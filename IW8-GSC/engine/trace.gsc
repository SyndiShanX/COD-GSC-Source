/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\trace.gsc
***********************************************/

ray_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);
  var_9 = physics_raycast(var_0, var_1, var_7, var_2, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", var_8, var_6);

  if(var_9.size)
    var_9 = var_9[0];
  else
    var_9 = internal_pack_default_trace(var_1);

  if(isDefined(var_4) && var_4)
    var_9 = convert_surface_flag(var_9);

  return var_9;
}

ray_trace_ents(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_7 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);
  var_8 = savepotgdata(var_0, var_1, var_6, var_2, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", var_7);

  if(var_8.size)
    var_8 = var_8[0];
  else
    var_8 = internal_pack_default_trace(var_1);

  if(isDefined(var_4) && var_4)
    var_8 = convert_surface_flag(var_8);

  return var_8;
}

_bullet_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"];

  if(var_2) {
    var_9[var_9.size] = "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0";
    var_9[var_9.size] = "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763";
  }

  if(isDefined(var_4) && var_4)
    var_9[var_9.size] = "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9";

  if(isDefined(var_6) && var_6)
    var_9[var_9.size] = "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07";

  if(!isDefined(var_7) || !var_7)
    var_9[var_9.size] = "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4";

  if(!isDefined(var_8) || var_8)
    var_9[var_9.size] = "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B";

  if(isDefined(var_5) && var_5)
    return ray_trace_detail(var_0, var_1, var_3, physics_createcontents(var_9), 1);
  else
    return ray_trace(var_0, var_1, var_3, physics_createcontents(var_9), 1);
}

_bullet_trace_passed(var_0, var_1, var_2, var_3) {
  return ray_trace_passed(var_0, var_1, var_3, create_default_contents(!var_2));
}

ray_trace_detail(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);

  if(isDefined(var_6))
    var_9 = physics_raycast(var_0, var_1, var_7, var_2, 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", var_8, var_6);
  else
    var_9 = physics_raycast(var_0, var_1, var_7, var_2, 1, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", var_8);

  if(var_9.size)
    var_9 = var_9[0];
  else
    var_9 = internal_pack_default_trace(var_1);

  if(isDefined(var_4) && var_4)
    var_9 = convert_surface_flag(var_9);

  return var_9;
}

ray_trace_get_all_results(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  var_6 = physics_raycast(var_0, var_1, var_5, var_2, 0, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");

  if(isDefined(var_4) && var_4) {
    foreach(var_9, var_8 in var_6)
    var_6[var_9] = convert_surface_flag(var_8);
  }

  return var_6;
}

ray_trace_passed(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  return !physics_raycast(var_0, var_1, var_4, var_2, 0, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
}

ray_trace_detail_passed(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, create_default_contents());
  return !physics_raycast(var_0, var_1, var_4, var_2, 1, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
}

can_see_origin(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!scripts\engine\math::point_in_fov(var_0))
    return 0;

  return ray_trace_passed(self getEye(), var_0, self, create_contents(var_1, 1, 0, 1, 0, 1));
}

sphere_trace(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_7 = physics_spherecast(var_0, var_1, var_2, var_6, var_3, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_7.size)
    var_7 = var_7[0];
  else
    var_7 = internal_pack_default_trace(var_1);

  if(isDefined(var_5) && var_5)
    var_7 = convert_surface_flag(var_7);

  return var_7;
}

sphere_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_8 = physics_spherecast(var_0, var_1, var_2, var_7, var_3, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9", undefined, var_6);

  if(isDefined(var_5) && var_5) {
    for(var_9 = 0; var_9 < var_8.size; var_9++)
      var_8[var_9] = convert_surface_flag(var_8[var_9]);
  }

  return var_8;
}

sphere_trace_passed(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  return !physics_spherecast(var_0, var_1, var_2, var_5, var_3, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
}

sphere_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_7 = physics_getclosestpointtosphere(var_0, var_1, var_2, var_6, var_3, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_7.size)
    var_7 = var_7[0];
  else
    var_7 = internal_pack_default_trace(var_0);

  if(isDefined(var_5) && var_5)
    var_7 = convert_surface_flag(var_7);

  return var_7;
}

capsule_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_9 = convert_capsule_data(var_0, var_1, var_2, var_3, var_4);
  var_10 = physics_capsulecast(var_9["_encstr_82970CD31AB83E19097FA15093C9"], var_9["_encstr_86580AFD5AD20711E727D880"], var_2, var_9["_encstr_8F0D0C43C21B33EB3456A5D9A11D"], var_4, var_8, var_5, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_10.size)
    var_10 = var_10[0];
  else
    var_10 = internal_pack_default_trace(var_1);

  if(isDefined(var_7) && var_7)
    var_10 = convert_surface_flag(var_10);

  return var_10;
}

capsule_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_9 = convert_capsule_data(var_0, var_1, var_2, var_3, var_4);
  var_10 = physics_capsulecast(var_9["_encstr_82970CD31AB83E19097FA15093C9"], var_9["_encstr_86580AFD5AD20711E727D880"], var_2, var_9["_encstr_8F0D0C43C21B33EB3456A5D9A11D"], var_4, var_8, var_5, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");

  if(isDefined(var_7) && var_7) {
    foreach(var_12 in var_10)
    var_12 = convert_surface_flag(var_12);
  }

  return var_10;
}

capsule_trace_passed(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_7 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_8 = convert_capsule_data(var_0, var_1, var_2, var_3, var_4);
  return !physics_capsulecast(var_8["_encstr_82970CD31AB83E19097FA15093C9"], var_8["_encstr_86580AFD5AD20711E727D880"], var_2, var_8["_encstr_8F0D0C43C21B33EB3456A5D9A11D"], var_4, var_7, var_5, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
}

capsule_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, create_default_contents());
  var_9 = convert_capsule_data(var_0, undefined, var_1, var_2, var_3);
  var_10 = physics_getclosestpointtocapsule(var_9["_encstr_82970CD31AB83E19097FA15093C9"], var_1, var_9["_encstr_8F0D0C43C21B33EB3456A5D9A11D"], var_3, var_4, var_8, var_5, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_10.size)
    var_10 = var_10[0];
  else
    var_10 = internal_pack_default_trace(var_0);

  if(isDefined(var_7) && var_7)
    var_10 = convert_surface_flag(var_10);

  return var_10;
}

