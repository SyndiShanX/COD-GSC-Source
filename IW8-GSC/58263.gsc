/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58263.gsc
***********************************************/

function all_players_pushed_past_pos() {}

function init() {
  level._effect["vfx_city_killer_gas_explosion"] = loadfx("vfx/iw8_br/gameplay/vfx_br3_city_killer_gas_explosion");
  level._effect["vfx_city_killer_gas_cloud"] = loadfx("vfx/iw8_br/gameplay/vfx_br3_city_killer_gas_cloud");
  level._effect["vfx_city_killer_gas_cloud_player"] = loadfx("vfx/iw8_br/gameplay/vfx_br3_city_killer_gas_cloud_player");
  level._effect["vfx_br3_city_killer_gas_vent_open"] = loadfx("vfx/iw8_br/gameplay/vfx_br3_city_killer_gas_vent_open");
  level._effect["vfx_br3_city_killer_gas_vent_closed"] = loadfx("vfx/iw8_br/gameplay/vfx_br3_city_killer_gas_vent_closed");
  level._effect["vfx_br3_city_killer_gas_cloud_distant"] = loadfx("vfx/iw8_br/gameplay/vfx_br3_city_killer_gas_cloud_distant");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("city_killer", &ref_13e26, undefined, &ref_13e0e);
  scripts\mp\utility\sound::besttime("ks_citykiller");
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  scripts\engine\scriptable::ref_12f57(&scriptable_used);
  test_bag_pickup();
  _handlevehiclerepair::init();
  timesincelastdeath();
  thread testsplashes();

  if(level.gulagloadoutindex.gulagmatchclocksounds == "nth_circle") {
    thread ref_144a3();
  }

  waitframe();

  if(isDefined(level.disable_super_in_turret)) {
    scripts\mp\gametypes\br_pickups::ref_12b33("brloot_killstreak_city_killer", &settings_group);
    return;
  }
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }

  if(isDefined(var_0) && isDefined(var_0.type)) {
    if(var_0.type == "brloot_killstreak_city_killer") {
      var_0 notify("city_killer_picked_up");
      gwperifvfx_plumes(var_3);
      thread ref_144a1();
      thread ref_144a2();
      return;
    }

    return;
  }
}

function testsplashes() {
  waitframe();

  if(!isDefined(game["dialogForAllTeams"])) {
    game["dialogForAllTeams"] = [];
  }

  hack_addkilltriggers("city_killer_enemy_kill_none", "dx_bra_bchr_ck_enemy_kill_none");
  hack_addkilltriggers("city_killer_enemy_killfirm", "dx_bra_bchr_ck_enemy_killfirm");
  hack_addkilltriggers("city_killer_enemy_killfirm_multi", "dx_bra_bchr_ck_enemy_killfirm_multi");
  hack_addkilltriggers("city_killer_radius_danger", "dx_bra_bchr_ck_radius_danger");
  hack_addkilltriggers("city_killer_player_deploy", "dx_bra_bchr_ck_player_deploy");
  hack_addkilltriggers("city_killer_enemy_deploy_far", "dx_bra_bchr_ck_enemy_deploy_far");
  hack_addkilltriggers("city_killer_enemy_deploy_near", "dx_bra_bchr_ck_enemy_deploy_near");
  hack_addkilltriggers("city_killer_squad_deploy", "dx_bra_bchr_ck_squad_deploy");
  hack_addkilltriggers("city_killer_enemy_detonate", "dx_bra_bchr_ck_enemy_detonate");
  hack_addkilltriggers("city_killer_squad_detonate", "dx_bra_bchr_ck_squad_detonate");
  hack_addkilltriggers("city_killer_enemy_acquire_far", "dx_bra_bchr_ck_enemy_acquire_far");
  hack_addkilltriggers("city_killer_enemy_acquire_near", "dx_bra_bchr_ck_enemy_acquire_near");
  hack_addkilltriggers("city_killer_player_pickup", "dx_bra_bchr_ck_player_pickup");
  hack_addkilltriggers("city_killer_squad_acquire", "dx_bra_bchr_ck_squad_acquire");
  hack_addkilltriggers("city_killer_radius_far", "dx_bra_bchr_ck_radius_far");
  hack_addkilltriggers("city_killer_radius_near", "dx_bra_bchr_ck_radius_near");
  hack_addkilltriggers("city_killer_radius_dissipate_far", "dx_bra_bchr_ck_radius_dissipate_far");
  hack_addkilltriggers("city_killer_radius_dissipate_near", "dx_bra_bchr_ck_radius_dissipate_near");
}

function hack_addkilltriggers(var_0, var_1) {
  game["dialog"][var_0] = var_1;
  game["dialogForAllTeams"][var_0] = 1;
}

function gunless() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  var_0 = 5;
  var_1 = 0;

  for(;;) {
    if(self.vehomncontrols != var_1) {
      var_2 = undefined;

      if(self.vehomncontrols - var_1 >= 2) {
        var_2 = "city_killer_enemy_killfirm_multi";
        var_0 = 8;
      } else {
        var_2 = "city_killer_enemy_killfirm";
        var_0 = 5;
      }

      if(isDefined(var_2)) {
        thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_2, self.owner);
      }

      var_1 = self.vehomncontrols;
    }

    wait var_0;
  }
}

function gunbutt(var_0, var_1, var_2, var_3) {
  var_4 = distance2d(self.origin, var_2.origin) <= level.gulagloadoutindex.gulagwinnerrestoregunandammo;
  var_5 = scripts\engine\utility::ter_op(var_4, var_0, var_1);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_5, var_2, 1, 0, var_3);
}

