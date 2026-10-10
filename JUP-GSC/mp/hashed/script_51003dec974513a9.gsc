/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_51003dec974513a9.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_193e3e231841082f;
#using script_6c63dbe7d4c85e19;
#using script_7edf952f8921aa6b;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_deathworm;

function function_72d358d261f676a3(params) {
  settings = function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    add_fx("mobile_spawner_death_normal_vfx", settings.var_2ef0e750c2eef74);
    add_fx("mobile_spawner_death_special_vfx", settings.var_446cbd97d2ff9d52);
    add_fx("mobile_spawner_death_elite_vfx", settings.var_38d9f8cad7ecdc7e);
  }
}

function function_d5a08a1079b6f4dd() {
  self.var_e49062f063f27791 = [];

  for(spawner_i = 0; spawner_i < 6; spawner_i++) {
    self.var_e49062f063f27791[spawner_i] = spawn("script_model", self.origin);
    self.var_e49062f063f27791[spawner_i] setModel(self.zombieaisettings.var_e58a65b7a8f5973c.var_e6140b1038dfc126);
    thread utility::delete_on_death(self.var_e49062f063f27791[spawner_i]);
  }

  self.var_d230d829f6d05081 = ["zombie_mangler", "zombie_mimic", "zombie_disciple"];
  self.var_e62a57499d165e15 = ["zombie_abom_mega"];
  self.var_1b51c793abb7dbe6 = 0;
  thread function_256d338911387c1d();

  function_1dc954d715878eee();
}

function private function_256d338911387c1d() {
  self endon("death");

  while(true) {
    self waittill("mobile_spawner_start");
    function_526cf3378fc68c07();
  }
}

function private function_526cf3378fc68c07() {
  thread utility::thread_on_notify("spawn_mobile_spawner", &function_89c75ea3b9bff392, undefined, undefined, self, self, "mobile_spawner_end");
  thread utility::thread_on_notify("open_mouth", &function_5d00deda54ae49e1, undefined, undefined, self);
  var_d12dacd904504bd3 = 0;

  if(isDefined(self.enemy)) {
    var_d12dacd904504bd3 = utility::getyawtospot(self.enemy.origin);

    if(abs(var_d12dacd904504bd3) < getdvarfloat(@ "hash_c178ebcd849021e1", 90)) {
      self.turnrate = getdvarfloat(@ "hash_d726648e2004014e", 0.1);
    } else {
      self.turnrate = 0.01;
    }
  }

  function_470882fae4167198("<dev string:x1c>" + var_d12dacd904504bd3);
}

function private function_89c75ea3b9bff392() {
  function_814d919be8390cd3();
  head_pos = self gettagorigin("j_head");
  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();
  is_injured = self.health < self.maxhealth * 0.5;
  var_b5483230dd35a2b1 = 1 && (is_injured && var_de7821bc51ab43a0 >= 4 || var_de7821bc51ab43a0 >= 7);
  max_elites = 2;

  if(var_de7821bc51ab43a0 <= 9) {
    max_elites = 1;
  }

  if(var_b5483230dd35a2b1 && isDefined(self.var_36a5706c4995e3d7)) {
    elites_spawned = 0;

    foreach(ai in self.var_36a5706c4995e3d7) {
      if(isalive(ai) && is_equal(ai.aicategory, "elite")) {
        elites_spawned++;
      }
    }

    if(elites_spawned >= 2) {
      var_b5483230dd35a2b1 = 0;
    }
  }

  var_b23fe13906e7191b = is_injured || var_de7821bc51ab43a0 >= 4 ? 3 : 4;
  var_98462fcf733f80b5 = is_injured || var_de7821bc51ab43a0 >= 4 ? 6 : var_b23fe13906e7191b + 1;
  var_d95356124cc5cc35 = randomintrange(var_b23fe13906e7191b, var_98462fcf733f80b5 + 1);

  for(spawner_i = 0; spawner_i < var_d95356124cc5cc35; spawner_i++) {
    self.var_e49062f063f27791[spawner_i] dontinterpolate();
    self.var_e49062f063f27791[spawner_i].origin = head_pos;
    self.var_e49062f063f27791[spawner_i] utility::function_3ab9164ef76940fd("mobile_spawner", "mobile_spawner_on");
    var_69e3e4c4a13b7d1 = 0;

    if(var_b5483230dd35a2b1) {
      var_69e3e4c4a13b7d1 = spawner_i == 0;

      if(!var_69e3e4c4a13b7d1 && var_de7821bc51ab43a0 >= 14) {
        var_69e3e4c4a13b7d1 = spawner_i == 1;
      }
    }

    thread function_363dbe4e6642291(self.var_e49062f063f27791[spawner_i], var_69e3e4c4a13b7d1);
  }

  utility::function_3ab9164ef76940fd("mouth_fire", "mouth_fire_on");

  function_470882fae4167198("<dev string:x40>", head_pos);
}

