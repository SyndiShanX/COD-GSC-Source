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
  level.ref_14687.ref_146da = getdvarint("scr_br_zombie_plunder_on_death_amount_base", 1);
  level.ref_14687.ref_146db = getdvarint("scr_br_zombie_plunder_on_death_amount_emp", 2);
  level.ref_14687.ref_146dc = getdvarint("scr_br_zombie_plunder_on_death_amount_explosion", 2);
  level.ref_14687.ref_146dd = getdvarint("scr_br_zombie_plunder_on_death_amount_gas", 2);
  level.ref_14687.ref_146de = getdvarint("scr_br_zombie_plunder_on_death_amount_weakpoint", 3);
  level.ref_14687.ref_146d8 = getdvarint("scr_br_zombie_plunder_multiplier", 50);
  level.ref_14687.ref_145a8 = getdvarint("scr_br_zombie_ai_week_number", 1);
  level.ref_14687.ref_12377 = getdvarfloat("scr_br_zombie_ping_time", 0.5);
  level.ref_14687.ref_12378 = getdvarfloat("scr_br_zombie_ping_wait_time", 2.5);
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
  level.ref_14687.ref_11aea = undefined;
  level.ref_14687.ref_11ae9 = undefined;

  switch (level.ref_14687.ref_145a8) {
    case 2:
    case 1:
      level.ref_14687.ref_11aea = "shipwreck";
      level.ref_14687.ref_11ae9 = "ship_tac";
      break;
    case 3:
      level.ref_14687.ref_11aea = "prison";
      level.ref_14687.ref_11ae9 = "gulag_tac";
      break;
    case 4:
      level.ref_14687.ref_11aea = "hospital";
      level.ref_14687.ref_11ae9 = "hospital_tac";
      break;
    case 5:
      level.ref_14687.ref_11aea = "downtown";
      level.ref_14687.ref_11ae9 = "downtown_tac";
      break;
    case 6:
      level.ref_14687.ref_11aea = "tvstation";
      level.ref_14687.ref_11ae9 = "tvstation_tac";
      break;
    case 7:
      level.ref_14687.ref_11aea = "superstore";
      level.ref_14687.ref_11ae9 = "super_tac";
      break;
    case 8:
      level.ref_14687.ref_11aea = "dam";
      level.ref_14687.ref_11ae9 = "dam_tac";
      break;
  }

  level.ref_146a0 = "gas_on_death";
  level.ref_1469f = "explosion_on_death";
  level.ref_1469e = "emp";
  level.ref_146a2 = "weakpoint";
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
  level.activeuavs["team_two_hundred"] = 0;
  level.activeadvanceduavs["team_two_hundred"] = 0;
  level.activecounteruavs["team_two_hundred"] = 0;
  thread ref_11ffa();
  thread hostvictimdamagefactorlow();
  thread ref_13d99();
  thread ref_146aa();
  thread ref_1468c();
  thread deploy_emp_drone();
  thread ref_1468e();
}

function ref_1468e() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(tableexists("mp/map_callouts/mp_don3_callouts.csv")) {
    var0 = int(tablelookup("mp/map_callouts/mp_don3_callouts.csv", 1, level.ref_14687.ref_11ae9, 0));
  } else {
    var0 = -1;
  }

  setomnvar("ui_br_zm_marked_area", var0);
}

function setup_target_anims() {
  wait 0.1;

  if(getdvarint("scr_br_zombie_encounters", 0) < 1) {
    play_missile_target_marker_vfx_on_missile_target_ent();
    return;
  }

  play_missile_target_marker_vfx_on_missile_target_ent(level.ref_146b8);
}

