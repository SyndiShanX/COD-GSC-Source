/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_weapons.gsc
*********************************************/

func_00D5() {
  setdvarifuninitialized("trailer_disable_intro_filter", 0);
  setdvarifuninitialized("trailer_disable_helmet_pop", 0);
  setdvarifuninitialized("trailer_allow_custom_outfits", 0);
  setdvarifuninitialized("trailer_plane_gunner_height", -1);
  setdvarifuninitialized("spv_enableAttachmentStats", 0);
  if(!maps\mp\_utility::func_585F() && !function_0367()) {
    level thread maps\mp\gametypes\_model_dismemberment::func_52A9();
  }

  level.var_808B = 1;
  level.var_808C = 1;
  if(!maps\mp\_utility::func_585F()) {
    level.var_6092 = max(maps\mp\_utility::func_4529("scr_maxPerPlayerExplosives", 2), 1);
  }

  level.var_7EA4 = maps\mp\_utility::func_4529("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");
  switch (maps\mp\_utility::func_4529("perk_scavengerMode", 0)) {
    case 1:
      level.var_808B = 0;
      break;

    case 2:
      level.var_808C = 0;
      break;

    case 3:
      level.var_808B = 0;
      level.var_808C = 0;
      break;
  }

  var_00 = maps\mp\_utility::func_4427();
  var_00 = common_scripts\utility::func_0C9E(var_00);
  thread maps\mp\_flashgrenades::func_00F9();
  thread maps\mp\_entityheadicons::func_00D5();
  if(!isDefined(level.var_585D) || !level.var_585D) {
    thread maps\mp\_riotshield::func_00D5();
  }

  if(!isDefined(level.var_A9C5)) {
    level.var_A9C5 = ::func_34B7;
  }

  var_01 = 70;
  level.var_2330 = cos(var_01);
  level.var_2332 = 20;
  level.var_2331 = 0.75;
  level.var_2333 = 192;
  level.var_396A = 0.15;
  level.var_396C = 100;
  level.var_396B = 30;
  level.var_3968 = 150;
  level.var_3967 = 150;
  level.var_3966 = 0.25;
  level.var_3972 = 7;
  if(!isDefined(level.var_585D) || !level.var_585D) {
    level.var_61E0 = 0.3;
    level.var_61E2 = 100;
    level.var_61E1 = 20;
    level.var_61DE = 175;
    level.var_61DC = 70;
    level.var_61DB = 200;
    level.var_61D9 = 46;
    level.var_61EF = 120;
    level.var_61CC = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
    level.var_61CF = loadfx("vfx/dust/bouncing_betty_swirl");
    level.var_61C8 = loadfx("vfx/explosion/bouncing_betty_explosion");
    level.var_61C2["enemy"] = loadfx("vfx/lights/light_c4_blink");
    level.var_61C2["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
  }

  if(!isDefined(level.var_585D) || !level.var_585D) {
    level.var_0611["mine_stunned"] = loadfx("vfx/sparks/emp_drone_damage");
    level.var_0611["signal_flare"] = loadfx("vfx/smoke/signal_flare_volumetric_runner_blinded");
    level.var_0611["signal_flare_friendly_tacmask"] = loadfx("vfx/smoke/signal_flare_volumetric_runner");
    level.var_0611["sentry_explode_mp"] = loadfx("vfx/explosion/remote_sentry_death");
    level.var_0611["sentry_smoke_mp"] = loadfx("vfx/explosion/remote_sentry_death_smoke");
    level.var_0611["trophy_detonation"] = loadfx("vfx/explosion/remote_sentry_death_smoke");
    level.var_0611["fire_lp_s_base_calm"] = loadfx("vfx/fire/fire_lp_s_base_calm");
    level.var_0611["sticky_grenade_splat"] = loadfx("vfx/weaponimpact/sticky_grenade_splat");
    level.var_0611["perception_glow"] = loadfx("vfx/ui/ui_role_ability_overlay_yellow");
    level.var_0611["divisions_bayonet_charge"] = loadfx("vfx/divisions/fx_divisions_rifle_bayont_charge_1p");
    level.var_0611["divisions_sniper"] = loadfx("vfx/divisions/divisions_sniper");
    level.var_0611["tactical_insertion_beacon_ally"] = loadfx("vfx/test/beacon_smoke_tac_insert_ally");
    level.var_0611["tactical_insertion_beacon_enemy"] = loadfx("vfx/test/beacon_smoke_tac_insert_enemy");
    level.var_0611["tactical_insertion_cavalry_ally"] = loadfx("vfx/test/mp_cav_tac_insert_ally");
    level.var_0611["tactical_insertion_cavalry_enemy"] = loadfx("vfx/test/mp_cav_tac_insert_enemy");
    level.var_0611["tactical_insertion_cavalry_ally_parachuting"] = loadfx("vfx/test/mp_cav_tac_insert_ally_parachuting");
    level.var_0611["tactical_insertion_cavalry_enemy_parachuting"] = loadfx("vfx/test/mp_cav_tac_insert_enemy_parachuting");
    level.var_0611["faster_health_regen_sweep"] = loadfx("vfx/unique/mp_fast_health_regen");
    level.var_0611["mp_dlc4_3rd_person_serum_orange"] = loadfx("vfx/map/mp_raid_dlc4/mp_dlc4_3rd_person_serum_orange");
    level.var_0611["mp_dlc4_1st_person_serum_orange"] = loadfx("vfx/map/mp_raid_dlc4/mp_dlc4_1st_person_serum_orange");
  }

  if(!function_0367()) {
    level.var_0611["blood_pool"] = loadfx("vfx/blood/blood_pool_mp");
  }

  level.var_2CE8 = 1.8;
  level.delayshortminetime = 0.9;
  level.shortminetime = 0.2;
  level.var_2CBD = 0.5;
  level.shortdelayc4armtime = 0.5;
  level.var_83E5 = loadfx("vfx/test/test_fx");
  level.var_93A7 = loadfx("vfx/test/test_fx");
  level.var_76F2 = [];
  level.var_8C3B = [];
  level.var_4852 = [];
  level.var_6237 = [];
  level.var_54FC = [];
  level.var_61ED = [];
  level.var_9DCB = [];
  if(!maps\mp\_utility::func_551F() && !function_0367()) {
    if(!isDefined(level.var_585D) || !level.var_585D) {
      level.var_0611["equipment_explode"] = loadfx("vfx/explosion/sparks_burst_lrg_c");
    }

    level.var_0611["sniperDustLarge"] = loadfx("vfx/dust/sniper_dust_kickup");
    level.var_0611["sniperDustLargeSuppress"] = loadfx("vfx/dust/sniper_dust_kickup_accum_suppress");
  }

  level thread func_6B6C();
  level.var_1DF7 = 0;
  common_scripts\utility::func_0FB2(getEntArray("misc_turret", "classname"), ::func_9F3A);
  thread turret_spawned_turrets_overheat();
  maps\mp\gametypes\_weapon_plant::func_5285();
}

func_92BA(param_00, param_01) {}

func_27D0(param_00, param_01, param_02) {
  var_03 = spawn("script_model", level.var_5FEB);
  var_03 method_805C();
  wait 0.05;
  if(isDefined(self) && isDefined(var_03)) {
    var_03 thread func_1908(param_02);
    var_03 setModel(param_00);
    var_03 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
    var_03 method_80B1();
    var_03 markvisibleinkillcam(0);
    self waittill("death");
    if(isDefined(self.var_9D65)) {
      self.var_9D65 delete();
    }
  }

  if(isDefined(var_03)) {
    var_03 delete();
  }
}

func_1908(param_00) {
  self endon("death");
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = param_00.var_01A7;
  func_21AD(param_00, var_01);
  for(;;) {
    level common_scripts\utility::func_A70A("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
    if(!isDefined(self)) {
      return;
    }

    self method_805C();
    func_21AD(param_00, var_01);
  }
}

func_21AD(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(level.var_984D) {
      if(!isDefined(var_03.var_01A7) || var_03.var_01A7 == "spectator") {
        continue;
      }

      if(var_03.var_01A7 != param_01 && var_03 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
        self showtoclient(var_03);
      }

      continue;
    }

    if(isDefined(param_00) && var_03 == param_00) {
      continue;
    }

    if(!var_03 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
      continue;
    }

    self showtoclient(var_03);
  }
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_4DDE = 0;
    var_00.var_57CF = 0;
    maps\mp\gametypes\_gamelogic::func_869D(var_00, 0);
    if(!maps\mp\_utility::func_551F() && !function_0367()) {
      var_00 thread func_8EC8();
    }

    var_00 thread func_6B82();
    var_00 thread func_A92B();
    var_00 thread maps\mp\_flashgrenades::func_92E8();
  }
}

func_6B82() {
  self endon("disconnect");
  for(;;) {
    common_scripts\utility::func_A70A("spawned_player", "faux_spawn");
    self.var_2954 = self getcurrentweapon();
    self method_85BD(0);
    self method_85BE(1);
    self.var_35EF = 0;
    self.var_2577 = 0;
    self.var_4DDE = 0;
    maps\mp\gametypes\_gamelogic::func_869D(self, 0);
    if(!isDefined(self.var_9BBB)) {
      self.var_9BBB = "";
      self.var_9BBB = "none";
      self.var_9BBC = 0;
      self.var_9BBA = 0;
      self.var_9BB9 = 0;
      self.var_9BB7 = 0;
      self.var_9BB8 = 0;
      self.var_9BB6 = 0;
      self.trackingweaponassists = 0;
      self.trackingweaponmultikills = 0;
      self.var_9BBD = 0;
    }

    thread func_A938();
    thread func_A944();
    thread func_A941();
    thread func_A920();
    thread func_A959();
    thread func_A918();
    thread func_A8E9();
    if(!isDefined(level.var_585D) && level.var_585D || function_01EF(self)) {
      thread maps\mp\_riotshield::func_9BC6();
    }

    if(!function_0367()) {
      thread maps\mp\_fmj::func_3D93();
    }

    thread func_A917();
    if(isDefined(level.var_6B83)) {
      self thread[[level.var_6B83]]();
    }

    self.var_5BA9 = [];
    self.var_34A0 = undefined;
    self.var_9A8D = [];
    self.tookweaponkillweapon = [];
    self.var_6FBA = [];
    thread func_A957();
    thread divisionabilitypromptupdateondeath();
    thread func_5C12();
    thread lastdivisiontimesusageupdateondeath();
    thread func_A945();
    thread func_A91A();
    self.var_2954 = undefined;
    self.var_9DD6 = undefined;
    thread func_9B90();
    if(!isDefined(self.var_9070)) {
      self.var_9070 = spawnStruct();
    }

    self.var_9070.var_29BA = 0;
    self.var_9070.var_29D9 = 0;
    self.var_9070.var_9CFD = 0;
    if(!isDefined(self.var_6870)) {
      self.var_6870 = 0;
    }

    self.var_6870++;
    if(function_01EF(self)) {
      continue;
    }

    if(isDefined(self.var_3959)) {
      self.var_3959 = undefined;
    }

    level notify("log_player_spawn_data", self);
    thread func_62FE();
    thread func_6302();
  }
}

func_8EC8() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = undefined;
  for(;;) {
    self waittill("weapon_fired");
    if(self getstance() != "prone") {
      continue;
    }

    if(maps\mp\_utility::func_472A(self getcurrentweapon()) != "weapon_sniper") {
      continue;
    }

    var_01 = anglesToForward(self.var_001D);
    if(!isDefined(var_00) || gettime() - var_00 > 2000) {
      playFX(level.var_0611["sniperDustLarge"], self.var_0116 + (0, 0, 10) + var_01 * 50, var_01);
      var_00 = gettime();
      continue;
    }

    playFX(level.var_0611["sniperDustLargeSuppress"], self.var_0116 + (0, 0, 10) + var_01 * 50, var_01);
  }
}

func_469C(param_00, param_01) {
  var_02 = "";
  if(self.var_01A7 == "axis") {
    var_02 = var_02 + "AX_";
  } else {
    var_02 = var_02 + "AL_";
  }

  if(self method_843D()) {
    var_02 = var_02 + "w";
  }

  if(param_01 > 1) {
    var_02 = var_02 + randomintrange(0, param_01);
    var_02 = var_02 + "_";
  } else {
    var_02 = var_02 + "0_";
  }

  var_02 = var_02 + param_00;
  return var_02;
}

func_A947() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("sprint_melee_charge_begin");
    if(issubstr(self getcurrentweapon(), "shield_charge")) {
      self setclientomnvar("ui_show_shield_charge_ability_prompt", 0);
      self.shieldchargeactive = 1;
    } else {
      self setclientomnvar("ui_show_division_rifle_ability_prompt", 0);
    }

    maps\mp\gametypes\_division_change::func_3657(self.var_0079, maps\mp\gametypes\_divisions::func_461C(0));
    self.var_165B = 1;
    func_A13B();
  }
}

func_A946() {
  self endon("disconnect");
  self endon("death");
  self waittill("sprint_melee_charge_attack", var_00);
}

func_A949() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("sprint_melee_charge_end");
    maps\mp\gametypes\_division_change::func_2F7B(self.var_0079, maps\mp\gametypes\_divisions::func_461C(0));
    self.var_165B = 0;
    self.shieldchargeactive = 0;
    func_A13B();
  }
}

func_A948() {
  self endon("disconnect");
  self endon("death");
  self waittill("sprint_melee_charge_cooldown_finished");
}

func_A945() {
  self.var_165B = 0;
  self.shieldchargeactive = 0;
  func_A13B();
  thread func_A947();
  thread func_A946();
  thread func_A949();
  thread func_A948();
}

func_A91B() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self.var_3D9C = 0;
  for(;;) {
    self waittill("hold_breath_begin");
    if(isDefined(self.var_0079) && function_0367() || self.var_0079 != 5) {
      var_00 = maps\mp\gametypes\_divisions::func_461C(3);
      if(var_00 == "sharpshooter_level1" || var_00 == "sharpshooter_level2" || var_00 == "sharpshooter_level3") {
        maps\mp\gametypes\_division_change::func_3657(3, var_00);
        self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
        self.var_8AE0 = 1;
      }

      continue;
    }

    if(isDefined(level.var_585D) && level.var_585D) {
      self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
      self.var_8AE0 = 1;
    }
  }
}

func_A91D() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self.var_3D9B = 0;
  for(;;) {
    self waittill("hold_breath_end");
    if(isDefined(self.var_0079) && function_0367() || self.var_0079 != 5) {
      var_00 = maps\mp\gametypes\_divisions::func_461C(3);
      if(var_00 == "sharpshooter_level1" || var_00 == "sharpshooter_level2" || var_00 == "sharpshooter_level3") {
        maps\mp\gametypes\_division_change::func_2F7B(3, var_00, undefined, 0);
        self.var_8AE0 = 0;
      }

      continue;
    }

    if(isDefined(level.var_585D) && level.var_585D) {
      self.var_8AE0 = 0;
    }
  }
}

func_A91C() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("faux_spawn");
  self waittill("death");
  self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
}

func_A91A() {
  self.var_8AE0 = 0;
  self setclientomnvar("ui_hide_hud", 0);
  thread func_A91B();
  thread func_A91D();
  thread func_A91C();
}

func_5C12() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  func_A196();
}

lastdivisiontimesusageupdateondeath() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  maps\mp\gametypes\_divisions::updatedivisionusagestats();
  self.divisionusageindex = undefined;
}

divisionabilitypromptupdateondeath() {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  self setclientomnvar("ui_dragon_breath_state", -1);
  self setclientomnvar("ui_suppressor_state", -1);
  self setclientomnvar("ui_m30_rifle_state", -1);
  self setclientomnvar("ui_rifle_grenade_state", -1);
  self setclientomnvar("ui_resistance_state", -1);
  self setclientomnvar("ui_zk383_smg_state", -1);
  if(!isDefined(level.var_585D) || !level.var_585D) {
    self setclientomnvar("ui_show_division_shotgun_ability_prompt", 0);
    self setclientomnvar("ui_show_division_smg_ability_prompt", 0);
    self setclientomnvar("ui_show_division_resistance_ability_prompt", 0);
    self setclientomnvar("ui_show_rifle_grenade_ability_prompt", 0);
    self setclientomnvar("ui_show_m30_rifle_altmode_prompt", 0);
    self setclientomnvar("ui_show_zk383_smg_altmode_prompt", 0);
  }
}

func_A957() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  thread func_A94B();
  if(func_60AE(self.var_2954)) {
    self.var_5B94 = self.var_2954;
  } else {
    self.var_5B94 = "none";
  }

  var_00 = self getcurrentweapon();
  var_01 = 1;
  func_534B();
  for(;;) {
    if(!var_01) {
      self waittill("weapon_change", var_02);
      if(isDefined(var_02)) {
        func_A15E(var_02);
      }

      if(maps\mp\_utility::func_0649("specialty_class_shifty")) {
        thread maps\mp\perks\_perkfunctions::refillpistolmagazineonswitch();
      }
    }

    var_01 = 0;
    var_00 = self getcurrentweapon();
    if(var_00 == "flamethrower_mp" || var_00 == "flamethrower_german_mp" || var_00 == "flamethrower_grenadier_mp" || var_00 == "flamethrower_german_grenadier_mp") {
      self.var_A258 = 1;
    } else {
      self.var_A258 = 0;
    }

    if(var_00 == "killstreak_molotov_cocktail_mp" || var_00 == "killstreak_molotov_cocktail_grenadier_mp") {
      self.var_A25A = 1;
    } else {
      self.var_A25A = 0;
    }

    if(issubstr(var_00, "riotshield_mp")) {
      self.usingriotshield = 1;
    } else {
      self.usingriotshield = 0;
    }

    if(issubstr(var_00, "dragon_breath")) {
      var_03 = maps\mp\gametypes\_divisions::func_461C(4);
      if(var_03 == "incendiary_level1" || var_03 == "incendiary_level2" || var_03 == "incendiary_level3") {
        if(issubstr(var_00, "alt+")) {
          self.var_012C["dragonBreathActive"] = 1;
          self setclientomnvar("ui_dragon_breath_state", 1);
          thread func_6386();
        } else {
          self setclientomnvar("ui_dragon_breath_state", 0);
          self.var_012C["dragonBreathActive"] = 0;
        }

        if(self method_85EC() && isDefined(self.var_0079) && self.var_0079 != 5) {
          self setclientomnvar("ui_show_division_shotgun_ability_prompt", 1);
        }
      }
    } else if(!self method_801D() && var_01 == "none" && issubstr(self.var_8061, "dragon_breath")) {
      self setclientomnvar("ui_dragon_breath_state", -1);
      if(!isDefined(level.var_585D) || !level.var_585D) {
        self setclientomnvar("ui_show_division_shotgun_ability_prompt", 0);
      }
    }

    if(issubstr(var_01, "grenade_launcher")) {
      if(issubstr(var_01, "alt+")) {
        self.var_012C["rifleGrenadeActive"] = 1;
        self setclientomnvar("ui_rifle_grenade_state", 1);
        thread monitorriflegrenadeempty();
      } else {
        self setclientomnvar("ui_rifle_grenade_state", 0);
        self.var_012C["rifleGrenadeActive"] = 0;
      }

      if(self method_85EC()) {
        self setclientomnvar("ui_show_rifle_grenade_ability_prompt", 1);
      }
    } else if(!self method_801D() && var_01 == "none" && issubstr(self.var_8061, "grenade_launcher")) {
      self setclientomnvar("ui_rifle_grenade_state", -1);
      if(!isDefined(level.var_585D) || !level.var_585D) {
        self setclientomnvar("ui_show_rifle_grenade_ability_prompt", 0);
      }
    }

    if(isDefined(self.var_0079) && self.var_0079 != 5 && maps\mp\_utility::func_472A(var_01) == "weapon_smg" && issubstr(var_01, "suppressor")) {
      var_04 = maps\mp\gametypes\_divisions::func_461C(1);
      if(var_04 == "suppressor_level1" || var_04 == "suppressor_level2" || var_04 == "suppressor_level3") {
        if(maps\mp\_utility::func_5670(var_01)) {
          self setclientomnvar("ui_suppressor_state", 1);
          self.var_012C["altModeActive"] = 1;
        } else {
          self setclientomnvar("ui_suppressor_state", 0);
          self.var_012C["altModeActive"] = 0;
        }
      } else {
        self setclientomnvar("ui_suppressor_state", -1);
      }
    } else {
      self setclientomnvar("ui_suppressor_state", -1);
    }

    if(issubstr(var_05, "m30_rifle")) {
      if(maps\mp\_utility::func_5670(var_05)) {
        self setclientomnvar("ui_m30_rifle_state", 1);
      } else {
        self setclientomnvar("ui_m30_rifle_state", 0);
      }
    } else {
      self setclientomnvar("ui_m30_rifle_state", -1);
    }

    if(issubstr(var_05, "zk383")) {
      if(maps\mp\_utility::func_5670(var_05)) {
        self setclientomnvar("ui_zk383_smg_state", 1);
        self.var_012C["altModeActive"] = 1;
      } else {
        self setclientomnvar("ui_zk383_smg_state", 0);
        self.var_012C["altModeActive"] = 0;
      }
    } else {
      self setclientomnvar("ui_zk383_smg_state", -1);
    }

    if(var_05 == "none") {
      if(!isDefined(level.var_585D) || !level.var_585D) {
        self setclientomnvar("ui_show_division_smg_ability_prompt", 0);
        self setclientomnvar("ui_show_m30_rifle_altmode_prompt", 0);
        self setclientomnvar("ui_show_zk383_smg_altmode_prompt", 0);
      }

      continue;
    }

    var_03 = function_0061(var_05, 1);
    if(isDefined(var_05) && !maps\mp\_utility::func_585F() && !maps\mp\_utility::func_773F() && isPlayer(self)) {
      if(maps\mp\_utility::func_5699(var_05) || maps\mp\_utility::func_569A(var_05)) {
        var_06 = maps\mp\_utility::func_45B5(var_05);
        var_07 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_06, "kills");
        if(isDefined(var_07)) {
          self setcurrentweaponkillcount(var_07);
        } else {}
      }
    }

    self.var_4B45 = 0;
    self.var_4B2D = 0;
    self.var_4B47 = 0;
    self.var_4B20 = 0;
    if(isDefined(var_03)) {
      foreach(var_09 in var_03) {
        if(var_09 == "stock") {
          self.var_4B45 = 1;
          continue;
        }

        if(issubstr(var_09, "fmj")) {
          self.var_4B2D = 1;
          continue;
        }

        if(issubstr(var_09, "suppressor")) {
          self.var_4B47 = 1;
          continue;
        }

        if(issubstr(var_09, "akimbo")) {
          self.var_4B20 = 1;
          continue;
        }
      }
    }

    if(self.var_4B20) {
      self setclientomnvar("ui_show_left_clip_ammo", 1);
    } else {
      self setclientomnvar("ui_show_left_clip_ammo", 0);
    }

    if(self method_85EC() && isDefined(self.var_0079) && self.var_0079 != 5 && self.var_4B47 && maps\mp\_utility::func_472A(var_05) == "weapon_smg" && !issubstr(var_05, "zk383")) {
      self setclientomnvar("ui_show_division_smg_ability_prompt", 1);
    } else if(!isDefined(level.var_585D) || !level.var_585D) {
      self setclientomnvar("ui_show_division_smg_ability_prompt", 0);
    }

    if(self method_85EC() && issubstr(var_05, "m30_rifle")) {
      self setclientomnvar("ui_show_m30_rifle_altmode_prompt", 1);
    } else if(!isDefined(level.var_585D) || !level.var_585D) {
      self setclientomnvar("ui_show_m30_rifle_altmode_prompt", 0);
    }

    if(self method_85EC() && issubstr(var_05, "zk383")) {
      self setclientomnvar("ui_show_zk383_smg_altmode_prompt", 1);
    } else if(!isDefined(level.var_585D) || !level.var_585D) {
      self setclientomnvar("ui_show_zk383_smg_altmode_prompt", 0);
    }

    if(isDefined(self.hasuseweapon) && self.hasuseweapon) {
      continue;
    }

    if(maps\mp\_utility::func_5740(var_05)) {
      if(maps\mp\killstreaks\_killstreaks::func_1F6E()) {
        self.var_20CC = undefined;
      }

      continue;
    }

    var_04 = maps\mp\_utility::func_4738(var_05);
    if(var_04[0] == "alt") {
      var_0C = getsubstr(var_05, 4);
      var_05 = var_0C;
    }

    if(func_60AE(var_05)) {
      self.var_5B94 = var_05;
    }

    self.var_20CC = undefined;
  }
}

