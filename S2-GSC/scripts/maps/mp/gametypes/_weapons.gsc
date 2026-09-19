/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_weapons.gsc
**************************************************/

init() {
  setdvarifuninitialized("trailer_disable_intro_filter", 0);
  setdvarifuninitialized("trailer_disable_helmet_pop", 0);
  setdvarifuninitialized("trailer_allow_custom_outfits", 0);
  setdvarifuninitialized("trailer_plane_gunner_height", -1);
  setdvarifuninitialized("spv_enableAttachmentStats", 0);

  if(!maps\mp\_utility::_id_585F() && !_func_367())
    level thread _id_04EB::_id_52A9();

  level._id_808B = 1;
  level._id_808C = 1;

  if(!maps\mp\_utility::_id_585F())
    level._id_6092 = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives", 2), 1);

  level._id_7EA4 = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets", 15);
  _func_0F8("DogsDontAttack");
  _func_0F8("Dogs");
  _func_0FF("DogsDontAttack", "Dogs");

  switch (maps\mp\_utility::getintproperty("perk_scavengerMode", 0)) {
    case 1:
      level._id_808B = 0;
      break;
    case 2:
      level._id_808C = 0;
      break;
    case 3:
      level._id_808B = 0;
      level._id_808C = 0;
      break;
  }

  var_0 = maps\mp\_utility::_id_4427();
  var_0 = common_scripts\utility::alphabetize(var_0);
  thread maps\mp\_flashgrenades::main();
  thread _id_0479::init();

  if(!isDefined(level._id_585D) || !level._id_585D)
    thread _id_048A::init();

  if(!isDefined(level._id_A9C5))
    level._id_A9C5 = ::_id_34B7;

  var_1 = 70;
  level._id_2330 = _func_0A7(var_1);
  level._id_2332 = 20;
  level._id_2331 = 0.75;
  level._id_2333 = 192;
  level._id_396A = 0.15;
  level._id_396C = 100;
  level._id_396B = 30;
  level._id_3968 = 150;
  level._id_3967 = 150;
  level._id_3966 = 0.25;
  level._id_3972 = 7;

  if(!isDefined(level._id_585D) || !level._id_585D) {
    level._id_61E0 = 0.3;
    level._id_61E2 = 100;
    level._id_61E1 = 20;
    level._id_61DE = 175;
    level._id_61DC = 70;
    level._id_61DB = 200;
    level._id_61D9 = 46;
    level._id_61EF = 120;
    level._id_61CC = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
    level._id_61CF = loadfx("vfx/dust/bouncing_betty_swirl");
    level._id_61C8 = loadfx("vfx/explosion/bouncing_betty_explosion");
    level._id_61C2["enemy"] = loadfx("vfx/lights/light_c4_blink");
    level._id_61C2["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
  }

  if(!isDefined(level._id_585D) || !level._id_585D) {
    level._effect["mine_stunned"] = loadfx("vfx/sparks/emp_drone_damage");
    level._effect["signal_flare"] = loadfx("vfx/smoke/signal_flare_volumetric_runner_blinded");
    level._effect["signal_flare_friendly_tacmask"] = loadfx("vfx/smoke/signal_flare_volumetric_runner");
    level._effect["sentry_explode_mp"] = loadfx("vfx/explosion/remote_sentry_death");
    level._effect["sentry_smoke_mp"] = loadfx("vfx/explosion/remote_sentry_death_smoke");
    level._effect["trophy_detonation"] = loadfx("vfx/explosion/remote_sentry_death_smoke");
    level._effect["fire_lp_s_base_calm"] = loadfx("vfx/fire/fire_lp_s_base_calm");
    level._effect["sticky_grenade_splat"] = loadfx("vfx/weaponimpact/sticky_grenade_splat");
    level._effect["perception_glow"] = loadfx("vfx/ui/ui_role_ability_overlay_yellow");
    level._effect["divisions_bayonet_charge"] = loadfx("vfx/divisions/fx_divisions_rifle_bayont_charge_1p");
    level._effect["divisions_sniper"] = loadfx("vfx/divisions/divisions_sniper");
    level._effect["tactical_insertion_beacon_ally"] = loadfx("vfx/test/beacon_smoke_tac_insert_ally");
    level._effect["tactical_insertion_beacon_enemy"] = loadfx("vfx/test/beacon_smoke_tac_insert_enemy");
    level._effect["tactical_insertion_cavalry_ally"] = loadfx("vfx/test/mp_cav_tac_insert_ally");
    level._effect["tactical_insertion_cavalry_enemy"] = loadfx("vfx/test/mp_cav_tac_insert_enemy");
    level._effect["tactical_insertion_cavalry_ally_parachuting"] = loadfx("vfx/test/mp_cav_tac_insert_ally_parachuting");
    level._effect["tactical_insertion_cavalry_enemy_parachuting"] = loadfx("vfx/test/mp_cav_tac_insert_enemy_parachuting");
    level._effect["faster_health_regen_sweep"] = loadfx("vfx/unique/mp_fast_health_regen");
    level._effect["mp_dlc4_3rd_person_serum_orange"] = loadfx("vfx/map/mp_raid_dlc4/mp_dlc4_3rd_person_serum_orange");
    level._effect["mp_dlc4_1st_person_serum_orange"] = loadfx("vfx/map/mp_raid_dlc4/mp_dlc4_1st_person_serum_orange");
  }

  if(!_func_367())
    level._effect["blood_pool"] = loadfx("vfx/blood/blood_pool_mp");

  level._id_2CE8 = 1.8;
  level.delayshortminetime = 0.9;
  level.shortminetime = 0.2;
  level._id_2CBD = 0.5;
  level.shortdelayc4armtime = 0.5;
  level._id_83E5 = loadfx("vfx/test/test_fx");
  level._id_93A7 = loadfx("vfx/test/test_fx");
  level._id_76F2 = [];
  level._id_8C3B = [];
  level._id_4852 = [];
  level._id_6237 = [];
  level._id_54FC = [];
  level._id_61ED = [];
  level._id_9DCB = [];

  if(!maps\mp\_utility::_id_551F() && !_func_367()) {
    if(!isDefined(level._id_585D) || !level._id_585D)
      level._effect["equipment_explode"] = loadfx("vfx/explosion/sparks_burst_lrg_c");

    level._effect["sniperDustLarge"] = loadfx("vfx/dust/sniper_dust_kickup");
    level._effect["sniperDustLargeSuppress"] = loadfx("vfx/dust/sniper_dust_kickup_accum_suppress");
  }

  level thread onplayerconnect();
  level._id_1DF7 = 0;
  common_scripts\utility::_id_0FB2(getEntArray("misc_turret", "classname"), ::_id_9F3A);
  thread turret_spawned_turrets_overheat();
  _id_0512::_id_5285();
}

_id_92BA(var_0, var_1) {}

_id_27D0(var_0, var_1, var_2) {
  var_3 = spawn("script_model", level._id_5FEB);
  var_3 _meth_805C();
  waitframe();

  if(isDefined(self) && isDefined(var_3)) {
    var_3 thread _id_1908(var_2);
    var_3 setModel(var_0);
    var_3 _meth_8055(self, var_1, (0, 0, 0), (0, 0, 0));
    var_3 _meth_80B1();
    var_3 _meth_8013(0);
    self waittill("death");

    if(isDefined(self._id_9D65))
      self._id_9D65 delete();
  }

  if(isDefined(var_3))
    var_3 delete();
}

_id_1908(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.team;
  _id_21AD(var_0, var_1);

  for(;;) {
    level common_scripts\utility::_id_A70A("joined_team", "player_spawned", "changed_kit", "update_bombsquad");

    if(!isDefined(self)) {
      return;
    }
    self _meth_805C();
    _id_21AD(var_0, var_1);
  }
}

_id_21AD(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(level.teambased) {
      if(!isDefined(var_3.team) || var_3.team == "spectator") {
        continue;
      }
      if(var_3.team != var_1 && var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
        self _meth_8005(var_3);

      continue;
    }

    if(isDefined(var_0) && var_3 == var_0) {
      continue;
    }
    if(!var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
      continue;
    }
    self _meth_8005(var_3);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_4DDE = 0;
    var_0._id_57CF = 0;
    maps\mp\gametypes\_gamelogic::_id_869D(var_0, 0);

    if(!maps\mp\_utility::_id_551F() && !_func_367())
      var_0 thread _id_8EC8();

    var_0 thread onplayerspawned();
    var_0 thread _id_A92B();
    var_0 thread maps\mp\_flashgrenades::_id_92E8();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("spawned_player", "faux_spawn");
    self._id_2954 = self getcurrentweapon();
    self _meth_85BD(0);
    self _meth_85BE(1);
    self._id_35EF = 0;
    self._id_2577 = 0;
    self._id_4DDE = 0;
    maps\mp\gametypes\_gamelogic::_id_869D(self, 0);

    if(!isDefined(self._id_9BBB)) {
      self._id_9BBB = "";
      self._id_9BBB = "none";
      self._id_9BBC = 0;
      self._id_9BBA = 0;
      self._id_9BB9 = 0;
      self._id_9BB7 = 0;
      self._id_9BB8 = 0;
      self._id_9BB6 = 0;
      self.trackingweaponassists = 0;
      self.trackingweaponmultikills = 0;
      self._id_9BBD = 0;
    }

    thread _id_A938();
    thread _id_A944();
    thread _id_A941();
    thread _id_A920();
    thread _id_A959();
    thread _id_A918();
    thread _id_A8E9();

    if(!(isDefined(level._id_585D) && level._id_585D) || _func_1EF(self))
      thread _id_048A::_id_9BC6();

    if(!_func_367())
      thread _id_047E::_id_3D93();

    thread _id_A917();

    if(isDefined(level._id_6B83))
      self thread[[level._id_6B83]]();

    self._id_5BA9 = [];
    self._id_34A0 = undefined;
    self._id_9A8D = [];
    self.tookweaponkillweapon = [];
    self._id_6FBA = [];
    thread _id_A957();
    thread divisionabilitypromptupdateondeath();
    thread _id_5C12();
    thread lastdivisiontimesusageupdateondeath();
    thread _id_A945();
    thread _id_A91A();
    self._id_2954 = undefined;
    self._id_9DD6 = undefined;
    thread _id_9B90();

    if(!isDefined(self._id_9070))
      self._id_9070 = spawnStruct();

    self._id_9070._id_29BA = 0;
    self._id_9070._id_29D9 = 0;
    self._id_9070._id_9CFD = 0;

    if(!isDefined(self._id_6870))
      self._id_6870 = 0;

    self._id_6870++;

    if(_func_1EF(self)) {
      continue;
    }
    if(isDefined(self._id_3959))
      self._id_3959 = undefined;

    level notify("log_player_spawn_data", self);
    thread _id_62FE();
    thread _id_6302();
  }
}

_id_8EC8() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = undefined;

  for(;;) {
    self waittill("weapon_fired");

    if(self _meth_8178() != "prone") {
      continue;
    }
    if(maps\mp\_utility::getweaponclass(self getcurrentweapon()) != "weapon_sniper") {
      continue;
    }
    var_1 = anglesToForward(self.angles);

    if(!isDefined(var_0) || gettime() - var_0 > 2000) {
      playFX(level._effect["sniperDustLarge"], self.origin + (0, 0, 10) + var_1 * 50, var_1);
      var_0 = gettime();
      continue;
    }

    playFX(level._effect["sniperDustLargeSuppress"], self.origin + (0, 0, 10) + var_1 * 50, var_1);
  }
}

_id_469C(var_0, var_1) {
  var_2 = "";

  if(self.team == "axis")
    var_2 = var_2 + "AX_";
  else
    var_2 = var_2 + "AL_";

  if(self _meth_843D())
    var_2 = var_2 + "w";

  if(var_1 > 1) {
    var_2 = var_2 + _func_0A4(0, var_1);
    var_2 = var_2 + "_";
  } else
    var_2 = var_2 + "0_";

  var_2 = var_2 + var_0;
  return var_2;
}

_id_A947() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("sprint_melee_charge_begin");

    if(issubstr(self getcurrentweapon(), "shield_charge")) {
      self _meth_82FF("ui_show_shield_charge_ability_prompt", 0);
      self.shieldchargeactive = 1;
    } else
      self _meth_82FF("ui_show_division_rifle_ability_prompt", 0);

    _id_04CB::_id_3657(self._id_0079, _id_04CA::_id_461C(0));
    self._id_165B = 1;
    _id_A13B();
  }
}

_id_A946() {
  self endon("disconnect");
  self endon("death");

  for(;;)
    self waittill("sprint_melee_charge_attack", var_0);
}

_id_A949() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("sprint_melee_charge_end");
    _id_04CB::_id_2F7B(self._id_0079, _id_04CA::_id_461C(0));
    self._id_165B = 0;
    self.shieldchargeactive = 0;
    _id_A13B();
  }
}

_id_A948() {
  self endon("disconnect");
  self endon("death");

  for(;;)
    self waittill("sprint_melee_charge_cooldown_finished");
}

_id_A945() {
  self._id_165B = 0;
  self.shieldchargeactive = 0;
  _id_A13B();
  thread _id_A947();
  thread _id_A946();
  thread _id_A949();
  thread _id_A948();
}

_id_A91B() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self._id_3D9C = 0;

  for(;;) {
    self waittill("hold_breath_begin");

    if(isDefined(self._id_0079) && (_func_367() || self._id_0079 != 5)) {
      var_0 = _id_04CA::_id_461C(3);

      if(var_0 == "sharpshooter_level1" || var_0 == "sharpshooter_level2" || var_0 == "sharpshooter_level3") {
        _id_04CB::_id_3657(3, var_0);
        self _meth_82FF("ui_show_division_sniper_ability_prompt", 0);
        self._id_8AE0 = 1;
      }

      continue;
    }

    if(isDefined(level._id_585D) && level._id_585D) {
      self _meth_82FF("ui_show_division_sniper_ability_prompt", 0);
      self._id_8AE0 = 1;
    }
  }
}

_id_A91D() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self._id_3D9B = 0;

  for(;;) {
    self waittill("hold_breath_end");

    if(isDefined(self._id_0079) && (_func_367() || self._id_0079 != 5)) {
      var_0 = _id_04CA::_id_461C(3);

      if(var_0 == "sharpshooter_level1" || var_0 == "sharpshooter_level2" || var_0 == "sharpshooter_level3") {
        _id_04CB::_id_2F7B(3, var_0, undefined, 0);
        self._id_8AE0 = 0;
      }

      continue;
    }

    if(isDefined(level._id_585D) && level._id_585D)
      self._id_8AE0 = 0;
  }
}

_id_A91C() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("faux_spawn");
  self waittill("death");
  self _meth_82FF("ui_show_division_sniper_ability_prompt", 0);
}

_id_A91A() {
  self._id_8AE0 = 0;
  self _meth_82FF("ui_hide_hud", 0);
  thread _id_A91B();
  thread _id_A91D();
  thread _id_A91C();
}

_id_5C12() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  _id_A196();
}

lastdivisiontimesusageupdateondeath() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  _id_04CA::updatedivisionusagestats();
  self.divisionusageindex = undefined;
}

divisionabilitypromptupdateondeath() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  self _meth_82FF("ui_dragon_breath_state", -1);
  self _meth_82FF("ui_suppressor_state", -1);
  self _meth_82FF("ui_m30_rifle_state", -1);
  self _meth_82FF("ui_rifle_grenade_state", -1);
  self _meth_82FF("ui_resistance_state", -1);
  self _meth_82FF("ui_zk383_smg_state", -1);

  if(!isDefined(level._id_585D) || !level._id_585D) {
    self _meth_82FF("ui_show_division_shotgun_ability_prompt", 0);
    self _meth_82FF("ui_show_division_smg_ability_prompt", 0);
    self _meth_82FF("ui_show_division_resistance_ability_prompt", 0);
    self _meth_82FF("ui_show_rifle_grenade_ability_prompt", 0);
    self _meth_82FF("ui_show_m30_rifle_altmode_prompt", 0);
    self _meth_82FF("ui_show_zk383_smg_altmode_prompt", 0);
  }
}

_id_A957() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  thread _id_A94B();

  if(_id_60AE(self._id_2954))
    self._id_5B94 = self._id_2954;
  else
    self._id_5B94 = "none";

  var_0 = self getcurrentweapon();
  var_1 = 1;
  _id_534B();

  for(;;) {
    if(!var_1) {
      self waittill("weapon_change", var_2);

      if(isDefined(var_2))
        _id_A15E(var_2);

      if(maps\mp\_utility::_hasperk("specialty_class_shifty"))
        thread _id_052C::refillpistolmagazineonswitch();
    }

    var_1 = 0;
    var_0 = self getcurrentweapon();

    if(var_0 == "flamethrower_mp" || var_0 == "flamethrower_german_mp" || var_0 == "flamethrower_grenadier_mp" || var_0 == "flamethrower_german_grenadier_mp")
      self._id_A258 = 1;
    else
      self._id_A258 = 0;

    if(var_0 == "killstreak_molotov_cocktail_mp" || var_0 == "killstreak_molotov_cocktail_grenadier_mp")
      self._id_A25A = 1;
    else
      self._id_A25A = 0;

    if(issubstr(var_0, "riotshield_mp"))
      self.usingriotshield = 1;
    else
      self.usingriotshield = 0;

    if(issubstr(var_0, "dragon_breath")) {
      var_3 = _id_04CA::_id_461C(4);

      if(var_3 == "incendiary_level1" || var_3 == "incendiary_level2" || var_3 == "incendiary_level3") {
        if(issubstr(var_0, "alt+")) {
          self.pers["dragonBreathActive"] = 1;
          self _meth_82FF("ui_dragon_breath_state", 1);
          thread _id_6386();
        } else {
          self _meth_82FF("ui_dragon_breath_state", 0);
          self.pers["dragonBreathActive"] = 0;
        }

        if(self _meth_85EC() && isDefined(self._id_0079) && self._id_0079 != 5)
          self _meth_82FF("ui_show_division_shotgun_ability_prompt", 1);
      }
    } else if(!(self _meth_801D() && var_0 == "none" && issubstr(self._id_8061, "dragon_breath"))) {
      self _meth_82FF("ui_dragon_breath_state", -1);

      if(!isDefined(level._id_585D) || !level._id_585D)
        self _meth_82FF("ui_show_division_shotgun_ability_prompt", 0);
    }

    if(issubstr(var_0, "grenade_launcher")) {
      if(issubstr(var_0, "alt+")) {
        self.pers["rifleGrenadeActive"] = 1;
        self _meth_82FF("ui_rifle_grenade_state", 1);
        thread monitorriflegrenadeempty();
      } else {
        self _meth_82FF("ui_rifle_grenade_state", 0);
        self.pers["rifleGrenadeActive"] = 0;
      }

      if(self _meth_85EC())
        self _meth_82FF("ui_show_rifle_grenade_ability_prompt", 1);
    } else if(!(self _meth_801D() && var_0 == "none" && issubstr(self._id_8061, "grenade_launcher"))) {
      self _meth_82FF("ui_rifle_grenade_state", -1);

      if(!isDefined(level._id_585D) || !level._id_585D)
        self _meth_82FF("ui_show_rifle_grenade_ability_prompt", 0);
    }

    if(isDefined(self._id_0079) && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_smg" && issubstr(var_0, "suppressor")) {
      var_4 = _id_04CA::_id_461C(1);

      if(var_4 == "suppressor_level1" || var_4 == "suppressor_level2" || var_4 == "suppressor_level3") {
        if(maps\mp\_utility::_id_5670(var_0)) {
          self _meth_82FF("ui_suppressor_state", 1);
          self.pers["altModeActive"] = 1;
        } else {
          self _meth_82FF("ui_suppressor_state", 0);
          self.pers["altModeActive"] = 0;
        }
      } else
        self _meth_82FF("ui_suppressor_state", -1);
    } else
      self _meth_82FF("ui_suppressor_state", -1);

    if(issubstr(var_0, "m30_rifle")) {
      if(maps\mp\_utility::_id_5670(var_0))
        self _meth_82FF("ui_m30_rifle_state", 1);
      else
        self _meth_82FF("ui_m30_rifle_state", 0);
    } else
      self _meth_82FF("ui_m30_rifle_state", -1);

    if(issubstr(var_0, "zk383")) {
      if(maps\mp\_utility::_id_5670(var_0)) {
        self _meth_82FF("ui_zk383_smg_state", 1);
        self.pers["altModeActive"] = 1;
      } else {
        self _meth_82FF("ui_zk383_smg_state", 0);
        self.pers["altModeActive"] = 0;
      }
    } else
      self _meth_82FF("ui_zk383_smg_state", -1);

    if(var_0 == "none") {
      if(!isDefined(level._id_585D) || !level._id_585D) {
        self _meth_82FF("ui_show_division_smg_ability_prompt", 0);
        self _meth_82FF("ui_show_m30_rifle_altmode_prompt", 0);
        self _meth_82FF("ui_show_zk383_smg_altmode_prompt", 0);
      }

      continue;
    }

    var_5 = _func_061(var_0, 1);

    if(isDefined(var_0) && !maps\mp\_utility::_id_585F() && !maps\mp\_utility::privatematch() && isPlayer(self)) {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) || maps\mp\_utility::iscacsecondaryweapon(var_0)) {
        var_6 = maps\mp\_utility::_id_45B5(var_0);
        var_7 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_6, "kills");

        if(isDefined(var_7))
          self _meth_82A2(var_7);
        else {}
      }
    }

    self._id_4B45 = 0;
    self._id_4B2D = 0;
    self._id_4B47 = 0;
    self._id_4B20 = 0;

    if(isDefined(var_5)) {
      foreach(var_9 in var_5) {
        if(var_9 == "stock") {
          self._id_4B45 = 1;
          continue;
        }

        if(issubstr(var_9, "fmj")) {
          self._id_4B2D = 1;
          continue;
        }

        if(issubstr(var_9, "suppressor")) {
          self._id_4B47 = 1;
          continue;
        }

        if(issubstr(var_9, "akimbo")) {
          self._id_4B20 = 1;
          continue;
        }
      }
    }

    if(self._id_4B20)
      self _meth_82FF("ui_show_left_clip_ammo", 1);
    else
      self _meth_82FF("ui_show_left_clip_ammo", 0);

    if(self _meth_85EC() && isDefined(self._id_0079) && self._id_0079 != 5 && self._id_4B47 && maps\mp\_utility::getweaponclass(var_0) == "weapon_smg" && !issubstr(var_0, "zk383"))
      self _meth_82FF("ui_show_division_smg_ability_prompt", 1);
    else if(!isDefined(level._id_585D) || !level._id_585D)
      self _meth_82FF("ui_show_division_smg_ability_prompt", 0);

    if(self _meth_85EC() && issubstr(var_0, "m30_rifle"))
      self _meth_82FF("ui_show_m30_rifle_altmode_prompt", 1);
    else if(!isDefined(level._id_585D) || !level._id_585D)
      self _meth_82FF("ui_show_m30_rifle_altmode_prompt", 0);

    if(self _meth_85EC() && issubstr(var_0, "zk383"))
      self _meth_82FF("ui_show_zk383_smg_altmode_prompt", 1);
    else if(!isDefined(level._id_585D) || !level._id_585D)
      self _meth_82FF("ui_show_zk383_smg_altmode_prompt", 0);

    if(isDefined(self.hasuseweapon) && self.hasuseweapon) {
      continue;
    }
    if(maps\mp\_utility::iskillstreakweapon(var_0)) {
      if(_id_051E::_id_1F6E())
        self._id_20CC = undefined;

      continue;
    }

    var_11 = maps\mp\_utility::_id_4738(var_0);

    if(var_11[0] == "alt") {
      var_12 = getsubstr(var_0, 4);
      var_0 = var_12;
    }

    if(_id_60AE(var_0))
      self._id_5B94 = var_0;

    self._id_20CC = undefined;
  }
}

