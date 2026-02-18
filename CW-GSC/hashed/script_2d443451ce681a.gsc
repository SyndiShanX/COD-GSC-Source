/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2d443451ce681a.gsc
***********************************************/

#using script_4ab78e327b76395f;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\load;
#using scripts\cp_common\util;
#namespace ai;

function function_18c4ff86(var_86318e49, var_a8d22172) {
  if(!isDefined(var_86318e49)) {
    str_team = "all";
  }

  if(!isDefined(var_a8d22172)) {
    var_a8d22172 = "all";
  }

  ateam = getaispeciesarray(var_86318e49, var_a8d22172);
  var_77f25691 = self function_10919848(ateam);
  return var_77f25691;
}

function function_41bdfd53(var_d18721b0) {
  if(!isDefined(var_d18721b0)) {
    assertmsg("<dev string:x38>");
  }

  agroup = spawner::get_ai_group_ai(var_d18721b0);
  var_77f25691 = self function_10919848(agroup);
  return var_77f25691;
}

function function_ac1dee40(var_cd0c8024) {
  if(isDefined(var_cd0c8024)) {
    var_8564fb5f = getaiarray(var_cd0c8024, "targetname");
  } else {
    var_8564fb5f = getaiarray();
  }

  var_77f25691 = self function_10919848(var_8564fb5f);
  return var_77f25691;
}

function private function_10919848(array) {
  var_77f25691 = array();

  foreach(guy in array) {
    if(guy istouching(self) && isalive(guy)) {
      if(!isDefined(var_77f25691)) {
        var_77f25691 = [];
      } else if(!isarray(var_77f25691)) {
        var_77f25691 = array(var_77f25691);
      }

      var_77f25691[var_77f25691.size] = guy;
    }
  }

  return var_77f25691;
}

function function_a45f8c64(var_86318e49 = "all", var_a8d22172 = "all", var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname) {
  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x71>");
  }

  var_8564fb5f = getaispeciesarray(var_86318e49, var_a8d22172);
  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);
  level thread function_8e158d78(var_8564fb5f, var_69747751, var_7b2eb76f);
}

function function_bb79f1ad(var_d18721b0, var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname) {
  if(!isDefined(var_d18721b0)) {
    assertmsg("<dev string:x9e>");
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:xd0>");
  }

  var_8564fb5f = spawner::get_ai_group_ai(var_d18721b0);
  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);
  level thread function_8e158d78(var_8564fb5f, var_69747751, var_7b2eb76f);
}

function function_eb9f3f65(var_d18721b0, var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname, var_216aaeec = 2) {
  if(!isDefined(var_d18721b0)) {
    assertmsg("<dev string:x9e>");
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:xd0>");
  }

  var_8564fb5f = spawner::get_ai_group_ai(var_d18721b0);
  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);

  foreach(e_ai in var_8564fb5f) {
    e_ai thread function_706516d4(var_69747751, var_7b2eb76f, var_216aaeec);
  }
}

function function_706516d4(var_69747751, var_7b2eb76f, var_216aaeec) {
  if(isDefined(var_216aaeec) && var_216aaeec > 0) {
    wait randomfloatrange(1, var_216aaeec);
  }

  if(isalive(self)) {
    self set_goal(var_69747751, "targetname", var_7b2eb76f);
  }
}

function function_d49a69a0(var_cd0c8024, var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname) {
  if(isDefined(var_cd0c8024)) {
    var_8564fb5f = getaiarray(var_cd0c8024, "targetname");
  } else {
    var_8564fb5f = getaiarray();
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:xfe>");
  }

  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);
  level function_8e158d78(var_8564fb5f, var_69747751, var_7b2eb76f);
}

function private function_8e158d78(ai_array, var_69747751, var_7b2eb76f) {
  if(!isDefined(ai_array)) {
    assertmsg("<dev string:x12c>");
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x159>");
  }

  if(!isDefined(var_7b2eb76f)) {
    var_7b2eb76f = 1;
  }

  foreach(e_ai in ai_array) {
    if(isalive(e_ai)) {
      e_ai set_goal(var_69747751, "targetname", var_7b2eb76f);
    }
  }
}

function function_f28ee73(var_86318e49 = "all", var_a8d22172 = "all", var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname, b_shoot) {
  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x183>");
  }

  var_8564fb5f = getaispeciesarray(var_86318e49, var_a8d22172);
  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);
  level thread function_6706a21c(var_8564fb5f, var_69747751, var_7b2eb76f, b_shoot);
}

function function_419b1881(var_d18721b0, var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname, b_shoot) {
  if(!isDefined(var_d18721b0)) {
    assertmsg("<dev string:x1b2>");
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x1e6>");
  }

  var_8564fb5f = spawner::get_ai_group_ai(var_d18721b0);
  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);
  level thread function_6706a21c(var_8564fb5f, var_69747751, var_7b2eb76f, b_shoot);
}

