/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_code.gsc
*****************************************/

on_damage_turret_push_friendly_fire(var_0) {
  self endon("death");

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);
    var_6 = isDefined(var_2) && maps\oilrocks_code::isturret(var_2) && isDefined(var_2.owner) && isplayer(var_2.owner);

    if(var_6) {
      var_7 = "turret";
      var_1 = common_scripts\utility::ter_op(isDefined(var_0), var_0, var_1);
      self notify("friendlyfire_notify", var_1, var_2.owner, var_3, var_4, var_5, var_7);
    }
  }
}

apache_ally_path_attack_func(var_0) {
  self notify("apache_ally_path_attack_func");
  self endon("apache_ally_path_attack_func");

  if(isDefined(var_0.script_delay))
    wait(var_0.script_delay * 0.5);

  if(maps\_utility::ent_flag("apache_ally_attack_override")) {
    return;
  }
  self endon("apache_ally_attack_override");
  var_1 = getent(var_0.script_linkto, "script_linkname");

  if(isDefined(var_1.script_noteworthy)) {
    var_2 = getEntArray(var_1.script_noteworthy, "script_noteworthy");
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(isDefined(var_5) && var_5 != var_1 && !isspawner(var_5)) {
        var_3 = var_5;
        break;
      }
    }

    if(isDefined(var_3)) {
      vehicle_attack_missile(var_3, 1);
      return;
    }
  } else {
    var_7 = 0;

    if(isDefined(var_1.script_parameters) && issubstr(var_1.script_parameters, "ignoretargets"))
      var_7 = 1;

    childthread apache_ally_path_attack_internal(var_1, 1, 5000, var_7);
  }
}

apache_ally_path_attack_internal(var_0, var_1, var_2, var_3) {
  var_4 = var_0;

  if(!isDefined(var_3) || !var_3) {
    var_5 = target_getarray();

    if(var_5.size)
      var_5 = apache_ally_path_attack_filter_targets(var_0.origin, var_5, var_2);

    var_4 = common_scripts\utility::ter_op(var_5.size, var_5[0], var_0);
  }

  if(isai(var_4))
    heli_attack_mg(var_4, 6);
  else
    vehicle_attack_missile(var_4, var_1);
}

heli_attack_mg_veh_weapon(var_0, var_1) {
  self endon("death");
  self notify("heli_attack_mg_stop");
  self endon("heli_attack_mg_stop");
  self setturrettargetent(var_0);
  var_2 = 0.1;

  for(;;) {
    self fireweapon();
    wait(var_2);
    var_1 = var_1 - var_2;

    if(var_1 <= 0) {
      break;
    }
  }

  self clearturrettarget();
}

heli_attack_mg(var_0, var_1) {
  self endon("death");
  self notify("heli_attack_mg_stop");
  self endon("heli_attack_mg_stop");
  common_scripts\utility::array_call(self.mgturret, ::turretfireenable);
  common_scripts\utility::array_call(self.mgturret, ::settargetentity, var_0, (0, 0, 24));
  var_2 = 0.1;

  while(isalive(var_0)) {
    common_scripts\utility::array_call(self.mgturret, ::shootturret);
    wait(var_2);
    var_1 = var_1 - var_2;

    if(var_1 <= 0) {
      break;
    }
  }

  common_scripts\utility::array_call(self.mgturret, ::turretfiredisable);
  common_scripts\utility::array_call(self.mgturret, ::setmode, "manual");
}

vehicle_attack_missile(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  self notify("new_vehicle_attack_missile");
  self endon("new_vehicle_attack_missile");
  var_3 = common_scripts\utility::cointoss();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(issubstr(self.classname, "apache")) {
    var_4 = common_scripts\utility::ter_op(var_1, 2, 4);
    var_5 = common_scripts\utility::ter_op(var_1, "apache_lockon_missile_ai", "apache_hellfire_missile_ai");
    var_10 = undefined;
    var_6 = common_scripts\utility::ter_op(var_1, "tag_flash_11", "tag_flash_3");
    var_7 = common_scripts\utility::ter_op(var_1, "tag_flash_2", "tag_flash_22");
    var_8 = common_scripts\utility::ter_op(var_1, 0.6, 0.05);
    var_9 = 0;
  } else if(issubstr(self.classname, "hind")) {
    var_4 = common_scripts\utility::ter_op(var_1, 1, 2);
    var_5 = common_scripts\utility::ter_op(var_1, "apache_lockon_missile_ai_enemy", "apache_hellfire_missile_ai");
    var_10 = "hind_turret";
    var_6 = "tag_flash_left";
    var_7 = "tag_flash_right";
    var_8 = common_scripts\utility::ter_op(var_1, 0.6, 0.05);
    var_9 = 0;
  } else if(issubstr(self.classname, "_gunboat")) {
    var_4 = 1;
    var_5 = "apache_lockon_missile_ai_enemy";
    var_10 = undefined;
    var_6 = "tag_turret";
    var_7 = "tag_turret";
    var_8 = 0.6;
    var_9 = 1;
  } else
    return;

  var_4 = common_scripts\utility::ter_op(isDefined(var_2), var_2, var_4);
  var_11 = weaponfiretime(var_5);
  var_12 = var_0 common_scripts\utility::spawn_tag_origin();
  var_12 setCanDamage(0);

  if(isDefined(var_0.vehicletype)) {
    var_13 = undefined;

    if(var_0 maps\_vehicle::ishelicopter()) {
      var_14 = get_apache_player();

      if(isDefined(var_14) && var_0 == var_14) {
        var_13 = (0, 0, -96);

        if(var_1)
          level notify("homing_hint");
      } else
        var_13 = (0, 0, -128);
    } else
      var_13 = (0, 0, 48);

    var_12 linkto(var_0, "tag_origin", var_13, (0, 0, 0));
  } else if(isai(var_0)) {
    var_13 = (0, 0, 24);
    var_12 linkto(var_0, "tag_origin", var_13, (0, 0, 0));
  } else
    var_12 linkto(var_0);

  var_12.missiles_waiting = var_4;
  var_12.missiles_chasing = 0;

  if(!var_9)
    self setvehweapon(var_5);

  while(var_4 && isalive(var_0)) {
    if(gettime() > level.missiledialognext) {
      do_random_pilot_chatter("missile_fire");
      level.missiledialognext = gettime() + randomintrange(3000, 4500);
    }

    wait 0.55;

    if(!isalive(var_0)) {
      continue;
    }
    var_15 = common_scripts\utility::ter_op((var_4 + var_3) % 2, var_6, var_7);
    var_16 = undefined;

    if(!var_9)
      var_16 = self fireweapon(var_15, var_12);
    else {
      var_17 = self gettagorigin(var_15);
      var_18 = vectornormalize(var_0.origin - var_17);
      var_16 = magicbullet(var_5, var_17 + var_18 * 60, var_17 + var_18 * 120);
    }

    var_16 common_scripts\utility::missile_settargetandflightmode(var_12, "direct");
    playFX(common_scripts\utility::getfx("FX_apache_ai_hydra_rocket_flash_wv"), self gettagorigin(var_15), anglesToForward(self gettagangles(var_15)));
    attack_missile_set_up_and_notify(var_16, var_0, var_1, var_12);
    var_16 thread vehicle_attack_missile_dummy_delete(var_12);
    var_4--;

    if(var_4 > 0)
      wait(var_11 + var_8);
  }

  if(isDefined(var_10))
    self setvehweapon(var_10);
}