func_6386() {
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_fired", var_00);
    if(issubstr(var_00, "dragon_breath") && self method_8680()) {
      var_01 = "alt+" + var_00;
      if(self hasweapon(var_01)) {
        var_02 = self getweaponammoclip(var_01);
        var_02 = var_02 + self getweaponammostock(var_01);
        if(var_02 == 0) {
          self setclientomnvar("ui_dragon_breath_state", 0);
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
    self waittill("weapon_fired", var_00);
    if(issubstr(var_00, "grenade_launcher") && self method_8680()) {
      var_01 = "alt+" + var_00;
      if(self hasweapon(var_01)) {
        var_02 = self getweaponammoclip(var_01);
        var_02 = var_02 + self getweaponammostock(var_01);
        if(var_02 == 0) {
          self setclientomnvar("ui_rifle_grenade_state", 0);
          return;
        }
      }
    }
  }
}

func_A94B() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self.var_20CC = undefined;
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    self setclientomnvar("ui_show_left_clip_ammo", 0);
    thread func_5FBC(self getcurrentweapon());
    self.var_20CC = var_00;
    if(var_00 == "none" && isDefined(self.var_56A1) && self.var_56A1) {
      while(self.var_56A1) {
        wait 0.05;
      }

      self.var_20CC = undefined;
    }
  }
}

func_5FBC(param_00) {
  self endon("weapon_switch_started");
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  if(!maps\mp\killstreaks\_killstreaks::func_1F6E()) {
    return;
  }

  wait(1);
  if(self.var_4B20) {
    self setclientomnvar("ui_show_left_clip_ammo", 1);
  }

  self.var_20CC = undefined;
}

func_60AE(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(issubstr(param_00, "uav")) {
    return 0;
  }

  if(issubstr(param_00, "killstreak")) {
    return 0;
  }

  if(issubstr(param_00, "riotshield")) {
    return 0;
  }

  if(maps\mp\_utility::func_472A(param_00) == "weapon_projectile" && maps\mp\_utility::func_45B5(param_00) != "dp28_mp") {
    return 0;
  }

  var_01 = function_01D4(param_00);
  if(var_01 != "primary") {
    return 0;
  }

  if(issubstr(param_00, "combatknife") || issubstr(param_00, "underwater")) {
    return 0;
  }

  return 1;
}

func_34B7(param_00, param_01, param_02) {
  if(!maps\mp\_utility::func_581D()) {
    waittillframeend;
  }

  if(isDefined(level.var_17EF)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_34A0)) {
    return;
  }

  if(level.var_5139) {
    return;
  }

  var_03 = self.var_5B94;
  if(!isDefined(var_03)) {
    return;
  }

  if(var_03 == "none") {
    return;
  }

  if(!self hasweapon(var_03)) {
    return;
  }

  if(isDefined(level.var_3FC7) && !self[[level.var_3FC7]](var_03)) {
    return;
  }

  var_03 = function_036D(var_03, "alt+");
  if(var_03 != "riotshield_mp") {
    if(!self anyammoforweaponmodes(var_03)) {
      return;
    }

    var_04 = self getweaponammoclip(var_03, "right");
    var_05 = self getweaponammoclip(var_03, "left");
    if(common_scripts\utility::func_562E(self.var_012C["dragonBreathActive"]) && issubstr(var_03, "dragon_breath")) {
      var_06 = int(min(self getweaponammoclip("alt+" + var_03, "right"), self getweaponammostock(var_03)));
      var_07 = int(min(self getweaponammoclip("alt+" + var_03, "left"), max(self getweaponammostock(var_03) - var_06, 0)));
      var_04 = int(min(var_04 + var_06, function_01D5(var_03)));
      var_05 = int(min(var_05 + var_07, function_01D5(var_03)));
      self setweaponammostock(var_03, self getweaponammostock(var_03) - var_06 + var_07);
    }

    if(!var_04 && !var_05) {
      return;
    }

    var_08 = self getweaponammostock(var_03);
    var_09 = weaponmaxammo(var_03);
    if(var_08 > var_09) {
      var_08 = var_09;
    }

    var_0A = getdvarint("g_physicsWeaponDropScripted", 1);
    var_0B = undefined;
    var_0C = 0;
    if(var_0A && param_01 != "MOD_SUICIDE" && !isDefined(param_00) || self != param_00) {
      var_0D = self getcorpseentity();
      if(isDefined(var_0D)) {
        var_0E = var_0D getcorpseanim();
        if(isDefined(var_0E)) {
          var_0F = getmovedelta(var_0E, 0, 0.5);
          var_10 = anglesToForward((0, var_0D.var_001D[1], 0));
          var_11 = 0;
          if(maps\mp\_utility::func_5755(param_01)) {
            var_11 = randomintrange(1, 3);
          } else if(maps\mp\_utility::func_5695(param_01)) {
            var_11 = randomintrange(3, 5);
          } else if(maps\mp\_utility::func_56E5(param_01)) {
            var_11 = randomintrange(20, 40);
          } else {
            var_11 = randomintrange(1, 10);
          }

          var_12 = var_0F[0] * var_11;
          var_13 = var_0F[1] * var_11;
          var_14 = var_0F[2] * var_11;
          var_0B = self dropitem(var_03, (var_12, var_13, var_14), var_0D.var_001D);
          var_0C = 1;
        }
      }
    }

    if(!var_11) {
      var_0A = self dropitem(var_09);
      var_11 = 1;
    }

    if(!isDefined(var_0A)) {
      return;
    }

    if(maps\mp\_utility::func_5755(var_05)) {
      var_0A.var_0116 = (var_0A.var_0116[0], var_0A.var_0116[1], var_0A.var_0116[2] - 5);
    }

    var_0A method_817E(var_0C, var_0E, var_0D);
  } else {
    var_0B = self dropitem(var_0E);
    if(!isDefined(var_0E)) {
      return;
    }

    var_0E method_817E(1, 1, 0);
  }

  self.var_34A0 = 1;
  if(maps\mp\_riotshield::func_A9C9(var_0D)) {
    self method_84D2();
  }

  var_0E.var_0117 = self;
  var_0E.var_6DAF = var_09;
  var_0E.ownersattackerweapon = var_0C;
  var_0E.var_01A5 = "dropped_weapon";
  var_0E thread func_A934();
  var_0E thread func_2D45();
  if(isDefined(level.gamemodehandledroppedweapon)) {
    thread[[level.gamemodehandledroppedweapon]](var_0E);
  }
}

func_2E42(param_00, param_01) {
  var_02 = self getattachsize();
  var_03 = 0;
  while(var_03 < var_02) {
    var_04 = self getattachmodelname(var_03);
    if(var_04 != param_00) {
      continue;
    }

    var_05 = self getattachtagname(var_03);
    self method_802E(param_00, var_05);
    if(var_05 != param_01) {
      var_02 = self getattachsize();
      for(var_03 = 0; var_03 < var_02; var_03++) {
        var_05 = self getattachtagname(var_03);
        if(var_05 != param_01) {
          continue;
        }

        param_00 = self getattachmodelname(var_03);
        self method_802E(param_00, var_05);
        break;
      }
    }

    return 1;
    var_04++;
  }

  return 0;
}

func_2D45() {
  self endon("death");
  wait(60);
  if(!isDefined(self)) {
    return;
  }

  self delete();
}

func_452C() {
  var_00 = self.var_003A;
  var_01 = getsubstr(var_00, 7);
  return var_01;
}

func_A934() {
  self endon("death");
  var_00 = func_452C();
  var_01 = self.var_0117;
  for(;;) {
    self waittill("trigger", var_02, var_03, var_04, var_05, var_06);
    if(!isDefined(var_04) || !isDefined(var_05)) {
      continue;
    }

    if(var_04 == var_05) {
      if(var_04) {
        return;
      }

      continue;
    }

    break;
  }

  if(isDefined(var_00) && var_00 == var_02.var_7704) {
    return;
  }

  if(isDefined(var_00) && var_00 == var_02.var_835A) {
    return;
  }

  if(!function_0367() && (!isDefined(level.var_585D) || !level.var_585D) && isDefined(var_02.var_0079) && level.var_3FDC != "br") {
    var_07 = var_00;
    var_00 = maps\mp\gametypes\_division_change::func_7CCD(var_00);
    var_00 = maps\mp\gametypes\_division_change::func_0995(var_02, var_02.var_0079, var_00, undefined, 1);
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled() && isDefined(var_02.var_0079) && var_02.var_0079 == 6 && isDefined(var_02.var_012C["resistanceScramblerIndicatorActive"])) {
      var_00 = maps\mp\gametypes\_division_change::removealtmodeattachmentsfromweapon(var_00);
    }

    if(var_07 != var_00) {
      var_08 = var_02 getweaponammoclip(var_07, "right");
      var_09 = var_02 getweaponammoclip(var_07, "left");
      var_0A = var_02 getweaponammostock(var_07);
      var_02 takeweapon(var_07);
      var_02 maps\mp\_utility::func_0642(var_00, 0, 0, var_06);
      var_02 method_82FA(var_00, var_08, "right");
      var_02 method_82FA(var_00, var_09, "left");
      var_02 setweaponammostock(var_00, var_0A);
      var_02 switchtoweapon(var_00);
    }
  }

  var_02.var_6FBA[var_00] = undefined;
  var_02.var_9A8D[var_00] = undefined;
  var_02.tookweaponkillweapon[var_00] = undefined;
  var_02 notify("pickup_weapon", var_00);
  if(isDefined(var_02.var_012C["weaponPickupsCount"])) {
    var_02.var_012C["weaponPickupsCount"]++;
  }

  if(isDefined(var_01) && var_01 != var_02) {
    var_02.var_6FBA[var_00] = var_01;
    if(isDefined(self.var_6DAF) && self.var_6DAF == var_02) {
      var_02.var_9A8D[var_00] = var_01;
      if(isDefined(self.ownersattackerweapon)) {
        var_02.tookweaponkillweapon[var_00] = self.ownersattackerweapon;
      }
    }
  }

  var_0C = "none";
  if(isDefined(var_03)) {
    var_0C = var_03 func_452C();
  }

  updateplayervariablesforweaponexchange(var_02, var_0C, var_00);
  if(isDefined(var_03)) {
    var_03.var_0117 = var_02;
    var_03.var_01A5 = "dropped_weapon";
    if(isDefined(var_02.var_6FBA[var_0C])) {
      var_03.var_0117 = var_02.var_6FBA[var_0C];
      var_02.var_6FBA[var_0C] = undefined;
    }

    if(isDefined(var_02.var_9A8D[var_0C])) {
      var_03.var_6DAF = var_02;
      var_02.var_9A8D[var_0C] = undefined;
    }

    if(isDefined(var_02.var_9A8D[var_0C])) {
      var_03.ownersattackerweapon = undefined;
      var_02.var_9A8D[var_0C] = undefined;
    }

    var_03 thread func_A934();
  }
}

updateplayervariablesforweaponexchange(param_00, param_01, param_02) {
  if(isDefined(param_00.var_7704) && param_00.var_7704 == "none" || param_00.var_7704 == param_01) {
    param_00.var_7704 = param_02;
    return;
  }

  if(isDefined(param_00.var_835A) && param_00.var_835A == "none" || param_00.var_835A == param_01) {
    param_00.var_835A = param_02;
  }
}

func_586F() {
  var_00 = func_452C();
  var_01 = weaponaltweaponname(var_00);
  for(var_02 = 1; var_01 != "none" && var_01 != var_00; var_02++) {
    self method_817E(0, 0, 0, var_02);
    var_01 = weaponaltweaponname(var_01);
  }
}

func_4AF1(param_00) {
  var_01 = self;
  if(var_01 != param_00.var_68FB.var_0117) {
    return;
  }

  param_00.var_68FB notify("scavenger");
  var_01 notify("scavenger_pickup");
  var_02 = param_00.var_68FB.var_7DFF;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = var_01 method_834A();
  if(var_08 != "none" && var_01 maps\mp\_utility::func_0649("specialty_lethalresupply")) {
    var_09 = var_01 getweaponammoclip(var_08);
    if(function_03AD(var_08) && !isDefined(var_01.var_6088) || var_09 < var_01.var_6088) {
      var_01 method_82FA(var_08, var_09 + 1);
      if(var_09 == 0) {
        var_01 notify("got_lethal_resupply");
      }
    }

    var_03 = 1;
  }

  var_0A = var_01 method_831F();
  if(var_0A != "none" && var_01 maps\mp\_utility::func_0649("specialty_tacticalresupply")) {
    var_09 = var_01 getweaponammoclip(var_0A);
    if(!isDefined(var_01.var_60A0) || var_09 < var_01.var_60A0) {
      var_01 method_82FA(var_0A, var_09 + 1);
    }

    var_03 = 1;
  }

  if(var_01 maps\mp\_utility::func_0649("specialty_scavenger")) {
    var_0B = var_01 getweaponslistprimaries();
    foreach(var_0D in var_0B) {
      if(maps\mp\_utility::func_5699(var_0D) || level.var_808C && maps\mp\_utility::func_569A(var_0D)) {
        var_0E = var_01 getweaponammostock(var_0D);
        var_0F = 0;
        var_10 = maps\mp\_utility::func_472A(var_0D);
        if(func_5684(var_0D) || var_10 == "weapon_riot" || issubstr(var_0D, "riotshield")) {} else if(var_10 == "weapon_projectile" || issubstr(var_0D, "exocrossbow") || issubstr(var_0D, "microdronelauncher")) {
          if(var_02 && var_01 maps\mp\_utility::func_0649("specialty_explosiveammoresupply")) {
            var_0F = weaponclipsize(var_0D);
          }
        } else if(maps\mp\_utility::func_5670(var_0D) && issubstr(var_0D, "grenade_launcher")) {
          if(var_02 && var_01 maps\mp\_utility::func_0649("specialty_explosiveammoresupply")) {
            var_0F = weaponclipsize(var_0D);
          }
        } else if(maps\mp\_utility::func_5670(var_0D) && issubstr(var_0D, "dragon_breath")) {} else if(func_5696(var_0D)) {
          if(var_01 maps\mp\_utility::func_0649("specialty_bulletresupply")) {
            var_0F = weaponclipsize(var_0D);
          }
        }

        if(var_0F > 0) {
          if(level.var_3FDC == "onevone") {
            var_01 setweaponammostock(var_0D, maps\mp\gametypes\onevone::func_4413(var_0D, var_0E + var_0F, var_01 getweaponammoclip(var_0D)));
          } else {
            var_01 setweaponammostock(var_0D, var_0E + var_0F);
          }
        }
      }
    }

    if(var_04 maps\mp\_utility::func_0649("specialty_bulletresupply")) {
      var_07 = 1;
    }

    if(var_05 && var_04 maps\mp\_utility::func_0649("specialty_explosiveammoresupply")) {
      var_0A = 1;
    }
  }

  if(var_08 maps\mp\_utility::func_0649("specialty_scorestreakresupply")) {
    level thread maps\mp\gametypes\_rank::func_1457("scorestreak_pack", var_08);
    var_0D = 1;
  }

  if(var_08 maps\mp\_utility::func_0649("specialty_intelresupply")) {
    function_0256(var_08.var_0116, var_08, 1200);
    var_0E = 1;
  }

  var_07.var_68FB func_4AED();
  if(var_0E) {
    var_08 maps\mp\gametypes\_damagefeedback::func_A102("resupply_intel");
  }

  if(var_0B) {
    if(var_0E) {
      wait(1.5);
    }

    var_08 maps\mp\gametypes\_damagefeedback::func_A102("resupply_equipment");
  }

  if(var_0C) {
    if(var_0B || var_0E) {
      wait(1.5);
    }

    var_08 maps\mp\gametypes\_damagefeedback::func_A102("resupply_bullets");
  }

  if(var_0D) {
    if(var_0C || var_0B || var_0E) {
      wait(1.5);
    }

    var_08 maps\mp\gametypes\_damagefeedback::func_A102("resupply_scorestreak");
  }

  if(var_11) {
    if(var_0C || var_0B || var_0D || var_0E) {
      wait(1.5);
    }

    var_08 maps\mp\gametypes\_damagefeedback::func_A102("resupply_launcher");
  }
}

func_4AF0(param_00) {}

func_4AEF() {
  self endon("death");
  self endon("scavenger");
  level endon("game_ended");
  if(level.var_3FDC != "onevone") {
    return;
  }

  wait(25);
  func_4AED();
}

func_4AEE(param_00) {
  self endon("death");
  self endon("scavenger");
  level endon("game_ended");
  param_00 common_scripts\utility::func_A70A("death", "disconnect");
  func_4AED();
}

func_4AED() {
  if(isDefined(self)) {
    self.var_0106 delete();
    self.var_9D65 notify("deleted");
    self.var_9D65 delete();
    self notify("death");
  }
}

func_34A9(param_00, param_01, param_02) {
  waittillframeend;
  if(level.var_5139) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 == self) {
    return;
  }

  if(level.var_585D) {
    return;
  }

  if(!param_00 maps\mp\_utility::func_0649("specialty_scavenger")) {
    return;
  }

  if(maps\mp\_utility::func_579B()) {
    if(self isusingturret()) {
      var_03 = self method_85E3();
      if(isDefined(var_03) && isDefined(var_03.var_A2C8)) {
        return;
      }
    }

    if(getdvarint("bot_FlightDynamicsModeEnabled", 0) > 0) {
      return;
    }
  }

  var_04 = isDefined(param_01) && param_01 != "MOD_GRENADE" && param_01 != "MOD_GRENADE_SPLASH" && param_01 != "MOD_EXPLOSIVE" && param_01 != "MOD_PROJECTILE" && param_01 != "MOD_PROJECTILE_SPLASH";
  var_05 = param_00 maps\mp\_utility::func_0649("specialty_explosiveammoresupply");
  var_06 = param_00 maps\mp\_utility::func_0649("specialty_lethalresupply") || param_00 maps\mp\_utility::func_0649("specialty_tacticalresupply");
  var_07 = param_00 maps\mp\_utility::func_0649("specialty_bulletresupply");
  var_08 = param_00 maps\mp\_utility::func_0649("specialty_scorestreakresupply");
  var_09 = param_00 maps\mp\_utility::func_0649("specialty_intelresupply");
  if(!var_04 && !var_06 && !var_07 && !var_08) {
    return;
  }

  var_0A = "usa_grenpack_org1";
  if(var_07) {
    var_0A = "usa_foragepack_org1";
  }

  if(var_08 || var_09) {
    var_0A = "usa_reqpack_org1";
  }

  if(var_05) {
    var_0A = "usa_launchpack_org1";
  }

  var_0B = spawnStruct();
  var_0C = bulletTrace(self.var_0116, self.var_0116 + (0, 0, -1000), 0, self, 0, 0, 0, 0, 1, 0, 0);
  var_0B.var_0116 = var_0C["position"];
  var_0B.var_0117 = param_00;
  var_0B.var_9D65 = spawn("trigger_radius", var_0B.var_0116, 0, 32, 48);
  var_0B.var_9D65.var_68FB = var_0B;
  var_0B.var_0106 = spawn("script_model", var_0B.var_0116);
  var_0B.var_0106 setModel(var_0A);
  var_0B.var_0106 rotateto((0, 0, 0), 0.1);
  var_0B.var_0106 method_805C();
  var_0B.var_0106 showtoclient(param_00);
  var_0B.var_7DFF = var_04;
  var_0B.var_9D65 thread maps\mp\_dynamic_world::func_9DC3(::func_4AF1, ::func_4AF0);
  var_0B thread func_4AEF();
  var_0B thread func_4AEE(param_00);
}