_id_6386() {
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(issubstr(var_0, "dragon_breath") && self _meth_8680()) {
      var_1 = "alt+" + var_0;

      if(self _meth_8319(var_1)) {
        var_2 = self getweaponammoclip(var_1);
        var_2 = var_2 + self getweaponammostock(var_1);

        if(var_2 == 0) {
          self _meth_82FF("ui_dragon_breath_state", 0);
          return;
        }
      }
    }
  }
}

monitorriflegrenadeempty() {
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(issubstr(var_0, "grenade_launcher") && self _meth_8680()) {
      var_1 = "alt+" + var_0;

      if(self _meth_8319(var_1)) {
        var_2 = self getweaponammoclip(var_1);
        var_2 = var_2 + self getweaponammostock(var_1);

        if(var_2 == 0) {
          self _meth_82FF("ui_rifle_grenade_state", 0);
          return;
        }
      }
    }
  }
}

_id_A94B() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self._id_20CC = undefined;

  for(;;) {
    self waittill("weapon_switch_started", var_0);
    self _meth_82FF("ui_show_left_clip_ammo", 0);
    thread _id_5FBC(self getcurrentweapon());
    self._id_20CC = var_0;

    if(var_0 == "none" && isDefined(self._id_56A1) && self._id_56A1) {
      while(self._id_56A1)
        waitframe();

      self._id_20CC = undefined;
    }
  }
}

_id_5FBC(var_0) {
  self endon("weapon_switch_started");
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  if(!_id_051E::_id_1F6E()) {
    return;
  }
  wait 1.0;

  if(self._id_4B20)
    self _meth_82FF("ui_show_left_clip_ammo", 1);

  self._id_20CC = undefined;
}

_id_60AE(var_0) {
  if(var_0 == "none")
    return 0;

  if(issubstr(var_0, "uav"))
    return 0;

  if(issubstr(var_0, "killstreak"))
    return 0;

  if(issubstr(var_0, "riotshield"))
    return 0;

  if(maps\mp\_utility::getweaponclass(var_0) == "weapon_projectile" && maps\mp\_utility::_id_45B5(var_0) != "dp28_mp")
    return 0;

  var_1 = weaponinventorytype(var_0);

  if(var_1 != "primary")
    return 0;

  if(issubstr(var_0, "combatknife") || issubstr(var_0, "underwater"))
    return 0;

  return 1;
}

_id_34B7(var_0, var_1, var_2) {
  if(!maps\mp\_utility::isusingremote())
    waittillframeend;

  if(isDefined(level._id_17EF)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_34A0)) {
    return;
  }
  if(level._id_5139) {
    return;
  }
  var_3 = self._id_5B94;

  if(!isDefined(var_3)) {
    return;
  }
  if(var_3 == "none") {
    return;
  }
  if(!self _meth_8319(var_3)) {
    return;
  }
  if(isDefined(level._id_3FC7) && !self[[level._id_3FC7]](var_3)) {
    return;
  }
  var_3 = _func_36D(var_3, "alt+");

  if(var_3 != "riotshield_mp") {
    if(!self _meth_82FE(var_3)) {
      return;
    }
    var_4 = self getweaponammoclip(var_3, "right");
    var_5 = self getweaponammoclip(var_3, "left");

    if(common_scripts\utility::_id_562E(self.pers["dragonBreathActive"]) && issubstr(var_3, "dragon_breath")) {
      var_6 = int(_func_0AF(self getweaponammoclip("alt+" + var_3, "right"), self getweaponammostock(var_3)));
      var_7 = int(_func_0AF(self getweaponammoclip("alt+" + var_3, "left"), max(self getweaponammostock(var_3) - var_6, 0)));
      var_4 = int(_func_0AF(var_4 + var_6, _func_1D5(var_3)));
      var_5 = int(_func_0AF(var_5 + var_7, _func_1D5(var_3)));
      self setweaponammostock(var_3, self getweaponammostock(var_3) - (var_6 + var_7));
    }

    if(!var_4 && !var_5) {
      return;
    }
    var_8 = self getweaponammostock(var_3);
    var_9 = _func_1D6(var_3);

    if(var_8 > var_9)
      var_8 = var_9;

    var_10 = getdvarint("g_physicsWeaponDropScripted", 1);
    var_11 = undefined;
    var_12 = 0;

    if(var_10 && var_1 != "MOD_SUICIDE" && (!isDefined(var_0) || self != var_0)) {
      var_13 = self _meth_8430();

      if(isDefined(var_13)) {
        var_14 = var_13 _meth_801E();

        if(isDefined(var_14)) {
          var_15 = _func_083(var_14, 0, 0.5);
          var_16 = anglesToForward((0, var_13.angles[1], 0));
          var_17 = 0;

          if(maps\mp\_utility::_id_5755(var_1))
            var_17 = _func_0A4(1, 3);
          else if(maps\mp\_utility::_id_5695(var_1))
            var_17 = _func_0A4(3, 5);
          else if(maps\mp\_utility::isexplosivedamage(var_1))
            var_17 = _func_0A4(20, 40);
          else
            var_17 = _func_0A4(1, 10);

          var_18 = var_15[0] * var_17;
          var_19 = var_15[1] * var_17;
          var_20 = var_15[2] * var_17;
          var_11 = self _meth_8247(var_3, (var_18, var_19, var_20), var_13.angles);
          var_12 = 1;
        }
      }
    }

    if(!var_12) {
      var_11 = self _meth_8247(var_3);
      var_12 = 1;
    }

    if(!isDefined(var_11)) {
      return;
    }
    if(maps\mp\_utility::_id_5755(var_1))
      var_11.origin = (var_11.origin[0], var_11.origin[1], var_11.origin[2] - 5);

    var_11 _meth_817E(var_4, var_8, var_5);
  } else {
    var_11 = self _meth_8247(var_3);

    if(!isDefined(var_11)) {
      return;
    }
    var_11 _meth_817E(1, 1, 0);
  }

  self._id_34A0 = 1;

  if(_id_048A::_id_A9C9(var_3))
    self _meth_84D2();

  var_11._id_0117 = self;
  var_11._id_6DAF = var_0;
  var_11.ownersattackerweapon = var_2;
  var_11.targetname = "dropped_weapon";
  var_11 thread _id_A934();
  var_11 thread _id_2D45();

  if(isDefined(level.gamemodehandledroppedweapon))
    thread[[level.gamemodehandledroppedweapon]](var_11);
}

_id_2E42(var_0, var_1) {
  var_2 = self getattachsize();

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self getattachmodelname(var_3);

    if(var_4 != var_0) {
      continue;
    }
    var_5 = self getattachtagname(var_3);
    self detach(var_0, var_5);

    if(var_5 != var_1) {
      var_2 = self getattachsize();

      for(var_3 = 0; var_3 < var_2; var_3++) {
        var_5 = self getattachtagname(var_3);

        if(var_5 != var_1) {
          continue;
        }
        var_0 = self getattachmodelname(var_3);
        self detach(var_0, var_5);
        break;
      }
    }

    return 1;
  }

  return 0;
}

_id_2D45() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

_id_452C() {
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

_id_A934() {
  self endon("death");
  var_0 = _id_452C();
  var_1 = self._id_0117;

  for(;;) {
    self waittill("trigger", var_2, var_3, var_4, var_5, var_6);

    if(!isDefined(var_4) || !isDefined(var_5)) {
      continue;
    }
    if(var_4 == var_5) {
      if(var_4)
        return;
    } else
      break;
  }

  if(isDefined(var_0) && var_0 == var_2.primaryweapon) {
    return;
  }
  if(isDefined(var_0) && var_0 == var_2._id_835A) {
    return;
  }
  if(!_func_367() && (!isDefined(level._id_585D) || !level._id_585D) && isDefined(var_2._id_0079) && level.gametype != "br") {
    var_7 = var_0;
    var_0 = _id_04CB::_id_7CCD(var_0);
    var_0 = _id_04CB::_id_0995(var_2, var_2._id_0079, var_0, undefined, 1);

    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled() && isDefined(var_2._id_0079) && var_2._id_0079 == 6 && isDefined(var_2.pers["resistanceScramblerIndicatorActive"]))
      var_0 = _id_04CB::removealtmodeattachmentsfromweapon(var_0);

    if(var_7 != var_0) {
      var_8 = var_2 getweaponammoclip(var_7, "right");
      var_9 = var_2 getweaponammoclip(var_7, "left");
      var_10 = var_2 getweaponammostock(var_7);
      var_2 takeweapon(var_7);
      var_2 maps\mp\_utility::_giveweapon(var_0, 0, 0, var_6);
      var_2 setweaponammoclip(var_0, var_8, "right");
      var_2 setweaponammoclip(var_0, var_9, "left");
      var_2 setweaponammostock(var_0, var_10);
      var_2 switchtoweapon(var_0);
    }
  }

  var_2._id_6FBA[var_0] = undefined;
  var_2._id_9A8D[var_0] = undefined;
  var_2.tookweaponkillweapon[var_0] = undefined;
  var_2 notify("pickup_weapon", var_0);

  if(isDefined(var_2.pers["weaponPickupsCount"]))
    var_2.pers["weaponPickupsCount"]++;

  if(isDefined(var_1) && var_1 != var_2) {
    var_2._id_6FBA[var_0] = var_1;

    if(isDefined(self._id_6DAF) && self._id_6DAF == var_2) {
      var_2._id_9A8D[var_0] = var_1;

      if(isDefined(self.ownersattackerweapon))
        var_2.tookweaponkillweapon[var_0] = self.ownersattackerweapon;
    }
  }

  var_12 = "none";

  if(isDefined(var_3))
    var_12 = var_3 _id_452C();

  updateplayervariablesforweaponexchange(var_2, var_12, var_0);

  if(isDefined(var_3)) {
    var_3._id_0117 = var_2;
    var_3.targetname = "dropped_weapon";

    if(isDefined(var_2._id_6FBA[var_12])) {
      var_3._id_0117 = var_2._id_6FBA[var_12];
      var_2._id_6FBA[var_12] = undefined;
    }

    if(isDefined(var_2._id_9A8D[var_12])) {
      var_3._id_6DAF = var_2;
      var_2._id_9A8D[var_12] = undefined;
    }

    if(isDefined(var_2._id_9A8D[var_12])) {
      var_3.ownersattackerweapon = undefined;
      var_2._id_9A8D[var_12] = undefined;
    }

    var_3 thread _id_A934();
  }
}

updateplayervariablesforweaponexchange(var_0, var_1, var_2) {
  if(isDefined(var_0.primaryweapon) && (var_0.primaryweapon == "none" || var_0.primaryweapon == var_1))
    var_0.primaryweapon = var_2;
  else if(isDefined(var_0._id_835A) && (var_0._id_835A == "none" || var_0._id_835A == var_1))
    var_0._id_835A = var_2;
}

_id_586F() {
  var_0 = _id_452C();
  var_1 = weaponaltweaponname(var_0);

  for(var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++) {
    self _meth_817E(0, 0, 0, var_2);
    var_1 = weaponaltweaponname(var_1);
  }
}

_id_4AF1(var_0) {
  var_1 = self;

  if(var_1 != var_0._id_68FB._id_0117) {
    return;
  }
  var_0._id_68FB notify("scavenger");
  var_1 notify("scavenger_pickup");
  var_2 = var_0._id_68FB._id_7DFF;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = var_1 _meth_834A();

  if(var_8 != "none" && var_1 maps\mp\_utility::_hasperk("specialty_lethalresupply")) {
    var_9 = var_1 getweaponammoclip(var_8);

    if(_func_3AD(var_8) && (!isDefined(var_1._id_6088) || var_9 < var_1._id_6088)) {
      var_1 setweaponammoclip(var_8, var_9 + 1);

      if(var_9 == 0)
        var_1 notify("got_lethal_resupply");
    }

    var_3 = 1;
  }

  var_10 = var_1 getoffhandsecondaryclass();

  if(var_10 != "none" && var_1 maps\mp\_utility::_hasperk("specialty_tacticalresupply")) {
    var_9 = var_1 getweaponammoclip(var_10);

    if(!isDefined(var_1._id_60A0) || var_9 < var_1._id_60A0)
      var_1 setweaponammoclip(var_10, var_9 + 1);

    var_3 = 1;
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_scavenger")) {
    var_11 = var_1 getweaponlistprimaries();

    foreach(var_13 in var_11) {
      if(maps\mp\_utility::iscacprimaryweapon(var_13) || level._id_808C && maps\mp\_utility::iscacsecondaryweapon(var_13)) {
        var_14 = var_1 getweaponammostock(var_13);
        var_15 = 0;
        var_16 = maps\mp\_utility::getweaponclass(var_13);

        if(_id_5684(var_13) || var_16 == "weapon_riot" || issubstr(var_13, "riotshield")) {} else if(var_16 == "weapon_projectile" || issubstr(var_13, "exocrossbow") || issubstr(var_13, "microdronelauncher")) {
          if(var_2 && var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
            var_15 = _func_1A3(var_13);
        } else if(maps\mp\_utility::_id_5670(var_13) && issubstr(var_13, "grenade_launcher")) {
          if(var_2 && var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
            var_15 = _func_1A3(var_13);
        } else if(maps\mp\_utility::_id_5670(var_13) && issubstr(var_13, "dragon_breath")) {} else if(_id_5696(var_13)) {
          if(var_1 maps\mp\_utility::_hasperk("specialty_bulletresupply"))
            var_15 = _func_1A3(var_13);
        }

        if(var_15 > 0) {
          if(level.gametype == "onevone")
            var_1 setweaponammostock(var_13, maps\mp\gametypes\onevone::_id_4413(var_13, var_14 + var_15, var_1 getweaponammoclip(var_13)));
          else
            var_1 setweaponammostock(var_13, var_14 + var_15);
        }
      }
    }

    if(var_1 maps\mp\_utility::_hasperk("specialty_bulletresupply"))
      var_4 = 1;

    if(var_2 && var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
      var_6 = 1;
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_scorestreakresupply")) {
    level thread maps\mp\gametypes\_rank::_id_1457("scorestreak_pack", var_1);
    var_5 = 1;
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_intelresupply")) {
    _func_256(var_1.origin, var_1, 1200);
    var_7 = 1;
  }

  var_0._id_68FB _id_4AED();

  if(var_7)
    var_1 _id_04C7::_id_A102("resupply_intel");

  if(var_3) {
    if(var_7)
      wait 1.5;

    var_1 _id_04C7::_id_A102("resupply_equipment");
  }

  if(var_4) {
    if(var_3 || var_7)
      wait 1.5;

    var_1 _id_04C7::_id_A102("resupply_bullets");
  }

  if(var_5) {
    if(var_4 || var_3 || var_7)
      wait 1.5;

    var_1 _id_04C7::_id_A102("resupply_scorestreak");
  }

  if(var_6) {
    if(var_4 || var_3 || var_5 || var_7)
      wait 1.5;

    var_1 _id_04C7::_id_A102("resupply_launcher");
  }
}

_id_4AF0(var_0) {}

_id_4AEF() {
  self endon("death");
  self endon("scavenger");
  level endon("game_ended");

  if(level.gametype != "onevone") {
    return;
  }
  wait 25.0;
  _id_4AED();
}

_id_4AEE(var_0) {
  self endon("death");
  self endon("scavenger");
  level endon("game_ended");
  var_0 common_scripts\utility::_id_A70A("death", "disconnect");
  _id_4AED();
}

_id_4AED() {
  if(isDefined(self)) {
    self.model delete();
    self._id_9D65 notify("deleted");
    self._id_9D65 delete();
    self notify("death");
  }
}

_id_34A9(var_0, var_1, var_2) {
  waittillframeend;

  if(level._id_5139) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == self) {
    return;
  }
  if(level._id_585D) {
    return;
  }
  if(!var_0 maps\mp\_utility::_hasperk("specialty_scavenger")) {
    return;
  }
  if(maps\mp\_utility::_id_579B()) {
    if(self _meth_8347()) {
      var_3 = self _meth_85E3();

      if(isDefined(var_3) && isDefined(var_3._id_A2C8))
        return;
    }

    if(getdvarint("bot_FlightDynamicsModeEnabled", 0) > 0)
      return;
  }

  var_4 = isDefined(var_1) && (var_1 != "MOD_GRENADE" && var_1 != "MOD_GRENADE_SPLASH" && var_1 != "MOD_EXPLOSIVE" && var_1 != "MOD_PROJECTILE" && var_1 != "MOD_PROJECTILE_SPLASH");
  var_5 = var_0 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply");
  var_6 = var_0 maps\mp\_utility::_hasperk("specialty_lethalresupply") || var_0 maps\mp\_utility::_hasperk("specialty_tacticalresupply");
  var_7 = var_0 maps\mp\_utility::_hasperk("specialty_bulletresupply");
  var_8 = var_0 maps\mp\_utility::_hasperk("specialty_scorestreakresupply");
  var_9 = var_0 maps\mp\_utility::_hasperk("specialty_intelresupply");

  if(!var_4 && (!var_6 && !var_7 && !var_8)) {
    return;
  }
  var_10 = "usa_grenpack_org1";

  if(var_7)
    var_10 = "usa_foragepack_org1";

  if(var_8 || var_9)
    var_10 = "usa_reqpack_org1";

  if(var_5)
    var_10 = "usa_launchpack_org1";

  var_11 = spawnStruct();
  var_12 = bulletTrace(self.origin, self.origin + (0, 0, -1000), 0, self, 0, 0, 0, 0, 1, 0, 0);
  var_11.origin = var_12["position"];
  var_11._id_0117 = var_0;
  var_11._id_9D65 = spawn("trigger_radius", var_11.origin, 0, 32, 48);
  var_11._id_9D65._id_68FB = var_11;
  var_11.model = spawn("script_model", var_11.origin);
  var_11.model setModel(var_10);
  var_11.model _meth_82B8((0, 0, 0), 0.1);
  var_11.model _meth_805C();
  var_11.model _meth_8005(var_0);
  var_11._id_7DFF = var_4;
  var_11._id_9D65 thread _id_0478::_id_9DC3(::_id_4AF1, ::_id_4AF0);
  var_11 thread _id_4AEF();
  var_11 thread _id_4AEE(var_0);
}

_id_4726(var_0) {
  return 2;
}

_id_4727(var_0) {
  return 1;
}

_id_44ED() {
  var_0 = "frag_grenade_mp";
  var_1 = self getammocount(var_0);
  return var_1;
}

_id_468A() {
  var_0 = self getammocount("smoke_grenade_mp");
  return var_0;
}

_id_8A67(var_0, var_1, var_2) {
  maps\mp\gametypes\_gamelogic::_id_8A67(var_0, var_1, var_2);
}

_id_2546(var_0, var_1) {
  var_2 = var_0._id_A9BB;
  var_3 = maps\mp\_utility::_id_4431(var_1);

  for(var_4 = 0; var_4 < var_2; var_4++) {
    if(var_0._id_A9BA[var_4].name == var_3)
      return var_4;
  }

  return -1;
}

_id_A959(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_1);
    maps\mp\gametypes\_gamelogic::_id_869D(self, 1);
    self._id_5BDB = gettime();

    if(_func_0C1(self)) {
      continue;
    }
    if(isDefined(self._id_8B3D)) {
      self._id_8B3D++;

      if(isDefined(level._id_585D) && level._id_585D) {
        if(maps\mp\_utility::_id_4431(var_1) == self._id_76D8)
          self._id_A9BA[self._id_76D9]._id_8B34 = self._id_A9BA[self._id_76D9]._id_8B34 + 1;
        else {
          var_2 = _id_2546(self, var_1);

          if(var_2 == -1) {
            self._id_76D8 = "";
            self._id_76D9 = -1;
          } else {
            self._id_A9BA[var_2]._id_8B34 = self._id_A9BA[var_2]._id_8B34 + 1;
            self._id_76D8 = maps\mp\_utility::_id_4431(var_1);
            self._id_76D9 = var_2;
          }
        }
      }
    }

    var_3 = maps\mp\_utility::_id_4431(var_1);

    if(!maps\mp\_utility::iscacprimaryweapon(var_3) && !maps\mp\_utility::iscacsecondaryweapon(var_3)) {
      continue;
    }
    var_4 = 0;

    if(!_func_367()) {
      var_5 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
      var_4 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
      var_6 = clamp(_func_0AD(var_4) / _func_0AD(var_5), 0.0, 1.0) * 10000.0;
      maps\mp\gametypes\_persistence::statsetbuffered("totalShots", var_5);
      maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_6));
      maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_5 - var_4));
    }

    if(isDefined(self._id_5BEF) && self._id_5BEF._id_5BF4 == gettime()) {
      self._id_4DDE = 0;
      return;
    }

    var_7 = 1;
    _id_8A67(var_1, var_7, "shots");
    _id_8A67(var_1, self._id_4DDE, "hits");
    self._id_4DDE = 0;
  }
}

