/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\trace.gsc
***********************************************/

ray_trace(start, end, ignore, contentoverride, _id_0EF65BF3909D178E, ignoreclutter, _id_B00C60A54D663CA2) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_F6DBAD2CD5A99BB1 = scripts\engine\utility::ter_op(isDefined(ignoreclutter), ignoreclutter, 0);
  trace = physics_raycast(start, end, _id_C56207BDA09B3A36, ignore, 0, "physicsquery_closest", _id_F6DBAD2CD5A99BB1, _id_B00C60A54D663CA2);

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

ray_trace_ents(start, end, ents, contentoverride, _id_0EF65BF3909D178E, ignoreclutter) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_F6DBAD2CD5A99BB1 = scripts\engine\utility::ter_op(isDefined(ignoreclutter), ignoreclutter, 0);
  trace = physics_raycastents(start, end, _id_C56207BDA09B3A36, ents, 0, "physicsquery_closest", _id_F6DBAD2CD5A99BB1);

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

_bullet_trace(start, end, _id_64E45CE4584053A6, ignore, _id_A1AD41E5813E2B9C, _id_45AB9428A87B2B9F, _id_C368EA2402A6A1AD, _id_8812897BD00BF028, _id_62D3DAE92D988367) {
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"];

  if(_id_64E45CE4584053A6)
    _id_C56207BDA09B3A36[_id_C56207BDA09B3A36.size] = "physicscontents_characterproxy";

  if(isDefined(_id_A1AD41E5813E2B9C) && _id_A1AD41E5813E2B9C)
    _id_C56207BDA09B3A36[_id_C56207BDA09B3A36.size] = "physicscontents_itemclip";

  if(isDefined(_id_C368EA2402A6A1AD) && _id_C368EA2402A6A1AD)
    _id_C56207BDA09B3A36[_id_C56207BDA09B3A36.size] = "physicscontents_vehicleclip";

  if(!isDefined(_id_8812897BD00BF028) || !_id_8812897BD00BF028)
    _id_C56207BDA09B3A36[_id_C56207BDA09B3A36.size] = "physicscontents_clipshot";

  if(!isDefined(_id_62D3DAE92D988367) || _id_62D3DAE92D988367)
    _id_C56207BDA09B3A36[_id_C56207BDA09B3A36.size] = "physicscontents_glass";

  if(isDefined(_id_45AB9428A87B2B9F) && _id_45AB9428A87B2B9F)
    return ray_trace_detail(start, end, ignore, physics_createcontents(_id_C56207BDA09B3A36), 1);
  else
    return ray_trace(start, end, ignore, physics_createcontents(_id_C56207BDA09B3A36), 1);
}

_bullet_trace_passed(start, end, _id_64E45CE4584053A6, ignore) {
  return ray_trace_passed(start, end, ignore, create_default_contents(!_id_64E45CE4584053A6));
}

ray_trace_detail(start, end, ignore, contentoverride, _id_0EF65BF3909D178E, ignoreclutter, _id_B00C60A54D663CA2) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_F6DBAD2CD5A99BB1 = scripts\engine\utility::ter_op(isDefined(ignoreclutter), ignoreclutter, 0);

  if(isDefined(_id_B00C60A54D663CA2))
    trace = physics_raycast(start, end, _id_C56207BDA09B3A36, ignore, 1, "physicsquery_closest", _id_F6DBAD2CD5A99BB1, _id_B00C60A54D663CA2);
  else
    trace = physics_raycast(start, end, _id_C56207BDA09B3A36, ignore, 1, "physicsquery_closest", _id_F6DBAD2CD5A99BB1);

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

ray_trace_get_all_results(start, end, ignore, contentoverride, _id_0EF65BF3909D178E) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_raycast(start, end, _id_C56207BDA09B3A36, ignore, 0, "physicsquery_all");

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E) {
    foreach(_id_AC0E594AC96AA3A8, t in trace)
    trace[_id_AC0E594AC96AA3A8] = convert_surface_flag(t);
  }

  return trace;
}

ray_trace_passed(start, end, ignore, contentoverride) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  return !physics_raycast(start, end, _id_C56207BDA09B3A36, ignore, 0, "physicsquery_any");
}

ray_trace_detail_passed(start, end, ignore, contentoverride) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  return !physics_raycast(start, end, _id_C56207BDA09B3A36, ignore, 1, "physicsquery_any");
}