do_random_pilot_chatter(var_0) {
  if(!common_scripts\utility::flag("FLAG_apache_factory_finished")) {
    return;
  }
  if(!isDefined(self.apache_chatter)) {
    return;
  }
  if(!isDefined(self.apache_chatter[var_0])) {
    return;
  }
  if(!isDefined(level.player.riding_heli)) {
    return;
  }
  if(!self.apache_chatter_queue.size)
    self.apache_chatter_queue = common_scripts\utility::array_randomize(self.apache_chatter[var_0]);

  if(!isDefined(self.function_stack) || self.function_stack.size == 0) {
    var_1 = undefined;

    while(self.apache_chatter_queue.size) {
      var_1 = self.apache_chatter_queue[0];
      self.apache_chatter_queue = common_scripts\utility::array_remove(self.apache_chatter_queue, var_1);

      if(isDefined(self.apache_chatter_last[var_1]) && gettime() - self.apache_chatter_last[var_1] < 10000) {
        var_1 = undefined;
        continue;
      }

      break;
    }

    if(isDefined(var_1)) {
      self.apache_chatter_last[var_1] = gettime();
      thread maps\_utility::smart_radio_dialogue(var_1);
    }
  }
}

attack_missile_set_up_and_notify(var_0, var_1, var_2, var_3) {
  if(var_2)
    var_0.type_missile = "guided";
  else
    var_0.type_missile = "straight";

  var_0 thread vehicle_scripts\_chopper_missile_defense_utility::missile_monitormisstarget(var_1, 0, undefined, "LISTEN_missile_missed_target", "LISTEN_missile_attached_to_flare");
  var_0 childthread earthquake_on_death_missile();
  self notify("LISTEN_missile_fire_self", var_0);

  if(isDefined(var_1.heli) && isDefined(var_1.heli.owner) && isplayer(var_1.heli.owner))
    var_1.heli.owner notify("LISTEN_missile_fire", var_0);
  else
    var_1 notify("LISTEN_missile_fire", var_0);
}

ai_attack_missile(var_0, var_1) {
  var_2 = self gettagorigin("tag_eye");
  var_3 = vectornormalize(var_0.origin - var_2);
  var_4 = var_2 + var_3 * 36;
  var_5 = var_2 + var_3 * 120;
  var_6 = (0, 0, 0);

  if(var_0 maps\_vehicle::isvehicle() && var_0 maps\_vehicle::ishelicopter()) {
    if(var_0 == get_apache_player()) {
      if(var_1)
        level notify("homing_hint");

      var_6 = (0, 0, -96);
    } else
      var_6 = (0, 0, -48);
  }

  var_7 = magicbullet("apache_lockon_missile_ai_enemy", var_4, var_5);
  var_7 common_scripts\utility::missile_settargetandflightmode(var_0, "top", var_6);
  playFX(common_scripts\utility::getfx("FX_apache_ai_hydra_rocket_flash_wv"), var_4, vectornormalize(var_5 - var_4));
  attack_missile_set_up_and_notify(var_7, var_0, var_1);
}

vehicle_attack_missile_dummy_delete(var_0) {
  var_1 = self;
  var_0.missiles_waiting--;
  var_0.missiles_chasing++;
  var_1 waittill("death");
  var_0.missiles_chasing--;

  if(var_0.missiles_waiting > 0) {
    return;
  }
  if(var_0.missiles_chasing <= 0) {
    var_0 unlink();
    wait 0.05;
    var_0 delete();
  }
}

apache_ally_path_attack_filter_targets(var_0, var_1, var_2) {
  if(!var_1.size)
    return var_1;

  return common_scripts\utility::get_array_of_closest(var_0, var_1, undefined, undefined, var_2);
}

spawn_apache_allies(var_0) {
  level.helicopter_firelinkfunk = ::apache_ally_path_attack_func;
  var_1 = [];
  var_2 = [1, 2];
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    var_7 = common_scripts\utility::getstruct(var_0 + var_6, "targetname");
    var_1[var_1.size] = spawn_apache_ally(var_6, var_7.origin, var_7.angles);
  }

  return var_1;
}

spawn_apache_ally(var_0, var_1, var_2) {
  var_3 = "apache_ally_spawner_0" + var_0;
  var_4 = "apache_ally_0" + var_0;
  var_5 = getent(var_4, "targetname");

  if(isDefined(var_5)) {
    var_5 vehicle_teleport(var_1, var_2);
    return var_5;
  }

  return spawn_apache_ally_targetname(var_3, var_4, var_1, var_2);
}

spawn_apache_ally_targetname(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  var_4.origin = common_scripts\utility::ter_op(isDefined(var_2), var_2, var_4.origin);
  var_4.angles = common_scripts\utility::ter_op(isDefined(var_3), var_3, var_4.angles);
  var_5 = maps\_vehicle::vehicle_spawn(var_4);
  var_5.targetname = var_1;
  var_5.script_noteworthy = "apache_allies";
  var_5 assign_chatter();
  var_5.godmode = 1;
  var_5 maps\_utility::ent_flag_init("apache_ally_attack_override");
  var_5 heli_ai_collision_cylinder_add();
  var_5 notify("stop_kicking_up_dust");
  var_5.missiledefense = vehicle_scripts\_chopper_ai_missile_defense::_init(var_5, 3);
  var_5.missiledefense thread vehicle_scripts\_chopper_ai_missile_defense::_start();
  var_5 thread self_make_chopper_boss();
  return var_5;
}

assign_chatter() {
  self.apache_chatter = [];

  if(self.targetname == "apache_ally_01") {
    self.apache_chatter["missile_fire"] = ["oilrocks_hp1_missileloose", "oilrocks_hp1_firingmissile"];
    self.apache_chatter["missile_confirm"] = ["oilrocks_hp1_goodmissile", "oilrocks_hp1_goodhitgoodhit", "oilrocks_hp1_yougothim", "oilrocks_hp1_goodengagement"];
    self.apache_chatter["other_player_kill_confirm"] = ["oilrocks_hp1_goodhitgoodhit", "oilrocks_hp1_yougothim", "oilrocks_hp1_goodengagement"];
    self.apache_chatter["flares_out"] = ["oilrocks_hp1_flaresout", "oilrocks_hp1_flaring", "oilrocks_hp1_flaresaway"];
  } else {
    self.apache_chatter["missile_fire"] = ["oilrocks_hp0_solidboxsolidbox", "oilrocks_hp0_firing", "oilrocks_hp2_missileloose", "oilrocks_hp2_missileout", "oilrocks_hp2_firingmissiles", "oilrocks_hp2_missileaway"];
    self.apache_chatter["flares_out"] = ["oilrocks_hp0_shitmantheygot", "oilrocks_hp2_missileincoming", "oilrocks_hp2_missileonyourten", "oilrocks_hp2_missile3oclock", "oilrocks_hp2_gotamissileincoming", "oilrocks_hp2_incomingmissilehangon"];
  }

  self.apache_chatter_queue = [];
  self.apache_chatter_last = [];
}

get_apache_players() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2.drivingvehicle) && var_2.drivingvehicle maps\_vehicle::ishelicopter())
      var_0[var_0.size] = var_2.drivingvehicle;
  }

  return var_0;
}

get_apache_allies() {
  var_0 = getEntArray("apache_allies", "script_noteworthy");
  return var_0;
}

