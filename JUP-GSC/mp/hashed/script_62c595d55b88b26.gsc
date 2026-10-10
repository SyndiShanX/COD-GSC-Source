/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_62c595d55b88b26.gsc
************************************************/

#using script_3f8889c16399185c;
#using script_6ad351ebd5a33280;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_ending;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_8c2e78a6b4c1c6fd;

function function_d32f459ab9f5e7af() {
  setdevdvarifuninitialized(@ "hash_cf55e0f95935f5af", 1);
  setdevdvarifuninitialized(@ "hash_ad33abd04b38d2fa", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_ad33aad04b38d0c7", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_ad33a9d04b38ce94", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_ad33a8d04b38cc61", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_ad33a7d04b38ca2e", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_ad33a6d04b38c7fb", "<dev string:x1c>");

  accoladelist = getscriptbundle(%"hash_2e2c8e9902bd7702");
  level.var_e3fca817c22e740d = [];

  if(isDefined(accoladelist)) {
    if(isDefined(accoladelist.var_ed69fdc32e48c4ea)) {
      foreach(id, entry in accoladelist.var_ed69fdc32e48c4ea) {
        if(isnumber(id) && isDefined(entry)) {
          ref = entry.var_6627cd540343e11d;

          if(!isDefined(level.var_e3fca817c22e740d[ref])) {
            level.var_e3fca817c22e740d[ref] = id;
            continue;
          }

          assert(!isDefined(level.var_e3fca817c22e740d[ref]));
        }
      }
    } else {
      assertex(isDefined(accoladelist.var_ed69fdc32e48c4ea), "<dev string:x20>");
    }
  } else {
    assertex(isDefined(accoladelist), "<dev string:x77>");
  }

  level.var_bcf7be5c24905ab9 = [];
  level.var_5477e9d7bbf824bf = [];
  function_389e9b1947ae8a9d();
  function_5368e57349c65cd6();
  params = spawnStruct();
  params.scenename = "jup_wz_acc_assassin_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["executionKills", "meleeKills"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 1;
  function_fa624b8c032afcf7("assassin", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_assists_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["assists"];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("assists", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_bigguns_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["killstreakKills"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 1;
  function_fa624b8c032afcf7("bigguns", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_breacher_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["stoppingPowerKills", "bossAgentKills"];

  for(i = 1; i <= 3; i++) {
    params.scoreparams[params.scoreparams.size] = "tier" + i + "NormalAgentKills";
    params.scoreparams[params.scoreparams.size] = "tier" + i + "EliteAgentKills";
  }

  params.maxvalue = 16;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("breacher", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_commando_scene";
  params.scorefunc = &function_f0496b6c16117c3f;
  params.datafunc = &function_755ff55065755233;

  params.debugfunc = &function_b12f9d6b95f241d0;

  params.maxvalue = 13;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("commando", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_ghost_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["deadSilenceKills", "throwingKnifeKills", "killstreakCUAVAssists", "silencedKills"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 1;
  function_1ef76151d5fb5218("ghost", "killstreakCUAVAssists", 0.5);
  function_fa624b8c032afcf7("ghost", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_interrogator_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["interrogations"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("interrogator", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_killer_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["kills"];
  params.maxvalue = 18;
  params.floor = 1;
  params.scale = 2;
  function_fa624b8c032afcf7("killer", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_machinist_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["smokesUsed", "flashbangHits", "trophySystemHits", "empDroneHits", "gasHits", "stunHits", "decoyHits", "deployableCoverUsed", "shockStickHits"];
  params.maxvalue = 11;
  params.floor = 1;
  params.scale = 0;
  function_1ef76151d5fb5218("machinist", "decoyHits", 0.1);
  function_1ef76151d5fb5218("machinist", "deployableCoverUsed", 0.1);
  function_1ef76151d5fb5218("machinist", "shockStickHits", 0.1);
  function_fa624b8c032afcf7("machinist", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_marksman_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["headshots", "totalMultikills", "penetrationKills"];
  params.maxvalue = 9;
  params.floor = 1;
  params.scale = 1;
  function_fa624b8c032afcf7("marksman", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_medic_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["rescues", "kioskRevives"];
  params.maxvalue = 6;
  params.floor = 1;
  params.scale = 1;
  function_fa624b8c032afcf7("medic", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_moneybags_scene";
  params.scorefunc = &function_8d32528bf59f4d60;
  params.datafunc = &function_a1d32055df3b7000;

  params.debugfunc = &function_f9cb44b2fa2cb71;

  params.scoreparams = ["highestPurchaseCost"];
  params.maxvalue = 5000;
  params.floor = 20;
  params.scale = 2;
  function_fa624b8c032afcf7("moneybags", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_pyro_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["fragKills", "molotovKills", "launcherKills", "semtexKills", "thermiteKills"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("pyro", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_scavenger_scene";
  params.scorefunc = &function_56c0ae4c11e6ecc3;
  params.datafunc = &function_c8209fbd2f8c013;

  params.debugfunc = &function_4fd5f112e483ad54;

  params.maxvalue = 22;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("scavenger", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_scout_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["reconDroneMarks", "killstreakUAVAssists", "killstreakAUAVAssists", "binocularMarks", "snapshotHits", "tacCamMarks"];
  params.maxvalue = 7;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("scout", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_sniper_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["longshotKills"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 1;
  function_fa624b8c032afcf7("sniper", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_supplier_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["munitionsBoxUsed", "armorBoxUsed"];
  params.maxvalue = 9;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("supplier", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_survivor_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["damageHealed", "gulagWins", "rescued", "revivedFromKiosk"];
  params.maxvalue = 59;
  params.floor = 1;
  params.scale = 2;
  function_1ef76151d5fb5218("survivor", "damageHealed", 0.1);
  function_fa624b8c032afcf7("survivor", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_teamobjectives_scene";
  params.scorefunc = &function_b9d90f8e9bf917b0;
  params.datafunc = &function_bd072f91ee4831b0;

  params.debugfunc = &function_9c146e27d6a5e7e1;

  params.scoreparams = ["blacksitesCaptured", "strongholdsCaptured"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("teamobjectives", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_trapper_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = ["claymoreKills", "c4Kills", "proximityMineKills"];
  params.maxvalue = 5;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("trapper", params);

  if(scripts\mp\gametypes\br_ending::can_play_ending()) {
    level.var_e3ac672a3513883f = &function_2cbdf94f9506ad4f;
    level.var_c3edd7b8c279a3e = &function_3e06f1c56df58044;
  }

  if(getdvarint(@ "hash_cc732c73e93ea9d7", 0)) {
    thread function_ebad1c4b67a19a0e();
  }
}

function function_dd857d7c2bd2f1bd() {
  params = spawnStruct();
  params.scenename = "jup_wz_acc_deadweight_scene";
  params.scorefunc = &function_93ffafa2252e5dff;
  params.datafunc = &function_6381c928faf6229f;

  params.debugfunc = &function_5ec9e0597a47f590;

  params.scoreparams = ["deaths"];
  params.maxvalue = 1;
  params.floor = 0.001;
  params.scale = 2;
  function_fa624b8c032afcf7("deadweight", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_highachiever_cool_scene";
  params.scorefunc = &function_f546b635aa8b84d2;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("highachiever_cool", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_highachiever_cooler_scene";
  params.scorefunc = &function_f546b635aa8b84d2;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("highachiever_cooler", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_highachiever_coolest_scene";
  params.scorefunc = &function_f546b635aa8b84d2;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("highachiever_coolest", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_immortal_scene";
  params.scorefunc = &function_47ad2469e6be0500;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_4a6f9f6476301391;

  params.scoreparams = ["deaths"];
  function_fa624b8c032afcf7("immortal", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_medalist_cool_scene";
  params.scorefunc = &function_f3f8f37d12315948;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("medalist_cool", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_medalist_cooler_scene";
  params.scorefunc = &function_f3f8f37d12315948;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("medalist_cooler", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_medalist_coolest_scene";
  params.scorefunc = &function_f3f8f37d12315948;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  params.maxvalue = 8;
  params.floor = 1;
  params.scale = 0;
  function_fa624b8c032afcf7("medalist_coolest", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_pacifist_scene";
  params.scorefunc = &function_e1271ea633c42ecc;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_176d8f69d69ec84d;

  params.scoreparams = ["kills", "assists"];
  params.maxvalue = 100;
  params.floor = 0;
  params.scale = 0;
  function_fa624b8c032afcf7("pacifist", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_tryhard_cool_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  function_fa624b8c032afcf7("tryhard_cool", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_tryhard_cooler_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  function_fa624b8c032afcf7("tryhard_cooler", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_tryhard_coolest_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  function_fa624b8c032afcf7("tryhard_coolest", params);
  params = spawnStruct();
  params.scenename = "jup_wz_acc_weakestlink_scene";
  params.scorefunc = &function_b13f6a12712eaa29;
  params.datafunc = &function_3f5a0a838086d8dd;

  params.debugfunc = &function_6ab412e6faa588ea;

  params.scoreparams = [];
  function_fa624b8c032afcf7("weakestlink", params);
}

function private function_389e9b1947ae8a9d() {
  level.var_9a2fe47bbb5d6729 = ["weakestlink", "deadweight", "tryhard_cool", "tryhard_cooler", "tryhard_coolest", "medalist_cool", "medalist_cooler", "medalist_coolest", "highachiever_cool", "highachiever_cooler", "highachiever_coolest"];
}

function private function_5368e57349c65cd6() {
  level.var_d1c6ce2aca9c7b81 = ["weakestlink", "deadweight", "medalist_cool", "medalist_cooler", "highachiever_cool", "highachiever_cooler", "highachiever_coolest"];
  var_aed700f334c599e9 = strtok(getDvar(@ "hash_b534c88be1278728", ""), " ");

  if(var_aed700f334c599e9.size > 0) {
    level.var_d1c6ce2aca9c7b81 = array_combine_unique(level.var_d1c6ce2aca9c7b81, var_aed700f334c599e9);
  }
}

function function_fa624b8c032afcf7(ref, paramstruct) {
  assert(isDefined(ref));
  assert(!isDefined(level.var_bcf7be5c24905ab9[ref]));
  assert(isDefined(paramstruct));
  assert(isDefined(paramstruct.scorefunc));
  paramstruct.name = ref;
  level.var_bcf7be5c24905ab9[ref] = paramstruct;
}

function function_2cbdf94f9506ad4f() {
  level endon("game_ended");
  self endon("disconnect");

  foreach(entry in level.var_bcf7be5c24905ab9) {
    if(isDefined(entry.scoreparams) && entry.scoreparams.size > 0) {
      foreach(persval in entry.scoreparams) {
        scripts\mp\utility\stats::initpersstat(persval);
      }
    }
  }
}

function function_1ef76151d5fb5218(accolade, stat, mod) {
  level.var_5477e9d7bbf824bf[accolade][stat] = mod;
}

function function_5417d27691d41344(accolade, stat) {
  if(!isDefined(level.var_5477e9d7bbf824bf) || !array_contains_key(level.var_5477e9d7bbf824bf, accolade) || !array_contains_key(level.var_5477e9d7bbf824bf[accolade], stat)) {
    return 1;
  }

  return level.var_5477e9d7bbf824bf[accolade][stat];
}

function private function_93ffafa2252e5dff(ref, params) {
  assert(isDefined(scripts\mp\utility\stats::getpersstat("<dev string:xbd>")));
  playerrank = getrank() + 1;
  teammates = scripts\mp\utility\teams::getteamdata(self.team, "players");

  if(teammates.size < 2 || playerrank < 54) {
    totalval = 0;
    self.var_fb37db009207fe1a[ref] = totalval;
    self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
    return;
  }

  localkills = getpersstat("kills");
  localdeaths = getpersstat("deaths");
  localscore = getpersstat("score");
  secondbestscore = -1;

  foreach(player in teammates) {
    if(player == self) {
      continue;
    }

    pkills = player getpersstat("kills");
    pdeaths = player getpersstat("deaths");

    if(pkills <= localkills || pdeaths >= localdeaths) {
      totalval = 0;
      secondbestscore = -1;
      break;
    }

    pscore = player getpersstat("score");

    if(secondbestscore == -1 || pscore < secondbestscore) {
      secondbestscore = pscore;
    }
  }

  if(secondbestscore > 0) {
    var_81d57b941144b81c = getdvarfloat(@ "hash_be569afee6af87f5", 0.2);
    var_fd506798b992cd0a = secondbestscore * var_81d57b941144b81c;
    var_32d1e481486eb81e = (localscore - var_fd506798b992cd0a) / (secondbestscore - var_fd506798b992cd0a);
    totalval = clamp(1 - var_32d1e481486eb81e, 0.001, 1);
  } else {
    totalval = 0;
  }

  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
}

function private function_47ad2469e6be0500(ref, params) {
  totalval = 0;
  assert(isDefined(scripts\mp\utility\stats::getpersstat("<dev string:xbd>")));

  if(scripts\mp\utility\stats::getpersstat("deaths") == 0) {
    totalval = 0.8;
  }

  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = totalval;
}

function private function_8d32528bf59f4d60(ref, params) {
  totalval = 0;

  if(isDefined(self.plundercount)) {
    totalval += self.plundercount * function_5417d27691d41344(ref, "plunderCount");
  }

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        totalval += scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
      }
    }
  }

  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
}

function private function_f3f8f37d12315948(ref, params) {
  totalwins = 0;

  if(istrue(level.brgametype.var_550e36ff15e08141)) {
    self.var_fb37db009207fe1a[ref] = 0;
    self.var_769c9edd0782e95d[ref] = 0;
    return;
  }

  totalwins = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "wins_c");
  highestkills = 0;
  highestrevives = 0;
  highestassist = 0;
  highestcontracts = 0;
  highestrespawns = 0;
  successscore = 0;
  currentkills = scripts\mp\utility\stats::getpersstat("kills");
  currentrevives = scripts\mp\utility\stats::getpersstat("rescues");
  currentassist = scripts\mp\utility\stats::getpersstat("assists");
  currentcontracts = scripts\mp\utility\stats::getpersstat("objectivesCompleted");
  currentrespawns = scripts\mp\utility\stats::getpersstat("kioskRevives");
  textvalue = 0;
  recordname = "";
  var_5e7fd99bc2d17e16 = "";

  switch (ref) {
    case #"hash_1d132230c198824":
      highestkills = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "kills_r");
      highestrevives = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "revives_r");
      highestassist = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "assist_r");
      highestcontracts = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "contracts_r");
      highestrespawns = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "respawns_r");
      var_5e7fd99bc2d17e16 = "_rolling";
      successscore = 0.8;
      break;
    case #"hash_37f4d05731e98df3":
      highestkills = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "kills_s");
      highestrevives = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "revives_s");
      highestassist = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "assist_s");
      highestcontracts = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "contracts_s");
      highestrespawns = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "respawns_s");
      var_5e7fd99bc2d17e16 = "_seasonal";
      successscore = 0.85;
      break;
    case #"hash_ffee7a4392a7837c":
      highestkills = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "kills_c");
      highestrevives = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "revives_c");
      highestassist = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "assist_c");
      highestcontracts = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "contracts_c");
      highestrespawns = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "respawns_c");
      var_5e7fd99bc2d17e16 = "_chapter";
      successscore = 0.9;
      break;
  }

  totalval = 0;

  if(highestkills < currentkills && currentkills >= 5) {
    totalval = successscore;
    recordname = "pb_kill";
    textvalue = currentkills;
  } else if(highestrevives < currentrevives && currentrevives >= 3) {
    totalval = successscore;
    recordname = "pb_revive";
    textvalue = currentrevives;
  } else if(highestcontracts < currentcontracts && currentcontracts >= 3) {
    totalval = successscore;
    recordname = "pb_contract";
    textvalue = currentcontracts;
  } else if(highestrespawns < currentrespawns && currentrespawns >= 3) {
    totalval = successscore;
    recordname = "pb_return";
    textvalue = currentrespawns;
  }

  function_cab1aa0020df0892(ref, totalval, recordname + var_5e7fd99bc2d17e16, textvalue);
  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = totalval;
}

function private function_f546b635aa8b84d2(ref, params) {
  totalwins = 0;

  if(!istrue(level.brgametype.var_550e36ff15e08141)) {
    totalwins = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "wins_c");
  }

  if(!isDefined(level.var_4fb0509d0e36fc92)) {
    level.var_4fb0509d0e36fc92 = [];
    level.var_4fb0509d0e36fc92["kills"] = 0;
    level.var_4fb0509d0e36fc92["rescues"] = 0;
    level.var_4fb0509d0e36fc92["assists"] = 0;
    level.var_4fb0509d0e36fc92["objectivesCompleted"] = 0;
    level.var_4fb0509d0e36fc92["kioskRevives"] = 0;

    foreach(teamate in level.teamdata[self.team]["players"]) {
      temkills = teamate scripts\mp\utility\stats::getpersstat("kills");
      temrevives = teamate scripts\mp\utility\stats::getpersstat("rescues");
      temassist = teamate scripts\mp\utility\stats::getpersstat("assists");
      temcontracts = teamate scripts\mp\utility\stats::getpersstat("objectivesCompleted");
      temrespawns = teamate scripts\mp\utility\stats::getpersstat("kioskRevives");

      if(temkills > level.var_4fb0509d0e36fc92["kills"]) {
        level.var_4fb0509d0e36fc92["kills"] = temkills;
      }

      if(temrevives > level.var_4fb0509d0e36fc92["rescues"]) {
        level.var_4fb0509d0e36fc92["rescues"] = temrevives;
      }

      if(temassist > level.var_4fb0509d0e36fc92["assists"]) {
        level.var_4fb0509d0e36fc92["assists"] = temassist;
      }

      if(temcontracts > level.var_4fb0509d0e36fc92["objectivesCompleted"]) {
        level.var_4fb0509d0e36fc92["objectivesCompleted"] = temcontracts;
      }

      if(temrespawns > level.var_4fb0509d0e36fc92["kioskRevives"]) {
        level.var_4fb0509d0e36fc92["kioskRevives"] = temrespawns;
      }
    }
  }

  highestkills = 0;
  highestrevives = 0;
  highestassist = 0;
  highestcontracts = 0;
  highestrespawns = 0;
  winrate = 0;
  top5rate = 0;
  top10rate = 0;
  top25rate = 0;
  currentkills = getdvarint(@ "hash_539991935690a86a", scripts\mp\utility\stats::getpersstat("kills"));
  currentrevives = getdvarint(@ "hash_b924a7ffec7e8bb1", scripts\mp\utility\stats::getpersstat("rescues"));
  currentassist = getdvarint(@ "hash_e21360dea7af2ab", scripts\mp\utility\stats::getpersstat("assists"));
  currentcontracts = getdvarint(@ "hash_f73e12236112ba9c", scripts\mp\utility\stats::getpersstat("objectivesCompleted"));
  currentrespawns = getdvarint(@ "hash_57751008667e1135", scripts\mp\utility\stats::getpersstat("kioskRevives"));
  currentwins = 0;
  currenttop5 = 0;
  currenttop10 = 0;
  currenttop25 = 0;
  successscore = 0;
  textvalue = 0;
  recordname = "";
  var_5e7fd99bc2d17e16 = "";

  switch (ref) {
    case #"hash_cefd45a5f0651582":
      if(isDefined(level.var_c192bb3f79de7dbf)) {
        highestkills = level.var_c192bb3f79de7dbf["kills_r"];
        highestrevives = level.var_c192bb3f79de7dbf["revives_r"];
        highestassist = level.var_c192bb3f79de7dbf["assist_r"];
        highestcontracts = level.var_c192bb3f79de7dbf["contracts_r"];
        highestrespawns = level.var_c192bb3f79de7dbf["respawns_r"];
        winrate = level.var_c192bb3f79de7dbf["wins_r"];
        top5rate = level.var_c192bb3f79de7dbf["top5_r"];
        top10rate = level.var_c192bb3f79de7dbf["top10_r"];
        top25rate = level.var_c192bb3f79de7dbf["top25_r"];
      }

      currentwins = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "wins_r") + 1;
      currenttop5 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top5_r") + 1;
      currenttop10 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top10_r") + 1;
      currenttop25 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top25_r") + 1;
      successscore = 0.95;
      var_5e7fd99bc2d17e16 = "_rolling";
      break;
    case #"hash_67540269f1b46075":
      if(isDefined(level.var_c192bb3f79de7dbf)) {
        highestkills = level.var_c192bb3f79de7dbf["kills_s"];
        highestrevives = level.var_c192bb3f79de7dbf["revives_s"];
        highestassist = level.var_c192bb3f79de7dbf["assist_s"];
        highestcontracts = level.var_c192bb3f79de7dbf["contracts_s"];
        highestrespawns = level.var_c192bb3f79de7dbf["respawns_s"];
        winrate = level.var_c192bb3f79de7dbf["wins_s"];
        top5rate = level.var_c192bb3f79de7dbf["top5_s"];
        top10rate = level.var_c192bb3f79de7dbf["top10_s"];
        top25rate = level.var_c192bb3f79de7dbf["top25_s"];
      }

      currentwins = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "wins_s") + 1;
      currenttop5 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top5_s") + 1;
      currenttop10 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top10_s") + 1;
      currenttop25 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top25_s") + 1;
      successscore = 0.98;
      var_5e7fd99bc2d17e16 = "_seasonal";
      break;
    case #"hash_5d9ccfc77ef0e622":
      if(isDefined(level.var_c192bb3f79de7dbf)) {
        highestkills = level.var_c192bb3f79de7dbf["kills_c"];
        highestrevives = level.var_c192bb3f79de7dbf["revives_c"];
        highestassist = level.var_c192bb3f79de7dbf["assist_c"];
        highestcontracts = level.var_c192bb3f79de7dbf["contracts_c"];
        highestrespawns = level.var_c192bb3f79de7dbf["respawns_c"];
        winrate = level.var_c192bb3f79de7dbf["wins_c"];
        top5rate = level.var_c192bb3f79de7dbf["top5_c"];
        top10rate = level.var_c192bb3f79de7dbf["top10_c"];
        top25rate = level.var_c192bb3f79de7dbf["top25_c"];
      }

      currentwins = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "wins_c") + 1;
      currenttop5 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top5_c") + 1;
      currenttop10 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top10_c") + 1;
      currenttop25 = namespace_8885c19c053dcb46::function_cfab25659633eefc(self, "top25_c") + 1;
      successscore = 1;
      var_5e7fd99bc2d17e16 = "_chapter";
      break;
  }

  totalval = 0;

  if(highestkills < currentkills && currentkills >= 5 && highestkills >= level.var_4fb0509d0e36fc92["kills"]) {
    totalval = successscore;
    recordname = "mb_kill";
    textvalue = currentkills;
  } else if(highestrevives < currentrevives && currentrevives >= 3 && highestrevives >= level.var_4fb0509d0e36fc92["rescues"]) {
    totalval = successscore;
    recordname = "mb_revive";
    textvalue = currentrevives;
  } else if(highestcontracts < currentcontracts && currentcontracts >= 3 && highestcontracts >= level.var_4fb0509d0e36fc92["objectivesCompleted"]) {
    totalval = successscore;
    recordname = "mb_contract";
    textvalue = currentcontracts;
  } else if(highestrespawns < currentrespawns && currentrespawns >= 3 && highestrespawns >= level.var_4fb0509d0e36fc92["kioskRevives"]) {
    totalval = successscore;
    recordname = "mb_return";
    textvalue = currentrespawns;
  }

  function_cab1aa0020df0892(ref, totalval, recordname + var_5e7fd99bc2d17e16, textvalue);
  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = totalval;
}

function private function_cab1aa0020df0892(ref, scorevalue, overridename, textvalue) {
  if(scorevalue > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, ref)) {
    if(isDefined(self.var_f090ccb984435bbc)) {
      if(self.var_d254e61d5b0ee746 < scorevalue) {
        self.var_f090ccb984435bbc = overridename;
        self.var_d254e61d5b0ee746 = scorevalue;
        self.var_5e71ee49d0cc6534 = textvalue;
      }

      return;
    }

    self.var_f090ccb984435bbc = overridename;
    self.var_d254e61d5b0ee746 = scorevalue;
    self.var_5e71ee49d0cc6534 = textvalue;
  }
}

function private function_e1271ea633c42ecc(ref, params) {
  totalkills = scripts\mp\utility\stats::getpersstat("kills");
  var_74ba9cc277cbe543 = scripts\mp\utility\stats::getpersstat("assists");
  totalval = 100 - 100 * totalkills + 3 * var_74ba9cc277cbe543;
  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
}

function function_56c0ae4c11e6ecc3(ref, params) {
  totalval = 0;

  if(isDefined(self.lootcachesopened)) {
    totalval += self.lootcachesopened * function_5417d27691d41344(ref, "lootCachesOpened");
  }

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        totalval += scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
      }
    }
  }

  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
}

function private function_b9d90f8e9bf917b0(ref, params) {
  totalval = 0;

  if(isDefined(self.brmissionscompleted)) {
    totalval += self.brmissionscompleted * function_5417d27691d41344(ref, "brMissionsCompleted");
  }

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        totalval += scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
      }
    }
  }

  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
}

function private function_a72f9ae578e162e8(ref, params) {
  self.var_fb37db009207fe1a[ref] = -1;
  self.var_769c9edd0782e95d[ref] = -1;
}

function private function_9bbbefe6a0debd2b(ref, value) {
  data = level.var_bcf7be5c24905ab9[ref];

  if(!isDefined(data.floor) || value < data.floor) {
    return -1;
  } else if(isDefined(data.maxvalue) && value > data.maxvalue) {
    value = data.maxvalue;
  }

  if(isDefined(data.maxvalue)) {
    if(isDefined(data.minvalue)) {
      minvalue = data.minvalue;
    } else if(isDefined(data.scale) && data.scale == 1) {
      minvalue = data.maxvalue * -0.1;
    } else {
      minvalue = 0;
    }

    assert(data.maxvalue > minvalue);
    value = float(value - minvalue) / float(data.maxvalue - minvalue);
  }

  if(isDefined(data.scale) && data.scale == 2) {
    value = pow(value, 1.2);
  }

  return value;
}

function function_b13f6a12712eaa29(ref, data_points) {
  assert(isDefined(data_points));
  totalval = 0;

  foreach(data_point in data_points) {
    val = scripts\mp\utility\stats::getpersstat(data_point);

    if(isDefined(val)) {
      totalval += val * function_5417d27691d41344(ref, data_point);
    }
  }

  self.var_fb37db009207fe1a[ref] = totalval;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalval);
}

function private function_f0496b6c16117c3f(ref, params) {
  totalkills = 0;
  addcategories = ["pistolKills", "shotgunKills", "smgKills", "arKills", "lmgKills", "sniperKills"];
  subtractcategories = ["longshotKills", "pointBlankKills"];

  foreach(statref in addcategories) {
    val = scripts\mp\utility\stats::getpersstat(statref);

    if(isDefined(val)) {
      totalkills += val;
    }
  }

  foreach(statref in subtractcategories) {
    val = scripts\mp\utility\stats::getpersstat(statref);

    if(isDefined(val)) {
      totalkills -= val;
    }
  }

  self.var_fb37db009207fe1a[ref] = totalkills;
  self.var_769c9edd0782e95d[ref] = function_9bbbefe6a0debd2b(ref, totalkills);
}

function private function_6381c928faf6229f(ref, params) {
  otherstats = [];

  if(isDefined(self.timesdowned)) {
    otherstats["timesDowned"] = self.timesdowned;
  } else {
    otherstats["timesDowned"] = 0;
  }

  return function_a0c339eeaf1dadb5(ref, params, otherstats);
}

function private function_a1d32055df3b7000(ref, params) {
  otherstats = [];

  if(isDefined(self.plundercount)) {
    otherstats["plunderCount"] = self.plundercount;
  } else {
    otherstats["plunderCount"] = 0;
  }

  return function_a0c339eeaf1dadb5(ref, params, otherstats);
}

function function_c8209fbd2f8c013(ref, params) {
  otherstats = [];

  if(isDefined(self.lootcachesopened)) {
    otherstats["lootCachesOpened"] = self.lootcachesopened;
  } else {
    otherstats["lootCachesOpened"] = 0;
  }

  return function_a0c339eeaf1dadb5(ref, params, otherstats);
}

function private function_bd072f91ee4831b0(ref, params) {
  otherstats = [];

  if(isDefined(self.brmissionscompleted)) {
    otherstats["brMissionsCompleted"] = self.brmissionscompleted;
  } else {
    otherstats["brMissionsCompleted"] = 0;
  }

  return function_a0c339eeaf1dadb5(ref, params, otherstats);
}

function private function_755ff55065755233(ref, params) {
  totalkills = 0;
  addcategories = ["pistolKills", "shotgunKills", "smgKills", "arKills", "lmgKills", "sniperKills"];
  subtractcategories = ["longshotKills", "pointBlankKills"];

  foreach(statref in addcategories) {
    val = scripts\mp\utility\stats::getpersstat(statref);

    if(isDefined(val)) {
      totalkills += val;
    }
  }

  foreach(statref in subtractcategories) {
    val = scripts\mp\utility\stats::getpersstat(statref);

    if(isDefined(val)) {
      totalkills -= val;
    }
  }

  otherstats = [];
  otherstats["midRangeKills"] = totalkills;
  return function_a0c339eeaf1dadb5(ref, params, otherstats);
}

function function_3f5a0a838086d8dd(ref, params) {
  return function_a0c339eeaf1dadb5(ref, params);
}

function private function_a0c339eeaf1dadb5(ref, persstats, otherstats) {
  data = spawnStruct();
  data.ref = ref;
  data.statdata = [];
  totalval = 0;

  if(isDefined(persstats)) {
    foreach(stat in persstats) {
      value = 0;
      scaledval = 0;

      if(isDefined(scripts\mp\utility\stats::getpersstat(stat))) {
        value = scripts\mp\utility\stats::getpersstat(stat);
        scaledval = value * function_5417d27691d41344(ref, stat);
        totalval += scaledval;
      }

      data.statdata[stat][0] = value;
      data.statdata[stat][1] = scaledval;
    }
  }

  if(isDefined(otherstats)) {
    foreach(stat, value in otherstats) {
      if(isDefined(value)) {
        scaledval = value * function_5417d27691d41344(ref, stat);
        totalval += scaledval;
        data.statdata[stat][0] = value;
        data.statdata[stat][1] = scaledval;
      }
    }
  }

  data.value = totalval;
  data.scaledvalue = function_9bbbefe6a0debd2b(ref, totalval);
  return data;
}

function function_97113d2008e3d1f6() {
  accolades = [];

  foreach(ref, entry in level.var_bcf7be5c24905ab9) {
    assert(isDefined(entry.datafunc));
    data = self[[entry.datafunc]](ref, entry.scoreparams);
    var_1384d9221443f717 = spawnStruct();
    var_1384d9221443f717.ref = ref;
    value = 0;
    scaledvalue = 0;

    if(isDefined(data.value)) {
      value = max(data.value, value);
    }

    if(isDefined(data.scaledvalue)) {
      scaledvalue = max(data.scaledvalue, scaledvalue);
    }

    var_1384d9221443f717.value = value;
    var_1384d9221443f717.scaledvalue = scaledvalue;
    var_9659c2342b30ad90 = [];

    foreach(sref, entry in data.statdata) {
      svalue = 0;
      var_882e5ffb508915f1 = 0;

      if(isDefined(entry) && entry.size >= 2) {
        if(isDefined(entry[0])) {
          svalue = max(0, entry[0]);
        }

        if(isDefined(entry[1])) {
          var_882e5ffb508915f1 = max(0, entry[1]);
        }
      }

      var_9659c2342b30ad90[var_9659c2342b30ad90.size] = ["stat", sref, "value", svalue, "scaledvalue", var_882e5ffb508915f1];
    }

    var_1384d9221443f717.stats = var_9659c2342b30ad90;
    accolades[accolades.size] = var_1384d9221443f717;
  }

  return accolades;
}

function function_3e06f1c56df58044() {
  data = function_97113d2008e3d1f6();

  foreach(accolade in data) {
    self dlog_recordplayerevent("dlog_event_br_accolade_data", ["stats", accolade.stats, "accolade", accolade.ref, "value", accolade.value, "scaledvalue", accolade.scaledvalue]);
  }
}

function function_74497a0f417e329f(winners) {
  winners = array_removeundefined(winners);

  foreach(player in winners) {
    if(!isPlayer(player)) {
      continue;
    }

    player.var_ae06891211af23ba = undefined;
    player.var_ae7b07ff9d949509 = [];
    player.var_fb37db009207fe1a = [];
    player.var_769c9edd0782e95d = [];
  }

  foreach(ref, entry in level.var_bcf7be5c24905ab9) {
    assert(isDefined(entry.scorefunc));

    foreach(player in winners) {
      if(!isPlayer(player)) {
        continue;
      }

      assert(!isDefined(player.var_fb37db009207fe1a[ref]));
      assert(!isDefined(player.var_769c9edd0782e95d[ref]));
      player[[entry.scorefunc]](ref, entry.scoreparams);
    }
  }

  foreach(ref, entry in level.var_bcf7be5c24905ab9) {
    var_ec1019cff3d1c77f = 0;
    bestplayer = undefined;

    foreach(player in winners) {
      if(!isPlayer(player)) {
        continue;
      }

      if(player.var_fb37db009207fe1a[ref] > var_ec1019cff3d1c77f && player.var_769c9edd0782e95d[ref] >= 0) {
        bestplayer = player;
        var_ec1019cff3d1c77f = player.var_fb37db009207fe1a[ref];
      }
    }

    foreach(player in winners) {
      if(!isPlayer(player)) {
        continue;
      }

      if(player.var_769c9edd0782e95d[ref] >= 0 && player.var_fb37db009207fe1a[ref] == var_ec1019cff3d1c77f) {
        player.var_ae7b07ff9d949509[player.var_ae7b07ff9d949509.size] = ref;
      }
    }
  }

  var_e722466d58c00cc1 = [];

  foreach(player in winners) {
    if(!isPlayer(player)) {
      continue;
    }

    bestref = function_6a7a8a710f348991(player);

    if(!isDefined(bestref)) {
      var_3513c54632ecb882 = -1;

      foreach(ref in player.var_ae7b07ff9d949509) {
        if(arraycontains(level.var_d1c6ce2aca9c7b81, ref)) {
          continue;
        }

        if(array_contains(var_e722466d58c00cc1, ref)) {
          continue;
        }

        if(player.var_769c9edd0782e95d[ref] > var_3513c54632ecb882) {
          var_3513c54632ecb882 = player.var_769c9edd0782e95d[ref];
          bestref = ref;
        }
      }
    }

    if(isDefined(bestref)) {
      player.var_ae06891211af23ba = bestref;
      var_e722466d58c00cc1[var_e722466d58c00cc1.size] = bestref;
    }
  }

  var_cf83385f8a939f54 = ["survivor", "scout", "scavenger", "ghost"];
  var_cf83385f8a939f54 = array_randomize(var_cf83385f8a939f54);
  var_cf83385f8a939f54 = array_combine(var_cf83385f8a939f54, ["killer", "breacher", "moneybags"]);

  for(i = var_cf83385f8a939f54.size - 1; i >= 0; i--) {
    testref = var_cf83385f8a939f54[i];

    if(array_contains(var_e722466d58c00cc1, testref)) {
      var_cf83385f8a939f54 = array_remove_index(var_cf83385f8a939f54, i);
    }
  }

  awardindex = 0;

  foreach(player in winners) {
    if(!isPlayer(player)) {
      continue;
    }

    var_3e04fa138ec067f5 = 0;

    if(!isDefined(player.var_ae06891211af23ba)) {
      assert(awardindex < var_cf83385f8a939f54.size);
      player.var_ae06891211af23ba = var_cf83385f8a939f54[awardindex];
      var_3e04fa138ec067f5 = 1;
      awardindex++;
      var_e722466d58c00cc1[var_e722466d58c00cc1.size] = var_cf83385f8a939f54[awardindex];
    }

    var_688f5beee0172bbb = player.var_fb37db009207fe1a[player.var_ae06891211af23ba];
    scaledval = player.var_769c9edd0782e95d[player.var_ae06891211af23ba];

    if(!isDefined(var_688f5beee0172bbb)) {
      var_688f5beee0172bbb = 0;
    }

    if(!isDefined(scaledval)) {
      scaledval = 0;
    }

    player dlog_recordplayerevent("dlog_event_br_winner_accolade_data", ["accolade", player.var_ae06891211af23ba, "is_participation_trophy", var_3e04fa138ec067f5, "value", float(var_688f5beee0172bbb), "scaled_value", float(scaledval)]);
    player.var_ae7b07ff9d949509 = undefined;
    player.var_fb37db009207fe1a = undefined;
    player.var_769c9edd0782e95d = undefined;
  }
}

function private function_8c70e1b5fb997d3a(winners) {
  for(i = 0; i < winners.size; i++) {
    if(isPlayer(winners[i])) {
      return i;
    }
  }

  return undefined;
}

function private function_95416c93789582a9(winners, index) {
  assert(index < winners.size);
  assert(isPlayer(winners[index]));

  for(tryindex = (index + 1) % winners.size; tryindex != index; tryindex = (index + 1) % winners.size) {
    if(isPlayer(winners[tryindex])) {
      return tryindex;
    }
  }

  return tryindex;
}

function private function_6a7a8a710f348991(player) {
  var_8f2db317ebf49ac6 = getDvar(@ "hash_7aa741226ec758e3", "<dev string:x1c>");

  if(isDefined(level.var_bcf7be5c24905ab9[var_8f2db317ebf49ac6])) {
    return var_8f2db317ebf49ac6;
  }

  stringlist = strtok(getDvar(@ "hash_b217b1fd0c1301e2", "<dev string:x1c>"), "<dev string:xc7>");

  if(stringlist.size > 2) {
    var_8f2db317ebf49ac6 = stringlist[0];

    if(isDefined(level.var_bcf7be5c24905ab9[var_8f2db317ebf49ac6])) {
      stringref = stringlist[1];
      textvalue = int(stringlist[2]);

      if(!isnumber(textvalue)) {
        textvalue = 0;
      }

      player function_cab1aa0020df0892(var_8f2db317ebf49ac6, 999, stringref, textvalue);
      return var_8f2db317ebf49ac6;
    }
  }

  if(isDefined(player.var_769c9edd0782e95d["highachiever_coolest"]) && player.var_769c9edd0782e95d["highachiever_coolest"] > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, "highachiever_coolest")) {
    return "highachiever_coolest";
  } else if(isDefined(player.var_769c9edd0782e95d["highachiever_cooler"]) && player.var_769c9edd0782e95d["highachiever_cooler"] > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, "highachiever_cooler")) {
    return "highachiever_cooler";
  } else if(isDefined(player.var_769c9edd0782e95d["highachiever_cool"]) && player.var_769c9edd0782e95d["highachiever_cool"] > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, "highachiever_cool")) {
    return "highachiever_cool";
  } else if(isDefined(player.var_769c9edd0782e95d["medalist_coolest"]) && player.var_769c9edd0782e95d["medalist_coolest"] > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, "medalist_coolest")) {
    return "medalist_coolest";
  } else if(isDefined(player.var_769c9edd0782e95d["medalist_cooler"]) && player.var_769c9edd0782e95d["medalist_cooler"] > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, "medalist_cooler")) {
    return "medalist_cooler";
  } else if(isDefined(player.var_769c9edd0782e95d["medalist_cool"]) && player.var_769c9edd0782e95d["medalist_cool"] > 0 && !arraycontains(level.var_d1c6ce2aca9c7b81, "medalist_cool")) {
    return "medalist_cool";
  }

  var_2556a6fc8fab9b93 = 0;

  foreach(ref, entry in level.var_bcf7be5c24905ab9) {
    if(arraycontains(level.var_9a2fe47bbb5d6729, ref)) {
      continue;
    }

    if(isDefined(player.var_769c9edd0782e95d[ref]) && player.var_769c9edd0782e95d[ref] >= 0.75) {
      var_2556a6fc8fab9b93++;
    }
  }

  if(var_2556a6fc8fab9b93 >= 7 && isDefined(level.var_bcf7be5c24905ab9["tryhard_coolest"]) && !arraycontains(level.var_d1c6ce2aca9c7b81, "tryhard_coolest")) {
    return "tryhard_coolest";
  } else if(var_2556a6fc8fab9b93 >= 5 && isDefined(level.var_bcf7be5c24905ab9["tryhard_cooler"]) && !arraycontains(level.var_d1c6ce2aca9c7b81, "tryhard_cooler")) {
    return "tryhard_cooler";
  } else if(var_2556a6fc8fab9b93 >= 3 && isDefined(level.var_bcf7be5c24905ab9["tryhard_cool"]) && !arraycontains(level.var_d1c6ce2aca9c7b81, "tryhard_cool")) {
    return "tryhard_cool";
  }

  var_502e863aedfa7526 = getdvarfloat(@ "hash_9c40aa930664958a", 0.25);
  var_1a6f71684f56f371 = 1;
  localkills = player getpersstat("kills");
  teammates = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(tmate in teammates) {
    if(player == tmate) {
      continue;
    }

    pkills = tmate getpersstat("kills");

    if(localkills >= pkills) {
      var_1a6f71684f56f371 = 0;
    }
  }

  playerrank = player getrank() + 1;

  if(teammates.size < 2 || playerrank < 54) {
    var_1a6f71684f56f371 = 0;
  }

  foreach(ref, entry in level.var_bcf7be5c24905ab9) {
    if(arraycontains(level.var_9a2fe47bbb5d6729, ref)) {
      continue;
    }

    if(isDefined(player.var_769c9edd0782e95d[ref]) && player.var_769c9edd0782e95d[ref] >= var_502e863aedfa7526) {
      var_1a6f71684f56f371 = 0;
      break;
    }
  }

  if(var_1a6f71684f56f371 && isDefined(level.var_bcf7be5c24905ab9["weakestlink"]) && !arraycontains(level.var_d1c6ce2aca9c7b81, "weakestlink")) {
    return "weakestlink";
  }

  return undefined;
}

function function_5864d7eeac0e9ac(winners, var_7fa848e5b3bbc437, var_807fea2fc7e90adc) {
  level.var_6b11625abe5346b0 = [];

  if(isDefined(var_807fea2fc7e90adc)) {
    foreach(idx, winner in winners) {
      if(!isPlayer(winner) || winner iscodcaster()) {
        continue;
      }

      if(isDefined(var_807fea2fc7e90adc[idx]) && var_807fea2fc7e90adc[idx] != "" && isDefined(level.var_bcf7be5c24905ab9[var_807fea2fc7e90adc[idx]])) {
        var_16a81c74ce61860e = spawnStruct();
        var_16a81c74ce61860e.ref = var_807fea2fc7e90adc[idx];
        var_16a81c74ce61860e.player = winner;
        level.var_6b11625abe5346b0[level.var_6b11625abe5346b0.size] = var_16a81c74ce61860e;
        continue;
      }

      assert(isDefined(winner.var_ae06891211af23ba));
      var_16a81c74ce61860e = spawnStruct();
      var_16a81c74ce61860e.ref = winner.var_ae06891211af23ba;
      var_16a81c74ce61860e.player = winner;
      level.var_6b11625abe5346b0[level.var_6b11625abe5346b0.size] = var_16a81c74ce61860e;
    }

    return;
  }

  if(getdvarint(@ "hash_dc744c8d367adc1a", 0)) {
    foreach(ref, entry in level.var_bcf7be5c24905ab9) {
      var_16a81c74ce61860e = spawnStruct();
      var_16a81c74ce61860e.ref = ref;
      var_16a81c74ce61860e.player = level.players[0];
      level.var_6b11625abe5346b0[level.var_6b11625abe5346b0.size] = var_16a81c74ce61860e;
    }

    return;
  }

  switch (var_7fa848e5b3bbc437) {
    case 0:
      return;
    case 1:
      foreach(player in winners) {
        if(!isPlayer(player) || player iscodcaster()) {
          continue;
        }

        assert(isDefined(player.var_ae06891211af23ba));
        var_16a81c74ce61860e = spawnStruct();
        var_16a81c74ce61860e.ref = player.var_ae06891211af23ba;
        var_16a81c74ce61860e.player = player;
        level.var_6b11625abe5346b0[level.var_6b11625abe5346b0.size] = var_16a81c74ce61860e;
      }

      break;
    case 2:
      var_362f690d4cbfc6f3 = array_randomize(level.var_bcf7be5c24905ab9);
      winnerindex = function_8c70e1b5fb997d3a(winners);

      if(isDefined(winnerindex)) {
        foreach(ref, entry in var_362f690d4cbfc6f3) {
          var_16a81c74ce61860e = spawnStruct();
          var_16a81c74ce61860e.ref = ref;
          var_16a81c74ce61860e.player = winners[winnerindex];
          winnerindex = function_95416c93789582a9(winners, winnerindex);
          level.var_6b11625abe5346b0[level.var_6b11625abe5346b0.size] = var_16a81c74ce61860e;
        }
      }

      break;
    case 3:
      var_81b900917ca1358e = array_randomize(level.var_bcf7be5c24905ab9);
      index = 0;

      foreach(player in winners) {
        if(!isPlayer(player) || player iscodcaster()) {
          continue;
        }

        var_16a81c74ce61860e = spawnStruct();
        var_16a81c74ce61860e.ref = getarraykey(var_81b900917ca1358e, index);
        var_16a81c74ce61860e.player = player;
        level.var_6b11625abe5346b0[level.var_6b11625abe5346b0.size] = var_16a81c74ce61860e;
        index++;
      }

      break;
    default:
      return;
  }
}

function function_ebad1c4b67a19a0e() {
  level endon("<dev string:xcc>");

  while(true) {
    dvar = hashcat(@ "hash_3f0db1f9a7328433");
    dvarvalue = getDvar(dvar, "<dev string:x1c>");

    if(isDefined(dvarvalue) && dvarvalue != "<dev string:x1c>") {
      setDvar(dvar, "<dev string:x1c>");
      player = getplayerinstance(dvarvalue);

      if(!isDefined(player) && dvarvalue == 1) {
        player = level.players[0];
      }

      if(isDefined(player)) {
        foreach(ref, entry in level.var_bcf7be5c24905ab9) {
          player function_bc603bc1a49d95ea(ref);
        }
      }
    }

    dvar = hashcat(@ "hash_e3d738ab702f7f92");
    dvarvalue = getDvar(dvar, "<dev string:x1c>");

    if(isDefined(dvarvalue) && dvarvalue != "<dev string:x1c>") {
      setDvar(dvar, "<dev string:x1c>");
      player = getplayerinstance(dvarvalue);

      if(!isDefined(player) && dvarvalue == 1) {
        player = level.players[0];
      }

      if(isDefined(player)) {
        foreach(ref, entry in level.var_bcf7be5c24905ab9) {
          player function_2ec70b5bd640dbe2(ref);
        }
      }
    }

    dvar = hashcat(@ "hash_4ceb5a58a8157672");
    dvarvalue = getDvar(dvar, "<dev string:x1c>");

    if(isDefined(dvarvalue) && dvarvalue != "<dev string:x1c>") {
      setDvar(dvar, "<dev string:x1c>");
      splitval = strtok(dvarvalue, "<dev string:xc7>");

      if(splitval.size == 2) {
        player = getplayerinstance(splitval[0]);
        var_b37316fae4667b00 = splitval[1];
      } else if(splitval.size == 1) {
        player = level.players[0];
        var_b37316fae4667b00 = splitval[0];
      } else {
        continue;
      }

      if(array_contains_key(level.var_bcf7be5c24905ab9, var_b37316fae4667b00)) {
        player function_bc603bc1a49d95ea(var_b37316fae4667b00);
      }
    }

    dvar = hashcat(@ "hash_5e93c048f094d7bf");
    dvarvalue = getDvar(dvar, "<dev string:x1c>");

    if(isDefined(dvarvalue) && dvarvalue != "<dev string:x1c>") {
      setDvar(dvar, "<dev string:x1c>");
      splitval = strtok(dvarvalue, "<dev string:xc7>");

      if(splitval.size == 2) {
        player = getplayerinstance(splitval[0]);
        var_b37316fae4667b00 = splitval[1];
      } else if(splitval.size == 1) {
        player = level.players[0];
        var_b37316fae4667b00 = splitval[0];
      } else {
        continue;
      }

      if(array_contains_key(level.var_bcf7be5c24905ab9, var_b37316fae4667b00)) {
        player function_2ec70b5bd640dbe2(var_b37316fae4667b00);
      }
    }

    wait 1;
  }
}

function private getplayerinstance(playername) {
  if(!isDefined(playername) || !isDefined(level.players) || level.players.size <= 0) {
    return undefined;
  }

  foreach(player in level.players) {
    if(player.name == playername) {
      return player;
    }
  }

  return undefined;
}

function private function_bc603bc1a49d95ea(ref) {
  if(!isDefined(ref) || !array_contains_key(level.var_bcf7be5c24905ab9, ref)) {
    return;
  }

  entry = level.var_bcf7be5c24905ab9[ref];
  assert(isDefined(entry.scorefunc));
  self[[entry.scorefunc]](ref, entry.scoreparams);
  print("<dev string:xda>" + self.name + "<dev string:xee>" + ref + "<dev string:xf4>" + self.var_fb37db009207fe1a[ref] + "<dev string:xf9>" + self.var_769c9edd0782e95d[ref] + "<dev string:xfe>");
  self.var_fb37db009207fe1a[ref] = undefined;
  self.var_769c9edd0782e95d[ref] = undefined;
}

function private function_2ec70b5bd640dbe2(ref) {
  entry = level.var_bcf7be5c24905ab9[ref];
  assert(isDefined(entry.debugfunc));
  self[[entry.debugfunc]](ref, entry.scoreparams);
}

function private function_5ec9e0597a47f590(ref, params) {
  totalval = 0;
  var_cb865f93adb30293 = [];
  assert(isDefined(scripts\mp\utility\stats::getpersstat("<dev string:xbd>")));
  timesdowned = ter_op(isDefined(self.timesdowned), self.timesdowned, 0);
  var_cb865f93adb30293["<dev string:xbd>"] = scripts\mp\utility\stats::getpersstat("<dev string:xbd>");
  var_cb865f93adb30293["<dev string:x103>"] = timesdowned;
  totalval = timesdowned + scripts\mp\utility\stats::getpersstat("<dev string:xbd>") * 3;
  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = max(0, function_9bbbefe6a0debd2b(ref, totalval));
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function private function_4a6f9f6476301391(ref, params) {
  totalval = 0;
  var_cb865f93adb30293 = [];
  assert(isDefined(scripts\mp\utility\stats::getpersstat("<dev string:xbd>")));
  var_cb865f93adb30293["<dev string:xbd>"] = scripts\mp\utility\stats::getpersstat("<dev string:xbd>");

  if(scripts\mp\utility\stats::getpersstat("<dev string:xbd>") == 0) {
    totalval = 0.8;
  }

  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = totalval;
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function private function_f9cb44b2fa2cb71(ref, params) {
  totalval = 0;
  var_cb865f93adb30293 = [];

  if(isDefined(self.plundercount)) {
    scaledval = self.plundercount * function_5417d27691d41344(ref, "<dev string:x12b>");
    totalval += scaledval;
    var_cb865f93adb30293["<dev string:x12b>"] = "<dev string:x1c>" + self.plundercount + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
  }

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        scaledval = scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
        totalval += scaledval;
        var_cb865f93adb30293[param] = "<dev string:x1c>" + scripts\mp\utility\stats::getpersstat(param) + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
      }
    }
  }

  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = max(0, function_9bbbefe6a0debd2b(ref, totalval));
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function private function_176d8f69d69ec84d(ref, params) {
  var_cb865f93adb30293 = [];
  totalkills = scripts\mp\utility\stats::getpersstat("<dev string:x13b>");
  var_74ba9cc277cbe543 = scripts\mp\utility\stats::getpersstat("<dev string:x144>");
  totalval = 30 - 2 * totalkills + 30 - var_74ba9cc277cbe543;
  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = function_9bbbefe6a0debd2b(totalval);
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function function_4fd5f112e483ad54(ref, params) {
  totalval = 0;
  var_cb865f93adb30293 = [];

  if(isDefined(self.lootcachesopened)) {
    scaledval = self.lootcachesopened * function_5417d27691d41344(ref, "<dev string:x14f>");
    totalval += scaledval;
    var_cb865f93adb30293["<dev string:x14f>"] = "<dev string:x1c>" + self.lootcachesopened + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
  }

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        scaledval = scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
        totalval += scaledval;
        var_cb865f93adb30293[param] = "<dev string:x1c>" + scripts\mp\utility\stats::getpersstat(param) + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
      }
    }
  }

  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = max(0, function_9bbbefe6a0debd2b(ref, totalval));
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function private function_9c146e27d6a5e7e1(ref, params) {
  totalval = 0;
  var_cb865f93adb30293 = [];

  if(isDefined(self.brmissionscompleted)) {
    scaledval = self.brmissionscompleted * function_5417d27691d41344(ref, "<dev string:x163>");
    totalval += scaledval;
    var_cb865f93adb30293["<dev string:x163>"] = "<dev string:x1c>" + self.brmissionscompleted + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
  }

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        scaledval = scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
        totalval += scaledval;
        var_cb865f93adb30293[param] = "<dev string:x1c>" + scripts\mp\utility\stats::getpersstat(param) + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
      }
    }
  }

  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = max(0, function_9bbbefe6a0debd2b(ref, totalval));
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function private function_b12f9d6b95f241d0(ref, params) {
  totalkills = 0;
  var_cb865f93adb30293 = [];
  addcategories = ["<dev string:x17a>", "<dev string:x189>", "<dev string:x199>", "<dev string:x1a5>", "<dev string:x1b0>", "<dev string:x1bc>"];
  subtractcategories = ["<dev string:x1cb>", "<dev string:x1dc>"];

  foreach(statref in addcategories) {
    val = scripts\mp\utility\stats::getpersstat(statref);

    if(isDefined(val)) {
      totalkills += val;
      var_cb865f93adb30293[statref] = val;
    }
  }

  foreach(statref in subtractcategories) {
    val = scripts\mp\utility\stats::getpersstat(statref);

    if(isDefined(val)) {
      totalkills -= val;
      var_cb865f93adb30293[statref] = -1 * val;
    }
  }

  var_cb865f93adb30293["<dev string:x112>"] = totalkills;
  var_cb865f93adb30293["<dev string:x11b>"] = max(0, function_9bbbefe6a0debd2b(ref, totalkills));
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function function_6ab412e6faa588ea(ref, data_points) {
  totalval = 0;
  var_cb865f93adb30293 = [];

  if(isDefined(data_points)) {
    foreach(param in data_points) {
      if(isDefined(scripts\mp\utility\stats::getpersstat(param))) {
        scaledval = scripts\mp\utility\stats::getpersstat(param) * function_5417d27691d41344(ref, param);
        totalval += scaledval;
        var_cb865f93adb30293[param] = "<dev string:x1c>" + scripts\mp\utility\stats::getpersstat(param) + "<dev string:xf9>" + scaledval + "<dev string:xfe>";
      }
    }
  }

  var_cb865f93adb30293["<dev string:x112>"] = totalval;
  var_cb865f93adb30293["<dev string:x11b>"] = max(0, function_9bbbefe6a0debd2b(ref, totalval));
  function_7a384e4d0599485c(ref, var_cb865f93adb30293);
}

function private function_7a384e4d0599485c(ref, var_cb865f93adb30293) {
  debugstr = "<dev string:x1ef>" + self.name + "<dev string:xee>" + ref + "<dev string:xf4>";

  if(isDefined(var_cb865f93adb30293) && var_cb865f93adb30293.size > 0) {
    foreach(key, value in var_cb865f93adb30293) {
      debugstr += "<dev string:x20c>" + key + "<dev string:x211>" + value + "<dev string:xf4>";
    }
  }

  print(debugstr);
}

# /