/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\scene_internal.gsc
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
    function_7855ec4caf5901f9("Types_Object", "shotObjectPlayAnim", &object_play_anim);
    function_7855ec4caf5901f9("Types_Object", "objectWaitNotes", &function_8e9f8e1fbe2b7ab4);
    function_7855ec4caf5901f9("Types_Object", "shotObjectStopAnim", &function_9b8055c613f1bb31);
    function_7855ec4caf5901f9("Types_Object", "shotObjectCleanup", &function_a477eb91dc3b38b8);
    function_7855ec4caf5901f9("Types_Object", "objectCleanup", &object_cleanup);
    function_7855ec4caf5901f9("Types_Object", "objectDelete", &object_delete);
    function_7855ec4caf5901f9("Types_Object", "objectKill", &object_kill);
    function_7855ec4caf5901f9("Types_Vehicle", "objectSpawn", &function_6acf84052cd5ab1);
    function_7855ec4caf5901f9("Types_Vehicle", "shotObjectSetup", &function_dec77fd275b35e92);
    function_7855ec4caf5901f9("Types_Vehicle", "objectMatchEntity", &function_619f2e5d7f38d9d5);
    function_7855ec4caf5901f9("Types_Mayhem", "objectSpawn", &mayhem_spawn);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectSetup", &function_d4f1b2dce50c7b7);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectFirstFrame", &function_532562ce2e63032f);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectPlayAnim", &function_d0ffa1bea912444d);
    function_7855ec4caf5901f9("Types_Mayhem", "shotObjectStopAnim", &function_94d19635a2c1b723);
    function_7855ec4caf5901f9("Types_Mayhem", "objectDelete", &mayhem_delete);
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
  scenedata.sceneobjectdata = [];

  if(!isDefined(scenedata.scenescriptbundle)) {
    scriptbundlename = sceneroot function_6c0e3626ebce826f();

    if(isDefined(scriptbundlename)) {
      println("<dev string:x1c>" + sceneroot function_6c0e3626ebce826f() + "<dev string:x48>");
    }

    return false;
  }

  objectcount = scenedata.scenescriptbundle function_291cd2f1089d3a94();

  for(objectindex = 0; objectindex < objectcount; objectindex++) {
    objectdata = spawnStruct();
    scenedata.sceneobjectdata[objectindex] = objectdata;
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
    objectdata.activeanimationtype = undefined;
    objectdata.activeanimation = undefined;
    objectdata.activeanimationplaying = undefined;
    objectdata.var_a3ff79ae166c57aa = undefined;
    objectdata.playbacksuccessful = undefined;
    objectdata.alignmentinfo = undefined;
    objectdata.issetup = undefined;
    objectdata.linkedtag = undefined;
    objectdata.xcamplaying = undefined;
    objectdata.alignmentinfo = undefined;
    objectdata.mayhemname = undefined;
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
    for(sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size; sceneobjectindex++) {
      sceneobjectdata = sceneroot.scenedata.sceneobjectdata[sceneobjectindex];

      if(isDefined(sceneobjectdata) && isDefined(sceneobjectdata.entity)) {
        sceneobjectdata object_cleanup();
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

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
    sceneobjectdata function_6a4d64bdba27cb06(animrate);
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

        for(checkshotindex = 0; checkshotindex < shotcount; checkshotindex++) {
          shot = scenescriptbundle function_2218afa82a590ea3(checkshotindex);
          shotname = shot function_55042076624e1180();

          if(shotname == shotindex) {
            shotindexes[i] = checkshotindex;
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

  result = getxhash("SSK");

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
  sceneplay.shotindicesindex = undefined;

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

function private scene_coordinated_reach(sceneplay, shotindex, speed_baseline, guy_anim) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  sceneplay notify("scene_coordinated_reach");
  sceneplay endon("scene_coordinated_reach");

  if(isDefined(sceneplay.currentshotreachspeed)) {
    sceneplay.currentshotreachspeed = min(sceneplay.currentshotreachspeed, speed_baseline);
  } else {
    sceneplay.currentshotreachspeed = speed_baseline;
  }

  if(!isDefined(sceneplay.var_6909d1a5df21c351)) {
    sceneplay.var_6909d1a5df21c351 = [];
  }

  sceneplay.var_6909d1a5df21c351[sceneplay.var_6909d1a5df21c351.size] = guy_anim;
  waittillframeend();
  sceneroot function_dca1a3a29d2ee467(sceneplay.var_6909d1a5df21c351, sceneplay.currentshotreachspeed);

  foreach(guy_anim in sceneplay.var_6909d1a5df21c351) {
    guy = guy_anim[0];

    if(isDefined(guy)) {
      guy notify("scene_coordinated_reach");
    }
  }

  sceneplay.var_6909d1a5df21c351 = undefined;
  sceneplay.currentshotreachspeed = undefined;
}

function private function_796087cbcf3fb30(arrivaltypegdt) {
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

  if(!isDefined(level.var_3d4e5fba17201307[arrivaltypegdt])) {
    println("<dev string:x4a>" + arrivaltypegdt);
    return "Exposed";
  }

  return level.var_3d4e5fba17201307[arrivaltypegdt];
}

function private reach_speed(demeanor, locomotion) {
  speed_baseline = 225;

  switch (demeanor) {
    case #"hash_186d745a92c317d9":
      speed_baseline = 53;
      break;
    case #"hash_9128327eb51e0b7b":
      speed_baseline = 48;
      break;
    case #"hash_46fdaf04e9be63e4":
      speed_baseline = 75;
      break;
    case #"hash_d320ccf96c495f71":
      speed_baseline = 47;
      break;
    case #"hash_1a53266c17b7d481":
    case #"hash_9a93c307fd4015ae":
    case #"hash_9e02cd4a0f3ca981":
    case #"hash_a7db48ba68421306":
      if(locomotion == "sprint") {
        speed_baseline = 225;
      } else {
        speed_baseline = 140;
      }

      break;
    case #"hash_eb06fed69a41dab5":
      speed_baseline = 225;
      break;
  }

  if(demeanor != "patrol" && demeanor != "alert") {
    switch (locomotion) {
      case #"hash_bdea5e7441323370":
        speed_baseline *= 0.5;
        break;
      case #"hash_5c7fca6c3a403003":
        speed_baseline *= 0.75;
        break;
    }
  }

  return speed_baseline;
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
  sceneobjectdata = self;
  return default_to(sceneobjectdata.sceneobject.variant_object.playerlinktag, "tag_player");
}

function private function_b6130df53fbf724c() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.allowusability);
}

function private function_3e13497ed7044cbd() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.isfemale);
}

function private function_ac04e049ff623301(entity, sceneobjectdata) {
  if(!isDefined(entity)) {
    return 0;
  }

  if(istrue(sceneobjectdata.scenedata.var_a416d1b334ed6b37)) {
    typefunc = function_1a2cae854fe073a0("modePlayerMatchingObjectForFemale");

    if(isDefined(typefunc)) {
      return [[typefunc]](entity, sceneobjectdata);
    }
  }

  return 1;
}

function private function_5fe020a6db35fab3(shotindex) {
  sceneobjectdata = self;
  var_409dc6bbf1421f94 = ["offhand_weapons", "melee", "sprint", "allow_jump", "mantle"];

  if(!sceneobjectdata function_b6130df53fbf724c()) {
    var_409dc6bbf1421f94[var_409dc6bbf1421f94.size] = "usability";
  }

  if(sceneobjectdata.sceneobject function_d1dd52dc1f43215d(shotindex) != "Keep") {
    var_409dc6bbf1421f94[var_409dc6bbf1421f94.size] = "weapon";
  }

  if(!sceneobjectdata.sceneobject function_fcc766f42b75a322(shotindex)) {
    var_409dc6bbf1421f94[var_409dc6bbf1421f94.size] = "weapon_switch";
  }

  return var_409dc6bbf1421f94;
}