player_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = self getplayerangles();

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());

  if(!isDefined(var_6))
    var_6 = 0;

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_8.size)
    var_8 = var_8[0];
  else
    var_8 = internal_pack_default_trace(var_1);

  if(isDefined(var_5) && var_5)
    var_8 = convert_surface_flag(var_8);

  return var_8;
}

player_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = self getplayerangles();

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());

  if(!isDefined(var_6))
    var_6 = 0;

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8)
    var_10 = convert_surface_flag(var_10);
  }

  return var_8;
}

player_trace_passed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = self getplayerangles();

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());

  if(!isDefined(var_5))
    var_5 = 0;

  return !physics_charactercast(var_0, var_1, self, var_5, var_2, var_6, var_3, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
}

player_get_closest_point_static(var_0, var_1, var_2, var_3) {
  return player_get_closest_point(self.origin, self.angles, var_0, var_1, var_2, var_3);
}

player_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = self getplayerangles();

  if(!isDefined(var_2))
    var_2 = 0;

  if(isarray(var_3))
    var_3 = scripts\engine\utility::array_add(var_3, self);
  else
    var_3 = self;

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_default_contents());
  var_7 = physics_getclosestpointtocharacter(var_0, self, 0, var_1, var_2, var_6, var_3, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_7.size)
    var_7 = var_7[0];
  else
    var_7 = internal_pack_default_trace(var_0);

  if(isDefined(var_5) && var_5)
    var_7 = convert_surface_flag(var_7);

  return var_7;
}

ai_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = self.angles;

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());

  if(!isDefined(var_6))
    var_6 = 0;

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_8.size)
    var_8 = var_8[0];
  else
    var_8 = internal_pack_default_trace(var_1);

  if(isDefined(var_5) && var_5)
    var_8 = convert_surface_flag(var_8);

  return var_8;
}

ai_trace_get_all_results(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = self.angles;

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());

  if(!isDefined(var_6))
    var_6 = 0;

  var_8 = physics_charactercast(var_0, var_1, self, var_6, var_2, var_7, var_3, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8)
    var_10 = convert_surface_flag(var_10);
  }

  return var_8;
}

ai_trace_passed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = self.angles;

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());

  if(!isDefined(var_5))
    var_5 = 0;

  return !physics_charactercast(var_0, var_1, self, var_5, var_2, var_6, var_3, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
}

ai_get_closest_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = self.angles;

  if(!isDefined(var_2))
    var_2 = 0;

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, create_solid_ai_contents());
  var_7 = physics_getclosestpointtocharacter(var_0, self, 0, var_1, var_2, var_6, var_3, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(var_7.size)
    var_7 = var_7[0];
  else
    var_7 = internal_pack_default_trace(var_0);

  if(isDefined(var_5) && var_5)
    var_7 = convert_surface_flag(var_7);

  return var_7;
}

create_solid_ai_contents(var_0) {
  var_1 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_87991799DBEBC6C8EB52F9703DC490F0932F4FC3B712014B10", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];

  if(!isDefined(var_0) || !var_0)
    var_1 = scripts\engine\utility::array_add(var_1, "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0");

  return physics_createcontents(var_1);
}

init_gas_trap_cloud() {
  var_0 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B"];
  return physics_createcontents(var_0);
}

init_ground_vehicle(var_0, var_1) {
  var_2 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];

  if(!istrue(var_0)) {
    var_2[var_2.size] = "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763";
    var_2[var_2.size] = "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0";
  }

  if(!istrue(var_1))
    var_2[var_2.size] = "_encstr_9352189FC04FC3636E8BD8B032C32338D363B01C2FE348BB57F2";

  return physics_createcontents(var_2);
}

