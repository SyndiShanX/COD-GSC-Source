/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\activity_manager.gsc
*****************************************************/

#using script_1174abedbefe9ada;
#using script_1193c0b83fce13b;
#using script_15ca41a3fbb0e379;
#using script_241ff3c86d02a28d;
#using script_2e2e13d44d465832;
#using script_318621981299585a;
#using script_34f71bd59550adcb;
#using script_358978e883d9f6c2;
#using script_3665d737b10b78d9;
#using script_3e32e216ce730ac2;
#using script_419eebc6f24e287;
#using script_45f403e1732217d3;
#using script_46b3c7d0a4338d8;
#using script_4948cdf739393d2d;
#using script_495022338d50407e;
#using script_4f9a55dee6aebc8f;
#using script_58fe895fd0fbe620;
#using script_6a9e2d3385424b39;
#using script_6b7618d5ead05b66;
#using script_744cad313ed0a87e;
#using script_78fe9876bb090d6b;
#using script_7fba4131729fe74d;
#using script_a62705cb078ec0a;
#using script_c00335a7aeb2728;
#using script_ef36a50d9b4627d;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_safes;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace activity_manager;

function function_df15f72187363229() {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_279c4202b5ed4980);

  if(isDefined(level.autoassignfirstquest) && level.autoassignfirstquest == 1 || getdvarint(@ "hash_85b85aad9f4aefea", 1) == 0) {
    return;
  }

  if(!istrue(level.var_1e0470dbb6cf1859)) {
    while(!isDefined(level.struct_class_names) || !isDefined(level.var_41670c1c65f3d3cf) || function_9a83377c98bce82a("everybody") <= 0 || !isDefined(level.lockedvolumes) || !istrue(level.var_f1073fbd45b59a06.var_9b87fdb80920f442) || !isDefined(level.startpoints)) {
      waitframe();
    }
  } else if(istrue(level.var_1e0470dbb6cf1859)) {
    while(!isDefined(level.var_f1073fbd45b59a06) || !isDefined(level.var_f1073fbd45b59a06.var_df987907a483df89)) {
      waitframe();
    }
  }

  level.var_1b7407dffe81e6e8 = spawnStruct();
  level.var_1b7407dffe81e6e8.teamlist = [];
  level.var_1b7407dffe81e6e8.activities = [];
  level.var_fe29a5bf2f96b5d3 = [];

  foreach(node in getStructArray("dmz_missionObjectiveUniversal", "script_noteworthy")) {
    level.var_fe29a5bf2f96b5d3[level.var_fe29a5bf2f96b5d3.size] = node;
  }

  level.var_1b7407dffe81e6e8.var_a3e3841ab1affb3c = getDvar(@ "hash_518d6090239df9b9", "mp/dmzactivities.csv");
  level.var_1b7407dffe81e6e8.var_d6d000f64c923fd6 = getdvarint(@ "hash_10fcfffe932c9bd5", 1);
  level.var_13daf5d5cf8158b2 = getdvarint(@ "hash_a598966b6e53fde8", 1);
  level.var_d1404cd77b68f22e = getdvarint(@ "hash_51ca2e83111f7340", 0);
  level.var_fc3962361e2033a9 = getdvarint(@ "hash_a17f8c87a9ffefa6", 1);
  level.var_427f173fa29d4e80 = getdvarint(@ "hash_f173806bc718ddd1", 1);
  level.var_a4840e7885ef58e = getdvarint(@ "scr_activity_autoassign", 1);

  if(istrue(level.var_1e0470dbb6cf1859)) {
    level.var_a4840e7885ef58e = 0;
  }

  level thread function_97479a799d6eb103();
  level thread function_4a6adeb5f340fcc8();

  if(scripts\mp\team_assimilation::function_6934349b7823d888()) {
    scripts\mp\team_assimilation::registerteamassimilatecallback(&function_22e206cc7ae5dbfd);
  }

  level thread activity_debugdvars();
}

function function_7460e0aba0b1f1b3(instance, part, state, player, bautouse, usestring) {
  thread scripts\mp\gametypes\activity_manager::function_57ac6111c7db410f(instance, player);
}

function onteameliminated(team) {
  if(function_5ea5a722c499078f(team)) {
    activity = function_b1d0568d9066a2ce(team);

    if(isDefined(activity)) {
      namespace_e77194a0203f683::function_1ef65d2654424502(activity, "fail", team);
      activity.tasks[0] function_8d4a1199159f7d52(team);

      if(istrue(level.gamemodebundle.var_b0c3d102a683d3ee)) {
        foreach(player in getteamdata(team, "players")) {
          player dlog_recordplayerevent("dlog_event_exgm_player_mission_complete", ["mission_ref", activity.tasks[0].ref, "completion_state", "failed - team eliminated"]);
        }
      }
    }
  }

  teamcount = scripts\mp\teams::getactiveteamcount();

  if(teamcount == 1) {
    namespace_b11859036e02907d::function_9afa2021a101589a();
  }
}

function private activity_debugdvars() {
  setDvar(@ "hash_38667c3d89e33b7b", 0);
  setDvar(@ "hash_b141c2b278951739", 0);
  setDvar(@ "hash_d53193725af8249a", 0);
  setDvar(@ "hash_49015467bf99bb3b", 0);

  while(true) {
    waitframe();

    if(isDefined(level.var_1b7407dffe81e6e8.spawndata)) {
      foreach(name, spawndata in level.var_1b7407dffe81e6e8.spawndata) {
        if(getdvarint(hashcat(@ "hash_31a2bba2a258c4a2", name, "<dev string:x1c>"), 0) == 1 || getdvarint(hashcat(@ "hash_31a2bba2a258c4a2", name, "<dev string:x29>"), 0) == 1) {
          tobot = getdvarint(hashcat(@ "hash_31a2bba2a258c4a2", name, "<dev string:x29>"), 0) == 1;
          setDvar(hashcat(@ "hash_31a2bba2a258c4a2", name, "<dev string:x1c>"), 0);
          setDvar(hashcat(@ "hash_31a2bba2a258c4a2", name, "<dev string:x29>"), 0);
          activity = undefined;

          foreach(act in level.var_1b7407dffe81e6e8.activities) {
            if(isDefined(act.name) && name == act.name) {
              activity = act;
              break;
            }
          }

          if(!isDefined(activity)) {
            node = undefined;

            foreach(testnode in spawndata.nodes) {
              if(function_39c4f5c52fb521d8(testnode.origin, spawndata.exclusionradius, spawndata.var_51f461a8e820667b, name)) {
                node = testnode;
                break;
              }
            }

            if(isDefined(node)) {
              activity = function_fbac8fe5cba1bccd(node, name, spawndata, 1);
            } else {
              assert("<dev string:x3a>" + name + "<dev string:x5a>");
            }
          }

          team = level.players[0].team;

          if(tobot) {
            foreach(player in level.players) {
              if(isbot(player)) {
                team = player.team;
                break;
              }
            }
          }

          activity activity_assign(team, undefined, level.players[0]);
        }
      }

      if(getdvarint(@ "hash_ef7e3cb3eb287471", 0)) {
        setDvar(@ "hash_ef7e3cb3eb287471", 0);
        player = level.players[0];

        if(function_5ea5a722c499078f(player.team)) {
          activity = function_b1d0568d9066a2ce(player.team);
          activity.tasks[0] function_8d4a1199159f7d52(player.team);
        }
      }

      if(getdvarint(@ "hash_e1cbc0efccbb05da", 0)) {
        printtoscreen2d(50, 50, "<dev string:x7f>");
        y = 50;
        total = 0;

        foreach(name, spawndata in level.var_1b7407dffe81e6e8.spawndata) {
          total += spawndata.spawned;
          text = name + "<dev string:x91>" + spawndata.spawned;
          y += 20;
          printtoscreen2d(50, y, text);
        }

        y += 20;
        printtoscreen2d(50, y, "<dev string:x9d>" + total);
      }
    }

    if(getdvarint(@ "hash_b141c2b278951739", 0) == 1) {
      taskindex = level.var_1b7407dffe81e6e8.activities[0].teams[level.players[0].team];
      task = level.var_1b7407dffe81e6e8.activities[0].tasks[taskindex];
      task function_18d4e8025ec24a0();
      setDvar(@ "hash_b141c2b278951739", 0);
    }

    if(getdvarint(@ "hash_38667c3d89e33b7b", 0) == 1) {
      activity = function_ebe9b1e455d46450(level.players[0]);
      activity activity_assign(level.players[0].team);
      setDvar(@ "hash_38667c3d89e33b7b", 0);
    }

    if(getdvarint(@ "hash_d53193725af8249a")) {
      setDvar(@ "hash_d53193725af8249a", 0);
      spawnpoint = level.players[0];
      activitystarter = spawnscriptable("<dev string:xa8>" + "<dev string:xc4>", spawnpoint.origin, spawnpoint.angles);
      activitystarter function_5220f38b5239eac8();
      activitystarter.var_dabe413c9c6c48f4 = randomint(tablelookupgetnumrows(level.var_1b7407dffe81e6e8.var_a3e3841ab1affb3c));
      activitystarter.var_d855aa87b99592a = randomint(100) + 1;
      activitystarter.poiindex = randomint(8);

      if(!isDefined(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38)) {
        level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38 = [];
      }

      prevsize = level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38.size;
      level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38[level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38.size] = activitystarter;

      if(prevsize == 0) {
        level thread function_4a6adeb5f340fcc8();
      }
    }

    if(getdvarint(@ "hash_2039b0d4553f1be2", 0)) {
      setDvar(@ "hash_2039b0d4553f1be2", 0);

      if(!isDefined(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38)) {
        level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38 = [];
      }

      foreach(activitystarter in level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38) {
        activitystarter function_66da9365bbfea8b7();
      }
    }

    if(getdvarint(@ "hash_49015467bf99bb3b", 0) == 1) {
      setDvar(@ "hash_49015467bf99bb3b", 0);
      node = spawnStruct();
      node.origin = level.players[0].origin + anglesToForward(level.players[0].angles) * 200;
      node.angles = level.players[0].angles;
      scripts\mp\gametypes\dmz_safes::function_d2441b457fa14419(node);
    }
  }
}