function private function_285bdba488858f9e(shotindex) {
  sceneobjectdata = self;
  shotobject = sceneobjectdata.sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.playernoteleport, 0);
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

  foreach(sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
      sceneobjectdata.alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, shotindex, sceneobjectindex);
    }
  }

  sceneplay.objectorder = [];

  foreach(sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    addorder = [];

    for(var_bf53103eaf0d32f9 = sceneobjectindex; isDefined(var_bf53103eaf0d32f9) && isDefined(scenedata.sceneobjectdata[var_bf53103eaf0d32f9]) && !isDefined(sceneplay.objectorder[var_bf53103eaf0d32f9]); var_bf53103eaf0d32f9 = undefined) {
      addorder[addorder.size] = var_bf53103eaf0d32f9;

      if(!isDefined(scenedata.sceneobjectdata[var_bf53103eaf0d32f9].alignmentinfo)) {
        scenedata.sceneobjectdata[var_bf53103eaf0d32f9].alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, shotindex, sceneobjectindex);
      }

      nextindex = scenedata.sceneobjectdata[var_bf53103eaf0d32f9].alignmentinfo.alignobjectindex;

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

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(isDefined(sceneobjectdata)) {
      sceneobjectdata.var_bb2bc0aa7d81de89 = undefined;
    }
  }

  foreach(sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
      nextshotindex = sceneplay.nextshot;

      if(isDefined(nextshotindex)) {
        if(isDefined(var_19a1a40cf0ff83b9[nextshotindex])) {
          sceneobjectdata.var_bb2bc0aa7d81de89 = scenedata.scenescriptbundle function_ab3ec43370c405d2(sceneroot, nextshotindex, sceneobjectindex);
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

  foreach(var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
    sceneobjectdata.sceneplay = sceneplay;
    sceneobjectdata notify("scene_play");
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

  foreach(var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(isPlayer(sceneobjectdata.entity)) {
      sceneobjectdata.entity thread player_scene_play_wait_skip(sceneplay);
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

  foreach(var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
    entities = sceneobjectdata function_f054a83311d7f448();

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

function private function_5a438716f043fddc(fromtimefrac, var_df5db7bd235f2729) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  sceneplay.var_43286fd46706909c = undefined;

  if(!isDefined(fromtimefrac) || isDefined(fromtimefrac) && fromtimefrac == 0) {
    return;
  }

  var_43286fd46706909c = spawnStruct();
  var_43286fd46706909c.fromtimefrac = clamp(fromtimefrac, 0, 1);
  var_43286fd46706909c.totaltimesec = 0;
  var_43286fd46706909c.shottimeinfo = [];
  sceneplay.var_43286fd46706909c = var_43286fd46706909c;

  foreach(shotindex in var_df5db7bd235f2729) {
    shottimeinfo = spawnStruct();
    shottimeinfo.startsec = var_43286fd46706909c.totaltimesec;
    shottimeinfo.durationsec = sceneroot function_30140edcf9e36027(sceneplay, shotindex);
    var_43286fd46706909c.shottimeinfo[shotindex] = shottimeinfo;
    var_43286fd46706909c.totaltimesec += shottimeinfo.durationsec;
  }

  var_43286fd46706909c.fromtimesec = var_43286fd46706909c.totaltimesec * var_43286fd46706909c.fromtimefrac;
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

  foreach(sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      sceneroot thread function_c4b3a49a6470bd32(sceneplay, "prepare", shotindex, sceneobjectindex);
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

    foreach(sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
      if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
        sceneroot thread function_daa02d9da601d14d(sceneplay, "anim", shotindex, sceneobjectindex);
      }
    }

    shot = sceneroot.scenedata.scenescriptbundle function_2218afa82a590ea3(shotindex);

    if(shot function_9336a9805a4ab29a()) {
      currentshotlength = sceneroot function_d9be975d8d1c9db3(shotindex, 1);
      alignedshotlength = function_81bab5b9c097deb5(currentshotlength);

      if(alignedshotlength > 0) {
        sceneplay delaythread(alignedshotlength, &function_8cb9e28d833bd068, "anim");
      }
    }

    sceneplay function_fef8a82cd85330df("anim");

    if(var_4e7a3e672aaebeaa) {
      sceneroot.var_708c03f822068263 = gettime();
    }

    sceneplay scripts\common\scene_debug::function_6b2bc344ea55f120();
  }

  foreach(var_19a1a40cf0ff83b9 in sceneplay.objectorder) {
    if(isDefined(var_19a1a40cf0ff83b9[shotindex])) {
      sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

      if(isDefined(sceneobjectdata.playbacksuccessful) && !sceneobjectdata.playbacksuccessful) {
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

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    objectshottimesec = sceneroot function_7d78fe1c5576bf4c(sceneplay, shotindex, sceneobjectindex);
    maxtimesec = max(maxtimesec, objectshottimesec);
  }

  return maxtimesec;
}

function private function_7c1dbb8157a07757(objecttask, shotindex) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;
  sceneplay.waitobjects[objecttask] = [];

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    if(isDefined(sceneplay.var_7038c2a13f1f5db8[sceneobjectindex]) && isDefined(sceneplay.var_7038c2a13f1f5db8[sceneobjectindex][shotindex])) {
      sceneplay.waitobjects[objecttask][sceneobjectindex] = sceneobjectindex;
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

  foreach(sceneobjectindex in sceneplay.waitobjects[objecttask]) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
    sceneobjectdata function_bdd631983c9e6f5c();
  }
}

function private function_28f230671b0b9a1f(var_9ca58f7c9e862815) {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;
  sceneplay.stoprequested = 1;
  sceneplay notify("scene_stop");
  sceneroot notify("scene_stop");

  for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
    if(isDefined(sceneplay.var_7038c2a13f1f5db8[sceneobjectindex])) {
      sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
      sceneroot function_b9b2392985736c52(sceneobjectindex);
    }
  }

  waittillframeend();

  while(sceneplay.state == "Playing") {
    anyactive = 0;

    for(sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size; sceneobjectindex++) {
      if(isDefined(sceneplay.var_7038c2a13f1f5db8[sceneobjectindex])) {
        sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

        if(isDefined(sceneobjectdata.active)) {
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
  sceneobjectdata = scenedata.sceneobjectdata[objectindex];

  if(sceneobjectdata ent_flag("scene_object_active")) {
    sceneroot function_b9b2392985736c52(objectindex);
  }

  sceneobjectdata ent_flag_waitopen("scene_object_active");
  sceneobjectdata ent_flag_set("scene_object_active");
  animtype = sceneobjectdata.sceneobject function_92192185fc7c5500();
  sceneobjectdata.var_36831a04af11576f = [];
  sceneobjectdata.var_36831a04af11576f[animtype] = "prepare" + shotindex + objectindex;
  sceneobjectdata.active = "prepare";
  sceneobjectdata function_d4dcec93a1db6e3f(sceneplay, shotindex, objectindex);
  sceneplay function_456603ee124b8267(objecttask, objectindex);
}

function private function_daa02d9da601d14d(sceneplay, objecttask, shotindex, objectindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  sceneobjectdata = scenedata.sceneobjectdata[objectindex];
  sceneobjectdata.var_36831a04af11576f = undefined;

  if(!isDefined(sceneobjectdata.active)) {
    sceneplay function_456603ee124b8267(objecttask, objectindex);
    return;
  }

  if(sceneobjectdata.sceneobject function_c2a0ad9229a93162(shotindex)) {
    sceneplay function_456603ee124b8267(objecttask, objectindex);
  }

  animated = sceneobjectdata.sceneobject function_938cdb6ca25882fc(shotindex);
  sceneobjectdata function_770c0b047ce9cfc1(shotindex);
  sceneobjectdata.active = "anim";
  sceneobjectdata.playbacksuccessful = 1;
  var_c5edd954050d9248 = 0;
  animstartsec = 0;
  lerptime = sceneobjectdata.sceneobject function_1e3ba3c3afdbb7b4(shotindex);
  blendtime = sceneobjectdata.sceneobject function_205f7afe5d801664(shotindex);
  blendcurve = sceneobjectdata.sceneobject function_167ed32773c7c534(shotindex);
  overridelerp = sceneobjectdata function_a680ab1ba5753613(shotindex, "lerp");
  overrideblend = sceneobjectdata function_a680ab1ba5753613(shotindex, "blend");

  if(isDefined(overridelerp)) {
    lerptime = float(overridelerp);
  }

  if(isDefined(overrideblend)) {
    blendtime = float(overrideblend);
  }

  cameraanimation = sceneobjectdata function_6c3d100538f590b3(shotindex);
  shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);
  var_44a5342136771a97 = isarray(shotanimations) && shotanimations.size > 0;
  sceneobjectdata function_535e6f4c06c15b1d(sceneplay, 1, 0, sceneobjectdata.alignmentinfo, lerptime);

  if(animated) {
    animtype = sceneobjectdata.sceneobject function_92192185fc7c5500();

    if(isDefined(sceneplay.var_43286fd46706909c)) {
      shotdurationsec = sceneroot function_7d78fe1c5576bf4c(sceneplay, shotindex, objectindex);
      shotstartsec = sceneplay.var_43286fd46706909c.shottimeinfo[shotindex].startsec;
      var_c5edd954050d9248 = shotstartsec;
      var_9102eff943c3c717 = shotstartsec + shotdurationsec;
      animstartsec = 0;

      if(var_9102eff943c3c717 < sceneplay.var_43286fd46706909c.fromtimesec) {
        sceneobjectdata.active = undefined;

        if(var_44a5342136771a97) {
          for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
            var_ad746e2693353028 = animtype + shotindex + objectindex + animationindex;
            sceneobjectdata function_9605363169f7b770(sceneobjectdata.alignmentinfo, shotanimations[animationindex], var_ad746e2693353028, 0, 1, animtype);
          }
        }

        if(isDefined(cameraanimation)) {
          var_ad746e2693353028 = animtype + shotindex + objectindex + animationindex + 0;
          sceneobjectdata function_9605363169f7b770(sceneobjectdata.alignmentinfo, cameraanimation, var_ad746e2693353028, 0, 1, "CameraAnimation");
        }

        sceneobjectdata function_4479600930e9e402(0, sceneplay, objecttask, shotindex, objectindex);
        return;
      } else {
        var_c5edd954050d9248 = sceneplay.var_43286fd46706909c.fromtimesec - shotstartsec;
      }
    }

    if(is_equal(sceneobjectdata.active, "anim")) {
      if(isDefined(cameraanimation)) {
        var_ad746e2693353028 = animtype + shotindex + objectindex + 0;
        var_866b3a3066122e39 = 0;

        if(isDefined(sceneplay.var_43286fd46706909c)) {
          var_866b3a3066122e39 = clamp(var_c5edd954050d9248 / sceneobjectdata function_9c0d01ef917ee30(cameraanimation, "CameraAnimation"), 0, 1);
          sceneobjectdata function_9605363169f7b770(sceneobjectdata.alignmentinfo, cameraanimation, var_ad746e2693353028, 0, var_866b3a3066122e39, "CameraAnimation");
        }

        var_812033365bb24665 = "CameraAnimation" + shotindex + objectindex;
        sceneobjectdata childthread object_play_anim(shotindex, 0, var_812033365bb24665, sceneobjectdata.alignmentinfo, cameraanimation, var_866b3a3066122e39, blendtime, blendcurve, lerptime, "CameraAnimation");
      }

      if(var_44a5342136771a97) {
        animationindex = 0;

        while(animationindex < shotanimations.size) {
          var_ad746e2693353028 = animtype + shotindex + objectindex + animationindex;
          var_866b3a3066122e39 = 0;

          if(var_c5edd954050d9248 > animstartsec) {
            animdurationsec = sceneobjectdata function_9c0d01ef917ee30(shotanimations[animationindex], animtype);

            if(animdurationsec > 0) {
              var_866b3a3066122e39 = clamp((var_c5edd954050d9248 - animstartsec) / animdurationsec, 0, 1);
              sceneobjectdata function_9605363169f7b770(sceneobjectdata.alignmentinfo, shotanimations[animationindex], var_ad746e2693353028, 0, var_866b3a3066122e39, animtype);

              if(var_866b3a3066122e39 > 1) {
                animstartsec += animdurationsec;
                animationindex++;
                continue;
              }
            } else {
              animationindex++;
              continue;
            }
          }

          animdurationsec = sceneobjectdata object_play_anim(shotindex, animationindex, var_ad746e2693353028, sceneobjectdata.alignmentinfo, shotanimations[animationindex], var_866b3a3066122e39, blendtime, blendcurve, lerptime, animtype);

          if(isDefined(animdurationsec)) {
            var_c5edd954050d9248 += animdurationsec;
            animstartsec += animdurationsec;
          }

          animationindex++;

          if(!is_equal(sceneobjectdata.active, "anim") || !is_equal(sceneobjectdata.sceneplay, sceneplay) || !isDefined(sceneobjectdata.scenedata)) {
            break;
          }
        }
      }
    }
  }

  while(isDefined(sceneobjectdata.var_36831a04af11576f) && sceneobjectdata.var_36831a04af11576f.size > 0) {
    sceneobjectdata waittill("scene_anim_ended");
  }

  sceneobjectdata function_4479600930e9e402(animated, sceneplay, objecttask, shotindex, objectindex);
}

function private function_4479600930e9e402(animated, sceneplay, objecttask, shotindex, objectindex) {
  sceneobjectdata = self;

  if(animated && !isDefined(sceneobjectdata.activeanimation)) {
    var_d6a0e35c2c8084e7 = 0;

    if(isDefined(sceneobjectdata.var_bb2bc0aa7d81de89)) {
      var_d6a0e35c2c8084e7 = function_1cf2b9abf05dd81d(sceneobjectdata.alignmentinfo.alignent, sceneobjectdata.alignmentinfo.aligntag, sceneobjectdata.var_bb2bc0aa7d81de89.alignent, sceneobjectdata.var_bb2bc0aa7d81de89.aligntag);
    }

    if(!var_d6a0e35c2c8084e7) {
      sceneobjectdata function_535e6f4c06c15b1d(sceneplay, 0, 0, sceneobjectdata.alignmentinfo);
    }
  }

  sceneobjectdata function_a477eb91dc3b38b8(shotindex);

  if(sceneobjectdata function_d04468979de3a6dd(sceneplay, shotindex)) {
    sceneobjectdata delaythreadendon(level.framedurationseconds, "scene_play", &object_cleanup);
  }

  sceneobjectdata.active = undefined;
  sceneobjectdata ent_flag_clear("scene_object_active");
  sceneplay function_456603ee124b8267(objecttask, objectindex);
}

function private function_157c6db3114c1ec9(sceneplay) {
  sceneobjectdata = self;
  assert(isDefined(sceneplay));
  assert(isarray(sceneplay.var_df5db7bd235f2729));
  assert(isint(sceneplay.shotindicesindex));
  objectindex = sceneobjectdata.index;

  if(!isDefined(sceneplay.var_7038c2a13f1f5db8[objectindex])) {
    return false;
  }

  for(sceneplayshotindex = sceneplay.shotindicesindex + 1; sceneplayshotindex < sceneplay.var_df5db7bd235f2729.size; sceneplayshotindex++) {
    var_1ee8422a72befa7 = sceneplay.var_df5db7bd235f2729[sceneplayshotindex];

    if(isDefined(sceneplay.var_7038c2a13f1f5db8[objectindex][var_1ee8422a72befa7])) {
      return true;
    }
  }

  return false;
}

function private function_d04468979de3a6dd(sceneplay, shotindex) {
  sceneobjectdata = self;
  sceneroot = sceneobjectdata.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!isDefined(scenedata)) {
    return true;
  }

  if(!is_equal(sceneplay, sceneobjectdata.sceneplay)) {
    return false;
  }

  if(isDefined(sceneobjectdata.activeanimation)) {
    return false;
  }

  if(sceneroot.scenedata.scenescriptbundle function_4f93a0dfb8fd6a47()) {
    return false;
  }

  if(!sceneobjectdata.sceneobject function_938cdb6ca25882fc(shotindex)) {
    return false;
  }

  if(sceneplay.var_df5db7bd235f2729.size == 0 || shotindex == sceneplay.var_df5db7bd235f2729[sceneplay.var_df5db7bd235f2729.size - 1]) {
    return true;
  }

  deletetype = sceneobjectdata.sceneobject function_d5f4474a16f90132();

  if(sceneobjectdata.sceneobject function_c77857d663e8cfbe() == "Types_XCam" || deletetype == "DeleteAlwaysNotInvolved" || deletetype == "DeleteSpawnedNotInvolved" && !istrue(sceneobjectdata.existingentity)) {
    if(!sceneobjectdata function_157c6db3114c1ec9(sceneplay)) {
      return true;
    }
  }

  return false;
}

function private function_7d78fe1c5576bf4c(sceneplay, shotindex, objectindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  sceneobjectdata = scenedata.sceneobjectdata[objectindex];

  if(isDefined(sceneplay.var_43286fd46706909c) && isDefined(sceneplay.var_43286fd46706909c.shottimeinfo[shotindex])) {
    return sceneplay.var_43286fd46706909c.shottimeinfo[shotindex].durationsec;
  }

  deltatimesec = 0;
  cameratimesec = 0;
  cameraanimation = sceneobjectdata function_6c3d100538f590b3(shotindex);

  if(isDefined(cameraanimation)) {
    shottimesec = sceneobjectdata function_9c0d01ef917ee30(cameraanimation, "CameraAnimation");
  }

  animtype = sceneobjectdata.sceneobject function_92192185fc7c5500();
  shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);

  for(animationindex = 0; animationindex < shotanimations.size; animationindex++) {
    deltatimesec += sceneobjectdata function_9c0d01ef917ee30(shotanimations[animationindex], animtype);
  }

  return max(cameratimesec, deltatimesec);
}

function private function_b9b2392985736c52(sceneobjectindex) {
  sceneroot = self;
  scenedata = sceneroot.scenedata;
  sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];
  sceneobjectdata.active = undefined;
  sceneobjectdata.playbacksuccessful = 0;
  sceneobjectdata notify("scene_stop");
  sceneobjectdata function_bdd631983c9e6f5c();
  sceneobjectdata function_9b8055c613f1bb31();
  sceneobjectdata ent_flag_clear("scene_object_active");
}

function private function_c643b2c6b794481e(newstate) {
  sceneroot = self;
  assert(newstate != "Playing");
  assert(newstate != "Stopped");

  if(isDefined(sceneroot.scenedata) && sceneroot.scenedata.state != newstate) {
    if(newstate != "NotInit") {
      sceneroot.scenedata.state = newstate;
      sceneroot function_2549c341bf1ae3e7(sceneroot.scenedata.state);
      return;
    }

    assert(sceneroot.scenedata.state == "NotSetup");

    if(isDefined(sceneroot.scenedata.sceneobjectdata)) {
      objectcount = sceneroot.scenedata.scenescriptbundle function_291cd2f1089d3a94();

      if(isDefined(objectcount)) {
        for(objectindex = 0; objectindex < objectcount; objectindex++) {
          if(objectindex < sceneroot.scenedata.sceneobjectdata.size) {
            sceneroot.scenedata.sceneobjectdata[objectindex].scenedata = undefined;
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
  assert(isDefined(level.scene.objecthandlers["Types_Object"]));
  assert(!isDefined(level.scene.var_8a6cbf5e0998e58d));
  level.scene.var_8a6cbf5e0998e58d = [];
  var_a05b670b818e941c = ["Types_Object", "Types_Prop", "Types_Actor", "Types_Player", "Types_EnemyPlayer", "Types_FakePlayer", "Types_FakeActor", "Types_Vehicle", "Types_Mayhem", "Types_XCam"];

  foreach(sceneobjecttype in var_a05b670b818e941c) {
    level.scene.var_8a6cbf5e0998e58d[sceneobjecttype] = [];

    foreach(functype, func in level.scene.objecthandlers["Types_Object"]) {
      level.scene.var_8a6cbf5e0998e58d[sceneobjecttype][functype] = func;
    }
  }

  foreach(sceneobjecttype, functable in level.scene.objecthandlers) {
    if(sceneobjecttype == "Types_Object") {
      continue;
    }

    foreach(func in functable) {
      level.scene.var_8a6cbf5e0998e58d[sceneobjecttype][functype] = func;
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
  sceneobjectdata = self;
  scenestatic = sceneobjectdata.sceneroot.scenestatic;
  entity = undefined;
  sceneobjecttype = sceneobjectdata.sceneobject function_c77857d663e8cfbe();
  sceneobjectassettype = sceneobjectdata.sceneobject function_992de34e05c5cea7();
  sceneobjectassetname = sceneobjectdata.sceneobject function_12eb9fd56334261c();
  sceneobjectname = sceneobjectdata.sceneobject function_aeb2b46911a5811d();
  spawnorigin = alignmentinfo.origin;
  spawnangles = alignmentinfo.angles;

  if(isDefined(shotinit)) {
    shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotinit);

    if(isDefined(shotanimations) && shotanimations.size > 0 && isanimation(shotanimations[0])) {
      spawnorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, shotanimations[0]);
      spawnangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, shotanimations[0]);
    }
  }

  function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x7e>", spawnorigin, spawnangles);

  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSpawn");

  if(isDefined(typefunc) && typefunc != &object_spawn) {
    entity = sceneobjectdata[[typefunc]](spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    entity = sceneobjectdata function_3e19c1b49e591d34(spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    if(sceneobjecttype != "<dev string:x84>" && sceneobjecttype != "<dev string:x91>") {
      println("<dev string:x9c>" + sceneobjectname + "<dev string:xc2>" + sceneobjectassettype + "<dev string:xcc>" + sceneobjectassetname + "<dev string:x48>");
    }
  }

  if(isDefined(entity) && !isPlayer(entity) && isDefined(scenestatic) && isDefined(scenestatic.spawnfunctions)) {
    entity.sceneobjectdata = sceneobjectdata;
    checktables = [sceneobjectname, sceneobjecttype, "_object_all_"];

    foreach(tablename in checktables) {
      if(isDefined(scenestatic.spawnfunctions[tablename])) {
        foreach(spawnfunc in scenestatic.spawnfunctions[tablename]) {
          entity thread[[spawnfunc]]();
        }
      }
    }
  }

  if(isDefined(entity)) {
    switch (sceneobjectdata.sceneobject function_b5a77eb340ad5552()) {
      case #"hash_5a532485943b3d4b":
        entity.targetname = "_scene_global_" + sceneobjectname;
        break;
      case #"hash_6d8a4db48060bf8":
        entity.script_noteworthy = "_scene_global_" + sceneobjectname;
        break;
    }
  }

  return entity;
}

function private function_3e19c1b49e591d34(spawnorigin, spawnangles) {
  sceneobjectdata = self;
  entity = undefined;
  sceneobjectassettype = sceneobjectdata.sceneobject function_992de34e05c5cea7();
  sceneobjectassetname = sceneobjectdata.sceneobject function_12eb9fd56334261c();

  if(sceneobjectassettype == "xmodel" || sceneobjectassettype == "xcompositemodel") {
    entity = spawn("script_model", spawnorigin);

    if(isDefined(entity)) {
      entity val::set("scene_scene", "cinematics_participant", 1);
      entity.angles = spawnangles;
      entity setModel(sceneobjectassetname);
      animtree = sceneobjectdata.sceneobject function_c106523f3836b90b();

      if(isDefined(animtree)) {
        entity useanimtree(animtree);
      }

      entity scripts\common\visibility_mode::function_d5f76e611c78509a();
    }
  } else if(sceneobjectassettype == "character") {
    character = getxhash(sceneobjectassetname);

    if(isDefined(level.fncharacter) && isDefined(level.fncharacter[character])) {
      entity = spawn("script_model", spawnorigin);

      if(isDefined(entity)) {
        entity val::set("scene_scene", "cinematics_participant", 1);
        func = level.fncharacter[character];
        entity[[func]]();
        entity.angles = spawnangles;
        animtree = sceneobjectdata.sceneobject function_c106523f3836b90b();

        if(isDefined(animtree)) {
          entity useanimtree(animtree);
        }

        entity scripts\common\visibility_mode::function_d5f76e611c78509a();
      }
    }
  }

  return entity;
}

function private function_476ef6856b76fadb(newsceneroot) {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata)) {
    return;
  }

  if(isDefined(sceneobjectdata.sceneplay) && isDefined(sceneobjectdata.active)) {
    sceneobjectdata.sceneplay function_456603ee124b8267(sceneobjectdata.active, sceneobjectdata.index);
  }

  sceneobjectdata function_bdd631983c9e6f5c();
  sceneobjectdata object_cleanup(newsceneroot);
  sceneobjectdata ent_flag_clear("scene_object_active");
  sceneobjectdata.entity = undefined;
}

function private function_6acd8ab4606e2a09(sceneroot, sceneplay, entity, existing, inittype) {
  sceneobjectdata = self;

  if(isDefined(entity) && isDefined(entity.sceneobjectdata) && !is_equal(sceneplay, entity.sceneobjectdata.sceneplay)) {
    if(!(inittype == "scene_init_prestream" && entity.sceneobjectdata == sceneobjectdata)) {
      assert(sceneobjectdata != entity.sceneobjectdata || !is_equal(sceneplay, entity.sceneobjectdata.sceneplay));
      entity.sceneobjectdata function_476ef6856b76fadb(sceneroot);
    }
  }

  if(isent(sceneobjectdata.entity)) {
    if(sceneobjectdata.entity == entity) {
      return;
    }

    if(!istrue(sceneobjectdata.existingentity)) {
      sceneobjectdata object_cleanup();
      sceneobjectdata object_delete();
    }
  }

  sceneobjectdata.entity = entity;
  sceneobjectdata.existingentity = existing;
}

function private object_setup(sceneplay) {
  sceneobjectdata = self;
  sceneobjectdata.sceneplay = sceneplay;

  if(isDefined(sceneobjectdata.entity)) {
    sceneobjectname = sceneobjectdata.sceneobject function_aeb2b46911a5811d();
    sceneobjecttree = sceneobjectdata.sceneobject function_c106523f3836b90b();
    sceneobjectdata function_729a3f3943f35748(sceneobjectname, sceneobjecttree);

    if(!isDefined(sceneobjectdata.restoredontmelee)) {
      sceneobjectdata.restoredontmelee = sceneobjectdata.entity.dontmelee;
    }

    sceneobjectdata.entity.dontmelee = 1;
    sceneobjectdata.entity ent_flag_set("scene_active");

    if(isPlayer(sceneobjectdata.entity)) {
      if(sceneobjectdata.scenedata.scenescriptbundle function_295cf85da8fa8653()) {
        sceneobjectdata.entity val::set("scene_scene", "show_hud", 0);
      }
    }
  }

  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetup");

  if(isDefined(typefunc) && typefunc != &object_setup) {
    sceneobjectdata[[typefunc]](sceneplay);
  }

  if(isDefined(sceneobjectdata.entity)) {
    sceneobjectdata.entity.sceneobjectdata = sceneobjectdata;
  }

  sceneobjectdata.issetup = 1;
}

function private function_729a3f3943f35748(animname, animtree) {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.entity)) {
    return;
  }

  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetAnimName");

  if(isDefined(typefunc) && typefunc != &function_729a3f3943f35748) {
    sceneobjectdata[[typefunc]](animname, animtree);
    return;
  }

  if(isDefined(animname)) {
    if(!isPlayer(sceneobjectdata.entity) && isDefined(animtree) && (!isDefined(sceneobjectdata.entity.animtree) || sceneobjectdata.entity.animtree == "")) {
      if(!isDefined(sceneobjectdata.animtreeprevious)) {
        sceneobjectdata.animtreeprevious = sceneobjectdata.entity.animtree;
      }

      sceneobjectdata.entity useanimtree(animtree);
    }

    if(!isDefined(sceneobjectdata.entity.animname)) {
      sceneobjectdata.entity.animname = animname;
    }

    return;
  }

  if(isDefined(sceneobjectdata.animtreeprevious)) {
    sceneobjectdata.entity useanimtree(sceneobjectdata.animtreeprevious);
  }

  sceneobjectdata.animtreeprevious = undefined;
}

function private function_bdfc45b799d27532(animasset) {
  sceneobjectdata = self;
  sceneobjectdata.activeanimationplaying = undefined;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetAnimPlaying");

  if(isDefined(typefunc) && typefunc != &function_bdfc45b799d27532) {
    sceneobjectdata[[typefunc]](animasset);
    return;
  }

  sceneobjectdata.activeanimationplaying = animasset;
  sceneobjectdata notify("scene_anim_playing", animasset);
}

function private function_2142970a7a74d1f2(endonevent, func, param1, param2) {
  sceneobjectdata = self;
  sceneobjectdata thread function_a3511922b90bf177(endonevent, func, param1, param2);
}

function private function_a3511922b90bf177(endonevent, func, param1, param2) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(sceneobjectdata.activeanimationplaying)) {
    entity endon("death");

    if(isDefined(endonevent)) {
      if(!isarray(endonevent)) {
        endonevent = [endonevent];
      }

      foreach(endonname in endonevent) {
        entity endon(endonname);
      }
    }

    sceneobjectdata waittill("scene_anim_playing");
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
  sceneobjectdata = self;
  animrate = default_to(animrate, 1);
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetAnimRate");

  if(isDefined(typefunc) && typefunc != &function_6a4d64bdba27cb06) {
    sceneobjectdata[[typefunc]](animrate);
    return;
  }

  if(isDefined(sceneobjectdata.activeanimation) && isDefined(sceneobjectdata.activeanimationtype) && sceneobjectdata.activeanimationtype == "DeltaAnimation") {
    entity = sceneobjectdata function_4c4c2a548b9fc7ab();

    if(isDefined(entity)) {
      entity setanimrate(sceneobjectdata.activeanimation, animrate);
    }
  }
}

function private function_380708345e16e475(animasset, timefrac) {
  sceneobjectdata = self;
  timefrac = default_to(timefrac, 0);
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetAnimTime");

  if(isDefined(typefunc) && typefunc != &function_380708345e16e475) {
    sceneobjectdata[[typefunc]](animasset, timefrac);
    return;
  }

  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity setanimtime(animasset, timefrac);
    entity dontinterpolate();
  }
}

function private function_db16fb604c5ca71d(lerptime, velocity) {
  sceneobjectdata = self;
  lerptime = default_to(lerptime, 0);
  velocity = default_to(velocity, (0, 0, 0));
  waittillframeend();
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetAnimLerp");

  if(isDefined(typefunc) && typefunc != &function_db16fb604c5ca71d) {
    sceneobjectdata[[typefunc]](lerptime, velocity);
    return;
  }

  entities = sceneobjectdata function_f054a83311d7f448();

  foreach(entity in entities) {
    if(isanimScripted(entity)) {
      entity animscripted_blendin(lerptime, velocity);
    }
  }
}

function private function_bf2f06d70b4e15ad(enabled) {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectSetProcBones");

  if(isDefined(typefunc) && typefunc != &function_bf2f06d70b4e15ad) {
    sceneobjectdata[[typefunc]](enabled);
    return;
  }

  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

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

      if(!isDefined(sceneobjectdata.activeanimationplaying)) {
        sceneobjectdata waittill("scene_anim_playing");
      }

      entity setanim(proc_node, weight, 0);
    }
  }
}

function private function_2294fe71a7c1d8d6(entity) {
  sceneobjectdata = self;

  if(!isent(entity)) {
    return 0;
  }

  if(isspawner(entity)) {
    return 0;
  }

  typefunc = sceneobjectdata function_8a786f133d7341c0("objectMatchEntity");

  if(isDefined(typefunc) && typefunc != &function_2294fe71a7c1d8d6) {
    return sceneobjectdata[[typefunc]](entity);
  }

  return entity.classname == "script_model";
}

function private function_1ba5fc9ef8e19620(sceneroot, sceneplay, sceneobjectname, matchset, matchanimname, existing, inittype) {
  sceneobjectdata = self;

  if(isarray(matchset)) {
    if(isDefined(sceneobjectdata.entity)) {
      foreach(matchsetindex, existingent in matchset) {
        if(isent(existingent) && sceneobjectdata function_2294fe71a7c1d8d6(existingent)) {
          if(existingent == sceneobjectdata.entity || isDefined(existingent.animname) && isDefined(sceneobjectdata.entity.animname) && existingent.animname == sceneobjectdata.entity.animname) {
            sceneobjectdata function_6acd8ab4606e2a09(sceneroot, sceneplay, existingent, existing, inittype);
            matchset[matchsetindex] = undefined;
            break;
          }
        }
      }

      return matchset;
    }

    foreach(existingent in matchset) {
      if(isent(existingent) && sceneobjectdata function_2294fe71a7c1d8d6(existingent)) {
        if(!istrue(matchanimname) || isDefined(existingent.animname) && existingent.animname == sceneobjectname) {
          sceneobjectdata function_6acd8ab4606e2a09(sceneroot, sceneplay, existingent, existing, inittype);
          matchset[matchsetindex] = undefined;
          break;
        }
      }
    }
  }

  return matchset;
}

function private function_53687c7001a0784b(sceneroot, sceneplay, sceneobjectname, usedset, keyname, inittype) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    sceneobjectdata function_6acd8ab4606e2a09(sceneroot, sceneplay, sceneobjectdata.entity, 1, inittype);
    entnum = sceneobjectdata.entity getentitynumber();
    usedset[entnum] = sceneobjectdata.entity;
    return usedset;
  }

  foundentities = getEntArray(sceneobjectname, keyname);

  foreach(foundent in foundentities) {
    entnum = foundent getentitynumber();

    if(isDefined(usedset) && isDefined(usedset[entnum])) {
      continue;
    }

    if(sceneobjectdata function_2294fe71a7c1d8d6(foundent)) {
      sceneobjectdata function_6acd8ab4606e2a09(sceneroot, sceneplay, foundent, 1, inittype);
      usedset[entnum] = foundent;
      break;
    }
  }

  return usedset;
}

