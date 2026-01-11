/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_crafting_traps.gsc
*********************************************/

init() {
  level._effect["tesla_idle"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_idle");
  level._effect["tesla_idle2"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_idle2");
  level._effect["tesla_idle3"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_idle3");
  level._effect["tesla_death"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_death");
  level._effect["tesla_connect"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_connect");
  level._effect["tesla_connect_50"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_connect_50");
  level._effect["tesla_connect_100"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_connect_100");
  level._effect["tesla_connect_150"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_connect_150");
  level._effect["tesla_connect_200"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_connect_200");
  level._effect["tesla_connect_250"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_connect_250");
  level._effect["tesla_attack"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_attack");
  level._effect["tesla_shock"] = loadfx("vfx/gameplay/alien/vfx_alien_tesla_shock");
  level._effect["tesla_ball"] = loadfx("vfx/_requests/mp_alien_beacon/vfx_ball_lightning");
  level._effect["tesla_ball_attack"] = loadfx("vfx/_requests/mp_alien_beacon/vfx_ball_lightning_tendrils");
  level._effect["actuator_active"] = loadfx("vfx/moments/alien/alien_hypno_trap_triggered");
  level._effect["actuator_idle"] = loadfx("vfx/moments/alien/alien_hypno_trap_ambient");
  level._effect["sticky_explode"] = loadfx("vfx/gameplay/alien/vfx_alien_pipebomb_exp_01");

  if(!isDefined(level.alien_crafting_table)) {
    level.alien_crafting_table = "mp/alien/crafting_traps.csv";
  }

  var_0 = 0;
  var_1 = 99;

  for(var_2 = var_0; var_2 < var_1; var_2++) {
    var_3 = tablelookup(level.alien_crafting_table, 0, var_2, 1);

    if(var_3 == "") {
      break;
    }

    var_4 = spawnStruct();
    var_4.streakname = tablelookup(level.alien_crafting_table, 0, var_2, 1);
    var_4.idx = var_2;
    var_4.weaponinfo = "ims_projectile_mp";
    var_4.modelbase = tablelookup(level.alien_crafting_table, 0, var_2, 4);
    var_4.modeldestroyed = "ims_scorpion_body_iw6";
    var_4.modelplacement = tablelookup(level.alien_crafting_table, 0, var_2, 16);
    var_4.modelplacementfailed = tablelookup(level.alien_crafting_table, 0, var_2, 17);
    var_4.item_class = tablelookup(level.alien_crafting_table, 0, var_2, 5);
    var_4.item_name_ref = tablelookup(level.alien_crafting_table, 0, var_2, 2);
    var_4.item_damage = int(tablelookup(level.alien_crafting_table, 0, var_2, 9));
    var_4.item_damage_rate = float(tablelookup(level.alien_crafting_table, 0, var_2, 8));
    var_4.item_damage_radius = int(tablelookup(level.alien_crafting_table, 0, var_2, 7));
    var_4.item_damage_falloff = int(tablelookup(level.alien_crafting_table, 0, var_2, 11));
    var_4.hintstring = &"ALIEN_CRAFTING_PICKUP_CRAFTED_ITEM";
    var_4.placestring = &"ALIEN_CRAFTING_PLACE_CRAFTED_ITEM";
    var_4.cannotplacestring = &"ALIEN_CRAFTING_CANNOT_PLACE";
    var_4.placestringnocancel = &"ALIEN_CRAFTING_PLACE_CRAFTED_ITEM_NOCANCEL";
    var_4.headiconheight = 75;
    var_4.splashname = "used_placeable_barrier";
    var_4.lifespan = int(tablelookup(level.alien_crafting_table, 0, var_2, 10));
    var_4.maxhealth = 500;
    var_4.allowmeleedamage = 0;
    var_4.damagefeedback = "ims";
    var_4.xppopup = "destroyed_ims";
    var_4.destroyedvo = "ims_destroyed";
    var_4.onplaceddelegate = ::onplaced;
    var_4.oncarrieddelegate = ::oncarried;
    var_4.placedsfx = "ims_plant";
    var_4.ondamageddelegate = ::ondamaged;
    var_4.ondeathdelegate = ::ondeath;
    var_4.deathvfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
    var_4.colradius = 72;
    var_4.colheight = 36;
    var_4.placementradius = 24.0;
    var_4.placementheighttolerance = 11.5;
    var_4.ingredientslist = strtok(var_4.streakname, "_");

    if(var_4.streakname == "placeable_generator") {
      var_4.placementoffsetz = 10;
    }

    level.placeableconfigs[var_4.streakname] = var_4;
  }

  level thread init_smartcrafting_lists();
}

tryuseplaceable(var_0) {
  var_1 = maps\mp\alien\_crafting::giveplaceable(var_0);
  self.iscarrying = undefined;
  return var_1;
}

onplaced(var_0) {
  var_1 = level.placeableconfigs[var_0];
  self setModel(var_1.modelbase);

  switch (var_1.item_class) {
    case "tesla":
      thread setup_tesla_craftable(var_1);
      break;
    case "trap":
      thread setup_trap_craftable(var_1);
      break;
    case "generator":
      thread setup_generator(var_1);
      break;
  }
}

oncarried(var_0) {
  if(!isDefined(level.connected_generators)) {
    return;
  }
  if(common_scripts\utility::array_contains(level.connected_generators, self)) {
    level.connected_generators = common_scripts\utility::array_remove(level.connected_generators, self);
  }

  disconnect_tesla();

  foreach(var_2 in level.connected_generators) {
    if(var_2 == self) {
      continue;
    }
    if(isDefined(var_2.connected_teslas) && common_scripts\utility::array_contains(var_2.connected_teslas, self)) {
      common_scripts\utility::array_remove(var_2.connected_teslas, self);
    }

    remove_connections_to_this_tesla(var_2);
  }

  self.connected_teslas = [];
}

disconnect_tesla() {
  if(isDefined(self.fx)) {
    foreach(var_1 in self.fx) {
      if(isDefined(var_1)) {
        var_1 delete();
        self.fx = common_scripts\utility::array_remove(self.fx, var_1);
      }
    }
  }
}

remove_connections_to_this_tesla(var_0) {
  if(isDefined(var_0.fx)) {
    var_1 = var_0.fx;

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && isDefined(var_3.connected_to) && var_3.connected_to == self) {
        var_3 delete();
        var_0.fx = common_scripts\utility::array_remove(var_0.fx, var_3);
      }
    }
  }
}

ondamaged(var_0, var_1, var_2, var_3) {
  return var_3;
}

ondeath(var_0) {
  disablecollision(var_0);
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(var_1.deathsfx)) {
    self playSound(var_1.deathsfx);
  }

  disconnect_tesla();

  if(isDefined(level.connected_generators) && common_scripts\utility::array_contains(level.connected_generators, self)) {
    level.connected_generators = common_scripts\utility::array_remove(level.connected_generators, self);

    foreach(var_3 in level.connected_generators) {
      if(var_3 == self) {
        continue;
      }
      if(isDefined(var_3.connected_teslas) && common_scripts\utility::array_contains(var_3.connected_teslas, self)) {
        common_scripts\utility::array_remove(var_3.connected_teslas, self);
      }

      remove_connections_to_this_tesla(var_3);
    }
  }

  if(var_1.item_class == "tesla") {
    playFXOnTag(level._effect["tesla_death"], self, "tag_fx_01");
  }

  wait 0.5;
}

disablecollision(var_0) {
  if(isDefined(self.collision)) {
    badplace_delete(var_0 + self getentitynumber());
    self.collision delete();
    self.collision = undefined;
  }
}

setup_tesla_craftable(var_0) {
  switch (var_0.item_name_ref) {
    case "tesla_generator_adv":
    case "tesla_generator_med":
    case "tesla_generator_basic":
      thread craftable_tesla_generator(var_0);
  }
}

craftable_tesla_generator(var_0) {
  self endon("death");
  self endon("carried");

  if(!maps\mp\alien\_utility::is_true(self.playing_loopsound)) {
    self.playing_loopsound = 1;
    self playLoopSound("alien_fence_hum_lp");
  }

  level notify("generator_placed", self);
  self.tesla_type = var_0.item_name_ref;
  self.fire_rate = var_0.item_damage_rate;
  self.damage_amount = var_0.item_damage;
  level thread tesla_generator_amb_fx(self);
  level thread watch_for_nearby_generators(self);

  if(isDefined(self.attack_bolt)) {
    wait 0.5;

    if(isDefined(self.attack_bolt)) {
      self.attack_bolt delete();
    }
  }

  self.attack_bolt = spawn("script_model", self.origin + (0, 0, 30));
  self.attack_bolt setModel("tag_origin");
  wait 1;
  var_1 = 62500;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.agentarray) {
      if(!maps\mp\alien\_utility::is_true(var_4.isactive) || !isalive(var_4)) {
        continue;
      }
      if(isDefined(var_4.pet) && var_4.pet) {
        continue;
      }
      if(maps\mp\alien\_utility::is_true(var_4.is_electrified)) {
        continue;
      }
      if(distancesquared(var_4.origin + (0, 0, 30), self.origin + (0, 0, 30)) <= var_1 && bullettracepassed(var_4.origin + (0, 0, 30), self.origin + (0, 0, 30), 0, self)) {
        var_4.is_electrified = 1;
        var_4 thread tesla_bolt_death(self);
        reset_attack_bolt();
        wait(self.fire_rate);
      }
    }

    wait 0.1;
  }
}

reset_attack_bolt() {
  self endon("death");
  self endon("carried");
  var_0 = (0, 0, 30);

  if(isDefined(self.is_tesla_ball)) {
    var_0 = (0, 0, 0);
  }

  var_1 = 0;

  while(isDefined(self.attack_bolt)) {
    wait 0.1;
    var_1++;

    if(var_1 > 15) {
      self.attack_bolt delete();
    }
  }

  self.attack_bolt = spawn("script_model", self.origin + var_0);
  self.attack_bolt setModel("tag_origin");
}

watch_for_nearby_generators(var_0) {
  var_0 endon("death");
  var_0 endon("carried");
  var_1 = 62500;

  for(;;) {
    level waittill("generator_placed", var_2);

    if(should_connect_teslas(var_0, var_2, var_1)) {
      if(!isDefined(level.connected_generators)) {
        level.connected_generators = [];
      }

      if(!common_scripts\utility::array_contains(level.connected_generators, var_0)) {
        level.connected_generators = common_scripts\utility::add_to_array(level.connected_generators, var_0);
      }

      if(!common_scripts\utility::array_contains(level.connected_generators, var_2)) {
        level.connected_generators = common_scripts\utility::add_to_array(level.connected_generators, var_2);
      }

      level thread connect_tesla_generators(var_0, var_2);
    }
  }
}

get_center_of_connected_teslas(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 35;
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.connected_generators) {
    var_1 = var_1 + var_5.origin[0];
    var_2 = var_2 + var_5.origin[1];
    var_3 = var_3 + (var_5.origin[2] + var_0);
  }

  var_7 = max(1, level.connected_generators.size);
  var_8 = (var_1 / var_7, var_2 / var_7, var_3 / var_7);
  return var_8;
}

get_center_of_alive_players() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(!isalive(var_5) || isDefined(var_5.laststand) && var_5.laststand) {
      continue;
    }
    var_0 = var_0 + var_5.origin[0];
    var_1 = var_1 + var_5.origin[1];
    var_2 = var_2 + (var_5.origin[2] + 80);
    var_3++;
  }

  var_7 = max(1, var_3);
  var_8 = (var_0 / var_7, var_1 / var_7, var_2 / var_7);
  return var_8;
}

should_connect_teslas(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, var_1.origin) <= var_2 && sighttracepassed(var_0.origin + (0, 0, 30), var_1.origin + (0, 0, 30), 0, var_0, var_1)) {
    if(abs(var_0.origin[2] - var_1.origin[2]) >= 60) {
      return 0;
    }
    else {
      return 1;
    }
  }

  return 0;
}

connect_tesla_generators(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("carried");
  var_1 endon("carried");
  level thread perimiter_defense_think(var_0, var_1);
  var_2 = undefined;
  var_3 = distance(var_0.origin, var_1.origin);

  if(var_3 <= 65) {
    var_2 = "tesla_connect_50";
  }
  else if(var_3 <= 115) {
    var_2 = "tesla_connect_100";
  }
  else if(var_3 <= 165) {
    var_2 = "tesla_connect_150";
  }
  else if(var_3 <= 215) {
    var_2 = "tesla_connect_200";
  }
  else if(var_3 <= 260) {
    var_2 = "tesla_connect_250";
  }

  if(!isDefined(var_0.connected_teslas)) {
    var_0.connected_teslas = [];
  }

  if(!isDefined(var_1.connected_teslas)) {
    var_1.connected_teslas = [];
  }

  if(!common_scripts\utility::array_contains(var_1.connected_teslas, var_0)) {
    var_1.connected_teslas = common_scripts\utility::add_to_array(var_1.connected_teslas, var_0);
  }

  if(!common_scripts\utility::array_contains(var_0.connected_teslas, var_1)) {
    var_0.connected_teslas = common_scripts\utility::add_to_array(var_0.connected_teslas, var_1);
  }

  if(level.connected_generators.size >= 3 && !maps\mp\alien\_utility::is_true(level.beacon_easter_egg_active) && level.script == "mp_alien_beacon") {
    var_4 = 1;

    for(var_5 = 0; var_5 < level.connected_generators.size; var_5++) {
      if(level.connected_generators[var_5].connected_teslas.size < 2) {
        var_4 = 0;
      }
    }

    if(var_4) {
      var_6 = get_center_of_connected_teslas();
      playsoundatpos(var_6, "venom_lightning_expl");
      level thread create_ball_lightning(var_6);
    }
  }

  if(!isDefined(var_0.fx)) {
    var_0.fx = [];
  }

  if(!isDefined(var_1.fx)) {
    var_1.fx = [];
  }

  var_7 = spawnfx(level._effect[var_2], var_0.origin + (0, 0, 55), var_0.origin + (0, 0, 55) - (var_1.origin + (0, 0, 30)), anglestoup(var_0.angles));
  var_7.generator = var_0;
  var_7.connected_to = var_1;
  triggerfx(var_7);
  var_0.fx[var_0.fx.size] = var_7;
  var_8 = spawnfx(level._effect[var_2], var_1.origin + (0, 0, 55), var_1.origin + (0, 0, 55) - (var_0.origin + (0, 0, 30)), anglestoup(var_1.angles));
  var_8.generator = var_1;
  var_8.connected_to = var_0;
  triggerfx(var_8);
  var_1.fx[var_1.fx.size] = var_8;
}

create_ball_lightning(var_0) {
  level endon("cancel_ball_lightning");

  if(isDefined(level.creating_ball_lightning)) {
    return;
  }
  level.creating_ball_lightning = 1;
  playFX(level._effect["electric_blast"], var_0);
  wait 9.25;
  level thread electric_ball_lightning(var_0);
  level.beacon_easter_egg_active = 1;
  level.creating_ball_lightning = undefined;
}

electric_ball_lightning(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  var_1.damage_amount = 1500;
  var_1.is_tesla_ball = 1;
  var_1 playLoopSound("alien_fence_hum_lp");
  level endon("tesla_ball_timeout");
  playsoundatpos(var_0, "venom_lightning_expl");
  wait 0.2;
  level thread electric_ball_lightning_movement(var_1);
  level thread electric_ball_lightning_damage(var_1);
  level thread electric_ball_lightning_timeout(var_1);

  for(;;) {
    playFXOnTag(level._effect["tesla_ball"], var_1, "tag_origin");
    wait 9.25;
  }
}

electric_ball_lightning_timeout(var_0) {
  wait 180;
  level notify("tesla_ball_timeout");
  wait 1;

  if(isDefined(var_0.attack_bolt)) {
    var_0.attack_bolt delete();
  }

  level.beacon_easter_egg_active = 0;
  var_0 stoploopsound();
  var_0 delete();
}

electric_ball_lightning_movement(var_0) {
  level endon("tesla_ball_timeout");
  level endon("game_ended");
  var_1 = 90000;

  for(;;) {
    var_2 = get_center_of_alive_players();

    if(distance2dsquared(var_0.origin, var_2) > var_1) {
      var_0 moveto(var_2, 1);
      wait 0.75;
    }

    wait 0.2;
  }
}

spawn_attack_bolt() {
  self.attack_bolt = spawn("script_model", self.origin);
  self.attack_bolt setModel("tag_origin");
  wait 0.1;
}

electric_ball_lightning_damage(var_0) {
  level endon("tesla_ball_timeout");
  var_0 spawn_attack_bolt();
  var_1 = 202500;

  for(;;) {
    foreach(var_3 in level.agentarray) {
      if(!maps\mp\alien\_utility::is_true(var_3.isactive) || !isalive(var_3)) {
        continue;
      }
      if(isDefined(var_3.pet) && var_3.pet) {
        continue;
      }
      if(maps\mp\alien\_utility::is_true(var_3.is_electrified)) {
        continue;
      }
      if(distancesquared(var_3.origin + (0, 0, 30), var_0.origin) <= var_1 && bullettracepassed(var_3.origin + (0, 0, 30), var_0.origin, 0, var_0)) {
        var_0.attack_bolt.origin = var_0.origin;
        playFXOnTag(level._effect["tesla_ball_attack"], var_0, "tag_origin");
        var_3.is_electrified = 1;
        var_3 thread tesla_bolt_death(var_0);
        var_0 thread reset_attack_bolt();
        wait 3;
      }
    }

    wait 0.1;
  }
}

perimiter_defense_think(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("carried");
  var_1 endon("carried");
  var_2 = distancesquared(var_0.origin, var_1.origin);
  var_3 = [var_0, var_1];

  for(;;) {
    foreach(var_5 in level.agentarray) {
      if(!maps\mp\alien\_utility::is_true(var_5.isactive) || !isalive(var_5)) {
        continue;
      }
      if(isDefined(var_5.pet) && var_5.pet) {
        continue;
      }
      if(maps\mp\alien\_utility::is_true(var_5.is_electrified)) {
        continue;
      }
      if(distancesquared(var_0.origin, var_5.origin) > var_2) {
        continue;
      }
      if(common_scripts\utility::within_fov(var_0.origin + (0, 0, 30), vectortoangles(var_1.origin + (0, 0, 30) - (var_0.origin + (0, 0, 30))), var_5.origin + (0, 0, 30), 0.85)) {
        var_5.is_electrified = 1;
        playFX(level._effect["tesla_shock"], var_5.origin + (0, 0, 30));
        var_5 thread perimiter_death(var_0, var_1);
      }
    }

    wait 0.1;
  }
}

tesla_bolt_death(var_0) {
  self endon("death");
  playFXOnTag(level._effect["tesla_attack"], var_0.attack_bolt, "TAG_ORIGIN");
  var_0.attack_bolt moveto(self.origin + (0, 0, 30), 0.05);
  var_0.attack_bolt waittill("movedone");
  playFXOnTag(level._effect["tesla_shock"], var_0.attack_bolt, "tag_origin");
  self playSound("tesla_shock");
  wait 0.05;

  if(isDefined(var_0.attack_bolt)) {
    var_0.attack_bolt delete();
  }

  if(isDefined(var_0.owner) && isalive(var_0.owner)) {
    self dodamage(var_0.damage_amount, self.origin, var_0.owner, var_0, "MOD_UNKNOWN");
  }
  else {
    var_1 = undefined;
    var_2 = undefined;
    self dodamage(var_0.damage_amount, self.origin, var_1, var_2, "MOD_UNKNOWN");
  }

  wait 2;
  self.is_electrified = undefined;
}

perimiter_death(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0.owner) && isalive(var_0.owner) && isDefined(var_1.owner) && isalive(var_1.owner)) {
    self dodamage(1500, self.origin, var_0.owner, var_0, "MOD_UNKNOWN");
    self dodamage(1500, self.origin, var_1.owner, var_1, "MOD_UNKNOWN");
  } else {
    var_2 = undefined;
    var_3 = undefined;
    self dodamage(3000, self.origin, var_3, var_2, "MOD_UNKNOWN");
  }

  wait 2;
  self.is_electrified = undefined;
}

