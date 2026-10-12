/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_twotwo_gulag.gsc
****************************************************/

#using script_2d9d24f7c63ac143;
#using script_3583ff375ab3a91e;
#using script_5bab271917698dc4;
#using script_5bc60484d17fa95c;
#using script_5cda031797dce489;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_ai_gulag;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#namespace br_twotwo_gulag;
#using_animtree("script_model");

function function_b7a198c3929006d7() {
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("prepGulagArena", &function_f4ac4c4f63924776);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("startGulagSequence", &function_8739234ffe5b08f5);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagKeyAcquired", &function_b5ec51ac542c7638);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("canPlayerSpectateGulag", &function_bb22cae6dd0b7899);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("shouldPlayerSpectateGulag", &function_1a16ae715c7d1d44);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagWinSequence", &function_669067932a658a0b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagLoseSequence", &function_8fe77205a38f1c50);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("getArenaLoadout", &function_3cbf68ef6c5ca981);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagOnPlayerKilled", &function_ed93a4074bbf2e51);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagCanPlayerDropKey", &function_452ab051852e4df1);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagOvertimeStart", &function_7873119d67c51a6d);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagTrackPlayerBulletHitAI", &function_9b688cc3fce07e4f);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagTrackPlayerBulletHitPlayer", &function_9b688cc3fce07e4f);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetMatchDuration", &function_f0e6f4161c97d369);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetMaxPlayers", &function_ccad0db0adae4784);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagIsMatchPending", &function_4e8443eb7352ffd4);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetClosedCircleIndex", &function_50019571d7c08658);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetOvertimeLength", &function_f592babbd034685b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetCountdownLength", &function_f12807f1bed9e2cb);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagIsOneTeamLeft", &function_86be51018a07870c);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagJailTimeout", &function_11b53584ec3dbc7b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagLeftoverJailTimeout", &function_b628764ab30b26ce);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetVictoryWait", &function_dbee0792574758d3);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetPostVictoryWait", &function_4925efb18ecce08d);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulag_startWaitingStartTime", &function_9b2d3873cc90a014);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulag_initPlayerArena", &function_e552fdbccca8f866);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("onGulagJailTimeout", &function_1fc65ff42afbb7fc);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("setGulagJailTimeoutVariation", &function_7f7b72ed922a1c24);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("unsetGulagJailTimeoutVariation", &function_df994a817536ae7b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("isGulagJailTimeoutVariation", &function_cf70188e00c433c4);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("setGulagVariationTeams", &function_90b1506ebceed929);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagOnPlayerDisconnect", &function_cfcc53a5d95fd20a);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagOrderArenaPlayers", &function_f8cbcfc051af262b);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagLostOverlay", &function_796bad56de4895fa);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagGetWinSplashName", &function_cea3949e01c439c6);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagJailRockAmount", &function_f1b80997f5c5a401);
  namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagWatchPlayerDeath", &function_4fa43f06faeee96c);

  if(namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8()) {
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagHandleLossInfiniteLate", &function_ccf74b81f01f0bf1);
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853("gulagHandleLossInfiniteWatchDeath", &function_ccf74b81f01f0bf1);
  }

  namespace_eb17b46cdcb98eea::function_f6796774d7a9535b("gulag2v2Teams");
  level function_93add0b65db9f722(&function_c525d1df15d88a84);
  function_ed63c88560ad9ba9();
  level thread function_ecf124f447ced0aa();

  if(!isDefined(level.supportsai)) {
    thread scripts\mp\ai_mp_controller::init();
  }

  if(namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8()) {
    level thread function_d8668dbedd47d5de();
  }

  function_3b5e4d861cd09132(%wz_gulag_player_acknowledge_r, "wz_gulag_player_acknowledge_r");
  function_3b5e4d861cd09132(%wz_gulag_player_acknowledge_l, "wz_gulag_player_acknowledge_l");
  function_3b5e4d861cd09132(%wz_gulag_player_acknowledge_r_pistol, "wz_gulag_player_acknowledge_r_pistol");
  function_3b5e4d861cd09132(%wz_gulag_player_acknowledge_l_pistol, "wz_gulag_player_acknowledge_l_pistol");
  level thread function_25a296c2ed85e35f();
  level.var_f684d37d5503eeba = spawnStruct();
  level.var_f684d37d5503eeba.var_b61a334ec66db6a9 = getdvarint(@ "hash_c973ffc21381cf54", 7);
  level.var_f684d37d5503eeba.var_1d8a378e37a1b6e5 = getdvarint(@ "hash_c6069a2a8998f630", 16);
  level.var_f684d37d5503eeba.var_4bd43e30441ecbe3 = getdvarint(@ "hash_40e04bb0cf289d6a", 0);
  level.var_f684d37d5503eeba.var_c47a1bff68eb4112 = getdvarint(@ "hash_fcb9b4a4f5c268fa", 2);
  level.var_f684d37d5503eeba.var_d5a4802dae58c710 = getdvarint(@ "hash_6a86d65c91d3cb93", 1);
  level.var_f684d37d5503eeba.var_b50451c7ab918479 = getdvarint(@ "hash_fc598be0504b0679", 2);
  level.var_f684d37d5503eeba.var_399b78e251f76cb8 = getscriptbundle(getDvar(@ "hash_49c6b2cc940a4bc5", "gulagcircleloadouts:jup_br_bigmap_gulag_circle_loadouts"));
}

function function_ed63c88560ad9ba9() {
  game["dialog"]["twotwo_gulag_jailer_dead"] = "fght_jalr_gujd";
  game["dialog"]["twotwo_gulag_allies_all_dead"] = "fght_jalr_gbad";
  game["dialog"]["twotwo_gulag_enemies_all_dead"] = "fght_jalr_gbed";
}

function function_3b5e4d861cd09132(var_b1e6fbabce1a26ba, var_41503cd028efb569) {
  if(!isDefined(var_41503cd028efb569)) {
    return;
  }

  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"][var_41503cd028efb569] = var_b1e6fbabce1a26ba;
  level.scr_eventanim["player"][var_41503cd028efb569] = var_41503cd028efb569;
}

function function_ecf124f447ced0aa() {
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("second_chance_door_dom_gulag", &function_15ae52c5e218380a);
  idcount = 0;

  foreach(arena in level.gulag.arenas) {
    arena.escapestructs = [];
    arena.keys = [];
    arena.var_45e35b44ec23ab43 = [];
    arena.lootpickedup = [];
    arena.cameralocations = [];
    arena.var_6d4e3b180776136f = [];
    arena.var_2c4104d74359893b = [];
    arena.var_aeac6a7f3fb3167f = [];
    arena.var_601cd7609bcc2ec2 = [];
    arena.var_2a7e62879a75ffe = [];
    arena.var_49e6d5114201a22b = [];
    arena.var_c8ada8b232d73a0a = [];
    arena.ai_structs = [];
    arena.var_5b4f59070035f64e = [];
    arena.audio_struct = undefined;
    arena.var_198c1cb09f6dbfb1 = undefined;
    arena.id = idcount;
    idcount++;

    if(level.var_43307855f189eb31.var_732a414f682801cc) {
      arena.lootpickedup = [];
    }

    arenastructs = getStructArray(arena.target, "targetname");

    foreach(arenastruct in arenastructs) {
      if(arenastruct.script_noteworthy == "gulag_dom_escape") {
        if(level.var_43307855f189eb31.var_7ca96b105dd358df == -1) {
          if(!isDefined(arenastruct.script_parameters) || arenastruct.script_parameters != "center" || arenastruct.script_parameters == "center") {
            function_889d1ac5ae186841(arenastruct);
          }
        } else if(level.var_43307855f189eb31.var_7ca96b105dd358df == 1) {
          if(!isDefined(arenastruct.script_parameters) || arenastruct.script_parameters != "center") {
            function_889d1ac5ae186841(arenastruct);
          } else {
            function_9fb89c3e5e88656c(arenastruct, arena);
          }
        } else if(level.var_43307855f189eb31.var_7ca96b105dd358df == 0) {
          if(isDefined(arenastruct.script_parameters) && arenastruct.script_parameters == "center") {
            function_889d1ac5ae186841(arenastruct);
          } else {
            function_9fb89c3e5e88656c(arenastruct, arena);
          }
        }
      }

      if(arenastruct.script_noteworthy == "gulag_twotwo_legendary_loot_structs") {
        if(level.var_43307855f189eb31.var_cddd2b80c91e5cab != 0 && level.var_43307855f189eb31.var_cddd2b80c91e5cab < 0 || arena.keys.size < level.var_43307855f189eb31.var_cddd2b80c91e5cab) {
          arena.keys[arena.keys.size] = spawnscriptable("second_chance_drive", arenastruct.origin);
        }
      }

      if(arenastruct.script_noteworthy == "gulag_twotwo_topdown_camera1" || arenastruct.script_noteworthy == "gulag_twotwo_topdown_camera2") {
        arena.cameralocations[arena.cameralocations.size] = arenastruct;
      }

      if(arenastruct.script_noteworthy == "gulag_twotwo_jugg_spawn") {
        arena.ai_structs[arenastruct.script_index] = arenastruct;
      }

      if(arenastruct.script_noteworthy == "gulag_twotwo_jugg_spawn_alt1") {
        arena.var_5b4f59070035f64e[arena.var_5b4f59070035f64e.size] = arenastruct;
      }

      if(arenastruct.script_noteworthy == "gulag_twotwo_jugg_intro" && getdvarint(@ "hash_fbf0c13ab4a94311", 0)) {
        arena.var_198c1cb09f6dbfb1 = arenastruct;
        arena.var_945ac0df95f159b3 = spawn("script_model", arena.var_198c1cb09f6dbfb1.origin);
        arena.var_945ac0df95f159b3 setModel("generic_prop_x3");

        if(isDefined(arena.var_198c1cb09f6dbfb1.angles)) {
          arena.var_945ac0df95f159b3.angles = arena.var_198c1cb09f6dbfb1.angles;
        }

        arena.var_48404668e5582241 = spawn("script_model", arena.var_198c1cb09f6dbfb1.origin);
        arena.var_48404668e5582241 setModel("door_industrial_metal_mp_01");
        arena.var_48404668e5582241 linkTo(arena.var_945ac0df95f159b3, "j_prop_1", (0, 0, 0), (0, 0, 0));
        arena.var_48404368e5581ba8 = spawn("script_model", arena.var_198c1cb09f6dbfb1.origin);
        arena.var_48404368e5581ba8 setModel("door_industrial_metal_mp_01");
        arena.var_48404368e5581ba8 linkTo(arena.var_945ac0df95f159b3, "j_prop_2", (0, 0, 0), (0, 0, 0));
        arena.var_945ac0df95f159b3 scriptmodelplayanimdeltamotionfrompos("wz_gulag_jailer_enter_doors_a", arena.var_198c1cb09f6dbfb1.origin, arena.var_198c1cb09f6dbfb1.angles);
      }

      if(arenastruct.script_noteworthy == "gulag_twotwo_spectator") {
        arena.spectateposition = arenastruct;
      }

      if(issubstr(arenastruct.script_noteworthy, "cashSpawn")) {
        arena.var_2c4104d74359893b[arena.var_2c4104d74359893b.size] = arenastruct;
      }

      if(issubstr(arenastruct.script_noteworthy, "itemSpawn")) {
        arena.var_aeac6a7f3fb3167f[arena.var_aeac6a7f3fb3167f.size] = arenastruct;
      }

      if(issubstr(arenastruct.script_noteworthy, "voucherSpawn")) {
        arena.var_601cd7609bcc2ec2[arena.var_601cd7609bcc2ec2.size] = arenastruct;
      }

      if(arenastruct.script_noteworthy == "aud_gulag_pa") {
        arena.audio_struct = arenastruct;

        if(isvector(arena.audio_struct.origin)) {
          arena.var_5c21e504cdf8c47 = spawn("script_model", arena.audio_struct.origin);
        }
      }
    }

    if(istrue(level.var_43307855f189eb31.var_e6b8a86f7f3d8b48)) {
      namespace_ad49798629176e96::function_da0a5d9a9fc8abc2(arena);
    }

    namespace_ad49798629176e96::function_6f05f895a3054ff0(arena);
    function_ab674fc3132afe8(arena);

    if(istrue(level.var_43307855f189eb31.gasspawning)) {
      function_1b2e2fd7f80fdd0b(arena);
    }

    function_33c93a39c558a492(arena);
  }

  function_413a363a7b6e1bf4();
  function_9b254813c229a51c();

  level thread function_14d03f62839087b0();
  level thread function_1d5e2e0d6af328f7(90);
}

