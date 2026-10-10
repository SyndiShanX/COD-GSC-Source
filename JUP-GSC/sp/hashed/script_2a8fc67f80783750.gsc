/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2a8fc67f80783750.gsc
*************************************************/

#using script_2a8fc67f80783750;
#using scripts\cp\cp_objectives;
#using scripts\cp\damagefeedback;
#using scripts\cp\equipment;
#using scripts\cp\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_ea5a853f2ff420bc;

function main() {
  if(function_240f7f4e57340e8f() && level.mapname != "cp_jup_mechanics") {
    assertmsg("Laser Trap Arrays no longer supported in Dungeons; use scriptscplaser_trapslaser_traps::setup_defusable_laser_turret_trap_array instead");
    return;
  }

  level thread function_1817b92de68a78aa();
}

function function_1817b92de68a78aa() {
  level endon("game_ended");
  wait 1;
  flag_wait("create_script_initialized");
  wait 1;
  flag_init("laser_arrays_setup");
  wait 10;
  var_8164f8b29cdabf6a = getStructArray("laserarray_origin", "script_noteworthy");
  levels_deep = 0;

  foreach(var_eabb894a8cad73c1 in var_8164f8b29cdabf6a) {
    var_eabb894a8cad73c1.var_99dc01209965e399 = [];
    function_1d5ba7acbb276a26(var_eabb894a8cad73c1, levels_deep, var_eabb894a8cad73c1);
  }

  level.var_5933d8f675e4273d = var_8164f8b29cdabf6a;

  foreach(laser_array in level.var_5933d8f675e4273d) {
    function_8aec75a4411844ba(laser_array);
  }

  flag_set("laser_arrays_setup");
}

function function_1d5ba7acbb276a26(var_eabb894a8cad73c1, levels_deep, parent_struct) {
  levels_deep++;

  end_letter = debug_letter(levels_deep);
  var_340a40fe8ade1007 = debug_letter(levels_deep + 1);

  if(levels_deep == 1) {
    var_eabb894a8cad73c1.levels_deep = 0;
    parent_struct.var_99dc01209965e399[parent_struct.var_99dc01209965e399.size] = var_eabb894a8cad73c1;
  }

  if(isDefined(var_eabb894a8cad73c1.script_parameters)) {
    var_eabb894a8cad73c1.var_55cc71192b8f1931 = strtok(var_eabb894a8cad73c1.script_parameters, ",");
  } else {
    var_eabb894a8cad73c1.var_55cc71192b8f1931 = [];
  }

  if(isDefined(var_eabb894a8cad73c1.target)) {
    end_structs = getStructArray(var_eabb894a8cad73c1.target, "targetname");

    foreach(end_struct in end_structs) {
      if(end_struct.script_noteworthy == "laserarray_target") {
        end_struct.levels_deep = levels_deep;
        parent_struct.var_99dc01209965e399[parent_struct.var_99dc01209965e399.size] = end_struct;
        function_1d5ba7acbb276a26(end_struct, levels_deep, parent_struct);
        continue;
      }

      if(end_struct.script_noteworthy == "laserarray_defuse") {
        parent_struct.defuse_struct = end_struct;
        level thread function_271e34074b8fe73a(parent_struct.defuse_struct, parent_struct);
        continue;
      }

      if(end_struct.script_noteworthy == "laserarray_sweeper_start") {
        var_eabb894a8cad73c1.sweep_start = end_struct;
      }
    }
  }

  if(isDefined(var_eabb894a8cad73c1.script_parameters)) {
    if(var_eabb894a8cad73c1.script_parameters == "visible") {
      var_eabb894a8cad73c1.laser_visibility = "visible";
    } else if(var_eabb894a8cad73c1.script_parameters == "nvg") {
      var_eabb894a8cad73c1.laser_visibility = "nvg";
    } else if(var_eabb894a8cad73c1.script_parameters == "thermal") {
      var_eabb894a8cad73c1.laser_visibility = "thermal";
    }

    return;
  }

  var_eabb894a8cad73c1.laser_visibility = "nvg";
}

