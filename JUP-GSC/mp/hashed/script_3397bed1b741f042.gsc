/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3397bed1b741f042.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_7edf952f8921aa6b;
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace zombie_deathworm;

function function_6e4961e4c0a38088(params) {
  settings = zombie_utils::function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    utility::add_fx("deathworm_beam_vfx", settings.beamvfx);
  }
}

function function_f847d21eaf2ae0ec() {
  self.var_544ffa1d219d6810 = undefined;
  self.var_a60b211ca1cf2a4e = 0;
  self.var_cadb0f258ae78683 = 400;
  self.var_c7310a377362f2c5 = 0;
  self.var_ac384c36d562babe = 0;
  self.worm_beam = undefined;
  self.var_938e5141ee890ce6 = spawn("script_model", self.origin);
  self.var_938e5141ee890ce6 setModel(self.zombieaisettings.var_e58a65b7a8f5973c.var_b298389835ed8e64);
  thread utility::delete_on_death(self.var_938e5141ee890ce6);
  thread function_da900f79fdfdf325();

  function_ef5fdad806a763db();
}

function function_66d92e1111a38ee9(asmname, statename, tostatename, params) {
  var_c8c23052c39bc69a = gettime() - self.var_c7310a377362f2c5;
  var_326cf47b91a5af18 = function_cdfb9d430f8848a7() + function_42ab866efe49c16a();

  if(var_326cf47b91a5af18 > 0 && var_c8c23052c39bc69a >= var_326cf47b91a5af18) {
    beam_print("<dev string:x1c>");

    return true;
  }

  return false;
}

function private function_42ab866efe49c16a() {
  return getdvarfloat(@ "hash_d4f7c6d528b62c", 600);
}

function private function_cdfb9d430f8848a7() {
  return self.var_d063762eab55a008;
}

