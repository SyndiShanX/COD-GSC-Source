/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\scene_internal.gsc
************************************************/

#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\scene;
#using scripts\common\scene_debug;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\engine\utility;
#namespace scene;

function private autoexec function_2afb8e0809c2e65d() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  thread function_6cd499378aadcad8();

  scenebundles = getscriptbundlenames("scenescriptbundle");

  foreach(scenescriptbundle in scenebundles) {
    scenescriptbundle = getscriptbundle(scenescriptbundle);

    if(isDefined(scenescriptbundle)) {
      scenescriptbundle function_69abf08346f3f6d9();
    }
  }
}

function private function_ace39e84230f386() {
  if(!isDefined(level.scene)) {
    level.scene = spawnStruct();
  }

  if(!isDefined(level.scene.objecthandlers)) {
    level.scene.objecthandlers = [];
    function_7855ec4caf5901f9("Types_Object", "objectSpawn", &object_spawn);
    function_7855ec4caf5901f9("Types_Object", "objectSetup", &object_setup);
    function_7855ec4caf5901f9("Types_Object", "shotObjectPrepare", &function_d4dcec93a1db6e3f);
    function_7855ec4caf5901f9("Types_Object", "shotObjectSetup", &function_770c0b047ce9cfc1);
    function_7855ec4caf5901f9("Types_Object", "shotObjectLinkSetup", &function_d82945c5509ec28e);
    function_7855ec4caf5901f9("Types_Object", "shotObjectFirstFrame", &function_9745e01cedd81c85);
    function_7855ec4caf5901f9("Types_Object", "objectMatchEntity", &function_2294fe71a7c1d8d6);
    function_7855ec4caf5901f9("Types_Object", "objectGetAnimEntity", &function_4c4c2a548b9fc7ab);
    function_7855ec4caf5901f9("Types_Object", "objectGetLinkEnts", &function_f054a83311d7f448);
    function_7855ec4caf5901f9("Types_Object", "objectGetAnimRoot", &function_b9c245bf99df4a8);
    function_7855ec4caf5901f9("Types_Object", "objectTeleport", &object_teleport);
    function_7855ec4caf5901f9("Types_Object", "objectVelocity", &object_velocity);
    function_7855ec4caf5901f9("Types_Object", "shotObjectPlayAnim", &function_c34fc4bc3e1ecbcb);
    function_7855ec4caf5901f9("Types_Object", "objectWaitNotes", &function_8e9f8e1fbe2b7ab4);
    function_7855ec4caf5901f9("Types_Object", "shotObjectStopAnim", &function_9b8055c613f1bb31);
    function_7855ec4caf5901f9("Types_Object", "shotObjectCleanup", &function_a477eb91dc3b38b8);
    function_7855ec4caf5901f9("Types_Object", "objectCleanup", &object_cleanup);
    function_7855ec4caf5901f9("Types_Object", "objectDelete", &object_delete);
    function_7855ec4caf5901f9("Types_Object", "objectKill", &object_kill);
    function_7855ec4caf5901f9("Types_Vehicle", "objectSpawn", &function_6acf84052cd5ab1);
    function_7855ec4caf5901f9("Types_Vehicle", "shotObjectSetup", &function_dec77fd275b35e92);
    function_7855ec4caf5901f9("Types_Vehicle", "objectMatchEntity", &function_619f2e5d7f38d9d5);
    function_7855ec4caf5901f9("Types_Mayhem", "objectSpawn", &function_f09a700ae2edf8dc);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectSetup", &function_d4f1b2dce50c7b7);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectFirstFrame", &function_532562ce2e63032f);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectPlayAnim", &function_d0ffa1bea912444d);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectStopAnim", &function_94d19635a2c1b723);
    function_7855ec4caf5901f9("Types_Mayhem", "objectDelete", &function_e045fde582740c36);
    function_7855ec4caf5901f9("Types_XCam", "objectSpawn", &xcam_spawn);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectSetup", &function_371c152f2c391c55);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectCleanup", &function_2db9cd1521705174);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectFirstFrame", &function_d6ce74b74dc12311);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectPreStream", &function_90e78898cf74b132);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectPlayAnim", &function_7ce890b54a48b767);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectSkipAnim", &function_fe644d526883b9b4);
    function_7855ec4caf5901f9("Types_XCam", "shotObjectStopAnim", &function_544bbcb14d370c45);
    function_7855ec4caf5901f9("Types_XCam", "objectDelete", &xcam_delete);
    function_7855ec4caf5901f9("Types_XCam", "objectMatchEntity", &function_a9acafbfcda23112);
    function_7855ec4caf5901f9("Types_XCam", "objectCleanup", &xcam_cleanup);
    function_7855ec4caf5901f9("Types_XCam", "objectParticipatingCinematics", &function_1069a83dc140e900);
  }
}

function private function_e16b1ab0a35605d3(str_flag) {
  flag_wait(str_flag);

  foreach(s_scene in level.var_a0b4eb1703be349a) {
    if(isDefined(s_scene.spawnflags)) {
      if((s_scene.spawnflags & 2) == 2) {
        s_scene thread play();
        continue;
      }

      if((s_scene.spawnflags & 1) == 1) {
        s_scene thread init();
      }
    }
  }
}

function private function_6a66a98742866fed() {
  sceneroot = self;
  function_ace39e84230f386();

  if(isDefined(sceneroot.scenestatic)) {
    return;
  }

  sceneroot.scenestatic = spawnStruct();
}

function private function_bd09568f76dd40ca() {
  sceneroot = self;
  function_ace39e84230f386();

  if(isDefined(sceneroot.scenedata) && sceneroot.scenedata.state != "NotInit") {
    return isDefined(sceneroot.scenedata.scenescriptbundle);
  }

  scenedata = spawnStruct();
  sceneroot.scenedata = scenedata;
  scenedata.sceneroot = sceneroot;

  sceneroot function_475cdb01202582a1();

  scenedata.state = "NotSetup";
  scenedata.sceneplay = [];
  scenedata.scenescriptbundle = sceneroot scene_scriptbundle();
  scenedata.var_214d924f4e137244 = [];

  if(!isDefined(scenedata.scenescriptbundle)) {
    scriptbundlename = sceneroot function_6c0e3626ebce826f();

    if(isDefined(scriptbundlename)) {
      println("<dev string:x1c>" + sceneroot function_6c0e3626ebce826f() + "<dev string:x4b>");
    }

    return false;
  }

  objectcount = scenedata.scenescriptbundle function_291cd2f1089d3a94();

  for(objectindex = 0; objectindex < objectcount; objectindex++) {
    objectdata = spawnStruct();
    scenedata.var_214d924f4e137244[objectindex] = objectdata;
    objectdata.index = objectindex;
    objectdata.sceneroot = sceneroot;
    objectdata.sceneplay = undefined;
    objectdata.scenedata = scenedata;
    objectdata.sceneobject = scenedata.scenescriptbundle function_bfc4196d3da11705(objectindex);
    objectdata.functable = level.scene.var_8a6cbf5e0998e58d[objectdata.sceneobject function_c77857d663e8cfbe()];
    objectdata.entity = undefined;
    objectdata.existingentity = undefined;
    objectdata.active = undefined;
    objectdata.var_36831a04af11576f = undefined;
    objectdata.animtreeprevious = undefined;
    objectdata.var_41dc93404af773a3 = undefined;
    objectdata.activeanimation = undefined;
    objectdata.var_53c962747bd1f2f = undefined;
    objectdata.var_a3ff79ae166c57aa = undefined;
    objectdata.playbacksuccessful = undefined;
    objectdata.alignmentinfo = undefined;
    objectdata.issetup = undefined;
    objectdata.linkedtag = undefined;
    objectdata.xcamplaying = undefined;
    objectdata.alignmentinfo = undefined;
    objectdata.var_251898eb5a0e0c9f = undefined;
  }

  return true;
}

function private function_798498fd6521b8f0() {
  sceneroot = self;
  waittillframeend();

  if(sceneroot get_state() == "Stopped") {
    sceneroot scene_reset();
  }
}

function private scene_reset() {
  sceneroot = self;
  state = sceneroot get_state();

  if(state == "NotInit" || state == "NotSetup") {
    return;
  }

  if(state == "Playing") {
    sceneroot stop();
  }

  if(isDefined(sceneroot.scenedata)) {
    for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < sceneroot.scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
      var_214d924f4e137244 = sceneroot.scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

      if(isDefined(var_214d924f4e137244) && isDefined(var_214d924f4e137244.entity)) {
        var_214d924f4e137244 object_cleanup();
      }
    }
  }

  sceneroot function_c643b2c6b794481e("NotSetup");

  if(isDefined(sceneroot.scenedata) && sceneroot.scenedata.scenescriptbundle function_62cef499110730d3()) {
    sceneroot cleanup();
  }
}

function private function_e525ff755ac18cf6() {
  sceneroot = self;
  scenescriptbundle = sceneroot scene_scriptbundle();
  return scenescriptbundle function_2c5f030a3c002210();
}

function private function_d225e757dea4eca6() {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  animrate = undefined;

  if(isDefined(sceneroot.scenestatic)) {
    animrate = sceneroot.scenestatic.animrate;
  }

  if(!isDefined(scenedata)) {
    return;
  }

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
    var_214d924f4e137244 function_6a4d64bdba27cb06(animrate);
  }
}

function private function_bb980ac4246f5baa(var_8338711a0d65673b) {
  sceneroot = self;
  scenestatic = sceneroot.scenestatic;

  if(!isDefined(var_8338711a0d65673b)) {
    return;
  }

  scriptbundlename = sceneroot function_6c0e3626ebce826f();

  if(!isDefined(scriptbundlename)) {
    return;
  }

  if(isDefined(level.scene.funcs) && isDefined(level.scene.funcs[scriptbundlename]) && isDefined(level.scene.funcs[scriptbundlename][var_8338711a0d65673b])) {
    foreach(func in level.scene.funcs[scriptbundlename][var_8338711a0d65673b]) {
      sceneroot thread[[func]]();
    }
  }

  if(isDefined(scenestatic) && isDefined(scenestatic.funcs) && isDefined(scenestatic.funcs[scriptbundlename]) && isDefined(scenestatic.funcs[scriptbundlename][var_8338711a0d65673b])) {
    foreach(func in scenestatic.funcs[scriptbundlename][var_8338711a0d65673b]) {
      sceneroot thread[[func]]();
    }
  }
}

function private function_14d02a749939e837(var_2a29e57c1c105d52) {
  sceneroot = self;
  shotindexes = var_2a29e57c1c105d52;

  if(isDefined(shotindexes)) {
    scenescriptbundle = sceneroot scene_scriptbundle();
    shotcount = scenescriptbundle function_d1338e27a26ecaeb();

    if(!isarray(shotindexes)) {
      shotindexes = [shotindexes];
    }

    for(i = 0; i < shotindexes.size; i++) {
      shotindex = shotindexes[i];

      if(isDefined(shotindex) && !isint(shotindex)) {
        shotindexes[i] = -1;

        for(var_b0239d47df5d0169 = 0; var_b0239d47df5d0169 < shotcount; var_b0239d47df5d0169++) {
          shot = scenescriptbundle function_2218afa82a590ea3(var_b0239d47df5d0169);
          shotname = shot function_55042076624e1180();

          if(shotname == shotindex) {
            shotindexes[i] = var_b0239d47df5d0169;
            break;
          }
        }
      }
    }
  } else {
    shotindexes = [];
    shotcount = sceneroot.scenedata.scenescriptbundle function_d1338e27a26ecaeb();

    for(shotindex = 0; shotindex < shotcount; shotindex++) {
      shotindexes[shotindexes.size] = shotindex;
    }
  }

  return shotindexes;
}

function private function_303476b29feb54bb(shotindices) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  scenescriptbundle = sceneroot scene_scriptbundle();
  shotcount = scenescriptbundle function_d1338e27a26ecaeb();

  if(!isarray(shotindices)) {
    shotindices = [shotindices];
  }

  result = function_1823ff50bb28148d("SSK");

  for(i = 0; i < shotindices.size; i++) {
    shotindex = shotindices[i];
    assert(isint(shotindex));
    result = hashcat(result, "_" + shotindex);
  }

  return result;
}

function private function_e6197350552df14b(shotnames, var_94f8931d2dd061eb) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  shotindices = sceneroot function_14d02a749939e837(shotnames);
  sequencekey = sceneroot function_303476b29feb54bb(shotindices);

  if(isDefined(scenedata.sceneplay[sequencekey])) {
    return scenedata.sceneplay[sequencekey];
  }

  if(!istrue(var_94f8931d2dd061eb)) {
    return undefined;
  }

  sceneplay = spawnStruct();
  sceneplay.sceneroot = sceneroot;
  sceneplay.var_df5db7bd235f2729 = [];
  sceneplay.shotindices = shotindices;
  sceneplay.var_1344e48bc80d0f52 = undefined;

  for(shotindex = 0; shotindex < shotindices.size; shotindex++) {
    var_531b82ca81cb9e5c = shotindices[shotindex];
    shot = scenedata.scenescriptbundle function_2218afa82a590ea3(var_531b82ca81cb9e5c);

    if(isDefined(shot) && !shot function_d218620a1b80e648()) {
      sceneplay.var_df5db7bd235f2729[sceneplay.var_df5db7bd235f2729.size] = var_531b82ca81cb9e5c;
    }
  }

  if(isDefined(sceneplay.var_df5db7bd235f2729[0])) {
    sceneplay.shotinit = sceneplay.var_df5db7bd235f2729[0];
  } else {
    sceneplay.shotinit = 0;
  }

  scenedata.sceneplay[sequencekey] = sceneplay;
  return sceneplay;
}

function private scene_coordinated_reach(sceneplay, shotindex, var_4bc185af207d5706, guy_anim) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  sceneplay notify("scene_coordinated_reach");
  sceneplay endon("scene_coordinated_reach");

  if(isDefined(sceneplay.var_56ebabfb3c6985b8)) {
    sceneplay.var_56ebabfb3c6985b8 = min(sceneplay.var_56ebabfb3c6985b8, var_4bc185af207d5706);
  } else {
    sceneplay.var_56ebabfb3c6985b8 = var_4bc185af207d5706;
  }

  if(!isDefined(sceneplay.var_6909d1a5df21c351)) {
    sceneplay.var_6909d1a5df21c351 = [];
  }

  sceneplay.var_6909d1a5df21c351[sceneplay.var_6909d1a5df21c351.size] = guy_anim;
  waittillframeend();
  sceneroot function_dca1a3a29d2ee467(sceneplay.var_6909d1a5df21c351, sceneplay.var_56ebabfb3c6985b8);

  foreach(guy_anim in sceneplay.var_6909d1a5df21c351) {
    guy = guy_anim[0];

    if(isDefined(guy)) {
      guy notify("scene_coordinated_reach");
    }
  }

  sceneplay.var_6909d1a5df21c351 = undefined;
  sceneplay.var_56ebabfb3c6985b8 = undefined;
}

function private function_796087cbcf3fb30(var_a99e1a741be31063) {
  if(!isDefined(level.var_3d4e5fba17201307)) {
    level.var_3d4e5fba17201307 = [];
    level.var_3d4e5fba17201307["Exposed"] = "Exposed";
    level.var_3d4e5fba17201307["ExposedMoving"] = "Exposed Moving";
    level.var_3d4e5fba17201307["ExposedCrouch"] = "Exposed Crouch";
    level.var_3d4e5fba17201307["CoverCrouch"] = "Cover Crouch";
    level.var_3d4e5fba17201307["CoverStand"] = "Cover Stand";
    level.var_3d4e5fba17201307["CoverProne"] = "Cover Prone";
    level.var_3d4e5fba17201307["CoverLeft"] = "Cover Left";
    level.var_3d4e5fba17201307["CoverLeftCrouch"] = "Cover Left Crouch";
    level.var_3d4e5fba17201307["CoverRight"] = "Cover Right";
    level.var_3d4e5fba17201307["CoverRightCrouch"] = "Cover Right Crouch";
    level.var_3d4e5fba17201307["CoverCrouchLMG"] = "Cover Crouch LMG";
    level.var_3d4e5fba17201307["CoverStandLMG"] = "Cover Stand LMG";
  }

  if(!isDefined(level.var_3d4e5fba17201307[var_a99e1a741be31063])) {
    println("<dev string:x50>" + var_a99e1a741be31063);
    return "Exposed";
  }

  return level.var_3d4e5fba17201307[var_a99e1a741be31063];
}

