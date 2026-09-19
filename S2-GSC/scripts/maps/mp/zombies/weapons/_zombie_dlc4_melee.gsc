/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_dlc4_melee.gsc
******************************************************************/

init() {
  level._effect["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_med_trap_gib");
  level._effect["zmb_bat_long_hit_crit_blood"] = loadfx("vfx/blood/zmb_bat_long_hit_crit_blood");
  level._effect["zmb_raven_sword_barb_burst"] = loadfx("vfx/zombie/zmb_sword_barb_burst");
  level._effect["zmb_melee_drain_player"] = loadfx("vfx/gameplay/mp/zombie/zmb_melee_drain_player");
  level._effect["zmb_giestkraft_impact"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
  level._effect["zmb_storm_hammer_impact"] = loadfx("vfx/zombie/rvn_weapons/zmb_storm_hammer_impact");
  level._effect["zmb_storm_hammer_lightning"] = loadfx("vfx/zombie/rvn_weapons/zmb_storm_hammer_lightning");
  level._effect["zmb_moonorb_stuck"] = loadfx("vfx/zombie/rvn_weapons/zmb_moonorb_stuck");
  level._effect["zmb_moonorb_suck"] = loadfx("vfx/zombie/rvn_weapons/zmb_moonorb_suck");
  level._effect["zmb_moonorb_charge"] = loadfx("vfx/zombie/zmb_moonorb_charge");
  level._effect["zmb_moonorb_tel_appear"] = loadfx("vfx/zombie/rvn_weapons/zmb_moonorb_tel_appear");
  level._effect["zmb_moonorb_tel_disappear"] = loadfx("vfx/zombie/rvn_weapons/zmb_moonorb_tel_disappear");
  level._effect["zmb_stormhammer_trail"] = loadfx("vfx/trail/zmb_stormhammer_trail");
  level._effect["zmb_hammer_smack"] = loadfx("vfx/blood/zmb_hammer_smack");
  level._effect["zmb_storm_hammer_knockback"] = loadfx("vfx/zombie/rvn_weapons/zmb_storm_hammer_knockback");
  level._effect["zmb_storm_hmr_zmb_stun"] = loadfx("vfx/zombie/rvn_weapons/zmb_storm_hmr_zmb_stun");
  level._effect["zmb_storm_hmr_godking_stun"] = loadfx("vfx/zombie/rvn_weapons/zmb_storm_hmr_godking_stun");
  level._effect["zmb_storm_hmr_zmb_kill"] = loadfx("vfx/zombie/rvn_weapons/zmb_storm_hmr_zmb_kill");
  level._effect["zmb_emp_HAMMER_aoe_fx"] = loadfx("vfx/trail/zmb_emp_HAMMER_projectile");
  level._effect["zmb_deathscythe_proj_exp"] = loadfx("vfx/zombie/rvn_weapons/zmb_deathscythe_proj_exp");
  level._effect["zmb_death_scythe_knockback"] = loadfx("vfx/zombie/rvn_weapons/zmb_death_scythe_knockback");
  level._effect["zmb_death_scythe_knockback_2"] = loadfx("vfx/zombie/rvn_weapons/zmb_death_scythe_knockback_2");
  level._effect["zmb_death_scythe_charged"] = loadfx("vfx/zombie/rvn_weapons/zmb_death_scythe_charged");
  level._effect["zmb_blood_shield_block"] = loadfx("vfx/zombie/rvn_weapons/zmb_blood_shield_block");
  level._effect["zmb_blood_shield_block_emp"] = loadfx("vfx/zombie/rvn_weapons/zmb_blood_shield_block_emp");
  level._effect["zmb_blood_shield_bash"] = loadfx("vfx/zombie/rvn_weapons/zmb_blood_shield_bash");
  level._effect["zmb_blood_shield_bash_emp"] = loadfx("vfx/zombie/rvn_weapons/zmb_blood_shield_bash_emp");
  level._effect["zmb_death_scythe_revive_aoe"] = loadfx("vfx/zombie/rvn_weapons/zmb_death_scythe_revive_aoe");
  level.zombiemeleeweapon["zom_dlc4_scythe_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_scythe_emp_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_hammer_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_hammer_emp_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_spike_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_spike_emp_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_shield_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_shield_emp_zm"] = 1;
  level.dlc4specialweapons = [];
  _id_054D::register_grenadier_immune_zombie_equipment("zom_moonorb_grenade_zm");
  _id_054D::register_grenadier_immune_zombie_equipment("zom_moonorb_grenade_emp_zm");
  _id_054D::register_grenadier_immune_zombie_equipment("zom_hammer_grenade_zm");
  level.ravenweaponmanager["shield"] = spawnStruct();
  level.ravenweaponmanager["shield"]._id_01D0 = "zom_dlc4_shield_zm";
  level.ravenweaponmanager["shield"].weapon_model = "npc_zom_bloodraven_shield";
  level.ravenweaponmanager["shield"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SHIELD";
  level.ravenweaponmanager["shield"].give_func = ::give_shield_weapon;
  level.ravenweaponmanager["shield"].pickup_glow = "zmb_desc_gun_glow_bloodraven";
  level.ravenweaponmanager["shield"].wep_loss_notify = "shield_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_shield_zm");
  level.ravenweaponmanager["shield_emp"] = spawnStruct();
  level.ravenweaponmanager["shield_emp"]._id_01D0 = "zom_dlc4_shield_emp_zm";
  level.ravenweaponmanager["shield_emp"].weapon_model = "npc_zom_bloodraven_shield";
  level.ravenweaponmanager["shield_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SHIELD_EMP";
  level.ravenweaponmanager["shield_emp"].give_func = ::give_shield_emp_weapon;
  level.ravenweaponmanager["shield_emp"].pickup_glow = "zmb_desc_gun_glow_bloodraven";
  level.ravenweaponmanager["shield_emp"].wep_loss_notify = "shield_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_shield_emp_zm");
  level.ravenweaponmanager["hammer"] = spawnStruct();
  level.ravenweaponmanager["hammer"]._id_01D0 = "zom_dlc4_hammer_zm";
  level.ravenweaponmanager["hammer"].weapon_model = "npc_gen_sledgehammer_zom";
  level.ravenweaponmanager["hammer"].weapon_hint = &"ZOMBIE_WEAPONDLC4_HAMMER";
  level.ravenweaponmanager["hammer"].give_func = ::give_hammer_weapon;
  level.ravenweaponmanager["hammer"].pickup_glow = "zmb_desc_gun_glow_stormraven";
  level.ravenweaponmanager["hammer"].wep_loss_notify = "hammer_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_hammer_zm");
  level.ravenweaponmanager["hammer_emp"] = spawnStruct();
  level.ravenweaponmanager["hammer_emp"]._id_01D0 = "zom_dlc4_hammer_emp_zm";
  level.ravenweaponmanager["hammer_emp"].weapon_model = "npc_gen_sledgehammer_zom_emp";
  level.ravenweaponmanager["hammer_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_HAMMER_EMP";
  level.ravenweaponmanager["hammer_emp"].give_func = ::give_hammer_emp_weapon;
  level.ravenweaponmanager["hammer_emp"].pickup_glow = "zmb_desc_gun_glow_stormraven";
  level.ravenweaponmanager["hammer_emp"].wep_loss_notify = "hammer_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_hammer_emp_zm");
  level.ravenweaponmanager["spike"] = spawnStruct();
  level.ravenweaponmanager["spike"]._id_01D0 = "zom_dlc4_spike_zm";
  level.ravenweaponmanager["spike"].weapon_model = "npc_zom_morningstar";
  level.ravenweaponmanager["spike"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SPIKE";
  level.ravenweaponmanager["spike"].give_func = ::give_spike_weapon;
  level.ravenweaponmanager["spike"].pickup_glow = "zmb_desc_gun_glow_moonraven";
  level.ravenweaponmanager["spike"].wep_loss_notify = "spike_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_spike_zm");
  level.ravenweaponmanager["spike_emp"] = spawnStruct();
  level.ravenweaponmanager["spike_emp"]._id_01D0 = "zom_dlc4_spike_emp_zm";
  level.ravenweaponmanager["spike_emp"].weapon_model = "npc_zom_morningstar_emp";
  level.ravenweaponmanager["spike_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SPIKE_EMP";
  level.ravenweaponmanager["spike_emp"].give_func = ::give_spike_emp_weapon;
  level.ravenweaponmanager["spike_emp"].pickup_glow = "zmb_desc_gun_glow_moonraven";
  level.ravenweaponmanager["spike_emp"].wep_loss_notify = "spike_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_spike_emp_zm");
  level.ravenweaponmanager["scythe"] = spawnStruct();
  level.ravenweaponmanager["scythe"]._id_01D0 = "zom_dlc4_scythe_zm";
  level.ravenweaponmanager["scythe"].weapon_model = "npc_zom_scythe";
  level.ravenweaponmanager["scythe"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SCYTHE";
  level.ravenweaponmanager["scythe"].give_func = ::give_scythe_weapon;
  level.ravenweaponmanager["scythe"].pickup_glow = "zmb_desc_gun_glow_deathraven";
  level.ravenweaponmanager["scythe"].wep_loss_notify = "scythe_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_scythe_zm");
  level.ravenweaponmanager["scythe_emp"] = spawnStruct();
  level.ravenweaponmanager["scythe_emp"]._id_01D0 = "zom_dlc4_scythe_emp_zm";
  level.ravenweaponmanager["scythe_emp"].weapon_model = "npc_zom_scythe_emp";
  level.ravenweaponmanager["scythe_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SCYTHE_EMP";
  level.ravenweaponmanager["scythe_emp"].give_func = ::give_scythe_emp_weapon;
  level.ravenweaponmanager["scythe_emp"].pickup_glow = "zmb_desc_gun_glow_deathraven";
  level.ravenweaponmanager["scythe_emp"].wep_loss_notify = "scythe_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::_id_0F6F(level.dlc4specialweapons, "zom_dlc4_scythe_emp_zm");
  level.weaponmaxammofuncs["zom_moonorb_grenade_emp_zm"] = ::raven_thrown_max_ammo_func;
  level.weaponmaxammofuncs["zom_moonorb_grenade_zm"] = ::raven_thrown_max_ammo_func;
  level.weaponmaxammofuncs["zom_hammer_grenade_zm"] = ::raven_thrown_max_ammo_func;
  level.weaponmaxammofuncs["zom_dlc4_spike_zm"] = ::spike_max_ammo_func;
  level.nobonusammoreward["zom_dlc4_spike_zm"] = 1;
  level.weaponmaxammofuncs["zom_dlc4_spike_emp_zm"] = ::spike_max_ammo_func;
  level.nobonusammoreward["zom_dlc4_spike_emp_zm"] = 1;
  _id_0547::_id_7BD0("shield_push", ::shield_push_run, ::shield_push_interrupt, 5.75, ::shield_push_end);

  if(!isDefined(level._id_6DF9))
    level._id_6DF9 = [];

  common_scripts\utility::flag_init("dlc4_melee_packable");
  thread shield_init();
  thread shield_emp_init();
  thread hammer_init();
  thread hammer_emp_init();
  thread moonorb_init();
  thread spike_init();
  thread spike_emp_init();
  thread scythe_init();
  thread scythe_emp_init();
  thread scale_damage();
  thread plinth_init();
}

raven_thrown_max_ammo_func(var_0) {
  if(isDefined(self._dlc4_weapon_manager) && isDefined(self._dlc4_weapon_manager["stored_lethal"]) && isDefined(self._dlc4_weapon_manager["stored_lethal_ammo"])) {
    var_1 = _func_1A3(self._dlc4_weapon_manager["stored_lethal"], self);
    self._dlc4_weapon_manager["stored_lethal_ammo"] = var_1;
  }

  if(isDefined(self._dlc4_weapon_manager) && isDefined(self._dlc4_weapon_manager["stored_tactical"]) && isDefined(self._dlc4_weapon_manager["stored_tactical_ammo"])) {
    var_1 = _func_1A3(self._dlc4_weapon_manager["stored_tactical"], self);
    self._dlc4_weapon_manager["stored_tactical_ammo"] = var_1;
  }

  return 1;
}

spawn_raven_weapon(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3))
    wait(var_3);

  if(_id_0547::_id_5565(var_0, "scythe") && common_scripts\utility::_id_562E(level.zmb_scythe_no_spawn)) {
    return;
  }
  var_5 = _func_2E1(var_1);
  var_6 = common_scripts\utility::_id_8FFC();
  var_6.origin = var_5;
  var_6 childthread wep_spin();
  var_6 childthread wep_bounce();
  var_7 = spawn("script_model", var_1);
  var_7.origin = var_6.origin + (0, 0, 50);

  if(isDefined(var_2))
    var_7.angles = var_2;

  var_7 linktosynchronizedparent(var_6, "tag_origin");
  var_7 setModel(level.ravenweaponmanager[var_0].weapon_model);
  var_6 set_fx(level.ravenweaponmanager[var_0].pickup_glow, "tag_origin");
  var_8 = spawnStruct();
  var_8.wep = var_7;
  thread maps\mp\_utility::_id_6F74(::pickup_override_think, var_8, "picked_up_raven_weapon");
  var_7 _id_0547::_id_AC41(level.ravenweaponmanager[var_0].weapon_hint, (0, 0, 16));
  var_9 = undefined;

  while(!isDefined(var_9))
    var_7 waittill("player_used", var_9);

  var_9 notify("picked_up_raven_weapon");
  var_7 _id_0547::_id_AC40();
  var_7 delete();
  var_6 delete();

  if(common_scripts\utility::_id_562E(var_4))
    var_9[[level.ravenweaponmanager[var_0].give_func]](undefined, var_4);
  else
    var_9[[level.ravenweaponmanager[var_0].give_func]]();

  return var_9;
}

pickup_override_think(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 3;
  var_5 = 64;

  while(!isDefined(var_0.wep._id_9D65))
    waitframe();

  while(isDefined(var_0.wep._id_9D65)) {
    if(var_1 _meth_8341() && _func_0E1(var_1.origin, var_0.wep.origin) <= var_5) {
      if(var_2 == 0) {
        var_2 = 1;
        var_3 = gettime() * 0.001;
      } else if(gettime() * 0.001 - var_3 > 3)
        var_0.wep._id_9D65 notify("trigger", self);
    } else if(var_2 == 1) {
      var_2 = 0;
      var_3 = undefined;
    }

    waitframe();
  }

  var_0 = undefined;
}

wep_disco_protect(var_0) {
  self notify("wep_disco_protect");
  self endon("wep_disco_protect");
  self endon(level.ravenweaponmanager[var_0].wep_loss_notify);
  level endon("wep_death_bossfight_protect_" + var_0);
  thread wep_disco_track(var_0);
  self waittill("disconnect");
  level notify("wep_disco_protect_" + var_0);
  take_raven_weapon(var_0, 1);
  spawn_raven_weapon(var_0, level.ravenweaponmanager[var_0].last_loc);
}

wep_disco_track(var_0) {
  self notify("wep_disco_track");
  self endon("wep_disco_track");
  self endon("disconnect");

  for(;;) {
    if(_func_2E6(self.origin))
      level.ravenweaponmanager[var_0].last_loc = self.origin;

    wait 1;
  }
}

wep_death_protect(var_0) {
  self notify("wep_death_protect");
  self endon("wep_death_protect");
  self endon(level.ravenweaponmanager[var_0].wep_loss_notify);
  level endon("wep_disco_protect_" + var_0);
  var_1 = 0;
  self waittill("death");

  if(common_scripts\utility::_id_3C77("flag_boss_fight_start") && !common_scripts\utility::_id_3C77("flag_boss_complete")) {
    var_2 = self.origin;

    if(isDefined(level.ravenweaponmanager[var_0].last_loc))
      var_2 = level.ravenweaponmanager[var_0].last_loc;

    level notify("wep_death_bossfight_protect_" + var_0);
    level thread spawn_raven_weapon(var_0, var_2);
    level.ravenweaponmanager[var_0]._id_0117 = undefined;
    return;
  }

  if(issubstr(var_0, "scythe_") && issubstr(var_0, "_emp") && !common_scripts\utility::_id_3C77(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_enter_trial")))
    var_1 = 1;

  if(issubstr(var_0, "_emp") && isDefined(self.isintrial) && !common_scripts\utility::_id_562E(self.inasneakyplace)) {
    level.ravenweaponmanager[var_0]._id_0117 = undefined;
    var_0 = _func_337(var_0, "_emp");
    level.ravenweaponmanager[var_0]._id_0117 = self;
  }

  if(common_scripts\utility::_id_562E(var_1)) {
    return;
  }
  self waittill("zombie_player_spawn_finished");

  if(_id_0547::_id_5565(level.ravenweaponmanager[var_0]._id_0117, self))
    self[[level.ravenweaponmanager[var_0].give_func]]();
}

wep_spin() {
  self endon("death");
  var_0 = 850;

  for(;;) {
    self _meth_82BA(36000, var_0);
    wait(var_0);
  }
}

wep_bounce() {
  self endon("death");
  var_0 = 4;

  for(;;) {
    self _meth_82B1(self.origin - (0, 0, 4), var_0, 0.5, 0.5);
    wait(var_0);
    self _meth_82B1(self.origin + (0, 0, 4), var_0, 0.5, 0.5);
    wait(var_0);
  }
}

take_raven_weapon(var_0, var_1) {
  if(isDefined(level.ravenweaponmanager[var_0]._id_0117) && isPlayer(level.ravenweaponmanager[var_0]._id_0117)) {
    level.ravenweaponmanager[var_0]._id_0117 _id_0586::_id_0790(level.ravenweaponmanager[var_0]._id_01D0);

    if(_id_0547::_id_5565(var_1, 1)) {
      var_2 = _id_0548::_id_454B(level.ravenweaponmanager[var_0]._id_0117, "shovel_zm");
      level.ravenweaponmanager[var_0]._id_0117 _id_0586::_id_078C(var_2);
      level.ravenweaponmanager[var_0]._id_0117 _id_0586::_id_078E(var_2);
    }
  }

  level.ravenweaponmanager[var_0]._id_0117 = undefined;
}

test_raven_weapon_owner() {
  var_0 = ["shield", "shield_emp", "hammer", "hammer_emp", "spike", "spike_emp", "scythe", "scythe_emp"];
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(_id_0547::_id_5565(level.ravenweaponmanager[var_3]._id_0117, self))
      var_1 = var_3;
  }

  return var_1;
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
    level.hammerdamage = max(1264, var_1 * 0.3);
    level.hammercleavedamage = max(1882, var_1 * 0.25);
    level.hammersweetcleavedamage = max(2710, var_1 * 0.7);
    level.hammerempdamage = max(1851, var_1 * 0.6);
    level.hammerempaoedamage = max(2710, var_1 * 0.7);
    level.hammerthrowdamage = max(450, var_1 * 0.5);
    level.hammerthrowburstdamage = max(1882, var_1 * 0.6);
    level.spikedamage = max(1530, var_1 * 0.2);
    level.spikeempdamage = max(1700, var_1 * 0.3);
    level.scythedamage = max(2385, var_1 * 0.35);
    level.scythecleavedamage = max(2385, var_1 * 0.35);
    level.scytheempdamage = max(2385, var_1 * 0.35);
    level.scytheempcleavedamage = max(2385, var_1 * 0.35);
    level.scythethrowdamage = max(2886, var_1 * 0.15);
    level.scythedeathburstdamage = max(3280, var_1 * 0.6);
    level._id_8AFE = max(850, var_1 * 0.33);
    level.shieldempdamage = max(2385, var_1 * 0.5);
    level.shieldslamdamage = max(850, var_1 * 0.4);
    level.shieldpushimpactdamage = max(100, var_1 * 0.1);
    level waittill("waveupdate");
    var_0 = level._id_A980;
  }
}

