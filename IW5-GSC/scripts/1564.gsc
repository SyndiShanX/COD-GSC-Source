/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1564.gsc
**************************************/

ai_preload() {
  ai_preload_weapons();
  precacheheadicon("headicon_delta_so");
  precacheheadicon("headicon_gign_so");
  precachemodel("weapon_c4");
  level._effect["martyrdom_c4_explosion"] = loadfx("explosions/grenadeExp_metal");
  level._effect["martyrdom_dlight_red"] = loadfx("misc/dlight_red");
  level._effect["martyrdom_red_blink"] = loadfx("misc/power_tower_light_red_blink");
  precachemodel("weapon_claymore");
  level._effect["claymore_laser"] = loadfx("misc/claymore_laser");
  level._effect["claymore_explosion"] = loadfx("explosions/grenadeExp_metal");
  level._effect["claymore_disabled"] = loadfx("explosions/sentry_gun_explosion");
  precachemodel("gas_canisters_backpack");
  precachemodel("ims_scorpion_explosive1");
  precacheshellshock("radiation_low");
  precacheshellshock("radiation_med");
  precacheshellshock("radiation_high");
  level._effect["chemical_tank_explosion"] = loadfx("smoke/so_chemical_explode_smoke");
  level._effect["chemical_tank_smoke"] = loadfx("smoke/so_chemical_stream_smoke");
  level._effect["chemical_mine_spew"] = loadfx("smoke/so_chemical_mine_spew");
  level._effect["money"] = loadfx("props/cash_player_drop");
  maps/_chopperboss::chopper_boss_load_fx();
  animscripts\dog\dog_init::initdoganimations();
}

ai_preload_weapons() {
  var_0 = 100;
  var_1 = 120;

  for(var_2 = var_0; var_2 <= var_1; var_2++) {
    var_3 = get_squad_array(get_wave_index(var_2));

    foreach(var_5 in var_3) {}
    precacheitem(var_5);
  }
}

ai_init() {
  setsaveddvar("ai_dropAkimboChance", 0);

  if(!isDefined(level.wave_table)) {
    level.wave_table = "sp/survival_waves.csv";
  }
  level.survival_ai = [];
  level.survival_boss = [];
  level.survival_ai = ai_type_populate();
  level.survival_repeat_wave = [];
  level.survival_waves_repeated = 0;
  level.survival_wave = [];
  level.survival_wave = wave_populate();
  createthreatbiasgroup("sentry");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("boss");
  createthreatbiasgroup("dogs");
  setignoremegroup("sentry", "dogs");
  setthreatbias("sentry", "boss", 50);
  setthreatbias("sentry", "axis", 50);
  setthreatbias("boss", "allies", 2000);
  setthreatbias("dogs", "allies", 1000);
  setthreatbias("axis", "allies", 0);

  foreach(var_1 in level.players) {
    var_1.onlygoodnearestnodes = 1;
    var_1 thread update_player_closest_node_think();
  }

  level.attributes_func = ::setup_attributes;
  level.squad_leader_behavior_func = ::default_ai;
  level.special_ai_behavior_func = ::default_ai;
  level.squad_drop_weapon_rate = 1;
  maps\_utility::add_global_spawn_function("axis", ::no_grenade_bag_drop);
  maps\_utility::add_global_spawn_function("axis", ::weapon_drop_ammo_adjustment);
  maps\_utility::add_global_spawn_function("axis", ::update_enemy_remaining);
  maps\_utility::add_global_spawn_function("axis", ::ai_on_long_death);
  maps\_utility::add_global_spawn_function("axis", ::kill_sentry_on_contact);
  register_xp();
  thread survival_ai_regular();
  thread survival_ai_martyrdom();
  thread survival_ai_claymore_and_chemical();
  thread survival_boss_juggernaut();
  thread survival_drop_chopper_init();
  thread survival_boss_chopper();
  thread dog_relocate_init();
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
}

kill_sentry_on_contact() {
  self endon("death");

  if(!isai(self)) {
    return;
  }
  wait 0.5;

  if(isDefined(self.ridingvehicle)) {
    self waittill("jumpedout");
  }
  if(!isDefined(level.placed_sentry)) {
    return;
  }
  foreach(var_1 in level.placed_sentry) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    if(distance2d(var_1.origin, self.origin) < 40 && distancesquared(var_1.origin, self.origin) < 4096) {
      var_1 kill();
    }
  }
}

wave_populate() {
  var_0 = 0;
  var_1 = 40;
  var_2 = [];

  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = get_wave_number_by_index(var_3);

    if(!isDefined(var_4) || var_4 == 0) {
      continue;
    }
    var_5 = spawnStruct();
    var_5.repeating = var_3;
    var_5.num = var_4;
    var_5._id_3D4B = get_squad_type(var_4);
    var_5._id_3D4C = get_squad_array(var_4);
    var_5._id_3D4D = get_special_ai(var_4);
    var_5._id_3D4E = get_special_ai_quantity(var_4);
    var_5._id_3D4F = get_wave_boss_delay(var_4);
    var_5._id_3D50 = get_bosses_ai(var_4);
    var_5._id_3D51 = get_bosses_nonai(var_4);
    var_5._id_3D52 = get_dog_type(var_4);
    var_5._id_3D53 = get_dog_quantity(var_4);
    var_5._id_3D54 = is_repeating(var_4);
    var_6 = get_armory_unlocked(var_4);

    if(isDefined(var_6) && var_6.size) {
      if(!isDefined(level.armory_unlock)) {
        level.armory_unlock = [];
      }
      foreach(var_8 in var_6) {}
      level.armory_unlock[var_8] = var_4;
    }

    var_2[var_4] = var_5;

    if(var_5._id_3D54) {
      level.survival_repeat_wave[level.survival_repeat_wave.size] = var_5;
    }
  }

  return var_2;
}

ai_type_add_override_class(var_0, var_1) {
  if(!isDefined(level.survival_ai_class_overrides)) {
    level.survival_ai_class_overrides = [];
  }
  level.survival_ai_class_overrides[var_0] = var_1;
}

ai_type_add_override_weapons(var_0, var_1) {
  if(!isDefined(level.survival_ai_weapon_overrides)) {
    level.survival_ai_weapon_overrides = [];
  }
  foreach(var_3 in var_1) {}
  precacheitem(var_3);

  level.survival_ai_weapon_overrides[var_0] = var_1;
}

ai_type_populate() {
  var_0 = 100;
  var_1 = 120;
  var_2 = [];

  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = get_wave_index(var_3);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = spawnStruct();
    var_5.repeating = var_3;
    var_5.ref = var_4;
    var_5.name = get_special_ai_quantity(var_4);
    var_5.desc = get_special_ai_type_quantity(var_4);
    var_5.classname = get_squad_type(var_4);
    var_5.weapon = get_squad_array(var_4);
    var_5.altweapon = get_special_ai(var_4);
    var_5.health = get_ai_health(var_4);
    var_5.speed = get_ai_speed(var_4);
    var_5.accuracy = get_ai_accuracy(var_4);
    var_5.xp = get_ai_xp(var_4);

    if(is_ai_boss(var_4)) {
      level.survival_boss[var_4] = var_5;
    }
    var_2[var_4] = var_5;
  }

  return var_2;
}

givexp_kill(var_0, var_1) {
  var_2 = "kill";

  if(isDefined(var_0.ai_type)) {
    var_2 = "survival_ai_" + var_0.ai_type.ref;
  }
  var_3 = undefined;

  if(isDefined(var_1)) {
    var_4 = maps\_rank::getscoreinfovalue(var_2);

    if(isDefined(var_4)) {
      var_3 = var_4 * var_1;
    }
  }

  maps\_utility::givexp(var_2, var_3);
}

register_xp() {
  foreach(var_1 in level.survival_ai) {}
  maps\_rank::registerscoreinfo("survival_ai_" + var_1.ref, get_ai_xp(var_1.ref));
}

update_player_closest_node_think() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = 128;
  var_1 = 1;
  var_2 = 512;

  for(;;) {
    var_3 = getclosestnodeinsight(self.origin);

    if(isDefined(var_3)) {
      if(var_3.type != "Begin" && var_3.type != "End" && var_3.type != "Turret") {
        self.node_closest = var_3;
      }
    }

    wait 0.25;
  }
}

update_enemy_remaining() {
  level endon("special_op_terminated");
  waittillframeend;
  level.enemy_remaining = get_survival_enemies_living().size;
  level notify("axis_spawned");
  self waittill("death");
  waittillframeend;
  var_0 = get_survival_enemies_living();
  level.enemy_remaining = var_0.size;
  level notify("axis_died");

  if(common_scripts\utility::flag("aggressive_mode") && var_0.size == 1 && isai(var_0[0]) && var_0[0].type != "dog") {
    var_0[0] thread prevent_long_death();
  }
}

