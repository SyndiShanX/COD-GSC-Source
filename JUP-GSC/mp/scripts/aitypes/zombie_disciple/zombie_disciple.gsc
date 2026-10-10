/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\zombie_disciple\zombie_disciple.gsc
******************************************************************/

#using script_3badb8914eb5ac16;
#using script_3e4f26df9dc4b465;
#using script_4d5690421d14cda9;
#using script_4fa22bc28608e9bd;
#using script_5a4a5d9ba343ff8f;
#using script_7edf952f8921aa6b;
#using script_ac32c5a74321662;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace zombie_disciple;

function precache(params) {
  settings = function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    add_fx("disciple_weakpoint_impact_fx", settings.var_5704bf989f7424ad);
  }

  function_fcbab070c240a397(params);
  function_352431dd86cd1c9f(params);
}

function private function_2f9902a8f2d094cc(params) {
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("killed_body_cloned", &function_c8c10b313b3fcf09);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_zombie_ai_damaged", &function_1672ec8a6f79b175);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_turned", &function_db27f76319d7eb19);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("shocked", &function_c8bbb80c04cd9a37);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("shocked_end", &function_deadba29b36b687d);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("burned", &function_bf0fe7b30fa14180);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("burned_end", &function_788a3fa28ef17f52);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("napalm_burned", &function_dbb5710ec418627e);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("napalm_burned_end", &function_afa5ec2deb3f62a0);

  function_97ab41be3f4a3f32();
}

function function_f4d5b246417ef16a(taskid) {
  assert(isDefined(self.zombieaisetting));
  function_7415ae9399ba8e75(self.zombieaisetting);
  assert(isDefined(self.zombieaisettings.var_e58a65b7a8f5973c));
  callback::add("on_first_ai_init", &function_2f9902a8f2d094cc);
  self.var_256e6f5113f1d484 = self.zombieaisettings.var_e58a65b7a8f5973c.healthstatemodels;
  self.sweep_speed = self.zombieaisettings.var_e58a65b7a8f5973c.sweepmovespeed;
  self.var_1e81a7753e0e50ba = squared(self.zombieaisettings.var_e58a65b7a8f5973c.var_1a818e0dcbfc15b2);
  self.var_9206541eb172ead2 = self.zombieaisettings.var_e58a65b7a8f5973c.var_f561f27619209f1c;
  self.var_181a00542ff4ff22 = self.zombieaisettings.var_e58a65b7a8f5973c.sweepcooldown * 1000;
  self.var_6be4867f8098164b = 0;
  assert(isDefined(self.var_256e6f5113f1d484) && self.var_256e6f5113f1d484.size, "<dev string:x1c>");
  self.health_state = 1;
  self.var_509fbc675b903534 = 10;
  self.var_30158902d2e2c3c0 = 100;
  self.allowstrafe = 0;
  self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  self.var_f8a44d7cde24460a = self.zombieaisettings.var_e58a65b7a8f5973c.disablebrainrot;
  function_2f1a5353c6e77e2a(0, &function_4d42c08e173ff9f2, &function_62bd63499815a3b5, undefined);
  function_2f1a5353c6e77e2a(1, &function_8f1d453ee684e38d, &function_4b6d93f3fa22a0b4, &function_14295ed2252547c5);
  function_2f1a5353c6e77e2a(2, &function_54a404c38a1369b7, &function_f77e2c4073f34d22, &function_6a23d453456a7033);
  function_2f1a5353c6e77e2a(3, &function_ed7af34e8711e3b9, &function_e1a0b3dd3d79acd8, &function_8dbd5a377a20ba99);
  function_2f1a5353c6e77e2a(4, &function_e354f660d897ba2e, &function_8f258de4aad8d969, &function_734d6307f1040338);
  function_2f1a5353c6e77e2a(5, &function_765311e9d977d0a4, &function_ee0dbf14cac0394b, &function_bdb7cfc201ba226a);
  thread spawn_fade_in();
  thread initscriptable();
  return anim.success;
}

