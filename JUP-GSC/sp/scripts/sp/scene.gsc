/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\scene.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\scene;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\fakeactor;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#namespace scene;

function private autoexec function_5f517f216d006d36() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  function_ace39e84230f386();
  function_9d3850b024ab89b1("modeLetterbox", &function_f6623635176f0b97);
  function_7855ec4caf5901f9("Types_Object", "shotObjectPlayAnim", &function_70b41a355929bc17);
  function_7855ec4caf5901f9("Types_Object", "shotObjectStopAnim", &function_cca29832342e0a31);
  function_7855ec4caf5901f9("Types_Object", "objectGetAnimRoot", &function_d63c9b1154a8be6);
  function_7855ec4caf5901f9("Types_Object", "objectWaitNotes", &function_5ace47d8b41f84c2);
  function_7855ec4caf5901f9("Types_Player", "objectSetup", &player_setup);
  function_7855ec4caf5901f9("Types_Player", "shotObjectSetup", &function_fbcd130e311a767f);
  function_7855ec4caf5901f9("Types_Player", "objectSetAnimName", &function_24b6b2bfc5bdab36);
  function_7855ec4caf5901f9("Types_Player", "objectMatchEntity", &function_c29e618edeaa7720);
  function_7855ec4caf5901f9("Types_Player", "objectGetAnimEntity", &function_e6e53745b22ae909);
  function_7855ec4caf5901f9("Types_Player", "objectGetLinkEnts", &function_9f8add72acb9b1f6);
  function_7855ec4caf5901f9("Types_Player", "objectVelocity", &player_velocity);
  function_7855ec4caf5901f9("Types_Player", "shotObjectPlayAnim", &function_a57d915bb947515);
  function_7855ec4caf5901f9("Types_Player", "shotObjectStopAnim", &function_e477b4837d3fc6a7);
  function_7855ec4caf5901f9("Types_Player", "shotObjectAnimEnd", &function_3efb11b3bc18a9c6);
  function_7855ec4caf5901f9("Types_Player", "objectCleanup", &player_cleanup);
  function_7855ec4caf5901f9("Types_Player", "objectDelete", &player_delete);
  function_7855ec4caf5901f9("Types_Player", "objectSetAnimRate", &function_c655258c05f2383c);
  function_7855ec4caf5901f9("Types_Player", "objectSetAnimTime", &function_3e11215cec07f917);
  function_7855ec4caf5901f9("Types_Actor", "objectSpawn", &actor_spawn);
  function_7855ec4caf5901f9("Types_Actor", "objectSetup", &actor_setup);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectPrepare", &function_9e7b86e7070de40f);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectSetup", &function_451712661ab10691);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectLinkSetup", &function_9acdf50d8ceba89e);
  function_7855ec4caf5901f9("Types_Actor", "objectMatchEntity", &function_62d306b8ddab4726);
  function_7855ec4caf5901f9("Types_Actor", "objectTeleport", &actor_teleport);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectFirstFrame", &function_f05b1eb6b24263b5);
  function_7855ec4caf5901f9("Types_Actor", "objectSetAnimRate", &function_9b5a56bdfebe61d6);
  function_7855ec4caf5901f9("Types_Actor", "objectSetAnimTime", &actor_set_anim_time);
  function_7855ec4caf5901f9("Types_Actor", "objectSetAnimLerp", &function_d3d0a7ea23cbe6d);
  function_7855ec4caf5901f9("Types_Actor", "objectSetAnimPlaying", &actor_set_anim_playing);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectCleanup", &function_4a2b39e903062a08);
  function_7855ec4caf5901f9("Types_Actor", "objectCleanup", &actor_cleanup);
  function_7855ec4caf5901f9("Types_Actor", "objectKill", &actor_kill);
  function_7855ec4caf5901f9("Types_Actor", "objectCanAnimate", &function_dd4e63bb65c5102d);
  function_7855ec4caf5901f9("Types_FakeActor", "objectSpawn", &function_fb3ea231a7df2bf2);
  function_7855ec4caf5901f9("Types_FakeActor", "objectMatchEntity", &function_aa6788c9ed21c842);
  function_7855ec4caf5901f9("Types_FakeActor", "shotObjectPrepare", &function_f07b0cbbb739527b);
  function_7855ec4caf5901f9("Types_FakeActor", "shotObjectCleanup", &function_aaa12a8607a888a4);
  function_7855ec4caf5901f9("Types_FakeActor", "objectCleanup", &function_b76ec219f2a45811);
  function_5a197e7b54a9091e();

  if(!isDefined(level.scr_animtree) || !isDefined(level.scr_animtree["player_rig"])) {
    gamemodebundle = function_1e231fc15fdab31d();

    if(isDefined(gamemodebundle) && isDefined(gamemodebundle.var_8ec20071f762ea35)) {
      scripts\sp\player_rig::init_player_rig(gamemodebundle.var_8ec20071f762ea35, undefined, gamemodebundle.var_6c2ad496230d88b9);
    } else {
      scripts\sp\player_rig::init_player_rig("viewhands_base_iw8", undefined, "viewhands_base_fullbody_iw8");
    }
  }

  level thread function_e16b1ab0a35605d3("load_finished");
}

