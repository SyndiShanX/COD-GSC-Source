/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\trace.gsc
***********************************************/

function ray_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);
  var_9 = physics_raycast(var_0, var_1, var_7, var_2, 0, "physicsquery_closest", var_8, var_6);

  if(var_9.size) {
    var_9 = var_9[0];
  } else {
    var_9 = internal_pack_default_trace(var_1);
  }

  if(isDefined(var_4) && var_4) {
    var_9 = convert_surface_flag(var_9);
  }

  return var_9;
}

function ray_trace_ents(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_7 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);
  var_8 = savepotgdata(var_0, var_1, var_6, var_2, 0, "physicsquery_closest", var_7);

  if(var_8.size) {
    var_8 = var_8[0];
  } else {
    var_8 = internal_pack_default_trace(var_1);
  }

  if(isDefined(var_4) && var_4) {
    var_8 = convert_surface_flag(var_8);
  }

  return var_8;
}

function _bullet_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = ["physicscontents_solid", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"];

  if(var_2) {
    GscBinSkip0(0x2e, var_9.size, "physicscontents_player");
  }

  if(isDefined(var_4) && var_4) {
    GscBinSkip0(0x2e, var_9.size, "physicscontents_itemclip");
  }

  if(isDefined(var_6) && var_6) {
    GscBinSkip0(0x2e, var_9.size, "physicscontents_vehicleclip");
  }

  if(!isDefined(var_7) || !var_7) {
    GscBinSkip0(0x2e, var_9.size, "physicscontents_clipshot");
  }

  if(!isDefined(var_8) || var_8) {
    GscBinSkip0(0x2e, var_9.size, "physicscontents_glass");
  }

  if(isDefined(var_5) && var_5) {
    return ray_trace_detail(var_0, var_1, var_3, physics_createcontents(var_9), 1);
  }

  return ray_trace(var_0, var_1, var_3, physics_createcontents(var_9), 1);
}

function _bullet_trace_passed(var_0, var_1, var_2, var_3) {
  return ray_trace_passed(var_0, var_1, var_3, create_default_contents(!var_2));
}

function ray_trace_detail(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);

  if(isDefined(var_6)) {
    var_9 = physics_raycast(var_0, var_1, var_7, var_2, 1, "physicsquery_closest", var_8, var_6);
  } else {
    var_9 = physics_raycast(var_1, var_2, var_8, var_3, 1, "physicsquery_closest", var_9);
  }

  if(var_9.size) {
    var_9 = var_9[0];
  } else {
    var_9 = internal_pack_default_trace(var_2);
  }

  if(isDefined(var_5) && var_5) {
    var_9 = convert_surface_flag(var_9);
  }

  return var_9;
}

function ray_trace_get_all_results(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_6 = physics_raycast(var_0, var_1, var_5, var_2, 0, "physicsquery_all");

  if(isDefined(var_4) && var_4) {
    foreach(var_8 in var_6) {
      var_6 = convert_surface_flag(var_8);
    }
  }

  return var_6;
}

function ray_trace_passed(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  return !physics_raycast(var_0, var_1, var_4, var_2, 0, "physicsquery_any");
}

function ray_trace_detail_passed(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  return !physics_raycast(var_0, var_1, var_4, var_2, 1, "physicsquery_any");
}

function can_see_origin(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!scripts\engine\math::point_in_fov(var_0)) {
    return false;
  }

  return ray_trace_passed(self getEye(), var_0, self, create_contents(var_1, 1, 0, 1, 0, 1));
}

function sphere_trace(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_7 = physics_spherecast(var_0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = internal_pack_default_trace(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = convert_surface_flag(var_7);
  }

  return var_7;
}

function sphere_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_8 = physics_spherecast(var_0, var_1, var_2, var_7, var_3, "physicsquery_all", undefined, var_6);

  if(isDefined(var_5) && var_5) {
    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      var_8 = convert_surface_flag(var_8[var_9]);
    }
  }

  return var_8;
}

function sphere_trace_passed(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  return !physics_spherecast(var_0, var_1, var_2, var_5, var_3, "physicsquery_any");
}