function private function_459bbcf9eb27f689() {
  self endon("death");
  self endon("beam_attack_end");
  self.var_d063762eab55a008 = getdvarfloat(@ "hash_f6ce4762e0434fef", 2000);
  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();
  alive_percentage = [[self.var_c54a21ea717fe8a5]]();
  is_injured = self.health < self.maxhealth * 0.5;

  if(gettime() - self.var_ac384c36d562babe < 30000 || var_de7821bc51ab43a0 >= 4 || var_de7821bc51ab43a0 > 1 && alive_percentage >= 1 || is_injured) {
    self.var_d063762eab55a008 *= 0.5;
  }

  target_yaw = 0;

  if(isDefined(self.var_544ffa1d219d6810)) {
    var_a7053004b9d5575c = (0, 0, 0);

    if(isagent(self.var_544ffa1d219d6810) || isPlayer(self.var_544ffa1d219d6810)) {
      var_a7053004b9d5575c = self.var_544ffa1d219d6810 getvelocity();

      if(isDefined(self.var_544ffa1d219d6810.vehicle)) {
        var_a7053004b9d5575c = self.var_544ffa1d219d6810.vehicle vehicle_getvelocity();
      }
    }

    var_6f40c792931eb29b = self.var_544ffa1d219d6810.origin;
    dist_perc = distance2d(self.origin, var_6f40c792931eb29b) / 2000;
    predicted_pos = var_6f40c792931eb29b + var_a7053004b9d5575c * (function_42ab866efe49c16a() + function_cdfb9d430f8848a7() * dist_perc) / 1000;

    if(function_a87645b86864efb()) {
      line(var_6f40c792931eb29b, predicted_pos, (1, 0, 0));
      beam_print("<dev string:x3c>", predicted_pos);
    }

    var_6f40c792931eb29b = predicted_pos;
    target_yaw = utility::getyawtospot(var_6f40c792931eb29b);
    target_yaw = clamp(target_yaw, -70, 70);
  }

  var_44d1224cde3b1617 = anglesToForward((0, target_yaw + self.angles[1], 0));
  var_bcb3cf08a20f19ee = getdvarfloat(@ "hash_1e3b0a1e3da21425", 3000);
  self function_a490fd20800374d8(target_yaw);
  self function_12df4eebdbb4f79(0);
  wait function_42ab866efe49c16a() / 1000;
  start_time = gettime();
  end_time = start_time + function_cdfb9d430f8848a7();
  self.worm_beam = playfxontagsbetweenclients(getfx("deathworm_beam_vfx"), self, "tag_fx_beam_rotate", self.var_938e5141ee890ce6, "tag_origin");

  if(isDefined(self.worm_beam)) {
    self.worm_beam function_cea710f9d017694a(1);
    thread function_5ee1730c2e122134(self.worm_beam, "beam_attack_end");
  }

  self.var_938e5141ee890ce6 utility::function_3ab9164ef76940fd("beam_target", "beam_target_on");
  self.var_938e5141ee890ce6 dontinterpolate();
  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();

  while(true) {
    var_ab577b8024fab2bc = self gettagorigin("tag_fx_beam_rotate");
    time_perc = math::remap(gettime(), start_time, end_time, 0, 1);
    dist_perc = time_perc;

    if(var_de7821bc51ab43a0 < 7) {
      dist_perc = easepower(time_perc, getdvarfloat(@ "hash_3e747e1d7b24b293", 1.25), 1, 0);
    }

    target_dist = math::remap(dist_perc, 0, 1, 300, 2000);
    target_dist = clamp(target_dist, 300, 2000);
    var_91b8d084bb27de57 = var_44d1224cde3b1617 * target_dist + self.origin;
    var_40b2a3853bbdd156 = vectorNormalize(var_91b8d084bb27de57 - var_ab577b8024fab2bc);
    var_91b8d084bb27de57 = var_ab577b8024fab2bc + var_40b2a3853bbdd156 * var_bcb3cf08a20f19ee;
    var_2c34e052444ffee3 = trace::ray_trace_get_all_results(var_ab577b8024fab2bc, var_91b8d084bb27de57);
    hit_ents = [];
    hit_position = var_91b8d084bb27de57;

    foreach(trace_result in var_2c34e052444ffee3) {
      if(isDefined(trace_result["hittype"]) && trace_result["hittype"] == "hittype_world") {
        hit_position = trace_result["position"];
        break;
      }

      if(isDefined(trace_result["hittype"]) && trace_result["hittype"] == "hittype_entity") {
        hit_ents = utility::array_add(hit_ents, trace_result["entity"]);
      }
    }

    blast_radius = 80;
    var_1021496814ce12f2 = function_143526130b12b2b6(hit_position, blast_radius);
    hit_ents = utility::array_combine_unique(hit_ents, var_1021496814ce12f2);

    foreach(hit_ent in hit_ents) {
      if(!isalive(hit_ent) || self == hit_ent) {
        continue;
      }

      if(hit_ent utility::ent_flag("worm_beamed")) {
        beam_print("<dev string:x4d>", hit_ent.origin);

        continue;
      }

      beam_damage = 50;
      var_bd6fa7a5a71157c9 = 0;

      if(isPlayer(hit_ent)) {
        beam_damage = 250;
      } else if(isai(hit_ent)) {
        if(is_equal(hit_ent.subclass, "zombie_hellhound_pet")) {
          beam_damage = 7500;
        } else if((!isDefined(hit_ent.aicategory) || hit_ent.aicategory == "normal") && !istrue(hit_ent.damageshield)) {
          var_bd6fa7a5a71157c9 = 1;
        } else if(is_equal(hit_ent.aicategory, "special")) {
          beam_damage = 50000;
        } else if(is_equal(hit_ent.aicategory, "elite")) {
          beam_damage = 25000;
        }
      }

      if(istrue(var_bd6fa7a5a71157c9)) {
        hit_ent utility::ent_flag_set("dissolve");
        hit_ent kill(var_ab577b8024fab2bc, self, self, "MOD_PROJECTILE");
        continue;
      }

      if(istrue(self.var_fa1a1806d30a40e1) && self.var_f8adf1aaec88d636 > 1 && isPlayer(hit_ent)) {
        hit_ent dodamage(beam_damage, var_ab577b8024fab2bc, self, self, "MOD_PROJECTILE");
      }

      hit_ent dodamage(beam_damage, var_ab577b8024fab2bc, self, self, "MOD_PROJECTILE");
      hit_ent utility::ent_flag_set("worm_beamed");
      hit_ent thread utility::ent_flag_clear_delayed("worm_beamed", 0.5);

      beam_print("<dev string:x5e>", hit_ent.origin);
    }

    if(function_a87645b86864efb()) {
      sphere(hit_position, blast_radius, (1, 0, 0));
    }

    self.var_938e5141ee890ce6.origin = hit_position;
    self.var_a60b211ca1cf2a4e = target_yaw;
    self.var_cadb0f258ae78683 = target_dist;

    if(function_a87645b86864efb()) {
      line(var_ab577b8024fab2bc, self.var_938e5141ee890ce6.origin, (1, 0, 0));
      beam_print("<dev string:x7f>", self.var_938e5141ee890ce6.origin);
      line(self.var_938e5141ee890ce6.origin, var_91b8d084bb27de57, (1, 1, 0), 0.3);
    }

    self function_a490fd20800374d8(self.var_a60b211ca1cf2a4e);
    self function_12df4eebdbb4f79(self.var_cadb0f258ae78683);
    waitframe();
  }
}