function timesincelastdeath() {
  var_0 = [];
  GscBinSkip0(0x2e, "brloot_plunder_cash_uncommon_2", 2);
}

function test_bag_pickup() {
  if(!isDefined(level.gulagloadoutindex)) {
    level.gulagloadoutindex = spawnStruct();
    level.gulagloadoutindex.instances = [];
    level.gulagloadoutindex.laststandweapon = undefined;
    level.gulagtableloadout = 0;
  }

  level.gulagloadoutindex.ref_11b43 = getdvarfloat("scr_city_killer_max_active_at_once", 1);
  level.gulagloadoutindex.ref_1288c = getdvarfloat("scr_city_killer_prime_time", 3.5);
  level.gulagloadoutindex.leave_pool_behind_after_deactivation = getdvarfloat("scr_city_killer_detonation_time", 30);
  level.gulagloadoutindex.lifetime = getdvarint("scr_city_killer_lifetime", 120);
  level.gulagloadoutindex.ref_12ec1 = getdvarfloat("scr_city_killer_scalar", 1);
  level.gulagloadoutindex.ref_129e2 = getdvarfloat("scr_city_killer_radius_spread_time", 95) * level.gulagloadoutindex.ref_12ec1;
  level.gulagloadoutindex.ref_129e0 = getdvarint("scr_city_killer_radius_max", 15000) * level.gulagloadoutindex.ref_12ec1;
  level.gulagloadoutindex.ref_129e1 = getdvarint("scr_city_killer_radius_min", 2000) * level.gulagloadoutindex.ref_12ec1;
  level.gulagloadoutindex.thermiteburnout = getdvarint("scr_city_killer_initial_detonation_damage", 90);
  level.gulagloadoutindex.is_cs_script_origin = getdvarint("scr_city_killer_initial_damage_per_tick", 6);
  level.gulagloadoutindex.is_cs_scriptable = getdvarint("scr_city_killer_initial_damage_per_tick_multiplier", 3);
  level.gulagloadoutindex.is_current_solution_correct = getdvarint("scr_city_killer_initial_damage_per_tick_multiplier_enabled", 0);
  level.gulagloadoutindex.is_cover_node = getdvarint("scr_city_killer_damage_multiply_duration", 30);
  level.gulagloadoutindex.start_coop_escape_end_camera = getdvarint("scr_city_killer_in_gas_vfx_height_threshold", 2250);
  level.gulagloadoutindex.gulagloadouts = getdvarint("scr_city_killer_circle_vfx_spawn_amount", 2);
  level.gulagloadoutindex.gulagloadouttable = getdvarint("scr_city_killer_circle_vfx_spawn_coverage_angle", 90);
  level.gulagloadoutindex.ref_14295 = getdvarint("scr_city_killer_vfx_distant_cloud_spawn_delay", 0.1);
  level.gulagloadoutindex.ref_14296 = getdvarint("scr_city_killer_vfx_expanding_cloud_spawn_delay", 3.5);
  level.gulagloadoutindex.ref_14294 = getdvarint("scr_city_killer_vfx_allow_high_net_lod", 0);
  level.gulagloadoutindex.ref_142a2 = getdvarint("scr_city_killer_vfx_inner_clouds_spacing", 3000);
  level.gulagloadoutindex.ref_142a1 = getdvarint("scr_city_killer_vfx_inner_clouds_grid_division_count", 15);
  level.gulagloadoutindex.ref_1215b = getdvarint("scr_city_killer_outer_vision_set_enabled", 0);
  level.gulagloadoutindex.ref_1215c = getdvarint("scr_city_killer_outer_vision_set_trigger_distance", 4000);
  level.gulagloadoutindex.gulagwinnertableloadout = getdvarint("scr_city_killer_planted_splash_radius_buffer", 100);
  level.gulagloadoutindex.gulagwinnerrestoregunandammo = getdvarint("scr_city_killer_near_or_far_threshold", level.gulagloadoutindex.ref_129e0 + level.gulagloadoutindex.gulagwinnertableloadout);
  level.gulagloadoutindex.gulagmatchclocksounds = getDvar("scr_city_killer_disable_on_event", "nth_circle");
  level.gulagloadoutindex.gulagplayerlost = getdvarint("scr_city_killer_disable_on_nth_circle", 3);
  level.gulagloadoutindex.gulagplayerwatchfordeath = getdvarint("scr_city_killer_disable_x_secs_before_gulag_shutdown", 120);
}

function ref_13e26(var_0) {
  var_1 = ref_13e27(var_0);

  if(!var_1) {
    var_2 = undefined;

    if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex.ref_11b43) {
      var_2 = "BR_CHEM_WEAPONS/CITY_KILLER_MAX_ACTIVE";
    } else if(!ref_124c5()) {
      var_2 = "BR_CHEM_WEAPONS/CITY_KILLER_STABLE_GROUND";
    } else {
      var_2 = "KILLSTREAKS/CANNOT_BE_USED";
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_2);
    }
  }

  return var_1;
}

function ref_13e0e() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("city_killer", self);
  var_0.ref_133ce = 1;
  return ref_13e27(var_0, 1);
}

