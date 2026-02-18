/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\smart_object.gsc
***********************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace smart_object;

function private autoexec __init__system__() {
  system::register(#"smart_object", &preinit, undefined, undefined, #"scene");
}

function private preinit() {
  function_b3ec7529();

  util::init_dvar("<dev string:x38>", 0, &function_5bfb6b3);
  level thread function_ed7733c7();
}

function private function_b3ec7529() {
  level.smartobjectpoints = [];

  level.var_49430738 = [];

  smartobjectpoints = struct::get_array("smart_object", "variantname");

  foreach(obj in smartobjectpoints) {
    obj.nextusetime = undefined;
    obj.var_fbb20a79 = undefined;
    obj.hasdeath = undefined;
    obj.scene_reach = undefined;

    obj.var_175b0e60 = undefined;

    obj.shots = [];

    if(!function_b69b2de4(obj)) {
      level.var_49430738[level.var_49430738.size] = obj;

      obj.var_fbb20a79 = 1;
      continue;
    }

    linked_structs = obj util::get_linked_structs();

    foreach(linkedstruct in linked_structs) {
      if(linkedstruct == obj) {
        continue;
      }

      if(!function_b69b2de4(linkedstruct)) {
        continue;
      }

      if(!isDefined(obj.linkedsmartobjects)) {
        obj.linkedsmartobjects = [];
      }

      obj.linkedsmartobjects[obj.linkedsmartobjects.size] = linkedstruct;
    }

    if(is_true(obj.script_auto_use)) {
      if(!isDefined(obj.var_7087ad5d)) {
        obj.var_7087ad5d = 0;
      }

      obj.var_2edb5d76 = sqr(obj.var_7087ad5d);
    } else {
      obj.script_auto_use = undefined;
      obj.var_7087ad5d = undefined;
      obj.var_2edb5d76 = undefined;
    }

    if(!isDefined(obj.var_dd0284ce)) {
      obj.var_dd0284ce = "patrol";
    }

    if(!isDefined(obj.var_a15f12c2)) {
      obj.var_a15f12c2 = 0;
    }

    obj thread scene::init();
    obj thread function_6e730e66();
    level.smartobjectpoints[level.smartobjectpoints.size] = obj;
  }
}

function private function_6e730e66() {
  self.shots = scene::get_all_shot_names(self.scriptbundlename);
  self.var_db740c43 = [];

  if(!isDefined(self.goalradius)) {
    self.goalradius = 16;
  }

  foreach(shotname in self.shots) {
    if(issubstr(tolower(shotname), "intro")) {
      intro = self function_3b013edc(shotname);

      if(isDefined(intro.origin)) {
        self.var_db740c43[self.var_db740c43.size] = intro;
        self.goalradius = max(self.goalradius, distance(self.origin, intro.origin) + 60);
        continue;
      }

      if(!isDefined(self.var_175b0e60)) {
        self.var_175b0e60 = [];
      }

      self.var_175b0e60[self.var_175b0e60.size] = intro;
    }
  }

  self.hasdeath = function_5ff18583(self.shots, "death");

  if(self.var_db740c43.size == 0 && array::contains(self.shots, "main")) {
    intro = self function_3b013edc("main");

    if(isDefined(intro.origin)) {
      self.var_db740c43[self.var_db740c43.size] = intro;
      self.goalradius = max(self.goalradius, distance(self.origin, intro.origin));
      return;
    }

    if(!isDefined(self.var_175b0e60)) {
      self.var_175b0e60 = [];
    }

    self.var_175b0e60[self.var_175b0e60.size] = intro;
  }
}

function private function_3b013edc(shotname) {
  intro = {};
  reach = self scene::function_15be7db9(self.scriptbundlename, shotname);

  if(isDefined(reach)) {
    intro.origin = reach.origin;
    intro.angles = reach.angles;

    intro.var_93d6832 = reach.var_93d6832;
  } else {
    intro.origin = self.origin;
    intro.angles = self.angles;
  }

  intro.shot = shotname;
  return intro;
}

function private function_27844fc(debounce) {
  assert(function_1631909f(self));

  if(!isDefined(self.var_715fc83d)) {
    self.var_715fc83d = -1;
  }

  self.nextusetime = isDefined(debounce) ? debounce : self.var_715fc83d;

  if(self.nextusetime > 0) {
    self.nextusetime = gettime() + self.nextusetime * 1000;
  }

  if(isDefined(self.linkedsmartobjects)) {
    foreach(obj in self.linkedsmartobjects) {
      if(isDefined(obj.nextusetime)) {
        obj.nextusetime = max(obj.nextusetime, self.nextusetime);
        continue;
      }

      obj.nextusetime = self.nextusetime;
    }
  }
}

function private function_5ff18583(shots, substr) {
  foreach(shotname in shots) {
    if(issubstr(tolower(shotname), substr)) {
      return true;
    }
  }

  return false;
}

function play(ai) {
  assert(function_1631909f(self));
  self thread function_5e77c231(ai);
  self waittill(#"hash_3a2c70ba8c45838e");
}

function function_5e77c231(ai) {
  ai notify(#"hash_274402e2db748171");

  if(!is_true(self.hasdeath)) {
    ai endoncallback(&function_8ffc948d, #"death");
  } else {
    ai val::set(#"smart_object", "skip_death", 1);
    ai val::set(#"smart_object", "skip_scene_death", 1);
  }

  ai endoncallback(&function_8ffc948d, #"hash_274402e2db748171", #"entitydeleted", #"in_action");
  self endoncallback(&function_8ffc948d, #"hash_274402e2db748171");
  self.script_play_multiple = 1;
  ai.var_c48f9f7d = 1;
  ai claim(self);
  self function_27844fc(-1);
  self.var_135bd649 = 1;
  var_ee9cbc26 = {};
  intro = undefined;

  if(self.var_db740c43.size > 0) {
    intro = self.var_db740c43[0];

    if(self.var_db740c43.size > 1) {
      var_36b33936 = arraysortclosest(arraycopy(self.var_db740c43), ai.origin, 1);
      intro = var_36b33936[0];
    }
  }

  if(!is_true(self.var_6491f35f) && isDefined(intro) && distancesquared(intro.origin, ai.origin) > sqr(4 + 1)) {
    self thread function_b150ae10(ai);
    self scene::anim_reach(self.scriptbundlename, intro.shot, ai);
    self notify(#"hash_5c09ebcc2e6a88a3");
  }

  self thread function_8b855873(self.shots, ai, var_ee9cbc26);

  if(isDefined(intro)) {
    ai thread function_6ab41bf7(intro.shot);

    self scene::play(self.scriptbundlename, intro.shot, ai);
  }

  if(array::contains(self.shots, "main") && (!isDefined(intro) || intro.shot != "main")) {
    ai thread function_6ab41bf7("<dev string:x4e>");

    self scene::play(self.scriptbundlename, "main", ai);
  }

  var_e0134196 = undefined;

  if(array::contains(self.shots, "outro")) {
    var_e0134196 = 1;
    var_ee9cbc26.var_fd84bab2 = 1;

    ai thread function_6ab41bf7("<dev string:x56>");

    self scene::play(self.scriptbundlename, "outro", ai);
  }

  self function_8ffc948d("smart_object_ending_normally");
  waitframe(2);
}

function private function_b150ae10(ai) {
  ai notify("18b9e447fd3c42ee");
  ai endon("18b9e447fd3c42ee");
  self endon(#"hash_5c09ebcc2e6a88a3");
  ai waittill(#"alert", #"death", #"damage", #"in_action");
  ai notify(#"hash_274402e2db748171");
}

function function_8ffc948d(var_4bb4b841) {
  smart_object = self.smart_object;

  if(!isDefined(smart_object) && isstruct(self)) {
    smart_object = self;
  }

  if(isDefined(smart_object)) {
    smart_object.var_135bd649 = undefined;

    if(isstring(var_4bb4b841)) {
      smart_object notify(var_4bb4b841);
    }

    if(isDefined(smart_object.claimer)) {
      if(issentient(smart_object.claimer)) {
        smart_object.claimer setgoal(smart_object.claimer.origin, undefined, undefined, undefined, smart_object.claimer.angles);
      }

      smart_object.claimer thread function_6ab41bf7(undefined);

      smart_object.claimer function_a59dc8a8(smart_object);
    }

    smart_object notify(#"hash_3a2c70ba8c45838e");
  }
}

function private function_8b855873(&shots, ai, var_ee9cbc26) {
  ai notify("559ca15ca3e188b8");
  ai endon("559ca15ca3e188b8");
  self endon(#"smart_object_ending_normally", #"hash_334d02928f88cfaa");
  ai endon(#"entitydeleted", #"in_action");
  ai.var_a965704f = undefined;

  while(true) {
    result = ai waittill(#"alert", #"death", #"damage");
    self childthread function_ca2d3925(shots, ai, var_ee9cbc26, result);
  }
}

function private function_ca2d3925(&shots, ai, var_ee9cbc26, result) {
  self notify("825d390354ad4af");
  self endon("825d390354ad4af");

  if(isalive(ai) || result._notify === "death") {
    var_68a5d6c0 = "react";
    isdeath = 0;

    if(isalive(ai) && result._notify !== "death") {
      if(isDefined(result.weapon) && result.weapon.weapclass == "grenade" && result.mod == "MOD_IMPACT") {
        return;
      }

      waitframe(1);

      if(isalive(ai)) {
        reactyaw = ai aiutility::bb_actorgetreactyaw();
      }
    }

    if(result._notify === "death" || !isalive(ai)) {
      var_68a5d6c0 = "death";
      isdeath = 1;
    }

    react = function_2e6e8631(shots, var_68a5d6c0, reactyaw);
    var_fd84bab2 = !isDefined(react) || is_true(var_ee9cbc26.var_fd84bab2);

    if(isDefined(ai)) {
      if((result._notify == # "damage" || result._notify == # "death") && (var_fd84bab2 || isDefined(ai.var_a965704f))) {
        ai scene::stop(self.scriptbundlename);
        ai util::stop_magic_bullet_shield();
        ai.var_4a438c2b = 0;
        ai kill(result.position, result.attacker, result.inflictor, result.weapon);
        ai startragdoll();
        ai function_a59dc8a8(self);

        if(isPlayer(result.attacker)) {
          result.attacker damagefeedback::update(result.mod, result.inflictor, undefined, result.weapon, ai);
        }

        self notify(#"hash_334d02928f88cfaa");
        return;
      }

      if(!isDefined(ai.var_a965704f) && isDefined(react) && react !== ai.var_a965704f) {
        ai.var_a965704f = react;
        self thread function_1ec70779(react, ai, isdeath);

        if(is_true(isdeath)) {
          if(isPlayer(result.attacker)) {
            result.attacker damagefeedback::update(result.mod, result.inflictor, undefined, result.weapon, ai);
          }

          self notify(#"hash_334d02928f88cfaa");
        }
      }
    }
  }
}

function private function_1ec70779(react, ai, isdeath = 0) {
  ai.var_29133295 = 1;
  var_f69c35a3 = isDefined(ai.stealth.ai_event) && ai.stealth.ai_event == "combat" && ai flashlight::function_47df32b8();
  ai notify(#"hash_274402e2db748171");

  if(isDefined(react)) {
    ai thread function_6ab41bf7(react);

    if(isdeath) {
      ai.ignorealivecheck = 1;
      ai.skipdeath = 1;
    }

    if(var_f69c35a3) {
      ai flashlight::light_off();
    }

    self scene::play(self.scriptbundlename, react, ai);

    if(isdeath && isDefined(level.var_3ba48663) && isDefined(ai)) {
      ai[[level.var_3ba48663]]();
    }

    if(isDefined(ai.stealth)) {
      ai.stealth.var_5cc4aa60 = gettime() + 3000;
    }

    if(var_f69c35a3) {
      ai flashlight::function_bfffb3fe();
    }
  } else {
    self scene::stop(self.scriptbundlename);
  }

  if(isDefined(ai)) {
    ai val::reset_all(#"smart_object");

    ai thread function_6ab41bf7();
  }
}

function private function_2e6e8631(&shots, var_68a5d6c0, yaw) {
  result = undefined;

  if(array::contains(shots, var_68a5d6c0)) {
    result = var_68a5d6c0;
  }

  var_c209edb = function_92be8cbf(yaw);

  foreach(var_a06ab73 in var_c209edb) {
    var_33ae3ae9 = var_68a5d6c0 + var_a06ab73;

    if(array::contains(shots, var_33ae3ae9)) {
      result = var_33ae3ae9;
      break;
    }
  }

  return result;
}

function claim(obj) {
  assert(issentient(self));
  assert(!isDefined(obj.claimer) || obj.claimer == self, "<dev string:x5f>");
  obj.claimer = self;
  self.smart_object = obj;
}

function function_a59dc8a8(obj) {
  if(!isDefined(obj)) {
    return;
  }

  assert(!isDefined(obj.claimer) || obj.claimer == self, "<dev string:x8f>");

  if(isDefined(obj.claimer)) {
    if(!is_true(obj.claimer.var_29133295)) {
      obj.claimer val::reset_all(#"smart_object");
    }

    obj.claimer.var_29133295 = undefined;
  }

  obj.claimer = undefined;
  obj function_27844fc();
  self.smart_object = undefined;
  self.var_c48f9f7d = undefined;
}

function can_claim(obj) {
  if(!isDefined(obj)) {
    return false;
  }

  return !isDefined(obj.claimer);
}

function can_use(obj) {
  if(!isDefined(obj)) {
    return false;
  }

  if(isDefined(obj.nextusetime) && (obj.nextusetime < 0 || gettime() < obj.nextusetime)) {
    return false;
  }

  if(is_true(obj.var_fbb20a79)) {
    return false;
  }

  if(isai(self) && obj.var_dd0284ce != self ai::get_behavior_attribute("demeanor")) {
    return false;
  }

  return true;
}

function get_goal() {
  assert(function_1631909f(self));
  str_shot = undefined;
  result = self;

  if(self.var_db740c43.size <= 1) {
    if(array::contains(self.shots, "intro")) {
      str_shot = "intro";
    } else if(array::contains(self.shots, "main")) {
      str_shot = "main";
    }

    if(isDefined(str_shot) && !is_true(self.var_fbb20a79)) {
      result = self scene::function_15be7db9(self.scriptbundlename, str_shot);
      result.goalradius = 16;
    }
  }

  assert(isDefined(result.goalradius));
  return result;
}

function function_ab981ed(desiredpos, volume, var_ce60cc2e, var_2889f642 = 0) {
  assert(issentient(self));

  if(!isDefined(level.smartobjectpoints)) {
    return undefined;
  }

  aiprofile_beginentry("GetBestSmartObject");
  var_3424891f = var_ce60cc2e * var_ce60cc2e;
  var_6debb24 = arraysortclosest(level.smartobjectpoints, desiredpos);
  var_43a2b258 = var_6debb24.size;
  smartobject = undefined;

  for(iobj = 0; iobj < var_43a2b258; iobj++) {
    object = var_6debb24[iobj];

    if(distancesquared(object.origin, desiredpos) > var_3424891f) {
      break;
    }

    if(!self can_claim(object)) {
      continue;
    }

    if(!self can_use(object)) {
      continue;
    }

    if(!self function_b5ba6914(object, desiredpos, volume, var_2889f642)) {
      continue;
    }

    smartobject = object;
    break;
  }

  aiprofile_endentry();
  return smartobject;
}

function function_1631909f(obj) {
  if(!isstruct(obj)) {
    return false;
  }

  if(!isDefined(obj.variantname)) {
    return false;
  }

  if(obj.variantname != "smart_object") {
    return false;
  }

  return true;
}

function function_b69b2de4(obj) {
  if(!function_1631909f(obj)) {
    return false;
  }

  if(!isstring(obj.scriptbundlename) && !ishash(obj.scriptbundlename)) {
    return false;
  }

  if(!isDefined(getscriptbundle(obj.scriptbundlename))) {
    return false;
  }

  return true;
}

function function_b03cc199(obj) {
  radiussq = 1600;
  zdiffsq = 4096;

  foreach(player in getplayers()) {
    if(distance2dsquared(obj.origin, player.origin) < radiussq && sqr(obj.origin[2] - player.origin[2]) < zdiffsq) {
      var_f9938c4c = vectortoyaw(player.origin - obj.origin);

      if(abs(angleclamp180(var_f9938c4c - obj.angles[1])) < 90) {
        return true;
      }
    }
  }

  return false;
}

function function_a49ba261(startpos, endpos, region, volume, var_9da4df29, var_aea7aa5b, var_a3a26744) {
  assert(issentient(self));

  if(!isDefined(level.smartobjectpoints)) {
    return;
  }

  var_d01a742 = 60;
  var_b079b771 = 60;
  var_62b1322 = 5184;
  var_26653e4b = 48;

  if(isDefined(region.volume.script_radius)) {
    var_26653e4b = region.volume.script_radius;
  }

  var_3f5ef53e = 128;

  if(isDefined(region.volume.script_maxdist)) {
    var_3f5ef53e = region.volume.script_maxdist;
  }

  starttoend = endpos - startpos;
  linelen = length(starttoend);
  var_8afe96be = starttoend / linelen;
  var_38bbcdf7 = vectornormalize((var_8afe96be[1], -1 * var_8afe96be[0], 0));
  var_1d23c510 = 0;
  drawtime = undefined;

  drawtime = 40;
  var_1d23c510 = getdvarint(#"hash_6c470450dd7dffd2", -1) == self getentitynumber();

  if(var_1d23c510) {
    line(startpos + (0, 0, 6), endpos + (0, 0, 6), (0, 0.5, 0.7), 1, 0, drawtime);
  }

  var_c7d9d665 = 60;
  var_fafda79b = 5;
  var_b11744c0 = 0.33;
  var_d5260937 = 1.5;
  var_c9b0ff8d = 300000;
  var_fda73bba = 0.001;
  bestobj = undefined;
  var_ef1e44f4 = -9999;

  foreach(obj in region.smart_objects) {
    if(distancesquared(obj.origin, self.origin) < var_62b1322) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xc4>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!self can_claim(obj)) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xcb>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!is_true(var_a3a26744) && !self can_use(obj)) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xd2>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!is_true(obj.script_auto_use)) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xda>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_5c084b53 = obj.origin - startpos;
    var_98883cf9 = vectordot(var_8afe96be, var_5c084b53);

    if(var_98883cf9 < var_9da4df29) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xe5>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(var_98883cf9 > linelen + var_d01a742) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xec>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_c79274d2 = abs(vectordot(var_38bbcdf7, var_5c084b53));

    if(var_c79274d2 * var_c79274d2 > obj.var_2edb5d76) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xf3>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_fbf46d73 = var_3f5ef53e;

    if(linelen - var_c79274d2 < 60) {
      var_fbf46d73 *= 0.5;
    }

    if(var_c79274d2 > var_fbf46d73) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xf8>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(isDefined(volume) && !volume istouching(obj.origin)) {
      if(var_1d23c510) {
        box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xff>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_fff54d0b = linelen - var_9da4df29;
    var_1f6e7bb3 = var_98883cf9 - var_9da4df29;
    var_429175fd = var_aea7aa5b - var_9da4df29;

    if(var_1f6e7bb3 < var_429175fd) {
      score = var_fafda79b + var_c7d9d665 * (1 - (var_429175fd - var_1f6e7bb3) / var_429175fd);
    } else {
      var_fff54d0b = linelen - var_aea7aa5b + var_d01a742;
      var_1f6e7bb3 = var_98883cf9 - var_aea7aa5b;
      score = var_fafda79b + var_c7d9d665 * (var_fff54d0b - var_1f6e7bb3) / var_fff54d0b;
    }

    if(var_c79274d2 > var_26653e4b) {
      var_7324080 = var_c79274d2 - var_26653e4b;
      score *= var_b11744c0 + (1 - var_7324080 / (var_fbf46d73 - var_26653e4b)) * (1 - var_b11744c0);
    }

    if(function_b03cc199(obj)) {
      score *= var_d5260937;

      if(var_1d23c510) {
        print3d(obj.origin + (0, 0, 20), "<dev string:x107>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }
    }

    if(isDefined(obj.lastusetime)) {
      if(gettime() - obj.lastusetime < var_c9b0ff8d) {
        score *= var_fda73bba;
      } else {
        obj.lastusetime = undefined;
      }
    }

    if(score > var_ef1e44f4) {
      var_ef1e44f4 = score;
      bestobj = obj;
    }

    if(var_1d23c510) {
      box(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.8, 0.8, 0), 0, drawtime);
      print3d(obj.origin + (0, 0, 24), "<dev string:x10c>" + score, (0.5, 0.5, 0.5), 1, 0.2, drawtime);
    }
  }

  return bestobj;
}

function function_b5ba6914(obj, optorigin, volume, var_2889f642) {
  assert(issentient(self));

  if(!is_true(optorigin.script_auto_use)) {
    return false;
  }

  if(isDefined(volume)) {
    pos = volume;
  } else {
    pos = self.origin;
  }

  distsqrd = distancesquared(pos, optorigin.origin);

  if(distsqrd > optorigin.var_2edb5d76) {
    return false;
  }

  if(isDefined(var_2889f642) && !var_2889f642 istouching(optorigin.origin)) {
    return false;
  }

  return true;
}

function set(obj) {
  assert(issentient(self));

  if(isDefined(self.smart_object)) {
    self function_a59dc8a8(self.smart_object);
  }

  self claim(obj);
  self thread function_2677ed08(obj);
}

function function_2677ed08(smartobj) {
  self notify("68a833247978732c");
  self endon("68a833247978732c");
  self endon(#"death", #"hash_6b1e2ef3367a9c8b");
  self.var_bf549417 = self.flashlightoverride;
  self.flashlightoverride = smartobj.var_a15f12c2;
  self.var_3ed929ba = smartobj.var_a15f12c2;
  smartobj waittill(#"hash_3a2c70ba8c45838e");
  function_bd54ea4c();
}

function function_bd54ea4c() {
  if(isDefined(self.var_3ed929ba)) {
    self.flashlightoverride = self.var_bf549417;
    self.var_3ed929ba = undefined;
  }
}

function function_feb48f7(obj) {
  assert(issentient(self));

  if(!isDefined(self.script_stealthgroup)) {
    return false;
  }

  if(isDefined(self.fnisinstealthinvestigate) && isDefined(self.fnisinstealthhunt) && !self[[self.fnisinstealthinvestigate]]() && !self[[self.fnisinstealthhunt]]()) {
    return false;
  }

  return true;
}

function function_97a10998(obj) {
  assert(issentient(self));
  forward = anglesToForward(self.angles);
  normal = vectornormalize(obj.origin - self.origin);

  if(vectordot(forward, normal) >= cos(60)) {
    strafedist = 64;
  } else {
    strafedist = 100;
  }

  if(distancesquared(self.origin, obj.origin) <= strafedist * strafedist) {
    return false;
  }

  forward = anglesToForward(obj.angles);

  if(vectordot(forward, normal) < cos(45)) {
    return false;
  }

  return true;
}

function private function_92be8cbf(localyaw = 0) {
  result = [];
  yaw = absangleclamp360(float(localyaw));

  if(yaw >= 315 || yaw <= 45) {
    if(yaw < 337.5 && yaw >= 315) {
      result[result.size] = 7;
    } else if(yaw > 22.5 && yaw <= 45) {
      result[result.size] = 9;
    }

    result[result.size] = 8;
  } else if(yaw >= 45 && yaw <= 90) {
    if(yaw < 67.5) {
      result[result.size] = 9;
    } else if(yaw > 112.5) {
      result[result.size] = 3;
    }

    result[result.size] = 6;
  } else if(yaw >= 135 && yaw <= 215) {
    if(yaw < 157.5) {
      result[result.size] = 3;
    } else if(yaw > 202.5) {
      result[result.size] = 1;
    }

    result[result.size] = 2;
  } else {
    if(yaw < 247.5) {
      result[result.size] = 1;
    } else if(yaw > 292.5) {
      result[result.size] = 7;
    }

    result[result.size] = 4;
  }

  return result;
}

function function_1cc20436() {
  function_b3ec7529();
  level thread function_ed7733c7();
}

function private function_5bfb6b3(dvar) {
  level.var_929178b5 = int(dvar.value);

  if(level.var_929178b5 != 0) {
    level thread function_23eef632();
    return;
  }

  level notify(#"hash_6f64ca444d328bd0");
}

function private function_23eef632() {
  self notify(#"hash_6f64ca444d328bd0");
  self endon(#"hash_6f64ca444d328bd0");

  while(true) {
    foreach(obj in level.smartobjectpoints) {
      scriptbundlename = obj.scriptbundlename;

      if(ishash(scriptbundlename)) {
        scriptbundlename = function_9e72a96(scriptbundlename);
      }

      print3d(obj.origin + (0, 0, 80), scriptbundlename, (0.5, 0.5, 0), 1, 0.25, 1, 1);
      util::draw_arrow(obj.origin + (0, 0, 1), obj.origin + (0, 0, 1) + anglesToForward(obj.angles) * 16, (0.5, 0.5, 0));

      if(obj.var_db740c43.size > 0) {
        foreach(intro in obj.var_db740c43) {
          print3d(intro.origin + (0, 0, 5), intro.shot, (0.5, 0.5, 0.5), 0.5, 0.1, 1, 1);
          line(intro.origin + (0, 0, 1), obj.origin + (0, 0, 1), (0.5, 0.5, 0.5), 0.5, 1, 1);
        }
      }

      if(isDefined(obj.var_175b0e60) && obj.var_175b0e60.size > 0) {
        foreach(intro in obj.var_175b0e60) {
          print3d(intro.var_93d6832 + (0, 0, 5), intro.shot + "<dev string:x110>", (1, 0, 0), 0.5, 0.1, 1, 1);
          line(intro.var_93d6832 + (0, 0, 1), obj.origin + (0, 0, 1), (1, 0, 0), 0.5, 1, 1);
        }
      }

      if(isDefined(obj.nextusetime) && (obj.nextusetime < 0 || gettime() < obj.nextusetime)) {
        msg = "<dev string:x11e>";

        if(obj.nextusetime >= 0) {
          msg = msg + "<dev string:x126>" + int(float(obj.nextusetime - gettime()) / 1000) + 1;
        }

        print3d(obj.origin + (0, 0, 75), msg, (0.5, 0.3, 0), 1, 0.25, 1, 1);
      }
    }

    waitframe(1);
  }
}

function private function_ed7733c7() {
  self notify(#"hash_4844afd3d6da9bce");
  self endon(#"hash_4844afd3d6da9bce");

  while(true) {
    foreach(obj in level.var_49430738) {
      scriptbundlename = obj.scriptbundlename;

      if(ishash(scriptbundlename)) {
        scriptbundlename = function_9e72a96(scriptbundlename);
      }

      print3d(obj.origin + (0, 0, 80), scriptbundlename, (0.5, 0, 0), 1, 0.25, 1, 1);
      print3d(obj.origin + (0, 0, 70), "<dev string:x12b>", (0.5, 0, 0), 1, 0.25, 1, 1);
      util::draw_arrow(obj.origin + (0, 0, 1), obj.origin + (0, 0, 1) + anglesToForward(obj.angles) * 16, (0.5, 0, 0));
    }

    if(level.var_49430738.size == 0) {
      break;
    }

    waitframe(1);
  }
}

function private function_6ab41bf7(shot) {
  self notify("<dev string:x144>");
  self endon("<dev string:x144>");

  if(isstring(shot)) {
    self endon(#"death", #"scene_done");

    while(true) {
      if(is_true(level.var_929178b5)) {
        print3d(self.origin + (0, 0, 71), shot, (1, 1, 0), 1, 0.25, 1, 1);
      }

      waitframe(1);
    }
  }
}