function private initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  waitframe();
  utility::function_3ab9164ef76940fd("base", "base_on");
  utility::function_3ab9164ef76940fd("head", "normal");
  function_ec17b7a24551187a();
}

function private spawn_fade_in() {
  self endon("death");
  self function_3e89eb3d8e3f1811("spawning", 1);
  val::set("spawn_fade_in", "damage", 0);
  wait 1.5;
  self function_3e89eb3d8e3f1811("spawning", 0);
  val::reset_all("spawn_fade_in");
  thread function_733117069a008b43(0);
}

function private function_c8c10b313b3fcf09(params) {
  body = function_d8853db47f5b98e4(params);

  if(isDefined(body)) {
    body utility::function_3ab9164ef76940fd("death_reveal", "death_reveal");
    body.origin = self.origin;
    wait 2.5;
    body = function_d8853db47f5b98e4(params);

    if(isDefined(body)) {
      body delete();
    }
  }
}

function private function_c8bbb80c04cd9a37(var_a21093610d4de2ed) {
  utility::function_3ab9164ef76940fd("shocked", "shocked_on");
}

function private function_deadba29b36b687d(var_a21093610d4de2ed) {
  utility::function_3677f2be30fdd581("shocked", "shocked_off");
}

function private function_bf0fe7b30fa14180(var_12c084a213d7ad2) {
  utility::function_3ab9164ef76940fd("burned", "burned_on");
}

function private function_788a3fa28ef17f52(var_12c084a213d7ad2) {
  utility::function_3677f2be30fdd581("burned", "burned_off");
}

function private function_dbb5710ec418627e(var_12c084a213d7ad2) {
  utility::function_3ab9164ef76940fd("napalm_burned", "napalm_burned_on");
}

function private function_afa5ec2deb3f62a0(var_12c084a213d7ad2) {
  utility::function_3677f2be30fdd581("napalm_burned", "napalm_burned_off");
}

function private function_db27f76319d7eb19(params) {
  utility::function_3ab9164ef76940fd("brainrot", "brainrot_on");
  function_ec17b7a24551187a();

  if(utility::function_35c178c80fa19cbd("head", "destroyed")) {
    utility::function_3677f2be30fdd581("head", "destroyed_turned");
  }

  self.var_dec41e66d2f7fffd = undefined;
  self.var_a4c14dc60d4dd398 = 1;
  self._blackboard.var_8d19c6ba087e7a86 = 1;
}

function private function_1672ec8a6f79b175(params) {
  self.var_3dfea6800a231b9f = gettime();

  if(isDefined(params.metabonename) && params.metabonename == "head") {
    playFXOnTag(getfx("disciple_weakpoint_impact_fx"), self, "tag_fx_head_weakspot");
  }

  if(!self._blackboard.var_8d19c6ba087e7a86 && function_ae3b1c8fcd5a82b0(self.health - params.idamage)) {
    if(!istrue(self.var_8eea1c7b28ac77b5)) {
      self function_3e89eb3d8e3f1811("in_health_state_pain", 1);
    }
  }
}

function function_a8c9248308033e4e() {
  if(istrue(self.var_f8a44d7cde24460a)) {
    return false;
  }

  return true;
}

function function_936ae5897003191c(taskid, params) {
  if(self._blackboard.var_4c29bf66496f352f != 1 && self._blackboard.var_4c29bf66496f352f != 3) {
    return 0;
  }

  if(istrue(self.var_e3093b57b14938a1)) {
    return 0;
  }

  return function_b377e44b6f4f14d9();
}

function function_dea7107232630efc(taskid, params) {
  return self._blackboard.var_4c29bf66496f352f == 3 && function_a6f183528ab5941();
}

