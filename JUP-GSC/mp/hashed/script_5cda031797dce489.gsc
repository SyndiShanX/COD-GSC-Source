/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5cda031797dce489.gsc
*************************************************/

#using script_3583ff375ab3a91e;
#using script_6172179f6bd0769e;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_ai_gulag;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\debug;
#namespace namespace_c28694cdd56d5c1a;

function function_25a296c2ed85e35f() {
  if(!level.var_43307855f189eb31.var_82fedf664ad855eb) {
    return;
  }

  function_ff712d25592cc337();
  variationtypes = function_5b3f79c906b20510();
  level.var_43307855f189eb31.var_c8fad0c23f319e5b = [];

  foreach(variation in variationtypes) {
    level.var_43307855f189eb31.var_c8fad0c23f319e5b[variation.variationtype] = variation;
  }

  level.var_43307855f189eb31.patroltier = getdvarint(@ "hash_c2aeee6f21d5d332", 4);
}

function function_ff712d25592cc337() {
  game["dialog"]["gulag_jailer_incoming"] = "fght_jalr_gutw";
  game["dialog"]["gulag_jailer_arrived"] = "fght_jalr_guji";
}

function function_5b3f79c906b20510() {
  variationtypes = [];
  variationtypes[variationtypes.size] = "stationary_guards";
  variationtypes[variationtypes.size] = "mixed_combat";
  variationtypes[variationtypes.size] = "combat_rush";
  variationtypes[variationtypes.size] = "patrol_guards";
  variationtypes[variationtypes.size] = "jailer_guard";
  var_956d22f6fdb80ea1 = [];

  foreach(variation in variationtypes) {
    variationinfo = function_d873949dc73d9847(variation);

    if(isDefined(variationinfo)) {
      var_956d22f6fdb80ea1[var_956d22f6fdb80ea1.size] = variationinfo;
    }
  }

  return var_956d22f6fdb80ea1;
}

function function_d873949dc73d9847(variationtype) {
  if(isDefined(variationtype)) {
    var_f53e52e268d0ecbf = function_23773068308f7b86(variationtype);
    variationweight = getdvarfloat(hashcat(@ "hash_ff06b06505b0fffc", variationtype), var_f53e52e268d0ecbf);

    if(getDvar(@ "hash_865217224dbe397", "") == variationtype || variationweight > 0) {
      variationinfo = spawnStruct();
      variationinfo.weight = variationweight;
      variationinfo.variationtype = variationtype;

      switch (variationtype) {
        case #"hash_bb9a6dbe0d657692":
          variationinfo.validatefunc = &function_f90bd5ce6fe97249;
          variationinfo.initfunc = &function_609b4c8f19884c6d;
          variationinfo.var_dea1b9b1cdabf819 = &function_d19a7fa3b438d083;
          return variationinfo;
        case #"hash_c6c45a9602fd8ae1":
          variationinfo.validatefunc = &function_e1f36d119d6700f4;
          variationinfo.initfunc = &function_4e90e3f8408f39f8;
          variationinfo.var_dea1b9b1cdabf819 = &function_f72c05143dd18bda;
          return variationinfo;
        case #"hash_810f49d16cc7964c":
          variationinfo.validatefunc = &function_dbe8fab19ce67ebb;
          variationinfo.initfunc = &function_5467c6ba98a48fc7;
          variationinfo.var_dea1b9b1cdabf819 = &function_93082ea5e92e3815;
          return variationinfo;
        case #"hash_53a8ebfb578e35d6":
          variationinfo.validatefunc = &function_2f225e6f823d9505;
          variationinfo.initfunc = &function_bfc00912de655901;
          variationinfo.var_dea1b9b1cdabf819 = &function_a8bf9e61af16ba9f;
          return variationinfo;
        case #"hash_3f6c88fccde37f5c":
          variationinfo.validatefunc = &function_cd1a60f4bf6d5907;
          variationinfo.initfunc = &function_2badf4089a186133;
          variationinfo.var_dea1b9b1cdabf819 = &function_536ddeab33ff6b51;
          return variationinfo;
        default:
          variationinfo.validatefunc = &function_f90bd5ce6fe97249;
          variationinfo.initfunc = &function_609b4c8f19884c6d;
          variationinfo.var_dea1b9b1cdabf819 = &function_d19a7fa3b438d083;
          return variationinfo;
      }
    }
  }
}

