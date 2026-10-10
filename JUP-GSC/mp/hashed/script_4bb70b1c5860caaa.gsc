/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4bb70b1c5860caaa.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_38db8bccc9eb301f;
#using script_63d03bd53d001217;
#using script_686729055b66c6e4;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\supers;
#namespace namespace_9a9b47877ca3f004;

function init() {
  level._effect["energy_mine_stationary"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_fld_energy_mine_lvl1_orb.vfx");
  level._effect["energy_mine_explosion3"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_fld_energy_mine_lvl5_activate.vfx");
  scripts\mp\supers::function_53110a12409d01da("super_energy_mine", undefined, undefined, &function_62bf63d59a97c263, &function_b790d6291eab001f, undefined);
  scripts\mp\supers::registersuperextraweapon("super_energy_mine", "energy_mine_ball_mp");

  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x35>", "<dev string:x49>");
  add_devgui_command("<dev string:x79>", "<dev string:x90>");
  function_fe953f000498048f();

  supertable = getscriptbundle(level.supertable);

  foreach(super in supertable.super_list) {
    if(super.ref == "super_energy_mine") {
      level.var_f04301db8ca5ecfa["super_energy_mine"] = getscriptbundle("super:" + super.bundle);
      break;
    }
  }
}

function function_62bf63d59a97c263() {
  if(isDefined(level.var_f04301db8ca5ecfa["super_energy_mine"])) {
    var_4c7b639370677d2a = level.var_f04301db8ca5ecfa["super_energy_mine"].offhandweapon;
    deploysuccess = namespace_e23f629a8349dfaf::function_75abcff430ed00b7(var_4c7b639370677d2a);

    if(deploysuccess) {
      thread function_f1a745e0820f56c8();
      return true;
    }
  }

  return false;
}

function function_b790d6291eab001f(fromdeath, attacker) {
  return false;
}

function function_f1a745e0820f56c8() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("wand_fx", "wand_on_energy_mine", 0);
  function_e072876ccd1495e8();
}

function function_e072876ccd1495e8() {
  forward = anglesToForward(self getplayerangles());
  var_76da69f57d1f80e = "energy_mine_ball_mp";
  result = scripts\cp_mp\utility\player_utility::isinvehicle();

  if(istrue(result)) {
    seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(self.vehicle, self);
    data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitpositionandangles(self.vehicle, self, seatid);

    if(isDefined(data)) {
      location = data[0];
      mdl_ball = function_ee5a64593eeafb01(location, forward * 1, var_76da69f57d1f80e);
    } else {
      location = self.vehicle.origin + (0, 0, 10);
      mdl_ball = function_ee5a64593eeafb01(location, forward * 1, var_76da69f57d1f80e);
    }
  } else {
    upvector = (0, 0, 1);
    var_5c2c1eddb0f0959b = 10;
    var_197136a65d1c9c3b = 30;
    var_785bdca2b3c12d34 = 400;
    origin = self gettagorigin("j_wrist_le", 1);
    origin = isDefined(origin) ? origin : self gettagorigin("tag_accessory_left");
    throwstart = origin + upvector * var_5c2c1eddb0f0959b + forward * var_197136a65d1c9c3b;
    throwvelocity = forward * var_785bdca2b3c12d34 + self getvelocity();
    mdl_ball = function_ee5a64593eeafb01(throwstart, throwvelocity, var_76da69f57d1f80e);
  }

  if(isDefined(mdl_ball)) {
    mdl_ball function_6b9674c374b1f1d8();
    newent = mdl_ball function_a059dc384d5983ba();

    if(!isDefined(newent)) {
      if(isDefined(mdl_ball) && isDefined(mdl_ball.scriptable)) {
        mdl_ball.scriptable freescriptable();
      }

      if(isDefined(mdl_ball)) {
        mdl_ball delete();
      }

      return 0;
    }

    if(isDefined(mdl_ball)) {
      mdl_ball delete();
    }

    mdl_ball = newent;
    mdl_ball.team = self.team;
    mdl_ball thread function_59a8b49b95ed21bc();
    thread function_7bea38ba568b92e6(mdl_ball);
    return;
  }

  assertmsg(var_76da69f57d1f80e + "<dev string:xc4>");
  return 0;
}

function private function_ee5a64593eeafb01(location, throwvelocity, mine_weapon) {
  mdl_ball = magicgrenademanual(mine_weapon, location, throwvelocity, 99999, self);
  var_7bd51846bb8b9086 = spawnscriptable("super_energymine_ball", mdl_ball.origin);
  var_7bd51846bb8b9086 scriptablesetparententity(mdl_ball);
  mdl_ball.scriptable = var_7bd51846bb8b9086;
  mdl_ball.scriptable setscriptablepartstate("audio", "fired");
  return mdl_ball;
}

function private function_59a8b49b95ed21bc() {
  var_12baea29dc62088 = function_2e9e02e8bda61ef2();

  if(isDefined(var_12baea29dc62088) && isDefined(var_12baea29dc62088.groundent) && isDefined(var_12baea29dc62088.localorigin) && isDefined(var_12baea29dc62088.localangles)) {
    if(isDefined(self.linkedparent)) {
      self.linkedparent linkTo(var_12baea29dc62088.groundent, "", var_12baea29dc62088.localorigin, var_12baea29dc62088.localangles);
      return;
    }

    self linkTo(var_12baea29dc62088.groundent, "", var_12baea29dc62088.localorigin, var_12baea29dc62088.localangles);
  }
}

function function_6b9674c374b1f1d8() {
  self endon("death");
  level endon("game_ended");
  last_origin = self.origin + (1, 1, 1);

  while(true) {
    if(distancesquared(self.origin, last_origin) > 0) {
      last_origin = self.origin;
    } else {
      break;
    }

    wait 0.4;
  }
}

function function_a059dc384d5983ba() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  offset = (0, 0, 0);
  ent = spawn_tag_origin(self.origin + offset, (0, 0, 0));
  ent show();
  var_7bd51846bb8b9086 = self.scriptable;
  var_7bd51846bb8b9086 scriptableclearparententity();
  waitframe();
  var_7bd51846bb8b9086 scriptablesetparententity(ent);
  ent.scriptable = var_7bd51846bb8b9086;
  ent.scriptable setscriptablepartstate("audio", "planted");
  ent play_vfx("energy_mine_stationary");
  return ent;
}