function private reach_speed(demeanor, locomotion) {
  var_4bc185af207d5706 = 225;

  switch (demeanor) {
    case #"hash_186d745a92c317d9":
      var_4bc185af207d5706 = 53;
      break;
    case #"hash_9128327eb51e0b7b":
      var_4bc185af207d5706 = 48;
      break;
    case #"hash_46fdaf04e9be63e4":
      var_4bc185af207d5706 = 75;
      break;
    case #"hash_d320ccf96c495f71":
      var_4bc185af207d5706 = 47;
      break;
    case #"hash_1a53266c17b7d481":
    case #"hash_9a93c307fd4015ae":
    case #"hash_9e02cd4a0f3ca981":
    case #"hash_a7db48ba68421306":
      if(locomotion == "sprint") {
        var_4bc185af207d5706 = 225;
      } else {
        var_4bc185af207d5706 = 140;
      }

      break;
    case #"hash_eb06fed69a41dab5":
      var_4bc185af207d5706 = 225;
      break;
  }

  if(demeanor != "patrol" && demeanor != "alert") {
    switch (locomotion) {
      case #"hash_bdea5e7441323370":
        var_4bc185af207d5706 *= 0.5;
        break;
      case #"hash_5c7fca6c3a403003":
        var_4bc185af207d5706 *= 0.75;
        break;
    }
  }

  return var_4bc185af207d5706;
}

function private function_950e5107399d1111() {
  sceneplay = self;
  typefunc = function_1a2cae854fe073a0("modeStartMonitoringPlayers");

  if(isDefined(typefunc)) {
    sceneplay thread[[typefunc]]();
  }
}

function private function_bc27ed6c295108d7() {
  sceneplay = self;
  typefunc = function_1a2cae854fe073a0("modeStopMonitoringPlayers");

  if(isDefined(typefunc)) {
    sceneplay[[typefunc]]();
  }
}

function private function_9f853ecc68f5058() {
  typefunc = function_1a2cae854fe073a0("modeXCamRespectsStartingTimeOnClients");

  if(isDefined(typefunc)) {
    return [[typefunc]]();
  }

  return 0;
}

function private function_a89f1262c5148bdf() {
  var_214d924f4e137244 = self;
  return default_to(var_214d924f4e137244.sceneobject.variant_object.playerlinktag, "tag_player");
}

function private function_b6130df53fbf724c() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.var_9f78587cfefc10ac);
}

function private function_3e13497ed7044cbd() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.isfemale);
}

function private function_ac04e049ff623301(entity, var_214d924f4e137244) {
  if(!isDefined(entity)) {
    return 0;
  }

  if(istrue(var_214d924f4e137244.scenedata.var_a416d1b334ed6b37)) {
    typefunc = function_1a2cae854fe073a0("modePlayerMatchingObjectForFemale");

    if(isDefined(typefunc)) {
      return [[typefunc]](entity, var_214d924f4e137244);
    }
  }

  return 1;
}

function private function_7c447098301ac4a3() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.var_9cadc424d1421646);
}

function private function_5fe020a6db35fab3(shotindex) {
  var_214d924f4e137244 = self;
  var_409dc6bbf1421f94 = ["offhand_weapons", "melee", "sprint", "allow_jump", "mantle"];

  if(!var_214d924f4e137244 function_b6130df53fbf724c()) {
    var_409dc6bbf1421f94[var_409dc6bbf1421f94.size] = "usability";
  }

  if(var_214d924f4e137244.sceneobject function_d1dd52dc1f43215d(shotindex) != "Keep") {
    var_409dc6bbf1421f94[var_409dc6bbf1421f94.size] = "weapon";
  }

  if(!var_214d924f4e137244.sceneobject function_fcc766f42b75a322(shotindex)) {
    var_409dc6bbf1421f94[var_409dc6bbf1421f94.size] = "weapon_switch";
  }

  return var_409dc6bbf1421f94;
}

function private function_285bdba488858f9e(shotindex) {
  var_214d924f4e137244 = self;
  shotobject = var_214d924f4e137244.sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_e6d38aba102a77d4, 0);
}

function private function_e7257014ebaeeaa8(enabled) {
  assert(isPlayer(self));
  player = self;
  typefunc = function_1a2cae854fe073a0("modeLetterbox");

  if(isDefined(typefunc)) {
    player thread[[typefunc]](enabled);
  }
}

function private function_bb60d8e77392c74e(tweenout, duration, hidemodel, stopxcam) {
  assert(isPlayer(self));
  player = self;
  player startcameratween(duration, hidemodel, "ease_inout_sine", 0, stopxcam);
}

function private function_15848d0bdc45e95e() {
  sceneplay = self;
  scenescriptbundle = sceneplay.sceneroot scene_scriptbundle();
  result = [];

  foreach(shotindex in sceneplay.var_df5db7bd235f2729) {
    result[result.size] = scenescriptbundle function_a3be29c7b9c648ef(shotindex);
  }

  return result;
}

function private function_218d0124f21f73b1(shotindex) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
      var_214d924f4e137244.alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, shotindex, var_56f4af8746a2d458);
    }
  }

  sceneplay.objectorder = [];

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    addorder = [];

    for(var_bf53103eaf0d32f9 = var_56f4af8746a2d458; isDefined(var_bf53103eaf0d32f9) && isDefined(scenedata.var_214d924f4e137244[var_bf53103eaf0d32f9]) && !isDefined(sceneplay.objectorder[var_bf53103eaf0d32f9]); var_bf53103eaf0d32f9 = undefined) {
      addorder[addorder.size] = var_bf53103eaf0d32f9;

      if(!isDefined(scenedata.var_214d924f4e137244[var_bf53103eaf0d32f9].alignmentinfo)) {
        scenedata.var_214d924f4e137244[var_bf53103eaf0d32f9].alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, shotindex, var_56f4af8746a2d458);
      }

      nextindex = scenedata.var_214d924f4e137244[var_bf53103eaf0d32f9].alignmentinfo.var_93cd726eb6096497;

      if(isDefined(nextindex) && nextindex != var_bf53103eaf0d32f9) {
        var_bf53103eaf0d32f9 = nextindex;
        continue;
      }
    }

    for(i = addorder.size - 1; i >= 0; i--) {
      sceneplay.objectorder[addorder[i]] = sceneplay.var_7038c2a13f1f5db8[addorder[i]];
    }
  }
}

function private function_e1b0a65cc436523d(shotindex) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(isDefined(var_214d924f4e137244)) {
      var_214d924f4e137244.var_bb2bc0aa7d81de89 = undefined;
    }
  }

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
      var_be98a78ee33f18b8 = sceneplay.nextshot;

      if(isDefined(var_be98a78ee33f18b8)) {
        if(isDefined(var_19a1a40cf0ff83b9[var_be98a78ee33f18b8])) {
          var_214d924f4e137244.var_bb2bc0aa7d81de89 = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, var_be98a78ee33f18b8, var_56f4af8746a2d458);
        }
      }
    }
  }
}

function private function_e5b5e877417bc710(isskipping) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;
  sceneplay.state = "Playing";

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
    var_214d924f4e137244.sceneplay = sceneplay;
    var_214d924f4e137244 notify("scene_play");
  }

  sceneplay notify("scene_play");

  if(!istrue(isskipping)) {
    sceneplay thread scene_play_wait_skip();
  }
}

function private scene_play_wait_skip() {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!sceneroot function_e525ff755ac18cf6()) {
    return;
  }

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(isPlayer(var_214d924f4e137244.entity)) {
      var_214d924f4e137244.entity thread player_scene_play_wait_skip(sceneplay);
    }
  }
}

function private function_317afd3b93b0b54d(player, pos) {
  sceneplay = self;
  assert(isPlayer(player));
  assert(isvector(pos));
  clientnum = player getentitynumber();

  if(!isDefined(sceneplay.prestream.players)) {
    sceneplay.prestream.players = [];
  }

  if(!isDefined(sceneplay.prestream.players[clientnum])) {
    sceneplay.prestream.players[clientnum] = spawnStruct();
  }

  playerinfo = sceneplay.prestream.players[clientnum];
  playerinfo.player = player;

  if(!isDefined(playerinfo.cameraorigins)) {
    playerinfo.cameraorigins = [];
  }

  playerinfo.cameraorigins[playerinfo.cameraorigins.size] = pos;
}

function private function_da660bb71d6eb080(boolval) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!isDefined(scenedata)) {
    return;
  }

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
    var_214d924f4e137244 function_5006f1d3bba27ce4(boolval);
  }
}

function private player_scene_play_wait_skip(sceneplay) {
  assert(isPlayer(self));
  player = self;
  player notify("player_scene_play_wait_skip");
  player endon("player_scene_play_wait_skip");
  player endon("death_or_disconnect");
  sceneplay endon("scene_stop");
  sceneplay endon("Stopped");
  player setclientomnvar("ui_is_bink_skippable", 1);

  while(true) {
    player waittillmatch("luinotifyserver", "skip_bink_input");

    if(!is_equal(sceneplay.state, "Playing")) {
      break;
    }

    player setclientomnvar("ui_is_bink_skippable", 0);
    shotnames = sceneplay function_15848d0bdc45e95e();
    sceneplay.sceneroot thread skip(shotnames, 0.5);
    return;
  }

  player setclientomnvar("ui_is_bink_skippable", 0);
}

function private function_5a438716f043fddc(var_f7ab585bff4b110, var_df5db7bd235f2729) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  sceneplay.var_43286fd46706909c = undefined;

  if(!isDefined(var_f7ab585bff4b110) || isDefined(var_f7ab585bff4b110) && var_f7ab585bff4b110 == 0) {
    return;
  }

  var_43286fd46706909c = spawnStruct();
  var_43286fd46706909c.var_f7ab585bff4b110 = clamp(var_f7ab585bff4b110, 0, 1);
  var_43286fd46706909c.totaltimesec = 0;
  var_43286fd46706909c.var_f263562e5b98bed4 = [];
  sceneplay.var_43286fd46706909c = var_43286fd46706909c;

  foreach(shotindex in var_df5db7bd235f2729) {
    var_f263562e5b98bed4 = spawnStruct();
    var_f263562e5b98bed4.startsec = var_43286fd46706909c.totaltimesec;
    var_f263562e5b98bed4.durationsec = sceneroot function_30140edcf9e36027(sceneplay, shotindex);
    var_43286fd46706909c.var_f263562e5b98bed4[shotindex] = var_f263562e5b98bed4;
    var_43286fd46706909c.totaltimesec += var_f263562e5b98bed4.durationsec;
  }

  var_43286fd46706909c.fromtimesec = var_43286fd46706909c.totaltimesec * var_43286fd46706909c.var_f7ab585bff4b110;
}

function private function_afea5de3a99c09ab(sceneplay, shotindex) {
  sceneroot = self;
  success = 1;
  scenedata = sceneroot.scenedata;
  sceneplay.currentshot = shotindex;
  sceneplay function_218d0124f21f73b1(shotindex);
  sceneplay function_e1b0a65cc436523d(shotindex);
  sceneroot function_bb980ac4246f5baa(scenedata.scenescriptbundle function_a3be29c7b9c648ef(shotindex));
  sceneplay function_7c1dbb8157a07757("prepare", shotindex);

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      sceneroot thread function_c4b3a49a6470bd32(sceneplay, "prepare", shotindex, var_56f4af8746a2d458);
    }
  }

  sceneplay function_fef8a82cd85330df("prepare");

  var_4e7a3e672aaebeaa = getdvarint(@ "hash_36ab188f318b1392", 0);

  if(var_4e7a3e672aaebeaa) {
    var_2f23edb971f368a6 = gettime();

    if(isDefined(sceneroot.var_708c03f822068263)) {
      assert(sceneroot.var_708c03f822068263 == var_2f23edb971f368a6);

      if(sceneroot.var_708c03f822068263 != var_2f23edb971f368a6) {
        here = 0;
      }
    }

    sceneroot.var_2f23edb971f368a6 = var_2f23edb971f368a6;
  }

  if(!istrue(sceneplay.stoprequested)) {
    sceneplay scripts\common\scene_debug::function_d4cfde3fa9af7e5a(shotindex);

    sceneplay function_7c1dbb8157a07757("anim", shotindex);

    foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
      if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
        sceneroot thread function_daa02d9da601d14d(sceneplay, "anim", shotindex, var_56f4af8746a2d458);
      }
    }

    shot = sceneroot.scenedata.scenescriptbundle function_2218afa82a590ea3(shotindex);

    if(shot function_9336a9805a4ab29a()) {
      var_73e1014ebc31c952 = sceneroot function_d9be975d8d1c9db3(shotindex, 1);
      var_40954f4dddf00c13 = function_81bab5b9c097deb5(var_73e1014ebc31c952);

      if(var_40954f4dddf00c13 > 0) {
        sceneplay delaythread(var_40954f4dddf00c13, &function_8cb9e28d833bd068, "anim");
      }
    }

    sceneplay function_fef8a82cd85330df("anim");

    if(var_4e7a3e672aaebeaa) {
      sceneroot.var_708c03f822068263 = gettime();
    }

    sceneplay scripts\common\scene_debug::function_6b2bc344ea55f120();
  }

  foreach(var_56f4af8746a2d458, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

      if(isDefined(var_214d924f4e137244.playbacksuccessful) && !var_214d924f4e137244.playbacksuccessful) {
        success = 0;
      }
    }
  }

  sceneplay notify("scene_shot_cleanup");
  return success;
}

function private function_81bab5b9c097deb5(shot_length) {
  var_9f421c699167b4eb = 50;

  if(isDefined(level.frameduration) && level.frameduration > 0) {
    var_9f421c699167b4eb = level.frameduration;
  }

  lengthms = round(shot_length * 1000);
  modms = lengthms % var_9f421c699167b4eb;
  adjustedlength = (lengthms - modms) / 1000;
  return adjustedlength;
}

function private function_30140edcf9e36027(sceneplay, shotindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  maxtimesec = 0;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_ae362d23669f650 = sceneroot function_7d78fe1c5576bf4c(sceneplay, shotindex, var_56f4af8746a2d458);
    maxtimesec = max(maxtimesec, var_ae362d23669f650);
  }

  return maxtimesec;
}

function private function_7c1dbb8157a07757(objecttask, shotindex) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;
  sceneplay.waitobjects[objecttask] = [];

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    if(isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458]) && isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458][shotindex])) {
      sceneplay.waitobjects[objecttask][var_56f4af8746a2d458] = var_56f4af8746a2d458;
    }
  }
}

function private function_456603ee124b8267(objecttask, objectindex) {
  sceneplay = self;

  if(isDefined(sceneplay.waitobjects) && isDefined(sceneplay.waitobjects[objecttask])) {
    sceneplay.waitobjects[objecttask][objectindex] = undefined;
  }

  sceneplay notify(objecttask);
}

function private function_fef8a82cd85330df(objecttask) {
  sceneplay = self;

  while(isDefined(sceneplay.waitobjects[objecttask]) && sceneplay.waitobjects[objecttask].size > 0) {
    sceneplay waittill(objecttask);
  }

  sceneplay.waitobjects[objecttask] = undefined;
}

function private function_8cb9e28d833bd068(objecttask) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!isDefined(sceneplay)) {
    return;
  }

  if(!isDefined(sceneplay.waitobjects)) {
    return;
  }

  foreach(var_56f4af8746a2d458 in sceneplay.waitobjects[objecttask]) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
    var_214d924f4e137244 function_bdd631983c9e6f5c();
  }
}

function private function_28f230671b0b9a1f(var_9ca58f7c9e862815) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;
  sceneplay.stoprequested = 1;
  sceneplay notify("scene_stop");
  sceneroot notify("scene_stop");

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    if(isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458])) {
      var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
      sceneroot function_b9b2392985736c52(var_56f4af8746a2d458);
    }
  }

  waittillframeend();

  while(sceneplay.state == "Playing") {
    anyactive = 0;

    for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
      if(isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458])) {
        var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

        if(isDefined(var_214d924f4e137244.active)) {
          anyactive = 1;
          break;
        }
      }
    }

    if(!anyactive) {
      sceneplay.state = "Stopped";
    }

    waitframe();
  }

  if(istrue(var_9ca58f7c9e862815)) {
    sceneplay function_8accfbca6fff9e0();
  }

  sceneplay.stoprequested = undefined;
}

function private function_c4b3a49a6470bd32(sceneplay, objecttask, shotindex, objectindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = scenedata.var_214d924f4e137244[objectindex];

  if(var_214d924f4e137244 ent_flag("scene_object_active")) {
    sceneroot function_b9b2392985736c52(objectindex);
  }

  var_214d924f4e137244 ent_flag_waitopen("scene_object_active");
  var_214d924f4e137244 ent_flag_set("scene_object_active");
  animtype = var_214d924f4e137244.sceneobject function_92192185fc7c5500();
  var_214d924f4e137244.var_36831a04af11576f = [];
  var_214d924f4e137244.var_36831a04af11576f[animtype] = "prepare" + shotindex + objectindex;
  var_214d924f4e137244.active = "prepare";
  var_214d924f4e137244 function_d4dcec93a1db6e3f(sceneplay, shotindex, objectindex);
  sceneplay function_456603ee124b8267(objecttask, objectindex);
}

