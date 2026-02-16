/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1906.gsc
*************************************************/

_id_10DD3() {
  level._id_9C90 = max(scripts\cp\utility::_id_6AC8("#x3f9d04b9bab7c46c5", 2), 5);
  level._id_C88E = scripts\cp\utility::_id_6AC8("#x3f611e9360b26cda3", 15);
  level._id_2CED = ::buildweapon;
  level._id_752E = ::_id_752E;
  level._id_683D = ::_id_683D;
  level._id_3101 = ::_id_3101;
  level._id_10D6F = [];
  level._id_AE0A = [];
  level._id_5045 = [];
  level._id_84F2 = [];
  level._id_10CBB = 0;
  level._id_10DB6 = 0;
  level._id_4EBA = 0;
  level._id_10DA6 = 0;
  level._id_10DC8 = [];
  level._id_5044 = ::_id_4FFD;
  level._id_5D69 = ::buildweapon;
  level._id_5DB9 = ::_id_6D17;
  _id_2D18();
  _id_2CFD();
  _id_0777::_id_3E1F();
  _id_818A();
  _id_D88A();
  _id_D85C();
  level._id_425D = [];
  level thread _id_424A();
  level thread onplayerconnect();
  _id_8B31();
  scripts\cp\cp_outline_utility::_id_824E();
  scripts\engine\utility::_id_1BE2(getEntArray("misc_turret", "classname"), ::_id_F857);

  if(isDefined(level._id_424F)) {
    [[level._id_424F]]();
  } else {
    _id_81EE();
  }

  thread _id_06F9::init();
  level thread _id_7360();
}

_id_7360() {
  wait 10;
  var_0 = [makeweapon("tur_gun_decho_cp"), makeweapon("s4_gunless"), makeweapon("deploy_manual_turret_mp"), makeweapon("manual_turret_mp"), makeweapon("deploy_tactical_cover_mp"), makeweapon("tac_cover_mp"), makeweapon("ac130_25mm_mp"), makeweapon("ac130_40mm_mp"), makeweapon("ac130_105mm_mp"), makeweapon("iw8_ammo_marker_cp"), makeweapon("iw8_armor_marker_cp"), makeweapon("iw8_adrenaline_marker_cp"), makeweapon("iw8_health_marker_cp"), makeweapon("vip_carry_cp"), makeweapon("iw8_health_marker_cp"), makeweapon("deploy_sentry_mp"), makeweapon("ks_generic_mp"), makeweapon("ks_remote_gauntlet_mp"), makeweapon("ks_remote_map_cp"), makeweapon("ks_remote_device_mp"), makeweapon("ks_remote_target_mp"), makeweapon("ks_gesture_generic_mp"), makeweapon("deploy_dronepackage_mp"), makeweapon("deploy_warden_mp"), makeweapon("deploy_box_marker_mp"), makeweapon("ks_manual_turret_marker_mp"), makeweapon("ks_marker_mp"), makeweapon("deploy_pac_sentry_mp"), makeweapon("intel_put_usb_in_tablet"), makeweapon("intel_call_phone"), makeweapon("intel_take_photo"), makeweapon("intel_found_usb"), makeweapon("iw8_nukecore_mp"), makeweapon("tur_gun_lighttank_mp"), makeweapon("intel_pickup_phone"), makeweapon("iw8_spotter_scope_mp"), makeweapon("iw8_la_mike32_mp"), makeweapon("iw8_green_beam_mp"), makeweapon("ks_remote_drone_mp"), makeweapon("s4_super_default_mp")];
  level._id_10D0 = scripts\engine\utility::array_combine(level._id_10D0, var_0);
}

_id_253B(var_0) {}

_id_818A() {
  level._effect["weap_blink_friend"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
  level._effect["weap_blink_enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["equipment_explode_big"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_explosion");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion.vfx");
  level._id_8DF8["spark"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_shock");
  level._effect["gas_grenade_smoke_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_smoke_gren_mp");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["penetration_railgun_explosion"] = loadfx("vfx/iw7/core/expl/weap/chargeshot/vfx_expl_chargeshot.vfx");
  level._effect["flash_bang_explode"] = loadfx("vfx/iw8_mp/equipment/flashbang/vfx_flash_bang.vfx");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch.vfx");
  level._effect["backpack_explosion"] = loadfx("vfx/s4/zombie_ai/vfx_zai_juggernaut_backpack_exp.vfx");
  level._effect["backpack_explosion_sm"] = loadfx("vfx/s4/zombie_ai/vfx_zai_juggernaut_backpack_exp_sm.vfx");
  level._effect["backpack_impact"] = loadfx("vfx/s4/zombie_ai/vfx_zai_juggernaut_backpack_impact.vfx");
  level._effect["juggernaut_bullet_impact"] = loadfx("vfx/s4/zombie_ai/vfx_zai_juggernaut_zmb_impact.vfx");
  level._effect["aether_grenade_trail"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_aether_grenade_trail");
}

_id_D88A() {
  var_0 = 70;
  level._id_3825 = cos(var_0);
  level._id_3827 = 20;
  level._id_3826 = 0.75;
  level._id_3828 = 192;
  level._id_9ED7 = 0.3;
  level._id_9ED9 = 150;
  level._id_9ED8 = 20;
  level._id_9ED3 = 256;
  level._id_9ED1 = 600;
  level._id_9ED0 = 1200;
  level._id_9ECF = 300;
  level._id_9EEF = 600;
  level._id_9EC5 = loadfx("vfx/core/impacts/bouncing_betty_launch_dirt");
  level._id_9EC3 = loadfx("vfx/core/expl/bouncing_betty_explosion.vfx");
  level._id_46D1 = 1.5;
  level._id_2E6E = 0;
  level._id_9EE2 = [];
}

_id_D85C() {
  var_0 = spawnStruct();
  var_0._id_9EBB["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
  var_0._id_9EBB["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level._id_10D6F["c4_mp_p"] = var_0;
  var_0 = spawnStruct();
  var_0._id_1B24 = 1.5;
  var_0._id_48A1 = 232;
  var_0._id_48A0 = 512;
  var_0._id_489F = 1;
  var_0._id_75F5 = 20;
  var_0._id_8D6B = 12;
  level._id_10D6F["proximity_explosive_mp"] = var_0;
  var_0 = spawnStruct();
  var_1 = 800;
  var_2 = 200;
  var_0._id_BF3E = var_1 * var_1;
  var_0._id_BF3F = var_2 * var_2;
  var_0._id_AAE5 = "flash_grenade_expl_trans";
  var_0._id_103C0 = 72;
  level._id_10D6F["flash_grenade_mp"] = var_0;
}

_id_8B31() {
  _id_3A07();
  _id_F1B9();
}

_id_F1B9() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_bio_spike_exp.vfx");
}

_id_3A07() {
  level._effect["clusterGrenade_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_cluster_gren_single_runner.vfx");
}

_id_6E77(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = scripts\cp\utility::getweaponrootname(var_1);
  return "mp/gunsmith/" + _func_00D6(var_2, 4) + "_attachments.csv";
}

_id_6980(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;
  var_8 = strtok(var_7, "_");
  var_9 = 0;

  if(var_8[0] == "alt") {
    var_9++;
  }

  if(var_8[var_9] == "iw7") {
    return;
  } else if(var_8[var_9] == "iw8") {
    var_10 = var_0;

    if(!isDefined(var_1)) {
      var_11 = ["none", "none", "none", "none", "none", "none"];
    } else {
      var_11 = var_1;
    }

    if(!isDefined(var_2)) {
      var_12 = "none";
    } else {
      var_12 = var_2;
    }

    if(!isDefined(var_3)) {
      var_13 = "none";
    } else {
      var_13 = var_3;
    }

    if(!isDefined(var_4)) {
      var_14 = -1;
    } else {
      var_14 = var_4;
    }

    if(!isDefined(var_5)) {
      var_15 = 0;
    } else {
      var_15 = var_5;
    }

    if(!isDefined(var_6)) {
      var_16 = "none";
    } else {
      var_16 = var_6;
    }

    return getcompleteweaponname(buildweapon(var_10, var_11, var_12, var_13, var_14, 1, 1, var_15, var_16));
  }
}

_id_9EF0() {
  self playSound(self._id_3B73._id_AB20);
  playFX(self._id_3B73._id_9104, self.origin);

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self hidepart("tag_sensor");
  _id_E8FD();
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel(self._id_3B73.model);
  var_0 hidepart("tag_base");
  var_0._id_3B73 = self._id_3B73;
  self._id_D0C6 = var_0;
  var_1 = self.origin + (0, 0, self._id_3B73._id_90F9);
  var_2 = self._id_3B73._id_9102;
  var_3 = self._id_3B73._id_9102 + 0.1;
  var_0 moveto(var_1, var_3, 0, var_2);
  var_0 rotatevelocity((0, 1100, 32), var_3, 0, var_2);
  var_0 thread _id_B8F6();
  wait(var_2);
  self notify("detonateExplosive");
}

_id_B8F6() {
  if(isDefined(self._id_3B73._id_9ECC)) {
    self endon("death");
    var_0 = gettime() + 1000;

    while(gettime() < var_0) {
      wait 0.05;
      playFXOnTag(self._id_3B73._id_9ECC, self, "tag_fx_spin1");
      playFXOnTag(self._id_3B73._id_9ECC, self, "tag_fx_spin3");
      wait 0.05;
      playFXOnTag(self._id_3B73._id_9ECC, self, "tag_fx_spin2");
      playFXOnTag(self._id_3B73._id_9ECC, self, "tag_fx_spin4");
    }
  }
}

_id_9ECE() {
  self playSound(self._id_3B73._id_AB20);
  playFX(level._id_9EC5, self.origin);

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  var_0 = self.origin + (0, 0, 64);
  self moveto(var_0, 0.7, 0, 0.65);
  self.killcament moveto(var_0 + self._id_8D6B, 0.7, 0, 0.65);
  self rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  thread _id_B8F6();
  wait 0.65;
  self notify("detonateExplosive");
}

_id_F857() {
  for(;;) {
    self waittill("trigger", var_0);
    thread _id_F863(var_0);
  }
}

_id_F863(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notify("weapon_change", _func_0375());
  self waittill("turret_deactivate");
  var_0 notify("weapon_change", var_0 getcurrentweapon());
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_79B5 = 0;
    var_0 thread onplayerspawned();
    var_0 thread _id_10BAE();
    var_0 thread _id_DFAD();
    var_0 thread _id_10B90();
    var_0 thread _id_FCA0();
    var_0 thread _id_10AAF();
  }
}

_id_3460(var_0) {
  for(;;) {
    self waittill(var_0);
    waitframe();
  }
}

_id_10B90() {}

_id_10AAF() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      _id_4C48(var_0);
    }

    self waittill("weapon_change");
  }
}

_id_4C48(var_0) {
  _id_FD91(var_0);
  _id_FCA1(var_0);
  _id_FCA2();
  _id_FD8E();
  _id_FC4E();
  _id_072A::_id_FD89();
  _id_C88B(var_0);
  _id_FC24(var_0, self._id_90CB);
}

_id_FD91(var_0) {
  if(!isDefined(var_0.basename) || var_0.basename == "none") {
    return;
  } else if(scripts\cp\utility::_id_8A7D(var_0.basename)) {
    _id_073C::_id_FCCC();
    return;
  } else if(scripts\cp\utility::_id_88F6(var_0.basename))
    return;
  else if(var_0.basename == "iw8_fists_mp_ls") {
    _id_073C::_id_FCCC();
    return;
  } else if(var_0._id_0241 != "primary" && var_0._id_0241 != "altmode") {
    return;
  }
  _id_073C::_id_FCCC();
}

_id_FC4E() {
  if(isagent(self)) {
    return;
  }
  var_0 = undefined;
  var_1 = _id_10D87(self._id_0133);

  if(var_1 == 4) {
    var_0 = 0.85;
  } else if(var_1 == 3) {
    var_0 = 0.2;
  } else if(var_1 == 2) {
    var_0 = 0.08;
  } else if(var_1 == 1) {
    var_0 = 0.25;
  } else {
    var_0 = 0.05;
  }

  _id_FD7E(var_0);
}

_id_FD7E(var_0) {
  if(isDefined(var_0)) {
    self._id_103D4 = var_0;
  }

  if(isDefined(self._id_AD1D)) {
    var_0 = self._id_AD1D;
  } else if(isDefined(self._id_AD63)) {
    var_0 = self._id_AD63;
    var_1 = _id_10D87(self getcurrentweapon());

    if(var_1 == 1) {
      var_0 = self._id_AD66;
    } else if(var_1 == 3) {
      var_0 = self._id_AD64;
    } else if(var_1 == 2) {
      var_0 = self._id_AD65;
    } else if(var_1 == 4) {
      var_0 = self._id_AD67;
    }
  } else if(isDefined(self._id_103D4))
    var_0 = self._id_103D4;
  else {
    var_0 = 1.0;
  }

  var_0 = clamp(var_0, 0.0, 1.0);
  self setviewkickscale(var_0);
}

_id_10D87(var_0) {
  var_1 = "none";
  var_2 = -1;

  if(isDefined(var_0) && !isnullweapon(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "pistol":
        var_2 = 1;
        break;
      case "sniper":
        if(getweapongroup(var_0) == "weapon_dmr") {
          if(var_0.basename == "iw8_sn_kilo98_mp") {
            var_2 = 2;
          } else {
            var_2 = 3;
          }
        } else
          var_2 = 4;

        break;
      default:
        var_2 = 0;
    }
  }

  return var_2;
}

_id_FD8E() {
  self._id_BC6C = _id_4EAB(self._id_BC6C);
}

_id_4EAB(var_0) {
  var_1 = self getcurrentweapon();
  _id_10D63(var_1, var_0);
  _id_10DBE(var_1, var_0);
  return var_1;
}

_id_10DBE(var_0, var_1) {
  if(!_func_0376(var_1)) {
    var_2 = scripts\cp\utility::getweaponrootname(var_1.basename);
    var_3 = _id_10DBD(var_2);

    if(isDefined(var_3)) {
      _id_0945::removeperk(var_3);
    }
  }

  if(!_func_0376(var_0)) {
    var_4 = scripts\cp\utility::getweaponrootname(var_0.basename);
    var_5 = _id_10DBD(var_4);

    if(isDefined(var_5)) {
      scripts\cp\utility::_id_6FC2(var_5);
    }
  }
}

_id_10DBD(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_AFA5)) {
    return level._id_10DB0[var_0]._id_AFA5;
  }

  return undefined;
}

_id_10D63(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!_func_0376(var_1)) {
    var_3 = getweaponattachments(var_1);

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = _id_1DAD(var_5);

        if(!isDefined(var_6)) {
          continue;
        }
        _id_0945::removeperk(var_6);
      }
    }
  }

  if(!_func_0376(var_0)) {
    var_2 = getweaponattachments(var_0);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = _id_1DAD(var_9);

        if(!isDefined(var_6)) {
          continue;
        }
        scripts\cp\utility::_id_6FC2(var_6);
      }
    }
  }
}

_id_1DAD(var_0) {
  if(isDefined(level._id_1DA0[var_0])) {
    return level._id_1DA0[var_0];
  }

  return undefined;
}

_id_FCA1(var_0) {
  self._id_90CB = var_0;

  if(_id_894F(var_0)) {
    self._id_9021 = var_0;
  }

  if(_id_8813(var_0)) {
    self._id_8FC2 = var_0;
  }

  if(_id_8799(var_0)) {
    self._id_8F9F = var_0;
  }
}

_id_F42C() {
  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(!isnullweapon(var_0) && var_0.basename == "c4_mp_p" && scripts\cp\utility::_id_8A09(self getcurrentweapon())) {
      self._id_AB8F = 1;
    }
  }
}

_id_F433() {
  if(!istrue(self._id_AB8F)) {
    var_0 = self getheldoffhand();

    if(!isnullweapon(var_0) && var_0.basename != "c4_mp_p" && scripts\cp\utility::_id_8A09(self getcurrentweapon()) && scripts\cp\utility::_id_8AB9(var_0)) {
      self._id_AB8F = 1;
    }
  }
}

_id_F42D(var_0) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");
  childthread _id_F42C();

  if(isDefined(level.monitorshieldalternatemeleethread)) {
    self childthread[[level.monitorshieldalternatemeleethread]]();
  }

  if(isDefined(var_0)) {
    self._id_10A15 = var_0;
  } else if(!isDefined(self._id_10A15)) {
    self._id_10A15 = 0;
  }

  while(scripts\cp\utility::_id_C87D()) {
    _id_F433();
    var_1 = _id_073B::_id_B4EF(self);

    if(!var_1) {
      if(istrue(self._id_10A15)) {
        self._id_9063 = 1;
        self._id_9064 = gettime() + 1300;
      } else if(isDefined(self._id_9064) && gettime() >= self._id_9064) {
        self._id_9063 = undefined;
        self._id_9064 = undefined;
      }

      self._id_10A15 = 0;
    } else {
      self._id_9063 = undefined;
      self._id_9064 = undefined;
      self._id_10A15 = 1;
    }

    if(self isonladder()) {
      _id_F430();
    } else if(self _meth_86C8()) {
      _id_F430();
    } else if(self _meth_86C9()) {
      _id_F431();
    } else if(self _meth_86B8() || self isskydiving()) {
      _id_F430();
    } else if(istrue(self._id_9063)) {
      _id_F430();
    } else if(istrue(self._id_AB8F)) {
      if(isnullweapon(self getheldoffhand())) {
        self._id_AB8F = undefined;
        _id_F432();
      } else
        _id_F430();
    } else
      _id_F432();

    waitframe();
  }

  _id_F432();
}

_id_F430() {
  var_0 = isDefined(self._id_C887);
  var_1 = isDefined(self._id_C888);

  if(!var_1) {
    if(var_0) {
      scripts\cp\utility::_id_C880(1);
    } else {
      scripts\cp\utility::_id_C875(0, _id_C87A());
    }
  }
}

_id_F42F() {
  var_0 = isDefined(self._id_C887);
  var_1 = isDefined(self._id_C888);

  if(!var_0) {
    if(var_1) {
      scripts\cp\utility::_id_C880(0);
    } else {
      scripts\cp\utility::_id_C875(1, _id_C87A());
    }
  }
}

_id_F431() {
  var_0 = isDefined(self._id_C887);
  var_1 = isDefined(self._id_C888);

  if(var_0) {
    scripts\cp\utility::_id_C878(1);
  }

  if(var_1) {
    scripts\cp\utility::_id_C878(0);
  }
}

_id_F432() {
  if(scripts\cp\utility::_id_C87D()) {
    var_0 = scripts\cp\utility::_id_8A09(self getcurrentweapon());

    if(var_0) {
      _id_F42F();
      return;
    }

    _id_F430();
    return;
  } else {
    var_1 = isDefined(self._id_C887);
    var_2 = isDefined(self._id_C888);

    if(var_1) {
      scripts\cp\utility::_id_C878(1);
    }

    if(var_2) {
      scripts\cp\utility::_id_C878(0);
    }
  }
}

_id_C88B(var_0) {
  if(isDefined(level.chargedshieldonchangeweapon)) {
    self[[level.chargedshieldonchangeweapon]](var_0);
  }

  if(scripts\cp\utility::_id_C87D()) {
    thread _id_F42D();
  } else {
    _id_F432();
    _id_C884();
    self notify("riotshield_detach");
  }
}

_id_C884(var_0) {
  self._id_9063 = undefined;
  self._id_9064 = undefined;
  self._id_10A15 = undefined;

  if(istrue(var_0)) {
    self._id_75A5 = undefined;
    self._id_75A6 = undefined;
    self._id_C887 = undefined;
    self._id_C888 = undefined;
  }
}

_id_6474(var_0, var_1, var_2, var_3) {
  var_4 = cos(var_3);
  var_5 = var_1 * var_1;
  var_6 = [];

  foreach(var_8 in level._id_E2A4) {
    if(distancesquared(var_0, var_8.origin) < var_5) {
      if(scripts\engine\utility::_id_10E76(var_0, var_2.angles, var_8.origin, var_4)) {
        var_6[var_6.size] = var_8;
      }
    }
  }

  return var_6;
}

_id_6FDF(var_0) {
  self._id_74F0 = 1;
  thread _id_585B(self);
}

_id_EDD5(var_0) {
  self._id_74F0 = undefined;
  self notify("remove_eye");
}

_id_585B(var_0) {
  self._id_10DF2 = 1;
  level notify("rat_king_eye_activated", self);

  if(scripts\engine\utility::_id_5C0C("rk_fight_started") && !scripts\engine\utility::_id_5C00("rk_fight_started")) {
    thread _id_7487(self);
    self setscriptablepartstate("rat_king_eye_light", "active");
    thread _id_C0C2();
    thread _id_10A43();
  }
}

_id_C0C2() {
  self endon("death");
  self endon("disconnect");
  self endon("removing_eye_from_player");
  level waittill("host_migration_begin");
  level waittill("host_migration_end");

  if(istrue(self._id_10DF2)) {
    self setscriptablepartstate("rat_king_eye_light", "active");
  }
}

_id_10A43() {
  self notify("watch_for_eye_remove");
  self endon("watch_for_eye_remove");
  wait 5;

  if(istrue(self._id_10DF2)) {
    _id_C3BA();
  }
}

_id_C3BA() {
  self._id_10DF2 = 0;
  level notify("rat_king_eye_deactivated");
  self notify("remove_eye");

  if(isDefined(level._id_1041F)) {
    self visionsetnakedforplayer(level._id_1041F, 0.1);
  } else {
    self visionsetnakedforplayer("", 0.1);
  }

  self setscriptablepartstate("rat_king_eye_light", "neutral");
}

_id_DFAD() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = undefined;

  for(;;) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }
    var_1 = self getcurrentweapon();

    if(var_1.classname != "weapon_sniper") {
      continue;
    }
    var_2 = anglesToForward(self.angles);

    if(!isDefined(var_0) || gettime() - var_0 > 2000) {
      var_0 = gettime();
      continue;
    }
  }
}

_id_FA3E(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self setscriptablepartstate("projectile", "inactive");
  var_1 notify("ranged_katana_missile_done");

  if(isDefined(self)) {
    self delete();
  }
}

_id_10BAE() {
  self endon("disconnect");
  thread _id_953A();

  for(;;) {
    var_0 = _id_108E7();
    var_1 = undefined;

    switch (var_0.weapon_name) {
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
        var_1 = self._id_9F76;
        break;
      case "iw8_la_juliet_mp":
        var_1 = self._id_8B7C.target;
        break;
      case "iw8_la_mike32_mp":
        var_0 thread _id_90DC(var_0.owner);
      case "remotemissile_projectile_mp":
        var_0 thread _id_7143();
        break;
      case "glsmoke":
        var_0 thread _id_DE51(1);
        break;
      case "glconc":
        var_0 thread _id_10AB3();
        break;
      case "glflash":
        break;
      case "glincendiary":
        break;
      case "glsnap":
        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\weapon_utility::_id_8916(var_0.weapon_name) && isDefined(var_1)) {
      var_0._id_9701 = var_1;
    }
  }
}

_id_953A() {
  self endon("disconnect");

  for(;;) {
    var_0 = getDvar("#x3f38e830c98df0008", "none");

    if(var_0 != "none") {
      self._id_700E = var_0;
    }

    wait 0.1;
  }
}

_id_90DC(var_0) {
  var_1 = _id_6431(var_0);

  if(isDefined(var_1)) {
    self delete();

    if(isDefined(level._id_425D[var_1])) {
      level thread[[level._id_425D[var_1]]](var_0);
    }
  }
}

_id_6431(var_0) {
  if(isDefined(var_0._id_700E)) {
    return var_0._id_700E;
  }

  return undefined;
}

_id_424A() {
  level._id_425D["concertina"] = ::_id_90F0;
  level._id_425D["thermite"] = ::_id_9101;
  level._id_425D["molotov"] = ::_id_90FB;
  level._id_425D["semtex"] = ::_id_90FF;
  level._id_425D["c4"] = ::_id_90E9;
}

_id_3F4E(var_0, var_1) {
  var_2 = anglesToForward(var_1 getplayerangles());
  var_2 = var_2 * 2000;

  if(var_1 tagexists("tag_flash")) {
    var_3 = var_1 gettagorigin("tag_flash");
  } else {
    var_3 = var_1 getEye();
  }

  var_4 = var_1 launchgrenade(var_0, var_3, var_2);
  var_4.owner = var_1;
  return var_4;
}

_id_9101(var_0) {
  var_1 = _id_3F4E("thermite_proj_cp", var_0);
  var_0 thread _id_0920::_id_F0FB(var_1);
}

_id_90FB(var_0) {
  var_1 = _id_3F4E("molotov_mp", var_0);
  self delete();
}

_id_90FF(var_0) {
  var_1 = _id_3F4E("semtex_mp", var_0);
  var_0 thread _id_D0A2(var_1);
  self delete();
}

_id_90E9(var_0) {
  var_1 = _id_3F4E("c4_mp_p", var_0);
  var_0 thread _id_070E::_id_2E64(var_1);
  self delete();
}

_id_90F8(var_0) {
  self waittill("explode", var_1, var_2, var_3, var_4);
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_5 = spawn("script_model", var_1);
  var_5 setModel("offhand_wm_grenade_thermite");
  var_5 setscriptablepartstate("effects", "impact", 0);
  var_5.trigger = spawn("trigger_radius", var_5.origin, 0, 125, 72);
  var_5.trigger thread _id_10A6A(var_0);
  wait 0.5;
  var_6 = 1;

  while(var_6 <= 10) {
    var_7 = var_6 + 1;
    var_6 = var_7;
    wait 0.5;
  }

  var_5 thread _id_25EC();
}

_id_106FD(var_0) {
  var_1 = scripts\engine\utility::_id_5000(var_0.origin + (0, 0, -100), 0, -5000);
  var_2 = 900;
  var_3 = 1000;
  var_4 = 0;

  for(;;) {
    if(distancesquared(var_0.origin, var_1) <= var_2) {
      return var_1;
    }

    if(var_4 >= var_3) {
      return var_1;
    }

    var_4 = var_4 + 50;
    waitframe();
  }
}

_id_10A6A(var_0) {
  self endon("end_thermite_trigger");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      continue;
    }
    if(!var_1 scripts\cp\utility::_id_86BE()) {
      continue;
    }
    if(isalive(var_1) && !istrue(var_1._id_9B33)) {
      var_1._id_9B33 = 1;
      thread _id_10A6E(var_1);
      var_1 thread scripts\cp\utility::_id_42D4(var_1, var_0, 2.5, 100, "MOD_EXPLOSIVE");
    }
  }
}

_id_10A6E(var_0) {
  self endon("death");
  var_0 waittill("death");
  var_0._id_9B33 = undefined;
  playFX(level._effect["vfx_thermite_end"], var_0.origin);
  self delete();
}

_id_25EC() {
  self setscriptablepartstate("effects", "burnEnd", 0);
  self notify("end_thermite_trigger");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self delete();
}

_id_10830(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      continue;
    }
    if(!var_1 scripts\cp\utility::_id_86BE()) {
      continue;
    }
    if(isalive(var_1) && !istrue(var_1._id_9B33)) {
      var_1._id_9B33 = 1;
      var_1 thread scripts\cp\utility::_id_42D4(var_1, var_0, 5, 100, "MOD_EXPLOSIVE");
    }
  }
}

_id_90F0(var_0) {
  self waittill("missile_stuck", var_1, var_2);
  var_3 = spawn("trigger_radius", self.origin, 0, 500, 72);
  var_3 thread _id_10830(var_0);
  wait 6;
  var_3 delete();
}

_id_C4DE(var_0, var_1) {
  wait(var_1);

  if(scripts\engine\utility::array_contains(level._id_EA69, var_0)) {
    level._id_EA69 = scripts\engine\utility::array_remove(level._id_EA69, var_0);
  }
}

_id_96FE(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = _id_96FF();

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if(isDefined(var_5) && isalive(var_5) && (var_5.team != self.team || var_2)) {
          var_1[var_1.size] = var_5;
        }
      }
    }

    if(isDefined(level._id_0F4C)) {
      foreach(var_8 in level._id_0F4C) {
        if(isDefined(var_8._id_11E4) && (var_8.team != self.team || var_2)) {
          var_1[var_1.size] = var_8;
        }
      }
    }

    if(isDefined(level._id_E3C3)) {
      foreach(var_11 in level._id_E3C3) {
        var_1[var_1.size] = var_11;
      }
    }

    if(isDefined(level._id_3E86)) {
      if(isDefined(level._id_3E86._id_0E45)) {
        foreach(var_14 in level._id_3E86._id_0E45) {
          if(var_14.team != self.team || var_2) {
            var_1[var_1.size] = var_14;
          }
        }
      }
    }

    foreach(var_17 in var_3) {}
  } else {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if((!isDefined(var_5) || !isalive(var_5)) && !var_2) {
          continue;
        }
        var_1[var_1.size] = var_5;
      }
    }

    if(isDefined(level._id_0F4C)) {
      foreach(var_8 in level._id_0F4C) {
        if(isDefined(var_8._id_11E4) && (isDefined(var_8.owner) && var_8.owner != self || var_2)) {
          var_1[var_1.size] = var_8;
        }
      }
    }

    if(isDefined(level._id_3E86)) {
      if(isDefined(level._id_3E86._id_0E45)) {
        foreach(var_14 in level._id_3E86._id_0E45) {
          if(var_14.owner != self || var_2) {
            var_1[var_1.size] = var_14;
          }
        }
      }
    }

    foreach(var_17 in var_3) {}
  }

  foreach(var_28 in var_1) {
    if(!isvector(var_28.origin)) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_28);
    }
  }

  return var_1;
}

