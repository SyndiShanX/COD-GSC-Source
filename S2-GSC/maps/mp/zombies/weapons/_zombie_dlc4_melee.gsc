/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_dlc4_melee.gsc
**********************************************************/

func_00D5() {
  level.var_611["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_med_trap_gib");
  level.var_611["zmb_bat_long_hit_crit_blood"] = loadfx("vfx/blood/zmb_bat_long_hit_crit_blood");
  level.var_611["zmb_raven_sword_barb_burst"] = loadfx("vfx/zombie/zmb_sword_barb_burst");
  level.var_611["zmb_melee_drain_player"] = loadfx("vfx/gameplay\mp\zombie/zmb_melee_drain_player");
  level.var_611["zmb_giestkraft_impact"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
  level.var_611["zmb_storm_hammer_impact"] = loadfx("vfx/zombie/rvn_weapons\zmb_storm_hammer_impact");
  level.var_611["zmb_storm_hammer_lightning"] = loadfx("vfx/zombie/rvn_weapons\zmb_storm_hammer_lightning");
  level.var_611["zmb_moonorb_stuck"] = loadfx("vfx/zombie/rvn_weapons\zmb_moonorb_stuck");
  level.var_611["zmb_moonorb_suck"] = loadfx("vfx/zombie/rvn_weapons\zmb_moonorb_suck");
  level.var_611["zmb_moonorb_charge"] = loadfx("vfx/zombie/zmb_moonorb_charge");
  level.var_611["zmb_moonorb_tel_appear"] = loadfx("vfx/zombie/rvn_weapons\zmb_moonorb_tel_appear");
  level.var_611["zmb_moonorb_tel_disappear"] = loadfx("vfx/zombie/rvn_weapons\zmb_moonorb_tel_disappear");
  level.var_611["zmb_stormhammer_trail"] = loadfx("vfx/trail/zmb_stormhammer_trail");
  level.var_611["zmb_hammer_smack"] = loadfx("vfx/blood/zmb_hammer_smack");
  level.var_611["zmb_storm_hammer_knockback"] = loadfx("vfx/zombie/rvn_weapons\zmb_storm_hammer_knockback");
  level.var_611["zmb_storm_hmr_zmb_stun"] = loadfx("vfx/zombie/rvn_weapons\zmb_storm_hmr_zmb_stun");
  level.var_611["zmb_storm_hmr_godking_stun"] = loadfx("vfx/zombie/rvn_weapons\zmb_storm_hmr_godking_stun");
  level.var_611["zmb_storm_hmr_zmb_kill"] = loadfx("vfx/zombie/rvn_weapons\zmb_storm_hmr_zmb_kill");
  level.var_611["zmb_emp_HAMMER_aoe_fx"] = loadfx("vfx/trail/zmb_emp_HAMMER_projectile");
  level.var_611["zmb_deathscythe_proj_exp"] = loadfx("vfx/zombie/rvn_weapons\zmb_deathscythe_proj_exp");
  level.var_611["zmb_death_scythe_knockback"] = loadfx("vfx/zombie/rvn_weapons\zmb_death_scythe_knockback");
  level.var_611["zmb_death_scythe_knockback_2"] = loadfx("vfx/zombie/rvn_weapons\zmb_death_scythe_knockback_2");
  level.var_611["zmb_death_scythe_charged"] = loadfx("vfx/zombie/rvn_weapons\zmb_death_scythe_charged");
  level.var_611["zmb_blood_shield_block"] = loadfx("vfx/zombie/rvn_weapons\zmb_blood_shield_block");
  level.var_611["zmb_blood_shield_block_emp"] = loadfx("vfx/zombie/rvn_weapons\zmb_blood_shield_block_emp");
  level.var_611["zmb_blood_shield_bash"] = loadfx("vfx/zombie/rvn_weapons\zmb_blood_shield_bash");
  level.var_611["zmb_blood_shield_bash_emp"] = loadfx("vfx/zombie/rvn_weapons\zmb_blood_shield_bash_emp");
  level.var_611["zmb_death_scythe_revive_aoe"] = loadfx("vfx/zombie/rvn_weapons\zmb_death_scythe_revive_aoe");
  level.zombiemeleeweapon["zom_dlc4_scythe_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_scythe_emp_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_hammer_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_hammer_emp_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_spike_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_spike_emp_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_shield_zm"] = 1;
  level.zombiemeleeweapon["zom_dlc4_shield_emp_zm"] = 1;
  level.dlc4specialweapons = [];
  lib_054D::register_grenadier_immune_zombie_equipment("zom_moonorb_grenade_zm");
  lib_054D::register_grenadier_immune_zombie_equipment("zom_moonorb_grenade_emp_zm");
  lib_054D::register_grenadier_immune_zombie_equipment("zom_hammer_grenade_zm");
  level.ravenweaponmanager["shield"] = spawnStruct();
  level.ravenweaponmanager["shield"].var_1D0 = "zom_dlc4_shield_zm";
  level.ravenweaponmanager["shield"].weapon_model = "npc_zom_bloodraven_shield";
  level.ravenweaponmanager["shield"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SHIELD";
  level.ravenweaponmanager["shield"].give_func = ::give_shield_weapon;
  level.ravenweaponmanager["shield"].pickup_glow = "zmb_desc_gun_glow_bloodraven";
  level.ravenweaponmanager["shield"].wep_loss_notify = "shield_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_shield_zm");
  level.ravenweaponmanager["shield_emp"] = spawnStruct();
  level.ravenweaponmanager["shield_emp"].var_1D0 = "zom_dlc4_shield_emp_zm";
  level.ravenweaponmanager["shield_emp"].weapon_model = "npc_zom_bloodraven_shield";
  level.ravenweaponmanager["shield_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SHIELD_EMP";
  level.ravenweaponmanager["shield_emp"].give_func = ::give_shield_emp_weapon;
  level.ravenweaponmanager["shield_emp"].pickup_glow = "zmb_desc_gun_glow_bloodraven";
  level.ravenweaponmanager["shield_emp"].wep_loss_notify = "shield_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_shield_emp_zm");
  level.ravenweaponmanager["hammer"] = spawnStruct();
  level.ravenweaponmanager["hammer"].var_1D0 = "zom_dlc4_hammer_zm";
  level.ravenweaponmanager["hammer"].weapon_model = "npc_gen_sledgehammer_zom";
  level.ravenweaponmanager["hammer"].weapon_hint = &"ZOMBIE_WEAPONDLC4_HAMMER";
  level.ravenweaponmanager["hammer"].give_func = ::give_hammer_weapon;
  level.ravenweaponmanager["hammer"].pickup_glow = "zmb_desc_gun_glow_stormraven";
  level.ravenweaponmanager["hammer"].wep_loss_notify = "hammer_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_hammer_zm");
  level.ravenweaponmanager["hammer_emp"] = spawnStruct();
  level.ravenweaponmanager["hammer_emp"].var_1D0 = "zom_dlc4_hammer_emp_zm";
  level.ravenweaponmanager["hammer_emp"].weapon_model = "npc_gen_sledgehammer_zom_emp";
  level.ravenweaponmanager["hammer_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_HAMMER_EMP";
  level.ravenweaponmanager["hammer_emp"].give_func = ::give_hammer_emp_weapon;
  level.ravenweaponmanager["hammer_emp"].pickup_glow = "zmb_desc_gun_glow_stormraven";
  level.ravenweaponmanager["hammer_emp"].wep_loss_notify = "hammer_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_hammer_emp_zm");
  level.ravenweaponmanager["spike"] = spawnStruct();
  level.ravenweaponmanager["spike"].var_1D0 = "zom_dlc4_spike_zm";
  level.ravenweaponmanager["spike"].weapon_model = "npc_zom_morningstar";
  level.ravenweaponmanager["spike"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SPIKE";
  level.ravenweaponmanager["spike"].give_func = ::give_spike_weapon;
  level.ravenweaponmanager["spike"].pickup_glow = "zmb_desc_gun_glow_moonraven";
  level.ravenweaponmanager["spike"].wep_loss_notify = "spike_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_spike_zm");
  level.ravenweaponmanager["spike_emp"] = spawnStruct();
  level.ravenweaponmanager["spike_emp"].var_1D0 = "zom_dlc4_spike_emp_zm";
  level.ravenweaponmanager["spike_emp"].weapon_model = "npc_zom_morningstar_emp";
  level.ravenweaponmanager["spike_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SPIKE_EMP";
  level.ravenweaponmanager["spike_emp"].give_func = ::give_spike_emp_weapon;
  level.ravenweaponmanager["spike_emp"].pickup_glow = "zmb_desc_gun_glow_moonraven";
  level.ravenweaponmanager["spike_emp"].wep_loss_notify = "spike_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_spike_emp_zm");
  level.ravenweaponmanager["scythe"] = spawnStruct();
  level.ravenweaponmanager["scythe"].var_1D0 = "zom_dlc4_scythe_zm";
  level.ravenweaponmanager["scythe"].weapon_model = "npc_zom_scythe";
  level.ravenweaponmanager["scythe"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SCYTHE";
  level.ravenweaponmanager["scythe"].give_func = ::give_scythe_weapon;
  level.ravenweaponmanager["scythe"].pickup_glow = "zmb_desc_gun_glow_deathraven";
  level.ravenweaponmanager["scythe"].wep_loss_notify = "scythe_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_scythe_zm");
  level.ravenweaponmanager["scythe_emp"] = spawnStruct();
  level.ravenweaponmanager["scythe_emp"].var_1D0 = "zom_dlc4_scythe_emp_zm";
  level.ravenweaponmanager["scythe_emp"].weapon_model = "npc_zom_scythe_emp";
  level.ravenweaponmanager["scythe_emp"].weapon_hint = &"ZOMBIE_WEAPONDLC4_SCYTHE_EMP";
  level.ravenweaponmanager["scythe_emp"].give_func = ::give_scythe_emp_weapon;
  level.ravenweaponmanager["scythe_emp"].pickup_glow = "zmb_desc_gun_glow_deathraven";
  level.ravenweaponmanager["scythe_emp"].wep_loss_notify = "scythe_emp_lost";
  level.dlc4specialweapons = common_scripts\utility::func_F6F(level.dlc4specialweapons, "zom_dlc4_scythe_emp_zm");
  level.weaponmaxammofuncs["zom_moonorb_grenade_emp_zm"] = ::raven_thrown_max_ammo_func;
  level.weaponmaxammofuncs["zom_moonorb_grenade_zm"] = ::raven_thrown_max_ammo_func;
  level.weaponmaxammofuncs["zom_hammer_grenade_zm"] = ::raven_thrown_max_ammo_func;
  level.weaponmaxammofuncs["zom_dlc4_spike_zm"] = ::spike_max_ammo_func;
  level.nobonusammoreward["zom_dlc4_spike_zm"] = 1;
  level.weaponmaxammofuncs["zom_dlc4_spike_emp_zm"] = ::spike_max_ammo_func;
  level.nobonusammoreward["zom_dlc4_spike_emp_zm"] = 1;
  lib_0547::func_7BD0("shield_push", ::shield_push_run, ::shield_push_interrupt, 5.75, ::shield_push_end);
  if(!isDefined(level.var_6DF9)) {
    level.var_6DF9 = [];
  }

  common_scripts\utility::func_3C87("dlc4_melee_packable");
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

raven_thrown_max_ammo_func(param_00) {
  if(isDefined(self._dlc4_weapon_manager) && isDefined(self._dlc4_weapon_manager["stored_lethal"]) && isDefined(self._dlc4_weapon_manager["stored_lethal_ammo"])) {
    var_01 = weaponclipsize(self._dlc4_weapon_manager["stored_lethal"], self);
    self._dlc4_weapon_manager["stored_lethal_ammo"] = var_01;
  }

  if(isDefined(self._dlc4_weapon_manager) && isDefined(self._dlc4_weapon_manager["stored_tactical"]) && isDefined(self._dlc4_weapon_manager["stored_tactical_ammo"])) {
    var_01 = weaponclipsize(self._dlc4_weapon_manager["stored_tactical"], self);
    self._dlc4_weapon_manager["stored_tactical_ammo"] = var_01;
  }

  return 1;
}

spawn_raven_weapon(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_03)) {
    wait(param_03);
  }

  if(lib_0547::func_5565(param_00, "scythe") && common_scripts\utility::func_562E(level.zmb_scythe_no_spawn)) {
    return;
  }

  var_05 = getclosestpointonnavmesh(param_01);
  var_06 = common_scripts\utility::func_8FFC();
  var_06.var_116 = var_05;
  var_06 childthread wep_spin();
  var_06 childthread wep_bounce();
  var_07 = spawn("script_model", param_01);
  var_07.var_116 = var_06.var_116 + (0, 0, 50);
  if(isDefined(param_02)) {
    var_07.var_1D = param_02;
  }

  var_07 method_8449(var_06, "tag_origin");
  var_07 setModel(level.ravenweaponmanager[param_00].weapon_model);
  var_06 set_fx(level.ravenweaponmanager[param_00].pickup_glow, "tag_origin");
  var_08 = spawnStruct();
  var_08.wep = var_07;
  thread maps\mp\_utility::func_6F74(::pickup_override_think, var_08, "picked_up_raven_weapon");
  var_07 lib_0547::func_AC41(level.ravenweaponmanager[param_00].weapon_hint, (0, 0, 16));
  var_09 = undefined;
  while(!isDefined(var_09)) {
    var_07 waittill("player_used", var_09);
  }

  var_09 notify("picked_up_raven_weapon");
  var_07 lib_0547::func_AC40();
  var_07 delete();
  var_06 delete();
  if(common_scripts\utility::func_562E(param_04)) {
    var_09[[level.ravenweaponmanager[param_00].give_func]](undefined, param_04);
  } else {
    var_09[[level.ravenweaponmanager[param_00].give_func]]();
  }

  return var_09;
}

pickup_override_think(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = 0;
  var_03 = undefined;
  var_04 = 3;
  var_05 = 64;
  while(!isDefined(param_00.wep.var_9D65)) {
    wait 0.05;
  }

  while(isDefined(param_00.wep.var_9D65)) {
    if(var_01 useButtonPressed() && distance2d(var_01.var_116, param_00.wep.var_116) <= var_05) {
      if(var_02 == 0) {
        var_02 = 1;
        var_03 = gettime() * 0.001;
      } else if(gettime() * 0.001 - var_03 > 3) {
        param_00.wep.var_9D65 notify("trigger", self);
      }

      continue;
    }

    if(var_02 == 1) {
      var_02 = 0;
      var_03 = undefined;
    }

    wait 0.05;
  }

  param_00 = undefined;
}

wep_disco_protect(param_00) {
  self notify("wep_disco_protect");
  self endon("wep_disco_protect");
  self endon(level.ravenweaponmanager[param_00].wep_loss_notify);
  level endon("wep_death_bossfight_protect_" + param_00);
  thread wep_disco_track(param_00);
  self waittill("disconnect");
  level notify("wep_disco_protect_" + param_00);
  take_raven_weapon(param_00, 1);
  spawn_raven_weapon(param_00, level.ravenweaponmanager[param_00].last_loc);
}

wep_disco_track(param_00) {
  self notify("wep_disco_track");
  self endon("wep_disco_track");
  self endon("disconnect");
  for(;;) {
    if(function_02E6(self.var_116)) {
      level.ravenweaponmanager[param_00].last_loc = self.var_116;
    }

    wait(1);
  }
}

wep_death_protect(param_00) {
  self notify("wep_death_protect");
  self endon("wep_death_protect");
  self endon(level.ravenweaponmanager[param_00].wep_loss_notify);
  level endon("wep_disco_protect_" + param_00);
  var_01 = 0;
  self waittill("death");
  if(common_scripts\utility::func_3C77("flag_boss_fight_start") && !common_scripts\utility::func_3C77("flag_boss_complete")) {
    var_02 = self.var_116;
    if(isDefined(level.ravenweaponmanager[param_00].last_loc)) {
      var_02 = level.ravenweaponmanager[param_00].last_loc;
    }

    level notify("wep_death_bossfight_protect_" + param_00);
    level thread spawn_raven_weapon(param_00, var_02);
    level.ravenweaponmanager[param_00].var_117 = undefined;
    return;
  }

  if(issubstr(var_01, "scythe_") && issubstr(var_01, "_emp") && !common_scripts\utility::func_3C77(lib_0557::func_7838("quest_deathraven", "quest_deathraven_enter_trial"))) {
    var_02 = 1;
  }

  if(issubstr(var_01, "_emp") && isDefined(self.isintrial) && !common_scripts\utility::func_562E(self.inasneakyplace)) {
    level.ravenweaponmanager[var_01].var_117 = undefined;
    var_01 = function_0337(var_01, "_emp");
    level.ravenweaponmanager[var_01].var_117 = self;
  }

  if(common_scripts\utility::func_562E(var_02)) {
    return;
  }

  self waittill("zombie_player_spawn_finished");
  if(lib_0547::func_5565(level.ravenweaponmanager[var_01].var_117, self)) {
    self[[level.ravenweaponmanager[var_01].give_func]]();
  }
}

wep_spin() {
  self endon("death");
  var_00 = 850;
  for(;;) {
    self rotateyaw(-29536, var_00);
    wait(var_00);
  }
}

wep_bounce() {
  self endon("death");
  var_00 = 4;
  for(;;) {
    self moveto(self.var_116 - (0, 0, 4), var_00, 0.5, 0.5);
    wait(var_00);
    self moveto(self.var_116 + (0, 0, 4), var_00, 0.5, 0.5);
    wait(var_00);
  }
}

take_raven_weapon(param_00, param_01) {
  if(isDefined(level.ravenweaponmanager[param_00].var_117) && isPlayer(level.ravenweaponmanager[param_00].var_117)) {
    level.ravenweaponmanager[param_00].var_117 lib_0586::func_790(level.ravenweaponmanager[param_00].var_1D0);
    if(lib_0547::func_5565(param_01, 1)) {
      var_02 = maps\mp\zombies\_zombies_magicbox::func_454B(level.ravenweaponmanager[param_00].var_117, "shovel_zm");
      level.ravenweaponmanager[param_00].var_117 lib_0586::func_78C(var_02);
      level.ravenweaponmanager[param_00].var_117 lib_0586::func_78E(var_02);
    }
  }

  level.ravenweaponmanager[param_00].var_117 = undefined;
}

test_raven_weapon_owner() {
  var_00 = ["shield", "shield_emp", "hammer", "hammer_emp", "spike", "spike_emp", "scythe", "scythe_emp"];
  var_01 = undefined;
  foreach(var_03 in var_00) {
    if(lib_0547::func_5565(level.ravenweaponmanager[var_03].var_117, self)) {
      var_01 = var_03;
    }
  }

  return var_01;
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
    level.hammerdamage = max(1264, var_01 * 0.3);
    level.hammercleavedamage = max(1882, var_01 * 0.25);
    level.hammersweetcleavedamage = max(2710, var_01 * 0.7);
    level.hammerempdamage = max(1851, var_01 * 0.6);
    level.hammerempaoedamage = max(2710, var_01 * 0.7);
    level.hammerthrowdamage = max(450, var_01 * 0.5);
    level.hammerthrowburstdamage = max(1882, var_01 * 0.6);
    level.spikedamage = max(1530, var_01 * 0.2);
    level.spikeempdamage = max(1700, var_01 * 0.3);
    level.scythedamage = max(2385, var_01 * 0.35);
    level.scythecleavedamage = max(2385, var_01 * 0.35);
    level.scytheempdamage = max(2385, var_01 * 0.35);
    level.scytheempcleavedamage = max(2385, var_01 * 0.35);
    level.scythethrowdamage = max(2886, var_01 * 0.15);
    level.scythedeathburstdamage = max(3280, var_01 * 0.6);
    level.var_8AFE = max(850, var_01 * 0.33);
    level.shieldempdamage = max(2385, var_01 * 0.5);
    level.shieldslamdamage = max(850, var_01 * 0.4);
    level.shieldpushimpactdamage = max(100, var_01 * 0.1);
    level waittill("waveupdate");
    var_00 = level.var_A980;
  }
}

setup_melee_abilityinfo(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = 0.25;
  }

  var_05 = spawnStruct();
  var_05.var_953E = param_00;
  var_05.firedelay = param_01;
  var_05.weaponlostendon = param_02;
  var_05.firingfunction = param_03;
  var_05.minduration = param_04;
  var_05.isheavymelee = 0;
  return var_05;
}

