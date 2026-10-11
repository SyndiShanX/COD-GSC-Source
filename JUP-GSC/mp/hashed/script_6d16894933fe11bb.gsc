/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d16894933fe11bb.gsc
*************************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_7e4700be8ab64610;

function findnearbyspawnpointguaranteed(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b) {
  thread function_ad5c3711a54f6d7b(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b);
}

function findnearbyspawnpoint(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b) {
  thread function_ef55cd1da5e48f24(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b);
}

function function_1ccac97aaa70e4cc(var_968be7ac0c885ec6, var_382b807d2ce2bca0, player) {
  return function_ab7db46b3325436(var_968be7ac0c885ec6, var_382b807d2ce2bca0, 0.5, player.origin, player getplayerangles(), cos(60), 16);
}

function function_48d03a548cabbbaa() {
  return createstruct_scoreamountsettings(20, 10, -1, 9, 0, 1, 0, 0, -1, 0, -1);
}

function function_e683a4069caa308a() {
  return createstruct_scoreamountsettings(200, 100, 0, 10, 0, 1, 0, 10000, 0, 1000, 0);
}

function private function_ad5c3711a54f6d7b(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b) {
  findnearbyspawnpoint(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b);
  var_e4592b88c9fe6650 waittill("FindNearbySpawnPoint_DONE", selected_point);

  if(!isDefined(selected_point)) {
    findnearbyspawnpoint(var_c9b964bd35abf3a4.player_origin, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b);
    var_e4592b88c9fe6650 waittill("FindNearbySpawnPoint_DONE", selected_point);
  }

  if(!isDefined(selected_point)) {
    selected_point = var_c9b964bd35abf3a4.player_origin;
  }

  var_e4592b88c9fe6650 notify("FindNearbySpawnPointGuaranteed_DONE", selected_point);
}

function private function_ef55cd1da5e48f24(original_position, search_radius, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_e4592b88c9fe6650, var_7f4854a36ffa1e4b) {
  var_7f4854a36ffa1e4b = default_to(var_7f4854a36ffa1e4b, &function_a86ee9afcab9274b);
  offset_positions = function_677e2d6ea2c4d55a(original_position, search_radius);
  function_6adfab97e68c049a(offset_positions, original_position, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, 2, var_e4592b88c9fe6650);
  scored_positions = undefined;
  var_e4592b88c9fe6650 waittill("AdjustAndScore_DONE", scored_positions);
  selected_position = undefined;

  if(scored_positions.size > 0) {
    var_1da28eb57130d8f2 = function_9f46ef5fb5beed12(scored_positions);
    var_2b3084bcaa7ef2f = [[var_7f4854a36ffa1e4b]](var_1da28eb57130d8f2);

    if(isDefined(var_2b3084bcaa7ef2f)) {
      selected_position = var_2b3084bcaa7ef2f.position;
    }
  }

  var_e4592b88c9fe6650 notify("FindNearbySpawnPoint_DONE", selected_position);

  function_3f5ff1b52f3b134c(selected_position, scored_positions, original_position, var_c9b964bd35abf3a4);
}

function function_6adfab97e68c049a(var_3b42ba940854ed70, var_e08e7fac766e98d3, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_869137a72cd99ed3, var_e4592b88c9fe6650) {
  thread function_2e10b411ead65dcf(var_3b42ba940854ed70, var_e08e7fac766e98d3, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_869137a72cd99ed3, var_e4592b88c9fe6650);
}

