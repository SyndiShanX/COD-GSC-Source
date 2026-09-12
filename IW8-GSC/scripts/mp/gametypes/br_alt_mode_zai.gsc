/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_zai.gsc
****************************************************/

function init() {
  thread setup_target_anims();

  if(getdvarint("scr_br_zombie_encounters", 0) < 1) {
    return;
  }

  level.ref_14687 = spawnStruct();
  level.ref_14687.ref_146DA = getdvarint("scr_br_zombie_plunder_on_death_amount_base", 1);
  level.ref_14687.ref_146DB = getdvarint("scr_br_zombie_plunder_on_death_amount_emp", 2);
  level.ref_14687.ref_146DC = getdvarint("scr_br_zombie_plunder_on_death_amount_explosion", 2);
  level.ref_14687.ref_146DD = getdvarint("scr_br_zombie_plunder_on_death_amount_gas", 2);
  level.ref_14687.ref_146DE = getdvarint("scr_br_zombie_plunder_on_death_amount_weakpoint", 3);
  level.ref_14687.ref_146D8 = getdvarint("scr_br_zombie_plunder_multiplier", 50);
  level.ref_14687.ref_145A8 = getdvarint("scr_br_zombie_ai_week_number", 1);
  level.ref_14687.ref_12377 = getdvarfloat("scr_br_zombie_ping_time", 0.5);
  level.ref_14687.ref_12378 = getdvarfloat("scr_br_zombie_ping_wait_time", 2.5);
  level.ref_14687.onuseitem = getdvarfloat("scr_br_zombie_explosion_damage", 35);
  level.ref_14687.onusethanksbc = getdvarfloat("scr_br_zombie_explosion_damage_vehicle_percent", 0.95);
  level.ref_14687.mortar_cooldown = getdvarfloat("scr_br_zombie_emp_radius", 275);
  level.ref_14687.packs = 1;
  level.ref_14687.ref_146B7 = getdvarint("scr_br_zombie_enable_variable_speed", 1);
  level.ref_14687.ref_146B6 = getdvarint("scr_br_zombie_enable_variable_health", 1);
  level.ref_14687.ref_146B5 = getdvarint("scr_br_zombie_enable_variable_damage", 1);
  level.ref_14687.ref_11A55 = getdvarint("scr_br_zombie_ai_damage_low", 15);
  level.ref_14687.ref_11BDC = getdvarint("scr_br_zombie_ai_damage_mid", 20);
  level.ref_14687.spawn_entity_carriable = getdvarint("scr_br_zombie_ai_damage_high", 35);
  level.ref_14687.ref_146A5 = getdvarfloat("scr_br_zombie_ammo_on_death_chance", 0.4);
  level.ref_14687.ref_146A7 = getdvarfloat("scr_br_zombie_armor_on_death_chance", 0.25);
  level.ref_14687.ref_146A6 = getdvarint("scr_br_zombie_ai_armor_drop_amount", 1);
  level.ref_14687.open_close_initial = getdvarfloat("scr_br_zombie_ai_explosive_mod_damage_modifier", 5);
  level.ref_14687.ref_146C7 = 0;
  level.ref_14687.ref_11AEA = undefined;
  level.ref_14687.ref_11AE9 = undefined;

  switch (level.ref_14687.ref_145A8) {
    case 2:
    case 1:
      level.ref_14687.ref_11AEA = "shipwreck";
      level.ref_14687.ref_11AE9 = "ship_tac";
      break;
    case 3:
      level.ref_14687.ref_11AEA = "prison";
      level.ref_14687.ref_11AE9 = "gulag_tac";
      break;
    case 4:
      level.ref_14687.ref_11AEA = "hospital";
      level.ref_14687.ref_11AE9 = "hospital_tac";
      break;
    case 5:
      level.ref_14687.ref_11AEA = "downtown";
      level.ref_14687.ref_11AE9 = "downtown_tac";
      break;
    case 6:
      level.ref_14687.ref_11AEA = "tvstation";
      level.ref_14687.ref_11AE9 = "tvstation_tac";
      break;
    case 7:
      level.ref_14687.ref_11AEA = "superstore";
      level.ref_14687.ref_11AE9 = "super_tac";
      break;
    case 8:
      level.ref_14687.ref_11AEA = "dam";
      level.ref_14687.ref_11AE9 = "dam_tac";
      break;
  }

  level.ref_146A0 = "gas_on_death";
  level.ref_1469F = "explosion_on_death";
  level.ref_1469E = "emp";
  level.ref_146A2 = "weakpoint";
  level.ref_1469D = "base";
  level._effect["zmb_ai_crawling_out_of_ground"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_ground.vfx");
  level._effect["zmb_ai_crawling_out_of_vent"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_vent.vfx");
  level._effect["zmb_ai_base_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level._effect["zmb_ai_gas_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_gas_death.vfx");
  level._effect["zmb_ai_explosion_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_explode_death.vfx");
  level._effect["zmb_ai_emp_charge"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse_chargeup.vfx");
  level._effect["zmb_ai_emp_pulse"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse.vfx");
  level._effect["zmb_ai_emp_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_death.vfx");
  level._effect["zmb_ai_weakpoint_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level.activeuavs["team_two_hundred"] = 0;
  level.activeadvanceduavs["team_two_hundred"] = 0;
  level.activecounteruavs["team_two_hundred"] = 0;
  thread ref_11FFA();
  thread hostvictimdamagefactorlow();
  thread ref_13D99();
  thread ref_146AA();
  thread ref_1468C();
  thread deploy_emp_drone();
  thread ref_1468E();
}

function ref_1468E() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(tableexists("mp/map_callouts/mp_don3_callouts.csv")) {
    var_0 = int(tablelookup("mp/map_callouts/mp_don3_callouts.csv", 1, level.ref_14687.ref_11AE9, 0));
  } else {
    var_0 = -1;
  }

  setomnvar("ui_br_zm_marked_area", var_0);
}

function setup_target_anims() {
  wait 0.1;

  if(getdvarint("scr_br_zombie_encounters", 0) < 1) {
    play_missile_target_marker_vfx_on_missile_target_ent();
    return;
  }

  play_missile_target_marker_vfx_on_missile_target_ent(level.ref_146B8);
}

function play_missile_target_marker_vfx_on_missile_target_ent(var_0) {
  if(!isDefined(var_0)) {
    thread ref_14688();
    return;
  }

  switch (var_0) {
    case "br_zombies_zone1":
      break;
    case "br_zombies_zone7":
    case "br_zombies_zone6":
    case "br_zombies_zone_tvstation":
    case "br_zombies_zone5":
    case "br_zombies_zone4":
    case "br_zombies_zone3":
    default:
      thread ref_14688();
      break;
  }
}

function ref_11FFA() {
  for(;;) {
    level waittill("add_to_team", var_0);
  }
}

function ref_146EB(var_0) {
  level notify("zai_round_over");
  ref_13D97(level.ref_146AD);
  level.ref_146AD = undefined;
  ref_14708();
  thread ref_146ED(var_0);
}

function ref_146EE() {
  ref_146EB();

  foreach(var_1 in level.ref_146EF) {
    if(isalive(var_1)) {
      var_1.shutdown = 1;
      var_1 suicide();
    }
  }
}

function ref_146EC(var_0) {
  if(getdvarint("scr_br_zombie_ai_enable_drop_loot", 1)) {
    var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var_2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, var_0.origin, var_0.angles, var_0);
    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_access_card_green", var_2);
  }

  var_3 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 6000);

  if(level.ref_14687.packs == 1) {
    foreach(var_5 in var_3) {
      var_5 scripts\mp\hud_message::showsplash("br_zai_round_over");
    }
  } else if(level.ref_14687.packs == 2) {
    foreach(var_5 in var_3) {
      var_5 scripts\mp\hud_message::showsplash("br_zai_round_over_multiple");
    }
  }

  level.ref_14687.packs = 0;
  ref_146EB(6);

  switch (level.ref_146B8) {
    case "br_zombies_zone1":
      thread ref_14689();

      if(getdvarint("scr_br_zombie_open_all_doors", 1)) {
        thread ref_14689();
      }

      break;
    case "br_zombies_zone7":
    case "br_zombies_zone6":
    case "br_zombies_zone_tvstation":
    case "br_zombies_zone5":
    case "br_zombies_zone4":
    case "br_zombies_zone3":
    default:
      break;
  }
}

function ref_146ED(var_0) {
  if(isDefined(var_0)) {
    level endon("game_ended");
    level endon("zai_computer_used");
    wait var_0;
  }

  foreach(var_2 in level.players) {
    var_2.unsetbettermissionrewards = 0;
    ref_126DC(var_2, level.ref_14687.ref_146C7);
  }
}

function ref_146BA() {
  level endon("game_ended");
  level endon("zai_computer_used");

  for(;;) {
    if(getdvarint("scr_br_zai_force_round_over", 0)) {
      var_0 = level.player;

      foreach(var_2 in level.ref_146EF) {
        if(isalive(var_2)) {
          var_0 = var_2;
          break;
        }
      }

      setDvar("scr_br_zai_force_round_over", 0);
      ref_146EC(var_0);
    }

    wait 2;
  }
}

function ref_14706(var_0) {
  var_1 = self;

  if(!isDefined(var_1.ref_14704)) {
    var_1.ref_14704 = "base";
  }

  var_2 = level.ref_14687.ref_146DA;

  switch (var_1.ref_14704) {
    case "gas_on_death":
      thread scripts\mp\equipment\gas_grenade::gas_createtrigger(self.origin, undefined, 5.5, 0.5);
      playFX(level._effect["zmb_ai_gas_death"], var_1 gettagorigin("j_spineupper"));
      var_2 = level.ref_14687.ref_146DD;
      break;
    case "explosion_on_death":
      playFX(level._effect["zmb_ai_explosion_death"], var_1 gettagorigin("j_spineupper"));
      var_3 = scripts\mp\utility\player::getplayersinradius(var_1.origin, 200);

      foreach(var_5 in var_3) {
        if(var_5 scripts\cp_mp\utility\player_utility::isinvehicle()) {
          if(var_5.vehicle.health > var_5.vehicle.maxhealth * 0.05) {
            var_6 = var_5.vehicle.maxhealth * level.ref_14687.onusethanksbc;
            var_5.vehicle dodamage(var_6, var_5.vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
          }
        }

        if(var_5 scripts\mp\utility\perk::_hasperk("specialty_br_eod")) {
          var_5 dodamage(int(level.ref_14687.onuseitem * 0.85), var_1.origin, var_1, var_5, "MOD_EXPLOSIVE");
        } else {
          var_5 dodamage(level.ref_14687.onuseitem, var_1.origin, var_1, var_5, "MOD_EXPLOSIVE");
        }

        var_5 earthquakeforplayer(0.35, 0.9, self.origin, 200);
      }

      var_2 = level.ref_14687.ref_146DC;
      break;
    case "emp":
      playFX(level._effect["zmb_ai_emp_death"], var_1 gettagorigin("j_spine4"));
      var_2 = level.ref_14687.ref_146DB;
      break;
    case "weakpoint":
      playFX(level._effect["zmb_ai_weakpoint_death"], var_1 gettagorigin("j_spineupper"));
      var_2 = level.ref_14687.ref_146DE;
      break;
    default:
      playFX(level._effect["zmb_ai_base_death"], var_1 gettagorigin("j_spineupper"));
      var_2 = level.ref_14687.ref_146DA;
      break;
  }

  var_8 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  if(var_2 > 0) {
    if(scripts\mp\utility\game::round_vehicle_logic() == "dmz") {
      var_2 *= level.ref_14687.ref_146D8;
    }

    scripts\mp\gametypes\br_plunder::ml_p3_func(var_2, var_8);
  }

  if(isalive(var_0) && isPlayer(var_0) && randomfloat(1) < level.ref_14687.ref_146A5) {
    var_9 = var_0 getcurrentprimaryweapon();
    var_10 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_9);

    if(!isDefined(var_10)) {
      return;
    }

    foreach(var_12 in level.br_ammo_types) {
      var_1.br_ammo[var_12] = 0;
    }

    var_1.br_ammo[var_10] = level.br_ammo_clipsize[var_10];
    var_1 scripts\mp\gametypes\br_pickups::minplunderextractions(var_8);
  }

  if(isalive(var_0) && isPlayer(var_0) && randomfloat(1) < level.ref_14687.ref_146A7) {
    var_14 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_8, var_1.origin, var_1.angles, var_1);
    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_armor_plate", var_14, level.ref_14687.ref_146A6, 1);
    return;
  }
}

function ref_14708() {
  level.ref_146F0 = 0;

  if(isDefined(level.ref_14687)) {
    level.ref_14687.ref_146C7 = 0;
  }

  level.deploy_subway_cars_on_track = getdvarint("scr_br_zombie_num", -1);
  level.deploy_suicide_truck_in_lumber_yard = getdvarint("scr_br_zombie_total_num_type_gas", -1);
  level.deploy_suicide_truck_in_farm = getdvarint("scr_br_zombie_total_num_type_explosion", -1);
  level.deploy_suicide_truck_in_blockade = getdvarint("scr_br_zombie_total_num_type_emp", -1);
  level.deployable_cover_cancel = getdvarint("scr_br_zombie_total_num_type_weakpoint", -1);
}

function ref_146D4() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("terminate_ai_threads");
  var_0 endon("death");

  for(;;) {
    var_0 setperk("specialty_radarblip", 1);
    wait level.ref_14687.ref_12377;
    var_0 unsetperk("specialty_radarblip", 1);
    wait level.ref_14687.ref_12378;
  }
}

function ref_146F5(var_0) {
  var_1 = self;

  if(!level.ref_14687.ref_146B7) {
    return;
  }

  if(!isDefined(var_1.ref_13174) || !isDefined(var_1.ref_131BC)) {
    return;
  }

  var_2 = randomfloat(2);

  if(var_0 == level.ref_146A0 || var_0 == level.ref_1469F) {
    var_1[[var_1.ref_13174]]("sprint");
    var_2 = randomfloat(1);
  } else if(var_0 == level.ref_1469E || var_0 == level.ref_1469D) {
    var_1[[var_1.ref_13174]]("run");
  } else if(var_0 == level.ref_146A2) {
    var_1[[var_1.ref_13174]]("walk");
  }

  var_1[[var_1.ref_131BC]](var_2);
}

function ref_146F3(var_0) {
  var_1 = self;

  if(!level.ref_14687.ref_146B6) {
    return;
  }

  if(var_0 == level.ref_146A0 || var_0 == level.ref_1469F) {
    var_1.health = 120;
    return;
  }
}

function ref_146F4(var_0) {
  var_1 = self;

  if(!level.ref_14687.ref_146B5) {
    return;
  }

  if(var_0 == level.ref_146A2) {
    var_1.ref_11BBD = level.ref_14687.spawn_entity_carriable;
    return;
  }

  if(var_0 == level.ref_1469D) {
    var_1.ref_11BBD = level.ref_14687.ref_11BDC;
    return;
  }

  if(var_0 == level.ref_1469E || var_0 == level.ref_146A0 || var_0 == level.ref_1469F) {
    var_1.ref_11BBD = level.ref_14687.ref_11A55;
    return;
  }
}

function ref_146AF(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(var_4.ref_14704) && isDefined(var_0) && isDefined(var_1)) {
    if(istrue(var_3)) {
      if(isDefined(var_2) && var_2 == "head") {
        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var_0 >= self.health, 1, "hitzombieheadshot");
        return;
      }

      var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var_0 >= self.health, 0, "hitzombieheadshot");
      return;
    }

    if(var_4.ref_14704 == level.ref_146A2) {
      if(isDefined(var_2) && var_2 == "head") {
        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitarmorheavy", var_0 >= self.health, 1);
        return;
      }

      var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitarmorheavy", var_0 >= self.health);
      return;
    }

    if(isDefined(var_2) && var_2 == "head") {
      var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", var_0 >= self.health, 1);
      return;
    }

    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", var_0 >= self.health);
    return;
  }
}

