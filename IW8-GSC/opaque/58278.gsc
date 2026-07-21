/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58278.gsc
***********************************************/

init() {
  level._id_12838 = spawnStruct();
  level._id_12838.area1_targets = [];
  level._id_12838.applyquest = [];
  scripts\engine\scriptable::scriptable_addusedcallback(::scriptable_used);
  scripts\engine\scriptable::_id_12F57(::scriptable_used);
  level thread _id_12832();
}

_id_12832() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);
    var_0 thread _id_13F7E(undefined, 0, 0);
  }
}

scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_0.type)) {
    switch (var_0.type) {
      case "_encstr_95B92103EB79A817D5214DCB499238186968EF535B962BE86183435D382D9F02775813":
        var_3 _id_12833("_encstr_A9DF0B12E879852F78B8EFE54E", var_0);
        break;
      case "_encstr_8165227EAB808F2AED6F0317639E62FD7173B583E1A85D13500F132F6BB5993248F82ACB":
        var_3 _id_12833("_encstr_9A570C4FD8FF88ADE7B260684BA3", var_0);
        break;
      case "_encstr_84C724C2703905675B60BAB501E113CF37F89A2B60DD7BD316D5BFCDAE08FF99D16862321077":
        var_3 _id_12833("_encstr_88E60E61324B219B37B0A2F8D74AD337", var_0);
        break;
      case "_encstr_956925353B32408074D143BB454A508DB99BB7971FBB1540877728B12D3491BEF20F0BE1E382DB":
        var_3 _id_12833("_encstr_83970FCC5A2BD846D7E45637EA07E0B1E5", var_0);
        break;
      case "_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922":
        if(!isDefined(var_3._id_12827) || !var_3._id_12827) {
          return;
        }
        var_5 = 5;
        var_3 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(int(var_5));
        break;
    }
  }
}

_id_12833(var_0, var_1) {
  thread _id_1393A(var_0);
  scripts\cp\vehicles\little_bird_mg_cp::addedcollision();
  var_1 freescriptable();
  thread _id_1282F();
}

_id_12AF4(var_0) {
  level._id_12838.area1_targets[var_0._id_138FD] = var_0;
  level._id_12838.applyquest[var_0._id_138FD] = [];
}

race_monitor_out_of_vehicle(var_0) {
  if(!cargo_truck_mg_cp_createfromstructs(var_0)) {
    return;
  }
  return level._id_12838.area1_targets[var_0];
}

_id_1393A(var_0) {
  if(!cargo_truck_mg_cp_createfromstructs(var_0))
    return 0;

  var_1 = 0;
  var_2 = getdvarint("_encstr_A6E22E37D8E4AF892728F6DDCAE4AEC1DCD785B1C6DEDDBEB5D5B1A3B40E1B95D7B0D8A3B4ECCAEB0EEDBB56C9EAE09B", 1);

  if(isDefined(self.are_players_nearby_turret) && self.are_players_nearby_turret.size > 0) {
    foreach(var_5, var_4 in self.are_players_nearby_turret) {
      if(var_5 == var_0) {
        var_1 = 1;

        if(isDefined(var_4._id_12E2D._id_12A35))
          var_4[[var_4._id_12E2D._id_12A35]]();

        continue;
      }

      if(!var_2) {
        if(isDefined(var_4._id_12E2D.isdisconnecting))
          var_4[[var_4._id_12E2D.isdisconnecting]]();
      }
    }
  }

  if(!var_1)
    assignvehiclestoteams(var_0);
}

assignvehiclestoteams(var_0) {
  var_1 = init_internal(var_0);
  level._id_12838.applyquest[var_0] = scripts\engine\utility::array_add(level._id_12838.applyquest[var_0], self);
  var_2 = race_monitor_vehicle(var_0);

  if(isDefined(var_1._id_12E2D.parachute_get_path))
    thread _id_13F7E(int(var_1._id_12E2D.parachute_get_path), var_2, 1);

  if(isDefined(var_1._id_12E2D.asm_playfacialanim_mp))
    var_1 thread[[var_1._id_12E2D.asm_playfacialanim_mp]]();

  if(isDefined(var_1._id_12E2D.parachute_get_path))
    var_1 thread _id_1449F();
  else {
    waitframe();
    var_1 thread isempdamage();
  }
}

_id_1449F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread moveplayertotoppos();

  if(isDefined(self._id_12E2D._id_1449E))
    self thread[[self._id_12E2D._id_1449E]]();

  while(gettime() < self.mp_layover_patch)
    waitframe();

  thread isempdamage();
}

moveplayertotoppos() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.player scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  thread isempdamage();
}

isempdamage() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self._id_12E2D._id_138FD;
  _id_13F73(var_0);
  var_1 = race_monitor_vehicle(var_0);

  if(isDefined(self._id_12E2D.parachute_get_path))
    self.player thread _id_13F7E(undefined, var_1, 0);

  if(isDefined(self._id_12E2D.isdeathshieldskippingenabled))
    self thread[[self._id_12E2D.isdeathshieldskippingenabled]]();

  self notify("_encstr_9B730DFFD9982B77A0F0CB574B5080");
}

