/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_44c2a1259e14bef1.gsc
***********************************************/

#using script_24c32478acf44108;
#using script_3751b21462a54a7d;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_stats;
#namespace namespace_32e85820;

function private autoexec __init__system__() {
  system::register(#"hash_36a2cb0be45d9374", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("toplayer", "fx_heal_aoe_player_clientfield", 1, 1, "counter");
  clientfield::register("scriptmover", "fx_heal_aoe_pillar_clientfield", 1, 1, "counter");
  clientfield::register("scriptmover", "fx_heal_aoe_bubble_clientfield", 1, 1, "int");
  namespace_1b527536::function_36e0540e(#"heal_aoe", 1, 50, #"field_upgrade_heal_aoe_item_sr");
  namespace_1b527536::function_36e0540e(#"heal_aoe_1", 1, 50, #"field_upgrade_heal_aoe_1_item_sr");
  namespace_1b527536::function_36e0540e(#"heal_aoe_2", 1, 50, #"field_upgrade_heal_aoe_2_item_sr");
  namespace_1b527536::function_36e0540e(#"heal_aoe_3", 1, 50, #"field_upgrade_heal_aoe_3_item_sr");
  namespace_1b527536::function_36e0540e(#"heal_aoe_4", 1, 50, #"field_upgrade_heal_aoe_4_item_sr");
  namespace_1b527536::function_36e0540e(#"heal_aoe_5", 1, 50, #"field_upgrade_heal_aoe_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"heal_aoe", &function_e190864a);
  namespace_1b527536::function_dbd391bf(#"heal_aoe_1", &function_1447ebb8);
  namespace_1b527536::function_dbd391bf(#"heal_aoe_2", &function_6ff0a318);
  namespace_1b527536::function_dbd391bf(#"heal_aoe_3", &function_62280787);
  namespace_1b527536::function_dbd391bf(#"heal_aoe_4", &function_594c75d0);
  namespace_1b527536::function_dbd391bf(#"heal_aoe_5", &function_4a8d5852);
}

function heal_player() {
  self.health = self.var_66cb03ad;

  if(!self scene::is_igc_active()) {
    self clientfield::increment_to_player("fx_heal_aoe_player_clientfield", 1);
  }
}

function function_f823ab5e() {
  self.var_9cd2c51d.var_232f5c31 = gettime();

  foreach(player in getplayers()) {
    if(player laststand::player_is_in_laststand() || !isalive(player)) {
      continue;
    }

    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    if(player.var_66cb03ad - player.health > 100) {
      self zm_stats::increment_challenge_stat(#"big_heals");
    }

    if(player.health < player.var_66cb03ad) {
      level scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: self, #scoreevent: "healing_aura_heal_zm"});
      self stats::function_622feb0d(#"heal_aoe", #"hash_6104ccb8b9cd1659", 1);
      self stats::function_6fb0b113(#"heal_aoe", #"hash_6b473078d990e6b2");
    }

    player heal_player();
  }
}

function function_e1dad5f7(var_c886f650 = 0) {
  self.var_9cd2c51d.var_232f5c31 = gettime();

  foreach(player in getplayers()) {
    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    if(player == self) {
      if(player.var_66cb03ad - player.health > 100) {
        self zm_stats::increment_challenge_stat(#"big_heals");
      }

      if(player.health < player.var_66cb03ad) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: self, #scoreevent: "healing_aura_heal_zm"});
        self stats::function_622feb0d(#"heal_aoe", #"hash_6104ccb8b9cd1659", 1);
        self stats::function_6fb0b113(#"heal_aoe", #"hash_6b473078d990e6b2");
      }

      player.health = player.var_66cb03ad;

      if(!player scene::is_igc_active()) {
        player clientfield::increment_to_player("fx_heal_aoe_player_clientfield", 1);
      }

      continue;
    }

    if(player laststand::player_is_in_laststand()) {
      player thread function_5427514f(var_c886f650);
      player notify(#"hash_4d93608c4b0fd45a");
      player thread zm_laststand::auto_revive(self, undefined, undefined, undefined, 1);
      level scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: self, #scoreevent: "healing_aura_revive_zm"});
      self stats::function_622feb0d(#"heal_aoe", #"hash_359bbe76d1d24148", 1);
      self zm_stats::increment_challenge_stat(#"assisted_revive");
      continue;
    }

    if(player.var_66cb03ad - player.health > 100) {
      self zm_stats::increment_challenge_stat(#"big_heals");
    }

    if(player.health < player.var_66cb03ad) {
      level scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: self, #scoreevent: "healing_aura_heal_zm"});
      self stats::function_622feb0d(#"heal_aoe", #"hash_6104ccb8b9cd1659", 1);
      self stats::function_6fb0b113(#"heal_aoe", #"hash_6b473078d990e6b2");
    }

    player heal_player();
  }
}

function function_5427514f(var_c886f650 = 0) {
  self endon(#"death");

  if(var_c886f650) {
    self.var_177876cb = self.var_ff5d288f;
  }

  self waittill(#"player_revived");
  self heal_player();

  if(var_c886f650) {
    self function_505c95d5();
  }
}

function function_505c95d5() {
  if(isDefined(self.var_177876cb)) {
    foreach(talent in self.var_177876cb) {
      self namespace_791d0451::function_3fecad82(talent, 0);
    }
  }

  self.var_177876cb = undefined;
}

function function_87d44a60() {
  nearbyzombies = getentitiesinradius(self.origin, 64, 15);

  foreach(zombie in nearbyzombies) {
    if(zombie.zm_ai_category == # "normal") {
      zombie zombie_utility::setup_zombie_knockdown(self.origin);
      continue;
    }

    if(zombie.zm_ai_category == # "special" || zombie.zm_ai_category == # "elite") {
      zombie ai::stun(2);
    }
  }
}

function function_451de831(var_c360c10f) {
  if(!isDefined(var_c360c10f)) {
    foreach(player in getplayers()) {
      nearbyzombies = getentitiesinradius(player.origin, 128, 15);

      foreach(zombie in nearbyzombies) {
        zombie.var_3f87fe17 = {
          #stun_time: gettime(), #player: self
        };

        if(zombie.zm_ai_category == # "normal") {
          zombie zombie_utility::setup_zombie_knockdown(self);
          continue;
        }

        if(zombie.zm_ai_category == # "special" || zombie.zm_ai_category == # "elite") {
          zombie ai::stun(2);
        }
      }
    }
  }
}

function function_27b2aab7() {
  foreach(player in getplayers()) {
    if(isalive(player)) {
      var_bf135e90 = spawn("script_model", player.origin);
      var_bf135e90 setModel("tag_origin");
      var_bf135e90 linkto(player);
      var_bf135e90 clientfield::increment("fx_heal_aoe_pillar_clientfield");
      var_bf135e90 thread function_4c7c38cb();
    }
  }
}

function function_4c7c38cb() {
  level endon(#"game_ended");
  self endon(#"death");
  wait 1;
  self delete();
}

function function_e190864a(params) {
  self namespace_1b527536::function_460882e2(1);
  function_27b2aab7();
  self function_f823ab5e();
}

function function_1447ebb8(params) {
  self namespace_1b527536::function_460882e2(1);
  function_27b2aab7();
  self function_f823ab5e();

  foreach(player in getplayers()) {
    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    player thread function_b923a327(self);
    player thread function_381f09f3();
  }
}

function function_6ff0a318(params) {
  self namespace_1b527536::function_460882e2(1);
  function_27b2aab7();
  self function_f823ab5e();

  foreach(player in getplayers()) {
    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    player thread function_b923a327(self);
    player thread function_381f09f3();
  }

  self function_451de831();
}

function function_62280787(params) {
  self namespace_1b527536::function_460882e2(1);
  function_27b2aab7();
  self thread function_e1dad5f7();

  foreach(player in getplayers()) {
    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    player thread function_b923a327(self);
    player thread function_381f09f3();
  }

  self function_451de831();
}

function function_594c75d0(params, var_c360c10f = undefined, var_a37a2188 = 0) {
  if(!var_a37a2188) {
    self namespace_1b527536::function_460882e2(1);
  }

  function_27b2aab7();
  self thread function_e1dad5f7(1);

  foreach(player in getplayers()) {
    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    if(isDefined(var_c360c10f)) {
      player thread function_b923a327(var_c360c10f);
    } else {
      player thread function_b923a327(self);
    }

    player thread function_381f09f3();
  }

  self function_451de831(var_c360c10f);
}

function function_4a8d5852(params) {
  self namespace_1b527536::function_460882e2(1);
  self endon(#"death");
  function_27b2aab7();
  self function_594c75d0(params);

  foreach(player in getplayers()) {
    if(isDefined(level.var_cbcc2ab7)) {
      if(![[level.var_cbcc2ab7]](player)) {
        continue;
      }
    }

    var_bf135e90 = spawn("script_model", player.origin);
    var_6af41078 = spawn("script_model", (player.origin[0], player.origin[1], player.origin[2] + 10));
    var_6af41078.angles = (270, 0, 0);
    var_bf135e90 setModel("tag_origin");
    var_6af41078 setModel("tag_origin");
    var_bf135e90 clientfield::set("fx_heal_aoe_bubble_clientfield", 1);
    var_bf135e90.player = player;
    var_bf135e90.owner = self;
    var_bf135e90 thread function_6f2ddf8e();
    var_bf135e90 thread function_93b178ae();
    var_6af41078 thread function_93b178ae();
  }
}

function function_b923a327(owner) {
  self endon(#"disconnect");

  if(!isalive(self) || self.sessionstate != "playing") {
    return;
  }

  if(self === owner) {
    self flag::increment("zm_field_upgrade_in_use");
  }

  wait 10;

  if(self === owner) {
    self flag::decrement("zm_field_upgrade_in_use");
  }
}

function function_381f09f3() {
  self endon(#"death");
  self notify("10c9228d258d4bfa");
  self endon("10c9228d258d4bfa");

  if(!isalive(self) || self.sessionstate != "playing") {
    return;
  }

  count = 0;

  while(count <= 10) {
    if(!self laststand::player_is_in_laststand()) {
      currenthealth = self.health;
      regen_amount = 25;

      if(currenthealth + regen_amount > self.var_66cb03ad) {
        regen_amount = self.var_66cb03ad - currenthealth;
      }

      self.health += regen_amount;

      if(!self scene::is_igc_active()) {
        self clientfield::increment_to_player("fx_heal_aoe_player_clientfield", 1);
      }
    }

    count++;
    wait 1;
  }
}

function function_92297dd0(var_c27b1726, var_c360c10f) {
  foreach(player in getplayers()) {
    if(distance2d(var_c27b1726, player.origin) <= 64) {
      if(player === var_c360c10f) {
        var_a37a2188 = 0;
      } else {
        var_a37a2188 = 1;
      }

      player function_594c75d0(undefined, var_c360c10f, var_a37a2188);
    }
  }
}

function function_93b178ae() {
  level endon(#"game_ended");
  self endon(#"death");
  wait 10;
  self delete();
}

function function_6f2ddf8e() {
  self endon(#"death");
  var_b9403c9 = self.origin;

  while(true) {
    function_92297dd0(var_b9403c9, self.owner);
    wait 1;
  }
}