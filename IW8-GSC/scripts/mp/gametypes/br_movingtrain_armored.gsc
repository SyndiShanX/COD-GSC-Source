/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_movingtrain_armored.gsc
***********************************************************/

function init() {
  level.validateattacker = &ref_14642;
  level.ref_13bd1 = &helidrivabledeathall;
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &helidrivabledeath);
  totalweaponxpearned();
  teleport_trigger_to_airplane();
  teleport_to_debug_start_pos();
  tr_kiosksearchparams();
  thread ref_11b37();
  thread exfil_smoke_vfx();
  thread enemy_targets_headshot();
}

function totalweaponxpearned() {
  foreach(var1 in level.ref_145f1.ref_13c8d) {
    var1.team = run_openexfil_spawn();
    var1.wz_tease.team = run_openexfil_spawn();
  }
}

function helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }

  radiusdamage(self.origin, 256, 100, 100, play_ac130_approach_scene(), "MOD_EXPLOSIVE", "toma_proj_mp");
}

function helidrivabledeath(var0, var1, var2, var3) {
  if(var2 == "toma_strike") {
    var4 = scripts\common\utility::playersincylinder(var0, var1);

    if(!isDefined(var3)) {
      var3 = 1;
    }

    foreach(var6 in var4) {
      if(!isDefined(var6) || !scripts\mp\utility\player::isreallyalive(var6) || var6.team == self.team) {
        continue;
      }

      if(isDefined(var6.waittill_target_group_complete)) {
        var7 = scripts\engine\utility::ter_op(get_alt_weapon(var6), var3, 0);
      } else {
        var7 = var3;
      }

      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var6, var2, var7);

      if(var7) {
        var6.waittill_target_group_complete = gettime();
      }
    }

    return;
  }

  scripts\mp\gametypes\br_killstreaks::isbulletpenetration(var0, var1, var2, var3);
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
  var0 = [["", 1, "", level._effect["vfx_br_x2_locomotive_hit"]], ["x2_veh8_mil_lnd_br_train_locomotive_damaged", 1, "d1", level._effect["vfx_br_x2_locomotive_damage_hit"]], ["", 0.5, "d2", undefined], ["", 0, "d3", undefined], ["x2_veh8_mil_lnd_br_train_locomotive_dead", 0, "dead", undefined]];
  level.ref_14637 = ref_127e8(var0);
  var0 = [["", 1, "", level._effect["vfx_br_x2_assault_car_hit"], 0], ["x2_veh8_mil_lnd_br_armored_train_cart_d2", 1, "d1", level._effect["vfx_br_x2_assault_car_damage_01_hit"], 0], ["x2_veh8_mil_lnd_br_armored_train_cart_d3", 0.66, "d2", level._effect["vfx_br_x2_assault_car_damage_02_hit"], 1], ["x2_veh8_mil_lnd_br_armored_train_cart_d4", 0.33, "d3", undefined, 1], ["", 0, "explosion", undefined, 1], ["x2_veh8_mil_lnd_br_armored_train_cart_dead", 0, "dead", undefined, 1]];
  level.ref_14636 = ref_127e8(var0);
  level.ref_14635 = 0;
  var0 = [["", 1, ""], ["", 0.5, ""], ["", 0, ""]];
  level.ref_14638 = ref_127e8(var0);
}

function tr_kiosksearchparams() {
  var0 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == var0) {
      continue;
    }

    var2.wz_tease.isvalidpos = spawn("script_model", (0, 0, 0));
    var2.wz_tease.isvalidpos setModel("x2_veh8_mil_lnd_br_train_assault_decal_0" + var3);
    var2.wz_tease.isvalidpos linkTo(var2.wz_tease, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

function ref_127e8(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var4 = spawnStruct();
    var4.model = var3[0];
    var4.get_request_backup_alias = var3[1];
    var4.statename = var3[2];
    var4.completex1stashquest = var3[3];
    var4.ref_12c2b = var3[4];
    var1 = var4;
  }

  return var1;
}

function ref_11b37() {
  level endon("game_ended");
  var0 = getdvarint("scr_wztrain_carHealthPerPlayer", 1700);
  var1 = getdvarint("scr_wztrain_locmotiveCarHealthPerPlayer", 3150);
  var2 = var0 + 0;
  tr_ontimerexpired(1, var2, var1);
  scripts\mp\flags::gameflagwait("prematch_done");
  totaldata();
  tr_ontimerexpired(level.players.size, var2, var1);
  level.ref_145f1.brmodifyvehicledamage = getdvarint("scr_wztrain_ambDamagePerPlayer", 0);
  level.ref_145f1.usedcountinveh = 0;
  level.ref_14640 = [];
  fail_mission_if_killed();
}

function tr_ontimerexpired(var0, var1, var2) {
  level.ref_145f1.ref_11b56 = var0 * var1;
  level.ref_145f1.ref_11b61 = var0 * var2;
  var3 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var5 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == var3) {
      var5.wz_tease.get_remaining_bots = level.ref_145f1.ref_11b61;
      var5.wz_tease.lightsfx = 0;
    } else {
      var5.wz_tease.get_remaining_bots = level.ref_145f1.ref_11b56;
      var5.wz_tease.lightsfx = 0;
    }

    var5.wz_tease.stadium_one_death_func = 1;
  }

  var7 = level.ref_145f1.ref_13c8d.size - 1;
  level.ref_145f1.ref_11b7a = var7 * level.ref_145f1.ref_11b56;
}

function teleport_to_debug_start_pos() {
  var0 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    var2.wz_tease.lb_wood_surf_dmg_scalar = -1;

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == var0) {
      var2.wz_tease setCanDamage(1);
      thread setup_weapon_spawns();
    } else {
      var2.wz_tease setCanDamage(1);
      thread handledamage();
    }

    var2.wz_tease.ref_13cc5 = var3;
    var2.wz_tease.ref_11e95 = 1;
    var2.wz_tease.ref_1217a = 0;
  }
}

function totaldata() {
  var0 = getdvarfloat("scr_x2_max_damage_reward", 135000);
  level.ref_13735 = [30000, 45000, 60000, 75000, 100000, var0];
  level.ref_13736 = ["knife_blueprint", "paintjob_stickers_x2", "watch_x2", "emblem_2_x2", "vehicleskin_x2", "callingcards_x2"];
  level.ref_13737 = [];
  var1 = level.squaddata;

  if(scripts\mp\menus::brking_updateteamscore()) {
    var1 = [];
    GscBinSkip0(0x2e, "allies", level.squaddata["allies"]);
  }

  foreach(var7, var3 in var1) {
    level.ref_13737[var7] = [];

    foreach(var5 in var3) {
      if(var5.players.size == 0) {
        continue;
      }

      level.ref_13737[var7][var5.index] = spawnStruct();
      level.ref_13737[var7][var5.index].ref_13bee = 0;
      level.ref_13737[var7][var5.index].ref_11e72 = 0;
    }
  }
}

function initmarker() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  var0 = level.ref_145f1.ref_13c8d[0];
  var0 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_ping_icon_x2_t", "current", var0.origin + (0, 0, 300));
  objective_removeallfrommask(var0.objectiveiconid);
  thread ref_13ff4();
  thread ref_13ff3();
  thread ref_13ff5();
}

function ref_13ff5() {
  level endon("game_ended");

  for(;;) {
    var0 = 4500;

    foreach(var2 in level.players) {
      var3 = distance2d(removespecialistbonus(), var2.origin);

      if(var3 > var0 && isalive(var2)) {
        if(!isDefined(var2.ref_1337b) || var2.ref_1337b == 0) {
          ref_1335f(var2);
          var2.ref_1337b = 1;
        }

        continue;
      }

      if(istrue(var2.ref_1337b)) {
        spawn_crew(var2);
        var2.ref_1337b = 0;
      }
    }

    wait 1;
  }
}

function removespecialistbonus() {
  return (level.ref_145f1.ref_13c8d[3].origin + level.ref_145f1.ref_13c8d[4].origin) / 2;
}