get_survival_enemies_living() {
  var_0 = getaiarray("axis");

  if(isDefined(level.bosses) && level.bosses.size) {
    var_0 = maps\_utility::array_merge(var_0, level.bosses);
  }
  var_0 = maps\_utility::array_merge(var_0, dog_get_living());
  return var_0;
}

prevent_long_death() {
  level endon("special_op_terminated");
  self endon("death");

  if(!isDefined(self.a.doinglongdeath)) {
    maps\_utility::disable_long_death();
    return;
  }

  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.players) {
      var_3 = distance2d(var_2.origin, self.origin) < 540;

      if(var_3) {
        var_0 = 0;
        break;
      }

      if(self cansee(var_2)) {
        var_0 = 0;
        break;
      }

      wait 0.05;
    }

    if(var_0) {
      var_5 = dog_get_count();

      if(isDefined(var_5)) {
        self kill(self.origin, var_5);
      } else {
        self kill(self.origin);
      }
      return;
    }

    wait 0.1;
  }
}

dog_get_count() {
  var_0 = undefined;

  if(isDefined(self.attacker_list) && self.attacker_list.size) {
    var_0 = self.attacker_list[self.attacker_list.size - 1];
  }
  return var_0;
}

weapon_drop_ammo_adjustment() {
  if(!isai(self) || isDefined(self.type) && self.type == "dog") {
    return;
  }
  if(!isDefined(level.armory) || !isDefined(level.armory["weapon"])) {
    return;
  }
  level endon("special_op_terminated");
  self waittill("weapon_dropped", var_0);

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getsubstr(var_0.classname, 7);
  wait 0.05;
  var_2 = level.armory["weapon"][var_1];

  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  var_3 = var_2.dropclip;
  var_4 = var_2.dropstock;
  var_0 itemweaponsetammo(var_3, var_4);
  var_5 = weaponaltweaponname(var_1);

  if(var_5 != "none") {
    var_6 = int(max(1, weaponclipsize(var_5)));
    var_7 = int(max(1, weaponmaxammo(var_5)));
    var_0 itemweaponsetammo(var_6, var_7, var_6, 1);
  }
}

no_grenade_bag_drop() {
  level.nextgrenadedrop = 100000;
}

money_fx_on_death() {
  level endon("special_op_terminated");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  playFX(level._effect["money"], self.origin + (0, 0, 32));
}

ai_on_long_death() {
  if(!isai(self) || isDefined(self.type) && self.type == "dog") {
    return;
  }
  self endon("death");
  level endon("special_op_terminated");
  self waittill("long_death");
  self waittill("flashbang", var_0, var_1, var_2, var_3);

  if(isDefined(var_3) && isDefined(var_3.team) && var_3.team == "allies") {
    self kill(self.origin, var_3);
  }
}

get_ai_type_ref() {
  if(isDefined(self.ai_type)) {
    return self.ai_type.ref;
  }
  if(isDefined(level.leaders)) {
    foreach(var_1 in level.leaders) {
      if(var_1 == self) {
        return get_squad_type(level.current_wave);
      }
    }
  }

  if(isDefined(self.leader) && isai(self.leader)) {
    return get_squad_type(level.current_wave);
  }
  return undefined;
}

get_special_ai_array(var_0) {
  var_1 = [];

  if(isDefined(level.special_ai) && level.special_ai.size) {
    foreach(var_3 in level.special_ai) {
      if(isalive(var_3) && isDefined(var_3.ai_type) && var_3.ai_type.ref == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

default_ai() {
  self notify("ai_behavior_change");
  self.aggressivemode = 1;
  self.aggressing = undefined;
  var_0 = self[[level.attributes_func]]();

  if(var_0 == "martyrdom") {
    thread behavior_special_ai_martyrdom();
    return;
  }

  if(var_0 == "claymore") {
    thread behavior_special_ai_claymore();
    return;
  }

  if(var_0 == "chemical") {
    thread behavior_special_ai_chemical();
    return;
  }

  if(var_0 == "easy" || var_0 == "regular" || var_0 == "hardened" || var_0 == "veteran" || var_0 == "elite") {
    thread default_squad_leader();
  }
}

aggressive_ai() {
  self notify("ai_behavior_change");
  self.aggressivemode = 1;
  self.aggressing = 1;
  var_0 = self[[level.attributes_func]]();

  if(var_0 == "martyrdom") {
    thread behavior_special_ai_martyrdom();
    return;
  }

  if(var_0 == "claymore") {
    thread behavior_special_ai_claymore();
    return;
  }

  if(var_0 == "chemical") {
    thread behavior_special_ai_chemical();
    return;
  }

  if(var_0 == "easy" || var_0 == "regular" || var_0 == "hardened" || var_0 == "veteran" || var_0 == "elite") {
    thread aggressive_squad_leader();
  }
}

setup_attributes() {
  if(isDefined(self.attributes_set) && isDefined(self.ai_type)) {
    return self.ai_type.ref;
  }
  var_0 = get_ai_type_ref();

  if(!isDefined(self.ai_type)) {
    var_1 = get_wave_number_by_index(var_0);
    self.ai_type = var_1;
  }

  var_2 = isDefined(self.code_classname) && self.code_classname == "script_vehicle";
  var_3 = get_ai_health(var_0);

  if(isDefined(var_3) && !var_2) {
    self.health = var_3;
  }
  var_4 = get_ai_speed(var_0);

  if(isDefined(var_4)) {
    if(var_2) {
      self vehicle_setspeed(60 * var_4, 20 * var_4);
    } else {
      self.moveplaybackrate = var_4;
    }
  }

  var_5 = get_ai_accuracy(var_0);

  if(isDefined(var_5)) {
    maps\_utility::set_baseaccuracy(var_5);
  }
  var_6 = get_special_ai(var_0);

  foreach(var_8 in var_6) {
    if(var_8 == "fraggrenade") {
      self.grenadeammo = 2;
      self.grenadeweapon = "fraggrenade";
    }

    if(var_8 == "flash_grenade") {
      self.grenadeammo = 2;
      self.grenadeweapon = "flash_grenade";
    }
  }

  if(isDefined(self.dropweapon) && self.dropweapon && isDefined(level.squad_drop_weapon_rate)) {
    var_10 = randomfloat(1);

    if(var_10 > level.squad_drop_weapon_rate) {
      self.dropweapon = 0;
    }
  }

  self.advance_regardless_of_numbers = 1;
  self.reacquire_without_facing = 1;
  self.minexposedgrenadedist = 256;
  self.attributes_set = 1;
  return var_0;
}

survival_boss_behavior() {
  self endon("death");
  var_0 = "Boss does not have AI_Type struct, should have been passed when spawning by AI_Type.";
  var_1 = self[[level.attributes_func]]();

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == "jug_regular") {
    global_jug_behavior();
    thread boss_jug_regular();
    return;
  }

  if(var_1 == "jug_headshot") {
    global_jug_behavior();
    thread boss_jug_headshot();
    return;
  }

  if(var_1 == "jug_explosive") {
    global_jug_behavior();
    thread boss_jug_explosive();
    return;
  }

  if(var_1 == "jug_riotshield") {
    global_jug_behavior();
    thread boss_jug_riotshield();
    return;
  }
}

survival_ai_regular() {}

default_squad_leader() {
  self.goalradius = 900;
  self.aggressing = undefined;
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 768);
  thread get_challenge_hud_params(4.0, self.goalradius, "ai_behavior_change demotion");
}

aggressive_squad_leader() {
  self.goalradius = 384;
  self.aggressing = 1;
  maps\_utility::enable_heat_behavior(1);
  maps\_utility::disable_surprise();
  self setengagementmindist(88, 64);
  self setengagementmaxdist(512, 768);
  thread get_challenge_hud_params(4.0, self.goalradius, "ai_behavior_change demotion");
}

behavior_special_ai_martyrdom() {
  self endon("death");
  self endon("ai_behavior_change");

  if(!isDefined(self.special_ability)) {
    thread martyrdom_ability();
  }
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self.aggressing) && self.aggressing) {
    var_0 = 88;
    var_1 = 64;
    self.goalradius = 384;
    maps\_utility::enable_heat_behavior(1);
    maps\_utility::disable_surprise();
  } else {
    var_0 = 200;
    var_1 = 100;
    self.goalradius = 900;
  }

  self setengagementmindist(var_0, var_1);
  self setengagementmaxdist(512, 768);
  thread get_challenge_hud_params(4.0, self.goalradius, "ai_behavior_change");
}

