/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2bd16c90e9c5c546.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_e1447aac8628ea7d;

function function_786c10d84c135d5c(noteworthy) {
  if(!isDefined(level.var_9283d76b0bfabcca)) {
    level.var_9283d76b0bfabcca = [];
  }

  if(isDefined(level.var_9283d76b0bfabcca[noteworthy])) {
    assertmsg("Tried to call init on choreographer '" + noteworthy + "' twice. Did you mean to shut it down first?");
    return;
  }

  setsaveddvar(@ "hash_3b4b03b3aaed756b", 1);
  function_72b276b70c158821(noteworthy);
  choreographer = spawnStruct();
  choreographer.name = noteworthy;
  choreographer.volumes = [];
  choreographer.var_3e74f4416e413e01 = [];
  volumes = getEntArray(noteworthy, "script_noteworthy");

  foreach(volume in volumes) {
    choreographer.volumes[volume.targetname] = volume;
  }

  level.var_9283d76b0bfabcca[noteworthy] = choreographer;
  choreographer thread function_91250540a257b285("free_ai_killed");
  choreographer thread function_49e7a298cd8821cc("free_ai_assigned");
  return choreographer;
}

function function_f3c3a2122b0fe598(noteworthy) {
  if(isDefined(level.var_9283d76b0bfabcca) && isDefined(level.var_9283d76b0bfabcca[noteworthy])) {
    choreographer = level.var_9283d76b0bfabcca[noteworthy];
    choreographer notify("shutdown");

    foreach(volume in choreographer.volumes) {
      volume notify("shutdown");
    }

    level.var_9283d76b0bfabcca = array_remove(level.var_9283d76b0bfabcca, choreographer);
  }

  function_c72495bb15ac272d(noteworthy);
}

function function_95515c853e90472c(noteworthy, ai) {
  function_37605fb617b75716(noteworthy, ai);
}

function function_9cb60ba3067949a3(volumetargetname) {
  volumeent = getEnt(volumetargetname, "targetname");
  assertex(isDefined(volumeent), "^1[AI Choreographer]: volume name '" + volumetargetname + "' could not be found. Cannot initialize volume.");
  assertex(isDefined(volumeent) && volumeent.classname == "info_volume_choreographer", "^1[AI Choreographer]: volume name '" + volumetargetname + "' is not of class type 'info_volume_choreographer'.");

  if(isDefined(volumeent) && volumeent.classname == "info_volume_choreographer") {
    var_9452f76b176ae883 = function_31e1b184571df76e(volumeent);

    for(i = 0; i < 8; i++) {
      stagestruct = function_a612e00addaa15c6(var_9452f76b176ae883, i);
      add_stage(volumeent, stagestruct);
    }

    function_e1a2c1380886b277(volumeent);
  }
}

function function_a7442d9986f00210(volumetargetname) {
  function_9d60ca3450653ce1(volumetargetname, 1);
}

function function_dfc307bd256d27d(volumetargetname) {
  function_9d60ca3450653ce1(volumetargetname, 0);
}

function function_34181ec2298dac40(var_1b1b54049e5e0079, volumeentity, volumetargetname, staticpriority) {
  assertex(array_contains_key(level.var_9283d76b0bfabcca, var_1b1b54049e5e0079), "Tried to add volume '" + volumetargetname + "' to choreographer '" + var_1b1b54049e5e0079 + "' but the choreographer doesn't exist. Did you call init?");
  level.var_9283d76b0bfabcca[var_1b1b54049e5e0079].volumes[volumetargetname] = volumeentity;
  volumeentity.targetname = volumetargetname;
  volumeentity.script_priority = staticpriority;
  function_7a6d3de4027df8e4(var_1b1b54049e5e0079, volumeentity);
}

function function_33a0071b309ada3a() {
  struct = spawnStruct();
  struct.stagename = "";
  struct.priority = 0;
  struct.var_d86443bb4dc09f55 = 0;
  struct.maxai = 0;
  struct.priorityperplayer = 0;
  struct.var_b895bca3d7f637f8 = 1;
  struct.var_8bd784bab1c5be5 = 0;
  struct.stealthgroup = undefined;
  struct.var_74d506aaf66c3d49 = 0;
  struct.maxreinforcementcooldown = 0;
  struct.var_56e4a813e857bd7d = "none";
  struct.reinforcementlimit = 0;
  struct.var_bcda9a9f65039f12 = 0;
  struct.var_bcb7a49f64dd6d58 = 0;
  struct.hasdefaultvalues = 1;
  return struct;
}