function private function_daa02d9da601d14d(sceneplay, objecttask, shotindex, objectindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = scenedata.var_214d924f4e137244[objectindex];
  var_214d924f4e137244.var_36831a04af11576f = undefined;

  if(!isDefined(var_214d924f4e137244.active)) {
    sceneplay function_456603ee124b8267(objecttask, objectindex);
    return;
  }

  if(var_214d924f4e137244.sceneobject function_c2a0ad9229a93162(shotindex)) {
    sceneplay function_456603ee124b8267(objecttask, objectindex);
  }

  animated = var_214d924f4e137244.sceneobject function_938cdb6ca25882fc(shotindex);
  var_214d924f4e137244 function_770c0b047ce9cfc1(shotindex);
  var_214d924f4e137244.active = "anim";
  var_214d924f4e137244.playbacksuccessful = 1;
  var_c5edd954050d9248 = 0;
  var_e731c34c23a09be5 = 0;
  lerptime = var_214d924f4e137244.sceneobject function_1e3ba3c3afdbb7b4(shotindex);
  blendtime = var_214d924f4e137244.sceneobject function_205f7afe5d801664(shotindex);
  blendcurve = var_214d924f4e137244.sceneobject function_167ed32773c7c534(shotindex);
  overridelerp = var_214d924f4e137244 function_a680ab1ba5753613(shotindex, "lerp");
  overrideblend = var_214d924f4e137244 function_a680ab1ba5753613(shotindex, "blend");

  if(isDefined(overridelerp)) {
    lerptime = float(overridelerp);
  }

  if(isDefined(overrideblend)) {
    blendtime = float(overrideblend);
  }

  cameraanimation = var_214d924f4e137244 function_6c3d100538f590b3(shotindex);
  shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);
  var_44a5342136771a97 = isarray(shotanimations) && shotanimations.size > 0;
  var_214d924f4e137244 function_535e6f4c06c15b1d(sceneplay, 1, 0, var_214d924f4e137244.alignmentinfo, lerptime);

  if(animated) {
    animtype = var_214d924f4e137244.sceneobject function_92192185fc7c5500();

    if(isDefined(sceneplay.var_43286fd46706909c)) {
      var_66a9a5767d99231e = sceneroot function_7d78fe1c5576bf4c(sceneplay, shotindex, objectindex);
      var_29506d8602a737a4 = sceneplay.var_43286fd46706909c.var_f263562e5b98bed4[shotindex].startsec;
      var_c5edd954050d9248 = var_29506d8602a737a4;
      var_9102eff943c3c717 = var_29506d8602a737a4 + var_66a9a5767d99231e;
      var_e731c34c23a09be5 = 0;

      if(var_9102eff943c3c717 < sceneplay.var_43286fd46706909c.fromtimesec) {
        var_214d924f4e137244.active = undefined;

        if(var_44a5342136771a97) {
          for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
            var_ad746e2693353028 = animtype + shotindex + objectindex + animationindex;
            var_214d924f4e137244 function_9605363169f7b770(var_214d924f4e137244.alignmentinfo, shotanimations[animationindex], var_ad746e2693353028, 0, 1, animtype);
          }
        }

        if(isDefined(cameraanimation)) {
          var_ad746e2693353028 = animtype + shotindex + objectindex + animationindex + 0;
          var_214d924f4e137244 function_9605363169f7b770(var_214d924f4e137244.alignmentinfo, cameraanimation, var_ad746e2693353028, 0, 1, "CameraAnimation");
        }

        var_214d924f4e137244 function_4479600930e9e402(0, sceneplay, objecttask, shotindex, objectindex);
        return;
      } else {
        var_c5edd954050d9248 = sceneplay.var_43286fd46706909c.fromtimesec - var_29506d8602a737a4;
      }
    }

    if(is_equal(var_214d924f4e137244.active, "anim")) {
      if(isDefined(cameraanimation)) {
        var_ad746e2693353028 = animtype + shotindex + objectindex + 0;
        var_866b3a3066122e39 = 0;

        if(isDefined(sceneplay.var_43286fd46706909c)) {
          var_866b3a3066122e39 = clamp(var_c5edd954050d9248 / var_214d924f4e137244 function_9c0d01ef917ee30(cameraanimation, "CameraAnimation"), 0, 1);
          var_214d924f4e137244 function_9605363169f7b770(var_214d924f4e137244.alignmentinfo, cameraanimation, var_ad746e2693353028, 0, var_866b3a3066122e39, "CameraAnimation");
        }

        var_812033365bb24665 = "CameraAnimation" + shotindex + objectindex;
        var_214d924f4e137244 childthread function_c34fc4bc3e1ecbcb(shotindex, 0, var_812033365bb24665, var_214d924f4e137244.alignmentinfo, cameraanimation, var_866b3a3066122e39, blendtime, blendcurve, lerptime, "CameraAnimation");
      }

      if(var_44a5342136771a97) {
        animationindex = 0;

        while(animationindex < shotanimations.size) {
          var_ad746e2693353028 = animtype + shotindex + objectindex + animationindex;
          var_866b3a3066122e39 = 0;

          if(var_c5edd954050d9248 > var_e731c34c23a09be5) {
            var_1f44bab9b75c3c9 = var_214d924f4e137244 function_9c0d01ef917ee30(shotanimations[animationindex], animtype);

            if(var_1f44bab9b75c3c9 > 0) {
              var_866b3a3066122e39 = clamp((var_c5edd954050d9248 - var_e731c34c23a09be5) / var_1f44bab9b75c3c9, 0, 1);
              var_214d924f4e137244 function_9605363169f7b770(var_214d924f4e137244.alignmentinfo, shotanimations[animationindex], var_ad746e2693353028, 0, var_866b3a3066122e39, animtype);

              if(var_866b3a3066122e39 > 1) {
                var_e731c34c23a09be5 += var_1f44bab9b75c3c9;
                animationindex++;
                continue;
              }
            } else {
              animationindex++;
              continue;
            }
          }

          var_1f44bab9b75c3c9 = var_214d924f4e137244 function_c34fc4bc3e1ecbcb(shotindex, animationindex, var_ad746e2693353028, var_214d924f4e137244.alignmentinfo, shotanimations[animationindex], var_866b3a3066122e39, blendtime, blendcurve, lerptime, animtype);

          if(isDefined(var_1f44bab9b75c3c9)) {
            var_c5edd954050d9248 += var_1f44bab9b75c3c9;
            var_e731c34c23a09be5 += var_1f44bab9b75c3c9;
          }

          animationindex++;

          if(!is_equal(var_214d924f4e137244.active, "anim") || !is_equal(var_214d924f4e137244.sceneplay, sceneplay) || !isDefined(var_214d924f4e137244.scenedata)) {
            break;
          }
        }
      }
    }
  }

  while(isDefined(var_214d924f4e137244.var_36831a04af11576f) && var_214d924f4e137244.var_36831a04af11576f.size > 0) {
    var_214d924f4e137244 waittill("scene_anim_ended");
  }

  var_214d924f4e137244 function_4479600930e9e402(animated, sceneplay, objecttask, shotindex, objectindex);
}

function private function_4479600930e9e402(animated, sceneplay, objecttask, shotindex, objectindex) {
  var_214d924f4e137244 = self;

  if(animated && !isDefined(var_214d924f4e137244.activeanimation)) {
    var_d6a0e35c2c8084e7 = 0;

    if(isDefined(var_214d924f4e137244.var_bb2bc0aa7d81de89)) {
      var_d6a0e35c2c8084e7 = function_1cf2b9abf05dd81d(var_214d924f4e137244.alignmentinfo.alignent, var_214d924f4e137244.alignmentinfo.aligntag, var_214d924f4e137244.var_bb2bc0aa7d81de89.alignent, var_214d924f4e137244.var_bb2bc0aa7d81de89.aligntag);
    }

    if(!var_d6a0e35c2c8084e7) {
      var_214d924f4e137244 function_535e6f4c06c15b1d(sceneplay, 0, 0, var_214d924f4e137244.alignmentinfo);
    }
  }

  var_214d924f4e137244 function_a477eb91dc3b38b8(shotindex);

  if(var_214d924f4e137244 function_d04468979de3a6dd(sceneplay, shotindex)) {
    var_214d924f4e137244 function_f9a207358d70923c(level.framedurationseconds, "scene_play", &object_cleanup);
  }

  var_214d924f4e137244.active = undefined;
  var_214d924f4e137244 ent_flag_clear("scene_object_active");
  sceneplay function_456603ee124b8267(objecttask, objectindex);
}

function private function_157c6db3114c1ec9(sceneplay) {
  var_214d924f4e137244 = self;
  assert(isDefined(sceneplay));
  assert(isarray(sceneplay.var_df5db7bd235f2729));
  assert(isint(sceneplay.var_1344e48bc80d0f52));
  objectindex = var_214d924f4e137244.index;

  if(!isDefined(sceneplay.var_7038c2a13f1f5db8[objectindex])) {
    return false;
  }

  for(var_2d687b7add41f6a3 = sceneplay.var_1344e48bc80d0f52 + 1; var_2d687b7add41f6a3 < sceneplay.var_df5db7bd235f2729.size; var_2d687b7add41f6a3++) {
    var_1ee8422a72befa7 = sceneplay.var_df5db7bd235f2729[var_2d687b7add41f6a3];

    if(isDefined(sceneplay.var_7038c2a13f1f5db8[objectindex][var_1ee8422a72befa7])) {
      return true;
    }
  }

  return false;
}

function private function_d04468979de3a6dd(sceneplay, shotindex) {
  var_214d924f4e137244 = self;
  sceneroot = var_214d924f4e137244.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!isDefined(scenedata)) {
    return true;
  }

  if(!is_equal(sceneplay, var_214d924f4e137244.sceneplay)) {
    return false;
  }

  if(isDefined(var_214d924f4e137244.activeanimation)) {
    return false;
  }

  if(sceneroot.scenedata.scenescriptbundle function_4f93a0dfb8fd6a47()) {
    return false;
  }

  if(!var_214d924f4e137244.sceneobject function_938cdb6ca25882fc(shotindex)) {
    return false;
  }

  if(sceneplay.var_df5db7bd235f2729.size == 0 || shotindex == sceneplay.var_df5db7bd235f2729[sceneplay.var_df5db7bd235f2729.size - 1]) {
    return true;
  }

  deletetype = var_214d924f4e137244.sceneobject function_d5f4474a16f90132();

  if(var_214d924f4e137244.sceneobject function_c77857d663e8cfbe() == "Types_XCam" || deletetype == "DeleteAlwaysNotInvolved" || deletetype == "DeleteSpawnedNotInvolved" && !istrue(var_214d924f4e137244.existingentity)) {
    if(!var_214d924f4e137244 function_157c6db3114c1ec9(sceneplay)) {
      return true;
    }
  }

  return false;
}

function private function_7d78fe1c5576bf4c(sceneplay, shotindex, objectindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = scenedata.var_214d924f4e137244[objectindex];

  if(isDefined(sceneplay.var_43286fd46706909c) && isDefined(sceneplay.var_43286fd46706909c.var_f263562e5b98bed4[shotindex])) {
    return sceneplay.var_43286fd46706909c.var_f263562e5b98bed4[shotindex].durationsec;
  }

  deltatimesec = 0;
  cameratimesec = 0;
  cameraanimation = var_214d924f4e137244 function_6c3d100538f590b3(shotindex);

  if(isDefined(cameraanimation)) {
    shottimesec = var_214d924f4e137244 function_9c0d01ef917ee30(cameraanimation, "CameraAnimation");
  }

  animtype = var_214d924f4e137244.sceneobject function_92192185fc7c5500();
  shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

  for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
    deltatimesec += var_214d924f4e137244 function_9c0d01ef917ee30(shotanimations[animationindex], animtype);
  }

  return max(cameratimesec, deltatimesec);
}

function private function_b9b2392985736c52(var_56f4af8746a2d458) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];
  var_214d924f4e137244.active = undefined;
  var_214d924f4e137244.playbacksuccessful = 0;
  var_214d924f4e137244 notify("scene_stop");
  var_214d924f4e137244 function_bdd631983c9e6f5c();
  var_214d924f4e137244 function_9b8055c613f1bb31();
  var_214d924f4e137244 ent_flag_clear("scene_object_active");
}

function private function_c643b2c6b794481e(newstate) {
  sceneroot = self;
  assert(newstate != "<dev string:x87>");
  assert(newstate != "<dev string:x92>");

  if(isDefined(sceneroot.scenedata) && sceneroot.scenedata.state != newstate) {
    if(newstate != "NotInit") {
      sceneroot.scenedata.state = newstate;
      sceneroot function_2549c341bf1ae3e7(sceneroot.scenedata.state);
      return;
    }

    assert(sceneroot.scenedata.state == "<dev string:x9d>");

    if(isDefined(sceneroot.scenedata.var_214d924f4e137244) && isDefined(sceneroot.scenedata.scenescriptbundle)) {
      objectcount = sceneroot.scenedata.scenescriptbundle function_291cd2f1089d3a94();

      if(isDefined(objectcount)) {
        for(objectindex = 0; objectindex < objectcount; objectindex++) {
          if(objectindex < sceneroot.scenedata.var_214d924f4e137244.size) {
            sceneroot.scenedata.var_214d924f4e137244[objectindex].scenedata = undefined;
          }
        }
      }
    }

    function_680ff86fdba6e483(sceneroot.scenedata.scriptbundle);

    sceneroot function_86051e11e7b7a98e();

    sceneroot.scenedata.sceneroot = undefined;
    sceneroot.scenedata = undefined;
  }
}

function private function_2549c341bf1ae3e7(state) {
  sceneroot = self;

  if(isDefined(sceneroot.scenestatic) && isDefined(sceneroot.scenestatic.notifyobject) && isDefined(sceneroot.scenestatic.notifyevent)) {
    if(!isDefined(sceneroot.scenestatic.notifymatch) || sceneroot.scenestatic.notifymatch == state) {
      sceneroot.scenestatic.notifyobject notify(sceneroot.scenestatic.notifyevent);
    }
  }
}

function private function_6c0e3626ebce826f() {
  sceneroot = self;
  return sceneroot.script_scenescriptbundle;
}

function private scene_scriptbundle() {
  sceneroot = self;
  sceneroot function_bd09568f76dd40ca();

  if(!isDefined(sceneroot.scenedata.scriptbundle)) {
    scenescriptbundlename = sceneroot function_6c0e3626ebce826f();

    if(isDefined(scenescriptbundlename)) {
      sceneroot.scenedata.scriptbundle = function_5e9baece4185ee1e(hashcat(%"scenescriptbundle:", scenescriptbundlename));
    }
  }

  return sceneroot.scenedata.scriptbundle;
}

function private function_7855ec4caf5901f9(typename, funcname, func) {
  function_ace39e84230f386();

  if(!isDefined(level.scene.objecthandlers[typename])) {
    level.scene.objecthandlers[typename] = [];
  }

  level.scene.objecthandlers[typename][funcname] = func;
}

function private function_5a197e7b54a9091e() {
  assert(isDefined(level.scene.objecthandlers));
  assert(isDefined(level.scene.objecthandlers["<dev string:xa9>"]));
  assert(!isDefined(level.scene.var_8a6cbf5e0998e58d));
  level.scene.var_8a6cbf5e0998e58d = [];
  var_a05b670b818e941c = ["Types_Object", "Types_Prop", "Types_Actor", "Types_Player", "Types_EnemyPlayer", "Types_FakePlayer", "Types_FakeActor", "Types_Vehicle", "Types_Mayhem", "Types_XCam"];

  foreach(var_c311f4d2b460f074 in var_a05b670b818e941c) {
    level.scene.var_8a6cbf5e0998e58d[var_c311f4d2b460f074] = [];

    foreach(functype, func in level.scene.objecthandlers["Types_Object"]) {
      level.scene.var_8a6cbf5e0998e58d[var_c311f4d2b460f074][functype] = func;
    }
  }

  foreach(var_c311f4d2b460f074, functable in level.scene.objecthandlers) {
    if(var_c311f4d2b460f074 == "Types_Object") {
      continue;
    }

    foreach(functype, func in functable) {
      level.scene.var_8a6cbf5e0998e58d[var_c311f4d2b460f074][functype] = func;
    }
  }

  level.scene.objecthandlers = undefined;
}

function private function_9d3850b024ab89b1(funcname, func) {
  function_ace39e84230f386();

  if(!isDefined(level.scene.modehandlers)) {
    level.scene.modehandlers = [];
  }

  level.scene.modehandlers[funcname] = func;
}

function private function_1a2cae854fe073a0(functype) {
  typefunc = undefined;

  if(isDefined(level.scene.modehandlers)) {
    typefunc = level.scene.modehandlers[functype];
  }

  return typefunc;
}

function private function_8a786f133d7341c0(functype) {
  return self.functable[functype];
}