_id_96FF() {
  return ["apc_russian", "atv", "big_bird", "cargo_truck", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "medium_transport", "pickup_truck", "tac_rover", "technical", "van"];
}

_id_105A(var_0) {
  if(!isDefined(level._id_E3C3)) {
    level._id_E3C3 = [];
  }

  if(!scripts\engine\utility::array_contains(level._id_E3C3, var_0)) {
    level._id_E3C3 = scripts\engine\utility::array_add(level._id_E3C3, var_0);
  }
}

_id_C3DC(var_0) {
  if(!isDefined(level._id_E3C3)) {
    level._id_E3C3 = [];
  }

  if(scripts\engine\utility::array_contains(level._id_E3C3, var_0)) {
    level._id_E3C3 = scripts\engine\utility::array_remove(level._id_E3C3, var_0);
  }
}

_id_6CBE(var_0, var_1) {
  var_2 = anglestoup(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_5 = randomint(360);
  var_6 = randomint(360);
  var_7 = cos(var_6) * sin(var_5);
  var_8 = sin(var_6) * sin(var_5);
  var_9 = cos(var_5);
  var_10 = (var_7 * var_3 + var_8 * var_4 + var_9 * var_2) / 0.33;
  return -1 * var_10;
}

_id_108E7() {
  self waittill("missile_fire", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      if(var_1._id_0245) {
        var_2 = scripts\cp\utility::_id_1DA5(var_1._id_04B7);

        switch (var_2) {
          case "glconc":
            var_0.weapon_name = "glconc";
            break;
          case "glflash":
            var_0.weapon_name = "glflash";
            break;
          case "glincendiary":
            var_0.weapon_name = "glincendiary";
            break;
          case "glsnap":
            var_0.weapon_name = "glsnap";
            break;
          case "glsmoke":
            var_0.weapon_name = "glsmoke";
            break;
          case "gl":
          default:
            var_0.weapon_name = "gl";
            break;
        }
      } else
        var_0.weapon_name = var_1.basename;
    }

    if(!isDefined(var_0.owner)) {
      var_0.owner = self;
    }

    if(!isDefined(var_0.team)) {
      var_0.team = self.team;
    }
  }

  return var_0;
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self._id_420B = self getcurrentweapon();
    self._id_51B2 = 0;
    self._id_3B5B = 0;
    self._id_79B5 = 0;

    if(!isDefined(self._id_F40F)) {
      self._id_F40F = _func_0375();
      self._id_F414 = 0;
      self._id_F413 = 0;
      self._id_F412 = 0;
      self._id_F411 = 0;
      self._id_F410 = 0;
    }

    _id_C884(1);
    thread _id_10B75();
    thread _id_E582();
    thread _id_820A();
    self._id_8FF1 = [];
    self._id_5046 = undefined;
    self._id_F33C = [];
    thread _id_10B60();
    thread _id_10B61();
    thread _id_A11F();
    self._id_420B = undefined;
    self._id_F6A3 = undefined;
    thread watchweaponpickedup();
    thread _id_CA28(self getcurrentweapon());
  }
}

watchweaponpickedup() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_picked_up", var_0, var_1);

    if(isDefined(var_1.reactivecamoindex)) {
      reactivecamoinittostage(var_0, var_1.reactivecamoindex, var_1.owner);
    }
  }
}

_id_820A() {
  var_0 = self getcurrentweapon();

  switch (var_0.basename) {
    case "iw8_la_gromeo_mp":
      break;
    case "iw8_la_juliet_mp":
      break;
  }
}

_id_FCA2() {
  var_0 = self getcurrentweapon();

  switch (var_0.basename) {
    default:
      break;
    case "iw8_la_gromeo_mp":
      break;
    case "iw8_la_juliet_mp":
      break;
    case "iw8_sn_crossbow_mp":
      thread _id_078B::_id_8177();
      break;
  }

  self notify("end_launcher");

  if(scripts\cp\utility::_hasperk("specialty_fastreload_launchers")) {
    var_1 = weaponclass(var_0.basename) == "rocketlauncher";

    if(var_1 && !istrue(self._id_59BE)) {
      scripts\cp\utility::_id_6FC2("specialty_fastreload");
      self._id_59BE = 1;
    } else if(istrue(self._id_59BE)) {
      scripts\cp\utility::_unsetperk("specialty_fastreload");
      self._id_59BE = undefined;
    }
  }

  switch (var_0.basename) {
    default:
      break;
    case "iw8_sn_crossbow_mp":
      thread _id_078B::_id_4099(var_0);
      break;
    case "iw8_la_gromeo_mp":
      break;
    case "iw8_la_juliet_mp":
      break;
  }
}

_id_10B61() {
  self endon("disconnect");
  self notify("watchForWeaponDropped");
  self endon("watchForWeaponDropped");

  for(;;) {
    self waittill("weapon_dropped", var_0, var_1);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_0) && isDefined(var_1)) {
      if(isDefined(self._id_E9C9)) {
        self._id_E9C9[var_1.basename] = undefined;
      }

      reactivecamodropweapon(var_0, var_1);
    }
  }
}

_id_A11F() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    var_0 = _id_108DC();

    if(isDefined(var_0.weapon_name)) {
      if(_id_7053(var_0.weapon_name) == "stickglprox") {
        _id_D0A2(var_0);
      }

      switch (var_0.weapon_name) {
        case "s4_thermite_zm":
        case "thermite_proj_cp":
          thread _id_0920::_id_F0FB(var_0);
          break;
        case "s4_throwing_knife_zm":
          thread _id_0923::_id_F1A2(var_0);
          break;
      }
    }
  }
}

_id_7053(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return var_0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return var_0;
  }

  if(getweaponbasename(var_0) == "iw7_glprox_mp") {
    if(_func_0121(var_0) && scripts\cp\utility::_id_874D(var_0) || isweapon(var_0) && var_0._id_0245) {
      var_1 = getweaponattachments(var_0);
      var_0 = var_1[0];
    } else
      var_0 = getweaponbasename(var_0);
  }

  return var_0;
}

_id_E582() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(!isPlayer(self)) {
    return;
  }
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  if(!self _meth_8684() && !isai(self)) {
    self notifyonplayercommand("adjustedStance", "+togglecrouch");
    self notifyonplayercommand("adjustedStance", "toggleprone");
    self notifyonplayercommand("adjustedStance", "+movedown");
    self notifyonplayercommand("adjustedStance", "-movedown");
    self notifyonplayercommand("adjustedStance", "+prone");
    self notifyonplayercommand("adjustedStance", "-prone");
  }

  for(;;) {
    scripts\engine\utility::waittill_any_3("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;

    if(isDefined(self._id_AAFE) && self._id_AAFE) {
      continue;
    }
    var_0 = self getstance();
    _id_E583(var_0);
  }
}

_id_E583(var_0) {
  var_1 = self getcurrentprimaryweapon();
  var_2 = 0;

  if(_id_89F0(var_1)) {
    var_2 = _id_6CE6();
  }

  if(var_0 == "prone") {
    var_3 = var_1.classname;

    if(isDefined(var_3)) {
      if(var_3 == "weapon_lmg") {
        _id_D69A(0, 40);
        return;
      }

      if(var_3 == "weapon_sniper") {
        if(var_1 _meth_8624("barrelbored", 1)) {
          _id_D69A(0, 20 + var_2);
          return;
        }

        _id_D69A(0, 40 + var_2);
        return;
        return;
      }

      return;
      return;
    }

    _id_D69A();
    return;
  } else if(var_0 == "crouch") {
    var_3 = var_1.classname;

    if(isDefined(var_3)) {
      if(var_3 == "weapon_lmg") {
        _id_D69A(0, 10);
        return;
      }

      if(var_3 == "weapon_sniper") {
        if(var_1 _meth_8624("barrelbored", 1)) {
          _id_D69A(0, 10 + var_2);
          return;
        }

        _id_D69A(0, 20 + var_2);
        return;
        return;
      }

      return;
      return;
    }

    _id_D69A();
    return;
  } else if(var_2 > 0)
    _id_D69A(0, var_2);
  else {
    _id_D69A();
  }
}

_id_D69A(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self._id_C114)) {
    self._id_C114 = var_0;
  } else {
    self._id_C114 = self._id_C114 + var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self._id_C114) && var_1 < self._id_C114) {
      var_1 = self._id_C114;
    }

    var_2 = 100 - var_1;
  } else
    var_2 = 100 - self._id_C114;

  if(var_2 < 0) {
    var_2 = 0;
  }

  if(var_2 > 100) {
    var_2 = 100;
  }

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

_id_89F0(var_0) {
  if(isnullweapon(var_0)) {
    return 0;
  }

  var_1 = 0;

  if(var_0 _meth_8624("kbsscope", 1) || var_0 _meth_8624("m8scope_zm", 1) || var_0 _meth_8624("cheytacscope", 1)) {
    var_1 = 1;
  }

  return var_1;
}

_id_6CE6() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 40;
}

_id_10B60() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchForWeaponChange");
  self endon("watchForWeaponChange");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(isnullweapon(var_0)) {
      continue;
    }
    if(_id_8AF0(var_0)) {
      self._id_8F74 = var_0;
    }

    if(!isDefined(self._id_E9C9)) {
      self._id_E9C9 = [];
    }

    if(!isDefined(self._id_E9C9[var_0.basename])) {
      self._id_E9C9[var_0.basename] = getcompleteweaponname(var_0);
    }

    if(scripts\cp\utility::_id_88F6(var_0)) {
      continue;
    }
    if(isDefined(level.updatecurrentpapstatus)) {
      [[level.updatecurrentpapstatus]](self);
    }
  }
}

_id_4FF4(var_0) {
  var_0 notify("dropping_minigun");
  var_1 = [];
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_0 hasweapon(var_4)) {
      var_2 = var_4;
    }
  }

  if(isDefined(var_2)) {
    var_6 = makeweapon(var_2);
    var_7 = var_0 dropitem(var_6);
    var_7 thread _id_10C2F();
  } else {}
}

_id_10A72(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("faux_spawn");
  var_0 endon("dropping_minigun");
  var_0 notify("watchMinigunAmmo");
  var_0 endon("watchMinigunAmmo");

  for(;;) {
    var_2 = var_0 getweaponammoclip(var_1);

    if(var_2 <= 0) {
      var_0 takeweapon(var_1);
      return;
    }

    waitframe();
  }
}

_id_B06D(var_0) {
  return 0;
}

_id_EC2E(var_0, var_1) {
  return _id_B4C8(var_0);
}

_id_B4C8(var_0) {
  var_1 = [];

  foreach(var_3 in var_1) {
    if(var_0 hasweapon(var_3)) {
      return 1;
    }
  }

  return 0;
}

_id_861F(var_0) {
  var_1 = weaponclass(var_0);

  if(var_1 == "rocketlauncher") {
    return 1;
  }

  switch (var_0.basename) {
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
      return 1;
  }

  return 0;
}

_id_861A(var_0) {
  switch (var_0.basename) {
    case "ac130_25mm_cp":
    case "ac130_40mm_cp":
      return 1;
    default:
      return 0;
  }
}

_id_0FE9(var_0) {
  var_1 = "xmags_cp_gromeo";

  switch (var_0.basename) {
    case "iw8_la_gromeo_mp":
      var_1 = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      var_1 = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      var_1 = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      var_1 = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(!var_0 _meth_8624(var_1)) {
    var_0 = addattachmenttoweapon(var_0, var_1, 1);
  }

  return var_0;
}

_id_C3FF(var_0) {
  var_1 = "xmags_cp_gromeo";

  switch (var_0.basename) {
    case "iw8_la_gromeo_mp":
      var_1 = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      var_1 = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      var_1 = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      var_1 = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(var_0 _meth_8624(var_1)) {
    _id_C37F(var_1, self, var_0);
  }

  return var_0;
}

_id_885E(var_0) {
  var_0 = scripts\cp\utility::getweaponrootname(var_0);
  return var_0 == "iw8_fists";
}

_id_8AF0(var_0) {
  var_1 = level._id_10D0;
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = makeweaponfromstring(var_0);
  }

  if(isnullweapon(var_2)) {
    return 0;
  } else if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, var_2)) {
    return 0;
  } else if(scripts\cp\utility::_id_8632(var_2, 1)) {
    return 0;
  } else {
    return 1;
  }
}

_id_FD16() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self._id_420B;

  if(isDefined(self._id_CB45)) {
    var_0 = self._id_CB45;
  }

  self._id_CB44 = var_0;

  for(;;) {
    self waittill("weapon_change", var_1);

    if(isnullweapon(var_1)) {
      self._id_CB44 = var_0;
      continue;
    }

    var_2 = _func_0276(var_1);
    self[[level._id_A201]]();
    self._id_CB44 = var_0;

    if(_id_8813(self._id_CB44)) {
      self._id_8FC2 = self._id_CB44;
    }

    var_0 = var_1;
  }
}

_id_12C1() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0.owner = self;

    switch (var_1.basename) {
      case "molotov_mp":
        break;
      case "gas_mp":
        break;
      case "concussion_grenade_mp":
        var_0 thread _id_10AB3();
        break;
    }
  }
}

_id_10B75() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  self._id_F1B3 = undefined;
  self._id_7107 = 0;

  if(!isDefined(self._id_B1CE)) {
    self._id_B1CE = [];
    self._id_B1D0 = [];
  }

  for(;;) {
    self waittill("grenade_pullback", var_0);
    var_1 = self _meth_8578();

    if(!isnullweapon(var_1)) {
      continue;
    }
    var_2 = var_0.basename;
    thread _id_10BB4();
    self._id_F1B3 = var_2;

    if(var_2 == "c4_mp_p") {
      thread _id_24A5();
    }

    _id_24AA();
    self._id_F1B3 = undefined;
  }
}

_id_10BB4() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");

  if(isDefined(self._id_33EF) && self._id_33EF != self getcurrentweapon()) {
    self._id_33EF = undefined;
  }
}

_id_24A5() {
  self notify("beginC4Tracking");
  self endon("beginC4Tracking");
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("grenade_fire", "weapon_change", "offhand_end");
  self._id_33EF = undefined;
}

_id_5080(var_0) {
  var_0 endon("disconnect");
  thread _id_ADA1(var_0);
  thread scripts\cp\utility::_id_A695("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_1);
  self delete();
}

_id_24AA() {
  self endon("offhand_end");
  var_0 = gettime();
  var_1 = _id_108DC();

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_1.weapon_name)) {
    return;
  }
  self._id_33EF = undefined;

  switch (var_1.weapon_name) {
    case "snapshot_grenade_mp":
      break;
    case "iw8_molotov_zm":
    case "molotov_mp":
      self._id_8F3F = gettime();
      break;
    case "iw8_health_marker_cp":
    case "iw8_adrenaline_marker_cp":
    case "iw8_armor_marker_cp":
    case "iw8_ammo_marker_cp":
      break;
    case "dud_grenade_zm":
      var_1 thread _id_5080(self);
      var_1 thread _id_7143();
      break;
    case "thermobaric_grenade_mp":
    case "frag_grenade_mp":
    case "frag_grenade_zm":
      if(gettime() - var_0 > 1000) {
        var_1._id_87C1 = 1;
      }

      _id_09C8::_id_0CF9("frag_grenade_mp", "explosion", 0.5);
      thread _id_7143();
      var_1 thread _id_10B63();
      var_1._id_AC8F = self;
      break;
    case "cluster_grenade_zm":
      var_1._id_3A0C = var_1._id_F1E0;

      if(var_1._id_F1E0 >= 1) {
        var_1._id_87C1 = 1;
      }

      var_1._id_AC8F = self;
      var_1 thread _id_3A09();
      var_1 thread _id_7143();
      break;
    case "zfreeze_semtex_mp":
    case "semtex_zm":
    case "semtex_mp":
      thread _id_D0A2(var_1);
      break;
    case "gas_mp":
      break;
    case "hb_sensor_mp":
      break;
    case "c4_mp_p":
      thread _id_070E::_id_2E64(var_1);
      break;
    case "claymore_mp":
      break;
    case "at_mine_mp":
      break;
    case "trophy_mp":
      break;
    case "flare_mp":
      break;
    case "concussion_grenade_mp":
      var_1 thread _id_10AB3();
      break;
    case "bouncing_betty_mp":
      thread _id_9EF9(var_1, ::_id_E326);
      break;
    case "throwingknifejugg_mp":
    case "throwingknifec4_mp":
    case "throwingknife_mp":
      level thread _id_F1C1(self, var_1, var_1.weapon_name);
      break;
    case "zom_repulsor_mp":
      var_1 delete();
      break;
    case "smoke_grenade_mp":
      var_1 thread _id_DE51();
      break;
    case "gas_grenade_mp":
      var_1 thread _id_10B69();
      break;
    case "trip_mine_mp":
      break;
    case "flash_grenade_mp":
      var_1._id_A4FC = var_1._id_F1E0;
      var_1 thread _id_10AEC();

      if(var_1._id_F1E0 >= 1) {
        var_1._id_87C1 = 1;
      }

      break;
    case "s4_decoy_grenade_zm":
      thread _id_091A::_id_453F(var_1);
      break;
    case "s4_monkey_bomb_zm":
      thread _id_091D::_id_A15C(var_1);
      break;
    case "s4_molotov_zm":
      thread _id_094C::_id_A098(var_1);
      break;
    case "s4_stun_gbr_n69_zm":
      thread scripts\cp\equipment\cp_stun_grenade::stun_grenade_used(var_1);
      break;
    case "s4_c4_zm":
      thread _id_070E::_id_2E64(var_1);
      break;
    case "s4_gas_usa_mk5cn_zm":
      thread _id_091B::_id_61A6(var_1);
      break;
    case "s4_mine_ger_s44_zm":
      thread scripts\cp\equipment\cp_stun_mine::stun_mine_used(var_1);
      break;
    case "s4_crystal_shard_zm":
      thread scripts\cp\equipment\zm_crystal_shard::crystal_shard_used(var_1);
      break;
    case "s4_electric_heart_zm":
      thread scripts\cp\equipment\zm_crystal_shard::electric_heart_used(var_1);
      break;
  }

  if(isDefined(var_1)) {
    var_1 thread _id_0750::_id_7170();
    _id_0750::_id_AAF8(var_1);
  }
}

_id_5805(var_0) {
  thread scripts\cp\utility::_id_A695("death", "end_explode");
  self endon("end_explode");
  var_1 = self.owner;
  self waittill("explode", var_2);
  level notify("explosion_extinguish", var_2, var_0, var_1);
}

_id_A4FB() {
  thread scripts\cp\utility::_id_A695("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_0);
  thread _id_4D61(var_0, self.owner, self._id_A4FC);
  _id_A4FA(var_0, self.owner, self._id_A4FC);
}

_id_A4FA(var_0, var_1, var_2) {
  if(var_2 >= 5) {
    playsoundatpos(var_0, "emp_grenade_explode_default");
    var_3 = level.players;

    foreach(var_5 in var_3) {
      var_5 notify("emp_damage", self.owner, 8.0);
    }
  }
}

_id_4D61(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = level._id_10D6F[self.weapon_name];
  wait(randomfloatrange(0.25, 0.5));

  for(var_4 = 1; var_4 < var_2; var_4++) {
    var_5 = _id_6B97(var_0, var_3._id_103C0);
    playFX(var_3._id_AAE6, var_5);

    foreach(var_7 in level.players) {
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive() || var_7.sessionstate != "playing") {
        continue;
      }
      var_8 = var_7 getEye();
      var_9 = distancesquared(var_0, var_8);

      if(var_9 > var_3._id_BF3E) {
        continue;
      }
      if(!scripts\engine\trace::_bullet_trace_passed(var_0, var_8, 0, var_7)) {
        continue;
      }
      if(var_9 <= var_3._id_BF3F) {
        var_10 = 1.0;
      } else {
        var_10 = 1.0 - (var_9 - var_3._id_BF3F) / (var_3._id_BF3E - var_3._id_BF3F);
      }

      var_11 = anglesToForward(var_7 getplayerangles());
      var_12 = var_0 - var_8;
      var_12 = vectornormalize(var_12);
      var_13 = 0.5 * (1.0 + vectordot(var_11, var_12));
      var_14 = 1;
      var_7 notify("flashbang", var_0, var_10, var_13, var_1, var_14);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

_id_6B97(var_0, var_1) {
  var_2 = (randomfloatrange(-1.0 * var_1, var_1), randomfloatrange(-1.0 * var_1, var_1), 0);
  var_3 = var_0 + var_2;
  var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 0, undefined, 0, 0, 0, 0, 0);

  if(var_4["fraction"] < 1) {
    var_3 = var_0 + var_4["fraction"] * var_2;
  }

  return var_3;
}

_id_C046(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  scripts\engine\utility::_id_108A8(var_0, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

_id_7487(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 thread _id_C046(2.4);
}

_id_88D5(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray("power_exclusion_volume", "targetname");

  if(isDefined(var_5)) {
    if(isDefined(level._id_A422) && isDefined(level._id_A422._id_FD9F)) {
      if(var_5 == level._id_A422 || var_5 == level._id_A422._id_FD9F) {
        return 0;
      }
    }

    if(isDefined(level._id_25C6)) {
      if(var_5 == level._id_25C6) {
        return 0;
      }
    }

    if(isDefined(var_5._id_0481) && var_5._id_0481 == "beginning_area_balloons") {
      return 0;
    }
  }

  if(isDefined(var_1)) {
    var_6 = scripts\engine\utility::array_combine(var_6, var_1);
  }

  foreach(var_8 in var_6) {
    if(_func_011A(var_0, var_8)) {
      return 0;
    }
  }

  if(istrue(var_4) && !_func_02AE(var_0)) {
    return 0;
  }

  if(istrue(var_3)) {
    if(_func_02A6(var_2.origin, var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_B164(var_0, var_1, var_2, var_3) {
  if(isPlayer(self)) {
    self playlocalsound("scavenger_pack_pickup");
  }

  if(istrue(var_1)) {
    var_4 = undefined;

    if(isPlayer(self)) {
      if(isDefined(var_3)) {
        var_4 = _func_020D(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
      } else {
        var_4 = _func_020D(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self);
      }
    } else
      var_4 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2);

    triggerfx(var_4);
    thread _id_B165(var_4);
  }
}

_id_B165(var_0) {
  wait 2;
  var_0 delete();
}

_id_E326(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (0, randomfloat(360), 0);
  }

  var_4 = level._id_10D6F[var_2];
  var_5 = spawn("script_model", var_0);
  var_5.angles = var_3;
  var_5.owner = var_1;
  var_5.weapon_name = var_2;
  var_5._id_3B73 = var_4;
  var_5 setModel(var_4.model);
  var_5 setotherent(var_1);
  var_5._id_8D6B = (0, 0, 4);
  var_5.killcament = spawn("script_model", var_5.origin + var_5._id_8D6B);
  var_5.killcament _meth_8375("explosive");
  var_1 _id_AB22(var_5);

  if(isDefined(var_4._id_9EBB)) {
    var_5 thread _id_4C41("tag_fx", var_4._id_9EBB["friendly"], var_4._id_9EBB["enemy"]);
  }

  var_6 = undefined;

  if(self != level) {
    var_6 = self _meth_8151();
  }

  var_5 _id_57E8(var_6);
  var_5 thread _id_9EE1(var_6);
  var_5 thread _id_7143();
  var_5 thread _id_9EEE();
  var_5 thread _id_9EDA();
  level thread _id_A105(var_1, var_5);
  return var_5;
}

_id_9EEE() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level._id_9EEF + randomfloat(0.4));
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

_id_9EDA() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  var_1 = self._id_3B73;
  var_2 = var_1._id_103C1;

  if(!isDefined(var_2)) {
    var_2 = "tag_fx";
  }

  var_3 = self gettagorigin(var_2);

  if(!isDefined(var_3)) {
    var_3 = self gettagorigin("tag_origin");
  }

  self notify("explode", var_3);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(var_1._id_AAE4)) {
    self thread[[var_1._id_AAE4]]();
  }

  if(isDefined(var_1._id_AAE5)) {
    self playSound(var_1._id_AAE5);
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1._id_AAE6), var_1._id_AAE6, level._id_9EC3);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1._id_9ED1), var_1._id_9ED1, level._id_9ED1);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1._id_9ED0), var_1._id_9ED0, level._id_9ED0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1._id_9ED3), var_1._id_9ED3, level._id_9ED3);
  self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  _id_476C();
}

_id_9EE1(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_1 = self._id_3B73;
  wait(var_1._id_1B88);

  if(isDefined(var_1._id_9EBB)) {
    thread _id_4C41("tag_fx", var_1._id_9EBB["friendly"], var_1._id_9EBB["enemy"]);
  }

  var_2 = spawn("trigger_radius", self.origin, 0, level._id_9ED9, level._id_9ED8);
  var_2.owner = self;
  var_2.team = var_2.owner.team;
  thread _id_9ED5(var_2);

  if(isDefined(var_0)) {
    var_2 _meth_80DB();
    var_2 linkto(var_0);
  }

  self._id_42E1 = var_2;

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isPlayer(var_3)) {
      wait 0.05;
      continue;
    }

    if(var_3 _meth_8096(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound(self._id_3B73._id_ABC5);
  _id_57EC(var_3, level._id_9ED7, "mine");
  self thread[[self._id_3B73._id_ABC4]]();
}

_id_9ED5(var_0) {
  scripts\engine\utility::_id_10882("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_4C41(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getfx("weap_blink_friend");
  }

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::getfx("weap_blink_enemy");
  }

  self._id_257D["friendly"] = var_1;
  self._id_257D["enemy"] = var_2;
  self._id_257E = var_0;
  thread _id_FC15(var_1, var_2, var_0);
  self waittill("death");
  _id_E8FD();
}

_id_FC15(var_0, var_1, var_2) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  var_3 = ::_id_3566;

  if(!level.teambased) {
    var_3 = ::_id_3537;
  }

  var_4 = randomfloatrange(0.05, 0.25);
  wait(var_4);
  childthread _id_AB08(var_0, var_1, var_2, var_3);

  foreach(var_6 in level.players) {
    if(isDefined(var_6)) {
      if(self.owner[[var_3]](var_6)) {
        _func_019D(var_0, self, var_2, var_6);
      } else {
        _func_019D(var_1, self, var_2, var_6);
      }

      wait 0.05;
    }
  }
}

_id_3537(var_0) {
  return self == var_0;
}

_id_3566(var_0) {
  return self.team == var_0.team;
}

_id_AB08(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  for(;;) {
    level waittill("joined_team", var_4);

    if(self.owner[[var_3]](var_4)) {
      _func_019D(var_0, self, var_2, var_4);
      continue;
    }

    _func_019D(var_1, self, var_2, var_4);
  }
}

_id_E8FD() {
  if(isalive(self) && isDefined(self._id_257D)) {
    stopFXOnTag(self._id_257D["friendly"], self, self._id_257E);
    stopFXOnTag(self._id_257D["enemy"], self, self._id_257E);
    self._id_257D = undefined;
    self._id_257E = undefined;
  }
}

_id_10B63() {
  var_0 = self.owner.name;
  self waittill("explode", var_1);
  level notify("grenade_exploded_during_stealth", var_1, "frag_grenade_mp", var_0);
}

_id_10AEC() {
  var_0 = self.owner.name;
  self waittill("explode", var_1);
  level notify("grenade_exploded_during_stealth", var_1, "flash_grenade_mp", var_0);
}

_id_10B69() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  thread _id_AAF7(var_0, var_1);
}

_id_AAF7(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_1, 0, 128, 160);
  var_2.owner = var_0;
  var_3 = 128;
  var_4 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), var_1);
  triggerfx(var_4);
  wait 1.0;

  for(var_5 = 8.0; var_5 > 0.0; var_5 = var_5 - 0.2) {
    var_6 = undefined;

    if(isDefined(level._id_E2A4)) {
      var_6 = level._id_E2A4;
    } else {
      var_6 = _id_06FE::_id_68A1("axis");
    }

    foreach(var_8 in var_6) {
      if(isDefined(var_8._id_1210) && (var_8._id_1210 == "zombie_brute" || var_8._id_1210 == "superslasher" || var_8._id_1210 == "slasher" || var_8._id_1210 == "zombie_grey")) {
        continue;
      }
      var_9 = _id_69BF(var_8);

      if(isalive(var_8)) {
        var_8 _id_19D7(var_0, var_1, var_2, var_2, int(var_9));
      }
    }

    wait 0.2;
  }

  var_4 delete();
  wait 2.0;
  var_2 delete();

  foreach(var_8 in _id_06FE::_id_68A1("axis")) {
    if(isalive(var_8)) {
      var_8._id_5C4B = undefined;
    }
  }
}

_id_69BF(var_0) {
  if(isalive(var_0)) {
    if(istrue(var_0._id_86D9)) {
      return int(min(1000, var_0.maxhealth * 0.25));
    } else {
      return int(min(1000, var_0.maxhealth * 0.1));
    }
  } else
    return 150;
}

_id_19D7(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(self) && self istouching(var_2)) {
    if(var_0 scripts\cp\utility::isenemy(self)) {
      var_3 radiusdamage(self.origin, 1, var_4, var_4, var_0, "MOD_GRENADE_SPLASH", "gas_grenade_mp");
      self._id_5C4B = gettime() + 200;
    }
  }
}