function play_missile_target_marker_vfx_on_missile_target_ent(var0) {
  if(!isDefined(var0)) {
    thread ref_14688();
    return;
  }

  switch (var0) {
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

function ref_11ffa() {
  for(;;) {
    level waittill("add_to_team", var0);
  }
}

function ref_146eb(var0) {
  level notify("zai_round_over");
  ref_13d97(level.ref_146ad);
  level.ref_146ad = undefined;
  ref_14708();
  thread ref_146ed(var0);
}

function ref_146ee() {
  ref_146eb();

  foreach(var1 in level.ref_146ef) {
    if(isalive(var1)) {
      var1.shutdown = 1;
      var1 suicide();
    }
  }
}

function ref_146ec(var0) {
  if(getdvarint("scr_br_zombie_ai_enable_drop_loot", 1)) {
    var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, var0.origin, var0.angles, var0);
    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_access_card_green", var2);
  }

  var3 = scripts\mp\utility\player::getplayersinradius(var0.origin, 6000);

  if(level.ref_14687.packs == 1) {
    foreach(var5 in var3) {
      var5 scripts\mp\hud_message::showsplash("br_zai_round_over");
    }
  } else if(level.ref_14687.packs == 2) {
    foreach(var5 in var3) {
      var5 scripts\mp\hud_message::showsplash("br_zai_round_over_multiple");
    }
  }

  level.ref_14687.packs = 0;
  ref_146eb(6);

  switch (level.ref_146b8) {
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

function ref_146ed(var0) {
  if(isDefined(var0)) {
    level endon("game_ended");
    level endon("zai_computer_used");
    wait var0;
  }

  foreach(var2 in level.players) {
    var2.unsetbettermissionrewards = 0;
    ref_126dc(var2, level.ref_14687.ref_146c7);
  }
}

function ref_146ba() {
  level endon("game_ended");
  level endon("zai_computer_used");

  for(;;) {
    if(getdvarint("scr_br_zai_force_round_over", 0)) {
      var0 = level.player;

      foreach(var2 in level.ref_146ef) {
        if(isalive(var2)) {
          var0 = var2;
          break;
        }
      }

      setDvar("scr_br_zai_force_round_over", 0);
      ref_146ec(var0);
    }

    wait 2;
  }
}

function ref_14706(var0) {
  var1 = self;

  if(!isDefined(var1.ref_14704)) {
    var1.ref_14704 = "base";
  }

  var2 = level.ref_14687.ref_146da;

  switch (var1.ref_14704) {
    case "gas_on_death":
      thread scripts\mp\equipment\gas_grenade::gas_createtrigger(self.origin, undefined, 5.5, 0.5);
      playFX(level._effect["zmb_ai_gas_death"], var1 gettagorigin("j_spineupper"));
      var2 = level.ref_14687.ref_146dd;
      break;
    case "explosion_on_death":
      playFX(level._effect["zmb_ai_explosion_death"], var1 gettagorigin("j_spineupper"));
      var3 = scripts\mp\utility\player::getplayersinradius(var1.origin, 200);

      foreach(var5 in var3) {
        if(var5 scripts\cp_mp\utility\player_utility::isinvehicle()) {
          if(var5.vehicle.health > var5.vehicle.maxhealth * 0.05) {
            var6 = var5.vehicle.maxhealth * level.ref_14687.onusethanksbc;
            var5.vehicle dodamage(var6, var5.vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
          }
        }

        if(var5 scripts\mp\utility\perk::_hasperk("specialty_br_eod")) {
          var5 dodamage(int(level.ref_14687.onuseitem * 0.85), var1.origin, var1, var5, "MOD_EXPLOSIVE");
        } else {
          var5 dodamage(level.ref_14687.onuseitem, var1.origin, var1, var5, "MOD_EXPLOSIVE");
        }

        var5 earthquakeforplayer(0.35, 0.9, self.origin, 200);
      }

      var2 = level.ref_14687.ref_146dc;
      break;
    case "emp":
      playFX(level._effect["zmb_ai_emp_death"], var1 gettagorigin("j_spine4"));
      var2 = level.ref_14687.ref_146db;
      break;
    case "weakpoint":
      playFX(level._effect["zmb_ai_weakpoint_death"], var1 gettagorigin("j_spineupper"));
      var2 = level.ref_14687.ref_146de;
      break;
    default:
      playFX(level._effect["zmb_ai_base_death"], var1 gettagorigin("j_spineupper"));
      var2 = level.ref_14687.ref_146da;
      break;
  }

  var8 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  if(var2 > 0) {
    if(scripts\mp\utility\game::round_vehicle_logic() == "dmz") {
      var2 *= level.ref_14687.ref_146d8;
    }

    scripts\mp\gametypes\br_plunder::ml_p3_func(var2, var8);
  }

  if(isalive(var0) && isPlayer(var0) && randomfloat(1) < level.ref_14687.ref_146a5) {
    var9 = var0 getcurrentprimaryweapon();
    var10 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var9);

    if(!isDefined(var10)) {
      return;
    }

    foreach(var12 in level.br_ammo_types) {
      var1.br_ammo[var12] = 0;
    }

    var1.br_ammo[var10] = level.br_ammo_clipsize[var10];
    var1 scripts\mp\gametypes\br_pickups::minplunderextractions(var8);
  }

  if(isalive(var0) && isPlayer(var0) && randomfloat(1) < level.ref_14687.ref_146a7) {
    var14 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var8, var1.origin, var1.angles, var1);
    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_armor_plate", var14, level.ref_14687.ref_146a6, 1);
    return;
  }
}

function ref_14708() {
  level.ref_146f0 = 0;

  if(isDefined(level.ref_14687)) {
    level.ref_14687.ref_146c7 = 0;
  }

  level.deploy_subway_cars_on_track = getdvarint("scr_br_zombie_num", -1);
  level.deploy_suicide_truck_in_lumber_yard = getdvarint("scr_br_zombie_total_num_type_gas", -1);
  level.deploy_suicide_truck_in_farm = getdvarint("scr_br_zombie_total_num_type_explosion", -1);
  level.deploy_suicide_truck_in_blockade = getdvarint("scr_br_zombie_total_num_type_emp", -1);
  level.deployable_cover_cancel = getdvarint("scr_br_zombie_total_num_type_weakpoint", -1);
}

function ref_146d4() {
  var0 = self;
  level endon("game_ended");
  var0 endon("terminate_ai_threads");
  var0 endon("death");

  for(;;) {
    var0 setperk("specialty_radarblip", 1);
    wait level.ref_14687.ref_12377;
    var0 unsetperk("specialty_radarblip", 1);
    wait level.ref_14687.ref_12378;
  }
}

function ref_146f5(var0) {
  var1 = self;

  if(!level.ref_14687.ref_146b7) {
    return;
  }

  if(!isDefined(var1.ref_13174) || !isDefined(var1.ref_131bc)) {
    return;
  }

  var2 = randomfloat(2);

  if(var0 == level.ref_146a0 || var0 == level.ref_1469f) {
    var1[[var1.ref_13174]]("sprint");
    var2 = randomfloat(1);
  } else if(var0 == level.ref_1469e || var0 == level.ref_1469d) {
    var1[[var1.ref_13174]]("run");
  } else if(var0 == level.ref_146a2) {
    var1[[var1.ref_13174]]("walk");
  }

  var1[[var1.ref_131bc]](var2);
}

function ref_146f3(var0) {
  var1 = self;

  if(!level.ref_14687.ref_146b6) {
    return;
  }

  if(var0 == level.ref_146a0 || var0 == level.ref_1469f) {
    var1.health = 120;
    return;
  }
}

function ref_146f4(var0) {
  var1 = self;

  if(!level.ref_14687.ref_146b5) {
    return;
  }

  if(var0 == level.ref_146a2) {
    var1.ref_11bbd = level.ref_14687.spawn_entity_carriable;
    return;
  }

  if(var0 == level.ref_1469d) {
    var1.ref_11bbd = level.ref_14687.ref_11bdc;
    return;
  }

  if(var0 == level.ref_1469e || var0 == level.ref_146a0 || var0 == level.ref_1469f) {
    var1.ref_11bbd = level.ref_14687.ref_11a55;
    return;
  }
}

function ref_146af(var0, var1, var2, var3) {
  var4 = self;

  if(isDefined(var4.ref_14704) && isDefined(var0) && isDefined(var1)) {
    if(istrue(var3)) {
      if(isDefined(var2) && var2 == "head") {
        var1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var0 >= self.health, 1, "hitzombieheadshot");
        return;
      }

      var1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var0 >= self.health, 0, "hitzombieheadshot");
      return;
    }

    if(var4.ref_14704 == level.ref_146a2) {
      if(isDefined(var2) && var2 == "head") {
        var1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitarmorheavy", var0 >= self.health, 1);
        return;
      }

      var1 thread scripts\mp\damagefeedback::updatedamagefeedback("hitarmorheavy", var0 >= self.health);
      return;
    }

    if(isDefined(var2) && var2 == "head") {
      var1 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", var0 >= self.health, 1);
      return;
    }

    var1 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", var0 >= self.health);
    return;
  }
}