setup_heavy_melee_abilityinfo(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = 0.25;
  }

  var_05 = spawnStruct();
  var_05.var_953E = param_00;
  var_05.firedelay = param_01;
  var_05.weaponlostendon = param_02;
  var_05.firingfunction = param_03;
  var_05.minduration = param_04;
  var_05.isheavymelee = 1;
  return var_05;
}

run_melee_ability(param_00) {
  if(isDefined(param_00.weaponlostendon)) {
    self endon(param_00.weaponlostendon);
  }

  self endon("disconnect");
  for(;;) {
    self waittill("melee_fired", var_01);
    if(issubstr(var_01, param_00.var_953E) && self method_8128() && !self method_8661()) {
      melee_ability_fire(param_00);
    }
  }
}

run_heavy_melee_ability(param_00) {
  if(isDefined(param_00.weaponlostendon)) {
    self endon(param_00.weaponlostendon);
  }

  self endon("disconnect");
  for(;;) {
    self waittill("melee_fired", var_01);
    if(issubstr(var_01, param_00.var_953E) && self method_8661()) {
      melee_ability_fire(param_00);
    }
  }
}

melee_ability_fire(param_00) {
  self endon("melee_ability_interrupt");
  if(isDefined(param_00.minduration) && isDefined(self.nextmeleeabilitytime)) {
    if(gettime() < self.nextmeleeabilitytime) {
      return;
    }
  }

  thread watch_for_melee_interrupt(param_00);
  if(isDefined(param_00.firedelay)) {
    wait(param_00.firedelay);
  }

  childthread[[param_00.firingfunction]](param_00);
  wait_for_melee_ability_duration(param_00);
}

wait_for_melee_ability_duration(param_00) {
  if(isDefined(param_00.minduration)) {
    self.nextmeleeabilitytime = gettime() + param_00.minduration * 1000;
    wait(param_00.minduration);
  } else {
    while((param_00.isheavymelee && self method_8661()) || !param_00.isheavymelee && self method_8128() && !self method_8661()) {
      wait 0.05;
    }
  }

  self notify("melee_ability_complete");
}

watch_for_melee_interrupt(param_00) {
  self endon("melee_ability_complete");
  self endon("disconnect");
  self endon("death");
  self waittill("weapon_switch_started");
  self notify("melee_ability_interrupt");
}

bayo_charge_watcher_zm(param_00, param_01, param_02) {
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

wait_for_raven_disco(param_00) {
  self endon("raven_weapon_taken");
  childthread raven_track_weapon_pos(param_00);
  self waittill("disconnect");
  level thread spawn_raven_weapon(param_00, level.ravenweaponmanager[param_00].last_valid_pos, undefined, 2);
  level.ravenweaponmanager[param_00].var_117 = undefined;
}

raven_track_weapon_pos(param_00) {
  var_01 = undefined;
  while(isDefined(self)) {
    var_02 = getgroundposition(self.var_116, 12, 36, 12);
    var_03 = function_02E6(var_02);
    if(lib_0547::func_5565(var_03, 1)) {
      level.ravenweaponmanager[param_00].last_valid_pos = var_01;
    }

    wait(2);
  }
}

raven_weapon_check_if_special_grenade(param_00) {
  var_01 = 0;
  if(lib_0547::func_5565(param_00, "zom_hammer_grenade_zm") || lib_0547::func_5565(param_00, "zom_moonorb_grenade_zm") || lib_0547::func_5565(param_00, "zom_moonorb_grenade_emp_zm")) {
    var_01 = 1;
  }

  return var_01;
}

shield_init() {
  level.zombiemeleeweapon["zom_dlc4_shield_zm"] = 1;
  level.var_62B3["zom_dlc4_shield_zm"] = ::shield_modify_damage;
  level.meleeaoeweapons["shield_cleave_zm"] = 1;
  level.var_2FE9["zom_dlc4_shield_zm"] = 1;
  level.var_4D3D["zom_dlc4_shield_zm"] = 1;
  level.var_2FE9["shield_cleave_zm"] = 1;
  level.var_4D3D["shield_cleave_zm"] = 1;
  setup_melee_weapon_ownership(::has_shield, ::shield_gained, ::shield_lost);
}

give_shield_weapon() {
  try_drop_old_weapon("shield");
  if(!lib_0547::func_73F9(self, "zom_dlc4_shield_zm")) {
    lib_0586::func_78C("zom_dlc4_shield_zm");
    self switchtoweapon("zom_dlc4_shield_zm");
  }

  thread wep_disco_protect("shield");
  thread wep_death_protect("shield");
  level.ravenweaponmanager["shield"].var_117 = self;
  if(isDefined(level.reveal_structs_in_order)) {
    foreach(var_01 in level.reveal_structs_in_order) {
      if(common_scripts\utility::func_562E(var_01.isrevealed)) {
        if(isDefined(var_01.var_3F2F)) {
          var_01.var_3F2F delete();
        }

        var_01 maps\mp\mp_zombie_descent_ee_main::set_blood_code(var_01.blood_fx_index, self);
        continue;
      }

      if(common_scripts\utility::func_562E(var_01.wisp)) {
        if(isDefined(var_01.var_3F2F)) {
          var_01.var_3F2F delete();
        }

        var_01.var_3F2F = lib_0547::func_8FBA(var_01, "zmf_descent_vision_blood_ready", self);
        triggerfx(var_01.var_3F2F);
      }
    }
  }
}

has_shield() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc4_shield_zm");
}

shield_gained() {
  thread shield_think();
  if(!common_scripts\utility::func_562E(self.has_shown_shield_hint)) {
    self.has_shown_shield_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_shield", self);
  }

  if(isDefined(level.ravenweaponmanager["shield"].on_gained_func)) {
    self[[level.ravenweaponmanager["shield"].on_gained_func]]();
  }
}

shield_lost() {
  self notify(level.ravenweaponmanager["shield"].wep_loss_notify);
  if(isDefined(level.reveal_structs_in_order)) {
    foreach(var_01 in level.reveal_structs_in_order) {
      if(isDefined(var_01.var_3F2F)) {
        var_01.var_3F2F delete();
      }
    }
  }
}

shield_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if((param_01 method_8128() && !param_01 method_8661()) || param_01 method_8128() && param_01 method_83DE()) {
    param_00.ignorethiszerodamage = 1;
    return 0;
  }

  return level.var_8AFE;
}

shield_think() {
  var_00 = setup_melee_abilityinfo("zom_dlc4_shield_zm", 0.22, level.ravenweaponmanager["shield"].wep_loss_notify, ::shield_melee_cone, 1);
  thread shield_blood_block_enable();
  thread run_melee_ability(var_00);
  thread bayo_charge_watcher_zm("zom_dlc4_shield_zm", ::sheild_bayo_charge_start, ::sheild_bayo_charge_result);
}

shield_blood_block_enable() {
  self endon("disconnect");
  self.bloodblockhealth = 100;
  self.bloodshieldblock_test_func = ::shield_block_test_func;
  childthread shield_block_think();
  while(has_shield()) {
    wait 0.05;
  }

  self notify("blood_block_disable");
}

shield_block_test_func(param_00, param_01) {
  if(!has_shield() || !lib_0547::func_5565(self getcurrentweapon(), "zom_dlc4_shield_zm") || !lib_0547::func_5565(self.is_bloodblocking, 1) || self method_8128() || self method_8661() || self method_83DE()) {
    return 0;
  }

  if(isDefined(param_01) && param_01 is_out_of_bounds_trigger()) {
    return 0;
  }

  if(isDefined(param_00) && self.bloodblockhealth >= 0 && maps\mp\_utility::func_3B8E(self, param_00, 50)) {
    return 1;
  }

  return 0;
}

is_out_of_bounds_trigger() {
  var_00 = self;
  return isDefined(var_00) && lib_0547::func_5565(var_00.var_3A, "trigger_hurt");
}

shield_block_think() {
  var_00 = self;
  var_00 thread shield_manage_health();
  for(;;) {
    var_01 = isalive(self);
    if(var_01 && self getcurrentweapon() == "zom_dlc4_shield_zm" && self.bloodblockhealth > 0) {
      if(!isDefined(self.shieldblockfx)) {
        shield_block_fx_on();
      }

      if(!lib_0547::func_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 1;
        thread shield_block_ui();
      }

      self.is_bloodblocking = 1;
    } else if(var_01 && self getcurrentweapon() == "zom_dlc4_shield_zm" && self.bloodblockhealth <= 0) {
      if(isDefined(self.shieldblockfx)) {
        shield_block_fx_off();
      }

      shield_punish(5);
      self.is_bloodblocking = 0;
    } else {
      if(isDefined(self.shieldblockfx)) {
        shield_block_fx_off();
      }

      if(lib_0547::func_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 0;
        self setclientomnvar("ui_onevone_class_5", -3);
      }

      self.is_bloodblocking = 0;
    }

    if(!has_shield()) {
      return;
    }

    common_scripts\utility::knock_off_battery("weapon_change", "blood_health_empty", "weapon_given", "weapon_taken", "zombie_player_spawn_finished", "offhand_end", "weapon_switch_started", "death");
    while(self method_8126()) {
      if(isDefined(self.shieldblockfx)) {
        shield_emp_block_fx_off();
      }

      wait 0.05;
    }
  }
}

shield_block_ui() {
  if(!isDefined(self.pre_bloodblockhealth)) {
    self.pre_bloodblockhealth = self.bloodblockhealth;
  }

  self setclientomnvar("ui_onevone_show_class_menu", 1);
  self setclientomnvar("ui_onevone_class_5", self.bloodblockhealth);
  while(lib_0547::func_5565(self.bloodui_active, 1)) {
    if(self.bloodblockhealth != self.pre_bloodblockhealth) {
      self.pre_bloodblockhealth = self.bloodblockhealth;
      if(self.bloodblockhealth <= 0) {
        self setclientomnvar("ui_onevone_class_5", -2);
        continue;
      }

      self setclientomnvar("ui_onevone_class_5", self.bloodblockhealth);
    }

    wait 0.05;
  }
}

shield_manage_health() {
  while(has_shield()) {
    self waittill("br_block_hit", var_00, var_01);
    self notify("shield_health_regen_interrupt");
    if(isDefined(self.boodshielddamagesustained)) {
      self.boodshielddamagesustained = self.boodshielddamagesustained + var_00;
    }

    if(lib_0547::is_solo() && is_boss_weapon(var_01) && var_00 > 80) {
      var_00 = 80;
    } else if(var_00 > 10 && !is_boss_weapon(var_01)) {
      var_00 = 10;
    }

    var_02 = var_00;
    if(self.bloodblockhealth - var_02 < 0) {
      var_02 = self.bloodblockhealth;
      if(isDefined(self.boodshielddamagesustained)) {
        self.boodshielddamagesustained = 0;
      }

      self notify("blood_health_empty");
    } else {
      lib_0378::func_8D74("zmb_shield_hit");
    }

    self.bloodblockhealth = self.bloodblockhealth - var_02;
    thread shield_health_regen();
  }
}

solo_or_not_boss_weapon(param_00) {
  if(lib_0547::is_solo()) {
    return 1;
  }

  return !is_boss_weapon(param_00);
}

is_boss_weapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "zombie_king_uber") || issubstr(param_00, "zombie_king_uber_flame") || issubstr(param_00, "zombie_king_uber_sun") || issubstr(param_00, "geist_bomb_artil") || issubstr(param_00, "geist_blast_red")) {
    return 1;
  }

  return 0;
}

shield_health_regen() {
  self notify("shield_health_regen_begin");
  self endon("shield_health_regen_begin");
  self endon("shield_health_regen_interrupt");
  wait(4);
  while(self.bloodblockhealth < 100) {
    if(self.bloodblockhealth == 0 && common_scripts\utility::func_562E(self.bloodui_active)) {
      self setclientomnvar("ui_onevone_show_class_menu", 1);
      self setclientomnvar("ui_onevone_class_5", -1);
    }

    self.bloodblockhealth = self.bloodblockhealth + 5;
    wait 0.05;
  }
}

shield_block_set_bar_color(param_00) {
  if(param_00 / 100 >= 1) {
    self.var_56 = (1, 0, 0);
    return;
  }

  if(param_00 / 100 < 1) {
    self.var_56 = (0.6, 0, 0);
  }
}

shield_block_fx_on() {
  level notify("shield_block_on");
  self.shieldblockfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_blood_shield_block"), self, "TAG_FX", 1);
  triggerfx(self.shieldblockfx);
  function_014E(self.shieldblockfx, 1);
  self.shieldblockfx thread lib_0547::func_2D19(self);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldblockfx);
}

shield_block_fx_off() {
  level notify("shield_block_off");
  if(isDefined(self.shieldblockfx)) {
    self.shieldblockfx delete();
  }

  self.shieldblockfx = undefined;
}

sheild_bayo_charge_result(param_00) {
  self method_8036(1, 0.2);
  self.bayonetboosthc = 0;
  wait 0.05;
  lib_0547::func_7ACD();
  if(param_00 == "sprint_melee_charge_end") {
    return;
  }

  if(param_00 == "sprint_melee_charge_attack") {
    thread shield_slam();
    return;
  }

  if(param_00 == "death") {
    return;
  }
}

shield_melee_cone(param_00) {
  self endon("melee_ability_interrupt");
  self setclientomnvar("ui_onevone_opponent_client_num", 1);
  var_01 = lib_0586::zombies_hit_by_melee_cone(92, 90);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_shield_hit(var_01[var_02], var_02);
  }

  self.shieldbashfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_blood_shield_bash"), self, "TAG_FX", 1);
  triggerfx(self.shieldbashfx);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldbashfx);
  self.shieldbashfx thread lib_0547::func_2D20(self, "melee_ability_interrupt");
  wait 0.05;
  if(isDefined(self.shieldbashfx)) {
    self.shieldbashfx delete();
    self.shieldbashfx = undefined;
  }

  lib_0378::func_8D74("zmb_shield_bash", self.var_116);
}

delayed_shield_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("zmb_shield_bash", param_00.var_116);
  param_00 dodamage(level.var_8AFE, self getEye(), self, self, "MOD_MELEE", "shield_cleave_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbybladebarbarossa)) {
      lib_0547::func_7D1B(self, param_00, "far");
    }
  }
}

shield_slam() {
  self endon("disconnect");
  var_00 = self geteyeangles();
  var_01 = anglestoaxis(var_00);
  var_02 = self getEye() + var_01["forward"] * 48;
  self.shieldbashfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_blood_shield_bash"), self, "TAG_FX", 1);
  triggerfx(self.shieldbashfx);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldbashfx);
  wait 0.05;
  self.shieldbashfx delete();
  self.shieldbashfx = undefined;
  var_03 = lib_0547::get_zombies_touching_sphere(var_02, 90, 1, self);
  var_03 = function_01AC(var_03, var_02);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    thread delayed_shield_slam(var_03[var_04], var_04);
  }
}

delayed_shield_slam(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("zmb_shield_bash", param_00.var_116);
  param_00 dodamage(level.shieldslamdamage, self getEye(), self, self, "MOD_MELEE", "shield_slam_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbybladebarbarossa)) {
      lib_0547::func_7D1B(self, param_00, "close");
    }
  }
}

shield_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_shield_emp_zm"] = 1;
  level.var_62B3["zom_dlc4_shield_emp_zm"] = ::shield_emp_modify_damage;
  level.meleeaoeweapons["shield_slam_zm"] = 1;
  level.meleeaoeweapons["shield_cleave_emp_zm"] = 1;
  level.var_2FE9["zom_dlc4_shield_emp_zm"] = 1;
  level.var_4D3D["zom_dlc4_shield_emp_zm"] = 1;
  level.var_2FE9["shield_cleave_emp_zm"] = 1;
  level.var_4D3D["shield_cleave_emp_zm"] = 1;
  level.obj_shield = getent("blood_shield_dome", "targetname");
  level.obj_shield.hidden_org = level.obj_shield.var_116;
  level.obj_shield notsolid();
  setup_melee_weapon_ownership(::has_shield_emp, ::shield_emp_gained, ::shield_emp_lost);
}

give_shield_emp_weapon(param_00) {
  try_drop_old_weapon("shield_emp", param_00);
  if(!lib_0547::func_73F9(self, "zom_dlc4_shield_emp_zm")) {
    lib_0586::func_78C("zom_dlc4_shield_emp_zm");
    self switchtoweapon("zom_dlc4_shield_emp_zm");
  }

  thread wep_disco_protect("shield_emp");
  thread wep_death_protect("shield_emp");
  level.ravenweaponmanager["shield_emp"].var_117 = self;
}

try_drop_old_weapon(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!common_scripts\utility::func_562E(param_02) && !common_scripts\utility::func_562E(param_03)) {
    self notify("return_faked_scythe");
    if(lib_0547::func_5565(self.forcedblooddest, "zom_dlc4_scythe_zm")) {
      self.forcedblooddest = undefined;
    }
  }

  var_04 = test_raven_weapon_owner();
  if(common_scripts\utility::func_562E(param_02) || isDefined(var_04) && var_04 != param_00) {
    take_raven_weapon(var_04);
    if(!isDefined(self.isintrial)) {
      if(!common_scripts\utility::func_562E(param_01) || common_scripts\utility::func_562E(param_02)) {
        thread spawn_raven_weapon(var_04, self.var_116, self.var_1D, 0.25);
      }
    }
  }

  var_05 = function_0337(param_00, "_emp");
  try_take_dlc4_melee_from_other_player(var_05, var_05 + "_emp", "shovel_zm");
  if(common_scripts\utility::func_562E(param_02)) {
    lib_0586::func_78E(common_scripts\utility::func_7A33(self getweaponslistprimaries()));
  }
}

has_shield_emp() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc4_shield_emp_zm");
}

shield_emp_gained() {
  thread shield_emp_think();
  if(!common_scripts\utility::func_562E(self.has_shown_shield_emp_hint)) {
    self.has_shown_shield_emp_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_shield_emp", self);
  }

  if(isDefined(level.ravenweaponmanager["shield_emp"].on_gained_func)) {
    self[[level.ravenweaponmanager["shield_emp"].on_gained_func]]();
  }
}

shield_emp_lost() {
  self notify(level.ravenweaponmanager["shield_emp"].wep_loss_notify);
}

shield_emp_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if((param_01 method_8128() && !param_01 method_8661()) || param_01 method_8128() && param_01 method_83DE()) {
    param_00.ignorethiszerodamage = 1;
    return 0;
  }

  return level.shieldempdamage;
}

shield_emp_think() {
  var_00 = setup_melee_abilityinfo("zom_dlc4_shield_emp_zm", 0.22, level.ravenweaponmanager["shield_emp"].wep_loss_notify, ::shield_emp_melee_cone, 1);
  thread shield_emp_blood_block_enable();
  thread shield_emp_uber_block_run();
  thread run_melee_ability(var_00);
  thread bayo_charge_watcher_zm("zom_dlc4_shield_emp_zm", ::sheild_bayo_charge_start, ::sheild_emp_bayo_charge_result);
}

shield_emp_blood_block_enable() {
  self endon("disconnect");
  self.bloodblockhealth = 200;
  self.bloodshieldblock_test_func = ::shield_emp_block_test_func;
  childthread shield_emp_block_think();
  while(has_shield_emp()) {
    wait 0.05;
  }

  self notify("blood_block_disable");
}

shield_emp_uber_block_run() {
  self endon("disconnect");
  while(has_shield_emp()) {
    if(shield_emp_uber_conditions() && isDefined(level.obj_shield)) {
      self.reserved_plate = shield_player_touching_full_blood_plate();
      if(isDefined(self.reserved_plate) && self.reserved_plate common_scripts\utility::func_3794("plate_reserved")) {
        continue;
      }

      if(isDefined(self.reserved_plate) && !isDefined(self.blood_shield_uber_fx)) {
        self.blood_shield_uber_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_blood_shield_uber"), self.reserved_plate.plate_model, "TAG_ORIGIN");
        self.blood_shield_uber_fx.owener = self;
        triggerfx(self.blood_shield_uber_fx);
        level.obj_shield.var_116 = self.reserved_plate.var_116;
        level.obj_shield thread shield_uber_block_disco_protect(self);
        level.obj_shield solid();
        level.obj_shield.var_9297 = gettime();
        self.reserved_plate thread maps\mp\mp_zombie_descent::blood_plate_boss_reserve(self);
        self.blood_shield_uber_fx thread shield_emp_uber_danger_zone();
        while(!shield_timeout_reached() && has_shield_emp()) {
          self.reserved_plate maps\mp\mp_zombie_descent::blood_plate_subtract();
          foreach(var_01 in level.var_744A) {
            if(distance2d(var_01.var_116, level.obj_shield.var_116) < 100) {
              var_01 lib_0547::func_73AC(1);
            }
          }

          wait(1);
        }

        self.reserved_plate maps\mp\mp_zombie_descent::blood_plate_empty();
        cleanup_blood_shield_uber(self.blood_shield_uber_fx, self.reserved_plate);
      } else if(isDefined(self.blood_shield_uber_fx)) {
        cleanup_blood_shield_uber(self.blood_shield_uber_fx, self.reserved_plate);
      }

      continue;
    }

    if(isDefined(self.blood_shield_uber_fx)) {
      cleanup_blood_shield_uber(self.blood_shield_uber_fx, self.reserved_plate);
    }

    wait 0.05;
  }
}

