/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_dlc2_melee.gsc
******************************************************************/

init() {
  level._effect["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_med_trap_gib");
  level._effect["zmb_bat_long_hit_crit_blood"] = loadfx("vfx/blood/zmb_bat_long_hit_crit_blood");
  level._effect["zmb_raven_sword_barb_burst"] = loadfx("vfx/zombie/zmb_sword_barb_burst");
  level._effect["zmb_melee_drain_player"] = loadfx("vfx/gameplay/mp/zombie/zmb_melee_drain_player");
  level._effect["zmb_giestkraft_impact"] = loadfx("vfx/zombie/zmb_giestkraft_impact");

  if(!isDefined(level._id_6DF9))
    level._id_6DF9 = [];

  common_scripts\utility::flag_init("dlc2_melee_packable");
  thread bat_init();
  thread bat_hc_init();
  thread trench_knife_init();
  thread trench_knife_hc_init();
  thread axe_init();
  thread axe_hc_init();
  thread blade_init();
  thread scale_damage();
}

setup_melee_weapon_ownership(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.hasfunc = var_0;
  var_3.gainedfunc = var_1;
  var_3.lostfunc = var_2;
  thread maps\mp\_utility::_id_6F74(::watch_melee_weapon_ownership, var_3);
}

watch_melee_weapon_ownership(var_0) {
  var_1 = 0;

  for(;;) {
    var_2 = [[var_0.hasfunc]]();

    if(var_1 != var_2) {
      if(var_2)
        thread[[var_0.gainedfunc]]();
      else
        thread[[var_0.lostfunc]]();

      var_1 = var_2;
    }

    common_scripts\utility::_id_A70A("weapon_taken", "weapon_given");
  }
}

scale_damage() {
  while(!isDefined(level._id_0A50) || !isDefined(level._id_0A50["zombie_generic"]))
    waitframe();

  var_0 = 1;

  for(;;) {
    var_1 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), var_0);
    level.batdamage = max(850, var_1 * 0.25);
    level.batcolumndamage = max(450, var_1 * 0.15);
    level.bathcdamage = max(1700, var_1 * 0.7);
    level.bathcaoedamage = max(900, var_1 * 0.25);
    level.axedamage = max(850, var_1 * 0.25);
    level.axehcdamage = max(1700, var_1 * 0.7);
    level.axehcaoedamage = var_1 * 0.25;
    level.knifedamage = max(850, var_1 * 0.25);
    level.knifehcdamage = max(1700, var_1 * 0.7);
    level.bladedamage = max(3400, var_1 * 1);
    level.bladecleavedamage = max(1, var_1 * 0.7);
    level waittill("waveupdate");
    var_0 = level._id_A980;
  }
}

setup_heavy_melee_abilityinfo(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.25;

  var_4 = spawnStruct();
  var_4._id_953E = var_0;
  var_4.firedelay = var_1;
  var_4.weaponlostendon = var_2;
  var_4.firingfunction = var_3;
  return var_4;
}

run_heavy_melee_ability(var_0) {
  if(isDefined(var_0.weaponlostendon))
    self endon(var_0.weaponlostendon);

  for(;;) {
    self waittill("melee_fired", var_1);

    if(issubstr(var_1, var_0._id_953E) && self _meth_8661()) {
      if(isDefined(var_0.firedelay))
        wait(var_0.firedelay);

      thread[[var_0.firingfunction]](var_0);

      while(self _meth_8661())
        waitframe();
    }
  }
}

bayo_charge_watcher_zm(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self notify("bayoCharge_watcher_zm");
  self endon("bayoCharge_watcher_zm");

  for(;;) {
    self waittill("sprint_melee_charge_begin");
    var_3 = self getcurrentweapon();

    if(!issubstr(var_3, var_0)) {
      continue;
    }
    togglemarathonability(0);

    if(isDefined(var_1))
      self thread[[var_1]]();

    thread bayochargeendingtracking(var_2);
    thread bayochargehittracking(var_2);
  }
}

bayochargecleanup(var_0, var_1) {
  togglemarathonability(1);

  if(isDefined(var_0))
    self thread[[var_0]](var_1);

  self notify("bayoCleanup");
}