function ref_1468c() {
  waittillframeend();
  level.ref_14687.max_rpg_groups = ref_1468b();

  foreach(var1 in level.ref_14687.max_rpg_groups) {
    if(isDefined(var1.targetname)) {
      if(var1.targetname == level.ref_146b8) {
        continue;
      }
    }

    var1 delete();
  }

  if(level.mapname == "mp_don3" && getdvarint("scr_br_don3_ship_path_fix", 0)) {
    var3 = getdvarvector("scr_br_don3_ship_path_fix_side_a", (39256, -42265, -506));
    var4 = getdvarvector("scr_br_don3_ship_path_fix_side_b", (39348, -42251, -508));
    var5 = (0, vectortoyaw(var4 - var3), 0);
    var6 = spawncovernode(var3, var5, "Begin", 0, undefined, undefined, "zombie");
    createnavlink("zombie_hack", var3, var4, var6);
    var5 = (0, vectortoyaw(var3 - var4), 0);
    var6 = spawncovernode(var4, var5, "Begin", 0, undefined, undefined, "zombie");
    createnavlink("zombie_hack", var4, var3, var6);
  }

  if(level.mapname == "mp_don3") {
    if(getdvarint("scr_br_zombie_open_all_doors_at_start", 1)) {
      ref_14689();
      return;
    }

    var7 = getdvarfloat("scr_br_don3_ship_door_obstacle_size", 0);

    if(var7 > 0) {
      if(level.ref_146b8 == "br_zombies_zone1" || level.ref_146b8 == "br_zombies_zone1") {
        var8 = ref_1468b("boat_doors_round1");

        foreach(var10 in var8) {
          var11 = anglesToForward(var10.angles) * 26;
          var10.ref_11f9a = createnavbadplacebyshape(var10.origin + var11, 6, var7, 20);
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1468b(var0) {
  var1 = getEntArray(level.ref_146b8, "targetname");

  if(!isDefined(var0)) {
    return var1;
  }

  if(!var1.size) {
    return undefined;
  }

  var2 = [];

  foreach(var4 in var1) {
    if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == var0) {
      var2 = var4;
    }
  }

  return var2;
}

function ref_1468d(var0) {
  if(isDefined(var0.script_linkto)) {
    if(isDefined(var0.ref_11f9a)) {
      destroynavobstacle(var0.ref_11f9a);
    }

    var0 setscriptablepartstate("br_zai_door", "open");
    var0 moveTo(scripts\engine\utility::getStruct(var0.script_linkto, "script_linkname").origin, 2.5, 0.5, 0.5);
    return;
  }
}

function ref_126dc(var0) {
  if(getdvarint("scr_br_zombie_encounters", 0) < 1) {
    return;
  }

  var1 = self;

  if(!isDefined(var1.unsetbettermissionrewards)) {
    var1.unsetbettermissionrewards = 0;
  }

  var2 = ref_1468a(var1.unsetbettermissionrewards, level.ref_14687.packs, var0);
  var1 setclientomnvar("ui_br_zai_counter", var2);
}

function ref_1468a(var0, var1, var2) {
  var3 = int(var0) & 1;
  var3 += (int(var1) & 3) << 1;
  var3 += (int(var2) & 63) << 3;
  return var3;
}

function ref_12666(var0) {
  level endon("game_ended");
  level endon("zai_round_over");

  for(;;) {
    var1 = scripts\mp\utility\player::getplayersinradius(var0, 6000);

    foreach(var3 in level.players) {
      if(!isalive(var3) || var3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var1, var3)) {
        if(!istrue(var3.unsetbettermissionrewards)) {
          ref_1253e(var3);
        }

        var3.unsetbettermissionrewards = 1;
      }

      ref_126dc(var3, level.ref_14687.ref_146c7);
    }

    wait 3;
  }
}

function ref_1253e() {
  var0 = self;

  if(level.ref_14687.packs == 1) {
    var0 scripts\mp\hud_message::showsplash("br_zai_entering_active_area");
    return;
  }

  if(level.ref_14687.packs == 2) {
    var0 scripts\mp\hud_message::showsplash("br_zai_entering_active_area_multiple");
    return;
  }
}

function ref_146b3() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("terminate_ai_threads");

  for(;;) {
    var1 = randomint(5);
    wait 5 + var1 - 2;
    playFXOnTag(level._effect["zmb_ai_emp_charge"], var0, "j_spine4");
    wait 2;
    ref_146b4(var0);
  }
}

function ref_146b4() {
  var0 = 60;
  var1 = 1;
  var2 = 64;
  var3 = var2 * var2;
  var4 = level.ref_14687.mortar_cooldown * level.ref_14687.mortar_cooldown;
  var5 = "zxp_emp_fire_plr";
  var6 = self;
  var7 = anglesToForward(var6.angles);
  playFX(level._effect["zmb_ai_emp_pulse"], var6 gettagorigin("j_spineupper"), var7);
  var8 = getcompleteweaponname("emp_drone_non_player_mp");
  var9 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var10 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var12 in var10) {
    var13 = var12.owner;

    if(isDefined(var13)) {
      if(var13 != var6 && !scripts\cp_mp\utility\player_utility::playersareenemies(var6, var13)) {
        continue;
      }
    }

    var14 = distancesquared(var6.origin, var12.origin);

    if(var14 > var4) {
      continue;
    }

    var15 = scripts\engine\utility::ter_op(var14 > var3, var8, var9);
    var12 dodamage(1, var6.origin, var6, var6, "MOD_EXPLOSIVE", var15);
    var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var6, var12, 1, var15, "MOD_EXPLOSIVE", var6, var6.origin);
    thread ref_126f9(var16);
  }

  var18 = getcompleteweaponname("emp_drone_player_mp");
  var19 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var19 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var6.origin, level.ref_14687.mortar_cooldown);
  }

  foreach(var21 in var19) {
    if(!var21 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var21 != var6 && !scripts\cp_mp\utility\player_utility::playersareenemies(var6, var21)) {
      continue;
    }

    var21 dodamage(1, var6.origin, var6, var6, "MOD_EXPLOSIVE", var18);
    var21 earthquakeforplayer(0.2, 0.7, self.origin, level.ref_14687.mortar_cooldown);
    var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var6, var21, 1, var18, "MOD_EXPLOSIVE", var6, var6.origin);
    thread ref_126f9(var16);
  }
}

