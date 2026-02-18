/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d8045dbc17aa3ee.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_36fc02e86719d0f5;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_68cdf0ca5df5e;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_e857b038;

function init() {
  callback::on_spawned(&on_bot_spawned);
  level thread setupdevgui();
}

function on_bot_spawned() {
  player = getplayers()[0];

  if(self istestclient()) {
    origin = player.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 30);
    self setorigin(origin);
  }
}

function setupdevgui() {
  if(getdvarint(#"hash_dfb36b6ef77c4fe", 0) == 1) {
    level thread function_8f024d05();
  }

  if(getdvarint(#"hash_5b503e419423d065", 0) == 1) {
    level thread function_9ec06f93();
  }

  level waittill(#"doa_game_initialized");
  execdevgui("<dev string:x38>");
  function_61b604bf();
  level thread function_d379ba37();

  level.doa.var_598305fe = 0;
  level.doa.var_2e491399 = 0;
  level.doa.var_ca7d285b = 15;
  level.doa.var_dcb11150 = 0;

  if(getdvarint(#"hash_56a6b1d074ad2f5d", 0) == 1) {
    level.doa.var_2e491399 = 1;
    level thread function_507d29b2();
  }

  if(getdvarint(#"hash_63b27cb45671e35c", 0)) {
    level.var_e5d89122 = 0;

    if(getdvarint(#"hash_63b27cb45671e35c", 1) == 2) {
      level.var_e5d89122 = 1;
    }

    setDvar(#"hash_63b27cb45671e35c", 0);
    setDvar(#"hash_d874e4e73e9f18", 1);
    level thread function_8cac3f8c();
  }

  if(getdvarint(#"hash_883867e357a4688", 0)) {
    level thread function_8cac3f8c();
  }

  if(getdvarint(#"hash_d874e4e73e9f18", 0) && !is_true(level.var_a095060b)) {
    level thread function_1552e594();
  }
}

function function_d379ba37() {
  setDvar(#"zombie_devgui", "");
  setDvar(#"hash_116f154050454a80", "");
  setDvar(#"hash_58c5fb7998861ea3", "basic_zombie");
  setDvar(#"hash_4e8b5bae739da5a", "zombietron_lmg");
  setDvar(#"hash_1c923c83363c543b", "");
  setDvar(#"hash_6a3de42f6f3e6fd7", "");
  setDvar(#"hash_4cd093f275a4cf7d", "");
  setDvar(#"hash_2bdf0b4b3b54f5f9", "");
  setDvar(#"hash_442e0c29ec279820", "");
  setDvar(#"hash_5668d121a9e929c8", "");
  setDvar(#"hash_2d6ac7bedd2e2d8", "");

  while(true) {
    if(getdvarint(#"hash_d874e4e73e9f18", 0)) {
      if(!is_true(level.var_a095060b)) {
        level thread function_1552e594();
      }
    } else if(is_true(level.var_a095060b)) {
      level notify(#"hash_12d79bc0fed4ee5a");
    }

    cmd = getdvarstring(#"zombie_devgui");

    if(cmd == "") {
      wait 0.5;
      continue;
    }

    origin = namespace_7f5aeb59::function_23e1f90f()[0].origin;
    namespace_1e25ad94::debugmsg("Devgui Cmd-->" + cmd);

    switch (cmd) {
      case # "hash_5ed1696f28fe5666":
        if(!isDefined(level.doa.var_ade3e372)) {
          level.doa.var_ade3e372 = 0;
        }

        level.doa.var_ade3e372 = !level.doa.var_ade3e372;
        level thread function_ade3e372();
        break;
      case # "hash_5e0fc049ab86a8c0":
        level notify(#"round_over");
        level flag::set("arena_zero_rounds");
        level flag::clear("doa_round_spawning");
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        break;
      case # "hash_e172fdc803f50b":
        if(is_true(level.doa.var_c93506fb)) {
          level.doa.var_c93506fb = undefined;
          level notify(#"hash_39ebcccef3aa05c6");
          break;
        }

        level.doa.var_c93506fb = 1;
        idx = 0;
        level thread function_c93506fb();
      case # "dungeon":
        if(!isDefined(level.doa.var_39e3fa99)) {
          break;
        }

        if([[level.doa.var_39e3fa99]] - > getname() != "island") {
          namespace_1e25ad94::debugmsg("ROF cmd only works from island level");
          break;
        }

        level.doa.var_e15152e6 = "jungle_1";
        level.doa.var_baeb966b = 0;
        level notify(#"round_over");
        level flag::set("arena_zero_rounds");
        level flag::clear("doa_round_spawning");
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        level waittill(#"waiting_on_player_exit_decidechoice");
        wait 0.2;
        level notify(#"hash_45f77908e3043522", {
          #note: "enter_the_wild"});
        level waittilltimeout(3, #"hash_58caf0ade03043bb");
        wait 2;
        level doa_banner::function_7a0e5387();
        wait 1;

        if(!isDefined(idx)) {
          idx = namespace_981c1f3c::function_61e1a1cb(getdvarstring(#"hash_2d6ac7bedd2e2d8"));
        }

        dungeons = getEntArray("dungeon_generator", "targetname");

        if(!isDefined(idx) || idx == 0) {
          level.doa.var_8823e378 = dungeons[randomint(dungeons.size)].origin;
        } else {
          foreach(dungeon in dungeons) {
            if(dungeon.target === getdvarstring(#"hash_2d6ac7bedd2e2d8")) {
              level.doa.var_8823e378 = dungeon.origin;
              break;
            }
          }

          if(!isDefined(level.doa.var_8823e378)) {
            level.doa.var_8823e378 = dungeons[randomint(dungeons.size)].origin;
          }
        }

        foreach(player in getplayers()) {
          player setorigin(level.doa.var_8823e378);
        }

        break;
      case # "hash_596169604e05dd60":
        if(!isDefined(level.doa.var_39e3fa99)) {
          break;
        }

        if([[level.doa.var_39e3fa99]] - > getname() != "island") {
          namespace_1e25ad94::debugmsg("ROF cmd only works from island level");
          return;
        }

        level.doa.var_e15152e6 = "jungle_1";
        level.doa.var_baeb966b = 0;
        level notify(#"round_over");
        level flag::set("arena_zero_rounds");
        level flag::clear("doa_round_spawning");
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        level waittill(#"waiting_on_player_exit_decidechoice");
        wait 0.2;
        level notify(#"hash_45f77908e3043522", {
          #note: "enter_the_wild"});
        level waittilltimeout(3, #"hash_58caf0ade03043bb");
        level doa_banner::function_7a0e5387();
        var_6fdeb679 = getent("room_of_fate_shaft_trigger", "targetname").origin;

        foreach(player in getplayers()) {
          player setorigin(var_6fdeb679);
        }

        break;
      case # "hash_192ba0c0796a9ce8":
        var_28979c91 = array::randomize(level.doa.var_fe92efd8);
        i = 0;

        foreach(player in getplayers()) {
          fate = var_28979c91[i];
          i++;
          player thread namespace_1c2a96f9::function_15a789ab(fate.var_c8386627);
          wait 0.5;
        }

        break;
      case # "fate":
        player = namespace_7f5aeb59::function_23e1f90f()[0];
        var_c8386627 = int(getdvarstring(#"hash_116f154050454a80"));
        player thread namespace_1c2a96f9::function_15a789ab(var_c8386627);
        break;
      case # "bonusroom":
        level notify(#"round_over");
        level flag::clear("doa_round_spawning");
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        level.doa.var_848746c8 = getdvarstring(#"hash_2bdf0b4b3b54f5f9");
        namespace_1e25ad94::debugmsg("Bonus room being forced to: " + level.doa.var_848746c8);
        break;
      case # "bonusroomsoak":
        level.doa.var_848746c8 = getdvarstring(#"hash_2bdf0b4b3b54f5f9");
        namespace_1e25ad94::debugmsg("Bonus room soak being forced to: " + level.doa.var_848746c8);
        level thread namespace_5a917022::function_e5c7bce7();
        break;
      case # "enemy":
        if(!isDefined(level.doa.var_39e3fa99)) {
          break;
        }

        spot = [[level.doa.var_39e3fa99]] - > function_70fb5745().origin;
        ai = doa_enemy::function_4e8ae191(doa_enemy::function_d7c5adee(getdvarstring(#"hash_442e0c29ec279820")), 1, spot);

        if(isDefined(ai)) {
          ai notify(#"hash_737e3431bf19a6aa");
        }

        break;
      case # "corner":
        level thread function_43548cd2();
        break;
      case # "infinite_round":
        isset = getdvarint(#"hash_5c718b756a54aaba", 0);
        setDvar(#"hash_5c718b756a54aaba", isset ? 0 : 1);
        break;
      case # "hash_308e49e861ae4bf5":
        isset = getdvarint(#"hash_4c32f1957a11eb6b", 0);
        setDvar(#"hash_4c32f1957a11eb6b", isset ? 0 : 1);
        break;
      case # "fly":

        player = namespace_7f5aeb59::function_23e1f90f()[0];

        if(!is_true(player.doa.infps)) {
          player thread namespace_a4bedd45::function_1f704cee(1);
          adddebugcommand("<dev string:x54>");
          setsaveddvar(#"hash_7aa67f68d1a1b28d", 10);
          level doa_banner::function_7a0e5387();
          objective_setstate(10, "<dev string:x5e>");
          namespace_1e25ad94::function_8225da57();
        } else {
          player notify(#"hash_7893364bd228d63e", {
            #var_cff8d1e: 1
          });
          adddebugcommand("<dev string:x54>");
        }

        break;
      case # "arena_safety":
        foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
          player.doa.var_3cf36932 = !player.doa.var_3cf36932;
          namespace_1e25ad94::debugmsg("Arena Saftey for player (" + player.doa.color + ") is set to:" + (player.doa.var_3cf36932 ? "ON" : "OFF"));
        }

        break;
      case # "arena":
        level.doa.var_39459d49 = 0;
        level.doa.var_e5ef2ab4 = 0;
        arenaid = namespace_8c04284b::function_a7c5291d(getdvarstring(#"hash_4cd093f275a4cf7d"));
        level thread namespace_8c04284b::function_41e097fc(arenaid);
        break;
      case # "hash_348a45c1bc20d9b6":
        namespace_1e25ad94::function_4e3cfad("Forcing waveSpawner to CLASSIC");
        setDvar(#"hash_23f1ebb21fe023b", 1);
        level flag::clear("doa_round_spawning");
        level notify(#"round_over");
        namespace_1e25ad94::debugmsg("Killing all enemy AI");
        waitframe(1);
        level.doa.var_dcbded2 = [];
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        break;
      case # "hash_4d7f5258f341a427":
        namespace_1e25ad94::function_4e3cfad("Forcing waveSpawner to HERD");
        setDvar(#"hash_23f1ebb21fe023b", 2);
        level flag::clear("doa_round_spawning");
        level notify(#"round_over");
        namespace_1e25ad94::debugmsg("Killing all enemy AI");
        waitframe(1);
        level.doa.var_dcbded2 = [];
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        break;
      case # "hash_3e86f92f4dae558d":
        namespace_1e25ad94::function_4e3cfad("Forcing waveSpawner to GATEMASTER");
        setDvar(#"hash_23f1ebb21fe023b", 3);
        level flag::clear("doa_round_spawning");
        level notify(#"round_over");
        namespace_1e25ad94::debugmsg("Killing all enemy AI");
        waitframe(1);
        level.doa.var_dcbded2 = [];
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        break;
      case # "hash_48c1404bafded35f":
        namespace_1e25ad94::function_4e3cfad("Forcing waveSpawner to DEFAULT");
        setDvar(#"hash_23f1ebb21fe023b", 3);
        level flag::clear("doa_round_spawning");
        level notify(#"round_over");
        namespace_1e25ad94::debugmsg("Killing all enemy AI");
        waitframe(1);
        level.doa.var_dcbded2 = [];
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        break;
      case # "hash_c24d87a77941492":
        if(is_true(level.doa.var_b9615dfc)) {
          level notify(#"hash_1468ab65b8d72e27");
          level.doa.var_b9615dfc = 0;
        } else {
          level thread function_ec4525c8();
        }

        break;
      case # "itemstats":
        if(is_true(level.doa.var_3beef3ad)) {
          level notify(#"hash_5775b641c4a1dff6");
          level.doa.var_3beef3ad = 0;
        } else {
          level thread function_9ec06f93();
        }

        break;
      case # "hash_23c602341a3f0d8c":
        if((level.doa.var_ca7d285b & 1) != 0) {
          level.doa.var_ca7d285b &= ~1;
        } else {
          level.doa.var_ca7d285b |= 1;
        }

        break;
      case # "hash_23c603341a3f0f3f":
        if((level.doa.var_ca7d285b & 2) != 0) {
          level.doa.var_ca7d285b &= ~2;
        } else {
          level.doa.var_ca7d285b |= 2;
        }

        break;
      case # "hash_23c604341a3f10f2":
        if((level.doa.var_ca7d285b & 4) != 0) {
          level.doa.var_ca7d285b &= ~4;
        } else {
          level.doa.var_ca7d285b |= 4;
        }

        break;
      case # "hash_23c605341a3f12a5":
        if((level.doa.var_ca7d285b & 8) != 0) {
          level.doa.var_ca7d285b &= ~8;
        } else {
          level.doa.var_ca7d285b |= 8;
        }

        break;
      case # "roundstats":
        if(is_true(level.doa.var_c560430c)) {
          level notify(#"hash_32fcc4870af9184f");
          level.doa.var_c560430c = 0;
        } else {
          level thread function_8f024d05();
        }

        break;
      case # "hash_6e7ee6e6afe7033c":
        if(is_true(level.doa.var_c8add526)) {
          level notify(#"hash_58f1eda6545e88e3");
          level.doa.var_c8add526 = 0;
        } else {
          level thread function_e25eba77();
        }

        break;
      case # "wild":
        if(isDefined(level.doa.var_a77e6349)) {
          exit = [[level.doa.var_a77e6349]] - > function_5acbc98e();
          exit.trigger notify(#"trigger");
          level waittill(#"hash_325440d5433be263");
          level waittill(#"round_begin");
          wait 1;
        }

        cmd = getdvarstring(#"hash_5668d121a9e929c8");
        args = strtok(cmd, "@");
        level.doa.var_e15152e6 = args[0];
        level.doa.var_baeb966b = int(args[1]);
        level.doa.zombie_health = doa_wild::function_271e0d71(level.doa.var_e15152e6, level.doa.var_baeb966b);
        level notify(#"round_over");
        level flag::set("arena_zero_rounds");
        level flag::clear("doa_round_spawning");
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        break;
      case # "flip":
        namespace_8c04284b::function_a70ff03e(!level.doa.var_ecff3871);
        break;
      case # "hash_4ce30f9f2b25ddae":
        namespace_1e25ad94::function_8225da57();
        break;
      case # "hash_2a09add45a0410e7":
        namespace_1e25ad94::function_d88064ec();
        break;
      case # "weaponcharger":
        level.doa.var_11623c49 = 0;
        level.doa.var_a6cd0cb7 = 1;
        break;
      case # "hash_1c8448e57962fa34":
        level.doa.var_dcb11150 = !level.doa.var_dcb11150;
        break;
      case # "pickup":
        namespace_1e25ad94::debugmsg("spawning pickup " + getdvarstring(#"hash_116f154050454a80"));
        item = namespace_dfc652ee::function_6265bde4(getdvarstring(#"hash_116f154050454a80"));

        if(isDefined(item)) {
          if(isDefined(level.doa.var_39e3fa99)) {
            origin = [[level.doa.var_39e3fa99]] - > function_70fb5745(origin).origin;
          }

          if([[item]] - > gettype() == 13) {
            level namespace_dfc652ee::function_d06cbfe8(origin, 1, 256, undefined, item, 1);
          } else {
            level namespace_dfc652ee::function_83aea294(origin, 5, 256, item, undefined, 1);
          }
        }

        break;
      case # "pickup_pile":
        namespace_1e25ad94::debugmsg("Here is a bunch of stuff for you!");
        level namespace_dfc652ee::function_ad7ac41b(origin, 20, 256, 0, 1);
        break;
      case # "weapon_pile":
        namespace_1e25ad94::debugmsg("Weapon aresenal incomming!!");
        level namespace_dfc652ee::function_ad7ac41b(origin, 20, 256, 6, 1);
        break;
      case # "money":
        namespace_1e25ad94::debugmsg("big money, BIG PRIZES!");
        level namespace_dfc652ee::function_68442ee7(origin, 20, 256);
        level namespace_dfc652ee::function_68442ee7(origin, 20, 128, 1);
        break;
      case # "hash_340cf8f497c2fa9":
        namespace_1e25ad94::debugmsg("Max Score Multiplier!");

        foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
          player.doa.score.var_a928c52e = level.doa.var_88be0b68;
        }

        break;
      case # "gem":
        namespace_1e25ad94::debugmsg("Gems!");
        namespace_dfc652ee::function_d06cbfe8(origin, 20, 256);
        break;
      case # "gempop":
        namespace_1e25ad94::debugmsg("Gems Launching!");
        namespace_dfc652ee::function_d06cbfe8(origin, 1, 128, 1);
        break;
      case # "king":
        namespace_1e25ad94::debugmsg("Hail to the King baby!");

        foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
          player thread function_ddde8af6();
        }

        break;
      case # "hash_32f10e7eebda6ed5":
        level notify(#"hash_6b0c389ef8ac36b4");
        break;
      case # "kill":
        namespace_1e25ad94::debugmsg("death has been notified ...");
        players = namespace_7f5aeb59::function_23e1f90f();

        if(players.size == 1) {
          player = players[0];
        } else {
          player = players[randomint(players.size)];
        }

        player dodamage(player.health + 100, player.origin);
        break;
      case # "kill_all":
        namespace_1e25ad94::debugmsg("death to all...");
        players = namespace_7f5aeb59::function_23e1f90f();

        foreach(player in players) {
          player dodamage(player.health + 100, player.origin);
        }

        break;
      case # "hash_ca0bb68723c267c":
        namespace_1e25ad94::debugmsg("death to all bots...");
        players = namespace_7f5aeb59::function_23e1f90f();
        bots = [];
        var_c8dd979c = (0, 0, 0);
        targetplayer = players[randomint(players.size)];

        foreach(player in players) {
          if(player == targetplayer) {
            var_c8dd979c = player.origin + (0, 0, 20);
            player dodamage(player.health + 100, player.origin);
            continue;
          }

          bots[bots.size] = player;
        }

        foreach(bot in bots) {
          bot setorigin(var_c8dd979c);
        }

        break;
      case # "max_score":
        foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
          player.doa.score.var_1397c196 = 500000000;
          player.doa.score.var_96798a01 = player.doa.score.var_1397c196;
        }

        break;
      case # "debug_invul":
        level.doa.var_2e491399 = !level.doa.var_2e491399;

        if(level.doa.var_2e491399) {
          foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
            player thread namespace_7f5aeb59::function_19616199();
          }
        }

        break;
      case # "bonustimeoutdisabletoggle":
        namespace_5a917022::function_9da359eb();
        break;
      case # "hash_7fafc90102def2d4":
        level.doa.var_8f710e5d = 1;
        setDvar(#"hash_267a8e5d4aab4191", 1);
      case # "hash_10ad94be51c3eb8e":
        level flag::clear("doa_round_spawning");
        level notify(#"round_over");
        namespace_1e25ad94::debugmsg("Killing all enemy AI");
        waitframe(1);
        level.doa.var_dcbded2 = [];
        level thread function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        break;
      case # "hash_7fe8e0602be387d1":
        setDvar(#"hash_d874e4e73e9f18", getdvarint(#"hash_d874e4e73e9f18", 0) < 0 ? 1 : 0);
        break;
      case # "hash_2de1d3669fb18997":
        setDvar(#"hash_d874e4e73e9f18", 2);

        if(!isDefined(level.var_e5d89122)) {
          level.var_e5d89122 = 0;
        }

        level.var_e5d89122 = !level.var_e5d89122;
        break;
      case # "hash_5f8b768219110179":
        setDvar(#"hash_d874e4e73e9f18", 3);
        break;
      case # "hash_7d4010bf3a19e3a9":
        level thread function_c019882();
        break;
      case # "hash_157b8f006d6b5973":
        setDvar(#"hash_d874e4e73e9f18", 4);
        break;
      case # "hash_ea8a4f8c1fc16b7":
        setDvar(#"hash_d874e4e73e9f18", 5);
        break;
      case # "hash_5701d70855a0ab97":
        namespace_4dae815d::function_21cd3890(level.doa.world_state == 4 ? 0 : 4);
        break;
      case # "hash_733328256697a260":
        setDvar(#"hash_18f07d96e21f2083", 1);
      case # "gameover":
        players = namespace_7f5aeb59::function_23e1f90f();

        foreach(player in players) {
          player.doa.score.lives = 0;
          player dodamage(player.health + 100, player.origin);
        }

        break;
      case # "hash_74c80147d91d653e":
        level.doa.var_598305fe = !level.doa.var_598305fe;
        level thread function_598305fe();
        break;
      case # "hash_6f957c9ffba3bfe1":
        level.doa.roundnumber += 10;
        level.doa.var_f4cf4e3 = namespace_8c04284b::function_f15b9f04(level.doa.roundnumber);
        level.doa.zombie_health = namespace_8c04284b::function_962e9d92(level.doa.roundnumber);
        namespace_4dae815d::function_e22d3978(level.doa.roundnumber);
        namespace_1e25ad94::debugmsg("Round set to: " + level.doa.roundnumber);
        break;
      case # "hash_23b75207d8e015d4":
        level.doa.roundnumber -= 10;

        if(level.doa.roundnumber < 1) {
          level.doa.roundnumber = 1;
        }

        level.doa.var_f4cf4e3 = namespace_8c04284b::function_f15b9f04(level.doa.roundnumber);
        level.doa.zombie_health = namespace_8c04284b::function_962e9d92(level.doa.roundnumber);
        namespace_4dae815d::function_e22d3978(level.doa.roundnumber);
        namespace_1e25ad94::debugmsg("Round set to: " + level.doa.roundnumber);
        break;
      case # "dpsvictim":
        var_94f3b914 = getDvar(#"hash_58c5fb7998861ea3");
        break;
      case # "hash_609ef494db2ab837":
        player = getplayers()[0];
        level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4(getDvar(#"hash_4e8b5bae739da5a", "zombietron_lmg")), player.origin, undefined, undefined, 1, undefined, undefined, undefined, player);
        break;
    }

    setDvar(#"zombie_devgui", "");
    setDvar(#"hash_116f154050454a80", "");
  }
}

function function_c019882() {
  if(!isDefined(level.doa.var_c2bb00bb)) {
    level.doa.var_c2bb00bb = 0;
  }

  self notify("339823bf12b43f17");
  self endon("339823bf12b43f17");
  level.doa.var_c2bb00bb = !level.doa.var_c2bb00bb;

  if(!is_true(level.doa.var_c2bb00bb)) {
    return;
  }

  while(true) {
    foreach(player in getplayers()) {
      player.doa.var_640df11b = 1;
    }

    wait randomfloatrange(6, 14);
  }
}

function function_9ec06f93() {
  self notify("65cc86f4af8abd05");
  self endon("65cc86f4af8abd05");
  level endon(#"hash_5775b641c4a1dff6", #"game_over");
  level.doa.var_3beef3ad = 1;
  var_4df46b9b = 100;
  var_f956d12 = 200;
  level doa_banner::function_7a0e5387();
  itemdefs = [];

  foreach(def in level.doa.pickups.itemdefs) {
    def.var_88ce3439 = function_9e72a96([[def]] - > getname());

    if(!isDefined(itemdefs)) {
      itemdefs = [];
    } else if(!isarray(itemdefs)) {
      itemdefs = array(itemdefs);
    }

    itemdefs[itemdefs.size] = def;
  }

  while(true) {
    waitframe(1);
    x = var_4df46b9b;
    y = var_f956d12;
    namespace_1e25ad94::function_70e370a(x, y, "ITEM STATS", (1, 1, 1), 1, 2, 0.05);
    y += 40;
    var_914554bd = 0;

    foreach(def in level.doa.pickups.itemdefs) {
      other = 1;

      if([[def]] - > function_2c127eb5() == 999999) {
        continue;
      }

      if([[def]] - > gettype() == 1 || [[def]] - > gettype() == 2 || [[def]] - > gettype() == 13) {
        other = 0;

        if((level.doa.var_ca7d285b & 1) == 0) {
          continue;
        }
      }

      if([[def]] - > gettype() == 6) {
        other = 0;

        if((level.doa.var_ca7d285b & 2) == 0) {
          continue;
        }
      }

      if(namespace_dfc652ee::function_4821dfcf([[def]] - > gettype())) {
        other = 0;

        if((level.doa.var_ca7d285b & 4) == 0) {
          continue;
        }
      }

      if(other && (level.doa.var_ca7d285b & 8) == 0) {
        continue;
      }

      var_914554bd += namespace_dfc652ee::function_72e8509(def);
    }

    text = "ITEMS SPAWNED: " + var_914554bd + " ITEM MASK - MONEY(" + ((level.doa.var_ca7d285b & 1) != 0 ? "ON" : "OFF") + ")WEAPONS(" + ((level.doa.var_ca7d285b & 2) != 0 ? "ON" : "OFF") + ")VEHICLES(" + ((level.doa.var_ca7d285b & 4) != 0 ? "ON" : "OFF") + ")OHTER(" + ((level.doa.var_ca7d285b & 8) != 0 ? "ON" : "OFF") + ")";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1.3, 0.05);
    y += 30;

    if(var_914554bd == 0) {
      continue;
    }

    var_db7cb1ce = array::quick_sort(itemdefs, &function_2dbde8cf);
    counter = 1;
    common = 0;
    uncommon = 0;
    rare = 0;
    var_a5233b6b = 0;
    var_7303927e = 0;
    var_d50d5463 = 0;
    var_b9583f1e = 0;
    var_62f09029 = 0;
    var_96fbb36c = 0;
    var_c84dab5e = 0;

    for(idx = var_db7cb1ce.size - 1; idx >= 0; idx--) {
      other = 1;
      def = var_db7cb1ce[idx];

      if([[def]] - > function_2c127eb5() == 999999) {
        continue;
      }

      if([[def]] - > gettype() == 1 || [[def]] - > gettype() == 2 || [[def]] - > gettype() == 13) {
        other = 0;

        if((level.doa.var_ca7d285b & 1) == 0) {
          continue;
        }
      }

      if([[def]] - > gettype() == 6) {
        other = 0;

        if((level.doa.var_ca7d285b & 2) == 0) {
          continue;
        }
      }

      if(namespace_dfc652ee::function_4821dfcf([[def]] - > gettype())) {
        other = 0;

        if((level.doa.var_ca7d285b & 4) == 0) {
          continue;
        }
      }

      if(other && (level.doa.var_ca7d285b & 8) == 0) {
        continue;
      }

      switch ([[def]] - > getrarity()) {
        case 0:
          common++;
          var_d50d5463 += [[def]] - > function_b3131904();
          color = (1, 1, 1);
          break;
        case 1:
          uncommon++;
          var_b9583f1e += [[def]] - > function_b3131904();
          color = (0, 1, 0);
          break;
        case 2:
          rare++;
          var_62f09029 += [[def]] - > function_b3131904();
          color = (0, 1, 1);
          break;
        case 3:
          var_a5233b6b++;
          var_96fbb36c += [[def]] - > function_b3131904();
          color = (1, 1, 0);
          break;
        case 4:
          var_7303927e++;
          var_c84dab5e += [[def]] - > function_b3131904();
          color = (1, 0, 1);
          break;
      }

      text = "" + def.var_88ce3439 + " count: " + [[def]] - > function_b3131904();

      if(var_914554bd > 0) {
        var_d905e426 = " [ " + int([[def]] - > function_b3131904() / var_914554bd * 100 + 0.5) + " % ]";
      }

      namespace_1e25ad94::function_70e370a(x, y, "" + counter + ". ", (1, 1, 1), 1, 1, 0.05);
      namespace_1e25ad94::function_70e370a(x + 50, y, text, (1, 1, 1), 1, 1, 0.05);
      namespace_1e25ad94::function_70e370a(x + 500, y, var_d905e426, color, 1, 1, 0.05);
      counter++;
      y += 20;

      if(y >= 1020) {
        y = var_f956d12 + 70;
        x += 770;
      }
    }

    x = 800;
    y = 50;
    namespace_1e25ad94::function_70e370a(x, y, "ITEM GROUPS", (1, 1, 1), 1, 1, 0.05);
    y += 30;
    namespace_1e25ad94::function_70e370a(x, y, "COMMON (" + common + ")", (1, 1, 1), 1, 1, 0.05);
    namespace_1e25ad94::function_70e370a(x + 200, y, "COUNT: " + var_d50d5463 + " [ " + int(var_d50d5463 / var_914554bd * 100 + 0.5) + " % ]", (1, 1, 1), 1, 1, 0.05);
    y += 20;
    namespace_1e25ad94::function_70e370a(x, y, "UNCOMMON (" + uncommon + ")", (0, 1, 0), 1, 1, 0.05);
    namespace_1e25ad94::function_70e370a(x + 200, y, "COUNT: " + var_b9583f1e + " [ " + int(var_b9583f1e / var_914554bd * 100 + 0.5) + " % ]", (0, 1, 0), 1, 1, 0.05);
    y += 20;
    namespace_1e25ad94::function_70e370a(x, y, "RARE (" + rare + ")", (0, 1, 1), 1, 1, 0.05);
    namespace_1e25ad94::function_70e370a(x + 200, y, "COUNT: " + var_62f09029 + " [ " + int(var_62f09029 / var_914554bd * 100 + 0.5) + " % ]", (0, 1, 1), 1, 1, 0.05);
    y += 20;
    namespace_1e25ad94::function_70e370a(x, y, "ULTRA RARE (" + var_a5233b6b + ")", (1, 1, 0), 1, 1, 0.05);
    namespace_1e25ad94::function_70e370a(x + 200, y, "COUNT: " + var_96fbb36c + " [ " + int(var_96fbb36c / var_914554bd * 100 + 0.5) + " % ]", (1, 1, 0), 1, 1, 0.05);
    y += 20;
    namespace_1e25ad94::function_70e370a(x, y, "EPIC (" + var_7303927e + ")", (1, 0, 1), 1, 1, 0.05);
    namespace_1e25ad94::function_70e370a(x + 200, y, "COUNT: " + var_c84dab5e + " [ " + int(var_c84dab5e / var_914554bd * 100 + 0.5) + " % ]", (1, 0, 1), 1, 1, 0.05);
    y += 20;
  }
}

function function_2dbde8cf(a, b) {
  return [[a]] - > function_b3131904() < [[b]] - > function_b3131904();
}

function function_ec4525c8() {
  self notify("18b3bd30d8aff38c");
  self endon("18b3bd30d8aff38c");
  level endon(#"hash_1468ab65b8d72e27", #"game_over");
  level.doa.var_b9615dfc = 1;
  var_4df46b9b = 100;
  var_f956d12 = 200;
  level doa_banner::function_7a0e5387();

  foreach(room in level.doa.var_8f6ccf63) {
    room.var_d52d06ee = 0;
  }

  while(true) {
    waitframe(1);
    x = var_4df46b9b;
    y = var_f956d12;
    namespace_1e25ad94::function_70e370a(x, y, "BONUS ROOM STATS", (1, 1, 1), 1, 2, 0.05);
    y += 40;
    text = "BONUS ROOMS SPAWNED: " + level.doa.var_ffb709d8 + "LAST ROUND: " + level.doa.var_f8e35dd0;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    randrange = math::clamp(100 - (level.doa.roundnumber - level.doa.var_f8e35dd0) * 6 - level.doa.var_a5ade8f8, 15, 100);
    text = "BONUS RNG RANGE: " + randrange + "ROUND FAVOR:" + level.doa.var_a5ade8f8 + "LAST ROLL: " + level.doa.var_ae635e19;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "ROUND: " + level.doa.roundnumber + "RATIO: " + int(level.doa.var_ffb709d8 / level.doa.roundnumber * 100 + 0.5) + "%";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1.3, 0.05);
    y += 40;
    text = "ROOMS: " + level.doa.var_8f6ccf63.size;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1.3, 0.05);
    y += 30;

    foreach(room in level.doa.var_8f6ccf63) {
      color = (1, 1, 1);

      if(room === level.doa.var_6ab50f27) {
        color = (1, 1, 0);
      }

      namespace_1e25ad94::function_70e370a(x, y, room.name, color, 1, 1, 0.05);
      text = "TIMES SEEN: " + room.var_6959a8a9;
      namespace_1e25ad94::function_70e370a(x + 280, y, text, color, 1, 1, 0.05);

      if(level.doa.var_ffb709d8 > 0) {
        text = "(" + int(room.var_6959a8a9 / level.doa.var_ffb709d8 * 100 + 0.5) + "%)";
        namespace_1e25ad94::function_70e370a(x + 460, y, text, color, 1, 1, 0.05);
      }

      duration = gettime() - room.var_5bbf26b8;
      timetext = function_71719130(duration);
      text = "LAST SEEN: " + timetext + "COOLDOWN: " + (room.var_a702483f != 9999999 ? room.var_a702483f : "Infinite");
      namespace_1e25ad94::function_70e370a(x + 550, y, text, color, 1, 1, 0.05);
      y += 20;
    }
  }
}

function function_e25eba77() {
  self notify("7a49d9e77ae9cf35");
  self endon("7a49d9e77ae9cf35");
  level endon(#"hash_58f1eda6545e88e3", #"game_over");
  level.doa.var_c8add526 = 1;
  var_4df46b9b = 100;
  var_f956d12 = 500;

  while(level.doa.var_c8add526) {
    waitframe(1);

    if(namespace_4dae815d::function_59a9cf1d() < 4) {
      continue;
    }

    x = var_4df46b9b;
    y = var_f956d12;
    namespace_1e25ad94::function_70e370a(x, y, "WILD STATS", (1, 1, 1), 1, 2, 0.05);
    y += 40;

    if(isDefined(level.doa.var_fc8d8951)) {
      duration = gettime() - level.doa.var_fc8d8951;
    } else {
      return;
    }

    timetext = function_71719130(duration);
    text = "WILD DURATION: " + timetext;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "TOTAL GENERATORS: " + level.doa.var_8acd67ef.size;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "GENERATORS DESTROYED: " + level.doa.var_148272df;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "DUNGEONS EXPLORED: " + level.doa.var_dfe4682;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "BOSSES KILLED: " + level.doa.var_be3ad33f;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    count = 0;

    foreach(item in level.doa.var_b8ef1466) {
      if(isDefined(item.script_model)) {
        count++;
      }
    }

    text = "WORLD ACTIVATES: " + level.doa.var_b8ef1466.size + " ACTIVE WITH MODELS: " + count;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    count = 0;

    foreach(item in level.doa.var_c793b1bb) {
      if(isDefined(item.script_model)) {
        count++;
      }
    }

    text = "WORLD ACTIVATED: " + level.doa.var_c793b1bb.size + " MODELS ALIVE: " + count;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    timetext = gettime();
    text = "GAME TIME: " + timetext;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    timetext = function_71719130(gettime() - level.doa.gamestarttime);
    text = "GAME DURATION: " + timetext;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "TOTAL PLAYER DEATHS: " + level.doa.var_bcc1fc05;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(isDefined(player.doa.color)) {
        y += 20;
        text = "PLAYER (" + player.doa.color + ") TARGETED BY " + player.doa.var_ab338943 + " BASIC AI" + (is_true(player.laststand) ? " (laststand)" : "");
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      }
    }

    y += 40;
    text = "PLAYER PELTS";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(isDefined(player.doa.color)) {
        y += 20;
        text = "PLAYER (" + player.doa.color + ") PELTMASK: ";

        for(i = level.doa.var_4eb7c3f0 - 1; i >= 0; i--) {
          typemask = 1 << i;
          set = player.doa.var_f240d1a5 &typemask;
          text += set ? "1" : "0";
        }

        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      }
    }

    y += 40;
    text = "PLAYER GRIND";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(isDefined(player.doa.color)) {
        y += 20;
        var_3c414369 = player.doa.var_370ac26d - player.doa.var_1f5b5d6b;
        text = "PLAYER (" + player.doa.color + ")WILD XP_GAIN: " + var_3c414369 + " TOT XP_GAIN: " + player.doa.var_370ac26d + " GRIND CURRENCY: " + player.doa.var_3b5fa231 + " UNCOMMITTED GRIND CURRENCY: " + player.doa.var_d362196a;
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
        y += 20;
        var_d69e87f7 = var_3c414369 / duration / 60000;
        text = "PLAYER (" + player.doa.color + ")WILD_XP PER MINUTE: " + var_d69e87f7;
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      }
    }
  }
}

function function_8f024d05() {
  self notify("3dd9cc60ad163266");
  self endon("3dd9cc60ad163266");
  level endon(#"hash_32fcc4870af9184f", #"game_over");
  level.doa.var_c560430c = 1;
  var_bc153d9a = getdvarint(#"hash_5cc1c07efe048c56", 300);
  var_af82a000 = var_bc153d9a - 30;
  var_4df46b9b = 100;
  var_f956d12 = 150;

  while(true) {
    waitframe(1);

    if(!isDefined(level.doa.roundstarttime)) {
      continue;
    }

    if(namespace_4dae815d::function_59a9cf1d() != 0) {
      continue;
    }

    x = var_4df46b9b;
    y = var_f956d12;
    namespace_1e25ad94::function_70e370a(x, y, "ROUND " + level.doa.roundnumber + " STATS", (1, 1, 1), 1, 2, 0.05);
    y += 40;

    if(is_true(level.doa.challengeactive)) {
      text = "CHALLENGE ROUND ACTIVE";

      if(level flag::get("challenge_round_spawnOverride")) {
        text += " [Challenge logic is controlling spawning]";
      }

      namespace_1e25ad94::function_70e370a(x, y, text, (1, 0.5, 0), 1, 1, 0.05);
      y += 20;
    }

    var_acfdd742 = "(CLASSIC DOA)";

    if(level.doa.var_6a0340ad === 2) {
      var_acfdd742 = "(HERD)";
    }

    if(level.doa.var_6a0340ad === 3) {
      var_acfdd742 = "(GATEMASTER)";
    }

    text = "WAVE SYSTEM " + var_acfdd742;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1.3, 0.05);
    y += 30;

    if(level flag::get("doa_round_spawning")) {
      text = "Round: SPAWNING";
      namespace_1e25ad94::function_70e370a(x, y, text, (0, 1, 0), 1, 1.3, 0.05);
    } else {
      text = "Round: NOT SPAWNING";
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1.3, 0.05);
    }

    y += 30;

    if(level.doa.var_f66b524a !== 0) {
      duration = level.doa.var_f66b524a;
    } else {
      duration = gettime() - level.doa.roundstarttime;
    }

    timetext = function_71719130(duration);
    text = "DURATION: " + timetext;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;

    if(isDefined(level.doa.var_a8834e17)) {
      text = "MIN ROUND DURATION: " + level.doa.var_a8834e17 / 1000 + " seconds";
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
    }

    if(level.doa.var_6a0340ad != 3) {
      text = "WAVES REMAINING: " + level.doa.var_aa7fba18;
    } else {
      remaining = float(level.doa.var_8f91d36b - gettime()) / 1000;

      if(remaining < 0) {
        remaining = 0;
      }

      text = "TIME REMAINING: " + int(remaining);
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;

      if(level.doa.var_654a3ea9 > 0) {
        text = "OVERTIME: " + level.doa.var_654a3ea9;
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 0, 0), 1, 1, 0.05);
        y += 20;
      }

      text = "GATES OPEN: ";
      var_8c2908e3 = namespace_8c04284b::function_53678480();

      foreach(gate in var_8c2908e3) {
        text = text + gate + " ";
      }
    }

    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;

    if(level.doa.var_6a0340ad == 2) {
      text = "QUEUE SPAWN ENTRIES: " + level.doa.var_dcbded2.size + " AI SPAWN EXPIRED: " + level.doa.var_2b4e2465;
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
    }

    text = "AI SPAWNED: " + level.doa.var_9fcf26ea;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;

    if(isDefined(level.doa.var_3ed31a82) && level.doa.var_3ed31a82 >= 0) {
      text = "AI LEFT TO SPAWN: " + level.doa.var_3ed31a82;
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
    }

    if(level.doa.var_9fcf26ea > 0) {
      text = "NON BASIC AI SPAWNED: " + level.doa.var_5de71250 + " Ratio: " + level.doa.var_5de71250 / level.doa.var_9fcf26ea * 100 + "%";
    } else {
      text = "NON BASIC AI SPAWNED: " + level.doa.var_5de71250;
    }

    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "BASE AI HEALTH: " + level.doa.zombie_health + " BASE AI SPEED: " + level.doa.var_f4cf4e3;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;

    if(isDefined(level.doa.var_39e3fa99)) {
      text = "MAX AI ALLOWED: " + [[level.doa.var_39e3fa99]] - > function_c892290a() + " CUR ALIVE: " + namespace_ec06fe4a::function_38de0ce8();
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
    }

    text = "AI SPAWN CAPPED: " + level.doa.var_cde5274e + " AI SPAWN FAILS: " + level.doa.var_de939ab7;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "ROUND PLAYER DEATHS: " + level.doa.var_465867b;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 40;
    timetext = gettime();
    text = "GAME TIME: " + timetext;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    timetext = function_71719130(gettime() - level.doa.gamestarttime);
    text = "GAME DURATION: " + timetext;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "TOTAL PLAYER DEATHS: " + level.doa.var_bcc1fc05;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(isDefined(player.doa.color)) {
        y += 20;
        text = "PLAYER (" + player.doa.color + ") TARGETED BY " + player.doa.var_ab338943 + " BASIC AI" + (is_true(player.laststand) ? " (laststand)" : "");
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      }
    }

    y += 40;
    text = "PLAYER PELTS";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(isDefined(player.doa.color)) {
        y += 20;
        text = "PLAYER (" + player.doa.color + ") PELTMASK: ";

        for(i = level.doa.var_4eb7c3f0 - 1; i >= 0; i--) {
          typemask = 1 << i;
          set = player.doa.var_f240d1a5 &typemask;
          text += set ? "1" : "0";
        }

        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      }
    }

    y += 40;
    text = "PLAYER GRIND";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(isDefined(player.doa.color)) {
        y += 20;
        text = "PLAYER (" + player.doa.color + ")XP_GAIN: " + player.doa.var_370ac26d + " GRIND CURRENCY: " + player.doa.var_3b5fa231 + " UNCOMMITTED GRIND CURRENCY: " + player.doa.var_d362196a;
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      }
    }

    y += 40;
    text = "PLAYER ACTIVITY";
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      if(!isDefined(player.doa.var_87c1cd32)) {
        player.doa.var_87c1cd32 = 0;
      }

      if(isDefined(player.doa.color)) {
        y += 20;
        var_d6b582ba = isDefined(player.doa.var_8f47d882) ? player.doa.var_8f47d882 : 0;
        text = "PLAYER (" + player.doa.color + ")ROUND PARTICIPATION: " + player.doa.var_87c1cd32 + "[ " + int(player.doa.var_87c1cd32 / level.doa.roundnumber * 100) + "%] STARTED ON ROUND: " + (isDefined(player.var_248bd83) ? player.var_248bd83 : 0) + " INACTIVITY COUNTER: " + var_d6b582ba + "/" + var_bc153d9a + " LStickCount:" + player.doa.var_43c43abc + " RStickCount:" + player.doa.var_7f8d38c2 + " StickIdleCounter: " + (isDefined(player.doa.var_e940d370) ? player.doa.var_e940d370 : 0);
        color = (1, 1, 1);

        if(var_d6b582ba >= var_af82a000) {
          color = (1, 0, 0);
        }

        namespace_1e25ad94::function_70e370a(x, y, text, color, 1, 1, 0.05);
      }
    }
  }
}

function function_71719130(totaldurationms) {
  if(!isDefined(totaldurationms)) {
    return;
  }

  duration = int(float(totaldurationms) / 1000);
  hours = int(duration / 3600);
  duration -= hours * 3600;
  minutes = int(duration / 60);
  duration -= minutes * 60;
  seconds = duration;
  text = "" + hours + ":" + (minutes > 10 ? "" : "0") + minutes + ":" + (seconds > 10 ? "" : "0") + seconds;
  return text;
}

function function_1a837918() {
  self notify("1c7aa15164b64a05");
  self endon("1c7aa15164b64a05");
  level endon(#"hash_39ebcccef3aa05c6", #"game_over");

  while(true) {
    x = 800;
    y = 300;
    namespace_1e25ad94::function_70e370a(x, y, "DUNGEON STATISTICS", (1, 1, 1), 1, 2, 0.05);
    y += 40;

    if(isDefined(level.doa.var_fa21a3aa) && level.doa.var_fa21a3aa > 0) {
      text = "Total Builds: " + level.doa.var_f33bb10;
      namespace_1e25ad94::function_70e370a(x, y, text, (0.439216, 0.501961, 0.564706), 1, 1, 0.05);
      y += 20;
      text = "Total Tiles:" + level.doa.var_fa21a3aa + "\tAvg Tile Count:" + level.doa.var_fa21a3aa / level.doa.var_f33bb10;
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
      text = "Total Rooms:" + level.doa.var_f5f2b4e8 + "\tAvg Room Count:" + level.doa.var_f5f2b4e8 / level.doa.var_f33bb10;
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
      text = "Total Halls:" + level.doa.var_f23e2931 + "\tAvg Hall Count:" + level.doa.var_f23e2931 / level.doa.var_f33bb10;
      namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
      y += 20;
      text = "PT = percentage of tiles";
      namespace_1e25ad94::function_70e370a(x, y, text, (0.5, 0.5, 0.5), 1, 1, 0.05);
      y += 20;
      text = "PB = percentage of builds";
      namespace_1e25ad94::function_70e370a(x, y, text, (0.5, 0.5, 0.5), 1, 1, 0.05);
      y += 30;

      foreach(tileid in level.doa.var_830f8412) {
        tile = {
          #name: tileid, #count: level.doa.var_4cdaff39[tileid]
        };

        if(tile.count == 0) {
          continue;
        }

        text = tile.name + "\tinstance count: " + tile.count + "\tPT: " + tile.count / level.doa.var_fa21a3aa * 100 + "%" + "\tPB: " + tile.count / level.doa.var_f33bb10 * 100 + "%";
        namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
        y += 20;
      }
    }

    waitframe(1);
  }
}

function function_c93506fb() {
  self notify("117dff878bc6e65e");
  self endon("117dff878bc6e65e");
  level endon(#"hash_39ebcccef3aa05c6", #"game_over");
  level.doa.var_f33bb10 = 1;
  self thread function_1a837918();

  while(true) {
    namespace_1e25ad94::function_4e3cfad("Dungeon Evolution: " + level.doa.var_f33bb10 + " started at:" + gettime(), undefined, undefined, undefined, 10);
    namespace_1e25ad94::debugmsg("###DungeonMasterSupreme Cycle:" + level.doa.var_f33bb10);

    while(!level flag::get("dungeon_building")) {
      waitframe(1);
    }

    while(level flag::get("dungeon_building")) {
      waitframe(1);
    }

    wait 1;
    level notify(#"ladder_up");
    level waittilltimeout(30, #"hash_df3bb53ea54541f");
    wait 2;
    namespace_1e25ad94::function_4e3cfad("\tDungeon Evolution: " + level.doa.var_f33bb10 + " completed at:" + gettime(), undefined, undefined, undefined, 60);

    foreach(player in getplayers()) {
      player setorigin(level.doa.var_8823e378);
    }

    level.doa.var_f33bb10++;
  }
}

function function_507d29b2() {
  while(namespace_7f5aeb59::function_23e1f90f().size == 0) {
    waitframe(1);
  }

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    player thread namespace_7f5aeb59::function_19616199();
  }
}

function function_8cac3f8c() {
  while(namespace_7f5aeb59::function_23e1f90f().size == 0) {
    waitframe(1);
  }

  namespace_1e25ad94::debugmsg("Hail to the King baby!");

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    player thread function_ddde8af6(1);
  }
}

function function_de70888a() {
  level.doa.var_3ec3c9aa = 1;
  namespace_ec06fe4a::function_de70888a();
}

function function_ddde8af6(delay = 0.1) {
  self notify("213d301a5d2a55a2");
  self endon("213d301a5d2a55a2");
  self endon(#"disconnect");
  level endon(#"hash_6b0c389ef8ac36b4", #"game_over");
  wait delay;

  while(true) {
    if(randomint(100) < getdvarint(#"hash_448d3a6683251780", 100)) {
      if(getdvarint(#"hash_58b45fb8267a06a", 1)) {
        if(self.doa.score.lives <= 3) {
          self.doa.score.lives = 9;
        }
      }

      if(getdvarint(#"hash_7aecb0e8e1c66d5e", 1)) {
        if(self.doa.score.bombs <= 1) {
          self.doa.score.bombs = 9;
        }
      }
    } else {
      wait 30;
    }

    if(self.doa.score.boosts <= 1) {
      self.doa.score.boosts = 9;
    }

    wait 1;
  }
}

function function_6d6477c9(name, section) {
  if(getdvarint(#"hash_241a904769d26d2c", 0)) {
    return {
      #time: 5, #xp: 0
    };
  }

  if(name === "jungle_1") {
    switch (section) {
      case 0:
        return {
          #time: 480, #xp: 3000
        };
      case 1:
        return {
          #time: 1200, #xp: 5000
        };
      case 2:
        return {
          #time: 600, #xp: 3000
        };
      case 3:
        return {
          #time: 900, #xp: 3000
        };
    }
  }
}

function function_1552e594() {
  self notify("6841cfcb2365b57b");
  self endon("6841cfcb2365b57b");
  level endon(#"hash_12d79bc0fed4ee5a", #"game_over");
  level.botcount = 0;
  level thread function_db3aef8f();
  level.var_a095060b = 1;
  level.var_96f7e84e = 1;
  setDvar(#"hash_2167ce61af5dc0b0", 0);

  while(true) {
    waitframe(1);
    guys = namespace_7f5aeb59::function_23e1f90f();

    if(guys.size == 0) {
      continue;
    }

    foreach(guy in guys) {
      guy.doa.var_11abc438 = guy.origin + (0, 0, 34);
    }

    break;
  }

  while(!isDefined(level.doa.var_39e3fa99)) {
    waitframe(1);
  }

  namespace_1e25ad94::debugmsg("DOA Soak Test [ON]");
  level thread function_b255a702();
  level thread function_e5266c17();

  while(is_true(level.var_a095060b)) {
    if(level flag::get("doa_game_is_over")) {
      break;
    }

    guys = namespace_7f5aeb59::function_23e1f90f();

    if(isDefined(level.doa.var_39e3fa99)) {
      var_271662e8 = [[level.doa.var_39e3fa99]] - > function_dfb49846();

      if(var_271662e8.size) {
        exit = var_271662e8[randomint(var_271662e8.size)];
        exit notify(#"trigger", {
          #activator: guys[randomint(guys.size)]
        });
      }
    }

    if(isDefined(level.doa.var_9ae7e5e6)) {
      guys[0] setorigin(level.doa.var_9ae7e5e6.origin + (0, 0, 32));
      result = level waittill(#"hash_5c97c4241ba01be4");
      name = [[level.doa.var_a77e6349]] - > getname();
      section = [[level.doa.var_a77e6349]] - > function_7c246362();
      estimate = function_6d6477c9(name, section.id);

      if(isDefined(estimate)) {
        foreach(guy in guys) {
          if(!isDefined(guy)) {
            continue;
          }

          guy.doa.var_d524abd8 = 0;
        }

        level thread namespace_6e90e490::function_c937e51f(estimate.time);
        result = level waittilltimeout(estimate.time, #"hash_7626a6770055d63c");
        level thread namespace_6e90e490::function_fa6f7ba7();

        if(result._notify == # "timeout") {
          while(isDefined(level.doa.var_6f3d327) || isDefined(level.doa.var_182fb75a)) {
            wait 1;
          }

          if(isDefined(level.doa.var_a77e6349)) {
            if(name === "jungle_1" && section.id === 2) {
              loc = getent("room_of_fate_shaft_trigger", "targetname").origin;
              guys = namespace_7f5aeb59::function_23e1f90f();
              guys[0] setorigin(loc + (0, 0, 32));
            } else {
              [[level.doa.var_a77e6349]] - > function_411b63ca();
            }
          }

          namespace_7f5aeb59::function_f8645db3(estimate.xp);
        }
      }
    } else if(isDefined(level.doa.teleporter) && randomint(5) == 0) {
      guys[0] setorigin(level.doa.teleporter.origin + (0, 0, 32));
    }

    if(level flag::get("doa_round_spawning")) {
      if(is_true(level.var_e5d89122)) {
        wait randomfloatrange(0.2, 0.6);
      } else {
        wait randomintrange(2, 6);
      }
    } else {
      waitframe(1);
      continue;
    }

    foreach(guy in guys) {
      if(!isDefined(guy)) {
        continue;
      }

      if(isDefined(level.doa.teleporter) && randomint(100) > 97) {
        guy setorigin(level.doa.teleporter.origin + (0, 0, 24));
      }

      guy thread function_be602f7c();

      if(guy isinmovemode("ufo", "noclip")) {
        wait 0.4;
        continue;
      }

      roll = randomint(100);

      if(roll > 90) {
        guy setplayerangles((0, randomint(360), 0));
        guy.doa.var_d524abd8 = 1;
        namespace_1e25ad94::debugmsg("Bot is boosting.Boosts Left:" + guy.doa.score.boosts);
      }

      if(roll == 0) {
        guy.doa.var_640df11b = 1;
        namespace_1e25ad94::debugmsg("Bot is dropping nuke.Bombs Left:" + guy.doa.score.bombs);
      }
    }

    if(level.botcount > 0 && randomint(100) > 70) {
      bot::remove_random_bot();
      level.botcount--;
      namespace_1e25ad94::debugmsg("Bot is being removed. Count=" + level.botcount);
      continue;
    }

    if(getdvarint(#"hash_d874e4e73e9f18", 0) != 5 && getdvarint(#"hash_4a0c2338e71a658e", 1) && getplayers().size < 4 && randomint(100) < 30) {
      bot = bot::add_bot(#"allies", function_a161addf(), "DOA");

      if(isDefined(bot) && level.doa.world_state == 0 && isDefined(level.doa.var_39e3fa99)) {
        bot.var_bbc4df09 = 1;
        spot = [[level.doa.var_39e3fa99]] - > function_fc81ec00(bot getentitynumber());
        bot setorigin(spot.origin);
        bot setplayerangles(spot.angles);
        level.botcount++;
        namespace_1e25ad94::debugmsg("Bot is being added.Count=" + level.botcount);
        waitframe(1);
        continue;
      }

      bot::remove_bot(bot);
    }
  }

  level notify(#"hash_12d79bc0fed4ee5a");
}

function function_b255a702() {
  level endon(#"hash_12d79bc0fed4ee5a");

  while(true) {
    arena = getDvar(#"skipto_jump", "");

    if(arena != "") {
      setDvar(#"skipto_jump", "");
      arena = int(arena);

      if(arena < 0 || arena >= level.doa.arenas.size) {
        arena = 0;
      }

      level thread namespace_8c04284b::function_41e097fc(arena);
    }

    waitframe(1);
  }
}

function function_a161addf() {
  colors = array("green", "blue", "red", "yellow");
  used = [];
  guys = namespace_7f5aeb59::function_23e1f90f();

  foreach(guy in guys) {
    used[used.size] = guy.doa.color;
  }

  valid = array::exclude(colors, used);
  return "TEST MONKEY (" + valid[0] + ")";
}

function function_b4d99705() {
  self notify("66d82101958cab69");
  self endon("66d82101958cab69");
  level endon(#"hash_12d79bc0fed4ee5a");
  wait randomintrange(30, 180);

  if(level.doa.world_state == 4) {
    guys = namespace_7f5aeb59::function_23e1f90f();

    foreach(guy in guys) {
      guy setorigin(guy.doa.var_11abc438);
      guy.doa.var_4f3aee7b = 0;
      namespace_1e25ad94::debugmsg("Sending " + guy.name + " back to home:" + guy.doa.var_11abc438);
    }
  }

  level.doa.var_a7fad318 = undefined;

  if(isDefined(level.doa.var_182fb75a)) {
    namespace_981c1f3c::function_8790b64a();
  }

  level thread function_b4d99705();
}

function function_be602f7c() {
  self endon(#"disconnect");
  self notify("61f927fc66bc126b");
  self endon("61f927fc66bc126b");
  level endon(#"hash_12d79bc0fed4ee5a");

  if(randomint(100) > 70) {
    self notify(#"hash_279998c5df86c04d");
  }

  if(randomint(100) > 80) {
    self notify(#"hash_7893364bd228d63e");
  }

  while(isDefined(self)) {
    if(self isinmovemode("ufo", "noclip") || isDefined(level.doa.var_a77e6349)) {
      self.doa.var_d524abd8 = 0;
      wait 1;
      continue;
    }

    if(randomint(100) > 50) {
      var_9cf94ae9 = undefined;
      var_d94778ea = getEntArray("a_pickup_item", "script_noteworthy");

      foreach(item in var_d94778ea) {
        if([[item.def]] - > gettype() === 15) {
          var_9cf94ae9 = item;
        }
      }

      if(var_d94778ea.size > 0 && !isDefined(var_9cf94ae9)) {
        var_9cf94ae9 = var_d94778ea[randomint(var_d94778ea.size)];
      }

      if(isDefined(var_9cf94ae9)) {
        self function_a4037f83(var_9cf94ae9);
      }
    } else {
      for(var_b779ea9b = randomint(6); var_b779ea9b; var_b779ea9b--) {
        if(self isinmovemode("ufo", "noclip")) {
          break;
        }

        self.doa.var_d524abd8 = 1;
        angles = (0, randomint(360), 0);
        self setplayerangles(angles);
        wait 0.5;
      }
    }

    wait randomint(10);
  }
}

function function_a4037f83(pickup) {
  self endon(#"disconnect");
  pickup endon(#"death");
  level endon(#"hash_7270a59e1f502d96");
  wait randomfloatrange(0.1, 1);

  if(self isinmovemode("ufo", "noclip") || isDefined(level.doa.var_a77e6349)) {
    return;
  }

  level thread namespace_1e25ad94::debugcircle(pickup.origin + (0, 0, 20), 30, 3, self namespace_7f5aeb59::function_5934bbc8());
  level thread namespace_1e25ad94::debugline(self.origin + (0, 0, 20), pickup.origin + (0, 0, 20), 3, self namespace_7f5aeb59::function_5934bbc8());
  tries = 5;

  while(isDefined(pickup) && tries) {
    tries--;

    if(self isinmovemode("ufo", "noclip") || isDefined(level.doa.var_a77e6349)) {
      return;
    }

    if(self.doa.score.boosts == 0 && randomint(500) == 0) {
      self.doa.score.boosts = 2;
    }

    yaw = self namespace_ec06fe4a::getyaw2d(pickup.origin);
    angles = (0, yaw, 0);
    self setplayerangles(angles);
    self.doa.var_d524abd8 = 1;
    namespace_1e25ad94::debugmsg("Bot is boosting at pickup:" + [[pickup.def]] - > getname() + ".Boosts Left:" + self.doa.score.boosts);
    wait 0.5;
  }

  self.doa.var_d524abd8 = 0;
}

function function_e5266c17() {
  self notify("1ad8a2fc5cbc1be4");
  self endon("1ad8a2fc5cbc1be4");
  level waittill(#"hash_12d79bc0fed4ee5a");
  bot::remove_bots();
}

function function_db3aef8f() {
  self notify("c3cacba82808ba9");
  self endon("c3cacba82808ba9");
  level waittill(#"hash_12d79bc0fed4ee5a");
  level.var_a095060b = 0;
  level.var_e5d89122 = 0;
  namespace_1e25ad94::debugmsg("DOA Soak Test [OFF]");
  setDvar(#"hash_2167ce61af5dc0b0", 1);
}

function function_3a2701da() {
  level endon(#"game_over");
  level endon(#"hash_12d79bc0fed4ee5a");

  while(true) {
    wait 10;

    if(namespace_dfc652ee::function_69cafbe0() < 5) {
      namespace_dfc652ee::function_ad7ac41b(getplayers()[0].origin, 12, 1024);
      namespace_dfc652ee::function_ad7ac41b(getplayers()[0].origin, 8, 1024, 6);
      namespace_dfc652ee::function_ad7ac41b(getplayers()[0].origin, 8, 1024, 1);
    }
  }
}

function function_61b604bf() {
  var_663588d = "<dev string:x6b>";
  var_b0d28a7 = "<dev string:x85>";

  foreach(def in level.doa.pickups.itemdefs) {
    if([[def]] - > gettype() == 1) {
      continue;
    }

    if([[def]] - > gettype() == 6) {
      continue;
    }

    if([[def]] - > gettype() == 13) {
      continue;
    }

    name = function_9e72a96([[def]] - > getname());
    toks = strtok(name, var_b0d28a7);
    label = var_663588d;

    for(i = 1; i < toks.size; i++) {
      if(i > 1) {
        label += "<dev string:x85>";
      }

      label += toks[i];
    }

    cmdline = "<dev string:x8a>" + name + "<dev string:x9f>";
    util::add_devgui(label, cmdline);
  }

  var_663588d = "<dev string:xb9>";

  foreach(def in level.doa.pickups.itemdefs) {
    if([[def]] - > gettype() != 6) {
      continue;
    }

    name = function_9e72a96([[def]] - > getname());
    toks = strtok(name, var_b0d28a7);
    label = var_663588d;

    for(i = 1; i < toks.size; i++) {
      if(i > 1) {
        label += "<dev string:x85>";
      }

      label += toks[i];
    }

    cmdline = "<dev string:x8a>" + name + "<dev string:x9f>";
    util::add_devgui(label, cmdline);
  }

  var_663588d = "<dev string:xd5>";

  foreach(def in level.doa.pickups.itemdefs) {
    if(!([[def]] - > gettype() == 1 || [[def]] - > gettype() == 13)) {
      continue;
    }

    name = function_9e72a96([[def]] - > getname());
    toks = strtok(name, var_b0d28a7);
    label = var_663588d;

    for(i = 1; i < toks.size; i++) {
      if(i > 1) {
        label += "<dev string:x85>";
      }

      label += toks[i];
    }

    cmdline = "<dev string:x8a>" + name + "<dev string:x9f>";
    util::add_devgui(label, cmdline);
  }
}

function function_43548cd2() {
  self notify("42198135199f9d64");
  self endon("42198135199f9d64");

  if(is_true(level.doa.var_23ae0778)) {
    level.doa.var_23ae0778 = 0;
    return;
  }

  level.doa.var_23ae0778 = 1;
  player = getplayers()[0];
  var_bead1873 = 13500;
  topy = 30000;
  var_d7e22d96 = 20000;
  bottomy = 30000;

  if(is_true(level.doa.var_ecff3871)) {
    var_bead1873 *= -1;
    topy *= -1;
    var_d7e22d96 *= -1;
    bottomy *= -1;
  }

  while(true) {
    var_eb40b4af = (var_bead1873, topy, 10000);
    var_5d5e18e0 = (var_bead1873, topy * -1, 10000);
    var_a515abf2 = (var_d7e22d96 * -1, bottomy, 10000);
    var_157b8cbc = (var_d7e22d96 * -1, bottomy * -1, 10000);
    level thread namespace_1e25ad94::debugline(player.origin, player.origin + var_eb40b4af, 0.1, (0, 1, 0));
    level thread namespace_1e25ad94::debugline(player.origin, player.origin + var_5d5e18e0, 0.1, (0, 0, 1));
    level thread namespace_1e25ad94::debugline(player.origin, player.origin + var_a515abf2, 0.1, (1, 0, 0));
    level thread namespace_1e25ad94::debugline(player.origin, player.origin + var_157b8cbc, 0.1, (1, 1, 0));
    wait 0.1;
  }
}

function function_a2a93037(var_1d62f124 = 5) {
  self endon(#"death");

  if(!isDefined(self.var_588775c1)) {
    self.var_588775c1 = 0;
  }

  if(!isDefined(self.var_98f48bd3)) {
    self.var_98f48bd3 = [];
  }

  if(!isDefined(self.var_cb0de45e)) {
    self.var_cb0de45e = 0;
  }

  if(!isDefined(self.var_3d8e0261)) {
    self.var_3d8e0261 = 0;
  }

  while(true) {
    waitframe(1);
    self.var_588775c1 = 0;
    self.var_3d8e0261 = 0;

    for(i = 0; i < self.var_98f48bd3.size; i++) {
      if(self.var_98f48bd3[i] > 0) {
        self.var_588775c1 += self.var_98f48bd3[i];
        self.var_3d8e0261++;
      }
    }

    self.var_588775c1 /= var_1d62f124;
  }
}

function function_f451bc26(var_1d62f124 = 5) {
  self endon(#"death");

  if(!isDefined(self.var_588775c1)) {
    self.var_588775c1 = 0;
  }

  if(!isDefined(self.var_98f48bd3)) {
    self.var_98f48bd3 = [];
  }

  var_36d61f3a = 1 / float(function_60d95f53()) / 1000;
  var_8f4c3718 = var_1d62f124 * var_36d61f3a;

  for(i = 0; i < var_8f4c3718; i++) {
    self.var_98f48bd3[i] = 0;
  }

  var_bb435707 = self.health;

  for(idx = 0; true; idx = 0) {
    self.var_98f48bd3[idx] = var_bb435707 - self.health;
    var_bb435707 = self.health;
    waitframe(1);
    idx++;

    if(idx >= var_8f4c3718) {}
  }
}

function function_6790d816() {
  self endon(#"death");

  while(true) {
    self waittill(#"damage");
    self.var_cb0de45e++;
    self namespace_ec06fe4a::function_2f4b0f9(self.health);
  }
}

function function_626d10c0(victimnum) {
  birthtime = gettime();
  self waittill(#"death");
  deathtime = gettime();
  seconds = float(deathtime - birthtime) / 1000;
  namespace_1e25ad94::function_4e3cfad("Victim Number: " + victimnum + " lasted " + seconds + " seconds", (1, 1, 1), 1, 1.5, 3);
}

function function_598305fe() {
  level notify(#"round_over");
  level thread function_de70888a();
  level namespace_ec06fe4a::function_b6b79fd1();
  wait 2;
  namespace_ec06fe4a::clearallcorpses();
  level.doa.var_ecff3871 = 0;
  namespace_8c04284b::function_a70ff03e(level.doa.var_ecff3871);
  doa_banner::function_7a0e5387();
  level notify(#"hash_40a4d01c20db352c");
  [[level.doa.var_39e3fa99]] - > setpaused(1);
  level util::set_lighting_state(3, 0);
  level clientfield::set("<dev string:xf3>", 3);
  player1 = getplayers()[0];

  if(!isDefined(level.doa.dev)) {
    level.doa.dev = spawnStruct();
    playerspot = struct::get("<dev string:xfd>");
    var_e2fdda78 = struct::get("<dev string:x113>");
    level.doa.dev.playerorg = namespace_ec06fe4a::spawnmodel(playerspot.origin, "<dev string:x129>", playerspot.angles, "<dev string:xfd>");
    level.doa.dev.var_85d6cfdf = namespace_ec06fe4a::spawnmodel(var_e2fdda78.origin, "<dev string:x129>", var_e2fdda78.angles, "<dev string:x113>");
    player1 linkto(level.doa.dev.playerorg);
    player1.doa.var_57eaec6e = 1;
  }

  victim = undefined;
  victimnum = 0;
  var_94f3b914 = "<dev string:x137>";
  var_b18e4c25 = [];
  right = vectornormalize(anglestoright(level.doa.dev.var_85d6cfdf.angles));
  forward = vectornormalize(anglestoright(level.doa.dev.var_85d6cfdf.angles));

  while(is_true(level.doa.var_598305fe)) {
    if(!isDefined(victim)) {
      victimnum++;
      var_94f3b914 = getDvar(#"hash_58c5fb7998861ea3", "<dev string:x13b>");
      victim = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee(var_94f3b914), level.doa.dev.var_85d6cfdf.origin);
      victim.var_6ea9e4cf = 1;
      victim.var_9540e8e7 = 1;
      victim namespace_83eb6304::turnofffx("<dev string:x14b>");
      victim.takedamage = 1;
      victim namespace_ec06fe4a::function_2f4b0f9(victim.health);
      victim forceteleport(level.doa.dev.var_85d6cfdf.origin, level.doa.dev.var_85d6cfdf.angles);
      victim.ignoreall = 1;
      victim.var_227e7c79 = 1;
      victim linkto(level.doa.dev.var_85d6cfdf);
      victim thread function_f451bc26(1);
      victim thread function_a2a93037(1);
      victim thread function_6790d816();
      victim thread function_626d10c0(victimnum);
    }

    function_1eaaceab(var_b18e4c25);

    if(var_b18e4c25.size < 6) {
      foreach(guy in var_b18e4c25) {
        if(isDefined(guy)) {
          guy thread namespace_ec06fe4a::function_570729f0(0);
        }
      }

      var_b18e4c25 = [];

      if(!isDefined(var_b18e4c25)) {
        var_b18e4c25 = [];
      } else if(!isarray(var_b18e4c25)) {
        var_b18e4c25 = array(var_b18e4c25);
      }

      var_b18e4c25[var_b18e4c25.size] = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("<dev string:x13b>"), level.doa.dev.var_85d6cfdf.origin + right * 20);

      if(!isDefined(var_b18e4c25)) {
        var_b18e4c25 = [];
      } else if(!isarray(var_b18e4c25)) {
        var_b18e4c25 = array(var_b18e4c25);
      }

      var_b18e4c25[var_b18e4c25.size] = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("<dev string:x13b>"), level.doa.dev.var_85d6cfdf.origin - right * 20);

      if(!isDefined(var_b18e4c25)) {
        var_b18e4c25 = [];
      } else if(!isarray(var_b18e4c25)) {
        var_b18e4c25 = array(var_b18e4c25);
      }

      var_b18e4c25[var_b18e4c25.size] = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("<dev string:x13b>"), level.doa.dev.var_85d6cfdf.origin + right * 40 - forward * 28);

      if(!isDefined(var_b18e4c25)) {
        var_b18e4c25 = [];
      } else if(!isarray(var_b18e4c25)) {
        var_b18e4c25 = array(var_b18e4c25);
      }

      var_b18e4c25[var_b18e4c25.size] = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("<dev string:x13b>"), level.doa.dev.var_85d6cfdf.origin - right * 40 - forward * 28);

      if(!isDefined(var_b18e4c25)) {
        var_b18e4c25 = [];
      } else if(!isarray(var_b18e4c25)) {
        var_b18e4c25 = array(var_b18e4c25);
      }

      var_b18e4c25[var_b18e4c25.size] = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("<dev string:x13b>"), level.doa.dev.var_85d6cfdf.origin + right * 96 - forward * 56);

      if(!isDefined(var_b18e4c25)) {
        var_b18e4c25 = [];
      } else if(!isarray(var_b18e4c25)) {
        var_b18e4c25 = array(var_b18e4c25);
      }

      var_b18e4c25[var_b18e4c25.size] = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("<dev string:x13b>"), level.doa.dev.var_85d6cfdf.origin - right * 96 - forward * 56);

      foreach(guy in var_b18e4c25) {
        guy.ignoreall = 1;
        guy.allow_movement = 0;
        guy.var_834ad023 = 1;
        guy.var_6edab899 = 1;
        guy setgoal(guy.origin);
        guy.health = 60000;
        guy.maxhealth = 60000;
      }
    }

    foreach(guy in var_b18e4c25) {
      if(isDefined(guy)) {
        guy setgoal(guy.origin);
      }
    }

    victim.ignoreall = 1;
    victim clearenemy();
    x = 800;
    y = 530;
    namespace_1e25ad94::function_70e370a(x, y, "<dev string:x160>", (1, 1, 1), 1, 2, 0.05);
    y += 40;
    text = "<dev string:x176>" + level.doa.roundnumber;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "<dev string:x18b>" + var_94f3b914 + "<dev string:x1a0>" + victimnum;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "<dev string:x1b4>" + victim.health;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "<dev string:x1c8>" + victim.maxhealth;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 30;
    text = "<dev string:x1d9>" + function_9e72a96(player1.doa.currentweaponname);
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "<dev string:x1ed>" + victim.var_3d8e0261 + "<dev string:x20a>" + victim.var_cb0de45e;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 1, 0.05);
    y += 20;
    text = "<dev string:x21b>" + victim.var_588775c1;
    namespace_1e25ad94::function_70e370a(x, y, text, (1, 1, 1), 1, 2, 0.05);
    y += 30;
    waitframe(1);
  }

  foreach(guy in var_b18e4c25) {
    if(isDefined(guy)) {
      guy thread namespace_ec06fe4a::function_570729f0(0.1);
    }
  }

  if(isDefined(victim)) {
    victim thread namespace_ec06fe4a::function_570729f0(0.1);
  }

  if(isDefined(level.doa.dev)) {
    if(isDefined(player1)) {
      player1 unlink();
    }

    if(isDefined(level.doa.dev.playerorg)) {
      level.doa.dev.playerorg unlink();
      level.doa.dev.playerorg delete();
    }

    if(isDefined(level.doa.dev.var_85d6cfdf)) {
      level.doa.dev.var_85d6cfdf unlink();
      level.doa.dev.var_85d6cfdf delete();
    }

    level.doa.dev = undefined;
  }
}

function function_ade3e372() {
  self notify("668176ab924f7ebb");
  self endon("668176ab924f7ebb");

  if(!level.doa.var_ade3e372) {
    level notify(#"hash_6b0c389ef8ac36b4");
    return;
  }

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    player thread function_ddde8af6();
  }

  while(true) {
    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      player dodamage(player.health + 100, player.origin);
    }

    wait randomintrange(4, 10);
  }
}