function function_889d1ac5ae186841(arenastruct) {
  var_a366308bf18a9167 = getStructArray(arenastruct.target, "targetname");

  foreach(var_5836bb6e49a3078e in var_a366308bf18a9167) {
    if(var_5836bb6e49a3078e.script_noteworthy == "gulag_dom_escape_doors") {
      var_3c865c6f7b13e400 = spawnscriptable("second_chance_door_dom_gulag", var_5836bb6e49a3078e.origin, var_5836bb6e49a3078e.angles);
    }
  }
}

function function_9fb89c3e5e88656c(arenastruct, arena) {
  arena.escapestructs[arena.escapestructs.size] = arenastruct;
  var_a366308bf18a9167 = getStructArray(arenastruct.target, "targetname");

  foreach(var_5836bb6e49a3078e in var_a366308bf18a9167) {
    if(var_5836bb6e49a3078e.script_noteworthy == "gulag_dom_escape_goal") {
      triggerwin = spawn("trigger_radius", var_5836bb6e49a3078e.origin, 0, var_5836bb6e49a3078e.radius, 9);
      arena.escapestructs[arena.escapestructs.size - 1].goalvolume = triggerwin;
      arenastruct thread function_740fbc412dff7c67(arena);
    }

    if(var_5836bb6e49a3078e.script_noteworthy == "gulag_dom_escape_doors") {
      if(!isDefined(arena.escapestructs[arena.escapestructs.size - 1].var_15fee21b382bfd2e)) {
        doorone = spawnscriptable("second_chance_door_dom_gulag", var_5836bb6e49a3078e.origin, var_5836bb6e49a3078e.angles);
        doorone setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
        doorone.initiallocation = doorone.origin;
        arena.escapestructs[arena.escapestructs.size - 1].var_15fee21b382bfd2e = doorone;
        continue;
      }

      doortwo = spawnscriptable("second_chance_door_dom_gulag", var_5836bb6e49a3078e.origin, var_5836bb6e49a3078e.angles);
      arena.escapestructs[arena.escapestructs.size - 1].var_9a86491b9a098194 = doortwo;
      doortwo.initiallocation = doortwo.origin;
    }
  }
}

function function_f4ac4c4f63924776(arena) {
  arena notify("arena_about_to_prep_for_next_match");
  level thread function_8cd391e5244b5670(arena);

  if(isDefined(arena.var_45e35b44ec23ab43) && arena.var_45e35b44ec23ab43.size > 0) {
    foreach(keylocation in arena.var_45e35b44ec23ab43) {
      spawnscriptable("second_chance_drive", keylocation);
    }

    arena.var_45e35b44ec23ab43 = [];
  }

  namespace_ad49798629176e96::function_15997d969114692d(arena);
  namespace_ad49798629176e96::function_394c37628afd48ef(arena);
  [arena.var_1003fa05cffaadcb, arena.var_28ddcfcec434cbf5, arena.tablename] = function_c3d75fb801e462f9(arena);
  function_5eaf324209d1c3f0();
  function_c724f178c2df7240("preLootSpawn", arena);
  function_144fc7f54908932f(arena);
  function_12801693c8c241bb(arena);
  function_687cfa994c08bada(arena);
  function_fcc8620f60ca604c(arena);
  function_b2d8f9adee070020(arena);

  if(level.var_f684d37d5503eeba.var_b50451c7ab918479 == 1) {
    function_d674739c4e4039b(arena);
  } else if(level.var_f684d37d5503eeba.var_b50451c7ab918479 == 2 && scripts\mp\gametypes\br_gulag::function_175e22055ae274a3("getEventSettings")) {
    event = scripts\mp\gametypes\br_gulag::function_d4b0eef0a0924094("getEventSettings", arena);

    if(isDefined(event)) {
      eventref = event.ref;
    }

    if(isDefined(eventref) && eventref == "cash_overflow") {
      function_d674739c4e4039b(arena, event.ref, "brloot_plunder_cash_epic_1");
    }
  }

  function_cc5468bb6e866411(arena);

  if(arena.arenaplayers.size > 2) {
    arena notify("gulag_about_to_start_camera_sequence");
    arena waittill("gulag_players_in_place_for_match_sequence");
  } else {
    thread function_731898ba8fc76e0f(arena);
  }

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player.var_4af73ce40a5d8572 = undefined;
    player.var_1578f3166bc6b5ae = [];
    player function_b9418a161c3b9ebd(arena);
  }

  if(arena.arenaplayers.size > 2) {
    foreach(p in arena.jailedplayers) {
      if(!isDefined(p)) {
        continue;
      }

      p thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_start_alert");
    }
  }
}

function function_731898ba8fc76e0f(arena) {
  wait 1;
  arena notify("gulag_about_to_start_camera_sequence");
}

function function_8739234ffe5b08f5(arena) {
  level endon("game_ended");
  arena.var_2d0904da1ac3fb61 = undefined;

  if(namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena) && level.var_43307855f189eb31.patroltier < 4) {
    var_6e5fdafe4800cd7d = "gulagai" + arena.gulagindex;
    var_1ce1b071385a88f0 = "gulagplayers" + arena.gulagindex;
    var_5c7f3cea21f3b966 = "gulagspectators" + arena.gulagindex;

    if(!threatbiasgroupexists(var_1ce1b071385a88f0)) {
      createthreatbiasgroup(var_1ce1b071385a88f0);
    }

    if(!threatbiasgroupexists(var_6e5fdafe4800cd7d)) {
      createthreatbiasgroup(var_6e5fdafe4800cd7d);
      setignoremegroup(var_5c7f3cea21f3b966, var_6e5fdafe4800cd7d);
      setthreatbias(var_6e5fdafe4800cd7d, var_1ce1b071385a88f0, 2000);
    }

    thread function_9a77e3aaa6da41c2(arena, var_6e5fdafe4800cd7d);
  }

  if(isDefined(arena.escapestructs)) {
    foreach(escapestruct in arena.escapestructs) {
      escapestruct thread function_740fbc412dff7c67(arena);
    }
  }

  if(level.var_43307855f189eb31.var_26f27e5acf1b3864) {
    namespace_ad49798629176e96::function_b57f39d9e91ebf95(arena);
  }

  if(level.var_43307855f189eb31.var_732a414f682801cc && isDefined(arena.lootpickedup) && arena.lootpickedup.size > 0) {
    namespace_ad49798629176e96::function_1794ec0dece12d2f(arena);
  }

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(istrue(level.var_43307855f189eb31.var_a30dc2ea18faa0aa)) {
      player.nocorpse = 1;
    }

    if(arena.arenaplayers.size < 4) {
      player thread scripts\mp\hud_message::showsplash("br_twotwo_one_v_one_gulag_start");
    } else {
      player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_start");
    }

    player.gulagkills = undefined;
    player.var_3a7c9a3e9aa20358 = undefined;
    player.var_d25277121d9d0a6c = undefined;
    player.var_322535086c0890fa = undefined;
    player.var_938604a8b5dd849 = undefined;
    player.var_e1ed3a7677ef1776 = undefined;

    if(isDefined(player.var_97ac1ea78faea6e3)) {
      player.var_97ac1ea78faea6e3 = undefined;
      arena.spawnbag = 1;
    }

    player namespace_ad49798629176e96::function_63776b389e7c92c1();
    player function_720ef3a3e6616ab7(0);

    if(namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena) && level.var_43307855f189eb31.patroltier < 4) {
      var_1ce1b071385a88f0 = "gulagplayers" + arena.gulagindex;
      player setthreatbiasgroup();
      player setthreatbiasgroup(var_1ce1b071385a88f0);
    }

    player thread gulagtwotwo_trackplayerbullets();
    player skydive_interrupt();
  }

  if(isDefined(arena.var_707537a8904aa962)) {
    arena.var_28a470799d66ecd7 = arena.var_707537a8904aa962.size;
  }

  if(isDefined(arena.arenaplayers)) {
    arena.var_b6b01621833467d1 = arena.arenaplayers.size;
  }

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    p setclientomnvar("ui_match_in_progress", 1);
    p setclientomnvar("ui_match_start_countdown", 0);
  }

  arena notify("ai_gulag_matchStarted");

  arena thread function_526dfbe9997544a0();
}

function function_9a77e3aaa6da41c2(arena, var_6e5fdafe4800cd7d) {
  arena endon("fight_over");
  arena endon("matchEnded");
  arena waittill("Jailer_Spawned");

  if(isDefined(arena.var_707537a8904aa962)) {
    foreach(ai in arena.var_707537a8904aa962) {
      if(isagent(ai)) {
        ai setthreatbiasgroup(var_6e5fdafe4800cd7d);
      }
    }
  }
}

function function_ccad0db0adae4784() {
  return level.var_f684d37d5503eeba.var_c47a1bff68eb4112;
}

function function_4e8443eb7352ffd4(nextmatch, arena) {
  if(level.var_43307855f189eb31.var_10c30e8082648b35 && isDefined(arena.var_654c981854394718)) {
    if(arena.var_654c981854394718.size < level.var_43307855f189eb31.var_bd9294679812b88) {
      return 0;
    } else {
      var_1ce522f5b914158b = function_53b2531fd0bb8f26(arena.var_654c981854394718);
      return var_1ce522f5b914158b;
    }

    return;
  }

  if(nextmatch.size < level.gulag.matchsize) {
    return 0;
  }

  return 1;
}

function function_53b2531fd0bb8f26(match) {
  var_1ce522f5b914158b = 0;

  foreach(player in match) {
    if(!isDefined(player)) {
      continue;
    }

    foreach(p in match) {
      if(!isDefined(p)) {
        continue;
      }

      if(player == p) {
        continue;
      }

      if(player.team == p.team) {
        continue;
      }

      var_1ce522f5b914158b = 1;
      break;
    }
  }

  return var_1ce522f5b914158b;
}