_id_F1C1(var_0, var_1, var_2) {
  if(var_2 == "throwingknifec4_mp") {
    var_1 makeunusable();
    var_1 thread _id_C150();
  }

  thread _id_F1BA(var_0, var_1);
  var_3 = undefined;
  var_4 = undefined;
  var_1 waittill("missile_stuck", var_3, var_4);
  var_5 = isDefined(var_4) && var_4 == "tag_flicker";
  var_6 = isDefined(var_4) && var_4 == "tag_weapon";

  if(isDefined(var_3) && (isPlayer(var_3) || isagent(var_3)) && var_5) {
    var_3 notify("shield_hit", var_1);
  }

  if(isDefined(var_3) && (isPlayer(var_3) || isagent(var_3)) && !var_6 && !var_5) {
    if(var_2 == "throwingknifec4_mp") {
      _id_F1B8(var_1, var_3, var_0);
    }
  }

  var_1._id_5562 = "equip_throwing_knife";
  var_1 thread _id_10B6E();

  for(;;) {
    var_1 waittill("trigger", var_7);
    var_7 _id_0753::_id_BA96(1, "primary");
  }
}

_id_F1BA(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_3) && var_3 == var_1) {
      if(var_7 == "throwingknifeteleport_mp" && !isDefined(var_1._id_8E34)) {
        _id_F1BE(var_1, var_2, var_0, 1);
        var_1._id_6FAC = 1;
      }

      break;
    }
  }
}

_id_10B6E() {
  self waittill("death");

  if(isDefined(self._id_8E32)) {
    self._id_8E32 delete();
  }
}

_id_F1C3(var_0, var_1, var_2) {
  var_3 = var_0 getweaponammoclip(var_2);
  var_4 = 2;
  var_5 = undefined;

  if(var_3 >= var_4) {
    var_5 = 0;
  } else {
    var_0 setweaponammoclip(var_2, var_3 + 1);
    var_0 thread _id_071B::_id_7B6B("throwingknife");
    var_5 = 1;
  }

  return var_5;
}

_id_F1BE(var_0, var_1, var_2, var_3) {
  var_2 playlocalsound("blinkknife_teleport");
  var_2 _meth_827E("blinkknife_teleport_npc");
  playsoundatpos(var_0.origin, "blinkknife_impact");
  thread _id_F1C0(var_2, var_1);
  var_4 = var_1 _meth_8122();

  if(isDefined(var_4)) {
    var_4 notsolid();
  }

  var_5 = [];

  foreach(var_7 in level.characters) {
    if(!isDefined(var_7) || !isalive(var_7) || var_7 == var_1 || var_7 == var_2 || !var_2 scripts\cp\utility::isenemy(var_7)) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  var_5 = _func_0204(var_5, var_1.origin);
  var_9 = var_2 gettagorigin("TAG_EYE");
  var_10 = var_1.origin;
  var_11 = var_1.origin + (0, 0, var_9[2] - var_2.origin[2]);
  var_12 = var_2.angles;

  foreach(var_14 in var_5) {
    var_15 = (var_14.origin[0], var_14.origin[1], var_14 gettagorigin("TAG_EYE")[2]);

    if(distancesquared(var_14.origin, var_1.origin) < 230400 && _func_0202(var_11, var_15, 0, undefined)) {
      var_12 = vectortoangles(var_15 - var_11);
      break;
    }
  }

  var_2 setorigin(var_1.origin, !var_3);
  var_2 setplayerangles(var_12);
  _id_F1BF(var_2, var_1);
}

_id_F1C0(var_0, var_1) {
  var_2 = var_1.origin - var_0.origin;
  var_3 = var_0.origin + (0, 0, 32);
  var_4 = vectornormalize(var_2);
  var_5 = vectornormalize(_func_025B(var_2, (0, 0, 1)));
  var_6 = _func_025B(var_5, var_4);
  var_7 = _func_0017(var_4, var_5, var_6);
  var_8 = 0;

  if(var_8) {
    var_9 = spawn("script_model", var_3);
    var_9.angles = var_7;
    var_9 setModel("tag_origin");
    var_9 hidefromplayer(var_0);
    waitframe();
    _func_02D4(scripts\engine\utility::getfx("vfx_knife_tele_start_friendly"), var_9, "tag_origin", var_0.team);
    wait 3.0;
    var_9 delete();
  } else {
    var_10 = spawn("script_model", var_3);
    var_10.angles = var_7;
    var_10 setModel("tag_origin");
    var_10 hidefromplayer(var_0);
    waitframe();

    foreach(var_12 in level.players) {
      var_10 hidefromplayer(var_12);
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_tele_start_friendly"), var_10, "tag_origin");
    wait 3.0;
    var_10 delete();
  }
}

_id_C150() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self._id_4BBE = 0;
  var_0 = self.origin;

  for(;;) {
    var_1 = scripts\engine\utility::_id_108A8(0.15, "death", "missile_stuck");

    if(!isDefined(self)) {
      break;
    }

    var_2 = distance(var_0, self.origin);
    self._id_4BBE = self._id_4BBE + var_2;
    var_0 = self.origin;

    if(var_1 != "timeout") {
      break;
    }
  }
}

_id_F1BF(var_0, var_1) {}

_id_F1B8(var_0, var_1, var_2) {
  var_1 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var_0.origin);
  var_0 radiusdamage(var_0.origin, 180, 1200, 600, var_2, "MOD_EXPLOSIVE", var_0.weapon_name);
  var_0 thread _id_7143();
  var_0 notify("explode", var_0.origin);
  var_0 delete();
}

_id_F1C2(var_0, var_1) {
  var_1 endon("missile_stuck");
  var_1 endon("death");
  var_0 scripts\engine\utility::waittill_any_2("death", "disconnect");
  var_1._id_8E34 = 1;
}

_id_10AB3() {
  thread _id_5334();
  self endon("end_explode");
  var_0 = self.owner.name;
  self waittill("explode", var_1);
  level notify("grenade_exploded_during_stealth", var_1, "concussion_grenade_mp", var_0);
  childthread _id_EAAA(var_1, self.owner);
  childthread _id_EAAD(var_1, self.owner);
}

_id_EAAD(var_0, var_1) {
  var_2 = level.players;
  var_3 = scripts\engine\utility::_id_6369(var_0, var_2, undefined, 24, 256);

  foreach(var_5 in var_3) {
    if((scripts\cp\utility::_id_85D9(var_5, var_1) && var_5 != var_1) == 0) {
      var_5 thread _id_EAA9(var_5, var_1, var_0);
    }
  }
}

_id_EAA9(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = 3;

  if(var_0 == var_1) {
    var_3 = 2;
    var_4 = 2;
  }

  var_5 = 1 - distance(var_0.origin, var_2) / 512;

  if(var_5 < 0) {
    var_5 = 0;
  }

  var_6 = var_3 + var_4 * var_5;
  var_1 notify("stun_hit");
  var_0 notify("concussed", var_1);
  var_0 scripts\cp\utility::_id_D675();
  var_0 thread _id_3879(var_6);
  var_0 shellshock("concussion_grenade_mp", var_6);
  var_0._id_3B5B = gettime() + var_6 * 1000;
}

_id_3879(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(var_0);
  scripts\cp\utility::_id_D679();
}

_id_EAAA(var_0, var_1) {
  var_2 = scripts\engine\utility::array_combine(_id_06FE::_id_68A1("axis"), _id_06FE::_id_68A1("team_three"));
  var_3 = scripts\engine\utility::_id_6369(var_0, var_2, undefined, 24, 500);

  foreach(var_5 in var_3) {
    var_5 thread _id_607A(var_5, var_1);
  }
}

_id_607A(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(var_0._id_EAA4)) {
    if(gettime() > var_0._id_EAA4) {
      var_0._id_0043 = 1;
      var_0._id_EAA4 = gettime() + 1000;
      var_0._id_EAAB = 1;
      var_0 thread _id_C171();
    } else
      return;
  } else {
    var_0._id_0043 = 1;
    var_0._id_EAA4 = gettime() + 1000;
    var_0._id_EAAB = 1;
    var_0 thread _id_C171();
  }

  var_0 dodamage(1, var_0.origin, var_1, var_1, "MOD_GRENADE_SPLASH", "concussion_grenade_mp");
  wait 10;
  var_0._id_0043 = 0;
  var_0._id_EAAB = undefined;
}

_id_C171() {
  self endon("death");
  self notify("sturn_accuracy_reduction");
  self endon("sturn_accuracy_reduction");

  if(self._id_0087 != 0) {
    self._id_AA08 = self._id_0087;
  }

  self._id_0087 = 0;

  while(istrue(self._id_EAAB)) {
    waitframe();
  }

  if(isDefined(self._id_AA08)) {
    self._id_0087 = self._id_AA08;
  }
}

_id_9EF9(var_0, var_1) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 thread _id_9EF5(self, var_0.weapon_name, var_1);
}

_id_9EF5(var_0, var_1, var_2, var_3) {
  self.owner = var_0;
  self waittill("missile_stuck", var_4);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_1 != "trip_mine_mp") {
    if(isDefined(var_4) && isDefined(var_4.owner)) {
      if(isDefined(var_3)) {
        self.owner[[var_3]](self);
      }

      self delete();
      return;
    }
  }

  var_5 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_6 = var_5["position"];

  if(var_5["fraction"] == 1) {
    var_6 = getgroundposition(self.origin, 12, 0, 32);
    var_5["normal"] = var_5["normal"] * -1;
  }

  var_7 = vectornormalize(var_5["normal"]);
  var_8 = vectortoangles(var_7);
  var_8 = var_8 + (90, 0, 0);
  var_9 = [[var_2]](var_6, var_0, var_1, var_8);
  var_9 thread _id_9ED2();
  self delete();
}

_id_9ED2() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(_id_85F3(var_0, var_4)) {
      break;
    }

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9.basename) {
        case "smoke_grenadejugg_zm":
        case "smoke_grenade_zm":
        case "flash_grenade_zm":
        case "concussion_grenade_zm":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self._id_10A0B = 1;
  }

  if(isDefined(var_8) && var_8 &level._id_7CA1) {
    self._id_10A0F = 1;
  }

  self._id_10A0C = 1;

  if(isDefined(var_0)) {
    self._id_42F2 = var_0;
  }

  self notify("detonateExplosive", var_0);
}

_id_85F3(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.classname)) {
    return 0;
  }

  return var_0.classname == "scriptable" && var_1 == "MOD_EXPLOSIVE";
}

_id_382B(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 hide();
  var_0 scripts\engine\utility::_id_108A7(0.05, "missile_stuck");

  if(!isDefined(self) || !isalive(self)) {
    var_0 delete();
    return;
  }

  var_1 = 60;
  var_2 = (0, 0, 4);
  var_3 = distancesquared(self.origin, var_0.origin);
  var_4 = distancesquared(self getEye(), var_0.origin);
  var_3 = var_3 + 600;
  var_5 = var_0 _meth_8151();

  if(isDefined(var_5)) {
    var_0 unlink();
  }

  if(var_3 < var_4) {
    if(var_1 * var_1 < distancesquared(var_0.origin, self.origin)) {
      var_6 = scripts\engine\trace::_bullet_trace(self.origin, self.origin - (0, 0, var_1), 0, self);

      if(var_6["fraction"] == 1) {
        var_0 delete();
        self setweaponammostock(var_0.weapon_name, self getweaponammostock(var_0.weapon_name) + 1);
        return;
      } else {
        var_0.origin = var_6["position"];
        var_5 = var_6["entity"];
      }
    } else {}
  } else if(var_1 * var_1 < distancesquared(var_0.origin, self getEye())) {
    var_6 = scripts\engine\trace::_bullet_trace(self.origin, self.origin - (0, 0, var_1), 0, self);

    if(var_6["fraction"] == 1) {
      var_0 delete();
      self setweaponammostock(var_0.weapon_name, self getweaponammostock(var_0.weapon_name) + 1);
      return;
    } else {
      var_0.origin = var_6["position"];
      var_5 = var_6["entity"];
    }
  } else {
    var_2 = (0, 0, -5);
    var_0.angles = var_0.angles + (0, 180, 0);
  }

  var_0.angles = var_0.angles * (0, 1, 1);
  var_0.origin = var_0.origin + var_2;
  var_0 _id_57E8(var_5);
  var_0 setscriptablepartstate("plant", "active", 0);
  var_0 show();
  var_0 _meth_85B9();
  var_0 _meth_85BA();
  var_0 _id_99ED();
  var_0 setscriptablepartstate("arm", "active", 0);
  _id_AB22(var_0);
  var_0 thread _id_AAB4();
  var_0 thread _id_2E6D();
  var_0 thread _id_3829(var_5);
  self._id_33EF = undefined;
  level thread _id_A105(self, var_0);
}

_id_3829(var_0) {
  self endon("death");
  var_1 = spawn("trigger_radius", self.origin + (0, 0, 0 - level._id_3828), 0, level._id_3828, level._id_3828 * 2);

  if(isDefined(var_0)) {
    var_1 _meth_80DB();
    var_1 linkto(var_0);
  }

  thread _id_4777(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(getdvarint("#x3a62e6e6ba12b87cc") != 1) {
      if(isDefined(self.owner)) {
        if(var_2 == self.owner) {
          continue;
        }
        if(isDefined(var_2.owner) && var_2.owner == self.owner) {
          continue;
        }
      }

      if(!_id_071A::_id_5FB2(self.owner, var_2, 0)) {
        continue;
      }
    }

    if(_func_0135(var_2 _meth_8131()) < 10) {
      continue;
    }
    var_3 = abs(var_2.origin[2] - self.origin[2]);

    if(var_3 > 128) {
      continue;
    }
    if(!var_2 _id_DAF9(self)) {
      continue;
    }
    if(var_2 _meth_8096(self.origin, self) > 0) {
      break;
    }
  }

  _id_57EC(var_2, level._id_3826, "claymore");
  self notify("detonateExplosive");
}

_id_57EC(var_0, var_1, var_2) {
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_delaymine")) {
    var_0 notify("triggeredExpl", var_2);
    var_1 = level._id_46D1;
  }

  wait(var_1);
}

_id_DAF9(var_0) {
  if(isDefined(var_0._id_4A88)) {
    return 0;
  }

  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < level._id_3827) {
    return 0;
  }

  var_2 = vectornormalize(var_2);
  var_5 = vectordot(var_2, var_3);
  return var_5 > level._id_3825;
}

_id_4777(var_0) {
  self waittill("death");
  self setscriptablepartstate("destroy", "active", 0);
  wait 0.05;

  if(isDefined(var_0)) {
    if(isDefined(var_0.trigger)) {
      var_0.trigger delete();
    }

    var_0 delete();
  }
}

_id_2E6D() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    _id_555C();
    self._id_4A88 = 1;
    self notify("disabled");
    wait(var_1);
    self._id_4A88 = undefined;
    self notify("enabled");
  }
}

_id_555C() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

_id_99EB() {
  self notify("equipmentWatchUse");
  self.trigger delete();
}

_id_99EA(var_0) {
  scripts\cp\utility::_id_99A0(self.owner.team);

  if(!isDefined(var_0) || !var_0) {
    self _meth_821F();
  }
}

_id_2E74(var_0) {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 delete();
    return;
  }

  self notify("c4_update", 0);
  var_0 thread _id_AAB4();
  thread _id_10AAA();
  thread _id_10AA9();
  thread _id_10AA8();
  var_0 setotherent(self);
  var_0._id_0EEB = 0;
  _id_AB22(var_0, "power_c4");
  var_1 = level._id_10D6F["c4_mp_p"];
  var_0 thread _id_4C41("tag_fx", var_1._id_9EBB["friendly"], var_1._id_9EBB["enemy"]);
  var_0 thread _id_2E51();
  var_0 thread _id_2E68();
  var_0 thread _id_2E6A();
  var_0 thread _id_10AAC();
  level thread _id_A105(self, var_0);
}

_id_2E6A() {
  self endon("death");
  self endon("detonated");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  var_1 = 1;

  if(self.owner scripts\cp\utility::_hasperk("specialty_rugged_eqp")) {
    var_1++;
  }

  for(;;) {
    self waittill("damage", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(!scripts\cp\utility::_id_85D9(self.owner, var_0)) {
      continue;
    }
    var_15 = scripts\engine\utility::ter_op(scripts\cp\utility::_id_8866(var_10, var_5), 2, 1);
    var_1 = var_1 - var_15;

    if(var_1 <= 0) {
      break;
    }
  }

  if(level._id_2E6E) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  level._id_2E6E = 1;
  thread _id_C608();

  if(isDefined(var_5) && (issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE"))) {
    self._id_10A0B = 1;
  }

  if(isDefined(var_9) && var_9 &level._id_7CA1) {
    self._id_10A0F = 1;
  }

  if(isDefined(var_9) && var_9 &level._id_7CA3) {
    self._id_10A10 = 1;
  }

  self._id_10A0C = 1;

  if(isDefined(var_0)) {
    self._id_42F2 = var_0;
  }

  if(isPlayer(var_0)) {}

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self.owner)) {
      var_16 = var_0.pers["team"];
      var_17 = self.owner.pers["team"];

      if(isDefined(var_16) && isDefined(var_17) && var_16 != var_17) {
        var_0 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var_0) && var_0 != self.owner)
    var_0 notify("destroyed_equipment");

  self notify("detonateExplosive", var_0);
}

_id_10AAB() {
  self.owner endon("disconnect");
  var_0 = self.owner;
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_1 linkto(self);
  thread _id_5334();
  self endon("end_explode");
  self waittill("explode", var_2);
  thread _id_2E70(var_2, var_0, var_1);
}

_id_2E70(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait 0.5;
  var_2 radiusdamage(var_0, 256, 1200, 600, var_1, "MOD_EXPLOSIVE", "c4_mp_p");
  thread _id_2E51();
}

_id_C608() {
  wait 0.05;
  level._id_2E6E = 0;
}

_id_2E68() {
  self endon("death");
  self waittill("missile_stuck", var_0);
  wait 0.05;
  self notify("activated");
  self._id_0EEB = 1;
}

_id_10AAC() {
  self endon("death");
  self waittill("missile_stuck", var_0);
  self setnodeploy(1);
  self._id_2E73 = 1;
  _id_57E8(var_0);
}

_id_AB22(var_0, var_1, var_2) {
  if(self._id_B1CE.size) {
    self._id_B1CE = scripts\engine\utility::_id_1BD1(self._id_B1CE);

    if(self._id_B1CE.size >= level._id_9C90) {
      if(istrue(var_2)) {
        self._id_B1CE[0] notify("destroyExplosive");
      } else {
        self._id_B1CE[0] _id_476C();
      }
    }
  }

  self._id_B1CE[self._id_B1CE.size] = var_0;
  var_3 = var_0 getentitynumber();
  level._id_9EE2[var_3] = var_0;
  level notify("mine_planted");
}

_id_1046(var_0) {
  var_1 = var_0 getentitynumber();
  level._id_9EE2[var_1] = var_0;
}

_id_10AA8(var_0) {
  self notify("watchC4AltDetonate");
  self endon("watchC4AltDetonate");
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_1 = 0;

      while(self useButtonPressed()) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!self useButtonPressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      if(!self._id_B1CE.size) {
        return;
      }
      self notify("alt_detonate");
    }

    wait 0.05;
  }
}

_id_10AA9() {
  self notify("watchC4AltDetonation");
  self endon("watchC4AltDetonation");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("alt_detonate");
    var_0 = self getcurrentweapon();

    if(var_0.basename != "c4_mp_p") {
      _id_2E6B();
    }
  }
}

_id_10AAA() {
  self notify("watchC4Detonation");
  self endon("watchC4Detonation");
  self endon("death");
  self endon("disconnect");
  var_0 = makeweapon("c4_mp_p");

  for(;;) {
    self waittillmatch("detonate", var_0);
    _id_2E6B();
  }
}

_id_2E6B() {
  foreach(var_1 in self._id_B1CE) {
    if(isDefined(var_1) && var_1.weapon_name == "c4_mp_p") {
      var_1 thread _id_107D7(0.1);
      scripts\engine\utility::array_remove(self._id_B1CE, var_1);
    }
  }

  self notify("c4_update", 0);
  waittillframeend;
  self notify("detonated");
}

_id_107D7(var_0) {
  self endon("death");
  wait(var_0);
  _id_10954();
  self notify("detonateExplosive");
}

_id_10954() {
  if(!isDefined(self._id_4A88)) {
    return;
  }
  self waittill("enabled");
}

_id_3A09() {
  var_0 = self._id_AC8F;
  var_0 endon("disconnect");
  thread _id_ADA1(var_0);
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_1[var_2] = 0.2;
  }

  var_3 = 0;

  foreach(var_5 in var_1) {
    var_3 = var_3 + var_5;
  }

  var_7 = spawn("script_model", self.origin);
  var_7 linkto(self);
  var_7 setModel("tag_origin");
  var_7 _meth_8375("explosive");
  var_7 thread _id_43E2(self, var_3 + 5);
  var_7 thread _id_ADA1(self.owner);
  var_7._id_F170 = self._id_F170;
  var_8 = var_0 scripts\cp\utility::_id_0C48("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  var_8 linkto(self);
  var_8 thread _id_43E2(self, var_3);
  var_8 thread _id_ADA1(self.owner);
  thread scripts\cp\utility::_id_A695("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_9);
  thread _id_3A06(var_9, var_1, var_0, var_7);
}

_id_3A06(var_0, var_1, var_2, var_3) {
  var_2 endon("disconnect");
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 1, 0, 0);
  var_5 = 0;
  var_6 = var_0 + (0, 0, 3);
  var_7 = var_6 + (0, 0, -5);
  var_8 = _func_02C1(var_6, var_7, var_4, undefined, 0, "physicsquery_closest");

  if(isDefined(var_8) && var_8.size > 0) {
    var_5 = 1;
  }

  var_9 = scripts\engine\utility::ter_op(var_5, (0, 0, 32), (0, 0, 2));
  var_10 = var_0 + var_9;
  var_11 = randomint(90) - 45;
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 1, 0, 0);

  for(var_12 = 0; var_12 < 4; var_12++) {
    var_3._id_D9D4 = scripts\engine\utility::ter_op(var_12 == 0, 1, undefined);
    var_3 radiusdamage(var_0, 256, 800, 400, var_2, "MOD_EXPLOSIVE", "cluster_grenade_zm");
    var_13 = scripts\engine\utility::ter_op(var_12 < 4, 90 * var_12 + var_11, randomint(360));
    var_14 = scripts\engine\utility::ter_op(var_5, 110, 90);
    var_15 = scripts\engine\utility::ter_op(var_5, 12, 45);
    var_16 = var_14 + randomint(var_15 * 2) - var_15;
    var_17 = randomint(60) + 30;
    var_18 = cos(var_13) * sin(var_16);
    var_19 = sin(var_13) * sin(var_16);
    var_20 = cos(var_16);
    var_21 = (var_18, var_19, var_20) * var_17;
    var_6 = var_10;
    var_7 = var_10 + var_21;
    var_8 = _func_02C1(var_6, var_7, var_4, undefined, 0, "physicsquery_closest");

    if(isDefined(var_8) && var_8.size > 0) {
      var_7 = var_8[0]["position"];
    }

    playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var_7);

    switch (var_12) {
      case 0:
        playsoundatpos(var_7, "frag_grenade_expl_trans");
        break;
      case 3:
        playsoundatpos(var_7, "cluster_explode_end");
        break;
      default:
        playsoundatpos(var_7, "cluster_explode_mid");
    }

    wait(var_1[var_12]);
  }
}

_id_43E2(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait(var_1);
  self delete();
}

_id_ADA1(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

_id_12D4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.owner = self;
  var_0._id_AC8F = self;
  var_0 setentityowner(self);
  var_0 setotherent(self);
  var_0 setscriptablepartstate("trail", "active", 0);
  var_0 setscriptablepartstate("state", "beacon", 0);
  var_1 = var_0.owner.name;
  var_0 waittill("missile_stuck", var_2);
  level notify("grenade_exploded_during_stealth", var_0.origin, "semtex_mp", var_1);
  var_0 thread _id_7143();
  var_0 _id_57E8(undefined);
}

_id_D0A2(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_AC8F = self;
  var_0 setentityowner(self);
  var_0 setotherent(self);
  var_0 thread _id_D09A();
  var_0 thread _id_D09C();
  var_1 = var_0.owner.name;
  var_0 waittill("missile_stuck", var_2);
  level notify("grenade_exploded_during_stealth", var_0.origin, "semtex_mp", var_1);
  var_0 thread _id_7143();
  var_0 _id_57E8(undefined);
}

_id_D09C() {
  self endon("death");
  wait 2;
  thread _id_D095();
}

_id_D095() {
  thread _id_D093(0.1);
}

_id_D094() {
  thread _id_D093(0.1);
}

_id_D093(var_0) {
  self notify("death");
  self._id_57CE = 1;
  wait(var_0);
  self delete();
}

_id_D09A() {
  self endon("death");
  _id_D09B();

  if(isDefined(self)) {
    thread _id_D094();
  }
}

_id_D09B() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

_id_320E(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6E69(var_0);

  foreach(var_1 in var_2) {}
}

_id_4C78(var_0, var_1) {
  foreach(var_3 in level._id_2A95._id_2A87[var_1]) {
    if(_id_1D99(var_0)) {
      continue;
    } else {
      var_4 = scripts\cp\utility::_id_1DA5(var_0);

      if(var_4 == var_3) {
        return 1;
      }
    }
  }

  return 0;
}

_id_1D99(var_0) {
  return isDefined(var_0) && (scripts\engine\utility::string_starts_with(var_0, "rec") || scripts\engine\utility::string_starts_with(var_0, "front") || scripts\engine\utility::string_starts_with(var_0, "back") || scripts\engine\utility::string_starts_with(var_0, "mag") || scripts\engine\utility::string_starts_with(var_0, "guard") || scripts\engine\utility::string_starts_with(var_0, "triggrip") || scripts\engine\utility::string_starts_with(var_0, "toprail"));
}

_id_753F(var_0, var_1) {
  return _id_753E(getweaponattachments(var_0), var_1);
}

_id_753E(var_0, var_1) {
  if(var_1 == -1) {
    return 1;
  }

  foreach(var_3 in var_0) {
    if(_id_4C78(var_3, var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_C475(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(self) || !isPlayer(self)) {
    return;
  }
  var_2 = var_1;
  var_3 = self getweaponammoclip(var_2);
  var_4 = self getweaponammostock(var_2);
  var_5 = scripts\cp\utility::_id_6E69(var_2);

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    if(scripts\engine\utility::array_contains(var_5, var_0[var_6])) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_0[var_6]);
    }
  }

  _id_0777::_takeweapon(var_2);
  var_7 = scripts\cp\utility::getweaponrootname(var_2.basename);
  var_8 = _id_2D1F(var_7, var_5, -1);

  if(isDefined(var_2._id_0070)) {
    foreach(var_10 in var_2._id_0070) {
      var_2 = var_2 _meth_866A(var_10);
    }
  }

  foreach(var_13 in var_8) {
    var_2 = var_2 _meth_8669(var_13);
  }

  self giveweapon(var_2);
  self setweaponammoclip(var_2, var_3);
  self setweaponammostock(var_2, var_4);
  self switchtoweapon(var_2);
}

_id_C37F(var_0, var_1, var_2) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return;
  }
  var_3 = [];
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_2)) {
    if(isweapon(var_2)) {
      var_3[var_3.size] = var_2;
    } else {
      var_3[var_3.size] = makeweaponfromstring(var_2);
    }
  } else
    var_3 = var_1 getweaponslistall();

  foreach(var_7 in var_3) {
    if(var_7 _meth_8624(var_0, 1)) {
      var_8 = scripts\cp\utility::_id_6CE3(var_7);
      var_9 = getweaponbasename(var_7);
      var_1 takeweapon(var_7);
      var_10 = getweaponattachments(var_7);

      foreach(var_12 in var_10) {
        if(issubstr(var_12, var_0)) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
          break;
        }
      }

      if(isDefined(level._id_2CED)) {
        var_5 = var_1[[level._id_2CED]](var_9, var_10);
      }

      if(isDefined(var_5)) {
        var_3 = self getweaponslistprimaries();

        foreach(var_2 in var_3) {
          if(issubstr(var_2.basename, var_5.basename)) {
            if(var_2._id_0245) {
              var_9 = getweaponbasename(var_2);

              if(isDefined(level._id_1648) && scripts\engine\utility::array_contains(level._id_1648, var_9)) {
                var_5 = var_5 getaltweapon();
                break;
              }
            }
          }
        }

        var_1 scripts\cp\utility::_giveweapon(var_5, -1, -1, 1);
        var_1 switchtoweapon(var_5);
      }
    }
  }
}

_id_74D7(var_0, var_1) {
  var_2 = strtok(var_0, "+");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] == var_1) {
      return 1;
    }

    if(issubstr(var_2[var_3], var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_68DF() {
  var_0 = [];
  var_1 = ["mp/attachmenttable.csv", "cp/cp_attachmenttable.csv"];

  foreach(var_3 in var_1) {
    var_4 = 0;

    for(var_5 = _func_0222(var_3, 0, var_4, 5); var_5 != ""; var_5 = _func_0222(var_3, 0, var_4, 5)) {
      if(!scripts\engine\utility::array_contains(var_0, var_5)) {
        var_0[var_0.size] = var_5;
      }

      var_4++;
    }
  }

  return var_0;
}

_id_68CF() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = _func_0222("cp/cp_attachmenttable.csv", 0, var_1, 5); var_2 != ""; var_2 = _func_0222("cp/cp_attachmenttable.csv", 0, var_1, 5)) {
    if(!scripts\engine\utility::array_contains(var_0, var_2)) {
      var_0[var_0.size] = var_2;
    }

    var_1++;
  }

  return var_0;
}

