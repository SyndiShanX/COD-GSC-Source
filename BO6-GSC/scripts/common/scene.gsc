/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\scene.gsc
**************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace scene;

function private event_handler[bootstrap] boot_strap(struct) {
  level.var_18c87c2c4c3b0a2d = [];
  level.var_8b929db1c0421d07 = [];
}

function private event_handler[spawnstruct] spawn_struct(struct) {
  if(isDefined(struct.script_scenescriptbundle)) {
    level.var_18c87c2c4c3b0a2d[level.var_18c87c2c4c3b0a2d.size] = struct.script_scenescriptbundle;
    level.var_8b929db1c0421d07[level.var_8b929db1c0421d07.size] = struct;
  }
}

function play(existingentities, shotnames, scriptbundlename, fromtimefrac) {
  sceneroot = self;
  sceneroot scene_play_internal(existingentities, shotnames, scriptbundlename, fromtimefrac);
}

function pre_stream_play(prestreamtime = 1, existingentities, shotnames, scriptbundlename, fromtimefrac) {
  sceneroot = self;

  if(!getdvarint(@ "hash_51251a5223126524", 0)) {
    sceneroot pre_stream(existingentities, shotnames, prestreamtime, scriptbundlename);
  }

  wait prestreamtime;
  sceneroot play(existingentities, shotnames, scriptbundlename, fromtimefrac);
}

function init(existingentities, shotnames, scriptbundlename) {
  sceneroot = self;
  return sceneroot function_2d539a8d693b3dbb(existingentities, shotnames, scriptbundlename, "scene_init_user");
}

function skip(shotnames, timefromend = 0.5, fadeinouttime = 0.5) {
  sceneroot = self;
  sceneplay = sceneroot function_42248a6e028ecfa2(shotnames, 0);

  if(!isDefined(sceneplay)) {
    iprintln("<dev string:x24>");

    return;
  }

  sceneplay scene_play_skip(timefromend, fadeinouttime);
}

function stop() {
  sceneroot = self;
  sceneroot function_b4cfd3b6e6f6987d();

  if(sceneroot get_state() == "Playing") {
    foreach(sceneplay in sceneroot.scenedata.sceneplay) {
      sceneplay thread scene_play_stop(1);
    }

    waittillframeend();

    while(sceneroot get_state() == "Playing") {
      waitframe();
    }

    sceneroot function_c17d9607a8faffc3("callback_stop");
  }
}

function stop_object(var_e8498804c99bde6b) {
  sceneroot = self;
  sceneobjectdata = undefined;

  if(isent(var_e8498804c99bde6b)) {
    sceneobjectdata = var_e8498804c99bde6b.sceneobjectdata;
  } else if(isDefined(sceneroot)) {
    sceneobjectdata = sceneroot get_object(var_e8498804c99bde6b);
  }

  if(isDefined(sceneobjectdata.sceneroot)) {
    if(isDefined(sceneobjectdata.index)) {
      sceneobjectdata.sceneroot function_2302629af55b51bd(sceneobjectdata.index);
    }

    sceneobjectdata function_741d59e7b6c8d2fc(sceneobjectdata.sceneroot, sceneobjectdata.sceneplay, undefined);
  }
}

function pause(pausestate = 1) {
  sceneroot = self;
  sceneroot function_b4cfd3b6e6f6987d();

  if(sceneroot get_state() == "Playing") {
    foreach(sceneplay in sceneroot.scenedata.sceneplay) {
      sceneplay thread scene_play_pause(pausestate);
    }
  }
}

function cleanup(forcedeleteall) {
  sceneroot = self;

  if(forcedeleteall) {
    sceneroot.scenestatic = undefined;
  }

  if(forcedeleteall && isDefined(sceneroot.var_c46929fa56699327)) {
    foreach(entity in sceneroot.var_c46929fa56699327) {
      if(!isDefined(entity)) {
        continue;
      }

      if(isagent(entity)) {
        entity.nocorpse = 1;
        entity val::reset_all("scene_shot");
        entity kill();
        continue;
      }

      entity delete();
    }

    sceneroot.var_c46929fa56699327 = undefined;
  }

  if(forcedeleteall) {
    if(sceneroot get_state() == "Playing") {
      sceneroot stop();
    }
  }

  if(isDefined(sceneroot) && !isDefined(sceneroot.var_c46929fa56699327)) {
    sceneroot.var_c46929fa56699327 = [];
  }

  for(sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = sceneroot.scenedata.sceneobjectdata[sceneobjectindex];

    if(isDefined(sceneobjectdata.entity) && !sceneobjectdata.existingentity) {
      if(forcedeleteall) {
        sceneobjectdata object_delete();
        continue;
      }

      if(!isPlayer(sceneobjectdata.entity)) {
        sceneroot.var_c46929fa56699327[sceneobjectdata.entity getentitynumber()] = sceneobjectdata.entity;
      }
    }
  }

  if(isDefined(sceneroot.var_c46929fa56699327) && sceneroot.var_c46929fa56699327.size == 0) {
    sceneroot.var_c46929fa56699327 = undefined;
  }

  if(sceneroot get_state() != "NotSetup") {
    sceneroot scene_reset();
  }

  if(sceneroot get_state() == "NotInit") {
    return;
  }

  if((sceneroot.scenestatic.var_bc227a74d38bdd36 ?? 1) == 1) {
    var_a11daf0a3d76391c = sceneroot.scenestatic.exclusiveplayers ?? level.players;

    foreach(player in var_a11daf0a3d76391c) {
      if(isDefined(player)) {
        player setclientomnvar("ui_scene_shot_index", -1);
      }
    }
  }

  sceneroot scene_set_state("NotInit");
}