cleanup_blood_shield_uber(param_00, param_01) {
  level.obj_shield notsolid();
  level.obj_shield.var_116 = level.obj_shield.hidden_org;
  level.obj_shield.var_9297 = undefined;
  param_00 delete();
  param_01 notify("release_plate");
  level.obj_shield notify("unlinked_from_player");
}

shield_timeout_reached() {
  var_00 = gettime();
  if(var_00 - level.obj_shield.var_9297 > 6000) {
    return 1;
  }

  return 0;
}

shield_uber_block_disco_protect(param_00) {
  self endon("unlinked_from_player");
  self notify("shield_disco_protect");
  self endon("shield_disco_protect");
  var_01 = param_00.reserved_plate;
  var_02 = param_00.blood_shield_uber_fx;
  param_00 waittill("disconnect");
  thread cleanup_blood_shield_uber(var_02, var_01);
}

shield_emp_uber_danger_zone() {
  var_00 = self;
  while(isDefined(var_00)) {
    foreach(var_02 in lib_0547::func_408F()) {
      if(distance(var_00.var_116, var_02.var_116) > 128 || lib_0547::func_5565(level.zombie_king, var_02) || common_scripts\utility::func_562E(var_02.var_8F2B)) {
        continue;
      }

      var_03 = lib_0580::func_8317(var_02.var_116, var_00.owener);
      var_03.var_6AA0 = ::shield_stun;
      var_02 thread lib_0547::func_7D1A("tesla_shock", [var_03], 1);
    }

    wait 0.05;
  }
}

shield_stun(param_00) {
  lib_0547::func_7D1B(self, self, "medium");
}

shield_emp_uber_conditions() {
  return common_scripts\utility::func_562E(self adsButtonPressed() && self getcurrentweapon() == "zom_dlc4_shield_emp_zm" && self.bloodblockhealth > 0 && !lib_0547::func_577E(self));
}

shield_player_touching_full_blood_plate() {
  foreach(var_01 in level.blood_plates) {
    if(isDefined(var_01.plate_damage_trig) && self istouching(var_01.plate_damage_trig) && lib_0547::func_5565(var_01.isbloodfull, 1)) {
      return var_01;
    }
  }
}

shield_emp_block_test_func(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!has_shield_emp() || !lib_0547::func_5565(self getcurrentweapon(), "zom_dlc4_shield_emp_zm") || !lib_0547::func_5565(self.is_bloodblocking, 1) || self method_8128() || self method_8661() || self method_83DE()) {
    return 0;
  }

  if(isDefined(param_01) && param_01 is_out_of_bounds_trigger()) {
    return 0;
  }

  if(self.bloodblockhealth >= 0 && maps\mp\_utility::func_3B8E(self, param_00, 60)) {
    return 1;
  }

  return 0;
}

shield_emp_block_think() {
  var_00 = self;
  var_00 thread shield_emp_manage_health();
  for(;;) {
    var_01 = isalive(self);
    if(var_01 && self getcurrentweapon() == "zom_dlc4_shield_emp_zm" && self.bloodblockhealth > 0 && !common_scripts\utility::func_562E(level.var_22F0)) {
      if(!isDefined(self.shieldblockfx)) {
        shield_emp_block_fx_on();
      }

      if(!lib_0547::func_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 1;
        thread shield_emp_block_ui();
      }

      self.is_bloodblocking = 1;
    } else if(var_01 && self getcurrentweapon() == "zom_dlc4_shield_emp_zm" && self.bloodblockhealth <= 0 && !common_scripts\utility::func_562E(level.var_22F0)) {
      if(isDefined(self.shieldblockfx)) {
        shield_emp_block_fx_off();
      }

      shield_punish(3);
      self.is_bloodblocking = 0;
    } else {
      if(isDefined(self.shieldblockfx)) {
        shield_emp_block_fx_off();
      }

      if(lib_0547::func_5565(self.bloodui_active, 1)) {
        self.bloodui_active = 0;
        self setclientomnvar("ui_onevone_class_5", -3);
      }

      self.is_bloodblocking = 0;
    }

    if(!has_shield_emp()) {
      return;
    }

    common_scripts\utility::func_A715("weapon_change", "blood_health_empty", "weapon_given", "weapon_taken", "zombie_player_spawn_finished", "offhand_end", "weapon_switch_started", "boss_scene_end", "death");
    while(self method_8126()) {
      if(isDefined(self.shieldblockfx)) {
        shield_emp_block_fx_off();
      }

      wait 0.05;
    }
  }
}

shield_emp_block_ui() {
  if(!isDefined(self.pre_bloodblockhealth)) {
    self.pre_bloodblockhealth = self.bloodblockhealth;
  }

  self setclientomnvar("ui_onevone_show_class_menu", 2);
  self setclientomnvar("ui_onevone_class_5", self.bloodblockhealth);
  while(lib_0547::func_5565(self.bloodui_active, 1)) {
    if(self.bloodblockhealth != self.pre_bloodblockhealth) {
      self.pre_bloodblockhealth = self.bloodblockhealth;
      if(self.bloodblockhealth <= 0) {
        self setclientomnvar("ui_onevone_class_5", -2);
        continue;
      }

      self setclientomnvar("ui_onevone_class_5", self.bloodblockhealth);
    }

    wait 0.05;
  }
}

shield_emp_manage_health() {
  while(has_shield_emp()) {
    self waittill("br_block_hit", var_00, var_01);
    self notify("shield_health_regen_interrupt");
    if(isDefined(self.boodshielddamagesustained)) {
      self.boodshielddamagesustained = self.boodshielddamagesustained + var_00;
    }

    if(lib_0547::is_solo() && is_boss_weapon(var_01) && var_00 > 180) {
      var_00 = 180;
    } else if(var_00 > 10 && !is_boss_weapon(var_01)) {
      var_00 = 10;
    }

    var_02 = var_00;
    if(self.bloodblockhealth - var_02 < 0) {
      var_02 = self.bloodblockhealth;
      if(isDefined(self.boodshielddamagesustained)) {
        self.boodshielddamagesustained = 0;
      }

      self notify("blood_health_empty");
    } else {
      lib_0378::func_8D74("zmb_shield_hit");
    }

    self.bloodblockhealth = self.bloodblockhealth - var_02;
    thread shield_emp_health_regen();
  }
}

shield_emp_health_regen() {
  self notify("shield_health_regen_begin");
  self endon("shield_health_regen_begin");
  self endon("shield_health_regen_interrupt");
  wait(3);
  while(self.bloodblockhealth < 200) {
    if(self.bloodblockhealth == 0 && common_scripts\utility::func_562E(self.bloodui_active)) {
      self setclientomnvar("ui_onevone_show_class_menu", 2);
      self setclientomnvar("ui_onevone_class_5", -1);
    }

    self.bloodblockhealth = self.bloodblockhealth + 5;
    wait 0.05;
  }
}

shield_emp_block_set_bar_color(param_00) {
  if(param_00 / 100 >= 1) {
    self.var_56 = (1, 0, 0);
    return;
  }

  if(param_00 / 100 < 1) {
    self.var_56 = (0.6, 0, 0);
  }
}

shield_emp_block_fx_on() {
  level notify("shield_block_on");
  self.shieldblockfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_blood_shield_block_emp"), self, "TAG_FX", 1);
  triggerfx(self.shieldblockfx);
  function_014E(self.shieldblockfx, 1);
  self.shieldblockfx thread lib_0547::func_2D19(self);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.shieldblockfx);
}

shield_emp_block_fx_off() {
  level notify("shield_block_off");
  if(isDefined(self.shieldblockfx)) {
    self.shieldblockfx delete();
  }

  self.shieldblockfx = undefined;
}

shield_punish(param_00) {
  var_01 = 30;
  self endon("death");
  self shellshock("zm_heavy_hit", param_00, param_00);
  self method_8308(0);
  self method_8322();
  self method_8326();
  self playrumbleonentity("damage_heavy");
  var_02 = self.var_116 - self.var_116 + anglesToForward(self.var_1D) * 10;
  var_02 = (var_02[0], var_02[1], 0);
  var_02 = var_01 * vectornormalize(var_02);
  var_02 = (var_02[0], var_02[1], 125);
  self setvelocity(var_02);
  lib_0378::func_8D74("zmb_shield_break");
  wait(param_00);
  self method_8308(1);
  self method_8323();
  self method_8327();
}

shield_emp_melee_cone(param_00) {
  self endon("melee_ability_interrupt");
  self setclientomnvar("ui_onevone_opponent_client_num", 2);
  var_01 = lib_0586::zombies_hit_by_melee_cone(220, 75);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_shield_emp_hit(var_01[var_02], var_02);
  }

  childthread attempt_reflect_king_blast(92, 90);
  var_03 = common_scripts\utility::func_44F5("zmb_blood_shield_bash_emp");
  playFX(var_03, self.var_116 + (0, 0, 50), anglesToForward(self geteyeangles()));
  lib_0378::func_8D74("zmb_bloodraven_shield_bash", self.var_116);
}

delayed_shield_emp_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("zmb_bloodraven_shield_bash", param_00.var_116);
  param_00 dodamage(level.shieldempdamage, self getEye(), self, self, "MOD_MELEE", "shield_cleave_emp_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbybladebarbarossa)) {
      lib_0547::func_7D1B(self, param_00, "medium");
    }
  }
}

sheild_bayo_charge_start() {
  self method_8036(1.25, 0.2);
  self.bayonetboosthc = 1;
  wait 0.05;
  lib_0547::func_7ACD();
}

create_shield_push_params(param_00) {
  var_01 = spawnStruct();
  var_01.var_117 = param_00;
  var_01.ownerinitialangles = param_00 geteyeangles();
  return var_01;
}

sheild_emp_bayo_charge_result(param_00) {
  self method_8036(1, 0.2);
  self.bayonetboosthc = 0;
  wait 0.05;
  lib_0547::func_7ACD();
  if(param_00 == "sprint_melee_charge_end") {
    return;
  }

  if(param_00 == "sprint_melee_charge_attack") {
    thread shield_emp_slam();
    return;
  }

  if(param_00 == "death") {
    return;
  }
}

shield_emp_slam() {
  self endon("disconnect");
  var_00 = self geteyeangles();
  var_01 = anglestoaxis(var_00);
  var_02 = self getEye() + var_01["forward"] * 48;
  var_03 = common_scripts\utility::func_44F5("zmb_blood_shield_bash_emp");
  playFX(var_03, self.var_116 + (0, 0, 50), anglesToForward(self.var_1D));
  var_04 = lib_0547::get_zombies_touching_sphere(var_02, 124, 1, self);
  var_04 = function_01AC(var_04, var_02);
  if(isDefined(var_04[0])) {
    thread delayed_shield_push_hit(var_04[0], shield_can_throw(var_04[0]));
  }
}

delayed_shield_push_hit(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  param_00 endon("death");
  wait 0.05;
  if(param_01) {
    wait(0);
    var_03 = create_shield_push_params(var_02);
    param_00.throwingzombie = 1;
    param_00 lib_0547::func_7D1A("shield_push", [var_03], 0.25);
    return;
  }

  var_04 = lib_0547::func_A51(param_00.var_A4B);
  var_05 = common_scripts\utility::func_562E(param_00.scaleshealthbyplayers) || common_scripts\utility::func_562E(var_04.scaleshealthbyplayers);
  var_06 = 1;
  lib_0378::func_8D74("zmb_shield_bash", param_00.var_116);
  param_00 dodamage(level.shieldempdamage, var_02 getEye(), var_02, var_02, "MOD_MELEE", "shield_slam_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(common_scripts\utility::func_562E(0)) {
    if(!common_scripts\utility::func_562E(1) || level.var_744A.size <= 0) {
      if(isDefined(param_00.var_A4B)) {
        if(isDefined(var_04) && common_scripts\utility::func_562E(var_04.knockbybladebarbarossa)) {
          lib_0547::func_7D1B(var_02, param_00, "far");
          return;
        }

        return;
      }

      return;
    }
  }
}

shield_push_interrupt(param_00) {}

shield_can_stun(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = lib_0547::func_A51(param_00.var_A4B);
  }

  if(common_scripts\utility::func_562E(param_00.noenergyhold)) {
    return 0;
  }

  return common_scripts\utility::func_562E(param_01.energyhold);
}

shield_can_secondary_stun(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = lib_0547::func_A51(param_00.var_A4B);
  }

  if(common_scripts\utility::func_562E(param_00.noenergyholdsecondary)) {
    return 0;
  }

  return common_scripts\utility::func_562E(param_01.energyholdsecondary);
}

shield_can_secondary_slow(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = lib_0547::func_A51(param_00.var_A4B);
  }

  if(common_scripts\utility::func_562E(param_00.noenergyslowsecondary)) {
    return 0;
  }

  return common_scripts\utility::func_562E(param_01.energyslowsecondary);
}

shield_can_throw(param_00, param_01) {
  if(param_00 maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    return 0;
  }

  if(!isDefined(param_01)) {
    param_01 = lib_0547::func_A51(param_00.var_A4B);
  }

  if(common_scripts\utility::func_562E(param_00.notthrowable)) {
    return 0;
  }

  return common_scripts\utility::func_562E(param_01.throwable);
}

shield_can_stun_kill(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = lib_0547::func_A51(param_00.var_A4B);
  }

  if(common_scripts\utility::func_562E(param_00.noenergyholdkill)) {
    return 0;
  }

  return common_scripts\utility::func_562E(param_01.energyholdkill);
}

shield_push_end(param_00) {
  var_01 = self;
  var_01.immunetotackling = undefined;
  var_01 set_shield_push_state(2);
  var_01 notify("sword_throw_end");
  if(var_01.var_A4B == "zombie_exploder") {
    var_01 lib_0563::zombie_exploder_attempt_detonate(param_00.var_117, "shield_slam_zm");
  }

  var_01 dodamage(var_01.var_BC + 1, var_01.var_116, param_00.var_117, param_00.var_117, "MOD_MELEE", "shield_slam_zm", "head");
  var_01 scragentsetscripted(0);
  var_01 maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "shield_push");
  var_01 method_839A(1, 1);
  set_shield_push_state(undefined);
  var_01.swordthrowowner = undefined;
}

shield_push_run(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01.immunetotackling = 1;
  var_01.shieldpushowner = param_00.var_117;
  var_01 scragentsetscripted(1);
  var_01 maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "shield_push");
  var_01 thread shield_push_handle_collision(param_00);
  if(common_scripts\utility::func_562E(1)) {
    var_01 thread shield_push_damage_impacted_zombies(param_00);
  }

  playFXOnTag(common_scripts\utility::func_44F5("zmb_raven_sword_barb_burst"), var_01, "tag_origin");
  var_01 lib_0378::func_8D74("zmb_shield_bash");
  var_01 shield_push_animate(param_00);
}

set_shield_push_state(param_00) {
  var_01 = self;
  var_01.shieldpushstate = param_00;
}

shield_push_handle_collision(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01 endon("shield_push_end");
  if(common_scripts\utility::func_562E(0)) {
    var_02 = self gettagorigin("J_Spine4");
    var_03 = spawn("script_model", var_02);
    var_03 setModel("tag_origin");
    var_03.var_117 = var_01;
    var_04 = 180;
    var_03 method_8449(var_01, "tag_origin", (0, 0, 0), (0, var_04, 0));
    var_01 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_03);
    thread cleanup_ent_on_shield_push_end(var_03);
    var_05 = spawnStruct();
    var_05.var_2434 = 37;
    var_05.var_60C1 = 55;
    var_05.var_3A20 = 82;
    var_05.var_1B70 = 160;
    var_01 childthread lib_0547::tackle_thread(var_03, var_05);
  }

  var_06 = var_01.var_116;
  var_07 = 100;
  var_08 = param_00.ownerinitialangles[1];
  var_09 = 10;
  wait(0.25);
  for(;;) {
    wait 0.05;
    var_0A = var_01.var_116 - var_06;
    if(lengthsquared(var_0A) < var_07) {
      break;
    }

    var_0B = vectortoyaw(var_0A);
    var_0C = abs(angleclamp180(var_0B - var_08));
    if(var_0C > var_09) {
      break;
    }

    var_06 = var_01.var_116;
  }

  if(common_scripts\utility::func_562E(1)) {
    var_0E = lib_0547::func_43F0(var_01.var_116, var_01.var_8302, var_01.var_8303 * 1.2, 1);
    foreach(var_10 in var_0E) {
      if(isDefined(var_01.thrownimpacts)) {
        var_11 = var_01.thrownimpacts[var_10 getentitynumber()];
        if(isDefined(var_11) && gettime() - var_11 <= 100) {
          continue;
        }
      }

      shield_push_zombie_impact_damage(param_00, var_01, var_10);
    }
  }

  var_01 notify("shield_push_blocked");
}

shield_push_damage_impacted_zombies(param_00) {
  var_01 = self;
  var_01 endon("shield_push_blocked");
  var_01 endon("shield_push_end");
  var_01 endon("death");
  for(;;) {
    var_01 waittill("touch", var_02);
    if(!function_01EF(var_02)) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    if(isDefined(var_02.var_A) && var_02.var_A == level.var_746E) {
      continue;
    }

    if(var_02 == var_01) {
      continue;
    }

    if(isDefined(var_02.shieldpushstate)) {
      continue;
    }

    shield_push_zombie_impact_damage(param_00, var_01, var_02);
  }
}

shield_push_zombie_impact_damage(param_00, param_01, param_02) {
  if(shield_can_stun(param_02) || shield_can_secondary_stun(param_02) || shield_can_secondary_slow(param_02)) {
    lib_0547::func_7D1B(lib_0547::create_temp_tackler(param_01), param_02, "close", param_01.shieldpushowner);
  }

  if(lib_0547::func_5565(level.zombie_king, param_02)) {
    var_03 = param_01.var_1D;
    var_03 = (var_03[0], angleclamp180(var_03[1] + 10 + 1), var_03[2]);
    param_01.var_1D = var_03;
  }

  param_02 dodamage(level.shieldpushimpactdamage, param_01.var_116, param_00.var_117, param_00.var_117, "MOD_MELEE", "shield_slam_zm");
  if(common_scripts\utility::func_562E(1) && isalive(param_02)) {
    if(param_02.var_A4B == "zombie_heavy") {
      param_02 thread lib_0567::zombie_heavy_set_grudge(param_00.var_117);
    }
  }

  if(param_01.var_A4B == "zombie_exploder") {
    param_01 lib_0563::zombie_exploder_attempt_detonate(param_00.var_117, "shield_slam_zm");
  }

  param_01 dodamage(level.shieldpushimpactdamage, param_01.var_116, param_00.var_117, param_00.var_117, "MOD_MELEE", "shield_slam_zm");
  if(!isDefined(param_01.thrownimpacts)) {
    param_01.thrownimpacts = [];
  }

  param_01.thrownimpacts[param_02 getentitynumber()] = gettime();
}

shield_push_handle_zombie_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = self;
  if(isDefined(self.shieldpushstate)) {
    if(var_09.var_A4B == "zombie_exploder") {
      var_09 lib_0563::zombie_exploder_attempt_detonate(var_09.shieldpushowner, "shield_slam_zm");
    }
  }
}

cleanup_ent_on_shield_push_end(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01 waittill("shield_push_end");
  param_00 delete();
}