setup_melee_abilityinfo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 0.25;

  var_5 = spawnStruct();
  var_5._id_953E = var_0;
  var_5.firedelay = var_1;
  var_5.weaponlostendon = var_2;
  var_5.firingfunction = var_3;
  var_5.minduration = var_4;
  var_5.isheavymelee = 0;
  return var_5;
}

setup_heavy_melee_abilityinfo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 0.25;

  var_5 = spawnStruct();
  var_5._id_953E = var_0;
  var_5.firedelay = var_1;
  var_5.weaponlostendon = var_2;
  var_5.firingfunction = var_3;
  var_5.minduration = var_4;
  var_5.isheavymelee = 1;
  return var_5;
}

run_melee_ability(var_0) {
  if(isDefined(var_0.weaponlostendon))
    self endon(var_0.weaponlostendon);

  self endon("disconnect");

  for(;;) {
    self waittill("melee_fired", var_1);

    if(issubstr(var_1, var_0._id_953E) && self _meth_8128() && !self _meth_8661())
      melee_ability_fire(var_0);
  }
}

run_heavy_melee_ability(var_0) {
  if(isDefined(var_0.weaponlostendon))
    self endon(var_0.weaponlostendon);

  self endon("disconnect");

  for(;;) {
    self waittill("melee_fired", var_1);

    if(issubstr(var_1, var_0._id_953E) && self _meth_8661())
      melee_ability_fire(var_0);
  }
}

melee_ability_fire(var_0) {
  self endon("melee_ability_interrupt");

  if(isDefined(var_0.minduration) && isDefined(self.nextmeleeabilitytime)) {
    if(gettime() < self.nextmeleeabilitytime)
      return;
  }

  thread watch_for_melee_interrupt(var_0);

  if(isDefined(var_0.firedelay))
    wait(var_0.firedelay);

  childthread[[var_0.firingfunction]](var_0);
  wait_for_melee_ability_duration(var_0);
}

wait_for_melee_ability_duration(var_0) {
  if(isDefined(var_0.minduration)) {
    self.nextmeleeabilitytime = gettime() + var_0.minduration * 1000;
    wait(var_0.minduration);
  } else {
    while(var_0.isheavymelee && self _meth_8661() || !var_0.isheavymelee && self _meth_8128() && !self _meth_8661())
      waitframe();
  }

  self notify("melee_ability_complete");
}

watch_for_melee_interrupt(var_0) {
  self endon("melee_ability_complete");
  self endon("disconnect");
  self endon("death");
  self waittill("weapon_switch_started");
  self notify("melee_ability_interrupt");
}

bayo_charge_watcher_zm(var_0, var_1, var_2) {
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
  var_1 = common_scripts\utility::_id_A715("death", "sprint_melee_charge_end");
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

wait_for_raven_disco(var_0) {
  self endon("raven_weapon_taken");
  childthread raven_track_weapon_pos(var_0);
  self waittill("disconnect");
  level thread spawn_raven_weapon(var_0, level.ravenweaponmanager[var_0].last_valid_pos, undefined, 2);
  level.ravenweaponmanager[var_0]._id_0117 = undefined;
}

raven_track_weapon_pos(var_0) {
  var_1 = undefined;

  while(isDefined(self)) {
    var_2 = _func_082(self.origin, 12, 36, 12);
    var_3 = _func_2E6(var_2);

    if(_id_0547::_id_5565(var_3, 1))
      level.ravenweaponmanager[var_0].last_valid_pos = var_1;

    wait 2;
  }
}

raven_weapon_check_if_special_grenade(var_0) {
  var_1 = 0;

  if(_id_0547::_id_5565(var_0, "zom_hammer_grenade_zm") || _id_0547::_id_5565(var_0, "zom_moonorb_grenade_zm") || _id_0547::_id_5565(var_0, "zom_moonorb_grenade_emp_zm"))
    var_1 = 1;

  return var_1;
}

shield_init() {
  level.zombiemeleeweapon["zom_dlc4_shield_zm"] = 1;
  level._id_62B3["zom_dlc4_shield_zm"] = ::shield_modify_damage;
  level.meleeaoeweapons["shield_cleave_zm"] = 1;
  level._id_2FE9["zom_dlc4_shield_zm"] = 1;
  level._id_4D3D["zom_dlc4_shield_zm"] = 1;
  level._id_2FE9["shield_cleave_zm"] = 1;
  level._id_4D3D["shield_cleave_zm"] = 1;
  setup_melee_weapon_ownership(::has_shield, ::shield_gained, ::shield_lost);
}

give_shield_weapon() {
  try_drop_old_weapon("shield");

  if(!_id_0547::_id_73F9(self, "zom_dlc4_shield_zm")) {
    _id_0586::_id_078C("zom_dlc4_shield_zm");
    self switchtoweapon("zom_dlc4_shield_zm");
  }

  thread wep_disco_protect("shield");
  thread wep_death_protect("shield");
  level.ravenweaponmanager["shield"]._id_0117 = self;

  if(isDefined(level.reveal_structs_in_order)) {
    foreach(var_1 in level.reveal_structs_in_order) {
      if(common_scripts\utility::_id_562E(var_1.isrevealed)) {
        if(isDefined(var_1.fx))
          var_1.fx delete();

        var_1 maps\mp\mp_zombie_descent_ee_main::set_blood_code(var_1.blood_fx_index, self);
        continue;
      }

      if(common_scripts\utility::_id_562E(var_1.wisp)) {
        if(isDefined(var_1.fx))
          var_1.fx delete();

        var_1.fx = _id_0547::_id_8FBA(var_1, "zmf_descent_vision_blood_ready", self);
        _func_14C(var_1.fx);
      }
    }
  }
}

has_shield() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc4_shield_zm");
}

shield_gained() {
  thread shield_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_shield_hint)) {
    self.has_shown_shield_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_shield", self);
  }

  if(isDefined(level.ravenweaponmanager["shield"].on_gained_func))
    self[[level.ravenweaponmanager["shield"].on_gained_func]]();
}

shield_lost() {
  self notify(level.ravenweaponmanager["shield"].wep_loss_notify);

  if(isDefined(level.reveal_structs_in_order)) {
    foreach(var_1 in level.reveal_structs_in_order) {
      if(isDefined(var_1.fx))
        var_1.fx delete();
    }
  }
}

shield_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8128() && !var_1 _meth_8661() || var_1 _meth_8128() && var_1 _meth_83DE()) {
    var_0.ignorethiszerodamage = 1;
    return 0;
  }

  return level._id_8AFE;
}

shield_think() {
  var_0 = setup_melee_abilityinfo("zom_dlc4_shield_zm", 0.22, level.ravenweaponmanager["shield"].wep_loss_notify, ::shield_melee_cone, 1);
  thread shield_blood_block_enable();
  thread run_melee_ability(var_0);
  thread bayo_charge_watcher_zm("zom_dlc4_shield_zm", ::sheild_bayo_charge_start, ::sheild_bayo_charge_result);
}

shield_blood_block_enable() {
  self endon("disconnect");
  self.bloodblockhealth = 100;
  self.bloodshieldblock_test_func = ::shield_block_test_func;
  childthread shield_block_think();

  while(has_shield())
    waitframe();

  self notify("blood_block_disable");
}

shield_block_test_func(var_0, var_1) {
  if(!has_shield() || !_id_0547::_id_5565(self getcurrentweapon(), "zom_dlc4_shield_zm") || !_id_0547::_id_5565(self.is_bloodblocking, 1) || self _meth_8128() || self _meth_8661() || self _meth_83DE())
    return 0;

  if(isDefined(var_1) && var_1 is_out_of_bounds_trigger())
    return 0;

  if(isDefined(var_0) && self.bloodblockhealth >= 0 && maps\mp\_utility::_id_3B8E(self, var_0, 50))
    return 1;

  return 0;
}

is_out_of_bounds_trigger() {
  var_0 = self;
  return isDefined(var_0) && _id_0547::_id_5565(var_0.classname, "trigger_hurt");
}

shield_block_think() {
  var_0 = self;
  var_0 thread shield_manage_health();

  for(;;) {
    var_1 = isalive(self);

    if(var_1 && self getcurrentweapon() == "zom_dlc4_shield_zm" && self.bloodblockhealth > 0) {
      if(!isDefined(self.shieldblockfx))
        shield_block_fx_on();

      if(!_id_0547::_id_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 1;
        thread shield_block_ui();
      }

      self.is_bloodblocking = 1;
    } else if(var_1 && self getcurrentweapon() == "zom_dlc4_shield_zm" && self.bloodblockhealth <= 0) {
      if(isDefined(self.shieldblockfx))
        shield_block_fx_off();

      shield_punish(5);
      self.is_bloodblocking = 0;
    } else {
      if(isDefined(self.shieldblockfx))
        shield_block_fx_off();

      if(_id_0547::_id_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 0;
        self _meth_82FF("ui_onevone_class_5", -3);
      }

      self.is_bloodblocking = 0;
    }

    if(!has_shield()) {
      return;
    }
    common_scripts\utility::_id_A70A("weapon_change", "blood_health_empty", "weapon_given", "weapon_taken", "zombie_player_spawn_finished", "offhand_end", "weapon_switch_started", "death");

    while(self _meth_8126()) {
      if(isDefined(self.shieldblockfx))
        shield_emp_block_fx_off();

      waitframe();
    }
  }
}

shield_block_ui() {
  if(!isDefined(self.pre_bloodblockhealth))
    self.pre_bloodblockhealth = self.bloodblockhealth;

  self _meth_82FF("ui_onevone_show_class_menu", 1);
  self _meth_82FF("ui_onevone_class_5", self.bloodblockhealth);

  while(_id_0547::_id_5565(self.bloodui_active, 1)) {
    if(self.bloodblockhealth != self.pre_bloodblockhealth) {
      self.pre_bloodblockhealth = self.bloodblockhealth;

      if(self.bloodblockhealth <= 0)
        self _meth_82FF("ui_onevone_class_5", -2);
      else
        self _meth_82FF("ui_onevone_class_5", self.bloodblockhealth);
    }

    waitframe();
  }
}

shield_manage_health() {
  while(has_shield()) {
    self waittill("br_block_hit", var_0, var_1);
    self notify("shield_health_regen_interrupt");

    if(isDefined(self.boodshielddamagesustained))
      self.boodshielddamagesustained = self.boodshielddamagesustained + var_0;

    if(_id_0547::is_solo() && is_boss_weapon(var_1) && var_0 > 80)
      var_0 = 80;
    else if(var_0 > 10 && !is_boss_weapon(var_1))
      var_0 = 10;

    var_2 = var_0;

    if(self.bloodblockhealth - var_2 < 0) {
      var_2 = self.bloodblockhealth;

      if(isDefined(self.boodshielddamagesustained))
        self.boodshielddamagesustained = 0;

      self notify("blood_health_empty");
    } else
      _id_0378::_id_8D74("zmb_shield_hit");

    self.bloodblockhealth = self.bloodblockhealth - var_2;
    thread shield_health_regen();
  }
}

solo_or_not_boss_weapon(var_0) {
  if(_id_0547::is_solo())
    return 1;

  return !is_boss_weapon(var_0);
}

is_boss_weapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "zombie_king_uber") || issubstr(var_0, "zombie_king_uber_flame") || issubstr(var_0, "zombie_king_uber_sun") || issubstr(var_0, "geist_bomb_artil") || issubstr(var_0, "geist_blast_red"))
    return 1;

  return 0;
}

shield_health_regen() {
  self notify("shield_health_regen_begin");
  self endon("shield_health_regen_begin");
  self endon("shield_health_regen_interrupt");
  wait 4;

  while(self.bloodblockhealth < 100) {
    if(self.bloodblockhealth == 0 && common_scripts\utility::_id_562E(self.bloodui_active)) {
      self _meth_82FF("ui_onevone_show_class_menu", 1);
      self _meth_82FF("ui_onevone_class_5", -1);
    }

    self.bloodblockhealth = self.bloodblockhealth + 5;
    waitframe();
  }
}

shield_block_set_bar_color(var_0) {
  if(var_0 / 100 >= 1)
    self.color = (1, 0, 0);
  else if(var_0 / 100 < 1)
    self.color = (0.6, 0, 0);
}

shield_block_fx_on() {
  level notify("shield_block_on");
  self.shieldblockfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_blood_shield_block"), self, "TAG_FX", 1);
  _func_14C(self.shieldblockfx);
  setfxkillondelete(self.shieldblockfx, 1);
  self.shieldblockfx thread _id_0547::_id_2D19(self);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldblockfx);
}

shield_block_fx_off() {
  level notify("shield_block_off");

  if(isDefined(self.shieldblockfx))
    self.shieldblockfx delete();

  self.shieldblockfx = undefined;
}

sheild_bayo_charge_result(var_0) {
  self _meth_8036(1, 0.2);
  self.bayonetboosthc = 0;
  waitframe();
  _id_0547::_id_7ACD();

  if(var_0 == "sprint_melee_charge_end") {
    return;
  }
  if(var_0 == "sprint_melee_charge_attack")
    thread shield_slam();
  else {
    if(var_0 == "death") {
      return;
    }
    return;
  }
}

shield_melee_cone(var_0) {
  self endon("melee_ability_interrupt");
  self _meth_82FF("ui_onevone_opponent_client_num", 1);
  var_1 = _id_0586::zombies_hit_by_melee_cone(92, 90);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_shield_hit(var_1[var_2], var_2);

  self.shieldbashfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_blood_shield_bash"), self, "TAG_FX", 1);
  _func_14C(self.shieldbashfx);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldbashfx);
  self.shieldbashfx thread _id_0547::_id_2D20(self, "melee_ability_interrupt");
  waitframe();

  if(isDefined(self.shieldbashfx)) {
    self.shieldbashfx delete();
    self.shieldbashfx = undefined;
  }

  _id_0378::_id_8D74("zmb_shield_bash", self.origin);
}

delayed_shield_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("zmb_shield_bash", var_0.origin);
  var_0 _meth_8059(level._id_8AFE, self getEye(), self, self, "MOD_MELEE", "shield_cleave_zm", "none");
  _func_147(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbybladebarbarossa))
      _id_0547::_id_7D1B(self, var_0, "far");
  }
}

shield_slam() {
  self endon("disconnect");
  var_0 = self _meth_8566();
  var_1 = _func_22E(var_0);
  var_2 = self getEye() + var_1["forward"] * 48;
  self.shieldbashfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_blood_shield_bash"), self, "TAG_FX", 1);
  _func_14C(self.shieldbashfx);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldbashfx);
  waitframe();
  self.shieldbashfx delete();
  self.shieldbashfx = undefined;
  var_3 = _id_0547::get_zombies_touching_sphere(var_2, 90, 1, self);
  var_3 = _func_1AC(var_3, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    thread delayed_shield_slam(var_3[var_4], var_4);
}

delayed_shield_slam(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("zmb_shield_bash", var_0.origin);
  var_0 _meth_8059(level.shieldslamdamage, self getEye(), self, self, "MOD_MELEE", "shield_slam_zm", "none");
  _func_147(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbybladebarbarossa))
      _id_0547::_id_7D1B(self, var_0, "close");
  }
}

shield_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_shield_emp_zm"] = 1;
  level._id_62B3["zom_dlc4_shield_emp_zm"] = ::shield_emp_modify_damage;
  level.meleeaoeweapons["shield_slam_zm"] = 1;
  level.meleeaoeweapons["shield_cleave_emp_zm"] = 1;
  level._id_2FE9["zom_dlc4_shield_emp_zm"] = 1;
  level._id_4D3D["zom_dlc4_shield_emp_zm"] = 1;
  level._id_2FE9["shield_cleave_emp_zm"] = 1;
  level._id_4D3D["shield_cleave_emp_zm"] = 1;
  level.obj_shield = _func_18E("blood_shield_dome", "targetname");
  level.obj_shield.hidden_org = level.obj_shield.origin;
  level.obj_shield _meth_82C2();
  setup_melee_weapon_ownership(::has_shield_emp, ::shield_emp_gained, ::shield_emp_lost);
}

give_shield_emp_weapon(var_0) {
  try_drop_old_weapon("shield_emp", var_0);

  if(!_id_0547::_id_73F9(self, "zom_dlc4_shield_emp_zm")) {
    _id_0586::_id_078C("zom_dlc4_shield_emp_zm");
    self switchtoweapon("zom_dlc4_shield_emp_zm");
  }

  thread wep_disco_protect("shield_emp");
  thread wep_death_protect("shield_emp");
  level.ravenweaponmanager["shield_emp"]._id_0117 = self;
}

try_drop_old_weapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!common_scripts\utility::_id_562E(var_2) && !common_scripts\utility::_id_562E(var_3)) {
    self notify("return_faked_scythe");

    if(_id_0547::_id_5565(self.forcedblooddest, "zom_dlc4_scythe_zm"))
      self.forcedblooddest = undefined;
  }

  var_4 = test_raven_weapon_owner();

  if(common_scripts\utility::_id_562E(var_2) || isDefined(var_4) && var_4 != var_0) {
    take_raven_weapon(var_4);

    if(!isDefined(self.isintrial)) {
      if(!common_scripts\utility::_id_562E(var_1) || common_scripts\utility::_id_562E(var_2))
        thread spawn_raven_weapon(var_4, self.origin, self.angles, 0.25);
    }
  }

  var_5 = _func_337(var_0, "_emp");
  try_take_dlc4_melee_from_other_player(var_5, var_5 + "_emp", "shovel_zm");

  if(common_scripts\utility::_id_562E(var_2))
    _id_0586::_id_078E(common_scripts\utility::random(self getweaponlistprimaries()));
}

has_shield_emp() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc4_shield_emp_zm");
}

shield_emp_gained() {
  thread shield_emp_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_shield_emp_hint)) {
    self.has_shown_shield_emp_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_shield_emp", self);
  }

  if(isDefined(level.ravenweaponmanager["shield_emp"].on_gained_func))
    self[[level.ravenweaponmanager["shield_emp"].on_gained_func]]();
}

shield_emp_lost() {
  self notify(level.ravenweaponmanager["shield_emp"].wep_loss_notify);
}

shield_emp_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8128() && !var_1 _meth_8661() || var_1 _meth_8128() && var_1 _meth_83DE()) {
    var_0.ignorethiszerodamage = 1;
    return 0;
  }

  return level.shieldempdamage;
}

shield_emp_think() {
  var_0 = setup_melee_abilityinfo("zom_dlc4_shield_emp_zm", 0.22, level.ravenweaponmanager["shield_emp"].wep_loss_notify, ::shield_emp_melee_cone, 1);
  thread shield_emp_blood_block_enable();
  thread shield_emp_uber_block_run();
  thread run_melee_ability(var_0);
  thread bayo_charge_watcher_zm("zom_dlc4_shield_emp_zm", ::sheild_bayo_charge_start, ::sheild_emp_bayo_charge_result);
}

shield_emp_blood_block_enable() {
  self endon("disconnect");
  self.bloodblockhealth = 200;
  self.bloodshieldblock_test_func = ::shield_emp_block_test_func;
  childthread shield_emp_block_think();

  while(has_shield_emp())
    waitframe();

  self notify("blood_block_disable");
}