func_4726(param_00) {
  return 2;
}

func_4727(param_00) {
  return 1;
}

func_44ED() {
  var_00 = "frag_grenade_mp";
  var_01 = self method_817F(var_00);
  return var_01;
}

func_468A() {
  var_00 = self method_817F("smoke_grenade_mp");
  return var_00;
}

func_8A67(param_00, param_01, param_02) {
  maps\mp\gametypes\_gamelogic::func_8A67(param_00, param_01, param_02);
}

func_2546(param_00, param_01) {
  var_02 = param_00.var_A9BB;
  var_03 = maps\mp\_utility::func_4431(param_01);
  for(var_04 = 0; var_04 < var_02; var_04++) {
    if(param_00.var_A9BA[var_04].var_0109 == var_03) {
      return var_04;
    }
  }

  return -1;
}

func_A959(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_fired", var_01);
    maps\mp\gametypes\_gamelogic::func_869D(self, 1);
    self.var_5BDB = gettime();
    if(isai(self)) {
      continue;
    }

    if(isDefined(self.var_8B3D)) {
      self.var_8B3D++;
      if(isDefined(level.var_585D) && level.var_585D) {
        if(maps\mp\_utility::func_4431(var_01) == self.var_76D8) {
          self.var_A9BA[self.var_76D9].var_8B34 = self.var_A9BA[self.var_76D9].var_8B34 + 1;
        } else {
          var_02 = func_2546(self, var_01);
          if(var_02 == -1) {
            self.var_76D8 = "";
            self.var_76D9 = -1;
          } else {
            self.var_A9BA[var_02].var_8B34 = self.var_A9BA[var_02].var_8B34 + 1;
            self.var_76D8 = maps\mp\_utility::func_4431(var_01);
            self.var_76D9 = var_02;
          }
        }
      }
    }

    var_03 = maps\mp\_utility::func_4431(var_01);
    if(!maps\mp\_utility::func_5699(var_03) && !maps\mp\_utility::func_569A(var_03)) {
      continue;
    }

    var_04 = 0;
    if(!function_0367()) {
      var_05 = maps\mp\gametypes\_persistence::func_9330("totalShots") + 1;
      var_04 = maps\mp\gametypes\_persistence::func_9330("hits");
      var_06 = clamp(float(var_04) / float(var_05), 0, 1) * 10000;
      maps\mp\gametypes\_persistence::func_9339("totalShots", var_05);
      maps\mp\gametypes\_persistence::func_9339("accuracy", int(var_06));
      maps\mp\gametypes\_persistence::func_9339("misses", int(var_05 - var_04));
    }

    if(isDefined(self.var_5BEF) && self.var_5BEF.var_5BF4 == gettime()) {
      self.var_4DDE = 0;
      return;
    }

    var_07 = 1;
    func_8A67(var_01, var_07, "shots");
    func_8A67(var_01, self.var_4DDE, "hits");
    self.var_4DDE = 0;
  }
}

func_A8E9() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  if(isai(self)) {
    return;
  }

  self.var_5663 = 0;
  for(;;) {
    var_00 = self playerads() > 0.5;
    var_01 = self getcurrentweapon();
    if(!self isusingturret() && function_01AA(var_01) == "sniper" && issubstr(var_01, "hold_breath_") && !issubstr(var_01, "iron_sight_sniper") && !issubstr(var_01, "telescopic_sight")) {
      if(self playerads() >= 1 && self method_8676() == 0) {
        var_02 = maps\mp\gametypes\_divisions::func_461C(3);
        if((isDefined(level.var_585D) && level.var_585D) || (isDefined(self.var_0079) && self.var_0079 != 5 && var_02 == "sharpshooter_level1") || var_02 == "sharpshooter_level2" || var_02 == "sharpshooter_level3") {
          self setclientomnvar("ui_show_division_sniper_ability_prompt", 1);
        } else {
          self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
        }
      } else {
        self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
      }
    }

    if(maps\mp\gametypes\_tweakables::func_46F7("game", "minimapHiddenWhileADS") && !maps\mp\_utility::func_0649("specialty_minimapwhileads")) {
      if(var_01 && !self.var_5663 && !maps\mp\_utility::func_0649("specialty_minimapwhileads")) {
        self setclientomnvar("ui_hide_minimap", 1);
      }
    }

    self.var_5663 = var_01;
    wait 0.05;
  }
}

func_21C6(param_00, param_01, param_02) {
  self endon("disconnect");
  var_03 = maps\mp\_utility::func_4431(param_00);
  if(!func_5795(var_03) && !func_57CD(var_03)) {
    return;
  }

  if(!maps\mp\_utility::func_5695(param_01)) {
    return;
  }

  if(self meleeButtonPressed()) {
    return;
  }

  switch (function_01AA(param_00)) {
    case "beam":
    case "mg":
    case "pistol":
    case "smg":
    case "rifle":
    case "sniper":
      self.var_4DDE++;
      break;

    case "spread":
      self.var_4DDE = 1;
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

  if(issubstr(param_00, "riotshield")) {
    thread maps\mp\gametypes\_gamelogic::func_996D("riotshield", self.var_4DDE, "hits");
    self.var_4DDE = 0;
  }

  waittillframeend;
  if(!isDefined(self.var_5BA9[param_00])) {
    self.var_5BA9[param_00] = 0;
  }

  if(self.var_5BA9[param_00] == gettime()) {
    return;
  }

  self.var_5BA9[param_00] = gettime();
  var_04 = maps\mp\gametypes\_persistence::func_9330("totalShots");
  var_05 = maps\mp\gametypes\_persistence::func_9330("hits") + 1;
  if(var_05 <= var_04) {
    maps\mp\gametypes\_persistence::func_9339("hits", var_05);
    maps\mp\gametypes\_persistence::func_9339("misses", int(var_04 - var_05));
    var_06 = clamp(float(var_05) / float(var_04), 0, 1) * 10000;
    maps\mp\gametypes\_persistence::func_9339("accuracy", int(var_06));
  }
}

func_1188(param_00, param_01) {
  return func_3ECD(param_01, param_00);
}

func_3ECD(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return 1;
  }

  if(!level.var_984D) {
    return 1;
  }

  if(function_0367() && isonevonedamage(param_01, param_00)) {
    return 1;
  }

  var_03 = param_01.var_01A7;
  var_04 = level.var_3EC4;
  if(isDefined(param_02)) {
    var_04 = param_02;
  }

  if(var_04 != 0) {
    return 1;
  }

  if(param_01 == param_00) {
    return 1;
  }

  if(!isDefined(var_03)) {
    return 1;
  }

  if(var_03 != param_00.var_01A7) {
    return 1;
  }

  if(isDefined(self.var_0C2E) && self.var_0C2E) {
    return 1;
  }

  return 0;
}

isonevonedamage(param_00, param_01) {
  if(isDefined(param_00) && param_00 == param_01 && isDefined(param_00.var_572A) && param_00.var_572A) {
    return 1;
  }

  if(!isDefined(param_00.var_4E03) || !isDefined(param_01.var_4E03)) {
    return 0;
  }

  return common_scripts\utility::func_0F79(param_00.var_4E03, param_01) && common_scripts\utility::func_0F79(param_01.var_4E03, param_00);
}

func_A918() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.var_99AC = undefined;
  self.var_4820 = 0;
  if(maps\mp\_utility::func_4529("scr_deleteexplosivesonspawn", 1) == 1) {
    if(isDefined(self.var_3233)) {
      self.var_3233 = undefined;
    } else {
      func_2CF3();
    }
  } else {
    if(!isDefined(self.var_5FDB)) {
      self.var_5FDB = [];
    }

    if(!isDefined(self.var_232F)) {
      self.var_232F = [];
    }

    if(!isDefined(self.var_1B56)) {
      self.var_1B56 = [];
    }

    if(!isDefined(self.var_2B71)) {
      self.var_2B71 = [];
    }
  }

  thread func_A916();
  thread func_A924();
  thread func_A923();
  thread func_2D2E();
  thread func_A8E3();
  for(;;) {
    self waittill("grenade_pullback", var_00);
    func_8A67(var_00, 1, "shots");
    maps\mp\gametypes\_gamelogic::func_869D(self, 1);
    thread func_A92C();
    if(var_00 == "claymore_mp") {
      continue;
    }

    self.var_99AC = var_00;
    self.var_4820 = 1;
    if(var_00 == "c4_mp" || var_00 == "bouncingbetty_mp") {
      func_2379();
    } else {
      func_1711();
    }

    self.var_99AC = undefined;
  }
}

func_A8E3() {
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watch_throwing_knife_usage");
  self endon("watch_throwing_knife_usage");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(isDefined(var_00)) {
      var_00.var_5CC6 = self.var_5CC6;
      if(issubstr(var_01, "throwingknife")) {
        var_00 thread func_99AD(self);
      }
    }
  }
}

func_1711() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self endon("offhand_end");
  self endon("weapon_change");
  var_00 = gettime();
  self waittill("grenade_fire", var_01, var_02);
  var_01.var_5CC6 = self.var_5CC6;
  if(isDefined(var_01)) {
    if(gettime() - var_00 > 1000 && var_02 == "frag_grenade_mp" || var_02 == "frag_grenade_german_mp") {
      var_01.var_56B8 = 1;
    }

    self.var_20CC = undefined;
    var_01.var_0117 = self;
    var_01.var_A9E0 = var_02;
    var_01 thread watchmissilestuck();
    switch (var_02) {
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_01 thread maps\mp\gametypes\_shellshock::func_485C();
        break;

      case "concussion_grenade_mp":
        var_01 thread func_35F0();
        break;

      case "stun_grenade_mp":
        break;

      case "smoke_grenade_axis_expeditionary_mp":
      case "smoke_grenade_expeditionary_mp":
      case "smoke_grenade_axis_mp":
      case "smoke_grenade_mp":
        var_01 thread func_A942();
        break;
    }
  }
}

watchmissilestuck() {
  self endon("death");
  self waittill("missile_stuck");
  self.missile_stuck = 1;
}

func_A92C() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");
  if(isDefined(self.var_20CC) && self.var_20CC != self getcurrentweapon()) {
    self.var_20CC = undefined;
  }
}

func_A942() {
  level endon("smokeTimesUp");
  var_00 = self.var_0117;
  var_00 endon("disconnect");
  self waittill("explode", var_01);
  var_02 = 128;
  var_03 = 8;
  level thread func_A6FC(var_03, var_02, var_01);
  for(;;) {
    if(!isDefined(var_00)) {
      break;
    }

    foreach(var_05 in level.var_744A) {
      if(!isDefined(var_05) || !isDefined(var_05.var_01A7)) {
        continue;
      }

      if(level.var_984D && var_05.var_01A7 == var_00.var_01A7) {
        if(distancesquared(var_05.var_0116, var_01) < var_02 * var_02) {
          var_05.var_5137 = var_00;
        } else {
          var_05.var_5137 = undefined;
        }

        continue;
      }

      if(distancesquared(var_05.var_0116, var_01) < var_02 * var_02) {
        var_05.var_5384 = var_00;
        continue;
      }

      var_05.var_5384 = undefined;
    }

    wait 0.05;
  }
}

func_A6FC(param_00, param_01, param_02) {
  maps\mp\gametypes\_hostmigration::func_A6F5(param_00);
  level notify("smokeTimesUp");
  waittillframeend;
  foreach(var_04 in level.var_744A) {
    if(isDefined(var_04)) {
      var_04.var_5384 = undefined;
    }
  }
}

func_A94E() {
  self waittill("death");
  if(isDefined(self.var_5AB2)) {
    self.var_5AB2 delete();
  }
}

func_99AD(param_00) {
  self endon("death");
  self makeunusable();
  if(!isDefined(param_00) || !maps\mp\_utility::func_57A0(param_00)) {
    return;
  }

  var_01 = undefined;
  self waittill("missile_stuck", var_01);
  if(isDefined(var_01) && isPlayer(var_01) || function_01EF(var_01)) {
    self delete();
    return;
  }

  var_02 = spawn("trigger_radius", self.var_0116, 0, 64, 64);
  var_02 enablelinkto();
  var_02 linkto(self);
  var_02.var_01A5 = "dropped_knife";
  self.var_5AB2 = var_02;
  thread func_A94E();
  for(;;) {
    wait 0.05;
    if(!isDefined(var_02)) {
      return;
    }

    var_02 waittill("trigger", var_03);
    if(!isPlayer(var_03) || !maps\mp\_utility::func_57A0(var_03) || var_03 != param_00) {
      continue;
    }

    if(!var_03 hasweapon(self.var_A9E0)) {
      continue;
    }

    var_04 = var_03 getweaponammoclip(self.var_A9E0);
    var_03 method_82FA(self.var_A9E0, var_04 + 1);
    var_03 maps\mp\gametypes\_damagefeedback::func_A102("resupply_throwingknife");
    self delete();
  }
}

func_A92B() {
  self endon("disconnect");
  for(;;) {
    self waittill("missile_fire", var_00, var_01);
    var_02 = [var_00];
    if(issubstr(var_01, "_gl")) {
      var_00.var_0117 = self;
      var_00.var_7704 = self getcurrentprimaryweapon();
      var_00 thread maps\mp\gametypes\_shellshock::func_485C();
    }

    if(isDefined(var_00)) {
      var_00.var_A9E0 = var_01;
      if(func_5794(var_01)) {
        var_00.var_3BE0 = self playerads();
      }
    }

    var_03 = maps\mp\_utility::func_45B5(var_01);
    switch (var_03) {
      case "iw5_lsr_mp":
        var_00.var_5E70 = self.var_93AE;
        level notify("stinger_fired", self, var_02);
        thread maps\mp\_utility::func_8626(var_00, "tag_origin", 65);
        break;

      case "panzerfaust60_mp":
      case "piat_mp":
      case "panzerschreck_mp":
      case "bazooka_mp":
        level notify("launcher_missile_fire", self, var_02);
        break;

      default:
        break;
    }

    switch (var_03) {
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
        var_00 thread maps\mp\gametypes\_shellshock::func_485C();
        break;

      default:
        break;
    }

    var_00 thread func_A929(self, var_03);
  }
}

func_35F0() {
  thread maps\mp\gametypes\_shellshock::func_36DC();
  self endon("end_explode");
  self waittill("explode", var_00);
  var_01 = func_44B3(var_00, 512, 0);
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_0117) && !func_3ECD(self.var_0117, var_03.var_0117)) {
      continue;
    }

    var_03 notify("emp_damage", self.var_0117, 8);
  }
}

func_66D9() {
  thread maps\mp\gametypes\_shellshock::func_36DC();
  self endon("end_explode");
  self waittill("explode", var_00);
  level thread func_3221(var_00, self.var_0117);
  var_01 = func_44B3(var_00, 512, 0);
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_0117) && !func_3ECD(self.var_0117, var_03.var_0117)) {
      continue;
    }

    var_03 notify("emp_damage", self.var_0117, 8);
  }
}

func_2578(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(self == param_02) {
    param_04 = param_04 * 0.5;
  }

  if(!isDefined(param_01)) {
    return;
  } else if(param_03 == "MOD_IMPACT") {
    return;
  } else if(common_scripts\utility::func_562E(self.concussionimmune)) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_4B97)) {
    return;
  }

  var_07 = 1;
  if(isDefined(param_01.var_0117) && param_01.var_0117 == param_02) {
    var_07 = 0;
  }

  var_08 = 1 - distancesquared(self.var_0116, param_01.var_0116) / param_04 * param_04;
  if(var_08 < 0) {
    var_08 = 0;
  }

  var_09 = param_05 + param_06 - param_05 * var_08;
  wait 0.05;
  if(maps\mp\_utility::func_0649("specialty_stun_resistance")) {
    self.var_8C5B = gettime() + var_09 * 1000;
    var_09 = 0;
  }

  self notify("concussed", param_02);
  if(param_02 != self) {
    param_02 maps\mp\gametypes\_missions::func_7750("ch_alittleconcussed");
  }

  self shellshock("concussion_grenade_mp", var_09, var_09);
  self shellshock("ear_ring_mp", var_09, var_09);
  self.var_2577 = gettime() + var_09 * 1000;
  if(var_07 && param_02 != self) {
    param_02 thread maps\mp\gametypes\_damagefeedback::func_A102("stun");
  }
}

func_3D43(param_00, param_01, param_02) {
  var_03 = 640000;
  var_04 = -25536;
  var_05 = 60;
  var_06 = 40;
  var_07 = 11;
  if(!maps\mp\_utility::func_57A0(param_00) || param_00.var_0178 != "playing") {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_4B97)) {
    return;
  }

  var_08 = distancesquared(param_01, param_00.var_0116);
  if(var_08 > var_03) {
    return;
  }

  if(var_08 <= var_04) {
    var_09 = 1;
  } else {
    var_09 = 1 - var_09 - var_05 / var_04 - var_05;
  }

  var_0A = param_00 method_81D8(param_01);
  if(var_0A < 0.5) {
    return;
  }

  var_0B = anglesToForward(param_00 getangles());
  var_0C = param_00.var_0116;
  switch (param_00 getstance()) {
    case "stand":
      var_0C = (var_0C[0], var_0C[1], var_0C[2] + var_05);
      break;

    case "crouch":
      var_0C = (var_0C[0], var_0C[1], var_0C[2] + var_06);
      break;

    case "prone":
      var_0C = (var_0C[0], var_0C[1], var_0C[2] + var_07);
      break;
  }

  var_0D = param_01 - var_0C;
  var_0D = vectornormalize(var_0D);
  var_0E = 0.5 * 1 + vectordot(var_0B, var_0D);
  param_00 notify("flashbang", param_01, var_09, var_0E, param_02);
}

func_3221(param_00, param_01) {
  level endon("game_ended");
  var_02 = 1;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    if(var_03 > 0) {
      playsoundatpos(param_00, "null");
      foreach(var_05 in level.var_744A) {
        func_3D43(var_05, param_00, param_01);
      }
    }

    var_07 = func_44B3(param_00, 512, 0);
    foreach(var_09 in var_07) {
      if(isDefined(var_09.var_0117) && !func_3ECD(self.var_0117, var_09.var_0117)) {
        continue;
      }

      var_09 notify("emp_damage", self.var_0117, 8);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

func_2379() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::func_A70A("grenade_fire", "weapon_change", "offhand_end");
  self.var_20CC = undefined;
}

func_21EB(param_00, param_01) {
  if(self.var_4820) {
    self.var_4820 = 0;
    return;
  }

  if(!issubstr(param_01, "frag_") && !issubstr(param_01, "semtex_")) {
    return;
  }

  if(param_01 == "frag_grenade_short_mp") {
    return;
  }

  param_00.var_999E = 1;
  param_00 thread maps\mp\gametypes\_shellshock::func_485C();
}

func_5FDA(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isDefined(var_03[0])) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

func_A916() {
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("disconnect");
  self.var_232F = [];
  func_5316();
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    var_02 = function_01DA(var_01);
    var_03 = function_027E(var_01);
    if(var_02 || var_03) {
      if(!self.var_5FDB.size) {
        thread func_A925();
      }

      if(self.var_5FDB.size) {
        self.var_5FDB = func_5FDA(self.var_5FDB);
        if(self.var_5FDB.size >= level.var_6092) {
          self.var_5FDB[0][0] method_81D6();
        }
      }

      var_04 = self.var_5FDB.size;
      self.var_5FDB[var_04] = [];
      self.var_5FDB[var_04][0] = var_00;
      self.var_5FDB[var_04][1] = var_02;
      self.var_5FDB[var_04][2] = var_03;
      if(isDefined(var_00)) {
        var_00.var_0117 = self;
        var_00 setotherent(self);
        var_00.var_01A7 = self.var_01A7;
        var_00.var_A9E0 = var_01;
        var_00.var_94B9 = 0;
      }
    } else if(isDefined(var_00)) {
      var_00.var_0117 = self;
      var_00.var_A9E0 = var_01;
    }

    func_3BE8(var_00, var_01);
  }
}

func_3BE8(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(param_01 == "c4" || param_01 == "c4_mp" || param_01 == "c4_zm") {
    func_3BD7(param_00, param_01);
  }

  if(param_01 == "claymore" || param_01 == "claymore_mp") {
    func_3BD8(param_00, param_01);
  }

  if(param_01 == "bouncingbetty" || param_01 == "bouncingbetty_mp" || param_01 == "bouncingbetty_zm") {
    func_3C15(param_00, param_01);
  }

  if(param_01 == "thermite" || param_01 == "thermite_mp" || param_01 == "killstreak_molotov_cocktail_mp" || param_01 == "killstreak_molotov_cocktail_grenadier_mp") {
    param_00 thread func_4AFE(self, param_01);
  }

  if(param_01 == "tabun_grenade_mp") {
    param_00 thread func_4A66(self, param_01);
  }

  if(param_01 == "decoy_device_mp") {
    thread func_49C8(param_00);
  }

  if(param_01 == "signal_flare_mp" || param_01 == "signal_flare_expeditionary_mp") {
    param_00 thread func_4AF3(self, param_01);
  }

  if(param_01 == "s2_tactical_insertion_device_mp" || param_01 == "s2_tactical_insertion_cavalry_mp") {
    func_4AF9(param_00, param_01);
  }

  if(param_01 == "role_barbed_wire_mp") {
    param_00 thread func_499D(self, param_01);
  }

  if(param_01 == "role_explosive_rat_mp") {
    func_3BE4(param_00, param_01);
  }

  if(issubstr(param_01, "semtex")) {
    func_9304(param_00);
  }

  func_21EB(param_00, param_01);
  param_00 thread func_A929(self, param_01);
}

func_3BD7(param_00, param_01) {
  thread lib_0378::func_8D74("wpn_c4_throw");
  level.var_61ED[level.var_61ED.size] = param_00;
  common_scripts\utility::func_0613(param_01, 0);
  param_00 thread func_A8F5(param_01, self, self.var_012C["team"]);
  if(!maps\mp\_utility::func_585F()) {
    param_00 thread maps\mp\gametypes\_shellshock::func_1DEE();
  }

  param_00 thread func_1DF0();
  param_00 thread func_1DF5();
  param_00 thread func_1DF6();
  param_00 thread func_A8F7();
}

