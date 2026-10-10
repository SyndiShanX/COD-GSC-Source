/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_387376c964b87290.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_955644017be51149;

function function_c1b99bc04c9cfe4a() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  animatedobjs = getEntArray("manipulate_ent", "script_noteworthy");
  assertex(animatedobjs.size < 200, animatedobjs.size + "<dev string:x1c>");

  foreach(obj in animatedobjs) {
    if(isDefined(obj.script_animation_type)) {
      switch (obj.script_animation_type) {
        case #"hash_7bbd660a0ef1a992":
        case #"hash_dac7d62cc377c033":
          obj thread animsuite_rotation(obj.script_animation_type);
          break;
        case #"hash_2fc0e960a17f77d0":
        case #"hash_cb20eda5e00181ef":
          obj thread animsuite_translation(obj.script_animation_type);
          break;
      }

      continue;
    }

    obj thread animsuite_rotation("rotation_continuous");
  }

  level.animatedobjs = animatedobjs;

  level thread function_d6355f012701ccd5();
}

function gathergroups(objects) {
  groups = [];
  groupssorted = [];

  foreach(obj in objects) {
    if(isDefined(obj.script_noteworthy) && issubstr(obj.script_noteworthy, "group")) {
      groups = array_add(groups, obj);
    }
  }

  foreach(item in groups) {
    if(!isDefined(groupssorted[item.script_noteworthy])) {
      groupssorted[item.script_noteworthy] = [item];
      continue;
    }

    groupssorted[item.script_noteworthy] = array_add(groupssorted[item.script_noteworthy], item);
  }

  foreach(group in groupssorted) {
    parent = animsuite_getparentobject(group);
    animsuite_linkchildrentoparentobject(parent, group);
  }

  return groupssorted;
}

function animsuite_getparentobject(group) {
  foreach(entry in group) {
    if(isDefined(entry.script_linkname)) {
      return entry;
    }
  }
}

function animsuite_linkchildrentoparentobject(parent, group) {
  if(isDefined(parent) && isDefined(group)) {
    foreach(entry in group) {
      if(entry == parent) {
        continue;
      }

      entry linkTo(parent);
    }
  }
}

function animsuite_translation(translation_type) {
  if(issubstr(translation_type, "pingpong")) {
    thread animsuite_translation_pingpong();
  }

  if(issubstr(translation_type, "once")) {
    thread animsuite_translation_once();
  }
}

function animsuite_translation_pingpong() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  var_d62c5724671299ba = (0, 90, 0);
  translationtime = 5;
  pause = 0.5;
  start = undefined;
  stop = undefined;
  loop = undefined;

  if(isDefined(self.script_translation_amount)) {
    var_d62c5724671299ba = self.script_translation_amount;
  }

  if(isDefined(self.script_translation_time)) {
    translationtime = self.script_translation_time;
  }

  if(isDefined(self.script_audio_parameters)) {
    if(issubstr(self.script_audio_parameters, "start")) {
      start = "mp_quarry_lg_crane_start";
    }

    if(issubstr(self.script_audio_parameters, "stop")) {
      stop = "mp_quarry_lg_crane_stop";
    }

    if(issubstr(self.script_audio_parameters, "loop")) {
      loop = "mp_quarry_lg_crane_loop";
    }
  }

  while(true) {
    firstpos = self.origin;
    self moveTo(self.origin + var_d62c5724671299ba, translationtime[0], translationtime[1], translationtime[2]);
    wait translationtime[0] + pause;

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }

    self moveTo(firstpos, translationtime[0], translationtime[1], translationtime[2]);
    wait translationtime[0] + pause;

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }
  }
}

function animsuite_translation_once() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  var_d62c5724671299ba = (0, 90, 0);
  translationtime = 5;

  if(isDefined(self.script_translation_amount)) {
    var_d62c5724671299ba = self.script_translation_amount;
  }

  if(isDefined(self.script_translation_time)) {
    translationtime = length(self.script_translation_time);
  }

  while(true) {
    self rotateby(var_d62c5724671299ba, translationtime, 0, 0);
    wait translationtime;

    if(!isvalidanimsuiteentity("animSuite_Translation_Once()", self)) {
      return;
    }
  }
}

function animsuite_rotation(rotation_type) {
  if(issubstr(rotation_type, "pingpong")) {
    thread animsuite_rotation_pingpong();
  }

  if(issubstr(rotation_type, "continuous")) {
    thread animsuite_rotation_continuous();
  }
}

function animsuite_rotation_pingpong() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  var_88c3a0fd4d89c1f4 = (0, 90, 0);
  rotatetime = (5, 0, 0);
  rotatepause = 0;
  start = undefined;
  stop = undefined;
  loop = undefined;

  if(isDefined(self.script_rotation_amount)) {
    var_88c3a0fd4d89c1f4 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    rotatetime = self.script_rotation_speed;
  }

  while(true) {
    self rotateby(var_88c3a0fd4d89c1f4, rotatetime[0], rotatetime[1], rotatetime[2]);
    wait rotatetime[0] + rotatepause;

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    self rotateby(var_88c3a0fd4d89c1f4 * -1, rotatetime[0], rotatetime[1], rotatetime[2]);
    wait rotatetime[0] + rotatepause;

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }
  }
}

function animsuite_rotation_continuous() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  var_88c3a0fd4d89c1f4 = (0, 90, 0);
  rotatetime = (5, 0, 0);
  rotatepause = 0.5;

  if(isDefined(self.script_rotation_amount)) {
    var_88c3a0fd4d89c1f4 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    rotatetime = self.script_rotation_speed;
  }

  while(true) {
    self rotateby(var_88c3a0fd4d89c1f4, rotatetime[0], rotatetime[1], rotatetime[2]);
    wait rotatetime[0];

    if(!isvalidanimsuiteentity("animSuite_Rotation_Continuous()", self)) {
      return;
    }
  }
}

function isvalidanimsuiteentity(funcname, ent) {
  if(!isDefined(ent)) {
    assertmsg(funcname + "<dev string:x8a>");
    return false;
  }

  return true;
}

function function_d6355f012701ccd5() {
  level endon("game_ended");
  level.var_541f214d076eb549 = undefined;

  while(true) {
    var_3a0baf8f0c5bd7f1 = getdvarint(@ "hash_e9197f745a6b494", 0);

    switch (var_3a0baf8f0c5bd7f1) {
      case 1:
        if(!isDefined(level.var_541f214d076eb549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level.var_541f214d076eb549 = obj;
        }

        level.var_541f214d076eb549 thread animsuite_rotation("continuous");
        break;
      case 2:
        if(!isDefined(level.var_541f214d076eb549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level.var_541f214d076eb549 = obj;
        }

        level.var_541f214d076eb549 thread animsuite_translation("once");
        break;
      case 3:
        if(!isDefined(level.var_541f214d076eb549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level.var_541f214d076eb549 = obj;
        }

        level.var_541f214d076eb549 thread animsuite_rotation("pingpong");
        break;
      case 4:
        if(!isDefined(level.var_541f214d076eb549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level.var_541f214d076eb549 = obj;
        }

        level.var_541f214d076eb549 thread animsuite_translation("pingpong");
        break;
      case 5:
        if(!isDefined(level.animatedobjs[0])) {
          break;
        }

        forward = vectorNormalize(anglesToForward(level.animatedobjs[0].angles));
        level.xcam_anchor.origin = forward * 100 + level.animatedobjs[0].origin;
        level.animatedobjs[0] thread animsuite_rotation("continuous");
        break;
      default:
        break;
    }

    setDvar(@ "hash_e9197f745a6b494", 0);
    waitframe();
  }
}