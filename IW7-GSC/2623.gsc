/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2623.gsc
***************************************/

ray_trace(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, create_default_contents());
  var_07 = scripts\engine\utility::ter_op(isDefined(var_05), var_05, 0);
  var_08 = physics_raycast(var_00, var_01, var_06, var_02, 0, "physicsquery_closest", var_07);

  if(var_8.size) {
    var_08 = var_8[0];
  } else {
    var_08 = internal_pack_default_trace(var_01);
  }

  if(isDefined(var_04) && var_04) {
    var_08 = convert_surface_flag(var_08);
  }

  return var_08;
}

ray_trace_detail(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, create_default_contents());
  var_07 = scripts\engine\utility::ter_op(isDefined(var_05), var_05, 0);
  var_08 = physics_raycast(var_00, var_01, var_06, var_02, 1, "physicsquery_closest", var_07);

  if(var_8.size) {
    var_08 = var_8[0];
  } else {
    var_08 = internal_pack_default_trace(var_01);
  }

  if(isDefined(var_04) && var_04) {
    var_08 = convert_surface_flag(var_08);
  }

  return var_08;
}

ray_trace_get_all_results(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, create_default_contents());
  var_06 = physics_raycast(var_00, var_01, var_05, var_02, 0, "physicsquery_all");

  if(isDefined(var_04) && var_04) {
    foreach(var_08 in var_06) {
      var_08 = convert_surface_flag(var_08);
    }
  }

  return var_06;
}

ray_trace_passed(var_00, var_01, var_02, var_03) {
  var_04 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, create_default_contents());
  return !physics_raycast(var_00, var_01, var_04, var_02, 0, "physicsquery_any");
}

ray_trace_detail_passed(var_00, var_01, var_02, var_03) {
  var_04 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, create_default_contents());
  return !physics_raycast(var_00, var_01, var_04, var_02, 1, "physicsquery_any");
}

sphere_trace(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());
  var_07 = physics_spherecast(var_00, var_01, var_02, var_06, var_03, "physicsquery_closest");

  if(var_7.size) {
    var_07 = var_7[0];
  } else {
    var_07 = internal_pack_default_trace(var_01);
  }

  if(isDefined(var_05) && var_05) {
    var_07 = convert_surface_flag(var_07);
  }

  return var_07;
}

sphere_trace_get_all_results(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());
  var_07 = physics_spherecast(var_00, var_01, var_02, var_06, var_03, "physicsquery_all");

  if(isDefined(var_05) && var_05) {
    foreach(var_09 in var_07) {
      var_09 = convert_surface_flag(var_09);
    }
  }

  return var_07;
}

sphere_trace_passed(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());
  return !physics_spherecast(var_00, var_01, var_02, var_05, var_03, "physicsquery_any");
}

sphere_get_closest_point(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());
  var_07 = physics_getclosestpointtosphere(var_00, var_01, var_02, var_06, var_03, "physicsquery_closest");

  if(var_7.size) {
    var_07 = var_7[0];
  } else {
    var_07 = internal_pack_default_trace(var_00);
  }

  if(isDefined(var_05) && var_05) {
    var_07 = convert_surface_flag(var_07);
  }

  return var_07;
}

capsule_trace(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_08 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, create_default_contents());
  var_09 = convert_capsule_data(var_00, var_01, var_02, var_03, var_04);
  var_10 = physics_capsulecast(var_9["trace_start"], var_9["trace_end"], var_02, var_9["half_height"], var_04, var_08, var_05, "physicsquery_closest");

  if(var_10.size) {
    var_10 = var_10[0];
  } else {
    var_10 = internal_pack_default_trace(var_01);
  }

  if(isDefined(var_07) && var_07) {
    var_10 = convert_surface_flag(var_10);
  }

  return var_10;
}

capsule_trace_get_all_results(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_08 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, create_default_contents());
  var_09 = convert_capsule_data(var_00, var_01, var_02, var_03, var_04);
  var_10 = physics_capsulecast(var_9["trace_start"], var_9["trace_end"], var_02, var_9["half_height"], var_04, var_08, var_05, "physicsquery_all");

  if(isDefined(var_07) && var_07) {
    foreach(var_12 in var_10) {
      var_12 = convert_surface_flag(var_12);
    }
  }

  return var_10;
}

