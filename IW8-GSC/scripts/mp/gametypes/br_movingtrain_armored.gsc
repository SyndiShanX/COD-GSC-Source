/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_movingtrain_armored.gsc
***********************************************************/

function init() {
  level.validateattacker = &ref_14642;
  level.ref_13BD1 = &helidrivabledeathall;
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &helidrivabledeath);
  totalweaponxpearned();
  teleport_trigger_to_airplane();
  teleport_to_debug_start_pos();
  tr_kiosksearchparams();
  thread ref_11B37();
  thread exfil_smoke_vfx();
  thread enemy_targets_headshot();
}

function totalweaponxpearned() {
  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    var_1.team = run_openexfil_spawn();
    var_1.wz_tease.team = run_openexfil_spawn();
  }
}

function helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }

  radiusdamage(self.origin, 256, 100, 100, play_ac130_approach_scene(), "MOD_EXPLOSIVE", "toma_proj_mp");
}

function helidrivabledeath(var_0, var_1, var_2, var_3) {
  if(var_2 == "toma_strike") {
    var_4 = scripts\common\utility::playersincylinder(var_0, var_1);

    if(!isDefined(var_3)) {
      var_3 = 1;
    }

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6) || var_6.team == self.team) {
        continue;
      }

      if(isDefined(var_6.waittill_target_group_complete)) {
        var_7 = scripts\engine\utility::ter_op(get_alt_weapon(var_6), var_3, 0);
      } else {
        var_7 = var_3;
      }

      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_6, var_2, var_7);

      if(var_7) {
        var_6.waittill_target_group_complete = gettime();
      }
    }

    return;
  }

  scripts\mp\gametypes\br_killstreaks::isbulletpenetration(var_0, var_1, var_2, var_3);
}

function get_alt_weapon() {
  if(self.heli_orbit_logic.size > 4) {
    return false;
  }

  if(self.waittill_target_group_complete + 10000 > gettime()) {
    return false;
  }

  return true;
}

function teleport_trigger_to_airplane() {
  var_0 = [["", 1, "", level._effect["vfx_br_x2_locomotive_hit"]], ["x2_veh8_mil_lnd_br_train_locomotive_damaged", 1, "d1", level._effect["vfx_br_x2_locomotive_damage_hit"]], ["", 0.5, "d2", undefined], ["", 0, "d3", undefined], ["x2_veh8_mil_lnd_br_train_locomotive_dead", 0, "dead", undefined]];
  level.ref_14637 = ref_127E8(var_0);
  var_0 = [["", 1, "", level._effect["vfx_br_x2_assault_car_hit"], 0], ["x2_veh8_mil_lnd_br_armored_train_cart_d2", 1, "d1", level._effect["vfx_br_x2_assault_car_damage_01_hit"], 0], ["x2_veh8_mil_lnd_br_armored_train_cart_d3", 0.66, "d2", level._effect["vfx_br_x2_assault_car_damage_02_hit"], 1], ["x2_veh8_mil_lnd_br_armored_train_cart_d4", 0.33, "d3", undefined, 1], ["", 0, "explosion", undefined, 1], ["x2_veh8_mil_lnd_br_armored_train_cart_dead", 0, "dead", undefined, 1]];
  level.ref_14636 = ref_127E8(var_0);
  level.ref_14635 = 0;
  var_0 = [["", 1, ""], ["", 0.5, ""], ["", 0, ""]];
  level.ref_14638 = ref_127E8(var_0);
}

function tr_kiosksearchparams() {
  var_0 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      continue;
    }

    var_2.wz_tease.isvalidpos = spawn("script_model", (0, 0, 0));
    var_2.wz_tease.isvalidpos setModel("x2_veh8_mil_lnd_br_train_assault_decal_0" + var_3);
    var_2.wz_tease.isvalidpos linkTo(var_2.wz_tease, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

function ref_127E8(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.model = var_3[0];
    var_4.get_request_backup_alias = var_3[1];
    var_4.statename = var_3[2];
    var_4.completex1stashquest = var_3[3];
    var_4.ref_12C2B = var_3[4];
    var_1 = var_4;
  }

  return var_1;
}

function ref_11B37() {
  level endon("game_ended");
  var_0 = getdvarint("scr_wztrain_carHealthPerPlayer", 1700);
  var_1 = getdvarint("scr_wztrain_locmotiveCarHealthPerPlayer", 3150);
  var_2 = var_0 + 0;
  tr_ontimerexpired(1, var_2, var_1);
  scripts\mp\flags::gameflagwait("prematch_done");
  totaldata();
  tr_ontimerexpired(level.players.size, var_2, var_1);
  level.ref_145F1.brmodifyvehicledamage = getdvarint("scr_wztrain_ambDamagePerPlayer", 0);
  level.ref_145F1.usedcountinveh = 0;
  level.ref_14640 = [];
  fail_mission_if_killed();
}

function tr_ontimerexpired(var_0, var_1, var_2) {
  level.ref_145F1.ref_11B56 = var_0 * var_1;
  level.ref_145F1.ref_11B61 = var_0 * var_2;
  var_3 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_5 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_3) {
      var_5.wz_tease.get_remaining_bots = level.ref_145F1.ref_11B61;
      var_5.wz_tease.lightsfx = 0;
    } else {
      var_5.wz_tease.get_remaining_bots = level.ref_145F1.ref_11B56;
      var_5.wz_tease.lightsfx = 0;
    }

    var_5.wz_tease.stadium_one_death_func = 1;
  }

  var_7 = level.ref_145F1.ref_13C8D.size - 1;
  level.ref_145F1.ref_11B7A = var_7 * level.ref_145F1.ref_11B56;
}

function teleport_to_debug_start_pos() {
  var_0 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    var_2.wz_tease.lb_wood_surf_dmg_scalar = -1;

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      var_2.wz_tease setCanDamage(1);
      thread setup_weapon_spawns();
    } else {
      var_2.wz_tease setCanDamage(1);
      thread handledamage();
    }

    var_2.wz_tease.ref_13CC5 = var_3;
    var_2.wz_tease.ref_11E95 = 1;
    var_2.wz_tease.ref_1217A = 0;
  }
}

function totaldata() {
  var_0 = getdvarfloat("scr_x2_max_damage_reward", 135000);
  level.ref_13735 = [30000, 45000, 60000, 75000, 100000, var_0];
  level.ref_13736 = ["knife_blueprint", "paintjob_stickers_x2", "watch_x2", "emblem_2_x2", "vehicleskin_x2", "callingcards_x2"];
  level.ref_13737 = [];
  var_1 = level.squaddata;

  if(scripts\mp\menus::brking_updateteamscore()) {
    var_1 = [];
    GscBinSkip0(0x2e, "allies", level.squaddata["allies"]);
  }

  foreach(var_7, var_3 in var_1) {
    level.ref_13737[var_7] = [];

    foreach(var_5 in var_3) {
      if(var_5.players.size == 0) {
        continue;
      }

      level.ref_13737[var_7][var_5.index] = spawnStruct();
      level.ref_13737[var_7][var_5.index].ref_13BEE = 0;
      level.ref_13737[var_7][var_5.index].ref_11E72 = 0;
    }
  }
}

function initmarker() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  var_0 = level.ref_145F1.ref_13C8D[0];
  var_0 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_ping_icon_x2_t", "current", var_0.origin + (0, 0, 300));
  objective_removeallfrommask(var_0.objectiveiconid);
  thread ref_13FF4();
  thread ref_13FF3();
  thread ref_13FF5();
}

function ref_13FF5() {
  level endon("game_ended");

  for(;;) {
    var_0 = 4500;

    foreach(var_2 in level.players) {
      var_3 = distance2d(removespecialistbonus(), var_2.origin);

      if(var_3 > var_0 && isalive(var_2)) {
        if(!isDefined(var_2.ref_1337B) || var_2.ref_1337B == 0) {
          ref_1335F(var_2);
          var_2.ref_1337B = 1;
        }

        continue;
      }

      if(istrue(var_2.ref_1337B)) {
        spawn_crew(var_2);
        var_2.ref_1337B = 0;
      }
    }

    wait 1;
  }
}

function removespecialistbonus() {
  return (level.ref_145F1.ref_13C8D[3].origin + level.ref_145F1.ref_13C8D[4].origin) / 2;
}

function ref_13FF4() {
  level endon("game_ended");

  while(!scripts\mp\flags::gameflag("x2_train_destroyed")) {
    var_0 = removespecialistbonus();
    scripts\mp\gametypes\br_quest_util::ref_11DB0(var_0 + (0, 0, 300));
    waitframe();
  }
}