function ref_13ff4() {
  level endon("game_ended");

  while(!scripts\mp\flags::gameflag("x2_train_destroyed")) {
    var0 = removespecialistbonus();
    scripts\mp\gametypes\br_quest_util::ref_11db0(var0 + (0, 0, 300));
    waitframe();
  }
}

function ref_1335f() {
  var0 = level.ref_145f1.ref_13c8d[0];
  objective_addclienttomask(var0.objectiveiconid, self);
  objective_showtoplayersinmask(var0.objectiveiconid);
}

function spawn_crew() {
  var0 = level.ref_145f1.ref_13c8d[0];
  objective_removeclientfrommask(var0.objectiveiconid, self);
  objective_showtoplayersinmask(var0.objectiveiconid);
}

function ref_13ff3() {
  level endon("game_ended");
  level scripts\engine\utility::ref_143a5("game_ended", "x2_train_destroyed");
  ref_12c0d();
}

function ref_12c0d() {
  var0 = level.ref_145f1.ref_13c8d[0];
  var0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var10, var10, var11);

    if(isDefined(var1) && isDefined(var1.team) && var1.team == run_openexfil_spawn() && !istrue(var1.ref_1217a)) {
      continue;
    }

    if(self.brdisabledamagestattracking > 0 || self.lb_wood_surf_dmg_scalar < 1) {
      continue;
    }

    if(getdvarint("x2_enable_blink_fx", 1) && !istrue(var1.ref_11e95)) {
      thread enemy_think(0);
    }

    var12 = var1;

    if(isDefined(var1.classname) && var1.classname == "script_vehicle") {
      var0 = setupmissionwidget(var1);

      if(isDefined(var1.owner)) {
        var12 = var1.owner;
      }
    }

    var13 = self.get_remaining_bots;
    self.get_remaining_bots = int(max(self.get_remaining_bots - var0, 0));

    if(var13 > 0) {
      if(isPlayer(var12)) {
        if(self.get_remaining_bots <= 0) {
          var12 scripts\mp\damagefeedback::updatedamagefeedback("hitheadx2break", 0, 0, "hitheadx2break", 0, 1);
        } else {
          var12 scripts\mp\damagefeedback::updatedamagefeedback("hitheadx2", 0, 0, "hitheadx2", 0, 1);
        }

        var14 = int(min(var0, var13));
        ref_13fcf(var12, var14);
      }

      scripts\mp\gametypes\br_gametype_x2::equipprimarypickup(var1, var0);
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var10, var10, var11);

    if(isDefined(var1) && isDefined(var1.team) && var1.team == run_openexfil_spawn() && !istrue(var1.ref_1217a)) {
      continue;
    }

    if(getdvarint("x2_enable_blink_fx", 1) && !istrue(var1.ref_11e95)) {
      thread enemy_think(0);
    }

    var12 = var1;

    if(isDefined(var1.classname) && var1.classname == "script_vehicle") {
      var0 = setupmissionwidget(var1);

      if(isDefined(var1.owner)) {
        var12 = var1.owner;
      }
    }

    var13 = self.get_remaining_bots;
    self.get_remaining_bots = int(max(self.get_remaining_bots - var0, 0));

    if(var13 > 0) {
      if(isPlayer(var12)) {
        var12 scripts\mp\damagefeedback::updatedamagefeedback("hitequip", self.get_remaining_bots == 0, 0, "standard", 0, 1);
        var14 = int(min(var0, var13));
        ref_13fcf(var12, var14);
      }

      scripts\mp\gametypes\br_gametype_x2::equipprimarypickup(var1, var0);
    }

    if(getkothlocations()) {
      getbombteam();
    }
  }
}

function setupmissionwidget(var0) {
  var1 = spawnStruct();
  var1.ent = [var0, self];
  var1.velocity = [var0 vehicle_getvelocity(), self.velocity];
  var2 = scripts\mp\gametypes\br_movingtrain::setup_hacks(var1);

  if(var2 > 0) {
    var2 = clamp(var2, 0, 3000);
  }

  return var2;
}

function ref_13ccd() {
  level endon("game_ended");
  level endon("x2_train_destroyed");
  level.ref_145f1.usedcountinveh = 1;
  var0 = getdvarint("scr_wztrain_timeBeforeSelfDestruct", 30);
  wait var0;
  var1 = level.ref_14636.size - 2;
  var2 = level.ref_14638.size - 1;
  var3 = level.ref_14637.size - 2;
  var4 = level.ref_145f1.ref_11b56 * 0.02;
  var5 = level.ref_145f1.ref_11b7c * 0.02;
  var6 = level.ref_145f1.ref_11b61 * 0.02;

  foreach(var9, var8 in level.ref_145f1.ref_13c8d) {
    var8.wz_tease.ref_1217a = 1;
  }

  for(;;) {
    foreach(var8 in level.ref_145f1.ref_13c8d) {
      var11 = var8.wz_tease;

      if(isDefined(var8.script_noteworthy) && var8.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
        if(var11.lb_wood_surf_dmg_scalar < var3) {
          var11 dodamage(var6, var11.origin, var11, var11, "MOD_EXPLOSIVE");
        } else {
          break;
        }

        continue;
      }

      if(var11.brdisabledamagestattracking > 0) {
        if(isDefined(var11.frontturret) && var11.frontturret.lb_wood_surf_dmg_scalar < var2) {
          var11.frontturret dodamage(var5, var11.frontturret.origin, var11, var11, "MOD_EXPLOSIVE");
        }

        if(isDefined(var11.rearturret) && var11.rearturret.lb_wood_surf_dmg_scalar < var2) {
          var11.rearturret dodamage(var5, var11.rearturret.origin, var11, var11, "MOD_EXPLOSIVE");
        }

        continue;
      }

      if(var11.lb_wood_surf_dmg_scalar < var1) {
        var11 dodamage(var4, var11.origin, var11, var11, "MOD_EXPLOSIVE");
      }
    }

    wait 1;
  }
}

function ref_13fcf(var0, var1) {
  var2 = level.ref_13737[var0.team][var0.squadindex].ref_13bee;
  var3 = level.ref_13735[level.ref_13735.size - 1];

  if(var2 < var3) {
    level.ref_13737[var0.team][var0.squadindex].ref_13bee = min(var2 + var1, var3);
    scripts\mp\gametypes\br_gametype_x2::fadeoutoverlay(var0);

    while(isDefined(level.ref_13735[level.ref_13737[var0.team][var0.squadindex].ref_11e72]) && level.ref_13737[var0.team][var0.squadindex].ref_13bee >= level.ref_13735[level.ref_13737[var0.team][var0.squadindex].ref_11e72]) {
      ref_13f1a(level.ref_13737[var0.team][var0.squadindex].ref_11e72, level.squaddata[var0.team][var0.squadindex].players, var0);
    }

    return;
  }
}

function ref_13f1a(var0, var1, var2) {
  foreach(var4 in var1) {
    if(!isDefined(var4)) {
      continue;
    }

    if(var4.squadindex == var2.squadindex) {
      var4 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4(level.ref_13736[var0]);
    }
  }

  level.ref_13737[var2.team][var2.squadindex].ref_11e72++;
}

function getgametypekillsperhouravg() {
  var0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var0 >= level.ref_14636.size - 1) {
    return false;
  }

  var1 = self.get_remaining_bots / level.ref_145f1.ref_11b56;

  if(var1 > level.ref_14636[var0].get_request_backup_alias) {
    return false;
  }

  return true;
}

function getblueprintforpickupweapon() {
  var0 = self.get_remaining_bots / level.ref_145f1.ref_11b56;
  var1 = level.ref_14636.size - 2;

  while(self.lb_wood_surf_dmg_scalar < var1 && var0 <= level.ref_14636[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias) {
    self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var1));
  }

  caclulate_track_distance(self.lb_wood_surf_dmg_scalar);

  if(self.lb_wood_surf_dmg_scalar == var1) {
    extract_removemissionweapon();
    thread explosion();
    return;
  }
}

