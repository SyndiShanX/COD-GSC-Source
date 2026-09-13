/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\molotov.gsc
***********************************************/

molotov_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.molotov = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.maxpools = getdvarint("dvar_541E147E1379B35E", 100);
  _id_962A30A9BB8C0F09.maxcastsperframe = getdvarint("dvar_3B54AD814E59B401", 8);
  _id_962A30A9BB8C0F09.immediatecleanup = getdvarint("dvar_EC13DC5B3AE7D79C", 1) > 0;
  _id_962A30A9BB8C0F09.uniquepoolid = 0;
  _id_962A30A9BB8C0F09.poolids = [];
  _id_962A30A9BB8C0F09.scriptables = [];
  _id_962A30A9BB8C0F09.triggers = [];
  _id_962A30A9BB8C0F09.frametimestamp = 0;
  _id_962A30A9BB8C0F09.caststhisframe = 0;

  if(istrue(level._id_289DF80E1DED586F)) {
    level.g_effect["vfx_burn_med_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx");
    level.g_effect["vfx_burn_sml_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx");
    level.g_effect["vfx_burn_sml_head_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx");
  }

  molotov_init_cast_data();
  molotov_init_pool_data();
}

molotov_init_cast_data() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  castdata = _id_962A30A9BB8C0F09.castdata;

  if(!isDefined(castdata)) {
    castdata = spawnStruct();
    _id_962A30A9BB8C0F09.castdata = castdata;
  }

  castdata.distforward = [];
  castdata.distdown = [];
  castdata.distup = [];
  castdata.maxcasts = [];
  castdata.maxfails = [];
  castdata.maxents = [];
  castdata.firstforwarddist = [];
  castdata.firstforwardmindist = [];
  castdata.firstforwardmodanglesfunc = [];
  id = 4;
  castdata.distforward[id] = undefined;
  castdata.distdown[id] = undefined;
  castdata.distup[id] = undefined;
  castdata.maxcasts[id] = undefined;
  castdata.maxfails[id] = undefined;
  castdata.maxents[id] = 1;
  id = 8;
  castdata.distforward[id] = 50;
  castdata.distdown[id] = 50;
  castdata.distup[id] = 25;
  castdata.maxcasts[id] = 4;
  castdata.maxfails[id] = 3;
  castdata.maxents[id] = 1;
  castdata.distforwardwall[id] = 25;
  id = 16;
  castdata.distforward[id] = 15;
  castdata.distdown[id] = 50;
  castdata.distup[id] = 25;
  castdata.maxcasts[id] = 17;
  castdata.maxfails[id] = 3;
  castdata.maxents[id] = 3;
  castdata.firstforwarddist[id] = 85;
  castdata.firstforwardmindist[id] = 8;
  castdata.distforwardwall[id] = 8;
  castdata.firstforwarddistwall[id] = 44;
}

molotov_init_pool_data() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  pooldata = _id_962A30A9BB8C0F09.pooldata;

  if(!isDefined(pooldata)) {
    pooldata = spawnStruct();
    _id_962A30A9BB8C0F09.pooldata = pooldata;
  }

  pooldata.triggerradius = [];
  pooldata.triggerheight = [];
  pooldata.triggeroffset = [];
  pooldata.startdelayms = [];
  id = 4;
  pooldata.triggerradius[id] = 30;
  pooldata.triggerheight[id] = 55;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 0;
  id = 8;
  pooldata.triggerradius[id] = 30;
  pooldata.triggerheight[id] = 55;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 100;
  id = 16;
  pooldata.triggerradius[id] = 10;
  pooldata.triggerheight[id] = 55;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 100;
  molotov_init_pool_mask();
}

molotov_init_pool_mask() {
  _id_DCF9401F976E906F = molotov_get_pool_level_data();
  _id_6F6EFEC7E89387E8 = [];
  _id_6F6EFEC7E89387E8[4] = "coreCenter";
  _id_6F6EFEC7E89387E8[8] = "core";
  _id_6F6EFEC7E89387E8[16] = "tendril";
  _id_6F6EFEC7E89387E8[1] = "";
  _id_6F6EFEC7E89387E8[2] = "DieDown";
  _id_6F6EFEC7E89387E8[32] = "";
  _id_6F6EFEC7E89387E8[64] = "Wall";
  _id_6F6EFEC7E89387E8[128] = "Ceil";
  scriptablestates = [];
  _id_E42C4A59211C25AA = 1;
  _id_A56FFA08FD7C6E21 = 4;
  _id_880B6BD9B71C4ABC = 32;

  for(_id_DFCFA94F575DB98D = _id_E42C4A59211C25AA;
    (_id_DFCFA94F575DB98D & 3) > 0; _id_DFCFA94F575DB98D = _id_DFCFA94F575DB98D << 1) {
    for(_id_5EE7711499BF12C4 = _id_A56FFA08FD7C6E21;
      (_id_5EE7711499BF12C4 & 28) > 0; _id_5EE7711499BF12C4 = _id_5EE7711499BF12C4 << 1) {
      for(_id_EBB5A5E5F2FAFC4B = _id_880B6BD9B71C4ABC;
        (_id_EBB5A5E5F2FAFC4B & 224) > 0; _id_EBB5A5E5F2FAFC4B = _id_EBB5A5E5F2FAFC4B << 1) {
        mask = _id_DFCFA94F575DB98D | _id_5EE7711499BF12C4 | _id_EBB5A5E5F2FAFC4B;
        scriptablestates[mask] = _id_6F6EFEC7E89387E8[_id_5EE7711499BF12C4] + _id_6F6EFEC7E89387E8[_id_DFCFA94F575DB98D] + _id_6F6EFEC7E89387E8[_id_EBB5A5E5F2FAFC4B];
        mask = _id_5EE7711499BF12C4 | _id_EBB5A5E5F2FAFC4B;
        scriptablestates[mask] = "neutral";
      }
    }
  }

  _id_DCF9401F976E906F.scriptablestates = scriptablestates;
}

molotov_on_give(equipmentref, slot, variantid) {
  thread molotov_watch_fx();
}

molotov_on_take(equipmentref, slot) {
  self notify("molotov_taken");
}

molotov_used(grenade) {
  grenade endon("death");
  grenade endon("molotov_water_impact");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    grenade endon("missile_water_impact");
    thread _id_E56975D29612C12A(grenade);
  }

  _id_6951CF1F43BC8EBE = self getgunangles();
  _id_8011CFFB839E8243 = gettime();
  _id_7331D469160F6A41 = anglesToForward(_id_6951CF1F43BC8EBE) * 940 + anglestoup(_id_6951CF1F43BC8EBE) * 120;
  thread molotov_cleanup_grenade(grenade);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(level.gamemodemolotovfunc))
    [[level.gamemodemolotovfunc]](grenade, self);

  _id_42F65B4B53C1F5D4 = (gettime() - _id_8011CFFB839E8243) / 1000;
  _id_CEAB23E7A7E95404 = _id_7331D469160F6A41 + (0, 0, -800 * _id_42F65B4B53C1F5D4);

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto)))
    thread molotov_stuck_player(grenade, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404);
  else
    thread molotov_stuck(grenade, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404);
}