survival_ai_martyrdom() {}

martyrdom_ability() {
  self.special_ability = 1;
  self.forcelongdeath = 1;
  thread attach_c4("j_spine4", (0, 6, 0), (0, 0, -90));
  thread attach_c4("tag_stowed_back", (0, 1, 5), (80, 90, 0));
  thread detonate_c4_when_dead(3, 0.4);
}

attach_c4(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }
  var_3 = spawn("script_model", self gettagorigin(var_0) + var_1);
  var_3 setModel("weapon_c4");
  var_3 linkTo(self, var_0, var_1, var_2);

  if(!isDefined(self.c4_attachments)) {
    self.c4_attachments = [];
  }
  self.c4_attachments[self.c4_attachments.size] = var_3;
}

detonate_c4_when_dead(var_0, var_1) {
  common_scripts\utility::waittill_any("long_death", "death", "force_c4_detonate");
  self notify("c4_detonated");

  if(!isDefined(self) || !isDefined(self.c4_attachments) || self.c4_attachments.size == 0) {
    return;
  }
  var_2 = dog_get_count();

  if(isDefined(self.dog_neck_snapped)) {
    var_0 = 5;
  }
  for(var_3 = 0; var_3 < self.c4_attachments.size; var_3++) {
    playFXOnTag(common_scripts\utility::getfx("martyrdom_dlight_red"), self.c4_attachments[var_3], "tag_fx");
    playFXOnTag(common_scripts\utility::getfx("martyrdom_red_blink"), self.c4_attachments[var_3], "tag_fx");
  }

  var_4 = self.c4_attachments;
  self.c4_attachments = undefined;
  badplace_cylinder("", var_0, var_4[0].origin, 144, 144, "axis", "allies");
  var_5 = max(var_0 - 1.5, 0);

  if(var_5 > 0) {
    var_0 = var_0 - var_5;
    wait(var_5);
  }

  var_4[0] playSound("semtex_warning");
  var_6 = 0;

  if(var_0 > 0.25) {
    var_0 = var_0 - 0.25;
    var_6 = 1;
  }

  wait(var_0);

  for(var_3 = 0; var_3 < var_4.size; var_3++) {
    if(!isDefined(var_4[var_3])) {
      continue;
    }
    stopFXOnTag(common_scripts\utility::getfx("martyrdom_red_blink"), var_4[var_3], "tag_fx");
  }

  if(var_6) {
    wait 0.25;
  }
  var_4 = sortbydistance(var_4, var_4[0].origin + (0, 0, -120));

  for(var_3 = 0; var_3 < var_4.size; var_3++) {
    if(!isDefined(var_4[var_3])) {
      continue;
    }
    playFX(level._effect["martyrdom_c4_explosion"], var_4[var_3].origin);
    var_4[var_3] playSound("detpack_explo_main", "sound_done");
    physicsexplosioncylinder(var_4[var_3].origin, 256, 1, 2);
    earthquake(0.4, 0.8, var_4[var_3].origin, 600);
    stopFXOnTag(common_scripts\utility::getfx("martyrdom_dlight_red"), var_4[var_3], "tag_fx");

    if(!isDefined(var_2)) {
      var_2 = undefined;
    }
    var_4[var_3] radiusdamage(var_4[var_3].origin, 192, 100, 50, var_2, "MOD_EXPLOSIVE");
    var_4[var_3] thread maps/_so_survival_code::ent_linked_delete();
    wait(var_1);
  }
}

behavior_special_ai_claymore() {
  if(isDefined(self.planting)) {
    return;
  }
  self endon("death");
  self endon("ai_behavior_change");
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self.aggressing) && self.aggressing) {
    var_0 = 88;
    var_1 = 64;
    self.goalradius = 384;
    maps\_utility::enable_heat_behavior(1);
    maps\_utility::disable_surprise();
  } else {
    var_0 = 300;
    var_1 = 200;
    self.goalradius = 900;
  }

  self setengagementmindist(var_0, var_1);
  self setengagementmaxdist(512, 768);
  thread get_challenge_hud_params(4.0, self.goalradius, "ai_behavior_change");
}

survival_ai_claymore_and_chemical() {
  mine_locs_populate();
  thread mine_locs_manage_weights();
  var_0 = ["claymore", "chemical"];
  thread mine_locs_manage_planting(var_0);
}

mine_locs_populate() {
  level.so_mine_locs = [];
  level.so_mine_locs = get_all_mine_locs();

  foreach(var_1 in level.so_mine_locs) {}
  var_1.weight = 0.0;
}

mine_locs_attempt_plant(var_0) {
  if(isDefined(level.so_mines) && level.so_mines.size >= 6) {
    return 0;
  }
  var_1 = [];

  foreach(var_3 in var_0) {}
  var_1 = common_scripts\utility::array_combine(var_1, get_special_ai_array(var_3));

  var_1 = mine_ai_remove_busy(var_1);

  if(!var_1.size) {
    return 0;
  }
  var_5 = mine_locs_get_valid(384, 2.0);
  var_5 = mine_locs_sorted_by_weight(var_5);

  foreach(var_7 in var_5) {
    foreach(var_9 in var_1) {
      var_10 = distance2d(var_7.origin, var_9.origin);

      if(var_10 > 768 || var_7.origin[2] < var_9.origin[2] - 120.0 || var_7.origin[2] > var_9.origin[2] + 120.0) {
        continue;
      }
      var_11 = maps\_utility::getclosest(var_7.origin, level.players);
      var_12 = distance2d(var_7.origin, var_11.origin);

      if(var_10 < var_12) {
        var_9 thread behavior_special_ai_mine_place(var_7);
        return 1;
      }
    }
  }

  return 0;
}

mine_ai_remove_busy(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.planting)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

mine_locs_sorted_by_weight(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = 0;

    for(var_3 = var_1 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3].weight < var_0[var_1].weight) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_1];
        var_0[var_1] = var_4;
      }
    }
  }

  return var_0;
}