get_apache_ally(var_0) {
  var_1 = getent("apache_ally_0" + var_0, "targetname");
  return var_1;
}

get_apache_ally_id() {
  return int(getsubstr(self.targetname, self.targetname.size - 1));
}

get_apache_player() {
  return getent("apache_player", "targetname");
}

is_apache_player(var_0) {
  var_1 = get_apache_player();
  return isDefined(var_0) && isDefined(var_1) && var_1 == var_0;
}

friendly_setup_apache_section(var_0) {
  thread on_damage_turret_push_friendly_fire(var_0);
}

spawn_blackhawk_ally(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = undefined;

  if(isDefined(var_0))
    var_4 = common_scripts\utility::getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    var_4 = spawnStruct();
    var_4.origin = var_1;
  }

  if(isDefined(var_2))
    var_4.angles = var_2;

  var_5 = getent("blackhawk_ally_spawner", "targetname");
  var_5.script_allow_rider_deaths = 0;
  var_5.origin = var_4.origin;
  var_5.angles = var_4.angles;
  var_6 = maps\_vehicle::vehicle_spawn(var_5);
  var_6.targetname = "blackhawk_ally";
  var_6.script_noteworthy = "blackhawk_ally";
  var_6 maps\_vehicle::godon();
  var_6 heli_ai_collision_cylinder_add();
  var_6 notify("stop_kicking_up_dust");

  if(var_3) {
    var_7 = getEntArray("blackhawk_riders", "script_noteworthy");
    common_scripts\utility::array_thread(var_7, maps\_utility::add_spawn_function, ::asign_blackhawk_riders);
    spawn_infantry_in_blackhawk();
  }

  foreach(var_9 in var_6.riders) {
    if(!isai(var_9))
      var_9 setCanDamage(0);
  }

  return var_6;
}

spawn_infantry_in_blackhawk() {
  var_0 = get_blackhawk_ally();
  var_1 = maps\oilrocks_code::spawn_infantry_friends(1);

  foreach(var_3 in var_1) {
    var_3 friendly_setup_apache_section(10);
    var_0 maps\_utility::guy_enter_vehicle(var_3);
  }
}

asign_blackhawk_riders() {
  if(!isDefined(level.infantry_guys))
    level.infantry_guys = [];
  else
    level.infantry_guys = maps\oilrocks_code::array_remove_undefined_dead_or_dying(level.infantry_guys);

  if(isDefined(self.script_friendname) && self.script_friendname == "Logan") {
    self.script_friendname = undefined;
    level.heroguy = self;
  }

  level.infantry_guys = common_scripts\utility::array_add(level.infantry_guys, self);
}

get_blackhawk_ally() {
  var_0 = getent("blackhawk_ally", "targetname");
  return var_0;
}

get_apaches_ally_and_player() {
  return common_scripts\utility::array_combine(get_apache_allies(), get_apache_players());
}

get_hinds_enemy_active() {
  var_0 = getEntArray("enemy_hinds_active", "script_noteworthy");

  if(!var_0.size) {
    foreach(var_2 in vehicle_getarray()) {
      if(isalive(var_2)) {
        if(isDefined(var_2.script_team) && var_2.script_team == "axis") {
          if(!isDefined(var_2.crashing) || !var_2.crashing)
            var_0[var_0.size] = var_2;
        }
      }
    }
  }

  return var_0;
}

heli_ai_collision_cylinder_setup() {
  level.heli_collision_ai = getEntArray("heli_collision_ai_mesh", "targetname");

  foreach(var_1 in level.heli_collision_ai) {
    var_1.start_origin = var_1.origin;
    var_1.start_angles = var_1.angles;
    var_1.in_use = 0;
  }
}

heli_ai_collision_cylinder_add() {
  var_0 = undefined;

  foreach(var_2 in level.heli_collision_ai) {
    if(!var_2.in_use)
      var_0 = var_2;
  }

  if(isDefined(var_0)) {
    var_0.in_use = 1;
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 linkto(self, "tag_origin");
    thread heli_ai_collision_cylinder_on_death_remove(var_0);
  }
}

heli_ai_collision_cylinder_on_death_remove(var_0) {
  self waittill("death");
  var_0 unlink();
  var_0.origin = var_0.start_origin;
  var_0.angles = var_0.start_angles;
  var_0.in_use = 0;
}

add_as_apache_target_on_spawn() {
  thread _add_as_apache_target_on_spawn_iternal();
}

_add_as_apache_target_on_spawn_iternal() {
  if(isDefined(level.player.riding_heli) && self == level.player.riding_heli) {
    return;
  }
  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "addastargetonflag")) {
    self endon("death");
    maps\_utility::ent_flag_init("ENT_FLAG_add_as_target");
    maps\_utility::ent_flag_wait("ENT_FLAG_add_as_target");
  }

  add_as_apaches_target();
}

add_as_apaches_target(var_0) {
  if(!isDefined(level.apache_target_manager))
    level.apache_target_manager = [];

  level.apache_target_manager[level.apache_target_manager.size] = self;
  level.apache_target_manager = maps\oilrocks_code::array_remove_undefined_dead_or_dying(level.apache_target_manager);
  var_1 = get_apache_players();

  foreach(var_3 in var_1)
  thread maps\oilrocks_code::addasapachehudtarget(var_3, var_0);
}

update_targets(var_0) {
  if(!isDefined(level.apache_target_manager)) {
    return;
  }
  level.apache_target_manager = maps\oilrocks_code::array_remove_undefined_dead_or_dying(level.apache_target_manager);
  level.apache_target_manager = common_scripts\utility::get_array_of_closest(level.player getEye(), level.apache_target_manager);
  var_1 = get_apache_players();

  foreach(var_3 in var_1) {
    foreach(var_5 in level.apache_target_manager)
    var_5 maps\oilrocks_code::addasapachehudtarget(var_3, var_0);
  }
}

ai_waittill_entered_vehicle() {
  if(!isDefined(self.ridingvehicle))
    common_scripts\utility::waittill_any("death", "enteredvehicle");

  while(isalive(self) && !isDefined(self.ridingvehicle))
    wait 0.05;

  if(!isalive(self))
    return 0;

  return 1;
}

ai_rider_invulnerable_until_vehicle_death() {
  var_0 = ai_waittill_entered_vehicle();

  if(!var_0) {
    return;
  }
  self endon("death");
  self endon("jumping_out");
  maps\_utility::deletable_magic_bullet_shield();
  thread ai_rider_invulnerable_until_vehicle_death_or_jumping_out();
  self.ridingvehicle waittill("death");
  maps\_utility::stop_magic_bullet_shield();
}

ai_rider_invulnerable_until_vehicle_death_or_jumping_out() {
  self endon("death");
  self endon("stop_magic_bullet_shield");
  self waittill("jumping_out");
  maps\_utility::stop_magic_bullet_shield();
}

