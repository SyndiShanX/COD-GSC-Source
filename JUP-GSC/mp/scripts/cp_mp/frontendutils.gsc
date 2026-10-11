/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\frontendutils.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\frontendfiringrange;
#using scripts\cp_mp\frontendutils;
#using scripts\engine\utility;
#using scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting;
#namespace frontendutils;

function init_frontend_utils() {
  create_camera_position_list();
  setup_initial_entities();
}

function function_186283adf8bff6d8() {
  setup_rarity_ui_images();
  initialize_transition_array();
  function_e7f97d640f18b510();

  thread debug_frontend();
  thread function_19ed7aafb3fc1018();
  thread function_3f816666273fe6a();

  thread frontend_camera_watcher(&camera_section_change);
  thread luinotifylistener();
  level thread function_dd495345615b5918();
  callback::add("on_camera_section_change", &on_camera_section_change);
}

function private on_camera_section_change(params) {
  gametype = getDvar(@ "ui_gametype");

  if(gametype == "ob") {
    if(isDefined(params.newroom) && (params.newroom == "character_faction_select_l_detail" || params.newroom == "character_tango")) {
      level notify("frontendWorldEvent_singleton");
      var_8014179938a618d3 = function_c6044b8ca41f9f54();

      if(isDefined(var_8014179938a618d3)) {
        deactivateworldevent(var_8014179938a618d3);
      }

      function_61bd6a757e62669d("war");
      return;
    }

    if(isDefined(params.previousroom) && (params.previousroom == "character_faction_select_l_detail" || params.previousroom == "character_tango")) {
      var_8014179938a618d3 = function_c6044b8ca41f9f54();

      if(isDefined(var_8014179938a618d3)) {
        level thread function_e45789a4e87d849e(var_8014179938a618d3);
      }

      function_61bd6a757e62669d(gametype);
    }
  }
}

function function_c6044b8ca41f9f54() {
  level.gamemodebundle = getgamemodescriptbundle();
  return level.gamemodebundle.frontendworldevent;
}

function function_61bd6a757e62669d(gametype) {
  scriptables = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "gametype");

  foreach(thing in scriptables) {
    if(thing getscriptableparthasstate("gametype", gametype)) {
      thing setscriptablepartstate("gametype", gametype, 1);
      continue;
    }

    thing setscriptablepartstate("gametype", "base");
  }
}

function private function_e45789a4e87d849e(world_event) {
  self notify("frontendWorldEvent_singleton");
  self endon("frontendWorldEvent_singleton");
  var_1d4be4bd22a67641 = getdvarfloat(@ "hash_9a16f0a0d73bb50c", 5);
  var_f9f5d82c075a9337 = 0.05;
  total_attempts = var_1d4be4bd22a67641 / var_f9f5d82c075a9337;

  for(attempt = 0; attempt < total_attempts; attempt++) {
    activateworldevent(world_event);
    wait var_f9f5d82c075a9337;
  }
}

function private function_dd495345615b5918() {
  if(istrue(level.var_9d17eff57558bc04)) {
    return;
  }

  level.var_9d17eff57558bc04 = 1;
  last_type = "";
  world_event = undefined;

  while(true) {
    waitframe();
    gametype = getDvar(@ "ui_gametype");

    if(gametype != last_type) {
      last_type = gametype;
      var_d395bbaee62a394d = function_c6044b8ca41f9f54();

      if(isDefined(world_event)) {
        deactivateworldevent(world_event);
        world_event = undefined;
      }

      if(isDefined(var_d395bbaee62a394d)) {
        level thread function_e45789a4e87d849e(var_d395bbaee62a394d);
      } else {
        level notify("frontendWorldEvent_singleton");
      }

      world_event = var_d395bbaee62a394d;
      function_61bd6a757e62669d(gametype);
    }
  }
}

function private function_93726c30d2b37614() {
  return default_to(level.projectbundle.var_9dc2c37526822978, "");
}

function function_70a855dd0c75561c(entname) {
  projectname = function_93726c30d2b37614();
  camera_ent = getEnt(entname + projectname, "targetname");

  if(projectname != "" && !isDefined(camera_ent)) {
    println("<dev string:x1c>" + entname + projectname + "<dev string:x51>");
    camera_ent = getEnt(entname, "targetname");
  }

  return camera_ent;
}

function function_abdba932e247d9c2(entname) {
  projectname = function_93726c30d2b37614();
  var_36ae6d00270bc142 = getEntArray(entname + projectname, "targetname");

  if(projectname != "" && !isDefined(var_36ae6d00270bc142)) {
    println("<dev string:x7d>" + entname + projectname + "<dev string:x51>");
    var_36ae6d00270bc142 = getEntArray(entname, "targetname");
  }

  return var_36ae6d00270bc142;
}

function private frontend_camera_setup(origin, angles) {
  level.camera_anchor = spawn("script_model", origin);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = angles;
  level.xcam_anchor = spawn("script_model", origin);
  level.xcam_anchor setModel("tag_origin");
  level.xcam_anchor.angles = angles;
  level.xcam_anchor.intransition = 0;
  function_afc6e0c85fa4b347();
  flag_init("started_mm");
  flag_init("lobby_member_increase");
  flag_init("zoom_triggered");
  flag_init("zoom_clear");
  flag_init("loadout_data_set");
  flag_init("force_weapon_update");
  level.var_7ee57b7672db9bf5 = getdvarint(@ "hash_50f29ef95283dc5d", 0);
  level.var_9121f71b47a01026 = getdvarint(@ "hash_b704cdc607351cd6", 0);
  level.cargoenabled = getdvarint(@ "hash_ffc75510a2b66232", 0);

  level thread function_bc662355e04368b1();
}

function private function_afc6e0c85fa4b347() {
  level.var_39e3bfc771325a76 = 0.3;
  level.var_e4b914d2cf9018d = ["tag_silencer", "tag_barrel_attach_small", "tag_barrel_attach_large", "tag_grip_attach", "tag_mag_attach", "j_mag1", "tag_scope", "tag_reflex", "tag_pistolgrip_attach", "tag_stock_attach", "tag_rack_attach", "j_gun", "tag_bipod_attach", "ammo_display_origin"];
}

function private frontend_camera_watcher(var_7ed4cf9ce7cc3393) {
  level endon("game_ended");
  self endon("disconnect");
  assert(isDefined(var_7ed4cf9ce7cc3393));
  self cameralinkTo(level.camera_anchor, "tag_origin");
  level.active_section = frontendscenegetactivesection();
  [[var_7ed4cf9ce7cc3393]](level.active_section);
  waitframe();

  while(true) {
    requested_section = frontendscenegetactivesection();
    camera_offsets = function_bef35a123c274c9f();

    if(!isDefined(level.var_c931a0e6b5dc96af)) {
      function_bc1542aad5140299(camera_offsets);
    } else if(!function_9aa20e292d7d0442(camera_offsets)) {
      function_bc1542aad5140299(camera_offsets);
      waitframe();
      [[var_7ed4cf9ce7cc3393]](requested_section);
    }

    if(requested_section.name == level.active_section.name && requested_section.index == level.active_section.index && isDefined(level.var_3417ad63b8b9976b) && !level.var_3417ad63b8b9976b) {
      if(level.active_section.name == getDvar(@ "hash_b8cc749b90dd2705")) {
        completescenetransition();
      }

      waitframe();
      continue;
    }

    level.var_3417ad63b8b9976b = 0;
    setomnvar("frontend_weapon_position_updated", 0);
    setomnvar("frontend_screen_black", 0);
    level.active_section = requested_section;
    setomnvar("frontend_weapon_position_updated", 0);
    setomnvar("frontend_screen_black", 0);
    setomnvar("frontend_weapon_position_force_update", 0);
    [[var_7ed4cf9ce7cc3393]](requested_section);
    println("<dev string:xb8>" + requested_section.name);
  }
}

function private function_bef35a123c274c9f() {
  cameraoffsets = spawnStruct();
  cameraoffsets.isenabled = getDvar(@ "hash_7e06254351806a5");
  cameraoffsets.positionoffsets = (getdvarfloat(@ "hash_c7b84c68b4a18696", 0), getdvarfloat(@ "hash_e26c4a7c1b9dd59f", 0), getdvarfloat(@ "hash_b20b2898d43b8a68", 0));
  cameraoffsets.orientationoffsets = (getdvarfloat(@ "hash_ff04a85e5dbe51b2", 0), getdvarfloat(@ "hash_f443ad27538b3297", 0), 0);
  cameraoffsets.var_362cee29cebe1bbb = getdvarfloat(@ "hash_53605a953e200942", 0);
  return cameraoffsets;
}

function private function_bc1542aad5140299(cameraoffsets) {
  level.var_9a2d5ce8ea083ffb = cameraoffsets.isenabled;
  level.var_c931a0e6b5dc96af = cameraoffsets.positionoffsets;
  level.var_c89e8c2733cc4ef4 = cameraoffsets.orientationoffsets;
  level.var_80644018acfdd9c5 = cameraoffsets.var_362cee29cebe1bbb;
}

function private function_9aa20e292d7d0442(cameraoffsets) {
  if(level.var_9a2d5ce8ea083ffb == cameraoffsets.isenabled && level.var_c931a0e6b5dc96af == cameraoffsets.positionoffsets && level.var_c89e8c2733cc4ef4 == cameraoffsets.orientationoffsets && level.var_80644018acfdd9c5 == cameraoffsets.var_362cee29cebe1bbb) {
    return 1;
  }

  return 0;
}

function private camera_section_change(requestedsection) {
  level notify("started_scene_change");

  if(requestedsection.name == "") {
    return;
  }

  sectionstate = get_section_state(requestedsection);

  if(!isDefined(sectionstate["scene"]) || !isDefined(sectionstate["camera"])) {
    return;
  }

  set_active_camera(sectionstate["scene"], sectionstate["camera"]);
  execute_transition(requestedsection, level.currentsectionname);
  callback::callback("on_camera_section_change", {
    #previousroom: level.currentsectionname, #newroom: requestedsection.name
  });
  level.currentsectionname = requestedsection.name;
  level notify("finished_scene_change");
}

function private set_active_camera(scene, camera) {
  level.active_scene_data = scene;
  level.active_camera = camera;
}

function private execute_transition(requestedsection, sectionfrom) {
  var_acf68bb64d0400f8 = !isDefined(level.active_scene_data) || level.transition_interrupted;

  if(var_acf68bb64d0400f8) {
    thread frontend_camera_teleport(level.active_camera, level.active_scene_data.myfov, level.active_scene_data.cinematic, 0, 0.2, &update_entities_and_camera);
  }

  assert(isDefined(level.transitionarray), "<dev string:xd9>");
  transitionarray = level.transitionarray;
  speed = undefined;
  fov = undefined;
  callback = undefined;
  transition = undefined;
  fadeouttime = undefined;
  fadeintime = undefined;
  cinematicname = undefined;
  accelscalar = undefined;
  decelscalar = undefined;
  movetime = undefined;
  use_bounce = undefined;

  if(isDefined(transitionarray[requestedsection.name])) {
    sectiontransition = transitionarray[requestedsection.name];
    defaulttransition = sectiontransition["default"];

    if(isDefined(sectionfrom) && isDefined(sectiontransition[sectionfrom])) {
      callback = sectiontransition[sectionfrom]["callback"];
      fov = sectiontransition[sectionfrom]["fov"];
      speed = sectiontransition[sectionfrom]["speed"];
      fadeouttime = sectiontransition[sectionfrom]["fadeOutTime"];
      fadeintime = sectiontransition[sectionfrom]["fadeInTime"];
      cinematicname = sectiontransition[sectionfrom]["cinematicName"];
      accelscalar = sectiontransition[sectionfrom]["accelScalar"];
      decelscalar = sectiontransition[sectionfrom]["decelScalar"];
      movetime = sectiontransition[sectionfrom]["moveTime"];
      use_bounce = sectiontransition[sectionfrom]["use_bounce"];

      if(isDefined(sectiontransition[sectionfrom]["transition"])) {
        transition = sectiontransition[sectionfrom]["transition"];
      }
    }

    callback = ter_op(isDefined(callback), callback, defaulttransition["callback"]);

    if(!isDefined(transition)) {
      transition = defaulttransition["transition"];
      fov = ter_op(isDefined(fov), fov, defaulttransition["fov"]);
      speed = ter_op(isDefined(speed), speed, defaulttransition["speed"]);
      fadeouttime = ter_op(isDefined(fadeouttime), fadeouttime, defaulttransition["fadeOutTime"]);
      fadeintime = ter_op(isDefined(fadeintime), fadeintime, defaulttransition["fadeInTime"]);
      cinematicname = ter_op(isDefined(cinematicname), cinematicname, defaulttransition["cinematicName"]);
      accelscalar = ter_op(isDefined(accelscalar), accelscalar, defaulttransition["accelScalar"]);
      decelscalar = ter_op(isDefined(decelscalar), decelscalar, defaulttransition["decelScalar"]);
      movetime = ter_op(isDefined(movetime), movetime, defaulttransition["moveTime"]);
      use_bounce = ter_op(isDefined(use_bounce), use_bounce, defaulttransition["use_bounce"]);
    }
  } else {
    transition = &frontend_camera_teleport;
    callback = &update_camera_depth_of_field;
    tagname = function_2d4a4197b801ad83(requestedsection.name);

    if(isDefined(tagname) && isDefined(level.var_d45fb3ee26047877[tagname])) {
      callback = &set_xcam;
    }
  }

  assert(isDefined(transition));

  if(transition == &frontend_camera_teleport) {
    fov = ter_op(isDefined(fov), fov, level.active_scene_data.myfov);
    fadeouttime = ter_op(isDefined(fadeouttime), fadeouttime, 0.2);
    fadeintime = ter_op(isDefined(fadeintime), fadeintime, 0.2);
    cinematicname = ter_op(isDefined(cinematicname), cinematicname, level.active_scene_data.cinematic);
    [[transition]](level.active_camera, fov, cinematicname, fadeouttime, fadeintime, callback);
  } else if(transition == &frontend_camera_move) {
    fov = ter_op(isDefined(fov), fov, level.active_scene_data.myfov);
    accelscalar = ter_op(isDefined(accelscalar), accelscalar, 0.1);
    decelscalar = ter_op(isDefined(decelscalar), decelscalar, 0.1);
    speed = ter_op(isDefined(speed), speed, 5000);
    use_bounce = ter_op(isDefined(use_bounce), use_bounce, 0);
    movetime = ter_op(isDefined(movetime), movetime, 0);
    update_camera_depth_of_field();
    frontendscenecamerafov(fov, movetime);

    if(isDefined(callback) && callback == &update_camera_depth_of_field) {
      callback = &update_camera_depth_of_field_slowly;
    }

    [[transition]](level.active_camera, speed, 0, 1, callback, accelscalar, decelscalar, use_bounce, movetime);
  } else {
    assert(0, "<dev string:x128>");
  }

  if(isDefined(requestedsection.name) && isDefined(level.var_2f5d13d3887f56a5) && isDefined(level.var_2f5d13d3887f56a5[requestedsection.name])) {
    [[level.var_2f5d13d3887f56a5[requestedsection.name]]](sectionfrom);
  }

  if(isDefined(sectionfrom) && isDefined(level.var_b50f0a931c0a33a1) && isDefined(level.var_b50f0a931c0a33a1[sectionfrom])) {
    [[level.var_b50f0a931c0a33a1[sectionfrom]]](sectionfrom);
  }
}

function private camera_move_helper(moveto, movetime, var_b73333faeb7580e8, accelscalar, decelscalar, use_bounce) {
  level.playerviewowner predictstreamposuntilcleared(moveto.origin);

  if(movetime < 0.05) {
    movetime = 0.05;
  }

  var_bde1f6386a595274 = 0;
  var_a4f9d343b9ef425 = 0;

  if(var_b73333faeb7580e8) {
    var_bde1f6386a595274 = movetime * accelscalar;
    var_a4f9d343b9ef425 = movetime * decelscalar;
  }

  if(use_bounce) {
    var_d9fe5c9e3f6fdf53 = 1.3;
    dir = vectorNormalize(moveto.origin - level.camera_anchor.origin);
    var_b8fd646dcdceac2d = moveto.origin + dir * var_d9fe5c9e3f6fdf53;
    bouncetime = movetime / 2;
    var_ca3314e2da30d3b3 = bouncetime * 0;
    var_b03ed768ddd916aa = bouncetime * 0.5;
    var_8e0a20dd79af6458 = bouncetime * 0.5;
    var_14adde5f19f82451 = bouncetime * 0;
    level.camera_anchor moveTo(var_b8fd646dcdceac2d, bouncetime, var_ca3314e2da30d3b3, var_b03ed768ddd916aa);
    level.camera_anchor rotateTo(moveto.angles, bouncetime, var_ca3314e2da30d3b3, var_b03ed768ddd916aa);
    wait bouncetime;
    level.camera_anchor moveTo(moveto.origin, bouncetime, var_8e0a20dd79af6458, var_14adde5f19f82451);
    wait bouncetime;
  } else {
    level.camera_anchor.move_target = moveto;
    level.camera_anchor moveTo(moveto.origin, movetime, var_bde1f6386a595274, var_a4f9d343b9ef425);
    level.camera_anchor rotateTo(moveto.angles, movetime, var_bde1f6386a595274, var_a4f9d343b9ef425);
  }

  level.playerviewowner clearpredictedstreampos();
}

function private frontend_camera_move(movetoorigin, speed, var_68383f581ab73544, var_b73333faeb7580e8, var_30a2c9209d42c54c, accelscalar, decelscalar, use_bounce, movetime) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(level.var_456a9092ba065871)) {
    level.var_456a9092ba065871 = [];
  }

  if(!isDefined(level.var_456a9092ba065871[movetoorigin.targetname])) {
    cameraposition = spawnStruct();
    cameraposition.origin = movetoorigin.origin;
    cameraposition.angles = movetoorigin.angles;
    level.var_456a9092ba065871[movetoorigin.targetname] = cameraposition;
  }

  var_836e5cac89d04dd0 = (0, 0, 0);
  var_e159b986341c44f9 = (0, 0, 0);

  if(getDvar(@ "hash_7e06254351806a5") == "1") {
    var_836e5cac89d04dd0 = (getdvarfloat(@ "hash_c7b84c68b4a18696", 0), getdvarfloat(@ "hash_e26c4a7c1b9dd59f", 0), getdvarfloat(@ "hash_b20b2898d43b8a68", 0));
    var_e159b986341c44f9 = (getdvarfloat(@ "hash_ff04a85e5dbe51b2", 0), getdvarfloat(@ "hash_f443ad27538b3297", 0), 0);
  }

  if(isDefined(level.camera_anchor.move_target)) {
    level.camera_anchor.origin = level.camera_anchor.move_target.origin;
    level.camera_anchor.angles = level.camera_anchor.move_target.angles;
  }

  movetoorigin.origin = level.var_456a9092ba065871[movetoorigin.targetname].origin + var_836e5cac89d04dd0;
  movetoorigin.angles = level.var_456a9092ba065871[movetoorigin.targetname].angles + var_e159b986341c44f9;
  level notify("camera_move");
  level endon("camera_move");

  if(!isDefined(speed)) {
    speed = 900;
  }

  moveto_origin = movetoorigin;

  if(movetime == 0) {
    dist = distance(level.camera_anchor.origin, moveto_origin.origin);
    movetime = dist / speed;
  }

  xcamscene = undefined;

  if(isDefined(level.active_section.name)) {
    xcamscene = level.active_section.name;

    if(!isDefined(level.var_d45fb3ee26047877[xcamscene])) {
      xcamscene = function_2d4a4197b801ad83(xcamscene);
    }
  }

  var_cfe414a4d77dd796 = isDefined(xcamscene) && isDefined(level.var_d45fb3ee26047877[xcamscene]);
  var_70053d8506f7d674 = isDefined(var_30a2c9209d42c54c) && (var_30a2c9209d42c54c == &set_xcam || var_30a2c9209d42c54c == &function_502ef984f5ad944e);
  var_71be8026e082d814 = var_68383f581ab73544 || var_cfe414a4d77dd796 && var_70053d8506f7d674;

  if(var_71be8026e082d814) {
    level.camera_anchor.origin = moveto_origin.origin;
    level.camera_anchor.angles = moveto_origin.angles;
  } else {
    camera_move_helper(moveto_origin, movetime, var_b73333faeb7580e8, accelscalar, decelscalar, use_bounce);
  }

  var_119779a9a16f190e = accelscalar + decelscalar;

  if(var_119779a9a16f190e > 1) {
    accelscalar /= var_119779a9a16f190e;
    decelscalar /= var_119779a9a16f190e;
  }

  while(isDefined(moveto_origin.target) && !var_cfe414a4d77dd796) {
    if(!isDefined(moveto_origin.target)) {
      return;
    }

    moveto_origin = getEnt(moveto_origin.target, "targetname");
    camera_move_helper(moveto_origin, movetime, var_b73333faeb7580e8, accelscalar, decelscalar, use_bounce);
  }

  level.camera_anchor.move_target = undefined;

  if(isDefined(var_30a2c9209d42c54c)) {
    self thread[[var_30a2c9209d42c54c]]();
  }

  completescenetransition();
}

function private frontend_camera_teleport(camera, fov, cinematicname, fadeouttime, fadeintime, var_c22e6553d3f7e83e) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level.playerviewowner predictstreamposuntilcleared(camera.origin);
  level.transition_interrupted = 1;
  frontendscenecamerafade(0, fadeouttime);
  wait fadeouttime + 0.05;
  setomnvar("frontend_screen_black", 1);
  xcam = function_cb66d1b49608d340();

  if(isDefined(xcam)) {
    end_current_xcam();
  }

  if(!isDefined(level.var_456a9092ba065871)) {
    level.var_456a9092ba065871 = [];
  }

  if(!isDefined(level.var_456a9092ba065871[camera.targetname]) || issubstr(camera.targetname, "cam_bp")) {
    cameraposition = spawnStruct();
    cameraposition.origin = camera.origin;
    cameraposition.angles = camera.angles;
    level.var_456a9092ba065871[camera.targetname] = cameraposition;
  }

  var_836e5cac89d04dd0 = (0, 0, 0);
  var_e159b986341c44f9 = (0, 0, 0);
  fov_offset = 0;

  if(getDvar(@ "hash_7e06254351806a5") == "1") {
    var_836e5cac89d04dd0 = (getdvarfloat(@ "hash_c7b84c68b4a18696", 0), getdvarfloat(@ "hash_e26c4a7c1b9dd59f", 0), getdvarfloat(@ "hash_b20b2898d43b8a68", 0));
    var_e159b986341c44f9 = (getdvarfloat(@ "hash_ff04a85e5dbe51b2", 0), getdvarfloat(@ "hash_f443ad27538b3297", 0), 0);
    fov_offset = getdvarint(@ "hash_53605a953e200942");
  }

  frontendscenecamerafov(fov + fov_offset, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = level.var_456a9092ba065871[camera.targetname].origin + var_836e5cac89d04dd0;
  level.camera_anchor.angles = level.var_456a9092ba065871[camera.targetname].angles + var_e159b986341c44f9;
  level.camera_anchor.move_target = undefined;

  if(isDefined(cinematicname)) {
    frontendscenecameracinematic(cinematicname);
  }

  wait 0.1;

  if(isDefined(level.currentsectionname) && function_4a669b7ad22042ad(level.currentsectionname)) {
    update_weapon_loc();
  }

  if(isDefined(var_c22e6553d3f7e83e)) {
    waitforxcam = undefined;

    if(var_c22e6553d3f7e83e == &set_xcam) {
      waitforxcam = 1;
    }

    if(istrue(waitforxcam)) {
      waitforxcam = [[var_c22e6553d3f7e83e]]();
    } else {
      [[var_c22e6553d3f7e83e]]();
    }

    if(istrue(waitforxcam)) {
      while(!isDefined(function_cb66d1b49608d340())) {
        waitframe();
      }
    }
  }

  frontendscenecamerafade(1, fadeintime);
  level.transition_interrupted = 0;
  completescenetransition();
  setomnvar("frontend_screen_black", 0);
  level.playerviewowner clearpredictedstreampos();
}

function private update_character_pos() {
  level.var_11aa1ed10ab3eca0 = [];

  if(isDefined(level.active_scene_data.update_char_loc)) {
    [[level.active_scene_data.update_char_loc]]();
    return;
  }

  if(isDefined(level.active_scene_data.char_loc)) {
    charindex = 0;

    if(isDefined(level.active_scene_data.char_index)) {
      charindex = level.active_scene_data.char_index;
    }

    level.characters[charindex].origin = level.active_scene_data.char_loc.origin;
    level.characters[charindex].angles = level.active_scene_data.char_loc.angles;

    level function_ebc947f48c860093(charindex, level.active_scene_data.char_loc, "<dev string:x155>" + charindex);
  }
}

function private update_player_character_showcase() {
  update_character_pos();
  update_weapon_loc();
  update_camera_depth_of_field();
  update_spot_limit();
}

function private update_camera_depth_of_field() {
  values = level.active_camera.depthoffieldvalues;
  var_1760f78ac7f81bbb = 0;

  if(getDvar(@ "hash_7e06254351806a5") == "1") {
    var_1760f78ac7f81bbb = getdvarint(@ "hash_53605a953e200942");
  }

  self setphysicaldepthoffield(values[0], values[1] + var_1760f78ac7f81bbb, 20, 20);
}

function private update_camera_depth_of_field_slowly() {
  values = level.active_camera.depthoffieldvalues;
  var_1760f78ac7f81bbb = 0;

  if(getDvar(@ "hash_7e06254351806a5") == "1") {
    var_1760f78ac7f81bbb = getdvarint(@ "hash_53605a953e200942");
  }

  self setphysicaldepthoffield(values[0], values[1] + var_1760f78ac7f81bbb, 3, 3);
}

function private function_bc662355e04368b1() {
  pval1 = getdvarint(@ "hash_e1e483a72c23e49c", 10);
  pval2 = getdvarint(@ "hash_e1e483a72c23e49c", 10);

  while(true) {
    val1 = getdvarint(@ "hash_e1e483a72c23e49c", 10);
    val2 = getdvarint(@ "hash_e1e486a72c23eb35", 10);

    if(isDefined(level.active_camera) && isDefined(level.active_camera.depthoffieldvalues)) {
      values = level.active_camera.depthoffieldvalues;
    }

    if(pval1 != val1 || pval2 != val2) {
      level.playerviewowner setphysicaldepthoffield(val1, val2, 20, 20);
      pval1 = val1;
      pval2 = val2;
    }

    waitframe();
  }
}

function private debug_frontend() {
  level.var_11aa1ed10ab3eca0 = [];
  level thread function_fa371655cf1125e1();

  while(true) {
    self waittill("<dev string:x168>", msg);

    if(msg == "<dev string:x17b>") {
      dumpfrontenddata(level);
    }
  }
}

function private function_ebc947f48c860093(charindex, charloc, name) {
  var_943709d550d5a688 = spawnStruct();
  var_943709d550d5a688.charindex = charindex;
  var_943709d550d5a688.charloc = charloc;
  var_943709d550d5a688.name = name;
  level.var_11aa1ed10ab3eca0[level.var_11aa1ed10ab3eca0.size] = var_943709d550d5a688;
}

function private function_dbab25154ba7f817() {}

function private function_6caf0e358af2d83b() {
  level endon("<dev string:x192>");
  self endon("<dev string:x1a0>");

  while(true) {
    var_c42f5a9994675966 = getdvarint(@ "hash_54d877684382d6b6");

    if(var_c42f5a9994675966 != -1) {
      foreach(active_character in level.var_11aa1ed10ab3eca0) {
        if(active_character.charindex == var_c42f5a9994675966) {}
      }
    }

    waitframe();
  }
}

function private function_fa371655cf1125e1() {
  level endon("<dev string:x192>");
  self endon("<dev string:x1a0>");

  while(true) {
    if(getdvarint(@ "hash_fcf3e4b333ad71c4")) {
      foreach(active_character in level.var_11aa1ed10ab3eca0) {
        cylinder(active_character.charloc.origin, active_character.charloc.origin + (0, 0, 72), 12, (0, 0.9, 0));
      }
    }

    waitframe();
  }
}

function private update_entities_and_camera(previousscene) {
  if(!isDefined(previousscene)) {
    end_current_xcam();
  } else if(function_f8448524349b24ce(previousscene)) {
    end_current_xcam();
  }

  update_character_pos();

  if(isDefined(level.active_section)) {
    if(level.active_section.name == "loadout_showcase_p" || level.active_section.name == "loadout_showcase_s") {
      reset_preview_weapon_loc();
    }
  }

  update_weapon_loc();
  update_camera_depth_of_field();
  update_spot_limit();

  if(getcurrentfrontendfastfilename() == "mp_frontend3") {
    function_2898724f8cf4c78e();
  }
}

function private update_spot_limit() {
  if(isDefined(level.active_scene_data.spotlimit)) {
    setDvar(@ "hash_63eb1893f96ac98d", level.active_scene_data.spotlimit);
    return;
  }

  setDvar(@ "hash_63eb1893f96ac98d", 2);
}

function private function_b29a3bc01e5aa394() {
  level endon("game_ended");

  while(!isDefined(level.var_e35b63f3ac08dada)) {
    waitframe();
  }
}