tesla_generator_amb_fx(var_0) {
  var_0 endon("death");
  var_0 endon("carried");
  wait 0.5;

  switch (var_0.tesla_type) {
    case "tesla_generator_basic":
      playFXOnTag(level._effect["tesla_idle"], var_0, "tag_fx_01");
      break;
    case "tesla_generator_med":
      playFXOnTag(level._effect["tesla_idle2"], var_0, "tag_fx_01");
      break;
    case "tesla_generator_adv":
      playFXOnTag(level._effect["tesla_idle3"], var_0, "tag_fx_01");
      break;
  }
}

setup_generator(var_0) {
  switch (var_0.item_name_ref) {
    case "generator":
      break;
  }
}

setup_trap_craftable(var_0) {
  switch (var_0.item_name_ref) {
    case "pet_trap":
      thread craftable_pet_trap(var_0);
      break;
  }
}

craftable_pet_trap(var_0) {
  self endon("death");
  self endon("carried");
  wait 1;

  if(!isDefined(self.enemy_trigger)) {
    self.enemy_trigger = spawn("trigger_radius", self.origin, 1, 64, 64);
  }

  self.enemy_trigger.origin = self.origin;
  thread pet_trap_idle_fx();
  self.is_pet_trap = 1;

  if(!isDefined(self.ammocount)) {
    self.ammocount = 2;
  }

  if(self.ammocount < 1) {
    self notify("stop_monitor");
    self.enemy_trigger delete();
    self delete();
    return;
  }

  self.disabled = 0;

  if(!maps\mp\alien\_utility::is_chaos_mode()) {
    level thread pet_trap_monitor(self);
  }

  for(;;) {
    self.enemy_trigger waittill("trigger", var_1);

    if(self.disabled) {
      continue;
    }
    if(!isplayer(var_1) && !maps\mp\alien\_utility::is_true(var_1.pet)) {
      if(!isDefined(var_1.alien_type)) {
        continue;
      }
      var_2 = var_1.alien_type;

      if(var_2 == "seeder" || var_2 == "minion" || var_2 == "mammoth" || var_2 == "gargoyle" || var_2 == "bomber" || var_2 == "ancestor") {
        continue;
      }
      playFX(level._effect["actuator_active"], self.origin + (0, 0, 20));
      self playSound("pet_trap_activate");
      var_1 convertalientopet(self.owner, var_1, self);
      self.ammocount--;

      if(self.ammocount < 1) {
        self notify("stop_monitor");
        killfxontag(level._effect["actuator_idle"], self, "tag_fx");
        self.enemy_trigger delete();
        self delete();
        return;
      }

      stopFXOnTag(level._effect["actuator_idle"], self, "tag_fx");
      wait 3;
      playFXOnTag(level._effect["actuator_idle"], self, "tag_fx");
    }
  }
}