function private function_2a64555627bef58f(struct) {
  if(!isDefined(struct.stagename) || !isDefined(struct.priority) || !isDefined(struct.var_d86443bb4dc09f55) || !isDefined(struct.maxai)) {
    assertmsg("Tried to add stage without required parameters: stageName, priority, minAI, maxAI.");
    return;
  }

  if(istrue(struct.hasdefaultvalues)) {
    return;
  }

  if(!isDefined(struct.priorityperplayer)) {
    struct.priorityperplayer = 0;
  }

  if(!isDefined(struct.var_b895bca3d7f637f8)) {
    struct.var_b895bca3d7f637f8 = 1;
  }

  if(!isDefined(struct.var_8bd784bab1c5be5)) {
    struct.var_8bd784bab1c5be5 = 0;
  }

  if(!isDefined(struct.stealthgroup)) {
    struct.stealthgroup = undefined;
  }

  if(!isDefined(struct.var_74d506aaf66c3d49)) {
    struct.var_74d506aaf66c3d49 = 0;
  }

  if(!isDefined(struct.maxreinforcementcooldown)) {
    struct.maxreinforcementcooldown = 0;
  }

  if(!isDefined(struct.var_56e4a813e857bd7d)) {
    struct.var_56e4a813e857bd7d = "none";
  }

  if(!isDefined(struct.reinforcementlimit)) {
    struct.reinforcementlimit = 0;
  }

  if(!isDefined(struct.var_bcda9a9f65039f12)) {
    struct.var_bcda9a9f65039f12 = 0;
  }

  if(!isDefined(struct.var_bcb7a49f64dd6d58)) {
    struct.var_bcb7a49f64dd6d58 = 0;
  }
}

function function_522de4e0b6e1fe88(volumetargetname, stagestruct) {
  function_2a64555627bef58f(stagestruct);
  function_3766773616a64eac(volumetargetname, stagestruct.stagename, stagestruct.priority, stagestruct.var_d86443bb4dc09f55, stagestruct.maxai, stagestruct.priorityperplayer, stagestruct.var_b895bca3d7f637f8, stagestruct.var_8bd784bab1c5be5, stagestruct.stealthgroup, stagestruct.var_74d506aaf66c3d49, stagestruct.maxreinforcementcooldown, stagestruct.var_56e4a813e857bd7d, stagestruct.reinforcementlimit, stagestruct.var_bcda9a9f65039f12, stagestruct.var_bcb7a49f64dd6d58);
}

function function_e1a2c1380886b277(volume) {
  volume.var_3e74f4416e413e01 = [];
  volume thread function_49e7a298cd8821cc("volume_assigned_ai");
  volume thread function_91250540a257b285("volume_ai_killed");
  volume thread function_2125e0704a40354b("volume_ai_minimized");
  volume thread function_2125e0704a40354b("volume_ai_cleared");
  volume thread function_2125e0704a40354b("volume_hit_reinforce_limit");
}

function function_9da53e82db41950b(debuglevel, noteworthy, volumetargetname) {
  if(!isDefined(debuglevel) && !isDefined(noteworthy) && !isDefined(volumetargetname)) {
    return;
  }

  debugcommand = "<dev string:x1c>";

  if(isDefined(debuglevel)) {
    debugcommand += "<dev string:x1d>" + debuglevel;
  }

  if(isDefined(noteworthy)) {
    debugcommand = ter_op(debugcommand.size > 0, debugcommand + "<dev string:x34>", debugcommand);
    debugcommand += "<dev string:x37>" + noteworthy;
  }

  if(isDefined(volumetargetname)) {
    debugcommand = ter_op(debugcommand.size > 0, debugcommand + "<dev string:x34>", debugcommand);
    debugcommand += "<dev string:x52>" + volumetargetname;
  }

  adddebugcommand(debugcommand);
}