function function_b713f2d39b34540f(data, createfunc, nodes) {
  assert(isDefined(data) && isDefined(createfunc) && isDefined(nodes), "<dev string:xce>");
  data.createfunc = createfunc;
  data.nodes = nodes;
}

function private function_38228778814192a() {
  spawndata = [];
  var_a3e3841ab1affb3c = level.var_1b7407dffe81e6e8.var_a3e3841ab1affb3c;
  numrows = tablelookupgetnumrows(var_a3e3841ab1affb3c);
  debug = getdvarint(@ "hash_4ca9133f642d177f", 0) == 1;
  startpoints = [];

  foreach(set in level.startpoints) {
    if(isDefined(set.points)) {
      foreach(point in set.points) {
        if(isDefined(point.origin)) {
          startpoints[startpoints.size] = point.origin;
        }
      }
    }

    if(isDefined(set.origin)) {
      startpoints[startpoints.size] = set.origin;
    }
  }

  for(row = 0; row < numrows; row++) {
    enabled = int(tablelookupbyrow(var_a3e3841ab1affb3c, row, 2));
    name = tablelookupbyrow(var_a3e3841ab1affb3c, row, 0);
    function_975afdc14c65649c(name, row);
    enabledoverride = getdvarint(hashcat(@ "hash_1b5fb36050170b0f", name, "_enabled"), -1);

    if(enabledoverride != -1) {
      enabled = enabledoverride;
    }

    if(!enabled) {
      continue;
    }

    data = spawnStruct();
    data.index = row;
    data.type = tablelookupbyrow(var_a3e3841ab1affb3c, row, 3);
    data.cashreward = int(tablelookupbyrow(var_a3e3841ab1affb3c, row, 4));
    data.difficulty = int(tablelookupbyrow(var_a3e3841ab1affb3c, row, 5));
    data.priority = float(tablelookupbyrow(var_a3e3841ab1affb3c, row, 7));
    data.exclusionradius = float(tablelookupbyrow(var_a3e3841ab1affb3c, row, 8));
    data.var_51f461a8e820667b = float(tablelookupbyrow(var_a3e3841ab1affb3c, row, 9));
    data.minspawncount = int(tablelookupbyrow(var_a3e3841ab1affb3c, row, 10));
    data.maxspawncount = int(tablelookupbyrow(var_a3e3841ab1affb3c, row, 11));
    data.var_2ce8f82ad71eb571 = float(tablelookupbyrow(var_a3e3841ab1affb3c, row, 14));
    data.var_7a62616965ed6a2e = float(tablelookupbyrow(var_a3e3841ab1affb3c, row, 15));
    playerspawnexclusion = int(tablelookupbyrow(var_a3e3841ab1affb3c, row, 16));

    if(playerspawnexclusion > 0) {
      foreach(startpoint in startpoints) {
        function_d4d97591648f4390(startpoint, playerspawnexclusion, name, 1);

        if(debug) {
          draw_circle(startpoint + (0, 0, 800), playerspawnexclusion, (0, 1, 1), 1, 0, 20000);
        }
      }
    }

    tospawn = getdvarint(hashcat(@ "hash_1b5fb36050170b0f", name, "_numberToSpawn"), -1);

    if(tospawn != -1) {
      data.minspawncount = tospawn;
      data.maxspawncount = tospawn;
    }

    assert(data.minspawncount <= data.maxspawncount, "<dev string:x102>" + name + "<dev string:x127>");

    switch (name) {
      case #"hash_f4a9126c03d3385b":
        namespace_e1bfa87a2a692d3c::function_80d68c9701e1aea5(data);
        break;
      case #"hash_194f31f722d1fa09":
        namespace_4c19ca57323d483c::function_80d68c9701e1aea5(data);
        break;
      case #"hash_e91729d4ef79ca26":
        namespace_4f4cbea0f5b0bdb8::function_80d68c9701e1aea5(data);
        break;
      case #"hash_75b6db03edb1e84e":
        namespace_300f9f7dca7fc109::function_80d68c9701e1aea5(data);
        break;
      case #"hash_e9d9fcb8daba8602":
        namespace_fa9fd40f68ab8478::function_80d68c9701e1aea5(data);
        break;
      case #"hash_82ea0e6e4f123b62":
        namespace_b8c00f1eafbbd213::function_80d68c9701e1aea5(data);
        break;
      case #"hash_514d922eb8aed0b1":
        break;
      case #"hash_8fe6af6c550e39bc":
        namespace_30baceecda213256::function_80d68c9701e1aea5(data);
        break;
      case #"hash_cf3abe09f0094696":
        namespace_5ffce5a43b2d1ec2::function_80d68c9701e1aea5(data);
        break;
      case #"hash_e0b82e0f064c17d6":
        namespace_232aeaeb467df5bd::function_80d68c9701e1aea5(data);
        break;
      case #"hash_9682e089e580b4b8":
        namespace_38da3c68826ceb02::function_80d68c9701e1aea5(data);
        break;
      case #"hash_1e754eb11fa62651":
        namespace_d0483bb41cd4e112::function_80d68c9701e1aea5(data);
        break;
      case #"hash_9db32d30f2603c35":
        namespace_168c086126cfa488::function_80d68c9701e1aea5(data);
        break;
      case #"hash_37bb23543c319104":
        namespace_b11859036e02907d::function_80d68c9701e1aea5(data);
        break;
      case #"hash_be386dc37be6968e":
        namespace_20374f100d8c4183::function_80d68c9701e1aea5(data);
        break;
      case #"hash_4f62da1c4ed6f790":
        namespace_a3ac717bde4bea03::function_80d68c9701e1aea5(data);
        break;
      case #"hash_218ddcea32fa5fbc":
        namespace_210d6dd43cfaf195::function_80d68c9701e1aea5(data);
        break;
      case #"hash_5c317bf7b4be6e08":
        break;
      case #"hash_88570f89de3f4680":
        namespace_a713760a939752c1::function_80d68c9701e1aea5(data);
        break;
      default:
        assertmsg("<dev string:x143>" + name);
        break;
    }

    data.tospawn = randomintrange(data.minspawncount, data.maxspawncount + 1);

    if(!isDefined(data.nodes) || !isarray(data.nodes) || data.nodes.size == 0 || data.tospawn <= 0) {
      continue;
    }

    data.spawned = 0;
    data.nodes = array_randomize(data.nodes);
    spawndata[name] = data;
  }

  level.var_1b7407dffe81e6e8.spawndata = spawndata;

  return spawndata;
}

function function_aece1e424e300380() {
  spawndata = [];
  numrows = tablelookupgetnumrows("mp/bractivities.csv");

  for(row = 0; row < numrows; row++) {
    enabled = int(tablelookupbyrow("mp/bractivities.csv", row, 2));
    name = tablelookupbyrow("mp/bractivities.csv", row, 0);
    function_975afdc14c65649c(name, row);

    if(!enabled) {
      continue;
    }

    data = spawnStruct();
    data.index = row;
    data.type = tablelookupbyrow("mp/bractivities.csv", row, 3);
    data.cashreward = int(tablelookupbyrow("mp/bractivities.csv", row, 4));

    switch (name) {
      case #"hash_7e9cf92ed0a526f1":
        namespace_c96c5decac69fc6::function_7aae8cb0d8b0ac6a(data);
        break;
      case #"hash_890e226c519dc6ab":
        namespace_d4eb7462ff000665::function_7aae8cb0d8b0ac6a(data);
        break;
      case #"hash_dd93195493d0c818":
        namespace_b8f885001f04bb5::function_7aae8cb0d8b0ac6a(data);
        break;
      default:
        assertmsg("<dev string:x19b>" + name);
        break;
    }

    spawndata[name] = data;
  }

  level.var_1b7407dffe81e6e8.spawndatamap = spawndata;
}

function function_6507dea837a9799c(name) {
  if(!isDefined(level.var_1b7407dffe81e6e8.spawndatamap)) {
    function_aece1e424e300380();
  }

  return level.var_1b7407dffe81e6e8.spawndatamap[name];
}

function private function_975afdc14c65649c(type, index) {
  if(!isDefined(level.var_1b7407dffe81e6e8.typeindexes)) {
    level.var_1b7407dffe81e6e8.typeindexes = [];
  }

  level.var_1b7407dffe81e6e8.typeindexes[type] = index;
}

function private function_f92c1a3d19210ccd(type) {
  assert(isDefined(level.var_1b7407dffe81e6e8) && isDefined(level.var_1b7407dffe81e6e8) && isDefined(level.var_1b7407dffe81e6e8.typeindexes) && isDefined(level.var_1b7407dffe81e6e8.typeindexes[type]));
  return level.var_1b7407dffe81e6e8.typeindexes[type];
}

function private function_3ee172d5f412da21() {
  level.var_1b7407dffe81e6e8.spawndatamap = function_38228778814192a();
  level.var_1b7407dffe81e6e8.var_ba936a320ae753dd = getdvarint(@ "hash_b44c01cc57de403d", 15);
  function_24d627b48a11f1f1(level.var_1b7407dffe81e6e8.spawndatamap);
  function_fa609575f2417f18(level.var_1b7407dffe81e6e8.spawndatamap);
}