function ref_13e27(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex.ref_11b43) {
    return false;
  }

  if(level.gulagtableloadout) {
    return false;
  }

  if(isDefined(level.gulagloadoutindex.laststandweapon) && isPlayer(level.gulagloadoutindex.laststandweapon)) {
    return false;
  }

  if(!ref_124c5()) {
    return false;
  }

  if(self isparachuting() || self isskydiving() || self isonladder()) {
    return false;
  }

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  thread ref_1248c(var_0);

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + var_0.streakname, self);
  }

  return true;
}

function gunnerdamagemodifier() {
  scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  thread scripts\mp\hud_message::showsplash("city_killer_diabled_player");
  _handlevehiclerepair::ref_13673("city_killer_salvage", self.origin, 8, 0);
  thread scripts\mp\rank::giverankxp("city_killer_salvaged", 500);
  thread scripts\mp\rank::scoreeventpopup("city_killer_salvaged");
}

function gwperifvfx_plumes() {
  if(!istrue(self.setupzombierespawnglobaltimer)) {
    self.setupzombierespawnglobaltimer = 1;
  } else {
    return;
  }

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = undefined;

    if(var_1 == self) {
      var_2 = "city_killer_acquired_self";
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("city_killer_player_pickup", var_1);
    } else if(var_1.team == self.team) {
      var_2 = "city_killer_acquired_ally";
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("city_killer_squad_acquire", var_1);
    } else {
      if(distance2d(self.origin, var_1.origin) < 3000) {
        var_2 = "city_killer_acquired_enemy";
      }

      gunbutt("city_killer_enemy_acquire_near", "city_killer_enemy_acquire_far", var_1);
    }

    if(!isDefined(var_2)) {
      continue;
    }

    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_1, var_2);
  }
}

function allowreuseofalldropbags() {}

function ref_1248c(var_0) {
  if(!isDefined(level.gulagloadoutindex.laststandweapon)) {
    level.gulagloadoutindex.laststandweapon = self;
  }

  var_1 = scripts\mp\utility\weapon::getweaponrootname("city_killer_mp");
  var_2 = scripts\mp\class::fixcollision(var_1, undefined, undefined, -1, undefined, undefined, 0);
  var_0.weaponobj = var_2;
  var_0.laststandplayers = 0;
  self.gulagwinnerloadout = var_0;
  ref_1246a(0);
  ref_12469(0);
  self giveweapon(var_2);
  self setweaponammostock(var_2, 0);
  self setweaponammoclip(var_2, 0);
  scripts\mp\supers::allowsuperweaponstow();
  var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("city_killer_mp", 0, 1);
  var_4 = 1;

  if(!istrue(var_3)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_2);
    } else {
      self takeweapon("city_killer_mp");
    }

    var_4 = 0;
  }

  scripts\mp\weapons::fixupplayerweapons(self, var_2);
  thread ref_144a4(var_2);
  thread ref_144a5(var_2);
  thread ref_144a8(var_0);
  thread ref_144a0();
  return var_4;
}

function ref_1246a(var_0) {
  self allowstand(var_0);
  self allowprone(var_0);
  self allowsprint(var_0);
  self allowmovement(var_0);
}

function ref_12469(var_0) {
  if(scripts\common\utility::trial_ui_retry_disabled() != var_0) {
    scripts\common\utility::brjugg_droponplayerdeath(var_0, "city_killer");
  }

  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_killstreaks(var_0);
  scripts\common\utility::allow_crate_use(var_0);
  scripts\mp\equipment::allow_equipment(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::brjugg_onplayerkilled(var_0);
  scripts\common\utility::allow_usability(var_0);
  scripts\common\utility::allow_weapon_pickup(var_0);
  scripts\common\utility::allow_vehicle_use(var_0);
}

function ref_12477(var_0, var_1) {
  if(!isDefined(var_0) || !var_0) {
    scripts\mp\utility\inventory::switchtolastweapon();
  }

  if(isDefined(level.gulagloadoutindex.laststandweapon) && level.gulagloadoutindex.laststandweapon == self) {
    level.gulagloadoutindex.laststandweapon = undefined;
  }

  ref_1246a(1);
  ref_12469(1);

  if(!isDefined(var_1) || !var_1) {
    if(!istrue(self.gulagwinnerloadout.laststandplayers)) {
      playernumlivesvo();
    }
  }

  thread ref_144a7();
}

function allowskydivecutparachute() {}

function ref_144a8(var_0) {
  self endon("death_or_disconnect");
  self endon("abort_city_killer");
  self waittill("weapon_change", var_1);
  var_2 = gettime();
  var_3 = var_2 + level.gulagloadoutindex.ref_1288c * 1000;

  while(gettime() < var_3) {
    if(self getcurrentweapon() != var_1 || isDefined(level.gulagloadoutindex.laststandweapon) && level.gulagloadoutindex.laststandweapon != self) {
      ref_12477(0, 0);
      return;
    }

    waitframe();
  }

  if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex.ref_11b43) {
    ref_12477(0, 0);
    return;
  }

  self.gulagwinnerloadout.laststandplayers = 1;
  ref_12477(0, 1);

  for(;;) {
    if(self getcurrentweapon().basename != "city_killer_mp") {
      var_4 = thread ref_124dc();
      break;
    }

    waitframe();
  }
}

function ref_144a7() {
  self endon("death_or_disconnect");

  while(self hasweapon("city_killer_mp")) {
    if(self getcurrentweapon().basename != "city_killer_mp") {
      self takeweapon("city_killer_mp");
      self.gulagwinnerloadout = undefined;
      break;
    }

    waitframe();
  }

  waitframe();
  self notify("abort_city_killer");
}

