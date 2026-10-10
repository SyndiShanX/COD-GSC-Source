/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\scene.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\notetrack;
#using scripts\common\scene;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace scene;

function private autoexec function_683aefb412af1596() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  function_ace39e84230f386();
  function_9d3850b024ab89b1("modeStartMonitoringPlayers", &function_22f6fca8362a92b);
  function_9d3850b024ab89b1("modeStopMonitoringPlayers", &function_276d3342cddac11a);
  function_9d3850b024ab89b1("modeXCamRespectsStartingTimeOnClients", &function_720d21706a7ff164);
  function_9d3850b024ab89b1("modeLetterbox", &function_f66b22351778fe49);
  function_9d3850b024ab89b1("modePlayerMatchingObjectForFemale", &function_d18c2d3d2819c322);
  function_7855ec4caf5901f9("Types_Player", "objectSetup", &function_c14ed0fc1a6ccf72);
  function_7855ec4caf5901f9("Types_Player", "shotObjectPlayAnim", &function_5fd2b7d3c29f131b);
  function_7855ec4caf5901f9("Types_Player", "shotObjectStopAnim", &function_e3f3a0837cae6779);
  function_7855ec4caf5901f9("Types_Player", "objectSetAnimName", &function_24b6b2bfc5bdab36);
  function_7855ec4caf5901f9("Types_Player", "objectDelete", &player_delete);
  function_7855ec4caf5901f9("Types_Player", "shotObjectPrepare", &function_43972bd744497667);
  function_7855ec4caf5901f9("Types_Player", "shotObjectCleanup", &function_8b3b351a42e84dc2);
  function_7855ec4caf5901f9("Types_Player", "objectMatchEntity", &function_70e05db9c7c6c130);
  function_7855ec4caf5901f9("Types_Player", "objectGetLinkEnts", &function_ca4527bcd586d366);
  function_7855ec4caf5901f9("Types_Player", "objectCleanup", &function_f5c1014e1cfdf615);
  function_7855ec4caf5901f9("Types_Player", "objectStoreAnimRequest", &function_8cd22f505439309f);
  function_7855ec4caf5901f9("Types_Player", "objectClearAnimRequest", &function_3e4cf61872dc003b);
  function_7855ec4caf5901f9("Types_Actor", "objectSpawn", &agent_spawn);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectPrepare", &function_61be92922a464251);
  function_7855ec4caf5901f9("Types_Actor", "objectMatchEntity", &function_12f50a9b21b4dd9a);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectPlayAnim", &function_43a42c8097aac565);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectStopAnim", &function_2d573d9c69823343);
  function_7855ec4caf5901f9("Types_Actor", "objectDelete", &agent_delete);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectCleanup", &function_642077a65edc7954);
  function_7855ec4caf5901f9("Types_Actor", "shotObjectFirstFrame", &function_6dad63edc3390487);
  function_7855ec4caf5901f9("Types_Vehicle", "objectSpawn", &vehicle_spawn_mp);
  function_7855ec4caf5901f9("Types_Vehicle", "shotObjectPlayAnim", &function_5552728c9588fd02);
  function_7855ec4caf5901f9("Types_Vehicle", "shotObjectStopAnim", &function_b8c3ea8ca94cea0c);
  function_7855ec4caf5901f9("Types_Vehicle", "objectDelete", &vehicle_delete);
  function_7855ec4caf5901f9("Types_Vehicle", "objectMatchEntity", &function_684629695ffebbdb);
  function_7855ec4caf5901f9("Types_Vehicle", "objectSetAnimName", &function_2e11be8a4ef151b5);
  function_7855ec4caf5901f9("Types_Object", "shotObjectPlayAnim", &function_70bd06355933aec9);
  function_7855ec4caf5901f9("Types_Object", "shotObjectStopAnim", &function_cc538c3233d741af);
  function_7855ec4caf5901f9("Types_Object", "shotObjectFirstFrame", &function_8bac7edf73a29d6b);
  function_7855ec4caf5901f9("Types_Object", "objectTeleport", &function_e8800b55f7cbd5a4);
  function_7855ec4caf5901f9("Types_Object", "objectMatchEntity", &function_83f1be5a5eb5f706);
  function_5a197e7b54a9091e();
  level thread function_e16b1ab0a35605d3("onStartGameTypeFinished");
}

function private function_70e05db9c7c6c130(entity) {
  if(function_2fbba7f29e8d78ce(self.index, entity)) {
    entity.animname = self.sceneobject.variant_object.name;
    return 1;
  }

  var_214d924f4e137244 = self;
  isplayerentity = isPlayer(entity);

  if(isDefined(isplayerentity)) {
    if(!function_ac04e049ff623301(entity, var_214d924f4e137244)) {
      return 0;
    }
  }

  return isplayerentity;
}

function private function_72777e12c4307f96() {
  var_214d924f4e137244 = self;
  return istrue(var_214d924f4e137244.sceneobject.variant_object.var_59f9757349c241a1);
}

function private function_be5a45fff59957b() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject.variant_object.var_d192b38b7ad90242;
}

function private function_306026c41bd7abbd() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject.variant_object.var_a6da0bee0f0e8948;
}

function private set_character_models(bodymodelname, headmodelname, viewmodelname) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  if(!isagent(self)) {
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    viewmodelname = self getcustomizationviewmodel();
  }

  self setModel(bodymodelname);
  self setviewmodel(viewmodelname);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }
}

function private function_ec6039191e7c076a(player, var_36a19240d8d46bc2, newheadmodel) {
  assert(isDefined(player));
  assert(isPlayer(player));
  player setcustomization(var_36a19240d8d46bc2, newheadmodel);
  var_e243ecbc215e7e07 = player getcustomizationviewmodel();
  player set_character_models(var_36a19240d8d46bc2, newheadmodel, var_e243ecbc215e7e07);
}

