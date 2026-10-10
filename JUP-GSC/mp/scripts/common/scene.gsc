/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\scene.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\hud_util;
#using scripts\common\notetrack;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace scene;

function play(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110) {
  sceneroot = self;
  sceneroot function_7e5354b44c829c9e(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110);
}

function function_24e44cdb807b87ba(var_198fc279325346db, existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110) {
  if(!isDefined(var_198fc279325346db)) {
    var_198fc279325346db = 1;
  }

  sceneroot = self;
  sceneroot pre_stream(existingentities, shotnames, var_198fc279325346db, scriptbundlename);
  wait var_198fc279325346db;
  sceneroot play(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110);
}

function init(existingentities, shotnames, scriptbundlename) {
  sceneroot = self;
  return sceneroot function_a9fc7e7dfd78e15e(existingentities, shotnames, scriptbundlename, "scene_init_user");
}

function skip(shotnames, var_870ed163bd3036dd, var_f77f80bf8f02d9f9) {
  if(!isDefined(var_870ed163bd3036dd)) {
    var_870ed163bd3036dd = 0.5;
  }

  if(!isDefined(var_f77f80bf8f02d9f9)) {
    var_f77f80bf8f02d9f9 = 0.5;
  }

  sceneroot = self;
  state = sceneroot get_state();

  if(state != "Playing") {
    return;
  }

  sceneplay = sceneroot function_e6197350552df14b(shotnames, 0);

  if(!isDefined(sceneplay)) {
    return;
  }

  if(var_f77f80bf8f02d9f9 > 0) {
    hud_util::fade_out(var_f77f80bf8f02d9f9);
    waitframe();
  }

  totalseconds = 0;

  foreach(shotindex in sceneplay.var_df5db7bd235f2729) {
    totalseconds += sceneroot function_30140edcf9e36027(sceneplay, shotindex);
  }

  if(var_f77f80bf8f02d9f9 > 0) {
    thread hud_util::fade_in(var_f77f80bf8f02d9f9);
  }

  if(totalseconds <= 0 || var_870ed163bd3036dd >= totalseconds) {
    return;
  }

  timefrac = (totalseconds - var_870ed163bd3036dd) / totalseconds;
  sceneplay function_5a438716f043fddc(timefrac, sceneplay.var_df5db7bd235f2729);
  sceneroot function_7e5354b44c829c9e(undefined, shotnames, undefined, timefrac, sceneplay.currentshot);
  sceneroot function_bb980ac4246f5baa("callback_skipped");
}

function stop() {
  sceneroot = self;
  sceneroot function_bd09568f76dd40ca();

  if(sceneroot get_state() == "Playing") {
    foreach(sceneplay in sceneroot.scenedata.sceneplay) {
      sceneplay thread function_28f230671b0b9a1f(1);
    }

    waittillframeend();

    while(sceneroot get_state() == "Playing") {
      waitframe();
    }
  }
}

function cleanup(forcedeleteall) {
  sceneroot = self;
  sceneroot.scenestatic = undefined;

  if(istrue(forcedeleteall) && isDefined(sceneroot.var_cf24d127aa3920a0)) {
    foreach(entity in sceneroot.var_cf24d127aa3920a0) {
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

    sceneroot.var_cf24d127aa3920a0 = undefined;
  }

  if(sceneroot get_state() != "NotSetup") {
    sceneroot scene_reset();
  }

  if(sceneroot get_state() == "NotInit") {
    return;
  }

  if(isDefined(sceneroot) && !isDefined(sceneroot.var_cf24d127aa3920a0)) {
    sceneroot.var_cf24d127aa3920a0 = [];
  }

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < sceneroot.scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = sceneroot.scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(isDefined(var_214d924f4e137244) && isDefined(var_214d924f4e137244.entity) && !istrue(var_214d924f4e137244.existingentity)) {
      if(istrue(forcedeleteall)) {
        var_214d924f4e137244 object_delete();
        continue;
      }

      if(!isPlayer(var_214d924f4e137244.entity)) {
        sceneroot.var_cf24d127aa3920a0[var_214d924f4e137244.entity getentitynumber()] = var_214d924f4e137244.entity;
      }
    }
  }

  if(isDefined(sceneroot) && isDefined(sceneroot.var_cf24d127aa3920a0) && sceneroot.var_cf24d127aa3920a0.size == 0) {
    sceneroot.var_cf24d127aa3920a0 = undefined;
  }

  sceneroot function_c643b2c6b794481e("NotInit");
}

