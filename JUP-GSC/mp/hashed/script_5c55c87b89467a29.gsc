/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c55c87b89467a29.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_13b6108ed675735e;
#using_animtree("script_model");

function function_209b4f3cbe639411() {
  if(getdvarint(@ "hash_ff65c25889692db8", 0) == 1) {
    return;
  }

  if(getdvarint(@ "hash_9c43b60485fbd92e", 0) == 1) {
    if(!istrue(level.var_72e1667d06ab98db)) {
      level thread function_362c40666180cacc();
    }

    return;
  }

  level.var_b0a252247b4d921c = 1;
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_ab0f4e43e75a740d);
  level.var_4ca71df7c9f87195 = getdvarint(@ "hash_b4dd40c7e16f3a0d", 1);
  level.var_6032d9d6e714a2a3 = getdvarint(@ "hash_4788d52ad8b0d95b", 3);
  level.var_9474fd9f170eb8bb = getdvarint(@ "hash_bc48245cbef08083", 10);
  level.var_8bb73eb201b171e2 = getdvarint(@ "hash_966200778cf1b8aa", 0);
  level.var_400484d15c2cfd6b = getdvarint(@ "hash_1e69ef33b46f5773", 400);
  level.var_ef3308c96486e0a9 = getdvarint(@ "hash_403f394c8232fdb1", 0);
  level.var_2d08577efb11dacb = getdvarint(@ "hash_b6a86be8437bb573", 5);
  level.var_e97fd1b659d67f4f = getdvarint(@ "hash_f5a76c762ab2ad27", -1);
  level.var_74e71ad99c620255 = [];
  level.var_fd915e8bd20b6d09 = &function_93e3fe0e5693889b;

  foreach(team in level.teamnamelist) {
    level.requiredplayercount[team] = 0;
  }

  level.prematchperiod = getdvarint(@ "hash_c653d32c30815d2b", 60);
  infilduration = getanimlength(%iw9_mp_dmz_infil_player1_cam);
  level.matchcountdowntime = infilduration + level.var_2d08577efb11dacb;
  level.prematchperiodend = infilduration + level.var_2d08577efb11dacb;
  level.var_7df8a2d09a6044a2 = getanimlength(%iw9_mp_dmz_infil_player1_intro);
  level.var_7df8a2d09a6044a2 += getanimlength(%iw9_mp_dmz_infil_player1_exit);
  level.var_7df8a2d09a6044a2 += level.var_2d08577efb11dacb;
  thread scripts\mp\gamelogic::matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);

  if(getdvarint(@ "hash_617f9fc340dd3ac6", 0) == 1) {
    level thread function_9360ab8d73d433f8();
  }

  function_354e8d20fb63725d();
  level thread function_ef34013df19c0ee3();
}

function function_ab0f4e43e75a740d(channel, val) {
  if(channel == "ui_dmz_mission_overlay") {
    self.var_9de396b15a642de3 = 1;
  }
}

function function_362c40666180cacc() {
  level.infilcompleted = 1;
  level waittill("match_start_real_countdown");
  level thread function_7114995a34df9681();
}

function function_9360ab8d73d433f8() {
  wait 10;

  foreach(point in level.startpoints) {
    level thread function_336d34d696729f31(point.origin);

    if(isDefined(point.target)) {
      ent = getStruct(point.target, "targetname");
      level thread function_336d34d696729f31(ent.origin);

      if(isDefined(ent.target)) {
        ent = getStruct(ent.target, "targetname");
        level thread function_336d34d696729f31(ent.origin);
      }
    }
  }
}

function function_336d34d696729f31(pos) {
  color = (randomfloat(1), randomfloat(1), randomfloat(1));
  interval = 1;

  while(true) {
    level thread scripts\mp\utility\debug::drawsphere(pos, 32, interval, color);
    wait interval;
  }
}