function private function_4c4c2a548b9fc7ab() {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.entity)) {
    return undefined;
  }

  typefunc = sceneobjectdata function_8a786f133d7341c0("objectGetAnimEntity");

  if(isDefined(typefunc) && typefunc != &function_4c4c2a548b9fc7ab) {
    return sceneobjectdata[[typefunc]]();
  }

  return sceneobjectdata.entity;
}

function private function_f054a83311d7f448() {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectGetLinkEnts");

  if(isDefined(typefunc) && typefunc != &function_f054a83311d7f448) {
    return sceneobjectdata[[typefunc]]();
  }

  animentity = sceneobjectdata function_4c4c2a548b9fc7ab();
  return [animentity];
}

function private function_b9c245bf99df4a8() {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectGetAnimRoot");

  if(isDefined(typefunc) && typefunc != &function_b9c245bf99df4a8) {
    return sceneobjectdata[[typefunc]]();
  }

  entity = function_4c4c2a548b9fc7ab();

  if(isDefined(entity) && isDefined(entity.anim_getrootfunc)) {
    return [[entity.anim_getrootfunc]]();
  }

  return undefined;
}

function private object_teleport(origin, angles) {
  sceneobjectdata = self;

  function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xd7>", origin, angles);

  typefunc = sceneobjectdata function_8a786f133d7341c0("objectTeleport");

  if(isDefined(typefunc) && typefunc != &object_teleport) {
    sceneobjectdata[[typefunc]](origin, angles);
    return;
  }

  entities = sceneobjectdata function_f054a83311d7f448();

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
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectVelocity");

  if(isDefined(typefunc) && typefunc != &object_velocity) {
    return sceneobjectdata[[typefunc]]();
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
  sceneobjectdata = self;

  if(istrue(blink)) {
    function_e4fc30ccdca08b9d(alignmentinfo);
  }

  linkents = sceneobjectdata function_f054a83311d7f448();

  if(istrue(bsetup) && isDefined(sceneplay) && !sceneobjectdata function_d82945c5509ec28e(sceneplay.shotinit)) {
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
      var_80cc7e738d1c353f = function_1cf2b9abf05dd81d(sceneobjectdata.linkedent, sceneobjectdata.linkedtag, alignmentinfo.alignent, alignmentinfo.aligntag);

      if(!var_80cc7e738d1c353f && alignmentinfo.alignent != entity && !entity isragdoll() && (!isDefined(linkedparent) || linkedparent != alignmentinfo.alignent || default_to(sceneobjectdata.linkedtag, "") != default_to(alignmentinfo.aligntag, ""))) {
        if(!isDefined(lerptime) || lerptime <= 0) {
          sceneobjectdata object_teleport(alignmentinfo.origin, alignmentinfo.angles);
        }

        if(isstring(alignmentinfo.aligntag)) {
          function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xe0>" + alignmentinfo.aligntag, alignmentinfo.alignent gettagorigin(alignmentinfo.aligntag), alignmentinfo.alignent gettagangles(alignmentinfo.aligntag));

          if(isPlayer(entity)) {
            entity playerlinkTo(alignmentinfo.alignent, alignmentinfo.aligntag);
          } else if(isagent(entity)) {
            entity linktomoveoffset(alignmentinfo.alignent, alignmentinfo.aligntag);
            entity playerlinkedoffsetenable();
            entity fixlinktointerpolationbug(1);
          } else {
            entity linkTo(alignmentinfo.alignent, alignmentinfo.aligntag, (0, 0, 0), (0, 0, 0));
          }

          sceneobjectdata.linkedtag = alignmentinfo.aligntag;
          sceneobjectdata.linkedent = alignmentinfo.alignent;

          if(isDefined(lerptime) && lerptime > 0) {
            sceneobjectdata object_teleport(prevorigin, prevangles);
          }
        } else {
          function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xe6>", entity.origin, entity.angles);

          sceneobjectdata.linkedtag = undefined;
          sceneobjectdata.linkedent = alignmentinfo.alignent;

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
      function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xeb>", entity.origin, entity.angles);

      entity unlink();
      sceneobjectdata.linkedtag = undefined;
      sceneobjectdata.linkedent = undefined;
    }
  }
}

function private function_9745e01cedd81c85(alignmentinfo, shotindex) {
  sceneobjectdata = self;
  shotindex = default_to(shotindex, sceneobjectdata.sceneplay.shotinit);
  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectFirstFrame");

  if(isDefined(typefunc) && typefunc != &function_9745e01cedd81c85) {
    sceneobjectdata[[typefunc]](alignmentinfo, shotindex);
    return;
  }

  if(!isDefined(sceneobjectdata.entity)) {
    return;
  }

  shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);

  if(shotanimations.size != 0) {
    entity = sceneobjectdata function_4c4c2a548b9fc7ab();
    animasset = shotanimations[0];

    if(isent(entity) && entity.model != "") {
      entity stopanimScripted();
      entity.origin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
      entity.angles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);
      entity setanimknob(animasset, 1, 0, 0);
      entity setanimtime(animasset, 0);
      entity dontinterpolate();

      function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xf2>" + getxhashsourcename(getanimname(animasset)), entity.origin, entity.angles);

      function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xff>" + getxhashsourcename(getanimname(animasset)), alignmentinfo.origin, alignmentinfo.angles);
    }
  }
}

