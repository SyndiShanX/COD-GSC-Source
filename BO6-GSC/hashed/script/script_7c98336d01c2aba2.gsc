/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7c98336d01c2aba2.gsc
*****************************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_632cf895a7d667a5;

function findnearbyspawnpointguaranteed(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a) {
  thread function_7a5e0b1596feddfe(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a);
}

function findnearbyspawnpoint(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a) {
  thread function_7d220906e19796a5(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a);
}

function function_8c21aa55f6e4f01d(var_8c6a541e9eed9e37, var_55b465dc79684875, player) {
  return function_a83c580adfed17ef(var_8c6a541e9eed9e37, var_55b465dc79684875, 0.5, player.origin, player getplayerangles(), cos(60), 16);
}

function function_7d57ce11714befd7() {
  return createstruct_scoreamountsettings(20, 10, -1, 9, 0, 1, 0, 0, -1, 0, -1);
}

function function_5fab5d5fe6becf6b() {
  return createstruct_scoreamountsettings(200, 100, 0, 10, 0, 1, 0, 10000, 0, 1000, 0);
}

function private function_7a5e0b1596feddfe(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a) {
  findnearbyspawnpoint(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a);
  var_65add5c30ad7773d waittill("\xa9\x94\x1e9\x8e\xbe\xe7\xf2\xb1W>\xb0\\\xb9\xa7@\x810\x856\xfbP\t[m", selected_point);

  if(!isDefined(selected_point)) {
    findnearbyspawnpoint(var_2deedb482a6bbe25.player_origin, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a);
    var_65add5c30ad7773d waittill("\xa9\x94\x1e9\x8e\xbe\xe7\xf2\xb1W>\xb0\\\xb9\xa7@\x810\x856\xfbP\t[m", selected_point);
  }

  if(!isDefined(selected_point)) {
    selected_point = var_2deedb482a6bbe25.player_origin;
  }

  var_65add5c30ad7773d notify("Z\x0e\xc8\x1cL\xdb0\f\x9d1\xba\xde\xffyUdV\xa5\xeb\xeawi\x80\xd2t\xf1\xc6|\xfcV\xc8)\xeds\x9f", selected_point);
}

function private function_7d220906e19796a5(original_position, search_radius, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_65add5c30ad7773d, var_ee72ecc29d3f753a = &function_3eaea3190f20e0aa) {
  offset_positions = function_81a685a0e055e987(original_position, search_radius);
  function_dd866c1a981ab9d3(offset_positions, original_position, var_2deedb482a6bbe25, var_ec2544d2439d856b, 2, var_65add5c30ad7773d);
  scored_positions = undefined;
  var_65add5c30ad7773d waittill("\x93rpD\x9e\xe2\x05\xc4_\xfd\xb7\xc3\x1e\xe2S\xd3\x14S\x8c", scored_positions);
  selected_position = undefined;

  if(scored_positions.size > 0) {
    var_bb42d5671a15133 = function_b6fa37032b07be6b(scored_positions);
    var_de415af085dc3c62 = [[var_ee72ecc29d3f753a]](var_bb42d5671a15133);

    if(isDefined(var_de415af085dc3c62)) {
      selected_position = var_de415af085dc3c62.position;
    }
  }

  var_65add5c30ad7773d notify("\xa9\x94\x1e9\x8e\xbe\xe7\xf2\xb1W>\xb0\\\xb9\xa7@\x810\x856\xfbP\t[m", selected_position);

  function_fd8badf1578f2b91(selected_position, scored_positions, original_position, var_2deedb482a6bbe25);
}

function function_dd866c1a981ab9d3(var_af98c8265cb110c9, var_3fcb92d4825099a2, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_1be5089e1e630a22, var_65add5c30ad7773d) {
  thread function_db79ecb4b1d767b6(var_af98c8265cb110c9, var_3fcb92d4825099a2, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_1be5089e1e630a22, var_65add5c30ad7773d);
}