_id_E56975D29612C12A(grenade) {
  grenade endon("explode");
  self endon("death");
  grenade waittill("missile_water_impact");
  grenade delete();
}

molotov_stuck(grenade, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404) {
  angles = undefined;
  forward = vectorNormalize(_id_CEAB23E7A7E95404);
  up = anglestoup(grenade.angles);
  right = anglestoright(_id_6951CF1F43BC8EBE);

  if(abs(vectordot(forward, up)) >= 0.9848)
    angles = molotov_rebuild_angles_up_right(up, right);
  else
    angles = molotov_rebuild_angles_up_forward(up, forward);

  grenade.angles = angles;
  grenade.exploding = 1;
  grenade setscriptablepartstate("effects", "explode", 0);
  grenade missilehidetrail();
  grenade notify("death");
  molotov_simulate_impact(grenade, grenade.origin, angles, stuckto, _id_CEAB23E7A7E95404, gettime());
}

molotov_stuck_player(grenade, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404) {
  scripts\mp\weapons::grenadestuckto(grenade, stuckto);
  stuckto thread molotov_burn_for_time(6, self, grenade, grenade);
  grenade.exploding = 1;
  grenade setscriptablepartstate("effects", "explode", 0);
  grenade missilehidetrail();
  _id_CEAB23E7A7E95404 = _id_CEAB23E7A7E95404 * (0, 0, 1);
  caststart = grenade.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = molotov_get_cast_contents();
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    castend = _id_E021C2744CC7ED68[0]["position"];
    _id_A95D04F8F906E839 = _id_E021C2744CC7ED68[0]["normal"];
    _id_8D3DD4E0CA9BB1C0 = _id_E021C2744CC7ED68[0]["entity"];
    castend = castend - _id_A95D04F8F906E839 * 1;
    _id_AC0E564AC96A9D0F = vectordot(castend - caststart, castdir);
    t = sqrt(2 * _id_AC0E564AC96A9D0F / 800);
    up = _id_A95D04F8F906E839;
    right = anglestoright(_id_6951CF1F43BC8EBE);
    _id_4B65413211AF7033 = molotov_rebuild_angles_up_right(up, right);
    thread molotov_simulate_impact(grenade, castend, _id_4B65413211AF7033, _id_8D3DD4E0CA9BB1C0, _id_CEAB23E7A7E95404, gettime() + t * 1000);
    return;
  }

  grenade notify("death");
  waitframe();

  if(isDefined(grenade))
    grenade delete();
}

molotovbadplace(_id_183BDCC9E630D8DD) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  badplace = createnavbadplacebybounds(_id_183BDCC9E630D8DD, (128, 128, 100), (0, 0, 0));
  return badplace;
}

molotov_simulate_impact(grenade, _id_183BDCC9E630D8DD, _id_4B65413211AF7033, _id_3AE043BBB7B2FDF0, _id_CEAB23E7A7E95404, impacttime) {
  owner = grenade.owner;

  if(!istrue(level.dangerzoneskipequipment)) {
    _id_A53FBEEB744EAE5C = scripts\engine\utility::ter_op(level.players.size > 15, 10, 20);
    scripts\mp\spawnlogic::addspawndangerzone(_id_183BDCC9E630D8DD - (0, 0, 128), 225, 256, owner.team, _id_A53FBEEB744EAE5C, owner, 1);
  }

  _id_DA984FE90CC9723C = anglestoup(_id_4B65413211AF7033);
  caststart = _id_183BDCC9E630D8DD + _id_DA984FE90CC9723C * 1;
  castend = caststart + _id_DA984FE90CC9723C * 25;
  contents = molotov_get_cast_contents();
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
    castend = _id_E021C2744CC7ED68[0]["position"] - _id_DA984FE90CC9723C * 1;

  _id_A862BFA81AEE2A1B = castend;
  burnsource = grenade;
  burnsource thread molotov_cleanup_burn_source();
  burnid = molotov_get_next_burning_id();
  _id_0E24E63386230E04 = 0;
  _id_483380BBC108CDCE = vectordot(vectorNormalize(_id_CEAB23E7A7E95404), -1 * _id_DA984FE90CC9723C);

  if(_id_483380BBC108CDCE < 0.96593)
    _id_0E24E63386230E04 = 1;

  shareddata = molotov_create_shared_data(owner, impacttime, burnsource, burnid);

  if(!istrue(grenade.owner._id_E6204058F06B94E5))
    shareddata.badplace = molotovbadplace(_id_183BDCC9E630D8DD);

  shareddata thread molotov_cleanup();
  grenade _id_49197CD063A740EA(::_id_946F8EBB6C6EFD92);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      if(isarray(elevators)) {
        foreach(_id_187F85DDB118861E in elevators)
        _id_187F85DDB118861E thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);

        continue;
      }

      elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
    }
  }

  id = 4;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_183BDCC9E630D8DD, _id_4B65413211AF7033, _id_3AE043BBB7B2FDF0);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  _id_6F2B46872DF538DE = 25;
  _id_DF64BADCCF60FD69 = 65;
  _id_144E6D19329167BD = 115;
  _id_911981AE29F681E9 = gettime() + pooldata.startdelayms;
  id = 8;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  oncompletedfunc = ::molotov_branch_create_tendril_radial;

  if(_id_0E24E63386230E04)
    oncompletedfunc = ::molotov_branch_create_forward_tendril_cone;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_A862BFA81AEE2A1B, _id_4B65413211AF7033, _id_3AE043BBB7B2FDF0, 0, _id_911981AE29F681E9, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  forward = anglesToForward(_id_4B65413211AF7033);
  right = anglestoright(_id_4B65413211AF7033);
  up = anglestoup(_id_4B65413211AF7033);
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  _id_17F0969AB028C296 = forward * -1;
  _id_87F08DF736795F51 = right * -1;
  _id_B644A203C149F9AC = up;
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  oncompletedfunc = ::molotov_branch_create_tendril_radial;

  if(_id_0E24E63386230E04)
    oncompletedfunc = undefined;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, _id_911981AE29F681E9, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  _id_17F0969AB028C296 = rotatepointaroundvector(up, forward, _id_DF64BADCCF60FD69);
  _id_87F08DF736795F51 = vectorNormalize(vectorcross(_id_17F0969AB028C296, up));
  _id_B644A203C149F9AC = vectorcross(_id_87F08DF736795F51, forward);
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  oncompletedfunc = ::molotov_branch_create_tendril_radial;

  if(_id_0E24E63386230E04)
    oncompletedfunc = ::molotov_branch_create_right_tendril_cone;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, _id_911981AE29F681E9, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  _id_17F0969AB028C296 = rotatepointaroundvector(up, forward, -1 * _id_DF64BADCCF60FD69);
  _id_87F08DF736795F51 = vectorNormalize(vectorcross(_id_17F0969AB028C296, up));
  _id_B644A203C149F9AC = vectorcross(_id_87F08DF736795F51, forward);
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  oncompletedfunc = ::molotov_branch_create_tendril_radial;

  if(_id_0E24E63386230E04)
    oncompletedfunc = ::molotov_branch_create_left_tendril_cone;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, _id_911981AE29F681E9, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  _id_17F0969AB028C296 = rotatepointaroundvector(up, forward, _id_144E6D19329167BD);
  _id_87F08DF736795F51 = vectorNormalize(vectorcross(_id_17F0969AB028C296, up));
  _id_B644A203C149F9AC = vectorcross(_id_87F08DF736795F51, forward);
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  oncompletedfunc = ::molotov_branch_create_tendril_radial;

  if(_id_0E24E63386230E04)
    oncompletedfunc = undefined;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, _id_911981AE29F681E9, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  _id_17F0969AB028C296 = rotatepointaroundvector(up, forward, -1 * _id_144E6D19329167BD);
  _id_87F08DF736795F51 = vectorNormalize(vectorcross(_id_17F0969AB028C296, up));
  _id_B644A203C149F9AC = vectorcross(_id_87F08DF736795F51, forward);
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  oncompletedfunc = ::molotov_branch_create_tendril_radial;

  if(_id_0E24E63386230E04)
    oncompletedfunc = undefined;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, _id_911981AE29F681E9, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  molotov_register_cast(shareddata);

  foreach(_id_8D01E03C5C561B39 in shareddata.branches)
  _id_8D01E03C5C561B39 thread molotov_start_branch();
}

