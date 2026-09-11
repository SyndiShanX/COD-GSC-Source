/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58263.gsc
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

function scriptable_used(var0, var1, var2, var3, var4) {
  if(var3 scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }

  if(isDefined(var0) && isDefined(var0.type)) {
    if(var0.type == "brloot_killstreak_city_killer") {
      var0 notify("city_killer_picked_up");
      gwperifvfx_plumes(var3);
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

function hack_addkilltriggers(var0, var1) {
  game["dialog"][var0] = var1;
  game["dialogForAllTeams"][var0] = 1;
}

function gunless() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  var0 = 5;
  var1 = 0;

  for(;;) {
    if(self.vehomncontrols != var1) {
      var2 = undefined;

      if(self.vehomncontrols - var1 >= 2) {
        var2 = "city_killer_enemy_killfirm_multi";
        var0 = 8;
      } else {
        var2 = "city_killer_enemy_killfirm";
        var0 = 5;
      }

      if(isDefined(var2)) {
        thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var2, self.owner);
      }

      var1 = self.vehomncontrols;
    }

    wait var0;
  }
}

function gunbutt(var0, var1, var2, var3) {
  var4 = distance2d(self.origin, var2.origin) <= level.gulagloadoutindex.gulagwinnerrestoregunandammo;
  var5 = scripts\engine\utility::ter_op(var4, var0, var1);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var5, var2, 1, 0, var3);
}

function timesincelastdeath() {
  var0 = [];
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

function ref_13e26(var0) {
  var1 = ref_13e27(var0);

  if(!var1) {
    var2 = undefined;

    if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex.ref_11b43) {
      var2 = "BR_CHEM_WEAPONS/CITY_KILLER_MAX_ACTIVE";
    } else if(!ref_124c5()) {
      var2 = "BR_CHEM_WEAPONS/CITY_KILLER_STABLE_GROUND";
    } else {
      var2 = "KILLSTREAKS/CANNOT_BE_USED";
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var2);
    }
  }

  return var1;
}

function ref_13e0e() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("city_killer", self);
  var0.ref_133ce = 1;
  return ref_13e27(var0, 1);
}

function ref_13e27(var0, var1) {
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
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  thread ref_1248c(var0);

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var0.streakname, self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + var0.streakname, self);
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

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var2 = undefined;

    if(var1 == self) {
      var2 = "city_killer_acquired_self";
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("city_killer_player_pickup", var1);
    } else if(var1.team == self.team) {
      var2 = "city_killer_acquired_ally";
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("city_killer_squad_acquire", var1);
    } else {
      if(distance2d(self.origin, var1.origin) < 3000) {
        var2 = "city_killer_acquired_enemy";
      }

      gunbutt("city_killer_enemy_acquire_near", "city_killer_enemy_acquire_far", var1);
    }

    if(!isDefined(var2)) {
      continue;
    }

    scripts\mp\gametypes\br_quest_util::displayplayersplash(var1, var2);
  }
}

function allowreuseofalldropbags() {}

function ref_1248c(var0) {
  if(!isDefined(level.gulagloadoutindex.laststandweapon)) {
    level.gulagloadoutindex.laststandweapon = self;
  }

  var1 = scripts\mp\utility\weapon::getweaponrootname("city_killer_mp");
  var2 = scripts\mp\class::fixcollision(var1, undefined, undefined, -1, undefined, undefined, 0);
  var0.weaponobj = var2;
  var0.laststandplayers = 0;
  self.gulagwinnerloadout = var0;
  ref_1246a(0);
  ref_12469(0);
  self giveweapon(var2);
  self setweaponammostock(var2, 0);
  self setweaponammoclip(var2, 0);
  scripts\mp\supers::allowsuperweaponstow();
  var3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("city_killer_mp", 0, 1);
  var4 = 1;

  if(!istrue(var3)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var2)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var2);
    } else {
      self takeweapon("city_killer_mp");
    }

    var4 = 0;
  }

  scripts\mp\weapons::fixupplayerweapons(self, var2);
  thread ref_144a4(var2);
  thread ref_144a5(var2);
  thread ref_144a8(var0);
  thread ref_144a0();
  return var4;
}