pet_trap_monitor(var_0) {
  var_0 endon("death");
  var_0 endon("carried");
  var_0 endon("stop_monitor");

  for(;;) {
    if(maps\mp\alien\_pillage::check_for_existing_pet_bombs() > 1) {
      killfxontag(level._effect["actuator_idle"], var_0, "tag_fx");
      var_0.disabled = 1;

      if(isDefined(var_0.owner) && isalive(var_0.owner)) {
        var_0.owner maps\mp\_utility::setlowermessage("trap_disabled", &"ALIEN_CRAFTING_PETTRAP_DISABLED", 3);
      }

      while(maps\mp\alien\_pillage::check_for_existing_pet_bombs() > 1) {
        wait 1;
      }

      if(isDefined(var_0.owner) && isalive(var_0.owner)) {
        var_0.owner maps\mp\_utility::setlowermessage("trap_disabled", &"ALIEN_CRAFTING_PETTRAP_ENABLED", 3);
      }

      playFXOnTag(level._effect["actuator_idle"], var_0, "tag_fx");
      var_0.disabled = 0;
    }

    wait 1;
  }
}

pet_trap_idle_fx() {
  self endon("death");
  self endon("carried");
  self playLoopSound("pet_trap");
  playFXOnTag(level._effect["actuator_idle"], self, "tag_fx");
}