function function_23773068308f7b86(variationtype) {
  if(!isDefined(variationtype)) {
    return 0;
  }

  switch (variationtype) {
    case #"hash_bb9a6dbe0d657692":
      return 0;
    case #"hash_c6c45a9602fd8ae1":
      return 0;
    case #"hash_810f49d16cc7964c":
      return 0;
    case #"hash_53a8ebfb578e35d6":
      return 0;
    case #"hash_3f6c88fccde37f5c":
      return 1;
    default:
      return 0;
  }
}

function function_89235e4fe5354b16(arena) {
  if(isDefined(level.var_43307855f189eb31.var_c8fad0c23f319e5b)) {
    var_bc2c7ebc26e6b6f = [];

    foreach(variation in level.var_43307855f189eb31.var_c8fad0c23f319e5b) {
      if(isDefined(variation.validatefunc) && [[variation.validatefunc]](arena)) {
        var_bc2c7ebc26e6b6f[var_bc2c7ebc26e6b6f.size] = variation.variationtype;
      }
    }

    variationoverride = getDvar(@ "hash_865217224dbe397", "");
    var_3cb75658113711a4 = "stationary_guards";

    if(variationoverride == "") {
      var_3cb75658113711a4 = function_9ce8f3ade5c16fb7(var_bc2c7ebc26e6b6f);
    } else if(isDefined(level.var_43307855f189eb31.var_c8fad0c23f319e5b[variationoverride])) {
      var_3cb75658113711a4 = variationoverride;
    } else {
      function_24601896fe5fa52("Invalid Variation Type given for override. Using default variation.");
    }

    var_9a8b9da48e504ed3 = level.var_43307855f189eb31.var_c8fad0c23f319e5b[var_3cb75658113711a4];

    if(isDefined(var_9a8b9da48e504ed3.initfunc)) {
      arena.currentvariation = var_9a8b9da48e504ed3;
      [[var_9a8b9da48e504ed3.initfunc]](arena);
    }
  }
}

function function_9ce8f3ade5c16fb7(validtypes) {
  weightedsum = 0;
  var_414d201bfca427a2 = [];

  foreach(validtype in validtypes) {
    variationinfo = level.var_43307855f189eb31.var_c8fad0c23f319e5b[validtype];
    assert(isDefined(variationinfo));
    variationweight = variationinfo.weight;
    weightedsum += variationweight;
    var_414d201bfca427a2[validtype] = weightedsum;
  }

  randchoice = randomfloat(weightedsum);

  foreach(validtype in validtypes) {
    if(var_414d201bfca427a2[validtype] >= randchoice) {
      return validtype;
    }
  }

  return "stationary_guards";
}

function private function_24601896fe5fa52(message) {
  if(getdvarint(@ "hash_ac25b65055b213b3", 1)) {
    logstring("AI GULAG VARIATIONS: " + message);
  }
}

function function_f90bd5ce6fe97249(arena) {
  return true;
}

function function_609b4c8f19884c6d(arena) {
  foreach(aispawn in arena.ai_structs) {
    thread function_ca641bb5167e4a5b(arena, aispawn);
  }
}

function function_ca641bb5167e4a5b(arena, aispawn, basetype, tiernum, nationality) {
  level endon("game_ended");

  if(!isDefined(basetype)) {
    basetype = "smg";
  }

  aitype = function_7f1a2e2ebe0c1693(basetype, tiernum, nationality);
  spawnlocation = aispawn.origin;

  if(!getdvarint(@ "hash_b3d7a9483362813e", 0)) {
    spawnlocation = getclosestpointonnavmesh(aispawn.origin);
  }

  agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread function_c31f3a6ef58a2928(arena);

    if(getdvarint(@ "hash_b3d7a9483362813e", 0)) {
      agent forceteleport(spawnlocation, aispawn.angles);
      agent setgoalpos(agent.origin, 32);
      agent clearpath();
      agent.fixednode = 1;
      agent thread function_b11c1964f528574b(agent, 1, agent.origin);
      return;
    }

    agent thread function_b11c1964f528574b(agent);
  }
}

function function_d19a7fa3b438d083(arena, var_536ac6b9e3d2178) {}

function function_e1f36d119d6700f4(arena) {
  return true;
}