function private function_744a16ccecd8e4dd() {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectCanAnimate");

  if(isDefined(typefunc) && typefunc != &function_744a16ccecd8e4dd) {
    return sceneobjectdata[[typefunc]]();
  }

  return 1;
}

function private object_play_anim(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  sceneobjectdata = self;
  sceneobjectdata.activeanimationtype = animationtype;
  sceneobjectdata.activeanimation = animasset;
  sceneobjectdata function_16714fbc8955e6c7(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype);

  if(isDefined(animationtype)) {
    sceneobjectdata.var_36831a04af11576f[animationtype] = notifystring;
  }

  animationtype = default_to(animationtype, "DeltaAnimation");
  animplaybacktime = 0;

  if(isent(sceneobjectdata.entity)) {
    sceneobjectdata.entity notify("scene_play_anim");
  }

  sceneobjectdata notify("scene_play_anim");

  if(animationtype == "DeltaAnimation") {
    if(!isent(sceneobjectdata.entity)) {
      n_anim_length = getanimlength(animasset);
      sceneobjectdata utility::waittill_any_timeout_1(n_anim_length, "scene_anim_ended");
      sceneobjectdata function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      sceneobjectdata function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    anim_entity = sceneobjectdata function_4c4c2a548b9fc7ab();

    if(!isDefined(anim_entity) || anim_entity.model == "") {
      sceneobjectdata function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      sceneobjectdata function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    if(sceneobjectdata.sceneobject function_84eff20f9e29c7f6(shotindex)) {
      function_e4fc30ccdca08b9d(alignmentinfo);
      sceneobjectdata function_9745e01cedd81c85(sceneobjectdata.alignmentinfo, shotindex);
      sceneobjectdata function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      sceneobjectdata function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    sceneobjectdata.entity endon("death");
    anim_entity endon("death");
    sceneobjectdata thread object_play_anim_waittill_end(animasset, [sceneobjectdata.entity, anim_entity], "death", animationtype, notifystring);

    debugname = getxhashsourcename(getanimname(animasset));
    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x112>" + debugname, alignmentinfo.origin, alignmentinfo.angles);

    typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectPlayAnim");

    if(isDefined(typefunc) && typefunc != &object_play_anim) {
      animplaybacktime = sceneobjectdata[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
    }

    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x11d>" + debugname, alignmentinfo.origin, alignmentinfo.angles);
  } else if(animationtype == "CameraAnimation") {
    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x128>" + animasset, alignmentinfo.origin, alignmentinfo.angles);

    typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectPlayAnim");

    if(isDefined(typefunc) && typefunc != &object_play_anim) {
      animplaybacktime = sceneobjectdata[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
    }

    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x133>" + animasset, alignmentinfo.origin, alignmentinfo.angles);
  } else if(animationtype == "MayhemAnimation") {
    if(sceneobjectdata.sceneobject function_84eff20f9e29c7f6(shotindex)) {
      function_e4fc30ccdca08b9d(alignmentinfo);
      sceneobjectdata function_9745e01cedd81c85(sceneobjectdata.alignmentinfo);
      sceneobjectdata function_bf0d14daf3e53248(animasset, animationtype, notifystring);
      sceneobjectdata function_68056529c69f4097(animationtype, shotindex, animindex);
      return;
    }

    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x13e>" + animasset, alignmentinfo.origin, alignmentinfo.angles);

    typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectPlayAnim");

    if(isDefined(typefunc) && typefunc != &object_play_anim) {
      animplaybacktime = sceneobjectdata[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
    }

    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x14b>" + animasset, alignmentinfo.origin, alignmentinfo.angles);
  }

  sceneobjectdata function_bf0d14daf3e53248(animasset, animationtype, notifystring);
  sceneobjectdata function_68056529c69f4097(animationtype, shotindex, animindex);
  return animplaybacktime;
}

function private object_play_anim_waittill_end(animasset, var_23a35a13a8548fe6, waitfor, animationtype, notifystring) {
  sceneobjectdata = self;

  if(isDefined(animasset) && is_equal(animationtype, "DeltaAnimation")) {
    suffix = getxhashhexname(getanimname(animasset));
  } else {
    suffix = "";
  }

  sceneobjectdata notify("object_play_anim_waittill_end" + suffix);
  sceneobjectdata endon("object_play_anim_waittill_end" + suffix);
  waittill_any_ents_array(var_23a35a13a8548fe6, waitfor);

  if(isDefined(sceneobjectdata)) {
    sceneobjectdata thread function_bf0d14daf3e53248(animasset, animationtype, notifystring);
  }
}

function private function_bf0d14daf3e53248(animasset, animationtype, notifystring) {
  sceneobjectdata = self;

  if(isDefined(animasset) && is_equal(animationtype, "DeltaAnimation")) {
    suffix = getxhashhexname(getanimname(animasset));
  } else {
    suffix = "";
  }

  sceneobjectdata notify("object_play_anim_waittill_end" + suffix);
  ended = 0;

  if(isDefined(sceneobjectdata.var_36831a04af11576f)) {
    foreach(activenotifystring in sceneobjectdata.var_36831a04af11576f) {
      if(!isDefined(animationtype) || animationtype == activeanimationtype) {
        if(!isDefined(notifystring) || notifystring == activenotifystring) {
          sceneobjectdata notify(activenotifystring, "end");
          ended = 1;
        }
      }
    }
  }

  if(ended) {
    if(isDefined(animationtype)) {
      sceneobjectdata.var_36831a04af11576f[animationtype] = undefined;
    } else {
      sceneobjectdata.var_36831a04af11576f = undefined;
    }
  }

  if(!isDefined(animasset) || isDefined(sceneobjectdata.activeanimationtype) && sceneobjectdata.activeanimationtype == animationtype && is_equal(sceneobjectdata.activeanimation, animasset)) {
    sceneobjectdata.activeanimation = undefined;
    sceneobjectdata.activeanimationtype = undefined;
    sceneobjectdata.activeanimationplaying = undefined;
  }

  sceneobjectdata notify("scene_anim_ended");
}

function private function_8e9f8e1fbe2b7ab4(notifystring, animasset) {
  sceneobjectdata = self;
  sceneobjectdata childthread function_924dc6425bd2b70d(notifystring);
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectWaitNotes");

  if(isDefined(typefunc) && typefunc != &function_8e9f8e1fbe2b7ab4) {
    sceneobjectdata[[typefunc]](notifystring, animasset);
    return;
  }

  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    sceneobjectdata childthread start_notetrack_wait(entity, notifystring, undefined, undefined, animasset);
  }
}

function private function_9605363169f7b770(alignmentinfo, animasset, notifystring, var_866b3a3066122e39, var_1cbffacca2bd0d4c, animationtype) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(animationtype == "DeltaAnimation") {
    typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectSkipAnim");

    if(isDefined(typefunc) && typefunc != &function_9605363169f7b770) {
      sceneobjectdata[[typefunc]](alignmentinfo, animasset, var_866b3a3066122e39, var_1cbffacca2bd0d4c);
      return;
    }

    if(isDefined(entity) && entity.model != "") {
      entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset);
      entity setanimtime(animasset, var_866b3a3066122e39);

      if(!(animislooping(animasset) && var_1cbffacca2bd0d4c == 1)) {
        entity setanimtime(animasset, var_1cbffacca2bd0d4c);
      }
    }
  }
}

function private function_924dc6425bd2b70d(notifystring, specificnotifyitem) {
  sceneobjectdata = self;
  scenestatic = sceneobjectdata.sceneroot.scenestatic;

  if(!isDefined(scenestatic) || !isDefined(scenestatic.notifies)) {
    return;
  }

  sceneobjecttype = sceneobjectdata.sceneobject function_c77857d663e8cfbe();
  sceneobjectname = sceneobjectdata.sceneobject function_aeb2b46911a5811d();
  notifies = [];
  checktables = [sceneobjectname, sceneobjecttype, "_object_all_"];

  foreach(tablename in checktables) {
    if(isDefined(scenestatic.notifies[tablename])) {
      notifies = array_combine(notifies, scenestatic.notifies[tablename]);
    }
  }

  foreach(notifyitem in notifies) {
    if(!isDefined(specificnotifyitem) || specificnotifyitem == notifyitem) {
      sceneobjectdata thread function_c9fbe2a0f09e68b0(notifystring, notifyitem);
    }
  }
}

function private function_c9fbe2a0f09e68b0(notifystring, notifyitem) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity function_5ecd1fd13181af98(notifystring, notifyitem, sceneobjectdata);
  }
}

function private object_shot_death_wait(sceneplay, shotindex, sceneobjectindex) {
  sceneobjectdata = self;
  sceneroot = sceneobjectdata.sceneroot;
  scenedata = sceneroot.scenedata;
  sceneobjectdata notify("object_shot_death_wait");
  sceneobjectdata endon("object_shot_death_wait");
  deathanim = sceneobjectdata.sceneobject function_f731c1198ec2b72f(shotindex);
  deathscenestop = sceneobjectdata.sceneobject function_becdf44d08cc1faf();

  if(!deathscenestop && !isDefined(deathanim)) {
    return;
  }

  sceneplay endon("scene_shot_cleanup");
  entity = sceneobjectdata.entity;

  if(isalive(entity)) {
    entity val::set("scene_shot", "death", 0);

    while(entity.health > 1) {
      entity waittill("damage");
    }

    if(deathscenestop) {
      sceneroot thread stop();
    }

    if(isDefined(entity) && isDefined(deathanim)) {
      animentity = sceneobjectdata function_4c4c2a548b9fc7ab();

      if(isDefined(animentity)) {
        animtype = sceneobjectdata.sceneobject function_92192185fc7c5500();
        notifystring = sceneobjectdata.var_36831a04af11576f[animtype];
        sceneobjectdata.var_36831a04af11576f[animtype] = undefined;
        sceneobjectdata object_play_anim(shotindex, -1, notifystring, sceneobjectdata.alignmentinfo, deathanim);
      }
    }

    entity val::set("scene_shot", "death", 1);
    sceneobjectdata object_kill();
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
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectAnimEnd");

  if(isDefined(typefunc) && typefunc != &function_bdd631983c9e6f5c) {
    sceneobjectdata[[typefunc]]();
  } else if(isDefined(sceneobjectdata.entity) && isDefined(sceneobjectdata.var_36831a04af11576f)) {
    foreach(message in sceneobjectdata.var_36831a04af11576f) {
      sceneobjectdata.entity notify(message, "end");
    }
  }

  sceneobjectdata.var_36831a04af11576f = undefined;
}

function private function_9b8055c613f1bb31() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x158>", sceneobjectdata.entity.origin, sceneobjectdata.entity.angles);
  }

  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectStopAnim");

  if(isDefined(typefunc) && typefunc != &function_9b8055c613f1bb31) {
    sceneobjectdata[[typefunc]]();
  } else if(isDefined(sceneobjectdata.entity) && isDefined(sceneobjectdata.activeanimationtype) && sceneobjectdata.activeanimationtype == "DeltaAnimation") {
    sceneobjectdata.entity stopanimScripted();
  }

  sceneobjectdata.activeanimationtype = undefined;
  sceneobjectdata.activeanimation = undefined;
  sceneobjectdata.var_a3ff79ae166c57aa = sceneobjectdata.activeanimationplaying;
  sceneobjectdata.activeanimationplaying = undefined;
  sceneobjectdata function_bf0d14daf3e53248();
}