function pre_stream(existingentities, shotnames, duration = 5, scriptbundlename = undefined, mode = "prestream_single") {
  sceneroot = self;
  predicttime = 0;

  if(mode == "prestream_predict") {
    predicttime = level.scene.prestreamtime;
  }

  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return;
  }

  scenedata = sceneroot.scenedata;

  if(isDefined(existingentities) && !isarray(existingentities)) {
    existingentities = [existingentities];
  }

  state = sceneroot get_state();
  sceneplay = undefined;
  scenescriptbundle = sceneroot scene_scriptbundle();
  shotindexes = [];

  if(!isDefined(shotnames)) {
    shotnames = sceneroot function_837e044d37c5d180();
  }

  if(!isarray(shotnames)) {
    shotnames = [shotnames];
  }

  foreach(shotname in shotnames) {
    shotindex = scenescriptbundle function_965b893bb918d34d(shotname);
    shotindexes[shotindex] = shotindex;
  }

  foreach(sceneplayiter in scenedata.sceneplay) {
    if(sceneplayiter.state == "Playing") {
      var_ec547618d18454e5 = arrayintersection(sceneplayiter.var_eb6d7fbdd0bb47f8, shotindexes);

      if(var_ec547618d18454e5.size == shotindexes.size) {
        sceneplay = sceneplayiter;
        break;
      }
    }
  }

  if(!isDefined(sceneplay)) {
    sceneplay = sceneroot function_2d539a8d693b3dbb(existingentities, shotnames, undefined, "scene_init_prestream");
  }

  if(isDefined(sceneplay) && sceneplay.var_eb6d7fbdd0bb47f8.size > 0) {
    sceneplay.prestream = spawnStruct();
    sceneplay.prestream.players = [];
    sceneplay.prestream.objects = [];
    sceneplay.prestream.models = undefined;

    debugdisplayindexes = [];

    foreach(shotindex in shotindexes) {
      sceneplay function_69e565b8af8a06a2(shotindex);

      foreach(sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder) {
        if(isDefined(var_1d42c5b8ad0adc80[shotindex])) {
          sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
          sceneobjectdata thread function_3c2e9847ed1dd391(sceneplay, shotindex);
        }
      }

      debugdisplayindexes[debugdisplayindexes.size] = shotindex;

      predicttime -= sceneplay.sceneroot function_b3c7b792a7a154fa(shotindex);

      if(mode == "prestream_simultaneous") {
        continue;
      }

      if(predicttime <= 0) {
        break;
      }
    }

    if(sceneplay.prestream.players.size == 0) {
      iprintlnbold("<dev string:x4f>");
    }

    foreach(playerinfo in sceneplay.prestream.players) {
      entitylist = [];
      entitydist = [];
      modellist = [];
      modeldist = [];
      player = playerinfo.player;
      var_96898119d6bab4bb = 32;

      if(!sceneplay.prestream.models) {
        var_96898119d6bab4bb -= player function_72b767355af09ad8("model");
      }

      foreach(cameraorigin in playerinfo.cameraorigins) {
        closestobjects = sortbydistance(sceneplay.prestream.objects, cameraorigin);

        foreach(objectinfo in closestobjects) {
          dist = distance(cameraorigin, objectinfo.origin);

          if(isent(objectinfo.entity)) {
            key = objectinfo.entity getentitynumber();

            if(!isDefined(entitylist[key])) {
              if(entitylist.size + modellist.size >= var_96898119d6bab4bb) {
                iprintlnbold("<dev string:x77>" + 32);

                break;
              }

              entitylist[key] = objectinfo.entity;
              entitydist[key] = dist;
            } else {
              entitydist[key] = min(entitydist[key], dist);
            }

            continue;
          }

          if(isDefined(objectinfo.model)) {
            key = objectinfo.model;

            if(!isDefined(modellist[key])) {
              if(entitylist.size + modellist.size >= var_96898119d6bab4bb) {
                iprintlnbold("<dev string:x77>" + 32);

                break;
              }

              modellist[key] = objectinfo.model;
              modeldist[key] = dist;
              continue;
            }

            modeldist[key] = min(modeldist[key], dist);
          }
        }
      }

      if(playerinfo.cameraorigins.size > 2) {
        iprintlnbold("<dev string:x9c>");
      }

      if(isDefined(player)) {
        sceneplay scene_debug::function_bbb480647f4f57ab(debugdisplayindexes, duration, playerinfo.cameraorigins);

        player utility::player_prestream_camera(playerinfo.cameraorigins[0], duration, playerinfo.cameraorigins[1]);
        streaments = [];
        streamentsdist = [];

        foreach(key, value in entitylist) {
          streaments[streaments.size] = value;
          streamentsdist[streamentsdist.size] = entitydist[key];
        }

        player utility::player_prestream_assets("entity", streaments, streamentsdist, duration);

        if(sceneplay.prestream.models) {
          streammodels = [];
          streammodelsdist = [];

          foreach(key, value in modellist) {
            streammodels[streammodels.size] = value;
            streammodelsdist[streammodelsdist.size] = modeldist[value];
          }

          player utility::player_prestream_assets("model", streammodels, streammodelsdist, duration);
        }
      }
    }

    sceneplay.prestreamuntil = undefined;

    if(duration > 0) {
      sceneplay.prestreamuntil = gettime() + duration * 1000;
    } else if(duration < 0) {
      sceneplay.prestreamuntil = -1;
    }

    sceneplay.prestream = undefined;
  }
}

function function_837e044d37c5d180(var_2d59f0720490d99b = 1) {
  sceneroot = self;
  scenescriptbundle = sceneroot scene_scriptbundle();
  shotnames = [];
  shotcount = scenescriptbundle function_30fd977cf5a4a95e();
  var_bd6ccb3355b22094 = 0;

  for(shotindex = 0; shotindex < shotcount; shotindex++) {
    shot = scenescriptbundle function_6404fde3adf1f642(shotindex);

    if(var_2d59f0720490d99b || !shot function_22dbcb174ae164e7()) {
      shotnames[var_bd6ccb3355b22094] = shot shot_get_name();
      var_bd6ccb3355b22094++;
    }
  }

  return shotnames;
}

function get_entities(var_efe6d0277f731e05, filter = "all") {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  entities = [];

  if(!isDefined(scenedata)) {
    return entities;
  }

  shotindexes = sceneroot function_4b5fdbefe3851660(var_efe6d0277f731e05);

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(isDefined(shotindexes) && !sceneobjectdata function_11c95ca4a274fbdb(shotindexes)) {
      continue;
    }

    switch (filter) {
      case #"hash_d71fd9ff6b033b7a":
        if(sceneobjectdata.existingentity || sceneobjectdata.sceneobject function_772de5acb2e194c7() != "None") {
          continue;
        }

        break;
    }

    entities[entities.size] = sceneobjectdata.entity;
  }

  return entities;
}

function get_entity(var_a41f0a1e4948cb19) {
  sceneroot = self;
  sceneobjectdata = sceneroot get_object(var_a41f0a1e4948cb19);

  if(isDefined(sceneobjectdata)) {
    return sceneobjectdata.entity;
  }

  return undefined;
}

function get_object(var_e8498804c99bde6b) {
  sceneroot = self;

  if(!(isDefined(sceneroot.scenedata) && isDefined(var_e8498804c99bde6b))) {
    return undefined;
  }

  scenedata = sceneroot.scenedata;

  if(isent(var_e8498804c99bde6b)) {
    if(isDefined(var_e8498804c99bde6b.sceneobjectdata)) {
      assert(var_e8498804c99bde6b.sceneobjectdata.sceneroot === sceneroot);
      return var_e8498804c99bde6b.sceneobjectdata;
    }
  } else if(isint(var_e8498804c99bde6b)) {
    return scenedata.sceneobjectdata[var_e8498804c99bde6b];
  } else if(isstring(var_e8498804c99bde6b)) {
    var_e8498804c99bde6b = scenedata.var_f6e1a451af0a2b43[var_e8498804c99bde6b];

    if(isDefined(var_e8498804c99bde6b)) {
      return scenedata.sceneobjectdata[var_e8498804c99bde6b];
    }
  }

  return undefined;
}