function pre_stream(existingentities, shotnames, duration, scriptbundlename, predicttime) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  if(!isDefined(scriptbundlename)) {
    scriptbundlename = undefined;
  }

  if(!isDefined(predicttime)) {
    predicttime = 0;
  }

  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
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
    shotnames = sceneroot function_8a37fe423de2b9db();
  }

  if(!isarray(shotnames)) {
    shotnames = [shotnames];
  }

  foreach(shotname in shotnames) {
    shotindex = scenescriptbundle function_eed2bf36a4defb90(shotname);
    shotindexes[shotindex] = shotindex;
  }

  foreach(var_370294f3b91920df in scenedata.sceneplay) {
    if(utility::is_equal(var_370294f3b91920df.state, "Playing")) {
      var_a1709fdb12562ef0 = utility::array_intersection(var_370294f3b91920df.var_df5db7bd235f2729, shotindexes);

      if(var_a1709fdb12562ef0.size == shotindexes.size) {
        sceneplay = var_370294f3b91920df;
        break;
      }
    }
  }

  if(!isDefined(sceneplay)) {
    sceneplay = sceneroot function_a9fc7e7dfd78e15e(existingentities, shotnames, undefined, "scene_init_prestream");
  }

  if(isDefined(sceneplay) && sceneplay.var_df5db7bd235f2729.size > 0) {
    sceneplay.prestream = spawnStruct();
    sceneplay.prestream.players = [];
    sceneplay.prestream.objects = [];

    var_8c3ac4ace886c14e = [];

    foreach(shotindex in shotindexes) {
      sceneplay function_218d0124f21f73b1(shotindex);

      foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
        if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
          var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
          var_214d924f4e137244 thread function_b62972e8f5541b26(sceneplay, shotindex);
        }
      }

      var_8c3ac4ace886c14e[var_8c3ac4ace886c14e.size] = shotindex;

      predicttime -= sceneplay.sceneroot function_d9be975d8d1c9db3(shotindex);

      if(predicttime <= 0) {
        break;
      }
    }

    if(sceneplay.prestream.players.size == 0) {
      iprintlnbold("<dev string:x1c>");
    }

    foreach(playerinfo in sceneplay.prestream.players) {
      entities = [];
      distances = [];
      player = playerinfo.player;

      foreach(cameraorigin in playerinfo.cameraorigins) {
        closestobjects = sortbydistance(sceneplay.prestream.objects, cameraorigin);

        foreach(objectinfo in closestobjects) {
          if(!isent(objectinfo.entity)) {
            continue;
          }

          entnum = objectinfo.entity getentitynumber();
          dist = distance(cameraorigin, objectinfo.origin);

          if(!isDefined(entities[entnum])) {
            entities[entnum] = objectinfo.entity;
            distances[entnum] = dist;
            continue;
          }

          distances[entnum] = min(distances[entnum], dist);
        }
      }

      if(playerinfo.cameraorigins.size > 2) {
        iprintlnbold("<dev string:x44>");
      }

      streamentities = [];
      streamdistances = [];

      foreach(entnum, entity in entities) {
        if(streamentities.size >= 16) {
          iprintlnbold("<dev string:x6a>" + 16);

          break;
        }

        streamentities[streamentities.size] = entity;
        streamdistances[streamdistances.size] = distances[entnum];
      }

      if(isDefined(player)) {
        sceneplay function_ffae6ec92028ce08(var_8c3ac4ace886c14e, duration, playerinfo.cameraorigins);

        player utility::player_prestream_camera(playerinfo.cameraorigins[0], duration, playerinfo.cameraorigins[1]);
        player utility::player_prestream_entities(streamentities, streamdistances, duration);
      }
    }

    sceneplay.var_2b0ae4dffc850db2 = undefined;

    if(duration > 0) {
      sceneplay.var_2b0ae4dffc850db2 = gettime() + duration * 1000;
    } else if(duration < 0) {
      sceneplay.var_2b0ae4dffc850db2 = -1;
    }

    sceneplay.prestream = undefined;
  }
}

function function_8a37fe423de2b9db() {
  sceneroot = self;
  scenescriptbundle = sceneroot scene_scriptbundle();
  shotnames = [];
  shotcount = scenescriptbundle function_d1338e27a26ecaeb();

  for(shotindex = 0; shotindex < shotcount; shotindex++) {
    shot = scenescriptbundle function_2218afa82a590ea3(shotindex);
    shotnames[shotindex] = shot function_55042076624e1180();
  }

  return shotnames;
}

function get_entities(var_2a29e57c1c105d52, filter) {
  if(!isDefined(filter)) {
    filter = "all";
  }

  sceneroot = self;
  scenedata = sceneroot.scenedata;
  entities = [];

  if(!isDefined(scenedata)) {
    return entities;
  }

  shotindexes = sceneroot function_14d02a749939e837(var_2a29e57c1c105d52);

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(isDefined(shotindexes) && !var_214d924f4e137244 function_225d78e3c485a7ae(shotindexes)) {
      continue;
    }

    switch (filter) {
      case #"hash_d71fd9ff6b033b7a":
        if(istrue(var_214d924f4e137244.existingentity) || var_214d924f4e137244.sceneobject function_d5f4474a16f90132() != "None") {
          continue;
        }

        break;
    }

    entities[entities.size] = var_214d924f4e137244.entity;
  }

  return entities;
}

function get_entity(var_9f7e823a4cdab21d) {
  sceneroot = self;
  var_214d924f4e137244 = sceneroot get_object(var_9f7e823a4cdab21d);

  if(isDefined(var_214d924f4e137244)) {
    return var_214d924f4e137244.entity;
  }

  return undefined;
}

