/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2812.gsc
***************************************/

func_248C(var_00) {
  return tablelookup("mp\attachmentTable.csv", 4, var_00, 2);
}

init() {
  level.func_EBCF = 1;
  level.func_EBD0 = 1;
  level._effect["item_fx_legendary"] = loadfx("vfx\iw7\_requests\mp\vfx_weap_loot_legendary.vfx");
  level._effect["item_fx_rare"] = loadfx("vfx\iw7\_requests\mp\vfx_weap_loot_rare.vfx");
  level._effect["item_fx_common"] = loadfx("vfx\iw7\_requests\mp\vfx_weap_loot_common.vfx");
  level._effect["shield_metal_impact"] = loadfx("vfx\iw7\core\impact\weapon\md\vfx_imp_md_metal.vfx");
  level.maxperplayerexplosives = max(scripts\mp\utility\game::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
  level.riotshieldxpbullets = scripts\mp\utility\game::getintproperty("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");

  switch (scripts\mp\utility\game::getintproperty("perk_scavengerMode", 0)) {
    case 1:
      level.func_EBCF = 0;
      break;
    case 2:
      level.func_EBD0 = 0;
      break;
    case 3:
      level.func_EBCF = 0;
      level.func_EBD0 = 0;
      break;
  }

  thread scripts\mp\flashgrenades::main();
  thread scripts\mp\entityheadicons::init();
  func_97DD();
  buildattachmentmaps();
  func_3222();
  level._effect["weap_blink_friend"] = loadfx("vfx\core\mp\killstreaks\vfx_detonator_blink_cyan");
  level._effect["weap_blink_enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_detonator_blink_orange");
  level._effect["emp_stun"] = loadfx("vfx\core\mp\equipment\vfx_emp_grenade");
  level._effect["equipment_explode"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp.vfx");
  level._effect["equipment_smoke"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx\core\mp\killstreaks\vfx_sentry_gun_explosion");
  level._effect["vfx_sensor_grenade_ping"] = loadfx("vfx\old\_requests\future_weapons\vfx_sensor_grenade_ping");
  level._effect["plasmablast_muz_w"] = loadfx("vfx\old\_requests\mp_weapons\vfx_muz_plasma_blast_w");
  level._effect["vfx_trail_plyr_knife_tele"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_plyr_knife_tele");
  level._effect["case_bomb"] = loadfx("vfx\old\_requests\mp_weapons\expl_plasma_blast");
  level._effect["corpse_pop"] = loadfx("vfx\iw7\_requests\mp\vfx_body_expl");
  level._effect["sniper_glint"] = loadfx("vfx\iw7\core\mechanics\sniper_glint\vfx_sniper_glint");
  level._effect["vfx_sonic_sensor_pulse"] = loadfx("vfx\iw7\_requests\mp\vfx_sonic_sensor_pulse");
  level._effect["distortion_field_cloud"] = loadfx("vfx\iw7\_requests\mp\vfx_distortion_field_volume");
  level._effect["penetration_railgun_impact"] = loadfx("vfx\iw7\_requests\mp\vfx_penetration_railgun_impact");
  level._effect["penetration_railgun_pin"] = loadfx("vfx\iw7\_requests\mp\vfx_penetration_railgun_pin");
  level._effect["vfx_penetration_railgun_impact"] = loadfx("vfx\iw7\_requests\mp\vfx_penetration_railgun_impact.vfx");
  level._effect["vfx_emp_grenade_underbarrel"] = loadfx("vfx\iw7\_requests\mp\vfx_pulse_grenade_friendly.vfx");
  throwingknifec4init();
  scripts\mp\utility\game::func_CC18();
  level.weaponconfigs = [];

  if(!isDefined(level.weapondropfunction))
    level.weapondropfunction = ::dropweaponfordeath;

  var_00 = 70;
  level.claymoredetectiondot = cos(var_00);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.5;
  level.claymoredetonateradius = 192;
  var_01 = 25;
  level.func_10F8F = cos(var_01);
  level.func_10F91 = 15;
  level.func_10F90 = 0.35;
  level.func_10F92 = 256;
  level.minedetectiongraceperiod = 0.3;
  level.minedetectionradius = 100;
  level.minedetectionheight = 40;
  level.minedamageradius = 256;
  level.minedamagemin = 70;
  level.minedamagemax = 210;
  level.minedamagehalfheight = 46;
  level.mineselfdestructtime = 120;
  level.mine_launch = loadfx("vfx\core\impacts\bouncing_betty_launch_dirt");
  level.mine_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_dest_exp");
  var_02 = spawnStruct();
  var_2.model = "projectile_bouncing_betty_grenade";
  var_2.bombsquadmodel = "projectile_bouncing_betty_grenade_bombsquad";
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_2.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_2.armtime = 2;
  var_2.ontriggeredsfx = "mine_betty_click";
  var_2.onlaunchsfx = "mine_betty_spin";
  var_2.onexplodesfx = "frag_grenade_explode";
  var_2.launchheight = 64;
  var_2.launchtime = 0.65;
  var_2.ontriggeredfunc = ::minebounce;
  var_2.headiconoffset = 20;
  level.weaponconfigs["bouncingbetty_mp"] = var_02;
  level.weaponconfigs["alienbetty_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "weapon_semtex_grenade_iw6";
  var_2.bombsquadmodel = "weapon_semtex_grenade_iw6_bombsquad";
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_2.armtime = 2;
  var_2.ontriggeredsfx = "mine_betty_click";
  var_2.onexplodesfx = "frag_grenade_explode";
  var_2.ontriggeredfunc = ::minebounce;
  var_2.headiconoffset = 20;
  level.weaponconfigs["sticky_mine_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "weapon_motion_sensor";
  var_2.bombsquadmodel = "weapon_motion_sensor_bombsquad";
  var_2.mine_beacon["enemy"] = scripts\engine\utility::getfx("weap_blink_enemy");
  var_2.mine_beacon["friendly"] = scripts\engine\utility::getfx("weap_blink_friend");
  var_2.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_2.armtime = 2;
  var_2.ontriggeredsfx = "motion_click";
  var_2.ontriggeredfunc = ::minesensorbounce;
  var_2.onlaunchsfx = "motion_spin";
  var_2.launchvfx = level.mine_launch;
  var_2.launchheight = 64;
  var_2.launchtime = 0.65;
  var_2.onexplodesfx = "motion_explode_default";
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_2.headiconoffset = 25;
  var_2.func_B371 = 4.0;
  level.weaponconfigs["motion_sensor_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "weapon_mobile_radar";
  var_2.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_2.mine_beacon["enemy"] = scripts\engine\utility::getfx("weap_blink_enemy");
  var_2.mine_beacon["friendly"] = scripts\engine\utility::getfx("weap_blink_friend");
  var_2.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_2.armtime = 2;
  var_2.ontriggeredsfx = "motion_click";
  var_2.ontriggeredfunc = ::func_B8F5;
  var_2.onlaunchsfx = "motion_spin";
  var_2.launchvfx = level.mine_launch;
  var_2.launchheight = 40;
  var_2.launchtime = 0.35;
  var_2.onexplodesfx = "motion_explode_default";
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_2.func_C4C5 = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_2.headiconoffset = 25;
  var_2.func_B371 = 4.0;
  level.weaponconfigs["mobile_radar_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.armingdelay = 1.5;
  var_2.detectionradius = 232;
  var_2.detectionheight = 512;
  var_2.detectiongraceperiod = 1;
  var_2.headiconoffset = 20;
  var_2.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var_02;
  var_02 = spawnStruct();
  var_03 = 800;
  var_04 = 200;
  var_2.radius_max_sq = var_03 * var_03;
  var_2.radius_min_sq = var_04 * var_04;
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_flashbang.vfx");
  var_2.onexplodesfx = "flashbang_explode_default";
  var_2.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var_02;
  var_02 = spawnStruct();
  var_03 = 800;
  var_04 = 200;
  var_2.radius_max_sq = var_03 * var_03;
  var_2.radius_min_sq = var_04 * var_04;
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_flashbang.vfx");
  var_2.func_C523 = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_charge");
  var_2.func_D828 = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_laser");
  var_2.onexplodesfx = "flashbang_explode_default";
  var_2.vfxradius = 72;
  level.weaponconfigs["throwingknifedisruptor_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "weapon_sonic_sensor_wm";
  var_2.bombsquadmodel = "weapon_motion_sensor_bombsquad";
  var_2.mine_beacon["enemy"] = scripts\engine\utility::getfx("weap_blink_enemy");
  var_2.mine_beacon["friendly"] = scripts\engine\utility::getfx("weap_blink_friend");
  var_2.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_2.armtime = 2;
  var_2.ontriggeredsfx = "motion_click";
  var_2.onlaunchsfx = "motion_spin";
  var_2.launchvfx = level.mine_launch;
  var_2.launchheight = 64;
  var_2.launchtime = 0.65;
  var_2.onexplodesfx = "motion_explode_default";
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_2.headiconoffset = 25;
  var_2.func_B371 = 4.0;
  level.weaponconfigs["sonic_sensor_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "weapon_mobile_radar";
  var_2.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_2.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_2.armtime = 0.05;
  var_2.minedamagemin = 0;
  var_2.minedamagemax = 0;
  var_2.ontriggeredsfx = "motion_click";
  var_2.onlaunchsfx = "motion_spin";
  var_2.onexplodesfx = "motion_explode_default";
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_2.launchheight = 64;
  var_2.launchtime = 0.65;
  var_2.ontriggeredfunc = scripts\mp\equipment\fear_grenade::func_6BBC;
  var_2.onexplodefunc = scripts\mp\equipment\fear_grenade::func_6BBB;
  var_2.headiconoffset = 20;
  var_2.minedetectionradius = 200;
  var_2.minedetectionheight = 100;
  level.weaponconfigs["fear_grenade_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "prop_mp_speed_strip_temp";
  var_2.bombsquadmodel = "prop_mp_speed_strip_temp";
  var_2.armtime = 0.05;
  var_2.vfxtag = "tag_origin";
  var_2.minedamagemin = 0;
  var_2.minedamagemax = 0;
  var_2.ontriggeredsfx = "motion_click";
  var_2.onlaunchsfx = "motion_spin";
  var_2.onexplodesfx = "motion_explode_default";
  var_2.launchheight = 64;
  var_2.launchtime = 0.65;
  var_2.ontriggeredfunc = scripts\mp\blackhole_grenade::blackholeminetrigger;
  var_2.onexplodefunc = scripts\mp\blackhole_grenade::blackholemineexplode;
  var_2.headiconoffset = 20;
  var_2.minedetectionradius = 200;
  var_2.minedetectionheight = 100;
  level.weaponconfigs["blackhole_grenade_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.model = "weapon_mobile_radar";
  var_2.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_2.armtime = 0.05;
  var_2.vfxtag = "tag_origin";
  var_2.minedamagemin = 0;
  var_2.minedamagemax = 0;
  var_2.ontriggeredsfx = "motion_click";
  var_2.onlaunchsfx = "motion_spin";
  var_2.onexplodesfx = "motion_explode_default";
  var_2.launchheight = 64;
  var_2.launchtime = 0.65;
  var_2.ontriggeredfunc = scripts\mp\shardball::func_FC5A;
  var_2.onexplodefunc = scripts\mp\shardball::func_FC59;
  var_2.headiconoffset = 20;
  var_2.minedetectionradius = 200;
  var_2.minedetectionheight = 100;
  level.weaponconfigs["shard_ball_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["c4_mp"] = var_02;
  var_02 = spawnStruct();
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["claymore_mp"] = var_02;
  level.delayminetime = 3.0;
  level.func_F240 = loadfx("vfx\core\muzflash\shotgunflash");
  level.func_10FA1 = loadfx("vfx\iw7\_requests\mp\power\vfx_wrist_rocket_exp.vfx");
  level.func_D8D4 = [];
  level.func_101AE = [];
  level._meth_857E = [];
  level.func_B7E0 = [];
  level.func_9B16 = [];
  level.mines = [];
  level._effect["glow_stick_glow_red"] = loadfx("vfx\misc\glow_stick_glow_red");
  scripts\mp\protoricochet::func_E4E3();
  scripts\mp\bulletstorm::func_3258();
  scripts\mp\shardball::func_FC58();
  scripts\mp\splashgrenade::splashgrenadeinit();
  level thread onplayerconnect();
  level.c4explodethisframe = 0;
  scripts\engine\utility::array_thread(getEntArray("misc_turret", "classname"), ::turret_monitoruse);
  scripts\mp\utility\game::func_98AA();
}

func_5F30() {
  wait 5.0;
}

func_97DD() {
  level.func_2C46 = [];
}

bombsquadwaiter_missilefire() {
  self endon("disconnect");

  for(;;) {
    var_00 = scripts\mp\utility\game::waittill_missile_fire();

    if(!isDefined(var_00)) {
      continue;
    }
    if(var_0.weapon_name == "iw6_mk32_mp")
      var_00 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad", "tag_weapon", self);
  }
}

createbombsquadmodel(var_00, var_01, var_02) {
  var_03 = spawn("script_model", (0, 0, 0));
  var_03 hide();
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.bombsquadmodel = var_03;
  var_03 thread bombsquadvisibilityupdater(var_02);
  var_03 setModel(var_00);
  var_03 linkto(self, var_01, (0, 0, 0), (0, 0, 0));
  var_03 setcontents(0);
  scripts\engine\utility::waittill_any("death", "trap_death");

  if(isDefined(self.trigger))
    self.trigger delete();

  var_03 delete();
}

func_561A(var_00) {
  self hudoutlineenableforclient(var_00, 6, 1, 0);
}

enablevisibilitycullingforclient(var_00) {
  self hudoutlinedisableforclient(var_00);
}

bombsquadvisibilityupdater(var_00) {
  self endon("death");
  self endon("trap_death");

  if(!isDefined(var_00)) {
    return;
  }
  var_01 = var_0.team;

  for(;;) {
    self hide();

    foreach(var_03 in level.players) {
      enablevisibilitycullingforclient(var_03);

      if(!var_03 scripts\mp\utility\game::_hasperk("specialty_detectexplosive")) {
        continue;
      }
      if(level.teambased) {
        if(var_3.team == "spectator" || var_3.team == var_01)
          continue;
      } else if(isDefined(var_00) && var_03 == var_00) {
        continue;
      }
      self giveperkequipment(var_03);
      func_561A(var_03);
    }

    level scripts\engine\utility::waittill_any("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_0.hits = 0;
    scripts\mp\gamelogic::sethasdonecombat(var_00, 0);
    var_00 thread onplayerspawned();
    var_00 thread bombsquadwaiter_missilefire();
    var_00 thread watchmissileusage();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.currentweaponatspawn = self.spawnweaponobj;
    self.empendtime = 0;
    self.concussionendtime = 0;
    self.hits = 0;
    scripts\mp\gamelogic::sethasdonecombat(self, 0);

    if(!isDefined(self.trackingweapon)) {
      self.trackingweapon = "";
      self.trackingweapon = "none";
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweapondeaths = 0;
    }

    thread watchweaponusage();
    thread watchweaponchange();
    thread func_13B4C();
    thread watchgrenadeusage();
    thread func_13A1F();
    thread func_13A93();
    thread scripts\mp\flashgrenades::func_10DC6();
    thread func_13AC3();
    thread func_13B38();
    thread scripts\mp\class::func_11B04();
    thread watchdropweapons();
    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    thread updatesavedlastweapon();
    self.currentweaponatspawn = undefined;
    self.trophyremainingammo = undefined;
    scripts\mp\gamescore::func_97D2();
    var_00 = self getcurrentweapon();
    var_01 = self _meth_8519(var_00);
    var_02 = getweaponcamoname(var_00);
    thread runcamoscripts(var_00, var_02);
    thread runweaponscriptvfx(var_00, var_01);
  }
}

recordtogglescopestates() {
  self.pers["altScopeStates"] = [];

  if(isDefined(self.primaryweapon) && self.primaryweapon != "none" && self hasweapon(self.primaryweapon) && func_7DB8(self.primaryweapon) != "" && self _meth_8519(self.primaryweapon)) {
    var_00 = getweaponbasename(self.primaryweapon);
    var_01 = func_7DB8(self.primaryweapon);
    var_02 = var_00 + "+" + var_01;
    self.pers["altScopeStates"][var_02] = 1;
  }

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && self hasweapon(self.secondaryweapon) && func_7DB8(self.secondaryweapon) != "" && self _meth_8519(self.secondaryweapon)) {
    var_00 = getweaponbasename(self.secondaryweapon);
    var_01 = func_7DB8(self.secondaryweapon);
    var_02 = var_00 + "+" + var_01;
    self.pers["altScopeStates"][var_02] = 1;
  }
}

func_DDF6() {
  if(isDefined(self.primaryweapon) && self.primaryweapon != "none" && self hasweapon(self.primaryweapon) && missile_settargetent(self.primaryweapon) != "" && self _meth_8519(self.primaryweapon)) {
    var_00 = getweaponbasename(self.primaryweapon);
    var_01 = missile_settargetent(self.primaryweapon);
    var_02 = var_00 + "+" + var_01;
    var_03 = func_7DB8(self.primaryweapon);
    var_04 = var_00 + "+" + var_03;
    self.pers["altScopeStates"][var_02] = 1;
    self.pers["altScopeStates"][var_04] = 1;
  }

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && self hasweapon(self.secondaryweapon) && missile_settargetent(self.secondaryweapon) != "" && self _meth_8519(self.secondaryweapon)) {
    var_00 = getweaponbasename(self.secondaryweapon);
    var_01 = missile_settargetent(self.secondaryweapon);
    var_02 = var_00 + "+" + var_01;
    var_03 = func_7DB8(self.secondaryweapon);
    var_04 = var_00 + "+" + var_03;
    self.pers["altScopeStates"][var_02] = 1;
    self.pers["altScopeStates"][var_04] = 1;
  }
}

func_DDF4() {
  self.pers["toggleScopeStates"] = [];
  var_00 = self getweaponslistprimaries();

  foreach(var_02 in var_00) {
    if(var_02 == self.primaryweapon || var_02 == self.secondaryweapon) {
      var_03 = getweaponattachments(var_02);

      foreach(var_05 in var_03) {
        if(issmallmissile(var_05)) {
          self.pers["toggleScopeStates"][var_02] = self _meth_812E(var_02);
          break;
        }
      }
    }
  }
}

updatetogglescopestate(var_00) {
  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][var_00]))
    self give_player_cryobomb(var_00, self.pers["toggleScopeStates"][var_00]);
}

updatesavedaltstate(var_00) {
  var_01 = missile_settargetent(var_00);
  var_02 = func_7DB8(var_00);
  var_03 = getweaponbasename(var_00);
  var_04 = var_03 + "+" + var_01;
  var_05 = var_03 + "+" + var_02;

  if(isDefined(self.pers["altScopeStates"]) && scripts\mp\utility\game::istrue(isDefined(self.pers["altScopeStates"][var_05]) || isDefined(self.pers["altScopeStates"][var_04])))
    return "alt_" + var_00;

  return var_00;
}

issmallmissile(var_00) {
  return 0;
}

func_7DB8(var_00) {
  var_01 = getweaponattachments(var_00);

  foreach(var_03 in var_01) {
    if(func_9D3C(var_03))
      return var_03;
  }

  return "";
}

missile_settargetent(var_00) {
  var_01 = getweaponattachments(var_00);

  foreach(var_03 in var_01) {
    if(func_9FF3(var_03))
      return var_03;
  }

  return "";
}

func_9D3C(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "shotgunlongshotl":
    case "longshotlscope":
    case "longshotscope":
    case "mod_akimboshotgun":
    case "ripperscopeb_camo":
    case "ripperlscope_camo":
    case "ripperscope_camo":
    case "m8lchargescope_camo":
    case "m8lscope_camo":
    case "m8rscope_camo":
    case "akimbofmg":
    case "m8scope_camo":
    case "ripperrscope_camo":
    case "shotgunlongshot":
    case "meleervn":
    case "arripper":
    case "arm8":
      var_01 = 1;
      break;
    default:
      var_02 = scripts\mp\utility\game::attachmentmap_tobase(var_00);

      if(var_02 == "hybrid" || var_02 == "acog")
        var_01 = 1;

      break;
  }

  return var_01;
}

func_9FF3(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "ripperlscope":
    case "ripperrscope":
    case "ripperscope":
    case "m8lscope":
    case "m8rscope":
    case "m8scope":
    case "akimbofmg":
      var_01 = 1;
      break;
    case "arripper":
    case "arm8":
    default:
      var_02 = scripts\mp\utility\game::attachmentmap_tobase(var_00);

      if(var_02 == "hybrid" || var_02 == "acog")
        var_01 = 1;

      break;
  }

  return var_01;
}

func_13AC3() {
  scripts\mp\missilelauncher::func_10FAD();
}

func_13AAC() {
  scripts\mp\javelin::func_A448();
}

func_13CB5(var_00, var_01) {
  if(isDefined(var_01) && var_01 != "none") {
    var_01 = scripts\mp\utility\game::getweaponrootname(var_01);
    var_02 = scripts\mp\utility\game::func_13CB4(var_01);

    if(isDefined(var_02))
      scripts\mp\utility\game::removeperk(var_02);
  }

  if(isDefined(var_00) && var_00 != "none") {
    var_00 = scripts\mp\utility\game::getweaponrootname(var_00);
    var_03 = scripts\mp\utility\game::func_13CB4(var_00);

    if(isDefined(var_03))
      scripts\mp\utility\game::giveperk(var_03);
  }
}

func_12F5D(var_00) {
  var_01 = 1;

  if(isDefined(var_00) && var_00 != "none") {
    var_02 = weaponclass(var_00);

    if((var_02 == "sniper" || issubstr(var_00, "iw7_longshot") && !isaltmodeweapon(var_00)) && !scripts\mp\utility\game::_hasperk("passive_scope_radar") || getweaponbasename(var_00) == "iw7_m1c_mp" && scripts\mp\utility\game::weaponhasattachment(var_00, "thermal"))
      var_01 = 0;
  }

  self setclientomnvar("ui_ads_minimap", var_01);
}

func_13C78(var_00, var_01) {
  var_02 = undefined;
  var_03 = undefined;

  if(isDefined(var_01) && var_01 != "none") {
    var_03 = getweaponattachments(var_01);

    if(isDefined(var_03) && var_3.size > 0) {
      foreach(var_05 in var_03) {
        var_06 = scripts\mp\utility\game::attachmentperkmap(var_05);

        if(!isDefined(var_06)) {
          continue;
        }
        scripts\mp\utility\game::removeperk(var_06);
      }
    }
  }

  if(isDefined(var_00) && var_00 != "none") {
    var_02 = getweaponattachments(var_00);

    if(isDefined(var_02) && var_2.size > 0) {
      foreach(var_09 in var_02) {
        var_06 = scripts\mp\utility\game::attachmentperkmap(var_09);

        if(!isDefined(var_06)) {
          continue;
        }
        scripts\mp\utility\game::giveperk(var_06);
      }
    }
  }
}

func_13B2E(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    var_02 = self getcurrentweapon();

    if(var_02 == var_00)
      childthread func_13BAC(var_00, var_01);

    self waittill("weapon_change");
  }
}

func_13BAC(var_00, var_01) {
  self endon("weapon_change");

  for(;;) {
    var_02 = scripts\mp\utility\game::waittill_missile_fire();

    if(!isDefined(var_2.func_9E8F))
      thread func_13BAB(var_00, var_02, anglesToForward(var_2.angles), 0, var_01);
  }
}

func_13BAB(var_00, var_01, var_02, var_03, var_04) {
  if(var_03 >= var_04) {
    return;
  }
  var_05 = var_01 scripts\engine\utility::waittill_any_timeout_no_endon_death(2, "death");

  if(var_05 != "death") {
    return;
  }
  if(!isDefined(var_01)) {
    return;
  }
  var_06 = var_1.origin + -8 * var_02;
  var_07 = var_06 + var_02 * 15;
  var_08 = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_player", "physicscontents_vehicleclip"]);
  var_09 = physics_raycast(var_06, var_07, var_08, self, 0, "physicsquery_closest");

  if(var_9.size == 0) {
    return;
  }
  var_10 = var_9[0]["entity"];
  var_11 = var_9[0]["normal"];
  var_12 = var_9[0]["position"];

  if(isDefined(var_10) && isplayer(var_10))
    return;
  else {
    var_13 = var_02 - 2 * vectordot(var_02, var_11) * var_11;
    var_13 = vectornormalize(var_13);
    var_14 = var_12 + var_13 * 2;
    var_01 = scripts\mp\utility\game::_magicbullet(var_00, var_14, var_14 + var_13, self);
    var_1.owner = self;
    var_1.func_9E8F = 1;
  }

  thread func_13BAB(var_00, var_01, var_13, var_03 + 1, var_04);
}

func_13BA9() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  var_00 = undefined;
  var_01 = self getcurrentweapon();

  for(;;) {
    var_01 = self getcurrentweapon();
    func_13C78(var_01, var_00);
    func_13CB5(var_01, var_00);
    var_00 = var_01;
    self waittill("weapon_change");
  }
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.lastdroppableweaponobj = self.currentweaponatspawn;
  self.hitsthismag = [];
  var_00 = scripts\mp\utility\game::func_E0CF(self getcurrentweapon());
  hitsthismag_init(var_00);

  for(;;) {
    self waittill("weapon_change", var_00);
    var_00 = scripts\mp\utility\game::func_E0CF(var_00);

    if(!func_B4E0(var_00)) {
      continue;
    }
    if(scripts\mp\utility\game::iskillstreakweapon(var_00)) {
      continue;
    }
    hitsthismag_init(var_00);

    if(scripts\mp\utility\game::iscacprimaryweapon(var_00) || scripts\mp\utility\game::iscacsecondaryweapon(var_00))
      self.lastdroppableweaponobj = var_00;
  }
}

func_12F11(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(var_01)
    wait 0.05;

  if(var_00 == "iw7_fhr_mp")
    self setscriptablepartstate("chargeVFX", "chargeVFXOn", 0);
  else
    self setscriptablepartstate("chargeVFX", "chargeVFXOff", 0);
}

func_13B4C() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_00 = self getcurrentweapon();

    if(func_103B9(var_00))
      childthread func_103B7();

    self waittill("weapon_change");
  }
}

func_103B9(var_00) {
  return var_00 != "none" && (weaponclass(var_00) == "sniper" || issubstr(var_00, "iw7_udm45_mpl") || issubstr(var_00, "iw7_longshot_mp") && !isaltmodeweapon(var_00)) && !issubstr(var_00, "iw7_m8_mpr");
}

func_103B7() {
  self notify("manageSniperGlint");
  self endon("managerSniperGlint");
  self endon("weapon_change");
  scripts\engine\utility::waitframe();
  thread func_103B6();
  self.glinton = 0;

  for(;;) {
    if(self playerads() > 0.5 && !scripts\mp\equipment\cloak::func_9FC1()) {
      if(!self.glinton)
        func_103B5();
    } else if(self.glinton)
      sniperglint_remove();

    scripts\engine\utility::waitframe();
  }
}

func_103B6() {
  scripts\engine\utility::waittill_any("death", "disconnect", "weapon_change");

  if(isDefined(self.glinton) && self.glinton) {
    sniperglint_remove();
    self.glinton = undefined;
  }
}

func_103B5() {
  self setscriptablepartstate("sniperGlint", "sniperGlintOn", 0);
  self.glinton = 1;
}

sniperglint_remove() {
  if(isDefined(self)) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOff", 0);
    self.glinton = 0;
  }
}

func_13B4A() {
  self endon("death");
  self endon("disconnect");
  thread watchsniperboltactionkills_ondeath();

  if(!isDefined(self.pers["recoilReduceKills"]))
    self.pers["recoilReduceKills"] = 0;

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

  for(;;) {
    self waittill("got_a_kill", var_00, var_01, var_02);

    if(isrecoilreducingweapon(var_01)) {
      var_03 = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(var_03, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

      if(var_03 <= 4)
        stancerecoilupdate(self getstance());
    }
  }
}

watchsniperboltactionkills_ondeath() {
  self notify("watchSniperBoltActionKills_onDeath");
  self endon("watchSniperBoltActionKills_onDeath");
  self endon("disconnect");
  self waittill("death");
  self.pers["recoilReduceKills"] = 0;
}

isrecoilreducingweapon(var_00) {
  if(!isDefined(var_00) || var_00 == "none")
    return 0;

  var_01 = 0;

  if(issubstr(var_00, "l115a3scope") || issubstr(var_00, "l115a3vzscope") || issubstr(var_00, "usrscope") || issubstr(var_00, "usrvzscope"))
    var_01 = 1;

  return var_01;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"]))
    self.pers["recoilReduceKills"] = 0;

  return self.pers["recoilReduceKills"] * 3;
}

glprox_trygetweaponname(var_00) {
  if(var_00 != "none" && getweaponbasename(var_00) == "iw7_glprox_mp") {
    if(isaltmodeweapon(var_00)) {
      var_01 = getweaponattachments(var_00);
      var_00 = var_1[0];
    } else
      var_00 = getweaponbasename(var_00);
  }

  return var_00;
}

glprox_modifieddamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = var_00;
  var_04 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_04);

  if(!isplayer(var_02))
    return var_07;

  if(var_04 != "iw7_glprox_mp")
    return var_07;

  if(!isexplosivedamagemod(var_05))
    return var_07;

  var_08 = 2500;

  if(level.hardcoremode)
    var_08 = 11025;
  else if(level.tactical)
    var_08 = 9216;

  var_09 = 105;

  if(level.hardcoremode)
    var_09 = 35;
  else if(level.tactical)
    var_09 = 105;

  var_10 = 55;

  if(level.hardcoremode)
    var_10 = 25;
  else if(level.tactical)
    var_10 = 55;

  var_11 = undefined;
  var_12 = undefined;

  if(isDefined(var_06)) {
    var_11 = distancesquared(var_06, var_02 getEye());
    var_12 = distancesquared(var_06, var_2.origin);
  } else if(isDefined(var_03)) {
    var_11 = distancesquared(var_3.origin, var_02 getEye());
    var_12 = distancesquared(var_3.origin, var_2.origin);
  }

  if(isDefined(var_11) && var_11 <= var_08)
    var_07 = var_09;
  else if(isDefined(var_12) && var_12 <= var_08)
    var_07 = var_09;
  else
    var_07 = var_10;

  return var_07;
}

glprox_modifiedblastshieldconst(var_00, var_01) {
  if(level.hardcoremode) {
    if(scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_01) == "iw7_glprox_mp")
      var_00 = 0.65;
  }

  return var_00;
}