molotov_cleanup() {
  self.burnsource scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 6.75);

  for(;;) {
    _id_3F9251D8CD3164A0 = 1;

    foreach(_id_8D01E03C5C561B39 in self.branches) {
      if(!istrue(_id_8D01E03C5C561B39.iscomplete)) {
        _id_3F9251D8CD3164A0 = 0;
        break;
      }

      if(!_id_3F9251D8CD3164A0) {
        break;
      }
    }

    if(_id_3F9251D8CD3164A0) {
      break;
    }

    waitframe();
  }

  if(isDefined(self.badplace))
    destroynavobstacle(self.badplace);
}

molotov_create_shared_data(owner, impacttime, burnsource, burnid) {
  shareddata = spawnStruct();
  shareddata.owner = owner;
  shareddata.team = owner.team;
  shareddata.impacttime = impacttime;
  shareddata.burnsource = burnsource;
  shareddata.burnid = burnid;
  shareddata.branches = [];
  shareddata.scriptablecount = 0;
  shareddata.caststotal = 0;
  shareddata.caststhisframe = 0;
  shareddata.frametimestamp = gettime();
  shareddata.castcontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  burnsource.shareddata = shareddata;
  return shareddata;
}

molotov_register_cast(shareddata) {
  shareddata.caststotal++;
  shareddata.caststhisframe++;
  shareddata.frametimestamp = gettime();
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_962A30A9BB8C0F09.caststhisframe++;
}

molotov_register_scriptable(shareddata) {
  shareddata.scriptablecount++;
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_962A30A9BB8C0F09.scriptables[self.id] = self;

  if(_id_962A30A9BB8C0F09.scriptables.size > _id_962A30A9BB8C0F09.maxpools)
    molotov_delete_oldest_scriptable();
}

molotov_register_trigger(trigger) {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_962A30A9BB8C0F09.triggers[self.id] = self;

  if(_id_962A30A9BB8C0F09.triggers.size > _id_962A30A9BB8C0F09.maxpools)
    molotov_delete_oldest_trigger();
}

molotov_delete_scriptable() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_962A30A9BB8C0F09.scriptables[self.id] = undefined;
  trigger = _id_962A30A9BB8C0F09.triggers[self.id];

  if(!isDefined(trigger))
    _id_962A30A9BB8C0F09.poolids = scripts\engine\utility::array_remove(_id_962A30A9BB8C0F09.poolids, self.id);

  self notify("death");
  self freescriptable();
}

molotov_delete_trigger() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_962A30A9BB8C0F09.triggers[self.id] = undefined;
  scriptable = _id_962A30A9BB8C0F09.scriptables[self.id];

  if(!isDefined(scriptable))
    _id_962A30A9BB8C0F09.poolids = scripts\engine\utility::array_remove(_id_962A30A9BB8C0F09.poolids, self.id);

  self delete();
}

molotov_delete_oldest_scriptable(immediate) {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  scriptable = undefined;
  id = undefined;

  foreach(id in _id_962A30A9BB8C0F09.poolids) {
    scriptable = _id_962A30A9BB8C0F09.scriptables[id];

    if(isDefined(scriptable)) {
      break;
    }
  }

  immediate = istrue(immediate) || _id_962A30A9BB8C0F09.immediatecleanup;

  if(getdvarint("dvar_7DFD0D2D59762B9E", 1) == 1) {
    if(isDefined(scriptable))
      molotov_delete_pool_by_id(id, immediate);
  } else if(!isDefined(scriptable))
    molotov_delete_pool_by_id(id, immediate);
}

molotov_delete_oldest_trigger(immediate) {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  trigger = undefined;
  id = undefined;

  foreach(id in _id_962A30A9BB8C0F09.poolids) {
    trigger = _id_962A30A9BB8C0F09.triggers[id];

    if(isDefined(trigger)) {
      break;
    }
  }

  immediate = istrue(immediate) || _id_962A30A9BB8C0F09.immediatecleanup;

  if(isDefined(trigger))
    molotov_delete_pool_by_id(id, immediate);
}

molotov_delete_pool_by_id(id, immediate) {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  scriptable = _id_962A30A9BB8C0F09.scriptables[id];

  if(isDefined(scriptable)) {
    if(!istrue(immediate)) {
      _id_962A30A9BB8C0F09.scriptables[id] = undefined;
      _id_962A30A9BB8C0F09.triggers[id] = undefined;
      _id_962A30A9BB8C0F09.poolids = scripts\engine\utility::array_remove(_id_962A30A9BB8C0F09.poolids, id);
      scriptable thread molotov_pool_end();
      return;
    }

    scriptable thread molotov_delete_scriptable();
  }

  trigger = _id_962A30A9BB8C0F09.triggers[id];

  if(isDefined(trigger))
    trigger thread molotov_delete_trigger();
}

molotov_can_cast_this_frame(shareddata) {
  if(shareddata.frametimestamp < gettime()) {
    shareddata.frametimestamp = gettime();
    shareddata.caststhisframe = 0;
  }

  if(shareddata.caststhisframe >= 3)
    return 0;

  _id_962A30A9BB8C0F09 = molotov_get_level_data();

  if(_id_962A30A9BB8C0F09.frametimestamp < gettime()) {
    _id_962A30A9BB8C0F09.frametimestamp = gettime();
    _id_962A30A9BB8C0F09.caststhisframe = 0;
  }

  if(_id_962A30A9BB8C0F09.caststhisframe >= _id_962A30A9BB8C0F09.maxcastsperframe)
    return 0;

  return 1;
}