function private function_43972bd744497667(sceneplay, shotindex, objectindex) {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;

  if(!isPlayer(player)) {
    return;
  }

  assert(isPlayer(player));
  function_3d8d8ad244283e65(#"hash_d54b289d498be977");

  if(var_214d924f4e137244 function_b4d836fe99f480e(shotindex)) {
    player val::set("scene_shot", "take_weapons", 1);
  }

  scenescriptbundle = var_214d924f4e137244.sceneroot scene_scriptbundle();

  if(scenescriptbundle function_cf67ad1bae22e908()) {
    player function_e7257014ebaeeaa8(1);
  }

  player val::set("scene_scene", "cinematic_motion", 0);
  var_7fba0dfc25328161 = ["offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "tacmap_scoreboard", "backpack_inventory"];

  if(!istrue(var_214d924f4e137244.sceneobject.variant_object.var_9f78587cfefc10ac)) {
    var_7fba0dfc25328161 = array_add(var_7fba0dfc25328161, "usability");
  }

  if(var_214d924f4e137244.sceneobject function_d1dd52dc1f43215d(shotindex) != "Keep") {
    var_7fba0dfc25328161 = array_add(var_7fba0dfc25328161, "weapon");
  }

  if(!var_214d924f4e137244.sceneobject function_fcc766f42b75a322(shotindex)) {
    var_7fba0dfc25328161 = array_add(var_7fba0dfc25328161, "weapon_switch");
  }

  var_214d924f4e137244.entity val::set("scene_shot", "freezecontrols", 1);
  var_214d924f4e137244.entity val::set("scene_shot", "swimming_underwater", 0);
  function_7f3923ed3d66f8ad();
  function_3d8d8ad244283e65(#"hash_559bfd7b0925399d");
  var_214d924f4e137244.entity val::set_array("scene_shot", var_7fba0dfc25328161, 0);
  function_7f3923ed3d66f8ad();

  if(shotindex == var_214d924f4e137244.sceneplay.var_df5db7bd235f2729[0]) {
    if(var_214d924f4e137244 function_72777e12c4307f96()) {
      var_36a19240d8d46bc2 = player getcustomizationbody();
      newheadmodel = player getcustomizationhead();

      if(!isDefined(var_214d924f4e137244.var_d5d84848169bf792)) {
        var_214d924f4e137244.var_d5d84848169bf792 = var_36a19240d8d46bc2;
      }

      if(!isDefined(var_214d924f4e137244.var_79825563576bccb8)) {
        var_214d924f4e137244.var_79825563576bccb8 = newheadmodel;
      }

      var_9a843b7e2ec0ad7c = var_214d924f4e137244 function_be5a45fff59957b();

      if(isDefined(var_9a843b7e2ec0ad7c) && var_9a843b7e2ec0ad7c.size > 0) {
        var_36a19240d8d46bc2 = var_9a843b7e2ec0ad7c;
      }

      requestedheadmodel = var_214d924f4e137244 function_306026c41bd7abbd();

      if(isDefined(requestedheadmodel) && requestedheadmodel.size > 0) {
        newheadmodel = requestedheadmodel;
      }

      function_ec6039191e7c076a(player, var_36a19240d8d46bc2, newheadmodel);
    }
  }
}

function private function_8b3b351a42e84dc2(shotindex) {
  var_214d924f4e137244 = self;

  if(!isPlayer(var_214d924f4e137244.entity)) {
    return;
  }

  assert(isPlayer(var_214d924f4e137244.entity));

  if(shotindex == var_214d924f4e137244.sceneplay.var_df5db7bd235f2729[var_214d924f4e137244.sceneplay.var_df5db7bd235f2729.size - 1]) {
    if(var_214d924f4e137244 function_72777e12c4307f96()) {
      if(isDefined(var_214d924f4e137244.var_d5d84848169bf792) && isDefined(var_214d924f4e137244.var_79825563576bccb8)) {
        function_ec6039191e7c076a(var_214d924f4e137244.entity, var_214d924f4e137244.var_d5d84848169bf792, var_214d924f4e137244.var_79825563576bccb8);
        var_214d924f4e137244.var_d5d84848169bf792 = undefined;
        var_214d924f4e137244.var_79825563576bccb8 = undefined;
      }
    }

    function_2d5d63169291228e(var_214d924f4e137244.entity, shotindex);
  }

  var_214d924f4e137244.entity val::reset_all("scene_shot");
}

function private function_5fd2b7d3c29f131b(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;
  var_214d924f4e137244 endon("scene_stop");
  var_214d924f4e137244 endon("scene_play_anim");

  if(!isPlayer(player)) {
    if(is_equal(player, var_214d924f4e137244.replacemententity)) {
      if(isagent(player)) {
        var_7c6075e90a7b0fa = var_214d924f4e137244 function_23cc62938b72190b();
        var_e5b70543a43b4c89 = player function_d28a53b100cbdda7(var_214d924f4e137244, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, var_7c6075e90a7b0fa);
        return var_e5b70543a43b4c89;
      } else {
        var_e5b70543a43b4c89 = var_214d924f4e137244 function_70bd06355933aec9(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime);
        return var_e5b70543a43b4c89;
      }
    } else {
      var_214d924f4e137244 function_bf0d14daf3e53248(animasset, var_214d924f4e137244.var_41dc93404af773a3, notifystring);
      var_214d924f4e137244 function_68056529c69f4097(var_214d924f4e137244.var_41dc93404af773a3, shotindex, animindex);
      return 0;
    }
  }

  var_409dc6bbf1421f94 = var_214d924f4e137244 function_5fe020a6db35fab3(shotindex);
  player val::set_array("scene_shot", var_409dc6bbf1421f94, 0);

  if(var_214d924f4e137244.var_41dc93404af773a3 == "CameraAnimation") {
    var_214d924f4e137244 thread object_play_anim_waittill_end(animasset, [player], "death_or_disconnect", "CameraAnimation", notifystring);
    var_214d924f4e137244.xcamplaying = 1;
    return var_214d924f4e137244 function_bae0f68830d519ad("scene_shot", player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex);
  }

  player val::set("scene_shot", "cinematics_participant", 1);
  var_2e2a2f75fd49152a = getanimname(animasset);
  n_anim_length = getanimlength(animasset);
  player setOrigin(alignmentinfo.origin);
  player setplayerangles(alignmentinfo.angles);
  var_d0cbd253b25b43f5 = istrue(var_214d924f4e137244.xcamplaying) && var_214d924f4e137244.sceneobject.variant_object.shots[shotindex].deltaanimations.size == 1;
  var_9ebbc3376d9ce8f2 = var_214d924f4e137244 function_d776460a61b689bf(shotindex);
  var_d8ab3f21c6db562e = !var_9ebbc3376d9ce8f2;

  if(var_9ebbc3376d9ce8f2) {
    function_639a0acd683457ec(player, shotindex);
  } else {
    function_2d5d63169291228e(player, shotindex);
  }

  var_214d924f4e137244 childthread function_8e9f8e1fbe2b7ab4(notifystring, animasset);
  function_3d8d8ad244283e65(#"hash_e45c00238da3528c");
  player playanimscriptsceneevent("scripted_scene", var_2e2a2f75fd49152a, var_d8ab3f21c6db562e);
  function_7f3923ed3d66f8ad();
  var_214d924f4e137244 function_bdfc45b799d27532(animasset);

  if(var_9ebbc3376d9ce8f2) {
    n_anim_length = function_a7bfaa03b4d58c00(player, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, n_anim_length);
  } else if(var_d0cbd253b25b43f5) {
    n_start_time = gettime();
    player waittill_any_timeout_2(n_anim_length, "stop_animmode", "death_or_disconnect");
    var_ef8433621bf198f1 = function_c89ed1840c8d0f0f(gettime() - n_start_time);
    println("<dev string:x1c>" + var_ef8433621bf198f1 + "<dev string:x41>" + function_3c8848a3a11b2553(var_2e2a2f75fd49152a) + "<dev string:x58>" + n_anim_length + "<dev string:x67>" + n_anim_length - var_ef8433621bf198f1 + "<dev string:x7c>");
    n_anim_length = var_ef8433621bf198f1;
  } else {
    wait n_anim_length;
  }

  return n_anim_length;
}

function private function_639a0acd683457ec(player, shotindex) {
  var_214d924f4e137244 = self;
  var_9ebbc3376d9ce8f2 = var_214d924f4e137244 function_d776460a61b689bf(shotindex);

  if(var_9ebbc3376d9ce8f2 && !isDefined(player.var_7c6c008ca46286b0)) {
    player.var_7c6c008ca46286b0 = spawn("script_arms", player.origin, 0, 0, player);
    player.var_7c6c008ca46286b0.animname = var_214d924f4e137244.sceneobject.variant_object.name;
    player.var_7c6c008ca46286b0 useanimtree(var_214d924f4e137244.sceneobject function_c106523f3836b90b());
    player.var_7c6c008ca46286b0 hide();
    player.var_7c6c008ca46286b0.entity = player;
    player.var_7c6c008ca46286b0 showonlytoplayer(player);
    player.var_7c6c008ca46286b0.noragdoll = 1;
    player.var_7c6c008ca46286b0 val::set("scene_scene", "cinematics_participant", 1);
    thread function_382ab03066aa1207(player, player.var_7c6c008ca46286b0);
  }
}

function private function_382ab03066aa1207(player, rig) {
  rig endon("death_or_disconnect");
  var_d1259a4ca338a8bd = 1;

  while(isDefined(player)) {
    var_8c9a37d8546a9e51 = player getcamerathirdperson();

    if(var_8c9a37d8546a9e51 && var_d1259a4ca338a8bd) {
      rig hide();
      var_d1259a4ca338a8bd = 0;
    } else if(!var_8c9a37d8546a9e51 && !var_d1259a4ca338a8bd) {
      rig showonlytoplayer(player);
      var_d1259a4ca338a8bd = 1;
    }

    waitframe();
  }

  rig delete();
}

function private function_a7bfaa03b4d58c00(player, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, n_anim_length) {
  var_214d924f4e137244 = self;
  function_639a0acd683457ec(player, shotindex);
  arcright = var_214d924f4e137244.sceneobject function_918dc2e0c83784b6(shotindex);
  arcleft = var_214d924f4e137244.sceneobject function_16b4cb7e4c5af0fd(shotindex);
  arctop = var_214d924f4e137244.sceneobject function_b06da1547120edef(shotindex);
  arcbottom = var_214d924f4e137244.sceneobject function_be3310ec58dd9807(shotindex);
  var_562ff78798cbfcc8 = var_214d924f4e137244.sceneobject function_8851aea907b47f88(shotindex);
  viewfraction = var_214d924f4e137244.sceneobject function_b083c5862877c8e3(shotindex);
  var_e854c1a35488c7d6 = function_a89f1262c5148bdf();
  player playerlinktoblend(player.var_7c6c008ca46286b0, var_e854c1a35488c7d6, lerptime);
  player playerlinktodelta(player.var_7c6c008ca46286b0, var_e854c1a35488c7d6, viewfraction, arcright, arcleft, arctop, arcbottom, var_562ff78798cbfcc8, 1, 1);
  player lerpviewangleclamp(blendtime, blendtime * 0.5, blendtime * 0.25, arcright, arcleft, arctop, arcbottom, 1);
  player.var_7c6c008ca46286b0 showonlytoplayer(player);
  var_6325cb53ec163839 = "none";

  if(blendtime > 0 && blendtime < 1) {
    var_6325cb53ec163839 = "normal";
  } else if(blendtime >= 1) {
    var_6325cb53ec163839 = "slow";
  }

  var_2e2a2f75fd49152a = getanimname(animasset);
  var_4fdfa3b181211e22 = var_866b3a3066122e39 * n_anim_length;

  if(var_214d924f4e137244 function_7f90ebd0aa7ad958(shotindex)) {
    player.var_7c6c008ca46286b0 animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime);
    player.var_7c6c008ca46286b0 scriptmodelplayanim(var_2e2a2f75fd49152a, undefined, var_4fdfa3b181211e22, undefined, var_6325cb53ec163839);
    player.var_7c6c008ca46286b0 function_ee012c2dd711a8ce(notifystring, "end", "stop_animmode");
  } else {
    player.var_7c6c008ca46286b0 scriptmodelplayanim(var_2e2a2f75fd49152a, undefined, var_4fdfa3b181211e22, undefined, var_6325cb53ec163839);
    player.var_7c6c008ca46286b0 waittill_any_timeout_1(getanimlength(animasset), "stop_animmode");
    player.var_7c6c008ca46286b0 notify(notifystring, "end");
  }

  return n_anim_length - var_4fdfa3b181211e22;
}

function private function_2d5d63169291228e(player, shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(player.var_7c6c008ca46286b0)) {
    if(isDefined(shotindex)) {
      tweenout = var_214d924f4e137244.sceneobject function_be64404b86d48153(shotindex);
      player function_af4b9b0f0e7c6c42(tweenout);
    } else {
      player function_af4b9b0f0e7c6c42(0);
    }

    player stopanimscriptsceneevent();
    player.var_7c6c008ca46286b0 delete();
  }
}

function private function_c14ed0fc1a6ccf72(sceneplay) {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;
  shotindex = sceneplay.var_df5db7bd235f2729[0];

  if(isDefined(player)) {
    function_639a0acd683457ec(player, shotindex);
  }
}

function private function_ca4527bcd586d366() {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;

  if(!isDefined(player)) {
    return [];
  }

  if(isDefined(player.var_7c6c008ca46286b0)) {
    return [player.var_7c6c008ca46286b0];
  }

  return [player];
}

function private function_f5c1014e1cfdf615(var_fa1af9d2277fd747) {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;
  var_214d924f4e137244 function_2f2327d535ed0bb();

  if(isDefined(player)) {
    scenescriptbundle = var_214d924f4e137244.sceneroot scene_scriptbundle();

    if(scenescriptbundle function_cf67ad1bae22e908()) {
      player function_e7257014ebaeeaa8(0);
    }
  }
}

function private function_e3f3a0837cae6779() {
  var_214d924f4e137244 = self;
  player = var_214d924f4e137244.entity;
  var_214d924f4e137244 function_2f2327d535ed0bb();

  if(isDefined(player)) {
    player notify("stop_loop");
    player notify("single anim", "end");
    player notify("looping anim", "end");
    player notify("stop_animmode");

    if(isPlayer(player)) {
      player stopanimscriptsceneevent();
    }

    function_2d5d63169291228e(player);
    player val::reset_all("scene_shot");
  }
}

function private function_24b6b2bfc5bdab36(animname, animtree) {
  var_214d924f4e137244 = self;
}

function private player_delete() {}

function private function_8cd22f505439309f(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype) {
  if(animationtype != "DeltaAnimation") {
    return;
  }

  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.var_b2de9e740fef7506)) {
    var_214d924f4e137244.var_b2de9e740fef7506 = spawnStruct();
  }

  var_214d924f4e137244.var_b2de9e740fef7506.newrequest = 1;
  var_214d924f4e137244.var_b2de9e740fef7506.shotindex = shotindex;
  var_214d924f4e137244.var_b2de9e740fef7506.animindex = animindex;
  var_214d924f4e137244.var_b2de9e740fef7506.notifystring = notifystring;
  var_214d924f4e137244.var_b2de9e740fef7506.alignmentinfo = alignmentinfo;
  var_214d924f4e137244.var_b2de9e740fef7506.alignmentinfo.origin = alignmentinfo.origin;
  var_214d924f4e137244.var_b2de9e740fef7506.alignmentinfo.angles = alignmentinfo.angles;
  var_214d924f4e137244.var_b2de9e740fef7506.animasset = animasset;
  var_214d924f4e137244.var_b2de9e740fef7506.var_866b3a3066122e39 = var_866b3a3066122e39;
  var_214d924f4e137244.var_b2de9e740fef7506.blendtime = blendtime;
  var_214d924f4e137244.var_b2de9e740fef7506.blendcurve = blendcurve;
  var_214d924f4e137244.var_b2de9e740fef7506.lerptime = lerptime;
  var_214d924f4e137244.var_b2de9e740fef7506.var_fe62dc1bdc14feca = gettime();
}