function private function_cfe0d1ffc4e09be5(entity, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  var_214d924f4e137244 = self;

  if(!isDefined(entity)) {
    return;
  }

  animlengthtime = 0;
  animrate = undefined;
  done = 0;

  if(isDefined(var_214d924f4e137244.sceneroot.scenestatic)) {
    animrate = var_214d924f4e137244.sceneroot.scenestatic.animrate;
  }

  var_866b3a3066122e39 = default_to(var_866b3a3066122e39, 0);
  lerptime = default_to(lerptime, 0);
  blendtime = default_to(blendtime, 0.2);
  root = var_214d924f4e137244 function_b9c245bf99df4a8();

  if(entity.model == "") {
    println("<dev string:x1c>" + var_214d924f4e137244.sceneobject function_aeb2b46911a5811d() + "<dev string:x4c>");
    return 0;
  }

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
    blendtime = 0;
    lerptime = 0;
  }

  function_e4fc30ccdca08b9d(alignmentinfo);

  if(!var_214d924f4e137244 function_744a16ccecd8e4dd()) {
    return 0;
  }

  startorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
  startangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);

  if(lerptime <= 0) {
    var_214d924f4e137244 object_teleport(startorigin, startangles);
  } else {
    angledelta = anglesdelta(entity.angles, startangles);
    entity.anglelerprate = angledelta / lerptime;
  }

  if(var_866b3a3066122e39 < 1) {
    var_214d924f4e137244 childthread function_8e9f8e1fbe2b7ab4(notifystring, animasset);
  }

  entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, root, blendtime);
  var_2b6a8cc75ce67f16 = is_equal(animasset, var_214d924f4e137244.var_a3ff79ae166c57aa);
  var_214d924f4e137244 function_bdfc45b799d27532(animasset);
  var_214d924f4e137244 thread function_bf2f06d70b4e15ad(1);

  if(isDefined(lerptime) && lerptime > 0) {
    var_214d924f4e137244 childthread function_db16fb604c5ca71d(lerptime, var_214d924f4e137244 object_velocity());
  }

  if(isDefined(blendcurve) && blendtime > 0) {
    entity setanimblendcurve(animasset, blendcurve);
  }

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0 && var_866b3a3066122e39 <= 1) {
    if(var_866b3a3066122e39 == 1 && function_8581f011ce975a6(animasset)) {
      var_866b3a3066122e39 = 0.999;
    }

    var_214d924f4e137244 function_380708345e16e475(animasset, var_866b3a3066122e39);
  } else if(istrue(var_2b6a8cc75ce67f16)) {
    var_214d924f4e137244 function_380708345e16e475(animasset, 0);
  }

  var_214d924f4e137244 function_6a4d64bdba27cb06(animrate);

  if(var_866b3a3066122e39 < 1) {
    entity function_ee012c2dd711a8ce(notifystring, "end", "stop_animmode");
  }

  animlengthtime += getanimlength(animasset);
  return animlengthtime - var_866b3a3066122e39 * animlengthtime;
}

function private function_70b41a355929bc17(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  var_214d924f4e137244 = self;
  anim_entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();
  assert(default_to(animationtype, "DeltaAnimation") == "DeltaAnimation");
  animplaybacktime = var_214d924f4e137244 function_cfe0d1ffc4e09be5(anim_entity, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
  return animplaybacktime;
}

function private function_cca29832342e0a31() {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity scripts\engine\sp\utility::anim_stopanimScripted();
  }
}