function function_93e3fe0e5693889b() {
  var_a95b157b75c7b989 = getdvarint(@ "hash_753d5d5f25ef4ef3", 1) == 1;

  if(!isDefined(level.var_d2a500c04f275698)) {
    level.var_d2a500c04f275698 = gettime();
  }

  if(!isDefined(level.var_d5464d9d1aa6dcff)) {
    level.var_d5464d9d1aa6dcff = gettime();
  } else {
    level.var_7e910037d1fd046a = gettime();
  }

  streamcomplete = 0;
  lobbysize = function_425d34ddd114f3de();

  if(level.players.size < lobbysize) {
    level.var_d2a500c04f275698 = gettime();
    return 0;
  }

  if(gettime() - level.var_d2a500c04f275698 < level.var_400484d15c2cfd6b) {
    return 0;
  }

  if(level.players.size > 0) {
    streamcomplete = 1;

    foreach(team in level.teamnamelist) {
      players = getteamdata(team, "players");

      foreach(player in players) {
        if(var_a95b157b75c7b989 && !player ispredictedstreamposready()) {
          streamcomplete = 0;
          break;
        }

        if(!istrue(player.pers["streamSyncComplete"]) || player.model == "") {
          if(!istrue(player.pers["streamSyncComplete"])) {
            if(!isDefined(player.var_560490e2dbf6bffd)) {
              player.var_560490e2dbf6bffd = gettime();
            } else {
              player.var_d8ef71a0ac335d44 = gettime();
            }
          }

          if(player.model == "") {
            if(!isDefined(player.var_b1641227c0a9ffcd)) {
              player.var_b1641227c0a9ffcd = gettime();
            } else {
              player.var_85a6b126d7750a54 = gettime();
            }
          }

          streamcomplete = 0;
          break;
        }
      }

      if(!streamcomplete) {
        break;
      }
    }
  }

  return streamcomplete;
}

function function_ef34013df19c0ee3() {
  level waittill("match_start_real_countdown");
  level thread function_7114995a34df9681();

  if(isDefined(level.var_d5464d9d1aa6dcff)) {
    logstring("<dev string:x1c>" + level.var_d5464d9d1aa6dcff);
  }

  if(isDefined(level.var_7e910037d1fd046a)) {
    logstring("<dev string:x4c>" + level.var_7e910037d1fd046a);
  }

  foreach(teamname in level.teamnamelist) {
    teamcount = getteamdata(teamname, "teamCount");

    if(teamcount) {
      level thread function_c9001909b0e28b18(teamname, "dmz_infil_");
    }
  }

  while(true) {
    if(getdvarint(@ "hash_7c2b5166dae9ac87", 0) == 1) {
      foreach(teamname in level.teamswithplayers) {
        function_c9001909b0e28b18(teamname, "<dev string:x7a>");
      }

      setDvar(@ "hash_7c2b5166dae9ac87", 0);
    }

    if(getdvarint(@ "hash_5265d7653ffa2075", 0) == 1) {
      level thread function_6d198a62f4efe4a7();
      setDvar(@ "hash_5265d7653ffa2075", 0);
    }

    if(getdvarint(@ "hash_36d8fafa1638eac", 0) == 1) {
      level thread function_843789f93292c6b7();
      setDvar(@ "hash_36d8fafa1638eac", 0);
    }

    if(getdvarint(@ "hash_449f5bb718a70589", 0) != 0) {
      level thread function_97a8d8477d7b7d01(getdvarint(@ "hash_449f5bb718a70589", 0));
      setDvar(@ "hash_449f5bb718a70589", 0);
    }

    if(getdvarint(@ "hash_59ece44a02195133", 0) == 1) {
      level.var_4dec411f05d13caa = 1;
      setDvar(@ "hash_59ece44a02195133", 0);
    }

    wait 1;
  }
}

function function_7114995a34df9681() {
  level notify("dmzInfil_start");
  setomnvar("ui_in_infil", 1);
  wait level.prematchperiodend - 4;
  setomnvar("ui_in_infil", 2);
  level notify("dmzInfil_countdownStart");
  level waittill("prematch_done");
  setomnvar("ui_in_infil", -1);
  level notify("dmzInfil_start");
}