function function_271e34074b8fe73a(defuse_struct, parent_struct) {
  level endon("game_ended");

  if(!isDefined(defuse_struct.angles)) {
    defuse_struct.angles = (0, 0, 0);
  }

  if(!isDefined(defuse_struct.parent_structs)) {
    defuse_struct.parent_structs = [];
  }

  if(!isDefined(array_find(defuse_struct.parent_structs, parent_struct))) {
    defuse_struct.parent_structs[defuse_struct.parent_structs.size] = parent_struct;
  }

  if(isDefined(defuse_struct.hint_obj)) {
    return;
  }

  defuse_struct.hint_obj = spawn("script_model", defuse_struct.origin);
  defuse_struct.hint_obj.angles = defuse_struct.angles;
  defuse_struct.hint_obj setModel("offhand_2h_wm_c4_v0");
  defuse_struct.hint_obj.targetname = "lasertraparay_defuse";
  defuse_struct.hint_obj.parent = defuse_struct;

  if(isDefined(defuse_struct.target)) {
    defuse_struct.target_structs = getStructArray(defuse_struct.target, "targetname");

    foreach(target in defuse_struct.target_structs) {
      target.hint_obj = defuse_struct.hint_obj;
      target.main_parent = defuse_struct;
    }
  }

  defuse_struct.hint_obj makeusable();
  hintstring = &"COOP_GAME_PLAY/DISABLE_TRAP";
  defuse_struct.hint_obj setHintString(hintstring);
  defuse_struct.hint_obj setCursorHint("HINT_BUTTON");
  defuse_struct.hint_obj sethintdisplayrange(128);
  defuse_struct.hint_obj sethintdisplayfov(80);
  defuse_struct.hint_obj setuserange(48);
  defuse_struct.hint_obj setusefov(50);

  if(array_contains(parent_struct.var_55cc71192b8f1931, "obstruction_check")) {
    defuse_struct.hint_obj sethintonobstruction("hide");
  } else {
    defuse_struct.hint_obj sethintonobstruction("show");
  }

  defuse_struct.hint_obj setuseholdduration("duration_medium");
  defuse_struct.hint_obj thread namespace_3bbec94305f740f0::watch_for_damage_on_trap(parent_struct);

  while(true) {
    defuse_struct.hint_obj waittill("trigger", player);

    if(isPlayer(player)) {
      defuse_struct.hint_obj makeunusable();
      level thread function_91bdcd29d2bcb28(defuse_struct, player);
      player playlocalsound("grenade_pickup");
      thread function_6ac084564c26345f(defuse_struct);
      return;
    }
  }
}

function function_6ac084564c26345f(defuse_struct) {
  if(isDefined(defuse_struct.target_structs)) {
    foreach(target_struct in defuse_struct.target_structs) {
      target_struct notify("laser_destroyed");
    }
  }

  foreach(var_d4d884b520d4c4fe in defuse_struct.parent_structs) {
    var_d4d884b520d4c4fe notify("laser_destroyed");
  }

  defuse_struct.hint_obj delete();
}

function function_91bdcd29d2bcb28(defuse_struct, player) {
  level endon("game_ended");
  gren = player launchgrenade("jup_c4_mp", defuse_struct.origin, (0, 0, 0), 120);
  gren setentityowner(undefined);
  gren waittill("missile_stuck");
  pickupent = spawnStruct();
  pickupent.scriptablename = "brloot_offhand_c4";
  pickupent.equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  pickupent.maxcount = player scripts\cp_mp\equipment::getequipmentmaxammo(pickupent.equipname);
  pickupent.count = 1;
  pickupent.origin = defuse_struct.origin;
  pickupent.var_54ac5c5126489388 = 1;
  gren thread scripts\cp\equipment::makeexplosiveusabletag("tag_use", 1, undefined, pickupent);
}