ishackweapon(var_00) {
  if(var_00 == "radar_mp" || var_00 == "airstrike_mp" || var_00 == "helicopter_mp")
    return 1;

  if(var_00 == "briefcase_bomb_mp")
    return 1;

  return 0;
}

func_9DF7(var_00) {
  var_00 = scripts\mp\utility\game::getweaponrootname(var_00);
  return var_00 == "iw7_fists";
}

func_9D6D(var_00) {
  return var_00 == "briefcase_bomb_mp" || var_00 == "briefcase_bomb_defuse_mp";
}

func_B4E0(var_00) {
  if(var_00 == "none")
    return 0;

  if(func_9DF7(var_00))
    return 0;

  if(func_9D6D(var_00))
    return 0;

  if(scripts\mp\powers::func_9F0A(var_00))
    return 0;

  if(issubstr(var_00, "ac130"))
    return 0;

  if(issubstr(var_00, "uav"))
    return 0;

  if(issubstr(var_00, "killstreak"))
    return 0;

  if(scripts\mp\utility\game::issuperweapon(var_00))
    return 0;

  var_01 = weaponinventorytype(var_00);

  if(var_01 != "primary")
    return 0;

  return 1;
}

dropweaponfordeath(var_00, var_01) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }
  if(isDefined(self.droppeddeathweapon)) {
    return;
  }
  if(isDefined(var_00) && var_00 == self || var_01 == "MOD_SUICIDE") {
    return;
  }
  var_02 = self.lastdroppableweaponobj;

  if(!isDefined(var_02)) {
    return;
  }
  if(var_02 == "none") {
    return;
  }
  if(!self hasweapon(var_02)) {
    return;
  }
  if(scripts\mp\utility\game::isjuggernaut()) {
    return;
  }
  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_02)) {
    return;
  }
  if(isaltmodeweapon(var_02))
    var_02 = scripts\mp\utility\game::func_E0CF(var_02);

  var_03 = 0;
  var_04 = 0;
  var_05 = 0;

  if(var_02 != "iw6_riotshield_mp") {
    if(!self anyammoforweaponmodes(var_02)) {
      return;
    }
    var_03 = self getweaponammoclip(var_02, "right");
    var_04 = self getweaponammoclip(var_02, "left");

    if(!var_03 && !var_04) {
      return;
    }
    var_05 = self getweaponammostock(var_02);
    var_06 = weaponmaxammo(var_02);

    if(var_05 > var_06)
      var_05 = var_06;

    var_07 = self dropitem(var_02);

    if(!isDefined(var_07)) {
      return;
    }
    var_07 itemweaponsetammo(var_03, var_05, var_04);
  } else {
    var_07 = self dropitem(var_02);

    if(!isDefined(var_07)) {
      return;
    }
    var_07 itemweaponsetammo(1, 1, 0);
  }

  self.droppeddeathweapon = 1;
  var_7.owner = self;
  var_7.targetname = "dropped_weapon";
  var_07 thread watchpickup();
  var_07 thread deletepickupafterawhile();
}

func_1175A(var_00, var_01, var_02, var_03) {
  self.owner endon("disconnect");

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  var_04 = self.origin;

  for(;;) {
    wait 0.25;

    if(!isDefined(self)) {
      return;
    }
    var_05 = self.origin;

    if(var_04 == var_05) {
      break;
    }
    var_04 = var_05;
  }

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(var_01 <= 0 && var_02 <= 0) {
    return;
  }
  var_06 = self.origin;
  var_07 = self.angles;
  var_08 = 2;
  var_09 = weaponfiretime(var_00) * var_08;

  while(isDefined(self) && (var_01 > 0 || var_02 > 0)) {
    var_10 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(0, 1));
    var_11 = var_10 * 180;
    var_12 = var_10 * 1000;
    self.origin = var_06 + (0, 0, 10);
    self.angles = var_11;
    thread scripts\mp\utility\game::drawline(self.origin, self.origin + var_12, 2, (0, 1, 0));
    thread func_1174C(self.origin, var_12, self.owner, var_00);
    wait(var_09);

    if(!isDefined(self)) {
      break;
    }
    var_01 = var_01 - var_08;
    var_02 = var_02 - var_08;

    if(var_01 <= 0)
      var_01 = 0;

    if(var_02 <= 0)
      var_02 = 0;

    self itemweaponsetammo(var_01, var_03, var_02);
  }

  if(!isDefined(self)) {
    return;
  }
  self.origin = var_06;
  self.angles = var_07;
}

func_1174C(var_00, var_01, var_02, var_03) {
  var_02 endon("disconnect");
  var_04 = var_00 + var_01;
  var_05 = scripts\mp\utility\game::_magicbullet(var_03, var_00, var_04, var_02);
}

func_1015B() {
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }
  var_00 = getitemweaponname();
  var_01 = getweaponbasename(var_00);
  var_02 = _meth_822A(var_01);

  switch (var_02) {
    case 4:
      playFXOnTag(scripts\engine\utility::getfx("item_fx_epic"), self, "j_gun");
      break;
    case 3:
      playFXOnTag(scripts\engine\utility::getfx("item_fx_legendary"), self, "j_gun");
      break;
    case 2:
      playFXOnTag(scripts\engine\utility::getfx("item_fx_rare"), self, "j_gun");
      break;
    case 1:
      playFXOnTag(scripts\engine\utility::getfx("item_fx_common"), self, "j_gun");
      break;
  }
}

_meth_822A(var_00) {
  if(!isDefined(var_00))
    return 0;

  var_01 = strtok(var_00, "_");

  foreach(var_03 in var_01) {
    switch (var_03) {
      case "mpe":
        return 4;
      case "mpl":
        return 3;
      case "mpr":
        return 2;
      case "mp":
        return 1;
    }
  }

  return 0;
}

detachifattached(var_00, var_01) {
  var_02 = self getattachsize();

  for(var_03 = 0; var_03 < var_02; var_3++) {
    var_04 = self getattachmodelname(var_03);

    if(var_04 != var_00) {
      continue;
    }
    var_05 = self getattachtagname(var_03);
    self detach(var_00, var_05);

    if(var_05 != var_01) {
      var_02 = self getattachsize();

      for(var_03 = 0; var_03 < var_02; var_3++) {
        var_05 = self getattachtagname(var_03);

        if(var_05 != var_01) {
          continue;
        }
        var_00 = self getattachmodelname(var_03);
        self detach(var_00, var_05);
        break;
      }
    }

    return 1;
  }

  return 0;
}

deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

getitemweaponname() {
  var_00 = self.classname;
  var_01 = getsubstr(var_00, 7);
  return var_01;
}

watchpickup() {
  self endon("death");
  var_00 = getitemweaponname();

  for(;;) {
    self waittill("trigger", var_01, var_02);
    var_03 = fixupplayerweapons(var_01, var_00);

    if(isDefined(var_02) || var_03) {
      break;
    }
  }

  if(isDefined(var_02)) {
    var_04 = var_02 getitemweaponname();

    if(isDefined(var_1.tookweaponfrom[var_04])) {
      var_2.owner = var_1.tookweaponfrom[var_04];
      var_1.tookweaponfrom[var_04] = undefined;
    }

    var_2.targetname = "dropped_weapon";
    var_02 thread watchpickup();
  }

  var_1.tookweaponfrom[var_00] = self.owner;
}

fixupplayerweapons(var_00, var_01) {
  var_02 = var_00 getweaponslistprimaries();
  var_03 = 1;
  var_04 = 1;

  foreach(var_06 in var_02) {
    if(var_0.primaryweapon == var_06) {
      var_03 = 0;
      continue;
    }

    if(var_0.secondaryweapon == var_06)
      var_04 = 0;
  }

  if(var_03)
    var_0.primaryweapon = var_01;
  else if(var_04)
    var_0.secondaryweapon = var_01;

  return var_03 || var_04;
}

itemremoveammofromaltmodes() {
  var_00 = getitemweaponname();
  var_01 = weaponaltweaponname(var_00);

  for(var_02 = 1; var_01 != "none" && var_01 != var_00; var_2++) {
    self itemweaponsetammo(0, 0, 0, var_02);
    var_01 = weaponaltweaponname(var_01);
  }
}

func_89DF(var_00, var_01) {
  self endon("death");
  level endon("game_ended");
  self waittill("scavenger", var_02);
  var_02 notify("scavenger_pickup");
  func_EBD2(var_02);
  scripts\mp\powers::func_EBD4(var_02);
  var_02 scripts\mp\damagefeedback::hudicontype("scavenger");
}

func_EBD2(var_00) {
  var_01 = var_00 getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(!scripts\mp\utility\game::iscacprimaryweapon(var_03) && !level.func_EBD0) {
      continue;
    }
    if(isaltmodeweapon(var_03) && weaponclass(var_03) == "grenade") {
      continue;
    }
    if(scripts\mp\utility\game::getweapongroup(var_03) == "weapon_projectile") {
      continue;
    }
    if(var_03 == "venomxgun_mp") {
      continue;
    }
    var_04 = var_00 getweaponammostock(var_03);
    var_05 = weaponclipsize(var_03);

    if(issubstr(var_03, "akimbo") && scripts\mp\utility\game::getweaponrootname(var_03) != "iw7_fmg")
      var_05 = var_05 * 2;

    var_00 setweaponammostock(var_03, var_04 + var_05);
  }
}

func_EBD3(var_00) {
  if(isDefined(var_0.powers)) {
    foreach(var_02 in var_0.powers) {
      var_00 notify("scavenged_ammo", var_2.weaponuse);
      scripts\engine\utility::waitframe();
    }
  }
}

dropscavengerfordeath(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  if(var_00 == self) {
    return;
  }
  var_02 = self dropscavengerbag("scavenger_bag_mp");

  if(!isDefined(var_02)) {
    return;
  }
  var_02 thread func_89DF(self, var_01);

  if(isDefined(level.bot_funcs["bots_add_scavenger_bag"]))
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var_02);
}

weaponcanstoreaccuracystats(var_00) {
  if(scripts\mp\utility\game::iscacmeleeweapon(var_00))
    return 0;

  return scripts\mp\utility\game::iscacprimaryweapon(var_00) || scripts\mp\utility\game::iscacsecondaryweapon(var_00);
}

setweaponstat(var_00, var_01, var_02) {
  scripts\mp\gamelogic::setweaponstat(var_00, var_01, var_02);
}

watchweaponusage(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_01);
    var_01 = self getcurrentweapon();
    thread scripts\mp\perks\weaponpassives::updateweaponpassivesonuse(self, var_01);
    scripts\mp\gamelogic::sethasdonecombat(self, 1);
    var_02 = gettime();

    if(!isDefined(self.lastshotfiredtime))
      self.lastshotfiredtime = 0;

    var_03 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_02;

    if(!issubstr(var_01, "silence") && var_03 > 500 && level.func_768F)
      thread scripts\mp\killstreaks\uplink::func_B37E();

    if(isai(self)) {
      continue;
    }
    if(!weaponcanstoreaccuracystats(var_01)) {
      continue;
    }
    var_04 = var_01;

    if(scripts\mp\perks\weaponpassives::doesshareammo(var_01))
      var_04 = scripts\mp\utility\game::func_E0CF(var_01);

    if(isDefined(self.hitsthismag[var_04]))
      thread hitsthismag_update(var_04);

    var_05 = scripts\mp\persistence::statgetbuffered("totalShots") + 1;
    var_06 = scripts\mp\persistence::statgetbuffered("hits");
    var_07 = clamp(float(var_06) / float(var_05), 0.0, 1.0) * 10000.0;
    scripts\mp\persistence::func_10E55("totalShots", var_05);
    scripts\mp\persistence::func_10E55("accuracy", int(var_07));
    scripts\mp\persistence::func_10E55("misses", int(var_05 - var_06));

    if(isDefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime()) {
      self.hits = 0;
      return;
    }

    var_08 = 1;
    setweaponstat(var_01, var_08, "shots");
    setweaponstat(var_01, self.hits, "hits");
    self.hits = 0;
  }
}

hitsthismag_init(var_00) {
  if(var_00 == "none") {
    return;
  }
  if((scripts\mp\utility\game::iscacprimaryweapon(var_00) || scripts\mp\utility\game::iscacsecondaryweapon(var_00)) && !isDefined(self.hitsthismag[var_00]))
    self.hitsthismag[var_00] = weaponclipsize(var_00);
}

hitsthismag_update(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("updateMagShots_" + var_00);
  self.hitsthismag[var_00]--;
  wait 0.05;
  self notify("shot_missed", var_00);
  self.consecutivehitsperweapon[var_00] = 0;
  self.hitsthismag[var_00] = weaponclipsize(var_00);
}

func_9046(var_00) {
  self endon("death");
  self endon("disconnect");
  self notify("updateMagShots_" + var_00);
  waittillframeend;

  if(isDefined(self.hitsthismag[var_00]) && self.hitsthismag[var_00] == 0) {
    var_01 = scripts\mp\utility\game::getweapongroup(var_00);
    scripts\mp\missions::processchallenge(var_01);
    self.hitsthismag[var_00] = weaponclipsize(var_00);
  }
}

func_3E1E(var_00, var_01) {
  self endon("disconnect");

  if(scripts\mp\utility\game::isstrstart(var_00, "alt_")) {
    var_02 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_00);

    if(scripts\engine\utility::array_contains(var_02, "shotgun") || scripts\engine\utility::array_contains(var_02, "gl"))
      self.hits = 1;
    else
      var_00 = getsubstr(var_00, 4);
  }

  if(!weaponcanstoreaccuracystats(var_00)) {
    return;
  }
  if(self meleebuttonpressed() && var_00 != "iw7_knife_mp") {
    return;
  }
  switch (weaponclass(var_00)) {
    case "smg":
    case "mg":
    case "rifle":
    case "sniper":
    case "pistol":
      self.hits++;
      break;
    case "spread":
      self.hits = 1;
      break;
    default:
      break;
  }

  if(isriotshield(var_00) || var_00 == "iw7_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_00, self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend;

  if(isDefined(self.hitsthismag[var_00]))
    thread func_9046(var_00);

  if(!isDefined(self.lasthittime[var_00]))
    self.lasthittime[var_00] = 0;

  if(self.lasthittime[var_00] == gettime()) {
    return;
  }
  self.lasthittime[var_00] = gettime();

  if(!isDefined(self.consecutivehitsperweapon) || !isDefined(self.consecutivehitsperweapon[var_00]))
    self.consecutivehitsperweapon[var_00] = 1;
  else
    self.consecutivehitsperweapon[var_00]++;

  var_03 = scripts\mp\persistence::statgetbuffered("totalShots");
  var_04 = scripts\mp\persistence::statgetbuffered("hits") + 1;

  if(var_04 <= var_03) {
    scripts\mp\persistence::func_10E55("hits", var_04);
    scripts\mp\persistence::func_10E55("misses", int(var_03 - var_04));
    var_05 = clamp(float(var_04) / float(var_03), 0.0, 1.0) * 10000.0;
    scripts\mp\persistence::func_10E55("accuracy", int(var_05));
  }

  thread scripts\mp\missions::func_C5A8(var_00);
  thread scripts\mp\contractchallenges::contractshotslanded(var_00);
  self.lastdamagetime = gettime();
  var_06 = scripts\mp\utility\game::getweapongroup(var_00);

  if(var_06 == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg))
      self.shotslandedlmg = 1;
    else
      self.shotslandedlmg++;
  }
}

func_24E2(var_00, var_01) {
  return friendlyfirecheck(var_01, var_00);
}

friendlyfirecheck(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00))
    return 1;

  if(!level.teambased)
    return 1;

  var_04 = level.friendlyfire;

  if(isDefined(var_02))
    var_04 = var_02;

  if(var_04 != 0)
    return 1;

  if(var_01 == var_00 || isDefined(var_1.owner) && var_1.owner == var_00)
    return 1;

  var_05 = undefined;

  if(isDefined(var_1.owner))
    var_05 = var_1.owner.team;
  else if(isDefined(var_1.team))
    var_05 = var_1.team;

  if(!isDefined(var_05))
    return 1;

  if(var_05 != var_0.team)
    return 1;

  return 0;
}

func_13A1F() {
  self notify("watchEquipmentOnSpawn");
  self endon("watchEquipmentOnSpawn");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");

  if(!isDefined(self.plantedlethalequip))
    self.plantedlethalequip = [];

  if(!isDefined(self.plantedtacticalequip))
    self.plantedtacticalequip = [];

  deletedisparateplacedequipment();
  var_00 = scripts\mp\utility\game::getintproperty("scr_deleteexplosivesonspawn", 1) && (!scripts\mp\utility\game::_hasperk("specialty_rugged_eqp") || !checkequipforrugged());

  if(var_00)
    func_51CE();

  var_01 = self.plantedtacticalequip.size;
  var_02 = self.plantedlethalequip.size;
  var_03 = var_01 && var_02;

  if(scripts\mp\utility\game::_hasperk("specialty_rugged_eqp") && var_03)
    thread scripts\mp\perks\perkfunctions::feedbackruggedeqp(var_02, var_01);
}

checkequipforrugged() {
  var_00 = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);

  foreach(var_02 in var_00) {
    if(isDefined(var_2.hasruggedeqp))
      return 1;
  }

  return 0;
}

watchgrenadeusage() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;)
    watchgrenadethrows();
}