function ref_126f9(var0) {
  var1 = 5;
  var2 = 2;
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  var3 = var1;

  if(isPlayer(var0.victim)) {
    var0.victim.unmark_on_death = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var0.victim != self && var0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var3 = var2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }
  }

  moraleslaptopthink(var0, var3);

  if(isDefined(var0.victim)) {
    var0.victim.unmark_on_death = undefined;
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function moraleslaptopthink(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);

  if(var2 != "emp_cleared") {
    var0.empremoved = 1;
    return;
  }
}

function hostvictimdamagefactorlow() {
  level.ref_14696 = spawnStruct();
  level.ref_14696.ref_12f41 = ["off", "offline", "low", "medium", "high", "critical"];
  level.ref_14696.ref_1403b = ["disabled", "enabled"];
  level.ref_14696.ref_12f44 = getdvarfloat("scr_br_zombie_con_comp_screen_update_time", 10);
  level.ref_14696.ref_13334 = getdvarint("scr_br_zombie_con_comp_show_disabled_hint", 1);
  waittillframeend();
  level.ref_14696.holoeffect = getentitylessscriptablearrayinradius("scriptable_containment_computer_01_screen_scripted", "classname");
  scripts\engine\scriptable::ref_12f5b("containment_computer_usable", &hostvictimdefensefactormod);
  var0 = getdvarint("scr_br_zombie_con_comp_screen_prematch", 0);
  var1 = getdvarint("scr_br_zombie_con_comp_usable_prematch", 0);
  hostvictimdamagepercentlow(var0, var1);

  if(!getdvarint("scr_br_enable_zai_button_in_prematch", 0)) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  var0 = getdvarint("scr_br_zombie_con_comp_screen", 2);
  var1 = getdvarint("scr_br_zombie_con_comp_usable", 0);
  hostvictimdamagepercentlow(var0, var1);
}