waittill_missile_stuck_or_timeout() {
  return common_scripts\utility::func_A71A(10, "missile_stuck");
}

func_A8F5(param_00, param_01, param_02) {
  self endon("death");
  if(isDefined(param_01) && param_01 maps\mp\_utility::func_0649("specialty_shortfuse")) {
    wait(level.shortdelayc4armtime);
  } else {
    if(level.var_258F) {
      waittill_missile_stuck_or_timeout();
    }

    wait(level.var_2CBD);
  }

  self.var_0117 common_scripts\utility::func_0613(param_00, 1);
  thread watchc4teamheadicon(param_02);
  thread func_A8F6(param_01);
}

watchc4teamheadicon(param_00) {
  self endon("death");
  if(!level.var_258F && !common_scripts\utility::func_562E(self.missile_stuck)) {
    waittill_missile_stuck_or_timeout();
  }

  thread func_86CA(param_00, 1);
}

func_A8F6(param_00) {
  param_00 setuseholdoverride(1);
  common_scripts\utility::func_A70A("death", "detonate");
  if(isDefined(param_00)) {
    param_00 setuseholdoverride(0);
  }
}

func_A8F7() {
  self endon("death");
  self waittill("missile_stuck");
  self.missile_stuck = 1;
  self.var_9D65 = spawn("script_origin", self.var_0116);
  self.var_9D65.var_0117 = self;
  thread func_3800(self.var_0117, 1);
  func_5FB8();
  thread func_1DF4(self.var_9D65);
}

func_1DF4(param_00) {
  param_00 endon("death");
  common_scripts\utility::func_A70A("death", "detonate");
  param_00 delete();
}

func_1DF5() {
  self endon("death");
  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    playFXOnTag(common_scripts\utility::func_44F5("sentry_explode_mp"), self, "tag_origin");
    self.var_2F74 = 1;
    self notify("disabled");
    wait(var_01);
    self.var_2F74 = undefined;
    self notify("enabled");
  }
}

func_1DF6() {
  self endon("death");
  for(;;) {
    level waittill("emp_update");
    if((level.var_984D && level.var_9852[self.var_01A7]) || !level.var_984D && isDefined(level.var_35F6) && level.var_35F6 != self.var_0117) {
      self.var_2F74 = 1;
      self notify("disabled");
      continue;
    }

    self.var_2F74 = undefined;
    self notify("enabled");
  }
}

func_86CA(param_00, param_01) {
  self endon("death");
  wait 0.05;
  var_02 = (0, 0, 20);
  if(isDefined(param_01) && param_01) {
    var_02 = rotatevector(var_02, self.var_001D);
  }

  if(level.var_984D && !function_0367()) {
    maps\mp\_entityheadicons::func_873C(param_00, var_02);
    return;
  }

  if(isDefined(self.var_0117)) {
    maps\mp\_entityheadicons::func_86FC(self.var_0117, var_02);
  }
}

func_3BD8(param_00, param_01) {
  self endon("faux_spawn");
  self endon("spawned_player");
  self endon("disconnect");
  if(!isalive(self)) {
    param_00 notify("remove");
    param_00 delete();
    return;
  }

  param_00 method_805C();
  param_00 common_scripts\utility::func_A71A(0.05, "missile_stuck");
  if(function_0030(param_00)) {
    param_00 notify("remove");
    param_00 delete();
    return;
  }

  var_02 = 60;
  var_03 = (0, 0, 4);
  var_04 = distancesquared(self.var_0116, param_00.var_0116);
  var_05 = distancesquared(self getEye(), param_00.var_0116);
  var_04 = var_04 + 600;
  var_06 = param_00 getlinkedparent();
  if(isDefined(var_06)) {
    param_00 unlink();
  }

  if(var_04 < var_05) {
    if(var_02 * var_02 < distancesquared(param_00.var_0116, self.var_0116)) {
      var_07 = bulletTrace(self.var_0116, self.var_0116 - (0, 0, var_02), 0, self);
      if(var_07["fraction"] == 1) {
        param_00 delete();
        self setweaponammostock("claymore_mp", self getweaponammostock("claymore_mp") + 1);
        return;
      } else {
        param_00.var_0116 = var_07["position"];
        var_06 = var_07["entity"];
      }
    } else {}
  } else if(var_03 * var_03 < distancesquared(param_01.var_0116, self getEye())) {
    var_07 = bulletTrace(self.var_0116, self.var_0116 - (0, 0, var_03), 0, self);
    if(var_07["fraction"] == 1) {
      param_00 delete();
      self setweaponammostock("claymore_mp", self getweaponammostock("claymore_mp") + 1);
      return;
    } else {
      param_00.var_0116 = var_07["position"];
      var_06 = var_07["entity"];
    }
  } else {
    var_04 = (0, 0, -5);
    param_01.var_001D = param_01.var_001D + (0, 180, 0);
  }

  param_01.var_001D = param_01.var_001D * (0, 1, 1);
  param_01.var_0116 = param_01.var_0116 + var_04;
  if(isDefined(var_07)) {
    param_01 linkto(var_07);
  }

  param_01 method_805B();
  self.var_232F = common_scripts\utility::func_0FA0(self.var_232F);
  if(self.var_232F.size >= level.var_6092) {
    func_2D37(self.var_232F[0]);
  }

  self.var_232F[self.var_232F.size] = param_01;
  param_01.var_0117 = self;
  param_01 setotherent(self);
  param_01.var_01A7 = self.var_01A7;
  param_01.var_A9E0 = var_02;
  param_01.var_9D65 = spawn("script_origin", param_01.var_0116);
  param_01.var_9D65.var_0117 = param_01;
  param_01.var_94B9 = 0;
  param_01 func_5FB8();
  level.var_61ED[level.var_61ED.size] = param_01;
  param_01 thread func_1DF0();
  param_01 thread func_1DF5();
  param_01 thread func_1DF6();
  param_01 thread func_2334();
  param_01 thread func_3800(self, 1);
  param_01 thread func_86CA(self.var_012C["team"]);
  self.var_20CC = undefined;
}

func_37F9(param_00) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self endon("change_owner");
  self.var_9D65 setcursorhint("HINT_NOICON");
  if(self.var_A9E0 == "c4_mp" || self.var_A9E0 == "c4_zm") {
    self.var_9D65 sethintstring(&"MP_PICKUP_C4");
  } else if(self.var_A9E0 == "claymore_mp") {
    self.var_9D65 sethintstring(&"MP_PICKUP_CLAYMORE");
  } else if(self.var_A9E0 == "bouncingbetty_mp" || self.var_A9E0 == "bouncingbetty_zm") {
    self.var_9D65 sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
  } else if(self.var_A9E0 == "s2_tactical_insertion_device_mp") {
    self.var_9D65 sethintstring(&"MP_PICKUP_TI");
  } else if(self.var_A9E0 == "s2_tactical_insertion_cavalry_mp") {
    self.var_9D65 sethintstring(&"DIVISIONS_DLC4_INSERTION_FLARE_PICKUP");
  }

  self.var_9D65 maps\mp\_utility::func_871E(param_00);
}

func_37F7(param_00) {
  self.var_9D65 sethintstring("");
  self.var_9D65 maps\mp\_utility::func_871D();
}

func_37FF(param_00) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  param_00 endon("disconnect");
  param_00 endon("death");
  var_01 = 1;
  for(;;) {
    if(param_00 getweaponammostock(self.var_A9E0) < weaponmaxammo(self.var_A9E0)) {
      if(!var_01) {
        func_37F9(param_00);
        var_01 = 1;
      }
    } else if(var_01) {
      func_37F7(param_00);
      var_01 = 0;
    }

    wait 0.05;
  }
}

func_3800(param_00, param_01) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self.var_9D65 setcursorhint("HINT_NOICON");
  func_37F9(param_00);
  self.var_9D65 thread maps\mp\_utility::func_A18D(param_00);
  if(isDefined(param_01) && param_01) {
    thread func_A184();
  }

  for(;;) {
    thread func_37FF(param_00);
    self.var_9D65 waittill("trigger", param_00);
    var_02 = param_00 getweaponammostock(self.var_A9E0);
    if(var_02 < weaponmaxammo(self.var_A9E0)) {
      param_00 method_8615("scavenger_pack_pickup");
      param_00 setweaponammostock(self.var_A9E0, var_02 + 1);
      if(isDefined(self.var_5A2C)) {
        self.var_5A2C delete();
      }

      self.var_9D65 delete();
      if(self.var_A9E0 == "s2_tactical_insertion_cavalry_mp") {
        param_00.var_6E6C = 0;
        maps\mp\perks\_perkfunctions::func_2D54(self);
      } else {
        self delete();
      }

      self notify("death");
    }
  }
}

watchforwater() {
  for(;;) {
    foreach(var_01 in level.var_A964) {
      if(var_01 istouching(self)) {
        self setmissileisdud(1);
        self notify("dud");
      }
    }

    wait 0.05;
  }
}

func_4AFE(param_00, param_01) {
  param_00 endon("disconnect");
  self endon("death");
  self endon("dud");
  self endon("entitydeleted");
  if(isDefined(level.var_A964)) {
    childthread watchforwater();
  }

  var_02 = spawnStruct();
  if(param_01 == "killstreak_molotov_cocktail_mp" || param_01 == "killstreak_molotov_cocktail_grenadier_mp") {
    var_02.var_50B0 = 125;
    var_02.var_50B9 = 100;
    var_02.var_3BB5 = 20;
    var_02.var_3BCB = 152;
    var_02.var_3BC1 = 152;
    var_02.var_3BC8 = 10;
    var_02.var_3BD2 = 0.4;
  } else {
    var_02.var_50B0 = 85;
    var_02.var_50B9 = 72;
    var_02.var_3BB5 = 18;
    var_02.var_3BCB = 152;
    var_02.var_3BC1 = 152;
    var_02.var_3BC8 = 10;
    var_02.var_3BD2 = 0.4;
  }

  self waittill("explode", var_03);
  if(function_0030(self)) {
    return;
  }

  var_02.var_5E55 = var_03;
  thread func_995B(param_00, var_02.var_5E55, var_02.var_50B0, var_02.var_50B9, var_02.var_3BC1, param_01);
  lib_0380::func_6842("mp_ks_molotov_exp_shatter", undefined, self.var_0116);
  thread func_9962(param_00, var_02, param_01);
}

func_9962(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disconnect");
  self endon("death");
  self endon("entitydeleted");
  wait(0.3);
  var_03 = self.var_0116;
  var_04 = lib_0380::func_6842("mp_ks_molotov_fire_loop", undefined, var_03, 1);
  var_05 = 0;
  while(var_05 < param_01.var_3BC8) {
    var_05++;
    func_995B(param_00, param_01.var_5E55, param_01.var_3BB5, param_01.var_3BCB, param_01.var_3BC1, param_02);
    wait(param_01.var_3BD2);
  }

  lib_0380::func_6842("mp_ks_molotov_fire_stop", undefined, var_03);
  lib_0380::func_6850(var_04, 3);
}

thermite_damage_character(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_00.var_A019)) {
    if(func_746F(param_00.var_0116, param_02, param_04, param_05)) {
      if(func_740F(param_00, param_02)) {
        param_00 dodamage(param_03, param_02, param_01, self, "MOD_BURNED", param_06);
        return;
      }
    }
  }
}

func_995B(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in level.var_744A) {
    thermite_damage_character(var_07, param_00, param_01, param_02, param_03, param_04, param_05);
  }

  var_09 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_0B in var_09) {
    thermite_damage_character(var_0B, param_00, param_01, param_02, param_03, param_04, param_05);
  }
}

func_746F(param_00, param_01, param_02, param_03) {
  if(param_00[2] - param_01[2] > param_03) {
    return 0;
  }

  return distance2dsquared(param_00, param_01) < param_02 * param_02;
}

func_4A66(param_00, param_01) {
  param_00 endon("disconnect");
  self endon("make_dud");
  self endon("death");
  self waittill("explode", var_02);
  var_03 = spawnStruct();
  var_03.var_6C2C = var_02;
  var_03.var_014F = 150;
  if(isDefined(param_00) && param_00 maps\mp\_utility::func_0649("specialty_improvedtacticals")) {
    var_03.var_688C = 8;
    var_03.var_99EB = 0.625;
    var_03.var_2994 = 5;
  } else {
    var_03.var_688C = 5;
    var_03.var_99EB = 1;
    var_03.var_2994 = 1;
  }

  thread func_9595(var_03, param_00, param_01);
}

func_9595(param_00, param_01, param_02) {
  level endon("game_ended");
  param_01 endon("disconnect");
  self endon("death");
  var_03 = 0;
  while(var_03 < param_00.var_688C) {
    var_03++;
    foreach(var_05 in level.var_744A) {
      if(function_0367()) {
        if(!isonevonedamage(param_01, var_05)) {
          continue;
        }
      } else if(var_05 != param_01 && level.var_984D && var_05.var_01A7 == param_01.var_01A7) {
        continue;
      }

      if(func_746D(var_05.var_0116, param_00.var_6C2C, param_00.var_014F)) {
        if(func_740F(var_05, param_00.var_6C2C)) {
          var_05 dodamage(param_00.var_2994, param_00.var_6C2C, param_01, self, "MOD_GAS", param_02, "none");
        }
      }
    }

    wait(param_00.var_99EB);
  }
}

func_746D(param_00, param_01, param_02) {
  return distancesquared(param_00, param_01) < param_02 * param_02;
}

func_740F(param_00, param_01) {
  if(param_00.var_0116[2] <= param_01[2]) {
    return bullettracepassed(param_00.var_0116 + (0, 0, 10), (param_00.var_0116[0], param_00.var_0116[1], param_01[2] + 10), 0, param_00) && bullettracepassed(param_01 + (0, 0, 10), (param_00.var_0116[0], param_00.var_0116[1], param_01[2] + 10), 0, param_00);
  }

  return bullettracepassed(param_01 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_0116[2] + 10), 0, param_00) && bullettracepassed(param_00.var_0116 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_0116[2] + 10), 0, param_00);
}

func_4AF3(param_00, param_01) {
  param_00 endon("disconnect");
  self endon("make_dud");
  self endon("death");
  common_scripts\utility::func_A63E(0.65, "missile_stuck");
  if(!isDefined(self)) {
    return;
  }

  var_02 = spawnStruct();
  var_02.var_3D33 = 1750;
  var_02.var_3D37 = 65536;
  var_02.var_3F83 = common_scripts\utility::func_8FFC();
  var_02.var_3F83 method_8449(self);
  var_02.var_3F83 method_805B();
  var_02.var_3F71 = maps\mp\_utility::func_9028(common_scripts\utility::func_44F5("signal_flare_friendly_tacmask"), param_00, param_00.var_01A7, 1, var_02.var_3F83, "TAG_ORIGIN");
  var_02.var_3F82 = common_scripts\utility::func_8FFC();
  var_02.var_3F82 method_8449(self);
  var_02.var_3F82 method_805B();
  var_02.var_3F6D = maps\mp\_utility::func_9028(common_scripts\utility::func_44F5("signal_flare"), param_00, maps\mp\_utility::func_45DE(param_00.var_01A7), 0, var_02.var_3F82, "TAG_ORIGIN");
  thread func_8C50(var_02);
  while(isDefined(self)) {
    foreach(var_04 in level.var_744A) {
      if(!maps\mp\_utility::func_57A0(var_04)) {
        continue;
      }

      if(function_0367()) {
        if(!isonevonedamage(param_00, var_04)) {
          continue;
        }
      } else if(var_04 != param_00 && level.var_984D && var_04.var_01A7 == param_00.var_01A7) {
        continue;
      }

      if(!isDefined(var_04.var_99F0) || var_04.var_99F0 + var_02.var_3D33 <= gettime()) {
        if(distancesquared(var_04.var_0116, self.var_0116) < var_02.var_3D37) {
          if(self method_81D8(var_04 getEye(), var_04) > 0.5) {
            var_05 = anglesToForward(var_04 getangles());
            var_06 = var_04 getEye();
            var_07 = self.var_0116 + (0, 0, 10);
            var_08 = vectornormalize(var_07 - var_06);
            var_09 = vectordot(var_05, var_08);
            if(var_09 > 0.55) {
              var_04 dodamage(1, self.var_0116, param_00, self, "MOD_GRENADE_SPLASH", param_01);
              var_0A = var_04 maps\mp\_utility::func_0649("specialty_stun_resistance");
              if(!var_0A && !common_scripts\utility::func_562E(var_04.var_4B97)) {
                var_04 thread maps\mp\_utility::func_5D22("flashed", 0.1, 1.55, 0.1);
                var_04.var_3D39 = gettime() + var_02.var_3D33;
              }

              var_04.var_99F0 = gettime();
            }
          }
        }
      }
    }

    wait(0.2);
  }
}

func_8C50(param_00) {
  self waittill("death");
  if(isDefined(param_00.var_3F83)) {
    param_00.var_3F83 delete();
  }

  if(isDefined(param_00.var_3F71)) {
    param_00.var_3F71 delete();
  }

  if(isDefined(param_00.var_3F82)) {
    param_00.var_3F82 delete();
  }

  if(isDefined(param_00.var_3F6D)) {
    param_00.var_3F6D delete();
  }
}

func_4AF9(param_00, param_01) {
  if(param_01 == "s2_tactical_insertion_device_mp" || param_01 == "s2_tactical_insertion_cavalry_mp") {
    var_02 = param_01 == "s2_tactical_insertion_cavalry_mp";
    if(var_02 && isDefined(self.var_6E6B) && self.var_6E6B && isDefined(self.var_6E6D) && param_00 == self.var_6E6D) {
      return;
    }

    param_00 method_805C();
    if(!isalive(self)) {
      if(isDefined(param_00)) {
        param_00 delete();
      }

      return;
    }

    if(var_02) {
      if(maps\mp\_utility::func_579B()) {
        switch (maps\mp\_utility::func_4571()) {
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
          case "mp_raid_dlc3":
          case "mp_raid_dlc2":
          default:
            self.playerparachutedropheight = 1600;
            break;
        }
      } else {
        self.playerparachutedropheight = 2700;
      }
    }

    var_03 = func_3B9A(var_02);
    var_04 = self.var_001D;
    if(!self isonground() || (!isDefined(var_03) && !common_scripts\utility::func_562E(param_00.isplayersteerable)) || isDefined(self.var_1B67) && self.var_1B67) {
      if(var_02) {
        if(isDefined(self.var_1B67) && self.var_1B67) {
          self iclientprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_WARBOUNDARY");
        } else if(!self isonground()) {
          self iclientprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_MIDAIR");
        } else {
          self iclientprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID");
        }
      } else {
        self iclientprintlnbold(&"WEAPON_MTX5_TAC_INSERT_INVALID");
      }

      var_05 = self getweaponammostock(param_01);
      if(var_05 < weaponmaxammo(param_01)) {
        self setweaponammostock(param_01, var_05 + 1);
      }

      if(isDefined(param_00)) {
        param_00 delete();
      }

      return;
    }

    maps\mp\gametypes\_gamelogic::func_869D(self, 1);
    param_00 thread func_9A29(self, var_03, var_04, param_01);
  }
}

isvalidraidtinode(param_00) {
  if(isDefined(level.var_79C2) && isDefined(level.var_79C2.var_4C32)) {
    var_01 = 24025;
    foreach(var_03 in level.var_79C2.var_4C32) {
      if(isDefined(var_03.var_9D65) && distance2dsquared(param_00.var_0116, var_03.var_9D65.var_0116) < var_01) {
        return 0;
      }
    }
  }

  return 1;
}

func_3B9A(param_00) {
  var_01 = getnodesinradiussorted(self.var_0116, 156, 0, 64);
  var_02 = undefined;
  foreach(var_04 in var_01) {
    if(isDefined(var_04) && !param_00 || nodeexposedtosky(var_04, 1)) {
      if(!param_00 || capsuletracepassed(var_04.var_0116 + (0, 0, 48), 32, self.playerparachutedropheight, self, 0, 0, 1)) {
        if(maps\mp\_utility::func_579B() && !isvalidraidtinode(var_04)) {
          continue;
        }

        var_05 = var_04.var_0116 + (0, 0, 10);
        if(bullettracepassed(self getEye(), var_05, 0, self)) {
          if(canspawn(var_05) && self isonground()) {
            var_02 = var_05;
            break;
          }
        }
      }
    }
  }

  return var_02;
}

func_9A29(param_00, param_01, param_02, param_03) {
  self.var_0117 = param_00;
  self waittill("missile_stuck");
  self method_805B();
  if(!isDefined(param_00)) {
    return;
  }

  func_8A4A(param_00, param_01, param_02, param_03);
  self.var_9D65 = spawn("script_origin", self.var_0116 + (0, 0, 25));
  self.var_9D65.var_0117 = self;
  self.var_9D65 linkto(self);
  if(param_03 == "s2_tactical_insertion_cavalry_mp") {
    param_00 thread func_A931();
    thread func_3800(param_00, 0);
    func_37F9(param_00);
    self.var_3773 = spawn("script_origin", self.var_0116 + (0, 0, 25));
    self.var_3773 linkto(self);
    self.var_3773.var_0117 = self;
    thread maps\mp\perks\_perkfunctions::func_47EA(param_00);
  }

  param_00 thread func_61FE(self);
  param_00 thread func_61FD(self);
  self notify("tactical_insertion_activated");
}

func_8A4A(param_00, param_01, param_02, param_03) {
  if(param_03 == "s2_tactical_insertion_cavalry_mp") {
    var_04 = bulletTrace(param_01 + (0, 0, 50), param_01 - (0, 0, 400), 0, self);
    var_05 = var_04["position"] + (0, 0, 1);
    self.var_0116 = var_05;
  }

  self.var_94B9 = 0;
  self setotherent(param_00);
  self.var_A9E0 = param_03;
  self.var_7464 = param_01;
  self.playerspawnangles = param_02;
  self method_861D("tac_insert_spark_lp");
  param_00.var_872A = self;
  thread func_95A0(param_03 == "s2_tactical_insertion_cavalry_mp", 0);
  thread func_99C2();
  param_00 thread func_9A30(self);
  thread tiwatchraidsboundarychange(param_00);
  func_5FB8(1);
}