convertalientopet(var_0, var_1, var_2) {
  var_1 dodamage(var_1.health * 10, var_1.origin, var_0, var_2, "MOD_IMPACT");
}

trygiveweapon(var_0) {
  switch (level.placeableconfigs[var_0].item_name_ref) {
    case "pipe_bomb":
      thread craftable_pipe_bomb(var_0);
      break;
    case "sticky_flare":
      thread craftable_sticky_flare(var_0);
      break;
    case "venomfx_grenade":
    case "venomlx_grenade":
    case "venomx_grenade_alt":
    case "venomx_grenade":
      thread craftable_venomx_grenade(var_0);
      break;
    case "cortex_grenade":
      thread craftable_cortex_grenade(var_0);
      break;
  }
}

craftable_venomx_grenade(var_0) {
  self setoffhandprimaryclass("other");
  self takeweapon("alienclaymore_mp");
  self takeweapon("alienbetty_mp");
  self takeweapon("alienmortar_shell_mp");
  self takeweapon("aliensemtex_mp");
  self takeweapon("iw6_aliendlc22_mp");
  self takeweapon("iw6_aliendlc31_mp");
  self takeweapon("iw6_aliendlc32_mp");
  self takeweapon("iw6_aliendlc33_mp");
  var_1 = undefined;

  switch (level.placeableconfigs[var_0].item_name_ref) {
    case "venomx_grenade_alt":
      var_1 = "iw6_aliendlc31_mp";
      break;
    case "venomx_grenade":
      var_1 = "iw6_aliendlc31_mp";
      break;
    case "venomlx_grenade":
      var_1 = "iw6_aliendlc32_mp";
      break;
    case "venomfx_grenade":
      var_1 = "iw6_aliendlc33_mp";
      break;
  }

  self giveweapon(var_1);
  self setweaponammoclip(var_1, 5);
}