function function_413a363a7b6e1bf4() {
  if(!isDefined(level.var_f684d37d5503eeba.var_6256525d35154bec)) {
    level.var_f684d37d5503eeba.var_6256525d35154bec = [];
  }

  gulagclosedcircleindex = scripts\mp\gametypes\br_gulag::getgulagclosedcircleindex() + 1;

  if(gulagclosedcircleindex <= 0) {
    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      scripts\mp\utility\script::demoforcesre("[GULAG] gulagTwoTwo_createLoadoutsPerCircle found 0 circles in the big map with gulag enabled");
    }

    loadouttable = function_aca4803ab9e602fb();
    level.var_f684d37d5503eeba.var_6256525d35154bec = [[loadouttable]];
    return;
  }

  var_e234adf4af953b2f = level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b.size;

  for(currentcircleindex = 0; currentcircleindex < gulagclosedcircleindex; currentcircleindex++) {
    var_c606fb1446310a0d = [];

    for(i = 0; i < var_e234adf4af953b2f; i++) {
      if(level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b[i].loadouttable == "") {
        continue;
      }

      startcircleindex = int(level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b[i].circlestart);
      endcircleindex = int(level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b[i].circleend);

      if(currentcircleindex >= startcircleindex && currentcircleindex <= endcircleindex) {
        var_c606fb1446310a0d[var_c606fb1446310a0d.size] = function_564cf344e6433ffc(i);
      }
    }

    if(var_c606fb1446310a0d.size == 0) {
      scripts\mp\utility\script::demoforcesre("[GULAG] gulagTwoTwo_createLoadoutsPerCircle found no valid loadouts for circle index : " + currentcircleindex);
      loadouttable = function_aca4803ab9e602fb();
      var_c606fb1446310a0d[var_c606fb1446310a0d.size] = loadouttable;
    }

    level.var_f684d37d5503eeba.var_6256525d35154bec[level.var_f684d37d5503eeba.var_6256525d35154bec.size] = var_c606fb1446310a0d;
  }
}

function function_564cf344e6433ffc(index) {
  tablename = "classtable:" + level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b[index].loadouttable;
  numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);

  if(numloadouts > 0) {
    return tablename;
  }
}

function function_aca4803ab9e602fb() {
  var_76ec1eee373871ee = randomint(int(level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b.size));
  tablename = "classtable:" + level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b[var_76ec1eee373871ee].loadouttable;
  numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);

  if(numloadouts > 0) {
    return tablename;
  }
}

function function_f0e6f4161c97d369(arena) {
  return getdvarfloat(@ "hash_8be34599dfa102b8", 15);
}

function function_50019571d7c08658(offset) {
  return level.br_level.br_circledelaytimes.size - 1 - getdvarint(@ "scr_br_fc_circle_disable", level.gulag.circledisable) - offset;
}

function function_f592babbd034685b() {
  return getdvarint(@ "hash_1ff83f4f24656c5b", 15);
}

function function_f12807f1bed9e2cb() {
  return getdvarint(@ "hash_fb05c5f6825931d", 8);
}

function function_86be51018a07870c() {
  return false;
}

function function_11b53584ec3dbc7b() {
  return getdvarfloat(@ "hash_e5f703a38f6e8043", 1);
}

function function_b628764ab30b26ce() {
  return getdvarfloat(@ "hash_78b34f0755fae527", 94);
}

function function_dbee0792574758d3() {
  return getdvarfloat(@ "hash_6b4dac9326512a03", 4);
}

function function_4925efb18ecce08d() {
  return getdvarfloat(@ "hash_9e833e314c2b6fea", 7);
}

function function_9b2d3873cc90a014() {
  player = self;
  player.waitingstarttime = gettime();
}

function function_e552fdbccca8f866() {
  player = self;
  player.waitingduration = gettime() - player.waitingstarttime;
  player.waitingstarttime = undefined;
}

function function_7f7b72ed922a1c24(arena) {
  arena.onevone = 1;
}

function function_df994a817536ae7b(arena) {
  if(isDefined(arena.onevone)) {
    arena.onevone = undefined;
  }
}

function function_cf70188e00c433c4(arena) {
  if(istrue(arena.onevone)) {
    return 1;
  }

  return 0;
}

function function_90b1506ebceed929() {
  arena = self;
  arena.var_801cdcfadc4d465c = [];
  arena.var_af5243fbba0720c2 = [];

  if(arena.arenaplayers.size > 2) {
    arena.var_801cdcfadc4d465c[arena.var_801cdcfadc4d465c.size] = arena.arenaplayers[0];
    arena.var_af5243fbba0720c2[arena.var_af5243fbba0720c2.size] = arena.arenaplayers[1];
    arena.var_af5243fbba0720c2[arena.var_af5243fbba0720c2.size] = arena.arenaplayers[2];
    arena.var_801cdcfadc4d465c[arena.var_801cdcfadc4d465c.size] = arena.arenaplayers[3];
    arena.arenaplayers[0].twotwoteam = 1;
    arena.arenaplayers[1].twotwoteam = 2;
    arena.arenaplayers[2].twotwoteam = 2;
    arena.arenaplayers[3].twotwoteam = 1;
    arena.arenaplayers[0].gulagloadoutindex = 1;
    arena.arenaplayers[1].gulagloadoutindex = 1;
    arena.arenaplayers[2].gulagloadoutindex = 2;
    arena.arenaplayers[3].gulagloadoutindex = 2;
    arena.arenaplayers[0].var_98482020d94dbd8 = 1;
    arena.arenaplayers[1].var_98482020d94dbd8 = 2;
    arena.arenaplayers[2].var_98482020d94dbd8 = 1;
    arena.arenaplayers[3].var_98482020d94dbd8 = 2;
    teamindex = arena.id * 2 + 1;
    arena.arenaplayers[0].var_b5091efefe8e436b = level.allteamnamelist[teamindex];
    arena.arenaplayers[1].var_b5091efefe8e436b = level.allteamnamelist[teamindex + 1];
    arena.arenaplayers[2].var_b5091efefe8e436b = level.allteamnamelist[teamindex + 1];
    arena.arenaplayers[3].var_b5091efefe8e436b = level.allteamnamelist[teamindex];
  } else {
    arena.var_801cdcfadc4d465c[arena.var_801cdcfadc4d465c.size] = arena.arenaplayers[0];
    arena.var_af5243fbba0720c2[arena.var_af5243fbba0720c2.size] = arena.arenaplayers[1];
    arena.arenaplayers[0].twotwoteam = 1;
    arena.arenaplayers[1].twotwoteam = 2;
    arena.arenaplayers[0].gulagloadoutindex = 1;
    arena.arenaplayers[1].gulagloadoutindex = 1;
    arena.arenaplayers[0].var_98482020d94dbd8 = 1;
    arena.arenaplayers[1].var_98482020d94dbd8 = 1;
    teamindex = arena.id * 2 + 1;
    arena.arenaplayers[0].var_b5091efefe8e436b = level.allteamnamelist[teamindex];
    arena.arenaplayers[1].var_b5091efefe8e436b = level.allteamnamelist[teamindex + 1];
  }

  namespace_ad49798629176e96::function_36c9dc5a1d1bb023(arena);
}

function function_4fa43f06faeee96c(arena) {
  player = self;
  arena endon("matchEnded");
  player endon("disconnect");
  player endon("gulag_end");
  player endon("gulag_auto_win");
  player endon("gulagLost");
  level endon("game_ended");
  player waittill_any_2("death", "gulag_volume_win");
  player setclientomnvar("ui_br_twotwo_gulag_player_state", -1);
  arenateamplayers = function_861c9ec1a22d6aa4(player);

  if(!isDefined(arenateamplayers)) {
    return;
  }

  player thread playersetwasingulag(1);
  player.arenadeathtime = gettime();
  fightover = player function_ef6ce7fd02518720(arenateamplayers, arena);
  player function_35f647c6340ceb22(arenateamplayers, arena);
  player thread function_556e62498ec825c5(fightover, arena);
}

function function_35f647c6340ceb22(arenateamplayers, arena) {
  player = self;

  foreach(p in arenateamplayers) {
    if(!isDefined(p) || p == player || !istrue(p.gulag)) {
      continue;
    }

    p playlocalsound("mp_bodycount_tick_negative_final");
  }

  var_8e28d3d3df9a6321 = function_488428f4237c7e87(player);

  foreach(p in var_8e28d3d3df9a6321) {
    if(!isDefined(p) || !istrue(p.gulag)) {
      continue;
    }

    p playlocalsound("mp_bodycount_tick_positive_final");
  }
}

function function_ef6ce7fd02518720(arenateamplayers, arena) {
  player = self;

  if(function_cf70188e00c433c4(arena) || arenateamplayers.size < 2) {
    return 1;
  }

  fightover = 0;

  foreach(p in arenateamplayers) {
    if(p == player) {
      continue;
    }

    if(!isDefined(p)) {
      fightover = 1;
      continue;
    }

    if(!isalive(p) || !istrue(p.gulag)) {
      fightover = 1;
      continue;
    }

    p setclientomnvar("ui_br_twotwo_gulag_player_state", -1);
  }

  return fightover;
}

function function_556e62498ec825c5(fightover, arena) {
  player = self;
  level endon("game_ended");
  var_4560e1f068a68f0 = undefined;

  if(isDefined(arena.var_af5243fbba0720c2)) {
    if(player.twotwoteam == 1) {
      var_4560e1f068a68f0 = arena.var_af5243fbba0720c2;
    } else {
      var_4560e1f068a68f0 = arena.var_801cdcfadc4d465c;
    }
  }

  if(fightover) {
    foreach(p in arena.arenaplayers) {
      if(!isDefined(p) || !isDefined(p.forcespectatorclient) || p.forcespectatorclient == -1) {
        continue;
      }

      p.forcespectatorclient = -1;
    }

    arena thread function_50fc80e21e19d442();
  }

  if(!isDefined(var_4560e1f068a68f0)) {
    return;
  }

  foreach(var_2b6c9e57c112f30 in var_4560e1f068a68f0) {
    if(!isDefined(var_2b6c9e57c112f30)) {
      continue;
    }

    if(!istrue(var_2b6c9e57c112f30.gulag)) {
      continue;
    }

    if(istrue(var_2b6c9e57c112f30.var_4af73ce40a5d8572)) {
      continue;
    }

    if(fightover) {
      var_2b6c9e57c112f30 function_dc0a56e258889cb(arena, "br_twotwo_gulag_win");
      continue;
    }

    if(istrue(level.var_f684d37d5503eeba.var_4bd43e30441ecbe3)) {
      var_2b6c9e57c112f30 thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_one_enemy_left");
    }
  }

  if(fightover) {
    arena notify("matchEnded");

    foreach(p in var_4560e1f068a68f0) {
      if(!isDefined(p)) {
        continue;
      }

      if(arena.arenaplayers.size > 2) {
        p thread scripts\mp\events::killeventtextpopup(#"team_wiped", 0);
      }

      p thread namespace_ad49798629176e96::function_696f54da8fcb6bbe("twotwo_gulag_enemies_all_dead", arena);
    }

    var_d63ec8946a18fd86 = function_861c9ec1a22d6aa4(player);

    if(isDefined(var_d63ec8946a18fd86)) {
      if(var_d63ec8946a18fd86.size > 1) {
        var_d63ec8946a18fd86 = scripts\mp\utility\script::quicksort(var_d63ec8946a18fd86, &function_e4549da9da5cb20);
      }

      foreach(p in var_d63ec8946a18fd86) {
        if(!isDefined(p) || istrue(p.disconnecting)) {
          continue;
        }

        p.arenadeathtime = undefined;

        if(istrue(p.var_4af73ce40a5d8572)) {
          continue;
        }

        p thread namespace_ad49798629176e96::function_696f54da8fcb6bbe("twotwo_gulag_allies_all_dead", arena);
        p function_7aaf75a824252d97(arena, "br_twotwo_gulag_lost_death");
      }
    }
  }

  function_cc5468bb6e866411(arena);
}

function function_e4549da9da5cb20(left, right) {
  return left.arenadeathtime <= right.arenadeathtime;
}

function function_cfcc53a5d95fd20a() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(!isDefined(arena)) {
    return;
  }

  if(!isDefined(player.twotwoteam)) {
    return;
  }

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    p function_6d217ba4de4b166b(arena);
    p function_fb51bdaa21d694e5(arena);
  }

  foreach(p in arena.jailedplayers) {
    if(!isDefined(p)) {
      continue;
    }

    p function_6d217ba4de4b166b(arena);
    p function_fb51bdaa21d694e5(arena);
  }

  arenateamplayers = function_861c9ec1a22d6aa4(player);

  if(!isDefined(arenateamplayers)) {
    return;
  }

  fightover = player function_ef6ce7fd02518720(arenateamplayers, arena);
  player function_35f647c6340ceb22(arenateamplayers, arena);
  player thread function_556e62498ec825c5(fightover, arena);
}

