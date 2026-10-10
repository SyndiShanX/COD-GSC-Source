/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_118c3165d7948d8b.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_42f1b4ddcbbf98b4;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_54f6d121e91434f8;
#using script_638d701d263ee1ed;
#using script_689f8728d45cb7e6;
#using script_7956d56c4922bd1;
#using script_9880b9dc28bc25e;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\outofbounds;
#namespace namespace_6babc541ac0484f4;

function function_483ef1bf0c76bedc() {
  function_89384091f7a2dbd("REV_OB_AETHERTEAR", 0, &function_72f2b1796fa07fa6);
  function_89384091f7a2dbd("REV_OB_AETHERTEAR", 1, &function_f0ec7d956c4a712e);
  function_89384091f7a2dbd("REV_OB_AETHERTEAR", 2, &function_5b80d2c2874ae1ab);
  function_89384091f7a2dbd("REV_OB_AETHERTEAR", 3, &function_8545b2b88d773755);
  function_89384091f7a2dbd("REV_OB_AETHERTEAR", 5, &function_81c481082c5b5b33);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_AETHERTEAR");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_5c651df8cfad0810, "REV_OB_AETHERTEAR");
  level._effect["aethertear_zombie_splatter"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_blood_splatter");
  level._effect["aethertear_teleport_vfx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_send_show");
}

function function_72f2b1796fa07fa6() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  var_45c17c8bd7095cc4 = function_b9c4aa88ad97ee68(self);
  self.variant_definition = var_45c17c8bd7095cc4;
  self.despawntimer = self.variant_definition.despawntimer;
  self.var_8708fa90e69653da = self.despawntimer + 2;
  self.var_b08a5eb0bbb07ab9 = self.variant_definition.var_b08a5eb0bbb07ab9;
  self.center_point = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);
  self.region = namespace_4df2ab39b0e96ec7::get_region(self.center_point);
  self.var_9b1cc6696e335d3 = function_415547ee4122c2ca();

  switch (self.var_9b1cc6696e335d3) {
    case #"hash_7bb2cd766703d463":
      self.lootoffset = self.variant_definition.teardifficulty.greendifficulty.offsetrange;
      self.var_4fb9dbd76077ce2f = self.variant_definition.teardifficulty.greendifficulty.var_4fb9dbd76077ce2f;
      self.oscillationtime = self.variant_definition.teardifficulty.greendifficulty.oscillationtime;
      self.containerinterval = self.variant_definition.teardifficulty.greendifficulty.containerinterval;
      break;
    case #"hash_af83e47edfa8900a":
      self.lootoffset = self.variant_definition.teardifficulty.yellowdifficulty.offsetrange;
      self.var_4fb9dbd76077ce2f = self.variant_definition.teardifficulty.yellowdifficulty.var_4fb9dbd76077ce2f;
      self.oscillationtime = self.variant_definition.teardifficulty.yellowdifficulty.oscillationtime;
      self.containerinterval = self.variant_definition.teardifficulty.yellowdifficulty.containerinterval;
      break;
    case #"hash_5343b465e56ec9a4":
      self.lootoffset = self.variant_definition.teardifficulty.orangedifficulty.offsetrange;
      self.var_4fb9dbd76077ce2f = self.variant_definition.teardifficulty.orangedifficulty.var_4fb9dbd76077ce2f;
      self.oscillationtime = self.variant_definition.teardifficulty.orangedifficulty.oscillationtime;
      self.containerinterval = self.variant_definition.teardifficulty.orangedifficulty.containerinterval;
      break;
    case #"hash_651f76c0ad6741ec":
      self.lootoffset = self.variant_definition.teardifficulty.reddifficulty.offsetrange;
      self.var_4fb9dbd76077ce2f = self.variant_definition.teardifficulty.reddifficulty.var_4fb9dbd76077ce2f;
      self.oscillationtime = self.variant_definition.teardifficulty.reddifficulty.oscillationtime;
      self.containerinterval = self.variant_definition.teardifficulty.reddifficulty.containerinterval;
      break;
    default:
      self.lootoffset = self.variant_definition.teardifficulty.greendifficulty.offsetrange;
      self.var_4fb9dbd76077ce2f = self.variant_definition.teardifficulty.greendifficulty.var_4fb9dbd76077ce2f;
      self.oscillationtime = self.variant_definition.teardifficulty.greendifficulty.oscillationtime;
      self.containerinterval = self.variant_definition.teardifficulty.greendifficulty.containerinterval;
      break;
  }

  self.var_4288c013f4ab2952 = getscriptbundle("itemspawnentry:" + self.var_4fb9dbd76077ce2f);
  self.spawned_items = [];
  self.var_8f03ddc94cda8be2 = [];
  self.var_25854b861ba805d9 = function_6d15e119c2779a93(self.var_4288c013f4ab2952);
  self.exit_point = function_2a7904a5d212e485();

  if(!isDefined(self.exit_point)) {
    point_height = getdvarfloat(@ "hash_50f18343f33b6153", 7000);
    self.exit_point = (self.center_point[0], self.center_point[1], self.center_point[2] + point_height);
  }

  function_7eb37783bbd7f386();
  self.tearused = 0;
  self.aethertear = spawnscriptable("ob_jup_aethertear", self.center_point);
  self.aethertear setscriptablepartstate("body_aethertear", "usable");
  self.aethertear.instance = activity_instance;

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case #"hash_224f194c88e9eac":
    case #"hash_9c19c4ead133822":
    case #"hash_330a93d145b37045":
    case #"hash_d7741d09a5c36348":
      self.aethertear setscriptablepartstate("entrance_vfx", "on_rift_run");
      break;
    default:
      self.aethertear setscriptablepartstate("entrance_vfx", "on");
      break;
  }

  self.exit_vfx = spawnscriptable("ob_jup_aethertear_vfx", self.exit_point);
  trigger_struct = spawnStruct();
  trigger_struct.origin = self.aethertear.origin - (0, 0, 15);
  trigger_struct.radius = 17;
  trigger_struct.height = 25;
  function_89a7111bd154e223(trigger_struct);
  function_b6fc2c96b463c007(activity_instance);
}

