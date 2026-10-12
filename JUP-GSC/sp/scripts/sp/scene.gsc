/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\scene.gsc
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
  function_7855ec4caf5901f9("Types_Player", "shotObjectPlayAnim", &player_play_anim);
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
    gamemodebundle = getgamemodescriptbundle();

    if(isDefined(gamemodebundle) && isDefined(gamemodebundle.var_8ec20071f762ea35)) {
      scripts\sp\player_rig::init_player_rig(gamemodebundle.var_8ec20071f762ea35, undefined, gamemodebundle.var_6c2ad496230d88b9);
    } else {
      scripts\sp\player_rig::init_player_rig("viewhands_base_iw8", undefined, "viewhands_base_fullbody_iw8");
    }
  }

  level thread function_e16b1ab0a35605d3("load_finished");
}

function private function_cfe0d1ffc4e09be5(entity, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  sceneobjectdata = self;

  if(!isDefined(entity)) {
    return;
  }

  animlengthtime = 0;
  animrate = undefined;
  done = 0;

  if(isDefined(sceneobjectdata.sceneroot.scenestatic)) {
    animrate = sceneobjectdata.sceneroot.scenestatic.animrate;
  }

  var_866b3a3066122e39 = default_to(var_866b3a3066122e39, 0);
  lerptime = default_to(lerptime, 0);
  blendtime = default_to(blendtime, 0.2);
  root = sceneobjectdata function_b9c245bf99df4a8();

  if(entity.model == "") {
    println("<dev string:x1c>" + sceneobjectdata.sceneobject function_aeb2b46911a5811d() + "<dev string:x4c>");
    return 0;
  }

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
    blendtime = 0;
    lerptime = 0;
  }

  function_e4fc30ccdca08b9d(alignmentinfo);

  if(!sceneobjectdata function_744a16ccecd8e4dd()) {
    return 0;
  }

  startorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
  startangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);

  if(lerptime <= 0) {
    sceneobjectdata object_teleport(startorigin, startangles);
  } else {
    angledelta = anglesdelta(entity.angles, startangles);
    entity.anglelerprate = angledelta / lerptime;
  }

  if(var_866b3a3066122e39 < 1) {
    sceneobjectdata childthread function_8e9f8e1fbe2b7ab4(notifystring, animasset);
  }

  entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, root, blendtime);
  var_2b6a8cc75ce67f16 = is_equal(animasset, sceneobjectdata.var_a3ff79ae166c57aa);
  sceneobjectdata function_bdfc45b799d27532(animasset);
  sceneobjectdata thread function_bf2f06d70b4e15ad(1);

  if(isDefined(lerptime) && lerptime > 0) {
    sceneobjectdata childthread function_db16fb604c5ca71d(lerptime, sceneobjectdata object_velocity());
  }

  if(isDefined(blendcurve) && blendtime > 0) {
    entity setanimblendcurve(animasset, blendcurve);
  }

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0 && var_866b3a3066122e39 <= 1) {
    if(var_866b3a3066122e39 == 1 && animislooping(animasset)) {
      var_866b3a3066122e39 = 0.999;
    }

    sceneobjectdata function_380708345e16e475(animasset, var_866b3a3066122e39);
  } else if(istrue(var_2b6a8cc75ce67f16)) {
    sceneobjectdata function_380708345e16e475(animasset, 0);
  }

  sceneobjectdata function_6a4d64bdba27cb06(animrate);

  if(var_866b3a3066122e39 < 1) {
    entity function_ee012c2dd711a8ce(notifystring, "end", "stop_animmode");
  }

  animlengthtime += getanimlength(animasset);
  return animlengthtime - var_866b3a3066122e39 * animlengthtime;
}

function private function_70b41a355929bc17(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  sceneobjectdata = self;
  anim_entity = sceneobjectdata function_4c4c2a548b9fc7ab();
  assert(default_to(animationtype, "DeltaAnimation") == "DeltaAnimation");
  animplaybacktime = sceneobjectdata function_cfe0d1ffc4e09be5(anim_entity, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
  return animplaybacktime;
}

function private function_cca29832342e0a31() {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity scripts\engine\sp\utility::anim_stopanimScripted();
  }
}