function function_f8cbcfc051af262b(match) {
  if(match.size == 4) {
    var_6daf5c22abba2234 = undefined;
    var_ccfd4a1c9626f37c = 0;
    var_da4146d44a272f3a = 1;
    var_9e96035329b953b0 = 2;
    var_6daf5c22abba2234 = match[var_ccfd4a1c9626f37c] function_e7940d6d0cd7148a(match);

    if(isDefined(var_6daf5c22abba2234)) {
      match = match function_3682f0cc9e284d5b(var_ccfd4a1c9626f37c, var_6daf5c22abba2234);
      return match;
    } else {
      var_6daf5c22abba2234 = match[var_da4146d44a272f3a] function_e7940d6d0cd7148a(match);
    }

    if(isDefined(var_6daf5c22abba2234)) {
      match = match function_3682f0cc9e284d5b(var_da4146d44a272f3a, var_6daf5c22abba2234);
      return match;
    } else {
      var_6daf5c22abba2234 = match[var_9e96035329b953b0] function_e7940d6d0cd7148a(match);
    }

    if(!isDefined(var_6daf5c22abba2234)) {
      return match;
    } else {
      match = match function_3682f0cc9e284d5b(var_9e96035329b953b0, var_6daf5c22abba2234);
      return match;
    }

    return;
  }

  return match;
}

function function_796bad56de4895fa(player, var_40d8983fc5e5c7a5) {
  player endon("disconnect");
  player.var_4af73ce40a5d8572 = 1;
  splashname = "br_twotwo_gulag_lost_timeout";

  if(isDefined(var_40d8983fc5e5c7a5)) {
    splashname = var_40d8983fc5e5c7a5;
  }

  player thread scripts\mp\hud_message::showsplash(splashname);
  wait 3;
  player thread scripts\mp\gametypes\br_spectate::triggereliminatedoverlay();
}

function function_cea3949e01c439c6() {
  return "br_twotwo_gulag_win";
}

function function_f1b80997f5c5a401() {
  player = self;
  lootname = "brloot_rock";

  if(isDefined(level.var_275ee8bdb4df1f94)) {
    lootname = "brloot_snowball";
  }

  player scripts\mp\equipment::setequipmentammo(level.br_pickups.br_equipname[lootname], level.var_43307855f189eb31.var_5bc7dbd34df10b08);
}

function function_e7940d6d0cd7148a(match) {
  player = self;

  for(i = 0; i < match.size; i++) {
    if(player == match[i]) {
      continue;
    }

    if(player.team == match[i].team) {
      return i;
    }
  }
}

function function_3682f0cc9e284d5b(playerindex, teammateindex) {
  match = self;

  switch (playerindex) {
    case 0:
      tempval = match[teammateindex];
      match[teammateindex] = match[3];
      match[3] = tempval;
      return match;
    case 1:
      tempval = match[teammateindex];
      match[teammateindex] = match[2];
      match[2] = tempval;
      return match;
    case 2:
      tempval = match[teammateindex];
      match[teammateindex] = match[1];
      match[1] = tempval;
      return match;
    default:
      return match;
  }
}

function function_b5ec51ac542c7638() {
  player = self;
  var_f9cd7fda74e92e2a = 8;
  drawthroughgeo = 1;
  naturaldist = 500;
  maxdistance = 25000;
  var_ee1c1550f39782c4 = "ui_map_icon_key_skeleton_green";
  var_1bf1eebcab47c063 = "ui_map_icon_key_skeleton_red";
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(isDefined(arena)) {
    var_efa74c6ecaaa78d0 = function_861c9ec1a22d6aa4(player);
    var_efa74c6ecaaa78d0 = array_remove(var_efa74c6ecaaa78d0, player);
    var_7b938c58658569df = function_488428f4237c7e87(player);
    headicon = player scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_efa74c6ecaaa78d0, var_ee1c1550f39782c4, var_f9cd7fda74e92e2a, drawthroughgeo, maxdistance, naturaldist, undefined, 1, 1, undefined);

    foreach(p in var_efa74c6ecaaa78d0) {
      p thread function_5a150f2908a378cb(headicon, player);
      player thread function_e6c0858f7a0aac96(headicon, p);
    }

    headicon = player scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_7b938c58658569df, var_1bf1eebcab47c063, var_f9cd7fda74e92e2a, drawthroughgeo, maxdistance, naturaldist, undefined, 1, 1, undefined);

    foreach(p in var_7b938c58658569df) {
      p thread function_5a150f2908a378cb(headicon, player);
      player thread function_e6c0858f7a0aac96(headicon, p);
    }
  }

  player.var_43b2a82936a5e974 = 1;
  player function_a7ec5e159ce62c68();
  var_1f058c408f19eddb = function_861c9ec1a22d6aa4(player);

  if(isDefined(var_1f058c408f19eddb)) {
    foreach(p in var_1f058c408f19eddb) {
      if(!isDefined(p)) {
        continue;
      }

      p thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_got_key_ally");
    }
  }

  var_a1ffa0e77f4ae724 = function_488428f4237c7e87(player);

  if(isDefined(var_a1ffa0e77f4ae724)) {
    foreach(p in var_a1ffa0e77f4ae724) {
      if(!isDefined(p)) {
        continue;
      }

      p thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_got_key_enemy");
    }
  }

  player setclientomnvar("ui_br_special_item_acquired", 1);

  if(isDefined(arena)) {
    namespace_ad49798629176e96::function_ba5dbc7633c84a(arena);
  }
}

function function_a7ec5e159ce62c68() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  foreach(escapestruct in arena.escapestructs) {
    objective_addclienttomask(escapestruct.objid, player);
    objective_showtoplayersinmask(escapestruct.objid);
  }
}

function function_e6c0858f7a0aac96(headicon, var_ca5a607c4f7a315) {
  playershowto = self;
  level endon("game_ended");
  var_ca5a607c4f7a315 endon("watchHeadIconDelete");
  waittill_any_ents(playershowto, "death", playershowto, "disconnect", playershowto, "gulag_end", playershowto, "gulagLost");

  if(!isDefined(playershowto)) {
    return;
  }

  removeclientfromheadiconmask(headicon, playershowto);
}

function function_5a150f2908a378cb(headicon, playershowto) {
  var_ca5a607c4f7a315 = self;
  level endon("game_ended");
  waittill_any_ents(var_ca5a607c4f7a315, "death", var_ca5a607c4f7a315, "disconnect", var_ca5a607c4f7a315, "gulag_end", var_ca5a607c4f7a315, "gulagLost");
  var_ca5a607c4f7a315 notify("watchHeadIconDelete");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
}

function function_1a16ae715c7d1d44() {
  player = self;
  arenateamplayers = function_861c9ec1a22d6aa4(player);

  if(!isDefined(arenateamplayers)) {
    return 0;
  }

  fightover = 0;

  foreach(p in arenateamplayers) {
    if(!isDefined(p)) {
      fightover = 1;
      continue;
    }

    if(p == player) {
      continue;
    }

    if(!isalive(p) || !istrue(p.gulag)) {
      fightover = 1;
    }
  }

  if(fightover) {
    return 0;
  }

  return 1;
}

function function_618bf5253a72136f() {
  player = self;
  player endon("disconnect");
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(!isDefined(arena) || !isDefined(arena.time)) {
    return;
  }

  if(arena.time < 5) {
    return;
  }

  player.var_36386f3f03c2ab4b = 1;
  player setclientdvar(@ "hash_b21f1157c582ff15", 0);
  var_1f058c408f19eddb = function_861c9ec1a22d6aa4(player);
  playertospectate = undefined;

  foreach(p in var_1f058c408f19eddb) {
    if(!isDefined(p) || p == player) {
      continue;
    }

    playertospectate = p;
  }

  if(isDefined(playertospectate)) {
    player setclientomnvar("ui_show_spectateHud", playertospectate getentitynumber());
    player scripts\mp\utility\player::updatesessionstate("dead");
    player.sessionstate = "dead";
    player setclientomnvar("ui_session_state", "spectator");

    if(!isDefined(arena.cameraspectate)) {
      arena = namespace_ad49798629176e96::function_2f4344abdc200e43(self);
      spawnpoint = arena.spectateposition;
      camera = spawn("script_model", spawnpoint.origin);
      camera.angles = spawnpoint.angles;
      camera setModel("tag_origin");
      arena.cameraspectate = camera;
    }

    player cameralinkTo(arena.cameraspectate, "tag_origin", 1, 1);
  }

  waittill_any_ents_or_timeout_return(arena.time, player, "stop_gulag_spectator", level, "game_ended");

  if(!isDefined(player)) {
    return;
  }

  player cameraunlink();
  player setclientdvar(@ "hash_b21f1157c582ff15", 1);
  player.var_36386f3f03c2ab4b = undefined;
}

function function_b9418a161c3b9ebd(arena) {
  player = self;

  if(arena.arenaplayers.size > 2) {
    if(level.var_43307855f189eb31.var_4749a3b876804ae5 == 1) {
      player thread namespace_ad49798629176e96::function_63cef9bb6769f404(arena);
    } else if(level.var_43307855f189eb31.var_4749a3b876804ae5 == 2) {
      player thread namespace_ad49798629176e96::function_85b349978cd4de4f(arena);
    }

    return;
  }

  player thread namespace_ad49798629176e96::function_608e28250c9d63a9(arena);
}

function gulagtwotwo_trackplayerbullets() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulagTwoTwo_trackPlayerBullets");
  player endon("gulagTwoTwo_trackPlayerBullets");
  player endon("can_show_splashes");

  while(true) {
    player waittill("weapon_fired", objweapon);

    if(!isDefined(player.var_322535086c0890fa)) {
      player.var_322535086c0890fa = 0;
    }

    player.var_322535086c0890fa += 1;
  }
}

function function_9b688cc3fce07e4f(eattacker, var_19ef223648735f8f) {
  if(isDefined(eattacker) && istrue(eattacker.gulag) && isPlayer(eattacker)) {
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43(eattacker);

    if(isDefined(arena)) {
      if(!isDefined(eattacker.var_d25277121d9d0a6c)) {
        eattacker.var_d25277121d9d0a6c = 0;
      }

      if(!isDefined(eattacker.var_322535086c0890fa)) {
        eattacker.var_322535086c0890fa = 1;
      }

      eattacker.var_d25277121d9d0a6c = min(eattacker.var_d25277121d9d0a6c + 1, eattacker.var_322535086c0890fa);

      if(isDefined(var_19ef223648735f8f)) {
        if(!isDefined(eattacker.var_a6e0850023a9d8f9)) {
          eattacker.var_a6e0850023a9d8f9 = 0;
        }

        eattacker.var_a6e0850023a9d8f9 += var_19ef223648735f8f;
      }
    }
  }
}