function hostvictimdamagepercentlow(var0, var1) {
  level.ref_14696.ref_12f42 = var0;

  foreach(var3 in level.ref_14696.holoeffect) {
    var3 notify("containmentComputersScreenRestore");
    hostvictimdamagepercenthigh(var3, var0, var1);
  }
}

function hostvictimdamagepercenthigh(var0, var1, var2) {
  var0.ref_12f43 = var1;
  var3 = level.ref_14696.ref_12f41[var1];
  var0 setscriptablepartstate("containment_computer_screen", var3);

  if(isDefined(var2)) {
    var0.ref_1403c = var2;
    var4 = level.ref_14696.ref_1403b[var2];
    var0 setscriptablepartstate("containment_computer_usable", var4);

    if(level.ref_14696.ref_13334) {
      var0 setscriptablepartstate("containment_computer_not_usable", var4);
      return;
    }

    return;
  }
}

function hostvictimdefensefactormod(var0, var1, var2, var3, var4) {
  if(isDefined(level.br_circle)) {
    var5 = 2;
  } else {
    var5 = 3;
  }

  var4 setclientomnvar("ui_br_purchase_file_override", var5);
  var4 thread scripts\mp\gametypes\br_armory_kiosk::_runpurchasemenu(var1, 1);
  var4 waittill("purchase_menu_closed", var6);

  if(var6 == 1) {
    hostvictimdamagefactorhigh(var1);
    return;
  }
}