function private object_spawn(alignmentinfo, shotinit) {
  var_214d924f4e137244 = self;
  scenestatic = var_214d924f4e137244.sceneroot.scenestatic;
  entity = undefined;
  var_c311f4d2b460f074 = var_214d924f4e137244.sceneobject function_c77857d663e8cfbe();
  var_373a2c3b02b1d81c = var_214d924f4e137244.sceneobject function_992de34e05c5cea7();
  var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject function_12eb9fd56334261c();
  var_982109bda19f3517 = var_214d924f4e137244.sceneobject function_aeb2b46911a5811d();
  spawnorigin = alignmentinfo.origin;
  spawnangles = alignmentinfo.angles;

  if(isDefined(shotinit)) {
    shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotinit);

    if(isDefined(shotanimations) && shotanimations.size > 0 && isanimation(shotanimations[0])) {
      spawnorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, shotanimations[0]);
      spawnangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, shotanimations[0]);
    }
  }

  function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:xb9>", spawnorigin, spawnangles);

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSpawn");

  if(isDefined(typefunc) && typefunc != &object_spawn) {
    entity = var_214d924f4e137244[[typefunc]](spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    entity = var_214d924f4e137244 function_3e19c1b49e591d34(spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    if(var_c311f4d2b460f074 != "<dev string:xc2>" && var_c311f4d2b460f074 != "<dev string:xd2>") {
      println("<dev string:xe0>" + var_982109bda19f3517 + "<dev string:x109>" + var_373a2c3b02b1d81c + "<dev string:x116>" + var_6fc4d2978cf27bef + "<dev string:x4b>");
    }
  }

  if(isDefined(entity) && !isPlayer(entity) && isDefined(scenestatic) && isDefined(scenestatic.spawnfunctions)) {
    entity.var_214d924f4e137244 = var_214d924f4e137244;
    checktables = [var_982109bda19f3517, var_c311f4d2b460f074, "_object_all_"];

    foreach(tablename in checktables) {
      if(isDefined(scenestatic.spawnfunctions[tablename])) {
        foreach(spawnfunc in scenestatic.spawnfunctions[tablename]) {
          entity thread[[spawnfunc]]();
        }
      }
    }
  }

  if(isDefined(entity)) {
    switch (var_214d924f4e137244.sceneobject function_b5a77eb340ad5552()) {
      case #"hash_5a532485943b3d4b":
        entity.targetname = "_scene_global_" + var_982109bda19f3517;
        break;
      case #"hash_6d8a4db48060bf8":
        entity.script_noteworthy = "_scene_global_" + var_982109bda19f3517;
        break;
    }
  }

  return entity;
}

function private function_3e19c1b49e591d34(spawnorigin, spawnangles) {
  var_214d924f4e137244 = self;
  entity = undefined;
  var_373a2c3b02b1d81c = var_214d924f4e137244.sceneobject function_992de34e05c5cea7();
  var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject function_12eb9fd56334261c();

  if(var_373a2c3b02b1d81c == "xmodel" || var_373a2c3b02b1d81c == "xcompositemodel") {
    entity = spawn("script_model", spawnorigin);

    if(isDefined(entity)) {
      entity val::set("scene_scene", "cinematics_participant", 1);
      entity.angles = spawnangles;
      entity setModel(var_6fc4d2978cf27bef);
      animtree = var_214d924f4e137244.sceneobject function_c106523f3836b90b();

      if(isDefined(animtree)) {
        entity useanimtree(animtree);
      }

      entity scripts\common\visibility_mode::function_d5f76e611c78509a();
    }
  } else if(var_373a2c3b02b1d81c == "character") {
    character = function_1823ff50bb28148d(var_6fc4d2978cf27bef);

    if(isDefined(level.fncharacter) && isDefined(level.fncharacter[character])) {
      entity = spawn("script_model", spawnorigin);

      if(isDefined(entity)) {
        entity val::set("scene_scene", "cinematics_participant", 1);
        func = level.fncharacter[character];
        entity[[func]]();
        entity.angles = spawnangles;
        animtree = var_214d924f4e137244.sceneobject function_c106523f3836b90b();

        if(isDefined(animtree)) {
          entity useanimtree(animtree);
        }

        entity scripts\common\visibility_mode::function_d5f76e611c78509a();
      }
    }
  }

  return entity;
}

function private function_476ef6856b76fadb(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244)) {
    return;
  }

  if(isDefined(var_214d924f4e137244.sceneplay) && isDefined(var_214d924f4e137244.active)) {
    var_214d924f4e137244.sceneplay function_456603ee124b8267(var_214d924f4e137244.active, var_214d924f4e137244.index);
  }

  var_214d924f4e137244 function_bdd631983c9e6f5c();
  var_214d924f4e137244 object_cleanup(var_fa1af9d2277fd747);
  var_214d924f4e137244 ent_flag_clear("scene_object_active");
  var_214d924f4e137244.entity = undefined;
}

function private function_6acd8ab4606e2a09(sceneroot, sceneplay, entity, existing, inittype) {
  var_214d924f4e137244 = self;

  if(isDefined(entity) && isDefined(entity.var_214d924f4e137244) && !is_equal(sceneplay, entity.var_214d924f4e137244.sceneplay)) {
    if(inittype != "scene_init_prestream" && entity.var_214d924f4e137244 != var_214d924f4e137244) {
      assert(var_214d924f4e137244 != entity.var_214d924f4e137244 || !is_equal(sceneplay, entity.var_214d924f4e137244.sceneplay));
      entity.var_214d924f4e137244 function_476ef6856b76fadb(sceneroot);
    }
  }

  if(isent(var_214d924f4e137244.entity)) {
    if(var_214d924f4e137244.entity == entity) {
      return;
    }

    if(!istrue(var_214d924f4e137244.existingentity)) {
      var_214d924f4e137244 object_cleanup();
      var_214d924f4e137244 object_delete();
    }
  }

  var_214d924f4e137244.entity = entity;
  var_214d924f4e137244.existingentity = existing;
}

function private object_setup(sceneplay) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.sceneplay = sceneplay;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_982109bda19f3517 = var_214d924f4e137244.sceneobject function_aeb2b46911a5811d();
    var_43ae35d311ef0ccc = var_214d924f4e137244.sceneobject function_c106523f3836b90b();
    var_214d924f4e137244 function_729a3f3943f35748(var_982109bda19f3517, var_43ae35d311ef0ccc);

    if(!isDefined(var_214d924f4e137244.var_f143eb748d8b5556)) {
      var_214d924f4e137244.var_f143eb748d8b5556 = var_214d924f4e137244.entity.dontmelee;
    }

    var_214d924f4e137244.entity.dontmelee = 1;
    var_214d924f4e137244.entity ent_flag_set("scene_active");

    if(isPlayer(var_214d924f4e137244.entity)) {
      if(var_214d924f4e137244.scenedata.scenescriptbundle function_295cf85da8fa8653()) {
        var_214d924f4e137244.entity val::set("scene_scene", "show_hud", 0);
      }
    }
  }

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetup");

  if(isDefined(typefunc) && typefunc != &object_setup) {
    var_214d924f4e137244[[typefunc]](sceneplay);
  }

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity.var_214d924f4e137244 = var_214d924f4e137244;
  }

  var_214d924f4e137244.issetup = 1;
}

function private function_729a3f3943f35748(animname, animtree) {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.entity)) {
    return;
  }

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetAnimName");

  if(isDefined(typefunc) && typefunc != &function_729a3f3943f35748) {
    var_214d924f4e137244[[typefunc]](animname, animtree);
    return;
  }

  if(isDefined(animname)) {
    if(!isPlayer(var_214d924f4e137244.entity) && isDefined(animtree) && (!isDefined(var_214d924f4e137244.entity.animtree) || var_214d924f4e137244.entity.animtree == "")) {
      if(!isDefined(var_214d924f4e137244.animtreeprevious)) {
        var_214d924f4e137244.animtreeprevious = var_214d924f4e137244.entity.animtree;
      }

      var_214d924f4e137244.entity useanimtree(animtree);
    }

    if(!isDefined(var_214d924f4e137244.entity.animname)) {
      var_214d924f4e137244.entity.animname = animname;
    }

    return;
  }

  if(isDefined(var_214d924f4e137244.animtreeprevious)) {
    var_214d924f4e137244.entity useanimtree(var_214d924f4e137244.animtreeprevious);
  }

  var_214d924f4e137244.animtreeprevious = undefined;
}

function private function_bdfc45b799d27532(animasset) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.var_53c962747bd1f2f = undefined;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetAnimPlaying");

  if(isDefined(typefunc) && typefunc != &function_bdfc45b799d27532) {
    var_214d924f4e137244[[typefunc]](animasset);
    return;
  }

  var_214d924f4e137244.var_53c962747bd1f2f = animasset;
  var_214d924f4e137244 notify("scene_anim_playing", animasset);
}

function private function_5006f1d3bba27ce4(boolval) {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectParticipatingCinematics");

  if(isDefined(typefunc) && typefunc != &function_5006f1d3bba27ce4) {
    var_214d924f4e137244[[typefunc]](boolval);
    return;
  }

  entities = var_214d924f4e137244 function_f054a83311d7f448();

  if(isarray(entities)) {
    foreach(entity in entities) {
      if(isent(entity)) {
        if(istrue(boolval)) {
          entity val::set("scene_scene", "cinematics_participant", 1);
          continue;
        }

        entity val::reset("scene_scene", "cinematics_participant");
      }
    }
  }
}

function private function_2142970a7a74d1f2(endonevent, func, param1, param2) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 thread function_a3511922b90bf177(endonevent, func, param1, param2);
}

function private function_a3511922b90bf177(endonevent, func, param1, param2) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(var_214d924f4e137244.var_53c962747bd1f2f)) {
    entity endon("death_or_disconnect");

    if(isDefined(endonevent)) {
      if(!isarray(endonevent)) {
        endonevent = [endonevent];
      }

      foreach(endonname in endonevent) {
        entity endon(endonname);
      }
    }

    var_214d924f4e137244 waittill("scene_anim_playing");
  }

  if(isDefined(param2)) {
    entity builtin[[func]](param1, param2);
    return;
  }

  if(isDefined(param1)) {
    entity builtin[[func]](param1);
    return;
  }

  entity builtin[[func]]();
}

function private function_6a4d64bdba27cb06(animrate) {
  var_214d924f4e137244 = self;
  animrate = default_to(animrate, 1);
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetAnimRate");

  if(isDefined(typefunc) && typefunc != &function_6a4d64bdba27cb06) {
    var_214d924f4e137244[[typefunc]](animrate);
    return;
  }

  if(isDefined(var_214d924f4e137244.activeanimation) && isDefined(var_214d924f4e137244.var_41dc93404af773a3) && var_214d924f4e137244.var_41dc93404af773a3 == "DeltaAnimation") {
    entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

    if(isDefined(entity)) {
      entity setanimrate(var_214d924f4e137244.activeanimation, animrate);
    }
  }
}

function private function_380708345e16e475(animasset, timefrac) {
  var_214d924f4e137244 = self;
  timefrac = default_to(timefrac, 0);
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetAnimTime");

  if(isDefined(typefunc) && typefunc != &function_380708345e16e475) {
    var_214d924f4e137244[[typefunc]](animasset, timefrac);
    return;
  }

  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity setanimtime(animasset, timefrac);
    entity dontinterpolate();
  }
}

function private function_db16fb604c5ca71d(lerptime, velocity) {
  var_214d924f4e137244 = self;
  lerptime = default_to(lerptime, 0);
  velocity = default_to(velocity, (0, 0, 0));
  waittillframeend();
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetAnimLerp");

  if(isDefined(typefunc) && typefunc != &function_db16fb604c5ca71d) {
    var_214d924f4e137244[[typefunc]](lerptime, velocity);
    return;
  }

  entities = var_214d924f4e137244 function_f054a83311d7f448();

  foreach(entity in entities) {
    if(isanimScripted(entity)) {
      entity function_4beb9f7715504995(lerptime, velocity);
    }
  }
}

function private function_bf2f06d70b4e15ad(enabled) {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectSetProcBones");

  if(isDefined(typefunc) && typefunc != &function_bf2f06d70b4e15ad) {
    var_214d924f4e137244[[typefunc]](enabled);
    return;
  }

  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  if(isDefined(entity.animtree)) {
    proc_node = function_d2fff5ce136ca7b("proc_node", entity);

    if(isDefined(proc_node)) {
      weight = 1;

      if(!istrue(enabled)) {
        weight = 0;
      }

      if(!isDefined(var_214d924f4e137244.var_53c962747bd1f2f)) {
        var_214d924f4e137244 waittill("scene_anim_playing");
      }

      entity setanim(proc_node, weight, 0);
    }
  }
}

function private function_2294fe71a7c1d8d6(entity) {
  var_214d924f4e137244 = self;

  if(!isent(entity)) {
    return 0;
  }

  if(isspawner(entity)) {
    return 0;
  }

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectMatchEntity");

  if(isDefined(typefunc) && typefunc != &function_2294fe71a7c1d8d6) {
    return var_214d924f4e137244[[typefunc]](entity);
  }

  return entity.classname == "script_model";
}

function private function_1ba5fc9ef8e19620(sceneroot, sceneplay, var_982109bda19f3517, matchset, matchanimname, existing, inittype) {
  var_214d924f4e137244 = self;

  if(isarray(matchset)) {
    if(isDefined(var_214d924f4e137244.entity)) {
      foreach(var_f638bf84f355737e, existingent in matchset) {
        if(isent(existingent) && var_214d924f4e137244 function_2294fe71a7c1d8d6(existingent)) {
          if(existingent == var_214d924f4e137244.entity || isDefined(existingent.animname) && isDefined(var_214d924f4e137244.entity.animname) && existingent.animname == var_214d924f4e137244.entity.animname) {
            var_214d924f4e137244 function_6acd8ab4606e2a09(sceneroot, sceneplay, existingent, existing, inittype);
            matchset[var_f638bf84f355737e] = undefined;
            break;
          }
        }
      }

      return matchset;
    }

    foreach(var_f638bf84f355737e, existingent in matchset) {
      if(isent(existingent) && var_214d924f4e137244 function_2294fe71a7c1d8d6(existingent)) {
        if(!istrue(matchanimname) || isDefined(existingent.animname) && existingent.animname == var_982109bda19f3517) {
          var_214d924f4e137244 function_6acd8ab4606e2a09(sceneroot, sceneplay, existingent, existing, inittype);
          matchset[var_f638bf84f355737e] = undefined;
          break;
        }
      }
    }
  }

  return matchset;
}

function private function_53687c7001a0784b(sceneroot, sceneplay, var_982109bda19f3517, usedset, keyname, inittype) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244 function_6acd8ab4606e2a09(sceneroot, sceneplay, var_214d924f4e137244.entity, 1, inittype);
    entnum = var_214d924f4e137244.entity getentitynumber();
    usedset[entnum] = var_214d924f4e137244.entity;
    return usedset;
  }

  foundentities = getEntArray(var_982109bda19f3517, keyname);

  foreach(foundent in foundentities) {
    entnum = foundent getentitynumber();

    if(isDefined(usedset) && isDefined(usedset[entnum])) {
      continue;
    }

    if(var_214d924f4e137244 function_2294fe71a7c1d8d6(foundent)) {
      var_214d924f4e137244 function_6acd8ab4606e2a09(sceneroot, sceneplay, foundent, 1, inittype);
      usedset[entnum] = foundent;
      break;
    }
  }

  return usedset;
}

function private function_4c4c2a548b9fc7ab() {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.entity)) {
    return undefined;
  }

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectGetAnimEntity");

  if(isDefined(typefunc) && typefunc != &function_4c4c2a548b9fc7ab) {
    return var_214d924f4e137244[[typefunc]]();
  }

  return var_214d924f4e137244.entity;
}

function private function_f054a83311d7f448() {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectGetLinkEnts");

  if(isDefined(typefunc) && typefunc != &function_f054a83311d7f448) {
    return var_214d924f4e137244[[typefunc]]();
  }

  animentity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();
  return [animentity];
}

function private function_b9c245bf99df4a8() {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectGetAnimRoot");

  if(isDefined(typefunc) && typefunc != &function_b9c245bf99df4a8) {
    return var_214d924f4e137244[[typefunc]]();
  }

  entity = function_4c4c2a548b9fc7ab();

  if(isDefined(entity) && isDefined(entity.anim_getrootfunc)) {
    return [[entity.anim_getrootfunc]]();
  }

  return undefined;
}

function private object_teleport(origin, angles) {
  var_214d924f4e137244 = self;

  function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x124>", origin, angles);

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectTeleport");

  if(isDefined(typefunc) && typefunc != &object_teleport) {
    var_214d924f4e137244[[typefunc]](origin, angles);
    return;
  }

  entities = var_214d924f4e137244 function_f054a83311d7f448();

  foreach(entity in entities) {
    if(isDefined(entity)) {
      entity dontinterpolate();

      if(isDefined(origin)) {
        entity.origin = origin;
      }

      if(isDefined(angles)) {
        entity.angles = angles;
      }
    }
  }
}

function private object_velocity() {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectVelocity");

  if(isDefined(typefunc) && typefunc != &object_velocity) {
    return var_214d924f4e137244[[typefunc]]();
  }

  return (0, 0, 0);
}

function private function_1cf2b9abf05dd81d(previousentity, previoustag, newentity, newtag) {
  if(!isDefined(previousentity)) {
    return false;
  }

  if(!isDefined(newentity)) {
    return false;
  }

  if(previousentity != newentity) {
    return false;
  }

  if(!isDefined(previoustag)) {
    return false;
  }

  if(!isDefined(newtag)) {
    return false;
  }

  if(previoustag != newtag) {
    return false;
  }

  return true;
}