function function_2fde990d57867cd() {
  target_ent = self.enemy;

  if(istrue(self.var_4a574e473630f0eb)) {
    nearby_ai = [];

    if(!istrue(self.var_c124ffbc8c1883e7)) {
      nearby_ai = getaiarrayinradius(self.origin, self.var_19ae2683f843e4f7, self.team);
    } else {
      nearby_ai = getaiarrayinradius(self.origin, self.var_19ae2683f843e4f7, "team_two_hundred");
    }

    var_4afe22ba200fcd1b = undefined;

    if(nearby_ai.size > 0) {
      foreach(zombie in nearby_ai) {
        if(isDefined(zombie.aicategory) && (zombie.aicategory == "special" || zombie.aicategory == "elite" || zombie.aicategory == "boss")) {
          continue;
        }

        if(isDefined(zombie.var_a61fd8396edeb3b9) && zombie.var_a61fd8396edeb3b9 < gettime()) {
          continue;
        }

        var_4afe22ba200fcd1b = zombie;
        break;
      }
    }

    if(isDefined(var_4afe22ba200fcd1b)) {
      var_8ad5784039525c45 = distancesquared(target_ent.origin, self.origin);
      var_66d389021bdc776d = distancesquared(var_4afe22ba200fcd1b.origin, self.origin);

      if(var_66d389021bdc776d < var_8ad5784039525c45) {
        target_ent = var_4afe22ba200fcd1b;
      }
    }
  }

  return target_ent;
}

function function_54c3f7436436a38d(taskid, params) {
  target_ent = function_2fde990d57867cd();

  if(ent_flag("playing_life_drain_anim")) {
    return false;
  }

  if(istrue(self.var_e3093b57b14938a1) && function_a6f183528ab5941()) {
    return false;
  }

  if(istrue(self.var_7415a936b72426f1) && istrue(self.var_ef4b3691a1f11505) && istrue(self.var_90217cf570d78169)) {
    return false;
  }

  if(!isalive(target_ent) || istrue(target_ent.var_bc3dcc1a5359b3e5)) {
    return false;
  }

  if(!ray_trace_passed(self getcentroid(), self.enemy getcentroid(), undefined, create_default_contents(1))) {
    return false;
  }

  if(isDefined(target_ent.var_a61fd8396edeb3b9) && target_ent.var_a61fd8396edeb3b9 > gettime()) {
    return false;
  }

  target_ent.var_a61fd8396edeb3b9 = gettime() + 3000;
  self.var_f3d93eb65ff33b13 = target_ent;
  return true;
}

function function_1499a812ecd5f3b6(entity) {
  return (entity.var_256e6f5113f1d484.size + 1 - entity.health_state) / entity.var_256e6f5113f1d484.size;
}

function function_dac2879b7074b060(n_health) {
  n_health = default_to(n_health, self.health);
  n_health = max(n_health, 1);
  return int(self.var_256e6f5113f1d484.size + 1 - ceil(n_health * self.var_256e6f5113f1d484.size / self.maxhealth));
}

function function_ae3b1c8fcd5a82b0(new_health) {
  var_25d777ca1380c3c2 = function_dac2879b7074b060(new_health);

  if(self.health_state != var_25d777ca1380c3c2) {
    self setModel(self.var_256e6f5113f1d484[var_25d777ca1380c3c2 - 1].modelname);
    self.health_state = var_25d777ca1380c3c2;
    function_ec17b7a24551187a();
    return true;
  }

  return false;
}

function function_ec17b7a24551187a() {
  utility::function_3ab9164ef76940fd("torso", "torso_" + self.health_state + ter_op(namespace_c56b0b75fd51eab1::function_8ce7894f1a52fb77("charm") || istrue(self.var_c124ffbc8c1883e7), "_turned", ""));
}

function function_5bef17118b9a7984(pos) {
  if(self._blackboard.var_1766d5cccf9b5670 > 0) {
    var_12d6ddd0639c7a3d = distance2dsquared(self._blackboard.var_46621811c1024018, pos);

    if(var_12d6ddd0639c7a3d > squared(self._blackboard.var_1766d5cccf9b5670)) {
      return true;
    }
  }

  return false;
}