function hostvictimattackfactormod(var0) {
  var1 = level.teamdata[var0]["players"];

  foreach(var3 in var1) {
    hostskipburndownmedium(var3);
  }
}

function hostskipburndownmedium(var0) {
  if(!isDefined(var0.delay_kick_inactive_player)) {
    return;
  }

  if(var0.delay_kick_inactive_player.classname != "scriptable_containment_computer_01_screen_scripted") {
    return;
  }

  var0 notify("force_exit");
}

function hostvictimdamagefactorhigh(var0) {
  if(var0.ref_12f43 <= 1) {
    return;
  }

  hostvictimdamagepercenthigh(var0, var0.ref_12f43 - 1);
  hostvictimdamagefactormedium(var0);
}

function hostvictimdamagefactormedium(var0) {
  var0 notify("containmentComputersScreenRestore");
  var0 endon("containmentComputersScreenRestore");

  while(var0.ref_12f43 < level.ref_14696.ref_12f42) {
    wait level.ref_14696.ref_12f44;
    hostvictimdamagepercenthigh(var0, var0.ref_12f43 + 1);
  }
}

function hostvictimdamagepercentmedium(var0) {
  var1 = var0 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_green");

  foreach(var3 in level.ref_14696.holoeffect) {
    if(var1) {
      var3 enablescriptablepartplayeruse("containment_computer_usable", var0);
      var3 disablescriptablepartplayeruse("containment_computer_not_usable", var0);
      continue;
    }

    var3 disablescriptablepartplayeruse("containment_computer_usable", var0);
    var3 enablescriptablepartplayeruse("containment_computer_not_usable", var0);
  }
}

function ref_11ff9(var0) {
  var1 = self;

  if(!isDefined(level.ref_14687)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(var0 == "brloot_access_card_green") {
    var2 = 225000000;

    for(var3 = 0; var3 < level.ref_14687.force_teleport_downedplayer.size; var3++) {
      if(distancesquared(level.ref_14687.forced_aitype_armored[var3].origin, var1.origin) < var2) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.ref_14687.force_teleport_downedplayer[var3], var1);
        return;
      }
    }

    return;
  }
}

function ref_1207d(var0) {
  if(!isDefined(level.ref_14687)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(var0 == "brloot_access_card_green") {
    foreach(var2 in level.ref_14687.force_teleport_downedplayer) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var2, self);
    }

    return;
  }
}

function ref_13d99() {
  var0 = getentitylessscriptablearrayinradius("scriptable_scriptable_test_victor_event_button", "classname");

  if(!getdvarint("scr_br_enable_zai_button_in_prematch", 0)) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
  }

  wait 4;

  foreach(var2 in var0) {
    if(var2.targetname == level.ref_146b8) {
      var2 setscriptablepartstate("button", "usable");
      var3 = anglesToForward(var2.angles);
      var2.ref_12f40 = easepower("scriptable_test_victor_event_button_screen", var2.origin + var3, var2.angles);
      ref_13d97(var2);
    }
  }
}