function private function_d63c9b1154a8be6() {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();
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
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  sceneobjectdata childthread start_notetrack_wait(entity, notifystring, undefined, undefined, animasset);
  sceneobjectdata childthread animscriptdonotetracksthread(entity, notifystring, undefined);
}

function private player_setup(sceneplay) {
  sceneobjectdata = self;
  sceneobjectdata.playerrigs = sceneobjectdata function_11f0b522fd79c07b();
}

function private function_fbcd130e311a767f(shotindex) {
  sceneobjectdata = self;

  if(isPlayer(sceneobjectdata.entity)) {
    sceneobjectdata.entity delaycall(0.1, &clearplayerhintlock);
    sceneobjectdata.entity val::set("scene_scene", "cinematic_motion", 0);
    sceneobjectdata.entity val::set("scene_scene", "show_legs_and_shadow", 0);

    if(sceneobjectdata function_8186a93a774b5977() == "Scene_Model") {
      if(!isDefined(sceneobjectdata.prevplayerrigs)) {
        sceneobjectdata.prevplayerrigs = [];

        foreach(rig in sceneobjectdata.playerrigs) {
          sceneobjectdata.prevplayerrigs[animname] = rig.model;
        }
      }

      model = sceneobjectdata.sceneobject function_12eb9fd56334261c();
      scripts\sp\player_rig::init_player_rig_no_precache(model);
    }
  }
}

function private function_24b6b2bfc5bdab36(animname, animtree) {
  sceneobjectdata = self;
}

function private function_c655258c05f2383c(animrate) {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.playerrigs)) {
    return;
  }

  foreach(rig in sceneobjectdata.playerrigs) {
    if(isDefined(rig) && isDefined(sceneobjectdata.activeanimation)) {
      rig setanimrate(sceneobjectdata.activeanimation, animrate);
    }
  }
}

function private function_3e11215cec07f917(animasset, timefrac) {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.playerrigs)) {
    return;
  }

  foreach(rig in sceneobjectdata.playerrigs) {
    if(isDefined(rig)) {
      rig setanimtime(animasset, timefrac);
      rig dontinterpolate();
    }
  }
}

function private function_c29e618edeaa7720(entity) {
  sceneobjectdata = self;
  return isPlayer(entity);
}

function private function_11f0b522fd79c07b() {
  sceneobjectdata = self;
  result = [];
  animtree = sceneobjectdata.sceneobject function_c106523f3836b90b();
  rigs = sceneobjectdata scripts\sp\player_rig::function_8ded956fcab6f73a(0, 1, animtree);
  rigtype = sceneobjectdata function_8186a93a774b5977();

  switch (rigtype) {
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
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.playerrigs)) {
    if(isDefined(sceneobjectdata.playerrigs["player_rig"])) {
      return sceneobjectdata.playerrigs["player_rig"];
    }

    foreach(rig in sceneobjectdata.playerrigs) {
      return rig;
    }
  }

  return undefined;
}

function private function_e6e53745b22ae909() {
  sceneobjectdata = self;
  return sceneobjectdata function_5f3da76468742def();
}

function private function_9f8add72acb9b1f6() {
  sceneobjectdata = self;
  return sceneobjectdata.playerrigs;
}

function private player_velocity() {
  sceneobjectdata = self;
  return sceneobjectdata.entity getvelocity();
}