function function_ef949b68ad626c8e() {
  timer = 0;

  if(level.var_8bb73eb201b171e2) {
    maxplayers = getdvarint(@ "party_maxplayers", 0);

    while(level.players.size < maxplayers) {
      timer += level.framedurationseconds;

      if(timer > level.var_9474fd9f170eb8bb) {
        return timer;
      }

      waitframe();
    }
  }

  if(level.var_6032d9d6e714a2a3 > 0) {
    foreach(team in level.teamnamelist) {
      if(getteamdata(team, "teamCount")) {
        streamcomplete = 0;

        for(players = getteamdata(team, "players"); players.size < level.var_6032d9d6e714a2a3 || !streamcomplete; players = getteamdata(team, "players")) {
          timer += level.framedurationseconds;

          if(players.size >= level.var_6032d9d6e714a2a3) {
            streamcomplete = 1;

            foreach(player in players) {
              if(!istrue(player.pers["streamSyncComplete"]) || player.model == "") {
                streamcomplete = 0;
              }
            }
          }

          if(timer > level.var_9474fd9f170eb8bb) {
            return timer;
          }

          waitframe();
        }
      }
    }
  }

  return timer;
}

function function_354e8d20fb63725d() {
  level.scr_anim["dmzExfil_player0"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_a;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_proto_a"] = getanimname(%iw9_mp_infil_proto_a_guy_a);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_b;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_proto_a"] = getanimname(%iw9_mp_infil_proto_a_guy_b);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_c;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_proto_a"] = getanimname(%iw9_mp_infil_proto_a_guy_c);
  level.scr_anim["dmzExfil_player0"]["dmz_infil_intro"] = % iw9_mp_dmz_infil_player1_intro;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_intro"] = getanimname(%iw9_mp_dmz_infil_player1_intro);
  level.scr_anim["dmzExfil_player0"]["dmz_infil_idle"] = % iw9_mp_dmz_infil_player1_idle;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_idle"] = getanimname(%iw9_mp_dmz_infil_player1_idle);
  level.scr_anim["dmzExfil_player0"]["dmz_infil_exit"] = % iw9_mp_dmz_infil_player1_exit;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_exit"] = getanimname(%iw9_mp_dmz_infil_player1_exit);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_intro"] = % iw9_mp_dmz_infil_player2_intro;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_intro"] = getanimname(%iw9_mp_dmz_infil_player2_intro);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_idle"] = % iw9_mp_dmz_infil_player2_idle;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_idle"] = getanimname(%iw9_mp_dmz_infil_player2_idle);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_exit"] = % iw9_mp_dmz_infil_player2_exit;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_exit"] = getanimname(%iw9_mp_dmz_infil_player2_exit);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_intro"] = % iw9_mp_dmz_infil_player3_intro;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_intro"] = getanimname(%iw9_mp_dmz_infil_player3_intro);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_idle"] = % iw9_mp_dmz_infil_player3_idle;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_idle"] = getanimname(%iw9_mp_dmz_infil_player3_idle);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_exit"] = % iw9_mp_dmz_infil_player3_exit;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_exit"] = getanimname(%iw9_mp_dmz_infil_player3_exit);

  if(getdvarint(@ "hash_947a9b74fcbd8126", 1) == 1) {
    level.scr_anim["dmzExfil_cam"]["dmz_infil_"] = % iw9_mp_dmz_infil_player1_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_1"] = % iw9_mp_dmz_infil_player1_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_2"] = % iw9_mp_dmz_infil_player2_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_3"] = % iw9_mp_dmz_infil_player3_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_low"] = % iw9_mp_dmz_infil_player1_lowcam_test;
    return;
  }

  if(getdvarint(@ "hash_d38ab35efdb1a60d", 1) == 1) {
    level.scr_anim["dmzExfil_cam"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_cam_alt;
    return;
  }

  level.scr_anim["dmzExfil_cam"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_cam;
}

function function_e5f3a754c68ef261(pos, angles) {
  cameraent = spawn("script_model", pos);

  if(isDefined(angles)) {
    cameraent.angles = angles;
  }

  cameraent setModel("tag_origin");
  cameraent.animname = "dmzExfil_cam";
  cameraent useanimtree(#animtree);
  return cameraent;
}

function function_c9001909b0e28b18(teamname, animref, overridespawnpoint) {
  if(level.mapname == "mp_dmz_hydro") {
    setglobalsoundcontext("wind", "heavy", 0.05);
  }

  players = getteamdata(teamname, "players");
  spawnpoint = ter_op(isDefined(overridespawnpoint), overridespawnpoint, level.teamdata[teamname]["startPoint"]);

  foreach(player in players) {
    if(isDefined(player.var_b1641227c0a9ffcd)) {
      logstring("Player " + player.name + " Model Load Time Start: " + player.var_b1641227c0a9ffcd);
    }

    if(isDefined(player.var_85a6b126d7750a54)) {
      logstring("Player " + player.name + " Model Load Time End: " + player.var_85a6b126d7750a54);
    }

    if(isDefined(player.var_560490e2dbf6bffd)) {
      logstring("Player " + player.name + " Stream Sync Time Start: " + player.var_560490e2dbf6bffd);
    }

    if(isDefined(player.var_d8ef71a0ac335d44)) {
      logstring("Player " + player.name + " Stream Sync Time End: " + player.var_d8ef71a0ac335d44);
    }

    logstring("Player " + player.name + " Infil Started: " + gettime());
  }

  if(getdvarint(@ "hash_696cc1e380833ac0", 0) == 1) {
    players = array_randomize(players);
  }

  assertex(players.size <= 3, "<dev string:x8f>");
  assertex(players.size > 0, "<dev string:xcd>");
  players = getteamdata(teamname, "players");

  if(players.size < 1) {
    return;
  }

  level.infilcompleted = 1;

  if(isDefined(level.var_796ae5bb031f323d)) {
    spawnpoint = players[0][[level.var_796ae5bb031f323d]]();
  }

  var_daf67907b493b764 = function_e5f3a754c68ef261(spawnpoint.origin, spawnpoint.angles);
  animstruct = function_236f4cbf385b007f(players[0], var_daf67907b493b764, undefined, spawnpoint);
  var_bbf920aff68a45f0 = animstruct;

  if(isDefined(players[0]) && players[0].model != "") {
    players[0] scripts\common\anim::anim_first_frame_solo(animstruct.cam, animref, "tag_origin");
  }

  animlength = getanimlength(level.scr_anim[animstruct.cam.animname][animref]);
  teamsize = min(players.size, 3);

  if(players.size > 3) {
    for(i = int(teamsize); i < players.size; i++) {
      players[i] _freezecontrols(0);
      players[i] _freezelookcontrols(0);
    }
  }

  for(i = 0; i < teamsize; i++) {
    if(!isDefined(players[i]) || players[i].model == "") {
      continue;
    }

    camerastructstart = undefined;
    players[i].var_1cd92a64c5b20fa0 = "dmzExfil_player" + i;

    if(isDefined(spawnpoint) && isDefined(spawnpoint.target)) {
      structs = getStructArray(spawnpoint.target, "targetname");

      foreach(struct in structs) {
        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "infil_camera") {
          camerastructstart = struct;
        }
      }
    }

    if(i > 0) {
      if(isDefined(spawnpoint) && isDefined(spawnpoint.target)) {
        structs = getStructArray(spawnpoint.target, "targetname");

        foreach(struct in structs) {
          if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "infil_camera") {
            camerastructstart = struct;
            continue;
          }

          spawnpoint = struct;
        }
      } else {
        spawnpoint = undefined;
      }

      if(isDefined(level.var_796ae5bb031f323d)) {
        spawnpoint = players[i][[level.var_796ae5bb031f323d]]();
      }

      if(level.var_4ca71df7c9f87195 == 1) {
        var_daf67907b493b764 = function_e5f3a754c68ef261(players[i].origin);
        animstruct = function_236f4cbf385b007f(players[i], var_daf67907b493b764, var_bbf920aff68a45f0, spawnpoint, animref);

        if(isDefined(players[i]) && players[i].model != "") {
          players[i] scripts\common\anim::anim_first_frame_solo(animstruct.cam, animref + i + 1, "tag_origin");
        }
      } else {
        animstruct = function_236f4cbf385b007f(players[i], var_daf67907b493b764, var_bbf920aff68a45f0, spawnpoint, animref);
      }
    }

    players[i] thread function_67ad64ccfb9082a8(animstruct, animref, camerastructstart);
  }

  if(level.var_4ca71df7c9f87195 == 0) {
    players[0] thread scripts\common\anim::anim_single_solo(animstruct.cam, animref, "tag_origin");
  }

  level thread function_1e328368618d72da(teamname);
}