shield_emp_uber_block_run() {
  self endon("disconnect");

  while(has_shield_emp()) {
    if(shield_emp_uber_conditions() && isDefined(level.obj_shield)) {
      self.reserved_plate = shield_player_touching_full_blood_plate();

      if(isDefined(self.reserved_plate) && self.reserved_plate common_scripts\utility::_id_3794("plate_reserved")) {
        continue;
      }
      if(isDefined(self.reserved_plate) && !isDefined(self.blood_shield_uber_fx)) {
        self.blood_shield_uber_fx = _func_2A8(common_scripts\utility::_id_44F5("zmb_blood_shield_uber"), self.reserved_plate.plate_model, "TAG_ORIGIN");
        self.blood_shield_uber_fx.owener = self;
        _func_14C(self.blood_shield_uber_fx);
        level.obj_shield.origin = self.reserved_plate.origin;
        level.obj_shield thread shield_uber_block_disco_protect(self);
        level.obj_shield _meth_82C1();
        level.obj_shield._id_9297 = gettime();
        self.reserved_plate thread maps\mp\mp_zombie_descent::blood_plate_boss_reserve(self);
        self.blood_shield_uber_fx thread shield_emp_uber_danger_zone();

        while(!shield_timeout_reached() && has_shield_emp()) {
          self.reserved_plate maps\mp\mp_zombie_descent::blood_plate_subtract();

          foreach(var_1 in level.players) {
            if(_func_0E1(var_1.origin, level.obj_shield.origin) < 100)
              var_1 _id_0547::_id_73AC(1);
          }

          wait 1;
        }

        self.reserved_plate maps\mp\mp_zombie_descent::blood_plate_empty();
        cleanup_blood_shield_uber(self.blood_shield_uber_fx, self.reserved_plate);
      } else if(isDefined(self.blood_shield_uber_fx))
        cleanup_blood_shield_uber(self.blood_shield_uber_fx, self.reserved_plate);
    } else if(isDefined(self.blood_shield_uber_fx))
      cleanup_blood_shield_uber(self.blood_shield_uber_fx, self.reserved_plate);

    waitframe();
  }
}

cleanup_blood_shield_uber(var_0, var_1) {
  level.obj_shield _meth_82C2();
  level.obj_shield.origin = level.obj_shield.hidden_org;
  level.obj_shield._id_9297 = undefined;
  var_0 delete();
  var_1 notify("release_plate");
  level.obj_shield notify("unlinked_from_player");
}

shield_timeout_reached() {
  var_0 = gettime();

  if(var_0 - level.obj_shield._id_9297 > 6000)
    return 1;

  return 0;
}

shield_uber_block_disco_protect(var_0) {
  self endon("unlinked_from_player");
  self notify("shield_disco_protect");
  self endon("shield_disco_protect");
  var_1 = var_0.reserved_plate;
  var_2 = var_0.blood_shield_uber_fx;
  var_0 waittill("disconnect");
  thread cleanup_blood_shield_uber(var_2, var_1);
}

shield_emp_uber_danger_zone() {
  var_0 = self;

  while(isDefined(var_0)) {
    foreach(var_2 in _id_0547::_id_408F()) {
      if(distance(var_0.origin, var_2.origin) > 128 || _id_0547::_id_5565(level.zombie_king, var_2) || common_scripts\utility::_id_562E(var_2._id_8F2B)) {
        continue;
      }
      var_3 = _id_0580::_id_8317(var_2.origin, var_0.owener);
      var_3._id_6AA0 = ::shield_stun;
      var_2 thread _id_0547::_id_7D1A("tesla_shock", [var_3], 1);
    }

    waitframe();
  }
}

shield_stun(var_0) {
  _id_0547::_id_7D1B(self, self, "medium");
}

shield_emp_uber_conditions() {
  return common_scripts\utility::_id_562E(self _meth_8343() && self getcurrentweapon() == "zom_dlc4_shield_emp_zm" && self.bloodblockhealth > 0 && !_id_0547::_id_577E(self));
}

shield_player_touching_full_blood_plate() {
  foreach(var_1 in level.blood_plates) {
    if(isDefined(var_1.plate_damage_trig) && self istouching(var_1.plate_damage_trig) && _id_0547::_id_5565(var_1.isbloodfull, 1))
      return var_1;
  }

  return;
}

shield_emp_block_test_func(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!has_shield_emp() || !_id_0547::_id_5565(self getcurrentweapon(), "zom_dlc4_shield_emp_zm") || !_id_0547::_id_5565(self.is_bloodblocking, 1) || self _meth_8128() || self _meth_8661() || self _meth_83DE())
    return 0;

  if(isDefined(var_1) && var_1 is_out_of_bounds_trigger())
    return 0;

  if(self.bloodblockhealth >= 0 && maps\mp\_utility::_id_3B8E(self, var_0, 60))
    return 1;

  return 0;
}

shield_emp_block_think() {
  var_0 = self;
  var_0 thread shield_emp_manage_health();

  for(;;) {
    var_1 = isalive(self);

    if(var_1 && self getcurrentweapon() == "zom_dlc4_shield_emp_zm" && self.bloodblockhealth > 0 && !common_scripts\utility::_id_562E(level._id_22F0)) {
      if(!isDefined(self.shieldblockfx))
        shield_emp_block_fx_on();

      if(!_id_0547::_id_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 1;
        thread shield_emp_block_ui();
      }

      self.is_bloodblocking = 1;
    } else if(var_1 && self getcurrentweapon() == "zom_dlc4_shield_emp_zm" && self.bloodblockhealth <= 0 && !common_scripts\utility::_id_562E(level._id_22F0)) {
      if(isDefined(self.shieldblockfx))
        shield_emp_block_fx_off();

      shield_punish(3);
      self.is_bloodblocking = 0;
    } else {
      if(isDefined(self.shieldblockfx))
        shield_emp_block_fx_off();

      if(_id_0547::_id_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 0;
        self _meth_82FF("ui_onevone_class_5", -3);
      }

      self.is_bloodblocking = 0;
    }

    if(!has_shield_emp()) {
      return;
    }
    common_scripts\utility::_id_A715("weapon_change", "blood_health_empty", "weapon_given", "weapon_taken", "zombie_player_spawn_finished", "offhand_end", "weapon_switch_started", "boss_scene_end", "death");

    while(self _meth_8126()) {
      if(isDefined(self.shieldblockfx))
        shield_emp_block_fx_off();

      waitframe();
    }
  }
}

shield_emp_block_ui() {
  if(!isDefined(self.pre_bloodblockhealth))
    self.pre_bloodblockhealth = self.bloodblockhealth;

  self _meth_82FF("ui_onevone_show_class_menu", 2);
  self _meth_82FF("ui_onevone_class_5", self.bloodblockhealth);

  while(_id_0547::_id_5565(self.bloodui_active, 1)) {
    if(self.bloodblockhealth != self.pre_bloodblockhealth) {
      self.pre_bloodblockhealth = self.bloodblockhealth;

      if(self.bloodblockhealth <= 0)
        self _meth_82FF("ui_onevone_class_5", -2);
      else
        self _meth_82FF("ui_onevone_class_5", self.bloodblockhealth);
    }

    waitframe();
  }
}

shield_emp_manage_health() {
  while(has_shield_emp()) {
    self waittill("br_block_hit", var_0, var_1);
    self notify("shield_health_regen_interrupt");

    if(isDefined(self.boodshielddamagesustained))
      self.boodshielddamagesustained = self.boodshielddamagesustained + var_0;

    if(_id_0547::is_solo() && is_boss_weapon(var_1) && var_0 > 180)
      var_0 = 180;
    else if(var_0 > 10 && !is_boss_weapon(var_1))
      var_0 = 10;

    var_2 = var_0;

    if(self.bloodblockhealth - var_2 < 0) {
      var_2 = self.bloodblockhealth;

      if(isDefined(self.boodshielddamagesustained))
        self.boodshielddamagesustained = 0;

      self notify("blood_health_empty");
    } else
      _id_0378::_id_8D74("zmb_shield_hit");

    self.bloodblockhealth = self.bloodblockhealth - var_2;
    thread shield_emp_health_regen();
  }
}

shield_emp_health_regen() {
  self notify("shield_health_regen_begin");
  self endon("shield_health_regen_begin");
  self endon("shield_health_regen_interrupt");
  wait 3;

  while(self.bloodblockhealth < 200) {
    if(self.bloodblockhealth == 0 && common_scripts\utility::_id_562E(self.bloodui_active)) {
      self _meth_82FF("ui_onevone_show_class_menu", 2);
      self _meth_82FF("ui_onevone_class_5", -1);
    }

    self.bloodblockhealth = self.bloodblockhealth + 5;
    waitframe();
  }
}

shield_emp_block_set_bar_color(var_0) {
  if(var_0 / 100 >= 1)
    self.color = (1, 0, 0);
  else if(var_0 / 100 < 1)
    self.color = (0.6, 0, 0);
}

shield_emp_block_fx_on() {
  level notify("shield_block_on");
  self.shieldblockfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_blood_shield_block_emp"), self, "TAG_FX", 1);
  _func_14C(self.shieldblockfx);
  setfxkillondelete(self.shieldblockfx, 1);
  self.shieldblockfx thread _id_0547::_id_2D19(self);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldblockfx);
}

shield_emp_block_fx_off() {
  level notify("shield_block_off");

  if(isDefined(self.shieldblockfx))
    self.shieldblockfx delete();

  self.shieldblockfx = undefined;
}

shield_punish(var_0) {
  var_1 = 30;
  self endon("death");
  self _meth_8182("zm_heavy_hit", var_0, var_0);
  self _meth_8308(0);
  self _meth_8322();
  self _meth_8326();
  self _meth_809F("damage_heavy");
  var_2 = self.origin - (self.origin + anglesToForward(self.angles) * 10);
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = var_1 * vectorNormalize(var_2);
  var_2 = (var_2[0], var_2[1], 125);
  self _meth_82F7(var_2);
  _id_0378::_id_8D74("zmb_shield_break");
  wait(var_0);
  self _meth_8308(1);
  self _meth_8323();
  self _meth_8327();
}

shield_emp_melee_cone(var_0) {
  self endon("melee_ability_interrupt");
  self _meth_82FF("ui_onevone_opponent_client_num", 2);
  var_1 = _id_0586::zombies_hit_by_melee_cone(220, 75);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_shield_emp_hit(var_1[var_2], var_2);

  childthread attempt_reflect_king_blast(92, 90);
  var_3 = common_scripts\utility::_id_44F5("zmb_blood_shield_bash_emp");
  playFX(var_3, self.origin + (0, 0, 50), anglesToForward(self _meth_8566()));
  _id_0378::_id_8D74("zmb_bloodraven_shield_bash", self.origin);
}

delayed_shield_emp_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("zmb_bloodraven_shield_bash", var_0.origin);
  var_0 _meth_8059(level.shieldempdamage, self getEye(), self, self, "MOD_MELEE", "shield_cleave_emp_zm", "none");
  _func_147(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbybladebarbarossa))
      _id_0547::_id_7D1B(self, var_0, "medium");
  }
}

sheild_bayo_charge_start() {
  self _meth_8036(1.25, 0.2);
  self.bayonetboosthc = 1;
  waitframe();
  _id_0547::_id_7ACD();
}

create_shield_push_params(var_0) {
  var_1 = spawnStruct();
  var_1._id_0117 = var_0;
  var_1.ownerinitialangles = var_0 _meth_8566();
  return var_1;
}

sheild_emp_bayo_charge_result(var_0) {
  self _meth_8036(1, 0.2);
  self.bayonetboosthc = 0;
  waitframe();
  _id_0547::_id_7ACD();

  if(var_0 == "sprint_melee_charge_end") {
    return;
  }
  if(var_0 == "sprint_melee_charge_attack")
    thread shield_emp_slam();
  else {
    if(var_0 == "death") {
      return;
    }
    return;
  }
}

shield_emp_slam() {
  self endon("disconnect");
  var_0 = self _meth_8566();
  var_1 = _func_22E(var_0);
  var_2 = self getEye() + var_1["forward"] * 48;
  var_3 = common_scripts\utility::_id_44F5("zmb_blood_shield_bash_emp");
  playFX(var_3, self.origin + (0, 0, 50), anglesToForward(self.angles));
  var_4 = _id_0547::get_zombies_touching_sphere(var_2, 124, 1, self);
  var_4 = _func_1AC(var_4, var_2);

  if(isDefined(var_4[0]))
    thread delayed_shield_push_hit(var_4[0], shield_can_throw(var_4[0]));
}

delayed_shield_push_hit(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_0 endon("death");
  waitframe();

  if(var_1) {
    wait 0;
    var_3 = create_shield_push_params(var_2);
    var_0.throwingzombie = 1;
    var_0 _id_0547::_id_7D1A("shield_push", [var_3], 0.25);
  } else {
    var_4 = _id_0547::_id_0A51(var_0._id_0A4B);
    var_5 = common_scripts\utility::_id_562E(var_0.scaleshealthbyplayers) || common_scripts\utility::_id_562E(var_4.scaleshealthbyplayers);
    var_6 = 1;
    _id_0378::_id_8D74("zmb_shield_bash", var_0.origin);
    var_0 _meth_8059(level.shieldempdamage, var_2 getEye(), var_2, var_2, "MOD_MELEE", "shield_slam_zm", "none");
    _func_147(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

    if(common_scripts\utility::_id_562E(0)) {
      if(!common_scripts\utility::_id_562E(1) || level.players.size <= 0) {
        if(isDefined(var_0._id_0A4B)) {
          if(isDefined(var_4) && common_scripts\utility::_id_562E(var_4.knockbybladebarbarossa))
            _id_0547::_id_7D1B(var_2, var_0, "far");
        }
      }
    }
  }
}

shield_push_interrupt(var_0) {}

shield_can_stun(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyhold))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyhold);
}

shield_can_secondary_stun(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyholdsecondary))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyholdsecondary);
}

shield_can_secondary_slow(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyslowsecondary))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyslowsecondary);
}

shield_can_throw(var_0, var_1) {
  if(var_0 maps\mp\agents\humanoid\_humanoid_util::_id_56BC())
    return 0;

  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.notthrowable))
    return 0;

  return common_scripts\utility::_id_562E(var_1.throwable);
}

shield_can_stun_kill(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyholdkill))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyholdkill);
}

shield_push_end(var_0) {
  var_1 = self;
  var_1.immunetotackling = undefined;
  var_1 set_shield_push_state(2);
  var_1 notify("sword_throw_end");

  if(var_1._id_0A4B == "zombie_exploder")
    var_1 _id_0563::zombie_exploder_attempt_detonate(var_0._id_0117, "shield_slam_zm");

  var_1 _meth_8059(var_1.health + 1, var_1.origin, var_0._id_0117, var_0._id_0117, "MOD_MELEE", "shield_slam_zm", "head");
  var_1 _meth_83A2(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "shield_push");
  var_1 _meth_839A(1.0, 1.0);
  set_shield_push_state(undefined);
  var_1.swordthrowowner = undefined;
}

shield_push_run(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1.immunetotackling = 1;
  var_1.shieldpushowner = var_0._id_0117;
  var_1 _meth_83A2(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "shield_push");
  var_1 thread shield_push_handle_collision(var_0);

  if(common_scripts\utility::_id_562E(1))
    var_1 thread shield_push_damage_impacted_zombies(var_0);

  _func_147(common_scripts\utility::_id_44F5("zmb_raven_sword_barb_burst"), var_1, "tag_origin");
  var_1 _id_0378::_id_8D74("zmb_shield_bash");
  var_1 shield_push_animate(var_0);
}

set_shield_push_state(var_0) {
  var_1 = self;
  var_1.shieldpushstate = var_0;
}

shield_push_handle_collision(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("shield_push_end");

  if(common_scripts\utility::_id_562E(0)) {
    var_2 = self gettagorigin("J_Spine4");
    var_3 = spawn("script_model", var_2);
    var_3 setModel("tag_origin");
    var_3._id_0117 = var_1;
    var_4 = 180;
    var_3 linktosynchronizedparent(var_1, "tag_origin", (0, 0, 0), (0, var_4, 0));
    var_1 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_3);
    thread cleanup_ent_on_shield_push_end(var_3);
    var_5 = spawnStruct();
    var_5._id_2434 = 37;
    var_5._id_60C1 = 55;
    var_5._id_3A20 = 82;
    var_5._id_1B70 = 160;
    var_1 childthread _id_0547::tackle_thread(var_3, var_5);
  }

  var_6 = var_1.origin;
  var_7 = 100;
  var_8 = var_0.ownerinitialangles[1];
  var_9 = 10;
  wait 0.25;

  for(;;) {
    waitframe();
    var_10 = var_1.origin - var_6;

    if(_func_0E5(var_10) < var_7) {
      break;
    }

    var_11 = _func_109(var_10);
    var_12 = _func_0AE(_func_0DD(var_11 - var_8));

    if(var_12 > var_9) {
      break;
    }

    var_6 = var_1.origin;
  }

  if(common_scripts\utility::_id_562E(1)) {
    var_14 = _id_0547::_id_43F0(var_1.origin, var_1._id_8302, var_1._id_8303 * 1.2, 1);

    foreach(var_16 in var_14) {
      if(isDefined(var_1.thrownimpacts)) {
        var_17 = var_1.thrownimpacts[var_16 getentitynumber()];

        if(isDefined(var_17) && gettime() - var_17 <= 100)
          continue;
      }

      shield_push_zombie_impact_damage(var_0, var_1, var_16);
    }
  }

  var_1 notify("shield_push_blocked");
}

shield_push_damage_impacted_zombies(var_0) {
  var_1 = self;
  var_1 endon("shield_push_blocked");
  var_1 endon("shield_push_end");
  var_1 endon("death");

  for(;;) {
    var_1 waittill("touch", var_2);

    if(!_func_1EF(var_2)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(var_2._id_000A) && var_2._id_000A == level._id_746E) {
      continue;
    }
    if(var_2 == var_1) {
      continue;
    }
    if(isDefined(var_2.shieldpushstate)) {
      continue;
    }
    shield_push_zombie_impact_damage(var_0, var_1, var_2);
  }
}

shield_push_zombie_impact_damage(var_0, var_1, var_2) {
  if(shield_can_stun(var_2) || shield_can_secondary_stun(var_2) || shield_can_secondary_slow(var_2))
    _id_0547::_id_7D1B(_id_0547::create_temp_tackler(var_1), var_2, "close", var_1.shieldpushowner);

  if(_id_0547::_id_5565(level.zombie_king, var_2)) {
    var_3 = var_1.angles;
    var_3 = (var_3[0], _func_0DD(var_3[1] + 10 + 1), var_3[2]);
    var_1.angles = var_3;
  }

  var_2 _meth_8059(level.shieldpushimpactdamage, var_1.origin, var_0._id_0117, var_0._id_0117, "MOD_MELEE", "shield_slam_zm");

  if(common_scripts\utility::_id_562E(1) && isalive(var_2)) {
    if(var_2._id_0A4B == "zombie_heavy")
      var_2 thread _id_0567::zombie_heavy_set_grudge(var_0._id_0117);
  }

  if(var_1._id_0A4B == "zombie_exploder")
    var_1 _id_0563::zombie_exploder_attempt_detonate(var_0._id_0117, "shield_slam_zm");

  var_1 _meth_8059(level.shieldpushimpactdamage, var_1.origin, var_0._id_0117, var_0._id_0117, "MOD_MELEE", "shield_slam_zm");

  if(!isDefined(var_1.thrownimpacts))
    var_1.thrownimpacts = [];

  var_1.thrownimpacts[var_2 getentitynumber()] = gettime();
}

shield_push_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;

  if(isDefined(self.shieldpushstate)) {
    if(var_9._id_0A4B == "zombie_exploder")
      var_9 _id_0563::zombie_exploder_attempt_detonate(var_9.shieldpushowner, "shield_slam_zm");
  }
}

cleanup_ent_on_shield_push_end(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 waittill("shield_push_end");
  var_0 delete();
}

shield_push_animate(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = _func_0A5(0.5, 2);
  set_shield_push_state(0);
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_throw_start");
  var_4 = self _meth_83DB(var_3);
  var_5 = randomint(var_4);
  var_6 = solve_yaw_for_shield_push_anim(var_3, var_5, var_0.ownerinitialangles[1]);
  var_1.angles = (var_1.angles[0], var_6, var_1.angles[2]);
  var_7 = 2 / var_2;
  var_1 _meth_839C("anim deltas");
  var_1 _meth_839B("face angle rel", (var_1.angles[0], var_6, var_1.angles[2]));
  var_1 _meth_839D("gravity");
  var_1 _meth_839A(var_7, 1.0);
  var_1 set_shield_push_state(1);
  var_3 = var_1 maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_throw_loop");
  var_4 = var_1 _meth_83DB(var_3);
  var_5 = randomint(var_4);
  var_6 = solve_yaw_for_shield_push_anim(var_3, var_5, var_0.ownerinitialangles[1]);
  var_1 _meth_839B("face angle abs", (var_1.angles[0], var_6, var_1.angles[2]));
  var_8 = 2.0;
  var_9 = _func_0A3(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_3, var_5, var_2, var_9);
  var_1 maps\mp\_utility::waitfortimeornotify(var_8, "shield_push_blocked");
}