function function_2f1a5353c6e77e2a(state_index, enter_func, update_func, exit_func) {
  if(!isDefined(self.var_2b7717b9ec8efbff)) {
    self.var_2b7717b9ec8efbff = [];
  }

  assert(!isDefined(self.var_2b7717b9ec8efbff[state_index]), "<dev string:x4c>" + state_index + "<dev string:x5a>");
  assert(isDefined(update_func), "<dev string:x73>");
  state = spawnStruct();
  state.state_index = state_index;
  state.enter_func = enter_func;
  state.update_func = update_func;
  state.exit_func = exit_func;
  self.var_2b7717b9ec8efbff[state_index] = state;
}

function function_733117069a008b43(init_state) {
  self endon("death");
  assert(isarray(self.var_2b7717b9ec8efbff) && self.var_2b7717b9ec8efbff.size > 0, "<dev string:x9c>");

  if(!isDefined(init_state)) {
    init_state = random(self.var_2b7717b9ec8efbff).state_index;
  }

  assert(isDefined(self.var_2b7717b9ec8efbff[init_state]), "<dev string:x4c>" + init_state + "<dev string:xd6>");
  self._blackboard.var_4c29bf66496f352f = init_state;
  current_state = self.var_2b7717b9ec8efbff[init_state];

  if(isDefined(current_state.enter_func)) {
    self[[current_state.enter_func]]();
  }

  while(true) {
    waitframe();
    next_state = self[[current_state.update_func]]();

    var_dc4c4507a4c16a32 = getdvarint(@ "hash_7bacd197b9d0c4c6", -1);

    if(isDefined(self.var_2b7717b9ec8efbff[var_dc4c4507a4c16a32])) {
      next_state = var_dc4c4507a4c16a32;
    }

    function_f4458fb2849c0f12("<dev string:xf2>" + self._blackboard.var_4c29bf66496f352f);

    if(isDefined(next_state) && next_state != self._blackboard.var_4c29bf66496f352f) {
      if(isDefined(current_state.exit_func)) {
        self[[current_state.exit_func]]();
      }

      assert(isDefined(self.var_2b7717b9ec8efbff[next_state]), "<dev string:x106>" + self._blackboard.var_4c29bf66496f352f + "<dev string:x11c>" + next_state + "<dev string:x138>");
      self._blackboard.var_4c29bf66496f352f = next_state;
      current_state = self.var_2b7717b9ec8efbff[next_state];

      if(isDefined(current_state.enter_func)) {
        self[[current_state.enter_func]]();
      }
    }
  }
}

function function_4d42c08e173ff9f2() {}

function function_62bd63499815a3b5() {
  clear_float_move();
  var_3d330f957ab773d5 = function_997cc9f014de985e();

  if(isDefined(var_3d330f957ab773d5)) {
    self.var_3d330f957ab773d5 = var_3d330f957ab773d5;
    return 1;
  }

  if(function_539bfd8d01bf5aa8()) {
    return 2;
  }

  if(function_8d145bc972d3d7c3(self.enemy, self.var_1e81a7753e0e50ba)) {
    return 5;
  }

  if(function_14964e5b82c7dd18()) {
    return 4;
  }

  if(function_abfb3e51c8ddf91f(self.enemy, self.var_1e81a7753e0e50ba)) {
    return 5;
  }
}

function function_a864efd5a4c343e4() {}

function function_8f1d453ee684e38d() {
  self setbtgoalent(2, self.var_3d330f957ab773d5);
}

function function_4b6d93f3fa22a0b4() {
  clear_float_move();

  if(!isalive(self.var_3d330f957ab773d5) || self.var_3d330f957ab773d5 ent_flag("disciple_bound") || function_5bef17118b9a7984(self.var_3d330f957ab773d5.origin)) {
    return 0;
  }

  if(function_8d145bc972d3d7c3(self.var_3d330f957ab773d5, self.var_1e81a7753e0e50ba * 0.25)) {
    return 5;
  }
}

function function_14295ed2252547c5() {
  self clearbtgoal(2);
  self.var_3d330f957ab773d5 = undefined;
}

