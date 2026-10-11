/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_da0dce9d411d119.gsc
************************************************/

#using script_14fb718749afd7cf;
#using script_4c543f01345a2c04;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_276b0a333696b49b;

function private function_51af81c1aecc2e12() {
  if(getdvarint(@ "hash_59166b6971c82342", 0)) {
    return 0;
  }

  if(self.entitydata.entitystate == 1) {
    return;
  }

  var_42c1062a451756ef = function_6f62bd82b9687bc0();

  if(isDefined(var_42c1062a451756ef)) {
    self.entitydata.entitystate = 1;
    self.var_e198ad98b4845f29.var_42c1062a451756ef = var_42c1062a451756ef;
    ent_flag_set("weakpoints_deactivate");
    return;
  }

  function_a497421f5acb0816();
}

function function_1f06485706658dbf(taskid, params) {
  self function_3e89eb3d8e3f1811("in_teleport", 1);
  return anim.success;
}

function function_5c5ec13b69fc89d9(taskid, params) {
  entitydata = self.entitydata;
  var_1fdf858c1fbf8cfa = self.var_e198ad98b4845f29;

  if(!isDefined(var_1fdf858c1fbf8cfa.var_42c1062a451756ef) || function_7f6dd8821551a274(4)) {
    if(function_7f6dd8821551a274(4)) {
      function_c3861dff329bffe1();
    }

    function_a497421f5acb0816();
    return anim.success;
  }

  if(function_7f6dd8821551a274(2)) {
    function_d8ff6d9287927895();
    function_25ef28554af7c94b();
    function_633de848764e3d4c();
  }

  return anim.running;
}

function private function_7f6dd8821551a274(state) {
  if(self getaiblackboarddynamic("in_teleport") == state) {
    return true;
  }

  return false;
}

function private function_6ead0d3f38711d70() {
  forcedstate = getDvar(@ "hash_8c559f76d73ee6fb", "disabled");
  settings = function_33e98dddd9968c7e();

  if(getdvarint(@ "hash_59166b6971c82342", 0)) {
    return false;
  }

  if(istrue(self.var_e198ad98b4845f29.var_a478985793711972)) {
    return false;
  }

  if(self.entitydata.entitystate == 1) {
    return false;
  }

  if(forcedstate == "disabled") {
    if(!settings.var_43d7f127229729e1.enabled) {
      return false;
    }

    if(function_99746a024292d48d()) {
      return false;
    }
  } else if(forcedstate != "teleport") {
    return false;
  }

  return true;
}

function private function_99746a024292d48d() {
  assert(isDefined(self.var_e198ad98b4845f29));
  settings = function_33e98dddd9968c7e();
  cooldowntime = getdvarint(@ "hash_f18107c280389e26", settings.var_43d7f127229729e1.cooldown);

  if(cooldowntime < 2) {
    cooldowntime = 2;
  }

  if(isDefined(self.var_4e54c3ab5875f278) && !istrue(self.var_4e54c3ab5875f278.var_9267ed46ecdf37c5)) {
    cooldowntime = getdvarint(@ "hash_c6f48c0c60cfedea", settings.var_43d7f127229729e1.cooldown);
  }

  cooldowntime *= 1000;
  currenttime = gettime();

  if(cooldowntime > 0) {
    if(!isDefined(self.var_e198ad98b4845f29.var_4a63cce2ed255914)) {
      return false;
    } else if(self.var_e198ad98b4845f29.var_4a63cce2ed255914 + cooldowntime > currenttime) {
      return true;
    }

    return false;
  }

  return true;
}

function private function_6b2e9906966d1148() {
  forcedstate = getDvar(@ "hash_8c559f76d73ee6fb", "disabled");
  settings = function_33e98dddd9968c7e();

  if(getdvarint(@ "hash_59166b6971c82342", 0)) {
    return false;
  }

  if(istrue(self.var_e198ad98b4845f29.var_a478985793711972)) {
    return false;
  }

  if(self.entitydata.entitystate == 1) {
    return false;
  }

  if(forcedstate != "disabled" || !settings.var_184af0c1a8b292d2.enabled) {
    return false;
  }

  if(function_c793e5d90687dc93()) {
    return false;
  }

  return true;
}

function private function_c793e5d90687dc93() {
  assert(isDefined(self.var_e198ad98b4845f29));
  settings = function_33e98dddd9968c7e();
  cooldowntime = getdvarint(@ "hash_f7be878189cf690", settings.var_184af0c1a8b292d2.cooldown);
  cooldowntime *= 1000;
  currenttime = gettime();

  if(cooldowntime > 0) {
    if(!isDefined(self.var_e198ad98b4845f29.var_4b262c5ba52dbb02)) {
      return false;
    } else if(self.var_e198ad98b4845f29.var_4b262c5ba52dbb02 + cooldowntime > currenttime) {
      return true;
    }

    return false;
  }

  return true;
}