molotov_shared_data_is_complete(_id_AF8745E2185687A8) {
  iscomplete = 0;
  maxcasts = 60;
  maxents = 20;

  if(self.caststotal >= maxcasts)
    iscomplete = 1;
  else if(self.scriptablecount >= maxents)
    iscomplete = 1;
  else if(istrue(_id_AF8745E2185687A8)) {
    _id_3CE5D6EB962629FA = 1;

    foreach(_id_8D01E03C5C561B39 in self.branches) {
      if(!_id_8D01E03C5C561B39 molotov_branch_is_complete(1, 1)) {
        _id_3CE5D6EB962629FA = 0;
        break;
      }
    }

    if(_id_3CE5D6EB962629FA)
      iscomplete = 1;
  }

  if(iscomplete) {
    self.iscomplete = 1;
    molotov_store_branch_ents();
    self.branches = [];
  }

  return iscomplete;
}

molotov_store_branch_ents() {
  shareddata = self;

  if(isDefined(self.shareddata))
    shareddata = self.shareddata;

  if(!isDefined(shareddata.oldbranchents))
    shareddata.oldbranchents = [];

  foreach(_id_8D01E03C5C561B39 in self.branches) {
    foreach(ent in _id_8D01E03C5C561B39.ents) {
      if(isDefined(ent))
        shareddata.oldbranchents[shareddata.oldbranchents.size] = ent;
    }
  }
}

molotov_create_branch(shareddata, castdata, pooldata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc) {
  _id_8D01E03C5C561B39 = spawnStruct();
  _id_8D01E03C5C561B39.shareddata = shareddata;
  _id_8D01E03C5C561B39.castdata = castdata;
  _id_8D01E03C5C561B39.pooldata = pooldata;
  _id_8D01E03C5C561B39.startingorigin = startingorigin;
  _id_8D01E03C5C561B39.startingangles = startingangles;
  _id_8D01E03C5C561B39.startingstuckto = startingstuckto;
  _id_8D01E03C5C561B39.startingcasttype = startingcasttype;
  _id_8D01E03C5C561B39.oncompletedfunc = oncompletedfunc;
  _id_8D01E03C5C561B39.ents = [];
  _id_8D01E03C5C561B39.branches = [];
  _id_8D01E03C5C561B39.hitpositions = [];
  _id_8D01E03C5C561B39.hittypes = [];
  _id_8D01E03C5C561B39.casts = 0;
  _id_8D01E03C5C561B39.castfails = 0;
  _id_8D01E03C5C561B39.preventstarttime = preventstarttime;
  return _id_8D01E03C5C561B39;
}

molotov_start_branch() {
  self endon("cleanup_branch");

  if(!isDefined(self.preventstarttime))
    self.preventstarttime = gettime();

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata molotov_shared_data_is_complete()) {
      _id_5D02A89F45CC20D7 = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.startingstuckto);
      _id_5D02A89F45CC20D7 = _id_5D02A89F45CC20D7 thread molotov_pool_start();
      self.iscomplete = 1;
      self.shareddata molotov_shared_data_is_complete(1);
    }
  } else {
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;

    for(;;) {
      if(self.shareddata molotov_shared_data_is_complete()) {
        break;
      }

      if(molotov_branch_is_complete(undefined, 1)) {
        break;
      }

      if(!molotov_can_cast_this_frame(self.shareddata)) {
        waitframe();
        continue;
      }

      if(self.casttype == 0) {
        firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;

        if(isDefined(firstforwardmodanglesfunc)) {
          self.castangles = [[firstforwardmodanglesfunc]](self.castangles);
          self.castdata.firstforwardmodanglesfunc = undefined;
          self.castdata.iswallcast = undefined;
        }
      }

      if(!isDefined(self.iswallcast)) {
        _id_89E70A63B116955B = vectordot(anglestoup(self.castangles), (0, 0, 1));
        self.iswallcast = _id_89E70A63B116955B > -0.81915 && _id_89E70A63B116955B <= 0.5;

        if(isDefined(self.castdata.firstforwarddist)) {
          if(self.iswallcast && isDefined(self.castdata.firstforwarddistwall)) {
            self.castdata.firstforwarddist = self.castdata.firstforwarddistwall;
            self.castdata.firstforwarddistwall = undefined;
          } else
            self.castdata.firstforwarddistwall = undefined;
        }
      }

      self.castdir = molotov_get_cast_dir(self.castangles, self.casttype);
      self.castend = self.caststart + self.castdir * molotov_get_cast_dist(self.casttype, self.castdata, self.iswallcast);
      _id_10CFD730AD727443 = undefined;
      _id_488AE8E1536D02B3 = undefined;
      _id_A95D04F8F906E839 = undefined;
      _id_8D3DD4E0CA9BB1C0 = undefined;
      _id_D27F9A12A82F66E3 = undefined;
      _id_E021C2744CC7ED68 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 1, "physicsquery_closest", 1);

      if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
        _id_10CFD730AD727443 = 1;
        _id_488AE8E1536D02B3 = _id_E021C2744CC7ED68[0]["position"];
        _id_A95D04F8F906E839 = _id_E021C2744CC7ED68[0]["normal"];
        _id_8D3DD4E0CA9BB1C0 = _id_E021C2744CC7ED68[0]["entity"];
      }

      switch (self.casttype) {
        case 0:
          if(istrue(_id_10CFD730AD727443)) {
            molotov_branch_register_cast(self.casttype, 0, _id_488AE8E1536D02B3);
            _id_1DDC516959EF26A0 = 1;

            if(isDefined(self.castdata.firstforwarddist)) {
              _id_D0914E2FC24E75F8 = _id_488AE8E1536D02B3 - self.caststart;
              _id_64B62CB5DC1E7AF6 = vectordot(_id_D0914E2FC24E75F8, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - _id_64B62CB5DC1E7AF6;

              if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist)
                _id_1DDC516959EF26A0 = 0;
              else
                self.castdata.firstforwarddist = undefined;
            }

            _id_D27F9A12A82F66E3 = molotov_rebuild_angles_up_right(_id_A95D04F8F906E839, anglestoright(self.castangles));

            if(_id_1DDC516959EF26A0) {
              ent = molotov_branch_create_pool(_id_488AE8E1536D02B3, _id_D27F9A12A82F66E3, _id_8D3DD4E0CA9BB1C0);
              ent thread molotov_pool_start();
            }

            self.casttype = 2;
            self.caststart = _id_488AE8E1536D02B3 + _id_A95D04F8F906E839 * 1;
            self.castangles = _id_D27F9A12A82F66E3;
            self.iswallcast = undefined;
          } else {
            molotov_branch_register_cast(self.casttype, undefined, undefined);

            if(isDefined(self.castdata.firstforwarddist)) {
              _id_D0914E2FC24E75F8 = self.castend - self.caststart;
              _id_64B62CB5DC1E7AF6 = vectordot(_id_D0914E2FC24E75F8, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - _id_64B62CB5DC1E7AF6;

              if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist)
                self.castdata.firstforwarddist = undefined;
            }

            self.casttype = 1;
            self.caststart = self.castend;
          }

          break;
        case 1:
          if(istrue(_id_10CFD730AD727443)) {
            _id_D27F9A12A82F66E3 = molotov_rebuild_angles_up_right(_id_A95D04F8F906E839, anglestoright(self.castangles));
            ent = molotov_branch_create_pool(_id_488AE8E1536D02B3, _id_D27F9A12A82F66E3, _id_8D3DD4E0CA9BB1C0);
            ent thread molotov_pool_start();
            _id_970F97CB88D6B89E = vectordot(anglestoup(self.castangles), _id_A95D04F8F906E839);

            if(_id_970F97CB88D6B89E < 0.9848) {
              molotov_branch_register_cast(self.casttype, 2, _id_488AE8E1536D02B3);
              self.casttype = 2;
              self.caststart = _id_488AE8E1536D02B3 + _id_A95D04F8F906E839 * 1;
              self.castangles = _id_D27F9A12A82F66E3;
            } else {
              molotov_branch_register_cast(self.casttype, 1, _id_488AE8E1536D02B3);
              self.casttype = 0;
            }
          } else {
            molotov_branch_register_cast(self.casttype, undefined, undefined);
            self.caststart = self.castend;
          }

          break;
        case 2:
          if(istrue(_id_10CFD730AD727443)) {
            molotov_branch_register_cast(self.casttype, 3, _id_488AE8E1536D02B3);
            self.casttype = 0;
            self.caststart = _id_488AE8E1536D02B3 + _id_A95D04F8F906E839 * 1;
          } else {
            molotov_branch_register_cast(self.casttype, undefined, undefined);
            self.casttype = 0;
          }

          break;
      }

      waittillframeend;
    }

    self.iscomplete = 1;
    self.shareddata molotov_shared_data_is_complete(1);
  }
}