function ref_1246a(var0) {
  self allowstand(var0);
  self allowprone(var0);
  self allowsprint(var0);
  self allowmovement(var0);
}

function ref_12469(var0) {
  if(scripts\common\utility::trial_ui_retry_disabled() != var0) {
    scripts\common\utility::brjugg_droponplayerdeath(var0, "city_killer");
  }

  scripts\common\utility::allow_melee(var0);
  scripts\common\utility::allow_killstreaks(var0);
  scripts\common\utility::allow_crate_use(var0);
  scripts\mp\equipment::allow_equipment(var0);
  scripts\common\utility::allow_offhand_weapons(var0);
  scripts\common\utility::brjugg_onplayerkilled(var0);
  scripts\common\utility::allow_usability(var0);
  scripts\common\utility::allow_weapon_pickup(var0);
  scripts\common\utility::allow_vehicle_use(var0);
}

function ref_12477(var0, var1) {
  if(!isDefined(var0) || !var0) {
    scripts\mp\utility\inventory::switchtolastweapon();
  }

  if(isDefined(level.gulagloadoutindex.laststandweapon) && level.gulagloadoutindex.laststandweapon == self) {
    level.gulagloadoutindex.laststandweapon = undefined;
  }

  ref_1246a(1);
  ref_12469(1);

  if(!isDefined(var1) || !var1) {
    if(!istrue(self.gulagwinnerloadout.laststandplayers)) {
      playernumlivesvo();
    }
  }

  thread ref_144a7();
}

function allowskydivecutparachute() {}