func_95A0(param_00, param_01) {
  self endon("change_owner");
  if(isDefined(param_00) && param_00) {
    if(isDefined(param_01) && param_01) {
      self.var_359B["friendly"] = spawnfx(common_scripts\utility::func_44F5("tactical_insertion_cavalry_ally_parachuting"), self gettagorigin("tag_fx"));
      self.var_359B["enemy"] = spawnfx(common_scripts\utility::func_44F5("tactical_insertion_cavalry_enemy_parachuting"), self gettagorigin("tag_fx"));
    } else {
      self.var_359B["friendly"] = spawnfx(common_scripts\utility::func_44F5("tactical_insertion_cavalry_ally"), self gettagorigin("tag_fx"));
      self.var_359B["enemy"] = spawnfx(common_scripts\utility::func_44F5("tactical_insertion_cavalry_enemy"), self gettagorigin("tag_fx"));
    }
  } else {
    self.var_359B["friendly"] = spawnfx(common_scripts\utility::func_44F5("tactical_insertion_beacon_ally"), self gettagorigin("tag_fx"));
    self.var_359B["enemy"] = spawnfx(common_scripts\utility::func_44F5("tactical_insertion_beacon_enemy"), self gettagorigin("tag_fx"));
  }

  thread func_61D1();
}

tiwatchraidsboundarychange(param_00) {
  if(level.var_3FDC != "raid" || !isDefined(level.var_1B69)) {
    return;
  }

  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("raid_boundaries_changed");
    foreach(var_02 in level.var_1B69) {
      if(param_00.var_01A7 != var_02.var_01A7 && var_02.var_931A == "active" || var_02.var_931A == "incoming") {
        if(var_02.var_9D65 method_858B(self.var_7464)) {
          level thread maps\mp\gametypes\_rank::func_1457("tac_insert_destroyed", param_00);
          maps\mp\perks\_perkfunctions::func_2D54(self);
        }
      }
    }
  }
}

func_99C2() {
  self endon("death");
  self setCanDamage(1);
  self.var_00FB = 100000;
  self.var_00BC = self.var_00FB;
  var_00 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isPlayer(var_00) && !function_01EF(var_00)) {
      continue;
    }

    if(!func_3ECD(self.var_0117, var_00)) {
      continue;
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          break;
      }
    }

    break;
  }

  if(isDefined(self.var_0117) && isDefined(self.var_0117.var_6E6B) && self.var_0117.var_6E6B) {
    return;
  }

  if(isDefined(var_08) && var_08 &level.var_5039) {
    self.var_A86F = 1;
  }

  self.var_A86E = 1;
  if(isPlayer(var_00)) {
    var_00 maps\mp\gametypes\_damagefeedback::func_A102("bouncing_betty");
  }

  if(level.var_984D) {
    if(isDefined(var_00) && isDefined(self.var_0117)) {
      var_0A = var_00.var_012C["team"];
      var_0B = self.var_0117.var_012C["team"];
      if(isDefined(var_0A) && isDefined(var_0B) && var_0A != var_0B) {
        var_00 notify("destroyed_explosive");
        level thread maps\mp\gametypes\_rank::func_1457("tac_insert_enemy_destroyed", var_00, var_09);
        level thread maps\mp\gametypes\_rank::func_1457("tac_insert_destroyed", self.var_0117);
        var_00 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
        if(var_00 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
          var_00 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
        }
      }
    }
  } else if(isDefined(self.var_0117) && isDefined(var_00) && var_00 != self.var_0117) {
    var_00 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::func_1457("tac_insert_enemy_destroyed", var_00, var_09);
    level thread maps\mp\gametypes\_rank::func_1457("tac_insert_destroyed", self.var_0117);
    var_00 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
    if(var_00 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
      var_00 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
    }
  }

  playFX(level.var_9062, self.var_0116);
  self.var_0117 thread maps\mp\_utility::func_5C43("ti_destroyed", undefined, undefined, self.var_0116);
  self.var_0117 luinotifyevent(&"tac_insert_destroyed", 0);
  self.var_0117.var_6E6E = 0;
  self.var_0117.var_872A = undefined;
  maps\mp\perks\_perkfunctions::func_2D54(self);
}

func_A6E2(param_00, param_01) {
  param_00 endon("airstrike_complete");
  param_01 thread func_9A25(param_00);
  param_01 thread func_9A24(param_00);
  while(!lib_0527::func_34AE(param_00, param_00.var_34AC, 50)) {
    wait 0.05;
  }

  param_01 thread func_9A23();
  param_01 notify("paratrooperInsertDroppedFromPlane");
}

func_9A25(param_00) {
  self method_808C();
  self setorigin(param_00.var_0116);
  self method_8322();
  self.var_6E6B = 1;
  self playerlinkto(param_00, undefined, 0, 180, 180, 180, 180, 1);
}

func_9A24(param_00) {
  param_00 endon("airstrike_complete");
  param_00 waittill("crashing");
  thread func_5A80();
}

func_5A80() {
  maps\mp\perks\_perkfunctions::func_2D54(self.var_6E6D);
  self dodamage(120, self.var_0116);
}

func_9A30(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  self waittill("spawned_player");
  if(!self.var_99BD) {
    return;
  }

  self.var_6E6F = self.var_0116;
  self.var_6E6D = param_00;
  maps\mp\perks\_perkfunctions::func_2D54(param_00);
}

monitorparatrooperparachutingbeacon(param_00) {
  level endon("game_ended");
  while(isDefined(self) && maps\mp\_utility::func_57A0(self) && isDefined(self.var_6E6B) && self.var_6E6B) {
    wait 0.05;
  }

  maps\mp\perks\_perkfunctions::func_2D54(param_00);
}

func_A931() {
  self endon("disconnect");
  self endon("stop_watchTISpawn");
  self.var_6E6E = 1;
  self.var_6E6C = 1;
  self waittill("spawned_player");
  if(!isDefined(self.var_6E6E) || !self.var_6E6E) {
    return;
  }

  self.var_6E6E = 0;
  if(isDefined(self.var_6E6B) && self.var_6E6B) {
    return;
  }

  self.var_6E6B = 1;
  self.var_6E6F = self.var_0116;
  self.paratrooperinsertgroundposition = self.var_0116;
  self.playerparachutemovementenabled = 0;
  self.playerparachuteweaponsenabled = 1;
  self.playerparachutedamageenabled = 1;
  self.playerparachuteweaponsactiveatcertaindropheight = 400;
  if(maps\mp\_utility::func_579B()) {
    self.playerparachutedropunitsperframeoverride = -16;
    self.playerparachutedropsprintingunitsperframeoverride = -26;
    self.playerparachutedropadsunitsperframeoverride = -12;
    self.playerparachutehealth = 125;
    var_00 = 1;
  } else {
    self.playerparachutedropunitsperframeoverride = -22;
    self.playerparachutedropsprintingunitsperframeoverride = -36;
    self.playerparachutedropadsunitsperframeoverride = -16;
    self.playerparachutehealth = 175;
    var_00 = 0;
  }

  var_01 = magicgrenademanual("s2_tactical_insertion_cavalry_mp", self.var_0116, (0, 0, 0), 400, self, 1);
  var_01.var_0117 = self;
  var_01 thread func_95A0(1, 1);
  self.var_6E6D = var_01;
  thread monitorparatrooperparachutingbeacon(var_01);
  thread maps\mp\killstreaks\_paratroopers::player_paratrooper(self.var_6E6F, undefined, var_00);
  if(maps\mp\_utility::func_579B()) {
    self.var_4B97 = undefined;
    self notify("removed_spawn_protection");
  }
}

func_9A23() {
  self endon("disconnect");
  var_00 = self.var_6E6F;
  self method_8322();
  self.var_6E6B = 1;
  var_01 = magicbullet("tactical_insertion_parachute_mp", self.var_0116, var_00);
  var_02 = spawn("script_model", var_01.var_0116);
  var_02 setModel("tag_origin");
  var_02 method_8449(var_01);
  var_03 = spawn("script_model", var_02.var_0116);
  var_03 method_805C();
  if(self.var_01A7 == "allies") {
    var_03 setModel("usa_carepackage_parachute_anim");
  } else {
    var_03 setModel("ger_carepackage_parachute_anim");
  }

  var_03.var_62A0 = 0.5;
  var_03 scriptmodelplayanim("carepackage_parachute_loop", "finished_ti_paratrooper_insert");
  var_03 method_8449(var_02, "tag_origin", (20, -20, 40), (0, 90, 0));
  var_03 method_805B();
  self.var_001D = var_03 gettagangles("tag_crate");
  self.var_0116 = var_03 gettagorigin("tag_crate");
  self playerlinkto(var_03, "tag_crate", 0, 180, 180, 180, 180, 1);
  self playerparachutesetactive(1);
  var_04 = spawn("script_model", var_03.var_0116);
  var_04.var_001D = var_03.var_001D;
  var_04 setModel("ger_carepackage_parachute");
  var_04 setCanDamage(1);
  var_04 method_805C();
  var_04 method_8449(var_03);
  var_04 thread func_9A20(var_01, self);
  thread func_9A21(var_00);
  thread func_9A22();
  var_01 thread func_9A1F(self, var_02, var_03, var_04);
}

func_9A20(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("paratrooper_released");
  for(;;) {
    self waittill("damage", var_02, var_03);
    if(isDefined(var_03)) {
      if((isDefined(param_01) && (level.var_984D && isDefined(var_03.var_01A7) && var_03.var_01A7 != param_01.var_01A7)) || !level.var_984D && var_03 != param_01) {
        var_03 thread maps\mp\gametypes\_damagefeedback::func_A102("standard");
        param_01 dodamage(var_02, var_03.var_0116, var_03);
        param_01.var_5723 = 1;
        param_00 notify("death");
        param_01 notify("paratrooper_released");
        maps\mp\perks\_perkfunctions::func_2D54(self.var_6E6D);
        return;
      }
    }
  }
}

func_9A22() {
  self endon("disconnect");
  self endon("paratrooper_released");
  self waittill("death");
  maps\mp\perks\_perkfunctions::func_2D54(self.var_6E6D);
}

func_9A21(param_00) {
  self endon("disconnect");
  self endon("death");
  self endon("paratrooper_released");
  for(;;) {
    if(self.var_0116[2] < param_00[2] + 500) {
      break;
    }

    wait(0.1);
  }

  self method_8323();
}

func_9A1F(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  if(param_00 maps\mp\_utility::func_0649("specialty_falldamage")) {
    param_00 maps\mp\_utility::func_0735("specialty_falldamage");
  }

  param_00 maps\mp\_utility::func_47A2("specialty_moreminimap");
  self waittill("death");
  if(isDefined(param_00)) {
    param_00 notify("paratrooper_released");
    param_00 playerparachutesetactive(0);
    param_00 unlink();
    if(!isDefined(param_00.var_5723) || !param_00.var_5723) {
      param_00.var_6E6B = 0;
      if(param_00 maps\mp\_utility::func_0649("specialty_falldamage")) {
        param_00 maps\mp\_utility::func_47A2("specialty_falldamage");
      }

      param_00 maps\mp\_utility::func_0735("specialty_moreminimap");
    }
  }

  param_02 method_8278("carepackage_parachute_detach");
  param_02 common_scripts\utility::func_2CBE(2.7, ::delete);
  param_01 common_scripts\utility::func_2CBE(3, ::delete);
  param_03 delete();
}

func_499D(param_00, param_01) {
  param_00 endon("disconnect");
  self endon("death");
  self waittill("missile_stuck");
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = bulletTrace(self.var_0116 + (0, 0, 4), self.var_0116 - (0, 0, 4), 0, self);
  var_03 = var_02["position"];
  if(var_02["fraction"] == 1) {
    var_03 = getgroundposition(self.var_0116, 12, 0, 32);
    var_02["normal"] = var_02["normal"] * -1;
  }

  var_04 = vectornormalize(var_02["normal"]);
  var_05 = vectortoangles(var_04);
  var_05 = var_05 + (90, 0, 0);
  var_06 = spawn("script_model", var_03);
  var_06.var_001D = var_05;
  var_06 setModel("ger_barbed_wire_pile_02");
  self waittill("explode", var_07);
  maps\mp\_utility::func_74D8("wpn_smoke_grenade_exp", var_07);
  var_08 = spawnStruct();
  var_08.var_2994 = 11;
  var_08.var_6C2C = var_07;
  var_08.var_629C = var_06;
  thread func_158A(var_08, param_00, param_01);
  thread func_158B(var_08, param_00);
  thread func_158C(var_08, param_00);
}

func_158A(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    foreach(var_04 in level.var_744A) {
      if(var_04 != param_01 && level.var_984D && var_04.var_01A7 == param_01.var_01A7) {
        continue;
      }

      if(distancesquared(var_04.var_0116, param_00.var_6C2C) < 14400) {
        var_04 dodamage(param_00.var_2994, param_00.var_6C2C, param_01, self, "MOD_IMPACT", param_02);
      }
    }

    self waittill("explode");
  }
}

func_158B(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  self waittill("death");
  if(isDefined(param_00) && isDefined(param_00.var_629C)) {
    param_00.var_629C delete();
  }
}

func_158C(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  param_01 waittill("disconnect");
  if(isDefined(param_00) && isDefined(param_00.var_629C)) {
    param_00.var_629C delete();
  }
}

func_49C8(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  self.var_2B71 = common_scripts\utility::func_0FA0(self.var_2B71);
  if(self.var_2B71.size >= level.var_6092) {
    self.var_2B71[0] notify("remove");
    self.var_2B71[0] delete();
  }

  self.var_2B71[self.var_2B71.size] = param_00;
  for(;;) {
    param_00 waittill("explode");
    if(!isDefined(param_00.var_3C4C)) {
      param_00.var_3C4C = 1;
      param_00.var_28D3 = maps\mp\gametypes\_gameobjects::func_45A9();
      objective_add(param_00.var_28D3, "invisible", (0, 0, 0));
      objective_position(param_00.var_28D3, param_00.var_0116);
      function_01D1(param_00.var_28D3, "cb_compassping_enemy_objective");
      if(!level.var_984D) {
        objective_playerenemyteam(param_00.var_28D3, self getentitynumber());
      } else {
        objective_team(param_00.var_28D3, level.var_6C63[self.var_01A7]);
      }

      param_00 thread func_2D06(param_00.var_28D3);
    }

    objective_state(param_00.var_28D3, "active");
    wait(2);
    objective_state(param_00.var_28D3, "invisible");
  }
}

func_2D06(param_00) {
  common_scripts\utility::func_A732("death", "remove");
  objective_state(param_00, "active");
  wait(2);
  objective_state(param_00, "invisible");
  maps\mp\_utility::func_068B(param_00);
}

func_A184() {
  self endon("death");
  for(;;) {
    if(isDefined(self) && isDefined(self.var_9D65)) {
      self.var_9D65.var_0116 = self.var_0116;
      if(isDefined(self.var_1907)) {
        self.var_1907.var_0116 = self.var_0116;
      }
    } else {
      return;
    }

    wait 0.05;
  }
}

func_2334() {
  self endon("death");
  self endon("change_owner");
  var_00 = spawn("trigger_radius", self.var_0116 + (0, 0, 0 - level.var_2333), 0, level.var_2333, level.var_2333 * 2);
  thread func_2D40(var_00);
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(self.var_94B9) {
      wait 0.05;
      continue;
    }

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.var_0117)) {
        if(var_01 == self.var_0117) {
          continue;
        }

        if(isDefined(var_01.var_0117) && var_01.var_0117 == self.var_0117) {
          continue;
        }
      }

      if(!func_3ECD(self.var_0117, var_01, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_01 method_81AD()) < 10) {
      continue;
    }

    var_02 = abs(var_01.var_0116[2] - self.var_0116[2]);
    if(var_02 > 128) {
      continue;
    }

    if(!var_01 func_8B85(self)) {
      continue;
    }

    if(var_01 method_81D7(self.var_0116, self) > 0) {
      break;
    }
  }

  self method_8617("claymore_activated");
  var_03 = isPlayer(self.var_0117) && self.var_0117 maps\mp\_utility::func_0649("specialty_shortfuse");
  var_04 = isPlayer(var_01) && var_01 maps\mp\_utility::func_0649("specialty_delaymine");
  if(var_03 && var_04) {
    wait(level.var_2331);
  } else if(var_03) {
    wait(level.shortminetime);
  } else if(var_04) {
    var_01 notify("triggered_claymore");
    wait(level.var_2CE8);
  } else {
    wait(level.var_2331);
  }

  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  if(isDefined(self.var_0117) && isDefined(level.var_5C44)) {
    self.var_0117 thread[[level.var_5C44]]("claymore_destroyed", undefined, undefined, self.var_0116);
  }

  self method_81D6();
}

func_8B85(param_00) {
  if(isDefined(param_00.var_2F74)) {
    return 0;
  }

  var_01 = self.var_0116 + (0, 0, 32);
  var_02 = var_01 - param_00.var_0116;
  var_03 = anglesToForward(param_00.var_001D);
  var_04 = vectordot(var_02, var_03);
  if(var_04 < level.var_2332) {
    return 0;
  }

  var_02 = vectornormalize(var_02);
  var_05 = vectordot(var_02, var_03);
  return var_05 > level.var_2330;
}

func_2D40(param_00) {
  self waittill("death");
  wait 0.05;
  if(isDefined(param_00)) {
    if(isDefined(param_00.var_9D65)) {
      param_00.var_9D65 delete();
    }

    param_00 delete();
  }
}

func_2D37(param_00) {
  if(isDefined(param_00)) {
    if(isDefined(param_00.var_9D65)) {
      param_00.var_9D65 delete();
    }

    param_00 delete();
  }
}

func_A925() {
  self endon("death");
  self endon("disconnect");
  self endon("all_detonated");
  level endon("game_ended");
  self endon("change_owner");
  var_00 = 0;
  for(;;) {
    if(self useButtonPressed()) {
      var_00 = 0;
      while(self useButtonPressed()) {
        var_00 = var_00 + 0.05;
        wait 0.05;
      }

      if(var_00 >= 0.5) {
        continue;
      }

      var_00 = 0;
      while(!self useButtonPressed() && var_00 < 0.35) {
        var_00 = var_00 + 0.05;
        wait 0.05;
      }

      if(var_00 >= 0.35) {
        continue;
      }

      if(!self.var_5FDB.size) {
        return;
      }

      self notify("detonate_double_tap");
    }

    wait 0.05;
  }
}

func_A924() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  for(;;) {
    self waittill("detonate");
    func_5FD9(1);
  }
}

func_A923() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  for(;;) {
    self waittill("detonate_double_tap");
    var_00 = self getcurrentweapon();
    if(!function_027E(var_00)) {
      func_5FD9(2);
    }
  }
}

func_5FD9(param_00) {
  var_01 = 0;
  var_02 = [];
  for(var_03 = 0; var_03 < self.var_5FDB.size; var_03++) {
    if(!self.var_5FDB[var_03][param_00]) {
      var_01 = 1;
      continue;
    }

    var_04 = self.var_5FDB[var_03][0];
    if(isDefined(var_04)) {
      if(var_04.var_94B9) {
        var_01 = 1;
        return;
      }

      if(isDefined(var_04.var_A9E0) && !self getdetonateenabled(var_04.var_A9E0)) {
        var_01 = 1;
        continue;
      }

      if(isDefined(var_04.var_5FDC)) {
        self thread[[var_04.var_5FDC]](var_04);
        continue;
      }

      var_04 thread func_A684(0, param_00);
    }
  }

  if(var_01) {
    self.var_5FDB = func_5FDA(self.var_5FDB);
    return;
  }

  self.var_5FDB = var_02;
  self notify("all_detonated");
}

func_A684(param_00, param_01) {
  self endon("death");
  wait(param_00);
  func_A77C();
  if(param_01 == 2) {
    self method_8520();
  } else {
    self method_81D6();
  }

  level.var_61ED = common_scripts\utility::func_0FA0(level.var_61ED);
}

func_2D2E() {
  self endon("faux_spawn");
  self endon("death");
  self waittill("disconnect");
  var_00 = self.var_5FDB;
  var_01 = self.var_232F;
  wait 0.05;
  if(isDefined(var_00)) {
    for(var_02 = 0; var_02 < var_00.size; var_02++) {
      if(isDefined(var_00[var_02][0])) {
        var_00[var_02][0] delete();
      }
    }
  }

  if(isDefined(var_01)) {
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      if(isDefined(var_01[var_02])) {
        var_01[var_02] delete();
      }
    }
  }
}

func_1DF0() {
  self endon("death");
  self endon("make_dud");
  self setCanDamage(1);
  self.var_00FB = 100000;
  self.var_00BC = self.var_00FB;
  var_00 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isPlayer(var_00) && !function_01EF(var_00)) {
      continue;
    }

    if(!func_3ECD(self.var_0117, var_00)) {
      continue;
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "signal_flare_expeditionary_mp":
        case "signal_flare_mp":
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          break;
      }
    }

    break;
  }

  if(level.var_1DF7) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }

  level.var_1DF7 = 1;
  thread func_7D54();
  if(isDefined(var_04) && issubstr(var_04, "MOD_GRENADE") || issubstr(var_04, "MOD_EXPLOSIVE")) {
    self.var_A86B = 1;
  }

  if(isDefined(var_08) && var_08 &level.var_5039) {
    self.var_A86F = 1;
  }

  self.var_A86E = 1;
  if(isPlayer(var_00)) {
    var_00 maps\mp\gametypes\_damagefeedback::func_A102("c4");
  }

  if(isDefined(var_00) && isDefined(var_00.var_5CC6) && var_00 != self.var_0117) {
    self.var_5CC6 = var_00.var_5CC6;
  }

  if(level.var_984D) {
    if(isDefined(var_00) && isDefined(self.var_0117)) {
      var_0A = var_00.var_012C["team"];
      var_0B = self.var_0117.var_012C["team"];
      if(isDefined(var_0A) && isDefined(var_0B) && var_0A != var_0B) {
        var_00 notify("destroyed_explosive");
        level thread maps\mp\gametypes\_rank::func_1457("equipment_destroyed", var_00, var_09);
        var_00 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
        if(var_00 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
          var_00 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
        }
      }
    }
  } else if(isDefined(self.var_0117) && isDefined(var_00) && var_00 != self.var_0117) {
    var_00 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::func_1457("equipment_destroyed", var_00, var_09);
    var_00 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
    if(var_00 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
      var_00 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
    }
  }

  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  self method_81D6(var_00);
}