function ref_144a4(var_0) {
  self endon("death_or_disconnect");
  self endon("abort_city_killer");

  for(;;) {
    self waittill("weapon_change", var_1);

    if(self hasweapon(var_0) && var_1 != var_0) {
      if(!self isonladder() && !(var_1.ismelee && self ismeleeing()) && var_1.basename != "armor_plate_deploy_mp") {
        var_2 = self.gulagwinnerloadout.laststandplayers;
        ref_12477(1, var_2);
      }
    }
  }
}

function ref_144a0() {
  self endon("disconnect");
  self endon("abort_city_killer");
  self endon("city_killer_deployed");

  if(isDefined(level.gulagloadoutindex.laststandweapon)) {
    level.gulagloadoutindex.laststandweapon = undefined;
  }

  while(isalive(self)) {
    waitframe();
  }

  ref_12485();
}

function ref_144a5(var_0) {
  self endon("death_or_disconnect");
  self endon("abort_city_killer");

  for(;;) {
    self waittill("weapon_taken", var_1);

    if(var_1 == var_0) {
      if(!isDefined(self.gulagwinnerloadout)) {
        break;
      }

      waitframe();
      var_2 = self.gulagwinnerloadout.laststandplayers;
      ref_12477(var_2, var_2);
    }

    waitframe();
  }
}

function ref_144a1() {
  if(level.gulagloadoutindex.gulagmatchclocksounds != "gulag_shutdown") {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("city_killer_gulgag_watcher");
  self endon("city_killer_gulgag_watcher");
  var_0 = 0;

  for(;;) {
    if(istrue(level.usegulag)) {
      if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
        if(!var_0 && scripts\mp\gametypes\br_gulag::run_hud_logic() <= level.gulagloadoutindex.gulagplayerwatchfordeath) {
          thread scripts\mp\hud_message::showsplash("city_killer_diabled_incoming");
          var_0 = 1;
        }
      }

      if(istrue(level.gulag.shutdown)) {
        if(isDefined(scripts\mp\killstreaks\killstreaks::getequippedkillstreakbyname("city_killer"))) {
          thread gunnerdamagemodifier();
        }

        break;
      }
    }

    wait 1;
  }
}

function ref_144a2() {
  if(level.gulagloadoutindex.gulagmatchclocksounds != "nth_circle") {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    level waittill("br_circle_set", var_0);

    if(var_0 >= level.gulagloadoutindex.gulagplayerlost && (!istrue(level.br_circle_disabled) || getdvarint("br_circle_pause", 0) != 1)) {
      if(isDefined(scripts\mp\killstreaks\killstreaks::getequippedkillstreakbyname("city_killer"))) {
        thread gunnerdamagemodifier();
      }

      break;
    }
  }
}

function ref_144a3() {
  if(level.gulagloadoutindex.gulagmatchclocksounds != "nth_circle") {
    return;
  }

  level endon("game_ended");

  for(;;) {
    level waittill("br_circle_set", var_0);

    if(var_0 >= level.gulagloadoutindex.gulagplayerlost && (!istrue(level.br_circle_disabled) || getdvarint("br_circle_pause", 0) != 1)) {
      level.gulagtableloadout = 1;

      if(getdvarint("scr_convoy_should_drop_nebula_bomb") == 1) {
        _handlevehiclerepair::ref_11a46("ai_convoy_killstreaks", "brloot_killstreak_city_killer");
      }

      break;
    }
  }
}

function settings_group() {
  thread ref_1444a();
}

function ref_1444a() {
  level endon("game_ended");
  self endon("city_killer_picked_up");

  for(;;) {
    level waittill("br_circle_set", var_0);

    if(!isDefined(self)) {
      break;
    }

    if(var_0 >= 3) {
      self freescriptable();
      break;
    }
  }
}

function addtoc130infil() {}

function ref_124c5() {
  var_0 = self getgroundentity();

  if(isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "worldspawn" && self isonground()) {
    return true;
  }

  return false;
}

function ref_124dc() {
  self notify("city_killer_deployed");
  var_0 = physics_raycast(self.origin + (0, 0, 30), self.origin + (0, 0, -1500), scripts\engine\trace::create_solid_ai_contents(1), self, 0, "physicsquery_closest", 1, undefined);
  jumpiffalse(!isDefined(var_0) || var_0.size == 0) LOC_00000066;
  var_1 = self.angles;
  var_2 = self.origin;
  goto LOC_000000a7;
}

function gun_buildoverrideattachmentlist() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  var_0 = int(level.gulagloadoutindex.leave_pool_behind_after_deactivation);
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 0, 3, self.origin);
  scripts\mp\gametypes\br_quest_util::ref_13369();
  scripts\mp\gametypes\br_quest_util::ref_1316f(self.ref_129e0);
  self.trackriotshield_tryarm = spawnStruct();
  self.trackriotshield_tryarm scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 0, 2, self.origin);
  self.trackriotshield_tryarm scripts\mp\gametypes\br_quest_util::ref_13369();
  self.trackriotshield_tryarm scripts\mp\gametypes\br_quest_util::ref_1316f(self.ref_129e1);
  var_1 = (0, 0, self.height / 2);
  var_2 = self.origin - var_1;
  self.trigger = spawn("trigger_radius", var_2, 0, self.ref_129e0, self.height);
  scripts\mp\utility\trigger::makeenterexittrigger(self.trigger, &guy_pushes_building, &guy_pushes_terminal, undefined, undefined, &ref_13da5);
  self.trigger.gulagloadoutindex = self;
  gunship_assignedtargetmarkers_onnewai();
  thread hack_laser_trap_control();
  var_3 = int(level.gulagloadoutindex.leave_pool_behind_after_deactivation / 2);
  var_4 = 0;

  for(;;) {
    if(var_0 <= 0) {
      thread gun_remove_fake();
      self notify("city_killer_on_detonate");
      break;
    }

    if(!var_4 && var_0 == var_3) {
      foreach(var_6 in level.players) {
        gunbutt("city_killer_enemy_detonate", "city_killer_squad_detonate", var_6);
      }

      var_4 = 1;
    }

    var_0--;
    wait 1;
  }
}