function caclulate_track_distance(var0) {
  self.lb_wood_surf_dmg_scalar = var0;
  var1 = level.ref_14636[self.lb_wood_surf_dmg_scalar];

  if(var1.model != "") {
    self setModel(var1.model);
  }

  if(var1.statename != "") {
    self setscriptablepartstate("base", var1.statename);
  }

  if(isDefined(var1.completex1stashquest)) {
    self.completex1stashquest = var1.completex1stashquest;
  }

  if(isDefined(self.isvalidpos) && self.lb_wood_surf_dmg_scalar >= 4) {
    self.isvalidpos delete();
    self.isvalidpos = undefined;
  }

  lbravo_actor_keep_anim_loop();

  if(istrue(var1.ref_12c2b)) {
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

  ref_1402a(self.ref_13cc5, self.lb_wood_surf_dmg_scalar);
}

function calculateandvalidatefuelstability(var0) {
  self.lb_wood_surf_dmg_scalar = var0;
  var1 = level.ref_14637[self.lb_wood_surf_dmg_scalar];

  if(var1.model != "") {
    self setModel(var1.model);
  }

  if(var1.statename != "") {
    self setscriptablepartstate("base", var1.statename);
  }

  if(isDefined(var1.completex1stashquest)) {
    self.completex1stashquest = var1.completex1stashquest;
  }

  ref_13fed(self.lb_wood_surf_dmg_scalar);
}

function ref_119a6() {
  level endon("game_ended");
  thread exterior_goal_func("scn_x2_train_death_explo_final_rampup", self, 4);
  f11scriptlightinit();
  wait 5;
  calculateandvalidatefuelstability(level.ref_14637.size - 1);
  lastdeathheadiconforenemy();
  ref_13c9d();
}

function explosion() {
  level endon("game_ended");
  var0 = play_ac130_approach_scene();
  self.ref_1293b = 1;
  thread ref_13fd6();
  wait 5;
  self.ref_1293b = 0;
  caclulate_track_distance(level.ref_14636.size - 1);

  foreach(var2 in level.players) {
    var2 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_armored_car");
  }

  thread scripts\mp\gametypes\br_gametype_x2::extractquest_helipadid();
  lastdeathheadiconforenemy();
  level.ref_14635 += 1;
  level notify("car_destroyed");
  getrandompointinboundscircle();
  thread ref_13e62();
  wait 0.1;
  var4 = scripts\mp\utility\player::getplayersinradius(self.origin, 1500);

  foreach(var2 in var4) {
    if(onteamproximitybecameinvalidplayer(var2)) {
      var2 scripts\mp\gametypes\br_gametype_x2::extratimeincreasecountcap(4);
    }
  }

  ref_13cca();
  level.ref_145f1.instance++;
  self.mediumstatehealthratio = ref_1327c();
}

function onteamproximitybecameinvalidplayer(var0) {
  var1 = ["tag_origin", "tag_front_base", "tag_rear_base", "tag_fx03", "tag_fx01"];
  var2 = var0.origin + (0, 0, var0 getplayerviewheight());
  var3 = [self, var0];
  var4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  foreach(var6 in var1) {
    if(!self tagexists(var6)) {
      return;
    }

    var7 = self gettagorigin(var6);

    if(scripts\engine\trace::ray_trace_passed(var7, var2, var3, var4)) {
      return 1;
    }
  }

  return 0;
}

function lbravo_actor_keep_anim_loop() {
  var0 = 750;
  var1 = self.origin;
  var2 = self.angles + (-90, 0, 0);
  var3 = physics_createcontents(["physicscontents_player"]);
  var4 = physics_capsulecast(var1, var1, 200, var0 / 2, var2, var3, [], "physicsquery_all");
  var5 = [];

  foreach(var7 in var4) {
    var8 = var7["entity"];

    if(isDefined(var8)) {
      var5 = var8;

      if(onteamproximitybecameinvalidplayer(var8)) {
        var8 dodamage(250, self.origin, self, self, "MOD_EXPLOSIVE");
      }
    }
  }

  var10 = scripts\mp\utility\player::getplayersinradius(self.origin, 750, undefined, var5);

  foreach(var12 in var10) {
    if(!isDefined(var12) || !onteamproximitybecameinvalidplayer(var12)) {
      continue;
    }

    var13 = distancesquared(var12.origin, self.origin);

    if(var13 < squared(550)) {
      var14 = 90;
    } else {
      var14 = 50;
    }

    var12 dodamage(var14, self.origin, self, self, "MOD_EXPLOSIVE");
  }
}

function ref_1327c() {
  var0 = 700;
  var1 = 85;
  var2 = anglesToForward(self.angles) * 350;
  var3 = anglestoup(self.angles) * 30;
  var4 = self.origin + var2 + var3;
  var5 = spawn("trigger_rotatable_radius", var4, 0, var1, var0);
  var5.angles = self.angles + (-90, 0, 0);
  var5.burnid = scripts\mp\equipment\molotov::molotov_get_next_burning_id();
  var5.playersintrigger = [];
  var5.traincar = self;
  var5 enablelinkTo();
  var5 linkTo(self);
  thread mercywintriggered();
  thread method_for_calling_reinforcemen();
  thread hangar_juggs();
  return var5;
}

function mercywintriggered() {
  self endon("death");
  level endon("game_ended");
  level endon("train_destroyed");

  for(;;) {
    self waittill("trigger", var0);
    var1 = var0 getentitynumber();

    if(isDefined(self.playersintrigger[var1])) {
      continue;
    }

    self.playersintrigger[var1] = var0;
    mercymatchending_time(var0, var0, undefined, undefined, self.burnid);
  }
}

function method_for_calling_reinforcemen() {
  self endon("death");
  level endon("game_ended");
  level endon("train_destroyed");

  for(;;) {
    foreach(var1 in self.playersintrigger) {
      if(!isDefined(var1)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var1)) {
        continue;
      }

      if(var1 istouching(self)) {
        continue;
      }

      self.playersintrigger[var2] = undefined;
      var1 scripts\mp\equipment\molotov::molotov_stop_burning(self.burnid);
    }

    waitframe();
  }
}

function mercymatchending_time(var0, var1, var2, var3) {
  var4 = scripts\mp\equipment\molotov::molotov_get_burning_info(1);

  if(!isDefined(var3)) {
    var3 = scripts\mp\equipment\molotov::molotov_get_next_burning_id();
  }

  var5 = scripts\mp\equipment\molotov::molotov_get_burning_source(var0, var1, var2, var4, var3, 1);
  var6 = 0;

  if(var5.count <= 0) {
    var6 = 1;
  }

  var5.count++;

  if(var6) {
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
  var0 = scripts\mp\equipment\molotov::molotov_get_burning_info();
  jumpiffalse(gettime() <= var0.updatetimestamp) LOC_00000040;
  waitframe();

  for(;;) {
    var0 = scripts\mp\equipment\molotov::molotov_get_burning_info();
    var1 = undefined;

    foreach(var3 in var0.sources) {
      if(var3 scripts\mp\equipment\molotov::molotov_burning_source_is_valid()) {
        if(!isDefined(var1) || var3.id > var1) {
          var1 = var3.id;
        }

        continue;
      }

      var0.sources[var3.id] = undefined;
    }

    if(isDefined(var1)) {
      var0.timeoff = 0;
      var0.timeon += 0.05;
      var3 = var0.sources[var1];
      var5 = 15;
      var6 = undefined;
      var7 = var3.attacker.origin;

      if(isDefined(var3.inflictor)) {
        var6 = var3.inflictor;
        var7 = var3.inflictor.origin;
      }

      if(var0.timetodamage <= 0) {
        self dodamage(var5, var7, var3.attacker, var6, "MOD_EXPLOSIVE", "molotov_mp");
        var0.firstdamagedone = 1;
        var0.timetodamage = 0.25;
      } else {
        if(!var0.firstdamagedone) {
          self dodamage(var5, var7, var3.attacker, var6, "MOD_EXPLOSIVE", "molotov_mp");
          var0.firstdamagedone = 1;
        }

        var0.timetodamage -= 0.05;
      }
    } else {
      var0.timeoff += 0.05;

      if(var0.timeoff >= 0.25) {
        thread scripts\mp\equipment\molotov::molotov_clear_burning();
      }
    }

    var0.updatetimestamp = gettime();
    wait 0.05;
  }
}

function hangar_juggs() {
  level endon("game_ended");
  level waittill("train_destroyed");

  foreach(var1 in self.playersintrigger) {
    var1 scripts\mp\equipment\molotov::molotov_stop_burning(self.burnid);
  }

  self.traincar.mediumstatehealthratio = undefined;
  self delete();
}

function ref_13fd6() {
  level endon("game_ended");
  var0 = undefined;

  while(self.ref_1293b) {
    if(isDefined(var0)) {
      var0 delete();
    }

    var0 = getmaxobjectivecount(self.origin[0], self.origin[1], 1500);
    var0 setmapcirclecolorindex(0);
    var0 setmapcirclestyleindex(0);
    wait 0.5;
  }

  var0 delete();
}

function lastdeathheadiconforenemy() {
  foreach(var1 in level.ref_145f1.ref_13c8d) {
    if(var1.wz_tease == self) {
      if(isDefined(var1.num_hackers)) {
        var1.num_hackers delete();
        break;
      }
    }
  }
}

function run_module_unpause_funcs() {
  var0 = 0;

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
      continue;
    }

    var0 += var2.wz_tease.get_remaining_bots;
  }

  return var0;
}