watchgrenadethrows() {
  var_00 = scripts\mp\utility\game::func_1377B();

  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  setweaponstat(var_0.weapon_name, 1, "shots");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(isDefined(level.func_2C46[var_0.weapon_name]))
    var_00 thread createbombsquadmodel(level.func_2C46[var_0.weapon_name].model, level.func_2C46[var_0.weapon_name].tag, self);

  if(getweaponbasename(var_0.weapon_name) == "iw7_glprox_mp") {
    var_01 = glprox_trygetweaponname(var_0.weapon_name);

    if(var_01 == "stickglprox")
      semtexused(var_00);

    return;
  }

  if(isaxeweapon(var_0.weapon_name)) {
    var_0.func_FF03 = self isinphase();
    var_00 thread watchgrenadeaxepickup(self);
    return;
  }

  switch (var_0.weapon_name) {
    case "frag_grenade_mp":
      if(var_0.ticks >= 1)
        var_0.iscooked = 1;

      var_0.originalowner = self;
      var_00 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "cluster_grenade_mp":
      var_0.clusterticks = var_0.ticks;

      if(var_0.ticks >= 1)
        var_0.iscooked = 1;

      var_0.originalowner = self;
      thread clustergrenadeused(var_00);
      var_00 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "wristrocket_mp":
      if(var_0.ticks >= 1)
        var_0.iscooked = 1;

      var_0.originalowner = self;
      thread scripts\mp\equipment\wrist_rocket::wristrocketused(var_00);
      var_00 thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;
    case "iw6_aliendlc22_mp":
      var_00 thread scripts\mp\shellshock::grenade_earthquake();
      var_0.originalowner = self;
      break;
    case "semtex_mp":
      thread semtexused(var_00);
      break;
    case "cryo_mine_mp":
      thread scripts\mp\equipment\cryo_mine::func_4ADA(var_00);
      break;
    case "c4_mp":
      thread scripts\mp\equipment\c4::c4_used(var_00);
      break;
    case "proximity_explosive_mp":
      thread func_DACD(var_00);
      break;
    case "flash_grenade_mp":
      var_0.func_BFD5 = var_0.ticks;

      if(var_0.ticks >= 1)
        var_0.iscooked = 1;

      var_00 thread func_BFD3();
      break;
    case "throwingknifedisruptor_mp":
      thread func_56E6(var_00);
      break;
    case "smoke_grenadejugg_mp":
    case "smoke_grenade_mp":
      var_00 thread func_1037B();
      break;
    case "gas_grenade_mp":
      var_00 thread watchgasgrenadeexplode();
      break;
    case "concussion_grenade_mp":
      thread scripts\mp\concussion::func_44EE(var_00);
      break;
    case "alientrophy_mp":
    case "trophy_mp":
      thread scripts\mp\trophy_system::func_12827(var_00);
      break;
    case "claymore_mp":
      thread claymoreused(var_00);
      break;
    case "alienbetty_mp":
    case "bouncingbetty_mp":
      thread mineused(var_00, ::spawnmine);
      break;
    case "motion_sensor_mp":
      thread mineused(var_00, ::func_108E7);
      break;
    case "mobile_radar_mp":
      thread mineused(var_00, ::func_108E5);
      break;
    case "distortionfield_grenade_mp":
      var_00 thread func_139F5();
      break;
    case "throwingknifejugg_mp":
    case "throwingknifehack_mp":
    case "throwingknifesiphon_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifeteleport_mp":
    case "throwingknife_mp":
    case "throwingknifec4_mp":
      level thread throwingknifeused(self, var_00, var_0.weapon_name);
      break;
    case "sensor_grenade_mp":
      break;
    case "sonic_sensor_mp":
      thread mineused(var_00, ::func_10910);
      break;
    case "proto_ricochet_device_mp":
      thread scripts\mp\protoricochet::func_E4E9(var_00);
      break;
    case "proxy_bomb_mp":
      thread func_DAD5(self, var_00);
      break;
    case "disc_marker_mp":
      thread func_562B(self, var_00);
      break;
    case "adrenaline_mist_mp":
      break;
    case "case_bomb_mp":
      thread func_3B0E(self, var_00);
      break;
    case "domeshield_mp":
      thread scripts\mp\domeshield::func_5910(var_00);
      break;
    case "blackhole_grenade_mp":
      thread scripts\mp\blackhole_grenade::blackholegrenadeused(var_00);
      break;
    case "portal_grenade_mp":
      break;
    case "copycat_grenade_mp":
      break;
    case "speed_strip_mp":
      break;
    case "shard_ball_mp":
      if(scripts\mp\powerloot::func_D779(var_0.power, "passive_grenade_to_mine"))
        thread mineused(var_00, ::func_1090D, scripts\mp\shardball::placementfailed);
      else
        thread scripts\mp\shardball::func_FC5B(var_00);

      break;
    case "splash_grenade_mp":
      var_00 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\splashgrenade::splashgrenadeused(var_00);
      break;
    case "forcepush_mp":
      break;
    case "portal_generator_mp":
      break;
    case "transponder_mp":
      break;
    case "throwingreaper_mp":
      break;
    case "pulse_grenade_mp":
      thread scripts\mp\equipment\pulse_grenade::func_DAF5(var_00);
      break;
    case "ammo_box_mp":
      break;
    case "virus_grenade_mp":
      break;
    case "fear_grenade_mp":
      thread mineused(var_00, ::func_10884);
      break;
    case "deployable_cover_mp":
      break;
    case "power_spider_grenade_mp":
      thread scripts\mp\equipment\spider_grenade::spidergrenade_used(var_00);
      break;
    case "split_grenade_mp":
      thread scripts\mp\equipment\split_grenade::func_10A54(var_00);
      break;
    case "trip_mine_mp":
      thread scripts\mp\equipment\trip_mine::tripmine_used(var_00);
      break;
    case "power_exploding_drone_mp":
      thread scripts\mp\equipment\exploding_drone::func_69D4(var_00);
      break;
  }
}

func_562B(var_00, var_01) {
  var_01 waittill("missile_stuck");
  var_00 notify("markerPlanted", var_01);
}

func_3B0E(var_00, var_01, var_02) {
  level endon("game_ended");
  var_01 endon("death");
  var_01 waittill("missile_stuck");

  if(!isDefined(var_1.origin))
    return;
}

func_3B0D(var_00, var_01) {
  level endon("game_ended");
  wait 0.05;
  var_02 = var_00 _meth_8113();
  wait(randomfloatrange(0.5, 0.8));

  if(!isDefined(var_02)) {
    return;
  }
  var_03 = var_2.origin;
  self playSound("frag_grenade_explode");
  earthquake(0.5, 1.5, var_03, 120);
  playFX(level._effect["case_bomb"], var_03 + (0, 0, 12));
  thread scripts\mp\utility\game::func_13AF(var_03, 256, 400, 50, self, "MOD_EXPLOSIVE", "case_bomb_mp", 0);
  wait 0.1;
  playFX(level._effect["corpse_pop"], var_03 + (0, 0, 12));

  if(isDefined(var_02))
    var_02 hide();
}

func_DAD5(var_00, var_01) {
  level endon("game_ended");
  var_01 endon("death");
  var_01 waittill("missile_stuck", var_02);

  if(isDefined(var_02) && (isplayer(var_02) || isagent(var_02)))
    var_01 detonate(var_00);
}

throwingknifeused(var_00, var_01, var_02) {
  var_01 makeunusable();

  if(var_02 == "throwingknifehack_mp") {} else if(var_02 == "throwingknifec4_mp")
    var_01 thread recordthrowingknifetraveldist();

  var_03 = undefined;
  var_04 = undefined;

  if(var_02 == "throwingknifesmokewall_mp") {
    var_01 func_1181E(var_00);
    return;
  } else
    var_01 waittill("missile_stuck", var_03, var_04);

  var_05 = isDefined(var_04) && var_04 == "tag_flicker";
  var_06 = isDefined(var_04) && var_04 == "tag_weapon";

  if(isDefined(var_03) && (isplayer(var_03) || isagent(var_03)) && var_05)
    var_03 notify("shield_hit", var_01);

  if(isDefined(var_03) && (isplayer(var_03) || isagent(var_03)) && !var_06 && !var_05) {
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_03, var_01)) {
      var_01 delete();
      return;
    } else if(var_02 == "throwingknifeteleport_mp") {} else if(var_02 == "throwingknifec4_mp")
      throwingknifec4detonate(var_01, var_03, var_00);
    else if(var_02 == "throwingknifesiphon_mp") {
      scripts\mp\equipment\siphon_knife::func_1181D(var_01, var_03, var_00);
      return;
    } else if(var_02 == "throwingknifehack_mp")
      return;
  }

  thread func_11825(var_00, var_01);
  var_01 endon("death");
  var_01 makeunusable();
  var_07 = spawn("trigger_radius", var_1.origin, 0, 64, 64);
  var_07 getrankxp();
  var_07 linkto(var_01);
  var_7.targetname = "dropped_knife";
  var_1.knife_trigger = var_07;
  var_01 thread watchgrenadedeath();

  for(;;) {
    scripts\engine\utility::waitframe();

    if(!isDefined(var_07)) {
      return;
    }
    var_07 waittill("trigger", var_08);

    if(!isplayer(var_08) || !scripts\mp\utility\game::isreallyalive(var_08)) {
      continue;
    }
    if(!var_08 hasweapon(var_02)) {
      continue;
    }
    if(throwingknifeused_trygiveknife(var_08, var_1.power)) {
      var_01 delete();
      break;
    }
  }
}

recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.disttravelled = 0;
  var_00 = self.origin;

  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_timeout(0.15, "death", "missile_stuck");

    if(!isDefined(self)) {
      break;
    }
    var_02 = distance(var_00, self.origin);
    self.disttravelled = self.disttravelled + var_02;
    var_00 = self.origin;

    if(var_01 != "timeout") {
      break;
    }
  }
}

func_11825(var_00, var_01) {
  var_02 = scripts\mp\utility\game::outlineenableforplayer(var_01, "white", var_00, 1, 0, "equipment");
  var_01 waittill("death");
  scripts\mp\utility\game::outlinedisable(var_02, var_01);
}

throwingknifeused_trygiveknife(var_00, var_01) {
  if(var_00 scripts\mp\powers::func_D734(var_01) == var_00 scripts\mp\powers::func_D736(var_01))
    return 0;

  var_00 scripts\mp\powers::func_D74C(var_01);
  var_00 scripts\mp\hud_message::showmiscmessage("throwingknife");
  return 1;
}

throwingknife_detachknivesfromcorpse(var_00) {
  var_01 = var_00 getlinkedchildren();

  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_04 = var_3.weapon_name;

    if(isDefined(var_04) && func_9FA9(var_04)) {
      var_03 unlink();
      var_05 = throwingknife_getdudknifeweapon(var_04);
      var_03 = var_3.owner scripts\mp\utility\game::_launchgrenade(var_05, var_3.origin, (0, 0, 0), 100, 1, var_03);

      if(isDefined(var_3.owner))
        var_03 setentityowner(var_3.owner);

      thread throwingknife_triggerlinkto(var_03);
      var_03 _meth_85AE();
    }
  }
}

throwingknife_triggerlinkto(var_00) {
  var_00 endon("death");

  while(!isDefined(var_0.knife_trigger))
    scripts\engine\utility::waitframe();

  var_01 = var_0.knife_trigger;
  var_01 endon("death");
  var_01 unlink();
  throwingknife_triggerlinktointernal(var_01, var_00);
  var_01 dontinterpolate();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_01 linkto(var_00);
}

throwingknife_triggerlinktointernal(var_00, var_01) {
  var_01 endon("missile_stuck");

  for(;;) {
    var_0.origin = var_1.origin;
    scripts\engine\utility::waitframe();
  }
}

throwingknife_getdudknifeweapon(var_00) {
  var_01 = undefined;

  switch (var_00) {
    case "throwingknifec4_mp":
      var_01 = "throwingknifec4dud_mp";
      break;
    case "throwingknifeteleport_mp":
      var_01 = "throwingknifeteleportdud_mp";
      break;
    default:
      var_01 = "throwingknifec4dud_mp";
  }

  return var_01;
}

throwingknifec4init() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx\iw7\_requests\mp\power\vfx_bio_spike_exp.vfx");
}

throwingknifec4detonate(var_00, var_01, var_02) {
  scripts\mp\missions::func_2AEA(var_00, var_02, var_01);
  var_01 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var_0.origin);
  var_00 radiusdamage(var_0.origin, 180, 140, 70, var_02, "MOD_EXPLOSIVE", var_0.weapon_name);
  var_00 thread scripts\mp\shellshock::grenade_earthquake();
  var_00 notify("explode", var_0.origin);
}

func_1181E(var_00) {
  var_00 thread scripts\mp\equipment\smoke_wall::func_1037D(self);
}

func_F235(var_00, var_01, var_02) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_03 = spawnStruct();
  var_3.func_C78B = [];
  var_04 = 0;
  thread func_F233(var_00, var_01);

  while(isDefined(var_01)) {
    foreach(var_06 in level.characters) {
      if(!isDefined(var_06)) {
        continue;
      }
      if(!var_00 scripts\mp\utility\game::isenemy(var_06)) {
        continue;
      }
      if(var_06 scripts\mp\utility\game::_hasperk("specialty_incog")) {
        continue;
      }
      if(isDefined(var_3.func_C78B[var_06 getentitynumber()])) {
        continue;
      }
      if(distancesquared(var_1.origin, var_6.origin) > 90000) {
        continue;
      }
      var_3.func_C78B[var_06 getentitynumber()] = var_06;
      thread func_F234(var_00, var_06, var_03);
    }

    scripts\engine\utility::waitframe();
  }
}

func_10413(var_00, var_01, var_02) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_01 endon("death");
  var_03 = spawnStruct();
  var_3.func_C78B = [];
  var_04 = 0;
  thread func_F233(var_00, var_01);

  while(isDefined(var_01)) {
    foreach(var_06 in level.characters) {
      if(!isDefined(var_06)) {
        continue;
      }
      if(!var_00 scripts\mp\utility\game::isenemy(var_06)) {
        continue;
      }
      if(var_06 scripts\mp\utility\game::_hasperk("specialty_quieter")) {
        continue;
      }
      if(isDefined(var_3.func_C78B[var_06 getentitynumber()])) {
        continue;
      }
      if(distancesquared(var_1.origin, var_6.origin) > 90000) {
        continue;
      }
      var_07 = scripts\engine\utility::add_to_array(level.players, var_01);

      if(!scripts\engine\trace::ray_trace_passed(var_1.origin, var_6.origin + (0, 0, 32), var_07)) {
        continue;
      }
      var_3.func_C78B[var_06 getentitynumber()] = var_06;
      thread func_F234(var_00, var_06, var_03);
    }

    wait 2.0;
  }
}

func_F233(var_00, var_01) {
  var_01 endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");
  scripts\engine\utility::waitframe();
  scripts\mp\utility\game::outlineenableforplayer(var_01, "cyan", var_00, 0, 0, "equipment");

  if(var_1.weapon_name == "sonic_sensor_mp")
    playFXOnTag(scripts\engine\utility::getfx("vfx_sonic_sensor_pulse"), var_01, "tag_origin");
  else
    playfxontagforclients(scripts\engine\utility::getfx("vfx_sensor_grenade_ping"), var_01, "tag_origin", var_00);
}

func_F234(var_00, var_01, var_02) {
  var_00 endon("disconnect");
  var_03 = var_01 getentitynumber();
  var_04 = undefined;
  var_01 scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  var_04 = scripts\mp\utility\game::outlineenableforplayer(var_01, "orange", var_00, 0, 0, "equipment");
  wait 0.5;

  if(isDefined(var_01) && isDefined(var_04))
    scripts\mp\utility\game::outlinedisable(var_04, var_01);

  var_2.func_C78B[var_03] = undefined;
}

watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();

  if(isDefined(self.useobj_trigger))
    self.useobj_trigger delete();
}

func_1037B() {
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_00);
  thread func_10377(var_00);

  if(isDefined(self.owner))
    self.owner thread monitorsmokeactive();
}

func_10377(var_00) {
  wait 1;
  thread smokegrenadegiveblindeye(var_00);
  var_01 = scripts\mp\utility\game::func_180C(var_00, 200);
  wait 8.25;
  scripts\mp\utility\game::func_E14A(var_01);
}

smokegrenadegiveblindeye(var_00) {
  var_01 = spawnStruct();
  var_1.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(var_01, var_00);

  foreach(var_03 in var_1.blindeyerecipients) {
    if(isDefined(var_03) && scripts\mp\utility\game::isreallyalive(var_03))
      var_03 scripts\mp\utility\game::removeperk("specialty_blindeye");
  }
}

smokegrenademonitorblindeyerecipients(var_00, var_01) {
  level endon("game_ended");
  var_02 = gettime() + 8250.0;
  var_03 = [];

  while(gettime() < var_02) {
    var_03 = scripts\mp\utility\game::clearscrambler(var_01, 200);

    foreach(var_07, var_05 in var_0.blindeyerecipients) {
      if(!isDefined(var_05)) {
        var_0.blindeyerecipients[var_07] = undefined;
        continue;
      }

      var_06 = scripts\engine\utility::array_find(var_03, var_05);

      if(!isDefined(var_06) || !scripts\mp\utility\game::isreallyalive(var_05) || scripts\mp\equipment\phase_shift::isentityphaseshifted(var_05)) {
        var_05 scripts\mp\utility\game::removeperk("specialty_blindeye");
        var_0.blindeyerecipients[var_07] = undefined;
      }

      if(isDefined(var_06))
        var_3[var_06] = undefined;
    }

    foreach(var_09 in var_03) {
      if(!isDefined(var_09)) {
        continue;
      }
      if(isDefined(var_0.blindeyerecipients[var_09 getentitynumber()])) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_09) || scripts\mp\equipment\phase_shift::isentityphaseshifted(var_09) || scripts\mp\utility\game::func_9F72(var_09)) {
        continue;
      }
      var_09 scripts\mp\utility\game::giveperk("specialty_blindeye");
      var_0.blindeyerecipients[var_09 getentitynumber()] = var_09;
    }

    scripts\engine\utility::waitframe();
  }
}

monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\mp\utility\game::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  var_00 = scripts\engine\utility::waittill_any_timeout(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility\game::printgameaction("smoke grenade deactivated", self);
}

watchgasgrenadeexplode() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self waittill("explode", var_01);
  thread ongasgrenadeimpact(var_00, var_01);
}

ongasgrenadeimpact(var_00, var_01) {
  var_02 = spawn("trigger_radius", var_01, 0, 128, 160);
  var_2.owner = var_00;
  var_03 = 128;
  var_04 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), var_01);
  triggerfx(var_04);
  wait 1.0;
  var_05 = 3.0;
  var_06 = spawn("script_model", var_01 + (0, 0, 60));
  var_06 linkto(var_02);

  for(var_2.killcament = var_06; var_05 > 0.0; var_05 = var_05 - 0.2) {
    foreach(var_08 in level.characters)
    var_08 applygaseffect(var_00, var_01, var_02, var_02, 4);

    wait 0.2;
  }

  var_04 delete();
  wait 2.0;
  var_06 delete();
  var_02 delete();
}

applygaseffect(var_00, var_01, var_02, var_03, var_04) {
  if(isalive(self) && self istouching(var_02)) {
    if(var_00 scripts\mp\utility\game::isenemy(self) || self == var_00)
      var_03 radiusdamage(self.origin, 1, var_04, var_04, var_00, "MOD_RIFLE_BULLET", "gas_grenade_mp");
  }
}

func_AF2B(var_00) {
  var_01 = [];

  if(level.teambased) {
    if(isDefined(var_00) && var_00 == 1) {
      foreach(var_03 in level.characters) {
        if(isDefined(var_03) && isalive(var_03) && var_3.team != self.team)
          var_1[var_1.size] = var_03;
      }
    }

    if(isDefined(level.func_1655)) {
      foreach(var_06 in level.func_1655) {
        if(isDefined(var_6.func_18DE) && var_6.team != self.team)
          var_1[var_1.size] = var_06;
      }
    }

    if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
      foreach(var_09 in level.supertrophy.trophies) {
        if(isDefined(var_09) && isDefined(var_9.team) && var_9.team != self.team)
          var_1[var_1.size] = var_09;
      }
    }

    if(isDefined(level.microturrets)) {
      foreach(var_12 in level.microturrets) {
        if(isDefined(var_12) && isDefined(var_12.team) && var_12.team != self.team)
          var_1[var_1.size] = var_12;
      }
    }
  } else {
    if(isDefined(var_00) && var_00 == 1) {
      foreach(var_03 in level.characters) {
        if(!isDefined(var_03) || !isalive(var_03)) {
          continue;
        }
        var_1[var_1.size] = var_03;
      }
    }

    if(isDefined(level.func_1655)) {
      foreach(var_06 in level.func_1655) {
        if(isDefined(var_6.func_18DE) && isDefined(var_6.owner) && var_6.owner != self)
          var_1[var_1.size] = var_06;
      }
    }

    if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
      foreach(var_09 in level.supertrophy.trophies) {
        if(isDefined(var_09) && isDefined(var_9.owner) && var_9.owner != self)
          var_1[var_1.size] = var_09;
      }
    }

    if(isDefined(level.microturrets)) {
      foreach(var_12 in level.microturrets) {
        if(isDefined(var_12) && isDefined(var_12.owner) && var_12.owner != self)
          var_1[var_1.size] = var_12;
      }
    }
  }

  return var_01;
}

watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    var_00 = scripts\mp\utility\game::waittill_missile_fire();

    if(!isDefined(var_00)) {
      continue;
    }
    switch (var_0.weapon_name) {
      case "stinger_mp":
      case "iw7_lockon_mp":
        level notify("stinger_fired", self, var_00, self.func_10FAA);
        break;
      case "javelin_mp":
      case "lasedStrike_missile_mp":
      case "remote_mortar_missile_mp":
        level notify("stinger_fired", self, var_00, self.func_A445);
        break;
      case "iw7_blackholegun_mp":
        thread scripts\mp\supers\super_blackholegun::missilespawned(var_0.weapon_name, var_00);
        break;
      case "iw7_unsalmg_mp":
      case "iw7_unsalmg_mpl":
        var_0.weapon_name = "power_smoke_drone_mp";
        thread scripts\mp\equipment\exploding_drone::func_69D4(var_00, 1);
        break;
      case "iw7_tacburst_mpl":
      case "iw7_tacburst_mp":
        var_00 thread scripts\mp\emp_debuff_mp::func_13A12();
        break;
      default:
        break;
    }

    if(isplayer(self))
      var_0.adsfire = scripts\mp\utility\game::func_9EE8();

    if(isexplosivemissile(var_0.weapon_name)) {
      var_01 = 1.0;

      if(func_9F5C(var_0.weapon_name))
        var_01 = 0.65;

      var_00 thread scripts\mp\shellshock::grenade_earthquake(var_01);
    }

    var_0.func_FF03 = self isinphase();
  }
}

func_9F5C(var_00) {
  var_00 = getweaponbasename(var_00);
  var_01 = 0;

  switch (var_00) {
    case "iw7_glprox_mp":
      var_01 = 1;
      break;
    default:
      break;
  }

  return var_01;
}

isexplosivemissile(var_00) {
  var_00 = getweaponbasename(var_00);

  switch (var_00) {
    case "iw7_cheytac_mpr_projectile":
    case "wristrocket_proj_mp":
      return 0;
  }

  return 1;
}

func_13B38() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sentry_placement_finished", var_00);
    thread scripts\mp\utility\game::setaltsceneobj(var_00, "tag_flash", 65);
  }
}

func_42D8(var_00) {
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_01);
}