function hack_laser_trap_control() {
  level endon("game_ended");
  self endon("city_killer_on_detonate");
  var_0 = gettime();
  wait 1;

  while(!self.sfx_infil_hackney_heli2_rope) {
    var_1 = (self.impactfunc_stun - gettime()) / 1000;

    foreach(var_3 in self.trigger.triggerenterents) {
      var_4 = hack_started(var_1);
      var_3 playlocalsound(var_4);
      var_0 = gettime();
    }

    wait 1;
  }
}

function hack_started(var_0) {
  if(var_0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var_0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var_0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var_0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function gunship_assignedtargetmarkers_onnewai() {
  var_0 = "hud_icon_killstreak_city_killer";
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var_1, "current");
  objective_position(var_1, self.origin + (0, 0, 50));
  objective_setplayintro(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  objective_setshowdistance(var_1, 1);
  getbnetigrbattlepassxpmultiplier(var_1, self.ref_129e1, self.ref_129e1 * 2);
  getscriptcachecontents(var_1, 0.5, 0.7);
  scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 50);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);
  self.ref_11f64 = var_1;
}

function gun_remove_fake() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_br3_city_killer_gas_vent_closed"), self, "tag_fx2");
  self setModel("offhand_wm_briefcase_gas_nodraw");
  self.sfx_infil_hackney_heli2_rope = 1;
  var_0 = playFX(scripts\engine\utility::getfx("vfx_city_killer_gas_explosion"), self.origin);
  self.ref_13290 freescriptable();
  self.ref_13290 = undefined;
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.ref_11f64);

  if(level.gulagloadoutindex.ref_14294) {
    var_0 unmarkkeyframedmover(1);
  }

  thread gunship_watchgameend(level, self);
  thread gunless();
  thread gunship_getbombingpoint();
  self setscriptablepartstate("alive", "explode");
  thread track_target_group_complete();

  if(level.gulagloadoutindex.ref_1215b) {
    thread gw_fobs_init();
  }

  self.trigger scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 0, 2, self.origin);
  self.trigger scripts\mp\gametypes\br_quest_util::ref_13369();
  self.onscavengerbagpickup = gettime();
  self.onriskplayerkilled = self.onscavengerbagpickup + level.gulagloadoutindex.leave_pool_behind_after_deactivation * 1000;
  var_1 = 3;

  foreach(var_3 in level.players) {
    thread gunbutt("city_killer_radius_near", "city_killer_radius_far", var_3, var_1);
    LOC_00000137:
  }

  thread gunship_detachplayerfromintro();
  var_5 = 0;

  for(;;) {
    var_6 = gettime();
    var_7 = (var_6 - self.onscavengerbagpickup) / 1000;
    var_5 = var_7 / level.gulagloadoutindex.ref_129e2;
    var_5 = clamp(var_5, 0, 1);
    self.ref_129df = self.ref_129e1 * (1 - var_5) + self.ref_129e0 * var_5;
    self.angles = (0, var_5 * 179, 0);
    var_8 = 1;
    var_9 = self.height;
    var_10 = 0.4;
    var_11 = var_5 * self.height * var_10;
    self.initialwinningteam = clamp(var_11, var_8, var_9);
    self.trigger scripts\mp\gametypes\br_quest_util::ref_1316f(self.ref_129df);
    waitframe();
  }
}

function gunship_getbombingpoint() {
  wait 0.15;

  if(isDefined(level.deposit_from_compromised_convoy_delayed) && isDefined(level.deposit_from_compromised_convoy_delayed.ref_1363d)) {
    var_0 = scripts\engine\utility::array_combine_unique(level.players, level.deposit_from_compromised_convoy_delayed.ref_1363d);
  } else {
    var_0 = level.players;
  }

  foreach(var_2 in var_0) {
    if(self.team == var_2.team && self.owner != var_2) {
      continue;
    }

    var_3 = distance(var_2.origin, self.origin) < self.ref_129e1;

    if(var_3) {
      var_2 dodamage(level.gulagloadoutindex.thermiteburnout, var_2.origin, self.owner, undefined, "MOD_TRIGGER_HURT", "city_killer_mp");

      if(!isagent(var_2) && self.team != var_2.team && var_2.br_armorhealth == 0 && var_2.health - level.gulagloadoutindex.thermiteburnout <= 0) {
        self.vehomncontrols++;
      }
    }
  }

  wait 0.15;
  self.trackriotshield_tryarm.mapcircle delete();
}

function gwinputtypesused() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = self.ref_129e0 + level.gulagloadoutindex.gulagwinnertableloadout;
    var_3 = distance2d(self.origin, var_1.origin) <= var_2;

    if(var_3) {
      scripts\mp\gametypes\br_quest_util::displayplayersplash(var_1, "city_killer_planted");
    }
  }
}