function ref_1335F() {
  var_0 = level.ref_145F1.ref_13C8D[0];
  objective_addclienttomask(var_0.objectiveiconid, self);
  objective_showtoplayersinmask(var_0.objectiveiconid);
}

function spawn_crew() {
  var_0 = level.ref_145F1.ref_13C8D[0];
  objective_removeclientfrommask(var_0.objectiveiconid, self);
  objective_showtoplayersinmask(var_0.objectiveiconid);
}

function ref_13FF3() {
  level endon("game_ended");
  level scripts\engine\utility::ref_143A5("game_ended", "x2_train_destroyed");
  ref_12C0D();
}

function ref_12C0D() {
  var_0 = level.ref_145F1.ref_13C8D[0];
  var_0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function run_openexfil_spawn() {
  if(scripts\mp\menus::brking_updateteamscore()) {
    return "axis";
  }

  return "team_two_hundred";
}

function handledamage() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_10, var_10, var_11);

    if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == run_openexfil_spawn() && !istrue(var_1.ref_1217A)) {
      continue;
    }

    if(self.brdisabledamagestattracking > 0 || self.lb_wood_surf_dmg_scalar < 1) {
      continue;
    }

    if(getdvarint("x2_enable_blink_fx", 1) && !istrue(var_1.ref_11E95)) {
      thread enemy_think(0);
    }

    var_12 = var_1;

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      var_0 = setupmissionwidget(var_1);

      if(isDefined(var_1.owner)) {
        var_12 = var_1.owner;
      }
    }

    var_13 = self.get_remaining_bots;
    self.get_remaining_bots = int(max(self.get_remaining_bots - var_0, 0));

    if(var_13 > 0) {
      if(isPlayer(var_12)) {
        if(self.get_remaining_bots <= 0) {
          var_12 scripts\mp\damagefeedback::updatedamagefeedback("hitheadx2break", 0, 0, "hitheadx2break", 0, 1);
        } else {
          var_12 scripts\mp\damagefeedback::updatedamagefeedback("hitheadx2", 0, 0, "hitheadx2", 0, 1);
        }

        var_14 = int(min(var_0, var_13));
        ref_13FCF(var_12, var_14);
      }

      scripts\mp\gametypes\br_gametype_x2::equipprimarypickup(var_1, var_0);
    }

    if(getgametypekillsperhouravg()) {
      getblueprintforpickupweapon();
    }
  }
}

function setup_weapon_spawns() {
  level endon("game_ended");
  level waittill("x2_locomotive_vulnerable");
  level endon("train_destroyed");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_10, var_10, var_11);

    if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == run_openexfil_spawn() && !istrue(var_1.ref_1217A)) {
      continue;
    }

    if(getdvarint("x2_enable_blink_fx", 1) && !istrue(var_1.ref_11E95)) {
      thread enemy_think(0);
    }

    var_12 = var_1;

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      var_0 = setupmissionwidget(var_1);

      if(isDefined(var_1.owner)) {
        var_12 = var_1.owner;
      }
    }

    var_13 = self.get_remaining_bots;
    self.get_remaining_bots = int(max(self.get_remaining_bots - var_0, 0));

    if(var_13 > 0) {
      if(isPlayer(var_12)) {
        var_12 scripts\mp\damagefeedback::updatedamagefeedback("hitequip", self.get_remaining_bots == 0, 0, "standard", 0, 1);
        var_14 = int(min(var_0, var_13));
        ref_13FCF(var_12, var_14);
      }

      scripts\mp\gametypes\br_gametype_x2::equipprimarypickup(var_1, var_0);
    }

    if(getkothlocations()) {
      getbombteam();
    }
  }
}

function setupmissionwidget(var_0) {
  var_1 = spawnStruct();
  var_1.ent = [var_0, self];
  var_1.velocity = [var_0 vehicle_getvelocity(), self.velocity];
  var_2 = scripts\mp\gametypes\br_movingtrain::setup_hacks(var_1);

  if(var_2 > 0) {
    var_2 = clamp(var_2, 0, 3000);
  }

  return var_2;
}

function ref_13CCD() {
  level endon("game_ended");
  level endon("x2_train_destroyed");
  level.ref_145F1.usedcountinveh = 1;
  var_0 = getdvarint("scr_wztrain_timeBeforeSelfDestruct", 30);
  wait var_0;
  var_1 = level.ref_14636.size - 2;
  var_2 = level.ref_14638.size - 1;
  var_3 = level.ref_14637.size - 2;
  var_4 = level.ref_145F1.ref_11B56 * 0.02;
  var_5 = level.ref_145F1.ref_11B7C * 0.02;
  var_6 = level.ref_145F1.ref_11B61 * 0.02;

  foreach(var_9, var_8 in level.ref_145F1.ref_13C8D) {
    var_8.wz_tease.ref_1217A = 1;
  }

  for(;;) {
    foreach(var_8 in level.ref_145F1.ref_13C8D) {
      var_11 = var_8.wz_tease;

      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
        if(var_11.lb_wood_surf_dmg_scalar < var_3) {
          var_11 dodamage(var_6, var_11.origin, var_11, var_11, "MOD_EXPLOSIVE");
        } else {
          break;
        }

        continue;
      }

      if(var_11.brdisabledamagestattracking > 0) {
        if(isDefined(var_11.frontturret) && var_11.frontturret.lb_wood_surf_dmg_scalar < var_2) {
          var_11.frontturret dodamage(var_5, var_11.frontturret.origin, var_11, var_11, "MOD_EXPLOSIVE");
        }

        if(isDefined(var_11.rearturret) && var_11.rearturret.lb_wood_surf_dmg_scalar < var_2) {
          var_11.rearturret dodamage(var_5, var_11.rearturret.origin, var_11, var_11, "MOD_EXPLOSIVE");
        }

        continue;
      }

      if(var_11.lb_wood_surf_dmg_scalar < var_1) {
        var_11 dodamage(var_4, var_11.origin, var_11, var_11, "MOD_EXPLOSIVE");
      }
    }

    wait 1;
  }
}

function ref_13FCF(var_0, var_1) {
  var_2 = level.ref_13737[var_0.team][var_0.squadindex].ref_13BEE;
  var_3 = level.ref_13735[level.ref_13735.size - 1];

  if(var_2 < var_3) {
    level.ref_13737[var_0.team][var_0.squadindex].ref_13BEE = min(var_2 + var_1, var_3);
    scripts\mp\gametypes\br_gametype_x2::fadeoutoverlay(var_0);

    while(isDefined(level.ref_13735[level.ref_13737[var_0.team][var_0.squadindex].ref_11E72]) && level.ref_13737[var_0.team][var_0.squadindex].ref_13BEE >= level.ref_13735[level.ref_13737[var_0.team][var_0.squadindex].ref_11E72]) {
      ref_13F1A(level.ref_13737[var_0.team][var_0.squadindex].ref_11E72, level.squaddata[var_0.team][var_0.squadindex].players, var_0);
    }

    return;
  }
}

function ref_13F1A(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4.squadindex == var_2.squadindex) {
      var_4 scripts\cp\vehicles\vehicle_compass_cp::ref_120A4(level.ref_13736[var_0]);
    }
  }

  level.ref_13737[var_2.team][var_2.squadindex].ref_11E72++;
}

function getgametypekillsperhouravg() {
  var_0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var_0 >= level.ref_14636.size - 1) {
    return false;
  }

  var_1 = self.get_remaining_bots / level.ref_145F1.ref_11B56;

  if(var_1 > level.ref_14636[var_0].get_request_backup_alias) {
    return false;
  }

  return true;
}

function getblueprintforpickupweapon() {
  var_0 = self.get_remaining_bots / level.ref_145F1.ref_11B56;
  var_1 = level.ref_14636.size - 2;

  while(self.lb_wood_surf_dmg_scalar < var_1 && var_0 <= level.ref_14636[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias) {
    self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var_1));
  }

  caclulate_track_distance(self.lb_wood_surf_dmg_scalar);

  if(self.lb_wood_surf_dmg_scalar == var_1) {
    extract_removemissionweapon();
    thread explosion();
    return;
  }
}