function function_c627f4f5ad3d65c1(type, function) {
  if(!isDefined(self.var_3e74f4416e413e01)) {
    assertmsg("Tried to add callback to " + self + ", but callbacks have not been initialised.");
    return;
  }

  if(!array_contains_key(self.var_3e74f4416e413e01, type)) {
    assertmsg("Invalid choreographer callback type '" + type + "'");
    return;
  }

  self.var_3e74f4416e413e01[type] = array_add(self.var_3e74f4416e413e01[type], function);
}

function private function_31e1b184571df76e(volumeent) {
  var_9452f76b176ae883 = spawnStruct();
  var_9452f76b176ae883.priority = [volumeent.var_bf0b0b944c5705c6, volumeent.var_40ab8ca5e6a9d851, volumeent.var_75c00ebf560f54c, volumeent.var_a6a83d4cfa022f1f, volumeent.var_5020aa3fd7320d52, volumeent.var_33a7b5d723c21d8d, volumeent.var_c6fe2f9f38346bb8, volumeent.var_5f1a066d7e6988db];
  var_9452f76b176ae883.var_d86443bb4dc09f55 = [volumeent.var_4e4a50551dfcaac5, volumeent.var_63290ccd7022114e, volumeent.var_a2fe792e9d5f51ff, volumeent.var_5b3e7d7305586e68, volumeent.var_47b4360713236389, volumeent.var_355dae6742623592, volumeent.var_3d3973428284e3d3, volumeent.var_d55f46487357817c];
  var_9452f76b176ae883.maxai = [volumeent.var_a77b851ffa0c9ddb, volumeent.var_550a13855eddd608, volumeent.var_70565658b4aa9c51, volumeent.var_36eaa2488464694e, volumeent.var_7aa7972c3af51447, volumeent.var_230b08a771ed7dc4, volumeent.var_60735e6d0242685d, volumeent.var_2821aa5cd332d91a];
  var_9452f76b176ae883.priorityperplayer = [volumeent.var_7e1875b56b2b852e, volumeent.var_ee942922d642b4ab, volumeent.var_94d54bfa388e01e0, volumeent.var_3d1eb4c45872b33d, volumeent.var_f54f0f38204e215a, volumeent.var_f6db7ad7116f5a37, volumeent.var_c86a1fa37ed2e72c, volumeent.var_cb68129b13f2da89];
  var_9452f76b176ae883.var_b895bca3d7f637f8 = [volumeent.var_85c88f59d0341dd4, volumeent.var_c6d5f196255a8879, volumeent.var_ca86c14747c5571e, volumeent.var_f7cb3f71f87f5273, volumeent.var_f83717200be3c858, volumeent.var_7a51837db6bf6ead, volumeent.var_89619be125d04882, volumeent.var_59ad913053e66bd7];
  var_9452f76b176ae883.var_8bd784bab1c5be5 = [volumeent.var_4d8a7a79fd5c80b, volumeent.var_433b47bbeb556c64, volumeent.var_cd4323a96263691d, volumeent.var_e5cd194b4f4152e6, volumeent.var_6b1658cb419d1567, volumeent.var_1c74d59e863383d0, volumeent.var_83ba703ce5c1ee09, volumeent.var_4a64ab742e5acca2];
  var_9452f76b176ae883.stealthgroups = [volumeent.var_4cce8d25eed3e560, volumeent.var_3928040df31a9887, volumeent.var_5f1fd7a67e19c0e2, volumeent.var_fd179a2f9b6de709, volumeent.var_7f9f29924d542104, volumeent.var_2c16a193b89287bb, volumeent.var_48e44e35249b0406, volumeent.var_bd74219a4d1afbed];
  var_9452f76b176ae883.var_74d506aaf66c3d49 = [volumeent.var_f522d34eb4bab628, volumeent.var_22dfaf0454c6dcb3, volumeent.var_28556691e1e80bfa, volumeent.var_6fbb90445023ddad, volumeent.var_da635cc8b2d2ae04, volumeent.var_1967762236746a2f, volumeent.var_46d221bee15f1e46, volumeent.var_1c13f480789772e9];
  var_9452f76b176ae883.maxreinforcementcooldown = [volumeent.var_e8218633cb8574ce, volumeent.var_f5ac32375c21160d, volumeent.var_d80aa4ebb3fcd6c, volumeent.var_dabc60631000b4b3, volumeent.var_53c45d6a31f99f62, volumeent.var_ea049bcf4bf1e791, volumeent.var_f43cddb88f56b600, volumeent.var_506b32ade56bf817];
  var_9452f76b176ae883.var_56e4a813e857bd7d = [volumeent.var_7f1848195465f938, volumeent.var_cb99f4f3f1f67c8f, volumeent.var_2040e22700f21b7e, volumeent.var_9fbf2e29cddea965, volumeent.var_71544301a22a64e4, volumeent.var_ef7d9137c8cbe0ab, volumeent.var_1865e30c655424a, volumeent.var_9f5e8ccf93498551];
  var_9452f76b176ae883.reinforcementlimit = [volumeent.var_32444206aa4fb1cf, volumeent.var_30d64d91f9e79692, volumeent.var_11d3e6ed76430415, volumeent.var_3c3f9bdb16982200, volumeent.var_d419683921d11b7b, volumeent.var_56cb45e0b2146c3e, volumeent.var_e10054cf5cf1e6b1, volumeent.var_8572b18c80a37b9c];
  var_9452f76b176ae883.var_36911c475270c536 = [volumeent.var_9a3725bb74947538, volumeent.var_8cc4cf92c74942d7, volumeent.var_76fa16a61d02f142, volumeent.var_bda1fbc2c05ec889, volumeent.var_426860f30bd4a7f4, volumeent.var_84b1cabbc3941e03, volumeent.var_98e5519b52f2d94e, volumeent.var_f1e85711f0bb67d5];
  var_9452f76b176ae883.var_36b40e475296ee24 = [volumeent.var_9a5a3bbb74baed52, volumeent.var_8ce7dd92c76fa959, volumeent.var_76d700a61cdc7928, volumeent.var_bd7eedc2c0386207, volumeent.var_428b4ef30bfac816, volumeent.var_84d4c0bbc3ba4fbd, volumeent.var_98c1439b52ca3fcc, volumeent.var_f20b4111f0e17f2b];
  var_9452f76b176ae883.name = [volumeent.var_821d3b3bb42b8e99, volumeent.var_1da4533fcc0f47ce, volumeent.var_4a34005e84ab659f, volumeent.var_f1d9fa5e49a143d4, volumeent.var_76bd52d802f08ccd, volumeent.var_a89a3e8ca5cb5f02, volumeent.var_edbfc12c4214dc43, volumeent.var_137b7b36a53262b8];
  return var_9452f76b176ae883;
}