function private function_3e4cf61872dc003b(animationtype, shotindex, animindex) {
  if(!isDefined(animationtype) || animationtype != "DeltaAnimation") {
    return;
  }

  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.var_b2de9e740fef7506)) {
    return;
  }

  if(shotindex == var_214d924f4e137244.var_b2de9e740fef7506.shotindex && animindex == var_214d924f4e137244.var_b2de9e740fef7506.animindex) {
    var_214d924f4e137244.var_b2de9e740fef7506 = undefined;
  }
}

function private agent_spawn(spawnorigin, spawnangles) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.sceneobject.variant_object.aitypename)) {
    var_373a2c3b02b1d81c = "aitype";
    var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject.variant_object.aitypename;
  } else if(isDefined(var_214d924f4e137244.sceneobject.variant_object.charactername)) {
    var_373a2c3b02b1d81c = "character";
    var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject.variant_object.charactername;
  } else {
    var_373a2c3b02b1d81c = "xmodel";
    var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject.variant_object.xmodelname;
  }

  if(isDefined(var_214d924f4e137244.entity)) {
    if(isagent(var_214d924f4e137244.entity)) {
      var_214d924f4e137244.entity scripts\cp_mp\agents\agent_utils::despawnagent();
    } else {
      var_214d924f4e137244.entity delete();
    }
  }

  entity = undefined;
  var_e94f24c42205140 = "team_eighty";

  if(var_373a2c3b02b1d81c == "aitype") {
    if(isDefined(var_214d924f4e137244.sceneobject.variant_object.var_c8b64adafd8e5711)) {
      var_e51bc72666444e2d = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc(var_214d924f4e137244.sceneobject.variant_object.var_c8b64adafd8e5711);
      var_3a7ad9d5e8329009 = random(var_e51bc72666444e2d);
      var_6fc4d2978cf27bef = default_to(var_3a7ad9d5e8329009, var_6fc4d2978cf27bef);
    }

    if(scripts\engine\utility::issharedfuncdefined("ai", "get_aitype_default_spawn_team_SharedFunc")) {
      var_e94f24c42205140 = namespace_53fc9ddbb516e6e1::get_aitype_default_spawn_team_sharedfunc();
    }

    if(scripts\engine\utility::issharedfuncdefined("ai", "spawnNewAIType_SharedFunc")) {
      entity = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(var_6fc4d2978cf27bef, spawnorigin, spawnangles, var_e94f24c42205140);
    } else {
      entity = scripts\mp\mp_agent::spawnnewagentaitype(var_6fc4d2978cf27bef, spawnorigin, spawnangles, var_e94f24c42205140);
    }

    entity useanimtree(var_214d924f4e137244.sceneobject.variant_object.animtree.id);
  }

  return entity;
}