clustergrenadeused(var_00) {
  if(isalive(self)) {
    var_01 = anglesToForward(self _meth_857C()) * 940;
    var_02 = (0, 0, 120);
    var_03 = var_01 + var_02;
  } else {
    var_01 = anglesToForward(self _meth_857C()) * 50;
    var_02 = (0, 0, 10);
    var_03 = var_01 + var_02;
  }

  var_00 = scripts\mp\utility\game::_launchgrenade("cluster_grenade_mp", var_0.origin, var_03, 100, 1, var_00);
  var_00 thread func_4107();
  thread func_42DF(var_00);
}

func_42DF(var_00, var_01) {
  var_00 endon("death");
  self endon("disconnect");
  var_02 = (1 - var_0.tickpercent) * 3.5;
  wait(var_02);
  thread clustergrenadeexplode(var_00);
}

clustergrenadeexplode(var_00) {
  var_00 notify("death");
  var_0.exploding = 1;
  var_0.origin = var_0.origin;
  var_01 = spawn("script_model", var_0.origin);
  var_01 setotherent(var_0.owner);
  var_01 setModel("prop_mp_cluster_grenade_scr");
  func_42DB(var_00, var_01);

  if(isDefined(var_00))
    var_00 forcehidegrenadehudwarning(1);

  wait 2;

  if(isDefined(var_01))
    var_01 delete();

  if(isDefined(var_00))
    var_00 delete();
}

func_42DB(var_00, var_01) {
  self endon("disconnect");
  scripts\mp\utility\game::printgameaction("cluster grenade explode", self);
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_03 = var_0.origin;
  var_04 = 0;
  var_05 = var_03 + (0, 0, 3);
  var_06 = var_05 + (0, 0, -5);
  var_07 = physics_raycast(var_05, var_06, var_02, undefined, 0, "physicsquery_closest");

  if(isDefined(var_07) && var_7.size > 0)
    var_04 = 1;

  var_08 = scripts\engine\utility::ter_op(var_04, (0, 0, 32), (0, 0, 2));
  var_09 = var_03 + var_08;
  var_10 = randomint(90) - 45;
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0);

  for(var_11 = 0; var_11 < 4; var_11++) {
    var_12 = "explode" + (var_11 + 1);
    var_00 setscriptablepartstate(var_12, "active", 0);
    var_13 = scripts\engine\utility::ter_op(var_11 < 4, 90 * var_11 + var_10, randomint(360));
    var_14 = scripts\engine\utility::ter_op(var_04, 110, 90);
    var_15 = scripts\engine\utility::ter_op(var_04, 12, 45);
    var_16 = var_14 + randomint(var_15 * 2) - var_15;
    var_17 = randomint(60) + 30;
    var_18 = cos(var_13) * sin(var_16);
    var_19 = sin(var_13) * sin(var_16);
    var_20 = cos(var_16);
    var_21 = (var_18, var_19, var_20) * var_17;
    var_05 = var_09;
    var_06 = var_09 + var_21;
    var_07 = physics_raycast(var_05, var_06, var_02, undefined, 0, "physicsquery_closest");

    if(isDefined(var_07) && var_7.size > 0)
      var_06 = var_7[0]["position"];

    var_01 dontinterpolate();
    var_1.origin = var_06;
    var_01 setscriptablepartstate(var_12, "active", 0);
    wait 0.175;
  }
}

func_4107() {
  self endon("death");
  self.owner waittill("disconnect");
  self delete();
}

func_10D85(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(!isDefined(var_04)) {
    return;
  }
  if(var_06) {
    var_11 = spawnfx(var_07, self.origin);
    playLoopSound(self.origin, var_08);
    triggerfx(var_11);
    wait 2;
    var_11 delete();
  } else
    wait(var_00);

  if(!isDefined(var_04)) {
    return;
  }
  radiusdamage(self.origin + (0, 0, 50), var_01, var_02, var_03, var_04, "MOD_EXPLOSIVE", var_10);
  playFX(var_05, self.origin + (0, 0, 50));
  playLoopSound(self.origin, var_09);
  self delete();
}

func_BFD3() {
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_00);
  thread func_5925(var_00, self.owner, self.func_BFD5);
  func_BFD2(var_00, self.owner, self.func_BFD5);
}

func_BFD2(var_00, var_01, var_02) {
  if(var_02 >= 5 || func_CBED(var_01, var_02)) {
    playLoopSound(var_00, "emp_grenade_explode_default");
    var_03 = getempdamageents(var_00, 512, 0, undefined);

    foreach(var_05 in var_03) {
      if(isDefined(var_5.owner) && !friendlyfirecheck(var_01, var_5.owner)) {
        continue;
      }
      var_05 notify("emp_damage", self.owner, 8.0);
    }
  }
}

func_CBED(var_00, var_01) {
  if(var_00 scripts\mp\utility\game::_hasperk("specialty_pitcher")) {
    if(var_01 >= 4)
      return 1;
  }

  return 0;
}

func_5925(var_00, var_01, var_02) {
  level endon("game_ended");
  var_03 = level.weaponconfigs[self.weapon_name];
  wait(randomfloatrange(0.25, 0.5));

  for(var_04 = 1; var_04 < var_02; var_4++) {
    var_05 = func_7FF0(var_00, var_3.vfxradius);
    playLoopSound(var_05, var_3.onexplodesfx);
    playFX(var_3.onexplodevfx, var_05);

    foreach(var_07 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_07) || var_7.sessionstate != "playing") {
        continue;
      }
      var_08 = var_07 getEye();
      var_09 = distancesquared(var_00, var_08);

      if(var_09 > var_3.radius_max_sq) {
        continue;
      }
      if(!bullettracepassed(var_00, var_08, 0, var_07)) {
        continue;
      }
      if(var_09 <= var_3.radius_min_sq)
        var_10 = 1.0;
      else
        var_10 = 1.0 - (var_09 - var_3.radius_min_sq) / (var_3.radius_max_sq - var_3.radius_min_sq);

      var_11 = anglesToForward(var_07 getplayerangles());
      var_12 = var_00 - var_08;
      var_12 = vectornormalize(var_12);
      var_13 = 0.5 * (1.0 + vectordot(var_11, var_12));
      var_14 = 1;
      var_07 notify("flashbang", var_00, var_10, var_13, var_01, var_14);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

func_7FF0(var_00, var_01) {
  var_02 = (randomfloatrange(-1.0 * var_01, var_01), randomfloatrange(-1.0 * var_01, var_01), 0);
  var_03 = var_00 + var_02;
  var_04 = bulletTrace(var_00, var_03, 0, self, 0, 0, 0, 0, 0);

  if(var_4["fraction"] < 1)
    var_03 = var_00 + var_4["fraction"] * var_02;

  return var_03;
}

func_56E6(var_00) {
  var_00 waittill("missile_stuck", var_01);
  var_00 thread func_56E5(self, 1);
}

func_56E5(var_00, var_01) {
  level endon("game_ended");
  var_02 = level.weaponconfigs[self.weapon_name];
  playFX(var_2.func_C523, self.origin);

  for(var_03 = 0; var_03 < var_01; var_3++) {
    foreach(var_05 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_05) || var_5.sessionstate != "playing") {
        continue;
      }
      if(var_5.team == self.owner.team) {
        continue;
      }
      if(var_05 == self.owner) {
        continue;
      }
      var_06 = var_05 getEye();

      if(!scripts\engine\trace::ray_trace_passed(self.origin, var_06, level.players)) {
        continue;
      }
      thread func_56E4(var_05, var_00, var_02, var_06);
    }

    wait 0.75;
    playLoopSound(self.origin, var_2.onexplodesfx);
    playFX(var_2.onexplodevfx, self.origin);
  }

  self delete();
}

func_56E4(var_00, var_01, var_02, var_03) {
  var_04 = self.origin;
  var_05 = anglesToForward(var_00 getplayerangles());
  var_06 = var_04 - var_03;
  var_07 = vectornormalize(var_06);
  playFX(var_2.func_D828, var_04, rotatevector(var_06, (0, 180, 0)) * (1, 1, -1));
  wait 0.75;

  if(var_00 adsbuttonpressed() && var_00 worldpointinreticle_circle(var_04, 65, 300))
    var_00 shellshock("disruptor_mp", 2.5, 0, 1);
  else {
    var_08 = distancesquared(var_04, var_03);

    if(var_08 < var_2.radius_max_sq) {
      if(var_08 <= var_2.radius_min_sq)
        var_09 = 1.0;
      else
        var_09 = 1.0 - (var_08 - var_2.radius_min_sq) / (var_2.radius_max_sq - var_2.radius_min_sq);

      var_10 = 0.65 * (1.0 + vectordot(var_05, var_07));
      var_11 = 1;
      var_00 notify("flashbang", var_04, var_09, var_10, var_01, var_11);
    }
  }
}

c4used(var_00) {
  if(!scripts\mp\utility\game::isreallyalive(self)) {
    var_00 delete();
    return;
  }

  self notify("c4_update", 0);
  var_00 thread ondetonateexplosive();
  thread watchc4detonation();
  thread watchc4altdetonation();
  thread watchc4altdetonate();
  var_00 setotherent(self);
  var_0.activated = 0;
  onlethalequipmentplanted(var_00, "power_c4");
  var_01 = level.weaponconfigs["c4_mp"];
  var_00 thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  var_00 thread scripts\mp\shellshock::c4_earthquake();
  var_00 thread c4activate();
  var_00 thread func_3343();
  var_00 thread func_66B4(1);
  var_00 thread watchc4stuck();
  level thread monitordisownedequipment(self, var_00);
}

watchc4implode() {
  self.owner endon("disconnect");
  var_00 = self.owner;
  var_01 = scripts\engine\utility::spawn_tag_origin();
  var_01 linkto(self);
  thread func_334D(var_01);
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_02);
  thread c4implode(var_02, var_00, var_01);
}

c4implode(var_00, var_01, var_02) {
  var_01 endon("disconnect");
  wait 0.5;
  var_02 radiusdamage(var_00, 256, 140, 70, var_01, "MOD_EXPLOSIVE", "c4_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(var_00);
}

func_334D(var_00) {
  var_00 endon("death");
  self waittill("death");
  wait 1;
  var_00 delete();
}

movingplatformdetonate(var_00) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision)
    self notify("detonateExplosive");
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck", var_00);
  self give_player_tickets(1);
  self.c4stuck = 1;
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  thread outlineequipmentforowner(self, self.owner);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", self.owner, 1);
  explosivehandlemovers(var_00);
  makeexplosiveusable();
}

c4empdamage() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("disabled");
    wait(var_01);
    self.disabled = undefined;
    self notify("enabled");
  }
}

func_DACD(var_00) {
  if(!scripts\mp\utility\game::isreallyalive(self)) {
    var_00 delete();
    return;
  }

  var_00 waittill("missile_stuck", var_01);

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    var_00 delete();
    return;
  }

  if(!isDefined(var_0.owner.team)) {
    var_00 delete();
    return;
  }

  var_02 = anglestoup(var_0.angles);
  var_0.origin = var_0.origin - var_02;
  var_03 = level.weaponconfigs[var_0.weapon_name];
  var_04 = spawn("script_model", var_0.origin + var_3.killcamoffset * var_02);
  var_04 setscriptmoverkillcam("explosive");
  var_04 linkto(var_00);
  var_0.killcament = var_04;
  var_00 explosivehandlemovers(var_01);
  var_00 makeexplosiveusable();
  var_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  onlethalequipmentplanted(var_00);
  var_00 thread ondetonateexplosive();
  var_00 thread func_3343();
  var_00 thread func_66B4(1);
  var_00 thread func_DACC(var_01);
  var_00 thread func_F692(self.team, 20);
  level thread monitordisownedequipment(self, var_00);
}

func_DACC(var_00) {
  self endon("death");
  self endon("disabled");
  var_01 = level.weaponconfigs[self.weapon_name];
  wait(var_1.armingdelay);
  self playLoopSound("ied_explo_beeps");
  thread doblinkinglight("tag_fx");
  var_02 = self.origin * (1, 1, 0);
  var_03 = var_1.detectionheight / 2;
  var_04 = self.origin[2] - var_03;
  var_02 = var_02 + (0, 0, var_04);
  var_05 = spawn("trigger_radius", var_02, 0, var_1.detectionradius, var_1.detectionheight);
  var_5.owner = self;

  if(isDefined(var_00)) {
    var_05 getrankxp();
    var_05 linkto(self);
  }

  self.damagearea = var_05;
  thread deleteondeath(var_05);
  var_06 = undefined;

  for(;;) {
    var_05 waittill("trigger", var_06);

    if(!isDefined(var_06)) {
      continue;
    }
    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.owner)) {
        if(var_06 == self.owner) {
          continue;
        }
        if(isDefined(var_6.owner) && var_6.owner == self.owner)
          continue;
      }

      if(!friendlyfirecheck(self.owner, var_06, 0))
        continue;
    }

    if(lengthsquared(var_06 getentityvelocity()) < 10) {
      continue;
    }
    if(var_06 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self stoploopsound("ied_explo_beeps");
  self playSound("ied_warning");
  explosivetrigger(var_06, var_1.detectiongraceperiod, "proxExplosive");
  self notify("detonateExplosive");
}

func_DACB() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("disabled");
    func_DACA();
    wait(var_01);

    if(isDefined(self)) {
      self.disabled = undefined;
      self notify("enabled");
      var_02 = self getlinkedparent();
      thread func_DACC(var_02);
    }
  }
}

func_DACA() {
  stopblinkinglight();

  if(isDefined(self.damagearea))
    self.damagearea delete();
}

func_F692(var_00, var_01) {
  self endon("death");
  wait 0.05;

  if(level.teambased)
    scripts\mp\entityheadicons::setteamheadicon(var_00, (0, 0, var_01));
  else if(isDefined(self.owner))
    scripts\mp\entityheadicons::setplayerheadicon(self.owner, (0, 0, var_01));
}

claymoreused(var_00) {
  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  var_00 hide();
  var_00 scripts\engine\utility::waittill_any_timeout(0.05, "missile_stuck");

  if(!isDefined(self) || !isalive(self)) {
    var_00 delete();
    return;
  }

  var_01 = 60;
  var_02 = (0, 0, 4);
  var_03 = distancesquared(self.origin, var_0.origin);
  var_04 = distancesquared(self getEye(), var_0.origin);
  var_03 = var_03 + 600;
  var_05 = var_00 getlinkedparent();

  if(isDefined(var_05))
    var_00 unlink();

  if(var_03 < var_04) {
    if(var_01 * var_01 < distancesquared(var_0.origin, self.origin)) {
      var_06 = bulletTrace(self.origin, self.origin - (0, 0, var_01), 0, self);

      if(var_6["fraction"] == 1) {
        var_00 delete();
        self setweaponammostock(var_0.weapon_name, self getweaponammostock(var_0.weapon_name) + 1);
        return;
      } else {
        var_0.origin = var_6["position"];
        var_05 = var_6["entity"];
      }
    } else {}
  } else if(var_01 * var_01 < distancesquared(var_0.origin, self getEye())) {
    var_06 = bulletTrace(self.origin, self.origin - (0, 0, var_01), 0, self);

    if(var_6["fraction"] == 1) {
      var_00 delete();
      self setweaponammostock(var_0.weapon_name, self getweaponammostock(var_0.weapon_name) + 1);
      return;
    } else {
      var_0.origin = var_6["position"];
      var_05 = var_6["entity"];
    }
  } else {
    var_02 = (0, 0, -5);
    var_0.angles = var_0.angles + (0, 180, 0);
  }

  var_0.angles = var_0.angles * (0, 1, 1);
  var_0.origin = var_0.origin + var_02;
  var_00 explosivehandlemovers(var_05);
  var_00 show();
  var_00 makeexplosiveusable();
  var_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  onlethalequipmentplanted(var_00, "power_claymore");
  var_00 thread ondetonateexplosive();
  var_00 thread func_3343();
  var_00 thread func_66B4(1);
  var_00 thread claymoredetonation(var_05);
  var_00 thread func_F692(self.pers["team"], 20);
  level thread monitordisownedequipment(self, var_00);
}

claymoredetonation(var_00) {
  self endon("death");
  var_01 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);

  if(isDefined(var_00)) {
    var_01 getrankxp();
    var_01 linkto(var_00);
  }

  thread deleteondeath(var_01);

  for(;;) {
    var_01 waittill("trigger", var_02);

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.owner)) {
        if(var_02 == self.owner) {
          continue;
        }
        if(isDefined(var_2.owner) && var_2.owner == self.owner)
          continue;
      }

      if(!friendlyfirecheck(self.owner, var_02, 0))
        continue;
    }

    if(lengthsquared(var_02 getentityvelocity()) < 10) {
      continue;
    }
    var_03 = abs(var_2.origin[2] - self.origin[2]);

    if(var_03 > 128) {
      continue;
    }
    if(!var_02 shouldaffectclaymore(self)) {
      continue;
    }
    if(var_02 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self playSound("claymore_activated");
  explosivetrigger(var_02, level.claymoredetectiongraceperiod, "claymore");

  if(isDefined(self.owner))
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer("claymore_destroyed", undefined, undefined, self.origin);

  self notify("detonateExplosive");
}

shouldaffectclaymore(var_00) {
  if(isDefined(var_0.disabled))
    return 0;

  var_01 = self.origin + (0, 0, 32);
  var_02 = var_01 - var_0.origin;
  var_03 = anglesToForward(var_0.angles);
  var_04 = vectordot(var_02, var_03);

  if(var_04 < level.claymoredetectionmindist)
    return 0;

  var_02 = vectornormalize(var_02);
  var_05 = vectordot(var_02, var_03);
  return var_05 > level.claymoredetectiondot;
}

deleteondeath(var_00) {
  self waittill("death");
  wait 0.05;

  if(isDefined(var_00)) {
    if(isDefined(var_0.trigger))
      var_0.trigger delete();

    var_00 delete();
  }
}

c4activate() {
  self endon("death");
  self waittill("missile_stuck", var_00);
  wait 0.05;
  self notify("activated");
  self.activated = 1;
}

watchc4altdetonate() {
  self notify("watchC4AltDetonate");
  self endon("watchC4AltDetonate");
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_00 = 0;

  for(;;) {
    if(self usebuttonpressed()) {
      var_00 = 0;

      while(self usebuttonpressed()) {
        var_00 = var_00 + 0.05;
        wait 0.05;
      }

      if(var_00 >= 0.5) {
        continue;
      }
      var_00 = 0;

      while(!self usebuttonpressed() && var_00 < 0.5) {
        var_00 = var_00 + 0.05;
        wait 0.05;
      }

      if(var_00 >= 0.5) {
        continue;
      }
      if(!self.plantedlethalequip.size) {
        return;
      }
      if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(self) && !scripts\mp\utility\game::isusingremote())
        self notify("alt_detonate");
    }

    wait 0.05;
  }
}

watchc4detonation(var_00) {
  self notify("watchC4Detonation");
  self endon("watchC4Detonation");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittillmatch("detonate", "c4_mp");
    c4detonateallcharges();
  }
}

watchc4altdetonation() {
  self notify("watchC4AltDetonation");
  self endon("watchC4AltDetonation");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("alt_detonate");
    var_00 = self getcurrentweapon();

    if(var_00 != "c4_mp")
      c4detonateallcharges();
  }
}

c4detonateallcharges() {
  foreach(var_01 in self.plantedlethalequip) {
    if(isDefined(var_01) && var_1.weapon_name == "c4_mp")
      var_01 thread waitanddetonate(0.1);
  }

  self.plantedlethalequip = [];
  self notify("c4_update", 0);
  self notify("detonated");
}

waitanddetonate(var_00) {
  self endon("death");
  wait(var_00);
  waittillenabled();
  self notify("detonateExplosive");
}

func_3343() {
  self endon("death");
  self endon("detonated");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_00 = undefined;
  var_01 = 1;

  if(self.owner scripts\mp\utility\game::_hasperk("specialty_rugged_eqp"))
    var_1++;

  for(;;) {
    self waittill("damage", var_02, var_00, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);

    if(!isplayer(var_00) && !isagent(var_00)) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_00)) {
      continue;
    }
    if(func_66AA(var_10, var_05)) {
      continue;
    }
    var_11 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isfmjdamage(var_10, var_05), 2, 1);
    var_01 = var_01 - var_11;

    if(var_01 <= 0) {
      break;
    }
    if(var_01 <= 0) {
      break;
    } else
      var_00 scripts\mp\damagefeedback::updatedamagefeedback("bouncing_betty");
  }

  if(level.c4explodethisframe)
    wait(0.1 + randomfloat(0.4));
  else
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  level.c4explodethisframe = 1;
  thread resetc4explodethisframe();

  if(isDefined(var_05) && (issubstr(var_05, "MOD_GRENADE") || issubstr(var_05, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(var_09) && var_09 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_09) && var_09 &level.idflags_no_team_protection)
    self.wasdamagedfrombulletricochet = 1;

  self.wasdamaged = 1;

  if(isDefined(var_00))
    self.damagedby = var_00;

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback("c4");

    if(var_00 != self.owner && var_0.team != self.owner.team) {
      if(var_10 != "trophy_mp")
        var_00 scripts\mp\killstreaks\killstreaks::_meth_83A0();
    }
  }

  if(level.teambased) {
    if(isDefined(var_00) && isDefined(self.owner)) {
      var_12 = var_0.pers["team"];
      var_13 = self.owner.pers["team"];

      if(isDefined(var_12) && isDefined(var_13) && var_12 != var_13)
        var_00 notify("destroyed_equipment");
    }
  } else if(isDefined(self.owner) && isDefined(var_00) && var_00 != self.owner)
    var_00 notify("destroyed_equipment");

  if(getdvarint("showArchetypes", 0) > 0) {
    if(self.weapon_name == "c4_mp")
      self.owner notify("c4_update", 0);
  }

  self notify("detonateExplosive", var_00);
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

func_EB82(var_00, var_01) {
  for(var_02 = 0; var_02 < 60; var_2++)
    wait 0.05;
}

waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }
  self waittill("enabled");
}

func_3347(var_00) {
  self waittill("activated");
  var_01 = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  var_1.func_53B1 = "trigger" + gettime() + randomint(1000000);
  var_1.owner = self;
  var_01 thread func_53B0(level.otherteam[var_00]);
  self waittill("death");
  var_01 notify("end_detection");

  if(isDefined(var_1.func_2C65))
    var_1.func_2C65 destroy();

  var_01 delete();
}

claymoredetectiontrigger(var_00) {
  var_01 = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  var_1.func_53B1 = "trigger" + gettime() + randomint(1000000);
  var_1.owner = self;
  var_01 thread func_53B0(level.otherteam[var_00]);
  self waittill("death");
  var_01 notify("end_detection");

  if(isDefined(var_1.func_2C65))
    var_1.func_2C65 destroy();

  var_01 delete();
}

func_53B0(var_00) {
  self endon("end_detection");
  level endon("game_ended");

  while(!level.gameended) {
    self waittill("trigger", var_01);

    if(!var_1.func_53AD) {
      continue;
    }
    if(level.teambased && var_1.team != var_00)
      continue;
    else if(!level.teambased && var_01 == self.owner.owner) {
      continue;
    }
    if(isDefined(var_1.func_2C67[self.func_53B1])) {
      continue;
    }
    var_01 thread showheadicon(self);
  }
}

monitordisownedequipment(var_00, var_01) {
  level endon("game_ended");
  var_01 endon("death");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  var_01 deleteexplosive();
}

monitordisownedgrenade(var_00, var_01) {
  level endon("game_ended");
  var_01 endon("death");
  var_01 endon("mine_planted");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");

  if(isDefined(var_01))
    var_01 delete();
}

isplantedequipment(var_00) {
  return isDefined(level.mines[var_00 getentitynumber()]) || scripts\mp\utility\game::istrue(var_0.planted);
}

func_7F9A(var_00) {
  var_01 = 0;
  var_02 = scripts\mp\powers::getcurrentequipment("primary");

  if(isDefined(var_02)) {
    var_01 = var_01 + scripts\mp\powers::func_D736(var_02);

    if(scripts\mp\utility\game::_hasperk("specialty_rugged_eqp"))
      var_1++;
  }

  return var_01;
}