shield_push_animate(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_02 = randomfloatrange(0.5, 2);
  set_shield_push_state(0);
  var_03 = maps\mp\agents\_scripted_agent_anim_util::func_434D("energy_throw_start");
  var_04 = self method_83DB(var_03);
  var_05 = randomint(var_04);
  var_06 = solve_yaw_for_shield_push_anim(var_03, var_05, param_00.ownerinitialangles[1]);
  var_01.var_1D = (var_01.var_1D[0], var_06, var_01.var_1D[2]);
  var_07 = 2 / var_02;
  var_01 method_839C("anim deltas");
  var_01 scragentsetorientmode("face angle rel", (var_01.var_1D[0], var_06, var_01.var_1D[2]));
  var_01 method_839D("gravity");
  var_01 method_839A(var_07, 1);
  var_01 set_shield_push_state(1);
  var_03 = var_01 maps\mp\agents\_scripted_agent_anim_util::func_434D("energy_throw_loop");
  var_04 = var_01 method_83DB(var_03);
  var_05 = randomint(var_04);
  var_06 = solve_yaw_for_shield_push_anim(var_03, var_05, param_00.ownerinitialangles[1]);
  var_01 scragentsetorientmode("face angle abs", (var_01.var_1D[0], var_06, var_01.var_1D[2]));
  var_08 = 2;
  var_09 = randomfloat(1);
  var_01 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_03, var_05, var_02, var_09);
  var_01 maps\mp\_utility::func_A6D1(var_08, "shield_push_blocked");
}

solve_yaw_for_shield_push_anim(param_00, param_01, param_02) {
  var_03 = self method_83D8(param_00, param_01);
  var_04 = getmovedelta(var_03, 0, 1);
  var_05 = vectortoangles(var_04);
  return angleclamp180(param_02 - var_05[1]);
}

hammer_init() {
  level.zombiemeleeweapon["zom_dlc4_hammer_zm"] = 1;
  level.var_62B3["zom_dlc4_hammer_zm"] = ::hammer_modify_damage;
  level.meleeaoeweapons["hammer_cleave_zm"] = 1;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_03["hit_zombie_snd"] = "zmb_HAMMER_melee_hit_wooden";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_HAMMER_melee_hit_wooden";
  level.var_6DF9["default"]["zom_dlc4_hammer_zm"] = var_03;
  setup_melee_weapon_ownership(::has_hammer, ::hammer_gained, ::hammer_lost);
}

give_hammer_weapon() {
  try_drop_old_weapon("hammer");
  if(!lib_0547::func_73F9(self, "zom_dlc4_hammer_zm")) {
    lib_0586::func_78C("zom_dlc4_hammer_zm");
    self switchtoweapon("zom_dlc4_hammer_zm");
  }

  thread wep_disco_protect("hammer");
  thread wep_death_protect("hammer");
  level.ravenweaponmanager["hammer"].var_117 = self;
}

has_hammer() {
  var_00 = self;
  var_01 = var_00 method_82D5();
  return issubstr(var_01, "zom_dlc4_hammer_zm");
}

hammer_gained() {
  thread hammer_think();
  if(!common_scripts\utility::func_562E(self.has_shown_hammer_hint)) {
    self.has_shown_hammer_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_hammer", self);
  }

  if(isDefined(level.ravenweaponmanager["hammer"].on_gained_func)) {
    self[[level.ravenweaponmanager["hammer"].on_gained_func]]();
  }
}

hammer_lost() {
  self notify(level.ravenweaponmanager["hammer"].wep_loss_notify);
}

hammer_think() {
  var_00 = setup_heavy_melee_abilityinfo("zom_dlc4_hammer_zm", 0.45, level.ravenweaponmanager["hammer"].wep_loss_notify, ::hammer_melee_cone, 0.3);
  thread run_heavy_melee_ability(var_00);
}

hammer_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8661()) {
    return 0;
  }

  return level.hammerdamage;
}

hammer_melee_cone(param_00) {
  self endon("melee_ability_interrupt");
  var_01 = lib_0586::zombies_hit_by_melee_cone(125, 80);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_hammer_hit(var_01[var_02], var_02);
  }
}

delayed_hammer_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  var_03 = spawnStruct();
  var_03.var_721C = self;
  var_03.var_ABE6 = param_00.var_116;
  var_03.var_4DCF = "none";
  var_03.var_60B8 = undefined;
  var_03.var_1D0 = "hammer_cleave_zm";
  var_03.delaysec = undefined;
  lib_0378::func_8D74("zmb_HAMMER_melee_hit_wooden", var_03);
  param_00 dodamage(level.hammercleavedamage, self getEye(), self, self, "MOD_MELEE", "hammer_cleave_zm", "none");
  playFXOnTag(level.var_611["zmb_hammer_smack"], param_00, "TAG_EYE");
  if(isDefined(param_00.var_A4B)) {
    var_04 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_04) && common_scripts\utility::func_562E(var_04.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "far");
    }
  }
}

sqrd_dist_between_segments(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = 1E-06;
  var_06 = param_03 - param_02;
  var_07 = param_01 - param_00;
  var_08 = param_00 - param_02;
  var_09 = vectordot(var_06, var_06);
  var_0A = vectordot(var_07, var_07);
  var_0B = vectordot(var_07, var_06);
  var_0C = vectordot(var_06, var_08);
  var_0D = vectordot(var_07, var_08);
  var_0E = var_09 * var_0A - var_0B * var_0B;
  var_0F = 0;
  var_10 = 0;
  if(var_0E <= var_05) {
    if(var_0B > var_09) {
      var_0F = var_0D / var_0B;
    } else {
      var_0F = var_0C / var_09;
    }
  } else {
    var_0F = var_0C * var_0A - var_0B * var_0D / var_0E;
    var_10 = var_0B * var_0C - var_0D * var_09 / var_0E;
  }

  var_0F = clamp(var_0F, 0, 1);
  var_10 = clamp(var_10, 0, 1);
  var_11 = param_02 + var_06 * var_0F;
  var_12 = param_00 + var_07 * var_10;
  var_13 = var_12 - var_11;
  var_14 = vectordot(var_13, var_13);
  var_04[1] = var_12;
  var_04[2] = var_11;
  var_04[0] = var_14;
  return var_04;
}

do_zombie_trace_damage(param_00, param_01, param_02) {
  var_03 = lib_0547::func_408F();
  foreach(var_05 in var_03) {
    var_06 = var_05.var_8302;
    var_07 = var_05.var_8303;
    var_08 = var_07 + self.hammer_radius;
    var_09 = var_08 * var_08;
    var_0A = sqrd_dist_between_segments(param_00, param_01, var_05.var_116, var_05.var_116 + (0, 0, var_06));
    if(var_0A[0] <= var_09) {
      [[param_02]](var_05, var_0A[1]);
    }
  }
}

do_zombie_damage_better(param_00) {
  self endon("death");
  self.hammer_old_pos = self.var_116;
  while(isDefined(self)) {
    wait 0.05;
    waittillframeend;
    do_zombie_trace_damage(self.hammer_old_pos, self.var_116, param_00);
    self.hammer_old_pos = self.var_116;
  }
}

hammer_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_hammer_emp_zm"] = 1;
  level.var_62B3["zom_dlc4_hammer_emp_zm"] = ::hammer_emp_modify_damage;
  level.meleeaoeweapons["hammer_cleave_emp_zm"] = 1;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (40, 2, 0);
  var_02 = length(var_01);
  var_03 = [];
  var_03["hit_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_world";
  var_03["hit_zombie_action"] = "pain_paired_melee_dlc2_1";
  var_03["hit_zombie_snd"] = "zmb_HAMMER_melee_hit_metal";
  var_03["fatal_worldmodel_anim"] = "va_melee_dlc2_1_zom_hit_crit_world";
  var_03["fatal_zombie_action"] = "death_melee_dlc2_1";
  var_03["dismemberment_override"] = var_00;
  var_03["fatal_zombie_pos"] = var_01;
  var_03["fatal_zombie_dist"] = var_02;
  var_03["fatal_zombie_snd"] = "zmb_HAMMER_melee_hit_metal";
  level.var_6DF9["default"]["zom_dlc4_hammer_emp_zm"] = var_03;
  setup_melee_weapon_ownership(::has_hammer_emp, ::hammer_emp_gained, ::hammer_emp_lost);
}

give_hammer_emp_weapon(param_00) {
  try_drop_old_weapon("hammer_emp", param_00);
  if(!lib_0547::func_73F9(self, "zom_dlc4_hammer_emp_zm")) {
    lib_0586::func_78C("zom_dlc4_hammer_emp_zm");
    self switchtoweapon("zom_dlc4_hammer_emp_zm");
  }

  thread wep_disco_protect("hammer_emp");
  thread wep_death_protect("hammer_emp");
  level.ravenweaponmanager["hammer_emp"].var_117 = self;
}

has_hammer_emp() {
  var_00 = self;
  var_01 = var_00 method_82D5();
  return issubstr(var_01, "zom_dlc4_hammer_emp_zm");
}

hammer_emp_gained() {
  thread hammer_emp_think();
  if(!common_scripts\utility::func_562E(self.has_shown_hammer_emp_hint)) {
    self.has_shown_hammer_emp_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_hammer_emp", self);
  }

  if(isDefined(level.ravenweaponmanager["hammer_emp"].on_gained_func)) {
    self[[level.ravenweaponmanager["hammer_emp"].on_gained_func]]();
  }
}

hammer_emp_lost() {
  self notify(level.ravenweaponmanager["hammer_emp"].wep_loss_notify);
}

hammer_emp_think() {
  setdvarifuninitialized("HAMMER_emp_debug", 0);
  thread hammer_throw_think();
  thread hammer_throw_toggle_equip();
  var_00 = setup_heavy_melee_abilityinfo("zom_dlc4_hammer_emp_zm", 0.45, level.ravenweaponmanager["hammer_emp"].wep_loss_notify, ::hammer_emp_melee_cone, 0.3);
  thread run_heavy_melee_ability(var_00);
}

hammer_throw_think() {
  self endon(level.ravenweaponmanager["hammer_emp"].wep_loss_notify);
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "zom_hammer_grenade_zm") {
      lib_0378::func_8D74("dlc4_throw_hammer");
      self.weapon_previous_to_hammer = common_scripts\utility::func_4550();
      var_00 thread handle_hammer_grenade(self);
    }
  }
}

handle_hammer_grenade(param_00) {
  self method_805C();
  wait 0.05;
  var_01 = hammer_replace_projectile_with_model(param_00);
  var_01.htarget = var_01.tag_tracker;
  var_01 childthread hammer_throw_arm();
  var_01 childthread hammer_throw_end();
  var_01 thread hammer_detonate_on_death(param_00);
  var_01.var_117 = param_00;
  var_01.var_117 thread hammer_handle_melee_attack();
  var_01.var_117.hammer_throw_on_cooldown = 1;
  var_01.hammer_radius = 22;
  var_02 = undefined;
  var_01 childthread do_zombie_damage_better(::hammer_do_flight_damage);
  var_03 = undefined;
  var_04 = vectornormalize(anglesToForward(var_01.var_117 geteyeangles()));
  var_05 = var_01.var_117 getEye() + var_04 * 2000;
  var_01.tag_tracker.end_point = var_05;
  var_01.tag_tracker.forward_dir = var_04;
  var_06 = vectornormalize(anglestoright(var_01.var_117 geteyeangles()));
  var_07 = 0.4;
  var_08 = 6;
  var_09 = 1000;
  var_0A = var_04 * var_09;
  var_09 = var_09 * 0.9;
  var_0B = (0, 0, 0.12);
  var_0B = var_0B + -0.2 * var_06;
  var_0C = vectornormalize(var_04 + var_0B);
  var_01.forward_dir = var_0C;
  var_01.var_1D = hammer_modelangles_fromdir(var_01.forward_dir);
  var_01.var_116 = var_01.var_116 - 38 * var_04;
  var_01.var_116 = var_01.var_116 - (0, 0, 8);
  playFXOnTag(level.var_611["zmb_stormhammer_trail"], var_01, "Tag_Weapon");
  var_01 lib_0378::func_8D74("aud_hammer_trail_lp");
  var_0D = 0.05;
  while(lib_0547::func_5565(var_01.inflight, 1) && vectordot(var_05 - var_01.tag_tracker.var_116, var_0A) > 0) {
    var_01.tag_tracker.next_tracker_pos = var_01.tag_tracker.var_116 + var_0A * var_0D;
    var_01.tag_tracker.var_116 = var_01.tag_tracker.next_tracker_pos;
    if(var_01.isarmed) {
      if(!function_01EF(var_01.htarget) || !isalive(var_01.htarget) || distancesquared(var_01.htarget.var_116, var_05) > distancesquared(var_01.var_116, var_05)) {
        var_01 hammer_rank_targets();
        var_02 = var_01 hammer_choose_target();
        if(!isDefined(var_02)) {
          var_02 = var_01.tag_tracker;
        }
      }
    }

    var_0E = 0;
    if(isDefined(var_02)) {
      var_01.htarget = var_02;
      var_0E = 1;
      var_02 = undefined;
    }

    var_0F = var_01.htarget.var_116;
    var_10 = var_0A * 0.9;
    var_11 = var_07;
    if(function_01EF(var_01.htarget)) {
      var_0F = var_01.htarget getEye() + (0, 0, -8);
      var_10 = var_01.htarget getvelocity();
      var_11 = var_11 + var_08;
    }

    var_12 = var_11 * var_0D;
    var_13 = var_12 * var_12;
    var_14 = distance(var_0F, var_01.var_116);
    var_15 = var_14 / var_09;
    var_16 = clamp(var_15, 0.05, 1);
    var_17 = var_0F + var_10 * var_16;
    var_18 = vectornormalize(var_17 - var_01.var_116);
    var_19 = var_18 - var_01.forward_dir;
    if(vectordot(var_19, var_19) > var_13) {
      var_19 = var_12 * vectornormalize(var_19);
    }

    var_01.forward_dir = vectornormalize(var_01.forward_dir + var_19);
    var_01.var_1D = hammer_modelangles_fromdir(var_01.forward_dir);
    var_01.next_hammer_pos = var_01.var_116 + var_01.forward_dir * var_09 * var_0D;
    var_1A = bulletTrace(var_01.var_116, var_01.next_hammer_pos, 0, var_01, 1);
    if(var_1A["fraction"] < 1) {
      var_1B = max(var_1A["fraction"] * var_0D, 0.05);
      var_01 moveto(var_1A["position"], var_1B);
      wait(var_1B);
      hammer_detonate_attack(var_1A["position"], param_00);
      break;
    }

    var_01 moveto(var_01.next_hammer_pos, var_0D);
    wait(var_0D);
  }

  var_01.forward_dir = vectornormalize(var_01.var_117.var_116 - var_01.var_116);
  var_01.var_1D = hammer_modelangles_fromdir(var_01.forward_dir);
  wait 0.05;
  var_1C = 0.05;
  while(isDefined(var_01)) {
    var_1D = var_01.var_117.var_116 + (0, 0, 42);
    var_1E = distance(var_1D, var_01.var_116);
    var_1F = var_1E / 1600;
    if(var_1F < var_1C - 0.025) {
      break;
    }

    var_16 = min(var_1F, 1);
    var_20 = var_1D + var_01.var_117 getvelocity() * var_16;
    var_01.forward_dir = vectornormalize(var_20 - var_01.var_116);
    var_01.var_1D = hammer_modelangles_fromdir(var_01.forward_dir);
    var_01 moveto(var_20, var_1F);
    var_01 lib_0378::func_8D74("dlc4_hammer_catch", var_01.var_116, var_1E);
    wait(var_1C);
  }

  var_01.tag_tracker delete();
  var_01.var_95AB delete();
  var_01 delete();
  var_21 = 4;
  param_00 notify("hammer_release_melee_lock");
  param_00 setclientomnvar("ui_show_scorestreak_training_hud", 1);
  wait(var_21);
  var_22 = param_00 test_raven_weapon_owner();
  param_00.hammer_throw_on_cooldown = 0;
  if(lib_0547::func_5565(var_22, "hammer_emp")) {
    maps\mp\zombies\_zombies_magicbox::func_3AC1(param_00, "zom_hammer_grenade_zm");
    param_00 thread spawn_hammer_full_fx();
  }
}

spawn_hammer_full_fx() {
  if(has_hammer_emp() && !isDefined(self.stormhammerchargedfx)) {
    self.stormhammerchargedfx = spawnlinkedfxforclient(common_scripts\utility::func_44F5("zmb_storm_hammer_gem_charge_vm"), self, "TAG_FX", self, 1);
    triggerfx(self.stormhammerchargedfx);
    self.stormhammerchargedfx lib_0378::func_8D74("aud_hammer_emp_charged");
    self.stormhammerchargedfx thread lib_0547::func_2D19(self);
    maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.stormhammerchargedfx);
  }

  thread hammer_lost_delete_fx();
}

hammer_lost_delete_fx() {
  while(isDefined(self) && has_hammer_emp()) {
    wait 0.05;
  }

  if(isDefined(self)) {
    delete_hammer_full_fx();
  }
}

delete_hammer_full_fx() {
  if(isDefined(self.stormhammerchargedfx)) {
    self.stormhammerchargedfx delete();
  }
}

hammer_handle_melee_attack() {
  lib_0586::func_790("zom_dlc4_hammer_emp_zm");
  self.raven_hammer_in_air = 1;
  if(self hasweapon(self.weapon_previous_to_hammer)) {
    self switchtoweapon(self.weapon_previous_to_hammer);
  } else {
    self switchtoweapon(self getweaponslistprimaries()[0]);
  }

  common_scripts\utility::knock_off_battery("hammer_release_melee_lock", "death");
  var_00 = test_raven_weapon_owner();
  if(lib_0547::func_5565(var_00, "hammer_emp")) {
    lib_0586::func_78C("zom_dlc4_hammer_emp_zm");
    self switchtoweapon("zom_dlc4_hammer_emp_zm");
  }

  self.raven_hammer_in_air = 1;
  self.weapon_previous_to_hammer = undefined;
}

hammer_replace_projectile_with_model(param_00) {
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("npc_gen_sledgehammer_zom");
  var_01.forward_dir = (0, 0, 1);
  var_01.var_1D = param_00 geteyeangles() + (90, 0, 0);
  var_01.var_95AB = spawn("script_model", var_01.var_116);
  var_01.var_95AB setModel("tag_origin");
  var_01.tag_tracker = spawn("script_model", var_01.var_116);
  var_01.tag_tracker setModel("tag_origin");
  var_01.tag_tracker.var_1D = param_00 geteyeangles();
  self delete();
  return var_01;
}

hammer_modelangles_fromdir(param_00) {
  var_01 = vectortoangles(param_00) + (90, 0, 0);
  return var_01;
}

hammer_choose_target() {
  var_00 = self;
  return var_00.pottargets[0];
}

hammer_rank_targets() {
  var_00 = self;
  if(!isDefined(var_00.pottargets)) {
    var_00.pottargets = [];
  }

  if(!isDefined(var_00.pottargetscores)) {
    var_00.pottargetscores = [];
  }

  var_01 = 100000000;
  for(var_02 = 0; var_02 < 2; var_02++) {
    var_00.pottargetscores[var_02] = var_01;
    var_00.pottargets[var_02] = undefined;
  }

  var_03 = var_00 lib_0586::func_43F1(var_00.var_116, var_00.forward_dir, 1200, 30);
  foreach(var_05 in var_03) {
    var_06 = var_05.var_8302;
    var_07 = sqrd_dist_between_segments(var_00.tag_tracker.var_116, var_00.tag_tracker.end_point, var_05.var_116, var_05.var_116 + (0, 0, var_06));
    var_08 = var_07[1] - var_00.tag_tracker.var_116;
    var_09 = var_07[2] - var_00.var_117.var_116;
    var_0A = vectordot(var_09, var_09);
    if(var_0A < var_00.pottargetscores[0]) {
      var_00.pottargetscores[1] = var_00.pottargetscores[0];
      var_00.pottargets[1] = var_00.pottargets[0];
      var_00.pottargetscores[0] = var_0A;
      var_00.pottargets[0] = var_05;
      continue;
    }

    if(var_0A < var_00.pottargetscores[1]) {
      var_00.pottargetscores[1] = var_0A;
      var_00.pottargets[1] = var_05;
    }
  }
}

hammer_do_flight_damage(param_00, param_01) {
  if(lib_0547::func_5565(param_00.temporary_hammer_flight_imunity, 1)) {
    return;
  }

  if(isDefined(param_00.var_A4B)) {
    var_02 = lib_0547::func_A51(param_00.var_A4B);
    if(lib_0547::func_5565(param_00.isforceshieldactive, 1)) {
      param_00 maps\mp\zombies\zombie_king::break_force_shield();
      if(isDefined(var_02) && common_scripts\utility::func_562E(var_02.knockbyravensword)) {
        lib_0547::func_7D1B(self, param_00, "far", self.var_117);
      }

      param_00 thread hammer_set_temp_immunity();
      param_00 lib_0378::func_8D74("zmb_HAMMER_throw_hit_metal");
      return;
    }

    if(isDefined(var_02) && common_scripts\utility::func_562E(var_02.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "close", self.var_117);
    }

    param_00 thread hammer_set_temp_immunity();
    param_00 dodamage(level.hammerthrowdamage, param_01, self.var_117, self.var_117, "MOD_EXPLOSIVE", "zom_hammer_grenade_zm");
    param_00 lib_0378::func_8D74("zmb_HAMMER_throw_hit_metal");
  }
}