function get_object(var_8a2a5f9c6428c06c) {
  sceneroot = self;

  if(!isDefined(sceneroot.scenedata)) {
    return undefined;
  }

  if(!isDefined(var_8a2a5f9c6428c06c)) {
    return undefined;
  }

  scenedata = sceneroot.scenedata;
  scenescriptbundle = sceneroot scene_scriptbundle();

  if(isint(var_8a2a5f9c6428c06c)) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_8a2a5f9c6428c06c];

    if(isDefined(var_214d924f4e137244)) {
      return var_214d924f4e137244;
    }
  } else {
    for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
      sceneobject = scenescriptbundle function_bfc4196d3da11705(var_56f4af8746a2d458);

      if(sceneobject function_aeb2b46911a5811d() == var_8a2a5f9c6428c06c) {
        var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
        return var_214d924f4e137244;
      }
    }
  }

  return undefined;
}

function function_6cb938788c210309(var_8a2a5f9c6428c06c, var_7c76f3de91f4cf3d, scriptbundlename) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
    return sceneroot;
  }

  if(!isDefined(var_8a2a5f9c6428c06c)) {
    return sceneroot;
  }

  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = sceneroot get_object(var_8a2a5f9c6428c06c);

  if(!isDefined(var_214d924f4e137244)) {
    return sceneroot;
  }

  shotindex = var_7c76f3de91f4cf3d;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366(shotindex);
  }

  if(!isDefined(shotindex)) {
    return sceneroot;
  }

  if(shotindex < 0 || shotindex >= var_214d924f4e137244.sceneobject.variant_object.shots.size) {
    return sceneroot;
  }

  alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, shotindex, var_214d924f4e137244.index);
  function_e4fc30ccdca08b9d(alignmentinfo);
  return alignmentinfo;
}

function function_10a1cbb13da3a4fe(var_8a2a5f9c6428c06c, var_7c76f3de91f4cf3d, scriptbundlename) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
    return [];
  }

  if(!isDefined(var_8a2a5f9c6428c06c)) {
    return [];
  }

  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = sceneroot get_object(var_8a2a5f9c6428c06c);

  if(!isDefined(var_214d924f4e137244)) {
    return [];
  }

  shotindex = var_7c76f3de91f4cf3d;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366(shotindex);
  }

  if(!isDefined(shotindex)) {
    return [];
  }

  if(shotindex < 0 || shotindex >= var_214d924f4e137244.sceneobject.variant_object.shots.size) {
    return [];
  }

  return var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);
}

function function_77751080050d2cb1(objecttype, var_2a29e57c1c105d52, scriptbundlename) {
  sceneroot = self;
  assert(isstring(objecttype));
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
    return [];
  }

  scenedata = sceneroot.scenedata;
  objects = [];
  shotindexes = sceneroot function_14d02a749939e837(var_2a29e57c1c105d52);

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(var_214d924f4e137244.sceneobject function_c77857d663e8cfbe() != objecttype) {
      continue;
    }

    if(isDefined(shotindexes) && !var_214d924f4e137244 function_225d78e3c485a7ae(shotindexes)) {
      continue;
    }

    objects[objects.size] = var_214d924f4e137244;
  }

  return objects;
}

function function_bc521bee52fde214(rate) {
  sceneroot = self;
  sceneroot function_6a66a98742866fed();
  sceneroot.scenestatic.animrate = rate;
  function_d225e757dea4eca6();
}

function function_b0b8f796886a9c81(ishighlod) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(isDefined(var_214d924f4e137244.entity)) {
      var_214d924f4e137244.entity namespace_53fc9ddbb516e6e1::function_cea710f9d017694a(ishighlod);
    }
  }
}

function function_ddebd5f650117455(var_8a2a5f9c6428c06c, var_7c76f3de91f4cf3d, overridetype, overridevalue, scriptbundlename) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
    return;
  }

  if(!isDefined(var_8a2a5f9c6428c06c)) {
    return;
  }

  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = sceneroot get_object(var_8a2a5f9c6428c06c);

  if(!isDefined(var_214d924f4e137244)) {
    return;
  }

  shotindex = var_7c76f3de91f4cf3d;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366(shotindex);
  }

  if(!isDefined(shotindex)) {
    return;
  }

  if(shotindex < 0 || shotindex >= var_214d924f4e137244.sceneobject.variant_object.shots.size) {
    return;
  }

  var_214d924f4e137244 function_5a65e42126f29a4f(shotindex, overridetype, overridevalue);
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

function add_spawn_function(spawnfunc, var_6bff09752f736d14) {
  if(!isDefined(var_6bff09752f736d14)) {
    var_6bff09752f736d14 = "_object_all_";
  }

  sceneroot = self;
  sceneroot function_6a66a98742866fed();
  scenestatic = sceneroot.scenestatic;

  if(!isDefined(scenestatic.spawnfunctions)) {
    scenestatic.spawnfunctions = [];
  }

  if(!isDefined(scenestatic.spawnfunctions[var_6bff09752f736d14])) {
    scenestatic.spawnfunctions[var_6bff09752f736d14] = [];
  }

  scenestatic.spawnfunctions[var_6bff09752f736d14][scenestatic.spawnfunctions[var_6bff09752f736d14].size] = spawnfunc;
}