function function_8aec75a4411844ba(laser_array) {
  if(!isDefined(laser_array.var_99dc01209965e399)) {
    return;
  }

  foreach(var_9e5dfd7e4e61b618 in laser_array.var_99dc01209965e399) {
    function_bdc3651f32de01c1(var_9e5dfd7e4e61b618);
  }

  for(i = laser_array.var_99dc01209965e399.size; i > 1; i--) {
    function_bb90868bcdd97ee9(laser_array.var_99dc01209965e399[i - 1], laser_array.var_99dc01209965e399[i - 2], laser_array.laser_visibility);
    level thread function_c415744d393290cd(laser_array.var_99dc01209965e399[i - 1].var_c6807cafb4bf3f2a, laser_array.var_99dc01209965e399[i - 2].var_c6807cafb4bf3f2a);
  }

  foreach(var_9e5dfd7e4e61b618 in laser_array.var_99dc01209965e399) {
    level thread function_e5ce76b6427f7e10(var_9e5dfd7e4e61b618);
    level thread function_d6d69f7ced75c79(var_9e5dfd7e4e61b618, laser_array);
    var_9e5dfd7e4e61b618.laser_array = laser_array;
  }
}

function function_bdc3651f32de01c1(laser_struct) {
  laser_struct.var_c6807cafb4bf3f2a = create_tag_origin(laser_struct.origin, laser_struct);
  laser_struct.var_c6807cafb4bf3f2a.laser_struct = laser_struct;
}

function function_bb90868bcdd97ee9(first_struct, second_struct, laser_visibility) {
  first_struct.fx_thermal_end = spawnfx(level._effect["vfx_laser_burn"], first_struct.var_c6807cafb4bf3f2a.origin);
  triggerfx(first_struct.fx_thermal_end);
  laser_fx = level._effect["vfx_laser_pointer_nvg"];

  if(is_equal(laser_visibility, "thermal")) {
    laser_fx = level._effect["vfx_laser_pointer_thermal"];
  } else if(is_equal(laser_visibility, "visible")) {
    laser_fx = level._effect["vfx_laser_pointer"];
  }

  first_struct.fx_thermal = playfxontagsbetweenclients(laser_fx, first_struct.var_c6807cafb4bf3f2a, "tag_origin", second_struct.var_c6807cafb4bf3f2a, "tag_origin");
}

function create_tag_origin(spawn_pos, var_a56c96b62623c721) {
  tag_origin = spawn("script_model", spawn_pos);
  tag_origin setModel("tag_origin");
  tag_origin thread clean_up_think(tag_origin, var_a56c96b62623c721);
  return tag_origin;
}

function clean_up_think(tag_origin, var_a56c96b62623c721) {
  tag_origin endon("death");
  var_a56c96b62623c721 waittill("death");
  tag_origin delete();
}

function function_e5ce76b6427f7e10(laser_struct) {
  level endon("game_ended");
  flag_wait("laser_arrays_setup");

  if(!isDefined(laser_struct.sweep_start)) {
    return;
  }

  laser_struct.sweep_end = getStruct(laser_struct.sweep_start.target, "targetname");
  assert(isDefined(laser_struct.sweep_start));
  assert(isDefined(laser_struct.sweep_end));

  if(!isDefined(laser_struct.sweep_start) || !isDefined(laser_struct.sweep_end)) {
    return;
  }

  level thread function_bfd6d3c3cb5cf316(laser_struct);
}

