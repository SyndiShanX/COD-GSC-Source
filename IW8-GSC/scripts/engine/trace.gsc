/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\trace.gsc
***********************************************/

function ray_trace(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\engine\utility::ter_op(isDefined(var3), var3, create_default_contents());
  var8 = scripts\engine\utility::ter_op(isDefined(var5), var5, 0);
  var9 = physics_raycast(var0, var1, var7, var2, 0, "physicsquery_closest", var8, var6);

  if(var9.size) {
    var9 = var9[0];
  } else {
    var9 = internal_pack_default_trace(var1);
  }

  if(isDefined(var4) && var4) {
    var9 = convert_surface_flag(var9);
  }

  return var9;
}

function ray_trace_ents(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\utility::ter_op(isDefined(var3), var3, create_default_contents());
  var7 = scripts\engine\utility::ter_op(isDefined(var5), var5, 0);
  var8 = savepotgdata(var0, var1, var6, var2, 0, "physicsquery_closest", var7);

  if(var8.size) {
    var8 = var8[0];
  } else {
    var8 = internal_pack_default_trace(var1);
  }

  if(isDefined(var4) && var4) {
    var8 = convert_surface_flag(var8);
  }

  return var8;
}

function _bullet_trace(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = ["physicscontents_solid", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"];

  if(var2) {
    GscBinSkip0(0x2e, var9.size, "physicscontents_player");
  }

  if(isDefined(var4) && var4) {
    GscBinSkip0(0x2e, var9.size, "physicscontents_itemclip");
  }

  if(isDefined(var6) && var6) {
    GscBinSkip0(0x2e, var9.size, "physicscontents_vehicleclip");
  }

  if(!isDefined(var7) || !var7) {
    GscBinSkip0(0x2e, var9.size, "physicscontents_clipshot");
  }

  if(!isDefined(var8) || var8) {
    GscBinSkip0(0x2e, var9.size, "physicscontents_glass");
  }

  if(isDefined(var5) && var5) {
    return ray_trace_detail(var0, var1, var3, physics_createcontents(var9), 1);
  }

  return ray_trace(var0, var1, var3, physics_createcontents(var9), 1);
}

function _bullet_trace_passed(var0, var1, var2, var3) {
  return ray_trace_passed(var0, var1, var3, create_default_contents(!var2));
}

function ray_trace_detail(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\engine\utility::ter_op(isDefined(var3), var3, create_default_contents());
  var8 = scripts\engine\utility::ter_op(isDefined(var5), var5, 0);

  if(isDefined(var6)) {
    var9 = physics_raycast(var0, var1, var7, var2, 1, "physicsquery_closest", var8, var6);
  } else {
    var9 = physics_raycast(var1, var2, var8, var3, 1, "physicsquery_closest", var9);
  }

  if(var9.size) {
    var9 = var9[0];
  } else {
    var9 = internal_pack_default_trace(var2);
  }

  if(isDefined(var5) && var5) {
    var9 = convert_surface_flag(var9);
  }

  return var9;
}

function ray_trace_get_all_results(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::ter_op(isDefined(var3), var3, create_default_contents());
  var6 = physics_raycast(var0, var1, var5, var2, 0, "physicsquery_all");

  if(isDefined(var4) && var4) {
    foreach(var8 in var6) {
      var6 = convert_surface_flag(var8);
    }
  }

  return var6;
}

function ray_trace_passed(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::ter_op(isDefined(var3), var3, create_default_contents());
  return !physics_raycast(var0, var1, var4, var2, 0, "physicsquery_any");
}

function ray_trace_detail_passed(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::ter_op(isDefined(var3), var3, create_default_contents());
  return !physics_raycast(var0, var1, var4, var2, 1, "physicsquery_any");
}

function can_see_origin(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!scripts\engine\math::point_in_fov(var0)) {
    return false;
  }

  return ray_trace_passed(self getEye(), var0, self, create_contents(var1, 1, 0, 1, 0, 1));
}

