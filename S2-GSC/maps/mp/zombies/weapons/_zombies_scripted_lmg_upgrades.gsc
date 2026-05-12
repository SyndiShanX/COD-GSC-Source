/**********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombies_scripted_lmg_upgrades.gsc
**********************************************************************/

func_00D5() {
  lib_054D::func_7BC6(::scripted_lmg_dmg);
  lib_0547::register_postenemykilledfunc(::scripted_lmgs_on_death);
  common_scripts\utility::func_092C("impact_sparks", "vfx/sparks/impact_sparks");
  common_scripts\utility::func_092C("zmb_lewis_upgraded_rewind", "vfx/zombie/zmb_lewis_upgraded_rewind");
  common_scripts\utility::func_092C("force_zombie_bubble", "vfx/zombie/prototype_fx/dlc4/force_zombie_bubble");
  common_scripts\utility::func_092C("force_zombie_bubble_pop", "vfx/zombie/prototype_fx/dlc4/force_zombie_bubble_pop");
  common_scripts\utility::func_092C("zmb_bren_pap_screen", "vfx/zombie/zmb_bren_pap_screen");
  level.heavy_giest_dmg = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 35);
  level thread maps\mp\_utility::func_6F74(::force_field_bubble_on_bren_reload);
  level thread maps\mp\_utility::func_6F74(::mg42_laser_rounds);
  level thread maps\mp\_utility::func_6F74(::mg15_bubble_on_full_clip);
  level thread maps\mp\_utility::func_6F74(::lewis_run_bullet_rewind);
  level.bren_bubble_func = ::run_bren_reload_shield;
}

lewis_run_bullet_rewind() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.rewindorigins = [];
  var_01 = 0;
  for(;;) {
    var_00 waittill("weapon_fired", var_02);
    if(var_01 < 5) {
      var_01++;
      continue;
    } else {
      var_01 = 0;
    }

    if(!var_00 required_weapon("lewis_zm")) {
      continue;
    }

    var_03 = var_00 getEye();
    var_04 = var_03 + 10000 * vectornormalize(anglesToForward(var_00 geteyeangles()));
    var_05 = bulletTrace(var_03, var_04, 0);
    if(!isDefined(var_05["position"])) {
      continue;
    }

    playFX(common_scripts\utility::func_44F5("zmb_lewis_upgraded_rewind"), var_05["position"]);
    var_00.rewindorigins[var_00.rewindorigins.size] = var_05["position"];
    var_02 = var_00 lib_0586::func_078B("lewis_zm") + "+" + lib_056C::getattachmentforzombieweapon("lewis_zm", "zmb_mad_minute");
    if(var_00.rewindorigins.size >= 3) {
      var_00 waittill("reload_start");
      wait(0.7);
      for(var_06 = 0; var_06 < 7; var_06++) {
        foreach(var_08 in common_scripts\utility::func_0F92(var_00.rewindorigins)) {
          magicbullet(var_02, var_08, var_00 getEye() + (0, 0, -16), var_00);
          playFX(common_scripts\utility::func_44F5("zmb_lewis_upgraded_rewind"), var_08);
          wait 0.05;
        }

        wait(0.7);
      }

      var_00.rewindorigins = [];
    }
  }
}

required_weapon(param_00) {
  var_01 = self;
  var_02 = var_01 getcurrentweapon();
  if(lib_0569::func_55D4(var_02)) {
    var_02 = var_01 maps\mp\_events_z::set_last_checked_weapon(var_02);
    if(!lib_0547::func_5565(var_02, param_00)) {
      return 0;
    }
  } else {
    return 0;
  }

  return 1;
}

force_field_bubble_on_bren_reload() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("reload_start");
    var_00 attempt_reload_action(::spawn_bubble_shield_on_player_small, "bren_zm");
  }
}

mg15_bubble_on_full_clip() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("reload_start");
    var_00 attempt_reload_action(::spawn_bubble_shield_on_player_large, "mg15_zm");
  }
}

mg42_laser_rounds() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = "ptrs41_pap_zm+" + lib_056C::getattachmentforzombieweapon("ptrs41_pap_zm", "zmb_mad_minute");
  var_02 = 0;
  var_03 = 5 + randomint(5);
  for(;;) {
    var_00 waittill("weapon_fired", var_04);
    var_02++;
    if(var_02 < var_03) {
      continue;
    }

    var_02 = 0;
    var_03 = 10 + randomint(25);
    if(!var_00 required_weapon("mg42_zm")) {
      continue;
    }

    var_05 = var_00 geteyeangles();
    var_06 = anglesToForward(var_05);
    var_07 = anglestoup(var_05);
    var_08 = anglestoright(var_05);
    var_09 = var_00 getEye() + var_06 * 45 + var_07 * -6.5 + var_08 * 4;
    var_0A = anglesToForward(var_05);
    magicbullet(var_01, var_09, var_09 + 1000 * vectornormalize(anglesToForward(var_00 geteyeangles())), var_00);
  }
}