func_7FA3(var_00) {
  var_01 = 0;
  var_02 = scripts\mp\powers::getcurrentequipment("secondary");

  if(isDefined(var_02)) {
    var_01 = var_01 + scripts\mp\powers::func_D736(var_02);

    if(scripts\mp\utility\game::_hasperk("specialty_rugged_eqp"))
      var_1++;
  }

  return var_01;
}

onlethalequipmentplanted(var_00, var_01, var_02) {
  var_0.func_D77A = var_01;
  var_0.func_51B6 = var_02;
  var_0.planted = 1;

  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size && self.plantedlethalequip.size >= func_7F9A(self))
      self.plantedlethalequip[0] deleteexplosive();
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var_00;
  var_03 = var_00 getentitynumber();
  level.mines[var_03] = var_00;
  level notify("mine_planted");
}

ontacticalequipmentplanted(var_00, var_01, var_02) {
  var_0.func_D77A = var_01;
  var_0.func_51B6 = var_02;
  var_0.planted = 1;

  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

    if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= func_7FA3(self))
      self.plantedtacticalequip[0] deleteexplosive();
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = var_00;
  var_03 = var_00 getentitynumber();
  level.mines[var_03] = var_00;
  level notify("mine_planted");
}

func_5608() {
  if(isDefined(self.plantedlethalequip) && self.plantedlethalequip.size > 0) {
    foreach(var_01 in self.plantedlethalequip) {
      if(isDefined(var_1.trigger) && isDefined(var_1.owner))
        var_1.trigger disableplayeruse(var_1.owner);
    }
  }

  if(isDefined(self.plantedtacticalequip) && self.plantedtacticalequip.size > 0) {
    foreach(var_01 in self.plantedtacticalequip) {
      if(isDefined(var_1.trigger) && isDefined(var_1.owner))
        var_1.trigger disableplayeruse(var_1.owner);
    }
  }
}

cleanupequipment(var_00, var_01, var_02, var_03) {
  if(getdvarint("showArchetypes", 0) > 0) {
    if(isDefined(self.weapon_name)) {
      if(self.weapon_name == "c4_mp")
        self.owner notify("c4_update", 0);
      else if(self.weapon_name == "bouncingbetty_mp")
        self.owner notify("bouncing_betty_update", 0);
      else if(self.weapon_name == "trip_mine_mp")
        self.owner notify("trip_mine_update", 0);
      else if(self.weapon_name == "cryo_mine_mp")
        self.owner notify("cryo_mine_update", 0);
      else if(self.weapon_name == "fear_grenade_mp")
        self.owner notify("restart_fear_grenade_cooldown", 0);
      else if(self.weapon_name == "trophy_mp")
        self.owner notify("trophy_update", 0);
    }
  }

  if(isDefined(var_00))
    level.mines[var_00] = undefined;

  if(isDefined(var_01))
    var_01 delete();

  if(isDefined(var_02))
    var_02 delete();

  if(isDefined(var_03))
    var_03 delete();
}

deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var_00 = self getentitynumber();
  level.mines[var_00] = undefined;

  if(isDefined(self.func_51B6)) {
    self thread[[self.func_51B6]]();
    self notify("deleted_equipment");
  } else {
    var_01 = self.killcament;
    var_02 = self.trigger;
    var_03 = self.sensor;
    cleanupequipment(var_00, var_01, var_02, var_03);
    self notify("deleted_equipment");
    self delete();
  }
}

ondetonateexplosive() {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");
  self detonate(self.owner);
}

cleanupexplosivesondeath() {
  self endon("deleted_equipment");
  level endon("game_ended");
  var_00 = self getentitynumber();
  var_01 = self.killcament;
  var_02 = self.trigger;
  var_03 = self.sensor;
  self waittill("death");
  cleanupequipment(var_00, var_01, var_02, var_03);
}

makeexplosiveusable(var_00) {
  self setotherent(self.owner);

  if(!isDefined(var_00))
    var_00 = 10;

  var_01 = spawn("script_origin", self.origin + var_00 * anglestoup(self.angles));
  var_01 linkto(self);
  self.trigger = var_01;
  var_1.owner = self;
  thread makeexplosiveusableinternal();
  return var_01;
}

makeexplosiveusableinternal() {
  self endon("makeExplosiveUnusable");
  var_00 = self.trigger;
  watchexplosiveusable();

  if(isDefined(self)) {
    var_00 = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(var_00))
    var_00 delete();
}

makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  var_00 = self.trigger;
  self.trigger = undefined;

  if(isDefined(var_00))
    var_00 delete();
}

watchexplosiveusable() {
  var_00 = self.owner;
  var_01 = self.trigger;
  self endon("death");
  var_01 endon("death");
  var_00 endon("disconnect");
  level endon("game_ended");
  var_01 setcursorhint("HINT_NOICON");
  var_01 scripts\mp\utility\game::setselfusable(var_00);
  var_01 childthread scripts\mp\utility\game::notusableforjoiningplayers(var_00);

  switch (self.weapon_name) {
    case "c4_mp":
      var_01 sethintstring(&"MP_PICKUP_C4");
      break;
    case "cryo_mine_mp":
      var_01 sethintstring(&"MP_PICKUP_CRYO_MINE");
      break;
    case "trip_mine_mp":
      var_01 sethintstring(&"MP_PICKUP_TRIP_MINE");
      break;
    case "trophy_mp":
      var_01 sethintstring(&"MP_PICKUP_TROPHY");
      break;
  }

  for(;;) {
    var_01 waittillmatch("trigger", var_00);

    if(isDefined(self.weapon_name)) {
      switch (self.weapon_name) {
        case "trophy_mp":
          thread scripts\mp\trophy_system::func_12818();
      }

      var_00 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_00 playlocalsound("scavenger_pack_pickup");
    var_00 notify("scavenged_ammo", self.weapon_name);
    thread deleteexplosive();
    return;
  }
}

makeexplosiveusabletag(var_00, var_01) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_02 = self.owner;
  var_03 = self.weapon_name;

  if(!isDefined(var_01))
    var_01 = 0;

  if(var_01)
    self grenade_earthquake(1);
  else
    self setcursorhint("HINT_NOICON");

  self _meth_84A7(var_00);

  switch (var_03) {
    case "c4_mp":
      self sethintstring(&"MP_PICKUP_C4");
      break;
    case "cryo_mine_mp":
      self sethintstring(&"MP_PICKUP_CRYO_MINE");
      break;
    case "trip_mine_mp":
      self sethintstring(&"MP_PICKUP_TRIP_MINE");
      break;
    case "trophy_mp":
      self sethintstring(&"MP_PICKUP_TROPHY");
      break;
  }

  scripts\mp\utility\game::setselfusable(var_02);
  childthread scripts\mp\utility\game::notusableforjoiningplayers(var_02);

  for(;;) {
    self waittillmatch("trigger", var_02);

    if(isDefined(var_03)) {
      switch (var_03) {
        case "trophy_mp":
          thread scripts\mp\trophy_system::func_12818();
      }

      var_02 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_02 playlocalsound("scavenger_pack_pickup");
    var_02 notify("scavenged_ammo", var_03);
    thread deleteexplosive();
    return;
  }
}

makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

explosivehandlemovers(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.linkparent = var_00;
  var_2.deathoverridecallback = ::movingplatformdetonate;
  var_2.endonstring = "death";

  if(!isDefined(var_01) || !var_01)
    var_2.invalidparentoverridecallback = scripts\mp\movers::moving_platform_empty_func;

  thread scripts\mp\movers::handle_moving_platforms(var_02);
}

explosivetrigger(var_00, var_01, var_02) {
  if(isplayer(var_00) && var_00 scripts\mp\utility\game::_hasperk("specialty_delaymine")) {
    var_00 thread scripts\mp\missions::func_127BC();
    var_00 notify("triggeredExpl", var_02);
    var_01 = level.delayminetime;
  }

  wait(var_01);
}

func_FA95() {
  self.func_2C67 = [];

  if(self.func_53AD && !self.func_2C66.size) {
    for(var_00 = 0; var_00 < 4; var_0++) {
      self.func_2C66[var_00] = newclienthudelem(self);
      self.func_2C66[var_00].x = 0;
      self.func_2C66[var_00].y = 0;
      self.func_2C66[var_00].z = 0;
      self.func_2C66[var_00].alpha = 0;
      self.func_2C66[var_00].archived = 1;
      self.func_2C66[var_00] setshader("waypoint_bombsquad", 14, 14);
      self.func_2C66[var_00] setwaypoint(0, 0);
      self.func_2C66[var_00].func_53B1 = "";
    }
  } else if(!self.func_53AD) {
    for(var_00 = 0; var_00 < self.func_2C66.size; var_0++)
      self.func_2C66[var_00] destroy();

    self.func_2C66 = [];
  }
}

showheadicon(var_00) {
  var_01 = var_0.func_53B1;
  var_02 = -1;

  for(var_03 = 0; var_03 < 4; var_3++) {
    var_04 = self.func_2C66[var_03].func_53B1;

    if(var_04 == var_01) {
      return;
    }
    if(var_04 == "")
      var_02 = var_03;
  }

  if(var_02 < 0) {
    return;
  }
  self.func_2C67[var_01] = 1;
  self.func_2C66[var_02].x = var_0.origin[0];
  self.func_2C66[var_02].y = var_0.origin[1];
  self.func_2C66[var_02].z = var_0.origin[2] + 24 + 128;
  self.func_2C66[var_02] fadeovertime(0.25);
  self.func_2C66[var_02].alpha = 1;
  self.func_2C66[var_02].func_53B1 = var_0.func_53B1;

  while(isalive(self) && isDefined(var_00) && self istouching(var_00))
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.func_2C66[var_02].func_53B1 = "";
  self.func_2C66[var_02] fadeovertime(0.25);
  self.func_2C66[var_02].alpha = 0;
  self.func_2C67[var_01] = undefined;
}

getdamageableents(var_00, var_01, var_02, var_03) {
  var_04 = [];

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  var_05 = var_01 * var_01;
  var_06 = level.players;

  for(var_07 = 0; var_07 < var_6.size; var_7++) {
    if(!isalive(var_6[var_07]) || var_6[var_07].sessionstate != "playing") {
      continue;
    }
    var_08 = scripts\mp\utility\game::func_7921(var_6[var_07]);
    var_09 = distancesquared(var_00, var_08);

    if(var_09 < var_05 && (!var_02 || func_13C7E(var_00, var_08, var_03, var_6[var_07])))
      var_4[var_4.size] = scripts\mp\utility\game::func_7920(var_6[var_07], var_08);
  }

  var_10 = getEntArray("grenade", "classname");

  for(var_07 = 0; var_07 < var_10.size; var_7++) {
    var_11 = scripts\mp\utility\game::func_791E(var_10[var_07]);
    var_09 = distancesquared(var_00, var_11);

    if(var_09 < var_05 && (!var_02 || func_13C7E(var_00, var_11, var_03, var_10[var_07])))
      var_4[var_4.size] = scripts\mp\utility\game::func_791D(var_10[var_07], var_11);
  }

  var_12 = getEntArray("destructible", "targetname");

  for(var_07 = 0; var_07 < var_12.size; var_7++) {
    var_11 = var_12[var_07].origin;
    var_09 = distancesquared(var_00, var_11);

    if(var_09 < var_05 && (!var_02 || func_13C7E(var_00, var_11, var_03, var_12[var_07]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.func_9D26 = 0;
      var_13.entity = var_12[var_07];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_14 = getEntArray("destructable", "targetname");

  for(var_07 = 0; var_07 < var_14.size; var_7++) {
    var_11 = var_14[var_07].origin;
    var_09 = distancesquared(var_00, var_11);

    if(var_09 < var_05 && (!var_02 || func_13C7E(var_00, var_11, var_03, var_14[var_07]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.func_9D26 = 1;
      var_13.entity = var_14[var_07];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_15 = getEntArray("misc_turret", "classname");

  foreach(var_17 in var_15) {
    var_11 = var_17.origin + (0, 0, 32);
    var_09 = distancesquared(var_00, var_11);

    if(var_09 < var_05 && (!var_02 || func_13C7E(var_00, var_11, var_03, var_17))) {
      switch (var_17.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_remote_turret":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          var_4[var_4.size] = scripts\mp\utility\game::func_7922(var_17, var_11);
          break;
      }
    }
  }

  var_19 = getEntArray("script_model", "classname");

  foreach(var_21 in var_19) {
    if(var_21.model != "projectile_bouncing_betty_grenade" && var_21.model != "ims_scorpion_body") {
      continue;
    }
    var_11 = var_21.origin + (0, 0, 32);
    var_09 = distancesquared(var_00, var_11);

    if(var_09 < var_05 && (!var_02 || func_13C7E(var_00, var_11, var_03, var_21)))
      var_4[var_4.size] = scripts\mp\utility\game::func_791F(var_21, var_11);
  }

  return var_04;
}

getempdamageents(var_00, var_01, var_02, var_03) {
  var_04 = [];

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  var_05 = var_01 * var_01;
  level.mines = scripts\engine\utility::array_removeundefined(level.mines);

  foreach(var_07 in level.mines) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  var_09 = getEntArray("misc_turret", "classname");

  foreach(var_07 in var_09) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.uplinks) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.remote_uav) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.balldrones) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.placedims) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.microturrets) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.func_105EA) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.func_69D6) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.spidergrenade.activeagents) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.spidergrenade.proxies) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.func_2ABD) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.func_590F) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.littlebirds) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.func_D3CC) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03))
      var_4[var_4.size] = var_07;
  }

  foreach(var_07 in level.players) {
    if(func_619A(var_07, var_00, var_05, var_02, var_03) && scripts\mp\utility\game::func_9EF0(var_07))
      var_4[var_4.size] = var_07;
  }

  return var_04;
}

func_619A(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_0.origin;
  var_06 = distancesquared(var_01, var_05);
  return var_06 < var_02 && (!var_03 || func_13C7E(var_01, var_05, var_04, var_00));
}

func_13C7E(var_00, var_01, var_02, var_03) {
  var_04 = undefined;
  var_05 = var_01 - var_00;

  if(lengthsquared(var_05) < var_02 * var_02)
    return 1;

  var_06 = vectornormalize(var_05);
  var_04 = var_00 + (var_6[0] * var_02, var_6[1] * var_02, var_6[2] * var_02);
  var_07 = bulletTrace(var_04, var_01, 0, var_03);

  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread debugprint(var_00, ".dmg");

    if(isDefined(var_03))
      thread debugprint(var_01, "." + var_3.classname);
    else
      thread debugprint(var_01, ".undefined");

    if(var_7["fraction"] == 1)
      thread debugline(var_04, var_01, (1, 1, 1));
    else {
      thread debugline(var_04, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_01, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

func_66B4(var_00) {
  self endon("death");
  self waittill("emp_damage", var_01, var_02, var_03, var_04, var_05);

  if(isDefined(var_04) && var_04 == "emp_grenade_mp") {
    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_01)))
      var_01 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
  }

  equipmentempstunvfx();

  if(isDefined(self.owner) && isDefined(var_01) && self.owner != var_01)
    var_01 scripts\mp\killstreaks\killstreaks::_meth_83A0();

  if(isDefined(var_00) && var_00)
    deleteexplosive();
  else
    self notify("detonateExplosive");
}

damageent(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(self.isplayer) {
    self.func_4D5B = var_05;
    self.entity thread[[level.callbackplayerdamage]](var_00, var_01, var_02, 0, var_03, var_04, var_05, var_06, "none", 0);
  } else {
    if(self.func_9D26 && (var_04 == "artillery_mp" || var_04 == "claymore_mp" || var_04 == "stealth_bomb_mp")) {
      return;
    }
    self.entity notify("damage", var_02, var_01, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_04);
  }
}

debugline(var_00, var_01, var_02) {
  for(var_03 = 0; var_03 < 600; var_3++)
    wait 0.05;
}

debugcircle(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03))
    var_03 = 16;

  var_04 = 360 / var_03;
  var_05 = [];

  for(var_06 = 0; var_06 < var_03; var_6++) {
    var_07 = var_04 * var_06;
    var_08 = cos(var_07) * var_01;
    var_09 = sin(var_07) * var_01;
    var_10 = var_0[0] + var_08;
    var_11 = var_0[1] + var_09;
    var_12 = var_0[2];
    var_5[var_5.size] = (var_10, var_11, var_12);
  }

  for(var_06 = 0; var_06 < var_5.size; var_6++) {
    var_13 = var_5[var_06];

    if(var_06 + 1 >= var_5.size)
      var_14 = var_5[0];
    else
      var_14 = var_5[var_06 + 1];

    thread debugline(var_13, var_14, var_02);
  }
}

debugprint(var_00, var_01) {
  for(var_02 = 0; var_02 < 600; var_2++)
    wait 0.05;
}

onweapondamage(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");
  self endon("disconnect");

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  if(isDefined(var_01) && var_01 != "none")
    var_01 = getweaponbasename(var_01);

  switch (var_01) {
    case "cluster_grenade_mp":
      if(isDefined(var_00) && scripts\mp\utility\game::istrue(var_0.shellshockondamage))
        scripts\mp\shellshock::shellshockondamage(var_02, var_03);

      break;
    case "concussion_grenade_mp":
      if(var_03 > 0)
        thread scripts\mp\concussion::onweapondamage(var_00, var_01, var_02, var_03, var_04);

      break;
    case "blackout_grenade_mp":
      if(var_03 > 0) {
        if(var_02 != "MOD_IMPACT")
          scripts\mp\equipment\blackout_grenade::func_10D6F(var_0.owner, var_0.origin);
      }

      break;
    case "venomproj_mp":
    case "cryo_mine_mp":
      if(var_03 > 0) {
        if(var_02 != "MOD_IMPACT") {
          if(isDefined(var_00)) {
            if(isDefined(var_0.streakinfo)) {
              if(scripts\mp\killstreaks\utility::func_A69F(var_0.streakinfo, "passive_increased_frost"))
                scripts\mp\equipment\cryo_mine::func_4ACF(var_04, 3);
              else
                scripts\mp\equipment\cryo_mine::func_4ACF(var_04);
            } else
              scripts\mp\equipment\cryo_mine::func_4ACF(var_04);
          }
        }
      }

      break;
    case "weapon_cobra_mk19_mp":
      break;
    case "iw7_glprox_mp":
      break;
    case "shard_ball_mp":
      break;
    case "splash_grenade_mp":
      break;
    case "pulse_grenade_mp":
      scripts\mp\equipment\pulse_grenade::func_DAF4();
      break;
    case "minijackal_strike_mp":
      break;
    case "groundpound_mp":
      scripts\mp\equipment\ground_pound::groundpound_victimimpacteffects(var_04, self, var_01, var_00);
      break;
    case "gltacburst_big":
    case "gltacburst":
      if(var_03 > 0)
        thread scripts\mp\emp_debuff_mp::onweapondamage(var_00, var_01, var_02, var_03, var_04);

      break;
    default:
      scripts\mp\shellshock::shellshockondamage(var_02, var_03);
      break;
  }
}

isprimaryweapon(var_00) {
  if(var_00 == "none")
    return 0;

  if(weaponinventorytype(var_00) != "primary")
    return 0;

  switch (weaponclass(var_00)) {
    case "smg":
    case "mg":
    case "rifle":
    case "sniper":
    case "rocketlauncher":
    case "spread":
    case "pistol":
      return 1;
    default:
      return 0;
  }
}

isbulletweapon(var_00) {
  if(var_00 == "none" || isriotshield(var_00) || isknifeonly(var_00))
    return 0;

  switch (weaponclass(var_00)) {
    case "smg":
    case "mg":
    case "rifle":
    case "sniper":
    case "spread":
    case "pistol":
      return 1;
    default:
      return 0;
  }
}

isknifeonly(var_00) {
  return scripts\mp\utility\game::getweaponrootname(var_00) == "iw7_knife";
}

isballweapon(var_00) {
  return scripts\mp\utility\game::getweaponrootname(var_00) == "iw7_uplinkball" || scripts\mp\utility\game::getweaponrootname(var_00) == "iw7_tdefball";
}

isaxeweapon(var_00) {
  return scripts\mp\utility\game::getweaponrootname(var_00) == "iw7_axe";
}

isaltmodeweapon(var_00) {
  if(var_00 == "none")
    return 0;

  return weaponinventorytype(var_00) == "altmode";
}

func_9E56(var_00) {
  if(var_00 == "none")
    return 0;

  return weaponinventorytype(var_00) == "item";
}

func_9F5D(var_00) {
  return isDefined(var_00) && scripts\mp\utility\game::getweaponrootname(var_00) == "iw7_emc";
}

isriotshield(var_00) {
  if(var_00 == "none")
    return 0;

  return weapontype(var_00) == "riotshield";
}

func_9EC0(var_00) {
  if(var_00 == "none")
    return 0;

  return weaponinventorytype(var_00) == "offhand";
}

func_9F54(var_00) {
  if(var_00 == "none")
    return 0;

  if(weaponinventorytype(var_00) != "primary")
    return 0;

  return weaponclass(var_00) == "pistol";
}

func_9E18(var_00) {
  var_01 = weaponclass(var_00);

  if(var_01 != "grenade")
    return 0;

  var_02 = weaponinventorytype(var_00);

  if(var_02 != "offhand")
    return 0;

  return 1;
}

func_9FA9(var_00) {
  if(var_00 == "none")
    return 0;

  return issubstr(var_00, "throwingknife");
}

updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_00 = self.currentweaponatspawn;

  if(isDefined(self.saved_lastweaponhack))
    var_00 = self.saved_lastweaponhack;

  self.saved_lastweapon = var_00;
  self.func_EB6C = var_00;

  for(;;) {
    self waittill("weapon_change", var_01);
    self.func_EB6C = var_01;

    if(var_01 == "none")
      continue;
    else if(scripts\mp\utility\game::issuperweapon(var_01)) {
      updatemovespeedscale();
      continue;
    } else if(scripts\mp\utility\game::iskillstreakweapon(var_01))
      continue;
    else {
      var_02 = weaponinventorytype(var_01);

      if(var_02 != "primary" && var_02 != "altmode")
        continue;
    }

    updatemovespeedscale();
    self.saved_lastweapon = var_00;
    var_00 = var_01;
  }
}

empplayer(var_00) {
  self endon("disconnect");
  self endon("death");
  thread func_41AB();
}

func_41AB() {
  self endon("disconnect");
  self waittill("death");
}

_meth_8237() {
  var_00 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_02 in self.weaponlist) {
      if(scripts\mp\utility\game::issuperweapon(var_02))
        var_03 = scripts\mp\supers::func_7FD0(var_02);
      else if(scripts\mp\utility\game::func_9E0D(var_02))
        var_03 = func_7ECD(var_02);
      else
        var_03 = _meth_8236(var_02);

      if(var_03 == 0) {
        continue;
      }
      if(var_03 < var_00)
        var_00 = var_03;
    }
  } else
    var_00 = 0.94;

  var_00 = clampweaponspeed(var_00);
  return var_00;
}

_meth_8236(var_00) {
  var_01 = scripts\mp\utility\game::getweaponrootname(var_00);
  return level.weaponmapdata[var_01].speed;
}

func_7ECD(var_00) {
  return 1.0;
}

clampweaponspeed(var_00) {
  return clamp(var_00, 0.0, 1.0);
}

updateviewkickscale(var_00) {
  if(isDefined(var_00))
    self.func_1339E = var_00;

  if(isDefined(self.func_C7E8))
    var_00 = self.func_C7E8;
  else if(scripts\mp\utility\game::_hasperk("specialty_distance_kit"))
    var_00 = 0.05;
  else if(isDefined(self.overrideviewkickscale)) {
    if((weaponclass(self getcurrentweapon()) == "sniper" || issubstr(self getcurrentweapon(), "iw7_udm45_mpl") || issubstr(self getcurrentweapon(), "iw7_longshot_mp")) && isDefined(self.overrideviewkickscalesniper))
      var_00 = self.overrideviewkickscalesniper;
    else
      var_00 = self.overrideviewkickscale;
  } else if(isDefined(self.func_1339E))
    var_00 = self.func_1339E;
  else
    var_00 = 1.0;

  var_00 = clamp(var_00, 0.0, 1.0);
  self givegesture(var_00);
}