function sphere_trace(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());
  var7 = physics_spherecast(var0, var1, var2, var6, var3, "physicsquery_closest");

  if(var7.size) {
    var7 = var7[0];
  } else {
    var7 = internal_pack_default_trace(var1);
  }

  if(isDefined(var5) && var5) {
    var7 = convert_surface_flag(var7);
  }

  return var7;
}

function sphere_trace_get_all_results(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());
  var8 = physics_spherecast(var0, var1, var2, var7, var3, "physicsquery_all", undefined, var6);

  if(isDefined(var5) && var5) {
    for(var9 = 0; var9 < var8.size; var9++) {
      var8 = convert_surface_flag(var8[var9]);
    }
  }

  return var8;
}

function sphere_trace_passed(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());
  return !physics_spherecast(var0, var1, var2, var5, var3, "physicsquery_any");
}

function sphere_get_closest_point(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());
  var7 = physics_getclosestpointtosphere(var0, var1, var2, var6, var3, "physicsquery_closest");

  if(var7.size) {
    var7 = var7[0];
  } else {
    var7 = internal_pack_default_trace(var0);
  }

  if(isDefined(var5) && var5) {
    var7 = convert_surface_flag(var7);
  }

  return var7;
}

function capsule_trace(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var8 = scripts\engine\utility::ter_op(isDefined(var6), var6, create_default_contents());
  var9 = convert_capsule_data(var0, var1, var2, var3, var4);
  var10 = physics_capsulecast(var9["trace_start"], var9["trace_end"], var2, var9["half_height"], var4, var8, var5, "physicsquery_closest");

  if(var10.size) {
    var10 = var10[0];
  } else {
    var10 = internal_pack_default_trace(var1);
  }

  if(isDefined(var7) && var7) {
    var10 = convert_surface_flag(var10);
  }

  return var10;
}

function capsule_trace_get_all_results(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var8 = scripts\engine\utility::ter_op(isDefined(var6), var6, create_default_contents());
  var9 = convert_capsule_data(var0, var1, var2, var3, var4);
  var10 = physics_capsulecast(var9["trace_start"], var9["trace_end"], var2, var9["half_height"], var4, var8, var5, "physicsquery_all");

  if(isDefined(var7) && var7) {
    foreach(var12 in var10) {
      var12 = convert_surface_flag(var12);
    }
  }

  return var10;
}

function capsule_trace_passed(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var7 = scripts\engine\utility::ter_op(isDefined(var6), var6, create_default_contents());
  var8 = convert_capsule_data(var0, var1, var2, var3, var4);
  return !physics_capsulecast(var8["trace_start"], var8["trace_end"], var2, var8["half_height"], var4, var7, var5, "physicsquery_any");
}

function capsule_get_closest_point(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  var8 = scripts\engine\utility::ter_op(isDefined(var6), var6, create_default_contents());
  var9 = convert_capsule_data(var0, undefined, var1, var2, var3);
  var10 = physics_getclosestpointtocapsule(var9["trace_start"], var1, var9["half_height"], var3, var4, var8, var5, "physicsquery_closest");

  if(var10.size) {
    var10 = var10[0];
  } else {
    var10 = internal_pack_default_trace(var0);
  }

  if(isDefined(var7) && var7) {
    var10 = convert_surface_flag(var10);
  }

  return var10;
}

function player_trace(var0, var1, var2, var3, var4, var5, var6) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = self getplayerangles();
  }

  var7 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());

  if(!isDefined(var6)) {
    var6 = 0;
  }

  var8 = physics_charactercast(var0, var1, self, var6, var2, var7, var3, "physicsquery_closest");

  if(var8.size) {
    var8 = var8[0];
  } else {
    var8 = internal_pack_default_trace(var1);
  }

  if(isDefined(var5) && var5) {
    var8 = convert_surface_flag(var8);
  }

  return var8;
}