function function_54a404c38a1369b7() {
  self setbtgoalpos(2, self.command_spot);
  self clearpath();
  self.allowstrafe = 1;
}

function function_f77e2c4073f34d22() {
  if(distance2dsquared(self.origin, self.command_spot) < 225) {
    return 3;
  } else if(!isalive(self.enemy)) {
    return 0;
  }

  function_f4458fb2849c0f12("<dev string:x15a>", self.command_spot);
}

function function_6a23d453456a7033() {
  self.allowstrafe = 0;
  self clearbtgoal(2);
}

function function_ed7af34e8711e3b9() {
  if(!isDefined(level.var_dbcae1b52f2a4d5f)) {
    level.var_dbcae1b52f2a4d5f = [];
  }

  level.var_dbcae1b52f2a4d5f[level.var_dbcae1b52f2a4d5f.size] = self;
  self clearpath();
  var_65523366607fd8d9 = spawnStruct();
  var_65523366607fd8d9.var_aed09b91a2030246 = gettime() + 2000;
  var_65523366607fd8d9.var_46d9fe3888f126b3 = gettime() + 5000;
  var_65523366607fd8d9.var_21c94d4c15f3b468 = 0;
  self.var_5c40558635c32132 = var_65523366607fd8d9;
}

function function_e1a0b3dd3d79acd8() {
  if(function_29e8abbd27a584c5()) {
    if(function_539bfd8d01bf5aa8()) {
      return 2;
    }

    return 0;
  }
}

function function_8dbd5a377a20ba99() {
  level.var_dbcae1b52f2a4d5f = array_remove(level.var_dbcae1b52f2a4d5f, self);
  self.var_5c40558635c32132 = undefined;
}

function function_e354f660d897ba2e() {
  self.allowstrafe = 1;
}

function function_8f258de4aad8d969() {
  var_3d330f957ab773d5 = function_997cc9f014de985e();

  if(isDefined(var_3d330f957ab773d5)) {
    self.var_3d330f957ab773d5 = var_3d330f957ab773d5;
    return 1;
  } else if(istrue(self.var_e3093b57b14938a1) && function_a6f183528ab5941()) {
    return 3;
  } else if(!function_14964e5b82c7dd18()) {
    return 0;
  }

  function_f9ed622e24431d52();
}

function function_734d6307f1040338() {
  self.allowstrafe = 0;
  self.circle_pos = undefined;
}

function function_765311e9d977d0a4() {
  self clearpath();
  self clearbtgoal(0);
  function_9eaaa0a5c40b2c19(self.sweep_pos, self.sweep_speed);
  self.var_8a692d3883049390 = gettime();
}

function function_ee0dbf14cac0394b() {
  dist_sq = distancesquared(self.origin, self.sweep_pos);

  if(dist_sq < 2025 || dist_sq > 4000000 || !istrue(self function_11e2d4051ea44b35("in_float_move"))) {
    return 0;
  }

  if(time_has_passed(self.var_8a692d3883049390, 10)) {
    return 0;
  }

  if(isDefined(self.sweep_target) && distancesquared(self.sweep_target.origin, self.sweep_pos) > squared(384)) {
    sweep_pos = function_67d5ae32b2b1e42a(self.sweep_target);

    if(isDefined(sweep_pos)) {
      self.sweep_pos = sweep_pos;
      function_c73058e4f180cbff(self.sweep_pos);
    }
  }

  if(isDefined(self.var_37ca4842bca3031c) && time_has_passed(self.var_37ca4842bca3031c, 1)) {
    return 0;
  }

  self animmode("noclip");
  self orientmode("face point", self.sweep_pos);

  function_f4458fb2849c0f12("<dev string:x16e>", self.sweep_pos);
}

function function_bdb7cfc201ba226a() {
  self.sweep_target = undefined;
  self.sweep_pos = undefined;
  self.var_6be4867f8098164b = gettime() + self.var_181a00542ff4ff22;
  clear_float_move();
}