function private function_47f8406a4c96af32(scene) {
  if(!isDefined(level.var_e35b63f3ac08dada)) {
    function_b29a3bc01e5aa394();
  }

  if(isDefined(level.var_e35b63f3ac08dada) && level.var_e35b63f3ac08dada != scene) {
    ismgl = getdvarint(@ "mgl", 0) > 0;

    foreach(light in level.lightsall) {
      light setlightintensity(0);
    }

    switch (scene) {
      case #"hash_a3d0a83d345a23d9":
        foreach(light in level.var_ce6333e67d961b48) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_721dfaa45ab40da3":
        foreach(light in level.lightsloadout) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_fa9a9f82be7c7750":
        foreach(light in level.lightscharacter) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_4c6b30f761704c3d":
        foreach(light in level.lightsoperator) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_ed55207ac18e6495":
        if(ismgl) {
          foreach(light in level.var_4933154ecf108192) {
            light setlightintensity(light.var_86102e35e838b321);
          }
        }

        break;
      case #"hash_312a5f08aec534c1":
        if(ismgl) {
          foreach(light in level.var_d7f9bd1d525c1c2) {
            light setlightintensity(light.var_86102e35e838b321);
          }
        }

        break;
      case #"hash_d07077b120b56c3e":
        foreach(light in level.var_59ab1197ebb66e32) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        foreach(light in level.var_e15a8396ad2b565e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_f47573a9016e4779":
        foreach(light in level.var_1ec5eb144158c5b5) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        foreach(light in level.var_e15a8396ad2b565e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_79e89985d0d418c1":
        foreach(light in level.var_2cf1153859b056fd) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        foreach(light in level.var_e15a8396ad2b565e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_abe21a1fe3c6e374":
        foreach(light in level.var_504408371dc54600) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        foreach(light in level.var_e15a8396ad2b565e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_f59ec880fd3a1e59":
        foreach(light in level.var_d0fc52d62ef83fd8) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        foreach(light in level.var_e15a8396ad2b565e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_2d25a7a4dac9123e":
        foreach(light in level.var_263ab51c7ff88c1a) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        foreach(light in level.var_e15a8396ad2b565e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_acd02ca6864b64a6":
        foreach(light in level.var_c63b6a758e9619f3) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_2b7def4e6421f0a2":
        foreach(light in level.lightsstore) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_4e09e8d7f40e42f7":
        foreach(light in level.var_427ed2f4ea09777e) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
    }
  }

  level.var_e35b63f3ac08dada = scene;
}

function private move_weapon_to_loc(index) {
  level.weapons[index].origin = level.active_scene_data.weapon_locs[index].origin;
  level.weapons[index].angles = level.active_scene_data.weapon_locs[index].angles;
}

function private update_weapon_loc() {
  if(isDefined(level.active_scene_data.weapon_locs)) {
    if(isarray(level.active_scene_data.weapon_locs)) {
      for(locindex = 0; locindex <= 6; locindex++) {
        if(locindex == 4) {
          continue;
        }

        assert(isDefined(level.weapons[locindex]));

        if(isDefined(level.active_scene_data.weapon_locs[locindex])) {
          move_weapon_to_loc(locindex);
        }
      }
    }
  }

  if(issubstr(level.active_section.name, "loadout_showcase_preview")) {
    setomnvar("frontend_weapon_position_updated", 1);
  }
}

function private update_arena_char_loc() {
  for(charindex = 0; charindex < 8; charindex++) {
    if(charindex < 4) {
      charloc = function_70a855dd0c75561c("tourroom_charslot_left_0" + charindex + 1);
    } else {
      adjustedcharindex = charindex - 4;
      charloc = function_70a855dd0c75561c("tourroom_charslot_right_0" + adjustedcharindex + 1);
    }

    level.characters[charindex].origin = charloc.origin;
    level.characters[charindex].angles = charloc.angles;

    if(charindex < 4) {
      level function_ebc947f48c860093(charindex, charloc, "<dev string:x1ae>" + charindex + 1);
      continue;
    }

    level function_ebc947f48c860093(charindex, charloc, "<dev string:x1bb>" + charindex / 2 + 1);
  }

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;

    if(index <= 3) {
      charloc = function_70a855dd0c75561c("tourroom_charslot_left_0" + index + "_dog");
    } else {
      adjustedindex = index - 3;
      charloc = function_70a855dd0c75561c("tourroom_charslot_right_0" + adjustedindex + "_dog");
    }

    level.characters[charindex].origin = charloc.origin;
    level.characters[charindex].angles = charloc.angles;

    level function_ebc947f48c860093(charindex, charloc, "<dev string:x1c9>" + index);
  }
}

function private function_e078e650b9311bae() {
  charloc = function_70a855dd0c75561c("social_charslot_01");
  level.characters[0].origin = charloc.origin;
  level.characters[0].angles = charloc.angles;

  for(charindex = 1; charindex < 8; charindex++) {
    index = charindex + 1;

    if(index < 10) {
      charloc = function_70a855dd0c75561c("social_charslot_0" + index);
    } else {
      charloc = function_70a855dd0c75561c("social_charslot_" + index);
    }

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;
    }
  }

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;
    charloc = function_70a855dd0c75561c("social_charslot_0" + index + "_dog");
    level.characters[charindex].origin = charloc.origin;
    level.characters[charindex].angles = charloc.angles;
  }
}

function private update_lobby_char_loc() {
  charloc = function_70a855dd0c75561c("lobby_charslot_01");
  level.characters[0].origin = charloc.origin;
  level.characters[0].angles = charloc.angles;

  level function_ebc947f48c860093(0, charloc, "<dev string:x1d5>");

  if(isDefined(level.var_21f36f18171d453d)) {
    level.var_21f36f18171d453d.origin = level.var_21f36f18171d453d.originallocation;
    level.var_21f36f18171d453d.angles = level.var_21f36f18171d453d.originalangles;

    if(isDefined(level.var_b0f545be973a4a13)) {
      level.var_b0f545be973a4a13.origin = level.var_b0f545be973a4a13.originallocation;
    }
  }

  for(charindex = 1; charindex < 8; charindex++) {
    index = charindex + 1;

    if(index < 10) {
      charloc = function_70a855dd0c75561c("lobby_charslot_0" + index);
    } else {
      charloc = function_70a855dd0c75561c("lobby_charslot_" + index);
    }

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x1e9>" + charindex);
    }
  }

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;
    charloc = function_70a855dd0c75561c("lobby_charslot_0" + index + "_dog");

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x1c9>" + index);
    }
  }
}

function private function_b65a48a89b1a2cc0() {
  charloc = function_70a855dd0c75561c("lobby_br_charslot_01");
  level.characters[0].origin = charloc.origin;
  level.characters[0].angles = charloc.angles;

  level function_ebc947f48c860093(0, charloc, "<dev string:x1f2>");

  if(isDefined(level.var_21f36f18171d453d)) {
    level.var_21f36f18171d453d.origin = (-7035, 2380, 0);
    level.var_21f36f18171d453d.angles = (0, 90, 0);

    if(isDefined(level.var_b0f545be973a4a13)) {
      level.var_b0f545be973a4a13.origin = (0, 0, 10000);
    }
  }

  for(charindex = 1; charindex < 8; charindex++) {
    index = charindex + 1;

    if(index < 10) {
      charloc = function_70a855dd0c75561c("lobby_br_charslot_0" + index);
    } else {
      charloc = function_70a855dd0c75561c("lobby_br_charslot_" + index);
    }

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x208>" + charindex);
    }
  }

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;
    charloc = function_70a855dd0c75561c("lobby_br_charslot_0" + index + "_dog");

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x213>" + index);
    }
  }
}

function private function_9c5a6e36e93eadd9() {
  charloc = getEnt("lobby_dmz_charslot_01", "targetname");
  level.characters[0].origin = charloc.origin;
  level.characters[0].angles = charloc.angles;

  level function_ebc947f48c860093(0, charloc, "<dev string:x221>");

  for(charindex = 1; charindex < 8; charindex++) {
    index = charindex + 1;

    if(index < 10) {
      charloc = getEnt("lobby_dmz_charslot_0" + index, "targetname");
    } else {
      charloc = getEnt("lobby_dmz_charslot_" + index, "targetname");
    }

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x238>" + charindex);
    }
  }

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;
    charloc = getEnt("lobby_dmz_charslot_0" + index + "_dog", "targetname");

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x243>" + index);
    }
  }
}

function private function_18d1a39cc5732fb1() {
  charloc = function_70a855dd0c75561c("crib_dmz_charslot_01");
  level.characters[0].origin = charloc.origin;
  level.characters[0].angles = charloc.angles;

  level function_ebc947f48c860093(0, charloc, "<dev string:x221>");

  for(charindex = 1; charindex < 8; charindex++) {
    index = charindex + 1;

    if(index < 10) {
      charloc = function_70a855dd0c75561c("crib_dmz_charslot_0" + index);
    } else {
      charloc = function_70a855dd0c75561c("crib_dmz_charslot_" + index);
    }

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x252>" + charindex);
    }
  }

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;
    charloc = function_70a855dd0c75561c("crib_dmz_charslot_0" + index + "_dog");

    if(isDefined(charloc)) {
      level.characters[charindex].origin = charloc.origin;
      level.characters[charindex].angles = charloc.angles;

      level function_ebc947f48c860093(charindex, charloc, "<dev string:x25d>" + index);
    }
  }
}

function private update_main_menu_char_loc() {
  ismgl = getdvarint(@ "mgl", 0) > 0;
  charloc = function_70a855dd0c75561c("charroom_char_tango_east");
  level.characters[14].origin = charloc.origin;
  level.characters[14].angles = charloc.angles;

  level function_ebc947f48c860093(14, charloc, "<dev string:x26b>");

  charloc = function_70a855dd0c75561c("charroom_char_tango_west");
  level.characters[15].origin = charloc.origin;
  level.characters[15].angles = charloc.angles;

  level function_ebc947f48c860093(15, charloc, "<dev string:x27b>");

  update_operator_west_char_loc();
  update_operator_east_char_loc();
}

function private update_operator_west_char_loc() {
  charloc = getEnt("charroom_char_west_b_dog", "targetname");
  level.characters[8].origin = charloc.origin;
  level.characters[8].angles = charloc.angles;

  level function_ebc947f48c860093(8, charloc, "<dev string:x28b>");
}

function private update_operator_east_char_loc() {
  charloc = getEnt("charroom_char_east_a_dog", "targetname");
  level.characters[9].origin = charloc.origin;
  level.characters[9].angles = charloc.angles;

  level function_ebc947f48c860093(9, charloc, "<dev string:x29e>");
}

function private function_64a0f78f8cdff3f() {
  charloc = function_70a855dd0c75561c("char_gunbench");
  level.characters[0].origin = charloc.origin;
  level.characters[0].angles = charloc.angles;

  if(istrue(level.var_939d7db4d53fd126)) {
    level.characters[0].origin -= 1000;
  }

  level function_ebc947f48c860093(0, charloc, "<dev string:x2b1>");

  charloc = function_70a855dd0c75561c("char_gunbench_dog");
  level.characters[8].origin = charloc.origin;
  level.characters[8].angles = charloc.angles;

  level function_ebc947f48c860093(8, charloc, "<dev string:x2c1>");
}

function private raritycamera(camera) {
  switch (camera) {
    case #"hash_5971965ed985a26c":
      foreach(bg in level.ui_bg_images_2d) {
        bg.origin = level.raritycamsmall.origin;
      }

      break;
    case #"hash_c71b112fe04823d6":
      foreach(bg in level.ui_bg_images_2d) {
        bg.origin = level.raritycammedium.origin;
      }

      break;
    case #"hash_4bf33d595d8f4894":
      foreach(bg in level.ui_bg_images_2d) {
        bg.origin = level.raritycamlarge.origin;
      }

      break;
    case #"hash_763ef102433d0808":
      foreach(bg in level.ui_bg_images_2d) {
        bg.origin = level.raritycamwatch.origin;
      }

      break;
  }
}

function private function_430b4aaa7c17c4c(scenename, waittime) {
  level notify("new_operator_xcam");
  level endon("game_ended");
  self endon("disconnect");
  level endon("xcam_transition");
  level endon("new_operator_xcam");
  wait waittime / 1000;
  function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][4], 0, 0.05, level.xcam_anchor);
  level thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][4], level.xcam_anchor);
}

function private function_e7571f41e1d6a427(scenename, flagmsg, previousscene) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  level.xcam_anchor.intransition = 1;
  level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
  level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;

  while(true) {
    if(!isDefined(level.var_a5777679e8986406) || !isDefined(level.var_d5e742a25a53c1b3)) {
      if(!isDefined(function_cb66d1b49608d340())) {
        blendtime = 0;

        if(isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"])) {
          blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["default"];

          if(isDefined(previousscene) && isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene])) {
            blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene];
          }
        }

        function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][4], 0, blendtime, level.xcam_anchor);
        level thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][4], level.xcam_anchor);
      } else if(function_cb66d1b49608d340().name == "iw9_fe_op_select_east_edit_in_xcam" || function_cb66d1b49608d340().name == "iw9_fe_op_select_west_edit_in_xcam") {
        blendtime = 0;

        if(isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"])) {
          blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["default"];

          if(isDefined(previousscene) && isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene])) {
            blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene];
          }
        }

        function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][4], 0, 0.35, level.xcam_anchor);
        level thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][4], level.xcam_anchor);
      }

      waitframe();
      continue;
    }

    var_843aa33343742ef5 = level.var_a5777679e8986406;
    gender = level.var_d5e742a25a53c1b3;

    if(gender == 1) {
      gender++;
    }

    xcamindex = var_843aa33343742ef5 + gender;
    level.var_a5777679e8986406 = undefined;
    level.var_d5e742a25a53c1b3 = undefined;
    level notify("new_operator_xcam");
    blendtime = 0;

    if(isDefined(previousscene) && previousscene != "" && isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"])) {
      blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["default"];

      if(isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene])) {
        blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene];
      }
    }

    leng = 0;

    if(!istrue(level.var_f750bd5e9c449424)) {
      function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][xcamindex], 0, blendtime, level.xcam_anchor);
      leng = function_74756a08469ca5e(level.var_d45fb3ee26047877[scenename]["transitions"][xcamindex]);
    }

    level.var_f750bd5e9c449424 = undefined;
    level thread function_430b4aaa7c17c4c(scenename, leng);
    previousscene = "";
    waitframe();
  }
}

function private lua_triggered_xcam_mm(scenename, flagmsg, previousscene) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
  level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;
  lobbyxcam = level.var_d45fb3ee26047877[scenename]["transitions"][0];

  if(isDefined(level.var_1eed5555b61f170)) {
    lobbyxcam = level.var_1eed5555b61f170;
  }

  function_5aea88c7c01479db(lobbyxcam, 0, 0, level.xcam_anchor);
  level.var_1eed5555b61f170 = lobbyxcam;
  level.xcam_anchor.intransition = 1;
  thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][0], level.xcam_anchor);
  waittime = undefined;
  waitframe();

  while(true) {
    waitframe();
    flag_wait_any_array(flagmsg);

    if(isarray(flagmsg)) {
      foreach(flagtoclear in flagmsg) {
        flag_clear(flagtoclear);
      }
    } else {
      flag_clear(flagmsg);
    }

    level notify("xcam_loop");
    currentcam = function_cb66d1b49608d340();
    blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["default"];

    if(level.currentflagmsg == "match_making") {
      blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["started_mm"];
      function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][2], 0, blendtime, level.xcam_anchor);
      waittime = max(function_74756a08469ca5e(level.var_d45fb3ee26047877[scenename]["transitions"][2]) - 1500, 0);
      break;
    }

    if(level.currentflagmsg == "lobby_member_increase" && level.var_13c94d72bba10b4 == 1 && isDefined(currentcam) && currentcam.name != "fe_lobby_plow_cam_01_idle_01_xcam") {
      blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["lobby_member_increase"];
      function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][0], 0, blendtime, level.xcam_anchor);
      thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][0], level.xcam_anchor);
      level.var_1eed5555b61f170 = level.var_d45fb3ee26047877[scenename]["transitions"][0];
      continue;
    }

    if(level.currentflagmsg == "lobby_member_increase" && level.var_13c94d72bba10b4 > 1 && isDefined(currentcam) && currentcam.name != "fe_lobby_plow_cam_01_idle_squad_01_xcam") {
      blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["lobby_member_increase"];
      function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][1], 0, blendtime, level.xcam_anchor);
      thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][0], level.xcam_anchor);
      level.var_1eed5555b61f170 = level.var_d45fb3ee26047877[scenename]["transitions"][1];
    }
  }

  level.var_1eed5555b61f170 = undefined;

  if(isDefined(waittime) && waittime > 0) {
    thread function_1992c5cb2e5f21fe(waittime);
  }

  level.xcam_anchor.intransition = 0;
}

function private function_1992c5cb2e5f21fe(waittime) {
  level notify("matchmaking_fade");
  level endon("game_ended");
  level endon("matchmaking_fade");
  level endon("xcam_transition");
  level endon("disconnect");
  wait waittime / 1000;
  frontendscenecamerafade(0, 1.5);
  thread function_b73bccceeabfb757();
  wait 1.5;
  setomnvar("frontend_screen_black", 1);
}

function private function_b73bccceeabfb757() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("camera_teleport");
  level waittill_any_2("xcam_set", "finished_scene_change");
  frontendscenecamerafade(1, 0.2);
  setomnvar("frontend_screen_black", 0);
}

function private function_701c8726c0b7fc47(scenename, flagmsg) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("xcam_transition");
  flag_wait("zoom_clear");
  level thread lua_triggered_attachment_zoom(scenename, flagmsg);
}

function private lua_triggered_attachment_zoom(scenename, flagmsg, previousscene) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  level.xcam_anchor.intransition = 1;
  level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
  level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;

  if(distancesquared(level.xcam_anchor.origin, (-5872.09, -3436.26, 0)) > 14000) {
    level.var_9c1886877f0e84a1 = undefined;
    flag_clear("force_weapon_update");
    update_weapon_loc();
    waitframe();
    setomnvar("frontend_weapon_position_force_update", 1);
    flag_wait("force_weapon_update");
    level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
    level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;
  }

  function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][0], 0, 0, level.xcam_anchor);
  flag_wait(flagmsg);
  flag_clear(flagmsg);
  index = 0;

  switch (level.var_ebfc572b07861f57) {
    case #"hash_2630d03d6f5fc192":
      index = 1;
      break;
    case #"hash_ac8941a3f4be6fc5":
      index = 0;
      break;
    case #"hash_6fc1c97a058fdcc9":
      index = 2;
      break;
    case #"hash_c693ed0e3896fe7b":
      index = 3;
      break;
    case #"hash_3c53eb274322e803":
      index = 4;
      break;
    case #"hash_e32d2a49d1ac024c":
      index = 5;
      break;
    case #"hash_c9e63a9bddd371e":
      index = 6;
      break;
    case #"hash_412112410dc298ec":
      index = 7;
      break;
    case #"hash_754f51acf0f54d82":
      index = 8;
      break;
    case #"hash_1f1886e1d0bae31d":
      index = 9;
      break;
    case #"hash_bba42a71d53ec8d0":
      index = 0;
      break;
  }

  while(level.active_section.name == scenename) {
    flag_wait("zoom_triggered");
    flag_clear("zoom_triggered");
    level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
    level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;
    function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][index], 0, level.var_39e3bfc771325a76, level.xcam_anchor);

    if(index == 0) {
      level.var_39e3bfc771325a76 = 0.3;
    }
  }

  level.xcam_anchor.intransition = 0;
}

function private function_502ef984f5ad944e(scenename, flagmsg, previousscene) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["default"];

  if(isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene])) {
    blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"][previousscene];
  }

  while(level.var_d45fb3ee26047877[scenename]["transitions"][0] == "") {
    waitframe();
  }

  level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
  level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;
  function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][0], 0, blendtime, level.xcam_anchor);
}

function private loop_xcam(xcam, xcam_anchor) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_loop");
  level endon("xcam_loop");
  level endon("xcam_transition");
  level endon("new_operator_xcam");

  while(true) {
    leng = function_74756a08469ca5e(xcam);

    if(leng <= 0) {
      waitframe();
      continue;
    } else {
      wait leng / 1000;
    }

    function_5aea88c7c01479db(xcam, 0, 0.3, xcam_anchor);
  }

  level.xcam_anchor.intransition = 0;
}

function private xcam_transition(scenename) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  transitionsize = level.var_d45fb3ee26047877[scenename]["transitions"].size;

  if(transitionsize == 0) {
    return;
  }

  if(isDefined(level.var_d45fb3ee26047877[scenename]["callback"]) && isDefined(level.var_d45fb3ee26047877[scenename]["flag_msg"])) {
    level thread[[level.var_d45fb3ee26047877[scenename]["callback"]]](scenename, level.var_d45fb3ee26047877[scenename]["flag_msg"], level.currentsectionname);
    return;
  }

  blendtime = 0;

  if(isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"])) {
    blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"]["default"];

    if(isDefined(level.currentsectionname) && isDefined(level.var_d45fb3ee26047877[scenename]["blend_time"][level.currentsectionname])) {
      blendtime = level.var_d45fb3ee26047877[scenename]["blend_time"][level.currentsectionname];
    }
  }

  level.xcam_anchor.origin = level.var_d45fb3ee26047877[scenename]["xcam_data"].origin;
  level.xcam_anchor.angles = level.var_d45fb3ee26047877[scenename]["xcam_data"].angles;

  if(transitionsize == 1) {
    function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][0], 0, blendtime, level.xcam_anchor);

    if(istrue(level.var_d45fb3ee26047877[scenename]["loop_last"])) {
      level thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][0], level.xcam_anchor);
    }

    return;
  }

  level.xcam_anchor.intransition = 1;

  for(i = 0; i < transitionsize; i++) {
    function_5aea88c7c01479db(level.var_d45fb3ee26047877[scenename]["transitions"][i], 0, blendtime, level.xcam_anchor);

    if(i < transitionsize - 1) {
      leng = function_74756a08469ca5e(level.var_d45fb3ee26047877[scenename]["transitions"][i]);
      wait leng / 1000;
    }
  }

  if(istrue(level.var_d45fb3ee26047877[scenename]["loop_last"])) {
    level thread loop_xcam(level.var_d45fb3ee26047877[scenename]["transitions"][transitionsize - 1], level.xcam_anchor);
    return;
  }

  level.xcam_anchor.intransition = 0;
}

function private function_5aea88c7c01479db(xcam, subcamera, blendtime, xcam_anchor) {
  tmpanchor = xcam_anchor;

  if(isDefined(level.xcam_offset)) {
    tmpanchor.origin += level.xcam_offset;
  }

  level.xcam_offset = undefined;
  function_55891d5a9dc7c19e(xcam, subcamera, blendtime, tmpanchor);
  level notify("xcam_set");
}

function private set_xcam() {
  update_entities_and_camera(level.currentsectionname);

  if(!isDefined(level.var_d45fb3ee26047877)) {
    return;
  }

  scenename = level.active_section.name;

  if(!function_80ac3e056bacbfcc(scenename) && !function_4a669b7ad22042ad(scenename) && istrue(level.var_9c1886877f0e84a1)) {
    level.var_9c1886877f0e84a1 = undefined;
  }

  if(function_4a669b7ad22042ad(scenename)) {
    function_f1d45199114730a5();
  }

  if(!isDefined(level.var_d45fb3ee26047877[scenename])) {
    scenename = function_2d4a4197b801ad83(scenename);
  }

  if(isDefined(scenename) && isDefined(level.var_d45fb3ee26047877[scenename])) {
    if(getcurrentfrontendfastfilename() == "mp_frontend3") {
      function_64ca1efa525c0bfa(scenename);
    }

    level.xcam_anchor.intransition = 0;
    level thread xcam_transition(scenename);
    return 1;
  }

  return 0;
}

function private function_f8448524349b24ce(previousscene) {
  activexcam = function_cb66d1b49608d340();
  scenename = level.active_section.name;

  if(!isDefined(activexcam)) {
    return false;
  }

  if(!isDefined(level.transitionarray[scenename])) {
    return true;
  }

  transition = undefined;

  if(isDefined(level.transitionarray[scenename][previousscene]) && isDefined(level.transitionarray[scenename][previousscene]["transition"])) {
    transition = level.transitionarray[scenename][previousscene]["transition"];
  } else if(isDefined(level.transitionarray[scenename]["default"]) && isDefined(level.transitionarray[scenename]["default"]["transition"])) {
    transition = level.transitionarray[scenename]["default"]["transition"];
  }

  if(!isDefined(transition)) {
    return true;
  }

  if(transition == &frontend_camera_teleport) {
    return true;
  }

  callback = undefined;

  if(isDefined(level.transitionarray[scenename][previousscene]) && isDefined(level.transitionarray[scenename][previousscene]["callback"])) {
    callback = level.transitionarray[scenename][previousscene]["callback"];
  } else if(isDefined(level.transitionarray[scenename]["default"]) && isDefined(level.transitionarray[scenename]["default"]["callback"])) {
    callback = level.transitionarray[scenename]["default"]["callback"];
  }

  if(!isDefined(callback)) {
    return true;
  }

  if(transition == &frontend_camera_move && callback == &set_xcam) {
    return false;
  }

  return true;
}

function private end_current_xcam() {
  function_b3eabe96f8b37124();
  level notify("xcam_transition");
  level.xcam_anchor.intransition = 0;
}