molotov_branch_is_complete(_id_AF8745E2185687A8, _id_F7D3F0B0605B5824) {
  iscomplete = 0;
  _id_3CE5D6EB962629FA = undefined;

  if(!istrue(_id_F7D3F0B0605B5824))
    iscomplete = self.shareddata molotov_shared_data_is_complete();

  if(!iscomplete) {
    if(isDefined(self.castdata) && isDefined(self.castdata.maxfails) && self.castfails >= self.castdata.maxfails)
      iscomplete = 1;
    else if(isDefined(self.castdata) && isDefined(self.castdata.maxcasts) && self.casts >= self.castdata.maxcasts)
      iscomplete = 1;
    else if(isDefined(self.castdata) && isDefined(self.castdata.maxents) && self.ents.size >= self.castdata.maxents)
      iscomplete = 1;
    else if(istrue(_id_AF8745E2185687A8) && self.branches.size > 0) {
      _id_3CE5D6EB962629FA = 1;

      foreach(_id_8D01E03C5C561B39 in self.branches) {
        if(!_id_8D01E03C5C561B39 molotov_branch_is_complete(_id_AF8745E2185687A8, _id_F7D3F0B0605B5824)) {
          _id_3CE5D6EB962629FA = 0;
          break;
        }
      }

      if(_id_3CE5D6EB962629FA)
        iscomplete = 1;
    }
  }

  if(iscomplete && !istrue(self.iscomplete)) {
    oncompletedfunc = self.oncompletedfunc;
    self.oncompletedfunc = undefined;

    if(isDefined(oncompletedfunc))
      self[[oncompletedfunc]]();

    if(istrue(_id_3CE5D6EB962629FA)) {
      iscomplete = 0;

      foreach(_id_8D01E03C5C561B39 in self.branches) {
        if(!_id_8D01E03C5C561B39 molotov_branch_is_complete(1, _id_F7D3F0B0605B5824)) {
          _id_3CE5D6EB962629FA = 0;
          break;
        }
      }

      if(_id_3CE5D6EB962629FA)
        iscomplete = 1;
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
    molotov_store_branch_ents();
    self.branches = [];
  }

  return iscomplete;
}

molotov_branch_register_cast(casttype, _id_8E87EBE279CDFCFB, _id_8A7FE8798602A3D1) {
  molotov_register_cast(self.shareddata);
  self.casts++;

  if(isDefined(_id_8E87EBE279CDFCFB)) {
    if(_id_8E87EBE279CDFCFB == 0 || _id_8E87EBE279CDFCFB == 1 || _id_8E87EBE279CDFCFB == 2)
      self.castfails = 0;
  } else if(casttype == 1)
    self.castfails++;
}

molotov_create_pool(origin, angles, stuckto, owner, burnsource, burnid, starttime, pooldata, poolmask, id) {
  scriptablename = "equip_molotov_pool_mp_p";

  if(isDefined(burnsource.weapon_name) && burnsource.weapon_name == "gas_can_mp")
    scriptablename = "equip_propane_tank_pool_br";

  scriptable = spawnscriptable(scriptablename, origin, angles);
  scriptable.stuckto = stuckto;
  scriptable.owner = owner;
  scriptable.burnsource = burnsource;
  scriptable.burnid = burnid;
  scriptable.starttime = starttime;
  scriptable.pooldata = pooldata;
  scriptable.poolmask = poolmask;
  scriptable.id = id;

  if(isDefined(stuckto)) {
    offset = rotatevectorinverted(origin - stuckto.origin, stuckto.angles);
    angleoffset = combineangles(invertangles(stuckto.angles), angles);
    scriptable scripts\common\utility::_id_6E506F39F121EA8A(stuckto, offset, angleoffset);
  }

  scriptable thread molotov_watch_cleanup_pool();
  return scriptable;
}

molotov_branch_create_pool(origin, angles, stuckto) {
  poolmask = self.pooldata.typeid;
  up = anglestoup(angles);
  dot = vectordot(up, (0, 0, 1));

  if(dot <= -0.81915)
    poolmask = poolmask | 128;
  else if(dot <= 0.5)
    poolmask = poolmask | 64;
  else
    poolmask = poolmask | 32;

  starttime = self.preventstarttime + self.pooldata.startdelayms;
  scriptable = molotov_create_pool(origin, angles, stuckto, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, starttime, self.pooldata, poolmask);
  self.preventstarttime = starttime;
  self.ents[self.ents.size] = scriptable;
  scriptable.id = molotov_get_unique_pool_id();
  scriptable molotov_register_scriptable(self.shareddata);
  return scriptable;
}

molotov_pool_start() {
  if(istrue(self.started)) {
    return;
  }
  self.started = 1;
  self endon("death");
  self endon("molotov_pool_end");

  while(gettime() < self.starttime)
    waitframe();

  self.ended = 0;
  molotov_watch_pool();
  thread molotov_pool_end();
}

molotov_watch_pool() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto))
    self.stuckto endon("death");

  self notify("molotov_pool_watch");
  self.trigger = molotov_create_pool_trigger(self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset);
  self.poolmask = self.poolmask | 1;
  molotov_pool_update_scriptable();
  _id_08FC4600D9C0CBB6 = randomfloatrange(6.5, 6.75);
  wait(_id_08FC4600D9C0CBB6);
}

molotov_pool_end(immediate) {
  self endon("death");

  if(istrue(self.ended)) {
    return;
  }
  self notify("molotov_pool_end");
  self.ended = 1;
  self.poolmask = self.poolmask &~1;
  self.poolmask = self.poolmask | 2;
  molotov_pool_update_scriptable();

  if(!istrue(immediate))
    wait 1;

  if(isDefined(self.trigger))
    self.trigger thread molotov_delete_trigger();

  if(!istrue(immediate))
    wait 3.5;

  thread molotov_delete_scriptable();
}