function gunship_detachplayerfromintro() {
  level endon("game_ended");
  wait level.gulagloadoutindex.lifetime;
  level.gulagloadoutindex.instances = scripts\engine\utility::array_remove(level.gulagloadoutindex.instances, self);

  foreach(var_1 in level.players) {
    gun_game_primary_weapon(var_1);
    var_1 notify("city_killer_exit");
    gunship_origin_override(var_1, self.trigger.gulagloadoutindex);
    hack_airport_combat_init(var_1, 0);
  }

  wait 0.5;

  if(self.vehomncontrols == 0) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("city_killer_enemy_kill_none", self.owner, 1, 1);
  }

  var_3 = 3;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    thread gunbutt("city_killer_radius_dissipate_near", "city_killer_radius_dissipate_far", var_1, var_3);
  }

  self.mapcircle delete();
  self.trigger.mapcircle delete();
  self.trigger delete();
  track_settings();
  self notify("city_killer_dissipate");
  self delete();
}

function h(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.ref_124ff)) {
    self.ref_124ff = [];
  }

  var_4 = var_3 getentitynumber();

  if(!isDefined(self.ref_124ff[var_4])) {
    self.ref_124ff[var_4] = [];
  }

  GscBinSkip1(0x45, 0, var_0);
}

function hack_airport_combat_init(var_0) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.gulagstreamexit)) {
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_city_killer_gas_cloud_player"), self, "j_head", self);
    self.gulagstreamexit = undefined;
  }

  if(var_0) {
    self.gulagstreamexit = scripts\engine\utility::getfx("vfx_city_killer_gas_cloud_player");
    playfxontagforclients(self.gulagstreamexit, self, "j_head", self);
    return;
  }
}

function gun_game_primary_weapon(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  self notify("city_killer_stop_vfx");
  var_1 = var_0 getentitynumber();
  var_2 = 4;
  var_3 = 0;

  if(!isDefined(self.ref_124ff)) {
    return;
  }

  if(!isDefined(self.ref_124ff[var_1])) {
    return;
  }

  foreach(var_5 in self.ref_124ff[var_1]) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
    var_9 = stopfxontagforclients(var_6, var_7, var_8, var_0);
    var_10 = isPlayer(var_7) || isbot(var_7) || isagent(var_7);

    if(!var_10) {
      var_7 delete();
    }

    var_3++;

    if(var_3 >= 4) {
      var_3 = 0;
      waitframe();
    }
  }
}

function track_target_group_complete() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  self.ref_142a3 = [];
  self.ref_142a4 = [];
  wait level.gulagloadoutindex.ref_14295;
  self.track_get_teleport_velocity = gettime();
  self.track_get_teleport_target = self.track_get_teleport_velocity + level.gulagloadoutindex.lifetime * 1000;
  thread track_timer_think();

  for(;;) {
    var_0 = gettime();
    var_1 = (var_0 - self.track_get_teleport_velocity) / 1000;
    var_2 = var_1 / level.gulagloadoutindex.ref_129e2;
    var_2 = clamp(var_2, 0, 1);
    self.ref_129df = self.ref_129e1 * (1 - var_2) + self.ref_129e0 * var_2;
    waitframe();
  }
}

function track_timer_think() {
  var_0 = spawnStruct();
  var_1 = self.ref_129e0;
  var_0.ref_11a58 = self.origin + (var_1 * -1, var_1 * -1, 0);
  var_0.ref_11a59 = self.origin + (var_1, var_1 * -1, 0);
  var_0.ref_14039 = self.origin + (var_1 * -1, var_1, 0);
  var_0.ref_1403a = self.origin + (var_1, var_1, 0);
  var_2 = level.gulagloadoutindex.ref_142a1;
  var_3 = self.ref_129e0 * 2;
  var_4 = var_3 / var_2;
  var_5 = (self.origin[0] - self.ref_129e0, self.origin[1] - self.ref_129e0, 0);
  trackcarpunches(self.origin);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    for(var_7 = 0; var_7 < var_2; var_7++) {
      var_8 = var_4 * var_6;
      var_9 = (var_8, 0, 0);
      var_10 = var_4 * var_7;
      var_11 = (0, var_10, 0);
      var_12 = var_5 + var_9 + var_11;

      if(distance2d(var_12, self.origin) < self.ref_129e0) {
        trackcarpunches(var_12);
      }
    }
  }

  track_last_good_position();
}

function trackcarpunches(var_0) {
  var_1 = spawnStruct();
  var_1.index = self.ref_142a3.size;
  var_1.origin = var_0;
  var_1.angles = (0, 0, 0);
  var_1.state = "valid";
  var_1.parent = undefined;
  var_1.ref_14293 = undefined;
  var_2 = distance(var_1.origin, self.origin);
  var_1.loot_getitemcountlefthand = self.ref_129e0 - var_2;
  self.ref_142a3[self.ref_142a3.size] = var_1;
}

function track_last_good_position() {
  trackcashevent(self.ref_142a3[0]);

  foreach(var_1 in self.ref_142a3) {
    if(var_1.state != "valid") {
      continue;
    }

    var_2 = 500;

    if(var_1.loot_getitemcountlefthand <= var_2) {
      continue;
    }

    trackcashevent(var_1);
  }
}

