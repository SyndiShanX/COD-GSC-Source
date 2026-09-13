/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_67673120f043631e.gsc
***********************************************/

_id_9C660C8EF32706C8() {
  level._effect["gas_cloud"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_gas_cloud.vfx");
}

start_puzzle(_id_8F326AB0287421A3) {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Water Maze");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_33DFD1B6A1005DFF = scripts\engine\utility::getStructArray("watermaze_revive_respawns", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_33DFD1B6A1005DFF, 1);
  }

  level thread _id_7E1F3A5AA9B072AF::_id_6B91D65174113D68();
  wait 1;
  _id_9C660C8EF32706C8();
  level._id_CA6CC42C53B63433 = 48;

  if(!istrue(level._id_BC53C613A7E7DB4D)) {
    level._id_93617D996E732D98 = _id_669C0F6CB0B7F0CD::_id_550A4455B981180C;
    thread scripts\cp_mp\tripwire::init();
  }

  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");
  level thread _id_25D34FEA909AADC5::_id_88CD811B63FF5A7B(0);
  level thread _id_7FAFDE5EB2B72419();
  level thread _id_A85A3BB76B2DE00D();
  level thread _id_7D0F9F8E29EAF0AB();
  level thread _id_723E0290430D0D00();
  level thread _id_6FC8E98766AC4CC1();
  level thread _id_DB46836AA3F8969B();
  level thread _id_A4B82191ABA56E15();
  level thread _id_86879C458815AB94();
  level thread _id_444E55FC1038F5F2();
  level thread _id_06CB156D573D96B9();
  level thread _id_D686043AA5DC16BB();
  thread _id_E62B1CAB42244B05(1.5);
  level thread _id_CCE9392D97201FB2();
  level thread _id_18AF78602B67B70C::_id_ED39B08FB6EE314A();
  level thread _id_1E9BF201EA44567C::_id_BF184D4BA504434F();
  level thread _id_1E9BF201EA44567C::_id_4DB7383FC4ED369C(_id_8F326AB0287421A3);
  level thread _id_18AF78602B67B70C::_id_CD5D33E1011B0B9D();
}

_id_E62B1CAB42244B05(delay) {
  level endon("game_ended");
  wait(delay);
  level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_puzzle2";
  setmusicstate(level._id_7CAA8AB2F4145CFA);
}

_id_CCE9392D97201FB2() {
  level thread _id_669C0F6CB0B7F0CD::_id_CB807C54DDFA3FB8();
  level thread _id_D5BD3D662C4B3444("maze_vo_hospital", 1000);
  level thread _id_669C0F6CB0B7F0CD::_id_74FEF0D96F450853("maze_vo_caves", 1000);
  level thread _id_669C0F6CB0B7F0CD::_id_84977F380F37AA5B("generator_room", 1000);
  level thread _id_513C910228900324("maze_vo_armory", 1000);
}

_id_D5BD3D662C4B3444(name, radius) {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct(name, "targetname");
  _id_1A96B3062BB2C598 = radius * radius;

  while(!scripts\cp\utility::any_player_nearby(struct.origin, _id_1A96B3062BB2C598))
    wait 1;

  childthread _id_669C0F6CB0B7F0CD::_id_32E44483E735F7A1();
  childthread _id_669C0F6CB0B7F0CD::_id_7D2179D71A41F0C3();
  childthread _id_669C0F6CB0B7F0CD::_id_CB0134F9E5CA5411();
}

_id_513C910228900324(name, radius) {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct(name, "targetname");
  _id_1A96B3062BB2C598 = radius * radius;

  while(!scripts\cp\utility::any_player_nearby(struct.origin, _id_1A96B3062BB2C598))
    wait 1;

  level thread _id_669C0F6CB0B7F0CD::_id_72D2B5997DCD8691();
}

_id_4E51A1FCB5CBA3D7(delay) {
  if(isDefined(delay))
    wait(delay);
}

_id_D686043AA5DC16BB() {
  if(istrue(level._id_39BD915EBC1420D5)) {
    return;
  }
  level._id_39BD915EBC1420D5 = 1;
  level thread _id_0815426E744E648E();
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot"]);
  _id_5C8BED8083C95381 = scripts\engine\utility::getStructArray("water_maze_pistol", "targetname");

  foreach(_id_558774275543A708 in _id_5C8BED8083C95381)
  _id_558774275543A708 _id_03DAF8A4D8E82EAD::_id_9655BF427A5ABDB8(undefined, _id_CDE2ED78F52F032C);
}

_id_06CB156D573D96B9() {
  if(getdvarint("dvar_AC5575F18BC73019", 1) < 1) {
    return;
  }
  _id_622D9B311E681DDC = scripts\engine\utility::getStruct("watermaze_debug_oxygenmask", "targetname");
  _id_5A379CCC24FD65B1 = level _id_4D5D872A7BD5C0C3::_id_18DFEA62F135DEF6(_id_622D9B311E681DDC.origin, _id_622D9B311E681DDC.angles);
  _id_5A379CCC24FD65B1 waittill("death");
  scripts\engine\utility::flag_set("maze_pickedup_mask");
}