function ref_13d97() {
  if(isDefined(self.ref_12f40)) {
    self.ref_12f40 setscriptablepartstate("screen", "green");
    return;
  }
}

function ref_13d96() {
  if(isDefined(self.ref_12f40)) {
    self.ref_12f40 setscriptablepartstate("screen", "red_100");
    return;
  }
}

function ref_146aa() {
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

  foreach(var1 in level.ref_14687.force_thermites) {
    if(isDefined(var1.script_noteworthy) && level.ref_146b8 != var1.script_noteworthy) {
      continue;
    }

    if(!isDefined(var1.angles)) {
      var1.angles = (0, 0, 0);
    }

    var2 = easepower("br_loot_cache_zom", var1.origin, var1.angles);
    var2.get_circle_back_nodes_on_same_side = &ref_146a9;
    var2.ref_1406c = &ref_146ab;
    var2.ref_12f7f = "cache_zom";
    var2.ref_11a48 = 1;
    var3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var3, "current", var2.origin + (0, 0, 15), "ui_mp_br_mapmenu_icon_zmb_event_dropbox");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var3, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var3);
      level.ref_14687.force_teleport_downedplayer[level.ref_14687.force_teleport_downedplayer.size] = var3;
    }

    level.ref_14687.forced_aitype_armored[level.ref_14687.forced_aitype_armored.size] = var2;
  }
}

function ref_146a8(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var0;
  var3.angles = var1;
  var3.script_noteworthy = var2;
  level.ref_14687.force_thermites[level.ref_14687.force_thermites.size] = var3;
}

function ref_146a9(var0, var1, var2, var3, var4) {
  if(!var3 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_green")) {
    var3 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/ZOMBIE_CACHE_DENY_CARD");
    var3 playlocalsound("br_pickup_deny");
    return false;
  }

  return true;
}

function ref_146ab(var0, var1, var2, var3, var4) {
  var3 scripts\mp\gametypes\br_pickups::ref_12bfc();

  if(!isDefined(var0.ref_12f80)) {
    var0.ref_12f80 = 0;
  } else {
    var0.ref_12f80 = (var0.ref_12f80 + 1) % 10;
  }

  for(var5 = 0; var5 < level.ref_14687.force_teleport_downedplayer.size; var5++) {
    if(var0 == level.ref_14687.forced_aitype_armored[var5]) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.ref_14687.force_teleport_downedplayer[var5], var3);
    }
  }

  applyminigunrestrictions(var0.origin);

  if(getdvarint("scr_bombardment_killswitch", 0) == 0) {
    var0 scripts\mp\gametypes\br::ref_11aa0("brloot_access_card_purple");
  }

  wait getdvarfloat("scr_br_zombie_cache_wait", 5);
  var0 setscriptablepartstate(var1, "closing");
}

function applyminigunrestrictions(var0) {
  var1 = getdvarint("scr_br_zombie_cache_delete_nearby_loot_radius", 128);

  if(var1 == 0) {
    return;
  }

  var2 = canceljoins(undefined, undefined, var0, var1);

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var4, 0)) {
        continue;
      }

      if(var4 getscriptableisreserved() && !isDefined(var4.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var4);
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

  var0 = [];

  if(!level.ref_14687.maxbetarank) {
    if(level.ref_14687.player_disable_invulnerability) {
      var0 = ref_1468b("boat_doors_round1");
      level.ref_14687.player_disable_invulnerability = 0;
    } else {
      var0 = ref_1468b("boat_doors_round2");
      level.ref_14687.maxbetarank = 1;
    }

    if(isDefined(var0)) {
      foreach(var2 in var0) {
        thread ref_1468d(var2);
      }

      return;
    }

    return;
  }
}

function ref_14688() {
  var0 = getEntArray("boat_doors_round1", "script_noteworthy");
  var0 scripts\engine\utility::array_combine(var0, getEntArray("boat_doors_round2", "script_noteworthy"));

  foreach(var2 in var0) {
    var2 delete();
  }
}

function deploy_emp_drone() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_zmb_sfx");
}