function getkothlocations() {
  var0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var0 >= level.ref_14637.size - 1) {
    return false;
  }

  var1 = self.get_remaining_bots / level.ref_145f1.ref_11b61;

  if(var1 > level.ref_14637[var0].get_request_backup_alias) {
    return false;
  }

  return true;
}

function getbombteam() {
  var0 = self.get_remaining_bots / level.ref_145f1.ref_11b61;
  var1 = level.ref_14637.size - 2;

  while(self.lb_wood_surf_dmg_scalar < var1 && var0 <= level.ref_14637[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias) {
    self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var1));
  }

  calculateandvalidatefuelstability(self.lb_wood_surf_dmg_scalar);

  if(self.lb_wood_surf_dmg_scalar == var1) {
    thread ref_13e62();
    level notify("x2SuperInterupt");
    extract_removemissionweapon();
    thread ref_119a6();
    return;
  }
}

function register_vehicle_as_ambient() {
  var0 = [];
  var1 = level.ref_14636.size - 1;

  foreach(var3 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
      continue;
    }

    if(var3.wz_tease.lb_wood_surf_dmg_scalar < var1) {
      var0 = var3;
    }
  }

  return var0;
}

function getrandompointinboundscircle() {
  var0 = 0;
  var1 = level.ref_14636.size - 1;

  foreach(var3 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
      continue;
    }

    if(var3.wz_tease.lb_wood_surf_dmg_scalar < var1) {
      var0++;
    }
  }

  if(var0 == 0) {
    ref_119a5();
    return;
  }
}

function ref_119a5() {
  scripts\mp\flags::gameflagset("x2_locomotive_vulnerable");
  var0 = level.ref_145f1.ref_13c8d[0].wz_tease;
  extractioncomplete(var0);
  calculateandvalidatefuelstability(var0, 1);
}

function ref_13c9d() {
  scripts\mp\flags::gameflagset("x2_train_destroyed");

  foreach(var1 in level.players) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_train_destroyed");
  }

  ref_13e63(level.ref_145f1.ref_13c8d[0].wz_tease.frontturret);
}

function ref_1402a(var0, var1) {
  if(var1 == 0) {
    return;
  }

  var2 = 3;
  var3 = var0 * var2;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_br_x2_event_data", var3, var2, var1);
}

function ref_13fed(var0) {
  var1 = 3;
  var2 = 0;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_br_x2_event_data", var2, var1, var0);
}

function ref_1402d(var0, var1, var2) {
  var3 = 2;
  var4 = var3 * 2;
  var5 = (var0 - 1) * var4 + var1 * var3;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_br_x2_event_data_2", var5, var3, var2);
}

function enemy_rushdown_player() {
  ent_cleanup(level.ref_145f1.brmodifyvehicledamage * level.ref_14639);
}

function ent_cleanup(var0) {
  var1 = 7;
  var2 = var0;
  var3 = [];
  var4 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var7, var6 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == var4) {
      continue;
    }

    var3 = var6.wz_tease;
  }

  while(var1 > 0 && var2 > 0) {
    var8 = var0 / var1;
    var9 = 0;
    var1 = 0;

    foreach(var7, var11 in var3) {
      if(var8 >= var11.get_remaining_bots) {
        if(isDefined(var11.lightsfx) && !var11.lightsfx) {
          var9 += var8 - var11.get_remaining_bots;
          var11.lightsfx = 1;
        }
      } else {
        var1++;
      }

      var11 dodamage(var8, var11.origin, var11);
    }

    var2 = var9;
  }

  var4 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var11 in var3) {
    var11.lightsfx = 0;
  }
}

function entityhit() {
  var0 = spawnStruct();
  var0.streakname = "toma_strike";
  var0.owner = self;
  var0.score = 0;
  var0.shots_fired = 0;
  var0.hits = 0;
  var0.damage = 0;
  var0.kills = 0;
  var0.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var0.ref_121a8 = "ks_toma_strike_cluster_mp_x2";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var0, "toma_strike");
  }

  return var0;
}

function ents_to_clean_up(var0) {
  if(var0 == "armored_train_mg_turret_mp" || var0 == "armored_train_mg_turret_buffed_mp") {
    return level._effect["vfx_br_x2_train_turrets_gatling_hit"];
  }

  if(var0 == "armored_train_tank_turret_mp" || var0 == "armored_train_tank_turret_buffed_mp") {
    return level._effect["vfx_br_x2_train_turrets_88mm_hit"];
  }

  return undefined;
}

function entry_open(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnturret("misc_turret", var1, var5);
  var7 setModel(var6);
  var7.team = run_openexfil_spawn();
  var7.angles = var2;
  var7.turreton = 1;
  var7.name = var3;
  var7.momentum = 0;
  var7.attackingtarget = undefined;
  var7.ref_14258 = var0.name;
  var7.ref_12cb3 = 15;
  var7.ref_11c78 = "auto_nonai";
  var7.ref_11c77 = "sentry_offline";
  var7.weaponname = var5;
  var7.health = level.turretsettings[var5].health;
  var7.maxhealth = level.turretsettings[var5].maxhealth;
  var7.ref_1407d = 1;
  var7.ref_12161 = 0;
  var7.completex1stashquest = ents_to_clean_up(var5);
  var7 linkTo(var0.wz_tease, var4, (0, 0, 0), (0, 0, 0));
  var7 setturretteam(run_openexfil_spawn());
  var7 setturretmodechangewait(0);
  var7 setmode(var7.ref_11c78);
  var7 makeunusable();
  var7 maketurretinoperable();
  var7 setconvergenceheightpercent(level.turretsettings[var5].ref_132be);
  var7 setdefaultdroppitch(0);
  var7 setCanDamage(1);
  var7 setnodeploy(1);
  var7 setautorotationdelay(1);
  var7 setconvergencetime(level.turretsettings[var5].ref_14681, "yaw");
  var7 setconvergencetime(level.turretsettings[var5].ref_12381, "pitch");
  var7.damagecenter = var7.origin + (0, 0, 10);
  var7.ref_13e91 = var4;
  var7.lb_wood_surf_dmg_scalar = 0;
  var7.brking_getcenterofcircle = 1;
  var7.helperdrone_isbeingpingedbydrone = spawn("script_model", var7.origin);
  var7.helperdrone_isbeingpingedbydrone.team = var7.team;
  var7.helperdrone_isbeingpingedbydrone linkTo(var7, "tag_aim_pivot", (0, 0, 0), (0, 0, 0));
  var7.helperdrone_isbeingpingedbydrone.juggernaut_update_hint_logic = var2;
  var7.helperdrone_isbeingpingedbydrone setModel(var6);
  var7.helperdrone_isbeingpingedbydrone hide();
  thread ref_13e80();
  thread ref_13e7e();

  if(var5 != "armored_train_locomotive_turret_mp") {
    thread ref_13e6e();
  }

  level.ref_14640[level.ref_14640.size] = var7;
  return var7;
}