_id_752E(var_0) {
  var_1 = self getweaponslistprimaries();
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  var_3 = scripts\cp\utility::_id_6CE3(var_2);

  foreach(var_5 in var_1) {
    var_6 = scripts\cp\utility::_id_6CE3(var_5);

    if(var_3 == var_6) {
      return 1;
    }
  }

  return 0;
}

_id_752F(var_0, var_1) {
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(var_1 == var_4.basename) {
      var_5 = [];

      foreach(var_7 in var_4._id_0070) {
        var_5[var_5.size] = ::scripts\cp\utility::_id_1DA5(var_7);
      }

      foreach(var_10 in var_0) {
        if(scripts\engine\utility::array_contains(var_5, var_10)) {
          return 0;
        } else {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_685A(var_0) {
  var_1 = self getweaponslistall();
  var_2 = [];
  var_3 = undefined;

  if(isweapon(var_0)) {
    var_3 = var_0.basename;
  } else {
    var_3 = var_0;
  }

  var_4 = scripts\cp\utility::_id_6CE3(var_3);

  foreach(var_6 in var_1) {
    var_7 = scripts\cp\utility::_id_6CE3(var_6);

    if(var_4 == var_7) {
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

_id_3ED3(var_0, var_1, var_2) {
  level._id_1DAB = [];
  level._id_1DAC = [];

  foreach(var_4 in var_0) {
    var_5 = _func_0222(var_1, 4, var_4, 5);

    if(var_2 == "zombie") {
      if(!isDefined(var_5) || var_5 == "") {
        var_5 = _func_0222("cp/cp_attachmenttable.csv", 4, var_4, 5);
      }
    }

    if(var_4 == var_5) {
      continue;
    }
    level._id_1DAB[var_4] = var_5;
    var_6 = _func_0222("mp/attachmenttable.csv", 4, var_4, 13);

    if(var_6 != "") {
      level._id_1DAC[var_4] = var_6;
      level._id_1D93[var_6] = 1;
    }
  }
}

_id_6BA9() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = _func_0222("mp/attachmenttable.csv", 0, var_1, 5); var_2 != ""; var_2 = _func_0222("mp/attachmenttable.csv", 0, var_1, 5)) {
    var_3 = _func_0222("mp/attachmenttable.csv", 0, var_1, 2);

    if(var_3 != "none" && var_3 != "rail" && !scripts\engine\utility::array_contains(var_0, var_2)) {
      var_0[var_0.size] = var_2;
    }

    var_1++;
  }

  return var_0;
}

_id_6BDC() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = _func_0222("mp/attachmenttable.csv", 0, var_1, 5); var_2 != ""; var_2 = _func_0222("mp/attachmenttable.csv", 0, var_1, 5)) {
    var_3 = _func_0222("mp/attachmenttable.csv", 0, var_1, 2);

    if(var_3 == "rail" && !scripts\engine\utility::array_contains(var_0, var_2)) {
      var_0[var_0.size] = var_2;
    }

    var_1++;
  }

  return var_0;
}

_id_2CFD() {
  level._id_1DAB = [];
  level._id_1DAC = [];
  level._id_1D93 = [];
  level._id_10D64 = [];
  var_0 = [];
  var_1 = tablelookupgetnumrows("mp/attachmentmap.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("mp/attachmentmap.csv", var_2, 0);

    if(var_3 != "" && var_3 != "empty") {
      var_0[var_0.size] = var_3;
    }
  }

  var_4 = [];
  var_5 = _func_0225("mp/attachmentmap.csv");

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_6);

    if(var_7 != "" && var_7 != "empty") {
      var_4[var_7] = var_6;
    }
  }

  level._id_1DA2 = [];

  foreach(var_3 in var_0) {
    foreach(var_12, var_10 in var_4) {
      var_11 = _func_0222("mp/attachmentmap.csv", 0, var_3, var_10);

      if(var_11 == "") {
        continue;
      }
      if(!isDefined(level._id_1DA2[var_3])) {
        level._id_1DA2[var_3] = [];
      }

      level._id_1DA2[var_3][var_12] = var_11;

      if(!isDefined(level._id_1DAB[var_11])) {
        level._id_1DAB[var_11] = var_12;
        continue;
      }

      if(level._id_1DAB[var_11] != var_12) {}
    }
  }

  level.attachmentmap_combooverrides = [];
  var_14 = [];
  var_15 = 1;

  for(var_16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var_15, 0); var_16 != ""; var_16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var_15, 0)) {
    var_14[var_14.size] = var_16;
    var_15++;
  }

  var_17 = [];
  var_6 = 1;

  for(var_18 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var_6); var_18 != ""; var_18 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var_6)) {
    var_17[var_17.size] = var_18;
    var_6++;
  }

  foreach(var_16 in var_14) {
    foreach(var_10, var_18 in var_17) {
      var_21 = _func_0222("mp/attachmentmap_comboOverrides.csv", 0, var_16, var_10 + 1);

      if(var_21 == "") {
        continue;
      }
      if(!isDefined(level.attachmentmap_combooverrides[var_16])) {
        level.attachmentmap_combooverrides[var_16] = [];
      }

      level.attachmentmap_combooverrides[var_16][var_18] = var_21;
    }
  }

  foreach(var_35, var_24 in level._id_10DB0) {
    if(_func_00D6(var_35, 0, 4) == "iw8_") {
      var_25 = _func_00D6(var_35, 4);
    } else {
      var_25 = var_35;
    }

    var_26 = "mp/gunsmith/" + var_25 + "_progression.csv";

    if(!_func_0221(var_26)) {
      continue;
    }
    level._id_10D64[var_35] = [];
    var_15 = 1;
    var_27 = tablelookupbyrow(var_26, var_15, 0);
    var_28 = tablelookupbyrow(var_26, var_15, 1);

    if(_func_00D6(var_35, 0, 4) == "iw8_") {
      var_29 = "loot/iw8_" + var_25 + "_attachment_ids.csv";
    } else {
      var_29 = "loot/" + var_25 + "_attachment_ids.csv";
    }

    while(var_27 != "") {
      if(var_28 != "") {
        var_30 = _func_0222(var_29, 0, var_28, 1);

        if(var_30 != "") {
          level._id_10D64[var_35][var_30] = var_30;
        }
      }

      var_15++;
      var_27 = tablelookupbyrow(var_26, var_15, 0);
      var_28 = tablelookupbyrow(var_26, var_15, 1);
    }

    var_15 = 1;
    var_27 = tablelookupbyrow(var_26, var_15, 0);

    for(var_28 = tablelookupbyrow(var_26, var_15, 5); var_27 != ""; var_28 = tablelookupbyrow(var_26, var_15, 5)) {
      if(var_28 != "") {
        if(issubstr(var_28, "|")) {
          var_31 = strtok(var_28, "|");

          foreach(var_33 in var_31) {
            var_30 = _func_0222(var_29, 0, var_33, 1);

            if(var_30 != "") {
              level._id_10D64[var_35][var_30] = var_30;
            }
          }
        } else {
          var_30 = _func_0222(var_29, 0, var_28, 1);

          if(var_30 != "") {
            level._id_10D64[var_35][var_30] = var_30;
          }
        }
      }

      var_15++;
      var_27 = tablelookupbyrow(var_26, var_15, 0);
    }
  }

  level._id_1DA0 = [];
  level._id_1D9F = [];
  level._id_1DA1 = [];
  level._id_1DAA = [];
  var_36 = _id_68E3();

  foreach(var_38 in var_36) {
    var_39 = _func_0222("mp/attachmenttable.csv", 4, var_38, 2);
    var_40 = scripts\cp\utility::_id_1DA5(var_38);

    if(var_39 != "" && isDefined(var_40)) {
      var_41 = level._id_1DA1[var_40];

      if(!isDefined(var_41)) {
        level._id_1DA1[var_40] = var_39;
      } else if(var_39 != var_41) {
        level._id_1DAA[var_38] = var_39;
      }
    }

    var_42 = _func_0222("mp/attachmenttable.csv", 4, var_38, 12);

    if(var_42 != "") {
      level._id_1DA0[var_38] = var_42;
    }

    var_43 = _func_0222("mp/attachmenttable.csv", 4, var_38, 13);

    if(var_43 != "") {
      level._id_1DAC[var_38] = var_43;
      level._id_1D93[var_43] = 1;
    }

    var_44 = _func_0222("mp/attachmenttable.csv", 4, var_38, 9);

    if(var_44 != "") {
      level._id_1D9F[var_38] = var_44;
    }
  }

  level._id_1DA3 = [];
  var_46 = 1;

  for(var_47 = tablelookupbyrow("mp/attachmentcombos.csv", var_46, 0); var_47 != ""; var_47 = tablelookupbyrow("mp/attachmentcombos.csv", var_46, 0)) {
    var_48 = 1;

    for(var_49 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var_48); var_49 != ""; var_49 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var_48)) {
      if(var_47 != var_49) {
        var_50 = tablelookupbyrow("mp/attachmentcombos.csv", var_46, var_48);
        var_51 = scripts\engine\utility::_id_163E([var_47, var_49]);
        var_52 = var_51[0] + "_" + var_51[1];

        if(var_50 == "no" && !isDefined(level._id_1DA3[var_52])) {
          level._id_1DA3[var_52] = 1;
        } else if(var_50 != "") {
          level._id_1DA3[var_52] = var_50;
        }
      }

      var_48++;
    }

    var_46++;
  }

  level.attachment_replacement_map = [];
  var_53 = tablelookupgetnumrows("cp/zombies/zombie_attachment_replacement_table.csv");

  for(var_54 = 0; var_54 < var_53; var_54++) {
    var_55 = tablelookupbyrow("cp/zombies/zombie_attachment_replacement_table.csv", var_54, 0);

    if(var_55 != "") {
      level.attachment_replacement_map[var_55] = tablelookupbyrow("cp/zombies/zombie_attachment_replacement_table.csv", var_54, 1);
    }
  }

  level.mag_replacement_map = [];
  var_56 = tablelookupgetnumrows("cp/zombies/zombie_mag_replacement_table.csv");

  for(var_54 = 0; var_54 < var_56; var_54++) {
    var_55 = tablelookupbyrow("cp/zombies/zombie_mag_replacement_table.csv", var_54, 0);

    if(var_55 != "") {
      level.mag_replacement_map[var_55] = tablelookupbyrow("cp/zombies/zombie_mag_replacement_table.csv", var_54, 1);
    }
  }
}

_id_68E3() {
  var_0 = [];
  var_1 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("mp/attachmenttable.csv", var_2, 0);
    var_3 = int(var_3);

    if(var_3 == 0) {
      continue;
    }
    var_4 = _func_0222("mp/attachmenttable.csv", 0, var_3, 4);

    if(var_4 != "") {
      var_0[var_4] = var_4;
    }
  }

  return var_0;
}

_id_3F95(var_0, var_1, var_2, var_3) {
  if(var_0 == "zombie") {
    foreach(var_5 in var_1) {
      foreach(var_9, var_7 in var_2) {
        var_8 = _func_0222(var_3, 0, var_5, var_7);

        if(var_8 == "") {
          continue;
        }
        if(!isDefined(level._id_1DA2[var_5])) {
          level._id_1DA2[var_5] = [];
        }

        if(var_8 == "none") {
          level._id_1DA2[var_5][var_9] = undefined;
          continue;
        }

        level._id_1DA2[var_5][var_9] = var_8;
      }
    }
  }
}

_id_7143(var_0) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread _id_5334();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.5, 0.75, var_1, 800);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::_id_8ACE()) {
      continue;
    }
    if(distancesquared(var_1, var_3.origin) > 360000) {
      continue;
    }
    if(var_3 _meth_8096(var_1)) {
      var_3 thread _id_49CD(var_1);
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_2E51() {
  thread _id_5334();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::_id_8ACE()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }
    if(var_2 _meth_8096(var_0)) {
      var_2 thread _id_49CD(var_0);
    }

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_5334() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

_id_49CD(var_0) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && var_7.basename != "iw6_riotshield_mp") {
    scripts\engine\utility::_id_10890(var_6, 2.0);
  } else if(abs(var_4) < 0.866) {
    if(var_5 > 0) {
      scripts\engine\utility::_id_10890(var_6, 2.0);
    } else {
      scripts\engine\utility::_id_10890(var_6, 2.0);
    }
  }
}

_id_D9D4(var_0, var_1) {
  if(_id_8861()) {
    return;
  }
  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(isDefined(self._id_D9D5) && self._id_D9D5) {
        self shellshock("damage_cp", self._id_D9D5);
      } else {
        self shellshock("damage_cp", 0.5);
      }
    }
  }
}

_id_8861() {
  return isDefined(self._id_5CA2) && gettime() < self._id_5CA2;
}

_id_108DC() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(isDefined(self._id_F1B3) && var_1.basename != self._id_F1B3) {
      continue;
    }
    if(isDefined(var_0)) {
      if(!isDefined(var_0._id_10D0B)) {
        var_0._id_10D0B = var_1;
      }

      if(!isDefined(var_0.weapon_name)) {
        var_0.weapon_name = var_1.basename;
      }

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.team)) {
        var_0.team = self.team;
      }

      if(!isDefined(var_0._id_F1E0) && isDefined(self._id_F1B3)) {
        var_0._id_F1E0 = scripts\common\utility::_id_C94D(4 * var_2);
      }
    }

    _id_7168(var_0, var_1, var_2, var_3);

    if(!scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(self._id_F1CD)) {
      self notify("grenade_fire_dead", var_0, var_1.basename);
      self._id_F1CD = 1;
    }

    if(istrue(var_0._id_F170)) {
      _id_0753::_id_BA96(1, "primary");
    }

    if(isDefined(var_0.owner) && !isDefined(var_0.owner.triggeredkeepgrenade)) {
      var_4 = var_0.owner;

      if(isDefined(var_0._id_5562) && !istrue(var_0.isquestitem)) {
        var_5 = scripts\cp\utility::getequipmenttypeequipref(var_0._id_5562);

        if(isDefined(var_5)) {
          if(var_5 == "lethal") {
            scripts\cp\cp_playerstats::incrementcategorystat(var_4, "lethalStats", var_0._id_5562, "uses", 1);
          }

          if(var_5 == "tactical") {
            scripts\cp\cp_playerstats::incrementcategorystat(var_4, "tacticalStats", var_0._id_5562, "uses", 1);
          }
        }
      }

      var_0.owner.triggeredkeepgrenade = _id_0728::should_keep_grenade(var_0.weapon_name, var_0._id_5562, 1);

      if(istrue(var_0.owner.triggeredkeepgrenade)) {
        var_0.owner notify("aether_grenade_triggered");
        var_0.isaethergrenade = 1;
        var_0 apply_aether_grenade_effects(var_0.weapon_name);
      }
    }

    return var_0;
  }
}

apply_aether_grenade_effects(var_0) {
  var_1 = "tag_origin";

  if(isDefined(var_0) && isDefined(level.aether_grenade_tag_overrides[var_0])) {
    var_1 = level.aether_grenade_tag_overrides[var_0];
  }

  if(isDefined(self) && self tagexists(var_1)) {
    playFXOnTag(scripts\engine\utility::getfx("aether_grenade_trail"), self, var_1);
  }
}

_id_717C(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0._id_EA8F = var_1;
    var_1._id_EA8D = var_0;
  } else if(level.teambased && scripts\engine\utility::is_equal(var_1.team, self.team))
    var_0._id_8A69 = "friendly";
  else {
    var_3 = undefined;

    if(!isDefined(var_0.weapon_name)) {
      return;
    }
    switch (var_0.weapon_name) {
      case "semtex_mp":
        var_3 = "semtex_stuck";
        break;
      case "molotov_mp":
        var_3 = "molotov_stuck";
        break;
      case "pop_rocket_proj_mp":
        var_3 = "flare_gun_attacker_stuck";
        break;
      case "s4_thermite_zm":
        var_3 = "thermite_attacker_stuck";
        break;
    }

    var_0._id_8A69 = "enemy";
    var_0._id_EA8F = var_1;
    var_1._id_EA8D = var_0;
    self notify("grenade_stuck_enemy");

    if(isPlayer(var_1)) {
      level thread _id_0750::_id_F759(var_1, "incoming_stuck");
    }
  }
}

_id_717D(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_1) && isDefined(var_0)) {
    if(isDefined(var_2.owner)) {
      var_2 = var_2.owner;
    }

    var_2 scripts\cp\cp_hud_message::showsplash(var_0);
  }
}

_id_3103(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self getcurrentweapon();
  }

  var_2 = getweaponbasename(var_1);
  var_3 = var_1.classname;
  var_4 = _id_66B7(var_3, var_2, var_0);

  if(!var_4) {
    return 0;
  }

  return 1;
}

_id_0F9D(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1)) {
    if(isweapon(var_1)) {
      var_4 = var_1;
    } else {
      var_4 = makeweaponfromstring(var_1);
    }
  } else
    var_4 = scripts\cp\utility::_id_6E34();

  var_5 = getweaponbasename(var_4);
  var_6 = 0;
  var_7 = getweaponattachments(var_4);
  var_8 = scripts\cp\utility::_id_69A1(var_4);
  var_9 = _id_C78E(var_4, var_0, var_7, undefined, var_8);

  if(!isDefined(var_9)) {
    return 0;
  }

  var_10 = makeweaponfromstring(var_9);

  if(isnullweapon(var_10)) {
    return 0;
  }

  var_11 = var_4._id_0245;

  if(var_10 _meth_8624("xmags", 1)) {
    var_6 = 1;
  }

  if(isDefined(var_0)) {
    if(!issubstr(var_0, "pap")) {
      var_12 = self getweaponammoclip(var_4);
      var_13 = self getweaponammostock(var_4);

      if(var_10 _meth_8624("akimbo", 1)) {
        var_14 = self getweaponammoclip(var_4, "left");
      } else {
        var_14 = undefined;
      }

      self takeweapon(var_4);
      scripts\cp\utility::_giveweapon(var_10, undefined, undefined, 1);

      if(var_10 _meth_8624("xmags", 1) && !var_6) {
        var_12 = weaponclipsize(var_10);
      }

      self setweaponammoclip(var_10, var_12);
      self setweaponammostock(var_10, var_13);

      if(isDefined(var_14)) {
        self setweaponammoclip(var_10, var_14, "left");
      }
    } else {
      self takeweapon(var_4);
      scripts\cp\utility::_giveweapon(var_10, undefined, undefined, 0);
      self givemaxammo(var_10);
    }
  }

  self playlocalsound("weap_raise_large_plr");
  var_15 = self getweaponslistprimaries();

  foreach(var_1 in var_15) {
    if(issubstr(var_1.basename, var_10.basename)) {
      if(var_1._id_0245) {
        var_17 = getweaponbasename(var_1);

        if(isDefined(level._id_1648) && scripts\engine\utility::array_contains(level._id_1648, var_17) || var_11) {
          var_10 = var_10 getaltweapon();
          break;
        }
      }
    }
  }

  if(istrue(var_3)) {
    return 1;
  }

  if(istrue(var_2)) {
    self switchtoweaponimmediate(var_10);
  } else {
    self switchtoweapon(var_10);
  }

  return 1;
}

_id_886B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0)) {
    if(var_0 == "iw7_forgefreeze_zm" || var_0 == "iw7_forgefreeze_zm_pap1" || var_0 == "iw7_forgefreeze_zm_pap2" || var_0 == "zfreeze_semtex_mp") {
      return 1;
    }
  }

  return 0;
}

_id_8A65(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1 == "iw7_steeldragon_zm";
}

_id_865F(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "doubletap") {
    return 1;
  }

  return 0;
}

_id_855B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "ark")) {
    return 1;
  }

  if(issubstr(var_0, "arcane")) {
    return 1;
  }

  return 0;
}

_id_8634(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "mod")) {
    return 1;
  }

  return 0;
}

_id_859D(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_10D61(var_1);

  if(!isDefined(var_2) || var_2.size < 1) {
    return 0;
  }

  foreach(var_4 in var_2) {
    if(var_0 == var_4) {
      return 1;
    }
  }

  return 0;
}

_id_8658(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "pap")) {
    return 1;
  }

  return 0;
}