function private function_d63c9b1154a8be6() {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();
  root = undefined;

  if(isai(entity) || entity scripts\sp\fakeactor::is_fakeactor()) {
    root = entity asm_getbodyknob();
  } else if(isDefined(entity.anim_getrootfunc)) {
    root = [[entity.anim_getrootfunc]]();
  }

  if(isDefined(entity.asm) && !isai(entity)) {
    entity asm_animScripted();
  }

  return root;
}

function private function_5ace47d8b41f84c2(notifystring, animasset) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  var_214d924f4e137244 childthread start_notetrack_wait(entity, notifystring, undefined, undefined, animasset);
  var_214d924f4e137244 childthread animscriptdonotetracksthread(entity, notifystring, undefined);
}

function private player_setup(sceneplay) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.playerrigs = var_214d924f4e137244 function_11f0b522fd79c07b();
}

function private function_fbcd130e311a767f(shotindex) {
  var_214d924f4e137244 = self;

  if(isPlayer(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity delaycall(0.1, &clearplayerhintlock);
    var_214d924f4e137244.entity val::set("scene_scene", "cinematic_motion", 0);
    var_214d924f4e137244.entity val::set("scene_scene", "show_legs_and_shadow", 0);

    if(var_214d924f4e137244 function_8186a93a774b5977() == "Scene_Model") {
      if(!isDefined(var_214d924f4e137244.var_d4981703521d992)) {
        var_214d924f4e137244.var_d4981703521d992 = [];

        foreach(rig in var_214d924f4e137244.playerrigs) {
          var_214d924f4e137244.var_d4981703521d992[animname] = rig.model;
        }
      }

      model = var_214d924f4e137244.sceneobject function_12eb9fd56334261c();
      scripts\sp\player_rig::init_player_rig_no_precache(model);
    }
  }
}

function private function_24b6b2bfc5bdab36(animname, animtree) {
  var_214d924f4e137244 = self;
}

function private function_c655258c05f2383c(animrate) {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.playerrigs)) {
    return;
  }

  foreach(rig in var_214d924f4e137244.playerrigs) {
    if(isDefined(rig) && isDefined(var_214d924f4e137244.activeanimation)) {
      rig setanimrate(var_214d924f4e137244.activeanimation, animrate);
    }
  }
}

function private function_3e11215cec07f917(animasset, timefrac) {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.playerrigs)) {
    return;
  }

  foreach(rig in var_214d924f4e137244.playerrigs) {
    if(isDefined(rig)) {
      rig setanimtime(animasset, timefrac);
      rig dontinterpolate();
    }
  }
}

function private function_c29e618edeaa7720(entity) {
  var_214d924f4e137244 = self;
  return isPlayer(entity);
}

function private function_11f0b522fd79c07b() {
  var_214d924f4e137244 = self;
  result = [];
  animtree = var_214d924f4e137244.sceneobject function_c106523f3836b90b();
  rigs = var_214d924f4e137244 scripts\sp\player_rig::function_8ded956fcab6f73a(0, 1, animtree);
  var_e7fa17ac3f0d00fd = var_214d924f4e137244 function_8186a93a774b5977();

  switch (var_e7fa17ac3f0d00fd) {
    case #"hash_f900f466f5425fa7":
      result["player_rig"] = rigs["player_rig"];
      result["player_legs"] = rigs["player_legs"];
      break;
    case #"hash_cc1dcc1121d79906":
      result["player_rig"] = rigs["player_rig"];
      result["player_body"] = rigs["player_body"];
      break;
    case #"hash_a947444bcd267ab4":
      result = rigs;
      break;
    case #"hash_8619326cd6780be9":
    default:
      result["player_rig"] = rigs["player_rig"];
      break;
  }

  foreach(animname, rig in rigs) {
    if(result.size == 0) {
      result[animname] = rigs[animname];
    }

    if(!isDefined(result[animname])) {
      rig hide();
    }
  }

  return result;
}

function private function_5f3da76468742def() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.playerrigs)) {
    if(isDefined(var_214d924f4e137244.playerrigs["player_rig"])) {
      return var_214d924f4e137244.playerrigs["player_rig"];
    }

    foreach(rig in var_214d924f4e137244.playerrigs) {
      return rig;
    }
  }

  return undefined;
}

function private function_e6e53745b22ae909() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244 function_5f3da76468742def();
}

function private function_9f8add72acb9b1f6() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.playerrigs;
}

function private player_velocity() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.entity getvelocity();
}