function extractcountdown(var0, var1, var2, var3) {
  var4 = spawnturret("misc_turret", var1.origin, var2);
  var4 setModel(var3);
  var4 linkTo(var0.wz_tease, var1.ref_13e91, (0, 0, 0), (0, 0, 0));
  var4.team = var1.team;
  var4.angles = var1.angles;
  var4.turreton = var1.turreton;
  var4.name = var1.name;
  var4.momentum = var1.momentum;
  var4.attackingtarget = var1.attackingtarget;
  var4.ref_14258 = var1.ref_14258;
  var4.ref_12cb3 = var1.ref_12cb3;
  var4.ref_11c78 = var1.ref_11c78;
  var4.ref_11c77 = var1.ref_11c77;
  var4.weaponname = var2;
  var4.health = var1.health;
  var4.maxhealth = var1.maxhealth;
  var4.ref_1407d = var1.ref_1407d;
  var4.ref_12161 = var1.ref_12161;
  var4.completex1stashquest = ents_to_clean_up(var2);
  var4 setturretteam(var1.team);
  var4 setturretmodechangewait(0);
  var4 setmode(var4.ref_11c78);
  var4 makeunusable();
  var4 maketurretinoperable();
  var4 setconvergenceheightpercent(level.turretsettings[var1.weaponname].ref_132be);
  var4 setdefaultdroppitch(0);
  var4 setCanDamage(1);
  var4 setnodeploy(1);
  var4 setautorotationdelay(1);
  var4 setconvergencetime(level.turretsettings[var1.weaponname].ref_14681, "yaw");
  var4 setconvergencetime(level.turretsettings[var1.weaponname].ref_12381, "pitch");
  var4.damagecenter = var1.damagecenter;
  var4.ref_13e91 = var1.ref_13e91;
  var4.lb_wood_surf_dmg_scalar = var1.lb_wood_surf_dmg_scalar;
  var4.helperdrone_isbeingpingedbydrone = spawn("script_model", var4.origin);
  var4.helperdrone_isbeingpingedbydrone.team = var4.team;
  var4.helperdrone_isbeingpingedbydrone linkTo(var4, "tag_aim_pivot", (0, 0, 0), (0, 0, 0));
  var4.helperdrone_isbeingpingedbydrone.juggernaut_update_hint_logic = var1.angles;
  var4.helperdrone_isbeingpingedbydrone setModel(var3);
  var4.helperdrone_isbeingpingedbydrone hide();
  thread ref_13e80(var4);
  thread ref_13e7e();

  if(var2 != "armored_train_locomotive_turret_mp" && var2 != "armored_train_locomotive_turret_buffed_mp") {
    thread ref_13e6e();
  }

  level.ref_14640[level.ref_14640.size] = var4;
  return var4;
}

function extraction_balloon_total_plunder() {
  foreach(var1 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var1.script_noteworthy) && var1.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
      continue;
    }

    extractioncomplete(var1.wz_tease.frontturret);
    extractioncomplete(var1.wz_tease.rearturret);
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
  var0 = spawnStruct();
  var0.ref_13e89 = "armored_train_mg_turret_mp";
  var0.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_gatling";
  var1 = spawnStruct();
  var1.ref_13e89 = "armored_train_tank_turret_mp";
  var1.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_88mm";
  var2 = spawnStruct();
  var2.ref_13e89 = "armored_train_mortar_turret_mp";
  var2.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_mortar";
  var3 = spawnStruct();
  var3.ref_13e89 = "armored_train_locomotive_turret_mp";
  var3.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_locomotive";
  return [[var3], [var0, var0], [var1, var1], [var0, var0], [var1, var1], [var0, var0], [var1, var1], [var0, var0]];
}

function enter_numbers_start() {
  var0 = spawnStruct();
  var0.ref_13e89 = "armored_train_mg_turret_buffed_mp";
  var0.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_gatling";
  var1 = spawnStruct();
  var1.ref_13e89 = "armored_train_tank_turret_buffed_mp";
  var1.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_88mm";
  var2 = spawnStruct();
  var2.ref_13e89 = "armored_train_locomotive_turret_buffed_mp";
  var2.turretmodel = "x2_veh8_mil_lnd_br_train_turrets_locomotive";
  return [[var2], [var0, var0], [var1, var1], [var0, var0], [var1, var1], [var0, var0], [var1, var1], [var0, var0]];
}

function fail_mission_if_killed() {
  var0 = getdvarint("scr_wztrain_turretHealthPerPlayer", 1050);
  var1 = level.players.size * var0;
  level.ref_145f1.ref_11b7c = var1;
  level.turretsettings["armored_train_mg_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_mg_turret_mp"].health = var1;
  level.turretsettings["armored_train_mg_turret_mp"].maxhealth = var1;
  level.turretsettings["armored_train_mg_turret_mp"].burst = 20;
  level.turretsettings["armored_train_mg_turret_mp"].ref_12212 = 1;
  level.turretsettings["armored_train_mg_turret_mp"].lockstrength = 3;
  level.turretsettings["armored_train_mg_turret_mp"].spinuptime = 0.1;
  level.turretsettings["armored_train_mg_turret_mp"].cooldowntime = 0.3;
  level.turretsettings["armored_train_mg_turret_mp"].ref_13a84 = 3500;
  level.turretsettings["armored_train_mg_turret_mp"].ref_132be = 0.65;
  level.turretsettings["armored_train_mg_turret_mp"].ref_14681 = 0.35;
  level.turretsettings["armored_train_mg_turret_mp"].ref_12381 = 0.35;
  level.turretsettings["armored_train_mg_turret_mp"].weaponinfo = "armored_train_mg_turret_mp";
  level.turretsettings["armored_train_mg_turret_buffed_mp"] = spawnStruct();
  level.turretsettings["armored_train_mg_turret_buffed_mp"].health = var1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].maxhealth = var1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].burst = 20;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_12212 = 0.1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].lockstrength = 3;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].spinuptime = 0.1;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].cooldowntime = 0.3;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_13a84 = 3500;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_132be = 0.65;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_14681 = 0.35;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].ref_12381 = 0.35;
  level.turretsettings["armored_train_mg_turret_buffed_mp"].weaponinfo = "armored_train_mg_turret_buffed_mp";
  level.turretsettings["armored_train_tank_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_tank_turret_mp"].health = var1;
  level.turretsettings["armored_train_tank_turret_mp"].maxhealth = var1;
  level.turretsettings["armored_train_tank_turret_mp"].burst = 1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_12212 = 3.5;
  level.turretsettings["armored_train_tank_turret_mp"].lockstrength = 3;
  level.turretsettings["armored_train_tank_turret_mp"].spinuptime = 0.4;
  level.turretsettings["armored_train_tank_turret_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_13a84 = 4500;
  level.turretsettings["armored_train_tank_turret_mp"].ref_132be = 0.1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_tank_turret_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_tank_turret_mp"].weaponinfo = "armored_train_tank_turret_mp";
  level.turretsettings["armored_train_tank_turret_buffed_mp"] = spawnStruct();
  level.turretsettings["armored_train_tank_turret_buffed_mp"].health = var1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].maxhealth = var1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].burst = 1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_12212 = 0.9;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].lockstrength = 3;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].spinuptime = 0.4;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_13a84 = 4500;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_132be = 0.1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_tank_turret_buffed_mp"].weaponinfo = "armored_train_tank_turret_buffed_mp";
  level.turretsettings["armored_train_mortar_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_mortar_turret_mp"].health = var1;
  level.turretsettings["armored_train_mortar_turret_mp"].maxhealth = var1;
  level.turretsettings["armored_train_mortar_turret_mp"].burst = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_12212 = 20;
  level.turretsettings["armored_train_mortar_turret_mp"].lockstrength = 6;
  level.turretsettings["armored_train_mortar_turret_mp"].spinuptime = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].cooldowntime = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_13a84 = 5000;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_132be = 0.2;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_mortar_turret_mp"].weaponinfo = "armored_train_mortar_turret_mp";
  level.turretsettings["armored_train_mortar_turret_mp"].streakinfo = entityhit();
  level.turretsettings["armored_train_locomotive_turret_mp"] = spawnStruct();
  level.turretsettings["armored_train_locomotive_turret_mp"].health = var1;
  level.turretsettings["armored_train_locomotive_turret_mp"].maxhealth = var1;
  level.turretsettings["armored_train_locomotive_turret_mp"].burst = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_12212 = 2;
  level.turretsettings["armored_train_locomotive_turret_mp"].lockstrength = 3;
  level.turretsettings["armored_train_locomotive_turret_mp"].spinuptime = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_13a84 = 4500;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_132be = 0.1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_locomotive_turret_mp"].weaponinfo = "armored_train_locomotive_turret_mp";
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"] = spawnStruct();
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].health = var1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].maxhealth = var1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].burst = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_12212 = 0.7;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].lockstrength = 3;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].spinuptime = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].cooldowntime = 0.1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_13a84 = 4500;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_132be = 0.1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_14681 = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].ref_12381 = 1;
  level.turretsettings["armored_train_locomotive_turret_buffed_mp"].weaponinfo = "armored_train_locomotive_turret_mp";
  var2 = entmantlingendtime();

  foreach(var4 in level.ref_145f1.ref_13c8d) {
    var5 = var2[var8];

    if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
      var4.wz_tease.frontturret = entry_open(var4, var4.wz_tease gettagorigin("tag_turret_front"), var4.angles, "front_turret", "tag_turret_front", var5[0].ref_13e89, var5[0].turretmodel);
      var4.wz_tease.frontturret.traincar = var4.wz_tease;
      var4.wz_tease.brdisabledamagestattracking = 1;
      continue;
    }

    var6 = (0, 0, 0);
    var7 = (0, 180, 0);
    var4.wz_tease.frontturret = entry_open(var4, var4.wz_tease gettagorigin("tag_turret_front"), var4.angles + var6, "front_turret", "tag_turret_front", var5[0].ref_13e89, var5[0].turretmodel);
    var4.wz_tease.rearturret = entry_open(var4, var4.wz_tease gettagorigin("tag_turret_rear"), var4.angles + var7, "rear_turret", "tag_turret_rear", var5[1].ref_13e89, var5[1].turretmodel);
    var4.wz_tease.frontturret.traincar = var4.wz_tease;
    var4.wz_tease.rearturret.traincar = var4.wz_tease;
    var4.wz_tease.brdisabledamagestattracking = 2;
  }
}