function private player_play_anim(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  sceneobjectdata = self;
  player = sceneobjectdata.entity;
  sceneobjectdata endon("scene_stop");
  sceneobjectdata endon("scene_play_anim");

  if(istrue(sceneobjectdata.sceneroot.scenedata.excludeplayer) || !isPlayer(player)) {
    sceneobjectdata function_bf0d14daf3e53248(animasset, sceneobjectdata.activeanimationtype, notifystring);
    sceneobjectdata function_68056529c69f4097(sceneobjectdata.activeanimationtype, shotindex, animindex);
    return 0;
  }

  var_409dc6bbf1421f94 = sceneobjectdata function_5fe020a6db35fab3(shotindex);

  if(sceneobjectdata.activeanimationtype == "CameraAnimation") {
    sceneobjectdata thread object_play_anim_waittill_end(animasset, [player], "death", "CameraAnimation", notifystring);
    sceneobjectdata.xcamplaying = 1;
    player val::set_array("scene_shot", var_409dc6bbf1421f94, 0);
    return sceneobjectdata function_bae0f68830d519ad("scene_shot", player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex);
  }

  animlengthtime = 0;
  rig = sceneobjectdata function_5f3da76468742def();
  shotindex = sceneobjectdata.sceneplay.currentshot;
  stance = sceneobjectdata.sceneobject function_892812e26790e793(shotindex);
  blendtime = sceneobjectdata.sceneobject function_205f7afe5d801664(shotindex);
  arcright = sceneobjectdata.sceneobject function_918dc2e0c83784b6(shotindex);
  arcleft = sceneobjectdata.sceneobject function_16b4cb7e4c5af0fd(shotindex);
  arctop = sceneobjectdata.sceneobject function_b06da1547120edef(shotindex);
  arcbottom = sceneobjectdata.sceneobject function_be3310ec58dd9807(shotindex);
  usetagangles = sceneobjectdata.sceneobject function_8851aea907b47f88(shotindex);
  restrictcamera = 0;
  autocenter = sceneobjectdata.sceneobject function_20e9c3d094691efe(shotindex);
  viewfraction = sceneobjectdata.sceneobject function_b083c5862877c8e3(shotindex);

  if(isDefined(sceneobjectdata.scenedata.var_43286fd46706909c)) {
    blendtime = 0;
    lerptime = 0;
  }

  scripts\sp\player_rig::set_player_rig_allows(var_409dc6bbf1421f94);

  if(getdvarint(@ "hash_54fd90073299424e")) {
    player thread scripts\common\scene_debug::function_c623b8e6e4b0a90("<dev string:x4e>", 20, getdvarint(@ "hash_54fd90073299424e"), lerptime);
    rig thread scripts\common\scene_debug::function_c623b8e6e4b0a90("<dev string:x4f>", 20, getdvarint(@ "hash_54fd90073299424e"));
    rig thread scripts\common\scene_debug::function_c623b8e6e4b0a90("<dev string:x5a>", 20, getdvarint(@ "hash_54fd90073299424e"));
  }

  if(!sceneobjectdata function_829b387c84d7e2c0()) {
    playerblending = lerptime > 0;
    animblending = blendtime > 0;

    if(animblending) {
      level.blendinfo["weaponDropTime"] = max(lerptime, blendtime) * 0.7;
    }

    linktag = sceneobjectdata function_a89f1262c5148bdf();
    otherrigs = [];

    foreach(rigother in sceneobjectdata.playerrigs) {
      if(rigother == rig) {
        continue;
      }

      otherrigs[otherrigs.size] = rigother;
    }

    sceneobjectdata.sceneroot childthread scripts\sp\player_rig::link_player_to_rig(undefined, stance, playerblending, lerptime, restrictcamera, arcright, arcleft, arctop, arcbottom, usetagangles, undefined, undefined, undefined, animblending, undefined, undefined, undefined, linktag, otherrigs);
  } else {
    foreach(rigent in sceneobjectdata.playerrigs) {
      rigent show();
    }

    if(!player function_68d997f850b153c7()) {
      player lerpviewangleclamp(lerptime, lerptime * 0.5, lerptime * 0.5, arcright, arcleft, arctop, arcbottom, 1);
    }

    player scripts\sp\player_rig::function_73341653f76b4e43();
  }

  if(lerptime <= 0) {
    if(!sceneobjectdata function_285bdba488858f9e(shotindex)) {
      player dontinterpolate();
    }
  }

  sceneobjectdata.playerrigvalues = 1;

  if(sceneobjectdata function_829b387c84d7e2c0() && !player isufo() && !player isnoclip()) {
    if(autocenter) {
      player springcamenabled(1);
    } else {
      player springcamdisabled(0.2);
    }

    player playerlinkedviewfraction(viewfraction);
  }

  sceneobjectdata thread function_e0ade8dd368ad3a5();
  riglerptime = 0;

  foreach(rigother in sceneobjectdata.playerrigs) {
    if(rigother != rig) {
      sceneobjectdata thread function_cfe0d1ffc4e09be5(rigother, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, riglerptime);
    }
  }

  animlengthtime = sceneobjectdata function_cfe0d1ffc4e09be5(rig, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, riglerptime);
  return animlengthtime;
}