solve_yaw_for_shield_push_anim(var_0, var_1, var_2) {
  var_3 = self _meth_83D8(var_0, var_1);
  var_4 = _func_083(var_3, 0, 1);
  var_5 = vectortoangles(var_4);
  return _func_0DD(var_2 - var_5[1]);
}

hammer_init() {
  level.zombiemeleeweapon["zom_dlc4_hammer_zm"] = 1;
  level._id_62B3["zom_dlc4_hammer_zm"] = ::hammer_modify_damage;
  level.meleeaoeweapons["hammer_cleave_zm"] = 1;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_3["hit_zombie_snd"] = "zmb_HAMMER_melee_hit_wooden";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_HAMMER_melee_hit_wooden";
  level._id_6DF9["default"]["zom_dlc4_hammer_zm"] = var_3;
  setup_melee_weapon_ownership(::has_hammer, ::hammer_gained, ::hammer_lost);
}

give_hammer_weapon() {
  try_drop_old_weapon("hammer");

  if(!_id_0547::_id_73F9(self, "zom_dlc4_hammer_zm")) {
    _id_0586::_id_078C("zom_dlc4_hammer_zm");
    self switchtoweapon("zom_dlc4_hammer_zm");
  }

  thread wep_disco_protect("hammer");
  thread wep_death_protect("hammer");
  level.ravenweaponmanager["hammer"]._id_0117 = self;
}

has_hammer() {
  var_0 = self;
  var_1 = var_0 _meth_82D5();
  return issubstr(var_1, "zom_dlc4_hammer_zm");
}

hammer_gained() {
  thread hammer_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_hammer_hint)) {
    self.has_shown_hammer_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_hammer", self);
  }

  if(isDefined(level.ravenweaponmanager["hammer"].on_gained_func))
    self[[level.ravenweaponmanager["hammer"].on_gained_func]]();
}

hammer_lost() {
  self notify(level.ravenweaponmanager["hammer"].wep_loss_notify);
}

hammer_think() {
  var_0 = setup_heavy_melee_abilityinfo("zom_dlc4_hammer_zm", 0.45, level.ravenweaponmanager["hammer"].wep_loss_notify, ::hammer_melee_cone, 0.3);
  thread run_heavy_melee_ability(var_0);
}

hammer_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8661())
    return 0;

  return level.hammerdamage;
}

hammer_melee_cone(var_0) {
  self endon("melee_ability_interrupt");
  var_1 = _id_0586::zombies_hit_by_melee_cone(125, 80);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_hammer_hit(var_1[var_2], var_2);
}

delayed_hammer_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  var_3 = spawnStruct();
  var_3.player = self;
  var_3._id_ABE6 = var_0.origin;
  var_3._id_4DCF = "none";
  var_3._id_60B8 = undefined;
  var_3._id_01D0 = "hammer_cleave_zm";
  var_3.delaysec = undefined;
  _id_0378::_id_8D74("zmb_HAMMER_melee_hit_wooden", var_3);
  var_0 _meth_8059(level.hammercleavedamage, self getEye(), self, self, "MOD_MELEE", "hammer_cleave_zm", "none");
  _func_147(level._effect["zmb_hammer_smack"], var_0, "TAG_EYE");

  if(isDefined(var_0._id_0A4B)) {
    var_4 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_4) && common_scripts\utility::_id_562E(var_4.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "far");
  }
}

sqrd_dist_between_segments(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 0.000001;
  var_6 = var_3 - var_2;
  var_7 = var_1 - var_0;
  var_8 = var_0 - var_2;
  var_9 = vectordot(var_6, var_6);
  var_10 = vectordot(var_7, var_7);
  var_11 = vectordot(var_7, var_6);
  var_12 = vectordot(var_6, var_8);
  var_13 = vectordot(var_7, var_8);
  var_14 = var_9 * var_10 - var_11 * var_11;
  var_15 = 0;
  var_16 = 0;

  if(var_14 <= var_5) {
    if(var_11 > var_9)
      var_15 = var_13 / var_11;
    else
      var_15 = var_12 / var_9;
  } else {
    var_15 = (var_12 * var_10 - var_11 * var_13) / var_14;
    var_16 = (var_11 * var_12 - var_13 * var_9) / var_14;
  }

  var_15 = clamp(var_15, 0.0, 1.0);
  var_16 = clamp(var_16, 0.0, 1.0);
  var_17 = var_2 + var_6 * var_15;
  var_18 = var_0 + var_7 * var_16;
  var_19 = var_18 - var_17;
  var_20 = vectordot(var_19, var_19);
  var_4[1] = var_18;
  var_4[2] = var_17;
  var_4[0] = var_20;
  return var_4;
}

do_zombie_trace_damage(var_0, var_1, var_2) {
  var_3 = _id_0547::_id_408F();

  foreach(var_5 in var_3) {
    var_6 = var_5._id_8302;
    var_7 = var_5._id_8303;
    var_8 = var_7 + self.hammer_radius;
    var_9 = var_8 * var_8;
    var_10 = sqrd_dist_between_segments(var_0, var_1, var_5.origin, var_5.origin + (0, 0, var_6));

    if(var_10[0] <= var_9)
      [[var_2]](var_5, var_10[1]);
  }
}

do_zombie_damage_better(var_0) {
  self endon("death");

  for(self.hammer_old_pos = self.origin; isDefined(self); self.hammer_old_pos = self.origin) {
    waitframe();
    waittillframeend;
    do_zombie_trace_damage(self.hammer_old_pos, self.origin, var_0);
  }
}

hammer_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_hammer_emp_zm"] = 1;
  level._id_62B3["zom_dlc4_hammer_emp_zm"] = ::hammer_emp_modify_damage;
  level.meleeaoeweapons["hammer_cleave_emp_zm"] = 1;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (40, 2, 0);
  var_2 = length(var_1);
  var_3 = [];
  var_3["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_3["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_3["hit_zombie_snd"] = "zmb_HAMMER_melee_hit_metal";
  var_3["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_3["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_HAMMER_melee_hit_metal";
  level._id_6DF9["default"]["zom_dlc4_hammer_emp_zm"] = var_3;
  setup_melee_weapon_ownership(::has_hammer_emp, ::hammer_emp_gained, ::hammer_emp_lost);
}

give_hammer_emp_weapon(var_0) {
  try_drop_old_weapon("hammer_emp", var_0);

  if(!_id_0547::_id_73F9(self, "zom_dlc4_hammer_emp_zm")) {
    _id_0586::_id_078C("zom_dlc4_hammer_emp_zm");
    self switchtoweapon("zom_dlc4_hammer_emp_zm");
  }

  thread wep_disco_protect("hammer_emp");
  thread wep_death_protect("hammer_emp");
  level.ravenweaponmanager["hammer_emp"]._id_0117 = self;
}

has_hammer_emp() {
  var_0 = self;
  var_1 = var_0 _meth_82D5();
  return issubstr(var_1, "zom_dlc4_hammer_emp_zm");
}

hammer_emp_gained() {
  thread hammer_emp_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_hammer_emp_hint)) {
    self.has_shown_hammer_emp_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_hammer_emp", self);
  }

  if(isDefined(level.ravenweaponmanager["hammer_emp"].on_gained_func))
    self[[level.ravenweaponmanager["hammer_emp"].on_gained_func]]();
}

hammer_emp_lost() {
  self notify(level.ravenweaponmanager["hammer_emp"].wep_loss_notify);
}

hammer_emp_think() {
  setdvarifuninitialized("HAMMER_emp_debug", 0);
  thread hammer_throw_think();
  thread hammer_throw_toggle_equip();
  var_0 = setup_heavy_melee_abilityinfo("zom_dlc4_hammer_emp_zm", 0.45, level.ravenweaponmanager["hammer_emp"].wep_loss_notify, ::hammer_emp_melee_cone, 0.3);
  thread run_heavy_melee_ability(var_0);
}

hammer_throw_think() {
  self endon(level.ravenweaponmanager["hammer_emp"].wep_loss_notify);

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "zom_hammer_grenade_zm") {
      _id_0378::_id_8D74("dlc4_throw_hammer");
      self.weapon_previous_to_hammer = common_scripts\utility::_id_4550();
      var_0 thread handle_hammer_grenade(self);
    }
  }
}

handle_hammer_grenade(var_0) {
  self _meth_805C();
  waitframe();
  var_1 = hammer_replace_projectile_with_model(var_0);
  var_1.htarget = var_1.tag_tracker;
  var_1 childthread hammer_throw_arm();
  var_1 childthread hammer_throw_end();
  var_1 thread hammer_detonate_on_death(var_0);
  var_1._id_0117 = var_0;
  var_1._id_0117 thread hammer_handle_melee_attack();
  var_1._id_0117.hammer_throw_on_cooldown = 1;
  var_1.hammer_radius = 22;
  var_2 = undefined;
  var_1 childthread do_zombie_damage_better(::hammer_do_flight_damage);
  var_3 = undefined;
  var_4 = vectorNormalize(anglesToForward(var_1._id_0117 _meth_8566()));
  var_5 = var_1._id_0117 getEye() + var_4 * 2000;
  var_1.tag_tracker.end_point = var_5;
  var_1.tag_tracker.forward_dir = var_4;
  var_6 = vectorNormalize(anglestoright(var_1._id_0117 _meth_8566()));
  var_7 = 0.4;
  var_8 = 6.0;
  var_9 = 1000.0;
  var_10 = var_4 * var_9;
  var_9 = var_9 * 0.9;
  var_11 = (0, 0, 0.12);
  var_11 = var_11 + -0.2 * var_6;
  var_12 = vectorNormalize(var_4 + var_11);
  var_1.forward_dir = var_12;
  var_1.angles = hammer_modelangles_fromdir(var_1.forward_dir);
  var_1.origin = var_1.origin - 38 * var_4;
  var_1.origin = var_1.origin - (0, 0, 8);
  _func_147(level._effect["zmb_stormhammer_trail"], var_1, "Tag_Weapon");
  var_1 _id_0378::_id_8D74("aud_hammer_trail_lp");
  var_13 = 0.05;

  while(_id_0547::_id_5565(var_1.inflight, 1) && vectordot(var_5 - var_1.tag_tracker.origin, var_10) > 0) {
    var_1.tag_tracker.next_tracker_pos = var_1.tag_tracker.origin + var_10 * var_13;
    var_1.tag_tracker.origin = var_1.tag_tracker.next_tracker_pos;

    if(var_1.isarmed) {
      if(!_func_1EF(var_1.htarget) || !isalive(var_1.htarget) || distancesquared(var_1.htarget.origin, var_5) > distancesquared(var_1.origin, var_5)) {
        var_1 hammer_rank_targets();
        var_2 = var_1 hammer_choose_target();

        if(!isDefined(var_2))
          var_2 = var_1.tag_tracker;
      }
    }

    var_14 = 0;

    if(isDefined(var_2)) {
      var_1.htarget = var_2;
      var_14 = 1;
      var_2 = undefined;
    }

    var_15 = var_1.htarget.origin;
    var_16 = var_10 * 0.9;
    var_17 = var_7;

    if(_func_1EF(var_1.htarget)) {
      var_15 = var_1.htarget getEye() + (0, 0, -8);
      var_16 = var_1.htarget _meth_833D();
      var_17 = var_17 + var_8;
    }

    var_18 = var_17 * var_13;
    var_19 = var_18 * var_18;
    var_20 = distance(var_15, var_1.origin);
    var_21 = var_20 / var_9;
    var_22 = clamp(var_21, 0.05, 1.0);
    var_23 = var_15 + var_16 * var_22;
    var_24 = vectorNormalize(var_23 - var_1.origin);
    var_25 = var_24 - var_1.forward_dir;

    if(vectordot(var_25, var_25) > var_19)
      var_25 = var_18 * vectorNormalize(var_25);

    var_1.forward_dir = vectorNormalize(var_1.forward_dir + var_25);
    var_1.angles = hammer_modelangles_fromdir(var_1.forward_dir);
    var_1.next_hammer_pos = var_1.origin + var_1.forward_dir * var_9 * var_13;
    var_26 = bulletTrace(var_1.origin, var_1.next_hammer_pos, 0, var_1, 1);

    if(var_26["fraction"] < 1.0) {
      var_27 = max(var_26["fraction"] * var_13, 0.05);
      var_1 _meth_82B1(var_26["position"], var_27);
      wait(var_27);
      hammer_detonate_attack(var_26["position"], var_0);
      break;
    }

    var_1 _meth_82B1(var_1.next_hammer_pos, var_13);
    wait(var_13);
  }

  var_1.forward_dir = vectorNormalize(var_1._id_0117.origin - var_1.origin);
  var_1.angles = hammer_modelangles_fromdir(var_1.forward_dir);
  waitframe();
  var_28 = 0.05;

  while(isDefined(var_1)) {
    var_29 = var_1._id_0117.origin + (0, 0, 42);
    var_30 = distance(var_29, var_1.origin);
    var_31 = var_30 / 1600;

    if(var_31 < var_28 - 0.025) {
      break;
    }

    var_22 = _func_0AF(var_31, 1.0);
    var_32 = var_29 + var_1._id_0117 _meth_833D() * var_22;
    var_1.forward_dir = vectorNormalize(var_32 - var_1.origin);
    var_1.angles = hammer_modelangles_fromdir(var_1.forward_dir);
    var_1 _meth_82B1(var_32, var_31);
    var_1 _id_0378::_id_8D74("dlc4_hammer_catch", var_1.origin, var_30);
    wait(var_28);
  }

  var_1.tag_tracker delete();
  var_1._id_95AB delete();
  var_1 delete();
  var_33 = 4;
  var_0 notify("hammer_release_melee_lock");
  var_0 _meth_82FF("ui_show_scorestreak_training_hud", 1);
  wait(var_33);
  var_34 = var_0 test_raven_weapon_owner();
  var_0.hammer_throw_on_cooldown = 0;

  if(_id_0547::_id_5565(var_34, "hammer_emp")) {
    _id_0548::_id_3AC1(var_0, "zom_hammer_grenade_zm");
    var_0 thread spawn_hammer_full_fx();
  }
}

spawn_hammer_full_fx() {
  if(has_hammer_emp() && !isDefined(self.stormhammerchargedfx)) {
    self.stormhammerchargedfx = _func_2A9(common_scripts\utility::_id_44F5("zmb_storm_hammer_gem_charge_vm"), self, "TAG_FX", self, 1);
    _func_14C(self.stormhammerchargedfx);
    self.stormhammerchargedfx _id_0378::_id_8D74("aud_hammer_emp_charged");
    self.stormhammerchargedfx thread _id_0547::_id_2D19(self);
    maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.stormhammerchargedfx);
  }

  thread hammer_lost_delete_fx();
}

hammer_lost_delete_fx() {
  while(isDefined(self) && has_hammer_emp())
    waitframe();

  if(isDefined(self))
    delete_hammer_full_fx();
}

delete_hammer_full_fx() {
  if(isDefined(self.stormhammerchargedfx))
    self.stormhammerchargedfx delete();
}

hammer_handle_melee_attack() {
  _id_0586::_id_0790("zom_dlc4_hammer_emp_zm");
  self.raven_hammer_in_air = 1;

  if(self _meth_8319(self.weapon_previous_to_hammer))
    self switchtoweapon(self.weapon_previous_to_hammer);
  else
    self switchtoweapon(self getweaponlistprimaries()[0]);

  common_scripts\utility::_id_A70A("hammer_release_melee_lock", "death");
  var_0 = test_raven_weapon_owner();

  if(_id_0547::_id_5565(var_0, "hammer_emp")) {
    _id_0586::_id_078C("zom_dlc4_hammer_emp_zm");
    self switchtoweapon("zom_dlc4_hammer_emp_zm");
  }

  self.raven_hammer_in_air = 1;
  self.weapon_previous_to_hammer = undefined;
}

hammer_replace_projectile_with_model(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("npc_gen_sledgehammer_zom");
  var_1.forward_dir = (0, 0, 1);
  var_1.angles = var_0 _meth_8566() + (90, 0, 0);
  var_1._id_95AB = spawn("script_model", var_1.origin);
  var_1._id_95AB setModel("tag_origin");
  var_1.tag_tracker = spawn("script_model", var_1.origin);
  var_1.tag_tracker setModel("tag_origin");
  var_1.tag_tracker.angles = var_0 _meth_8566();
  self delete();
  return var_1;
}

hammer_modelangles_fromdir(var_0) {
  var_1 = vectortoangles(var_0) + (90, 0, 0);
  return var_1;
}

hammer_choose_target() {
  var_0 = self;
  return var_0.pottargets[0];
}

hammer_rank_targets() {
  var_0 = self;

  if(!isDefined(var_0.pottargets))
    var_0.pottargets = [];

  if(!isDefined(var_0.pottargetscores))
    var_0.pottargetscores = [];

  var_1 = 100000000;

  for(var_2 = 0; var_2 < 2; var_2++) {
    var_0.pottargetscores[var_2] = var_1;
    var_0.pottargets[var_2] = undefined;
  }

  var_3 = var_0 _id_0586::_id_43F1(var_0.origin, var_0.forward_dir, 1200, 30);

  foreach(var_5 in var_3) {
    var_6 = var_5._id_8302;
    var_7 = sqrd_dist_between_segments(var_0.tag_tracker.origin, var_0.tag_tracker.end_point, var_5.origin, var_5.origin + (0, 0, var_6));
    var_8 = var_7[1] - var_0.tag_tracker.origin;
    var_9 = var_7[2] - var_0._id_0117.origin;
    var_10 = vectordot(var_9, var_9);

    if(var_10 < var_0.pottargetscores[0]) {
      var_0.pottargetscores[1] = var_0.pottargetscores[0];
      var_0.pottargets[1] = var_0.pottargets[0];
      var_0.pottargetscores[0] = var_10;
      var_0.pottargets[0] = var_5;
      continue;
    }

    if(var_10 < var_0.pottargetscores[1]) {
      var_0.pottargetscores[1] = var_10;
      var_0.pottargets[1] = var_5;
    }
  }
}

hammer_do_flight_damage(var_0, var_1) {
  if(_id_0547::_id_5565(var_0.temporary_hammer_flight_imunity, 1)) {
    return;
  }
  if(isDefined(var_0._id_0A4B)) {
    var_2 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(_id_0547::_id_5565(var_0.isforceshieldactive, 1)) {
      var_0 maps\mp\zombies\zombie_king::break_force_shield();

      if(isDefined(var_2) && common_scripts\utility::_id_562E(var_2.knockbyravensword))
        _id_0547::_id_7D1B(self, var_0, "far", self._id_0117);

      var_0 thread hammer_set_temp_immunity();
      var_0 _id_0378::_id_8D74("zmb_HAMMER_throw_hit_metal");
    } else {
      if(isDefined(var_2) && common_scripts\utility::_id_562E(var_2.knockbyravensword))
        _id_0547::_id_7D1B(self, var_0, "close", self._id_0117);

      var_0 thread hammer_set_temp_immunity();
      var_0 _meth_8059(level.hammerthrowdamage, var_1, self._id_0117, self._id_0117, "MOD_EXPLOSIVE", "zom_hammer_grenade_zm");
      var_0 _id_0378::_id_8D74("zmb_HAMMER_throw_hit_metal");
    }
  }
}

hammer_set_temp_immunity() {
  self endon("death");
  self.temporary_hammer_flight_imunity = 1;
  wait 0.85;
  self.temporary_hammer_flight_imunity = undefined;
}