function private function_db79ecb4b1d767b6(var_af98c8265cb110c9, var_3fcb92d4825099a2, var_2deedb482a6bbe25, var_ec2544d2439d856b, var_1be5089e1e630a22, var_65add5c30ad7773d) {
  scored_positions = [];
  var_401d0de9111c9ae0 = function_907365dd3bfde9f6(var_3fcb92d4825099a2);
  frames_waited = 0;

  if(isDefined(var_401d0de9111c9ae0)) {
    for(i = 0; i < var_af98c8265cb110c9.size; i++) {
      var_b003f327f4eaf972 = var_af98c8265cb110c9[i];
      scored_position = function_934c0033a80c5a71(var_b003f327f4eaf972, var_401d0de9111c9ae0, var_2deedb482a6bbe25, var_ec2544d2439d856b);

      if(isDefined(scored_position)) {
        scored_positions[scored_positions.size] = scored_position;
      }

      if(function_9c527ca855656c75(i, var_af98c8265cb110c9.size, var_1be5089e1e630a22)) {
        frames_waited++;
        waitframe();
      }
    }
  }

  if(frames_waited == 0) {
    waitframe();
  }

  var_65add5c30ad7773d notify("\x93rpD\x9e\xe2\x05\xc4_\xfd\xb7\xc3\x1e\xe2S\xd3\x14S\x8c", scored_positions);
}

function function_b6fa37032b07be6b(scored_positions) {
  var_bb42d5671a15133 = [];
  highest_score = -1;

  foreach(scored_position in scored_positions) {
    score = scored_position.score;

    if(score == -1) {
      continue;
    }

    if(score > highest_score) {
      var_bb42d5671a15133 = [scored_position];
      highest_score = score;
      continue;
    }

    if(score == highest_score) {
      var_bb42d5671a15133[var_bb42d5671a15133.size] = scored_position;
    }
  }

  return var_bb42d5671a15133;
}

function function_3eaea3190f20e0aa(var_bb42d5671a15133) {
  return utility::array_random(var_bb42d5671a15133);
}

function private function_934c0033a80c5a71(offset_point, var_401d0de9111c9ae0, var_2deedb482a6bbe25, var_ec2544d2439d856b) {
  if(!isDefined(var_401d0de9111c9ae0)) {
    println("<dev string:x24>");
    return undefined;
  }

  var_e428d68d9cd7deb0 = function_907365dd3bfde9f6(offset_point);

  if(!isDefined(var_e428d68d9cd7deb0)) {
    println("<dev string:x98>");
    return undefined;
  }

  var_5ab86e0063f03317 = score_navtrace(var_401d0de9111c9ae0, var_e428d68d9cd7deb0, var_ec2544d2439d856b.var_cee5123dbdc2d268, var_ec2544d2439d856b.var_d7958f234cc312b3);
  var_26939c6fbca15b09 = drop_to_ground(var_e428d68d9cd7deb0);

  if(!isDefined(var_26939c6fbca15b09)) {
    println("<dev string:x10a>");
    return undefined;
  }

  var_64692f7726bd014f = score_collision(var_26939c6fbca15b09, var_2deedb482a6bbe25.var_6f6ede7391b07835, var_2deedb482a6bbe25.var_4636a331c6d719b9, var_2deedb482a6bbe25.var_216e490be6198317, var_ec2544d2439d856b.var_6214553a11889b20, var_ec2544d2439d856b.var_2b8551ddd89aebd2, var_ec2544d2439d856b.var_e7dabe03c436e58b);
  var_a32f78120a6a0452 = function_4c01ac31625ddac5(var_26939c6fbca15b09, var_2deedb482a6bbe25.player_origin, var_2deedb482a6bbe25.player_angles, var_2deedb482a6bbe25.player_fov, var_ec2544d2439d856b.var_eb53ff6b92f5884b, var_ec2544d2439d856b.var_4f108df660b9f088);
  var_740994edf2f6443c = function_8a4de5b5ea4c13b9(var_26939c6fbca15b09, var_2deedb482a6bbe25.player_origin, var_2deedb482a6bbe25.player_angles, var_ec2544d2439d856b.var_9d8b2730a40c0ef5, var_ec2544d2439d856b.var_94259cb52c6d0f06);
  var_7c0471e0bf998a23 = function_848496bc82e6292c(var_26939c6fbca15b09, var_2deedb482a6bbe25.player_origin, var_2deedb482a6bbe25.var_99c204dc1ec836d5, var_ec2544d2439d856b.var_2eaa89f661c8fa93, var_ec2544d2439d856b.var_c61722a074b7f610);
  scores = [var_5ab86e0063f03317.score, var_64692f7726bd014f.score, var_a32f78120a6a0452.score, var_740994edf2f6443c.score, var_7c0471e0bf998a23.score];
  total_score = function_29be8820974e74ca(scores);
  scored_position = function_ed60def7c98ece55(var_26939c6fbca15b09, total_score, var_5ab86e0063f03317.computed_data, var_64692f7726bd014f.computed_data, var_7c0471e0bf998a23.computed_data);
  return scored_position;
}