function private function_e477b4837d3fc6a7() {
  sceneobjectdata = self;
  sceneobjectdata function_2f2327d535ed0bb();
  sceneobjectdata function_cca29832342e0a31();
}

function private function_3efb11b3bc18a9c6() {
  sceneobjectdata = self;

  foreach(rig in sceneobjectdata.playerrigs) {
    if(isDefined(rig) && isDefined(sceneobjectdata.var_36831a04af11576f)) {
      foreach(message in sceneobjectdata.var_36831a04af11576f) {
        rig notify(message, "end");
      }
    }
  }

  if(isDefined(sceneobjectdata.entity) && isDefined(sceneobjectdata.var_36831a04af11576f)) {
    foreach(message in sceneobjectdata.var_36831a04af11576f) {
      sceneobjectdata.entity notify(message, "end");
    }
  }
}

function private player_cleanup(newsceneroot) {
  sceneobjectdata = self;
  sceneobjectdata function_2f2327d535ed0bb();

  if(sceneobjectdata.playerrigs.size > 0) {
    rig = sceneobjectdata function_5f3da76468742def();

    if(!isDefined(newsceneroot)) {
      if(sceneobjectdata function_829b387c84d7e2c0()) {
        stancebegin = sceneobjectdata.sceneobject function_892812e26790e793(sceneobjectdata.sceneplay.currentshot);
        stanceend = sceneobjectdata.sceneobject function_c3345343cc0eb8ab(sceneobjectdata.sceneplay.currentshot);
        immediatestance = default_to(rig.linktag, "tag_player") == "tag_camera";

        if(!is_equal(stancebegin, stanceend)) {
          immediatestance = 1;
        }

        childthread scripts\sp\player_rig::unlink_player_from_rig(0, stanceend, immediatestance, 1);
      }

      if(isPlayer(sceneobjectdata.entity) && istrue(sceneobjectdata.playerrigvalues)) {
        sceneobjectdata.entity val::reset_all("player_rig");
        sceneobjectdata.playerrigvalues = undefined;
      }
    }

    foreach(rig in sceneobjectdata.playerrigs) {
      rig hide();
    }

    if(sceneobjectdata function_8186a93a774b5977() == "Scene_Model" && isDefined(sceneobjectdata.prevplayerrigs)) {
      scripts\sp\player_rig::init_player_rig_no_precache(sceneobjectdata.prevplayerrigs["player_rig"], sceneobjectdata.prevplayerrigs["player_legs"], sceneobjectdata.prevplayerrigs["player_body"]);
      sceneobjectdata.prevplayerrigs = undefined;
    }
  }
}

function private player_delete() {}

function private function_8186a93a774b5977() {
  sceneobjectdata = self;
  return default_to(sceneobjectdata.sceneobject.variant_object.playerrigtype, "Rig");
}