function private function_12f50a9b21b4dd9a(entity) {
  var_214d924f4e137244 = self;
  return isagent(entity) && isalive(entity);
}

function private function_61be92922a464251(sceneplay, shotindex, objectindex) {
  function_bea88b25e17cea66(sceneplay, shotindex, objectindex);
}

function private function_6dad63edc3390487(alignmentinfo, shotindex) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244.entity;
  shotanimations = var_214d924f4e137244.sceneobject function_79edcc9987330a2a(shotindex);

  if(shotanimations.size != 0) {
    animasset = shotanimations[0];
    function_549578bb9e3f4f78(entity, alignmentinfo, animasset, undefined, undefined, undefined, 0);

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x81>" + function_3c8848a3a11b2553(getanimname(animasset)), entity.origin, entity.angles);

    function_ce4b6d4d859ede39(var_214d924f4e137244, "<dev string:x91>" + function_3c8848a3a11b2553(getanimname(animasset)), alignmentinfo.origin, alignmentinfo.angles);
  }
}

function private function_43a42c8097aac565(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244.entity;
  var_d77e596283581825 = entity function_d28a53b100cbdda7(var_214d924f4e137244, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, undefined);
  return var_d77e596283581825;
}

function private function_549578bb9e3f4f78(entity, alignmentinfo, animasset, var_7c6075e90a7b0fa, lerptime, var_866b3a3066122e39, animrate) {
  if(!isDefined(lerptime)) {
    lerptime = 0;
  }

  if(!isDefined(var_866b3a3066122e39)) {
    var_866b3a3066122e39 = 0;
  }

  if(!isDefined(animrate)) {
    animrate = 1;
  }

  var_214d924f4e137244 = self;

  if(!isagent(entity) || !isalive(entity)) {
    return;
  }

  function_e4fc30ccdca08b9d(alignmentinfo);
  var_2e2a2f75fd49152a = getanimname(animasset);
  entity.var_34a25b21bc155d14 = var_214d924f4e137244.sceneobject.variant_object.var_7c6075e90a7b0fa;

  if(isDefined(var_7c6075e90a7b0fa)) {
    entity.var_34a25b21bc155d14 = var_7c6075e90a7b0fa;
  }

  if(isDefined(entity.var_34a25b21bc155d14)) {
    entity setoverridearchetype("animscript", entity.var_34a25b21bc155d14, 0);
  }

  entity asmsetstate(entity.asmname, "animscripted");
  animindex = entity asm_lookupanimfromalias("animscripted", var_2e2a2f75fd49152a);
  entity.var_b65a7211c663d3ed = animindex;
  entity animmode("noclip");
  startorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
  startangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);

  if(lerptime == 0) {
    entity dontinterpolate();
  }

  entity orientmode("face angle", entity.angles[1]);
  entity scripts\asm\asm_bb::bb_setanimScripted();

  if(isDefined(entity.scripted_mode)) {
    entity.scripted_mode = 1;
  }

  if(isent(alignmentinfo.alignent)) {
    entity unlink();
    entity forceteleport(startorigin, startangles);

    if(isDefined(alignmentinfo.aligntag)) {
      entity linktomoveoffset(alignmentinfo.alignent, alignmentinfo.aligntag);
    } else {
      entity linktomoveoffset(alignmentinfo.alignent);
    }
  } else {
    entity forceteleport(startorigin, startangles);
  }

  entity aisetanim("animscripted", animindex, animrate, var_866b3a3066122e39);
  entity callback::remove("on_ai_killed", &function_c1a5da4f68a742a6, 1);
  entity callback::add("on_ai_killed", &function_c1a5da4f68a742a6);
}