bayochargeendingtracking(var_0) {
  self endon("disconnect");
  self endon("bayoCleanup");
  var_1 = common_scripts\utility::waittill_any_return("death", "sprint_melee_charge_end");
  waittillframeend;
  thread bayochargecleanup(var_0, var_1);
}

bayochargehittracking(var_0) {
  self endon("disconnect");
  self endon("bayoCleanup");
  self waittill("sprint_melee_charge_attack");
  thread bayochargecleanup(var_0, "sprint_melee_charge_attack");
}

togglemarathonability(var_0) {
  if(!_id_056A::_id_4B7E("runperk")) {
    return;
  }
  if(var_0)
    maps\mp\_utility::giveperk("specialty_marathon");
  else
    maps\mp\_utility::_id_0735("specialty_marathon");
}

bat_init() {
  level.zombiemeleeweapon["zom_dlc2_1_zm"] = 1;
  level._id_62B3["zom_dlc2_1_zm"] = ::bat_modify_damage;
  level.meleeaoeweapons["baseballbat_aoe_zm"] = 1;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_3["hit_zombie_snd"] = "zmb_bat_melee_hit_wooden";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_bat_melee_hit_wooden";
  level._id_6DF9["default"]["zom_dlc2_1_zm"] = var_3;
  setup_melee_weapon_ownership(::has_bat, ::bat_gained, ::bat_lost);
}

has_bat() {
  var_0 = self;
  var_1 = var_0 _meth_82D5();
  return issubstr(var_1, "zom_dlc2_1_zm");
}

bat_gained() {
  thread bat_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_bat_hint)) {
    self.has_shown_bat_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_bat", self);
  }
}

bat_lost() {
  self notify("bat_lost");
}

bat_think() {
  var_0 = setup_heavy_melee_abilityinfo("zom_dlc2_1_zm", 0.45, "bat_lost", ::bat_cone);
  thread run_heavy_melee_ability(var_0);
}

bat_cone(var_0) {
  var_1 = _id_0586::zombies_hit_by_melee_cone(90, 15);
  var_1 = _sortbydistance(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    thread delayed_bat_hit(var_1[var_2], var_2);
}

delayed_bat_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  var_3 = spawnStruct();
  var_3.player = self;
  var_3._id_ABE6 = var_0.origin;
  var_3._id_4DCF = "none";
  var_3._id_60B8 = undefined;
  var_3._id_01D0 = "baseballbat_aoe_zm";
  var_3.delaysec = undefined;
  var_0 _id_0378::_id_8D74("zmb_bat_melee_hit_wooden", var_3);
  var_0 dodamage(level.batcolumndamage, self getEye(), self, self, "MOD_MELEE", "baseballbat_aoe_zm", "none");
  _playfxontag(level._effect["zmb_bat_long_hit_crit_blood"], var_0, "TAG_EYE");

  if(isDefined(var_0._id_0A4B)) {
    var_4 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_4) && common_scripts\utility::_id_562E(var_4.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "far");
  }
}

bat_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8661())
    return 0;

  return level.batdamage;
}

bat_hc_init() {
  level.zombiemeleeweapon["zom_dlc2_1hc_zm"] = 1;
  level._id_62B3["zom_dlc2_1hc_zm"] = ::bat_hc_modify_damage;
  level.meleeaoeweapons["baseballbat_hc_aoe_zm"] = 1;
  level._effect["zmb_hc_bat_aoe_fx"] = loadfx("vfx/trail/zmb_hc_bat_projectile");
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_3["hit_zombie_snd"] = "zmb_bat_melee_hit_metal";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_bat_melee_hit_metal";
  level._id_6DF9["default"]["zom_dlc2_1hc_zm"] = var_3;
  setup_melee_weapon_ownership(::has_bat_hc, ::bat_hc_gained, ::bat_hc_lost);
}

has_bat_hc() {
  var_0 = self;
  var_1 = var_0 _meth_82D5();
  return issubstr(var_1, "zom_dlc2_1hc_zm");
}

bat_hc_gained() {
  thread bat_hc_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_bat_hc_hint)) {
    self.has_shown_bat_hc_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_bat_hc", self);
  }
}

bat_hc_lost() {
  self notify("bat_hc_lost");
}

bat_hc_think() {
  setdvarifuninitialized("bat_hc_debug", 0);
  var_0 = setup_heavy_melee_abilityinfo("zom_dlc2_1hc_zm", 0.45, "bat_hc_lost", ::bat_hc_blast);
  thread run_heavy_melee_ability(var_0);
}

