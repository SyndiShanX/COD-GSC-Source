/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4947004a8b7efbdc.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_4c543f01345a2c04;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#namespace namespace_6693a0c04250d04c;

function function_b25d4cb935628ac8(taskid, params) {
  var_b33910d3fd7718b1 = function_349fad68f5235a62();
  self.entitydata.var_9adf21d0962a922b = 2;
  self.entitydata.var_1be563f374236c47 = 1;
  self.var_a3d0ad660af72d52.var_d91ebd99b9e4a77 = [];
  self.var_a3d0ad660af72d52.var_d8e4422371928803 = [];
  self.var_a3d0ad660af72d52.var_49723cc0041f1836 = [];
  self.var_a3d0ad660af72d52.targetindex = 0;
  self.var_a3d0ad660af72d52.var_4674902b1ffe1500 = ["death", "fake_death", "beam_end", "beam_attack_end"];
  ent_flag_clear("beam_origin_start");
  ent_flag_clear("beam_origin_ent_created");
  ent_flag_set("beam_attack_vo");
  self.var_a3d0ad660af72d52.starttime = gettime();

  if(!isDefined(self.var_a3d0ad660af72d52.var_ca191c145576c838)) {
    thread function_6ad51f4ad0a62bed();
  }

  self.var_a3d0ad660af72d52.var_d465ac053115a827 = function_efc9be9e46d1f242(self.asmname, "beam_attack_exit", "start_beam", "end_beam");

  if(!isDefined(self.var_a3d0ad660af72d52.var_d465ac053115a827)) {
    self.var_a3d0ad660af72d52.var_d465ac053115a827 = var_b33910d3fd7718b1.var_68e04b0455c43bfe;
  }

  if(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Random") {
    self.var_a3d0ad660af72d52.var_98a650d81ee56d1a = 1;
    var_b33910d3fd7718b1.var_15c62e2a3e84a52 = function_d4d4badbc5957e54();
  }

  switch (var_b33910d3fd7718b1.var_15c62e2a3e84a52) {
    case #"hash_5a7a588e698f5388":
      self.var_a3d0ad660af72d52.targetent = function_1b412af6d5fbead2();
      self.var_a3d0ad660af72d52.var_5cbba012d5f74041 = utility::spawn_model("tag_origin", self.var_a3d0ad660af72d52.targetent.origin);
      self.var_a3d0ad660af72d52.var_5cbba012d5f74041 setModel(var_b33910d3fd7718b1.var_591cbe2e14d189c0);
      thread function_5ee1730c2e122134(self.var_a3d0ad660af72d52.var_5cbba012d5f74041, "beam_end");
      thread function_741a839378a9a54c();
      break;
    case #"hash_4d08ff3ad458ee96":
      var_b33910d3fd7718b1.var_15c62e2a3e84a52 = "Simultaneous";
    case #"hash_16a7a0d29228a344":
      self.var_a3d0ad660af72d52.targetents = function_ec3c1dd899050013(var_b33910d3fd7718b1);
      function_a4874db27f866be1(var_b33910d3fd7718b1);

      for(i = 0; i < self.var_a3d0ad660af72d52.targetents.size; i++) {
        thread function_741a839378a9a54c(i);
      }

      break;
    default:
      break;
  }

  return anim.success;
}

function function_5231ea5134958d4d(taskid, params) {
  var_b33910d3fd7718b1 = function_349fad68f5235a62();

  if(self function_11e2d4051ea44b35("in_beam_attack") < 2) {
    return anim.running;
  }

  if(!istrue(self.var_a3d0ad660af72d52.var_63f444e437cb1262)) {
    function_f67f84973edc7503(var_b33910d3fd7718b1);
    self.var_a3d0ad660af72d52.var_63f444e437cb1262 = 1;
  }

  if(gettime() > self.var_a3d0ad660af72d52.var_ba5f72633d21887d + var_b33910d3fd7718b1.var_136749637cbe9ad2) {
    self.var_a3d0ad660af72d52.var_63f444e437cb1262 = 0;
    self function_3e89eb3d8e3f1811("in_beam_attack", 3);
    function_443cd80e8a6ff2cc(var_b33910d3fd7718b1);
    return anim.success;
  }

  return anim.running;
}