craftable_pipe_bomb(var_0) {
  self setoffhandprimaryclass("other");
  self takeweapon("alienclaymore_mp");
  self takeweapon("alienbetty_mp");
  self takeweapon("alienmortar_shell_mp");
  self takeweapon("aliensemtex_mp");
  self takeweapon("iw6_aliendlc22_mp");

  if(level.script == "mp_alien_last") {
    self takeweapon("iw6_aliendlc43_mp");
  }

  self giveweapon("iw6_aliendlc22_mp");
  self setweaponammoclip("iw6_aliendlc22_mp", 5);
}

craftable_sticky_flare(var_0) {
  self setoffhandsecondaryclass("flash");
  self takeweapon("alienflare_mp");
  self takeweapon("alientrophy_mp");
  self takeweapon("alienthrowingknife_mp");
  self takeweapon("iw6_aliendlc21_mp");
  self giveweapon("iw6_aliendlc21_mp");
  self setweaponammoclip("iw6_aliendlc21_mp", 2);
}

craftable_cortex_grenade(var_0) {
  self setoffhandprimaryclass("other");
  self takeweapon("alienclaymore_mp");
  self takeweapon("alienbetty_mp");
  self takeweapon("alienmortar_shell_mp");
  self takeweapon("aliensemtex_mp");
  self takeweapon("iw6_aliendlc22_mp");
  self takeweapon("iw6_aliendlc43_mp");
  self giveweapon("iw6_aliendlc43_mp");
  self setweaponammoclip("iw6_aliendlc43_mp", 5);
}