function get_object_alignment(var_a41f0a1e4948cb19, var_f051b54b0cb641b4, scriptbundlename) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return sceneroot;
  }

  if(!isDefined(var_a41f0a1e4948cb19)) {
    return sceneroot;
  }

  scenedata = sceneroot.scenedata;
  sceneobjectdata = sceneroot get_object(var_a41f0a1e4948cb19);

  if(!isDefined(sceneobjectdata)) {
    return sceneroot;
  }

  shotindex = var_f051b54b0cb641b4;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79(shotindex);
  }

  if(!isDefined(shotindex)) {
    return sceneroot;
  }

  if(shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size) {
    return sceneroot;
  }

  alignmentinfo = scenedata.scenescriptbundle function_83bfd4c94b262c65(sceneroot, shotindex, sceneobjectdata.index, sceneobjectdata.alignmentinfo);
  function_7caec59d5958332(alignmentinfo);
  return alignmentinfo;
}

function function_d0df7c35d793d179(var_a41f0a1e4948cb19, var_f051b54b0cb641b4, scriptbundlename) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return [];
  }

  if(!isDefined(var_a41f0a1e4948cb19)) {
    return [];
  }

  scenedata = sceneroot.scenedata;
  sceneobjectdata = sceneroot get_object(var_a41f0a1e4948cb19);

  if(!isDefined(sceneobjectdata)) {
    return [];
  }

  shotindex = var_f051b54b0cb641b4;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79(shotindex);
  }

  if(!isDefined(shotindex)) {
    return [];
  }

  if(shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size) {
    return [];
  }

  return sceneobjectdata function_6bf501072826e845(shotindex);
}

function function_20b3387e3454e668(objecttype, var_efe6d0277f731e05, scriptbundlename) {
  sceneroot = self;
  assert(isstring(objecttype));
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return [];
  }

  scenedata = sceneroot.scenedata;
  objects = [];
  shotindexes = sceneroot function_4b5fdbefe3851660(var_efe6d0277f731e05);

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(sceneobjectdata.sceneobject function_827f7d9bd7a46afd() != objecttype) {
      continue;
    }

    if(isDefined(shotindexes) && !sceneobjectdata function_11c95ca4a274fbdb(shotindexes)) {
      continue;
    }

    objects[objects.size] = sceneobjectdata;
  }

  return objects;
}

function function_91d4fb6d5b238f7c(scenescriptbundlename, sceneobjectname) {
  scriptbundle = getscriptbundle(isxhashasset(scenescriptbundlename) ? scenescriptbundlename : hashcat(%"scenescriptbundle:", scenescriptbundlename));

  if(!isDefined(scriptbundle)) {
    return false;
  }

  aobjects = scriptbundle.objects;

  foreach(sceneobject in aobjects) {
    objectname = sceneobject obj_get_name();

    if(objectname === sceneobjectname) {
      return true;
    }
  }

  return false;
}

function function_a44b4d616d61172d(rate) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();
  sceneroot.scenestatic.animrate = rate;
  function_5d3c9762c4e7799();
}

function function_c3c55ba95cf75724(ishighlod) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(isDefined(sceneobjectdata.entity)) {
      sceneobjectdata.entity namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc(ishighlod);
    }
  }
}

function function_3c9981eea870b966(var_a41f0a1e4948cb19, var_f051b54b0cb641b4, overridetype, overridevalue, scriptbundlename) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return;
  }

  if(!isDefined(var_a41f0a1e4948cb19)) {
    return;
  }

  scenedata = sceneroot.scenedata;
  sceneobjectdata = sceneroot get_object(var_a41f0a1e4948cb19);

  if(!isDefined(sceneobjectdata)) {
    return;
  }

  shotindex = var_f051b54b0cb641b4;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79(shotindex);
  }

  if(!isDefined(shotindex)) {
    return;
  }

  if(shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size) {
    return;
  }

  sceneobjectdata function_bb5b08e9ff4407ee(shotindex, overridetype, overridevalue);
}

function set_scriptbundle(scriptbundlename) {
  sceneroot = self;

  if(isDefined(scriptbundlename)) {
    if(isDefined(sceneroot.script_scenescriptbundle) && sceneroot.script_scenescriptbundle != scriptbundlename) {
      sceneroot cleanup(1);
    }

    sceneroot.script_scenescriptbundle = scriptbundlename;
  }
}

function add_spawn_function(spawnfunc, var_226a1c0234e7ab8b = "_object_all_") {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();
  scenestatic = sceneroot.scenestatic;

  if(!isDefined(scenestatic.spawnfunctions)) {
    scenestatic.spawnfunctions = [];
  }

  if(!isDefined(scenestatic.spawnfunctions[var_226a1c0234e7ab8b])) {
    scenestatic.spawnfunctions[var_226a1c0234e7ab8b] = [];
  }

  scenestatic.spawnfunctions[var_226a1c0234e7ab8b][scenestatic.spawnfunctions[var_226a1c0234e7ab8b].size] = spawnfunc;
}

function get_state() {
  sceneroot = self;

  if(!isDefined(sceneroot.scenedata)) {
    return "NotInit";
  }

  sceneroot function_b4cfd3b6e6f6987d();

  if(sceneroot.scenedata.state == "Setup") {
    foreach(sceneplay in sceneroot.scenedata.sceneplay) {
      if(sceneplay.state === "Playing") {
        return "Playing";
      }
    }

    return "Stopped";
  }

  return sceneroot.scenedata.state;
}

function function_5fe163f439457bd0() {
  players = [];
  sceneroot = self;

  foreach(sceneobjectdata in sceneroot.scenedata.sceneobjectdata) {
    if(sceneobjectdata object_get_type() == "Types_XCam") {
      xcam_players = sceneobjectdata function_931d12df9abebc7f();
      players = arraycombineunique(players, xcam_players);
      continue;
    }

    if(isPlayer(sceneobjectdata.entity)) {
      players = arraycombineunique(players, [sceneobjectdata.entity]);
    }
  }

  return players;
}

function set_exclude_players(exclude_players) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(!exclude_players) {
    sceneroot.scenestatic.excludeplayers = undefined;
    return;
  }

  sceneroot.scenestatic.excludeplayers = 1;
}

function function_f922341b264d32c8(var_22cf99a980b5b2e3) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(!var_22cf99a980b5b2e3) {
    sceneroot.scenestatic.var_9e562de25765fd05 = undefined;
    return;
  }

  sceneroot.scenestatic.var_9e562de25765fd05 = 1;
}