updatemovespeedscale() {
  var_00 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_00 = 1.0;
    var_00 = var_00 + self.playerstreakspeedscale;
  } else {
    var_00 = getplayerspeedbyweapon(self);

    if(isDefined(self.overrideweaponspeed_speedscale))
      var_00 = self.overrideweaponspeed_speedscale;

    var_01 = self.chill_data;

    if(isDefined(var_01) && isDefined(var_1.speedmod))
      var_00 = var_00 + var_1.speedmod;

    if(isDefined(self.weaponpassivespeedmod))
      var_00 = var_00 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      var_00 = var_00 + self.weaponpassivespeedonkillmod;

    var_00 = var_00 + scripts\mp\perks\weaponpassives::passivecolddamagegetspeedmod(self);

    if(isDefined(self.weaponpassivefastrechamberspeedmod))
      var_00 = var_00 + self.weaponpassivefastrechamberspeedmod;

    if(isDefined(self.speedonkillmod))
      var_00 = var_00 + self.speedonkillmod;
  }

  self.weaponspeed = var_00;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  var_00 = var_00 + (self.movespeedscaler - 1.0);
  var_00 = var_00 + (self.combatspeedscalar - 1.0);
  var_00 = clamp(var_00, 0.0, 1.08);

  if(isDefined(self.fastcrouchspeedmod))
    var_00 = var_00 + self.fastcrouchspeedmod;

  self setmovespeedscale(var_00);
}

getplayerspeedbyweapon(var_00) {
  var_01 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size)
    var_01 = 0.94;
  else {
    var_02 = self getcurrentweapon();

    if(scripts\mp\utility\game::issuperweapon(var_02))
      var_01 = scripts\mp\supers::func_7FD0(var_02);
    else if(scripts\mp\utility\game::func_9E0D(var_02))
      var_01 = func_7ECD(var_02);
    else if(scripts\mp\utility\game::iskillstreakweapon(var_02))
      var_01 = 0.94;
    else if(issubstr(var_02, "iw7_mauler_mpl_damage"))
      var_01 = 0.87;
    else if(issubstr(var_02, "iw7_udm45_mpl"))
      var_01 = 0.95;
    else if(issubstr(var_02, "iw7_rvn") && self _meth_8519(var_02))
      var_01 = 1.0;
    else if(issubstr(var_02, "iw7_longshot") && self _meth_8519(var_02))
      var_01 = 0.98;
    else {
      var_03 = weaponinventorytype(var_02);

      if(var_03 != "primary" && var_03 != "altmode") {
        if(isDefined(self.saved_lastweapon))
          var_02 = self.saved_lastweapon;
        else
          var_02 = undefined;
      }

      if(!isDefined(var_02) || !self hasweapon(var_02))
        var_01 = _meth_8237();
      else
        var_01 = _meth_8236(var_02);
    }
  }

  var_01 = clampweaponspeed(var_01);
  return var_01;
}

stancerecoiladjuster() {
  if(!isplayer(self)) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  if(!level.console && !isai(self)) {
    self notifyonplayercommand("adjustedStance", "+togglecrouch");
    self notifyonplayercommand("adjustedStance", "toggleprone");
    self notifyonplayercommand("adjustedStance", "+movedown");
    self notifyonplayercommand("adjustedStance", "-movedown");
    self notifyonplayercommand("adjustedStance", "+prone");
    self notifyonplayercommand("adjustedStance", "-prone");
  }

  for(;;) {
    scripts\engine\utility::waittill_any("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;

    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }
    var_00 = self getstance();
    stancerecoilupdate(var_00);
  }
}

stancerecoilupdate(var_00) {
  var_01 = self getcurrentprimaryweapon();
  var_02 = 0;

  if(isrecoilreducingweapon(var_01))
    var_02 = getrecoilreductionvalue();

  if(var_00 == "prone") {
    var_03 = scripts\mp\utility\game::getweapongroup(var_01);

    if(var_03 == "weapon_lmg") {
      scripts\mp\utility\game::setrecoilscale(0, 0);
      return;
    }

    if(var_03 == "weapon_sniper") {
      if(issubstr(var_01, "barrelbored")) {
        scripts\mp\utility\game::setrecoilscale(0, 0 + var_02);
        return;
      }

      scripts\mp\utility\game::setrecoilscale(0, 0 + var_02);
      return;
      return;
    }

    scripts\mp\utility\game::setrecoilscale();
    return;
    return;
  } else if(var_00 == "crouch") {
    var_03 = scripts\mp\utility\game::getweapongroup(var_01);

    if(var_03 == "weapon_lmg") {
      scripts\mp\utility\game::setrecoilscale(0, 0);
      return;
    }

    if(var_03 == "weapon_sniper") {
      if(issubstr(var_01, "barrelbored")) {
        scripts\mp\utility\game::setrecoilscale(0, 0 + var_02);
        return;
      }

      scripts\mp\utility\game::setrecoilscale(0, 0 + var_02);
      return;
      return;
    }

    scripts\mp\utility\game::setrecoilscale();
    return;
    return;
  } else if(var_02 > 0)
    scripts\mp\utility\game::setrecoilscale(0, var_02);
  else
    scripts\mp\utility\game::setrecoilscale();
}

semtexused(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  var_0.originalowner = self;
  var_00 waittill("missile_stuck", var_01);
  var_00 thread scripts\mp\shellshock::grenade_earthquake();

  if(isplayer(var_01) || isagent(var_01))
    grenadestuckto(var_00, var_01);

  var_00 explosivehandlemovers(undefined);
}

turret_monitoruse() {
  for(;;) {
    self waittill("trigger", var_00);
    thread turret_playerthread(var_00);
  }
}

turret_playerthread(var_00) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 notify("weapon_change", "none");
  self waittill("turret_deactivate");
  var_00 notify("weapon_change", var_00 getcurrentweapon());
}

spawnmine(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = (0, randomfloat(360), 0);

  var_05 = level.weaponconfigs[var_02];
  var_06 = spawn("script_model", var_00);
  var_6.angles = var_04;
  var_06 setModel(var_5.model);
  var_6.owner = var_01;
  var_06 setotherent(var_01);
  var_6.weapon_name = var_02;
  var_6.config = var_05;
  var_6.killcamoffset = (0, 0, 4);
  var_6.killcament = spawn("script_model", var_6.origin + var_6.killcamoffset);
  var_6.killcament setscriptmoverkillcam("explosive");
  var_07 = scripts\mp\utility\game::getequipmenttype(var_02);

  if(!isDefined(var_07))
    var_07 = "lethal";

  if(var_07 == "lethal")
    var_01 onlethalequipmentplanted(var_06, var_03);
  else if(var_07 == "tactical")
    var_01 ontacticalequipmentplanted(var_06, var_03);
  else {}

  if(isDefined(var_5.bombsquadmodel))
    var_06 thread createbombsquadmodel(var_5.bombsquadmodel, "tag_origin", var_01);

  if(isDefined(var_5.mine_beacon))
    var_06 thread doblinkinglight("tag_fx", var_5.mine_beacon["friendly"], var_5.mine_beacon["enemy"]);

  var_06 thread func_F692(var_1.pers["team"], var_5.headiconoffset);
  var_08 = undefined;

  if(self != level)
    var_08 = self getlinkedparent();

  var_06 explosivehandlemovers(var_08);
  var_06 thread mineproximitytrigger(var_08);
  var_06 thread scripts\mp\shellshock::grenade_earthquake();
  var_06 thread mineselfdestruct();
  var_06 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_01, 1);
  var_06 thread mineexplodeonnotify();
  var_06 thread func_66B4(1);
  var_06 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  thread outlineequipmentforowner(var_06, var_01);
  level thread monitordisownedequipment(var_01, var_06);
  return var_06;
}

func_108E7(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = (0, randomfloat(360), 0);

  var_05 = level.weaponconfigs[var_02];
  var_06 = spawn("script_model", var_00);
  var_6.angles = var_04;
  var_06 setModel(var_5.model);
  var_6.owner = var_01;
  var_06 setotherent(var_01);
  var_6.weapon_name = var_02;
  var_6.config = var_05;
  var_01 ontacticalequipmentplanted(var_06, var_03);
  var_06 thread createbombsquadmodel(var_5.bombsquadmodel, "tag_origin", var_01);
  var_06 thread func_F692(var_1.pers["team"], var_5.headiconoffset);
  var_07 = undefined;

  if(self != level)
    var_07 = self getlinkedparent();

  var_06 explosivehandlemovers(var_07, 1);
  var_06 thread mineproximitytrigger(var_07);
  var_06 thread scripts\mp\shellshock::grenade_earthquake();
  var_06 thread func_BBC4();
  var_06 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_01);
  var_06 thread func_B77D();
  level thread monitordisownedequipment(var_01, var_06);
  return var_06;
}

func_108E5(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_04))
    var_04 = (0, randomfloat(360), 0);

  var_07 = level.weaponconfigs[var_02];
  var_08 = spawn("script_model", var_00);
  var_8.angles = var_04;
  var_08 setModel(var_7.model);
  var_8.owner = var_01;
  var_08 setotherent(var_01);
  var_8.weapon_name = var_02;
  var_8.config = var_07;

  if(isDefined(var_05))
    var_8.func_AC75 = var_05;
  else
    var_8.func_AC75 = 45;

  var_01 ontacticalequipmentplanted(var_08, var_03);
  var_08 thread createbombsquadmodel(var_7.bombsquadmodel, "tag_origin", var_01);
  var_08 thread func_F692(var_1.pers["team"], var_7.headiconoffset);
  var_09 = undefined;

  if(self != level)
    var_09 = self getlinkedparent();

  var_08 explosivehandlemovers(var_09, 1);
  var_08 thread mineproximitytrigger(var_09);
  var_08 thread scripts\mp\shellshock::grenade_earthquake();
  var_08 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var_01);
  var_08 thread func_B8F6();
  level thread monitordisownedequipment(var_01, var_08);
  var_08 thread func_D501();
  var_08 thread func_139F0();

  if(isDefined(var_06) && var_06) {
    var_08 makeexplosiveusable();
    var_08 thread minedamagemonitor();
  }

  return var_08;
}

func_139F5() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self waittill("missile_stuck");
  thread func_E845(var_00, self.origin);
}

func_E845(var_00, var_01) {
  var_02 = spawn("trigger_radius", var_01, 0, 128, 135);
  var_2.owner = var_00;
  var_03 = 128;
  var_04 = spawnfx(scripts\engine\utility::getfx("distortion_field_cloud"), var_01);
  triggerfx(var_04);
  var_05 = 8.0;

  foreach(var_07 in level.players) {
    var_7.func_9E44 = 0;
    var_07 thread func_20C2(var_02);
  }

  while(var_05 > 0.0) {
    foreach(var_07 in level.players) {
      if(var_07 istouching(var_02) && !var_7.func_9E44)
        var_07 thread func_20C2(var_02);
    }

    wait 0.2;
    var_05 = var_05 - 0.2;
  }

  foreach(var_07 in level.players) {
    var_07 notify("distortion_field_ended");

    foreach(var_14 in level.players)
    var_07 giveperkequipment(var_14);
  }

  var_04 delete();
  self delete();
  wait 2.0;
  var_02 delete();
}

func_20C2(var_00) {
  self endon("death");
  self endon("disconnect");

  while(isDefined(var_00) && self istouching(var_00) && !scripts\mp\killstreaks\emp_common::isemped()) {
    self setblurforplayer(4, 1);
    self.func_9E44 = 1;
    thread func_B9CF();

    foreach(var_02 in level.players)
    self hidefromplayer(var_02);

    scripts\engine\utility::waittill_any_timeout(1.4, "emp_damage");

    foreach(var_02 in level.players)
    self giveperkequipment(var_02);

    wait 0.1;
  }

  self setblurforplayer(0, 0.25);
  self.func_9E44 = 0;

  foreach(var_02 in level.players)
  var_02 giveperkequipment(var_02);
}

func_B9CF() {
  self endon("distortion_field_ended");
  var_00 = 0;

  while(!var_00) {
    var_00 = scripts\mp\killstreaks\emp_common::isemped();
    scripts\engine\utility::waitframe();
  }

  self notify("emp_damage");
}

func_10910(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = (0, randomfloat(360), 0);

  var_05 = level.weaponconfigs[var_02];
  var_06 = spawn("script_model", var_00);
  var_6.angles = var_04;
  var_06 setModel(var_5.model);
  var_6.owner = var_01;
  var_06 setotherent(var_01);
  var_6.weapon_name = var_02;
  var_6.config = var_05;
  var_01 ontacticalequipmentplanted(var_06, var_03);
  var_06 thread createbombsquadmodel(var_5.bombsquadmodel, "tag_origin", var_01);
  var_06 thread func_F692(var_1.pers["team"], var_5.headiconoffset);
  var_06 thread func_10413(var_01, var_06, var_6.weapon_name);
  var_6.func_AC75 = 15;
  var_06 thread func_139F0(0);
  var_01 notify("sonic_sensor_used");
  var_07 = undefined;

  if(self != level)
    var_07 = self getlinkedparent();

  var_06 explosivehandlemovers(var_07, 1);
  var_06 thread scripts\mp\shellshock::grenade_earthquake();
  var_06 thread func_BBC4();
  var_06 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var_01);
  var_06 thread func_B77D();
  var_06 thread func_10412();
  level thread monitordisownedequipment(var_01, var_06);
  return var_06;
}

func_10412() {
  scripts\engine\utility::waittill_any("death", "mine_destroyed");
  self.owner notify("sonic_sensor_update");

  foreach(var_01 in self.owner.plantedtacticalequip) {
    if(isDefined(var_01) && var_1.weapon_name == "sonic_sensor_mp") {
      var_01 deleteexplosive();
      scripts\engine\utility::array_remove(self.owner.plantedtacticalequip, var_01);
    }
  }
}

func_139F0(var_00) {
  self endon("death");

  while(self.func_AC75 > 0) {
    self.func_AC75--;
    wait 1;
  }

  self playSound(self.config.onexplodesfx);
  var_01 = self gettagorigin("tag_origin");
  playFX(self.config.onexplodevfx, var_01);

  if(isDefined(self.config.func_127BF)) {
    self.config.func_127BF.func_DBD8 = undefined;
    self.config.func_127BF = undefined;
  }

  if(!isDefined(var_00) || var_00)
    self getplayermodelname();

  deleteexplosive();
}

func_66AA(var_00, var_01) {
  if(isDefined(var_00)) {
    switch (var_00) {
      case "cryo_mine_mp":
        return 1;
    }

    if(var_01 == "MOD_IMPACT") {
      switch (var_00) {
        case "trip_mine_mp":
        case "splash_grenade_mp":
        case "c4_mp":
          return 1;
      }
    } else {
      switch (var_00) {
        case "gltacburst_big":
        case "gltacburst":
        case "blackout_grenade_mp":
        case "concussion_grenade_mp":
          return 1;
      }
    }
  }

  return 0;
}

deleteallgrenades() {
  if(isDefined(level.grenades)) {
    foreach(var_01 in level.grenades) {
      if(isDefined(var_01) && !scripts\mp\utility\game::istrue(var_1.exploding) && !isplantedequipment(var_01))
        var_01 delete();
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_04 in level.missiles) {
      if(isDefined(var_04) && !scripts\mp\utility\game::istrue(var_4.exploding) && !isplantedequipment(var_04))
        var_04 delete();
    }
  }
}

minegettwohitthreshold() {
  return 80;
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_00 = undefined;
  var_01 = self.owner scripts\mp\utility\game::_hasperk("specialty_rugged_eqp");
  var_02 = scripts\engine\utility::ter_op(var_01, 2, 1);
  var_03 = scripts\engine\utility::ter_op(var_01, "hitequip", "");

  for(;;) {
    self waittill("damage", var_04, var_00, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    var_12 = scripts\mp\utility\game::func_13CA1(var_12, var_16);

    if(!isplayer(var_00) && !isagent(var_00)) {
      continue;
    }
    if(isDefined(var_12) && isendstr(var_12, "betty_mp")) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_00)) {
      continue;
    }
    if(isballweapon(var_12)) {
      continue;
    }
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_00)) {
      continue;
    }
    if(func_66AA(var_12, var_07)) {
      continue;
    }
    var_17 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isfmjdamage(var_12, var_07) || var_04 >= 80, 2, 1);
    var_02 = var_02 - var_17;
    scripts\mp\powers::equipmenthit(self.owner, var_00, var_12, var_07);

    if(var_02 <= 0) {
      break;
    } else
      var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_03);
  }

  self notify("mine_destroyed");

  if(isDefined(var_07) && (issubstr(var_07, "MOD_GRENADE") || issubstr(var_07, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(var_11) && var_11 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_11) && var_11 &level.idflags_no_team_protection)
    self.wasdamagedfrombulletricochet = 1;

  self.wasdamaged = 1;

  if(isDefined(var_00))
    self.damagedby = var_00;

  if(isDefined(self.killcament))
    self.killcament.damagedby = var_00;

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_03);

    if(var_00 != self.owner && var_0.team != self.owner.team)
      var_00 scripts\mp\killstreaks\killstreaks::_meth_83A0();
  }

  if(level.teambased) {
    if(isDefined(var_00) && isDefined(var_0.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(var_0.pers["team"] != self.owner.pers["team"])
        var_00 notify("destroyed_equipment");
    }
  } else if(isDefined(self.owner) && isDefined(var_00) && var_00 != self.owner)
    var_00 notify("destroyed_equipment");

  scripts\mp\missions::minedestroyed(self, var_00, var_07);
  self notify("detonateExplosive", var_00);
}

mineproximitytrigger(var_00, var_01) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_02 = self.config;
  wait(var_2.armtime);

  if(isDefined(var_2.mine_beacon))
    thread doblinkinglight("tag_fx", var_2.mine_beacon["friendly"], var_2.mine_beacon["enemy"]);

  var_03 = scripts\engine\utility::ter_op(isDefined(var_2.minedetectionradius), var_2.minedetectionradius, level.minedetectionradius);
  var_04 = scripts\engine\utility::ter_op(isDefined(var_2.minedetectionheight), var_2.minedetectionheight, level.minedetectionheight);
  var_05 = spawn("trigger_radius", self.origin, 0, var_03, var_04);
  var_5.owner = self;
  thread minedeletetrigger(var_05);

  if(isDefined(var_00)) {
    var_05 getrankxp();
    var_05 linkto(var_00);
  }

  self.damagearea = var_05;
  var_06 = undefined;

  for(;;) {
    var_05 waittill("trigger", var_06);

    if(!isDefined(var_06)) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_06)) {
      continue;
    }
    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.owner)) {
        if(var_06 == self.owner) {
          continue;
        }
        if(isDefined(var_6.owner) && var_6.owner == self.owner)
          continue;
      }

      if(!friendlyfirecheck(self.owner, var_06, 0))
        continue;
    }

    if(lengthsquared(var_06 getentityvelocity()) < 10) {
      continue;
    }
    if(self.weapon_name == "mobile_radar_mp" && !func_B8F7(var_06)) {
      continue;
    }
    if(isDefined(var_01) && var_01 || var_06 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self.config.func_127BF = var_06;

  if(isDefined(self.config.ontriggeredsfx))
    self playSound(self.config.ontriggeredsfx);

  explosivetrigger(var_06, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(var_00) {
  scripts\engine\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_00))
    var_00 delete();
}

func_BBC4() {
  self endon("mine_triggered");
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    equipmentempstunvfx();
    stopblinkinglight();

    if(isDefined(self.damagearea))
      self.damagearea delete();

    self.disabled = 1;
    self notify("disabled");
    wait(var_01);

    if(isDefined(self)) {
      self.disabled = undefined;
      self notify("enabled");
      var_02 = self getlinkedparent();
      thread mineproximitytrigger(var_02);
    }
  }
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.mineselfdestructtime + randomfloat(0.4));
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

minebounce() {
  self playSound(self.config.onlaunchsfx);
  playFX(level.mine_launch, self.origin);

  if(isDefined(self.trigger))
    self.trigger delete();

  var_00 = self.origin + (0, 0, 64);
  self moveto(var_00, 0.7, 0, 0.65);
  self.killcament moveto(var_00 + self.killcamoffset, 0.7, 0, 0.65);
  self rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  thread playspinnerfx();
  wait 0.65;
  self notify("detonateExplosive");
}

mineexplodeonnotify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_00);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = self.owner;

  var_01 = self.config;
  var_02 = var_1.vfxtag;

  if(!isDefined(var_02))
    var_02 = "tag_fx";

  var_03 = self gettagorigin(var_02);

  if(!isDefined(var_03))
    var_03 = self gettagorigin("tag_origin");

  self notify("explode", var_03);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(var_1.onexplodefunc))
    self thread[[var_1.onexplodefunc]]();

  if(isDefined(var_1.onexplodesfx))
    self playSound(var_1.onexplodesfx);

  var_04 = scripts\engine\utility::ter_op(isDefined(var_1.onexplodevfx), var_1.onexplodevfx, level.mine_explode);
  playFX(var_04, var_03);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_07 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);

  if(var_06 > 0)
    self radiusdamage(self.origin, var_07, var_06, var_05, var_00, "MOD_EXPLOSIVE", self.weapon_name);

  if(isDefined(self.owner))
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;
  deleteexplosive();
}

minesensorbounce() {
  self playSound(self.config.onlaunchsfx);
  playFX(self.config.launchvfx, self.origin);

  if(isDefined(self.trigger))
    self.trigger delete();

  self hidepart("tag_sensor");
  stopblinkinglight();
  var_00 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_00 setModel(self.config.model);
  var_00 hidepart("tag_base");
  var_0.config = self.config;
  self.sensor = var_00;
  var_01 = self.origin + (0, 0, self.config.launchheight);
  var_02 = self.config.launchtime;
  var_03 = self.config.launchtime + 0.1;
  var_00 moveto(var_01, var_03, 0, var_02);
  var_00 rotatevelocity((0, 1100, 32), var_03, 0, var_02);
  var_00 thread playspinnerfx();
  wait(var_02);
  self notify("detonateExplosive");
}

func_B77D() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_00);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = self.owner;

  self playSound(self.config.onexplodesfx);
  var_01 = undefined;

  if(isDefined(self.sensor))
    var_01 = self.sensor gettagorigin("tag_sensor");
  else
    var_01 = self gettagorigin("tag_origin");

  playFX(self.config.onexplodevfx, var_01);
  scripts\engine\utility::waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(isDefined(self.sensor))
    self.sensor delete();
  else
    self hidepart("tag_sensor");

  self.owner thread scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  var_02 = [];

  foreach(var_04 in level.characters) {
    if(var_4.team == self.owner.team) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_04)) {
      continue;
    }
    if(var_04 scripts\mp\utility\game::_hasperk("specialty_heartbreaker")) {
      continue;
    }
    if(distance2d(self.origin, var_4.origin) < 300)
      var_2[var_2.size] = var_04;
  }

  foreach(var_07 in var_02) {
    thread func_B37F(var_07, self.owner);
    level thread func_F236(var_07, self.owner);
  }

  if(var_2.size > 0) {
    self.owner scripts\mp\missions::processchallenge("ch_motiondetected", var_2.size);
    self.owner thread scripts\mp\gamelogic::threadedsetweaponstatbyname("motion_sensor", 1, "hits");
  }

  if(isDefined(self.owner))
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;
  deleteexplosive();
}