function function_4e90e3f8408f39f8(arena) {
  foreach(aispawn in arena.ai_structs) {
    if(isstartstr(aispawn.script_noteworthy, "gulag_ai_enemy_armory")) {
      thread function_55efd2583d54df2a(arena, aispawn, undefined, 2);
      continue;
    }

    if(isstartstr(aispawn.script_noteworthy, "gulag_ai_enemy_meeting")) {
      thread function_ca641bb5167e4a5b(arena, aispawn, undefined, 2);
      continue;
    }

    if(isstartstr(aispawn.script_noteworthy, "gulag_ai_enemy_economy")) {
      thread function_55efd2583d54df2a(arena, aispawn);
      continue;
    }

    if(isstartstr(aispawn.script_noteworthy, "gulag_ai_enemy_bar")) {
      thread function_ca641bb5167e4a5b(arena, aispawn);
    }
  }
}

function function_f72c05143dd18bda(arena, var_536ac6b9e3d2178) {}

function function_dbe8fab19ce67ebb(arena) {
  return true;
}

function function_5467c6ba98a48fc7(arena) {
  foreach(aispawn in arena.ai_structs) {
    thread function_55efd2583d54df2a(arena, aispawn);
  }
}

function function_55efd2583d54df2a(arena, aispawn, basetype, tiernum, nationality) {
  level endon("game_ended");

  if(!isDefined(basetype)) {
    basetype = "smg";
  }

  aitype = function_7f1a2e2ebe0c1693(basetype, tiernum, nationality);
  spawnlocation = getclosestpointonnavmesh(aispawn.origin);
  agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread function_c31f3a6ef58a2928(arena);
    arena waittill("ai_gulag_matchStarted");
    reinforceorigin = arena.fightspawns[0].origin;
    agent thread function_a5117518725da028(agent, reinforceorigin);
  }
}

function function_93082ea5e92e3815(arena, var_536ac6b9e3d2178) {}

function function_2f225e6f823d9505(arena) {
  return true;
}

function function_bfc00912de655901(arena) {
  var_deb852aee36cbaf9 = getdvarint(@ "hash_f8fe15aaf2f77c90", 3);

  if(var_deb852aee36cbaf9 <= 0) {
    return;
  }

  respawncooldown = getdvarfloat(@ "hash_fab0873e75ed4193", 8);
  var_3c3d57fd381f981b = 0;
  spawnstructs = array_randomize(arena.ai_structs);
  basetype = undefined;

  if(namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena) && level.var_43307855f189eb31.patroltier == 4) {
    basetype = "jugg";

    if(!isDefined(level.bosses)) {
      level.bosses = [];
      namespace_817a152f5a5554f8::function_4c60c607a6e7b9ae();

      foreach(boss in level.bosses) {
        if(getdvarint(hashcat(@ "scr_", boss.name, "_disabled"), 0) > 0) {
          boss.disabled = 1;
          continue;
        }

        if(isDefined(boss.initfunc)) {
          [[boss.initfunc]](boss);
        }
      }
    }
  }

  foreach(aispawn in spawnstructs) {
    thread function_287401a3027db2bf(arena, aispawn, basetype, level.var_43307855f189eb31.patroltier, undefined, respawncooldown);
    var_3c3d57fd381f981b++;

    if(var_3c3d57fd381f981b >= var_deb852aee36cbaf9) {
      break;
    }
  }
}

function function_a8bf9e61af16ba9f(arena, var_536ac6b9e3d2178) {}

function function_287401a3027db2bf(arena, aispawn, basetype, tiernum, nationality, respawncooldown) {
  level endon("game_ended");

  if(!isDefined(basetype)) {
    basetype = "smg";
  }

  agent = undefined;
  spawnlocation = aispawn.origin;
  spawnlocation = getgroundposition(spawnlocation, 12);

  if(basetype == "jugg") {
    aispawn.origin = spawnlocation;
    agent = namespace_817a152f5a5554f8::function_7f6818be5068dd4e(aispawn, "gulag");
    weapon = scripts\cp_mp\weapon::buildweapon("iw9_sm_aviktor", ["thermal01", "none", "none", "none", "silencer01_sm", "laserirsmg"], "none", "none");
    agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, weapon);
  } else {
    aitype = function_7f1a2e2ebe0c1693(basetype, tiernum, nationality);
    agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);
  }

  if(!isDefined(agent)) {
    function_24601896fe5fa52("Agent failed to spawn in arena: " + arena.gulagindex);
    return;
  }

  agent.baseaccuracy = getdvarfloat(@ "hash_3ec2e682b32338fe", 0.6);
  agent.accuracy = agent.baseaccuracy;
  agent.maxsightdistsqrd = getdvarfloat(@ "hash_1f2b18095c07fd11", 31360000);

  if(isagent(agent)) {
    agent function_c31f3a6ef58a2928(arena);
    agent.respawncooldown = respawncooldown;

    if(isDefined(arena.pathstructs) && arena.pathstructs.size > 0) {
      pathstruct = arena.pathstructs[randomint(arena.pathstructs.size)];
      startindex = function_93e03a3112114bfb(spawnlocation, pathstruct.path);
      level thread behavior_patrol([agent], pathstruct, startindex);
      return;
    }

    level thread function_b11c1964f528574b(agent);
  }
}