_id_A8E9() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  if(_func_0C1(self)) {
    return;
  }
  self._id_5663 = 0;

  for(;;) {
    var_0 = self _meth_8345() > 0.5;
    var_1 = self getcurrentweapon();

    if(!self _meth_8347() && weaponclass(var_1) == "sniper" && issubstr(var_1, "hold_breath_") && !issubstr(var_1, "iron_sight_sniper") && !issubstr(var_1, "telescopic_sight")) {
      if(self _meth_8345() >= 1 && self _meth_8676() == 0) {
        var_2 = _id_04CA::_id_461C(3);

        if(isDefined(level._id_585D) && level._id_585D || (isDefined(self._id_0079) && self._id_0079 != 5 && var_2 == "sharpshooter_level1" || var_2 == "sharpshooter_level2" || var_2 == "sharpshooter_level3"))
          self _meth_82FF("ui_show_division_sniper_ability_prompt", 1);
        else
          self _meth_82FF("ui_show_division_sniper_ability_prompt", 0);
      } else
        self _meth_82FF("ui_show_division_sniper_ability_prompt", 0);
    }

    if(_id_0511::_id_46F7("game", "minimapHiddenWhileADS") && !maps\mp\_utility::_hasperk("specialty_minimapwhileads")) {
      if(var_0 && !self._id_5663 && !maps\mp\_utility::_hasperk("specialty_minimapwhileads"))
        self _meth_82FF("ui_hide_minimap", 1);
    }

    self._id_5663 = var_0;
    waitframe();
  }
}

_id_21C6(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = maps\mp\_utility::_id_4431(var_0);

  if(!_id_5795(var_3) && !_id_57CD(var_3)) {
    return;
  }
  if(!maps\mp\_utility::_id_5695(var_1)) {
    return;
  }
  if(self _meth_8344()) {
    return;
  }
  switch (weaponclass(var_0)) {
    case "beam":
    case "mg":
    case "pistol":
    case "smg":
    case "rifle":
    case "sniper":
      self._id_4DDE++;
      break;
    case "spread":
      self._id_4DDE = 1;
      break;
    case "grenade":
    case "shield":
    case "item":
    case "underwater":
    case "rocketlauncher":
    case "ball":
      break;
    default:
      break;
  }

  if(issubstr(var_0, "riotshield")) {
    thread maps\mp\gametypes\_gamelogic::_id_996D("riotshield", self._id_4DDE, "hits");
    self._id_4DDE = 0;
  }

  waittillframeend;

  if(!isDefined(self._id_5BA9[var_0]))
    self._id_5BA9[var_0] = 0;

  if(self._id_5BA9[var_0] == gettime()) {
    return;
  }
  self._id_5BA9[var_0] = gettime();
  var_4 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
  var_5 = maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;

  if(var_5 <= var_4) {
    maps\mp\gametypes\_persistence::statsetbuffered("hits", var_5);
    maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_4 - var_5));
    var_6 = clamp(_func_0AD(var_5) / _func_0AD(var_4), 0.0, 1.0) * 10000.0;
    maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_6));
  }
}

_id_1188(var_0, var_1) {
  return _id_3ECD(var_1, var_0);
}

_id_3ECD(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return 1;

  if(!level.teambased)
    return 1;

  if(_func_367() && isonevonedamage(var_1, var_0))
    return 1;

  var_3 = var_1.team;
  var_4 = level._id_3EC4;

  if(isDefined(var_2))
    var_4 = var_2;

  if(var_4 != 0)
    return 1;

  if(var_1 == var_0)
    return 1;

  if(!isDefined(var_3))
    return 1;

  if(var_3 != var_0.team)
    return 1;

  if(isDefined(self._id_0C2E) && self._id_0C2E)
    return 1;

  return 0;
}

isonevonedamage(var_0, var_1) {
  if(isDefined(var_0) && var_0 == var_1 && isDefined(var_0._id_572A) && var_0._id_572A)
    return 1;

  if(!isDefined(var_0._id_4E03) || !isDefined(var_1._id_4E03))
    return 0;

  return common_scripts\utility::_id_0F79(var_0._id_4E03, var_1) && common_scripts\utility::_id_0F79(var_1._id_4E03, var_0);
}

_id_A918() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.throwinggrenade = undefined;
  self._id_4820 = 0;

  if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1) {
    if(isDefined(self._id_3233))
      self._id_3233 = undefined;
    else
      _id_2CF3();
  } else {
    if(!isDefined(self._id_5FDB))
      self._id_5FDB = [];

    if(!isDefined(self._id_232F))
      self._id_232F = [];

    if(!isDefined(self._id_1B56))
      self._id_1B56 = [];

    if(!isDefined(self._id_2B71))
      self._id_2B71 = [];
  }

  thread _id_A916();
  thread _id_A924();
  thread _id_A923();
  thread _id_2D2E();
  thread _id_A8E3();

  for(;;) {
    self waittill("grenade_pullback", var_0);
    _id_8A67(var_0, 1, "shots");
    maps\mp\gametypes\_gamelogic::_id_869D(self, 1);
    thread _id_A92C();

    if(var_0 == "claymore_mp") {
      continue;
    }
    self.throwinggrenade = var_0;
    self._id_4820 = 1;

    if(var_0 == "c4_mp" || var_0 == "bouncingbetty_mp")
      _id_2379();
    else
      _id_1711();

    self.throwinggrenade = undefined;
  }
}

_id_A8E3() {
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watch_throwing_knife_usage");
  self endon("watch_throwing_knife_usage");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0)) {
      var_0._id_5CC6 = self._id_5CC6;

      if(issubstr(var_1, "throwingknife"))
        var_0 thread _id_99AD(self);
    }
  }
}

_id_1711() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self endon("offhand_end");
  self endon("weapon_change");
  var_0 = gettime();
  self waittill("grenade_fire", var_1, var_2);
  var_1._id_5CC6 = self._id_5CC6;

  if(isDefined(var_1)) {
    if(gettime() - var_0 > 1000 && (var_2 == "frag_grenade_mp" || var_2 == "frag_grenade_german_mp"))
      var_1._id_56B8 = 1;

    self._id_20CC = undefined;
    var_1._id_0117 = self;
    var_1._id_A9E0 = var_2;
    var_1 thread watchmissilestuck();

    switch (var_2) {
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_1 thread _id_050A::_id_485C();
        break;
      case "concussion_grenade_mp":
        var_1 thread _id_35F0();
        break;
      case "stun_grenade_mp":
        break;
      case "smoke_grenade_axis_expeditionary_mp":
      case "smoke_grenade_expeditionary_mp":
      case "smoke_grenade_axis_mp":
      case "smoke_grenade_mp":
        var_1 thread _id_A942();
    }
  }
}

watchmissilestuck() {
  self endon("death");
  self waittill("missile_stuck");
  self.missile_stuck = 1;
}

_id_A92C() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");

  if(isDefined(self._id_20CC) && self._id_20CC != self getcurrentweapon())
    self._id_20CC = undefined;
}

_id_A942() {
  level endon("smokeTimesUp");
  var_0 = self._id_0117;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  var_2 = 128;
  var_3 = 8;
  level thread _id_A6FC(var_3, var_2, var_1);

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    foreach(var_5 in level.players) {
      if(!isDefined(var_5) || !isDefined(var_5.team)) {
        continue;
      }
      if(level.teambased && var_5.team == var_0.team) {
        if(distancesquared(var_5.origin, var_1) < var_2 * var_2)
          var_5._id_5137 = var_0;
        else
          var_5._id_5137 = undefined;

        continue;
      }

      if(distancesquared(var_5.origin, var_1) < var_2 * var_2) {
        var_5._id_5384 = var_0;
        continue;
      }

      var_5._id_5384 = undefined;
    }

    waitframe();
  }
}

_id_A6FC(var_0, var_1, var_2) {
  maps\mp\gametypes\_hostmigration::_id_A6F5(var_0);
  level notify("smokeTimesUp");
  waittillframeend;

  foreach(var_4 in level.players) {
    if(isDefined(var_4))
      var_4._id_5384 = undefined;
  }
}

_id_A94E() {
  self waittill("death");

  if(isDefined(self._id_5AB2))
    self._id_5AB2 delete();
}

_id_99AD(var_0) {
  self endon("death");
  self _meth_80B3();

  if(!isDefined(var_0) || !maps\mp\_utility::isreallyalive(var_0)) {
    return;
  }
  var_1 = undefined;
  self waittill("missile_stuck", var_1);

  if(isDefined(var_1) && (isPlayer(var_1) || _func_1EF(var_1))) {
    self delete();
    return;
  }

  var_2 = spawn("trigger_radius", self.origin, 0, 64, 64);
  var_2 _meth_8070();
  var_2 _meth_8055(self);
  var_2.targetname = "dropped_knife";
  self._id_5AB2 = var_2;
  thread _id_A94E();

  for(;;) {
    waitframe();

    if(!isDefined(var_2)) {
      return;
    }
    var_2 waittill("trigger", var_3);

    if(!isPlayer(var_3) || !maps\mp\_utility::isreallyalive(var_3) || var_3 != var_0) {
      continue;
    }
    if(!var_3 _meth_8319(self._id_A9E0)) {
      continue;
    }
    var_4 = var_3 getweaponammoclip(self._id_A9E0);
    var_3 setweaponammoclip(self._id_A9E0, var_4 + 1);
    var_3 _id_04C7::_id_A102("resupply_throwingknife");
    self delete();
    return;
  }
}

_id_A92B() {
  self endon("disconnect");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    var_2 = [var_0];

    if(issubstr(var_1, "_gl")) {
      var_0._id_0117 = self;
      var_0.primaryweapon = self _meth_8317();
      var_0 thread _id_050A::_id_485C();
    }

    if(isDefined(var_0)) {
      var_0._id_A9E0 = var_1;

      if(_id_5794(var_1))
        var_0._id_3BE0 = self _meth_8345();
    }

    var_3 = maps\mp\_utility::_id_45B5(var_1);

    switch (var_3) {
      case "iw5_lsr_mp":
        var_0._id_5E70 = self._id_93AE;
        level notify("stinger_fired", self, var_2);
        thread maps\mp\_utility::setaltsceneobj(var_0, "tag_origin", 65);
        break;
      case "panzerfaust60_mp":
      case "piat_mp":
      case "panzerschreck_mp":
      case "bazooka_mp":
        level notify("launcher_missile_fire", self, var_2);
      default:
        break;
    }

    switch (var_3) {
      case "panzerfaust60_mp":
      case "piat_mp":
      case "panzerschreck_mp":
      case "bazooka_mp":
      case "v2_rocket_mp":
      case "missile_strike_projectile_axis_mp":
      case "missile_strike_projectile_mp":
      case "mortar_strike_projectile_axis_mp":
      case "mortar_strike_projectile_mp":
      case "azon_projectile_mp":
      case "fritzx_projectile_mp":
        var_0 thread _id_050A::_id_485C();
      default:
        break;
    }

    var_0 thread _id_A929(self, var_3);
  }
}

_id_35F0() {
  thread _id_050A::_id_36DC();
  self endon("end_explode");
  self waittill("explode", var_0);
  var_1 = _id_44B3(var_0, 512, 0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_0117) && !_id_3ECD(self._id_0117, var_3._id_0117)) {
      continue;
    }
    var_3 notify("emp_damage", self._id_0117, 8.0);
  }
}

_id_66D9() {
  thread _id_050A::_id_36DC();
  self endon("end_explode");
  self waittill("explode", var_0);
  level thread _id_3221(var_0, self._id_0117);
  var_1 = _id_44B3(var_0, 512, 0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_0117) && !_id_3ECD(self._id_0117, var_3._id_0117)) {
      continue;
    }
    var_3 notify("emp_damage", self._id_0117, 8.0);
  }
}

_id_2578(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self == var_2)
    var_4 = var_4 * 0.5;

  if(!isDefined(var_1))
    return;
  else if(var_3 == "MOD_IMPACT")
    return;
  else if(common_scripts\utility::_id_562E(self.concussionimmune)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_4B97)) {
    return;
  }
  var_7 = 1;

  if(isDefined(var_1._id_0117) && var_1._id_0117 == var_2)
    var_7 = 0;

  var_8 = 1 - distancesquared(self.origin, var_1.origin) / (var_4 * var_4);

  if(var_8 < 0)
    var_8 = 0;

  var_9 = var_5 + (var_6 - var_5) * var_8;
  waitframe();

  if(maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
    self._id_8C5B = gettime() + var_9 * 1000;
    var_9 = 0;
  }

  self notify("concussed", var_2);

  if(var_2 != self)
    var_2 maps\mp\gametypes\_missions::processchallenge("ch_alittleconcussed");

  self _meth_8182("concussion_grenade_mp", var_9, var_9);
  self _meth_8182("ear_ring_mp", var_9, var_9);
  self._id_2577 = gettime() + var_9 * 1000;

  if(var_7 && var_2 != self)
    var_2 thread _id_04C7::_id_A102("stun");
}

_id_3D43(var_0, var_1, var_2) {
  var_3 = 640000;
  var_4 = 40000;
  var_5 = 60;
  var_6 = 40;
  var_7 = 11;

  if(!maps\mp\_utility::isreallyalive(var_0) || var_0.sessionstate != "playing") {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_4B97)) {
    return;
  }
  var_8 = distancesquared(var_1, var_0.origin);

  if(var_8 > var_3) {
    return;
  }
  if(var_8 <= var_4)
    var_9 = 1.0;
  else
    var_9 = 1.0 - (var_8 - var_4) / (var_3 - var_4);

  var_10 = var_0 _meth_81D8(var_1);

  if(var_10 < 0.5) {
    return;
  }
  var_11 = anglesToForward(var_0 getplayerangles());
  var_12 = var_0.origin;

  switch (var_0 _meth_8178()) {
    case "stand":
      var_12 = (var_12[0], var_12[1], var_12[2] + var_5);
      break;
    case "crouch":
      var_12 = (var_12[0], var_12[1], var_12[2] + var_6);
      break;
    case "prone":
      var_12 = (var_12[0], var_12[1], var_12[2] + var_7);
      break;
  }

  var_13 = var_1 - var_12;
  var_13 = vectorNormalize(var_13);
  var_14 = 0.5 * (1.0 + vectordot(var_11, var_13));
  var_0 notify("flashbang", var_1, var_9, var_14, var_2);
}

_id_3221(var_0, var_1) {
  level endon("game_ended");
  var_2 = 1;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(var_3 > 0) {
      playsoundatpos(var_0, "null");

      foreach(var_5 in level.players)
      _id_3D43(var_5, var_0, var_1);
    }

    var_7 = _id_44B3(var_0, 512, 0);

    foreach(var_9 in var_7) {
      if(isDefined(var_9._id_0117) && !_id_3ECD(self._id_0117, var_9._id_0117)) {
        continue;
      }
      var_9 notify("emp_damage", self._id_0117, 8.0);
    }

    wait(_func_0A5(0.25, 0.5));
  }
}

_id_2379() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::_id_A70A("grenade_fire", "weapon_change", "offhand_end");
  self._id_20CC = undefined;
}

_id_21EB(var_0, var_1) {
  if(self._id_4820) {
    self._id_4820 = 0;
    return;
  }

  if(!issubstr(var_1, "frag_") && !issubstr(var_1, "semtex_")) {
    return;
  }
  if(var_1 == "frag_grenade_short_mp") {
    return;
  }
  var_0._id_999E = 1;
  var_0 thread _id_050A::_id_485C();
}

_id_5FDA(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3[0])) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_A916() {
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("disconnect");
  self._id_232F = [];
  _id_5316();

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = _func_1DA(var_1);
    var_3 = _func_27E(var_1);

    if(var_2 || var_3) {
      if(!self._id_5FDB.size)
        thread _id_A925();

      if(self._id_5FDB.size) {
        self._id_5FDB = _id_5FDA(self._id_5FDB);

        if(self._id_5FDB.size >= level._id_6092)
          self._id_5FDB[0][0] _meth_81D6();
      }

      var_4 = self._id_5FDB.size;
      self._id_5FDB[var_4] = [];
      self._id_5FDB[var_4][0] = var_0;
      self._id_5FDB[var_4][1] = var_2;
      self._id_5FDB[var_4][2] = var_3;

      if(isDefined(var_0)) {
        var_0._id_0117 = self;
        var_0 _meth_8385(self);
        var_0.team = self.team;
        var_0._id_A9E0 = var_1;
        var_0._id_94B9 = 0;
      }
    } else if(isDefined(var_0)) {
      var_0._id_0117 = self;
      var_0._id_A9E0 = var_1;
    }

    _id_3BE8(var_0, var_1);
  }
}

_id_3BE8(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_1 == "c4" || var_1 == "c4_mp" || var_1 == "c4_zm")
    _id_3BD7(var_0, var_1);

  if(var_1 == "claymore" || var_1 == "claymore_mp")
    _id_3BD8(var_0, var_1);

  if(var_1 == "bouncingbetty" || var_1 == "bouncingbetty_mp" || var_1 == "bouncingbetty_zm")
    _id_3C15(var_0, var_1);

  if(var_1 == "thermite" || var_1 == "thermite_mp" || var_1 == "killstreak_molotov_cocktail_mp" || var_1 == "killstreak_molotov_cocktail_grenadier_mp")
    var_0 thread _id_4AFE(self, var_1);

  if(var_1 == "tabun_grenade_mp")
    var_0 thread _id_4A66(self, var_1);

  if(var_1 == "decoy_device_mp")
    thread _id_49C8(var_0);

  if(var_1 == "signal_flare_mp" || var_1 == "signal_flare_expeditionary_mp")
    var_0 thread _id_4AF3(self, var_1);

  if(var_1 == "s2_tactical_insertion_device_mp" || var_1 == "s2_tactical_insertion_cavalry_mp")
    _id_4AF9(var_0, var_1);

  if(var_1 == "role_barbed_wire_mp")
    var_0 thread _id_499D(self, var_1);

  if(var_1 == "role_explosive_rat_mp")
    _id_3BE4(var_0, var_1);

  if(issubstr(var_1, "semtex"))
    _id_9304(var_0);

  _id_21EB(var_0, var_1);
  var_0 thread _id_A929(self, var_1);
}