function function_e4a60b288e21acbd(taskid, params) {
  var_b33910d3fd7718b1 = function_349fad68f5235a62();

  if(self function_11e2d4051ea44b35("in_beam_attack") <= 6) {
    switch (var_b33910d3fd7718b1.var_15c62e2a3e84a52) {
      case #"hash_5a7a588e698f5388":
        return function_a9ebe59a07633a35(var_b33910d3fd7718b1);
      case #"hash_16a7a0d29228a344":
        return function_dd84c64b6c429321(var_b33910d3fd7718b1);
      case #"hash_4d08ff3ad458ee96":
      default:
        break;
    }
  }

  return anim.running;
}

function private function_6ad51f4ad0a62bed() {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("beam_end");
  self endon("beam_attack_end");
  ent_flag_wait("beam_origin_start");
  var_b33910d3fd7718b1 = function_349fad68f5235a62();
  var_afd09beba51fbff6 = self gettagorigin(var_b33910d3fd7718b1.handtag);
  handangles = self gettagangles(var_b33910d3fd7718b1.handtag);
  upvector = anglestoup(handangles);
  forwardvector = anglesToForward(handangles);
  leftvector = anglestoleft(handangles);
  var_6b5e24742ed2634c = function_682c11b8dcb8c7f9(var_b33910d3fd7718b1.handtag);
  handoffset = var_b33910d3fd7718b1.var_856dc80728272d7b.forward * forwardvector + var_b33910d3fd7718b1.var_856dc80728272d7b.left * leftvector + var_b33910d3fd7718b1.var_856dc80728272d7b.up * upvector;
  self.var_a3d0ad660af72d52.var_ca191c145576c838 = utility::spawn_model("tag_origin", var_afd09beba51fbff6 + handoffset, (0, 0, 0));
  self.var_a3d0ad660af72d52.var_ca191c145576c838 setModel(var_b33910d3fd7718b1.var_4be7b82edbfe5a31);
  self.var_a3d0ad660af72d52.var_ca191c145576c838.var_42929bc8877878b3 = 1;
  thread function_5ee1730c2e122134(self.var_a3d0ad660af72d52.var_ca191c145576c838, "beam_end");
  self.var_a3d0ad660af72d52.var_ca191c145576c838 linkTo(self, var_b33910d3fd7718b1.handtag, (0, 0, 0), var_6b5e24742ed2634c);
  self.var_a3d0ad660af72d52.var_ca191c145576c838 fixlinktointerpolationbug(1);
  self.var_a3d0ad660af72d52.var_ca191c145576c838 utility::function_3ab9164ef76940fd("beam_origin", "beam_origin_on");
  ent_flag_set("beam_origin_ent_created");
}

function private function_a4874db27f866be1(var_b33910d3fd7718b1) {
  self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6 = [];

  for(i = 0; i < self.var_a3d0ad660af72d52.targetents.size; i++) {
    self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[i] = utility::spawn_model("tag_origin", self.var_a3d0ad660af72d52.targetents[i].origin);
    self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[i] setModel(var_b33910d3fd7718b1.var_591cbe2e14d189c0);
    thread function_5ee1730c2e122134(self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[i], "beam_end");
  }
}

function private function_ec3c1dd899050013(var_b33910d3fd7718b1) {
  targets = [];
  count = clamp(level.players.size, var_b33910d3fd7718b1.var_e4fbe8b46e55aabc, var_b33910d3fd7718b1.var_9ed08423c48f77a);

  for(i = 0; i < count; i++) {
    targets[i] = function_1b412af6d5fbead2();
  }

  return targets;
}

function private function_1b412af6d5fbead2() {
  var_8b591b0bc361ab3d = randomint(3);
  selectedplayer = undefined;

  switch (var_8b591b0bc361ab3d) {
    case 0:
      selectedplayer = function_370e89cf65df0b01(1, 1);
      break;
    case 1:
      selectedplayer = function_f3a96ba65901316(1, 1);
      break;
    case 2:
    default:
      selectedplayer = function_34f345873460798b(1, 1);
      break;
  }

  if(!isDefined(selectedplayer)) {
    selectedplayer = random(level.players);
  }

  selectedplayer.var_c764aba579deab63 = 1;
  return selectedplayer;
}