hammer_test_impact(var_0) {
  if(!_func_07E(self.origin, var_0, 0, self)) {
    var_1 = bulletTrace(self.origin, var_0, 0, self, 1);
    return var_1;
  }

  return undefined;
}

hammer_throw_arm() {
  self endon("death");
  self.isarmed = 0;
  wait 0.15;
  self.isarmed = 1;
}

hammer_throw_end() {
  self endon("death");
  self.inflight = 1;
  wait 2;
  self.inflight = 0;
}

hammer_detonate() {
  self endon("death");
  self notify("detonate");
  waitframe();
}

hammer_detonate_on_death(var_0) {
  self waittill("detonate");
  hammer_detonate_attack(self.origin, var_0);
}

hammer_detonate_attack(var_0, var_1) {
  playFX(common_scripts\utility::_id_44F5("zmb_storm_hammer_lightning"), var_0);
  _id_0378::_id_8D74("aud_hammer_lightning", var_0);
  wait 0.25;
  playFX(common_scripts\utility::_id_44F5("zmb_storm_hammer_impact"), var_0);
  var_2 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);
  var_3 = _id_0547::_id_408F();
  var_3 = _func_1AC(var_3, var_0, 92);

  foreach(var_5 in var_3) {
    if(distance(var_0, var_5.origin) < 92) {
      if(_id_0547::_id_5565(var_5.isforceshieldactive, 1)) {
        var_5 maps\mp\zombies\zombie_king::break_force_shield();
        var_6 = _id_0547::_id_0A51(var_5._id_0A4B);

        if(isDefined(var_6) && common_scripts\utility::_id_562E(var_6.knockbyravensword))
          _id_0547::_id_7D1B(var_1, var_5, "close");

        continue;
      }

      if(level.hammerthrowburstdamage > var_5.health) {
        var_5 _id_0547::_id_5A85(var_5.origin, var_0 - var_5.origin);
        continue;
      }

      if(isDefined(level.ravenweaponmanager["hammer_emp"]._id_0117))
        var_5 _meth_8059(level.hammerthrowburstdamage, var_0, level.ravenweaponmanager["hammer_emp"]._id_0117, level.ravenweaponmanager["hammer_emp"]._id_0117, "MOD_MELEE", "hammer_cleave_zm", "none");
      else
        var_5 _meth_8059(level.hammerthrowburstdamage, var_0, undefined, undefined, "MOD_MELEE", "hammer_cleave_zm", "none");

      if(isDefined(var_5._id_0A4B)) {
        var_6 = _id_0547::_id_0A51(var_5._id_0A4B);

        if(isDefined(var_6) && common_scripts\utility::_id_562E(var_6.knockbyravensword))
          _id_0547::_id_7D1B(var_1, var_5, "close");
      }
    }
  }

  waitframe();
  _func_175(var_0, 128, 50, 3.5);
}

hammer_throw_toggle_equip() {
  if(!isDefined(self._dlc4_weapon_manager))
    self._dlc4_weapon_manager = [];

  var_0 = "zom_dlc4_hammer_emp_zm";
  var_1 = "zom_hammer_grenade_zm";

  while(isDefined(self) && has_hammer_emp()) {
    self waittill("weapon_change", var_2);

    while(isDefined(self._dlc4_weapon_manager["special_grenade"]) && self._dlc4_weapon_manager["special_grenade"] != "zom_hammer_grenade_zm")
      waitframe();

    if(self _meth_8317() == var_0) {
      if(!self _meth_8319("zom_hammer_grenade_zm"))
        hammer_throw_give_grenade();

      continue;
    }

    if(self _meth_8319("zom_hammer_grenade_zm")) {
      hammer_throw_take_grenade();
      thread delete_hammer_full_fx();
    }
  }

  if(isDefined(self) && self _meth_8319("zom_hammer_grenade_zm")) {
    hammer_throw_take_grenade();
    thread delete_hammer_full_fx();
  }
}

hammer_throw_give_grenade() {
  if(!isDefined(self._dlc4_weapon_manager))
    self._dlc4_weapon_manager = [];

  var_0 = "zom_hammer_grenade_zm";

  while(self _meth_8126())
    waitframe();

  var_1 = self _meth_834A();

  if(!raven_weapon_check_if_special_grenade(var_1)) {
    self._dlc4_weapon_manager["stored_lethal"] = var_1;
    self._dlc4_weapon_manager["stored_lethal_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_lethal"]);
  }

  _id_0586::_id_0790(var_1);
  self _meth_8349(var_0);
  self._dlc4_weapon_manager["special_grenade"] = "zom_hammer_grenade_zm";
  _id_0586::_id_078C(var_0);

  if(_id_0547::_id_5565(self.hammer_throw_on_cooldown, 1))
    self setweaponammoclip(var_0, 0);
  else {
    _id_0548::_id_3AC1(self, "zom_hammer_grenade_zm");
    thread spawn_hammer_full_fx();
  }
}

hammer_throw_take_grenade() {
  _id_0586::_id_0790("zom_hammer_grenade_zm");

  if(isDefined(self._dlc4_weapon_manager["stored_lethal"])) {
    self _meth_8349(self._dlc4_weapon_manager["stored_lethal"]);
    self setweaponammoclip(self._dlc4_weapon_manager["stored_lethal"], self._dlc4_weapon_manager["stored_lethal_ammo"]);

    if(self._dlc4_weapon_manager["stored_lethal"] != "none") {
      _id_0586::_id_078C(self._dlc4_weapon_manager["stored_lethal"]);
      self setweaponammoclip(self._dlc4_weapon_manager["stored_lethal"], self._dlc4_weapon_manager["stored_lethal_ammo"]);
      self._dlc4_weapon_manager["stored_lethal"] = undefined;
      self._dlc4_weapon_manager["stored_lethal_ammo"] = undefined;
    } else
      self setweaponammostock(self._dlc4_weapon_manager["stored_lethal"], 0);
  } else {
    var_0 = maps\mp\_utility::_id_44CD(self._id_90E4._id_37FE);
    self _meth_8349(var_0);
    var_1 = _func_1A3(var_0, self);
    self setweaponammoclip(var_0, var_1);
  }

  if(_id_0547::_id_5565(self._dlc4_weapon_manager["special_grenade"], "zom_hammer_grenade_zm"))
    self._dlc4_weapon_manager["special_grenade"] = undefined;

  thread raven_weapon_prevent_free_grenades();
}

hammer_emp_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8661())
    return 0;

  return level.hammerempdamage;
}

hammer_emp_melee_cone(var_0) {
  self endon("melee_ability_interrupt");
  var_1 = _id_0586::zombies_hit_by_melee_cone(225, 100);
  var_2 = _id_0586::zombies_hit_by_melee_cone(64, 12);
  var_2 = _func_1AC(var_2, self.origin);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 > 3) {
      break;
    }

    childthread delayed_hammer_emp_sweet_hit(var_2[var_3], var_3);
    var_1 = common_scripts\utility::_id_0F93(var_1, var_2[var_3]);
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    childthread delayed_hammer_emp_hit(var_1[var_3], var_3);

  var_4 = common_scripts\utility::_id_44F5("zmb_storm_hammer_knockback");
  playFX(var_4, self.origin + (0, 0, 50), anglesToForward(self.angles));
  _id_0378::_id_8D74("zmb_sword_aoe", self.origin);
}

delayed_hammer_emp_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  var_3 = spawnStruct();
  var_3.player = self;
  var_3._id_ABE6 = var_0.origin;
  var_3._id_4DCF = "none";
  var_3._id_60B8 = undefined;
  var_3._id_01D0 = "hammer_cleave_zm";
  var_3.delaysec = undefined;

  if(var_0.health < level.hammercleavedamage)
    playFX(level._effect["zmb_storm_hmr_zmb_kill"], var_0.origin);

  var_0 _meth_8059(level.hammercleavedamage, self getEye(), self, self, "MOD_MELEE", "hammer_cleave_zm", "none");

  if(var_0._id_0A4B == "zombie_king")
    _func_147(level._effect["zmb_storm_hmr_godking_stun"], var_0, "TAG_ORIGIN");
  else
    _func_147(level._effect["zmb_storm_hmr_zmb_stun"], var_0, "TAG_ORIGIN");

  if(isDefined(var_0._id_0A4B)) {
    var_4 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_4) && common_scripts\utility::_id_562E(var_4.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "medium");
  }
}

delayed_hammer_emp_sweet_hit(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  var_3 = spawnStruct();
  var_3.player = self;
  var_3._id_ABE6 = var_0.origin;
  var_3._id_4DCF = "none";
  var_3._id_60B8 = undefined;
  var_3._id_01D0 = "hammer_cleave_zm";
  var_3.delaysec = undefined;
  _id_0378::_id_8D74("zmb_HAMMER_melee_hit_metal", var_3);

  if(var_0.health < level.hammercleavedamage)
    playFX(level._effect["zmb_storm_hmr_zmb_kill"], var_0.origin);

  var_0 _meth_8059(level.hammersweetcleavedamage, self getEye(), self, self, "MOD_MELEE", "hammer_cleave_zm", "none");
  _func_147(level._effect["zmb_hammer_smack"], var_0, "TAG_EYE");

  if(isDefined(var_0._id_0A4B)) {
    var_4 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_4) && common_scripts\utility::_id_562E(var_4.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "close");
  }
}

moonorb_init() {
  if(!isDefined(level.currentconverts))
    level.currentconverts = 0;

  level.moonorb_safe_vols = getEntArray("vol_moonorb_safe", "targetname");
  level.moonorb_bad_vols = getEntArray("vol_moonorb_bad", "targetname");
  level thread maps\mp\_utility::_id_6F74(::notify_moonorb_fired);
  level thread maps\mp\_utility::_id_6F74(::notify_moonorb_current_manager);
}

notify_moonorb_fired() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "zom_moonorb_grenade_zm" || var_1 == "zom_moonorb_grenade_emp_zm") {
      self.zoneonmoonorbthrow = _id_055A::_id_462D();
      thread handle_moonorb_state_change("fired", var_1, 0);

      if(var_1 == "zom_moonorb_grenade_zm") {
        var_0 thread moonorb_register_active(self);
        continue;
      }

      var_0 thread moonorb_register_active(self, 1);
    }
  }
}

handle_moonorb_state_change(var_0, var_1, var_2) {
  if(!_id_0547::_id_5565("zom_moonorb_grenade_zm", var_1)) {
    return;
  }
  if(var_2) {
    return;
  }
  return;
}

set_fx(var_0, var_1) {
  if(isDefined(self.fx))
    self.fx delete();

  if(!isDefined(var_1))
    var_1 = "tag_fx";

  self._id_3F74 = var_0;
  self.fx = _func_2A8(common_scripts\utility::_id_44F5(var_0), self, var_1);
  _func_14C(self.fx);

  if(_func_1EF(self))
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fx);
  else
    self.fx thread _id_0547::_id_2D19(self);
}

moonorb_register_active(var_0, var_1) {
  level.moon_orb_manager["moonscepter_orb_active"] = self;

  if(_id_0547::_id_5565(var_1, 1))
    self.is_empowered = 1;

  self.owner_first = var_0;
  moonorb_active_think(var_1);
  level.moon_orb_manager["moonscepter_orb_active"] = undefined;
}

moonorb_active_think(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_1.last_safe_pos = var_1.origin;
  var_7 = level.moon_orb_manager["moonscepter_owner"];

  if(isDefined(var_7) && isPlayer(var_7)) {
    var_7 setweaponammostock(var_7 _meth_82D5(), 0);
    var_7 setweaponammoclip(var_7 _meth_82D5(), 0);
  }

  if(_id_0547::_id_5565(var_0, 1))
    var_8 = "zom_moonorb_grenade_emp_zm";
  else
    var_8 = "zom_moonorb_grenade_zm";

  var_1 notify("new_moonorb_tracking");
  var_1 endon("new_moonorb_tracking");
  var_1 thread moonorb_safe_vol_track();
  var_1 thread moonorb_test_orrery_distance();

  while(isDefined(var_1)) {
    var_1 thread moonorb_air_timeout();
    var_1 thread moonorb_set_cooktime();
    var_9 = var_1 common_scripts\utility::_id_A717("air_timeout", "missile_stuck", "orb_teleport_request", "orb_control_request", "ee_moonorb_collected", "moonorb_near_orrery", "moonorb_trial_end_stagnate");
    var_10 = var_9[0];

    if(_id_0547::_id_5565(var_10, "missile_stuck") || _id_0547::_id_5565(var_10, "moonorb_near_orrery")) {
      var_2 = var_1 moonorb_replace_projectile_with_model();
      level.moon_orb_manager["moonscepter_orb_active"] = var_2;

      if(isDefined(var_9[1]) && _func_1EF(var_9[1]) && var_9[1].health > 0) {
        var_3 = var_9[1];
        var_2 _meth_8055(var_9[1], var_9[1] get_closest_tag_from_array(var_2.origin, ["tag_origin", "tag_eye", "J_Head", "J_Hip_RI", "J_Hip_LE", "J_Knee_LE", "J_Knee_RI", "J_SpineLower", "J_SpineUpper", "J_Shoulder_RI", "J_Shoulder_LE", "J_MainRoot"]));
      } else if(var_10 == "moonorb_near_orrery") {
        var_11 = common_scripts\utility::_id_8FFC();
        var_11.origin = common_scripts\utility::_id_46B5("moonraven_orrery_teleport_node", "targetname").origin;
        var_11 _meth_805B();
        var_2 linktosynchronizedparent(var_11, "TAG_ORIGIN");
        var_11 thread moonorb_orbit();
        var_2.istrialready = 1;
        var_12 = _func_382("zmb_moonorb_beam", var_2, "tag_origin", var_11, "tag_origin");
        var_11 thread _id_0547::_id_2D19(var_2);
        var_12 thread _id_0547::_id_2D19(var_2);
      } else {
        var_13 = bulletTrace(var_2.origin, var_2.origin + (0, 0, -1000), 0, var_2, 1, 0, 0, 0, 0, 0, 0);
        var_2 childthread _id_0547::obj_fall_onto_pos(var_13["position"]);
      }

      var_2 thread set_fx("zmb_moonorb_stuck");
      var_2 _id_0378::_id_8D74("aud_moonorb_stuck");
      var_2 thread moonorb_stuck_wait();
      var_2.stuck = 1;
      var_7 = level.moon_orb_manager["moonscepter_owner"];

      if(isDefined(var_7) && isPlayer(var_7)) {
        if(_id_0547::_id_5565(var_0, 1)) {
          if(isDefined(var_9[1]) && _func_1EF(var_9[1]) && !common_scripts\utility::_id_562E(var_7.has_shown_spike_emp_control_hint)) {
            var_7.has_shown_spike_emp_control_hint = 1;
            _id_0555::_id_83DD("dlc4_weap_hint_spike_emp_control", var_7);
          } else if(!common_scripts\utility::_id_562E(var_7.has_shown_spike_emp_tele_hint)) {
            var_7.has_shown_spike_emp_tele_hint = 1;
            _id_0555::_id_83DD("dlc4_weap_hint_spike_teleport", var_7);
          }
        } else if(!common_scripts\utility::_id_562E(var_7.has_shown_spike_tele_hint)) {
          var_7.has_shown_spike_tele_hint = 1;
          _id_0555::_id_83DD("dlc4_weap_hint_spike_teleport", var_7);
        }
      }

      var_9 = var_2 common_scripts\utility::_id_A717("orb_stagnate_timeout", "orb_teleport_request", "orb_control_request", "moonorb_trial_end_stagnate");
      var_10 = var_9[0];
      var_2 notify("orb_stagnate_cancel");
    }

    if(isDefined(var_2))
      var_1 = var_2;

    if(_id_0547::_id_5565(var_0, 1) && (_id_0547::_id_5565(var_10, "orb_control_request") || _id_0547::_id_5565(var_10, "orb_stagnate_timeout"))) {
      var_14 = playFX(common_scripts\utility::_id_44F5("moonorb_control_burst"), var_1.origin, anglesToForward(var_1.angles));
      var_14 _id_0378::_id_8D74("aud_moonorb_control_burst");
      var_15 = _id_0547::_id_408F();
      var_15 = _func_1AC(var_15, var_1.origin, 128, 1);

      for(var_16 = 0; var_16 < var_15.size; var_16++) {
        if(level.currentconverts >= 10 || var_16 >= 3 || !var_15[var_16] isvalidmoonorbtarget()) {
          continue;
        }
        if(common_scripts\utility::_id_302B(var_15[var_16].origin, var_1.origin)) {
          if(moonorb_zombieishittable(var_15[var_16], var_1.origin)) {
            if(isDefined(level.currentconverts) && level.currentconverts < 10)
              var_15[var_16] thread moonorb_mind_control();
          }
        }
      }
    } else if(_id_0547::_id_5565(var_10, "orb_teleport_request") && isDefined(level.moon_orb_manager["moonscepter_owner"]) && isPlayer(level.moon_orb_manager["moonscepter_owner"])) {
      var_1 thread set_fx("zmb_moonorb_stuck");
      var_17 = undefined;

      if(var_7 moonorb_player_busy())
        var_17 = [0];
      else if(_id_0547::_id_5565(var_1.istrialready, 1)) {
        var_7 = level.moon_orb_manager["moonscepter_owner"];
        var_7 _id_0378::_id_8D74("aud_moonraven_enter_trial");
        var_18 = common_scripts\utility::_id_46B5("zombie_warp_moon_trial", "targetname");
        var_12 = _func_382("zmb_moonorb_beam", var_1, "tag_origin", var_7, "tag_weapon_right");
        var_7 moon_orb_play_screen_fx();
        wait 0.25;

        if(isDefined(var_12))
          var_12 delete();

        var_19 = spawnStruct();
        var_19.origin = var_7.origin;
        var_19.angles = var_7.angles;
        var_7.old_destination = var_19;
        var_7 setOrigin(var_18.origin, 1);
        common_scripts\utility::flag_set("moon_trial_entered");
        var_7 thread maps\mp\mp_zombie_descent_ee_main::run_weapon_ritual("zom_dlc4_spike_zm");
        var_1 delete();
        return;
      } else if(isDefined(var_3)) {
        var_20 = moon_orb_head_bump_test(var_3.origin);

        if(var_3 moonorb_zombie_touching_vol() && common_scripts\utility::_id_562E(var_20[0]))
          var_17 = [1, var_20[1]];
        else
          var_17 = var_1 moon_orb_teleport_validation(level.moon_orb_manager["moonscepter_owner"]);
      } else
        var_17 = var_1 moon_orb_teleport_validation(level.moon_orb_manager["moonscepter_owner"]);

      if(isDefined(var_17)) {
        if(isDefined(var_17[0]))
          var_4 = var_17[0];

        if(isDefined(var_17[1]))
          var_5 = var_17[1];
      }

      if(common_scripts\utility::_id_562E(var_4))
        level.moon_orb_manager["moonscepter_owner"] do_moon_orb_teleportation(var_5, var_1, var_3, var_8);
      else {
        var_21 = playFX(common_scripts\utility::_id_44F5("zmb_moonorb_suck"), var_1.origin, anglesToForward(var_1.angles));
        var_21 _id_0378::_id_8D74("aud_moonorb_orphaned_lp");
        var_6 = 1;
      }
    } else {
      var_21 = playFX(common_scripts\utility::_id_44F5("zmb_moonorb_suck"), var_1.origin, anglesToForward(var_1.angles));
      var_21 _id_0378::_id_8D74("aud_moonorb_orphaned_lp");
      var_6 = 1;
    }

    var_22 = 20;

    if(_id_0547::_id_5565(var_0, 1)) {
      var_22 = 10;
      var_7 _meth_82FF("ui_show_scorestreak_training_hud", 3);
    } else
      var_7 _meth_82FF("ui_show_scorestreak_training_hud", 2);

    if(common_scripts\utility::_id_562E(var_6))
      var_22 = 0.25;

    if(isDefined(var_1._id_95AB))
      var_1._id_95AB delete();

    var_1 delete();
    var_7 moonorb_cooldown(var_22);

    if(isDefined(level.moon_orb_manager["moonscepter_owner"])) {
      _id_0548::_id_3AC1(level.moon_orb_manager["moonscepter_owner"], var_8);
      var_7 = level.moon_orb_manager["moonscepter_owner"];
      var_7 setweaponammostock(var_7 _meth_82D5(), 1);
    }
  }
}