molotov_watch_cleanup_pool() {
  self endon("death");
  molotov_watch_cleanup_pool_internal();
  thread molotov_delete_scriptable();
}

molotov_watch_cleanup_pool_internal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto))
    self.stuckto endon("death");

  self waittill("forever");
}

molotov_create_pool_trigger(triggerradius, triggerheight, triggeroffset) {
  origin = self.origin - anglestoup(self.angles) * triggeroffset;
  trigger = spawn("trigger_rotatable_radius", origin, 0, triggerradius, triggerheight);
  trigger.angles = self.angles;
  trigger.id = self.id;

  if(isDefined(self.stuckto) && (!isai(self.stuckto) || isalive(self.stuckto))) {
    trigger enablelinkTo();
    trigger linkTo(self.stuckto);
  }

  trigger hide();
  struct = spawnStruct();
  struct.trigger = trigger;
  struct.attacker = self.owner;
  struct.inflictor = self.burnsource;
  struct.killcament = self.burnsource;
  struct.burnid = self.burnid;
  struct.stuckto = self.stuckto;
  struct.playersintrigger = [];
  trigger.struct = struct;
  struct thread molotov_watch_pool_trigger_enter();
  struct thread molotov_watch_pool_trigger_exit();
  struct thread molotov_cleanup_pool_trigger();
  trigger molotov_register_trigger();
  return trigger;
}

molotov_watch_pool_trigger_enter() {
  if(isDefined(self.inflictor))
    self.inflictor endon("death");

  level endon("game_ended");
  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player) && !isagent(player)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    playerowner = scripts\engine\utility::ter_op(isDefined(player.owner), player.owner, player);

    if(playerowner != self.attacker && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(playerowner, self.attacker)) && !istrue(self.inflictor._id_88FE704ADF00EADF)) {
      continue;
    }
    entnum = player getentitynumber();

    if(isDefined(self.playersintrigger[entnum])) {
      continue;
    }
    self.playersintrigger[entnum] = player;
    player molotov_start_burning(self.attacker, self.inflictor, self.killcament, self.burnid);
  }
}

molotov_watch_pool_trigger_exit() {
  level endon("game_ended");
  self.trigger endon("death");

  for(;;) {
    foreach(id, player in self.playersintrigger) {
      if(!isDefined(player)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(player)) {
        continue;
      }
      if(player istouching(self.trigger)) {
        continue;
      }
      self.playersintrigger[id] = undefined;
      player molotov_stop_burning(self.burnid);
    }

    waitframe();
  }
}

molotov_cleanup_pool_trigger() {
  level endon("game_ended");
  molotov_cleanup_pool_trigger_end_early();

  foreach(player in self.playersintrigger) {
    if(isDefined(player))
      player molotov_stop_burning(self.burnid);
  }

  if(isDefined(self.trigger))
    self.trigger thread molotov_delete_trigger();
}

molotov_cleanup_pool_trigger_end_early() {
  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  if(isDefined(self.stuckto))
    self.stuckto endon("death");

  for(;;)
    waitframe();
}

molotov_pool_update_scriptable() {
  _id_DCF9401F976E906F = molotov_get_pool_level_data();
  state = _id_DCF9401F976E906F.scriptablestates[self.poolmask];
  self setscriptablepartstate("effects", state, 0);
}

molotov_branch_create_sub_branch(id, starttime, firstforwarddist, firstforwardmindist, firstforwardmodanglesfunc, firstforwarddistwall, maxcasts, maxents, _id_94B720A60991D4DB) {
  shareddata = self.shareddata;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);

  if(isDefined(self.castdata)) {
    if(self.castfails > self.castdata.maxfails) {
      return;
    }
    if(self.castfails > castdata.maxfails)
      return;
  }

  if(isDefined(firstforwarddist))
    castdata.firstforwarddist = firstforwarddist;

  if(isDefined(firstforwardmindist))
    castdata.firstforwardmindist = firstforwardmindist;

  if(isDefined(firstforwardmodanglesfunc))
    castdata.firstforwardmodanglesfunc = firstforwardmodanglesfunc;

  if(isDefined(firstforwarddistwall))
    castdata.firstforwarddistwall = firstforwarddistwall;

  if(isDefined(maxcasts))
    castdata.maxcasts = maxcasts;

  if(isDefined(maxents))
    castdata.maxents = maxents;

  _id_8D01E03C5C561B39 = molotov_create_branch(shareddata, castdata, pooldata, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime);
  _id_8D01E03C5C561B39.castfails = self.castfails;
  self.branches[self.branches.size] = _id_8D01E03C5C561B39;
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;

  if(istrue(_id_94B720A60991D4DB))
    _id_8D01E03C5C561B39 thread molotov_start_branch();

  return _id_8D01E03C5C561B39;
}

molotov_branch_create_forward_tendril_cone() {
  _id_8D01E03C5C561B39 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1);
}

molotov_branch_create_left_tendril_cone() {
  _id_8D01E03C5C561B39 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, ::molotov_left_tendril_mod_angles, 44, undefined, undefined, 1);
}

molotov_branch_create_right_tendril_cone() {
  _id_8D01E03C5C561B39 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, ::molotov_right_tendril_mod_angles, 44, undefined, undefined, 1);
}

molotov_branch_create_tendril_radial() {
  _id_8D01E03C5C561B39 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, ::molotov_tendril_mod_angles_radial, 44, 6, 1, 1);
}

molotov_rotate_angles_about_up(angles, amount) {
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  right = undefined;
  forward = rotatepointaroundvector(up, forward, amount);
  right = vectorNormalize(vectorcross(forward, up));
  up = vectorcross(right, forward);
  return axistoangles(forward, right, up);
}

molotov_left_tendril_mod_angles(angles) {
  amount = randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(angles, amount);
}

molotov_right_tendril_mod_angles(angles) {
  amount = -1 * randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(angles, amount);
}

molotov_tendril_mod_angles_radial(angles) {
  amount = randomfloatrange(-60, 60);
  return molotov_rotate_angles_about_up(angles, amount);
}

molotov_cleanup_burn_source() {
  self endon("death");
  wait 20;
  self delete();
}

molotov_cleanup_grenade(grenade) {
  grenade endon("death");
  scripts\engine\utility::waittill_any_2("disconnect", "joined_team");
  grenade delete();
}

molotov_get_level_data() {
  return level.molotov;
}

molotov_get_pool_level_data() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_DCF9401F976E906F = _id_962A30A9BB8C0F09.pooldata;
  return _id_DCF9401F976E906F;
}

molotov_get_cast_level_data() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  _id_AB59026CFE871548 = _id_962A30A9BB8C0F09.castdata;
  return _id_AB59026CFE871548;
}

molotov_get_unique_pool_id() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();
  uniquepoolid = _id_962A30A9BB8C0F09.uniquepoolid;
  _id_962A30A9BB8C0F09.uniquepoolid++;
  _id_962A30A9BB8C0F09.poolids = scripts\engine\utility::array_add(_id_962A30A9BB8C0F09.poolids, uniquepoolid);
  return uniquepoolid;
}