_id_13F73(var_0) {
  if(!cargo_truck_mg_cp_createfromstructs(var_0))
    return 0;

  lbravo_actorthinkpath(self.player);

  if(scripts\engine\utility::array_contains(level._id_12838.applyquest[var_0], self.player))
    level._id_12838.applyquest[var_0] = scripts\engine\utility::array_remove(level._id_12838.applyquest[var_0], self.player);
}

init_internal(var_0) {
  var_1 = spawnStruct();
  var_1._id_12E2D = race_monitor_out_of_vehicle(var_0);
  var_1.player = self;
  var_1.team = self.team;
  var_1._id_13AB1 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.squadleaderbeacon_isactive = [];
  var_1._id_1381C = gettime();

  if(isDefined(var_1._id_12E2D.parachute_get_path))
    var_1.mp_layover_patch = gettime() + var_1._id_12E2D.parachute_get_path * 1000;

  var_1 carriable_pickup_wait(var_1.player);
  return var_1;
}

carriable_pickup_wait(var_0) {
  if(!isDefined(var_0.are_players_nearby_turret))
    var_0.are_players_nearby_turret = [];

  var_0.are_players_nearby_turret[self._id_12E2D._id_138FD] = self;
}

lbravo_actorthinkpath(var_0) {
  if(!isDefined(var_0.are_players_nearby_turret) || !isDefined(var_0.are_players_nearby_turret[self._id_12E2D._id_138FD])) {
    return;
  }
  var_0.are_players_nearby_turret[self._id_12E2D._id_138FD] = undefined;
}

_id_124DD(var_0) {
  if(scripts\engine\utility::array_contains(level._id_12838.applyquest[var_0], self))
    return 1;

  return 0;
}

_id_1249C(var_0) {
  if(!_id_124DD(var_0)) {
    return;
  }
  if(!isDefined(self.are_players_nearby_turret)) {
    return;
  }
  return self.are_players_nearby_turret[var_0];
}

cargo_truck_mg_cp_createfromstructs(var_0) {
  var_1 = scripts\engine\utility::array_contains_key(level._id_12838.area1_targets, var_0);

  if(isDefined(level._id_12838.area1_targets) && var_1)
    return 1;
  else
    return 0;
}

_id_12426(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(self.team == "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = spawnStruct();
    var_4.intvar = var_2;
  }

  var_5 = self.team;
  var_5 = scripts\engine\utility::array_remove(var_5, self);

  foreach(var_7 in var_5)
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_7, var_0, var_4);
}

_id_12425(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3);
}

_id_13F7E(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0)) {
    if(isfloat(var_0))
      var_0 = int(var_0);

    var_3 = var_3 + var_0 * 100;
  }

  if(isDefined(var_1))
    var_3 = var_3 + var_1 * 10;

  if(isDefined(var_2))
    var_3 = var_3 + var_2;

  self setclientomnvar("_encstr_A1DA1C1B2BF1B69DC8C1C8D7AF3EF7689B41A12291E7F73BA5F7B81B93F9", var_3);
}

modify_juggernaut_damage(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 100;

  var_2 = randomintrange(1, 101);

  if(var_1 < var_2) {
    return;
  }
  var_3 = _id_1233D();
  var_4 = "_encstr_8D251789E4B1B7DEE8F5C9D5DAC48D59BE0EDEEE2B275707AF" + var_3;

  if(!isent(self) || self isscriptable()) {
    var_5 = 35;
    var_6 = 75;
    var_6 = var_6 + randomfloatrange(-10, 10);
    var_7 = var_5 + 55 + randomfloatrange(-5, 5);
    var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, self.origin, self.angles, undefined, var_6, var_7);
  } else
    var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, self.origin, self.angles, self);

  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_4, var_8, 1, 1);
}

script_model_spawn_and_use_logic() {
  var_0 = _id_1233D();
  var_1 = "_encstr_8D251789E4B1B7DEE8F5C9D5DAC48D59BE0EDEEE2B275707AF" + var_0;
  thread _id_1393A(var_0);
}

_id_1233D() {
  var_0 = [];

  foreach(var_3, var_2 in level._id_12838.area1_targets)
  var_0[var_0.size] = var_3;

  var_0 = scripts\engine\utility::array_randomize(var_0);
  return var_0[0];
}

_id_1282F() {
  if(level.disable_super_in_turret.name == "_encstr_816E079685517D0975")
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());

  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }
  if(level.disable_super_in_turret.name == "_encstr_816E079685517D0975") {
    self.health = self.maxhealth;
    scripts\mp\healthoverlay::onexitdeathsdoor(1);
    self.br_armorhealth = self.br_maxarmorhealth;
    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", 1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    thread _id_12CCB();
  }
}

_id_12CCB() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

race_monitor_vehicle(var_0) {
  switch (var_0) {
    case "_encstr_88E60E61324B219B37B0A2F8D74AD337":
      return 1;
    case "_encstr_A9DF0B12E879852F78B8EFE54E":
      return 3;
    case "_encstr_9A570C4FD8FF88ADE7B260684BA3":
      return 4;
  }
}