function private function_d28a53b100cbdda7(var_214d924f4e137244, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, var_7c6075e90a7b0fa) {
  entity = self;
  entity endon("scene_monitor_players_agent_will_be_despawned");
  entity endon("scene_monitor_players_new_animation_for_agent");
  entity endon("agent_scene_stop");
  entity endon("death_or_disconnect");

  if(!isDefined(entity)) {
    return;
  }

  if(!isagent(entity)) {
    return;
  }

  if(!isalive(entity)) {
    return;
  }

  blendtime = default_to(blendtime, 0);
  lerptime = default_to(lerptime, 0);

  if(isDefined(var_214d924f4e137244.scenedata.var_43286fd46706909c)) {
    blendtime = 0;
    lerptime = 0;
  }

  var_2e2a2f75fd49152a = getanimname(animasset);
  n_anim_length = getanimlength(animasset);
  var_7a4a31d740c51ee8 = n_anim_length - var_866b3a3066122e39 * n_anim_length;

  if(var_866b3a3066122e39 < 1) {
    var_214d924f4e137244 childthread function_8e9f8e1fbe2b7ab4(notifystring, animasset);
  }

  var_214d924f4e137244 function_549578bb9e3f4f78(entity, alignmentinfo, animasset, var_7c6075e90a7b0fa, lerptime, var_866b3a3066122e39);
  var_214d924f4e137244 function_bdfc45b799d27532(animasset);

  if(var_866b3a3066122e39 < 1) {
    if(function_8581f011ce975a6(animasset)) {
      while(true) {
        var_6fde8947aa74cf43 = entity scripts\asm\asm::asm_donotetracks(entity.asmname, "animscripted", scripts\asm\asm::asm_getnotehandler(entity.asmname, "animscripted"));

        if(is_equal(var_6fde8947aa74cf43, "end")) {
          break;
        }
      }
    } else {
      wait var_7a4a31d740c51ee8;
    }
  }

  entity.var_b65a7211c663d3ed = undefined;

  if(isDefined(entity.scripted_mode)) {
    entity.scripted_mode = 0;
  }

  entity scripts\asm\asm_bb::bb_clearanimScripted();
  entity orientmode("face current");
  entity animmode("none");

  if(isDefined(entity.var_34a25b21bc155d14)) {
    entity clearoverridearchetype("animscript");
    entity.var_34a25b21bc155d14 = undefined;
  }

  return var_7a4a31d740c51ee8;
}

function private function_c1a5da4f68a742a6(params) {
  if(isDefined(self)) {
    if(isDefined(self.var_34a25b21bc155d14)) {
      self clearoverridearchetype("animscript");
      self.var_34a25b21bc155d14 = undefined;
    }

    if(isDefined(self.var_214d924f4e137244)) {
      self.var_214d924f4e137244.entity = undefined;
      self.var_214d924f4e137244 = undefined;
    }

    callback::remove("on_ai_killed", &function_c1a5da4f68a742a6, 1);
  }
}

function private function_2d573d9c69823343() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity notify("stop_loop");
    var_214d924f4e137244.entity notify("single anim", "end");
    var_214d924f4e137244.entity notify("looping anim", "end");
    var_214d924f4e137244.entity notify("stop_animmode");
    var_214d924f4e137244.entity notify("agent_scene_stop");

    if(isDefined(var_214d924f4e137244.entity.scripted_mode)) {
      var_214d924f4e137244.entity.scripted_mode = 0;
    }

    if(isalive(var_214d924f4e137244.entity) && var_214d924f4e137244.entity scripts\asm\asm_bb::bb_isanimScripted()) {
      var_214d924f4e137244.entity scripts\asm\asm_bb::bb_clearanimScripted();
    }

    var_214d924f4e137244.entity orientmode("face current");
    var_214d924f4e137244.entity animmode("none");
    var_214d924f4e137244.entity stopanimScripted();
    var_214d924f4e137244.entity.var_b65a7211c663d3ed = undefined;

    if(isDefined(var_214d924f4e137244.entity.var_34a25b21bc155d14)) {
      var_214d924f4e137244.entity clearoverridearchetype("animscript");
      var_214d924f4e137244.entity.var_34a25b21bc155d14 = undefined;
    }
  }
}

function private agent_delete() {
  var_214d924f4e137244 = self;

  if(isagent(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity.nocorpse = 1;
    var_214d924f4e137244.entity scripts\cp_mp\agents\agent_utils::despawnagent();
    return;
  }

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity delete();
  }
}

function private function_642077a65edc7954(shotindex) {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.entity)) {
    return;
  }

  if(isDefined(var_214d924f4e137244.entity.scripted_mode)) {
    var_214d924f4e137244.entity.scripted_mode = 0;
  }

  if(isalive(var_214d924f4e137244.entity) && var_214d924f4e137244.entity scripts\asm\asm_bb::bb_isanimScripted()) {
    var_214d924f4e137244.entity scripts\asm\asm_bb::bb_clearanimScripted();
  }

  var_214d924f4e137244.entity orientmode("face current");
  var_214d924f4e137244.entity animmode("none");
  var_214d924f4e137244.entity stopanimScripted();
  var_214d924f4e137244.entity.var_b65a7211c663d3ed = undefined;

  if(isDefined(var_214d924f4e137244.entity.var_34a25b21bc155d14)) {
    var_214d924f4e137244.entity clearoverridearchetype("animscript");
    var_214d924f4e137244.entity.var_34a25b21bc155d14 = undefined;
  }
}

function private function_70bd06355933aec9(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244.entity;

  if(!isDefined(entity)) {
    return;
  }

  animlengthtime = 0;
  done = 0;

  if(entity.model == "") {
    println("<dev string:xa7>" + var_214d924f4e137244.sceneobject.variant_object.name + "<dev string:xda>");
    return 0;
  }

  entity val::set("scene_shot", "cinematics_participant", 1);

  if(isDefined(var_214d924f4e137244.scenedata.var_43286fd46706909c)) {
    blendtime = 0;
    lerptime = 0;
  }

  var_2e2a2f75fd49152a = getanimname(animasset);
  function_e4fc30ccdca08b9d(alignmentinfo);
  var_6325cb53ec163839 = "none";

  if(blendtime > 0 && blendtime < 1) {
    var_6325cb53ec163839 = "normal";
  } else if(blendtime >= 1) {
    var_6325cb53ec163839 = "slow";
  }

  var_bc4340437549698a = 0;

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0) {
    var_bc4340437549698a = getanimlength(animasset) * var_866b3a3066122e39;
  }

  if(var_866b3a3066122e39 < 1) {
    var_214d924f4e137244 childthread function_8e9f8e1fbe2b7ab4(notifystring, animasset);
  }

  if(var_214d924f4e137244 function_7f90ebd0aa7ad958(shotindex)) {
    var_6db82a0c287ea33 = var_214d924f4e137244.scenedata.scenescriptbundle function_ee55ab255c0be00d();

    if(var_6db82a0c287ea33 == "AnimScripted") {
      entity scriptmodelclearanim();
      entity useanimtree(var_214d924f4e137244.sceneobject function_c106523f3836b90b());
      entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime);
      entity scriptmodelplayanim(var_2e2a2f75fd49152a, undefined, var_bc4340437549698a, 1, var_6325cb53ec163839);
      var_214d924f4e137244 function_bdfc45b799d27532(animasset);

      if(var_866b3a3066122e39 < 1) {
        entity function_ee012c2dd711a8ce(notifystring, "end", "stop_animmode");
      }
    } else if(var_6db82a0c287ea33 == "ScriptModelPlayAnimDeltaMotionFromPos") {
      entity stopuseanimtree();
      entity scriptmodelplayanimdeltamotionfrompos(var_2e2a2f75fd49152a, alignmentinfo.origin, alignmentinfo.angles, notifystring, var_bc4340437549698a, var_6325cb53ec163839);
      var_214d924f4e137244 function_bdfc45b799d27532(animasset);

      if(var_866b3a3066122e39 < 1) {
        entity function_ee012c2dd711a8ce(notifystring, "end", "stop_animmode");
      }
    }
  } else {
    entity stopuseanimtree();
    entity scriptmodelplayanim(var_2e2a2f75fd49152a, notifystring, var_bc4340437549698a, 1, var_6325cb53ec163839);
    var_214d924f4e137244 function_bdfc45b799d27532(animasset);
    entity function_ee012c2dd711a8ce(notifystring, "end", "stop_animmode");
    entity scriptmodelclearanim();
    entity useanimtree(var_214d924f4e137244.sceneobject function_c106523f3836b90b());
  }

  animlengthtime += getanimlength(animasset);
  return animlengthtime - var_866b3a3066122e39 * animlengthtime;
}

