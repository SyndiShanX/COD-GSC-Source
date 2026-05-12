/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_dlc2_melee.gsc
**********************************************************/

func_00D5() {
  level.var_611["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_med_trap_gib");
  level.var_611["zmb_bat_long_hit_crit_blood"] = loadfx("vfx/blood/zmb_bat_long_hit_crit_blood");
  level.var_611["zmb_raven_sword_barb_burst"] = loadfx("vfx/zombie/zmb_sword_barb_burst");
  level.var_611["zmb_melee_drain_player"] = loadfx("vfx/gameplay\mp\zombie/zmb_melee_drain_player");
  level.var_611["zmb_giestkraft_impact"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
  if(!isDefined(level.var_6DF9)) {
    level.var_6DF9 = [];
  }

  common_scripts\utility::func_3C87("dlc2_melee_packable");
  thread bat_init();
  thread bat_hc_init();
  thread trench_knife_init();
  thread trench_knife_hc_init();
  thread axe_init();
  thread axe_hc_init();
  thread blade_init();
  thread scale_damage();
}

setup_melee_weapon_ownership(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.hasfunc = param_00;
  var_03.gainedfunc = param_01;
  var_03.lostfunc = param_02;
  thread maps\mp\_utility::func_6F74(::watch_melee_weapon_ownership, var_03);
}

watch_melee_weapon_ownership(param_00) {
  var_01 = 0;
  for(;;) {
    var_02 = [[param_00.hasfunc]]();
    if(var_01 != var_02) {
      if(var_02) {
        thread[[param_00.gainedfunc]]();
      } else {
        thread[[param_00.lostfunc]]();
      }

      var_01 = var_02;
    }

    common_scripts\utility::knock_off_battery("weapon_taken", "weapon_given");
  }
}

scale_damage() {
  while(!isDefined(level.var_A50) || !isDefined(level.var_A50["zombie_generic"])) {
    wait 0.05;
  }

  var_00 = 1;
  for(;;) {
    var_01 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), var_00);
    level.batdamage = max(850, var_01 * 0.25);
    level.batcolumndamage = max(450, var_01 * 0.15);
    level.bathcdamage = max(1700, var_01 * 0.7);
    level.bathcaoedamage = max(900, var_01 * 0.25);
    level.axedamage = max(850, var_01 * 0.25);
    level.axehcdamage = max(1700, var_01 * 0.7);
    level.axehcaoedamage = var_01 * 0.25;
    level.knifedamage = max(850, var_01 * 0.25);
    level.knifehcdamage = max(1700, var_01 * 0.7);
    level.bladedamage = max(3400, var_01 * 1);
    level.bladecleavedamage = max(1, var_01 * 0.7);
    level waittill("waveupdate");
    var_00 = level.var_A980;
  }
}

setup_heavy_melee_abilityinfo(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 0.25;
  }

  var_04 = spawnStruct();
  var_04.var_953E = param_00;
  var_04.firedelay = param_01;
  var_04.weaponlostendon = param_02;
  var_04.firingfunction = param_03;
  return var_04;
}

run_heavy_melee_ability(param_00) {
  if(isDefined(param_00.weaponlostendon)) {
    self endon(param_00.weaponlostendon);
  }

  for(;;) {
    self waittill("melee_fired", var_01);
    if(issubstr(var_01, param_00.var_953E) && self method_8661()) {
      if(isDefined(param_00.firedelay)) {
        wait(param_00.firedelay);
      }

      thread[[param_00.firingfunction]](param_00);
      while(self method_8661()) {
        wait 0.05;
      }
    }
  }
}

bayo_charge_watcher_zm(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  self notify("bayoCharge_watcher_zm");
  self endon("bayoCharge_watcher_zm");
  for(;;) {
    self waittill("sprint_melee_charge_begin");
    var_03 = self getcurrentweapon();
    if(!issubstr(var_03, param_00)) {
      continue;
    }

    togglemarathonability(0);
    if(isDefined(param_01)) {
      self thread[[param_01]]();
    }

    thread bayochargeendingtracking(param_02);
    thread bayochargehittracking(param_02);
  }
}

bayochargecleanup(param_00, param_01) {
  togglemarathonability(1);
  if(isDefined(param_00)) {
    self thread[[param_00]](param_01);
  }

  self notify("bayoCleanup");
}