function private function_741a839378a9a54c(index) {
  self endon("death");
  self endon("fake_death");
  self endon("beam_end");
  level endon("game_ended");
  predictedposition = undefined;
  var_6bd99ac91b3d29d = undefined;
  face_direction = (0, 0, 0);
  var_b33910d3fd7718b1 = function_349fad68f5235a62();
  ent_flag_wait("beam_origin_ent_created");

  while(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Standard" && isDefined(self.var_a3d0ad660af72d52.var_ca191c145576c838) && isDefined(self.var_a3d0ad660af72d52.var_5cbba012d5f74041) || isDefined(self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6) && isDefined(self.var_a3d0ad660af72d52.var_ca191c145576c838) && isDefined(self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[index])) {
    if(self function_11e2d4051ea44b35("in_beam_attack") == 4) {
      if(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Standard") {
        result = function_a11b584f07a0a8b4();
        predictedposition = result.predictedposition;
        var_6bd99ac91b3d29d = result.var_6bd99ac91b3d29d;
      } else {
        result = function_52b9e6a7c93ab15c(index);
        predictedposition = result.predictedposition;
        var_6bd99ac91b3d29d = result.var_6bd99ac91b3d29d;
      }
    } else if(self function_11e2d4051ea44b35("in_beam_attack") == 2) {
      if(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Standard") {
        result = function_2a4593cba21b7ead();
        predictedposition = result.predictedposition;
        var_6bd99ac91b3d29d = result.var_6bd99ac91b3d29d;
      } else {
        result = function_2971c0d765357e2b(index);
        predictedposition = result.predictedposition;
        var_6bd99ac91b3d29d = result.var_6bd99ac91b3d29d;
      }
    }

    if(isDefined(predictedposition)) {
      if(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Standard") {
        target_yaw = utility::getyawtospot(var_6bd99ac91b3d29d);
        target_pitch = self.var_a3d0ad660af72d52.var_ca191c145576c838 getpitchtospot3d(var_6bd99ac91b3d29d);
        self function_a490fd20800374d8(target_yaw);
        self.var_a3d0ad660af72d52.var_5cbba012d5f74041.origin = predictedposition;
      } else {
        if(index == self.var_a3d0ad660af72d52.targetindex) {
          target_yaw = utility::getyawtospot(var_6bd99ac91b3d29d);
          target_pitch = self.var_a3d0ad660af72d52.var_ca191c145576c838 getpitchtospot3d(var_6bd99ac91b3d29d);
          self function_a490fd20800374d8(target_yaw);
        }

        self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[index].origin = predictedposition;
      }

      face_direction = predictedposition - self.var_a3d0ad660af72d52.var_ca191c145576c838.origin;
      face_angles = vectortoangles(face_direction);
      self.var_a3d0ad660af72d52.var_ca191c145576c838.angles = face_angles;
    }

    waitframe();
  }
}

function private function_a11b584f07a0a8b4() {
  var_b33910d3fd7718b1 = function_349fad68f5235a62();

  if(!(isDefined(self.var_a3d0ad660af72d52.var_52c410f7e0d3b282) && isDefined(self.var_a3d0ad660af72d52.var_974971cf3b92ec81))) {
    target = self.var_a3d0ad660af72d52.targetent;
    forward = anglesToForward(target.angles);
    randomyaw = randomfloatrange(-20, 20);
    randomdirection = rotatevector(forward, (0, randomyaw, 0));
    self.var_a3d0ad660af72d52.var_52c410f7e0d3b282 = target.origin + randomdirection * 1000;
    self.var_a3d0ad660af72d52.var_974971cf3b92ec81 = target.origin - randomdirection * 1000;
  }

  return function_70bb54c5694e2df4(self.var_a3d0ad660af72d52.var_52c410f7e0d3b282, self.var_a3d0ad660af72d52.var_974971cf3b92ec81, var_b33910d3fd7718b1);
}