func_7D54() {
  wait 0.05;
  level.var_1DF7 = 0;
}

func_8077(param_00, param_01) {
  for(var_02 = 0; var_02 < 60; var_02++) {
    wait 0.05;
  }
}

func_A77C() {
  if(!isDefined(self.var_2F74)) {
    return;
  }

  self waittill("enabled");
}

func_5FB8(param_00) {
  common_scripts\utility::func_5FA9(self.var_0117.var_01A7);
  if(!isDefined(param_00) || !param_00) {
    self makeentitynomeleetarget();
  }

  if(issentient(self)) {
    self setthreatbiasgroup("DogsDontAttack");
  }
}

func_8A08() {
  self.var_1906 = [];
  if(self.var_2E51 && !self.var_1905.size) {
    for(var_00 = 0; var_00 < 4; var_00++) {
      self.var_1905[var_00] = newclienthudelem(self);
      self.var_1905[var_00].var_01D3 = 0;
      self.var_1905[var_00].var_01D7 = 0;
      self.var_1905[var_00].var_01D9 = 0;
      self.var_1905[var_00].var_0018 = 0;
      self.var_1905[var_00].var_001F = 1;
      self.var_1905[var_00] setshader("waypoint_bombsquad", 14, 14);
      self.var_1905[var_00] setwaypoint(0, 0);
      self.var_1905[var_00].var_2E53 = "";
    }

    return;
  }

  if(!self.var_2E51) {
    for(var_00 = 0; var_00 < self.var_1905.size; var_00++) {
      self.var_1905[var_00] destroy();
    }

    self.var_1905 = [];
  }
}

func_8BFE(param_00) {
  var_01 = param_00.var_2E53;
  var_02 = -1;
  for(var_03 = 0; var_03 < 4; var_03++) {
    var_04 = self.var_1905[var_03].var_2E53;
    if(var_04 == var_01) {
      return;
    }

    if(var_04 == "") {
      var_02 = var_03;
    }
  }

  if(var_02 < 0) {
    return;
  }

  self.var_1906[var_01] = 1;
  self.var_1905[var_02].var_01D3 = param_00.var_0116[0];
  self.var_1905[var_02].var_01D7 = param_00.var_0116[1];
  self.var_1905[var_02].var_01D9 = param_00.var_0116[2] + 24 + 128;
  self.var_1905[var_02] fadeovertime(0.25);
  self.var_1905[var_02].var_0018 = 1;
  self.var_1905[var_02].var_2E53 = param_00.var_2E53;
  while(isalive(self) && isDefined(param_00) && self istouching(param_00)) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }

  self.var_1905[var_02].var_2E53 = "";
  self.var_1905[var_02] fadeovertime(0.25);
  self.var_1905[var_02].var_0018 = 0;
  self.var_1906[var_01] = undefined;
}

func_4486(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_05 = param_01 * param_01;
  var_06 = level.var_744A;
  for(var_07 = 0; var_07 < var_06.size; var_07++) {
    if(!isalive(var_06[var_07]) || var_06[var_07].var_0178 != "playing") {
      continue;
    }

    var_08 = maps\mp\_utility::func_413B(var_06[var_07]);
    var_09 = distancesquared(param_00, var_08);
    if(var_09 < var_05 && !param_02 || func_A9C3(param_00, var_08, param_03, var_06[var_07])) {
      var_04[var_04.size] = maps\mp\_utility::func_413A(var_06[var_07], var_08);
    }
  }

  var_0A = getEntArray("grenade", "classname");
  for(var_07 = 0; var_07 < var_0A.size; var_07++) {
    var_0B = maps\mp\_utility::func_4138(var_0A[var_07]);
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_A9C3(param_00, var_0B, param_03, var_0A[var_07])) {
      var_04[var_04.size] = maps\mp\_utility::func_4137(var_0A[var_07], var_0B);
    }
  }

  var_0C = getEntArray("destructible", "targetname");
  for(var_07 = 0; var_07 < var_0C.size; var_07++) {
    var_0B = var_0C[var_07].var_0116;
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_A9C3(param_00, var_0B, param_03, var_0C[var_07])) {
      var_0D = spawnStruct();
      var_0D.var_5779 = 0;
      var_0D.var_5662 = 0;
      var_0D.var_008E = var_0C[var_07];
      var_0D.var_29B6 = var_0B;
      var_04[var_04.size] = var_0D;
    }
  }

  var_0E = getEntArray("destructable", "targetname");
  for(var_07 = 0; var_07 < var_0E.size; var_07++) {
    var_0B = var_0E[var_07].var_0116;
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_A9C3(param_00, var_0B, param_03, var_0E[var_07])) {
      var_0D = spawnStruct();
      var_0D.var_5779 = 0;
      var_0D.var_5662 = 1;
      var_0D.var_008E = var_0E[var_07];
      var_0D.var_29B6 = var_0B;
      var_04[var_04.size] = var_0D;
    }
  }

  var_0F = getEntArray("misc_turret", "classname");
  foreach(var_11 in var_0F) {
    var_0B = var_11.var_0116 + (0, 0, 32);
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_A9C3(param_00, var_0B, param_03, var_11)) {
      switch (var_11.var_0106) {
        case "vehicle_ugv_talon_gun_cloaked_mp":
        case "vehicle_ugv_talon_gun_mp":
        case "mp_remote_turret":
        case "mp_scramble_turret":
        case "sentry_minigun_weak":
          var_04[var_04.size] = maps\mp\_utility::func_413C(var_11, var_0B);
          break;
      }
    }
  }

  var_13 = getEntArray("script_model", "classname");
  foreach(var_15 in var_13) {
    if(var_15.var_0106 != "npc_ger_smi44_bouncing_betty" && var_15.var_0106 != "ims_scorpion_body") {
      continue;
    }

    var_0B = var_15.var_0116 + (0, 0, 32);
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_A9C3(param_00, var_0B, param_03, var_15)) {
      var_04[var_04.size] = maps\mp\_utility::func_4139(var_15, var_0B);
    }
  }

  return var_04;
}

func_44B3(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_05 = getEntArray("grenade", "classname");
  foreach(var_07 in var_05) {
    var_08 = var_07.var_0116;
    var_09 = distance(param_00, var_08);
    if(var_09 < param_01 && !param_02 || func_A9C3(param_00, var_08, param_03, var_07)) {
      var_04[var_04.size] = var_07;
    }
  }

  var_0B = getEntArray("misc_turret", "classname");
  foreach(var_0D in var_0B) {
    var_08 = var_0D.var_0116;
    var_09 = distance(param_00, var_08);
    if(var_09 < param_01 && !param_02 || func_A9C3(param_00, var_08, param_03, var_0D)) {
      var_04[var_04.size] = var_0D;
    }
  }

  return var_04;
}

func_A9C3(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = param_01 - param_00;
  if(lengthsquared(var_05) < param_02 * param_02) {
    return 1;
  }

  var_06 = vectornormalize(var_05);
  var_04 = param_00 + (var_06[0] * param_02, var_06[1] * param_02, var_06[2] * param_02);
  var_07 = bulletTrace(var_04, param_01, 0, param_03);
  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread func_2B5B(param_00, ".dmg");
    if(isDefined(param_03)) {
      thread func_2B5B(param_01, "." + param_03.var_003A);
    } else {
      thread func_2B5B(param_01, ".undefined");
    }

    if(var_07["fraction"] == 1) {
      thread func_2B57(var_04, param_01, (1, 1, 1));
    } else {
      thread func_2B57(var_04, var_07["position"], (1, 0.9, 0.8));
      thread func_2B57(var_07["position"], param_01, (1, 0.4, 0.3));
    }
  }

  return var_07["fraction"] == 1;
}

func_29C0(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(self.var_5779) {
    self.var_29D2 = param_05;
    self.var_008E thread[[level.var_1E78]](param_00, param_01, param_02, 0, param_03, param_04, param_05, param_06, "none", 0);
    return;
  }

  if(self.var_5662 && param_04 == "artillery_mp" || param_04 == "claymore_mp" || param_04 == "airstrike_bomb_mp" || param_04 == "airstrike_bomb_axis_mp" || param_04 == "firebomb_bomb_mp" || param_04 == "firebomb_bomb_axis_mp" || param_04 == "firebomb_bomb_grenadier_mp" || param_04 == "firebomb_bomb_axis_grenadier_mp") {
    return;
  }

  self.var_008E notify("damage", param_02, param_01, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, param_04);
}

func_2B57(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 600;
  }
}

func_2B4D(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = 16;
  }

  var_05 = 360 / param_03;
  var_06 = [];
  for(var_07 = 0; var_07 < param_03; var_07++) {
    var_08 = var_05 * var_07;
    var_09 = cos(var_08) * param_01;
    var_0A = sin(var_08) * param_01;
    var_0B = param_00[0] + var_09;
    var_0C = param_00[1] + var_0A;
    var_0D = param_00[2];
    var_06[var_06.size] = (var_0B, var_0C, var_0D);
  }

  for(var_07 = 0; var_07 < var_06.size; var_07++) {
    var_0E = var_06[var_07];
    if(var_07 + 1 >= var_06.size) {
      var_0F = var_06[0];
    } else {
      var_0F = var_06[var_07 + 1];
    }

    thread func_2B57(var_0E, var_0F, param_02, param_04);
  }
}

func_2B5B(param_00, param_01) {
  for(var_02 = 0; var_02 < 600; var_02++) {
    wait 0.05;
  }
}

func_6BCD(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  var_05 = 700;
  var_06 = 25;
  var_07 = var_05 * var_05;
  var_08 = var_06 * var_06;
  var_09 = 60;
  var_0A = 40;
  var_0B = 11;
  if(issubstr(param_01, "_uts19_")) {
    thread func_A263(param_00);
    return;
  }

  switch (param_01) {
    case "stun_grenade_mp":
    case "concussion_grenade_mp":
      var_0C = 512;
      if(isDefined(param_04) && param_04 maps\mp\_utility::func_0649("specialty_improvedtacticals")) {
        var_0D = 2.5;
        var_0E = 4.25;
      } else {
        var_0D = 1.75;
        var_0E = 3.5;
      }

      func_2578(self, param_00, param_04, param_02, var_0C, var_0D, var_0E);
      break;

    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
      break;

    case "flash_grenade_mp":
      func_3D43(self, param_01.var_0116, var_05);
      break;

    case "weapon_cobra_mk19_mp":
      break;

    case "role_barbed_wire_mp":
    case "tabun_grenade_mp":
      if(!maps\mp\_utility::func_0649("specialty_stun_resistance") && !common_scripts\utility::func_562E(self.var_4B97)) {
        self shellshock("mp_radiation_med", 1);
        self.var_3FE5 = gettime() + 1000;
      }
      break;

    case "teslagunmtx_mp":
      var_0C = 200;
      var_0D = 0.2;
      var_0E = 2;
      if(self == param_04) {
        var_0C = var_0C * 0.5;
      }

      func_2578(self, param_00, param_04, param_02, var_0C, var_0D, var_0E);
      break;

    default:
      maps\mp\gametypes\_shellshock::func_8AF0(param_02, param_03);
      break;
  }
}

func_A263(param_00) {
  if(getdvarint("scr_game_uts19_shock", 0) == 0) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  var_01 = 0.45;
  var_02 = 1.2;
  var_03 = 250;
  var_04 = 700;
  var_05 = distance(self.var_0116, param_00.var_0116) - var_03 / var_04 - var_03;
  var_06 = 1 - var_05;
  var_06 = clamp(var_06, 0, 1);
  var_07 = var_01 + var_02 - var_01 * var_06;
  if(isDefined(self.var_A264)) {
    if(self.var_A264 >= var_07) {
      return;
    }
  }

  self.var_A264 = var_07;
  self shellshock("uts19_mp", var_07);
  waittillframeend;
  if(isDefined(self)) {
    self.var_A264 = undefined;
  }
}

func_5795(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(function_01D4(param_00) != "primary") {
    return 0;
  }

  switch (function_01AA(param_00)) {
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

func_57F6(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  switch (param_00) {
    case "signal_flare_expeditionary_mp":
    case "signal_flare_mp":
    case "decoy_device_mp":
    case "tabun_grenade_mp":
    case "stun_grenade_mp":
    case "flash_grenade_mp":
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
      return 1;

    default:
      return 0;
  }
}

func_5747(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  switch (param_00) {
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

func_5756(param_00) {
  if(function_01A9(param_00) == "melee") {
    return 1;
  }

  return 0;
}

func_5696(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  switch (maps\mp\_utility::func_472A(param_00)) {
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

func_5684(param_00) {
  return 0;
}

func_5735(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return function_01D4(param_00) == "item";
}

func_57AE(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return function_01A9(param_00) == "riotshield";
}

func_5762(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return function_01D4(param_00) == "offhand";
}

func_57CD(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(function_01D4(param_00) != "primary") {
    return 0;
  }

  return function_01AA(param_00) == "pistol";
}

func_5707(param_00) {
  var_01 = function_01AA(param_00);
  var_02 = function_01D4(param_00);
  if(var_01 != "grenade") {
    return 0;
  }

  if(var_02 != "offhand") {
    return 0;
  }

  return 1;
}

func_582E(param_00) {
  if(!isDefined(param_00) || param_00 == "none") {
    return 0;
  }

  var_01 = function_01D4(param_00);
  return var_01 == "primary" || var_01 == "altmode";
}

func_534B() {
  self.var_2953 = self.var_2954;
  self.var_8061 = self.var_2953;
  func_8A68(self.var_2953);
}

func_A15E(param_00) {
  func_A196();
  func_8A68(param_00);
  if(func_5831(param_00)) {
    func_A13B();
  }

  self.var_8061 = self.var_2953;
  if(func_582E(param_00)) {
    self.var_2953 = param_00;
  }
}

func_A196() {
  if(isDefined(self.var_A9F7) && isDefined(self.var_A9F6)) {
    var_00 = int(gettime() - self.var_A9F7 / 1000);
    thread func_8A67(self.var_A9F6, var_00, "timeInUse");
  }
}

func_8A68(param_00) {
  self.var_A9F6 = param_00;
  self.var_A9F7 = gettime();
}

func_5831(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(func_582E(param_00)) {
    return 1;
  }

  var_01 = function_01AA(param_00);
  if(var_01 == "ball") {
    return 1;
  }

  return 0;
}

func_A13B() {
  var_00 = level.var_162E;
  if(isDefined(level.gametypemovespeedscalefunc)) {
    var_00 = var_00 * self[[level.gametypemovespeedscalefunc]]();
  }

  if(isDefined(self.var_5525) && self.var_5525) {
    var_00 = var_00 * self.watermovespeedscale;
  }

  if(isDefined(self.agentspeedscale)) {
    var_00 = var_00 * self.agentspeedscale;
  }

  if(isDefined(self.zombietrainingmovespeedscale)) {
    var_00 = var_00 * self.zombietrainingmovespeedscale;
  }

  if(isDefined(self.var_1649) && self.var_1649 > 0) {
    var_00 = var_00 * level.battlecrymovespeedscale;
  }

  if(isDefined(self.var_53C5) && self.var_53C5) {
    var_00 = var_00 * level.raidtriggermovespeedscale;
  }

  if(isDefined(self.var_4B9A) && self.var_4B9A) {
    var_00 = var_00 * level.steelbibmovespeedscale;
  }

  if(isDefined(self.var_4B66) && self.var_4B66) {
    var_00 = var_00 * level.extremeconditioningmovespeedscale;
  }

  if(isDefined(self.var_4B64) && self.var_4B64) {
    var_00 = var_00 * level.doronvestmovespeedscale;
  }

  if(isDefined(self.var_4B50) && self.var_4B50) {
    var_00 = var_00 * level.adrenalineshotmovespeedscale;
  }

  if(isDefined(self.var_5720) && self.var_5720) {
    var_00 = var_00 * level.fightorflightmovespeedscale;
  }

  if(maps\mp\_utility::func_0649("specialty_crouchmovement") && self getstance() == "crouch") {
    var_00 = var_00 * level.crouchperkmovespeedscale;
  }

  if(isDefined(self.var_165B) && self.var_165B) {
    if(isDefined(self.shieldchargeactive) && self.shieldchargeactive) {
      var_00 = var_00 * level.shieldchargemovespeedscale;
    } else {
      var_00 = var_00 * level.bayonetchargemovespeedscale;
    }
  }

  if(maps\mp\_utility::func_0649("specialty_sprintfasterovertime") && isDefined(self.sprintfasterovertimemovespeedscale)) {
    var_00 = var_00 * self.sprintfasterovertimemovespeedscale;
  }

  if(isDefined(self.raidmaniac) && self.raidmaniac) {
    var_00 = var_00 * level.raidmaniacmovespeedscale;
  }

  if(isDefined(self.raidcombatbuff) && self.raidcombatbuff) {
    var_00 = var_00 * level.raidcombatbuffmovespeedscale;
  }

  if(maps\mp\_utility::func_0649("specialty_sessionProgressionB") && isDefined(self.var_012C["sessionProgressionB_Modifier"])) {
    var_00 = var_00 * maps\mp\perks\_perkfunctions::getgrenadiermodvalue_b();
  }

  if(isDefined(level.gametypemovespeedmaxscalar)) {
    var_00 = min(var_00, level.gametypemovespeedmaxscalar);
  }

  self method_81E1(var_00);
}

func_9161() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");
  for(;;) {
    common_scripts\utility::func_A70A("adjustedStance", "sprint_begin", "weapon_change");
    wait(0.5);
    self.var_915E = self getstance();
    if(self.var_915E == "prone") {
      var_00 = self getcurrentprimaryweapon();
      var_01 = maps\mp\_utility::func_472A(var_00);
      if(var_01 == "weapon_lmg") {
        maps\mp\_utility::func_870F(0, 40);
      } else if(var_01 == "weapon_sniper") {
        maps\mp\_utility::func_870F(0, 60);
      } else {
        maps\mp\_utility::func_870F();
      }

      continue;
    }

    if(self.var_915E == "crouch") {
      var_00 = self getcurrentprimaryweapon();
      var_01 = maps\mp\_utility::func_472A(var_01);
      if(var_01 == "weapon_lmg") {
        maps\mp\_utility::func_870F(0, 10);
      } else if(var_01 == "weapon_sniper") {
        maps\mp\_utility::func_870F(0, 30);
      } else {
        maps\mp\_utility::func_870F();
      }

      continue;
    }

    maps\mp\_utility::func_870F();
  }
}

func_1D65() {}

func_57C3(param_00) {
  if(!isDefined(param_00.var_A9E0)) {
    return 0;
  }

  if(!issubstr(param_00.var_A9E0, "semtex")) {
    return 0;
  }

  return 1;
}

func_9304(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!func_57C3(param_00)) {
    return;
  }

  param_00 thread func_63DE();
}

func_63DE() {
  self.var_0117 endon("disconnect");
  self.var_0117 endon("death");
  self.var_0117 endon("faux_spawn");
  self endon("death");
  self waittill("missile_stuck", var_00);
  thread func_93A1("detonate");
  playFX(common_scripts\utility::func_44F5("sticky_grenade_splat"), self.var_0116, anglesToForward(self.var_001D + (0, 180, 0)));
  if(!isPlayer(var_00)) {
    return;
  }

  if(self.var_0117 func_57E7(var_00)) {
    self.var_0117.var_57E6 = "friendly";
    return;
  }

  self.var_57E6 = "enemy";
  self.var_9488 = var_00;
  if(!isDefined(self.var_0117.stuckenemy)) {
    self.var_0117.stuckenemy = 0;
  }

  self.var_0117.stuckenemy++;
  self.var_0117 maps\mp\_events::func_83CD(var_00);
  self.var_0117 notify("process", "ch_bullseye");
}

func_57E7(param_00) {
  return level.var_984D && isDefined(param_00.var_01A7) && param_00.var_01A7 == self.var_01A7;
}

func_9F3A() {
  if(maps\mp\_utility::isprophuntgametype()) {
    self delete();
    return;
  }

  thread turret_heat_thread();
  for(;;) {
    self waittill("trigger", var_00);
    thread func_9F4A(var_00);
  }
}

func_9F4A(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 notify("weapon_change", "none");
  self waittill("turret_deactivate");
  param_00 notify("weapon_change", param_00 getcurrentweapon());
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
    wait 0.05;
  }
}

turret_updateheat() {
  var_00 = self.turretlerp_isheatingup;
  var_01 = gettime();
  if(self.turretlerp_lastheatchangetime >= var_01) {
    return;
  }

  if(var_01 >= self.turretlerp_heatpenaltyendtime) {
    if(!self method_8698()) {
      self method_8175();
    }
  }

  var_02 = self.turret_heatlevel;
  self.turret_heatlevel = bg_turret_computeheatlevel(var_01, self.gdt_overheatuprate, self.gdt_overheatdownrate);
  self.turretlerp_isheatingup = self method_80D7() && self.turretlerp_heatpenaltyendtime <= var_01;
  if(var_00 != self.turretlerp_isheatingup) {
    self.turretlerp_lastheatchangetime = var_01;
    self.turretlerp_lastheatchangelevel = self.turret_heatlevel;
  }

  if(self.turret_heatlevel >= 100) {
    self.turretlerp_heatpenaltyendtime = var_01 + self.gdt_overheatpenalty * 1000;
    if(isDefined(self.gdt_overheatvfx)) {
      playFXOnTag(self.gdt_overheatvfx, self, "TAG_FLASH");
    }

    if(isDefined(self.gdt_overheatsound)) {
      lib_0380::func_288B(self.gdt_overheatsound, undefined, self);
    }

    self method_8158();
  }
}

bg_turret_computeheatlevel(param_00, param_01, param_02) {
  var_03 = self.turretlerp_lastheatchangelevel / 100;
  if(param_00 <= self.turretlerp_lastheatchangetime) {
    return self.turretlerp_lastheatchangelevel;
  }

  var_04 = param_00 - self.turretlerp_lastheatchangetime * 0.001;
  if(self.turretlerp_isheatingup) {
    var_05 = var_04 * param_01;
    var_06 = min(var_03 + var_05, 1);
  } else {
    var_05 = var_06 * var_04;
    var_06 = max(var_04 - var_06, 0);
  }

  return int(var_06 * 100);
}

turret_heat_store_settings() {
  if(!isDefined(level.turret_heat_settings)) {
    level.turret_heat_settings["turret_mg42_mp"] = spawnStruct();
    level.turret_heat_settings["turret_mg42_mp"].overheatuprate = 1.3;
    level.turret_heat_settings["turret_mg42_mp"].overheatdownrate = 0.6;
    level.turret_heat_settings["turret_mg42_mp"].overheatpenalty = 3;
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
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatpenalty = 2;
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatvfx = loadfx("vfx/muzzleflash/minigun_overheat");
    level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"].overheatsound = "wpn_mg42_overheat";
    level.turret_heat_settings["turretweapon_mg42_bucket_mp"] = level.turret_heat_settings["turretweapon_usa_m1919_tank_sherman_bucket_mp"];
  }

  var_00 = self.var_01D1;
  if(isDefined(var_00)) {
    if(function_0224(var_00)) {
      if(isDefined(level.turret_heat_settings[var_00])) {
        self.gdt_overheatpenalty = level.turret_heat_settings[var_00].overheatpenalty;
        self.gdt_overheatuprate = level.turret_heat_settings[var_00].overheatuprate;
        self.gdt_overheatdownrate = level.turret_heat_settings[var_00].overheatdownrate;
        self.gdt_overheatvfx = level.turret_heat_settings[var_00].overheatvfx;
        self.gdt_overheatsound = level.turret_heat_settings[var_00].overheatsound;
        return 1;
      }
    }
  }

  return 0;
}

turret_spawned_turrets_overheat() {
  var_00 = function_0024();
  for(;;) {
    wait 0.05;
    var_01 = function_0024();
    var_02 = common_scripts\utility::func_0F7D(var_01, var_00);
    if(isDefined(var_02)) {
      foreach(var_04 in var_02) {
        var_04 thread turret_heat_thread();
      }
    }

    var_00 = var_01;
  }
}

func_8A2E(param_00, param_01) {
  self.var_94B9 = 0;
  self setotherent(param_00);
  level.var_61ED[level.var_61ED.size] = self;
  self.var_5A30 = (0, 0, 4);
  self.var_5A2C = spawn("script_model", self.var_0116 + self.var_5A30);
  self.var_5A2C setscriptmoverkillcam("explosive");
  self.var_5A2C linkto(self);
  param_00.var_37FB = common_scripts\utility::func_0FA0(param_00.var_37FB);
  if(param_00.var_37FB.size >= level.var_6092) {
    if(maps\mp\_utility::func_585F() && isDefined(param_00.var_37FB[0].var_9D65)) {
      param_00.var_37FB[0].var_9D65 notify("trigger", param_00);
      wait 0.05;
    } else {
      param_00.var_37FB[0] delete();
    }
  }

  param_00.var_37FB[param_00.var_37FB.size] = self;
  if(!maps\mp\_utility::func_585F()) {
    thread func_27D0("npc_ger_smi44_bouncing_betty_bombsquad", "tag_weapon", param_00);
  }

  thread func_86CA(param_00.var_012C["team"]);
  thread func_61DD();
  thread func_61EB();
  func_5FB8(!param_01);
}

func_61DD() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.var_00FB = 100000;
  self.var_00BC = self.var_00FB;
  var_00 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isPlayer(var_00) && !function_01EF(var_00)) {
      continue;
    }

    if(isDefined(var_09) && var_09 == "bouncingbetty_mp") {
      continue;
    }

    if(!func_3ECD(self.var_0117, var_00)) {
      continue;
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          break;
      }
    }

    break;
  }

  self notify("mine_destroyed");
  if(isDefined(var_04) && issubstr(var_04, "MOD_GRENADE") || issubstr(var_04, "MOD_EXPLOSIVE")) {
    self.var_A86B = 1;
  }

  if(isDefined(var_08) && var_08 &level.var_5039) {
    self.var_A86F = 1;
  }

  self.var_A86E = 1;
  if(isPlayer(var_00)) {
    var_00 maps\mp\gametypes\_damagefeedback::func_A102("bouncing_betty");
  }

  if(level.var_984D) {
    if(isDefined(var_00) && isDefined(self.var_0117)) {
      var_0A = var_00.var_012C["team"];
      var_0B = self.var_0117.var_012C["team"];
      if(isDefined(var_0A) && isDefined(var_0B) && var_0A != var_0B) {
        var_00 notify("destroyed_explosive");
        level thread maps\mp\gametypes\_rank::func_1457("equipment_destroyed", var_00, var_09);
        var_00 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
        if(var_00 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
          var_00 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
        }
      }
    }
  } else if(isDefined(self.var_0117) && isDefined(var_00) && var_00 != self.var_0117) {
    var_00 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::func_1457("equipment_destroyed", var_00, var_09);
    var_00 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
    if(var_00 maps\mp\_utility::func_0649("specialty_detectexplosive")) {
      var_00 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
    }
  }

  thread func_61E3(var_00);
}