capsule_trace_passed(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_07 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, create_default_contents());
  var_08 = convert_capsule_data(var_00, var_01, var_02, var_03, var_04);
  return !physics_capsulecast(var_8["trace_start"], var_8["trace_end"], var_02, var_8["half_height"], var_04, var_07, var_05, "physicsquery_any");
}

capsule_get_closest_point(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(var_03)) {
    var_03 = (0, 0, 0);
  }

  var_08 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, create_default_contents());
  var_09 = convert_capsule_data(var_00, undefined, var_01, var_02, var_03);
  var_10 = physics_getclosestpointtocapsule(var_9["trace_start"], var_01, var_9["half_height"], var_03, var_04, var_08, var_05, "physicsquery_closest");

  if(var_10.size) {
    var_10 = var_10[0];
  } else {
    var_10 = internal_pack_default_trace(var_00);
  }

  if(isDefined(var_07) && var_07) {
    var_10 = convert_surface_flag(var_10);
  }

  return var_10;
}

player_trace(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = self getplayerangles();
  }

  var_07 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());

  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  var_08 = physics_charactercast(var_00, var_01, self, var_06, var_02, var_07, var_03, "physicsquery_closest");

  if(var_8.size) {
    var_08 = var_8[0];
  } else {
    var_08 = internal_pack_default_trace(var_01);
  }

  if(isDefined(var_05) && var_05) {
    var_08 = convert_surface_flag(var_08);
  }

  return var_08;
}

player_trace_get_all_results(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = self getplayerangles();
  }

  var_07 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());

  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  var_08 = physics_charactercast(var_00, var_01, self, var_06, var_02, var_07, var_03, "physicsquery_all");

  if(isDefined(var_05) && var_05) {
    foreach(var_10 in var_08) {
      var_10 = convert_surface_flag(var_10);
    }
  }

  return var_08;
}

player_trace_passed(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = self getplayerangles();
  }

  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  return !physics_charactercast(var_00, var_01, self, var_05, var_02, var_06, var_03, "physicsquery_any");
}

player_get_closest_point_static(var_00, var_01, var_02, var_03) {
  return player_get_closest_point(self.origin, self.angles, var_00, var_01, var_02, var_03);
}

player_get_closest_point(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = self getplayerangles();
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  if(isarray(var_03)) {
    var_03 = scripts\engine\utility::array_add(var_03, self);
  } else {
    var_03 = self;
  }

  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());
  var_07 = physics_getclosestpointtocharacter(var_00, self, 0, var_01, var_02, var_06, var_03, "physicsquery_closest");

  if(var_7.size) {
    var_07 = var_7[0];
  } else {
    var_07 = internal_pack_default_trace(var_00);
  }

  if(isDefined(var_05) && var_05) {
    var_07 = convert_surface_flag(var_07);
  }

  return var_07;
}

ai_trace(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = self.angles;
  }

  var_07 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());

  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  var_08 = physics_charactercast(var_00, var_01, self, var_06, var_02, var_07, var_03, "physicsquery_closest");

  if(var_8.size) {
    var_08 = var_8[0];
  } else {
    var_08 = internal_pack_default_trace(var_01);
  }

  if(isDefined(var_05) && var_05) {
    var_08 = convert_surface_flag(var_08);
  }

  return var_08;
}

ai_trace_get_all_results(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = self.angles;
  }

  var_07 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());

  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  var_08 = physics_charactercast(var_00, var_01, self, var_06, var_02, var_07, var_03, "physicsquery_all");

  if(isDefined(var_05) && var_05) {
    foreach(var_10 in var_08) {
      var_10 = convert_surface_flag(var_10);
    }
  }

  return var_08;
}

ai_trace_passed(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = self.angles;
  }

  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  return !physics_charactercast(var_00, var_01, self, var_05, var_02, var_06, var_03, "physicsquery_any");
}

ai_get_closest_point(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = self.angles;
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_06 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, create_default_contents());
  var_07 = physics_getclosestpointtocharacter(var_00, self, var_01, var_02, var_06, var_03, "physicsquery_closest");

  if(var_7.size) {
    var_07 = var_7[0];
  } else {
    var_07 = internal_pack_default_trace(var_00);
  }

  if(isDefined(var_05) && var_05) {
    var_07 = convert_surface_flag(var_07);
  }

  return var_07;
}