function private function_52b9e6a7c93ab15c(index) {
  var_b33910d3fd7718b1 = function_349fad68f5235a62();

  if(!(isDefined(self.var_a3d0ad660af72d52.var_d8e4422371928803[index]) && isDefined(self.var_a3d0ad660af72d52.var_49723cc0041f1836[index]))) {
    target = self.var_a3d0ad660af72d52.targetents[index];
    forward = anglesToForward(target.angles);
    randomyaw = randomfloatrange(-20, 20);
    randomdirection = rotatevector(forward, (0, randomyaw, 0));

    if(level.players.size == 1 && index != 0) {
      randomdirection = rotatevector(forward, (0, 90, 0));
    }

    self.var_a3d0ad660af72d52.var_d8e4422371928803[index] = target.origin + randomdirection * 1000;
    self.var_a3d0ad660af72d52.var_49723cc0041f1836[index] = target.origin - randomdirection * 1000;
  }

  return function_70bb54c5694e2df4(self.var_a3d0ad660af72d52.var_d8e4422371928803[index], self.var_a3d0ad660af72d52.var_49723cc0041f1836[index], var_b33910d3fd7718b1);
}

function private function_70bb54c5694e2df4(startpoint, endpoint, var_b33910d3fd7718b1) {
  currenttime = gettime() - self.var_a3d0ad660af72d52.var_8b3564d3aa8cefe2;
  var_d465ac053115a827 = self.var_a3d0ad660af72d52.var_d465ac053115a827;
  fraction = currenttime / var_d465ac053115a827;
  predictedposition = vectorlerp(startpoint, endpoint, fraction);
  var_6bd99ac91b3d29d = predictedposition;
  hitents = [];
  var_9786a680355a9e9c = undefined;
  var_2ea13c3bee4acef8 = 0;
  var_d99cdcd32709ef50 = self.var_a3d0ad660af72d52.var_ca191c145576c838 gettagorigin("tag_origin");
  var_9073e87eddd24712 = distance(var_d99cdcd32709ef50, predictedposition);
  attackdirection = vectorNormalize(predictedposition - self.var_a3d0ad660af72d52.var_ca191c145576c838.origin);
  var_c9d970d88a95e6a7 = self.var_a3d0ad660af72d52.var_ca191c145576c838.origin + attackdirection * self.var_a3d0ad660af72d52.var_59ce2c6601dbb32e;
  traceresults = trace::ray_trace_get_all_results(var_d99cdcd32709ef50, var_c9d970d88a95e6a7);

  foreach(traceresult in traceresults) {
    if(isDefined(traceresult["hittype"])) {
      if(traceresult["hittype"] == "hittype_world") {
        if(!isDefined(var_9786a680355a9e9c)) {
          var_9786a680355a9e9c = traceresult["position"];
          var_2ea13c3bee4acef8 = distance(var_d99cdcd32709ef50, var_9786a680355a9e9c);
          break;
        }
      }

      if(traceresult["hittype"] == "hittype_entity") {
        hitents = utility::array_add(hitents, traceresult["entity"]);
      }
    }
  }

  if(!isDefined(var_9786a680355a9e9c)) {
    var_758c8f7ab148c3cf = min(var_9073e87eddd24712 * 2, self.var_a3d0ad660af72d52.var_59ce2c6601dbb32e);
    predictedposition = self.var_a3d0ad660af72d52.var_ca191c145576c838.origin + attackdirection * var_758c8f7ab148c3cf;
  } else {
    predictedposition = var_9786a680355a9e9c;
  }

  if(isDefined(hitents) && hitents.size > 0) {
    function_cb2f8ad0f4aad08a(hitents, var_d99cdcd32709ef50);
  }

  result = spawnStruct();
  result.predictedposition = predictedposition;
  result.var_6bd99ac91b3d29d = var_6bd99ac91b3d29d;
  return result;
}