function function_236f4cbf385b007f(player, cam, relativeto, spawnpoint, animref) {
  startpoint = undefined;

  if(level.var_ef3308c96486e0a9 == 1 && isDefined(level.var_74e71ad99c620255[player.team])) {
    startpoint = level.var_74e71ad99c620255[player.team];
  } else if(isDefined(spawnpoint)) {
    startpoint = spawnpoint;
  } else {
    startpoint = level.teamdata[player.team]["startPoint"];
  }

  assertex(isDefined(startpoint), "<dev string:xfb>");
  animstruct = spawnStruct();
  animstruct.origin = player_drop_to_ground(startpoint.origin, 32, undefined, undefined, (0, 0, 1));
  animstruct.angles = startpoint.angles;
  animstruct.cam = cam;

  if(isDefined(startpoint.script_parameters)) {
    animstruct.script_parameters = startpoint.script_parameters;
  }

  if(isDefined(relativeto)) {
    animstart = getoriginforanimtime(relativeto.origin, relativeto.angles, level.scr_anim[player.var_1cd92a64c5b20fa0][animref + "intro"], 1);
    zpos = player_drop_to_ground(animstart, 32, undefined, undefined, (0, 0, 1));
    targetpos = relativeto.origin;

    if(isDefined(spawnpoint)) {
      animstart = getoriginforanimtime(spawnpoint.origin, spawnpoint.angles, level.scr_anim[player.var_1cd92a64c5b20fa0][animref + "intro"], 1);
      zpos = player_drop_to_ground(spawnpoint.origin, 32, undefined, undefined, (0, 0, 1));
      targetpos = spawnpoint.origin + spawnpoint.origin - animstart;
    }

    relativez = relativeto.origin[2];

    if(isDefined(spawnpoint)) {
      relativez = spawnpoint.origin[2];
    }

    animstruct.origin = (targetpos[0], targetpos[1], relativez + zpos[2] - animstart[2]);
    animstruct.angles = relativeto.angles;
    animstruct.campos = spawnStruct();
    animstruct.campos.origin = zpos;
    animstruct.campos.angles = animstruct.angles;
  } else {
    animstruct.campos = spawnStruct();
    animstruct.campos.origin = animstruct.origin;
    animstruct.campos.angles = animstruct.angles;
  }

  return animstruct;
}

