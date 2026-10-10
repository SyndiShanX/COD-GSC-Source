/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\engine\trace.gsc
***********************************************/

#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace trace;

function ray_trace(start, end, ignore, contentoverride, getsurfacetype, ignoreclutter, var_b00c60a54d663ca2) {
  trace = physics_raycast(start, end, isDefined(contentoverride) ? contentoverride : create_default_contents(), ignore, 0, "physicsquery_closest", istrue(ignoreclutter), var_b00c60a54d663ca2);

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x1c>", start, end);

  return trace;
}

function ray_trace_ents(start, end, ents, contentoverride, getsurfacetype, ignoreclutter) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  var_f6dbad2cd5a99bb1 = ter_op(isDefined(ignoreclutter), ignoreclutter, 0);
  trace = physics_raycastents(start, end, content, ents, 0, "physicsquery_closest", var_f6dbad2cd5a99bb1);

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x1c>", start, end);

  return trace;
}

function player_viewangles(collisioncontents, getsurfacetype, ignoreclutter, var_b00c60a54d663ca2) {
  if(!isDefined(collisioncontents)) {
    collisioncontents = create_all_contents();
  }

  if(!isDefined(getsurfacetype)) {
    getsurfacetype = 1;
  }

  if(!isDefined(ignoreclutter)) {
    ignoreclutter = 1;
  }

  if(!isDefined(var_b00c60a54d663ca2)) {
    var_b00c60a54d663ca2 = 1;
  }

  assert(isPlayer(self));
  return ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 10000, self, collisioncontents, getsurfacetype, ignoreclutter, var_b00c60a54d663ca2);
}

function _bullet_trace(start, end, hitcharacters, ignore, itemclip, var_45ab9428a87b2b9f, var_c368ea2402a6a1ad, var_8812897bd00bf028, testglass) {
  content = ["physicscontents_clipshot", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"];

  if(hitcharacters) {
    content[content.size] = "physicscontents_characterproxy";
  }

  if(isDefined(itemclip) && itemclip) {
    content[content.size] = "physicscontents_itemclip";
  }

  if(isDefined(var_c368ea2402a6a1ad) && var_c368ea2402a6a1ad) {
    content[content.size] = "physicscontents_vehicleclip";
  }

  if(!isDefined(var_8812897bd00bf028) || !var_8812897bd00bf028) {
    content[content.size] = "physicscontents_clipshot";
  }

  if(!isDefined(testglass) || testglass) {
    content[content.size] = "physicscontents_glass";
  }

  if(isDefined(var_45ab9428a87b2b9f) && var_45ab9428a87b2b9f) {
    return ray_trace_detail(start, end, ignore, physics_createcontents(content), 1);
  }

  return ray_trace(start, end, ignore, physics_createcontents(content), 1);
}

function _bullet_trace_passed(start, end, hitcharacters, ignore) {
  return ray_trace_passed(start, end, ignore, create_default_contents(!hitcharacters));
}

function ray_trace_detail(start, end, ignore, contentoverride, getsurfacetype, ignoreclutter, var_b00c60a54d663ca2) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  var_f6dbad2cd5a99bb1 = ter_op(isDefined(ignoreclutter), ignoreclutter, 0);

  if(isDefined(var_b00c60a54d663ca2)) {
    trace = physics_raycast(start, end, content, ignore, 1, "physicsquery_closest", var_f6dbad2cd5a99bb1, var_b00c60a54d663ca2);
  } else {
    trace = physics_raycast(start, end, content, ignore, 1, "physicsquery_closest", var_f6dbad2cd5a99bb1);
  }

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x1c>", start, end);

  return trace;
}

function ray_trace_get_all_results(start, end, ignore, contentoverride, getsurfacetype) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_raycast(start, end, content, ignore, 0, "physicsquery_all");

  if(isDefined(getsurfacetype) && getsurfacetype) {
    foreach(i, t in trace) {
      trace[i] = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:x1c>", start, end);

  return trace;
}

function ray_trace_passed(start, end, ignore, contentoverride) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  return !physics_raycast(start, end, content, ignore, 0, "physicsquery_any");
}