_id_3BD7(var_0, var_1) {
  thread _id_0378::_id_8D74("wpn_c4_throw");
  level._id_61ED[level._id_61ED.size] = var_0;
  common_scripts\utility::_id_0613(var_1, 0);
  var_0 thread _id_A8F5(var_1, self, self.pers["team"]);

  if(!maps\mp\_utility::_id_585F())
    var_0 thread _id_050A::_id_1DEE();

  var_0 thread _id_1DF0();
  var_0 thread _id_1DF5();
  var_0 thread _id_1DF6();
  var_0 thread _id_A8F7();
}

waittill_missile_stuck_or_timeout() {
  return common_scripts\utility::_id_A71A(10, "missile_stuck");
}

_id_A8F5(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_shortfuse"))
    wait(level.shortdelayc4armtime);
  else {
    if(level._id_258F)
      waittill_missile_stuck_or_timeout();

    wait(level._id_2CBD);
  }

  self._id_0117 common_scripts\utility::_id_0613(var_0, 1);
  thread watchc4teamheadicon(var_2);
  thread _id_A8F6(var_1);
}

watchc4teamheadicon(var_0) {
  self endon("death");

  if(!level._id_258F && !common_scripts\utility::_id_562E(self.missile_stuck))
    waittill_missile_stuck_or_timeout();

  thread _id_86CA(var_0, 1);
}

_id_A8F6(var_0) {
  var_0 _meth_86AD(1);
  common_scripts\utility::_id_A70A("death", "detonate");

  if(isDefined(var_0))
    var_0 _meth_86AD(0);
}

_id_A8F7() {
  self endon("death");
  self waittill("missile_stuck");
  self.missile_stuck = 1;
  self._id_9D65 = spawn("script_origin", self.origin);
  self._id_9D65._id_0117 = self;
  thread _id_3800(self._id_0117, 1);
  _id_5FB8();
  thread _id_1DF4(self._id_9D65);
}

_id_1DF4(var_0) {
  var_0 endon("death");
  common_scripts\utility::_id_A70A("death", "detonate");
  var_0 delete();
}

_id_1DF5() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    _func_147(common_scripts\utility::_id_44F5("sentry_explode_mp"), self, "tag_origin");
    self._id_2F74 = 1;
    self notify("disabled");
    wait(var_1);
    self._id_2F74 = undefined;
    self notify("enabled");
  }
}

_id_1DF6() {
  self endon("death");

  for(;;) {
    level waittill("emp_update");

    if(level.teambased && level.teamemped[self.team] || !level.teambased && isDefined(level.empplayer) && level.empplayer != self._id_0117) {
      self._id_2F74 = 1;
      self notify("disabled");
      continue;
    }

    self._id_2F74 = undefined;
    self notify("enabled");
  }
}

_id_86CA(var_0, var_1) {
  self endon("death");
  waitframe();
  var_2 = (0, 0, 20);

  if(isDefined(var_1) && var_1)
    var_2 = _func_112(var_2, self.angles);

  if(level.teambased && !_func_367())
    _id_0479::_id_873C(var_0, var_2);
  else if(isDefined(self._id_0117))
    _id_0479::_id_86FC(self._id_0117, var_2);
}

_id_3BD8(var_0, var_1) {
  self endon("faux_spawn");
  self endon("spawned_player");
  self endon("disconnect");

  if(!isalive(self)) {
    var_0 notify("remove");
    var_0 delete();
    return;
  }

  var_0 _meth_805C();
  var_0 common_scripts\utility::_id_A71A(0.05, "missile_stuck");

  if(_func_030(var_0)) {
    var_0 notify("remove");
    var_0 delete();
    return;
  }

  var_2 = 60;
  var_3 = (0, 0, 4);
  var_4 = distancesquared(self.origin, var_0.origin);
  var_5 = distancesquared(self getEye(), var_0.origin);
  var_4 = var_4 + 600;
  var_6 = var_0 _meth_83F2();

  if(isDefined(var_6))
    var_0 _meth_8057();

  if(var_4 < var_5) {
    if(var_2 * var_2 < distancesquared(var_0.origin, self.origin)) {
      var_7 = bulletTrace(self.origin, self.origin - (0, 0, var_2), 0, self);

      if(var_7["fraction"] == 1) {
        var_0 delete();
        self setweaponammostock("claymore_mp", self getweaponammostock("claymore_mp") + 1);
        return;
      } else {
        var_0.origin = var_7["position"];
        var_6 = var_7["entity"];
      }
    } else {}
  } else if(var_2 * var_2 < distancesquared(var_0.origin, self getEye())) {
    var_7 = bulletTrace(self.origin, self.origin - (0, 0, var_2), 0, self);

    if(var_7["fraction"] == 1) {
      var_0 delete();
      self setweaponammostock("claymore_mp", self getweaponammostock("claymore_mp") + 1);
      return;
    } else {
      var_0.origin = var_7["position"];
      var_6 = var_7["entity"];
    }
  } else {
    var_3 = (0, 0, -5);
    var_0.angles = var_0.angles + (0, 180, 0);
  }

  var_0.angles = var_0.angles * (0, 1, 1);
  var_0.origin = var_0.origin + var_3;

  if(isDefined(var_6))
    var_0 _meth_8055(var_6);

  var_0 _meth_805B();
  self._id_232F = common_scripts\utility::_id_0FA0(self._id_232F);

  if(self._id_232F.size >= level._id_6092)
    _id_2D37(self._id_232F[0]);

  self._id_232F[self._id_232F.size] = var_0;
  var_0._id_0117 = self;
  var_0 _meth_8385(self);
  var_0.team = self.team;
  var_0._id_A9E0 = var_1;
  var_0._id_9D65 = spawn("script_origin", var_0.origin);
  var_0._id_9D65._id_0117 = var_0;
  var_0._id_94B9 = 0;
  var_0 _id_5FB8();
  level._id_61ED[level._id_61ED.size] = var_0;
  var_0 thread _id_1DF0();
  var_0 thread _id_1DF5();
  var_0 thread _id_1DF6();
  var_0 thread _id_2334();
  var_0 thread _id_3800(self, 1);
  var_0 thread _id_86CA(self.pers["team"]);
  self._id_20CC = undefined;
}

_id_37F9(var_0) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self endon("change_owner");
  self._id_9D65 _meth_80CD("HINT_NOICON");

  if(self._id_A9E0 == "c4_mp" || self._id_A9E0 == "c4_zm")
    self._id_9D65 _meth_80CE(&"MP_PICKUP_C4");
  else if(self._id_A9E0 == "claymore_mp")
    self._id_9D65 _meth_80CE(&"MP_PICKUP_CLAYMORE");
  else if(self._id_A9E0 == "bouncingbetty_mp" || self._id_A9E0 == "bouncingbetty_zm")
    self._id_9D65 _meth_80CE(&"MP_PICKUP_BOUNCING_BETTY");
  else if(self._id_A9E0 == "s2_tactical_insertion_device_mp")
    self._id_9D65 _meth_80CE(&"MP_PICKUP_TI");
  else if(self._id_A9E0 == "s2_tactical_insertion_cavalry_mp")
    self._id_9D65 _meth_80CE(&"DIVISIONS_DLC4_INSERTION_FLARE_PICKUP");

  self._id_9D65 maps\mp\_utility::setselfusable(var_0);
}

_id_37F7(var_0) {
  self._id_9D65 _meth_80CE("");
  self._id_9D65 maps\mp\_utility::_id_871D();
}

_id_37FF(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = 1;

  for(;;) {
    if(var_0 getweaponammostock(self._id_A9E0) < _func_1D6(self._id_A9E0)) {
      if(!var_1) {
        _id_37F9(var_0);
        var_1 = 1;
      }
    } else if(var_1) {
      _id_37F7(var_0);
      var_1 = 0;
    }

    waitframe();
  }
}

_id_3800(var_0, var_1) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self._id_9D65 _meth_80CD("HINT_NOICON");
  _id_37F9(var_0);
  self._id_9D65 thread maps\mp\_utility::_id_A18D(var_0);

  if(isDefined(var_1) && var_1)
    thread _id_A184();

  for(;;) {
    thread _id_37FF(var_0);
    self._id_9D65 waittill("trigger", var_0);
    var_2 = var_0 getweaponammostock(self._id_A9E0);

    if(var_2 < _func_1D6(self._id_A9E0)) {
      var_0 playlocalsound("scavenger_pack_pickup");
      var_0 setweaponammostock(self._id_A9E0, var_2 + 1);

      if(isDefined(self._id_5A2C))
        self._id_5A2C delete();

      self._id_9D65 delete();

      if(self._id_A9E0 == "s2_tactical_insertion_cavalry_mp") {
        var_0._id_6E6C = 0;
        _id_052C::_id_2D54(self);
      } else
        self delete();

      self notify("death");
    }
  }
}

watchforwater() {
  for(;;) {
    foreach(var_1 in level._id_A964) {
      if(var_1 istouching(self)) {
        self _meth_8469(1);
        self notify("dud");
      }
    }

    waitframe();
  }
}

_id_4AFE(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("death");
  self endon("dud");
  self endon("entitydeleted");

  if(isDefined(level._id_A964))
    childthread watchforwater();

  var_2 = spawnStruct();

  if(var_1 == "killstreak_molotov_cocktail_mp" || var_1 == "killstreak_molotov_cocktail_grenadier_mp") {
    var_2._id_50B0 = 125;
    var_2._id_50B9 = 100;
    var_2._id_3BB5 = 20;
    var_2._id_3BCB = 152;
    var_2._id_3BC1 = 152;
    var_2._id_3BC8 = 10;
    var_2._id_3BD2 = 0.4;
  } else {
    var_2._id_50B0 = 85;
    var_2._id_50B9 = 72;
    var_2._id_3BB5 = 18;
    var_2._id_3BCB = 152;
    var_2._id_3BC1 = 152;
    var_2._id_3BC8 = 10;
    var_2._id_3BD2 = 0.4;
  }

  self waittill("explode", var_3);

  if(_func_030(self)) {
    return;
  }
  var_2.location = var_3;
  thread _id_995B(var_0, var_2.location, var_2._id_50B0, var_2._id_50B9, var_2._id_3BC1, var_1);
  _id_0380::_id_6842("mp_ks_molotov_exp_shatter", undefined, self.origin);
  thread _id_9962(var_0, var_2, var_1);
}

_id_9962(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  self endon("death");
  self endon("entitydeleted");
  wait 0.3;
  var_3 = self.origin;
  var_4 = _id_0380::_id_6842("mp_ks_molotov_fire_loop", undefined, var_3, 1);
  var_5 = 0;

  while(var_5 < var_1._id_3BC8) {
    var_5++;
    _id_995B(var_0, var_1.location, var_1._id_3BB5, var_1._id_3BCB, var_1._id_3BC1, var_2);
    wait(var_1._id_3BD2);
  }

  _id_0380::_id_6842("mp_ks_molotov_fire_stop", undefined, var_3);
  _id_0380::_id_6850(var_4, 3);
}

thermite_damage_character(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0._id_A019)) {
    if(_id_746F(var_0.origin, var_2, var_4, var_5)) {
      if(_id_740F(var_0, var_2))
        var_0 _meth_8059(var_3, var_2, var_1, self, "MOD_BURNED", var_6);
    }
  }
}

_id_995B(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level.players)
  thermite_damage_character(var_7, var_0, var_1, var_2, var_3, var_4, var_5);

  var_9 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_11 in var_9)
  thermite_damage_character(var_11, var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_746F(var_0, var_1, var_2, var_3) {
  if(var_0[2] - var_1[2] > var_3)
    return 0;

  return _func_211(var_0, var_1) < var_2 * var_2;
}

_id_4A66(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("make_dud");
  self endon("death");
  self waittill("explode", var_2);
  var_3 = spawnStruct();
  var_3._id_6C2C = var_2;
  var_3.radius = 150;

  if(isDefined(var_0) && var_0 maps\mp\_utility::_hasperk("specialty_improvedtacticals")) {
    var_3._id_688C = 8;
    var_3._id_99EB = 0.625;
    var_3._id_2994 = 5;
  } else {
    var_3._id_688C = 5;
    var_3._id_99EB = 1;
    var_3._id_2994 = 1;
  }

  thread _id_9595(var_3, var_0, var_1);
}

_id_9595(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("disconnect");
  self endon("death");
  var_3 = 0;

  while(var_3 < var_0._id_688C) {
    var_3++;

    foreach(var_5 in level.players) {
      if(_func_367()) {
        if(!isonevonedamage(var_1, var_5))
          continue;
      } else if(var_5 != var_1 && level.teambased && var_5.team == var_1.team) {
        continue;
      }
      if(_id_746D(var_5.origin, var_0._id_6C2C, var_0.radius)) {
        if(_id_740F(var_5, var_0._id_6C2C))
          var_5 _meth_8059(var_0._id_2994, var_0._id_6C2C, var_1, self, "MOD_GAS", var_2, "none");
      }
    }

    wait(var_0._id_99EB);
  }
}

_id_746D(var_0, var_1, var_2) {
  return distancesquared(var_0, var_1) < var_2 * var_2;
}

_id_740F(var_0, var_1) {
  if(var_0.origin[2] <= var_1[2])
    return _func_07E(var_0.origin + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0) && _func_07E(var_1 + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0);
  else
    return _func_07E(var_1 + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0) && _func_07E(var_0.origin + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0);
}

_id_4AF3(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("make_dud");
  self endon("death");
  common_scripts\utility::_id_A63E(0.65, "missile_stuck");

  if(!isDefined(self)) {
    return;
  }
  var_2 = spawnStruct();
  var_2._id_3D33 = 1750;
  var_2._id_3D37 = 65536;
  var_2._id_3F83 = common_scripts\utility::_id_8FFC();
  var_2._id_3F83 linktosynchronizedparent(self);
  var_2._id_3F83 _meth_805B();
  var_2._id_3F71 = maps\mp\_utility::_id_9028(common_scripts\utility::_id_44F5("signal_flare_friendly_tacmask"), var_0, var_0.team, 1, var_2._id_3F83, "TAG_ORIGIN");
  var_2._id_3F82 = common_scripts\utility::_id_8FFC();
  var_2._id_3F82 linktosynchronizedparent(self);
  var_2._id_3F82 _meth_805B();
  var_2._id_3F6D = maps\mp\_utility::_id_9028(common_scripts\utility::_id_44F5("signal_flare"), var_0, maps\mp\_utility::getotherteam(var_0.team), 0, var_2._id_3F82, "TAG_ORIGIN");
  thread _id_8C50(var_2);

  while(isDefined(self)) {
    foreach(var_4 in level.players) {
      if(!maps\mp\_utility::isreallyalive(var_4)) {
        continue;
      }
      if(_func_367()) {
        if(!isonevonedamage(var_0, var_4))
          continue;
      } else if(var_4 != var_0 && level.teambased && var_4.team == var_0.team) {
        continue;
      }
      if(!isDefined(var_4._id_99F0) || var_4._id_99F0 + var_2._id_3D33 <= gettime()) {
        if(distancesquared(var_4.origin, self.origin) < var_2._id_3D37) {
          if(self _meth_81D8(var_4 getEye(), var_4) > 0.5) {
            var_5 = anglesToForward(var_4 getplayerangles());
            var_6 = var_4 getEye();
            var_7 = self.origin + (0, 0, 10);
            var_8 = vectorNormalize(var_7 - var_6);
            var_9 = vectordot(var_5, var_8);

            if(var_9 > 0.55) {
              var_4 _meth_8059(1, self.origin, var_0, self, "MOD_GRENADE_SPLASH", var_1);
              var_10 = var_4 maps\mp\_utility::_hasperk("specialty_stun_resistance");

              if(!var_10 && !common_scripts\utility::_id_562E(var_4._id_4B97)) {
                var_4 thread maps\mp\_utility::_id_5D22("flashed", 0.1, 1.55, 0.1);
                var_4._id_3D39 = gettime() + var_2._id_3D33;
              }

              var_4._id_99F0 = gettime();
            }
          }
        }
      }
    }

    wait 0.2;
  }
}

_id_8C50(var_0) {
  self waittill("death");

  if(isDefined(var_0._id_3F83))
    var_0._id_3F83 delete();

  if(isDefined(var_0._id_3F71))
    var_0._id_3F71 delete();

  if(isDefined(var_0._id_3F82))
    var_0._id_3F82 delete();

  if(isDefined(var_0._id_3F6D))
    var_0._id_3F6D delete();
}

_id_4AF9(var_0, var_1) {
  if(var_1 == "s2_tactical_insertion_device_mp" || var_1 == "s2_tactical_insertion_cavalry_mp") {
    var_2 = var_1 == "s2_tactical_insertion_cavalry_mp";

    if(var_2 && isDefined(self._id_6E6B) && self._id_6E6B && isDefined(self._id_6E6D) && var_0 == self._id_6E6D) {
      return;
    }
    var_0 _meth_805C();

    if(!isalive(self)) {
      if(isDefined(var_0))
        var_0 delete();

      return;
    }

    if(var_2) {
      if(maps\mp\_utility::_id_579B()) {
        switch (maps\mp\_utility::_id_4571()) {
          case "mp_raid_cobra":
            self.playerparachutedropheight = 1500;
            break;
          case "mp_raid_bulge":
            self.playerparachutedropheight = 1500;
            break;
          case "mp_raid_dday":
            self.playerparachutedropheight = 1400;
            break;
          case "mp_raid_aachen":
            self.playerparachutedropheight = 1500;
            break;
          case "mp_raid_dlc4":
          case "mp_raid_dlc2":
          case "mp_raid_dlc3":
          default:
            self.playerparachutedropheight = 1600;
            break;
        }
      } else
        self.playerparachutedropheight = 2700;
    }

    var_3 = _id_3B9A(var_2);
    var_4 = self.angles;

    if(!self _meth_8346() || !isDefined(var_3) && !common_scripts\utility::_id_562E(var_0.isplayersteerable) || isDefined(self._id_1B67) && self._id_1B67) {
      if(var_2) {
        if(isDefined(self._id_1B67) && self._id_1B67)
          self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_WARBOUNDARY");
        else if(!self _meth_8346())
          self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_MIDAIR");
        else
          self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID");
      } else
        self iprintlnbold(&"WEAPON_MTX5_TAC_INSERT_INVALID");

      var_5 = self getweaponammostock(var_1);

      if(var_5 < _func_1D6(var_1))
        self setweaponammostock(var_1, var_5 + 1);

      if(isDefined(var_0))
        var_0 delete();

      return;
    }

    maps\mp\gametypes\_gamelogic::_id_869D(self, 1);
    var_0 thread _id_9A29(self, var_3, var_4, var_1);
  }
}

isvalidraidtinode(var_0) {
  if(isDefined(level._id_79C2) && isDefined(level._id_79C2._id_4C32)) {
    var_1 = 24025;

    foreach(var_3 in level._id_79C2._id_4C32) {
      if(isDefined(var_3._id_9D65) && _func_211(var_0.origin, var_3._id_9D65.origin) < var_1)
        return 0;
    }
  }

  return 1;
}

_id_3B9A(var_0) {
  var_1 = _func_0B9(self.origin, 156, 0, 64);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && (!var_0 || _func_200(var_4, 1))) {
      if(!var_0 || _func_293(var_4.origin + (0, 0, 48), 32, self.playerparachutedropheight, self, 0, 0, 1)) {
        if(maps\mp\_utility::_id_579B() && !isvalidraidtinode(var_4)) {
          continue;
        }
        var_5 = var_4.origin + (0, 0, 10);

        if(_func_07E(self getEye(), var_5, 0, self)) {
          if(_func_15E(var_5) && self _meth_8346()) {
            var_2 = var_5;
            break;
          }
        }
      }
    }
  }

  return var_2;
}

_id_9A29(var_0, var_1, var_2, var_3) {
  self._id_0117 = var_0;
  self waittill("missile_stuck");
  self _meth_805B();

  if(!isDefined(var_0)) {
    return;
  }
  _id_8A4A(var_0, var_1, var_2, var_3);
  self._id_9D65 = spawn("script_origin", self.origin + (0, 0, 25));
  self._id_9D65._id_0117 = self;
  self._id_9D65 _meth_8055(self);

  if(var_3 == "s2_tactical_insertion_cavalry_mp") {
    var_0 thread _id_A931();
    thread _id_3800(var_0, 0);
    _id_37F9(var_0);
    self._id_3773 = spawn("script_origin", self.origin + (0, 0, 25));
    self._id_3773 _meth_8055(self);
    self._id_3773._id_0117 = self;
    thread _id_052C::_id_47EA(var_0);
  }

  var_0 thread _id_61FE(self);
  var_0 thread _id_61FD(self);
  self notify("tactical_insertion_activated");
}