molotov_get_cast_data(_id_2C6848D386785D9F) {
  _id_AB59026CFE871548 = molotov_get_cast_level_data();
  castdata = spawnStruct();
  castdata.distforward = _id_AB59026CFE871548.distforward[_id_2C6848D386785D9F];
  castdata.distdown = _id_AB59026CFE871548.distdown[_id_2C6848D386785D9F];
  castdata.distup = _id_AB59026CFE871548.distup[_id_2C6848D386785D9F];
  castdata.maxcasts = _id_AB59026CFE871548.maxcasts[_id_2C6848D386785D9F];
  castdata.maxfails = _id_AB59026CFE871548.maxfails[_id_2C6848D386785D9F];
  castdata.maxents = _id_AB59026CFE871548.maxents[_id_2C6848D386785D9F];
  castdata.distforwardwall = _id_AB59026CFE871548.distforwardwall[_id_2C6848D386785D9F];

  if(isDefined(_id_AB59026CFE871548.firstforwarddist[_id_2C6848D386785D9F])) {
    castdata.firstforwarddist = _id_AB59026CFE871548.firstforwarddist[_id_2C6848D386785D9F];
    castdata.firstforwardmindist = _id_AB59026CFE871548.firstforwardmindist[_id_2C6848D386785D9F];
    castdata.firstforwardmodanglesfunc = _id_AB59026CFE871548.firstforwardmodanglesfunc[_id_2C6848D386785D9F];

    if(isDefined(_id_AB59026CFE871548.firstforwarddistwall[_id_2C6848D386785D9F]))
      castdata.firstforwarddistwall = _id_AB59026CFE871548.firstforwarddistwall[_id_2C6848D386785D9F];
  }

  return castdata;
}

molotov_get_pool_data(typeid) {
  _id_DCF9401F976E906F = molotov_get_pool_level_data();
  pooldata = spawnStruct();
  pooldata.typeid = typeid;
  pooldata.triggerradius = _id_DCF9401F976E906F.triggerradius[typeid];
  pooldata.triggerheight = _id_DCF9401F976E906F.triggerheight[typeid];
  pooldata.triggeroffset = _id_DCF9401F976E906F.triggeroffset[typeid];
  pooldata.startdelayms = _id_DCF9401F976E906F.startdelayms[typeid];
  return pooldata;
}

molotov_get_cast_dir(angles, casttype) {
  switch (casttype) {
    case 0:
      return anglesToForward(angles);
    case 1:
      return -1 * anglestoup(angles);
    case 2:
      return anglestoup(angles);
  }

  return undefined;
}

molotov_get_cast_dist(casttype, castdata, iswallcast) {
  switch (casttype) {
    case 0:
      if(isDefined(castdata.firstforwarddist))
        return castdata.firstforwarddist;
      else if(iswallcast && isDefined(castdata.distforwardwall))
        return castdata.distforwardwall;
      else
        return castdata.distforward;
    case 1:
      return castdata.distdown;
    case 2:
      return castdata.distup;
  }

  return undefined;
}

molotov_get_cast_contents() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
}

molotov_rebuild_angles_up_right(up, right) {
  forward = vectorNormalize(vectorcross(up, right));
  right = vectorcross(forward, up);
  return axistoangles(forward, right, up);
}

molotov_rebuild_angles_up_forward(up, forward) {
  right = vectorNormalize(vectorcross(forward, up));
  forward = vectorcross(up, right);
  return axistoangles(forward, right, up);
}

_id_D89C621CE916F11E() {
  _id_711624163E30B22B = undefined;

  if(!isDefined(level))
    return _id_711624163E30B22B;

  if(!isDefined(level.molotov))
    return _id_711624163E30B22B;

  if(!isDefined(level.molotov._id_A3F7381340CF06D9)) {
    _id_A3F7381340CF06D9 = scripts\mp\equipment::_id_2113B6F7CB462692("molotov_mp");
    level.molotov._id_A3F7381340CF06D9 = _id_A3F7381340CF06D9;
  }

  _id_711624163E30B22B = level.molotov._id_A3F7381340CF06D9;
  return _id_711624163E30B22B;
}

molotov_start_burning(attacker, inflictor, killcament, id) {
  if(self _meth_6F55D55CCFF20D14()) {
    return;
  }
  if(!isDefined(id)) {}

  info = molotov_get_burning_info(1);

  if(!isDefined(id))
    id = molotov_get_next_burning_id();

  source = molotov_get_burning_source(attacker, inflictor, killcament, info, id, 1);
  source._id_D442547D75DFFD09 = inflictor._id_D442547D75DFFD09;
  scripts\mp\utility\player::_id_8B23D28B1D38CB39("fire", -1);
  _id_20AB5A5656202253 = 0;

  if(source.count <= 0)
    _id_20AB5A5656202253 = 1;

  source.count++;

  if(_id_20AB5A5656202253)
    thread molotov_update_burning();
}

molotov_stop_burning(id) {
  info = molotov_get_burning_info();

  if(!isDefined(info)) {
    return;
  }
  source = molotov_get_burning_source(undefined, undefined, undefined, info, id, 0);

  if(isDefined(source)) {
    if(source.count > 0) {
      _id_20AB5A5656202253 = 0;

      if(source.count == 1)
        _id_20AB5A5656202253 = 1;

      source.count--;

      if(_id_20AB5A5656202253)
        thread molotov_update_burning();
    }
  }
}

molotov_burn_for_time(time, attacker, inflictor, killcament) {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  id = molotov_get_next_burning_id();
  molotov_start_burning(attacker, inflictor, killcament, id);
  wait(time);
  molotov_stop_burning(id);
}

molotov_clear_burning(immediate) {
  self notify("clear_burning");

  if(isDefined(self.burninginfo) && isDefined(self.burninginfo.sources)) {
    foreach(source in self.burninginfo.sources)
    self.burninginfo.sources[source.id] = undefined;
  }

  scripts\mp\utility\player::_id_8B23D28B1D38CB39("fire", 0);
  self.burninginfo = undefined;
}