function private object_cleanup(newsceneroot) {
  sceneobjectdata = self;

  if(istrue(sceneobjectdata.issetup)) {
    sceneobjectdata function_535e6f4c06c15b1d(undefined, 0, 0, sceneobjectdata.alignmentinfo);
    typefunc = sceneobjectdata function_8a786f133d7341c0("objectCleanup");

    if(isDefined(typefunc) && typefunc != &object_cleanup) {
      sceneobjectdata[[typefunc]](newsceneroot);
    }

    if(isDefined(sceneobjectdata.entity)) {
      sceneobjectdata.entity val::reset_all("scene_scene");
      sceneobjectdata.entity ent_flag_clear("scene_active");
      sceneobjectdata.entity.sceneobjectdata = undefined;
      sceneobjectdata function_729a3f3943f35748(undefined, undefined);

      if(isDefined(sceneobjectdata.restoredontmelee)) {
        sceneobjectdata.entity.dontmelee = sceneobjectdata.restoredontmelee;
      }
    }

    sceneobjectdata notify("scene_ai_stealth");

    if(!isDefined(newsceneroot) && sceneobjectdata function_cdec4d1452eba0d8()) {
      sceneobjectdata object_delete();
    }

    sceneobjectdata.issetup = undefined;
  }
}

function private function_cdec4d1452eba0d8() {
  sceneobjectdata = self;
  deletetype = sceneobjectdata.sceneobject function_d5f4474a16f90132();
  deletealways = deletetype == "DeleteAlways" || deletetype == "DeleteAlwaysNotInvolved";
  deletespawned = (deletetype == "DeleteSpawned" || deletetype == "DeleteSpawnedNotInvolved") && !istrue(sceneobjectdata.existingentity);

  if(deletealways || deletespawned) {
    return true;
  }

  return false;
}

