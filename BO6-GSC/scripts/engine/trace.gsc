/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\trace.gsc
**************************************/

#using scripts\engine\math;
#using scripts\engine\utility;
#namespace trace;

function ray_trace(start, end, ignore, contentoverride, getsurfacetype, ignoreclutter, allowscriptables) {
  trace = physics_raycast(start, end, contentoverride ?? create_default_contents(), ignore, 0, "physicsquery_closest", istrue(ignoreclutter), allowscriptables);

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x24>", start, end);

  return trace;
}

function ray_trace_ents(start, end, ents, contentoverride, getsurfacetype, ignoreclutter, var_4493f393bfd59162) {
  content = contentoverride ?? create_default_contents();
  trace = physics_raycastents(start, end, content, ents, 0, "physicsquery_closest", var_4493f393bfd59162);

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x24>", start, end);

  return trace;
}

function player_viewangles(collisioncontents = create_all_contents(), getsurfacetype = 1, ignoreclutter = 1, allowscriptables = 1) {
  assert(isPlayer(self));
  return ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 10000, self, collisioncontents, getsurfacetype, ignoreclutter, allowscriptables);
}

function _bullet_trace(start, end, hitcharacters, ignore, itemclip, var_47161858d46d0532, testvehicleclip, noshotclip, testglass) {
  content = ["physicscontents_clipshot", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"];

  if(hitcharacters) {
    content[content.size] = "physicscontents_characterproxy";
  }

  if(itemclip) {
    content[content.size] = "physicscontents_itemclip";
  }

  if(testvehicleclip) {
    content[content.size] = "physicscontents_vehicleclip";
  }

  if(!isDefined(noshotclip) || !noshotclip) {
    content[content.size] = "physicscontents_clipshot";
  }

  if(!isDefined(testglass) || testglass) {
    content[content.size] = "physicscontents_glass";
  }

  if(var_47161858d46d0532) {
    return ray_trace_detail(start, end, ignore, physics_createcontents(content), 1);
  }

  return ray_trace(start, end, ignore, physics_createcontents(content), 1);
}

function _bullet_trace_passed(start, end, hitcharacters, ignore) {
  return ray_trace_passed(start, end, ignore, create_default_contents(!hitcharacters));
}

function ray_trace_detail(start, end, ignore, contentoverride, getsurfacetype, ignoreclutter, allowscriptables) {
  content = contentoverride ?? create_default_contents();
  shouldignoreclutter = ignoreclutter ?? 0;

  if(isDefined(allowscriptables)) {
    trace = physics_raycast(start, end, content, ignore, 1, "physicsquery_closest", shouldignoreclutter, allowscriptables);
  } else {
    trace = physics_raycast(start, end, content, ignore, 1, "physicsquery_closest", shouldignoreclutter);
  }

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x24>", start, end);

  return trace;
}

function ray_trace_get_all_results(start, end, ignore, contentoverride, getsurfacetype, allowscriptables) {
  content = contentoverride ?? create_default_contents();
  trace = physics_raycast(start, end, content, ignore, 0, "physicsquery_all", 0, allowscriptables);

  if(getsurfacetype) {
    foreach(i, t in trace) {
      trace[i] = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:x24>", start, end);

  return trace;
}

function ray_trace_passed(start, end, ignore, contentoverride) {
  content = contentoverride ?? create_default_contents();
  return !physics_raycast(start, end, content, ignore, 0, "physicsquery_any");
}

function ray_trace_detail_passed(start, end, ignore, contentoverride) {
  content = contentoverride ?? create_default_contents();
  return !physics_raycast(start, end, content, ignore, 1, "physicsquery_any");
}

function can_see_origin(origin, test_characters) {
  assert(isDefined(origin), "<dev string:x2b>");
  assert(isPlayer(self) || isai(self), "<dev string:x68>");

  if(!isDefined(test_characters)) {
    test_characters = 1;
  }

  if(!math::point_in_fov(origin)) {
    return false;
  }

  return ray_trace_passed(self getEye(), origin, self, create_contents(test_characters, 1, 0, 1, 0, 1));
}

function sphere_trace(start, end, radius, ignore, contentoverride, getsurfacetype, allowscriptables) {
  content = contentoverride ?? create_default_contents();
  trace = physics_spherecast(start, end, radius, content, ignore, "physicsquery_closest", undefined, allowscriptables);

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xa2>", start, end, radius);

  return trace;
}

function sphere_trace_get_all_results(start, end, radius, ignore, contentoverride, getsurfacetype, allowscriptables) {
  content = contentoverride ?? create_default_contents();
  trace = physics_spherecast(start, end, radius, content, ignore, "physicsquery_all", undefined, allowscriptables);

  if(getsurfacetype) {
    for(i = 0; i < trace.size; i++) {
      trace[i] = convert_surface_flag(trace[i]);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xa2>", start, end, radius);

  return trace;
}

function sphere_trace_passed(start, end, radius, ignore, contentoverride) {
  content = contentoverride ?? create_default_contents();
  return !physics_spherecast(start, end, radius, content, ignore, "physicsquery_any");
}

function sphere_get_closest_point(position, radius, search_distance, ignore, contentoverride, getsurfacetype) {
  content = contentoverride ?? create_default_contents();
  trace = physics_getclosestpointtosphere(position, radius, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xa2>", position, undefined, radius, undefined, undefined, search_distance);

  return trace;
}

function capsule_trace(start, end, radius, height, angles, ignore, contentoverride, getsurfacetype) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = contentoverride ?? create_default_contents();
  capsule_data = convert_capsule_data(start, end, radius, height, angles);
  trace = physics_capsulecast(capsule_data["trace_start"], capsule_data["trace_end"], radius, capsule_data["half_height"], angles, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xac>", start, end, radius, height, angles);

  return trace;
}

function capsule_trace_get_all_results(start, end, radius, height, angles, ignore, contentoverride, getsurfacetype) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = contentoverride ?? create_default_contents();
  capsule_data = convert_capsule_data(start, end, radius, height, angles);
  trace = physics_capsulecast(capsule_data["trace_start"], capsule_data["trace_end"], radius, capsule_data["half_height"], angles, content, ignore, "physicsquery_all");

  if(getsurfacetype) {
    foreach(t in trace) {
      t = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xac>", start, end, radius, height, angles);

  return trace;
}

function capsule_trace_passed(start, end, radius, height, angles, ignore, contentoverride) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = contentoverride ?? create_default_contents();
  capsule_data = convert_capsule_data(start, end, radius, height, angles);
  return !physics_capsulecast(capsule_data["trace_start"], capsule_data["trace_end"], radius, capsule_data["half_height"], angles, content, ignore, "physicsquery_any");
}

function capsule_get_closest_point(position, radius, height, angles, search_distance, ignore, contentoverride, getsurfacetype) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = contentoverride ?? create_default_contents();
  capsule_data = convert_capsule_data(position, undefined, radius, height, angles);
  trace = physics_getclosestpointtocapsule(capsule_data["trace_start"], radius, capsule_data["half_height"], angles, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xac>", position, undefined, radius, height, angles, search_distance);

  return trace;
}

function player_trace(start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:xb7>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  content = contentoverride ?? create_default_contents();

  if(!isDefined(ground_clearance)) {
    ground_clearance = 0;
  }

  trace = physics_charactercast(start, end, self, ground_clearance, angles, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xe7>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function player_trace_get_all_results(start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:xf4>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  content = contentoverride ?? create_default_contents();

  if(!isDefined(ground_clearance)) {
    ground_clearance = 0;
  }

  trace = physics_charactercast(start, end, self, ground_clearance, angles, content, ignore, "physicsquery_all");

  if(getsurfacetype) {
    foreach(t in trace) {
      t = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xe7>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function player_trace_passed(start, end, angles, ignore, contentoverride, ground_clearance) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x134>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  content = contentoverride ?? create_default_contents();

  if(!isDefined(ground_clearance)) {
    ground_clearance = 0;
  }

  return !physics_charactercast(start, end, self, ground_clearance, angles, content, ignore, "physicsquery_any");
}

function player_get_closest_point_static(search_distance, ignore, contentoverride, getsurfacetype) {
  return player_get_closest_point(self.origin, self.angles, search_distance, ignore, contentoverride, getsurfacetype);
}

function player_get_closest_point(position, angles, search_distance, ignore, contentoverride, getsurfacetype) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x16b>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  if(!isDefined(search_distance)) {
    search_distance = 0;
  }

  if(isarray(ignore)) {
    ignore[ignore.size] = self;
  } else {
    ignore = self;
  }

  content = contentoverride ?? create_default_contents();
  trace = physics_getclosestpointtocharacter(position, self, 0, angles, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xe7>", position, undefined, undefined, undefined, angles, search_distance, self);

  return trace;
}

function ai_trace(start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance) {
  if(!isai(self)) {
    assertmsg("<dev string:x1a7>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  content = contentoverride ?? create_solid_ai_contents();

  if(!isDefined(ground_clearance)) {
    ground_clearance = 0;
  }

  trace = physics_charactercast(start, end, self, ground_clearance, angles, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xe7>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function ai_trace_get_all_results(start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance) {
  if(!isai(self)) {
    assertmsg("<dev string:x1d0>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  content = contentoverride ?? create_solid_ai_contents();

  if(!isDefined(ground_clearance)) {
    ground_clearance = 0;
  }

  trace = physics_charactercast(start, end, self, ground_clearance, angles, content, ignore, "physicsquery_all");

  if(getsurfacetype) {
    foreach(t in trace) {
      t = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xe7>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function ai_trace_passed(start, end, angles, ignore, contentoverride, ground_clearance) {
  if(!isai(self)) {
    assertmsg("<dev string:x1a7>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  content = contentoverride ?? create_solid_ai_contents();

  if(!isDefined(ground_clearance)) {
    ground_clearance = 0;
  }

  return !physics_charactercast(start, end, self, ground_clearance, angles, content, ignore, "physicsquery_any");
}

function ai_get_closest_point(position, angles, search_distance, ignore, contentoverride, getsurfacetype) {
  if(!isai(self)) {
    assertmsg("<dev string:x1a7>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  if(!isDefined(search_distance)) {
    search_distance = 0;
  }

  content = contentoverride ?? create_solid_ai_contents();
  trace = physics_getclosestpointtocharacter(position, self, 0, angles, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xe7>", position, undefined, undefined, undefined, angles, search_distance, self);

  return trace;
}

function create_solid_ai_contents(ignore_characters) {
  content = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(ignore_characters) || !ignore_characters) {
    content[content.size] = "physicscontents_characterproxy";
  }

  return physics_createcontents(content);
}

function function_d436792385c352aa() {
  content = ["physicscontents_solid", "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass"];
  return physics_createcontents(content);
}

function create_opaque_ai_contents(ignore_character, ignore_foliage) {
  contents = ["physicscontents_ainosight", "physicscontents_vehicle"];

  if(!ignore_character) {
    contents[contents.size] = "physicscontents_characterproxy";
  }

  if(!ignore_foliage) {
    contents[contents.size] = "physicscontents_foliage";
  }

  return physics_createcontents(contents);
}

function function_75d39778b2b14b81() {
  contents = ["physicscontents_foliage", "physicscontents_foliage_audio"];
  return physics_createcontents(contents);
}

function create_ainosight_contents() {
  content = ["physicscontents_ainosight"];
  return physics_createcontents(content);
}

function create_world_contents() {
  content = ["physicscontents_itemclip", "physicscontents_water"];
  return physics_createcontents(content);
}

function function_bbd81e56529ef225() {
  return physics_createcontents(["physicscontents_water"]);
}

function create_glass_contents() {
  content = ["physicscontents_glass"];
  return physics_createcontents(content);
}

function create_ainoshoot_contents() {
  content = ["physicscontents_ainoshoot"];
  return physics_createcontents(content);
}

function create_item_contents() {
  content = ["physicscontents_item"];
  return physics_createcontents(content);
}

function create_itemclip_contents() {
  content = ["physicscontents_itemclip"];
  return physics_createcontents(content);
}

function create_vehicle_contents() {
  content = ["physicscontents_vehicle"];
  return physics_createcontents(content);
}

function function_95e6759db38fe94e() {
  content = ["physicscontents_vehicleclip"];
  return physics_createcontents(content);
}

function create_shotclip_contents() {
  content = ["physicscontents_clipshot", "physicscontents_missileclip"];
  return physics_createcontents(content);
}

function create_playerclip_contents() {
  content = ["physicscontents_playerclip"];
  return physics_createcontents(content);
}

function create_character_contents() {
  content = ["physicscontents_characterproxy"];
  return physics_createcontents(content);
}

function function_c0d3ab83fb6e9efb() {
  content = ["physicscontents_cameraclip"];
  return physics_createcontents(content);
}

function create_default_contents(ignore_characters) {
  if(ignore_characters) {
    return (level.tracecontents[#"hash_9c68a7d42423c367"] ?? function_41e6f1cfccdca785());
  }

  return level.tracecontents[#"hash_3b87644c44e5a89f"] ?? function_7e09a15185b5ee19();
}

function private function_41e6f1cfccdca785() {
  level.tracecontents[#"hash_9c68a7d42423c367"] = create_default_contents_internal(1);
  return level.tracecontents[#"hash_9c68a7d42423c367"];
}

function private function_7e09a15185b5ee19() {
  level.tracecontents[#"hash_3b87644c44e5a89f"] = create_default_contents_internal(0);
  return level.tracecontents[#"hash_3b87644c44e5a89f"];
}

function private create_default_contents_internal(ignore_characters) {
  return create_contents(!ignore_characters, 1, 1, 1, 0, 1);
}

function create_contents(character, _world, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip, vehicleclip, waterclip, cameraclip, excludewaterclip) {
  content = 0;
  contentcache = level.create_contents_cache ?? function_63b69288208a3639();

  if(character) {
    content |= contentcache.character;
  }

  if(_world) {
    content |= contentcache._world;
  }

  if(glass) {
    content |= contentcache.glass;
  }

  if(shotclip) {
    content |= contentcache.shotclip;
  }

  if(item) {
    content |= contentcache.item;
  }

  if(vehicle) {
    content |= contentcache.vehicle;
  }

  if(playerclip) {
    content |= contentcache.playerclip;
  }

  if(ainosight) {
    content |= contentcache.ainosight;
  }

  if(itemclip) {
    content |= contentcache.itemclip;
  }

  if(vehicleclip) {
    content |= contentcache.vehicleclip;
  }

  if(waterclip && !excludewaterclip) {
    content |= contentcache.waterclip;
  }

  if(cameraclip) {
    content |= contentcache.cameraclip;
  }

  if(excludewaterclip && content | contentcache.waterclip) {
    content -= contentcache.waterclip;
  }

  return content;
}

function function_63b69288208a3639() {
  level.create_contents_cache = {
    #cameraclip: function_c0d3ab83fb6e9efb(), #waterclip: function_bbd81e56529ef225(), #vehicleclip: function_95e6759db38fe94e(), #itemclip: create_itemclip_contents(), #ainosight: create_ainosight_contents(), #playerclip: create_playerclip_contents(), #vehicle: create_vehicle_contents(), #item: create_item_contents(), #shotclip: create_shotclip_contents(), #glass: create_glass_contents(), #_world: create_world_contents(), #character: create_character_contents()
  };
  return level.create_contents_cache;
}

function create_all_contents() {
  content = ["physicscontents_foliage", "physicscontents_foliage_audio", "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_trigger", "physicscontents_vehicle", "physicscontents_useclip"];
  return physics_createcontents(content);
}

function convert_surface_flag(trace) {
  trace = arraycopy(trace);
  var_6a158acb78626840 = physics_getsurfacetypefromflags(trace["surfaceflags"]);
  trace["surfaceindex"] = var_6a158acb78626840["index"];
  trace["surfacetype"] = var_6a158acb78626840["name"];
  return trace;
}

function convert_capsule_data(start_ground_pos, end_ground_pos, radius, height, angles) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  half_height = height * 0.5;
  up = anglestoup(angles);
  capsule_data = [];
  capsule_data["trace_start"] = start_ground_pos + up * half_height;

  if(isDefined(end_ground_pos)) {
    capsule_data["trace_end"] = end_ground_pos + up * half_height;
  }

  capsule_data["radius"] = radius;
  capsule_data["angles"] = angles;
  capsule_data["half_height"] = half_height;
  return capsule_data;
}

function draw_trace(trace, color, display_details, duration) {
  if(!isDefined(trace)) {
    return;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(isDefined(trace["<dev string:x209>"])) {
    draw_trace_type(trace["<dev string:x209>"], color, duration);
  }

  if(isDefined(trace[0])) {
    foreach(t in trace) {
      thread draw_trace_hit(t, trace["<dev string:x209>"], color, display_details, duration);
    }

    return;
  }

  thread draw_trace_hit(trace, trace["<dev string:x209>"], color, display_details, duration);
}

function draw_trace_hit(trace, debug_data, color, display_details, duration) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  if(isDefined(trace["<dev string:x216>"])) {
    half_color = color * 0.25;
    is_white = gettime() / 50 / 2 == int(gettime() / 50 / 2);

    if(is_white) {
      color = (1, 1, 1);
    }

    sphere(trace["<dev string:x216>"], 5, color, 1, duration);
    line(trace["<dev string:x216>"], trace["<dev string:x216>"] + trace["<dev string:x222>"] * 15, color, 1, 1, duration);

    if(display_details && isDefined(level.player)) {
      cam_angles = level.player getplayerangles();
      cam_up = anglestoup(cam_angles);
      text_scale = 0.25;
      new_line = 11 * text_scale;
      normal_len = 15;

      if(isDefined(trace["<dev string:x22c>"])) {
        normal_len = trace["<dev string:x22c>"];
      }

      text_pos = trace["<dev string:x216>"] + trace["<dev string:x222>"] * normal_len;
      print3d(text_pos, "<dev string:x238>" + trace["<dev string:x216>"], (1, 1, 1), 1, text_scale, duration);

      if(isDefined(trace["<dev string:x247>"])) {
        print3d(text_pos - cam_up * new_line * 1, "<dev string:x259>" + trace["<dev string:x247>"], (1, 1, 1), 1, text_scale, duration);
      } else {
        print3d(text_pos - cam_up * new_line * 1, "<dev string:x268>", (1, 1, 1), 1, text_scale, duration);
      }

      print3d(text_pos - cam_up * new_line * 2, "<dev string:x27d>" + trace["<dev string:x222>"], (1, 1, 1), 1, text_scale, duration);

      if(isDefined(trace["<dev string:x289>"])) {
        print3d(text_pos - cam_up * new_line * 3, "<dev string:x295>" + trace["<dev string:x289>"], (1, 1, 1), 1, text_scale, duration);
      } else if(isDefined(trace["<dev string:x22c>"])) {
        print3d(text_pos - cam_up * new_line * 3, "<dev string:x2a3>" + trace["<dev string:x22c>"], (1, 1, 1), 1, text_scale, duration);
      } else {
        print3d(text_pos - cam_up * new_line * 3, "<dev string:x2b1>", (1, 1, 1), 1, text_scale, duration);
      }

      if(isDefined(trace["<dev string:x2bb>"])) {
        print3d(text_pos - cam_up * new_line * 4, "<dev string:x2ca>" + trace["<dev string:x2bb>"], (1, 1, 1), 1, text_scale, duration);
      } else {
        print3d(text_pos - cam_up * new_line * 4, "<dev string:x2dc>", (1, 1, 1), 1, text_scale, duration);
      }

      if(isDefined(trace["<dev string:x2fe>"])) {
        print3d(text_pos - cam_up * new_line * 5, "<dev string:x308>", (1, 1, 1), 1, text_scale, duration);
        print3d(text_pos - cam_up * new_line * 6, "<dev string:x31d>" + trace["<dev string:x2fe>"] getentitynumber(), (1, 1, 1), 1, text_scale, duration);
        print3d(text_pos - cam_up * new_line * 7, "<dev string:x330>" + trace["<dev string:x2fe>"].classname, (1, 1, 1), 1, text_scale, duration);
        return;
      }

      print3d(text_pos - cam_up * new_line * 5, "<dev string:x342>", (1, 1, 1), 1, text_scale, duration);
    }
  }
}

function draw_trace_type(debugdata, color, duration) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  half_color = color * 0.75;
  no_color = color * 0.1;
  start = debugdata["<dev string:x358>"];

  if(debugdata["<dev string:x361>"] == "<dev string:x24>") {
    end = debugdata["<dev string:x369>"];
    dist = distance(debugdata["<dev string:x358>"], debugdata["<dev string:x369>"]);
    sphere(start, 0.15, no_color, 1, duration);
    sphere(end, 0.15, half_color, 1, duration);
    utility::draw_arrow(start, end, no_color, 1, 0, duration);
    line(start, end, half_color, 1, 1, duration);
    return;
  }

  if(debugdata["<dev string:x361>"] == "<dev string:xa2>") {
    radius = debugdata["<dev string:x370>"];

    if(isDefined(debugdata["<dev string:x369>"])) {
      end = debugdata["<dev string:x369>"];
      dist = distance(debugdata["<dev string:x358>"], debugdata["<dev string:x369>"]);
      count = max(ceil(dist / 128), 1);

      for(i = 0; i <= count; i++) {
        sphere(vectorlerp(start, end, i / count), radius, no_color, 0, duration);
        sphere(vectorlerp(start, end, i / count), radius, half_color, 1, duration);
      }

      utility::draw_arrow(start, end, no_color, 1, 0, duration);
      line(start, end, half_color, 1, 1, duration);
    } else {
      sphere(start, radius, no_color, 0, duration);
      sphere(start, radius, half_color, 1, duration);
    }

    return;
  }

  if(debugdata["<dev string:x361>"] == "<dev string:xac>" || debugdata["<dev string:x361>"] == "<dev string:xe7>") {
    if(debugdata["<dev string:x361>"] == "<dev string:xe7>" &isDefined(debugdata["<dev string:xe7>"])) {
      angles = debugdata["<dev string:x37a>"];
      capsule_data = debugdata["<dev string:xe7>"] physics_getcharactercollisioncapsule();
      radius = capsule_data["<dev string:x370>"];
      height = capsule_data["<dev string:x384>"] * 2;
    } else {
      radius = debugdata["<dev string:x370>"];
      angles = debugdata["<dev string:x37a>"];
      height = debugdata["<dev string:x393>"];
    }

    if(isDefined(debugdata["<dev string:x369>"])) {
      end = debugdata["<dev string:x369>"];
      dist = distance(debugdata["<dev string:x358>"], debugdata["<dev string:x369>"]);
      count = max(ceil(dist / 128), 1);

      for(i = 0; i <= count; i++) {
        utility::draw_capsule(vectorlerp(start, end, i / count), radius, height, angles, no_color, 0, duration);
        utility::draw_capsule(vectorlerp(start, end, i / count), radius, height, angles, half_color, 1, duration);
      }

      up = anglestoup(angles);
      start_top = start + up * height;
      end_top = end + up * height;
      utility::draw_arrow(start, end, no_color, 1, 0, duration);
      line(start, end, half_color, 1, 1, duration);
      utility::draw_arrow(start_top, end_top, no_color, 1, 0, duration);
      line(start_top, end_top, half_color, 1, 1, duration);
      return;
    }

    utility::draw_capsule(start, radius, height, angles, no_color, 0);
  }
}

function internal_pack_default_trace(pos) {
  trace = [];
  trace["fraction"] = 1;
  trace["surfaceflags"] = 0;
  trace["distance"] = 0;
  trace["position"] = pos;
  trace["shape_position"] = pos;
  trace["normal"] = (0, 0, 0);
  trace["contact_normal"] = (0, 0, 0);
  trace["hittype"] = "hittype_none";
  return trace;
}

function internal_create_debug_data(trace, type, start, end, radius, height, angles, search_distance, character) {
  trace = arraycopy(trace);
  trace["<dev string:x209>"]["<dev string:x361>"] = type;
  trace["<dev string:x209>"]["<dev string:x358>"] = start;
  trace["<dev string:x209>"]["<dev string:x369>"] = end;
  trace["<dev string:x209>"]["<dev string:x370>"] = radius;
  trace["<dev string:x209>"]["<dev string:x393>"] = height;
  trace["<dev string:x209>"]["<dev string:x37a>"] = angles;
  trace["<dev string:x209>"]["<dev string:x39d>"] = search_distance;
  trace["<dev string:x209>"]["<dev string:xe7>"] = character;
  return trace;
}

# /