function function_bfd6d3c3cb5cf316(var_eabb894a8cad73c1) {
  level endon("game_ended");
  var_eabb894a8cad73c1 endon("laser_destroyed");

  if(isDefined(var_eabb894a8cad73c1.script_delay)) {
    wait var_eabb894a8cad73c1.script_delay;
  }

  if(!isDefined(var_eabb894a8cad73c1.var_c6807cafb4bf3f2a) || !isent(var_eabb894a8cad73c1.var_c6807cafb4bf3f2a)) {
    return;
  }

  traveltime = 5;

  while(true) {
    if(isDefined(var_eabb894a8cad73c1.sweep_start.script_duration)) {
      traveltime = float(var_eabb894a8cad73c1.sweep_start.script_duration);
    }

    var_eabb894a8cad73c1.var_c6807cafb4bf3f2a moveTo(var_eabb894a8cad73c1.sweep_start.origin, traveltime);

    if(isDefined(var_eabb894a8cad73c1.sweep_start.delay) && float(var_eabb894a8cad73c1.sweep_start.delay) > 0) {
      wait traveltime + float(var_eabb894a8cad73c1.sweep_start.delay);
    } else {
      wait traveltime;
    }

    if(isDefined(var_eabb894a8cad73c1.sweep_end.script_duration)) {
      traveltime = float(var_eabb894a8cad73c1.sweep_end.script_duration);
    }

    var_eabb894a8cad73c1.var_c6807cafb4bf3f2a moveTo(var_eabb894a8cad73c1.sweep_end.origin, traveltime);

    if(isDefined(var_eabb894a8cad73c1.sweep_end.delay) && float(var_eabb894a8cad73c1.sweep_end.delay) > 0) {
      wait traveltime + float(var_eabb894a8cad73c1.sweep_end.delay);
      continue;
    }

    wait traveltime;
  }
}

function debug_location(ent) {
  level endon("game_ended");
  ent endon("death");
  color = randomint(1);
  assert(isent(ent));

  if(!isent(ent)) {
    return;
  }

  while(true) {
    print3d(ent.origin, "<dev string:x1c>", (1, 0, color), 1, 0.5, 20, 0);

    wait 0.1;
  }
}

function debug_letter(levels_deep) {
  label = "x";

  switch (levels_deep) {
    case 0:
    case 1:
      label = "A";
      break;
    case 2:
      label = "B";
      break;
    case 3:
      label = "C";
      break;
    case 4:
      label = "D";
      break;
    case 5:
      label = "E";
      break;
    case 6:
      label = "F";
      break;
    case 7:
      label = "G";
      break;
    case 8:
      label = "H";
      break;
    case 9:
      label = "I";
      break;
    case 10:
      label = "J";
      break;
    case 11:
      label = "K";
      break;
    case 12:
      label = "L";
      break;
  }

  return label;
}

function function_c415744d393290cd(start_ent, end_ent) {
  level endon("game_ended");
  start_ent.laser_struct endon("laser_destroyed");
  flag_wait("player_spawned_with_loadout");
  wait 2;
  mindistsq = squared(2048);
  gooddistsq = lengthsquared(start_ent.origin - end_ent.origin);
  var_f295fb91449b386e = gooddistsq * 1.75;

  while(true) {
    if(!any_player_nearby(start_ent.origin, mindistsq)) {
      wait 0.5;
      continue;
    }

    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distancesquared(player.origin, start_ent.origin) > var_f295fb91449b386e) {
        continue;
      }

      if(distancesquared(player.origin, end_ent.origin) > var_f295fb91449b386e) {
        continue;
      }

      var_6d3ab3a23dd14dd7 = ["j_helmet", "j_head", "j_neck", "j_spineupper", "j_spinelower", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_wrist_ri", "j_wrist_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le", "j_ankle_ri", "j_ankle_le", "tag_eye", "tag_origin"];

      if(function_240f7f4e57340e8f()) {
        var_6d3ab3a23dd14dd7 = ["tag_origin", "j_spineupper", "j_spinelower", "j_shoulder_ri", "j_shoulder_le", "j_ankle_ri", "j_ankle_le", "j_knee_ri", "j_knee_le", "j_hip_ri", "j_hip_le"];
        var_42bfa7e980312d72 = vectorfromlinetopoint(start_ent.origin, end_ent.origin, player getEye());
        var_91c0145351e3672 = length(var_42bfa7e980312d72);

        if(function_546bf7abf994cbf1(start_ent, end_ent, player getEye())) {
          level thread function_c8f95e09465a43f6(player, start_ent, end_ent);
          return;
        }
      }

      foreach(tag in var_6d3ab3a23dd14dd7) {
        if(player tagexists(tag)) {
          if(function_546bf7abf994cbf1(start_ent, end_ent, player gettagorigin(tag))) {
            level thread function_c8f95e09465a43f6(player, start_ent, end_ent);
            return;
          }
        }
      }
    }

    waitframe();
  }
}