function function_a2a5e7f267b0ca05(var_9cd9c9ecfbed632d) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(isDefined(var_9cd9c9ecfbed632d) && var_9cd9c9ecfbed632d.size > 0) {
    sceneroot.scenestatic.var_854da17aefaac034 = var_9cd9c9ecfbed632d;
  }
}

function function_e214b532712cd63a(var_6b00c9eb585feea5) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(var_6b00c9eb585feea5 >= 0) {
    sceneroot.scenestatic.var_a51f583c93c991ca = var_6b00c9eb585feea5;
    return;
  }

  sceneroot.scenestatic.var_a51f583c93c991ca = undefined;
}

function function_b95eab90f9ebc981(exclusiveplayers) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(isDefined(exclusiveplayers) && !isarray(exclusiveplayers)) {
    exclusiveplayers = [exclusiveplayers];
  }

  if(isDefined(sceneroot.scenestatic)) {
    sceneroot.scenestatic.exclusiveplayers = exclusiveplayers;
  }
}

function function_f40e088831060345(enablenotify) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(isDefined(sceneroot.scenestatic)) {
    sceneroot.scenestatic.var_bc227a74d38bdd36 = enablenotify ? undefined : 0;
  }
}

function function_48ea223b2dfda0() {
  sceneroot = self;
  sceneroot function_b4cfd3b6e6f6987d();
  characterobjects = function_20b3387e3454e668("Types_ClientChar");

  foreach(characterobj in characterobjects) {
    characterobj.characterindex = characterobj.sceneobject function_8d6340a41bdf10ed();
  }

  return characterobjects;
}

function function_85b13b837056bc8b(func) {
  if(!isDefined(level.scene)) {
    return;
  }

  if(!isDefined(level.scene.igc_handlers)) {
    level.scene.igc_handlers = [];
  }

  if(!arraycontains(level.scene.igc_handlers, func)) {
    level.scene.igc_handlers[level.scene.igc_handlers.size] = func;
  }
}

function function_53de0775d8452750(func) {
  if(!isDefined(level.scene)) {
    return;
  }

  if(!isDefined(level.scene.igc_handlers_done)) {
    level.scene.igc_handlers_done = [];
  }

  if(!arraycontains(level.scene.igc_handlers_done, func)) {
    level.scene.igc_handlers_done[level.scene.igc_handlers_done.size] = func;
  }
}

function add_scene_func(scene_ref, func, var_737cff255011346c) {
  structdest = undefined;

  if(isstring(scene_ref) || isxhashasset(scene_ref)) {
    structdest = level.scene;
  } else if(isstruct(scene_ref)) {
    sceneroot = scene_ref;
    sceneroot function_24d710698a8bf244();
    structdest = sceneroot.scenestatic;
    scene_ref = sceneroot scene_scriptbundle_name();
  } else {
    assertmsg("<dev string:xc2>");
  }

  if(!isDefined(structdest.funcs)) {
    structdest.funcs = [];
  }

  if(!isDefined(structdest.funcs[scene_ref])) {
    structdest.funcs[scene_ref] = [];
  }

  if(!isDefined(structdest.funcs[scene_ref][var_737cff255011346c])) {
    structdest.funcs[scene_ref][var_737cff255011346c] = [];
  }

  structdest.funcs[scene_ref][var_737cff255011346c] = arraycombineunique(structdest.funcs[scene_ref][var_737cff255011346c], [func]);
}

function remove_scene_func(scene_ref, func, var_737cff255011346c) {
  structdest = undefined;

  if(isstring(scene_ref)) {
    structdest = level.scene;
  } else if(isstruct(scene_ref)) {
    sceneroot = scene_ref;
    sceneroot function_b4cfd3b6e6f6987d();
    scene_ref = sceneroot scene_scriptbundle_name();
    structdest = sceneroot.scenedata;
  } else {
    assertmsg("<dev string:xc2>");
  }

  if(!isDefined(structdest.funcs)) {
    return false;
  }

  if(!isDefined(structdest.funcs[scene_ref])) {
    return false;
  }

  if(!isDefined(structdest.funcs[scene_ref][var_737cff255011346c])) {
    return false;
  }

  if(arraycontains(structdest.funcs[scene_ref][var_737cff255011346c], func)) {
    structdest.funcs[scene_ref][var_737cff255011346c] = arrayremove(structdest.funcs[scene_ref][var_737cff255011346c], func);
    return true;
  }

  return false;
}

function function_50fa3ec5022ba8e6(objecttype, valuename, value, gameplay) {
  function_9faf48fca9716acd();

  if(!isDefined(gameplay)) {
    gameplay = 0;
  }

  if(!isDefined(level.scene.values)) {
    level.scene.values = [];
  }

  if(!isDefined(level.scene.values[objecttype])) {
    level.scene.values[objecttype] = [];
  }

  if(!isDefined(level.scene.values[objecttype][gameplay])) {
    level.scene.values[objecttype][gameplay] = [];
  }

  level.scene.values[objecttype][gameplay][valuename] = value;
}

function function_f6c388039120f839(objecttype, valuename, gameplay) {
  function_9faf48fca9716acd();

  if(!isDefined(gameplay)) {
    gameplay = 0;
  }

  if(isDefined(level.scene.values[objecttype][gameplay][valuename])) {
    level.scene.values[objecttype][gameplay][valuename] = undefined;
  }
}

function function_b339b51ecae661fc(notifytarget, eventmessage, statematch) {
  sceneroot = self;
  sceneroot function_24d710698a8bf244();

  if(!isDefined(statematch)) {
    statematch = "Stopped";
  }

  if(statematch != "<dev string:x126>" && statematch != "<dev string:x131>") {
    assertmsg("<dev string:x13c>");
  }

  sceneroot.scenestatic.notifyobject = notifytarget;
  sceneroot.scenestatic.notifyevent = eventmessage;
  sceneroot.scenestatic.notifymatch = statematch;
}

function function_26e9262444e640fb(notifytarget, note, var_226a1c0234e7ab8b, repeat) {
  sceneroot = self;
  assert(isDefined(var_226a1c0234e7ab8b), "<dev string:x180>");
  sceneroot function_24d710698a8bf244();
  scenestatic = sceneroot.scenestatic;
  notifyinfo = spawnStruct();
  notifyinfo.notifyobject = notifytarget;
  notifyinfo.notifynote = note;
  notifyinfo.notifyrepeat = repeat;

  if(!isDefined(scenestatic.notifies)) {
    scenestatic.notifies = [];
  }

  if(!isDefined(scenestatic.notifies[var_226a1c0234e7ab8b])) {
    scenestatic.notifies[var_226a1c0234e7ab8b] = [];
  }

  if(function_c89f1bf37f1ca708(scenestatic.notifies[var_226a1c0234e7ab8b], notifyinfo)) {
    return;
  }

  scenestatic.notifies[var_226a1c0234e7ab8b][scenestatic.notifies[var_226a1c0234e7ab8b].size] = notifyinfo;

  if(sceneroot get_state() == "Playing") {
    for(sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size; sceneobjectindex++) {
      sceneobjectdata = sceneroot.scenedata.sceneobjectdata[sceneobjectindex];

      if(isDefined(sceneobjectdata.var_caa911de855ae014["DeltaAnimation"])) {
        sceneobjectdata thread function_f41f57a25d231b2(sceneobjectdata.var_caa911de855ae014["DeltaAnimation"]);
      }
    }
  }
}