function private function_24d627b48a11f1f1(spawndatamap) {
  if(!poi_issystemactive()) {
    return;
  }

  var_fcf22b7b64b65cd5 = getdvarint(@ "hash_870dad054972bf3e", 2);
  var_d4a378ed7d56a57a = [];

  foreach(poiname, _ in level.poi) {
    tospawn = getdvarint(hashcat(@ "hash_c6cea952b5d6724c", poiname), ter_op(issubstr(poiname, "suburb"), 0, var_fcf22b7b64b65cd5));

    if(tospawn > 0) {
      var_d4a378ed7d56a57a[poiname] = tospawn;
    }
  }

  var_4e01f7c3200a9adb = 0;

  while(true) {
    [name, spawndata] = function_b77f6d389fed1407(spawndatamap);

    if(!isDefined(name) || !isDefined(spawndata)) {
      return;
    }

    foreach(index, node in spawndata.nodes) {
      if(!isDefined(node.poi)) {
        node.poi = poi_findpoioriginisin(node.origin, 1);
      }

      if(isDefined(node.poi) && isDefined(var_d4a378ed7d56a57a[node.poi]) && var_d4a378ed7d56a57a[node.poi] > 0 && function_39c4f5c52fb521d8(node.origin, spawndata.exclusionradius, spawndata.var_51f461a8e820667b, name) && !namespace_7789f919216d38a2::function_cdcab1374db7f007(node.origin)) {
        function_fbac8fe5cba1bccd(node, name, spawndata, getdvarint(@ "hash_4ca9133f642d177f", 0) == 1);
        var_d4a378ed7d56a57a[node.poi]--;

        if(var_d4a378ed7d56a57a[node.poi] <= 0) {
          var_d4a378ed7d56a57a[node.poi] = undefined;
        }

        spawndata.nodes[index] = undefined;
        var_4e01f7c3200a9adb++;

        if(var_4e01f7c3200a9adb >= level.var_1b7407dffe81e6e8.var_ba936a320ae753dd) {
          var_4e01f7c3200a9adb -= level.var_1b7407dffe81e6e8.var_ba936a320ae753dd;
          waitframe();
        }

        if(var_d4a378ed7d56a57a.size <= 0) {
          return;
        }

        spawndata.spawned++;

        if(spawndata.spawned >= spawndata.tospawn) {
          break;
        }
      }
    }

    spawndatamap[name] = undefined;
  }
}

function private function_fa609575f2417f18(spawndatamap) {
  var_4e01f7c3200a9adb = 0;

  while(true) {
    [name, spawndata] = function_b77f6d389fed1407(spawndatamap);

    if(!isDefined(name) || !isDefined(spawndata)) {
      break;
    }

    if(spawndata.spawned < spawndata.tospawn) {
      foreach(node in spawndata.nodes) {
        if(!isDefined(node.poi)) {
          node.poi = poi_findpoioriginisin(node.origin, 1);
        }

        if(function_39c4f5c52fb521d8(node.origin, spawndata.exclusionradius, spawndata.var_51f461a8e820667b, name) && (!poi_issystemactive() || !isDefined(node.poi) || poi_ispoiactive(node.poi)) && !namespace_7789f919216d38a2::function_cdcab1374db7f007(node.origin)) {
          function_fbac8fe5cba1bccd(node, name, spawndata, getdvarint(@ "hash_4ca9133f642d177f", 0) == 1);
          var_4e01f7c3200a9adb++;

          if(var_4e01f7c3200a9adb >= level.var_1b7407dffe81e6e8.var_ba936a320ae753dd) {
            var_4e01f7c3200a9adb -= level.var_1b7407dffe81e6e8.var_ba936a320ae753dd;
            waitframe();
          }

          spawndata.spawned++;

          if(spawndata.spawned >= spawndata.tospawn) {
            break;
          }
        }
      }
    }

    spawndatamap[name] = undefined;
  }
}

function function_f222bd80432744ff(name) {
  triggerowner = self;
  spawndata = function_6507dea837a9799c(name);
  activity = function_aebc13d5b1e8d58d();

  if(isDefined(triggerowner.var_6a9a1aeeaa7c25df)) {
    activity.fortress = triggerowner;
  }

  activity.tasks[0] = [[spawndata.createfunc]](activity, triggerowner);
  activity.cashreward = spawndata.cashreward;
  activity.name = name;
  activity.origin = triggerowner.origin;
  activity.type = spawndata.type;
  level.var_1b7407dffe81e6e8.activities[activity.id] = activity;
  return activity function_5c8fa034ed436a02();
}

function private function_fbac8fe5cba1bccd(node, name, spawndata, debug) {
  if(poi_issystemactive() && !isDefined(node.poi)) {
    node.poi = poi_findpoioriginisin(node.origin, 1);
  }

  if(function_2d421d1f793f6f93() && !isDefined(node.fortress)) {
    node.fortress = function_c0a211a69f5f8f2f(node.origin);
  }

  function_d4d97591648f4390(node.origin, spawndata.exclusionradius, name);
  activity = function_aebc13d5b1e8d58d();
  activity.tasks[0] = [[spawndata.createfunc]](activity, node);
  activity.cashreward = spawndata.cashreward;
  activity.name = name;
  activity.origin = node.origin;
  activity.poi = node.poi;
  activity.fortress = node.fortress;
  activity.type = spawndata.type;
  level.var_1b7407dffe81e6e8.activities[activity.id] = activity;

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6(name, name, "<dev string:x1f2>", undefined, activity.id, undefined, activity.poi, activity.origin);

  activity thread function_5c8fa034ed436a02();

  if(istrue(debug)) {
    line(node.origin, node.origin + (0, 0, 4096), (0, 1, 1), 1, 0, 20000);
    draw_circle(node.origin + (0, 0, 800), spawndata.exclusionradius, (1, 0, 0), 1, 0, 20000);
    draw_circle(node.origin + (0, 0, 800), spawndata.var_51f461a8e820667b, (1, 1, 0), 1, 0, 20000);
  }

  return activity;
}

function private function_39c4f5c52fb521d8(origin, var_83d4d63f858eebb6, var_fd8a6ebe7ce71b34, name) {
  if(!isDefined(level.var_1b7407dffe81e6e8.exclusionpoints)) {
    level.var_1b7407dffe81e6e8.exclusionpoints = [];
  }

  foreach(point in level.var_1b7407dffe81e6e8.exclusionpoints) {
    dist = distance(origin, point.origin);

    if(istrue(point.onlyexcludename)) {
      if(point.name == name && dist < point.radius) {
        return false;
      }

      continue;
    }

    if(dist < point.radius || dist < var_83d4d63f858eebb6 || point.name == name && dist < var_fd8a6ebe7ce71b34) {
      return false;
    }
  }

  return true;
}

function private function_d4d97591648f4390(origin, radius, name, onlyexcludename) {
  if(!isDefined(level.var_1b7407dffe81e6e8.exclusionpoints)) {
    level.var_1b7407dffe81e6e8.exclusionpoints = [];
  }

  point = spawnStruct();
  point.origin = origin;
  point.radius = radius;
  point.name = name;
  point.onlyexcludename = onlyexcludename;
  level.var_1b7407dffe81e6e8.exclusionpoints[level.var_1b7407dffe81e6e8.exclusionpoints.size] = point;
}

function private function_b77f6d389fed1407(spawndata) {
  if(!isDefined(spawndata) || spawndata.size <= 0) {
    return [undefined, undefined];
  }

  maxpriority = -1;
  bestname = undefined;
  bestdata = undefined;

  foreach(name, data in spawndata) {
    if(data.priority > maxpriority) {
      maxpriority = data.priority;
      bestname = name;
      bestdata = data;
    }
  }

  return [bestname, bestdata];
}

function private function_5c8fa034ed436a02() {
  foreach(index, task in self.tasks) {
    task.index = index;

    if(isDefined(task.funcs["onInit"])) {
      task[[task.funcs["onInit"]]]();
    }
  }
}

function private function_97479a799d6eb103() {
  var_db5b04bc41f47c73 = 0;
  level.var_1b7407dffe81e6e8.teamsinfo = [];

  if(istrue(level.var_1e0470dbb6cf1859)) {
    level namespace_bd614c3c2275579a::function_2e6a3f3e4d2731ea(1);

    if(istrue(level.var_187b57dd871ec189)) {
      foreach(agent in function_b4b9401715cf98ea("everybody")) {
        function_234dfccd8495c7d1(agent.team);
      }

      var_db5b04bc41f47c73 = function_9a83377c98bce82a("everybody");
    }
  } else {
    level function_3ee172d5f412da21();
    level thread function_98c331a3e2621695();
    level function_84ed600d2bd001ad();

    if(getdvarint(@ "hash_5ebc91cfdc6a2402", 0)) {
      level thread namespace_b11859036e02907d::function_7562a66c42d923dc();
    }
  }

  level.var_1b7407dffe81e6e8.totalplayers = level.players.size + var_db5b04bc41f47c73;

  foreach(player in level.players) {
    function_234dfccd8495c7d1(player.team);
  }

  var_93aa5ac7d4107dab = getdvarint(@ "hash_7aa1f51e05f1bd54", 5);

  if(var_93aa5ac7d4107dab > 0) {
    level thread function_672b3bf78b2f92e7(var_93aa5ac7d4107dab);
  }
}

function private function_672b3bf78b2f92e7(var_93aa5ac7d4107dab) {
  while(true) {
    if(level.var_1b7407dffe81e6e8.totalplayers < level.players.size) {
      foreach(player in level.players) {
        if(!isDefined(level.var_1b7407dffe81e6e8.teamsinfo[player.team])) {
          function_234dfccd8495c7d1(player.team);
        }
      }
    }

    level.var_1b7407dffe81e6e8.totalplayers = level.players.size;

    if(istrue(level.var_187b57dd871ec189)) {
      level.var_1b7407dffe81e6e8.totalplayers = level.players.size + level.var_41670c1c65f3d3cf.spawned["everybody"].size;
    }

    wait var_93aa5ac7d4107dab;
  }
}