function private function_a612e00addaa15c6(var_9452f76b176ae883, stageindex) {
  stagestruct = spawnStruct();
  stagestruct.index = stageindex + 1;
  stagestruct.priority = var_9452f76b176ae883.priority[stageindex];
  stagestruct.var_d86443bb4dc09f55 = var_9452f76b176ae883.var_d86443bb4dc09f55[stageindex];
  stagestruct.maxai = var_9452f76b176ae883.maxai[stageindex];
  stagestruct.priorityperplayer = var_9452f76b176ae883.priorityperplayer[stageindex];
  stagestruct.var_b895bca3d7f637f8 = var_9452f76b176ae883.var_b895bca3d7f637f8[stageindex];
  stagestruct.var_8bd784bab1c5be5 = var_9452f76b176ae883.var_8bd784bab1c5be5[stageindex];
  stagestruct.stealthgroup = var_9452f76b176ae883.stealthgroups[stageindex];
  stagestruct.var_74d506aaf66c3d49 = var_9452f76b176ae883.var_74d506aaf66c3d49[stageindex];
  stagestruct.maxreinforcementcooldown = var_9452f76b176ae883.maxreinforcementcooldown[stageindex];
  stagestruct.var_56e4a813e857bd7d = var_9452f76b176ae883.var_56e4a813e857bd7d[stageindex];
  stagestruct.reinforcementlimit = var_9452f76b176ae883.reinforcementlimit[stageindex];
  stagestruct.var_36911c475270c536 = var_9452f76b176ae883.var_36911c475270c536[stageindex];
  stagestruct.var_36b40e475296ee24 = var_9452f76b176ae883.var_36b40e475296ee24[stageindex];
  stagestruct.name = var_9452f76b176ae883.name[stageindex];

  if(isDefined(stagestruct.stealthgroup) && stagestruct.stealthgroup == "") {
    stagestruct.stealthgroup = undefined;
  }

  if(!isDefined(stagestruct.var_56e4a813e857bd7d)) {
    stagestruct.var_56e4a813e857bd7d = "none";
  }

  if(!isDefined(stagestruct.var_36911c475270c536)) {
    stagestruct.var_36911c475270c536 = 0;
  }

  if(!isDefined(stagestruct.var_36b40e475296ee24)) {
    stagestruct.var_36b40e475296ee24 = 0;
  }

  stagestruct.var_582685fd005f7229 = isDefined(stagestruct.priority) && isDefined(stagestruct.var_d86443bb4dc09f55) && isDefined(stagestruct.maxai) && isDefined(stagestruct.priorityperplayer) && isDefined(stagestruct.var_b895bca3d7f637f8) && isDefined(stagestruct.var_8bd784bab1c5be5) && isDefined(stagestruct.var_74d506aaf66c3d49) && isDefined(stagestruct.maxreinforcementcooldown) && isDefined(stagestruct.var_56e4a813e857bd7d) && isDefined(stagestruct.reinforcementlimit);
  stagestruct.var_9dc417101f3fb9f3 = stagestruct.var_d86443bb4dc09f55 > 0 || stagestruct.maxai > 0;
  stagestruct.isnamed = isDefined(stagestruct.name) && stagestruct.name.size > 0;
  return stagestruct;
}