function private function_c89f1bf37f1ca708(notifies, newnotify) {
  if(!isDefined(notifies)) {
    return false;
  }

  foreach(registerednotify in notifies) {
    if(registerednotify.notifyobject == newnotify.notifyobject && registerednotify.notifynote == newnotify.notifynote && (registerednotify.notifyrepeat ?? 0) == (newnotify.notifyrepeat ?? 0)) {
      registerednotify.notifytriggered = undefined;
      return true;
    }
  }

  return false;
}

function function_b3c7b792a7a154fa(var_f051b54b0cb641b4, var_258c0c982c66ce8c) {
  sceneroot = self;

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return 0;
  }

  scenedata = sceneroot.scenedata;
  shotindex = var_f051b54b0cb641b4;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79(shotindex);
  }

  if(!isDefined(shotindex)) {
    return 0;
  }

  if(shotindex < 0) {
    return 0;
  }

  if(!isDefined(var_258c0c982c66ce8c)) {
    var_258c0c982c66ce8c = 1;
  }

  var_2e3aa55cfe61dec9 = 0;

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(shotindex < sceneobjectdata.sceneobject.variant_object.shots.size) {
      cameraanimation = sceneobjectdata function_64466e4b9ed25e4c(shotindex);

      if(isDefined(cameraanimation)) {
        var_df6172b83ae83a53 = sceneobjectdata function_58a93a40f02daed7(cameraanimation, "CameraAnimation");

        if(var_df6172b83ae83a53 > var_2e3aa55cfe61dec9) {
          var_2e3aa55cfe61dec9 = var_df6172b83ae83a53;
        }
      }

      var_33d8b2fadff83a5 = 0;
      animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
      shotanimations = sceneobjectdata function_6bf501072826e845(shotindex);

      for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
        var_33d8b2fadff83a5 += sceneobjectdata function_58a93a40f02daed7(shotanimations[animationindex], animtype);
      }

      if(var_33d8b2fadff83a5 > var_2e3aa55cfe61dec9) {
        var_2e3aa55cfe61dec9 = var_33d8b2fadff83a5;
      }
    }
  }

  if(isDefined(sceneroot.scenestatic.animrate) && var_258c0c982c66ce8c) {
    var_2e3aa55cfe61dec9 *= sceneroot.scenestatic.animrate;
  }

  return var_2e3aa55cfe61dec9;
}

function function_30ae5e4baf26ba77(var_f051b54b0cb641b4) {
  sceneroot = self;

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return undefined;
  }

  scenedata = sceneroot.scenedata;

  if(!isarray(scenedata.sceneplay)) {
    return undefined;
  }

  shotindex = var_f051b54b0cb641b4;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79(shotindex);
  }

  if(!isDefined(shotindex)) {
    return undefined;
  }

  if(shotindex < 0) {
    return undefined;
  }

  foreach(itsceneplay in scenedata.sceneplay) {
    if((itsceneplay.currentshot ?? -1) != shotindex) {
      continue;
    }

    if(!isDefined(itsceneplay.var_b443c7b52a68e739)) {
      itsceneplay.var_b443c7b52a68e739 = itsceneplay function_5dd68723df85d7bb(itsceneplay.var_eb6d7fbdd0bb47f8, 0, 1);
    }

    if(!isarray(itsceneplay.var_caf7bc39e6b19dd5[shotindex])) {
      continue;
    }

    foreach(objectindex in itsceneplay.var_caf7bc39e6b19dd5[shotindex]) {
      refsceneobject = sceneroot.scenedata.sceneobjectdata[objectindex];

      if(isDefined(refsceneobject.activeanimationplaying)) {
        linkents = refsceneobject function_f2fb9eed776f75ff();

        if(isarray(linkents) && linkents.size > 0 && linkents[0] isusinganimtree()) {
          shotanimations = refsceneobject function_6bf501072826e845(shotindex);
          shottime = 0;

          foreach(animasset in shotanimations) {
            timefrac = 1;

            if(animasset == refsceneobject.activeanimationplaying) {
              if(isagent(linkents[0])) {
                animname = getanimname(animasset);
                animindex = linkents[0] asm::asm_lookupanimfromalias("animscripted", animname);

                if(isDefined(animindex)) {
                  timefrac = linkents[0] aigetanimtime("animscripted", animindex);
                }
              } else {
                timefrac = linkents[0] getanimtime(refsceneobject.activeanimationplaying) ?? 1;
              }
            }

            shottime += timefrac * getanimlength(refsceneobject.activeanimationplaying);

            if(animasset == refsceneobject.activeanimationplaying) {
              shotduration = itsceneplay.var_b443c7b52a68e739.shottimeinfo[shotindex].durationsec;

              if((shotduration ?? 0) > 0) {
                return (shottime / shotduration);
              }
            }
          }
        }
      }
    }
  }

  return undefined;
}

function function_110f292f4976d4fd(var_f051b54b0cb641b4, assettype, assets, origins) {
  sceneroot = self;

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return;
  }

  scenedata = sceneroot.scenedata;
  shotindex = var_f051b54b0cb641b4;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79(shotindex);
  }

  if(!isDefined(shotindex)) {
    return;
  }

  if(shotindex < 0) {
    return;
  }

  sceneroot function_24d710698a8bf244();
  structdest = sceneroot.scenestatic;
  structdest.prestreamassets[shotindex][assettype] = {
    #origins: origins, #assets: assets
  };
}