_id_0815426E744E648E() {
  level endon("game_ended");
  _id_3FCAA442990A85D7 = getEnt("watermaze_hint_pistols", "targetname");

  if(!isent(_id_3FCAA442990A85D7)) {
    return;
  }
  for(;;) {
    _id_3FCAA442990A85D7 waittill("trigger", player);

    if(isPlayer(player)) {
      if(!istrue(player._id_19C9D4C5EBD6EB31))
        player thread _id_9966DF9E3C29F870();
    }
  }
}

_id_9966DF9E3C29F870() {
  self endon("disconnect");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(_id_1B4114093CD44368::_id_23A6763562820C70()) {
    return;
  }
  if(!self _meth_6F55D55CCFF20D14()) {
    return;
  }
  _id_D37A096A940FFFD8 = 0;

  foreach(weapon in self getweaponslistprimaries()) {
    name = weapon.classname;

    if(isDefined(name) && name == "pistol") {
      _id_D37A096A940FFFD8 = 1;
      break;
    }
  }

  if(!_id_D37A096A940FFFD8) {
    return;
  }
  _id_893FF9B814E04F95 = self getcurrentweapon();

  if(isDefined(_id_893FF9B814E04F95.classname) && _id_893FF9B814E04F95.classname == "pistol") {
    return;
  }
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID_WATERMAZE/HINT_PISTOL_SWIM");
  self._id_19C9D4C5EBD6EB31 = 1;
  return;
}

_id_444E55FC1038F5F2() {
  if(getdvarint("dvar_FB8E3DA5439C06AE", 1) < 0) {
    return;
  }
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("maze_fx_flare", "targetname");

  if(_id_9E4E1482CB40C9C5.size == 0) {
    return;
  }
  level._id_1BAA8156EE4C59C6 = [];

  foreach(struct in _id_9E4E1482CB40C9C5) {
    model = spawn("script_model", struct.origin);
    model.angles = struct.angles;
    model setModel("tag_origin_flarestick_cp_airpocket");
    level._id_1BAA8156EE4C59C6[level._id_1BAA8156EE4C59C6.size] = model;
    wait 0.05;
  }
}

_id_A4B82191ABA56E15() {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("enemy_claymore_trap", "targetname");
  level._id_ADFCAD02441F4649 = 0;
  level._id_404C4C9C7FEA188E = ::_id_72B4697947C3462B;

  if(getdvarint("dvar_EC03CB336E70A30F", -1) > 0) {
    return;
  }
  _id_A75014348E2B0C24 = 0;

  if(getdvarint("dvar_28E4E32107407D38", -1) > 0)
    _id_A75014348E2B0C24 = 1;

  foreach(struct in _id_9E4E1482CB40C9C5) {
    floating = undefined;

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "floating")
      floating = 1;

    if(_id_A75014348E2B0C24)
      level thread scripts\cp\cp_claymore::spawn_enemy_claymore(struct.origin, struct.angles, undefined, floating);
    else
      level thread _id_2F97FEC09B835FAB(struct);

    level._id_ADFCAD02441F4649 = level._id_ADFCAD02441F4649 + 1;
    wait 0.05;
  }
}

_id_72B4697947C3462B(origin) {
  dist = 100;
  distsq = dist * dist;
  level thread _id_829E26D465F70035(origin, dist);
  players = scripts\cp\utility::give_all_players_nearby(origin, distsq);

  if(isDefined(players)) {
    attacker = getaiarray("axis")[0];

    foreach(player in players) {
      if(isDefined(player) && isalive(player))
        player dodamage(100, origin, attacker, attacker, "MOD_TRIGGER_HURT");
    }
  }
}

_id_2F97FEC09B835FAB(struct) {
  model = spawn("script_model", struct.origin);
  model.angles = struct.angles;
  _id_6CAFCA24B497061B = getEnt("staging_claymore_coll", "targetname");

  if(isDefined(_id_6CAFCA24B497061B) && isent(_id_6CAFCA24B497061B)) {
    collision = spawn("script_model", model.origin);
    collision dontinterpolate();
    collision.angles = model.angles;
    collision clonebrushmodeltoscriptmodel(_id_6CAFCA24B497061B);
    collision linkTo(model);
    collision hide();
    model.collision = collision;
  }

  model setModel("projectile_claymore_v0");
  model setscriptablepartstate("arm", "active", 0);
  model setscriptablepartstate("plant", "active", 0);
  model thread _id_18088C142D166FE9();
  model thread _id_1BF2A80EE67D9654();
  model thread _id_74502A9E0EF1F19C::minedamagemonitor();
  level.mines[model getentitynumber()] = model;

  if(!isDefined(level._id_804A2874C0323DA7))
    level._id_804A2874C0323DA7 = [];

  level._id_804A2874C0323DA7[level._id_804A2874C0323DA7.size] = model;
}

_id_1BF2A80EE67D9654() {
  level endon("game_ended");
  self endon("detonateExplosive");
  self endon("death");
  _id_08DADA2BFDB065B1 = 88;
  _id_A5B12ADEAD58E3D5 = _id_08DADA2BFDB065B1 * _id_08DADA2BFDB065B1;
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"]);

  for(;;) {
    wait 0.1;
    nearbyplayer = scripts\cp\utility::give_closest_player_nearby(self.origin, _id_A5B12ADEAD58E3D5);

    if(isDefined(nearbyplayer)) {
      if(!scripts\engine\math::is_point_in_front(nearbyplayer.origin)) {
        continue;
      }
      if(abs(nearbyplayer.origin[2] - (self.origin[2] - 10)) > 20) {
        continue;
      }
      if(scripts\engine\trace::ray_trace_passed(self.origin, nearbyplayer.origin, [self], contents)) {
        self notify("detonateExplosive", nearbyplayer);
        continue;
      }

      if(scripts\engine\trace::ray_trace_passed(self.origin, nearbyplayer getEye(), [self], contents))
        self notify("detonateExplosive", nearbyplayer);
    }
  }
}