function function_7bea38ba568b92e6(mdl_ball) {
  mdl_ball endon("death");
  deploy_limit = function_bfef753aaf727ca0("energy_mine_deploy_limit");

  if(isDefined(deploy_limit)) {
    if(!isDefined(self.var_c005fa4a47da9984)) {
      self.var_c005fa4a47da9984 = [];
    }

    self.var_c005fa4a47da9984 = array_add(self.var_c005fa4a47da9984, mdl_ball);

    if(self.var_c005fa4a47da9984.size > deploy_limit) {
      first_ball = array_get_first_item(self.var_c005fa4a47da9984);
      first_ball.var_60fae3fe6a67317a = 1;
      self.var_c005fa4a47da9984 = array_remove(self.var_c005fa4a47da9984, first_ball);
    }
  }

  var_828c4c6ae53b48c4 = 0.6;
  var_818c0fdeb609f44c = 1;
  var_16379c59a5f75eba = function_bfef753aaf727ca0("energy_mine_ai_proximity_distance");
  mdl_ball function_d4081170de1f3ef1(self, var_16379c59a5f75eba);
  mdl_ball.scriptable setscriptablepartstate("audio", "tripped");

  if(isDefined(mdl_ball)) {
    mdl_ball stop_vfx("energy_mine_stationary");
    mdl_ball play_vfx("energy_mine_explosion3");
    wait var_828c4c6ae53b48c4;

    if(isPlayer(self)) {
      if(isDefined(mdl_ball) && isDefined(mdl_ball.scriptable)) {
        mdl_ball.scriptable setscriptablepartstate("audio", "explosion");
      }

      if(isDefined(mdl_ball)) {
        mdl_ball thread do_explosion(self);
      }
    }

    var_dda21aa6ac78fa04 = function_bfef753aaf727ca0("energy_mine_base_extra_explosion");

    for(i = 0; i < var_dda21aa6ac78fa04; i++) {
      wait var_818c0fdeb609f44c;

      if(isPlayer(self)) {
        if(isDefined(mdl_ball) && isDefined(mdl_ball.scriptable)) {
          mdl_ball.scriptable setscriptablepartstate("audio", "explosion");
        }

        if(isDefined(mdl_ball)) {
          mdl_ball thread do_explosion(self);
        }

        continue;
      }

      break;
    }

    wait var_818c0fdeb609f44c;

    if(isDefined(self.var_c005fa4a47da9984) && isDefined(mdl_ball)) {
      self.var_c005fa4a47da9984 = array_remove(self.var_c005fa4a47da9984, mdl_ball);
    }

    if(isDefined(mdl_ball) && isDefined(mdl_ball.scriptable)) {
      mdl_ball.scriptable freescriptable();
    }

    if(isDefined(mdl_ball)) {
      mdl_ball delete();
    }
  }
}