function private function_2d539a8d693b3dbb(existingentities, shotnames, scriptbundlename, inittype) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return;
  }

  sceneplay = sceneroot function_42248a6e028ecfa2(shotnames, 1);
  scenedata = sceneroot.scenedata;
  var_e721f1409fd57ca9 = [];

  if(isDefined(existingentities)) {
    if(!isarray(existingentities)) {
      existingentities = [existingentities];
    }

    existingentities = function_5713d46873b29625(existingentities);

    foreach(existingentity in existingentities) {
      if(isPlayer(existingentity)) {
        var_e721f1409fd57ca9[var_e721f1409fd57ca9.size] = existingentity;
      }

      if(isDefined(existingentity.script_animname) && !isDefined(existingentity.animname)) {
        existingentity.animname = existingentity.script_animname;
      }
    }
  }

  if(var_e721f1409fd57ca9.size > 0) {
    sceneplay.var_e721f1409fd57ca9 = var_e721f1409fd57ca9;
  } else {
    sceneplay.var_e721f1409fd57ca9 = undefined;
  }

  scenedata.isclientscene = 0;
  scenedata.var_3bb93b020e59c4de = undefined;

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(sceneobjectdata object_get_type() == "Types_Player") {
      if(isDefined(sceneobjectdata.entity) && isarray(sceneplay.var_e721f1409fd57ca9) && !arraycontains(sceneplay.var_e721f1409fd57ca9, sceneobjectdata.entity)) {
        sceneobjectdata function_741d59e7b6c8d2fc(sceneobjectdata.sceneroot, sceneobjectdata.sceneplay, undefined, inittype);
      }

      if(sceneobjectdata function_58b62b656cb29e76()) {
        scenedata.var_3bb93b020e59c4de = 1;
      }
    }

    if(sceneobjectdata.sceneobject function_8d6340a41bdf10ed() > 0) {
      scenedata.isclientscene = 1;
    }
  }

  if(scenedata.var_3bb93b020e59c4de) {
    sceneroot function_a39787a799ce2d9e();
  }

  sceneplay.var_caf7bc39e6b19dd5 = [];
  foundentitiesused = [];

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(!sceneobjectdata function_11c95ca4a274fbdb(sceneplay.var_eb6d7fbdd0bb47f8, sceneplay, sceneobjectindex)) {
      continue;
    }

    sceneobjectname = sceneobjectdata.sceneobject obj_get_name();
    existingentities = sceneobjectdata function_8c745f4ef7a9726f(sceneroot, sceneplay, sceneobjectname, existingentities, 1, 1, inittype);

    if(!isDefined(sceneobjectdata.entity)) {
      sceneroot.var_c46929fa56699327 = sceneobjectdata function_8c745f4ef7a9726f(sceneroot, sceneplay, sceneobjectname, sceneroot.var_c46929fa56699327, 1, 0, inittype);
    }

    if(!isDefined(sceneobjectdata.entity)) {
      foundentitiesused = sceneobjectdata function_46476cf72237e890(sceneroot, sceneplay, sceneobjectname, foundentitiesused, "targetname", inittype);
    }

    if(!isDefined(sceneobjectdata.entity)) {
      foundentitiesused = sceneobjectdata function_46476cf72237e890(sceneroot, sceneplay, sceneobjectname, foundentitiesused, "script_noteworthy", inittype);
    }

    if(!isDefined(sceneobjectdata.entity)) {
      foundentitiesused = sceneobjectdata function_46476cf72237e890(sceneroot, sceneplay, "_scene_global_" + sceneobjectname, foundentitiesused, "targetname", inittype);
    }

    if(!isDefined(sceneobjectdata.entity)) {
      foundentitiesused = sceneobjectdata function_46476cf72237e890(sceneroot, sceneplay, "_scene_global_" + sceneobjectname, foundentitiesused, "script_noteworthy", inittype);
    }
  }

  playerindex = 0;
  playermaleindex = 0;
  playerfemaleindex = 0;
  xcamcount = 0;
  maxplayers = -1;

  if(isDefined(sceneroot.scenestatic.var_a51f583c93c991ca)) {
    maxplayers = sceneroot.scenestatic.var_a51f583c93c991ca;
  }

  if(isarray(existingentities) && foundentitiesused.size > 0) {
    existingentities = arraydifference(existingentities, foundentitiesused);
  }

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(!isDefined(sceneplay.var_caf7bc39e6b19dd5[sceneobjectindex])) {
      continue;
    }

    if(sceneobjectdata object_get_type() == "Types_Player" && inittype == "scene_init_user") {
      continue;
    }

    sceneobjectname = sceneobjectdata.sceneobject obj_get_name();

    if(!isDefined(sceneobjectdata.entity) && !sceneobjectdata.sceneobject function_6b060c2167962186()) {
      existingentities = sceneobjectdata function_8c745f4ef7a9726f(sceneroot, sceneplay, sceneobjectname, existingentities, 0, 1, inittype);

      if(!isDefined(sceneobjectdata.entity)) {
        sceneroot.var_c46929fa56699327 = sceneobjectdata function_8c745f4ef7a9726f(sceneroot, sceneplay, sceneobjectname, sceneroot.var_c46929fa56699327, 0, 0, inittype);
      }
    }

    entity = sceneobjectdata.entity;
    isplayerobject = sceneobjectdata object_get_type() == "Types_Player";
    xcamcount += sceneobjectdata object_get_type() == "Types_XCam";
    var_c809a3d453c003d6 = 0;

    var_c809a3d453c003d6 = getdvarint(@ "hash_3bc9bc279e3f772", 0);

    if(!isDefined(entity)) {
      var_bcefe4edd076bc9f = 1;

      if(isplayerobject && maxplayers >= 0) {
        playernumber = playermaleindex;

        if(sceneobjectdata function_58b62b656cb29e76()) {
          playernumber = playerfemaleindex;
        }

        if(playernumber >= maxplayers) {
          var_bcefe4edd076bc9f = 0;
        }
      }

      if(var_bcefe4edd076bc9f && (!sceneobjectdata.sceneobject function_c68f88c2b5f207d3(sceneplay.shotinit) || var_c809a3d453c003d6 && isplayerobject)) {
        sceneobjectdata.alignmentinfo = scenedata.scenescriptbundle function_83bfd4c94b262c65(sceneroot, sceneplay.shotinit, sceneobjectindex, sceneobjectdata.alignmentinfo);
        function_7caec59d5958332(sceneobjectdata.alignmentinfo);

        if(isplayerobject) {
          if(!sceneobjectdata function_f0e8d8f1099045cc()) {
            if(playerindex < level.players.size) {
              playerentity = level.players[playerindex];

              if(!function_f43455d85847000(playerentity, sceneobjectdata)) {
                playerentity = undefined;
              }

              entity = playerentity;
            }
          }

          if(var_c809a3d453c003d6) {
            if(scene_debug::function_c4e717374c36ac3(sceneobjectindex)) {
              entity = level.players[0];
            } else if(entity == level.players[0]) {
              entity = undefined;
            }
          }

        } else {
          sceneobjectdata.spawner = function_2c2907d07310b0e(sceneobjectname, 0);
          entity = sceneobjectdata object_spawn(sceneobjectdata.alignmentinfo, sceneplay.shotinit);
        }
      } else {
        sceneplay.var_caf7bc39e6b19dd5[sceneobjectindex] = undefined;
      }
    }

    if(isDefined(entity)) {
      sceneobjectdata function_741d59e7b6c8d2fc(sceneroot, sceneplay, entity, undefined, inittype);
    }

    issetup = istrue(sceneobjectdata.issetup) || isDefined(entity) && isDefined(entity.sceneobjectdata) && istrue(entity.sceneobjectdata.issetup);

    if(isDefined(sceneplay.var_caf7bc39e6b19dd5[sceneobjectindex]) && !(issetup && inittype == "scene_init_prestream")) {
      sceneobjectdata object_setup(sceneplay);
    }

    if(isDefined(entity) && inittype == "scene_init_prestream" && !sceneobjectdata.existingentity && !isDefined(sceneobjectdata.activeanimation)) {
      sceneobjectdata function_4395eb62ee2212b9(0);
    }

    if(isplayerobject) {
      playerindex++;

      if(sceneobjectdata function_58b62b656cb29e76()) {
        playerfemaleindex++;
        continue;
      }

      playermaleindex++;
    }
  }

  if(inittype != "scene_init_prestream") {
    sceneobjectdata function_4395eb62ee2212b9(1);
  }

  sceneplay function_69e565b8af8a06a2(sceneplay.shotinit);
  sceneplay.hasplayers = max(playerindex, xcamcount) > 0;

  foreach(sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(!isDefined(sceneplay.var_caf7bc39e6b19dd5[sceneobjectindex])) {
      continue;
    }

    if(sceneobjectdata object_get_type() == "Types_Player" && inittype == "scene_init_user") {
      continue;
    }

    sceneobjectdata object_alignment_link(sceneplay, sceneobjectdata.alignmentinfo, inittype, undefined, 1);

    if(sceneobjectdata.sceneobject function_e3e0913c7903daa4() && inittype == "scene_init_user") {
      sceneobjectdata object_first_frame(sceneobjectdata.alignmentinfo);
    }
  }

  sceneroot scene_set_state("Setup");
  sceneplay.state = "Stopped";
  sceneroot function_c17d9607a8faffc3("callback_init");
  return sceneplay;
}