function function_cd1a60f4bf6d5907(arena) {
  return true;
}

function function_2badf4089a186133(arena) {
  if(!isDefined(level.bosses) && namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena) && level.var_43307855f189eb31.patroltier == 4) {
    level.bosses = [];
    namespace_817a152f5a5554f8::function_4c60c607a6e7b9ae();

    foreach(boss in level.bosses) {
      if(getdvarint(hashcat(@ "scr_", boss.name, "_disabled"), 0) > 0) {
        boss.disabled = 1;
        continue;
      }

      if(isDefined(boss.initfunc)) {
        [[boss.initfunc]](boss);
      }
    }
  }

  aispawn = undefined;

  if(getdvarint(@ "hash_fbf0c13ab4a94311", 0)) {
    aispawn = arena.var_198c1cb09f6dbfb1;
  } else {
    [aispawn] = array_randomize(arena.ai_structs);
  }

  thread function_5038458e3ceeb5bd(arena, aispawn);
}

function function_5e687a5a783b435d(jailer) {
  result = [-1, -1, -1, -1];
  index = 0;

  foreach(player in jailer.gulagarena.arenaplayers) {
    if(index == 4) {
      break;
    }

    if(isDefined(player)) {
      result[index] = float(player getentitynumber());
      index++;
    }
  }

  return result;
}