moonorb_cooldown(var_0) {
  level.moon_orb_manager["on_cooldown"] = 1;
  moonorb_wait_cooldown(var_0);
  level.moon_orb_manager["on_cooldown"] = undefined;
}

moonorb_wait_cooldown(var_0) {
  var_1 = self;
  var_1 endon("moonorb_force_cooldown_reset");
  wait(var_0);
}

moonorb_player_busy() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0.isbloodtubemoonorbblocked))
    return 1;

  return 0;
}

do_moon_orb_teleportation(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 endon("disconnect");
  playFX(level._effect["zmb_moonorb_tel_disappear"], var_4.origin + (0, 0, 48));
  playFX(level._effect["zmb_moonorb_suck"], var_1.origin);
  var_4 _id_0378::_id_8D74("aud_moonorb_teleport");
  var_5 = _func_382("zmb_moonorb_beam", var_1, "tag_origin", var_4, "tag_weapon_right");
  var_4 moon_orb_play_screen_fx();
  wait 0.25;

  if(isDefined(var_2) && isDefined(var_3)) {
    if(isDefined(var_2) && var_2 isvalidmoonorbtarget())
      var_2 _meth_8059(var_2.maxhealth + 666, var_4.origin, undefined, undefined, "MOD_EXPLOSIVE", var_3);
  }

  var_4 setOrigin(var_0);

  if(isDefined(self.wing_fx))
    thread maps\mp\zombies\zombie_king::spawn_wings();

  playFX(level._effect["zmb_moonorb_tel_appear"], var_4.origin + (0, 0, 48));
  var_4 childthread record_landing_zone();

  if(isDefined(var_5))
    var_5 delete();
}

moonorb_orbit() {
  self endon("death");
  var_0 = 10;

  for(;;) {
    self _meth_83E5((360, 360, 0), var_0);
    wait(var_0);
  }
}

isvalidmoonorbtarget() {
  var_0 = self;

  if(!isalive(var_0) || common_scripts\utility::_id_562E(var_0._id_2FDA) || isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_heavy" || isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_dlc4" || isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_fireman" || isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_heavy" || isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_treasurer" || isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_king")
    return 0;

  return 1;
}

record_landing_zone() {
  self endon("death");
  self endon("disconnect");
  waitframe();
  self.zoneonmoonorbland = _id_055A::_id_462D();
  self notify("zmb_moonraven_grenade_gap", self.zoneonmoonorbthrow, self.zoneonmoonorbland);
}

moonorb_safe_vol_track() {
  self endon("death");
  self notify("moonorb_safe_vol_start_track");
  self endon("moonorb_safe_vol_start_track");
  self.validposarray = [];

  for(;;) {
    var_0 = self.origin;

    foreach(var_2 in level.moonorb_safe_vols) {
      if(moonorb_vol_test(var_2)) {
        if(_func_2E6(_func_082(var_0, 64))) {
          self.last_safe_pos_touching = 1;
          self.last_safe_pos = var_0;
          moonorb_add_pos_to_valid_array(var_0);
        }
      }
    }

    waitframe();
  }
}

moonorb_vol_test(var_0) {
  if(self istouching(var_0)) {
    foreach(var_2 in level.moonorb_bad_vols) {
      if(self istouching(var_2))
        return 0;
    }

    return 1;
  }

  return 0;
}

moonorb_add_pos_to_valid_array(var_0) {
  if(self.validposarray.size == 0)
    self.validposarray[self.validposarray.size] = var_0;
  else if(!isDefined(common_scripts\utility::_id_0F7E(self.validposarray, var_0)))
    self.validposarray = common_scripts\utility::_id_0F86(self.validposarray, var_0, 0);

  if(self.validposarray.size > 100)
    self.validposarray = common_scripts\utility::_id_0F9A(self.validposarray, self.validposarray.size);
}

moonorb_test_orrery_distance() {
  self endon("death");
  self endon("moonorb_safe_vol_start_track");

  if(!common_scripts\utility::_id_3C77("moon_trial_unlocked") || common_scripts\utility::_id_3C77("moon_trial_complete")) {
    return;
  }
  var_0 = common_scripts\utility::_id_46B5("moonraven_orrery_teleport_node", "targetname");

  for(;;) {
    if(distance(self.origin, var_0.origin) < 44)
      self notify("moonorb_near_orrery");

    waitframe();
  }
}

moonorb_air_timeout() {
  self endon("air_timeout_skip");
  wait 3;
  self notify("air_timeout");
}

moonorb_set_cooktime() {
  self endon("death");
  self.is_cooking = 1;
  wait 0.25;
  self.is_cooking = 0;
}

moonorb_replace_projectile_with_model() {
  var_0 = spawn("script_model", self.origin);

  if(_id_0547::_id_5565(self.is_empowered, 1))
    var_0 setModel("npc_zom_morningstar_grenade");
  else
    var_0 setModel("npc_zom_morningstar_grenade");

  if(isDefined(self.last_safe_pos_touching))
    var_0.last_safe_pos_touching = self.last_safe_pos_touching;

  if(isDefined(self.last_safe_pos))
    var_0.last_safe_pos = self.last_safe_pos;

  if(isDefined(self.validposarray))
    var_0.validposarray = self.validposarray;

  var_0._id_95AB = spawn("script_model", var_0.origin);
  var_0._id_95AB setModel("tag_origin");
  var_0._id_95AB.angles = (-90, 0, 0);
  self delete();
  return var_0;
}

get_closest_tag_from_array(var_0, var_1) {
  var_2 = 0;
  var_3 = 100000;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = self _meth_8445(var_6);

    if(!common_scripts\utility::_id_562E(var_7)) {
      continue;
    }
    var_8 = self gettagorigin(var_6);
    var_2 = distance(var_8, var_0);

    if(var_2 < var_3) {
      var_4 = var_6;
      var_3 = var_2;
    }

    if(var_2 < 1) {
      break;
    }
  }

  return var_4;
}

moonorb_stuck_wait() {
  self endon("orb_stagnate_cancel");
  wait 5;
  self notify("orb_stagnate_timeout");
}

moonorb_mind_control() {
  self endon("moon_control_end");
  self endon("death");
  maps\mp\agents\_agent_utility::_id_83FE("allies");
  self.ismooncontrolled = 1;
  self.nomutilate = 1;
  self.ispassiveexempt = 1;
  thread moonorb_mind_control_fx();
  level thread moonorb_onzombiedeath(self);
  self.modifyagentdamage = ::moonorb_modify_minion_agent_damage;
  self._id_6816 = 1;
  var_0 = 0;
  wait 10;

  while(common_scripts\utility::_id_562E(self.stall_mc_death))
    waitframe();

  self notify("kill_moonzombie_listener");
  level.currentconverts--;
  self.ismooncontrolled = 0;

  while(isalive(self)) {
    if(_id_0547::_id_5565(self.isforceshieldactive, 1))
      maps\mp\zombies\zombie_king::break_force_shield();

    if(common_scripts\utility::_id_562E(self._id_480F))
      self._id_480F = 0;

    if(self _meth_85F0())
      self _meth_84C0(0);

    if(common_scripts\utility::_id_562E(self._id_2FDA))
      self suicide();
    else
      self _meth_8059(self._id_0008 + 666, self.origin, undefined, undefined, "MOD_ENERGY", "zom_moonorb_grenade_zm");

    wait 1;
  }
}

moonorb_zombieishittable(var_0, var_1) {
  if(var_0.origin[2] <= var_1[2])
    return _func_07E(var_0.origin + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0) && _func_07E(var_1 + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0);
  else
    return _func_07E(var_1 + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0) && _func_07E(var_0.origin + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0);
}

moonorb_onzombiedeath(var_0) {
  var_0 endon("kill_moonzombie_listener");
  level.currentconverts++;
  var_0 waittill("death");
  level.currentconverts--;
}

moonorb_mind_control_fx(var_0) {
  self endon("death");

  if(isDefined(self.mooncontrolledfx))
    self.mooncontrolledfx delete();

  if(isDefined(self.darkhostfx)) {
    return;
  }
  self.mooncontrolledfx = _func_2A8(common_scripts\utility::_id_44F5("moonorb_control"), self, "j_head", 1);
  _func_14C(self.mooncontrolledfx);
  self.mooncontrolledfx thread _id_0547::_id_2D19(self);
  self.mooncontrolledfx thread _id_0547::_id_2D20(self, "dark_host_fx_update");

  if(common_scripts\utility::_id_562E(var_0)) {
    return;
  }
  _id_0378::_id_8D74("aud_moonorb_control_lp");
}

notify_moonorb_current_manager() {
  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(var_0 != "zom_dlc4_spike_zm") {
      thread handle_moonorb_state_change("switching to other weapon", self getcurrentweapon(), 0);
      continue;
    } else
      thread handle_moonorb_state_change("switching to loaded sawgun", var_0, 1);
  }
}

moonorb_modify_minion_agent_damage(var_0, var_1) {
  if(isDefined(var_1) && common_scripts\utility::_id_562E(var_1.ismooncontrolled)) {
    if(_id_0547::_id_5565(self._id_0A4B, "zombie_generic") || _id_0547::_id_5565(self._id_0A4B, "zombie_berserker")) {
      self.ismooncontrolled = 1;
      return self.health + 666;
    } else if(_id_0547::_id_5565(self._id_0A4B, "zombie_exploder")) {
      if(self.health <= self.maxhealth / 3)
        self.ismooncontrolled = 1;

      return self.maxhealth / 3;
    } else if(_id_0547::_id_5565(self._id_0A4B, "zombie_heavy") || _id_0547::_id_5565(self._id_0A4B, "zombie_assassin")) {
      if(self.health <= self.maxhealth / 5)
        self.ismooncontrolled = 1;

      return self.maxhealth / 5;
    }
  }

  return var_0;
}

moonorb_zombie_touching_vol() {
  foreach(var_1 in level.moonorb_safe_vols) {
    if(self istouching(var_1))
      return 1;
  }

  return 0;
}

moon_orb_teleport_validation(var_0) {
  if(!isDefined(var_0) || !isPlayer(var_0) || !isalive(var_0))
    return [0];

  var_1 = [0];
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 228;
  var_6 = self;

  foreach(var_12, var_8 in var_6.validposarray) {
    var_9 = var_6.validposarray[var_12];
    var_1 = moon_orb_head_bump_test(var_9);

    if(var_1[0] == 1) {
      var_2 = 1;
      var_10 = var_1[1];

      if(_func_21B(var_9, _func_18E("zone_crash", "targetname"))) {
        var_11 = undefined;
        var_11 = _func_082(var_9, 64);

        if(distance(var_9, var_11) > var_5)
          var_4 = var_11 + (0, 0, var_5);
        else
          var_4 = var_10;
      } else
        var_4 = var_10;
    }

    if(common_scripts\utility::_id_562E(var_2) && isDefined(var_4)) {
      var_1 = [1, var_4];
      break;
    } else {}
  }

  return var_1;
}

is_false(var_0) {
  return isDefined(var_0) && !var_0;
}

moon_orb_head_bump_test(var_0) {
  var_1 = 64;
  var_2 = 32;
  var_3 = 0;
  var_4 = [0];

  if(isDefined(var_0)) {
    for(var_5 = 0; var_5 < 2; var_5++) {
      if(!isDefined(var_3))
        var_3 = 0;

      var_6 = var_0 - (0, 0, var_3);
      var_7 = _func_293(var_6 + (0, 0, 2), var_2, var_1, level.moon_orb_manager["moonscepter_orb_active"], 0, 1, 1);

      if(common_scripts\utility::_id_562E(var_7)) {
        var_4 = [1, var_6];
        break;
      } else {
        var_8 = _func_081(var_6, var_6 + (0, 0, var_1), level.moon_orb_manager["moonscepter_orb_active"]);
        var_9 = distance(var_8, var_6);
        var_3 = var_1 - var_9;
      }
    }
  }

  return var_4;
}

moon_orb_play_screen_fx() {
  level thread common_scripts\_exploder::_id_088E(216, [self]);
}

spike_init() {
  level.zombiemeleeweapon["zom_dlc4_spike_zm"] = 1;
  level._id_62B3["zom_dlc4_spike_zm"] = ::spike_modify_damage;
  level._id_A9C8["zom_dlc4_spike_zm"] = ::spike_heavy_melee_fatal;
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
  level._id_6DF9["default"]["zom_dlc4_spike_zm"] = var_3;
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
  level._id_6DF9["heavy"]["zom_dlc4_spike_zm"] = var_3;
  setup_melee_weapon_ownership(::has_spike_weapon, ::spike_gained, ::spike_lost);
}

give_spike_weapon() {
  try_drop_old_weapon("spike");

  if(!_id_0547::_id_73F9(self, "zom_dlc4_spike_zm")) {
    _id_0586::_id_078C("zom_dlc4_spike_zm");
    self switchtoweapon("zom_dlc4_spike_zm");
  }

  thread wep_disco_protect("spike");
  thread wep_death_protect("spike");
  level.ravenweaponmanager["spike"]._id_0117 = self;
}

has_spike_weapon() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc4_spike_zm");
}

spike_gained() {
  level.moon_orb_manager["moonscepter_owner"] = self;
  thread spike_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_knife_hint)) {
    self.has_shown_knife_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_spike", self);
  }

  if(isDefined(level.ravenweaponmanager["spike"].on_gained_func))
    self[[level.ravenweaponmanager["spike"].on_gained_func]]();
}

spike_lost() {
  self notify(level.ravenweaponmanager["spike"].wep_loss_notify);
  level.moon_orb_manager["moonscepter_owner"] = undefined;
}

spike_think() {
  self endon(level.ravenweaponmanager["spike"].wep_loss_notify);
  thread spike_vision_think();
  thread moonorb_toggle_equip();
  childthread maps\mp\mp_zombie_descent_ee_main::moonraven_contellation_vision();
  waitframe();

  while(isDefined(self) && has_spike_weapon()) {
    var_0 = common_scripts\utility::_id_A715("lethal_pressed", "tactical_pressed");

    if(!isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || _id_0547::_id_5565(level.moon_orb_manager["moonscepter_orb_active"].is_cooking, 1)) {
      continue;
    }
    if(var_0 == "lethal_pressed")
      level.moon_orb_manager["moonscepter_orb_active"] notify("orb_teleport_request");

    waitframe();
  }
}

moonorb_toggle_equip(var_0) {
  if(!isDefined(self._dlc4_weapon_manager))
    self._dlc4_weapon_manager = [];

  var_1 = "zom_dlc4_spike_zm";

  if(_id_0547::_id_5565(var_0, 1))
    var_1 = "zom_dlc4_spike_emp_zm";

  var_2 = "zom_moonorb_grenade_zm";

  if(_id_0547::_id_5565(var_0, 1))
    var_2 = "zom_moonorb_grenade_emp_zm";

  while(isDefined(self) && has_spike_weapon() || has_spike_emp()) {
    common_scripts\utility::_id_A70A("weapon_change", "offhand_end");

    while(isDefined(self._dlc4_weapon_manager["special_grenade"]) && self._dlc4_weapon_manager["special_grenade"] != "zom_moonorb_grenade_zm") {
      waitframe();

      if(!(has_spike_weapon() || has_spike_emp()))
        continue;
    }

    if(self _meth_8317() == var_1) {
      if(!self _meth_8319(var_2))
        moonorb_give_grenade(var_0);

      continue;
    }

    if(self _meth_8319(var_2))
      moonorb_take_grenade(var_0);
  }

  if(isDefined(self) && (self _meth_8319("zom_moonorb_grenade_zm") || self _meth_8319("zom_moonorb_grenade_emp_zm")))
    moonorb_take_grenade(var_0);
}

moonorb_give_grenade(var_0) {
  if(!isDefined(self._dlc4_weapon_manager))
    self._dlc4_weapon_manager = [];

  var_1 = "zom_moonorb_grenade_zm";

  if(_id_0547::_id_5565(var_0, 1))
    var_1 = "zom_moonorb_grenade_emp_zm";

  var_2 = self _meth_834A();

  if(!raven_weapon_check_if_special_grenade(var_2)) {
    self._dlc4_weapon_manager["stored_lethal"] = var_2;
    self._dlc4_weapon_manager["stored_lethal_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_lethal"]);
  }

  if(var_2 != var_1) {
    _id_0586::_id_0790(var_2);
    self _meth_8349(var_1);
  }

  if(_id_0547::_id_5565(var_0, 1)) {
    var_3 = self getoffhandsecondaryclass();

    if(!raven_weapon_check_if_special_grenade(var_2)) {
      self._dlc4_weapon_manager["stored_tactical"] = var_3;
      self._dlc4_weapon_manager["stored_tactical_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_tactical"]);
    }

    if(var_3 != var_1) {
      _id_0586::_id_0790(var_3);
      self setoffhandsecondaryclass(var_1);
    }
  }

  self._dlc4_weapon_manager["special_grenade"] = "zom_moonorb_grenade_zm";
  _id_0586::_id_078C(var_1);
  thread moonorb_handle_grenade_pickup(var_0, var_1);

  if(isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || common_scripts\utility::_id_562E(level.moon_orb_manager["on_cooldown"]))
    self setweaponammoclip(var_1, 0);
  else {
    self setweaponammoclip(self _meth_82D5(), 1);
    _id_0548::_id_3AC1(self, var_1);
  }

  thread raven_weapon_prevent_free_grenades();
}

moonorb_take_grenade(var_0) {
  if(_id_0547::_id_5565(var_0, 1)) {
    _id_0586::_id_0790("zom_moonorb_grenade_emp_zm");
    _id_0586::_id_0790("zom_moonorb_grenade_zm");
  } else
    _id_0586::_id_0790("zom_moonorb_grenade_zm");

  if(isDefined(self._dlc4_weapon_manager["stored_lethal"])) {
    if(self._dlc4_weapon_manager["stored_lethal"] != "none") {
      self _meth_8349(self._dlc4_weapon_manager["stored_lethal"]);
      _id_0586::_id_078C(self._dlc4_weapon_manager["stored_lethal"]);
      self setweaponammoclip(self._dlc4_weapon_manager["stored_lethal"], self._dlc4_weapon_manager["stored_lethal_ammo"]);
      self._dlc4_weapon_manager["stored_lethal"] = undefined;
      self._dlc4_weapon_manager["stored_lethal_ammo"] = undefined;
    } else {}
  } else {
    var_1 = maps\mp\_utility::_id_44CD(self._id_90E4._id_37FE);
    self _meth_8349(var_1);
    self setweaponammoclip(var_1, 0);
  }

  if(isDefined(self._dlc4_weapon_manager["stored_tactical"])) {
    if(self._dlc4_weapon_manager["stored_tactical"] != "none") {
      self setoffhandsecondaryclass(self._dlc4_weapon_manager["stored_tactical"]);
      _id_0586::_id_078C(self._dlc4_weapon_manager["stored_tactical"]);
      self setweaponammoclip(self._dlc4_weapon_manager["stored_tactical"], self._dlc4_weapon_manager["stored_tactical_ammo"]);
      self._dlc4_weapon_manager["stored_tactical"] = undefined;
      self._dlc4_weapon_manager["stored_tactical_ammo"] = undefined;
    } else {}
  } else {}

  if(_id_0547::_id_5565(self._dlc4_weapon_manager["special_grenade"], "zom_moonorb_grenade_emp_zm") || _id_0547::_id_5565(self._dlc4_weapon_manager["special_grenade"], "zom_moonorb_grenade_zm"))
    self._dlc4_weapon_manager["special_grenade"] = undefined;

  self setweaponammoclip(self _meth_82D5(), 0);
  thread raven_weapon_prevent_free_grenades();
  self notify("moonorb_taken");
}