function private scene_play_omnvars(var_e1fc920feb677005) {
  scenedata = self;
  scenestatic = scenedata.sceneroot.scenestatic;

  if(isDefined(scenestatic.var_bc227a74d38bdd36) && scenestatic.var_bc227a74d38bdd36 == 0) {
    return;
  }

  var_a11daf0a3d76391c = scenestatic.exclusiveplayers ?? level.players;

  foreach(player in var_a11daf0a3d76391c) {
    if(isDefined(player)) {
      player setclientomnvar("ui_scene_play", var_e1fc920feb677005);
    }
  }

  wait 0.5;

  foreach(player in var_a11daf0a3d76391c) {
    if(isDefined(player)) {
      player setclientomnvar("ui_scene_play", -1);
    }
  }
}

function private scene_play_internal(existingentities, shotnames, scriptbundlename, fromtimefrac, startshotindex) {
  sceneroot = self;

  if(getdvarint(@ "scr_debug_scene_disabled")) {
    level waittill("<dev string:x1c7>");
    return;
  }

  if(!arraycontains(level.var_8b929db1c0421d07, sceneroot)) {
    sceneroot.var_737c289bc27765a9 = 1;
    level.var_8b929db1c0421d07 = arraycombineunique(level.var_8b929db1c0421d07, [sceneroot]);
  }

  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_b4cfd3b6e6f6987d()) {
    return;
  }

  scenedata = sceneroot.scenedata;

  if(isDefined(existingentities) && !isarray(existingentities)) {
    existingentities = [existingentities];
  }

  state = sceneroot get_state();
  sceneplay = undefined;

  if(state != "NotSetup") {
    sceneplay = sceneroot function_42248a6e028ecfa2(shotnames, 0);

    if(isDefined(sceneplay) && sceneplay.state == "Playing") {
      sceneplay scene_play_stop(0);
    }

    shotindices = undefined;

    foreach(sceneplayiter in scenedata.sceneplay) {
      if(isDefined(sceneplayiter.prestreamuntil)) {
        stopstreaming = sceneplayiter === sceneplay;

        if(!stopstreaming) {
          if(!isDefined(shotindices)) {
            shotindices = sceneroot function_4b5fdbefe3851660(shotnames);
          }

          var_ec547618d18454e5 = arrayintersection(sceneplayiter.var_eb6d7fbdd0bb47f8, shotindices);

          if(var_ec547618d18454e5.size > 0) {
            stopstreaming = 1;
          }
        }

        if(stopstreaming) {
          if(sceneplayiter.prestreamuntil < 0 || gettime() > sceneplayiter.prestreamuntil) {
            sceneroot pre_stream(existingentities, sceneplayiter.var_eb6d7fbdd0bb47f8, level.framedurationseconds * 2);
          }

          sceneplayiter.prestreamuntil = undefined;
        }
      }
    }
  }

  sceneplay = sceneroot function_2d539a8d693b3dbb(existingentities, shotnames, undefined, "scene_init_play");

  if(sceneplay.var_eb6d7fbdd0bb47f8.size == 0) {
    shotsstr = "<dev string:x1d2>";

    if(isDefined(shotnames)) {
      shotsstr = "<dev string:x1d6>";

      if(!isarray(shotnames)) {
        shotnames = [shotnames];
      }

      foreach(shot in shotnames) {
        shotsstr = shotsstr + "<dev string:x1db>" + shot;
      }
    }

    iprintlnbold("<dev string:x1e0>" + getxhashsourcename(sceneroot.script_scenescriptbundle) + "<dev string:x1ec>" + shotsstr);

    return;
  }

  sceneplay function_97739bae625d1f27(1);
  sceneplay function_1d07da6ed2bd0f6b(isDefined(startshotindex));
  sceneplay function_4fbd928ce143468f(sceneplay.var_eb6d7fbdd0bb47f8, fromtimefrac);
  sceneplay function_4b100730bcea788();
  sceneroot function_d267e3929640a45f();
  sceneroot function_c17d9607a8faffc3("callback_play");
  sceneroot.var_92148924baa5c73c = undefined;
  var_60595ccb55543612 = getdvarint(@ "hash_be485550bea2743", 0);

  if(var_60595ccb55543612 == 1) {
    sceneref = sceneroot scene_scriptbundle_name();
    sceneref = isxhashasset(sceneref) ? sceneref : hashcat(%"scenescriptbundle:", sceneref);
    var_e1fc920feb677005 = function_43b5ed5a14a56573(#"scriptbundle_scenescriptbundle", sceneref);

    if(isDefined(var_e1fc920feb677005) && scenedata.isclientscene) {
      scenedata thread scene_play_omnvars(var_e1fc920feb677005);
    }
  }

  while(isDefined(sceneroot.scenedata) && !sceneplay function_177d435a8fba3dc0()) {
    scenestarttime = gettime();
    sceneplay.shotindicesindex = 0;

    if(isDefined(startshotindex)) {
      foreach(index, shotindex in sceneplay.var_eb6d7fbdd0bb47f8) {
        if(shotindex == startshotindex) {
          sceneplay.shotindicesindex = index;
          break;
        }
      }
    }

    while(sceneplay.shotindicesindex < sceneplay.var_eb6d7fbdd0bb47f8.size) {
      sceneplay.currentshot = sceneplay.var_eb6d7fbdd0bb47f8[sceneplay.shotindicesindex];
      sceneplay.nextshot = undefined;

      if(sceneplay.shotindicesindex + 1 < sceneplay.var_eb6d7fbdd0bb47f8.size) {
        sceneplay.nextshot = sceneplay.var_eb6d7fbdd0bb47f8[sceneplay.shotindicesindex + 1];
      }

      if(sceneplay.var_eb6d7fbdd0bb47f8.size > sceneplay.shotindicesindex + 1) {
        doprestream = scenedata.scenescriptbundle function_4f6556149db5309e();
        streamtime = level.scene.prestreamtime;
        predicttime = streamtime;
        nextshotnames = [];

        for(var_c2fdbd707967c56d = sceneplay.shotindicesindex + 1; var_c2fdbd707967c56d < sceneplay.var_eb6d7fbdd0bb47f8.size; var_c2fdbd707967c56d++) {
          nextshotindex = sceneplay.var_eb6d7fbdd0bb47f8[var_c2fdbd707967c56d];
          nextshot = scenedata.scenescriptbundle function_6404fde3adf1f642(nextshotindex);
          nextshotnames[nextshotnames.size] = nextshot shot_get_name();
          doprestream = doprestream || nextshot function_207777fd99d7a922();
          predicttime -= sceneroot function_b3c7b792a7a154fa(nextshotindex);

          if(predicttime <= 0) {
            break;
          }
        }

        if(isDefined(sceneplay.var_a173fd36d9f698cb.fromtimesec) && sceneplay.var_a173fd36d9f698cb.shottimeinfo[nextshotindex].startsec < sceneplay.var_a173fd36d9f698cb.fromtimesec) {
          doprestream = 0;
        }

        if(doprestream && sceneplay.hasplayers) {
          currentshotlength = sceneroot function_b3c7b792a7a154fa(sceneplay.currentshot, 1);
          streamstarttime = max(currentshotlength - streamtime, level.framedurationseconds);
          sceneroot utility::delaythreadendon(streamstarttime, "scene_stop", &pre_stream, existingentities, nextshotnames, streamtime + 0.1, undefined, "prestream_predict");
        }
      }

      success = sceneroot scene_shot_play(sceneplay, sceneplay.currentshot);

      if(!success) {
        break;
      }

      sceneplay.shotindicesindex++;
    }

    if(!isDefined(sceneroot.scenedata) || !sceneroot.scenedata.scenescriptbundle function_18b6837bdb9e4208()) {
      break;
    }

    if(gettime() == scenestarttime) {
      break;
    }
  }

  sceneplay function_fd69bbc76c8dac86();
}