function function_5038458e3ceeb5bd(arena, aispawn) {
  level endon("game_ended");
  arena endon("matchEnded");
  arena endon("fight_over");
  spawnlocation = aispawn.origin;
  spawnlocation = getgroundposition(spawnlocation, 12);
  aispawn.origin = spawnlocation;
  tiernum = level.var_43307855f189eb31.patroltier;
  var_e46e01e060830b0 = getdvarfloat(@ "hash_28fc993237fc1087", 30);
  var_5f9b4fd184dcb3a2 = max(0, getdvarfloat(@ "hash_c75fae28e8a2210e", 6));
  delaytime = max(0, var_e46e01e060830b0 - var_5f9b4fd184dcb3a2);
  wait delaytime;

  if(namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena) && isarray(arena.arenaplayers)) {
    foreach(player in arena.arenaplayers) {
      player namespace_ad49798629176e96::function_696f54da8fcb6bbe("gulag_jailer_incoming", arena);
    }
  }

  wait var_5f9b4fd184dcb3a2;

  if(tiernum == 4) {
    agent = namespace_817a152f5a5554f8::function_7f6818be5068dd4e(aispawn, "gulag");
  } else {
    basetype = "shotgun";
    aitype = function_7f1a2e2ebe0c1693(basetype, tiernum);
    agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);
  }

  if(!isDefined(agent)) {
    function_24601896fe5fa52("Agent failed to spawn in arena: " + arena.gulagindex);
    return;
  }

  weapon = undefined;
  weaponchoice = getDvar(@ "hash_b29e4f282f8eea21", "");

  switch (weaponchoice) {
    case #"hash_900cb96c552c5e8e":
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_sm_aviktor", ["thermal01", "none", "none", "none", "silencer01_sm", "none"], "none", "none");
      break;
    case #"hash_40a94c5d9e4e265b":
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
      break;
    case #"hash_23209741b93850b5":
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_sh_charlie725_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    default:
      break;
  }

  body = undefined;
  head = undefined;
  helmet = undefined;

  if(tiernum < 4) {
    body = "body_sp_opforce_shadow_company_elite_3_1";
    head = "head_sp_opforce_shadow_company_elite_3_1";
    helmet = getdvarint(@ "hash_beb5c0190b33fea0", 10);
  } else {
    helmet = getdvarint(@ "hash_beb5c0190b33fea0", 1500);
  }

  armor = getdvarint(@ "hash_882a30a0c7844f34", 3400);
  agent scripts\mp\mp_agent::set_agent_health(getdvarint(@ "hash_971882d628502def", 100));
  grenade_type = getdvarint(@ "hash_617969f5d3fa5bb5", "frag_grenade_mp");
  grenadeammo = getdvarint(@ "hash_6529e1ace08f3f17", 0);
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmet, 1);
  agent.sweepscalar = getdvarfloat(@ "hash_727c76a293d85e6f", 4);
  agent.maxsightdistsqrd = getdvarfloat(@ "hash_fa26f07d026720be", 12250000);
  agent.var_2626d6897d71b728 = getdvarfloat(@ "hash_57f1a5678a01b7eb", 12250000);
  agent.var_b4e73b5c37fe850f = getdvarint(@ "hash_8b0d1bd49a4054b5", 0);
  agent setcanusecover(0);
  agent.goalradius = getdvarint(@ "hash_d9a7939c74c23d34", 3200);
  agent.script_goalradius = agent.goalradius;
  agent.ballowexecutions = getdvarint(@ "hash_52d3883d39c08659", 1);
  agent.minpaindamage = getdvarint(@ "hash_289b813a732c2672", 450);
  agent.pursueruncooldown = getdvarint(@ "hash_61ec5d7484718bc9", 500);
  agent.var_7d606bec79308eb5 = getdvarint(@ "hash_a0b1e91f87faf171", 768);
  agent.pursuestopdistance = getdvarint(@ "hash_f2334aa4fa920550", 512);
  agent.var_a67833fea11a521c = getdvarint(@ "hash_95a0623d74d35620", 128);
  agent.var_427cbd3288a2f59 = getdvarint(@ "hash_cb0a08edcac4931d", 128);
  agent.var_789bf98b36e292db = getdvarint(@ "hash_34a27361609efe2f", 1000);
  agent.var_7878ef8b36bc3525 = getdvarint(@ "hash_347f81616078d541", 500);
  var_4aaf2fa9e5d0f74a = 8;
  activetime = getdvarfloat(@ "hash_8be34599dfa102b8", 30) + getdvarfloat(@ "hash_1ff83f4f24656c5b", 30) - getdvarfloat(@ "hash_28fc993237fc1087", 25) + var_4aaf2fa9e5d0f74a;
  function_1b688b532168cd14(&function_5e687a5a783b435d);
  agent function_e451eecc3a7441c3("default", activetime);
  agent.gulagjailer = 1;
  agent.gulagarena = arena;
  agent.var_2a3ca6fc2d0e1cdc = agent.armorhealth + agent.maxhealth;
  agent.sweeptime = getdvarint(@ "hash_2e956fd207e71d5a", 5);
  level.var_c0f958f7943f0cde = &function_d6bf9d11fd14acbc;
  agent function_450e0e26617a68f();
  var_6cfb886a97484c55 = [];
  var_6cfb886a97484c55[var_6cfb886a97484c55.size] = "wz_gulag_jailer_death_a";
  var_6cfb886a97484c55[var_6cfb886a97484c55.size] = "wz_gulag_jailer_death_b";
  var_6cfb886a97484c55[var_6cfb886a97484c55.size] = "wz_gulag_jailer_death_c";
  var_6cfb886a97484c55[var_6cfb886a97484c55.size] = "wz_gulag_jailer_death_d";
  agent.deathstate = "animscripted";
  agent.deathalias = random(var_6cfb886a97484c55);

  if(isagent(agent)) {
    agent scripts\mp\gametypes\br_twotwo_gulag::function_82eee32bb4c490d8(arena);

    if(istrue(level.var_43307855f189eb31.var_6712560a5ef54a88)) {
      agent.nocorpse = 1;
    }

    arena notify("Jailer_Spawned");
    agent.ignoreall = 1;
    agent playLoopSound("mus_jugg_01_hp");
    agent setclothtype(#"nylon");
    agent setgeartype(#"scubagr");
    agent function_3f32b2ac35f3ea96(arena);
    level thread function_dabf898f5f2a99e5(agent, arena);
    agent.ignoreall = 0;
  }
}

function function_536ddeab33ff6b51(arena) {}

function function_450e0e26617a68f() {
  if(!getdvarint(@ "hash_3019c51aaa25b462", 0)) {
    return;
  }

  arena = self.gulagarena;
  gulagplayers = array_combine(arena.arenaplayers, arena.jailedplayers);

  foreach(player in gulagplayers) {
    player setclientomnvar("ui_br_twotwo_gulag_jailer_health", 100);
  }
}

function function_d6bf9d11fd14acbc(idamage) {
  if(isDefined(self.var_2a3ca6fc2d0e1cdc) && isDefined(idamage) && idamage >= 0 && getdvarint(@ "hash_3019c51aaa25b462", 0)) {
    var_c047deea265f1e49 = self.health + self.armorhealth;
    var_8c3ce3103e9d62ef = int(ceil(var_c047deea265f1e49 / self.var_2a3ca6fc2d0e1cdc * 100));
    arena = self.gulagarena;
    gulagplayers = array_combine(arena.arenaplayers, arena.jailedplayers);

    foreach(player in gulagplayers) {
      player setclientomnvar("ui_br_twotwo_gulag_jailer_health", var_8c3ce3103e9d62ef);
    }
  }
}

function function_3f32b2ac35f3ea96(arena) {
  var_7408385ae587ebad = [];
  var_7408385ae587ebad[var_7408385ae587ebad.size] = "wz_gulag_jailer_enter_a";
  var_7408385ae587ebad[var_7408385ae587ebad.size] = "wz_gulag_jailer_enter_b";
  var_7408385ae587ebad[var_7408385ae587ebad.size] = "wz_gulag_jailer_enter_c";
  var_7408385ae587ebad[var_7408385ae587ebad.size] = "wz_gulag_jailer_enter_d";
  var_feb9ded19a11d621 = [];
  var_feb9ded19a11d621[var_feb9ded19a11d621.size] = "wz_gulag_jailer_enter_doors_a";
  var_feb9ded19a11d621[var_feb9ded19a11d621.size] = "wz_gulag_jailer_enter_doors_b";
  var_feb9ded19a11d621[var_feb9ded19a11d621.size] = "wz_gulag_jailer_enter_doors_c";
  var_feb9ded19a11d621[var_feb9ded19a11d621.size] = "wz_gulag_jailer_enter_doors_d";
  var_f019f5897a011c52 = randomint(4);
  self.animationarchetype = "juggernaut";
  startpos = arena.var_198c1cb09f6dbfb1.origin;
  startangles = arena.var_198c1cb09f6dbfb1.angles;
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_7408385ae587ebad[var_f019f5897a011c52]);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animstartpos = getstartorigin(startpos, startangles, xanim);
  animstartangles = getstartangles(startpos, startangles, xanim);
  self forceteleport(animstartpos, animstartangles);
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  self dontinterpolate();

  foreach(player in arena.arenaplayers) {
    player delaycall(0.1, &setplayermusicstate, "mx_mp_br_gulag_juggernaut");
    player delaythread(2.3, &scripts\mp\hud_message::showsplash, "br_twotwo_gulag_jailer_spawn");

    if(istrue(level.var_43307855f189eb31.var_41ba817a6aa8ea0a)) {
      player delaythread(3.5, &namespace_ad49798629176e96::function_696f54da8fcb6bbe, "gulag_jailer_arrived", arena);
    }
  }

  arena.var_945ac0df95f159b3 scriptmodelplayanimdeltamotionfrompos(var_feb9ded19a11d621[var_f019f5897a011c52], arena.var_198c1cb09f6dbfb1.origin, arena.var_198c1cb09f6dbfb1.angles);
  self aisetanim("animscripted", animindex);
  self animmode("noclip");
  anim_length = getanimlength(xanim);
  wait anim_length;
  thread function_c7e36fcf1462f9af(arena);
  var_3d698930d3181f40 = function_b6d4a15b2927be20(arena);
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "wz_gulag_jailer_well_walk_forward");
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animstartpos = getstartorigin(startpos, startangles, xanim);
  animstartangles = getstartangles(startpos, startangles, xanim);
  self forceteleport(animstartpos + (0, 0, 8), animstartangles);
  self dontinterpolate();
  self aisetanim("animscripted", animindex);
  self animmode("noclip");
  anim_length = getanimlength(xanim);
  wait anim_length;
  scripts\asm\asm_bb::bb_clearanimScripted();
}