function function_d8668dbedd47d5de() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait 15;

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      continue;
    }

    player kill();
  }
}

function function_740fbc412dff7c67(arena) {
  escapestruct = self;
  level endon("game_ended");

  while(true) {
    escapestruct.goalvolume waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && !istrue(player.var_4af73ce40a5d8572)) {
      if(istrue(escapestruct.dooropen)) {
        player function_7c296b84f3f04cb5(arena);
      }
    }
  }
}

function function_15ae52c5e218380a(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(player) || !isPlayer(player) || !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() || istrue(player.var_4af73ce40a5d8572)) {
    return;
  }

  if(!istrue(player.var_43b2a82936a5e974)) {
    player scripts\mp\hud_message::showerrormessage("MP/MISSING_GULAG_KEY");
    return;
  }

  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);

  if(!isDefined(arena)) {
    return;
  }

  level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(player.origin + (0, 0, 150), "revive", 1);
  instance thread function_bca70e305fb00f25(arena);
  player setclientomnvar("ui_br_special_item_acquired", 0);
  player.var_43b2a82936a5e974 = undefined;
}

function function_bca70e305fb00f25(arena) {
  var_c1057221e17f180b = self;
  var_12db0fe9902cd14b = undefined;
  var_c1057221e17f180b notify("gulagDom_DoorOpened");
  var_c1057221e17f180b endon("gulagDom_DoorOpened");
  escapestruct = undefined;

  foreach(var_5836bb6e49a3078e in arena.escapestructs) {
    if(var_5836bb6e49a3078e.var_15fee21b382bfd2e == var_c1057221e17f180b) {
      escapestruct = var_5836bb6e49a3078e;
      var_12db0fe9902cd14b = var_5836bb6e49a3078e.var_9a86491b9a098194;
      break;
    }

    if(var_5836bb6e49a3078e.var_9a86491b9a098194 == var_c1057221e17f180b) {
      escapestruct = var_5836bb6e49a3078e;
      var_12db0fe9902cd14b = var_5836bb6e49a3078e.var_15fee21b382bfd2e;
      break;
    }
  }

  if(!isDefined(escapestruct)) {
    return;
  }

  escapestruct.dooropen = 1;

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    if(isDefined(p.var_c1057221e17f180b) && p.var_c1057221e17f180b == var_c1057221e17f180b) {
      continue;
    }

    p namespace_ad49798629176e96::function_6ce94cf4eee9eab7(escapestruct);
  }

  var_c1057221e17f180b namespace_ad49798629176e96::function_80658d002f64199(var_12db0fe9902cd14b);
  wait level.var_43307855f189eb31.dooropentime;
  thread namespace_ad49798629176e96::function_51b0f4b8cbce83ad(escapestruct);
  escapestruct function_77dc965bed28a081(arena);
}

function function_67d92d9a720e2307(escapestruct) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  objective_addclienttomask(escapestruct.objid, player);
  objective_showtoplayersinmask(escapestruct.objid);
}

function function_77dc965bed28a081(arena) {
  escapestruct = self;

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p) || isDefined(p.var_c1057221e17f180b) && p.var_c1057221e17f180b == escapestruct) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(escapestruct.objid, p);
  }
}

function function_7c296b84f3f04cb5(arena) {
  player = self;
  arena thread function_50fc80e21e19d442();
  var_1f058c408f19eddb = function_861c9ec1a22d6aa4(player);
  var_a1ffa0e77f4ae724 = function_488428f4237c7e87(player);

  foreach(p in var_1f058c408f19eddb) {
    if(!isDefined(p)) {
      continue;
    }

    if(!istrue(p.gulag)) {
      continue;
    }

    if(istrue(p.var_4af73ce40a5d8572)) {
      continue;
    }

    p.var_4af73ce40a5d8572 = 1;

    if(isalive(p)) {
      p function_dc0a56e258889cb(arena, "br_twotwo_gulag_win_door");
      continue;
    }

    var_913e4d836cbd71fd = function_1bd32287885bb933(p);

    if(!isDefined(var_913e4d836cbd71fd)) {
      var_913e4d836cbd71fd = p;
    }

    p thread playergulagautowin("gulagTwoTwoVolume", var_913e4d836cbd71fd, undefined, undefined, undefined, 1);
  }

  foreach(p in var_a1ffa0e77f4ae724) {
    if(!isDefined(p)) {
      continue;
    }

    if(!istrue(p.gulag)) {
      continue;
    }

    if(istrue(p.var_4af73ce40a5d8572)) {
      continue;
    }

    p.var_4af73ce40a5d8572 = 1;
    p function_7aaf75a824252d97(arena, "br_twotwo_gulag_lost_door");
  }

  waitframe();
  arena notify("matchEnded");
  arena notify("fight_over_early");
  level handleendarena(arena);
}

function function_dc0a56e258889cb(arena, var_b6acf0c07c4311e6) {
  player = self;

  if(istrue(player.var_4af73ce40a5d8572)) {
    return;
  } else {
    player.var_4af73ce40a5d8572 = 1;
  }

  player setclientomnvar("ui_br_gulag_match_end_time", 0);
  player setclientomnvar("ui_br_twotwo_gulag_players", -1);

  if(player.sessionstate == "playing") {
    player thread gulagvictory(arena, player, 0, 0, var_b6acf0c07c4311e6, undefined, undefined, undefined, 1);
  } else {
    var_913e4d836cbd71fd = function_1bd32287885bb933(player);

    if(!isDefined(var_913e4d836cbd71fd)) {
      var_913e4d836cbd71fd = player;
    }

    player thread scripts\mp\gametypes\br_gulag::playergulagautowin("gulagTwoTwo_victory", undefined, undefined, undefined, undefined, 1, undefined, var_b6acf0c07c4311e6);
  }

  function_cc5468bb6e866411(arena);
}

function function_669067932a658a0b(arena, var_b6acf0c07c4311e6) {
  player = self;

  if(isDefined(arena) && isDefined(arena.var_654c981854394718)) {
    if(array_contains(arena.var_654c981854394718, player)) {
      arena.var_654c981854394718 = array_remove(arena.var_654c981854394718, player);
    }
  }

  player.var_4af73ce40a5d8572 = 1;
  player namespace_ad49798629176e96::function_dcead2b56fdbf3e(var_b6acf0c07c4311e6);
  player namespace_ad49798629176e96::function_3f18739ae34d9958();
  player function_720ef3a3e6616ab7(-1);
  player setthreatbiasgroup();
  player setclientomnvar("ui_br_twotwo_gulag_player_state", -1);

  if(isDefined(arena) && isDefined(arena.var_a9350ed31bec6aef)) {
    foreach(escapestruct in arena.escapestructs) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(escapestruct.objid, player);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.var_a9350ed31bec6aef, player);
  }

  player setclientomnvar("ui_br_special_item_acquired", 0);

  if(namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8()) {
    player thread function_defee99c5c401b40();
  }

  if(isDefined(arena)) {
    setovertimeomnvarenabled(arena, 0);
  }
}

function function_fe66ad4ed04f807f() {
  player = self;

  foreach(var_cc950bdc5e75f92c in player.var_61c274a3bd736bed) {
    player br_pickups::function_ebf82cde71707ec8(var_cc950bdc5e75f92c);
  }
}

function function_7aaf75a824252d97(arena, var_40d8983fc5e5c7a5) {
  player = self;

  if(istrue(player.var_4af73ce40a5d8572)) {
    return;
  } else {
    player.var_4af73ce40a5d8572 = 1;
  }

  player setclientomnvar("ui_br_gulag_match_end_time", 0);
  player setclientomnvar("ui_br_twotwo_gulag_players", -1);
  player thread gulagplayerlost(arena, var_40d8983fc5e5c7a5);
}

function function_8fe77205a38f1c50(arena, var_40d8983fc5e5c7a5) {
  player = self;

  if(isDefined(arena.var_654c981854394718)) {
    if(array_contains(arena.var_654c981854394718, player)) {
      arena.var_654c981854394718 = array_remove(arena.var_654c981854394718, player);
    }
  }

  if(!isDefined(var_40d8983fc5e5c7a5)) {
    if(!isalive(player)) {
      var_40d8983fc5e5c7a5 = "death";
    } else if(isDefined(arena.var_72b377bfe92c3499) && arena.var_72b377bfe92c3499 >= 1) {
      var_40d8983fc5e5c7a5 = "br_twotwo_gulag_lost_ladder_escape";
    } else {
      var_40d8983fc5e5c7a5 = "time_ran_out";
    }
  }

  player setclientomnvar("ui_br_twotwo_gulag_player_state", -1);

  foreach(escapestruct in arena.escapestructs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(escapestruct.objid, player);
  }

  if(isDefined(arena.var_a9350ed31bec6aef)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.var_a9350ed31bec6aef, player);
  }

  player setthreatbiasgroup();
  player namespace_ad49798629176e96::function_dcead2b56fdbf3e(var_40d8983fc5e5c7a5);
  player namespace_ad49798629176e96::function_3f18739ae34d9958();
  setovertimeomnvarenabled(arena, 0);
  function_cc5468bb6e866411(arena);

  if(!istrue(level.var_d034183abf2e274d)) {
    player namespace_aead94004cf4c147::clearbackpack();
    namespace_aead94004cf4c147::function_954372d604277278(player);
  }
}

function function_50fc80e21e19d442() {
  arena = self;
  level endon("game_ended");
  var_acffaf2e14327be0 = [];

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    body = p getcorpseentity();

    if(isDefined(body)) {
      var_acffaf2e14327be0[var_acffaf2e14327be0.size] = body;
    }
  }

  wait 5.5;

  foreach(body in var_acffaf2e14327be0) {
    if(!isDefined(body)) {
      continue;
    }

    body notify("corpse_manually_deleted");
  }
}

function function_defee99c5c401b40() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 18;

  if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    player kill();
  }
}

function function_4f4c7829487b8220(arena) {
  foreach(escapestruct in arena.escapestructs) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", escapestruct.origin + (0, 0, 60), "ui_mp_br_icon_gulag_exit_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    } else {
      println("<dev string:x1c>");
    }

    escapestruct.objid = objid;
  }
}

function function_3dc19fbe8b98e015() {
  player = self;
  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(player);
  closestvolume = arena.escapestructs[0];
  var_27c330da5d381169 = distance(closestvolume.origin, player.origin);

  foreach(escapestruct in arena.escapestructs) {
    tempdistance = distance(escapestruct.origin, player.origin);

    if(var_27c330da5d381169 > distance(escapestruct.origin, player.origin)) {
      closestvolume = escapestruct;
      var_27c330da5d381169 = tempdistance;
    }
  }

  objective_addclienttomask(closestvolume.objid, player);
  objective_showtoplayersinmask(closestvolume.objid);
}

function function_c3d75fb801e462f9(arena) {
  var_bb400f5c504d242a = [];
  currentcircleindex = level.br_circle.circleindex;

  if(!isDefined(currentcircleindex) || currentcircleindex < 0) {
    tablename = function_aca4803ab9e602fb();
    numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);
    gamemodeloadout = scripts\mp\gametypes\br::initstandardloadout(tablename, randomint(numloadouts));
    var_b749d549d1199784 = gamemodeloadout;
  } else {
    var_bb400f5c504d242a = function_9b9255a993b0fa1c(currentcircleindex);
    var_b749d549d1199784 = var_bb400f5c504d242a[0];
    var_ffb6bc4a062518fa = var_bb400f5c504d242a[1];
  }

  if(!isDefined(var_ffb6bc4a062518fa)) {
    var_ffb6bc4a062518fa = var_b749d549d1199784;
  }

  return [var_b749d549d1199784, var_ffb6bc4a062518fa];
}