function private function_2e10b411ead65dcf(var_3b42ba940854ed70, var_e08e7fac766e98d3, var_c9b964bd35abf3a4, var_9633b54b4a5d18de, var_869137a72cd99ed3, var_e4592b88c9fe6650) {
  scored_positions = [];
  var_194432c419132865 = function_114e5c055b13dacf(var_e08e7fac766e98d3);
  frames_waited = 0;

  if(isDefined(var_194432c419132865)) {
    for(i = 0; i < var_3b42ba940854ed70.size; i++) {
      var_1cea27f9e5a44ca3 = var_3b42ba940854ed70[i];
      scored_position = function_4cca5e4e38f25fac(var_1cea27f9e5a44ca3, var_194432c419132865, var_c9b964bd35abf3a4, var_9633b54b4a5d18de);

      if(isDefined(scored_position)) {
        scored_positions[scored_positions.size] = scored_position;
      }

      if(function_510ad113c8dd1ce4(i, var_3b42ba940854ed70.size, var_869137a72cd99ed3)) {
        frames_waited++;
        waitframe();
      }
    }
  }

  if(frames_waited == 0) {
    waitframe();
  }

  var_e4592b88c9fe6650 notify("AdjustAndScore_DONE", scored_positions);
}

function function_9f46ef5fb5beed12(scored_positions) {
  var_1da28eb57130d8f2 = [];
  highest_score = -1;

  foreach(scored_position in scored_positions) {
    score = scored_position.score;

    if(score == -1) {
      continue;
    }

    if(score > highest_score) {
      var_1da28eb57130d8f2 = [scored_position];
      highest_score = score;
      continue;
    }

    if(score == highest_score) {
      var_1da28eb57130d8f2[var_1da28eb57130d8f2.size] = scored_position;
    }
  }

  return var_1da28eb57130d8f2;
}

function function_a86ee9afcab9274b(var_1da28eb57130d8f2) {
  return utility::array_random(var_1da28eb57130d8f2);
}

function private function_4cca5e4e38f25fac(offset_point, var_194432c419132865, var_c9b964bd35abf3a4, var_9633b54b4a5d18de) {
  if(!isDefined(var_194432c419132865)) {
    println("<dev string:x1c>");
    return undefined;
  }

  var_49cdfab0f4218435 = function_114e5c055b13dacf(offset_point);

  if(!isDefined(var_49cdfab0f4218435)) {
    println("<dev string:x90>");
    return undefined;
  }

  var_2ec1c749a01ca3d2 = score_navtrace(var_194432c419132865, var_49cdfab0f4218435, var_9633b54b4a5d18de.var_5b31ffa29547405, var_9633b54b4a5d18de.var_c230b42df20d3dca);
  var_cb41931239bbd7f4 = drop_to_ground(var_49cdfab0f4218435);

  if(!isDefined(var_cb41931239bbd7f4)) {
    println("<dev string:x102>");
    return undefined;
  }

  var_9ac69cb5fcff4d42 = score_collision(var_cb41931239bbd7f4, var_c9b964bd35abf3a4.var_db0ba21189111548, var_c9b964bd35abf3a4.var_1ac1f65b0e8643c, var_c9b964bd35abf3a4.var_6e82ca28afde6992, var_9633b54b4a5d18de.var_9be5f041f38d955, var_9633b54b4a5d18de.var_23b853d5aebfb28b, var_9633b54b4a5d18de.var_82a1705495f2db3a);
  var_f5111a13515bfbf = function_7aa8da5d39957d0c(var_cb41931239bbd7f4, var_c9b964bd35abf3a4.player_origin, var_c9b964bd35abf3a4.player_angles, var_c9b964bd35abf3a4.player_fov, var_9633b54b4a5d18de.var_88636fbf7ac1c3ca, var_9633b54b4a5d18de.var_f489656c6a6dd615);
  var_7c21da60af113c3d = function_57d93c53afa6f5b0(var_cb41931239bbd7f4, var_c9b964bd35abf3a4.player_origin, var_c9b964bd35abf3a4.player_angles, var_9633b54b4a5d18de.var_bc5573cd02c964e0, var_9633b54b4a5d18de.var_13ba179a7806e4af);
  var_4c419aac2142adea = function_b6777c70bc659ac1(var_cb41931239bbd7f4, var_c9b964bd35abf3a4.player_origin, var_c9b964bd35abf3a4.var_ae35725717d412dc, var_9633b54b4a5d18de.var_9d820040732f2a3a, var_9633b54b4a5d18de.var_9ae7de37d4fa9e25);
  scores = [var_2ec1c749a01ca3d2.score, var_9ac69cb5fcff4d42.score, var_f5111a13515bfbf.score, var_7c21da60af113c3d.score, var_4c419aac2142adea.score];
  total_score = function_7b1103bf742c213f(scores);
  scored_position = function_42856ccaccadb424(var_cb41931239bbd7f4, total_score, var_2ec1c749a01ca3d2.computed_data, var_9ac69cb5fcff4d42.computed_data, var_4c419aac2142adea.computed_data);
  return scored_position;
}

