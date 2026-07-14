/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\weapons\lightning_chain.gsc
*****************************************************/

#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace lightning_chain;

function private autoexec __init__system__() {
  system::register(#"lightning_chain", undefined, undefined, &post_main);
}

function private post_main() {
  common_init();
  utility::callsharedfunc(#"lightning_chain", #"init");
}

function private common_init() {
  level._effect["tesla_bolt"] = loadfxasset("vfx_t10_gameplay_zm_weapons_tesla_elec_bolt_01");
  level._effect["tesla_shock"] = loadfxasset("vfx_jup_ob_gameplay_zm_tesla_shock_zmb");
  level._effect["tesla_shock_eyes"] = loadfxasset("vfx_t10_gameplay_zm_weapons_tesla_shock_eye");
  level._effect["tesla_shock_mouth"] = loadfxasset("vfx_t10_gameplay_zm_weapons_tesla_shock_mouth");
  level._effect["tesla_shock_ground"] = loadfxasset("vfx_jup_ob_gameplay_zm_tesla_shock_ground");
  level._effect["tesla_bolt_pap"] = loadfxasset("vfx_t10_gameplay_zm_weapons_tesla_elec_bolt_pap_01");
  level._effect["tesla_shock_pap"] = loadfxasset("vfx_jup_ob_gameplay_zm_tesla_shock_ug_zmb");
  level._effect["tesla_shock_eyes_pap"] = loadfxasset("vfx_t10_gameplay_zm_weapons_tesla_shock_eye_pap");
  level._effect["tesla_shock_mouth_pap"] = loadfxasset("vfx_t10_gameplay_zm_weapons_tesla_shock_mouth_pap");
  level._effect["tesla_shock_ground_pap"] = loadfxasset("vfx_jup_ob_gameplay_zm_tesla_shock_ug_ground");
  level callback::add("on_zombie_ai_damaged", &function_a68037a538d49c18);
  level callback::add("on_soldier_ai_damaged", &function_a68037a538d49c18);
  level callback::add(#"player_laststand", &on_player_laststand);
  level callback::add(#"player_death", &on_player_death);
  level.var_cf7706e013c62841 = [];
  level.var_cf7706e013c62841[0] = 5000;
  level.var_cf7706e013c62841[1] = 10000;
  level.var_cf7706e013c62841[2] = 20000;
  level.var_cf7706e013c62841[3] = 40000;
  utility::registersharedfunc(#"lightning_chain", #"hash_1722084e0b6f97fc", &create_lightning_chain_params);
  utility::registersharedfunc(#"lightning_chain", #"lc_expand", &lc_expand);
  utility::registersharedfunc(#"lightning_chain", #"lc_stun_and_damage", &lc_stun_and_damage);
  utility::registersharedfunc(#"lightning_chain", #"lc_damage_calculation", &lc_damage_calculation);
  utility::registersharedfunc(#"lightning_chain", #"lc_play_stun_fx", &lc_play_stun_fx);
}

function create_lightning_chain_params(max_enemies_killed, radius, head_gib_chance, arc_travel_time, var_dc97cf84d9220187) {
  lcp = spawnStruct();
  lcp.max_enemies_killed = max_enemies_killed;
  lcp.arc_radius = radius;
  lcp.head_gib_chance = head_gib_chance;
  lcp.arc_travel_time = arc_travel_time;
  lcp.var_dc97cf84d9220187 = var_dc97cf84d9220187;
  return lcp;
}

function arc_damage(source_enemy, player, params) {
  if(!isDefined(params)) {
    return;
  }

  params.team = params.attacker.team ?? player.team;
  params.attacker_origin = params.attacker.origin ?? player.origin;
  var_f191c2408c95ef7 = !params.var_bca2b52118f73;
  thread utility::callsharedfunc(#"lightning_chain", #"lc_stun_and_damage", var_f191c2408c95ef7, params);

  if(ai::function_9c67144145079cca() && !params.var_fff5dc5501f9e352) {
    return;
  }

  expand_start_point = level function_edaa39ee22ae128b(source_enemy);
  level utility::callsharedfunc(#"lightning_chain", #"lc_expand", expand_start_point, params.max_enemies_killed - 1, params);
}

function function_7060ea3387a52416(params) {
  if(self.lc_stunned || self.team == params.attacker.team || self.team == params.team || isDefined(self.lc_records) && arraycontains(self.lc_records, params.lc_id)) {
    return true;
  }

  return false;
}

function private lc_expand(start_point, count_left, params) {
  var_d61135157d642a8f = int(min(params.var_dc97cf84d9220187, count_left));
  filtered_targets = [];
  targets = getplayersandaiarrayinradius(start_point, params.arc_radius);

  foreach(target in targets) {
    if(target function_7060ea3387a52416(params)) {
      continue;
    }

    if(isPlayer(target) && !trace::ray_trace_passed(start_point, target getEye(), targets)) {
      continue;
    }

    filtered_targets[filtered_targets.size] = target;
  }

  var_d61135157d642a8f = int(min(filtered_targets.size, var_d61135157d642a8f));

  if(var_d61135157d642a8f == 0) {
    return 0;
  }

  filtered_targets = sortbydistance(filtered_targets, start_point);

  for(i = 0; i < var_d61135157d642a8f; i++) {
    level thread function_36f0e2930c537867(start_point, filtered_targets[i], params);
  }

  if(params.var_fff5dc5501f9e352) {
    while(i > 0 && filtered_targets[i - 1] ai::is_boss()) {
      i--;
    }
  } else {
    while(i > 0 && filtered_targets[i - 1] ai::function_9c67144145079cca()) {
      i--;
    }
  }

  if(i == 0) {
    return;
  }

  next_start_point = function_edaa39ee22ae128b(filtered_targets[i - 1]);
  count_left -= var_d61135157d642a8f;

  if(count_left > 0) {
    level thread function_dd36404d9835d6b2(params.arc_travel_time + 0.1, next_start_point, count_left, params);
  }
}

function function_dd36404d9835d6b2(waittime, start_point, count_left, params) {
  wait waittime;
  level utility::callsharedfunc(#"lightning_chain", #"lc_expand", start_point, count_left, params);
}

function function_edaa39ee22ae128b(ai_target) {
  end_point = ai_target gettagorigin("J_SpineUpper", 1);

  if(!isDefined(end_point)) {
    end_point = ai_target.origin;
  }

  return end_point;
}

function function_36f0e2930c537867(start_point, ai_target, params) {
  end_point = function_edaa39ee22ae128b(ai_target);

  if(!isDefined(end_point)) {
    return;
  }

  var_a542a8f69a73e0fa = utility::spawn_tag_origin(start_point);
  var_a542a8f69a73e0fa show();

  if(params.var_516d207140d59c2 > 0) {
    bolt_fx = "tesla_bolt_pap";
  } else {
    bolt_fx = "tesla_bolt";
  }

  fx_id = level._effect[bolt_fx];

  if(isDefined(params.var_ff926fba88e29825)) {
    fx_id = params.var_ff926fba88e29825;
  }

  fx = playFXOnTag(fx_id, var_a542a8f69a73e0fa, "tag_origin");
  var_a542a8f69a73e0fa moveTo(end_point, params.arc_travel_time);
  var_a542a8f69a73e0fa waittill("movedone");
  var_a542a8f69a73e0fa delete();

  if(isalive(ai_target)) {
    ai_target thread utility::callsharedfunc(#"lightning_chain", #"lc_stun_and_damage", 0, params);
  }
}

function function_3dcee24de3aa889a(duration) {
  level endon("game_ended");
  self endon("death");

  if(self.health > 0 && !asm_bb::bb_isanimScripted()) {
    duration_ms = utility::function_4b74c15943231980(duration);
    var_8dd8a39c00110f2b = gettime();
    self._blackboard.var_ba9517cfc0287af8 = var_8dd8a39c00110f2b;

    if(self asmhaspainstate(self.asmname)) {
      self asmevalpaintransition(self.asmname);
    }

    while(true) {
      time_now = gettime();

      if(time_now < var_8dd8a39c00110f2b + duration_ms) {
        self._blackboard.var_ba9517cfc0287af8 = time_now;
      } else {
        break;
      }

      wait 0.1;
    }
  }
}

function private function_f234d7ec3f10b141(params) {
  if(isDefined(params.var_d0449be91ab49769)) {
    if(!self[[params.var_d0449be91ab49769]]()) {
      return false;
    }
  }

  if(ai::is_boss()) {
    return false;
  }

  if(isDefined(params.var_a4b06b7d5862ddea)) {
    return true;
  }

  if(ai::function_9c67144145079cca()) {
    return false;
  }

  return true;
}

function private lc_stun_and_damage_player(var_f191c2408c95ef7, params) {
  self endon("death_or_disconnect");
  self notify("lc_stun_and_damage");
  self endon("lc_stun_and_damage");

  if(!isalive(self)) {
    lc_play_stun_fx(var_f191c2408c95ef7, params);
    return;
  }

  params.tdot = 0;

  if(!self.lc_stunned) {
    lc_do_damage(params);
  }

  self.lc_stunned = 1;
  lc_play_stun_fx(var_f191c2408c95ef7, params);
  shockdata = level function_1ec562064213fee9(params.attacker, params);

  if(utility::callsharedfunc(#"shockstick", #"shockstick_canbehaywire", shockdata, 1)) {
    shockdata thread utility::callsharedfunc(#"shockstick", #"shockstick_applyhaywire", self, shockdata.weapon, 0);
  }

  if(getdvarint(@ "hash_68697a8f385d5617", 1)) {
    thread lc_do_tick_damage_player(params, params.duration);
  }

  wait params.duration;
  self.lc_stunned = undefined;
}

function private lc_stun_and_damage(var_f191c2408c95ef7, params) {
  self endon("death");

  if(self.lc_stunned && !isPlayer(self)) {
    return;
  }

  if(isDefined(params.var_53ad54fe8805dda3)) {
    if(!self[[params.var_53ad54fe8805dda3]]()) {
      return;
    }
  } else if(isagent(self) && !function_f234d7ec3f10b141(params)) {
    lc_do_damage(params);

    if(!isDefined(self.lc_records)) {
      self.lc_records = [];
      return;
    }

    self.lc_records = arraycombineunique(self.lc_records, [params.lc_id]);
    return;
  }

  base_duration = isPlayer(self) ? getdvarint(@ "hash_76b59dd07a5d1f7c", 3) : params.stun_duration ?? 3;
  variation = params.stun_variation ?? 0.5;
  duration = base_duration + randomfloatrange(variation * -1, variation);
  params.duration = duration;

  if(isPlayer(self)) {
    lc_stun_and_damage_player(var_f191c2408c95ef7, params);
    return;
  }

  if(self.type == "zombie" && isDefined(self.aicategory)) {
    if(self.aicategory == "normal") {
      duration = params.var_a4b06b7d5862ddea ?? duration;
    } else if(self.aicategory == "special") {
      duration = params.var_ae23bfd4b4acd418 ?? duration;
    } else if(self.aicategory == "elite" || self.aicategory == "hvt") {
      duration = params.var_bf1f7231596f25bc ?? duration;
    }
  }

  if(params.var_7a514800b212feb9 && self.aicategory == "normal") {
    thread function_63083e0eb079e32d(params, duration);
  }

  var_4d51ccca7bd4ed02 = !params.var_6d86f4ac5ff3667a;

  if(var_4d51ccca7bd4ed02 && self.type) {
    switch (self.type) {
      case #"hash_f695947f7a9ce23f":
        if(utility::issharedfuncdefined(#"effect_stun", #"stun")) {
          utility::callsharedfunc(#"effect_stun", #"stun", params.weapon.basename, duration, params.eattacker, undefined, undefined, "electrical");
        }

        break;
      case #"hash_207629acc9a1e5a":
        thread function_3dcee24de3aa889a(duration);
        break;
    }

    self.lc_stunned = 1;
    self.var_230f79da4bf6cf4a = gettime() + utility::function_4b74c15943231980(duration);
    self notify("zombie_lc_stunned");
    utility::callsharedfunc(#"lightning_chain", #"lc_play_stun_fx", var_f191c2408c95ef7, params);
  }

  if(params.var_516d207140d59c2 > 0) {
    self.lc_stunned_pap = 1;

    if(!utility::function_32b24db3127bff40("shocked_lightning_chain", "shocked_on_paped")) {
      utility::function_32b24db3127bff40("shocked_tesla_storm", "shocked_tesla_storm_on");
    }
  } else {
    self.lc_stunned_pap = 0;

    if(!utility::function_32b24db3127bff40("shocked_lightning_chain", "shocked_on")) {
      utility::function_32b24db3127bff40("shocked_tesla_storm", "shocked_tesla_storm_on");
    }
  }

  self.lc_record = params.lc_id;
  thread lc_do_tick_damage_ai(params, duration);
  wait duration;
  self.lc_stunned = 0;
  self.lc_stunned_pap = 0;

  if(!utility::function_32b24db3127bff40("shocked_lightning_chain", "shocked_off")) {
    utility::function_32b24db3127bff40("shocked_tesla_storm", "shocked_tesla_storm_off");
  }
}

function function_63083e0eb079e32d(params, stun_duration) {
  self endon("death");

  while(stun_duration > 0) {
    wait 0.1;
    closest_player = function_47c86977a18df38b(level.players, self.origin, 48);

    if(isDefined(closest_player)) {
      break;
    }

    stun_duration -= 0.1;
  }

  self kill(self.origin, params.attacker, params.attacker, "MOD_ELEMENTAL_ELEC", params.weapon);
}

function lc_do_damage(params) {
  lc_damage = utility::callsharedfunc(#"lightning_chain", #"lc_damage_calculation", params);
  self.var_6232d6ee94f13e0f = params.var_6232d6ee94f13e0f ?? 0;
  self dodamage(lc_damage, params.arc_origin ?? self.origin, params.attacker, params.attacker, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper");
}

function private lc_damage_calculation(params) {
  if(isPlayer(self)) {
    if(params.tdot) {
      return (params.var_8953d5d1a11c5cfd ?? getdvarint(@ "hash_e951b3efc51435d9", 25));
    }

    return (params.player_damage ?? getdvarint(@ "hash_49d1b75ff4c19854", 75));
  }

  if(utility::issharedfuncdefined(#"lightning_chain", #"hash_d8c9695ff733902")) {
    n_damage = utility::callsharedfunc(#"lightning_chain", #"hash_d8c9695ff733902");

    if(isDefined(n_damage)) {
      return n_damage;
    }
  }

  if(isnumber(params.lc_damage)) {
    return params.lc_damage;
  }

  if(ai::function_9c67144145079cca() && isDefined(params.var_7cae2e380e0347ab)) {
    var_516d207140d59c2 = minint(params.var_516d207140d59c2 ?? 0, params.var_7cae2e380e0347ab.size - 1);
    return params.var_7cae2e380e0347ab[var_516d207140d59c2];
  }

  if(ai::function_9c67144145079cca()) {
    return level.var_cf7706e013c62841[params.var_516d207140d59c2 ?? 0];
  }

  return self.health;
}

function lc_do_tick_damage_player(params, duration) {
  self endon("death_or_disconnect");

  if(!getdvarint(@ "hash_e0e2f2fc98337fb8", 1)) {
    self notify("lc_do_tick_damage");
    self endon("lc_do_tick_damage");
  }

  params.tdot = 1;
  total_ticks = getdvarint(@ "hash_1f72142683105b52", 5);
  tick_time = duration / total_ticks;
  total_damage = 0;
  lc_damage = lc_damage_calculation(params);
  params.tdot = 0;
  var_911ac5c9ec402167 = int(ceil(lc_damage / total_ticks));

  for(tick = 0; tick < total_ticks; tick++) {
    if(tick + 1 == total_ticks) {
      var_911ac5c9ec402167 = lc_damage - total_damage;
    }

    total_damage += var_911ac5c9ec402167;
    self dodamage(var_911ac5c9ec402167, self.origin, params.attacker, params.attacker, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper");
    wait tick_time;
  }
}

function lc_do_tick_damage_ai(params, duration) {
  self endon("death");
  lc_damage = lc_damage_calculation(params);

  if(!isDefined(var_911ac5c9ec402167)) {
    var_911ac5c9ec402167 = params.var_911ac5c9ec402167;
  }

  if(!isnumber(params.var_911ac5c9ec402167)) {
    var_911ac5c9ec402167 = int(ceil(lc_damage / duration * 2));
  }

  self.var_6232d6ee94f13e0f = params.var_6232d6ee94f13e0f ?? 0;
  elementtype = "MOD_ELEMENTAL_ELEC";

  if(isDefined(params.var_93c94c124f42e7c9)) {
    elementtype = params.var_93c94c124f42e7c9;
  }

  inflictor = params.var_cf3d764fcbd3988 ? params.inflictor : params.attacker;
  var_80eff23f65611a6a = 0;

  while(var_80eff23f65611a6a < duration) {
    self dodamage(var_911ac5c9ec402167, self.origin, params.attacker, inflictor, elementtype, params.weapon, "torso_upper", undefined, 134217728);
    wait 0.5;
    var_80eff23f65611a6a += 0.5;
  }
}

function private lc_play_stun_fx(var_f191c2408c95ef7, params) {
  if(params.var_516d207140d59c2 > 0) {
    paped = 1;
  } else {
    paped = 0;
  }

  tag = "J_SpineUpper";

  if(paped) {
    shock_fx = "tesla_shock_pap";
  } else {
    shock_fx = "tesla_shock";
  }

  if(isPlayer(self)) {
    if(paped) {
      ground_fx = "tesla_shock_ground_pap";
    } else {
      ground_fx = "tesla_shock_ground";
    }

    playFXOnTag(level._effect[ground_fx], self, "tag_origin");

    if(isDefined(shock_fx) && utility::hastag(self.model, tag)) {
      playFXOnTag(level._effect[shock_fx], self, tag);
    }

    return;
  }

  if(var_f191c2408c95ef7) {
    if(paped) {
      ground_fx = "tesla_shock_ground_pap";
    } else {
      ground_fx = "tesla_shock_ground";
    }

    ground_fx_id = level._effect[ground_fx];

    if(isDefined(params.var_4ba65bb5d9255011)) {
      ground_fx_id = params.var_4ba65bb5d9255011;
    }

    playFXOnTag(ground_fx_id, self, "tag_origin");
  } else {
    shock_fx = undefined;
  }

  if(isDefined(shock_fx) && utility::hastag(self.model, tag)) {
    shock_fx_id = level._effect[shock_fx];

    if(isDefined(params.var_9610c85754f48f86)) {
      shock_fx_id = params.var_9610c85754f48f86;
    }

    playFXOnTag(shock_fx_id, self, tag);
  }

  if(params.should_gib_head && isDefined(self.aicategory) && self.aicategory == "normal" && !self.head_gibbed) {
    if(randomint(100) < params.head_gib_chance) {
      self.var_6a6a43836cde0417 = 1;
      return;
    }

    if(self tagexists("J_EyeBall_LE")) {
      if(paped) {
        eye_fx = "tesla_shock_eyes_pap";
        mouth_fx = "tesla_shock_mouth_pap";
      } else {
        eye_fx = "tesla_shock_eyes";
        mouth_fx = "tesla_shock_mouth";
      }

      eye_fx_id = level._effect[eye_fx];

      if(isDefined(params.var_3ec5f4dcb4be2127)) {
        eye_fx_id = params.var_3ec5f4dcb4be2127;
      }

      mouth_fx_id = level._effect[mouth_fx];

      if(isDefined(params.var_25163072dbc16af5)) {
        mouth_fx_id = params.var_25163072dbc16af5;
      }

      playFXOnTag(eye_fx_id, self, "J_EyeBall_RI");
      playFXOnTag(eye_fx_id, self, "J_EyeBall_LE");
      playFXOnTag(mouth_fx_id, self, "J_Head");
    }
  }
}

function private function_a68037a538d49c18(params) {
  if(params.idamage >= self.health && self.lc_stunned) {
    self.health = int(params.idamage) + 2;

    if(!self.var_a9c101367b31e643) {
      thread lc_wait_till_stun_end();
    }
  }
}

function private on_player_laststand(params) {
  if(self.lc_stunned) {
    self.lc_stunned = undefined;
  }
}

function private on_player_death(params) {
  if(self.lc_stunned) {
    self.lc_stunned = undefined;
  }
}

function private lc_wait_till_stun_end() {
  self notify("lc_wait_till_stun_end");
  self endon("lc_wait_till_stun_end");
  self endon("death");
  self.var_a9c101367b31e643 = 1;

  while(self.lc_stunned) {
    current_time = gettime();

    if(self.var_6a6a43836cde0417 && !self.head_gibbed && isDefined(self.var_230f79da4bf6cf4a) && self.var_230f79da4bf6cf4a - current_time <= 500) {
      self.var_6a6a43836cde0417 = 0;

      if(utility::issharedfuncdefined(#"zombie_dismemberment", #"dismemberhead")) {
        utility::callsharedfunc(#"zombie_dismemberment", #"dismemberhead", 1);
      }
    }

    waitframe();
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  var_d85c6b92e2f088f0 = isDefined(self.last_dmg_struct) ? self.last_dmg_struct.eattacker : undefined;
  var_284de4bde8a5141b = isDefined(self.last_dmg_struct) ? self.last_dmg_struct.objweapon : undefined;
  self kill(self.origin, var_d85c6b92e2f088f0, undefined, undefined, var_284de4bde8a5141b);
  self.var_a9c101367b31e643 = 0;
}

function private function_1ec562064213fee9(attacker, params) {
  shockdata = spawnStruct();
  shockdata.tableinfo = equipment::getequipmenttableinfo("equip_shockstick");
  shockdata.owner = attacker;
  shockdata.team = attacker.team ?? params.team;
  shockdata.origin = attacker.origin ?? params.attacker_origin;
  shockdata.weapon = params.weapon ?? shockdata.tableinfo.objweapon;
  shockdata.tableinfo.var_f3447a3874df563f = 0;
  shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
  shockdata.tableinfo.var_c6920ebeb7833310 = 1;
  shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
  shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
  shockdata.tableinfo.bundle.var_860545b754d7ecc0 = params.duration ?? 5;
  shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = params.duration ?? 5;
  shockdata.tableinfo.bundle.var_2b2a3fde48397a39 = 0.2;
  shockdata.tableinfo.bundle.var_bd94b71ffdfd39c = getdvarint(@ "hash_63e354fa4bd6021c", 0);
  shockdata.tableinfo.bundle.var_4c6cc0f99efbb64f = 1;
  return shockdata;
}