function function_3ff06c1e(var_cd0c8024, var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname, b_shoot) {
  if(isDefined(var_cd0c8024)) {
    var_8564fb5f = getaiarray(var_cd0c8024, "targetname");
  } else {
    var_8564fb5f = getaiarray();
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x216>");
  }

  level thread function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout);
  level thread function_a57f6629(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    level waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(var_8564fb5f);
  level function_6706a21c(var_8564fb5f, var_69747751, var_7b2eb76f, b_shoot);
}

function function_c3314131(var_2795777d, var_82706add = "targetname", var_69747751, var_7b2eb76f, var_89c6f2db, n_timeout, str_flagname, b_shoot) {
  e_goal = spawnStruct();

  if(isDefined(var_2795777d)) {
    a_e_ai = getaiarray(var_2795777d, var_82706add);
  } else {
    a_e_ai = getaiarray();
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x216>");
  }

  function_1eaaceab(a_e_ai);
  e_goal thread function_53f3fb5(a_e_ai, var_89c6f2db, n_timeout);
  e_goal thread function_b7bb4bb5(str_flagname);

  if(isDefined(var_89c6f2db) || isDefined(str_flagname)) {
    e_goal waittill(array("aGuys_kill_count", "aGuys_flag_hit"));
  }

  function_1eaaceab(a_e_ai);
  level thread function_6706a21c(a_e_ai, var_69747751, var_7b2eb76f, b_shoot);
  e_goal struct::delete();
}

function function_6706a21c(ai_array, var_69747751, var_7b2eb76f, b_shoot) {
  if(!isDefined(ai_array)) {
    assertmsg("<dev string:x12c>");
  }

  if(!isDefined(var_69747751)) {
    assertmsg("<dev string:x159>");
  }

  if(!isDefined(var_7b2eb76f)) {
    var_7b2eb76f = 1;
  }

  foreach(e_ai in ai_array) {
    if(isalive(e_ai)) {
      e_ai thread function_33d55665(var_69747751, var_7b2eb76f, b_shoot);
    }
  }
}

function function_33d55665(var_69747751, var_7b2eb76f, b_shoot) {
  goal = self set_goal(var_69747751, "targetname", var_7b2eb76f);
  self force_goal(goal, b_shoot, undefined, 1, 1);
}