function private function_829b387c84d7e2c0() {
  sceneobjectdata = self;
  rig = sceneobjectdata function_5f3da76468742def();
  player = sceneobjectdata.entity;

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
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.playerrigs)) {
    return;
  }

  body = sceneobjectdata.playerrigs["player_body"];

  if(isDefined(body)) {
    if(!isDefined(sceneobjectdata.activeanimationplaying)) {
      sceneobjectdata waittill("scene_anim_playing");
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
  sceneobjectdata = self;
  sceneobjectassettype = sceneobjectdata.sceneobject function_992de34e05c5cea7();
  sceneobjectassetname = sceneobjectdata.sceneobject function_12eb9fd56334261c();
  entity = undefined;

  if(sceneobjectassettype == "aitype") {
    entity = spawndroneaitype("actor_" + sceneobjectassetname, spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    entity = sceneobjectdata function_3e19c1b49e591d34(spawnorigin, spawnangles);

    if(isDefined(entity)) {
      entity.team = "allies";
      entity.type = "human";
      entity.unittype = "soldier";
      sceneobjectdata.nosentient = 1;
    }
  }

  if(isDefined(entity)) {
    entity scripts\sp\spawner::function_7a2464dfda234e36();

    if(sceneobjectdata function_5a831c826484d0fa() == "Sentient" && !istrue(sceneobjectdata.nosentient)) {
      sceneobjectdata function_318f4852c1eb7c74(entity);
    }

    entity useanimtree(sceneobjectdata.sceneobject function_c106523f3836b90b());
  }

  return entity;
}

function private function_aa6788c9ed21c842(entity) {
  sceneobjectdata = self;
  sceneobjectdata.nosentient = undefined;

  if(sceneobjectdata function_5a831c826484d0fa() == "Sentient") {
    return istrue(entity.script_fakeactor);
  }

  return entity.classname == "script_model";
}

function private function_f07b0cbbb739527b(sceneplay, shotindex, objectindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;

    if(sceneobjectdata function_e2bb6af4c53815a0()) {
      fakeactor scripts\sp\fakeactor::function_cc5fb4563e4cbd5d();
    }

    if(sceneobjectdata.sceneobject function_fc9281240877df76()) {
      if(sceneobjectdata function_5a831c826484d0fa() == "Sentient" && !istrue(sceneobjectdata.nosentient)) {
        sceneobjectdata function_318f4852c1eb7c74();
        fakeactor scripts\sp\fakeactor::set_use_pain(1);
      } else {
        sceneobjectdata thread function_7e0dd853c6d00913();
      }
    } else {
      fakeactor scripts\sp\fakeactor::function_b4deaa96649c12db();
    }

    if(istrue(fakeactor.script_fakeactor)) {
      fakeactor scripts\sp\fakeactor::take_control();
    }

    if(sceneobjectdata function_e0c309a786687925(shotindex)) {
      fakeactor val::set("scene_shot", "take_weapons", 1);
    }
  }
}

function private function_aaa12a8607a888a4(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;

    if(istrue(fakeactor.script_fakeactor)) {
      fakeactor scripts\sp\fakeactor::release_control();
    }

    if(sceneobjectdata function_e0c309a786687925(shotindex)) {
      fakeactor val::reset("scene_shot", "take_weapons");
    }
  }
}

function private function_b76ec219f2a45811(newsceneroot) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;

    if(sceneobjectdata function_e2bb6af4c53815a0()) {
      fakeactor scripts\sp\fakeactor::function_ca5cea9991fa5306();
    }
  }
}

function private function_318f4852c1eb7c74(entity) {
  sceneobjectdata = self;
  entity = default_to(entity, sceneobjectdata.entity);

  if(isDefined(entity)) {
    fakeactor = entity;

    if(!isDefined(level.fakeactor_spawn_func)) {
      scripts\sp\fakeactor::fakeactor_spawner_init();
    }

    if(!istrue(fakeactor.script_fakeactor) && isDefined(level.fakeactor_spawn_func)) {
      fakeactor thread fakeactorspawn_setup();
    }
  }
}

function private function_7e0dd853c6d00913() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;

    if(!istrue(fakeactor.script_fakeactor)) {
      fakeactor scripts\sp\fakeactor::function_b247aabd62f70947();
    }
  }
}

function private function_5a831c826484d0fa() {
  sceneobjectdata = self;
  return default_to(sceneobjectdata.sceneobject.variant_object.fakeactortype, "Drone");
}

function private function_e2bb6af4c53815a0() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.navrepulsor);
}