function function_9b9255a993b0fa1c(currentcircleindex) {
  var_da28dd96064dd73 = [];
  circleloadoutindex = int(min(currentcircleindex, level.var_f684d37d5503eeba.var_6256525d35154bec.size));
  var_1b1f01577447e98d = randomint(int(level.var_f684d37d5503eeba.var_6256525d35154bec[circleloadoutindex].size));
  var_da28dd96064dd73[var_da28dd96064dd73.size] = var_1b1f01577447e98d;
  var_d2252a573ea13967 = var_1b1f01577447e98d + 1;

  if(var_d2252a573ea13967 >= level.var_f684d37d5503eeba.var_6256525d35154bec[circleloadoutindex].size) {
    var_d2252a573ea13967 = 0;
  }

  var_da28dd96064dd73[var_da28dd96064dd73.size] = var_d2252a573ea13967;
  var_bb400f5c504d242a = [];

  foreach(index in var_da28dd96064dd73) {
    tablename = level.var_f684d37d5503eeba.var_6256525d35154bec[circleloadoutindex][index];
    numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);
    gamemodeloadout = scripts\mp\gametypes\br::initstandardloadout(tablename, randomint(numloadouts));
    var_bb400f5c504d242a[var_bb400f5c504d242a.size] = gamemodeloadout;
  }

  return var_bb400f5c504d242a;
}

function function_91b7c321b7e78443(index) {
  var_35e87b647e77e13b = [];
  var_e234adf4af953b2f = level.var_f684d37d5503eeba.var_399b78e251f76cb8.var_9678564e7abf373b.size;

  for(i = 0; i < var_e234adf4af953b2f; i++) {
    tablename = function_564cf344e6433ffc(i);
    numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);

    for(k = 0; k < numloadouts; k++) {
      temploadout = scripts\mp\gametypes\br::initstandardloadout(tablename, k);
      var_35e87b647e77e13b[var_35e87b647e77e13b.size] = temploadout;
    }
  }

  if(index >= var_35e87b647e77e13b.size) {
    index = var_35e87b647e77e13b.size - 1;
  }

  return var_35e87b647e77e13b[index];
}

function function_3cbf68ef6c5ca981(arena) {
  player = self;

  if(player.gulagloadoutindex == 1) {
    loadout = arena.var_1003fa05cffaadcb;
  } else {
    loadout = arena.var_28ddcfcec434cbf5;
  }

  if(level.var_43307855f189eb31.var_3b156be10b96edb9) {
    loadout = arena.var_1003fa05cffaadcb;
  }

  if(level.var_43307855f189eb31.forceloadoutindex >= 0) {
    loadout = function_91b7c321b7e78443(level.var_43307855f189eb31.forceloadoutindex);
  }

  return loadout;
}

function function_1fc65ff42afbb7fc(arena, player) {
  if(!isDefined(arena.var_654c981854394718)) {
    arena.var_654c981854394718 = [];
  }

  arena.var_654c981854394718 = array_add(arena.var_654c981854394718, player);
}

function function_1b2e2fd7f80fdd0b(arena) {
  arena.gasspawnlocations = arena.var_aeac6a7f3fb3167f;
  arena.gasspawnlocations = sortbydistance(arena.gasspawnlocations, arena.center);
  arena.gasspawnlocations = array_reverse(arena.gasspawnlocations);
}

function function_33c93a39c558a492(arena) {
  var_df6698a1ad9d50bf = [];

  foreach(fightspawn in arena.fightspawns) {
    if(fightspawn.script_index == 0 || fightspawn.script_index == 1 || fightspawn.script_index == 6 || fightspawn.script_index == 7) {
      var_df6698a1ad9d50bf[var_df6698a1ad9d50bf.size] = fightspawn;
    }
  }

  var_df6698a1ad9d50bf = array_sort_by_script_index(var_df6698a1ad9d50bf);
  arena.fightspawns = var_df6698a1ad9d50bf;
}

function function_c525d1df15d88a84(agent, killer) {
  if(!isPlayer(killer)) {
    return;
  }

  arena = namespace_ad49798629176e96::function_2f4344abdc200e43(killer);

  if(!isDefined(arena)) {
    return;
  }

  if(!isDefined(killer.gulagaikills)) {
    killer.gulagaikills = 0;
  }

  killer.gulagaikills += 1;

  if(function_cf70188e00c433c4(arena)) {
    arena thread function_50fc80e21e19d442();

    foreach(player in arena.arenaplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(!istrue(player.gulag)) {
        continue;
      }

      if(istrue(player.var_4af73ce40a5d8572)) {
        continue;
      }

      player function_dc0a56e258889cb(arena, "br_twotwo_jailer_gulag_win");
    }

    return;
  }

  if(isDefined(level.var_43307855f189eb31.var_b18455b0e6b6e213)) {
    if(level.var_43307855f189eb31.var_b18455b0e6b6e213 == 1) {
      arena thread function_50fc80e21e19d442();
      arenateamplayers = function_861c9ec1a22d6aa4(killer);

      foreach(player in arenateamplayers) {
        if(!isDefined(player)) {
          continue;
        }

        if(!istrue(player.gulag)) {
          continue;
        }

        if(istrue(player.var_4af73ce40a5d8572)) {
          continue;
        }

        player function_dc0a56e258889cb(arena, "br_twotwo_jailer_gulag_win");
        player thread namespace_ad49798629176e96::function_696f54da8fcb6bbe("twotwo_gulag_jailer_dead", arena);
      }

      return;
    } else if(level.var_43307855f189eb31.var_b18455b0e6b6e213 == 2) {
      function_9135ada02e07bf10(arena, "br_twotwo_jailer_gulag_win", 1);
      return;
    }
  }

  if(istrue(level.var_43307855f189eb31.var_6efb9d0afa7efcb2) && !istrue(arena.var_2d0904da1ac3fb61)) {
    arena.var_2d0904da1ac3fb61 = 1;
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    agent thread scripts\mp\gametypes\br_pickups::function_55463a3679678e2f(dropstruct, arena);
  }
}

function function_9135ada02e07bf10(arena, victorycause, var_bd8ebd50121f174e) {
  arena thread function_50fc80e21e19d442();

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!istrue(player.gulag)) {
      continue;
    }

    if(istrue(player.var_4af73ce40a5d8572)) {
      continue;
    }

    player function_dc0a56e258889cb(arena, victorycause);

    if(istrue(var_bd8ebd50121f174e)) {
      player thread namespace_ad49798629176e96::function_696f54da8fcb6bbe("twotwo_gulag_jailer_dead", arena);
    }
  }
}

function function_ed93a4074bbf2e51(attacker) {
  if(!isPlayer(attacker)) {
    return;
  }

  if(!isDefined(attacker.gulagkills)) {
    attacker.gulagkills = 0;
  }

  attacker.gulagkills += 1;
}

function function_a4c35fe489cc7da5() {
  player = self;
  player waittill("gulag_outline_removed");

  if(isDefined(player) && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    arenateamplayers = function_861c9ec1a22d6aa4(player);

    foreach(p in arenateamplayers) {
      if(!isDefined(p) || !istrue(p.gulag) || p == player) {
        continue;
      }

      p thread namespace_ad49798629176e96::function_da46de174875958a(player, "outline_nodepth_green");
    }
  }
}

function function_720ef3a3e6616ab7(value) {
  player = self;
  player setclientomnvar("ui_br_ai_gulag_score", value);
}

function function_cc5468bb6e866411(arena) {
  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    p function_6d217ba4de4b166b(arena);
    p function_fb51bdaa21d694e5(arena);
  }

  foreach(p in arena.jailedplayers) {
    if(!isDefined(p)) {
      continue;
    }

    p function_6d217ba4de4b166b(arena);
    p function_fb51bdaa21d694e5(arena);
  }
}

function function_6d217ba4de4b166b(arena) {
  player = self;
  packedval = 0;
  var_4c096c17e2c382e1 = 0;
  var_77fa43fc5f58845d = 4;

  if(function_cf70188e00c433c4(arena)) {
    var_77fa43fc5f58845d = 2;
  }

  for(i = 0; i < var_77fa43fc5f58845d; i++) {
    p = arena.arenaplayers[i];

    if(!isDefined(p) || !p scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      playerentnum = 0;
    } else {
      playerentnum = p getentitynumber() + 1;
    }

    playerentnummax = 256 - 1;
    assert(playerentnum >= 0 && playerentnum <= playerentnummax);
    packedval += (int(playerentnum) &playerentnummax) << var_4c096c17e2c382e1;
    var_4c096c17e2c382e1 += 8;
  }

  player setclientomnvar("ui_br_twotwo_gulag_players", packedval);
}

function function_fb51bdaa21d694e5(arena) {
  player = self;
  packedval = 0;
  var_4c096c17e2c382e1 = 0;
  var_77fa43fc5f58845d = 4;

  if(function_cf70188e00c433c4(arena)) {
    var_77fa43fc5f58845d = 2;
  }

  for(i = 0; i < var_77fa43fc5f58845d; i++) {
    p = arena.arenaplayers[i];
    playerstate = function_a3404116e7794c47(player, p, arena);
    var_62b5521602cbb385 = 8 - 1;
    assert(playerstate >= 0 && playerstate <= var_62b5521602cbb385);
    packedval += (int(playerstate) &var_62b5521602cbb385) << var_4c096c17e2c382e1;
    var_4c096c17e2c382e1 += 3;
  }

  player setclientomnvar("ui_br_twotwo_gulag_players_state", packedval);
}

function function_a3404116e7794c47(player, gulagplayer, arena) {
  if(!isDefined(gulagplayer) || !gulagplayer scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return 0;
  }

  if(!isalive(gulagplayer)) {
    return 1;
  }

  if(player == gulagplayer) {
    return 3;
  }

  isplayerwaiting = array_contains(arena.jailedplayers, player);

  if(isplayerwaiting) {
    return 2;
  }

  if(gulagplayer.team == player.team) {
    return 5;
  }

  var_f3cef7e5ebad72e0 = array_contains(arena.var_801cdcfadc4d465c, gulagplayer);

  if(var_f3cef7e5ebad72e0) {
    var_eb3d6fa548fa6972 = array_contains(arena.var_801cdcfadc4d465c, player);

    if(var_eb3d6fa548fa6972) {
      return 4;
    }
  } else {
    var_55ff96a652e94ea8 = array_contains(arena.var_af5243fbba0720c2, player);

    if(var_55ff96a652e94ea8) {
      return 4;
    }
  }

  return 6;
}

function function_861c9ec1a22d6aa4(player) {
  if(!isDefined(player)) {
    return;
  }

  for(i = 0; i < level.gulag.arenas.size; i++) {
    var_f40e6deec30ee209 = level.gulag.arenas[i];

    if(isDefined(var_f40e6deec30ee209.var_801cdcfadc4d465c)) {
      foreach(arenaplayer in var_f40e6deec30ee209.var_801cdcfadc4d465c) {
        if(arenaplayer == player) {
          return var_f40e6deec30ee209.var_801cdcfadc4d465c;
        }
      }
    }

    if(isDefined(var_f40e6deec30ee209.var_af5243fbba0720c2)) {
      foreach(arenaplayer in var_f40e6deec30ee209.var_af5243fbba0720c2) {
        if(arenaplayer == player) {
          return var_f40e6deec30ee209.var_af5243fbba0720c2;
        }
      }
    }
  }

  return undefined;
}