function ray_trace_detail_passed(start, end, ignore, contentoverride) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  return !physics_raycast(start, end, content, ignore, 1, "physicsquery_any");
}

function can_see_origin(origin, test_characters) {
  assertex(isDefined(origin), "<dev string:x23>");
  assertex(isPlayer(self) || isai(self), "<dev string:x60>");

  if(!isDefined(test_characters)) {
    test_characters = 1;
  }

  if(!math::point_in_fov(origin)) {
    return false;
  }

  return ray_trace_passed(self getEye(), origin, self, scripts\engine\trace::create_contents(test_characters, 1, 0, 1, 0, 1));
}

function sphere_trace(start, end, radius, ignore, contentoverride, getsurfacetype, var_b00c60a54d663ca2) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_spherecast(start, end, radius, content, ignore, "physicsquery_closest", undefined, var_b00c60a54d663ca2);

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x9a>", start, end, radius);

  return trace;
}

function sphere_trace_get_all_results(start, end, radius, ignore, contentoverride, getsurfacetype, var_b00c60a54d663ca2) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_spherecast(start, end, radius, content, ignore, "physicsquery_all", undefined, var_b00c60a54d663ca2);

  if(isDefined(getsurfacetype) && getsurfacetype) {
    for(i = 0; i < trace.size; i++) {
      trace[i] = convert_surface_flag(trace[i]);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:x9a>", start, end, radius);

  return trace;
}

function sphere_trace_passed(start, end, radius, ignore, contentoverride) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  return !physics_spherecast(start, end, radius, content, ignore, "physicsquery_any");
}

function sphere_get_closest_point(position, radius, search_distance, ignore, contentoverride, getsurfacetype) {
  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_getclosestpointtosphere(position, radius, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:x9a>", position, undefined, radius, undefined, undefined, search_distance);

  return trace;
}

function capsule_trace(start, end, radius, height, angles, ignore, contentoverride, getsurfacetype) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  capsule_data = convert_capsule_data(start, end, radius, height, angles);
  trace = physics_capsulecast(capsule_data["trace_start"], capsule_data["trace_end"], radius, capsule_data["half_height"], angles, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xa4>", start, end, radius, height, angles);

  return trace;
}

function capsule_trace_get_all_results(start, end, radius, height, angles, ignore, contentoverride, getsurfacetype) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  capsule_data = convert_capsule_data(start, end, radius, height, angles);
  trace = physics_capsulecast(capsule_data["trace_start"], capsule_data["trace_end"], radius, capsule_data["half_height"], angles, content, ignore, "physicsquery_all");

  if(isDefined(getsurfacetype) && getsurfacetype) {
    foreach(t in trace) {
      t = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xa4>", start, end, radius, height, angles);

  return trace;
}

function capsule_trace_passed(start, end, radius, height, angles, ignore, contentoverride) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  capsule_data = convert_capsule_data(start, end, radius, height, angles);
  return !physics_capsulecast(capsule_data["trace_start"], capsule_data["trace_end"], radius, capsule_data["half_height"], angles, content, ignore, "physicsquery_any");
}

function capsule_get_closest_point(position, radius, height, angles, search_distance, ignore, contentoverride, getsurfacetype) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  capsule_data = convert_capsule_data(position, undefined, radius, height, angles);
  trace = physics_getclosestpointtocapsule(capsule_data["trace_start"], radius, capsule_data["half_height"], angles, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xa4>", position, undefined, radius, height, angles, search_distance);

  return trace;
}

function player_trace(start, end, angles, ignore, contentoverride, getsurfacetype, var_e98b3969bbe145d3) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:xaf>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());

  if(!isDefined(var_e98b3969bbe145d3)) {
    var_e98b3969bbe145d3 = 0;
  }

  trace = physics_charactercast(start, end, self, var_e98b3969bbe145d3, angles, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xdf>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function player_trace_get_all_results(start, end, angles, ignore, contentoverride, getsurfacetype, var_e98b3969bbe145d3) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:xec>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());

  if(!isDefined(var_e98b3969bbe145d3)) {
    var_e98b3969bbe145d3 = 0;
  }

  trace = physics_charactercast(start, end, self, var_e98b3969bbe145d3, angles, content, ignore, "physicsquery_all");

  if(isDefined(getsurfacetype) && getsurfacetype) {
    foreach(t in trace) {
      t = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xdf>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function player_trace_passed(start, end, angles, ignore, contentoverride, var_e98b3969bbe145d3) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x12c>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());

  if(!isDefined(var_e98b3969bbe145d3)) {
    var_e98b3969bbe145d3 = 0;
  }

  return !physics_charactercast(start, end, self, var_e98b3969bbe145d3, angles, content, ignore, "physicsquery_any");
}