function private function_a57d915bb947515(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;
  var_214d924f4e137244 endon("scene_stop");
  var_214d924f4e137244 endon("scene_play_anim");

  if(istrue(var_214d924f4e137244.sceneroot.scenedata.excludeplayer) || !isPlayer(player)) {
    var_214d924f4e137244 function_bf0d14daf3e53248(animasset, var_214d924f4e137244.var_41dc93404af773a3, notifystring);
    var_214d924f4e137244 function_68056529c69f4097(var_214d924f4e137244.var_41dc93404af773a3, shotindex, animindex);
    return 0;
  }

  var_409dc6bbf1421f94 = var_214d924f4e137244 function_5fe020a6db35fab3(shotindex);

  if(var_214d924f4e137244.var_41dc93404af773a3 == "CameraAnimation") {
    var_214d924f4e137244 thread object_play_anim_waittill_end(animasset, [player], "death", "CameraAnimation", notifystring);
    var_214d924f4e137244.xcamplaying = 1;
    player val::set_array("scene_shot", var_409dc6bbf1421f94, 0);
    return var_214d924f4e137244 function_bae0f68830d519ad("scene_shot", player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex);
  }

  animlengthtime = 0;
  rig = var_214d924f4e137244 function_5f3da76468742def();
  shotindex = var_214d924f4e137244.sceneplay.currentshot;
  stance = var_214d924f4e137244.sceneobject function_892812e26790e793(shotindex);
  blendtime = var_214d924f4e137244.sceneobject function_205f7afe5d801664(shotindex);
  arcright = var_214d924f4e137244.sceneobject function_918dc2e0c83784b6(shotindex);
  arcleft = var_214d924f4e137244.sceneobject function_16b4cb7e4c5af0fd(shotindex);
  arctop = var_214d924f4e137244.sceneobject function_b06da1547120edef(shotindex);
  arcbottom = var_214d924f4e137244.sceneobject function_be3310ec58dd9807(shotindex);
  var_562ff78798cbfcc8 = var_214d924f4e137244.sceneobject function_8851aea907b47f88(shotindex);
  restrictcamera = 0;
  autocenter = var_214d924f4e137244.sceneobject function_20e9c3d094691efe(shotindex);
  viewfraction = var_214d924f4e137244.sceneobject function_b083c5862877c8e3(shotindex);

  if(isDefined(var_214d924f4e137244.scenedata.var_43286fd46706909c)) {
    blendtime = 0;
    lerptime = 0;
  }

  scripts\sp\player_rig::set_player_rig_allows(var_409dc6bbf1421f94);

  if(getdvarint(@ "hash_54fd90073299424e")) {
    player thread scripts\common\scene_debug::function_c623b8e6e4b0a90("<dev string:x4e>", 20, getdvarint(@ "hash_54fd90073299424e"), lerptime);
    rig thread scripts\common\scene_debug::function_c623b8e6e4b0a90("<dev string:x4f>", 20, getdvarint(@ "hash_54fd90073299424e"));
    rig thread scripts\common\scene_debug::function_c623b8e6e4b0a90("<dev string:x5a>", 20, getdvarint(@ "hash_54fd90073299424e"));
  }

  if(!var_214d924f4e137244 function_829b387c84d7e2c0()) {
    var_ec96a350b2692ae9 = lerptime > 0;
    var_1c5d1595dab3ef39 = blendtime > 0;

    if(var_1c5d1595dab3ef39) {
      level.blendinfo["weaponDropTime"] = max(lerptime, blendtime) * 0.7;
    }

    linktag = var_214d924f4e137244 function_a89f1262c5148bdf();
    otherrigs = [];

    foreach(var_e079e7d4275a0ea5 in var_214d924f4e137244.playerrigs) {
      if(var_e079e7d4275a0ea5 == rig) {
        continue;
      }

      otherrigs[otherrigs.size] = var_e079e7d4275a0ea5;
    }

    var_214d924f4e137244.sceneroot childthread scripts\sp\player_rig::link_player_to_rig(undefined, stance, var_ec96a350b2692ae9, lerptime, restrictcamera, arcright, arcleft, arctop, arcbottom, var_562ff78798cbfcc8, undefined, undefined, undefined, var_1c5d1595dab3ef39, undefined, undefined, undefined, linktag, otherrigs);
  } else {
    foreach(rigent in var_214d924f4e137244.playerrigs) {
      rigent show();
    }

    if(!player function_68d997f850b153c7()) {
      player lerpviewangleclamp(lerptime, lerptime * 0.5, lerptime * 0.5, arcright, arcleft, arctop, arcbottom, 1);
    }

    player scripts\sp\player_rig::function_73341653f76b4e43();
  }

  if(lerptime <= 0) {
    if(!var_214d924f4e137244 function_285bdba488858f9e(shotindex)) {
      player dontinterpolate();
    }
  }

  var_214d924f4e137244.var_b3996565972e4ff0 = 1;

  if(var_214d924f4e137244 function_829b387c84d7e2c0() && !player isufo() && !player isnoclip()) {
    if(autocenter) {
      player springcamenabled(1);
    } else {
      player springcamdisabled(0.2);
    }

    player function_6b8a3855966e9ada(viewfraction);
  }

  var_214d924f4e137244 thread function_e0ade8dd368ad3a5();
  var_2c898415e2a1fcb1 = 0;

  foreach(var_e079e7d4275a0ea5 in var_214d924f4e137244.playerrigs) {
    if(var_e079e7d4275a0ea5 != rig) {
      var_214d924f4e137244 thread function_cfe0d1ffc4e09be5(var_e079e7d4275a0ea5, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, var_2c898415e2a1fcb1);
    }
  }

  animlengthtime = var_214d924f4e137244 function_cfe0d1ffc4e09be5(rig, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, var_2c898415e2a1fcb1);
  return animlengthtime;
}