mine_locs_get_valid(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.so_mine_locs) {
    if(var_4 mine_loc_valid_plant(var_0, var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

mine_loc_valid_plant(var_0, var_1) {
  if(isDefined(self.occupied) || self.weight < var_1) {
    return 0;
  }
  foreach(var_3 in level.players) {
    if(distance2d(self.origin, var_3.origin) < var_0) {
      return 0;
    }
  }

  return 1;
}

mine_locs_manage_weights() {
  level endon("special_op_terminated");

  for(;;) {
    foreach(var_1 in level.so_mine_locs) {
      var_2 = 0;

      foreach(var_4 in level.players) {
        if(distance2d(var_1.origin, var_4.origin) <= 512) {
          var_1 mine_loc_adjust_weight(1);
          var_2 = 1;
        }
      }

      if(!var_2) {
        var_1 mine_loc_adjust_weight(0);
      }
    }

    wait 0.5;
  }
}

mine_loc_adjust_weight(var_0) {
  if(var_0) {
    self.weight = min(20, self.weight + 0.5);
  } else {
    self.weight = max(0, self.weight - 0.025);
  }
}

mine_locs_manage_planting(var_0) {
  level endon("special_op_terminated");

  for(;;) {
    if(mine_locs_attempt_plant(var_0)) {
      wait 8.0;
      continue;
    }

    wait 2.0;
  }
}

behavior_special_ai_mine_place(var_0) {
  self endon("death");
  self.planting = 1;
  self notify("ai_behavior_change");
  var_0.occupied = 1;
  thread mine_ai_planting_death(var_0);
  var_1 = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setgoalpos(var_0.origin);
  var_2 = common_scripts\utility::waittill_any_timeout(13, "goal", "bad_path");

  if(var_2 != "goal") {
    var_0.occupied = undefined;

    if(var_2 == "bad_path") {
      level.so_mine_locs = maps\_utility::array_remove_nokeys(level.so_mine_locs, var_0);
    }
  } else {
    self allowedstances("crouch");
    wait 1.0;
    var_3 = undefined;
    var_4 = get_ai_type_ref();

    if(var_4 == "claymore") {
      var_3 = claymore_create(var_0.origin, var_0.angles);
      var_3 playSound("so_claymore_plant");
      var_3 thread claymore_on_trigger();
      var_3 thread claymore_on_damage();
      var_3 thread claymore_on_emp();
      level notify("ai_claymore_planted");
    } else if(var_4 == "chemical") {
      var_3 = chembomb_create(var_0.origin, var_0.angles);
      var_3 playSound("so_claymore_plant");
      var_3 thread chembomb_on_trigger();
      var_3 thread chembomb_on_damage();
      level notify("ai_chembomb_planted");
    } else {}

    if(isDefined(var_3)) {
      if(!isDefined(level.so_mines)) {
        level.so_mines = [];
      }
      level.so_mines[level.so_mines.size] = var_3;
      var_3 thread mine_on_death(var_0);
      wait 0.25;
      var_0.weight = var_0.weight * 0.5;
    }
  }

  self allowedstances("prone", "crouch", "stand");
  self.goalradius = var_1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.planting = undefined;
  self notify("planting_done");
  var_4 = get_ai_type_ref();

  if(var_4 == "claymore") {
    thread behavior_special_ai_claymore();
  } else if(var_4 == "chemical") {
    thread behavior_special_ai_chemical();
  }
}

mine_ai_planting_death(var_0) {
  self endon("planting_done");
  level endon("special_op_terminated");
  self waittill("death");
  var_0.occupied = undefined;
}

claymore_create(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("weapon_claymore");

  if(!isDefined(var_2) || var_2) {
    var_3.origin = maps\_utility::drop_to_ground(var_0, 12, -120);
  }
  var_3.angles = (0, var_1[1], 0);
  playFXOnTag(common_scripts\utility::getfx("claymore_laser"), var_3, "tag_fx");

  if(isDefined(self) && isalive(self)) {
    var_3.owner = self;
  }
  return var_3;
}

claymore_on_trigger() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = 6;
  var_1 = spawn("trigger_radius", self.origin + (0, 0, -192), var_0, 192, 384);
  thread mine_delete_on_death(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(isDefined(self.disabled)) {
      self waittill("enabled");
      continue;
    }

    if(var_2 claymore_on_trigger_laser_check(self)) {
      self notify("triggered");
      claymore_detonate(0.75);
      return;
    }
  }
}

claymore_on_trigger_laser_check(var_0) {
  if(isDefined(var_0.disabled)) {
    return 0;
  }
  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < 20) {
    return 0;
  }
  var_2 = vectorNormalize(var_2);
  var_5 = vectordot(var_2, var_3);

  if(!isDefined(level.so_claymore_trig_dot)) {
    level.so_claymore_trig_dot = cos(70);
  }
  return var_5 > level.so_claymore_trig_dot;
}

claymore_detonate(var_0) {
  if(isDefined(self.so_claymore_activated)) {
    return;
  }
  self.so_claymore_activated = 1;
  level endon("special_op_terminated");
  self playSound("claymore_activated_SP");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  self playSound("detpack_explo_main", "sound_done");
  playFX(level._effect["claymore_explosion"], self.origin);
  physicsexplosioncylinder(self.origin, 256, 1, 2);
  earthquake(0.4, 0.8, self.origin, 600);
  stopFXOnTag(common_scripts\utility::getfx("claymore_laser"), self, "tag_fx");
  radiusdamage(self.origin, 192, 100, 50, undefined, "MOD_EXPLOSIVE");
  level.so_mine_last_detonate_time = gettime();

  if(isDefined(self)) {
    self delete();
  }
}

mine_delete_on_death(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  level.so_mines = maps\_utility::array_remove_nokeys(level.so_mines, self);
  wait 0.05;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

claymore_on_damage() {
  self endon("death");
  self endon("triggered");
  level endon("special_op_terminated");
  self.health = 100;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self waittill("damage", var_0, var_1);
  var_2 = 0.05;

  if(mine_so_detonated_recently()) {
    var_2 = 0.1 + randomfloat(0.4);
  }
  claymore_detonate(var_2);
}

mine_so_detonated_recently() {
  return isDefined(level.so_mine_last_detonate_time) && gettime() - level.so_mine_last_detonate_time < 400;
}

claymore_on_emp() {
  self endon("death");
  self endon("triggered");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    playFXOnTag(common_scripts\utility::getfx("claymore_disabled"), self, "tag_origin");
    self.disabled = 1;
    self notify("disabled");
    wait(var_1);
    self.disabled = undefined;
    self notify("enabled");
  }
}

mine_on_death(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  var_0.occupied = undefined;
}

behavior_special_ai_chemical() {
  if(isDefined(self.planting)) {
    return;
  }
  self endon("death");
  self endon("ai_behavior_change");

  if(!isDefined(self.special_ability)) {
    thread chemical_ability();
  }
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self.aggressing) && self.aggressing) {
    var_0 = 88;
    var_1 = 64;
    self.goalradius = 384;
    maps\_utility::enable_heat_behavior(1);
    maps\_utility::disable_surprise();
  } else {
    var_0 = 120;
    var_1 = 60;
    self.goalradius = 512;
  }

  self setengagementmindist(var_0, var_1);
  self setengagementmaxdist(512, 768);
  thread get_challenge_hud_params(4.0, self.goalradius, "ai_behavior_change");
}

chemical_ability() {
  self.special_ability = 1;
  self.ignoresuppression = 1;
  self.no_pistol_switch = 1;
  self.norunngun = 1;
  self.disableexits = 1;
  self.disablearrivals = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.neversprintforvariation = 1;
  maps\_utility::disable_long_death();
  maps\_utility::disable_surprise();
  var_0 = chemical_ability_attach_tank("tag_shield_back", (0, 0, 0), (0, 90, 0));
  thread chemical_ability_tank_spew(var_0);
  thread chemical_ability_on_tank_damage(var_0);
  thread chemical_ability_on_death(var_0);
}

chemical_ability_attach_tank(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self gettagorigin(var_0) + var_1);
  var_3 setModel("gas_canisters_backpack");
  var_3.health = 99999;
  var_3 setCanDamage(1);
  var_3 linkTo(self, var_0, var_1, var_2);
  return var_3;
}

chemical_ability_tank_spew(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("chemical_tank_smoke"), self, "tag_shield_back");
    wait 0.05;
  }
}

chemical_ability_on_tank_damage(var_0) {
  self endon("death");
  self endon("tank_detonated");
  level endon("special_op_terminated");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isPlayer(var_2) || var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE" || var_5 == "MOD_GRENADE_SPLASH") {
      thread maps/_so_survival_code::so_survival_kill_ai(var_2, var_5, var_10);
      return;
    }
  }
}

chemical_ability_on_death(var_0) {
  self endon("tank_detonated");
  level endon("special_op_terminated");
  self waittill("death", var_1);

  if(!isDefined(self)) {
    if(isDefined(var_0)) {
      wait 0.05;
      var_0 delete();
    }

    return;
  }

  thread chemical_ability_detonate(var_0, var_1);
}

chemical_ability_detonate(var_0, var_1) {
  if(!isDefined(var_0) || isDefined(var_0.detonated)) {
    return;
  }
  var_0.detonated = 1;

  if(!isDefined(self)) {
    return;
  }
  self notify("tank_detonated");
  var_2 = self.origin;
  var_0 playSound("detpack_explo_main", "sound_done");
  physicsexplosioncylinder(var_2, 256, 1, 0.5);
  earthquake(0.2, 0.4, var_2, 600);
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, undefined);
  playFX(common_scripts\utility::getfx("chemical_tank_explosion"), var_2);
  thread chemical_ability_gas_cloud(var_2, 6.0, 2.0);
  var_0 unlink();
  wait 0.05;
  var_0 delete();
}

chemical_ability_gas_cloud(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  var_3 = 7;
  var_4 = spawn("trigger_radius", var_0 + (0, 0, -96), var_3, 96, 192);
  badplace_cylinder("", var_2, var_0, 96, 96, "axis", "allies");
  var_4 endon("smoke_done");
  var_4 thread wait_for_delete();
  var_4 thread maps\_utility::do_in_order(maps\_utility::_wait, var_1, maps\_utility::send_notify, "smoke_done");

  for(;;) {
    var_4 waittill("trigger", var_5);

    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    if(isPlayer(var_5)) {
      if(maps\_utility::is_player_down(var_5) || maps\_utility::is_player_down_and_out(var_5)) {
        continue;
      }
      if(isDefined(var_5.gassed)) {
        continue;
      }
      var_6 = "";
      var_7 = gettime();

      if(!isDefined(var_5.gassed_before) || isDefined(var_5.gas_time) && var_7 - var_5.gas_time > 1500.0) {
        var_6 = "radiation_low";
      } else if(var_5.gas_shock == "radiation_low") {
        var_6 = "radiation_med";
      } else {
        var_6 = "radiation_high";
      }
      var_5.gassed_before = 1;
      var_5.gas_shock = var_6;
      var_5.gas_time = var_7;
      var_5 shellshock(var_6, 1.5);
      var_5.gassed = 1;
      var_5 thread chemical_ability_remove_gas_flag(1.0);
    }

    if(isai(var_5)) {}
  }
}