bat_hc_blast(var_0) {
  var_1 = self;
  var_2 = var_1 _meth_8566();
  var_3 = _anglestoaxis(var_2);
  var_4 = var_1 getEye() + var_3["forward"] * 12 + var_3["up"] * 0;
  var_5 = bulletTrace(var_4, var_4 + 500 * var_3["forward"], 0, undefined, 0, 0, 0, 0, 0, 0, 0);
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_1.angles;
  var_6 setModel("tag_origin");
  var_6._id_2DA7 = var_5["position"];
  var_6._id_2F0C = vectorNormalize(var_6._id_2DA7 - var_6.origin);
  var_6._id_9B7F = var_5["fraction"];
  var_6.player = var_1;
  var_6._id_953E = "baseballbat_hc_aoe_zm";
  var_6._id_018A = 1000;
  var_6.hit_radius = 30;
  var_6.hit_height = 30;
  var_6.already_hit = [];
  thread bat_hc_blast_think(var_6);
}

bat_hc_blast_think(var_0) {
  var_0 endon("death");
  var_1 = distance(var_0.origin, var_0._id_2DA7);
  var_2 = var_1 / var_0._id_018A;

  if(var_2 > 0)
    var_0 moveto(var_0._id_2DA7, var_2, 0, 0);

  var_3 = var_0.origin - var_0.hit_height * 0.5 * (0, 0, 1);
  var_0._id_9D65 = spawn("trigger_radius", var_3, 0, var_0.hit_radius, var_0.hit_height);
  var_0._id_9D65 enablelinkto();
  var_0._id_9D65 linkto(var_0);
  thread bat_hc_blast_watch_collision(var_0);
  _playfxontag(common_scripts\utility::_id_44F5("zmb_hc_bat_aoe_fx"), var_0, "tag_origin");
  _id_0378::_id_8D74("zmb_hc_bat_aoe_fx", var_0, "tag_origin");
  wait(var_2);
  var_0 notify("bat_hc_blast_end");
  var_0._id_9D65 delete();
  var_0 delete();
}

bat_hc_blast_watch_collision(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0._id_9D65 waittill("trigger", var_1);

    if(isDefined(var_1.team) && !_isenemyteam(var_0.player.team, var_1.team)) {
      continue;
    }
    if(isDefined(var_0.already_hit[var_1 getentitynumber()])) {
      continue;
    }
    thread bat_hc_blast_hit(var_1, var_0);
  }
}

bat_hc_blast_hit(var_0, var_1) {
  var_0 endon("death");
  var_2 = self;
  var_1.already_hit[var_0 getentitynumber()] = 1;

  if(_isagent(var_0)) {
    var_3 = spawnStruct();
    var_3.player = self;
    var_3._id_ABE6 = var_0.origin;
    var_3._id_4DCF = "none";
    var_3._id_60B8 = undefined;
    var_3._id_01D0 = "baseballbat_aoe_zm";
    var_3.delaysec = undefined;
    var_0 _id_0378::_id_8D74("zmb_bat_melee_hit_metal", var_3);
    var_0 dodamage(level.bathcaoedamage, var_2 getEye(), var_2, var_2, "MOD_MELEE", "baseballbat_hc_aoe_zm", "none");
    _playfxontag(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

    if(isDefined(var_0._id_0A4B)) {
      var_4 = _id_0547::_id_0A51(var_0._id_0A4B);

      if(isDefined(var_4) && common_scripts\utility::_id_562E(var_0.knockbyravensword)) {
        _id_0547::_id_7D1B(self, var_0, "medium");
        return;
      }

      return;
    }
  } else {}
}

bat_hc_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8661())
    return 0;

  return level.bathcdamage;
}