can_craft_sticky_flare(var_0) {
  var_1 = level.offhand_secondaries;
  var_2 = 0;
  var_3 = self getweaponslistoffhands();

  foreach(var_5 in var_3) {
    foreach(var_7 in var_1) {
      if(var_5 != var_7) {
        continue;
      }
      if(isDefined(var_5) && var_5 != "none" && self getammocount(var_5) > 0) {
        var_8 = undefined;
        var_9 = undefined;
        var_10 = undefined;
        var_11 = undefined;

        switch (var_5) {
          case "alienflare_mp":
            var_8 = "alienflare_mp";
            var_9 = "flare";
            var_10 = "alienflare_mp";
            var_11 = 1;
            break;
          case "alientrophy_mp":
            var_8 = "alientrophy_mp";
            var_9 = "trophy";
            var_10 = "alientrophy_mp";
            var_11 = 1;
            break;
          case "alienthrowingknife_mp":
            var_8 = "alienthrowingknife_mp";
            var_9 = "pet_leash";
            var_10 = "alienthrowingknife_mp";
            var_11 = 1;
            break;
          case "iw6_aliendlc21_mp":
            if(self getfractionmaxammo("iw6_aliendlc21_mp") < 1) {
              self givemaxammo("iw6_aliendlc21_mp");
              return 1;
            } else
              return 0;
        }

        drop_pillagable_item(var_8, var_9, var_10, var_11);
        return 1;
      }
    }
  }

  return 1;
}