_id_8A4A(var_0, var_1, var_2, var_3) {
  if(var_3 == "s2_tactical_insertion_cavalry_mp") {
    var_4 = bulletTrace(var_1 + (0, 0, 50), var_1 - (0, 0, 400), 0, self);
    var_5 = var_4["position"] + (0, 0, 1);
    self.origin = var_5;
  }

  self._id_94B9 = 0;
  self _meth_8385(var_0);
  self._id_A9E0 = var_3;
  self._id_7464 = var_1;
  self.playerspawnangles = var_2;
  self _meth_861D("tac_insert_spark_lp");
  var_0._id_872A = self;
  thread _id_95A0(var_3 == "s2_tactical_insertion_cavalry_mp", 0);
  thread _id_99C2();
  var_0 thread _id_9A30(self);
  thread tiwatchraidsboundarychange(var_0);
  _id_5FB8(1);
}

_id_95A0(var_0, var_1) {
  self endon("change_owner");

  if(isDefined(var_0) && var_0) {
    if(isDefined(var_1) && var_1) {
      self._id_359B["friendly"] = _func_14B(common_scripts\utility::_id_44F5("tactical_insertion_cavalry_ally_parachuting"), self gettagorigin("tag_fx"));
      self._id_359B["enemy"] = _func_14B(common_scripts\utility::_id_44F5("tactical_insertion_cavalry_enemy_parachuting"), self gettagorigin("tag_fx"));
    } else {
      self._id_359B["friendly"] = _func_14B(common_scripts\utility::_id_44F5("tactical_insertion_cavalry_ally"), self gettagorigin("tag_fx"));
      self._id_359B["enemy"] = _func_14B(common_scripts\utility::_id_44F5("tactical_insertion_cavalry_enemy"), self gettagorigin("tag_fx"));
    }
  } else {
    self._id_359B["friendly"] = _func_14B(common_scripts\utility::_id_44F5("tactical_insertion_beacon_ally"), self gettagorigin("tag_fx"));
    self._id_359B["enemy"] = _func_14B(common_scripts\utility::_id_44F5("tactical_insertion_beacon_enemy"), self gettagorigin("tag_fx"));
  }

  thread _id_61D1();
}

tiwatchraidsboundarychange(var_0) {
  if(level.gametype != "raid" || !isDefined(level._id_1B69)) {
    return;
  }
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("raid_boundaries_changed");

    foreach(var_3, var_2 in level._id_1B69) {
      if(var_0.team != var_2.team && (var_2._id_931A == "active" || var_2._id_931A == "incoming")) {
        if(var_2._id_9D65 _meth_858B(self._id_7464)) {
          level thread maps\mp\gametypes\_rank::_id_1457("tac_insert_destroyed", var_0);
          _id_052C::_id_2D54(self);
        }
      }
    }
  }
}

_id_99C2() {
  self endon("death");
  self _meth_82C3(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0) && !_func_1EF(var_0)) {
      continue;
    }
    if(!_id_3ECD(self._id_0117, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9) {
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    break;
  }

  if(isDefined(self._id_0117) && isDefined(self._id_0117._id_6E6B) && self._id_0117._id_6E6B) {
    return;
  }
  if(isDefined(var_8) && var_8 &level._id_5039)
    self._id_A86F = 1;

  self._id_A86E = 1;

  if(isPlayer(var_0))
    var_0 _id_04C7::_id_A102("bouncing_betty");

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self._id_0117)) {
      var_10 = var_0.pers["team"];
      var_11 = self._id_0117.pers["team"];

      if(isDefined(var_10) && isDefined(var_11) && var_10 != var_11) {
        var_0 notify("destroyed_explosive");
        level thread maps\mp\gametypes\_rank::_id_1457("tac_insert_enemy_destroyed", var_0, var_9);
        level thread maps\mp\gametypes\_rank::_id_1457("tac_insert_destroyed", self._id_0117);
        var_0 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

        if(var_0 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
      }
    }
  } else if(isDefined(self._id_0117) && isDefined(var_0) && var_0 != self._id_0117) {
    var_0 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::_id_1457("tac_insert_enemy_destroyed", var_0, var_9);
    level thread maps\mp\gametypes\_rank::_id_1457("tac_insert_destroyed", self._id_0117);
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

    if(var_0 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
      var_0 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
  }

  playFX(level._id_9062, self.origin);
  self._id_0117 thread maps\mp\_utility::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  self._id_0117 _meth_85EF(&"tac_insert_destroyed", 0);
  self._id_0117._id_6E6E = 0;
  self._id_0117._id_872A = undefined;
  _id_052C::_id_2D54(self);
}

_id_A6E2(var_0, var_1) {
  var_0 endon("airstrike_complete");
  var_1 thread _id_9A25(var_0);
  var_1 thread _id_9A24(var_0);

  while(!_id_0527::_id_34AE(var_0, var_0._id_34AC, 50))
    waitframe();

  var_1 thread _id_9A23();
  var_1 notify("paratrooperInsertDroppedFromPlane");
}

_id_9A25(var_0) {
  self _meth_808C();
  self setOrigin(var_0.origin);
  self _meth_8322();
  self._id_6E6B = 1;
  self _meth_8077(var_0, undefined, 0, 180, 180, 180, 180, 1);
}

_id_9A24(var_0) {
  var_0 endon("airstrike_complete");
  var_0 waittill("crashing");
  thread _id_5A80();
}

_id_5A80() {
  _id_052C::_id_2D54(self._id_6E6D);
  self _meth_8059(120, self.origin);
}

_id_9A30(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  self waittill("spawned_player");

  if(!self._id_99BD) {
    return;
  }
  self._id_6E6F = self.origin;
  self._id_6E6D = var_0;
  _id_052C::_id_2D54(var_0);
}

monitorparatrooperparachutingbeacon(var_0) {
  level endon("game_ended");

  while(isDefined(self) && maps\mp\_utility::isreallyalive(self) && isDefined(self._id_6E6B) && self._id_6E6B)
    waitframe();

  _id_052C::_id_2D54(var_0);
}

_id_A931() {
  self endon("disconnect");
  self endon("stop_watchTISpawn");
  self._id_6E6E = 1;
  self._id_6E6C = 1;
  self waittill("spawned_player");

  if(!isDefined(self._id_6E6E) || !self._id_6E6E) {
    return;
  }
  self._id_6E6E = 0;

  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    return;
  }
  self._id_6E6B = 1;
  self._id_6E6F = self.origin;
  self.paratrooperinsertgroundposition = self.origin;
  self.playerparachutemovementenabled = 0;
  self.playerparachuteweaponsenabled = 1;
  self.playerparachutedamageenabled = 1;
  self.playerparachuteweaponsactiveatcertaindropheight = 400;

  if(maps\mp\_utility::_id_579B()) {
    self.playerparachutedropunitsperframeoverride = -16;
    self.playerparachutedropsprintingunitsperframeoverride = -26;
    self.playerparachutedropadsunitsperframeoverride = -12;
    self.playerparachutehealth = 125;
    var_0 = 1;
  } else {
    self.playerparachutedropunitsperframeoverride = -22;
    self.playerparachutedropsprintingunitsperframeoverride = -36;
    self.playerparachutedropadsunitsperframeoverride = -16;
    self.playerparachutehealth = 175;
    var_0 = 0;
  }

  var_1 = _func_071("s2_tactical_insertion_cavalry_mp", self.origin, (0, 0, 0), 400, self, 1);
  var_1._id_0117 = self;
  var_1 thread _id_95A0(1, 1);
  self._id_6E6D = var_1;
  thread monitorparatrooperparachutingbeacon(var_1);
  thread _id_0523::player_paratrooper(self._id_6E6F, undefined, var_0);

  if(maps\mp\_utility::_id_579B()) {
    self._id_4B97 = undefined;
    self notify("removed_spawn_protection");
  }
}

_id_9A23() {
  self endon("disconnect");
  var_0 = self._id_6E6F;
  self _meth_8322();
  self._id_6E6B = 1;
  var_1 = _func_1B5("tactical_insertion_parachute_mp", self.origin, var_0);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2 linktosynchronizedparent(var_1);
  var_3 = spawn("script_model", var_2.origin);
  var_3 _meth_805C();

  if(self.team == "allies")
    var_3 setModel("usa_carepackage_parachute_anim");
  else
    var_3 setModel("ger_carepackage_parachute_anim");

  var_3._id_62A0 = 0.5;
  var_3 _meth_8276("carepackage_parachute_loop", "finished_ti_paratrooper_insert");
  var_3 linktosynchronizedparent(var_2, "tag_origin", (20, -20, 40), (0, 90, 0));
  var_3 _meth_805B();
  self.angles = var_3 _meth_8181("tag_crate");
  self.origin = var_3 gettagorigin("tag_crate");
  self _meth_8077(var_3, "tag_crate", 0, 180, 180, 180, 180, 1);
  self _meth_8009(1);
  var_4 = spawn("script_model", var_3.origin);
  var_4.angles = var_3.angles;
  var_4 setModel("ger_carepackage_parachute");
  var_4 _meth_82C3(1);
  var_4 _meth_805C();
  var_4 linktosynchronizedparent(var_3);
  var_4 thread _id_9A20(var_1, self);
  thread _id_9A21(var_0);
  thread _id_9A22();
  var_1 thread _id_9A1F(self, var_2, var_3, var_4);
}

_id_9A20(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("paratrooper_released");

  for(;;) {
    self waittill("damage", var_2, var_3);

    if(isDefined(var_3)) {
      if(isDefined(var_1) && (level.teambased && isDefined(var_3.team) && var_3.team != var_1.team) || !level.teambased && var_3 != var_1) {
        var_3 thread _id_04C7::_id_A102("standard");
        var_1 _meth_8059(var_2, var_3.origin, var_3);
        var_1._id_5723 = 1;
        var_0 notify("death");
        var_1 notify("paratrooper_released");
        _id_052C::_id_2D54(self._id_6E6D);
        return;
      }
    }
  }
}

_id_9A22() {
  self endon("disconnect");
  self endon("paratrooper_released");
  self waittill("death");
  _id_052C::_id_2D54(self._id_6E6D);
}

_id_9A21(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("paratrooper_released");

  for(;;) {
    if(self.origin[2] < var_0[2] + 500) {
      break;
    }

    wait 0.1;
  }

  self _meth_8323();
}

_id_9A1F(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(var_0 maps\mp\_utility::_hasperk("specialty_falldamage"))
    var_0 maps\mp\_utility::_id_0735("specialty_falldamage");

  var_0 maps\mp\_utility::giveperk("specialty_moreminimap");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 notify("paratrooper_released");
    var_0 _meth_8009(0);
    var_0 _meth_8057();

    if(!isDefined(var_0._id_5723) || !var_0._id_5723) {
      var_0._id_6E6B = 0;

      if(var_0 maps\mp\_utility::_hasperk("specialty_falldamage"))
        var_0 maps\mp\_utility::giveperk("specialty_falldamage");

      var_0 maps\mp\_utility::_id_0735("specialty_moreminimap");
    }
  }

  var_2 _meth_8278("carepackage_parachute_detach");
  var_2 common_scripts\utility::_id_2CBE(2.7, ::delete);
  var_1 common_scripts\utility::_id_2CBE(3, ::delete);
  var_3 delete();
}

_id_499D(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("death");
  self waittill("missile_stuck");

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_3 = var_2["position"];

  if(var_2["fraction"] == 1) {
    var_3 = _func_082(self.origin, 12, 0, 32);
    var_2["normal"] = var_2["normal"] * -1;
  }

  var_4 = vectorNormalize(var_2["normal"]);
  var_5 = vectortoangles(var_4);
  var_5 = var_5 + (90, 0, 0);
  var_6 = spawn("script_model", var_3);
  var_6.angles = var_5;
  var_6 setModel("ger_barbed_wire_pile_02");
  self waittill("explode", var_7);
  maps\mp\_utility::playsoundinspace("wpn_smoke_grenade_exp", var_7);
  var_8 = spawnStruct();
  var_8._id_2994 = 11;
  var_8._id_6C2C = var_7;
  var_8._id_629C = var_6;
  thread _id_158A(var_8, var_0, var_1);
  thread _id_158B(var_8, var_0);
  thread _id_158C(var_8, var_0);
}

_id_158A(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    foreach(var_4 in level.players) {
      if(var_4 != var_1 && level.teambased && var_4.team == var_1.team) {
        continue;
      }
      if(distancesquared(var_4.origin, var_0._id_6C2C) < 14400)
        var_4 _meth_8059(var_0._id_2994, var_0._id_6C2C, var_1, self, "MOD_IMPACT", var_2);
    }

    self waittill("explode");
  }
}

_id_158B(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  self waittill("death");

  if(isDefined(var_0) && isDefined(var_0._id_629C))
    var_0._id_629C delete();
}

_id_158C(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  var_1 waittill("disconnect");

  if(isDefined(var_0) && isDefined(var_0._id_629C))
    var_0._id_629C delete();
}

_id_49C8(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  self._id_2B71 = common_scripts\utility::_id_0FA0(self._id_2B71);

  if(self._id_2B71.size >= level._id_6092) {
    self._id_2B71[0] notify("remove");
    self._id_2B71[0] delete();
  }

  self._id_2B71[self._id_2B71.size] = var_0;

  for(;;) {
    var_0 waittill("explode");

    if(!isDefined(var_0._id_3C4C)) {
      var_0._id_3C4C = 1;
      var_0._id_28D3 = _id_04D1::_id_45A9();
      _func_1CE(var_0._id_28D3, "invisible", (0, 0, 0));
      _func_1D2(var_0._id_28D3, var_0.origin);
      _func_1D1(var_0._id_28D3, "cb_compassping_enemy_objective");

      if(!level.teambased)
        _func_186(var_0._id_28D3, self getentitynumber());
      else
        _func_183(var_0._id_28D3, level._id_6C63[self.team]);

      var_0 thread _id_2D06(var_0._id_28D3);
    }

    _func_1D0(var_0._id_28D3, "active");
    wait 2;
    _func_1D0(var_0._id_28D3, "invisible");
  }
}

_id_2D06(var_0) {
  common_scripts\utility::_id_A732("death", "remove");
  _func_1D0(var_0, "active");
  wait 2;
  _func_1D0(var_0, "invisible");
  maps\mp\_utility::_objective_delete(var_0);
}

_id_A184() {
  self endon("death");

  for(;;) {
    if(isDefined(self) && isDefined(self._id_9D65)) {
      self._id_9D65.origin = self.origin;

      if(isDefined(self._id_1907))
        self._id_1907.origin = self.origin;
    } else
      return;

    waitframe();
  }
}

_id_2334() {
  self endon("death");
  self endon("change_owner");
  var_0 = spawn("trigger_radius", self.origin + (0, 0, 0 - level._id_2333), 0, level._id_2333, level._id_2333 * 2);
  thread _id_2D40(var_0);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(self._id_94B9) {
      waitframe();
      continue;
    }

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self._id_0117)) {
        if(var_1 == self._id_0117) {
          continue;
        }
        if(isDefined(var_1._id_0117) && var_1._id_0117 == self._id_0117)
          continue;
      }

      if(!_id_3ECD(self._id_0117, var_1, 0))
        continue;
    }

    if(_func_0E5(var_1 _meth_81AD()) < 10) {
      continue;
    }
    var_2 = _func_0AE(var_1.origin[2] - self.origin[2]);

    if(var_2 > 128) {
      continue;
    }
    if(!var_1 _id_8B85(self)) {
      continue;
    }
    if(var_1 _meth_81D7(self.origin, self) > 0) {
      break;
    }
  }

  self playSound("claymore_activated");
  var_3 = isPlayer(self._id_0117) && self._id_0117 maps\mp\_utility::_hasperk("specialty_shortfuse");
  var_4 = isPlayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_delaymine");

  if(var_3 && var_4)
    wait(level._id_2331);
  else if(var_3)
    wait(level.shortminetime);
  else if(var_4) {
    var_1 notify("triggered_claymore");
    wait(level._id_2CE8);
  } else
    wait(level._id_2331);

  if(isDefined(self._id_9D65))
    self._id_9D65 delete();

  if(isDefined(self._id_0117) && isDefined(level._id_5C44))
    self._id_0117 thread[[level._id_5C44]]("claymore_destroyed", undefined, undefined, self.origin);

  self _meth_81D6();
}

_id_8B85(var_0) {
  if(isDefined(var_0._id_2F74))
    return 0;

  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < level._id_2332)
    return 0;

  var_2 = vectorNormalize(var_2);
  var_5 = vectordot(var_2, var_3);
  return var_5 > level._id_2330;
}

_id_2D40(var_0) {
  self waittill("death");
  waitframe();

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_9D65))
      var_0._id_9D65 delete();

    var_0 delete();
  }
}

_id_2D37(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(var_0._id_9D65))
      var_0._id_9D65 delete();

    var_0 delete();
  }
}

_id_A925() {
  self endon("death");
  self endon("disconnect");
  self endon("all_detonated");
  level endon("game_ended");
  self endon("change_owner");
  var_0 = 0;

  for(;;) {
    if(self _meth_8341()) {
      var_0 = 0;

      while(self _meth_8341()) {
        var_0 = var_0 + 0.05;
        waitframe();
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while(!self _meth_8341() && var_0 < 0.35) {
        var_0 = var_0 + 0.05;
        waitframe();
      }

      if(var_0 >= 0.35) {
        continue;
      }
      if(!self._id_5FDB.size) {
        return;
      }
      self notify("detonate_double_tap");
    }

    waitframe();
  }
}

_id_A924() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  for(;;) {
    self waittill("detonate");
    _id_5FD9(1);
  }
}

_id_A923() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  for(;;) {
    self waittill("detonate_double_tap");
    var_0 = self getcurrentweapon();

    if(!_func_27E(var_0))
      _id_5FD9(2);
  }
}

_id_5FD9(var_0) {
  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < self._id_5FDB.size; var_3++) {
    if(!self._id_5FDB[var_3][var_0]) {
      var_1 = 1;
      continue;
    }

    var_4 = self._id_5FDB[var_3][0];

    if(isDefined(var_4)) {
      if(var_4._id_94B9) {
        var_1 = 1;
        return;
      }

      if(isDefined(var_4._id_A9E0) && !self _meth_84D0(var_4._id_A9E0)) {
        var_1 = 1;
        continue;
      }

      if(isDefined(var_4._id_5FDC)) {
        self thread[[var_4._id_5FDC]](var_4);
        continue;
      }

      var_4 thread _id_A684(0, var_0);
    }
  }

  if(var_1)
    self._id_5FDB = _id_5FDA(self._id_5FDB);
  else {
    self._id_5FDB = var_2;
    self notify("all_detonated");
  }
}

_id_A684(var_0, var_1) {
  self endon("death");
  wait(var_0);
  _id_A77C();

  if(var_1 == 2)
    self _meth_8520();
  else
    self _meth_81D6();

  level._id_61ED = common_scripts\utility::_id_0FA0(level._id_61ED);
}

_id_2D2E() {
  self endon("faux_spawn");
  self endon("death");
  self waittill("disconnect");
  var_0 = self._id_5FDB;
  var_1 = self._id_232F;
  waitframe();

  if(isDefined(var_0)) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      if(isDefined(var_0[var_2][0]))
        var_0[var_2][0] delete();
    }
  }

  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]))
        var_1[var_2] delete();
    }
  }
}

_id_1DF0() {
  self endon("death");
  self endon("make_dud");
  self _meth_82C3(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0) && !_func_1EF(var_0)) {
      continue;
    }
    if(!_id_3ECD(self._id_0117, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9) {
        case "signal_flare_expeditionary_mp":
        case "signal_flare_mp":
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    break;
  }

  if(level._id_1DF7)
    wait(0.1 + _func_0A3(0.4));
  else
    waitframe();

  if(!isDefined(self)) {
    return;
  }
  level._id_1DF7 = 1;
  thread _id_7D54();

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE")))
    self._id_A86B = 1;

  if(isDefined(var_8) && var_8 &level._id_5039)
    self._id_A86F = 1;

  self._id_A86E = 1;

  if(isPlayer(var_0))
    var_0 _id_04C7::_id_A102("c4");

  if(isDefined(var_0) && isDefined(var_0._id_5CC6) && var_0 != self._id_0117)
    self._id_5CC6 = var_0._id_5CC6;

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self._id_0117)) {
      var_10 = var_0.pers["team"];
      var_11 = self._id_0117.pers["team"];

      if(isDefined(var_10) && isDefined(var_11) && var_10 != var_11) {
        var_0 notify("destroyed_explosive");
        level thread maps\mp\gametypes\_rank::_id_1457("equipment_destroyed", var_0, var_9);
        var_0 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

        if(var_0 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
      }
    }
  } else if(isDefined(self._id_0117) && isDefined(var_0) && var_0 != self._id_0117) {
    var_0 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::_id_1457("equipment_destroyed", var_0, var_9);
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

    if(var_0 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
      var_0 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
  }

  if(isDefined(self._id_9D65))
    self._id_9D65 delete();

  self _meth_81D6(var_0);
}

_id_7D54() {
  waitframe();
  level._id_1DF7 = 0;
}

_id_8077(var_0, var_1) {
  for(var_2 = 0; var_2 < 60; var_2++)
    waitframe();
}

