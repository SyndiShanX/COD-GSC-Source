/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\animation_suite.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#namespace animation_suite;

function animationsuite() {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  animatedobjs = getEntArray("animObj", "targetname");
  assertex(animatedobjs.size < 200, animatedobjs.size + "<dev string:x1c>");
  groups = gathergroups(animatedobjs);
  setupvfxobjs(animatedobjs);
  setupsfxobjs(animatedobjs);

  foreach(obj in animatedobjs) {
    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      obj forcenetfieldhighlod(1);
    }

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
    }
  }
}

function setupvfxobjs(objects) {
  foreach(obj in objects) {
    if(isDefined(obj.script_noteworthy) && string_starts_with(obj.script_noteworthy, "vfx_")) {
      model = obj spawn_tag_origin();
      model show();
      model linkTo(obj);
      assertex(isDefined(level._effect[obj.script_noteworthy]), obj.script_noteworthy + "<dev string:x8a>");
      waitframe();

      if(!isvalidanimsuiteentity("setupVFXObjs(): obj", obj)) {
        continue;
      }

      if(!isvalidanimsuiteentity("setupVFXObjs(): model", model)) {
        continue;
      }

      thread delayfxcall(getfx(obj.script_noteworthy), model, "tag_origin");
    }
  }
}

function delayfxcall(fx, model, tag) {
  wait 5;

  if(!isvalidanimsuiteentity("delayFXCall()", model)) {
    return;
  }

  playFXOnTag(fx, model, tag);
}

function setupsfxobjs(objects) {
  foreach(obj in objects) {
    if(isDefined(obj.script_noteworthy) && string_starts_with(obj.script_noteworthy, "sfx_")) {
      obj setModel("tag_origin");
      obj thread play_loop_sound_on_entity("mp_quarry_lg_crane_loop");
    }
  }
}

function debug_temp_sphere() {
  while(true) {
    drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
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
  level endon("game_ended");
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

    if(isDefined(stop)) {
      thread animsuite_playthreadedsound(translationtime[0], stop);
    }

    wait translationtime[0] + pause;

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }

    if(isDefined(start)) {
      playsoundatpos(self.origin, start);
    }

    self moveTo(firstpos, translationtime[0], translationtime[1], translationtime[2]);

    if(isDefined(stop)) {
      thread animsuite_playthreadedsound(translationtime[0], stop);
    }

    wait translationtime[0] + pause;

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }

    if(isDefined(start)) {
      playsoundatpos(self.origin, start);
    }
  }
}

function animsuite_playthreadedsound(waittime, alias) {
  wait waittime;

  if(!isvalidanimsuiteentity("animSuite_playThreadedSound()", self)) {
    return;
  }

  playsoundatpos(self.origin, alias);
}

function animsuite_translation_once() {
  level endon("game_ended");
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
  level endon("game_ended");
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

    if(isDefined(stop)) {
      thread animsuite_playthreadedsound(rotatetime[0] * 0.9, stop);
    }

    wait rotatetime[0] + rotatepause;

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    if(isDefined(start)) {
      playsoundatpos(self.origin, start);
    }

    self rotateby(var_88c3a0fd4d89c1f4 * -1, rotatetime[0], rotatetime[1], rotatetime[2]);

    if(isDefined(stop)) {
      thread animsuite_playthreadedsound(rotatetime[0] * 0.9, stop);
    }

    wait rotatetime[0] + rotatepause;

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    if(isDefined(start)) {
      playsoundatpos(self.origin, start);
    }
  }
}

function animsuite_rotation_continuous() {
  level endon("game_ended");
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
    assertmsg(funcname + "<dev string:xab>");
    return false;
  }

  return true;
}