function private function_5552728c9588fd02(shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244.entity;

  if(!isDefined(entity)) {
    return;
  }

  animlengthtime = 0;
  done = 0;

  if(entity.model == "") {
    println("<dev string:xa7>" + var_214d924f4e137244.sceneobject.variant_object.name + "<dev string:xda>");
    return 0;
  }

  entity endon("death_or_disconnect");
  entity endon("vehicle_scene_stop");
  blendtime = default_to(blendtime, 0);
  lerptime = default_to(lerptime, 0);

  if(isDefined(var_214d924f4e137244.scenedata.var_43286fd46706909c)) {
    blendtime = 0;
    lerptime = 0;
  }

  var_2e2a2f75fd49152a = getanimname(animasset);
  function_e4fc30ccdca08b9d(alignmentinfo);

  if(entity vehicle_isphysveh()) {
    entity function_247ad6a91f6a4ffe(1);
    entity vehphys_forcekeyframedmotion();
  } else {
    entity notsolid();
  }

  if(lerptime == 0) {
    entity dontinterpolate();
  }

  startorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
  startangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);
  entity vehicle_teleport(startorigin, startangles);

  if(var_866b3a3066122e39 < 1) {
    var_214d924f4e137244 childthread function_8e9f8e1fbe2b7ab4(notifystring, animasset);
  }

  entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime);
  entity vehicleplayanim(animasset);
  var_214d924f4e137244 function_bdfc45b799d27532(animasset);

  if(isDefined(var_866b3a3066122e39) && var_866b3a3066122e39 > 0 && var_866b3a3066122e39 <= 1) {
    if(var_866b3a3066122e39 == 1 && function_8581f011ce975a6(animasset)) {
      var_866b3a3066122e39 = 0.999;
    }

    var_214d924f4e137244 function_380708345e16e475(animasset, var_866b3a3066122e39);
  }

  animlengthtime += getanimlength(animasset);
  n_wait_time = animlengthtime - var_866b3a3066122e39 * animlengthtime;

  if(var_866b3a3066122e39 < 1) {
    wait n_wait_time;
  }

  if(entity vehicle_isphysveh()) {
    entity function_247ad6a91f6a4ffe(0);
    entity vehphys_setdefaultmotion();
  } else {
    entity solid();
  }

  if(isDefined(entity.var_cb77a772d04fc8e4)) {
    entity thread[[entity.var_cb77a772d04fc8e4]]();
  }

  return n_wait_time;
}

function private function_b8c3ea8ca94cea0c() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity notify("stop_loop");
    var_214d924f4e137244.entity notify("single anim", "end");
    var_214d924f4e137244.entity notify("looping anim", "end");
    var_214d924f4e137244.entity notify("stop_animmode");
    var_214d924f4e137244.entity notify("vehicle_scene_stop");
    var_214d924f4e137244.entity stopanimScripted();

    if(var_214d924f4e137244.entity vehicle_isphysveh()) {
      var_214d924f4e137244.entity function_247ad6a91f6a4ffe(0);
      var_214d924f4e137244.entity vehphys_setdefaultmotion();
      return;
    }

    var_214d924f4e137244.entity solid();
  }
}

function private vehicle_spawn_mp(spawnorigin, spawnangles) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.sceneobject.variant_object.vehiclename)) {
    var_373a2c3b02b1d81c = "vehicle";
    var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject.variant_object.vehiclename;
  } else {
    var_373a2c3b02b1d81c = "xmodel";
    var_6fc4d2978cf27bef = var_214d924f4e137244.sceneobject.variant_object.xmodelname;
  }

  if(!isDefined(var_214d924f4e137244.entity)) {
    if(var_373a2c3b02b1d81c == "vehicle") {
      spawndata = spawnStruct();
      spawndata.origin = spawnorigin;
      spawndata.angles = spawnangles;
      spawndata.vehicletype = var_6fc4d2978cf27bef;
      spawndata.targetname = "scene_vehicle";
      spawndata.modelname = vehicle_modelname(var_6fc4d2978cf27bef);
      var_214d924f4e137244.entity = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata);
    } else {
      var_214d924f4e137244.entity = utility::spawn_model(var_6fc4d2978cf27bef, spawnorigin, spawnangles);
    }
  }

  return var_214d924f4e137244.entity;
}

function private vehicle_delete() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity delete();
  }
}

function private function_684629695ffebbdb(entity) {
  return entity scripts\common\vehicle::isvehicle();
}

function private function_2e11be8a4ef151b5(animname, animtree) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity) && !isDefined(var_214d924f4e137244.entity.animname)) {
    var_214d924f4e137244.entity.animname = animname;
  }
}

function private function_cc538c3233d741af() {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity stopanimScripted();
    var_214d924f4e137244.entity scriptmodelclearanim();
    var_214d924f4e137244.entity notify("stop_loop");
    var_214d924f4e137244.entity notify("single anim", "end");
    var_214d924f4e137244.entity notify("looping anim", "end");
    var_214d924f4e137244.entity notify("stop_animmode");
  }
}

function private function_8bac7edf73a29d6b(alignmentinfo, shotindex) {
  var_214d924f4e137244 = self;

  if(isDefined(var_214d924f4e137244.entity)) {
    var_214d924f4e137244.entity scriptmodelclearanim();
  }
}

function private function_e8800b55f7cbd5a4(origin, angles) {
  var_214d924f4e137244 = self;
  entity = var_214d924f4e137244.entity;

  if(isDefined(entity)) {
    if(!isagent(entity) && !isPlayer(entity) && entity.model != "") {
      entity scriptmodelclearanim();
    }

    entity dontinterpolate();

    if(isDefined(origin)) {
      entity.origin = origin;
    }

    if(isDefined(angles)) {
      entity.angles = angles;
    }
  }
}