function function_89a7111bd154e223(structspawn) {
  self.trigger = spawn("trigger_radius", structspawn.origin, 0, structspawn.radius, structspawn.height);
  thread watchplayertrigger(self.trigger);
}

function watchplayertrigger(trigger) {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  self endon("despawning_tear");

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && !ent ent_flag("teleporting")) {
      function_3939a0857f18fe96(ent, self);
      continue;
    }

    if(isDefined(ent.subclass) && (ent.subclass == "zombie_base" || ent.subclass == "zombie_base_armored_light" || ent.subclass == "zombie_base_armored_heavy") && !ent ent_flag("teleporting")) {
      thread function_d93dd15db4daa7bd(ent, self);
    }
  }
}

function function_44c6c04fa367baea(point) {
  difficulty_region = undefined;
  difficulty_region = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(point);

  if(!isDefined(difficulty_region) || is_equal(difficulty_region, "difficulty_undefined")) {
    return "difficulty_easy";
  }

  return difficulty_region;
}

function function_415547ee4122c2ca() {
  difficulty_region = undefined;

  if(isDefined(level.var_fac39a693f085779)) {
    difficulty_region = [[level.var_fac39a693f085779]](namespace_68dc261109a9503f::function_8988a4c89289d7f4(self));
  }

  if(!isDefined(difficulty_region) || is_equal(difficulty_region, "difficulty_undefined")) {
    return "difficulty_easy";
  }

  return difficulty_region;
}