function function_1e328368618d72da(team) {
  wait 2;

  if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("match_intro_generic", team);
  } else {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("match_intro", team);
  }

  wait 15;

  if(!istrue(level.var_644a33d86d8514bf)) {
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_contract_reminder", getteamdata(team, "players"));
  }
}

function function_706eaf553cdb684(cament, path, time) {
  starttime = gettime();
  totaldist = 0;

  for(i = path.size - 1; i > 0; i--) {
    path[i].dist = distance(path[i].origin, path[i - 1].origin);
    totaldist += path[i].dist;
  }

  var_969e785c4e00a1d1 = 0;
  var_976824f5544dc282 = 0;

  for(i = path.size - 1; i > 0; i--) {
    segmentsize = path[i].dist / totaldist;
    var_969e785c4e00a1d1 = var_976824f5544dc282;
    var_976824f5544dc282 += segmentsize;
    timepercent = (gettime() - starttime) / 1000 / time;

    while(timepercent < var_976824f5544dc282) {
      timepercent = (gettime() - starttime) / 1000 / time;
      var_774e0f07388b5aab = (timepercent - var_969e785c4e00a1d1) / segmentsize;
      cament.angles = anglelerpquatfrac(path[i].angles, path[i - 1].angles, var_774e0f07388b5aab);
      cament.origin = vectorlerp(path[i].origin, path[i - 1].origin, var_774e0f07388b5aab);
      waitframe();
    }
  }
}