function get_state() {
  sceneroot = self;

  if(!isDefined(sceneroot.scenedata)) {
    return "NotInit";
  }

  sceneroot function_bd09568f76dd40ca();

  if(sceneroot.scenedata.state == "Setup") {
    foreach(sceneplay in sceneroot.scenedata.sceneplay) {
      if(sceneplay.state == "Playing") {
        return "Playing";
      }
    }

    return "Stopped";
  }

  return sceneroot.scenedata.state;
}

function function_263e37fc44b91d4f(exclude_players) {
  sceneroot = self;
  sceneroot function_6a66a98742866fed();

  if(!istrue(exclude_players)) {
    sceneroot.scenestatic.excludeplayers = undefined;
    return;
  }

  sceneroot.scenestatic.excludeplayers = 1;
}

function function_595670eb4c1bdf59(var_8d59d732cf917fb2) {
  sceneroot = self;
  sceneroot function_6a66a98742866fed();

  if(!istrue(var_8d59d732cf917fb2)) {
    sceneroot.scenestatic.var_8f28f8f196c70a58 = undefined;
    return;
  }

  sceneroot.scenestatic.var_8f28f8f196c70a58 = 1;
}

function function_2136d6e5467c6caf(var_da75af8d8c3a50e4) {
  sceneroot = self;
  sceneroot function_6a66a98742866fed();

  if(var_da75af8d8c3a50e4 >= 0) {
    sceneroot.scenestatic.var_ce9c0a8610712c8d = var_da75af8d8c3a50e4;
    return;
  }

  sceneroot.scenestatic.var_ce9c0a8610712c8d = undefined;
}

function add_scene_func(scene_ref, func, var_8338711a0d65673b) {
  structdest = undefined;

  if(isstring(scene_ref)) {
    structdest = level.scene;
  } else if(isstruct(scene_ref)) {
    sceneroot = scene_ref;
    sceneroot function_6a66a98742866fed();
    structdest = sceneroot.scenestatic;
    scene_ref = sceneroot function_6c0e3626ebce826f();
  } else {
    assertmsg("<dev string:x90>");
  }

  structdest.funcs = utility::default_to(structdest.funcs, []);
  structdest.funcs[scene_ref] = utility::default_to(structdest.funcs[scene_ref], []);
  structdest.funcs[scene_ref][var_8338711a0d65673b] = utility::default_to(structdest.funcs[scene_ref][var_8338711a0d65673b], []);
  structdest.funcs[scene_ref][var_8338711a0d65673b] = utility::function_6d6af8144a5131f1(structdest.funcs[scene_ref][var_8338711a0d65673b], func);
}

function remove_scene_func(scene_ref, func, var_8338711a0d65673b) {
  structdest = undefined;

  if(isstring(scene_ref)) {
    structdest = level.scene;
  } else if(isstruct(scene_ref)) {
    sceneroot = scene_ref;
    sceneroot function_bd09568f76dd40ca();
    scene_ref = sceneroot function_6c0e3626ebce826f();
    structdest = sceneroot.scenedata;
  } else {
    assertmsg("<dev string:x90>");
  }

  if(!isDefined(structdest.funcs)) {
    return false;
  }

  if(!isDefined(structdest.funcs[scene_ref])) {
    return false;
  }

  if(!isDefined(structdest.funcs[scene_ref][var_8338711a0d65673b])) {
    return false;
  }

  if(utility::array_contains(structdest.funcs[scene_ref][var_8338711a0d65673b], func)) {
    structdest.funcs[scene_ref][var_8338711a0d65673b] = utility::array_remove(structdest.funcs[scene_ref][var_8338711a0d65673b], func);
    return true;
  }

  return false;
}

function function_a07af33558d3050f(notifytarget, eventmessage, statematch) {
  sceneroot = self;
  sceneroot function_6a66a98742866fed();

  if(!isDefined(statematch)) {
    statematch = "Stopped";
  }

  if(statematch != "<dev string:xf4>" && statematch != "<dev string:xff>") {
    assertmsg("<dev string:x10a>");
  }

  sceneroot.scenestatic.notifyobject = notifytarget;
  sceneroot.scenestatic.notifyevent = eventmessage;
  sceneroot.scenestatic.notifymatch = statematch;
}