function function_2a7904a5d212e485() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");

  if(is_equal(scripts\cp_mp\utility\game_utility::getmapname(), "mp_jup_tower")) {
    var_eac93756f0bc7bc7 = getStruct(activity_instance.varianttag, "target");

    if(isDefined(var_eac93756f0bc7bc7)) {
      self.var_41f4fbcda6d7b9b7 = var_eac93756f0bc7bc7;
      return self.var_41f4fbcda6d7b9b7.origin;
    }
  }

  point_height = getdvarfloat(@ "hash_50f18343f33b6153", 7000);
  exit_point = undefined;
  var_8ef8ac335e8c4f8e = 0;

  while(!var_8ef8ac335e8c4f8e) {
    var_940f8606abe57fc8 = randomfloatrange(-200, 200);
    exit_point = (self.center_point[0] + var_940f8606abe57fc8, self.center_point[1] + var_940f8606abe57fc8, self.center_point[2] + point_height);
    difficulty_point = (exit_point[0], exit_point[1], 1);
    point_region = function_44c6c04fa367baea(difficulty_point);

    if(point_region == activity_instance.var_9b1cc6696e335d3) {
      var_8ef8ac335e8c4f8e = 1;
    }

    waitframe();
  }

  return exit_point;
}

function function_7eb37783bbd7f386() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  var_f08b335bba455b6c = spawnStruct();
  var_f08b335bba455b6c function_a1f71337a6844055();
  addcondition(var_f08b335bba455b6c, &function_133d3f81f9f3ab58, [function_8988a4c89289d7f4(self)]);
  addcondition(var_f08b335bba455b6c, &function_4a1651413519d392, [activity_instance.center_point, activity_instance.var_b08a5eb0bbb07ab9]);
  addcondition(var_f08b335bba455b6c, &function_c37214cf3d029093, [activity_instance.type]);

  if(isDefined(self.var_41f4fbcda6d7b9b7)) {
    activity_instance.playerangles = self.var_41f4fbcda6d7b9b7.angles;
    return;
  }

  var_a48794050cd1f283 = function_8ba4c11453487949(activity_instance.center_point, undefined, var_f08b335bba455b6c);
  var_ba899ec70c359048 = undefined;

  if(isDefined(var_a48794050cd1f283)) {
    var_ba899ec70c359048 = namespace_68dc261109a9503f::function_8988a4c89289d7f4(var_a48794050cd1f283);
  } else {
    var_4839faba11fabb49 = undefined;
    var_8ef8ac335e8c4f8e = 0;

    while(!var_8ef8ac335e8c4f8e) {
      direction_vec = randomvector(1);
      o_forward = undefined;
      var_1d67589b996f6e54 = getgroundposition(activity_instance.exit_point, 10);

      while(!isDefined(o_forward)) {
        o_forward = vectorNormalize(direction_vec) * activity_instance.var_b08a5eb0bbb07ab9 + var_1d67589b996f6e54;
        waitframe();
      }

      var_4839faba11fabb49 = getclosestpointonnavmesh(o_forward);
      difficulty_point = (var_4839faba11fabb49[0], var_4839faba11fabb49[1], 1);
      point_region = function_44c6c04fa367baea(difficulty_point);

      if(point_region == activity_instance.var_9b1cc6696e335d3 && !scripts\mp\outofbounds::ispointinoutofbounds(difficulty_point)) {
        var_8ef8ac335e8c4f8e = 1;
      }

      waitframe();
    }

    var_ba899ec70c359048 = var_4839faba11fabb49;
  }

  self.var_adcbe2e969bff2ff = activity_instance.exit_point + vectorNormalize(var_ba899ec70c359048 - activity_instance.exit_point) * 100;
  self.var_ba899ec70c359048 = var_ba899ec70c359048 + vectorNormalize(activity_instance.exit_point - var_ba899ec70c359048) * 800;
  activity_instance.playerangles = vectortoangles(self.var_ba899ec70c359048 - self.var_adcbe2e969bff2ff);
}