function sphere_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_7 = physics_getclosestpointtosphere(var_0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = internal_pack_default_trace(var_0);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = convert_surface_flag(var_7);
  }

  return var_7;
}

function capsule_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_9 = convert_capsule_data(var_0, var_1, var_2, var_3, var_4);
  var_10 = physics_capsulecast(var_9["trace_start"], var_9["trace_end"], var_2, var_9["half_height"], var_4, var_8, var_5, "physicsquery_closest");

  if(var_10.size) {
    var_10 = var_10[0];
  } else {
    var_10 = internal_pack_default_trace(var_1);
  }

  if(isDefined(var_7) && var_7) {
    var_10 = convert_surface_flag(var_10);
  }

  return var_10;
}

function capsule_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_9 = convert_capsule_data(var_0, var_1, var_2, var_3, var_4);
  var_10 = physics_capsulecast(var_9["trace_start"], var_9["trace_end"], var_2, var_9["half_height"], var_4, var_8, var_5, "physicsquery_all");

  if(isDefined(var_7) && var_7) {
    foreach(var_12 in var_10) {
      var_12 = convert_surface_flag(var_12);
    }
  }

  return var_10;
}

function capsule_trace_passed(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_8 = convert_capsule_data(var_0, var_1, var_2, var_3, var_4);
  return !physics_capsulecast(var_8["trace_start"], var_8["trace_end"], var_2, var_8["half_height"], var_4, var_7, var_5, "physicsquery_any");
}

function capsule_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_9 = convert_capsule_data(var_0, undefined, var_1, var_2, var_3);
  var_10 = physics_getclosestpointtocapsule(var_9["trace_start"], var_1, var_9["half_height"], var_3, var_4, var_8, var_5, "physicsquery_closest");

  if(var_10.size) {
    var_10 = var_10[0];
  } else {
    var_10 = internal_pack_default_trace(var_0);
  }

  if(isDefined(var_7) && var_7) {
    var_10 = convert_surface_flag(var_10);
  }

  return var_10;
}

function player_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = self getplayerangles();
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_closest");

  if(var_8.size) {
    var_8 = var_8[0];
  } else {
    var_8 = internal_pack_default_trace(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_8 = convert_surface_flag(var_8);
  }

  return var_8;
}

function player_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = self getplayerangles();
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_all");

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8) {
      var_10 = convert_surface_flag(var_10);
    }
  }

  return var_8;
}

function player_trace_passed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = self getplayerangles();
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return !physics_charactercast(var_0, var_1, self, var_5, var_2, var_6, var_3, "physicsquery_any");
}

function player_get_closest_point_static(var_0, var_1, var_2, var_3) {
  return player_get_closest_point(self.origin, self.angles, var_0, var_1, var_2, var_3);
}

function player_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = self getplayerangles();
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isarray(var_3)) {
    var_3 = scripts\engine\utility::array_add(var_3, self);
  } else {
    var_3 = self;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_7 = physics_getclosestpointtocharacter(var_0, self, 0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = internal_pack_default_trace(var_0);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = convert_surface_flag(var_7);
  }

  return var_7;
}

function ai_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_closest");

  if(var_8.size) {
    var_8 = var_8[0];
  } else {
    var_8 = internal_pack_default_trace(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_8 = convert_surface_flag(var_8);
  }

  return var_8;
}

function ai_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_all");

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8) {
      var_10 = convert_surface_flag(var_10);
    }
  }

  return var_8;
}

function ai_trace_passed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return !physics_charactercast(var_0, var_1, self, var_5, var_2, var_6, var_3, "physicsquery_any");
}

function ai_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());
  var_7 = physics_getclosestpointtocharacter(var_0, self, 0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = internal_pack_default_trace(var_0);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = convert_surface_flag(var_7);
  }

  return var_7;
}

function create_solid_ai_contents(var_0) {
  var_1 = ["physicscontents_solid", "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(var_0) || !var_0) {
    var_1 = scripts\engine\utility::array_add(var_1, "physicscontents_player");
  }

  return physics_createcontents(var_1);
}