function ref_1468C() {
  waittillframeend();
  level.ref_14687.max_rpg_groups = ref_1468B();

  foreach(var_1 in level.ref_14687.max_rpg_groups) {
    if(isDefined(var_1.targetname)) {
      if(var_1.targetname == level.ref_146B8) {
        continue;
      }
    }

    var_1 delete();
  }

  if(level.mapname == "mp_don3" && getdvarint("scr_br_don3_ship_path_fix", 0)) {
    var_3 = getdvarvector("scr_br_don3_ship_path_fix_side_a", (39256, -42265, -506));
    var_4 = getdvarvector("scr_br_don3_ship_path_fix_side_b", (39348, -42251, -508));
    var_5 = (0, vectortoyaw(var_4 - var_3), 0);
    var_6 = spawncovernode(var_3, var_5, "Begin", 0, undefined, undefined, "zombie");
    createnavlink("zombie_hack", var_3, var_4, var_6);
    var_5 = (0, vectortoyaw(var_3 - var_4), 0);
    var_6 = spawncovernode(var_4, var_5, "Begin", 0, undefined, undefined, "zombie");
    createnavlink("zombie_hack", var_4, var_3, var_6);
  }

  if(level.mapname == "mp_don3") {
    if(getdvarint("scr_br_zombie_open_all_doors_at_start", 1)) {
      ref_14689();
      return;
    }

    var_7 = getdvarfloat("scr_br_don3_ship_door_obstacle_size", 0);

    if(var_7 > 0) {
      if(level.ref_146B8 == "br_zombies_zone1" || level.ref_146B8 == "br_zombies_zone1") {
        var_8 = ref_1468B("boat_doors_round1");

        foreach(var_10 in var_8) {
          var_11 = anglesToForward(var_10.angles) * 26;
          var_10.ref_11F9A = createnavbadplacebyshape(var_10.origin + var_11, 6, var_7, 20);
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1468B(var_0) {
  var_1 = getEntArray(level.ref_146B8, "targetname");

  if(!isDefined(var_0)) {
    return var_1;
  }

  if(!var_1.size) {
    return undefined;
  }

  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_0) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function ref_1468D(var_0) {
  if(isDefined(var_0.script_linkto)) {
    if(isDefined(var_0.ref_11F9A)) {
      destroynavobstacle(var_0.ref_11F9A);
    }

    var_0 setscriptablepartstate("br_zai_door", "open");
    var_0 moveTo(scripts\engine\utility::getStruct(var_0.script_linkto, "script_linkname").origin, 2.5, 0.5, 0.5);
    return;
  }
}

function ref_126DC(var_0) {
  if(getdvarint("scr_br_zombie_encounters", 0) < 1) {
    return;
  }

  var_1 = self;

  if(!isDefined(var_1.unsetbettermissionrewards)) {
    var_1.unsetbettermissionrewards = 0;
  }

  var_2 = ref_1468A(var_1.unsetbettermissionrewards, level.ref_14687.packs, var_0);
  var_1 setclientomnvar("ui_br_zai_counter", var_2);
}

function ref_1468A(var_0, var_1, var_2) {
  var_3 = int(var_0) & 1;
  var_3 += (int(var_1) & 3) << 1;
  var_3 += (int(var_2) & 63) << 3;
  return var_3;
}

function ref_12666(var_0) {
  level endon("game_ended");
  level endon("zai_round_over");

  for(;;) {
    var_1 = scripts\mp\utility\player::getplayersinradius(var_0, 6000);

    foreach(var_3 in level.players) {
      if(!isalive(var_3) || var_3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_1, var_3)) {
        if(!istrue(var_3.unsetbettermissionrewards)) {
          ref_1253E(var_3);
        }

        var_3.unsetbettermissionrewards = 1;
      }

      ref_126DC(var_3, level.ref_14687.ref_146C7);
    }

    wait 3;
  }
}

function ref_1253E() {
  var_0 = self;

  if(level.ref_14687.packs == 1) {
    var_0 scripts\mp\hud_message::showsplash("br_zai_entering_active_area");
    return;
  }

  if(level.ref_14687.packs == 2) {
    var_0 scripts\mp\hud_message::showsplash("br_zai_entering_active_area_multiple");
    return;
  }
}

function ref_146B3() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("terminate_ai_threads");

  for(;;) {
    var_1 = randomint(5);
    wait 5 + var_1 - 2;
    playFXOnTag(level._effect["zmb_ai_emp_charge"], var_0, "j_spine4");
    wait 2;
    ref_146B4(var_0);
  }
}

function ref_146B4() {
  var_0 = 60;
  var_1 = 1;
  var_2 = 64;
  var_3 = var_2 * var_2;
  var_4 = level.ref_14687.mortar_cooldown * level.ref_14687.mortar_cooldown;
  var_5 = "zxp_emp_fire_plr";
  var_6 = self;
  var_7 = anglesToForward(var_6.angles);
  playFX(level._effect["zmb_ai_emp_pulse"], var_6 gettagorigin("j_spineupper"), var_7);
  var_8 = getcompleteweaponname("emp_drone_non_player_mp");
  var_9 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var_10 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_12 in var_10) {
    var_13 = var_12.owner;

    if(isDefined(var_13)) {
      if(var_13 != var_6 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_6, var_13)) {
        continue;
      }
    }

    var_14 = distancesquared(var_6.origin, var_12.origin);

    if(var_14 > var_4) {
      continue;
    }

    var_15 = scripts\engine\utility::ter_op(var_14 > var_3, var_8, var_9);
    var_12 dodamage(1, var_6.origin, var_6, var_6, "MOD_EXPLOSIVE", var_15);
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_6, var_12, 1, var_15, "MOD_EXPLOSIVE", var_6, var_6.origin);
    thread ref_126F9(var_16);
  }

  var_18 = getcompleteweaponname("emp_drone_player_mp");
  var_19 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_19 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var_6.origin, level.ref_14687.mortar_cooldown);
  }

  foreach(var_21 in var_19) {
    if(!var_21 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var_21 != var_6 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_6, var_21)) {
      continue;
    }

    var_21 dodamage(1, var_6.origin, var_6, var_6, "MOD_EXPLOSIVE", var_18);
    var_21 earthquakeforplayer(0.2, 0.7, self.origin, level.ref_14687.mortar_cooldown);
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_6, var_21, 1, var_18, "MOD_EXPLOSIVE", var_6, var_6.origin);
    thread ref_126F9(var_16);
  }
}