function function_c7e36fcf1462f9af(arena) {
  var_b14b8cdc38138db8 = 160;
  var_59d38865512dcbf9 = 10;
  var_78a3d5c778457697 = 75;
  impulse_scaler = 600;
  var_d88864d300c4668d = 1100;
  var_96db99f7468f1547 = [];

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }

    var_9d6746d0624b17fb = distance2d(player.origin, arena.var_198c1cb09f6dbfb1.origin);
    var_785b4da79140e397 = abs(player.origin[2] - arena.var_198c1cb09f6dbfb1.origin[2]);

    if(var_9d6746d0624b17fb < var_b14b8cdc38138db8 && var_785b4da79140e397 <= var_59d38865512dcbf9) {
      var_96db99f7468f1547[var_96db99f7468f1547.size] = player;
    }
  }

  foreach(player in var_96db99f7468f1547) {
    impulsevec = undefined;
    var_9d6746d0624b17fb = distance2d(player.origin, arena.var_198c1cb09f6dbfb1.origin);
    impulsevec = vectorNormalize(player.origin - arena.var_198c1cb09f6dbfb1.origin) * ter_op(var_9d6746d0624b17fb < var_78a3d5c778457697, var_d88864d300c4668d, impulse_scaler);
    player setvelocity(impulsevec);
  }

  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(arena.var_198c1cb09f6dbfb1.origin, undefined, 3.5, var_b14b8cdc38138db8);
}