function private object_kill() {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectKill");

  if(isDefined(typefunc) && typefunc != &object_kill) {
    sceneobjectdata[[typefunc]]();
    return;
  }

  if(isalive(sceneobjectdata.entity)) {
    sceneobjectdata.entity kill();
  }
}

function private object_delete() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x15d>", sceneobjectdata.entity.origin, sceneobjectdata.entity.angles);
  }

  scripts\common\visibility_mode::function_b6e23e71bb7ad50f(sceneobjectdata.entity);
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectDelete");

  if(isDefined(typefunc) && typefunc != &object_delete) {
    sceneobjectdata[[typefunc]]();
  } else if(isDefined(sceneobjectdata.entity)) {
    sceneobjectdata.entity delete();
  }

  sceneobjectdata.entity = undefined;
  sceneobjectdata.existingentity = undefined;
}

function private function_2f2327d535ed0bb() {
  sceneobjectdata = self;

  if(istrue(sceneobjectdata.xcamplaying)) {
    if(isPlayer(sceneobjectdata.entity)) {
      sceneobjectdata.entity stopxcam();
    }

    sceneobjectdata.xcamplaying = undefined;
  }
}

function private function_b62972e8f5541b26(sceneplay, shotindex) {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectPreStream");

  if(isDefined(typefunc) && typefunc != &function_b62972e8f5541b26) {
    sceneobjectdata[[typefunc]](sceneplay, shotindex);
  }

  sceneobjectdata function_e4fc30ccdca08b9d(sceneobjectdata.alignmentinfo);

  if(isDefined(sceneobjectdata.alignmentinfo)) {
    cameraanimation = sceneobjectdata function_6c3d100538f590b3(shotindex);
    shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);

    if(isPlayer(sceneobjectdata.entity)) {
      player = sceneobjectdata.entity;
      streamcameraorigin = undefined;

      if(isDefined(cameraanimation)) {
        streamcameraorigin = player getxcamposition(cameraanimation, 0, 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles);
      } else if(isDefined(shotanimations) && shotanimations.size > 0) {
        linktag = sceneobjectdata function_a89f1262c5148bdf();
        animentity = sceneobjectdata function_4c4c2a548b9fc7ab();
        offset = (0, 0, player getplayerviewheight());

        if(isDefined(animentity)) {
          startposang = animentity function_d2e8597ff01310ed(shotanimations[0], linktag, 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles);

          if(isDefined(startposang)) {
            streamcameraorigin = startposang["origin"];
            offset = rotatevector(offset, startposang["angles"]);
          }
        }

        if(!isDefined(streamcameraorigin)) {
          streamcameraorigin = getstartorigin(sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles, shotanimations[0]);
        }

        if(!is_equal(linktag, "tag_camera")) {
          streamcameraorigin += offset;
        }
      }

      if(isDefined(streamcameraorigin)) {
        function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x164>", streamcameraorigin, (0, 0, 0));

        playerinfo = sceneplay function_317afd3b93b0b54d(player, streamcameraorigin);
      }
    }

    if(isDefined(shotanimations) && shotanimations.size > 0) {
      if(sceneobjectdata function_7f90ebd0aa7ad958(shotindex)) {
        objectorigin = getstartorigin(sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles, shotanimations[0]);
      } else {
        objectorigin = sceneobjectdata.alignmentinfo.origin;
      }

      objectinfo = spawnStruct();
      objectinfo.origin = objectorigin;
      objectinfo.entity = sceneobjectdata function_4c4c2a548b9fc7ab();
      sceneplay.prestream.objects[sceneplay.prestream.objects.size] = objectinfo;
    }
  }
}

function private function_d4dcec93a1db6e3f(sceneplay, shotindex, sceneobjectindex) {
  sceneobjectdata = self;
  sceneplay endon("scene_stop");
  sceneobjectdata endon("scene_stop");

  foreach(message in sceneobjectdata.var_36831a04af11576f) {
    sceneobjectdata endon(message);
  }

  sceneobjectdata childthread object_shot_death_wait(sceneplay, shotindex, sceneobjectindex);
  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectPrepare");

  if(isDefined(typefunc) && typefunc != &function_d4dcec93a1db6e3f) {
    sceneobjectdata[[typefunc]](sceneplay, shotindex, sceneobjectindex);
  }
}

function private function_770c0b047ce9cfc1(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    if(sceneobjectdata.sceneobject function_7a553773a0af8bcd(shotindex)) {
      sceneobjectdata.entity val::set("scene_scene", "hide", 1);
      sceneobjectdata.entity val::set("scene_scene", "ignoreall", 1);
      sceneobjectdata.entity val::set("scene_scene", "ignoreme", 1);
    }

    if(sceneobjectdata.sceneobject function_8ed9853e35162b7c(shotindex)) {
      sceneobjectdata.entity val::reset("scene_scene", "hide");
      sceneobjectdata.entity show();
      sceneobjectdata.entity val::reset("scene_scene", "ignoreall");
      sceneobjectdata.entity val::reset("scene_scene", "ignoreme");
    }

    if(!sceneobjectdata.sceneobject function_fc9281240877df76()) {
      sceneobjectdata.entity val::set("scene_shot", "damage", 0);
    }

    if(isPlayer(sceneobjectdata.entity)) {
      tweenin = sceneobjectdata.sceneobject function_6cf39bfd67cda93a(shotindex);

      if(tweenin > 0) {
        viewmodelvisible = sceneobjectdata.sceneobject function_a8485c8c63aa2cc3(shotindex);
        stopxcam = sceneobjectdata.sceneobject function_4040a1e0bb19e02f(shotindex);

        function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x16f>" + sceneobjectdata.entity getentitynumber(), sceneobjectdata.entity.origin, sceneobjectdata.entity.angles);

        sceneobjectdata.entity function_bb60d8e77392c74e(0, tweenin, !istrue(viewmodelvisible), stopxcam);
      }
    }
  }

  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectSetup");

  if(isDefined(typefunc) && typefunc != &function_770c0b047ce9cfc1) {
    sceneobjectdata[[typefunc]](shotindex);
  }
}

function private function_d82945c5509ec28e(shotindex) {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectLinkSetup");

  if(isDefined(typefunc) && typefunc != &function_d82945c5509ec28e) {
    return sceneobjectdata[[typefunc]](shotindex);
  }

  return 1;
}

function private function_a477eb91dc3b38b8(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    sceneobjectdata.entity val::reset_all("scene_shot");

    if(isPlayer(sceneobjectdata.entity)) {
      tweenout = sceneobjectdata.sceneobject function_be64404b86d48153(shotindex);

      if(tweenout > 0) {
        viewmodelvisible = sceneobjectdata.sceneobject function_c5c4ac51272db146(shotindex);
        stopxcam = sceneobjectdata.sceneobject function_51bd4cd630963c3a(shotindex);

        function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x180>" + sceneobjectdata.entity getentitynumber(), sceneobjectdata.entity.origin, sceneobjectdata.entity.angles);

        sceneobjectdata.entity function_bb60d8e77392c74e(1, tweenout, !istrue(viewmodelvisible), stopxcam);
      }
    }
  }

  if(isent(sceneobjectdata.entity)) {
    sceneobjectdata.entity notify("scene_shot_cleanup");
  }

  sceneobjectdata notify("scene_shot_cleanup");
  typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectCleanup");

  if(isDefined(typefunc) && typefunc != &function_a477eb91dc3b38b8) {
    sceneobjectdata[[typefunc]](shotindex);
  }
}

function private function_6c3d100538f590b3(shotindex) {
  sceneobjectdata = self;
  sceneobject = sceneobjectdata.sceneobject;
  cameraanimation = sceneobject.variant_object.shots[shotindex].cameraanimation;

  if(isDefined(cameraanimation) && cameraanimation == "") {
    cameraanimation = undefined;
  }

  return cameraanimation;
}

function private function_7f90ebd0aa7ad958(shotindex) {
  sceneobjectdata = self;
  sceneobject = sceneobjectdata.sceneobject;
  var_f403b8bef0c4a943 = sceneobject function_1d5820595bc2d310(shotindex);
  var_badc9307ea231fbe = !istrue(sceneobject.variant_object.var_adbd47886f23e1a2);
  return var_f403b8bef0c4a943 && var_badc9307ea231fbe;
}