function trackcashevent(var_0) {
  if(var_0.state != "valid") {
    return;
  }

  var_0.state = "selected";
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var_2 = (0, 0, 100000);
  var_3 = var_0.origin + var_2;
  var_4 = var_0.origin - var_2;
  var_5 = [];
  var_6 = physics_raycast(var_3, var_4, var_1, var_5, 0, "physicsquery_closest", 1);
  var_7 = var_0.origin;

  if(isDefined(var_6) && var_6.size > 0) {
    var_7 = var_6[0]["position"];
  }

  var_8 = scripts\engine\utility::ter_op(var_0.loot_getitemcountlefthand < 3000, 200, 1500);
  var_0.ref_14293 = spawnfx(scripts\engine\utility::getfx("vfx_br3_city_killer_gas_cloud_distant"), var_7 + (0, 0, randomfloatrange(0, var_8)));

  if(level.gulagloadoutindex.ref_14294) {
    var_0.ref_14293 unmarkkeyframedmover(1);
  }

  self.ref_142a4[self.ref_142a4.size] = var_0;
  var_9 = risk_flagspawncount();

  foreach(var_11 in self.ref_142a3) {
    if(var_11.state != "valid") {
      continue;
    }

    var_12 = distance2d(var_0.origin, var_11.origin);

    if(var_12 <= level.gulagloadoutindex.ref_142a2) {
      var_11.parent = var_0;
      var_11.state = "occupied";
      var_11.color = var_9;
    }
  }

  thread track_is_operational(var_0);
}

function track_is_operational(var_0) {
  level endon("game_ended");
  var_0 endon("city_killer_dissipate");

  for(;;) {
    if(scripts\engine\utility::updatescrapassistdata(self.origin, var_0.origin, var_0.ref_129df + 1500)) {
      if(isDefined(self.ref_14293)) {
        triggerfx(self.ref_14293);
      }

      break;
    }

    wait 1;
  }
}

function track_settings() {
  foreach(var_1 in self.ref_142a4) {
    if(isDefined(var_1.ref_14293)) {
      var_1.ref_14293 delete();
    }
  }

  self.ref_142a3 = [];
  self.ref_142a4 = [];
  self notify("city_killer_dissipate");
}

function risk_flagspawncount() {
  var_0 = randomfloatrange(0.4, 1);
  var_1 = randomfloatrange(0.3, 0.6);
  var_2 = randomfloatrange(0.3, 1);
  return (var_0, var_1, var_2);
}

function guy_pushes_building(var_0, var_1) {
  var_2 = var_0;
  thread gun_create_fake(var_2);
  thread hack_console_activation_func(var_2, var_1.gulagloadoutindex);

  if(!scripts\engine\utility::array_contains(var_1.gulagloadoutindex.ref_12658, var_2)) {
    var_3 = var_2 getentitynumber();
    var_1.gulagloadoutindex.ref_12658[var_3] = var_2;
    return;
  }
}

function guy_pushes_terminal(var_0, var_1) {
  var_2 = var_0;
  gunship_origin_override(var_2, var_1.gulagloadoutindex);
}

function gun_createrandomweapon() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  jumpiftrue(isDefined(self.ref_12658)) LOC_0000001e;
  self.ref_12658 = [];

  for(;;) {
    foreach(var_1 in self.ref_12658) {
      if(!isDefined(var_1)) {
        continue;
      }

      var_2 = distance2d(self.origin, var_1.origin);

      if(var_2 >= level.gulagloadoutindex.ref_129e0) {
        gunship_watchgameend(var_1, self);
        self.ref_12658 = scripts\engine\utility::array_remove(self.ref_12658, var_1);
      }
    }

    wait 1;
  }
}

function hack_console_activation_func(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  if(var_0.sfx_infil_hackney_heli2_rope) {
    return;
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  self setclientomnvar("ui_nuke_data", 2);
  var_2 = int(var_0.impactfunc_stun);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var_2);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  setomnvar("ui_nuke_end_milliseconds", var_2);
}

function gunship_watchgameend(var_0, var_1) {
  if(isDefined(var_1)) {
    wait var_1;
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
}

function ref_13dbb() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  wait 5;
  setomnvar("ui_nuke_data", 2);
  var_0 = gettime() + 60000;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var_0);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  var_1 = 0;
  var_2 = gettime();
  var_3 = var_0;
  setomnvar("ui_nuke_end_milliseconds", var_0);
}