axe_init() {
  level.zombiemeleeweapon["zom_dlc2_3_zm"] = 1;
  level._id_62B3["zom_dlc2_3_zm"] = ::axe_modify_damage;
  level._id_A9C8["zom_dlc2_3_zm"] = ::axe_heavy_melee_fatal;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee";
  var_3["hit_zombie_snd"] = "zmb_axe_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_shovel_zm";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["no_flinch_time"] = 4;
  var_3["fatal_zombie_snd"] = "zmb_axe_melee_hit";
  level._id_6DF9["default"]["zom_dlc2_3_zm"] = var_3;
  var_3 = [];
  var_1 = (47.5, 0, 0);
  var_2 = length(var_1);
  var_3["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee";
  var_3["hit_zombie_snd"] = "zmb_axe_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_dlc2_3_charge_hit_crit_long_world";
  var_3["fatal_zombie_action"] = "death_melee_heavy_dlc2_3";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["no_flinch_time"] = 4;
  var_3["fatal_zombie_snd"] = "zmb_axe_melee_alt_hit";
  level._id_6DF9["heavy"]["zom_dlc2_3_zm"] = var_3;
  setup_melee_weapon_ownership(::has_axe, ::axe_gained, ::axe_lost);
}

has_axe() {
  var_0 = self;
  var_1 = var_0 _meth_82D5();
  return issubstr(var_1, "zom_dlc2_3_zm");
}

axe_gained() {
  thread axe_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_axe_hint)) {
    self.has_shown_axe_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_axe", self);
  }
}

axe_lost() {
  self notify("axe_lost");
}

axe_heavy_melee_fatal(var_0) {
  return common_scripts\utility::_id_562E(self._id_165B);
}

axe_think() {
  thread bayo_charge_watcher_zm("zom_dlc2_3_zm", ::axe_bayo_charge_start, ::axe_bayo_charge_result);
}

axe_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.axedamage;
}

axe_hc_init() {
  level._effect["zmb_hc_axe_aoe"] = loadfx("vfx/zombie/zmb_axe_burst");
  level.zombiemeleeweapon["zom_dlc2_3hc_zm"] = 1;
  level._id_62B3["zom_dlc2_3hc_zm"] = ::axe_hc_modify_damage;
  level._id_A9C8["zom_dlc2_3hc_zm"] = ::axe_hc_heavy_melee_fatal;
  level.meleeaoeweapons["axe_aoe_zm"] = 1;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee";
  var_3["hit_zombie_snd"] = "zmb_axe_hc_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_shovel_zm";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["no_flinch_time"] = 4;
  var_3["fatal_zombie_snd"] = "zmb_axe_hc_melee_hit";
  level._id_6DF9["default"]["zom_dlc2_3hc_zm"] = var_3;
  var_3 = [];
  var_1 = (47.5, 0, 0);
  var_2 = length(var_1);
  var_3["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee";
  var_3["hit_zombie_snd"] = "zmb_axe_hc_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_dlc2_3_charge_hit_crit_long_world";
  var_3["fatal_zombie_action"] = "death_melee_heavy_dlc2_3";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["no_flinch_time"] = 4;
  var_3["fatal_zombie_snd"] = "zmb_axe_hc_melee_alt_hit";
  level._id_6DF9["heavy"]["zom_dlc2_3hc_zm"] = var_3;
  setup_melee_weapon_ownership(::has_axe_hc, ::axe_hc_gained, ::axe_hc_lost);
}

has_axe_hc() {
  var_0 = self;
  var_1 = var_0 _meth_82D5();
  return issubstr(var_1, "zom_dlc2_3hc_zm");
}

axe_hc_gained() {
  thread axe_hc_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_axe_hc_hint)) {
    self.has_shown_axe_hc_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_axe_hc", self);
  }
}

axe_hc_lost() {
  self notify("axe_hc_lost");
}

axe_hc_heavy_melee_fatal(var_0) {
  return common_scripts\utility::_id_562E(self._id_165B);
}

axe_hc_think() {
  thread bayo_charge_watcher_zm("zom_dlc2_3hc_zm", ::axe_hc_bayo_charge_start, ::axe_hc_bayo_charge_result);
}

axe_hc_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.axehcdamage;
}

axe_bayo_charge_start() {
  self lerpfovscale(1.1, 0.2);
  self.bayonetboost = 1;
  waitframe();
  _id_0547::_id_7ACD();
}

axe_bayo_charge_result(var_0) {
  self lerpfovscale(1, 0.2);
  self.bayonetboost = 0;
  waitframe();
  _id_0547::_id_7ACD();
}

axe_hc_bayo_charge_start() {
  self lerpfovscale(1.25, 0.2);
  self.bayonetboosthc = 1;
  waitframe();
  _id_0547::_id_7ACD();
}