vehicle_spawner_adjust_health_and_damage() {
  if(!issubstr(self.classname, "_apache_player"))
    maps\_utility::add_spawn_function(::friendly_fire_enable);

  var_0 = 0;
  var_1 = 1;
  var_2 = undefined;
  var_3 = undefined;

  if(issubstr(self.classname, "_hind_")) {
    var_3 = level.apache_difficulty.enemy_hind_health;
    var_1 = 1;
    var_2 = 1.0;
    var_0 = 1;
  } else if(issubstr(self.classname, "m800")) {
    var_3 = level.apache_difficulty.enemy_m800_health;
    maps\_utility::add_spawn_function(::turn_engine_off_on_spawn);
    var_0 = 1;
  } else if(issubstr(self.classname, "_gaz_")) {
    var_3 = level.apache_difficulty.enemy_gaz_health;
    var_0 = 1;
    maps\_utility::add_spawn_function(::turn_engine_off_on_spawn);
  } else if(issubstr(self.classname, "_zpu4")) {
    var_3 = level.apache_difficulty.enemy_zpu_health;
    var_0 = 1;
  } else if(issubstr(self.classname, "_gunboat")) {
    var_3 = level.apache_difficulty.enemy_gunboat_health;
    var_0 = 1;
    maps\_utility::add_spawn_function(::turn_engine_off_on_spawn);
  } else
    return;

  if(!isDefined(self.script_startinghealth))
    self.script_startinghealth = var_3;

  if(var_0)
    maps\_utility::add_spawn_function(::enemy_adjust_missile_damage, var_1, var_2);

  maps\_utility::add_spawn_function(::earthquake_on_death);
}

turn_engine_off_on_spawn() {
  self vehicle_turnengineoff();
}

friendly_fire_enable() {
  self.team = self.script_team;
  level thread maps\_friendlyfire::friendly_fire_think(self);
}

enemy_adjust_missile_damage(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  var_2 = self.health - self.healthbuffer;
  var_3 = var_2 / var_0 + 1;

  for(;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8);

    if(isDefined(self.one_missile_kill) && (var_8 == "MOD_PROJECTILE" || var_8 == "MOD_PROJECTILE_SPLASH")) {
      if(maps\_vehicle::isvehicle() && maps\_vehicle::ishelicopter()) {
        self.enablerocketdeath = 1;
        self.alwaysrocketdeath = 1;
      }

      maps\_vehicle::godoff();
      self dodamage(var_2 + 100, self.origin, var_5);
      return;
    }

    if(isDefined(var_5) && isplayer(var_5) && isDefined(var_8) && (var_8 == "MOD_PROJECTILE" || var_8 == "MOD_PROJECTILE_SPLASH")) {
      var_9 = max(0, var_3 - var_4);
      var_10 = common_scripts\utility::ter_op(isDefined(var_7), var_7, self.origin);

      if(var_9) {
        if(self.health - self.healthbuffer - var_9 <= 0 && maps\_vehicle::isvehicle() && maps\_vehicle::ishelicopter()) {
          self.enablerocketdeath = 1;
          self.alwaysrocketdeath = 1;
        }

        self dodamage(var_9, var_10, var_5);

        if(isDefined(var_1))
          wait(var_1);
      }
    }
  }
}

vehicle_ai_turret_think() {
  self endon("death");
  var_0 = 0;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(issubstr(self.classname, "_gaz_")) {
    var_1 = self.mgturret[0];
    var_2 = 0;
    var_3 = 3;
  } else if(issubstr(self.classname, "_gunboat")) {
    var_2 = 1;
    var_1 = self.mgturret[0];
  }

  var_1 settoparc(90);
  var_4 = undefined;

  if(isDefined(var_3)) {
    foreach(var_6 in self.riders) {
      if(isDefined(var_6.vehicle_position) && var_6.vehicle_position == var_3 || isDefined(var_6.script_startingposition) && var_6.script_startingposition == var_3) {
        var_4 = var_6;
        break;
      }
    }

    if(isDefined(var_4)) {
      var_4 endon("death");
      var_4 thread ai_rider_invulnerable_until_vehicle_death();
    }
  }

  var_1.disablereload = 1;

  if(isDefined(var_4))
    var_4 thread vehicle_ai_turret_gunner_ignore_all_until_unload();

  var_1 setmode("manual");

  while(isDefined(self)) {
    var_8 = vehicle_ai_turret_get_target();

    if(isDefined(var_8)) {
      var_9 = var_2;

      if(var_2) {
        if(isDefined(self.vehicle_ai_turret_think_next_missile_time) && gettime() < self.vehicle_ai_turret_think_next_missile_time)
          var_9 = 0;
        else if(isDefined(var_8.veh_missiles_targeting) && var_8.veh_missiles_targeting > 0)
          var_9 = 0;
        else if(!is_apache_player(var_8) && randomfloat(1.0) <= level.apache_difficulty.gunboat_chance_fire_missile_at_ai)
          var_9 = 0;
      }

      thread vehicle_ai_turret_register_target(var_8, var_9);

      if(var_9) {
        if(is_apache_player(var_8))
          missile_attack_notify_target_of_lock_and_delay(var_8);

        vehicle_attack_missile(var_8, 1);
        self.vehicle_ai_turret_think_next_missile_time = gettime() + level.apache_difficulty.gunboat_time_between_missiles_msec;
      } else {
        var_1 turretfireenable();
        vehicle_ai_turret_shoot_target(var_8, var_1, var_4);
        var_1 turretfiredisable();
      }

      self notify("LISTEN_veh_turret_finished_targeting");
    }

    wait(randomfloatrange(0.2, 0.4));
  }
}

missile_attack_notify_target_of_lock_and_delay(var_0) {
  var_1 = var_0.heli.owner;
  var_1 notify("LISTEN_missile_lockOn", self);
  var_2 = common_scripts\utility::waittill_any_timeout(level.apache_difficulty.vehicle_vs_player_lock_on_time, "death", "deathspin");

  if(var_2 == "death" || var_2 == "deathspin") {
    self notify("LISTEN_missile_lockOnFailed");
    return 0;
  }
}

vehicle_ai_turret_gunner_ignore_all_until_unload() {
  self endon("death");
  self.ignoreall = 1;
  self waittill("unload");
  self.ignoreall = 0;
}

vehicle_ai_turret_get_target() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = maps\oilrocks_code::getteam();

  if(var_2 == "axis") {
    var_0 = get_apaches_ally_and_player();
    var_1 = getaiarray("allies");
  } else if(var_2 == "allies") {
    var_0 = get_hinds_enemy_active();
    var_1 = getaiarray("axis");
  }

  var_3 = [];

  foreach(var_5 in var_0) {
    if(vehicle_ai_turret_can_target(var_5))
      var_3[var_3.size] = var_5;
  }

  foreach(var_5 in var_1) {
    if(vehicle_ai_turret_can_target(var_5))
      var_3[var_3.size] = var_5;
  }

  var_9 = [];
  var_9["none"] = var_3;
  var_10 = undefined;
  var_11 = "none";

  if(!var_3.size)
    return undefined;

  var_3 = sortbydistance(var_3, self.origin);
  var_3 = common_scripts\utility::array_sort_by_handler(var_3, ::get_vehicle_turrets_targeting);
  var_12 = get_apache_player();
  var_13 = 1;

  foreach(var_5 in var_3) {
    var_15 = var_5 get_vehicle_turrets_targeting();

    if(!isDefined(var_13))
      var_13 = var_15;
    else if(var_15 > var_13) {
      break;
    }

    if(isDefined(var_12) && var_5 == var_12) {
      var_10 = var_5;
      break;
    }
  }

  if(!isDefined(var_10))
    var_10 = var_3[0];

  return var_10;
}

vehicle_ai_turret_get_target_type() {
  var_0 = undefined;

  if(maps\_vehicle::isvehicle())
    var_0 = "vehicle";
  else if(isai(self))
    var_0 = "ai";
  else {}

  return var_0;
}