_id_18088C142D166FE9() {
  level endon("game_ended");
  _id_B9CE53DAD043E9E4 = self.origin + (0, 0, 50) + anglesToForward(self.angles) * 95;
  _id_419BFD33C72E7EF9 = self.origin + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("detonateExplosive", nearbyplayer);
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  attacker = getaiarray("axis")[0];

  if(isDefined(nearbyplayer) && isalive(nearbyplayer)) {
    if(distance(nearbyplayer.origin, self.origin) < 100)
      nearbyplayer dodamage(100, self.origin, attacker, attacker, "MOD_TRIGGER_HURT");
  }

  level thread _id_829E26D465F70035(self.origin, 100);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, forward, up);
  level thread scripts\cp\utility::playsoundatpos_safe(self.origin, "iw9_frag_grenade_expl_trans");
  level._id_804A2874C0323DA7 = scripts\engine\utility::array_remove(level._id_804A2874C0323DA7, self);
  self delete();
}

_id_969296FC86121B8B() {
  level notify("new_maze_debug_display");
  level endon("new_maze_debug_display");

  if(isDefined(level._id_D47B85CA8A7815C7))
    level._id_D47B85CA8A7815C7 destroy();

  level._id_D47B85CA8A7815C7 = newhudelem();
  level._id_D47B85CA8A7815C7.x = 400;
  level._id_D47B85CA8A7815C7.y = 125;
  level._id_D47B85CA8A7815C7.color = (1, 0, 0.9);
  level._id_D47B85CA8A7815C7.alpha = 1.0;
  level._id_D47B85CA8A7815C7.hidden = 0;
  level._id_D47B85CA8A7815C7._id_9E76FE13C19DA9A3 = 0;
  level._id_D47B85CA8A7815C7._id_95EF0E28E73E593C = 0;
  level._id_D47B85CA8A7815C7.fontscale = 1.0;
  max = 15;
  level._id_D47B85CA8A7815C7 thread scripts\engine\utility::delaycall(max + 1, ::destroy);

  if(!isDefined(level._id_804A2874C0323DA7))
    level._id_804A2874C0323DA7 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < max; _id_AC0E594AC96AA3A8++) {
    text = "^1Enemy claymores total alive : " + level._id_804A2874C0323DA7.size + " ...";
    text = text + ("\n .Total spawned lifetime : " + level._id_ADFCAD02441F4649 + " ...");
    text = text + ("\n .(" + (max - _id_AC0E594AC96AA3A8) + "s)");
    level thread _id_62D476C426B7468C();
    wait 1;
  }
}

_id_62D476C426B7468C() {
  foreach(_id_656F0AE440B1B5D5 in level._id_804A2874C0323DA7) {
    if(isDefined(_id_656F0AE440B1B5D5.parent))
      continue;
  }
}

_id_86879C458815AB94() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready"))
    waitframe();

  scripts\engine\utility::flag_wait("scriptables_ready");
  barrels = getscriptablearray("scriptable_decor_barrels_gameplay_flammable_lowhealth", "classname");
  _id_FBEADC84E3E47938 = getscriptablearray("scriptable_decor_barrels_gameplay_flammable", "classname");
  barrels = scripts\engine\utility::array_combine(barrels, _id_FBEADC84E3E47938);
  scripts\engine\utility::array_thread(barrels, ::_id_19964212851CA7EE);

  for(;;) {
    dead = 0;

    foreach(_id_DDC4E4BDECFF28CD in barrels) {
      if(!scripts\engine\utility::is_equal(_id_DDC4E4BDECFF28CD getscriptablepartstate("base", 1), "dead") || istrue(_id_DDC4E4BDECFF28CD.dead)) {
        continue;
      }
      _id_DDC4E4BDECFF28CD notify("stop_logic");
      _id_DDC4E4BDECFF28CD.dead = 1;
      dead++;
      waitframe();
    }

    if(dead == barrels.size) {
      return;
    }
    wait 1;
  }
}

_id_19964212851CA7EE() {
  self endon("stop_logic");
  self.health = 40;
  self._id_689D46E1E37CC5AD = ::_id_42A278B3CCDCFAD0;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    _id_354C862768CFE202::process_damage_feedback(attacker, attacker, amount, _id_44E290FB31B85206, meansofdeath, objweapon, direction_vec, direction_vec, partname, undefined, self);
  }
}

_id_42A278B3CCDCFAD0(idamage) {
  if(idamage >= self.health) {
    level thread _id_829E26D465F70035(self.origin);
    return 1;
  }

  return 0;
}

