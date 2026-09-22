/******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombies_scripted_lmg_upgrades.gsc
******************************************************************************/

init() {
  _id_054D::_id_7BC6(::scripted_lmg_dmg);
  _id_0547::register_postenemykilledfunc(::scripted_lmgs_on_death);
  common_scripts\utility::_id_092C("impact_sparks", "vfx/sparks/impact_sparks");
  common_scripts\utility::_id_092C("zmb_lewis_upgraded_rewind", "vfx/zombie/zmb_lewis_upgraded_rewind");
  common_scripts\utility::_id_092C("force_zombie_bubble", "vfx/zombie/prototype_fx/dlc4/force_zombie_bubble");
  common_scripts\utility::_id_092C("force_zombie_bubble_pop", "vfx/zombie/prototype_fx/dlc4/force_zombie_bubble_pop");
  common_scripts\utility::_id_092C("zmb_bren_pap_screen", "vfx/zombie/zmb_bren_pap_screen");
  level.heavy_giest_dmg = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 35);
  level thread maps\mp\_utility::_id_6F74(::force_field_bubble_on_bren_reload);
  level thread maps\mp\_utility::_id_6F74(::mg42_laser_rounds);
  level thread maps\mp\_utility::_id_6F74(::mg15_bubble_on_full_clip);
  level thread maps\mp\_utility::_id_6F74(::lewis_run_bullet_rewind);
  level.bren_bubble_func = ::run_bren_reload_shield;
}

lewis_run_bullet_rewind() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0.rewindorigins = [];
  var_1 = 0;

  for(;;) {
    var_0 waittill("weapon_fired", var_2);

    if(var_1 < 5) {
      var_1++;
      continue;
    } else
      var_1 = 0;

    if(!var_0 required_weapon("lewis_zm")) {
      continue;
    }
    var_3 = var_0 getEye();
    var_4 = var_3 + 10000 * vectorNormalize(anglesToForward(var_0 _meth_8566()));
    var_5 = bulletTrace(var_3, var_4, 0);

    if(!isDefined(var_5["position"])) {
      continue;
    }
    playFX(common_scripts\utility::_id_44F5("zmb_lewis_upgraded_rewind"), var_5["position"]);
    var_0.rewindorigins[var_0.rewindorigins.size] = var_5["position"];
    var_2 = var_0 _id_0586::_id_078B("lewis_zm") + "+" + _id_056C::getattachmentforzombieweapon("lewis_zm", "zmb_mad_minute");

    if(var_0.rewindorigins.size >= 3) {
      var_0 waittill("reload_start");
      wait 0.7;

      for(var_6 = 0; var_6 < 7; var_6++) {
        foreach(var_8 in common_scripts\utility::array_randomize(var_0.rewindorigins)) {
          _magicbullet(var_2, var_8, var_0 getEye() + (0, 0, -16), var_0);
          playFX(common_scripts\utility::_id_44F5("zmb_lewis_upgraded_rewind"), var_8);
          waitframe();
        }

        wait 0.7;
      }

      var_0.rewindorigins = [];
    }
  }
}

required_weapon(var_0) {
  var_1 = self;
  var_2 = var_1 getcurrentweapon();

  if(_id_0569::_id_55D4(var_2)) {
    var_2 = var_1 maps\mp\_events_z::set_last_checked_weapon(var_2);

    if(!_id_0547::_id_5565(var_2, var_0)) {
      return 0;
    }
  } else
    return 0;

  return 1;
}

force_field_bubble_on_bren_reload() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("reload_start");
    var_0 attempt_reload_action(::spawn_bubble_shield_on_player_small, "bren_zm");
  }
}

mg15_bubble_on_full_clip() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("reload_start");
    var_0 attempt_reload_action(::spawn_bubble_shield_on_player_large, "mg15_zm");
  }
}

mg42_laser_rounds() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = "ptrs41_pap_zm+" + _id_056C::getattachmentforzombieweapon("ptrs41_pap_zm", "zmb_mad_minute");
  var_2 = 0;
  var_3 = 5 + randomint(5);

  for(;;) {
    var_0 waittill("weapon_fired", var_4);
    var_2++;

    if(var_2 < var_3) {
      continue;
    }
    var_2 = 0;
    var_3 = 10 + randomint(25);

    if(!var_0 required_weapon("mg42_zm")) {
      continue;
    }
    var_5 = var_0 _meth_8566();
    var_6 = anglesToForward(var_5);
    var_7 = anglestoup(var_5);
    var_8 = anglestoright(var_5);
    var_9 = var_0 getEye() + var_6 * 45 + var_7 * -6.5 + var_8 * 4;
    var_10 = anglesToForward(var_5);
    _magicbullet(var_1, var_9, var_9 + 1000 * vectorNormalize(anglesToForward(var_0 _meth_8566())), var_0);
  }
}