function private function_234dfccd8495c7d1(teamname) {
  if(!isDefined(level.var_1b7407dffe81e6e8.teamsinfo[teamname])) {
    level.var_1b7407dffe81e6e8.teamlist[level.var_1b7407dffe81e6e8.teamlist.size] = teamname;
    level.var_1b7407dffe81e6e8.teamsinfo[teamname] = spawnStruct();
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].trackingids = [];
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].trackingindex = -1;
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].activities = [];
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].activitiescompleted = 0;
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].active = 0;
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].var_388b0969ae3525f2 = [];

    if(level.var_a4840e7885ef58e > 1) {
      if(!function_5ea5a722c499078f(teamname)) {
        player = getteamdata(teamname, "players")[0];

        if(isDefined(player)) {
          activity = function_ebe9b1e455d46450(player);

          if(isDefined(activity)) {
            activity activity_assign(teamname);
          }
        }
      }
    }
  }
}

function function_821fa443949531c9(missiontrigger, activity) {
  triggerowner = self;
  level endon("game_ended");
  missiontrigger endon("deleted");
  missiontrigger endon("activity_ended");
  missiontrigger.touchents = [];
  missiontrigger.var_3551befc72f03b2d = [];
  triggerowner thread scripts\mp\gametypes\activity_manager::function_f222bd80432744ff(activity);

  while(true) {
    validenter = 0;
    missiontrigger waittill("trigger", ent);

    if(!istrue(triggerowner.unlocked) || istrue(level.var_6e53394b95fde2bf) && !istrue(triggerowner.infiltrated)) {
      continue;
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      if(!isDefined(occupants)) {
        continue;
      }

      foreach(occupant in occupants) {
        if(missiontrigger function_1a0a0367591e7f87(occupant)) {
          validenter = missiontrigger function_7098ff5bc0ec9505(occupant, missiontrigger.entnum, triggerowner);

          if(validenter) {
            missiontrigger function_c4839e806ac50bd6(occupant);
          }
        }
      }

      continue;
    }

    if(missiontrigger function_1a0a0367591e7f87(ent)) {
      validenter = missiontrigger function_7098ff5bc0ec9505(ent, missiontrigger.entnum, triggerowner);

      if(validenter) {
        missiontrigger function_c4839e806ac50bd6(ent);
      }
    }
  }
}

function function_c4839e806ac50bd6(player) {
  missiontrigger = self;
  playerentnum = player getentitynumber();

  if(!isDefined(missiontrigger.touchents[playerentnum])) {
    missiontrigger notify("trigger_enter", player);
    missiontrigger.touchents[playerentnum] = player;
    missiontrigger.var_3551befc72f03b2d[playerentnum] = gettime();
    return;
  }

  missiontrigger.var_3551befc72f03b2d[playerentnum] = gettime();
}

function function_1a0a0367591e7f87(player) {
  triggervol = self;

  if(!isreallyalive(player)) {
    return false;
  }

  if(istrue(triggervol.trigger_off)) {
    return false;
  }

  if(!istrue(level.var_187b57dd871ec189)) {
    if(!isbot(player) && scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
      return false;
    }

    if(!scripts\cp_mp\utility\game_utility::isgameparticipant(player)) {
      return false;
    }

    if(isagent(player) && (!isDefined(player.team) || !isDefined(triggervol.numtouching[player.team]))) {
      return false;
    }
  }

  if(isDefined(player.classname) && player.classname == "script_vehicle") {
    return false;
  }

  return true;
}

function function_7098ff5bc0ec9505(player, triggerentnum, triggerowner) {
  playerentnum = player getentitynumber();
  return function_ced68e0624873af5(player, triggerentnum, triggerowner);
}

function function_a33c10c0682918bd(missiontrigger, var_9399bf62b66519d1) {
  assertex(isDefined(missiontrigger), "<dev string:x203>");
  task = self;
  level endon("game_ended");
  missiontrigger endon("deleted");
  missiontrigger endon("activity_ended");
  var_d0ff518e0d3279c6 = 1;

  if(!isDefined(var_9399bf62b66519d1)) {
    var_9399bf62b66519d1 = 9000;
  }

  var_51785c3dce118d4b = 0;

  if(!isDefined(missiontrigger.var_51785c3dce118d4b)) {
    var_51785c3dce118d4b = 300;
  } else {
    var_51785c3dce118d4b = missiontrigger.var_51785c3dce118d4b;
  }

  resolutions = var_51785c3dce118d4b / 1000;
  assertex(resolutions > 0, "<dev string:x23d>");

  while(true) {
    wait resolutions;
    waittillframeend();

    foreach(playerentnum, touchent in missiontrigger.touchents) {
      if(!isDefined(touchent)) {
        missiontrigger.touchents[playerentnum] = undefined;
        missiontrigger.var_3551befc72f03b2d[playerentnum] = undefined;
        continue;
      }

      assertex(isDefined(missiontrigger.var_3551befc72f03b2d[playerentnum]), "<dev string:x26c>");
      currenttime = gettime();
      var_ca63cbdf2251b4af = currenttime - missiontrigger.var_3551befc72f03b2d[playerentnum];

      if(var_ca63cbdf2251b4af > var_9399bf62b66519d1) {
        missiontrigger notify("trigger_exit", touchent);

        if(isDefined(task.funcs["onPlayerExitTimeout"])) {
          task thread[[task.funcs["onPlayerExitTimeout"]]](touchent);
        }

        missiontrigger.touchents[playerentnum] = undefined;
        missiontrigger.var_3551befc72f03b2d[playerentnum] = undefined;
        continue;
      }

      if(var_ca63cbdf2251b4af > var_51785c3dce118d4b) {
        if(isDefined(task.funcs["onPlayerExitVolume"])) {
          task thread[[task.funcs["onPlayerExitVolume"]]](touchent);
        }

        continue;
      }

      if(istrue(touchent.var_e09c6ea56555f1ed)) {
        if(isDefined(task.funcs["onPlayerReenterVolume"])) {
          task thread[[task.funcs["onPlayerReenterVolume"]]](touchent);
        }
      }
    }
  }
}

function private function_98c331a3e2621695() {
  while(true) {
    foreach(activity in level.var_1b7407dffe81e6e8.activities) {
      if(isDefined(activity)) {
        foreach(team, index in activity.teams) {
          if(!level.var_1b7407dffe81e6e8.teamsinfo[team].active) {
            foreach(player in getteamdata(team, "players")) {
              if(distancesquared(player.origin, activity.origin) < activity.var_8d3a05143c7a1142) {
                activity activity_start(team);
                break;
              }
            }
          }
        }
      }
    }

    wait 1;
  }
}

function function_c509b7faae587820(triggerowner) {
  player = self;

  if(istrue(istrue(player.var_38f4f1b1c66513f1))) {
    return false;
  }

  if(!level.var_1b7407dffe81e6e8.teamsinfo[player.team].active) {
    if(!isDefined(triggerowner.task)) {
      return false;
    }
  } else if(!array_contains(triggerowner.task.players, player)) {
    var_388b0969ae3525f2 = level.var_1b7407dffe81e6e8.teamsinfo[player.team].var_388b0969ae3525f2;

    foreach(activity in var_388b0969ae3525f2) {
      if(!isDefined(activity.tasks)) {
        continue;
      }

      foreach(task in activity.tasks) {
        if(!isDefined(task)) {
          continue;
        }

        if(array_contains(task.players, player)) {
          var_5d7b8825ae739ab4 = distance2d(task.circlecenter, player.origin);
          var_3c7fa17be3f77a08 = distance2d(triggerowner.task.circlecenter, player.origin);

          if(var_5d7b8825ae739ab4 > var_3c7fa17be3f77a08 && !istrue(player.var_38f4f1b1c66513f1)) {
            player thread function_513d7f67ab57c97(task.activity, triggerowner.task.activity);
          }

          return false;
        }
      }
    }
  } else if(array_contains(triggerowner.task.players, player)) {
    return true;
  }

  player playlocalsound("mp_dmz_phone_pickup");
  triggerowner.task.activity activity_assign(player.team, undefined, player, 1);
  triggerowner.task.activity function_6e31cc7110b536fd(player.team);
  return true;
}

function function_ced68e0624873af5(player, triggerentnum, triggerowner) {
  if(isDefined(triggerowner)) {
    return player function_c509b7faae587820(triggerowner);
  }

  return false;
}