function private function_5a65e42126f29a4f(shotindex, overridetype, overridevalue) {
  sceneobjectdata = self;
  sceneobjectdata.shotoverrides = default_to(sceneobjectdata.shotoverrides, []);
  sceneobjectdata.shotoverrides[overridetype] = default_to(sceneobjectdata.shotoverrides[overridetype], []);
  sceneobjectdata.shotoverrides[overridetype][shotindex] = overridevalue;
}

function private function_a680ab1ba5753613(shotindex, overridetype) {
  sceneobjectdata = self;
  assert(isint(shotindex));

  if(!isDefined(sceneobjectdata.shotoverrides)) {
    return undefined;
  }

  if(!isDefined(sceneobjectdata.shotoverrides[overridetype])) {
    return undefined;
  }

  return sceneobjectdata.shotoverrides[overridetype][shotindex];
}

function private function_225d78e3c485a7ae(shotindexes, sceneplay, sceneobjectindex) {
  sceneobjectdata = self;
  scenedata = sceneobjectdata.scenedata;
  scenestatic = sceneobjectdata.sceneroot.scenestatic;

  if(sceneobjectdata.sceneobject function_cb6926d352c405c7()) {
    return 0;
  }

  if(isDefined(scenestatic) && istrue(scenestatic.excludeplayers) && sceneobjectdata object_get_type() == "Types_Player") {
    return 0;
  }

  if(isDefined(scenestatic) && isDefined(scenestatic.var_8f28f8f196c70a58) && scenestatic.var_8f28f8f196c70a58 && sceneobjectdata object_get_type() != "Types_Player") {
    return 0;
  }

  if(!isarray(shotindexes)) {
    shotindexes = [shotindexes];
  }

  result = 0;

  foreach(shotindex in shotindexes) {
    doeshide = sceneobjectdata.sceneobject function_7a553773a0af8bcd(shotindex);
    doesshow = sceneobjectdata.sceneobject function_8ed9853e35162b7c(shotindex);
    animated = sceneobjectdata.sceneobject function_938cdb6ca25882fc(shotindex);

    if(!animated || doeshide || doesshow) {
      if(isDefined(sceneplay) && isDefined(sceneobjectindex)) {
        if(!isDefined(sceneplay.var_7038c2a13f1f5db8[sceneobjectindex])) {
          sceneplay.var_7038c2a13f1f5db8[sceneobjectindex] = [];
        }

        sceneplay.var_7038c2a13f1f5db8[sceneobjectindex][shotindex] = 1;
        result = 1;
      } else {
        return 1;
      }

      continue;
    }

    shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);
    cameraanimation = sceneobjectdata function_6c3d100538f590b3(shotindex);

    if(shotanimations.size != 0 || isDefined(cameraanimation)) {
      if(isDefined(sceneplay) && isDefined(sceneobjectindex)) {
        if(!isDefined(sceneplay.var_7038c2a13f1f5db8[sceneobjectindex])) {
          sceneplay.var_7038c2a13f1f5db8[sceneobjectindex] = [];
        }

        sceneplay.var_7038c2a13f1f5db8[sceneobjectindex][shotindex] = 1;
        result = 1;
        continue;
      }

      return 1;
    }
  }

  return result;
}