function private function_83f1be5a5eb5f706(entity) {
  if(isDefined(entity.classname) && entity.classname == "script_model") {
    return true;
  }

  return false;
}

function private function_d776460a61b689bf(shotindex) {
  var_214d924f4e137244 = self;

  if(!isDefined(var_214d924f4e137244.sceneobject.variant_object.shots)) {
    return 0;
  }

  if(shotindex < 0 || shotindex >= var_214d924f4e137244.sceneobject.variant_object.shots.size) {
    return 0;
  }

  shotobject = var_214d924f4e137244.sceneobject.variant_object.shots[shotindex];
  return default_to(shotobject.var_25a8d725d83b4fc1, 0);
}

function private function_4e15410d3aae945c() {
  var_214d924f4e137244 = self;
  agenttype = var_214d924f4e137244 function_a2142af2db8fbb0();
  return isDefined(agenttype) && agenttype.size > 0;
}

function private function_f66e8916121d9737() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject.variant_object.var_8e16e8d6f4501d72;
}

function private function_a2142af2db8fbb0() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject.variant_object.var_ab73f93a436a7409;
}

function private function_7c9fcb0161b76b2d() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject.variant_object.var_ed40a4854b93740c;
}

function private function_23cc62938b72190b() {
  var_214d924f4e137244 = self;
  return var_214d924f4e137244.sceneobject.variant_object.var_6b7d083fa865688a;
}

function private function_22f6fca8362a92b() {
  sceneplay = self;
  sceneplay endon("Stopped");
  scenedata = sceneplay.sceneroot.scenedata;

  if(!isDefined(sceneplay.var_ca29a69dc742b367)) {
    sceneplay.var_ca29a69dc742b367 = [];
  }

  var_6e050937039896b9 = 0;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(var_214d924f4e137244 object_get_type() == "Types_Player") {
      sceneplay.var_ca29a69dc742b367[var_6e050937039896b9] = spawnStruct();
      sceneplay.var_ca29a69dc742b367[var_6e050937039896b9].replacementallowed = 1;

      if(var_214d924f4e137244 function_3e13497ed7044cbd()) {
        if(isDefined(var_214d924f4e137244.var_17f5321d96d1bf24)) {
          if(isDefined(scenedata.var_214d924f4e137244[var_214d924f4e137244.var_17f5321d96d1bf24].entity)) {
            sceneplay.var_ca29a69dc742b367[var_6e050937039896b9].replacementallowed = 0;
          }
        }
      } else if(isDefined(var_214d924f4e137244.var_9668be326e00024b)) {
        if(isDefined(scenedata.var_214d924f4e137244[var_214d924f4e137244.var_9668be326e00024b].entity)) {
          sceneplay.var_ca29a69dc742b367[var_6e050937039896b9].replacementallowed = 0;
        }
      }

      var_6e050937039896b9++;
    }
  }

  sceneplay function_a8bfee1f6abe8209();

  while(true) {
    waittillframeend();
    playerindex = 0;

    for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
      var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

      if(var_214d924f4e137244 object_get_type() == "Types_Player") {
        replacementallowed = istrue(sceneplay.var_ca29a69dc742b367[playerindex].replacementallowed);
        replacementisenabled = var_214d924f4e137244 function_4e15410d3aae945c() || isDefined(var_214d924f4e137244 function_f66e8916121d9737());

        if(replacementallowed && replacementisenabled && !isDefined(var_214d924f4e137244.entity) && !var_214d924f4e137244 function_fe495eb5e40771ec(scenedata)) {
          entitydesc = sceneplay.var_ca29a69dc742b367[playerindex];
          var_84cccd2e89c1bbe7 = !isDefined(var_214d924f4e137244 function_f66e8916121d9737());

          if(var_84cccd2e89c1bbe7) {
            if(isDefined(var_214d924f4e137244.var_b2de9e740fef7506) && !isDefined(entitydesc.agententity)) {
              var_214d924f4e137244 function_fa25c05bae26b761(var_214d924f4e137244.var_b2de9e740fef7506, entitydesc);
            }

            if(isDefined(var_214d924f4e137244.var_b2de9e740fef7506) && var_214d924f4e137244.var_b2de9e740fef7506.newrequest) {
              agententity = entitydesc.agententity;

              if(isDefined(agententity)) {
                agententity notify("scene_monitor_players_new_animation_for_agent");
                var_6751e5eb36fccfa9 = var_214d924f4e137244.var_b2de9e740fef7506;
                n_anim_length = getanimlength(var_6751e5eb36fccfa9.animasset);
                var_b7d39a4661f3460 = gettime();
                var_c952be88c3ffef2f = (var_b7d39a4661f3460 - var_6751e5eb36fccfa9.var_fe62dc1bdc14feca) / 1000;
                var_53cea02c2ced41aa = var_6751e5eb36fccfa9.var_866b3a3066122e39;

                if(n_anim_length > 0) {
                  var_53cea02c2ced41aa += var_c952be88c3ffef2f / n_anim_length;
                }

                var_7c6075e90a7b0fa = var_214d924f4e137244 function_23cc62938b72190b();
                agententity thread function_d28a53b100cbdda7(var_214d924f4e137244, var_6751e5eb36fccfa9.shotindex, var_6751e5eb36fccfa9.animindex, var_6751e5eb36fccfa9.notifystring, var_6751e5eb36fccfa9.alignmentinfo, var_6751e5eb36fccfa9.animasset, var_53cea02c2ced41aa, var_6751e5eb36fccfa9.blendtime, var_6751e5eb36fccfa9.blendcurve, var_6751e5eb36fccfa9.lerptime, var_7c6075e90a7b0fa);
                var_214d924f4e137244.var_b2de9e740fef7506.newrequest = 0;
              }
            }
          } else {
            if(isDefined(var_214d924f4e137244.var_b2de9e740fef7506) && !isDefined(entitydesc.scriptmodelentity)) {
              modelname = var_214d924f4e137244 function_f66e8916121d9737();
              entitydesc.scriptmodelentity = function_6a16552e40cb91e1(var_214d924f4e137244.var_b2de9e740fef7506.alignmentinfo.origin, var_214d924f4e137244.var_b2de9e740fef7506.alignmentinfo.angles, modelname);
              var_214d924f4e137244.replacemententity = entitydesc.scriptmodelentity;
              var_214d924f4e137244.entity = var_214d924f4e137244.replacemententity;
              var_214d924f4e137244 function_535e6f4c06c15b1d(sceneplay, 1, 0, var_214d924f4e137244.alignmentinfo);
            }

            if(isDefined(var_214d924f4e137244.var_b2de9e740fef7506) && var_214d924f4e137244.var_b2de9e740fef7506.newrequest) {
              scriptmodelentity = entitydesc.scriptmodelentity;

              if(isDefined(scriptmodelentity)) {
                var_6751e5eb36fccfa9 = var_214d924f4e137244.var_b2de9e740fef7506;
                n_anim_length = getanimlength(var_6751e5eb36fccfa9.animasset);
                var_b7d39a4661f3460 = gettime();
                var_c952be88c3ffef2f = float(var_b7d39a4661f3460 - var_6751e5eb36fccfa9.var_fe62dc1bdc14feca) / 1000;
                var_2e2a2f75fd49152a = getanimname(var_6751e5eb36fccfa9.animasset);
                var_6325cb53ec163839 = "none";
                scriptmodelentity stopuseanimtree();
                scriptmodelentity scriptmodelplayanimdeltamotionfrompos(var_2e2a2f75fd49152a, var_6751e5eb36fccfa9.alignmentinfo.origin, var_6751e5eb36fccfa9.alignmentinfo.angles, var_6751e5eb36fccfa9.notifystring, var_c952be88c3ffef2f, var_6325cb53ec163839);
                var_214d924f4e137244.var_b2de9e740fef7506.newrequest = 0;
              }
            }
          }
        }

        playerindex++;
      }
    }

    waitframe();
  }
}