function function_18d4e8025ec24a0(task, var_5e671fc71e72d5e8, var_644a33d86d8514bf) {
  var_c893965b0b5cc806 = isDefined(var_5e671fc71e72d5e8);
  var_7baf547d7eb18030 = task.index + 1;

  foreach(var_729f88304cd1d6f8 in task.teams) {
    victor = var_c893965b0b5cc806 && var_729f88304cd1d6f8 == var_5e671fc71e72d5e8;

    if(var_7baf547d7eb18030 >= self.tasks.size) {
      function_83d7eb52598be0b3(var_729f88304cd1d6f8);
      scripts\cp_mp\overlord::function_70979c1eabf04180(getteamdata(var_729f88304cd1d6f8, "players"), self.name);
      level.var_1b7407dffe81e6e8.teamsinfo[var_729f88304cd1d6f8].active = 0;

      if(victor) {
        players = getteamdata(var_729f88304cd1d6f8, "players");

        foreach(player in players) {
          if(!isDefined(player.brmissionscompleted)) {
            player.brmissionscompleted = 0;
          }

          player.brmissionscompleted++;
          player scripts\mp\utility\points::doscoreevent(#"dmz_contract_complete");

          if(istrue(level.var_9fb5000ae38dcf7f)) {
            player setclientomnvar("ui_dmz_missions_completed", 0);
          }

          player scripts\mp\gametypes\br_public::updatebrscoreboardstat("missionsCompleted", player.brmissionscompleted);

          if(istrue(level.gamemodebundle.var_b0c3d102a683d3ee)) {
            player dlog_recordplayerevent("dlog_event_exgm_player_mission_complete", ["mission_ref", task.ref, "completion_state", "success"]);
          }
        }

        level.var_1b7407dffe81e6e8.teamsinfo[var_729f88304cd1d6f8].activitiescompleted++;
        namespace_e77194a0203f683::function_1ef65d2654424502(self, "success", var_5e671fc71e72d5e8);
        starterpoi = undefined;

        if(isDefined(self.activitystarter) && isDefined(self.activitystarter.starterpoi)) {
          starterpoi = self.activitystarter.starterpoi;
        }

        scripts\mp\pmc_missions::function_a9f8fa06a358585b(var_5e671fc71e72d5e8, self.name, 1, starterpoi);

        if(isDefined(level.var_faa873310add1096)) {
          level[[level.var_faa873310add1096]](var_729f88304cd1d6f8, self);
        }
      }

      if(!istrue(var_644a33d86d8514bf)) {
        thread function_137d718c82ac0947(var_729f88304cd1d6f8);
      }

      continue;
    }

    self.tasks[var_7baf547d7eb18030].teams[self.tasks[var_7baf547d7eb18030].teams.size] = var_729f88304cd1d6f8;
    self.teams[var_729f88304cd1d6f8] = var_7baf547d7eb18030;
    function_b7bbe29ed551ee90(self.tasks[var_7baf547d7eb18030].refindex, self.tasks[var_7baf547d7eb18030].tier, var_729f88304cd1d6f8);
    function_675059586a84fa06(var_729f88304cd1d6f8, "onTeamStart");
    self.tasks[var_7baf547d7eb18030].started = 1;
  }

  if(var_7baf547d7eb18030 >= self.tasks.size) {
    activity_ended(var_5e671fc71e72d5e8);
  }

  task notify("task_ended");
}

function activity_ended(var_5e671fc71e72d5e8) {
  level.var_1b7407dffe81e6e8.activities[self.id] = undefined;

  if(isDefined(self.activitystarter)) {
    level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38 = array_remove(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38, self.activitystarter);
    self.activitystarter setscriptablepartstate("brloot_activity_starter", "hidden");
  }

  foreach(team, task in self.teams) {
    level.var_1b7407dffe81e6e8.teamsinfo[team].activities = array_remove(level.var_1b7407dffe81e6e8.teamsinfo[team].activities, self.id);

    if(!function_5ea5a722c499078f(team)) {
      function_d8625665d55f3941(team, 1);
    }

    if(level.var_a4840e7885ef58e > 0) {
      if(!function_5ea5a722c499078f(team)) {
        player = getteamdata(team, "players")[0];

        if(isDefined(player)) {
          activity = function_ebe9b1e455d46450(player);

          if(isDefined(activity)) {
            activity activity_assign(team);
          }
        }
      }
    }

    if(!level.var_1b7407dffe81e6e8.teamsinfo[team].active) {
      function_3fd9d5652f4642ad(team);
    }
  }
}

function private activity_start(team) {
  assertex(!level.var_1b7407dffe81e6e8.teamsinfo[team].active, "<dev string:x29d>");
  level.var_1b7407dffe81e6e8.teamsinfo[team].active = 1;
  function_675059586a84fa06(team, "onTeamStart");
  self.tasks[0].started = 1;
  task = function_73fd6fe2488e3ebf(self, team);
  function_b7bbe29ed551ee90(task.refindex, function_f8cd22fb229f4138(self.cashreward), team);
}

function private function_6e31cc7110b536fd(team) {
  level.var_1b7407dffe81e6e8.teamsinfo[team].active = 1;
  self.tasks[0].started = 1;
}

function function_bf253015ff42711(player, team) {
  assert(function_5ea5a722c499078f(team), "<dev string:x2e5>");
  activity = function_b1d0568d9066a2ce(team);
  activity function_d36579bab450735a(player, team);

  foreach(task in activity.tasks) {
    if(isDefined(task.funcs["onPlayerJoined"])) {
      task thread[[task.funcs["onPlayerJoined"]]](player);
    }
  }

  activity function_37db4c1f01e80f2f(team);
}

function function_90603f537224e960() {
  task_ended();

  if(isDefined(self.funcs["onForceEnd"])) {
    self thread[[self.funcs["onForceEnd"]]]();
  }
}

function function_8d4a1199159f7d52(team) {
  if(isDefined(self.funcs["onCancel"])) {
    self thread[[self.funcs["onCancel"]]](team);
  }
}

function function_b2aef739a3653a70(player, team) {
  assert(function_5ea5a722c499078f(team), "<dev string:x326>");
  activity = function_b1d0568d9066a2ce(team);
  function_6d93be335873296e(player);

  if(isDefined(activity.tasks[0].icon)) {
    activity.tasks[0] function_401535e3fa9e171c(player);
  } else if(isDefined(activity.tasks[0].objidnum)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(activity.tasks[0].objidnum, player);
  }

  foreach(task in activity.tasks) {
    if(isDefined(task.funcs["onPlayerRemoved"])) {
      task thread[[task.funcs["onPlayerRemoved"]]](player);
    }

    if(istrue(level.gamemodebundle.var_b0c3d102a683d3ee)) {
      player dlog_recordplayerevent("dlog_event_exgm_player_mission_complete", ["mission_ref", task.ref, "completion_state", "failed - task cancelled"]);
    }
  }

  if(isDefined(activity.var_972eddbdcf30619c)) {
    activity.var_972eddbdcf30619c = array_remove(activity.var_972eddbdcf30619c, player);
  }

  if(!activity.tasks[0] function_c251e35450891f3()) {
    activity.tasks[0] function_8d4a1199159f7d52(team);
    return;
  }

  activity function_37db4c1f01e80f2f(team);
}

function function_513d7f67ab57c97(toremove, toadd) {
  player = self;

  if(istrue(player.var_38f4f1b1c66513f1)) {
    return false;
  }

  player.var_38f4f1b1c66513f1 = 1;
  toremove function_b2aef739a3653a70(player, player.team);
  wait 3;
  player playlocalsound("mp_dmz_phone_pickup");
  toadd activity_assign(player.team, undefined, player, 1);
  toadd function_6e31cc7110b536fd(player.team);
  player.var_38f4f1b1c66513f1 = 0;
  return true;
}

function function_22e206cc7ae5dbfd(player, oldteam, newteam) {
  if(function_5ea5a722c499078f(oldteam)) {
    function_b2aef739a3653a70(player, oldteam);
  }

  function_6d93be335873296e(player);
  var_3dd2c57ac95be94f = function_5ea5a722c499078f(newteam);

  if(function_5ea5a722c499078f(newteam)) {
    function_bf253015ff42711(player, newteam);
  }

  function_64623e2ff7409f39(player, !var_3dd2c57ac95be94f || istrue(player.canhackcontracts));
}

function activity_assign(team, taskindex, var_27e49251bb3376ea, var_21d04ce2f9146315) {
  if(function_5ea5a722c499078f(team) && !istrue(var_21d04ce2f9146315)) {
    return;
  }

  if(!isDefined(taskindex)) {
    taskindex = 0;
  }

  if(isDefined(self.activitystarter)) {
    level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38 = array_remove(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38, self.activitystarter);
    self.activitystarter setscriptablepartstate("brloot_activity_starter", "hidden");
  }

  if(istrue(level.var_9fb5000ae38dcf7f)) {
    foreach(player in getteamdata(team, "players")) {
      player setclientomnvar("ui_dmz_missions_completed", 1);
    }
  }

  if(isDefined(var_27e49251bb3376ea) && !scripts\cp_mp\utility\game_utility::isaigameparticipant(var_27e49251bb3376ea)) {
    function_d8625665d55f3941(team, 0);
    scripts\cp_mp\overlord::function_2c722a2ef9574e87(getteamdata(team, "players"), self.name, 75);
  }

  self.teams[team] = taskindex;

  if(!array_contains(self.tasks[taskindex].teams, team)) {
    self.tasks[taskindex].teams[self.tasks[taskindex].teams.size] = team;
  }

  level.var_1b7407dffe81e6e8.teamsinfo[team].activities = array_add(level.var_1b7407dffe81e6e8.teamsinfo[team].activities, self.id);
  self.var_7ca287a82f54e4f6 = var_27e49251bb3376ea;

  if(isDefined(var_27e49251bb3376ea) && !scripts\cp_mp\utility\game_utility::isaigameparticipant(var_27e49251bb3376ea)) {
    thread function_415205c2b0df5476(team, var_27e49251bb3376ea);
  }

  foreach(task in self.tasks) {
    if(isDefined(task.funcs["onTeamAssigned"])) {
      task thread[[task.funcs["onTeamAssigned"]]](team);
    }

    if(isDefined(var_27e49251bb3376ea) && isDefined(task.funcs["onPlayerAssigned"]) && isDefined(task.funcs["onPlayerJoined"])) {
      task function_ecef3f5e98fb83c1(team, var_27e49251bb3376ea);
    }

    if(istrue(level.gamemodebundle.var_b0c3d102a683d3ee)) {
      foreach(player in getteamdata(team, "players")) {
        player dlog_recordplayerevent("dlog_event_exgm_player_mission_assign", ["mission_ref", task.ref]);
      }
    }
  }

  starterpoi = undefined;

  if(isDefined(self.activitystarter) && isDefined(self.activitystarter.starterpoi)) {
    starterpoi = self.activitystarter.starterpoi;
  }

  if(isDefined(var_27e49251bb3376ea)) {
    scripts\mp\pmc_missions::function_a9f8fa06a358585b(team, self.name, 0, starterpoi);
  }

  scripts\cp_mp\talking_gun::function_44cdb18eb18593de(team, self);
}

function function_ecef3f5e98fb83c1(teamname, player) {
  task = self;
  var_f1c8753e7038e53f = task.teams.size == 1;
  assignfirstplayer = task.players.size == 0;
  var_404766db14e343f = 0;
  var_96710dfe8fa22d93 = 0;
  size = level.var_1b7407dffe81e6e8.teamsinfo[teamname].var_388b0969ae3525f2.size;

  if(assignfirstplayer) {
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].var_388b0969ae3525f2[size] = task.activity;
    task thread[[task.funcs["onPlayerAssigned"]]](teamname, player);
    return;
  }

  if(task.teams.size >= 0) {
    foreach(activityplayer in task.players) {
      if(!isDefined(activityplayer) || !isDefined(activityplayer.team)) {
        continue;
      }

      if(player.team == activityplayer.team) {
        var_404766db14e343f = 1;
        break;
      }
    }

    if(!var_404766db14e343f && !var_f1c8753e7038e53f) {
      var_96710dfe8fa22d93 = 1;
    }
  }

  if(var_404766db14e343f) {
    task thread[[task.funcs["onPlayerJoined"]]](player);
    return;
  }

  if(!assignfirstplayer && var_96710dfe8fa22d93) {
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].var_388b0969ae3525f2[size] = task.activity;
    task thread[[task.funcs["onPlayerAssigned"]]](teamname, player);
    return;
  }

  assertex(0, "<dev string:x36f>");
}