function function_a83c580adfed17ef(var_6f6ede7391b07835, var_4636a331c6d719b9, var_216e490be6198317, player_origin, player_angles, player_fov, var_99c204dc1ec836d5) {
  return {
    #var_99c204dc1ec836d5: var_99c204dc1ec836d5, #player_fov: player_fov, #player_angles: player_angles, #player_origin: player_origin, #var_216e490be6198317: var_216e490be6198317, #var_4636a331c6d719b9: var_4636a331c6d719b9, #var_6f6ede7391b07835: var_6f6ede7391b07835
  };
}

function private createstruct_scoreamountsettings(var_6214553a11889b20, var_2b8551ddd89aebd2, var_e7dabe03c436e58b, var_eb53ff6b92f5884b, var_4f108df660b9f088, var_9d8b2730a40c0ef5, var_94259cb52c6d0f06, var_cee5123dbdc2d268, var_d7958f234cc312b3, var_2eaa89f661c8fa93, var_c61722a074b7f610) {
  return {
    #var_c61722a074b7f610: var_c61722a074b7f610, #var_2eaa89f661c8fa93: var_2eaa89f661c8fa93, #var_d7958f234cc312b3: var_d7958f234cc312b3, #var_cee5123dbdc2d268: var_cee5123dbdc2d268, #var_94259cb52c6d0f06: var_94259cb52c6d0f06, #var_9d8b2730a40c0ef5: var_9d8b2730a40c0ef5, #var_4f108df660b9f088: var_4f108df660b9f088, #var_eb53ff6b92f5884b: var_eb53ff6b92f5884b, #var_e7dabe03c436e58b: var_e7dabe03c436e58b, #var_2b8551ddd89aebd2: var_2b8551ddd89aebd2, #var_6214553a11889b20: var_6214553a11889b20
  };
}

function private function_90b83d2c6a0bcb95(score, computed_data) {
  return {
    #computed_data: computed_data, #score: score
  };
}

function private function_ed60def7c98ece55(position, score, var_df7a40ba6a0a8879, var_4a451fd364ee2d8e, var_a303ee62c54cf811) {
  return {
    #var_a303ee62c54cf811: var_a303ee62c54cf811, #var_4a451fd364ee2d8e: var_4a451fd364ee2d8e, #var_df7a40ba6a0a8879: var_df7a40ba6a0a8879, #score: score, #position: position
  };
}

function private score_navtrace(position_from, position_to, var_cc0c3df2dead273b, var_a057fd9b53d59cfa) {
  score = var_a057fd9b53d59cfa;
  navtrace_result = navtrace(position_from, position_to, undefined, 1);

  if(!isDefined(navtrace_result)) {
    score = var_cc0c3df2dead273b;
  } else {
    fraction = navtrace_result["\xda\x16\x81\aw}^i"];

    if(fraction > 0.95) {
      score = var_cc0c3df2dead273b;
    }
  }

  return function_90b83d2c6a0bcb95(score, navtrace_result);
}