function function_8207074e79f22926(notifytarget, note, var_6bff09752f736d14, repeat) {
  sceneroot = self;
  sceneroot function_6a66a98742866fed();
  scenestatic = sceneroot.scenestatic;
  notifyinfo = spawnStruct();
  notifyinfo.notifyobject = notifytarget;
  notifyinfo.notifynote = note;
  notifyinfo.notifyrepeat = repeat;
  var_6bff09752f736d14 = default_to(var_6bff09752f736d14, "_object_all_");

  if(!isDefined(scenestatic.notifies)) {
    scenestatic.notifies = [];
  }

  if(!isDefined(scenestatic.notifies[var_6bff09752f736d14])) {
    scenestatic.notifies[var_6bff09752f736d14] = [];
  }

  if(function_85b2629a7bbafad9(scenestatic.notifies["_object_all_"], notifyinfo)) {
    return;
  }

  if(function_85b2629a7bbafad9(scenestatic.notifies[var_6bff09752f736d14], notifyinfo)) {
    return;
  }

  scenestatic.notifies[var_6bff09752f736d14][scenestatic.notifies[var_6bff09752f736d14].size] = notifyinfo;

  if(sceneroot get_state() == "Playing") {
    for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < sceneroot.scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
      var_214d924f4e137244 = sceneroot.scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

      if(isDefined(var_214d924f4e137244) && isDefined(var_214d924f4e137244.var_36831a04af11576f) && isDefined(var_214d924f4e137244.var_36831a04af11576f["DeltaAnimation"])) {
        var_214d924f4e137244 thread function_924dc6425bd2b70d(var_214d924f4e137244.var_36831a04af11576f["DeltaAnimation"]);
      }
    }
  }
}

function private function_85b2629a7bbafad9(notifies, newnotify) {
  if(!isDefined(notifies)) {
    return false;
  }

  foreach(registerednotify in notifies) {
    if(registerednotify.notifyobject == newnotify.notifyobject && registerednotify.notifynote == newnotify.notifynote && utility::default_to(registerednotify.notifyrepeat, 0) == utility::default_to(newnotify.notifyrepeat, 0)) {
      registerednotify.notifytriggered = undefined;
      return true;
    }
  }

  return false;
}

function function_d9be975d8d1c9db3(var_7c76f3de91f4cf3d, var_c5b4f177c96bcce1) {
  sceneroot = self;

  if(!sceneroot function_bd09568f76dd40ca()) {
    return 0;
  }

  scenedata = sceneroot.scenedata;
  shotindex = var_7c76f3de91f4cf3d;

  if(!isint(shotindex)) {
    shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366(shotindex);
  }

  if(!isDefined(shotindex)) {
    return 0;
  }

  if(shotindex < 0) {
    return 0;
  }

  var_c5b4f177c96bcce1 = utility::default_to(var_c5b4f177c96bcce1, 1);
  var_ba7c51f4385e6b48 = 0;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(shotindex < var_214d924f4e137244.sceneobject.variant_object.shots.size) {
      cameraanimation = var_214d924f4e137244 function_6c3d100538f590b3(shotindex);

      if(isDefined(cameraanimation)) {
        var_4aade63686d9cdf2 = var_214d924f4e137244 function_9c0d01ef917ee30(cameraanimation, "CameraAnimation");

        if(var_4aade63686d9cdf2 > var_ba7c51f4385e6b48) {
          var_ba7c51f4385e6b48 = var_4aade63686d9cdf2;
        }
      }

      var_755a82d10fefd14 = 0;
      animtype = var_214d924f4e137244.sceneobject function_92192185fc7c5500();
      shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

      for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
        var_755a82d10fefd14 += var_214d924f4e137244 function_9c0d01ef917ee30(shotanimations[animationindex], animtype);
      }

      if(var_755a82d10fefd14 > var_ba7c51f4385e6b48) {
        var_ba7c51f4385e6b48 = var_755a82d10fefd14;
      }
    }
  }

  if(isDefined(sceneroot.scenestatic) && isDefined(sceneroot.scenestatic.animrate) && var_c5b4f177c96bcce1) {
    var_ba7c51f4385e6b48 *= sceneroot.scenestatic.animrate;
  }

  return var_ba7c51f4385e6b48;
}