_id_66B7(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = [];
  var_4 = scripts\cp\utility::_id_6902(var_1);

  if(isDefined(level._id_1DA2[var_4])) {
    if(isDefined(level._id_1DA2[var_4][var_2])) {
      if(level._id_1DA2[var_4][var_2] != "none") {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(isDefined(level._id_1DA2[var_0])) {
    if(isDefined(level._id_1DA2[var_0][var_2])) {
      if(level._id_1DA2[var_0][var_2] != "none") {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(isDefined(level._id_1DA2[var_4])) {
    var_5 = getarraykeys(level._id_1DA2[var_4]);

    foreach(var_7 in var_5) {
      if(level._id_1DA2[var_4][var_7] == var_2) {
        if(level._id_1DA2[var_4][var_7] != "none") {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  if(isDefined(level._id_1DA2[var_0])) {
    var_5 = getarraykeys(level._id_1DA2[var_0]);

    foreach(var_7 in var_5) {
      if(level._id_1DA2[var_0][var_7] == var_2) {
        if(level._id_1DA2[var_0][var_7] != "none") {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  return 0;
}

_id_C78E(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    if(isweapon(var_0)) {
      var_5 = var_0;
    } else {
      var_5 = makeweaponfromstring(var_0);
    }
  } else
    var_5 = self getcurrentweapon();

  var_6 = getweaponbasename(var_5);
  var_7 = scripts\cp\utility::_id_6859(self, var_5);
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = undefined;
  var_13 = [];
  var_14 = 7;
  var_15 = [];
  var_16 = 1;
  var_17 = [];
  var_18 = 1;
  var_19 = [];
  var_20 = 1;
  var_21 = [];
  var_22 = 1;
  var_23 = [];
  var_24 = 1;
  var_25 = [];
  var_26 = 12;
  var_27 = var_5.classname;

  if(var_5 _meth_8624("xmags", 1)) {
    var_9 = 1;
  }

  var_28 = _id_66B7(var_27, var_6, var_1);

  if(!var_28 && isDefined(var_1)) {
    if(!istrue(var_3)) {
      scripts\cp\utility::_id_D5E9("cant_attach", &"COOP_PILLAGE/CANT_USE", 3);
    }

    return undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = getweaponattachments(var_5);
  }

  if(scripts\cp\utility::_id_7531("perk_machine_rat_a_tat")) {
    if(_id_66B7(var_27, var_6, "doubletap")) {
      var_2[var_2.size] = "doubletap";
    }
  }

  if(isDefined(var_1)) {
    if(weaponclass(var_0) == "spread") {
      if(issubstr(var_1, "arkyellow")) {
        foreach(var_30 in var_2) {
          if(issubstr(var_30, "smart")) {
            var_2 = scripts\engine\utility::array_remove(var_2, var_30);
          }
        }
      }
    }
  }

  var_2 = scripts\engine\utility::_id_1BC1(var_2);
  var_2 = scripts\engine\utility::_id_1BD1(var_2);

  if(var_2.size > 0 && var_2.size <= var_26) {
    foreach(var_33 in var_2) {
      if(_id_8658(var_33)) {
        if(var_17.size < var_18) {
          var_17[var_17.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(_id_855B(var_33)) {
        if(var_23.size < var_24) {
          var_23[var_23.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(_id_8634(var_33)) {
        if(var_19.size < var_20) {
          var_19[var_19.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(_id_859D(var_33, scripts\cp\utility::getweaponrootname(var_6))) {
        if(var_21.size < var_22) {
          var_21[var_21.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(_id_865F(var_33)) {
        if(var_15.size < var_16) {
          var_15[var_15.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(var_13.size < var_14) {
        var_13[var_13.size] = var_33;
        var_25[var_25.size] = var_33;
        continue;
      }

      continue;
    }
  }

  if(isDefined(var_1)) {
    var_35 = scripts\cp\utility::_id_1DA5(var_1);

    if(isDefined(var_35) && var_35 != "none") {
      for(var_36 = 0; var_36 < var_25.size; var_36++) {
        var_37 = scripts\cp\utility::_id_1DA5(var_25[var_36]);

        if(var_37 == var_35) {
          var_25[var_36] = var_1;
          var_8 = 1;
          break;
        }
      }
    }

    var_38 = scripts\cp\utility::_id_68E5(var_1);

    if(isDefined(var_38) && var_38 != "none") {
      if(!var_8) {
        if(_id_8658(var_1)) {
          if(var_17.size < var_18) {
            var_17[var_17.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::_id_68E5(var_25[var_36]);

              if(var_39 == var_38) {
                var_17[var_17.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(_id_855B(var_1)) {
          if(var_23.size < var_24) {
            var_23[var_23.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::_id_68E5(var_25[var_36]);

              if(var_39 == var_38) {
                var_23[var_15.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(_id_865F(var_1)) {
          if(var_15.size < var_16) {
            var_15[var_15.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::_id_68E5(var_25[var_36]);

              if(var_39 == var_38) {
                var_15[var_15.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(var_13.size < var_14) {
          var_13[var_13.size] = var_1;
          var_25[var_25.size] = var_1;
        } else {
          for(var_36 = 0; var_36 < var_25.size; var_36++) {
            var_39 = scripts\cp\utility::_id_68E5(var_25[var_36]);

            if(var_39 == var_38) {
              var_13[var_13.size] = var_1;
              var_25[var_36] = var_1;
              var_8 = 1;
              break;
            }
          }

          if(!var_8) {
            return undefined;
          }
        }
      } else if(_id_865F(var_1)) {
        var_17[var_17.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(_id_8658(var_1)) {
        var_15[var_15.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(_id_855B(var_1)) {
        var_23[var_23.size] = var_1;
        var_25[var_25.size] = var_1;
      } else {
        var_13[var_13.size] = var_1;
        var_25[var_25.size] = var_1;
      }
    } else if(isDefined(var_1)) {
      if(_id_865F(var_1)) {
        var_15[var_15.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(_id_8658(var_1)) {
        var_17[var_17.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(_id_855B(var_1)) {
        var_23[var_23.size] = var_1;
        var_25[var_25.size] = var_1;
      } else {
        var_13[var_13.size] = var_1;
        var_25[var_25.size] = var_1;
      }
    }
  }

  var_40 = scripts\cp\utility::getweaponrootname(var_6);
  var_41 = isDefined(self._id_10CEA[scripts\cp\utility::_id_6CE3(var_5)]);

  if(!isDefined(var_4) && var_41) {
    var_10 = scripts\cp\utility::_id_6E6B(var_40);
  } else {
    var_10 = var_4;
  }

  if(var_41) {
    var_42 = 0;

    foreach(var_30 in var_25) {
      if(issubstr(var_30, "cos_")) {
        var_42 = 1;
        var_12 = undefined;
        break;
      }
    }

    if(!var_42) {
      var_12 = scripts\cp\utility::_id_6E6E(var_40);
    }

    var_11 = scripts\cp\utility::_id_6E88(var_40);
    var_45 = scripts\cp\utility::_id_6E7F(var_40);
  } else {
    var_12 = undefined;
    var_11 = undefined;
    var_45 = undefined;
  }

  foreach(var_30 in var_25) {
    if(issubstr(var_30, "arcane") || issubstr(var_30, "ark")) {
      foreach(var_48 in var_25) {
        if(var_30 == var_48) {
          continue;
        }
        if(issubstr(var_48, "cos_")) {
          var_25 = scripts\engine\utility::array_remove(var_25, var_48);
        }
      }

      var_12 = undefined;
    }
  }

  var_51 = scripts\cp\utility::_id_A2AE(var_40, var_25, var_10, var_11, var_7, self getentitynumber(), self._id_399D, var_45, var_12);

  if(isDefined(var_51)) {
    return var_51;
  } else {
    return getcompleteweaponname(var_5);
  }
}

_id_68E6(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6E68(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = scripts\cp\utility::_id_1DA9(var_5, var_0);

    if(var_5 != var_6) {
      var_7 = scripts\cp\utility::_id_68E5(var_6);
    } else {
      continue;
    }

    if(var_7 == "") {
      continue;
    }
    if(isDefined(level.attachment_replacement_map[var_6])) {
      var_8 = level.attachment_replacement_map[var_6];

      if(var_8 == "") {
        continue;
      } else {
        var_5 = scripts\cp\utility::_id_1DA5(level.attachment_replacement_map[var_6]);

        if(var_5 == var_8) {
          continue;
        }
      }
    }

    if(isDefined(var_1) && scripts\cp\utility::_id_9553(var_1, var_5)) {
      continue;
    }
    if(!isDefined(var_3[var_7])) {
      var_3[var_7] = [];
    }

    var_3[var_7] = ::scripts\cp\utility::_id_1B8C(var_3[var_7], var_5);
  }

  return var_3;
}

_id_68E0() {
  var_0 = [];
  var_1 = ["mp/attachmenttable.csv", "cp/cp_attachmenttable.csv"];

  foreach(var_3 in var_1) {
    var_4 = 0;

    for(var_5 = _func_0222(var_3, 0, var_4, 5); var_5 != ""; var_5 = _func_0222(var_3, 0, var_4, 5)) {
      var_6 = _func_0222(var_3, 0, var_4, 2);

      if(var_6 != "none" && !scripts\engine\utility::array_contains(var_0, var_5)) {
        var_0[var_0.size] = var_5;
      }

      var_4++;
    }
  }

  return var_0;
}

_id_6E67(var_0) {
  var_1 = [];
  var_2 = scripts\cp\utility::_id_6902(var_0);
  var_3 = scripts\cp\utility::_id_3D17(var_0);

  if(isDefined(level._id_1DA2[var_2])) {
    var_1 = scripts\engine\utility::array_combine(var_1, level._id_1DA2[var_2]);
  }

  if(isDefined(level._id_1DA2[var_3])) {
    var_1 = scripts\engine\utility::array_combine(var_1, level._id_1DA2[var_3]);
  }

  return var_1;
}

_id_8AF1(var_0) {
  if(!isDefined(level._id_10DC6)) {
    level._id_10DC6 = [];

    foreach(var_2 in level.weaponlist) {
      level._id_10DC6[getcompleteweaponname(var_2)] = 1;
    }
  }

  if(isDefined(level._id_10DC6[var_0])) {
    return 1;
  }

  return 0;
}

_id_D8E8() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self._id_B005 = 0;
  var_0 = self getcurrentweapon();

  for(;;) {
    _id_D8EC(var_0);

    if(self._id_B005 == 0) {
      self._id_B005 = 1;
      _id_5273();
    }

    childthread _id_D8E9();
    childthread _id_D8EA(1.0);
    self._id_B004 = undefined;
    self waittill("weapon_change", var_0);

    if(self._id_B005 == 1) {
      self._id_B005 = 0;
      _id_4AFD();
    }
  }
}

_id_D8EC(var_0) {
  for(;;) {
    if(isDefined(var_0) && (var_0.basename == "iw6_kac_mp" || var_0.basename == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", var_0);
  }
}

_id_D8E9() {
  self endon("weapon_change");

  for(;;) {
    if(!isDefined(self._id_B004) || self._id_B004 == 0) {
      if(self playerads() > 0.6) {
        if(self._id_B005 == 1) {
          self._id_B005 = 0;
          _id_4AFD();
        }
      } else if(self._id_B005 == 0) {
        self._id_B005 = 1;
        _id_5273();
      }
    }

    waitframe();
  }
}

_id_D8EA(var_0) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread _id_D8EB(var_0);
  }
}

_id_D8EB(var_0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self._id_B005 == 1) {
    self._id_B004 = 1;
    self._id_B005 = 0;
    _id_4AFD();
  }

  wait(var_0);
  self._id_B004 = undefined;

  if(self._id_B005 == 0 && self playerads() <= 0.6) {
    self._id_B005 = 1;
    _id_5273();
  }
}

_id_5273() {
  if(!isDefined(self._id_10DA8)) {
    self._id_10DA8 = 0;
  }

  self._id_10DA8++;
  self _meth_8203();
}

_id_4AFD() {
  self._id_10DA8--;

  if(self._id_10DA8 == 0) {
    self _meth_8202();
    self._id_10DA8 = undefined;
  }
}

_id_AAB4(var_0) {
  self endon("death");
  level endon("game_ended");
  thread _id_3883();
  self waittill("detonateExplosive");

  if(isDefined(var_0)) {
    self.owner notify(var_0, 1);
  } else {
    self.owner notify("powers_c4_used", 1);
  }

  self detonate(self.owner);
}

_id_3883() {
  self endon("deleted_equipment");
  level endon("game_ended");
  var_0 = self getentitynumber();
  var_1 = self.killcament;
  var_2 = self.trigger;
  var_3 = self._id_D0C6;
  self waittill("death");
  _id_3882(var_0, var_1, var_2, var_3);
}

_id_3882(var_0, var_1, var_2, var_3) {
  if(isDefined(self.weapon_name)) {
    if(self.weapon_name == "c4_mp_p") {
      self.owner notify("c4_update", 0);
    } else if(self.weapon_name == "bouncing_betty_mp") {
      self.owner notify("bouncing_betty_update", 0);
    } else if(self.weapon_name == "sticky_mine_mp") {
      self.owner notify("sticky_mine_update", 0);
    } else if(self.weapon_name == "trip_mine_mp") {
      self.owner notify("trip_mine_update", 0);
    } else if(self.weapon_name == "cryo_grenade_mp") {
      self.owner notify("restart_cryo_grenade_cooldown", 0);
    }
  }

  if(isDefined(var_0)) {
    level._id_9EE2[var_0] = undefined;
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_A0FF(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 9999999;
  self.maxhealth = var_0;
  self._id_014E = 0;

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_6 = 1; var_6; var_6 = _id_A101(var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_20, var_1, var_2, var_3, var_4)) {
    self waittill("damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20);

    if(var_5) {
      self playrumbleonentity("damage_light");
    }

    if(isDefined(self._id_77E7) && self._id_77E7 == "littlebird") {
      if(!isDefined(self._id_1DDE)) {
        self._id_1DDE = [];
      }

      var_21 = "";

      if(isDefined(var_8) && isPlayer(var_8)) {
        var_21 = var_8 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self._id_1DDE[var_21])) {
        self._id_1DDE[var_21] = self._id_1DDE[var_21] + var_7;
      } else {
        self._id_1DDE[var_21] = var_7;
      }
    }
  }
}

_id_A101(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(var_1) && !_id_071A::_id_5FB2(self.owner, var_1)) {
    if(isDefined(self._id_5562) && self._id_5562 == "equip_tac_cover") {} else
      return 1;
  }

  var_15 = var_0;

  if(isDefined(var_9)) {
    if(_id_A5A7(var_1, var_9, var_10, var_4)) {
      return 1;
    }
  }

  var_16 = _id_09BF::_id_ADCA(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);

  if(!isDefined(var_13)) {
    var_13 = _id_071A::_id_A007;
  }

  var_15 = self[[var_13]](var_16);

  if(var_15 <= 0) {
    return 1;
  }

  self._id_10A0C = 1;
  self._id_014E = self._id_014E + var_15;
  self.health = 2147483647;

  if(istrue(var_14)) {
    scripts\cp\utility::_id_8DD6(var_1, var_9, self, var_4, var_15);
  }

  if(isDefined(var_1)) {
    if(isPlayer(var_1)) {
      var_1 _id_071B::_id_FC47(var_11);
    }
  }

  if(self._id_014E >= self.maxhealth) {
    var_16 = _id_09BF::_id_ADCA(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);
    self thread[[var_12]](var_16);
    return 0;
  }

  return 1;
}

_id_A5A7(var_0, var_1, var_2, var_3) {
  if(_id_A5A8(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  if(isDefined(var_1.basename)) {
    if(var_3 != "MOD_MELEE") {
      switch (var_1.basename) {
        case "iw8_green_beam_mp":
        case "iw8_spotter_scope_mp":
          return 1;
      }
    }

    if(var_3 == "MOD_IMPACT") {
      switch (var_1.basename) {
        case "at_mine_mp":
        case "claymore_mp":
        case "c4_mp_p":
        case "thermite_mp":
        case "semtex_mp":
          return 1;
      }
    } else {
      switch (var_1.basename) {
        case "claymore_radial_mp":
        case "emp_drone_player_mp":
        case "thermite_ap_mp":
        case "snapshot_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "gas_mp":
          return 1;
      }
    }
  }

  return 0;
}

_id_A5A8(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_7D20)) {
    return 0;
  }

  if(isDefined(var_1) && _func_0121(var_1)) {
    var_1 = makeweapon(var_1);
  }

  foreach(var_5 in self._id_7D20) {
    if(!isDefined(var_5)) {
      return 0;
    }

    if(var_5._id_34E2) {
      if(!isDefined(var_5.attacker)) {
        _id_A5A6(var_5._id_7C8C);
        continue;
      } else if(!isDefined(var_0))
        continue;
      else if(var_0 != var_5.attacker) {
        continue;
      }
    }

    if(var_5._id_3530) {
      if(!isDefined(var_1) || isnullweapon(var_1)) {
        continue;
      } else if(var_1 != var_5.objweapon) {
        continue;
      }
    }

    if(var_5._id_3520) {
      if(!isDefined(var_5.inflictor)) {
        _id_A5A6(var_5._id_7C8C);
        continue;
      } else if(!isDefined(var_2))
        continue;
      else if(var_2 != var_5.inflictor) {
        continue;
      }
    }

    if(var_5._id_352B) {
      if(!isDefined(var_3)) {
        continue;
      } else if(var_3 != var_5._id_9CD6) {
        continue;
      }
    }

    return 1;
  }

  return 0;
}

_id_A5A6(var_0) {
  if(!isDefined(self._id_7D20)) {
    return;
  }
  self._id_7D20[var_0] = undefined;
}

_id_A5A1(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_7D1F)) {
    self._id_7D1F = 0;
  }

  if(!isDefined(self._id_7D20)) {
    self._id_7D20 = [];
  }

  var_4 = self._id_7D1F;
  self._id_7D1F++;

  if(isDefined(var_1) && _func_0121(var_1)) {
    var_1 = makeweapon(var_1);
  }

  var_5 = spawnStruct();
  var_5._id_7C8C = var_4;
  var_5.attacker = var_0;
  var_5.objweapon = var_1;
  var_5.inflictor = var_2;
  var_5._id_9CD6 = var_3;
  var_5._id_34E2 = isDefined(var_0);
  var_5._id_3530 = isDefined(var_1) && !isnullweapon(var_1);
  var_5._id_3520 = isDefined(var_2);
  var_5._id_352B = isDefined(var_3);
  self._id_7D20[var_4] = var_5;
  return var_4;
}

_id_57E8(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_950E = var_0;
  var_2._id_43F7 = ::_id_A28A;
  var_2._id_5338 = "death";

  if(!isDefined(var_1) || !var_1) {
    var_2._id_84FB = _id_0744::_id_A284;
  }

  thread _id_0744::_id_7403(var_2);
}

_id_A28A(var_0) {
  if(!isDefined(var_0._id_90AD) || !isDefined(var_0._id_90AD._id_4850) || var_0._id_90AD._id_4850) {
    self notify("detonateExplosive");
  }
}

_id_99ED() {
  if(self.owner scripts\cp_mp\utility\player_utility::_isalive()) {
    self setotherent(self.owner);
    self.trigger = spawn("script_origin", self.origin + _id_6A23());
    self.trigger.owner = self;
    thread _id_558D(self.owner, 1);
  }
}

_id_558D(var_0, var_1) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger _id_0728::_id_D549(self.weapon_name);
  self.trigger scripts\cp\utility::_id_D6C2(var_0);
  self.trigger thread scripts\cp\utility::_id_A6C3(var_0);

  if(isDefined(var_1) && var_1) {
    thread _id_FD6F();
  }

  for(;;) {
    self.trigger waittill("trigger", var_0);
    var_0 notify("pickup_equipment", self.weapon_name);
    var_0 setweaponammostock(self.weapon_name, var_0 getweaponammostock(self.weapon_name) + 1);
    _id_476C();
    self notify("death");
  }
}

_id_FD6F() {
  self endon("death");

  for(;;) {
    if(isDefined(self) && isDefined(self.trigger)) {
      self.trigger.origin = self.origin + _id_6A23();

      if(isDefined(self._id_267F)) {
        self._id_267F.origin = self.origin;
      }
    } else
      return;

    wait 0.05;
  }
}

_id_476C(var_0) {
  if(isDefined(self)) {
    if(isDefined(self._id_476E)) {
      self thread[[self._id_476E]]();
      self notify("deleted_equipment");
    } else {
      var_1 = self getentitynumber();
      var_2 = self.killcament;
      var_3 = self.trigger;
      var_4 = self._id_D0C6;
      _id_3882(var_1, var_2, var_3, var_4);
      self notify("deleted_equipment");
      self delete();
    }
  }
}

_id_ABB6(var_0, var_1, var_2) {
  if(self._id_B1D0.size) {
    self._id_B1D0 = scripts\engine\utility::_id_1BD1(self._id_B1D0);

    if(self._id_B1D0.size >= level._id_9C90) {
      if(istrue(var_2)) {
        self._id_B1D0[0] notify("destroyExplosive");
      } else {
        self._id_B1D0[0] _id_476C();
      }
    }
  }

  self._id_B1D0[self._id_B1D0.size] = var_0;
  var_3 = var_0 getentitynumber();
  level._id_9EE2[var_3] = var_0;
  level notify("mine_planted");
}

_id_6B46(var_0) {
  var_1 = 0;
  var_1 = 4;
  return var_1;
}

_id_68A9() {
  var_0 = [];

  if(isDefined(self._id_B1CE)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self._id_B1CE);
  }

  if(isDefined(self._id_B1D0)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self._id_B1D0);
  }

  return var_0;
}

_id_5558(var_0) {
  var_1 = spawnfx(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  triggerfx(var_1);

  if(!isDefined(var_0) || var_0 == 0) {
    self playSound("sentry_explode");
  }

  var_1 thread scripts\cp\utility::_id_46C7(1);
}

_id_555A() {
  var_0 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), self.origin);
  triggerfx(var_0);
  self playSound("mp_killstreak_disappear");
  var_0 thread scripts\cp\utility::_id_46C7(1);
}

_id_A105(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  var_1 _id_476C();
}

_id_89C7(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return 0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return 0;
  }

  if(_func_0276(var_0) != "primary") {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "spread":
    case "mg":
    case "rifle":
    case "rocketlauncher":
    case "smg":
    case "sniper":
    case "pistol":
      return 1;
    default:
      return 0;
  }
}

_id_6A23() {
  var_0 = anglestoup(self.angles);
  return 10 * var_0;
}

_id_88F9(var_0) {
  var_1 = getweaponbasename(var_0);
  return issubstr(var_1, "knife");
}

_id_8607(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level._id_171B)) {
    if(scripts\engine\utility::array_contains(level._id_171B, var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_8795(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return 0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return 0;
  }

  if(scripts\cp\utility::_id_8A09(var_0) || _id_88F9(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_0241) && var_0._id_0241 == "model_only") {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "spread":
    case "mg":
    case "rifle":
    case "smg":
    case "sniper":
    case "pistol":
      return 1;
    default:
      return 0;
  }
}

_id_85C5(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "zombie_armageddon_mp":
    case "zfreeze_semtex_mp":
    case "splash_grenade_zm":
    case "splash_grenade_mp":
    case "throwingknifec4_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "c4_mp_p":
    case "frag_grenade_zm":
    case "semtex_mp":
      return 1;
    default:
      return 0;
  }
}

_id_855A(var_0, var_1, var_2, var_3, var_4, var_5) {
  return var_2 && var_3 && var_4 && !var_5 && isDefined(var_1._id_EAA5) && isDefined(var_1._id_EAA5._id_1DC0) && var_0 == var_1._id_EAA5._id_1DC0;
}

_id_85F5(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();

  if(var_1.classname == "weapon_pistol") {
    return 1;
  } else {
    return 0;
  }
}

get_num_random_attachments_by_weapon_level(var_0) {
  var_1 = scripts\cp\utility::_id_459B(var_0, 0);

  if(isDefined(level.pap_num_random_attachments[var_1])) {
    return level.pap_num_random_attachments[var_1];
  }

  return 0;
}

_id_683D(var_0) {
  if(!isPlayer(self)) {
    return int(1);
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(self._id_AE0A[var_1])) {
    return self._id_AE0A[var_1]._id_991E;
  }

  var_2 = scripts\cp\utility::_id_6CE3(var_1);

  if(isDefined(self._id_AE0A[var_2])) {
    return self._id_AE0A[var_2]._id_991E;
  }

  return int(1);
}

_id_3101(var_0, var_1) {
  if(!isDefined(level._id_AE0A)) {
    return 0;
  }

  if(isDefined(level._id_9C29)) {
    return [[level._id_9C29]](var_0, var_1);
  }

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::_id_6CE3(var_0);
  } else {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!isDefined(level._id_AE0A[var_2])) {
    var_3 = _func_00D6(var_2, 0, var_2.size - 1);

    if(!isDefined(level._id_AE0A[var_3])) {
      return 0;
    }
  }

  return 1;
}

_id_663A(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1)) {
    var_4 = 0;

    if(isDefined(var_0)) {
      var_4 = var_0 - 1;
    }

    if(isDefined(level._id_A524) && scripts\engine\utility::array_contains(level._id_A524, var_1)) {
      var_3 = undefined;
    } else if(isDefined(level._id_AE0B) && var_4 == 1) {
      var_3 = level._id_AE0B;
    } else if(isDefined(level._id_AE0C) && var_4 == 2) {
      var_3 = level._id_AE0C;
    } else if(isDefined(level._id_AE0D) && var_4 == 3) {
      var_3 = level._id_AE0D;
    }

    switch (var_1) {
      case "dischord":
        var_2 = "iw7_dischord_zm_pap1";
        var_3 = "camo20";
        break;
      case "facemelter":
        var_2 = "iw7_facemelter_zm_pap1";
        var_3 = "camo22";
        break;
      case "headcutter":
        var_2 = "iw7_headcutter_zm_pap1";
        var_3 = "camo21";
        break;
      case "forgefreeze":
        if(var_0 == 2) {
          var_2 = "iw7_forgefreeze_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_forgefreeze_zm_pap2";
        }

        var_5 = 1;
        break;
      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        var_5 = 1;
        break;
      case "shredder":
        var_2 = "iw7_shredder_zm_pap1";
        var_3 = "camo23";
        break;
    }
  }

  return var_3;
}

_id_FF38(var_0, var_1, var_2) {
  if(isDefined(level._id_10D23) && isDefined(level._id_10D23[getweaponbasename(var_2)])) {
    var_2 = level._id_10D23[getweaponbasename(var_2)];
  } else if(isDefined(var_1)) {
    switch (var_1) {
      case "two":
        if(var_0 == 2) {
          var_2 = "iw7_two_headed_axe_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_two_headed_axe_mp";
        }

        break;
      case "golf":
        if(var_0 == 2) {
          var_2 = "iw7_golf_club_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_golf_club_mp";
        }

        break;
      case "machete":
        if(var_0 == 2) {
          var_2 = "iw7_machete_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_machete_mp";
        }

        break;
      case "spiked":
        if(var_0 == 2) {
          var_2 = "iw7_spiked_bat_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_spiked_bat_mp";
        }

        break;
      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        break;
      case "katana":
        if(var_0 == 2) {
          var_2 = "iw7_katana_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_katana_zm_pap2";
        }

        break;
      case "nunchucks":
        if(var_0 == 2) {
          var_2 = "iw7_nunchucks_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_nunchucks_zm_pap2";
        }

        break;
      default:
        return var_2;
    }
  }

  return var_2;
}

_id_10BE2() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("melee_fired", var_0);
    var_1 = var_0.basename;

    if(self._id_9D91 == 0) {
      if(var_1 == "iw7_fists_zm_crane" || var_1 == "iw7_fists_zm_dragon" || var_1 == "iw7_fists_zm_snake" || var_1 == "iw7_fists_zm_tiger") {
        if(self._id_8E56 == 0) {
          self._id_8E56 = 1;
          thread _id_076F::_id_F72D("melee_punch", "zmb_comment_vo", "high", 1, 0, 0, 1);
          thread _id_8E57();
        } else {
          self._id_8E56 = 1;
          self notify("kung_fu_vo_reset");
          thread _id_076F::_id_F72D("melee_punch", "zmb_comment_vo", "high", 1, 0, 0, 1, 60);
          thread _id_8E57();
        }
      } else
        thread _id_076F::_id_F72D("melee_miss", "zmb_comment_vo", "high", 1, 0, 0, 1, 20);

      continue;
    }

    if(issubstr(var_1, "katana") && self._id_105F0 == "p5_") {
      thread _id_076F::_id_F72D("melee_special_katana", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if((issubstr(var_1, "golf") || issubstr(var_1, "machete") || issubstr(var_1, "spiked_bat") || issubstr(var_1, "two_headed_axe")) && self._id_9D91 == 1) {
      thread _id_076F::_id_F72D("melee_special", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if(issubstr(var_1, "iw7_knife") && scripts\cp\utility::_id_8632(var_1) && self._id_9D91 == 1) {
      thread _id_076F::_id_F72D("melee_fatal", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self._id_9D91 = 0;
      continue;
    }

    if((var_1 == "iw7_axe_zm" || var_1 == "iw7_axe_zm_pap1" || var_1 == "iw7_axe_zm_pap2") && scripts\cp\utility::_id_8632(var_1) && self._id_9D91 == 1) {
      thread _id_076F::_id_F72D("melee_splice", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self._id_9D91 = 0;
    }
  }
}

_id_8E57() {
  self endon("kung_fu_vo_reset");
  wait 4;
  self._id_8E56 = 0;
}

_id_10C2D() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponFired");
  self endon("watchWeaponFired");
  level endon("game_ended");

  for(;;) {
    wait 1;
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || isnullweapon(var_0)) {
      continue;
    }
    self waittill("fired", var_0);
    var_0 = self getcurrentweapon();
    var_1 = self _meth_8109(var_0);
    var_2 = weaponclipsize(var_0);

    if(var_2 == 0) {
      continue;
    }
    var_3 = var_1 / var_2;

    if(scripts\cp\utility::_id_8632(var_0) || issubstr(var_0.basename, "fists") || issubstr(var_0.basename, "heart")) {
      continue;
    }
    if(var_1 <= 5 && var_1 > 0 && self getweaponammostock(var_0) == 0 || self getweaponammostock(var_0) > 0 && var_1 / self getweaponammostock(var_0) < 0.1) {} else if(var_1 == 0 && (var_0.basename != "iw7_cpbasketball_mp" && !isnullweapon(var_0)))
      _id_076F::_id_F72D("nag_out_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);

    if(var_0.basename == "ac130_105mm_mp" || var_0.basename == "ac130_40mm_mp" || var_0.basename == "ac130_25mm_mp") {
      continue;
    }
  }
}

_id_6AD0() {
  var_0 = self.classname;
  var_1 = _func_00D6(var_0, 7);
  return var_1;
}

_id_10C2F() {
  self endon("death");
  var_0 = _id_6AD0();

  for(;;) {
    self waittill("trigger", var_1, var_2);
    var_3 = var_1 getcurrentweapon();
    var_1 thread _id_10BD0(var_0, var_3);
    var_1 notify("weapon_pickup", var_0);
    var_4 = _id_5BFC(var_1, var_0);

    if(isDefined(var_2) || var_4) {
      break;
    }
  }

  if(isDefined(var_2)) {
    var_1 notify("manual_switch_from_minigun");
    var_5 = var_2 _id_6AD0();
    var_6 = makeweaponfromstring(var_5);

    if(isDefined(var_1._id_F33C[var_5])) {
      var_2.owner = var_1._id_F33C[var_5];
      var_1._id_F33C[var_5] = undefined;
    }

    var_2.objweapon = var_6.basename;
    var_2._id_0481 = "dropped_weapon";
    var_2 thread _id_10C2F();
  }

  var_1._id_F33C[var_0] = self.owner;
}

_id_5BFC(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(isweapon(var_1)) {
    var_5 = getcompleteweaponname(var_1);
  } else {
    var_5 = var_1;
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7) {
      var_4 = 0;
    }
  }

  if(var_3) {
    var_0._id_034C = var_5;
    var_0.primaryweaponobj = makeweaponfromstring(var_5);
  } else if(var_4) {
    var_0._id_03B5 = var_5;
    var_0.secondaryweaponobj = makeweaponfromstring(var_5);
  }

  return var_3 || var_4;
}

_id_10BD0(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var_2 = self._id_0133;
  var_3 = 0;

  if(_func_0121(var_0)) {
    var_0 = makeweaponfromstring(var_0);
  }

  if(var_2 == var_0) {
    var_3 = 1;
  } else {
    for(;;) {
      waitframe();
      var_4 = self._id_0133;

      if(issameweapon(var_2, var_4, 0)) {
        continue;
      }
      if(issameweapon(var_0, var_4, 0)) {
        var_3 = 1;
      } else {
        var_3 = 0;
      }

      break;
    }
  }

  if(var_3) {
    if(var_0.basename == "s4_gw_flima35_mp") {}

    thread _id_A6B8();
    self notify("finish_pickup_of_weapon", var_0, var_1);
  }
}

_id_A6B8() {
  self setclientomnvar("ui_weapon_pickup", 0);
}

_id_10C32(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("watchWeaponUsage");
  self endon("watchWeaponUsage");

  for(;;) {
    self waittill("weapon_fired", var_1);
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2) || isnullweapon(var_2)) {
      continue;
    }
    if(!scripts\cp\utility::_id_88D7(var_2)) {
      continue;
    }
    if(isDefined(level._id_FCDD)) {
      thread[[level._id_FCDD]](self, getcompleteweaponname(var_2));
    }

    var_3 = gettime();

    if(!isDefined(self._id_9042)) {
      self._id_9042 = 0;
    }

    var_4 = gettime() - self._id_9042;
    self._id_9042 = var_3;

    if(isai(self)) {
      continue;
    }
    var_5 = getweaponbasename(var_2);

    if(!isDefined(self._id_DA68[var_5])) {
      self._id_DA68[var_5] = 1;
    } else {
      self._id_DA68[var_5]++;
    }

    if(!isDefined(self._id_0E5D)) {
      self._id_0E5D = 1;
    } else {
      self._id_0E5D++;
    }

    _id_074E::_id_7DE1(self);
    scripts\cp\cp_playerstats::_id_7DF5(self, var_2, "uses", 1);

    if(isDefined(var_5)) {
      if(isDefined(self._id_79BD[var_5])) {
        thread _id_79BF(var_5, var_2);
      }
    }
  }
}

_id_79BF(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 = var_1.basename;
  self endon("updateMagShots_" + var_0);
  self._id_79BD[var_0]--;

  if(var_1.type == "projectile") {
    wait 1;
  } else {
    wait 0.1;
  }

  self notify("shot_missed", var_1);
  self._id_3B88[var_0] = 0;
  self._id_79BD[var_0] = weaponclipsize(var_1);
}

_id_10C2B() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponChange");
  self endon("watchWeaponChange");
  self._id_79BD = [];
  var_0 = getweaponbasename(self getcurrentweapon());
  _id_79BE(var_0);

  for(;;) {
    self waittill("weapon_change", var_1);
    var_0 = var_1.basename;
    _id_10DE5(var_0);

    if(isDefined(self._id_10D0F[var_1.basename])) {} else {}

    _id_79BE(var_0);
  }
}

_id_74CB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!issubstr(var_0, "harpoon")) {
    return;
  } else {
    var_2 startragdoll();
    var_8 = physics_createcontents(["physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle"]);
    var_9 = var_3 + var_4 * 4096;
    var_10 = scripts\engine\trace::_id_C051(var_3, var_9, undefined, var_8, undefined, 1);
    var_9 = var_10["position"] - var_4 * 12;
    var_11 = length(var_9 - var_3);
    var_12 = var_11 / 1250;
    var_12 = clamp(var_12, 0.05, 1);
    wait 0.05;
    var_13 = var_4;
    var_14 = anglestoup(var_1.angles);
    var_15 = _func_025B(var_13, var_14);
    var_16 = scripts\engine\utility::spawn_tag_origin(var_3, _func_0017(var_13, var_15, var_14));
    var_16 moveto(var_9, var_12);
    var_17 = _func_0212(var_2, var_5, var_6, var_7);
    var_17.origin = var_16.origin;
    var_17.angles = var_16.angles;
    var_17 linkto(var_16);
    thread _id_B227(var_9, var_1);
    thread _id_7D5C(var_2, var_16, var_12 + 0.05, var_17);
  }
}

_id_7D5C(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::_id_108A8(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

_id_B227(var_0, var_1) {
  wait 2;
  var_1 radiusdamage(var_0, 500, 1000, 500, var_1, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], var_0);
}

_id_CF36() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(issubstr(var_0.basename, "harpoon1")) {
      thread _id_74CC();
      continue;
    }

    continue;
  }
}

_id_74CC() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");
  self._id_F58B = [];

  for(var_0 = 1; var_0 <= 5; var_0++) {
    self._id_F58B[var_0] = undefined;
  }

  for(;;) {
    self waittill("ads_in");
    self waittill("ads_out");
    var_1 = self getplayerangles();
    var_2 = self getEye();
    var_3 = anglesToForward(var_1);
    var_4 = var_2 + var_3 * 2048;
    var_5 = scripts\engine\trace::_id_3EE5(1, 1, 0, 0, 0, 0, 0);
    var_6 = _func_02C1(var_2, var_4, var_5, self, 0, "physicsquery_closest");
    var_7 = var_6[0]["position"];

    if(isDefined(var_7)) {
      if(isDefined(self._id_1101F)) {
        if(self._id_1101F <= 5) {
          thread _id_3F7C(self._id_1101F, self, var_7);
        }

        self._id_1101F++;
      } else {
        self._id_1101F = 1;
        thread _id_3F7C(self._id_1101F, self, var_7);
      }

      thread _id_340C(var_7);
    }

    wait 0.8;
  }
}

_id_340C(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_1 = gettime();

  while(gettime() <= var_1 + 7000) {
    waitframe();

    if(self getcurrentweaponclipammo() <= 1) {
      continue;
    }
    if(isDefined(self._id_1101F)) {
      if(self._id_1101F > 5) {
        foreach(var_3 in self._id_F58B) {
          if(isDefined(var_3)) {
            var_3 delete();
          }
        }

        self radiusdamage(var_0, 100, 1000, 100, self, "MOD_EXPLOSIVE");
        playFX(level._effect["penetration_railgun_explosion"], var_0);
        self._id_1101F = 0;
      }
    }
  }

  foreach(var_3 in self._id_F58B) {
    if(isDefined(var_3)) {
      self radiusdamage(var_3.origin, 100, 1000, 100, self, "MOD_EXPLOSIVE");
      playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      var_3 delete();
    }
  }
}

_id_3F7C(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_3 = 0;

  switch (var_0) {
    case 0:
      self._id_1101F = 1;
    case 1:
      foreach(var_5 in self._id_F58B) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_5 delete();
          }
        }
      }

      var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      break;
    case 2:
      foreach(var_5 in self._id_F58B) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 55, 25);
            var_3 = 1;
          }

          if(isDefined(var_1._id_F58B[var_0]) && var_5 != var_1._id_F58B[var_0]) {
            var_5 delete();
          }
        }
      }

      if(!var_3) {
        var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      }

      break;
    case 3:
      foreach(var_5 in self._id_F58B) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 60, 25);
            var_3 = 1;
          }

          if(isDefined(var_1._id_F58B[var_0]) && var_5 != var_1._id_F58B[var_0]) {
            var_5 delete();
          }
        }
      }

      if(!var_3) {
        var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      }

      break;
    case 4:
      foreach(var_5 in self._id_F58B) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 65, 25);
            var_3 = 1;
          }

          if(isDefined(var_1._id_F58B[var_0]) && var_5 != var_1._id_F58B[var_0]) {
            var_5 delete();
          }
        }
      }

      if(!var_3) {
        var_1._id_F58B[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      }

      break;
    case 5:
      foreach(var_5 in self._id_F58B) {
        if(isDefined(var_5)) {
          var_1 radiusdamage(var_5.origin, 100, 1000, 100, var_1, "MOD_EXPLOSIVE");
          playFX(level._effect["penetration_railgun_explosion"], var_5.origin);
          var_5 delete();
        }
      }

      break;
    default:
      break;
  }

  if(isDefined(var_1._id_F58B[var_0])) {
    var_1._id_F58B[var_0] setModel("prop_mp_super_blackholegun_projectile");
    var_1._id_F58B[var_0] thread _id_4BEE(var_1._id_F58B[var_0], var_1);
  }
}

_id_4BEE(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = 0;

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(isDefined(var_3._id_1210) && var_3._id_1210 == "generic_zombie" && !isDefined(var_3._id_5D22)) {
      var_1 radiusdamage(var_3.origin, 100, 1000, 100, var_1, "MOD_EXPLOSIVE");
      playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      var_2++;

      if(var_2 >= 5) {
        foreach(var_5 in self._id_F58B) {
          if(isDefined(var_5)) {
            var_5 delete();
          }
        }

        self._id_1101F = 0;
        var_1 radiusdamage(var_3.origin, 100, 1000, 100, var_1, "MOD_EXPLOSIVE");
        playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      }
    }
  }
}

_id_10DE5(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }
  if(!isDefined(self._id_DA68[var_0])) {
    self._id_DA68[var_0] = 0;
  }

  if(!isDefined(self._id_DA6C[var_0])) {
    self._id_DA6C[var_0] = 0;
  }

  if(!isDefined(self._id_761D[var_0])) {
    self._id_761D[var_0] = 0;
  }

  if(!isDefined(self._id_10CB8[var_0])) {
    self._id_10CB8[var_0] = 1;
  }

  if(!isDefined(self._id_4EB5[var_0])) {
    self._id_4EB5[var_0] = 0;
  }

  if(!isDefined(self._id_8DA4[var_0])) {
    self._id_8DA4[var_0] = 0;
  }
}

_id_79BE(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }
  if(scripts\cp\utility::_id_88D7(var_0) && !isDefined(self._id_79BD[var_0])) {
    self._id_79BD[var_0] = weaponclipsize(var_0);
  }
}

addattachmenttoweapon(var_0, var_1, var_2) {
  var_3 = self._id_0133;
  var_4 = var_3;
  var_0 = undefined;
  var_5 = scripts\cp\utility::_id_1DA9(var_1, var_4);
  var_6 = 0;

  if(var_3._id_0070.size == 0) {
    if(var_4 _meth_8629(var_5)) {
      var_6 = 1;
    } else {
      var_6 = 0;
    }
  } else {
    for(var_7 = 0; var_7 < var_3._id_0070.size; var_7++) {
      if(var_4 _meth_8629(var_5) && _id_1DB2(var_3._id_0070[var_7], var_5, var_4) == "") {
        var_6 = 1;
        continue;
      }

      var_6 = 0;
      break;
    }
  }

  if(var_6) {
    var_0 = var_4 _meth_8669(var_5);
  }

  if(!isDefined(var_0)) {
    if(!isbot(self)) {}

    return undefined;
  }

  var_8 = self getweaponammoclip(var_0);
  var_9 = self getweaponammostock(var_0);

  if(istrue(var_2)) {
    var_8 = weaponclipsize(var_0);
    var_9 = weaponmaxammo(var_0);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
  self giveweapon(var_0);
  self setweaponammoclip(var_0, var_8);
  self setweaponammostock(var_0, var_9);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
  _id_5BFC(self, var_0);
  return var_0;
}

_id_B4CB(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self getcurrentweapon();
  }

  return var_0 _meth_8624("silenc", 1);
}

_id_10DDC(var_0) {
  switch (var_0) {
    case "s4_mg_streak_mp":
    case "s4_mg_juniform_mp":
    case "iw8_fists_mp":
    case "s4_gw_flima35_mp":
    case "s4_me_knife_mp":
    case "s4_me_rindigo_mp":
      return 0;
  }

  if(scripts\cp\utility::_id_88F6(var_0)) {
    return 0;
  }

  var_1 = weaponclass(var_0);
  return var_1 == "rifle" || var_1 == "mg" || var_1 == "sniper" || var_1 == "smg" || var_1 == "spread";
}

_id_3509(var_0, var_1) {
  var_2 = makeweapon(var_1);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_2 _meth_8629(var_5)) {
      var_3[var_3.size] = var_5;
      continue;
    }

    thread _id_84F8(var_5, var_1);
  }

  return var_3;
}

_id_84F8(var_0, var_1) {
  var_2 = "Invalid Attachment: " + var_0 + " on " + var_1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("#x3decf448ab3afab5f", 0) == 1) {
      self iprintlnbold(var_2);
    } else {}
  }

  if(!isDefined(level.soak_testing)) {
    return;
  }
}

_id_4C80(var_0, var_1, var_2) {
  var_3 = [];

  if(istrue(var_2)) {
    var_3 = var_0._id_030D;
  } else {
    var_3 = var_0._id_0070;
  }

  if(_id_7540(var_3, var_1)) {
    return 1;
  } else {
    return 0;
  }
}

_id_7540(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(scripts\cp\utility::_id_1DA5(var_3) == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_75A9(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\cp\utility::_id_68E5(var_2) == "rail") {
      return 1;
    }
  }

  return 0;
}

_id_6CF2(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = int(_func_0222("mp/reticleTable.csv", 1, var_0, 5));

  if(!isDefined(var_1) || var_1 == 0) {
    return undefined;
  }

  return var_1;
}

_id_2D1F(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 < 0) {
    var_2 = undefined;
  }

  var_1 = scripts\cp\utility::_id_10D65(var_1);
  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  var_3 = scripts\cp\utility::_id_10D61(var_0);
  var_4 = scripts\cp\utility::_id_2D16(var_0, var_2);
  var_5 = var_1;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_5[var_6] = ::scripts\cp\utility::_id_1DA5(var_5[var_6]);
  }

  if(isDefined(var_3)) {
    var_7 = var_3;

    for(var_6 = 0; var_6 < var_7.size; var_6++) {
      var_7[var_6] = ::scripts\cp\utility::_id_1DA5(var_7[var_6]);
    }

    var_5 = scripts\engine\utility::_id_1B9D(var_7, var_5);
  }

  var_8 = [];

  if(var_5.size > 0) {
    var_5 = scripts\cp\utility::_id_5A44(var_5, var_0);

    for(var_9 = 0; var_9 < var_5.size; var_9++) {
      var_8[var_9] = ::scripts\cp\utility::_id_1DA9(var_5[var_9], var_4);
    }
  }

  var_10 = [];

  foreach(var_12 in var_8) {
    var_13 = scripts\cp\utility::_id_1DA8(var_12);

    if(isDefined(var_13)) {
      var_10[var_10.size] = ::scripts\cp\utility::_id_1DA9(var_13, var_4);
    }
  }

  if(var_10.size > 0) {
    var_8 = scripts\engine\utility::_id_1B9D(var_8, var_10);
  }

  if(isDefined(var_2)) {
    var_15 = scripts\cp\utility::_id_6E92(var_4, var_2);

    foreach(var_17 in var_15) {
      var_8[var_8.size] = var_17;
    }
  }

  var_19 = undefined;
  return var_8;
}

_id_19D3(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isDefined(var_0._id_FF18)) {
    return 0;
  }

  if(isDefined(var_0.vehicle)) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(scripts\cp\utility::_id_85D9(var_0, var_1) && var_0 != var_1) {
    return 0;
  }

  var_4 = distance(var_2, var_0.origin);
  var_5 = 0;

  if(var_1 == var_0) {
    if(var_4 > 384) {
      return 0;
    } else {
      var_5 = 1;
    }
  }

  var_6 = 0;
  var_7 = 0;

  if(var_4 >= 512 || !scripts\engine\utility::_id_10E76(var_1.origin, var_1 getplayerangles(), var_2, 0.5)) {
    var_6 = 3;
    var_7 = 0.25;
  } else if(var_4 <= 256) {
    var_6 = 5;
    var_7 = 0.75;
  } else {
    var_8 = 1 - (var_4 - 256) / 256;
    var_6 = 3 + var_8 * 2;
    var_7 = 0.25 + var_8 * 0.5;
  }

  if(var_3) {
    var_0 = var_1;
    var_6 = max(3, var_6 * 0.75);
    var_7 = max(0.25, var_7 * 0.75);
  } else if(var_5) {
    var_6 = max(3, var_6 * 0.75);
    var_7 = max(0.25, var_7 * 0.75);
  }

  if(isPlayer(var_0)) {
    var_0 shellshock("flashbang_mp", var_6);
    var_0._id_5CA2 = gettime() + var_6 * 1000;
    var_0 thread _id_5CD7(var_7);
  } else if(var_0 scripts\cp\utility::_id_872B() || var_0._id_1210 == "soldier_agent" || var_0._id_04B9 == "soldier")
    _id_EAAA(var_2, var_1);
  else {
    var_0 shellshock("flashbang_mp", var_6);
    var_0._id_5CA2 = gettime() + var_6 * 1000;
    var_0 thread _id_5CD7(var_7);
  }

  return 1;
}

_id_8863(var_0, var_1) {
  return var_0.basename == "flash_grenade_mp" && var_1 != "MOD_IMPACT";
}

_id_5CD7(var_0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

_id_6F95(var_0) {
  switch (var_0) {
    case "molotov":
      self._id_8F79 = self getcurrentweapon();
      self giveweapon("iw8_molotov_zm");
      self switchtoweapon("iw8_molotov_zm");
      break;
    case "breach_charge":
      self._id_8F79 = self getcurrentweapon();
      self giveweapon("c4_mp_p");
      self switchtoweapon("c4_mp_p");
      break;
  }
}

_id_10A40() {
  for(;;) {
    level waittill("ai_weapon_dropped");
    var_0 = _func_00E8();

    foreach(var_2 in var_0) {
      var_2 _meth_83A1(1, 1);
    }
  }
}

_id_4FFD(var_0, var_1) {
  var_2 = var_0.basename;

  if(scripts\engine\utility::array_contains(level._id_84F2, var_2)) {
    return;
  }
  var_3 = var_0._id_0070;
  var_4 = getDvar("#x344bf87bfeb941f95", "");

  if(var_4 != "") {
    var_3 = scripts\engine\utility::array_add(var_3, var_4);
  }

  if(_id_B4C9()) {
    var_5 = 1;
  } else {
    var_5 = undefined;
  }

  var_6 = _id_E1EA(var_2, var_3, self.origin + (0, 0, 32), self.angles, var_5);

  if(!isDefined(var_6)) {
    return;
  }
  scripts\cp_mp\utility\weapon_utility::_id_5076(var_6);

  if(!isDefined(var_6)) {
    return;
  }
  var_6 _id_FB60();
  var_7 = _func_00D6(var_6.classname, 7, var_6.classname.size);
  var_6 scripts\anim\shared::_id_D6BE(var_7, self);
  var_6 thread _id_4755();
  var_6 thread _id_10C2F();
}

_id_B4C9() {
  if(level.script == "cp_so_estate") {
    return 1;
  }

  return 0;
}

_id_4755() {
  level endon("game_ended");
  self endon("death");
  self endon("entitydeleted");
  wait 30;
  _id_C3E2(self);
  self delete();
}

_id_FB60() {
  self _meth_83A1(1, 1);
  self setuserange(72);
}

_id_81EE() {
  if(level.gametype == "cp_pvpve") {
    return;
  }
  if(isDefined(level._id_4220)) {
    var_0 = level._id_4220;
  } else {
    var_0 = ["iw8_ar_falpha", "iw8_sm_papa90", "iw8_sm_augolf", "iw8_lm_pkilo", "iw8_sn_alpha50", "iw8_pi_mike1911", "iw8_ar_mike4", "iw8_ar_akilo47", "iw8_sm_mpapa5", "iw8_sh_dpapa12", "iw8_lm_kilo121", "iw8_sn_mike14", "iw8_sn_kilo98", "iw8_pi_golf21", "iw8_sn_crossbow"];
  }

  var_1 = scripts\engine\utility::getStructArray("weapon_pickup", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_CE18)) {
      var_4 = _id_6980(var_3._id_CE18 + "_mp");
      var_5 = spawn("weapon_" + var_4, var_3.origin);
      var_5 _meth_81F6(weaponclipsize(var_4), weaponmaxammo(var_4));
      var_5 thread _id_10C2F();
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  var_7 = [];
  var_8 = [];

  foreach(var_14, var_10 in level._id_10DB0) {
    foreach(var_4 in var_0) {
      if(var_14 == var_4) {
        var_12 = strtok(var_14, "_");

        if(var_12[0] == "iw8") {
          var_7[var_7.size] = var_14;
          level._id_1D9E[var_14] = _id_BE15(var_14);
        }
      }
    }
  }

  var_7 = _id_5145(var_7);
  var_15 = 0;
  var_16 = 0;

  for(var_17 = var_1.size; var_16 < var_17; var_16++) {
    var_15 = randomintrange(0, var_7.size);
    var_18 = _id_1DAF(var_7[var_15]);

    foreach(var_20 in var_18) {
      foreach(var_22 in var_18) {
        if(var_20 == var_22) {
          continue;
        }
        if(!_id_1DB1(var_20, var_22)) {
          var_18 = scripts\engine\utility::array_remove(var_18, var_22);
        }
      }
    }

    var_4 = _id_6980(var_7[var_15]);
    var_5 = spawn("weapon_" + var_4, var_1[var_16].origin);

    if(isDefined(var_1[var_16].angles)) {
      var_5.angles = var_1[var_16].angles;
    } else {
      var_5.angles = (0, 0, 0);
    }

    var_5 _meth_81F6(weaponclipsize(var_4), weaponmaxammo(var_4));
    var_5 thread _id_10C2F();
  }
}

_id_1DAF(var_0) {
  var_1 = [];

  if(isDefined(level._id_1D9E[var_0])) {
    var_2 = scripts\engine\utility::array_randomize(level._id_1D9E[var_0]);
    var_3 = _id_1DB0();

    for(var_4 = 0; var_4 < var_3 && var_4 < var_2.size; var_4++) {
      var_1[var_1.size] = var_2[var_4];
    }
  }

  return var_1;
}

_id_1DB0() {
  var_0 = randomint(100);

  if(var_0 < 50) {
    return 0;
  } else if(var_0 < 80) {
    return 1;
  } else if(var_0 < 95) {
    return 2;
  } else if(var_0 < 100) {
    return 3;
  }

  return 0;
}

_id_BE15(var_0) {
  foreach(var_3, var_2 in level._id_1DA2) {
    if(var_0 == var_3) {
      return _id_C791(var_2, var_0);
    }
  }
}

_id_C791(var_0, var_1) {
  foreach(var_4, var_3 in level._id_10DB0) {
    if(var_1 == var_4) {
      if(scripts\engine\utility::array_contains(var_0, "doubletap")) {
        var_0 = scripts\engine\utility::array_remove(var_0, "doubletap");
      }

      if(scripts\engine\utility::array_contains(var_0, "reconsilencer_cp")) {
        var_0 = scripts\engine\utility::array_remove(var_0, "reconsilencer_cp");
      }

      if(isDefined(var_3._id_1D7A)) {
        return scripts\engine\utility::_id_1BBF(var_0, var_3._id_1D7A);
      }
    }
  }
}

_id_5145(var_0) {
  var_1 = ["iw8_knife", "iw8_fists", "iw8_knifestab", "none", "speciality_null", "iw8_ar_dummycp", "iw8_ar_dummycs", "iw8_me_riotshield"];
  var_2 = [];

  if(_func_02DE(scripts\engine\utility::random(var_0))) {
    foreach(var_5, var_4 in var_0) {
      if(!scripts\engine\utility::array_contains(var_1, var_5)) {
        var_2[var_5] = var_4;
      }
    }

    return var_2;
  }

  return scripts\engine\utility::_id_1BBF(var_0, var_1);
}

_id_361C() {
  for(;;) {
    var_0 = scripts\engine\utility::random(level._id_9897);

    foreach(var_3, var_2 in level._id_3E1E) {
      if(var_0.name == var_3) {
        return var_0;
      } else {
        continue;
      }
    }

    waitframe();
  }
}

_id_99EC() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

_id_8985(var_0) {
  return isDefined(level._id_9EE2[var_0 getentitynumber()]) || istrue(var_0._id_B1C9);
}

_id_1D20(var_0, var_1) {
  var_2 = _id_361C();

  if(isDefined(var_2._id_1DAE)) {
    return makeweapon(var_0, [var_2._id_1DAE]);
  } else {
    var_3 = scripts\cp\utility::getweaponrootname(var_0);
    var_4 = makeweapon(var_0);
    var_1._id_10D0F[var_3] = var_2;
    return var_4;
  }
}

_id_7169() {
  return !isnullweapon(self getheldoffhand());
}

_id_6A79() {
  var_0 = self getheldoffhand();

  if(isDefined(self._id_62F1) && var_0 == makeweaponfromstring(self._id_62F1)) {
    var_0 = _func_0375();
  }

  return var_0;
}

_id_7168(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0._id_10D0C)) {
    var_0._id_10D0C = var_1;
  }

  if(!isDefined(var_0.weapon_name)) {
    var_0.weapon_name = var_1.basename;
  }

  if(!isDefined(var_0.owner)) {
    var_0.owner = self;
  }

  if(!isDefined(var_0.team)) {
    var_0.team = self.team;
  }

  if(!isDefined(var_0._id_F1DF)) {
    var_0._id_F1DF = var_2;
  }

  if(!isDefined(var_0._id_F1E0) && isDefined(var_0._id_F1DF)) {
    var_0._id_F1E0 = scripts\common\utility::_id_C94D(4 * var_2);
  }

  var_4 = _id_0728::_id_6A14(var_1);

  if(isDefined(var_4)) {
    var_5 = _id_0728::_id_6A17(var_4);
    var_0._id_5562 = var_4;
    var_0._id_8835 = 1;
    var_0.isquestitem = var_5.isquestitem;
  }

  var_0._id_F170 = isDefined(var_3);
}

_id_158E(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("firstRaiseAnims", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    setsaveddvar("#x3eae70921f59648b0", 0);
  } else if(isDefined(var_2) && !var_2) {
    setsaveddvar("#x3eae70921f59648b0", 1);
  }
}

_id_FCA0() {
  self endon("disconnect");
  self endon("faux_spawn");
  self._id_9021 = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_90CB = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_8FC2 = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_8F9F = scripts\engine\utility::ter_op(isDefined(self._id_E3A8) && _id_8799(self._id_E3A8), self._id_E3A8, _func_0375());

  for(;;) {
    self waittill("weapon_change", var_0);
    self._id_90CB = var_0;

    if(_id_894F(var_0)) {
      self._id_9021 = var_0;
    }

    if(_id_8813(var_0)) {
      self._id_8FC2 = var_0;
    }

    if(_id_8799(var_0)) {
      self._id_8F9F = var_0;
    }
  }
}

_id_894F(var_0) {
  if(var_0.basename == "none") {
    return 0;
  }

  if(var_0.classname == "turret") {
    return 0;
  }

  if(scripts\cp\utility::_id_8A7D(var_0.basename)) {
    return 0;
  }

  if(scripts\cp\utility::_id_88F6(var_0.basename)) {
    return 0;
  }

  if(var_0._id_0241 != "primary" && var_0._id_0241 != "altmode") {
    return 0;
  }

  return 1;
}

_id_879A(var_0) {
  switch (getweapongroup(var_0)) {
    case "weapon_melee":
    case "weapon_shotgun":
    case "weapon_assault":
    case "weapon_smg":
    case "weapon_dmr":
    case "weapon_lmg":
    case "weapon_sniper":
      return 1;
    default:
      return 0;
  }
}

getweapongroup(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return "other";
  }

  if(_func_0121(var_0) && (var_0 == "none" || var_0 == "alt_none")) {
    return "other";
  }

  var_1 = scripts\cp\utility::getweaponrootname(var_0);
  var_2 = scripts\cp\utility::_id_10D99(var_1);

  if(!isDefined(var_2)) {
    if(scripts\cp\utility::_id_8A7D(var_0)) {
      var_2 = "super";
    } else if(scripts\cp\utility::_id_8834(var_0)) {
      var_2 = "weapon_mg";
    } else if(scripts\cp\utility::_id_88F6(var_0)) {
      var_2 = "killstreak";
    } else {
      var_2 = "other";
    }
  }

  return var_2;
}

_id_879C(var_0) {
  switch (getweapongroup(var_0)) {
    case "weapon_melee2":
    case "weapon_rail":
    case "weapon_beam":
    case "weapon_machine_pistol":
    case "weapon_projectile":
    case "weapon_pistol":
      return 1;
    default:
      return 0;
  }
}

_id_8799(var_0) {
  return _id_879A(var_0) || _id_879C(var_0);
}

_id_8798(var_0) {
  return getweapongroup(var_0) == "weapon_melee";
}

_id_8813(var_0) {
  if(var_0.basename == "none") {
    return 0;
  }

  if(_id_885E(var_0.basename)) {
    return 0;
  }

  if(isDefined(self) && istrue(self.inlaststand)) {
    return 0;
  }

  if(scripts\cp\utility::_id_88F6(var_0.basename)) {
    return 0;
  }

  if(scripts\cp\utility::_id_8A7D(var_0.basename)) {
    return 0;
  }

  if(var_0._id_0241 != "primary") {
    return 0;
  }

  if(var_0.classname == "turret") {
    return 0;
  }

  if(!_id_879A(var_0.basename) && !_id_879C(var_0.basename)) {
    return 0;
  }

  return 1;
}

_id_725A() {
  var_0 = getDvar("#x38a01ffd5d4ede161");

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      _id_725B(var_2, var_0);
    }
  }
}

_id_725B(var_0, var_1) {
  var_2 = var_0._id_0133;
  var_0 dropitem(var_2);
  var_2 = var_2 _meth_8628();
  var_3 = scripts\cp\utility::_id_6E69(var_2);
  var_4 = 0;

  if(scripts\engine\utility::array_contains(var_3, var_1)) {
    var_4 = 1;
  } else {
    var_5 = scripts\cp\utility::_id_1DA9(var_1, var_2);

    if(!var_2 _meth_8629(var_5)) {
      if(!isbot(var_0)) {
        var_0 iprintlnbold("Invalid attachment for this weapon: " + var_5);
      }

      var_4 = 1;
    }
  }

  if(var_4) {
    var_0 giveweapon(var_2);
    return;
  }

  var_6 = var_3;
  var_6[var_6.size] = var_1;
  var_7 = scripts\cp\utility::getweaponrootname(var_2.basename);
  var_8 = _id_2D1F(var_7, var_6, -1);

  if(isDefined(var_2._id_0070)) {
    foreach(var_10 in var_2._id_0070) {
      var_2 = var_2 _meth_866A(var_10);
    }
  }

  foreach(var_13 in var_8) {
    var_2 = var_2 _meth_8669(var_13);
  }

  var_15 = getweaponattachments(var_2);

  if(var_15.size > 12) {
    var_0 iprintlnbold("Player / Bot already has 12 attachments: " + getcompleteweaponname(var_2));
    return;
  }

  var_0 giveweapon(var_2);
  var_0 setweaponammoclip(var_2, weaponclipsize(var_2));
  var_0 setweaponammostock(var_2, weaponmaxammo(var_2));
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_2);
  _id_5BFC(var_0, var_2);
}

_id_10B77() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_10BD9();
  }
}

_id_10BD9() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "debug_attach_select") {
      var_2 = _func_0222("mp/attachmenttable.csv", 0, var_1, 4);
      _id_725B(self, var_2);
    }
  }
}