raven_weapon_prevent_free_grenades() {
  self endon("disconnect");
  self endon("spawned");

  if(self _meth_8126()) {
    common_scripts\utility::_disableoffhandweapons();

    while(self _meth_8126())
      waitframe();

    common_scripts\utility::_id_0614();
  }
}

moonorb_handle_grenade_pickup(var_0, var_1) {
  self endon("moonorb_taken");

  for(;;) {
    self waittill("weapon_given");

    if(!self _meth_8319(var_1)) {
      var_2 = self _meth_834A();

      if(!raven_weapon_check_if_special_grenade(var_2) && var_2 != "none") {
        self._dlc4_weapon_manager["stored_lethal"] = var_2;
        self._dlc4_weapon_manager["stored_lethal_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_lethal"]);
        _id_0586::_id_0790(var_2);
      }

      if(var_2 != var_1)
        self _meth_8349(var_1);

      if(_id_0547::_id_5565(var_0, 1)) {
        var_3 = self getoffhandsecondaryclass();

        if(!raven_weapon_check_if_special_grenade(var_2) && var_3 != "none") {
          self._dlc4_weapon_manager["stored_tactical"] = var_3;
          self._dlc4_weapon_manager["stored_tactical_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_tactical"]);
          _id_0586::_id_0790(var_3);
        }

        if(var_3 != var_1)
          self setoffhandsecondaryclass(var_1);
      }

      _id_0586::_id_078C(var_1);

      if(isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || common_scripts\utility::_id_562E(level.moon_orb_manager["on_cooldown"]))
        self setweaponammoclip(var_1, 0);
      else
        self setweaponammoclip(var_1, 1);
    }
  }
}

spike_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.spikedamage;
}

spike_max_ammo_func(var_0) {
  return 1;
}

spike_heavy_melee_fatal(var_0) {
  return common_scripts\utility::_id_562E(self._id_165B) || self _meth_8343();
}

spike_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_spike_emp_zm"] = 1;
  level._id_62B3["zom_dlc4_spike_emp_zm"] = ::spike_emp_modify_damage;
  level._id_A9C8["zom_dlc4_spike_emp_zm"] = ::spike_emp_heavy_melee_fatal;
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
  level._id_6DF9["default"]["zom_dlc4_spike_emp_zm"] = var_3;
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
  level._id_6DF9["heavy"]["zom_dlc4_spike_emp_zm"] = var_3;
  setup_melee_weapon_ownership(::has_spike_emp, ::spike_emp_gained, ::spike_emp_lost);
  _id_0547::_id_7BA9(::spike_emp_on_zombie_killed);
}

give_spike_emp_weapon(var_0) {
  try_drop_old_weapon("spike_emp", var_0);
  waittillframeend;

  if(!_id_0547::_id_73F9(self, "zom_dlc4_spike_emp_zm")) {
    _id_0586::_id_078C("zom_dlc4_spike_emp_zm");
    self switchtoweapon("zom_dlc4_spike_emp_zm");
  }

  thread wep_disco_protect("spike_emp");
  thread wep_death_protect("spike_emp");
  level.ravenweaponmanager["spike_emp"]._id_0117 = self;
}

has_spike_emp() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc4_spike_emp_zm");
}

spike_emp_gained() {
  level.moon_orb_manager["moonscepter_owner"] = self;
  thread spike_emp_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_knife_emp_hint)) {
    self.has_shown_knife_emp_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_spike_emp", self);
  }

  if(isDefined(level.ravenweaponmanager["spike_emp"].on_gained_func))
    self[[level.ravenweaponmanager["spike_emp"].on_gained_func]]();
}

spike_emp_lost() {
  self notify(level.ravenweaponmanager["spike_emp"].wep_loss_notify);

  if(!_id_0547::_id_5565(level.ravenweaponmanager["spike"]._id_0117, level.moon_orb_manager["moonscepter_owner"]))
    level.moon_orb_manager["moonscepter_owner"] = undefined;
}

spike_emp_heavy_melee_fatal(var_0) {
  return common_scripts\utility::_id_562E(self._id_165B) || self _meth_8343();
}

spike_emp_think() {
  thread moonorb_toggle_equip(1);
  thread spike_vision_think();
  waitframe();

  while(has_spike_emp()) {
    var_0 = common_scripts\utility::_id_A715("lethal_pressed", "tactical_pressed");

    if(!isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || _id_0547::_id_5565(level.moon_orb_manager["moonscepter_orb_active"].is_cooking, 1) || _id_0547::_id_577E(self) || !isalive(self)) {
      continue;
    }
    if(var_0 == "lethal_pressed")
      level.moon_orb_manager["moonscepter_orb_active"] notify("orb_teleport_request");
    else if(var_0 == "tactical_pressed")
      level.moon_orb_manager["moonscepter_orb_active"] notify("orb_control_request");

    waitframe();
  }
}

spike_vision_think() {
  self notify("spike_vision_start");
  self endon("spike_vision_start");
  self endon("disconnect");

  for(;;) {
    if((self getcurrentweapon() == "zom_dlc4_spike_zm" || self getcurrentweapon() == "zom_dlc4_spike_emp_zm") && self _meth_8343() && !common_scripts\utility::_id_562E(self.spike_vision_enabled)) {
      self.spike_vision_enabled = 1;
      enable_moon_vision();
    } else if(!self _meth_8343() && common_scripts\utility::_id_562E(self.spike_vision_enabled) || self getcurrentweapon() != "zom_dlc4_spike_zm" && self getcurrentweapon() != "zom_dlc4_spike_emp_zm") {
      self.spike_vision_enabled = undefined;
      disable_moon_vision();
    }

    waitframe();

    while(self _meth_833B())
      waitframe();

    if(!_id_0547::_id_5565(level.ravenweaponmanager["spike"]._id_0117, self) && !_id_0547::_id_5565(level.ravenweaponmanager["spike_emp"]._id_0117, self)) {
      if(common_scripts\utility::_id_562E(self.spike_vision_enabled)) {
        self.spike_vision_enabled = undefined;
        disable_moon_vision();
      }

      return;
    }
  }
}

enable_moon_vision() {
  if(!common_scripts\utility::_id_562E(level._id_22F0) && !_id_0547::_id_5565(self.vision_blood_active, 1))
    self _meth_8483("mp_zombie_descent_moonravengreen", 0.05);
}

disable_moon_vision() {
  self _meth_8483("", 0.05);
}

spike_emp_on_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1 has_spike_emp()) {
    if(common_scripts\utility::_id_562E(self._id_0103))
      var_1 spike_emp_spec_effect();
  }
}

spike_emp_spec_effect() {
  var_0 = self;
  wait 1.38;

  if(var_0.health < var_0.maxhealth) {
    if(var_0.health + 10 <= var_0.maxhealth)
      var_0.health = var_0.health + 10;
    else
      var_0.health = var_0.maxhealth;

    var_0 notify("immediateHealthRegen");
  } else if(var_0 _id_0547::_id_73E9() < var_0 _id_0547::playergetmaxarmorcount()) {
    _func_14D(common_scripts\utility::_id_44F5("zmb_melee_drain_player"), var_0, "J_Spine4", var_0);
    _id_0378::_id_8D74("zmb_knife_finisher_effects");
    wait 0.2;
    var_0 _id_0547::_id_73AC(1);
  }
}

spike_emp_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.spikeempdamage;
}

scythe_init() {
  level.zombiemeleeweapon["zom_dlc4_scythe_zm"] = 1;
  level._id_62B3["zom_dlc4_scythe_zm"] = ::scythe_modify_damage;
  level.meleeaoeweapons["scythe_cleave_zm"] = 1;
  level._id_2FE9["zom_dlc4_scythe_zm"] = 1;
  level._id_4D3D["zom_dlc4_scythe_zm"] = 1;
  level._id_2FE9["scythe_cleave_zm"] = 1;
  level._id_4D3D["scythe_cleave_zm"] = 1;
  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (42.816, 5.533, 0);
  var_2 = length(var_1);
  setup_melee_weapon_ownership(::has_scythe, ::scythe_gained, ::scythe_lost);
}

give_scythe_weapon() {
  try_drop_old_weapon("scythe");

  if(!_id_0547::_id_73F9(self, "zom_dlc4_scythe_zm")) {
    _id_0586::_id_078C("zom_dlc4_scythe_zm");
    self switchtoweapon("zom_dlc4_scythe_zm");
  }

  thread wep_disco_protect("scythe");
  thread wep_death_protect("scythe");
  level.ravenweaponmanager["scythe"]._id_0117 = self;
}

getcurrentdlc4meleeweapon() {
  var_0 = self _meth_82D5();

  foreach(var_3, var_2 in level.ravenweaponmanager) {
    if(_id_0547::_id_5565(var_0, var_2._id_01D0))
      return var_3;
  }
}

has_scythe() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc4_scythe_zm");
}

scythe_gained() {
  thread scythe_think();

  if(!common_scripts\utility::_id_562E(self.has_shown_scythe_hint))
    self.has_shown_scythe_hint = 1;

  if(isDefined(level.ravenweaponmanager["scythe"].on_gained_func))
    self[[level.ravenweaponmanager["scythe"].on_gained_func]]();
}

scythe_lost() {
  self notify(level.ravenweaponmanager["scythe"].wep_loss_notify);
}

scythe_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8128() && !var_1 _meth_8661() && var_4 == "zom_dlc4_scythe_zm") {
    var_0.ignorethiszerodamage = 1;
    return 0;
  }

  return level.scythedamage;
}

scythe_think() {
  var_0 = setup_melee_abilityinfo("zom_dlc4_scythe_zm", 0.25, level.ravenweaponmanager["scythe"].wep_loss_notify, ::scythe_melee_cone, 0.7);
  thread run_melee_ability(var_0);
}

scythe_melee_cone(var_0) {
  self endon("melee_ability_interrupt");
  var_1 = _id_0586::zombies_hit_by_melee_cone(128, 100);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_scythe_hit1(var_1[var_2], var_2);

  _id_0378::_id_8D74("aud_zmb_scythe_swing");
  wait 0.65;
  var_1 = _id_0586::zombies_hit_by_melee_cone(128, 100);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_scythe_hit2(var_1[var_2], var_2);
}

delayed_scythe_hit1(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("aud_zmb_scythe_impact");
  var_0 _meth_8059(level.scythecleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_zm", "none");
  _func_147(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");
}

delayed_scythe_hit2(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("aud_zmb_scythe_impact");
  var_0 _meth_8059(level.scythecleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_zm", "none");
  _func_147(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbybladebarbarossa))
      _id_0547::_id_7D1B(self, var_0, "far");
  }
}

playzombiekilledbeamexplodefx() {
  var_0 = self gettagorigin("J_MainRoot");

  if(!isDefined(var_0))
    var_0 = self.origin;

  playFX(common_scripts\utility::_id_44F5("zmb_blood_blast"), var_0);
}

scythe_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_scythe_emp_zm"] = 1;
  level._id_62B3["zom_dlc4_scythe_emp_zm"] = ::scythe_emp_modify_damage;
  level._id_62B3["scythe_shard_zm"] = ::scythe_throw_modify_damage;
  level.meleeaoeweapons["scythe_cleave_emp_zm"] = 1;
  level._id_4D3D["zom_dlc4_scythe_emp_zm"] = 1;
  level._id_4D3D["scythe_cleave_emp_zm"] = 1;
  level._id_2FE9["zom_dlc4_scythe_emp_zm"] = 1;
  level._id_2FE9["scythe_cleave_emp_zm"] = 1;
  setup_melee_weapon_ownership(::has_scythe_emp, ::scythe_emp_gained, ::scythe_emp_lost);
  _id_0547::_id_7BA9(::scythe_emp_onenemykilled);
}

give_scythe_emp_weapon(var_0, var_1) {
  try_drop_old_weapon("scythe_emp", var_0, undefined, var_1);

  if(!_id_0547::_id_73F9(self, "zom_dlc4_scythe_emp_zm")) {
    _id_0586::_id_078C("zom_dlc4_scythe_emp_zm");
    self switchtoweapon("zom_dlc4_scythe_emp_zm");
  }

  thread wep_disco_protect("scythe_emp");
  thread wep_death_protect("scythe_emp");
  level.ravenweaponmanager["scythe_emp"]._id_0117 = self;
}

has_scythe_emp() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc4_scythe_emp_zm");
}

scythe_emp_gained() {
  thread scythe_emp_think();
  thread scythe_death_shield_enable();

  if(!common_scripts\utility::_id_562E(self.has_shown_scythe_emp_hint)) {
    self.has_shown_scythe_emp_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_scythe_emp_2", self);
  }
}

scythe_emp_lost() {
  self notify(level.ravenweaponmanager["scythe_emp"].wep_loss_notify);
}

scythe_emp_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8128()) {
    var_0.ignorethiszerodamage = 1;
    return 0;
  }

  return level.scytheempdamage;
}

scythe_throw_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return level.scythethrowdamage;
}

scythe_emp_think() {
  var_0 = setup_melee_abilityinfo("zom_dlc4_scythe_emp_zm", 0.25, level.ravenweaponmanager["scythe_emp"].wep_loss_notify, ::scythe_emp_melee_cone, 0.7);
  var_1 = setup_heavy_melee_abilityinfo("zom_dlc4_scythe_emp_zm", 0.25, level.ravenweaponmanager["scythe_emp"].wep_loss_notify, ::scythe_throw_blades, 0.25);
  thread run_melee_ability(var_0);
  thread run_heavy_melee_ability(var_1);
}

scythe_throw_blades(var_0) {
  if(!common_scripts\utility::_id_562E(self.has_shown_scythe_emp_blade_hint)) {
    self.has_shown_scythe_emp_blade_hint = 1;
    _id_0555::_id_83DD("dlc4_weap_hint_scythe_emp_1", self);
  }

  var_1 = anglesToForward(self _meth_8566() + (6, 6, 0));
  var_2 = anglesToForward(self _meth_8566());
  var_3 = anglesToForward(self _meth_8566() - (6, 6, 0));
  var_4 = _func_071("scythe_shard_zm", self getEye() + (3, 0, 0), vectorNormalize(var_1) * 1600, 10, self, 1, 1);
  var_5 = _func_071("scythe_shard_zm", self getEye(), vectorNormalize(var_2) * 1600, 10, self, 1, 1);
  var_6 = _func_071("scythe_shard_zm", self getEye() - (3, 0, 0), vectorNormalize(var_3) * 1600, 10, self, 1, 1);
  var_4._id_0117 = self;
  var_5._id_0117 = self;
  var_6._id_0117 = self;
  var_7 = [var_4, var_5, var_6];
  _id_0378::_id_8D74("aud_zmb_scythe_proj_shoot");

  foreach(var_9 in var_7) {
    var_9 thread scythe_shard_damage();
    var_9 _id_0378::_id_8D74("aud_zmb_scythe_proj_loop");
  }
}

scythe_shard_damage() {
  self waittill("explode", var_0);

  if(isDefined(var_0)) {
    playFX(level._effect["zmb_deathscythe_proj_exp"], var_0);
    _id_0378::_id_8D74("aud_zmb_scythe_proj_impact");
  }
}

scythe_emp_melee_cone(var_0) {
  self endon("melee_ability_interrupt");
  var_1 = _id_0586::zombies_hit_by_melee_cone(128, 100);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_emp_scythe_hit1(var_1[var_2], var_2);

  thread attempt_reflect_king_blast(128, 100);
  var_3 = common_scripts\utility::_id_44F5("zmb_death_scythe_knockback");
  playFX(var_3, self.origin + (0, 0, 50), anglesToForward(self.angles));
  _id_0378::_id_8D74("aud_zmb_scythe_emp_swing");
  wait 0.65;
  var_1 = _id_0586::zombies_hit_by_melee_cone(128, 100);
  var_1 = _func_1AC(var_1, self.origin);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    childthread delayed_emp_scythe_hit2(var_1[var_2], var_2);

  childthread attempt_reflect_king_blast(128, 100);
  var_3 = common_scripts\utility::_id_44F5("zmb_death_scythe_knockback_2");
  playFX(var_3, self.origin + (0, 0, 50), anglesToForward(self.angles));
}

attempt_reflect_king_blast(var_0, var_1) {
  var_2 = self;

  if(!isDefined(level.zombie_king)) {
    return;
  }
  if(!isDefined(level.zombie_king.current_blast)) {
    return;
  }
  if(!isDefined(level.zombie_king.current_blast._id_776C)) {
    return;
  }
  if(isDefined(level.zombie_king.current_blast._id_776C._id_0117) && isPlayer(level.zombie_king.current_blast._id_776C._id_0117)) {
    return;
  }
  var_3 = level.zombie_king.current_blast._id_776C;
  var_3 notify("blast_reflected");
  var_4 = 96;
  var_5 = var_2 getEye();
  var_6 = var_2 _meth_8566();
  var_7 = _func_0AF(90 - var_1 / 2, var_6[0]);
  var_8 = anglesToForward((var_7, var_6[1], var_6[2]));
  var_9 = _func_0A7(var_1 / 2);
  var_10 = _func_3A2(var_5, -1.0 * var_8, var_9, var_0, var_3.origin);

  if(_func_211(var_10, var_3.origin) > var_4 * var_4) {
    return;
  }
  var_11 = var_3.origin;
  var_3 delete();
  var_12 = var_5 + anglesToForward(var_6) * 1000;
  var_2 thread maps\mp\zombies\zombie_king::geist_blast_player(var_11, var_12);
}

delayed_emp_scythe_hit1(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("aud_zmb_scythe_impact");
  var_0 _meth_8059(level.scytheempcleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_emp_zm", "none");
}

delayed_emp_scythe_hit2(var_0, var_1) {
  var_0 endon("death");

  for(var_2 = 0; var_2 < var_1; var_2++)
    waitframe();

  _id_0378::_id_8D74("aud_zmb_scythe_impact");
  var_0 _meth_8059(level.scytheempcleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_emp_zm", "none");

  if(isDefined(var_0._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.knockbybladebarbarossa))
      _id_0547::_id_7D1B(self, var_0, "far");
  }
}

scythe_emp_onenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(var_4, "scythe_cleave_emp_zm") || _id_0547::_id_5565(var_4, "zom_dlc4_scythe_emp_zm")) {
    playzombiekilledbeamexplodefx();

    if(isDefined(self._id_0A4B)) {
      var_9 = undefined;

      if(_id_0547::_id_5565(self._id_0A4B, "zombie_dlc4") && self._id_5A36 >= maps\mp\zombies\zombie_corpse_eater::get_max_zombies_to_eat())
        var_9 = 1;

      if(common_scripts\utility::_id_562E(self.isempowered))
        var_9 = 1;

      if(common_scripts\utility::_id_562E(var_9) && !common_scripts\utility::_id_562E(self.has_shown_death_trial_hint)) {
        self.has_shown_death_trial_hint = 1;
        _id_0555::_id_83DD("dlc4_trial_hint_death", self);
      }

      var_1 scythe_death_shield_add(self._id_0A4B, var_9);
    }
  }
}

scythe_death_shield_enable() {
  self endon("disconnect");

  if(!isDefined(self.deathravenenergy))
    self.deathravenenergy = 0;

  if(!isDefined(self.deathravenenergy_test_func))
    self.deathravenenergy_test_func = ::scythe_death_energy_test_func;

  thread scythe_death_energy_reset_on_death();
  thread scythe_death_shield_check();
  thread scythe_death_sheild_weapon_fx();
}

scythe_death_energy_test_func() {
  if(!has_scythe_emp())
    return 0;

  if(self.deathravenenergy >= 1000)
    return 1;

  return 0;
}