function init_gas_trap_cloud() {
  var_0 = ["physicscontents_solid", "physicscontents_playerclip", "physicscontents_player", "physicscontents_actor", "physicscontents_glass"];
  return physics_createcontents(var_0);
}

function init_ground_vehicle(var_0, var_1) {
  var_2 = ["physicscontents_solid", "physicscontents_sky", "physicscontents_ainosight", "physicscontents_vehicle"];

  if(!istrue(var_0)) {
    GscBinSkip0(0x2e, var_2.size, "physicscontents_actor");
  }

  if(!istrue(var_1)) {
    GscBinSkip0(0x2e, var_2.size, "physicscontents_foliage");
  }

  return physics_createcontents(var_2);
}

function create_ainosight_contents() {
  var_0 = ["physicscontents_ainosight"];
  return physics_createcontents(var_0);
}

function create_world_contents() {
  var_0 = ["physicscontents_solid", "physicscontents_water", "physicscontents_sky"];
  return physics_createcontents(var_0);
}

function create_glass_contents() {
  var_0 = ["physicscontents_glass"];
  return physics_createcontents(var_0);
}

function create_ainoshoot_contents() {
  var_0 = ["physicscontents_ainoshoot"];
  return physics_createcontents(var_0);
}

function create_item_contents() {
  var_0 = ["physicscontents_item"];
  return physics_createcontents(var_0);
}

function create_itemclip_contents() {
  var_0 = ["physicscontents_itemclip"];
  return physics_createcontents(var_0);
}

function create_vehicle_contents() {
  var_0 = ["physicscontents_vehicle"];
  return physics_createcontents(var_0);
}

function create_shotclip_contents() {
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip"];
  return physics_createcontents(var_0);
}

function create_playerclip_contents() {
  var_0 = ["physicscontents_playerclip"];
  return physics_createcontents(var_0);
}

function create_character_contents() {
  var_0 = ["physicscontents_player", "physicscontents_actor"];
  return physics_createcontents(var_0);
}

function create_default_contents(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  return create_contents(!var_0, 1, 1, 1, 0, 1);
}

function create_contents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;

  if(isDefined(var_0) && var_0) {
    var_9 += create_character_contents();
  }

  if(isDefined(var_1) && var_1) {
    var_9 += create_world_contents();
  }

  if(isDefined(var_2) && var_2) {
    var_9 += create_glass_contents();
  }

  if(isDefined(var_3) && var_3) {
    var_9 += create_shotclip_contents();
  }

  if(isDefined(var_4) && var_4) {
    var_9 += create_item_contents();
  }

  if(isDefined(var_5) && var_5) {
    var_9 += create_vehicle_contents();
  }

  if(isDefined(var_6) && var_6) {
    var_9 += create_playerclip_contents();
  }

  if(isDefined(var_7) && var_7) {
    var_9 += create_ainosight_contents();
  }

  if(isDefined(var_8) && var_8) {
    var_9 += create_itemclip_contents();
  }

  return var_9;
}

function create_all_contents() {
  var_0 = ["physicscontents_solid", "physicscontents_foliage", "physicscontents_vehicletrigger", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_sky", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_actor", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_sentienttrigger", "physicscontents_nonsentienttrigger", "physicscontents_vehicle", "physicscontents_mantle", "physicscontents_player", "physicscontents_useclip", "physicscontents_playertrigger"];
  return physics_createcontents(var_0);
}

function convert_surface_flag(var_0) {
  var_1 = physics_getsurfacetypefromflags(var_0["surfaceflags"]);
  var_0 = var_1["index"];
  var_0 = var_1["name"];
  return var_0;
}

function convert_capsule_data(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_5 = var_3 * 0.5;
  var_6 = anglesToForward(var_4);
  var_7 = anglestoup(var_4);
  var_8 = [];
  GscBinSkip0(0x2e, "trace_start", var_0 + var_7 * var_5);
}

function draw_trace(var_0, var_1, var_2, var_3) {}

function draw_trace_hit(var_0, var_1, var_2, var_3, var_4) {}

function draw_trace_type(var_0, var_1, var_2) {}

function internal_pack_default_trace(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, "fraction", 1);
}

function internal_create_debug_data(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}