_id_3F93() {
  var_0 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = strtok(var_0[var_1]._id_039B, "+");
    var_3 = var_2[0];
    var_4 = [];

    if(var_2.size > 1) {
      var_5 = strtok(var_2[1], " ");

      for(var_6 = 0; var_6 < var_5.size; var_6++) {
        var_4[var_4.size] = var_5[var_6];
      }
    }

    var_3 = _id_E1EA(var_3, var_4, var_0[var_1].origin, var_0[var_1].angles);
  }
}

_id_E1EA(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  var_5 = undefined;

  if(getdvarint("#x330ca3528c9a76219", 0) != 0) {
    var_5 = _id_2D21(var_0, var_1);
  } else {
    var_5 = buildweapon(var_0, var_1, "none", "none", -1, undefined, undefined, undefined, var_4);
  }

  var_6 = getcompleteweaponname(var_5);
  var_7 = spawn("weapon_" + var_6, var_2);

  if(isDefined(var_7)) {
    if(scripts\cp\utility::_id_871A()) {
      var_7 _meth_81F6(weaponclipsize(var_7), 0);
    } else {
      var_7 _meth_81F6(weaponclipsize(var_7), weaponclipsize(var_7));
    }

    var_7.angles = var_3;
    _id_1062(var_7);
    var_7 thread scripts\engine\utility::_id_F126("death", ::_id_C3E2);
  }

  return var_7;
}

_id_1062(var_0) {
  level._id_5045[level._id_5045.size] = var_0;
}

_id_C3E2(var_0) {
  if(isDefined(var_0)) {
    if(scripts\engine\utility::array_contains(level._id_5045, var_0)) {
      level._id_5045 = scripts\engine\utility::array_remove(level._id_5045, var_0);
    }
  }
}

_id_DE51(var_0) {
  thread scripts\cp\utility::_id_A695("death", "end_explode");
  self endon("end_explode");
  var_1 = self.owner.name;

  if(istrue(var_0)) {
    self waittill("missile_stuck", var_6, var_2, var_3, var_4, var_5, var_7);
    thread _id_DE4D(var_6);
  } else
    self waittill("explode", var_6);

  level notify("smoke_grenade_explosion", var_6, 330, 9.25, 1);

  foreach(var_9 in _func_0070("axis")) {
    var_9 childthread _id_06C0::_id_12CF("getdown");
  }

  thread _id_DE4E(var_6, var_1);

  if(isDefined(self.owner)) {
    self.owner thread _id_A13E();
  }
}

_id_DE4E(var_0, var_1) {
  wait 1;
  var_2 = scripts\cp\cp_outline_utility::_id_110A(var_0, 330);
  var_3 = spawn("script_model", var_0);
  var_3 show();
  var_4 = getent("smoke_grenade_sight_clip_256", "targetname");

  if(isDefined(var_4)) {
    level notify("grenade_exploded_during_stealth", var_3, "smoke_grenade_mp", var_1);
    var_3 clonebrushmodeltoscriptmodel(var_4);
    var_3 _meth_8731();
  } else
    var_3 delete();

  wait 8.25;

  if(isDefined(var_3)) {
    var_3 delete();
  }

  scripts\cp\cp_outline_utility::_id_C4FA(var_2);
}

_id_DE4D(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("glsmoke"), var_0, anglestoup((0, 90, 0)));
}

_id_A13E() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\cp\utility::_id_BD15("smoke grenade activated", self);
  self._id_7533 = 1;
  var_0 = scripts\engine\utility::_id_108A7(9.25, "death");
  self._id_7533 = 0;
  scripts\cp\utility::_id_BD15("smoke grenade deactivated", self);
}

_id_2D21(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = scripts\cp\utility::getweaponrootname(var_0);

  if(!isai(self)) {
    return;
  }
  return _id_6E5C(var_10, weaponclass(var_0));
}