function ref_144a8(var0) {
  self endon("death_or_disconnect");
  self endon("abort_city_killer");
  self waittill("weapon_change", var1);
  var2 = gettime();
  var3 = var2 + level.gulagloadoutindex.ref_1288c * 1000;

  while(gettime() < var3) {
    if(self getcurrentweapon() != var1 || isDefined(level.gulagloadoutindex.laststandweapon) && level.gulagloadoutindex.laststandweapon != self) {
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
      var4 = thread ref_124dc();
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

function ref_144a4(var0) {
  self endon("death_or_disconnect");
  self endon("abort_city_killer");

  for(;;) {
    self waittill("weapon_change", var1);

    if(self hasweapon(var0) && var1 != var0) {
      if(!self isonladder() && !(var1.ismelee && self ismeleeing()) && var1.basename != "armor_plate_deploy_mp") {
        var2 = self.gulagwinnerloadout.laststandplayers;
        ref_12477(1, var2);
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

function ref_144a5(var0) {
  self endon("death_or_disconnect");
  self endon("abort_city_killer");

  for(;;) {
    self waittill("weapon_taken", var1);

    if(var1 == var0) {
      if(!isDefined(self.gulagwinnerloadout)) {
        break;
      }

      waitframe();
      var2 = self.gulagwinnerloadout.laststandplayers;
      ref_12477(var2, var2);
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
  var0 = 0;

  for(;;) {
    if(istrue(level.usegulag)) {
      if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
        if(!var0 && scripts\mp\gametypes\br_gulag::run_hud_logic() <= level.gulagloadoutindex.gulagplayerwatchfordeath) {
          thread scripts\mp\hud_message::showsplash("city_killer_diabled_incoming");
          var0 = 1;
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
    level waittill("br_circle_set", var0);

    if(var0 >= level.gulagloadoutindex.gulagplayerlost && (!istrue(level.br_circle_disabled) || getdvarint("br_circle_pause", 0) != 1)) {
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
    level waittill("br_circle_set", var0);

    if(var0 >= level.gulagloadoutindex.gulagplayerlost && (!istrue(level.br_circle_disabled) || getdvarint("br_circle_pause", 0) != 1)) {
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
    level waittill("br_circle_set", var0);

    if(!isDefined(self)) {
      break;
    }

    if(var0 >= 3) {
      self freescriptable();
      break;
    }
  }
}

function addtoc130infil() {}

function ref_124c5() {
  var0 = self getgroundentity();

  if(isDefined(var0) && isDefined(var0.classname) && var0.classname == "worldspawn" && self isonground()) {
    return true;
  }

  return false;
}

function ref_124dc() {
  self notify("city_killer_deployed");
  var0 = physics_raycast(self.origin + (0, 0, 30), self.origin + (0, 0, -1500), scripts\engine\trace::create_solid_ai_contents(1), self, 0, "physicsquery_closest", 1, undefined);
  jumpiffalse(!isDefined(var0) || var0.size == 0) LOC_00000066;
  var1 = self.angles;
  var2 = self.origin;
  goto LOC_000000a7;
}

function gun_buildoverrideattachmentlist() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  var0 = int(level.gulagloadoutindex.leave_pool_behind_after_deactivation);
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 0, 3, self.origin);
  scripts\mp\gametypes\br_quest_util::ref_13369();
  scripts\mp\gametypes\br_quest_util::ref_1316f(self.ref_129e0);
  self.trackriotshield_tryarm = spawnStruct();
  self.trackriotshield_tryarm scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 0, 2, self.origin);
  self.trackriotshield_tryarm scripts\mp\gametypes\br_quest_util::ref_13369();
  self.trackriotshield_tryarm scripts\mp\gametypes\br_quest_util::ref_1316f(self.ref_129e1);
  var1 = (0, 0, self.height / 2);
  var2 = self.origin - var1;
  self.trigger = spawn("trigger_radius", var2, 0, self.ref_129e0, self.height);
  scripts\mp\utility\trigger::makeenterexittrigger(self.trigger, &guy_pushes_building, &guy_pushes_terminal, undefined, undefined, &ref_13da5);
  self.trigger.gulagloadoutindex = self;
  gunship_assignedtargetmarkers_onnewai();
  thread hack_laser_trap_control();
  var3 = int(level.gulagloadoutindex.leave_pool_behind_after_deactivation / 2);
  var4 = 0;

  for(;;) {
    if(var0 <= 0) {
      thread gun_remove_fake();
      self notify("city_killer_on_detonate");
      break;
    }

    if(!var4 && var0 == var3) {
      foreach(var6 in level.players) {
        gunbutt("city_killer_enemy_detonate", "city_killer_squad_detonate", var6);
      }

      var4 = 1;
    }

    var0--;
    wait 1;
  }
}

function hack_laser_trap_control() {
  level endon("game_ended");
  self endon("city_killer_on_detonate");
  var0 = gettime();
  wait 1;

  while(!self.sfx_infil_hackney_heli2_rope) {
    var1 = (self.impactfunc_stun - gettime()) / 1000;

    foreach(var3 in self.trigger.triggerenterents) {
      var4 = hack_started(var1);
      var3 playlocalsound(var4);
      var0 = gettime();
    }

    wait 1;
  }
}

function hack_started(var0) {
  if(var0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function gunship_assignedtargetmarkers_onnewai() {
  var0 = "hud_icon_killstreak_city_killer";
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var1, "current");
  objective_position(var1, self.origin + (0, 0, 50));
  objective_setplayintro(var1, 1);
  objective_setshowoncompass(var1, 1);
  objective_setshowdistance(var1, 1);
  getbnetigrbattlepassxpmultiplier(var1, self.ref_129e1, self.ref_129e1 * 2);
  getscriptcachecontents(var1, 0.5, 0.7);
  scripts\mp\objidpoolmanager::update_objective_icon(var1, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var1, 50);
  scripts\mp\objidpoolmanager::update_objective_onentity(var1, self);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var1, 1);
  self.ref_11f64 = var1;
}

function gun_remove_fake() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_br3_city_killer_gas_vent_closed"), self, "tag_fx2");
  self setModel("offhand_wm_briefcase_gas_nodraw");
  self.sfx_infil_hackney_heli2_rope = 1;
  var0 = playFX(scripts\engine\utility::getfx("vfx_city_killer_gas_explosion"), self.origin);
  self.ref_13290 freescriptable();
  self.ref_13290 = undefined;
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.ref_11f64);

  if(level.gulagloadoutindex.ref_14294) {
    var0 unmarkkeyframedmover(1);
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
  var1 = 3;

  foreach(var3 in level.players) {
    thread gunbutt("city_killer_radius_near", "city_killer_radius_far", var3, var1);
    LOC_00000137:
  }

  thread gunship_detachplayerfromintro();
  var5 = 0;

  for(;;) {
    var6 = gettime();
    var7 = (var6 - self.onscavengerbagpickup) / 1000;
    var5 = var7 / level.gulagloadoutindex.ref_129e2;
    var5 = clamp(var5, 0, 1);
    self.ref_129df = self.ref_129e1 * (1 - var5) + self.ref_129e0 * var5;
    self.angles = (0, var5 * 179, 0);
    var8 = 1;
    var9 = self.height;
    var10 = 0.4;
    var11 = var5 * self.height * var10;
    self.initialwinningteam = clamp(var11, var8, var9);
    self.trigger scripts\mp\gametypes\br_quest_util::ref_1316f(self.ref_129df);
    waitframe();
  }
}

function gunship_getbombingpoint() {
  wait 0.15;

  if(isDefined(level.deposit_from_compromised_convoy_delayed) && isDefined(level.deposit_from_compromised_convoy_delayed.ref_1363d)) {
    var0 = scripts\engine\utility::array_combine_unique(level.players, level.deposit_from_compromised_convoy_delayed.ref_1363d);
  } else {
    var0 = level.players;
  }

  foreach(var2 in var0) {
    if(self.team == var2.team && self.owner != var2) {
      continue;
    }

    var3 = distance(var2.origin, self.origin) < self.ref_129e1;

    if(var3) {
      var2 dodamage(level.gulagloadoutindex.thermiteburnout, var2.origin, self.owner, undefined, "MOD_TRIGGER_HURT", "city_killer_mp");

      if(!isagent(var2) && self.team != var2.team && var2.br_armorhealth == 0 && var2.health - level.gulagloadoutindex.thermiteburnout <= 0) {
        self.vehomncontrols++;
      }
    }
  }

  wait 0.15;
  self.trackriotshield_tryarm.mapcircle delete();
}

function gwinputtypesused() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var2 = self.ref_129e0 + level.gulagloadoutindex.gulagwinnertableloadout;
    var3 = distance2d(self.origin, var1.origin) <= var2;

    if(var3) {
      scripts\mp\gametypes\br_quest_util::displayplayersplash(var1, "city_killer_planted");
    }
  }
}

function gunship_detachplayerfromintro() {
  level endon("game_ended");
  wait level.gulagloadoutindex.lifetime;
  level.gulagloadoutindex.instances = scripts\engine\utility::array_remove(level.gulagloadoutindex.instances, self);

  foreach(var1 in level.players) {
    gun_game_primary_weapon(var1);
    var1 notify("city_killer_exit");
    gunship_origin_override(var1, self.trigger.gulagloadoutindex);
    hack_airport_combat_init(var1, 0);
  }

  wait 0.5;

  if(self.vehomncontrols == 0) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("city_killer_enemy_kill_none", self.owner, 1, 1);
  }

  var3 = 3;

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    thread gunbutt("city_killer_radius_dissipate_near", "city_killer_radius_dissipate_far", var1, var3);
  }

  self.mapcircle delete();
  self.trigger.mapcircle delete();
  self.trigger delete();
  track_settings();
  self notify("city_killer_dissipate");
  self delete();
}

function h(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self.ref_124ff)) {
    self.ref_124ff = [];
  }

  var4 = var3 getentitynumber();

  if(!isDefined(self.ref_124ff[var4])) {
    self.ref_124ff[var4] = [];
  }

  GscBinSkip1(0x45, 0, var0);
}

function hack_airport_combat_init(var0) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.gulagstreamexit)) {
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_city_killer_gas_cloud_player"), self, "j_head", self);
    self.gulagstreamexit = undefined;
  }

  if(var0) {
    self.gulagstreamexit = scripts\engine\utility::getfx("vfx_city_killer_gas_cloud_player");
    playfxontagforclients(self.gulagstreamexit, self, "j_head", self);
    return;
  }
}