function caclulate_track_distance(var_0) {
  self.lb_wood_surf_dmg_scalar = var_0;
  var_1 = level.ref_14636[self.lb_wood_surf_dmg_scalar];

  if(var_1.model != "") {
    self setModel(var_1.model);
  }

  if(var_1.statename != "") {
    self setscriptablepartstate("base", var_1.statename);
  }

  if(isDefined(var_1.completex1stashquest)) {
    self.completex1stashquest = var_1.completex1stashquest;
  }

  if(isDefined(self.isvalidpos) && self.lb_wood_surf_dmg_scalar >= 4) {
    self.isvalidpos delete();
    self.isvalidpos = undefined;
  }

  lbravo_actor_keep_anim_loop();

  if(istrue(var_1.ref_12C2B)) {
    if(isDefined(self.frontturret)) {
      has_started_cache_defenses(self.frontturret);
    }

    if(isDefined(self.rearturret)) {
      has_started_cache_defenses(self.rearturret);
    }
  }

  if(self.lb_wood_surf_dmg_scalar == 1) {
    level notify("car_vulnerable");
  }

  ref_1402A(self.ref_13CC5, self.lb_wood_surf_dmg_scalar);
}

function calculateandvalidatefuelstability(var_0) {
  self.lb_wood_surf_dmg_scalar = var_0;
  var_1 = level.ref_14637[self.lb_wood_surf_dmg_scalar];

  if(var_1.model != "") {
    self setModel(var_1.model);
  }

  if(var_1.statename != "") {
    self setscriptablepartstate("base", var_1.statename);
  }

  if(isDefined(var_1.completex1stashquest)) {
    self.completex1stashquest = var_1.completex1stashquest;
  }

  ref_13FED(self.lb_wood_surf_dmg_scalar);
}

function ref_119A6() {
  level endon("game_ended");
  thread exterior_goal_func("scn_x2_train_death_explo_final_rampup", self, 4);
  f11scriptlightinit();
  wait 5;
  calculateandvalidatefuelstability(level.ref_14637.size - 1);
  lastdeathheadiconforenemy();
  ref_13C9D();
}

function explosion() {
  level endon("game_ended");
  var_0 = play_ac130_approach_scene();
  self.ref_1293B = 1;
  thread ref_13FD6();
  wait 5;
  self.ref_1293B = 0;
  caclulate_track_distance(level.ref_14636.size - 1);

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_armored_car");
  }

  thread scripts\mp\gametypes\br_gametype_x2::extractquest_helipadid();
  lastdeathheadiconforenemy();
  level.ref_14635 += 1;
  level notify("car_destroyed");
  getrandompointinboundscircle();
  thread ref_13E62();
  wait 0.1;
  var_4 = scripts\mp\utility\player::getplayersinradius(self.origin, 1500);

  foreach(var_2 in var_4) {
    if(onteamproximitybecameinvalidplayer(var_2)) {
      var_2 scripts\mp\gametypes\br_gametype_x2::extratimeincreasecountcap(4);
    }
  }

  ref_13CCA();
  level.ref_145F1.instance++;
  self.mediumstatehealthratio = ref_1327C();
}

function onteamproximitybecameinvalidplayer(var_0) {
  var_1 = ["tag_origin", "tag_front_base", "tag_rear_base", "tag_fx03", "tag_fx01"];
  var_2 = var_0.origin + (0, 0, var_0 getplayerviewheight());
  var_3 = [self, var_0];
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  foreach(var_6 in var_1) {
    if(!self tagexists(var_6)) {
      return;
    }

    var_7 = self gettagorigin(var_6);

    if(scripts\engine\trace::ray_trace_passed(var_7, var_2, var_3, var_4)) {
      return 1;
    }
  }

  return 0;
}

function lbravo_actor_keep_anim_loop() {
  var_0 = 750;
  var_1 = self.origin;
  var_2 = self.angles + (-90, 0, 0);
  var_3 = physics_createcontents(["physicscontents_player"]);
  var_4 = physics_capsulecast(var_1, var_1, 200, var_0 / 2, var_2, var_3, [], "physicsquery_all");
  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = var_7["entity"];

    if(isDefined(var_8)) {
      var_5 = var_8;

      if(onteamproximitybecameinvalidplayer(var_8)) {
        var_8 dodamage(250, self.origin, self, self, "MOD_EXPLOSIVE");
      }
    }
  }

  var_10 = scripts\mp\utility\player::getplayersinradius(self.origin, 750, undefined, var_5);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12) || !onteamproximitybecameinvalidplayer(var_12)) {
      continue;
    }

    var_13 = distancesquared(var_12.origin, self.origin);

    if(var_13 < squared(550)) {
      var_14 = 90;
    } else {
      var_14 = 50;
    }

    var_12 dodamage(var_14, self.origin, self, self, "MOD_EXPLOSIVE");
  }
}

function ref_1327C() {
  var_0 = 700;
  var_1 = 85;
  var_2 = anglesToForward(self.angles) * 350;
  var_3 = anglestoup(self.angles) * 30;
  var_4 = self.origin + var_2 + var_3;
  var_5 = spawn("trigger_rotatable_radius", var_4, 0, var_1, var_0);
  var_5.angles = self.angles + (-90, 0, 0);
  var_5.burnid = scripts\mp\equipment\molotov::molotov_get_next_burning_id();
  var_5.playersintrigger = [];
  var_5.traincar = self;
  var_5 enablelinkTo();
  var_5 linkTo(self);
  thread mercywintriggered();
  thread method_for_calling_reinforcemen();
  thread hangar_juggs();
  return var_5;
}

function mercywintriggered() {
  self endon("death");
  level endon("game_ended");
  level endon("train_destroyed");

  for(;;) {
    self waittill("trigger", var_0);
    var_1 = var_0 getentitynumber();

    if(isDefined(self.playersintrigger[var_1])) {
      continue;
    }

    self.playersintrigger[var_1] = var_0;
    mercymatchending_time(var_0, var_0, undefined, undefined, self.burnid);
  }
}

function method_for_calling_reinforcemen() {
  self endon("death");
  level endon("game_ended");
  level endon("train_destroyed");

  for(;;) {
    foreach(var_1 in self.playersintrigger) {
      if(!isDefined(var_1)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }

      if(var_1 istouching(self)) {
        continue;
      }

      self.playersintrigger[var_2] = undefined;
      var_1 scripts\mp\equipment\molotov::molotov_stop_burning(self.burnid);
    }

    waitframe();
  }
}

function mercymatchending_time(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\equipment\molotov::molotov_get_burning_info(1);

  if(!isDefined(var_3)) {
    var_3 = scripts\mp\equipment\molotov::molotov_get_next_burning_id();
  }

  var_5 = scripts\mp\equipment\molotov::molotov_get_burning_source(var_0, var_1, var_2, var_4, var_3, 1);
  var_6 = 0;

  if(var_5.count <= 0) {
    var_6 = 1;
  }

  var_5.count++;

  if(var_6) {
    thread mercymatchending_nuke();
    return;
  }
}

function mercymatchending_nuke() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread scripts\mp\equipment\molotov::molotov_cleanup_burning();
  var_0 = scripts\mp\equipment\molotov::molotov_get_burning_info();
  jumpiffalse(gettime() <= var_0.updatetimestamp) LOC_00000040;
  waitframe();

  for(;;) {
    var_0 = scripts\mp\equipment\molotov::molotov_get_burning_info();
    var_1 = undefined;

    foreach(var_3 in var_0.sources) {
      if(var_3 scripts\mp\equipment\molotov::molotov_burning_source_is_valid()) {
        if(!isDefined(var_1) || var_3.id > var_1) {
          var_1 = var_3.id;
        }

        continue;
      }

      var_0.sources[var_3.id] = undefined;
    }

    if(isDefined(var_1)) {
      var_0.timeoff = 0;
      var_0.timeon += 0.05;
      var_3 = var_0.sources[var_1];
      var_5 = 15;
      var_6 = undefined;
      var_7 = var_3.attacker.origin;

      if(isDefined(var_3.inflictor)) {
        var_6 = var_3.inflictor;
        var_7 = var_3.inflictor.origin;
      }

      if(var_0.timetodamage <= 0) {
        self dodamage(var_5, var_7, var_3.attacker, var_6, "MOD_EXPLOSIVE", "molotov_mp");
        var_0.firstdamagedone = 1;
        var_0.timetodamage = 0.25;
      } else {
        if(!var_0.firstdamagedone) {
          self dodamage(var_5, var_7, var_3.attacker, var_6, "MOD_EXPLOSIVE", "molotov_mp");
          var_0.firstdamagedone = 1;
        }

        var_0.timetodamage -= 0.05;
      }
    } else {
      var_0.timeoff += 0.05;

      if(var_0.timeoff >= 0.25) {
        thread scripts\mp\equipment\molotov::molotov_clear_burning();
      }
    }

    var_0.updatetimestamp = gettime();
    wait 0.05;
  }
}