vehicle_ai_turret_can_target(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.ignoreme) && var_0.ignoreme)
    return 0;

  if(isDefined(var_0.ridingvehicle))
    return 0;

  if(distancesquared(self.origin, var_0.origin) > level.apache_difficulty.veh_turret_range_squared)
    return 0;

  return 1;
}

get_vehicle_turrets_targeting() {
  return common_scripts\utility::ter_op(isDefined(self.veh_turrets_targeting), self.veh_turrets_targeting, 0);
}

vehicle_ai_turret_register_target(var_0, var_1) {
  if(!isDefined(var_0.veh_turrets_targeting))
    var_0.veh_turrets_targeting = 0;

  if(!isDefined(var_0.veh_missiles_targeting))
    var_0.veh_missiles_targeting = 0;

  var_0.veh_turrets_targeting++;

  if(var_1)
    var_0.veh_missiles_targeting++;

  common_scripts\utility::waittill_either("death", "LISTEN_veh_turret_finished_targeting");

  if(!isDefined(var_0)) {
    return;
  }
  var_0.veh_turrets_targeting--;

  if(var_1)
    var_0.veh_missiles_targeting--;

  if(var_1) {}

  if(isDefined(var_0.veh_turrets_targeting) && var_0.veh_turrets_targeting <= 0)
    var_0.veh_turrets_targeting = undefined;

  if(isDefined(var_0.veh_missiles_targeting) && var_0.veh_missiles_targeting <= 0)
    var_0.veh_missiles_targeting = undefined;
}

vehicle_ai_turret_shoot_target(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if(isDefined(var_2))
    var_2 endon("death");

  var_3 = get_apache_player();
  var_4 = 0;

  if(isplayer(var_0) || isDefined(var_3) && var_3 == var_0)
    var_4 = 1;

  var_1 settargetentity(var_0);
  var_5 = 0;

  if(var_4)
    var_5 = 70;
  else
    var_5 = randomintrange(25, 35);

  var_6 = undefined;

  foreach(var_9, var_8 in self.mgturret) {
    if(var_8 == var_1) {
      var_6 = var_9;
      break;
    }
  }

  var_10 = 0.05;

  if(isDefined(var_6)) {
    var_11 = level.vehicle_mgturret[self.classname][var_6];

    if(isDefined(var_11))
      var_10 = weaponfiretime(var_11.info);
  }

  var_12 = undefined;
  var_13 = undefined;

  if(!var_4)
    var_13 = vehicle_ai_turret_get_fx_shoot_flash();

  if(isDefined(var_13)) {
    var_10 = max(var_10, 0.15);
    var_14 = var_1 gettagangles("tag_flash");

    for(var_15 = 0; var_15 < var_5; var_15++) {
      var_16 = var_1 gettagorigin("tag_flash");
      var_17 = var_1 gettagangles("tag_flash");
      var_18 = anglesToForward(var_17);
      bullettracer(var_16, var_16 + var_18 * 10000, 1);

      if(var_15 % 2 == 0)
        playFXOnTag(common_scripts\utility::getfx(var_13), var_1, "tag_flash");

      wait(var_10);
    }
  } else if(isDefined(var_2)) {
    var_10 = max(var_10, 0.1);

    for(var_15 = 0; var_15 < var_5; var_15++) {
      var_1 shootturret();
      wait(var_10);
    }
  } else {
    var_1 startfiring();
    wait(var_5 * var_10);
    var_1 stopfiring();
  }
}

vehicle_ai_turret_get_fx_shoot_flash() {
  var_0 = undefined;

  if(issubstr(self.classname, "_gaz_"))
    var_0 = "FX_oilrocks_turret_flash_gaz";
  else if(issubstr(self.classname, "_gunboat"))
    var_0 = "FX_oilrocks_turret_flash_gunboat";
  else if(issubstr(self.classname, "_zpu4"))
    var_0 = "FX_oilrocks_turret_flash_zpu";
  else {}

  return var_0;
}

chopper_ai_init() {
  level.missiledialognext = gettime();
  level.engagementcomplimentdialognext = gettime();
  precacheitem("apache_lockon_missile_ai");
  precacheitem("apache_lockon_missile_ai_enemy");
  maps\_utility::add_global_spawn_function("axis", ::add_as_apache_target_on_spawn);
  maps\_utility::add_global_spawn_function("allies", ::add_as_apache_target_on_spawn);
  maps\_utility::add_global_spawn_function("allies", maps\oilrocks_code::friendly_setup);
  common_scripts\utility::array_thread(maps\_utility::getvehiclespawnerarray(), ::vehicle_spawner_adjust_health_and_damage);

  foreach(var_1 in getspawnerarray()) {
    if(!isDefined(var_1.script_spawn_pool)) {
      continue;
    }
    if(issubstr(var_1.script_spawn_pool, "infantry")) {
      continue;
    }
    var_1 maps\_utility::add_spawn_function(::ai_record_spawn_pos, undefined);
    var_1 maps\_utility::add_spawn_function(::enemy_infantry_set_up_on_spawn, undefined);

    if(issubstr(var_1.script_spawn_pool, "_rpg")) {
      var_1 maps\_utility::add_spawn_function(::enemy_infantry_rpg_only);
      var_1 maps\_utility::add_spawn_function(::rpg_ai_record_ready);
    }
  }

  maps\_chopperboss::chopper_boss_locs_populate("script_noteworthy", "heli_nav_mesh");
  maps\_chopperboss::init();
  level.chopperboss_const["default"]["max_target_dist2d"] = 12072;
  thread manage_all_rpg_ai_attack_player_think();
  level.apache_chatter_func = ::do_random_pilot_chatter;
  level.disablemovementtracker = 1;
  common_scripts\utility::array_thread(getEntArray("damageable_exploder_rooftanks", "script_noteworthy"), ::setup_damageable_exploder_rooftanks);
}

setup_damageable_exploder_rooftanks() {
  self setCanDamage(1);
  thread maps\_utility::generic_damage_think();
  maps\_utility::add_damage_function(::damageable_exploder_rooftanks);
}

damageable_exploder_rooftanks(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self.accumulated_damage))
    self.accumulated_damage = 0;

  self.accumulated_damage = self.accumulated_damage + var_0;

  if(self.accumulated_damage > 3330 || var_4 == "MOD_PROJECTILE") {
    self notify("stop_generic_damage_think");

    if(isDefined(self.script_exploder))
      common_scripts\utility::exploder(self.script_exploder);
  }
}

manage_active_hind_forced_targets() {
  var_0 = self;
  var_0 endon("death");
  self endon("death");

  for(;;) {
    var_1 = get_hinds_enemy_active();

    if(var_1.size) {
      var_2 = undefined;

      if(var_1.size == 1)
        var_1[0] dot_to_apache_player_facing_2d();
      else
        var_1 = common_scripts\utility::array_sort_by_handler(var_1, ::dot_to_apache_player_facing_2d_inverse);

      foreach(var_4 in var_1) {
        if(var_4.dot_to_apache_player_facing_2d >= 0.25) {
          var_2 = var_4;
          break;
        }
      }

      if(!isDefined(var_2)) {
        var_1 = sortbydistance(var_1, var_0.origin);
        var_2 = var_1[0];
      }

      var_2 maps\_chopperboss_utility::chopper_boss_forced_target_set(var_0);
      common_scripts\utility::waittill_any_timeout(3, "death", "deathspin", "chopper_done_shooting");

      if(isDefined(var_2)) {
        var_2 maps\_chopperboss_utility::chopper_boss_forced_target_clear();
        continue;
      }
    }

    wait 0.05;
  }
}