function private function_a9fc7e7dfd78e15e(existingentities, shotnames, scriptbundlename, inittype) {
  sceneroot = self;
  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
    return;
  }

  sceneplay = sceneroot function_e6197350552df14b(shotnames, 1);
  scenedata = sceneroot.scenedata;

  if(isDefined(existingentities)) {
    if(!isarray(existingentities)) {
      existingentities = [existingentities];
    }

    existingentities = utility::array_removeundefined(existingentities);

    foreach(existingentity in existingentities) {
      if(isDefined(existingentity.script_animname) && !isDefined(existingentity.animname)) {
        existingentity.animname = existingentity.script_animname;
      }
    }
  }

  scenedata.var_a416d1b334ed6b37 = undefined;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(var_214d924f4e137244 object_get_type() == "Types_Player") {
      if(var_214d924f4e137244 function_3e13497ed7044cbd()) {
        scenedata.var_a416d1b334ed6b37 = 1;
        break;
      }
    }
  }

  if(istrue(scenedata.var_a416d1b334ed6b37)) {
    sceneroot function_9030d05e9f5301ff();
  }

  sceneplay.var_7038c2a13f1f5db8 = [];
  var_a55c41e47aa5aeb5 = [];

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(!var_214d924f4e137244 function_225d78e3c485a7ae(sceneplay.var_df5db7bd235f2729, sceneplay, var_56f4af8746a2d458)) {
      continue;
    }

    var_982109bda19f3517 = var_214d924f4e137244.sceneobject function_aeb2b46911a5811d();
    existingentities = var_214d924f4e137244 function_1ba5fc9ef8e19620(sceneroot, sceneplay, var_982109bda19f3517, existingentities, 1, 1, inittype);

    if(!isDefined(var_214d924f4e137244.entity)) {
      sceneroot.var_cf24d127aa3920a0 = var_214d924f4e137244 function_1ba5fc9ef8e19620(sceneroot, sceneplay, var_982109bda19f3517, sceneroot.var_cf24d127aa3920a0, 1, 0, inittype);
    }

    if(!isDefined(var_214d924f4e137244.entity)) {
      var_a55c41e47aa5aeb5 = var_214d924f4e137244 function_53687c7001a0784b(sceneroot, sceneplay, var_982109bda19f3517, var_a55c41e47aa5aeb5, "targetname", inittype);
    }

    if(!isDefined(var_214d924f4e137244.entity)) {
      var_a55c41e47aa5aeb5 = var_214d924f4e137244 function_53687c7001a0784b(sceneroot, sceneplay, var_982109bda19f3517, var_a55c41e47aa5aeb5, "script_noteworthy", inittype);
    }

    if(!isDefined(var_214d924f4e137244.entity)) {
      var_a55c41e47aa5aeb5 = var_214d924f4e137244 function_53687c7001a0784b(sceneroot, sceneplay, "_scene_global_" + var_982109bda19f3517, var_a55c41e47aa5aeb5, "targetname", inittype);
    }

    if(!isDefined(var_214d924f4e137244.entity)) {
      var_a55c41e47aa5aeb5 = var_214d924f4e137244 function_53687c7001a0784b(sceneroot, sceneplay, "_scene_global_" + var_982109bda19f3517, var_a55c41e47aa5aeb5, "script_noteworthy", inittype);
    }
  }

  playerindex = 0;
  var_2218e47de6541d57 = 0;
  var_48e25d3373e9b4b0 = 0;
  maxplayers = -1;

  if(isDefined(sceneroot.scenestatic) && isDefined(sceneroot.scenestatic.var_ce9c0a8610712c8d)) {
    maxplayers = sceneroot.scenestatic.var_ce9c0a8610712c8d;
  }

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(!isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458])) {
      continue;
    }

    var_982109bda19f3517 = var_214d924f4e137244.sceneobject function_aeb2b46911a5811d();

    if(!isDefined(var_214d924f4e137244.entity) && !var_214d924f4e137244.sceneobject function_d301ab09c0738edf()) {
      existingentities = var_214d924f4e137244 function_1ba5fc9ef8e19620(sceneroot, sceneplay, var_982109bda19f3517, existingentities, 0, 1, inittype);

      if(!isDefined(var_214d924f4e137244.entity)) {
        sceneroot.var_cf24d127aa3920a0 = var_214d924f4e137244 function_1ba5fc9ef8e19620(sceneroot, sceneplay, var_982109bda19f3517, sceneroot.var_cf24d127aa3920a0, 0, 0, inittype);
      }
    }

    entity = var_214d924f4e137244.entity;
    isplayerobject = var_214d924f4e137244 object_get_type() == "Types_Player";
    var_fdc8fd88a88422e5 = 0;

    var_fdc8fd88a88422e5 = getdvarint(@ "hash_3bc9bc279e3f772", 0);

    if(!isDefined(entity)) {
      var_d05ef3f217cebd10 = 1;

      if(isplayerobject && maxplayers >= 0) {
        playernumber = var_2218e47de6541d57;

        if(var_214d924f4e137244 function_3e13497ed7044cbd()) {
          playernumber = var_48e25d3373e9b4b0;
        }

        if(playernumber >= maxplayers) {
          var_d05ef3f217cebd10 = 0;
        }
      }

      if(var_d05ef3f217cebd10 && (!var_214d924f4e137244.sceneobject function_9be5ff9b4bc5843a(sceneplay.shotinit) || var_fdc8fd88a88422e5 && isplayerobject)) {
        var_214d924f4e137244.alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, sceneplay.shotinit, var_56f4af8746a2d458);
        function_e4fc30ccdca08b9d(var_214d924f4e137244.alignmentinfo);

        if(isplayerobject) {
          if(!var_214d924f4e137244 function_7c447098301ac4a3()) {
            if(playerindex < level.players.size) {
              playerentity = level.players[playerindex];

              if(!function_ac04e049ff623301(playerentity, var_214d924f4e137244)) {
                playerentity = undefined;
              }

              entity = playerentity;
            }
          }

          if(var_fdc8fd88a88422e5) {
            if(function_2fbba7f29e8d78ce(var_56f4af8746a2d458)) {
              entity = level.players[0];
            } else if(utility::is_equal(entity, level.players[0])) {
              entity = undefined;
            }
          }

        } else {
          var_214d924f4e137244.spawner = function_9b40ea5276506411(var_982109bda19f3517, 0);
          entity = var_214d924f4e137244 object_spawn(var_214d924f4e137244.alignmentinfo, sceneplay.shotinit);
        }
      } else {
        sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458] = undefined;
      }
    }

    if(isDefined(entity)) {
      var_214d924f4e137244 function_6acd8ab4606e2a09(sceneroot, sceneplay, entity, undefined, inittype);
    }

    issetup = istrue(var_214d924f4e137244.issetup) || isDefined(entity) && isDefined(entity.var_214d924f4e137244) && istrue(entity.var_214d924f4e137244.issetup);

    if(isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458]) && !(issetup && inittype == "scene_init_prestream")) {
      var_214d924f4e137244 object_setup(sceneplay);
    }

    if(isplayerobject) {
      playerindex++;

      if(var_214d924f4e137244 function_3e13497ed7044cbd()) {
        var_48e25d3373e9b4b0++;
        continue;
      }

      var_2218e47de6541d57++;
    }
  }

  sceneplay function_218d0124f21f73b1(sceneplay.shotinit);

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(!isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458])) {
      continue;
    }

    var_214d924f4e137244 function_535e6f4c06c15b1d(sceneplay, 1, 1, var_214d924f4e137244.alignmentinfo);

    if(var_214d924f4e137244.sceneobject function_83ba0b38ef7f3949() && inittype == "scene_init_user") {
      var_214d924f4e137244 function_9745e01cedd81c85(var_214d924f4e137244.alignmentinfo);
    }
  }

  sceneroot function_c643b2c6b794481e("Setup");
  sceneplay.state = "Stopped";
  sceneroot function_bb980ac4246f5baa("callback_init");
  return sceneplay;
}