function private function_e7f97d640f18b510() {
  ismgl = getdvarint(@ "mgl", 0) > 0;
  var_d45fb3ee26047877 = [];
  lobbyxcam = ter_op(ismgl, "mgl_fe_op_lobby_01_xcam", "jup_fe_lobby_plow_cam_01_idle_squad_01_xcam");
  lobbychar = function_70a855dd0c75561c("lobby_charslot_01");
  var_d45fb3ee26047877["squad_lobby"] = [];
  var_d45fb3ee26047877["squad_lobby"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["squad_lobby"]["xcam_data"].origin = lobbychar.origin + ter_op(ismgl, getdvarvector(@ "hash_a64f75b19dd8a93", (2.8, 20, -3.5)), (0, 0, 0));
  var_d45fb3ee26047877["squad_lobby"]["xcam_data"].angles = lobbychar.angles + ter_op(ismgl, getdvarvector(@ "hash_840e8f5916f3fb19", (0, 0, 0)), (0, 0, 0));
  var_d45fb3ee26047877["squad_lobby"]["transitions"] = [];
  var_d45fb3ee26047877["squad_lobby"]["transitions"][0] = lobbyxcam;

  if(!ismgl) {
    var_d45fb3ee26047877["squad_lobby"]["transitions"][1] = "jup_fe_lobby_plow_cam_01_idle_squad_01_xcam";
    var_d45fb3ee26047877["squad_lobby"]["transitions"][2] = "jup_fe_lobby_plow_cam_01_idle_squad_01_xcam";
    var_d45fb3ee26047877["squad_lobby"]["callback"] = &lua_triggered_xcam_mm;
    var_d45fb3ee26047877["squad_lobby"]["flag_msg"] = ["lobby_member_increase", "started_mm"];
  }

  var_d45fb3ee26047877["squad_lobby"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["squad_lobby"]["blend_time"]["lobby_member_increase"] = getdvarfloat(@ "hash_6c2ffd9e1138c485", 4);
  var_d45fb3ee26047877["squad_lobby"]["blend_time"]["started_mm"] = getdvarfloat(@ "hash_acefefc58946a4b7", 2);
  lobbyxcam = ter_op(ismgl, "mgl_fe_op_lobby_01_xcam", "fe_lobby_plow_cam_01_idle_01_xcam");

  if(istrue(level.var_70aee737d4082daf)) {
    lobbychar = getEnt("lobby_dmz_charslot_01", "targetname");
  }

  var_d45fb3ee26047877["squad_lobby_dmz"] = [];
  var_d45fb3ee26047877["squad_lobby_dmz"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["squad_lobby_dmz"]["xcam_data"].origin = lobbychar.origin + ter_op(ismgl, getdvarvector(@ "hash_a64f75b19dd8a93", (2.8, 20, -3.5)), (0, 0, 0));
  var_d45fb3ee26047877["squad_lobby_dmz"]["xcam_data"].angles = lobbychar.angles + ter_op(ismgl, getdvarvector(@ "hash_840e8f5916f3fb19", (0, 0, 0)), (0, 0, 0));
  var_d45fb3ee26047877["squad_lobby_dmz"]["transitions"] = [];
  var_d45fb3ee26047877["squad_lobby_dmz"]["transitions"][0] = lobbyxcam;

  if(!ismgl) {
    var_d45fb3ee26047877["squad_lobby_dmz"]["transitions"][1] = "fe_lobby_plow_cam_01_idle_squad_01_xcam";
    var_d45fb3ee26047877["squad_lobby_dmz"]["transitions"][2] = "fe_lobby_plow_cam_01_mm_01_xcam";
    var_d45fb3ee26047877["squad_lobby_dmz"]["callback"] = &lua_triggered_xcam_mm;
    var_d45fb3ee26047877["squad_lobby_dmz"]["flag_msg"] = ["lobby_member_increase", "started_mm"];
  }

  var_d45fb3ee26047877["squad_lobby_dmz"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["squad_lobby_dmz"]["blend_time"]["lobby_member_increase"] = getdvarfloat(@ "hash_6c2ffd9e1138c485", 4);
  var_d45fb3ee26047877["squad_lobby_dmz"]["blend_time"]["started_mm"] = getdvarfloat(@ "hash_acefefc58946a4b7", 2);
  lobbyxcam = ter_op(ismgl, "mgl_fe_op_lobby_01_xcam", "fe_lobby_plow_cam_01_idle_01_xcam");

  if(istrue(level.var_70aee737d4082daf)) {
    lobbychar = getEnt("lobby_br_charslot_01", "targetname");
  }

  var_d45fb3ee26047877["squad_lobby_br"] = [];
  var_d45fb3ee26047877["squad_lobby_br"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["squad_lobby_br"]["xcam_data"].origin = lobbychar.origin + ter_op(ismgl, getdvarvector(@ "hash_a64f75b19dd8a93", (2.8, 20, -3.5)), (0, 0, 0));
  var_d45fb3ee26047877["squad_lobby_br"]["xcam_data"].angles = lobbychar.angles + ter_op(ismgl, getdvarvector(@ "hash_840e8f5916f3fb19", (0, 0, 0)), (0, 0, 0));
  var_d45fb3ee26047877["squad_lobby_br"]["transitions"] = [];
  var_d45fb3ee26047877["squad_lobby_br"]["transitions"][0] = lobbyxcam;

  if(!ismgl) {
    var_d45fb3ee26047877["squad_lobby_br"]["transitions"][1] = "fe_lobby_plow_cam_01_idle_squad_01_xcam";
    var_d45fb3ee26047877["squad_lobby_br"]["transitions"][2] = "fe_lobby_plow_cam_01_mm_01_xcam";
    var_d45fb3ee26047877["squad_lobby_br"]["callback"] = &lua_triggered_xcam_mm;
    var_d45fb3ee26047877["squad_lobby_br"]["flag_msg"] = ["lobby_member_increase", "started_mm"];
  }

  var_d45fb3ee26047877["squad_lobby_br"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["squad_lobby_br"]["blend_time"]["lobby_member_increase"] = getdvarfloat(@ "hash_6c2ffd9e1138c485", 4);
  var_d45fb3ee26047877["squad_lobby_br"]["blend_time"]["started_mm"] = getdvarfloat(@ "hash_acefefc58946a4b7", 2);
  var_d45fb3ee26047877["character_tango"] = [];
  var_d45fb3ee26047877["character_tango"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["character_tango"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  var_d45fb3ee26047877["character_tango"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["character_tango"]["transitions"] = [];
  var_d45fb3ee26047877["character_tango"]["transitions"][0] = "iw9_fe_op_select_generic_male_west_intro_01_xcam";
  var_d45fb3ee26047877["character_tango"]["transitions"][1] = "iw9_fe_op_select_generic_male_east_intro_01_xcam";
  var_d45fb3ee26047877["character_tango"]["transitions"][2] = "iw9_fe_op_select_generic_female_west_intro_01_xcam";
  var_d45fb3ee26047877["character_tango"]["transitions"][3] = "iw9_fe_op_select_generic_female_east_intro_01_xcam";
  var_d45fb3ee26047877["character_tango"]["transitions"][4] = "iw9_fe_op_select_idle_01_xcam";
  var_d45fb3ee26047877["character_tango"]["callback"] = &function_e7571f41e1d6a427;
  var_d45fb3ee26047877["character_tango"]["flag_msg"] = "none";
  var_d45fb3ee26047877["character_tango"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["character_tango"]["blend_time"]["character_faction_select_l_detail"] = 0.1;
  var_d45fb3ee26047877["character_tango"]["blend_time"]["character_faction_select_r_detail"] = 0.1;
  var_d45fb3ee26047877["character_faction_select_l"] = [];
  var_d45fb3ee26047877["character_faction_select_l"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["character_faction_select_l"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  var_d45fb3ee26047877["character_faction_select_l"]["xcam_data"].angles = (0, -133, 0);
  var_d45fb3ee26047877["character_faction_select_l"]["transitions"] = [];
  var_d45fb3ee26047877["character_faction_select_l"]["transitions"][0] = level.var_8a919d89cd6129ae + "fe_op_select_generic_male_east_intro_01_xcam";
  var_d45fb3ee26047877["character_faction_select_l"]["transitions"][1] = level.var_8a919d89cd6129ae + "fe_op_select_idle_01_xcam";
  var_d45fb3ee26047877["character_faction_select_l_clone"] = [];
  var_d45fb3ee26047877["character_faction_select_l_clone"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["character_faction_select_l_clone"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  var_d45fb3ee26047877["character_faction_select_l_clone"]["xcam_data"].angles = (0, -133, 0);
  var_d45fb3ee26047877["character_faction_select_l_clone"]["transitions"] = [];
  var_d45fb3ee26047877["character_faction_select_l_detail"] = [];
  var_d45fb3ee26047877["character_faction_select_l_detail"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["character_faction_select_l_detail"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  var_d45fb3ee26047877["character_faction_select_l_detail"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["character_faction_select_l_detail"]["transitions"] = [];
  var_d45fb3ee26047877["character_faction_select_l_detail"]["transitions"][0] = "iw9_fe_op_select_west_edit_in_xcam";
  var_d45fb3ee26047877["character_faction_select_r"] = [];
  var_d45fb3ee26047877["character_faction_select_r"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["character_faction_select_r"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  var_d45fb3ee26047877["character_faction_select_r"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["character_faction_select_r"]["transitions"] = [];
  var_d45fb3ee26047877["character_faction_select_r"]["transitions"][0] = level.var_8a919d89cd6129ae + "fe_op_select_generic_male_east_intro_01_xcam";
  var_d45fb3ee26047877["character_faction_select_r"]["transitions"][1] = level.var_8a919d89cd6129ae + "fe_op_select_idle_01_xcam";
  var_d45fb3ee26047877["character_faction_select_r_detail"] = [];
  var_d45fb3ee26047877["character_faction_select_r_detail"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["character_faction_select_r_detail"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  var_d45fb3ee26047877["character_faction_select_r_detail"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["character_faction_select_r_detail"]["transitions"] = [];
  var_d45fb3ee26047877["character_faction_select_r_detail"]["transitions"][0] = "iw9_fe_op_select_east_edit_in_xcam";
  var_d45fb3ee26047877["loadout_showcase_overview"] = [];
  var_d45fb3ee26047877["loadout_showcase_overview"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_overview"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  var_d45fb3ee26047877["loadout_showcase_overview"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["loadout_showcase_overview"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_overview"]["transitions"][0] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_loadout_01_xcam";
  var_d45fb3ee26047877["loadout_showcase_overview"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_overview"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_overview"]["blend_time"]["loadout_showcase"] = 0.3;
  var_d45fb3ee26047877["loadout_showcase_overview"]["blend_time"]["loadout_showcase_overview"] = 0;
  var_d45fb3ee26047877["loadout_showcase_overview"]["loop_last"] = 1;
  var_d45fb3ee26047877["loadout_showcase"] = [];
  var_d45fb3ee26047877["loadout_showcase"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  var_d45fb3ee26047877["loadout_showcase"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["loadout_showcase"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase"]["transitions"][0] = "fe_op_crib_xcam_loadout_02_xcam";
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_overview"] = 0.3;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_p"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_s"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_l"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_t"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["blend_time"]["loadout_showcase_o"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase"]["loop_last"] = 1;
  var_cc25bb795ed240a2 = -206.4;
  var_d45fb3ee26047877["loadout_showcase_preview_small"] = [];
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["xcam_data"].origin = (-5926.6, -3372.8, 49);
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["xcam_data"].angles = (0, var_cc25bb795ed240a2, 0);
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][0] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_01_xcam";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][1] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_br_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][2] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_fg_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][3] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_gp_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][4] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_mg_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][5] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_mz_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][6] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_op_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][7] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_st_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][8] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_um_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][9] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_ammo_zoom";

  if(ismgl) {
    var_d45fb3ee26047877["loadout_showcase_preview_small"]["transitions"][10] = "mgl_fe_op_crib_xcam_gunbench_01_topright_xcam";
  }

  var_d45fb3ee26047877["loadout_showcase_preview_small"]["callback"] = &lua_triggered_attachment_zoom;
  var_d45fb3ee26047877["loadout_showcase_preview_small"]["flag_msg"] = "zoom_triggered";
  var_d45fb3ee26047877["loadout_showcase_preview"] = [];
  var_d45fb3ee26047877["loadout_showcase_preview"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_preview"]["xcam_data"].origin = (-5934.6, -3386.2, 49.7);
  var_d45fb3ee26047877["loadout_showcase_preview"]["xcam_data"].angles = (0, var_cc25bb795ed240a2, 0);
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][0] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_02_xcam";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][1] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_br_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][2] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_fg_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][3] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_gp_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][4] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_mg_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][5] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_mz_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][6] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_op_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][7] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_st_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][8] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_um_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][9] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_ammo_zoom";

  if(ismgl) {
    var_d45fb3ee26047877["loadout_showcase_preview"]["transitions"][10] = "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam";
  }

  var_d45fb3ee26047877["loadout_showcase_preview"]["callback"] = &lua_triggered_attachment_zoom;
  var_d45fb3ee26047877["loadout_showcase_preview"]["flag_msg"] = "zoom_triggered";
  var_d45fb3ee26047877["loadout_showcase_preview_large"] = [];
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["xcam_data"].origin = (-5930.3, -3390.2, 49.1);
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["xcam_data"].angles = (0, var_cc25bb795ed240a2, 0);
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][0] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_03_xcam";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][1] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_br_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][2] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_fg_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][3] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_gp_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][4] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_mg_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][5] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_mz_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][6] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_op_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][7] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_st_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][8] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_um_zoom";
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][9] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_ammo_zoom";

  if(ismgl) {
    var_d45fb3ee26047877["loadout_showcase_preview_large"]["transitions"][10] = "mgl_fe_op_crib_xcam_gunbench_03_topright_xcam";
  }

  var_d45fb3ee26047877["loadout_showcase_preview_large"]["callback"] = &lua_triggered_attachment_zoom;
  var_d45fb3ee26047877["loadout_showcase_preview_large"]["flag_msg"] = "zoom_triggered";
  var_d45fb3ee26047877["loadout_showcase_perks"] = [];
  var_d45fb3ee26047877["loadout_showcase_perks"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_perks"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  var_d45fb3ee26047877["loadout_showcase_perks"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["loadout_showcase_perks"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_perks"]["transitions"][0] = "fe_op_crib_xcam_loadout_pkp_xcam";
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_p"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_s"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_l"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_t"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_o"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_perks"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_perks"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"] = [];
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["xcam_data"].angles = (0, -139.143, 0);
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["transitions"][0] = "fe_op_crib_xcam_loadout_fu_xcam";
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_perks"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_t"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_p"] = 0.25;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_s"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_l"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_o"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_field_upgrade"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["loadout_showcase_p"] = [];
  var_d45fb3ee26047877["loadout_showcase_p"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_p"]["xcam_data"].origin = (-5905.82, -3649.48, 44.0002);
  var_d45fb3ee26047877["loadout_showcase_p"]["xcam_data"].angles = (0, 270, 90);
  var_d45fb3ee26047877["loadout_showcase_p"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_p"]["transitions"][0] = "";
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_s"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_o"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_t"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_l"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_p"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_p"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["loadout_showcase_s"] = [];
  var_d45fb3ee26047877["loadout_showcase_s"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_s"]["xcam_data"].origin = (-5897.97, -3658.72, 44.0002);
  var_d45fb3ee26047877["loadout_showcase_s"]["xcam_data"].angles = (179.99, 270, 90);
  var_d45fb3ee26047877["loadout_showcase_s"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_s"]["transitions"][0] = "";
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_p"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_o"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_perks"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_t"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_l"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_s"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_s"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["loadout_showcase_o"] = [];
  var_d45fb3ee26047877["loadout_showcase_o"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_o"]["xcam_data"].origin = (-5897.97, -3658.72, 44.0002);
  var_d45fb3ee26047877["loadout_showcase_o"]["xcam_data"].angles = (179.99, 270, 90);
  var_d45fb3ee26047877["loadout_showcase_o"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_o"]["transitions"][0] = "";
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_s"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_p"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_perks"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_t"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_l"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_o"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_o"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["loadout_showcase_l"] = [];
  var_d45fb3ee26047877["loadout_showcase_l"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_l"]["xcam_data"].origin = (-5879.75, -3642.25, 42.15);
  var_d45fb3ee26047877["loadout_showcase_l"]["xcam_data"].angles = (0, 230, 0);
  var_d45fb3ee26047877["loadout_showcase_l"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_l"]["transitions"][0] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_loadout_equip_xcam";
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_s"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_p"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_o"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_t"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_l"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_l"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["loadout_showcase_t"] = [];
  var_d45fb3ee26047877["loadout_showcase_t"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["loadout_showcase_t"]["xcam_data"].origin = (-5880.75, -3659, 42.15);
  var_d45fb3ee26047877["loadout_showcase_t"]["xcam_data"].angles = (0, 230, 0);
  var_d45fb3ee26047877["loadout_showcase_t"]["transitions"] = [];
  var_d45fb3ee26047877["loadout_showcase_t"]["transitions"][0] = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_loadout_equip_xcam";
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"] = [];
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_s"] = 0.2;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_p"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_o"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_l"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase"] = 0.15;
  var_d45fb3ee26047877["loadout_showcase_t"]["callback"] = &function_502ef984f5ad944e;
  var_d45fb3ee26047877["loadout_showcase_t"]["flag_msg"] = "loadout_data_set";
  var_d45fb3ee26047877["weapon_preview"] = [];
  var_d45fb3ee26047877["weapon_preview"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_preview"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_preview"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_preview"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_preview"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  var_d45fb3ee26047877["weapon_preview"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_preview"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_preview_small"] = [];
  var_d45fb3ee26047877["weapon_preview_small"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_preview_small"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_preview_small"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_preview_small"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_preview_small"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_01_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
  var_d45fb3ee26047877["weapon_preview_small"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_preview_small"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_preview_large"] = [];
  var_d45fb3ee26047877["weapon_preview_large"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_preview_large"]["xcam_data"].origin = (-3076, 3019.6, 0.2);
  var_d45fb3ee26047877["weapon_preview_large"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_preview_large"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_preview_large"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_03_xcam", "fe_op_crib_xcam_gunbench_03_xcam");
  var_d45fb3ee26047877["weapon_preview_large"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_preview_large"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_preview_riot"] = [];
  var_d45fb3ee26047877["weapon_preview_riot"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_preview_riot"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_preview_riot"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_preview_riot"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_preview_riot"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  var_d45fb3ee26047877["weapon_preview_riot"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_preview_riot"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_progression"] = [];
  var_d45fb3ee26047877["weapon_progression"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_progression"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_progression"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_progression"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_progression"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  var_d45fb3ee26047877["weapon_progression"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_progression"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_progression_small"] = [];
  var_d45fb3ee26047877["weapon_progression_small"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_progression_small"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_progression_small"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_progression_small"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_progression_small"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_01_topright_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
  var_d45fb3ee26047877["weapon_progression_small"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_progression_small"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_progression_large"] = [];
  var_d45fb3ee26047877["weapon_progression_large"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_progression_large"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_progression_large"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_progression_large"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_progression_large"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_03_topright_xcam", "fe_op_crib_xcam_gunbench_03_xcam");
  var_d45fb3ee26047877["weapon_progression_large"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_progression_large"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_customize"] = [];
  var_d45fb3ee26047877["weapon_customize"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_customize"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_customize"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_customize"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_customize"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_top_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  var_d45fb3ee26047877["weapon_customize"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_customize"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_customize_small"] = [];
  var_d45fb3ee26047877["weapon_customize_small"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_customize_small"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_customize_small"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_customize_small"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_customize_small"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_01_top_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
  var_d45fb3ee26047877["weapon_customize_small"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_customize_small"]["blend_time"]["default"] = 0;
  var_d45fb3ee26047877["weapon_customize_large"] = [];
  var_d45fb3ee26047877["weapon_customize_large"]["xcam_data"] = spawnStruct();
  var_d45fb3ee26047877["weapon_customize_large"]["xcam_data"].origin = (-3072, 3072, 0);
  var_d45fb3ee26047877["weapon_customize_large"]["xcam_data"].angles = (0, 180, 0);
  var_d45fb3ee26047877["weapon_customize_large"]["transitions"] = [];
  var_d45fb3ee26047877["weapon_customize_large"]["transitions"][0] = ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_03_top_xcam", "fe_op_crib_xcam_gunbench_03_xcam");
  var_d45fb3ee26047877["weapon_customize_large"]["blend_time"] = [];
  var_d45fb3ee26047877["weapon_customize_large"]["blend_time"]["default"] = 0;

  if(ismgl) {
    var_c84c1a0716e42135 = getEnt("charroom_char_luckydraw_tango_east", "targetname");
    var_d45fb3ee26047877["lucky_draw_operator"] = [];
    var_d45fb3ee26047877["lucky_draw_operator"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_operator"]["xcam_data"].origin = var_c84c1a0716e42135.origin;
    var_d45fb3ee26047877["lucky_draw_operator"]["xcam_data"].angles = var_c84c1a0716e42135.angles + (0, 180, 0);
    var_d45fb3ee26047877["lucky_draw_operator"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_operator"]["transitions"][0] = "mgl_fe_op_luckydraw_01_xcam";
    var_d45fb3ee26047877["lucky_draw_operator"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_operator"]["blend_time"]["default"] = 0;
    var_d45fb3ee26047877["lucky_draw_operator_showcase"] = [];
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["xcam_data"].origin = var_c84c1a0716e42135.origin + getdvarvector(@ "hash_ff373233c4f5ee3", (20, 12, 0));
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["xcam_data"].angles = var_c84c1a0716e42135.angles + (0, 180, 0);
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["transitions"][0] = "mgl_fe_op_luckydraw_showcase_01_xcam";
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_operator_showcase"]["blend_time"]["default"] = 0;
    luckydrawweapon = getEnt("weapon_loc_luckydraw_preview", "targetname");
    var_d45fb3ee26047877["lucky_draw_weapon"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_weapon"]["xcam_data"].origin = luckydrawweapon.origin;
    var_d45fb3ee26047877["lucky_draw_weapon"]["xcam_data"].angles = luckydrawweapon.angles;
    var_d45fb3ee26047877["lucky_draw_weapon"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon"]["transitions"][0] = "mgl_fe_op_crib_xcam_luckydraw_02_xcam";
    var_d45fb3ee26047877["lucky_draw_weapon"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon"]["blend_time"]["default"] = 0;
    var_d45fb3ee26047877["lucky_draw_weapon_small"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["xcam_data"].origin = luckydrawweapon.origin;
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["xcam_data"].angles = luckydrawweapon.angles;
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["transitions"][0] = "mgl_fe_op_crib_xcam_luckydraw_01_xcam";
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_small"]["blend_time"]["default"] = 0;
    var_d45fb3ee26047877["lucky_draw_weapon_large"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["xcam_data"].origin = luckydrawweapon.origin;
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["xcam_data"].angles = luckydrawweapon.angles;
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["transitions"][0] = "mgl_fe_op_crib_xcam_luckydraw_03_xcam";
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_large"]["blend_time"]["default"] = 0;
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["xcam_data"].origin = luckydrawweapon.origin + getdvarvector(@ "hash_17f8c42220c8522b", (-4, 0, -2));
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["xcam_data"].angles = luckydrawweapon.angles;
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["transitions"][0] = "mgl_fe_op_crib_xcam_luckydraw_showcase_02_xcam";
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_showcase"]["blend_time"]["default"] = 0;
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["xcam_data"].origin = luckydrawweapon.origin + getdvarvector(@ "hash_270edac9ce60beec", (-13, -5, -2));
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["xcam_data"].angles = luckydrawweapon.angles;
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["transitions"][0] = "mgl_fe_op_crib_xcam_luckydraw_showcase_01_xcam";
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_small_showcase"]["blend_time"]["default"] = 0;
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["xcam_data"] = spawnStruct();
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["xcam_data"].origin = luckydrawweapon.origin + getdvarvector(@ "hash_270a32a3589fbfb7", (-12, -15, -2));
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["xcam_data"].angles = luckydrawweapon.angles;
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["transitions"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["transitions"][0] = "mgl_fe_op_crib_xcam_luckydraw_showcase_03_xcam";
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["blend_time"] = [];
    var_d45fb3ee26047877["lucky_draw_weapon_large_showcase"]["blend_time"]["default"] = 0;
  }

  level.var_8d5e9fc8ddef81a2 = [];
  level.var_8d5e9fc8ddef81a2[0] = "";
  level.var_8d5e9fc8ddef81a2[1] = "";
  level.var_d45fb3ee26047877 = var_d45fb3ee26047877;
}

function private function_24ef280c015211c3(tagarray) {
  attachtype = tagarray[1];

  if(!isDefined(attachtype)) {
    return undefined;
  }

  return attachtype;
}

function private function_aea02750a3aff7bf(tagarray, weaponpreview, currentscene) {
  xcamname = function_d2e36762f0204dad(tagarray[2], weaponpreview, currentscene);

  if(!isDefined(xcamname)) {
    return undefined;
  }

  tagstruct = spawnStruct();
  tagstruct.name = tagarray[2];
  tagstruct.xcam = xcamname;
  tagstruct.origin = (float(tagarray[3]), float(tagarray[4]), float(tagarray[5]));
  tagstruct.angles = (float(tagarray[6]), float(tagarray[7]), float(tagarray[8]));

  if(isDefined(tagarray[9])) {
    tagstruct.class = tagarray[9];
  }

  if(isDefined(tagarray[10])) {
    tagstruct.weaponname = tagarray[10];
  }

  return tagstruct;
}

function private function_7273f375b5991c19(tagarray, weaponpreview, currentscene) {
  xcamname = function_d2e36762f0204dad(tagarray[0], weaponpreview, currentscene);

  if(!isDefined(xcamname)) {
    return undefined;
  }

  zangle = float(tagarray[6]);

  if(tagarray[0] == "tag_laser_attach") {
    zangle = 90;
  }

  tagstruct = spawnStruct();
  tagstruct.name = tagarray[0];
  tagstruct.xcam = xcamname;
  tagstruct.origin = (float(tagarray[1]), float(tagarray[2]), float(tagarray[3]));
  tagstruct.angles = (float(tagarray[4]), float(tagarray[5]), zangle);
  return tagstruct;
}

function private function_21fd6d79cf32e1ac(class) {
  if(!isDefined(class)) {
    return false;
  }

  return class == "weapon_projectile" || class == "weapon_classic_s" || class == "weapon_melee2" || class == "weapon_melee" || class == "weapon_classic_p";
}

function private function_76228931203a6279(currentscene) {
  if(!isDefined(currentscene)) {
    return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_02_xcam");
  }

  ismgl = getdvarint(@ "mgl", 0) > 0;

  switch (currentscene) {
    case #"hash_5cc66fe2e71f720a":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_01_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
    case #"hash_7e8acee7da2d9002":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_01_xcam");
    case #"hash_5e1d833551ca1661":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_01_top_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
    case #"hash_c364c37a7df6456":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case #"hash_248405f0613a37fd":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case #"hash_19ed0e9de6d8f60e":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_02_xcam");
    case #"hash_2ad4511c672b3479":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_top_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case #"hash_be3bd585498a6ae6":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_03_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
    case #"hash_c36ef36dd1c5f0be":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_03_xcam");
    case #"hash_facaeaf0ac11387d":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_03_top_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
    case #"hash_521816631cee456":
    case #"hash_8576db07bac8d6c2":
    case #"hash_8b6b4b1228fa1fe9":
    case #"hash_ab7920a236c7c262":
      return undefined;
    default:
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_02_xcam");
  }
}

function private function_65b27252ee6e8284(currentscene) {
  ismgl = getdvarint(@ "mgl", 0) > 0;

  if(!isDefined(currentscene)) {
    return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  }

  switch (currentscene) {
    case #"hash_fb8d15ff96772235":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_01_topright_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
    case #"hash_3fec9c3219804c0d":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case #"hash_1d26c8f742a4ef31":
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_03_topright_xcam", "fe_op_crib_xcam_gunbench_03_xcam");
    default:
      return ter_op(ismgl, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  }
}

function private function_d2e36762f0204dad(tag, weaponpreview, currentscene) {
  switch (tag) {
    case #"hash_2ebbd10bc3f36e0e":
    case #"hash_7bdd7b80127fa4f4":
      return function_76228931203a6279(currentscene);
    case #"hash_2f9cdb76a336eceb":
      return function_65b27252ee6e8284(currentscene);
    case #"hash_c140f05197182dbf":
      return "fe_op_crib_xcam_gunbench_mz_xcam";
    case #"hash_b74aa2c7e628b458":
      return "fe_op_crib_xcam_gunbench_br_pistol_xcam";
    case #"hash_8aaca5091d505bc4":
      return "fe_op_crib_xcam_gunbench_br_xcam";
    case #"hash_96d433e5bdc6bf10":
      return "fe_op_crib_xcam_gunbench_br_sniper_xcam";
    case #"hash_b1b3f69cc133ac94":
      return "fe_op_crib_xcam_gunbench_fg_xcam";
    case #"hash_19a1970c29085405":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_lz_xcam");
    case #"hash_635902b104004521":
    case #"hash_9a1cf7dcaacdd82c":
      return "fe_op_crib_xcam_gunbench_mg_xcam";
    case #"hash_84eed77be6815580":
    case #"hash_a52679d5a5b05b52":
      return "fe_op_crib_xcam_gunbench_op_xcam";
    case #"hash_d49595fe0280fea1":
      return "fe_op_crib_xcam_gunbench_gp_xcam";
    case #"hash_57b788e828981035":
    case #"hash_dd3f3b9997ed3d6a":
      return "fe_op_crib_xcam_gunbench_st_xcam";
    case #"hash_6920bec13886425c":
      return "fe_op_crib_xcam_gunbench_um_xcam";
    case #"hash_385d996ef17d925d":
      return "fe_op_crib_xcam_gunbench_ammo";
    case #"hash_a4daec5079604c53":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_ch_xcam");
    case #"hash_3f0ecc42f886065f":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_gs_xcam");
    case #"hash_8501367b06a03483":
      return (level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_gunbench_stkrs_xcam");
    case #"hash_ea364af169c3280e":
      return "fe_op_crib_xcam_gunbench_stkrs_sh_xcam";
    default:
      return undefined;
  }
}

function private function_2d4a4197b801ad83(scenename) {
  switch (scenename) {
    case #"hash_2bc9361cebbbcbd2":
    case #"hash_3287498ac2bdec62":
    case #"hash_7e5fff2eb82441c6":
    case #"hash_703c7fd9224070b1":
      return "tag_silencer";
    case #"hash_21aa25df730e1363":
    case #"hash_1a02be6831832733":
    case #"hash_bed1face88fdcb22":
    case #"hash_bed1f9ce88fdc98f":
    case #"hash_b03e7af96e0cc592":
    case #"hash_5c8cf8ab59b4ef97":
      return "tag_barrel_attach";
    case #"hash_1a96f606bada8c07":
    case #"hash_3d5aa4ebe484d097":
    case #"hash_e2a532526c4b1986":
      return "tag_grip_attach";
    case #"hash_77f7b408606d1238":
    case #"hash_ea6b42a40068e528":
    case #"hash_a5e0219576906481":
    case #"hash_c3c7633ef4e5e971":
    case #"hash_c39eb86ef6e2f365":
    case #"hash_77f7b708606d16f1":
      return "tag_pistolgrip_attach";
    case #"hash_1e404931df187946":
    case #"hash_c9fc556dd4fb88f6":
    case #"hash_b91600265f2dd072":
    case #"hash_5161faf8fea12ebc":
    case #"hash_5161fdf8fea13375":
      return "tag_laser_attach";
    case #"hash_ce66d785edbb652d":
    case #"hash_72931d90e9f9c4fd":
    case #"hash_a29c118653f671":
    case #"hash_7ec8461faf149064":
    case #"hash_7ec8491faf14951d":
    case #"hash_594a0c65c7d7cc28":
    case #"hash_bce86e3a86f0c8ed":
    case #"hash_bce86b3a86f0c434":
      return "j_mag1";
    case #"hash_b254a9604b488320":
    case #"hash_b32dd453b0b185ef":
    case #"hash_a271bcda8ca803bc":
    case #"hash_ffa5b7c1c1a799f0":
      return "tag_reflex";
    case #"hash_189960eb1cd2112f":
    case #"hash_a8d85b2b5283a5cb":
    case #"hash_5890922b50b3f2ce":
    case #"hash_46b9834d37017c5f":
    case #"hash_4194b71a94fb817e":
    case #"hash_4194b61a94fb7feb":
      return "tag_stock_attach";
    case #"hash_ae36caa1297604f2":
    case #"hash_472c95bf362ca54a":
    case #"hash_472c92bf362ca091":
    case #"hash_989642de7c8f0501":
    case #"hash_472c90bf362c9d6b":
    case #"hash_4379b9c7a2831922":
    case #"hash_98963fde7c8f0048":
    case #"hash_19ed0e9de6d8f60e":
    case #"hash_fda8d24e03c1db76":
      return "j_gun";
    default:
      return undefined;
  }
}

function private function_3c8d38b326a9c64f(tagarray) {
  primaryarray = [];
  secondaryarray = [];
  lethalarray = [];
  tacticalarray = [];
  var_21168ac0c3ed30c9 = [];
  var_21168ac0c3ed30c9[2] = -5910;
  var_21168ac0c3ed30c9[3] = -3650;
  var_21168ac0c3ed30c9[4] = 45;
  var_21168ac0c3ed30c9[5] = 0;
  var_21168ac0c3ed30c9[6] = 270;
  var_21168ac0c3ed30c9[7] = 90;
  var_c254a3b1bfc94ae1 = [];
  var_c254a3b1bfc94ae1[10] = -5894;
  var_c254a3b1bfc94ae1[11] = -3658;
  var_c254a3b1bfc94ae1[12] = 45;
  var_c254a3b1bfc94ae1[13] = 360;
  var_c254a3b1bfc94ae1[14] = 90;
  var_c254a3b1bfc94ae1[15] = 90;
  var_2de0742488212fa1 = [];
  var_2de0742488212fa1[17] = -5878;
  var_2de0742488212fa1[18] = -3642;
  var_2de0742488212fa1[19] = 42;
  var_2de0742488212fa1[20] = 0;
  var_2de0742488212fa1[21] = 227;
  var_2de0742488212fa1[22] = 0;
  var_cf03c81cb9cfe7c = [];
  var_cf03c81cb9cfe7c[24] = -5879;
  var_cf03c81cb9cfe7c[25] = -3659;
  var_cf03c81cb9cfe7c[26] = 44;
  var_cf03c81cb9cfe7c[27] = 0;
  var_cf03c81cb9cfe7c[28] = 235;
  var_cf03c81cb9cfe7c[29] = 0;

  for(i = 0; i < tagarray.size; i++) {
    if(i > 7 && i < 16) {
      if(tagarray[i] != "none") {
        secondaryarray[secondaryarray.size] = tagarray[i];
      } else {
        secondaryarray[secondaryarray.size] = var_c254a3b1bfc94ae1[i];
      }

      continue;
    }

    if(i >= 16 && i < 23) {
      if(tagarray[i] != "none") {
        lethalarray[lethalarray.size] = tagarray[i];
      } else {
        lethalarray[lethalarray.size] = var_2de0742488212fa1[i];
      }

      continue;
    }

    if(i >= 23) {
      if(tagarray[i] != "none") {
        tacticalarray[tacticalarray.size] = tagarray[i];
      } else {
        tacticalarray[tacticalarray.size] = var_cf03c81cb9cfe7c[i];
      }

      continue;
    }

    if(tagarray[i] != "none") {
      primaryarray[primaryarray.size] = tagarray[i];
      continue;
    }

    primaryarray[primaryarray.size] = var_21168ac0c3ed30c9[i];
  }

  var_f48b2f9265e216ed = function_17cf8393e8359feb(primaryarray[1]);
  var_c870a7b5804ff26d = function_a2efa6bb922ddcf(secondaryarray[1]);

  if(!isDefined(var_f48b2f9265e216ed) || !isDefined(var_c870a7b5804ff26d)) {
    return undefined;
  }

  var_6362d7a8bdf41f78 = spawnStruct();
  var_6362d7a8bdf41f78.name = "loadout_showcase_p";
  var_6362d7a8bdf41f78.xcam = var_f48b2f9265e216ed;
  var_6362d7a8bdf41f78.origin = (float(primaryarray[2]), float(primaryarray[3]), float(primaryarray[4]));
  var_90b2927bf28547e8 = spawnStruct();
  var_90b2927bf28547e8.name = function_5b8b22b77b344d91(secondaryarray[1]);
  var_90b2927bf28547e8.xcam = var_c870a7b5804ff26d;
  var_90b2927bf28547e8.origin = (float(secondaryarray[2]), float(secondaryarray[3]), float(secondaryarray[4]));
  level.var_d45fb3ee26047877["loadout_showcase_o"]["transitions"] = [];
  level.var_d45fb3ee26047877["loadout_showcase_o"]["transitions"][0] = var_90b2927bf28547e8.xcam;
  var_8bb24f977b8c9fe0 = spawnStruct();
  var_8bb24f977b8c9fe0.name = "loadout_showcase_l";
  var_8bb24f977b8c9fe0.xcam = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_loadout_equip_xcam";
  var_71ba24485168e2fb = spawnStruct();
  var_71ba24485168e2fb.name = "loadout_showcase_t";
  var_71ba24485168e2fb.xcam = level.var_9aa5b3137bd141b4 + "fe_op_crib_xcam_loadout_equip_xcam";
  return [var_6362d7a8bdf41f78, var_90b2927bf28547e8, var_8bb24f977b8c9fe0, var_71ba24485168e2fb];
}

function private function_5b8b22b77b344d91(weaponname) {
  switch (weaponname) {
    case #"hash_bef5ec0b3e197ae":
    case #"hash_16cf6289ab06bd30":
    case #"hash_47368bc0d2ef1565":
    case #"hash_8af0086b038622b5":
    case #"hash_9d18adab1b65a661":
    case #"hash_ab10f9c080fe4faf":
    case #"hash_c095d67337b1f5a1":
    case #"hash_dd616da0b395a0b0":
      return "loadout_showcase_s";
    case #"hash_34340d457a63e7f1":
    case #"hash_86b11ac21f992552":
      return "loadout_showcase_s";
    default:
      return "loadout_showcase_s";
  }
}

function private function_17cf8393e8359feb(tag) {
  switch (tag) {
    case #"hash_a1f27f97be15d620":
    case #"hash_ab10f9c080fe4faf":
      return "fe_op_crib_xcam_loadout_smg_xcam";
    case #"hash_16cf6289ab06bd30":
    case #"hash_47368bc0d2ef1565":
    case #"hash_8af0086b038622b5":
    case #"hash_dd616da0b395a0b0":
      return "fe_op_crib_xcam_loadout_ar_xcam";
    case #"hash_bef5ec0b3e197ae":
    case #"hash_86b11ac21f992552":
    case #"hash_9d18adab1b65a661":
    case #"hash_c095d67337b1f5a1":
      return "fe_op_crib_xcam_loadout_sn_xcam";
    case #"hash_34340d457a63e7f1":
      return "fe_op_crib_xcam_loadout_pi_xcam";
    default:
      return undefined;
  }
}

function private function_a2efa6bb922ddcf(tag) {
  switch (tag) {
    case #"hash_a1f27f97be15d620":
    case #"hash_ab10f9c080fe4faf":
      return "fe_op_crib_xcam_loadout_smg_xcam";
    case #"hash_16cf6289ab06bd30":
    case #"hash_47368bc0d2ef1565":
    case #"hash_8af0086b038622b5":
    case #"hash_dd616da0b395a0b0":
      return "fe_op_crib_xcam_loadout_ar_xcam";
    case #"hash_bef5ec0b3e197ae":
    case #"hash_86b11ac21f992552":
    case #"hash_9d18adab1b65a661":
    case #"hash_c095d67337b1f5a1":
      return "fe_op_crib_xcam_loadout_sn_xcam";
    case #"hash_34340d457a63e7f1":
      return "fe_op_crib_xcam_loadout_pi_xcam";
    default:
      return undefined;
  }
}

function private function_f32739a3b45e91ba(sectionfrom) {
  level.playerviewowner function_451319f93d30ebe5("hw_mp_frontend_lobby_rt");
}

function private function_d5386639bf9fc14c(sectionfrom) {
  level.playerviewowner function_df8fad503896462("hw_mp_frontend_lobby_rt");
}

function function_b7807ab9efbe2177() {
  level.var_2f5d13d3887f56a5 = [];
  level.var_2f5d13d3887f56a5["squad_lobby"] = &function_f32739a3b45e91ba;
  level.var_b50f0a931c0a33a1 = [];
  level.var_b50f0a931c0a33a1["squad_lobby"] = &function_d5386639bf9fc14c;
}

function private initialize_transition_array() {
  ismgl = getdvarint(@ "mgl", 0) > 0;
  transitionarray = [];
  transitionarray["loadout_showcase"] = [];
  transitionarray["loadout_showcase"]["default"] = [];
  transitionarray["loadout_showcase"]["default"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase"]["default"]["fov"] = 85;
  transitionarray["loadout_showcase"]["character_tango"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["character_tango"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase"]["character_tango"]["fov"] = 85;
  transitionarray["loadout_showcase"]["character_tango"]["fadeOutTime"] = 0.1;
  transitionarray["loadout_showcase"]["character_tango"]["fadeInTime"] = 0.1;
  var_1addd326036d635d = [];
  var_1addd326036d635d["transition"] = &frontend_camera_move;
  var_1addd326036d635d["callback"] = &update_entities_and_camera;
  var_1addd326036d635d["fov"] = 50;
  var_1addd326036d635d["speed"] = 200;
  var_1addd326036d635d["accelScalar"] = 0.9;
  var_1addd326036d635d["moveTime"] = 0.4;
  var_1addd326036d635d["decelScalar"] = 0.1;
  transitionarray["loadout_showcase"]["loadout_showcase"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_overview"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_p"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_p_large"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_o"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_o_large"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_s"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_l"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_t"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_field_upgrade"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_field_upgrade_01"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_field_upgrade_02"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_perks"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_x"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_y"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_z"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["loadout_showcase_watch"] = var_1addd326036d635d;
  transitionarray["loadout_showcase"]["squad_lobby"] = [];
  transitionarray["loadout_showcase"]["squad_lobby"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["squad_lobby"]["fov"] = 85;
  transitionarray["loadout_showcase"]["black_screen"] = [];
  transitionarray["loadout_showcase"]["black_screen"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["black_screen"]["fov"] = 50;
  transitionarray["loadout_showcase"]["social"] = [];
  transitionarray["loadout_showcase"]["social"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["social"]["fov"] = 50;
  transitionarray["loadout_showcase"]["social_showcase"] = [];
  transitionarray["loadout_showcase"]["social_showcase"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["social_showcase"]["fov"] = 50;
  transitionarray["loadout_showcase"]["weapon_preview_riot"] = [];
  transitionarray["loadout_showcase"]["weapon_preview_riot"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["weapon_preview_riot"]["fov"] = 50;
  transitionarray["loadout_showcase"]["weapon_preview_small"] = [];
  transitionarray["loadout_showcase"]["weapon_preview_small"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase"]["weapon_preview_small"]["fov"] = 50;
  var_a280f537276c5e42 = [];
  var_a280f537276c5e42["transition"] = &frontend_camera_move;
  var_a280f537276c5e42["callback"] = &set_xcam;
  var_a280f537276c5e42["fov"] = 50;
  var_a280f537276c5e42["speed"] = 75;
  var_a280f537276c5e42["accelScalar"] = 0.9;
  var_a280f537276c5e42["moveTime"] = 0.4;
  var_a280f537276c5e42["decelScalar"] = 0.1;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview"] = var_a280f537276c5e42;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_large"] = var_a280f537276c5e42;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_small"] = var_a280f537276c5e42;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_large"] = var_a280f537276c5e42;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_small"] = var_a280f537276c5e42;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview"] = var_a280f537276c5e42;
  var_aab752cabc872ac6 = [];
  var_aab752cabc872ac6["transition"] = &frontend_camera_teleport;
  var_aab752cabc872ac6["callback"] = &update_entities_and_camera;
  var_aab752cabc872ac6["fov"] = 50;
  var_aab752cabc872ac6["fadeOutTime"] = 0.025;
  var_aab752cabc872ac6["fadeInTime"] = 0.025;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_barrel"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_laser"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_laser_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_laser_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_large_laser"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_magazine"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_muzzle"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_muzzle_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_optic"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_optic_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_reargrip"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_stock"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_large_stock_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt3"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt4"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt3"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt4"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_barrel"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_laser"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_muzzle"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_optic"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_magazine"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_magazine_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_reargrip"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_stock"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_trigger"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_charm"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_sticker"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_barrel"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_barrel_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_laser"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_laser"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_muzzle"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_optic"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_stock"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_stock_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt1"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt2"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt3"] = var_aab752cabc872ac6;
  transitionarray["loadout_showcase_overview"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_overview"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["default"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["accelScalar"] = 0.9;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["moveTime"] = 0.4;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["decelScalar"] = 0.1;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["accelScalar"] = 0.9;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["moveTime"] = 0.4;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["decelScalar"] = 0.1;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["character_tango"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_overview"]["character_tango"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["character_tango"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["character_tango"]["fadeOutTime"] = 0;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_01"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_01"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_01"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_01"]["fov"] = 50;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_02"]["transition"] = &frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_02"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_02"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_field_upgrade_02"]["fov"] = 50;
  previewtransition = [];
  previewtransition["transition"] = &frontend_camera_teleport;
  previewtransition["callback"] = &set_xcam;
  previewtransition["fov"] = 50;
  previewtransition["fadeOutTime"] = 0.1;
  previewtransition["fadeInTime"] = 0.1;
  transitionarray["loadout_showcase_preview"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_p"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_o"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_s"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["weapon_progression"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["weapon_progression_small"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["weapon_progression_large"] = previewtransition;
  transitionarray["loadout_showcase_preview"]["weapon_customize"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_large"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_o_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_p"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_o"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_s"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_progression"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_progression_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_progression_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_customize_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_large"]["weapon_customize_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_small"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_small"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_s"] = previewtransition;
  transitionarray["loadout_showcase_preview_small"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_small"]["weapon_progression_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_small"]["weapon_progression"] = previewtransition;
  transitionarray["loadout_showcase_preview_small"]["weapon_progression_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_small"]["weapon_customize_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_riot"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_riot"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_p"] = previewtransition;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_o"] = previewtransition;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_o_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_s"] = previewtransition;
  transitionarray["loadout_showcase_preview_riot"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_small_sticker"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_small_sticker"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_small_sticker"]["default"]["fov"] = 50;
  transitionarray["loadout_showcase_preview_small_sticker"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_large_sticker"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_large_sticker"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_large_sticker"]["default"]["fov"] = 50;
  transitionarray["loadout_showcase_preview_large_sticker"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt1"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt1"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt2"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt2"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt3"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt3"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt4"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt4"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview_large"] = previewtransition;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview_riot"] = previewtransition;
  transitionarray["loadout_showcase_preview_small_charm"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_small_charm"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_small_charm"]["weapon_preview_small"] = previewtransition;
  transitionarray["loadout_showcase_preview_large_charm"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_large_charm"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_large_charm"]["weapon_preview_large"] = previewtransition;
  transitionarray["weapon_preview"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_preview"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_preview"]["default"]["fov"] = 50;
  transitionarray["weapon_preview"]["weapon_preview"] = previewtransition;
  transitionarray["weapon_preview"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_preview"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_preview"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_preview"]["loadout_showcase_o"] = previewtransition;
  transitionarray["weapon_preview"]["loadout_showcase_preview"] = previewtransition;
  transitionarray["weapon_preview"]["loadout_showcase_preview_large"] = previewtransition;
  transitionarray["weapon_preview"]["weapon_progression"] = previewtransition;
  transitionarray["weapon_preview"]["weapon_customize"] = previewtransition;
  transitionarray["weapon_preview"]["social"] = previewtransition;
  transitionarray["weapon_preview"]["social_showcase"] = previewtransition;
  transitionarray["weapon_preview_large"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_preview_large"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_preview_large"]["default"]["fov"] = 50;
  transitionarray["weapon_preview_large"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_preview_large"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_preview_large"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_preview_large"]["loadout_showcase_preview_large"] = previewtransition;
  transitionarray["weapon_preview_large"]["weapon_progression_large"] = previewtransition;
  transitionarray["weapon_preview_large"]["weapon_customize_large"] = previewtransition;
  transitionarray["weapon_preview_large"]["weapon_customize_riot"] = previewtransition;
  transitionarray["weapon_preview_small"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_preview_small"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_preview_small"]["default"]["fov"] = 50;
  transitionarray["weapon_preview_small"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_preview_small"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_preview_small"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_preview_small"]["loadout_showcase_preview_small"] = previewtransition;
  transitionarray["weapon_preview_small"]["weapon_progression_small"] = previewtransition;
  transitionarray["weapon_preview_small"]["weapon_customize_small"] = previewtransition;
  transitionarray["weapon_preview_riot"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_preview_riot"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_preview_riot"]["default"]["fov"] = 50;
  transitionarray["weapon_preview_riot"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_preview_riot"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_preview_riot"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_progression"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_progression"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["weapon_progression"]["default"]["fov"] = 50;
  transitionarray["weapon_progression"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_progression"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_progression"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_progression"]["loadout_showcase_o"] = previewtransition;
  transitionarray["weapon_progression"]["loadout_showcase_preview"] = previewtransition;
  transitionarray["weapon_progression"]["loadout_showcase_preview_large"] = previewtransition;
  transitionarray["weapon_progression"]["weapon_preview"] = previewtransition;
  transitionarray["weapon_progression"]["weapon_customize"] = previewtransition;
  transitionarray["weapon_progression_large"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_progression_large"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["weapon_progression_large"]["default"]["fov"] = 50;
  transitionarray["weapon_progression_large"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_progression_large"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_progression_large"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_progression_large"]["loadout_showcase_preview_large"] = previewtransition;
  transitionarray["weapon_progression_large"]["weapon_preview_large"] = previewtransition;
  transitionarray["weapon_progression_large"]["weapon_customize_large"] = previewtransition;
  transitionarray["weapon_progression_large"]["weapon_customize_riot"] = previewtransition;
  transitionarray["weapon_progression_small"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_progression_small"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["weapon_progression_small"]["default"]["fov"] = 50;
  transitionarray["weapon_progression_small"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_progression_small"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_progression_small"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_progression_small"]["loadout_showcase_preview_small"] = previewtransition;
  transitionarray["weapon_progression_small"]["weapon_preview_small"] = previewtransition;
  transitionarray["weapon_progression_small"]["weapon_customize_small"] = previewtransition;
  transitionarray["weapon_customize"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_customize"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_customize"]["default"]["fov"] = 50;
  transitionarray["weapon_customize"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_customize"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_customize"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_customize"]["loadout_showcase_o"] = previewtransition;
  transitionarray["weapon_customize"]["loadout_showcase_preview"] = previewtransition;
  transitionarray["weapon_customize"]["loadout_showcase_preview_large"] = previewtransition;
  transitionarray["weapon_customize"]["weapon_preview"] = previewtransition;
  transitionarray["weapon_customize"]["weapon_progression"] = previewtransition;
  transitionarray["weapon_customize_large"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_customize_large"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_customize_large"]["default"]["fov"] = 50;
  transitionarray["weapon_customize_large"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_customize_large"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_customize_large"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_customize_large"]["loadout_showcase_preview_large"] = previewtransition;
  transitionarray["weapon_customize_large"]["weapon_preview_large"] = previewtransition;
  transitionarray["weapon_customize_large"]["weapon_progression_large"] = previewtransition;
  transitionarray["weapon_customize_small"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_customize_small"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_customize_small"]["default"]["fov"] = 50;
  transitionarray["weapon_customize_small"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_customize_small"]["loadout_showcase_p_large"] = previewtransition;
  transitionarray["weapon_customize_small"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_customize_small"]["loadout_showcase_preview_small"] = previewtransition;
  transitionarray["weapon_customize_small"]["weapon_preview_small"] = previewtransition;
  transitionarray["weapon_customize_small"]["weapon_progression_small"] = previewtransition;
  transitionarray["weapon_customize_riot"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_customize_riot"]["default"]["callback"] = &set_xcam;
  transitionarray["weapon_customize_riot"]["default"]["fov"] = 50;
  transitionarray["weapon_customize_riot"]["loadout_showcase_p"] = previewtransition;
  transitionarray["weapon_customize_riot"]["loadout_showcase_s"] = previewtransition;
  transitionarray["weapon_customize_riot"]["weapon_preview_riot"] = previewtransition;
  transitionarray["bundle_preview"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["bundle_preview"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["bundle_preview"]["default"]["fadeOutTime"] = 0;
  transitionarray["bundle_preview_large"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["bundle_preview_large"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["bundle_preview_large"]["default"]["fadeOutTime"] = 0;
  transitionarray["bundle_preview_small"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["bundle_preview_small"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["bundle_preview_small"]["default"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_character_detail"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["battle_pass_character_detail"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["battle_pass_character_detail"]["default"]["fadeOutTime"] = 0;
  transitionarray["bundle_preview_riot"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["bundle_preview_riot"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_preview_watch"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_watch"]["default"]["callback"] = &set_xcam;
  transitionarray["loadout_showcase_preview_watch"]["loadout_showcase_watch"] = previewtransition;
  var_c82921ad71045243["transition"] = &frontend_camera_teleport;
  var_c82921ad71045243["callback"] = &update_entities_and_camera;
  var_c82921ad71045243["fadeOutTime"] = 0.2;
  var_c82921ad71045243["fadeInTime"] = 0.2;
  var_c82921ad71045243["fov"] = 50;
  var_19e7d2726f0d24a5 = [];
  var_19e7d2726f0d24a5["transition"] = &frontend_camera_move;
  var_19e7d2726f0d24a5["callback"] = &update_entities_and_camera;
  var_19e7d2726f0d24a5["fov"] = 50;
  var_19e7d2726f0d24a5["speed"] = 200;
  var_19e7d2726f0d24a5["accelScalar"] = 0.9;
  var_19e7d2726f0d24a5["moveTime"] = 0.4;
  var_19e7d2726f0d24a5["decelScalar"] = 0.1;
  transitionarray["loadout_showcase_p"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["loadout_showcase"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_perks_vest"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_overview"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview_riot"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p"]["social_showcase"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_perks_vest"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_p_large"]["weapon_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["weapon_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["weapon_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["weapon_preview_riot"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_p_large"]["social_showcase"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_field_upgrade"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["loadout_showcase_perks_vest"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_s"]["weapon_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["weapon_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["weapon_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["weapon_preview_riot"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_s"]["social_showcase"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["loadout_showcase_perks_vest"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o"]["weapon_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["weapon_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["weapon_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["weapon_preview_riot"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o"]["social_showcase"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview_riot"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_o_large"]["social_showcase"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_l"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_l"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_perks_vest"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_t"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_field_upgrade_01"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_field_upgrade_02"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_perks_vest"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_x"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_specialist"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_y"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_specialist"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_z"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_specialist"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_watch"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["default"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_p"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_p_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_s"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_o"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_o_large"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_l"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_t"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_field_upgrade"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_perks"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_x"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_y"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_z"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_overview"] = var_19e7d2726f0d24a5;
  transitionarray["character_tango"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_tango"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_tango"]["default"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["default"]["fadeOutTime"] = 0.2;
  transitionarray["character_tango"]["default"]["fadeInTime"] = 0.2;
  transitionarray["character_tango"]["character_faction_select_l_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_tango"]["character_faction_select_l_detail"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["character_faction_select_l_detail"]["callback"] = &update_entities_and_camera;
  transitionarray["character_tango"]["character_faction_select_r_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_tango"]["character_faction_select_r_detail"]["callback"] = &update_entities_and_camera;
  transitionarray["character_tango"]["character_faction_select_r_detail"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_faction_select_l"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_l"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l"]["default"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["speed"] = 150;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["use_bounce"] = 1;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l"]["character_faction_select_r"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_l_clone"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_l_clone"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l_clone"]["default"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_faction_select_l_detail"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_l_detail"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l_detail"]["default"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["default"]["fadeOutTime"] = 0.2;
  transitionarray["character_faction_select_l_detail"]["default"]["fadeInTime"] = 0.2;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_r_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_r_detail"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_r_detail"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l_detail"]["character_tango"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_l_detail"]["character_tango"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["character_tango"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["speed"] = 150;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["use_bounce"] = 1;
  transitionarray["character_faction_select_r"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_r"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_r"]["default"]["fov"] = level.camera_character_faction_select_r.myfov;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["speed"] = 150;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["use_bounce"] = 1;
  transitionarray["character_faction_select_r"]["character_faction_select_l"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_r_detail"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_faction_select_r_detail"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_r_detail"]["default"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_faction_select_r_detail"]["default"]["fadeOutTime"] = 0.2;
  transitionarray["character_faction_select_r_detail"]["default"]["fadeInTime"] = 0.2;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_l_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_l_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_l_detail"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_r_detail"]["character_tango"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_r_detail"]["character_tango"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_r_detail"]["character_tango"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["transition"] = &frontend_camera_move;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["speed"] = 150;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["fov"] = level.camera_character_faction_select_r.myfov;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["callback"] = &update_entities_and_camera;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["use_bounce"] = 1;
  transitionarray["character_preview_select"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_preview_select"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_preview_select"]["default"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["transition"] = &frontend_camera_move;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["speed"] = 150;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["use_bounce"] = 1;
  transitionarray["character_preview_select"]["character_preview_select"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_preview_select_detail"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_preview_select_detail"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_preview_select_detail"]["default"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_preview_select_detail"]["character_preview_select_detail"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_preview_select_detail"]["character_preview_select_detail"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["transition"] = &frontend_camera_move;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["speed"] = 150;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["use_bounce"] = 1;
  transitionarray["character_tournaments"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["character_tournaments"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["character_tournaments"]["default"]["fov"] = 36;
  transitionarray["squad_lobby"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby"]["default"]["fov"] = 36;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["transition"] = &frontend_camera_move;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["speed"] = 150;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["fov"] = 36;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["use_bounce"] = 1;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["fov"] = 36;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["fadeOutTime"] = 0;
  transitionarray["squad_lobby_dmz"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby_dmz"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby_dmz"]["default"]["fov"] = 36;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["transition"] = &frontend_camera_move;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["speed"] = 150;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["fov"] = 36;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["use_bounce"] = 1;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["fov"] = 36;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["fadeOutTime"] = 0;
  transitionarray["squad_lobby_br"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby_br"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby_br"]["default"]["fov"] = 36;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["transition"] = &frontend_camera_move;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["speed"] = 150;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["fov"] = 36;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["use_bounce"] = 1;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["fov"] = 36;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["fadeOutTime"] = 0;
  transitionarray["squad_lobby_detail"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["squad_lobby_detail"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["squad_lobby_detail"]["default"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["transition"] = &frontend_camera_move;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["speed"] = 150;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["use_bounce"] = 1;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["transition"] = &frontend_camera_move;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["speed"] = 150;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["use_bounce"] = 1;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["transition"] = &frontend_camera_move;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["speed"] = 150;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["use_bounce"] = 1;

  if(ismgl) {
    var_bba55f0e43a4671d = [];
    var_bba55f0e43a4671d["transition"] = &frontend_camera_teleport;
    var_bba55f0e43a4671d["fov"] = 36;
    transitionarray["lucky_draw_operator"]["default"] = var_bba55f0e43a4671d;
    transitionarray["lucky_draw_weapon"]["default"] = var_bba55f0e43a4671d;
    transitionarray["lucky_draw_weapon_small"]["default"] = var_bba55f0e43a4671d;
    transitionarray["lucky_draw_weapon_large"]["default"] = var_bba55f0e43a4671d;
  }

  transitionarray["social"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["social"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["social"]["default"]["fov"] = 36;
  transitionarray["social"]["social_detail"]["transition"] = &frontend_camera_move;
  transitionarray["social"]["social_detail"]["speed"] = 150;
  transitionarray["social"]["social_detail"]["fov"] = 36;
  transitionarray["social"]["social_detail"]["use_bounce"] = 1;
  transitionarray["social_detail"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["social_detail"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["social_detail"]["default"]["fov"] = 36;
  transitionarray["social_detail"]["social"]["transition"] = &frontend_camera_move;
  transitionarray["social_detail"]["social"]["speed"] = 150;
  transitionarray["social_detail"]["social"]["fov"] = 36;
  transitionarray["social_detail"]["social"]["use_bounce"] = 1;
  transitionarray["social_wide"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["social_wide"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["social_wide"]["default"]["fov"] = 36;
  transitionarray["social_showcase"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["social_showcase"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["social_showcase"]["default"]["fov"] = 36;
  transitionarray["showcase_operator"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["showcase_operator"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["showcase_operator"]["default"]["fov"] = 36;
  transitionarray["showcase_weapon"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["showcase_weapon"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["showcase_weapon"]["default"]["fov"] = 36;
  transitionarray["aar_performance"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["aar_performance"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["aar_performance"]["default"]["fov"] = 36;
  transitionarray["ui_bg_01"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["ui_bg_01"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["ui_bg_01"]["default"]["fov"] = 28;
  transitionarray["weapon_showcase"] = [];
  transitionarray["weapon_showcase"]["default"] = [];
  transitionarray["weapon_showcase"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["weapon_showcase"]["default"]["callback"] = &update_camera_depth_of_field;
  transitionarray["weapon_showcase"]["default"]["fov"] = 50;
  transitionarray["barracks"] = [];
  transitionarray["barracks"]["default"] = [];
  transitionarray["barracks"]["default"]["transition"] = &frontend_camera_move;
  transitionarray["barracks"]["default"]["callback"] = &update_camera_depth_of_field;
  transitionarray["barracks"]["default"]["speed"] = 100;
  transitionarray["barracks"]["weapon_showcase"]["speed"] = 5000;
  transitionarray["player_character_showcase"] = [];
  transitionarray["player_character_showcase"]["default"] = [];
  transitionarray["player_character_showcase"]["default"]["transition"] = &frontend_camera_teleport;
  transitionarray["player_character_showcase"]["default"]["callback"] = &update_player_character_showcase;
  var_15614224c14e9efd = [];
  var_15614224c14e9efd["transition"] = &frontend_camera_teleport;
  var_15614224c14e9efd["fadeOutTime"] = 0.1;
  var_15614224c14e9efd["fadeInTime"] = 0.15;
  transitionarray["battle_pass_vehicle"]["default"] = var_15614224c14e9efd;
  transitionarray["battle_pass_vehicle"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["battle_pass_character"]["default"] = var_15614224c14e9efd;
  transitionarray["battle_pass_character"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["battle_pass_weapon"]["default"] = var_15614224c14e9efd;
  transitionarray["battle_pass_weapon"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["battle_pass_items"]["default"] = var_15614224c14e9efd;
  transitionarray["battle_pass_items"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["battle_pass_vehicle"]["social"] = [];
  transitionarray["battle_pass_vehicle"]["social"]["transition"] = &frontend_camera_teleport;
  transitionarray["battle_pass_vehicle"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_vehicle"]["social"]["fadeInTime"] = 0;
  transitionarray["battle_pass_character"]["social"] = [];
  transitionarray["battle_pass_character"]["social"]["transition"] = &frontend_camera_teleport;
  transitionarray["battle_pass_character"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_character"]["social"]["fadeInTime"] = 0;
  transitionarray["battle_pass_weapon"]["social"] = [];
  transitionarray["battle_pass_weapon"]["social"]["transition"] = &frontend_camera_teleport;
  transitionarray["battle_pass_weapon"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_weapon"]["social"]["fadeInTime"] = 0;
  transitionarray["battle_pass_items"]["social"] = [];
  transitionarray["battle_pass_items"]["social"]["transition"] = &frontend_camera_teleport;
  transitionarray["battle_pass_items"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_items"]["social"]["fadeInTime"] = 0;
  transitionarray["firingrange"]["default"] = var_15614224c14e9efd;
  transitionarray["firingrange"]["default"]["callback"] = &update_entities_and_camera;
  transitionarray["loadout_showcase_field_upgrade"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_field_upgrade"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["bundle_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["bundle_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["bundle_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade"]["battle_pass_character_detail"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_field_upgrade_01"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["loadout_showcase_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["loadout_showcase_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["bundle_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["bundle_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["bundle_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_01"]["battle_pass_character_detail"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_field_upgrade_02"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["loadout_showcase_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["loadout_showcase_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["loadout_showcase_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["bundle_preview"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["bundle_preview_large"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["bundle_preview_small"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_field_upgrade_02"]["battle_pass_character_detail"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_perks_vest"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks_gloves"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks_boots"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks_gear_1"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks_gear_2"]["default"] = var_19e7d2726f0d24a5;
  transitionarray["loadout_showcase_perks_vest"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_perks_gloves"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_perks_boots"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_perks_gear_1"]["social"] = var_c82921ad71045243;
  transitionarray["loadout_showcase_perks_gear_2"]["social"] = var_c82921ad71045243;
  level.transitionarray = transitionarray;
}

function private get_section_state(requestedsection) {
  ismgl = getdvarint(@ "mgl", 0) > 0;
  sectionstate = [];
  var_acf68bb64d0400f8 = !isDefined(level.active_scene_data) || level.transition_interrupted;
  gametype = getDvar(@ "ui_gametype");
  sunset = getDvar(@ "sunset_visionset");
  level.playerviewowner visionsetnakedforplayer("", 0);

  switch (requestedsection.name) {
    case #"hash_1326142e1033cb47":
      break;
    case #"hash_9dd6064e8ca4a5d5":
      sectionstate["scene"] = level.var_61f3469bfd32fc67;
      sectionstate["camera"] = level.var_61f3469bfd32fc67.basecam;
      break;
    case #"hash_1b3ccd8c05bf147a":
      sectionstate["scene"] = level.camera_lobby;
      sectionstate["camera"] = level.camera_lobby.basecam;

      if(ismgl) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_lobby", 0);
      }

      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_41ede176398a67ae();

      if(gametype == "ob") {
        thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      }

      if(sunset == "1") {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_jup_01_lobby", 0);
      }

      break;
    case #"hash_a03b1add89f2d35e":
      sectionstate["scene"] = level.camera_lobby_detail;
      sectionstate["camera"] = level.camera_lobby_detail.basecam;

      if(ismgl) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_lobby", 0);
      }

      break;
    case #"hash_f7f91c417f08f99a":
      if(istrue(level.var_70aee737d4082daf)) {
        sectionstate["scene"] = level.var_b78f085ce2b63f91;
        sectionstate["camera"] = level.var_b78f085ce2b63f91.basecam;
      } else {
        sectionstate["scene"] = level.camera_lobby_detail;
        sectionstate["camera"] = level.camera_lobby_detail.basecam;
      }

      if(ismgl) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_lobby", 0);
      }

      break;
    case #"hash_97752ff2d2989d0f":
      if(istrue(level.var_70aee737d4082daf)) {
        sectionstate["scene"] = level.var_e679086c223bdfa;
        sectionstate["camera"] = level.var_e679086c223bdfa.basecam;
      } else {
        sectionstate["scene"] = level.camera_lobby_detail;
        sectionstate["camera"] = level.camera_lobby_detail.basecam;
      }

      if(ismgl) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_lobby", 0);
      }

      break;
    case #"hash_82bd1bffd7e1f1a6":
      sectionstate["scene"] = level.var_e679086c223bdfa;
      sectionstate["camera"] = level.var_e679086c223bdfa.basecam;
      break;
    case #"hash_110fbc0b986c29aa":
      sectionstate["scene"] = level.var_816f5b98cfe745fe;
      sectionstate["camera"] = level.var_816f5b98cfe745fe.basecam;
      break;
    case #"hash_f014ffc8aa724fb":
      sectionstate["scene"] = level.var_b78f085ce2b63f91;
      sectionstate["camera"] = level.var_b78f085ce2b63f91.basecam;
      break;
    case #"hash_ee2ab54cbbc82cbd":
      sectionstate["scene"] = level.var_837428c53be309fb;
      sectionstate["camera"] = level.var_837428c53be309fb.basecam;
      break;
    case #"hash_a4ee0391db6b651f":
      sectionstate["scene"] = level.camera_crib_dmz;
      sectionstate["camera"] = level.camera_crib_dmz.basecam;
      break;
    case #"hash_787e7e5e19624661":
      sectionstate["scene"] = level.camera_crib_dmz_detail;
      sectionstate["camera"] = level.camera_crib_dmz_detail.basecam;
      break;
    case #"hash_40248e51024c9732":
      sectionstate["scene"] = level.camera_social;
      sectionstate["camera"] = level.camera_social.basecam;
      break;
    case #"hash_1319c1ff531ed768":
      sectionstate["scene"] = level.var_b4d7482dcafb066a;
      sectionstate["camera"] = level.var_b4d7482dcafb066a.basecam;
      break;
    case #"hash_fa98418ade667a96":
      sectionstate["scene"] = level.var_3bfbe3641dfecff0;
      sectionstate["camera"] = level.var_3bfbe3641dfecff0.basecam;
      break;
    case #"hash_94165ff5cf7fa155":
      sectionstate["scene"] = level.var_c0c7e6be70482b73;
      sectionstate["camera"] = level.var_c0c7e6be70482b73.basecam;
      break;
    case #"hash_a155b5016bfdb759":
      sectionstate["scene"] = level.var_8302cd976fa0a3;
      sectionstate["camera"] = level.var_8302cd976fa0a3.basecam;
      break;
    case #"hash_15c453ef442d22e6":
      sectionstate["scene"] = level.var_32d5bc10c9517a5c;
      sectionstate["camera"] = level.var_32d5bc10c9517a5c.basecam;
      break;
    case #"hash_104db2c291aca36e":
      sectionstate["scene"] = level.camera_character_tango;
      sectionstate["camera"] = level.camera_character_tango.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_b81b35afd5c271cf();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_3d536453ebbe96e0();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_c9bb3dc88b9fd73d":
      sectionstate["scene"] = level.var_5215fa2603c0cd47;
      sectionstate["camera"] = level.var_5215fa2603c0cd47.basecam;
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_53438926fbd080b5();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_e455bc38a3035527":
      sectionstate["scene"] = level.var_6c5e13e5cadf25c9;
      sectionstate["camera"] = level.var_6c5e13e5cadf25c9.basecam;
      function_47f8406a4c96af32("store_character");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_65314805226740a":
      sectionstate["scene"] = level.var_ead7de7f41b832bc;
      sectionstate["camera"] = level.var_ead7de7f41b832bc.basecam;
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_53438926fbd080b5();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_2c9fc69edeb2af26":
      sectionstate["scene"] = level.var_5dc4697427310378;
      sectionstate["camera"] = level.var_5dc4697427310378.basecam;
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_53438926fbd080b5();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_6a6ef27fa322fdb6":
      sectionstate["scene"] = level.var_e671031110af7f94;
      sectionstate["camera"] = level.var_e671031110af7f94.basecam;
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_53438926fbd080b5();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_ab7920a236c7c262":
      sectionstate["scene"] = level.var_af794e04046d3d0c;
      sectionstate["camera"] = level.var_af794e04046d3d0c.basecam;
      break;
    case #"hash_8576db07bac8d6c2":
      sectionstate["scene"] = level.var_ed5abb1b576fe118;
      sectionstate["camera"] = level.var_ed5abb1b576fe118.basecam;
      break;
    case #"hash_521816631cee456":
      sectionstate["scene"] = level.var_bd4429cf96edc040;
      sectionstate["camera"] = level.var_bd4429cf96edc040.basecam;
      break;
    case #"hash_8b6b4b1228fa1fe9":
      sectionstate["scene"] = level.var_215ed1c3599cd313;
      sectionstate["camera"] = level.var_215ed1c3599cd313.basecam;
      break;
    case #"hash_51de71777d38997":
      sectionstate["scene"] = level.var_aeb531c63a3266d6;
      sectionstate["camera"] = level.var_aeb531c63a3266d6.basecam;
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_4b6d3aaf28ce27af":
      sectionstate["scene"] = level.camera_character_faction_select_l;
      sectionstate["camera"] = level.camera_character_faction_select_l.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_95b65e00718558d":
      sectionstate["scene"] = level.camera_character_faction_select_l;
      sectionstate["camera"] = level.camera_character_faction_select_l.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_d75ba083b1c5e911":
      sectionstate["scene"] = level.camera_character_faction_select_l_detail;
      sectionstate["camera"] = level.camera_character_faction_select_l_detail.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_e68fc7cfd8cc07b8":
      sectionstate["scene"] = level.camera_character_preview_select;
      sectionstate["camera"] = level.camera_character_preview_select.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_88359450d2fe1974":
      sectionstate["scene"] = level.camera_character_preview_select_detail;
      sectionstate["camera"] = level.camera_character_preview_select_detail.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_4b6d30af28ce17f1":
      sectionstate["scene"] = level.camera_character_faction_select_r;
      sectionstate["camera"] = level.camera_character_faction_select_r.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_442dd9aded5a5adb":
      sectionstate["scene"] = level.camera_character_faction_select_r_detail;
      sectionstate["camera"] = level.camera_character_faction_select_r_detail.basecam;
      function_47f8406a4c96af32("Operator");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_acf8b8703896231b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_5fb647ebf45ace9b":
      sectionstate["scene"] = level.camera_character_tournaments;
      sectionstate["camera"] = level.camera_character_tournaments.basecam;
      break;
    case #"hash_4205f17832919979":
      sectionstate["scene"] = level.camera_loadout_showcase_overview;
      sectionstate["camera"] = level.camera_loadout_showcase_overview.basecam;
      function_47f8406a4c96af32("Loadout");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_4e390c2c37cff5e();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_92097d6de58d5f2b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_c364c37a7df6456":
      sectionstate["scene"] = level.var_7cf9581b3a0c8511;
      sectionstate["camera"] = level.var_7cf9581b3a0c8511.basecam;
      raritycamera("medium");
      function_47f8406a4c96af32("Gunbench");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_3d536453ebbe96e0();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_92097d6de58d5f2b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_5ba05843b262c3d7();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      level.playerviewowner visionsetnakedforplayer("mp_frontend_jup_01_weapon_preview", 0);
      break;
    case #"hash_be3bd585498a6ae6":
      sectionstate["scene"] = level.var_823394ceaac62e95;
      sectionstate["camera"] = level.var_823394ceaac62e95.basecam;
      raritycamera("large");
      function_47f8406a4c96af32("Gunbench");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_jup_01_weapon_preview", 0);
      break;
    case #"hash_5cc66fe2e71f720a":
      sectionstate["scene"] = level.var_a31a266a6008f399;
      sectionstate["camera"] = level.var_a31a266a6008f399.basecam;
      raritycamera("small");
      function_47f8406a4c96af32("Gunbench");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_jup_01_weapon_preview", 0);
      break;
    case #"hash_248405f0613a37fd":
      sectionstate["scene"] = level.var_a5a822ffa6e52b60;
      sectionstate["camera"] = level.var_a5a822ffa6e52b60.basecam;
      break;
    case #"hash_3fec9c3219804c0d":
      sectionstate["scene"] = level.var_c62dad9dd0cac55e;
      sectionstate["camera"] = level.var_c62dad9dd0cac55e.basecam;
      raritycamera("medium");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_1d26c8f742a4ef31":
      sectionstate["scene"] = level.var_b8bf2aaa73b51a2e;
      sectionstate["camera"] = level.var_b8bf2aaa73b51a2e.basecam;
      raritycamera("large");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_fb8d15ff96772235":
      sectionstate["scene"] = level.var_1fc849ffb55cda12;
      sectionstate["camera"] = level.var_1fc849ffb55cda12.basecam;
      raritycamera("small");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_2ad4511c672b3479":
      sectionstate["scene"] = level.var_f6700e1227881ee6;
      sectionstate["camera"] = level.var_f6700e1227881ee6.basecam;
      raritycamera("medium");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_facaeaf0ac11387d":
      sectionstate["scene"] = level.var_6c202b6758ce5a16;
      sectionstate["camera"] = level.var_6c202b6758ce5a16.basecam;
      raritycamera("large");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_5e1d833551ca1661":
      sectionstate["scene"] = level.var_593d9a9218690ada;
      sectionstate["camera"] = level.var_593d9a9218690ada.basecam;
      raritycamera("small");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_98e7b38df85ca168":
      sectionstate["scene"] = level.var_be74dc099f9c404d;
      sectionstate["camera"] = level.var_be74dc099f9c404d.basecam;
      raritycamera("large");
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_19ed0e9de6d8f60e":
      sectionstate["scene"] = level.camera_loadout_showcase_preview;
      sectionstate["camera"] = level.camera_loadout_showcase_preview.basecam;
      raritycamera("medium");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_3d536453ebbe96e0();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_92097d6de58d5f2b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_5ba05843b262c3d7();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_c36ef36dd1c5f0be":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large.basecam;
      raritycamera("large");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_92097d6de58d5f2b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_3d536453ebbe96e0();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_5ba05843b262c3d7();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_7e8acee7da2d9002":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small.basecam;
      raritycamera("small");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_92097d6de58d5f2b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_3d536453ebbe96e0();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_5ba05843b262c3d7();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      function_47f8406a4c96af32("Gunbench");
      break;
    case #"hash_44ddc2242369a755":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_riot;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_riot.basecam;
      break;
    case #"hash_bfc3955a42dd0442":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_watch;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_watch.basecam;
      raritycamera("watch");
      break;
    case #"hash_1a02be6831832733":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_barrel;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_barrel.basecam;
      break;
    case #"hash_bed1face88fdcb22":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_barrel_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_barrel_alt1.basecam;
      break;
    case #"hash_bed1f9ce88fdc98f":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_barrel_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_barrel_alt2.basecam;
      break;
    case #"hash_ae36caa1297604f2":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_charm;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_charm.basecam;
      break;
    case #"hash_472c92bf362ca091":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_charm_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_charm_alt1.basecam;
      break;
    case #"hash_472c8fbf362c9bd8":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_charm_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_charm_alt2.basecam;
      break;
    case #"hash_472c90bf362c9d6b":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_charm_alt3;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_charm_alt3.basecam;
      break;
    case #"hash_472c95bf362ca54a":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_charm_alt4;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_charm_alt4.basecam;
      break;
    case #"hash_c9fc556dd4fb88f6":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_laser;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_laser.basecam;
      break;
    case #"hash_5161fdf8fea13375":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_laser_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_laser_alt1.basecam;
      break;
    case #"hash_5161faf8fea12ebc":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_laser_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_laser_alt2.basecam;
      break;
    case #"hash_ce66d785edbb652d":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_magazine;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_magazine.basecam;
      break;
    case #"hash_7ec8461faf149064":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_magazine_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_magazine_alt1.basecam;
      break;
    case #"hash_7ec8491faf14951d":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_magazine_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_magazine_alt2.basecam;
      break;
    case #"hash_2bc9361cebbbcbd2":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_muzzle;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_muzzle.basecam;
      break;
    case #"hash_703c7fd9224070b1":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_muzzle_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_muzzle_alt1.basecam;
      break;
    case #"hash_b254a9604b488320":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_optic;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_optic.basecam;
      break;
    case #"hash_b32dd453b0b185ef":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_optic_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_optic_alt1.basecam;
      break;
    case #"hash_a5e0219576906481":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_reargrip;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_reargrip.basecam;
      break;
    case #"hash_77f7b408606d1238":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_reargrip_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_reargrip_alt1.basecam;
      break;
    case #"hash_77f7b708606d16f1":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_reargrip_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_reargrip_alt2.basecam;
      break;
    case #"hash_d566f0bff3ad6ffe":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_sticker;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_sticker.basecam;
      break;
    case #"hash_9aea309bf7e7e9ed":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_sticker_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_sticker_alt1.basecam;
      break;
    case #"hash_9aea2d9bf7e7e534":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_sticker_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_sticker_alt2.basecam;
      break;
    case #"hash_9aea2e9bf7e7e6c7":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_sticker_alt3;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_sticker_alt3.basecam;
      break;
    case #"hash_9aea2b9bf7e7e20e":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_sticker_alt4;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_sticker_alt4.basecam;
      break;
    case #"hash_46b9834d37017c5f":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_stock;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_stock.basecam;
      break;
    case #"hash_4194b71a94fb817e":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_stock_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_stock_alt1.basecam;
      break;
    case #"hash_4194b61a94fb7feb":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_stock_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_stock_alt2.basecam;
      break;
    case #"hash_1a96f606bada8c07":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_underbarrel;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_underbarrel.basecam;
      break;
    case #"hash_21aa25df730e1363":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_barrel;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_barrel.basecam;
      break;
    case #"hash_b03e7af96e0cc592":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_barrel_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_barrel_alt1.basecam;
      break;
    case #"hash_4379b9c7a2831922":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_charm;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_charm.basecam;
      break;
    case #"hash_989642de7c8f0501":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_charm_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_charm_alt1.basecam;
      break;
    case #"hash_98963fde7c8f0048":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_charm_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_charm_alt2.basecam;
      break;
    case #"hash_1e404931df187946":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_laser;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_laser.basecam;
      break;
    case #"hash_72931d90e9f9c4fd":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_magazine;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_magazine.basecam;
      break;
    case #"hash_bce86b3a86f0c434":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt1.basecam;
      break;
    case #"hash_bce86e3a86f0c8ed":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt2.basecam;
      break;
    case #"hash_3287498ac2bdec62":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_muzzle;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_muzzle.basecam;
      break;
    case #"hash_5bbe3fca9d4cc6c1":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_muzzle_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam;
      break;
    case #"hash_ffa5b7c1c1a799f0":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_optic;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_optic.basecam;
      break;
    case #"hash_c3c7633ef4e5e971":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_reargrip;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_reargrip.basecam;
      break;
    case #"hash_ea6b42a40068e528":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_reargrip_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam;
      break;
    case #"hash_f1629b80ba25d36e":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_sticker;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_sticker.basecam;
      break;
    case #"hash_646e277328ea1c5d":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_sticker_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_sticker_alt1.basecam;
      break;
    case #"hash_646e247328ea17a4":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_sticker_alt2;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_sticker_alt2.basecam;
      break;
    case #"hash_646e257328ea1937":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_sticker_alt3;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_sticker_alt3.basecam;
      break;
    case #"hash_189960eb1cd2112f":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_stock;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_stock.basecam;
      break;
    case #"hash_5890922b50b3f2ce":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_stock_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_stock_alt1.basecam;
      break;
    case #"hash_3d5aa4ebe484d097":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_underbarrel;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_underbarrel.basecam;
      break;
    case #"hash_e2a532526c4b1986":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_large_underbarrel_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam;
      break;
    case #"hash_5c8cf8ab59b4ef97":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_barrel;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_barrel.basecam;
      break;
    case #"hash_fda8d24e03c1db76":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_charm;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_charm.basecam;
      break;
    case #"hash_b91600265f2dd072":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_laser;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_laser.basecam;
      break;
    case #"hash_a29c118653f671":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_magazine;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_magazine.basecam;
      break;
    case #"hash_594a0c65c7d7cc28":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_magazine_alt1;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_magazine_alt1.basecam;
      break;
    case #"hash_7e5fff2eb82441c6":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_muzzle;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_muzzle.basecam;
      break;
    case #"hash_a271bcda8ca803bc":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_optic;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_optic.basecam;

      if(!ismgl) {
        break;
      }
    case #"hash_c39eb86ef6e2f365":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_reargrip;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_reargrip.basecam;
      break;
    case #"hash_5d37977ba99ef70a":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_sticker;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_sticker.basecam;
      break;
    case #"hash_a8d85b2b5283a5cb":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_stock;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_stock.basecam;
      break;
    case #"hash_e20e17a8dfe74e9":
      sectionstate["scene"] = level.camera_loadout_showcase_preview_small_trigger;
      sectionstate["camera"] = level.camera_loadout_showcase_preview_small_trigger.basecam;
      break;
    case #"hash_eabd7b3e2f655111":
      sectionstate["scene"] = level.camera_loadout_showcase;
      sectionstate["camera"] = level.camera_loadout_showcase.basecam;
      function_47f8406a4c96af32("Loadout");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fee0f9a43c6aa();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_92097d6de58d5f2b();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_4ed1bd50498307a0":
      sectionstate["scene"] = level.camera_loadout_showcase_armory;
      sectionstate["camera"] = level.camera_loadout_showcase_armory.basecam;
      break;
    case #"hash_34a12b8952ffa106":
      sectionstate["scene"] = level.camera_loadout_showcase_p;
      sectionstate["camera"] = level.camera_loadout_showcase_p.basecam;
      function_47f8406a4c96af32("Loadout");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_2d78680345ec28d6":
      sectionstate["scene"] = level.camera_loadout_showcase_p_large;
      sectionstate["camera"] = level.camera_loadout_showcase_p_large.basecam;
      function_47f8406a4c96af32("Loadout");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_d99194cd0b2f101c();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_34a12a8952ff9f73":
      sectionstate["scene"] = level.camera_loadout_showcase_s;
      sectionstate["camera"] = level.camera_loadout_showcase_s.basecam;
      function_47f8406a4c96af32("Loadout");
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_7f5fef0f9a43c8dd();
      thread scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::function_886baf008b3c1850();
      break;
    case #"hash_34a1468952ffcb87":
      sectionstate["scene"] = level.camera_loadout_showcase_o;
      sectionstate["camera"] = level.camera_loadout_showcase_o.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_de5d7c1255c8ccb7":
      sectionstate["scene"] = level.camera_loadout_showcase_o_large;
      sectionstate["camera"] = level.camera_loadout_showcase_o_large.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_34a1478952ffcd1a":
      sectionstate["scene"] = level.camera_loadout_showcase_l;
      sectionstate["camera"] = level.camera_loadout_showcase_l.basecam;
      function_47f8406a4c96af32("Loadout_lethal");

      if(ismgl) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_lethal", 0);
      }

      break;
    case #"hash_34a12f8952ffa752":
      sectionstate["scene"] = level.camera_loadout_showcase_t;
      sectionstate["camera"] = level.camera_loadout_showcase_t.basecam;
      function_47f8406a4c96af32("Loadout_tactical");

      if(ismgl) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_tactical", 0);
      }

      break;
    case #"hash_45ebf138ab51a7d1":
      sectionstate["scene"] = level.var_d693f81e12da320;
      sectionstate["camera"] = level.var_d693f81e12da320.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_337d36b77d1fa16d":
      sectionstate["scene"] = level.var_50cdfbe2ce17ca2;
      sectionstate["camera"] = level.var_50cdfbe2ce17ca2.basecam;
      function_47f8406a4c96af32("Loadout_fu");
      break;
    case #"hash_337d33b77d1f9cb4":
      sectionstate["scene"] = level.var_50cdebe2ce17a6f;
      sectionstate["camera"] = level.var_50cdebe2ce17a6f.basecam;
      break;
    case #"hash_4a375d7e61a6c1e7":
      sectionstate["scene"] = level.camera_loadout_showcase_perks;
      sectionstate["camera"] = level.camera_loadout_showcase_perks.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_6e4e92fa76f6812a":
      sectionstate["scene"] = level.var_a8bb61626d7b233c;
      sectionstate["camera"] = level.var_a8bb61626d7b233c.basecam;
      function_47f8406a4c96af32("Loadout_vest");
      break;
    case #"hash_82307786bffffc0e":
      sectionstate["scene"] = level.var_a8bb64626d7b29d5;
      sectionstate["camera"] = level.var_a8bb64626d7b29d5.basecam;
      function_47f8406a4c96af32("Loadout_vest");
      break;
    case #"hash_3461177fb9a87859":
      sectionstate["scene"] = level.var_a8bb63626d7b27a2;
      sectionstate["camera"] = level.var_a8bb63626d7b27a2.basecam;
      function_47f8406a4c96af32("Loadout_boot");
      break;
    case #"hash_fe9236004518ddc7":
      sectionstate["scene"] = level.var_a8bb5e626d7b1ca3;
      sectionstate["camera"] = level.var_a8bb5e626d7b1ca3.basecam;
      function_47f8406a4c96af32("Loadout_helmet");
      break;
    case #"hash_fe9237004518df5a":
      sectionstate["scene"] = level.var_a8bb5d626d7b1a70;
      sectionstate["camera"] = level.var_a8bb5d626d7b1a70.basecam;
      function_47f8406a4c96af32("Loadout_helmet");
      break;
    case #"hash_34a1338952ffad9e":
      sectionstate["scene"] = level.camera_loadout_showcase_x;
      sectionstate["camera"] = level.camera_loadout_showcase_x.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_34a1348952ffaf31":
      sectionstate["scene"] = level.camera_loadout_showcase_y;
      sectionstate["camera"] = level.camera_loadout_showcase_y.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_34a1318952ffaa78":
      sectionstate["scene"] = level.camera_loadout_showcase_z;
      sectionstate["camera"] = level.camera_loadout_showcase_z.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_2b806046ece6c597":
      sectionstate["scene"] = level.camera_loadout_showcase_specialist;
      sectionstate["camera"] = level.camera_loadout_showcase_specialist.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_97f23301828b3019":
      sectionstate["scene"] = level.camera_loadout_showcase_watch;
      sectionstate["camera"] = level.camera_loadout_showcase_watch.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_ca521a71d39e3a33":
      sectionstate["scene"] = level.camera_ui_bg_01;
      sectionstate["camera"] = level.camera_ui_bg_01.basecam;
      function_47f8406a4c96af32("Loadout");
      break;
    case #"hash_8f69629c3ee1c05e":
      var_1c5105e69b7863ca = ter_op(var_acf68bb64d0400f8, level.camera_ui_bg_01, level.active_scene_data);
      sectionstate["scene"] = level.camera_ui_bg_01;
      sectionstate["camera"] = level.camera_ui_bg_01.basecam;
      break;
    case #"hash_2181393f28efb190":
      sectionstate["scene"] = level.camera_ui_bg_01;
      sectionstate["camera"] = level.camera_ui_bg_01.basecam;
      break;
    case #"hash_3359e16158524e7e":
      if(ismgl) {
        sectionstate["scene"] = level.var_8d74a710fdc57c7;
        sectionstate["camera"] = level.var_8d74a710fdc57c7.basecam;
      }

      break;
    default:
      assert(0, "<dev string:x2d4>");
      break;
  }

  return sectionstate;
}

function private create_camera_position_list() {
  ismgl = getdvarint(@ "mgl", 0) > 0;
  level.camera_loadout_showcase = spawnStruct();
  level.camera_loadout_showcase.basecam = function_70a855dd0c75561c("camera_mp_gunsmith");
  level.camera_loadout_showcase.basecam.depthoffieldvalues = [4, 1620];
  level.camera_loadout_showcase.myfov = 80;
  level.camera_loadout_showcase.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase.spotlimit = 8;
  level.camera_loadout_showcase.update_char_loc = &function_64a0f78f8cdff3f;
  level.camera_loadout_showcase_overview = spawnStruct();
  level.camera_loadout_showcase_overview.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_overview");
  level.camera_loadout_showcase_overview.basecam.depthoffieldvalues = [10, 35];
  level.camera_loadout_showcase_overview.myfov = 50;
  level.camera_loadout_showcase_overview.update_char_loc = &function_64a0f78f8cdff3f;
  level.camera_loadout_showcase_overview.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_overview.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_overview.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_overview.spotlimit = 8;
  level.camera_loadout_showcase_preview = spawnStruct();
  level.camera_loadout_showcase_preview.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview");
  level.camera_loadout_showcase_preview.basecam.depthoffieldvalues = [8, 42];
  level.camera_loadout_showcase_preview.myfov = 50;
  level.camera_loadout_showcase_preview.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview.spotlimit = 8;
  level.camera_loadout_showcase_preview_large = spawnStruct();
  level.camera_loadout_showcase_preview_large.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large");
  level.camera_loadout_showcase_preview_large.basecam.depthoffieldvalues = [4, 38];
  level.camera_loadout_showcase_preview_large.myfov = 50;
  level.camera_loadout_showcase_preview_large.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large.spotlimit = 8;
  level.camera_loadout_showcase_preview_small = spawnStruct();
  level.camera_loadout_showcase_preview_small.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_secondary");
  level.camera_loadout_showcase_preview_small.basecam.depthoffieldvalues = [3.5, 28];
  level.camera_loadout_showcase_preview_small.myfov = 50;
  level.camera_loadout_showcase_preview_small.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small.spotlimit = 8;
  level.camera_loadout_showcase_preview_watch = spawnStruct();
  level.camera_loadout_showcase_preview_watch.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_watch");
  level.camera_loadout_showcase_preview_watch.basecam.depthoffieldvalues = [20, 16];
  level.camera_loadout_showcase_preview_watch.myfov = 50;
  level.camera_loadout_showcase_preview_watch.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_watch.spotlimit = 8;
  level.camera_loadout_showcase_armory = spawnStruct();
  level.camera_loadout_showcase_armory.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_armory");
  level.camera_loadout_showcase_armory.basecam.depthoffieldvalues = [7, 67];
  level.camera_loadout_showcase_armory.myfov = 50;
  level.camera_loadout_showcase_armory.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_armory.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_armory.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_armory.spotlimit = 8;
  level.camera_loadout_showcase_p = spawnStruct();
  level.camera_loadout_showcase_p.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_p");
  level.camera_loadout_showcase_p.basecam.depthoffieldvalues = [3, 33];
  level.camera_loadout_showcase_p.myfov = 50;
  level.camera_loadout_showcase_p.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_p.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_p.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_p.spotlimit = 8;
  level.camera_loadout_showcase_p_large = spawnStruct();
  level.camera_loadout_showcase_p_large.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_p_large");
  level.camera_loadout_showcase_p_large.basecam.depthoffieldvalues = [5, 42];
  level.camera_loadout_showcase_p_large.myfov = 50;
  level.camera_loadout_showcase_p_large.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_p_large.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_p_large.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_p_large.spotlimit = 8;
  level.camera_loadout_showcase_s = spawnStruct();
  level.camera_loadout_showcase_s.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_s");
  level.camera_loadout_showcase_s.basecam.depthoffieldvalues = [3.5, 28];
  level.camera_loadout_showcase_s.myfov = 50;
  level.camera_loadout_showcase_s.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_s.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_s.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_s.spotlimit = 8;
  level.camera_loadout_showcase_o = spawnStruct();
  level.camera_loadout_showcase_o.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_o_large");
  level.camera_loadout_showcase_o.basecam.depthoffieldvalues = [3, 33];
  level.camera_loadout_showcase_o.myfov = 50;
  level.camera_loadout_showcase_o.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_o.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_o.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_o.spotlimit = 8;
  level.camera_loadout_showcase_o_large = spawnStruct();
  level.camera_loadout_showcase_o_large.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_o_large");
  level.camera_loadout_showcase_o_large.basecam.depthoffieldvalues = [5, 42];
  level.camera_loadout_showcase_o_large.myfov = 50;
  level.camera_loadout_showcase_o_large.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_o_large.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_o_large.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_o_large.spotlimit = 8;
  level.camera_loadout_showcase_l = spawnStruct();
  level.camera_loadout_showcase_l.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_l");
  level.camera_loadout_showcase_l.basecam.depthoffieldvalues = [4.5, 18];
  level.camera_loadout_showcase_l.myfov = 50;
  level.camera_loadout_showcase_l.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_l.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_l.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_l.spotlimit = 8;
  level.camera_loadout_showcase_t = spawnStruct();
  level.camera_loadout_showcase_t.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_t");
  level.camera_loadout_showcase_t.basecam.depthoffieldvalues = [3, 20.3];
  level.camera_loadout_showcase_t.myfov = 50;
  level.camera_loadout_showcase_t.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_t.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_t.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_t.spotlimit = 8;
  level.var_d693f81e12da320 = spawnStruct();
  level.var_d693f81e12da320.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_field_upgrade");
  level.var_d693f81e12da320.basecam.depthoffieldvalues = [2, 14];
  level.var_d693f81e12da320.myfov = 50;
  level.var_d693f81e12da320.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.var_d693f81e12da320.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.var_d693f81e12da320.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.var_d693f81e12da320.spotlimit = 8;
  level.var_50cdfbe2ce17ca2 = spawnStruct();
  level.var_50cdfbe2ce17ca2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_loadout_field_upgrade_01");
  level.var_50cdfbe2ce17ca2.basecam.depthoffieldvalues = [3, 40.5];
  level.var_50cdfbe2ce17ca2.myfov = 50;
  level.var_50cdfbe2ce17ca2.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.var_50cdfbe2ce17ca2.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.var_50cdfbe2ce17ca2.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.var_50cdfbe2ce17ca2.spotlimit = 8;
  level.var_50cdebe2ce17a6f = spawnStruct();
  level.var_50cdebe2ce17a6f.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_loadout_field_upgrade_02");
  level.var_50cdebe2ce17a6f.basecam.depthoffieldvalues = [6, 35];
  level.var_50cdebe2ce17a6f.myfov = 50;
  level.var_50cdebe2ce17a6f.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.var_50cdebe2ce17a6f.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.var_50cdebe2ce17a6f.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.var_50cdebe2ce17a6f.spotlimit = 8;
  level.camera_loadout_showcase_perks = spawnStruct();
  level.camera_loadout_showcase_perks.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_perks");
  level.camera_loadout_showcase_perks.basecam.depthoffieldvalues = [6, 45];
  level.camera_loadout_showcase_perks.myfov = 50;
  level.camera_loadout_showcase_perks.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_perks.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_perks.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_perks.spotlimit = 8;
  level.camera_loadout_showcase_x = spawnStruct();
  level.camera_loadout_showcase_x.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_x");
  level.camera_loadout_showcase_x.basecam.depthoffieldvalues = [5, 20];
  level.camera_loadout_showcase_x.myfov = 50;
  level.camera_loadout_showcase_x.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_x.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_x.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_x.spotlimit = 8;
  level.camera_loadout_showcase_y = spawnStruct();
  level.camera_loadout_showcase_y.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_y");
  level.camera_loadout_showcase_y.basecam.depthoffieldvalues = [4, 21];
  level.camera_loadout_showcase_y.myfov = 50;
  level.camera_loadout_showcase_y.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_y.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_y.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_y.spotlimit = 8;
  level.camera_loadout_showcase_z = spawnStruct();
  level.camera_loadout_showcase_z.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_z");
  level.camera_loadout_showcase_z.basecam.depthoffieldvalues = [6, 20];
  level.camera_loadout_showcase_z.myfov = 50;
  level.camera_loadout_showcase_z.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_z.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_z.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_z.spotlimit = 8;
  level.camera_loadout_showcase_specialist = spawnStruct();
  level.camera_loadout_showcase_specialist.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_specialist");
  level.camera_loadout_showcase_specialist.basecam.depthoffieldvalues = [22, 16];
  level.camera_loadout_showcase_specialist.myfov = 50;
  level.camera_loadout_showcase_specialist.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_specialist.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_specialist.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_specialist.spotlimit = 8;

  if(getcurrentfrontendfastfilename() == "mp_frontend_jup_01") {
    level.var_a8bb61626d7b233c = spawnStruct();
    level.var_a8bb61626d7b233c.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_perks_vest");
    level.var_a8bb61626d7b233c.basecam.depthoffieldvalues = [3.3, 27];
    level.var_a8bb61626d7b233c.myfov = 50;
    level.var_a8bb61626d7b233c.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
    level.var_a8bb61626d7b233c.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
    level.var_a8bb61626d7b233c.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
    level.var_a8bb61626d7b233c.spotlimit = 8;
    level.var_a8bb64626d7b29d5 = spawnStruct();
    level.var_a8bb64626d7b29d5.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_perks_gloves");
    level.var_a8bb64626d7b29d5.basecam.depthoffieldvalues = [2.5, 16];
    level.var_a8bb64626d7b29d5.myfov = 50;
    level.var_a8bb64626d7b29d5.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
    level.var_a8bb64626d7b29d5.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
    level.var_a8bb64626d7b29d5.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
    level.var_a8bb64626d7b29d5.spotlimit = 8;
    level.var_a8bb63626d7b27a2 = spawnStruct();
    level.var_a8bb63626d7b27a2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_perks_boots");
    level.var_a8bb63626d7b27a2.basecam.depthoffieldvalues = [2.6, 27];
    level.var_a8bb63626d7b27a2.myfov = 50;
    level.var_a8bb63626d7b27a2.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
    level.var_a8bb63626d7b27a2.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
    level.var_a8bb63626d7b27a2.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
    level.var_a8bb63626d7b27a2.spotlimit = 8;
    level.var_a8bb5e626d7b1ca3 = spawnStruct();
    level.var_a8bb5e626d7b1ca3.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_perks_helmet");
    level.var_a8bb5e626d7b1ca3.basecam.depthoffieldvalues = [3, 25];
    level.var_a8bb5e626d7b1ca3.myfov = 50;
    level.var_a8bb5e626d7b1ca3.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
    level.var_a8bb5e626d7b1ca3.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
    level.var_a8bb5e626d7b1ca3.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
    level.var_a8bb5e626d7b1ca3.spotlimit = 8;
    level.var_a8bb5d626d7b1a70 = spawnStruct();
    level.var_a8bb5d626d7b1a70.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_perks_helmet_02");
    level.var_a8bb5d626d7b1a70.basecam.depthoffieldvalues = [3, 25];
    level.var_a8bb5d626d7b1a70.myfov = 50;
    level.var_a8bb5d626d7b1a70.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
    level.var_a8bb5d626d7b1a70.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
    level.var_a8bb5d626d7b1a70.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
    level.var_a8bb5d626d7b1a70.spotlimit = 8;
  }

  level.camera_loadout_showcase_watch = spawnStruct();
  level.camera_loadout_showcase_watch.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_alt_watch");
  level.camera_loadout_showcase_watch.basecam.depthoffieldvalues = [22, 8];
  level.camera_loadout_showcase_watch.myfov = 50;
  level.camera_loadout_showcase_watch.weapon_locs[0] = function_70a855dd0c75561c("weapon_loc_hq1");
  level.camera_loadout_showcase_watch.weapon_locs[1] = function_70a855dd0c75561c("weapon_loc_hq2");
  level.camera_loadout_showcase_watch.weapon_locs[3] = function_70a855dd0c75561c("weapon_loc_watch");
  level.camera_loadout_showcase_watch.spotlimit = 8;
  level.camera_loadout_showcase_preview_riot = spawnStruct();
  level.camera_loadout_showcase_preview_riot.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_riot");
  level.camera_loadout_showcase_preview_riot.basecam.depthoffieldvalues = [16, 152];
  level.camera_loadout_showcase_preview_riot.myfov = 80;
  level.camera_loadout_showcase_preview_riot.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_riot.spotlimit = 8;
  level.var_7cf9581b3a0c8511 = spawnStruct();
  level.var_7cf9581b3a0c8511.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview");
  level.var_7cf9581b3a0c8511.basecam.depthoffieldvalues = [22, 56];
  level.var_7cf9581b3a0c8511.myfov = 80;
  level.var_7cf9581b3a0c8511.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.var_7cf9581b3a0c8511.spotlimit = 8;
  level.var_823394ceaac62e95 = spawnStruct();
  level.var_823394ceaac62e95.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_large");
  level.var_823394ceaac62e95.basecam.depthoffieldvalues = [22, 64];
  level.var_823394ceaac62e95.myfov = 80;
  level.var_823394ceaac62e95.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.var_823394ceaac62e95.spotlimit = 8;
  level.var_a31a266a6008f399 = spawnStruct();
  level.var_a31a266a6008f399.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_secondary");
  level.var_a31a266a6008f399.basecam.depthoffieldvalues = [22, 36];
  level.var_a31a266a6008f399.myfov = 80;
  level.var_a31a266a6008f399.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.var_a31a266a6008f399.spotlimit = 8;
  level.var_a5a822ffa6e52b60 = spawnStruct();
  level.var_a5a822ffa6e52b60.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_riot");
  level.var_a5a822ffa6e52b60.basecam.depthoffieldvalues = [16, 152];
  level.var_a5a822ffa6e52b60.myfov = 80;
  level.var_a5a822ffa6e52b60.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.var_a5a822ffa6e52b60.spotlimit = 8;

  if(!ismgl) {
    level.var_af794e04046d3d0c = spawnStruct();
    level.var_af794e04046d3d0c.basecam = function_70a855dd0c75561c("camera_mp_bundle_preview");
    level.var_af794e04046d3d0c.basecam.depthoffieldvalues = [22, 56];
    level.var_af794e04046d3d0c.myfov = 36;
    level.var_af794e04046d3d0c.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_af794e04046d3d0c.weapon_locs[5] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_af794e04046d3d0c.weapon_locs[6] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_af794e04046d3d0c.spotlimit = 8;
    level.var_ed5abb1b576fe118 = spawnStruct();
    level.var_ed5abb1b576fe118.basecam = function_70a855dd0c75561c("camera_mp_bundle_preview_large");
    level.var_ed5abb1b576fe118.basecam.depthoffieldvalues = [22, 64];
    level.var_ed5abb1b576fe118.myfov = 36;
    level.var_ed5abb1b576fe118.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_ed5abb1b576fe118.weapon_locs[5] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_ed5abb1b576fe118.weapon_locs[6] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_ed5abb1b576fe118.spotlimit = 8;
    level.var_bd4429cf96edc040 = spawnStruct();
    level.var_bd4429cf96edc040.basecam = function_70a855dd0c75561c("camera_mp_bundle_preview_secondary");
    level.var_bd4429cf96edc040.basecam.depthoffieldvalues = [22, 36];
    level.var_bd4429cf96edc040.myfov = 36;
    level.var_bd4429cf96edc040.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_bd4429cf96edc040.weapon_locs[5] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_bd4429cf96edc040.weapon_locs[6] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_bd4429cf96edc040.spotlimit = 8;
    level.var_215ed1c3599cd313 = spawnStruct();
    level.var_215ed1c3599cd313.basecam = function_70a855dd0c75561c("camera_mp_bundle_preview_riot");
    level.var_215ed1c3599cd313.basecam.depthoffieldvalues = [22, 152];
    level.var_215ed1c3599cd313.myfov = 36;
    level.var_215ed1c3599cd313.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_215ed1c3599cd313.weapon_locs[5] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_215ed1c3599cd313.weapon_locs[6] = function_70a855dd0c75561c("weapon_loc_bundle_preview");
    level.var_215ed1c3599cd313.spotlimit = 8;
  } else {
    level.var_c62dad9dd0cac55e = spawnStruct();
    level.var_c62dad9dd0cac55e.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview");
    level.var_c62dad9dd0cac55e.basecam.depthoffieldvalues = [22, 56];
    level.var_c62dad9dd0cac55e.myfov = 36;
    level.var_c62dad9dd0cac55e.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_c62dad9dd0cac55e.spotlimit = 8;
    level.var_b8bf2aaa73b51a2e = spawnStruct();
    level.var_b8bf2aaa73b51a2e.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_large");
    level.var_b8bf2aaa73b51a2e.basecam.depthoffieldvalues = [22, 64];
    level.var_b8bf2aaa73b51a2e.myfov = 36;
    level.var_b8bf2aaa73b51a2e.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_b8bf2aaa73b51a2e.spotlimit = 8;
    level.var_1fc849ffb55cda12 = spawnStruct();
    level.var_1fc849ffb55cda12.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_secondary");
    level.var_1fc849ffb55cda12.basecam.depthoffieldvalues = [22, 36];
    level.var_1fc849ffb55cda12.myfov = 36;
    level.var_1fc849ffb55cda12.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_1fc849ffb55cda12.spotlimit = 8;
    level.var_f6700e1227881ee6 = spawnStruct();
    level.var_f6700e1227881ee6.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview");
    level.var_f6700e1227881ee6.basecam.depthoffieldvalues = [22, 56];
    level.var_f6700e1227881ee6.myfov = 36;
    level.var_f6700e1227881ee6.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_f6700e1227881ee6.spotlimit = 8;
    level.var_6c202b6758ce5a16 = spawnStruct();
    level.var_6c202b6758ce5a16.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_large");
    level.var_6c202b6758ce5a16.basecam.depthoffieldvalues = [22, 64];
    level.var_6c202b6758ce5a16.myfov = 36;
    level.var_6c202b6758ce5a16.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_6c202b6758ce5a16.spotlimit = 8;
    level.var_593d9a9218690ada = spawnStruct();
    level.var_593d9a9218690ada.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_secondary");
    level.var_593d9a9218690ada.basecam.depthoffieldvalues = [22, 36];
    level.var_593d9a9218690ada.myfov = 36;
    level.var_593d9a9218690ada.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_593d9a9218690ada.spotlimit = 8;
    level.var_be74dc099f9c404d = spawnStruct();
    level.var_be74dc099f9c404d.basecam = function_70a855dd0c75561c("camera_mp_weapon_preview_riot");
    level.var_be74dc099f9c404d.basecam.depthoffieldvalues = [22, 64];
    level.var_be74dc099f9c404d.myfov = 36;
    level.var_be74dc099f9c404d.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
    level.var_be74dc099f9c404d.spotlimit = 8;
  }

  level.camera_loadout_showcase_preview_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_barrel.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_barrel");
  level.camera_loadout_showcase_preview_barrel.basecam.depthoffieldvalues = [8, 34];
  level.camera_loadout_showcase_preview_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_barrel.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_barrel.spotlimit = 8;
  level.camera_loadout_showcase_preview_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_barrel_alt1");
  level.camera_loadout_showcase_preview_barrel_alt1.basecam.depthoffieldvalues = [8, 48];
  level.camera_loadout_showcase_preview_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_barrel_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_barrel_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_barrel_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_barrel_alt2");
  level.camera_loadout_showcase_preview_barrel_alt2.basecam.depthoffieldvalues = [8, 54];
  level.camera_loadout_showcase_preview_barrel_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_barrel_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_barrel_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_charm = spawnStruct();
  level.camera_loadout_showcase_preview_charm.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_charm");
  level.camera_loadout_showcase_preview_charm.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm.myfov = 36;
  level.camera_loadout_showcase_preview_charm.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_charm.spotlimit = 8;
  level.camera_loadout_showcase_preview_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_charm_alt1");
  level.camera_loadout_showcase_preview_charm_alt1.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_charm_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_charm_alt2");
  level.camera_loadout_showcase_preview_charm_alt2.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_charm_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_charm_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt3.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_charm_alt3");
  level.camera_loadout_showcase_preview_charm_alt3.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt3.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_charm_alt3.spotlimit = 8;
  level.camera_loadout_showcase_preview_charm_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt4.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_charm_alt4");
  level.camera_loadout_showcase_preview_charm_alt4.basecam.depthoffieldvalues = [21, 18];
  level.camera_loadout_showcase_preview_charm_alt4.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt4.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_charm_alt4.spotlimit = 8;
  level.camera_loadout_showcase_preview_laser = spawnStruct();
  level.camera_loadout_showcase_preview_laser.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_laser");
  level.camera_loadout_showcase_preview_laser.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser.myfov = 36;
  level.camera_loadout_showcase_preview_laser.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_laser.spotlimit = 8;
  level.camera_loadout_showcase_preview_laser_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_laser_alt1");
  level.camera_loadout_showcase_preview_laser_alt1.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_laser_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_laser_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_laser_alt2");
  level.camera_loadout_showcase_preview_laser_alt2.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_laser_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_magazine.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_magazine");
  level.camera_loadout_showcase_preview_magazine.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_magazine.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_magazine.spotlimit = 8;
  level.camera_loadout_showcase_preview_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_magazine_alt1");
  level.camera_loadout_showcase_preview_magazine_alt1.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_magazine_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_magazine_alt2");
  level.camera_loadout_showcase_preview_magazine_alt2.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_magazine_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_muzzle");
  level.camera_loadout_showcase_preview_muzzle.basecam.depthoffieldvalues = [12, 30];
  level.camera_loadout_showcase_preview_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_muzzle.spotlimit = 8;
  level.camera_loadout_showcase_preview_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_muzzle_alt1");
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam.depthoffieldvalues = [18, 32];
  level.camera_loadout_showcase_preview_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_muzzle_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_optic = spawnStruct();
  level.camera_loadout_showcase_preview_optic.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_optic");
  level.camera_loadout_showcase_preview_optic.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic.myfov = 36;
  level.camera_loadout_showcase_preview_optic.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_optic.spotlimit = 8;
  level.camera_loadout_showcase_preview_optic_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_optic_alt1");
  level.camera_loadout_showcase_preview_optic_alt1.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_optic_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_optic_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_reargrip");
  level.camera_loadout_showcase_preview_reargrip.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_reargrip.spotlimit = 8;
  level.camera_loadout_showcase_preview_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_reargrip_alt1");
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_reargrip_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_reargrip_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_reargrip_alt2");
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam.depthoffieldvalues = [12, 22];
  level.camera_loadout_showcase_preview_reargrip_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_reargrip_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_sticker = spawnStruct();
  level.camera_loadout_showcase_preview_sticker.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_sticker");
  level.camera_loadout_showcase_preview_sticker.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_sticker.myfov = 36;
  level.camera_loadout_showcase_preview_sticker.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_sticker.spotlimit = 8;
  level.camera_loadout_showcase_preview_sticker_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_sticker_alt1");
  level.camera_loadout_showcase_preview_sticker_alt1.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_sticker_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_sticker_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_sticker_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_sticker_alt2");
  level.camera_loadout_showcase_preview_sticker_alt2.basecam.depthoffieldvalues = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_sticker_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_sticker_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt3.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_sticker_alt3");
  level.camera_loadout_showcase_preview_sticker_alt3.basecam.depthoffieldvalues = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt3.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_sticker_alt3.spotlimit = 8;
  level.camera_loadout_showcase_preview_sticker_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt4.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_sticker_alt4");
  level.camera_loadout_showcase_preview_sticker_alt4.basecam.depthoffieldvalues = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt4.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt4.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_sticker_alt4.spotlimit = 8;
  level.camera_loadout_showcase_preview_stock = spawnStruct();
  level.camera_loadout_showcase_preview_stock.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_stock");
  level.camera_loadout_showcase_preview_stock.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock.myfov = 36;
  level.camera_loadout_showcase_preview_stock.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_stock.spotlimit = 8;
  level.camera_loadout_showcase_preview_stock_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_stock_alt1");
  level.camera_loadout_showcase_preview_stock_alt1.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_stock_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_stock_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_stock_alt2");
  level.camera_loadout_showcase_preview_stock_alt2.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_stock_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_stock_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_underbarrel");
  level.camera_loadout_showcase_preview_underbarrel.basecam.depthoffieldvalues = [10, 34];
  level.camera_loadout_showcase_preview_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_underbarrel.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_underbarrel.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_small_barrel.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_barrel");
  level.camera_loadout_showcase_preview_small_barrel.basecam.depthoffieldvalues = [12, 22.5];
  level.camera_loadout_showcase_preview_small_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_small_barrel.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_barrel.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_charm = spawnStruct();
  level.camera_loadout_showcase_preview_small_charm.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_charm");
  level.camera_loadout_showcase_preview_small_charm.basecam.depthoffieldvalues = [21, 15];
  level.camera_loadout_showcase_preview_small_charm.myfov = 36;
  level.camera_loadout_showcase_preview_small_charm.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_small_charm.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_laser = spawnStruct();
  level.camera_loadout_showcase_preview_small_laser.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_laser");
  level.camera_loadout_showcase_preview_small_laser.basecam.depthoffieldvalues = [12, 19];
  level.camera_loadout_showcase_preview_small_laser.myfov = 36;
  level.camera_loadout_showcase_preview_small_laser.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_laser.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_magazine");
  level.camera_loadout_showcase_preview_small_magazine.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_magazine.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_magazine_alt1");
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_magazine_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_small_muzzle.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_muzzle");
  level.camera_loadout_showcase_preview_small_muzzle.basecam.depthoffieldvalues = [16, 25];
  level.camera_loadout_showcase_preview_small_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_small_muzzle.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_muzzle.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_optic = spawnStruct();
  level.camera_loadout_showcase_preview_small_optic.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_optic");
  level.camera_loadout_showcase_preview_small_optic.basecam.depthoffieldvalues = [20, 15];
  level.camera_loadout_showcase_preview_small_optic.myfov = 36;
  level.camera_loadout_showcase_preview_small_optic.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_optic.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_small_reargrip.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_reargrip");
  level.camera_loadout_showcase_preview_small_reargrip.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_small_reargrip.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_reargrip.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_sticker = spawnStruct();
  level.camera_loadout_showcase_preview_small_sticker.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_sticker");
  level.camera_loadout_showcase_preview_small_sticker.basecam.depthoffieldvalues = [16, 22];
  level.camera_loadout_showcase_preview_small_sticker.myfov = 36;
  level.camera_loadout_showcase_preview_small_sticker.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_small_sticker.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_stock = spawnStruct();
  level.camera_loadout_showcase_preview_small_stock.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_stock");
  level.camera_loadout_showcase_preview_small_stock.basecam.depthoffieldvalues = [16, 36];
  level.camera_loadout_showcase_preview_small_stock.myfov = 36;
  level.camera_loadout_showcase_preview_small_stock.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_stock.spotlimit = 8;
  level.camera_loadout_showcase_preview_small_trigger = spawnStruct();
  level.camera_loadout_showcase_preview_small_trigger.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_small_trigger");
  level.camera_loadout_showcase_preview_small_trigger.basecam.depthoffieldvalues = [21, 12];
  level.camera_loadout_showcase_preview_small_trigger.myfov = 36;
  level.camera_loadout_showcase_preview_small_trigger.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_small_trigger.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_barrel");
  level.camera_loadout_showcase_preview_large_barrel.basecam.depthoffieldvalues = [12, 46];
  level.camera_loadout_showcase_preview_large_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_barrel.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_charm = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_charm");
  level.camera_loadout_showcase_preview_large_charm.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_charm.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_charm_alt1");
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_charm_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_charm_alt2");
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_charm_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_barrel_alt1");
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam.depthoffieldvalues = [16, 52];
  level.camera_loadout_showcase_preview_large_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_barrel_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_laser = spawnStruct();
  level.camera_loadout_showcase_preview_large_laser.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_laser");
  level.camera_loadout_showcase_preview_large_laser.basecam.depthoffieldvalues = [12, 26];
  level.camera_loadout_showcase_preview_large_laser.myfov = 36;
  level.camera_loadout_showcase_preview_large_laser.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_laser.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_magazine");
  level.camera_loadout_showcase_preview_large_magazine.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_magazine.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_magazine_alt1");
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_magazine_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_magazine_alt2");
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_magazine_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_muzzle");
  level.camera_loadout_showcase_preview_large_muzzle.basecam.depthoffieldvalues = [21, 34];
  level.camera_loadout_showcase_preview_large_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_muzzle.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_muzzle_alt1");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam.depthoffieldvalues = [21, 32];
  level.camera_loadout_showcase_preview_large_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_optic = spawnStruct();
  level.camera_loadout_showcase_preview_large_optic.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_optic");
  level.camera_loadout_showcase_preview_large_optic.basecam.depthoffieldvalues = [21.5, 25];
  level.camera_loadout_showcase_preview_large_optic.myfov = 36;
  level.camera_loadout_showcase_preview_large_optic.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_optic.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_reargrip");
  level.camera_loadout_showcase_preview_large_reargrip.basecam.depthoffieldvalues = [12, 23];
  level.camera_loadout_showcase_preview_large_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_reargrip.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_reargrip_alt1");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam.depthoffieldvalues = [12, 21];
  level.camera_loadout_showcase_preview_large_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_sticker = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_sticker");
  level.camera_loadout_showcase_preview_large_sticker.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_large_sticker.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_sticker.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_sticker_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_sticker_alt1");
  level.camera_loadout_showcase_preview_large_sticker_alt1.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_sticker_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_sticker_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_sticker_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker_alt2.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_sticker_alt2");
  level.camera_loadout_showcase_preview_large_sticker_alt2.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_large_sticker_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker_alt2.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_sticker_alt2.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_sticker_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker_alt3.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_sticker_alt3");
  level.camera_loadout_showcase_preview_large_sticker_alt3.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_sticker_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker_alt3.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_weapon_preview");
  level.camera_loadout_showcase_preview_large_sticker_alt3.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_stock = spawnStruct();
  level.camera_loadout_showcase_preview_large_stock.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_stock");
  level.camera_loadout_showcase_preview_large_stock.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_large_stock.myfov = 36;
  level.camera_loadout_showcase_preview_large_stock.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_stock.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_stock_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_stock_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_stock_alt1");
  level.camera_loadout_showcase_preview_large_stock_alt1.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_large_stock_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_stock_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_stock_alt1.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_underbarrel");
  level.camera_loadout_showcase_preview_large_underbarrel.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_underbarrel.spotlimit = 8;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam = function_70a855dd0c75561c("camera_mp_gunsmith_preview_large_underbarrel_alt1");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam.depthoffieldvalues = [20, 36];
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.weapon_locs[2] = function_70a855dd0c75561c("weapon_loc_preview");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.spotlimit = 8;
  level.camera_character_tango = spawnStruct();
  level.camera_character_tango.basecam = function_70a855dd0c75561c("char_tango");
  level.camera_character_tango.basecam.depthoffieldvalues = [12, 140];
  level.camera_character_tango.myfov = 28;
  level.camera_character_tango.update_char_loc = &update_main_menu_char_loc;
  level.camera_character_tango.spotlimit = 8;
  level.camera_character_faction_select_l = spawnStruct();
  level.camera_character_faction_select_l.basecam = function_70a855dd0c75561c("char_west_b_detail");
  level.camera_character_faction_select_l.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_l.myfov = 37;
  level.camera_character_faction_select_l.update_char_loc = &update_main_menu_char_loc;
  level.camera_character_faction_select_l.spotlimit = 8;
  level.camera_character_faction_select_l_detail = spawnStruct();
  level.camera_character_faction_select_l_detail.basecam = function_70a855dd0c75561c("char_west_b");
  level.camera_character_faction_select_l_detail.basecam.depthoffieldvalues = [18, 100];
  level.camera_character_faction_select_l_detail.myfov = 37;
  level.camera_character_faction_select_l_detail.update_char_loc = &update_main_menu_char_loc;
  level.camera_character_faction_select_l_detail.spotlimit = 8;
  level.camera_character_faction_select_r = spawnStruct();
  level.camera_character_faction_select_r.basecam = function_70a855dd0c75561c("char_east_a_detail");
  level.camera_character_faction_select_r.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_r.myfov = 37;
  level.camera_character_faction_select_r.update_char_loc = &update_main_menu_char_loc;
  level.camera_character_faction_select_r.char_index = 1;
  level.camera_character_faction_select_r.spotlimit = 8;
  level.camera_character_faction_select_r_detail = spawnStruct();
  level.camera_character_faction_select_r_detail.basecam = function_70a855dd0c75561c("char_east_a");
  level.camera_character_faction_select_r_detail.basecam.depthoffieldvalues = [18, 100];
  level.camera_character_faction_select_r_detail.myfov = 37;
  level.camera_character_faction_select_r_detail.update_char_loc = &update_main_menu_char_loc;
  level.camera_character_faction_select_r_detail.char_index = 1;
  level.camera_character_faction_select_r_detail.spotlimit = 8;
  level.camera_character_preview_select = spawnStruct();
  level.camera_character_preview_select.basecam = function_70a855dd0c75561c("char_preview_detail");
  level.camera_character_preview_select.basecam.depthoffieldvalues = [22, 60];
  level.camera_character_preview_select.myfov = 37;
  level.camera_character_preview_select.char_loc = function_70a855dd0c75561c("charroom_char_preview");
  level.camera_character_preview_select.spotlimit = 8;
  level.camera_character_preview_select_detail = spawnStruct();
  level.camera_character_preview_select_detail.basecam = function_70a855dd0c75561c("char_preview");
  level.camera_character_preview_select_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_preview_select_detail.myfov = 37;
  level.camera_character_preview_select_detail.char_loc = function_70a855dd0c75561c("charroom_char_preview");
  level.camera_character_preview_select_detail.spotlimit = 8;
  level.camera_lobby = spawnStruct();
  level.camera_lobby.basecam = function_70a855dd0c75561c("char_lobby");
  level.camera_lobby.basecam.depthoffieldvalues = ter_op(ismgl, [22, 98], [4, 125]);
  level.camera_lobby.myfov = ter_op(ismgl, 37, 36);
  level.camera_lobby.update_char_loc = &update_lobby_char_loc;
  level.camera_lobby.spotlimit = 8;
  level.camera_lobby_detail = spawnStruct();
  level.camera_lobby_detail.basecam = function_70a855dd0c75561c("char_lobby_detail");
  level.camera_lobby_detail.basecam.depthoffieldvalues = [3, 100];
  level.camera_lobby_detail.myfov = 36;
  level.camera_lobby_detail.update_char_loc = &update_lobby_char_loc;
  level.camera_lobby_detail.spotlimit = 8;
  level.var_e679086c223bdfa = spawnStruct();
  level.var_e679086c223bdfa.basecam = function_70a855dd0c75561c("char_lobby_br");
  level.camera_crib_dmz = spawnStruct();
  level.camera_crib_dmz.basecam = function_70a855dd0c75561c("camera_crib_dmz");
  level.camera_crib_dmz.basecam.depthoffieldvalues = [3.5, 225];
  level.camera_crib_dmz.myfov = 36;
  level.camera_crib_dmz.update_char_loc = &function_18d1a39cc5732fb1;
  level.camera_crib_dmz.spotlimit = 6;
  level.camera_crib_dmz_detail = spawnStruct();
  level.camera_crib_dmz_detail.basecam = function_70a855dd0c75561c("camera_crib_dmz_detail");
  level.camera_crib_dmz_detail.basecam.depthoffieldvalues = [3, 100];
  level.camera_crib_dmz_detail.myfov = 36;
  level.camera_crib_dmz_detail.update_char_loc = &function_18d1a39cc5732fb1;
  level.camera_crib_dmz_detail.spotlimit = 6;
  level.camera_social = spawnStruct();
  level.camera_social.basecam = function_70a855dd0c75561c("char_social");
  level.camera_social.basecam.depthoffieldvalues = [2, 150];
  level.camera_social.myfov = 36;
  level.camera_social.update_char_loc = &function_e078e650b9311bae;
  level.camera_social.spotlimit = 6;
  level.var_b4d7482dcafb066a = spawnStruct();
  level.var_b4d7482dcafb066a.basecam = function_70a855dd0c75561c("char_social_wide");
  level.var_b4d7482dcafb066a.basecam.depthoffieldvalues = [3, 325];
  level.var_b4d7482dcafb066a.myfov = 36;
  level.var_b4d7482dcafb066a.update_char_loc = &function_e078e650b9311bae;
  level.var_b4d7482dcafb066a.spotlimit = 6;
  level.var_32d5bc10c9517a5c = spawnStruct();
  level.var_32d5bc10c9517a5c.basecam = function_70a855dd0c75561c("char_social_alt");
  level.var_32d5bc10c9517a5c.basecam.depthoffieldvalues = [3, 150];
  level.var_32d5bc10c9517a5c.myfov = 36;
  level.var_32d5bc10c9517a5c.update_char_loc = &function_e078e650b9311bae;
  level.var_32d5bc10c9517a5c.spotlimit = 6;

  if(!ismgl) {
    level.var_3bfbe3641dfecff0 = spawnStruct();
    level.var_3bfbe3641dfecff0.basecam = function_70a855dd0c75561c("char_social_showcase");
    level.var_3bfbe3641dfecff0.basecam.depthoffieldvalues = [2, 150];
    level.var_3bfbe3641dfecff0.myfov = 36;
    level.var_3bfbe3641dfecff0.update_char_loc = &function_e078e650b9311bae;
    level.var_3bfbe3641dfecff0.spotlimit = 3;
  }

  level.var_c0c7e6be70482b73 = spawnStruct();
  level.var_c0c7e6be70482b73.basecam = function_70a855dd0c75561c("social_showcase_character");
  level.var_c0c7e6be70482b73.basecam.depthoffieldvalues = [10, 100];
  level.var_c0c7e6be70482b73.myfov = 36;
  level.var_c0c7e6be70482b73.update_char_loc = &function_e078e650b9311bae;
  level.var_c0c7e6be70482b73.spotlimit = 8;
  level.var_8302cd976fa0a3 = spawnStruct();
  level.var_8302cd976fa0a3.basecam = function_70a855dd0c75561c("social_showcase_weapon");
  level.var_8302cd976fa0a3.basecam.depthoffieldvalues = [10, 80];
  level.var_8302cd976fa0a3.myfov = 36;
  level.var_8302cd976fa0a3.update_char_loc = &function_e078e650b9311bae;
  level.var_8302cd976fa0a3.spotlimit = 8;
  level.camera_character_tournaments = spawnStruct();
  level.camera_character_tournaments.basecam = function_70a855dd0c75561c("char_tournament_overcam");
  level.camera_character_tournaments.basecam.depthoffieldvalues = [22, 256];
  level.camera_character_tournaments.myfov = 36;
  level.camera_character_tournaments.update_char_loc = &update_arena_char_loc;
  level.var_aeb531c63a3266d6 = spawnStruct();
  level.var_aeb531c63a3266d6.basecam = function_70a855dd0c75561c("cam_firing_range");
  level.var_aeb531c63a3266d6.basecam.depthoffieldvalues = [2, 256];
  level.var_aeb531c63a3266d6.myfov = 65;
  level.var_5215fa2603c0cd47 = spawnStruct();
  level.var_5215fa2603c0cd47.basecam = function_70a855dd0c75561c("cam_bp_character");
  level.var_b76dad29b681c12b = level.var_5215fa2603c0cd47.basecam.origin;
  level.var_9b2e06d9573d88a5 = level.var_5215fa2603c0cd47.basecam.angles;
  level.var_5215fa2603c0cd47.spotlimit = 4;

  if(isDefined(level.var_5215fa2603c0cd47.basecam)) {
    level.var_5215fa2603c0cd47.basecam.depthoffieldvalues = [20, 170];
    level.var_cec4ce34318c0c9a = level.var_5215fa2603c0cd47.basecam.depthoffieldvalues;
    level.var_5215fa2603c0cd47.myfov = 45;
    level.var_5215fa2603c0cd47.char_loc = function_70a855dd0c75561c("bp_character_figurine_01");
  }

  level.var_6c5e13e5cadf25c9 = spawnStruct();
  level.var_6c5e13e5cadf25c9.basecam = function_70a855dd0c75561c("cam_bp_character_detail");
  level.var_6c5e13e5cadf25c9.spotlimit = 4;

  if(isDefined(level.var_6c5e13e5cadf25c9.basecam)) {
    level.var_6c5e13e5cadf25c9.basecam.depthoffieldvalues = [22, 100];
    level.var_6c5e13e5cadf25c9.myfov = 35;
    level.var_6c5e13e5cadf25c9.char_loc = function_70a855dd0c75561c("bp_character_figurine_01");
  }

  level.var_ead7de7f41b832bc = spawnStruct();
  level.var_ead7de7f41b832bc.basecam = function_70a855dd0c75561c("cam_bp_weapon");
  level.var_32991c40f6d4268a = level.var_ead7de7f41b832bc.basecam.origin;
  level.var_37125601a51470c8 = level.var_ead7de7f41b832bc.basecam.angles;
  level.var_ead7de7f41b832bc.spotlimit = 4;

  if(isDefined(level.var_ead7de7f41b832bc.basecam)) {
    level.var_ead7de7f41b832bc.basecam.depthoffieldvalues = [20, 80];
    level.var_cc2bb7c6e61990d5 = level.var_ead7de7f41b832bc.basecam.depthoffieldvalues;
    level.var_ead7de7f41b832bc.myfov = 35;
    level.var_ead7de7f41b832bc.weapon_locs[2] = function_70a855dd0c75561c("bp_weapon_figurine_01");
  }

  level.var_5dc4697427310378 = spawnStruct();
  level.var_5dc4697427310378.basecam = function_70a855dd0c75561c("cam_bp_vehicle");
  level.var_7526bc63841e8e7e = level.var_5dc4697427310378.basecam.origin;
  level.var_5b29f35c02a41e14 = level.var_5dc4697427310378.basecam.angles;
  level.var_5dc4697427310378.spotlimit = 4;

  if(isDefined(level.var_5dc4697427310378.basecam)) {
    level.var_5dc4697427310378.basecam.depthoffieldvalues = [20, 150];
    level.var_7fae4a98502ea9b1 = level.var_5dc4697427310378.basecam.depthoffieldvalues;
    level.var_5dc4697427310378.myfov = 35;
    level.var_5dc4697427310378.char_loc = function_70a855dd0c75561c("bp_vehicle_figurine_01");
  }

  var_fc3a5eace0f99101 = ter_op(ismgl, "cam_bp_vehicle_detail", "cam_bp_items");
  level.var_e671031110af7f94 = spawnStruct();
  level.var_e671031110af7f94.basecam = getEnt(var_fc3a5eace0f99101, "targetname");
  level.var_346a5a00f79c082 = level.var_e671031110af7f94.basecam.origin;
  level.var_38bf9876723f7300 = level.var_e671031110af7f94.basecam.angles;
  level.var_e671031110af7f94.spotlimit = 4;

  if(isDefined(level.var_e671031110af7f94.basecam)) {
    level.var_e671031110af7f94.basecam.depthoffieldvalues = [10, 100];
    level.var_c039481874832d2d = level.var_e671031110af7f94.basecam.depthoffieldvalues;
    level.var_e671031110af7f94.myfov = 45;
    level.var_e671031110af7f94.char_loc = function_70a855dd0c75561c("bp_vehicle_items");
  }

  level.var_61f3469bfd32fc67 = spawnStruct();
  level.var_61f3469bfd32fc67.basecam = function_70a855dd0c75561c("camera_black");
  level.var_61f3469bfd32fc67.basecam.depthoffieldvalues = [2, 256];
  level.var_61f3469bfd32fc67.myfov = 45;
}

function private function_7a7465e3b2f21267() {
  wait 0.25;
  level.lightsall = function_abdba932e247d9c2("lights");
  level.var_ce6333e67d961b48 = [];
  level.lightsloadout = [];
  level.lightscharacter = [];
  level.lightsoperator = [];
  level.var_59ab1197ebb66e32 = [];
  level.var_1ec5eb144158c5b5 = [];
  level.var_2cf1153859b056fd = [];
  level.var_504408371dc54600 = [];
  level.var_d0fc52d62ef83fd8 = [];
  level.var_263ab51c7ff88c1a = [];
  level.var_e15a8396ad2b565e = [];
  level.var_c63b6a758e9619f3 = [];
  level.lightsstore = [];
  level.var_427ed2f4ea09777e = [];
  ismgl = getdvarint(@ "mgl", 0) > 0;

  if(ismgl) {
    level.var_4933154ecf108192 = [];
    level.var_d7f9bd1d525c1c2 = [];
  }

  foreach(light in level.lightsall) {
    if(isDefined(light.script_noteworthy)) {
      tags = strtok(light.script_noteworthy, "+");

      foreach(tag in tags) {
        switch (tag) {
          case #"hash_eef52d343c64d74c":
            level.var_ce6333e67d961b48[level.var_ce6333e67d961b48.size] = light;
            break;
          case #"hash_bb6fa2433bb2f28":
            level.lightsloadout[level.lightsloadout.size] = light;
            break;
          case #"hash_cc702aacc4874235":
            level.lightscharacter[level.lightscharacter.size] = light;
            break;
          case #"hash_a5cb0d7ce465ba6a":
            level.lightsoperator[level.lightsoperator.size] = light;
            break;
          case #"hash_fe7a2594067d3e72":
            if(ismgl) {
              level.var_4933154ecf108192[level.var_4933154ecf108192.size] = light;
            }

            break;
          case #"hash_af6954d0799af042":
            if(ismgl) {
              level.var_d7f9bd1d525c1c2[level.var_d7f9bd1d525c1c2.size] = light;
            }

            break;
          case #"hash_f47accb277c8759e":
            level.var_59ab1197ebb66e32[level.var_59ab1197ebb66e32.size] = light;
            break;
          case #"hash_ee1e4c865aaf58d9":
            level.var_1ec5eb144158c5b5[level.var_1ec5eb144158c5b5.size] = light;
            break;
          case #"hash_a3579f9cf8f38d21":
            level.var_2cf1153859b056fd[level.var_2cf1153859b056fd.size] = light;
            break;
          case #"hash_eaaaccc406742d4":
            level.var_504408371dc54600[level.var_504408371dc54600.size] = light;
            break;
          case #"hash_3bd768aaef471cb9":
            level.var_d0fc52d62ef83fd8[level.var_d0fc52d62ef83fd8.size] = light;
            break;
          case #"hash_8fee3a513769719e":
            level.var_263ab51c7ff88c1a[level.var_263ab51c7ff88c1a.size] = light;
            break;
          case #"hash_6d79cb16a608f8e2":
            level.var_e15a8396ad2b565e[level.var_e15a8396ad2b565e.size] = light;
            break;
          case #"hash_6f16240205e44a3a":
            level.var_c63b6a758e9619f3[level.var_c63b6a758e9619f3.size] = light;
            break;
          case #"hash_123089890ba86a0e":
            level.lightsstore[level.lightsstore.size] = light;
            break;
          case #"hash_bfc3667f5f819e35":
            level.var_427ed2f4ea09777e[level.var_427ed2f4ea09777e.size] = light;
            break;
        }
      }
    }
  }

  level.var_e35b63f3ac08dada = "DUNNO";
  waitframe();

  foreach(light in level.lightsall) {
    light.var_86102e35e838b321 = light getlightintensity();
  }

  function_47f8406a4c96af32("Gunbench");
}

function private setup_initial_entities() {
  ismgl = getdvarint(@ "mgl", 0) > 0;
  level.characters = [];

  for(charindex = 0; charindex < 8; charindex++) {
    charloc = undefined;
    index = charindex + 1;

    if(index < 10) {
      charloc = function_70a855dd0c75561c("lobby_charslot_0" + index);
    } else {
      charloc = function_70a855dd0c75561c("lobby_charslot_" + index);
    }

    level.characters[charindex] = spawn("script_character", charloc.origin, 0, 0, charindex, "MPClientCharacter");
  }

  level.characters[16] = spawn("script_character", level.characters[0].origin, 0, 0, 16, "MPClientCharacter");
  level.characters[16].angles = (0, 270, 0);

  for(var_c433f957a34a5776 = 0; var_c433f957a34a5776 < 6; var_c433f957a34a5776++) {
    index = var_c433f957a34a5776 + 1;
    charindex = 8 + var_c433f957a34a5776;
    charloc = function_70a855dd0c75561c("lobby_charslot_0" + index + "_dog");

    if(isDefined(charloc)) {
      level.characters[charindex] = spawn("script_character", charloc.origin, 0, 0, charindex, "MPClientCharacter");
    }
  }

  charloc = function_70a855dd0c75561c("charroom_char_tango_east");
  level.characters[14] = spawn("script_character", charloc.origin, 0, 0, 14, "MPClientCharacter");
  charloc = function_70a855dd0c75561c("charroom_char_tango_west");
  level.characters[15] = spawn("script_character", charloc.origin, 0, 0, 15, "MPClientCharacter");
  weapon_loc = function_70a855dd0c75561c("weapon_loc_hq1");
  level.weapons = [];
  level.weapons[0] = spawn("script_weapon", weapon_loc.origin, 0, 0, 0);
  level.weapons[0].angles = weapon_loc.angles;
  weapon_loc2 = function_70a855dd0c75561c("weapon_loc_hq2");
  level.weapons[1] = spawn("script_weapon", weapon_loc2.origin, 0, 0, 1);
  level.weapons[1].angles = weapon_loc2.angles;
  preview_weapon_loc = function_70a855dd0c75561c("weapon_loc_preview");
  level.weapons[2] = spawn("script_weapon", preview_weapon_loc.origin, 0, 0, 2);
  level.weapons[2].angles = preview_weapon_loc.angles;
  weapon_watch = function_70a855dd0c75561c("weapon_loc_watch");
  level.weapons[3] = spawn("script_weapon", weapon_watch.origin, 0, 0, 3);
  level.weapons[3].angles = weapon_watch.angles;

  if(ismgl) {
    var_290173c821124083 = getEnt("charroom_char_luckydraw_tango_east", "targetname");
    level.characters[17] = spawn("script_character", var_290173c821124083.origin, 0, 0, 17, "MPClientCharacter");
    var_99b293a026ce42f7 = getEnt("weapon_loc_luckydraw_preview", "targetname");
    level.weapons[4] = spawn("script_weapon", var_99b293a026ce42f7.origin, 0, 0, 4);
    level.weapons[4].angles = var_99b293a026ce42f7.angles;
  }

  var_558454d04c9a7d9 = function_70a855dd0c75561c("weapon_loc_preview");
  level.weapons[5] = spawn("script_weapon", var_558454d04c9a7d9.origin, 0, 0, 5);
  level.weapons[5].angles = var_558454d04c9a7d9.angles;
  var_9bd7e0afb38d3774 = function_70a855dd0c75561c("weapon_loc_preview");
  level.weapons[6] = spawn("script_weapon", var_9bd7e0afb38d3774.origin, 0, 0, 6);
  level.weapons[6].angles = var_9bd7e0afb38d3774.angles;
  level.var_21f36f18171d453d = getEnt("br_cargoplane_exterior", "targetname");
  level.var_b0f545be973a4a13 = getEnt("br_cargoplane_car", "targetname");
  level.var_29dd07d56f00e38d = getEntArray("br_cargoplane", "targetname");

  if(isDefined(level.var_21f36f18171d453d)) {
    if(isDefined(level.var_29dd07d56f00e38d)) {
      foreach(item in level.var_29dd07d56f00e38d) {
        item linkTo(level.var_21f36f18171d453d);
      }
    }

    level.var_21f36f18171d453d.originallocation = level.var_21f36f18171d453d.origin;
    level.var_21f36f18171d453d.originalangles = level.var_21f36f18171d453d.angles;
  }

  if(isDefined(level.var_b0f545be973a4a13)) {
    level.var_b0f545be973a4a13.originallocation = level.var_b0f545be973a4a13.origin;
  }

  if(getcurrentfrontendfastfilename() == "mp_frontend3") {
    thread function_7c7293562fd00957();
  }

  frontend_camera_setup(level.camera_lobby_detail.basecam.origin, level.camera_lobby_detail.basecam.angles);
  thread function_7a7465e3b2f21267();
}

#using_animtree("client_character");

function private function_7c7293562fd00957() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  if(istrue(level.var_9121f71b47a01026)) {
    var_c940010faf0828f0 = getStruct("fe_mil_base_anim_01", "targetname");
    level.vehicles[0] = spawn("script_model", var_c940010faf0828f0.origin);
    level.vehicles[0] setModel("veh9_mil_lnd_jltv_lobby");
    level.vehicles[0].animname = "vehicle";
    level.vehicles[0].var_ac4c2bf73cf75667 = "jltv";
    level.vehicles[0] useanimtree(#animtree);
    level.vehicles[1] = spawn("script_model", var_c940010faf0828f0.origin);
    level.vehicles[1] setModel("veh9_mil_air_heli_medium_lobby");
    level.vehicles[1].animname = "vehicle";
    level.vehicles[1].var_ac4c2bf73cf75667 = "small_bird";
    level.vehicles[1] useanimtree(#animtree);
  }

  if(istrue(level.var_7ee57b7672db9bf5)) {
    var_c940020faf082b23 = getStruct("fe_mil_base_anim_02", "targetname");
    level.vehicles[2] = spawn("script_model", (-7161.34, 3702.8, 117.042));
    level.vehicles[2] setModel("veh9_mil_air_heli_blima_lobby");
    level.vehicles[2].animname = "vehicle";
    level.vehicles[2].var_ac4c2bf73cf75667 = "medium_bird";
    level.vehicles[2] useanimtree(#animtree);
    function_4aaa584c581b532e(level.vehicles[2]);
  }

  if(istrue(level.cargoenabled)) {
    var_c940030faf082d56 = getStruct("fe_mil_base_anim_03", "targetname");
    level.vehicles[3] = spawn("script_model", var_c940030faf082d56.origin);
    level.vehicles[3] setModel("veh9_mil_lnd_cargo_truck_lobby");
    level.vehicles[3].animname = "vehicle";
    level.vehicles[3].var_ac4c2bf73cf75667 = "cargo";
    level.vehicles[3] useanimtree(#animtree);
  }
}

function private function_2898724f8cf4c78e() {
  if(istrue(level.var_9121f71b47a01026)) {
    var_c940010faf0828f0 = getStruct("fe_mil_base_anim_01", "targetname");
    level.vehicles[0].origin = var_c940010faf0828f0.origin;
    level.vehicles[1].origin = var_c940010faf0828f0.origin;
  }

  if(istrue(level.var_7ee57b7672db9bf5)) {
    var_c940020faf082b23 = getStruct("fe_mil_base_anim_02", "targetname");
    level.vehicles[2].origin = (-7161.34, 3702.8, 117.042);
  }

  if(istrue(level.cargoenabled)) {
    var_c940030faf082d56 = getStruct("fe_mil_base_anim_03", "targetname");
    level.vehicles[3].origin = var_c940030faf082d56.origin;
  }
}

function private function_64ca1efa525c0bfa(scenename) {
  if(!isDefined(scenename) || scenename != "squad_lobby" || istrue(level.var_5b62e15f6487baa0)) {
    return;
  }

  level.var_5b62e15f6487baa0 = 1;

  if(istrue(level.var_9121f71b47a01026)) {
    thread function_207d03d11d9a3fb0();
  }

  if(istrue(level.var_7ee57b7672db9bf5)) {
    thread function_43f1a37a8330e1ed();
  }

  if(istrue(level.cargoenabled)) {
    thread cargo_anims();
  }
}

function private function_207d03d11d9a3fb0() {
  level endon("game_ended");
  starttimelow = getdvarint(@ "hash_b453ec118b6f9c37", 30);
  starttimehigh = getdvarint(@ "hash_b476fa118b9602b9", 180);

  while(true) {
    delaytime = randomintrange(starttimelow, starttimehigh);
    wait delaytime;
    vehicle_node = getStruct("fe_mil_base_anim_01", "targetname");
    level.vehicles[0] animScripted("iw9_fe_jltv_enter_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_jltv_enter_01);
    level.vehicles[1] animScripted("iw9_fe_small_bird_enter_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_small_bird_enter_01);
    wait getanimlength(%iw9_fe_jltv_enter_01);
    level.vehicles[0] animScripted("iw9_fe_jltv_loop_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_jltv_loop_01);
    level.vehicles[1] animScripted("iw9_fe_small_bird_loop_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_small_bird_loop_01);
    wait getdvarint(@ "hash_4ba87d948942d27e", 60);
    level.vehicles[0] animScripted("iw9_fe_jltv_exit_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_jltv_exit_01);
    level.vehicles[1] animScripted("iw9_fe_small_bird_exit_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_small_bird_exit_01);
  }
}

function private function_43f1a37a8330e1ed() {
  level endon("game_ended");
  level.vehicles[2] scriptmodelplayanim("iw9_fe_medium_bird_loop_01");
}

function private cargo_anims() {
  level endon("game_ended");
  starttimelow = getdvarint(@ "hash_7469506e01034889", 30);
  starttimehigh = getdvarint(@ "hash_7446426e00dce207", 180);

  while(true) {
    delaytime = randomintrange(starttimelow, starttimehigh);
    wait delaytime;
    vehicle_node = getStruct("fe_mil_base_anim_03", "targetname");
    level.vehicles[3] animScripted("iw9_fe_cargo_truck_enter_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_cargo_truck_enter_01);
    wait getanimlength(%iw9_fe_cargo_truck_enter_01);
    level.vehicles[3] animScripted("iw9_fe_cargo_truck_loop_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_cargo_truck_loop_01);
    wait getdvarint(@ "hash_61e0ef762c4aa27c", 60);
    level.vehicles[3] animScripted("iw9_fe_cargo_truck_exit_01", vehicle_node.origin, vehicle_node.angles, %iw9_fe_cargo_truck_exit_01);
  }
}

function private function_4aaa584c581b532e(blima) {
  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_01")) {
    blima hidepart("TAG_TAIL_ROTOR_BLADE_01");
  }

  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_02")) {
    blima hidepart("TAG_TAIL_ROTOR_BLADE_02");
  }

  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_03")) {
    blima hidepart("TAG_TAIL_ROTOR_BLADE_03");
  }

  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_04")) {
    blima hidepart("TAG_TAIL_ROTOR_BLADE_04");
  }

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_01")) {
    blima hidepart("TAG_MAIN_ROTOR_BLADE_01");
  }

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_02")) {
    blima hidepart("TAG_MAIN_ROTOR_BLADE_02");
  }

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_03")) {
    blima hidepart("TAG_MAIN_ROTOR_BLADE_03");
  }

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_04")) {
    blima hidepart("TAG_MAIN_ROTOR_BLADE_04");
  }
}

function private reset_preview_weapon_loc() {
  weapontransform = function_70a855dd0c75561c("weapon_loc_preview");
  level.weapons[2].origin = weapontransform.origin;
  level.weapons[2].angles = weapontransform.angles;
  level.weapons[5].origin = weapontransform.origin;
  level.weapons[5].angles = weapontransform.angles;
  level.weapons[6].origin = weapontransform.origin;
  level.weapons[6].angles = weapontransform.angles;
}

function private getgunbenchents() {
  level.gunbenchbulletent = function_70a855dd0c75561c("gunbench_bullets");
}

function private devui_bg_swap(bgnumber) {
  foreach(bg in level.ui_bg_images_2d) {
    bg hide();
  }

  if(bgnumber > 0 && bgnumber <= level.ui_bg_images_2d.size) {
    level.ui_bg_images_2d[bgnumber] show();
  }
}

function private function_9617358b4b6d2f49(rewardscriptbundle, basecam, initialvalues) {
  var_421cc4ac3ea9f7bc = rewardscriptbundle.var_421cc4ac3ea9f7bc;
  var_4157bff8abdfdfb5 = rewardscriptbundle.var_4157bff8abdfdfb5;

  if(!isDefined(var_421cc4ac3ea9f7bc)) {
    var_421cc4ac3ea9f7bc = initialvalues[0];
  }

  if(!isDefined(var_4157bff8abdfdfb5)) {
    var_4157bff8abdfdfb5 = initialvalues[1];
  }

  basecam.depthoffieldvalues = [var_421cc4ac3ea9f7bc, var_4157bff8abdfdfb5];
}

function private function_eb177a9f98c3a1b2(rewardscriptbundle, var_d5453091b27b7d5, var_3417ad63b8b9976b, itemtype) {
  if(isDefined(rewardscriptbundle)) {
    level.var_12bf4d83235579c7 = (0, 0, 0);
    level.currentcameraangles = (0, 0, 0);
    cameraxoffset = rewardscriptbundle.cameraxoffset;
    camerayoffset = rewardscriptbundle.camerayoffset;
    camerazoffset = rewardscriptbundle.camerazoffset;
    var_c43193ec5074c3fe = rewardscriptbundle.var_c43193ec5074c3fe;

    if(!isDefined(cameraxoffset)) {
      cameraxoffset = 0;
    }

    if(!isDefined(camerayoffset)) {
      camerayoffset = 0;
    }

    if(!isDefined(camerazoffset)) {
      camerazoffset = 0;
    }

    if(!isDefined(var_c43193ec5074c3fe)) {
      var_c43193ec5074c3fe = 0;
    }

    if(var_d5453091b27b7d5 == 1) {
      level.var_5215fa2603c0cd47.basecam.origin = level.var_b76dad29b681c12b + (cameraxoffset, camerayoffset, camerazoffset);
      level.var_5215fa2603c0cd47.basecam.angles = level.var_9b2e06d9573d88a5 + (var_c43193ec5074c3fe, 0, 0);
      level.currentcamera = function_70a855dd0c75561c("cam_bp_character");
      println("<dev string:x308>" + level.var_5215fa2603c0cd47.basecam.origin);

      if(level.active_section.name == "battle_pass_character") {
        println("<dev string:x334>");
        level.var_3417ad63b8b9976b = 1;
      }

      function_9617358b4b6d2f49(rewardscriptbundle, level.var_5215fa2603c0cd47.basecam, level.var_cec4ce34318c0c9a);

      if(isDefined(itemtype)) {
        if(itemtype == 9) {
          function_47f8406a4c96af32("battlepass_execution");
        } else if(itemtype == 1 || itemtype == 8) {
          function_47f8406a4c96af32("battlepass_character");
        }
      }
    } else if(var_d5453091b27b7d5 == 2) {
      level.var_ead7de7f41b832bc.basecam.origin = level.var_32991c40f6d4268a + (cameraxoffset, camerayoffset, camerazoffset);
      level.var_ead7de7f41b832bc.basecam.angles = level.var_37125601a51470c8 + (var_c43193ec5074c3fe, 0, 0);
      level.currentcamera = function_70a855dd0c75561c("cam_bp_weapon");
      function_9617358b4b6d2f49(rewardscriptbundle, level.var_ead7de7f41b832bc.basecam, level.var_cc2bb7c6e61990d5);
    } else if(var_d5453091b27b7d5 == 3) {
      level.var_5dc4697427310378.basecam.origin = level.var_7526bc63841e8e7e + (cameraxoffset, camerayoffset, camerazoffset);
      level.var_5dc4697427310378.basecam.angles = level.var_5b29f35c02a41e14 + (var_c43193ec5074c3fe, 0, 0);
      level.currentcamera = function_70a855dd0c75561c("cam_bp_vehicle");
      function_9617358b4b6d2f49(rewardscriptbundle, level.var_5dc4697427310378.basecam, level.var_7fae4a98502ea9b1);
    } else if(var_d5453091b27b7d5 == 4) {
      level.var_e671031110af7f94.basecam.origin = level.var_346a5a00f79c082 + (cameraxoffset, camerayoffset, camerazoffset);
      level.var_e671031110af7f94.basecam.angles = level.var_38bf9876723f7300 + (var_c43193ec5074c3fe, 0, 0);
      level.currentcamera = function_70a855dd0c75561c("cam_bp_items");
      function_9617358b4b6d2f49(rewardscriptbundle, level.var_e671031110af7f94.basecam, level.var_c039481874832d2d);
    }

    if(isDefined(var_3417ad63b8b9976b)) {
      level.var_3417ad63b8b9976b = var_3417ad63b8b9976b;
    }

    setomnvar("ui_battlepass_camera_changed", level.var_dc3cdb43df6e6607);
  }
}

function private function_84efd6c7dc93b161(requestedsection, rewardscriptbundle, var_d5453091b27b7d5, var_3417ad63b8b9976b, itemtype) {
  level endon("clear_camera_thread");
  camera_section_change(requestedsection);
  function_eb177a9f98c3a1b2(rewardscriptbundle, var_d5453091b27b7d5, var_3417ad63b8b9976b, itemtype);
  camera_section_change(requestedsection);
}

function private function_b46b25eecee65418(ratio) {
  luckydrawweapon = getEnt("weapon_loc_luckydraw_preview", "targetname");
  var_c84c1a0716e42135 = getEnt("charroom_char_luckydraw_tango_east", "targetname");
  var_60f2d005808c8e6f = getdvarvector(@ "hash_a103e148a8290aa8", (27, -3, -8));
  var_563e72a28568d4d6 = (var_60f2d005808c8e6f[0] * ratio, var_60f2d005808c8e6f[1], var_60f2d005808c8e6f[2]);
  var_aaa42abca3282c63 = getdvarvector(@ "hash_a09ad148a7b61050", (-30, 16, 1));
  weaponoffset = (var_aaa42abca3282c63[0], var_aaa42abca3282c63[1] * ratio - 42, var_aaa42abca3282c63[2]);
  var_4f0997747b01c27e = getdvarvector(@ "hash_17f8c22220c84dc5", (-15, -5, 0));
  var_2a7073711398530f = (var_4f0997747b01c27e[0] * ratio, var_4f0997747b01c27e[1], var_4f0997747b01c27e[2]);
  var_c32f60bafa4d77b6 = getdvarvector(@ "hash_1805b82220d64c4c", (-55, 28, 0));
  var_e951072b761bbf67 = (var_c32f60bafa4d77b6[0], var_c32f60bafa4d77b6[1] * ratio - 85, var_c32f60bafa4d77b6[2]);
  level.var_d45fb3ee26047877["lucky_draw_operator"]["xcam_data"].origin = var_c84c1a0716e42135.origin + var_563e72a28568d4d6;
  level.var_d45fb3ee26047877["lucky_draw_weapon"]["xcam_data"].origin = luckydrawweapon.origin + weaponoffset;
  level.var_d45fb3ee26047877["lucky_draw_weapon_small"]["xcam_data"].origin = luckydrawweapon.origin + var_2a7073711398530f;
  level.var_d45fb3ee26047877["lucky_draw_weapon_large"]["xcam_data"].origin = luckydrawweapon.origin + var_e951072b761bbf67;
}

function private function_6e56f196e5e51ecf(assettype, var_785532f9be9dbaf3, ratio) {
  var_87a4bdf058c8fb34 = var_785532f9be9dbaf3 == "showcase";
  var_63287a4029fdf469 = assettype == "weapon" || assettype == "image";

  if(var_87a4bdf058c8fb34) {
    var_a1564d94086cdcfd = getdvarvector(@ "hash_b7bfea306cd5a616", (40, 90, 0));
    var_f5a72d30219f1cb1 = getdvarvector(@ "hash_6ae2f7e5c3b0519e", (-40, -50, 55));
    return ter_op(var_63287a4029fdf469, var_a1564d94086cdcfd, var_f5a72d30219f1cb1);
  }

  var_3ef1057f2fa09aad = ter_op(var_63287a4029fdf469, 43.75, -36.25);
  var_759228886f048d43 = getdvarvector(@ "hash_e0fce5ff6e0da1b7", (25, 90, 4));
  var_92ae45057d2eb98f = getdvarvector(@ "hash_e11fd5ff6e33c63f", (-15, -50, 55));
  offsets = ter_op(var_63287a4029fdf469, var_759228886f048d43, var_92ae45057d2eb98f);
  var_ffe46d70b4ead339 = (offsets[0] * ratio + var_3ef1057f2fa09aad, offsets[1], offsets[2]);
  return var_ffe46d70b4ead339;
}

function private function_18df3b1e7b2fe74e(assettype, var_785532f9be9dbaf3, ratio) {
  var_63287a4029fdf469 = assettype == "weapon" || assettype == "image";
  vfxorigin = ter_op(var_63287a4029fdf469, level.weapons[4].origin, level.characters[17].origin);
  offsets = function_6e56f196e5e51ecf(assettype, var_785532f9be9dbaf3, ratio);
  return vfxorigin + offsets;
}

function private function_12ec2fd0a3fb6c37() {
  if(isDefined(level.var_ee13e469c1425d3e)) {
    level.var_ee13e469c1425d3e delete();
  }
}

function private function_4416cdf7c3dcd2c5(position, forward, rarity) {
  if(!isDefined(position) || !isDefined(rarity)) {
    return;
  }

  if(isDefined(level.var_ee13e469c1425d3e)) {
    currpos = level.var_ee13e469c1425d3e.origin;
    var_16192a170639ea76 = level.var_ee13e469c1425d3e.rarity;

    if(currpos == position && var_16192a170639ea76 == rarity) {
      return;
    } else {
      function_12ec2fd0a3fb6c37();
    }
  }

  level.var_ee13e469c1425d3e = spawnfx(getfx("lucky_draw_rarity_" + rarity), position, forward);
  level.var_ee13e469c1425d3e.rarity = rarity;
  waitframe();
  triggerfx(level.var_ee13e469c1425d3e);
}

function private function_9e86cc40c0a76cec(weaponclass) {
  switch (weaponclass) {
    case #"hash_34340d457a63e7f1":
    case #"hash_a1f27f97be15d620":
      return "lucky_draw_weapon_small";
    case #"hash_47368bc0d2ef1565":
    case #"hash_8af0086b038622b5":
    case #"hash_ab10f9c080fe4faf":
    case #"hash_dd616da0b395a0b0":
      return "lucky_draw_weapon";
    case #"hash_bef5ec0b3e197ae":
    case #"hash_16cf6289ab06bd30":
    case #"hash_86b11ac21f992552":
    case #"hash_9d18adab1b65a661":
    case #"hash_c095d67337b1f5a1":
      return "lucky_draw_weapon_large";
    default:
      return "lucky_draw_weapon";
  }
}

function private function_25067223e125038c(assettype) {
  switch (assettype) {
    case #"hash_27124c6c97ccffa1":
    case #"hash_b1c3f78f709da9da":
      return "LuckyDrawWeapon";
    case #"hash_8cfcad56b3b4065d":
      return "LuckyDrawOperator";
    default:
      return undefined;
  }
}

function private luinotifylistener() {
  self endon("disconnect");
  getgunbenchents();
  level.currentdropcount = 0;

  while(true) {
    self waittill("luinotifyserver", msg, arg);

    if(isDefined(level._effect["vfx_frontend_store_operator_motes_med"]) && !isDefined(level.var_9ddf81b1164374d1)) {
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (1548.76, 2986.94, -27));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (1518.69, 3474.11, -24));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (1534.24, 3259.83, -25));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (1533.78, 3162.83, -26));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -27));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -24));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -25));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -26));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 2986.94, -27));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 3474.11, -24));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 3259.83, -25));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 3162.83, -26));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 2986.94, -27));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 3474.11, -24));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 3259.83, -25));
      playFX(getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 3162.83, -26));
      level.var_9ddf81b1164374d1 = 1;
    }

    if(msg == "end_current_xcam") {
      end_current_xcam();
      continue;
    }

    if(msg == "loadout_showcase_entered") {
      level.bulletsinitialstate = 1;
      level.currentdropcount = 0;
      level.var_2179aaba15b2d35e.origin = level.var_5af5ef2a9a52f0ca;
      level.var_2179aaba15b2d35e.angles = level.var_96b8921fe92408f1;
      continue;
    }

    if(msg == "primary_weapon_changed") {
      var_ff5d8e52a29d498 = int(arg);

      if(istrue(level.bulletsinitialstate)) {
        level.bulletsinitialstate = 0;
        continue;
      }

      if(level.currentdropcount == 0) {}

      level.currentdropcount++;

      if(level.currentdropcount > 3) {
        level.currentdropcount = 1;
      }

      continue;
    }

    if(msg == "set_ui_rarity_image") {
      var_bda559afc5ba9b52 = int(arg);
      devui_bg_swap(var_bda559afc5ba9b52);
      continue;
    }

    if(msg == "entered_firing_range_after_target_settings") {
      numplates = int(arg);
      thread function_7086103bdf1f2c05(numplates);
      end_current_xcam();
      thread function_ad45f79e3a9b4d2(1);
      continue;
    }

    if(msg == "entered_firing_range_after_pause") {
      end_current_xcam();
      thread function_ad45f79e3a9b4d2(1);
      continue;
    }

    if(msg == "entered_firing_range_pause_menu") {
      thread function_2bef3a70387bed5();
      continue;
    }

    if(msg == "entered_firing_range_from_social") {
      thread function_cb993ebadda105c7();
      thread function_2bef3a70387bed5();
      continue;
    }

    if(msg == "entered_firing_range") {
      end_current_xcam();
      thread function_cb993ebadda105c7();
      continue;
    }

    if(msg == "force_exit_firing_range") {
      thread function_31c28009668de7ec();
      continue;
    }

    if(msg == "switch_loadouts") {
      if(getomnvar("ui_firing_range_has_started") && istrue(self.settospectate)) {
        end_current_xcam();
        thread function_ad45f79e3a9b4d2(0);
      }

      thread function_a0c6c9f9a16b236();
      continue;
    }

    if(msg == "exit_firing_range") {
      thread function_6ddbfa779dce4b5d();
      set_xcam();
      continue;
    }

    if(msg == "restart_xcam_in_firing_range") {
      thread function_a52f1e6528800c39();
      set_xcam();
      continue;
    }

    if(msg == "pre_match_making") {
      thread function_31c28009668de7ec();
      println("<dev string:x34e>");
      flag_clear("started_mm");

      if(!isDefined(level.active_scene_data)) {
        level waittill("finished_scene_change");
      }

      level.currentflagmsg = "pre_match_making";
      continue;
    }

    if(msg == "match_making") {
      println("<dev string:x366>");
      level.var_24e98e32c755aa54 = getpartyinfo().size;

      if(getdvarint(@ "hash_cbd831de958955e3")) {
        level.var_24e98e32c755aa54 = getdvarint(@ "hash_6e71a0ce997a3f8a");
      }

      level.currentflagmsg = "match_making";
      flag_set("started_mm");
      continue;
    }

    if(msg == "lobby_members_changed") {
      if(!istrue(level.overridenumplayers)) {
        level.var_13c94d72bba10b4 = arg;
      }

      level.currentflagmsg = "lobby_member_increase";
      flag_set("lobby_member_increase");
      continue;
    }

    if(msg == "crib_op_intro_anim_rotated") {
      if(arg >> 3) {
        if((arg & 2) == 0) {
          level.characters[14].angles = (0, -153, 0);
        } else {
          level.characters[14].angles = (0, -126, 0);
        }
      } else {
        level.characters[14].angles = (0, -139.143, 0);
        level.var_a5777679e8986406 = arg & 2;
        level.var_d5e742a25a53c1b3 = arg & 1;
        level.var_f750bd5e9c449424 = (arg & 2) >> 1;
      }

      continue;
    }

    if(msg == "crib_op_intro_anim_forward") {
      level.var_a5777679e8986406 = arg & 2;
      level.var_d5e742a25a53c1b3 = arg & 1;
      level.var_f750bd5e9c449424 = (arg & 2) >> 1;
      continue;
    }

    if(msg == "streak_select_trigger") {
      if(arg == 1) {
        function_5aea88c7c01479db("fe_op_crib_xcam_killstreak_01_in_xcam", 0, 0.05, level.xcam_anchor);
      } else {
        function_5aea88c7c01479db("fe_op_crib_xcam_killstreak_01_out_xcam", 0, 0.05, level.xcam_anchor);
      }

      continue;
    }

    if(msg == "operator_store_preview") {
      if(isDefined(level.var_3455211a7fd01921)) {
        level.var_3455211a7fd01921 setModel("bp_diorama_background_simple_s2_v0");
        level.var_3455211a7fd01921.origin = level.var_a41e68b26a527a29;
      }

      var_c052bf187f34990c = function_70a855dd0c75561c("shop_character_01");

      if(arg == "default_vision_set") {
        visionset = "";
      } else {
        visionset = arg;
      }

      level.playerviewowner visionsetnakedforplayer(visionset, 0);
      level.characters[0].angles = var_c052bf187f34990c.angles;
      level.characters[0].origin = var_c052bf187f34990c.origin;
      continue;
    }

    if(msg == "update_operator_crib_vision") {
      if(arg == "default_vision_set") {
        visionset = "";
      } else {
        visionset = arg;
      }

      level.playerviewowner visionsetnakedforplayer(visionset, 0);
      continue;
    }

    if(msg == "update_weapon_store_background") {
      args = strtok(arg, ",");
      xoffset = int(args[0]);
      isprotuned = int(args[1]);
      var_7438b486c4b4b686 = int(args[2]);
      var_7a327f18fd3b7a74 = (4103.15, 3095.33, 2);

      if(isprotuned == 1) {
        if(!isDefined(level.var_7928769f15745242)) {
          level.var_7928769f15745242 = spawnfx(getfx("vfx_frontend_weapon_protune_aura"), var_7a327f18fd3b7a74, (1, 0, 0), (0, -1, 0));
        } else {
          level.var_7928769f15745242 delete();
          level.var_7928769f15745242 = spawnfx(getfx("vfx_frontend_weapon_protune_aura"), var_7a327f18fd3b7a74, (1, 0, 0), (0, -1, 0));
        }

        triggerfx(level.var_7928769f15745242);
      } else if(isDefined(level.var_7928769f15745242)) {
        level.var_7928769f15745242 delete();
      }

      if(var_7438b486c4b4b686 == 1) {}

      level.var_2179aaba15b2d35e setModel("bp_diorama_background_simple_s2_v0");
      level.var_2179aaba15b2d35e.origin = level.var_5af5ef2a9a52f0ca;
      level.var_2179aaba15b2d35e.angles = level.var_96b8921fe92408f1;
      continue;
    }

    if(msg == "update_gunscreen_store_background") {
      level.var_2179aaba15b2d35e setModel("bp_diorama_background_simple_s2_v0");
      level.var_2179aaba15b2d35e.origin = (-3072, 3072, -50);
      level.var_2179aaba15b2d35e.angles = (0, 70, 0);
      continue;
    }

    if(msg == "remove_protuned_weapon_vfx") {
      if(isDefined(level.var_7928769f15745242)) {
        level.var_7928769f15745242 delete();
      }

      continue;
    }

    if(msg == "swap_gun_foam") {
      arg = int(arg);

      if(!isDefined(arg)) {
        return;
      }

      level.foamlarge = function_70a855dd0c75561c("foam_large");
      level.foammedium = function_70a855dd0c75561c("foam_med");
      level.foamsmall = function_70a855dd0c75561c("foam_small");

      if(arg == 3) {
        level.foamlarge show();
        level.foammedium hide();
        level.foamsmall hide();
      } else if(arg == 2) {
        level.foamlarge hide();
        level.foammedium show();
        level.foamsmall hide();
      } else if(arg == 1) {
        level.foamlarge hide();
        level.foammedium hide();
        level.foamsmall show();
      }

      continue;
    }

    if(msg == "battlemap_sector_update") {
      assert(getdvarint(@ "mgl", 0) == 0, "<dev string:x383>");
      level notify("clear_camera_thread");
      args = strtok(arg, "+");
      var_21f8b99332beed7b = args[0];
      var_d5453091b27b7d5 = int(args[1]);
      level.var_dc3cdb43df6e6607 = -1;

      if(isDefined(level.var_3455211a7fd01921)) {
        level.var_3455211a7fd01921.origin += (0, 0, -1000);
      }

      rewardscriptbundle = getscriptbundle(hashcat(%"hash_6e3aa7ae38b4c049", var_21f8b99332beed7b));

      if(isDefined(args[3])) {
        level.var_dc3cdb43df6e6607 = int(args[3]);
      }

      if(isDefined(args[4])) {
        var_3417ad63b8b9976b = args[4] == "1";
      }

      if(isDefined(args[5])) {
        itemtype = int(args[5]);
      }

      if(isDefined(args[2]) && args[2] != "none") {
        requestedsection = spawnStruct();
        requestedsection.name = args[2];
        requestedsection.index = 0;
        level.active_section = requestedsection;
        setomnvar("frontend_weapon_position_updated", 0);
        setomnvar("frontend_screen_black", 0);
        thread function_84efd6c7dc93b161(requestedsection, rewardscriptbundle, var_d5453091b27b7d5, var_3417ad63b8b9976b, itemtype);
      } else {
        thread function_eb177a9f98c3a1b2(rewardscriptbundle, var_d5453091b27b7d5, var_3417ad63b8b9976b, itemtype);
      }

      continue;
    }

    if(msg == "battlemap_sector_update_camera") {
      end_current_xcam();

      if(!isDefined(arg)) {
        return;
      }

      if(!isDefined(level.currentcamera)) {
        return;
      }

      arg = int(arg);

      if(arg == 1) {
        level.var_12bf4d83235579c7 += (1, 0, 0);
      } else if(arg == 2) {
        level.var_12bf4d83235579c7 += (-1, 0, 0);
      } else if(arg == 3) {
        level.var_12bf4d83235579c7 += (0, 1, 0);
      } else if(arg == 4) {
        level.var_12bf4d83235579c7 += (0, -1, 0);
      } else if(arg == 5) {
        level.var_12bf4d83235579c7 += (0, 0, 1);
      } else if(arg == 6) {
        level.var_12bf4d83235579c7 += (0, 0, -1);
      } else if(arg == 7) {
        level.currentcameraangles += (2, 0, 0);
      } else if(arg == 8) {
        level.currentcameraangles += (-2, 0, 0);
      } else if(arg == 9) {
        var_cb2eb4e646daef26 = level.active_camera.depthoffieldvalues[0] + 1;

        if(var_cb2eb4e646daef26 <= 0) {
          var_cb2eb4e646daef26 = 0;
        }

        level.active_camera.depthoffieldvalues[0] = var_cb2eb4e646daef26;
        update_camera_depth_of_field();
      } else if(arg == 10) {
        var_cb2eb4e646daef26 = level.active_camera.depthoffieldvalues[0] - 1;

        if(var_cb2eb4e646daef26 <= 0) {
          var_cb2eb4e646daef26 = 0;
        }

        level.active_camera.depthoffieldvalues[0] = var_cb2eb4e646daef26;
        update_camera_depth_of_field();
      } else if(arg == 11) {
        level.active_camera.depthoffieldvalues[1] += 2;
        update_camera_depth_of_field();
      } else if(arg == 12) {
        level.active_camera.depthoffieldvalues[1] -= 2;
        update_camera_depth_of_field();
      }

      movetoorigin = spawnStruct();
      movetoorigin.origin = level.currentcamera.origin + level.var_12bf4d83235579c7;
      movetoorigin.angles = level.currentcamera.angles + level.currentcameraangles;
      camera_move_helper(movetoorigin, 0, 0, 0, 0, 0);
      continue;
    }

    if(msg == "pass_store_weapon_update") {
      flag_set("force_weapon_update");
      continue;
    }

    if(msg == "remove_lucky_draw_vfx") {
      function_12ec2fd0a3fb6c37();
      continue;
    }

    if(msg == "lucky_draw_update") {
      args = strtok(arg, ",");
      ratio = float(args[3]);

      if(!isDefined(level.var_8d74a710fdc57c7.ratio) || level.var_8d74a710fdc57c7.ratio != ratio) {
        function_b46b25eecee65418(ratio);
        level.var_8d74a710fdc57c7.ratio = ratio;
      }

      assettype = args[0];
      var_785532f9be9dbaf3 = args[1];
      var_87a4bdf058c8fb34 = var_785532f9be9dbaf3 == "showcase";
      var_c868933f909c90a5 = undefined;

      switch (assettype) {
        case #"hash_27124c6c97ccffa1":
          weaponclass = args[4];
          var_c868933f909c90a5 = function_9e86cc40c0a76cec(weaponclass);
          break;
        case #"hash_8cfcad56b3b4065d":
          var_c868933f909c90a5 = "lucky_draw_operator";
          break;
        case #"hash_b1c3f78f709da9da":
          var_c868933f909c90a5 = "lucky_draw_weapon";
          break;
        default:
          function_12ec2fd0a3fb6c37();
          return;
      }

      if(var_87a4bdf058c8fb34) {
        var_c868933f909c90a5 += "_showcase";
      }

      var_a4d8cc0c24a9b127 = level.var_d45fb3ee26047877[var_c868933f909c90a5]["xcam_data"].origin;
      var_d100f8b15ec57c0 = function_18df3b1e7b2fe74e(assettype, var_785532f9be9dbaf3, ratio);
      var_562deeee2d11e498 = vectorNormalize(var_a4d8cc0c24a9b127 - var_d100f8b15ec57c0);
      rarity = args[2];
      xcam_transition(var_c868933f909c90a5);
      function_4416cdf7c3dcd2c5(var_d100f8b15ec57c0, var_562deeee2d11e498, rarity);
      spotlights = function_25067223e125038c(assettype);
      function_47f8406a4c96af32(spotlights);
      continue;
    }

    tagarray = strtok(msg, ",");
    isloadout = tagarray.size > 7;
    var_27af6391b2c24e9b = tagarray[0] == "attach_zoom";
    isweaponpreview = tagarray[0] == "weapon_preview";

    if(var_27af6391b2c24e9b || isweaponpreview) {
      tagstruct = function_aea02750a3aff7bf(tagarray, isweaponpreview, level.active_section.name);
    } else if(isloadout) {
      tagstruct = function_3c8d38b326a9c64f(tagarray);
    } else {
      tagstruct = function_7273f375b5991c19(tagarray, isweaponpreview, level.active_section.name);
    }

    if(!isDefined(tagstruct)) {
      continue;
    }

    if(!isarray(tagstruct)) {
      tagstruct = [tagstruct];
    }

    if(isweaponpreview) {
      foreach(index, struct in tagstruct) {
        if(struct.name == "tag_cosmetic") {
          struct.angles = (10, 190, 30);
        }

        if(struct.name == "tag_sticker" || struct.name == "tag_sticker_shotgun") {
          struct.angles = (10, 190, 42);
        }

        if(function_21fd6d79cf32e1ac(struct.class)) {
          struct.angles = (0, 180, 0);
        }

        level.var_d45fb3ee26047877[struct.name]["transitions"] = [];
        level.var_d45fb3ee26047877[struct.name]["transitions"][0] = struct.xcam;
        level.var_d45fb3ee26047877[struct.name]["xcam_data"] = spawnStruct();
        level.var_d45fb3ee26047877[struct.name]["xcam_data"].origin = struct.origin;
        level.var_d45fb3ee26047877[struct.name]["xcam_data"].angles = struct.angles;
        blendtime = getdvarfloat(@ "hash_4773a268cb735013", 0.2);

        if(distancesquared(struct.origin, (-3072, 3072, 0)) < 10000) {
          level.xcam_anchor.origin = struct.origin;
          level.xcam_anchor.angles = struct.angles;
          function_5aea88c7c01479db(level.var_d45fb3ee26047877[struct.name]["transitions"][0], 0, blendtime, level.xcam_anchor);
        }
      }

      continue;
    }

    if(!var_27af6391b2c24e9b) {
      foreach(index, struct in tagstruct) {
        if(!isloadout) {
          if(struct.name == "tag_origin") {
            struct.name = "j_gun";
            struct.origin = level.active_camera.origin;
          }

          level.var_d45fb3ee26047877[struct.name]["transitions"] = [];
          level.var_d45fb3ee26047877[struct.name]["transitions"][0] = struct.xcam;
          level.var_d45fb3ee26047877[struct.name]["xcam_data"] = spawnStruct();
          level.var_d45fb3ee26047877[struct.name]["xcam_data"].origin = struct.origin;
          level.var_d45fb3ee26047877[struct.name]["xcam_data"].angles = struct.angles;
          level.var_e4d4dcef31a14dde = 1;
          level.xcam_anchor.origin = struct.origin;
          level.xcam_anchor.angles = struct.angles;
          blendtime = getdvarfloat(@ "hash_4773a268cb735013", 0.2);
          function_5aea88c7c01479db(level.var_d45fb3ee26047877[struct.name]["transitions"][0], 0, blendtime, level.xcam_anchor);
          continue;
        }

        if(isDefined(level.var_8d5e9fc8ddef81a2[index]) && struct.xcam != level.var_8d5e9fc8ddef81a2[index]) {
          level.var_d45fb3ee26047877[struct.name]["transitions"][0] = struct.xcam;
          level.var_d45fb3ee26047877[struct.name]["xcam_data"].origin = struct.origin;

          if(index == 1) {
            level.var_d45fb3ee26047877["loadout_showcase_o"]["transitions"][0] = struct.xcam;
            level.var_d45fb3ee26047877["loadout_showcase_o"]["xcam_data"].origin = struct.origin;
          }

          continue;
        }

        if(isDefined(struct.origin) && struct.origin != level.var_d45fb3ee26047877[struct.name]["xcam_data"].origin) {
          level.var_d45fb3ee26047877[struct.name]["xcam_data"].origin = struct.origin;

          if(index == 1) {
            level.var_d45fb3ee26047877["loadout_showcase_o"]["xcam_data"].origin = struct.origin;
          }
        }
      }

      if(isloadout) {
        level.var_8d5e9fc8ddef81a2[0] = tagstruct[0].xcam;
        level.var_8d5e9fc8ddef81a2[1] = tagstruct[1].xcam;
      }

      continue;
    }

    var_ebfc572b07861f57 = function_24ef280c015211c3(tagarray);

    if(var_ebfc572b07861f57 != "receiver") {
      continue;
    }

    if(istrue(level.var_9c1886877f0e84a1)) {
      flag_set("zoom_triggered");
      level.var_ebfc572b07861f57 = var_ebfc572b07861f57;
      continue;
    }

    foreach(struct in tagstruct) {
      level.var_d45fb3ee26047877["loadout_showcase_preview"]["xcam_data"].origin = struct.origin;
      level.var_d45fb3ee26047877["loadout_showcase_preview"]["xcam_data"].angles = struct.angles;
      level.var_d45fb3ee26047877["loadout_showcase_preview_small"]["xcam_data"].origin = struct.origin;
      level.var_d45fb3ee26047877["loadout_showcase_preview_small"]["xcam_data"].angles = struct.angles;
      level.var_d45fb3ee26047877["loadout_showcase_preview_large"]["xcam_data"].origin = struct.origin;
      level.var_d45fb3ee26047877["loadout_showcase_preview_large"]["xcam_data"].angles = struct.angles;
      level.var_9c1886877f0e84a1 = 1;
      flag_set("force_weapon_update");
    }

    level.var_ebfc572b07861f57 = var_ebfc572b07861f57;
    flag_set("zoom_triggered");
  }
}

function private function_80ac3e056bacbfcc(scenename) {
  if(!isDefined(scenename)) {
    return false;
  }

  return isDefined(function_2d4a4197b801ad83(scenename));
}

function private function_4a669b7ad22042ad(scenename) {
  if(!isDefined(scenename)) {
    return 0;
  }

  return issubstr(scenename, "weapon_preview");
}

function private function_f1d45199114730a5() {
  level.var_39e3bfc771325a76 = 0;

  foreach(tag in level.var_e4b914d2cf9018d) {
    if(isDefined(level.var_d45fb3ee26047877) && isDefined(level.var_d45fb3ee26047877[tag])) {
      level.var_d45fb3ee26047877[tag] = undefined;
    }
  }
}

function private loadandplayholoeffect() {
  if(!isDefined(level.holoeffect)) {
    level.holoeffect = loadfx("vfx/iw8_mp/watches/vfx_mp_holo_watch");
    wait 1;
  }

  level.watchfx = spawnfx(level.holoeffect, level.weapons[3].origin);
  level.watchfx.angles = (221, -34.753, 181.997);
  level.watchfx.origin += (1, -0.66, 0.98);
  waitframe();
  triggerfx(level.watchfx);
}

function private updaterotatedebug() {
  while(true) {
    if(getdvarint(@ "hash_97e86d4661a38d", -1) != -1) {
      val = getdvarint(@ "hash_97e86d4661a38d");
      scripts\cp_mp\frontendutils::moveeffect(val);

      setdevdvar(@ "hash_97e86d4661a38d", -1);
    }

    waitframe();
  }
}

function private moveeffect(val) {
  watchx = 0;
  watchy = 0;
  watchz = 0;

  if(val == 1) {
    watchx = 0.1;
  }

  if(val == 2) {
    watchx = -0.1;
  }

  if(val == 3) {
    watchy = 0.1;
  }

  if(val == 4) {
    watchy = -0.1;
  }

  if(val == 5) {
    watchz = 0.1;
  }

  if(val == 6) {
    watchz = -0.1;
  }

  angle = level.watchfx.angles;
  newpos = level.watchfx.origin + (watchx, watchy, watchz);
  level.watchfx delete();
  level.watchfx = spawnfx(level.holoeffect, newpos);
  level.watchfx.angles = angle;
  triggerfx(level.watchfx);
  println(newpos);
}

function private rotateeffect(val) {
  watchx = 0;
  watchy = 0;
  watchz = 0;

  if(val == 1) {
    watchx = 10;
  }

  if(val == 2) {
    watchx = -10;
  }

  if(val == 3) {
    watchy = 10;
  }

  if(val == 4) {
    watchy = -10;
  }

  if(val == 5) {
    watchz = 10;
  }

  if(val == 6) {
    watchz = -10;
  }

  newangles = level.watchfx.angles + (watchx, watchy, watchz);
  level.watchfx delete();
  level.watchfx = spawnfx(level.holoeffect, level.weapons[3].origin + (1, -0.66, 1.1));
  level.watchfx.angles = newangles;
  triggerfx(level.watchfx);
  println(level.watchfx.angles);
}

function private setup_rarity_ui_images() {
  level.ui_bg_images_2d = [];
  level.ui_bg_images_2d[1] = function_70a855dd0c75561c("weapRarity01");
  level.ui_bg_images_2d[2] = function_70a855dd0c75561c("weapRarity02");
  level.ui_bg_images_2d[3] = function_70a855dd0c75561c("weapRarity03");
  level.ui_bg_images_2d[4] = function_70a855dd0c75561c("weapRarity04");
  level.ui_bg_images_2d[5] = function_70a855dd0c75561c("weapRarity05");
  level.raritycamsmall = getStruct("weapRaritySmall", "targetname");
  level.raritycammedium = getStruct("weapRarityMedium", "targetname");
  level.raritycamlarge = getStruct("weapRarityLarge", "targetname");
  level.raritycamwatch = getStruct("weapRarityWatch", "targetname");
  devui_bg_swap(0);
}

function private function_19ed7aafb3fc1018() {
  setdevdvar(@ "hash_902a293944d16b28", 0);
  setdevdvar(@ "hash_47ad1705c52e610", "<dev string:x3d5>");
  setdevdvar(@ "hash_e4612a44320c55af", 0);
  setdevdvar(@ "hash_a2635942d6da077f", 0);

  for(;;) {
    if(getdvarint(@ "hash_e4612a44320c55af") == 1) {
      thread function_fe52bb27c24b4cb9();
    } else if(getdvarint(@ "hash_902a293944d16b28") == 1) {
      thread function_bcf544492688d74a();
    } else if(getDvar(@ "hash_47ad1705c52e610") != "<dev string:x3d5>") {
      thread function_8fd0be95104d80de();
    } else if(getdvarint(@ "hash_a2635942d6da077f") == 1) {
      thread function_5a17bc1576aae0c9();
    }

    wait level.weaponmapdata.size * 0.01;
  }
}

function private function_bcf544492688d74a() {
  adddebugcommand("<dev string:x3d9>" + "<dev string:x3e5>");
  setdevdvar(@ "hash_902a293944d16b28", 0);
}

function private function_8fd0be95104d80de() {
  var_dd01c78957848d22 = getDvar(@ "hash_47ad1705c52e610");

  foreach(weaponref in level.weaponmapdata) {
    if(weaponref.assetname == var_dd01c78957848d22) {
      adddebugcommand("<dev string:x3ee>" + "<dev string:x3ff>" + weaponref.weaponlootid);
    }

    waitframe();
  }

  setdevdvar(@ "hash_47ad1705c52e610", "<dev string:x3d5>");
}

function private function_fe52bb27c24b4cb9() {
  foreach(weaponref in level.weaponmapdata) {
    adddebugcommand("<dev string:x3ee>" + "<dev string:x3ff>" + weaponref.weaponlootid);
    waitframe();
  }

  setdevdvar(@ "hash_e4612a44320c55af", 0);
}

function private function_5a17bc1576aae0c9() {
  adddebugcommand("<dev string:x40c>" + "<dev string:x41d>");
  setdevdvar(@ "hash_a2635942d6da077f", 0);
}

function private function_3f816666273fe6a() {
  while(true) {
    var_8c8a196e7d60fd8 = getdvarint(@ "hash_c64c3bd538ca07a7", 0);

    if(var_8c8a196e7d60fd8 > 0) {
      setdevdvar(@ "hash_c64c3bd538ca07a7", 0);
      level.var_13c94d72bba10b4 = var_8c8a196e7d60fd8;
      level.overridenumplayers = 1;
      level.currentflagmsg = "<dev string:x429>";
      flag_set("<dev string:x429>");
    }

    startmm = getdvarint(@ "hash_14743422cbaa5593", 0);

    if(startmm) {
      setdevdvar(@ "hash_14743422cbaa5593", 0);

      if(!isDefined(level.var_13c94d72bba10b4)) {
        level.var_24e98e32c755aa54 = 1;
      } else {
        level.var_24e98e32c755aa54 = level.var_13c94d72bba10b4;
      }

      level.currentflagmsg = "<dev string:x442>";
      flag_set("<dev string:x452>");
    }

    endxcam = getdvarint(@ "hash_51ac823f87aca451", 0);

    if(endxcam) {
      setdevdvar(@ "hash_51ac823f87aca451", 0);
      end_current_xcam();
    }

    wait 1;
  }
}

# /