function function_b6d4a15b2927be20(arena) {}

function function_dabf898f5f2a99e5(agent, arena) {
  agent endon("death");
  scripts\mp\ai_behavior::function_1670c315976c767b();
  wait 1;
  agent.meleechargedistvsplayer = 100;
  agent.meleechargedist = 100;

  if(getdvarint(@ "hash_8bf4874031af778a", 0)) {
    function_411c2b5ec5acd20a(agent, arena);
  }
}

function function_1b065d8d74e9eb4c(agent, arena) {
  var_a28aceeaa1666056 = getdvarint(@ "hash_8d0b6a1b71c97774", 100);
  cooldowntimesweep = getdvarint(@ "hash_2be23112df934cb6", 8);
  sweepdebug = getdvarint(@ "hash_f31e28c193ae06a", 0);
  var_8b9c7217fe2ae0e8 = getdvarint(@ "hash_47d84e982292419c", 1);

  while(true) {
    while(!agent.baimedataimtarget) {
      waitframe();
    }

    if(var_8b9c7217fe2ae0e8) {
      agent thread scripts\common\cap::cap_start("cap_jugg_sweep", "caps/common/cap_jugg_sweep");
      agent waittill("cap_exit_completed");
      continue;
    }

    shootfrompos = agent getshootfrompos();
    targetposstruct = agent getshootpos(shootfrompos);
    initialtargetpos = undefined;

    if(isDefined(targetposstruct)) {
      initialtargetpos = targetposstruct.shootpos;
    } else {
      initialtargetpos = agent lastknownpos(agent.enemy);
    }

    forwardvec = vectorNormalize(initialtargetpos - shootfrompos);
    agent.dontmelee = 1;
    agent setbtgoalpos(3, agent.origin);
    fakegoalorigin = forwardvec * 100 + shootfrompos;
    fakegoalent = spawn_script_origin(fakegoalorigin);

    if(sweepdebug) {
      thread scripts\mp\utility\debug::drawsphere(fakegoalent.origin, 25, 5, (0, 1, 0));
    }

    level thread function_32308e52ccff8164(fakegoalent, agent);
    agent setentitytarget(fakegoalent);
    waitframe();
    forwardangles = vectortoangles(forwardvec);
    forwardyaw = forwardangles[1] + var_a28aceeaa1666056;
    translationvec = anglesToForward((0, forwardyaw, 0)) * distance2d(fakegoalorigin, shootfrompos);
    finaltargetpos = fakegoalorigin + translationvec;

    if(sweepdebug) {
      thread scripts\mp\utility\debug::drawsphere(finaltargetpos, 25, 5, (0, 1, 1));
    }

    fakegoalent moveTo(finaltargetpos, agent.sweeptime);
    wait agent.sweeptime;
    agent forcereloading();
    agent.bulletsinclip = 0;
    agent.dontevershoot = 1;
    agent clearentitytarget();
    fakegoalent delete();
    agent setgoalpos(agent.origin, 10000);
    agent.dontmelee = 0;
    wait cooldowntimesweep;
    agent.dontevershoot = 0;
  }
}

function function_32308e52ccff8164(fakegoalent, agent) {
  fakegoalent endon("death");
  agent waittill("death");
  fakegoalent delete();
}