function ref_13e80(var0) {
  self endon("death");
  self endon("disabled");
  level endon("game_ended");

  if(isDefined(var0)) {
    wait var0;
  }

  var1 = level.turretsettings[self.weaponname];
  var2 = var1.cooldowntime;

  for(;;) {
    if(!istrue(self.turreton)) {
      waitframe();
      continue;
    }

    var3 = ref_13e6b();

    if(isDefined(var3)) {
      self.currenttarget = var3;
      ref_13e68(var3);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
    }

    wait 0.05;
  }
}

function ref_13e6b() {
  var0 = level.turretsettings[self.weaponname];
  var1 = var0.ref_13a84;
  var2 = var1 * var1;
  var3 = self.origin + anglesToForward(self.angles) * var1;
  var4 = scripts\common\utility::playersinsphere(var3, var1);
  var5 = undefined;
  var6 = undefined;

  foreach(var8 in var4) {
    var9 = ref_13e72(var8);

    if(!istrue(var9)) {
      continue;
    }

    var10 = self gettagorigin("tag_barrel");
    var11 = var8.origin;
    var12 = distancesquared(var10, var11);

    if(!isDefined(var5) && !isDefined(var6) || var12 < var6) {
      var5 = var8;
      var6 = var12;
    }
  }

  return var5;
}

function ref_13e72(var0) {
  var1 = 1;

  if(!isDefined(var0)) {
    var1 = 0;
  } else if(!scripts\mp\utility\player::isreallyalive(var0)) {
    var1 = 0;
  } else if(scripts\mp\utility\player::unset_relic_trex(var0)) {
    var1 = 0;
  } else if(isDefined(var0.play_disguise_vo)) {
    var1 = 0;
  } else if(!ref_13e5e(var0)) {
    var1 = 0;
  }

  return var1;
}

function ref_13e7c(var0) {
  var1 = level.turretsettings[self.weaponname];
  var2 = var1.ref_13a84;
  var3 = var2 * var2;

  if(!ref_13e72(var0)) {
    return false;
  }

  if(distancesquared(self gettagorigin("tag_barrel"), var0.origin) > var3) {
    return false;
  }

  return true;
}

function ref_13e5e(var0) {
  var1 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];
  var2 = self gettagorigin("tag_flash");
  var3 = var0.origin + (0, 0, var0 getplayerviewheight());
  var4 = vectorNormalize(var3 - var2);
  var5 = vectorNormalize(anglesToForward(self.angles));
  var6 = [self, var0];
  var6 = scripts\engine\utility::array_combine(var6, level.ref_14640);
  var7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  var8 = var0 scripts\cp_mp\utility\player_utility::isinvehicle();

  if(istrue(var8)) {
    var9 = var0 scripts\cp_mp\utility\player_utility::getvehicle();
    var6 = var9;
    var10 = var9 getlinkedchildren();

    if(isDefined(var10) && var10.size > 0) {
      var6 = scripts\engine\utility::array_combine(var6, var10);
    }
  }

  for(var11 = 0; var11 < var1.size; var11++) {
    if(scripts\engine\trace::ray_trace_passed(var2, var3, var6, var7) && vectordot(var5, var4) > cos(120)) {
      return true;
    }
  }

  return false;
}

function ref_13e71(var0) {
  var1 = self gettagorigin("tag_flash");
  var2 = var0.origin;
  var3 = vectorNormalize(var2 - var1);
  var4 = vectorNormalize(anglesToForward(self gettagangles("tag_aim_pivot")));

  if(vectordot(var4, var3) > 0.3) {
    return true;
  }

  return false;
}

function ref_13e68(var0) {
  self settargetentity(var0);
  self.attackingtarget = var0;
  ref_13e79();
  ref_13e5c(var0);
  ref_13e5d();
  self cleartargetentity();
  self.currenttarget = undefined;
}

function ref_13e79() {
  self laseron();
  var0 = level.turretsettings[self.weaponname];

  while(istrue(self.turreton) && self.momentum < var0.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function ref_13e78() {
  self laseroff();
  self.momentum = 0;
}

function ref_13e5c(var0) {
  self endon("disabled");
  var1 = level.turretsettings[self.weaponname];
  var2 = var1.burst;
  var3 = var1.ref_12212;
  var4 = var1.lockstrength;

  while(istrue(self.turreton) && ref_13e7c(var0)) {
    for(var5 = 0; var5 < var2; var5++) {
      if(istrue(self.turreton) && ref_13e7c(var0) && ref_13e71(var0)) {
        if(self.weaponname == "armored_train_mortar_turret_mp") {
          var6 = var1.streakinfo;
          ref_11d2c(self.origin, var0.origin, var6);
          self shootturret("tag_flash", var4);
        } else {
          var7 = weaponfiretime(var1.weaponinfo);
          self shootturret("tag_flash", var4);
          wait var7;
        }

        continue;
      }

      break;
    }

    wait var3;
  }
}

function ref_13e5d() {
  ref_13e78();
}

function ref_13e7e() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.helperdrone_isbeingpingedbydrone delete();
    self delete();
    return;
  }
}

function enemy_think(var0) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.ref_12161)) {
    return;
  }

  var1 = "tag_origin";

  if(var0) {
    var1 = "tag_aim_pivot";
  }

  if(isDefined(self.completex1stashquest)) {
    playFXOnTag(self.completex1stashquest, self, var1);
    return;
  }
}