function private function_7e5354b44c829c9e(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110, var_4f20498ef1bfe199) {
  sceneroot = self;

  if(getdvarint(@ "hash_1aa832f211c5245e")) {
    level waittill("<dev string:x14e>");
    return;
  }

  if(!utility::array_contains(level.var_a0b4eb1703be349a, sceneroot)) {
    sceneroot.var_4d8e093da0426022 = 1;
    level.var_a0b4eb1703be349a = utility::function_6d6af8144a5131f1(level.var_a0b4eb1703be349a, sceneroot);
  }

  sceneroot set_scriptbundle(scriptbundlename);

  if(!sceneroot function_bd09568f76dd40ca()) {
    return;
  }

  scenedata = sceneroot.scenedata;

  if(isDefined(existingentities) && !isarray(existingentities)) {
    existingentities = [existingentities];
  }

  state = sceneroot get_state();
  sceneplay = undefined;

  if(state != "NotSetup") {
    sceneplay = sceneroot function_e6197350552df14b(shotnames, 0);

    if(isDefined(sceneplay) && sceneplay.state == "Playing") {
      sceneplay function_28f230671b0b9a1f(0);
    }

    shotindices = undefined;

    foreach(var_370294f3b91920df in scenedata.sceneplay) {
      if(isDefined(var_370294f3b91920df.var_2b0ae4dffc850db2)) {
        var_6e70dd21d9147b17 = is_equal(var_370294f3b91920df, sceneplay);

        if(!var_6e70dd21d9147b17) {
          if(!isDefined(shotindices)) {
            shotindices = sceneroot function_14d02a749939e837(shotnames);
          }

          var_a1709fdb12562ef0 = utility::array_intersection(var_370294f3b91920df.var_df5db7bd235f2729, shotindices);

          if(var_a1709fdb12562ef0.size > 0) {
            var_6e70dd21d9147b17 = 1;
          }
        }

        if(var_6e70dd21d9147b17) {
          if(var_370294f3b91920df.var_2b0ae4dffc850db2 < 0 || gettime() > var_370294f3b91920df.var_2b0ae4dffc850db2) {
            sceneroot pre_stream(existingentities, var_370294f3b91920df.var_df5db7bd235f2729, level.framedurationseconds * 2);
          }

          var_370294f3b91920df.var_2b0ae4dffc850db2 = undefined;
        }
      }
    }
  }

  sceneplay = sceneroot function_a9fc7e7dfd78e15e(existingentities, shotnames, undefined, "scene_init_play");

  if(sceneplay.var_df5db7bd235f2729.size == 0) {
    shotsstr = "<dev string:x159>";

    if(isDefined(shotnames)) {
      shotsstr = "<dev string:x15d>";

      if(!isarray(shotnames)) {
        shotnames = [shotnames];
      }

      foreach(shot in shotnames) {
        shotsstr = shotsstr + "<dev string:x162>" + shot;
      }
    }

    iprintlnbold("<dev string:x167>" + sceneroot.script_scenescriptbundle + "<dev string:x173>" + shotsstr);

    return;
  }

  sceneplay function_da660bb71d6eb080(1);
  sceneplay function_e5b5e877417bc710(isDefined(var_4f20498ef1bfe199));
  sceneplay function_5a438716f043fddc(var_f7ab585bff4b110, sceneplay.var_df5db7bd235f2729);
  sceneplay function_950e5107399d1111();
  sceneroot function_bb980ac4246f5baa("callback_play");
  sceneroot.var_708c03f822068263 = undefined;

  while(isDefined(sceneroot.scenedata) && !istrue(sceneplay.stoprequested)) {
    scenestarttime = gettime();
    sceneplay.var_1344e48bc80d0f52 = utility::default_to(var_4f20498ef1bfe199, 0);

    while(sceneplay.var_1344e48bc80d0f52 < sceneplay.var_df5db7bd235f2729.size) {
      sceneplay.currentshot = sceneplay.var_df5db7bd235f2729[sceneplay.var_1344e48bc80d0f52];
      sceneplay.nextshot = undefined;

      if(sceneplay.var_1344e48bc80d0f52 + 1 < sceneplay.var_df5db7bd235f2729.size) {
        sceneplay.nextshot = sceneplay.var_df5db7bd235f2729[sceneplay.var_1344e48bc80d0f52 + 1];
      }

      if(sceneplay.var_df5db7bd235f2729.size > sceneplay.var_1344e48bc80d0f52 + 1) {
        var_43799a95aaee8d61 = scenedata.scenescriptbundle function_e65f46a710591a5();
        streamtime = 2;
        predicttime = streamtime;
        var_5b1df6bdb52e24c = [];

        for(var_7d3411523e9ab92c = sceneplay.var_1344e48bc80d0f52 + 1; var_7d3411523e9ab92c < sceneplay.var_df5db7bd235f2729.size; var_7d3411523e9ab92c++) {
          var_be98a78ee33f18b8 = sceneplay.var_df5db7bd235f2729[var_7d3411523e9ab92c];
          nextshot = scenedata.scenescriptbundle function_2218afa82a590ea3(var_be98a78ee33f18b8);
          var_5b1df6bdb52e24c[var_5b1df6bdb52e24c.size] = nextshot function_55042076624e1180();
          var_43799a95aaee8d61 = var_43799a95aaee8d61 || nextshot function_dd4368cda4b91e7d();
          predicttime -= sceneroot function_d9be975d8d1c9db3(var_be98a78ee33f18b8);

          if(predicttime <= 0) {
            break;
          }
        }

        if(var_43799a95aaee8d61) {
          var_73e1014ebc31c952 = sceneroot function_d9be975d8d1c9db3(sceneplay.currentshot, 1);
          streamstarttime = max(var_73e1014ebc31c952 - streamtime, level.framedurationseconds);
          sceneroot utility::function_f9a207358d70923c(streamstarttime, "scene_stop", &pre_stream, existingentities, var_5b1df6bdb52e24c, streamtime + 0.1, undefined, streamtime);
        }
      }

      success = sceneroot function_afea5de3a99c09ab(sceneplay, sceneplay.currentshot);

      if(!success) {
        break;
      }

      sceneplay.var_1344e48bc80d0f52++;
    }

    if(!isDefined(sceneroot.scenedata) || !sceneroot.scenedata.scenescriptbundle function_4f93a0dfb8fd6a47()) {
      break;
    }

    if(gettime() == scenestarttime) {
      break;
    }
  }

  sceneplay function_8accfbca6fff9e0();
}