function function_67ad64ccfb9082a8(animstruct, animref, camerastructstart) {
  assertex(isDefined(animstruct), "<dev string:x124>");
  self notify("dmz_playInfil");
  self endon("disconnect");
  thread function_4a22eef220bff896();
  thread scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated(self.var_1cd92a64c5b20fa0, self.origin, self.angles);
  self cameraunlink();
  animstruct scripts\common\anim::anim_first_frame_solo(self.player_rig, animref + "intro");
  self cameralinkTo(animstruct.cam, "tag_origin", 1, 1);
  self setclientdvar(@ "cg_fov", 40);

  if(isDefined(camerastructstart) && getdvarint(@ "hash_5bda28fa688a245c", 0) == 1) {
    campath = [camerastructstart];
    curnode = camerastructstart;

    while(isDefined(curnode.target)) {
      curnode = getStruct(curnode.target, "targetname");
      campath[campath.size] = curnode;
    }

    animstruct thread function_706eaf553cdb684(animstruct.cam, campath, getanimlength(%iw9_mp_dmz_infil_player1_intro));
  } else if(level.var_4ca71df7c9f87195 == 1) {
    var_4752910cfaba108a = animref;

    if(isDefined(animstruct.script_parameters)) {
      var_4752910cfaba108a = animstruct.script_parameters;
    }

    animstruct.campos thread scripts\common\anim::anim_single_solo(animstruct.cam, var_4752910cfaba108a);
  }

  self attach("offhand2h_wm_tablet_dmz", "tag_accessory_left");
  animstruct thread anim_player_solo(self, self.player_rig, animref + "intro");
  self playlocalsound("dmz_camera_zoom_in");
  introdur = getanimlength(%iw9_mp_dmz_infil_player1_intro);
  wait introdur - 1.8;

  if(isDefined(self.hidehudenabled)) {
    utility::hidehuddisable();
  }

  if(getdvarint(@ "hash_8da4a5e690432cd0", 1) == 1) {
    thread function_dff9480861b2acb1();
    _freezecontrols(0, 1);
  }

  wait 1.8;

  if(level.var_e97fd1b659d67f4f == -1) {
    thread function_e31ab6a7ebef3680();
  } else {
    thread function_80959dd6d2c10831(level.var_e97fd1b659d67f4f);
  }

  self clearadditionalstreampos();
  function_2b14c4dbf6ebd391(animstruct, animref, 1);
  animstruct thread anim_player_solo(self, self.player_rig, animref + "exit");

  if(getdvarint(@ "hash_e985d309e4bf9569", 0) == 1) {
    thread function_f43a907c9b43b440(animstruct.cam);
  } else {
    thread function_f687b7ea0da59a4c(animstruct);
  }

  var_539a64d23aa56d91 = getanimlength(%iw9_mp_dmz_infil_player1_exit);
  wait var_539a64d23aa56d91;
  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    attached = self getattachmodelname(i);

    if(attached == "offhand2h_wm_tablet_dmz") {
      self detach("offhand2h_wm_tablet_dmz", "tag_accessory_left");
    }
  }

  if(getdvarint(@ "hash_8da4a5e690432cd0", 1) == 0) {
    _freezecontrols(0);
  }

  _freezelookcontrols(0);

  if(level.var_4ca71df7c9f87195 == 1) {
    animstruct.cam delete();
  }

  self notify("dmzInfil_complete");
}

function function_4a22eef220bff896() {
  self endon("disconnect");
  waittill_any_timeout_1(30, "dmzInfil_complete");
  wait 5;

  if(self getclientomnvar("ui_world_fade") > 0) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 0, 0.5);
  }

  if(self getclientomnvar("ui_total_fade") > 0) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
  }
}

function function_e31ab6a7ebef3680() {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  level waittill("prematch_done");
  self setclientomnvar("ui_dmz_mission_overlay", 0);
  self notify("dmzInfil_stopIdle");
}

function function_80959dd6d2c10831(maxtime) {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  wait maxtime;
  self setclientomnvar("ui_dmz_mission_overlay", 0);
  self notify("dmzInfil_stopIdle");
}

function function_2b14c4dbf6ebd391(animstruct, animref, minimumtime) {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  thread function_c5693aee7d75230a(animstruct, animref);
  wait minimumtime;

  while(!istrue(self.var_9de396b15a642de3)) {
    waitframe();
  }

  self notify("dmzInfil_stopIdle");
}

function function_c5693aee7d75230a(animstruct, animref) {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  animlength = getanimlength(level.scr_anim[self.player_rig.animname][animref + "idle"]);

  if(animlength < 0.1) {
    return;
  }

  while(true) {
    if(!isDefined(self) || !isDefined(self.player_rig) || !isreallyalive(self) || !isDefined(animstruct)) {
      println("<dev string:x147>");
      return;
    }

    animstruct thread anim_player_solo(self, self.player_rig, animref + "idle");
    wait animlength;
  }
}