can_see_origin(origin, _id_EBB58CA93D8FB272) {
  if(!isDefined(_id_EBB58CA93D8FB272))
    _id_EBB58CA93D8FB272 = 1;

  if(!scripts\engine\math::point_in_fov(origin))
    return 0;

  return ray_trace_passed(self getEye(), origin, self, create_contents(_id_EBB58CA93D8FB272, 1, 0, 1, 0, 1));
}

sphere_trace(start, end, radius, ignore, contentoverride, _id_0EF65BF3909D178E, _id_B00C60A54D663CA2) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_spherecast(start, end, radius, _id_C56207BDA09B3A36, ignore, "physicsquery_closest", undefined, _id_B00C60A54D663CA2);

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

sphere_trace_get_all_results(start, end, radius, ignore, contentoverride, _id_0EF65BF3909D178E, _id_B00C60A54D663CA2) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_spherecast(start, end, radius, _id_C56207BDA09B3A36, ignore, "physicsquery_all", undefined, _id_B00C60A54D663CA2);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < trace.size; _id_AC0E594AC96AA3A8++)
      trace[_id_AC0E594AC96AA3A8] = convert_surface_flag(trace[_id_AC0E594AC96AA3A8]);
  }

  return trace;
}

sphere_trace_passed(start, end, radius, ignore, contentoverride) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  return !physics_spherecast(start, end, radius, _id_C56207BDA09B3A36, ignore, "physicsquery_any");
}

sphere_get_closest_point(position, radius, _id_BE3F10A856EEC49D, ignore, contentoverride, _id_0EF65BF3909D178E) {
  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_getclosestpointtosphere(position, radius, _id_BE3F10A856EEC49D, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(position);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

capsule_trace(start, end, radius, height, angles, ignore, contentoverride, _id_0EF65BF3909D178E) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_3AC658A13FFCBFB5 = convert_capsule_data(start, end, radius, height, angles);
  trace = physics_capsulecast(_id_3AC658A13FFCBFB5["trace_start"], _id_3AC658A13FFCBFB5["trace_end"], radius, _id_3AC658A13FFCBFB5["half_height"], angles, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

capsule_trace_get_all_results(start, end, radius, height, angles, ignore, contentoverride, _id_0EF65BF3909D178E) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_3AC658A13FFCBFB5 = convert_capsule_data(start, end, radius, height, angles);
  trace = physics_capsulecast(_id_3AC658A13FFCBFB5["trace_start"], _id_3AC658A13FFCBFB5["trace_end"], radius, _id_3AC658A13FFCBFB5["half_height"], angles, _id_C56207BDA09B3A36, ignore, "physicsquery_all");

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E) {
    foreach(t in trace)
    t = convert_surface_flag(t);
  }

  return trace;
}

capsule_trace_passed(start, end, radius, height, angles, ignore, contentoverride) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_3AC658A13FFCBFB5 = convert_capsule_data(start, end, radius, height, angles);
  return !physics_capsulecast(_id_3AC658A13FFCBFB5["trace_start"], _id_3AC658A13FFCBFB5["trace_end"], radius, _id_3AC658A13FFCBFB5["half_height"], angles, _id_C56207BDA09B3A36, ignore, "physicsquery_any");
}

capsule_get_closest_point(position, radius, height, angles, _id_BE3F10A856EEC49D, ignore, contentoverride, _id_0EF65BF3909D178E) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  _id_3AC658A13FFCBFB5 = convert_capsule_data(position, undefined, radius, height, angles);
  trace = physics_getclosestpointtocapsule(_id_3AC658A13FFCBFB5["trace_start"], radius, _id_3AC658A13FFCBFB5["half_height"], angles, _id_BE3F10A856EEC49D, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(position);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

player_trace(start, end, angles, ignore, contentoverride, _id_0EF65BF3909D178E, _id_E98B3969BBE145D3) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self getplayerangles();

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());

  if(!isDefined(_id_E98B3969BBE145D3))
    _id_E98B3969BBE145D3 = 0;

  trace = physics_charactercast(start, end, self, _id_E98B3969BBE145D3, angles, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

player_trace_get_all_results(start, end, angles, ignore, contentoverride, _id_0EF65BF3909D178E, _id_E98B3969BBE145D3) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self getplayerangles();

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());

  if(!isDefined(_id_E98B3969BBE145D3))
    _id_E98B3969BBE145D3 = 0;

  trace = physics_charactercast(start, end, self, _id_E98B3969BBE145D3, angles, _id_C56207BDA09B3A36, ignore, "physicsquery_all");

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E) {
    foreach(t in trace)
    t = convert_surface_flag(t);
  }

  return trace;
}