_id_829E26D465F70035(origin, _id_46F15229FA7DE09B) {
  maxdist = 256;

  if(isDefined(_id_46F15229FA7DE09B))
    maxdist = _id_46F15229FA7DE09B;

  _id_CDC5DD6C28C9709D = maxdist * maxdist;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_804A2874C0323DA7.size; _id_AC0E594AC96AA3A8++) {
    _id_656F0AE440B1B5D5 = level._id_804A2874C0323DA7[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_656F0AE440B1B5D5) && isent(_id_656F0AE440B1B5D5)) {
      if(distancesquared(origin, _id_656F0AE440B1B5D5.origin) < _id_CDC5DD6C28C9709D)
        _id_656F0AE440B1B5D5 notify("detonateExplosive");
    }
  }

  glassradiusdamage(origin, maxdist, 99999, 9999);
}

_id_DB46836AA3F8969B() {
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_6416FB9A24D278B4);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_42974A5D66E156B8);
  level._id_389461E50023B898 = spawnStruct();
  level._id_389461E50023B898._id_6F99E830A75518FA = [];
  level._id_389461E50023B898._id_11BE92A51BC01707 = 0;
  level._id_389461E50023B898._id_72E7130051CE9141 = [];
  level._id_389461E50023B898._id_8E5B53035959F2D2 = [];
  level thread _id_65474E3DDFC5B929();
  level thread _id_487494982385FACD();
  level thread _id_52A5879D333091DB();
  level thread _id_AF1FA444011AF99B();
}

_id_6416FB9A24D278B4(scriptable, player) {
  return "CP_RAID1_MAZE/DOOR_LOCKED";
}

_id_42974A5D66E156B8(instance, player, _id_85E3240D30E184E7) {
  return 1;
}

_id_65474E3DDFC5B929() {
  _id_36E4555D3788AD40 = scripts\engine\utility::getStructArray("door_effect_lock_radius", "script_noteworthy");
  level._id_389461E50023B898._id_11BE92A51BC01707 = _id_36E4555D3788AD40.size;

  foreach(_id_4546F22B5CDBDDB3 in _id_36E4555D3788AD40) {
    pos = _id_4546F22B5CDBDDB3.origin;
    radius = scripts\engine\utility::ter_op(isDefined(_id_4546F22B5CDBDDB3.radius), _id_4546F22B5CDBDDB3.radius, 100);
    _id_8083C7DFFFBDF168 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(pos, radius);
    _id_0716DFDFBA692DD1 = spawnStruct();
    _id_0716DFDFBA692DD1.origin = pos;
    _id_0716DFDFBA692DD1.radius = radius;

    foreach(_id_0E07FDA417A4F08B in _id_8083C7DFFFBDF168) {
      _id_0E07FDA417A4F08B _id_3B64EB40368C1450::set("raid_maze_door_lock", "door_frozen", 1);
      level._id_389461E50023B898._id_6F99E830A75518FA[level._id_389461E50023B898._id_6F99E830A75518FA.size] = _id_0E07FDA417A4F08B;
    }

    level._id_389461E50023B898._id_72E7130051CE9141[level._id_389461E50023B898._id_72E7130051CE9141.size] = _id_0716DFDFBA692DD1;
    wait 0.05;
  }
}

_id_487494982385FACD() {
  _id_16DB5168C95BBCBD = scripts\engine\utility::getStructArray("door_effect_group_lockrandom", "targetname");

  foreach(_id_5C7C45C033E7571D in _id_16DB5168C95BBCBD) {
    level._id_389461E50023B898._id_8E5B53035959F2D2[level._id_389461E50023B898._id_8E5B53035959F2D2.size] = _id_5C7C45C033E7571D;
    _id_5BC8BA41B8247294 = scripts\engine\utility::getStructArray(_id_5C7C45C033E7571D.target, "targetname");
    _id_F950DF6BB5FA3703 = scripts\engine\utility::ter_op(isDefined(_id_5C7C45C033E7571D.script_noteworthy), _id_5C7C45C033E7571D.script_noteworthy, 1);
    _id_F950DF6BB5FA3703 = int(_id_F950DF6BB5FA3703);

    if(_id_F950DF6BB5FA3703 > _id_5BC8BA41B8247294.size)
      _id_F950DF6BB5FA3703 = _id_5BC8BA41B8247294.size;

    _id_5C7C45C033E7571D._id_F950DF6BB5FA3703 = _id_F950DF6BB5FA3703;
    _id_5C7C45C033E7571D._id_5BC8BA41B8247294 = _id_5BC8BA41B8247294;

    if(!isDefined(_id_5C7C45C033E7571D._id_BD59A95FC824E0F9))
      _id_5C7C45C033E7571D._id_BD59A95FC824E0F9 = [];

    _id_5BC8BA41B8247294 = scripts\engine\utility::array_randomize(_id_5BC8BA41B8247294);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F950DF6BB5FA3703; _id_AC0E594AC96AA3A8++) {
      _id_268A2463FA58D460 = _id_5BC8BA41B8247294[_id_AC0E594AC96AA3A8];
      pos = _id_268A2463FA58D460.origin;
      radius = scripts\engine\utility::ter_op(isDefined(_id_268A2463FA58D460.radius), _id_268A2463FA58D460.radius, 100);
      _id_8083C7DFFFBDF168 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(pos, radius);

      foreach(_id_0E07FDA417A4F08B in _id_8083C7DFFFBDF168) {
        _id_0E07FDA417A4F08B thread _id_25B032CDBFD54EDF(_id_268A2463FA58D460, _id_5C7C45C033E7571D);
        _id_0E07FDA417A4F08B _id_3B64EB40368C1450::set("raid_maze_door_group", "door_frozen", 1);
        _id_5C7C45C033E7571D._id_BD59A95FC824E0F9[_id_5C7C45C033E7571D._id_BD59A95FC824E0F9.size] = _id_0E07FDA417A4F08B;
      }
    }

    wait 0.05;
  }
}