function function_3939a0857f18fe96(player, activity_instance) {
  activity_instance endon("instance_destroyed");
  player endon("death_or_disconnect");

  if(player scripts\cp_mp\utility\player_utility::isinvehicle() || istrue(player.inlaststand)) {
    return;
  }

  player val::set("aether_tear", "damage", 0);
  player ent_flag_set("teleporting");
  player playsoundevent("snd_aethertear_teleport_plr");
  player freezecontrols(1);
  playFX(getfx("aethertear_teleport_vfx"), player.origin);
  player thread function_7669f67b44245f73(1.25);

  if(istrue(activity_instance.tearused)) {
    if(isDefined(activity_instance.var_39f51e50bbc7280b) && activity_instance.var_39f51e50bbc7280b > activity_instance.var_8708fa90e69653da - 60) {
      activity_instance.var_39f51e50bbc7280b -= 60;
    }
  } else if(!isDefined(self.var_41f4fbcda6d7b9b7)) {
    activity_instance.tearused = 1;
    activity_instance function_5236025830b9bc9e();
    activity_instance thread function_514197a6326a2146();
    activity_instance thread function_777d2424031f2038();
  }

  thread function_e5dbca9e25c4b7fc(player, activity_instance);
  wait 0.2;
}

function private function_e5dbca9e25c4b7fc(player, activity_instance) {
  wait 1;

  if(isDefined(activity_instance.aethertear)) {
    activity_instance.aethertear setscriptablepartstate("teleport_audio", "play");
  }

  activity_instance.exit_vfx setscriptablepartstate("exit_vfx", "on");
  player setOrigin(activity_instance.exit_point);
  player setplayerangles(activity_instance.playerangles);
  scripts\common\callbacks::callback("exited_aether_tear", {
    #instance: activity_instance, #player: player
  });
  player freezecontrols(0);
  player val::set("aether_tear", "damage", 1);
  wait 0.2;
  player ent_flag_clear("teleporting");
}

function function_7669f67b44245f73(wait_time, fade_in_time) {
  self notify("play_nuke_screen_flash");
  self endon("death_or_disconnect");
  self endon("play_nuke_screen_flash");
  wait_time = default_to(wait_time, 1);
  fade_in_time = default_to(fade_in_time, 0.6);

  if(!isDefined(self.var_ad173ac833a970d4)) {
    self.var_ad173ac833a970d4 = newclienthudelem(self);
    self.var_ad173ac833a970d4.x = 0;
    self.var_ad173ac833a970d4.y = 0;
    self.var_ad173ac833a970d4 setshader("white", 640, 480);
    self.var_ad173ac833a970d4.alignx = "left";
    self.var_ad173ac833a970d4.aligny = "top";
    self.var_ad173ac833a970d4.sort = 1;
    self.var_ad173ac833a970d4.horzalign = "fullscreen";
    self.var_ad173ac833a970d4.vertalign = "fullscreen";
    self.var_ad173ac833a970d4.alpha = 0;
    self.var_ad173ac833a970d4.foreground = 1;
    self.var_ad173ac833a970d4.archived = 0;
    self.var_ad173ac833a970d4.scramblerdisabled = 1;
  }

  var_52bee65a8171b558 = fade_in_time;
  n_target_alpha = 1;
  self.var_ad173ac833a970d4 fadeovertime(var_52bee65a8171b558);
  self.var_ad173ac833a970d4.alpha = n_target_alpha;
  wait wait_time;
  var_52bee65a8171b558 = 0.5;
  self.var_ad173ac833a970d4 fadeovertime(var_52bee65a8171b558);
  self.var_ad173ac833a970d4.alpha = 0;
  wait var_52bee65a8171b558;

  if(isDefined(self.var_ad173ac833a970d4)) {
    self.var_ad173ac833a970d4 destroy();
  }
}