function player_get_closest_point_static(search_distance, ignore, contentoverride, getsurfacetype) {
  return player_get_closest_point(self.origin, self.angles, search_distance, ignore, contentoverride, getsurfacetype);
}

function player_get_closest_point(position, angles, search_distance, ignore, contentoverride, getsurfacetype) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x163>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self getplayerangles();
  }

  if(!isDefined(search_distance)) {
    search_distance = 0;
  }

  if(isarray(ignore)) {
    ignore = array_add(ignore, self);
  } else {
    ignore = self;
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_getclosestpointtocharacter(position, self, 0, angles, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xdf>", position, undefined, undefined, undefined, angles, search_distance, self);

  return trace;
}

function ai_trace(start, end, angles, ignore, contentoverride, getsurfacetype, var_e98b3969bbe145d3) {
  if(!isai(self)) {
    assertmsg("<dev string:x19f>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());

  if(!isDefined(var_e98b3969bbe145d3)) {
    var_e98b3969bbe145d3 = 0;
  }

  trace = physics_charactercast(start, end, self, var_e98b3969bbe145d3, angles, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(end);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xdf>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function ai_trace_get_all_results(start, end, angles, ignore, contentoverride, getsurfacetype, var_e98b3969bbe145d3) {
  if(!isai(self)) {
    assertmsg("<dev string:x1c8>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());

  if(!isDefined(var_e98b3969bbe145d3)) {
    var_e98b3969bbe145d3 = 0;
  }

  trace = physics_charactercast(start, end, self, var_e98b3969bbe145d3, angles, content, ignore, "physicsquery_all");

  if(isDefined(getsurfacetype) && getsurfacetype) {
    foreach(t in trace) {
      t = convert_surface_flag(t);
    }
  }

  trace = internal_create_debug_data(trace, "<dev string:xdf>", start, end, undefined, undefined, angles, undefined, self);

  return trace;
}

function ai_trace_passed(start, end, angles, ignore, contentoverride, var_e98b3969bbe145d3) {
  if(!isai(self)) {
    assertmsg("<dev string:x19f>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());

  if(!isDefined(var_e98b3969bbe145d3)) {
    var_e98b3969bbe145d3 = 0;
  }

  return !physics_charactercast(start, end, self, var_e98b3969bbe145d3, angles, content, ignore, "physicsquery_any");
}

function ai_get_closest_point(position, angles, search_distance, ignore, contentoverride, getsurfacetype) {
  if(!isai(self)) {
    assertmsg("<dev string:x19f>");
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  if(!isDefined(search_distance)) {
    search_distance = 0;
  }

  content = ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());
  trace = physics_getclosestpointtocharacter(position, self, 0, angles, search_distance, content, ignore, "physicsquery_closest");

  if(trace.size) {
    trace = trace[0];
  } else {
    trace = internal_pack_default_trace(position);
  }

  if(isDefined(getsurfacetype) && getsurfacetype) {
    trace = convert_surface_flag(trace);
  }

  trace = internal_create_debug_data(trace, "<dev string:xdf>", position, undefined, undefined, undefined, angles, search_distance, self);

  return trace;
}

function create_solid_ai_contents(ignore_characters) {
  content = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(ignore_characters) || !ignore_characters) {
    content = array_add(content, "physicscontents_characterproxy");
  }

  return physics_createcontents(content);
}

function function_2d88cb1f022d0989() {
  content = ["physicscontents_solid", "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass"];
  return physics_createcontents(content);
}

function create_opaque_ai_contents(ignore_character, ignore_foliage) {
  contents = ["physicscontents_ainosight", "physicscontents_vehicle"];

  if(!istrue(ignore_character)) {
    contents[contents.size] = "physicscontents_characterproxy";
  }

  if(!istrue(ignore_foliage)) {
    contents[contents.size] = "physicscontents_foliage";
  }

  return physics_createcontents(contents);
}

function function_416688b9ffe933c4() {
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

function function_b88b8bd51ea7fe24() {
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

function function_f3dae12daeb1e8bb() {
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

function function_95da3996aeae6098() {
  content = ["physicscontents_cameraclip"];
  return physics_createcontents(content);
}

function create_default_contents(ignore_characters) {
  if(!isDefined(ignore_characters)) {
    ignore_characters = 0;
  }

  return create_contents(!ignore_characters, 1, 1, 1, 0, 1);
}

function create_contents(character, world, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip, vehicleclip, waterclip, cameraclip) {
  content = 0;
  contentcache = isDefined(level.var_dd16da2ec35010ad) ? level.var_dd16da2ec35010ad : function_f00c9e807784481e();

  if(istrue(character)) {
    content += contentcache.character;
  }

  if(istrue(world)) {
    content += contentcache.world;
  }

  if(istrue(glass)) {
    content += contentcache.glass;
  }

  if(istrue(shotclip)) {
    content += contentcache.shotclip;
  }

  if(istrue(item)) {
    content += contentcache.item;
  }

  if(istrue(vehicle)) {
    content += contentcache.vehicle;
  }

  if(istrue(playerclip)) {
    content += contentcache.playerclip;
  }

  if(istrue(ainosight)) {
    content += contentcache.ainosight;
  }

  if(istrue(itemclip)) {
    content += contentcache.itemclip;
  }

  if(istrue(vehicleclip)) {
    content += contentcache.vehicleclip;
  }

  if(istrue(waterclip)) {
    content += contentcache.waterclip;
  }

  if(istrue(cameraclip)) {
    content += contentcache.cameraclip;
  }

  return content;
}

function function_f00c9e807784481e() {
  level.var_dd16da2ec35010ad = {
    #cameraclip: function_95da3996aeae6098(), #waterclip: function_b88b8bd51ea7fe24(), #vehicleclip: function_f3dae12daeb1e8bb(), #itemclip: create_itemclip_contents(), #ainosight: create_ainosight_contents(), #playerclip: create_playerclip_contents(), #vehicle: create_vehicle_contents(), #item: create_item_contents(), #shotclip: create_shotclip_contents(), #glass: create_glass_contents(), #world: create_world_contents(), #character: create_character_contents()
  };
  return level.var_dd16da2ec35010ad;
}

function create_all_contents() {
  content = ["physicscontents_foliage", "physicscontents_foliage_audio", "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_trigger", "physicscontents_vehicle", "physicscontents_useclip"];
  return physics_createcontents(content);
}

function convert_surface_flag(trace) {
  var_ea126d64fbd440ef = physics_getsurfacetypefromflags(trace["surfaceflags"]);
  trace["surfaceindex"] = var_ea126d64fbd440ef["index"];
  trace["surfacetype"] = var_ea126d64fbd440ef["name"];
  return trace;
}

function convert_capsule_data(var_cc43f8a28dc3bc22, var_b26c88a9b9f4ef65, radius, height, angles) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  half_height = height * 0.5;
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  capsule_data = [];
  capsule_data["trace_start"] = var_cc43f8a28dc3bc22 + up * half_height;

  if(isDefined(var_b26c88a9b9f4ef65)) {
    capsule_data["trace_end"] = var_b26c88a9b9f4ef65 + up * half_height;
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

  if(isDefined(trace["<dev string:x201>"])) {
    draw_trace_type(trace["<dev string:x201>"], color, duration);
  }

  if(isDefined(trace[0])) {
    foreach(t in trace) {
      thread draw_trace_hit(t, trace["<dev string:x201>"], color, display_details, duration);
    }

    return;
  }

  thread draw_trace_hit(trace, trace["<dev string:x201>"], color, display_details, duration);
}

function draw_trace_hit(trace, var_42ef1b9ce9e7de9c, color, display_details, duration) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  if(isDefined(trace["<dev string:x20e>"])) {
    half_color = color * 0.25;
    is_white = gettime() / 50 / 2 == int(gettime() / 50 / 2);

    if(is_white) {
      color = (1, 1, 1);
    }

    sphere(trace["<dev string:x20e>"], 5, color, 1, duration);
    line(trace["<dev string:x20e>"], trace["<dev string:x20e>"] + trace["<dev string:x21a>"] * 15, color, 1, 1, duration);

    if(isDefined(display_details) && display_details) {
      cam_angles = level.player getplayerangles();
      cam_up = anglestoup(cam_angles);
      text_scale = 0.25;
      new_line = 11 * text_scale;
      normal_len = 15;

      if(isDefined(trace["<dev string:x224>"])) {
        normal_len = trace["<dev string:x224>"];
      }

      text_pos = trace["<dev string:x20e>"] + trace["<dev string:x21a>"] * normal_len;
      print3d(text_pos, "<dev string:x230>" + trace["<dev string:x20e>"], (1, 1, 1), 1, text_scale, duration);

      if(isDefined(trace["<dev string:x23f>"])) {
        print3d(text_pos - cam_up * new_line * 1, "<dev string:x251>" + trace["<dev string:x23f>"], (1, 1, 1), 1, text_scale, duration);
      } else {
        print3d(text_pos - cam_up * new_line * 1, "<dev string:x260>", (1, 1, 1), 1, text_scale, duration);
      }

      print3d(text_pos - cam_up * new_line * 2, "<dev string:x275>" + trace["<dev string:x21a>"], (1, 1, 1), 1, text_scale, duration);

      if(isDefined(trace["<dev string:x281>"])) {
        print3d(text_pos - cam_up * new_line * 3, "<dev string:x28d>" + trace["<dev string:x281>"], (1, 1, 1), 1, text_scale, duration);
      } else if(isDefined(trace["<dev string:x224>"])) {
        print3d(text_pos - cam_up * new_line * 3, "<dev string:x29b>" + trace["<dev string:x224>"], (1, 1, 1), 1, text_scale, duration);
      } else {
        print3d(text_pos - cam_up * new_line * 3, "<dev string:x2a9>", (1, 1, 1), 1, text_scale, duration);
      }

      if(isDefined(trace["<dev string:x2b3>"])) {
        print3d(text_pos - cam_up * new_line * 4, "<dev string:x2c2>" + trace["<dev string:x2b3>"], (1, 1, 1), 1, text_scale, duration);
      } else {
        print3d(text_pos - cam_up * new_line * 4, "<dev string:x2d4>", (1, 1, 1), 1, text_scale, duration);
      }

      if(isDefined(trace["<dev string:x2f6>"])) {
        print3d(text_pos - cam_up * new_line * 5, "<dev string:x300>", (1, 1, 1), 1, text_scale, duration);
        print3d(text_pos - cam_up * new_line * 6, "<dev string:x315>" + trace["<dev string:x2f6>"] getentitynumber(), (1, 1, 1), 1, text_scale, duration);
        print3d(text_pos - cam_up * new_line * 7, "<dev string:x328>" + trace["<dev string:x2f6>"].classname, (1, 1, 1), 1, text_scale, duration);
        return;
      }

      print3d(text_pos - cam_up * new_line * 5, "<dev string:x33a>", (1, 1, 1), 1, text_scale, duration);
    }
  }
}

function draw_trace_type(debugdata, color, duration) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  half_color = color * 0.75;
  no_color = color * 0.1;
  start = debugdata["<dev string:x350>"];

  if(debugdata["<dev string:x359>"] == "<dev string:x1c>") {
    end = debugdata["<dev string:x361>"];
    dist = distance(debugdata["<dev string:x350>"], debugdata["<dev string:x361>"]);
    sphere(start, 0.15, no_color, 1, duration);
    sphere(end, 0.15, half_color, 1, duration);
    line(start, end, no_color, 1, 0, duration);
    line(start, end, half_color, 1, 1, duration);
    return;
  }

  if(debugdata["<dev string:x359>"] == "<dev string:x9a>") {
    radius = debugdata["<dev string:x368>"];

    if(isDefined(debugdata["<dev string:x361>"])) {
      end = debugdata["<dev string:x361>"];
      dist = distance(debugdata["<dev string:x350>"], debugdata["<dev string:x361>"]);
      count = max(ceil(dist / 128), 1);

      for(i = 0; i <= count; i++) {
        sphere(vectorlerp(start, end, i / count), radius, no_color, 0, duration);
        sphere(vectorlerp(start, end, i / count), radius, half_color, 1, duration);
      }

      line(start, end, no_color, 1, 0, duration);
      line(start, end, half_color, 1, 1, duration);
    } else {
      sphere(start, radius, no_color, 0, duration);
      sphere(start, radius, half_color, 1, duration);
    }

    return;
  }

  if(debugdata["<dev string:x359>"] == "<dev string:xa4>" || debugdata["<dev string:x359>"] == "<dev string:xdf>") {
    if(debugdata["<dev string:x359>"] == "<dev string:xdf>" &isDefined(debugdata["<dev string:xdf>"])) {
      angles = debugdata["<dev string:x372>"];
      capsule_data = debugdata["<dev string:xdf>"] physics_getcharactercollisioncapsule();
      radius = capsule_data["<dev string:x368>"];
      height = capsule_data["<dev string:x37c>"] * 2;
    } else {
      radius = debugdata["<dev string:x368>"];
      angles = debugdata["<dev string:x372>"];
      height = debugdata["<dev string:x38b>"];
    }

    if(isDefined(debugdata["<dev string:x361>"])) {
      end = debugdata["<dev string:x361>"];
      dist = distance(debugdata["<dev string:x350>"], debugdata["<dev string:x361>"]);
      count = max(ceil(dist / 128), 1);

      for(i = 0; i <= count; i++) {
        draw_capsule(vectorlerp(start, end, i / count), radius, height, angles, no_color, 0, duration);
        draw_capsule(vectorlerp(start, end, i / count), radius, height, angles, half_color, 1, duration);
      }

      up = anglestoup(angles);
      start_top = start + up * height;
      end_top = end + up * height;
      line(start, end, no_color, 1, 0, duration);
      line(start, end, half_color, 1, 1, duration);
      line(start_top, end_top, no_color, 1, 0, duration);
      line(start_top, end_top, half_color, 1, 1, duration);
      return;
    }

    draw_capsule(start, radius, height, angles, no_color, 0);
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
  trace["<dev string:x201>"]["<dev string:x359>"] = type;
  trace["<dev string:x201>"]["<dev string:x350>"] = start;
  trace["<dev string:x201>"]["<dev string:x361>"] = end;
  trace["<dev string:x201>"]["<dev string:x368>"] = radius;
  trace["<dev string:x201>"]["<dev string:x38b>"] = height;
  trace["<dev string:x201>"]["<dev string:x372>"] = angles;
  trace["<dev string:x201>"]["<dev string:x395>"] = search_distance;
  trace["<dev string:x201>"]["<dev string:xdf>"] = character;
  return trace;
}

# /