function private function_276d3342cddac11a() {
  sceneplay = self;

  if(!isDefined(sceneplay.var_ca29a69dc742b367)) {
    return;
  }

  foreach(entitydesc in sceneplay.var_ca29a69dc742b367) {
    function_f4cf37b2c85bb5c0(entitydesc);
    function_870557fc814fab46(entitydesc);
  }

  sceneplay.var_ca29a69dc742b367 = undefined;
}

function private function_fa25c05bae26b761(var_6751e5eb36fccfa9, entitydesc) {
  var_214d924f4e137244 = self;
  agent_type = var_214d924f4e137244 function_a2142af2db8fbb0();
  agent_team = var_214d924f4e137244 function_7c9fcb0161b76b2d();
  newagent = scripts\mp\mp_agent::spawnnewagentaitype(agent_type, var_6751e5eb36fccfa9.alignmentinfo.origin, var_6751e5eb36fccfa9.alignmentinfo.angles, agent_team);
  entitydesc.agententity = newagent;
  var_214d924f4e137244.replacemententity = newagent;
  var_214d924f4e137244.entity = newagent;
  var_214d924f4e137244 function_535e6f4c06c15b1d(var_214d924f4e137244.sceneplay, 1, 0, var_214d924f4e137244.alignmentinfo);
}

function private function_f4cf37b2c85bb5c0(entitydesc) {
  if(!isDefined(entitydesc.agententity)) {
    return;
  }

  agententity = entitydesc.agententity;
  agententity notify("scene_monitor_players_agent_will_be_despawned");
  assert(isagent(agententity));
  agententity.nocorpse = 1;
  agententity scripts\cp_mp\agents\agent_utils::despawnagent();
  entitydesc.agententity = undefined;
}

function private function_6a16552e40cb91e1(spawnorigin, spawnangles, modelname) {
  newentity = utility::spawn_model(modelname, spawnorigin, spawnangles);
  newentity forcenetfieldhighlod(1);
  newentity val::set("scene_shot", "cinematics_participant", 1);
  return newentity;
}

function private function_870557fc814fab46(entitydesc) {
  if(!isDefined(entitydesc.scriptmodelentity)) {
    return;
  }

  scriptmodelentity = entitydesc.scriptmodelentity;
  scriptmodelentity delete();
  entitydesc.scriptmodelentity = undefined;
}

function private function_a8bfee1f6abe8209() {
  sceneplay = self;
  scenedata = sceneplay.sceneroot.scenedata;
  playerindex = 0;

  for(var_56f4af8746a2d458 = 0; var_56f4af8746a2d458 < scenedata.var_214d924f4e137244.size; var_56f4af8746a2d458++) {
    var_214d924f4e137244 = scenedata.var_214d924f4e137244[var_56f4af8746a2d458];

    if(var_214d924f4e137244 object_get_type() == "Types_Player") {
      replacementallowed = istrue(sceneplay.var_ca29a69dc742b367[playerindex].replacementallowed);
      replacementisenabled = isDefined(var_214d924f4e137244 function_f66e8916121d9737());

      if(replacementallowed && replacementisenabled && !isDefined(var_214d924f4e137244.entity)) {
        entitydesc = sceneplay.var_ca29a69dc742b367[playerindex];

        if(!isDefined(entitydesc.scriptmodelentity)) {
          spawnorigin = sceneplay.sceneroot.origin;
          spawnorigin += (0, 0, -200);
          spawnangles = sceneplay.sceneroot.angles;
          modelname = var_214d924f4e137244 function_f66e8916121d9737();
          entitydesc.scriptmodelentity = function_6a16552e40cb91e1(spawnorigin, spawnangles, modelname);
          var_214d924f4e137244.replacemententity = entitydesc.scriptmodelentity;
          var_214d924f4e137244.entity = var_214d924f4e137244.replacemententity;

          if(isDefined(var_214d924f4e137244.alignmentinfo)) {
            var_214d924f4e137244 function_535e6f4c06c15b1d(sceneplay, 1, 0, var_214d924f4e137244.alignmentinfo);
          }
        }
      }

      playerindex++;
    }
  }
}

function private function_fe495eb5e40771ec(scenedata) {
  var_214d924f4e137244 = self;

  if(var_214d924f4e137244 object_get_type() != "Types_Player") {
    return false;
  }

  if(var_214d924f4e137244 function_3e13497ed7044cbd()) {
    if(isDefined(var_214d924f4e137244.var_17f5321d96d1bf24)) {
      return isDefined(scenedata.var_214d924f4e137244[var_214d924f4e137244.var_17f5321d96d1bf24].replacemententity);
    }

    return false;
  }

  if(isDefined(var_214d924f4e137244.var_9668be326e00024b)) {
    return isDefined(scenedata.var_214d924f4e137244[var_214d924f4e137244.var_9668be326e00024b].replacemententity);
  }

  return false;
}

function function_720d21706a7ff164() {
  return true;
}

function function_f66b22351778fe49(enabled) {
  assert(isPlayer(self));
  player = self;
  player scripts\common\utility::letterbox_enable(enabled, 0);
}

function function_d18c2d3d2819c322(entity, var_214d924f4e137244) {
  assert(isPlayer(entity));
  scenedata = var_214d924f4e137244.scenedata;
  var_dbdcde08b6a6c0f2 = var_214d924f4e137244 function_3e13497ed7044cbd();

  if(var_dbdcde08b6a6c0f2) {
    if(isDefined(var_214d924f4e137244.var_17f5321d96d1bf24)) {
      if(isDefined(scenedata.var_214d924f4e137244[var_214d924f4e137244.var_17f5321d96d1bf24].entity)) {
        return false;
      }
    }
  } else if(isDefined(var_214d924f4e137244.var_9668be326e00024b)) {
    if(isDefined(scenedata.var_214d924f4e137244[var_214d924f4e137244.var_9668be326e00024b].entity)) {
      return false;
    }
  }

  var_a7f983dc6ed7cd38 = entity scripts\cp_mp\utility\player_utility::isfemale();

  if(var_dbdcde08b6a6c0f2 != var_a7f983dc6ed7cd38) {
    return false;
  }

  return true;
}