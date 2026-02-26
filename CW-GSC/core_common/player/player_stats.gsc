/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_stats.gsc
***********************************************/

#using scripts\core_common\player\player_loadout;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;
#namespace stats;

function function_d92cb558(result, vararg) {
  if(!isDefined(result)) {
    pathstr = ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0];

    if(!isDefined(pathstr)) {
      return;
    }

    for(i = 1; i < vararg.size; i++) {
      pathstr = pathstr + "<dev string:x38>" + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
    }

    println("<dev string:x3d>" + pathstr);
  }
}

function function_f94325d3() {
  assert(isPlayer(self), "<dev string:x5b>");

  if(sessionmodeiscampaigngame()) {
    return true;
  }

  if(sessionmodeiszombiesgame()) {
    if(level.gametype === # "doa") {
      return true;
    }
  }

  if(isbot(self) || is_true(level.disablestattracking)) {
    return false;
  }

  return true;
}

function function_ca76d4a() {
  var_c282197b = gettime() + int(30 * 1000);

  while(gettime() < var_c282197b) {
    if(function_2b9d6412()) {
      break;
    }

    waitframe(1);
  }

  level.var_87d7c3ab = 1;
}

function function_8921af36() {
  return level.var_12323003;
}

function get_stat(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:x5b>");
    result = self readstat(0, vararg);

    function_d92cb558(result, vararg);
  }

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}

function function_e3eb9a8b(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:x87>");
    result = self readstat(1, vararg);

    function_d92cb558(result, vararg);
  }

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}

function function_1bb1c57c(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:x5b>");
    result = self readstat(2, vararg);

    function_d92cb558(result, vararg);
  }

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}

function function_6d50f14b(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:xba>");
    result = self readstat(3, vararg);

    function_d92cb558(result, vararg);
  }

  return result;
}

function function_ff8f4f17(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:xee>");
    result = self readstat(4, vararg);

    function_d92cb558(result, vararg);
  }

  return result;
}

function set_stat(...) {
  assert(!is_true(level.var_87d7c3ab));
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return 0;
  }

  if(!function_f94325d3()) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:x124>");
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = self writestat(0, vararg, value);

    function_d92cb558(result, vararg);
  }

  return is_true(result);
}

function function_505387a6(...) {
  assert(!is_true(level.var_87d7c3ab));
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return 0;
  }

  if(!function_f94325d3()) {
    return 0;
  }

  result = 0;

  if(isDefined(self)) {
    assert(isPlayer(self), "<dev string:x124>");
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    result = self writestat(1, vararg, value);

    function_d92cb558(result, vararg);
  }

  return is_true(result);
}

function inc_stat(...) {
  assert(!is_true(level.var_87d7c3ab));
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return;
  }

  if(!function_f94325d3()) {
    return;
  }

  assert(isPlayer(self), "<dev string:x124>");

  if(!isPlayer(self)) {
    return;
  }

  value = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  result = self incrementstat(0, vararg, value);

  function_d92cb558(result, vararg);

  return is_true(result);
}

function function_f5859f81(...) {
  assert(!is_true(level.var_87d7c3ab));
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return;
  }

  if(!function_f94325d3()) {
    return;
  }

  player = self;
  assert(isPlayer(player), "<dev string:x124>");

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  value = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  result = player incrementstat(1, vararg, value);

  function_d92cb558(result, vararg);

  return is_true(result);
}