player_trace_passed(start, end, angles, ignore, contentoverride, _id_E98B3969BBE145D3) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self getplayerangles();

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());

  if(!isDefined(_id_E98B3969BBE145D3))
    _id_E98B3969BBE145D3 = 0;

  return !physics_charactercast(start, end, self, _id_E98B3969BBE145D3, angles, _id_C56207BDA09B3A36, ignore, "physicsquery_any");
}

player_get_closest_point_static(_id_BE3F10A856EEC49D, ignore, contentoverride, _id_0EF65BF3909D178E) {
  return player_get_closest_point(self.origin, self.angles, _id_BE3F10A856EEC49D, ignore, contentoverride, _id_0EF65BF3909D178E);
}

player_get_closest_point(position, angles, _id_BE3F10A856EEC49D, ignore, contentoverride, _id_0EF65BF3909D178E) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self getplayerangles();

  if(!isDefined(_id_BE3F10A856EEC49D))
    _id_BE3F10A856EEC49D = 0;

  if(isarray(ignore))
    ignore = scripts\engine\utility::array_add(ignore, self);
  else
    ignore = self;

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_default_contents());
  trace = physics_getclosestpointtocharacter(position, self, 0, angles, _id_BE3F10A856EEC49D, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(position);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

ai_trace(start, end, angles, ignore, contentoverride, _id_0EF65BF3909D178E, _id_E98B3969BBE145D3) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self.angles;

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());

  if(!isDefined(_id_E98B3969BBE145D3))
    _id_E98B3969BBE145D3 = 0;

  trace = physics_charactercast(start, end, self, _id_E98B3969BBE145D3, angles, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(end);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

ai_trace_get_all_results(start, end, angles, ignore, contentoverride, _id_0EF65BF3909D178E, _id_E98B3969BBE145D3) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self.angles;

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());

  if(!isDefined(_id_E98B3969BBE145D3))
    _id_E98B3969BBE145D3 = 0;

  trace = physics_charactercast(start, end, self, _id_E98B3969BBE145D3, angles, _id_C56207BDA09B3A36, ignore, "physicsquery_all");

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E) {
    foreach(t in trace)
    t = convert_surface_flag(t);
  }

  return trace;
}

ai_trace_passed(start, end, angles, ignore, contentoverride, _id_E98B3969BBE145D3) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self.angles;

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());

  if(!isDefined(_id_E98B3969BBE145D3))
    _id_E98B3969BBE145D3 = 0;

  return !physics_charactercast(start, end, self, _id_E98B3969BBE145D3, angles, _id_C56207BDA09B3A36, ignore, "physicsquery_any");
}

ai_get_closest_point(position, angles, _id_BE3F10A856EEC49D, ignore, contentoverride, _id_0EF65BF3909D178E) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(angles))
    angles = self.angles;

  if(!isDefined(_id_BE3F10A856EEC49D))
    _id_BE3F10A856EEC49D = 0;

  _id_C56207BDA09B3A36 = scripts\engine\utility::ter_op(isDefined(contentoverride), contentoverride, create_solid_ai_contents());
  trace = physics_getclosestpointtocharacter(position, self, 0, angles, _id_BE3F10A856EEC49D, _id_C56207BDA09B3A36, ignore, "physicsquery_closest");

  if(trace.size)
    trace = trace[0];
  else
    trace = internal_pack_default_trace(position);

  if(isDefined(_id_0EF65BF3909D178E) && _id_0EF65BF3909D178E)
    trace = convert_surface_flag(trace);

  return trace;
}

create_solid_ai_contents(_id_29478236719CFD44) {
  _id_C56207BDA09B3A36 = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(_id_29478236719CFD44) || !_id_29478236719CFD44)
    _id_C56207BDA09B3A36 = scripts\engine\utility::array_add(_id_C56207BDA09B3A36, "physicscontents_characterproxy");

  return physics_createcontents(_id_C56207BDA09B3A36);
}