can_craft_cortex_grenade(var_0) {
  var_1 = level.offhand_explosives;
  var_2 = 0;
  var_3 = self getweaponslistoffhands();

  foreach(var_5 in var_3) {
    foreach(var_7 in var_1) {
      if(var_5 != var_7) {
        continue;
      }
      if(isDefined(var_5) && var_5 != "none" && self getammocount(var_5) > 0) {
        var_8 = undefined;
        var_9 = undefined;
        var_10 = undefined;

        switch (var_5) {
          case "alienclaymore_mp":
            var_8 = "explosive";
            var_9 = "alienclaymore_mp";
            break;
          case "alienbetty_mp":
            var_8 = "explosive";
            var_9 = "alienbetty_mp";
            break;
          case "alienmortar_shell_mp":
            var_8 = "explosive";
            var_9 = "alienmortar_shell_mp";
            break;
          case "aliensemtex_mp":
            var_8 = "explosive";
            var_9 = "aliensemtex_mp";
            break;
          case "iw6_aliendlc33_mp":
          case "iw6_aliendlc32_mp":
          case "iw6_aliendlc31_mp":
          case "iw6_aliendlc22_mp":
            var_8 = "explosive";
            var_9 = var_5;
            break;
          case "iw6_aliendlc43_mp":
            if(self getfractionmaxammo("iw6_aliendlc43_mp") < 1) {
              self givemaxammo("iw6_aliendlc43_mp");
              return 1;
            } else
              return 0;
        }

        var_11 = var_5;
        var_12 = self getammocount(var_5);
        drop_pillagable_item(var_11, var_8, var_9, var_12, var_10);
        return 1;
      }
    }
  }

  return 1;
}

drop_pillagable_item(var_0, var_1, var_2, var_3, var_4) {
  self takeweapon(var_0);
  var_5 = spawnStruct();
  var_5.pillageinfo = spawnStruct();
  var_5.pillage_trigger = spawn("script_model", self.origin);
  var_5.pillage_trigger.angles = self.angles;
  var_5.pillage_trigger setModel(get_pillage_model(var_0));
  var_6 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup(var_0);
  var_5.pillage_trigger sethintstring(var_6);
  var_5.pillage_trigger makeusable();

  if(isDefined(var_4)) {
    var_5.explosive_type = var_4;
  }

  if(maps\mp\alien\_utility::alien_mode_has("outline")) {
    maps\mp\alien\_outline_proto::add_to_outline_pillage_watch_list(var_5.pillage_trigger, 0);
  }

  var_5.enabled = 1;
  var_5.searched = 1;
  var_5.pillageinfo.type = var_1;
  var_5.pillageinfo.item = var_2;
  var_5.pillageinfo.ammo = var_3;
  var_5 thread maps\mp\alien\_pillage::pillage_spot_think();
  var_5.pillage_trigger maps\mp\alien\_pillage::drop_pillage_item_on_ground();
}