function private function_363dbe4e6642291(mobile_spawner, var_69e3e4c4a13b7d1) {
  self endon("death");
  mobile_spawner endon("death");
  forward_vec = anglesToForward(self.angles);
  var_d04bd7f014726149 = getdvarfloat(@ "hash_1db1f153f575c73a", 90);
  var_c8fef90150a3a014 = getdvarfloat(@ "hash_7f2b507d55b34c01", 60);
  air_drag = getdvarfloat(@ "hash_df2d63ee68c8172b", 3);
  gravity = getdvarfloat(@ "bg_lowgravity", 400);
  current_velocity = forward_vec * var_d04bd7f014726149 + (0, 0, -1) * var_c8fef90150a3a014;
  current_velocity += randomint(20) * utility::random([-1, 1]) * (0, 0, 1);
  current_velocity += randomint(40) * utility::random([-1, 1]) * anglestoright(self.angles);
  prev_origin = mobile_spawner.origin;
  var_58124d39e9aa990 = 0;

  while(!var_58124d39e9aa990) {
    current_velocity += ((0, 0, -1) * gravity / 8 - forward_vec * air_drag) * level.framedurationseconds;
    mobile_spawner.origin += current_velocity;
    end_pos = physicstrace(prev_origin, mobile_spawner.origin);
    var_58124d39e9aa990 = end_pos != mobile_spawner.origin;

    if(function_af06517ad8334a70()) {
      line(prev_origin, mobile_spawner.origin, (1, 0, 0), 1);
    }

    prev_origin = mobile_spawner.origin;
    waitframe();
  }

  mobile_spawner utility::function_3ab9164ef76940fd("mobile_spawner", "mobile_spawner_impact");
  var_46d416fa1e8b773e = utility::random(var_69e3e4c4a13b7d1 ? self.var_e62a57499d165e15 : self.var_d230d829f6d05081);
  aitypes = namespace_2b1145f62aa835b8::get_aitype_by_subclass_sharedfunc(var_46d416fa1e8b773e);
  base_aitype = undefined;

  foreach(aitype in aitypes) {
    strlen = aitype.size;

    if(!isDefined(base_aitype) || base_aitype.size > strlen) {
      base_aitype = aitype;
    }
  }

  var_931e0bfccfc26fa5 = base_aitype;
  var_28c911f563f84e4 = utility::function_114e5c055b13dacf(mobile_spawner.origin, 200, -200);

  if(isDefined(var_28c911f563f84e4)) {
    angles = (0, 0, 0);

    if(isDefined(self.enemy)) {
      angles = (0, vectortoyaw(self.enemy.origin - var_28c911f563f84e4), 0);
    }

    var_2b1c25f7ca164d0f = namespace_2b1145f62aa835b8::spawnnewaitype_sharedfunc(var_931e0bfccfc26fa5, var_28c911f563f84e4, angles, self.team);

    if(isDefined(var_2b1c25f7ca164d0f)) {
      var_2b1c25f7ca164d0f.worm = self;
      self.var_1b51c793abb7dbe6++;
      self.var_36a5706c4995e3d7 = array_add_safe(self.var_36a5706c4995e3d7, var_2b1c25f7ca164d0f);
      var_2b1c25f7ca164d0f utility::function_3ab9164ef76940fd("deathworm_mobile_spawner", "on");
      var_2b1c25f7ca164d0f val::set("mobile_spawner", "ammomod_immune", 1);
      var_2b1c25f7ca164d0f.worm = self;
      var_2b1c25f7ca164d0f thread function_448e957d7afaac9a();
      params = spawnStruct();
      params.ai = var_2b1c25f7ca164d0f;
      callback("spawned_from_deathworm", params);

      if(istrue(level.var_4fe0c43951f6ce37)) {
        var_2b1c25f7ca164d0f.var_a0d32443f1df7929 = ai_spawn_director::spawn_request("ai_flood_fill_encounter:" + self.zombieaisettings.var_e58a65b7a8f5973c.var_3ab85d9d466f24bb, mobile_spawner.origin, 10000, 1, 1);
      }

      if(isDefined(var_2b1c25f7ca164d0f.var_a0d32443f1df7929)) {
        function_b0a68315f80cb547(var_2b1c25f7ca164d0f.var_a0d32443f1df7929, var_2b1c25f7ca164d0f);
        ai_spawn_director::function_73147cdf5c28d10c(var_2b1c25f7ca164d0f.var_a0d32443f1df7929, &function_f8355668319bcaf2, var_2b1c25f7ca164d0f);
        ai_spawn_director::function_e4a67fe4ddca7ed5(var_2b1c25f7ca164d0f.var_a0d32443f1df7929, &function_3fcec029f50d7376, var_2b1c25f7ca164d0f);
        var_2b1c25f7ca164d0f thread function_4b8806398ad868d9(var_2b1c25f7ca164d0f.var_a0d32443f1df7929);
      }
    }
  }

  targets = function_143526130b12b2b6(mobile_spawner.origin, 128);

  foreach(target in targets) {
    if(target.team != self.team) {
      var_d45caa2978502280 = distance2d(mobile_spawner.origin, target.origin);
      damage_percentage = max((128 - var_d45caa2978502280) / 128, 0);
      var_ec46e8a0004279b0 = math::remap(damage_percentage, 0, 1, 100, 300);
      target dodamage(var_ec46e8a0004279b0, mobile_spawner.origin, self, self, "MOD_UNKNOWN");

      function_470882fae4167198("<dev string:x63>" + var_ec46e8a0004279b0, target.origin + (0, 0, 70));
    }
  }
}