_id_2D88CB1F022D0989() {
  _id_C56207BDA09B3A36 = ["physicscontents_solid", "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_opaque_ai_contents(_id_A7089085C7D171DF, _id_9575ABC4FBAAFED3) {
  contents = ["physicscontents_ainosight", "physicscontents_vehicle"];

  if(!istrue(_id_A7089085C7D171DF))
    contents[contents.size] = "physicscontents_characterproxy";

  if(!istrue(_id_9575ABC4FBAAFED3))
    contents[contents.size] = "physicscontents_foliage";

  return physics_createcontents(contents);
}

_id_416688B9FFE933C4() {
  contents = ["physicscontents_foliage", "physicscontents_foliage_audio"];
  return physics_createcontents(contents);
}

create_ainosight_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_ainosight"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_world_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_itemclip", "physicscontents_water"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

_id_B88B8BD51EA7FE24() {
  return physics_createcontents(["physicscontents_water"]);
}

create_glass_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_glass"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_ainoshoot_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_ainoshoot"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_item_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_item"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_itemclip_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_itemclip"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_vehicle_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_vehicle"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

_id_F3DAE12DAEB1E8BB() {
  _id_C56207BDA09B3A36 = ["physicscontents_vehicleclip"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_shotclip_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_playerclip_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_playerclip"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_character_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_characterproxy"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

create_default_contents(_id_29478236719CFD44) {
  if(!isDefined(_id_29478236719CFD44))
    _id_29478236719CFD44 = 0;

  return create_contents(!_id_29478236719CFD44, 1, 1, 1, 0, 1);
}

create_contents(_id_7DC3241E7F3C6B24, world, glass, _id_97D66CB843A8EC8F, item, vehicle, _id_41E4FE254D4402FA, _id_8DD8E0F7C10BDCB9, _id_A1AD41E5813E2B9C, _id_B89273D7EA6829D5, _id_F5DBB25343A6DE9A) {
  _id_C56207BDA09B3A36 = 0;

  if(isDefined(_id_7DC3241E7F3C6B24) && _id_7DC3241E7F3C6B24)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_character_contents();

  if(isDefined(world) && world)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_world_contents();

  if(isDefined(glass) && glass)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_glass_contents();

  if(isDefined(_id_97D66CB843A8EC8F) && _id_97D66CB843A8EC8F)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_shotclip_contents();

  if(isDefined(item) && item)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_item_contents();

  if(isDefined(vehicle) && vehicle)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_vehicle_contents();

  if(isDefined(_id_41E4FE254D4402FA) && _id_41E4FE254D4402FA)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_playerclip_contents();

  if(isDefined(_id_8DD8E0F7C10BDCB9) && _id_8DD8E0F7C10BDCB9)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_ainosight_contents();

  if(isDefined(_id_A1AD41E5813E2B9C) && _id_A1AD41E5813E2B9C)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + create_itemclip_contents();

  if(isDefined(_id_B89273D7EA6829D5) && _id_B89273D7EA6829D5)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + _id_F3DAE12DAEB1E8BB();

  if(isDefined(_id_F5DBB25343A6DE9A) && _id_F5DBB25343A6DE9A)
    _id_C56207BDA09B3A36 = _id_C56207BDA09B3A36 + _id_B88B8BD51EA7FE24();

  return _id_C56207BDA09B3A36;
}

create_all_contents() {
  _id_C56207BDA09B3A36 = ["physicscontents_foliage", "physicscontents_foliage_audio", "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_trigger", "physicscontents_vehicle", "physicscontents_useclip"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

convert_surface_flag(trace) {
  _id_EA126D64FBD440EF = physics_getsurfacetypefromflags(trace["surfaceflags"]);
  trace["surfaceindex"] = _id_EA126D64FBD440EF["index"];
  trace["surfacetype"] = _id_EA126D64FBD440EF["name"];
  return trace;
}

convert_capsule_data(_id_CC43F8A28DC3BC22, _id_B26C88A9B9F4EF65, radius, height, angles) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  _id_E86FD4EA1AC5C77A = height * 0.5;
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  _id_3AC658A13FFCBFB5 = [];
  _id_3AC658A13FFCBFB5["trace_start"] = _id_CC43F8A28DC3BC22 + up * _id_E86FD4EA1AC5C77A;

  if(isDefined(_id_B26C88A9B9F4EF65))
    _id_3AC658A13FFCBFB5["trace_end"] = _id_B26C88A9B9F4EF65 + up * _id_E86FD4EA1AC5C77A;

  _id_3AC658A13FFCBFB5["radius"] = radius;
  _id_3AC658A13FFCBFB5["angles"] = angles;
  _id_3AC658A13FFCBFB5["half_height"] = _id_E86FD4EA1AC5C77A;
  return _id_3AC658A13FFCBFB5;
}

draw_trace(trace, color, _id_16EA998B9D34C9E0, duration) {}

draw_trace_hit(trace, _id_42EF1B9CE9E7DE9C, color, _id_16EA998B9D34C9E0, duration) {}

draw_trace_type(debugdata, color, duration) {}

internal_pack_default_trace(pos) {
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

internal_create_debug_data(trace, type, start, end, radius, height, angles, _id_BE3F10A856EEC49D, _id_7DC3241E7F3C6B24) {}