function private function_da900f79fdfdf325() {
  self endon("death");

  while(true) {
    self waittill("beam_attack_start");
    self.var_c7310a377362f2c5 = gettime();
    self.var_544ffa1d219d6810 = self.enemy;
    utility::function_3ab9164ef76940fd("mouth", "beam");
    function_7380ccd6f2c49392("beaming_head", 1);
    var_d12dacd904504bd3 = 0;

    if(isDefined(self.enemy)) {
      var_d12dacd904504bd3 = utility::getyawtospot(self.enemy.origin);

      if(abs(var_d12dacd904504bd3) < getdvarfloat(@ "hash_290f687417871da4", 130)) {
        self.turnrate = getdvarfloat(@ "hash_600c759093c68d43", 0.025);
      } else {
        self.turnrate = 0.01;
      }
    }

    thread function_459bbcf9eb27f689();
    thread utility::thread_on_notify("beam_attack_end", &function_b6d9c51fec9ca521, undefined, undefined, self);
  }
}

function private function_b6d9c51fec9ca521() {
  utility::function_3ab9164ef76940fd("mouth", "off");
  utility::function_3ab9164ef76940fd("audio", "beam_off");
  self.var_938e5141ee890ce6 utility::function_3ab9164ef76940fd("beam_target", "beam_target_off");
  function_7380ccd6f2c49392("beaming_head", 0);
  ai::function_3e5ce428974325fb("beam_attack_cooldown", getdvarint(@ "hash_c9e4cfd3227d2cbf", 16000));
  self.var_ac384c36d562babe = gettime();
}

function function_ef5fdad806a763db() {
  devgui::function_6e7290c8ee4f558b("<dev string:x8d>");
  devgui::function_a9a864379a098ad6("<dev string:xac>", "<dev string:xc1>", &function_b453b984aa01e08f);
  devgui::function_a9a864379a098ad6("<dev string:xdb>", "<dev string:xf0>", &function_7e09fc9744157fee);
  devgui::function_fe953f000498048f();
}

function private function_b453b984aa01e08f() {
  worm = zombie_utils::function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x10a>");

  if(!isDefined(worm)) {
    worm = zombie_utils::function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x11e>");

    if(!isDefined(worm)) {
      return;
    }
  }

  worm function_3e89eb3d8e3f1811("<dev string:x137>", 1);
}

function private function_a87645b86864efb() {
  return getdvarint(@ "hash_f6e0c15a97baed74", 0) > 0;
}

function private function_7e09fc9744157fee() {
  devgui::function_2fb888667001fc39("<dev string:x149>", @ "hash_f6e0c15a97baed74");
}

function private beam_print(text, pos) {
  if(function_a87645b86864efb()) {
    pos = utility::default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x168>" + text, (1, 0, 0));
  }
}

# /