function function_411c2b5ec5acd20a(agent, arena) {
  var_56cd131a91453511 = getdvarfloat(@ "hash_15ec5f864d15e41d", 0.5);
  var_6fa953e577adc01e = getdvarfloat(@ "hash_e54d8527ee6a429a", 0.4);
  var_600a0cc182c41cbd = getdvarfloat(@ "hash_1a17d98123e7f319", 0.1);
  var_de3194c9477b34 = getdvarfloat(@ "hash_ecaa9bfa3f51c620", 10);

  while(true) {
    utilityscores = [];
    var_8980dd54afd4cd16 = 0;
    var_b5bc250d2565700a = 0;
    var_d0c5a54a30143b50 = [];
    var_62f96d9fb747538f = [];
    var_7a9097c1cbfc3bde = [];

    foreach(player in arena.arenaplayers) {
      if(isalive(player)) {
        var_b47a8cc2e1180256 = array_contains(arena.var_801cdcfadc4d465c, player);
        playerid = player getentitynumber();
        var_62f96d9fb747538f = array_add(var_62f96d9fb747538f, player);

        if(var_b47a8cc2e1180256) {
          var_8980dd54afd4cd16++;
        } else {
          var_8980dd54afd4cd16--;
        }

        if(isDefined(player.var_a6e0850023a9d8f9)) {
          if(!isDefined(player.var_9ead71e797f9eebb)) {
            player.var_9ead71e797f9eebb = 0;
          }

          var_d0c5a54a30143b50[playerid] = player.var_a6e0850023a9d8f9 - player.var_9ead71e797f9eebb;
          var_b5bc250d2565700a += var_d0c5a54a30143b50[playerid];
          player.var_9ead71e797f9eebb = player.var_a6e0850023a9d8f9;
        }
      }
    }

    var_62f96d9fb747538f = sortbydistance(var_62f96d9fb747538f, agent.origin);
    var_86380489b943a379 = -1;
    var_22c69a24a1ad0d6a = undefined;

    for(index = 0; index < var_62f96d9fb747538f.size; index++) {
      player = var_62f96d9fb747538f[index];
      playerid = player getentitynumber();
      utilityscores[playerid] = 0;

      if(!istrue(arena.onevone)) {
        var_b47a8cc2e1180256 = array_contains(arena.var_801cdcfadc4d465c, player);

        if(var_b47a8cc2e1180256 && var_8980dd54afd4cd16 > 0) {
          utilityscores[playerid] += var_56cd131a91453511;
        } else if(!var_b47a8cc2e1180256 && var_8980dd54afd4cd16 < 0) {
          utilityscores[playerid] += var_56cd131a91453511;
        }
      }

      if(isDefined(var_d0c5a54a30143b50[playerid]) && var_b5bc250d2565700a > 0) {
        var_15dbe60970aab166 = var_d0c5a54a30143b50[playerid] / var_b5bc250d2565700a * var_6fa953e577adc01e;
        utilityscores[playerid] += var_15dbe60970aab166;
      }

      var_d6f25d5146ebeba0 = (var_62f96d9fb747538f.size - index) / var_62f96d9fb747538f.size * var_600a0cc182c41cbd;
      utilityscores[playerid] += var_d6f25d5146ebeba0;

      if(utilityscores[playerid] > var_86380489b943a379) {
        var_86380489b943a379 = utilityscores[playerid];
        var_22c69a24a1ad0d6a = player;
      }
    }

    if(isDefined(var_22c69a24a1ad0d6a)) {
      agent agentsetfavoriteenemy(var_22c69a24a1ad0d6a);
      agent setgoalentity(var_22c69a24a1ad0d6a);
    }

    wait var_de3194c9477b34;
  }
}

function function_93e03a3112114bfb(origin, path) {
  if(!isDefined(path) || path.size < 1) {
    return undefined;
  }

  index = undefined;
  dist = undefined;

  foreach(i, node in path) {
    newdist = distancesquared(node.origin, origin);

    if(!isDefined(dist) || newdist < dist) {
      dist = newdist;
      index = i;
    }
  }

  return index;
}

function function_62729cb2f806997a(arena, aispawn, basetype) {
  level endon("game_ended");
  respawncooldown = self.respawncooldown;

  if(isDefined(respawncooldown)) {
    wait respawncooldown;
  }

  level thread function_287401a3027db2bf(arena, aispawn, basetype, level.var_43307855f189eb31.patroltier, undefined, respawncooldown);
}