function ref_126F9(var_0) {
  var_1 = 5;
  var_2 = 2;
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_3 = var_1;

  if(isPlayer(var_0.victim)) {
    var_0.victim.unmark_on_death = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_0.victim != self && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var_3 = var_2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }
  }

  moraleslaptopthink(var_0, var_3);

  if(isDefined(var_0.victim)) {
    var_0.victim.unmark_on_death = undefined;
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function moraleslaptopthink(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);

  if(var_2 != "emp_cleared") {
    var_0.empremoved = 1;
    return;
  }
}

function hostvictimdamagefactorlow() {
  level.ref_14696 = spawnStruct();
  level.ref_14696.ref_12F41 = ["off", "offline", "low", "medium", "high", "critical"];
  level.ref_14696.ref_1403B = ["disabled", "enabled"];
  level.ref_14696.ref_12F44 = getdvarfloat("scr_br_zombie_con_comp_screen_update_time", 10);
  level.ref_14696.ref_13334 = getdvarint("scr_br_zombie_con_comp_show_disabled_hint", 1);
  waittillframeend();
  level.ref_14696.holoeffect = getentitylessscriptablearrayinradius("scriptable_containment_computer_01_screen_scripted", "classname");
  scripts\engine\scriptable::ref_12F5B("containment_computer_usable", &hostvictimdefensefactormod);
  var_0 = getdvarint("scr_br_zombie_con_comp_screen_prematch", 0);
  var_1 = getdvarint("scr_br_zombie_con_comp_usable_prematch", 0);
  hostvictimdamagepercentlow(var_0, var_1);

  if(!getdvarint("scr_br_enable_zai_button_in_prematch", 0)) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  var_0 = getdvarint("scr_br_zombie_con_comp_screen", 2);
  var_1 = getdvarint("scr_br_zombie_con_comp_usable", 0);
  hostvictimdamagepercentlow(var_0, var_1);
}

function hostvictimdamagepercentlow(var_0, var_1) {
  level.ref_14696.ref_12F42 = var_0;

  foreach(var_3 in level.ref_14696.holoeffect) {
    var_3 notify("containmentComputersScreenRestore");
    hostvictimdamagepercenthigh(var_3, var_0, var_1);
  }
}

function hostvictimdamagepercenthigh(var_0, var_1, var_2) {
  var_0.ref_12F43 = var_1;
  var_3 = level.ref_14696.ref_12F41[var_1];
  var_0 setscriptablepartstate("containment_computer_screen", var_3);

  if(isDefined(var_2)) {
    var_0.ref_1403C = var_2;
    var_4 = level.ref_14696.ref_1403B[var_2];
    var_0 setscriptablepartstate("containment_computer_usable", var_4);

    if(level.ref_14696.ref_13334) {
      var_0 setscriptablepartstate("containment_computer_not_usable", var_4);
      return;
    }

    return;
  }
}

function hostvictimdefensefactormod(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.br_circle)) {
    var_5 = 2;
  } else {
    var_5 = 3;
  }

  var_4 setclientomnvar("ui_br_purchase_file_override", var_5);
  var_4 thread scripts\mp\gametypes\br_armory_kiosk::_runpurchasemenu(var_1, 1);
  var_4 waittill("purchase_menu_closed", var_6);

  if(var_6 == 1) {
    hostvictimdamagefactorhigh(var_1);
    return;
  }
}

function hostvictimattackfactormod(var_0) {
  var_1 = level.teamdata[var_0]["players"];

  foreach(var_3 in var_1) {
    hostskipburndownmedium(var_3);
  }
}

function hostskipburndownmedium(var_0) {
  if(!isDefined(var_0.delay_kick_inactive_player)) {
    return;
  }

  if(var_0.delay_kick_inactive_player.classname != "scriptable_containment_computer_01_screen_scripted") {
    return;
  }

  var_0 notify("force_exit");
}

function hostvictimdamagefactorhigh(var_0) {
  if(var_0.ref_12F43 <= 1) {
    return;
  }

  hostvictimdamagepercenthigh(var_0, var_0.ref_12F43 - 1);
  hostvictimdamagefactormedium(var_0);
}

function hostvictimdamagefactormedium(var_0) {
  var_0 notify("containmentComputersScreenRestore");
  var_0 endon("containmentComputersScreenRestore");

  while(var_0.ref_12F43 < level.ref_14696.ref_12F42) {
    wait level.ref_14696.ref_12F44;
    hostvictimdamagepercenthigh(var_0, var_0.ref_12F43 + 1);
  }
}

function hostvictimdamagepercentmedium(var_0) {
  var_1 = var_0 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_green");

  foreach(var_3 in level.ref_14696.holoeffect) {
    if(var_1) {
      var_3 enablescriptablepartplayeruse("containment_computer_usable", var_0);
      var_3 disablescriptablepartplayeruse("containment_computer_not_usable", var_0);
      continue;
    }

    var_3 disablescriptablepartplayeruse("containment_computer_usable", var_0);
    var_3 enablescriptablepartplayeruse("containment_computer_not_usable", var_0);
  }
}

function ref_11FF9(var_0) {
  var_1 = self;

  if(!isDefined(level.ref_14687)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == "brloot_access_card_green") {
    var_2 = 225000000;

    for(var_3 = 0; var_3 < level.ref_14687.force_teleport_downedplayer.size; var_3++) {
      if(distancesquared(level.ref_14687.forced_aitype_armored[var_3].origin, var_1.origin) < var_2) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.ref_14687.force_teleport_downedplayer[var_3], var_1);
        return;
      }
    }

    return;
  }
}

function ref_1207D(var_0) {
  if(!isDefined(level.ref_14687)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == "brloot_access_card_green") {
    foreach(var_2 in level.ref_14687.force_teleport_downedplayer) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2, self);
    }

    return;
  }
}

function ref_13D99() {
  var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_test_victor_event_button", "classname");

  if(!getdvarint("scr_br_enable_zai_button_in_prematch", 0)) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
  }

  wait 4;

  foreach(var_2 in var_0) {
    if(var_2.targetname == level.ref_146B8) {
      var_2 setscriptablepartstate("button", "usable");
      var_3 = anglesToForward(var_2.angles);
      var_2.ref_12F40 = easepower("scriptable_test_victor_event_button_screen", var_2.origin + var_3, var_2.angles);
      ref_13D97(var_2);
    }
  }
}