function function_ab7db46b3325436(var_db0ba21189111548, var_1ac1f65b0e8643c, var_6e82ca28afde6992, player_origin, player_angles, player_fov, var_ae35725717d412dc) {
  return {
    #var_ae35725717d412dc: var_ae35725717d412dc, #player_fov: player_fov, #player_angles: player_angles, #player_origin: player_origin, #var_6e82ca28afde6992: var_6e82ca28afde6992, #var_1ac1f65b0e8643c: var_1ac1f65b0e8643c, #var_db0ba21189111548: var_db0ba21189111548
  };
}

function private createstruct_scoreamountsettings(var_9be5f041f38d955, var_23b853d5aebfb28b, var_82a1705495f2db3a, var_88636fbf7ac1c3ca, var_f489656c6a6dd615, var_bc5573cd02c964e0, var_13ba179a7806e4af, var_5b31ffa29547405, var_c230b42df20d3dca, var_9d820040732f2a3a, var_9ae7de37d4fa9e25) {
  return {
    #var_9ae7de37d4fa9e25: var_9ae7de37d4fa9e25, #var_9d820040732f2a3a: var_9d820040732f2a3a, #var_c230b42df20d3dca: var_c230b42df20d3dca, #var_5b31ffa29547405: var_5b31ffa29547405, #var_13ba179a7806e4af: var_13ba179a7806e4af, #var_bc5573cd02c964e0: var_bc5573cd02c964e0, #var_f489656c6a6dd615: var_f489656c6a6dd615, #var_88636fbf7ac1c3ca: var_88636fbf7ac1c3ca, #var_82a1705495f2db3a: var_82a1705495f2db3a, #var_23b853d5aebfb28b: var_23b853d5aebfb28b, #var_9be5f041f38d955: var_9be5f041f38d955
  };
}

function private function_a85eeeeccebdd928(score, computed_data) {
  return {
    #computed_data: computed_data, #score: score
  };
}

function private function_42856ccaccadb424(position, score, var_5e2580ae7a0e3a9c, var_ddc70164cdcb7b7f, var_a11c8a0833df22ac) {
  return {
    #var_a11c8a0833df22ac: var_a11c8a0833df22ac, #var_ddc70164cdcb7b7f: var_ddc70164cdcb7b7f, #var_5e2580ae7a0e3a9c: var_5e2580ae7a0e3a9c, #score: score, #position: position
  };
}

function private score_navtrace(position_from, position_to, var_c1d0b2648a9309f6, var_790d9b119308194f) {
  score = var_790d9b119308194f;
  navtrace_result = navtrace(position_from, position_to, undefined, 1);

  if(!isDefined(navtrace_result)) {
    score = var_c1d0b2648a9309f6;
  } else {
    fraction = navtrace_result["fraction"];

    if(fraction > 0.95) {
      score = var_c1d0b2648a9309f6;
    }
  }

  return function_a85eeeeccebdd928(score, navtrace_result);
}