function private function_1017131041e2a7b() {
  forcedstate = getDvar(@ "hash_8c559f76d73ee6fb", "disabled");
  settings = function_33e98dddd9968c7e();

  if(getdvarint(@ "hash_59166b6971c82342", 0)) {
    return false;
  }

  if(istrue(self.var_e198ad98b4845f29.var_a478985793711972)) {
    return false;
  }

  if(self.entitydata.entitystate == 1) {
    return false;
  }

  if(forcedstate != "disabled" || !settings.var_2a032a8d81704ebe.enabled) {
    return false;
  }

  return true;
}

function private function_6f62bd82b9687bc0() {
  if(getdvarint(@ "hash_21ee76b33e5115a6", 0)) {
    return self.entitydata.spawnlocation;
  }

  settings = function_33e98dddd9968c7e();
  locationindex = undefined;

  switch (settings.var_e1feaafebeaf442a) {
    case #"hash_35316be9c536822f":
      locationindex = function_130b4014bf08795();
      break;
    case #"hash_da565d3a0de1db3f":
      locationindex = function_72cc2105f47c4128();
      break;
    case #"hash_d950ebd1da4d0aa2":
      locationindex = function_e9488f769f23fc32();
      break;
    default:
      break;
  }

  if(isDefined(locationindex) && locationindex != self.entitydata.spawnlocation) {
    return locationindex;
  }

  if(istrue(settings.var_f88e5ea025599288)) {
    locationindex = function_e9488f769f23fc32();
    return locationindex;
  }

  return undefined;
}

function private function_ae4bc364d68e0605(var_3617e86310f044f) {
  settings = function_33e98dddd9968c7e();
  currenttime = gettime();

  if(istrue(var_3617e86310f044f) || istrue(settings.var_e585ee0d361fb9ba)) {
    self.var_e198ad98b4845f29.var_4a63cce2ed255914 = currenttime;
    self.var_e198ad98b4845f29.var_4b262c5ba52dbb02 = currenttime;
  }

  if(!isDefined(self.var_e198ad98b4845f29.reason)) {
    return;
  }

  switch (self.var_e198ad98b4845f29.reason) {
    case #"hash_7b6614415d1b2e48":
      self.var_e198ad98b4845f29.var_4a63cce2ed255914 = currenttime;
      break;
    case #"hash_1cc8a923a608c2a0":
      self.var_e198ad98b4845f29.var_4b262c5ba52dbb02 = currenttime;
      break;
    case #"hash_8446a00bea334ae5":
    default:
      break;
  }
}

function private function_d8ff6d9287927895() {
  callback::callback("zombie_entity_pre_teleport_callback");
}

function private function_633de848764e3d4c() {
  self function_3e89eb3d8e3f1811("in_teleport", 3);
  self.var_898e7a18e3c1354c.var_4e598e1797c70ad1++;
  callback::callback("zombie_entity_post_teleport_callback");
  self notify("spawn_orbs");
}

function private function_25ef28554af7c94b() {
  animdelta = namespace_87d56af5268f434b::function_7cd7a5fa2e0d8e24(self.asmname, "teleport_exit");

  if(!isDefined(animdelta)) {
    animdelta = (0, 0, 0);
  }

  phaseindex = self.entitydata.phaseindex;

  if(!isDefined(self.phasedata[phaseindex].var_8d5f6ee9e22c653e) || self.phasedata[phaseindex].var_8d5f6ee9e22c653e.size == 0) {
    return;
  }

  location = self.phasedata[phaseindex].var_8d5f6ee9e22c653e[self.var_e198ad98b4845f29.var_42c1062a451756ef];

  if(!isDefined(location)) {
    return;
  }

  reverse = -1 * vectorNormalize(anglesToForward(location.angles));
  var_5875aebc3992449e = -1 * vectorNormalize(anglestoup(location.angles));
  leftvector = vectorNormalize(anglestoleft(location.angles));
  var_646666a33716a682 = animdelta[0] * reverse + animdelta[1] * leftvector + animdelta[2] * var_5875aebc3992449e;
  teleportorigin = location.origin + var_646666a33716a682;

  if(getdvarint(@ "hash_b5024b31d9ec2722", 0)) {
    sphere(location.origin, 100, (0, 1, 0), undefined, 500);
    sphere(teleportorigin, 100, (1, 0, 0), undefined, 500);
  }

  self forceteleport(teleportorigin, location.angles);

  if(isDefined(self.entitydata.spawnlocation)) {
    self.entitydata.var_9e9d541733c8afa4 = self.entitydata.spawnlocation;
  }

  self.entitydata.spawnlocation = self.var_e198ad98b4845f29.var_42c1062a451756ef;
}

function private function_c3861dff329bffe1() {
  ent_flag_set("weakpoints_activate");
}

function private function_a497421f5acb0816() {
  function_ae4bc364d68e0605();
  self.var_e198ad98b4845f29.reason = undefined;
  self.var_e198ad98b4845f29.var_c9a5e91aaf4191d5 = self.health;
  self.var_e198ad98b4845f29.var_42c1062a451756ef = undefined;
  self.entitydata.entitystate = 0;
  self function_3e89eb3d8e3f1811("in_teleport", 0);
  utility::function_3ab9164ef76940fd("reactive_miscellaneous", "off");
}

function private function_33e98dddd9968c7e() {
  return self.var_e198ad98b4845f29.phase[self.entitydata.phaseindex];
}