_id_A77C() {
  if(!isDefined(self._id_2F74)) {
    return;
  }
  self waittill("enabled");
}

_id_5FB8(var_0) {
  common_scripts\utility::_id_5FA9(self._id_0117.team);

  if(!isDefined(var_0) || !var_0)
    self _meth_838B();

  if(_func_0C3(self))
    self _meth_8173("DogsDontAttack");
}

_id_8A08() {
  self._id_1906 = [];

  if(self.detectexplosives && !self.bombsquadicons.size) {
    for(var_0 = 0; var_0 < 4; var_0++) {
      self.bombsquadicons[var_0] = _func_19B(self);
      self.bombsquadicons[var_0].x = 0;
      self.bombsquadicons[var_0].y = 0;
      self.bombsquadicons[var_0]._id_01D9 = 0;
      self.bombsquadicons[var_0].alpha = 0;
      self.bombsquadicons[var_0].archived = 1;
      self.bombsquadicons[var_0] setshader("waypoint_bombsquad", 14, 14);
      self.bombsquadicons[var_0] _meth_80CB(0, 0);
      self.bombsquadicons[var_0]._id_2E53 = "";
    }
  } else if(!self.detectexplosives) {
    for(var_0 = 0; var_0 < self.bombsquadicons.size; var_0++)
      self.bombsquadicons[var_0] destroy();

    self.bombsquadicons = [];
  }
}

_id_8BFE(var_0) {
  var_1 = var_0._id_2E53;
  var_2 = -1;

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = self.bombsquadicons[var_3]._id_2E53;

    if(var_4 == var_1) {
      return;
    }
    if(var_4 == "")
      var_2 = var_3;
  }

  if(var_2 < 0) {
    return;
  }
  self._id_1906[var_1] = 1;
  self.bombsquadicons[var_2].x = var_0.origin[0];
  self.bombsquadicons[var_2].y = var_0.origin[1];
  self.bombsquadicons[var_2]._id_01D9 = var_0.origin[2] + 24 + 128;
  self.bombsquadicons[var_2] fadeovertime(0.25);
  self.bombsquadicons[var_2].alpha = 1;
  self.bombsquadicons[var_2]._id_2E53 = var_0._id_2E53;

  while(isalive(self) && isDefined(var_0) && self istouching(var_0))
    waitframe();

  if(!isDefined(self)) {
    return;
  }
  self.bombsquadicons[var_2]._id_2E53 = "";
  self.bombsquadicons[var_2] fadeovertime(0.25);
  self.bombsquadicons[var_2].alpha = 0;
  self._id_1906[var_1] = undefined;
}

_id_4486(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_5 = var_1 * var_1;
  var_6 = level.players;

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7].sessionstate != "playing") {
      continue;
    }
    var_8 = maps\mp\_utility::get_damagable_player_pos(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);

    if(var_9 < var_5 && (!var_2 || _id_A9C3(var_0, var_8, var_3, var_6[var_7])))
      var_4[var_4.size] = maps\mp\_utility::get_damagable_player(var_6[var_7], var_8);
  }

  var_10 = getEntArray("grenade", "classname");

  for(var_7 = 0; var_7 < var_10.size; var_7++) {
    var_11 = maps\mp\_utility::get_damagable_grenade_pos(var_10[var_7]);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_A9C3(var_0, var_11, var_3, var_10[var_7])))
      var_4[var_4.size] = maps\mp\_utility::get_damagable_grenade(var_10[var_7], var_11);
  }

  var_12 = getEntArray("destructible", "targetname");

  for(var_7 = 0; var_7 < var_12.size; var_7++) {
    var_11 = var_12[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_A9C3(var_0, var_11, var_3, var_12[var_7]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 0;
      var_13.entity = var_12[var_7];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_14 = getEntArray("destructable", "targetname");

  for(var_7 = 0; var_7 < var_14.size; var_7++) {
    var_11 = var_14[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_A9C3(var_0, var_11, var_3, var_14[var_7]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 1;
      var_13.entity = var_14[var_7];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_15 = getEntArray("misc_turret", "classname");

  foreach(var_17 in var_15) {
    var_11 = var_17.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_A9C3(var_0, var_11, var_3, var_17))) {
      switch (var_17.model) {
        case "vehicle_ugv_talon_gun_cloaked_mp":
        case "vehicle_ugv_talon_gun_mp":
        case "mp_remote_turret":
        case "mp_scramble_turret":
        case "sentry_minigun_weak":
          var_4[var_4.size] = maps\mp\_utility::get_damagable_sentry(var_17, var_11);
          break;
      }
    }
  }

  var_19 = getEntArray("script_model", "classname");

  foreach(var_21 in var_19) {
    if(var_21.model != "npc_ger_smi44_bouncing_betty" && var_21.model != "ims_scorpion_body") {
      continue;
    }
    var_11 = var_21.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_A9C3(var_0, var_11, var_3, var_21)))
      var_4[var_4.size] = maps\mp\_utility::_id_4139(var_21, var_11);
  }

  return var_4;
}

_id_44B3(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_5 = getEntArray("grenade", "classname");

  foreach(var_7 in var_5) {
    var_8 = var_7.origin;
    var_9 = distance(var_0, var_8);

    if(var_9 < var_1 && (!var_2 || _id_A9C3(var_0, var_8, var_3, var_7)))
      var_4[var_4.size] = var_7;
  }

  var_11 = getEntArray("misc_turret", "classname");

  foreach(var_13 in var_11) {
    var_8 = var_13.origin;
    var_9 = distance(var_0, var_8);

    if(var_9 < var_1 && (!var_2 || _id_A9C3(var_0, var_8, var_3, var_13)))
      var_4[var_4.size] = var_13;
  }

  return var_4;
}

_id_A9C3(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(_func_0E5(var_5) < var_2 * var_2)
    return 1;

  var_6 = vectorNormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = bulletTrace(var_4, var_1, 0, var_3);

  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread _id_2B5B(var_0, ".dmg");

    if(isDefined(var_3))
      thread _id_2B5B(var_1, "." + var_3.classname);
    else
      thread _id_2B5B(var_1, ".undefined");

    if(var_7["fraction"] == 1)
      thread _id_2B57(var_4, var_1, (1, 1, 1));
    else {
      thread _id_2B57(var_4, var_7["position"], (1, 0.9, 0.8));
      thread _id_2B57(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

_id_29C0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self._id_29D2 = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
  } else {
    if(self.isadestructable && (var_4 == "artillery_mp" || var_4 == "claymore_mp" || var_4 == "airstrike_bomb_mp" || var_4 == "airstrike_bomb_axis_mp" || var_4 == "firebomb_bomb_mp" || var_4 == "firebomb_bomb_axis_mp" || var_4 == "firebomb_bomb_grenadier_mp" || var_4 == "firebomb_bomb_axis_grenadier_mp")) {
      return;
    }
    self.entity notify("damage", var_2, var_1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_4);
  }
}

_id_2B57(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 600;
}

_id_2B4D(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 16;

  var_5 = 360 / var_3;
  var_6 = [];

  for(var_7 = 0; var_7 < var_3; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = _func_0A7(var_8) * var_1;
    var_10 = _func_0A6(var_8) * var_1;
    var_11 = var_0[0] + var_9;
    var_12 = var_0[1] + var_10;
    var_13 = var_0[2];
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_14 = var_6[var_7];

    if(var_7 + 1 >= var_6.size)
      var_15 = var_6[0];
    else
      var_15 = var_6[var_7 + 1];

    thread _id_2B57(var_14, var_15, var_2, var_4);
  }
}

_id_2B5B(var_0, var_1) {
  for(var_2 = 0; var_2 < 600; var_2++)
    waitframe();
}

_id_6BCD(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_5 = 700;
  var_6 = 25;
  var_7 = var_5 * var_5;
  var_8 = var_6 * var_6;
  var_9 = 60;
  var_10 = 40;
  var_11 = 11;

  if(issubstr(var_1, "_uts19_"))
    thread _id_A263(var_0);
  else {
    switch (var_1) {
      case "stun_grenade_mp":
      case "concussion_grenade_mp":
        var_12 = 512;

        if(isDefined(var_4) && var_4 maps\mp\_utility::_hasperk("specialty_improvedtacticals")) {
          var_13 = 2.5;
          var_14 = 4.25;
        } else {
          var_13 = 1.75;
          var_14 = 3.5;
        }

        _id_2578(self, var_0, var_4, var_2, var_12, var_13, var_14);
        break;
      case "signal_flare_expeditionary_mp":
      case "signal_flare_mp":
        break;
      case "flash_grenade_mp":
        _id_3D43(self, var_0.origin, var_4);
        break;
      case "weapon_cobra_mk19_mp":
        break;
      case "role_barbed_wire_mp":
      case "tabun_grenade_mp":
        if(!maps\mp\_utility::_hasperk("specialty_stun_resistance") && !common_scripts\utility::_id_562E(self._id_4B97)) {
          self _meth_8182("mp_radiation_med", 1);
          self._id_3FE5 = gettime() + 1000;
        }

        break;
      case "teslagunmtx_mp":
        var_12 = 200;
        var_13 = 0.2;
        var_14 = 2;

        if(self == var_4)
          var_12 = var_12 * 0.5;

        _id_2578(self, var_0, var_4, var_2, var_12, var_13, var_14);
        break;
      default:
        _id_050A::_id_8AF0(var_2, var_3);
        break;
    }
  }
}

_id_A263(var_0) {
  if(getdvarint("scr_game_uts19_shock", 0) == 0) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0.45;
  var_2 = 1.2;
  var_3 = 250;
  var_4 = 700;
  var_5 = (distance(self.origin, var_0.origin) - var_3) / (var_4 - var_3);
  var_6 = 1 - var_5;
  var_6 = clamp(var_6, 0, 1);
  var_7 = var_1 + (var_2 - var_1) * var_6;

  if(isDefined(self._id_A264)) {
    if(self._id_A264 >= var_7)
      return;
  }

  self._id_A264 = var_7;
  self _meth_8182("uts19_mp", var_7);
  waittillframeend;

  if(isDefined(self))
    self._id_A264 = undefined;
}

_id_5795(var_0) {
  if(var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  switch (weaponclass(var_0)) {
    case "beam":
    case "mg":
    case "pistol":
    case "smg":
    case "rifle":
    case "rocketlauncher":
    case "sniper":
    case "spread":
      return 1;
    default:
      return 0;
  }
}

_id_57F6(var_0) {
  if(var_0 == "none")
    return 0;

  switch (var_0) {
    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
    case "decoy_device_mp":
    case "tabun_grenade_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "stun_grenade_mp":
    case "flash_grenade_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
      return 1;
    default:
      return 0;
  }
}

_id_5747(var_0) {
  if(var_0 == "none")
    return 0;

  switch (var_0) {
    case "thermite_mp":
    case "bouncingbetty_mp":
    case "frag_grenade_german_mp":
    case "throwingknife_mp":
    case "c4_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 1;
    default:
      return 0;
  }
}

_id_5756(var_0) {
  if(_func_1A9(var_0) == "melee")
    return 1;

  return 0;
}

_id_5696(var_0) {
  if(var_0 == "none")
    return 0;

  switch (maps\mp\_utility::getweaponclass(var_0)) {
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_heavy":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
      return 1;
    default:
      return 0;
  }
}

_id_5684(var_0) {
  return 0;
}

_id_5735(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "item";
}

_id_57AE(var_0) {
  if(var_0 == "none")
    return 0;

  return _func_1A9(var_0) == "riotshield";
}

_id_5762(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "offhand";
}

_id_57CD(var_0) {
  if(var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  return weaponclass(var_0) == "pistol";
}

_id_5707(var_0) {
  var_1 = weaponclass(var_0);
  var_2 = weaponinventorytype(var_0);

  if(var_1 != "grenade")
    return 0;

  if(var_2 != "offhand")
    return 0;

  return 1;
}

_id_582E(var_0) {
  if(!isDefined(var_0) || var_0 == "none")
    return 0;

  var_1 = weaponinventorytype(var_0);
  return var_1 == "primary" || var_1 == "altmode";
}

_id_534B() {
  self.currentweapon = self._id_2954;
  self._id_8061 = self.currentweapon;
  _id_8A68(self.currentweapon);
}

_id_A15E(var_0) {
  _id_A196();
  _id_8A68(var_0);

  if(_id_5831(var_0))
    _id_A13B();

  self._id_8061 = self.currentweapon;

  if(_id_582E(var_0))
    self.currentweapon = var_0;
}

_id_A196() {
  if(isDefined(self._id_A9F7) && isDefined(self._id_A9F6)) {
    var_0 = int((gettime() - self._id_A9F7) / 1000);
    thread _id_8A67(self._id_A9F6, var_0, "timeInUse");
  }
}

_id_8A68(var_0) {
  self._id_A9F6 = var_0;
  self._id_A9F7 = gettime();
}

_id_5831(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(_id_582E(var_0))
    return 1;

  var_1 = weaponclass(var_0);

  if(var_1 == "ball")
    return 1;

  return 0;
}

_id_A13B() {
  var_0 = level._id_162E;

  if(isDefined(level.gametypemovespeedscalefunc))
    var_0 = var_0 * self[[level.gametypemovespeedscalefunc]]();

  if(isDefined(self._id_5525) && self._id_5525)
    var_0 = var_0 * self.watermovespeedscale;

  if(isDefined(self.agentspeedscale))
    var_0 = var_0 * self.agentspeedscale;

  if(isDefined(self.zombietrainingmovespeedscale))
    var_0 = var_0 * self.zombietrainingmovespeedscale;

  if(isDefined(self._id_1649) && self._id_1649 > 0)
    var_0 = var_0 * level.battlecrymovespeedscale;

  if(isDefined(self._id_53C5) && self._id_53C5)
    var_0 = var_0 * level.raidtriggermovespeedscale;

  if(isDefined(self._id_4B9A) && self._id_4B9A)
    var_0 = var_0 * level.steelbibmovespeedscale;

  if(isDefined(self._id_4B66) && self._id_4B66)
    var_0 = var_0 * level.extremeconditioningmovespeedscale;

  if(isDefined(self._id_4B64) && self._id_4B64)
    var_0 = var_0 * level.doronvestmovespeedscale;

  if(isDefined(self._id_4B50) && self._id_4B50)
    var_0 = var_0 * level.adrenalineshotmovespeedscale;

  if(isDefined(self._id_5720) && self._id_5720)
    var_0 = var_0 * level.fightorflightmovespeedscale;

  if(maps\mp\_utility::_hasperk("specialty_crouchmovement") && self _meth_8178() == "crouch")
    var_0 = var_0 * level.crouchperkmovespeedscale;

  if(isDefined(self._id_165B) && self._id_165B) {
    if(isDefined(self.shieldchargeactive) && self.shieldchargeactive)
      var_0 = var_0 * level.shieldchargemovespeedscale;
    else
      var_0 = var_0 * level.bayonetchargemovespeedscale;
  }

  if(maps\mp\_utility::_hasperk("specialty_sprintfasterovertime") && isDefined(self.sprintfasterovertimemovespeedscale))
    var_0 = var_0 * self.sprintfasterovertimemovespeedscale;

  if(isDefined(self.raidmaniac) && self.raidmaniac)
    var_0 = var_0 * level.raidmaniacmovespeedscale;

  if(isDefined(self.raidcombatbuff) && self.raidcombatbuff)
    var_0 = var_0 * level.raidcombatbuffmovespeedscale;

  if(maps\mp\_utility::_hasperk("specialty_sessionProgressionB") && isDefined(self.pers["sessionProgressionB_Modifier"]))
    var_0 = var_0 * _id_052C::getgrenadiermodvalue_b();

  if(isDefined(level.gametypemovespeedmaxscalar))
    var_0 = _func_0AF(var_0, level.gametypemovespeedmaxscalar);

  self _meth_81E1(var_0);
}

_id_9161() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self _meth_82E1("adjustedStance", "+stance");
  self _meth_82E1("adjustedStance", "+goStand");

  for(;;) {
    common_scripts\utility::_id_A70A("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
    self._id_915E = self _meth_8178();

    if(self._id_915E == "prone") {
      var_0 = self _meth_8317();
      var_1 = maps\mp\_utility::getweaponclass(var_0);

      if(var_1 == "weapon_lmg")
        maps\mp\_utility::_id_870F(0, 40);
      else if(var_1 == "weapon_sniper")
        maps\mp\_utility::_id_870F(0, 60);
      else
        maps\mp\_utility::_id_870F();

      continue;
    }

    if(self._id_915E == "crouch") {
      var_0 = self _meth_8317();
      var_1 = maps\mp\_utility::getweaponclass(var_0);

      if(var_1 == "weapon_lmg")
        maps\mp\_utility::_id_870F(0, 10);
      else if(var_1 == "weapon_sniper")
        maps\mp\_utility::_id_870F(0, 30);
      else
        maps\mp\_utility::_id_870F();

      continue;
    }

    maps\mp\_utility::_id_870F();
  }
}

_id_1D65() {}

_id_57C3(var_0) {
  if(!isDefined(var_0._id_A9E0))
    return 0;

  if(!issubstr(var_0._id_A9E0, "semtex"))
    return 0;

  return 1;
}

_id_9304(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!_id_57C3(var_0)) {
    return;
  }
  var_0 thread _id_63DE();
}

_id_63DE() {
  self._id_0117 endon("disconnect");
  self._id_0117 endon("death");
  self._id_0117 endon("faux_spawn");
  self endon("death");
  self waittill("missile_stuck", var_0);
  thread _id_93A1("detonate");
  playFX(common_scripts\utility::_id_44F5("sticky_grenade_splat"), self.origin, anglesToForward(self.angles + (0, 180, 0)));

  if(!isPlayer(var_0)) {
    return;
  }
  if(self._id_0117 _id_57E7(var_0)) {
    self._id_0117._id_57E6 = "friendly";
    return;
  }

  self._id_57E6 = "enemy";
  self._id_9488 = var_0;

  if(!isDefined(self._id_0117.stuckenemy))
    self._id_0117.stuckenemy = 0;

  self._id_0117.stuckenemy++;
  self._id_0117 _id_047A::_id_83CD(var_0);
  self._id_0117 notify("process", "ch_bullseye");
}

_id_57E7(var_0) {
  return level.teambased && isDefined(var_0.team) && var_0.team == self.team;
}

_id_9F3A() {
  if(maps\mp\_utility::isprophuntgametype()) {
    self delete();
    return;
  }

  thread turret_heat_thread();

  for(;;) {
    self waittill("trigger", var_0);
    thread _id_9F4A(var_0);
  }
}

_id_9F4A(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notify("weapon_change", "none");
  self waittill("turret_deactivate");
  var_0 notify("weapon_change", var_0 getcurrentweapon());
}

turret_heat_thread() {
  if(turret_heat_store_settings() == 0) {
    return;
  }
  self endon("death");
  self.turretlerp_isheatingup = 0;
  self.turretlerp_lastheatchangetime = 0;
  self.turretlerp_heatpenaltyendtime = 0;
  self.turretlerp_lastheatchangelevel = 0;
  self.turretlerp_isheatingup = 0;
  self.turret_heatlevel = 0;

  for(;;) {
    turret_updateheat();
    waitframe();
  }
}

turret_updateheat() {
  var_0 = self.turretlerp_isheatingup;
  var_1 = gettime();

  if(self.turretlerp_lastheatchangetime >= var_1) {
    return;
  }
  if(var_1 >= self.turretlerp_heatpenaltyendtime) {
    if(!self _meth_8698())
      self _meth_8175();
  }

  var_2 = self.turret_heatlevel;
  self.turret_heatlevel = bg_turret_computeheatlevel(var_1, self.gdt_overheatuprate, self.gdt_overheatdownrate);
  self.turretlerp_isheatingup = self _meth_80D7() && self.turretlerp_heatpenaltyendtime <= var_1;

  if(var_0 != self.turretlerp_isheatingup) {
    self.turretlerp_lastheatchangetime = var_1;
    self.turretlerp_lastheatchangelevel = self.turret_heatlevel;
  }

  if(self.turret_heatlevel >= 100) {
    self.turretlerp_heatpenaltyendtime = var_1 + self.gdt_overheatpenalty * 1000;

    if(isDefined(self.gdt_overheatvfx))
      _func_147(self.gdt_overheatvfx, self, "TAG_FLASH");

    if(isDefined(self.gdt_overheatsound))
      _id_0380::_id_288B(self.gdt_overheatsound, undefined, self);

    self _meth_8158();
  }
}

bg_turret_computeheatlevel(var_0, var_1, var_2) {
  var_3 = self.turretlerp_lastheatchangelevel / 100.0;

  if(var_0 <= self.turretlerp_lastheatchangetime)
    return self.turretlerp_lastheatchangelevel;

  var_4 = (var_0 - self.turretlerp_lastheatchangetime) * 0.001;

  if(self.turretlerp_isheatingup) {
    var_5 = var_4 * var_1;
    var_6 = _func_0AF(var_3 + var_5, 1.0);
  } else {
    var_5 = var_4 * var_2;
    var_6 = max(var_3 - var_5, 0.0);
  }

  return int(var_6 * 100.0);
}

turret_heat_store_settings() {
  if(!isDefined(level.turret_heat_settings)) {
    level.turret_heat_settings["turret_mg42_mp"] = spawnStruct();
    level.turret_heat_settings["turret_mg42_mp"].overheatuprate = 1.3;
    level.turret_heat_settings["turret_mg42_mp"].overheatdownrate = 0.6;
    level.turret_heat_settings["turret_mg42_mp"].overheatpenalty = 3.0;
    level.turret_heat_settings["turret_mg42_mp"].overheatvfx = loadfx("vfx/muzzleflash/minigun_overheat");
    level.turret_heat_settings["turret_mg42_mp"].overheatsound = "wpn_mg42_overheat";
    level.turret_heat_settings["turret_mg42_prone_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_raid_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_raid_crouch_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_raid_crouch_d_day_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_raid_prone_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_raid_stand_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_raid_stand_guardtower_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_zm"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turret_mg42_stand_mp"] = level.turret_heat_settings["turret_mg42_mp"];
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"] = spawnStruct();
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatuprate = 1.3;
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatdownrate = 0.3;
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatpenalty = 2.0;
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatvfx = loadfx("vfx/muzzleflash/minigun_overheat");
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatsound = "wpn_mg42_overheat";
    level.turret_heat_settings["turretweapon_mg42_bucket_mp"] = level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"];
  }

  var_0 = self._id_01D1;

  if(isDefined(var_0)) {
    if(_func_224(var_0)) {
      if(isDefined(level.turret_heat_settings[var_0])) {
        self.gdt_overheatpenalty = level.turret_heat_settings[var_0].overheatpenalty;
        self.gdt_overheatuprate = level.turret_heat_settings[var_0].overheatuprate;
        self.gdt_overheatdownrate = level.turret_heat_settings[var_0].overheatdownrate;
        self.gdt_overheatvfx = level.turret_heat_settings[var_0].overheatvfx;
        self.gdt_overheatsound = level.turret_heat_settings[var_0].overheatsound;
        return 1;
      }
    }
  }

  return 0;
}

turret_spawned_turrets_overheat() {
  var_0 = _func_024();

  for(;;) {
    waitframe();
    var_1 = _func_024();
    var_2 = common_scripts\utility::_id_0F7D(var_1, var_0);

    if(isDefined(var_2)) {
      foreach(var_4 in var_2)
      var_4 thread turret_heat_thread();
    }

    var_0 = var_1;
  }
}

_id_8A2E(var_0, var_1) {
  self._id_94B9 = 0;
  self _meth_8385(var_0);
  level._id_61ED[level._id_61ED.size] = self;
  self._id_5A30 = (0, 0, 4);
  self._id_5A2C = spawn("script_model", self.origin + self._id_5A30);
  self._id_5A2C _meth_834D("explosive");
  self._id_5A2C _meth_8055(self);
  var_0._id_37FB = common_scripts\utility::_id_0FA0(var_0._id_37FB);

  if(var_0._id_37FB.size >= level._id_6092) {
    if(maps\mp\_utility::_id_585F() && isDefined(var_0._id_37FB[0]._id_9D65)) {
      var_0._id_37FB[0]._id_9D65 notify("trigger", var_0);
      waitframe();
    } else
      var_0._id_37FB[0] delete();
  }

  var_0._id_37FB[var_0._id_37FB.size] = self;

  if(!maps\mp\_utility::_id_585F())
    thread _id_27D0("npc_ger_smi44_bouncing_betty_bombsquad", "tag_weapon", var_0);

  thread _id_86CA(var_0.pers["team"]);
  thread _id_61DD();
  thread _id_61EB();
  _id_5FB8(!var_1);
}

_id_61DD() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self _meth_82C3(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0) && !_func_1EF(var_0)) {
      continue;
    }
    if(isDefined(var_9) && var_9 == "bouncingbetty_mp") {
      continue;
    }
    if(!_id_3ECD(self._id_0117, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9) {
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE")))
    self._id_A86B = 1;

  if(isDefined(var_8) && var_8 &level._id_5039)
    self._id_A86F = 1;

  self._id_A86E = 1;

  if(isPlayer(var_0))
    var_0 _id_04C7::_id_A102("bouncing_betty");

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self._id_0117)) {
      var_10 = var_0.pers["team"];
      var_11 = self._id_0117.pers["team"];

      if(isDefined(var_10) && isDefined(var_11) && var_10 != var_11) {
        var_0 notify("destroyed_explosive");
        level thread maps\mp\gametypes\_rank::_id_1457("equipment_destroyed", var_0, var_9);
        var_0 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

        if(var_0 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
      }
    }
  } else if(isDefined(self._id_0117) && isDefined(var_0) && var_0 != self._id_0117) {
    var_0 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::_id_1457("equipment_destroyed", var_0, var_9);
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

    if(var_0 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
      var_0 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
  }

  thread _id_61E3(var_0);
}

_id_61EB() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait 2;
  var_0 = spawn("trigger_radius", self.origin, 0, level._id_61E2, level._id_61E1);
  var_0._id_0117 = self;
  thread _id_61DF(var_0);
  var_1 = undefined;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(self._id_94B9) {
      continue;
    }
    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self._id_0117)) {
        if(var_1 == self._id_0117) {
          continue;
        }
        if(isDefined(var_1._id_0117) && var_1._id_0117 == self._id_0117)
          continue;
      }

      if(!_id_3ECD(self._id_0117, var_1, 0))
        continue;
    }

    if(_func_0E5(var_1 _meth_81AD()) < 10) {
      continue;
    }
    if(var_1 _meth_81D7(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  _id_0378::_id_8D74("wpn_bouncingbetty_trigger");
  var_2 = isPlayer(self._id_0117) && self._id_0117 maps\mp\_utility::_hasperk("specialty_shortfuse");
  var_3 = isPlayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_delaymine");

  if(var_2 && var_3) {
    var_1 notify("triggered_mine");
    wait(level.delayshortminetime);
  } else if(var_2)
    wait(level.shortminetime);
  else if(var_3) {
    var_1 notify("triggered_mine");
    wait(level._id_2CE8);
  } else
    wait(level._id_61E0);

  thread _id_61D2();
}

_id_61DF(var_0) {
  common_scripts\utility::_id_A70A("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  var_0 delete();
}

_id_61EE() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level._id_61EF);
  wait(_func_0A3(0.4));
  self notify("mine_selfdestruct");
  thread _id_61E3();
}