axe_hc_bayo_charge_result(var_0) {
  self lerpfovscale(1, 0.2);
  self.bayonetboosthc = 0;
  waitframe();
  _id_0547::_id_7ACD();

  if(var_0 == "sprint_melee_charge_end") {
    return;
  }
  if(var_0 == "sprint_melee_charge_attack")
    thread axe_hc_explosion();
  else {
    if(var_0 == "death") {
      return;
    }
    return;
  }
}

axe_hc_explosion() {
  self endon("disconnect");
  var_0 = self _meth_8566();
  var_1 = _anglestoaxis(var_0);
  var_2 = self getEye() + var_1["forward"] * 48;
  var_3 = common_scripts\utility::_id_44F5("zmb_hc_axe_aoe");
  playFX(var_3, var_2, var_1["up"], var_1["forward"]);
  var_4 = _id_0547::get_zombies_touching_sphere(var_2, 250, 1, self);
  var_4 = _sortbydistance(var_4, var_2);

  for(var_5 = 0; var_5 < var_4.size; var_5++)
    childthread axe_hc_explosion_delayed_hit(var_4[var_5], var_5, var_2);
}

axe_hc_explosion_delayed_hit(var_0, var_1, var_2) {
  var_0 endon("death");
  wait(var_1 * 0.05);
  var_0 dodamage(level.axehcaoedamage, var_2, self, self, "MOD_MELEE", "axe_aoe_zm", "none");
  _playfxontag(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "medium");
  }
}

trench_knife_init() {
  level.zombiemeleeweapon["zom_dlc2_2_zm"] = 1;
  level._id_62B3["zom_dlc2_2_zm"] = ::trench_knife_modify_damage;
  level._id_A9C8["zom_dlc2_2_zm"] = ::trench_knife_heavy_melee_fatal;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (34.222, -0.23, 0);
  var_2 = length(var_1);
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_3["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_dlc2_2";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level._id_6DF9["default"]["zom_dlc2_2_zm"] = var_3;
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_3["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_long_world";
  var_3["fatal_zombie_action"] = "death_melee_heavy_dlc2_2";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["no_flinch_time"] = 3;
  var_3["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level._id_6DF9["heavy"]["zom_dlc2_2_zm"] = var_3;
  setup_melee_weapon_ownership(::has_trench_knife, ::trench_knife_gained, ::trench_knife_lost);
}

has_trench_knife() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc2_2_zm");
}

trench_knife_gained() {
  thread trench_knife_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_knife_hint)) {
    self.has_shown_knife_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_knife", self);
  }
}

trench_knife_lost() {
  self notify("knife_lost");
}

trench_knife_think() {}

trench_knife_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.knifedamage;
}

trench_knife_heavy_melee_fatal(var_0) {
  return common_scripts\utility::_id_562E(self._id_165B) || self adsbuttonpressed();
}

trench_knife_hc_init() {
  level.zombiemeleeweapon["zom_dlc2_2hc_zm"] = 1;
  level._id_62B3["zom_dlc2_2hc_zm"] = ::trench_knife_hc_modify_damage;
  level._id_A9C8["zom_dlc2_2hc_zm"] = ::trench_knife_hc_heavy_melee_fatal;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (34.222, -0.23, 0);
  var_2 = length(var_1);
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_3["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_dlc2_2";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level._id_6DF9["default"]["zom_dlc2_2hc_zm"] = var_3;
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_2";
  var_3["hit_zombie_snd"] = "zmb_knife_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_2_zom_hit_crit_long_world";
  var_3["fatal_zombie_action"] = "death_melee_heavy_dlc2_2_hc";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["no_flinch_time"] = 3;
  var_3["fatal_zombie_snd"] = "zmb_knife_melee_hit";
  level._id_6DF9["heavy"]["zom_dlc2_2hc_zm"] = var_3;
  setup_melee_weapon_ownership(::has_trench_knife_hc, ::trench_knife_hc_gained, ::trench_knife_hc_lost);
  _id_0547::_id_7BA9(::trench_knife_hc_on_zombie_killed);
}

has_trench_knife_hc() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc2_2hc_zm");
}

trench_knife_hc_gained() {
  thread trench_knife_hc_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_knife_hc_hint)) {
    self.has_shown_knife_hc_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_knife_hc", self);
  }
}