function private function_d36579bab450735a(player, team) {
  if(istrue(level.var_427f173fa29d4e80) && !istrue(level.var_1e0470dbb6cf1859)) {
    task = function_73fd6fe2488e3ebf(self, team);
    function_b43e9536b7e60884(player, task.refindex);
  }

  if(isDefined(self.tasks[0].icon)) {
    self.tasks[0] function_fbf23ae15945ee5a(player);
    return;
  }

  if(isDefined(self.tasks[0].objidnum)) {
    objective_showtoplayersinmask(self.tasks[0].objidnum);
  }
}

function private function_415205c2b0df5476(team, var_27e49251bb3376ea) {
  info = level.var_1b7407dffe81e6e8.teamsinfo[team];
  info.trackingindex += 1;
  info.trackingindex = ter_op(info.trackingindex >= level.var_fc3962361e2033a9, 0, info.trackingindex);

  foreach(index, id in info.trackingids) {
    if(!isDefined(level.var_1b7407dffe81e6e8.activities[id])) {
      info.trackingindex = index;
    }
  }

  if(isDefined(info.trackingids[info.trackingindex])) {
    prevactivity = level.var_1b7407dffe81e6e8.activities[info.trackingids[info.trackingindex]];

    if(isDefined(prevactivity)) {
      if(level.var_d1404cd77b68f22e == 0) {
        return;
      }

      if(isDefined(self.tasks[0].icon)) {
        prevactivity.tasks[0] function_743033b2e6c2d930(team);
      } else if(isDefined(self.tasks[0].objidnum)) {
        prevactivity.tasks[0] function_e8d8df3da4392f0f(team);
      }
    }
  }

  info.trackingids[info.trackingindex] = self.id;

  if(istrue(level.var_427f173fa29d4e80) && !istrue(level.var_1e0470dbb6cf1859)) {
    task = function_73fd6fe2488e3ebf(self, team);
    function_b7bbe29ed551ee90(task.refindex, function_f8cd22fb229f4138(self.cashreward), team);
  }

  if(!isDefined(self.tasks[0].icon) && !isDefined(self.tasks[0].objidnum)) {
    return;
  }

  self.tasks[0] endon("task_ended");
  self.tasks[0] function_ced2dbd3ba98d2(team, var_27e49251bb3376ea, 1);
}

function function_ced2dbd3ba98d2(team, var_27e49251bb3376ea, shouldping) {
  wait 2.4;

  if(isDefined(self.icon)) {
    function_a92867e16c21da22(team);
  } else if(isDefined(self.objidnum)) {
    function_30c89ac91cfae119(team);
  }

  if(!isDefined(var_27e49251bb3376ea)) {
    return;
  }

  if(istrue(shouldping)) {
    wait 2;

    if(isDefined(self.objidnum) || isDefined(self.icon)) {
      origin = self.origin;

      if(isDefined(self.iconorigin)) {
        origin = self.iconorigin;
      }

      if(isDefined(self.curorigin)) {
        origin = self.curorigin;
      }

      if(isDefined(self.offset3d)) {
        origin += self.offset3d;
      }

      idnum = default_to(self.icon, self.objidnum);
      scripts\mp\objidpoolmanager::objective_set_play_intro(idnum, 0);
      var_27e49251bb3376ea scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, origin, idnum);
    }
  }
}

function private function_3fd9d5652f4642ad(team) {
  if(!function_5ea5a722c499078f(team)) {
    return;
  }

  mainplayer = getteamdata(team, "players")[0];

  if(!isDefined(mainplayer)) {
    return;
  }

  closestid = level.var_1b7407dffe81e6e8.teamsinfo[team].activities[0];
  closestdist = 100000000;

  foreach(id in level.var_1b7407dffe81e6e8.teamsinfo[team].activities) {
    activityloc = level.var_1b7407dffe81e6e8.activities[id].origin;
    dist = distancesquared(activityloc, mainplayer.origin);
    assertex(isDefined(dist), "<dev string:x395>" + level.var_1b7407dffe81e6e8.activities[id].tasks[0].ref);

    if(dist < closestdist) {
      closestdist = dist;
      closestid = id;
    }
  }

  if(!array_contains(level.var_1b7407dffe81e6e8.teamsinfo[team].trackingids, closestid)) {
    level.var_1b7407dffe81e6e8.activities[closestid] thread function_415205c2b0df5476(team, mainplayer);
  }
}

function function_ca85c43247ab6279() {
  if(isDefined(level.var_1b7407dffe81e6e8.teamsinfo[self.team].activities)) {
    foreach(activityindex in level.var_1b7407dffe81e6e8.teamsinfo[self.team].activities) {
      activity = level.var_1b7407dffe81e6e8.activities[activityindex];

      foreach(task in activity.tasks) {
        if(isDefined(task.funcs["onExtract"])) {
          task thread[[task.funcs["onExtract"]]](self);
        }
      }

      if(istrue(level.gamemodebundle.var_b0c3d102a683d3ee) && function_5ea5a722c499078f(self.team) && isDefined(activity)) {
        self dlog_recordplayerevent("dlog_event_exgm_player_mission_complete", ["mission_ref", activity.tasks[0].ref, "completion_state", "failed - extracted"]);
      }
    }
  }
}

function private function_aebc13d5b1e8d58d() {
  activity = spawnStruct();
  activity.currenttask = 0;
  activity.id = function_a4316795af2639f3();
  activity.teams = [];
  activity.tasks = [];
  activity.markerradius = 2500;
  activity.var_8d3a05143c7a1142 = activity.markerradius * activity.markerradius;
  activity.origin = (0, 0, 0);
  activity.var_75ded47b03386e57 = 0;
  return activity;
}

function private function_a4316795af2639f3() {
  if(!isDefined(level.var_1b7407dffe81e6e8.var_8d03da3910129d74)) {
    level.var_1b7407dffe81e6e8.var_8d03da3910129d74 = 0;
  } else {
    level.var_1b7407dffe81e6e8.var_8d03da3910129d74 += 1;
  }

  return level.var_1b7407dffe81e6e8.var_8d03da3910129d74;
}

function private function_4a6adeb5f340fcc8() {
  level endon("game_ended");

  while(!isDefined(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38)) {
    waitframe();
  }

  var_b30b3c96c21fb5d8 = 160000;
  function_ae35ae0fa34731b8(var_b30b3c96c21fb5d8);

  while(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38.size > 0) {
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.origin) && isDefined(player.team) && isalive(player) && (!function_5ea5a722c499078f(player.team) || istrue(player.canhackcontracts))) {
        closestphone = function_c1ac85f526f2b937(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38, player.origin, 400);

        if(isDefined(closestphone)) {
          player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_dmz_activity_starter_activity_type", closestphone.var_dabe413c9c6c48f4);
          player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_dmz_activity_starter_poi_name", closestphone.poiindex);
          namespace_210d6dd43cfaf195::function_604a7fc1fb4b6dfd(closestphone, player);
        }
      }
    }

    wait 1;
  }
}

function private function_ae35ae0fa34731b8(mindistancesq) {
  foreach(activitystarter in level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38) {
    foreach(var_81a6258c743174db in level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38) {
      if(activitystarter == var_81a6258c743174db) {
        continue;
      }

      if(distancesquared(activitystarter.origin, var_81a6258c743174db.origin) <= mindistancesq) {
        println("<dev string:x3b1>");
      }
    }
  }
}