func_61EB() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait(2);
  var_00 = spawn("trigger_radius", self.var_0116, 0, level.var_61E2, level.var_61E1);
  var_00.var_0117 = self;
  thread func_61DF(var_00);
  var_01 = undefined;
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(self.var_94B9) {
      continue;
    }

    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.var_0117)) {
        if(var_01 == self.var_0117) {
          continue;
        }

        if(isDefined(var_01.var_0117) && var_01.var_0117 == self.var_0117) {
          continue;
        }
      }

      if(!func_3ECD(self.var_0117, var_01, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_01 method_81AD()) < 10) {
      continue;
    }

    if(var_01 method_81D7(self.var_0116, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  lib_0378::func_8D74("wpn_bouncingbetty_trigger");
  var_02 = isPlayer(self.var_0117) && self.var_0117 maps\mp\_utility::func_0649("specialty_shortfuse");
  var_03 = isPlayer(var_01) && var_01 maps\mp\_utility::func_0649("specialty_delaymine");
  if(var_02 && var_03) {
    var_01 notify("triggered_mine");
    wait(level.delayshortminetime);
  } else if(var_02) {
    wait(level.shortminetime);
  } else if(var_03) {
    var_01 notify("triggered_mine");
    wait(level.var_2CE8);
  } else {
    wait(level.var_61E0);
  }

  thread func_61D2();
}

func_61DF(param_00) {
  common_scripts\utility::func_A70A("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  param_00 delete();
}

func_61EE() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.var_61EF);
  wait(randomfloat(0.4));
  self notify("mine_selfdestruct");
  thread func_61E3();
}

func_61D2() {
  lib_0378::func_8D74("wpn_bouncingbetty_spin");
  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  var_00 = spawn("script_model", self.var_0116);
  var_00.var_001D = self.var_001D;
  var_00 setModel("npc_ger_smi44_bouncing_betty");
  var_00.var_0117 = self.var_0117;
  var_00 setotherent(self.var_0117);
  var_00.var_A9E0 = self.var_A9E0;
  var_00.var_5A2C = self.var_5A2C;
  var_00.var_5A30 = self.var_5A30;
  if(!maps\mp\_utility::func_585F()) {
    var_00 thread func_27D0("npc_ger_smi44_bouncing_betty_bombsquad", "tag_weapon", self.var_0117);
  }

  var_01 = function_0030(self);
  self.var_5A2C unlink();
  self notify("remove");
  self delete();
  var_02 = var_00.var_0116 + (0, 0, 64);
  var_00 moveto(var_02, 0.7, 0, 0.65);
  var_00.var_5A2C moveto(var_02 + var_00.var_5A30, 0.7, 0, 0.65);
  var_00 rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  var_00 thread func_74DD();
  wait(0.65);
  if(!var_01) {
    var_00 thread func_61E3();
    return;
  }

  var_00.var_5A2C delete();
  var_00 notify("death");
  var_00 delete();
}

func_61E3(param_00) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(param_00) && isDefined(param_00.var_5CC6) && param_00 != self.var_0117) {
    self.var_5CC6 = param_00.var_5CC6;
  }

  if(!isDefined(param_00)) {
    param_00 = self.var_0117;
  }

  lib_0378::func_8D74("wpn_bouncingbetty_exp");
  if(!function_0030(self)) {
    var_01 = self gettagorigin("tag_fx");
    playFX(level.var_61C8, var_01);
  }

  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  self method_805C();
  if(!function_0030(self)) {
    self entityradiusdamage(self.var_0116, level.var_61DE, level.var_61DB, level.var_61DC, param_00, "MOD_EXPLOSIVE", self.var_A9E0);
  }

  if(isDefined(self.var_0117) && isDefined(level.var_5C44)) {
    self.var_0117 thread[[level.var_5C44]]("mine_destroyed", undefined, undefined, self.var_0116);
  }

  wait(0.2);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  self.var_5A2C delete();
  self notify("death");
  self delete();
}

func_61E4(param_00, param_01, param_02) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = self.var_0117;
  }

  lib_0378::func_8D74("wpn_bouncingbetty_exp");
  var_03 = self gettagorigin("tag_fx");
  playFX(level.var_61C8, var_03);
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  self method_805C();
  self entityradiusdamage(self.var_0116, level.var_61DE * param_01, level.var_61DB * param_02, level.var_61DC, param_00, "MOD_EXPLOSIVE", self.var_A9E0);
  if(isDefined(self.var_0117) && isDefined(level.var_5C44)) {
    self.var_0117 thread[[level.var_5C44]]("mine_destroyed", undefined, undefined, self.var_0116);
  }

  wait(0.2);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  self.var_5A2C delete();
  self notify("death");
  self delete();
}

func_61F7() {
  if(self.var_94B9) {
    return;
  }

  self.var_94B9 = 1;
  playFXOnTag(common_scripts\utility::func_44F5("mine_stunned"), self, "tag_origin");
}

func_61F8() {
  self.var_94B9 = 0;
  stopFXOnTag(common_scripts\utility::func_44F5("mine_stunned"), self, "tag_origin");
}

func_61D7(param_00) {
  if(isDefined(self.var_A9E0)) {
    if(isDefined(self.var_37D3)) {
      self.var_37D3 destroy();
    }

    if(self.var_A9E0 == "bouncingbetty_mp") {
      if(isDefined(self.var_9D65)) {
        self.var_9D65 delete();
      }

      if(isDefined(self.var_359B["friendly"])) {
        self.var_359B["friendly"] delete();
      }

      if(isDefined(self.var_359B["enemy"])) {
        self.var_359B["enemy"] delete();
      }

      for(var_01 = 0; var_01 < self.var_0117.var_37FB.size; var_01++) {
        if(self.var_0117.var_37FB[var_01] == self) {
          self.var_0117.var_37FB[var_01] = undefined;
        }
      }

      self.var_0117.var_37FB = common_scripts\utility::func_0FA0(self.var_0117.var_37FB);
      self notify("change_owner");
      self.var_0117 = param_00;
      self.var_0117.var_37FB[self.var_0117.var_37FB.size] = self;
      self.var_01A7 = param_00.var_01A7;
      self setotherent(param_00);
      self.var_9D65 = spawn("script_origin", self.var_0116 + (0, 0, 25));
      self.var_9D65.var_0117 = self;
      func_37F7(param_00);
      thread func_86CA(param_00.var_01A7);
      param_00 thread func_61FE(self);
      param_00 thread func_61FD(self);
      return;
    }

    if(self.var_A9E0 == "claymore_mp") {
      if(isDefined(self.var_9D65)) {
        self.var_9D65 delete();
      }

      for(var_01 = 0; var_01 < self.var_0117.var_232F.size; var_01++) {
        if(self.var_0117.var_232F[var_01] == self) {
          self.var_0117.var_232F[var_01] = undefined;
        }
      }

      self.var_0117.var_232F = common_scripts\utility::func_0FA0(self.var_0117.var_232F);
      self notify("change_owner");
      self.var_0117 = param_00;
      self.var_0117.var_232F[self.var_0117.var_232F.size] = self;
      self.var_01A7 = param_00.var_01A7;
      self setotherent(param_00);
      self.var_9D65 = spawn("script_origin", self.var_0116);
      self.var_9D65.var_0117 = self;
      func_37F7(param_00);
      thread func_86CA(param_00.var_01A7);
      param_00 thread func_61FE(self);
      param_00 thread func_61FD(self);
      thread func_2334();
      return;
    }

    if(self.var_A9E0 == "c4_mp") {
      var_02 = 0;
      var_03 = 0;
      for(var_01 = 0; var_01 < self.var_0117.var_5FDB.size; var_01++) {
        if(self.var_0117.var_5FDB[var_01][0] == self) {
          self.var_0117.var_5FDB[var_01][0] = undefined;
          var_02 = self.var_0117.var_5FDB[var_01][1];
          var_03 = self.var_0117.var_5FDB[var_01][2];
        }
      }

      self.var_0117.var_5FDB = func_5FDA(self.var_0117.var_5FDB);
      self notify("change_owner");
      self.var_0117 = param_00;
      var_04 = self.var_0117.var_5FDB.size;
      self.var_0117.var_5FDB[var_04] = [];
      self.var_0117.var_5FDB[var_04][0] = self;
      self.var_0117.var_5FDB[var_04][1] = var_02;
      self.var_0117.var_5FDB[var_04][2] = var_03;
      self.var_01A7 = param_00.var_01A7;
      self setotherent(param_00);
      func_37F7(param_00);
      thread func_86CA(param_00.var_01A7);
      return;
    }

    return;
  }
}

func_74DD() {
  self endon("death");
  var_00 = gettime() + 1000;
  while(gettime() < var_00) {
    wait 0.05;
    playFXOnTag(level.var_61CF, self, "tag_fx_spin1");
    playFXOnTag(level.var_61CF, self, "tag_fx_spin3");
    wait 0.05;
    playFXOnTag(level.var_61CF, self, "tag_fx_spin2");
    playFXOnTag(level.var_61CF, self, "tag_fx_spin4");
  }
}

func_61D8(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06[0] = (1, 0, 0);
  var_06[1] = (0, 1, 0);
  if(param_01[2] < param_05) {
    var_07 = 0;
  } else {
    var_07 = 1;
  }

  var_08 = (param_00[0], param_00[1], param_05);
  var_09 = (param_01[0], param_01[1], param_05);
  thread func_2B4D(var_08, level.var_61DE, var_06[var_07], 32);
  var_0A = distancesquared(param_00, param_01);
  if(var_0A > param_02) {
    var_07 = 0;
  } else {
    var_07 = 1;
  }

  thread func_2B57(var_08, var_09, var_06[var_07]);
}

func_61DA(param_00, param_01) {
  if(isPlayer(param_01) && isalive(param_01) && param_01.var_0178 == "playing") {
    var_02 = param_01 maps\mp\_utility::func_469E();
  } else if(var_02.var_003A == "misc_turret") {
    var_02 = var_02.var_0116 + (0, 0, 32);
  } else {
    var_02 = var_02.var_0116;
  }

  var_03 = 0;
  var_04 = param_00.var_0116[2] + var_03 + level.var_61D9;
  var_05 = param_00.var_0116[2] + var_03 - level.var_61D9;
  if(var_02[2] > var_04 || var_02[2] < var_05) {
    return 0;
  }

  return 1;
}

func_A941() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");
  for(;;) {
    self.var_57CF = 0;
    self waittill("sprint_slide_begin");
    self.var_57CF = 1;
    self.var_5BDE = gettime();
    self waittill("sprint_slide_end");
  }
}

func_A938() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");
  for(;;) {
    self waittill("reload");
    self.var_5BD6 = gettime();
    if(maps\mp\_utility::func_0649("specialty_boostafterreload")) {
      thread maps\mp\perks\_perkfunctions::handleclassifiedboostafterreload();
    }
  }
}

func_A944() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");
  for(;;) {
    self waittill("sprint_begin");
    var_00 = gettime();
    var_01 = self getcurrentweapon();
    var_02 = undefined;
    if(!isDefined(level.disabledivisionskills) && level.disabledivisionskills && isDefined(self.var_0079) && self.var_0079 != 5 && function_01AA(var_01) == "rifle" && issubstr(var_01, "bayonet")) {
      var_02 = maps\mp\gametypes\_divisions::func_461C(0);
      if(var_02 == "bayonet_level2" || var_02 == "bayonet_level3") {
        self setclientomnvar("ui_show_division_rifle_ability_prompt", 1);
        thread func_A94A();
      }
    } else if(issubstr(var_01, "shield_charge")) {
      self setclientomnvar("ui_show_shield_charge_ability_prompt", 1);
      thread watchsprintweaponswitchforshieldchargeprompt();
    } else if(function_01AA(var_01) == "spread" && issubstr(var_01, "dragon_breath")) {
      if(!maps\mp\_utility::func_0649("specialty_sprintreload")) {
        self setclientomnvar("ui_show_division_shotgun_ability_prompt", 0);
      }
    }

    self waittill("sprint_end");
    var_03 = gettime();
    if(!isDefined(level.disabledivisionskills) && level.disabledivisionskills && isDefined(self.var_0079) && self.var_0079 != 5 && function_01AA(var_01) == "rifle" && issubstr(var_01, "bayonet") && isDefined(var_02) && var_02 == "bayonet_level2" || var_02 == "bayonet_level3") {
      self setclientomnvar("ui_show_division_rifle_ability_prompt", 0);
    } else if(issubstr(var_01, "shield_charge")) {
      self setclientomnvar("ui_show_shield_charge_ability_prompt", 0);
    } else if(function_01AA(var_01) == "spread" && issubstr(var_01, "dragon_breath")) {
      if(self method_85EC() && !maps\mp\_utility::func_0649("specialty_sprintreload")) {
        self setclientomnvar("ui_show_division_shotgun_ability_prompt", 1);
      }
    }

    if(isDefined(self.var_9A16) && isDefined(self.var_9A17)) {
      self.var_9A16 = self.var_9A16 + var_03 - var_00 / 1000;
      if(!isDefined(self.var_90AE)) {
        self.var_90AE = -1;
      }

      if(!isDefined(self.var_90AD)) {
        self.var_90AD = -1;
      }

      if(self.var_90AE < 0 && self.var_90AD < 0) {
        self.var_9A17 = self.var_9A17 + var_03 - var_00 / 1000;
      }
    }

    self.var_5BE3 = var_03;
  }
}

func_A94A() {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("sprint_end");
  for(;;) {
    self waittill("weapon_change");
    var_00 = self getcurrentweapon();
    if(!isDefined(level.disabledivisionskills) && level.disabledivisionskills && isDefined(self.var_0079) && self.var_0079 != 5 && function_01AA(var_00) == "rifle" && issubstr(var_00, "bayonet")) {
      var_01 = maps\mp\gametypes\_divisions::func_461C(0);
      if(var_01 == "bayonet_level2" || var_01 == "bayonet_level3") {
        self setclientomnvar("ui_show_division_rifle_ability_prompt", 1);
      } else {
        self setclientomnvar("ui_show_division_rifle_ability_prompt", 0);
      }

      continue;
    }

    self setclientomnvar("ui_show_division_rifle_ability_prompt", 0);
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
    var_00 = self getcurrentweapon();
    if(issubstr(var_00, "shield_charge")) {
      self setclientomnvar("ui_show_shield_charge_ability_prompt", 1);
      continue;
    }

    self setclientomnvar("ui_show_shield_charge_ability_prompt", 0);
  }
}

func_A920() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");
  self.var_A25D = 0;
  for(;;) {
    self waittill("got_lethal_resupply");
    self.var_A25D = 1;
  }
}

func_5316() {
  if(isDefined(self.var_37FB)) {
    if(maps\mp\_utility::func_4529("scr_deleteexplosivesonspawn", 1) == 1) {
      if(isDefined(self.var_3234)) {
        self.var_3234 = undefined;
      } else {
        func_2CF6();
      }
    }
  } else {
    self.var_37FB = [];
  }

  if(!isDefined(self.var_5A6D)) {
    self.var_5A6D = [];
  }
}

func_3BE4(param_00, param_01) {
  if(param_01 == "role_explosive_rat_mp") {
    if(!isalive(self)) {
      param_00 delete();
      return;
    }

    maps\mp\gametypes\_gamelogic::func_869D(self, 1);
    param_00 thread func_3973(self, 1);
  }
}

func_3973(param_00, param_01) {
  self.var_0117 = param_00;
  self waittill("missile_stuck");
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = bulletTrace(self.var_0116 + (0, 0, 4), self.var_0116 - (0, 0, 4), 0, self);
  var_03 = var_02["position"];
  if(var_02["fraction"] == 1) {
    var_03 = getgroundposition(self.var_0116, 12, 0, 32);
    var_02["normal"] = var_02["normal"] * -1;
  }

  var_04 = func_905F(var_03, param_00, undefined, self.var_001D, param_01);
  var_04.var_9D65 = spawn("script_origin", var_04.var_0116 + (0, 0, 25));
  var_04.var_9D65.var_0117 = var_04;
  var_04.var_9D65.var_28D3 = maps\mp\gametypes\_gameobjects::func_45A9();
  objective_add(var_04.var_9D65.var_28D3, "invisible", (0, 0, 0));
  objective_position(var_04.var_9D65.var_28D3, var_04.var_0116);
  function_01D1(var_04.var_9D65.var_28D3, "cb_compassping_enemy_objective");
  if(!level.var_984D) {
    objective_playerenemyteam(var_04.var_9D65.var_28D3, param_00 getentitynumber());
  } else {
    objective_team(var_04.var_9D65.var_28D3, level.var_6C63[param_00.var_01A7]);
  }

  var_04.var_9D65 thread func_3970();
  param_00 thread func_61FE(var_04);
  param_00 thread func_61FD(var_04);
  self delete();
}