function private add_stage(volumeent, stagestruct) {
  assertex(stagestruct.var_582685fd005f7229, "^1[AI Choreographer]: " + volumeent.targetname + "' contains invalid stage data for stage index '" + stagestruct.index + "'. Some values are undefined. Radiant should be providing default values for these - see coredev.def.json ('classname': 'info_volume_choreographer)");
  assertex(!(stagestruct.var_9dc417101f3fb9f3 && !stagestruct.isnamed), "^1[AI Choreographer]: " + volumeent.targetname + "' stage index '" + stagestruct.index + "' has non default data BUT does not have a stage name and will therefore not be added. Add a stage name if this stage is intended to be used.");
  assertex(stagestruct.var_d86443bb4dc09f55 <= stagestruct.maxai, "^1[AI Choreographer]: " + volumeent.targetname + "' stage index '" + stagestruct.index + "'s MinAI value is larger than MaxAI");
  assertex(stagestruct.var_74d506aaf66c3d49 <= stagestruct.maxreinforcementcooldown, "^1[AI Choreographer]: " + volumeent.targetname + "' stage index '" + stagestruct.index + "'s MinReinforcementCooldown value is larger than MaxReinforcementCooldown");

  if(stagestruct.isnamed) {
    function_3766773616a64eac(volumeent.targetname, stagestruct.name, stagestruct.priority, stagestruct.var_d86443bb4dc09f55, stagestruct.maxai, stagestruct.priorityperplayer, stagestruct.var_b895bca3d7f637f8, stagestruct.var_8bd784bab1c5be5, stagestruct.stealthgroup, stagestruct.var_74d506aaf66c3d49, stagestruct.maxreinforcementcooldown, stagestruct.var_56e4a813e857bd7d, stagestruct.reinforcementlimit, stagestruct.var_36911c475270c536, stagestruct.var_36b40e475296ee24);
  }
}

function private function_b6c9e72cac5377c5() {
  return isstruct(self);
}