function private actor_spawn(spawnorigin, spawnangles) {
  sceneobjectdata = self;
  sceneobjectassettype = sceneobjectdata.sceneobject function_992de34e05c5cea7();
  sceneobjectassetname = sceneobjectdata.sceneobject function_12eb9fd56334261c();
  entity = undefined;

  if(isactorspawner(sceneobjectdata.spawner)) {
    var_75c15e716113c51b = isDefined(sceneobjectdata.spawner.script_stealthgroup) && flag("stealth_enabled") && !flag("stealth_spotted");
    entity = sceneobjectdata.spawner stalingradspawn(var_75c15e716113c51b, 1);

    if(isDefined(entity)) {
      entity teleport(spawnorigin, spawnangles);
    }
  }

  if(!isDefined(entity)) {
    if(sceneobjectassettype == "aitype") {
      entity = dospawnaitype("actor_" + sceneobjectassetname, spawnorigin, spawnangles, 1, 0, 1, 1);

      if(isDefined(entity)) {
        entity thread scripts\sp\spawner::spawn_think();
      }
    } else if(sceneobjectassettype == "character") {
      println("<dev string:x65>" + sceneobjectdata.sceneobject function_aeb2b46911a5811d() + "<dev string:x8f>" + sceneobjectassetname + "<dev string:x4c>");
    }
  }

  if(isDefined(entity)) {
    entity useanimtree(sceneobjectdata.sceneobject function_c106523f3836b90b());
  }

  return entity;
}

function private actor_setup(sceneplay) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    actor = sceneobjectdata.entity;

    if(isDefined(actor.stealth) && isDefined(level.stealth)) {
      if(sceneobjectdata function_62305a66a4f213b()) {
        sceneobjectdata thread function_89c29980d9b0ebe();
      }

      if(sceneobjectdata function_c811d75d62ab3b31()) {
        sceneobjectdata thread function_81f89576d8f466b4();
      }
    }

    if(sceneobjectdata.sceneobject function_fc9281240877df76()) {
      actor.allowdeath = 1;
    }
  }
}

function private function_62d306b8ddab4726(entity) {
  sceneobjectdata = self;
  return isactor(entity) && isalive(entity);
}

function private actor_teleport(origin, angles) {
  sceneobjectdata = self;
  sceneobjectdata.entity forceteleport(origin, angles);
}

function private function_f05b1eb6b24263b5(alignmentinfo, shotindex) {
  sceneobjectdata = self;
  shotindex = default_to(shotindex, sceneobjectdata.sceneplay.shotinit);
  actor = sceneobjectdata.entity;
  deltaanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a(shotindex);

  if(deltaanimations.size != 0 && isent(actor)) {
    animasset = deltaanimations[0];
    sceneobjectdata function_cca29832342e0a31();
    origin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
    angles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);
    actor thread ai_anim_first_frame(animasset, actor.animname);

    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:x95>" + getxhashsourcename(getanimname(animasset)), origin, angles);

    function_ce4b6d4d859ede39(sceneobjectdata, "<dev string:xa2>" + getxhashsourcename(getanimname(animasset)), alignmentinfo.origin, alignmentinfo.angles);

    actor delaycallendon(level.framedurationseconds, "scene_play_anim", &forceteleport, origin, angles);
    actor delaycallendon(level.framedurationseconds, "scene_play_anim", &setanimtime, animasset, 0);
    actor delaycallendon(level.framedurationseconds, "scene_play_anim", &setanimrate, animasset, 0);
  }
}

function private function_9b5a56bdfebe61d6(animrate) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity) && isDefined(sceneobjectdata.activeanimation)) {
    sceneobjectdata function_2142970a7a74d1f2("scene_play_anim", &setanimrate, sceneobjectdata.activeanimation, animrate);
  }
}

function private actor_set_anim_time(animasset, timefrac) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    entity notify("actor_set_anim_time");
    entity dontinterpolate();
    sceneobjectdata function_2142970a7a74d1f2("scene_play_anim", &setanimtime, animasset, timefrac);
  }
}