hammer_set_temp_immunity() {
  self endon("death");
  self.temporary_hammer_flight_imunity = 1;
  wait(0.85);
  self.temporary_hammer_flight_imunity = undefined;
}

hammer_test_impact(param_00) {
  if(!bullettracepassed(self.var_116, param_00, 0, self)) {
    var_01 = bulletTrace(self.var_116, param_00, 0, self, 1);
    return var_01;
  }

  return undefined;
}

hammer_throw_arm() {
  self endon("death");
  self.isarmed = 0;
  wait(0.15);
  self.isarmed = 1;
}

hammer_throw_end() {
  self endon("death");
  self.inflight = 1;
  wait(2);
  self.inflight = 0;
}

hammer_detonate() {
  self endon("death");
  self notify("detonate");
  wait 0.05;
}

hammer_detonate_on_death(param_00) {
  self waittill("detonate");
  hammer_detonate_attack(self.var_116, param_00);
}

hammer_detonate_attack(param_00, param_01) {
  playFX(common_scripts\utility::func_44F5("zmb_storm_hammer_lightning"), param_00);
  lib_0378::func_8D74("aud_hammer_lightning", param_00);
  wait(0.25);
  playFX(common_scripts\utility::func_44F5("zmb_storm_hammer_impact"), param_00);
  var_02 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), level.var_A980);
  var_03 = lib_0547::func_408F();
  var_03 = function_01AC(var_03, param_00, 92);
  foreach(var_05 in var_03) {
    if(distance(param_00, var_05.var_116) < 92) {
      if(lib_0547::func_5565(var_05.isforceshieldactive, 1)) {
        var_05 maps\mp\zombies\zombie_king::break_force_shield();
        var_06 = lib_0547::func_A51(var_05.var_A4B);
        if(isDefined(var_06) && common_scripts\utility::func_562E(var_06.knockbyravensword)) {
          lib_0547::func_7D1B(param_01, var_05, "close");
        }

        continue;
      }

      if(level.hammerthrowburstdamage > var_05.var_BC) {
        var_05 lib_0547::func_5A85(var_05.var_116, param_00 - var_05.var_116);
        continue;
      }

      if(isDefined(level.ravenweaponmanager["hammer_emp"].var_117)) {
        var_05 dodamage(level.hammerthrowburstdamage, param_00, level.ravenweaponmanager["hammer_emp"].var_117, level.ravenweaponmanager["hammer_emp"].var_117, "MOD_MELEE", "hammer_cleave_zm", "none");
      } else {
        var_05 dodamage(level.hammerthrowburstdamage, param_00, undefined, undefined, "MOD_MELEE", "hammer_cleave_zm", "none");
      }

      if(isDefined(var_05.var_A4B)) {
        var_06 = lib_0547::func_A51(var_05.var_A4B);
        if(isDefined(var_06) && common_scripts\utility::func_562E(var_06.knockbyravensword)) {
          lib_0547::func_7D1B(param_01, var_05, "close");
        }
      }
    }
  }

  wait 0.05;
  physicsexplosionsphere(param_00, 128, 50, 3.5);
}

hammer_throw_toggle_equip() {
  if(!isDefined(self._dlc4_weapon_manager)) {
    self._dlc4_weapon_manager = [];
  }

  var_00 = "zom_dlc4_hammer_emp_zm";
  var_01 = "zom_hammer_grenade_zm";
  while(isDefined(self) && has_hammer_emp()) {
    self waittill("weapon_change", var_02);
    while(isDefined(self._dlc4_weapon_manager["special_grenade"]) && self._dlc4_weapon_manager["special_grenade"] != "zom_hammer_grenade_zm") {
      wait 0.05;
    }

    if(self getcurrentprimaryweapon() == var_00) {
      if(!self hasweapon("zom_hammer_grenade_zm")) {
        hammer_throw_give_grenade();
      }

      continue;
    }

    if(self hasweapon("zom_hammer_grenade_zm")) {
      hammer_throw_take_grenade();
      thread delete_hammer_full_fx();
    }
  }

  if(isDefined(self) && self hasweapon("zom_hammer_grenade_zm")) {
    hammer_throw_take_grenade();
    thread delete_hammer_full_fx();
  }
}

hammer_throw_give_grenade() {
  if(!isDefined(self._dlc4_weapon_manager)) {
    self._dlc4_weapon_manager = [];
  }

  var_00 = "zom_hammer_grenade_zm";
  while(self method_8126()) {
    wait 0.05;
  }

  var_01 = self method_834A();
  if(!raven_weapon_check_if_special_grenade(var_01)) {
    self._dlc4_weapon_manager["stored_lethal"] = var_01;
    self._dlc4_weapon_manager["stored_lethal_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_lethal"]);
  }

  lib_0586::func_790(var_01);
  self method_8349(var_00);
  self._dlc4_weapon_manager["special_grenade"] = "zom_hammer_grenade_zm";
  lib_0586::func_78C(var_00);
  if(lib_0547::func_5565(self.hammer_throw_on_cooldown, 1)) {
    self method_82FA(var_00, 0);
    return;
  }

  maps\mp\zombies\_zombies_magicbox::func_3AC1(self, "zom_hammer_grenade_zm");
  thread spawn_hammer_full_fx();
}

hammer_throw_take_grenade() {
  lib_0586::func_790("zom_hammer_grenade_zm");
  if(isDefined(self._dlc4_weapon_manager["stored_lethal"])) {
    self method_8349(self._dlc4_weapon_manager["stored_lethal"]);
    self method_82FA(self._dlc4_weapon_manager["stored_lethal"], self._dlc4_weapon_manager["stored_lethal_ammo"]);
    if(self._dlc4_weapon_manager["stored_lethal"] != "none") {
      lib_0586::func_78C(self._dlc4_weapon_manager["stored_lethal"]);
      self method_82FA(self._dlc4_weapon_manager["stored_lethal"], self._dlc4_weapon_manager["stored_lethal_ammo"]);
      self._dlc4_weapon_manager["stored_lethal"] = undefined;
      self._dlc4_weapon_manager["stored_lethal_ammo"] = undefined;
    } else {
      self setweaponammostock(self._dlc4_weapon_manager["stored_lethal"], 0);
    }
  } else {
    var_00 = maps\mp\_utility::func_44CD(self.var_90E4.var_37FE);
    self method_8349(var_00);
    var_01 = weaponclipsize(var_00, self);
    self method_82FA(var_00, var_01);
  }

  if(lib_0547::func_5565(self._dlc4_weapon_manager["special_grenade"], "zom_hammer_grenade_zm")) {
    self._dlc4_weapon_manager["special_grenade"] = undefined;
  }

  thread raven_weapon_prevent_free_grenades();
}

hammer_emp_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8661()) {
    return 0;
  }

  return level.hammerempdamage;
}

hammer_emp_melee_cone(param_00) {
  self endon("melee_ability_interrupt");
  var_01 = lib_0586::zombies_hit_by_melee_cone(225, 100);
  var_02 = lib_0586::zombies_hit_by_melee_cone(64, 12);
  var_02 = function_01AC(var_02, self.var_116);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(var_03 > 3) {
      break;
    }

    childthread delayed_hammer_emp_sweet_hit(var_02[var_03], var_03);
    var_01 = common_scripts\utility::func_F93(var_01, var_02[var_03]);
  }

  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    childthread delayed_hammer_emp_hit(var_01[var_03], var_03);
  }

  var_04 = common_scripts\utility::func_44F5("zmb_storm_hammer_knockback");
  playFX(var_04, self.var_116 + (0, 0, 50), anglesToForward(self.var_1D));
  lib_0378::func_8D74("zmb_sword_aoe", self.var_116);
}

delayed_hammer_emp_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  var_03 = spawnStruct();
  var_03.var_721C = self;
  var_03.var_ABE6 = param_00.var_116;
  var_03.var_4DCF = "none";
  var_03.var_60B8 = undefined;
  var_03.var_1D0 = "hammer_cleave_zm";
  var_03.delaysec = undefined;
  if(param_00.var_BC < level.hammercleavedamage) {
    playFX(level.var_611["zmb_storm_hmr_zmb_kill"], param_00.var_116);
  }

  param_00 dodamage(level.hammercleavedamage, self getEye(), self, self, "MOD_MELEE", "hammer_cleave_zm", "none");
  if(param_00.var_A4B == "zombie_king") {
    playFXOnTag(level.var_611["zmb_storm_hmr_godking_stun"], param_00, "TAG_ORIGIN");
  } else {
    playFXOnTag(level.var_611["zmb_storm_hmr_zmb_stun"], param_00, "TAG_ORIGIN");
  }

  if(isDefined(param_00.var_A4B)) {
    var_04 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_04) && common_scripts\utility::func_562E(var_04.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "medium");
    }
  }
}

delayed_hammer_emp_sweet_hit(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  var_03 = spawnStruct();
  var_03.var_721C = self;
  var_03.var_ABE6 = param_00.var_116;
  var_03.var_4DCF = "none";
  var_03.var_60B8 = undefined;
  var_03.var_1D0 = "hammer_cleave_zm";
  var_03.delaysec = undefined;
  lib_0378::func_8D74("zmb_HAMMER_melee_hit_metal", var_03);
  if(param_00.var_BC < level.hammercleavedamage) {
    playFX(level.var_611["zmb_storm_hmr_zmb_kill"], param_00.var_116);
  }

  param_00 dodamage(level.hammersweetcleavedamage, self getEye(), self, self, "MOD_MELEE", "hammer_cleave_zm", "none");
  playFXOnTag(level.var_611["zmb_hammer_smack"], param_00, "TAG_EYE");
  if(isDefined(param_00.var_A4B)) {
    var_04 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_04) && common_scripts\utility::func_562E(var_04.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "close");
    }
  }
}

moonorb_init() {
  if(!isDefined(level.currentconverts)) {
    level.currentconverts = 0;
  }

  level.moonorb_safe_vols = getEntArray("vol_moonorb_safe", "targetname");
  level.moonorb_bad_vols = getEntArray("vol_moonorb_bad", "targetname");
  level thread maps\mp\_utility::func_6F74(::notify_moonorb_fired);
  level thread maps\mp\_utility::func_6F74(::notify_moonorb_current_manager);
}

notify_moonorb_fired() {
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "zom_moonorb_grenade_zm" || var_01 == "zom_moonorb_grenade_emp_zm") {
      self.zoneonmoonorbthrow = lib_055A::func_462D();
      thread handle_moonorb_state_change("fired", var_01, 0);
      if(var_01 == "zom_moonorb_grenade_zm") {
        var_00 thread moonorb_register_active(self);
        continue;
      }

      var_00 thread moonorb_register_active(self, 1);
    }
  }
}

handle_moonorb_state_change(param_00, param_01, param_02) {
  if(!lib_0547::func_5565("zom_moonorb_grenade_zm", param_01)) {
    return;
  }

  if(param_02) {}
}

set_fx(param_00, param_01) {
  if(isDefined(self.var_3F2F)) {
    self.var_3F2F delete();
  }

  if(!isDefined(param_01)) {
    param_01 = "tag_fx";
  }

  self.var_3F74 = param_00;
  self.var_3F2F = spawnlinkedfx(common_scripts\utility::func_44F5(param_00), self, param_01);
  triggerfx(self.var_3F2F);
  if(function_01EF(self)) {
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.var_3F2F);
    return;
  }

  self.var_3F2F thread lib_0547::func_2D19(self);
}

moonorb_register_active(param_00, param_01) {
  level.moon_orb_manager["moonscepter_orb_active"] = self;
  if(lib_0547::func_5565(param_01, 1)) {
    self.is_empowered = 1;
  }

  self.owner_first = param_00;
  moonorb_active_think(param_01);
  level.moon_orb_manager["moonscepter_orb_active"] = undefined;
}

moonorb_active_think(param_00) {
  var_01 = self;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_01.last_safe_pos = var_01.var_116;
  var_07 = level.moon_orb_manager["moonscepter_owner"];
  if(isDefined(var_07) && isPlayer(var_07)) {
    var_07 setweaponammostock(var_07 method_82D5(), 0);
    var_07 method_82FA(var_07 method_82D5(), 0);
  }

  if(lib_0547::func_5565(param_00, 1)) {
    var_08 = "zom_moonorb_grenade_emp_zm";
  } else {
    var_08 = "zom_moonorb_grenade_zm";
  }

  var_01 notify("new_moonorb_tracking");
  var_01 endon("new_moonorb_tracking");
  var_01 thread moonorb_safe_vol_track();
  var_01 thread moonorb_test_orrery_distance();
  while(isDefined(var_01)) {
    var_01 thread moonorb_air_timeout();
    var_01 thread moonorb_set_cooktime();
    var_09 = var_01 common_scripts\utility::func_A717("air_timeout", "missile_stuck", "orb_teleport_request", "orb_control_request", "ee_moonorb_collected", "moonorb_near_orrery", "moonorb_trial_end_stagnate");
    var_0A = var_09[0];
    if(lib_0547::func_5565(var_0A, "missile_stuck") || lib_0547::func_5565(var_0A, "moonorb_near_orrery")) {
      var_02 = var_01 moonorb_replace_projectile_with_model();
      level.moon_orb_manager["moonscepter_orb_active"] = var_02;
      if(isDefined(var_09[1]) && function_01EF(var_09[1]) && var_09[1].var_BC > 0) {
        var_03 = var_09[1];
        var_02 linkto(var_09[1], var_09[1] get_closest_tag_from_array(var_02.var_116, ["tag_origin", "tag_eye", "J_Head", "J_Hip_RI", "J_Hip_LE", "J_Knee_LE", "J_Knee_RI", "J_SpineLower", "J_SpineUpper", "J_Shoulder_RI", "J_Shoulder_LE", "J_MainRoot"]));
      } else if(var_0A == "moonorb_near_orrery") {
        var_0B = common_scripts\utility::func_8FFC();
        var_0B.var_116 = common_scripts\utility::func_46B5("moonraven_orrery_teleport_node", "targetname").var_116;
        var_0B method_805B();
        var_02 method_8449(var_0B, "TAG_ORIGIN");
        var_0B thread moonorb_orbit();
        var_02.istrialready = 1;
        var_0C = launchbeam("zmb_moonorb_beam", var_02, "tag_origin", var_0B, "tag_origin");
        var_0B thread lib_0547::func_2D19(var_02);
        var_0C thread lib_0547::func_2D19(var_02);
      } else {
        var_0D = bulletTrace(var_02.var_116, var_02.var_116 + (0, 0, -1000), 0, var_02, 1, 0, 0, 0, 0, 0, 0);
        var_02 childthread lib_0547::obj_fall_onto_pos(var_0D["position"]);
      }

      var_02 thread set_fx("zmb_moonorb_stuck");
      var_02 lib_0378::func_8D74("aud_moonorb_stuck");
      var_02 thread moonorb_stuck_wait();
      var_02.stuck = 1;
      var_07 = level.moon_orb_manager["moonscepter_owner"];
      if(isDefined(var_07) && isPlayer(var_07)) {
        if(lib_0547::func_5565(param_00, 1)) {
          if(isDefined(var_09[1]) && function_01EF(var_09[1]) && !common_scripts\utility::func_562E(var_07.has_shown_spike_emp_control_hint)) {
            var_07.has_shown_spike_emp_control_hint = 1;
            lib_0555::func_83DD("dlc4_weap_hint_spike_emp_control", var_07);
          } else if(!common_scripts\utility::func_562E(var_07.has_shown_spike_emp_tele_hint)) {
            var_07.has_shown_spike_emp_tele_hint = 1;
            lib_0555::func_83DD("dlc4_weap_hint_spike_teleport", var_07);
          }
        } else if(!common_scripts\utility::func_562E(var_07.has_shown_spike_tele_hint)) {
          var_07.has_shown_spike_tele_hint = 1;
          lib_0555::func_83DD("dlc4_weap_hint_spike_teleport", var_07);
        }
      }

      var_09 = var_02 common_scripts\utility::func_A717("orb_stagnate_timeout", "orb_teleport_request", "orb_control_request", "moonorb_trial_end_stagnate");
      var_0A = var_09[0];
      var_02 notify("orb_stagnate_cancel");
    }

    if(isDefined(var_02)) {
      var_01 = var_02;
    }

    if(lib_0547::func_5565(param_00, 1) && lib_0547::func_5565(var_0A, "orb_control_request") || lib_0547::func_5565(var_0A, "orb_stagnate_timeout")) {
      var_0E = playFX(common_scripts\utility::func_44F5("moonorb_control_burst"), var_01.var_116, anglesToForward(var_01.var_1D));
      var_0E lib_0378::func_8D74("aud_moonorb_control_burst");
      var_0F = lib_0547::func_408F();
      var_0F = function_01AC(var_0F, var_01.var_116, 128, 1);
      for(var_10 = 0; var_10 < var_0F.size; var_10++) {
        if(level.currentconverts >= 10 || var_10 >= 3 || !var_0F[var_10] isvalidmoonorbtarget()) {
          continue;
        }

        if(common_scripts\utility::func_302B(var_0F[var_10].var_116, var_01.var_116)) {
          if(moonorb_zombieishittable(var_0F[var_10], var_01.var_116)) {
            if(isDefined(level.currentconverts) && level.currentconverts < 10) {
              var_0F[var_10] thread moonorb_mind_control();
            }
          }
        }
      }
    } else if(lib_0547::func_5565(var_0A, "orb_teleport_request") && isDefined(level.moon_orb_manager["moonscepter_owner"]) && isPlayer(level.moon_orb_manager["moonscepter_owner"])) {
      var_01 thread set_fx("zmb_moonorb_stuck");
      var_11 = undefined;
      if(var_07 moonorb_player_busy()) {
        var_11 = [0];
      } else if(lib_0547::func_5565(var_01.istrialready, 1)) {
        var_07 = level.moon_orb_manager["moonscepter_owner"];
        var_07 lib_0378::func_8D74("aud_moonraven_enter_trial");
        var_12 = common_scripts\utility::func_46B5("zombie_warp_moon_trial", "targetname");
        var_0C = launchbeam("zmb_moonorb_beam", var_01, "tag_origin", var_07, "tag_weapon_right");
        var_07 moon_orb_play_screen_fx();
        wait(0.25);
        if(isDefined(var_0C)) {
          var_0C delete();
        }

        var_13 = spawnStruct();
        var_13.var_116 = var_07.var_116;
        var_13.var_1D = var_07.var_1D;
        var_07.old_destination = var_13;
        var_07 setorigin(var_12.var_116, 1);
        common_scripts\utility::func_3C8F("moon_trial_entered");
        var_07 thread maps\mp\mp_zombie_descent_ee_main::run_weapon_ritual("zom_dlc4_spike_zm");
        var_01 delete();
        return;
      } else if(isDefined(var_06)) {
        var_14 = moon_orb_head_bump_test(var_06.var_116);
        if(var_06 moonorb_zombie_touching_vol() && common_scripts\utility::func_562E(var_14[0])) {
          var_13 = [1, var_14[1]];
        } else {
          var_13 = var_04 moon_orb_teleport_validation(level.moon_orb_manager["moonscepter_owner"]);
        }
      } else {
        var_13 = var_04 moon_orb_teleport_validation(level.moon_orb_manager["moonscepter_owner"]);
      }

      if(isDefined(var_13)) {
        if(isDefined(var_13[0])) {
          var_07 = var_13[0];
        }

        if(isDefined(var_13[1])) {
          var_08 = var_13[1];
        }
      }

      if(common_scripts\utility::func_562E(var_07)) {
        level.moon_orb_manager["moonscepter_owner"] do_moon_orb_teleportation(var_08, var_04, var_06, var_16);
      } else {
        var_15 = playFX(common_scripts\utility::func_44F5("zmb_moonorb_suck"), var_04.var_116, anglesToForward(var_04.var_1D));
        var_15 lib_0378::func_8D74("aud_moonorb_orphaned_lp");
        var_09 = 1;
      }
    } else {
      var_15 = playFX(common_scripts\utility::func_44F5("zmb_moonorb_suck"), var_04.var_116, anglesToForward(var_04.var_1D));
      var_15 lib_0378::func_8D74("aud_moonorb_orphaned_lp");
      var_09 = 1;
    }

    var_0C = 20;
    if(lib_0547::func_5565(var_03, 1)) {
      var_0C = 10;
      var_0A setclientomnvar("ui_show_scorestreak_training_hud", 3);
    } else {
      var_0A setclientomnvar("ui_show_scorestreak_training_hud", 2);
    }

    if(common_scripts\utility::func_562E(var_09)) {
      var_0C = 0.25;
    }

    if(isDefined(var_04.var_95AB)) {
      var_04.var_95AB delete();
    }

    var_04 delete();
    var_0A moonorb_cooldown(var_0C);
    if(isDefined(level.moon_orb_manager["moonscepter_owner"])) {
      maps\mp\zombies\_zombies_magicbox::func_3AC1(level.moon_orb_manager["moonscepter_owner"], var_16);
      var_0A = level.moon_orb_manager["moonscepter_owner"];
      var_0A setweaponammostock(var_0A method_82D5(), 1);
    }
  }
}