get_pillage_model(var_0) {
  switch (var_0) {
    case "alienflare_mp":
      return level.pillageinfo.flare_model;
    case "alientrophy_mp":
      return level.pillageinfo.trophy_model;
    case "alienthrowingknife_mp":
      return level.pillageinfo.leash_model;
    case "iw6_aliendlc21_mp":
    case "alienmortar_shell_mp":
    case "aliensemtex_mp":
    case "iw6_aliendlc43_mp":
    case "alienbetty_mp":
    case "alienclaymore_mp":
      return getweaponmodel(var_0);
  }
}

can_craft_pipe_bomb() {
  var_0 = level.offhand_explosives;
  var_1 = 0;
  var_2 = self getweaponslistoffhands();

  foreach(var_4 in var_2) {
    foreach(var_6 in var_0) {
      if(var_4 != var_6) {
        continue;
      }
      if(isDefined(var_4) && var_4 != "none" && self getammocount(var_4) > 0) {
        var_7 = undefined;
        var_8 = undefined;
        var_9 = undefined;

        switch (var_4) {
          case "alienclaymore_mp":
            var_7 = "explosive";
            var_8 = "alienclaymore_mp";
            break;
          case "alienbetty_mp":
            var_7 = "explosive";
            var_8 = "alienbetty_mp";
            break;
          case "alienmortar_shell_mp":
            var_7 = "explosive";
            var_8 = "alienmortar_shell_mp";
            break;
          case "aliensemtex_mp":
            var_7 = "explosive";
            var_8 = "aliensemtex_mp";
            break;
          case "iw6_aliendlc33_mp":
          case "iw6_aliendlc32_mp":
          case "iw6_aliendlc31_mp":
          case "iw6_aliendlc43_mp":
            var_7 = "explosive";
            var_8 = var_4;
            break;
          case "iw6_aliendlc22_mp":
            if(self getfractionmaxammo("iw6_aliendlc22_mp") < 1) {
              self givemaxammo("iw6_aliendlc22_mp");
              return 1;
            } else
              return 0;
        }

        var_10 = var_4;
        var_11 = self getammocount(var_4);
        drop_pillagable_item(var_10, var_7, var_8, var_11, var_9);
        return 1;
      }
    }
  }

  return 1;
}

can_craft_venom_grenade() {
  var_0 = level.offhand_explosives;
  var_1 = 0;
  var_2 = self getweaponslistoffhands();

  foreach(var_4 in var_2) {
    foreach(var_6 in var_0) {
      if(var_4 != var_6) {
        continue;
      }
      if(isDefined(var_4) && var_4 != "none" && self getammocount(var_4) > 0) {
        var_7 = undefined;
        var_8 = undefined;
        var_9 = undefined;

        switch (var_4) {
          case "alienclaymore_mp":
            var_7 = "explosive";
            var_8 = "alienclaymore_mp";
            break;
          case "alienbetty_mp":
            var_7 = "explosive";
            var_8 = "alienbetty_mp";
            break;
          case "alienmortar_shell_mp":
            var_7 = "explosive";
            var_8 = "alienmortar_shell_mp";
            break;
          case "aliensemtex_mp":
            var_7 = "explosive";
            var_8 = "aliensemtex_mp";
            break;
          case "iw6_aliendlc22_mp":
            var_7 = "explosive";
            var_8 = "iw6_aliendlc22_mp";
            break;
          case "iw6_aliendlc43_mp":
            var_7 = "explosive";
            var_8 = "iw6_aliendlc43_mp";
            break;
          case "iw6_aliendlc31_mp":
            if(self getfractionmaxammo("iw6_aliendlc31_mp") < 1) {
              self givemaxammo("iw6_aliendlc31_mp");
              return 1;
            }

            return 0;
          case "iw6_aliendlc32_mp":
            if(self getfractionmaxammo("iw6_aliendlc32_mp") < 1) {
              self givemaxammo("iw6_aliendlc32_mp");
              return 1;
            }

            return 0;
          case "iw6_aliendlc33_mp":
            if(self getfractionmaxammo("iw6_aliendlc33_mp") < 1) {
              self givemaxammo("iw6_aliendlc33_mp");
              return 1;
            }

            return 0;
        }

        var_10 = var_4;
        var_11 = self getammocount(var_4);
        drop_pillagable_item(var_10, var_7, var_8, var_11, var_9);
        return 1;
      }
    }
  }

  return 1;
}

init_smartcrafting_lists() {
  level.crafting_ingredient_lists = [];
  var_0 = getarraykeys(level.placeableconfigs);

  foreach(var_2 in var_0) {
    level.crafting_ingredient_lists[var_2] = [];
    level.crafting_ingredient_lists[var_2] = strtok(var_2, "_");
  }
}