function private function_cb2f8ad0f4aad08a(hitents, var_6ab10bf6e1963525) {
  var_b33910d3fd7718b1 = function_349fad68f5235a62();

  foreach(hitent in hitents) {
    if(!isalive(hitent) || self == hitent || istrue(self.inlaststand)) {
      continue;
    }

    var_939e1aed87d29e13 = 50;
    var_f4991c83e09960bd = 0;

    if(isPlayer(hitent)) {
      var_939e1aed87d29e13 = var_b33910d3fd7718b1.playerdamage;
    } else if(isai(hitent)) {
      if(isPlayer(hitent.var_66c1831357048c02)) {
        var_939e1aed87d29e13 = hitent.maxhealth * self.var_a3d0ad660af72d52.var_e3283b87da5f2e91;
      } else if((!isDefined(hitent.aicategory) || hitent.aicategory == "normal") && !istrue(hitent.damageshield)) {
        var_f4991c83e09960bd = 1;
      } else if(is_equal(hitent.aicategory, "special")) {
        var_939e1aed87d29e13 = hitent.maxhealth * self.var_a3d0ad660af72d52.specialdamage;
      } else if(is_equal(hitent.aicategory, "elite")) {
        var_939e1aed87d29e13 = hitent.maxhealth * self.var_a3d0ad660af72d52.var_6004242b2a8e2529;
      }
    }

    if(istrue(var_f4991c83e09960bd)) {
      hitent utility::ent_flag_set("dissolve");
      hitent playSound("evt_entity_beam_zombie_dissolve_death");
      hitent kill(var_6ab10bf6e1963525, self, self, "MOD_PROJECTILE");
      continue;
    }

    if(isai(hitent) && !isDefined(hitent.var_66c1831357048c02)) {
      hitent dodamage(var_939e1aed87d29e13, var_6ab10bf6e1963525, undefined, undefined, "MOD_PROJECTILE");
      continue;
    }

    hitent dodamage(var_939e1aed87d29e13, var_6ab10bf6e1963525, self, self, "MOD_PROJECTILE");
  }
}

function private function_2a4593cba21b7ead() {
  predictedposition = vectorlerp(self.var_a3d0ad660af72d52.var_5cbba012d5f74041.origin, self.var_a3d0ad660af72d52.targetent.origin, 0.2);
  result = spawnStruct();
  result.predictedposition = predictedposition;
  result.var_6bd99ac91b3d29d = predictedposition;
  return result;
}

function private function_2971c0d765357e2b(index) {
  predictedposition = vectorlerp(self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[index].origin, self.var_a3d0ad660af72d52.targetents[index].origin, 0.2);
  result = spawnStruct();
  result.predictedposition = predictedposition;
  result.var_6bd99ac91b3d29d = predictedposition;
  return result;
}

function private function_d4d4badbc5957e54() {
  var_21e7f83a51e08f01 = randomint(3);

  switch (var_21e7f83a51e08f01) {
    case 2:
      return "Successive";
    case 1:
      return "Simultaneous";
    case 0:
    default:
      return "Standard";
  }
}

function private function_f67f84973edc7503(var_b33910d3fd7718b1) {
  ent_flag_set("beam_origin_start");
  scriptablepartstate = function_b61d0a63a27dd52e("beam_attack_target", self.entitydata.phaseindex);

  if(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Standard") {
    self.var_a3d0ad660af72d52.targetent function_3ab9164ef76940fd("zombieEntityVFX", scriptablepartstate);
    return;
  }

  for(i = 0; i < self.var_a3d0ad660af72d52.targetents.size; i++) {
    if(isent(self.var_a3d0ad660af72d52.targetents[i])) {
      self.var_a3d0ad660af72d52.targetents[i] function_3ab9164ef76940fd("zombieEntityVFX", scriptablepartstate);
    }
  }
}

function private function_443cd80e8a6ff2cc(var_b33910d3fd7718b1) {
  if(var_b33910d3fd7718b1.var_15c62e2a3e84a52 == "Standard") {
    if(isDefined(self.var_a3d0ad660af72d52.targetent)) {
      self.var_a3d0ad660af72d52.targetent function_3ab9164ef76940fd("zombieEntityVFX", "off");
    }

    return;
  }

  for(i = 0; i < self.var_a3d0ad660af72d52.targetents.size; i++) {
    if(isent(self.var_a3d0ad660af72d52.targetents[i])) {
      self.var_a3d0ad660af72d52.targetents[i] function_3ab9164ef76940fd("zombieEntityVFX", "off");
    }
  }
}