function function_d4081170de1f3ef1(e_player, n_radius) {
  self endon("death");

  while(true) {
    if(!isPlayer(e_player)) {
      return;
    }

    if(istrue(self.var_60fae3fe6a67317a)) {
      return;
    }

    a_ai_targets = e_player function_8e6d126b004376fa(n_radius, self.origin, 0);
    a_turrets = e_player function_bdb0c24fab4bf13c(n_radius, self.origin);

    if(a_ai_targets.size || a_turrets.size) {
      return;
    }

    waitframe();
  }
}

function function_226e870ed356947(env_damage, params) {
  if(isDefined(params.player) && isDefined(params.vehicle)) {
    if(!params.vehicle ent_flag_exist("convoy_energy_mine_stopped")) {
      params.player callback::callback("energy_mine_convoy_stopped", params);
      params.vehicle ent_flag_init("convoy_energy_mine_stopped");
    }

    if(env_damage >= params.vehicle.health || isDefined(params.vehicle.burningdown)) {
      params.vehicle ent_flag_init("energy_mine_kill");
    }
  }
}

function do_explosion(player) {
  var_86288ab91cf2da30 = spawnStruct();

  if(!isDefined(level.energy_mine_vehicle_throttle)) {
    level.energy_mine_vehicle_throttle = throttle_initialize("energy_mine_vehicle_throttle", 1, level.framedurationseconds);
  }

  var_8631e3bf9b3d2f28 = spawnStruct();

  if(!isDefined(level.energy_mine_ai_throttle)) {
    level.energy_mine_ai_throttle = throttle_initialize("energy_mine_ai_throttle", 1, level.framedurationseconds);
  }

  usedradius = function_bfef753aaf727ca0("energy_mine_explosion_radius");
  sweapon = "none";

  if(isDefined(level.weaponmetadata[%"energy_mine"])) {
    if(!isDefined(level.weaponmetadata[%"energy_mine"].weaponobj)) {
      sweapon = makeweapon(level.weaponmetadata[%"energy_mine"].weapon);
      level.weaponmetadata[%"energy_mine"].weaponobj = sweapon;
    } else {
      sweapon = level.weaponmetadata[%"energy_mine"].weaponobj;
    }
  }

  env_damage = function_bfef753aaf727ca0("energy_mine_env_damage");
  player radiusdamage(self.origin, usedradius, env_damage, env_damage, player, "MOD_EXPLOSIVE", sweapon, 1);
  vehicles = vehicle_getarrayinradius(self.origin, usedradius);
  vehicleparams = spawnStruct();
  vehicleparams.player = player;

  foreach(vehicle in vehicles) {
    vehicleparams.vehicle = vehicle;

    if(isDefined(vehicle.owner) && isDefined(vehicle.owner.team) && vehicle.owner.team != self.team) {
      function_226e870ed356947(env_damage, vehicleparams);
    } else if(isDefined(vehicle.team) && vehicle.team != player.team) {
      function_226e870ed356947(env_damage, vehicleparams);
    }

    vehicle dodamage(env_damage, self.origin, player, player, "MOD_EXPLOSIVE", sweapon);
    function_f632348cbb773537(level.energy_mine_vehicle_throttle, var_86288ab91cf2da30);
  }

  turrets = player function_bdb0c24fab4bf13c(usedradius, self.origin);

  foreach(turret in turrets) {
    if(isDefined(turret)) {
      turret notify("kill_turret", 1, 1);
    }
  }

  a_ai_targets = player function_8e6d126b004376fa(usedradius, self.origin, 1);
  var_1166efc9ef31932c = function_bfef753aaf727ca0("energy_mine_ai_soldier_damage");
  var_b3e4335e71ba04f6 = function_bfef753aaf727ca0("energy_mine_ai_special_damage_percent");
  var_86bd417f8eaa95d6 = function_bfef753aaf727ca0("energy_mine_ai_elite_damage_percent");
  var_c44ee1e9c7e69214 = function_bfef753aaf727ca0("energy_mine_ai_boss_damage_percent");
  var_e0dab373c4606f30 = function_bfef753aaf727ca0("energy_mine_ai_base_damage_percent");

  foreach(ai in a_ai_targets) {
    damage = 0;

    if(isDefined(ai.type) && ai.type == "human") {
      if(isDefined(ai.subclass) && issubstr(ai.subclass, "warlord")) {
        if(isDefined(var_86bd417f8eaa95d6)) {
          damage = ai.maxhealth * var_86bd417f8eaa95d6;
        }
      } else {
        damage = var_1166efc9ef31932c;
      }
    }

    if(damage == 0 && isDefined(ai.aicategory)) {
      if(ai.aicategory == "normal") {
        if(isDefined(var_e0dab373c4606f30)) {
          damage = ai.maxhealth * var_e0dab373c4606f30;
        }
      } else if(ai.aicategory == "special") {
        damage = ai.maxhealth * var_b3e4335e71ba04f6;
      } else if(ai.aicategory == "elite") {
        damage = ai.maxhealth * var_86bd417f8eaa95d6;
      } else if(ai.aicategory == "boss") {
        damage = ai.maxhealth * var_c44ee1e9c7e69214;
      }
    }

    if(damage == 0) {
      var_43ea7ee7224a5f65 = namespace_53fc9ddbb516e6e1::function_560b2e700ce084a2(ai.origin);
      base_damage = function_bfef753aaf727ca0("energy_mine_env_damage");
      damage = namespace_73f07f62510f0f5b::function_6f4c937aa843fac2(base_damage, var_43ea7ee7224a5f65, "frag_grenade", ai.aicategory, ai.maxhealth);
    }

    hitlocation = ai function_e715bf8be42d93b6();

    if(damage >= ai.health) {
      ai ent_flag_init("energy_mine_kill");
      ai ent_flag_set("energy_mine_kill");
      ai val::set("insta_kill", "kill_on_damage", 1);
      ai val::set("zm_allow_give_super_point", "allow_give_super_point", 0);
    }

    ai dodamage(damage, ai.origin, player, player, "MOD_UNKNOWN", sweapon, hitlocation, undefined, 65536);
    function_f632348cbb773537(level.energy_mine_ai_throttle, var_8631e3bf9b3d2f28);
  }
}