bayochargeendingtracking(param_00) {
  self endon("disconnect");
  self endon("bayoCleanup");
  var_01 = common_scripts\utility::func_A715("death", "sprint_melee_charge_end");
  waittillframeend;
  thread bayochargecleanup(param_00, var_01);
}

bayochargehittracking(param_00) {
  self endon("disconnect");
  self endon("bayoCleanup");
  self waittill("sprint_melee_charge_attack");
  thread bayochargecleanup(param_00, "sprint_melee_charge_attack");
}

togglemarathonability(param_00) {
  if(!lib_056A::func_4B7E("runperk")) {
    return;
  }

  if(param_00) {
    maps\mp\_utility::func_47A2("specialty_marathon");
    return;
  }

  maps\mp\_utility::func_735("specialty_marathon");
}

bat_init() {
  level.zombiemeleeweapon["zom_dlc2_1_zm"] = 1;
  level.var_62B3["zom_dlc2_1_zm"] = ::bat_modify_damage;
  level.meleeaoeweapons["baseballbat_aoe_zm"] = 1;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_03["hit_zombie_snd"] = "zmb_bat_melee_hit_wooden";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_bat_melee_hit_wooden";
  level.var_6DF9["default"]["zom_dlc2_1_zm"] = var_03;
  setup_melee_weapon_ownership(::has_bat, ::bat_gained, ::bat_lost);
}

has_bat() {
  var_00 = self;
  var_01 = var_00 method_82D5();
  return issubstr(var_01, "zom_dlc2_1_zm");
}

bat_gained() {
  thread bat_think();
  if(!common_scripts\utility::func_562E(self.has_shown_bat_hint)) {
    self.has_shown_bat_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_bat", self);
  }
}

bat_lost() {
  self notify("bat_lost");
}

bat_think() {
  var_00 = setup_heavy_melee_abilityinfo("zom_dlc2_1_zm", 0.45, "bat_lost", ::bat_cone);
  thread run_heavy_melee_ability(var_00);
}

bat_cone(param_00) {
  var_01 = lib_0586::zombies_hit_by_melee_cone(90, 15);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    thread delayed_bat_hit(var_01[var_02], var_02);
  }
}

delayed_bat_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  var_03 = spawnStruct();
  var_03.var_721C = self;
  var_03.var_ABE6 = param_00.var_116;
  var_03.var_4DCF = "none";
  var_03.var_60B8 = undefined;
  var_03.var_1D0 = "baseballbat_aoe_zm";
  var_03.delaysec = undefined;
  param_00 lib_0378::func_8D74("zmb_bat_melee_hit_wooden", var_03);
  param_00 dodamage(level.batcolumndamage, self getEye(), self, self, "MOD_MELEE", "baseballbat_aoe_zm", "none");
  playFXOnTag(level.var_611["zmb_bat_long_hit_crit_blood"], param_00, "TAG_EYE");
  if(isDefined(param_00.var_A4B)) {
    var_04 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_04) && common_scripts\utility::func_562E(var_04.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "far");
    }
  }
}

bat_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8661()) {
    return 0;
  }

  return level.batdamage;
}

bat_hc_init() {
  level.zombiemeleeweapon["zom_dlc2_1hc_zm"] = 1;
  level.var_62B3["zom_dlc2_1hc_zm"] = ::bat_hc_modify_damage;
  level.meleeaoeweapons["baseballbat_hc_aoe_zm"] = 1;
  level.var_611["zmb_hc_bat_aoe_fx"] = loadfx("vfx/trail/zmb_hc_bat_projectile");
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_03["hit_zombie_snd"] = "zmb_bat_melee_hit_metal";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_bat_melee_hit_metal";
  level.var_6DF9["default"]["zom_dlc2_1hc_zm"] = var_03;
  setup_melee_weapon_ownership(::has_bat_hc, ::bat_hc_gained, ::bat_hc_lost);
}

has_bat_hc() {
  var_00 = self;
  var_01 = var_00 method_82D5();
  return issubstr(var_01, "zom_dlc2_1hc_zm");
}

bat_hc_gained() {
  thread bat_hc_think();
  if(!common_scripts\utility::func_562E(self.has_shown_bat_hc_hint)) {
    self.has_shown_bat_hc_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_bat_hc", self);
  }
}

bat_hc_lost() {
  self notify("bat_hc_lost");
}