function private function_49e7a298cd8821cc(notifymessage) {
  callon = ter_op(function_b6c9e72cac5377c5(), level, self);
  self.var_3e74f4416e413e01[notifymessage] = [];
  self endon("shutdown");
  level endon("game_ended");

  while(true) {
    callon waittill(notifymessage, assignmentlist, var_1b1b54049e5e0079);

    if(isDefined(var_1b1b54049e5e0079)) {
      if(var_1b1b54049e5e0079 != self.name) {
        continue;
      }
    }

    if(!isDefined(self.var_3e74f4416e413e01[notifymessage])) {
      continue;
    }

    foreach(func in self.var_3e74f4416e413e01[notifymessage]) {
      self[[func]](assignmentlist);
    }

    foreach(assignment in assignmentlist) {
      sourcestring = "<dev string:x6f>";

      if(isDefined(assignment.source_volume)) {
        sourcestring = assignment.source_volume.targetname;
      }

      disabledstring = "<dev string:x1c>";

      if(istrue(assignment.var_a56835088f2e30f9)) {
        disabledstring = "<dev string:x7c>";
      }

      println("<dev string:x99>" + sourcestring + "<dev string:xc1>" + disabledstring);
    }
  }
}

function private test() {
  stagestruct = function_33a0071b309ada3a();
  stagestruct.stagename = "test";
  function_522de4e0b6e1fe88("test", stagestruct);
}

function private function_91250540a257b285(notifymessage) {
  callon = ter_op(function_b6c9e72cac5377c5(), level, self);
  self.var_3e74f4416e413e01[notifymessage] = [];
  self endon("shutdown");
  level endon("game_ended");

  while(true) {
    callon waittill(notifymessage, entitylist, var_1b1b54049e5e0079);

    if(isDefined(var_1b1b54049e5e0079)) {
      if(var_1b1b54049e5e0079 != self.name) {
        continue;
      }
    }

    if(!isDefined(self.var_3e74f4416e413e01[notifymessage])) {
      continue;
    }

    foreach(func in self.var_3e74f4416e413e01[notifymessage]) {
      self[[func]](entitylist);
    }

    println("<dev string:xc3>" + entitylist.size + "<dev string:xda>" + notifymessage);
  }
}

function private function_2125e0704a40354b(notifymessage) {
  callon = ter_op(function_b6c9e72cac5377c5(), level, self);
  self endon("shutdown");
  level endon("game_ended");

  while(true) {
    callon waittill(notifymessage, var_1b1b54049e5e0079);

    if(isDefined(var_1b1b54049e5e0079)) {
      if(var_1b1b54049e5e0079 != self.name) {
        continue;
      }
    }

    if(!isDefined(self.var_3e74f4416e413e01[notifymessage])) {
      continue;
    }

    foreach(func in self.var_3e74f4416e413e01[notifymessage]) {
      self[[func]]();
    }

    println("<dev string:xc3>" + notifymessage);
  }
}

function function_dadf0846a19b2d4b(flagname, oneoff, mode, value) {
  if(ent_flag_exist(flagname)) {
    assertmsg("Tried to reinitialize choreographer reinforcement flag '" + flagname + "' on volume '" + self.targetname + "'");
    return;
  }

  thread function_284da564a2225c39(flagname, oneoff, mode, value);
}

function private function_67bd9b51a7445ace() {
  assert(isDefined(self));
  var_e1f25aa8ee4db062 = isstruct(self);

  if(var_e1f25aa8ee4db062) {
    return function_68d7b95450b67d2a(self.name);
  }

  return self function_4ebcb5bee3112344();
}

function private function_284da564a2225c39(flagname, oneoff, mode, value) {
  self endon("shutdown");
  level endon("game_ended");

  while(true) {
    ent_flag_init(flagname);

    switch (mode) {
      case #"hash_7bb1e6b2cdfe51d4":
        function_46408ccc4843afe5(value);
        break;
      case #"hash_4f89286e3448ad44":
        wait value;
        break;
      case #"hash_43e76e9ca2c4666":
        assert(isfunction(value));

        while(true) {
          aicount = function_67bd9b51a7445ace();
          ready = self[[value]](aicount);

          if(ready) {
            break;
          }

          wait 0.5;
        }

        break;
      default:
        assertmsg("Unknown choreographer reinforcement flag mode: '" + mode + "'");
        return;
    }

    ent_flag_set(flagname);

    if(oneoff) {
      return;
    }

    while(ent_flag(flagname)) {
      wait 0.5;
    }
  }
}

function private function_46408ccc4843afe5(value) {
  while(true) {
    wait 0.5;
    count = function_67bd9b51a7445ace();

    if(count <= value) {
      return;
    }
  }
}