_id_25B032CDBFD54EDF(struct, _id_5C7C45C033E7571D) {
  level endon("game_ended");
  success = _id_7E71DCFAA802E9FD(struct);

  if(!success) {
    return;
  }
  if(!isDefined(struct._id_D3EA2709CD534EAA)) {
    return;
  }
  _id_BE8ED00FD64C22B5(struct);
  struct._id_D3EA2709CD534EAA _id_2DF555E236BBA486();

  if(isDefined(struct._id_D3EA2709CD534EAA))
    struct._id_D3EA2709CD534EAA delete();

  foreach(_id_49F578A66F0B65F9 in struct._id_B23DE00636104E7E)
  _id_49F578A66F0B65F9 delete();

  foreach(_id_BCD14643777D1C50 in _id_5C7C45C033E7571D._id_BD59A95FC824E0F9)
  _id_BCD14643777D1C50 _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("raid_maze_door_group");
}

_id_BE8ED00FD64C22B5(struct) {
  hintstring = &"CP_RAID_WATERMAZE/DOOR_LOCKED_OTHERSIDE";
  _id_963953C3478BF4FE = self.origin + rotatevector((49, 0, 41), self.angles);
  obj = scripts\cp\utility::createhintobject(_id_963953C3478BF4FE, "HINT_BUTTON", undefined, hintstring, undefined, "duration_none", "show", 140, 90, 80, 60);
  obj setModel("tag_origin");
  obj show();
  obj makeusable();

  if(!isDefined(struct._id_B23DE00636104E7E))
    struct._id_B23DE00636104E7E = [];

  struct._id_B23DE00636104E7E[struct._id_B23DE00636104E7E.size] = obj;
}

_id_7E71DCFAA802E9FD(struct) {
  if(isDefined(struct.target)) {
    trigger = getEnt(struct.target, "targetname");

    if(istrue(trigger._id_8343675ABCFBF20D))
      return 0;

    if(isDefined(trigger) && isent(trigger)) {
      struct._id_D3EA2709CD534EAA = trigger;
      trigger._id_8343675ABCFBF20D = 1;
      return 1;
    }
  }

  return 0;
}

_id_2DF555E236BBA486() {
  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    return;
  }
}

_id_52A5879D333091DB() {
  _id_F5E7721EED069EB7 = getEntArray("door_effect_group_brushmodel", "targetname");

  if(!isDefined(_id_F5E7721EED069EB7) || _id_F5E7721EED069EB7.size == 0) {
    return;
  }
  level._id_20DA425625414A99 = [];

  foreach(brush in _id_F5E7721EED069EB7) {
    struct = spawnStruct();
    struct.origin = brush.origin;
    struct.id = level._id_20DA425625414A99.size;
    level._id_20DA425625414A99[level._id_20DA425625414A99.size] = struct;
  }

  _id_807589063278AE95 = 1;
  _id_F5E7721EED069EB7 = scripts\engine\utility::array_randomize(_id_F5E7721EED069EB7);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_807589063278AE95; _id_AC0E594AC96AA3A8++) {
    _id_F5E7721EED069EB7[_id_AC0E594AC96AA3A8] delete();
    _id_F5E7721EED069EB7 = scripts\engine\utility::array_removeundefined(_id_F5E7721EED069EB7);
  }
}

_id_AF1FA444011AF99B() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");

  while(level.players.size == 0)
    wait 1;

  wait 1;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Water Maze / Display Doors Single Locked\" \"set scr_watermaze_displaysinglelocked 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_06210EE247808946", ::_id_73BC589EB46CDEA4);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Water Maze / Display Doors Group Locked\" \"set scr_watermaze_displaygrouplocked 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_67F06EE0EC014FE1", ::_id_CA7F70BF1408609B);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Water Maze / Display Enemy Claymores\" \"set scr_watermaze_displayclaymores 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_C19747022A88D929", ::_id_969296FC86121B8B);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Water Maze / Display Doors Brushes\" \"set scr_watermaze_displaydoorsbrushes 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_B05B18269C6765AB", ::_id_D7A286DEF34C8611);
  _id_91A06C50183ECBA2();
}

_id_91A06C50183ECBA2() {
  if(isDefined(level._id_CBB69F1166D546E9)) {
    return;
  }
  level._id_CBB69F1166D546E9 = 1;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Water Maze o2 / P2 grab mask\" \"set scr_watermaze_p2grabp1mask 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Water Maze o2 / P3 grab mask\" \"set scr_watermaze_p3grabp1mask 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_96D11BC0E5F090E1", ::_id_0E4ABEC7849406E9);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_024768E2A15DD0EE", ::_id_A90F3C80F30CF8B6);
}