run_bren_reload_shield(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = _spawnlinkedfx(common_scripts\utility::_id_44F5("force_zombie_bubble"), var_1, "J_SpineLower");
  var_1.linkedbubblefx = var_2;
  _triggerfx(var_2);
  var_1 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_2);
  var_3 = gettime();
  var_4 = 5;

  if(common_scripts\utility::_id_562E(var_0)) {
    var_4 = 10000;
  }

  _id_0547::playfxclient("zmb_bren_pap_screen", var_1.origin, var_1, var_4);

  while((gettime() - var_3) / 1000 < var_4) {
    var_5 = 0;

    foreach(var_7 in _id_0547::_id_408F()) {
      if(distance(var_7.origin, var_1.origin) > 85) {
        continue;
      }
      if(!isDefined(var_7._id_0A4B)) {
        continue;
      }
      if(!common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder"], var_7._id_0A4B)) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_7.plrorbaffected)) {
        continue;
      }
      var_5 = 1;
      playFX(common_scripts\utility::_id_44F5("tesla_blood_explosion"), var_1.origin);
      var_7 _id_0378::_id_8D74("aud_ww_blood_explode");
      var_7 do_strong_giest_damage(level.heavy_giest_dmg, var_1, var_1 _id_0586::_id_078B("bren_zm"));
    }

    waitframe();

    if(var_5) {
      _physicsexplosionsphere(var_1.origin, 250, 150, 2.7);
    }
  }

  playFX(common_scripts\utility::_id_44F5("force_zombie_bubble_pop"), var_1.origin);
  _id_0378::_id_8D74("zmb_pomel_grenade_final_explosion", var_1.origin);

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

do_strong_giest_damage(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");

  if(common_scripts\utility::_id_562E(var_3.tookheavygiestdamage)) {
    return;
  }
  var_3.tookheavygiestdamage = 1;
  var_3 maps\mp\zombies\consumables\inv_giest_shield::play_shield_zombie_shock_vfx();
  waitframe();
  var_3 dodamage(var_0, var_1.origin, var_1, undefined, "MOD_ENERGY", var_2);
  var_3 thread dmg_cooldown();
}

dmg_cooldown() {
  var_0 = self;
  var_0 endon("death");
  wait 2;
  var_0.plrorbaffected = 0;
  var_0.tookheavygiestdamage = 0;
}

scripted_lmg_dmg(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_5)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(_id_0569::_id_55D4(var_5)) {
    var_11 = var_1 maps\mp\_events_z::set_last_checked_weapon(var_5);

    if(var_1 exectute_stinger_feedback(self, var_11, var_6, var_7)) {
      return;
    }
    if(var_1 exectute_mg81_feedback(self, var_11, var_6, var_7)) {
      return;
    }
    if(var_1 exectute_vmg_1927_feedback(self, var_11, var_6, var_7)) {
      return;
    }
  }
}

exectute_vmg_1927_feedback(var_0, var_1, var_2, var_3) {
  if(_id_0547::_id_5565(var_1, "vmg1927_zm")) {
    var_0 try_catch_on_fire(self);
    return 1;
  } else
    return 0;
}

exectute_stinger_feedback(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(_id_0547::_id_5565(var_1, "blyskawica_zm")) {
    if(randomint(3) == 0) {
      playFX(common_scripts\utility::_id_44F5("impact_sparks"), var_2, anglesToForward(var_3), anglestoup(var_3));
    }
  }

  if(_id_0547::_id_5565(var_1, "m1919_zm")) {
    if(!isDefined(var_0.timesstung)) {
      var_0.timesstung = 0;
    }

    if(var_0.timesstung >= 0) {
      var_0.timesstung++;
    }

    if(randomint(200) == 0) {
      var_0.timesstung = 12;
    }

    if(!isDefined(var_4.laststingbursttime)) {
      var_4.laststingbursttime = gettime();
    }

    if(var_0.timesstung > 5) {
      playFX(common_scripts\utility::_id_44F5("impact_sparks"), var_2, anglesToForward(var_3), anglestoup(var_3));
    }

    if(var_0.timesstung >= 12 && (gettime() - var_4.laststingbursttime) / 1000 > 4) {
      var_0.timesstung = -1;
      var_4.laststingbursttime = gettime();
      playsoundatpos(var_2, "zmb_wonder_weapon_proj_impact");
      _id_053A::mini_stunning_burst_execute(var_2, var_4, 60, 0.7, undefined, undefined, "zombie_fireman", maps\mp\zombies\weapons\_zombie_razer_gun::zombie_on_electric_charge);
    }

    return 1;
  } else
    return 0;
}