function gun_game_primary_weapon(var0) {
  if(!isDefined(var0)) {
    return;
  }

  self notify("city_killer_stop_vfx");
  var1 = var0 getentitynumber();
  var2 = 4;
  var3 = 0;

  if(!isDefined(self.ref_124ff)) {
    return;
  }

  if(!isDefined(self.ref_124ff[var1])) {
    return;
  }

  foreach(var5 in self.ref_124ff[var1]) {
    var6 = var5[0];
    var7 = var5[1];
    var8 = var5[2];
    var9 = stopfxontagforclients(var6, var7, var8, var0);
    var10 = isPlayer(var7) || isbot(var7) || isagent(var7);

    if(!var10) {
      var7 delete();
    }

    var3++;

    if(var3 >= 4) {
      var3 = 0;
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
    var0 = gettime();
    var1 = (var0 - self.track_get_teleport_velocity) / 1000;
    var2 = var1 / level.gulagloadoutindex.ref_129e2;
    var2 = clamp(var2, 0, 1);
    self.ref_129df = self.ref_129e1 * (1 - var2) + self.ref_129e0 * var2;
    waitframe();
  }
}

function track_timer_think() {
  var0 = spawnStruct();
  var1 = self.ref_129e0;
  var0.ref_11a58 = self.origin + (var1 * -1, var1 * -1, 0);
  var0.ref_11a59 = self.origin + (var1, var1 * -1, 0);
  var0.ref_14039 = self.origin + (var1 * -1, var1, 0);
  var0.ref_1403a = self.origin + (var1, var1, 0);
  var2 = level.gulagloadoutindex.ref_142a1;
  var3 = self.ref_129e0 * 2;
  var4 = var3 / var2;
  var5 = (self.origin[0] - self.ref_129e0, self.origin[1] - self.ref_129e0, 0);
  trackcarpunches(self.origin);

  for(var6 = 0; var6 < var2; var6++) {
    for(var7 = 0; var7 < var2; var7++) {
      var8 = var4 * var6;
      var9 = (var8, 0, 0);
      var10 = var4 * var7;
      var11 = (0, var10, 0);
      var12 = var5 + var9 + var11;

      if(distance2d(var12, self.origin) < self.ref_129e0) {
        trackcarpunches(var12);
      }
    }
  }

  track_last_good_position();
}

function trackcarpunches(var0) {
  var1 = spawnStruct();
  var1.index = self.ref_142a3.size;
  var1.origin = var0;
  var1.angles = (0, 0, 0);
  var1.state = "valid";
  var1.parent = undefined;
  var1.ref_14293 = undefined;
  var2 = distance(var1.origin, self.origin);
  var1.loot_getitemcountlefthand = self.ref_129e0 - var2;
  self.ref_142a3[self.ref_142a3.size] = var1;
}

function track_last_good_position() {
  trackcashevent(self.ref_142a3[0]);

  foreach(var1 in self.ref_142a3) {
    if(var1.state != "valid") {
      continue;
    }

    var2 = 500;

    if(var1.loot_getitemcountlefthand <= var2) {
      continue;
    }

    trackcashevent(var1);
  }
}

function trackcashevent(var0) {
  if(var0.state != "valid") {
    return;
  }

  var0.state = "selected";
  var1 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var2 = (0, 0, 100000);
  var3 = var0.origin + var2;
  var4 = var0.origin - var2;
  var5 = [];
  var6 = physics_raycast(var3, var4, var1, var5, 0, "physicsquery_closest", 1);
  var7 = var0.origin;

  if(isDefined(var6) && var6.size > 0) {
    var7 = var6[0]["position"];
  }

  var8 = scripts\engine\utility::ter_op(var0.loot_getitemcountlefthand < 3000, 200, 1500);
  var0.ref_14293 = spawnfx(scripts\engine\utility::getfx("vfx_br3_city_killer_gas_cloud_distant"), var7 + (0, 0, randomfloatrange(0, var8)));

  if(level.gulagloadoutindex.ref_14294) {
    var0.ref_14293 unmarkkeyframedmover(1);
  }

  self.ref_142a4[self.ref_142a4.size] = var0;
  var9 = risk_flagspawncount();

  foreach(var11 in self.ref_142a3) {
    if(var11.state != "valid") {
      continue;
    }

    var12 = distance2d(var0.origin, var11.origin);

    if(var12 <= level.gulagloadoutindex.ref_142a2) {
      var11.parent = var0;
      var11.state = "occupied";
      var11.color = var9;
    }
  }

  thread track_is_operational(var0);
}

function track_is_operational(var0) {
  level endon("game_ended");
  var0 endon("city_killer_dissipate");

  for(;;) {
    if(scripts\engine\utility::updatescrapassistdata(self.origin, var0.origin, var0.ref_129df + 1500)) {
      if(isDefined(self.ref_14293)) {
        triggerfx(self.ref_14293);
      }

      break;
    }

    wait 1;
  }
}

function track_settings() {
  foreach(var1 in self.ref_142a4) {
    if(isDefined(var1.ref_14293)) {
      var1.ref_14293 delete();
    }
  }

  self.ref_142a3 = [];
  self.ref_142a4 = [];
  self notify("city_killer_dissipate");
}

function risk_flagspawncount() {
  var0 = randomfloatrange(0.4, 1);
  var1 = randomfloatrange(0.3, 0.6);
  var2 = randomfloatrange(0.3, 1);
  return (var0, var1, var2);
}

function guy_pushes_building(var0, var1) {
  var2 = var0;
  thread gun_create_fake(var2);
  thread hack_console_activation_func(var2, var1.gulagloadoutindex);

  if(!scripts\engine\utility::array_contains(var1.gulagloadoutindex.ref_12658, var2)) {
    var3 = var2 getentitynumber();
    var1.gulagloadoutindex.ref_12658[var3] = var2;
    return;
  }
}

function guy_pushes_terminal(var0, var1) {
  var2 = var0;
  gunship_origin_override(var2, var1.gulagloadoutindex);
}

function gun_createrandomweapon() {
  level endon("game_ended");
  self endon("city_killer_dissipate");
  jumpiftrue(isDefined(self.ref_12658)) LOC_0000001e;
  self.ref_12658 = [];

  for(;;) {
    foreach(var1 in self.ref_12658) {
      if(!isDefined(var1)) {
        continue;
      }

      var2 = distance2d(self.origin, var1.origin);

      if(var2 >= level.gulagloadoutindex.ref_129e0) {
        gunship_watchgameend(var1, self);
        self.ref_12658 = scripts\engine\utility::array_remove(self.ref_12658, var1);
      }
    }

    wait 1;
  }
}

function hack_console_activation_func(var0, var1) {
  level endon("game_ended");
  self endon("death");

  if(var0.sfx_infil_hackney_heli2_rope) {
    return;
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  self setclientomnvar("ui_nuke_data", 2);
  var2 = int(var0.impactfunc_stun);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var2);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  setomnvar("ui_nuke_end_milliseconds", var2);
}

function gunship_watchgameend(var0, var1) {
  if(isDefined(var1)) {
    wait var1;
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
  var0 = gettime() + 60000;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var0);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  var1 = 0;
  var2 = gettime();
  var3 = var0;
  setomnvar("ui_nuke_end_milliseconds", var0);
}

function gun_create_fake(var0) {
  while(!var0.sfx_infil_hackney_heli2_rope) {
    waitframe();
  }

  level endon("game_ended");
  self endon("disconnect");
  self notify("city_killer_enter");
  self endon("city_killer_enter");
  self endon("city_killer_exit");
  var0 endon("city_killer_dissipate");
  wait 0.1;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(gunship_watchintrodisown(var0) && gun_course_forward()) {
      if(!istrue(self.start_coop_escape)) {
        self visionsetnakedforplayer("city_killer_in_gas", 0);
        self.start_coop_escape = 1;
        hack_airport_combat_init(1);
      }

      var1 = level.gulagloadoutindex.is_cs_script_origin;

      if(level.gulagloadoutindex.is_current_solution_correct) {
        var2 = (gettime() - var0.onscavengerbagpickup) / 1000;

        if(var2 <= level.gulagloadoutindex.is_cover_node) {
          var1 = level.gulagloadoutindex.is_cs_script_origin * level.gulagloadoutindex.is_cs_scriptable;
        }
      }

      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(!scripts\mp\gametypes\br_pickups::ks_circlecount(self)) {
          scripts\mp\gametypes\br_pickups::plunderrepositoryref("city_killer");
        }

        scripts\cp_mp\gasmask::processdamage(var1);
      } else {
        if(scripts\mp\utility\killstreak::isjuggernaut()) {
          var1 = scripts\mp\gametypes\br_jugg_common::ref_11c95(var1);
        }

        if(self.team == var0.team) {
          var3 = self;
        } else {
          var3 = var1.owner;
        }

        if(scripts\mp\gametypes\br_public::hasarmor()) {
          scripts\mp\gametypes\br_public::damagearmor(var3);
        } else {
          self dodamage(var3, self.origin, var3, undefined, undefined, "city_killer_mp", "j_body");
        }

        if(isPlayer(self)) {
          scripts\mp\gametypes\br_circle::ref_13e18();

          if(self.team != var1.team && self.br_armorhealth == 0 && self.health - level.gulagloadoutindex.is_cs_script_origin <= 0) {
            var1.vehomncontrols++;
          }
        }
      }
    } else {
      gunship_origin_override(var1);
    }

    wait 1;
  }
}