function private function_d72eb8b7(var_8564fb5f, var_89c6f2db, n_timeout) {
  if(isDefined(var_89c6f2db) && var_89c6f2db > 0) {
    level waittill_dead(var_8564fb5f, var_89c6f2db, n_timeout);
    self notify(#"aguys_kill_count");
  }
}

function private function_a57f6629(str_flagname) {
  if(isDefined(str_flagname)) {
    if(isarray(str_flagname)) {
      level flag::wait_till_any(str_flagname);
    } else {
      if(!level flag::exists(str_flagname)) {
        return;
      }

      level flag::wait_till_any(array(str_flagname));
    }

    self notify(#"aguys_flag_hit");
  }
}

function private function_53f3fb5(var_8564fb5f, var_89c6f2db, n_timeout) {
  self endon(#"aguys_flag_hit");

  if(isDefined(var_89c6f2db) && var_89c6f2db > 0) {
    level waittill_dead(var_8564fb5f, var_89c6f2db, n_timeout);
    self notify(#"aguys_kill_count");
  }
}

function private function_b7bb4bb5(str_flagname) {
  self endon(#"aguys_kill_count");

  if(isDefined(str_flagname)) {
    if(isarray(str_flagname)) {
      level flag::wait_till_any(str_flagname);
    } else {
      if(!level flag::exists(str_flagname)) {
        return;
      }

      level flag::wait_till_any(array(str_flagname));
    }

    self notify(#"aguys_flag_hit");
  }
}

function function_b0bd06fa(ai_group, n_count, str_flagname) {
  if(!level flag::exists(str_flagname)) {
    return;
  }

  spawner::waittill_ai_group_ai_count(ai_group, n_count);
  level flag::set(str_flagname);
}

function array_spawn(str_targetname) {
  var_523ed269 = getspawnerarray(str_targetname, "targetname");
  aiarray = array();

  foreach(spawner in var_523ed269) {
    guy = spawner spawnfromspawner(str_targetname, 1);

    if(!isDefined(aiarray)) {
      aiarray = [];
    } else if(!isarray(aiarray)) {
      aiarray = array(aiarray);
    }

    aiarray[aiarray.size] = guy;
  }

  return aiarray;
}

function set_corpse_entity(prompt_tag) {
  assert(isentity(self));
  level.additional_corpse[self getentitynumber()] = self;
  self thread namespace_5f6e61d9::function_c74e98cb(1, prompt_tag);
}

function function_4f84c3ed(origin, radius) {
  result = [];

  if(!isDefined(radius)) {
    radius = 0;
  }

  radiussq = sqr(radius);

  if(isDefined(origin)) {
    result = getcorpsearray(origin, radius);
  } else {
    result = getcorpsearray();
  }

  if(isDefined(level.additional_corpse)) {
    foreach(ent in level.additional_corpse) {
      if(isDefined(ent) && (!isDefined(origin) || distancesquared(ent.origin, origin) < radiussq)) {
        result[result.size] = ent;
      }
    }
  }

  return result;
}

function custom_locomotion(var_c62e2503, var_d9530aee, goal, stop_notify) {
  assert(issentient(self));
  assert(!isPlayer(self));
  self notify(#"custom_locomotion");

  if(!isDefined(var_c62e2503)) {
    var_c62e2503 = [];
  } else if(!isarray(var_c62e2503)) {
    var_c62e2503 = array(var_c62e2503);
  }

  if(!isDefined(var_d9530aee)) {
    var_d9530aee = [];
  } else if(!isarray(var_d9530aee)) {
    var_d9530aee = array(var_d9530aee);
  }

  self.custom_locomotion = spawnStruct();
  self.custom_locomotion.move = var_c62e2503;
  self.custom_locomotion.idle = var_d9530aee;
  self.custom_locomotion.goal = goal;
  self.custom_locomotion.face_angle = self.angles[1];
  self.custom_locomotion.stop_notify = stop_notify;

  if(!isDefined(self.custom_locomotion.goal)) {
    self.custom_locomotion.goal = self.origin;
  } else if(!isvec(self.custom_locomotion.goal)) {
    self.custom_locomotion.goal = self.custom_locomotion.goal.origin;
  }

  self.custom_locomotion.path = generatenavmeshpath(self.origin, self.custom_locomotion.goal, self);

  if(!isDefined(self.custom_locomotion.path)) {
    self.custom_locomotion.path = generatenavmeshpath(self.origin, self.origin, self);
  }

  self.custom_locomotion.path.index = 0;
  self animcustom(&function_66d43d96, &function_6e4a9c24);
}

function private function_66d43d96() {
  assert(isDefined(self.custom_locomotion));
  self endon(#"death", #"killanimscript", #"custom_locomotion", self.custom_locomotion.stop_notify);
  var_cd6d7e01 = undefined;
  var_bee8f197 = float(function_60d95f53()) / 1000;
  lastangle = undefined;
  self animmode("gravity");

  while(true) {
    while(self.custom_locomotion.path.pathpoints.size > self.custom_locomotion.path.index) {
      point2d = self.custom_locomotion.path.pathpoints[self.custom_locomotion.path.index];
      point2d = (point2d[0], point2d[1], self.origin[2]);

      if(distancesquared(point2d, self.origin) < sqr(16)) {
        self.custom_locomotion.path.index += 1;
        continue;
      }

      break;
    }

    self.custom_locomotion.moving = self.custom_locomotion.path.pathpoints.size > self.custom_locomotion.path.index;

    if(self.custom_locomotion.moving) {
      point2d = self.custom_locomotion.path.pathpoints[self.custom_locomotion.path.index];
      point2d = (point2d[0], point2d[1], self.origin[2]);
      delta = vectornormalize(point2d - self.origin);
      self.custom_locomotion.face_angle = vectortoyaw(delta);
    }

    if(lastangle !== self.custom_locomotion.face_angle) {
      self orientmode("face angle", self.custom_locomotion.face_angle);
      lastangle = self.custom_locomotion.face_angle;
    }

    if(self.custom_locomotion.moving !== var_cd6d7e01) {
      if(self.custom_locomotion.moving) {
        self childthread function_f3a8861e(self.custom_locomotion.move, 1);
        var_bee8f197 = float(function_60d95f53()) / 1000;
      } else {
        self childthread function_f3a8861e(self.custom_locomotion.idle, 1);
        self notify(#"custom_goal");
        var_bee8f197 = 1;
      }

      var_cd6d7e01 = self.custom_locomotion.moving;
    }

    wait var_bee8f197;
  }
}

function private function_f3a8861e(anims, loop, mode = "custom") {
  self notify("15ea8c5841d3bd17");
  self endon("15ea8c5841d3bd17");

  while(anims.size > 0) {
    animation = array::random(anims);
    self animscripted(animation, self.origin, self.angles, animation, mode, undefined, 1, 0.2);
    wait getanimlength(animation);

    if(!is_true(loop)) {
      return;
    }
  }
}

function private function_6e4a9c24() {
  if(!isalive(self)) {
    self startragdoll();
  }

  self.custom_locomotion = undefined;
}