function private function_535e6f4c06c15b1d(sceneplay, blink, bsetup, alignmentinfo, lerptime) {
  var_214d924f4e137244 = self;

  if(istrue(blink)) {
    function_e4fc30ccdca08b9d(alignmentinfo);
  }

  linkents = var_214d924f4e137244 function_f054a83311d7f448();

  if(istrue(bsetup) && isDefined(sceneplay) && !var_214d924f4e137244 function_d82945c5509ec28e(sceneplay.shotinit)) {
    return;
  }

  foreach(entity in linkents) {
    if(!isent(entity)) {
      continue;
    }

    linkedparent = entity getlinkedparent();

    if(!isDefined(alignmentinfo) || !isent(alignmentinfo.alignent)) {
      if(isDefined(linkedparent)) {
        entity unlink();
      }

      return;
    }

    if(istrue(blink)) {
      prevorigin = entity.origin;
      prevangles = entity.angles;
      var_80cc7e738d1c353f = function_1cf2b9abf05dd81d(var_214d924f4e137244.linkedent, var_214d924f4e137244.linkedtag, alignmentinfo.alignent, alignmentinfo.aligntag);

      if(!var_80cc7e738d1c353f && alignmentinfo.alignent != entity && !entity isragdoll() && (!isDefined(linkedparent) || linkedparent != alignmentinfo.alignent || default_to(var_214d924f4e137244.linkedtag, "") != default_to(alignmentinfo.aligntag, ""))) {
        if(!isDefined(lerptime) || lerptime <= 0) {
          var_214d924f4e137244 object_teleport(alignmentinfo.origin, alignmentinfo.angles);
        }

        if(isstring(alignmentinfo.aligntag)) {
          function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x130>" + alignmentinfo.aligntag, alignmentinfo.alignent gettagorigin(alignmentinfo.aligntag), alignmentinfo.alignent gettagangles(alignmentinfo.aligntag));

          if(isPlayer(entity)) {
            entity playerlinkTo(alignmentinfo.alignent, alignmentinfo.aligntag);
          } else if(isagent(entity)) {
            entity linktomoveoffset(alignmentinfo.alignent, alignmentinfo.aligntag);
            entity playerlinkedoffsetenable();
            entity fixlinktointerpolationbug(1);
          } else {
            entity linkTo(alignmentinfo.alignent, alignmentinfo.aligntag, (0, 0, 0), (0, 0, 0));
          }

          var_214d924f4e137244.linkedtag = alignmentinfo.aligntag;
          var_214d924f4e137244.linkedent = alignmentinfo.alignent;

          if(isDefined(lerptime) && lerptime > 0) {
            var_214d924f4e137244 object_teleport(prevorigin, prevangles);
          }
        } else {
          function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x139>", entity.origin, entity.angles);

          var_214d924f4e137244.linkedtag = undefined;
          var_214d924f4e137244.linkedent = alignmentinfo.alignent;

          if(isPlayer(entity)) {
            entity playerlinkTo(alignmentinfo.alignent);
          } else if(isagent(entity)) {
            entity linktomoveoffset(alignmentinfo.alignent);
            entity playerlinkedoffsetenable();
            entity fixlinktointerpolationbug(1);
          } else {
            entity linkTo(alignmentinfo.alignent);
          }
        }
      }

      continue;
    }

    if(isDefined(linkedparent) && linkedparent == alignmentinfo.alignent) {
      function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x141>", entity.origin, entity.angles);

      entity unlink();
      var_214d924f4e137244.linkedtag = undefined;
      var_214d924f4e137244.linkedent = undefined;
    }
  }
}

function private function_9745e01cedd81c85(alignmentinfo, shotindex) {
  var_214d924f4e137244 = self;
  shotindex = default_to(shotindex, var_214d924f4e137244.sceneplay.shotinit);
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectFirstFrame");

  if(isDefined(typefunc) && typefunc != &function_9745e01cedd81c85) {
    var_214d924f4e137244[[typefunc]](alignmentinfo, shotindex);
    return;
  }

  if(!isDefined(var_214d924f4e137244.entity)) {
    return;
  }

  shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

  if(shotanimations.size != 0) {
    entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();
    animasset = shotanimations[0];

    if(isent(entity) && entity.model != "") {
      entity stopanimScripted();
      entity.origin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
      entity.angles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);
      entity setanimknob(animasset, 1, 0, 0);
      entity setanimtime(animasset, 0);
      entity dontinterpolate();

      function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x14b>" + function_3c8848a3a11b2553(getanimname(animasset)), entity.origin, entity.angles);

      function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x15b>" + function_3c8848a3a11b2553(getanimname(animasset)), alignmentinfo.origin, alignmentinfo.angles);
    }
  }
}

function private function_744a16ccecd8e4dd() {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectCanAnimate");

  if(isDefined(typefunc) && typefunc != &function_744a16ccecd8e4dd) {
    return var_214d924f4e137244[[typefunc]]();
  }

  return 1;
}

function private function_c34fc4bc3e1ecbcb(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.var_41dc93404af773a3 = animationtype;
  var_214d924f4e137244.activeanimation = animasset;
  var_214d924f4e137244 function_16714fbc8955e6c7(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype);

  if(isDefined(animationtype)) {
    var_214d924f4e137244.var_36831a04af11576f[animationtype] = notifystring;
  }

  animationtype = default_to(animationtype, "DeltaAnimation");
  animplaybacktime = 0;

  if(isent(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity notify("scene_play_anim");
  }

  var_214d924f4e137244 notify("scene_play_anim");

  if(animationtype == "DeltaAnimation") {
    if(!isent(var_214d924f4e137244.entity)) {
      n_anim_length = getanimlength(animasset);
      var_214d924f4e137244 utility::waittill_any_timeout_1(n_anim_length, "scene_anim_ended");
      var_214d924f4e137244 function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      var_214d924f4e137244 function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    anim_entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

    if(!isDefined(anim_entity) || anim_entity.model == "") {
      var_214d924f4e137244 function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      var_214d924f4e137244 function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    if(var_214d924f4e137244.sceneobject function_84eff20f9e29c7f6(shotindex)) {
      function_e4fc30ccdca08b9d(alignmentinfo);
      var_214d924f4e137244 function_9745e01cedd81c85(var_214d924f4e137244.alignmentinfo, shotindex);
      var_214d924f4e137244 function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      var_214d924f4e137244 function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    var_214d924f4e137244.entity endon("death_or_disconnect");
    anim_entity endon("death_or_disconnect");
    var_214d924f4e137244 thread object_play_anim_waittill_end(animasset, [var_214d924f4e137244.entity, anim_entity], "death_or_disconnect", animationtype, notifystring);

    debugname = function_3c8848a3a11b2553(getanimname(animasset));
    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x171>" + debugname, alignmentinfo.origin, alignmentinfo.angles);

    typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectPlayAnim");

    if(isDefined(typefunc) && typefunc != &function_c34fc4bc3e1ecbcb) {
      animplaybacktime = var_214d924f4e137244[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
    }

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x17f>" + debugname, alignmentinfo.origin, alignmentinfo.angles);
  } else if(animationtype == "CameraAnimation") {
    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x18d>" + animasset, alignmentinfo.origin, alignmentinfo.angles);

    typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectPlayAnim");

    if(isDefined(typefunc) && typefunc != &function_c34fc4bc3e1ecbcb) {
      animplaybacktime = var_214d924f4e137244[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
    }

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x19b>" + animasset, alignmentinfo.origin, alignmentinfo.angles);
  } else if(animationtype == "MayhemAnimation") {
    if(var_214d924f4e137244.sceneobject function_84eff20f9e29c7f6(shotindex)) {
      function_e4fc30ccdca08b9d(alignmentinfo);
      var_214d924f4e137244 function_9745e01cedd81c85(var_214d924f4e137244.alignmentinfo);
      var_214d924f4e137244 function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      var_214d924f4e137244 function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1a9>" + animasset, alignmentinfo.origin, alignmentinfo.angles);

    typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectPlayAnim");

    if(isDefined(typefunc) && typefunc != &function_c34fc4bc3e1ecbcb) {
      animplaybacktime = var_214d924f4e137244[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
    }

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1b9>" + animasset, alignmentinfo.origin, alignmentinfo.angles);
  }

  var_214d924f4e137244 function_bf0d14daf3e53248(animasset, animationtype, notifystring);
  var_214d924f4e137244 function_68056529c69f4097(animationtype, shotindex, animindex);
  return animplaybacktime;
}

function private object_play_anim_waittill_end(animasset, var_23a35a13a8548fe6, waitfor, animationtype, notifystring) {
  var_214d924f4e137244 = self;

  if(isDefined(animasset) && is_equal(animationtype, "DeltaAnimation")) {
    suffix = function_f28fd66285fa2c9(getanimname(animasset));
  } else {
    suffix = "";
  }

  var_214d924f4e137244 notify("object_play_anim_waittill_end" + suffix);
  var_214d924f4e137244 endon("object_play_anim_waittill_end" + suffix);
  waittill_any_ents_array(var_23a35a13a8548fe6, waitfor);

  if(isDefined(var_214d924f4e137244)) {
    var_214d924f4e137244 thread function_bf0d14daf3e53248(animasset, animationtype, notifystring);
  }
}

function private function_bf0d14daf3e53248(animasset, animationtype, notifystring) {
  var_214d924f4e137244 = self;

  if(isDefined(animasset) && is_equal(animationtype, "DeltaAnimation")) {
    suffix = function_f28fd66285fa2c9(getanimname(animasset));
  } else {
    suffix = "";
  }

  var_214d924f4e137244 notify("object_play_anim_waittill_end" + suffix);
  ended = 0;

  if(isDefined(var_214d924f4e137244.var_36831a04af11576f)) {
    foreach(var_41dc93404af773a3, activenotifystring in var_214d924f4e137244.var_36831a04af11576f) {
      if(!isDefined(animationtype) || animationtype == var_41dc93404af773a3) {
        if(!isDefined(notifystring) || notifystring == activenotifystring) {
          var_214d924f4e137244 notify(activenotifystring, "end");
          ended = 1;
        }
      }
    }
  }

  if(ended) {
    if(isDefined(animationtype)) {
      var_214d924f4e137244.var_36831a04af11576f[animationtype] = undefined;
    } else {
      var_214d924f4e137244.var_36831a04af11576f = undefined;
    }
  }

  if(!isDefined(animasset) || isDefined(var_214d924f4e137244.var_41dc93404af773a3) && var_214d924f4e137244.var_41dc93404af773a3 == animationtype && is_equal(var_214d924f4e137244.activeanimation, animasset)) {
    var_214d924f4e137244.activeanimation = undefined;
    var_214d924f4e137244.var_41dc93404af773a3 = undefined;
    var_214d924f4e137244.var_53c962747bd1f2f = undefined;
  }

  var_214d924f4e137244 notify("scene_anim_ended");
}

function private function_8e9f8e1fbe2b7ab4(notifystring, animasset) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 childthread function_924dc6425bd2b70d(notifystring);
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectWaitNotes");

  if(isDefined(typefunc) && typefunc != &function_8e9f8e1fbe2b7ab4) {
    var_214d924f4e137244[[typefunc]](notifystring, animasset);
    return;
  }

  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    var_214d924f4e137244 childthread start_notetrack_wait(entity, notifystring, undefined, undefined, animasset);
  }
}

function private function_9605363169f7b770(alignmentinfo, animasset, notifystring, var_866b3a3066122e39, var_1cbffacca2bd0d4c, animationtype) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(animationtype == "DeltaAnimation") {
    typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectSkipAnim");

    if(isDefined(typefunc) && typefunc != &function_9605363169f7b770) {
      var_214d924f4e137244[[typefunc]](alignmentinfo, animasset, var_866b3a3066122e39, var_1cbffacca2bd0d4c);
      return;
    }

    if(isDefined(entity) && entity.model != "") {
      entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset);
      entity setanimtime(animasset, var_866b3a3066122e39);

      if(!(function_8581f011ce975a6(animasset) && var_1cbffacca2bd0d4c == 1)) {
        entity setanimtime(animasset, var_1cbffacca2bd0d4c);
      }
    }
  }
}

function private function_924dc6425bd2b70d(notifystring, var_d091096ced443a73) {
  var_214d924f4e137244 = self;
  scenestatic = var_214d924f4e137244.sceneroot.scenestatic;

  if(!isDefined(scenestatic) || !isDefined(scenestatic.notifies)) {
    return;
  }

  var_c311f4d2b460f074 = var_214d924f4e137244.sceneobject function_c77857d663e8cfbe();
  var_982109bda19f3517 = var_214d924f4e137244.sceneobject function_aeb2b46911a5811d();
  notifies = [];
  checktables = [var_982109bda19f3517, var_c311f4d2b460f074, "_object_all_"];

  foreach(tablename in checktables) {
    if(isDefined(scenestatic.notifies[tablename])) {
      notifies = array_combine(notifies, scenestatic.notifies[tablename]);
    }
  }

  foreach(notifyitem in notifies) {
    if(!isDefined(var_d091096ced443a73) || var_d091096ced443a73 == notifyitem) {
      var_214d924f4e137244 thread function_c9fbe2a0f09e68b0(notifystring, notifyitem);
    }
  }
}

function private function_c9fbe2a0f09e68b0(notifystring, notifyitem) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity function_5ecd1fd13181af98(notifystring, notifyitem, var_214d924f4e137244);
  }
}

function private object_shot_death_wait(sceneplay, shotindex, var_56f4af8746a2d458) {
  var_214d924f4e137244 = self;
  sceneroot = var_214d924f4e137244.sceneroot;
  scenedata = sceneroot.scenedata;
  var_214d924f4e137244 notify("object_shot_death_wait");
  var_214d924f4e137244 endon("object_shot_death_wait");
  deathanim = var_214d924f4e137244.sceneobject function_f731c1198ec2b72f(shotindex);
  var_fe3c33d4dd6936af = var_214d924f4e137244.sceneobject function_becdf44d08cc1faf();

  if(!var_fe3c33d4dd6936af && !isDefined(deathanim)) {
    return;
  }

  sceneplay endon("scene_shot_cleanup");
  entity = var_214d924f4e137244.entity;

  if(isalive(entity)) {
    entity val::set("scene_shot", "death", 0);

    while(entity.health > 1) {
      entity waittill("damage");
    }

    if(var_fe3c33d4dd6936af) {
      sceneroot thread stop();
    }

    if(isDefined(entity) && isDefined(deathanim)) {
      animentity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

      if(isDefined(animentity)) {
        animtype = var_214d924f4e137244.sceneobject function_92192185fc7c5500();
        notifystring = var_214d924f4e137244.var_36831a04af11576f[animtype];
        var_214d924f4e137244.var_36831a04af11576f[animtype] = undefined;
        var_214d924f4e137244 function_c34fc4bc3e1ecbcb(shotindex, -1, notifystring, var_214d924f4e137244.alignmentinfo, deathanim);
      }
    }

    entity val::set("scene_shot", "death", 1);
    var_214d924f4e137244 object_kill();
  }
}

function private function_9c0d01ef917ee30(animasset, animationtype) {
  switch (animationtype) {
    case #"hash_db2a102a7b3b4349":
      return getanimlength(animasset);
    case #"hash_3c9daf4fd5203d1c":
      return function_c55e2627715b3a72(animasset);
    case #"hash_eb9c9817350b0b1e":
      break;
  }

  return 0;
}

function private function_bdd631983c9e6f5c() {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectAnimEnd");

  if(isDefined(typefunc) && typefunc != &function_bdd631983c9e6f5c) {
    var_214d924f4e137244[[typefunc]]();
  } else if(isDefined(var_214d924f4e137244.entity) && isDefined(var_214d924f4e137244.var_36831a04af11576f)) {
    foreach(message in var_214d924f4e137244.var_36831a04af11576f) {
      var_214d924f4e137244.entity notify(message, "end");
    }
  }

  var_214d924f4e137244.var_36831a04af11576f = undefined;
}

function private function_9b8055c613f1bb31() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1c9>", var_214d924f4e137244.entity.origin, var_214d924f4e137244.entity.angles);
  }

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectStopAnim");

  if(isDefined(typefunc) && typefunc != &function_9b8055c613f1bb31) {
    var_214d924f4e137244[[typefunc]]();
  } else if(isDefined(var_214d924f4e137244.entity) && isDefined(var_214d924f4e137244.var_41dc93404af773a3) && var_214d924f4e137244.var_41dc93404af773a3 == "DeltaAnimation") {
    var_214d924f4e137244.entity stopanimScripted();
  }

  var_214d924f4e137244.var_41dc93404af773a3 = undefined;
  var_214d924f4e137244.activeanimation = undefined;
  var_214d924f4e137244.var_a3ff79ae166c57aa = var_214d924f4e137244.var_53c962747bd1f2f;
  var_214d924f4e137244.var_53c962747bd1f2f = undefined;
  var_214d924f4e137244 function_bf0d14daf3e53248();
}