function private function_4b952ece3c5e63d0(var_b33910d3fd7718b1) {
  handangles = self gettagangles(var_b33910d3fd7718b1.handtag);
  upvector = anglestoup(handangles);
  forwardvector = anglesToForward(handangles);
  leftvector = anglestoleft(handangles);
  var_afd09beba51fbff6 = self gettagorigin(var_b33910d3fd7718b1.handtag);
  originoffset = var_b33910d3fd7718b1.var_856dc80728272d7b.forward * forwardvector + var_b33910d3fd7718b1.var_856dc80728272d7b.left * leftvector + var_b33910d3fd7718b1.var_856dc80728272d7b.up * upvector;
  var_7b34ce703558d8d1 = var_b33910d3fd7718b1.var_2bf0e4c391a41f48.forward * forwardvector + var_b33910d3fd7718b1.var_2bf0e4c391a41f48.left * leftvector + var_b33910d3fd7718b1.var_2bf0e4c391a41f48.up * upvector;
  self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743 = utility::spawn_model("tag_origin", var_afd09beba51fbff6 + originoffset + var_7b34ce703558d8d1, (0, 0, 0));
  thread function_5ee1730c2e122134(self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743, "beam_end");
  self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743 linkTo(self, var_b33910d3fd7718b1.handtag);
}

function private function_54e2a401d6eadd42(var_7fb15984f4f0a480, starttag, targetent, targettag, index) {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("beam_end");
  self endon("beam_attack_end");
  var_b33910d3fd7718b1 = function_349fad68f5235a62();
  fxid = function_c4447e7f406126bb("entity_beam_vfx", self.entitydata.phaseindex);
  beamfx = playfxontagsbetweenclients(getfx(fxid), var_7fb15984f4f0a480, starttag, targetent, targettag);

  if(isDefined(beamfx)) {
    beamfx function_cea710f9d017694a(1);
    thread function_5ee1730c2e122134(beamfx, "beam_end");

    switch (var_b33910d3fd7718b1.var_15c62e2a3e84a52) {
      case #"hash_5a7a588e698f5388":
        self.var_a3d0ad660af72d52.var_43ebce8c6fadfade = beamfx;
        break;
      case #"hash_16a7a0d29228a344":
      case #"hash_4d08ff3ad458ee96":
        if(isDefined(index)) {
          self.var_a3d0ad660af72d52.var_d91ebd99b9e4a77[index] = beamfx;
        }

        break;
      default:
        break;
    }
  }

  targetent utility::function_3ab9164ef76940fd("beam_target", "beam_target_on");
  utility::function_3ab9164ef76940fd("palm", "beam");
}

function private function_a9ebe59a07633a35(var_b33910d3fd7718b1) {
  var_35ede15dcb6c126a = self function_11e2d4051ea44b35("in_beam_attack");

  if(var_35ede15dcb6c126a == 5) {
    function_1b6bb935b2ee68bf();
    return anim.success;
  } else if(var_35ede15dcb6c126a < 5) {
    if(ent_flag("end_beam")) {
      function_680e907027d24e86();
    } else if(!isDefined(self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743) && isDefined(self.var_a3d0ad660af72d52.var_52c410f7e0d3b282) && isDefined(self.var_a3d0ad660af72d52.var_974971cf3b92ec81)) {
      self.var_a3d0ad660af72d52.var_b7a18d0cc9bb6b75 = 1;
      function_4b952ece3c5e63d0(var_b33910d3fd7718b1);
      function_f9a207358d70923c(0.1, self.var_a3d0ad660af72d52.var_4674902b1ffe1500, &function_54e2a401d6eadd42, self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743, "tag_origin", self.var_a3d0ad660af72d52.var_5cbba012d5f74041, "tag_origin");
    }
  }

  return anim.running;
}