trench_knife_hc_lost() {
  self notify("knife_hc_lost");
}

trench_knife_hc_heavy_melee_fatal(var_0) {
  return common_scripts\utility::_id_562E(self._id_165B) || self adsbuttonpressed();
}

trench_knife_hc_think() {}

trench_knife_hc_on_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1 has_trench_knife_hc()) {
    if(common_scripts\utility::_id_562E(self._id_0103))
      var_1 trench_knife_hc_spec_effect();
  }
}

trench_knife_hc_spec_effect() {
  var_0 = self;
  wait 1.38;

  if(var_0.health < var_0.maxhealth) {
    if(var_0.health + 10 <= var_0.maxhealth)
      var_0.health = var_0.health + 10;
    else
      var_0.health = var_0.maxhealth;

    var_0 notify("immediateHealthRegen");
  } else if(var_0 _id_0547::_id_73E9() < var_0 _id_0547::playergetmaxarmorcount()) {
    _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_melee_drain_player"), var_0, "J_Spine4", var_0);
    _id_0378::_id_8D74("zmb_knife_finisher_effects");
    wait 0.2;
    var_0 _id_0547::_id_73AC(1);
  }
}

trench_knife_hc_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.knifehcdamage;
}

blade_init() {
  level.zombiemeleeweapon["zom_dlc2_4_zm"] = 1;
  level._id_62B3["zom_dlc2_4_zm"] = ::blade_modify_damage;
  level.meleeaoeweapons["blade_aoe_zm"] = 1;
  level._id_2FE9["zom_dlc2_4_zm"] = 1;
  level._id_4D3D["zom_dlc2_4_zm"] = 1;
  level._id_2FE9["blade_aoe_zm"] = 1;
  level._id_4D3D["blade_aoe_zm"] = 1;
  level.zerorewardweapons["blade_aoe_zm"] = 1;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (42.816, 5.533, 0);
  var_2 = length(var_1);
  var_3["hit_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_raven_sword";
  var_3["hit_zombie_snd"] = "zmb_sword_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  var_3["fatal_zombie_action"] = "death_melee_raven_sword_zm";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_sword_melee_hit";
  level._id_6DF9["default"]["zom_dlc2_4_zm"] = var_3;
  setup_melee_weapon_ownership(::has_blade, ::blade_gained, ::blade_lost);
  _id_0547::_id_7BA9(::blade_onenemykilled);
}

has_blade() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc2_4_zm");
}

blade_gained() {
  thread blade_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_blade_hint)) {
    self.has_shown_blade_hint = 1;
    _id_0555::issprinting("dlc2_weap_hint_blade", self);
  }
}

blade_lost() {
  self notify("blade_lost");
}

blade_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8661())
    return 0;

  return level.bladedamage;
}

blade_think() {
  var_0 = setup_heavy_melee_abilityinfo("zom_dlc2_4_zm", 0.45, "blade_lost", ::blade_melee_cone);
  thread run_heavy_melee_ability(var_0);
}

blade_melee_cone(var_0) {
  var_1 = _id_0586::zombies_hit_by_melee_cone(350, 100);
  var_1 = _sortbydistance(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    thread delayed_blade_hit(var_1[var_2], var_2);

  var_3 = common_scripts\utility::_id_44F5("zmb_raven_sword_barb_burst");
  playFX(var_3, self.origin + (0, 0, 50), anglesToForward(self.angles));
  _id_0378::_id_8D74("zmb_sword_aoe", self.origin);
}

delayed_blade_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("zmb_sword_melee_hit_delayed", var_0.origin);
  var_0 dodamage(level.bladecleavedamage, self getEye(), self, self, "MOD_MELEE", "blade_aoe_zm", "none");
  _playfxontag(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbybladebarbarossa))
      _id_0547::_id_7D1B(self, var_0, "close");
  }
}

blade_onenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(var_4, "blade_aoe_zm") || _id_0547::_id_5565(var_4, "zom_dlc2_4_zm"))
    playzombiekilledbeamexplodefx();
}

playzombiekilledbeamexplodefx() {
  var_0 = self gettagorigin("J_MainRoot");

  if(!isDefined(var_0))
    var_0 = self.origin;

  playFX(common_scripts\utility::_id_44F5("zmb_blood_blast"), var_0);
}