function private function_d3d0a7ea23cbe6d(lerptime, velocity) {
  sceneobjectdata = self;
  lerptime = default_to(lerptime, 0);
  var_8e37660f5aca2238 = default_to(velocity, (0, 0, 0));
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(isDefined(entity)) {
    sceneobjectdata function_2142970a7a74d1f2("scene_play_anim", &animscripted_blendin, lerptime, velocity);
  }
}

function private actor_set_anim_playing(animasset) {
  sceneobjectdata = self;
  sceneobjectdata notify("actor_set_anim_playing");
  sceneobjectdata endon("actor_set_anim_playing");
  sceneobjectdata endon("scene_stop");
  entity = sceneobjectdata function_4c4c2a548b9fc7ab();

  if(!isDefined(entity)) {
    return;
  }

  codescripted = undefined;

  if(!isDefined(sceneobjectdata.activeanimationplaying)) {
    entity waittill("scripted_anim", codescripted);
  }

  if(isDefined(codescripted) && isDefined(codescripted["anim"]) && codescripted["anim"] == animasset) {
    sceneobjectdata.activeanimationplaying = animasset;
    sceneobjectdata notify("scene_anim_playing", animasset);
  }
}

function private function_9e7b86e7070de40f(sceneplay, shotindex, objectindex) {
  function_bea88b25e17cea66(sceneplay, shotindex, objectindex);
}

function private function_451712661ab10691(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    actor = sceneobjectdata.entity;

    if(sceneobjectdata.sceneobject function_2917c4d9acc44d9(shotindex) && isDefined(anim.var_91bc951178da9f3b)) {
      actor delaythreadendon(level.framedurationseconds, "scene_shot_cleanup", anim.var_91bc951178da9f3b, level.player);
    }
  }
}

function private function_9acdf50d8ceba89e(shotindex) {
  sceneobjectdata = self;
  reachtype = sceneobjectdata.sceneobject function_8b6dcfac0d2921ad(shotindex);
  return reachtype == "Teleport";
}

function private function_4a2b39e903062a08(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    actor = sceneobjectdata.entity;
    demeanorend = sceneobjectdata.sceneobject function_b56c0812b975be8(shotindex);

    if(demeanorend != "DEFAULT") {
      actor val::set("scene_end", "demeanor", demeanorend);
    }

    if(sceneobjectdata.sceneobject function_2917c4d9acc44d9(shotindex) && isDefined(anim.var_8122f7efa052c448)) {
      actor[[anim.var_8122f7efa052c448]](level.player);
    }

    stanceend = sceneobjectdata.sceneobject function_c3345343cc0eb8ab(shotindex);
    actor scripts\asm\asm_bb::bb_requeststance(stanceend);

    if(sceneobjectdata function_1ac09e541828ca09()) {
      actor setgoalpos(actor.origin);
    }

    if(sceneobjectdata function_ebd63773be52d607()) {
      actor pausepath(randomfloatrange(2, 3));
    }

    if(sceneobjectdata function_e0c309a786687925(shotindex)) {
      actor val::reset("scene_shot", "take_weapons");
    }
  }
}

function private function_dd4e63bb65c5102d() {
  sceneobjectdata = self;
  return isalive(sceneobjectdata.entity) && !sceneobjectdata.entity doinglongdeath();
}

function private actor_kill() {
  sceneobjectdata = self;

  if(isalive(sceneobjectdata.entity)) {
    sceneobjectdata.entity startragdoll();
    sceneobjectdata.entity kill();
  }
}

function private actor_cleanup(newsceneroot) {
  sceneobjectdata = self;
}

function private function_62305a66a4f213b() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.lookatstealth);
}

function private function_c811d75d62ab3b31() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.stealthreact);
}

function private function_ebd63773be52d607() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.delaymovementatend);
}

function private function_1ac09e541828ca09() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.var_fefc136f72d755f);
}

function function_f6623635176f0b97(enabled) {
  assert(isPlayer(self));
  player = self;
  player scripts\sp\anim::letterbox_enable(enabled, 0);
}