function private function_dd84c64b6c429321(var_b33910d3fd7718b1) {
  var_35ede15dcb6c126a = self function_11e2d4051ea44b35("in_beam_attack");

  if(var_35ede15dcb6c126a == 5) {
    function_1b6bb935b2ee68bf();
    return anim.success;
  } else if(var_35ede15dcb6c126a < 5) {
    if(ent_flag("end_beam")) {
      function_680e907027d24e86();
    } else if(!isDefined(self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743)) {
      function_4b952ece3c5e63d0(var_b33910d3fd7718b1);
      self.var_a3d0ad660af72d52.var_9ca44e352a9e86e3 = [];
    }

    for(i = 0; i < self.var_a3d0ad660af72d52.targetents.size; i++) {
      if(!istrue(self.var_a3d0ad660af72d52.var_9ca44e352a9e86e3[i]) && isDefined(self.var_a3d0ad660af72d52.var_d8e4422371928803[i]) && isDefined(self.var_a3d0ad660af72d52.var_49723cc0041f1836[i])) {
        function_f9a207358d70923c(0.1, self.var_a3d0ad660af72d52.var_4674902b1ffe1500, &function_54e2a401d6eadd42, self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743, "tag_origin", self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6[i], "tag_origin");
        self.var_a3d0ad660af72d52.var_9ca44e352a9e86e3[i] = 1;
      }
    }
  }

  return anim.running;
}

function function_6b4f9e89f81383ea() {
  self notify("tracker_beam_end");
  self notify("beam_attack_end");
  function_680e907027d24e86();
  function_1b6bb935b2ee68bf();
}

function private function_680e907027d24e86() {
  self notify("beam_end");
  var_b33910d3fd7718b1 = function_349fad68f5235a62();
  self.entitydata.var_37e9fcfa2a8f6a31 = gettime() + var_b33910d3fd7718b1.cooldown;
  self.entitydata.attack_lastattacktime = gettime();

  if(isDefined(self.var_a3d0ad660af72d52.targetents)) {
    for(i = 0; i < self.var_a3d0ad660af72d52.targetents.size; i++) {
      if(isDefined(self.var_a3d0ad660af72d52.targetents[i])) {
        self.var_a3d0ad660af72d52.targetents[i].var_c764aba579deab63 = 0;
      }
    }
  }

  self function_3e89eb3d8e3f1811("in_beam_attack", 5);
  utility::function_3ab9164ef76940fd("palm", "off");
  ent_flag_clear("beam_attack_vo");
  ent_flag_clear("beam_origin_start");

  if(isDefined(self.var_a3d0ad660af72d52.var_ca191c145576c838)) {
    self.var_a3d0ad660af72d52.var_ca191c145576c838 utility::function_3ab9164ef76940fd("beam_origin", "beam_origin_off");
    self.var_a3d0ad660af72d52.var_ca191c145576c838 = undefined;
  }

  if(isDefined(self.var_a3d0ad660af72d52.var_5cbba012d5f74041)) {
    self.var_a3d0ad660af72d52.var_5cbba012d5f74041 utility::function_3ab9164ef76940fd("beam_target", "beam_target_off");
    self.var_a3d0ad660af72d52.var_5cbba012d5f74041 = undefined;
  } else if(isDefined(self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6)) {
    foreach(targetent in self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6) {
      if(!isDefined(targetent)) {
        continue;
      }

      targetent utility::function_3ab9164ef76940fd("beam_target", "beam_target_off");
    }
  }

  if(isDefined(self.var_a3d0ad660af72d52.targetent)) {
    self.var_a3d0ad660af72d52.targetent.var_c764aba579deab63 = 0;
    self.var_a3d0ad660af72d52.targetent utility::function_3ab9164ef76940fd("zombieEntityVFX", "off");
    self.var_a3d0ad660af72d52.targetent = undefined;
  }

  if(istrue(self.var_a3d0ad660af72d52.var_98a650d81ee56d1a)) {
    var_b33910d3fd7718b1.var_15c62e2a3e84a52 = "Random";
    self.var_a3d0ad660af72d52.var_98a650d81ee56d1a = 0;
  }

  self.var_a3d0ad660af72d52.var_63f444e437cb1262 = undefined;
  self.var_a3d0ad660af72d52.var_7fb62dc3a8a94743 = undefined;
  self.var_a3d0ad660af72d52.var_d465ac053115a827 = undefined;
  self.var_a3d0ad660af72d52.var_52c410f7e0d3b282 = undefined;
  self.var_a3d0ad660af72d52.var_974971cf3b92ec81 = undefined;
  self.var_a3d0ad660af72d52.var_d8e4422371928803 = [];
  self.var_a3d0ad660af72d52.var_49723cc0041f1836 = [];
  self.var_a3d0ad660af72d52.targetents = [];
  self.var_a3d0ad660af72d52.var_e7e13b6c8ec22df6 = [];
  self.var_a3d0ad660af72d52.var_d91ebd99b9e4a77 = [];
  self.var_a3d0ad660af72d52.var_9ca44e352a9e86e3 = [];
}