function ref_13e6e() {
  self endon("stopDamageMonitor");
  level endon("game_ended");
  var0 = undefined;
  var1 = undefined;

  for(;;) {
    self waittill("damage", var2, var0, var3, var4, var1, var5, var6);

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var0) && isDefined(var0.team) && var0.team == run_openexfil_spawn() && !istrue(var0.ref_1217a)) {
      continue;
    }

    if(getdvarint("x2_enable_blink_fx", 1) && !istrue(var0.ref_11e95)) {
      thread enemy_think(1);
    }

    var7 = var0;

    if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
      if(isDefined(var0.owner)) {
        var7 = var0.owner;
      }
    }

    var8 = var2;

    if(self.health < 0) {
      var8 += self.health;
    }

    if(isPlayer(var7)) {
      if(self.health <= 0) {
        var7 scripts\mp\damagefeedback::updatedamagefeedback("hitturretx2break", 0, 1, "hitturretx2break", 0, 1);
      } else {
        var7 scripts\mp\damagefeedback::updatedamagefeedback("hitturretx2", 0, 1, "hitturretx2", 0, 1);
      }

      var9 = int(min(var2, var8));
      ref_13fcf(var7, var9);
    }

    scripts\mp\gametypes\br_gametype_x2::equipsecondarypickup(var0, var8);

    if(getrandompointinboundssafecircle()) {
      getc130airdropheight();
    }

    if(self.health <= 0) {
      break;
    }
  }

  ref_13e63();
  thread ref_13e85();
}

function ref_13e63() {
  if(self.turreton) {
    if(self.health > 0) {
      self notify("stopDamageMonitor");
      self.health = 0;
    }

    self.turreton = 0;
    self setmode(self.ref_11c77);
    self cleartargetentity();
    self.attackingtarget = undefined;
    self notify("disabled");
    self hide();

    if(isDefined(self.outlineid)) {
      extract_removemissionweapon();
    }

    if(self.weaponname == "armored_train_locomotive_turret_mp" || self.weaponname == "armored_train_locomotive_turret_buffed_mp") {
      self.ref_127e6 = spawn("script_model", self.origin);
      self.ref_127e6 setModel("x2_vfx_turret_loco_pop");
      self.ref_127e6.angles = self.traincar.angles;
      self.ref_127e6 linkTo(self.traincar, self.ref_13e91);
      self.ref_127e6 setscriptablepartstate("base", "loco_pop");
      return;
    }

    self.ref_127e6 = spawn("script_model", self.origin);
    self.ref_127e6 setModel("x2_vfx_turret_pop");
    self.ref_127e6.angles = self.traincar.angles;
    self.ref_127e6 linkTo(self.traincar, self.ref_13e91);
    self.ref_127e6 setscriptablepartstate("base", "pop");
    self.isvalidpos = spawn("script_model", self.origin);
    self.isvalidpos setModel("x2_reveal_assault_car_turrets_destroyed_decal");
    self.isvalidpos.angles = self.traincar.angles;
    self.isvalidpos linkTo(self.traincar, self.ref_13e91);
    return;
  }
}

function has_started_cache_defenses() {
  if(isDefined(self.isvalidpos)) {
    self.isvalidpos delete();
    self.isvalidpos = undefined;
  }

  if(isDefined(self.ref_127e6)) {
    self.ref_127e6 delete();
    self.ref_127e6 = undefined;
    return;
  }
}

function has_no_focus_fire_attackers(var0) {
  self endon("death");

  if(!isDefined(var0)) {
    var0 = 5;
  }

  wait var0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function ref_13e62() {
  level endon("game_ended");

  if(self.frontturret.turreton) {
    ref_13e63(self.frontturret);
  }

  if(isDefined(self.rearturret) && self.rearturret.turreton) {
    ref_13e63(self.rearturret);
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
  var0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var0 >= level.ref_14638.size) {
    return false;
  }

  var1 = self.health / self.maxhealth;

  if(var1 > level.ref_14638[var0].get_request_backup_alias) {
    return false;
  }

  return true;
}

function getc130airdropheight() {
  var0 = self.health / self.maxhealth;
  var1 = level.ref_14638.size - 1;

  while(self.lb_wood_surf_dmg_scalar < var1 && var0 <= level.ref_14638[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias) {
    self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var1));
  }

  calculatenumteamswithplayers(self.lb_wood_surf_dmg_scalar);
}

function calculatenumteamswithplayers(var0) {
  self.lb_wood_surf_dmg_scalar = var0;
  var1 = level.ref_14638[self.lb_wood_surf_dmg_scalar];

  if(var1.model != "") {
    self setModel(var1.model);
  }

  if(var1.statename != "") {
    self setscriptablepartstate("base", var1.statename);
  }

  var2 = scripts\engine\utility::ter_op(self == self.traincar.frontturret, 0, 1);
  ref_1402d(self.traincar.ref_13cc5, var2, self.lb_wood_surf_dmg_scalar);
}

function ref_13e64() {
  var0 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == var0) {
      ref_13e63(var2.wz_tease.frontturret);
      continue;
    }

    if(var2.wz_tease.lb_wood_surf_dmg_scalar != level.ref_14636.size - 1) {
      ref_13e63(var2.wz_tease.frontturret);
      ref_13e63(var2.wz_tease.rearturret);
    }
  }
}

function ref_13e65() {
  if(!self.turreton) {
    self show();
    self.helperdrone_isbeingpingedbydrone hide();
    self.helperdrone_isbeingpingedbydrone setscriptablepartstate("base", "enabled");
    self.health = self.maxhealth;
    self setmode(self.ref_11c78);
    self.turreton = 1;
    thread ref_13e80();

    if(self.weaponname != "armored_train_locomotive_turret_mp") {
      thread ref_13e6e();
      return;
    }

    return;
  }
}

function ref_13e66() {
  var0 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == var0) {
      ref_13e65(var2.wz_tease.frontturret);
      continue;
    }

    if(var2.wz_tease.lb_wood_surf_dmg_scalar != level.ref_14636.size - 1) {
      ref_13e65(var2.wz_tease.frontturret);
      ref_13e65(var2.wz_tease.rearturret);
    }
  }
}

function fire_rate() {
  scripts\mp\gametypes\br_gametype_x2::f11scriptlighttoggle(0);
  var0 = enter_numbers_start();

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    var3 = var0[var7];

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == level.ref_145f1.cargo_truck_mg_create.ref_119a4) {
      var4 = extractcountdown(var2, var2.wz_tease.frontturret, var3[0].ref_13e89, var3[0].turretmodel);
      var2.wz_tease.frontturret.helperdrone_isbeingpingedbydrone delete();
      var2.wz_tease.frontturret delete();
      var2.wz_tease.frontturret = var4;
      var2.wz_tease.frontturret.traincar = var2.wz_tease;
      continue;
    }

    if(isDefined(var2.wz_tease.frontturret) && var2.wz_tease.frontturret.turreton && var2.wz_tease.frontturret.health > 0) {
      var5 = extractcountdown(var2, var2.wz_tease.frontturret, var3[0].ref_13e89, var3[0].turretmodel);
      var2.wz_tease.frontturret.helperdrone_isbeingpingedbydrone delete();
      var2.wz_tease.frontturret delete();
      var2.wz_tease.frontturret = var5;
      var2.wz_tease.frontturret.traincar = var2.wz_tease;
      extractioncomplete(var2.wz_tease.frontturret);
      getc130airdropheight(var2.wz_tease.frontturret);
    }

    if(isDefined(var2.wz_tease.rearturret) && var2.wz_tease.rearturret.turreton && var2.wz_tease.rearturret.health > 0) {
      var6 = extractcountdown(var2, var2.wz_tease.rearturret, var3[1].ref_13e89, var3[1].turretmodel);
      var2.wz_tease.rearturret.helperdrone_isbeingpingedbydrone delete();
      var2.wz_tease.rearturret delete();
      var2.wz_tease.rearturret = var6;
      var2.wz_tease.rearturret.traincar = var2.wz_tease;
      extractioncomplete(var2.wz_tease.rearturret);
      getc130airdropheight(var2.wz_tease.rearturret);
    }
  }

  wait 2.5;
  level notify("buffTurrets");
}