moonorb_cooldown(param_00) {
  level.moon_orb_manager["on_cooldown"] = 1;
  moonorb_wait_cooldown(param_00);
  level.moon_orb_manager["on_cooldown"] = undefined;
}

moonorb_wait_cooldown(param_00) {
  var_01 = self;
  var_01 endon("moonorb_force_cooldown_reset");
  wait(param_00);
}

moonorb_player_busy() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.isbloodtubemoonorbblocked)) {
    return 1;
  }

  return 0;
}

do_moon_orb_teleportation(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 endon("disconnect");
  playFX(level.var_611["zmb_moonorb_tel_disappear"], var_04.var_116 + (0, 0, 48));
  playFX(level.var_611["zmb_moonorb_suck"], param_01.var_116);
  var_04 lib_0378::func_8D74("aud_moonorb_teleport");
  var_05 = launchbeam("zmb_moonorb_beam", param_01, "tag_origin", var_04, "tag_weapon_right");
  var_04 moon_orb_play_screen_fx();
  wait(0.25);
  if(isDefined(param_02) && isDefined(param_03)) {
    if(isDefined(param_02) && param_02 isvalidmoonorbtarget()) {
      param_02 dodamage(param_02.var_FB + 666, var_04.var_116, undefined, undefined, "MOD_EXPLOSIVE", param_03);
    }
  }

  var_04 setorigin(param_00);
  if(isDefined(self.wing_fx)) {
    thread maps\mp\zombies\zombie_king::spawn_wings();
  }

  playFX(level.var_611["zmb_moonorb_tel_appear"], var_04.var_116 + (0, 0, 48));
  var_04 childthread record_landing_zone();
  if(isDefined(var_05)) {
    var_05 delete();
  }
}

moonorb_orbit() {
  self endon("death");
  var_00 = 10;
  for(;;) {
    self rotateby((360, 360, 0), var_00);
    wait(var_00);
  }
}

isvalidmoonorbtarget() {
  var_00 = self;
  if(!isalive(var_00) || common_scripts\utility::func_562E(var_00.var_2FDA) || (isDefined(var_00.var_A4B) && var_00.var_A4B == "zombie_heavy") || (isDefined(var_00.var_A4B) && var_00.var_A4B == "zombie_dlc4") || (isDefined(var_00.var_A4B) && var_00.var_A4B == "zombie_fireman") || (isDefined(var_00.var_A4B) && var_00.var_A4B == "zombie_heavy") || (isDefined(var_00.var_A4B) && var_00.var_A4B == "zombie_treasurer") || isDefined(var_00.var_A4B) && var_00.var_A4B == "zombie_king") {
    return 0;
  }

  return 1;
}

record_landing_zone() {
  self endon("death");
  self endon("disconnect");
  wait 0.05;
  self.zoneonmoonorbland = lib_055A::func_462D();
  self notify("zmb_moonraven_grenade_gap", self.zoneonmoonorbthrow, self.zoneonmoonorbland);
}

moonorb_safe_vol_track() {
  self endon("death");
  self notify("moonorb_safe_vol_start_track");
  self endon("moonorb_safe_vol_start_track");
  self.validposarray = [];
  for(;;) {
    var_00 = self.var_116;
    foreach(var_02 in level.moonorb_safe_vols) {
      if(moonorb_vol_test(var_02)) {
        if(function_02E6(getgroundposition(var_00, 64))) {
          self.last_safe_pos_touching = 1;
          self.last_safe_pos = var_00;
          moonorb_add_pos_to_valid_array(var_00);
        }
      }
    }

    wait 0.05;
  }
}

moonorb_vol_test(param_00) {
  if(self istouching(param_00)) {
    foreach(var_02 in level.moonorb_bad_vols) {
      if(self istouching(var_02)) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

moonorb_add_pos_to_valid_array(param_00) {
  if(self.validposarray.size == 0) {
    self.validposarray[self.validposarray.size] = param_00;
  } else if(!isDefined(common_scripts\utility::func_F7E(self.validposarray, param_00))) {
    self.validposarray = common_scripts\utility::func_F86(self.validposarray, param_00, 0);
  }

  if(self.validposarray.size > 100) {
    self.validposarray = common_scripts\utility::func_F9A(self.validposarray, self.validposarray.size);
  }
}

moonorb_test_orrery_distance() {
  self endon("death");
  self endon("moonorb_safe_vol_start_track");
  if(!common_scripts\utility::func_3C77("moon_trial_unlocked") || common_scripts\utility::func_3C77("moon_trial_complete")) {
    return;
  }

  var_00 = common_scripts\utility::func_46B5("moonraven_orrery_teleport_node", "targetname");
  for(;;) {
    if(distance(self.var_116, var_00.var_116) < 44) {
      self notify("moonorb_near_orrery");
    }

    wait 0.05;
  }
}

moonorb_air_timeout() {
  self endon("air_timeout_skip");
  wait(3);
  self notify("air_timeout");
}

moonorb_set_cooktime() {
  self endon("death");
  self.is_cooking = 1;
  wait(0.25);
  self.is_cooking = 0;
}

moonorb_replace_projectile_with_model() {
  var_00 = spawn("script_model", self.var_116);
  if(lib_0547::func_5565(self.is_empowered, 1)) {
    var_00 setModel("npc_zom_morningstar_grenade");
  } else {
    var_00 setModel("npc_zom_morningstar_grenade");
  }

  if(isDefined(self.last_safe_pos_touching)) {
    var_00.last_safe_pos_touching = self.last_safe_pos_touching;
  }

  if(isDefined(self.last_safe_pos)) {
    var_00.last_safe_pos = self.last_safe_pos;
  }

  if(isDefined(self.validposarray)) {
    var_00.validposarray = self.validposarray;
  }

  var_00.var_95AB = spawn("script_model", var_00.var_116);
  var_00.var_95AB setModel("tag_origin");
  var_00.var_95AB.var_1D = (-90, 0, 0);
  self delete();
  return var_00;
}

get_closest_tag_from_array(param_00, param_01) {
  var_02 = 0;
  var_03 = 100000;
  var_04 = undefined;
  foreach(var_06 in param_01) {
    var_07 = self method_8445(var_06);
    if(!common_scripts\utility::func_562E(var_07)) {
      continue;
    }

    var_08 = self gettagorigin(var_06);
    var_02 = distance(var_08, param_00);
    if(var_02 < var_03) {
      var_04 = var_06;
      var_03 = var_02;
    }

    if(var_02 < 1) {
      break;
    }
  }

  return var_04;
}

moonorb_stuck_wait() {
  self endon("orb_stagnate_cancel");
  wait(5);
  self notify("orb_stagnate_timeout");
}

moonorb_mind_control() {
  self endon("moon_control_end");
  self endon("death");
  maps\mp\agents\_agent_utility::func_83FE("allies");
  self.ismooncontrolled = 1;
  self.nomutilate = 1;
  self.ispassiveexempt = 1;
  thread moonorb_mind_control_fx();
  level thread moonorb_onzombiedeath(self);
  self.modifyagentdamage = ::moonorb_modify_minion_agent_damage;
  self.var_6816 = 1;
  var_00 = 0;
  wait(10);
  while(common_scripts\utility::func_562E(self.stall_mc_death)) {
    wait 0.05;
  }

  self notify("kill_moonzombie_listener");
  level.currentconverts--;
  self.ismooncontrolled = 0;
  while(isalive(self)) {
    if(lib_0547::func_5565(self.isforceshieldactive, 1)) {
      maps\mp\zombies\zombie_king::break_force_shield();
    }

    if(common_scripts\utility::func_562E(self.var_480F)) {
      self.var_480F = 0;
    }

    if(self method_85F0()) {
      self setdemigod(0);
    }

    if(common_scripts\utility::func_562E(self.var_2FDA)) {
      self suicide();
      continue;
    }

    self dodamage(self.var_8 + 666, self.var_116, undefined, undefined, "MOD_ENERGY", "zom_moonorb_grenade_zm");
    wait(1);
  }
}

moonorb_zombieishittable(param_00, param_01) {
  if(param_00.var_116[2] <= param_01[2]) {
    return bullettracepassed(param_00.var_116 + (0, 0, 10), (param_00.var_116[0], param_00.var_116[1], param_01[2] + 10), 0, param_00) && bullettracepassed(param_01 + (0, 0, 10), (param_00.var_116[0], param_00.var_116[1], param_01[2] + 10), 0, param_00);
  }

  return bullettracepassed(param_01 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_116[2] + 10), 0, param_00) && bullettracepassed(param_00.var_116 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_116[2] + 10), 0, param_00);
}

moonorb_onzombiedeath(param_00) {
  param_00 endon("kill_moonzombie_listener");
  level.currentconverts++;
  param_00 waittill("death");
  level.currentconverts--;
}

moonorb_mind_control_fx(param_00) {
  self endon("death");
  if(isDefined(self.mooncontrolledfx)) {
    self.mooncontrolledfx delete();
  }

  if(isDefined(self.darkhostfx)) {
    return;
  }

  self.mooncontrolledfx = spawnlinkedfx(common_scripts\utility::func_44F5("moonorb_control"), self, "j_head", 1);
  triggerfx(self.mooncontrolledfx);
  self.mooncontrolledfx thread lib_0547::func_2D19(self);
  self.mooncontrolledfx thread lib_0547::func_2D20(self, "dark_host_fx_update");
  if(common_scripts\utility::func_562E(param_00)) {
    return;
  }

  lib_0378::func_8D74("aud_moonorb_control_lp");
}

notify_moonorb_current_manager() {
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    if(var_00 != "zom_dlc4_spike_zm") {
      thread handle_moonorb_state_change("switching to other weapon", self getcurrentweapon(), 0);
      continue;
    } else {
      thread handle_moonorb_state_change("switching to loaded sawgun", var_00, 1);
    }
  }
}

moonorb_modify_minion_agent_damage(param_00, param_01) {
  if(isDefined(param_01) && common_scripts\utility::func_562E(param_01.ismooncontrolled)) {
    if(lib_0547::func_5565(self.var_A4B, "zombie_generic") || lib_0547::func_5565(self.var_A4B, "zombie_berserker")) {
      self.ismooncontrolled = 1;
      return self.var_BC + 666;
    } else if(lib_0547::func_5565(self.var_A4B, "zombie_exploder")) {
      if(self.var_BC <= self.var_FB / 3) {
        self.ismooncontrolled = 1;
      }

      return self.var_FB / 3;
    } else if(lib_0547::func_5565(self.var_A4B, "zombie_heavy") || lib_0547::func_5565(self.var_A4B, "zombie_assassin")) {
      if(self.var_BC <= self.var_FB / 5) {
        self.ismooncontrolled = 1;
      }

      return self.var_FB / 5;
    }
  }

  return param_00;
}

moonorb_zombie_touching_vol() {
  foreach(var_01 in level.moonorb_safe_vols) {
    if(self istouching(var_01)) {
      return 1;
    }
  }

  return 0;
}

moon_orb_teleport_validation(param_00) {
  if(!isDefined(param_00) || !isPlayer(param_00) || !isalive(param_00)) {
    return [0];
  }

  var_01 = [0];
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = 228;
  var_06 = self;
  foreach(var_0C, var_08 in var_06.validposarray) {
    var_09 = var_06.validposarray[var_0C];
    var_01 = moon_orb_head_bump_test(var_09);
    if(var_01[0] == 1) {
      var_02 = 1;
      var_0A = var_01[1];
      if(ispointinvolume(var_09, getent("zone_crash", "targetname"))) {
        var_0B = undefined;
        var_0B = getgroundposition(var_09, 64);
        if(distance(var_09, var_0B) > var_05) {
          var_04 = var_0B + (0, 0, var_05);
        } else {
          var_04 = var_0A;
        }
      } else {
        var_04 = var_0A;
      }
    }

    if(common_scripts\utility::func_562E(var_02) && isDefined(var_04)) {
      var_01 = [1, var_04];
      break;
    } else {}
  }

  return var_01;
}

is_false(param_00) {
  return isDefined(param_00) && !param_00;
}

moon_orb_head_bump_test(param_00) {
  var_01 = 64;
  var_02 = 32;
  var_03 = 0;
  var_04 = [0];
  if(isDefined(param_00)) {
    for(var_05 = 0; var_05 < 2; var_05++) {
      if(!isDefined(var_03)) {
        var_03 = 0;
      }

      var_06 = param_00 - (0, 0, var_03);
      var_07 = capsuletracepassed(var_06 + (0, 0, 2), var_02, var_01, level.moon_orb_manager["moonscepter_orb_active"], 0, 1, 1);
      if(common_scripts\utility::func_562E(var_07)) {
        var_04 = [1, var_06];
        break;
      } else {
        var_08 = playerphysicstrace(var_06, var_06 + (0, 0, var_01), level.moon_orb_manager["moonscepter_orb_active"]);
        var_09 = distance(var_08, var_06);
        var_03 = var_01 - var_09;
      }
    }
  }

  return var_04;
}

moon_orb_play_screen_fx() {
  level thread common_scripts\_exploder::func_88E(216, [self]);
}

spike_init() {
  level.zombiemeleeweapon["zom_dlc4_spike_zm"] = 1;
  level.var_62B3["zom_dlc4_spike_zm"] = ::spike_modify_damage;
  level.var_A9C8["zom_dlc4_spike_zm"] = ::spike_heavy_melee_fatal;
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
  level.var_6DF9["default"]["zom_dlc4_spike_zm"] = var_03;
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
  level.var_6DF9["heavy"]["zom_dlc4_spike_zm"] = var_03;
  setup_melee_weapon_ownership(::has_spike_weapon, ::spike_gained, ::spike_lost);
}

give_spike_weapon() {
  try_drop_old_weapon("spike");
  if(!lib_0547::func_73F9(self, "zom_dlc4_spike_zm")) {
    lib_0586::func_78C("zom_dlc4_spike_zm");
    self switchtoweapon("zom_dlc4_spike_zm");
  }

  thread wep_disco_protect("spike");
  thread wep_death_protect("spike");
  level.ravenweaponmanager["spike"].var_117 = self;
}

has_spike_weapon() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc4_spike_zm");
}

spike_gained() {
  level.moon_orb_manager["moonscepter_owner"] = self;
  thread spike_think();
  if(!common_scripts\utility::func_562E(self.has_shown_knife_hint)) {
    self.has_shown_knife_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_spike", self);
  }

  if(isDefined(level.ravenweaponmanager["spike"].on_gained_func)) {
    self[[level.ravenweaponmanager["spike"].on_gained_func]]();
  }
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
  wait 0.05;
  while(isDefined(self) && has_spike_weapon()) {
    var_00 = common_scripts\utility::func_A715("lethal_pressed", "tactical_pressed");
    if(!isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || lib_0547::func_5565(level.moon_orb_manager["moonscepter_orb_active"].is_cooking, 1)) {
      continue;
    }

    if(var_00 == "lethal_pressed") {
      level.moon_orb_manager["moonscepter_orb_active"] notify("orb_teleport_request");
    }

    wait 0.05;
  }
}

moonorb_toggle_equip(param_00) {
  if(!isDefined(self._dlc4_weapon_manager)) {
    self._dlc4_weapon_manager = [];
  }

  var_01 = "zom_dlc4_spike_zm";
  if(lib_0547::func_5565(param_00, 1)) {
    var_01 = "zom_dlc4_spike_emp_zm";
  }

  var_02 = "zom_moonorb_grenade_zm";
  if(lib_0547::func_5565(param_00, 1)) {
    var_02 = "zom_moonorb_grenade_emp_zm";
  }

  while((isDefined(self) && has_spike_weapon()) || has_spike_emp()) {
    common_scripts\utility::knock_off_battery("weapon_change", "offhand_end");
    while(isDefined(self._dlc4_weapon_manager["special_grenade"]) && self._dlc4_weapon_manager["special_grenade"] != "zom_moonorb_grenade_zm") {
      wait 0.05;
      if(!has_spike_weapon() || has_spike_emp()) {
        continue;
      }
    }

    if(self getcurrentprimaryweapon() == var_01) {
      if(!self hasweapon(var_02)) {
        moonorb_give_grenade(param_00);
      }

      continue;
    }

    if(self hasweapon(var_02)) {
      moonorb_take_grenade(param_00);
    }
  }

  if(isDefined(self) && self hasweapon("zom_moonorb_grenade_zm") || self hasweapon("zom_moonorb_grenade_emp_zm")) {
    moonorb_take_grenade(param_00);
  }
}

moonorb_give_grenade(param_00) {
  if(!isDefined(self._dlc4_weapon_manager)) {
    self._dlc4_weapon_manager = [];
  }

  var_01 = "zom_moonorb_grenade_zm";
  if(lib_0547::func_5565(param_00, 1)) {
    var_01 = "zom_moonorb_grenade_emp_zm";
  }

  var_02 = self method_834A();
  if(!raven_weapon_check_if_special_grenade(var_02)) {
    self._dlc4_weapon_manager["stored_lethal"] = var_02;
    self._dlc4_weapon_manager["stored_lethal_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_lethal"]);
  }

  if(var_02 != var_01) {
    lib_0586::func_790(var_02);
    self method_8349(var_01);
  }

  if(lib_0547::func_5565(param_00, 1)) {
    var_03 = self method_831F();
    if(!raven_weapon_check_if_special_grenade(var_02)) {
      self._dlc4_weapon_manager["stored_tactical"] = var_03;
      self._dlc4_weapon_manager["stored_tactical_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_tactical"]);
    }

    if(var_03 != var_01) {
      lib_0586::func_790(var_03);
      self method_831E(var_01);
    }
  }

  self._dlc4_weapon_manager["special_grenade"] = "zom_moonorb_grenade_zm";
  lib_0586::func_78C(var_01);
  thread moonorb_handle_grenade_pickup(param_00, var_01);
  if(isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || common_scripts\utility::func_562E(level.moon_orb_manager["on_cooldown"])) {
    self method_82FA(var_01, 0);
  } else {
    self method_82FA(self method_82D5(), 1);
    maps\mp\zombies\_zombies_magicbox::func_3AC1(self, var_01);
  }

  thread raven_weapon_prevent_free_grenades();
}

moonorb_take_grenade(param_00) {
  if(lib_0547::func_5565(param_00, 1)) {
    lib_0586::func_790("zom_moonorb_grenade_emp_zm");
    lib_0586::func_790("zom_moonorb_grenade_zm");
  } else {
    lib_0586::func_790("zom_moonorb_grenade_zm");
  }

  if(isDefined(self._dlc4_weapon_manager["stored_lethal"])) {
    if(self._dlc4_weapon_manager["stored_lethal"] != "none") {
      self method_8349(self._dlc4_weapon_manager["stored_lethal"]);
      lib_0586::func_78C(self._dlc4_weapon_manager["stored_lethal"]);
      self method_82FA(self._dlc4_weapon_manager["stored_lethal"], self._dlc4_weapon_manager["stored_lethal_ammo"]);
      self._dlc4_weapon_manager["stored_lethal"] = undefined;
      self._dlc4_weapon_manager["stored_lethal_ammo"] = undefined;
    } else {}
  } else {
    var_01 = maps\mp\_utility::func_44CD(self.var_90E4.var_37FE);
    self method_8349(var_01);
    self method_82FA(var_01, 0);
  }

  if(isDefined(self._dlc4_weapon_manager["stored_tactical"])) {
    if(self._dlc4_weapon_manager["stored_tactical"] != "none") {
      self method_831E(self._dlc4_weapon_manager["stored_tactical"]);
      lib_0586::func_78C(self._dlc4_weapon_manager["stored_tactical"]);
      self method_82FA(self._dlc4_weapon_manager["stored_tactical"], self._dlc4_weapon_manager["stored_tactical_ammo"]);
      self._dlc4_weapon_manager["stored_tactical"] = undefined;
      self._dlc4_weapon_manager["stored_tactical_ammo"] = undefined;
    } else {}
  } else {}

  if(lib_0547::func_5565(self._dlc4_weapon_manager["special_grenade"], "zom_moonorb_grenade_emp_zm") || lib_0547::func_5565(self._dlc4_weapon_manager["special_grenade"], "zom_moonorb_grenade_zm")) {
    self._dlc4_weapon_manager["special_grenade"] = undefined;
  }

  self method_82FA(self method_82D5(), 0);
  thread raven_weapon_prevent_free_grenades();
  self notify("moonorb_taken");
}