function gun_create_fake(var_0) {
  while(!var_0.sfx_infil_hackney_heli2_rope) {
    waitframe();
  }

  level endon("game_ended");
  self endon("disconnect");
  self notify("city_killer_enter");
  self endon("city_killer_enter");
  self endon("city_killer_exit");
  var_0 endon("city_killer_dissipate");
  wait 0.1;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(gunship_watchintrodisown(var_0) && gun_course_forward()) {
      if(!istrue(self.start_coop_escape)) {
        self visionsetnakedforplayer("city_killer_in_gas", 0);
        self.start_coop_escape = 1;
        hack_airport_combat_init(1);
      }

      var_1 = level.gulagloadoutindex.is_cs_script_origin;

      if(level.gulagloadoutindex.is_current_solution_correct) {
        var_2 = (gettime() - var_0.onscavengerbagpickup) / 1000;

        if(var_2 <= level.gulagloadoutindex.is_cover_node) {
          var_1 = level.gulagloadoutindex.is_cs_script_origin * level.gulagloadoutindex.is_cs_scriptable;
        }
      }

      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(!scripts\mp\gametypes\br_pickups::ks_circlecount(self)) {
          scripts\mp\gametypes\br_pickups::plunderrepositoryref("city_killer");
        }

        scripts\cp_mp\gasmask::processdamage(var_1);
      } else {
        if(scripts\mp\utility\killstreak::isjuggernaut()) {
          var_1 = scripts\mp\gametypes\br_jugg_common::ref_11c95(var_1);
        }

        if(self.team == var_0.team) {
          var_3 = self;
        } else {
          var_3 = var_1.owner;
        }

        if(scripts\mp\gametypes\br_public::hasarmor()) {
          scripts\mp\gametypes\br_public::damagearmor(var_3);
        } else {
          self dodamage(var_3, self.origin, var_3, undefined, undefined, "city_killer_mp", "j_body");
        }

        if(isPlayer(self)) {
          scripts\mp\gametypes\br_circle::ref_13e18();

          if(self.team != var_1.team && self.br_armorhealth == 0 && self.health - level.gulagloadoutindex.is_cs_script_origin <= 0) {
            var_1.vehomncontrols++;
          }
        }
      }
    } else {
      gunship_origin_override(var_1);
    }

    wait 1;
  }
}

function gunship_origin_override(var_0) {
  if(!gunship_watchownerexitaction()) {
    return;
  }

  self visionsetnakedforplayer("", 0);
  hack_airport_combat_init(0);
  self.start_coop_escape = 0;

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    scripts\mp\gametypes\br_pickups::plunderrankupdate("city_killer");
  }

  if(!isalive(self)) {
    self notify("city_killer_exit");
    return;
  }
}

function gw_fobs_init() {
  level endon("game_ended");
  self endon("city_killer_dissipate");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1.gulagwinnerrestoreloadout)) {
        var_1.gulagwinnerrestoreloadout = 0;
      }

      if(istrue(var_1.start_coop_escape) || istrue(var_1.start_death_from_above_sequence)) {
        continue;
      }

      var_2 = self.ref_129df + level.gulagloadoutindex.ref_1215c;
      var_3 = distance2d(var_1.origin, self.origin) <= var_2;

      if(var_3 && !var_1.gulagwinnerrestoreloadout) {
        var_1 visionsetnakedforplayer("city_killer_near_gas", 0.5);
        continue;
      }

      if(var_1.gulagwinnerrestoreloadout) {
        var_1 visionsetnakedforplayer("", 0.2);
        var_1.gulagwinnerrestoreloadout = 0;
      }
    }

    wait 1;
  }
}

function gun_course_forward() {
  if(!isalive(self)) {
    return false;
  }

  if(istrue(self.start_death_from_above_sequence)) {
    return false;
  }

  if(istrue(self.gulag) && istrue(self.inrespawnc130)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125f3() && scripts\mp\gametypes\br_public::ref_125ec()) {
    return false;
  }

  if(istrue(self.ref_14439)) {
    return false;
  }

  if(istrue(self.unset_relic_thirdperson)) {
    return false;
  }

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed)) {
      return false;
    }
  }

  return true;
}

function gwsiege_config() {
  var_0 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var_1 = (0, 0, 50);
  var_2 = 1;
  var_3 = level.gulagloadoutindex.start_coop_escape_end_camera + var_2;
  var_4 = self.origin + var_1;
  var_5 = self.origin - var_3;
  var_6 = [];

  if(isPlayer(self)) {
    GscBinSkip0(0x2e, 0, self);
  }

  var_7 = physics_raycast(var_4, var_5, var_0, var_6, 0, "physicsquery_closest", 1);

  if(isDefined(var_7[0])) {
    var_8 = var_7[0]["position"];

    if(self.origin[2] - var_8[2] < level.gulagloadoutindex.start_coop_escape_end_camera) {
      return true;
    }
  }

  return false;
}

function gunship_watchintrodisown(var_0) {
  var_1 = gwsiege_config();

  if(distance(self.origin, var_0.origin) < var_0.ref_129df && var_1) {
    return true;
  }

  var_2 = distance2d(self.origin, var_0.origin) <= var_0.ref_129df;
  var_3 = var_0.initialwinningteam / 2;
  var_4 = abs(var_0.origin[2] - self.origin[2]) <= var_0.initialwinningteam / 2;

  if(var_2 && var_1) {
    return true;
  }

  return false;
}

function citykiller_ispointindamagezone(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  return gunship_watchintrodisown(var_2, var_1);
}

function gunship_watchownerexitaction() {
  var_0 = 0;

  foreach(var_2 in level.gulagloadoutindex.instances) {
    if(!isDefined(var_2.trigger)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_2.trigger.triggerenterents, self)) {
      var_3 = gunship_watchintrodisown(var_2);

      if(!var_3) {
        var_0++;
      }
    }
  }

  return level.gulagloadoutindex.instances.size == var_0 || level.gulagloadoutindex.instances.size == 0;
}

function ref_13da5(var_0, var_1) {
  if(isPlayer(var_0) || isbot(var_0) || isagent(var_0)) {
    return false;
  }

  return true;
}

function ref_12485() {
  var_0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_1 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_0, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_city_killer", var_1);
}

function playernumlivesvo() {
  var_0 = level.gametype == "br";

  if(var_0) {
    scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar("city_killer", 0, 0);
    return;
  }

  scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  scripts\mp\killstreaks\killstreaks::awardkillstreak("city_killer", "other");
}

function adjustactivespawnlogic() {}