wait_for_delete() {
  level endon("special_op_terminated");
  self waittill("smoke_done");
  self delete();
}

chemical_ability_remove_gas_flag(var_0) {
  self endon("death");
  wait(var_0);
  self.gassed = undefined;
}

chembomb_create(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("ims_scorpion_explosive1");

  if(!isDefined(var_2) || var_2) {
    var_3.origin = maps\_utility::drop_to_ground(var_0, 12, -120) + (0, 0, 5);
  }
  var_3.angles = (0, var_1[1], 0);
  var_3.tag_origin = var_3 common_scripts\utility::spawn_tag_origin();
  var_3.tag_origin linkTo(var_3, "tag_explosive1", (0, 0, 6), (-90, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("chemical_mine_spew"), var_3.tag_origin, "tag_origin");

  if(isDefined(self) && isalive(self)) {
    var_3.owner = self;
  }
  return var_3;
}

chembomb_on_trigger() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = 6;
  var_1 = spawn("trigger_radius", self.origin + (0, 0, -96), var_0, 96, 192);
  thread mine_delete_on_death(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(isDefined(self.disabled)) {
      self waittill("enabled");
      continue;
    }

    self notify("triggered");
    chembomb_detonate(0.5);
    return;
  }
}

chembomb_on_damage() {
  self endon("death");
  self endon("triggered");
  level endon("special_op_terminated");
  self.health = 100;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self waittill("damage", var_0, var_1);
  var_2 = 0.05;

  if(mine_so_detonated_recently()) {
    var_2 = 0.1 + randomfloat(0.4);
  }
  chembomb_detonate(var_2);
}

chembomb_detonate(var_0) {
  if(isDefined(self.chembomb_activated)) {
    return;
  }
  self.chembomb_activated = 1;
  level endon("special_op_terminated");
  self playSound("claymore_activated_SP");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  level.so_mine_last_detonate_time = gettime();
  self playSound("detpack_explo_main", "sound_done");
  physicsexplosioncylinder(self.origin, 256, 1, 0.5);
  earthquake(0.2, 0.4, self.origin, 600);
  playFX(common_scripts\utility::getfx("chemical_tank_explosion"), self.origin);
  stopFXOnTag(common_scripts\utility::getfx("chemical_mine_spew"), self.tag_origin, "tag_origin");
  thread chemical_ability_gas_cloud(self.origin, 6.0, 1.0);
  self.tag_origin delete();
  wait 0.05;

  if(isDefined(self)) {
    self delete();
  }
}

dog_relocate_init() {
  level.dog_reloc_trig_array = getEntArray("dog_relocate", "targetname");

  if(!isDefined(level.dog_reloc_trig_array) || level.dog_reloc_trig_array.size == 0) {
    return;
  }
  foreach(var_1 in level.dog_reloc_trig_array) {
    var_2 = common_scripts\utility::getStruct(var_1.target, "targetname");
    var_1.reloc_origin = var_2.origin;
    var_1 thread dog_reloc_monitor();
  }
}

dog_reloc_monitor() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("trigger", var_0);

    while(var_0 istouching(self)) {
      var_0.dog_reloc = self.reloc_origin;
      wait 0.05;
    }

    var_0.dog_reloc = undefined;
  }
}

spawn_dogs(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");

  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || !var_1) {
    return;
  }
  level.dogs = [];
  var_2 = [];

  foreach(var_4 in level.players) {}
  var_2[var_2.size] = var_4;

  var_6 = getEntArray("dog_spawner", "targetname")[0];
  level.dogs_attach_c4 = isDefined(var_0) && var_0 == "dog_splode";
  var_6 maps\_utility::add_spawn_function(::dog_setup);
  var_6 maps\_utility::add_spawn_function(::dog_seek_player);
  var_6 maps\_utility::add_spawn_function(::dog_register_death);

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_8 = maps/_so_survival_code::get_furthest_from_these(level.wave_spawn_locs, var_2, 4);
    var_6.count = 1;
    var_6.origin = var_8.origin;
    var_6.angles = var_8.angles;
    var_9 = int((40 + randomint(10)) / var_1);
    level.survival_dog_spawning = 1;
    var_10 = var_6 maps\_utility::spawn_ai(1);
    var_10.ai_type = get_wave_number_by_index(var_0);
    var_10 setthreatbiasgroup("dogs");
    var_10[[level.attributes_func]]();
    var_10.canclimbladders = 0;
    level.dogs[level.dogs.size] = var_10;
    level.survival_dog_spawning = undefined;

    if(!common_scripts\utility::flag("aggressive_mode")) {
      common_scripts\utility::waittill_any_timeout(var_9, "aggressive_mode");
    }
    wait 0.05;
  }
}

dog_setup() {
  self.badplaceawareness = 0;
  self.grenadeawareness = 0;

  if(isDefined(level.dogs_attach_c4) && level.dogs_attach_c4) {
    thread attach_c4("j_hip_base_ri", (6, 6, -3), (0, 0, 0));
    thread attach_c4("j_hip_base_le", (-6, -6, 3), (0, 0, 0));
    thread detonate_c4_when_dead(3, 0.4);
    thread dog_detonate_c4_near_sentry();
  }
}

dog_detonate_c4_near_sentry() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("c4_detonated");
  var_0 = self.origin;
  var_1 = self.origin;
  var_2 = gettime();

  for(;;) {
    wait 0.2;
    var_1 = self.origin;
    var_3 = gettime();

    if(distancesquared(var_1, var_0) > squared(10) || animscripts\dog\dog_combat::insyncmeleewithtarget()) {
      var_0 = var_1;
      var_2 = var_3;
    }

    if(!isDefined(level.placed_sentry) || !level.placed_sentry.size) {
      continue;
    }
    if(var_3 - var_2 < 2000) {
      continue;
    }
    var_4 = 0;

    foreach(var_6 in level.placed_sentry) {
      if(isDefined(var_6.carrier)) {
        continue;
      }
      if(distancesquared(var_1, var_6.origin) < squared(40)) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      break;
    } else {
      var_0 = var_1;
      var_2 = var_3;
    }
  }

  self notify("stop_dog_seek_player");
  self.ignoreall = 1;
  self setgoalpos(self.origin);
  self notify("force_c4_detonate");
}

dog_register_death() {
  self waittill("death");
  level.dogs = dog_get_living();
}

dog_seek_player() {
  level endon("special_op_terminated");
  level endon("wave_ended");
  self endon("death");
  self endon("stop_dog_seek_player");
  self.moveplaybackrate = 0.75;
  self.goalheight = 80;
  self.goalradius = 300;
  var_0 = 1.0;

  for(;;) {
    var_1 = maps\_utility::get_closest_player_healthy(self.origin);

    if(!isDefined(var_1)) {
      var_1 = maps\_utility::get_closest_player(self.origin);
    }
    if(isDefined(var_1)) {
      var_2 = self cansee(var_1);
      var_3 = distancesquared(self.origin, var_1.origin);

      if(isDefined(var_1.dog_reloc)) {
        self setgoalpos(var_1.dog_reloc);
      } else if((!var_2 || var_3 > 1048576) && isDefined(var_1.node_closest)) {
        self setgoalpos(var_1.node_closest.origin);
        self.goalradius = 24;
      } else {
        self setgoalpos(var_1.origin);
        self.goalradius = 384;
      }
    }

    wait(var_0);
  }
}

dog_get_count() {
  var_0 = dog_get_living().size;

  if(isDefined(level.survival_dog_spawning)) {
    var_0++;
  }
  return var_0;
}

dog_get_living() {
  if(!isDefined(level.dogs)) {
    level.dogs = [];
    return level.dogs;
  }

  var_0 = [];

  foreach(var_2 in level.dogs) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

survival_boss_juggernaut() {}

is_juggernaut_used(var_0) {
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "jug_")) {
      return 1;
    }
  }

  return 0;
}