_id_61D2() {
  _id_0378::_id_8D74("wpn_bouncingbetty_spin");

  if(isDefined(self._id_9D65))
    self._id_9D65 delete();

  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("npc_ger_smi44_bouncing_betty");
  var_0._id_0117 = self._id_0117;
  var_0 _meth_8385(self._id_0117);
  var_0._id_A9E0 = self._id_A9E0;
  var_0._id_5A2C = self._id_5A2C;
  var_0._id_5A30 = self._id_5A30;

  if(!maps\mp\_utility::_id_585F())
    var_0 thread _id_27D0("npc_ger_smi44_bouncing_betty_bombsquad", "tag_weapon", self._id_0117);

  var_1 = _func_030(self);
  self._id_5A2C _meth_8057();
  self notify("remove");
  self delete();
  var_2 = var_0.origin + (0, 0, 64);
  var_0 _meth_82B1(var_2, 0.7, 0, 0.65);
  var_0._id_5A2C _meth_82B1(var_2 + var_0._id_5A30, 0.7, 0, 0.65);
  var_0 _meth_82C0((0, 750, 32), 0.7, 0, 0.65);
  var_0 thread _id_74DD();
  wait 0.65;

  if(!var_1)
    var_0 thread _id_61E3();
  else {
    var_0._id_5A2C delete();
    var_0 notify("death");
    var_0 delete();
  }
}

_id_61E3(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_0._id_5CC6) && var_0 != self._id_0117)
    self._id_5CC6 = var_0._id_5CC6;

  if(!isDefined(var_0))
    var_0 = self._id_0117;

  _id_0378::_id_8D74("wpn_bouncingbetty_exp");

  if(!_func_030(self)) {
    var_1 = self gettagorigin("tag_fx");
    playFX(level._id_61C8, var_1);
  }

  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self _meth_805C();

  if(!_func_030(self))
    self _meth_81D5(self.origin, level._id_61DE, level._id_61DB, level._id_61DC, var_0, "MOD_EXPLOSIVE", self._id_A9E0);

  if(isDefined(self._id_0117) && isDefined(level._id_5C44))
    self._id_0117 thread[[level._id_5C44]]("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_9D65))
    self._id_9D65 delete();

  self._id_5A2C delete();
  self notify("death");
  self delete();
}

_id_61E4(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = self._id_0117;

  _id_0378::_id_8D74("wpn_bouncingbetty_exp");
  var_3 = self gettagorigin("tag_fx");
  playFX(level._id_61C8, var_3);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self _meth_805C();
  self _meth_81D5(self.origin, level._id_61DE * var_1, level._id_61DB * var_2, level._id_61DC, var_0, "MOD_EXPLOSIVE", self._id_A9E0);

  if(isDefined(self._id_0117) && isDefined(level._id_5C44))
    self._id_0117 thread[[level._id_5C44]]("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_9D65))
    self._id_9D65 delete();

  self._id_5A2C delete();
  self notify("death");
  self delete();
}

_id_61F7() {
  if(self._id_94B9) {
    return;
  }
  self._id_94B9 = 1;
  _func_147(common_scripts\utility::_id_44F5("mine_stunned"), self, "tag_origin");
}

_id_61F8() {
  self._id_94B9 = 0;
  _func_148(common_scripts\utility::_id_44F5("mine_stunned"), self, "tag_origin");
}

_id_61D7(var_0) {
  if(isDefined(self._id_A9E0)) {
    if(isDefined(self._id_37D3))
      self._id_37D3 destroy();

    if(self._id_A9E0 == "bouncingbetty_mp") {
      if(isDefined(self._id_9D65))
        self._id_9D65 delete();

      if(isDefined(self._id_359B["friendly"]))
        self._id_359B["friendly"] delete();

      if(isDefined(self._id_359B["enemy"]))
        self._id_359B["enemy"] delete();

      for(var_1 = 0; var_1 < self._id_0117._id_37FB.size; var_1++) {
        if(self._id_0117._id_37FB[var_1] == self)
          self._id_0117._id_37FB[var_1] = undefined;
      }

      self._id_0117._id_37FB = common_scripts\utility::_id_0FA0(self._id_0117._id_37FB);
      self notify("change_owner");
      self._id_0117 = var_0;
      self._id_0117._id_37FB[self._id_0117._id_37FB.size] = self;
      self.team = var_0.team;
      self _meth_8385(var_0);
      self._id_9D65 = spawn("script_origin", self.origin + (0, 0, 25));
      self._id_9D65._id_0117 = self;
      _id_37F7(var_0);
      thread _id_86CA(var_0.team);
      var_0 thread _id_61FE(self);
      var_0 thread _id_61FD(self);
    } else if(self._id_A9E0 == "claymore_mp") {
      if(isDefined(self._id_9D65))
        self._id_9D65 delete();

      for(var_1 = 0; var_1 < self._id_0117._id_232F.size; var_1++) {
        if(self._id_0117._id_232F[var_1] == self)
          self._id_0117._id_232F[var_1] = undefined;
      }

      self._id_0117._id_232F = common_scripts\utility::_id_0FA0(self._id_0117._id_232F);
      self notify("change_owner");
      self._id_0117 = var_0;
      self._id_0117._id_232F[self._id_0117._id_232F.size] = self;
      self.team = var_0.team;
      self _meth_8385(var_0);
      self._id_9D65 = spawn("script_origin", self.origin);
      self._id_9D65._id_0117 = self;
      _id_37F7(var_0);
      thread _id_86CA(var_0.team);
      var_0 thread _id_61FE(self);
      var_0 thread _id_61FD(self);
      thread _id_2334();
    } else if(self._id_A9E0 == "c4_mp") {
      var_2 = 0;
      var_3 = 0;

      for(var_1 = 0; var_1 < self._id_0117._id_5FDB.size; var_1++) {
        if(self._id_0117._id_5FDB[var_1][0] == self) {
          self._id_0117._id_5FDB[var_1][0] = undefined;
          var_2 = self._id_0117._id_5FDB[var_1][1];
          var_3 = self._id_0117._id_5FDB[var_1][2];
        }
      }

      self._id_0117._id_5FDB = _id_5FDA(self._id_0117._id_5FDB);
      self notify("change_owner");
      self._id_0117 = var_0;
      var_4 = self._id_0117._id_5FDB.size;
      self._id_0117._id_5FDB[var_4] = [];
      self._id_0117._id_5FDB[var_4][0] = self;
      self._id_0117._id_5FDB[var_4][1] = var_2;
      self._id_0117._id_5FDB[var_4][2] = var_3;
      self.team = var_0.team;
      self _meth_8385(var_0);
      _id_37F7(var_0);
      thread _id_86CA(var_0.team);
    }
  }
}

_id_74DD() {
  self endon("death");
  var_0 = gettime() + 1000;

  while(gettime() < var_0) {
    waitframe();
    _func_147(level._id_61CF, self, "tag_fx_spin1");
    _func_147(level._id_61CF, self, "tag_fx_spin3");
    waitframe();
    _func_147(level._id_61CF, self, "tag_fx_spin2");
    _func_147(level._id_61CF, self, "tag_fx_spin4");
  }
}

_id_61D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6[0] = (1, 0, 0);
  var_6[1] = (0, 1, 0);

  if(var_1[2] < var_5)
    var_7 = 0;
  else
    var_7 = 1;

  var_8 = (var_0[0], var_0[1], var_5);
  var_9 = (var_1[0], var_1[1], var_5);
  thread _id_2B4D(var_8, level._id_61DE, var_6[var_7], 32);
  var_10 = distancesquared(var_0, var_1);

  if(var_10 > var_2)
    var_7 = 0;
  else
    var_7 = 1;

  thread _id_2B57(var_8, var_9, var_6[var_7]);
}

_id_61DA(var_0, var_1) {
  if(isPlayer(var_1) && isalive(var_1) && var_1.sessionstate == "playing")
    var_2 = var_1 maps\mp\_utility::_id_469E();
  else if(var_1.classname == "misc_turret")
    var_2 = var_1.origin + (0, 0, 32);
  else
    var_2 = var_1.origin;

  var_3 = 0;
  var_4 = var_0.origin[2] + var_3 + level._id_61D9;
  var_5 = var_0.origin[2] + var_3 - level._id_61D9;

  if(var_2[2] > var_4 || var_2[2] < var_5)
    return 0;

  return 1;
}

_id_A941() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  for(;;) {
    self._id_57CF = 0;
    self waittill("sprint_slide_begin");
    self._id_57CF = 1;
    self._id_5BDE = gettime();
    self waittill("sprint_slide_end");
  }
}

_id_A938() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload");
    self._id_5BD6 = gettime();

    if(maps\mp\_utility::_hasperk("specialty_boostafterreload"))
      thread _id_052C::handleclassifiedboostafterreload();
  }
}

_id_A944() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");
    var_0 = gettime();
    var_1 = self getcurrentweapon();
    var_2 = undefined;

    if(!(isDefined(level.disabledivisionskills) && level.disabledivisionskills) && isDefined(self._id_0079) && self._id_0079 != 5 && weaponclass(var_1) == "rifle" && issubstr(var_1, "bayonet")) {
      var_2 = _id_04CA::_id_461C(0);

      if(var_2 == "bayonet_level2" || var_2 == "bayonet_level3") {
        self _meth_82FF("ui_show_division_rifle_ability_prompt", 1);
        thread _id_A94A();
      }
    } else if(issubstr(var_1, "shield_charge")) {
      self _meth_82FF("ui_show_shield_charge_ability_prompt", 1);
      thread watchsprintweaponswitchforshieldchargeprompt();
    } else if(weaponclass(var_1) == "spread" && issubstr(var_1, "dragon_breath")) {
      if(!maps\mp\_utility::_hasperk("specialty_sprintreload"))
        self _meth_82FF("ui_show_division_shotgun_ability_prompt", 0);
    }

    self waittill("sprint_end");
    var_3 = gettime();

    if(!(isDefined(level.disabledivisionskills) && level.disabledivisionskills) && (isDefined(self._id_0079) && self._id_0079 != 5 && weaponclass(var_1) == "rifle" && issubstr(var_1, "bayonet") && isDefined(var_2) && (var_2 == "bayonet_level2" || var_2 == "bayonet_level3")))
      self _meth_82FF("ui_show_division_rifle_ability_prompt", 0);
    else if(issubstr(var_1, "shield_charge"))
      self _meth_82FF("ui_show_shield_charge_ability_prompt", 0);
    else if(weaponclass(var_1) == "spread" && issubstr(var_1, "dragon_breath")) {
      if(self _meth_85EC() && !maps\mp\_utility::_hasperk("specialty_sprintreload"))
        self _meth_82FF("ui_show_division_shotgun_ability_prompt", 1);
    }

    if(isDefined(self._id_9A16) && isDefined(self._id_9A17)) {
      self._id_9A16 = self._id_9A16 + (var_3 - var_0) / 1000;

      if(!isDefined(self._id_90AE))
        self._id_90AE = -1;

      if(!isDefined(self._id_90AD))
        self._id_90AD = -1;

      if(self._id_90AE < 0 && self._id_90AD < 0)
        self._id_9A17 = self._id_9A17 + (var_3 - var_0) / 1000;
    }

    self._id_5BE3 = var_3;
  }
}

_id_A94A() {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("sprint_end");

  for(;;) {
    self waittill("weapon_change");
    var_0 = self getcurrentweapon();

    if(!(isDefined(level.disabledivisionskills) && level.disabledivisionskills) && isDefined(self._id_0079) && self._id_0079 != 5 && weaponclass(var_0) == "rifle" && issubstr(var_0, "bayonet")) {
      var_1 = _id_04CA::_id_461C(0);

      if(var_1 == "bayonet_level2" || var_1 == "bayonet_level3")
        self _meth_82FF("ui_show_division_rifle_ability_prompt", 1);
      else
        self _meth_82FF("ui_show_division_rifle_ability_prompt", 0);

      continue;
    }

    self _meth_82FF("ui_show_division_rifle_ability_prompt", 0);
  }
}

watchsprintweaponswitchforshieldchargeprompt() {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("sprint_end");

  for(;;) {
    self waittill("weapon_change");
    var_0 = self getcurrentweapon();

    if(issubstr(var_0, "shield_charge")) {
      self _meth_82FF("ui_show_shield_charge_ability_prompt", 1);
      continue;
    }

    self _meth_82FF("ui_show_shield_charge_ability_prompt", 0);
  }
}

_id_A920() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");
  self._id_A25D = 0;

  for(;;) {
    self waittill("got_lethal_resupply");
    self._id_A25D = 1;
  }
}

_id_5316() {
  if(isDefined(self._id_37FB)) {
    if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1) {
      if(isDefined(self._id_3234))
        self._id_3234 = undefined;
      else
        _id_2CF6();
    }
  } else
    self._id_37FB = [];

  if(!isDefined(self._id_5A6D))
    self._id_5A6D = [];
}

_id_3BE4(var_0, var_1) {
  if(var_1 == "role_explosive_rat_mp") {
    if(!isalive(self)) {
      var_0 delete();
      return;
    }

    maps\mp\gametypes\_gamelogic::_id_869D(self, 1);
    var_0 thread _id_3973(self, 1);
  }
}

_id_3973(var_0, var_1) {
  self._id_0117 = var_0;
  self waittill("missile_stuck");

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_3 = var_2["position"];

  if(var_2["fraction"] == 1) {
    var_3 = _func_082(self.origin, 12, 0, 32);
    var_2["normal"] = var_2["normal"] * -1;
  }

  var_4 = _id_905F(var_3, var_0, undefined, self.angles, var_1);
  var_4._id_9D65 = spawn("script_origin", var_4.origin + (0, 0, 25));
  var_4._id_9D65._id_0117 = var_4;
  var_4._id_9D65._id_28D3 = _id_04D1::_id_45A9();
  _func_1CE(var_4._id_9D65._id_28D3, "invisible", (0, 0, 0));
  _func_1D2(var_4._id_9D65._id_28D3, var_4.origin);
  _func_1D1(var_4._id_9D65._id_28D3, "cb_compassping_enemy_objective");

  if(!level.teambased)
    _func_186(var_4._id_9D65._id_28D3, var_0 getentitynumber());
  else
    _func_183(var_4._id_9D65._id_28D3, level._id_6C63[var_0.team]);

  var_4._id_9D65 thread _id_3970();
  var_0 thread _id_61FE(var_4);
  var_0 thread _id_61FD(var_4);
  self delete();
}