_id_73BC589EB46CDEA4() {
  level notify("new_maze_debug_display");
  level endon("new_maze_debug_display");

  if(isDefined(level._id_D47B85CA8A7815C7))
    level._id_D47B85CA8A7815C7 destroy();

  level._id_D47B85CA8A7815C7 = newhudelem();
  level._id_D47B85CA8A7815C7.x = 400;
  level._id_D47B85CA8A7815C7.y = 125;
  level._id_D47B85CA8A7815C7.color = (1, 0, 0.9);
  level._id_D47B85CA8A7815C7.alpha = 1.0;
  level._id_D47B85CA8A7815C7.hidden = 0;
  level._id_D47B85CA8A7815C7._id_9E76FE13C19DA9A3 = 0;
  level._id_D47B85CA8A7815C7._id_95EF0E28E73E593C = 0;
  level._id_D47B85CA8A7815C7.fontscale = 1.0;
  max = 15;
  level._id_D47B85CA8A7815C7 thread scripts\engine\utility::delaycall(max + 1, ::destroy);
  _id_CD1D3361FC24AF16 = level._id_389461E50023B898._id_11BE92A51BC01707;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < max; _id_AC0E594AC96AA3A8++) {
    text = "^1Single Doors Locked: " + level._id_389461E50023B898._id_6F99E830A75518FA.size + " ...";
    text = text + ("\n .Total noteworthy structs found to lock: " + _id_CD1D3361FC24AF16 + " ...");
    text = text + ("\n .(" + (max - _id_AC0E594AC96AA3A8) + "s)");
    level thread _id_B37AF1AFC6975A58();
    wait 1;
  }
}

_id_B37AF1AFC6975A58() {
  _id_CA09B95AD12396A7 = (1, 0.64, 0);

  foreach(struct in level._id_389461E50023B898._id_72E7130051CE9141) {}

  foreach(_id_BCD14643777D1C50 in level._id_389461E50023B898._id_6F99E830A75518FA) {}
}

_id_CA7F70BF1408609B() {
  level notify("new_maze_debug_display");
  level endon("new_maze_debug_display");

  if(isDefined(level._id_D47B85CA8A7815C7))
    level._id_D47B85CA8A7815C7 destroy();

  level._id_D47B85CA8A7815C7 = newhudelem();
  level._id_D47B85CA8A7815C7.x = 400;
  level._id_D47B85CA8A7815C7.y = 125;
  level._id_D47B85CA8A7815C7.color = (1, 0, 0.9);
  level._id_D47B85CA8A7815C7.alpha = 1.0;
  level._id_D47B85CA8A7815C7.hidden = 0;
  level._id_D47B85CA8A7815C7._id_9E76FE13C19DA9A3 = 0;
  level._id_D47B85CA8A7815C7._id_95EF0E28E73E593C = 0;
  level._id_D47B85CA8A7815C7.fontscale = 1.0;
  _id_CA09B95AD12396A7 = (1, 0.64, 0);
  max = 15;
  level._id_D47B85CA8A7815C7 thread scripts\engine\utility::delaycall(max + 1, ::destroy);
  _id_342B7FB8A938DB3C = 0;

  foreach(group in level._id_389461E50023B898._id_8E5B53035959F2D2)
  _id_342B7FB8A938DB3C = _id_342B7FB8A938DB3C + group._id_BD59A95FC824E0F9.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < max; _id_AC0E594AC96AA3A8++) {
    text = "^1Groups of Door Locks: " + level._id_389461E50023B898._id_8E5B53035959F2D2.size + " ...";
    text = text + ("\n Total doors locked via groups: " + _id_342B7FB8A938DB3C + " ...");
    text = text + ("\n (" + (max - _id_AC0E594AC96AA3A8) + "s)");
    level thread _id_05175166B8537DA7();
    wait 1;
  }
}

_id_05175166B8537DA7() {
  _id_CA09B95AD12396A7 = (1, 0.64, 0);

  foreach(_id_5C7C45C033E7571D in level._id_389461E50023B898._id_8E5B53035959F2D2) {
    if(isDefined(_id_5C7C45C033E7571D._id_BD59A95FC824E0F9)) {
      foreach(_id_BCD14643777D1C50 in _id_5C7C45C033E7571D._id_BD59A95FC824E0F9) {}

      if(isDefined(_id_5C7C45C033E7571D._id_F950DF6BB5FA3703))
        amount = _id_5C7C45C033E7571D._id_F950DF6BB5FA3703;
    }
  }
}

_id_D7A286DEF34C8611() {
  _id_CA09B95AD12396A7 = (1, 0.64, 0);
  time = 200;

  foreach(_id_60B697DA424053BE in level._id_20DA425625414A99) {}
}

_id_0E4ABEC7849406E9() {
  if(level.players.size < 2) {
    return;
  }
  player = level.players[1];
  _id_27A0BC40D0D2BC81 = getEnt("oxygenmask_usable_player", "targetname");

  if(!isDefined(_id_27A0BC40D0D2BC81)) {
    return;
  }
  _id_27A0BC40D0D2BC81 notify("trigger", player);
}

_id_A90F3C80F30CF8B6() {
  if(level.players.size < 3) {
    return;
  }
  player = level.players[2];
  _id_27A0BC40D0D2BC81 = getEnt("oxygenmask_usable_player", "targetname");

  if(!isDefined(_id_27A0BC40D0D2BC81)) {
    return;
  }
  _id_27A0BC40D0D2BC81 notify("trigger", player);
}