func_905F(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = (0, randomfloat(360), 0);
  }

  var_05 = "vfx_rat_fr6_a";
  var_06 = spawn("script_model", param_00);
  var_06.var_001D = param_03;
  var_06 setModel(var_05);
  var_06.var_0117 = param_01;
  var_06.var_94B9 = 0;
  var_06 setotherent(param_01);
  var_06.var_A9E0 = "role_explosive_rat_mp";
  var_06.var_5A30 = (10, 10, 10);
  var_06.var_5A2C = spawn("script_model", var_06.var_0116 + var_06.var_5A30);
  var_06.var_5A2C setscriptmoverkillcam("explosive");
  var_06 thread func_396F(param_01);
  var_06 thread func_3971(param_01);
  var_07 = self getlinkedparent();
  if(isDefined(var_07)) {
    var_06 linkto(var_07);
  }

  return var_06;
}

func_3970() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait(randomfloat(2));
  for(;;) {
    objective_state(self.var_28D3, "active");
    wait(0.25 + randomfloat(2));
    objective_state(self.var_28D3, "invisible");
    wait(0.25 + randomfloat(2));
  }
}

func_396F(param_00) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait(level.var_3966);
  var_01 = spawn("trigger_radius", self.var_0116, 0, level.var_396C, level.var_396B);
  var_01.var_0117 = self;
  thread func_396E(var_01, param_00);
  thread func_3969(var_01);
  var_02 = undefined;
  for(;;) {
    var_01 waittill("trigger", var_02);
    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.var_0117)) {
        if(var_02 == self.var_0117) {
          continue;
        }

        if(isDefined(var_02.var_0117) && var_02.var_0117 == self.var_0117) {
          continue;
        }
      }

      if(!func_3ECD(self.var_0117, var_02, 0)) {
        continue;
      }
    }

    break;
  }

  wait(level.var_396A);
  self notify("mine_triggered");
  lib_0378::func_8D74("wpn_bouncingbetty_trigger");
  thread func_396D(param_00);
}

func_396E(param_00, param_01) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  param_01 waittill("death");
  thread func_396D(param_01);
}

func_3969(param_00, param_01) {
  common_scripts\utility::func_A70A("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  if(isDefined(param_00)) {
    if(isDefined(param_00.var_28D3)) {
      maps\mp\_utility::func_068B(param_00.var_28D3);
    }

    param_00 delete();
  }
}

func_3971(param_00) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.var_3972);
  wait(randomfloat(0.4));
  self notify("mine_selfdestruct");
  thread func_396D(param_00);
}

func_396D(param_00) {
  if(!isDefined(self)) {
    return;
  }

  lib_0378::func_8D74("wpn_bouncingbetty_exp");
  playFX(level.var_61C8, self.var_0116);
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  self method_805C();
  foreach(var_02 in level.var_744A) {
    if(var_02 != param_00 && level.var_984D && var_02.var_01A7 == param_00.var_01A7) {
      continue;
    }

    if(distancesquared(var_02.var_0116, self.var_0116) < pow(level.var_3968, 2)) {
      var_02 dodamage(level.var_3967, self.var_0116, param_00, self, "MOD_EXPLOSIVE", "role_explosive_rat_mp");
    }
  }

  if(isDefined(self.var_0117) && isDefined(level.var_5C44)) {
    self.var_0117 thread[[level.var_5C44]]("mine_destroyed", undefined, undefined, self.var_0116);
  }

  wait(0.2);
  if(!isDefined(self)) {
    return;
  }

  maps\mp\_utility::func_068B(self.var_9D65.var_28D3);
  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  self.var_5A2C delete();
  self delete();
}

func_3C15(param_00, param_01) {
  if(param_01 == "bouncingbetty" || param_01 == "bouncingbetty_mp") {
    maps\mp\gametypes\_gamelogic::func_869D(self, 1);
  }

  param_00 method_805C();
  if(!isalive(self)) {
    if(isDefined(param_00)) {
      param_00 notify("remove");
      param_00 delete();
    }

    return;
  }

  if(!self isonground()) {
    self iclientprintlnbold(&"WEAPON_BETTY_INVALID_MIDAIR");
    var_02 = self getweaponammostock(param_01);
    if(var_02 < weaponmaxammo(param_01)) {
      self setweaponammostock(param_01, var_02 + 1);
    }

    if(isDefined(param_00)) {
      param_00 delete();
    }

    return;
  }

  param_00 thread func_61F9(self, 1);
}

func_61F9(param_00, param_01) {
  self.var_0117 = param_00;
  var_02 = waittill_missile_stuck_or_timeout();
  if(!function_0030(self) && var_02 == "missile_stuck") {
    self method_805B();
    if(!isDefined(param_00)) {
      return;
    }

    func_8A2E(param_00, param_01);
    self.var_9D65 = spawn("script_origin", self.var_0116 + (0, 0, 25));
    self.var_9D65.var_0117 = self;
    self.var_9D65 linkto(self);
    thread func_3800(param_00, 0);
    param_00 thread func_61FE(self);
    param_00 thread func_61FD(self);
    return;
  }

  self notify("remove");
  self delete();
}

func_61FE(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  param_00 endon("change_owner");
  self waittill("disconnect");
  if(isDefined(param_00.var_9D65)) {
    param_00.var_9D65 delete();
  }

  param_00 notify("remove");
  param_00 delete();
}

func_61FD(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  param_00 endon("change_owner");
  common_scripts\utility::func_A732("joined_team", "joined_spectators");
  if(param_00.var_A9E0 == "s2_tactical_insertion_cavalry_mp") {
    self.var_6E6C = 0;
    maps\mp\perks\_perkfunctions::func_2D54(param_00);
    return;
  }

  if(isDefined(param_00.var_9D65)) {
    param_00.var_9D65 delete();
  }

  param_00 notify("remove");
  param_00 delete();
}

func_61D0() {
  self endon("change_owner");
  self.var_359B["friendly"] = spawnfx(level.var_61C2["friendly"], self gettagorigin("tag_fx"));
  self.var_359B["enemy"] = spawnfx(level.var_61C2["enemy"], self gettagorigin("tag_fx"));
  thread func_61D1();
  self waittill("death");
  self.var_359B["friendly"] delete();
  self.var_359B["enemy"] delete();
}

func_61D1() {
  self endon("death");
  self endon("change_owner");
  var_00 = self.var_0117.var_01A7;
  wait 0.05;
  triggerfx(self.var_359B["friendly"]);
  triggerfx(self.var_359B["enemy"]);
  for(;;) {
    self.var_359B["friendly"] method_805C();
    self.var_359B["enemy"] method_805C();
    foreach(var_02 in level.var_744A) {
      if(level.var_984D && !function_0367()) {
        if(var_02.var_01A7 == var_00) {
          self.var_359B["friendly"] showtoclient(var_02);
        } else {
          self.var_359B["enemy"] showtoclient(var_02);
        }

        continue;
      }

      if(var_02 == self.var_0117) {
        self.var_359B["friendly"] showtoclient(var_02);
        continue;
      }

      self.var_359B["enemy"] showtoclient(var_02);
    }

    level common_scripts\utility::func_A732("joined_team", "player_spawned");
  }
}

func_2CF3() {
  if(isDefined(self.var_5FDB)) {
    for(var_00 = 0; var_00 < self.var_5FDB.size; var_00++) {
      if(isDefined(self.var_5FDB[var_00][0])) {
        if(isDefined(self.var_5FDB[var_00][0].var_9D65)) {
          self.var_5FDB[var_00][0].var_9D65 delete();
        }

        self.var_5FDB[var_00][0] delete();
      }
    }
  }

  self.var_5FDB = [];
  if(isDefined(self.var_232F)) {
    for(var_00 = 0; var_00 < self.var_232F.size; var_00++) {
      if(isDefined(self.var_232F[var_00])) {
        if(isDefined(self.var_232F[var_00].var_9D65)) {
          self.var_232F[var_00].var_9D65 delete();
        }

        self.var_232F[var_00] notify("remove");
        self.var_232F[var_00] delete();
      }
    }
  }

  self.var_232F = [];
  if(isDefined(self.var_1B56)) {
    for(var_00 = 0; var_00 < self.var_1B56.size; var_00++) {
      if(isDefined(self.var_1B56[var_00])) {
        if(isDefined(self.var_1B56[var_00].var_9D65)) {
          self.var_1B56[var_00].var_9D65 delete();
        }

        self.var_1B56[var_00] notify("remove");
        self.var_1B56[var_00] delete();
      }
    }
  }

  self.var_1B56 = [];
  if(isDefined(self.var_2B71)) {
    for(var_00 = 0; var_00 < self.var_2B71.size; var_00++) {
      if(isDefined(self.var_2B71[var_00])) {
        self.var_2B71[var_00] notify("remove");
        self.var_2B71[var_00] delete();
      }
    }
  }

  self.var_2B71 = [];
}

func_2CF6() {
  if(isDefined(self.var_37FB)) {
    self.var_37FB = common_scripts\utility::func_0FA0(self.var_37FB);
    foreach(var_01 in self.var_37FB) {
      if(isDefined(var_01.var_9D65)) {
        var_01.var_9D65 delete();
      }

      var_01 delete();
    }
  }
}

func_9C5A(param_00) {
  param_00 func_2CF3();
  param_00 func_2CF6();
  if(isDefined(self.var_5FDB)) {
    param_00.var_5FDB = func_5FDA(self.var_5FDB);
  } else {
    param_00.var_5FDB = undefined;
  }

  if(isDefined(self.var_232F)) {
    param_00.var_232F = common_scripts\utility::func_0FA0(self.var_232F);
  } else {
    param_00.var_232F = undefined;
  }

  if(isDefined(self.var_1B56)) {
    param_00.var_1B56 = common_scripts\utility::func_0FA0(self.var_1B56);
  } else {
    param_00.var_1B56 = undefined;
  }

  if(isDefined(self.var_37FB)) {
    param_00.var_37FB = common_scripts\utility::func_0FA0(self.var_37FB);
  } else {
    param_00.var_37FB = undefined;
  }

  if(isDefined(self.var_5A6D)) {
    param_00.var_5A6D = common_scripts\utility::func_0FA0(self.var_5A6D);
  } else {
    param_00.var_5A6D = undefined;
  }

  if(isDefined(param_00.var_5FDB)) {
    foreach(var_02 in param_00.var_5FDB) {
      var_02[0].var_0117 = param_00;
      var_02[0] thread func_3800(param_00);
    }
  }

  if(isDefined(param_00.var_232F)) {
    foreach(var_05 in param_00.var_232F) {
      var_05.var_0117 = param_00;
      var_05 thread func_3800(param_00);
    }
  }

  if(isDefined(param_00.var_1B56)) {
    foreach(var_08 in param_00.var_1B56) {
      var_08.var_0117 = param_00;
      var_08 thread func_3800(param_00);
    }
  }

  if(isDefined(param_00.var_37FB)) {
    foreach(var_0B in param_00.var_37FB) {
      var_0B.var_0117 = param_00;
      var_0B thread func_3800(param_00);
    }
  }

  if(isDefined(param_00.var_5A6D)) {
    foreach(var_0E in param_00.var_5A6D) {
      var_0E.var_0117 = param_00;
      var_0E thread func_3800(param_00);
    }
  }

  self.var_5FDB = [];
  self.var_232F = [];
  self.var_1B56 = [];
  self.var_37FB = [];
  self.var_2B71 = [];
  self.var_5A6D = [];
  self.var_3233 = 1;
  self.var_3234 = 1;
}

func_37F5() {
  playFX(common_scripts\utility::func_44F5("equipment_sparks"), self.var_0116);
  self method_8617("sentry_explode");
}

func_37F6() {
  playFX(common_scripts\utility::func_44F5("equipment_explode_big"), self.var_0116);
  playFX(common_scripts\utility::func_44F5("equipment_smoke"), self.var_0116);
}

func_37F8() {
  playFXOnTag(common_scripts\utility::func_44F5("emp_stun"), self, "tag_origin");
}

func_9B90() {
  self.var_29A2 = [];
  if(!isai(self)) {
    thread func_7D30();
  }
}

func_7D30() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    if(self.var_00BC >= 100 && isDefined(self.var_29A2) && self.var_29A2.size > 0) {
      self.var_29A2 = [];
    }

    wait 0.05;
  }
}

func_93A1(param_00, param_01) {
  var_02 = spawnStruct();
  if(isDefined(param_00)) {
    var_02.var_6810 = param_00;
  }

  if(isDefined(param_01)) {
    var_02.var_36DE = param_01;
  }

  var_02.var_2AA8 = ::func_93A2;
  thread maps\mp\_movers::func_4A27(var_02);
}

func_93A2(param_00) {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  if(isDefined(self)) {
    if(isDefined(param_00.var_6810)) {
      if(param_00.var_6810 == "detonate") {
        self method_81D6();
        return;
      }

      self notify(param_00.var_6810);
      return;
    }

    self delete();
  }
}

func_4501() {
  var_00 = 10;
  if(isDefined(level.var_4867)) {
    var_00 = level.var_4867;
  }

  var_01 = 0;
  if(isDefined(level.var_7690)) {
    var_01 = gettime() - level.var_7690 / 1000;
  }

  return var_00 - var_01;
}

func_513A() {
  return func_4501() > 0 && !function_0367();
}

func_584D(param_00) {
  if(isendstr(param_00, "_gl")) {
    return 0;
  }

  switch (param_00) {
    case "frag_grenade_german_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 0;

    default:
      break;
  }

  var_01 = getweapondisplayname(param_00);
  if(isDefined(var_01)) {
    switch (var_01) {
      case "iw5_maaws_mp":
      case "iw5_mahem_mp":
        return 0;

      default:
        break;
    }
  }

  return 1;
}

func_A917() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    var_00 = common_scripts\utility::func_A717("grenade_fire", "missile_fire");
    var_01 = var_00[0];
    var_02 = var_00[1];
    var_03 = var_00[2];
    if(!isDefined(var_03) || var_03 == "") {
      continue;
    }

    if(func_513A()) {
      if(!func_584D(var_03)) {
        var_04 = int(func_4501() + 0.5);
        if(!var_04) {
          var_04 = 1;
        }

        if(isPlayer(self)) {
          self iclientprintlnbold(&"MP_EXPLOSIVES_UNAVAILABLE_FOR_N", var_04);
        }
      }

      continue;
    }

    break;
  }
}

func_5794(param_00) {
  var_01 = maps\mp\_utility::func_472A(param_00);
  var_02 = maps\mp\_utility::func_4431(param_00);
  if(var_01 == "weapon_projectile") {
    return 1;
  }

  if(isDefined(var_02) && issubstr(var_02, "microdronelauncher") || issubstr(var_02, "exocrossbow")) {
    return 1;
  }

  return 0;
}

func_806D(param_00, param_01, param_02) {
  var_03 = self.var_806E.size;
  if(var_03 == 0) {
    self.var_3C6E = param_01;
  }

  self.var_806E[var_03]["type"] = param_00;
  self.var_806E[var_03]["use"] = param_02;
}

func_466E(param_00) {
  var_01 = self.var_806E.size;
  var_02 = -1;
  for(var_03 = 0; var_03 < var_01; var_03++) {
    if(self.var_806E[var_03]["type"] == param_00) {
      var_02 = var_03;
      break;
    }
  }

  if(var_02 >= 0) {
    return self.var_806E[var_02]["use"];
  }

  return "none";
}

func_7DF7(param_00) {
  var_01 = [];
  var_02 = self.var_806E.size;
  var_03 = -1;
  var_04 = 0;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    if(var_03 < 0 && self.var_806E[var_05]["type"] == param_00) {
      var_03 = var_05;
      continue;
    }

    var_01[var_04] = self.var_806E[var_05];
    var_04++;
  }

  if(var_03 >= 0) {
    var_06 = "none";
    if(var_01.size == 0) {
      var_06 = self.var_3C6E;
      self.var_806E = var_01;
      self.var_3C6E = "none";
    } else {
      self.var_806E = var_01;
      var_06 = func_466E("underwater");
      if(var_06 == "none") {
        var_06 = self.var_806E[0]["use"];
      }
    }

    var_07 = self getcurrentweapon();
    if(var_07 != var_06) {
      self switchtoweaponimmediate(var_06);
    }
  }
}

func_A928(param_00, param_01) {
  self endon("end_explode");
  self endon("explode");
  self endon("remove");
  self endon("death");
  self waittill("make_dud");
}

func_A92A(param_00, param_01) {
  self endon("end_explode");
  self endon("explode");
  self endon("remove");
  self endon("death");
  for(;;) {
    self waittill("make_live");
    switch (param_01) {
      case "c4_zm":
      case "c4":
      case "c4_mp":
        thread func_1DF0();
        if(!maps\mp\_utility::func_585F()) {
          thread maps\mp\gametypes\_shellshock::func_1DEE();
        }
        break;

      case "claymore":
      case "claymore_mp":
        thread func_1DF0();
        break;

      case "tabun_grenade_mp":
        thread func_4A66(param_00, param_01);
        break;

      case "signal_flare_expeditionary_mp":
      case "signal_flare_mp":
        thread func_4AF3(param_00, param_01);
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
        thread maps\mp\gametypes\_shellshock::func_485C();
        break;
    }
  }
}

func_1712(param_00, param_01) {
  thread func_A928(param_00, param_01);
  thread func_A92A(param_00, param_01);
}

func_6244(param_00, param_01) {
  var_02 = 1;
  if(isDefined(param_01.var_556C)) {
    var_02 = param_01.var_556C;
  }

  if(function_0030(param_00) != var_02) {
    self setmissileisdud(var_02);
    if(param_01.var_556C) {
      param_00 notify("make_dud");
    } else {
      param_00 notify("make_live");
    }
  }

  param_00.var_9ABC[param_01.var_37D8] = param_01;
}

func_6245(param_00, param_01) {
  if(isDefined(param_01.var_600D) && param_01.var_600D) {
    var_02 = 0;
    if(isDefined(param_01.var_556C)) {
      var_02 = !param_01.var_556C;
    }

    if(function_0030(param_00) != var_02) {
      self setmissileisdud(var_02);
      if(var_02) {
        param_00 notify("make_dud");
      } else {
        param_00 notify("make_live");
      }
    }
  }

  param_01.var_9ABC[var_02.var_37D8] = undefined;
}

func_A929(param_00, param_01) {
  self endon("death");
  self endon("remove");
  self endon("missile_stuck");
  if(!isDefined(self)) {
    return;
  }

  func_1712(param_00, param_01);
  if(!isDefined(self.var_9ABC)) {
    self.var_9ABC = [];
  }

  if(function_0367()) {
    self setmissileisdud(1);
    self notify("make_dud");
  }

  for(;;) {
    if(isDefined(level.var_6246)) {
      foreach(var_03 in level.var_6246) {
        if(!isDefined(var_03.var_37D8)) {
          var_03.var_37D8 = var_03 getentitynumber();
        }

        if(self istouching(var_03)) {
          if(!isDefined(self.var_9ABC[var_03.var_37D8])) {
            func_6244(self, var_03);
          }

          continue;
        }

        if(isDefined(self.var_9ABC[var_03.var_37D8])) {
          func_6245(self, var_03);
        }
      }
    }

    wait 0.05;
  }
}

func_62FE() {
  level endon("game_ended");
  self notify("monitor_dive");
  self endon("monitor_dive");
  self endon("death");
  for(;;) {
    self waittill("dive_land");
    self.var_5B93 = gettime();
    self setclientomnvar("ui_fullscreen_dirt_left", 1);
    self playrumbleonentity("defaultweapon_fire");
  }
}

func_6302() {
  if(function_0367()) {
    return;
  }

  thread func_6303();
  thread func_6304();
}

func_6303() {
  level endon("game_ended");
  self notify("monitor_empty_lethals");
  self endon("monitor_empty_lethals");
  self endon("death");
  self notifyonplayercommand("lethal_pressed", "+frag");
  for(;;) {
    self waittill("lethal_pressed");
    var_00 = self method_834A();
    if(!isDefined(var_00)) {
      continue;
    }

    if(var_00 == "none" || self method_817F(var_00) == 0) {
      self playrumbleonentity("defaultweapon_fire");
    }
  }
}

func_6304() {
  level endon("game_ended");
  self notify("monitor_empty_tacticals");
  self endon("monitor_empty_tacticals");
  self endon("death");
  self notifyonplayercommand("tactical_pressed", "+smoke");
  for(;;) {
    self waittill("tactical_pressed");
    var_00 = self method_831F();
    if(!isDefined(var_00)) {
      continue;
    }

    if(var_00 == "none" || self method_817F(var_00) == 0) {
      self playrumbleonentity("defaultweapon_fire");
    }
  }
}

initteslagun() {
  if(getdvarint("spv_tesla_mp_active", 0) == 1) {
    self method_8512(["teslagunmtx_mp"]);
  }
}

potentiallyspawnteslagun(param_00, param_01) {
  level endon("game_ended");
  if(randomint(100) <= param_01 - 1) {
    var_02 = "teslagunmtx_mp";
    var_03 = "weapon_" + var_02;
    var_04 = (0, 0, 60);
    var_05 = spawn(var_03, param_00 + var_04);
    var_05 hudoutlineenable(0, 1);
    var_05 method_817E(5, 5);
    var_05 method_86B3(0);
    wait 0.05;
    if(isDefined(var_05) && !function_0279(var_05)) {
      playFXOnTag(common_scripts\utility::func_44F5("tesla_gun_glow"), var_05, "tag_origin");
      var_06 = (0, 0, 0);
      var_07 = (randomfloatrange(-0.5, 0.5), randomfloatrange(-0.5, 0.5), 1);
      var_08 = 1500;
      var_05 physicslaunchserveritem(var_05.var_0116 + var_06, var_07 * var_08);
      var_05 thread func_A934();
    }
  }
}