function function_1bd32287885bb933(player) {
  if(!isDefined(player)) {
    return undefined;
  }

  allyteam = function_861c9ec1a22d6aa4(player);

  if(isDefined(allyteam)) {
    foreach(p in allyteam) {
      if(!isDefined(p)) {
        continue;
      }

      if(p != player) {
        return p;
      }
    }
  }

  return undefined;
}

function function_488428f4237c7e87(player) {
  if(!isDefined(player)) {
    return;
  }

  for(i = 0; i < level.gulag.arenas.size; i++) {
    var_f40e6deec30ee209 = level.gulag.arenas[i];

    if(isDefined(var_f40e6deec30ee209.var_801cdcfadc4d465c)) {
      foreach(arenaplayer in var_f40e6deec30ee209.var_801cdcfadc4d465c) {
        if(!isDefined(arenaplayer)) {
          continue;
        }

        if(arenaplayer == player) {
          return var_f40e6deec30ee209.var_af5243fbba0720c2;
        }
      }
    }

    if(isDefined(var_f40e6deec30ee209.var_af5243fbba0720c2)) {
      foreach(arenaplayer in var_f40e6deec30ee209.var_af5243fbba0720c2) {
        if(!isDefined(arenaplayer)) {
          continue;
        }

        if(arenaplayer == player) {
          return var_f40e6deec30ee209.var_801cdcfadc4d465c;
        }
      }
    }
  }

  return undefined;
}

function function_66ba5f24fbb13a23(player) {
  for(i = 0; i < level.gulag.arenas.size; i++) {
    var_f40e6deec30ee209 = level.gulag.arenas[i];

    foreach(jailedplayers in var_f40e6deec30ee209.jailedplayers) {
      if(jailedplayers == player) {
        arena = level.gulag.arenas[i];
        return arena;
      }
    }
  }

  return undefined;
}

function function_6e3541fd8fab45bc() {
  if(isDefined(level.var_43307855f189eb31) && level.var_43307855f189eb31.name == "gulag_twotwo") {
    return true;
  }

  return false;
}

function function_ccf74b81f01f0bf1(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  foreach(escapestruct in arena.escapestructs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(escapestruct.objid, player);
  }

  namespace_ad49798629176e96::function_ba5dbc7633c84a(arena);
  wait 12;

  if(!isDefined(player)) {
    return;
  }

  player.gulag = 0;
  player namespace_ad49798629176e96::function_3f18739ae34d9958();
  player playergulagautowin("gulagInfinite", player, undefined, undefined, undefined, 1);
  wait 12;

  if(!isDefined(player)) {
    return;
  }

  player.gulagloser = undefined;

  if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    player kill();
  }
}

function function_bb22cae6dd0b7899() {
  if(isDefined(level.var_43307855f189eb31) && istrue(level.var_43307855f189eb31.var_d06b935d7d60de61)) {
    return true;
  }

  return false;
}

function function_452ab051852e4df1() {
  player = self;

  if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && istrue(player.var_43b2a82936a5e974) && istrue(level.var_43307855f189eb31.var_ec2eaa1a4b68c0cf)) {
    return true;
  }

  return false;
}

function function_7873119d67c51a6d() {
  arena = self;
  arena endon("matchEnded");
  arena endon("fight_over");
  setovertimeomnvarenabled(arena, 1);
  arena notify("gulag_overtime_started");

  if(level.var_43307855f189eb31.overtimevariation == 1) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(arena.var_707537a8904aa962)) {
      foreach(agent in arena.var_707537a8904aa962) {
        if(!istrue(arena.var_2d0904da1ac3fb61)) {
          agent thread scripts\mp\gametypes\br_pickups::function_55463a3679678e2f(dropstruct, arena);
          arena.var_2d0904da1ac3fb61 = 1;
        }
      }
    }

    return;
  }

  if(level.var_43307855f189eb31.overtimevariation == 2) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    arena.var_2d0904da1ac3fb61 = 1;

    if(isDefined(arena.var_707537a8904aa962)) {
      foreach(agent in arena.var_707537a8904aa962) {
        agent thread scripts\mp\gametypes\br_pickups::function_55463a3679678e2f(dropstruct, arena);

        foreach(player in arena.arenaplayers) {
          player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_key_dropped");
        }

        namespace_ad49798629176e96::function_9f7b9a86a5328f0b(arena, agent.origin);
        wait 0.3;
        agent kill();
      }
    }

    return;
  }

  if(level.var_43307855f189eb31.overtimevariation == 3) {
    centralposition = getgroundposition(arena.center, 1);
    scriptable = level.br_pickups.var_838863c4848d4c26["loot_key_gulag"];
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, centralposition, (0, 0, 0), undefined, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride);
    item = scripts\mp\gametypes\br_pickups::spawnpickup(scriptable, dropinfo, 1, 1, undefined, 0);
    arena.var_6d4e3b180776136f[arena.var_6d4e3b180776136f.size] = item;

    foreach(player in arena.arenaplayers) {
      player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_key_spawned_center");
    }

    namespace_ad49798629176e96::function_9f7b9a86a5328f0b(arena, item.origin);
    playsoundatpos(centralposition, "flag_spawned");
    return;
  }

  if(level.var_43307855f189eb31.overtimevariation == 4) {
    wait level.var_43307855f189eb31.var_b1985d454f9b2200;

    if(istrue(level.var_43307855f189eb31.gasspawning)) {
      arena thread scripts\mp\gametypes\br_ai_gulag::function_5427c6229b93668e(arena.gasspawnlocations, 11, 1.2);
    }
  }
}

function function_8cd391e5244b5670(arena) {
  if(!isDefined(arena.var_707537a8904aa962)) {
    arena.aiset = 1;

    if(isDefined(arena.ai_structs)) {
      thread function_3aee652da47a2a39(arena);
    }

    arena waittill("matchEnded");
    thread function_d6b701f1cb759bd5(arena);
  }
}

function function_9b254813c229a51c() {
  category = "gulag";
  function_ba4022744dce59f6(category);
}

function function_3aee652da47a2a39(arena) {
  if(namespace_ad49798629176e96::function_d8f18f1d691c0ef8(arena)) {
    thread function_89235e4fe5354b16(arena);
  }
}

function function_d1f5aaddab74bd10(arena, aispawn) {
  aitype = "enemy_mp_smg_tier1_aq";
  spawnlocation = aispawn.origin;

  if(!getdvarint(@ "hash_b3d7a9483362813e", 0)) {
    spawnlocation = getclosestpointonnavmesh(aispawn.origin);
  }

  agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread function_82eee32bb4c490d8(arena);

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

function function_9119de486a6fa5cd(arena) {
  if(!istrue(arena.aiset)) {
    function_8cd391e5244b5670(arena);
  }
}

function function_82eee32bb4c490d8(arena) {
  if(!isDefined(arena.var_707537a8904aa962)) {
    arena.var_707537a8904aa962 = [];
  }

  arena.var_707537a8904aa962 = array_add(arena.var_707537a8904aa962, self);

  if(getdvarint(@ "hash_cef54d9e018c7722", 0)) {
    gulagplayers = array_combine(arena.arenaplayers, arena.jailedplayers);

    foreach(player in gulagplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player namespace_ad49798629176e96::function_da46de174875958a(self, "outline_nodepth_red", -1);
    }
  }
}

function function_3aad61cbc63b74c8(arena) {
  if(isDefined(arena.var_707537a8904aa962)) {
    arena.var_707537a8904aa962 = array_remove(arena.var_707537a8904aa962, self);

    if(isagent(self)) {
      self notify("jailer_stop_firing");
      self stoploopsound("mus_jugg_01_hp");

      if(isalive(self)) {
        function_dbd4cba5d524eba9(arena);
        function_28b90eb2b591003f();
      } else if(getdvarint(@ "hash_82733198d2d5b09e", 1)) {
        if(isDefined(arena.currentvariation) && arena.currentvariation.variationtype == "jailer_guard") {
          wait 10;
        }

        body = self getcorpseentity();

        if(isDefined(body)) {
          body delete();
        }
      }
    }

    if(isDefined(arena.var_707537a8904aa962) && arena.var_707537a8904aa962.size <= 0) {
      arena.var_707537a8904aa962 = undefined;
    }
  }
}

function function_dbd4cba5d524eba9(arena) {
  agent = self;
  arena endon("arena_about_to_prep_for_next_match");
  level endon("game_ended");
  var_e875263615163617 = 4;
  var_c9ec98acf0094360 = 200;
  exitposition = arena.var_198c1cb09f6dbfb1.origin + (-18, 205, -128);
  agent clearbtgoal(2);
  waitframe();

  if(!isDefined(agent)) {
    return;
  }

  agent.ignoreall = 1;
  agent function_304da84d9a815c01(exitposition, var_e875263615163617);
  agent aisetdesiredspeed(var_c9ec98acf0094360);
  starttime = gettime();
  timeout_kill = getdvarint(@ "hash_5b82b0cf2b0ff269", 10000);

  while(distance2d(agent.origin, exitposition) > 4) {
    timepassed = gettime() - starttime;

    if(timepassed >= timeout_kill) {
      break;
    }

    waitframe();
  }
}

function function_d6b701f1cb759bd5(arena) {
  if(isDefined(arena.var_707537a8904aa962)) {
    foreach(agent in arena.var_707537a8904aa962) {
      if(isagent(agent)) {
        agent thread function_3aad61cbc63b74c8(arena);
        agent setthreatbiasgroup();
      }
    }

    arena.var_707537a8904aa962 = undefined;
    arena.aiset = undefined;
  }

  wait function_86ee3121d91c59c3();
  var_2e903a90a966d9c2 = 2650;
  nearbyloot = getlootscriptablearrayinradius(undefined, undefined, arena.center, var_2e903a90a966d9c2);

  foreach(lootitem in nearbyloot) {
    if(lootitem getscriptableisreserved() && lootitem getscriptableisloot()) {
      lootitem scripts\mp\gametypes\br_pickups::deletescriptableinstance();
    }
  }
}

function function_12801693c8c241bb(arena) {
  for(i = 0; i < 10; i++) {
    arena.var_2a7e62879a75ffe[arena.var_2a7e62879a75ffe.size] = getscriptcachecontents(level.var_42706f92b61ab857, i);
  }
}

function function_144fc7f54908932f(arena) {
  for(i = 0; i < 5; i++) {
    arena.var_49e6d5114201a22b[arena.var_49e6d5114201a22b.size] = getscriptcachecontents(level.var_1d446b9562cad6cb, i);
  }
}

function function_687cfa994c08bada(arena) {
  for(i = 0; i < 3; i++) {
    arena.var_c8ada8b232d73a0a[arena.var_c8ada8b232d73a0a.size] = getscriptcachecontents(level.var_8aa2fc86861fc20c, i);
  }
}

function function_b2d8f9adee070020(arena) {
  var_7205fab5ac6f58e = 0;
  var_a29ac4899acd2c08 = arena.var_2c4104d74359893b;
  var_39ce9039c3660d76 = "";
  maxcount = 0;

  while(var_7205fab5ac6f58e < level.var_f684d37d5503eeba.var_b61a334ec66db6a9) {
    var_7205fab5ac6f58e++;
    var_9ae625e33b2fc5f6 = var_a29ac4899acd2c08.size;
    diceroll = randomint(var_9ae625e33b2fc5f6);
    var_efcce422369f16a3 = arena.var_2a7e62879a75ffe.size;
    var_d6a189deafcb31fd = randomint(var_efcce422369f16a3);
    scriptablename = arena.var_2a7e62879a75ffe[var_d6a189deafcb31fd][var_7205fab5ac6f58e - 1];

    if(!isDefined(scriptablename) || scriptablename == "") {
      var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[diceroll]);
      continue;
    }

    if(issubstr(scriptablename, "weapon")) {
      weaponname = scripts\mp\gametypes\br_pickups::getfullweaponobjfromscriptablename(scriptablename);
      pickupcount = weaponclipsize(weaponname) * 2;
    } else {
      pickupcount = level.br_pickups.counts[scriptablename];
    }

    if(!isDefined(pickupcount)) {
      pickupcount = 1;
    }

    dropinfo = spawnStruct();
    dropinfo.origin = var_a29ac4899acd2c08[diceroll].origin;
    dropinfo.angles = (0, 0, 0);
    dropinfo.payload = 0;
    lootitem = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, pickupcount);
    var_39ce9039c3660d76 = var_a29ac4899acd2c08[diceroll].script_noteworthy;
    var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[diceroll]);
    var_a29ac4899acd2c08 = function_7f32923c29bcf243(arena.var_2a7e62879a75ffe, var_a29ac4899acd2c08, scriptablename, var_39ce9039c3660d76, pickupcount);
  }
}