dot_to_apache_player_facing_2d_inverse() {
  var_0 = 0;
  var_1 = get_apache_player();

  if(isDefined(var_1))
    var_0 = -1.0 * dot_to_apache_player_facing_2d();

  return var_0;
}

dot_to_apache_player_facing_2d() {
  self.dot_to_apache_player_facing_2d = 0;
  var_0 = get_apache_player();

  if(isDefined(var_0)) {
    var_1 = anglesToForward((0, var_0.angles[1], 0));
    var_2 = vectornormalize((self.origin[0], self.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
    self.dot_to_apache_player_facing_2d = vectordot(var_1, var_2);
  }

  return self.dot_to_apache_player_facing_2d;
}

heli_ai_gather_targets() {
  var_0 = [];

  if(self.script_team == "allies") {
    var_0 = common_scripts\utility::array_combine(var_0, get_hinds_enemy_active());

    if(!var_0.size) {
      var_1 = getaiarray("axis");
      var_2 = [];

      foreach(var_4 in var_1) {
        if(isDefined(var_4.ignoreme) && var_4.ignoreme) {
          continue;
        }
        var_2[var_2.size] = var_4;
      }

      var_0 = common_scripts\utility::array_combine(var_0, var_2);
    }
  } else
    var_0 = common_scripts\utility::array_combine(var_0, get_apaches_ally_and_player());

  return var_0;
}

heli_ai_can_hit_target(var_0, var_1) {
  var_2 = self getpointinbounds(1, 0, 0);

  if(isDefined(self.mgturret) && self.mgturret.size > 0)
    return maps\_chopperboss_utility::chopper_boss_can_hit_from_mgturret(var_2, var_1);

  return 1;
}

heli_decides_to_shoot_missile_at_ai(var_0) {
  if(!isDefined(level.last_heli_decides_to_shoot_missile_at_ai_time))
    level.last_heli_decides_to_shoot_missile_at_ai_time = gettime();

  if(gettime() - level.last_heli_decides_to_shoot_missile_at_ai_time < 5000)
    return 0;

  if(common_scripts\utility::cointoss())
    return 0;

  if(distance2dsquared(level.player.origin, var_0.origin) < 9000000)
    return 0;

  level.last_heli_decides_to_shoot_missile_at_ai_time = gettime();
  return 1;
}

heli_ai_shoot_target(var_0) {
  var_1 = 1;

  if(isai(var_0) && !heli_decides_to_shoot_missile_at_ai(var_0))
    var_1 = 0;
  else if(isDefined(self.heli_ai_shoot_missile_time_next) && gettime() < self.heli_ai_shoot_missile_time_next)
    var_1 = 0;
  else if(common_scripts\utility::distance_2d_squared(self.origin, var_0.origin) <= level.apache_difficulty.heli_vs_heli_mg_range_2d_squared)
    var_1 = 0;

  if(var_1) {
    if(is_apache_player(var_0)) {
      missile_attack_notify_target_of_lock_and_delay(var_0);

      if(!isDefined(var_0))
        return 0;
    }

    vehicle_attack_missile(var_0, 1, 1);
    self.heli_ai_shoot_missile_time_next = gettime() + randomfloatrange(level.apache_difficulty.heli_vs_heli_min_shoot_time_msec, level.apache_difficulty.heli_vs_heli_max_shoot_time_msec);
  } else if(isDefined(self.mgturret))
    heli_attack_mg(var_0, 3.0);
  else
    heli_attack_mg_veh_weapon(var_0, 3.0);

  return 1;
}

heli_ai_pre_move_func() {
  var_0 = maps\_chopperboss::pause_action();

  if(isDefined(maps\_chopperboss_utility::chopper_boss_forced_target_get()))
    self setlookatent(maps\_chopperboss_utility::chopper_boss_forced_target_get());
  else if(isalive(self.heli_target)) {
    self setlookatent(self.heli_target);
    self.last_heli_lookat_origin = self.heli_target.origin;
  } else
    self clearlookatent();
}

spawn_hind_enemy(var_0) {
  var_1 = getent("hind_enemy", "targetname");
  var_1 vehicle_spawner_adjust_health_and_damage();

  while(isDefined(var_1.vehicle_spawned_thisframe))
    wait 0.05;

  if(isDefined(var_0)) {
    var_1.origin = var_0.origin;

    if(isDefined(var_0.angles))
      var_1.angles = var_0.angles;
  }

  var_2 = maps\_vehicle::vehicle_spawn(var_1);
  var_2.script_noteworthy = "enemy_hinds_active";
  var_2.enablerocketdeath = 1;
  var_2.missiledefense = vehicle_scripts\_chopper_ai_missile_defense::_init(var_2);
  var_2.missiledefense thread vehicle_scripts\_chopper_ai_missile_defense::_start();
  var_2 vehicle_setspeed(80, 50, 50);
  var_2 thread hind_manage_damage_states();
  var_2 heli_ai_collision_cylinder_add();
  return var_2;
}

choper_fly_in_think(var_0) {
  self endon("death");
  self setlookatent(level.player);
  thread self_make_chopper_boss();
  thread maps\oilrocks_code::chopper_boss_path_override(var_0);
}

self_make_chopper_boss(var_0, var_1) {
  level endon("stop_chopper_boss_forever");
  self endon("death");

  if(!isDefined(var_0)) {
    for(;;) {
      var_0 = maps\_chopperboss_utility::chopper_boss_get_closest_available_path_struct_2d(self.origin);

      if(isDefined(var_0)) {
        break;
      }

      wait 0.05;
    }
  }

  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);

  if(var_1) {
    var_0.in_use = 1;
    thread maps\_vehicle::vehicle_paths(var_0);
    self waittill("reached_dynamic_path_end");
    var_0.in_use = undefined;
  }

  if(!isDefined(level.chopperboss_const[self.classname])) {
    maps\_chopperboss_utility::build_data_override("min_target_dist2d", 350);
    maps\_chopperboss_utility::build_data_override("max_target_dist2d", 8192);
    maps\_chopperboss_utility::build_data_override("get_targets_func", ::heli_ai_gather_targets);
    maps\_chopperboss_utility::build_data_override("tracecheck_func", ::heli_ai_can_hit_target);
    maps\_chopperboss_utility::build_data_override("fire_func", ::heli_ai_shoot_target);
    maps\_chopperboss_utility::build_data_override("pre_move_func", ::heli_ai_pre_move_func);
  }

  childthread maps\_chopperboss::chopper_boss_think(var_0, 1);
  childthread maps\_chopperboss::chopper_boss_agro_chopper();
}

hind_manage_damage_states() {
  self endon("death");
  self endon("deathspin");
  var_0 = self.health - self.healthbuffer;
  var_1 = 0;

  for(;;) {
    var_2 = self.health - self.healthbuffer;

    if(var_2 <= var_0 * 0.5)
      playFXOnTag(common_scripts\utility::getfx("FX_hind_damaged_smoke_heavy"), self, "tag_deathfx");

    wait 0.05;
  }
}

ai_clean_up(var_0, var_1) {
  self notify("ai_clean_up");
  self endon("ai_clean_up");
  self endon("death");
  var_0 = common_scripts\utility::ter_op(isDefined(var_0), var_0, 1);
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 1);
  var_2 = 1;

  if(!isDefined(self.ai_pos_start) || !isai(self) || isDefined(self.script_vehicleride) || isDefined(self.ridingvehicle) || common_scripts\utility::distance_2d_squared(self.origin, self.ai_pos_start) > squared(1600))
    var_2 = 0;

  if(var_2) {
    self notify("stop_going_to_node");
    self.ignoreall = 1;
    self.goalradius = 32;
    self setgoalpos(self.ai_pos_start);
    common_scripts\utility::waittill_any_timeout(25, "goal", "bad_path");
  }

  if(var_1) {
    while(maps\_utility::player_looking_at(self.origin, undefined, 1))
      wait 0.05;
  }

  var_3 = get_apache_player();

  if(isDefined(var_3))
    var_3 thread vehicle_scripts\_apache_player::hud_hidetargets([self]);

  if(var_0)
    self delete();
  else
    self kill(self.origin);
}