function private score_collision(position, var_db0ba21189111548, var_1ac1f65b0e8643c, var_6e82ca28afde6992, var_c1d0b2648a9309f6, var_3c48b578ae1d1520, var_790d9b119308194f) {
  score = var_790d9b119308194f;
  content = 0;
  content += scripts\engine\trace::create_world_contents();
  content += scripts\engine\trace::create_vehicle_contents();
  var_4dbebdf7827031b1 = position + (0, 0, var_1ac1f65b0e8643c);
  var_cb568fc0f8e6c6e = scripts\engine\trace::sphere_trace(var_4dbebdf7827031b1, var_4dbebdf7827031b1, var_db0ba21189111548, undefined, content, 1, 1);

  if(!isDefined(var_cb568fc0f8e6c6e) || var_cb568fc0f8e6c6e["fraction"] == 1) {
    score = var_c1d0b2648a9309f6;
  } else {
    hit_position = var_cb568fc0f8e6c6e["position"];
    var_a5fea26ca8831505 = function_cf89fb8c92ceda52(position, var_db0ba21189111548, hit_position);

    if(var_a5fea26ca8831505 > 0.95) {
      score = var_c1d0b2648a9309f6;
    } else if(var_a5fea26ca8831505 > var_6e82ca28afde6992) {
      score = var_3c48b578ae1d1520;
    }
  }

  return function_a85eeeeccebdd928(score, var_cb568fc0f8e6c6e);
}

function private function_7aa8da5d39957d0c(position, player_origin, player_angles, fov, var_c1d0b2648a9309f6, var_790d9b119308194f) {
  score = var_790d9b119308194f;
  is_within_fov = utility::within_fov(player_origin, player_angles, position, fov);

  if(is_within_fov) {
    score = var_c1d0b2648a9309f6;
  }

  return function_a85eeeeccebdd928(score);
}

function private function_57d93c53afa6f5b0(position, player_origin, player_angles, var_c1d0b2648a9309f6, var_790d9b119308194f) {
  return function_7aa8da5d39957d0c(position, player_origin, player_angles, 0, var_c1d0b2648a9309f6, var_790d9b119308194f);
}

function private function_b6777c70bc659ac1(position, player_origin, var_ae35725717d412dc, var_c1d0b2648a9309f6, var_790d9b119308194f) {
  score = var_790d9b119308194f;
  var_a11c8a0833df22ac = distance2d(position, player_origin);

  if(var_a11c8a0833df22ac > var_ae35725717d412dc) {
    score = var_c1d0b2648a9309f6;
  }

  return function_a85eeeeccebdd928(score, var_a11c8a0833df22ac);
}

function function_677e2d6ea2c4d55a(position, offset_radius) {
  offset_positions = [];
  offsets = function_277a001b9d96b876(offset_radius);

  foreach(offset in offsets) {
    offset_positions[offset_positions.size] = position + offset;
  }

  return offset_positions;
}

function function_277a001b9d96b876(radius) {
  offsets = function_88928c61c11ea048();

  for(i = 0; i < offsets.size; i++) {
    offsets[i] *= radius;
  }

  return offsets;
}

function private function_114e5c055b13dacf(position) {
  var_f4f2f1078a1998f6 = 0;
  ground_pos = drop_to_ground(position);

  if(!isDefined(ground_pos)) {
    return ground_pos;
  }

  var_9687e9878f9da949 = getclosestpointonnavmesh(position, undefined, undefined, undefined, var_f4f2f1078a1998f6);
  return var_9687e9878f9da949;
}

function private drop_to_ground(position) {
  return getgroundposition(position, 1);
}

function private function_510ad113c8dd1ce4(position_index, var_64e48a85b0d8d307, var_869137a72cd99ed3) {
  return position_index != 0 && position_index != var_64e48a85b0d8d307 - 1 && position_index % var_869137a72cd99ed3 == 0;
}

function private function_7b1103bf742c213f(scores) {
  total_score = 0;

  foreach(score in scores) {
    if(score == -1) {
      return -1;
    }

    total_score += score;
  }

  return total_score;
}

function private function_cf89fb8c92ceda52(sphere_origin, sphere_radius, var_de8c49cc6b3b064f) {
  hit_distance = distance2d(sphere_origin, var_de8c49cc6b3b064f);
  return hit_distance / float(sphere_radius);
}