function hangar_juggs() {
  level endon("game_ended");
  level waittill("train_destroyed");

  foreach(var_1 in self.playersintrigger) {
    var_1 scripts\mp\equipment\molotov::molotov_stop_burning(self.burnid);
  }

  self.traincar.mediumstatehealthratio = undefined;
  self delete();
}

function ref_13FD6() {
  level endon("game_ended");
  var_0 = undefined;

  while(self.ref_1293B) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    var_0 = getmaxobjectivecount(self.origin[0], self.origin[1], 1500);
    var_0 setmapcirclecolorindex(0);
    var_0 setmapcirclestyleindex(0);
    wait 0.5;
  }

  var_0 delete();
}

function lastdeathheadiconforenemy() {
  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    if(var_1.wz_tease == self) {
      if(isDefined(var_1.num_hackers)) {
        var_1.num_hackers delete();
        break;
      }
    }
  }
}

function run_module_unpause_funcs() {
  var_0 = 0;

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
      continue;
    }

    var_0 += var_2.wz_tease.get_remaining_bots;
  }

  return var_0;
}

function getkothlocations() {
  var_0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var_0 >= level.ref_14637.size - 1) {
    return false;
  }

  var_1 = self.get_remaining_bots / level.ref_145F1.ref_11B61;

  if(var_1 > level.ref_14637[var_0].get_request_backup_alias) {
    return false;
  }

  return true;
}

function getbombteam() {
  var_0 = self.get_remaining_bots / level.ref_145F1.ref_11B61;
  var_1 = level.ref_14637.size - 2;

  while(self.lb_wood_surf_dmg_scalar < var_1 && var_0 <= level.ref_14637[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias) {
    self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var_1));
  }

  calculateandvalidatefuelstability(self.lb_wood_surf_dmg_scalar);

  if(self.lb_wood_surf_dmg_scalar == var_1) {
    thread ref_13E62();
    level notify("x2SuperInterupt");
    extract_removemissionweapon();
    thread ref_119A6();
    return;
  }
}

function register_vehicle_as_ambient() {
  var_0 = [];
  var_1 = level.ref_14636.size - 1;

  foreach(var_3 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
      continue;
    }

    if(var_3.wz_tease.lb_wood_surf_dmg_scalar < var_1) {
      var_0 = var_3;
    }
  }

  return var_0;
}

function getrandompointinboundscircle() {
  var_0 = 0;
  var_1 = level.ref_14636.size - 1;

  foreach(var_3 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
      continue;
    }

    if(var_3.wz_tease.lb_wood_surf_dmg_scalar < var_1) {
      var_0++;
    }
  }

  if(var_0 == 0) {
    ref_119A5();
    return;
  }
}

function ref_119A5() {
  scripts\mp\flags::gameflagset("x2_locomotive_vulnerable");
  var_0 = level.ref_145F1.ref_13C8D[0].wz_tease;
  extractioncomplete(var_0);
  calculateandvalidatefuelstability(var_0, 1);
}

function ref_13C9D() {
  scripts\mp\flags::gameflagset("x2_train_destroyed");

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_train_destroyed");
  }

  ref_13E63(level.ref_145F1.ref_13C8D[0].wz_tease.frontturret);
}

function ref_1402A(var_0, var_1) {
  if(var_1 == 0) {
    return;
  }

  var_2 = 3;
  var_3 = var_0 * var_2;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_br_x2_event_data", var_3, var_2, var_1);
}

function ref_13FED(var_0) {
  var_1 = 3;
  var_2 = 0;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_br_x2_event_data", var_2, var_1, var_0);
}

function ref_1402D(var_0, var_1, var_2) {
  var_3 = 2;
  var_4 = var_3 * 2;
  var_5 = (var_0 - 1) * var_4 + var_1 * var_3;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_br_x2_event_data_2", var_5, var_3, var_2);
}

function enemy_rushdown_player() {
  ent_cleanup(level.ref_145F1.brmodifyvehicledamage * level.ref_14639);
}

function ent_cleanup(var_0) {
  var_1 = 7;
  var_2 = var_0;
  var_3 = [];
  var_4 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_7, var_6 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == var_4) {
      continue;
    }

    var_3 = var_6.wz_tease;
  }

  while(var_1 > 0 && var_2 > 0) {
    var_8 = var_0 / var_1;
    var_9 = 0;
    var_1 = 0;

    foreach(var_7, var_11 in var_3) {
      if(var_8 >= var_11.get_remaining_bots) {
        if(isDefined(var_11.lightsfx) && !var_11.lightsfx) {
          var_9 += var_8 - var_11.get_remaining_bots;
          var_11.lightsfx = 1;
        }
      } else {
        var_1++;
      }

      var_11 dodamage(var_8, var_11.origin, var_11);
    }

    var_2 = var_9;
  }

  var_4 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_11 in var_3) {
    var_11.lightsfx = 0;
  }
}

function entityhit() {
  var_0 = spawnStruct();
  var_0.streakname = "toma_strike";
  var_0.owner = self;
  var_0.score = 0;
  var_0.shots_fired = 0;
  var_0.hits = 0;
  var_0.damage = 0;
  var_0.kills = 0;
  var_0.ref_121A9 = "ks_toma_strike_missile_mp_x2";
  var_0.ref_121A8 = "ks_toma_strike_cluster_mp_x2";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var_0, "toma_strike");
  }

  return var_0;
}

function ents_to_clean_up(var_0) {
  if(var_0 == "armored_train_mg_turret_mp" || var_0 == "armored_train_mg_turret_buffed_mp") {
    return level._effect["vfx_br_x2_train_turrets_gatling_hit"];
  }

  if(var_0 == "armored_train_tank_turret_mp" || var_0 == "armored_train_tank_turret_buffed_mp") {
    return level._effect["vfx_br_x2_train_turrets_88mm_hit"];
  }

  return undefined;
}

function entry_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnturret("misc_turret", var_1, var_5);
  var_7 setModel(var_6);
  var_7.team = run_openexfil_spawn();
  var_7.angles = var_2;
  var_7.turreton = 1;
  var_7.name = var_3;
  var_7.momentum = 0;
  var_7.attackingtarget = undefined;
  var_7.ref_14258 = var_0.name;
  var_7.ref_12CB3 = 15;
  var_7.ref_11C78 = "auto_nonai";
  var_7.ref_11C77 = "sentry_offline";
  var_7.weaponname = var_5;
  var_7.health = level.turretsettings[var_5].health;
  var_7.maxhealth = level.turretsettings[var_5].maxhealth;
  var_7.ref_1407D = 1;
  var_7.ref_12161 = 0;
  var_7.completex1stashquest = ents_to_clean_up(var_5);
  var_7 linkTo(var_0.wz_tease, var_4, (0, 0, 0), (0, 0, 0));
  var_7 setturretteam(run_openexfil_spawn());
  var_7 setturretmodechangewait(0);
  var_7 setmode(var_7.ref_11C78);
  var_7 makeunusable();
  var_7 maketurretinoperable();
  var_7 setconvergenceheightpercent(level.turretsettings[var_5].ref_132BE);
  var_7 setdefaultdroppitch(0);
  var_7 setCanDamage(1);
  var_7 setnodeploy(1);
  var_7 setautorotationdelay(1);
  var_7 setconvergencetime(level.turretsettings[var_5].ref_14681, "yaw");
  var_7 setconvergencetime(level.turretsettings[var_5].ref_12381, "pitch");
  var_7.damagecenter = var_7.origin + (0, 0, 10);
  var_7.ref_13E91 = var_4;
  var_7.lb_wood_surf_dmg_scalar = 0;
  var_7.brking_getcenterofcircle = 1;
  var_7.helperdrone_isbeingpingedbydrone = spawn("script_model", var_7.origin);
  var_7.helperdrone_isbeingpingedbydrone.team = var_7.team;
  var_7.helperdrone_isbeingpingedbydrone linkTo(var_7, "tag_aim_pivot", (0, 0, 0), (0, 0, 0));
  var_7.helperdrone_isbeingpingedbydrone.juggernaut_update_hint_logic = var_2;
  var_7.helperdrone_isbeingpingedbydrone setModel(var_6);
  var_7.helperdrone_isbeingpingedbydrone hide();
  thread ref_13E80();
  thread ref_13E7E();

  if(var_5 != "armored_train_locomotive_turret_mp") {
    thread ref_13E6E();
  }

  level.ref_14640[level.ref_14640.size] = var_7;
  return var_7;
}