spawn_juggernaut(var_0, var_1) {
  level endon("special_op_terminated");
  var_2 = drop_jug_by_chopper(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2.ai_type = get_wave_number_by_index(var_0);
  var_2.kill_assist_xp = int(get_ai_xp(var_0) * 0.2);
  var_2 maps/_so_survival_loot::loot_roll(0.0);
  level.bosses[level.bosses.size] = var_2;
  var_2 waittill("jumpedout");
  level notify("juggernaut_jumpedout");
  var_2 thread survival_boss_behavior();
  var_2 thread maps/_so_survival_code::clear_from_boss_array_when_dead();
}

drop_jug_by_chopper(var_0, var_1) {
  var_2 = maps/_so_survival_code::get_spawners_by_targetname(var_0)[0];
  var_2 maps\_utility::add_spawn_function(::money_fx_on_death);
  var_3 = maps/_so_survival_code::chopper_spawn_from_targetname_and_drive("jug_drop_chopper", var_1.origin, var_1);
  var_3 thread maps/_chopperboss::chopper_path_release("reached_dynamic_path_end death deathspin");
  var_3 maps\_vehicle::godon();
  var_3.script_vehicle_selfremove = 1;
  var_3 vehicle_setspeed(60 + randomint(15), 30, 30);
  var_3 thread maps/_so_survival_code::chopper_drop_smoke_at_unloading();
  var_3 maps/_so_survival_code::chopper_spawn_pilot_from_targetname("jug_drop_chopper_pilot");
  var_4 = var_3 maps/_so_survival_code::chopper_spawn_passenger(var_2);
  var_4 maps\_utility::deletable_magic_bullet_shield();
  var_4 thread maps\_utility::do_in_order(common_scripts\utility::waittill_any, "jumpedout", maps\_utility::stop_magic_bullet_shield);
  var_4 setthreatbiasgroup("boss");
  return var_4;
}

progressive_damaged() {
  self endon("death");
  self endon("new_jug_behavior");

  for(;;) {
    if(self.health <= 250) {
      self.walkdist = 500;
      self.walkdistfacingmotion = 500;
    } else {
      self.walkdist = 1000;
      self.walkdistfacingmotion = 1000;
    }

    wait 0.05;
  }
}

damage_factor() {
  self endon("death");
  self endon("new_jug_behavior");
  self.bullet_resistance = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.magic_bullet_shield)) {
      continue;
    }
    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_1) && isai(var_1) && self.team != var_1.team) {
      var_10 = printdebugtexthud(var_0, self.dmg_factor["ai_damage"]);
    } else if(var_4 == "MOD_MELEE") {
      if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_9) && issubstr(var_9, "riotshield_so")) {
        var_10 = printdebugtexthud(var_0, self.dmg_factor["melee_riotshield"]);
      } else {
        var_10 = printdebugtexthud(var_0, self.dmg_factor["melee"]);
      }
    } else if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH") {
      var_10 = printdebugtexthud(var_0, self.dmg_factor["explosive"]);
    } else if(maps/_so_survival_code::was_headshot()) {
      var_10 = printdebugtexthud(var_0, self.dmg_factor["headshot"]);
      var_11 = 1;
    } else {
      var_10 = printdebugtexthud(var_0, self.dmg_factor["bodyshot"]);
    }
    var_10 = int(var_10);

    if(var_10 < 0 && abs(var_10) >= self.health) {
      if(var_11) {
        self.died_of_headshot = 1;
      }
      thread maps/_so_survival_code::so_survival_kill_ai(var_1, var_4, var_9);
    } else {
      self.health = self.health + var_10;
    }
    self notify("dmg_factored");
  }
}

printdebugtexthud(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1) && var_1) {
    var_2 = int(var_0 * (1 - var_1));
  }
  return var_2;
}

global_jug_behavior() {
  self.dmg_factor["headshot"] = 1;
  self.dmg_factor["bodyshot"] = 1;
  self.dmg_factor["melee"] = 1;
  self.dmg_factor["melee_riotshield"] = 1;
  self.dmg_factor["explosive"] = 1;
  self.dmg_factor["ai_damage"] = 1;
  self.dropweapon = 0;
  self.minpaindamage = 350;
  maps\_utility::set_battlechatter(0);
  self.aggressing = 1;
  self.dontmelee = undefined;
  self.meleealwayswin = 1;
  thread damage_factor();
  thread progressive_damaged();
}

boss_jug_helmet_pop(var_0, var_1) {
  self endon("death");
  var_2 = self.health;

  if(isDefined(self.ai_type)) {
    var_2 = get_ai_health(self.ai_type.ref);
  }
  for(;;) {
    if(self.health / var_2 <= var_0) {
      animscripts\death::helmetpop();
      var_3 = self.dmg_factor.size;
      self.dmg_factor = maps\_utility::array_combine_keys(self.dmg_factor, var_1);
      return;
    }

    self waittill("dmg_factored");
  }
}