create_solid_ai_contents(var_00) {
  var_01 = ["physicscontents_solid", "physicscontents_monsterclip", "physicscontents_aiavoid", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(var_00) || !var_00) {
    var_01 = scripts\engine\utility::array_add(var_01, "physicscontents_player");
  }

  return physics_createcontents(var_01);
}

create_world_contents() {
  var_00 = ["physicscontents_solid", "physicscontents_water", "physicscontents_sky"];
  return physics_createcontents(var_00);
}

create_glass_contents() {
  var_00 = ["physicscontents_glass"];
  return physics_createcontents(var_00);
}

create_item_contents() {
  var_00 = ["physicscontents_item"];
  return physics_createcontents(var_00);
}

create_vehicle_contents() {
  var_00 = ["physicscontents_vehicle"];
  return physics_createcontents(var_00);
}

create_shotclip_contents() {
  var_00 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip"];
  return physics_createcontents(var_00);
}

create_playerclip_contents() {
  var_00 = ["physicscontents_playerclip"];
  return physics_createcontents(var_00);
}

create_character_contents() {
  var_00 = ["physicscontents_player", "physicscontents_actor"];
  return physics_createcontents(var_00);
}

create_default_contents(var_00) {
  if(!isDefined(var_00)) {
    var_00 = 0;
  }

  return create_contents(!var_00, 1, 1, 1, 0, 1);
}

create_contents(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = 0;

  if(isDefined(var_00) && var_00) {
    var_07 = var_07 + create_character_contents();
  }

  if(isDefined(var_01) && var_01) {
    var_07 = var_07 + create_world_contents();
  }

  if(isDefined(var_02) && var_02) {
    var_07 = var_07 + create_glass_contents();
  }

  if(isDefined(var_03) && var_03) {
    var_07 = var_07 + create_shotclip_contents();
  }

  if(isDefined(var_04) && var_04) {
    var_07 = var_07 + create_item_contents();
  }

  if(isDefined(var_05) && var_05) {
    var_07 = var_07 + create_vehicle_contents();
  }

  if(isDefined(var_06) && var_06) {
    var_07 = var_07 + create_playerclip_contents();
  }

  return var_07;
}

create_all_contents() {
  var_00 = ["physicscontents_solid", "physicscontents_foliage", "physicscontents_aiavoid", "physicscontents_vehicletrigger", "physicscontents_glass", "physicscontents_water", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_sky", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_actor", "physicscontents_corpseclipshot", "physicscontents_playerclip", "physicscontents_monsterclip", "physicscontents_sentienttrigger", "physicscontents_teamtrigger", "physicscontents_use", "physicscontents_nonsentienttrigger", "physicscontents_vehicle", "physicscontents_mantle", "physicscontents_player", "physicscontents_corpse", "physicscontents_detail", "physicscontents_structural", "physicscontents_translucent", "physicscontents_playertrigger", "physicscontents_nodrop"];
  return physics_createcontents(var_00);
}

convert_surface_flag(var_00) {
  var_01 = _physics_getsurfacetypefromflags(var_0["surfaceflags"]);
  var_0["surfaceindex"] = var_1["index"];
  var_0["surfacetype"] = var_1["name"];
  return var_00;
}

convert_capsule_data(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_05 = var_03 * 0.5;
  var_06 = anglesToForward(var_04);
  var_07 = anglestoup(var_04);
  var_08 = [];
  var_8["trace_start"] = var_00 + var_07 * var_05;

  if(isDefined(var_01)) {
    var_8["trace_end"] = var_01 + var_07 * var_05;
  }

  var_8["radius"] = var_02;
  var_8["angles"] = var_04;
  var_8["half_height"] = var_05;
  return var_08;
}

draw_trace(var_00, var_01, var_02, var_03) {}

draw_trace_hit(var_00, var_01, var_02, var_03, var_04) {}

draw_trace_type(var_00, var_01, var_02) {}

internal_pack_default_trace(var_00) {
  var_01 = [];
  var_1["fraction"] = 1;
  var_1["surfaceflags"] = 0;
  var_1["distance"] = 0;
  var_1["position"] = var_00;
  var_1["shape_position"] = var_00;
  var_1["normal"] = (0, 0, 0);
  var_1["contact_normal"] = (0, 0, 0);
  var_1["hittype"] = "hittype_none";
  return var_01;
}

internal_create_debug_data(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {}