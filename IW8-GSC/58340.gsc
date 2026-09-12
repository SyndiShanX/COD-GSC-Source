/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58340.gsc
***********************************************/

function main() {
  level endon("game_ended");

  if(getdvarint("scr_br_zombie_encounters", 0) < 1) {
    ref_146fd("Zombie Spawning Disabled");
    return;
  }

  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\engine\scriptable::ref_12f5b("button", &ref_146ae);
  initzombievariables();
  level.disable_oob_immunity_on_riders = 1;
  level.playerexitlaststand = &ref_146f7;
  level.playerclearjailtimeouthud = &ref_146bb;
  level.ref_146b8 = getDvar("scr_br_zombie_encounter_zone", "br_zombies_zone1");
  level.ref_146e9 = getdvarint("scr_br_zombie_encounter_no_target_go_to_spawn", 1);
  level.ref_146ca = getdvarint("scr_br_zombie_max_num_in_a_round", 40);
  level.ref_146ad = undefined;
  scripts\mp\gametypes\br_alt_mode_zai::ref_14708();
  level.deployed = getdvarfloat("scr_br_zombie_spawning_wait_time", 1.5);
  level.deploy_subway_car_at_station = getdvarint("scr_default_maxagents", 10);
  ref_146fd("Zombie Spawning Enabled for " + level.ref_146b8);

  while(!scripts\mp\flags::playerzombiethermalcleanup("prematch_done")) {
    wait 1;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
}

function initzombievariables() {
  level.ref_14687 = spawnStruct();
  level.ref_14687.ref_146da = getdvarint("scr_br_zombie_plunder_on_death_amount_base", 1);
  level.ref_14687.ref_146db = getdvarint("scr_br_zombie_plunder_on_death_amount_emp", 2);
  level.ref_14687.ref_146dc = getdvarint("scr_br_zombie_plunder_on_death_amount_explosion", 2);
  level.ref_14687.ref_146dd = getdvarint("scr_br_zombie_plunder_on_death_amount_gas", 2);
  level.ref_14687.ref_146de = getdvarint("scr_br_zombie_plunder_on_death_amount_weakpoint", 3);
  level.ref_14687.ref_146d8 = getdvarint("scr_br_zombie_plunder_multiplier", 50);
  level.ref_14687.onuseitem = getdvarfloat("scr_br_zombie_explosion_damage", 35);
  level.ref_14687.onusethanksbc = getdvarfloat("scr_br_zombie_explosion_damage_vehicle_percent", 0.95);
  level.ref_14687.mortar_cooldown = getdvarfloat("scr_br_zombie_emp_radius", 275);
  level.ref_14687.packs = 1;
  level.ref_14687.ref_146b7 = getdvarint("scr_br_zombie_enable_variable_speed", 1);
  level.ref_14687.ref_146b6 = getdvarint("scr_br_zombie_enable_variable_health", 1);
  level.ref_14687.ref_146b5 = getdvarint("scr_br_zombie_enable_variable_damage", 1);
  level.ref_14687.ref_11a55 = getdvarint("scr_br_zombie_ai_damage_low", 15);
  level.ref_14687.ref_11bdc = getdvarint("scr_br_zombie_ai_damage_mid", 20);
  level.ref_14687.spawn_entity_carriable = getdvarint("scr_br_zombie_ai_damage_high", 35);
  level.ref_14687.ref_146a5 = getdvarfloat("scr_br_zombie_ammo_on_death_chance", 0.4);
  level.ref_14687.ref_146a7 = getdvarfloat("scr_br_zombie_armor_on_death_chance", 0.25);
  level.ref_14687.ref_146a6 = getdvarint("scr_br_zombie_ai_armor_drop_amount", 1);
  level.ref_14687.open_close_initial = getdvarfloat("scr_br_zombie_ai_explosive_mod_damage_modifier", 5);
  level.ref_14687.ref_146c7 = 0;
  level.ref_146a0 = "gas_on_death";
  level.ref_1469f = "explosion_on_death";
  level.ref_1469e = "emp";
  level.ref_146a2 = "weakpoint";
  level.zombie_type_ranger = "ranger";
  level.ref_1469d = "base";
  level._effect["zmb_ai_crawling_out_of_ground"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_ground.vfx");
  level._effect["zmb_ai_crawling_out_of_vent"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_vent.vfx");
  level._effect["zmb_ai_base_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level._effect["zmb_ai_gas_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_gas_death.vfx");
  level._effect["zmb_ai_explosion_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_explode_death.vfx");
  level._effect["zmb_ai_emp_charge"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse_chargeup.vfx");
  level._effect["zmb_ai_emp_pulse"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse.vfx");
  level._effect["zmb_ai_emp_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_death.vfx");
  level._effect["zmb_ai_weakpoint_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  scripts\mp\utility\sound::besttime("br_zmb_sfx");
}

function ref_146b0() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("terminate_ai_threads");
  var_0 hide();
  wait 0.2;
  var_0 show();
  wait 2;

  if(getdvarint("scr_br_zombie_encounters", 0) >= 1 && isDefined(level.ref_14687)) {
    var_0 thread scripts\mp\gametypes\br_alt_mode_zai::ref_146d4();
    return;
  }
}

function ref_146f7() {
  return false;
}

function ref_146fe() {
  return getdvarint("scr_br_zombie_log", 0) > 0;
}

function ref_146fa(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::string_starts_with(var_0, "actor_")) {
    var_0 = "actor_" + var_0;
  }

  if(!isDefined(level.agent_definition[var_0])) {
    return undefined;
  }

  if(!isDefined(var_3) || !isDefined(var_3.script_animation)) {
    var_3 = spawnStruct();
    var_3.script_animation = "spawn_ground";
    var_3.targetname = "spawnStruct";
    var_3.origin = var_1;
  }

  if(isDefined(var_3) && isDefined(var_3.targetname)) {
    ref_146fd("Zombie will spawn At " + var_3.targetname);
  }

  var_5 = scripts\mp\mp_agent::spawnnewagent(var_0, "team_two_hundred", var_1, var_2, undefined, var_3);

  if(isDefined(var_5)) {
    ref_146fd("Spawned zombie : " + var_0);
    thread ref_146b0();

    if(isDefined(var_4)) {
      var_5.ref_14704 = var_4;

      switch (var_4) {
        case "base":
          var_5 setscriptablepartstate("ai_glow", "base_loop");
          playsoundatpos(var_5.origin, "zmb_spawn_type_default");
          break;
        case "ranger":
        case "gas_on_death":
          var_5 setscriptablepartstate("ai_glow", "gas_loop");
          playsoundatpos(var_5.origin, "zmb_spawn_type_gas");
          break;
        case "explosion_on_death":
          var_5 setscriptablepartstate("ai_glow", "exp_loop");
          playsoundatpos(var_5.origin, "zmb_spawn_type_exp");
          break;
        case "emp":
          var_5 setscriptablepartstate("ai_glow", "emp_loop");
          playsoundatpos(var_5.origin, "zmb_spawn_type_emp");
          break;
        case "weakpoint":
          var_5 setscriptablepartstate("ai_glow", "weak_loop");
          thread carriablemagicgrenades(var_5, "c_t9_zmb_ndu_zombie_honorguard_helmet_barbed");
          playsoundatpos(var_5.origin, "zmb_spawn_type_armor");
          break;
        default:
          var_5 setscriptablepartstate("ai_glow", "base_loop");
          break;
      }
    }

    if(!isDefined(var_3.ref_146ea)) {
      var_3.ref_146ea = getclosestpointonnavmesh(var_3.origin);
    }

    switch (var_3.script_animation) {
      case "spawn_ground":
        if(isDefined(level._effect["zmb_ai_crawling_out_of_ground"])) {
          playFX(scripts\engine\utility::getfx("zmb_ai_crawling_out_of_ground"), var_5.origin);
        }

        break;
      case "spawn_wall_low":
        if(isDefined(level._effect["zmb_ai_crawling_out_of_vent"])) {
          playFX(level._effect["zmb_ai_crawling_out_of_vent"], var_5.origin);
        }

        break;
      default:
        if(isDefined(level._effect["zmb_ai_crawling_out_of_ground"])) {
          playFX(scripts\engine\utility::getfx("zmb_ai_crawling_out_of_ground"), var_5.origin);
        }

        break;
    }
  } else {
    ref_146fd("Spawn Failed " + var_0);
  }

  return var_5;
}

function carriablemagicgrenades(var_0, var_1, var_2) {
  level endon("zai_round_over");
  level endon("game_ended");
  self endon("terminate_ai_threads");

  if(!istrue(var_2)) {
    wait 0.25;
  }

  self attach(var_0, var_1);
  self.hashelmet = 1;
  self.attached_helmet = spawnStruct();
  self.attached_helmet.model = var_0;
  self.attached_helmet.tag = var_1;
}

function detachhelmetfromzombie(var_0, var_1) {
  self detach(self.attached_helmet.model, self.attached_helmet.tag);
  self.hashelmet = 0;
  self.attached_helmet = undefined;
}

function ref_1470e(var_0) {
  return !accesscard::ref_13303(var_0, 1);
}

function ref_146a4(var_0) {
  level endon("game_ended");
  var_1 = ref_14711(getEntArray(var_0.target, "targetname"));

  for(;;) {
    level.ref_146d7 = 0;

    foreach(var_3 in level.players) {
      var_3.trial_targs = 0;
    }

    foreach(var_6 in var_1) {
      var_6.isactive = 0;
      var_6.ref_1252f = 0;
    }

    var_8 = [];

    foreach(var_3 in level.players) {
      if(ref_1470e(var_3)) {
        var_8 = var_3;
      }
    }

    foreach(var_6 in var_1) {
      foreach(var_3 in var_8) {
        if(var_3 istouching(var_6)) {
          if(!istrue(var_3.trial_targs)) {
            var_3.trial_targs = 1;
            level.ref_146d7 += 1;
          }

          var_6.isactive = 1;
          var_6.ref_1252f += 1;
        }
      }
    }

    level.ref_146a3 = [];

    foreach(var_6 in var_1) {
      if(var_6.isactive) {
        level.ref_146a3[level.ref_146a3.size] = var_6;

        foreach(var_17 in level.vehicle.instances) {
          foreach(var_19 in var_17) {
            if(var_19 istouching(var_6)) {
              thread ref_14701();
            }
          }
        }

        foreach(var_23 in level.mines) {
          if(isDefined(var_23) && isDefined(var_23.equipmentref) && var_23.equipmentref == "equip_tac_cover") {
            if(var_23 istouching(var_6)) {
              thread ref_14701();
            }
          }
        }
      }
    }

    foreach(var_3 in level.players) {}

    var_28 = ref_14710();
    wait var_28;
  }
}

function ref_14701() {
  var_0 = createnavobstaclebyent(self, "team_two_hundred");
  wait ref_14710() - 0.05;

  if(isDefined(var_0)) {
    destroynavobstacle(var_0);
    return;
  }
}

function ref_14710() {
  return getdvarfloat("scr_br_zombie_volume_wait_time", 1);
}

function ref_146ac() {
  level endon("game_ended");
  level endon("zai_round_over");

  for(;;) {
    if(vehicle_collision_init(level.ref_146ad)) {
      thread scripts\mp\gametypes\br_alt_mode_zai::ref_146ee();
      return;
    }

    wait 1;
  }
}

function ref_14711(var_0) {
  foreach(var_2 in var_0) {
    var_2.ref_14723 = [];

    if(!isDefined(var_2.script_linkname)) {
      continue;
    }

    if(!isDefined(var_2.script_linkto)) {
      continue;
    }

    var_3 = var_2 scripts\engine\utility::get_linked_ents();

    if(var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_2.ref_14723[var_2.ref_14723.size] = var_5;
      }
    }
  }

  return var_0;
}

function ref_146ff(var_0) {
  level endon("game_ended");
  level endon("zai_round_over");
  var_1 = getdvarint("scr_br_zombie_respawn_time", 5);
  ref_146fd("Zombie Spawning Zone '" + var_0.target + "', Goal of " + level.deploy_subway_cars_on_track + " active");
  level.ref_146ef = [];
  level.ref_146ad = var_0;
  level.ref_146d7 = 0;
  level.ref_146a3 = [];
  var_2 = getEntArray(var_0.target, "targetname");

  if(var_2.size == 0) {
    ref_146fd("Zombie Spawning Zone '" + var_0.target + "' has no volumes");
    return;
  }

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, "team_two_hundred")) {
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, "team_two_hundred");
  }

  thread ref_146a4(level);
  thread ref_146ac();
  level thread scripts\mp\gametypes\br_alt_mode_zai::ref_146ba();
  ref_14707();
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 6000);

  foreach(var_5 in var_3) {
    var_5.unsetbettermissionrewards = 1;
  }

  if(level.ref_14687.packs == 1) {
    foreach(var_5 in var_3) {
      var_5 scripts\mp\hud_message::showsplash("br_zai_begin");
    }
  } else if(level.ref_14687.packs == 2) {
    foreach(var_5 in var_3) {
      var_5 scripts\mp\hud_message::showsplash("br_zai_begin_multiple");
    }
  }

  level thread scripts\mp\gametypes\br_alt_mode_zai::ref_12666(var_0.origin);

  for(;;) {
    if(level.ref_146d7 > 0) {
      var_11 = [];

      foreach(var_13 in level.ref_146ef) {
        if(isalive(var_13)) {
          var_11 = var_13;
          continue;
        }

        if(isDefined(var_13)) {
          var_13 notify("terminate_ai_threads");
        }
      }

      level.ref_146ef = var_11;

      if(get_checking_area_alias()) {
        var_15 = [];
        var_16 = getdvarint("scr_br_zombie_force_ground", 0);
        var_17 = getdvarint("scr_br_zombie_force_vent", 0);
        var_18 = [];

        foreach(var_20 in level.ref_146a3) {
          var_18 = var_20;
          var_18 = scripts\engine\utility::array_combine(var_18, var_20.ref_14723);
        }

        var_18 = scripts\engine\utility::array_remove_duplicates(var_18);

        foreach(var_20 in var_18) {
          var_23 = scripts\engine\utility::getStructArray(var_20.target, "targetname");

          foreach(var_25 in var_23) {
            if(!istrue(var_25.disabled)) {
              if(var_16) {
                if(isDefined(var_25.script_animation) && var_25.script_animation == "spawn_ground") {
                  var_15 = var_25;
                }

                continue;
              }

              if(var_17) {
                if(isDefined(var_25.script_animation) && var_25.script_animation == "spawn_wall_low") {
                  var_15 = var_25;
                }

                continue;
              }

              var_15 = var_25;
            }
          }
        }

        var_15 = scripts\engine\utility::array_randomize(var_15);

        for(var_28 = 0; var_28 < var_15.size && get_checking_area_alias(); var_28++) {
          var_25 = var_15[var_28];
          var_29 = level.ref_14709[level.ref_146f0];
          var_13 = ref_146fa("enemy_lw_base_zombie", var_25.origin, var_25.angles, var_25, var_29);
          level.ref_146ef[level.ref_146ef.size] = var_13;

          if(var_29 == level.ref_146a0) {
            level.deploy_suicide_truck_in_lumber_yard--;
          } else if(var_29 == level.ref_1469f) {
            level.deploy_suicide_truck_in_farm--;
          } else if(var_29 == level.ref_1469e) {
            level.deploy_suicide_truck_in_blockade--;
            var_13 thread scripts\mp\gametypes\br_alt_mode_zai::ref_146b3();
          } else if(var_29 == level.ref_146a2) {
            level.deployable_cover_cancel--;
          } else if(var_29 == level.ref_1469d) {
            level.deploy_subway_cars_on_track--;
          }

          var_13 scripts\mp\gametypes\br_alt_mode_zai::ref_146f5(var_29);
          var_13 scripts\mp\gametypes\br_alt_mode_zai::ref_146f3(var_29);
          var_13 scripts\mp\gametypes\br_alt_mode_zai::ref_146f4(var_29);
          level.ref_146f0++;
          wait level.deployed;
        }
        LOC_00000428:
      }
    }

    wait var_1;
  }
}

function ref_14707() {
  level.ref_14709 = [];
  level.ref_14687.packs = 1;
  var_0 = [];
  var_1 = 0;
  var_2 = 0;

  if(level.ref_14687.ref_145a8 > 0) {
    switch (level.ref_14687.ref_145a8) {
      case 2:
        if(level.deploy_suicide_truck_in_lumber_yard < 0) {
          level.deploy_suicide_truck_in_lumber_yard = 6;
        }

        var_0 = [level.ref_146a0, level.ref_1469f, level.ref_1469e];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.05);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 3);
        break;
      case 3:
        if(level.deploy_suicide_truck_in_farm < 0) {
          level.deploy_suicide_truck_in_farm = 6;
        }

        var_0 = [level.ref_146a0, level.ref_1469f, level.ref_1469e];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.1);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 3);
        break;
      case 4:
        if(level.deploy_suicide_truck_in_blockade < 0) {
          level.deploy_suicide_truck_in_blockade = 6;
        }

        var_0 = [level.ref_146a0, level.ref_1469f, level.ref_1469e];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.1);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 5);
        break;
      case 5:
        if(level.deploy_suicide_truck_in_lumber_yard < 0) {
          level.deploy_suicide_truck_in_lumber_yard = 6;
        }

        if(level.deploy_suicide_truck_in_farm < 0) {
          level.deploy_suicide_truck_in_farm = 6;
        }

        var_0 = [level.ref_146a0, level.ref_1469f, level.ref_1469e];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.2);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 5);
        break;
      case 6:
        if(level.deploy_suicide_truck_in_lumber_yard < 0) {
          level.deploy_suicide_truck_in_lumber_yard = 6;
        }

        if(level.deploy_suicide_truck_in_blockade < 0) {
          level.deploy_suicide_truck_in_blockade = 6;
        }

        var_0 = [level.ref_146a2];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.2);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 5);
        break;
      case 7:
        if(level.deploy_suicide_truck_in_lumber_yard < 0) {
          level.deploy_suicide_truck_in_lumber_yard = 6;
        }

        if(level.deployable_cover_cancel < 0) {
          level.deployable_cover_cancel = 6;
        }

        var_0 = [level.ref_146a0, level.ref_1469f, level.ref_1469e, level.ref_146a2, level.ref_1469d];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.3);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 5);
        break;
      case 8:
        if(level.deploy_suicide_truck_in_farm < 0) {
          level.deploy_suicide_truck_in_farm = 6;
        }

        if(level.deployable_cover_cancel < 0) {
          level.deployable_cover_cancel = 6;
        }

        var_0 = [level.ref_146a0, level.ref_1469f, level.ref_1469e, level.ref_146a2, level.ref_1469d];
        var_1 = getdvarfloat("scr_br_zombie_ai_extra_zombie_spawn_chance", 0.3);
        var_2 = getdvarint("scr_br_zombie_ai_extra_zombie_spawn_quantity", 5);
        break;
      default:
        break;
    }

    if(var_0.size > 0) {
      if(randomfloat(1) < var_1) {
        level.ref_14687.packs = 2;
        var_3 = randomint(var_0.size);

        for(var_4 = 0; var_4 < var_2; var_4++) {
          level.ref_14709[level.ref_14709.size] = var_0[var_3];
        }
      }
    }
  }

  for(var_4 = 0; var_4 < level.deploy_suicide_truck_in_lumber_yard; var_4++) {
    level.ref_14709[level.ref_14709.size] = level.ref_146a0;
  }

  for(var_4 = 0; var_4 < level.deploy_suicide_truck_in_farm; var_4++) {
    level.ref_14709[level.ref_14709.size] = level.ref_1469f;
  }

  for(var_4 = 0; var_4 < level.deploy_suicide_truck_in_blockade; var_4++) {
    level.ref_14709[level.ref_14709.size] = level.ref_1469e;
  }

  for(var_4 = 0; var_4 < level.deployable_cover_cancel; var_4++) {
    level.ref_14709[level.ref_14709.size] = level.ref_146a2;
  }

  if(level.deploy_subway_cars_on_track < 0) {
    level.deploy_subway_cars_on_track = level.ref_146ca - level.ref_14709.size;
  }

  for(var_4 = 0; var_4 < level.deploy_subway_cars_on_track; var_4++) {
    level.ref_14709[level.ref_14709.size] = level.ref_1469d;
  }

  level.ref_14709 = scripts\engine\utility::array_randomize(level.ref_14709);
}

function ref_146ae(var_0, var_1, var_2, var_3, var_4) {
  level notify("zai_computer_used");

  if(!getdvarint("scr_br_enable_zai_button_in_prematch", 0) && !isDefined(level.prematchstarted)) {
    return;
  }

  if(!issubstr(var_0.targetname, "zombie")) {
    return;
  }

  if(vehicle_collision_init(var_0)) {
    return;
  }

  if(isDefined(level.ref_146ad)) {
    var_3 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/ZOMBIE_EVENT_IS_ALREADY_ACTIVE");
    var_3 playlocalsound("br_pickup_deny");
    return 0;
  }

  if(!isDefined(var_0.targetname) || !isDefined(level.ref_146b8) || var_0.targetname != level.ref_146b8) {
    return;
  }

  level.ref_146ad = var_0.targetname;
  level.ref_146f0 = 0;
  level.create_ai_type_override = var_0.origin;
  var_0 scripts\mp\gametypes\br_alt_mode_zai::ref_13d96();
  thread ref_146ff(level);
}

function ref_146bb() {
  if(level.ref_146e9) {
    return self.spawner.ref_146ea;
  }

  return undefined;
}

function get_checking_area_alias() {
  if(level.ref_146f0 < level.ref_14709.size && level.ref_146ef.size < level.deploy_subway_car_at_station) {
    return true;
  }

  return false;
}

function vehicle_collision_init() {
  var_0 = self;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return 0;
  }

  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_3 = var_2 * var_2;

  if(distance2dsquared(var_0.origin, var_1) > var_3) {
    return 1;
  }

  return 0;
}

function ref_146fd(var_0) {}