_id_6FC8E98766AC4CC1() {
  level endon("game_ended");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("maze_movingbox", "targetname");

  if(!isDefined(_id_9E4E1482CB40C9C5)) {
    return;
  }
  foreach(struct in _id_9E4E1482CB40C9C5) {
    _id_47A6D579E415C1D0 = spawn("script_model", struct.origin);
    _id_47A6D579E415C1D0.angles = struct.angles;
    _id_47A6D579E415C1D0 setModel("cardboard_box_small_01");
    level thread _id_69FA1500B00FDC63(_id_47A6D579E415C1D0);
    wait(0.1 + randomfloat(0.1));
  }
}

_id_69FA1500B00FDC63(_id_47A6D579E415C1D0) {
  level endon("game_ended");

  for(;;) {
    _id_47A6D579E415C1D0 rotateby((1, 1, 1), 0.5, 0.08, 0.08);
    _id_47A6D579E415C1D0 movez(-0.5, 0.5, 0.08, 0.08);
    wait 0.5;
    _id_47A6D579E415C1D0 rotateby((-1, -1, -1), 0.5, 0.08, 0.08);
    _id_47A6D579E415C1D0 movez(0.5, 0.5, 0.08, 0.08);
    wait 0.5;
  }
}

_id_F3416EE6BFA2F955() {
  level endon("game_ended");
  _id_C410B587DC57AF6E = getdvarint("dvar_D534F8E2E07F4673", 1);

  if(_id_C410B587DC57AF6E) {
    self setHintString(&"CP_RAID_WATERMAZE/NO_POWER");
    self setuseholdduration("duration_none");
    self.disabled = 1;
  }

  for(;;) {
    level waittill("maze_power_enabled", _id_3068716C250A5E58);

    if(istrue(_id_3068716C250A5E58)) {
      self setHintString(&"CP_RAID_WATERMAZE/DOOR_OPEN");
      self setuseholdduration("duration_none");
      self.disabled = 0;
      continue;
    }

    self setHintString(&"CP_RAID_WATERMAZE/NO_POWER");
    self setuseholdduration("duration_none");
    self.disabled = 1;
  }
}

_id_13FD87C4987BB2AD() {
  _id_2DCFF59967985ABD = scripts\engine\utility::getStruct("maze_gate_switch", "targetname");

  if(!isDefined(_id_2DCFF59967985ABD)) {
    announcement("no maze gate switch");
    return;
  }

  _id_2639F6CD79A6BA22 = spawn("script_model", _id_2DCFF59967985ABD.origin);
  _id_2639F6CD79A6BA22.angles = _id_2DCFF59967985ABD.origin;
  _id_2639F6CD79A6BA22 setModel("military_nuke_core_ball");
  _id_2639F6CD79A6BA22.targetname = "gate_switch_struct_usable";
  level._id_1779628EE27077B0 = _id_2639F6CD79A6BA22;
  _id_2639F6CD79A6BA22 endon("death");
  _id_2639F6CD79A6BA22 makeusable();
  _id_2639F6CD79A6BA22 setCursorHint("HINT_BUTTON");
  _id_2639F6CD79A6BA22 sethintdisplayrange(165);
  _id_2639F6CD79A6BA22 sethintdisplayfov(80);
  _id_2639F6CD79A6BA22 setuserange(45);
  _id_2639F6CD79A6BA22 setusefov(50);
  _id_2639F6CD79A6BA22 sethintonobstruction("show");
  _id_2639F6CD79A6BA22 setuseholdduration("duration_medium");

  for(;;) {
    _id_2639F6CD79A6BA22 waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      _id_2639F6CD79A6BA22 makeunusable();
      player playlocalsound("grenade_pickup");
      _id_2639F6CD79A6BA22 notify("switch_used");
      level thread _id_9F459E8046911296();
    }
  }
}

_id_9F459E8046911296() {
  door_ent = getEnt("maze_exit_gate", "targetname");
  _id_FEF7FF29C1843069 = getEnt("maze_exit_gate_model", "targetname");

  if(isDefined(door_ent) && isent(door_ent))
    door_ent delete();

  if(isDefined(_id_FEF7FF29C1843069) && isent(_id_FEF7FF29C1843069))
    _id_FEF7FF29C1843069 delete();

  announcement("^3Maze Gate Opened.");
}