function player_trace_get_all_results(var0, var1, var2, var3, var4, var5, var6) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = self getplayerangles();
  }

  var7 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());

  if(!isDefined(var6)) {
    var6 = 0;
  }

  var8 = physics_charactercast(var0, var1, self, var6, var2, var7, var3, "physicsquery_all");

  if(isDefined(var5) && var5) {
    foreach(var10 in var8) {
      var10 = convert_surface_flag(var10);
    }
  }

  return var8;
}

function player_trace_passed(var0, var1, var2, var3, var4, var5) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = self getplayerangles();
  }

  var6 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());

  if(!isDefined(var5)) {
    var5 = 0;
  }

  return !physics_charactercast(var0, var1, self, var5, var2, var6, var3, "physicsquery_any");
}

function player_get_closest_point_static(var0, var1, var2, var3) {
  return player_get_closest_point(self.origin, self.angles, var0, var1, var2, var3);
}

function player_get_closest_point(var0, var1, var2, var3, var4, var5) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = self getplayerangles();
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(isarray(var3)) {
    var3 = scripts\engine\utility::array_add(var3, self);
  } else {
    var3 = self;
  }

  var6 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_default_contents());
  var7 = physics_getclosestpointtocharacter(var0, self, 0, var1, var2, var6, var3, "physicsquery_closest");

  if(var7.size) {
    var7 = var7[0];
  } else {
    var7 = internal_pack_default_trace(var0);
  }

  if(isDefined(var5) && var5) {
    var7 = convert_surface_flag(var7);
  }

  return var7;
}

function ai_trace(var0, var1, var2, var3, var4, var5, var6) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = self.angles;
  }

  var7 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_solid_ai_contents());

  if(!isDefined(var6)) {
    var6 = 0;
  }

  var8 = physics_charactercast(var0, var1, self, var6, var2, var7, var3, "physicsquery_closest");

  if(var8.size) {
    var8 = var8[0];
  } else {
    var8 = internal_pack_default_trace(var1);
  }

  if(isDefined(var5) && var5) {
    var8 = convert_surface_flag(var8);
  }

  return var8;
}

function ai_trace_get_all_results(var0, var1, var2, var3, var4, var5, var6) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = self.angles;
  }

  var7 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_solid_ai_contents());

  if(!isDefined(var6)) {
    var6 = 0;
  }

  var8 = physics_charactercast(var0, var1, self, var6, var2, var7, var3, "physicsquery_all");

  if(isDefined(var5) && var5) {
    foreach(var10 in var8) {
      var10 = convert_surface_flag(var10);
    }
  }

  return var8;
}

function ai_trace_passed(var0, var1, var2, var3, var4, var5) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = self.angles;
  }

  var6 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_solid_ai_contents());

  if(!isDefined(var5)) {
    var5 = 0;
  }

  return !physics_charactercast(var0, var1, self, var5, var2, var6, var3, "physicsquery_any");
}

function ai_get_closest_point(var0, var1, var2, var3, var4, var5) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = self.angles;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var6 = scripts\engine\utility::ter_op(isDefined(var4), var4, create_solid_ai_contents());
  var7 = physics_getclosestpointtocharacter(var0, self, 0, var1, var2, var6, var3, "physicsquery_closest");

  if(var7.size) {
    var7 = var7[0];
  } else {
    var7 = internal_pack_default_trace(var0);
  }

  if(isDefined(var5) && var5) {
    var7 = convert_surface_flag(var7);
  }

  return var7;
}

function create_solid_ai_contents(var0) {
  var1 = ["physicscontents_solid", "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(var0) || !var0) {
    var1 = scripts\engine\utility::array_add(var1, "physicscontents_player");
  }

  return physics_createcontents(var1);
}

function init_gas_trap_cloud() {
  var0 = ["physicscontents_solid", "physicscontents_playerclip", "physicscontents_player", "physicscontents_actor", "physicscontents_glass"];
  return physics_createcontents(var0);
}