_id_905F(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = (0, _func_0A3(360), 0);

  var_5 = "vfx_rat_fr6_a";
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_3;
  var_6 setModel(var_5);
  var_6._id_0117 = var_1;
  var_6._id_94B9 = 0;
  var_6 _meth_8385(var_1);
  var_6._id_A9E0 = "role_explosive_rat_mp";
  var_6._id_5A30 = (10, 10, 10);
  var_6._id_5A2C = spawn("script_model", var_6.origin + var_6._id_5A30);
  var_6._id_5A2C _meth_834D("explosive");
  var_6 thread _id_396F(var_1);
  var_6 thread _id_3971(var_1);
  var_7 = self _meth_83F2();

  if(isDefined(var_7))
    var_6 _meth_8055(var_7);

  return var_6;
}

_id_3970() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait(_func_0A3(2.0));

  for(;;) {
    _func_1D0(self._id_28D3, "active");
    wait(0.25 + _func_0A3(2.0));
    _func_1D0(self._id_28D3, "invisible");
    wait(0.25 + _func_0A3(2.0));
  }
}

_id_396F(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait(level._id_3966);
  var_1 = spawn("trigger_radius", self.origin, 0, level._id_396C, level._id_396B);
  var_1._id_0117 = self;
  thread _id_396E(var_1, var_0);
  thread _id_3969(var_1);
  var_2 = undefined;

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self._id_0117)) {
        if(var_2 == self._id_0117) {
          continue;
        }
        if(isDefined(var_2._id_0117) && var_2._id_0117 == self._id_0117)
          continue;
      }

      if(!_id_3ECD(self._id_0117, var_2, 0))
        continue;
    }

    break;
  }

  wait(level._id_396A);
  self notify("mine_triggered");
  _id_0378::_id_8D74("wpn_bouncingbetty_trigger");
  thread _id_396D(var_0);
}

_id_396E(var_0, var_1) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  var_1 waittill("death");
  thread _id_396D(var_1);
}

_id_3969(var_0, var_1) {
  common_scripts\utility::_id_A70A("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_28D3))
      maps\mp\_utility::_objective_delete(var_0._id_28D3);

    var_0 delete();
  }
}

_id_3971(var_0) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level._id_3972);
  wait(_func_0A3(0.4));
  self notify("mine_selfdestruct");
  thread _id_396D(var_0);
}

_id_396D(var_0) {
  if(!isDefined(self)) {
    return;
  }
  _id_0378::_id_8D74("wpn_bouncingbetty_exp");
  playFX(level._id_61C8, self.origin);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self _meth_805C();

  foreach(var_2 in level.players) {
    if(var_2 != var_0 && level.teambased && var_2.team == var_0.team) {
      continue;
    }
    if(distancesquared(var_2.origin, self.origin) < _func_1E2(level._id_3968, 2))
      var_2 _meth_8059(level._id_3967, self.origin, var_0, self, "MOD_EXPLOSIVE", "role_explosive_rat_mp");
  }

  if(isDefined(self._id_0117) && isDefined(level._id_5C44))
    self._id_0117 thread[[level._id_5C44]]("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;

  if(!isDefined(self)) {
    return;
  }
  maps\mp\_utility::_objective_delete(self._id_9D65._id_28D3);

  if(isDefined(self._id_9D65))
    self._id_9D65 delete();

  self._id_5A2C delete();
  self delete();
}

_id_3C15(var_0, var_1) {
  if(var_1 == "bouncingbetty" || var_1 == "bouncingbetty_mp")
    maps\mp\gametypes\_gamelogic::_id_869D(self, 1);

  var_0 _meth_805C();

  if(!isalive(self)) {
    if(isDefined(var_0)) {
      var_0 notify("remove");
      var_0 delete();
    }

    return;
  }

  if(!self _meth_8346()) {
    self iprintlnbold(&"WEAPON_BETTY_INVALID_MIDAIR");
    var_2 = self getweaponammostock(var_1);

    if(var_2 < _func_1D6(var_1))
      self setweaponammostock(var_1, var_2 + 1);

    if(isDefined(var_0))
      var_0 delete();

    return;
  }

  var_0 thread _id_61F9(self, 1);
}

_id_61F9(var_0, var_1) {
  self._id_0117 = var_0;
  var_2 = waittill_missile_stuck_or_timeout();

  if(!_func_030(self) && var_2 == "missile_stuck") {
    self _meth_805B();

    if(!isDefined(var_0)) {
      return;
    }
    _id_8A2E(var_0, var_1);
    self._id_9D65 = spawn("script_origin", self.origin + (0, 0, 25));
    self._id_9D65._id_0117 = self;
    self._id_9D65 _meth_8055(self);
    thread _id_3800(var_0, 0);
    var_0 thread _id_61FE(self);
    var_0 thread _id_61FD(self);
  } else {
    self notify("remove");
    self delete();
  }
}

_id_61FE(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("change_owner");
  self waittill("disconnect");

  if(isDefined(var_0._id_9D65))
    var_0._id_9D65 delete();

  var_0 notify("remove");
  var_0 delete();
}

_id_61FD(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("change_owner");
  common_scripts\utility::_id_A732("joined_team", "joined_spectators");

  if(var_0._id_A9E0 == "s2_tactical_insertion_cavalry_mp") {
    self._id_6E6C = 0;
    _id_052C::_id_2D54(var_0);
  } else {
    if(isDefined(var_0._id_9D65))
      var_0._id_9D65 delete();

    var_0 notify("remove");
    var_0 delete();
  }
}

_id_61D0() {
  self endon("change_owner");
  self._id_359B["friendly"] = _func_14B(level._id_61C2["friendly"], self gettagorigin("tag_fx"));
  self._id_359B["enemy"] = _func_14B(level._id_61C2["enemy"], self gettagorigin("tag_fx"));
  thread _id_61D1();
  self waittill("death");
  self._id_359B["friendly"] delete();
  self._id_359B["enemy"] delete();
}

_id_61D1() {
  self endon("death");
  self endon("change_owner");
  var_0 = self._id_0117.team;
  waitframe();
  _func_14C(self._id_359B["friendly"]);
  _func_14C(self._id_359B["enemy"]);

  for(;;) {
    self._id_359B["friendly"] _meth_805C();
    self._id_359B["enemy"] _meth_805C();

    foreach(var_2 in level.players) {
      if(level.teambased && !_func_367()) {
        if(var_2.team == var_0)
          self._id_359B["friendly"] _meth_8005(var_2);
        else
          self._id_359B["enemy"] _meth_8005(var_2);

        continue;
      }

      if(var_2 == self._id_0117) {
        self._id_359B["friendly"] _meth_8005(var_2);
        continue;
      }

      self._id_359B["enemy"] _meth_8005(var_2);
    }

    level common_scripts\utility::_id_A732("joined_team", "player_spawned");
  }
}

_id_2CF3() {
  if(isDefined(self._id_5FDB)) {
    for(var_0 = 0; var_0 < self._id_5FDB.size; var_0++) {
      if(isDefined(self._id_5FDB[var_0][0])) {
        if(isDefined(self._id_5FDB[var_0][0]._id_9D65))
          self._id_5FDB[var_0][0]._id_9D65 delete();

        self._id_5FDB[var_0][0] delete();
      }
    }
  }

  self._id_5FDB = [];

  if(isDefined(self._id_232F)) {
    for(var_0 = 0; var_0 < self._id_232F.size; var_0++) {
      if(isDefined(self._id_232F[var_0])) {
        if(isDefined(self._id_232F[var_0]._id_9D65))
          self._id_232F[var_0]._id_9D65 delete();

        self._id_232F[var_0] notify("remove");
        self._id_232F[var_0] delete();
      }
    }
  }

  self._id_232F = [];

  if(isDefined(self._id_1B56)) {
    for(var_0 = 0; var_0 < self._id_1B56.size; var_0++) {
      if(isDefined(self._id_1B56[var_0])) {
        if(isDefined(self._id_1B56[var_0]._id_9D65))
          self._id_1B56[var_0]._id_9D65 delete();

        self._id_1B56[var_0] notify("remove");
        self._id_1B56[var_0] delete();
      }
    }
  }

  self._id_1B56 = [];

  if(isDefined(self._id_2B71)) {
    for(var_0 = 0; var_0 < self._id_2B71.size; var_0++) {
      if(isDefined(self._id_2B71[var_0])) {
        self._id_2B71[var_0] notify("remove");
        self._id_2B71[var_0] delete();
      }
    }
  }

  self._id_2B71 = [];
}

_id_2CF6() {
  if(isDefined(self._id_37FB)) {
    self._id_37FB = common_scripts\utility::_id_0FA0(self._id_37FB);

    foreach(var_1 in self._id_37FB) {
      if(isDefined(var_1._id_9D65))
        var_1._id_9D65 delete();

      var_1 delete();
    }
  }
}

_id_9C5A(var_0) {
  var_0 _id_2CF3();
  var_0 _id_2CF6();

  if(isDefined(self._id_5FDB))
    var_0._id_5FDB = _id_5FDA(self._id_5FDB);
  else
    var_0._id_5FDB = undefined;

  if(isDefined(self._id_232F))
    var_0._id_232F = common_scripts\utility::_id_0FA0(self._id_232F);
  else
    var_0._id_232F = undefined;

  if(isDefined(self._id_1B56))
    var_0._id_1B56 = common_scripts\utility::_id_0FA0(self._id_1B56);
  else
    var_0._id_1B56 = undefined;

  if(isDefined(self._id_37FB))
    var_0._id_37FB = common_scripts\utility::_id_0FA0(self._id_37FB);
  else
    var_0._id_37FB = undefined;

  if(isDefined(self._id_5A6D))
    var_0._id_5A6D = common_scripts\utility::_id_0FA0(self._id_5A6D);
  else
    var_0._id_5A6D = undefined;

  if(isDefined(var_0._id_5FDB)) {
    foreach(var_2 in var_0._id_5FDB) {
      var_2[0]._id_0117 = var_0;
      var_2[0] thread _id_3800(var_0);
    }
  }

  if(isDefined(var_0._id_232F)) {
    foreach(var_5 in var_0._id_232F) {
      var_5._id_0117 = var_0;
      var_5 thread _id_3800(var_0);
    }
  }

  if(isDefined(var_0._id_1B56)) {
    foreach(var_8 in var_0._id_1B56) {
      var_8._id_0117 = var_0;
      var_8 thread _id_3800(var_0);
    }
  }

  if(isDefined(var_0._id_37FB)) {
    foreach(var_11 in var_0._id_37FB) {
      var_11._id_0117 = var_0;
      var_11 thread _id_3800(var_0);
    }
  }

  if(isDefined(var_0._id_5A6D)) {
    foreach(var_14 in var_0._id_5A6D) {
      var_14._id_0117 = var_0;
      var_14 thread _id_3800(var_0);
    }
  }

  self._id_5FDB = [];
  self._id_232F = [];
  self._id_1B56 = [];
  self._id_37FB = [];
  self._id_2B71 = [];
  self._id_5A6D = [];
  self._id_3233 = 1;
  self._id_3234 = 1;
}

_id_37F5() {
  playFX(common_scripts\utility::_id_44F5("equipment_sparks"), self.origin);
  self playSound("sentry_explode");
}

_id_37F6() {
  playFX(common_scripts\utility::_id_44F5("equipment_explode_big"), self.origin);
  playFX(common_scripts\utility::_id_44F5("equipment_smoke"), self.origin);
}

_id_37F8() {
  _func_147(common_scripts\utility::_id_44F5("emp_stun"), self, "tag_origin");
}

_id_9B90() {
  self._id_29A2 = [];

  if(!_func_0C1(self))
    thread _id_7D30();
}

_id_7D30() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    if(self.health >= 100 && isDefined(self._id_29A2) && self._id_29A2.size > 0)
      self._id_29A2 = [];

    waitframe();
  }
}

_id_93A1(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0))
    var_2.notifystring = var_0;

  if(isDefined(var_1))
    var_2._id_36DE = var_1;

  var_2._id_2AA8 = ::_id_93A2;
  thread _id_0488::_id_4A27(var_2);
}

_id_93A2(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  if(isDefined(self)) {
    if(isDefined(var_0.notifystring)) {
      if(var_0.notifystring == "detonate")
        self _meth_81D6();
      else
        self notify(var_0.notifystring);
    } else
      self delete();
  }
}

_id_4501() {
  var_0 = 10;

  if(isDefined(level._id_4867))
    var_0 = level._id_4867;

  var_1 = 0;

  if(isDefined(level._id_7690))
    var_1 = (gettime() - level._id_7690) / 1000;

  return var_0 - var_1;
}

_id_513A() {
  return _id_4501() > 0 && !_func_367();
}

_id_584D(var_0) {
  if(_func_115(var_0, "_gl"))
    return 0;

  switch (var_0) {
    case "frag_grenade_german_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 0;
    default:
      break;
  }

  var_1 = _func_05F(var_0);

  if(isDefined(var_1)) {
    switch (var_1) {
      case "iw5_maaws_mp":
      case "iw5_mahem_mp":
        return 0;
      default:
        break;
    }
  }

  return 1;
}

_id_A917() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    [var_1, var_2, var_3] = common_scripts\utility::_id_A717("grenade_fire", "missile_fire");

    if(!isDefined(var_3) || var_3 == "") {
      continue;
    }
    if(_id_513A()) {
      if(!_id_584D(var_3)) {
        var_4 = int(_id_4501() + 0.5);

        if(!var_4)
          var_4 = 1;

        if(isPlayer(self))
          self iprintlnbold(&"MP_EXPLOSIVES_UNAVAILABLE_FOR_N", var_4);
      }

      continue;
    }

    break;
  }
}

_id_5794(var_0) {
  var_1 = maps\mp\_utility::getweaponclass(var_0);
  var_2 = maps\mp\_utility::_id_4431(var_0);

  if(var_1 == "weapon_projectile")
    return 1;

  if(isDefined(var_2) && (issubstr(var_2, "microdronelauncher") || issubstr(var_2, "exocrossbow")))
    return 1;

  return 0;
}

_id_806D(var_0, var_1, var_2) {
  var_3 = self._id_806E.size;

  if(var_3 == 0)
    self._id_3C6E = var_1;

  self._id_806E[var_3]["type"] = var_0;
  self._id_806E[var_3]["use"] = var_2;
}

_id_466E(var_0) {
  var_1 = self._id_806E.size;
  var_2 = -1;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(self._id_806E[var_3]["type"] == var_0) {
      var_2 = var_3;
      break;
    }
  }

  if(var_2 >= 0)
    return self._id_806E[var_2]["use"];
  else
    return "none";
}

_id_7DF7(var_0) {
  var_1 = [];
  var_2 = self._id_806E.size;
  var_3 = -1;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    if(var_3 < 0 && self._id_806E[var_5]["type"] == var_0) {
      var_3 = var_5;
      continue;
    }

    var_1[var_4] = self._id_806E[var_5];
    var_4++;
  }

  if(var_3 >= 0) {
    var_6 = "none";

    if(var_1.size == 0) {
      var_6 = self._id_3C6E;
      self._id_806E = var_1;
      self._id_3C6E = "none";
    } else {
      self._id_806E = var_1;
      var_6 = _id_466E("underwater");

      if(var_6 == "none")
        var_6 = self._id_806E[0]["use"];
    }

    var_7 = self getcurrentweapon();

    if(var_7 != var_6)
      self _meth_831B(var_6);
  }
}

_id_A928(var_0, var_1) {
  self endon("end_explode");
  self endon("explode");
  self endon("remove");
  self endon("death");

  for(;;)
    self waittill("make_dud");
}

_id_A92A(var_0, var_1) {
  self endon("end_explode");
  self endon("explode");
  self endon("remove");
  self endon("death");

  for(;;) {
    self waittill("make_live");

    switch (var_1) {
      case "c4_zm":
      case "c4":
      case "c4_mp":
        thread _id_1DF0();

        if(!maps\mp\_utility::_id_585F())
          thread _id_050A::_id_1DEE();

        break;
      case "claymore":
      case "claymore_mp":
        thread _id_1DF0();
        break;
      case "tabun_grenade_mp":
        thread _id_4A66(var_0, var_1);
        break;
      case "signal_flare_expeditionary_mp":
      case "signal_flare_mp":
        thread _id_4AF3(var_0, var_1);
        break;
      case "panzerfaust60_mp":
      case "piat_mp":
      case "panzerschreck_mp":
      case "bazooka_mp":
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "v2_rocket_mp":
      case "missile_strike_projectile_axis_mp":
      case "missile_strike_projectile_mp":
      case "mortar_strike_projectile_axis_mp":
      case "mortar_strike_projectile_mp":
      case "azon_projectile_mp":
      case "fritzx_projectile_mp":
      case "frag_grenade_mp":
        thread _id_050A::_id_485C();
        break;
    }
  }
}

_id_1712(var_0, var_1) {
  thread _id_A928(var_0, var_1);
  thread _id_A92A(var_0, var_1);
}

_id_6244(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1._id_556C))
    var_2 = var_1._id_556C;

  if(_func_030(var_0) != var_2) {
    self _meth_8469(var_2);

    if(var_1._id_556C)
      var_0 notify("make_dud");
    else
      var_0 notify("make_live");
  }

  var_0._id_9ABC[var_1._id_37D8] = var_1;
}

_id_6245(var_0, var_1) {
  if(isDefined(var_1._id_600D) && var_1._id_600D) {
    var_2 = 0;

    if(isDefined(var_1._id_556C))
      var_2 = !var_1._id_556C;

    if(_func_030(var_0) != var_2) {
      self _meth_8469(var_2);

      if(var_2)
        var_0 notify("make_dud");
      else
        var_0 notify("make_live");
    }
  }

  var_0._id_9ABC[var_1._id_37D8] = undefined;
}

_id_A929(var_0, var_1) {
  self endon("death");
  self endon("remove");
  self endon("missile_stuck");

  if(!isDefined(self)) {
    return;
  }
  _id_1712(var_0, var_1);

  if(!isDefined(self._id_9ABC))
    self._id_9ABC = [];

  if(_func_367()) {
    self _meth_8469(1);
    self notify("make_dud");
  }

  for(;;) {
    if(isDefined(level._id_6246)) {
      foreach(var_3 in level._id_6246) {
        if(!isDefined(var_3._id_37D8))
          var_3._id_37D8 = var_3 getentitynumber();

        if(self istouching(var_3)) {
          if(!isDefined(self._id_9ABC[var_3._id_37D8]))
            _id_6244(self, var_3);

          continue;
        }

        if(isDefined(self._id_9ABC[var_3._id_37D8]))
          _id_6245(self, var_3);
      }
    }

    waitframe();
  }
}

_id_62FE() {
  level endon("game_ended");
  self notify("monitor_dive");
  self endon("monitor_dive");
  self endon("death");

  for(;;) {
    self waittill("dive_land");
    self._id_5B93 = gettime();
    self _meth_82FF("ui_fullscreen_dirt_left", 1);
    self _meth_809F("defaultweapon_fire");
  }
}

_id_6302() {
  if(_func_367()) {
    return;
  }
  thread _id_6303();
  thread _id_6304();
}

_id_6303() {
  level endon("game_ended");
  self notify("monitor_empty_lethals");
  self endon("monitor_empty_lethals");
  self endon("death");
  self _meth_82E1("lethal_pressed", "+frag");

  for(;;) {
    self waittill("lethal_pressed");
    var_0 = self _meth_834A();

    if(!isDefined(var_0)) {
      continue;
    }
    if(var_0 == "none" || self getammocount(var_0) == 0)
      self _meth_809F("defaultweapon_fire");
  }
}

_id_6304() {
  level endon("game_ended");
  self notify("monitor_empty_tacticals");
  self endon("monitor_empty_tacticals");
  self endon("death");
  self _meth_82E1("tactical_pressed", "+smoke");

  for(;;) {
    self waittill("tactical_pressed");
    var_0 = self getoffhandsecondaryclass();

    if(!isDefined(var_0)) {
      continue;
    }
    if(var_0 == "none" || self getammocount(var_0) == 0)
      self _meth_809F("defaultweapon_fire");
  }
}

initteslagun() {
  if(getdvarint("spv_tesla_mp_active", 0) == 1)
    self _meth_8512(["teslagunmtx_mp"]);
}

potentiallyspawnteslagun(var_0, var_1) {
  level endon("game_ended");

  if(randomint(100) <= var_1 - 1) {
    var_2 = "teslagunmtx_mp";
    var_3 = "weapon_" + var_2;
    var_4 = (0, 0, 60);
    var_5 = spawn(var_3, var_0 + var_4);
    var_5 _meth_83FE(0, 1);
    var_5 _meth_817E(5, 5);
    var_5 _meth_86B3(0);
    waitframe();

    if(isDefined(var_5) && !_func_279(var_5)) {
      _func_147(common_scripts\utility::_id_44F5("tesla_gun_glow"), var_5, "tag_origin");
      var_6 = (0, 0, 0);
      var_7 = (_func_0A5(-0.5, 0.5), _func_0A5(-0.5, 0.5), 1);
      var_8 = 1500;
      var_5 _meth_8273(var_5.origin + var_6, var_7 * var_8);
      var_5 thread _id_A934();
    }
  }
}