function ref_11d2c(var0, var1, var2) {
  var3 = play_ac130_approach_scene();
  ref_132b3(var3, var0, var1, var2);
}

function ref_13e85() {
  level endon("game_ended");
  ref_13cca();
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

  while(level.ref_145f1.ref_13cca < 15) {
    wait 0.2;
  }

  level notify("activateMortar");
  scripts\mp\gametypes\br_gametype_x2::showsplash("br_x2_superattack_enabled");
}

function ref_13cca() {
  level.ref_145f1.ref_13cca++;
  level notify("train_part_destroyed");

  if(level.ref_145f1.ref_13cca == 6) {
    thread fire_rate();
    return;
  }
}

function round_vehicle_path_logic() {
  if(level.ref_145f1.ref_13cca >= 21) {
    var0 = 0.5;
  } else if(level.ref_145f1.ref_13cca >= 15) {
    var0 = 1;
  } else {
    var0 = 0;
  }

  var0 = getdvarfloat("x2_cluster_cooldown", var0);
  return var0;
}

function round_waittill_at_end_enemy_count() {
  if(level.ref_145f1.ref_13cca >= 21) {
    var0 = 0.5;
  } else if(level.ref_145f1.ref_13cca >= 15) {
    var0 = 0.3;
  } else {
    var0 = 0;
  }

  var0 = getdvarfloat("x2_cluster_delay", var0);
  return var0;
}

function exfil_smoke_vfx() {
  level endon("game_ended");
  level endon("train_destroyed");
  level endon("x2SuperInterupt");

  for(;;) {
    if(level.ref_145f1.ref_13cca < 15) {
      wait 0.5;
      continue;
    }

    level.ref_145f1.ref_1397c = [];
    var0 = register_vehicle_as_ambient();

    if(var0.size == 0) {
      var1 = level.ref_145f1.ref_13c8d[0];
      thread enter_combat_after_call();
      wait round_waittill_at_end_enemy_count();
    } else {
      foreach(var3 in var0) {
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
  thread ref_1397a();
}

function ref_1397a() {
  level endon("game_ended");
  level endon("train_destroyed");
  level endon("x2SuperInterupt");
  var0 = play_ac130_approach_scene();
  var1 = 0;
  var2 = 1;

  if(!isDefined(var2)) {
    return;
  }

  var3 = scripts\mp\utility\player::getplayersinradius(self.origin, 12000);

  foreach(var5 in var3) {
    if(var1 >= var2) {
      break;
    }

    if(!get_bomb_case_omnvar_value_based_on_color(var5.origin)) {
      continue;
    }

    if(unset_slow_healthregen(var5.origin)) {
      continue;
    }

    if(!ref_13e1c(var5.origin)) {
      continue;
    }

    ref_132b3(var0, self.origin, var5.origin);
    var1++;
  }

  for(var7 = var1; var7 < var2; var7++) {
    var8 = getrandompointincircle(self.origin, 5000, 0.5);

    if(unset_slow_healthregen(var8)) {
      continue;
    }

    if(!ref_13e1c(var8)) {
      continue;
    }

    ref_132b3(var0, self.origin, var8);
  }

  level notify("x2SuperAttackCompleted");
}

function get_bomb_case_omnvar_value_based_on_color(var0) {
  var1 = gettime() - 500000;
  var2 = scripts\mp\utility\player::getplayersinradius(var0, 1200);

  foreach(var4 in var2) {
    var5 = play_train_sequence(var4);

    if(isDefined(var5) && level.ref_145f1.ref_1397d[var5].watch_for_player_in_los >= var1) {
      return false;
    }
  }

  return true;
}

function ref_13e1c(var0) {
  var1 = gettime();
  var2 = var1 - 500000;
  var3 = scripts\mp\utility\player::getplayersinradius(var0, 1200);

  foreach(var5 in var3) {
    var6 = play_train_sequence(var5);

    if(isDefined(var6) && level.ref_145f1.ref_1397d[var6].watch_for_player_in_los >= var2) {
      return false;
    }
  }

  foreach(var5 in var3) {
    var6 = play_train_sequence(var5);

    if(!isDefined(var6)) {
      var9 = spawnStruct();
      var9.player = var5;
      var6 = level.ref_145f1.ref_1397d.size;
    } else {
      var9 = level.ref_145f1.ref_1397d[var6];
    }

    var9.watch_for_player_in_los = var1 + randomint(1000);
    level.ref_145f1.ref_1397d[var6] = var9;
  }

  return true;
}

function play_train_sequence(var0) {
  foreach(var2 in level.ref_145f1.ref_1397d) {
    if(var2.player == var0) {
      return var3;
    }
  }

  return undefined;
}

function unset_slow_healthregen(var0) {
  foreach(var2 in level.ref_145f1.ref_1397c) {
    var3 = distance2d(var0, var2);

    if(var3 <= 1200) {
      return true;
    }
  }

  return false;
}

function ref_14642(var0) {
  if(isagent(var0)) {
    var1 = play_ac130_approach_scene();

    if(var1 != var0) {
      if(!isDefined(var0.isactive) || !var0.isactive) {
        return undefined;
      }

      if(!isDefined(var0.classname)) {
        return undefined;
      }
    }
  }

  return var0;
}

function play_ac130_approach_scene() {
  var0 = undefined;

  if(isDefined(level.ref_13cc2)) {
    var0 = level.ref_13cc2;
  } else {
    var1 = scripts\engine\utility::array_reverse(level.agentarray);

    foreach(var3 in var1) {
      if(!isDefined(var3)) {
        continue;
      }

      if(isDefined(var3.team) && var3.team != "axis") {
        continue;
      }

      if(!isDefined(var3.team) && isDefined(var3.agentteam)) {
        continue;
      }

      var0 = var3;
      var0.ref_1407d = 1;

      if(!isDefined(var0.pers["nextKillstreakID"])) {
        var0.pers["nextKillstreakID"] = 0;
      }

      break;
    }

    level.ref_13cc2 = var0;
  }

  return var0;
}

function ref_132b3(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = var0 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var0);
  }

  var3.ref_11eae = 1;
  var3.ref_11f47 = 1;
  var3.vehicle_process_node_when_at_goal = 1;
  var3.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var3.ref_121a8 = "ks_toma_strike_cluster_mp_x2";
  var0.origin = var2;
  var0.angles = vectortoangles(var2 - var1);
  level.ref_145f1.ref_1397c = scripts\engine\utility::array_add(level.ref_145f1.ref_1397c, var2);
  var3.ref_13a81 = var2;
  var0 thread scripts\cp_mp\killstreaks\toma_strike::starttomastrike(5, undefined, undefined, var3);
}

function getrandompointincircle(var0, var1, var2, var3, var4, var5, var6) {
  if(var1 <= 0) {
    return var0;
  }

  var7 = 0;

  if(isDefined(var2)) {
    var7 = var2;
  }

  var8 = 1;

  if(isDefined(var3)) {
    var8 = var3;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var6)) {
    var6 = 360;
  }

  var9 = squared(var1 * var7);
  var10 = squared(var1 * var8);
  var11 = undefined;

  if(var9 == var10) {
    var11 = sqrt(var9);
  } else {
    var11 = sqrt(randomfloatrange(var9, var10));
  }

  var12 = var5 + randomfloat(var6 - var5);
  var13 = (var11 * cos(var12), var11 * sin(var12), 0);
  var14 = var0 + var13;

  if(var4) {
    var15 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var14 = scripts\engine\utility::drop_to_ground((var0[0], var0[1], 400) + var13, undefined, undefined, undefined, var15);
  }

  return var14;
}

function exterior_goal_func(var0, var1, var2) {
  level endon("game_ended");
  wait var2;
  var1 playsoundonmovingent(var0);
}

function f11scriptlightinit() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 setsoundsubmix("br_x2_train_destroyed", 0.3);
  }
}