function private function_84ed600d2bd001ad() {
  level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38 = [];
  var_d48061d99a12dd19 = [];

  foreach(activity in level.var_1b7407dffe81e6e8.activities) {
    if(!isDefined(var_d48061d99a12dd19[activity.type])) {
      var_d48061d99a12dd19[activity.type] = [];
    }

    var_d48061d99a12dd19[activity.type][var_d48061d99a12dd19[activity.type].size] = activity;
  }

  var_b1e6cfea54837661 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_activity_starter");
  var_b1e6cfea54837661 = function_879faf1bea33f06(var_b1e6cfea54837661);
  var_202f4b66718ab8bd = [];

  foreach(activitystarter in var_b1e6cfea54837661) {
    type = getsubstr(activitystarter.type, 24);

    if(!isDefined(var_202f4b66718ab8bd[type])) {
      var_202f4b66718ab8bd[type] = [];
    }

    var_202f4b66718ab8bd[type][var_202f4b66718ab8bd[type].size] = activitystarter;
  }

  foreach(type, activitylist in var_d48061d99a12dd19) {
    if(!isDefined(var_202f4b66718ab8bd[type])) {
      assertmsg("<dev string:x454>" + type + "<dev string:x471>");
      continue;
    }

    foreach(activity in activitylist) {
      var_112e955ba5db3f2b = squared(level.var_1b7407dffe81e6e8.spawndatamap[activity.name].var_2ce8f82ad71eb571);
      var_b03ad0ba8c8849ea = squared(level.var_1b7407dffe81e6e8.spawndatamap[activity.name].var_7a62616965ed6a2e);
      activitystarter = activity_getbestspawnpoint(var_202f4b66718ab8bd[type], activity.origin, var_112e955ba5db3f2b, var_b03ad0ba8c8849ea);

      if(isDefined(activitystarter)) {
        var_202f4b66718ab8bd[type] = array_remove(var_202f4b66718ab8bd[type], activitystarter);
        activitystarter.var_d855aa87b99592a = int(clamp(distance(activity.origin, activitystarter.origin) / 200, 1, 100));
        activitystarter.var_dabe413c9c6c48f4 = function_f92c1a3d19210ccd(activity.name);
        activitystarter.poiindex = scripts\mp\poi::function_80cdaea4bd3ecf70(scripts\mp\poi::poi_findpoioriginisin(activity.origin, undefined, undefined, 1));
        activitystarter.starterpoi = scripts\mp\poi::poi_findpoioriginisin(activitystarter.origin, 0, 0, 0);
        activitystarter.activity = activity;
        activity.activitystarter = activitystarter;
        activitystarter function_5220f38b5239eac8();
        level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38[level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38.size] = activitystarter;

        namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x48e>", activity.name, "<dev string:x4a2>", "<dev string:x4b2>", undefined, activity.id, activity.poi, activitystarter.origin);

        if(getdvarint(@ "hash_458fa5763ddccd6b", 0) == 1) {
          line(activitystarter.origin, activity.origin, (0, 0, 1), 1, 0, 20000);
          line(activitystarter.origin, activitystarter.origin + (0, 0, 3000), (1, 0, 1), 1, 0, 20000);
        }
      }
    }
  }

  level notify("activitymanager_initActivityStarters_done");
}

function function_5220f38b5239eac8() {
  if(istrue(level.var_1b7407dffe81e6e8.var_d6d000f64c923fd6)) {
    self setscriptablepartstate("brloot_activity_starter", "visible");
    return;
  }

  self setscriptablepartstate("brloot_activity_starter", "visible_no_icon");
}

function function_66da9365bbfea8b7() {
  level notify("tablethide_kill_callout_" + self.origin);
  self setscriptablepartstate("brloot_activity_starter", "hidden");
}

function private function_879faf1bea33f06(locations) {
  scripts\mp\locksandkeys::function_1a037d5cd64dc892();
  validlocations = [];
  var_229dd59111a2fa54 = getdvarint(@ "hash_b54c660e3e9515b2", 1000);
  var_aa5a3885f8d284dc = var_229dd59111a2fa54 * var_229dd59111a2fa54;

  foreach(location in locations) {
    if((!namespace_7789f919216d38a2::radiation_isinit() || !namespace_7789f919216d38a2::function_cdcab1374db7f007(location.origin)) && scripts\mp\poi::function_9c93e67f90980177(location.origin) && (!isDefined(level.uniquedoors) || level.uniquedoors.size == 0 || distance(sortbydistance(level.uniquedoors, location.origin)[0].origin, location.origin) > 350) && (validlocations.size == 0 || distancesquared(sortbydistance(validlocations, location.origin)[0].origin, location.origin) > var_aa5a3885f8d284dc) && !namespace_9823ee6035594d67::function_f0201365c368cf88(location.origin)) {
      validlocations[validlocations.size] = location;
    }
  }

  return validlocations;
}

function private activity_getbestspawnpoint(structs, origin, mindistancesq, var_205a760f75f8e9d6) {
  bestoption = undefined;
  bestdiff = 999999999;

  foreach(struct in structs) {
    dist = distancesquared(struct.origin, origin);
    diff = abs(dist - var_205a760f75f8e9d6);

    if(diff < bestdiff && dist > mindistancesq) {
      if(bestdiff < 150) {
        return struct;
      }

      bestoption = struct;
      bestdiff = diff;
    }
  }

  return bestoption;
}

function function_ebe9b1e455d46450(player) {
  if(!isDefined(level.var_1b7407dffe81e6e8.activities) || level.var_1b7407dffe81e6e8.activities.size == 0) {
    return undefined;
  }

  if(!isDefined(level.var_1b7407dffe81e6e8.scoring)) {
    function_4b4f24e571cb5af9();
  }

  exfils = getteamdata(player.team, "exfils");
  assert(isDefined(exfils), "<dev string:x4d1>" + player.team);

  if(istrue(level.gamemodebundle.var_b0c3d102a683d3ee)) {
    var_c273b344396d4890 = [];

    foreach(exfil in exfils) {
      if(isDefined(exfil) && !isDefined(exfil.origin) && isDefined(exfil.ent)) {
        var_c273b344396d4890[var_c273b344396d4890.size] = exfil.ent;
      }
    }

    if(var_c273b344396d4890.size == exfils.size) {
      exfils = var_c273b344396d4890;
    } else {
      assert(0, "<dev string:x50c>" + player.name + "<dev string:x51a>");
    }
  }

  playerorigin = player.origin;
  var_2a73d37d4f624825 = undefined;
  var_a96c0ad7583e3d = undefined;
  var_b6b0b797c6ef02e2 = 0;

  if(exfils.size > 0) {
    var_2a73d37d4f624825 = getclosest(playerorigin, exfils).origin;
    var_a96c0ad7583e3d = var_2a73d37d4f624825 - playerorigin;
    var_b6b0b797c6ef02e2 = distance(var_2a73d37d4f624825, playerorigin) > 2000;
  }

  var_c56664807b194adb = sortbydistance(level.var_1b7407dffe81e6e8.activities, playerorigin);
  var_7f767d0b39d7e455 = [];
  var_32f9bd0ca63c013e = 0;

  for(index = 0; index < var_c56664807b194adb.size && var_32f9bd0ca63c013e < 10; index++) {
    activity = var_c56664807b194adb[index];

    if(array_contains_key(activity.teams, player.team)) {
      continue;
    }

    activityorigin = activity.origin;
    score = 0;
    score += function_5f083fb42518423c(playerorigin, activityorigin);

    if(isDefined(var_2a73d37d4f624825)) {
      score += function_2b921d0e6bc242e1(playerorigin, var_2a73d37d4f624825);
    }

    if(var_b6b0b797c6ef02e2) {
      score += function_52bb8aec483e159a(playerorigin, activityorigin, var_a96c0ad7583e3d);
    }

    var_32f9bd0ca63c013e++;
    var_7f767d0b39d7e455[index] = score;
  }

  if(var_32f9bd0ca63c013e <= 0) {
    return undefined;
  }

  var_7f767d0b39d7e455 = function_6c2c22972f70be38(var_7f767d0b39d7e455);
  chosenindex = function_76e8e9f07068ad3(var_7f767d0b39d7e455);

  function_6845df1d2d8832b8(var_c56664807b194adb, var_7f767d0b39d7e455, chosenindex);

  return var_c56664807b194adb[chosenindex];
}

function private function_4b4f24e571cb5af9() {
  scoring = spawnStruct();
  scoring.var_6f1d78292f73ee46 = getdvarfloat(@ "hash_c508e27b819d49b2", 0.15);
  scoring.var_5845ba08c276f11 = getdvarfloat(@ "hash_58211513a78506af", 0.3);
  scoring.var_f9cff5c6714553f7 = getdvarfloat(@ "hash_c321cda536bc126e", 0.3);
  scoring.alignmentweight = getdvarfloat(@ "hash_7cdac9442bc68fb2", 0.25);
  scoring.var_7c0a2bb952bf39c = getdvarfloat(@ "hash_f88016cb082a72ec", 0.5);
  level.var_1b7407dffe81e6e8.scoring = scoring;
}

function private function_5f083fb42518423c(playerorigin, activityorigin) {
  dist = distance(activityorigin, playerorigin);
  var_74f7841a848c74df = (15000 - dist) / 15000;
  var_74f7841a848c74df *= level.var_1b7407dffe81e6e8.scoring.var_6f1d78292f73ee46;
  var_bb7a6b74942c715e = (40000 - dist) / 40000;
  var_bb7a6b74942c715e *= level.var_1b7407dffe81e6e8.scoring.var_5845ba08c276f11;
  return max(0, var_74f7841a848c74df) + max(0, var_bb7a6b74942c715e);
}

function private function_2b921d0e6bc242e1(playerorigin, var_2a73d37d4f624825) {
  dist = distance(var_2a73d37d4f624825, playerorigin);
  distscore = (15000 - dist) / 15000;
  return max(0, distscore * level.var_1b7407dffe81e6e8.scoring.var_f9cff5c6714553f7);
}

function private function_52bb8aec483e159a(playerorigin, activityorigin, var_a96c0ad7583e3d) {
  var_76c8be7626613ca = activityorigin - playerorigin;
  angle = math::anglebetweenvectors(var_76c8be7626613ca, var_a96c0ad7583e3d);
  return max(0, (1 - angle / 180) * level.var_1b7407dffe81e6e8.scoring.alignmentweight);
}