function function_546bf7abf994cbf1(var_7fb15984f4f0a480, endent, tagorigin) {
  var_b9d548a9b237fc0a = distance(var_7fb15984f4f0a480.origin, endent.origin);
  var_c48d664db8b390ff = distance(var_7fb15984f4f0a480.origin, tagorigin);
  var_517df4767f2986a = distance(endent.origin, tagorigin);

  if(var_c48d664db8b390ff > var_b9d548a9b237fc0a || var_517df4767f2986a > var_b9d548a9b237fc0a) {
    return false;
  }

  var_81127e016b847fdd = vectorfromlinetopoint(var_7fb15984f4f0a480.origin, endent.origin, tagorigin);

  if(length(var_81127e016b847fdd) < 5) {
    return true;
  }

  return false;
}

function function_c8f95e09465a43f6(player, start_ent, end_ent) {
  playFX(level._effect["vfx_laser_destroy"], start_ent.origin);
  playFX(level._effect["vfx_laser_destroy"], end_ent.origin);
  start_ent.laser_struct.var_c6807cafb4bf3f2a playSound("recon_drone_explode");
  level thread function_c5d4cacf993e20e3(start_ent.laser_struct, player);

  if(isDefined(start_ent.laser_struct.laser_array)) {
    if(isDefined(start_ent.laser_struct.laser_array.hint_obj)) {
      if(isDefined(start_ent.laser_struct.laser_array.hint_obj.parent)) {
        function_6ac084564c26345f(start_ent.laser_struct.laser_array.hint_obj.parent);
      }
    }
  }

  start_ent.laser_struct notify("laser_destroyed");
}

function function_c5d4cacf993e20e3(laser_struct, victim, var_ac0ffcd3a4d3ed84) {
  if(isDefined(laser_struct.laser_array.var_99dc01209965e399) && !istrue(var_ac0ffcd3a4d3ed84)) {
    foreach(var_5b26e932474e06f7 in laser_struct.laser_array.var_99dc01209965e399) {
      if(var_5b26e932474e06f7 != laser_struct) {
        level thread function_c5d4cacf993e20e3(var_5b26e932474e06f7, victim, 1);
      }
    }
  }

  if(!isDefined(laser_struct.defuse_struct)) {
    return;
  }

  if(isDefined(victim) && isPlayer(victim)) {
    if(!function_240f7f4e57340e8f()) {
      victim.var_230a3287f9ad2965 = 1;
    }

    victim.shouldskipdeathsshield = 1;
  }

  radiusdamage(laser_struct.defuse_struct.origin, 256, 230, 30, laser_struct.var_c6807cafb4bf3f2a, "MOD_EXPLOSIVE", "frag_grenade_mp");
  level.player notify("laser_trap_exploded");
  playrumbleonposition("grenade_rumble", laser_struct.defuse_struct.origin);
  earthquake(0.45, 0.7, laser_struct.defuse_struct.origin, 800);

  if(isDefined(level.var_2418f6a5c3e407a5)) {
    thread[[level.var_2418f6a5c3e407a5]](laser_struct.defuse_struct.origin);
  }

  if(isDefined(victim) && isPlayer(victim)) {
    victim function_3e2f7fdfd94f71ba(victim);
  }
}