function private score_collision(position, var_6f6ede7391b07835, var_4636a331c6d719b9, var_216e490be6198317, var_cc0c3df2dead273b, var_8de7c6d3a6690b29, var_a057fd9b53d59cfa) {
  score = var_a057fd9b53d59cfa;
  content = 0;
  content += trace::create_world_contents();
  content += trace::create_vehicle_contents();
  var_50a44df90b8b7a38 = position + (0, 0, var_4636a331c6d719b9);
  var_20e52e165c31701b = trace::sphere_trace(var_50a44df90b8b7a38, var_50a44df90b8b7a38, var_6f6ede7391b07835, undefined, content, 1, 1);

  if(!isDefined(var_20e52e165c31701b) || var_20e52e165c31701b["\xda\x16\x81\aw}^i"] == 1) {
    score = var_cc0c3df2dead273b;
  } else {
    hit_position = var_20e52e165c31701b["\xc1\xbd\xdci\xe8i{7"];
    var_64b7ec99e7a3069c = function_c99a0ee022a7f287(position, var_6f6ede7391b07835, hit_position);

    if(var_64b7ec99e7a3069c > 0.95) {
      score = var_cc0c3df2dead273b;
    } else if(var_64b7ec99e7a3069c > var_216e490be6198317) {
      score = var_8de7c6d3a6690b29;
    }
  }

  return function_90b83d2c6a0bcb95(score, var_20e52e165c31701b);
}

function private function_4c01ac31625ddac5(position, player_origin, player_angles, fov, var_cc0c3df2dead273b, var_a057fd9b53d59cfa) {
  score = var_a057fd9b53d59cfa;
  var_3aa951da0e19f178 = utility::within_fov(player_origin, player_angles, position, fov);

  if(var_3aa951da0e19f178) {
    score = var_cc0c3df2dead273b;
  }

  return function_90b83d2c6a0bcb95(score);
}

function private function_8a4de5b5ea4c13b9(position, player_origin, player_angles, var_cc0c3df2dead273b, var_a057fd9b53d59cfa) {
  return function_4c01ac31625ddac5(position, player_origin, player_angles, 0, var_cc0c3df2dead273b, var_a057fd9b53d59cfa);
}

function private function_848496bc82e6292c(position, player_origin, var_99c204dc1ec836d5, var_cc0c3df2dead273b, var_a057fd9b53d59cfa) {
  score = var_a057fd9b53d59cfa;
  var_a303ee62c54cf811 = distance2d(position, player_origin);

  if(var_a303ee62c54cf811 > var_99c204dc1ec836d5) {
    score = var_cc0c3df2dead273b;
  }

  return function_90b83d2c6a0bcb95(score, var_a303ee62c54cf811);
}

function function_81a685a0e055e987(position, offset_radius) {
  offset_positions = [];
  offsets = function_dcc6946781f70f63(offset_radius);

  foreach(offset in offsets) {
    offset_positions[offset_positions.size] = position + offset;
  }

  return offset_positions;
}

function function_dcc6946781f70f63(radius) {
  offsets = function_7682457599dbebc5();

  for(i = 0; i < offsets.size; i++) {
    offsets[i] *= radius;
  }

  return offsets;
}

function private function_907365dd3bfde9f6(position) {
  var_c105694614e7c2f = 0;
  ground_pos = drop_to_ground(position);

  if(!isDefined(ground_pos)) {
    return ground_pos;
  }

  var_73de4d168720c280 = getclosestpointonnavmesh(position, undefined, undefined, undefined, var_c105694614e7c2f);
  return var_73de4d168720c280;
}

function private drop_to_ground(position) {
  return getgroundposition(position, 1);
}

function private function_9c527ca855656c75(position_index, var_ba7bacda1aa3874e, var_1be5089e1e630a22) {
  return position_index != 0 && position_index != var_ba7bacda1aa3874e - 1 && position_index % var_1be5089e1e630a22 == 0;
}

function private function_29be8820974e74ca(scores) {
  total_score = 0;

  foreach(score in scores) {
    if(score == -1) {
      return -1;
    }

    total_score += score;
  }

  return total_score;
}

function private function_c99a0ee022a7f287(sphere_origin, sphere_radius, var_b6d658bd4d8280a) {
  hit_distance = distance2d(sphere_origin, var_b6d658bd4d8280a);
  return hit_distance / float(sphere_radius);
}

