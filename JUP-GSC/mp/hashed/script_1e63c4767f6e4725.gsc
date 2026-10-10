/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1e63c4767f6e4725.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\weapons\lightning_chain;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\shock_stick;
#namespace namespace_37751a84674f6b5c;

function private autoexec __init__system__() {
  system::register(#"hash_92765c54d894608", #"lightning_chain", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("lightning_chain", "init", &init);
}

function private init() {
  utility::registersharedfunc("lightning_chain", "lc_expand", &lc_expand);
  utility::registersharedfunc("lightning_chain", "lc_stun_and_damage", &lc_stun_and_damage);
  utility::registersharedfunc("lightning_chain", "lc_damage_calculation", &lc_damage_calculation);
  utility::registersharedfunc("lightning_chain", "lc_play_stun_fx", &lc_play_stun_fx);
  level callback::add("player_laststand", &on_player_laststand);
  level callback::add("player_death", &on_player_death);
}

function private on_player_laststand(params) {
  if(istrue(self.lc_stunned)) {
    self.lc_stunned = 0;
  }
}

function private on_player_death(params) {
  if(istrue(self.lc_stunned)) {
    self.lc_stunned = 0;
  }
}

function private lc_expand(start_point, count_left, params) {
  var_ec235e528a1b6682 = int(min(params.var_232825c32e606ba4, count_left));
  filtered_targets = [];
  targets = function_143526130b12b2b6(start_point, params.arc_radius);
  targets = utility::array_exclude(targets, namespace_2b1145f62aa835b8::function_9563f2d4e690856d(params.player.team, "players"));

  foreach(target in targets) {
    if(target lightning_chain::function_9754219dda9b7840(params)) {
      continue;
    }

    if(!trace::ray_trace_passed(start_point, target getEye(), targets)) {
      continue;
    }

    filtered_targets = array_add(filtered_targets, target);
  }

  var_ec235e528a1b6682 = int(min(filtered_targets.size, var_ec235e528a1b6682));

  if(var_ec235e528a1b6682 == 0) {
    return 0;
  }

  filtered_targets = sortbydistance(filtered_targets, start_point);

  for(i = 0; i < var_ec235e528a1b6682; i++) {
    level thread lightning_chain::function_ba46a0d1e783a686(start_point, filtered_targets[i], params);
  }

  while(i > 0 && filtered_targets[i - 1] ai::function_f6347c9c410226d3()) {
    i--;
  }

  if(i == 0) {
    return;
  }

  var_224aee65a62dda42 = lightning_chain::function_ae21b7c8d9bf419c(filtered_targets[i - 1]);
  count_left -= var_ec235e528a1b6682;

  if(count_left > 0) {
    level thread lightning_chain::function_36230b878a401091(params.arc_travel_time + 0.1, var_224aee65a62dda42, count_left, params);
  }
}

function private lc_stun_and_damage(var_6344ee17398456ea, params) {
  self endon("death");

  if(istrue(self.lc_stunned) && !isPlayer(self)) {
    return;
  }

  if(isDefined(params.var_795cf764ad7734f4)) {
    if(!self[[params.var_795cf764ad7734f4]]()) {
      return;
    }
  } else if(isagent(self) && ai::function_f6347c9c410226d3()) {
    lightning_chain::lc_do_damage(params);

    if(!isDefined(self.lc_records)) {
      self.lc_records = [];
      return;
    }

    self.lc_records = function_6d6af8144a5131f1(self.lc_records, params.lc_id);
    return;
  }

  base_duration = isPlayer(self) ? getdvarint(@ "hash_ff72a8d53ec4b833", 3) : default_to(params.stun_duration, 3);
  duration = base_duration + (randomint(10) - 5) * 0.1;
  params.duration = duration;

  if(isPlayer(self)) {
    function_bc946a0508ac8d93(var_6344ee17398456ea, params);
    return;
  }

  switch (self.type) {
    case #"hash_f695947f7a9ce23f":
      if(utility::issharedfuncdefined("zombie", "stunZombie")) {
        utility::function_f3bb4f4911a1beb2("zombie", "stunZombie", duration);
      }

      break;
    case #"hash_207629acc9a1e5a":
      thread lightning_chain::function_ca73f0d9e9cea887(duration);
      break;
  }

  self.lc_stunned = 1;
  self.var_7cf353523b4c1663 = gettime() + function_a5b14435e3229bed(duration);
  self notify("zombie_lc_stunned");
  lc_play_stun_fx(var_6344ee17398456ea, params);

  if(isDefined(params.var_cc8643dde5979643) && params.var_cc8643dde5979643 > 0) {
    utility::function_3ab9164ef76940fd("shocked_lightning_chain", "shocked_on_paped");
  } else {
    utility::function_3ab9164ef76940fd("shocked_lightning_chain", "shocked_on");
  }

  wait duration;
  self.lc_stunned = 0;
  utility::function_3ab9164ef76940fd("shocked_lightning_chain", "shocked_off");
  lightning_chain::lc_do_damage(params);
}

function private function_bc946a0508ac8d93(var_6344ee17398456ea, params) {
  self endon("death_or_disconnect");
  self notify("lc_stun_and_damage");
  self endon("lc_stun_and_damage");

  if(!isalive(self)) {
    lc_play_stun_fx(var_6344ee17398456ea, params);
    return;
  }

  params.var_8de885f6fab113ba = 0;

  if(!istrue(self.lc_stunned)) {
    lightning_chain::lc_do_damage(params);
  }

  self.lc_stunned = 1;
  lc_play_stun_fx(var_6344ee17398456ea, params);

  if(getdvarint(@ "hash_e46e93c9eb4606db", 1) && params.smeansofdeath == "MOD_PROJECTILE" && params.victim == self) {
    shockdata = params.player function_8d61b29d5f678432(params);

    if(istrue(shock_stick::shockstick_canbehaywire(shockdata, 1))) {
      shockdata thread shock_stick::shockstick_applyhaywire(self, shockdata.weapon, 0);
    }
  }

  if(getdvarint(@ "hash_d27b250aeaf3d2a0", 1)) {
    thread lc_do_tick_damage(params, params.duration);
  }

  wait params.duration;
  self.lc_stunned = 0;
}

function private lc_damage_calculation(params) {
  if(isPlayer(self)) {
    if(params.var_8de885f6fab113ba) {
      return getdvarint(@ "hash_cb529ff640bba618", 25);
    }

    return getdvarint(@ "hash_85fd7070115ffa8f", 75);
  }

  if(ai::function_f6347c9c410226d3()) {
    return level.var_b0d02607ac2c9ec[default_to(params.var_cc8643dde5979643, 0)];
  }

  return self.health + 666;
}

function private lc_do_tick_damage(params, duration) {
  self endon("death_or_disconnect");

  if(!getdvarint(@ "hash_5829f58ced5a4871", 1)) {
    self notify("lc_do_tick_damage");
    self endon("lc_do_tick_damage");
  }

  params.var_8de885f6fab113ba = 1;
  total_ticks = getdvarint(@ "hash_59086b940de532cd", 5);
  tick_time = duration / total_ticks;
  total_damage = 0;
  lc_damage = lc_damage_calculation(params);
  params.var_8de885f6fab113ba = 0;
  var_885efccb799e30cc = int(ceil(lc_damage / total_ticks));

  for(tick = 0; tick < total_ticks; tick++) {
    if(tick + 1 == total_ticks) {
      var_885efccb799e30cc = lc_damage - total_damage;
    }

    total_damage += var_885efccb799e30cc;
    self dodamage(var_885efccb799e30cc, self.origin, params.player, params.player, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper");
    wait tick_time;
  }
}

function private lc_play_stun_fx(var_6344ee17398456ea, params) {
  if(isDefined(params.var_cc8643dde5979643) && params.var_cc8643dde5979643 > 0) {
    paped = 1;
  } else {
    paped = 0;
  }

  tag = "J_SpineUpper";

  if(paped) {
    fx = "tesla_shock_pap";
  } else {
    fx = "tesla_shock";
  }

  if(isPlayer(self)) {
    if(paped) {
      ground_fx = "tesla_shock_ground_pap";
    } else {
      ground_fx = "tesla_shock_ground";
    }

    playFXOnTag(level._effect[ground_fx], self, "tag_origin");

    if(isDefined(fx) && hastag(self.model, tag)) {
      playFXOnTag(level._effect[fx], self, tag);
    }

    return;
  }

  if(istrue(var_6344ee17398456ea)) {
    if(paped) {
      ground_fx = "tesla_shock_ground_pap";
    } else {
      ground_fx = "tesla_shock_ground";
    }

    playFXOnTag(level._effect[ground_fx], self, "tag_origin");
  } else {
    fx = undefined;
  }

  if(isDefined(fx) && hastag(self.model, tag)) {
    playFXOnTag(level._effect[fx], self, tag);
  }

  if(istrue(params.should_gib_head) && isDefined(self.aicategory) && self.aicategory == "normal" && !istrue(self.head_gibbed)) {
    if(randomint(100) < params.head_gib_chance) {
      self.var_6315c8282142db0a = 1;
      return;
    }

    if(self tagexists("J_Eyeball_LE")) {
      if(paped) {
        eye_fx = "tesla_shock_eyes_pap";
      } else {
        eye_fx = "tesla_shock_eyes";
      }

      playFXOnTag(level._effect[eye_fx], self, "J_Eyeball_LE");
    }
  }
}

function private function_8d61b29d5f678432(params) {
  shockdata = spawnStruct();
  shockdata.tableinfo = equipment::getequipmenttableinfo("equip_shockstick");
  shockdata.owner = self;
  shockdata.team = self.team;
  shockdata.origin = self.origin;
  shockdata.weapon = isDefined(params.weapon) ? params.weapon : shockdata.tableinfo.objweapon;
  shockdata.tableinfo.var_b79e08e886b92d46 = 0;
  shockdata.tableinfo.var_5dd66ebda239d1b = 1;
  shockdata.tableinfo.bundle.var_33bce1558051ceb5 = 0.3;
  shockdata.tableinfo.bundle.var_7c742af3d434b807 = isDefined(params.duration) ? params.duration : 5;
  shockdata.tableinfo.bundle.var_95602b4d7262c11f = isDefined(params.duration) ? params.duration : 5;
  shockdata.tableinfo.bundle.var_aba76142349af9c0 = 0.2;
  shockdata.tableinfo.bundle.var_d5798377c05f4edf = getdvarint(@ "hash_84b01b09dcb60a3f", 0);
  shockdata.tableinfo.bundle.var_e926abd3e5970492 = 1;
  return shockdata;
}