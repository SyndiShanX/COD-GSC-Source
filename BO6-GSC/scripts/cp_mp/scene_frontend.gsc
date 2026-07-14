/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\scene_frontend.gsc
********************************************/

#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace scene;

function function_6c37456303b2e980() {
  if(!isinfrontend()) {
    return;
  }

  level.players = [self];
  function_9faf48fca9716acd();
  function_3a06b41e384fbf58("Types_ClientChar", "objectDelete", &client_character_delete);
  function_3a06b41e384fbf58("Types_ClientChar", "shotObjectPrepare", &function_88b717bec001f592);
  function_3a06b41e384fbf58("Types_Prop", "shotObjectPlayAnim", &function_8384f562f0cb4abe);
  function_3a06b41e384fbf58("Types_XCam", "shotObjectPlayAnim", &function_e5fa611bc31131e8);
  function_a8d91578e2556475();
}

function private client_character_delete() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    sceneobjectdata.entity hide();

    if(sceneobjectdata.sceneroot.var_c46929fa56699327) {
      sceneobjectdata.sceneroot.var_c46929fa56699327 = arrayremove(sceneobjectdata.sceneroot.var_c46929fa56699327, sceneobjectdata.entity);
    }
  }
}

function private function_88b717bec001f592(sceneplay, shotindex, sceneobjectindex) {
  sceneobjectdata = self;
  sceneobject = sceneobjectdata.sceneobject;
  var_dac9072a6d0b14bd = sceneobject.variant_object.shots[shotindex];
  characterindex = sceneobject function_8d6340a41bdf10ed() - 1;
  character = level.client_characters[characterindex];
  character function_de4866729f37f5d2(var_dac9072a6d0b14bd.deltaanimations.size > 0);
}

function private function_8384f562f0cb4abe(shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime) {
  sceneobjectdata = self;
  entity = sceneobjectdata.entity;

  if(!isDefined(entity)) {
    return;
  }

  animlengthtime = 0;
  done = 0;

  if(entity.model == "") {
    println("<dev string:x24>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:x57>");
    return 0;
  }

  entity val::set("scene_shot", "cinematics_participant", 1);

  if(!isDefined(blendtime)) {
    blendtime = 0;
  }

  if(!isDefined(lerptime)) {
    lerptime = 0;
  }

  if(!isDefined(var_142c2c5d44216f2a)) {
    var_142c2c5d44216f2a = 0;
  }

  if(isDefined(sceneobjectdata.scenedata.var_a173fd36d9f698cb)) {
    blendtime = 0;
    lerptime = 0;
  }

  str_anim_name = getanimname(animasset);
  function_7caec59d5958332(alignmentinfo);
  var_3d2460219c7907a = "none";

  if(blendtime > 0 && blendtime < 1) {
    var_3d2460219c7907a = "normal";
  } else if(blendtime >= 1) {
    var_3d2460219c7907a = "slow";
  }

  starttimeinseconds = 0;
  n_anim_length = getanimlength(animasset);

  if(var_142c2c5d44216f2a > 0) {
    starttimeinseconds = n_anim_length * var_142c2c5d44216f2a;
  }

  b_looping = animislooping(animasset);

  if(var_142c2c5d44216f2a < 1) {
    sceneobjectdata childthread function_26364b7b16eb9611(notifystring, animasset);
  }

  entity scriptmodelclearanim();
  entity useanimtree(sceneobjectdata.sceneobject function_4641057744100c08());
  entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime);
  entity scriptmodelplayanim(str_anim_name, undefined, starttimeinseconds, 1, var_3d2460219c7907a);
  sceneobjectdata function_4a9835edd174d8e3(animasset);
  animlengthtime += getanimlength(animasset);

  if(b_looping) {
    sceneobjectdata waittillmatch(notifystring, "end");
  } else if(animlengthtime > 0) {
    sceneobjectdata utility::waittill_match_or_timeout(notifystring, "end", animlengthtime);
  }

  return animlengthtime - var_142c2c5d44216f2a * animlengthtime;
}

function private function_e5fa611bc31131e8(shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype) {
  sceneobjectdata = self;
  sceneobjectdata xcam_delete();

  if(level.players.size == 0) {
    return 0;
  }

  function_7caec59d5958332(alignmentinfo);
  sceneobjectdata endon("scene_stop");
  sceneobjectdata endon("scene_play_anim");
  sceneobjectdata.xcamplaying = 1;
  players = sceneobjectdata function_931d12df9abebc7f();

  foreach(player in players) {
    sceneobjectdata childthread function_d3e02207e3f1f850("scene_shot_xcam", player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex);
  }

  waittime = function_516be5ef89c77c57(animasset, var_142c2c5d44216f2a);

  if(getxcamlooping(animasset)) {
    sceneobjectdata waittillmatch(notifystring, "end");
  } else if(waittime > 0) {
    sceneobjectdata utility::waittill_match_or_timeout(notifystring, "end", waittime);
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player val::reset_all("scene_shot_xcam");
  }

  return waittime;
}

function private function_d3e02207e3f1f850(valgroup, player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex) {
  sceneobjectdata = self;
  assert(isPlayer(player));

  if(function_3e768ed8916f0542(shotindex)) {
    player endon("disconnect");
  } else {
    player endon("death_or_disconnect");
  }

  scene_debug::object_event(sceneobjectdata, "<dev string:x5c>" + shotindex, alignmentinfo.origin, alignmentinfo.angles);

  waittime = 0;

  if(animasset != "") {
    starttime = 0;

    if(var_142c2c5d44216f2a > 0) {
      starttime = getxcamlength(animasset) * var_142c2c5d44216f2a;
    }

    player notify("scene_play_xcam");
    player endon("scene_play_xcam");

    if(!isDefined(level.var_26b9bd60c95fd049)) {
      level.var_26b9bd60c95fd049 = spawn("script_model", alignmentinfo.origin);
      level.var_26b9bd60c95fd049 setModel("tag_origin");
    }

    level.var_26b9bd60c95fd049.origin = alignmentinfo.origin;
    level.var_26b9bd60c95fd049.angles = alignmentinfo.angles;
    blendtime = sceneobjectdata.sceneobject function_1c54677f7be74c59(shotindex);

    if(blendtime == 0) {
      sceneobjectdata thread function_85ae4b01cd8305f2();
    }

    function_41797a7aad14e175(animasset, 0, blendtime, level.var_26b9bd60c95fd049);
    player cameralinkTo(level.var_26b9bd60c95fd049, "tag_origin");
    player.scenexcam = {
      #time: gettime(), #animasset: animasset
    };

    if(getxcamlooping(animasset)) {
      sceneobjectdata waittillmatch(notifystring, "end");
    } else {
      waittime = function_516be5ef89c77c57(animasset, var_142c2c5d44216f2a);

      if(waittime > 0) {
        sceneobjectdata utility::waittill_match_or_timeout(notifystring, "end", waittime);
      }
    }

    player notify("scene_play_xcam_done");
  }

  return waittime;
}

function private function_85ae4b01cd8305f2() {
  sceneobjectdata = self;
  var_a5534827805425ee = "client_scene_teleport:" + sceneobjectdata.activeanimation;
  setDvar(@ "lui_fe_transitioning_scene", var_a5534827805425ee);
  level.active_section.name = var_a5534827805425ee;
  waitframe();
  completescenetransition();
}