function ref_13D97() {
  if(isDefined(self.ref_12F40)) {
    self.ref_12F40 setscriptablepartstate("screen", "green");
    return;
  }
}

function ref_13D96() {
  if(isDefined(self.ref_12F40)) {
    self.ref_12F40 setscriptablepartstate("screen", "red_100");
    return;
  }
}

function ref_146AA() {
  level.ref_14687.force_thermites = scripts\engine\utility::getStructArray("zombie_cache_loc", "targetname");

  switch (level.script) {
    case "mp_br_mechanics":
      break;
    default:
      break;
  }

  level.ref_14687.forced_aitype_armored = [];
  level.ref_14687.force_teleport_downedplayer = [];
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.ref_14687.force_thermites) {
    if(isDefined(var_1.script_noteworthy) && level.ref_146B8 != var_1.script_noteworthy) {
      continue;
    }

    if(!isDefined(var_1.angles)) {
      var_1.angles = (0, 0, 0);
    }

    var_2 = easepower("br_loot_cache_zom", var_1.origin, var_1.angles);
    var_2.get_circle_back_nodes_on_same_side = &ref_146A9;
    var_2.ref_1406C = &ref_146AB;
    var_2.ref_12F7F = "cache_zom";
    var_2.ref_11A48 = 1;
    var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "current", var_2.origin + (0, 0, 15), "ui_mp_br_mapmenu_icon_zmb_event_dropbox");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3);
      level.ref_14687.force_teleport_downedplayer[level.ref_14687.force_teleport_downedplayer.size] = var_3;
    }

    level.ref_14687.forced_aitype_armored[level.ref_14687.forced_aitype_armored.size] = var_2;
  }
}