function private object_get_type() {
  sceneobjectdata = self;
  return sceneobjectdata.sceneobject function_c77857d663e8cfbe();
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

  if(isDefined(sceneobject.variant_object.xcompositemodelname)) {
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

  if(isDefined(sceneobject.variant_object.xcompositemodelname)) {
    return sceneobject.variant_object.xcompositemodelname;
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
  return istrue(sceneobject.variant_object.strictmatching);
}

function private function_79edcc9987330a2a(shotindex) {
  sceneobject = self;
  animations = [];
  objtype = sceneobject function_c77857d663e8cfbe();

  switch (objtype) {
    case #"hash_873689dd62a87ffa":
      shotanimations = sceneobject.variant_object.shots[shotindex].mayhemanimations;

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
      shotanimations = sceneobject.variant_object.shots[shotindex].mayhemanimations;

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
  return default_to(shotobject.demeanorstart, "DEFAULT");
}

function private function_b56c0812b975be8(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.demeanorend, "DEFAULT");
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
  return default_to(shotobject.usetagangles, 1);
}

function private function_20e9c3d094691efe(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return istrue(shotobject.autocenter);
}

function private function_b083c5862877c8e3(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.float_viewfraction, 1);
}

function private function_c2a0ad9229a93162(shotindex) {
  sceneobject = self;
  shotobject = sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.noanimwait, 0);
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
  return default_to(shotobject.cameratweeninstopxcam, 0);
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
  return default_to(shotobject.cameratweenoutstopxcam, 0);
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
  sceneobjectdata = self;
  entity = undefined;
  sceneobjectassettype = sceneobjectdata.sceneobject function_992de34e05c5cea7();
  sceneobjectassetname = sceneobjectdata.sceneobject function_12eb9fd56334261c();

  if(sceneobjectassettype == "vehicle") {
    entity = spawnVehicle(vehicle_modelname(sceneobjectassetname), "scene_system_vehicle", sceneobjectassetname, spawnorigin, spawnangles);

    if(isDefined(entity)) {
      entity useanimtree(sceneobjectdata.sceneobject function_c106523f3836b90b());
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
  sceneobjectdata = self;
  vehicle = sceneobjectdata.entity;

  if(isDefined(vehicle) && vehicle vehicle_isphysveh()) {
    vehicle vehphys_forcekeyframedmotion();
  }
}

function private function_69abf08346f3f6d9() {
  scenescriptbundle = self;
  sceneobjectcount = scenescriptbundle function_291cd2f1089d3a94();

  for(sceneobjectindex = 0; sceneobjectindex < sceneobjectcount; sceneobjectindex++) {
    sceneobject = scenescriptbundle function_bfc4196d3da11705(sceneobjectindex);
    sceneobjectassettype = sceneobject function_992de34e05c5cea7();
    sceneobjectassetname = sceneobject function_12eb9fd56334261c();

    if(!isDefined(sceneobjectassetname)) {
      continue;
    }

    if(sceneobjectassettype == "aitype") {
      continue;
    }

    if(sceneobjectassettype == "character") {
      character = getxhash(sceneobjectassetname);

      if(isDefined(level.fncharacterprecache) && isDefined(level.fncharacterprecache[character])) {
        funcprecache = level.fncharacterprecache[character];
        level[[funcprecache]]();
      }

      continue;
    }

    if(sceneobjectassettype == "vehicle") {
      precachevehicle(sceneobjectassetname);
      modelname = vehicle_modelname(sceneobjectassetname);

      if(modelname != "") {
        precachemodel(modelname);
      }

      continue;
    }

    precachemodel(sceneobjectassetname);
  }
}

function private function_ab3ec43370c405d2(sceneroot, shotindex, objectindex) {
  scenescriptbundle = self;
  alignmentinfo = spawnStruct();
  alignmentinfo.aligntarget = undefined;
  alignmentinfo.aligntag = undefined;
  alignmentinfo.alignent = undefined;
  alignmentinfo.alignobjectindex = undefined;
  alignmentinfo.originoffset = (0, 0, 0);
  alignmentinfo.anglesoffset = (0, 0, 0);
  alignmentinfo.shotindex = shotindex;
  shot = scenescriptbundle function_2218afa82a590ea3(shotindex);
  sceneobject = scenescriptbundle function_bfc4196d3da11705(objectindex);
  shotobject = sceneobject.variant_object.shots[shotindex];
  aligncheck = [shotobject, sceneobject.variant_object, shot.variant_object, scenescriptbundle];

  for(aligncheckindex = 0; aligncheckindex < aligncheck.size; aligncheckindex++) {
    alignobj = aligncheck[aligncheckindex];

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
        alignmentinfo.alignobjectindex = var_aecf57ef77b2c2e6.index;
      }
    }

    if(!isDefined(aligntarget) && isDefined(level.struct_class_names)) {
      aligntarget = function_9b40ea5276506411(alignmentinfo.aligntarget);

      if(isDefined(aligntarget) && isDefined(aligntarget.sceneobjectdata)) {
        alignmentinfo.alignobjectindex = aligntarget.sceneobjectdata.index;
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
  return istrue(scenescriptbundle.bool_letterbox);
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

function private function_e1e718bbc3eb9fd2(shotname) {
  scenescriptbundle = self;

  foreach(index, shot in scenescriptbundle.shots) {
    if(!isDefined(shotname)) {
      return index;
    }

    if(shot.variant_object.name == shotname) {
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
  foundshotindex = undefined;
  shotcount = scenescriptbundle function_d1338e27a26ecaeb();

  for(shotindex = 0; shotindex < shotcount; shotindex++) {
    shot = scenescriptbundle function_2218afa82a590ea3(shotindex);

    if(shot function_55042076624e1180() == shotname) {
      foundshotindex = shotindex;
      break;
    }
  }

  return foundshotindex;
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

function private mayhem_spawn(alignmentinfo, shotinit) {}

function private function_d4f1b2dce50c7b7(shotindex) {
  sceneobjectdata = self;

  if(sceneobjectdata.sceneobject function_7a553773a0af8bcd(shotindex)) {
    if(!isDefined(sceneobjectdata.mayhemname)) {
      sceneobjectdata function_532562ce2e63032f(sceneobjectdata.alignmentinfo);
    }

    if(isDefined(sceneobjectdata.mayhemname)) {
      hidemayhem(sceneobjectdata.mayhemname);
    }
  }

  if(sceneobjectdata.sceneobject function_8ed9853e35162b7c(shotindex)) {
    if(!isDefined(sceneobjectdata.mayhemname)) {
      sceneobjectdata function_532562ce2e63032f(sceneobjectdata.alignmentinfo);
    }

    if(isDefined(sceneobjectdata.mayhemname)) {
      showmayhem(sceneobjectdata.mayhemname);
    }
  }
}

function private function_532562ce2e63032f(alignmentinfo, shotindex) {
  sceneobjectdata = self;
  shotindex = default_to(shotindex, sceneobjectdata.sceneplay.shotinit);
  shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);

  if(shotanimations.size != 0) {
    sceneobjectdata function_d0ffa1bea912444d(sceneobjectdata.sceneplay.shotinit, "mayhem", alignmentinfo, shotanimations[0], 0, 0, 0, "MayhemAnimation");
    pausemayhem(sceneobjectdata.mayhemname);
  }
}

function private function_d0ffa1bea912444d(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  sceneobjectdata = self;
  sceneobjectdata mayhem_delete();

  if(!isDefined(level.scene.mayhemindex)) {
    level.scene.mayhemindex = 0;
  }

  level.scene.mayhemindex++;
  sceneobjectdata.mayhemname = sceneobjectdata.sceneroot.script_scenescriptbundle + "_mayhem" + level.scene.mayhemindex;
  function_e4fc30ccdca08b9d(alignmentinfo);
  animlengths = sceneobjectdata.sceneobject function_698798987ca7073(shotindex);

  if(animlengths.size == 0) {
    return;
  }

  spawnmayhem(sceneobjectdata.mayhemname, animasset, alignmentinfo.origin, alignmentinfo.angles);
  waittill_match_or_timeout(notifystring, "end", animlengths[animindex]);
}

function private function_94d19635a2c1b723() {
  sceneobjectdata = self;
  sceneobjectdata mayhem_delete();
}

function private mayhem_delete() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.mayhemname)) {
    killmayhem(sceneobjectdata.mayhemname);
    sceneobjectdata.mayhemname = undefined;
  }
}

function private xcam_spawn(alignmentinfo, shotinit) {
  sceneobjectdata = self;
  scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
  letterbox = scenescriptbundle function_cf67ad1bae22e908();

  if(letterbox) {
    foreach(player in level.players) {
      player function_e7257014ebaeeaa8(1);
    }
  }
}

function private function_371c152f2c391c55(shotindex) {
  sceneobjectdata = self;
  tweenin = sceneobjectdata.sceneobject function_6cf39bfd67cda93a(shotindex);

  if(tweenin > 0) {
    foreach(player in level.players) {
      player val::set("scene_scene" + "_xcam", "cinematic_motion", 0);
      stopxcam = sceneobjectdata.sceneobject function_4040a1e0bb19e02f(shotindex);

      function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x16f>" + player getentitynumber(), player.origin, player.angles);

      player function_bb60d8e77392c74e(0, tweenin, 1, stopxcam);
    }
  }
}

function private function_2db9cd1521705174(shotindex) {
  sceneobjectdata = self;
  tweenout = sceneobjectdata.sceneobject function_be64404b86d48153(shotindex);

  if(tweenout > 0) {
    foreach(player in level.players) {
      player val::reset_all("scene_scene" + "_xcam");
      stopxcam = sceneobjectdata.sceneobject function_51bd4cd630963c3a(shotindex);

      function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x180>" + player getentitynumber(), player.origin, player.angles);

      player function_bb60d8e77392c74e(1, tweenout, 1, stopxcam);
    }
  }
}

function private function_d6ce74b74dc12311(alignmentinfo, shotindex) {}

function private function_90e78898cf74b132(sceneplay, shotindex) {
  sceneobjectdata = self;
  sceneobjectdata function_e4fc30ccdca08b9d(sceneobjectdata.alignmentinfo);

  if(isDefined(sceneobjectdata.alignmentinfo)) {
    cameraanimation = sceneobjectdata function_6c3d100538f590b3(shotindex);

    if(isDefined(cameraanimation)) {
      foreach(player in level.players) {
        streamcameraorigin = player getxcamposition(cameraanimation, 0, 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles);

        if(isDefined(streamcameraorigin)) {
          function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x164>", streamcameraorigin, (0, 0, 0));

          sceneplay function_317afd3b93b0b54d(player, streamcameraorigin);
        }
      }
    }
  }
}

function private function_7ce890b54a48b767(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  sceneobjectdata = self;
  sceneobjectdata xcam_delete();
  function_e4fc30ccdca08b9d(alignmentinfo);
  sceneobjectdata endon("scene_stop");
  sceneobjectdata endon("scene_play_anim");
  sceneobjectdata.xcamplaying = 1;

  foreach(player in level.players) {
    sceneobjectdata childthread function_bae0f68830d519ad("scene_shot_xcam", player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex);
  }

  waittime = function_c55e2627715b3a72(animasset, var_866b3a3066122e39);

  if(getxcamlooping(animasset)) {
    sceneobjectdata waittillmatch(notifystring, "end");
  } else if(waittime > 0) {
    sceneobjectdata waittill_match_or_timeout(notifystring, "end", waittime);
  }

  foreach(player in level.players) {
    player val::reset_all("scene_shot_xcam");
  }

  return waittime;
}

function private function_bae0f68830d519ad(valgroup, player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex) {
  sceneobjectdata = self;
  assert(isPlayer(player));
  player endon("death");

  function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x192>" + shotindex, alignmentinfo.origin, alignmentinfo.angles);

  waittime = 0;
  player val::set(valgroup, "cg_drawcrosshair", 0);
  player val::set(valgroup, "freezecontrols", 1);

  if(animasset != "") {
    starttime = 0;

    if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
      starttime = getxcamlength(animasset) * var_866b3a3066122e39;
    }

    var_be9e9d8d5ea874f9 = !sceneobjectdata.sceneobject function_cef37972e99fd713(shotindex);
    var_a9eb89bfa3d96107 = function_9f853ecc68f5058();
    thirdpersonplayer = sceneobjectdata.sceneobject function_f0f9db1f4b0000f4(shotindex);
    player notify("scene_play_xcam");

    if(isent(alignmentinfo.alignent)) {
      player playxcamontag(animasset, 0, alignmentinfo.alignent, default_to(alignmentinfo.aligntag, ""), starttime, 1, var_be9e9d8d5ea874f9, var_a9eb89bfa3d96107, thirdpersonplayer);
    } else {
      player playxcam(animasset, 0, alignmentinfo.origin, alignmentinfo.angles, starttime, 1, var_be9e9d8d5ea874f9, var_a9eb89bfa3d96107, thirdpersonplayer);
    }

    if(getxcamlooping(animasset)) {
      sceneobjectdata waittillmatch(notifystring, "end");
    } else {
      waittime = function_c55e2627715b3a72(animasset, var_866b3a3066122e39);

      if(waittime > 0) {
        sceneobjectdata waittill_match_or_timeout(notifystring, "end", waittime);
      }
    }

    player notify("scene_play_xcam_done");
  }

  return waittime;
}

function private function_c55e2627715b3a72(animasset, var_866b3a3066122e39) {
  cameraanimationtime = getxcamlength(animasset);
  starttime = 0;

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
    starttime = cameraanimationtime * var_866b3a3066122e39;
    cameraanimationtime -= starttime;
  }

  return cameraanimationtime;
}

function private function_fe644d526883b9b4(alignmentinfo, animasset, notifystring, var_866b3a3066122e39, var_1cbffacca2bd0d4c, animationtype) {}

function private function_544bbcb14d370c45() {
  sceneobjectdata = self;
  sceneobjectdata xcam_delete();
}

function private xcam_delete() {
  sceneobjectdata = self;
  scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
  letterbox = scenescriptbundle function_cf67ad1bae22e908();

  foreach(player in level.players) {
    player stopxcam();
    player val::reset_all("scene_shot_xcam");

    if(letterbox) {
      player function_e7257014ebaeeaa8(0);
    }
  }

  sceneobjectdata.xcamplaying = undefined;
}

function private function_a9acafbfcda23112(entity) {
  return false;
}

function private xcam_cleanup(newsceneroot) {
  sceneobjectdata = self;
  sceneobjectdata xcam_delete();
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

function private function_5ecd1fd13181af98(notifystring, notifyitem, sceneobjectdata) {
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
  sceneobjectdata = self;
  sceneroot = sceneplay.sceneroot;

  if(isDefined(sceneobjectdata.entity)) {
    aientity = sceneobjectdata.entity;
    demeanorstart = sceneobjectdata.sceneobject function_1b712c4c79096ef9(shotindex);
    locomotionstart = sceneobjectdata.sceneobject function_8f11c2704d4c19c3(shotindex);

    if(demeanorstart != "DEFAULT") {
      aientity val::set("scene_shot", "demeanor", demeanorstart);
    }

    if(sceneobjectdata function_e0c309a786687925(shotindex)) {
      aientity val::set("scene_shot", "take_weapons", 1);
    }

    if(isDefined(sceneobjectdata.scenedata.var_43286fd46706909c)) {
      return;
    }

    reachtype = sceneobjectdata.sceneobject function_8b6dcfac0d2921ad(shotindex);

    if(reachtype != "Teleport" && istrue(sceneobjectdata.existingentity)) {
      scenedata = sceneroot.scenedata;
      animasset = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex)[0];

      if(isDefined(animasset)) {
        function_e4fc30ccdca08b9d(sceneobjectdata.alignmentinfo);
        animstartorigin = getstartorigin(sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles, animasset);

        if(distancesquared(aientity.origin, animstartorigin) > squared(16)) {
          typefunc = sceneobjectdata function_8a786f133d7341c0("shotObjectStopAnim");

          if(isDefined(typefunc) && typefunc != &function_9b8055c613f1bb31) {
            sceneobjectdata[[typefunc]]();
          }

          speed_baseline = reach_speed(demeanorstart, locomotionstart);
          arrivaltype = undefined;

          if(reachtype == "ReachArrive") {
            arrivaltype = function_796087cbcf3fb30(sceneobjectdata.sceneobject function_ceabc6a1e0fac4cf(shotindex));
          }

          function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x198>", sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles);

          sceneroot childthread scene_coordinated_reach(sceneplay, shotindex, speed_baseline, [aientity, animasset, sceneobjectdata.alignmentinfo, arrivaltype]);
          aientity waittill_any_2("scene_coordinated_reach", "death");
        }
      }
    }
  }
}

function private function_e0c309a786687925(shotindex) {
  sceneobjectdata = self;
  sceneobject = sceneobjectdata.sceneobject;
  shotobject = sceneobject.variant_object.shots[shotindex];
  actor_weapon = sceneobjectdata.entity.weapon;
  var_fffc453ca4f78b1c = isDefined(actor_weapon) && !isnullweapon(actor_weapon);
  var_80db383140a106e8 = istrue(shotobject.removeweapon);
  var_1dc8da8f86fd9a5b = istrue(sceneobject.variant_object.removeweapon);

  if((var_80db383140a106e8 || var_1dc8da8f86fd9a5b) && var_fffc453ca4f78b1c) {
    return true;
  }

  return false;
}

function private function_89c29980d9b0ebe() {
  sceneobjectdata = self;
  assert(isai(sceneobjectdata.entity));
  sceneobjectdata.entity endon("death");
  sceneobjectdata endon("scene_ai_stealth");

  while(true) {
    lookatplayer = sceneobjectdata.entity function_47dbe773d9a4572f(0.25);

    if(isDefined(lookatplayer) && (!isDefined(sceneobjectdata.var_63dd238417ee222c) || sceneobjectdata.var_63dd238417ee222c != lookatplayer)) {
      sceneobjectdata.var_63dd238417ee222c = lookatplayer;
      sceneobjectdata.entity scripts\common\ai_lookat::enablelookatentity(sceneobjectdata.var_63dd238417ee222c);
    } else if(isDefined(sceneobjectdata.var_63dd238417ee222c)) {
      sceneobjectdata.entity scripts\common\ai_lookat::disablelookatentity(sceneobjectdata.var_63dd238417ee222c);
      sceneobjectdata.var_63dd238417ee222c = undefined;
    }

    waitframe();
  }
}

function private function_81f89576d8f466b4() {
  sceneobjectdata = self;
  assert(isai(sceneobjectdata.entity));
  sceneobjectdata.entity endon("death");
  sceneobjectdata endon("scene_ai_stealth");

  while(true) {
    sceneobjectdata.entity waittill("ai_events", events);

    foreach(event in events) {
      sceneobjectdata function_bdd631983c9e6f5c();
      sceneobjectdata function_9b8055c613f1bb31();
      sceneobjectdata thread object_cleanup();
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
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectStoreAnimRequest");

  if(isDefined(typefunc)) {
    sceneobjectdata[[typefunc]](shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype);
  }
}

function private function_68056529c69f4097(animationtype, shotindex, animindex) {
  sceneobjectdata = self;
  typefunc = sceneobjectdata function_8a786f133d7341c0("objectClearAnimRequest");

  if(isDefined(typefunc)) {
    sceneobjectdata[[typefunc]](animationtype, shotindex, animindex);
  }
}