raven_weapon_prevent_free_grenades() {
  self endon("disconnect");
  self endon("spawned");
  if(self method_8126()) {
    common_scripts\utility::func_600();
    while(self method_8126()) {
      wait 0.05;
    }

    common_scripts\utility::func_614();
  }
}

moonorb_handle_grenade_pickup(param_00, param_01) {
  self endon("moonorb_taken");
  for(;;) {
    self waittill("weapon_given");
    if(!self hasweapon(param_01)) {
      var_02 = self method_834A();
      if(!raven_weapon_check_if_special_grenade(var_02) && var_02 != "none") {
        self._dlc4_weapon_manager["stored_lethal"] = var_02;
        self._dlc4_weapon_manager["stored_lethal_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_lethal"]);
        lib_0586::func_790(var_02);
      }

      if(var_02 != param_01) {
        self method_8349(param_01);
      }

      if(lib_0547::func_5565(param_00, 1)) {
        var_03 = self method_831F();
        if(!raven_weapon_check_if_special_grenade(var_02) && var_03 != "none") {
          self._dlc4_weapon_manager["stored_tactical"] = var_03;
          self._dlc4_weapon_manager["stored_tactical_ammo"] = self getweaponammoclip(self._dlc4_weapon_manager["stored_tactical"]);
          lib_0586::func_790(var_03);
        }

        if(var_03 != param_01) {
          self method_831E(param_01);
        }
      }

      lib_0586::func_78C(param_01);
      if(isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || common_scripts\utility::func_562E(level.moon_orb_manager["on_cooldown"])) {
        self method_82FA(param_01, 0);
      } else {
        self method_82FA(param_01, 1);
      }
    }
  }
}

spike_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.spikedamage;
}

spike_max_ammo_func(param_00) {
  return 1;
}

spike_heavy_melee_fatal(param_00) {
  return common_scripts\utility::func_562E(self.var_165B) || self adsButtonPressed();
}

spike_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_spike_emp_zm"] = 1;
  level.var_62B3["zom_dlc4_spike_emp_zm"] = ::spike_emp_modify_damage;
  level.var_A9C8["zom_dlc4_spike_emp_zm"] = ::spike_emp_heavy_melee_fatal;
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
  level.var_6DF9["default"]["zom_dlc4_spike_emp_zm"] = var_03;
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
  level.var_6DF9["heavy"]["zom_dlc4_spike_emp_zm"] = var_03;
  setup_melee_weapon_ownership(::has_spike_emp, ::spike_emp_gained, ::spike_emp_lost);
  lib_0547::func_7BA9(::spike_emp_on_zombie_killed);
}

give_spike_emp_weapon(param_00) {
  try_drop_old_weapon("spike_emp", param_00);
  waittillframeend;
  if(!lib_0547::func_73F9(self, "zom_dlc4_spike_emp_zm")) {
    lib_0586::func_78C("zom_dlc4_spike_emp_zm");
    self switchtoweapon("zom_dlc4_spike_emp_zm");
  }

  thread wep_disco_protect("spike_emp");
  thread wep_death_protect("spike_emp");
  level.ravenweaponmanager["spike_emp"].var_117 = self;
}

has_spike_emp() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc4_spike_emp_zm");
}

spike_emp_gained() {
  level.moon_orb_manager["moonscepter_owner"] = self;
  thread spike_emp_think();
  if(!common_scripts\utility::func_562E(self.has_shown_knife_emp_hint)) {
    self.has_shown_knife_emp_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_spike_emp", self);
  }

  if(isDefined(level.ravenweaponmanager["spike_emp"].on_gained_func)) {
    self[[level.ravenweaponmanager["spike_emp"].on_gained_func]]();
  }
}

spike_emp_lost() {
  self notify(level.ravenweaponmanager["spike_emp"].wep_loss_notify);
  if(!lib_0547::func_5565(level.ravenweaponmanager["spike"].var_117, level.moon_orb_manager["moonscepter_owner"])) {
    level.moon_orb_manager["moonscepter_owner"] = undefined;
  }
}

spike_emp_heavy_melee_fatal(param_00) {
  return common_scripts\utility::func_562E(self.var_165B) || self adsButtonPressed();
}

spike_emp_think() {
  thread moonorb_toggle_equip(1);
  thread spike_vision_think();
  wait 0.05;
  while(has_spike_emp()) {
    var_00 = common_scripts\utility::func_A715("lethal_pressed", "tactical_pressed");
    if(!isDefined(level.moon_orb_manager["moonscepter_orb_active"]) || lib_0547::func_5565(level.moon_orb_manager["moonscepter_orb_active"].is_cooking, 1) || lib_0547::func_577E(self) || !isalive(self)) {
      continue;
    }

    if(var_00 == "lethal_pressed") {
      level.moon_orb_manager["moonscepter_orb_active"] notify("orb_teleport_request");
      continue;
    }

    if(var_00 == "tactical_pressed") {
      level.moon_orb_manager["moonscepter_orb_active"] notify("orb_control_request");
    }

    wait 0.05;
  }
}

spike_vision_think() {
  self notify("spike_vision_start");
  self endon("spike_vision_start");
  self endon("disconnect");
  for(;;) {
    if((self getcurrentweapon() == "zom_dlc4_spike_zm" || self getcurrentweapon() == "zom_dlc4_spike_emp_zm") && self adsButtonPressed() && !common_scripts\utility::func_562E(self.spike_vision_enabled)) {
      self.spike_vision_enabled = 1;
      enable_moon_vision();
    } else if((!self adsButtonPressed() && common_scripts\utility::func_562E(self.spike_vision_enabled)) || self getcurrentweapon() != "zom_dlc4_spike_zm" && self getcurrentweapon() != "zom_dlc4_spike_emp_zm") {
      self.spike_vision_enabled = undefined;
      disable_moon_vision();
    }

    wait 0.05;
    while(self method_833B()) {
      wait 0.05;
    }

    if(!lib_0547::func_5565(level.ravenweaponmanager["spike"].var_117, self) && !lib_0547::func_5565(level.ravenweaponmanager["spike_emp"].var_117, self)) {
      if(common_scripts\utility::func_562E(self.spike_vision_enabled)) {
        self.spike_vision_enabled = undefined;
        disable_moon_vision();
      }

      return;
    }
  }
}

enable_moon_vision() {
  if(!common_scripts\utility::func_562E(level.var_22F0) && !lib_0547::func_5565(self.vision_blood_active, 1)) {
    self method_8483("mp_zombie_descent_moonravengreen", 0.05);
  }
}

disable_moon_vision() {
  self method_8483("", 0.05);
}

spike_emp_on_zombie_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(param_01) && isPlayer(param_01) && param_01 has_spike_emp()) {
    if(common_scripts\utility::func_562E(self.var_103)) {
      param_01 spike_emp_spec_effect();
    }
  }
}

spike_emp_spec_effect() {
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

spike_emp_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.spikeempdamage;
}

scythe_init() {
  level.zombiemeleeweapon["zom_dlc4_scythe_zm"] = 1;
  level.var_62B3["zom_dlc4_scythe_zm"] = ::scythe_modify_damage;
  level.meleeaoeweapons["scythe_cleave_zm"] = 1;
  level.var_2FE9["zom_dlc4_scythe_zm"] = 1;
  level.var_4D3D["zom_dlc4_scythe_zm"] = 1;
  level.var_2FE9["scythe_cleave_zm"] = 1;
  level.var_4D3D["scythe_cleave_zm"] = 1;
  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (42.816, 5.533, 0);
  var_02 = length(var_01);
  setup_melee_weapon_ownership(::has_scythe, ::scythe_gained, ::scythe_lost);
}

give_scythe_weapon() {
  try_drop_old_weapon("scythe");
  if(!lib_0547::func_73F9(self, "zom_dlc4_scythe_zm")) {
    lib_0586::func_78C("zom_dlc4_scythe_zm");
    self switchtoweapon("zom_dlc4_scythe_zm");
  }

  thread wep_disco_protect("scythe");
  thread wep_death_protect("scythe");
  level.ravenweaponmanager["scythe"].var_117 = self;
}

getcurrentdlc4meleeweapon() {
  var_00 = self method_82D5();
  foreach(var_03, var_02 in level.ravenweaponmanager) {
    if(lib_0547::func_5565(var_00, var_02.var_1D0)) {
      return var_03;
    }
  }
}

has_scythe() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc4_scythe_zm");
}

scythe_gained() {
  thread scythe_think();
  if(!common_scripts\utility::func_562E(self.has_shown_scythe_hint)) {
    self.has_shown_scythe_hint = 1;
  }

  if(isDefined(level.ravenweaponmanager["scythe"].on_gained_func)) {
    self[[level.ravenweaponmanager["scythe"].on_gained_func]]();
  }
}

scythe_lost() {
  self notify(level.ravenweaponmanager["scythe"].wep_loss_notify);
}

scythe_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8128() && !param_01 method_8661() && param_04 == "zom_dlc4_scythe_zm") {
    param_00.ignorethiszerodamage = 1;
    return 0;
  }

  return level.scythedamage;
}

scythe_think() {
  var_00 = setup_melee_abilityinfo("zom_dlc4_scythe_zm", 0.25, level.ravenweaponmanager["scythe"].wep_loss_notify, ::scythe_melee_cone, 0.7);
  thread run_melee_ability(var_00);
}

scythe_melee_cone(param_00) {
  self endon("melee_ability_interrupt");
  var_01 = lib_0586::zombies_hit_by_melee_cone(128, 100);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_scythe_hit1(var_01[var_02], var_02);
  }

  lib_0378::func_8D74("aud_zmb_scythe_swing");
  wait(0.65);
  var_01 = lib_0586::zombies_hit_by_melee_cone(128, 100);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_scythe_hit2(var_01[var_02], var_02);
  }
}

delayed_scythe_hit1(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("aud_zmb_scythe_impact");
  param_00 dodamage(level.scythecleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
}

delayed_scythe_hit2(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("aud_zmb_scythe_impact");
  param_00 dodamage(level.scythecleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_zm", "none");
  playFXOnTag(level.var_611["zmb_giestkraft_impact"], param_00, "J_Spine4");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbybladebarbarossa)) {
      lib_0547::func_7D1B(self, param_00, "far");
    }
  }
}

playzombiekilledbeamexplodefx() {
  var_00 = self gettagorigin("J_MainRoot");
  if(!isDefined(var_00)) {
    var_00 = self.var_116;
  }

  playFX(common_scripts\utility::func_44F5("zmb_blood_blast"), var_00);
}

scythe_emp_init() {
  level.zombiemeleeweapon["zom_dlc4_scythe_emp_zm"] = 1;
  level.var_62B3["zom_dlc4_scythe_emp_zm"] = ::scythe_emp_modify_damage;
  level.var_62B3["scythe_shard_zm"] = ::scythe_throw_modify_damage;
  level.meleeaoeweapons["scythe_cleave_emp_zm"] = 1;
  level.var_4D3D["zom_dlc4_scythe_emp_zm"] = 1;
  level.var_4D3D["scythe_cleave_emp_zm"] = 1;
  level.var_2FE9["zom_dlc4_scythe_emp_zm"] = 1;
  level.var_2FE9["scythe_cleave_emp_zm"] = 1;
  setup_melee_weapon_ownership(::has_scythe_emp, ::scythe_emp_gained, ::scythe_emp_lost);
  lib_0547::func_7BA9(::scythe_emp_onenemykilled);
}

give_scythe_emp_weapon(param_00, param_01) {
  try_drop_old_weapon("scythe_emp", param_00, undefined, param_01);
  if(!lib_0547::func_73F9(self, "zom_dlc4_scythe_emp_zm")) {
    lib_0586::func_78C("zom_dlc4_scythe_emp_zm");
    self switchtoweapon("zom_dlc4_scythe_emp_zm");
  }

  thread wep_disco_protect("scythe_emp");
  thread wep_death_protect("scythe_emp");
  level.ravenweaponmanager["scythe_emp"].var_117 = self;
}

has_scythe_emp() {
  var_00 = self method_82D5();
  return issubstr(var_00, "zom_dlc4_scythe_emp_zm");
}

scythe_emp_gained() {
  thread scythe_emp_think();
  thread scythe_death_shield_enable();
  if(!common_scripts\utility::func_562E(self.has_shown_scythe_emp_hint)) {
    self.has_shown_scythe_emp_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_scythe_emp_2", self);
  }
}

scythe_emp_lost() {
  self notify(level.ravenweaponmanager["scythe_emp"].wep_loss_notify);
}

scythe_emp_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8128()) {
    param_00.ignorethiszerodamage = 1;
    return 0;
  }

  return level.scytheempdamage;
}

scythe_throw_modify_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return level.scythethrowdamage;
}

scythe_emp_think() {
  var_00 = setup_melee_abilityinfo("zom_dlc4_scythe_emp_zm", 0.25, level.ravenweaponmanager["scythe_emp"].wep_loss_notify, ::scythe_emp_melee_cone, 0.7);
  var_01 = setup_heavy_melee_abilityinfo("zom_dlc4_scythe_emp_zm", 0.25, level.ravenweaponmanager["scythe_emp"].wep_loss_notify, ::scythe_throw_blades, 0.25);
  thread run_melee_ability(var_00);
  thread run_heavy_melee_ability(var_01);
}

scythe_throw_blades(param_00) {
  if(!common_scripts\utility::func_562E(self.has_shown_scythe_emp_blade_hint)) {
    self.has_shown_scythe_emp_blade_hint = 1;
    lib_0555::func_83DD("dlc4_weap_hint_scythe_emp_1", self);
  }

  var_01 = anglesToForward(self geteyeangles() + (6, 6, 0));
  var_02 = anglesToForward(self geteyeangles());
  var_03 = anglesToForward(self geteyeangles() - (6, 6, 0));
  var_04 = magicgrenademanual("scythe_shard_zm", self getEye() + (3, 0, 0), vectornormalize(var_01) * 1600, 10, self, 1, 1);
  var_05 = magicgrenademanual("scythe_shard_zm", self getEye(), vectornormalize(var_02) * 1600, 10, self, 1, 1);
  var_06 = magicgrenademanual("scythe_shard_zm", self getEye() - (3, 0, 0), vectornormalize(var_03) * 1600, 10, self, 1, 1);
  var_04.var_117 = self;
  var_05.var_117 = self;
  var_06.var_117 = self;
  var_07 = [var_04, var_05, var_06];
  lib_0378::func_8D74("aud_zmb_scythe_proj_shoot");
  foreach(var_09 in var_07) {
    var_09 thread scythe_shard_damage();
    var_09 lib_0378::func_8D74("aud_zmb_scythe_proj_loop");
  }
}

scythe_shard_damage() {
  self waittill("explode", var_00);
  if(isDefined(var_00)) {
    playFX(level.var_611["zmb_deathscythe_proj_exp"], var_00);
    lib_0378::func_8D74("aud_zmb_scythe_proj_impact");
  }
}

scythe_emp_melee_cone(param_00) {
  self endon("melee_ability_interrupt");
  var_01 = lib_0586::zombies_hit_by_melee_cone(128, 100);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_emp_scythe_hit1(var_01[var_02], var_02);
  }

  thread attempt_reflect_king_blast(128, 100);
  var_03 = common_scripts\utility::func_44F5("zmb_death_scythe_knockback");
  playFX(var_03, self.var_116 + (0, 0, 50), anglesToForward(self.var_1D));
  lib_0378::func_8D74("aud_zmb_scythe_emp_swing");
  wait(0.65);
  var_01 = lib_0586::zombies_hit_by_melee_cone(128, 100);
  var_01 = function_01AC(var_01, self.var_116);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    childthread delayed_emp_scythe_hit2(var_01[var_02], var_02);
  }

  childthread attempt_reflect_king_blast(128, 100);
  var_03 = common_scripts\utility::func_44F5("zmb_death_scythe_knockback_2");
  playFX(var_03, self.var_116 + (0, 0, 50), anglesToForward(self.var_1D));
}

attempt_reflect_king_blast(param_00, param_01) {
  var_02 = self;
  if(!isDefined(level.zombie_king)) {
    return;
  }

  if(!isDefined(level.zombie_king.current_blast)) {
    return;
  }

  if(!isDefined(level.zombie_king.current_blast.var_776C)) {
    return;
  }

  if(isDefined(level.zombie_king.current_blast.var_776C.var_117) && isPlayer(level.zombie_king.current_blast.var_776C.var_117)) {
    return;
  }

  var_03 = level.zombie_king.current_blast.var_776C;
  var_03 notify("blast_reflected");
  var_04 = 96;
  var_05 = var_02 getEye();
  var_06 = var_02 geteyeangles();
  var_07 = min(90 - param_01 / 2, var_06[0]);
  var_08 = anglesToForward((var_07, var_06[1], var_06[2]));
  var_09 = cos(param_01 / 2);
  var_0A = closestpointonconicsectionofspheretopoint(var_05, -1 * var_08, var_09, param_00, var_03.var_116);
  if(distance2dsquared(var_0A, var_03.var_116) > var_04 * var_04) {
    return;
  }

  var_0B = var_03.var_116;
  var_03 delete();
  var_0C = var_05 + anglesToForward(var_06) * 1000;
  var_02 thread maps\mp\zombies\zombie_king::geist_blast_player(var_0B, var_0C);
}

delayed_emp_scythe_hit1(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("aud_zmb_scythe_impact");
  param_00 dodamage(level.scytheempcleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_emp_zm", "none");
}

delayed_emp_scythe_hit2(param_00, param_01) {
  param_00 endon("death");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    wait 0.05;
  }

  lib_0378::func_8D74("aud_zmb_scythe_impact");
  param_00 dodamage(level.scytheempcleavedamage, self getEye(), self, self, "MOD_MELEE", "scythe_cleave_emp_zm", "none");
  if(isDefined(param_00.var_A4B)) {
    var_03 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.knockbybladebarbarossa)) {
      lib_0547::func_7D1B(self, param_00, "far");
    }
  }
}

scythe_emp_onenemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(param_04, "scythe_cleave_emp_zm") || lib_0547::func_5565(param_04, "zom_dlc4_scythe_emp_zm")) {
    playzombiekilledbeamexplodefx();
    if(isDefined(self.var_A4B)) {
      var_09 = undefined;
      if(lib_0547::func_5565(self.var_A4B, "zombie_dlc4") && self.var_5A36 >= maps\mp\zombies\zombie_corpse_eater::get_max_zombies_to_eat()) {
        var_09 = 1;
      }

      if(common_scripts\utility::func_562E(self.isempowered)) {
        var_09 = 1;
      }

      if(common_scripts\utility::func_562E(var_09) && !common_scripts\utility::func_562E(self.has_shown_death_trial_hint)) {
        self.has_shown_death_trial_hint = 1;
        lib_0555::func_83DD("dlc4_trial_hint_death", self);
      }

      param_01 scythe_death_shield_add(self.var_A4B, var_09);
    }
  }
}

scythe_death_shield_enable() {
  self endon("disconnect");
  if(!isDefined(self.deathravenenergy)) {
    self.deathravenenergy = 0;
  }

  if(!isDefined(self.deathravenenergy_test_func)) {
    self.deathravenenergy_test_func = ::scythe_death_energy_test_func;
  }

  thread scythe_death_energy_reset_on_death();
  thread scythe_death_shield_check();
  thread scythe_death_sheild_weapon_fx();
}

scythe_death_energy_test_func() {
  if(!has_scythe_emp()) {
    return 0;
  }

  if(self.deathravenenergy >= 1000) {
    return 1;
  }

  return 0;
}