bat_hc_think() {
  setdvarifuninitialized("bat_hc_debug", 0);
  var_00 = setup_heavy_melee_abilityinfo("zom_dlc2_1hc_zm", 0.45, "bat_hc_lost", ::bat_hc_blast);
  thread run_heavy_melee_ability(var_00);
}

bat_hc_blast(param_00) {
  var_01 = self;
  var_02 = var_01 geteyeangles();
  var_03 = anglestoaxis(var_02);
  var_04 = var_01 getEye() + var_03["forward"] * 12 + var_03["up"] * 0;
  var_05 = bulletTrace(var_04, var_04 + 500 * var_03["forward"], 0, undefined, 0, 0, 0, 0, 0, 0, 0);
  var_06 = spawn("script_model", var_04);
  var_06.var_1D = var_01.var_1D;
  var_06 setModel("tag_origin");
  var_06.var_2DA7 = var_05["position"];
  var_06.var_2F0C = vectornormalize(var_06.var_2DA7 - var_06.var_116);
  var_06.var_9B7F = var_05["fraction"];
  var_06.var_721C = var_01;
  var_06.var_953E = "baseballbat_hc_aoe_zm";
  var_06.var_18A = 1000;
  var_06.hit_radius = 30;
  var_06.hit_height = 30;
  var_06.already_hit = [];
  thread bat_hc_blast_think(var_06);
}

bat_hc_blast_think(param_00) {
  param_00 endon("death");
  var_01 = distance(param_00.var_116, param_00.var_2DA7);
  var_02 = var_01 / param_00.var_18A;
  if(var_02 > 0) {
    param_00 moveto(param_00.var_2DA7, var_02, 0, 0);
  }

  var_03 = param_00.var_116 - param_00.hit_height * 0.5 * (0, 0, 1);
  param_00.var_9D65 = spawn("trigger_radius", var_03, 0, param_00.hit_radius, param_00.hit_height);
  param_00.var_9D65 enablelinkto();
  param_00.var_9D65 linkto(param_00);
  thread bat_hc_blast_watch_collision(param_00);
  playFXOnTag(common_scripts\utility::func_44F5("zmb_hc_bat_aoe_fx"), param_00, "tag_origin");
  lib_0378::func_8D74("zmb_hc_bat_aoe_fx", param_00, "tag_origin");
  wait(var_02);
  param_00 notify("bat_hc_blast_end");
  param_00.var_9D65 delete();
  param_00 delete();
}

bat_hc_blast_watch_collision(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00.var_9D65 waittill("trigger", var_01);
    if(isDefined(var_01.var_1A7) && !isenemyteam(param_00.var_721C.var_1A7, var_01.var_1A7)) {
      continue;
    }

    if(isDefined(param_00.already_hit[var_01 getentitynumber()])) {
      continue;
    }

    thread bat_hc_blast_hit(var_01, param_00);
  }
}

bat_hc_blast_hit(param_00, param_01) {
  param_00 endon("death");
  var_02 = self;
  param_01.already_hit[param_00 getentitynumber()] = 1;
  if(function_01EF(param_00)) {
    var_03 = spawnStruct();
    var_03.var_721C = self;
    var_03.var_ABE6 = param_00.var_116;
    var_03.var_4DCF = "none";
    var_03.var_60B8 = undefined;
    var_03.var_1D0 = "baseballbat_aoe_zm";
    var_03.delaysec = undefined;
    param_00 lib_0378::func_8D74("zmb_bat_melee_hit_metal", var_03);
    param_00 dodamage(level.bathcaoedamage, var_02 getEye(), var_02, var_02, "MOD_MELEE", "baseballbat_hc_aoe_zm", "none");
    playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
    if(isDefined(param_00.var_A4B)) {
      var_04 = lib_0547::func_A51(param_00.var_A4B);
      if(isDefined(var_04) && common_scripts\utility::func_562E(param_00.knockbyravensword)) {
        lib_0547::func_7D1B(self, param_00, "medium");
        return;
      }

      return;
    }
  }
}

bat_hc_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8661()) {
    return 0;
  }

  return level.bathcdamage;
}