create_ainosight_contents() {
  var_0 = ["_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"];
  return physics_createcontents(var_0);
}

create_world_contents() {
  var_0 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52"];
  return physics_createcontents(var_0);
}

create_glass_contents() {
  var_0 = ["_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B"];
  return physics_createcontents(var_0);
}

create_ainoshoot_contents() {
  var_0 = ["_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1"];
  return physics_createcontents(var_0);
}

create_item_contents() {
  var_0 = ["_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"];
  return physics_createcontents(var_0);
}

create_itemclip_contents() {
  var_0 = ["_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  return physics_createcontents(var_0);
}

create_vehicle_contents() {
  var_0 = ["_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];
  return physics_createcontents(var_0);
}

create_shotclip_contents() {
  var_0 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80"];
  return physics_createcontents(var_0);
}

create_playerclip_contents() {
  var_0 = ["_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C"];
  return physics_createcontents(var_0);
}

create_character_contents() {
  var_0 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763"];
  return physics_createcontents(var_0);
}

create_default_contents(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  return create_contents(!var_0, 1, 1, 1, 0, 1);
}

create_contents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;

  if(isDefined(var_0) && var_0)
    var_9 = var_9 + create_character_contents();

  if(isDefined(var_1) && var_1)
    var_9 = var_9 + create_world_contents();

  if(isDefined(var_2) && var_2)
    var_9 = var_9 + create_glass_contents();

  if(isDefined(var_3) && var_3)
    var_9 = var_9 + create_shotclip_contents();

  if(isDefined(var_4) && var_4)
    var_9 = var_9 + create_item_contents();

  if(isDefined(var_5) && var_5)
    var_9 = var_9 + create_vehicle_contents();

  if(isDefined(var_6) && var_6)
    var_9 = var_9 + create_playerclip_contents();

  if(isDefined(var_7) && var_7)
    var_9 = var_9 + create_ainosight_contents();

  if(isDefined(var_8) && var_8)
    var_9 = var_9 + create_itemclip_contents();

  return var_9;
}

create_all_contents() {
  var_0 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9352189FC04FC3636E8BD8B032C32338D363B01C2FE348BB57F2", "_encstr_97D01FA3E053423FF936EBEF40E3F7CDA1A0D97B2029BC5F3015E40AEBA9B75715", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_87991799DBEBC6C8EB52F9703DC490F0932F4FC3B712014B10", "_encstr_81DE2010B1A8BACFDE1B4A7240AD3735182F879B33780397F59033CBEB0B472F38D5", "_encstr_A607236B60D3BF2C6067EBFF45A3F703FDBB1112E820E7672081E9FD6D68FBCBABD12A2AD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_853817094B7B56B89B2269E08D542B37039FDFAB07729DD8B5", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_83B318637409E8C34A4F4F4F23E31DC8BC0A0E5BDA7D3009C2AB", "_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"];
  return physics_createcontents(var_0);
}

convert_surface_flag(var_0) {
  var_1 = physics_getsurfacetypefromflags(var_0["_encstr_999F0D032513EF1788D7CC45523773"]);
  var_0["_encstr_82BC0D8BBB9AD85FC26FD3D5834A1B"] = var_1["_encstr_B48F06CC58B0F50B"];
  var_0["_encstr_8BCA0C2BFD504F333E6D7513637B"] = var_1["_encstr_84BA05A8CA852B"];
  return var_0;
}

convert_capsule_data(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_5 = var_3 * 0.5;
  var_6 = anglesToForward(var_4);
  var_7 = anglestoup(var_4);
  var_8 = [];
  var_8["_encstr_82970CD31AB83E19097FA15093C9"] = var_0 + var_7 * var_5;

  if(isDefined(var_1))
    var_8["_encstr_86580AFD5AD20711E727D880"] = var_1 + var_7 * var_5;

  var_8["_encstr_8D4607ABF0ABE4FB47"] = var_2;
  var_8["_encstr_A7610758E6CED8569B"] = var_4;
  var_8["_encstr_8F0D0C43C21B33EB3456A5D9A11D"] = var_5;
  return var_8;
}

draw_trace(var_0, var_1, var_2, var_3) {}

draw_trace_hit(var_0, var_1, var_2, var_3, var_4) {}

draw_trace_type(var_0, var_1, var_2) {}

internal_pack_default_trace(var_0) {
  var_1 = [];
  var_1["_encstr_A53009A25003666B9818C6"] = 1;
  var_1["_encstr_999F0D032513EF1788D7CC45523773"] = 0;
  var_1["_encstr_9138093063275CD9E27627"] = 0;
  var_1["_encstr_BD260953AA97E3F014279D"] = var_0;
  var_1["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"] = var_0;
  var_1["_encstr_820E07FAE8780B3A4C"] = (0, 0, 0);
  var_1["_encstr_8FCC0F8DB7CD47B08DD17D37DB39DA85B1"] = (0, 0, 0);
  var_1["_encstr_AA1C0886968EA32FE056"] = "_encstr_AC4B0D3BD013D433491D6125700D8A";
  return var_1;
}

internal_create_debug_data(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}