function private function_e477b4837d3fc6a7() {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 function_2f2327d535ed0bb();
  var_214d924f4e137244 function_cca29832342e0a31();
}

function private function_3efb11b3bc18a9c6() {
  var_214d924f4e137244 = self;

  foreach(rig in var_214d924f4e137244.playerrigs) {
    if(isDefined(rig) && isDefined(var_214d924f4e137244.var_36831a04af11576f)) {
      foreach(message in var_214d924f4e137244.var_36831a04af11576f) {
        rig notify(message, "end");
      }
    }
  }

  if(isDefined(var_214d924f4e137244.entity) && isDefined(var_214d924f4e137244.var_36831a04af11576f)) {
    foreach(message in var_214d924f4e137244.var_36831a04af11576f) {
      var_214d924f4e137244.entity notify(message, "end");
    }
  }
}

function private player_cleanup(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 function_2f2327d535ed0bb();

  if(var_214d924f4e137244.playerrigs.size > 0) {
    rig = var_214d924f4e137244 function_5f3da76468742def();

    if(!isDefined(var_fa1af9d2277fd747)) {
      if(var_214d924f4e137244 function_829b387c84d7e2c0()) {
        stancebegin = var_214d924f4e137244.sceneobject function_892812e26790e793(var_214d924f4e137244.sceneplay.currentshot);
        stanceend = var_214d924f4e137244.sceneobject function_c3345343cc0eb8ab(var_214d924f4e137244.sceneplay.currentshot);
        immediatestance = default_to(rig.linktag, "tag_player") == "tag_camera";

        if(!is_equal(stancebegin, stanceend)) {
          immediatestance = 1;
        }

        childthread scripts\sp\player_rig::unlink_player_from_rig(0, stanceend, immediatestance, 1);
      }

      if(isPlayer(var_214d924f4e137244.entity) && istrue(var_214d924f4e137244.var_b3996565972e4ff0)) {
        var_214d924f4e137244.entity val::reset_all("player_rig");
        var_214d924f4e137244.var_b3996565972e4ff0 = undefined;
      }
    }

    foreach(rig in var_214d924f4e137244.playerrigs) {
      rig hide();
    }

    if(var_214d924f4e137244 function_8186a93a774b5977() == "Scene_Model" && isDefined(var_214d924f4e137244.var_d4981703521d992)) {
      scripts\sp\player_rig::init_player_rig_no_precache(var_214d924f4e137244.var_d4981703521d992["player_rig"], var_214d924f4e137244.var_d4981703521d992["player_legs"], var_214d924f4e137244.var_d4981703521d992["player_body"]);
      var_214d924f4e137244.var_d4981703521d992 = undefined;
    }
  }
}

function private player_delete() {}

function private function_8186a93a774b5977() {
  var_214d924f4e137244 = self;
  return default_to(var_214d924f4e137244.sceneobject.variant_object.var_4abe5bbb3e48b9fa, "Rig");
}

function private function_829b387c84d7e2c0() {
  var_214d924f4e137244 = self;
  rig = var_214d924f4e137244 function_5f3da76468742def();
  player = var_214d924f4e137244.entity;

  if(isDefined(player) && isDefined(rig)) {
    playerparent = player getlinkedparent();

    if(isDefined(playerparent) && playerparent == rig) {
      return true;
    }
  }

  return false;
}

#using_animtree("player");

function function_e0ade8dd368ad3a5() {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.playerrigs)) {
    return;
  }

  body = var_214d924f4e137244.playerrigs["player_body"];

  if(isDefined(body)) {
    if(!isDefined(var_214d924f4e137244.var_53c962747bd1f2f)) {
      var_214d924f4e137244 waittill("scene_anim_playing");
    }

    waittillframeend();

    if(getdvarint(@ "hash_d0761d5c3f9e3bf", 0)) {
      body setanim(%head_shoulder_hide, 0, 0);
      return;
    }

    body setanim(%head_shoulder_hide, 1, 0);
  }
}

function private function_fb3ea231a7df2bf2(spawnorigin, spawnangles) {
  var_214d924f4e137244 = self;
  var_373a2c3b02b1d81c = var_214d924f4e137244.sceneobject function_992de34e05c5cea7();
  var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject function_12eb9fd56334261c();
  entity = undefined;

  if(var_373a2c3b02b1d81c == "aitype") {
    entity = function_d9469562fdbb08bc("actor_" + var_6fc4d2978cf27bef, spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    entity = var_214d924f4e137244 function_3e19c1b49e591d34(spawnorigin, spawnangles);

    if(isDefined(entity)) {
      entity.team = "allies";
      entity.type = "human";
      entity.unittype = "soldier";
      var_214d924f4e137244.nosentient = 1;
    }
  }

  if(isDefined(entity)) {
    entity scripts\sp\spawner::function_7a2464dfda234e36();

    if(var_214d924f4e137244 function_5a831c826484d0fa() == "Sentient" && !istrue(var_214d924f4e137244.nosentient)) {
      var_214d924f4e137244 function_318f4852c1eb7c74(entity);
    }

    entity useanimtree(var_214d924f4e137244.sceneobject function_c106523f3836b90b());
  }

  return entity;
}

function private function_aa6788c9ed21c842(entity) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.nosentient = undefined;

  if(var_214d924f4e137244 function_5a831c826484d0fa() == "Sentient") {
    return istrue(entity.script_fakeactor);
  }

  return entity.classname == "script_model";
}

function private function_f07b0cbbb739527b(sceneplay, shotindex, objectindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    fakeactor = var_214d924f4e137244.entity;

    if(var_214d924f4e137244 function_e2bb6af4c53815a0()) {
      fakeactor scripts\sp\fakeactor::function_cc5fb4563e4cbd5d();
    }

    if(var_214d924f4e137244.sceneobject function_fc9281240877df76()) {
      if(var_214d924f4e137244 function_5a831c826484d0fa() == "Sentient" && !istrue(var_214d924f4e137244.nosentient)) {
        var_214d924f4e137244 function_318f4852c1eb7c74();
        fakeactor scripts\sp\fakeactor::set_use_pain(1);
      } else {
        var_214d924f4e137244 thread function_7e0dd853c6d00913();
      }
    } else {
      fakeactor scripts\sp\fakeactor::function_b4deaa96649c12db();
    }

    if(istrue(fakeactor.script_fakeactor)) {
      fakeactor scripts\sp\fakeactor::take_control();
    }

    if(var_214d924f4e137244 function_e0c309a786687925(shotindex)) {
      fakeactor val::set("scene_shot", "take_weapons", 1);
    }
  }
}

function private function_aaa12a8607a888a4(shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    fakeactor = var_214d924f4e137244.entity;

    if(istrue(fakeactor.script_fakeactor)) {
      fakeactor scripts\sp\fakeactor::release_control();
    }

    if(var_214d924f4e137244 function_e0c309a786687925(shotindex)) {
      fakeactor val::reset("scene_shot", "take_weapons");
    }
  }
}

function private function_b76ec219f2a45811(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    fakeactor = var_214d924f4e137244.entity;

    if(var_214d924f4e137244 function_e2bb6af4c53815a0()) {
      fakeactor scripts\sp\fakeactor::function_ca5cea9991fa5306();
    }
  }
}

function private function_318f4852c1eb7c74(entity) {
  var_214d924f4e137244 = self;
  entity = default_to(entity, var_214d924f4e137244.entity);

  if(isDefined(entity)) {
    fakeactor = entity;

    if(!isDefined(level.fakeactor_spawn_func)) {
      scripts\sp\fakeactor::fakeactor_spawner_init();
    }

    if(!istrue(fakeactor.script_fakeactor) && isDefined(level.fakeactor_spawn_func)) {
      fakeactor thread function_1fad0f895757885a();
    }
  }
}

function private function_7e0dd853c6d00913() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    fakeactor = var_214d924f4e137244.entity;

    if(!istrue(fakeactor.script_fakeactor)) {
      fakeactor scripts\sp\fakeactor::function_b247aabd62f70947();
    }
  }
}

function private function_5a831c826484d0fa() {
  var_214d924f4e137244 = self;
  return default_to(var_214d924f4e137244.sceneobject.variant_object.fakeactortype, "Drone");
}

function private function_e2bb6af4c53815a0() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.navrepulsor);
}

function private actor_spawn(spawnorigin, spawnangles) {
  var_214d924f4e137244 = self;
  var_373a2c3b02b1d81c = var_214d924f4e137244.sceneobject function_992de34e05c5cea7();
  var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject function_12eb9fd56334261c();
  entity = undefined;

  if(isactorspawner(var_214d924f4e137244.spawner)) {
    var_75c15e716113c51b = isDefined(var_214d924f4e137244.spawner.script_stealthgroup) && flag("stealth_enabled") && !flag("stealth_spotted");
    entity = var_214d924f4e137244.spawner stalingradspawn(var_75c15e716113c51b, 1);

    if(isDefined(entity)) {
      entity teleport(spawnorigin, spawnangles);
    }
  }

  if(!isDefined(entity)) {
    if(var_373a2c3b02b1d81c == "aitype") {
      entity = dospawnaitype("actor_" + var_6fc4d2978cf27bef, spawnorigin, spawnangles, 1, 0, 1, 1);

      if(isDefined(entity)) {
        entity thread scripts\sp\spawner::spawn_think();
      }
    } else if(var_373a2c3b02b1d81c == "character") {
      println("<dev string:x65>" + var_214d924f4e137244.sceneobject function_aeb2b46911a5811d() + "<dev string:x8f>" + var_6fc4d2978cf27bef + "<dev string:x4c>");
    }
  }

  if(isDefined(entity)) {
    entity useanimtree(var_214d924f4e137244.sceneobject function_c106523f3836b90b());
  }

  return entity;
}

function private actor_setup(sceneplay) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    actor = var_214d924f4e137244.entity;

    if(isDefined(actor.stealth) && isDefined(level.stealth)) {
      if(var_214d924f4e137244 function_62305a66a4f213b()) {
        var_214d924f4e137244 thread function_89c29980d9b0ebe();
      }

      if(var_214d924f4e137244 function_c811d75d62ab3b31()) {
        var_214d924f4e137244 thread function_81f89576d8f466b4();
      }
    }

    if(var_214d924f4e137244.sceneobject function_fc9281240877df76()) {
      actor.allowdeath = 1;
    }
  }
}

function private function_62d306b8ddab4726(entity) {
  var_214d924f4e137244 = self;
  return isactor(entity) && isalive(entity);
}

function private actor_teleport(origin, angles) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244.entity forceteleport(origin, angles);
}

function private function_f05b1eb6b24263b5(alignmentinfo, shotindex) {
  var_214d924f4e137244 = self;
  shotindex = default_to(shotindex, var_214d924f4e137244.sceneplay.shotinit);
  actor = var_214d924f4e137244.entity;
  deltaanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

  if(deltaanimations.size != 0 && isent(actor)) {
    animasset = deltaanimations[0];
    var_214d924f4e137244 function_cca29832342e0a31();
    origin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
    angles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);
    actor thread ai_anim_first_frame(animasset, actor.animname);

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x95>" + function_3c8848a3a11b2553(getanimname(animasset)), origin, angles);

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:xa2>" + function_3c8848a3a11b2553(getanimname(animasset)), alignmentinfo.origin, alignmentinfo.angles);

    actor function_ad9433aab9fcdf04(level.framedurationseconds, "scene_play_anim", &forceteleport, origin, angles);
    actor function_ad9433aab9fcdf04(level.framedurationseconds, "scene_play_anim", &setanimtime, animasset, 0);
    actor function_ad9433aab9fcdf04(level.framedurationseconds, "scene_play_anim", &setanimrate, animasset, 0);
  }
}

function private function_9b5a56bdfebe61d6(animrate) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity) && isDefined(var_214d924f4e137244.activeanimation)) {
    var_214d924f4e137244 function_2142970a7a74d1f2("scene_play_anim", &setanimrate, var_214d924f4e137244.activeanimation, animrate);
  }
}

function private actor_set_anim_time(animasset, timefrac) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity notify("actor_set_anim_time");
    entity dontinterpolate();
    var_214d924f4e137244 function_2142970a7a74d1f2("scene_play_anim", &setanimtime, animasset, timefrac);
  }
}

function private function_d3d0a7ea23cbe6d(lerptime, velocity) {
  var_214d924f4e137244 = self;
  lerptime = default_to(lerptime, 0);
  var_8e37660f5aca2238 = default_to(velocity, (0, 0, 0));
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    var_214d924f4e137244 function_2142970a7a74d1f2("scene_play_anim", &function_4beb9f7715504995, lerptime, velocity);
  }
}

function private actor_set_anim_playing(animasset) {
  var_214d924f4e137244 = self;
  var_214d924f4e137244 notify("actor_set_anim_playing");
  var_214d924f4e137244 endon("actor_set_anim_playing");
  var_214d924f4e137244 endon("scene_stop");
  entity = var_214d924f4e137244 function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  codescripted = undefined;

  if(!isDefined(var_214d924f4e137244.var_53c962747bd1f2f)) {
    entity waittill("scripted_anim", codescripted);
  }

  if(isDefined(codescripted) && isDefined(codescripted["anim"]) && codescripted["anim"] == animasset) {
    var_214d924f4e137244.var_53c962747bd1f2f = animasset;
    var_214d924f4e137244 notify("scene_anim_playing", animasset);
  }
}

function private function_9e7b86e7070de40f(sceneplay, shotindex, objectindex) {
  function_bea88b25e17cea66(sceneplay, shotindex, objectindex);
}

function private function_451712661ab10691(shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    actor = var_214d924f4e137244.entity;

    if(var_214d924f4e137244.sceneobject function_2917c4d9acc44d9(shotindex) && isDefined(anim.var_91bc951178da9f3b)) {
      actor function_f9a207358d70923c(level.framedurationseconds, "scene_shot_cleanup", anim.var_91bc951178da9f3b, level.player);
    }
  }
}

function private function_9acdf50d8ceba89e(shotindex) {
  var_214d924f4e137244 = self;
  reachtype = var_214d924f4e137244.sceneobject function_8b6dcfac0d2921ad(shotindex);
  return reachtype == "Teleport";
}

function private function_4a2b39e903062a08(shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    actor = var_214d924f4e137244.entity;
    var_d223a5b14195b3ef = var_214d924f4e137244.sceneobject function_b56c0812b975be8(shotindex);

    if(var_d223a5b14195b3ef != "DEFAULT") {
      actor val::set("scene_end", "demeanor", var_d223a5b14195b3ef);
    }

    if(var_214d924f4e137244.sceneobject function_2917c4d9acc44d9(shotindex) && isDefined(anim.var_8122f7efa052c448)) {
      actor[[anim.var_8122f7efa052c448]](level.player);
    }

    stanceend = var_214d924f4e137244.sceneobject function_c3345343cc0eb8ab(shotindex);
    actor scripts\asm\asm_bb::bb_requeststance(stanceend);

    if(var_214d924f4e137244 function_1ac09e541828ca09()) {
      actor setgoalpos(actor.origin);
    }

    if(var_214d924f4e137244 function_ebd63773be52d607()) {
      actor pausepath(randomfloatrange(2, 3));
    }

    if(var_214d924f4e137244 function_e0c309a786687925(shotindex)) {
      actor val::reset("scene_shot", "take_weapons");
    }
  }
}

function private function_dd4e63bb65c5102d() {
  var_214d924f4e137244 = self;
  return isalive(var_214d924f4e137244.entity) && !var_214d924f4e137244.entity doinglongdeath();
}

function private actor_kill() {
  var_214d924f4e137244 = self;

  if(isalive(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity startragdoll();
    var_214d924f4e137244.entity kill();
  }
}

function private actor_cleanup(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;
}

function private function_62305a66a4f213b() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.lookatstealth);
}

function private function_c811d75d62ab3b31() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.stealthreact);
}

function private function_ebd63773be52d607() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.delaymovementatend);
}

function private function_1ac09e541828ca09() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.var_fefc136f72d755f);
}

function function_f6623635176f0b97(enabled) {
  assert(isPlayer(self));
  player = self;
  player scripts\sp\anim::letterbox_enable(enabled, 0);
}