function function_f135e04cf8f97daa() {
  self endon("death");
  self endon("clear_float_move");
  self.sweep_target waittill("death");
  self.sweep_target = undefined;
}

function function_67d5ae32b2b1e42a(target) {
  var_70c7a86553ca36e3 = self.origin - target.origin;
  center_pos = vectorNormalize(var_70c7a86553ca36e3) * 128 + target.origin;
  sweep_pos = getrandomnavpoint(center_pos, 128);

  if(isDefined(sweep_pos)) {
    return (sweep_pos + (0, 0, 50));
  }
}

function function_8d145bc972d3d7c3(target, var_9659f5d380c46f25) {
  if(!isalive(target) || function_860d329e4f5111ae(self)) {
    return false;
  }

  if(self.var_6be4867f8098164b > gettime()) {
    return false;
  }

  if(distancesquared(target.origin, self.origin) < var_9659f5d380c46f25) {
    return false;
  }

  if(self._blackboard.var_1766d5cccf9b5670 > 0) {
    var_12d6ddd0639c7a3d = distance2dsquared(self._blackboard.var_46621811c1024018, target.origin);

    if(var_12d6ddd0639c7a3d > squared(self._blackboard.var_1766d5cccf9b5670)) {
      return false;
    }
  }

  if(self.var_9206541eb172ead2 && !self cansee(target)) {
    return false;
  }

  sweep_pos = function_67d5ae32b2b1e42a(target);

  if(isDefined(sweep_pos)) {
    self.sweep_pos = sweep_pos;
    self.sweep_target = target;
    thread function_f135e04cf8f97daa();
    return true;
  }

  return false;
}

function function_abfb3e51c8ddf91f(target, var_9659f5d380c46f25) {
  if(self._blackboard.var_1766d5cccf9b5670 <= 0) {
    return false;
  }

  if(!isalive(target) || function_860d329e4f5111ae(self)) {
    return false;
  }

  if(self.var_6be4867f8098164b > gettime()) {
    return false;
  }

  if(distancesquared(self.origin, self._blackboard.var_46621811c1024018) < var_9659f5d380c46f25) {
    return false;
  }

  var_12d6ddd0639c7a3d = distance2dsquared(self._blackboard.var_46621811c1024018, target.origin);

  if(var_12d6ddd0639c7a3d < squared(self._blackboard.var_1766d5cccf9b5670)) {
    return false;
  }

  sweep_pos = self._blackboard.var_46621811c1024018;

  if(isDefined(sweep_pos)) {
    self.sweep_pos = sweep_pos;
    return true;
  }

  return false;
}