func_B37F(var_00, var_01) {
  if(var_00 == var_01) {
    return;
  }
  var_00 endon("disconnect");
  var_02 = undefined;

  if(level.teambased)
    var_02 = scripts\mp\utility\game::outlineenableforteam(var_00, "orange", var_1.team, 0, 0, "equipment");
  else
    var_02 = scripts\mp\utility\game::outlineenableforplayer(var_00, "orange", var_01, 0, 0, "equipment");

  var_00 thread scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  scripts\mp\gamescore::func_11ACE(var_01, var_00, "motion_sensor_mp");
  var_00 scripts\engine\utility::waittill_any_timeout(self.config.func_B371, "death");
  scripts\mp\gamescore::untrackdebuffassist(var_01, var_00, "motion_sensor_mp");
  scripts\mp\utility\game::outlinedisable(var_02, var_00);
}

func_F236(var_00, var_01) {
  if(var_00 == var_01) {
    return;
  }
  if(isai(var_00)) {
    return;
  }
  var_02 = "coup_sunblind";
  var_00 setclientomnvar("ui_hud_shake", 1);
  var_00 visionsetnakedforplayer(var_02, 0.05);
  wait 0.05;
  var_00 visionsetnakedforplayer(var_02, 0);
  var_00 visionsetnakedforplayer("", 0.5);
}

func_B8F5() {
  self playSound(self.config.onlaunchsfx);
  playFX(self.config.launchvfx, self.origin);

  if(isDefined(self.trigger))
    self.trigger delete();

  stopblinkinglight();
  var_00 = self.origin + (0, 0, self.config.launchheight);
  var_01 = self.config.launchtime;
  var_02 = self.config.launchtime + 0.1;
  self moveto(var_00, var_02, 0, var_01);
  self rotatevelocity((0, 1100, 32), var_02, 0, var_01);
  thread playspinnerfx();
  wait(var_01);
  self notify("detonateExplosive");
}

func_B8F6() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_00);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = self.owner;

  self playSound(self.config.onexplodesfx);
  var_01 = self gettagorigin("tag_origin");
  playFX(self.config.onexplodevfx, var_01);
  scripts\engine\utility::waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(isDefined(self.config.func_127BF)) {
    var_02 = self.config.func_127BF;
    var_2.func_DBD8 = 1;
    var_02 func_10DC5(self);
  }

  if(isDefined(self.owner)) {
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
    self.owner scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  }

  wait 0.2;
  deleteexplosive();
}

func_10DC5(var_00) {
  var_01 = self gettagorigin("tag_shield_back");
  var_02 = spawn("script_model", var_01);
  var_02 setModel("weapon_mobile_radar_back");
  var_2.func_AC75 = var_0.func_AC75;
  var_2.owner = var_0.owner;
  var_2.config = var_0.config;
  var_02 linkto(self, "tag_shield_back", (0, 0, 0), (0, 90, 90));
  var_02 thread func_D501(self);
  var_02 thread createbombsquadmodel(var_0.config.bombsquadmodel, "tag_origin", var_0.owner);
  var_02 thread minedamagemonitor();
  var_02 thread func_13B1A(self, var_00);
  var_02 thread func_13B1B(self, var_00);
  var_02 thread func_139F0();
}

func_D501(var_00) {
  self endon("death");
  var_01 = self gettagorigin("tag_fx");
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin");
  var_02 linkto(self, "tag_fx", (0, 0, 0), (90, 0, -90));
  var_02 thread func_13A0F(self);

  for(;;) {
    wait 2;
    playFXOnTag(self.config.func_C4C5, var_02, "tag_origin");

    if(isDefined(var_00)) {
      var_00 scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
      var_00 playsoundonmovingent("ball_drone_3Dping");
    } else
      self playSound("ball_drone_3Dping");

    foreach(var_04 in level.players) {
      if(var_4.team != self.owner.team) {
        continue;
      }
      triggerportableradarping(self.origin, var_04);
    }
  }
}

func_13A0F(var_00) {
  self endon("death");
  var_00 waittill("death");
  self delete();
}

func_13B1A(var_00, var_01) {
  self endon("death");

  for(;;) {
    self waittill("detonateExplosive", var_02);
    var_0.func_DBD8 = undefined;
    self.config.func_127BF = undefined;
    self playSound(self.config.onexplodesfx);
    var_03 = self gettagorigin("tag_origin");
    playFX(self.config.onexplodevfx, var_03);
    self delete();
  }
}

func_13B1B(var_00, var_01) {
  self endon("death");
  var_02 = var_1.owner;
  var_03 = var_1.angles;
  var_04 = var_1.func_AC75;
  var_00 waittill("death");
  var_0.func_DBD8 = undefined;
  self.config.func_127BF = undefined;
  func_108E5(var_0.origin, var_02, "mobile_radar_mp", var_03, var_04, 1);
  self delete();
}

func_B8F7(var_00) {
  var_01 = 1;

  if(isDefined(var_0.func_DBD8))
    var_01 = 0;

  if(!isplayer(var_00))
    var_01 = 0;

  return var_01;
}

playspinnerfx() {
  if(isDefined(self.config.mine_spin)) {
    self endon("death");
    var_00 = gettime() + 1000;

    while(gettime() < var_00) {
      wait 0.05;
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin1");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin3");
      wait 0.05;
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin2");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin4");
    }
  }
}

minedamagedebug(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_6[0] = (1, 0, 0);
  var_6[1] = (0, 1, 0);

  if(var_1[2] < var_05)
    var_07 = 0;
  else
    var_07 = 1;

  var_08 = (var_0[0], var_0[1], var_05);
  var_09 = (var_1[0], var_1[1], var_05);
  thread debugcircle(var_08, level.minedamageradius, var_6[var_07], 32);
  var_10 = distancesquared(var_00, var_01);

  if(var_10 > var_02)
    var_07 = 0;
  else
    var_07 = 1;

  thread debugline(var_08, var_09, var_6[var_07]);
}

minedamageheightpassed(var_00, var_01) {
  if(isplayer(var_01) && isalive(var_01) && var_1.sessionstate == "playing")
    var_02 = var_01 scripts\mp\utility\game::getstancecenter();
  else if(var_1.classname == "misc_turret")
    var_02 = var_1.origin + (0, 0, 32);
  else
    var_02 = var_1.origin;

  var_03 = 0;
  var_04 = var_0.origin[2] + var_03 - level.minedamagehalfheight;

  if(var_2[2] < var_04)
    return 0;

  return 1;
}

mineused(var_00, var_01, var_02) {
  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var_00 thread minethrown(self, var_0.weapon_name, var_0.power, var_0.func_1088C, var_02);
}

minethrown(var_00, var_01, var_02, var_03, var_04) {
  self.owner = var_00;
  self waittill("missile_stuck", var_05);

  if(var_01 != "trip_mine_mp") {
    if(isDefined(var_05) && isDefined(var_5.owner)) {
      if(isDefined(var_04))
        self.owner[[var_04]](self);

      self delete();
      return;
    }
  }

  self.owner notify("bouncing_betty_update", 0);

  if(!isDefined(var_00)) {
    return;
  }
  if(var_01 != "sonic_sensor_mp")
    var_06 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  else
    var_06 = scripts\engine\trace::ray_trace(self.origin, self.origin + anglestoup(self.angles * 2));

  var_07 = var_6["position"];

  if(var_6["fraction"] == 1 && var_01 != "sonic_sensor_mp") {
    var_07 = getgroundposition(self.origin, 12, 0, 32);
    var_6["normal"] = var_6["normal"] * -1;
  }

  if(var_01 != "sonic_sensor_mp") {
    var_08 = vectornormalize(var_6["normal"]);
    var_09 = vectortoangles(var_08);
    var_09 = var_09 + (90, 0, 0);
  } else
    var_09 = self.angles;

  var_10 = self[[var_03]](var_07, var_00, var_01, var_02, var_09);
  var_10 makeexplosiveusable();
  var_10 thread minedamagemonitor();
  self delete();
}

func_51CE() {
  if(isDefined(self.plantedlethalequip)) {
    foreach(var_01 in self.plantedlethalequip) {
      if(isDefined(var_01))
        var_01 deleteexplosive();
    }
  }

  if(isDefined(self.plantedtacticalequip)) {
    foreach(var_01 in self.plantedtacticalequip) {
      if(isDefined(var_01))
        var_01 deleteexplosive();
    }
  }

  self.plantedlethalequip = [];
  self.plantedtacticalequip = [];
}

deletedisparateplacedequipment() {
  var_00 = scripts\mp\powers::getcurrentequipment("primary");

  foreach(var_02 in self.plantedlethalequip) {
    if(isDefined(var_02)) {
      if(!isDefined(var_2.func_D77A) || !isDefined(var_00) || var_2.func_D77A != var_00)
        var_02 deleteexplosive();
    }
  }

  var_04 = scripts\mp\powers::getcurrentequipment("secondary");

  foreach(var_02 in self.plantedtacticalequip) {
    if(isDefined(var_02)) {
      if(!isDefined(var_2.func_D77A) || !isDefined(var_04) || var_2.func_D77A != var_04)
        var_02 deleteexplosive();
    }
  }
}

doblinkinglight(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = scripts\engine\utility::getfx("weap_blink_friend");

  if(!isDefined(var_02))
    var_02 = scripts\engine\utility::getfx("weap_blink_enemy");

  self.blinkinglightfx["friendly"] = var_01;
  self.blinkinglightfx["enemy"] = var_02;
  self.blinkinglighttag = var_00;
  thread updateblinkinglight(var_01, var_02, var_00);
  self waittill("death");
  stopblinkinglight();
}

updateblinkinglight(var_00, var_01, var_02) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  var_03 = ::checkteam;

  if(!level.teambased)
    var_03 = ::checkplayer;

  var_04 = randomfloatrange(0.05, 0.25);
  wait(var_04);
  childthread onjointeamblinkinglight(var_00, var_01, var_02, var_03);

  foreach(var_06 in level.players) {
    if(isDefined(var_06)) {
      if(self.owner[[var_03]](var_06))
        playfxontagforclients(var_00, self, var_02, var_06);
      else
        playfxontagforclients(var_01, self, var_02, var_06);

      wait 0.05;
    }
  }
}

onjointeamblinkinglight(var_00, var_01, var_02, var_03) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  for(;;) {
    level waittill("joined_team", var_04);

    if(self.owner[[var_03]](var_04)) {
      playfxontagforclients(var_00, self, var_02, var_04);
      continue;
    }

    playfxontagforclients(var_01, self, var_02, var_04);
  }
}

stopblinkinglight() {
  if(isalive(self) && isDefined(self.blinkinglightfx)) {
    stopFXOnTag(self.blinkinglightfx["friendly"], self, self.blinkinglighttag);
    stopFXOnTag(self.blinkinglightfx["enemy"], self, self.blinkinglighttag);
    self.blinkinglightfx = undefined;
    self.blinkinglighttag = undefined;
  }
}

checkteam(var_00) {
  return self.team == var_0.team;
}

checkplayer(var_00) {
  return self == var_00;
}

equipmentdeathvfx(var_00) {
  playFX(scripts\engine\utility::getfx("equipment_sparks"), self.origin);

  if(!isDefined(var_00) || var_00 == 0)
    self playSound("sentry_explode");
}

equipmentdeletevfx(var_00, var_01) {
  if(isDefined(var_00)) {
    if(isDefined(var_01)) {
      var_02 = anglesToForward(var_01);
      var_03 = anglestoup(var_01);
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_00, var_02, var_03);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_00, var_02, var_03);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_00);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_00);
    }

    playLoopSound(var_00, "mp_killstreak_disappear");
  } else if(isDefined(self)) {
    var_04 = self.origin;
    var_02 = anglesToForward(self.angles);
    var_03 = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("equipment_explode"), var_04, var_02, var_03);
    playFX(scripts\engine\utility::getfx("equipment_smoke"), var_04, var_02, var_03);
    self playSound("mp_killstreak_disappear");
  }
}

equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

buildattachmentmaps() {
  var_00 = getattachmentlistuniquenames();
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.attachmentextralist = [];

  foreach(var_02 in var_00) {
    var_03 = tablelookup("mp\attachmenttable.csv", 4, var_02, 5);

    if(var_02 != var_03)
      level.attachmentmap_uniquetobase[var_02] = var_03;

    var_04 = tablelookup("mp\attachmenttable.csv", 4, var_02, 13);

    if(var_04 != "") {
      level.attachmentmap_uniquetoextra[var_02] = var_04;
      level.attachmentextralist[var_04] = 1;
    }
  }

  var_06 = [];
  var_07 = 1;

  for(var_08 = tablelookupbyrow("mp\attachmentmap.csv", var_07, 0); var_08 != ""; var_08 = tablelookupbyrow("mp\attachmentmap.csv", var_07, 0)) {
    var_6[var_6.size] = var_08;
    var_7++;
  }

  var_09 = [];
  var_10 = 1;

  for(var_11 = tablelookupbyrow("mp\attachmentmap.csv", 0, var_10); var_11 != ""; var_11 = tablelookupbyrow("mp\attachmentmap.csv", 0, var_10)) {
    var_9[var_11] = var_10;
    var_10++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var_08 in var_06) {
    foreach(var_16, var_14 in var_09) {
      var_15 = tablelookup("mp\attachmentmap.csv", 0, var_08, var_14);

      if(var_15 == "") {
        continue;
      }
      if(!isDefined(level.attachmentmap_basetounique[var_08]))
        level.attachmentmap_basetounique[var_08] = [];

      level.attachmentmap_basetounique[var_08][var_16] = var_15;
    }
  }

  level.attachmentmap_attachtoperk = [];

  foreach(var_19 in var_00) {
    var_20 = tablelookup("mp\attachmenttable.csv", 4, var_19, 12);

    if(var_20 == "") {
      continue;
    }
    level.attachmentmap_attachtoperk[var_19] = var_20;
  }

  level.attachmentmap_conflicts = [];
  var_22 = 1;

  for(var_23 = tablelookupbyrow("mp\attachmentcombos.csv", var_22, 0); var_23 != ""; var_23 = tablelookupbyrow("mp\attachmentcombos.csv", var_22, 0)) {
    var_24 = 1;

    for(var_25 = tablelookupbyrow("mp\attachmentcombos.csv", 0, var_24); var_25 != ""; var_25 = tablelookupbyrow("mp\attachmentcombos.csv", 0, var_24)) {
      if(var_23 != var_25) {
        var_26 = tablelookupbyrow("mp\attachmentcombos.csv", var_22, var_24);
        var_27 = scripts\engine\utility::alphabetize([var_23, var_25]);
        var_28 = var_27[0] + "_" + var_27[1];

        if(var_26 == "no" && !isDefined(level.attachmentmap_conflicts[var_28]))
          level.attachmentmap_conflicts[var_28] = 1;
      }

      var_24++;
    }

    var_22++;
  }
}

getattachmentlistuniquenames() {
  var_00 = [];
  var_01 = 0;

  for(var_02 = tablelookup("mp\attachmentTable.csv", 0, var_01, 4); var_02 != ""; var_02 = tablelookup("mp\attachmentTable.csv", 0, var_01, 4)) {
    var_0[var_02] = var_02;
    var_1++;
  }

  return var_00;
}

func_3222() {
  level.weaponmapdata = [];

  for(var_00 = 1; tablelookup("mp\statstable.csv", 0, var_00, 0) != ""; var_0++) {
    var_01 = tablelookup("mp\statstable.csv", 0, var_00, 4);

    if(var_01 != "") {
      level.weaponmapdata[var_01] = spawnStruct();
      var_02 = tablelookup("mp\statstable.csv", 0, var_00, 0);

      if(var_02 != "")
        level.weaponmapdata[var_01].number = var_02;

      var_03 = tablelookup("mp\statstable.csv", 0, var_00, 1);

      if(var_03 != "")
        level.weaponmapdata[var_01].group = var_03;

      var_04 = tablelookup("mp\statstable.csv", 0, var_00, 5);

      if(var_04 != "")
        level.weaponmapdata[var_01].func_23B0 = var_04;

      var_05 = tablelookup("mp\statstable.csv", 0, var_00, 44);

      if(var_05 != "")
        level.weaponmapdata[var_01].perk = var_05;

      var_06 = tablelookup("mp\statstable.csv", 0, var_00, 9);

      if(var_06 != "")
        level.weaponmapdata[var_01].attachdefaults = strtok(var_06, " ");

      level.weaponmapdata[var_01].selectableattachmentlist = [];
      level.weaponmapdata[var_01].selectableattachmentmap = [];

      for(var_07 = 0; var_07 < 20; var_7++) {
        var_08 = tablelookup("mp\statstable.csv", 0, var_00, 10 + var_07);

        if(isDefined(var_08) && var_08 != "") {
          var_09 = level.weaponmapdata[var_01].selectableattachmentlist.size;
          level.weaponmapdata[var_01].selectableattachmentlist[var_09] = var_08;
          level.weaponmapdata[var_01].selectableattachmentmap[var_08] = 1;
        }
      }

      if(level.tactical)
        var_10 = tablelookup("mp\statstable.csv", 0, var_00, 50);
      else
        var_10 = tablelookup("mp\statstable.csv", 0, var_00, 8);

      if(var_10 != "") {
        var_10 = float(var_10);
        level.weaponmapdata[var_01].speed = var_10;
      }
    }
  }
}

func_464F() {
  level endon("game_ended");
  self endon("end_explode");
  self.owner endon("disconnect");
  self waittill("explode", var_00);
  func_464D(var_00);
}

func_464D(var_00) {
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  var_01 = self.owner;
  var_02 = var_01 scripts\mp\utility\game::getotherteam(var_1.team);
  var_03 = undefined;
  var_04 = 0;

  if(level.teambased)
    var_03 = scripts\mp\utility\game::getteamarray(var_02);
  else
    var_03 = level.characters;

  var_05 = [];
  var_06 = getempdamageents(var_00, 256, 0, undefined);

  if(var_6.size >= 1) {
    foreach(var_08 in var_06) {
      if(isDefined(var_8.owner) && !friendlyfirecheck(self.owner, var_8.owner)) {
        continue;
      }
      var_08 notify("emp_damage", self.owner, 5.0);

      foreach(var_10 in var_03) {
        if(var_08 == var_10 || var_08 == self.owner) {
          var_08 thread func_464E();
          var_5[var_5.size] = var_08;
          break;
        }
      }
    }

    foreach(var_14 in var_05) {
      if(var_14 == self.owner) {
        var_04 = 1;
        break;
      }
    }

    if(!var_04) {
      var_14 = var_5[var_5.size - 1];

      if(isDefined(var_14) && var_14 != var_01) {
        var_16 = "primary";
        var_17 = "none";
        var_18 = getarraykeys(var_1.powers);

        foreach(var_20 in var_18) {
          if(var_1.powers[var_20].slot == var_16)
            var_17 = var_20;
        }

        var_22 = var_14.func_AE7B;

        if(isDefined(var_22) && var_22 != "none") {
          var_01 notify("corpse_steal");
          var_01 notify("start_copycat");
          var_01 scripts\mp\powers::removepower(var_17);
          var_01 scripts\mp\powers::givepower(var_22, var_16, 1);
          var_01 thread func_139D7(var_22, var_16);
        }
      }
    }
  }
}

func_139D7(var_00, var_01) {
  self endon("disconnect");
  self endon("death");
  self endon("corpse_steal");
  self waittill("copycat_reset");
  self notify("start_copycat");
  scripts\mp\powers::removepower(var_00);
  scripts\mp\powers::givepower(self.func_AE7B, var_01, 1);
  self setclientomnvar("ui_juggernaut", 0);
}

func_464E() {
  self endon("disconnect");
  self endon("death");
  var_00 = gettime() + 5000.0;
  scripts\mp\powers::power_modifycooldownrate(0.0);

  if(isDefined(self.func_38A1) && self.func_38A1)
    scripts\mp\powers::func_12C9F();

  thread scripts\mp\powers::func_D729();

  while(gettime() < var_00)
    wait 0.1;

  scripts\mp\powers::func_D74E();

  if(isDefined(self.func_38A1) && !self.func_38A1)
    scripts\mp\powers::func_F6B1();

  thread scripts\mp\powers::func_D72F();
}

grenadestuckto(var_00, var_01, var_02) {
  if(!isDefined(self)) {
    var_0.stuckenemyentity = var_01;
    var_1.func_1117F = var_00;
  } else if(level.teambased && isDefined(var_1.team) && var_1.team == self.team)
    var_0.isstuck = "friendly";
  else {
    var_03 = undefined;

    if(glprox_trygetweaponname(var_0.weapon_name) == "stickglprox")
      var_03 = "stickglprox_stuck";
    else {
      switch (var_0.weapon_name) {
        case "semtex_mp":
          var_03 = "semtex_stuck";
          break;
        case "splash_grenade_mp":
          var_03 = "splash_grenade_stuck";
          break;
        case "power_spider_grenade_mp":
          var_03 = "spider_grenade_stuck";
          break;
        case "wristrocket_proj_mp":
          var_03 = "wrist_rocket_stuck";
      }
    }

    var_0.isstuck = "enemy";
    var_0.stuckenemyentity = var_01;

    if(var_0.weapon_name == "split_grenade_mp")
      var_1.func_1117F = undefined;
    else {
      var_1.func_1117F = var_00;
      self notify("grenade_stuck_enemy");
    }

    if(!scripts\mp\utility\game::istrue(var_02))
      func_85DE(var_03, var_01);
  }
}

func_85DE(var_00, var_01) {
  if(isplayer(var_01) && isDefined(var_00))
    var_01 scripts\mp\hud_message::showsplash(var_00, undefined, self);

  thread scripts\mp\awards::givemidmatchaward("explosive_stick");
}

func_66A5(var_00, var_01) {
  if(var_00 scripts\mp\powers::func_D734(var_01) > 0)
    return 0;

  var_02 = undefined;

  switch (var_01) {
    case "power_explodingDrone":
      var_02 = var_0.func_69D6;
      break;
    case "power_c4":
      var_02 = var_0.plantedlethalequip;
      break;
    case "power_transponder":
      var_02 = var_0.plantedtacticalequip;
      break;
  }

  if(!isDefined(var_02) || var_2.size == 0)
    return 0;

  return 1;
}

func_10884(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnmine(var_00, var_01, var_02, var_03, var_04);
  var_5.func_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.func_76CF setscriptmoverkillcam("explosive");
  thread cleanupflashanim(var_5.func_76CF, var_05);
  return var_05;
}

cleanupflashanim(var_00, var_01) {
  var_01 waittill("death");
  wait 20.0;
  var_00 delete();
}

func_10832(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnmine(var_00, var_01, var_02, var_03, var_04);
  var_5.func_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.func_76CF setscriptmoverkillcam("explosive");
  thread func_40E6(var_5.func_76CF, var_05);
  var_01 notify("powers_blackholeGrenade_used", 1);
  return var_05;
}

func_40E6(var_00, var_01) {
  var_01 waittill("death");
  wait 20.0;
  var_00 delete();
}

func_1082C(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnmine(var_00, var_01, var_02, var_03, var_04);
  var_5.func_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.func_76CF setscriptmoverkillcam("explosive");
  thread func_40E4(var_5.func_76CF, var_05);
  return var_05;
}

func_40E4(var_00, var_01) {
  var_01 waittill("death");
  wait 20.0;
  var_00 delete();
}

func_10843(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnmine(var_00, var_01, var_02, var_03, var_04);
  var_5.func_4ACD = spawn("script_model", var_5.killcament.origin);
  var_5.func_4ACD setscriptmoverkillcam("explosive");
  thread func_40F1(var_5.func_4ACD, var_05);
  var_01 notify("powers_cryoGrenade_used", 1);
  return var_05;
}

func_40F1(var_00, var_01) {
  var_01 waittill("death");
  wait 20.0;
  var_00 delete();
}

func_1090D(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnmine(var_00, var_01, var_02, var_03, var_04);
  var_5.func_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.func_76CF setscriptmoverkillcam("explosive");
  thread func_4117(var_5.func_76CF, var_05);
  self notify("powers_shardBall_used", 1);
  return var_05;
}

func_4117(var_00, var_01) {
  var_01 waittill("death");
  wait 20.0;
  var_00 delete();
}

