/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1edff2e0ab8e8655.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\siegebot;
#namespace namespace_78792ce8;

function function_7980d69c() {
  self endon(#"death");
  self enableaimassist();

  while(true) {
    target = self turretgettarget(0);

    if(isDefined(target)) {
      self turretsettarget(1, target);
    }

    waitframe(1);
  }
}

function function_ba7e9b89() {
  self endon(#"death", #"exit_vehicle");
  firetime = max(self seatgetweapon(1).firetime, self seatgetweapon(2).firetime);
  self fireweapon(1);
  self fireweapon(2);
  wait firetime;
}

function function_b974aa72(origin, player) {
  if(!isDefined(player) || isDefined(player.doa.vehicle) || is_true(player.doa.var_36cc2d9a) || !isDefined(level.doa.pickups.var_92a02b26)) {
    return;
  }

  if(!is_true(level.var_7fcdba66)) {
    siegebot::function_5de06a3f();
  }

  if(!is_true(level.doa.var_318aa67a)) {
    if(is_true(player.doa.infps)) {
      player notify(#"hash_7893364bd228d63e");
      waitframe(1);
      timeout = gettime() + 1000;

      while(is_true(player.doa.var_a5eb0385) && gettime() < timeout) {
        waitframe(1);
      }
    }
  }

  player notify(#"hash_df25520ab279dff");
  player endon(#"disconnect");
  level.doa.pickups.var_92a02b26.origin = origin;
  siegebot = level.doa.pickups.var_92a02b26 spawner::spawn(1, "zombietron_siegebot_spawner", origin, player.angles);

  if(!isDefined(siegebot)) {
    return;
  }

  player.doa.var_46b45756 = &function_b974aa72;
  player.doa.var_36cc2d9a = 1;
  player namespace_7f5aeb59::function_77785447(1);
  player function_fee48e9e();
  siegebot.var_8c05c51a = &function_ba7e9b89;
  siegebot thread namespace_ec06fe4a::function_ae010bb4(player);
  player.doa.var_36cc2d9a = undefined;
  player.doa.vehicle = siegebot;
  siegebot.team = player.team;
  siegebot.owner = player;
  siegebot.playercontrolled = 1;
  siegebot.var_7efce95 = 0;
  siegebot setModel("zombietron_siegebot_mini_" + player.doa.color);
  siegebot usevehicle(player, 0);
  siegebot makeunusable();
  siegebot.health = 9999999;
  siegebot thread function_7980d69c();
  siegebot.var_b9bb0656 = 1;
  siegebot function_d733412a(0);
  timeout = player namespace_1c2a96f9::function_4808b985(40);

  if(isDefined(level.doa.var_a77e6349)) {
    timeout += 30;
  }

  siegebot thread function_c45d8312(player, timeout);
  player namespace_83eb6304::turnofffx("player_trail_" + player.doa.color);
  player waittill(#"hash_279998c5df86c04d");

  if(!is_true(self.doa.infps)) {
    player namespace_83eb6304::function_3ecfde67("player_trail_" + player.doa.color);
  }

  player namespace_7f5aeb59::function_77785447(0, 1);

  if(isDefined(siegebot)) {
    var_f3fd3234 = siegebot.origin;
    siegebot makeusable();

    if(isDefined(player)) {
      player function_9b3b2351(var_f3fd3234, siegebot);
    }
  }

  if(isDefined(siegebot)) {
    siegebot makeunusable();
    siegebot thread namespace_ec06fe4a::function_52afe5df();
  }

  player thread namespace_7f5aeb59::turnplayershieldon();
  player notify(#"hash_7893364bd228d63e");
  util::wait_network_frame();
  player clientfield::increment_to_player("controlBinding");
}

function function_9b3b2351(var_f3fd3234, vehicle) {
  self endon(#"disconnect");

  if(isDefined(vehicle)) {
    vehicle.var_3e742dc1 = 1;
    vehicle usevehicle(self, 0);
  }

  if(namespace_4dae815d::function_59a9cf1d() == 0 && isDefined(level.doa.var_39e3fa99)) {
    spot = [[level.doa.var_39e3fa99]] - > function_70fb5745(vehicle.origin, 64, 1024, 1);
  }

  self.ignoreme = 0;
  self.doa.vehicle = undefined;
  self.doa.var_baad518e = undefined;
  self.doa.var_61c7a559 = gettime();
  self.doa.var_cfe0bf1b = self.doa.var_61c7a559 + 1000;

  if(isDefined(spot)) {
    self setorigin(spot.origin);
  }

  self clientfield::increment_to_player("controlBinding");
}

function function_fee48e9e() {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }

  self notify(#"kill_shield");
  self notify(#"kill_chickens");
  util::wait_network_frame();
}

function function_c45d8312(player, time) {
  player endon(#"disconnect", #"hash_279998c5df86c04d");

  while(!namespace_dfc652ee::function_f759a457()) {
    waitframe(1);
  }

  expiretime = gettime() + time * 1000;

  while(isDefined(self)) {
    result = self waittilltimeout(1, #"death", #"flipped", #"exit_vehicle");

    if(result._notify != # "timeout") {
      break;
    }

    if(gettime() > expiretime) {
      break;
    }
  }

  player notify(#"hash_279998c5df86c04d");
}