function extractcountdown(var_0, var_1, var_2, var_3) {
  var_4 = spawnturret("misc_turret", var_1.origin, var_2);
  var_4 setModel(var_3);
  var_4 linkTo(var_0.wz_tease, var_1.ref_13E91, (0, 0, 0), (0, 0, 0));
  var_4.team = var_1.team;
  var_4.angles = var_1.angles;
  var_4.turreton = var_1.turreton;
  var_4.name = var_1.name;
  var_4.momentum = var_1.momentum;
  var_4.attackingtarget = var_1.attackingtarget;
  var_4.ref_14258 = var_1.ref_14258;
  var_4.ref_12CB3 = var_1.ref_12CB3;
  var_4.ref_11C78 = var_1.ref_11C78;
  var_4.ref_11C77 = var_1.ref_11C77;
  var_4.weaponname = var_2;
  var_4.health = var_1.health;
  var_4.maxhealth = var_1.maxhealth;
  var_4.ref_1407D = var_1.ref_1407D;
  var_4.ref_12161 = var_1.ref_12161;
  var_4.completex1stashquest = ents_to_clean_up(var_2);
  var_4 setturretteam(var_1.team);
  var_4 setturretmodechangewait(0);
  var_4 setmode(var_4.ref_11C78);
  var_4 makeunusable();
  var_4 maketurretinoperable();
  var_4 setconvergenceheightpercent(level.turretsettings[var_1.weaponname].ref_132BE);
  var_4 setdefaultdroppitch(0);
  var_4 setCanDamage(1);
  var_4 setnodeploy(1);
  var_4 setautorotationdelay(1);
  var_4 setconvergencetime(level.turretsettings[var_1.weaponname].ref_14681, "yaw");
  var_4 setconvergencetime(level.turretsettings[var_1.weaponname].ref_12381, "pitch");
  var_4.damagecenter = var_1.damagecenter;
  var_4.ref_13E91 = var_1.ref_13E91;
  var_4.lb_wood_surf_dmg_scalar = var_1.lb_wood_surf_dmg_scalar;
  var_4.helperdrone_isbeingpingedbydrone = spawn("script_model", var_4.origin);
  var_4.helperdrone_isbeingpingedbydrone.team = var_4.team;
  var_4.helperdrone_isbeingpingedbydrone linkTo(var_4, "tag_aim_pivot", (0, 0, 0), (0, 0, 0));
  var_4.helperdrone_isbeingpingedbydrone.juggernaut_update_hint_logic = var_1.angles;
  var_4.helperdrone_isbeingpingedbydrone setModel(var_3);
  var_4.helperdrone_isbeingpingedbydrone hide();
  thread ref_13E80(var_4);
  thread ref_13E7E();

  if(var_2 != "armored_train_locomotive_turret_mp" && var_2 != "armored_train_locomotive_turret_buffed_mp") {
    thread ref_13E6E();
  }

  level.ref_14640[level.ref_14640.size] = var_4;
  return var_4;
}

function extraction_balloon_total_plunder() {
  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
      continue;
    }

    extractioncomplete(var_1.wz_tease.frontturret);
    extractioncomplete(var_1.wz_tease.rearturret);
  }
}

function extractioncomplete() {
  self.ref_12161 = 0;
  self.outlineid = scripts\mp\utility\outline::outlineenableforall(self, "outline_depth_red_x2", "level_script");
}

function extract_removemissionweapon() {
  self.ref_12161 = 1;
  scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
}

function entmantlingendtime() {
  var_0 = spawnStruct();
  var_0.ref_13E89 = "armored_train_mg_turret_mp";
  var_0.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_gatling";
  var_1 = spawnStruct();
  var_1.ref_13E89 = "armored_train_tank_turret_mp";
  var_1.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_88mm";
  var_2 = spawnStruct();
  var_2.ref_13E89 = "armored_train_mortar_turret_mp";
  var_2.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_mortar";
  var_3 = spawnStruct();
  var_3.ref_13E89 = "armored_train_locomotive_turret_mp";
  var_3.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_locomotive";
  return [[var_3], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0]];
}

function enter_numbers_start() {
  var_0 = spawnStruct();
  var_0.ref_13E89 = "armored_train_mg_turret_buffed_mp";
  var_0.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_gatling";
  var_1 = spawnStruct();
  var_1.ref_13E89 = "armored_train_tank_turret_buffed_mp";
  var_1.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_88mm";
  var_2 = spawnStruct();
  var_2.ref_13E89 = "armored_train_locomotive_turret_buffed_mp";
  var_2.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_locomotive";
  return [[var_2], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0]];
}

function fail_mission_if_killed() {
  var_0 = getdvarint("scr_wztrain_turretHealthPerPlayer", 1050);
  var_1 = level.players.size * var_0;
  level.ref_145F1.ref_11B7C = var_1;
  level.turretsettings["armored_train_mg_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_mg_turret_mp"].health = var_1;
  level.turretsettings["armored_train_mg_turret_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_mg_turret_mp"].burst = 20;
  level.turretsettings["armored_train_mg_turret_mp"].ref_12212 = 1;
  level.turretsettings["armored_train_mg_turret_mp"].lockstrength = 3;
  level.turretsettings["armored_train_mg_turret_mp"].spinuptime = 0.1;
  level.turretsettings["armored_train_mg_turret_mp"].cooldowntime = 0.3;
  level.turretsettings["armored_train_mg_turret_mp"].ref_13A84 = 3500;
  level.turretsettings["armored_train_mg_turret_mp"].ref_132BE = 0.65;
  level.turretsettings["armored_train_mg_turret_mp"].ref_14681 = 0.35;
  level.turretsettings["armored_train_mg_turret_mp"].ref_12381 = 0.35;
  level.turretsettings["armored_train_mg_turret_mp"].weaponinfo = "armored_train_mg_turret_mp";
  level.turretsettings["armored_train_mg_turret_buffed_mp"] = spawnStruct();
  level.turretsettings["armored_train_mg_turret_buffed_mp"].health = var_1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].burst = 20;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_12212 = 0.1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].lockstrength = 3;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].spinuptime = 0.1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].cooldowntime = 0.3;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_13A84 = 3500;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_132BE = 0.65;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_14681 = 0.35;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_12381 = 0.35;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].weaponinfo = "armored_train_mg_turret_buffed_mp";
  level.turretsettings["armored_train_tank_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_tank_turret_mp"].health = var_1;
  level.turretsettings["armored_train_tank_turret_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_tank_turret_mp"].burst = 1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_12212 = 3.5;
  level.turretsettings["armored_train_tank_turret_mp"].lockstrength = 3;
  level.turretsettings["armored_train_tank_turret_mp"].spinuptime = 0.4;
  level.turretsettings["armored_train_tank_turret_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_13A84 = 4500;
  level.turretsettings["armored_train_tank_turret_mp"].ref_132BE = 0.1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_tank_turret_mp"].weaponinfo = "armored_train_tank_turret_mp";
  level.turretsettings["armored_train_tank_turret_buffed_mp"] = spawnStruct();
  level.turretsettings["armored_train_tank_turret_buffed_mp"].health = var_1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].burst = 1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_12212 = 0.9;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].lockstrength = 3;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].spinuptime = 0.4;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_13A84 = 4500;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_132BE = 0.1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].weaponinfo = "armored_train_tank_turret_buffed_mp";
  level.turretsettings["armored_train_mortar_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_mortar_turret_mp"].health = var_1;
  level.turretsettings["armored_train_mortar_turret_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_mortar_turret_mp"].burst = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_12212 = 20;
  level.turretsettings["armored_train_mortar_turret_mp"].lockstrength = 6;
  level.turretsettings["armored_train_mortar_turret_mp"].spinuptime = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].cooldowntime = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_13A84 = 5000;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_132BE = 0.2;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].weaponinfo = "armored_train_mortar_turret_mp";
  level.turretsettings["armored_train_mortar_turret_mp"].streakinfo = entityhit();
  level.turretsettings["armored_train_locomotive_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_locomotive_turret_mp"].health = var_1;
  level.turretsettings["armored_train_locomotive_turret_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_locomotive_turret_mp"].burst = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_12212 = 2;
  level.turretsettings["armored_train_locomotive_turret_mp"].lockstrength = 3;
  level.turretsettings["armored_train_locomotive_turret_mp"].spinuptime = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_13A84 = 4500;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_132BE = 0.1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].weaponinfo = "armored_train_locomotive_turret_mp";
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"] = spawnStruct();
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].health = var_1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].maxhealth = var_1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].burst = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_12212 = 0.7;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].lockstrength = 3;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].spinuptime = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_13A84 = 4500;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_132BE = 0.1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].weaponinfo = "armored_train_locomotive_turret_mp";
  var_2 = entmantlingendtime();

  foreach(var_4 in level.ref_145F1.ref_13C8D) {
    var_5 = var_2[var_8];

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
      var_4.wz_tease.frontturret = entry_open(var_4, var_4.wz_tease gettagorigin("tag_turret_front"), var_4.angles, "front_turret", "tag_turret_front", var_5[0].ref_13E89, var_5[0].turretmodel);
      var_4.wz_tease.frontturret.traincar = var_4.wz_tease;
      var_4.wz_tease.brdisabledamagestattracking = 1;
      continue;
    }

    var_6 = (0, 0, 0);
    var_7 = (0, 180, 0);
    var_4.wz_tease.frontturret = entry_open(var_4, var_4.wz_tease gettagorigin("tag_turret_front"), var_4.angles + var_6, "front_turret", "tag_turret_front", var_5[0].ref_13E89, var_5[0].turretmodel);
    var_4.wz_tease.rearturret = entry_open(var_4, var_4.wz_tease gettagorigin("tag_turret_rear"), var_4.angles + var_7, "rear_turret", "tag_turret_rear", var_5[1].ref_13E89, var_5[1].turretmodel);
    var_4.wz_tease.frontturret.traincar = var_4.wz_tease;
    var_4.wz_tease.rearturret.traincar = var_4.wz_tease;
    var_4.wz_tease.brdisabledamagestattracking = 2;
  }
}