function private object_cleanup(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;

  if(istrue(var_214d924f4e137244.issetup)) {
    var_214d924f4e137244 function_535e6f4c06c15b1d(undefined, 0, 0, var_214d924f4e137244.alignmentinfo);
    typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectCleanup");

    if(isDefined(typefunc) && typefunc != &object_cleanup) {
      var_214d924f4e137244[[typefunc]](var_fa1af9d2277fd747);
    }

    if(isDefined(var_214d924f4e137244.entity)) {
      var_214d924f4e137244.entity val::reset_all("scene_scene");
      var_214d924f4e137244.entity ent_flag_clear("scene_active");
      var_214d924f4e137244.entity.var_214d924f4e137244 = undefined;
      var_214d924f4e137244 function_729a3f3943f35748(undefined, undefined);

      if(isDefined(var_214d924f4e137244.var_f143eb748d8b5556)) {
        var_214d924f4e137244.entity.dontmelee = var_214d924f4e137244.var_f143eb748d8b5556;
      }
    }

    var_214d924f4e137244 notify("scene_ai_stealth");

    if(!isDefined(var_fa1af9d2277fd747) && var_214d924f4e137244 function_cdec4d1452eba0d8()) {
      var_214d924f4e137244 object_delete();
    }

    var_214d924f4e137244.issetup = undefined;
  }
}

function private function_cdec4d1452eba0d8() {
  var_214d924f4e137244 = self;
  deletetype = var_214d924f4e137244.sceneobject function_d5f4474a16f90132();
  deletealways = deletetype == "DeleteAlways" || deletetype == "DeleteAlwaysNotInvolved";
  deletespawned = (deletetype == "DeleteSpawned" || deletetype == "DeleteSpawnedNotInvolved") && !istrue(var_214d924f4e137244.existingentity);

  if(deletealways || deletespawned) {
    return true;
  }

  return false;
}

function private object_kill() {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectKill");

  if(isDefined(typefunc) && typefunc != &object_kill) {
    var_214d924f4e137244[[typefunc]]();
    return;
  }

  if(isalive(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity kill();
  }
}

function private object_delete() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1d1>", var_214d924f4e137244.entity.origin, var_214d924f4e137244.entity.angles);
  }

  scripts\common\visibility_mode::function_b6e23e71bb7ad50f(var_214d924f4e137244.entity);
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectDelete");

  if(isDefined(typefunc) && typefunc != &object_delete) {
    var_214d924f4e137244[[typefunc]]();
  } else if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity delete();
  }

  var_214d924f4e137244.entity = undefined;
  var_214d924f4e137244.existingentity = undefined;
}

function private function_2f2327d535ed0bb() {
  var_214d924f4e137244 = self;

  if(istrue(var_214d924f4e137244.xcamplaying)) {
    if(isPlayer(var_214d924f4e137244.entity)) {
      var_214d924f4e137244.entity stopxcam();
    }

    var_214d924f4e137244.xcamplaying = undefined;
  }
}

function private function_b62972e8f5541b26(sceneplay, shotindex) {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectPreStream");

  if(isDefined(typefunc) && typefunc != &function_b62972e8f5541b26) {
    var_214d924f4e137244[[typefunc]](sceneplay, shotindex);
  }

  var_214d924f4e137244 function_e4fc30ccdca08b9d(var_214d924f4e137244.alignmentinfo);

  if(isDefined(var_214d924f4e137244.alignmentinfo)) {
    cameraanimation = var_214d924f4e137244 function_6c3d100538f590b3(shotindex);
    shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

    if(isPlayer(var_214d924f4e137244.entity)) {
      player = var_214d924f4e137244.entity;
      var_a9b43fd80025b224 = undefined;

      if(isDefined(cameraanimation)) {
        var_a9b43fd80025b224 = player getxcamposition(cameraanimation, 0, 0, var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles);
      } else if(isDefined(shotanimations) && shotanimations.size > 0) {
        linktag = var_214d924f4e137244 function_a89f1262c5148bdf();
        animentity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();
        offset = (0, 0, player getplayerviewheight());

        if(isDefined(animentity) && animentity.model != "") {
          startposang = animentity function_d2e8597ff01310ed(shotanimations[0], linktag, 0, var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles);

          if(isDefined(startposang)) {
            var_a9b43fd80025b224 = startposang["origin"];
            offset = rotatevector(offset, startposang["angles"]);
          }
        }

        if(!isDefined(var_a9b43fd80025b224)) {
          var_a9b43fd80025b224 = getstartorigin(var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles, shotanimations[0]);
        }

        if(!is_equal(linktag, "tag_camera")) {
          var_a9b43fd80025b224 += offset;
        }
      }

      if(isDefined(var_a9b43fd80025b224)) {
        function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1db>", var_a9b43fd80025b224, (0, 0, 0));

        playerinfo = sceneplay function_317afd3b93b0b54d(player, var_a9b43fd80025b224);
      }
    }

    if(isDefined(shotanimations) && shotanimations.size > 0) {
      entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

      if(isDefined(entity)) {
        if(var_214d924f4e137244 function_7f90ebd0aa7ad958(shotindex)) {
          objectorigin = getstartorigin(var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles, shotanimations[0]);
        } else {
          objectorigin = var_214d924f4e137244.alignmentinfo.origin;
        }

        objectinfo = spawnStruct();
        objectinfo.origin = objectorigin;
        objectinfo.entity = entity;
        sceneplay.prestream.objects[sceneplay.prestream.objects.size] = objectinfo;
      }
    }
  }
}

function private function_d4dcec93a1db6e3f(sceneplay, shotindex, var_56f4af8746a2d458) {
  var_214d924f4e137244 = self;
  sceneplay endon("scene_stop");
  var_214d924f4e137244 endon("scene_stop");

  foreach(message in var_214d924f4e137244.var_36831a04af11576f) {
    var_214d924f4e137244 endon(message);
  }

  var_214d924f4e137244 childthread object_shot_death_wait(sceneplay, shotindex, var_56f4af8746a2d458);
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectPrepare");

  if(isDefined(typefunc) && typefunc != &function_d4dcec93a1db6e3f) {
    var_214d924f4e137244[[typefunc]](sceneplay, shotindex, var_56f4af8746a2d458);
  }
}

function private function_770c0b047ce9cfc1(shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    if(var_214d924f4e137244.sceneobject function_7a553773a0af8bcd(shotindex)) {
      var_214d924f4e137244.entity val::set("scene_scene", "hide", 1);
      var_214d924f4e137244.entity val::set("scene_scene", "ignoreall", 1);
      var_214d924f4e137244.entity val::set("scene_scene", "ignoreme", 1);
    }

    if(var_214d924f4e137244.sceneobject function_8ed9853e35162b7c(shotindex)) {
      var_214d924f4e137244.entity val::reset("scene_scene", "hide");
      var_214d924f4e137244.entity show();
      var_214d924f4e137244.entity val::reset("scene_scene", "ignoreall");
      var_214d924f4e137244.entity val::reset("scene_scene", "ignoreme");
    }

    if(!var_214d924f4e137244.sceneobject function_fc9281240877df76()) {
      var_214d924f4e137244.entity val::set("scene_shot", "damage", 0);
    }

    if(isPlayer(var_214d924f4e137244.entity)) {
      tweenin = var_214d924f4e137244.sceneobject function_6cf39bfd67cda93a(shotindex);

      if(tweenin > 0) {
        viewmodelvisible = var_214d924f4e137244.sceneobject function_a8485c8c63aa2cc3(shotindex);
        stopxcam = var_214d924f4e137244.sceneobject function_4040a1e0bb19e02f(shotindex);

        function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1e9>" + var_214d924f4e137244.entity getentitynumber(), var_214d924f4e137244.entity.origin, var_214d924f4e137244.entity.angles);

        var_214d924f4e137244.entity function_bb60d8e77392c74e(0, tweenin, !istrue(viewmodelvisible), stopxcam);
      }
    }
  }

  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectSetup");

  if(isDefined(typefunc) && typefunc != &function_770c0b047ce9cfc1) {
    var_214d924f4e137244[[typefunc]](shotindex);
  }
}

function private function_d82945c5509ec28e(shotindex) {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectLinkSetup");

  if(isDefined(typefunc) && typefunc != &function_d82945c5509ec28e) {
    return var_214d924f4e137244[[typefunc]](shotindex);
  }

  return 1;
}

function private function_a477eb91dc3b38b8(shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity val::reset_all("scene_shot");

    if(isPlayer(var_214d924f4e137244.entity)) {
      tweenout = var_214d924f4e137244.sceneobject function_be64404b86d48153(shotindex);

      if(tweenout > 0) {
        viewmodelvisible = var_214d924f4e137244.sceneobject function_c5c4ac51272db146(shotindex);
        stopxcam = var_214d924f4e137244.sceneobject function_51bd4cd630963c3a(shotindex);

        function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1fd>" + var_214d924f4e137244.entity getentitynumber(), var_214d924f4e137244.entity.origin, var_214d924f4e137244.entity.angles);

        var_214d924f4e137244.entity function_bb60d8e77392c74e(1, tweenout, !istrue(viewmodelvisible), stopxcam);
      }
    }
  }

  if(isent(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity notify("scene_shot_cleanup");
  }

  var_214d924f4e137244 notify("scene_shot_cleanup");
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectCleanup");

  if(isDefined(typefunc) && typefunc != &function_a477eb91dc3b38b8) {
    var_214d924f4e137244[[typefunc]](shotindex);
  }
}

function private function_6c3d100538f590b3(shotindex) {
  var_214d924f4e137244 = self;
  sceneobject = var_214d924f4e137244.sceneobject;
  cameraanimation = sceneobject.variant_object.shots[shotindex].cameraanimation;

  if(isDefined(cameraanimation) && cameraanimation == "") {
    cameraanimation = undefined;
  }

  return cameraanimation;
}

function private function_7f90ebd0aa7ad958(shotindex) {
  var_214d924f4e137244 = self;
  sceneobject = var_214d924f4e137244.sceneobject;
  var_f403b8bef0c4a943 = sceneobject function_1d5820595bc2d310(shotindex);
  var_badc9307ea231fbe = !istrue(sceneobject.variant_object.var_adbd47886f23e1a2);
  return var_f403b8bef0c4a943 && var_badc9307ea231fbe;
}

function private function_b4d836fe99f480e(shotindex) {
  var_214d924f4e137244 = self;
  sceneobject = var_214d924f4e137244.sceneobject;
  shotobject = sceneobject.variant_object.shots[shotindex];
  var_80db383140a106e8 = istrue(shotobject.removeweapon);
  var_1dc8da8f86fd9a5b = istrue(sceneobject.variant_object.removeweapon);
  var_62df8bf2c6dd7fc6 = undefined;

  if(isPlayer(var_214d924f4e137244.entity) || !isDefined(var_214d924f4e137244.entity)) {
    var_62df8bf2c6dd7fc6 = 1;
  } else {
    entity_weapon = var_214d924f4e137244.entity.weapon;
    var_62df8bf2c6dd7fc6 = isDefined(entity_weapon) && !isnullweapon(entity_weapon);
  }

  if((var_80db383140a106e8 || var_1dc8da8f86fd9a5b) && var_62df8bf2c6dd7fc6) {
    return true;
  }

  return false;
}

function private function_5a65e42126f29a4f(shotindex, overridetype, overridevalue) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.shotoverrides = default_to(var_214d924f4e137244.shotoverrides, []);
  var_214d924f4e137244.shotoverrides[overridetype] = default_to(var_214d924f4e137244.shotoverrides[overridetype], []);
  var_214d924f4e137244.shotoverrides[overridetype][shotindex] = overridevalue;
}

function private function_a680ab1ba5753613(shotindex, overridetype) {
  var_214d924f4e137244 = self;
  assert(isint(shotindex));

  if(!isDefined(var_214d924f4e137244.shotoverrides)) {
    return undefined;
  }

  if(!isDefined(var_214d924f4e137244.shotoverrides[overridetype])) {
    return undefined;
  }

  return var_214d924f4e137244.shotoverrides[overridetype][shotindex];
}

function private function_225d78e3c485a7ae(shotindexes, sceneplay, var_56f4af8746a2d458) {
  var_214d924f4e137244 = self;
  scenedata = var_214d924f4e137244.scenedata;
  scenestatic = var_214d924f4e137244.sceneroot.scenestatic;

  if(var_214d924f4e137244.sceneobject function_cb6926d352c405c7()) {
    return 0;
  }

  if(isDefined(scenestatic) && istrue(scenestatic.excludeplayers) && var_214d924f4e137244 object_get_type() == "Types_Player") {
    return 0;
  }

  if(isDefined(scenestatic) && isDefined(scenestatic.var_8f28f8f196c70a58) && scenestatic.var_8f28f8f196c70a58 && var_214d924f4e137244 object_get_type() != "Types_Player") {
    return 0;
  }

  if(!isarray(shotindexes)) {
    shotindexes = [shotindexes];
  }

  result = 0;

  foreach(shotindex in shotindexes) {
    doeshide = var_214d924f4e137244.sceneobject function_7a553773a0af8bcd(shotindex);
    doesshow = var_214d924f4e137244.sceneobject function_8ed9853e35162b7c(shotindex);
    animated = var_214d924f4e137244.sceneobject function_938cdb6ca25882fc(shotindex);

    if(!animated || doeshide || doesshow) {
      if(isDefined(sceneplay) && isDefined(var_56f4af8746a2d458)) {
        if(!isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458])) {
          sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458] = [];
        }

        sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458][shotindex] = 1;
        result = 1;
      } else {
        return 1;
      }

      continue;
    }

    shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);
    cameraanimation = var_214d924f4e137244 function_6c3d100538f590b3(shotindex);

    if(shotanimations.size != 0 || isDefined(cameraanimation)) {
      if(isDefined(sceneplay) && isDefined(var_56f4af8746a2d458)) {
        if(!isDefined(sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458])) {
          sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458] = [];
        }

        sceneplay.var_7038c2a13f1f5db8[var_56f4af8746a2d458][shotindex] = 1;
        result = 1;
        continue;
      }

      return 1;
    }
  }

  return result;
}

function private object_get_type() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject function_c77857d663e8cfbe();
}

function private function_c77857d663e8cfbe() {
  return self.variant_type;
}

function private function_92192185fc7c5500() {
  sceneobject = self;
  animtype = "DeltaAnimation";

  if(sceneobject function_c77857d663e8cfbe() == "Types_Mayhem") {
    animtype = "MayhemAnimation";
  }

  return animtype;
}

function private function_992de34e05c5cea7() {
  sceneobject = self;

  if(isDefined(sceneobject.variant_object.aitypename)) {
    return "aitype";
  }

  if(isDefined(sceneobject.variant_object.charactername)) {
    return "character";
  }

  if(isDefined(sceneobject.variant_object.vehiclename)) {
    return "vehicle";
  }

  if(isDefined(sceneobject.variant_object.var_2d53850266558c60)) {
    return "xcompositemodel";
  }

  if(isDefined(sceneobject.variant_object.xmodelname)) {
    return "xmodel";
  }

  return "mayhem";
}

function private function_12eb9fd56334261c() {
  sceneobject = self;

  if(isDefined(sceneobject.variant_object.aitypename)) {
    return sceneobject.variant_object.aitypename;
  }

  if(isDefined(sceneobject.variant_object.charactername)) {
    return sceneobject.variant_object.charactername;
  }

  if(isDefined(sceneobject.variant_object.vehiclename)) {
    return sceneobject.variant_object.vehiclename;
  }

  if(isDefined(sceneobject.variant_object.var_2d53850266558c60)) {
    return sceneobject.variant_object.var_2d53850266558c60;
  }

  return sceneobject.variant_object.xmodelname;
}

function private function_aeb2b46911a5811d() {
  sceneobject = self;
  return sceneobject.variant_object.name;
}

function private function_83ba0b38ef7f3949() {
  sceneobject = self;
  return istrue(sceneobject.variant_object.firstframe);
}

function private function_84eff20f9e29c7f6(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return isDefined(shotobject) && istrue(shotobject.firstframeonly);
}

function private function_cb6926d352c405c7() {
  sceneobject = self;
  return istrue(sceneobject.variant_object.disabled);
}

function private function_d5f4474a16f90132() {
  sceneobject = self;
  return default_to(sceneobject.variant_object.deletetype, "None");
}

function private function_b5a77eb340ad5552() {
  sceneobject = self;
  return default_to(sceneobject.variant_object.globaltype, "None");
}

function private function_fc9281240877df76() {
  sceneobject = self;
  return istrue(sceneobject.variant_object.takedamage);
}

function private function_becdf44d08cc1faf() {
  sceneobject = self;
  return istrue(sceneobject.variant_object.var_6da5cfc338f95f28);
}

function private function_c106523f3836b90b() {
  sceneobject = self;

  if(isDefined(sceneobject.variant_object.animtree)) {
    return sceneobject.variant_object.animtree.id;
  }

  return undefined;
}

function private function_d301ab09c0738edf() {
  sceneobject = self;
  return istrue(sceneobject.variant_object.var_eb6d97710680539f);
}