function private function_7682457599dbebc5() {
  var_961327a016b062aa = level.var_20ed7e6d32ae807e;

  if(!isDefined(var_961327a016b062aa)) {
    var_961327a016b062aa = [];
    cos_45 = cos(45);
    sin_45 = sin(45);
    var_961327a016b062aa[0] = (1, 0, 0);
    var_961327a016b062aa[1] = (-1, 0, 0);
    var_961327a016b062aa[2] = (0, 1, 0);
    var_961327a016b062aa[3] = (0, -1, 0);
    var_961327a016b062aa[4] = (cos_45, sin_45, 0);
    var_961327a016b062aa[5] = (cos_45 * -1, sin_45, 0);
    var_961327a016b062aa[6] = (cos_45, sin_45 * -1, 0);
    var_961327a016b062aa[7] = (cos_45 * -1, sin_45 * -1, 0);
    level.var_20ed7e6d32ae807e = var_961327a016b062aa;
  }

  return var_961327a016b062aa;
}

function private function_fd8badf1578f2b91(selected_position, scored_positions, var_77184a6afc0239b5, var_2deedb482a6bbe25) {
  var_ff512f401f79df6c = getdvarint(@ "hash_eff5e2218caf8354", 0);

  if(var_ff512f401f79df6c) {
    var_169f6aa0ae0ac4a = getdvarint(@ "hash_1ed3e490fb83235e", 999);
    function_77dd41d8abf2d6ca(selected_position, scored_positions, var_77184a6afc0239b5, var_2deedb482a6bbe25, var_169f6aa0ae0ac4a);
  }
}

function private function_77dd41d8abf2d6ca(selected_position, scored_positions, var_77184a6afc0239b5, var_2deedb482a6bbe25, duration) {
  var_3016d6bd6cdfe831 = (0, 255, 0);
  var_81b527a3162525d5 = (0, 100, 100);
  var_f2311ade6ceddf7e = (0, 0, 255);
  var_c1517ee24a9c7ae5 = (255, 0, 255);
  var_7b713dc24757a618 = (255, 0, 0);
  var_f37f09a9870a8243 = (255, 255, 0);
  debug_draw(var_77184a6afc0239b5, 8, var_81b527a3162525d5, duration, "<dev string:x18e>", undefined, 0.5);
  debug_draw(function_907365dd3bfde9f6(var_77184a6afc0239b5), 6, var_f2311ade6ceddf7e, duration, "<dev string:x1a6>", 0, 0.5);

  foreach(scored_position in scored_positions) {
    if(isDefined(selected_position) && scored_position.position == selected_position) {
      color = var_3016d6bd6cdfe831;
    } else if(scored_position.score == -1) {
      color = var_7b713dc24757a618;
    } else {
      color = var_c1517ee24a9c7ae5;
    }

    debug_draw(scored_position.position + (0, 0, var_2deedb482a6bbe25.var_4636a331c6d719b9), var_2deedb482a6bbe25.var_6f6ede7391b07835, color, duration, utility::string(scored_position.score));
    var_20e52e165c31701b = scored_position.var_4a451fd364ee2d8e;

    if(isDefined(var_20e52e165c31701b) && var_20e52e165c31701b["<dev string:x1d1>"] < 1) {
      sphere(var_20e52e165c31701b["<dev string:x1dd>"], 3, var_f37f09a9870a8243, 0, int(duration));
    }
  }
}

function private debug_draw(pos, radius, color, duration, optional_text, var_279f4866c377c1b3, var_59c235dfa3208589) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  if(!isDefined(var_279f4866c377c1b3)) {
    var_279f4866c377c1b3 = 30;
  }

  if(!isDefined(var_59c235dfa3208589)) {
    var_59c235dfa3208589 = 1;
  }

  if(!isDefined(pos)) {
    return;
  }

  duration = int(duration);
  sphere(pos, radius, color, 0, duration);
  sphere(pos, 3, undefined, 1, duration);

  if(isDefined(optional_text)) {
    print3d(pos + (0, 0, var_279f4866c377c1b3), optional_text, (255, 255, 255), 1, var_59c235dfa3208589, duration, 1);
  }
}

# /