function function_d93dd15db4daa7bd(zombie, activity_instance) {
  activity_instance endon("instance_destroyed");
  zombie endon("death");
  zombie ent_flag_set("teleporting");

  if(isalive(zombie)) {
    zombie thread namespace_5381a59d140f4df8::function_c0d3ba0eab1acba0(zombie);
    waitframe();
    playFX(getfx("aethertear_teleport_vfx"), zombie.origin);
  }

  wait 1;

  if(isalive(zombie)) {
    zombie val::set("aether_tear", "show_healthbar", 0);
    zombie scripts\asm\asm::function_8d1655ae223d862a(0.3);
    zombie thread scripts\asm\shared\mp\utility::animscripted_single("falling");
  }

  zombie animmode("gravity_off_nav");
  waitframe();

  if(isalive(zombie)) {
    if(zombie getscriptablehaspart("teleport_audio")) {
      zombie setscriptablepartstate("teleport_audio", "in");
    }

    if(isDefined(activity_instance.aethertear)) {
      activity_instance.aethertear setscriptablepartstate("teleport_audio", "play_zombie");
    }

    zombie hide();
    zombie animmode("gravity_off_nav");
    zombie forceteleport(self.exit_point);
    zombie thread function_267216239fcea57b(self.exit_point);
  }

  wait 0.4;

  if(isalive(zombie)) {
    zombie show();
    zombie thread scripts\asm\shared\mp\utility::animscripted_single("falling");
    random_dir = function_6174330574a2a273();
    offset_origin = zombie.origin + random_dir * 900;
    zombie thread function_493643ebc0b429f(offset_origin);
    zombie thread zombie_death_watcher();
  }

  wait 0.2;
  zombie ent_flag_clear("teleporting");
}

function function_267216239fcea57b(exit_point) {
  self endon("death");
  time = gettime();

  while(true) {
    if(gettime() - time >= 250) {
      return;
    }

    self forceteleport(exit_point);
    self animmode("gravity_off_nav");
    waitframe();
  }
}

function function_493643ebc0b429f(backward_origin) {
  level endon("game_ended");
  self endon("death");
  ent_flag_set("aethertear_horizontal_falling");
  counter = 0;

  while(true) {
    if(counter >= 25) {
      waitframe();
      ent_flag_clear("aethertear_horizontal_falling");
      return;
    }

    backward_origin = (backward_origin[0], backward_origin[1], self.origin[2] - 150);
    current_origin = vectorlerp(self.origin, backward_origin, counter / 25);
    self forceteleport(current_origin);
    counter++;
    waitframe();
  }
}

function zombie_death_watcher() {
  level endon("game_ended");
  self endon("death");
  self.prev_origin = self.origin;

  while(true) {
    waitframe();
    self animmode("gravity_off_nav");
    curr_z = self.origin[2];
    prev_z = self.prev_origin[2];
    self.var_7e281b3e4bf725a1 = abs(curr_z - prev_z);

    if(isDefined(self.var_8d46a4815fd63b64) && self.var_7e281b3e4bf725a1 < self.var_8d46a4815fd63b64) {
      self.forceannihilate = 1;
      playFX(getfx("aethertear_zombie_splatter"), self.origin);
      self kill();
      return;
    }

    if(!ent_flag("aethertear_horizontal_falling")) {
      self.var_8d46a4815fd63b64 = self.var_7e281b3e4bf725a1;
    }

    self.prev_origin = self.origin;
  }
}