function function_d6d69f7ced75c79(laser_struct, laser_array) {
  level endon("game_ended");
  laser_struct waittill("laser_destroyed");

  foreach(var_5b26e932474e06f7 in laser_array.var_99dc01209965e399) {
    if(var_5b26e932474e06f7 != laser_struct) {
      var_5b26e932474e06f7 notify("laser_destroyed");
    }
  }

  if(isDefined(laser_struct.defuse_struct) && isDefined(laser_struct.defuse_struct.hint_obj)) {
    laser_struct.defuse_struct.hint_obj delete();
  }

  if(isDefined(laser_struct.laser_end_ent_thermal)) {
    laser_struct.laser_end_ent_thermal delete();
  }

  if(isDefined(laser_struct.fx_thermal)) {
    laser_struct.fx_thermal delete();
  }

  if(isDefined(laser_struct.fx_thermal_end)) {
    laser_struct.fx_thermal_end delete();
  }

  if(isDefined(laser_struct.var_c6807cafb4bf3f2a)) {
    laser_struct.var_c6807cafb4bf3f2a delete();
  }

  if(isDefined(laser_struct)) {
    laser_struct = undefined;
  }
}

function watch_for_damage_on_trap(parent_struct) {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self.var_abbaa2fc2b3da347 = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      continue;
    }

    attacker thread scripts\cp\damagefeedback::updatedamagefeedback("hitturret", undefined, damage, 1);
    self.var_abbaa2fc2b3da347++;

    attacker iprintln("<dev string:x1e>");

    self.health = 9999;
    self.maxhealth = 9999;

    if(isPlayer(attacker)) {
      start_ent = parent_struct.var_99dc01209965e399[0].var_c6807cafb4bf3f2a;
      end_ent = parent_struct.var_99dc01209965e399[1].var_c6807cafb4bf3f2a;
      mindistsq = squared(2048);
      gooddistsq = lengthsquared(start_ent.origin - end_ent.origin);
      player = attacker;

      if(distancesquared(attacker.origin, start_ent.origin) > gooddistsq + gooddistsq * 0.25) {
        player = undefined;
      }

      level thread function_c8f95e09465a43f6(player, start_ent, end_ent);
    }
  }
}

function function_3e2f7fdfd94f71ba(player) {
  dir = -1 * anglesToForward(player.angles);
  var_d01387bda9e91e50 = player getvelocity();
  var_adc4b2bf275805c7 = length2d(var_d01387bda9e91e50);

  if(var_adc4b2bf275805c7 == 0) {
    var_adc4b2bf275805c7 = 60;
  }

  if(var_adc4b2bf275805c7 < 60) {
    var_adc4b2bf275805c7 = 60;
  }

  var_e73621f0a50827ac = player getvelocity();
  var_e73621f0a50827ac = (var_e73621f0a50827ac[0], var_e73621f0a50827ac[1], 0);
  var_2fdce9f0da5412e0 = length2d(var_e73621f0a50827ac);

  if(var_2fdce9f0da5412e0 > 0) {
    var_3173030081735e94 = dir * var_adc4b2bf275805c7;
    var_80e3e9c318e99cf1 = var_e73621f0a50827ac + var_3173030081735e94;
    var_2297d1c3903888ed = length2d(var_80e3e9c318e99cf1);

    if(vectordot(var_80e3e9c318e99cf1, var_3173030081735e94) < 0) {
      right = vectorcross((0, 0, 1), dir);

      if(vectordot(right, var_e73621f0a50827ac) > 0) {
        var_2fdce9f0da5412e0 = length2d(var_e73621f0a50827ac);
        var_e73621f0a50827ac = right * var_2fdce9f0da5412e0;
      } else {
        left = right * -1;
        var_2fdce9f0da5412e0 = length2d(var_e73621f0a50827ac);
        var_e73621f0a50827ac = left * var_2fdce9f0da5412e0;
      }

      var_80e3e9c318e99cf1 = var_e73621f0a50827ac + var_3173030081735e94;
      var_adc4b2bf275805c7 = length2d(var_80e3e9c318e99cf1);
    } else {
      if(var_2fdce9f0da5412e0 > var_adc4b2bf275805c7) {
        var_adc4b2bf275805c7 = var_2fdce9f0da5412e0;
      }

      dir = vectorNormalize(var_80e3e9c318e99cf1);
    }
  }

  player knockback(dir, var_adc4b2bf275805c7);
}