function ref_13E80(var_0) {
  self endon("death");
  self endon("disabled");
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait var_0;
  }

  var_1 = level.turretsettings[self.weaponname];
  var_2 = var_1.cooldowntime;

  for(;;) {
    if(!istrue(self.turreton)) {
      waitframe();
      continue;
    }

    var_3 = ref_13E6B();

    if(isDefined(var_3)) {
      self.currenttarget = var_3;
      ref_13E68(var_3);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
    }

    wait 0.05;
  }
}

function ref_13E6B() {
  var_0 = level.turretsettings[self.weaponname];
  var_1 = var_0.ref_13A84;
  var_2 = var_1 * var_1;
  var_3 = self.origin + anglesToForward(self.angles) * var_1;
  var_4 = scripts\common\utility::playersinsphere(var_3, var_1);
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_4) {
    var_9 = ref_13E72(var_8);

    if(!istrue(var_9)) {
      continue;
    }

    var_10 = self gettagorigin("tag_barrel");
    var_11 = var_8.origin;
    var_12 = distancesquared(var_10, var_11);

    if(!isDefined(var_5) && !isDefined(var_6) || var_12 < var_6) {
      var_5 = var_8;
      var_6 = var_12;
    }
  }

  return var_5;
}

function ref_13E72(var_0) {
  var_1 = 1;

  if(!isDefined(var_0)) {
    var_1 = 0;
  } else if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    var_1 = 0;
  } else if(scripts\mp\utility\player::unset_relic_trex(var_0)) {
    var_1 = 0;
  } else if(isDefined(var_0.play_disguise_vo)) {
    var_1 = 0;
  } else if(!ref_13E5E(var_0)) {
    var_1 = 0;
  }

  return var_1;
}

function ref_13E7C(var_0) {
  var_1 = level.turretsettings[self.weaponname];
  var_2 = var_1.ref_13A84;
  var_3 = var_2 * var_2;

  if(!ref_13E72(var_0)) {
    return false;
  }

  if(distancesquared(self gettagorigin("tag_barrel"), var_0.origin) > var_3) {
    return false;
  }

  return true;
}

function ref_13E5E(var_0) {
  var_1 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];
  var_2 = self gettagorigin("tag_flash");
  var_3 = var_0.origin + (0, 0, var_0 getplayerviewheight());
  var_4 = vectorNormalize(var_3 - var_2);
  var_5 = vectorNormalize(anglesToForward(self.angles));
  var_6 = [self, var_0];
  var_6 = scripts\engine\utility::array_combine(var_6, level.ref_14640);
  var_7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  var_8 = var_0 scripts\cp_mp\utility\player_utility::isinvehicle();

  if(istrue(var_8)) {
    var_9 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();
    var_6 = var_9;
    var_10 = var_9 getlinkedchildren();

    if(isDefined(var_10) && var_10.size > 0) {
      var_6 = scripts\engine\utility::array_combine(var_6, var_10);
    }
  }

  for(var_11 = 0; var_11 < var_1.size; var_11++) {
    if(scripts\engine\trace::ray_trace_passed(var_2, var_3, var_6, var_7) && vectordot(var_5, var_4) > cos(120)) {
      return true;
    }
  }

  return false;
}

function ref_13E71(var_0) {
  var_1 = self gettagorigin("tag_flash");
  var_2 = var_0.origin;
  var_3 = vectorNormalize(var_2 - var_1);
  var_4 = vectorNormalize(anglesToForward(self gettagangles("tag_aim_pivot")));

  if(vectordot(var_4, var_3) > 0.3) {
    return true;
  }

  return false;
}

function ref_13E68(var_0) {
  self settargetentity(var_0);
  self.attackingtarget = var_0;
  ref_13E79();
  ref_13E5C(var_0);
  ref_13E5D();
  self cleartargetentity();
  self.currenttarget = undefined;
}

function ref_13E79() {
  self laseron();
  var_0 = level.turretsettings[self.weaponname];

  while(istrue(self.turreton) && self.momentum < var_0.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function ref_13E78() {
  self laseroff();
  self.momentum = 0;
}

function ref_13E5C(var_0) {
  self endon("disabled");
  var_1 = level.turretsettings[self.weaponname];
  var_2 = var_1.burst;
  var_3 = var_1.ref_12212;
  var_4 = var_1.lockstrength;

  while(istrue(self.turreton) && ref_13E7C(var_0)) {
    for(var_5 = 0; var_5 < var_2; var_5++) {
      if(istrue(self.turreton) && ref_13E7C(var_0) && ref_13E71(var_0)) {
        if(self.weaponname == "armored_train_mortar_turret_mp") {
          var_6 = var_1.streakinfo;
          ref_11D2C(self.origin, var_0.origin, var_6);
          self shootturret("tag_flash", var_4);
        } else {
          var_7 = weaponfiretime(var_1.weaponinfo);
          self shootturret("tag_flash", var_4);
          wait var_7;
        }

        continue;
      }

      break;
    }

    wait var_3;
  }
}

function ref_13E5D() {
  ref_13E78();
}

function ref_13E7E() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.helperdrone_isbeingpingedbydrone delete();
    self delete();
    return;
  }
}

function enemy_think(var_0) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.ref_12161)) {
    return;
  }

  var_1 = "tag_origin";

  if(var_0) {
    var_1 = "tag_aim_pivot";
  }

  if(isDefined(self.completex1stashquest)) {
    playFXOnTag(self.completex1stashquest, self, var_1);
    return;
  }
}

function ref_13E6E() {
  self endon("stopDamageMonitor");
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    self waittill("damage", var_2, var_0, var_3, var_4, var_1, var_5, var_6);

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == run_openexfil_spawn() && !istrue(var_0.ref_1217A)) {
      continue;
    }

    if(getdvarint("x2_enable_blink_fx", 1) && !istrue(var_0.ref_11E95)) {
      thread enemy_think(1);
    }

    var_7 = var_0;

    if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
      if(isDefined(var_0.owner)) {
        var_7 = var_0.owner;
      }
    }

    var_8 = var_2;

    if(self.health < 0) {
      var_8 += self.health;
    }

    if(isPlayer(var_7)) {
      if(self.health <= 0) {
        var_7 scripts\mp\damagefeedback::updatedamagefeedback("hitturretx2break", 0, 1, "hitturretx2break", 0, 1);
      } else {
        var_7 scripts\mp\damagefeedback::updatedamagefeedback("hitturretx2", 0, 1, "hitturretx2", 0, 1);
      }

      var_9 = int(min(var_2, var_8));
      ref_13FCF(var_7, var_9);
    }

    scripts\mp\gametypes\br_gametype_x2::equipsecondarypickup(var_0, var_8);

    if(getrandompointinboundssafecircle()) {
      getc130airdropheight();
    }

    if(self.health <= 0) {
      break;
    }
  }

  ref_13E63();
  thread ref_13E85();
}