function ref_146A8(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.script_noteworthy = var_2;
  level.ref_14687.force_thermites[level.ref_14687.force_thermites.size] = var_3;
}

function ref_146A9(var_0, var_1, var_2, var_3, var_4) {
  if(!var_3 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_green")) {
    var_3 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/ZOMBIE_CACHE_DENY_CARD");
    var_3 playlocalsound("br_pickup_deny");
    return false;
  }

  return true;
}

function ref_146AB(var_0, var_1, var_2, var_3, var_4) {
  var_3 scripts\mp\gametypes\br_pickups::ref_12BFC();

  if(!isDefined(var_0.ref_12F80)) {
    var_0.ref_12F80 = 0;
  } else {
    var_0.ref_12F80 = (var_0.ref_12F80 + 1) % 10;
  }

  for(var_5 = 0; var_5 < level.ref_14687.force_teleport_downedplayer.size; var_5++) {
    if(var_0 == level.ref_14687.forced_aitype_armored[var_5]) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.ref_14687.force_teleport_downedplayer[var_5], var_3);
    }
  }

  applyminigunrestrictions(var_0.origin);

  if(getdvarint("scr_bombardment_killswitch", 0) == 0) {
    var_0 scripts\mp\gametypes\br::ref_11AA0("brloot_access_card_purple");
  }

  wait getdvarfloat("scr_br_zombie_cache_wait", 5);
  var_0 setscriptablepartstate(var_1, "closing");
}

function applyminigunrestrictions(var_0) {
  var_1 = getdvarint("scr_br_zombie_cache_delete_nearby_loot_radius", 128);

  if(var_1 == 0) {
    return;
  }

  var_2 = canceljoins(undefined, undefined, var_0, var_1);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var_4, 0)) {
        continue;
      }

      if(var_4 getscriptableisreserved() && !isDefined(var_4.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11A21(var_4);
    }

    return;
  }
}

function ref_14689() {
  if(!isDefined(level.ref_14687.player_disable_invulnerability)) {
    level.ref_14687.player_disable_invulnerability = 1;
  }

  if(!isDefined(level.ref_14687.maxbetarank)) {
    level.ref_14687.maxbetarank = 0;
  }

  var_0 = [];

  if(!level.ref_14687.maxbetarank) {
    if(level.ref_14687.player_disable_invulnerability) {
      var_0 = ref_1468B("boat_doors_round1");
      level.ref_14687.player_disable_invulnerability = 0;
    } else {
      var_0 = ref_1468B("boat_doors_round2");
      level.ref_14687.maxbetarank = 1;
    }

    if(isDefined(var_0)) {
      foreach(var_2 in var_0) {
        thread ref_1468D(var_2);
      }

      return;
    }

    return;
  }
}

function ref_14688() {
  var_0 = getEntArray("boat_doors_round1", "script_noteworthy");
  var_0 scripts\engine\utility::array_combine(var_0, getEntArray("boat_doors_round2", "script_noteworthy"));

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

function deploy_emp_drone() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_zmb_sfx");
}