scythe_death_shield_add(var_0, var_1) {
  var_2 = self;

  if(!var_2 has_scythe_emp() && !_id_0547::_id_5565(var_2 getcurrentweapon(), "zom_dlc4_scythe_emp_zm")) {
    return;
  }
  if(!isDefined(var_2.deathravenenergy))
    var_2.deathravenenergy = 0;

  var_2.deathravenenergy = var_2.deathravenenergy + scythe_death_shield_values(var_0, var_1);

  if(var_2.deathravenenergy >= 1000) {
    var_2 notify("death_raven_energy_full", self.only_charged_scythe_with_corpse_eaters);
    var_2.only_charged_scythe_with_corpse_eaters = 1;
    var_2.deathravenenergy = 1000;
  }
}

scythe_death_shield_set_empty() {
  var_0 = self;

  if(!isDefined(var_0.deathravenenergy))
    var_0.deathravenenergy = 0;

  var_0.deathravenenergy = 0;
  var_0 notify("death_raven_energy_empty");
}

scythe_death_shield_values(var_0, var_1) {
  var_2 = 0;

  switch (var_0) {
    case "zombie_generic":
      var_2 = 10;
      break;
    case "zombie_heavy":
      var_2 = 50;
      break;
    case "zombie_berserker":
      var_2 = 15;
      break;
    case "zombie_exploder":
      var_2 = 20;
      break;
    case "zombie_dlc4":
      var_2 = 30;
      break;
    default:
      break;
  }

  if(_id_0547::_id_5565(var_1, 1))
    var_2 = 1000;

  return var_2;
}

scythe_death_sheild_weapon_fx() {
  self notify("scythe_fx_start");
  self endon("scythe_fx_start");

  for(;;) {
    if(self getcurrentweapon() == "zom_dlc4_scythe_emp_zm") {
      if(self.deathravenenergy >= 1000 && !isDefined(self.scythechargedfx))
        scythe_charge_on();

      if(isDefined(self.scythechargedfx) && self.deathravenenergy < 1000)
        scythe_charge_off();
    } else
      scythe_charge_off();

    common_scripts\utility::_id_A70A("weapon_change", "death_raven_energy_full", "death_raven_energy_empty", "weapon_given", "weapon_taken", "zombie_player_spawn_finished", "offhand_end", "weapon_switch_started");

    while(self _meth_8126()) {
      if(isDefined(self.scythechargedfx))
        scythe_charge_off();

      waitframe();
    }
  }
}

scythe_charge_on() {
  level notify("scythe_charge_on");
  self.scythechargedfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_death_scythe_charged"), self, "TAG_FX", 1);
  _func_14C(self.scythechargedfx);
  self.scythechargedfx thread _id_0547::_id_2D19(self);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.scythechargedfx);
  _id_0378::_id_8D74("aud_zmb_scythe_charged_loop_start");
}

scythe_charge_off() {
  level notify("scythe_charge_off");

  if(isDefined(self.scythechargedfx))
    self.scythechargedfx delete();

  self.scythechargedfx = undefined;
  _id_0378::_id_8D74("aud_zmb_scythe_charged_loop_stop");
}

scythe_death_energy_reset_on_death() {
  self notify("death_energy_reset_on_death");
  self endon("death_energy_reset_on_death");
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    scythe_death_shield_set_empty();
  }
}

scythe_death_shield_check() {
  self notify("death_shield_activate");
  self endon("death_shield_activate");

  for(;;) {
    self waittill("dr_shield_activate");

    if(self.deathravenenergy < 1000) {
      continue;
    }
    self switchtoweapon(level.ravenweaponmanager["scythe_emp"]._id_01D0);
    self.health = 30;
    self notify("damage", 0);
    scythe_death_shield_burst();
  }
}

scythe_death_shield_burst() {
  var_0 = _id_0547::_id_408F();
  var_0 = _func_1AC(var_0, self.origin, 256);
  scythe_death_shield_set_empty();
  playFX(common_scripts\utility::_id_44F5("zmb_death_scythe_revive_aoe"), self.origin);
  _id_0378::_id_8D74("aud_zmb_scythe_burst");
  thread run_death_shellshock(self.origin);

  foreach(var_2 in var_0)
  thread scythe_death_shield_damage(var_2);
}

scythe_death_shield_damage(var_0) {
  var_1 = self;
  var_0 endon("death");
  playFX(level._effect["zmb_deathscythe_proj_exp"], var_0.origin + (0, 0, 50));
  var_0 _meth_8059(level.scythedeathburstdamage, var_1.origin, var_1, var_1, "MOD_MELEE", "scythe_burst_aoe_zm", "none");

  if(isDefined(var_0._id_0A4B)) {
    var_2 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_2) && common_scripts\utility::_id_562E(var_2.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "close");
  }
}

is_scythe_death_burst_weapon(var_0) {
  if(_id_0547::_id_5565(var_0, "scythe_burst_aoe_zm"))
    return 1;

  return 0;
}

run_death_shellshock(var_0) {
  var_1 = 3;
  var_2 = 3;
  var_3 = 300;
  self endon("death");
  self _meth_8182("zm_heavy_hit", var_2, var_1);
  self _meth_8308(0);
  self _meth_809F("damage_heavy");
  var_4 = self.origin - var_0;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = var_3 * vectorNormalize(var_4);
  var_4 = (var_4[0], var_4[1], 125);
  wait(var_2);
  self _meth_82F7(var_4);
  self _meth_8308(1);
}

store_players_weapons_zm(var_0) {
  if(!isDefined(self._id_9429))
    self._id_9429 = [];

  if(!isDefined(self._id_A08B))
    self._id_A08B = [];

  var_1 = [];
  var_2 = self getweaponlistall();
  var_3 = self getcurrentweapon();
  var_4 = self _meth_834A();
  var_5 = self getoffhandsecondaryclass();

  foreach(var_7 in var_2) {
    if(isDefined(self._id_A08B[var_7])) {
      continue;
    }
    var_1[var_7] = [];
    var_1[var_7]["clip_left"] = self getweaponammoclip(var_7, "left");
    var_1[var_7]["clip_right"] = self getweaponammoclip(var_7, "right");
    var_1[var_7]["stock"] = self getweaponammostock(var_7);
  }

  if(!isDefined(var_0))
    var_0 = "default";

  self._id_9429[var_0] = [];

  if(isDefined(self._id_A08B[var_3])) {
    var_9 = self getweaponlistprimaries();

    foreach(var_7 in var_9) {
      if(!isDefined(self._id_A08B[var_7])) {
        var_3 = var_7;
        break;
      }
    }
  }

  self._id_9429[var_0]["current_weapon"] = var_3;
  self._id_9429[var_0]["inventory"] = var_1;
  self._id_9429[var_0]["lethal_offhand"] = var_4;
  self._id_9429[var_0]["tactical_offhand"] = var_5;
}

restore_players_weapons_zm(var_0) {
  if(!isDefined(var_0))
    var_0 = "default";

  if(!isDefined(self._id_9429) || !isDefined(self._id_9429[var_0])) {
    return;
  }
  self _meth_8315();

  foreach(var_3, var_2 in self._id_9429[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode")
      self giveweapon(var_3);

    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self._id_9429[var_0]["current_weapon"];

  if(var_4 != "none")
    self switchtoweapon(var_4);

  self _meth_8349(self._id_9429[var_0]["lethal_offhand"]);
  self setoffhandsecondaryclass(self._id_9429[var_0]["tactical_offhand"]);
}

_id_941D(var_0) {
  if(!isDefined(self._id_9429))
    self._id_9429 = [];

  if(!isDefined(self._id_A08B))
    self._id_A08B = [];

  var_1 = [];
  var_2 = self getweaponlistall();
  var_3 = self getcurrentweapon();
  var_4 = self _meth_834A();
  var_5 = self getoffhandsecondaryclass();

  foreach(var_7 in var_2) {
    if(isDefined(self._id_A08B[var_7])) {
      continue;
    }
    var_1[var_7] = [];
    var_1[var_7]["clip_left"] = self getweaponammoclip(var_7, "left");
    var_1[var_7]["clip_right"] = self getweaponammoclip(var_7, "right");
    var_1[var_7]["stock"] = self getweaponammostock(var_7);
  }

  if(!isDefined(var_0))
    var_0 = "default";

  self._id_9429[var_0] = [];

  if(isDefined(self._id_A08B[var_3])) {
    var_9 = self getweaponlistprimaries();

    foreach(var_7 in var_9) {
      if(!isDefined(self._id_A08B[var_7])) {
        var_3 = var_7;
        break;
      }
    }
  }

  self._id_9429[var_0]["current_weapon"] = var_3;
  self._id_9429[var_0]["inventory"] = var_1;
  self._id_9429[var_0]["lethal_offhand"] = var_4;
  self._id_9429[var_0]["tactical_offhand"] = var_5;
}

_id_7DE9(var_0) {
  if(!isDefined(var_0))
    var_0 = "default";

  if(!isDefined(self._id_9429) || !isDefined(self._id_9429[var_0])) {
    return;
  }
  self _meth_8315();

  foreach(var_3, var_2 in self._id_9429[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode")
      self giveweapon(var_3);

    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self._id_9429[var_0]["current_weapon"];

  if(var_4 != "none")
    self switchtoweapon(var_4);

  self _meth_8349(self._id_9429[var_0]["lethal_offhand"]);
  self setoffhandsecondaryclass(self._id_9429[var_0]["tactical_offhand"]);
}

plinth_init() {
  common_scripts\utility::flag_init("flag_plinth_one_weapon_placed");
  common_scripts\utility::flag_init("flag_plinth_two_weapon_placed");
  common_scripts\utility::flag_init("flag_plinth_three_weapon_placed");
  common_scripts\utility::flag_init("flag_plinth_four_weapon_placed");
  common_scripts\utility::flag_init("flag_plinth_all_weapons_placed");
  var_0 = common_scripts\utility::_id_46B7("plinth_struct", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] plinth_weapon_setup();
    var_0[var_1] thread plinth_weapon_placement();

    switch (var_1) {
      case 0:
        var_0[var_1].weaponplacedflag = "flag_plinth_one_weapon_placed";
        break;
      case 1:
        var_0[var_1].weaponplacedflag = "flag_plinth_two_weapon_placed";
        break;
      case 2:
        var_0[var_1].weaponplacedflag = "flag_plinth_three_weapon_placed";
        break;
      case 3:
        var_0[var_1].weaponplacedflag = "flag_plinth_four_weapon_placed";
        break;
    }
  }

  thread plinth_check_for_all_weapons();
}

plinth_weapon_setup() {
  self._id_A9EB = "empty";
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "shield":
        self.shield = var_2;
        self.shield.goalposition = var_2.origin;
        var_2 _meth_805C();
        break;
      case "hammer":
        self.hammer = var_2;
        self.hammer.goalposition = var_2.origin;
        var_2 _meth_805C();
        break;
      case "spike":
        self.spike = var_2;
        self.spike.goalposition = var_2.origin;
        var_2 _meth_805C();
        break;
      case "scythe":
        self.scythe = var_2;
        self.scythe.goalposition = var_2.origin;
        var_2 _meth_805C();
        break;
      case "use_trigger":
        self.usetrigger = var_2;
        break;
      default:
        break;
    }
  }
}

plinth_weapon_placement() {
  var_0 = undefined;

  for(;;) {
    var_1 = undefined;
    var_2 = 0;
    self.usetrigger waittill("trigger", var_3);

    if(common_scripts\utility::_id_562E(level.bossceremonyactive)) {
      continue;
    }
    var_4 = var_3 test_raven_weapon_owner();
    var_5 = is_this_basic_wep(var_4);
    var_6 = is_this_right_wep("shield_emp", var_4);
    var_7 = is_this_right_wep("hammer_emp", var_4);
    var_8 = is_this_right_wep("spike_emp", var_4);
    var_9 = is_this_right_wep("scythe_emp", var_4);

    if(var_6 && _id_0547::_id_5565(self._id_0165, "plinth_generic")) {
      continue;
    }
    if((var_7 || var_8 || var_9) && _id_0547::_id_5565(self._id_0165, "plinth_shield")) {
      continue;
    }
    var_10 = undefined;

    if(var_6) {
      var_10 = "shield_emp";

      if(self._id_0165 == "plinth_shield") {
        var_2 = 1;
        var_1 = self.shield;
      }
    } else if(var_7) {
      var_10 = "hammer_emp";

      if(self._id_0165 == "plinth_generic") {
        var_2 = 1;
        var_1 = self.hammer;
      }
    } else if(var_8) {
      var_10 = "spike_emp";

      if(self._id_0165 == "plinth_generic") {
        var_2 = 1;
        var_1 = self.spike;
      }
    } else if(var_9) {
      var_10 = "scythe_emp";

      if(self._id_0165 == "plinth_generic") {
        var_2 = 1;
        var_1 = self.scythe;
      }
    }

    if(!isDefined(var_10) && self._id_A9EB == "empty") {
      continue;
    }
    if(isDefined(var_0)) {
      if(isDefined(self._id_3F76))
        self._id_3F76 delete();

      var_0 _meth_805C();

      if(common_scripts\utility::_id_562E(var_5))
        thread spawn_raven_weapon(var_4, level.player.origin);
    }

    var_11 = undefined;

    switch (self._id_A9EB) {
      case "empty":
        if(var_2 && _id_0547::_id_5565(level.ravenweaponmanager[var_10]._id_0117, var_3))
          var_3 take_raven_weapon(var_10, 1);

        break;
      case "shield":
        var_3 give_shield_emp_weapon(1);
        level notify("aud_shield_removed_from_plith");
        break;
      case "hammer":
        var_3 give_hammer_emp_weapon(1);
        level notify("aud_hammer_removed_from_plith");
        break;
      case "spike":
        var_3 give_spike_emp_weapon(1);
        level notify("aud_spike_removed_from_plith");
        break;
      case "scythe":
        var_3 give_scythe_emp_weapon(1);
        level notify("aud_scythe_removed_from_plith");
        break;
      default:
        break;
    }

    if(self._id_A9EB != "empty" && !common_scripts\utility::_id_3C77("flag_plinth_all_weapons_placed")) {
      if(isDefined(var_0) && isDefined(var_0.towerfx))
        var_0.towerfx delete();
    }

    if(isDefined(var_1)) {
      plinth_weapon_move_into_place(var_1, var_10);
      var_0 = var_1;
      common_scripts\utility::flag_set(self.weaponplacedflag);
      self._id_A9EB = var_1._id_0165;
      continue;
    }

    common_scripts\utility::_id_3C7B(self.weaponplacedflag);
    self._id_A9EB = "empty";
  }
}

is_this_basic_wep(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == "shield" || var_0 == "hammer" || var_0 == "spike" || var_0 == "scythe")
    return 1;

  return 0;
}

is_this_right_wep(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(var_0 == var_1)
    return 1;

  return 0;
}

plinth_weapon_move_into_place(var_0, var_1) {
  if(var_1 == "shield_emp" && isDefined(var_0._id_6C50)) {
    var_0 _meth_82B8(var_0._id_6C50, 0.05);
    wait 0.1;
  }

  var_0 _meth_82B1(var_0.goalposition + (0, 0, 24), 0.05);
  waitframe();
  var_0 _meth_805B();
  _id_0378::_id_8D74("aud_citadel_wpn_placement", var_1, var_0.goalposition);
  wait 1;
  var_0 _meth_82B1(var_0.goalposition, 3, 0.5, 1.25);
  wait 3;
  var_2 = common_scripts\utility::_id_46B7("citadel_tower_fx_struct", "targetname");
  var_3 = undefined;

  switch (var_1) {
    case "shield_emp":
      var_0.towerfx = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_fire_pillar_01"), var_2[0].origin);
      _id_0378::_id_8D74("aud_citadel_pillar_ignite", (-3196, -8926, 1504));
      _id_0378::_id_8D74("aud_citadel_shield_pillar_fire_lp", (-3196, -8926, 1504));
      break;
    case "hammer_emp":
      var_0.towerfx = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_fire_pillar_01"), var_2[1].origin);
      _id_0378::_id_8D74("aud_citadel_pillar_ignite", (-3096, -5456, 1411));
      _id_0378::_id_8D74("aud_citadel_hammer_pillar_fire_lp", (-3096, -5456, 1411));
      break;
    case "spike_emp":
      var_0.towerfx = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_fire_pillar_01"), var_2[2].origin);
      _id_0378::_id_8D74("aud_citadel_pillar_ignite", (3226, -5484, 1387));
      _id_0378::_id_8D74("aud_citadel_spike_pillar_fire_lp", (3226, -5484, 1387));
      break;
    case "scythe_emp":
      var_0.towerfx = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_fire_pillar_01"), var_2[3].origin);
      _id_0378::_id_8D74("aud_citadel_pillar_ignite", (3208, -8997, 1485));
      _id_0378::_id_8D74("aud_citadel_scythe_pillar_fire_lp", (3208, -8997, 1485));
      break;
  }

  if(isDefined(var_0.towerfx))
    _func_14C(var_0.towerfx);

  self._id_3F76 = spawn("script_model", self.origin);
  self._id_3F76 setModel("tag_origin");
  self._id_3F76 set_fx(level.ravenweaponmanager[var_1].pickup_glow, "tag_origin");
}

plinth_shield_rotate(var_0) {
  var_1 = _func_18E("shield_angles_destination", "targetname");
  var_2 = _func_18E("shield_manual_pivot", "targetname");

  if(!isDefined(var_2._id_6C50))
    var_2._id_6C50 = var_2.angles;

  if(!isDefined(var_0._id_6C50))
    var_0._id_6C50 = var_0.angles;

  var_0 linktosynchronizedparent(var_2);
  waittillframeend;
  var_2 _meth_82B8(var_1.angles, 3, 1.5, 1.5);
  wait 3;
  var_0 _meth_8057();
  waitframe();
  var_2 _meth_82B8(var_2._id_6C50, 0.1);
}

plinth_check_for_all_weapons() {
  var_0 = 0;

  while(!common_scripts\utility::_id_562E(var_0)) {
    waitframe();

    if(!common_scripts\utility::_id_3C77("flag_plinth_one_weapon_placed")) {
      continue;
    }
    if(!common_scripts\utility::_id_3C77("flag_plinth_two_weapon_placed")) {
      continue;
    }
    if(!common_scripts\utility::_id_3C77("flag_plinth_three_weapon_placed")) {
      continue;
    }
    if(!common_scripts\utility::_id_3C77("flag_plinth_four_weapon_placed")) {
      continue;
    }
    var_0 = 1;
  }

  var_1 = _func_18E("shield", "script_noteworthy");
  plinth_shield_rotate(var_1);
  level.bossceremonyactive = 1;
  common_scripts\utility::flag_set("flag_plinth_all_weapons_placed");
  _func_213(232);
  _func_213(220);
  _id_0378::_id_8D74("aud_citadel_entrance", (-785, -9852, 2387));
  _id_0378::_id_8D74("aud_citadel_all_weapons_placed");
  wait 2;
  level notify("vo_vivian_entranced");
  wait 8;
  level.bossceremonyactive = 0;
  maps\mp\zombies\_zombies_blood_tubes::enter_boss_tube_activate();
  level notify("boss_tube_activated");
}

debug_plinth_spawn_weapons() {
  var_0 = common_scripts\utility::_id_46B7("plinth_raven_weapon_spawns", "targetname");
  var_1 = ["shield_emp", "hammer_emp", "spike_emp", "scythe_emp"];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    thread spawn_raven_weapon(var_1[var_2], var_0[var_2].origin);
}

try_take_dlc4_melee_from_other_player(var_0, var_1, var_2) {
  var_3 = [var_0, var_1];
  var_2 = "shovel_zm";

  foreach(var_5 in var_3) {
    if(!isDefined(level.ravenweaponmanager[var_5]._id_0117) || level.ravenweaponmanager[var_5]._id_0117 == self) {
      continue;
    }
    var_6 = level.ravenweaponmanager[var_5]._id_0117;
    take_raven_weapon(var_5);

    if(var_6 _meth_82D5() == "none") {
      var_7 = _id_0548::_id_454B(var_6, var_2);
      var_6 _id_0586::_id_078C(var_7);
    }
  }
}