function ref_13E63() {
  if(self.turreton) {
    if(self.health > 0) {
      self notify("stopDamageMonitor");
      self.health = 0;
    }

    self.turreton = 0;
    self setmode(self.ref_11C77);
    self cleartargetentity();
    self.attackingtarget = undefined;
    self notify("disabled");
    self hide();

    if(isDefined(self.outlineid)) {
      extract_removemissionweapon();
    }

    if(self.weaponname == "armored_train_locomotive_turret_mp" || self.weaponname == "armored_train_locomotive_turret_buffed_mp") {
      self.ref_127E6 = spawn("script_model", self.origin);
      self.ref_127E6 setModel("x2_vfx_turret_loco_pop");
      self.ref_127E6.angles = self.traincar.angles;
      self.ref_127E6 linkTo(self.traincar, self.ref_13E91);
      self.ref_127E6 setscriptablepartstate("base", "loco_pop");
      return;
    }

    self.ref_127E6 = spawn("script_model", self.origin);
    self.ref_127E6 setModel("x2_vfx_turret_pop");
    self.ref_127E6.angles = self.traincar.angles;
    self.ref_127E6 linkTo(self.traincar, self.ref_13E91);
    self.ref_127E6 setscriptablepartstate("base", "pop");
    self.isvalidpos = spawn("script_model", self.origin);
    self.isvalidpos setModel("x2_reveal_assault_car_turrets_destroyed_decal");
    self.isvalidpos.angles = self.traincar.angles;
    self.isvalidpos linkTo(self.traincar, self.ref_13E91);
    return;
  }
}

function has_started_cache_defenses() {
  if(isDefined(self.isvalidpos)) {
    self.isvalidpos delete();
    self.isvalidpos = undefined;
  }

  if(isDefined(self.ref_127E6)) {
    self.ref_127E6 delete();
    self.ref_127E6 = undefined;
    return;
  }
}

function has_no_focus_fire_attackers(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  wait var_0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function ref_13E62() {
  level endon("game_ended");

  if(self.frontturret.turreton) {
    ref_13E63(self.frontturret);
  }

  if(isDefined(self.rearturret) && self.rearturret.turreton) {
    ref_13E63(self.rearturret);
  }

  self.frontturret kill();

  if(isDefined(self.rearturret)) {
    self.rearturret kill();
  }

  if(isDefined(self.frontturret) || isDefined(self.rearturret)) {
    self.frontturret hide();
    self.frontturret.helperdrone_isbeingpingedbydrone hide();

    if(isDefined(self.rearturret)) {
      self.rearturret hide();
      self.rearturret.helperdrone_isbeingpingedbydrone hide();
    }

    wait 5;
    self.frontturret.helperdrone_isbeingpingedbydrone delete();
    self.frontturret delete();

    if(isDefined(self.rearturret)) {
      self.rearturret.helperdrone_isbeingpingedbydrone delete();
      self.rearturret delete();
      return;
    }

    return;
  }
}

function getrandompointinboundssafecircle() {
  var_0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var_0 >= level.ref_14638.size) {
    return false;
  }

  var_1 = self.health / self.maxhealth;

  if(var_1 > level.ref_14638[var_0].get_request_backup_alias) {
    return false;
  }

  return true;
}

function getc130airdropheight() {
  var_0 = self.health / self.maxhealth;
  var_1 = level.ref_14638.size - 1;

  while(self.lb_wood_surf_dmg_scalar < var_1 && var_0 <= level.ref_14638[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias) {
    self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var_1));
  }

  calculatenumteamswithplayers(self.lb_wood_surf_dmg_scalar);
}

function calculatenumteamswithplayers(var_0) {
  self.lb_wood_surf_dmg_scalar = var_0;
  var_1 = level.ref_14638[self.lb_wood_surf_dmg_scalar];

  if(var_1.model != "") {
    self setModel(var_1.model);
  }

  if(var_1.statename != "") {
    self setscriptablepartstate("base", var_1.statename);
  }

  var_2 = scripts\engine\utility::ter_op(self == self.traincar.frontturret, 0, 1);
  ref_1402D(self.traincar.ref_13CC5, var_2, self.lb_wood_surf_dmg_scalar);
}

function ref_13E64() {
  var_0 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      ref_13E63(var_2.wz_tease.frontturret);
      continue;
    }

    if(var_2.wz_tease.lb_wood_surf_dmg_scalar != level.ref_14636.size - 1) {
      ref_13E63(var_2.wz_tease.frontturret);
      ref_13E63(var_2.wz_tease.rearturret);
    }
  }
}

function ref_13E65() {
  if(!self.turreton) {
    self show();
    self.helperdrone_isbeingpingedbydrone hide();
    self.helperdrone_isbeingpingedbydrone setscriptablepartstate("base", "enabled");
    self.health = self.maxhealth;
    self setmode(self.ref_11C78);
    self.turreton = 1;
    thread ref_13E80();

    if(self.weaponname != "armored_train_locomotive_turret_mp") {
      thread ref_13E6E();
      return;
    }

    return;
  }
}

function ref_13E66() {
  var_0 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      ref_13E65(var_2.wz_tease.frontturret);
      continue;
    }

    if(var_2.wz_tease.lb_wood_surf_dmg_scalar != level.ref_14636.size - 1) {
      ref_13E65(var_2.wz_tease.frontturret);
      ref_13E65(var_2.wz_tease.rearturret);
    }
  }
}

function fire_rate() {
  scripts\mp\gametypes\br_gametype_x2::f11scriptlighttoggle(0);
  var_0 = enter_numbers_start();

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    var_3 = var_0[var_7];

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == level.ref_145F1.cargo_truck_mg_create.ref_119A4) {
      var_4 = extractcountdown(var_2, var_2.wz_tease.frontturret, var_3[0].ref_13E89, var_3[0].turretmodel);
      var_2.wz_tease.frontturret.helperdrone_isbeingpingedbydrone delete();
      var_2.wz_tease.frontturret delete();
      var_2.wz_tease.frontturret = var_4;
      var_2.wz_tease.frontturret.traincar = var_2.wz_tease;
      continue;
    }

    if(isDefined(var_2.wz_tease.frontturret) && var_2.wz_tease.frontturret.turreton && var_2.wz_tease.frontturret.health > 0) {
      var_5 = extractcountdown(var_2, var_2.wz_tease.frontturret, var_3[0].ref_13E89, var_3[0].turretmodel);
      var_2.wz_tease.frontturret.helperdrone_isbeingpingedbydrone delete();
      var_2.wz_tease.frontturret delete();
      var_2.wz_tease.frontturret = var_5;
      var_2.wz_tease.frontturret.traincar = var_2.wz_tease;
      extractioncomplete(var_2.wz_tease.frontturret);
      getc130airdropheight(var_2.wz_tease.frontturret);
    }

    if(isDefined(var_2.wz_tease.rearturret) && var_2.wz_tease.rearturret.turreton && var_2.wz_tease.rearturret.health > 0) {
      var_6 = extractcountdown(var_2, var_2.wz_tease.rearturret, var_3[1].ref_13E89, var_3[1].turretmodel);
      var_2.wz_tease.rearturret.helperdrone_isbeingpingedbydrone delete();
      var_2.wz_tease.rearturret delete();
      var_2.wz_tease.rearturret = var_6;
      var_2.wz_tease.rearturret.traincar = var_2.wz_tease;
      extractioncomplete(var_2.wz_tease.rearturret);
      getc130airdropheight(var_2.wz_tease.rearturret);
    }
  }

  wait 2.5;
  level notify("buffTurrets");
}

function ref_11D2C(var_0, var_1, var_2) {
  var_3 = play_ac130_approach_scene();
  ref_132B3(var_3, var_0, var_1, var_2);
}

function ref_13E85() {
  level endon("game_ended");
  ref_13CCA();
  self.brdisabledamagestattracking = max(self.brdisabledamagestattracking - 1, 0);

  if(self.brdisabledamagestattracking == 0) {
    wait 0.2;
    caclulate_track_distance(1);
    extractioncomplete();

    if(!scripts\mp\flags::gameflag("x2_airstrike_begin")) {
      thread scripts\mp\gametypes\br_gametype_x2::extratimeincreasecount(3, 0);
      wait 9;
      scripts\mp\gametypes\br_gametype_x2::fadeoutinspectatorsofplayer(1);
      return;
    }

    return;
  }
}