function function_dff9480861b2acb1() {
  self setclientomnvar("ui_dmz_mission_overlay", 1);
}

function function_301d27fda3ec6b41(teamname) {
  timer = 0;
  players = getteamdata(teamname, "players");

  while(true) {
    timer += level.framedurationseconds;
    streamcomplete = 1;

    foreach(player in players) {
      if(!istrue(player.pers["streamSyncComplete"]) || player.model == "") {
        streamcomplete = 0;
      }
    }

    if(streamcomplete) {
      return;
    }

    waitframe();
  }
}

function function_f58b70c3d35c2f5() {
  _freezecontrols(1);
  _freezelookcontrols(1);

  while(self.model == "") {
    waitframe();
  }
}

function function_f687b7ea0da59a4c(animstruct) {
  self endon("disconnect");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 1, 0.5);
  self lerpfovbypreset("default");
  self cameraunlink();

  if(isreallyalive(self)) {
    if(isDefined(self.player_rig)) {
      self.player_rig scripts\mp\utility\infilexfil::handleweaponstatenotetrack("drop");
    }

    wait 0.2;

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(self.player_rig)) {
      self.player_rig scripts\mp\utility\infilexfil::handleweaponstatenotetrack("raise");
    }
  }

  self setplayerangles(animstruct.angles);
  self notify("remove_rig");
  self notify("screen_completely_black");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 0, 0.5);
}

function function_f43a907c9b43b440(cam) {
  newcam = function_e5f3a754c68ef261(cam.origin, cam.angles);
  targetpos = self getEye();
  targetangles = self.angles;
  self cameralinkTo(newcam, "tag_origin", 1, 1);
  newcam moveTo(targetpos, 1);
  newcam rotateTo(targetangles, 1, 0.5);
  wait 1;
  self lerpfovbypreset("default");
  self cameraunlink();
  self notify("remove_rig");
  newcam delete();
}

function function_c8556d47c98bb0ec(teamname, node) {
  level.var_ef3308c96486e0a9 = 1;
  level.var_74e71ad99c620255[teamname] = node;
  function_c9001909b0e28b18(teamname, "dmz_infil_", node);
}

function function_6d198a62f4efe4a7() {
  if(!isDefined(level.playerteams)) {
    level.playerteams = [];

    foreach(player in level.players) {
      if(array_contains(level.playerteams, player.team)) {
        continue;
      }

      level.playerteams[level.playerteams.size] = player.team;
    }
  }

  level.var_4dec411f05d13caa = 0;
  player = level.players[0];
  level.allstartpoint = array_combine(level.startpoints[0].points, level.startpoints[1].points);

  for(i = 0; i < level.allstartpoint.size; i++) {
    offset = 0;

    foreach(team in level.playerteams) {
      index = i + offset;

      if(index > level.allstartpoint.size) {
        index -= level.allstartpoint.size;
      }

      function_c8556d47c98bb0ec(team, level.allstartpoint[index]);
      offset += 1;
    }

    waitdur = level.var_7df8a2d09a6044a2;

    if(istrue(level.var_4dec411f05d13caa)) {
      return;
    }

    wait waitdur;

    if(istrue(level.var_4dec411f05d13caa)) {
      return;
    }
  }
}

function function_97a8d8477d7b7d01(index) {
  player = level.players[0];
  level.var_4dec411f05d13caa = 1;
  function_c8556d47c98bb0ec(player.team, level.startpoints.points[index]);
}

function function_843789f93292c6b7() {
  player = level.players[0];
  level.var_4dec411f05d13caa = 1;
  closestdist = distancesquared(level.startpoints[0].points[0].origin, player.origin);
  targetnode = level.startpoints[0].points[0];

  foreach(pointgroup in level.startpoints) {
    foreach(point in pointgroup.points) {
      dist = distancesquared(point.origin, player.origin);

      if(closestdist > dist) {
        targetnode = point;
      }
    }
  }

  function_c8556d47c98bb0ec(player.team, targetnode);
}