boss_jug_regular() {
  self.dmg_factor["headshot"] = 0.75;
  self.dmg_factor["bodyshot"] = 0.33;
  self.dmg_factor["melee"] = 0.25;
  self.dmg_factor["melee_riotshield"] = 0.25;
  self.dmg_factor["explosive"] = 0.33;
  self.dmg_factor["ai_damage"] = 0.33;
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  thread get_challenge_hud_params(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
}

boss_jug_headshot() {
  self.dmg_factor["headshot"] = 1.0;
  self.dmg_factor["bodyshot"] = 0.33;
  self.dmg_factor["melee"] = 0.25;
  self.dmg_factor["melee_riotshield"] = 0.25;
  self.dmg_factor["explosive"] = 1.0;
  self.dmg_factor["ai_damage"] = 0.25;
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  thread get_challenge_hud_params(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
}

boss_jug_explosive() {
  self.dmg_factor["headshot"] = 0.33;
  self.dmg_factor["bodyshot"] = 0.25;
  self.dmg_factor["melee"] = 0.25;
  self.dmg_factor["melee_riotshield"] = 0.25;
  self.dmg_factor["explosive"] = 0.33;
  self.dmg_factor["ai_damage"] = 0.25;
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  thread get_challenge_hud_params(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
}

boss_jug_riotshield() {
  self endon("death");
  self endon("riotshield_damaged");
  self.dmg_factor["headshot"] = 0.75;
  self.dmg_factor["bodyshot"] = 0.75;
  self.dmg_factor["melee"] = 0.33;
  self.dmg_factor["melee_riotshield"] = 0.33;
  self.dmg_factor["explosive"] = 1.0;
  self.dmg_factor["ai_damage"] = 0.25;

  if(getdvarint("survival_chaos") != 1) {
    self.dropriotshield = 1;
  }
  subclass_juggernaut_riotshield();

  if(getdvarint("survival_chaos") != 1) {
    thread juggernaut_abandon_shield();
  }
  if(1) {
    self.shieldbulletblocklimit = 9999;
  }
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  self.usechokepoints = 0;
  thread get_challenge_hud_params(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
  thread juggernaut_manage_min_pain_damage();
}

juggernaut_manage_min_pain_damage() {
  self endon("death");

  for(;;) {
    if(self.health <= 250) {
      self.minpaindamage = 250;
    } else {
      self.minpaindamage = 350;
    }
    wait 0.05;
  }
}

subclass_juggernaut_riotshield() {
  self.juggernaut = 1;
  self.doorflashchance = 0.05;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.no_pistol_switch = 1;
  self.norunngun = 1;
  self.disablearrivals = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.neversprintforvariation = 1;
  self.a.disablelongdeath = 1;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  self.meleealwayswin = 1;

  if(!self isbadguy()) {
    return;
  }
  level notify("juggernaut_spawned");
  thread subclass_juggernaut_death();
}

juggernaut_abandon_shield() {
  self endon("death");
  thread hud_blink(0.5);
  self waittill("riotshield_damaged");
  wait 0.05;
  ai_drop_riotshield();

  if(!isalive(self)) {
    return;
  }
  animscripts\riotshield\riotshield::riotshield_turn_into_regular_ai();
  thread maps/_juggernaut::subclass_juggernaut();
  self notify("new_jug_behavior");
  global_jug_behavior();
  thread boss_jug_regular();
}

hud_blink(var_0) {
  self endon("death");
  self endon("riotshield_damaged");
  var_1 = self.health;

  if(isDefined(self.ai_type)) {
    var_1 = get_ai_health(self.ai_type.ref);
  }
  for(;;) {
    self waittill("damage");

    if(self.health / var_1 <= var_0) {
      self notify("riotshield_damaged");
      return;
    }
  }
}

subclass_juggernaut_death() {
  self endon("new_jug_behavior");
  self waittill("death", var_0);

  if(getdvarint("survival_chaos") != 1) {
    ai_drop_riotshield();
  }
  level notify("juggernaut_died");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
}

survival_boss_chopper() {
  level.chopper_boss_min_dist2d = 128;
  maps/_chopperboss::chopper_boss_locs_populate("script_noteworthy", "so_chopper_boss_path_struct");
}

survival_drop_chopper_init() {
  var_0 = common_scripts\utility::getStructArray("drop_path_start", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2;

    while(isDefined(var_3)) {
      if(isDefined(var_3.script_unload)) {
        var_3.ground_pos = maps\_utility::groundpos(var_3.origin);
        break;
      }

      if(isDefined(var_3.target)) {
        var_3 = common_scripts\utility::getStruct(var_3.target, "targetname");
        continue;
      }

      break;
    }
  }
}

spawn_chopper_boss(var_0, var_1) {
  level endon("special_op_terminated");
  var_2 = maps/_so_survival_code::chopper_spawn_from_targetname(var_0, var_1.origin);
  var_2 maps/_so_survival_code::chopper_spawn_pilot_from_targetname("jug_drop_chopper_pilot");
  var_2 thread maps/_remotemissile_utility::setup_remote_missile_target();
  var_2.ai_type = get_wave_number_by_index(var_0);
  var_2[[level.attributes_func]]();

  if(isDefined(level.xp_enable) && level.xp_enable) {
    var_2 thread maps\_rank::ai_xp_init();
  }
  var_2.kill_assist_xp = int(get_ai_xp(var_0) * 0.2);
  level.bosses[level.bosses.size] = var_2;
  var_2 thread maps/_chopperboss::chopper_boss_behavior_little_bird(var_1);
  var_2 thread maps/_chopperboss::chopper_path_release("death deathspin");
  var_2 thread maps/_so_survival_code::clear_from_boss_array_when_dead();
  var_2 setthreatbiasgroup("boss");
  setthreatbias("sentry", "boss", 1500);

  foreach(var_4 in var_2.mgturret) {}
  var_4 setbottomarc(90);

  return var_2;
}

spawn_ally_team(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = maps/_so_survival_code::get_spawners_by_targetname(var_0)[0];

  if(!isDefined(var_5)) {
    return var_4;
  }
  var_6 = maps/_so_survival_code::chopper_spawn_from_targetname_and_drive("ally_drop_chopper", var_2.origin, var_2);
  var_6 thread maps/_chopperboss::chopper_path_release("reached_dynamic_path_end death deathspin");
  var_6 maps\_vehicle::godon();
  var_6 vehicle_setspeed(60 + randomint(15), 30, 30);
  var_6.script_vehicle_selfremove = 1;
  var_6 endon("death");
  var_6 maps/_so_survival_code::chopper_spawn_pilot_from_targetname("friendly_support_delta");

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_8 = var_6 maps/_so_survival_code::chopper_spawn_passenger(var_5, var_7 + 2);
    var_8 maps\_utility::set_battlechatter(0);
    var_8 maps\_utility::deletable_magic_bullet_shield();
    var_8 thread ally_remove_bullet_shield(20, "jumpedout");
    var_8 setthreatbiasgroup("allies");
    var_8.ignoreme = 1;
    var_8.ai_type = get_wave_number_by_index(var_0);
    var_8[[level.attributes_func]]();
    var_8 thread setup_ai_weapon();
    var_8.owner = var_3;
    var_4[var_4.size] = var_8;
    var_8.headiconteam = "allies";

    if(var_0 == "friendly_support_delta") {
      var_8.headicon = "headicon_delta_so";
    }
    if(var_0 == "friendly_support_riotshield") {
      var_8.headicon = "headicon_gign_so";
    }
    var_8.drawoncompass = 0;
    wait 0.05;
  }

  var_6 thread ally_team_setup(var_4);
  return var_4;
}

_geteye() {
  if(isDefined(self) && isalive(self)) {
    return self getEye();
  }
  return undefined;
}

ally_team_setup(var_0) {
  self endon("death");
  self waittill("unloaded");
  common_scripts\utility::array_thread(var_0, ::ally_setup);
}

ally_setup() {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 768);
  self.goalradius = 512;

  if(isDefined(self.ai_type) && issubstr(self.ai_type.ref, "riotshield")) {
    self.goalradius = 448;
    self setengagementmindist(200, 100);
    self setengagementmaxdist(512, 768);
    thread drop_riotshield_think();
    thread ally_manage_min_pain_damage(300);
  } else {
    thread ally_manage_min_pain_damage(150);
  }
  self.ignoreme = 0;
  self.fixednode = 0;
  self.dropweapon = 0;
  self.dropriotshield = 1;
  self.drawoncompass = 1;
  maps\_utility::set_battlechatter(1);
  self pushplayer(0);
  self.bullet_resistance = 30;
  thread ally_on_death();
  thread get_challenge_hud_params(4.0, self.goalradius);
}

ally_manage_min_pain_damage(var_0) {
  self endon("death");

  for(;;) {
    self.minpaindamage = var_0;
    wait 0.05;
  }
}

drop_riotshield_think() {
  self endon("death");
  common_scripts\utility::waittill_any_return("riotshield_damaged", "dog_attacks_ai");
  wait 0.05;
  ai_drop_riotshield();

  if(!isalive(self)) {
    return;
  }
  animscripts\riotshield\riotshield::riotshield_turn_into_regular_ai();
}

ally_remove_bullet_shield(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    self waittill(var_1);
  }
  wait(var_0);
  maps\_utility::stop_magic_bullet_shield();
}

ally_on_death() {
  self waittill("death");

  if(isDefined(self.owner) && isalive(self.owner)) {
    self.owner notify("ally_died");
  }
  ai_drop_riotshield();
}

setup_ai_weapon() {
  waittillframeend;

  if(isDefined(self.team) && self.team == "axis") {
    maps/_so_survival_loot::loot_roll();
  }
  if(isDefined(level.coop_incap_weapon)) {
    self.sidearm = level.coop_incap_weapon;
    maps\_utility::place_weapon_on(self.sidearm, "none");
  }

  var_0 = get_squad_array(self.ai_type.ref)[0];

  if(!isDefined(var_0) || var_0 == self.weapon) {
    return;
  }
  maps\_utility::forceuseweapon(var_0, "primary");
}

get_all_mine_locs() {
  var_0 = common_scripts\utility::getStructArray("so_claymore_loc", "targetname");
  return var_0;
}

ai_drop_riotshield() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.weaponinfo["iw5_riotshield_so"])) {
    var_0 = self.weaponinfo["iw5_riotshield_so"].position;

    if(isDefined(self.dropriotshield) && self.dropriotshield && var_0 != "none") {
      thread animscripts\shared::dropweaponwrapper("iw5_riotshield_so", var_0);
    }
    animscripts\shared::detachweapon("iw5_riotshield_so");
    self.weaponinfo["iw5_riotshield_so"].position = "none";
    self.a.weaponpos[var_0] = "none";
  }
}

get_challenge_hud_params(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");
  self endon("death");
  self.goalradius = common_scripts\utility::ter_op(isDefined(var_1), var_1, self.goalradius);
  self.goalheight = 80;

  if(isDefined(var_2)) {
    var_4 = strtok(var_2, " ");

    foreach(var_6 in var_4) {}
    self endon(var_6);
  }

  if(isDefined(var_3)) {
    var_8 = strtok(var_3, " ");

    foreach(var_10 in var_8) {}
    self notify(var_10);
  }

  survival_disable_sprint();
  var_12 = 1;
  var_13 = undefined;

  for(;;) {
    var_14 = maps\_utility::get_closest_player_healthy(self.origin);

    if(!isDefined(var_14)) {
      var_14 = maps\_utility::get_closest_player(self.origin);
    }
    if(!isDefined(var_14)) {
      wait(var_0);
      continue;
    }

    if(self.team == "allies") {
      if(distancesquared(self.origin, var_14.origin) > self.goalradius * self.goalradius) {
        self setgoalentity(var_14);
        wait 2;
        continue;
      }
    } else if(distancesquared(self.origin, var_14.origin) < self.goalradius * self.goalradius) {
      self getenemyinfo(var_14);
    }
    if(!isDefined(var_13) || var_13 != var_14) {
      var_13 = var_14;
      self setgoalentity(var_14);
      self notify("target_reset");
      thread bad_path_listener(var_14);
    }

    if(var_12) {
      var_12 = 0;

      if(self.team == "axis") {
        self getenemyinfo(var_14);
      }
    }

    survival_disable_sprint();

    if(self.team == "allies") {
      self setgoalpos(self.origin);

      if(isDefined(self.subclass) && self.subclass == "riotshield") {
        wait(randomfloatrange(0.2, 2.0));
        var_15 = self.goalradius;
        self.goalradius = 1.0;
        wait 0.1;
        self.goalradius = var_15;
      }
    }

    wait(var_0);
  }
}

bad_path_listener(var_0) {
  self endon("target_reset");
  self endon("death");

  for(;;) {
    self waittill("bad_path");

    if(isDefined(var_0.node_closest)) {
      self setgoalpos(var_0.node_closest.origin);
      var_1 = var_0.origin;

      while(distancesquared(var_1, var_0.origin) < 144) {
        wait 0.5;
      }
      self setgoalentity(var_0);
    }
  }
}