_id_7FAFDE5EB2B72419() {
  data = spawnStruct();
  door_ent = getEnt("ending_puzzle_door", "script_noteworthy");
  _id_FEF7FF29C1843069 = getEnt("ending_puzzle_door_model", "script_noteworthy");
  door_ent linkTo(_id_FEF7FF29C1843069);

  if(!isDefined(_id_FEF7FF29C1843069.script_offset))
    _id_FEF7FF29C1843069.script_offset = (0, 0, 60);

  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("2man_out_maze", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_master_maze", "targetname");
  _id_5AC49E018B46B2CD.origin = _id_5AC49E018B46B2CD.origin + rotatevector((0, 0, 0.25), _id_5AC49E018B46B2CD.angles);
  _id_20F3271DC43A6012.origin = _id_20F3271DC43A6012.origin + rotatevector((0, 0, 0.25), _id_20F3271DC43A6012.angles);
  _id_FEF7FF29C1843069.target = _id_5AC49E018B46B2CD.targetname;
  hintstring = &"CP_RAID_WATERMAZE/NO_POWER";
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(_id_FEF7FF29C1843069);
  _id_FEF7FF29C1843069 thread _id_C093C2F3D1CFEE0B();
  _id_2603F87EB4879FBA = [];
  _id_2603F87EB4879FBA[_id_2603F87EB4879FBA.size] = _id_FEF7FF29C1843069._id_590D3F80EE9B48CB;
  _id_2603F87EB4879FBA[_id_2603F87EB4879FBA.size] = _id_FEF7FF29C1843069._id_7432D0D0FA70617C;

  foreach(button in _id_2603F87EB4879FBA)
  button thread _id_F3416EE6BFA2F955();
}

_id_55CD3AB76D72BDAF() {
  foreach(door in self.doors)
  door thread _id_C093C2F3D1CFEE0B();
}

_id_C093C2F3D1CFEE0B() {
  level endon("game_ended");
  self notify("puzzle_doors_sound_watchfornotify");
  self endon("puzzle_doors_sound_watchfornotify");

  for(;;) {
    scripts\engine\utility::waittill_any_2("door_open", "door_close");
    thread scripts\cp\utility::playsoundatpos_safe(self.origin, "cp_puzzledoor_open");
  }
}

_id_723E0290430D0D00() {
  level endon("game_ended");

  while(level.players.size == 0)
    wait 5;

  _id_BE54B263FCC77733 = scripts\engine\utility::getStruct("maze_endofscripting", "targetname");
  maxdist = 1000000;

  if(_id_00C84EC5404C9B1F()) {
    if(isDefined(_id_BE54B263FCC77733.radius))
      maxdist = _id_BE54B263FCC77733.radius * _id_BE54B263FCC77733.radius;

    while(!scripts\cp\utility::are_all_players_nearby(_id_BE54B263FCC77733.origin, maxdist)) {
      if(scripts\cp\utility::any_player_nearby(_id_BE54B263FCC77733.origin, maxdist))
        level thread _id_2FC74196DF9BFE10();

      wait 0.25;
    }
  } else {
    while(!scripts\cp\utility::any_player_nearby(_id_BE54B263FCC77733.origin, maxdist))
      wait 0.25;
  }

  scripts\engine\utility::flag_set("maze_completed");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Water Maze");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid Transition: Water Maze - Nums");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F();

  level thread _id_1DB8D0E02A99C5E2::_id_D0E0B1A0DC489379();
  level thread _id_1E9BF201EA44567C::_id_80DC43014F80E68B();

  if(scripts\cp\cp_checkpoint::_id_9EED75023A958C18() != "checkpoint_maze_armory") {
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_maze_armory");
    level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "startpoint_armory");
  }

  if(_id_00C84EC5404C9B1F()) {
    for(;;) {
      announcement("^5End of scripting...");
      wait 5;
      announcement("^5Go to stealth section...");
      wait 60;
    }
  }
}

_id_2FC74196DF9BFE10() {
  if(!_id_00C84EC5404C9B1F()) {
    return;
  }
  if(istrue(level._id_E6956172E2592D5D)) {
    return;
  }
  level._id_E6956172E2592D5D = 1;
  announcement("Bring all players to exit.");
  wait 3;
  level._id_E6956172E2592D5D = 0;
}

_id_00C84EC5404C9B1F() {
  mapname = getDvar("ui_mapname");

  if(mapname == "cp_raid1_maze")
    return 1;

  return 0;
}

_id_7D0F9F8E29EAF0AB() {
  _id_11D2F38D4F2C5AC7 = scripts\engine\utility::getStruct("maze_gas_interact", "targetname");
  _id_C7BB3AA8DA7CC07D = "maze_gas_interact_fx";
  _id_11D2F38D4F2C5AC7 thread _id_25D34FEA909AADC5::_id_F21AE5A240979E87(_id_C7BB3AA8DA7CC07D);
  level._id_8ECC159BA05FA524 = _id_669C0F6CB0B7F0CD::_id_9DFDAD79E177BA83;
}

_id_A85A3BB76B2DE00D() {
  data = spawnStruct();
  door_ent = getEnt("2man_hallway_door_clip", "script_noteworthy");

  if(!isDefined(door_ent)) {
    return;
  }
  _id_FEF7FF29C1843069 = getEnt("2man_hallway_door", "script_noteworthy");
  door_ent linkTo(_id_FEF7FF29C1843069);

  if(!isDefined(_id_FEF7FF29C1843069.script_offset))
    _id_FEF7FF29C1843069.script_offset = (-50, 0, 0);

  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("2man_hallway_out_maze", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_hallway_master_maze", "targetname");
  _id_5AC49E018B46B2CD.origin = _id_5AC49E018B46B2CD.origin + rotatevector((0, 0, 0.25), _id_5AC49E018B46B2CD.angles);
  _id_20F3271DC43A6012.origin = _id_20F3271DC43A6012.origin + rotatevector((0, 0, 0.25), _id_20F3271DC43A6012.angles);
  _id_FEF7FF29C1843069.target = _id_5AC49E018B46B2CD.targetname;
  hintstring = &"CP_RAID_WATERMAZE/DOOR_OPEN";
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(_id_FEF7FF29C1843069);
  _id_FEF7FF29C1843069 thread _id_C093C2F3D1CFEE0B();
}