scythe_death_shield_add(param_00, param_01) {
  var_02 = self;
  if(!var_02 has_scythe_emp() && !lib_0547::func_5565(var_02 getcurrentweapon(), "zom_dlc4_scythe_emp_zm")) {
    return;
  }

  if(!isDefined(var_02.deathravenenergy)) {
    var_02.deathravenenergy = 0;
  }

  var_02.deathravenenergy = var_02.deathravenenergy + scythe_death_shield_values(param_00, param_01);
  if(var_02.deathravenenergy >= 1000) {
    var_02 notify("death_raven_energy_full", self.only_charged_scythe_with_corpse_eaters);
    var_02.only_charged_scythe_with_corpse_eaters = 1;
    var_02.deathravenenergy = 1000;
  }
}

scythe_death_shield_set_empty() {
  var_00 = self;
  if(!isDefined(var_00.deathravenenergy)) {
    var_00.deathravenenergy = 0;
  }

  var_00.deathravenenergy = 0;
  var_00 notify("death_raven_energy_empty");
}

scythe_death_shield_values(param_00, param_01) {
  var_02 = 0;
  switch (param_00) {
    case "zombie_generic":
      var_02 = 10;
      break;

    case "zombie_heavy":
      var_02 = 50;
      break;

    case "zombie_berserker":
      var_02 = 15;
      break;

    case "zombie_exploder":
      var_02 = 20;
      break;

    case "zombie_dlc4":
      var_02 = 30;
      break;

    default:
      break;
  }

  if(lib_0547::func_5565(param_01, 1)) {
    var_02 = 1000;
  }

  return var_02;
}

scythe_death_sheild_weapon_fx() {
  self notify("scythe_fx_start");
  self endon("scythe_fx_start");
  for(;;) {
    if(self getcurrentweapon() == "zom_dlc4_scythe_emp_zm") {
      if(self.deathravenenergy >= 1000 && !isDefined(self.scythechargedfx)) {
        scythe_charge_on();
      }

      if(isDefined(self.scythechargedfx) && self.deathravenenergy < 1000) {
        scythe_charge_off();
      }
    } else {
      scythe_charge_off();
    }

    common_scripts\utility::knock_off_battery("weapon_change", "death_raven_energy_full", "death_raven_energy_empty", "weapon_given", "weapon_taken", "zombie_player_spawn_finished", "offhand_end", "weapon_switch_started");
    while(self method_8126()) {
      if(isDefined(self.scythechargedfx)) {
        scythe_charge_off();
      }

      wait 0.05;
    }
  }
}

scythe_charge_on() {
  level notify("scythe_charge_on");
  self.scythechargedfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_death_scythe_charged"), self, "TAG_FX", 1);
  triggerfx(self.scythechargedfx);
  self.scythechargedfx thread lib_0547::func_2D19(self);
  maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(self.scythechargedfx);
  lib_0378::func_8D74("aud_zmb_scythe_charged_loop_start");
}

scythe_charge_off() {
  level notify("scythe_charge_off");
  if(isDefined(self.scythechargedfx)) {
    self.scythechargedfx delete();
  }

  self.scythechargedfx = undefined;
  lib_0378::func_8D74("aud_zmb_scythe_charged_loop_stop");
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

    self switchtoweapon(level.ravenweaponmanager["scythe_emp"].var_1D0);
    self.var_BC = 30;
    self notify("damage", 0);
    scythe_death_shield_burst();
  }
}

scythe_death_shield_burst() {
  var_00 = lib_0547::func_408F();
  var_00 = function_01AC(var_00, self.var_116, 256);
  scythe_death_shield_set_empty();
  playFX(common_scripts\utility::func_44F5("zmb_death_scythe_revive_aoe"), self.var_116);
  lib_0378::func_8D74("aud_zmb_scythe_burst");
  thread run_death_shellshock(self.var_116);
  foreach(var_02 in var_00) {
    thread scythe_death_shield_damage(var_02);
  }
}

scythe_death_shield_damage(param_00) {
  var_01 = self;
  param_00 endon("death");
  playFX(level.var_611["zmb_deathscythe_proj_exp"], param_00.var_116 + (0, 0, 50));
  param_00 dodamage(level.scythedeathburstdamage, var_01.var_116, var_01, var_01, "MOD_MELEE", "scythe_burst_aoe_zm", "none");
  if(isDefined(param_00.var_A4B)) {
    var_02 = lib_0547::func_A51(param_00.var_A4B);
    if(isDefined(var_02) && common_scripts\utility::func_562E(var_02.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "close");
    }
  }
}

is_scythe_death_burst_weapon(param_00) {
  if(lib_0547::func_5565(param_00, "scythe_burst_aoe_zm")) {
    return 1;
  }

  return 0;
}

run_death_shellshock(param_00) {
  var_01 = 3;
  var_02 = 3;
  var_03 = 300;
  self endon("death");
  self shellshock("zm_heavy_hit", var_02, var_01);
  self method_8308(0);
  self playrumbleonentity("damage_heavy");
  var_04 = self.var_116 - param_00;
  var_04 = (var_04[0], var_04[1], 0);
  var_04 = var_03 * vectornormalize(var_04);
  var_04 = (var_04[0], var_04[1], 125);
  wait(var_02);
  self setvelocity(var_04);
  self method_8308(1);
}

store_players_weapons_zm(param_00) {
  if(!isDefined(self.var_9429)) {
    self.var_9429 = [];
  }

  if(!isDefined(self.var_A08B)) {
    self.var_A08B = [];
  }

  var_01 = [];
  var_02 = self getweaponslistall();
  var_03 = self getcurrentweapon();
  var_04 = self method_834A();
  var_05 = self method_831F();
  foreach(var_07 in var_02) {
    if(isDefined(self.var_A08B[var_07])) {
      continue;
    }

    var_01[var_07] = [];
    var_01[var_07]["clip_left"] = self getweaponammoclip(var_07, "left");
    var_01[var_07]["clip_right"] = self getweaponammoclip(var_07, "right");
    var_01[var_07]["stock"] = self getweaponammostock(var_07);
  }

  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  self.var_9429[param_00] = [];
  if(isDefined(self.var_A08B[var_03])) {
    var_09 = self getweaponslistprimaries();
    foreach(var_07 in var_09) {
      if(!isDefined(self.var_A08B[var_07])) {
        var_03 = var_07;
        break;
      }
    }
  }

  self.var_9429[param_00]["current_weapon"] = var_03;
  self.var_9429[param_00]["inventory"] = var_01;
  self.var_9429[param_00]["lethal_offhand"] = var_04;
  self.var_9429[param_00]["tactical_offhand"] = var_05;
}

restore_players_weapons_zm(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  if(!isDefined(self.var_9429) || !isDefined(self.var_9429[param_00])) {
    return;
  }

  self takeallweapons();
  foreach(var_03, var_02 in self.var_9429[param_00]["inventory"]) {
    if(function_01D4(var_03) != "altmode") {
      self giveweapon(var_03);
    }

    self method_82FA(var_03, var_02["clip_left"], "left");
    self method_82FA(var_03, var_02["clip_right"], "right");
    self setweaponammostock(var_03, var_02["stock"]);
  }

  var_04 = self.var_9429[param_00]["current_weapon"];
  if(var_04 != "none") {
    self switchtoweapon(var_04);
  }

  self method_8349(self.var_9429[param_00]["lethal_offhand"]);
  self method_831E(self.var_9429[param_00]["tactical_offhand"]);
}

func_941D(param_00) {
  if(!isDefined(self.var_9429)) {
    self.var_9429 = [];
  }

  if(!isDefined(self.var_A08B)) {
    self.var_A08B = [];
  }

  var_01 = [];
  var_02 = self getweaponslistall();
  var_03 = self getcurrentweapon();
  var_04 = self method_834A();
  var_05 = self method_831F();
  foreach(var_07 in var_02) {
    if(isDefined(self.var_A08B[var_07])) {
      continue;
    }

    var_01[var_07] = [];
    var_01[var_07]["clip_left"] = self getweaponammoclip(var_07, "left");
    var_01[var_07]["clip_right"] = self getweaponammoclip(var_07, "right");
    var_01[var_07]["stock"] = self getweaponammostock(var_07);
  }

  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  self.var_9429[param_00] = [];
  if(isDefined(self.var_A08B[var_03])) {
    var_09 = self getweaponslistprimaries();
    foreach(var_07 in var_09) {
      if(!isDefined(self.var_A08B[var_07])) {
        var_03 = var_07;
        break;
      }
    }
  }

  self.var_9429[param_00]["current_weapon"] = var_03;
  self.var_9429[param_00]["inventory"] = var_01;
  self.var_9429[param_00]["lethal_offhand"] = var_04;
  self.var_9429[param_00]["tactical_offhand"] = var_05;
}

func_7DE9(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  if(!isDefined(self.var_9429) || !isDefined(self.var_9429[param_00])) {
    return;
  }

  self takeallweapons();
  foreach(var_03, var_02 in self.var_9429[param_00]["inventory"]) {
    if(function_01D4(var_03) != "altmode") {
      self giveweapon(var_03);
    }

    self method_82FA(var_03, var_02["clip_left"], "left");
    self method_82FA(var_03, var_02["clip_right"], "right");
    self setweaponammostock(var_03, var_02["stock"]);
  }

  var_04 = self.var_9429[param_00]["current_weapon"];
  if(var_04 != "none") {
    self switchtoweapon(var_04);
  }

  self method_8349(self.var_9429[param_00]["lethal_offhand"]);
  self method_831E(self.var_9429[param_00]["tactical_offhand"]);
}

plinth_init() {
  common_scripts\utility::func_3C87("flag_plinth_one_weapon_placed");
  common_scripts\utility::func_3C87("flag_plinth_two_weapon_placed");
  common_scripts\utility::func_3C87("flag_plinth_three_weapon_placed");
  common_scripts\utility::func_3C87("flag_plinth_four_weapon_placed");
  common_scripts\utility::func_3C87("flag_plinth_all_weapons_placed");
  var_00 = common_scripts\utility::func_46B7("plinth_struct", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] plinth_weapon_setup();
    var_00[var_01] thread plinth_weapon_placement();
    switch (var_01) {
      case 0:
        var_00[var_01].weaponplacedflag = "flag_plinth_one_weapon_placed";
        break;

      case 1:
        var_00[var_01].weaponplacedflag = "flag_plinth_two_weapon_placed";
        break;

      case 2:
        var_00[var_01].weaponplacedflag = "flag_plinth_three_weapon_placed";
        break;

      case 3:
        var_00[var_01].weaponplacedflag = "flag_plinth_four_weapon_placed";
        break;
    }
  }

  thread plinth_check_for_all_weapons();
}

plinth_weapon_setup() {
  self.var_A9EB = "empty";
  var_00 = getEntArray(self.var_1A2, "targetname");
  foreach(var_02 in var_00) {
    switch (var_02.var_165) {
      case "shield":
        self.shield = var_02;
        self.shield.goalposition = var_02.var_116;
        var_02 method_805C();
        break;

      case "hammer":
        self.hammer = var_02;
        self.hammer.goalposition = var_02.var_116;
        var_02 method_805C();
        break;

      case "spike":
        self.spike = var_02;
        self.spike.goalposition = var_02.var_116;
        var_02 method_805C();
        break;

      case "scythe":
        self.scythe = var_02;
        self.scythe.goalposition = var_02.var_116;
        var_02 method_805C();
        break;

      case "use_trigger":
        self.usetrigger = var_02;
        break;

      default:
        break;
    }
  }
}

plinth_weapon_placement() {
  var_00 = undefined;
  for(;;) {
    var_01 = undefined;
    var_02 = 0;
    self.usetrigger waittill("trigger", var_03);
    if(common_scripts\utility::func_562E(level.bossceremonyactive)) {
      continue;
    }

    var_04 = var_03 test_raven_weapon_owner();
    var_05 = is_this_basic_wep(var_04);
    var_06 = is_this_right_wep("shield_emp", var_04);
    var_07 = is_this_right_wep("hammer_emp", var_04);
    var_08 = is_this_right_wep("spike_emp", var_04);
    var_09 = is_this_right_wep("scythe_emp", var_04);
    if(var_06 && lib_0547::func_5565(self.var_165, "plinth_generic")) {
      continue;
    }

    if((var_07 || var_08 || var_09) && lib_0547::func_5565(self.var_165, "plinth_shield")) {
      continue;
    }

    var_0A = undefined;
    if(var_06) {
      var_0A = "shield_emp";
      if(self.var_165 == "plinth_shield") {
        var_02 = 1;
        var_01 = self.shield;
      }
    } else if(var_07) {
      var_0A = "hammer_emp";
      if(self.var_165 == "plinth_generic") {
        var_02 = 1;
        var_01 = self.hammer;
      }
    } else if(var_08) {
      var_0A = "spike_emp";
      if(self.var_165 == "plinth_generic") {
        var_02 = 1;
        var_01 = self.spike;
      }
    } else if(var_09) {
      var_0A = "scythe_emp";
      if(self.var_165 == "plinth_generic") {
        var_02 = 1;
        var_01 = self.scythe;
      }
    }

    if(!isDefined(var_0A) && self.var_A9EB == "empty") {
      continue;
    }

    if(isDefined(var_00)) {
      if(isDefined(self.var_3F76)) {
        self.var_3F76 delete();
      }

      var_00 method_805C();
      if(common_scripts\utility::func_562E(var_05)) {
        thread spawn_raven_weapon(var_04, level.var_721C.var_116);
      }
    }

    var_0B = undefined;
    switch (self.var_A9EB) {
      case "empty":
        if(var_02 && lib_0547::func_5565(level.ravenweaponmanager[var_0A].var_117, var_03)) {
          var_03 take_raven_weapon(var_0A, 1);
        }
        break;

      case "shield":
        var_03 give_shield_emp_weapon(1);
        level notify("aud_shield_removed_from_plith");
        break;

      case "hammer":
        var_03 give_hammer_emp_weapon(1);
        level notify("aud_hammer_removed_from_plith");
        break;

      case "spike":
        var_03 give_spike_emp_weapon(1);
        level notify("aud_spike_removed_from_plith");
        break;

      case "scythe":
        var_03 give_scythe_emp_weapon(1);
        level notify("aud_scythe_removed_from_plith");
        break;

      default:
        break;
    }

    if(self.var_A9EB != "empty" && !common_scripts\utility::func_3C77("flag_plinth_all_weapons_placed")) {
      if(isDefined(var_00) && isDefined(var_00.towerfx)) {
        var_00.towerfx delete();
      }
    }

    if(isDefined(var_01)) {
      plinth_weapon_move_into_place(var_01, var_0A);
      var_00 = var_01;
      common_scripts\utility::func_3C8F(self.weaponplacedflag);
      self.var_A9EB = var_01.var_165;
      continue;
    }

    common_scripts\utility::func_3C7B(self.weaponplacedflag);
    self.var_A9EB = "empty";
  }
}

is_this_basic_wep(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "shield" || param_00 == "hammer" || param_00 == "spike" || param_00 == "scythe") {
    return 1;
  }

  return 0;
}

is_this_right_wep(param_00, param_01) {
  if(!isDefined(param_01)) {
    return 0;
  }

  if(param_00 == param_01) {
    return 1;
  }

  return 0;
}

plinth_weapon_move_into_place(param_00, param_01) {
  if(param_01 == "shield_emp" && isDefined(param_00.var_6C50)) {
    param_00 rotateto(param_00.var_6C50, 0.05);
    wait(0.1);
  }

  param_00 moveto(param_00.goalposition + (0, 0, 24), 0.05);
  wait 0.05;
  param_00 method_805B();
  lib_0378::func_8D74("aud_citadel_wpn_placement", param_01, param_00.goalposition);
  wait(1);
  param_00 moveto(param_00.goalposition, 3, 0.5, 1.25);
  wait(3);
  var_02 = common_scripts\utility::func_46B7("citadel_tower_fx_struct", "targetname");
  var_03 = undefined;
  switch (param_01) {
    case "shield_emp":
      param_00.towerfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_fire_pillar_01"), var_02[0].var_116);
      lib_0378::func_8D74("aud_citadel_pillar_ignite", (-3196, -8926, 1504));
      lib_0378::func_8D74("aud_citadel_shield_pillar_fire_lp", (-3196, -8926, 1504));
      break;

    case "hammer_emp":
      param_00.towerfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_fire_pillar_01"), var_02[1].var_116);
      lib_0378::func_8D74("aud_citadel_pillar_ignite", (-3096, -5456, 1411));
      lib_0378::func_8D74("aud_citadel_hammer_pillar_fire_lp", (-3096, -5456, 1411));
      break;

    case "spike_emp":
      param_00.towerfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_fire_pillar_01"), var_02[2].var_116);
      lib_0378::func_8D74("aud_citadel_pillar_ignite", (3226, -5484, 1387));
      lib_0378::func_8D74("aud_citadel_spike_pillar_fire_lp", (3226, -5484, 1387));
      break;

    case "scythe_emp":
      param_00.towerfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_fire_pillar_01"), var_02[3].var_116);
      lib_0378::func_8D74("aud_citadel_pillar_ignite", (3208, -8997, 1485));
      lib_0378::func_8D74("aud_citadel_scythe_pillar_fire_lp", (3208, -8997, 1485));
      break;
  }

  if(isDefined(param_00.towerfx)) {
    triggerfx(param_00.towerfx);
  }

  self.var_3F76 = spawn("script_model", self.var_116);
  self.var_3F76 setModel("tag_origin");
  self.var_3F76 set_fx(level.ravenweaponmanager[param_01].pickup_glow, "tag_origin");
}

plinth_shield_rotate(param_00) {
  var_01 = getent("shield_angles_destination", "targetname");
  var_02 = getent("shield_manual_pivot", "targetname");
  if(!isDefined(var_02.var_6C50)) {
    var_02.var_6C50 = var_02.var_1D;
  }

  if(!isDefined(param_00.var_6C50)) {
    param_00.var_6C50 = param_00.var_1D;
  }

  param_00 method_8449(var_02);
  waittillframeend;
  var_02 rotateto(var_01.var_1D, 3, 1.5, 1.5);
  wait(3);
  param_00 unlink();
  wait 0.05;
  var_02 rotateto(var_02.var_6C50, 0.1);
}

plinth_check_for_all_weapons() {
  for(var_00 = 0; !common_scripts\utility::func_562E(var_00); var_00 = 1) {
    wait 0.05;
    if(!common_scripts\utility::func_3C77("flag_plinth_one_weapon_placed")) {
      continue;
    }

    if(!common_scripts\utility::func_3C77("flag_plinth_two_weapon_placed")) {
      continue;
    }

    if(!common_scripts\utility::func_3C77("flag_plinth_three_weapon_placed")) {
      continue;
    }

    if(!common_scripts\utility::func_3C77("flag_plinth_four_weapon_placed")) {
      continue;
    }
  }

  var_01 = getent("shield", "script_noteworthy");
  plinth_shield_rotate(var_01);
  level.bossceremonyactive = 1;
  common_scripts\utility::func_3C8F("flag_plinth_all_weapons_placed");
  activateclientexploder(232);
  activateclientexploder(220);
  lib_0378::func_8D74("aud_citadel_entrance", (-785, -9852, 2387));
  lib_0378::func_8D74("aud_citadel_all_weapons_placed");
  wait(2);
  level notify("vo_vivian_entranced");
  wait(8);
  level.bossceremonyactive = 0;
  maps\mp\zombies\_zombies_blood_tubes::enter_boss_tube_activate();
  level notify("boss_tube_activated");
}

debug_plinth_spawn_weapons() {
  var_00 = common_scripts\utility::func_46B7("plinth_raven_weapon_spawns", "targetname");
  var_01 = ["shield_emp", "hammer_emp", "spike_emp", "scythe_emp"];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    thread spawn_raven_weapon(var_01[var_02], var_00[var_02].var_116);
  }
}

try_take_dlc4_melee_from_other_player(param_00, param_01, param_02) {
  var_03 = [param_00, param_01];
  param_02 = "shovel_zm";
  foreach(var_05 in var_03) {
    if(!isDefined(level.ravenweaponmanager[var_05].var_117) || level.ravenweaponmanager[var_05].var_117 == self) {
      continue;
    }

    var_06 = level.ravenweaponmanager[var_05].var_117;
    take_raven_weapon(var_05);
    if(var_06 method_82D5() == "none") {
      var_07 = maps\mp\zombies\_zombies_magicbox::func_454B(var_06, param_02);
      var_06 lib_0586::func_78C(var_07);
    }
  }
}