run_bren_reload_shield(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = spawnlinkedfx(common_scripts\utility::func_44F5("force_zombie_bubble"), var_01, "J_SpineLower");
  var_01.linkedbubblefx = var_02;
  triggerfx(var_02);
  var_01 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_02);
  var_03 = gettime();
  var_04 = 5;
  if(common_scripts\utility::func_562E(param_00)) {
    var_04 = 10000;
  }

  lib_0547::playfxclient("zmb_bren_pap_screen", var_01.var_0116, var_01, var_04);
  while(gettime() - var_03 / 1000 < var_04) {
    var_05 = 0;
    foreach(var_07 in lib_0547::func_408F()) {
      if(distance(var_07.var_0116, var_01.var_0116) > 85) {
        continue;
      }

      if(!isDefined(var_07.var_0A4B)) {
        continue;
      }

      if(!common_scripts\utility::func_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder"], var_07.var_0A4B)) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_07.plrorbaffected)) {
        continue;
      }

      var_05 = 1;
      playFX(common_scripts\utility::func_44F5("tesla_blood_explosion"), var_01.var_0116);
      var_07 lib_0378::func_8D74("aud_ww_blood_explode");
      var_07 do_strong_giest_damage(level.heavy_giest_dmg, var_01, var_01 lib_0586::func_078B("bren_zm"));
    }

    wait 0.05;
    if(var_05) {
      physicsexplosionsphere(var_01.var_0116, 250, 150, 2.7);
    }
  }

  playFX(common_scripts\utility::func_44F5("force_zombie_bubble_pop"), var_01.var_0116);
  lib_0378::func_8D74("zmb_pomel_grenade_final_explosion", var_01.var_0116);
  if(isDefined(var_02)) {
    var_02 delete();
  }
}

do_strong_giest_damage(param_00, param_01, param_02) {
  var_03 = self;
  var_03 endon("death");
  if(common_scripts\utility::func_562E(var_03.tookheavygiestdamage)) {
    return;
  }

  var_03.tookheavygiestdamage = 1;
  var_03 maps\mp\zombies\consumables\inv_giest_shield::play_shield_zombie_shock_vfx();
  wait 0.05;
  var_03 dodamage(param_00, param_01.var_0116, param_01, undefined, "MOD_ENERGY", param_02);
  var_03 thread dmg_cooldown();
}

dmg_cooldown() {
  var_00 = self;
  var_00 endon("death");
  wait(2);
  var_00.plrorbaffected = 0;
  var_00.tookheavygiestdamage = 0;
}

scripted_lmg_dmg(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_05)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(lib_0569::func_55D4(param_05)) {
    var_0B = param_01 maps\mp\_events_z::set_last_checked_weapon(param_05);
    if(param_01 exectute_stinger_feedback(self, var_0B, param_06, param_07)) {
      return;
    }

    if(param_01 exectute_mg81_feedback(self, var_0B, param_06, param_07)) {
      return;
    }

    if(param_01 exectute_vmg_1927_feedback(self, var_0B, param_06, param_07)) {
      return;
    }
  }
}

exectute_vmg_1927_feedback(param_00, param_01, param_02, param_03) {
  if(lib_0547::func_5565(param_01, "vmg1927_zm")) {
    param_00 try_catch_on_fire(self);
    return 1;
  }

  return 0;
}

exectute_stinger_feedback(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(lib_0547::func_5565(param_01, "blyskawica_zm")) {
    if(randomint(3) == 0) {
      playFX(common_scripts\utility::func_44F5("impact_sparks"), param_02, anglesToForward(param_03), anglestoup(param_03));
    }
  }

  if(lib_0547::func_5565(param_01, "m1919_zm")) {
    if(!isDefined(param_00.timesstung)) {
      param_00.timesstung = 0;
    }

    if(param_00.timesstung >= 0) {
      param_00.timesstung++;
    }

    if(randomint(200) == 0) {
      param_00.timesstung = 12;
    }

    if(!isDefined(var_04.laststingbursttime)) {
      var_04.laststingbursttime = gettime();
    }

    if(param_00.timesstung > 5) {
      playFX(common_scripts\utility::func_44F5("impact_sparks"), param_02, anglesToForward(param_03), anglestoup(param_03));
    }

    if(param_00.timesstung >= 12 && gettime() - var_04.laststingbursttime / 1000 > 4) {
      param_00.timesstung = -1;
      var_04.laststingbursttime = gettime();
      playsoundatpos(param_02, "zmb_wonder_weapon_proj_impact");
      lib_053A::mini_stunning_burst_execute(param_02, var_04, 60, 0.7, undefined, undefined, "zombie_fireman", ::maps\mp\zombies\weapons\_zombie_razer_gun::zombie_on_electric_charge);
    }

    return 1;
  }

  return 0;
}