function enemy_targets_headshot() {
  level endon("game_ended");
  level endon("x2_locomotive_vulnerable");
  level waittill("buffTurrets");
  scripts\mp\gametypes\br_gametype_x2::showsplash("br_x2_buffed_turrets_enabled");

  while(level.ref_145F1.ref_13CCA < 15) {
    wait 0.2;
  }

  level notify("activateMortar");
  scripts\mp\gametypes\br_gametype_x2::showsplash("br_x2_superattack_enabled");
}

function ref_13CCA() {
  level.ref_145F1.ref_13CCA++;
  level notify("train_part_destroyed");

  if(level.ref_145F1.ref_13CCA == 6) {
    thread fire_rate();
    return;
  }
}

function round_vehicle_path_logic() {
  if(level.ref_145F1.ref_13CCA >= 21) {
    var_0 = 0.5;
  } else if(level.ref_145F1.ref_13CCA >= 15) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  var_0 = getdvarfloat("x2_cluster_cooldown", var_0);
  return var_0;
}

function round_waittill_at_end_enemy_count() {
  if(level.ref_145F1.ref_13CCA >= 21) {
    var_0 = 0.5;
  } else if(level.ref_145F1.ref_13CCA >= 15) {
    var_0 = 0.3;
  } else {
    var_0 = 0;
  }

  var_0 = getdvarfloat("x2_cluster_delay", var_0);
  return var_0;
}

function exfil_smoke_vfx() {
  level endon("game_ended");
  level endon("train_destroyed");
  level endon("x2SuperInterupt");

  for(;;) {
    if(level.ref_145F1.ref_13CCA < 15) {
      wait 0.5;
      continue;
    }

    level.ref_145F1.ref_1397C = [];
    var_0 = register_vehicle_as_ambient();

    if(var_0.size == 0) {
      var_1 = level.ref_145F1.ref_13C8D[0];
      thread enter_combat_after_call();
      wait round_waittill_at_end_enemy_count();
    } else {
      foreach(var_3 in var_0) {
        thread enter_combat_after_call();
        wait round_waittill_at_end_enemy_count();
      }
    }

    waitframe();
    wait round_vehicle_path_logic();
  }
}

function enter_combat_after_call() {
  level endon("game_ended");
  level endon("train_destroyed");
  level endon("x2SuperInterupt");
  scripts\mp\gametypes\br_gametype_x2::extractionlocation();
  thread ref_1397A();
}

function ref_1397A() {
  level endon("game_ended");
  level endon("train_destroyed");
  level endon("x2SuperInterupt");
  var_0 = play_ac130_approach_scene();
  var_1 = 0;
  var_2 = 1;

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = scripts\mp\utility\player::getplayersinradius(self.origin, 12000);

  foreach(var_5 in var_3) {
    if(var_1 >= var_2) {
      break;
    }

    if(!get_bomb_case_omnvar_value_based_on_color(var_5.origin)) {
      continue;
    }

    if(unset_slow_healthregen(var_5.origin)) {
      continue;
    }

    if(!ref_13E1C(var_5.origin)) {
      continue;
    }

    ref_132B3(var_0, self.origin, var_5.origin);
    var_1++;
  }

  for(var_7 = var_1; var_7 < var_2; var_7++) {
    var_8 = getrandompointincircle(self.origin, 5000, 0.5);

    if(unset_slow_healthregen(var_8)) {
      continue;
    }

    if(!ref_13E1C(var_8)) {
      continue;
    }

    ref_132B3(var_0, self.origin, var_8);
  }

  level notify("x2SuperAttackCompleted");
}

function get_bomb_case_omnvar_value_based_on_color(var_0) {
  var_1 = gettime() - 500000;
  var_2 = scripts\mp\utility\player::getplayersinradius(var_0, 1200);

  foreach(var_4 in var_2) {
    var_5 = play_train_sequence(var_4);

    if(isDefined(var_5) && level.ref_145F1.ref_1397D[var_5].watch_for_player_in_los >= var_1) {
      return false;
    }
  }

  return true;
}

function ref_13E1C(var_0) {
  var_1 = gettime();
  var_2 = var_1 - 500000;
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0, 1200);

  foreach(var_5 in var_3) {
    var_6 = play_train_sequence(var_5);

    if(isDefined(var_6) && level.ref_145F1.ref_1397D[var_6].watch_for_player_in_los >= var_2) {
      return false;
    }
  }

  foreach(var_5 in var_3) {
    var_6 = play_train_sequence(var_5);

    if(!isDefined(var_6)) {
      var_9 = spawnStruct();
      var_9.player = var_5;
      var_6 = level.ref_145F1.ref_1397D.size;
    } else {
      var_9 = level.ref_145F1.ref_1397D[var_6];
    }

    var_9.watch_for_player_in_los = var_1 + randomint(1000);
    level.ref_145F1.ref_1397D[var_6] = var_9;
  }

  return true;
}

function play_train_sequence(var_0) {
  foreach(var_2 in level.ref_145F1.ref_1397D) {
    if(var_2.player == var_0) {
      return var_3;
    }
  }

  return undefined;
}

function unset_slow_healthregen(var_0) {
  foreach(var_2 in level.ref_145F1.ref_1397C) {
    var_3 = distance2d(var_0, var_2);

    if(var_3 <= 1200) {
      return true;
    }
  }

  return false;
}

function ref_14642(var_0) {
  if(isagent(var_0)) {
    var_1 = play_ac130_approach_scene();

    if(var_1 != var_0) {
      if(!isDefined(var_0.isactive) || !var_0.isactive) {
        return undefined;
      }

      if(!isDefined(var_0.classname)) {
        return undefined;
      }
    }
  }

  return var_0;
}

function play_ac130_approach_scene() {
  var_0 = undefined;

  if(isDefined(level.ref_13CC2)) {
    var_0 = level.ref_13CC2;
  } else {
    var_1 = scripts\engine\utility::array_reverse(level.agentarray);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(isDefined(var_3.team) && var_3.team != "axis") {
        continue;
      }

      if(!isDefined(var_3.team) && isDefined(var_3.agentteam)) {
        continue;
      }

      var_0 = var_3;
      var_0.ref_1407D = 1;

      if(!isDefined(var_0.pers["nextKillstreakID"])) {
        var_0.pers["nextKillstreakID"] = 0;
      }

      break;
    }

    level.ref_13CC2 = var_0;
  }

  return var_0;
}

function ref_132B3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = var_0 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var_0);
  }

  var_3.ref_11EAE = 1;
  var_3.ref_11F47 = 1;
  var_3.vehicle_process_node_when_at_goal = 1;
  var_3.ref_121A9 = "ks_toma_strike_missile_mp_x2";
  var_3.ref_121A8 = "ks_toma_strike_cluster_mp_x2";
  var_0.origin = var_2;
  var_0.angles = vectortoangles(var_2 - var_1);
  level.ref_145F1.ref_1397C = scripts\engine\utility::array_add(level.ref_145F1.ref_1397C, var_2);
  var_3.ref_13A81 = var_2;
  var_0 thread scripts\cp_mp\killstreaks\toma_strike::starttomastrike(5, undefined, undefined, var_3);
}

function getrandompointincircle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 <= 0) {
    return var_0;
  }

  var_7 = 0;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  var_8 = 1;

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 360;
  }

  var_9 = squared(var_1 * var_7);
  var_10 = squared(var_1 * var_8);
  var_11 = undefined;

  if(var_9 == var_10) {
    var_11 = sqrt(var_9);
  } else {
    var_11 = sqrt(randomfloatrange(var_9, var_10));
  }

  var_12 = var_5 + randomfloat(var_6 - var_5);
  var_13 = (var_11 * cos(var_12), var_11 * sin(var_12), 0);
  var_14 = var_0 + var_13;

  if(var_4) {
    var_15 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var_14 = scripts\engine\utility::drop_to_ground((var_0[0], var_0[1], 400) + var_13, undefined, undefined, undefined, var_15);
  }

  return var_14;
}

function exterior_goal_func(var_0, var_1, var_2) {
  level endon("game_ended");
  wait var_2;
  var_1 playsoundonmovingent(var_0);
}

function f11scriptlightinit() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 setsoundsubmix("br_x2_train_destroyed", 0.3);
  }
}