manage_ai_poll_player_state(var_0) {
  self endon("death");
  self endon("manage_ai_stop_polling_player_state");

  for(;;) {
    wait 0.1;

    if(!isDefined(var_0) || !isalive(var_0) || maps\_utility::is_player_down(var_0)) {
      self notify("manage_ai_player_invalid");
      return;
    } else if(distancesquared(self.origin, var_0.origin) <= self.goalradius * self.goalradius) {
      self notify("manage_ai_player_found");
      return;
    }
  }
}

ai_exist(var_0) {
  if(isDefined(var_0.node_closest)) {
    self setgoalpos(var_0.node_closest.origin);
  }
}

survival_enable_sprint() {
  if(isDefined(self.subclass) && self.subclass == "riotshield") {
    if(isDefined(self.juggernaut)) {
      maps/_riotshield::riotshield_fastwalk_on();
    } else {
      maps/_riotshield::riotshield_sprint_on();
    }
  } else if(isDefined(self.juggernaut)) {
    maps\_utility::enable_sprint();
  } else {
    self.combatmode = "no_cover";
  }
}

survival_disable_sprint() {
  if(isDefined(self.subclass) && self.subclass == "riotshield") {
    if(isDefined(self.juggernaut)) {
      maps/_riotshield::riotshield_fastwalk_off();
    } else {
      maps/_riotshield::riotshield_sprint_off();
    }
  } else if(isDefined(self.juggernaut)) {
    maps\_utility::disable_sprint();
  } else {
    self.combatmode = "cover";
  }
}

wave_exist(var_0) {
  return isDefined(level.survival_ai) && isDefined(level.survival_ai[var_0]);
}

get_wave_boss_delay(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].repeating;
  }
  return int(tablelookup("sp/survival_waves.csv", 1, var_0, 0));
}

get_wave_index(var_0) {
  return tablelookup("sp/survival_waves.csv", 0, var_0, 1);
}

get_wave_number_by_index(var_0) {
  var_1 = "Trying to get survival AI_type struct before stringtable is ready, or type doesnt exist.";
  return level.survival_ai[var_0];
}

get_squad_type(var_0) {
  if(isDefined(level.survival_ai_class_overrides) && isDefined(level.survival_ai_class_overrides[var_0])) {
    return level.survival_ai_class_overrides[var_0];
  }
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].classname;
  }
  return tablelookup("sp/survival_waves.csv", 1, var_0, 4);
}

get_squad_array(var_0) {
  if(isDefined(level.survival_ai_weapon_overrides) && isDefined(level.survival_ai_weapon_overrides[var_0])) {
    return level.survival_ai_weapon_overrides[var_0];
  }
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].weapon;
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 5);
  return strtok(var_1, " ");
}

get_special_ai(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].altweapon;
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 6);
  return strtok(var_1, " ");
}

get_special_ai_quantity(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].name;
  }
  return tablelookup("sp/survival_waves.csv", 1, var_0, 2);
}

get_special_ai_type_quantity(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].desc;
  }
  return tablelookup("sp/survival_waves.csv", 1, var_0, 3);
}

get_ai_health(var_0) {
  if(isDefined(level.survival_waves_repeated)) {
    var_1 = 1.0 + level.survival_waves_repeated * 0.1;
  } else {
    var_1 = 1.0;
  }
  if(wave_exist(var_0)) {
    return int(level.survival_ai[var_0].health * var_1);
  }
  var_2 = tablelookup("sp/survival_waves.csv", 1, var_0, 7);

  if(var_2 == "") {
    return undefined;
  }
  return int(int(var_2) * var_1);
}

get_ai_speed(var_0) {
  if(isDefined(level.survival_waves_repeated)) {
    var_1 = 1.0 + level.survival_waves_repeated * 0.05;
  } else {
    var_1 = 1.0;
  }
  if(wave_exist(var_0)) {
    return min(level.survival_ai[var_0].speed * var_1, 1.5);
  }
  var_2 = tablelookup("sp/survival_waves.csv", 1, var_0, 8);

  if(var_2 == "") {
    return undefined;
  }
  return min(float(var_2) * var_1, 1.5);
}

get_ai_accuracy(var_0) {
  if(isDefined(level.survival_waves_repeated)) {
    var_1 = 1.0 + level.survival_waves_repeated * 0.2;
  } else {
    var_1 = 1.0;
  }
  if(wave_exist(var_0)) {
    if(isDefined(level.survival_ai[var_0].accuracy)) {
      return level.survival_ai[var_0].accuracy * var_1;
    } else {
      return level.survival_ai[var_0].accuracy;
    }
  }

  var_2 = tablelookup("sp/survival_waves.csv", 1, var_0, 11);

  if(var_2 == "") {
    return undefined;
  }
  return float(var_2) * var_1;
}

get_ai_xp(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_ai[var_0].xp;
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 9);

  if(var_1 == "") {
    return undefined;
  }
  return int(var_1);
}

is_ai_boss(var_0) {
  if(wave_exist(var_0) && isDefined(level.survival_boss)) {
    return isDefined(level.survival_boss[var_0]);
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 10);

  if(!isDefined(var_1) || var_1 == "") {
    return 0;
  }
  return 1;
}

wave_exist(var_0) {
  return isDefined(level.survival_wave) && isDefined(level.survival_wave[var_0]);
}

get_wave_boss_delay(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D4F;
  }
  return int(tablelookup(level.wave_table, 2, var_0, 1));
}

get_wave_index(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0].repeating;
  }
  return int(tablelookup(level.wave_table, 2, var_0, 0));
}

get_wave_number_by_index(var_0) {
  return int(tablelookup(level.wave_table, 0, var_0, 2));
}

get_squad_type(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D4B;
  }
  return tablelookup(level.wave_table, 2, var_0, 3);
}

get_squad_array(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D4C;
  }
  var_1 = [];
  var_2 = int(tablelookup(level.wave_table, 2, var_0, 4));

  if(var_2 <= 3) {
    var_1[0] = var_2;
  } else {
    var_3 = var_2 % 3;
    var_4 = int(var_2 / 3);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_1[var_5] = 3;
    }
    if(var_3 == 1) {
      if(level.merge_squad_member_max == 4) {
        var_1[var_1.size - 1] = var_1[var_1.size - 1] + var_3;
      } else {
        var_6 = 1;
        var_1[var_1.size - 1] = var_1[var_1.size - 1] - var_6;
        var_1[var_1.size] = var_3 + var_6;
      }
    } else if(var_3 == 2) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

get_special_ai(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D4D;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 5);

  if(isDefined(var_1) && var_1 != "") {
    return strtok(var_1, " ");
  }
  return undefined;
}

get_special_ai_quantity(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D4E;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 6);
  var_2 = [];

  if(isDefined(var_1) && var_1 != "") {
    var_1 = strtok(var_1, " ");

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_2[var_3] = int(var_1[var_3]);
    }
    return var_2;
  }

  return undefined;
}

get_special_ai_type_quantity(var_0, var_1) {
  var_2 = get_special_ai(var_0);
  var_3 = get_special_ai_quantity(var_0);

  if(isDefined(var_2) && isDefined(var_3) && var_2.size && var_3.size) {
    foreach(var_6, var_5 in var_2) {
      if(var_1 == var_5) {
        return var_3[var_6];
      }
    }
  }

  return 0;
}

get_bosses_ai(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D50;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 7);

  if(isDefined(var_1) && var_1 != "") {
    return strtok(var_1, " ");
  }
  return undefined;
}

get_bosses_nonai(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D51;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 8);

  if(isDefined(var_1) && var_1 != "") {
    return strtok(var_1, " ");
  }
  return undefined;
}

is_repeating(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D54;
  }
  return int(tablelookup(level.wave_table, 2, var_0, 9));
}

get_armory_unlocked(var_0) {
  var_1 = tablelookup(level.wave_table, 2, var_0, 10);
  var_1 = strtok(var_1, " ");
  return var_1;
}

get_dog_type(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D52;
  }
  var_1 = get_special_ai(var_0);

  if(!isDefined(var_1) || !var_1.size) {
    return "";
  }
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "dog")) {
      return var_3;
    }
  }

  return "";
}

get_dog_quantity(var_0) {
  if(wave_exist(var_0)) {
    return level.survival_wave[var_0]._id_3D53;
  }
  var_1 = get_dog_type(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }
  return get_special_ai_type_quantity(var_0, var_1);
}