function private function_8accfbca6fff9e0() {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;

  if(istrue(sceneroot.var_4d8e093da0426022)) {
    level.var_a0b4eb1703be349a = utility::array_remove(level.var_a0b4eb1703be349a, sceneroot);
  }

  sceneplay function_da660bb71d6eb080(0);
  sceneplay.state = "Stopped";
  sceneplay notify("Stopped");
  sceneplay function_bc27ed6c295108d7();

  if(sceneroot get_state() == "Stopped") {
    sceneroot function_2549c341bf1ae3e7("Stopped");
  }

  if(!istrue(sceneplay.stoprequested)) {
    sceneroot function_bb980ac4246f5baa("callback_done");
  }

  sceneroot thread function_798498fd6521b8f0();
}

function private function_9030d05e9f5301ff() {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  maleindices = [];
  femaleindices = [];

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(var_214d924f4e137244 object_get_type() == "Types_Player") {
      if(var_214d924f4e137244 function_3e13497ed7044cbd()) {
        femaleindices[femaleindices.size] = var_56f4af8746a2d458;
        continue;
      }

      maleindices[maleindices.size] = var_56f4af8746a2d458;
    }
  }

  maxcount = min(maleindices.size, femaleindices.size);

  for(i = 0; i < maxcount; i++) {
    maleplayerindex = maleindices[i];
    femaleplayerindex = femaleindices[i];
    scenedata.var_214d924f4e137244[maleplayerindex].var_9668be326e00024b = femaleplayerindex;
    scenedata.var_214d924f4e137244[femaleplayerindex].var_17f5321d96d1bf24 = maleplayerindex;
  }
}