function function_fcc8620f60ca604c(arena) {
  spawneditemindex = 0;
  var_a29ac4899acd2c08 = arena.var_aeac6a7f3fb3167f;
  var_39ce9039c3660d76 = "";

  while(spawneditemindex < level.var_f684d37d5503eeba.var_1d8a378e37a1b6e5 && spawneditemindex < arena.var_49e6d5114201a22b[0].size) {
    spawneditemindex++;
    var_9ae625e33b2fc5f6 = var_a29ac4899acd2c08.size;
    diceroll = randomint(var_9ae625e33b2fc5f6);
    scriptablename = arena.var_49e6d5114201a22b[0][spawneditemindex - 1];

    if(!isDefined(scriptablename) || scriptablename == "") {
      var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[diceroll]);
      continue;
    }

    pickupcount = level.br_pickups.counts[scriptablename];

    if(!isDefined(pickupcount)) {
      pickupcount = 1;
    }

    dropinfo = spawnStruct();
    dropinfo.origin = var_a29ac4899acd2c08[diceroll].origin;
    dropinfo.angles = (0, 0, 0);
    dropinfo.payload = 0;
    lootitem = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, pickupcount);
    lootitem.var_1b46a808091ea19c = 1;
    var_39ce9039c3660d76 = var_a29ac4899acd2c08[diceroll].script_noteworthy;
    var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[diceroll]);
    var_a29ac4899acd2c08 = function_7f32923c29bcf243(arena.var_49e6d5114201a22b, var_a29ac4899acd2c08, scriptablename, var_39ce9039c3660d76, pickupcount);
  }
}

function function_d674739c4e4039b(arena, eventref, scriptablename) {
  var_410a59c41f3537f7 = 0;
  var_a29ac4899acd2c08 = arena.var_601cd7609bcc2ec2;

  if(isDefined(eventref) && isDefined(scriptablename)) {
    if(scriptablename == "") {
      return;
    }

    pickupcount = level.br_pickups.counts[scriptablename];

    if(!isDefined(pickupcount)) {
      pickupcount = 1;
    }

    dropinfo = spawnStruct();
    dropinfo.origin = var_a29ac4899acd2c08[0].origin;
    dropinfo.angles = (0, 0, 0);
    dropinfo.payload = 0;
    lootitem = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, pickupcount);
    lootitem.var_1b46a808091ea19c = 1;
    return;
  }

  if(level.var_f684d37d5503eeba.var_b50451c7ab918479 == 1) {
    while(var_410a59c41f3537f7 < level.var_f684d37d5503eeba.var_d5a4802dae58c710 && var_410a59c41f3537f7 < arena.var_c8ada8b232d73a0a[0].size) {
      var_410a59c41f3537f7++;
      diceroll = randomint(var_a29ac4899acd2c08.size);
      scriptablename = arena.var_c8ada8b232d73a0a[0][var_410a59c41f3537f7 - 1];

      if(!isDefined(scriptablename) || scriptablename == "") {
        var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[diceroll]);
        continue;
      }

      pickupcount = level.br_pickups.counts[scriptablename];

      if(!isDefined(pickupcount)) {
        pickupcount = 1;
      }

      dropinfo = spawnStruct();
      dropinfo.origin = var_a29ac4899acd2c08[diceroll].origin;
      dropinfo.angles = (0, 0, 0);
      dropinfo.payload = 0;
      lootitem = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, pickupcount);
      lootitem.var_1b46a808091ea19c = 1;
      var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[diceroll]);
    }
  }
}

function function_7f32923c29bcf243(itemlist, var_a29ac4899acd2c08, scriptablename, var_39ce9039c3660d76, pickupcount) {
  for(checkednodes = 0; checkednodes < var_a29ac4899acd2c08.size; checkednodes++) {
    if(var_a29ac4899acd2c08[checkednodes].script_noteworthy == var_39ce9039c3660d76) {
      dropinfo = spawnStruct();
      dropinfo.origin = var_a29ac4899acd2c08[checkednodes].origin;
      dropinfo.angles = (0, 0, 0);
      dropinfo.payload = 0;
      lootitem = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, pickupcount);
      lootitem.var_1b46a808091ea19c = 1;
      var_a29ac4899acd2c08 = array_remove(var_a29ac4899acd2c08, var_a29ac4899acd2c08[checkednodes]);
      break;
    }
  }

  return var_a29ac4899acd2c08;
}

function function_ab674fc3132afe8(arena) {
  if(level.var_f684d37d5503eeba.var_1d8a378e37a1b6e5 > arena.var_aeac6a7f3fb3167f.size / 2) {
    level.var_f684d37d5503eeba.var_1d8a378e37a1b6e5 = arena.var_aeac6a7f3fb3167f.size / 2;
  }

  if(level.var_f684d37d5503eeba.var_b61a334ec66db6a9 > arena.var_2c4104d74359893b.size / 2) {
    level.var_f684d37d5503eeba.var_b61a334ec66db6a9 = arena.var_2c4104d74359893b.size / 2;
  }
}

function function_5eaf324209d1c3f0() {
  level.var_1d446b9562cad6cb = "sc_gulag_items_1";
  level.var_42706f92b61ab857 = "sc_gulag_cash_1";
  level.var_8aa2fc86861fc20c = "sc_gulag_vouchers_1";

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    switch (level.br_circle.circleindex) {
      case 0:
        level.var_1d446b9562cad6cb = "sc_gulag_items_1";
        level.var_42706f92b61ab857 = "sc_gulag_cash_1";
        break;
      case 1:
        level.var_1d446b9562cad6cb = "sc_gulag_items_2";
        level.var_42706f92b61ab857 = "sc_gulag_cash_2";
        break;
      case 2:
        level.var_1d446b9562cad6cb = "sc_gulag_items_3";
        level.var_42706f92b61ab857 = "sc_gulag_cash_3";
        break;
      case 3:
        level.var_1d446b9562cad6cb = "sc_gulag_items_4";
        level.var_42706f92b61ab857 = "sc_gulag_cash_4";
        break;
      default:
        level.var_1d446b9562cad6cb = "sc_gulag_items_1";
        level.var_42706f92b61ab857 = "sc_gulag_cash_1";
        break;
    }
  }
}

function function_14d03f62839087b0() {
  var_ec22aea58117669e = 0;
  var_e3761a51d388c838 = 80;
  var_f8d9ad8f9ddee0a3 = 0;
  var_c59d027c6b2964aa = 14;
  var_b9880d08819747b1 = 1;
  var_220fe5e2359aa7bb = 1;

  if(!var_ec22aea58117669e) {
    return;
  }

  wait var_e3761a51d388c838;
  pone = undefined;

  foreach(player in level.teamdata[level.players[0].team]["<dev string:x49>"]) {
    if(player == level.players[0]) {
      continue;
    }

    pone = player;
  }

  level.players[0] kill();
  pone kill();
  wait 6;
  var_b33905c8f48b514e = level.players[7];
  var_f8890a693a90926c = undefined;

  foreach(player in level.teamdata[var_b33905c8f48b514e.team]["<dev string:x49>"]) {
    if(player == var_b33905c8f48b514e) {
      continue;
    }

    var_f8890a693a90926c = player;
  }

  var_b33905c8f48b514e kill();
  var_f8890a693a90926c kill();
  ptwo = undefined;

  foreach(player in level.teamdata[level.players[0].team]["<dev string:x49>"]) {
    if(player == level.players[0]) {
      continue;
    }

    if(player == pone) {
      continue;
    }

    ptwo = player;
  }

  wait 10;
  ptwo kill();
  wait 25;

  foreach(player in level.teamdata[var_b33905c8f48b514e.team]["<dev string:x49>"]) {
    if(player == var_b33905c8f48b514e) {
      continue;
    }

    if(player == var_f8890a693a90926c) {
      continue;
    }

    player kill();
  }

  wait 10;

  foreach(player in level.teamdata[level.players[0].team]["<dev string:x49>"]) {
    if(player == level.players[0]) {
      continue;
    }

    if(player == pone) {
      continue;
    }

    if(player == ptwo) {
      continue;
    }

    player kill();
  }

  wait 15;
  level.players[0] kill();
  wait 10;
  namespace_8bfdb6eb5a3df67a::br_kioskrevive(level.players[0], pone, 0);
  wait 5;
  var_5cf03fab06dd626f = function_1bd32287885bb933(ptwo);
  wait 1;
  ptwo kill();

  if(isDefined(var_5cf03fab06dd626f)) {
    var_5cf03fab06dd626f kill();
  }

  wait 25;
  namespace_8bfdb6eb5a3df67a::br_kioskrevive(ptwo, pone, 0);
  wait 20;

  if(isalive(ptwo)) {
    ptwo kill();
    wait 3;
  }

  var_139de170898d8659 = ptwo getentitynumber();
  kick(var_139de170898d8659);
  wait 1;
  countt = 0;

  while(countt < 100) {
    countt++;

    if(isDefined(var_139de170898d8659)) {
      kick(var_139de170898d8659);
    }

    if(!isDefined(var_139de170898d8659)) {
      level.players[0] kill();
    }

    wait 0.1;
  }

  if(isDefined(var_139de170898d8659)) {
    kick(var_139de170898d8659);
    level.players[0] kill();
  }
}

function function_526dfbe9997544a0() {
  var_e4a60bd9c8018200 = 0;

  if(!var_e4a60bd9c8018200) {
    return;
  }

  arena = self;
  wait 30;
  wait 5;

  if(isDefined(arena.var_707537a8904aa962[0]) && isDefined(arena.arenaplayers[0])) {
    function_c525d1df15d88a84(arena.var_707537a8904aa962[0], arena.arenaplayers[0]);
  }
}

function function_1d5e2e0d6af328f7(waittime) {
  var_cdd688f817853f8b = 0;

  if(!var_cdd688f817853f8b) {
    return;
  }

  wait waittime;
  setDvar(@ "hash_9e78730ec3baa38c", 4);
  eventdata = level.br_pe_data[3];
  eventdata.active = 1;
  scripts\mp\gametypes\br_publicevents::activateevent(eventdata);
}

# /