function private function_6c2c22972f70be38(var_5201ad92c6e26086) {
  if(var_5201ad92c6e26086.size <= 1) {
    return var_5201ad92c6e26086;
  }

  minscore = 100;
  maxscore = -100;

  foreach(score in var_5201ad92c6e26086) {
    if(score < minscore) {
      minscore = score;
    }

    if(score > maxscore) {
      maxscore = score;
    }
  }

  range = maxscore - minscore;

  if(range <= 0) {
    foreach(key, score in var_5201ad92c6e26086) {
      var_5201ad92c6e26086[key] = 1;
    }
  } else {
    foreach(key, score in var_5201ad92c6e26086) {
      normalizedscore = max(0, (score - minscore) / range);

      if(normalizedscore < level.var_1b7407dffe81e6e8.scoring.var_7c0a2bb952bf39c) {
        normalizedscore = 0;
      }

      var_5201ad92c6e26086[key] = normalizedscore;
    }
  }

  return var_5201ad92c6e26086;
}

function private function_76e8e9f07068ad3(var_5201ad92c6e26086) {
  totalscore = 0;

  foreach(score in var_5201ad92c6e26086) {
    totalscore += score;
  }

  randomval = randomfloat(totalscore);

  foreach(key, score in var_5201ad92c6e26086) {
    randomval -= score;

    if(randomval <= 0) {
      return key;
    }
  }

  return key;
}

function private function_6845df1d2d8832b8(var_c56664807b194adb, var_7f767d0b39d7e455, chosenindex) {
  if(getdvarint(@ "hash_e0b8b49a793faf58", 0) == 1) {
    for(index = 0; index < var_c56664807b194adb.size; index++) {
      vectorheight = 1000;
      color = (1, 0, 0);
      activity = var_c56664807b194adb[index];

      if(isDefined(var_7f767d0b39d7e455[index])) {
        vectorheight += 4000 * var_7f767d0b39d7e455[index];

        if(index == chosenindex) {
          color = (0, 1, 0);
        } else if(var_7f767d0b39d7e455[index] > 0) {
          color = (0, 0, 1);
        }
      }

      line(activity.origin, activity.origin + (0, 0, vectorheight), color, 1, 0, 800);
    }
  }
}

function function_57ac6111c7db410f(struct, player) {
  instance = struct.instance;
  activity = instance.activity;
  level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38 = array_remove(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38, instance);
  instance setscriptablepartstate("brloot_activity_starter", "hidden");
  player playlocalsound("mp_dmz_phone_pickup");
  player function_9be29ad72a155ee1();

  if(isDefined(activity)) {
    activity activity_assign(player.team, undefined, player);
  }
}

function function_3ab4a84501caacde(container, player) {
  container notify("stopRinging");
  container function_d062142f367ed7b2();
  player function_9be29ad72a155ee1("intel_put_usb_in_tablet");
  activity = function_ebe9b1e455d46450(player);

  if(isDefined(activity)) {
    activity activity_assign(player.team, undefined, player);
  }
}

function function_d8625665d55f3941(team, show) {
  foreach(player in getteamdata(team, "players")) {
    function_64623e2ff7409f39(player, show);
  }
}

function function_64623e2ff7409f39(player, show) {
  if(isDefined(level.var_1b7407dffe81e6e8) && isDefined(level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38) && isDefined(player)) {
    foreach(starter in level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38) {
      if(istrue(show)) {
        starter enablescriptableplayeruse(player);
        continue;
      }

      starter disablescriptableplayeruse(player);
    }
  }
}

function function_5ea5a722c499078f(team) {
  return isDefined(team) && isDefined(level.var_1b7407dffe81e6e8) && isDefined(level.var_1b7407dffe81e6e8.teamsinfo) && isDefined(level.var_1b7407dffe81e6e8.teamsinfo[team]) && isDefined(level.var_1b7407dffe81e6e8.teamsinfo[team].activities) && level.var_1b7407dffe81e6e8.teamsinfo[team].activities.size > 0;
}

function function_37416c14e9703fb6(player) {
  if(!function_5ea5a722c499078f(player.team)) {
    return;
  }

  activity = function_b1d0568d9066a2ce(player.team);

  if(isDefined(activity)) {
    return activity function_43c0a14bae1aa483(player);
  }
}

function function_a2dcdcd112310e33(team, fortress) {
  if(function_5ea5a722c499078f(team)) {
    foreach(id in level.var_1b7407dffe81e6e8.teamsinfo[team].activities) {
      activity = level.var_1b7407dffe81e6e8.activities[id];

      if(isDefined(activity) && isDefined(activity.fortress) && activity.fortress == fortress) {
        return true;
      }
    }
  }

  return false;
}

function function_40143c869e13213(teamname, dialog) {
  soundname = game["dialog"][dialog];
  assertex(isDefined(soundname), "<dev string:x527>" + dialog);

  foreach(teammember in getteamdata(teamname, "players")) {
    teammember queuedialogforplayer(soundname, dialog, 2);
  }
}

function function_73fd6fe2488e3ebf(activity, team) {
  if(isDefined(activity) && isDefined(activity.tasks) && isDefined(activity.teams) && array_contains_key(activity.teams, team)) {
    return activity.tasks[activity.teams[team]];
  }

  return undefined;
}

function private function_675059586a84fa06(team, func) {
  task = function_73fd6fe2488e3ebf(self, team);

  if(isDefined(task) && isDefined(task.funcs[func])) {
    task thread[[task.funcs[func]]](team);
  }
}

function function_43c0a14bae1aa483(player) {
  if(isDefined(self.teams[player.team])) {
    return self.tasks[self.teams[player.team]];
  }

  return undefined;
}

function private function_b1d0568d9066a2ce(team) {
  info = level.var_1b7407dffe81e6e8.teamsinfo[team];
  trackingid = info.trackingids[info.trackingindex];
  currentactivity = level.var_1b7407dffe81e6e8.activities[trackingid];

  if(isDefined(currentactivity)) {
    return currentactivity;
  }
}

function private function_c251e35450891f3() {
  foreach(team in self.teams) {
    players = getteamdata(team, "players");

    if(players.size > 0) {
      return true;
    }
  }

  return false;
}

function function_ad20469c1815a7c7(team, var_693b800e6cd7b21c) {
  task = self;
  activeteamplayers = [];
  players = [];

  foreach(player in task.players) {
    if(!isDefined(player) || !isDefined(player.team)) {
      continue;
    }

    var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

    if(var_aa128e29d7c10074 && !var_693b800e6cd7b21c) {
      continue;
    }

    var_5c5d5d857ce5fd60 = array_contains(task.teams, team);
    var_87d653f5e64be2d7 = player.team == team;
    var_33a0c14b002fd190 = array_contains(task.teams, player.team);

    if(isDefined(team) && !var_5c5d5d857ce5fd60) {
      continue;
    }

    if(isDefined(team) && !var_87d653f5e64be2d7) {
      continue;
    }

    if(!isDefined(team) && !var_33a0c14b002fd190) {
      continue;
    }

    players[players.size] = player;
  }

  return players;
}

function function_133eba493f1f3636(team) {
  if(!isDefined(self.var_972eddbdcf30619c)) {
    self.var_972eddbdcf30619c = [];
  }

  numplayers = 0;
  playersonteam = getsquadmates(team, undefined, 1);

  foreach(player in playersonteam) {
    if(array_contains(self.var_972eddbdcf30619c, player)) {
      numplayers++;
    }
  }

  return numplayers;
}

function function_37db4c1f01e80f2f(team) {
  if(!isDefined(self.var_972eddbdcf30619c)) {
    self.var_972eddbdcf30619c = [];
  }

  playersonteam = getsquadmates(team, undefined, 1);

  if(function_133eba493f1f3636(team) == playersonteam.size) {
    if(!istrue(self.tasks[0].var_bb74e27bbadcc48b)) {
      level thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("mission_cancel_complete", team, 1);
    }

    self.tasks[0] function_8d4a1199159f7d52(team);

    foreach(player in playersonteam) {
      player setclientomnvar("ui_br_contract_cancellation_state", 0);
    }

    if(!istrue(self.tasks[0].var_2fa3a0c38dfce74b)) {
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_contract_cancelled_" + self.type, playersonteam);
    }

    return true;
  }

  return false;
}

function function_15ab6babbe46e018() {
  if(isDefined(self) && isDefined(self.team) && function_5ea5a722c499078f(self.team)) {
    activity = function_b1d0568d9066a2ce(self.team);

    if(!isDefined(activity)) {
      assertmsg("<dev string:x576>");
      return;
    }

    if(!isDefined(activity.var_972eddbdcf30619c)) {
      activity.var_972eddbdcf30619c = [];
    }

    if(array_contains(activity.var_972eddbdcf30619c, self)) {
      activity function_37db4c1f01e80f2f(self.team);
      return;
    }

    activity.var_972eddbdcf30619c[activity.var_972eddbdcf30619c.size] = self;

    if(!activity function_37db4c1f01e80f2f(self.team)) {
      squadmates = getsquadmates(self.team, undefined, 1);
      scripts\cp_mp\overlord::playevent("mission_cancel_request", array_remove_array(squadmates, activity.var_972eddbdcf30619c));
      var_7aa06be6f06bef26 = activity function_133eba493f1f3636(self.team);
      totalplayers = squadmates.size;
      combineddata = var_7aa06be6f06bef26 | totalplayers << 3;

      foreach(player in squadmates) {
        player setclientomnvar("ui_br_contract_cancellation_state", combineddata);
      }

      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_contract_pending_" + activity.type, squadmates, undefined, combineddata);
    }
  }
}

function function_279c4202b5ed4980(notification, value) {
  if(isDefined(notification)) {
    switch (notification) {
      case #"hash_9fd64c8b171158f":
        function_15ab6babbe46e018();
        break;
    }
  }
}