rpg_ai_record_ready() {
  if(isDefined(self.script_forcegoal)) {
    self endon("death");
    self waittill("goal");
  }

  self.rpg_ai_in_position = 1;
}

enemy_infantry_rpg_only() {
  self.secondaryweapon = "none";
  thread maps\oilrocks_code::giveunlimitedrpgammo();
}

enemy_infantry_set_up_on_spawn() {
  maps\_utility::disable_long_death();
}

ai_record_spawn_pos() {
  self.ai_pos_start = self.origin;
}

start_apache_common() {
  maps\oilrocks_apache_difficulty::apache_mission_difficulty();
  apache_mission_heli_ai_collision();
  thread maps\oilrocks_apache_vo::apache_mission_vo_player_crashing();
}

destructible_quakes_on() {
  level.fast_destructible_explode = 1;
  var_0 = getEntArray("destructible_vehicle", "targetname");
  common_scripts\utility::array_thread(var_0, ::destructible_force_explode_on);
  thread earthquake_player_missile_monitor("LISTEN_heli_end");
  thread earthquake_destructibles_monitor("LISTEN_heli_end");
  self waittill("LISTEN_heli_end");
  destructible_quakes_off();
}

destructible_quakes_off() {
  var_0 = getEntArray("destructible_vehicle", "targetname");
  common_scripts\utility::array_thread(var_0, ::destructible_force_explode_off);
  level.fast_destructible_explode = 0;
}

destructible_force_explode_on() {
  self.forceexploding = 1;
}

destructible_force_explode_off() {
  self.forceexploding = undefined;
}

earthquake_destructibles_monitor(var_0) {
  self endon(var_0);

  for(;;) {
    level waittill("destructible_exploded", var_1, var_2);

    if(!isDefined(var_2) || !isDefined(var_1)) {
      continue;
    }
    if(!earthquake_valid_entity(var_1, var_2)) {
      continue;
    }
    earthquake_player(var_1.origin);
  }
}

earthquake_player(var_0) {
  var_1 = level.player getEye();
  var_2 = clamp(distancesquared(var_1, var_0), 1440000, 92160000);
  var_3 = 1 - (var_2 - 1440000) / 90720000;
  var_4 = maps\_utility::linear_interpolate(var_3, 0.155, 0.225);
  earthquake(var_4, 0.6, var_1, 3072);
}

earthquake_valid_entity(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.origin) || !isDefined(var_1))
    return 0;

  var_2 = isplayer(var_1) || isDefined(var_1.owner) && isplayer(var_1.owner);
  var_3 = 0;
  var_4 = 0;

  if(isDefined(var_0.destructible_type))
    var_4 = issubstr(var_0.destructible_type, "tank") || issubstr(var_0.destructible_type, "vehicle_");
  else if(isDefined(var_0.classname))
    var_4 = issubstr(var_0.classname, "script_vehicle_");
  else if(isvalidmissile(var_0))
    var_4 = 1;

  if(!var_2)
    var_3 = level.player maps\_utility::player_looking_at(var_0.origin, undefined, 1);

  return var_4 && (var_2 || var_3);
}

earthquake_on_death() {
  self waittill("death", var_0, var_1, var_2);

  if(maps\_vehicle::isvehicle() && maps\_vehicle::ishelicopter() && !maps\_vehicle_code::vehicle_should_do_rocket_death(self.model, var_0, var_1)) {
    var_3 = common_scripts\utility::waittill_any_timeout(40, "crash_done");

    if(isDefined(var_3) && var_3 == "timeout")
      return;
  }

  if(isDefined(var_0) && isDefined(self) && earthquake_valid_entity(self, var_0))
    earthquake_player(self.origin);

  if(!isDefined(var_0)) {
    return;
  }
  if(isplayer(var_0) || isDefined(var_0.owner) && isplayer(var_0.owner)) {
    if(isDefined(var_2)) {
      if(gettime() > level.engagementcomplimentdialognext) {
        if(issubstr(var_2, "apache_"))
          get_apache_ally(1) do_random_pilot_chatter("missile_confirm");
        else
          get_apache_ally(1) do_random_pilot_chatter("other_player_kill_confirm");

        level.engagementcomplimentdialognext = gettime() + randomintrange(3000, 5000);
      }
    }
  }
}

earthquake_player_missile_monitor(var_0) {
  self endon(var_0);

  for(;;) {
    level waittill("LISTEN_apache_player_missile_fire", var_1);

    if(isvalidmissile(var_1))
      var_1 childthread earthquake_on_death_missile();
  }
}

earthquake_on_death_missile() {
  self waittill("death");

  if(isDefined(self) && isDefined(self.origin))
    earthquake_player(self.origin);
}

apache_mission_heli_ai_collision() {
  heli_ai_collision_cylinder_setup();
}

manage_all_rpg_ai_attack_player_think() {
  for(;;) {
    if(!isDefined(level.player.riding_heli)) {
      wait 0.05;
      continue;
    }

    var_0 = undefined;
    var_1 = rpg_ai_get_ready_array();

    if(var_1.size) {
      var_2 = manage_all_rpg_ai_get_target();

      if(isDefined(var_2)) {
        var_3 = rpg_ai_pick_shooter(var_1, var_2);

        if(isDefined(var_3))
          var_0 = var_3 rpg_ai_attack(var_2, 1);
      }
    }

    if(isDefined(var_0) && var_0) {
      wait(randomfloatrange(level.apache_difficulty.ai_rpg_attack_delay_min, level.apache_difficulty.ai_rpg_attack_delay_max));
      continue;
    }

    wait 0.1;
  }
}

rpg_ai_attack(var_0, var_1) {
  self notify("rpg_ai_attack");
  self endon("rpg_ai_attack");
  self endon("death");
  self clearenemy();
  self allowedstances("stand");
  maps\_utility::enable_dontevershoot();
  maps\_utility::disable_pain();
  self.combatmode_old = self.combatmode;
  self.combatmode = "no_cover";
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2 linkto(var_0);
  self setentitytarget(var_2);
  var_3 = gettime() + 4000;

  for(;;) {
    var_4 = isDefined(self.isreloading) && self.isreloading || isDefined(self.a.exposedreloading) && self.a.exposedreloading;

    if(!var_4) {
      break;
    }

    if(gettime() >= var_3)
      return 0;

    wait 0.05;
  }

  wait 1.0;

  if(!isDefined(var_0))
    return 0;

  if(isDefined(self.a.pose) && self.a.pose != "stand")
    return 0;

  if(is_apache_player(var_0))
    missile_attack_notify_target_of_lock_and_delay(var_0);

  if(!isDefined(var_0) || !self canshoot(var_0.origin)) {
    if(isDefined(var_0) && is_apache_player(var_0))
      self notify("LISTEN_missile_lockOnFailed");

    return 0;
  }

  ai_attack_missile(var_0, var_1);
  thread rpg_ai_attack_clear_no_shoot(3.5, "rpg_ai_attack", var_2);
  return 1;
}