molotov_update_burning() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread molotov_cleanup_burning();
  info = molotov_get_burning_info();

  if(gettime() <= info.updatetimestamp)
    waitframe();

  for(;;) {
    info = molotov_get_burning_info();
    _id_1CC80627B9BDB202 = undefined;

    if(self _meth_6F55D55CCFF20D14())
      thread molotov_clear_burning();

    foreach(source in info.sources) {
      if(source molotov_burning_source_is_valid()) {
        if(!isDefined(_id_1CC80627B9BDB202) || source.id > _id_1CC80627B9BDB202)
          _id_1CC80627B9BDB202 = source.id;

        continue;
      }

      info.sources[source.id] = undefined;
    }

    if(isDefined(_id_1CC80627B9BDB202)) {
      info.timeoff = 0;
      info.timeon = info.timeon + 0.05;
      source = info.sources[_id_1CC80627B9BDB202];
      _id_3A472C52FA6CED24 = _id_D89C621CE916F11E();
      _id_6D3F04F7E314CF47 = scripts\engine\utility::_id_53C4C53197386572(_id_3A472C52FA6CED24._id_1B01E583ECC2FB9A, 1.5);
      _id_2BB09E77EE4C7B38 = scripts\engine\utility::_id_53C4C53197386572(_id_3A472C52FA6CED24._id_9369D29BFD0AEC71, 0.5);
      damage = scripts\engine\utility::_id_53C4C53197386572(_id_3A472C52FA6CED24._id_E0CF068CCAB49E34, 15);

      if(info.timeon > _id_6D3F04F7E314CF47)
        damage = scripts\engine\utility::_id_53C4C53197386572(_id_3A472C52FA6CED24._id_81C84C326CAEC1D2, 30);
      else if(info.timeon > _id_2BB09E77EE4C7B38)
        damage = scripts\engine\utility::_id_53C4C53197386572(_id_3A472C52FA6CED24._id_74FBF35A2265FA59, 25);

      inflictor = undefined;
      damageorigin = source.attacker.origin;

      if(isDefined(source.inflictor)) {
        inflictor = source.inflictor;
        damageorigin = source.inflictor.origin;
      }

      if(info.timetodamage <= 0) {
        self._id_604D21C5B1326910 = gettime();
        self dodamage(damage, damageorigin, source.attacker, inflictor, "MOD_EXPLOSIVE", "molotov_mp", "none");
        info.firstdamagedone = 1;
        info.timetodamage = scripts\engine\utility::_id_53C4C53197386572(_id_3A472C52FA6CED24._id_439885D26A2F9BF5, 0.25);
      } else {
        if(!info.firstdamagedone) {
          self._id_604D21C5B1326910 = gettime();
          self dodamage(damage, damageorigin, source.attacker, inflictor, "MOD_EXPLOSIVE", "molotov_mp", "none");
          info.firstdamagedone = 1;
        }

        info.timetodamage = info.timetodamage - 0.05;
      }
    } else {
      info.timeoff = info.timeoff + 0.05;

      if(info.timeoff >= 0.25)
        thread molotov_clear_burning();
    }

    info.updatetimestamp = gettime();
    wait 0.05;
  }
}

molotov_is_burning() {
  info = molotov_get_burning_info();
  return isDefined(info) && info.sources.size > 0;
}

molotov_get_burning_info(create) {
  info = self.burninginfo;

  if(!isDefined(info) && istrue(create)) {
    info = spawnStruct();
    info.timeon = 0;
    info.timeoff = 0;
    info.timetodamage = 0.25;
    info.updatetimestamp = 0;
    info.victim = self;
    info.sources = [];
    info.firstdamagedone = 0;
    self.burninginfo = info;
  }

  return info;
}

molotov_get_burning_source(attacker, inflictor, killcament, info, id, _id_0E5EA290EAEA85D2) {
  source = info.sources[id];

  if(!isDefined(source)) {
    if(istrue(_id_0E5EA290EAEA85D2)) {
      source = spawnStruct();
      source.attacker = attacker;
      source.inflictor = inflictor;
      source.hasinflictor = isDefined(inflictor);
      source.killcament = killcament;
      source.info = info;
      source.id = id;
      source.count = 0;
      info.sources[id] = source;
    }
  }

  return source;
}

molotov_burning_source_is_valid() {
  if(!isDefined(self.attacker))
    return 0;

  if(!isDefined(self.info.victim))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(self.info.victim))
    return 0;

  if(self.attacker != self.info.victim && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.attacker, self.info.victim)) && (isDefined(self.inflictor) && !istrue(self.inflictor._id_88FE704ADF00EADF)))
    return 0;

  if(self.hasinflictor && !isDefined(self.inflictor))
    return 0;

  if(self.count <= 0)
    return 0;

  return 1;
}

molotov_get_next_burning_id() {
  _id_962A30A9BB8C0F09 = molotov_get_level_data();

  if(!isDefined(_id_962A30A9BB8C0F09.burningid))
    _id_962A30A9BB8C0F09.burningid = 0;

  id = _id_962A30A9BB8C0F09.burningid;
  _id_962A30A9BB8C0F09.burningid++;
  return id;
}

molotov_cleanup_burning() {
  self notify("cleanup_burning");
  self endon("cleanup_burning");
  childthread molotov_cleanup_burning_on_death();
  childthread molotov_cleanup_burning_on_game_end();
}

molotov_cleanup_burning_on_death() {
  self endon("disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self waittill("death");
  thread molotov_clear_burning(1);
}

molotov_cleanup_burning_on_game_end() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level waittill("game_ended");
  thread molotov_clear_burning();
}

molotov_on_player_damaged(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  data.victim thread scripts\mp\weapons::enableburnfxfortime(0.5);
  return 1;
}

molotov_watch_fx() {
  self notify("molotov_clear_fx");
  self endon("molotov_clear_fx");
  self endon("death_or_disconnect");
  _id_08E784B7CB7322EB = 0;

  for(;;) {
    _id_B818F06C051B78F0 = 0;
    objweapon = self getheldoffhand();

    if(!isnullweapon(objweapon) && objweapon.basename == "molotov_mp")
      _id_B818F06C051B78F0 = 1;

    if(_id_B818F06C051B78F0 && !_id_08E784B7CB7322EB)
      thread molotov_begin_fx();
    else if(_id_08E784B7CB7322EB && !_id_B818F06C051B78F0)
      thread molotov_end_fx();

    _id_08E784B7CB7322EB = _id_B818F06C051B78F0;
    waitframe();
  }
}

molotov_begin_fx() {
  self endon("death_or_disconnect");
  self endon("molotov_end_fx");
  self.playingmolotovwickfx = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  waittime = 0.4;
  wait(waittime);
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
  self waittill("offhand_fired");
  waitframe();
  thread molotov_end_fx();
}

molotov_end_fx() {
  self notify("molotov_end_fx");

  if(istrue(self.playingmolotovwickfx)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self.playingmolotovwickfx = undefined;
}

molotov_clear_fx() {
  self notify("molotov_clear_fx");
  thread molotov_end_fx();
}

molotov_cleanup_branch(_id_8D01E03C5C561B39, immediate) {
  _id_8D01E03C5C561B39 notify("cleanup_branch");

  if(isDefined(_id_8D01E03C5C561B39.ents)) {
    foreach(scriptable in _id_8D01E03C5C561B39.ents) {
      if(isDefined(scriptable))
        scriptable thread molotov_pool_end(immediate);
    }
  }
}

molotov_cleanup_pool(grenade, immediate) {
  if(isDefined(grenade.shareddata)) {
    if(isDefined(grenade.shareddata.branches)) {
      foreach(_id_8D01E03C5C561B39 in grenade.shareddata.branches)
      molotov_cleanup_branch(_id_8D01E03C5C561B39, immediate);
    }

    if(isDefined(grenade.shareddata.oldbranchents)) {
      foreach(scriptable in grenade.shareddata.oldbranchents) {
        if(isDefined(scriptable))
          scriptable thread molotov_pool_end(immediate);
      }
    }
  }
}

_id_946F8EBB6C6EFD92() {
  self.shareddata.burnsource delete();
  molotov_cleanup_pool(self, 0);
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}