axe_init() {
  level.zombiemeleeweapon["zom_dlc2_3_zm"] = 1;
  level.var_62B3["zom_dlc2_3_zm"] = ::axe_modify_damage;
  level.var_A9C8["zom_dlc2_3_zm"] = ::axe_heavy_melee_fatal;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee";
  var_03["hit_zombie_snd"] = "zmb_axe_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_shovel_zm";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["no_flinch_time"] = 4;
  var_03["fatal_zombie_snd"] = "zmb_axe_melee_hit";
  level.var_6DF9["default"]["zom_dlc2_3_zm"] = var_03;
  var_03 = [];
  var_01 = (47.5, 0, 0);
  var_02 = length(var_01);
  var_03["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee";
  var_03["hit_zombie_snd"] = "zmb_axe_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_dlc2_3_charge_hit_crit_long_world";
  var_03["fatal_zombie_action"] = "death_melee_heavy_dlc2_3";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["no_flinch_time"] = 4;
  var_03["fatal_zombie_snd"] = "zmb_axe_melee_alt_hit";
  level.var_6DF9["heavy"]["zom_dlc2_3_zm"] = var_03;
  setup_melee_weapon_ownership(::has_axe, ::axe_gained, ::axe_lost);
}

has_axe() {
  var_00 = self;
  var_01 = var_00 method_82D5();
  return issubstr(var_01, "zom_dlc2_3_zm");
}

axe_gained() {
  thread axe_think();
  if(!common_scripts\utility::func_562E(self.has_shown_axe_hint)) {
    self.has_shown_axe_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_axe", self);
  }
}

axe_lost() {
  self notify("axe_lost");
}

axe_heavy_melee_fatal(param_00) {
  return common_scripts\utility::func_562E(self.var_165B);
}

axe_think() {
  thread bayo_charge_watcher_zm("zom_dlc2_3_zm", ::axe_bayo_charge_start, ::axe_bayo_charge_result);
}

axe_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.axedamage;
}

axe_hc_init() {
  level.var_611["zmb_hc_axe_aoe"] = loadfx("vfx/zombie/zmb_axe_burst");
  level.zombiemeleeweapon["zom_dlc2_3hc_zm"] = 1;
  level.var_62B3["zom_dlc2_3hc_zm"] = ::axe_hc_modify_damage;
  level.var_A9C8["zom_dlc2_3hc_zm"] = ::axe_hc_heavy_melee_fatal;
  level.meleeaoeweapons["axe_aoe_zm"] = 1;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee";
  var_03["hit_zombie_snd"] = "zmb_axe_hc_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_shovel_zm";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["no_flinch_time"] = 4;
  var_03["fatal_zombie_snd"] = "zmb_axe_hc_melee_hit";
  level.var_6DF9["default"]["zom_dlc2_3hc_zm"] = var_03;
  var_03 = [];
  var_01 = (47.5, 0, 0);
  var_02 = length(var_01);
  var_03["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee";
  var_03["hit_zombie_snd"] = "zmb_axe_hc_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_dlc2_3_charge_hit_crit_long_world";
  var_03["fatal_zombie_action"] = "death_melee_heavy_dlc2_3";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["no_flinch_time"] = 4;
  var_03["fatal_zombie_snd"] = "zmb_axe_hc_melee_alt_hit";
  level.var_6DF9["heavy"]["zom_dlc2_3hc_zm"] = var_03;
  setup_melee_weapon_ownership(::has_axe_hc, ::axe_hc_gained, ::axe_hc_lost);
}

has_axe_hc() {
  var_00 = self;
  var_01 = var_00 method_82D5();
  return issubstr(var_01, "zom_dlc2_3hc_zm");
}

axe_hc_gained() {
  thread axe_hc_think();
  if(!common_scripts\utility::func_562E(self.has_shown_axe_hc_hint)) {
    self.has_shown_axe_hc_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_axe_hc", self);
  }
}

axe_hc_lost() {
  self notify("axe_hc_lost");
}

axe_hc_heavy_melee_fatal(param_00) {
  return common_scripts\utility::func_562E(self.var_165B);
}

axe_hc_think() {
  thread bayo_charge_watcher_zm("zom_dlc2_3hc_zm", ::axe_hc_bayo_charge_start, ::axe_hc_bayo_charge_result);
}

axe_hc_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.axehcdamage;
}

axe_bayo_charge_start() {
  self method_8036(1.1, 0.2);
  self.bayonetboost = 1;
  wait 0.05;
  lib_0547::func_7ACD();
}

axe_bayo_charge_result(param_00) {
  self method_8036(1, 0.2);
  self.bayonetboost = 0;
  wait 0.05;
  lib_0547::func_7ACD();
}

axe_hc_bayo_charge_start() {
  self method_8036(1.25, 0.2);
  self.bayonetboosthc = 1;
  wait 0.05;
  lib_0547::func_7ACD();
}