_id_6E5C(var_0, var_1) {
  var_2 = [];

  if(_func_0107(var_0)) {
    var_2 = var_0;
    var_0 = var_0[randomint(var_0.size)];
  } else
    var_2 = [var_0];

  if(var_0 == "s4_gw_flima35_mp") {}

  if(1) {
    return _id_6E5D(var_1, var_0, var_2);
  }

  if(issubstr(tolower(self.classname), "_alq_")) {
    return _id_6E5D(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_rus_desert_")) {
    return _id_6E60(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_spetsnaz_")) {
    return _id_6E60(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_hero_")) {
    return _id_6E5E(var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_villain_")) {
    return _id_6E5E(var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_sas_")) {
    return _id_6E63(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_reb_")) {
    return _id_6E5F(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_so15_")) {
    return _id_6E64(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_london_police_")) {
    return _id_6E64(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_usmc_")) {
    return _id_6E65(var_1, var_0, var_2);
  } else {
    return buildweapon(var_0);
  }

  return var_0;
}

_id_6E5E(var_0, var_1) {
  if(issubstr(tolower(self.classname), "_hero_alex")) {
    switch (var_0) {
      case "iw8_pi_mike1911":
        return _id_99D8("alex_pistol");
      case "iw8_sn_mike14":
        return _id_99D8("alex_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_hadir")) {
    switch (var_0) {
      case "iw8_sm_augolf":
        return _id_99D8("hadir_smg");
      case "iw8_sn_hdromeo":
        return _id_99D8("hadir_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_kyle")) {
    switch (var_0) {
      case "iw8_ar_mcharlie":
        return _id_99D8("kyle_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_price")) {
    switch (var_0) {
      case "iw8_pi_papa320":
        return _id_99D8("papa320_black");
      case "iw8_ar_kilo433":
        return _id_99D8("price_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_farah")) {
    switch (var_0) {
      case "iw8_ar_akilo47":
        return _id_99D8("farah_ar");
    }
  } else if(issubstr(tolower(self.classname), "_villain_barkov")) {
    switch (var_0) {
      case "iw8_pi_golf21":
        return _id_99D8("barkov_pistol");
    }
  }

  if(getdvarint("#x38d847dcafb0389fe")) {
    iprintln("not whitelisted!skipping scripted build.");
  }

  return _id_99D4(var_0, []);
}

_id_6E5D(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
    case "ar":
      var_5["iw8_ar_akilo47"] = 45;
      var_5["iw8_ar_falima"] = 35;
      var_5["iw8_ar_falpha"] = 20;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["scopes"] = [50, "thermalvz", "acog", "acog2", "holo2"];
          var_3["stocks"] = [50, "stockh", "stockl", "stockno", "stockfold"];
          var_3["mags"] = [50, "drums", "xmags"];
          var_3["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          var_3["barrels"] = [50, "barlong"];
          var_3["underbarrels"] = [15, "gl", "glsmoke", "glgas", "glconc"];
          break;
        case "iw8_ar_falpha":
          var_3["scopes"] = [10, "acog2", "acog2light", "thermalvz"];
          var_3["stocks"] = [50, "stockh", "stockl", "stocks"];
          var_3["mags"] = [20, "xmags"];
          var_3["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          var_3["barrels"] = [50, "barlong"];
          var_3["underbarrels"] = [15, "selectsemi"];
          break;
        case "iw8_ar_falima":
          var_3["scopes"] = [20, "acog2"];
          var_3["mags"] = [20, "xmags"];
          var_3["grips"] = [50, "gripvert", "gripang"];
          var_3["barrels"] = [50, "barshort", "barlong"];
          var_3["underbarrels"] = [15, "ub_mike203", "selectauto"];
          break;
      }

      break;
    case "dmr":
      var_5["iw8_sn_kilo98"] = 50;
      var_5["iw8_ar_falima"] = 50;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3["scopes"] = [75, "scope", "vzscope"];
          var_3["stocks"] = [50, "stockh", "stockl"];
          var_3["barrels"] = [50, "barlong", "barmid", "barshort"];
          var_3["laserir"] = [50, "laserir"];
          var_3["mags"] = [35, "xmags"];
          break;
        case "iw8_ar_falima":
          var_3["scopes"] = [20, "acog2"];
          var_3["mags"] = [20, "xmags"];
          var_3["grips"] = [50, "gripvert", "gripang"];
          var_3["barrels"] = [50, "barshort", "barlong"];
          var_3["underbarrels"] = [15, "ub_mike203", "selectauto"];
          break;
      }

      break;
    case "jugg":
      return "iw8_lm_dblmg";
    case "launcher":
      return "iw8_la_rpapa7";
    case "lmg":
      var_5["iw8_lm_pkilo"] = 50;
      var_5["iw8_ar_akilo47"] = 35;
      var_5["iw8_sm_augolf"] = 15;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3["bipods"] = [75, "bipod"];
          var_3["mags"] = [100, "drums", "xmags"];
          break;
        case "iw8_sm_augolf":
          var_3["barrels"] = [100, "barlong"];
          var_3["mags"] = [100, "drums", "xmags"];
          break;
        case "iw8_ar_akilo47":
          var_3["scopes"] = [50, "thermalvz", "acog", "acog2", "holo2"];
          var_3["stocks"] = [50, "stockh", "stockl", "stockno", "stockfold"];
          var_3["mags"] = [50, "drums", "xmags"];
          var_3["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          var_3["barrels"] = [50, "barlong"];
          break;
      }

      break;
    case "pistol":
      var_5["iw8_pi_mike1911"] = 50;
      var_5["iw8_pi_golf21"] = 35;

      switch (var_1) {
        case "iw8_pi_mike1911":
          var_3["mags"] = [35, "xmags"];
        case "iw8_pi_golf21":
          var_3["mags"] = [35, "xmags"];
          break;
      }

      break;
    case "shotgun":
      var_5["iw8_sh_romeo870"] = 50;
      var_5["iw8_sh_charlie725"] = 35;

      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["stocks"] = [80, "stockno", "stockh", "stockl", "stocks"];
          var_3["barrels"] = [50, "barshort", "barlong"];
          break;
        case "iw8_sh_charlie725":
          var_3["scopes"] = [100, "scope"];
          var_3["stocks"] = [75, "stockno", "stockh", "stockl", "stocks"];
          var_3["barrels"] = [50, "barshort", "barlong"];
          break;
      }

      break;
    case "smg":
      var_5["iw8_sm_uzulu"] = 90;
      var_5["iw8_ar_akilo47"] = 10;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_uzulu":
          var_3["scopes"] = [100, "reflex2"];
          break;
        case "iw8_ar_akilo47":
          var_3["scopes"] = [50, "thermalvz", "acog", "acog2", "holo2"];
          var_3["stocks"] = [100, "stockl"];
          var_3["mags"] = [50, "xmags"];
          var_3["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          var_3["barrels"] = [100, "barshortnoguard"];
          var_3["underbarrels"] = [15, "gl", "glsmoke", "glgas", "glconc"];
          break;
      }

      break;
    case "sniper":
      var_5["iw8_sn_delta"] = 50;
      var_5["iw8_sn_kilo98"] = 50;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3["scopes"] = [100, "scope"];
          var_3["laserir"] = [100, "laserir"];
          var_3["mags"] = [35, "xmags"];
          break;
        case "iw8_sn_delta":
          var_3["scopes"] = [100, "scope"];
          var_3["laserir"] = [100, "laserir"];
          var_3["mags"] = [35, "xmags"];
          break;
      }

      break;
  }

  return _id_C00A(var_1, var_3, var_4);
}

_id_6E60(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_ar_asierra12"] = 30;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["scopes"] = [70, "acogstable_east01", "holostable_east01", "reflexstable_east01", "reflexstable_east02"];
          var_3["stocks"] = [100, "stocksmg_akilo47", "stockno_akilo47", "stockfold_akilo47", "stockcust_akilo47"];
          var_3["mags"] = [20, "drums_akilo47"];
          var_3["grips"] = [50, "gripvert_akilo47", "griphip_akilo47", "gripvert_akilo47"];
          var_3["barrels"] = [50, "barlmg_akilo47", "barcust_akilo47"];
          var_3["underbarrels"] = [15, "ub_golf25"];
          var_3["other"] = [15, "laserir_bar"];
          break;
        case "iw8_ar_asierra12":
          var_3["scopes"] = [70, "reflex_east01", "reflex_east02", "holo_east01", "acog_east01_irons"];
          var_3["stocks"] = [50, "stockh_asierra12", "stockl_asierra12", "stocks_asierra12"];
          var_3["mags"] = [20, "xmags_asierra12"];
          var_3["grips"] = [50, "gripvert", "gripang"];
          var_3["barrels"] = [50, "barcust_asierra12", "barshort_asierra12", "barlong_asierra12"];
          var_3["other"] = [15, "laserir"];
          var_3["underbarrels"] = [15, "selectsemi"];
          break;
      }

      break;
    case "dmr":
      switch (var_1) {
        case "iw8_sn_mike14":
          var_3["scopes"] = [50, "snprscope_mike14"];
          var_3["other"] = [100, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3["other"] = [50, "bipod_pkilo"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      var_5["iw8_sh_romeo870"] = 50;
      var_5["iw8_sh_oscar12"] = 50;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["scopes"] = [50, "reflex_east01", "reflex_east02"];
          var_3["stocks"] = [50, "stockno_romeo870"];
          var_3["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          var_3["grips"] = [25, "gripcust_romeo870"];
          var_3["other"] = [50, "laserir_bar"];
          break;
        case "iw8_sh_oscar12":
          var_3["scopes"] = [50, "reflex_east01", "reflex_east02"];
          var_3["stocks"] = [75, "stockno_oscar12", "stockh_oscar12"];
          var_3["mags"] = [75, "drums_oscar12"];
          var_3["barrels"] = [50, "barshort_oscar12", "barmid_oscar12", "barlong_oscar12"];
          var_3["other"] = [50, "laserir"];
          break;
      }

      break;
    case "smg":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_sm_augolf"] = 30;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_augolf":
          var_3["scopes"] = [50, "reflex_east01", "reflex_east02", "holo_east01"];
          var_3["mags"] = [30, "drums_augolf"];
          var_3["other"] = [50, "laserirsmg"];
          var_3["barrels"] = [50, "barshort_augolf"];
          var_3["grips"] = [50, "gripvertsmg", "gripangsmg"];
          break;
        case "iw8_ar_akilo47":
          var_3["barrels"] = [100, "barcust_akilo47"];
          var_3["stocks"] = [100, "stockcust_akilo47", "stocksmg_akilo47", "stockno_akilo47", "stockno_akilo47"];
          var_3["mags"] = [100, "calsmg_akilo47", "calsmgdrums_akilo47"];
          var_3["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          var_3["other"] = [50, "laserir_bar"];
          var_3["scopes"] = [70, "holostable_east01", "reflexstable_east01", "reflexstable_east02"];
          break;
      }

      break;
    case "sniper":
      switch (var_1) {
        case "iw8_sn_delta":
          var_3["other"] = [100, "laserads_bar"];
          break;
      }

      break;
  }

  return _id_C00A(var_1, var_3, var_4);
}

_id_6E5F(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      var_5["iw8_ar_akilo47"] = 50;
      var_5["iw8_ar_falpha"] = 50;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["scopes"] = [10, "acogstable_east01"];
          var_3["stocks"] = [50, "stocklmg_akilo47", "stocksmg_akilo47", "stockno_akilo47", "stockfold_akilo47"];
          var_3["mags"] = [20, "drums_akilo47", "mag_akilo47|1"];
          var_3["grips"] = [50, "gripvert_akilo47", "griphip_akilo47", "guard_akilo47|1"];
          var_3["barrels"] = [50, "barlmg_akilo47", "front_akilo47|1"];
          var_3["underbarrels"] = [15, "ub_golf25"];
          var_3["other"] = [15, "rec_akilo47|1"];
          break;
        case "iw8_ar_falpha":
          var_3["scopes"] = [15, "acog_east01_irons"];
          var_3["stocks"] = [50, "stockh_falpha", "stockl_falpha", "stocks_falpha"];
          var_3["mags"] = [20, "xmags_falpha"];
          var_3["grips"] = [50, "gripvert", "gripang"];
          var_3["barrels"] = [50, "barlong_falpha", "barcust_falpha", "barshort_falpha"];
          var_3["underbarrels"] = [15, "selectsemi"];
          break;
      }

      break;
    case "dmr":
      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3["scopes"] = [50, "snprscope_kilo98", "vzscope_kilo98"];
          var_3["mags"] = [30, "xmags_kilo98"];
          var_3["other"] = [40, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      var_5["iw8_lm_pkilo"] = 50;
      var_5["iw8_ar_akilo47"] = 35;
      var_5["iw8_sm_augolf"] = 15;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3["scopes"] = [50, "reflex_west01", "acog_east01_irons", "holo_east01"];
          var_3["bipods"] = [75, "bipod_pkilo"];
          var_3["mags"] = [35, "xmags_pkilo", "drums_pkilo"];
          break;
        case "iw8_sm_augolf":
          var_3["scopes"] = [50, "reflex_west01", "acog_east01", "holo_east01"];
          var_3["arrels"] = [100, "barlmg_augolf"];
          var_3["ags"] = [100, "callmgdrums_augolf", "callmg_augolf"];
          var_3["ther"] = [50, "rec_augolf|1"];
          break;
        case "iw8_ar_akilo47":
          var_3["barrels"] = [100, "barlmg_akilo47"];
          var_3["bipods"] = [50, "bipod_akilo47"];
          var_3["mags"] = [100, "callmgdrums_akilo47", "callmg_akilo47"];
          var_3["scopes"] = [50, "reflexstable_west01", "acogstable_east01", "holostable_east01"];
          var_3["stocks"] = [75, "stocklmg_akilo47"];
          var_3["grips"] = [50, "guard_akilo47|1"];
          var_3["other"] = [50, "rec_akilo47|1"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["stocks"] = [100, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
          var_3["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          break;
      }

      break;
    case "smg":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_sm_uzulu"] = 15;
      var_5["iw8_sm_mpapa5"] = 15;
      var_1 = scripts\common\utility::_id_685B(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_uzulu":
          var_3["scopes"] = [50, "minireddot", "reflex_west01", "reflex_east01", "reflex_east02"];
          break;
        case "iw8_ar_akilo47":
          var_3["barrels"] = [100, "barcust_akilo47"];
          var_3["stocks"] = [100, "stockcust_akilo47", "stockno_akilo47", "stockno_akilo47"];
          var_3["mags"] = [100, "calsmg_akilo47", "calsmgdrums_akilo47"];
          var_3["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          var_3["scopes"] = [30, "reflexstable_west01", "reflexstable_west01", "reflexstable_east01"];
          break;
        case "iw8_sm_mpapa5":
          var_3["stocks"] = [50, "stockno_mpapa5", "stockh_mpapa5", "stocks_mpapa5"];
          var_3["mags"] = [35, "drums_mpapa5"];
          var_3["grips"] = [35, "gripvertsmg"];
          var_3["scopes"] = [30, "reflex_west01_irons", "reflex_east01", "reflex_east02", "minireddot"];
          break;
      }

      break;
    case "sniper":
      switch (var_1) {
        case "iw8_sn_alpha50":
          var_3["scopes"] = [100, "snprscope_alpha50", "vzscope_alpha50"];
          var_3["barrels"] = [50, "barmid_alpha50", "barshort_alpha50"];
          var_3["laserir"] = [100, "laserads"];
          var_3["stocks"] = [50, "stockl_alpha50", "stockh_alpha50", "stocks_alpha50"];
          var_3["other"] = [25, "bipodsnpr"];
          var_3["mags"] = [35, "xmags_alpha50"];
          break;
      }

      break;
  }

  return _id_C00A(var_1, var_3, var_4);
}

_id_6E63(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      return _id_99D8("sas_ar");
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      return _id_99D8("papa320_black");
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return _id_C00A(var_1, var_3, var_4);
}

_id_6E64(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      break;
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      if(level.script == "piccadilly" || level.script == "ai_aitypes_allies") {
        return _id_99D8("papa320_black_rain");
      } else {
        return _id_99D8("papa320_black");
      }
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return _id_C00A(var_1, var_3, var_4);
}

_id_6E65(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      switch (var_1) {
        case "iw8_ar_mike4":
          var_3["scopes"] = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01_irons", "minireddot"];
          var_3["stocks"] = [70, "stockl_mike4", "stocks_mike4", "back_mike4|1", "back_mike4|2"];
          var_3["mags"] = [50, "xmags_mike4", "mag_mike4|1", "mag_mike4|2"];
          var_3["grips"] = [50, "gripvert", "gripang", "gripvertpro", "gripangpro"];
          var_3["barrels"] = [70, "barshort_mike4", "front_mike4|2"];
          var_3["underbarrels"] = [15, "ub_mike203"];
          var_3["endbarrel"] = [65, "flashhider", "comp", "brake", "linearbrake", "laser", "laserir"];
          var_3["other"] = [50, "rec_mike4|1", "rec_mike4|2"];
          break;
      }

      break;
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      break;
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return _id_C00A(var_1, var_3, var_4);
}

_id_99D8(var_0) {
  switch (var_0) {
    case "farah_ar":
      var_0 = _id_99D4("iw8_ar_akilo47", ["rec_akilo47|1", "back_akilo47|1", "front_akilo47|1", "mag_akilo47|1", "guard_akilo47|1"]);
      break;
    case "alex_sniper":
      var_0 = _id_99D4("iw8_sn_mike14", ["vzscope_mike14", "rec_mike14|1", "reargrip_mike14|1", "front_mike14|1", "mag_mike14|1"]);
      break;
    case "alex_pistol":
      var_0 = _id_99D4("iw8_pi_mike1911", ["rec_mike1911|2", "mag_mike1911|2", "slide_mike1911|2"]);
      break;
    case "hadir_smg":
      var_0 = _id_99D4("iw8_sm_augolf", ["rec_augolf|1", "front_augolf|1", "mag_augolf|1", "toprail_augolf|1"]);
      break;
    case "hadir_sniper":
      var_0 = _id_99D4("iw8_sn_hdromeo_ballistics", ["vzscope_hdromeo_ballistics", "bipod_hdromeo", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
      break;
    case "sas_ar":
      var_0 = _id_99D4("iw8_ar_kilo433", ["holo_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "price_ar":
      var_0 = _id_99D4("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "kyle_ar":
      var_0 = _id_99D4("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "front_mcharlie|1", "mag_mcharlie|1"]);
      break;
    case "papa320_black":
      var_0 = _id_99D4("iw8_pi_papa320", ["rec_papa320|2", "mag_papa320|2", "slide_papa320|2"]);
      break;
    case "papa320_black_rain":
      var_0 = _id_99D4("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
      break;
    case "barkov_pistol":
      var_0 = _id_99D4("iw8_pi_golf21", ["rec_golf21|1", "mag_golf21|1", "slide_golf21|1"]);
      break;
    case "estate_teaser_price":
      var_0 = _id_99D4("iw8_ar_kilo433", ["hybrid_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "estate_teaser":
      var_0 = _id_99D4("iw8_ar_kilo433", ["reflex_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    default:
      var_0 = undefined;
  }

  return var_0;
}

_id_99D4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level._id_0DD7)) {
    level._id_0DD7 = spawnStruct();
  }

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!isweapon(var_0)) {
    var_7 = strtok(var_0, "+");

    if(var_7.size > 1) {
      var_0 = var_7[0];
      var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::array_remove(var_7, var_7[0]));
    }
  } else {
    if(isnullweapon(var_0)) {
      return var_0;
    }

    var_0 = getweaponbasename(var_0);
  }

  if(istrue(var_5)) {
    var_8 = ::_func_037C;
  } else {
    var_8 = ::makeweapon;
  }

  var_9 = var_0;
  var_9 = scripts\cp\utility::getweaponrootname(var_0);
  var_10 = scripts\cp\utility::_id_10D61(var_9);
  var_10 = _id_C485(var_1, var_10);
  var_1 = scripts\engine\utility::array_combine(var_1, var_10);
  var_11 = scripts\cp\utility::_id_2D16(var_9, var_4);

  foreach(var_19, var_13 in var_1) {
    var_14 = strtok(var_13, "|");
    var_15 = scripts\engine\utility::ter_op(issubstr(var_13, "|"), strtok(var_13, "|")[0], var_13);

    if(isDefined(level.mag_replacement_map[var_15])) {
      if(issubstr(var_15, "_zm")) {
        if(istrue(var_6)) {
          var_16 = level.mag_replacement_map[var_15];
        } else {
          var_16 = "";
        }
      } else
        var_16 = scripts\engine\utility::ter_op(istrue(var_6), var_15 + "_pack_zm", var_15 + "_zm");

      if(var_16 == "") {
        continue;
      } else {
        var_17 = scripts\cp\utility::_id_1DA5(level.mag_replacement_map[var_15]);

        if(var_17 == var_16) {
          continue;
        }
        var_18 = var_16 + "|" + var_14[1];
        var_1[var_19] = var_18;
      }
    }
  }

  var_20 = [];

  foreach(var_13 in var_1) {
    if(issubstr(var_13, "|")) {
      var_22 = strtok(var_13, "|");
      var_1 = scripts\engine\utility::array_remove(var_1, var_13);
      var_1[var_1.size] = var_22[0];
      var_20[var_22[0]] = int(var_22[1]);
    }
  }

  var_24 = _id_2D1F(var_9, var_1, var_4);
  var_24 = _id_3509(var_24, var_11);
  var_1 = var_24;

  if(!isDefined(level.activeattachmentoverrides)) {
    level.activeattachmentoverrides = [];
  }

  foreach(var_13 in var_1) {
    for(var_26 = 0; var_26 < var_1.size; var_26++) {
      var_15 = var_1[var_26];
      var_27 = scripts\cp\utility::_id_1DA5(var_15);

      if(isDefined(level.attachmentmap_combooverrides[var_13]) && isDefined(level.attachmentmap_combooverrides[var_13][var_27])) {
        level.activeattachmentoverrides[var_13] = var_27;
        var_28 = level.attachmentmap_combooverrides[var_13][var_27];
        var_1[var_26] = var_28;
        var_20[var_28] = var_20[var_15];
        var_20 = scripts\engine\utility::_id_1BC6(var_20, var_15);
      }
    }
  }

  if(isDefined(var_4)) {
    var_30 = call[[var_8]](var_11, undefined, undefined, var_3, var_4);
  } else if(isDefined(var_3)) {
    var_30 = call[[var_8]](var_11, undefined, undefined, var_3);
  } else {
    var_30 = call[[var_8]](var_11);
  }

  foreach(var_13, var_32 in var_20) {
    if(var_32 > 0) {
      var_33 = var_30 _meth_8889(var_13, var_32);

      if(!var_33) {
        var_32 = 0;
      }
    }

    var_30 = var_30 _meth_8669(var_13, var_32);
  }

  if(isDefined(var_30._id_0389) && !_func_010D(var_30._id_0389, "ironsdefault")) {
    if(isDefined(var_2)) {
      var_30 = var_30 _meth_8674(var_2);
    }
  }

  return var_30;
}

_id_C485(var_0, var_1) {
  var_2 = [];

  if(_func_0107(var_1)) {
    foreach(var_4 in var_1) {
      var_5 = 1;

      foreach(var_7 in var_0) {
        var_5 = _id_1DB1(var_7, var_4);

        if(!istrue(var_5)) {
          break;
        }
      }

      if(istrue(var_5)) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
      }
    }
  }

  return var_2;
}

_id_C486(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;

  if(_func_010C(var_3, "_")) {
    var_5 = _func_0441(var_3, "_");
  }

  foreach(var_7 in var_0) {
    if(issubstr(var_7, var_3)) {
      var_4 = 1;
    }

    if(_func_010D(var_7, var_2) || istrue(var_4)) {
      for(var_8 = 0; var_8 < var_1.size; var_8++) {
        var_9 = isDefined(var_5) && issubstr(var_1[var_8], var_5);
        var_10 = var_9 || issubstr(var_1[var_8], var_3);

        if(var_10) {
          var_1 = scripts\engine\utility::array_remove_index(var_1, var_8);
          return var_1;
        }
      }
    }
  }

  return var_1;
}

_id_C00A(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::_id_66D3(var_1, var_2);
  var_4 = _id_99D4(var_0, var_3);
  return var_4;
}

_id_6D17(var_0, var_1) {
  if(!isDefined(var_0)) {
    return _func_0375();
  }

  if(!_func_0107(var_0) && var_0 == "") {
    return _func_0375();
  }

  if(isDefined(var_1) && var_1 == "sidearm") {
    var_2 = _id_6E5C(var_0, "pistol");
  } else {
    var_2 = _id_6E5C(var_0, self._id_CF7F);
  }

  return var_2;
}

_id_BD23() {
  self notify("stop printWeapon");
  self endon("death");
  self endon("stop printWeapon");

  for(;;) {
    var_0 = 72;

    if(isDefined(self) && isDefined(self._id_04F6)) {
      if(isDefined(self._id_04F6.basename)) {}

      if(isDefined(self._id_04F6._id_0070)) {
        var_1 = var_0 - 1.5;

        foreach(var_4, var_3 in self._id_04F6._id_0070) {
          var_1 = var_1 - 1.4;
        }
      }
    }

    waitframe();
  }
}

_id_3F92(var_0, var_1) {
  if(!isDefined(level._id_5DB9)) {
    self._id_FEC7 = undefined;

    if(!isDefined(var_0)) {
      var_2 = _func_0375();
    } else if(!_func_0107(var_0) && var_0 == "") {
      var_2 = _func_0375();
    } else if(_func_0107(var_0)) {
      var_2 = makeweapon(var_0[randomint(var_0.size)]);
    } else {
      var_2 = makeweapon(var_0);
    }

    if(!isnullweapon(var_2)) {
      self._id_CF80 = 1;

      if(isDefined(var_1) && var_1 == "sidearm") {
        self._id_CF83 = var_0;
      } else {
        self._id_CF81 = var_0;
      }
    }

    return var_2;
  } else
    return [[level._id_5DB9]](var_0, var_1);
}

buildweapon_blueprint(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_10D60(var_0, var_3);

  if(!isDefined(var_7)) {
    var_7 = [];
  }

  return _id_2D12(var_0, var_7, "none", "none", var_3, var_4, var_5, var_6);
}

_id_2D12(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  foreach(var_12, var_11 in var_1) {
    var_8[var_8.size] = var_12;
    var_9[var_9.size] = var_11;
  }

  return buildweapon(var_0, var_8, var_2, var_3, var_4, var_9, var_5, var_6, var_7);
}

_id_2D13(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  return buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_0;
  var_11 = strtok(var_10, "_");
  var_12 = 0;

  if(var_11[0] == "alt") {
    var_12++;
  }

  if(var_11[var_12] == "iw8" || var_11[var_12] == "s4") {
    var_1 = scripts\cp\utility::_id_459B(var_1, []);
    var_2 = scripts\cp\utility::_id_459B(var_2, "none");
    var_3 = scripts\cp\utility::_id_459B(var_3, "none");

    if(isDefined(var_4) && var_4 < 0) {
      var_4 = undefined;
    }

    if(!isDefined(var_4)) {
      if(issubstr(var_0, "_mp")) {
        var_13 = scripts\cp\utility::getweaponrootname(var_0);

        if(isDefined(var_13) && (var_13 == "s4_pi_raygun" || var_13 == "s4_me_rindigoww" || var_13 == "s4_ar_tgun")) {
          var_4 = 0;
        }
      }
    }

    var_5 = scripts\cp\utility::_id_459B(var_5, []);
    var_6 = scripts\cp\utility::_id_459B(var_6, "none");
    var_7 = scripts\cp\utility::_id_459B(var_7, []);
    var_8 = scripts\cp\utility::_id_459B(var_8, 0);
    var_14 = undefined;

    if(isDefined(var_9)) {
      var_14 = var_9;
    } else if(isDefined(level._id_6E79)) {
      var_14 = self[[level._id_6E79]](var_0);
    }

    if(!isDefined(var_14)) {
      var_15 = scripts\cp\utility::_id_6CE3(var_10);
      var_14 = _id_683D(var_15);
    }

    if(isDefined(level._id_1092)) {
      [var_1, var_5] = self[[level._id_1092]](var_0, var_1, var_5, var_14);
    }

    if(isDefined(level._id_6F89)) {
      var_2 = self[[level._id_6F89]](var_0, var_2, var_14, var_4);
    }
  } else {
    if(var_11[var_12] == "iw7") {} else {}

    return;
  }

  if(issubstr(var_0, "_mp")) {
    var_0 = scripts\cp\utility::getweaponrootname(var_0);
  }

  var_17 = scripts\cp\utility::_id_2D16(var_0, var_4);
  var_18 = _id_2D17(var_1, var_5);

  if(istrue(var_8)) {
    if(_id_10DDC(var_17)) {
      var_19 = _id_6E7C(var_17);

      if(!scripts\engine\utility::array_contains(var_1, var_19)) {
        var_1[var_1.size] = var_19;

        if(var_18.size > 0) {
          var_18[var_19] = 0;
        }
      }
    }
  }

  var_20 = _id_2D20(var_0, var_1, var_4, var_18);

  if(isDefined(var_6) && var_6 != "none") {
    var_20[var_6] = 0;
  }

  var_20 = _id_5A4D(var_20, var_17);
  var_1 = [];
  var_5 = [];

  foreach(var_23, var_22 in var_20) {
    var_1[var_1.size] = var_23 + "|" + var_22;
    var_5[var_5.size] = var_22;
  }

  var_24 = scripts\engine\utility::ter_op(isint(var_3), var_3, _id_6CF2(var_3));
  var_25 = _id_99D4(var_17, var_1, var_24, var_2, var_4, undefined, var_14);

  if(isDefined(var_7)) {
    for(var_26 = 0; var_26 < var_7.size; var_26++) {
      if(!isDefined(var_7[var_26])) {
        continue;
      }
      var_27 = var_7[var_26];

      if("i/" != _func_00D6(var_27, 0, 2)) {
        var_27 = "i/" + var_7[var_26];
      }

      var_25 = var_25 _meth_8671(var_26, var_27);
    }
  }

  return var_25;
}

_id_2D17(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_1)) {
    foreach(var_5, var_4 in var_0) {
      if(isDefined(var_1[var_4])) {
        var_2[var_4] = var_1[var_4];
        continue;
      }

      if(var_5 < var_1.size) {
        var_2[var_4] = var_1[var_5];
        continue;
      }

      var_2[var_4] = 0;
    }
  }

  return var_2;
}

_id_2D20(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 < 0) {
    var_2 = undefined;
  }

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  var_3 = scripts\engine\utility::_id_1BC6(var_3, "none");

  if(var_1.size > 0 && var_3.size == 0) {
    foreach(var_5 in var_1) {
      var_3[var_5] = 0;
    }
  }

  var_7 = _id_10D62(var_0, var_2);
  var_8 = scripts\cp\utility::_id_2D16(var_0, var_2);
  var_9 = [];

  if(isDefined(var_7)) {
    var_9 = _id_3AD1(var_7, var_3);
  }

  var_10 = [];

  if(var_9.size > 0) {
    var_9 = _id_5A45(var_9, var_0);

    foreach(var_5, var_12 in var_9) {
      var_13 = scripts\cp\utility::_id_1DA9(var_5, var_8);
      var_10[var_13] = var_12;
    }
  }

  var_14 = [];
  var_15 = 0;
  var_16 = undefined;

  foreach(var_23, var_12 in var_10) {
    var_18 = scripts\cp\utility::_id_1DA8(var_23);

    if(isDefined(var_18)) {
      var_19 = 0;

      if(isDefined(var_2)) {
        var_20 = scripts\cp\utility::_id_1DA5(var_18);
        var_19 = _id_1DA4(var_20, var_0, var_2);
      }

      var_21 = scripts\cp\utility::_id_1DA9(var_18, var_8);
      var_14[var_21] = var_19;
    }

    var_22 = scripts\cp\utility::_id_1DA5(var_23);

    if(!isDefined(var_16) && scripts\cp\utility::_id_879E(var_22)) {
      var_16 = var_23;
    }

    if(!var_15 && (scripts\cp\utility::_id_8A36(var_22) || scripts\cp\utility::_id_8A35(var_23))) {
      var_15 = 1;
    }
  }

  if(var_14.size > 0) {
    var_10 = scripts\engine\utility::_id_1B9E(var_10, var_14);
  }

  if(isDefined(var_16) && var_15) {
    var_16 = scripts\engine\utility::ter_op(var_16 == "calsmg_mike4", "calsil_mike4smg", "calsil");

    if(isDefined(var_10[var_16])) {
      var_10[var_16] = 0;
    }
  }

  return var_10;
}

_id_3AD1(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(scripts\engine\utility::_id_1BA1(var_1, var_5)) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4;
  }

  return var_2;
}

_id_8A4E(var_0) {
  if(!isweapon(var_0)) {
    return 0;
  }

  switch (var_0.basename) {
    case "iw8_sn_hdromeo_mp":
      if(var_0 _meth_8624("barmid", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_charlie_mp":
      if(var_0 _meth_8624("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_kilo433_mp":
      if(var_0 _meth_8624("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_mike4_mp":
      if(var_0 _meth_8624("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_sm_mpapa5_mp":
      if(var_0 _meth_8624("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    default:
      if(var_0 _meth_8624("barsil", 1)) {
        return 1;
        return;
      }

      return 0;
      return;
  }
}

_id_5A45(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    var_3[var_3.size] = var_6;
  }

  if(var_3.size > 0) {
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_6 = var_3[var_7];

      if(var_6 == "none") {
        continue;
      }
      var_8 = 1;

      for(var_9 = 0; var_9 < var_2.size; var_9++) {
        if(var_6 == var_2[var_9]) {
          var_8 = 0;
          break;
        }

        var_10 = _id_1DB2(var_6, var_2[var_9], var_1);

        if(var_10 != "") {
          var_8 = 0;
          var_2 = scripts\engine\utility::array_remove_index(var_2, var_9);
          var_11 = [];
          var_11 = strtok(var_10, " ");

          foreach(var_14, var_13 in var_11) {
            var_3 = scripts\engine\utility::_id_1BB3(var_3, var_13, var_7 + 1 + var_14);
          }

          break;
        }
      }

      if(var_8) {
        var_2[var_2.size] = var_6;
      }
    }
  }

  var_15 = [];

  foreach(var_6 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_0[var_6]), var_0[var_6], 0);
    var_15[var_6] = var_5;
  }

  return var_15;
}

_id_5A4D(var_0, var_1) {
  var_2 = makeweapon(var_1);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_2 _meth_8629(var_6)) {
      var_3[var_6] = var_5;
      continue;
    }

    thread _id_84F8(var_6, var_1);
  }

  return var_3;
}

_id_1DB1(var_0, var_1) {
  if(scripts\cp\utility::_id_1D98(var_0) && scripts\cp\utility::_id_1D98(var_1)) {
    return 0;
  }

  var_0 = scripts\cp\utility::_id_1DA5(var_0);
  var_1 = scripts\cp\utility::_id_1DA5(var_1);
  var_2 = 1;

  if(var_0 == var_1) {
    var_2 = 0;
  } else if(isDefined(level._id_1DA3)) {
    var_3 = scripts\engine\utility::_id_163E([var_0, var_1]);
    var_2 = !isDefined(level._id_1DA3[var_3[0] + "_" + var_3[1]]);
  } else if(var_0 != "none" && var_1 != "none") {
    var_4 = tablelookuprownum("mp/attachmentcombos.csv", 0, var_1);

    if(_func_0222("mp/attachmentcombos.csv", 0, var_0, var_4) == "no") {
      var_2 = 0;
    }
  }

  return var_2;
}

_id_1DB2(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_1D98(var_0) && scripts\cp\utility::_id_1D98(var_1)) {
    return var_0;
  }

  var_3 = undefined;

  if(isweapon(var_2)) {
    var_3 = getcompleteweaponname(var_2);
  } else {
    var_3 = var_2;
  }

  var_4 = scripts\cp\utility::_id_1DA9(var_0, var_3);
  var_5 = scripts\cp\utility::_id_1DA9(var_1, var_3);

  if(_id_0B44(var_4, var_5)) {
    return var_0;
  }

  if(_id_0B44(var_5, var_4)) {
    return var_1;
  }

  var_0 = scripts\cp\utility::_id_1DA5(var_0);
  var_1 = scripts\cp\utility::_id_1DA5(var_1);
  var_6 = "";

  if(var_0 == var_1) {
    var_6 = var_0;
  } else if(isDefined(level._id_1DA3)) {
    var_7 = scripts\engine\utility::_id_163E([var_0, var_1]);
    var_8 = var_7[0] + "_" + var_7[1];

    if(isDefined(level._id_1DA3[var_8])) {
      if(level._id_1DA3[var_8] == "no") {
        var_6 = var_0;
      } else {
        var_6 = level._id_1DA3[var_8];
      }
    }
  }

  return var_6;
}

_id_0B44(var_0, var_1) {
  var_2 = _id_1DA7(var_0);
  var_3 = _id_1DA6(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_3 == var_2;
}

_id_1DA6(var_0) {
  if(isDefined(level._id_1D9F[var_0])) {
    return level._id_1D9F[var_0];
  }

  return undefined;
}

_id_1DA7(var_0) {
  if(isDefined(level._id_1DAA[var_0])) {
    return level._id_1DAA[var_0];
  }

  var_1 = scripts\cp\utility::_id_1DA5(var_0);

  if(isDefined(level._id_1DA1[var_1])) {
    return level._id_1DA1[var_1];
  }

  return undefined;
}

_id_1DA4(var_0, var_1, var_2) {
  var_3 = var_1 + "|" + var_2;

  if(isDefined(level._id_10DAC[var_3]) && isDefined(level._id_10DAC[var_3]._id_1D86) && isDefined(level._id_10DAC[var_3]._id_1D86[var_0])) {
    return level._id_10DAC[var_3]._id_1D86[var_0];
  }

  return 0;
}

_id_10D62(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level._id_10DAC[var_2]) && isDefined(level._id_10DAC[var_2]._id_1D7B)) {
      return level._id_10DAC[var_2]._id_1D7B;
    }
  }

  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_1D7B)) {
    return level._id_10DB0[var_0]._id_1D7B;
  }

  return undefined;
}

_id_6E7C(var_0) {
  return "laserir";
}

_id_10D60(var_0, var_1) {
  if(isDefined(var_1) && var_1 >= 0) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level._id_10DAC[var_2]) && isDefined(level._id_10DAC[var_2]._id_1D78)) {
      return level._id_10DAC[var_2]._id_1D78;
    }
  }

  return undefined;
}

_id_2D18() {
  level._id_10DB0 = [];
  level._id_10D98 = [];
  var_0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/statstable.csv", var_1, 0);
    var_2 = int(var_2);

    if(var_2 == 0) {
      continue;
    }
    var_3 = _func_0222("mp/statstable.csv", 0, var_2, 4);

    if(var_3 != "") {
      level._id_10DB0[var_3] = spawnStruct();
      var_4 = _func_0222("mp/statstable.csv", 0, var_2, 0);

      if(var_4 != "") {
        level._id_10DB0[var_3]._id_A76E = var_4;
      }

      var_5 = _func_0222("mp/statstable.csv", 0, var_2, 1);

      if(var_5 != "") {
        level._id_10DB0[var_3]._id_71F4 = var_5;
        var_6 = _func_0222("mp/statstable.csv", 0, var_2, 41);

        if(var_6 != "") {
          var_7 = int(var_6);

          if(var_7 > -1) {
            if(!isDefined(level._id_10D98[var_5])) {
              level._id_10D98[var_5] = [];
            }

            level._id_10D98[var_5][level._id_10D98[var_5].size] = var_3;
          } else
            level._id_10DB0[var_3]._id_F91D = 1;
        }
      }

      var_8 = _func_0222("mp/statstable.csv", 0, var_2, 5);

      if(var_8 != "") {
        level._id_10DB0[var_3]._id_1CED = var_8;
      }

      var_9 = _func_0222("mp/statstable.csv", 0, var_2, 44);

      if(var_9 != "") {
        level._id_10DB0[var_3]._id_AFA5 = var_9;
      }

      var_10 = _func_0222("mp/statstable.csv", 0, var_2, 9);

      if(var_10 != "") {
        level._id_10DB0[var_3]._id_1D7A = strtok(var_10, " ");
      }

      var_11 = _id_AE6C(var_10);

      if(isDefined(var_11)) {
        level._id_10DB0[var_3]._id_1D7B = var_11;
      } else {
        level._id_10DB0[var_3]._id_1D7B = [];
      }

      var_12 = _func_0222("mp/statstable.csv", 0, var_2, 8);

      if(var_12 != "") {
        var_12 = float(var_12);
        level._id_10DB0[var_3].speed = var_12;
      }

      var_13 = _func_0222("mp/statstable.csv", 0, var_2, 61);

      if(var_13 != "") {
        if(var_13 == "1") {
          level._id_10DB0[var_3]._id_8B15 = 1;
        } else {
          level._id_10DB0[var_3]._id_8B15 = 0;
        }
      } else
        level._id_10DB0[var_3]._id_8B15 = 0;
    }

    var_2++;
  }

  level._id_10DAC = [];
  var_14 = -1;

  for(;;) {
    var_14++;
    var_15 = tablelookupbyrow("loot/weapon_ids.csv", var_14, 0);

    if(var_15 == "") {
      break;
    }

    var_3 = tablelookupbyrow("loot/weapon_ids.csv", var_14, 1);
    var_16 = tablelookupbyrow("loot/weapon_ids.csv", var_14, 9);
    var_17 = _id_6E93(var_3);
    var_18 = _func_0222(var_17, 1, var_16, 0);

    if(var_18 == "") {
      continue;
    }
    var_19 = var_3 + "|" + var_18;
    level._id_10DAC[var_19] = spawnStruct();
    level._id_10DAC[var_19]._id_04CC = int(var_18);
    var_20 = _func_0222(var_17, 1, var_16, 3);

    if(var_20 != "") {
      level._id_10DAC[var_19]._id_1CEE = var_20;
    }

    var_21 = _func_0222("loot/weapon_ids.csv", 9, var_16, 5);
    level._id_10DAC[var_19]._id_8912 = int(var_18) != 0 && int(var_21) == 99;
    var_22 = _func_0222(var_17, 1, var_16, 4);
    var_11 = _id_AE6C(var_22);

    if(isDefined(var_11)) {
      if(isDefined(level._id_10DB0[var_3]) && isDefined(level._id_10DB0[var_3]._id_1D7B)) {
        var_11 = scripts\engine\utility::_id_1B9E(var_11, level._id_10DB0[var_3]._id_1D7B);
      }

      level._id_10DAC[var_19]._id_1D7B = var_11;
    }

    var_23 = [];

    for(var_24 = 5; var_24 <= 15; var_24++) {
      var_25 = _func_0222(var_17, 1, var_16, var_24);

      if(var_25 != "") {
        var_26 = strtok(var_25, "|");

        if(var_26.size == 2) {
          var_23[var_26[0]] = int(var_26[1]);
        } else {
          var_23[var_26[0]] = 0;
        }
      }
    }

    if(var_23.size > 0) {
      level._id_10DAC[var_19]._id_1D78 = var_23;
    }

    var_27 = _func_0222(var_17, 1, var_16, 16);

    if(var_27 != "") {
      var_28 = [];
      var_29 = strtok(var_27, " ");

      foreach(var_31 in var_29) {
        var_32 = strtok(var_31, "|");

        if(var_32.size != 2) {
          continue;
        }
        var_28[var_32[0]] = int(var_32[1]);
      }

      if(var_28.size > 0) {
        level._id_10DAC[var_19]._id_1D86 = var_28;
      }
    }
  }
}

_id_6E93(var_0) {
  if(scripts\cp\utility::_id_8A68(var_0, "iw8_")) {
    var_0 = _func_00D6(var_0, 4);
  }

  return "mp/gunsmith/" + var_0 + "_variants.csv";
}

_id_AE6C(var_0) {
  if(var_0 != "") {
    var_1 = strtok(var_0, " ");
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = strtok(var_4, "|");

      if(getdvarint("#x3ae126b167405781f", 1) == 0) {
        if(scripts\engine\utility::string_starts_with(var_5[0], "select")) {
          continue;
        }
      }

      if(var_5.size == 2) {
        var_2[var_5[0]] = int(var_5[1]);
        continue;
      }

      var_2[var_5[0]] = 0;
    }

    return var_2;
  }

  return undefined;
}

_id_A106(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("mine_planted");
  scripts\engine\utility::_id_10888(var_0, "joined_team", var_0, "joined_spectators", var_0, "disconnect", level, "prematch_cleanup");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_C87A() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(var_2.basename == "s4_me_rindigoww_mp") {
      return "wm_shield_demonic_zm_200";
    }
  }

  return "wm_shield_00";
}

_id_D5B0() {
  self._id_7D32 = 1;
}

_id_3945() {
  self._id_7D32 = undefined;
}

_id_897E(var_0) {
  if(_id_879A(var_0) || _id_879C(var_0)) {
    var_1 = undefined;

    if(isweapon(var_0)) {
      var_1 = getcompleteweaponname(var_0 _meth_8628());
    } else if(_func_0121(var_0)) {
      var_1 = var_0;

      if(issubstr(var_1, "alt_")) {
        var_1 = _func_00D6(var_1, 4, var_0.size);
      }
    }

    var_2 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var_1;
    var_3 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var_1;

    if(!var_2 && !var_3) {
      return 1;
    }
  }

  return 0;
}

_id_8AFA(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "bradley_tow_proj_mp":
    case "lighttank_mp":
    case "lighttank_tur_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "tur_apc_rus_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mp":
    case "technical_mp":
      return 1;
    default:
      return 0;
  }
}

_id_1DB3(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_id_1D9D(var_4, var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1D9D(var_0, var_1) {
  if(scripts\cp\utility::_id_1D98(var_0)) {
    return 0;
  }

  if(!_id_1D9B(var_1, var_0)) {
    return 0;
  }

  if(scripts\engine\utility::string_starts_with(var_0, "laststand_")) {
    return 0;
  }

  return 1;
}

_id_1D9B(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponrootname(var_0);
  var_3 = level._id_10D64[var_2];
  return isDefined(var_3) && isDefined(var_3[var_1]);
}

_id_C323(var_0) {
  switch (var_0) {
    case "laserbalanced":
    case "laserRange":
    case "laserads":
      var_0 = "laser";
      break;
    case "barsil2":
    case "silencer4":
    case "silencer3":
    case "silencer2":
    case "barsil":
      var_0 = "silencer";
      break;
    case "barcustnoguard":
    case "barcust2":
    case "barcust":
    case "barshortnoguard":
    case "barmid":
    case "barshort":
    case "barlong":
      var_0 = "barlong";
      break;
  }

  return var_0;
}

_id_9ACB(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_0)) {
    var_3 = makeweapon("none");
  }

  var_4 = 0;

  if(var_3.basename != "none") {
    switch (var_3.basename) {
      case "pop_rocket_proj_mp":
        var_3 = makeweapon("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        var_3 = makeweapon("iw8_turret_50cal_mp");
        break;
      case "tur_bradley_mp":
      case "tur_gun_lighttank_mp":
        var_3 = makeweapon("lighttank_tur_mp");
        break;
      case "tur_gun_lighttank_ks_mp":
      case "tur_bradley_ks_mp":
        var_3 = makeweapon("lighttank_tur_ks_mp");
        break;
      case "ks_remote_drone_mp":
        var_3 = makeweapon("none");
        break;
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_1.objweapon)) {
      var_3 = makeweapon(var_1.objweapon.basename);
      var_4 = 1;
    } else if(isDefined(var_1.weapon_name)) {
      var_3 = makeweapon(var_1.weapon_name);
      var_4 = 1;
    }
  }

  if(var_4 && !istrue(var_2)) {
    var_3 = _id_9ACB(var_3, var_1, 1);
  }

  return var_3;
}

ismeleeweapon(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return 0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return 0;
  }

  if(isDefined(var_0._id_0241) && var_0._id_0241 == "model_only") {
    return 0;
  }

  if(isDefined(var_0.basename) && issubstr(var_0.basename, "s4_me_")) {
    return 1;
  } else {
    return 0;
  }
}

_id_FC24(var_0, var_1) {
  if(weaphasreactivecamo(var_1)) {
    _id_392A(_func_00ED(var_1));
  }

  _id_CA28(var_0);
}

_id_CA28(var_0) {
  if(!getdvarint("#x3b1d87d8e0b53e10", 1) || !self _meth_86EE()) {
    return;
  }
  if(weaphasreactivecamo(var_0)) {
    thread reactivecamo(var_0);
    thread devreactivecamo(var_0);
  } else
    self setscriptablepartstate("activeCamo", "no_stage");
}

_id_392A(var_0) {
  self notify("endReactiveCamoThread");
  self setscriptablepartstate("activeCamo", "no_stage");
}

reactivecamoresetwhenprematchdone() {
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1.reactivecamoweapons)) {
      foreach(var_3 in var_1.reactivecamoweapons) {
        var_3._id_0267 = 0;

        if(var_3.stage > 0) {
          reactivecamosetstage(var_3, 0, 0);
        }
      }
    }
  }
}

reactivecamosetstage(var_0, var_1, var_2) {
  var_0.stage = var_1;

  if(var_2 == 1) {
    self setscriptablepartstate("activeCamo", "stage" + var_0.stage);
  } else {
    self setscriptablepartstate("activeCamo", "init_stage" + var_0.stage);
  }
}

reactivecamoinittostage(var_0, var_1, var_2) {
  var_3 = weapongetreactivecamolookup(var_0);
  reactivecamosetup(var_3);
  var_4 = self.reactivecamoweapons[var_3];

  if(var_2 != self) {
    var_4.laststage = var_4.stage;
    var_4.lastkills = var_4._id_0267;
    thread reactivecamowatchdeath(var_4);
  }

  reactivecamosetstage(var_4, var_1, 0);
}

reactivecamoresetweapon(var_0) {
  var_0.stage = var_0.laststage;
  var_0._id_0267 = var_0.lastkills;
}

reactivecamodropweapon(var_0, var_1) {
  if(!weaphasreactivecamo(var_1)) {
    return;
  }
  cachereactivecamostageonweaponitem(var_0, var_1);

  if(isDefined(var_0.owner) && var_0.owner != self) {
    var_2 = weapongetreactivecamolookup(var_1);

    if(isDefined(self.reactivecamoweapons)) {
      var_3 = self.reactivecamoweapons[var_2];

      if(isDefined(var_3) && isDefined(var_3.lastkills) && isDefined(var_3.laststage)) {
        reactivecamoresetweapon(var_3, var_1);
      }
    }
  }
}

reactivecamowatchdeath(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  self waittill("death");

  if(self hasweapon(var_1)) {
    reactivecamoresetweapon(var_0);
  }
}

reactivecamowatchgesturenotetracks(var_0) {
  self endon("disconnect");
  self.reactivecamocurprocgestures = [];

  if(!isDefined(level.reactivecamoexcludedgestures)) {
    level.reactivecamoexcludedgestures = [];
  }

  scripts\engine\utility::array_add(self.handledreactivecamontweapons, var_0);

  for(;;) {
    if(!self hasweapon(var_0)) {
      scripts\engine\utility::array_remove(self.handledreactivecamontweapons, var_0);
      return;
    }

    if(!self _meth_84B7() && !self _meth_887C() || var_0 != self getcurrentweapon()) {
      waitframe();
      continue;
    }

    if(self _meth_84B7()) {
      var_1 = self _meth_84AE();

      foreach(var_3 in var_1) {
        if(scripts\engine\utility::array_contains(self.reactivecamocurprocgestures, var_3) || scripts\engine\utility::array_contains(level.reactivecamoexcludedgestures, var_3)) {
          waitframe();
          continue;
        }

        var_4 = self _meth_8879(var_3, "rac_");

        if(var_4.size > 0) {
          var_5 = self _meth_887A(var_3);
          var_6 = self _meth_8495(var_3);

          if(var_5 > var_6 * 0.75) {
            waitframe();
            continue;
          }

          thread end_watcher_gesture(var_3);
          thread reactivecamonotetrackwatcher(var_4, var_0, var_5, var_6, var_3);
          continue;
        }

        level.reactivecamoexcludedgestures = scripts\engine\utility::array_add(level.reactivecamoexcludedgestures, var_3);
      }
    } else if(self _meth_887C()) {
      if(scripts\engine\utility::array_contains(self.reactivecamocurprocgestures, var_0.basename) || scripts\engine\utility::array_contains(level.reactivecamoexcludedgestures, var_0.basename)) {
        waitframe();
        continue;
      }

      var_4 = self _meth_887F("rac_");

      if(var_4.size > 0) {
        var_8 = self _meth_887D();
        var_9 = self _meth_887E();

        if(var_8 > var_9 * 0.75) {
          waitframe();
          continue;
        }

        thread end_watcher_inspect(var_0.basename);
        thread reactivecamonotetrackwatcher(var_4, var_0, var_8, var_9, var_0.basename);
      } else
        level.reactivecamoexcludedgestures = scripts\engine\utility::array_add(level.reactivecamoexcludedgestures, var_0.basename);
    }

    waitframe();
  }
}

end_watcher_gesture(var_0) {
  while(self _meth_84B7(var_0)) {
    waitframe();
  }

  self notify("cancel_reactive_watcher");
  self.reactivecamocurprocgestures = scripts\engine\utility::array_remove(self.reactivecamocurprocgestures, var_0);
}

end_watcher_inspect(var_0) {
  while(istrue(self _meth_887C())) {
    waitframe();
  }

  self notify("cancel_reactive_watcher");
  self.reactivecamocurprocgestures = scripts\engine\utility::array_remove(self.reactivecamocurprocgestures, var_0);
}

reactivecamonotetrackcomparefunc(var_0, var_1) {
  return var_0._id_110F4 < var_1._id_110F4;
}

reactivecamonotetrackwatcher(var_0, var_1, var_2, var_3, var_4) {
  self endon("cancel_reactive_watcher");
  self.reactivecamocurprocgestures = scripts\engine\utility::array_add(self.reactivecamocurprocgestures, var_4);
  var_0 = scripts\engine\utility::_id_1BD6(var_0, ::reactivecamonotetrackcomparefunc);
  var_5 = 0.0;

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_7._id_110F4 * var_3 < var_2) {
      reactivecamoprocessnotetrack(var_7.name, var_1);
      continue;
    }

    break;
  }

  var_5 = var_2;

  for(var_8 = var_6; var_8 < var_0.size; var_8++) {
    var_9 = var_0[var_8]._id_110F4 * var_3;
    wait(var_9 - var_5);
    var_5 = var_9;
    reactivecamoprocessnotetrack(var_0[var_8].name, var_1);
  }

  wait(var_3 - var_5);
  self.reactivecamocurprocgestures = scripts\engine\utility::array_remove(self.reactivecamocurprocgestures, var_4);
}