rpg_ai_attack_clear_no_shoot(var_0, var_1, var_2) {
  self endon("death");

  if(var_0 > 0) {
    if(isDefined(var_1))
      self endon(var_1);

    wait(var_0);
  }

  self allowedstances("stand", "crouch");
  maps\_utility::disable_dontevershoot();
  maps\_utility::enable_pain();

  if(isDefined(self.combatmode_old)) {
    self.combatmode = self.combatmode_old;
    self.combatmode_old = undefined;
  }

  if(isDefined(var_2)) {
    self clearentitytarget();
    var_2 delete();
  }
}

rpg_ai_pick_shooter(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.a.pose) && var_4.a.pose == "stand" && var_4 canshoot(var_1.origin))
      var_2[var_2.size] = var_4;
  }

  var_6 = undefined;

  if(var_2.size)
    var_6 = var_2[randomint(var_2.size)];

  return var_6;
}

manage_all_rpg_ai_get_target() {
  return get_apache_player();
}

rpg_ai_get_ready_array() {
  var_0 = getaiarray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.rpg_ai_in_position) && var_3.rpg_ai_in_position)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

apache_precache() {
  precacheitem("rpg");
  precacheitem("rpg_straight");
  precacheitem("rpg_player");
  precacheitem("apache_lockon_missile_ai");
  precacheitem("apache_lockon_missile_ai_enemy");
  precachemodel("viewhands_devgru_elite");
  precachestring(&"OILROCKS_OBJ_APACHE_ATTACK");
  precachestring(&"OILROCKS_OBJ_APACHE_CHOPPER");
  precachestring(&"OILROCKS_KILLED_BY_MISSILE");
  maps\oilrocks_apache_hints::apache_hints_precache();
  vehicle_scripts\_chopper_ai_missile_defense::_precache();
  level.friendlyfire_enable_attacker_owner_check = 1;
  level.dronesthermalteamselect = "axis";
  level.custom_radius_damage_for_exploders = ::exploder_radius_custom;
  maps\_vehicle::enable_global_vehicle_spawn_functions();
  maps\_utility::post_load_precache(::post);
  setsaveddvar("r_hudOutlineenable", 1);
  setsaveddvar("r_hudOutlinewidth", 2);
  setsaveddvar("r_hudOutlinealpha0", 1.0);
  setsaveddvar("r_hudOutlinealpha1", 0.88);
  level.spawn_pool_enabled = 1;
  thread maps\oilrocks_apache_bridge_exploder::main();
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 13, 6);
  level.default_goalradius = 128;
}

exploder_radius_custom(var_0, var_1, var_2) {
  radiusdamage(var_0, var_1, var_2, var_2, level.player);
}

post() {
  start_apache_common();
  chopper_ai_init();
  maps\_drone_ai::init();
  level.struct = undefined;
  _globals();
  _flags();
  level.apache_savecheck = ::apache_autosave_check;
  level.spawn_pool_copy_function = ::spawn_pool_copy_function;
}

spawn_pool_copy_function(var_0) {
  self.script_startingposition = undefined;

  if(isDefined(var_0.script_startingposition))
    self.script_startingposition = var_0.script_startingposition;
}

apache_autosave_check() {
  var_0 = level.player.riding_heli vehicle_scripts\_apache_player::apache_health_pct_get();

  if(var_0 < 0.5)
    return 0;

  if(level.player.riding_heli.missile_defense vehicle_scripts\_chopper_missile_defense_utility::isanyenemylockedontome())
    return 0;

  if(level.player.riding_heli.missile_defense vehicle_scripts\_chopper_missile_defense_utility::isanymissilefiredonme())
    return 0;

  if(level.missionfailed)
    return 0;

  return 1;
}

_globals() {
  level.guy1 = undefined;
  level.guy2 = undefined;
  level.guy3 = undefined;
  level.guy4 = undefined;
  level.enemy_pool = [];
}

_flags() {
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_stop_control_hint");
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_stop_auto_pilot");
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_quarter");
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_half");
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_targets");
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_dialogue_finished");
  common_scripts\utility::flag_init("FLAG_apache_tut_fly_finished");
  common_scripts\utility::flag_init("FLAG_apache_factory_exit_canyon");
  common_scripts\utility::flag_init("FLAG_apache_factory_allies_close");
  common_scripts\utility::flag_init("FLAG_apache_factory_player_close");
  common_scripts\utility::flag_init("FLAG_apache_factory_hint_missiles");
  common_scripts\utility::flag_init("FLAG_apache_factory_hint_mg");
  common_scripts\utility::flag_init("FLAG_apache_factory_hind_take_off_dead");
  common_scripts\utility::flag_init("FLAG_apache_factory_destroyed_ai");
  common_scripts\utility::flag_init("FLAG_apache_factory_destroyed_vehicles");
  common_scripts\utility::flag_init("FLAG_apache_factory_destroyed");
  common_scripts\utility::flag_init("FLAG_apache_factory_finished");
  common_scripts\utility::flag_init("FLAG_apache_chase_vo_done");
  common_scripts\utility::flag_init("FLAG_apache_chase_finished");
  common_scripts\utility::flag_init("FLAG_apache_chopper_vo_take_it_done");
  common_scripts\utility::flag_init("FLAG_apache_chopper_hind_destroyed_two");
  common_scripts\utility::flag_init("FLAG_apache_chopper_hind_remaining_three");
  common_scripts\utility::flag_init("FLAG_apache_chopper_hind_remaining_one");
  common_scripts\utility::flag_init("FLAG_apache_chopper_vo_done");
  common_scripts\utility::flag_init("FLAG_apache_chopper_finished");
}

objective_protect_start() {
  var_0 = maps\_utility::obj_exists("protect_the_blackhawk");
  var_1 = maps\_utility::obj("protect_the_blackhawk");

  if(!var_0) {
    objective_add(var_1, "active", & "OILROCKS_OBJ_PROTECT_THE_BLACKHAWK");
    objective_current(var_1);
  } else
    objective_current(var_1);
}

objective_protect_complete() {
  var_0 = maps\_utility::obj("protect_the_blackhawk");
  maps\_utility::objective_complete(var_0);
}

send_apaches_to_hangout(var_0) {
  thread send_apaches_to_hangout_thread(var_0);
}

send_apaches_to_hangout_thread(var_0) {
  maps\_chopperboss_utility::chopper_boss_set_hangout_volume(getent(var_0, "targetname"));
  var_1 = get_apache_allies();

  foreach(var_3 in var_1)
  var_3 maps\oilrocks_code::chopper_boss_goto_hangout();
}

spawn_vehicles_from_targetname_prunespawning(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.code_classname) || var_4.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_4) && !isDefined(var_4.vehicle_spawned_thisframe))
      var_1[var_1.size] = maps\_vehicle_code::_vehicle_spawn(var_4);
  }

  return var_1;
}