function private function_79edcc9987330a2a(shotindex) {
  sceneobject = self;
  animations = [];
  objtype = sceneobject function_c77857d663e8cfbe();

  switch (objtype) {
    case #"hash_873689dd62a87ffa":
      shotanimations = sceneobject.variant_object.shots[shotindex].var_e608c28a92676233;

      if(isDefined(shotanimations)) {
        for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
          animations[animationindex] = shotanimations[animationindex].mayhemanimation;
        }
      }

      break;
    default:
      shotanimations = sceneobject.variant_object.shots[shotindex].deltaanimations;

      if(isDefined(shotanimations)) {
        for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
          animations[animationindex] = shotanimations[animationindex].deltaanimation.id;
        }
      }

      break;
  }

  return animations;
}

function private function_698798987ca7073(shotindex) {
  sceneobject = self;
  lengths = [];
  objtype = sceneobject function_c77857d663e8cfbe();

  if(shotindex < 0 || shotindex > sceneobject.variant_object.shots.size - 1) {
    return lengths;
  }

  switch (objtype) {
    case #"hash_873689dd62a87ffa":
      shotanimations = sceneobject.variant_object.shots[shotindex].var_e608c28a92676233;

      if(isDefined(shotanimations)) {
        animationcount = shotanimations.size;

        for(animationindex = 0; animationindex < animationcount; animationindex++) {
          lengths[animationindex] = 0;

          if(isDefined(shotanimations[animationindex].framecount) && isDefined(shotanimations[animationindex].framerate)) {
            lengths[animationindex] = shotanimations[animationindex].framecount * 1 / float(shotanimations[animationindex].framerate);
          }
        }
      }

      break;
    default:
      shotanimations = sceneobject.variant_object.shots[shotindex].deltaanimations;

      if(isDefined(shotanimations)) {
        animationcount = shotanimations.size;

        for(animationindex = 0; animationindex < animationcount; animationindex++) {
          lengths[animationindex] = 0;

          if(isanimation(shotanimations[animationindex].deltaanimation.id)) {
            lengths[animationindex] = getanimlength(shotanimations[animationindex].deltaanimation.id);
          }
        }
      }

      break;
  }

  return lengths;
}

function private function_f731c1198ec2b72f(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];

  if(isDefined(shotobject.deathanim)) {
    return shotobject.deathanim.id;
  }

  return undefined;
}

function private function_938cdb6ca25882fc(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return !istrue(shotobject.notanimated);
}

function private function_1d5820595bc2d310(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return !istrue(shotobject.var_adbd47886f23e1a2);
}

function private function_7a553773a0af8bcd(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return istrue(shotobject.preparehide);
}

function private function_8ed9853e35162b7c(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return istrue(shotobject.prepareshow);
}

function private function_1e3ba3c3afdbb7b4(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.float_lerptime, 0);
}

function private function_205f7afe5d801664(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.float_blendtime, 0.2);
}

function private function_167ed32773c7c534(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.blendcurve, "linear");
}

function private function_2917c4d9acc44d9(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return istrue(shotobject.lookatplayer);
}

function private function_8b6dcfac0d2921ad(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.reachtype, "Teleport");
}

function private function_ceabc6a1e0fac4cf(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.arrivaltype, "Exposed");
}

function private function_1b712c4c79096ef9(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_7db06d4a4c1afffa, "DEFAULT");
}

function private function_b56c0812b975be8(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_d223a5b14195b3ef, "DEFAULT");
}

function private function_8f11c2704d4c19c3(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.locomotionstart, "DEFAULT");
}

function private function_d1dd52dc1f43215d(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.weaponuse, "DropQuick");
}

function private function_fcc766f42b75a322(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.weaponswitch, 1);
}

function private function_892812e26790e793(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return tolower(default_to(shotobject.stancebegin, "stand"));
}

function private function_c3345343cc0eb8ab(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return tolower(default_to(shotobject.stanceend, "stand"));
}

function private function_16b4cb7e4c5af0fd(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_52c388f739467cb0, 45);
}

function private function_918dc2e0c83784b6(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_1f406d98a26a7085, 45);
}

function private function_b06da1547120edef(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_88317c7614e6553c, 15);
}

function private function_be3310ec58dd9807(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_169ec6c28c4aae8a, 15);
}

function private function_8851aea907b47f88(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_562ff78798cbfcc8, 1);
}

function private function_20e9c3d094691efe(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return istrue(shotobject.autocenter);
}

function private function_b083c5862877c8e3(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_ea65489e6dd7e725, 1);
}

function private function_c2a0ad9229a93162(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_88e69aa15889ab66, 0);
}

function private function_9be5ff9b4bc5843a(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.nospawn, 0);
}

function private function_6cf39bfd67cda93a(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.cameratweenin, 0);
}

function private function_a8485c8c63aa2cc3(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.cameratweeninvisible, 1);
}

function private function_4040a1e0bb19e02f(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_5f517de02c7ca959, 0);
}

function private function_be64404b86d48153(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.cameratweenout, 0);
}

function private function_c5c4ac51272db146(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.cameratweenoutvisible, 1);
}

function private function_51bd4cd630963c3a(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_9d3a8c6c70cf8ae4, 0);
}

function private function_f0f9db1f4b0000f4(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.xcamthirdperson, 0);
}

function private function_cef37972e99fd713(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_fdbf9e3bd86923cf, 0);
}

function private function_6acf84052cd5ab1(spawnorigin, spawnangles) {
  var_214d924f4e137244 = self;
  entity = undefined;
  var_373a2c3b02b1d81c = var_214d924f4e137244.sceneobject function_992de34e05c5cea7();
  var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject function_12eb9fd56334261c();

  if(var_373a2c3b02b1d81c == "vehicle") {
    entity = spawnVehicle(vehicle_modelname(var_6fc4d2978cf27bef), "scene_system_vehicle", var_6fc4d2978cf27bef, spawnorigin, spawnangles);

    if(isDefined(entity)) {
      entity useanimtree(var_214d924f4e137244.sceneobject function_c106523f3836b90b());
    }
  }

  return entity;
}

function private function_619f2e5d7f38d9d5(entity) {
  if(entity.classname == "script_vehicle") {
    return true;
  }

  if(entity.classname == "script_model") {
    return true;
  }

  return false;
}

function private function_dec77fd275b35e92(shotindex) {
  var_214d924f4e137244 = self;
  vehicle = var_214d924f4e137244.entity;

  if(isDefined(vehicle) && vehicle vehicle_isphysveh()) {
    vehicle vehphys_forcekeyframedmotion();
  }
}

function private function_69abf08346f3f6d9() {
  scenescriptbundle = self;
  var_bb49a14608f264e3 = scenescriptbundle function_291cd2f1089d3a94();

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < var_bb49a14608f264e3; var_56f4af8746a2d458++) {
    sceneobject = scenescriptbundle function_bfc4196d3da11705(var_56f4af8746a2d458);
    var_373a2c3b02b1d81c = sceneobject function_992de34e05c5cea7();
    var_6fc4d2978cf27bef = sceneobject function_12eb9fd56334261c();

    if(!isDefined(var_6fc4d2978cf27bef)) {
      continue;
    }

    if(var_373a2c3b02b1d81c == "aitype") {
      continue;
    }

    if(var_373a2c3b02b1d81c == "character") {
      character = function_1823ff50bb28148d(var_6fc4d2978cf27bef);

      if(isDefined(level.var_7d97144daa7995cd) && isDefined(level.var_7d97144daa7995cd[character])) {
        funcprecache = level.var_7d97144daa7995cd[character];
        level[[funcprecache]]();
      }

      continue;
    }

    if(var_373a2c3b02b1d81c == "vehicle") {
      precachevehicle(var_6fc4d2978cf27bef);
      modelname = vehicle_modelname(var_6fc4d2978cf27bef);

      if(modelname != "") {
        precachemodel(modelname);
      }

      continue;
    }

    precachemodel(var_6fc4d2978cf27bef);
  }
}

function private function_ab3ec43370c405d2(sceneroot, shotindex, objectindex) {
  scenescriptbundle = self;
  alignmentinfo = spawnStruct();
  alignmentinfo.aligntarget = undefined;
  alignmentinfo.aligntag = undefined;
  alignmentinfo.alignent = undefined;
  alignmentinfo.var_93cd726eb6096497 = undefined;
  alignmentinfo.originoffset = (0, 0, 0);
  alignmentinfo.anglesoffset = (0, 0, 0);
  alignmentinfo.shotindex = shotindex;
  shot = scenescriptbundle function_2218afa82a590ea3(shotindex);
  sceneobject = scenescriptbundle function_bfc4196d3da11705(objectindex);
  shotobject = sceneobject.variant_object.shots[shotindex];
  aligncheck = [shotobject, sceneobject.variant_object, shot.variant_object, scenescriptbundle];

  for(var_afaaf74a3ad05eae = 0; var_afaaf74a3ad05eae < aligncheck.size; var_afaaf74a3ad05eae++) {
    alignobj = aligncheck[var_afaaf74a3ad05eae];

    if(isDefined(alignobj.aligntarget)) {
      alignmentinfo.aligntarget = alignobj.aligntarget;

      if(isDefined(alignobj.aligntargettag)) {
        alignmentinfo.aligntag = tolower(alignobj.aligntargettag);
      }

      break;
    }
  }

  alignmentinfo.originoffset += function_61f8f9a912f9df9f(shotobject.var_8db9e726632f82c7, shotobject.var_8db9e626632f8094, shotobject.var_8db9e926632f872d);
  alignmentinfo.anglesoffset += function_61f8f9a912f9df9f(shotobject.var_ac0c3857c7b0c6d, shotobject.var_ac0c2857c7b0a3a, shotobject.var_ac0c1857c7b0807);
  alignmentinfo.originoffset += function_61f8f9a912f9df9f(sceneobject.variant_object.var_8db9e726632f82c7, sceneobject.variant_object.var_8db9e626632f8094, sceneobject.variant_object.var_8db9e926632f872d);
  alignmentinfo.anglesoffset += function_61f8f9a912f9df9f(sceneobject.variant_object.var_ac0c3857c7b0c6d, sceneobject.variant_object.var_ac0c2857c7b0a3a, sceneobject.variant_object.var_ac0c1857c7b0807);
  alignmentinfo.originoffset += function_61f8f9a912f9df9f(shot.variant_object.var_8db9e726632f82c7, shot.variant_object.var_8db9e626632f8094, shot.variant_object.var_8db9e926632f872d);
  alignmentinfo.anglesoffset += function_61f8f9a912f9df9f(shot.variant_object.var_ac0c3857c7b0c6d, shot.variant_object.var_ac0c2857c7b0a3a, shot.variant_object.var_ac0c1857c7b0807);
  alignmentinfo.originoffset += function_61f8f9a912f9df9f(scenescriptbundle.var_8db9e726632f82c7, scenescriptbundle.var_8db9e626632f8094, scenescriptbundle.var_8db9e926632f872d);
  alignmentinfo.anglesoffset += function_61f8f9a912f9df9f(scenescriptbundle.var_ac0c3857c7b0c6d, scenescriptbundle.var_ac0c2857c7b0a3a, scenescriptbundle.var_ac0c1857c7b0807);
  aligntarget = undefined;

  if(isDefined(alignmentinfo.aligntarget)) {
    var_aecf57ef77b2c2e6 = sceneroot get_object(alignmentinfo.aligntarget);

    if(isDefined(var_aecf57ef77b2c2e6)) {
      aligntarget = var_aecf57ef77b2c2e6 function_4c4c2a548b9fc7ab();

      if(isDefined(aligntarget)) {
        alignmentinfo.var_93cd726eb6096497 = var_aecf57ef77b2c2e6.index;
      }
    }

    if(!isDefined(aligntarget)) {
      aligntarget = function_9b40ea5276506411(alignmentinfo.aligntarget);

      if(isDefined(aligntarget) && isDefined(aligntarget.var_214d924f4e137244)) {
        alignmentinfo.var_93cd726eb6096497 = aligntarget.var_214d924f4e137244.index;
      }
    }
  }

  if(!isDefined(aligntarget)) {
    aligntarget = sceneroot;
  }

  alignmentinfo.alignent = aligntarget;
  alignmentinfo.origin = default_to(alignmentinfo.alignent.origin, (0, 0, 0));
  alignmentinfo.angles = default_to(alignmentinfo.alignent.angles, (0, 0, 0));
  return alignmentinfo;
}

function private function_2c5f030a3c002210() {
  scenescriptbundle = self;
  return istrue(scenescriptbundle.bool_skippable);
}

function private function_4f93a0dfb8fd6a47() {
  scenescriptbundle = self;
  return istrue(scenescriptbundle.bool_looping);
}

function private function_cf67ad1bae22e908() {
  scenescriptbundle = self;
  return istrue(scenescriptbundle.var_40e675414bba8ec3);
}

function private function_62cef499110730d3() {
  scenescriptbundle = self;
  return default_to(scenescriptbundle.autocleanup, 1);
}

function private function_291cd2f1089d3a94() {
  scenescriptbundle = self;
  return scenescriptbundle.objects.size;
}

function private function_bfc4196d3da11705(index) {
  scenescriptbundle = self;
  return scenescriptbundle.objects[index];
}

function private function_d1338e27a26ecaeb() {
  scenescriptbundle = self;
  return scenescriptbundle.shots.size;
}

function private function_2218afa82a590ea3(index) {
  scenescriptbundle = self;
  return scenescriptbundle.shots[index];
}

function private function_eed2bf36a4defb90(var_f8c9c619e9b781d) {
  scenescriptbundle = self;
  var_38640d9c6ebeb669 = isstring(var_f8c9c619e9b781d);
  b_isint = isint(var_f8c9c619e9b781d);

  foreach(index, shot in scenescriptbundle.shots) {
    if(!isDefined(var_f8c9c619e9b781d)) {
      return index;
    }

    if(b_isint && var_f8c9c619e9b781d == index) {
      return index;
    }

    if(var_38640d9c6ebeb669 && shot.variant_object.name == var_f8c9c619e9b781d) {
      return index;
    }
  }

  return -1;
}

function private function_a3be29c7b9c648ef(index) {
  scenescriptbundle = self;
  return scenescriptbundle.shots[index] function_55042076624e1180();
}

function private function_e65f46a710591a5() {
  scenescriptbundle = self;
  return istrue(scenescriptbundle.autostream);
}

function private function_ee55ab255c0be00d() {
  scenescriptbundle = self;
  return default_to(scenescriptbundle.var_b9717bd2a5317a1c, "AnimScripted");
}

function private function_924e47d1f90e6366(shotname) {
  scenescriptbundle = self;
  var_406b6072ae54dcd1 = undefined;
  shotcount = scenescriptbundle function_d1338e27a26ecaeb();

  for(shotindex = 0; shotindex < shotcount; shotindex++) {
    shot = scenescriptbundle function_2218afa82a590ea3(shotindex);

    if(shot function_55042076624e1180() == shotname) {
      var_406b6072ae54dcd1 = shotindex;
      break;
    }
  }

  return var_406b6072ae54dcd1;
}

function private function_295cf85da8fa8653() {
  scenescriptbundle = self;
  return istrue(scenescriptbundle.disablehud);
}

function private function_55042076624e1180() {
  shot = self;

  if(!isDefined(shot)) {
    return undefined;
  }

  return shot.variant_object.name;
}

function private function_d218620a1b80e648() {
  shot = self;
  return istrue(shot.variant_object.disableshot);
}

function private function_dd4368cda4b91e7d() {
  shot = self;
  return istrue(shot.variant_object.autostream);
}

function private function_9336a9805a4ab29a() {
  shot = self;

  if(getdvarint(@ "hash_b279d32f047f16db", 0)) {
    return true;
  }

  return istrue(shot.variant_object.syncend);
}

function private function_f09a700ae2edf8dc(alignmentinfo, shotinit) {}

function private function_d4f1b2dce50c7b7(shotindex) {
  var_214d924f4e137244 = self;

  if(var_214d924f4e137244.sceneobject function_7a553773a0af8bcd(shotindex)) {
    if(!isDefined(var_214d924f4e137244.var_251898eb5a0e0c9f)) {
      var_214d924f4e137244 function_532562ce2e63032f(var_214d924f4e137244.alignmentinfo);
    }

    if(isDefined(var_214d924f4e137244.var_251898eb5a0e0c9f)) {
      hidemayhem(var_214d924f4e137244.var_251898eb5a0e0c9f);
    }
  }

  if(var_214d924f4e137244.sceneobject function_8ed9853e35162b7c(shotindex)) {
    if(!isDefined(var_214d924f4e137244.var_251898eb5a0e0c9f)) {
      var_214d924f4e137244 function_532562ce2e63032f(var_214d924f4e137244.alignmentinfo);
    }

    if(isDefined(var_214d924f4e137244.var_251898eb5a0e0c9f)) {
      showmayhem(var_214d924f4e137244.var_251898eb5a0e0c9f);
    }
  }
}

function private function_532562ce2e63032f(alignmentinfo, shotindex) {
  var_214d924f4e137244 = self;
  shotindex = default_to(shotindex, var_214d924f4e137244.sceneplay.shotinit);
  shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

  if(shotanimations.size != 0) {
    var_214d924f4e137244 thread function_d0ffa1bea912444d(var_214d924f4e137244.sceneplay.shotinit, shotindex, "mayhem", alignmentinfo, shotanimations[0], 0, 0, 0, 0, "MayhemAnimation");
    pausemayhem(var_214d924f4e137244.var_251898eb5a0e0c9f);
  }
}