function private function_d267e3929640a45f() {
  if(self.scenedata.scenescriptbundle function_7f138cc8a9e70cf4()) {
    if(!self.scenedata.sceneroot function_de0c3faf7f92b366()) {
      if(isDefined(level.scene) && isarray(level.scene.igc_handlers)) {
        foreach(var_bddce983b620ac2f in level.scene.igc_handlers) {
          self thread[[var_bddce983b620ac2f]]();
        }
      }
    }
  }
}

function private function_684eaabee2eab081() {
  if(self.scenedata.scenescriptbundle && self.scenedata.scenescriptbundle function_7f138cc8a9e70cf4()) {
    if(!self.scenedata.sceneroot function_de0c3faf7f92b366()) {
      if(isDefined(level.scene) && isarray(level.scene.igc_handlers_done)) {
        foreach(var_bddce983b620ac2f in level.scene.igc_handlers_done) {
          self thread[[var_bddce983b620ac2f]]();
        }
      }
    }
  }
}

function private function_fd69bbc76c8dac86() {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  if(sceneroot.var_737c289bc27765a9) {
    level.var_8b929db1c0421d07 = arrayremove(level.var_8b929db1c0421d07, sceneroot);
  }

  sceneplay function_97739bae625d1f27(0);
  sceneplay.state = "Stopped";
  sceneplay notify("Stopped");

  if(isDefined(sceneroot) && sceneroot function_534c5ebe7d240503()) {
    foreach(sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5) {
      sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

      if(isPlayer(sceneobjectdata.entity) && sceneobjectdata.entity.var_447f739b52f0598d) {
        sceneobjectdata.entity.var_447f739b52f0598d = undefined;
        sceneobjectdata.entity setclientomnvar("ui_is_bink_skippable", 0);
        continue;
      }

      if(sceneobjectdata.sceneobject.variant_type === "Types_XCam") {
        players = sceneobjectdata function_931d12df9abebc7f();

        foreach(player in players) {
          if(player.var_447f739b52f0598d) {
            player.var_447f739b52f0598d = undefined;
            player setclientomnvar("ui_is_bink_skippable", 0);
          }
        }
      }
    }
  }

  sceneplay function_ca4b8bd505800128();

  if(sceneroot get_state() == "Stopped") {
    sceneroot function_7ae4ca45fe9ff944("Stopped");
  }

  if(isDefined(sceneroot) && !sceneplay.stoprequested) {
    sceneroot function_c17d9607a8faffc3("callback_done");
    sceneroot function_684eaabee2eab081();
  }

  sceneroot thread scene_reset_thread();
}

function private function_177d435a8fba3dc0() {
  sceneplay = self;

  if(sceneplay.stoprequested) {
    return true;
  }

  return sceneplay.state === "Stopped";
}

function private function_a39787a799ce2d9e() {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  maleindices = [];
  femaleindices = [];

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(sceneobjectdata object_get_type() == "Types_Player") {
      if(sceneobjectdata function_58b62b656cb29e76()) {
        femaleindices[femaleindices.size] = sceneobjectindex;
        continue;
      }

      maleindices[maleindices.size] = sceneobjectindex;
    }
  }

  maxcount = min(maleindices.size, femaleindices.size);

  for(i = 0; i < maxcount; i++) {
    maleplayerindex = maleindices[i];
    femaleplayerindex = femaleindices[i];
    scenedata.sceneobjectdata[maleplayerindex].var_fc43e503169048b4 = femaleplayerindex;
    scenedata.sceneobjectdata[femaleplayerindex].var_bb90b6cef43f6c8f = maleplayerindex;
  }
}

function private function_263a428cb3b06bb6() {
  var_79b71dd6eb150719 = function_d1bb58bd28875f50();

  foreach(player in var_79b71dd6eb150719) {
    player stopsoundchannel("scn_igc_unres_2d");
    player stopsoundchannel("scn_lfe_unres_2d");
  }
}