function private function_1b6bb935b2ee68bf() {
  self.entitydata.var_9adf21d0962a922b = 0;
  self.entitydata.var_1be563f374236c47 = undefined;
  ent_flag_clear("end_beam");
  self function_3e89eb3d8e3f1811("in_beam_attack", 0);
}

function private function_349fad68f5235a62() {
  assert(isDefined(self.var_a3d0ad660af72d52.var_b33910d3fd7718b1) && isDefined(self.entitydata.phaseindex) && isDefined(self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[self.entitydata.phaseindex]), "<dev string:x1c>");
  return self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[self.entitydata.phaseindex];
}

function private function_682c11b8dcb8c7f9(var_a82cf207c930ea2d) {
  switch (var_a82cf207c930ea2d) {
    case #"hash_490819a022507b47":
      return (22.5, 0, 0);
    default:
      var_f11a27a38e837d64 = (0, 0, 0);
      return var_f11a27a38e837d64;
  }
}

function function_fb8d528d55c8ec50(var_c738c3b00598761c) {
  if(!isDefined(var_c738c3b00598761c) || !isalive(var_c738c3b00598761c) || !isDefined(var_c738c3b00598761c.entitydata)) {
    return;
  }

  var_b33910d3fd7718b1 = var_c738c3b00598761c function_349fad68f5235a62();

  switch (var_b33910d3fd7718b1.var_15c62e2a3e84a52) {
    case #"hash_5a7a588e698f5388":
      if(isDefined(var_c738c3b00598761c.var_a3d0ad660af72d52.targetent) && var_c738c3b00598761c.var_a3d0ad660af72d52.targetent == self) {
        var_c738c3b00598761c.var_a3d0ad660af72d52.targetent = utility::spawn_model("tag_origin", var_c738c3b00598761c.var_a3d0ad660af72d52.targetent.origin, (0, 0, 0));
        var_c738c3b00598761c thread function_5ee1730c2e122134(var_c738c3b00598761c.var_a3d0ad660af72d52.targetent, "beam_end");
        break;
      }
    case #"hash_16a7a0d29228a344":
    case #"hash_4d08ff3ad458ee96":
      if(isDefined(var_c738c3b00598761c.var_a3d0ad660af72d52.targetents)) {
        for(i = 0; i < var_c738c3b00598761c.var_a3d0ad660af72d52.targetents.size; i++) {
          if(isDefined(var_c738c3b00598761c.var_a3d0ad660af72d52.targetents[i]) && var_c738c3b00598761c.var_a3d0ad660af72d52.targetents[i] == self) {
            var_c738c3b00598761c.var_a3d0ad660af72d52.targetents[i] = utility::spawn_model("tag_origin", var_c738c3b00598761c.var_a3d0ad660af72d52.targetents[i].origin, (0, 0, 0));
            var_c738c3b00598761c thread function_5ee1730c2e122134(var_c738c3b00598761c.var_a3d0ad660af72d52.targetents[i], "beam_end");
          }
        }
      }

      break;
    default:
      break;
  }
}