axe_hc_bayo_charge_result(param_00) {
  self method_8036(1, 0.2);
  self.bayonetboosthc = 0;
  wait 0.05;
  lib_0547::func_7ACD();
  if(param_00 == "sprint_melee_charge_end") {
    return;
  }

  if(param_00 == "sprint_melee_charge_attack") {
    thread axe_hc_explosion();
    return;
  }

  if(param_00 == "death") {
    return;
  }
}

axe_hc_explosion() {
  self endon("disconnect");
  var_00 = self geteyeangles();
  var_01 = anglestoaxis(var_00);
  var_02 = self getEye() + var_01["forward"] * 48;
  var_03 = common_scripts\utility::func_44F5("zmb_hc_axe_aoe");
  playFX(var_03, var_02, var_01["up"], var_01["forward"]);
  var_04 = lib_0547::get_zombies_touching_sphere(var_02, 250, 1, self);
  var_04 = function_01AC(var_04, var_02);
  for(var_05 = 0; var_05 < var_04.size; var_05++) {
    childthread axe_hc_explosion_delayed_hit(var_04[var_05], var_05, var_02);
  }
}

axe_hc_explosion_delayed_hit(param_00, param_01, param_02) {
  param_00 endon("death");
  wait(param_01 * 0.05);
  param_00 dodamage(level.axehcaoedamage, param_02, self, self, "MOD_MELEE", "axe_aoe_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "medium");
    }
  }
}

trench_knife_init() {
  level.zombiemeleeweapon["zom_dlc2_2_zm"] = 1;
  level.var_62B3["zom_dlc2_2_zm"] = ::trench_knife_modify_damage;
  level.var_A9C8["zom_dlc2_2_zm"] = ::trench_knife_heavy_melee_fatal;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (34.222, -0.23, 0);
  var_02 = length(var_01);
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_03["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_dlc2_2";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level.var_6DF9["default"]["zom_dlc2_2_zm"] = var_03;
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_03["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_long_world";
  var_03["fatal_zombie_action"] = "death_melee_heavy_dlc2_2";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["no_flinch_time"] = 3;
  var_03["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level.var_6DF9["heavy"]["zom_dlc2_2_zm"] = var_03;
  setup_melee_weapon_ownership(::has_trench_knife, ::trench_knife_gained, ::trench_knife_lost);
}

has_trench_knife() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc2_2_zm");
}

trench_knife_gained() {
  thread trench_knife_think();
  if(!common_scripts\utility::func_562E(self.has_shown_knife_hint)) {
    self.has_shown_knife_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_knife", self);
  }
}

trench_knife_lost() {
  self notify("knife_lost");
}

trench_knife_think() {}

trench_knife_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.knifedamage;
}

trench_knife_heavy_melee_fatal(param_00) {
  return common_scripts\utility::func_562E(self.var_165B) || self adsButtonPressed();
}

trench_knife_hc_init() {
  level.zombiemeleeweapon["zom_dlc2_2hc_zm"] = 1;
  level.var_62B3["zom_dlc2_2hc_zm"] = ::trench_knife_hc_modify_damage;
  level.var_A9C8["zom_dlc2_2hc_zm"] = ::trench_knife_hc_heavy_melee_fatal;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (34.222, -0.23, 0);
  var_02 = length(var_01);
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_03["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_dlc2_2";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level.var_6DF9["default"]["zom_dlc2_2hc_zm"] = var_03;
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_03["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_long_world";
  var_03["fatal_zombie_action"] = "death_melee_heavy_dlc2_2_hc";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["no_flinch_time"] = 3;
  var_03["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level.var_6DF9["heavy"]["zom_dlc2_2hc_zm"] = var_03;
  setup_melee_weapon_ownership(::has_trench_knife_hc, ::trench_knife_hc_gained, ::trench_knife_hc_lost);
  lib_0547::func_7BA9(::trench_knife_hc_on_zombie_killed);
}

has_trench_knife_hc() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc2_2hc_zm");
}

trench_knife_hc_gained() {
  thread trench_knife_hc_think();
  if(!common_scripts\utility::func_562E(self.has_shown_knife_hc_hint)) {
    self.has_shown_knife_hc_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_knife_hc", self);
  }
}

trench_knife_hc_lost() {
  self notify("knife_hc_lost");
}

trench_knife_hc_heavy_melee_fatal(param_00) {
  return common_scripts\utility::func_562E(self.var_165B) || self adsButtonPressed();
}

trench_knife_hc_think() {}

trench_knife_hc_on_zombie_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(param_01) && isPlayer(param_01) && param_01 has_trench_knife_hc()) {
    if(common_scripts\utility::func_562E(self.var_103)) {
      param_01 trench_knife_hc_spec_effect();
    }
  }
}

trench_knife_hc_spec_effect() {
  var_00 = self;
  wait(1.38);
  if(var_00.var_BC < var_00.var_FB) {
    if(var_00.var_BC + 10 <= var_00.var_FB) {
      var_00.var_BC = var_00.var_BC + 10;
    } else {
      var_00.var_BC = var_00.var_FB;
    }

    var_00 notify("immediateHealthRegen");
    return;
  }

  if(var_00 lib_0547::func_73E9() < var_00 lib_0547::playergetmaxarmorcount()) {
    playfxontagforclients(common_scripts\utility::func_44F5("zmb_melee_drain_player"), var_00, "J_Spine4", var_00);
    lib_0378::func_8D74("zmb_knife_finisher_effects");
    wait(0.2);
    var_00 lib_0547::func_73AC(1);
  }
}

trench_knife_hc_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.knifehcdamage;
}

