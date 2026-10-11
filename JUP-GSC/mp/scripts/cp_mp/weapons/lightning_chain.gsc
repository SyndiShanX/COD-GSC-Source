/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\weapons\lightning_chain.gsc
********************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace lightning_chain;

function private autoexec __init__system__() {
  system::register(#"lightning_chain", undefined, undefined, &post_main);
}

function private post_main() {
  common_init();
  utility::callsharedfunc("lightning_chain", "init");
}

function private common_init() {
  level._effect["tesla_bolt"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_elec_bolt_01.vfx");
  level._effect["tesla_shock"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_shock_zmb.vfx");
  level._effect["tesla_shock_nonfatal"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_elec_bolt_01.vfx");
  level._effect["tesla_shock_eyes"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_shock_eyes_zmb.vfx");
  level._effect["tesla_shock_ground"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_shock_ground.vfx");
  level._effect["tesla_bolt_pap"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_elec_bolt_ug_01.vfx");
  level._effect["tesla_shock_pap"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_shock_ug_zmb.vfx");
  level._effect["tesla_shock_nonfatal_pap"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_elec_bolt_ug_01.vfx");
  level._effect["tesla_shock_eyes_pap"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_shock_eyes_ug_zmb.vfx");
  level._effect["tesla_shock_ground_pap"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_tesla_shock_ug_ground.vfx");
  level callback::add("on_zombie_ai_damaged", &function_510d27a7b8d2bbcd);
  level callback::add("on_soldier_ai_damaged", &function_510d27a7b8d2bbcd);
  level.var_b0d02607ac2c9ec = [];
  level.var_b0d02607ac2c9ec[0] = 5000;
  level.var_b0d02607ac2c9ec[1] = 10000;
  level.var_b0d02607ac2c9ec[2] = 20000;
  level.var_b0d02607ac2c9ec[3] = 40000;
  utility::registersharedfunc("lightning_chain", "lc_expand", &lc_expand);
  utility::registersharedfunc("lightning_chain", "lc_stun_and_damage", &lc_stun_and_damage);
  utility::registersharedfunc("lightning_chain", "lc_damage_calculation", &lc_damage_calculation);
  utility::registersharedfunc("lightning_chain", "lc_play_stun_fx", &lc_play_stun_fx);
}

function create_lightning_chain_params(max_enemies_killed, radius, head_gib_chance, arc_travel_time, var_232825c32e606ba4) {
  lcp = spawnStruct();
  lcp.max_enemies_killed = max_enemies_killed;
  lcp.arc_radius = radius;
  lcp.head_gib_chance = head_gib_chance;
  lcp.arc_travel_time = arc_travel_time;
  lcp.var_232825c32e606ba4 = var_232825c32e606ba4;
  return lcp;
}

function arc_damage(source_enemy, player, params) {
  if(!isDefined(params)) {
    return;
  }

  thread utility::callsharedfunc("lightning_chain", "lc_stun_and_damage", 1, params);

  if(ai::function_f6347c9c410226d3()) {
    return;
  }

  var_e47555a8dc3f59cb = level function_ae21b7c8d9bf419c(source_enemy);
  level utility::callsharedfunc("lightning_chain", "lc_expand", var_e47555a8dc3f59cb, params.max_enemies_killed - 1, params);
}

function function_9754219dda9b7840(params) {
  if(istrue(self.lc_stunned) || is_equal(self.team, params.player.team) || isDefined(self.lc_records) && array_contains(self.lc_records, params.lc_id)) {
    return true;
  }

  return false;
}

function private lc_expand(start_point, count_left, params) {
  var_ec235e528a1b6682 = int(min(params.var_232825c32e606ba4, count_left));
  ai_targets = getaiarrayinradius(start_point, params.arc_radius);
  var_4e83f2f535a21158 = [];

  foreach(ai in ai_targets) {
    if(istrue(ai function_9754219dda9b7840(params))) {
      continue;
    }

    var_4e83f2f535a21158 = array_add(var_4e83f2f535a21158, ai);
  }

  var_ec235e528a1b6682 = int(min(var_4e83f2f535a21158.size, var_ec235e528a1b6682));

  if(var_ec235e528a1b6682 == 0) {
    return 0;
  }

  var_4e83f2f535a21158 = sortbydistance(var_4e83f2f535a21158, start_point);

  for(i = 0; i < var_ec235e528a1b6682; i++) {
    level thread function_ba46a0d1e783a686(start_point, var_4e83f2f535a21158[i], params);
  }

  while(i > 0 && var_4e83f2f535a21158[i - 1] ai::function_f6347c9c410226d3()) {
    i--;
  }

  if(i == 0) {
    return;
  }

  var_224aee65a62dda42 = function_ae21b7c8d9bf419c(var_4e83f2f535a21158[i - 1]);
  count_left -= var_ec235e528a1b6682;

  if(count_left > 0) {
    level thread function_36230b878a401091(params.arc_travel_time + 0.1, var_224aee65a62dda42, count_left, params);
  }
}

function function_36230b878a401091(waittime, start_point, count_left, params) {
  wait waittime;
  level utility::callsharedfunc("lightning_chain", "lc_expand", start_point, count_left, params);
}

function function_ae21b7c8d9bf419c(ai_target) {
  end_point = ai_target gettagorigin("J_SpineUpper", 1);

  if(!isDefined(end_point)) {
    end_point = ai_target.origin;
  }

  return end_point;
}

function function_ba46a0d1e783a686(start_point, ai_target, params) {
  end_point = function_ae21b7c8d9bf419c(ai_target);

  if(!isDefined(end_point)) {
    return;
  }

  var_d1624c8004bcaa3b = spawn_tag_origin(start_point);
  var_d1624c8004bcaa3b show();

  if(isDefined(params.var_cc8643dde5979643) && params.var_cc8643dde5979643 > 0) {
    bolt_fx = "tesla_bolt_pap";
  } else {
    bolt_fx = "tesla_bolt";
  }

  fx = playFXOnTag(level._effect[bolt_fx], var_d1624c8004bcaa3b, "tag_origin");
  var_d1624c8004bcaa3b moveTo(end_point, params.arc_travel_time);
  var_d1624c8004bcaa3b waittill("movedone");
  var_d1624c8004bcaa3b delete();

  if(isalive(ai_target)) {
    ai_target thread utility::callsharedfunc("lightning_chain", "lc_stun_and_damage", 0, params);
  }
}

function function_ca73f0d9e9cea887(duration) {
  level endon("game_ended");
  self endon("death");

  if(self.health > 0 && !scripts\asm\asm_bb::bb_isanimScripted()) {
    duration_ms = function_a5b14435e3229bed(duration);
    var_dce8146da743e9fa = gettime();
    self._blackboard.var_dc51d4ea36da3ae1 = var_dce8146da743e9fa;

    if(self asmhaspainstate(self.asmname)) {
      self asmevalpaintransition(self.asmname);
    }

    while(true) {
      time_now = gettime();

      if(time_now < var_dce8146da743e9fa + duration_ms) {
        self._blackboard.var_dc51d4ea36da3ae1 = time_now;
      } else {
        break;
      }

      wait 0.1;
    }
  }
}

function private lc_stun_and_damage(pin_to_ground, params) {
  self endon("death");

  if(istrue(self.lc_stunned)) {
    return;
  }

  if(isDefined(params.var_795cf764ad7734f4)) {
    if(!self[[params.var_795cf764ad7734f4]]()) {
      return;
    }
  } else if(isDefined(self.var_795cf764ad7734f4)) {
    if(!self[[self.var_795cf764ad7734f4]](pin_to_ground, params)) {
      return;
    }
  }

  if(ai::function_f6347c9c410226d3()) {
    lc_do_damage(params);

    if(!isDefined(self.lc_records)) {
      self.lc_records = [];
      return;
    }

    self.lc_records = function_6d6af8144a5131f1(self.lc_records, params.lc_id);
    return;
  }

  duration = default_to(params.stun_duration, 3) + (randomint(10) - 5) * 0.1;

  switch (self.type) {
    case #"hash_f695947f7a9ce23f":
      if(utility::issharedfuncdefined("zombie", "stunZombie")) {
        utility::callsharedfunc("zombie", "stunZombie", duration);
      }

      break;
    case #"hash_207629acc9a1e5a":
      thread function_ca73f0d9e9cea887(duration + 1);
      break;
  }

  self.lc_stunned = 1;
  self.var_7cf353523b4c1663 = gettime() + function_a5b14435e3229bed(duration);
  self notify("zombie_lc_stunned");
  utility::callsharedfunc("lightning_chain", "lc_play_stun_fx", pin_to_ground, params);

  if(isDefined(params.var_cc8643dde5979643) && params.var_cc8643dde5979643 > 0) {
    self.var_29a419c3cdeccf06 = 1;
    utility::function_3ab9164ef76940fd("shocked_lightning_chain", "shocked_on_paped");
  } else {
    self.var_29a419c3cdeccf06 = 0;
    utility::function_3ab9164ef76940fd("shocked_lightning_chain", "shocked_on");
  }

  thread lc_do_tick_damage(params, duration);
  wait duration;
  self.lc_stunned = 0;
  self.var_29a419c3cdeccf06 = 0;
  utility::function_3ab9164ef76940fd("shocked_lightning_chain", "shocked_off");
}

function lc_do_damage(params) {
  lc_damage = utility::callsharedfunc("lightning_chain", "lc_damage_calculation", params);
  self dodamage(lc_damage, self.origin, params.player, params.player, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper");
}

function private lc_damage_calculation(params) {
  if(ai::function_f6347c9c410226d3()) {
    return level.var_b0d02607ac2c9ec[default_to(params.var_cc8643dde5979643, 0)];
  }

  return self.health + 100;
}

function private lc_do_tick_damage(params, duration) {
  self endon("death");
  lc_damage = lc_damage_calculation(params);
  var_885efccb799e30cc = int(ceil(lc_damage / duration * 2));
  var_585785874daa275b = 0;

  while(var_585785874daa275b < duration + 1) {
    self dodamage(var_885efccb799e30cc, self.origin, params.player, params.player, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper");
    wait 0.5;
    var_585785874daa275b += 0.1;
  }
}

function private lc_play_stun_fx(pin_to_ground, params) {
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

  if(istrue(pin_to_ground)) {
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

function private function_510d27a7b8d2bbcd(params) {
  if(params.idamage >= self.health && istrue(self.lc_stunned)) {
    self.health = int(params.idamage) + 2;

    if(!istrue(self.var_6cc1f9da4c747de)) {
      thread lc_wait_till_stun_end();
    }
  }
}

function private lc_wait_till_stun_end() {
  self notify("lc_wait_till_stun_end");
  self endon("lc_wait_till_stun_end");
  self endon("death");
  self.var_6cc1f9da4c747de = 1;

  while(istrue(self.lc_stunned)) {
    current_time = gettime();

    if(istrue(self.var_6315c8282142db0a) && !istrue(self.head_gibbed) && isDefined(self.var_7cf353523b4c1663) && self.var_7cf353523b4c1663 - current_time <= 500) {
      self.var_6315c8282142db0a = 0;

      if(utility::issharedfuncdefined("zombie_dismemberment", "dismemberHead")) {
        utility::callsharedfunc("zombie_dismemberment", "dismemberHead", 1);
      }
    }

    waitframe();
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  self.var_6cc1f9da4c747de = 0;
}