function private function_88928c61c11ea048() {
  var_b670d68601bacc13 = level.var_635d51cc5daf677b;

  if(!isDefined(var_b670d68601bacc13)) {
    var_b670d68601bacc13 = [];
    cos_45 = cos(45);
    sin_45 = sin(45);
    var_b670d68601bacc13[0] = (1, 0, 0);
    var_b670d68601bacc13[1] = (-1, 0, 0);
    var_b670d68601bacc13[2] = (0, 1, 0);
    var_b670d68601bacc13[3] = (0, -1, 0);
    var_b670d68601bacc13[4] = (cos_45, sin_45, 0);
    var_b670d68601bacc13[5] = (cos_45 * -1, sin_45, 0);
    var_b670d68601bacc13[6] = (cos_45, sin_45 * -1, 0);
    var_b670d68601bacc13[7] = (cos_45 * -1, sin_45 * -1, 0);
    level.var_635d51cc5daf677b = var_b670d68601bacc13;
  }

  return var_b670d68601bacc13;
}

function private function_3f5ff1b52f3b134c(selected_position, scored_positions, var_b9f9b692fc3709e8, var_c9b964bd35abf3a4) {
  var_ceb612692dd7ca1d = getdvarint(@ "hash_eff5e2218caf8354", 0);

  if(var_ceb612692dd7ca1d) {
    var_8413510412a61b93 = getdvarint(@ "hash_1ed3e490fb83235e", 999);
    function_4be40ababbe96dc7(selected_position, scored_positions, var_b9f9b692fc3709e8, var_c9b964bd35abf3a4, var_8413510412a61b93);
  }
}

function private function_4be40ababbe96dc7(selected_position, scored_positions, var_b9f9b692fc3709e8, var_c9b964bd35abf3a4, duration) {
  var_7b08892f10fff3b4 = (0, 255, 0);
  var_44abc2142cbaf028 = (0, 100, 100);
  var_eb66e42880eb990b = (0, 0, 255);
  var_37c903fe9120a5d8 = (255, 0, 255);
  var_234455c2ac03c8d = (255, 0, 0);
  var_9017e37442714912 = (255, 255, 0);
  debug_draw(var_b9f9b692fc3709e8, 8, var_44abc2142cbaf028, duration, "<dev string:x186>", undefined, 0.5);
  debug_draw(function_114e5c055b13dacf(var_b9f9b692fc3709e8), 6, var_eb66e42880eb990b, duration, "<dev string:x19e>", 0, 0.5);

  foreach(scored_position in scored_positions) {
    if(isDefined(selected_position) && scored_position.position == selected_position) {
      color = var_7b08892f10fff3b4;
    } else if(scored_position.score == -1) {
      color = var_234455c2ac03c8d;
    } else {
      color = var_37c903fe9120a5d8;
    }

    debug_draw(scored_position.position + (0, 0, var_c9b964bd35abf3a4.var_1ac1f65b0e8643c), var_c9b964bd35abf3a4.var_db0ba21189111548, color, duration, utility::string(scored_position.score));
    var_cb568fc0f8e6c6e = scored_position.var_ddc70164cdcb7b7f;

    if(isDefined(var_cb568fc0f8e6c6e) && var_cb568fc0f8e6c6e["<dev string:x1c9>"] < 1) {
      sphere(var_cb568fc0f8e6c6e["<dev string:x1d5>"], 3, var_9017e37442714912, 0, int(duration));
    }
  }
}

function private debug_draw(pos, radius, color, duration, optional_text, var_a3c3604324011b66, var_e42f8c5f7c385ecc) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  if(!isDefined(var_a3c3604324011b66)) {
    var_a3c3604324011b66 = 30;
  }

  if(!isDefined(var_e42f8c5f7c385ecc)) {
    var_e42f8c5f7c385ecc = 1;
  }

  if(!isDefined(pos)) {
    return;
  }

  duration = int(duration);
  sphere(pos, radius, color, 0, duration);
  sphere(pos, 3, undefined, 1, duration);

  if(isDefined(optional_text)) {
    print3d(pos + (0, 0, var_a3c3604324011b66), optional_text, (255, 255, 255), 1, var_e42f8c5f7c385ecc, duration, 1);
  }
}

# /