exectute_mg81_feedback(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(common_scripts\utility::_id_562E(var_4.activatedmg81lastshot)) {
    return 0;
  }

  if(_id_0547::_id_5565(var_1, "mg81_zm")) {
    if(var_4 getcurrentweaponclipammo() == 0 && !common_scripts\utility::_id_562E(var_4.activatedmg81lastshot)) {
      var_4.activatedmg81lastshot = 1;
      var_4 thread restoremg81lastshot();
      var_4 do_pommel_explosion_radius(var_1, var_4, var_0.origin, 192);
    } else
      return 0;

    return 1;
  } else
    return 0;
}

do_pommel_explosion_radius(var_0, var_1, var_2, var_3) {
  var_1 endon("disconnect");
  playFX(level._effect["zmb_pommel_energy_field_burst"], var_2);
  _id_0378::_id_8D74("zmb_pomel_grenade_final_explosion", var_2);

  foreach(var_5 in _id_0547::_id_408F()) {
    if(!isDefined(var_5._id_0A4B) || !common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder"], var_5._id_0A4B)) {
      continue;
    }
    if(distance(var_5.origin, var_2) > var_3) {
      continue;
    }
    var_5 thread do_strong_giest_damage(level.heavy_giest_dmg, var_1, var_1 _id_0586::_id_078B(var_0));
  }

  _physicsexplosionsphere(var_2, 250, 150, 2.7);
}

restoremg81lastshot() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 2;
  var_0.activatedmg81lastshot = 0;
}

try_catch_on_fire(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = 0;

  if(!isDefined(level.zmb_fire_explode_origin)) {
    level.zmb_fire_explode_origin = var_1 common_scripts\utility::_id_8FFC();
    level.zmb_fire_explode_origin show();
  }

  if(!isDefined(var_1.fireshotcount)) {
    var_1.fireshotcount = 0;
  }

  if(common_scripts\utility::_id_562E(var_1.isonfire)) {
    return;
  }
  if(!common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker", "zombie_exploder", "zombie_heavy"], var_1._id_0A4B)) {
    return;
  }
  var_1.fireshotcount++;

  foreach(var_4 in _id_0547::_id_408F()) {
    if(_id_0547::_id_5565("zombie_sizzler", var_4._id_0A4B)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_4.isonfire)) {
      var_2++;
    }
  }

  if(_id_0547::_id_5565("zombie_heavy", var_1._id_0A4B)) {
    var_6 = 15;
  } else {
    var_6 = 5;
  }

  if(var_1.fireshotcount < var_6) {
    return;
  } else if(randomint(100) < 50) {
    var_1.fireshotcount = 0;
    return;
  }

  if(var_2 < 4) {
    var_1.isonfire = 1;
    _id_0547::_id_A6F6();
    var_1 childthread set_on_fire_and_detonate(var_0);
  }
}

scripted_lmgs_on_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self._id_2E68) && isDefined(var_1) && isPlayer(var_1)) {
    level thread do_vmg_explosion(self.origin, var_1);
  }
}

do_vmg_explosion(var_0, var_1) {
  _id_0547::_id_A6F6();
  level.zmb_fire_explode_origin.origin = var_0;
  level.zmb_fire_explode_origin _meth_8561("drag_explosive_zombie_zm", var_1, level.zmb_fire_explode_origin);
}

set_on_fire_and_detonate(var_0) {
  self _meth_8682(0, 100, 1, "none", 1);
  self._id_2E68 = 1;
}

attempt_reload_action(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");

  if(!var_2 required_weapon(var_1)) {
    return;
  }
  if(weapon_clip_empty(var_1)) {
    var_2 childthread[[var_0]]();

    while(weapon_clip_empty(var_1)) {
      waitframe();
    }
  }
}

spawn_bubble_shield_on_player_large() {
  var_0 = self;
  var_0 maps\mp\zombies\consumables\inv_giest_shield::spawn_a_giest_bubble_shield(var_0.origin, 5);
}

spawn_bubble_shield_on_player_small() {
  var_0 = self;
  var_0 thread run_bren_reload_shield();
}

weapon_clip_empty(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_0, _id_0547::_id_AAF9(var_1 getcurrentweapon()))) {
    return 1;
  }

  return var_1 getcurrentweaponclipammo() == 0;
}