function function_539bfd8d01bf5aa8() {
  if(getdvarint(@ "hash_a13284356f5c0aaa", 0)) {
    return false;
  }

  if(!isPlayer(self.enemy)) {
    return false;
  }

  if(function_860d329e4f5111ae(self)) {
    return false;
  }

  if(namespace_c56b0b75fd51eab1::function_8ce7894f1a52fb77("charm")) {
    return false;
  }

  if(!function_a6f183528ab5941()) {
    return false;
  }

  n_time = gettime();

  if(isDefined(self.var_3dfea6800a231b9f) && self.var_3dfea6800a231b9f + 4000 > n_time) {
    return false;
  }

  if(isDefined(self.var_9717a724c68ce93b) && self.var_9717a724c68ce93b + 3000 > n_time) {
    return false;
  }

  if(isDefined(self.var_8100d97175d3996d) && self.var_8100d97175d3996d + 500 > n_time) {
    return false;
  }

  self.var_8100d97175d3996d = n_time;

  if(!self cansee(self.enemy)) {
    self.var_9717a724c68ce93b = gettime();
    return false;
  }

  if(!isDefined(level.var_6f953b18327ddbb1)) {
    level.var_6f953b18327ddbb1 = [];
  }

  var_77f6338075a44a8f = getclosest(self.enemy.origin, level.var_6f953b18327ddbb1, 200);

  if(isDefined(var_77f6338075a44a8f)) {
    possible_spots = var_77f6338075a44a8f.spots;
  } else {
    possible_spots = function_931eb9eae1b9991e(self, self.enemy);
  }

  if(!isarray(possible_spots) || possible_spots.size == 0) {
    self.var_9717a724c68ce93b = gettime();
    return false;
  }

  if(!isPlayer(self.enemy)) {
    return false;
  }

  var_77f6338075a44a8f = spawnStruct();
  var_77f6338075a44a8f.origin = self.enemy.origin;
  var_77f6338075a44a8f.spots = possible_spots;
  level.var_6f953b18327ddbb1[level.var_6f953b18327ddbb1.size] = var_77f6338075a44a8f;

  if(level.var_6f953b18327ddbb1.size > 15) {
    level.var_6f953b18327ddbb1 = array_slice(level.var_6f953b18327ddbb1, 5, 15);
  }

  possible_spots = get_array_of_closest(self.origin, possible_spots, undefined, undefined, undefined, 200);

  if(isDefined(level.var_dbcae1b52f2a4d5f)) {
    foreach(var_f9dcc32d69f0bf39 in level.var_dbcae1b52f2a4d5f) {
      if(possible_spots.size == 0) {
        self.var_9717a724c68ce93b = gettime();
        return false;
      }

      if(!isalive(var_f9dcc32d69f0bf39)) {
        continue;
      }

      if(!isDefined(var_f9dcc32d69f0bf39.command_spot)) {
        continue;
      }

      possible_spots = get_array_of_closest(var_f9dcc32d69f0bf39.command_spot, possible_spots, undefined, undefined, undefined, 200);
    }
  }

  if(isDefined(possible_spots[0])) {
    command_spot = possible_spots[0].origin + (0, 0, 50);
    z_offset = (0, 0, 50);
    end = command_spot + z_offset + vectorNormalize(self.enemy.origin - command_spot) * 200;
    hit_nothing = scripts\engine\trace::ray_trace_passed(command_spot + z_offset, end);

    if(hit_nothing) {
      self.command_spot = command_spot;
      return true;
    }
  }

  self.var_9717a724c68ce93b = gettime();
  return false;
}

function function_29e8abbd27a584c5() {
  info = self.var_5c40558635c32132;

  if(!isDefined(info)) {
    return true;
  }

  if(!function_a6f183528ab5941()) {
    return true;
  }

  if(isDefined(self.var_9d47ede802b8ad6a) && self.health < self.var_9d47ede802b8ad6a) {
    return true;
  }

  if(gettime() < info.var_aed09b91a2030246) {
    return false;
  }

  if(gettime() > info.var_46d9fe3888f126b3) {
    return true;
  }

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 40000) {
    return true;
  }

  if(isDefined(self.enemy) && !self cansee(self.enemy)) {
    info.var_21c94d4c15f3b468 += 1;
  }

  if(info.var_21c94d4c15f3b468 >= 3) {
    return true;
  }

  return false;
}

function function_931eb9eae1b9991e(disciple, var_36005c75d5248ec1) {
  var_75658f54099f176f = vectortoyaw(disciple.origin - var_36005c75d5248ec1.origin);
  positions = function_3bd08a7c5eba1671(10, var_36005c75d5248ec1.origin, 100, 500, 300, 1, var_75658f54099f176f - 50, var_75658f54099f176f + 50);
  spot_list = [];

  foreach(pos in positions) {
    if(abs(disciple.origin[2] - pos[2]) > 100) {
      continue;
    }

    spot = spawnStruct();
    spot.origin = pos;
    spot_list[spot_list.size] = spot;
  }

  return spot_list;
}

function function_14964e5b82c7dd18() {
  if(!isDefined(self.enemy) || function_860d329e4f5111ae(self) || distancesquared(self.origin, self.enemy.origin) > 62500) {
    return false;
  }

  return true;
}