outlineequipmentforowner(var_00, var_01) {
  var_02 = scripts\mp\utility\game::outlineenableforplayer(var_00, "white", var_01, 0, 0, "equipment");
  var_00 waittill("death");
  scripts\mp\utility\game::outlinedisable(var_02, var_00);
}

outlinesuperequipment(var_00, var_01) {
  if(level.teambased)
    thread outlinesuperequipmentforteam(var_00, var_01);
  else
    thread outlinesuperequipmentforplayer(var_00, var_01);
}

outlinesuperequipmentforteam(var_00, var_01) {
  var_02 = scripts\mp\utility\game::outlineenableforteam(var_00, "cyan", var_1.team, 0, 0, "killstreak");
  var_00 waittill("death");
  scripts\mp\utility\game::outlinedisable(var_02, var_00);
}

outlinesuperequipmentforplayer(var_00, var_01) {
  var_02 = scripts\mp\utility\game::outlineenableforplayer(var_00, "cyan", var_01, 0, 0, "killstreak");
  var_00 waittill("death");
  scripts\mp\utility\game::outlinedisable(var_02, var_00);
}

_meth_85BE() {
  if(!isDefined(self._meth_85BE) || self._meth_85BE == "none")
    return 0;

  return 1;
}

func_7EE4() {
  if(!isDefined(self._meth_85BE))
    return "none";
  else
    return self._meth_85BE;
}

func_13A93() {
  self notify("watchGrenadeHeldAtDeath");
  self endon("watchGrenadeHeldAtDeath");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self._meth_85BE = scripts\mp\utility\game::func_7EE5();
    scripts\engine\utility::waitframe();
  }
}

trace_impale(var_00, var_01) {
  var_02 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_03 = scripts\engine\trace::ray_trace_detail(var_00, var_01, level.players, var_02, undefined, 1);
  return var_03;
}

impale_endpoint(var_00, var_01) {
  var_02 = var_00 + var_01 * 4096;
  return var_02;
}

impale(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_01 endon("death");
  var_01 endon("disconnect");

  if(!isDefined(var_1.body)) {
    return;
  }
  var_09 = var_00 scripts\mp\utility\game::_hasperk("passive_power_melee");

  if(var_09)
    var_06 = "torso";
  else
    playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), var_04);

  var_10 = impale_endpoint(var_04, var_05);
  var_11 = trace_impale(var_04, var_10);
  var_10 = var_11["position"] - var_05 * 12;
  var_12 = length(var_10 - var_04);
  var_13 = var_12 / scripts\engine\utility::ter_op(var_09, 600, 1000);
  var_13 = max(var_13, 0.05);

  if(var_11["hittype"] != "hittype_world")
    var_13 = 0;

  var_14 = var_13 > 0.05;

  if(isDefined(var_01))
    var_1.body startragdoll();

  wait 0.05;

  if(var_14) {
    var_15 = var_05;
    var_16 = anglestoup(var_0.angles);
    var_17 = vectorcross(var_15, var_16);
    var_18 = scripts\engine\utility::spawn_tag_origin(var_04, _axistoangles(var_15, var_17, var_16));
    var_18 moveto(var_10, var_13);
    var_19 = spawnragdollconstraint(var_1.body, var_06, var_07, var_08);
    var_19.origin = var_18.origin;
    var_19.angles = var_18.angles;
    var_19 linkto(var_18);

    if(var_13 > scripts\engine\utility::ter_op(var_09, 0.075, 1))
      thread impale_detachaftertime(var_19, scripts\engine\utility::ter_op(var_09, 0.075, 1));

    thread impale_cleanup(var_01, var_18, var_13 + 0.25);

    if(!var_09)
      var_18 thread impale_effects(var_10, var_13);
  }
}

impale_detachaftertime(var_00, var_01) {
  wait(var_01);

  if(isDefined(var_00))
    var_00 delete();
}

impale_effects(var_00, var_01) {
  wait(clamp(var_01 - 0.05, 0.05, 20));
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), var_00);
}

impale_cleanup(var_00, var_01, var_02) {
  if(isDefined(var_00))
    var_00 scripts\engine\utility::waittill_any_timeout(var_02, "death", "disconnect");

  var_01 delete();
}

codecallback_getprojectilespeedscale(var_00, var_01) {
  return [1.0, 1.0];
}

func_9F3C(var_00, var_01) {
  return isDefined(level.weaponmapdata[var_00].selectableattachmentmap[var_01]);
}

func_F7FC() {
  if(!isDefined(self.isstunned))
    self.isstunned = 1;
  else
    self.isstunned++;
}

func_F800() {
  self.isstunned--;
}

isstunned() {
  return isDefined(self.isstunned) && self.isstunned > 0;
}

func_F7EE() {
  if(!isDefined(self.isblinded))
    self.isblinded = 1;
  else
    self.isblinded++;
}

func_F7FF() {
  self.isblinded--;
}

isblinded() {
  return isDefined(self.isblinded) && self.isblinded > 0;
}

isstunnedorblinded() {
  return isblinded() || isstunned();
}

func_40EA(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(var_00);
  func_F800();
}

func_A008(var_00) {
  var_01 = getweaponbasename(var_00);

  switch (var_01) {
    case "iw7_sonic_mp":
      return 1;
  }

  return 0;
}

func_20E4() {
  self endon("death");
  self endon("disconnect");
  wait 0.1;

  if(isDefined(self) && isplayer(self) && !isbot(self)) {
    self playlocalsound("sonic_shotgun_debuff");
    self setsoundsubmix("sonic_shotgun_impact");
  }
}

func_13AB2() {
  level endon("lethal_delay_end");
  level endon("round_end");
  level endon("game_ended");
  level waittill("prematch_over");
  level.func_ABBF = getdvarfloat("scr_lethalDelay", 0);

  if(level.func_ABBF == 0) {
    level.func_ABC2 = scripts\mp\utility\game::gettimepassed();
    level.func_ABC0 = level.func_ABC2;
    level notify("lethal_delay_end");
  }

  level.func_ABC2 = scripts\mp\utility\game::gettimepassed();
  level.func_ABC0 = level.func_ABC2 + level.func_ABBF * 1000;
  level notify("lethal_delay_start");

  while(scripts\mp\utility\game::gettimepassed() < level.func_ABC0)
    scripts\engine\utility::waitframe();

  level notify("lethal_delay_end");
}

func_13AB5(var_00, var_01, var_02) {
  var_00 endon("death");
  var_00 endon("disconnect");
  level endon("round_end");
  level endon("game_ended");

  if(func_ABC1()) {
    return;
  }
  self notify("watchLethalDelayPlayer_" + var_02);
  self endon("watchLethalDelayPlayer_" + var_02);
  self endon("power_removed_" + var_01);
  var_00 scripts\mp\powers::func_D727(var_01);
  func_13AB4(var_00, var_02);
  var_00 scripts\mp\powers::func_D72D(var_01);
}

func_13AB4(var_00, var_01) {
  level endon("lethal_delay_end");

  if(!scripts\mp\utility\game::istrue(scripts\mp\utility\game::gameflag("prematch_done")))
    level waittill("lethal_delay_start");

  var_02 = "+frag";

  if(var_01 != "primary")
    var_02 = "+smoke";

  if(!isbot(var_00))
    var_00 notifyonplayercommand("lethal_attempt_" + var_01, var_02);

  for(;;) {
    self waittill("lethal_attempt_" + var_01);
    var_03 = (level.func_ABC0 - scripts\mp\utility\game::gettimepassed()) / 1000;
    var_03 = int(max(0, ceil(var_03)));
    var_00 scripts\mp\hud_message::showerrormessage("MP_LETHALS_UNAVAILABLE_FOR_N", var_03);
  }
}

cancellethaldelay() {
  level.func_ABBF = 0;
  level.func_ABC2 = scripts\mp\utility\game::gettimepassed();
  level.func_ABC0 = level.func_ABC2;
  level notify("lethal_delay_end");
}

func_ABC1(var_00) {
  if(isDefined(level.func_ABBF) && level.func_ABBF == 0)
    return 1;

  return isDefined(level.func_ABC0) && scripts\mp\utility\game::gettimepassed() > level.func_ABC0;
}

func_13AA9() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_switch_invalid", var_00);
    var_01 = self getcurrentweapon();
    var_02 = weaponinventorytype(var_01);

    if(var_02 == "item" || var_02 == "exclusive")
      scripts\mp\utility\game::_switchtoweapon(self.lastdroppableweaponobj);
  }
}

func_13C98(var_00) {
  var_01 = scripts\mp\utility\game::getweaponrootname(var_00);
  var_02 = getweaponattachments(var_00);

  foreach(var_04 in var_02) {
    var_05 = func_248C(var_04);

    if(var_05 == "rail") {
      var_06 = scripts\mp\utility\game::attachmentmap_tobase(var_04);

      if(func_9F3C(var_01, var_06))
        return 1;
    }
  }

  return 0;
}

watchdropweapons() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_dropped", var_00, var_01);

    if(isDefined(var_00) && isDefined(var_01)) {}
  }
}

watchgrenadeaxepickup(var_00, var_01) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.weapon_name) && isDefined(var_01))
    self.weapon_name = var_01;

  self.inphase = 0;

  if(isDefined(var_00))
    self.inphase = var_00 isinphase();

  self waittill("missile_stuck", var_02, var_03);

  if(isDefined(var_02) && (isplayer(var_02) || isagent(var_02))) {
    var_04 = var_03 == "tag_flicker";
    var_05 = var_03 == "tag_top_flicker";
    var_06 = var_02 scripts\mp\utility\game::_hasperk("specialty_rearguard") && var_03 == "tag_origin";
    var_07 = isDefined(var_03) && (var_04 || var_05 || var_06);
    var_08 = isDefined(var_03) && var_03 == "tag_weapon";

    if(var_07) {
      playFX(scripts\engine\utility::getfx("shield_metal_impact"), self.origin);

      if(isDefined(self.owner)) {
        var_09 = self.owner;
        relaunchaxe(self.weapon_name, var_09, 1);
        return;
      }
    } else if(!scripts\mp\utility\game::istrue(var_07) && isplayer(var_02) && !scripts\mp\utility\game::isreallyalive(var_02) && (level.mapname == "mp_neon" || scripts\mp\utility\game::istrue(level.func_DC24)))
      return;
  }

  var_00 thread func_11825(var_00, self);
  var_10 = 45;
  thread watchaxetimeout(var_10);
  thread watchgrenadedeath();
  thread watchaxeuse(var_00, self.weapon_name);
  thread watchaxeautopickup(var_00, self.weapon_name);
}

axedetachfromcorpse(var_00) {
  level endon("game_ended");
  var_01 = var_00 getlinkedchildren();

  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_04 = var_3.weapon_name;
    var_05 = var_3.owner;
    var_06 = var_3.origin;

    if(isDefined(var_04) && isaxeweapon(var_04))
      var_03 relaunchaxe(var_04, var_05, 1);
  }
}

relaunchaxe(var_00, var_01, var_02) {
  self unlink();
  var_03 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);
  var_04 = getsubstr(var_00, var_3.size);
  var_05 = var_01 scripts\mp\utility\game::_launchgrenade("iw7_axe_mp_dummy" + var_04, self.origin, (0, 0, 0), 100, 1, self);
  var_05 setentityowner(var_01);
  var_05 thread watchgrenadeaxepickup(var_01, self.weapon_name);

  if(scripts\mp\utility\game::istrue(var_02)) {
    self.inphase = 0;
    self.func_FF03 = 0;
  }
}

watchaxetimeout(var_00) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self delete();
}

watchaxeautopickup(var_00, var_01) {
  self endon("death");
  level endon("game_ended");
  var_02 = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  var_02 getrankxp();
  var_02 linkto(self);
  self.knife_trigger = var_02;
  var_02 endon("death");

  for(;;) {
    var_02 waittill("trigger", var_00);

    if(!isplayer(var_00)) {
      continue;
    }
    if(var_00 playercanautopickupaxe(self)) {
      var_00 playerpickupaxe(var_01, 1);
      self delete();
      break;
    }
  }
}

watchaxeuse(var_00, var_01) {
  self endon("death");
  level endon("game_ended");
  var_02 = spawn("script_model", self.origin);
  var_02 linkto(self);
  self.useobj_trigger = var_02;
  var_02 makeusable();
  var_02 setcursorhint("HINT_NOICON");
  var_02 _meth_84A9("show");
  var_02 sethintstring(&"WEAPON_PICKUP_AXE");
  var_02 _meth_84A6(360);
  var_02 setusefov(360);
  var_02 _meth_84A4(64);
  var_02 setuserange(64);
  var_02 setusepriority(0);
  thread watchallplayerphasestates(var_02);
  var_02 waittill("trigger", var_00);
  var_00 playerpickupaxe(var_01, 0);
  self delete();
}

watchallplayerphasestates(var_00) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    foreach(var_02 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_02)) {
        continue;
      }
      if(!axeinsamephaseplayerstate(self, var_02)) {
        var_00 disableplayeruse(var_02);
        continue;
      }

      var_00 enableplayeruse(var_02);
    }

    scripts\engine\utility::waitframe();
  }
}

axeinsamephaseplayerstate(var_00, var_01) {
  var_02 = 1;

  if(scripts\mp\utility\game::istrue(var_0.inphase) && !var_01 isinphase())
    var_02 = 0;
  else if(!scripts\mp\utility\game::istrue(var_0.inphase) && var_01 isinphase())
    var_02 = 0;

  return var_02;
}

playercanautopickupaxe(var_00) {
  if(isDefined(var_0.owner) && self != var_0.owner)
    return 0;

  var_01 = self getweaponslistprimaries();
  var_02 = 0;
  var_03 = 0;

  foreach(var_05 in var_01) {
    if(isaxeweapon(var_05) && self getweaponammoclip(var_05) == 0) {
      var_02 = 1;
      break;
    }

    if(issubstr(var_05, "iw7_fists_mp")) {
      var_02 = 1;
      break;
    }

    if(!issubstr(var_05, "alt_"))
      var_3++;
  }

  if(var_03 < 2)
    var_02 = 1;

  if(scripts\mp\utility\game::istrue(var_02)) {
    if(!axeinsamephaseplayerstate(var_00, self))
      var_02 = 0;
  }

  return var_02;
}

playerpickupaxe(var_00, var_01) {
  var_02 = scripts\mp\utility\game::func_E0CF(var_00);
  var_03 = self getcurrentweapon();
  var_04 = self getweaponslistprimaries();

  if(self hasweapon(var_00)) {
    var_05 = self getweaponammoclip(var_00);

    if(!var_01 && var_05 > 0) {
      self dropitem(var_00);
      scripts\mp\utility\game::_giveweapon(var_02);
    } else if(!issubstr(var_03, var_00)) {
      scripts\mp\utility\game::_takeweapon(var_00);
      scripts\mp\utility\game::_giveweapon(var_02);
    }

    var_06 = self getweaponammoclip(var_03) == 0 && isaxeweapon(var_03);
    var_07 = issubstr(var_03, "iw7_fists_mp");

    if(!var_01 || var_07 || var_06)
      scripts\mp\utility\game::_switchtoweapon(var_02);

    self setweaponammoclip(var_02, 1);
    scripts\mp\hud_message::showmiscmessage("axe");
    return;
  }

  var_08 = undefined;
  var_09 = 0;

  foreach(var_11 in var_04) {
    if(issubstr(var_11, "alt_")) {
      continue;
    }
    if(issubstr(var_11, "uplinkball")) {
      continue;
    }
    var_12 = self getweaponammoclip(var_11) == 0 && isaxeweapon(var_11);

    if(!isDefined(var_08) && (weaponispreferreddrop(var_11) || var_12))
      var_08 = var_11;

    var_9++;
  }

  var_14 = undefined;

  if(isDefined(var_08))
    var_14 = var_08;
  else if(var_09 >= 2)
    var_14 = var_03;

  var_15 = !var_01 || isDefined(var_14) && issubstr(var_03, var_14);

  if(isDefined(var_14)) {
    var_12 = self getweaponammoclip(var_14) == 0 && isaxeweapon(var_14);
    var_16 = var_14 == "iw7_fists_mp";
    var_17 = weaponcandrop(var_14) && !var_12;

    if(var_17) {
      var_18 = self dropitem(var_14);

      if(isDefined(var_18)) {
        if(isDefined(self.tookweaponfrom[var_14])) {
          var_18.owner = self.tookweaponfrom[var_14];
          self.tookweaponfrom[var_14] = undefined;
        } else
          var_18.owner = self;

        var_18.targetname = "dropped_weapon";
        var_18 thread watchpickup();
        var_18 thread deletepickupafterawhile();
      }
    } else if(!var_17 && !(var_16 && var_09 < 2) && !(var_12 && var_09 < 2))
      self giveuponsuppressiontime(var_14);
  }

  scripts\mp\utility\game::_giveweapon(var_02);
  self setweaponammoclip(var_02, 1);

  if(var_15)
    scripts\mp\utility\game::_switchtoweapon(var_02);

  scripts\mp\hud_message::showmiscmessage("axe");
  fixupplayerweapons(self, var_02);
}

callback_finishweaponchange(var_00, var_01, var_02, var_03) {
  updatecamoscripts(var_00, var_01, var_02, var_03);
  updateholidayweaponsounds(var_00, var_01, var_02, var_03);
  updateweaponscriptvfx(var_00, var_01, var_02, var_03);

  if(level.ingraceperiod > 0)
    thread watchrigchangeforweaponfx(var_00, var_01, var_02, var_03);

  scripts\mp\missions::monitorweaponpickup(var_00);
}

watchrigchangeforweaponfx(var_00, var_01, var_02, var_03) {
  self notify("rigChangedDuringGraceperiod");
  self endon("rigChangedDuringGraceperiod");
  self endon("graceperiod_done");

  while(level.ingraceperiod > 0) {
    self waittill("changed_kit");

    if(isDefined(var_01) && var_01 != "none")
      updateweaponscriptvfx(var_00, var_01, var_02, var_03);
  }
}

updateholidayweaponsounds(var_00, var_01, var_02, var_03) {
  var_04 = getweaponvariantindex(var_00);

  if(scripts\mp\class::isholidayweapon(var_00, var_04))
    self _meth_8460("special_foley", "bells", 2);
  else
    self _meth_8460("special_foley", "", 0.1);
}

updateweaponscriptvfx(var_00, var_01, var_02, var_03) {
  if((var_01 == "none" || var_01 == "alt_none") && isDefined(self.lastdroppableweaponobj)) {
    if(var_01 == "alt_none")
      var_03 = 1;
    else
      var_03 = 0;

    var_01 = self.lastdroppableweaponobj;
  }

  clearweaponscriptvfx(var_01, var_03);
  runweaponscriptvfx(var_00, var_02);
}

runweaponscriptvfx(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  if(isDefined(var_01) && var_01 == 1)
    var_02 = "alt_" + scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);
  else
    var_02 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);

  switch (var_02) {
    case "alt_iw7_rvn_mp":
      self setscriptablepartstate("rvnFXView", "VFX_base", 0);

      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self))
        self setscriptablepartstate("rvnFXWorld", "activePhase", 0);
      else
        self setscriptablepartstate("rvnFXWorld", "active", 0);

      break;
    case "alt_iw7_rvn_mpl_burst6":
    case "alt_iw7_rvn_mpl":
      self setscriptablepartstate("rvnFXView", "VFX_epic", 0);

      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self))
        self setscriptablepartstate("rvnFXWorld", "activePhase", 0);
      else
        self setscriptablepartstate("rvnFXWorld", "active", 0);

      break;
    case "alt_iw7_gauss_mpl":
    case "alt_iw7_gauss_mp_burst3":
    case "alt_iw7_gauss_mp_burst2":
    case "alt_iw7_gauss_mp":
    case "iw7_gauss_mp_burst3":
    case "iw7_gauss_mp_burst2":
    case "iw7_gauss_mp":
    case "iw7_gauss_mpl":
      self setscriptablepartstate("gaussFXView", "VFX_base", 0);

      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self))
        self setscriptablepartstate("gaussFXWorld", "activePhase", 0);
      else
        self setscriptablepartstate("gaussFXWorld", "active", 0);

      thread chargefxwatcher();
      break;
  }
}

clearweaponscriptvfx(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  if(isDefined(var_01) && var_01 == 1)
    var_02 = "alt_" + scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);
  else
    var_02 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);

  switch (var_02) {
    case "alt_iw7_rvn_mp":
      self setscriptablepartstate("rvnFXView", "neutral", 0);
      self setscriptablepartstate("rvnFXWorld", "neutral", 0);
      break;
    case "alt_iw7_rvn_mpl_burst6":
    case "alt_iw7_rvn_mpl":
      self setscriptablepartstate("rvnFXView", "neutral", 0);
      self setscriptablepartstate("rvnFXWorld", "neutral", 0);
      break;
    case "alt_iw7_gauss_mpl":
    case "alt_iw7_gauss_mp_burst3":
    case "alt_iw7_gauss_mp_burst2":
    case "alt_iw7_gauss_mp":
    case "iw7_gauss_mp_burst3":
    case "iw7_gauss_mp_burst2":
    case "iw7_gauss_mp":
    case "iw7_gauss_mpl":
      self setscriptablepartstate("gaussFXView", "neutral", 0);
      self setscriptablepartstate("gaussFXWorld", "neutral", 0);
      self notify("clear_chargeFXWatcher");
      break;
  }
}

chargefxwatcher() {
  self endon("clear_chargeFXWatcher");
  self setscriptablepartstate("gaussFXWorld", "neutral", 0);
  thread chargedeathwatcher();

  for(;;) {
    if(!scripts\mp\utility\game::isreallyalive(self)) {
      break;
    }
    self waittill("weapon_charge_update_tag_count", var_00);

    if(var_00 >= 7) {
      self setscriptablepartstate("gaussFXWorld", "active", 0);
      self waittill("weapon_charge_update_tag_count", var_00);
      self setscriptablepartstate("gaussFXWorld", "neutral", 0);
    }

    wait 0.1;
  }
}

chargedeathwatcher() {
  self endon("clear_chargeFXWatcher");
  self waittill("death");
  self setscriptablepartstate("gaussFXWorld", "neutral", 0);
  self notify("clear_chargeFXWatcher");
}

updatecamoscripts(var_00, var_01, var_02, var_03) {
  var_04 = getweaponcamoname(var_00);
  var_05 = getweaponcamoname(var_01);

  if(!isDefined(var_04))
    var_04 = "none";

  if(!isDefined(var_05))
    var_05 = "none";

  clearcamoscripts(var_01, var_05);
  runcamoscripts(var_00, var_04);
}

runcamoscripts(var_00, var_01) {
  if(!isDefined(var_01)) {
    return;
  }
  switch (var_01) {
    case "camo31":
      thread mw2_camo_31();
      break;
    case "camo84":
      thread blood_camo_84();
      break;
  }
}

clearcamoscripts(var_00, var_01) {
  if(!isDefined(var_01)) {
    return;
  }
  switch (var_01) {
    case "camo31":
      self notify("mw2_camo_31");
      break;
    case "camo84":
      self notify("blood_camo_84");
      break;
  }
}

mw2_camo_31() {
  self endon("disconnect");
  self endon("death");
  self endon("mw2_camo_31");

  if(!isDefined(self.pers["mw2CamoKillCount"]))
    self.pers["mw2CamoKillCount"] = 0;

  self setscriptablepartstate("camo_31", self.pers["mw2CamoKillCount"] + "_kills");

  for(;;) {
    self waittill("kill_event_buffered");
    self.pers["mw2CamoKillCount"] = self.pers["mw2CamoKillCount"] + 1;

    if(self.pers["mw2CamoKillCount"] > 7)
      self.pers["mw2CamoKillCount"] = 0;

    self setscriptablepartstate("camo_31", self.pers["mw2CamoKillCount"] + "_kills");
  }
}

blood_camo_84() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");

  if(isDefined(self.bloodcamokillcount))
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  else
    self.bloodcamokillcount = 0;

  while(self.bloodcamokillcount < 13) {
    self waittill("kill_event_buffered");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  }
}