function init_ground_vehicle(var0, var1) {
  var2 = ["physicscontents_solid", "physicscontents_sky", "physicscontents_ainosight", "physicscontents_vehicle"];

  if(!istrue(var0)) {
    GscBinSkip0(0x2e, var2.size, "physicscontents_actor");
  }

  if(!istrue(var1)) {
    GscBinSkip0(0x2e, var2.size, "physicscontents_foliage");
  }

  return physics_createcontents(var2);
}

function create_ainosight_contents() {
  var0 = ["physicscontents_ainosight"];
  return physics_createcontents(var0);
}

function create_world_contents() {
  var0 = ["physicscontents_solid", "physicscontents_water", "physicscontents_sky"];
  return physics_createcontents(var0);
}

function create_glass_contents() {
  var0 = ["physicscontents_glass"];
  return physics_createcontents(var0);
}

function create_ainoshoot_contents() {
  var0 = ["physicscontents_ainoshoot"];
  return physics_createcontents(var0);
}

function create_item_contents() {
  var0 = ["physicscontents_item"];
  return physics_createcontents(var0);
}

function create_itemclip_contents() {
  var0 = ["physicscontents_itemclip"];
  return physics_createcontents(var0);
}

function create_vehicle_contents() {
  var0 = ["physicscontents_vehicle"];
  return physics_createcontents(var0);
}

function create_shotclip_contents() {
  var0 = ["physicscontents_clipshot", "physicscontents_missileclip"];
  return physics_createcontents(var0);
}

function create_playerclip_contents() {
  var0 = ["physicscontents_playerclip"];
  return physics_createcontents(var0);
}

function create_character_contents() {
  var0 = ["physicscontents_player", "physicscontents_actor"];
  return physics_createcontents(var0);
}

function create_default_contents(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  return create_contents(!var0, 1, 1, 1, 0, 1);
}

function create_contents(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = 0;

  if(isDefined(var0) && var0) {
    var9 += create_character_contents();
  }

  if(isDefined(var1) && var1) {
    var9 += create_world_contents();
  }

  if(isDefined(var2) && var2) {
    var9 += create_glass_contents();
  }

  if(isDefined(var3) && var3) {
    var9 += create_shotclip_contents();
  }

  if(isDefined(var4) && var4) {
    var9 += create_item_contents();
  }

  if(isDefined(var5) && var5) {
    var9 += create_vehicle_contents();
  }

  if(isDefined(var6) && var6) {
    var9 += create_playerclip_contents();
  }

  if(isDefined(var7) && var7) {
    var9 += create_ainosight_contents();
  }

  if(isDefined(var8) && var8) {
    var9 += create_itemclip_contents();
  }

  return var9;
}

function create_all_contents() {
  var0 = ["physicscontents_solid", "physicscontents_foliage", "physicscontents_vehicletrigger", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_sky", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_actor", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_sentienttrigger", "physicscontents_nonsentienttrigger", "physicscontents_vehicle", "physicscontents_mantle", "physicscontents_player", "physicscontents_useclip", "physicscontents_playertrigger"];
  return physics_createcontents(var0);
}

function convert_surface_flag(var0) {
  var1 = physics_getsurfacetypefromflags(var0["surfaceflags"]);
  var0 = var1["index"];
  var0 = var1["name"];
  return var0;
}

function convert_capsule_data(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var5 = var3 * 0.5;
  var6 = anglesToForward(var4);
  var7 = anglestoup(var4);
  var8 = [];
  GscBinSkip0(0x2e, "trace_start", var0 + var7 * var5);
}

function draw_trace(var0, var1, var2, var3) {}

function draw_trace_hit(var0, var1, var2, var3, var4) {}

function draw_trace_type(var0, var1, var2) {}

function internal_pack_default_trace(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "fraction", 1);
}

function internal_create_debug_data(var0, var1, var2, var3, var4, var5, var6, var7, var8) {}