function function_6d2f600ec6654e8(player, a_ai_targets, v_origin) {
  stun_dur = 3;

  foreach(ai in a_ai_targets) {
    if(!isalive(ai)) {
      continue;
    }

    ai thread play_stun_fx(stun_dur);
    ai namespace_ed7c38f3847343dc::stun_ai(stun_dur);
    waitframe();
  }
}

function private function_e715bf8be42d93b6() {
  hitlocation = "none";

  if(isDefined(self.metabones)) {
    possiblehitlocations = [];
    var_46a3e181e35f46ab = scripts\common\metabone::function_97fd256a244527b4(self.metabones.bundle_name);

    if(isDefined(var_46a3e181e35f46ab)) {
      foreach(metabone in var_46a3e181e35f46ab.metabones) {
        if(!self.metabones.info[metabone.name].is_active) {
          continue;
        }

        if(scripts\common\metabone::function_cec565632b7fc419(metabone.name)) {
          continue;
        }

        if(!isDefined(metabone.hitlocations)) {
          continue;
        }

        foreach(var_7cec1af3073bea5d in metabone.hitlocations) {
          possiblehitlocations[possiblehitlocations.size] = var_7cec1af3073bea5d.hitlocation;
        }
      }

      if(possiblehitlocations.size > 0) {
        hitlocation = possiblehitlocations[randomintrange(0, possiblehitlocations.size)];
      }
    }
  }

  return hitlocation;
}

function function_8e6d126b004376fa(n_radius, v_origin, b_sort) {
  a_ai_all = getaiarrayinradius(v_origin, n_radius);
  a_ai_targets = [];

  foreach(ai in a_ai_all) {
    if(!isalive(ai)) {
      continue;
    }

    if(isDefined(ai.team) && ai.team == self.team) {
      continue;
    }

    a_ai_targets = array_add(a_ai_targets, ai);
  }

  if(istrue(b_sort)) {
    a_ai_targets = sortbydistance(a_ai_targets, v_origin);
  }

  return a_ai_targets;
}

function function_bdb0c24fab4bf13c(n_radius, v_origin) {
  var_199e6864751d7458 = getentarrayinradius("misc_turret", "classname", v_origin, n_radius);
  a_targets = [];

  foreach(turret in var_199e6864751d7458) {
    if(!isDefined(turret)) {
      continue;
    }

    if(isDefined(turret.team) && turret.team == self.team) {
      continue;
    }

    a_targets = array_add(a_targets, turret);
  }

  return a_targets;
}

function play_vfx(var_69e074f3c6e5686a) {
  playFXOnTag(getfx(var_69e074f3c6e5686a), self, "tag_origin");
}

function stop_vfx(var_69e074f3c6e5686a) {
  stopFXOnTag(getfx(var_69e074f3c6e5686a), self, "tag_origin");
}

function play_stun_fx(duration) {
  level endon("game_ended");
  self endon("death");
}

function function_bfef753aaf727ca0(str_field) {
  return namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_energy_mine", str_field);
}