function private function_d0ffa1bea912444d(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 function_e045fde582740c36();

  if(!isDefined(level.scene.var_629ea32e5d4a2c40)) {
    level.scene.var_629ea32e5d4a2c40 = 0;
  }

  level.scene.var_629ea32e5d4a2c40++;
  var_214d924f4e137244.var_251898eb5a0e0c9f = var_214d924f4e137244.sceneroot.script_scenescriptbundle + "_mayhem" + level.scene.var_629ea32e5d4a2c40;
  function_e4fc30ccdca08b9d(alignmentinfo);
  animlengths = var_214d924f4e137244.sceneobject function_698798987ca7073(shotindex);

  if(animlengths.size == 0) {
    return;
  }

  spawnmayhem(var_214d924f4e137244.var_251898eb5a0e0c9f, animasset, alignmentinfo.origin, alignmentinfo.angles);
  waittill_match_or_timeout(notifystring, "end", animlengths[animindex]);
}

function private function_94d19635a2c1b723() {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 function_e045fde582740c36();
}

function private function_e045fde582740c36() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.var_251898eb5a0e0c9f)) {
    killmayhem(var_214d924f4e137244.var_251898eb5a0e0c9f);
    var_214d924f4e137244.var_251898eb5a0e0c9f = undefined;
  }
}

function private xcam_spawn(alignmentinfo, shotinit) {}

function private function_371c152f2c391c55(shotindex) {
  var_214d924f4e137244 = self;
  scenescriptbundle = var_214d924f4e137244.sceneroot scene_scriptbundle();
  letterbox = scenescriptbundle function_cf67ad1bae22e908();

  if(letterbox) {
    foreach(player in level.players) {
      player function_e7257014ebaeeaa8(1);
    }
  }

  tweenin = var_214d924f4e137244.sceneobject function_6cf39bfd67cda93a(shotindex);

  if(tweenin > 0) {
    foreach(player in level.players) {
      player val::set("scene_scene" + "_xcam", "cinematic_motion", 0);

      if(var_214d924f4e137244 function_b4d836fe99f480e(shotindex)) {
        player val::set("scene_scene" + "_xcam", "take_weapons", 1);
      }

      stopxcam = var_214d924f4e137244.sceneobject function_4040a1e0bb19e02f(shotindex);

      function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1e9>" + player getentitynumber(), player.origin, player.angles);

      player function_bb60d8e77392c74e(0, tweenin, 1, stopxcam);
    }
  }
}

function private function_2db9cd1521705174(shotindex) {
  var_214d924f4e137244 = self;
  tweenout = var_214d924f4e137244.sceneobject function_be64404b86d48153(shotindex);

  if(tweenout > 0) {
    foreach(player in level.players) {
      player val::reset_all("scene_scene" + "_xcam");
      stopxcam = var_214d924f4e137244.sceneobject function_51bd4cd630963c3a(shotindex);

      function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1fd>" + player getentitynumber(), player.origin, player.angles);

      player function_bb60d8e77392c74e(1, tweenout, 1, stopxcam);
    }
  }
}

function private function_d6ce74b74dc12311(alignmentinfo, shotindex) {}

function private function_90e78898cf74b132(sceneplay, shotindex) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 function_e4fc30ccdca08b9d(var_214d924f4e137244.alignmentinfo);

  if(isDefined(var_214d924f4e137244.alignmentinfo)) {
    cameraanimation = var_214d924f4e137244 function_6c3d100538f590b3(shotindex);

    if(isDefined(cameraanimation)) {
      foreach(player in level.players) {
        var_a9b43fd80025b224 = player getxcamposition(cameraanimation, 0, 0, var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles);

        if(isDefined(var_a9b43fd80025b224)) {
          function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x1db>", var_a9b43fd80025b224, (0, 0, 0));

          sceneplay function_317afd3b93b0b54d(player, var_a9b43fd80025b224);
        }
      }
    }
  }
}

function private function_7ce890b54a48b767(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 xcam_delete();

  if(level.players.size == 0) {
    return 0;
  }

  function_e4fc30ccdca08b9d(alignmentinfo);
  var_214d924f4e137244 endon("scene_stop");
  var_214d924f4e137244 endon("scene_play_anim");
  var_214d924f4e137244.xcamplaying = 1;

  foreach(player in level.players) {
    var_214d924f4e137244 childthread function_bae0f68830d519ad("scene_shot_xcam", player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex);
  }

  waittime = function_c55e2627715b3a72(animasset, var_866b3a3066122e39);

  if(getxcamlooping(animasset)) {
    var_214d924f4e137244 waittillmatch(notifystring, "end");
  } else if(waittime > 0) {
    var_214d924f4e137244 waittill_match_or_timeout(notifystring, "end", waittime);
  }

  foreach(player in level.players) {
    player val::reset_all("scene_shot_xcam");
  }

  return waittime;
}

function private function_bae0f68830d519ad(valgroup, player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex) {
  var_214d924f4e137244 = self;
  assert(isPlayer(player));
  player endon("death_or_disconnect");

  function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x212>" + shotindex, alignmentinfo.origin, alignmentinfo.angles);

  waittime = 0;
  player val::set(valgroup, "cg_drawcrosshair", 0);
  player val::set(valgroup, "freezecontrols", 1);

  if(animasset != "") {
    starttime = 0;

    if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
      starttime = getxcamlength(animasset) * var_866b3a3066122e39;
    }

    var_be9e9d8d5ea874f9 = !var_214d924f4e137244.sceneobject function_cef37972e99fd713(shotindex);
    var_a9eb89bfa3d96107 = function_9f853ecc68f5058();
    thirdpersonplayer = var_214d924f4e137244.sceneobject function_f0f9db1f4b0000f4(shotindex);
    player notify("scene_play_xcam");

    if(isent(alignmentinfo.alignent) && isDefined(alignmentinfo.aligntag) && alignmentinfo.aligntag != "") {
      player function_cebd47970f60e9b(animasset, 0, alignmentinfo.alignent, alignmentinfo.aligntag, starttime, 1, var_be9e9d8d5ea874f9, var_a9eb89bfa3d96107, thirdpersonplayer);
    } else {
      player playxcam(animasset, 0, alignmentinfo.origin, alignmentinfo.angles, starttime, 1, var_be9e9d8d5ea874f9, var_a9eb89bfa3d96107, thirdpersonplayer);
    }

    if(getxcamlooping(animasset)) {
      var_214d924f4e137244 waittillmatch(notifystring, "end");
    } else {
      waittime = function_c55e2627715b3a72(animasset, var_866b3a3066122e39);

      if(waittime > 0) {
        var_214d924f4e137244 waittill_match_or_timeout(notifystring, "end", waittime);
      }
    }

    player notify("scene_play_xcam_done");
  }

  return waittime;
}

function private function_c55e2627715b3a72(animasset, var_866b3a3066122e39) {
  var_43869b27e8e72c31 = getxcamlength(animasset);
  starttime = 0;

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
    starttime = var_43869b27e8e72c31 * var_866b3a3066122e39;
    var_43869b27e8e72c31 -= starttime;
  }

  return var_43869b27e8e72c31;
}

function private function_fe644d526883b9b4(alignmentinfo, animasset, notifystring, var_866b3a3066122e39, var_1cbffacca2bd0d4c, animationtype) {}

function private function_544bbcb14d370c45() {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 xcam_delete();
}

function private xcam_delete() {
  var_214d924f4e137244 = self;
  scenescriptbundle = var_214d924f4e137244.sceneroot scene_scriptbundle();
  letterbox = scenescriptbundle function_cf67ad1bae22e908();

  foreach(player in level.players) {
    player stopxcam();
    player val::reset_all("scene_shot_xcam");

    if(letterbox) {
      player function_e7257014ebaeeaa8(0);
    }
  }

  var_214d924f4e137244.xcamplaying = undefined;
}

function private function_a9acafbfcda23112(entity) {
  return false;
}

function private xcam_cleanup(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 xcam_delete();
}

function private function_1069a83dc140e900(boolval) {
  foreach(player in level.players) {
    if(!isent(player)) {
      continue;
    }

    if(istrue(boolval)) {
      player val::set("scene_scene", "cinematics_participant", 1);
      continue;
    }

    player val::reset("scene_scene", "cinematics_participant");
  }
}

function private function_61f8f9a912f9df9f(paramx, paramy, paramz) {
  if(!isDefined(paramx)) {
    paramx = 0;
  }

  if(!isDefined(paramy)) {
    paramy = 0;
  }

  if(!isDefined(paramz)) {
    paramz = 0;
  }

  return (paramx, paramy, paramz);
}

function private function_e4fc30ccdca08b9d(alignmentinfo) {
  alignmentinfo.origin = (0, 0, 0);
  alignmentinfo.angles = (0, 0, 0);

  if(isent(alignmentinfo.alignent) && isDefined(alignmentinfo.aligntag)) {
    alignmentinfo.origin = alignmentinfo.alignent gettagorigin(alignmentinfo.aligntag, 1, 0, 0);

    if(!isDefined(alignmentinfo.origin)) {
      alignmentinfo.origin = (0, 0, 0);
    }

    alignmentinfo.angles = alignmentinfo.alignent gettagangles(alignmentinfo.aligntag, 1, 0, 0);

    if(!isDefined(alignmentinfo.angles)) {
      alignmentinfo.angles = (0, 0, 0);
    }
  } else {
    if(isDefined(alignmentinfo.alignent.origin)) {
      alignmentinfo.origin = alignmentinfo.alignent.origin;
    }

    if(isDefined(alignmentinfo.alignent.angles)) {
      alignmentinfo.angles = alignmentinfo.alignent.angles;
    }
  }

  alignmentinfo.origin += rotatevector(alignmentinfo.originoffset, alignmentinfo.angles);
  alignmentinfo.angles = combineangles(alignmentinfo.angles, alignmentinfo.anglesoffset);
}

function private function_5ecd1fd13181af98(notifystring, notifyitem, var_214d924f4e137244) {
  entity = self;

  if(!isent(self)) {
    return;
  }

  if(!isDefined(notifystring) || !isDefined(notifyitem.notifyobject)) {
    return;
  }

  if(!istrue(notifyitem.notifyrepeat) && istrue(notifyitem.notifytriggered)) {
    return;
  }

  note = tolower(notifyitem.notifynote);
  singletonnotify = "ewnr_" + self getentitynumber() + "_" + notifystring + "_" + note + "_" + (istrue(notifyitem.notifyrepeat) ? "_r" : "");
  notifyitem.notifyobject notify(singletonnotify);
  notifyitem.notifyobject endon(singletonnotify);
  waittillframeend();

  if(notifyitem.notifynote != "end") {
    entity thread function_b66a5adba2137274(notifystring, "end", "entity_wait_note_abort");
    entity endon("entity_wait_note_abort");
  }

  while(true) {
    entity waittillmatch(notifystring, note);

    if(isDefined(notifyitem.notifyobject)) {
      if(istrue(notifyitem.notifyrepeat) || !istrue(notifyitem.notifytriggered)) {
        notifyitem.notifyobject notify(notifyitem.notifynote);
        notifyitem.notifytriggered = 1;
      }

      if(!istrue(notifyitem.notifyrepeat) || notifyitem.notifynote == "end") {
        return;
      }
    }
  }
}

function private function_b66a5adba2137274(notifystring, match, notifyresult) {
  entity = self;
  entity waittillmatch(notifystring, match);

  if(isDefined(entity)) {
    entity notify(notifyresult);
  }
}

function private function_bea88b25e17cea66(sceneplay, shotindex, objectindex) {
  var_214d924f4e137244 = self;
  sceneroot = sceneplay.sceneroot;

  if(isDefined(var_214d924f4e137244.entity)) {
    aientity = var_214d924f4e137244.entity;
    var_7db06d4a4c1afffa = var_214d924f4e137244.sceneobject function_1b712c4c79096ef9(shotindex);
    locomotionstart = var_214d924f4e137244.sceneobject function_8f11c2704d4c19c3(shotindex);

    if(var_7db06d4a4c1afffa != "DEFAULT") {
      aientity val::set("scene_shot", "demeanor", var_7db06d4a4c1afffa);
    }

    if(var_214d924f4e137244 function_b4d836fe99f480e(shotindex)) {
      aientity val::set("scene_shot", "take_weapons", 1);
    }

    if(isDefined(var_214d924f4e137244.scenedata.var_43286fd46706909c)) {
      return;
    }

    reachtype = var_214d924f4e137244.sceneobject function_8b6dcfac0d2921ad(shotindex);

    if(reachtype != "Teleport" && istrue(var_214d924f4e137244.existingentity)) {
      scenedata = sceneroot.scenedata;
      animasset = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex)[0];

      if(isDefined(animasset)) {
        function_e4fc30ccdca08b9d(var_214d924f4e137244.alignmentinfo);
        animstartorigin = getstartorigin(var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles, animasset);

        if(distancesquared(aientity.origin, animstartorigin) > squared(16)) {
          typefunc = var_214d924f4e137244 function_8a786f133d7341c0("shotObjectStopAnim");

          if(isDefined(typefunc) && typefunc != &function_9b8055c613f1bb31) {
            var_214d924f4e137244[[typefunc]]();
          }

          var_4bc185af207d5706 = reach_speed(var_7db06d4a4c1afffa, locomotionstart);
          arrivaltype = undefined;

          if(reachtype == "ReachArrive") {
            arrivaltype = function_796087cbcf3fb30(var_214d924f4e137244.sceneobject function_ceabc6a1e0fac4cf(shotindex));
          }

          function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x21b>", var_214d924f4e137244.alignmentinfo.origin, var_214d924f4e137244.alignmentinfo.angles);

          sceneroot childthread scene_coordinated_reach(sceneplay, shotindex, var_4bc185af207d5706, [aientity, animasset, var_214d924f4e137244.alignmentinfo, arrivaltype]);
          aientity waittill_any_2("scene_coordinated_reach", "death_or_disconnect");
        }
      }
    }
  }
}

function private function_89c29980d9b0ebe() {
  var_214d924f4e137244 = self;
  assert(isai(var_214d924f4e137244.entity));
  var_214d924f4e137244.entity endon("death_or_disconnect");
  var_214d924f4e137244 endon("scene_ai_stealth");

  while(true) {
    lookatplayer = var_214d924f4e137244.entity function_47dbe773d9a4572f(0.25);

    if(isDefined(lookatplayer) && (!isDefined(var_214d924f4e137244.var_63dd238417ee222c) || var_214d924f4e137244.var_63dd238417ee222c != lookatplayer)) {
      var_214d924f4e137244.var_63dd238417ee222c = lookatplayer;
      var_214d924f4e137244.entity scripts\common\ai_lookat::enablelookatentity(var_214d924f4e137244.var_63dd238417ee222c);
    } else if(isDefined(var_214d924f4e137244.var_63dd238417ee222c)) {
      var_214d924f4e137244.entity scripts\common\ai_lookat::disablelookatentity(var_214d924f4e137244.var_63dd238417ee222c);
      var_214d924f4e137244.var_63dd238417ee222c = undefined;
    }

    waitframe();
  }
}

function private function_81f89576d8f466b4() {
  var_214d924f4e137244 = self;
  assert(isai(var_214d924f4e137244.entity));
  var_214d924f4e137244.entity endon("death_or_disconnect");
  var_214d924f4e137244 endon("scene_ai_stealth");

  while(true) {
    var_214d924f4e137244.entity waittill("ai_events", events);

    foreach(event in events) {
      var_214d924f4e137244 function_bdd631983c9e6f5c();
      var_214d924f4e137244 function_9b8055c613f1bb31();
      var_214d924f4e137244 thread object_cleanup();
    }
  }
}

function private function_9b40ea5276506411(searchname, ignorespawners) {
  if(!isDefined(ignorespawners)) {
    ignorespawners = 1;
  }

  aligntargets = utility::function_a5079b5837467402(searchname, "targetname", ignorespawners);

  if(!isDefined(aligntargets) || aligntargets.size == 0) {
    aligntarget = utility::function_a5079b5837467402(searchname, "script_noteworthy", ignorespawners);
  }

  if(!isDefined(aligntargets) || aligntargets.size == 0) {
    aligntarget = utility::function_a5079b5837467402("_scene_global_" + searchname, "targetname", ignorespawners);
  }

  if(!isDefined(aligntargets) || aligntargets.size == 0) {
    aligntarget = utility::function_a5079b5837467402("_scene_global_" + searchname, "script_noteworthy", ignorespawners);
  }

  if(aligntargets.size > 1) {}

  return aligntargets[0];
}

function private function_16714fbc8955e6c7(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectStoreAnimRequest");

  if(isDefined(typefunc)) {
    var_214d924f4e137244[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype);
  }
}

function private function_68056529c69f4097(animationtype, shotindex, animindex) {
  var_214d924f4e137244 = self;
  typefunc = var_214d924f4e137244 function_8a786f133d7341c0("objectClearAnimRequest");

  if(isDefined(typefunc)) {
    var_214d924f4e137244[[typefunc]](animationtype, shotindex, animindex);
  }
}