reactivecamoprocessnotetrack(var_0, var_1) {
  var_2 = getreactivecamostagecount(var_1);
  var_3 = getreactivecamostage(var_1);
  var_4 = 0;
  var_0 = _func_00D6(var_0, 4);
  var_5 = strtok(var_0, ",");

  if(var_5[0] == "increment") {
    if(var_5.size > 1 && var_5[1] == "cyclical") {
      var_3 = (var_3 + 1) % var_2;
      var_4 = 2;
    } else {
      var_3 = int(min(var_3 + 1, var_2 - 1));
      var_4 = 1;
    }
  } else if(var_5[0] == "set" && var_5.size > 1) {
    var_3 = int(var_5[1]);
    var_3 = int(clamp(var_3, 0, var_2));
    var_4 = 2;
  }

  var_6 = 0;

  if(var_5.size > var_4) {
    var_6 = int(var_5[var_4]) == 1;
  }

  setreactivecamostage(var_1, var_3, var_6);
}

reactivecamosetup(var_0) {
  if(!isDefined(self.reactivecamoweapons)) {
    self.reactivecamoweapons = [];
  }

  if(!isDefined(self.reactivecamoweapons[var_0])) {
    self.reactivecamoweapons[var_0] = spawnStruct();
    self.reactivecamoweapons[var_0]._id_0267 = 0;
    self.reactivecamoweapons[var_0].stage = 0;
    self.reactivecamoweapons[var_0].owner = self;
  }
}

cachereactivecamostageonweaponitem(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(weaphasreactivecamo(var_1)) {
    var_2 = getreactivecamostage(var_1);

    if(var_2 >= 0) {
      var_0.reactivecamoindex = var_2;

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }
    }
  }
}

getreactivecamostage(var_0) {
  if(!isDefined(var_0) || !isDefined(self.reactivecamoweapons)) {
    return -1;
  }

  var_1 = weapongetreactivecamolookup(var_0);

  if(!isDefined(self.reactivecamoweapons[var_1])) {
    return -1;
  }

  return self.reactivecamoweapons[var_1].stage;
}

setreactivecamostage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = weapongetreactivecamolookup(var_0);
  reactivecamosetup(var_3);
  var_4 = self.reactivecamoweapons[var_3];
  reactivecamosetstage(var_4, var_1, var_2);
}

getreactivecamostagecount(var_0) {
  var_1 = var_0 _meth_8876();
  return var_1.size;
}

reactivecamo(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endReactiveCamoThread");

  if(!isDefined(level.reactivecamoprematchthreadstarted) && !_id_07D1::_id_60BE("prematch_done")) {
    level.reactivecamoprematchthreadstarted = 1;
    level thread reactivecamoresetwhenprematchdone();
  }

  var_1 = weapongetreactivecamolookup(var_0);
  reactivecamosetup(var_1);

  if(!isDefined(self.handledreactivecamontweapons)) {
    self.handledreactivecamontweapons = [];
  }

  if(!scripts\engine\utility::array_contains(self.handledreactivecamontweapons, var_0)) {
    thread reactivecamowatchgesturenotetracks(var_0);
  }

  var_2 = self.reactivecamoweapons[var_1];
  reactivecamosetstage(var_2, var_2.stage, 0);
  var_3 = var_0 _meth_8876();
  var_4 = int(var_3.size - 1);

  for(;;) {
    scripts\engine\utility::_id_108C5("on_ai_killed", "scr_advancereactivecamo");
    var_5 = int(var_3[int(min(var_2.stage + 1, var_4))]);
    var_2._id_0267++;

    if(var_2._id_0267 == var_5) {
      reactivecamosetstage(var_2, var_2.stage + 1, 1);

      if(!self isswitchingweapon()) {}
    }
  }
}

devreactivecamo(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endReactiveCamoThread");

  if(!isDefined(level.reactivecamoprematchthreadstarted) && !_id_07D1::_id_60BE("prematch_done")) {
    level.reactivecamoprematchthreadstarted = 1;
    level thread reactivecamoresetwhenprematchdone();
  }

  var_1 = weapongetreactivecamolookup(var_0);
  reactivecamosetup(var_1);

  for(;;) {
    self waittill("scr_resetreactivecamo");
    var_2 = self.reactivecamoweapons[var_1];
    var_2._id_0267 = 0;
    var_2.stage = 0;
    reactivecamosetstage(var_2, var_2.stage, 0);
  }
}

weapongetreactivecamolookup(var_0) {
  return var_0.basename + "_v" + var_0._id_04CC;
}

weaphasreactivecamo(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_04CC)) {
    return 0;
  }

  return var_0 _meth_8875();
  return 0;
}