function private function_448e957d7afaac9a() {
  self endon("death");

  while(true) {
    if(!isalive(self.worm) || distance2dsquared(self.worm.origin, self.origin) > squared(2000)) {
      if(!isDefined(self.enemy)) {
        self kill();
      }
    }

    wait 10;
  }
}

function private function_4b8806398ad868d9(var_7ffb0443e06ecae) {
  worm = self.worm;
  aicategory = self.aicategory;
  self waittill("death");
  function_2169641d6a403864(var_7ffb0443e06ecae);
  ai_spawn_director::function_9950e6e485bf5261(var_7ffb0443e06ecae);

  if(isDefined(worm) && isDefined(worm.var_1b51c793abb7dbe6)) {
    worm.var_1b51c793abb7dbe6--;
  }

  if(is_equal(aicategory, "special")) {
    playFX(getfx("mobile_spawner_death_special_vfx"), self getcentroid() + (0, 0, 30));
  } else if(is_equal(aicategory, "elite")) {
    playFX(getfx("mobile_spawner_death_elite_vfx"), self getcentroid() + (0, 0, 30));
  }

  explosion_radius = 500;
  nearby_ai = getaiarrayinradius(self.origin, explosion_radius);

  foreach(ai in nearby_ai) {
    if(ai ent_flag("spawned_by_mobile_spawner")) {
      ai kill(ai.origin);
      wait randomfloatrange(0, 0.2);
    }
  }
}

function private function_f8355668319bcaf2(requestid, userdata) {
  var_2b1c25f7ca164d0f = userdata;

  if(isalive(var_2b1c25f7ca164d0f)) {}

  return false;
}

function private function_3fcec029f50d7376(requestid, userdata, agent, ai_data) {
  agent function_3ab9164ef76940fd("mobile_spawner", "mobile_spawner_on");
  agent ent_flag_set("spawned_by_mobile_spawner");
  agent.nocorpse = 1;

  if(isDefined(userdata.worm)) {
    params = spawnStruct();
    params.ai = agent;
    userdata.worm callback("spawned_from_deathworm", params);
  }

  agent waittill("death");
  playFX(getfx("mobile_spawner_death_normal_vfx"), agent getcentroid() + (0, 0, 30));
}

function private function_5d00deda54ae49e1() {
  self endon("death");
  utility::function_3677f2be30fdd581("mouth", "mobile_spawner");
  utility::waittill_2("close_mouth", "mobile_spawner_end");
  utility::function_3677f2be30fdd581("mouth", "off");
  cooldown = getdvarint(@ "hash_822ac04ca0fde15d", 90000);
  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();

  if(var_de7821bc51ab43a0 >= 4) {
    cooldown = int(60000);
  } else if(var_de7821bc51ab43a0 >= 7) {
    cooldown = int(30000);
  }

  ai::function_3e5ce428974325fb("mobile_spawner_cooldown", cooldown);
}

function function_1dc954d715878eee() {
  devgui::function_6e7290c8ee4f558b("<dev string:x70>");
  devgui::function_a9a864379a098ad6("<dev string:x8f>", "<dev string:xa7>", &function_2467e628b86f2234);
  devgui::function_a9a864379a098ad6("<dev string:xbf>", "<dev string:xd7>", &function_8ac0ad159685698f);
  devgui::function_fe953f000498048f();
}

function private function_2467e628b86f2234() {
  deathworm = zombie_utils::function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:xef>");

  if(!isDefined(deathworm)) {
    return;
  }

  deathworm function_3e89eb3d8e3f1811("<dev string:x103>", 1);
}

function private function_af06517ad8334a70() {
  return getdvarint(@ "hash_4407d608d4a28905", 0) > 0;
}

function private function_8ac0ad159685698f() {
  devgui::function_2fb888667001fc39("<dev string:x118>", @ "hash_4407d608d4a28905");
}

function private function_470882fae4167198(text, pos) {
  if(function_af06517ad8334a70()) {
    pos = utility::default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x13a>" + text, (1, 0, 0));
  }
}

# /