function function_5236025830b9bc9e() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  var_ba899ec70c359048 = self.var_ba899ec70c359048;
  var_adcbe2e969bff2ff = self.var_adcbe2e969bff2ff;
  cross_a = vectorNormalize(var_ba899ec70c359048 - var_adcbe2e969bff2ff);
  cross_b = (0, 0, 1);
  cross_vec = vectorcross(cross_a, cross_b);
  total_distance = distance(var_ba899ec70c359048, var_adcbe2e969bff2ff);
  dist_interval = total_distance / activity_instance.containerinterval;

  for(i = 1; i <= activity_instance.containerinterval; i++) {
    spawn_point = var_adcbe2e969bff2ff + vectorNormalize(var_ba899ec70c359048 - var_adcbe2e969bff2ff) * i * dist_interval;
    offset = randomfloatrange(activity_instance.lootoffset * -1, activity_instance.lootoffset);
    spawn_point = (spawn_point[0] + offset, spawn_point[1], spawn_point[2]);
    item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(activity_instance.var_4288c013f4ab2952, spawn_point, (0, 0, 0), 1);
    activity_instance.spawned_items = array_add(activity_instance.spawned_items, item);

    switch (activity_instance.var_9b1cc6696e335d3) {
      case #"hash_5343b465e56ec9a4":
      case #"hash_651f76c0ad6741ec":
      case #"hash_7bb2cd766703d463":
      case #"hash_af83e47edfa8900a":
        waitframe();
        move_to_point = spawn("script_model", item.origin);
        move_to_point setModel("tag_origin");
        item utility::function_6e506f39f121ea8a(move_to_point);
        activity_instance.var_8f03ddc94cda8be2 = array_add(activity_instance.var_8f03ddc94cda8be2, move_to_point);
        activity_instance thread function_c07392437df9ec0c(move_to_point, activity_instance.oscillationtime, cross_vec, item);
        break;
      default:
        item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(activity_instance.var_4288c013f4ab2952, spawn_point + cross_vec * 100, (0, 0, 0), 1);
        array_add(activity_instance.spawned_items, item);
        item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(activity_instance.var_4288c013f4ab2952, spawn_point + cross_vec * -100, (0, 0, 0), 1);
        array_add(activity_instance.spawned_items, item);
        break;
    }
  }
}

function function_c07392437df9ec0c(move_to_point, time, cross_vec, item) {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  item endon("death");
  center_point = item.origin;
  left_point = center_point + cross_vec * -125;
  right_point = center_point + cross_vec * 125;
  var_8e41959b7febe01 = randomint(2);
  move_to_point.origin = left_point;

  if(var_8e41959b7febe01 == 0) {
    while(true) {
      move_to_point moveTo(right_point, time, 0.5, 0.5);
      move_to_point waittill("movedone");
      move_to_point moveTo(left_point, time, 0.5, 0.5);
      move_to_point waittill("movedone");
    }
  }

  if(var_8e41959b7febe01 == 1) {
    while(true) {
      move_to_point moveTo(left_point, time, 0.5, 0.5);
      wait time;
      move_to_point moveTo(right_point, time, 0.5, 0.5);
      wait time;
    }
  }
}

function function_514197a6326a2146() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  timer = 0;

  while(true) {
    timer++;

    if(timer >= self.despawntimer) {
      self.aethertear setscriptablepartstate("entrance_vfx", "closing");
      wait 1.5;

      if(isDefined(self.aethertear)) {
        self.aethertear freescriptable();
      }

      self notify("despawning_tear");
      self waittill("essence_despawned");
      endactivity(activity_instance, 1);
    }

    wait 1;
  }
}

function function_777d2424031f2038() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  self.var_39f51e50bbc7280b = 0;

  while(true) {
    self.var_39f51e50bbc7280b++;

    if(self.var_39f51e50bbc7280b >= self.var_8708fa90e69653da) {
      self notify("essence_despawned");
    }

    wait 1;
  }
}

function function_f0ec7d956c4a712e() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
}

function function_5b80d2c2874ae1ab(activity_succeeded) {
  activity_instance = self;
  activity_instance endon("instance_destroyed");
}

function function_8545b2b88d773755() {
  activity_instance = self;
  activity_instance endon("instance_destroyed");

  if(isDefined(self.exit_vfx)) {
    self.exit_vfx freescriptable();
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  foreach(point in activity_instance.var_8f03ddc94cda8be2) {
    if(isDefined(point)) {
      point delete();
    }
  }

  foreach(item in activity_instance.spawned_items) {
    if(isDefined(item)) {
      function_c14962ea14e58968(item);
    }
  }
}

function function_6bb48579974ebf1e() {
  return (0, 0, 0);
}

function function_81c481082c5b5b33() {
  var_cc7aa96a854fd8ee = spawnStruct();
  var_cc7aa96a854fd8ee.origin = (0, 0, 0);
  var_cc7aa96a854fd8ee.angles = (0, 0, 0);
}

function function_1531bbf5cff97dc0(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.var_b494ea8c4b70490;
}

function function_5c651df8cfad0810(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
}