exectute_mg81_feedback(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(common_scripts\utility::func_562E(var_04.activatedmg81lastshot)) {
    return 0;
  }

  if(lib_0547::func_5565(param_01, "mg81_zm")) {
    if(var_04 getcurrentweaponclipammo() == 0 && !common_scripts\utility::func_562E(var_04.activatedmg81lastshot)) {
      var_04.activatedmg81lastshot = 1;
      var_04 thread restoremg81lastshot();
      var_04 do_pommel_explosion_radius(param_01, var_04, param_00.var_0116, 192);
    } else {
      return 0;
    }

    return 1;
  }

  return 0;
}

do_pommel_explosion_radius(param_00, param_01, param_02, param_03) {
  param_01 endon("disconnect");
  playFX(level.var_0611["zmb_pommel_energy_field_burst"], param_02);
  lib_0378::func_8D74("zmb_pomel_grenade_final_explosion", param_02);
  foreach(var_05 in lib_0547::func_408F()) {
    if(!isDefined(var_05.var_0A4B) || !common_scripts\utility::func_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder"], var_05.var_0A4B)) {
      continue;
    }

    if(distance(var_05.var_0116, param_02) > param_03) {
      continue;
    }

    var_05 thread do_strong_giest_damage(level.heavy_giest_dmg, param_01, param_01 lib_0586::func_078B(param_00));
  }

  physicsexplosionsphere(param_02, 250, 150, 2.7);
}

restoremg81lastshot() {
  var_00 = self;
  var_00 endon("disconnect");
  wait(2);
  var_00.activatedmg81lastshot = 0;
}

try_catch_on_fire(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_02 = 0;
  if(!isDefined(level.zmb_fire_explode_origin)) {
    level.zmb_fire_explode_origin = var_01 common_scripts\utility::func_8FFC();
    level.zmb_fire_explode_origin method_805B();
  }

  if(!isDefined(var_01.fireshotcount)) {
    var_01.fireshotcount = 0;
  }

  if(common_scripts\utility::func_562E(var_01.isonfire)) {
    return;
  }

  if(!common_scripts\utility::func_0F79(["zombie_generic", "zombie_berserker", "zombie_exploder", "zombie_heavy"], var_01.var_0A4B)) {
    return;
  }

  var_01.fireshotcount++;
  foreach(var_04 in lib_0547::func_408F()) {
    if(lib_0547::func_5565("zombie_sizzler", var_04.var_0A4B)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_04.isonfire)) {
      var_02++;
    }
  }

  if(lib_0547::func_5565("zombie_heavy", var_01.var_0A4B)) {
    var_06 = 15;
  } else {
    var_06 = 5;
  }

  if(var_01.fireshotcount < var_06) {
    return;
  } else if(randomint(100) < 50) {
    var_01.fireshotcount = 0;
    return;
  }

  if(var_02 < 4) {
    var_01.isonfire = 1;
    lib_0547::func_A6F6();
    var_01 childthread set_on_fire_and_detonate(param_00);
  }
}

scripted_lmgs_on_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(common_scripts\utility::func_562E(self.var_2E68) && isDefined(param_01) && isPlayer(param_01)) {
    level thread do_vmg_explosion(self.var_0116, param_01);
  }
}

do_vmg_explosion(param_00, param_01) {
  lib_0547::func_A6F6();
  level.zmb_fire_explode_origin.var_0116 = param_00;
  level.zmb_fire_explode_origin detonateusingweapon("drag_explosive_zombie_zm", param_01, level.zmb_fire_explode_origin);
}

set_on_fire_and_detonate(param_00) {
  self setonfire(0, 100, 1, "none", 1);
  self.var_2E68 = 1;
}

attempt_reload_action(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  if(!var_02 required_weapon(param_01)) {
    return;
  }

  if(weapon_clip_empty(param_01)) {
    var_02 childthread[[param_00]]();
    while(weapon_clip_empty(param_01)) {
      wait 0.05;
    }
  }
}

spawn_bubble_shield_on_player_large() {
  var_00 = self;
  var_00 maps\mp\zombies\consumables\inv_giest_shield::spawn_a_giest_bubble_shield(var_00.var_0116, 5);
}

spawn_bubble_shield_on_player_small() {
  var_00 = self;
  var_00 thread run_bren_reload_shield();
}

weapon_clip_empty(param_00) {
  var_01 = self;
  if(!lib_0547::func_5565(param_00, lib_0547::func_AAF9(var_01 getcurrentweapon()))) {
    return 1;
  }

  return var_01 getcurrentweaponclipammo() == 0;
}