function function_f9ed622e24431d52() {
  if(!isDefined(self.enemy)) {
    return;
  }

  if(!isDefined(self.circle_pos) || distance2dsquared(self.origin, self.circle_pos) < 900) {
    var_bcd63e8b75ae0cfa = self.origin - self.enemy.origin;
    var_cb512fe1100a614a = vectortoyaw(var_bcd63e8b75ae0cfa);
    angle_offsets = [30, -30];
    var_3ee453f41c8fee6b = [];
    circle_range = 100;

    if(self getentitynumber() % 2 == 0) {
      circle_range += 50;
    }

    foreach(angle in angle_offsets) {
      target_angle = angleclamp180(var_cb512fe1100a614a + angle);
      target_vec = anglesToForward((0, target_angle, 0));
      target_pos = self.enemy.origin + target_vec * circle_range;
      var_4d665e1c4dd6e8c2 = getclosestpointonnavmesh(target_pos);

      if(isDefined(var_4d665e1c4dd6e8c2)) {
        var_3ee453f41c8fee6b[var_3ee453f41c8fee6b.size] = var_4d665e1c4dd6e8c2;
      }
    }

    var_9b1dd3f31435d981 = undefined;

    if(!isDefined(self.circle_pos)) {
      if(self.enemy ent_flag("disciple_take_left_turn")) {
        var_9b1dd3f31435d981 = default_to(var_3ee453f41c8fee6b[1], var_3ee453f41c8fee6b[0]);
        self.enemy ent_flag_clear("disciple_take_left_turn");
      } else {
        var_9b1dd3f31435d981 = var_3ee453f41c8fee6b[0];
        self.enemy ent_flag_set("disciple_take_left_turn");
      }
    } else {
      forward_vec = self.velocity;

      foreach(pos in var_3ee453f41c8fee6b) {
        var_3a61c8a04b4a99e2 = pos - self.origin;
        dot = vectordot(var_3a61c8a04b4a99e2, forward_vec);

        if(dot > 0) {
          var_9b1dd3f31435d981 = pos;
        }
      }
    }

    if(!isDefined(var_9b1dd3f31435d981) && var_3ee453f41c8fee6b.size > 0) {
      var_9b1dd3f31435d981 = var_3ee453f41c8fee6b[randomint(var_3ee453f41c8fee6b.size)];
    }

    if(isDefined(var_9b1dd3f31435d981)) {
      function_a55b3d6929d24cf7(var_9b1dd3f31435d981);
      self.circle_pos = var_9b1dd3f31435d981;
    }
  }
}

function function_97ab41be3f4a3f32() {
  var_46ebfc01e5ddeabd = [];
  var_46ebfc01e5ddeabd[0] = "<dev string:x180>";
  var_46ebfc01e5ddeabd[1] = "<dev string:x189>";
  var_46ebfc01e5ddeabd[2] = "<dev string:x199>";
  var_46ebfc01e5ddeabd[3] = "<dev string:x1af>";
  var_46ebfc01e5ddeabd[4] = "<dev string:x1bf>";
  function_6e7290c8ee4f558b("<dev string:x1c9>");
  function_a9a864379a098ad6("<dev string:x1e6>", "<dev string:x1f8>", &function_6644115e46341e36);
  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:x20f>");

  foreach(i, v in var_46ebfc01e5ddeabd) {
    function_b23a59dfb4ca49a1(v, "<dev string:x241>" + i, &function_4ea9638384d2757e);
  }

  function_b23a59dfb4ca49a1("<dev string:x25a>", "<dev string:x26f>", &function_4ea9638384d2757e);
  function_fe953f000498048f();
}

function private function_6644115e46341e36() {
  function_2fb888667001fc39("<dev string:x28a>", @ "hash_80faa777c33aade8");
}

function private function_4ea9638384d2757e(params) {
  state_index = int(params[0]);
  setDvar(@ "hash_7bacd197b9d0c4c6", state_index);
}

function private function_f4458fb2849c0f12(text, pos) {
  if(getdvarint(@ "hash_80faa777c33aade8", 0)) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, text, (1, 0, 0));
  }
}

# /