blade_init() {
  level.zombiemeleeweapon["zom_dlc2_4_zm"] = 1;
  level.var_62B3["zom_dlc2_4_zm"] = ::blade_modify_damage;
  level.meleeaoeweapons["blade_aoe_zm"] = 1;
  level.var_2FE9["zom_dlc2_4_zm"] = 1;
  level.var_4D3D["zom_dlc2_4_zm"] = 1;
  level.var_2FE9["blade_aoe_zm"] = 1;
  level.var_4D3D["blade_aoe_zm"] = 1;
  level.zerorewardweapons["blade_aoe_zm"] = 1;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (42.816, 5.533, 0);
  var_02 = length(var_01);
  var_03["hit_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_raven_sword";
  var_03["hit_zombie_snd"] = "zmb_sword_melee_hit";
  var_03["fatal_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  var_03["fatal_zombie_action"] = "death_melee_raven_sword_zm";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_sword_melee_hit";
  level.var_6DF9["default"]["zom_dlc2_4_zm"] = var_03;
  setup_melee_weapon_ownership(::has_blade, ::blade_gained, ::blade_lost);
  lib_0547::func_7BA9(::blade_onenemykilled);
}

has_blade() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc2_4_zm");
}

blade_gained() {
  thread blade_think();
  if(!common_scripts\utility::func_562E(self.has_shown_blade_hint)) {
    self.has_shown_blade_hint = 1;
    lib_0555::func_83DD("dlc2_weap_hint_blade", self);
  }
}

blade_lost() {
  self notify("blade_lost");
}

blade_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8661()) {
    return 0;
  }

  return level.bladedamage;
}

blade_think() {
  var_00 = setup_heavy_melee_abilityinfo("zom_dlc2_4_zm", 0.45, "blade_lost", ::blade_melee_cone);
  thread run_heavy_melee_ability(var_00);
}

blade_melee_cone(param_00) {
  var_01 = lib_0586::zombies_hit_by_melee_cone(350, 100);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    thread delayed_blade_hit(var_01[var_02], var_02);
  }

  var_03 = common_scripts\utility::func_44F5("zmb_raven_sword_barb_burst");
  playFX(var_03, self.var_116 + (0, 0, 50), anglesToForward(self.var_1D));
  lib_0378::func_8D74("zmb_sword_aoe", self.var_116);
}

delayed_blade_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("zmb_sword_melee_hit_delayed", param_00.var_116);
  param_00 dodamage(level.bladecleavedamage, self getEye(), self, self, "MOD_MELEE", "blade_aoe_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbybladebarbarossa)) {
      lib_0547::func_7D1B(self, param_00, "close");
    }
  }
}

blade_onenemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(param_04, "blade_aoe_zm") || lib_0547::func_5565(param_04, "zom_dlc2_4_zm")) {
    playzombiekilledbeamexplodefx();
  }
}

playzombiekilledbeamexplodefx() {
  var_00 = self gettagorigin("J_MainRoot");
  if(!isDefined(var_00)) {
    var_00 = self.var_116;
  }

  playFX(common_scripts\utility::func_44F5("zmb_blood_blast"), var_00);
}