function private function_e6106f3b(statname, value) {
  self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
  self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"challengevalue", value);
  self set_stat(#"playerstatslist", statname, #"statvalue", value);
  self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

function private function_1d354b96(statname, value) {
  var_44becfa9 = self inc_stat(#"playerstatslist", statname, #"statvalue", value);
  self addgametypestat(statname, value);
  return var_44becfa9;
}

function function_ed81f25e(statname) {
  return self get_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue");
}

function function_baa25a23(statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self set_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
  return true;
}

function function_d40764f3(statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self addgametypestat(statname, value);
  return true;
}

function function_cc215323(statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"playerstatsbygametype", function_8921af36(), statname, #"statvalue", value);
  return true;
}

function function_a2261724(weapon) {
  statweapon = isDefined(weapon.statname) ? getweapon(weapon.statname) : undefined;
  return isDefined(statweapon) && statweapon != level.weaponnone ? statweapon : weapon;
}

function function_a431be09(weapon) {
  statweapon = function_a2261724(weapon);
  loadout_slot_index = self loadout::function_8435f729(statweapon);

  if(loadout_slot_index === "primarygrenade" || loadout_slot_index === "secondarygrenade" || loadout_slot_index === "specialgrenade") {
    weaponname = function_3f64434(statweapon);
    self function_622feb0d(weaponname, #"destructions", 1);
    self function_6fb0b113(weaponname, #"best_destructions");
    return;
  }

  if(isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](statweapon) && isDefined(level.get_killstreak_for_weapon_for_stats)) {
    killstreak = [[level.get_killstreak_for_weapon_for_stats]](statweapon);

    if(killstreak === "jetfighter") {
      return;
    }

    self function_8fb23f94(killstreak, "destructions", 1);
    self function_b04e7184(killstreak, #"best_destructions");
    return;
  }

  self function_561716e6(statweapon.name, #"destroyed", 1);
  self function_80099ca1(statweapon.name, #"best_destroyed");
}

function function_b2c11cc(weapon, statname) {
  return self get_stat(#"hash_3713686a5fc7b39e", weapon, statname, #"statvalue");
}

function function_53e7d4a5(weapon, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self set_stat(#"hash_3713686a5fc7b39e", weapon, statname, #"statvalue", value);
  return true;
}

function function_561716e6(weapon, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"hash_3713686a5fc7b39e", weapon, statname, #"statvalue", value);
  return true;
}

function function_6cdd992f(weapon, bucket, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"hash_3713686a5fc7b39e", weapon, #"engagement_ranges", bucket, #"statvalue", value);
  return true;
}

function function_328bc34a(weapon, location, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"hash_3713686a5fc7b39e", weapon, #"hash_5b635080228b9c03", location, #"statvalue", value);
  return true;
}

function function_80099ca1(weapon, statname) {
  if(!function_f94325d3()) {
    return false;
  }

  if(!isDefined(self.pers[#"hash_45ad01f9212e202c"])) {
    self.pers[#"hash_45ad01f9212e202c"] = [];
  }

  if(!isDefined(self.pers[#"hash_45ad01f9212e202c"][weapon])) {
    self.pers[#"hash_45ad01f9212e202c"][weapon] = [];
  }

  if(!isDefined(self.pers[#"hash_45ad01f9212e202c"][weapon][statname])) {
    self.pers[#"hash_45ad01f9212e202c"][weapon][statname] = 0;
  }

  self.pers[#"hash_45ad01f9212e202c"][weapon][statname]++;
  value = self.pers[#"hash_45ad01f9212e202c"][weapon][statname];

  if(value > self function_b2c11cc(weapon, statname)) {
    self function_53e7d4a5(weapon, statname, value);
    return true;
  }

  return false;
}

function function_97f7728e(equipment, statname) {
  return self get_stat(#"hash_7a634ccef92080c6", equipment, statname, #"statvalue");
}

function function_3f64434(weapon) {
  weaponname = weapon.name;

  if(weaponname === # "molotov_fire") {
    weaponname = # "eq_molotov";
  }

  return weaponname;
}

function function_c8da9a88(equipment, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self set_stat(#"hash_7a634ccef92080c6", equipment, statname, #"statvalue", value);
  return true;
}

function function_622feb0d(equipment, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"hash_7a634ccef92080c6", equipment, statname, #"statvalue", value);
  return true;
}

function function_6fb0b113(equipment, statname) {
  if(!function_f94325d3()) {
    return false;
  }

  if(!isDefined(self.pers[#"hash_535ec6a0c26aaa28"])) {
    self.pers[#"hash_535ec6a0c26aaa28"] = [];
  }

  if(!isDefined(self.pers[#"hash_535ec6a0c26aaa28"][equipment])) {
    self.pers[#"hash_535ec6a0c26aaa28"][equipment] = [];
  }

  if(!isDefined(self.pers[#"hash_535ec6a0c26aaa28"][equipment][statname])) {
    self.pers[#"hash_535ec6a0c26aaa28"][equipment][statname] = 0;
  }

  self.pers[#"hash_535ec6a0c26aaa28"][equipment][statname]++;
  value = self.pers[#"hash_535ec6a0c26aaa28"][equipment][statname];

  if(value > self function_97f7728e(equipment, statname)) {
    self function_c8da9a88(equipment, statname, value);
    return true;
  }

  return false;
}

function function_9792680b(scorestreak, statname) {
  return self get_stat(#"hash_5d925e2af850ce9e", scorestreak, statname, #"statvalue");
}

function function_1eb9272f(scorestreak, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self set_stat(#"hash_5d925e2af850ce9e", scorestreak, statname, #"statvalue", value);
  return true;
}

function function_8fb23f94(scorestreak, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"hash_5d925e2af850ce9e", scorestreak, statname, #"statvalue", value);
  return true;
}

function function_b04e7184(scorestreak, statname) {
  if(!function_f94325d3()) {
    return false;
  }

  if(!isDefined(self.pers[#"hash_5720f063ea8634a8"])) {
    self.pers[#"hash_5720f063ea8634a8"] = [];
  }

  if(!isDefined(self.pers[#"hash_5720f063ea8634a8"][scorestreak])) {
    self.pers[#"hash_5720f063ea8634a8"][scorestreak] = [];
  }

  if(!isDefined(self.pers[#"hash_5720f063ea8634a8"][scorestreak][statname])) {
    self.pers[#"hash_5720f063ea8634a8"][scorestreak][statname] = 0;
  }

  self.pers[#"hash_5720f063ea8634a8"][scorestreak][statname]++;
  value = self.pers[#"hash_5720f063ea8634a8"][scorestreak][statname];

  if(value > self function_9792680b(scorestreak, statname)) {
    self function_1eb9272f(scorestreak, statname, value);
    return true;
  }

  return false;
}

function function_bd731115(vehicle, statname) {
  return self get_stat(#"hash_3d466b9663c34ff2", vehicle, statname, #"statvalue");
}

function function_e1c64c80(vehicle, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self set_stat(#"hash_3d466b9663c34ff2", vehicle, statname, #"statvalue", value);
  return true;
}

function function_7fd36562(vehicle, statname, value) {
  if(!function_f94325d3()) {
    return false;
  }

  self inc_stat(#"hash_3d466b9663c34ff2", vehicle, statname, #"statvalue", value);
  return true;
}

function function_7a850245(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  return self set_stat(#"afteractionreportstats", statname, value);
}

function function_62b271d8(statname, value) {
  if(!sessionmodeiswarzonegame()) {
    return;
  }

  teammates = getplayers(self.team);

  foreach(player in teammates) {
    if(!player function_f94325d3()) {
      continue;
    }

    teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");

    if(!isDefined(teammatecount)) {
      return;
    }

    playerxuid = int(self getxuid(1));

    for(i = 0; i < teammatecount; i++) {
      var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");

      if(var_bd8d01a8 === playerxuid) {
        player set_stat(#"afteractionreportstats", #"teammates", i, statname, value);
        break;
      }
    }
  }
}

function function_b7f80d87(statname, value) {
  if(!sessionmodeiswarzonegame()) {
    return;
  }

  teammates = getplayers(self.team);

  foreach(player in teammates) {
    if(!player function_f94325d3()) {
      continue;
    }

    teammatecount = get_stat(#"afteractionreportstats", #"teammatecount");

    if(!isDefined(teammatecount)) {
      return;
    }

    playerxuid = int(self getxuid(1));

    for(i = 0; i < teammatecount; i++) {
      var_bd8d01a8 = player get_stat(#"afteractionreportstats", #"teammates", i, #"xuid");

      if(var_bd8d01a8 === playerxuid) {
        player inc_stat(#"afteractionreportstats", #"teammates", i, statname, value);
        break;
      }
    }
  }
}

function function_81f5c0fe(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  gametype = level.var_12323003;
  map = util::get_map_name();
  mapstats = gamemodeisarena() ? # "mapstatsarena" : # "mapstats";
  return self inc_stat(mapstats, map, #"permode", gametype, statname, value);
}

function set_stat_global(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  if(sessionmodeiscampaigngame()) {
    return self function_505387a6(#"playerstatslist", statname, #"statvalue", value);
  }

  return self set_stat(#"playerstatslist", statname, #"statvalue", value);
}

function get_stat_global(statname) {
  if(sessionmodeiscampaigngame()) {
    return self function_e3eb9a8b(#"playerstatslist", statname, #"statvalue");
  }

  return self get_stat(#"playerstatslist", statname, #"statvalue");
}

function function_c5453ed4(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  assert(!sessionmodeiscampaigngame());
  return self function_505387a6(#"playerstatslist", statname, #"statvalue", value);
}

function function_927be59d(statname) {
  assert(!sessionmodeiscampaigngame());
  return self function_e3eb9a8b(#"playerstatslist", statname, #"statvalue");
}

function set_stat_challenge(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  return self set_stat(#"playerstatslist", statname, #"challengevalue", value);
}

function get_stat_challenge(statname) {
  return self get_stat(#"playerstatslist", statname, #"challengevalue");
}

function function_af5584ca(statname) {
  return self get_stat(#"playerstatslist", statname, #"challengetier");
}

function function_8e071909(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  return self set_stat(#"playerstatslist", statname, #"challengetier", value);
}

function function_878e75b7(statname) {
  return self get_stat(#"playerstatsbygametype", function_8921af36(), statname, #"challengevalue");
}

function function_dad108fa(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  if(sessionmodeiscampaigngame()) {
    return self function_f5859f81(#"playerstatslist", statname, #"statvalue", value);
  }

  return self inc_stat(#"playerstatslist", statname, #"statvalue", value);
}

function function_42277145(statname, value) {
  if(!function_f94325d3()) {
    return 0;
  }

  assert(!sessionmodeiscampaigngame());
  return self function_f5859f81(#"playerstatslist", statname, #"statvalue", value);
}

function function_bb7eedf0(statname, value) {
  setglobal = self function_dad108fa(statname, value);
  return self addgametypestat(statname, value);
}

function function_d0de7686(statname, value, var_4261ca42) {
  if(getdvarint(var_4261ca42, 0) == 0) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(level.var_d619bc61 === 1) {
    if(!isDefined(self.pers)) {
      return;
    }

    if(!isDefined(self.pers[#"hash_58ebc906abf2fa00"])) {
      self.pers[#"hash_58ebc906abf2fa00"] = [];
    }

    if(!isDefined(self.pers[#"hash_58ebc906abf2fa00"][statname])) {
      self.pers[#"hash_58ebc906abf2fa00"][statname] = 0;
    }

    self.pers[#"hash_58ebc906abf2fa00"][statname]++;
    return;
  }

  return self function_dad108fa(statname, value);
}

function function_841e4896(statname, value, var_4261ca42, weaponnamehash) {
  if(getdvarint(var_4261ca42, 0) == 0) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(self function_a3a54104(weaponnamehash)) {
    return;
  }

  if(level.var_d619bc61 === 1) {
    if(!isDefined(self.pers)) {
      return;
    }

    if(!isDefined(self.pers[#"hash_58ebc906abf2fa00"])) {
      self.pers[#"hash_58ebc906abf2fa00"] = [];
    }

    if(!isDefined(self.pers[#"hash_58ebc906abf2fa00"][statname])) {
      self.pers[#"hash_58ebc906abf2fa00"][statname] = 0;
    }

    self.pers[#"hash_58ebc906abf2fa00"][statname]++;
    return;
  }

  return self function_dad108fa(statname, value);
}

function function_a47092b5(statname, value, var_4261ca42) {
  if(getdvarint(var_4261ca42, 0)) {
    return self function_dad108fa(statname, value);
  }
}

function function_bcf9602(statname, value, var_4261ca42) {
  if(getdvarint(var_4261ca42, 0)) {
    return self function_42277145(statname, value);
  }
}

function function_eec52333(weapon, statname, value, classnum, pickedup, forceads) {
  if(sessionmodeiszombiesgame() && level.zm_disable_recording_stats === 1) {
    return;
  }

  if(isDefined(level.var_b10e134d)) {
    [[level.var_b10e134d]](self, weapon, statname, value);
  }

  self addweaponstat(weapon, statname, value, classnum, pickedup, forceads);

  switch (statname) {
    case # "shots":
    case # "used":
      self function_f95ea9b6(weapon);
      break;
    case # "kills":
      if(weapon.var_ff0b00ba) {
        self function_dad108fa(#"kills_equipment", 1);
      }

      break;
  }
}

function function_e24eec31(weapon, statname, value) {
  self function_eec52333(weapon, statname, value, undefined, undefined, undefined);
}