function gunship_origin_override(var0) {
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
    foreach(var1 in level.players) {
      if(!isDefined(var1.gulagwinnerrestoreloadout)) {
        var1.gulagwinnerrestoreloadout = 0;
      }

      if(istrue(var1.start_coop_escape) || istrue(var1.start_death_from_above_sequence)) {
        continue;
      }

      var2 = self.ref_129df + level.gulagloadoutindex.ref_1215c;
      var3 = distance2d(var1.origin, self.origin) <= var2;

      if(var3 && !var1.gulagwinnerrestoreloadout) {
        var1 visionsetnakedforplayer("city_killer_near_gas", 0.5);
        continue;
      }

      if(var1.gulagwinnerrestoreloadout) {
        var1 visionsetnakedforplayer("", 0.2);
        var1.gulagwinnerrestoreloadout = 0;
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
  var0 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var1 = (0, 0, 50);
  var2 = 1;
  var3 = level.gulagloadoutindex.start_coop_escape_end_camera + var2;
  var4 = self.origin + var1;
  var5 = self.origin - var3;
  var6 = [];

  if(isPlayer(self)) {
    GscBinSkip0(0x2e, 0, self);
  }

  var7 = physics_raycast(var4, var5, var0, var6, 0, "physicsquery_closest", 1);

  if(isDefined(var7[0])) {
    var8 = var7[0]["position"];

    if(self.origin[2] - var8[2] < level.gulagloadoutindex.start_coop_escape_end_camera) {
      return true;
    }
  }

  return false;
}

function gunship_watchintrodisown(var0) {
  var1 = gwsiege_config();

  if(distance(self.origin, var0.origin) < var0.ref_129df && var1) {
    return true;
  }

  var2 = distance2d(self.origin, var0.origin) <= var0.ref_129df;
  var3 = var0.initialwinningteam / 2;
  var4 = abs(var0.origin[2] - self.origin[2]) <= var0.initialwinningteam / 2;

  if(var2 && var1) {
    return true;
  }

  return false;
}

function citykiller_ispointindamagezone(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  return gunship_watchintrodisown(var2, var1);
}

function gunship_watchownerexitaction() {
  var0 = 0;

  foreach(var2 in level.gulagloadoutindex.instances) {
    if(!isDefined(var2.trigger)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var2.trigger.triggerenterents, self)) {
      var3 = gunship_watchintrodisown(var2);

      if(!var3) {
        var0++;
      }
    }
  }

  return level.gulagloadoutindex.instances.size == var0 || level.gulagloadoutindex.instances.size == 0;
}

function ref_13da5(var0, var1) {
  if(isPlayer(var0) || isbot(var0) || isagent(var0)) {
    return false;
  }

  return true;
}

function ref_12485() {
  var0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var1 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var0, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_city_killer", var1);
}

function playernumlivesvo() {
  var0 = level.gametype == "br";

  if(var0) {
    scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar("city_killer", 0, 0);
    return;
  }

  scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  scripts\mp\killstreaks\killstreaks::awardkillstreak("city_killer", "other");
}

function adjustactivespawnlogic() {}