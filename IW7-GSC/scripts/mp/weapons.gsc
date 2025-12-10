/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\weapons.gsc
**********************************/

func_248C(param_00) {
  return tablelookup("mp\attachmentTable.csv", 4, param_00, 2);
}

init() {
  level.var_EBCF = 1;
  level.var_EBD0 = 1;
  level._effect["item_fx_legendary"] = loadfx("vfx\iw7\_requests\mp\vfx_weap_loot_legendary.vfx");
  level._effect["item_fx_rare"] = loadfx("vfx\iw7\_requests\mp\vfx_weap_loot_rare.vfx");
  level._effect["item_fx_common"] = loadfx("vfx\iw7\_requests\mp\vfx_weap_loot_common.vfx");
  level._effect["shield_metal_impact"] = loadfx("vfx\iw7\core\impact\weapon\md\vfx_imp_md_metal.vfx");
  level.maxperplayerexplosives = max(scripts\mp\utility::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
  level.riotshieldxpbullets = scripts\mp\utility::getintproperty("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");
  switch (scripts\mp\utility::getintproperty("perk_scavengerMode", 0)) {
    case 1:
      level.var_EBCF = 0;
      break;

    case 2:
      level.var_EBD0 = 0;
      break;

    case 3:
      level.var_EBCF = 0;
      level.var_EBD0 = 0;
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
  scripts\mp\utility::func_CC18();
  level.weaponconfigs = [];
  if(!isDefined(level.weapondropfunction)) {
    level.weapondropfunction = ::dropweaponfordeath;
  }

  var_00 = 70;
  level.claymoredetectiondot = cos(var_00);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.5;
  level.claymoredetonateradius = 192;
  var_01 = 25;
  level.var_10F8F = cos(var_01);
  level.var_10F91 = 15;
  level.var_10F90 = 0.35;
  level.var_10F92 = 256;
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
  var_02.model = "projectile_bouncing_betty_grenade";
  var_02.bombsquadmodel = "projectile_bouncing_betty_grenade_bombsquad";
  var_02.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_02.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_02.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_02.armtime = 2;
  var_02.ontriggeredsfx = "mine_betty_click";
  var_02.onlaunchsfx = "mine_betty_spin";
  var_02.onexplodesfx = "frag_grenade_explode";
  var_02.launchheight = 64;
  var_02.launchtime = 0.65;
  var_02.ontriggeredfunc = ::minebounce;
  var_02.headiconoffset = 20;
  level.weaponconfigs["bouncingbetty_mp"] = var_02;
  level.weaponconfigs["alienbetty_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "weapon_semtex_grenade_iw6";
  var_02.bombsquadmodel = "weapon_semtex_grenade_iw6_bombsquad";
  var_02.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_02.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_02.armtime = 2;
  var_02.ontriggeredsfx = "mine_betty_click";
  var_02.onexplodesfx = "frag_grenade_explode";
  var_02.ontriggeredfunc = ::minebounce;
  var_02.headiconoffset = 20;
  level.weaponconfigs["sticky_mine_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "weapon_motion_sensor";
  var_02.bombsquadmodel = "weapon_motion_sensor_bombsquad";
  var_02.mine_beacon["enemy"] = scripts\engine\utility::getfx("weap_blink_enemy");
  var_02.mine_beacon["friendly"] = scripts\engine\utility::getfx("weap_blink_friend");
  var_02.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_02.armtime = 2;
  var_02.ontriggeredsfx = "motion_click";
  var_02.ontriggeredfunc = ::minesensorbounce;
  var_02.onlaunchsfx = "motion_spin";
  var_02.launchvfx = level.mine_launch;
  var_02.launchheight = 64;
  var_02.launchtime = 0.65;
  var_02.onexplodesfx = "motion_explode_default";
  var_02.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_02.headiconoffset = 25;
  var_02.var_B371 = 4;
  level.weaponconfigs["motion_sensor_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "weapon_mobile_radar";
  var_02.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_02.mine_beacon["enemy"] = scripts\engine\utility::getfx("weap_blink_enemy");
  var_02.mine_beacon["friendly"] = scripts\engine\utility::getfx("weap_blink_friend");
  var_02.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_02.armtime = 2;
  var_02.ontriggeredsfx = "motion_click";
  var_02.ontriggeredfunc = ::func_B8F5;
  var_02.onlaunchsfx = "motion_spin";
  var_02.launchvfx = level.mine_launch;
  var_02.launchheight = 40;
  var_02.launchtime = 0.35;
  var_02.onexplodesfx = "motion_explode_default";
  var_02.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_02.var_C4C5 = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_02.headiconoffset = 25;
  var_02.var_B371 = 4;
  level.weaponconfigs["mobile_radar_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.armingdelay = 1.5;
  var_02.detectionradius = 232;
  var_02.detectionheight = 512;
  var_02.detectiongraceperiod = 1;
  var_02.headiconoffset = 20;
  var_02.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var_02;
  var_02 = spawnStruct();
  var_03 = 800;
  var_04 = 200;
  var_02.radius_max_sq = var_03 * var_03;
  var_02.radius_min_sq = var_04 * var_04;
  var_02.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_flashbang.vfx");
  var_02.onexplodesfx = "flashbang_explode_default";
  var_02.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var_02;
  var_02 = spawnStruct();
  var_03 = 800;
  var_04 = 200;
  var_02.radius_max_sq = var_03 * var_03;
  var_02.radius_min_sq = var_04 * var_04;
  var_02.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_flashbang.vfx");
  var_02.var_C523 = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_charge");
  var_02.var_D828 = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_laser");
  var_02.onexplodesfx = "flashbang_explode_default";
  var_02.vfxradius = 72;
  level.weaponconfigs["throwingknifedisruptor_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "weapon_sonic_sensor_wm";
  var_02.bombsquadmodel = "weapon_motion_sensor_bombsquad";
  var_02.mine_beacon["enemy"] = scripts\engine\utility::getfx("weap_blink_enemy");
  var_02.mine_beacon["friendly"] = scripts\engine\utility::getfx("weap_blink_friend");
  var_02.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_02.armtime = 2;
  var_02.ontriggeredsfx = "motion_click";
  var_02.onlaunchsfx = "motion_spin";
  var_02.launchvfx = level.mine_launch;
  var_02.launchheight = 64;
  var_02.launchtime = 0.65;
  var_02.onexplodesfx = "motion_explode_default";
  var_02.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_02.headiconoffset = 25;
  var_02.var_B371 = 4;
  level.weaponconfigs["sonic_sensor_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "weapon_mobile_radar";
  var_02.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_02.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_02.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_02.mine_spin = loadfx("vfx\misc\bouncing_betty_swirl");
  var_02.armtime = 0.05;
  var_02.minedamagemin = 0;
  var_02.minedamagemax = 0;
  var_02.ontriggeredsfx = "motion_click";
  var_02.onlaunchsfx = "motion_spin";
  var_02.onexplodesfx = "motion_explode_default";
  var_02.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_02.launchheight = 64;
  var_02.launchtime = 0.65;
  var_02.ontriggeredfunc = ::scripts\mp\equipment\fear_grenade::func_6BBC;
  var_02.onexplodefunc = ::scripts\mp\equipment\fear_grenade::func_6BBB;
  var_02.headiconoffset = 20;
  var_02.minedetectionradius = 200;
  var_02.minedetectionheight = 100;
  level.weaponconfigs["fear_grenade_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "prop_mp_speed_strip_temp";
  var_02.bombsquadmodel = "prop_mp_speed_strip_temp";
  var_02.armtime = 0.05;
  var_02.vfxtag = "tag_origin";
  var_02.minedamagemin = 0;
  var_02.minedamagemax = 0;
  var_02.ontriggeredsfx = "motion_click";
  var_02.onlaunchsfx = "motion_spin";
  var_02.onexplodesfx = "motion_explode_default";
  var_02.launchheight = 64;
  var_02.launchtime = 0.65;
  var_02.ontriggeredfunc = ::scripts\mp\blackholegrenade::blackholeminetrigger;
  var_02.onexplodefunc = ::scripts\mp\blackholegrenade::blackholemineexplode;
  var_02.headiconoffset = 20;
  var_02.minedetectionradius = 200;
  var_02.minedetectionheight = 100;
  level.weaponconfigs["blackhole_grenade_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.model = "weapon_mobile_radar";
  var_02.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_02.armtime = 0.05;
  var_02.vfxtag = "tag_origin";
  var_02.minedamagemin = 0;
  var_02.minedamagemax = 0;
  var_02.ontriggeredsfx = "motion_click";
  var_02.onlaunchsfx = "motion_spin";
  var_02.onexplodesfx = "motion_explode_default";
  var_02.launchheight = 64;
  var_02.launchtime = 0.65;
  var_02.ontriggeredfunc = ::scripts\mp\shardball::func_FC5A;
  var_02.onexplodefunc = ::scripts\mp\shardball::func_FC59;
  var_02.headiconoffset = 20;
  var_02.minedetectionradius = 200;
  var_02.minedetectionheight = 100;
  level.weaponconfigs["shard_ball_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_02.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["c4_mp"] = var_02;
  var_02 = spawnStruct();
  var_02.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_02.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["claymore_mp"] = var_02;
  level.delayminetime = 3;
  level.var_F240 = loadfx("vfx\core\muzflash\shotgunflash");
  level.var_10FA1 = loadfx("vfx\iw7\_requests\mp\power\vfx_wrist_rocket_exp.vfx");
  level.var_D8D4 = [];
  level.var_101AE = [];
  level._meth_857E = [];
  level.var_B7E0 = [];
  level.var_9B16 = [];
  level.mines = [];
  level._effect["glow_stick_glow_red"] = loadfx("vfx\misc\glow_stick_glow_red");
  scripts\mp\ricochet::func_E4E3();
  scripts\mp\bulletstorm::func_3258();
  scripts\mp\shardball::func_FC58();
  scripts\mp\splashgrenade::splashgrenadeinit();
  level thread onplayerconnect();
  level.c4explodethisframe = 0;
  scripts\engine\utility::array_thread(getEntArray("misc_turret", "classname"), ::turret_monitoruse);
  scripts\mp\utility::func_98AA();
}

func_5F30() {
  wait(5);
}

func_97DD() {
  level.var_2C46 = [];
}

bombsquadwaiter_missilefire() {
  self endon("disconnect");
  for(;;) {
    var_00 = scripts\mp\utility::waittill_missile_fire();
    if(!isDefined(var_00)) {
      continue;
    }

    if(var_00.weapon_name == "iw6_mk32_mp") {
      var_00 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad", "tag_weapon", self);
    }
  }
}

createbombsquadmodel(param_00, param_01, param_02) {
  var_03 = spawn("script_model", (0, 0, 0));
  var_03 hide();
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self.bombsquadmodel = var_03;
  var_03 thread bombsquadvisibilityupdater(param_02);
  var_03 setModel(param_00);
  var_03 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  var_03 setcontents(0);
  scripts\engine\utility::waittill_any_3("death", "trap_death");
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  var_03 delete();
}

func_561A(param_00) {
  self hudoutlineenableforclient(param_00, 6, 1, 0);
}

enablevisibilitycullingforclient(param_00) {
  self hudoutlinedisableforclient(param_00);
}

bombsquadvisibilityupdater(param_00) {
  self endon("death");
  self endon("trap_death");
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = param_00.team;
  for(;;) {
    self hide();
    foreach(var_03 in level.players) {
      enablevisibilitycullingforclient(var_03);
      if(!var_03 scripts\mp\utility::_hasperk("specialty_detectexplosive")) {
        continue;
      }

      if(level.teambased) {
        if(var_03.team == "spectator" || var_03.team == var_01) {
          continue;
        }
      } else if(isDefined(param_00) && var_03 == param_00) {
        continue;
      }

      self showtoplayer(var_03);
      func_561A(var_03);
    }

    level scripts\engine\utility::waittill_any_3("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.hits = 0;
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
    self.ismodded = undefined;
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

updatetogglescopestate(param_00) {
  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][param_00])) {
    self give_player_cryobomb(param_00, self.pers["toggleScopeStates"][param_00]);
  }
}

updatesavedaltstate(param_00) {
  var_01 = missile_settargetent(param_00);
  var_02 = func_7DB8(param_00);
  var_03 = getweaponbasename(param_00);
  var_04 = var_03 + "+" + var_01;
  var_05 = var_03 + "+" + var_02;
  if(isDefined(self.pers["altScopeStates"]) && scripts\mp\utility::istrue(isDefined(self.pers["altScopeStates"][var_05]) || isDefined(self.pers["altScopeStates"][var_04]))) {
    return "alt_" + param_00;
  }

  return param_00;
}

issmallmissile(param_00) {
  return 0;
}

func_7DB8(param_00) {
  var_01 = getweaponattachments(param_00);
  foreach(var_03 in var_01) {
    if(func_9D3C(var_03)) {
      return var_03;
    }
  }

  return "";
}

missile_settargetent(param_00) {
  var_01 = getweaponattachments(param_00);
  foreach(var_03 in var_01) {
    if(func_9FF3(var_03)) {
      return var_03;
    }
  }

  return "";
}

func_9D3C(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "shotgunlongshot_burst":
    case "longshotlscope_burst":
    case "acogm4selector":
    case "firetypeselectorsingle":
    case "shotgunlongshotl":
    case "longshotlscope":
    case "longshotscope":
    case "ripperscopeb_camo":
    case "ripperlscope_camo":
    case "ripperscope_camo":
    case "m8lchargescope_camo":
    case "m8lscope_camo":
    case "m8rscope_camo":
    case "m8scope_camo":
    case "ripperrscope_camo":
    case "shotgunlongshot":
    case "meleervn":
    case "arripper":
    case "arm8":
    case "mod_akimboshotgun":
    case "akimbofmg":
      var_01 = 1;
      break;

    default:
      var_02 = scripts\mp\utility::attachmentmap_tobase(param_00);
      if(var_02 == "hybrid" || var_02 == "acog") {
        var_01 = 1;
      }
      break;
  }

  return var_01;
}

func_9FF3(param_00) {
  var_01 = 0;
  switch (param_00) {
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
      var_02 = scripts\mp\utility::attachmentmap_tobase(param_00);
      if(var_02 == "hybrid" || var_02 == "acog") {
        var_01 = 1;
      }
      break;
  }

  return var_01;
}

func_13AC3() {
  scripts\mp\stinger::func_10FAD();
}

func_13AAC() {
  scripts\mp\javelin::func_A448();
}

weaponperkupdate(param_00, param_01) {
  if(isDefined(param_01) && param_01 != "none") {
    param_01 = scripts\mp\utility::getweaponrootname(param_01);
    var_02 = scripts\mp\utility::func_13CB4(param_01);
    if(isDefined(var_02)) {
      scripts\mp\utility::removeperk(var_02);
    }
  }

  if(isDefined(param_00) && param_00 != "none") {
    param_00 = scripts\mp\utility::getweaponrootname(param_00);
    var_03 = scripts\mp\utility::func_13CB4(param_00);
    if(isDefined(var_03)) {
      scripts\mp\utility::giveperk(var_03);
    }
  }

  if(isDefined(param_01) && issubstr(param_01, "iw7_nunchucks") && param_00 != param_01) {
    scripts\mp\utility::unblockperkfunction("specialty_sprintfire");
  }

  if(isDefined(param_01) && issubstr(param_00, "iw7_nunchucks")) {
    scripts\mp\utility::blockperkfunction("specialty_sprintfire");
  }
}

func_12F5D(param_00) {
  var_01 = 1;
  if(isDefined(param_00) && param_00 != "none") {
    var_02 = weaponclass(param_00);
    if(((var_02 == "sniper" || issubstr(param_00, "iw7_longshot") && !isaltmodeweapon(param_00)) && !scripts\mp\utility::_hasperk("passive_scope_radar")) || getweaponbasename(param_00) == "iw7_m1c_mp" && scripts\mp\utility::weaponhasattachment(param_00, "thermal")) {
      var_01 = 0;
    }
  }

  self setclientomnvar("ui_ads_minimap", var_01);
}

func_13C78(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(param_01) && param_01 != "none") {
    var_03 = getweaponattachments(param_01);
    if(isDefined(var_03) && var_03.size > 0) {
      foreach(var_05 in var_03) {
        var_06 = scripts\mp\utility::attachmentperkmap(var_05);
        if(!isDefined(var_06)) {
          continue;
        }

        scripts\mp\utility::removeperk(var_06);
      }
    }
  }

  if(isDefined(param_00) && param_00 != "none") {
    var_02 = getweaponattachments(param_00);
    if(isDefined(var_02) && var_02.size > 0) {
      foreach(var_09 in var_02) {
        var_06 = scripts\mp\utility::attachmentperkmap(var_09);
        if(!isDefined(var_06)) {
          continue;
        }

        scripts\mp\utility::giveperk(var_06);
      }
    }
  }
}

func_13B2E(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    var_02 = self getcurrentweapon();
    if(var_02 == param_00) {
      childthread func_13BAC(param_00, param_01);
    }

    self waittill("weapon_change");
  }
}

func_13BAC(param_00, param_01) {
  self endon("weapon_change");
  for(;;) {
    var_02 = scripts\mp\utility::waittill_missile_fire();
    if(!isDefined(var_02.var_9E8F)) {
      thread func_13BAB(param_00, var_02, anglesToForward(var_02.angles), 0, param_01);
    }
  }
}

func_13BAB(param_00, param_01, param_02, param_03, param_04) {
  if(param_03 >= param_04) {
    return;
  }

  var_05 = param_01 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(2, "death");
  if(var_05 != "death") {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  var_06 = param_01.origin + -8 * param_02;
  var_07 = var_06 + param_02 * 15;
  var_08 = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_player", "physicscontents_vehicleclip"]);
  var_09 = physics_raycast(var_06, var_07, var_08, self, 0, "physicsquery_closest");
  if(var_09.size == 0) {
    return;
  }

  var_0A = var_09[0]["entity"];
  var_0B = var_09[0]["normal"];
  var_0C = var_09[0]["position"];
  if(isDefined(var_0A) && isplayer(var_0A)) {
    return;
  } else {
    var_0D = param_02 - 2 * vectordot(param_02, var_0B) * var_0B;
    var_0D = vectornormalize(var_0D);
    var_0E = var_0C + var_0D * 2;
    param_01 = scripts\mp\utility::_magicbullet(param_00, var_0E, var_0E + var_0D, self);
    param_01.triggerportableradarping = self;
    param_01.var_9E8F = 1;
  }

  thread func_13BAB(param_00, param_01, var_0D, param_03 + 1, param_04);
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
    weaponperkupdate(var_01, var_00);
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
  var_00 = scripts\mp\utility::func_E0CF(self getcurrentweapon());
  hitsthismag_init(var_00);
  for(;;) {
    self waittill("weapon_change", var_00);
    var_00 = scripts\mp\utility::func_E0CF(var_00);
    if(!func_B4E0(var_00)) {
      continue;
    }

    if(scripts\mp\utility::iskillstreakweapon(var_00)) {
      continue;
    }

    hitsthismag_init(var_00);
    if(scripts\mp\utility::iscacprimaryweapon(var_00) || scripts\mp\utility::iscacsecondaryweapon(var_00)) {
      self.lastdroppableweaponobj = var_00;
    }
  }
}

func_12F11(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  if(param_01) {
    wait(0.05);
  }

  if(param_00 == "iw7_fhr_mp") {
    self setscriptablepartstate("chargeVFX", "chargeVFXOn", 0);
    return;
  }

  self setscriptablepartstate("chargeVFX", "chargeVFXOff", 0);
}

func_13B4C() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    var_00 = self getcurrentweapon();
    if(func_103B9(var_00)) {
      childthread func_103B7();
    }

    self waittill("weapon_change");
  }
}

func_103B9(param_00) {
  return param_00 != "none" && weaponclass(param_00) == "sniper" || issubstr(param_00, "iw7_udm45_mpl") || issubstr(param_00, "iw7_longshot_mp") && !isaltmodeweapon(param_00) && !issubstr(param_00, "iw7_m8_mpr");
}

func_103B7() {
  self notify("manageSniperGlint");
  self endon("managerSniperGlint");
  self endon("weapon_change");
  scripts\engine\utility::waitframe();
  thread func_103B6();
  self.glinton = 0;
  for(;;) {
    if(self getweaponrankinfominxp() > 0.5 && !scripts\mp\equipment\cloak::func_9FC1()) {
      if(!self.glinton) {
        func_103B5();
      }
    } else if(self.glinton) {
      sniperglint_remove();
    }

    scripts\engine\utility::waitframe();
  }
}

func_103B6() {
  scripts\engine\utility::waittill_any_3("death", "disconnect", "weapon_change");
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
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);
  for(;;) {
    self waittill("got_a_kill", var_00, var_01, var_02);
    if(isrecoilreducingweapon(var_01)) {
      var_03 = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(var_03, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);
      if(var_03 <= 4) {
        stancerecoilupdate(self getstance());
      }
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

isrecoilreducingweapon(param_00) {
  if(!isDefined(param_00) || param_00 == "none") {
    return 0;
  }

  var_01 = 0;
  if(issubstr(param_00, "l115a3scope") || issubstr(param_00, "l115a3vzscope") || issubstr(param_00, "usrscope") || issubstr(param_00, "usrvzscope")) {
    var_01 = 1;
  }

  return var_01;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 3;
}

glprox_trygetweaponname(param_00) {
  if(param_00 != "none" && getweaponbasename(param_00) == "iw7_glprox_mp") {
    if(isaltmodeweapon(param_00)) {
      var_01 = getweaponattachments(param_00);
      param_00 = var_01[0];
    } else {
      param_00 = getweaponbasename(param_00);
    }
  }

  return param_00;
}

glprox_modifieddamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = param_00;
  param_04 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_04);
  if(!isplayer(param_02)) {
    return var_07;
  }

  if(param_04 != "iw7_glprox_mp") {
    return var_07;
  }

  if(!isexplosivedamagemod(param_05)) {
    return var_07;
  }

  var_08 = 2500;
  if(level.hardcoremode) {
    var_08 = 11025;
  } else if(level.tactical) {
    var_08 = 9216;
  }

  var_09 = 105;
  if(level.hardcoremode) {
    var_09 = 35;
  } else if(level.tactical) {
    var_09 = 105;
  }

  var_0A = 55;
  if(level.hardcoremode) {
    var_0A = 25;
  } else if(level.tactical) {
    var_0A = 55;
  }

  var_0B = undefined;
  var_0C = undefined;
  if(isDefined(param_06)) {
    var_0B = distancesquared(param_06, param_02 getEye());
    var_0C = distancesquared(param_06, param_02.origin);
  } else if(isDefined(param_03)) {
    var_0B = distancesquared(param_03.origin, param_02 getEye());
    var_0C = distancesquared(param_03.origin, param_02.origin);
  }

  if(isDefined(var_0B) && var_0B <= var_08) {
    var_07 = var_09;
  } else if(isDefined(var_0C) && var_0C <= var_08) {
    var_07 = var_09;
  } else {
    var_07 = var_0A;
  }

  return var_07;
}

glprox_modifiedblastshieldconst(param_00, param_01) {
  if(level.hardcoremode) {
    if(scripts\mp\utility::getweaponbasedsmokegrenadecount(param_01) == "iw7_glprox_mp") {
      param_00 = 0.65;
    }
  }

  return param_00;
}

ishackweapon(param_00) {
  if(param_00 == "radar_mp" || param_00 == "airstrike_mp" || param_00 == "helicopter_mp") {
    return 1;
  }

  if(param_00 == "briefcase_bomb_mp") {
    return 1;
  }

  return 0;
}

func_9DF7(param_00) {
  param_00 = scripts\mp\utility::getweaponrootname(param_00);
  return param_00 == "iw7_fists";
}

func_9D6D(param_00) {
  return param_00 == "briefcase_bomb_mp" || param_00 == "briefcase_bomb_defuse_mp";
}

func_B4E0(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(func_9DF7(param_00)) {
    return 0;
  }

  if(func_9D6D(param_00)) {
    return 0;
  }

  if(scripts\mp\powers::func_9F0A(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "ac130")) {
    return 0;
  }

  if(issubstr(param_00, "uav")) {
    return 0;
  }

  if(issubstr(param_00, "killstreak")) {
    return 0;
  }

  if(scripts\mp\utility::issuperweapon(param_00)) {
    return 0;
  }

  var_01 = weaponinventorytype(param_00);
  if(var_01 != "primary") {
    return 0;
  }

  return 1;
}

dropweaponfordeath(param_00, param_01) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  if((isDefined(param_00) && param_00 == self) || param_01 == "MOD_SUICIDE") {
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

  if(scripts\mp\utility::isjuggernaut()) {
    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_02)) {
    return;
  }

  if(isaltmodeweapon(var_02)) {
    var_02 = scripts\mp\utility::func_E0CF(var_02);
  }

  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  if(var_02 != "iw6_riotshield_mp") {
    if(!self getobjectivehinttext(var_02)) {
      return;
    }

    var_03 = self getweaponammoclip(var_02, "right");
    var_04 = self getweaponammoclip(var_02, "left");
    if(!var_03 && !var_04) {
      return;
    }

    var_05 = self getweaponammostock(var_02);
    var_06 = weaponmaxammo(var_02);
    if(var_05 > var_06) {
      var_05 = var_06;
    }

    var_07 = self dropitem(var_02);
    if(!isDefined(var_07)) {
      return;
    }

    var_07 gettimepassedpercentage(var_03, var_05, var_04);
  } else {
    var_07 = self dropitem(var_03);
    if(!isDefined(var_07)) {
      return;
    }

    var_07 gettimepassedpercentage(1, 1, 0);
  }

  self.droppeddeathweapon = 1;
  var_07.triggerportableradarping = self;
  var_07.var_336 = "dropped_weapon";
  var_07 thread watchpickup();
  var_07 thread deletepickupafterawhile();
}

func_1175A(param_00, param_01, param_02, param_03) {
  self.triggerportableradarping endon("disconnect");
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  var_04 = self.origin;
  for(;;) {
    wait(0.25);
    if(!isDefined(self)) {
      return;
    }

    var_05 = self.origin;
    if(var_04 == var_05) {
      break;
    }

    var_04 = var_05;
  }

  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(param_01 <= 0 && param_02 <= 0) {
    return;
  }

  var_06 = self.origin;
  var_07 = self.angles;
  var_08 = 2;
  var_09 = weaponfiretime(param_00) * var_08;
  while(isDefined(self) && param_01 > 0 || param_02 > 0) {
    var_0A = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(0, 1));
    var_0B = var_0A * 180;
    var_0C = var_0A * 1000;
    self.origin = var_06 + (0, 0, 10);
    self.angles = var_0B;
    thread scripts\mp\utility::drawline(self.origin, self.origin + var_0C, 2, (0, 1, 0));
    thread func_1174C(self.origin, var_0C, self.triggerportableradarping, param_00);
    wait(var_09);
    if(!isDefined(self)) {
      break;
    }

    param_01 = param_01 - var_08;
    param_02 = param_02 - var_08;
    if(param_01 <= 0) {
      param_01 = 0;
    }

    if(param_02 <= 0) {
      param_02 = 0;
    }

    self gettimepassedpercentage(param_01, param_03, param_02);
  }

  if(!isDefined(self)) {
    return;
  }

  self.origin = var_06;
  self.angles = var_07;
}

func_1174C(param_00, param_01, param_02, param_03) {
  param_02 endon("disconnect");
  var_04 = param_00 + param_01;
  var_05 = scripts\mp\utility::_magicbullet(param_03, param_00, var_04, param_02);
}

func_1015B() {
  wait(0.1);
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

_meth_822A(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = strtok(param_00, "_");
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

detachifattached(param_00, param_01) {
  var_02 = self getscoreremaining();
  var_03 = 0;
  while(var_03 < var_02) {
    var_04 = self getscoreperminute(var_03);
    if(var_04 != param_00) {
      continue;
    }

    var_05 = self getattachtagname(var_03);
    self detach(param_00, var_05);
    if(var_05 != param_01) {
      var_02 = self getscoreremaining();
      for(var_03 = 0; var_03 < var_02; var_03++) {
        var_05 = self getattachtagname(var_03);
        if(var_05 != param_01) {
          continue;
        }

        param_00 = self getscoreperminute(var_03);
        self detach(param_00, var_05);
        break;
      }
    }

    return 1;
    var_04++;
  }

  return 0;
}

deletepickupafterawhile() {
  self endon("death");
  wait(60);
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
    if(isDefined(var_01.tookweaponfrom[var_04])) {
      var_02.triggerportableradarping = var_01.tookweaponfrom[var_04];
      var_01.tookweaponfrom[var_04] = undefined;
    }

    var_02.var_336 = "dropped_weapon";
    var_02 thread watchpickup();
  }

  var_01.tookweaponfrom[var_00] = self.triggerportableradarping;
}

fixupplayerweapons(param_00, param_01) {
  var_02 = param_00 getweaponslistprimaries();
  var_03 = 1;
  var_04 = 1;
  foreach(var_06 in var_02) {
    if(param_00.primaryweapon == var_06) {
      var_03 = 0;
      continue;
    }

    if(param_00.secondaryweapon == var_06) {
      var_04 = 0;
    }
  }

  if(var_03) {
    param_00.primaryweapon = param_01;
  } else if(var_04) {
    param_00.secondaryweapon = param_01;
  }

  return var_03 || var_04;
}

itemremoveammofromaltmodes() {
  var_00 = getitemweaponname();
  var_01 = weaponaltweaponname(var_00);
  for(var_02 = 1; var_01 != "none" && var_01 != var_00; var_02++) {
    self gettimepassedpercentage(0, 0, 0, var_02);
    var_01 = weaponaltweaponname(var_01);
  }
}

func_89DF(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  self waittill("scavenger", var_02);
  var_02 notify("scavenger_pickup");
  func_EBD2(var_02);
  scripts\mp\powers::func_EBD4(var_02);
  var_02 scripts\mp\damagefeedback::hudicontype("scavenger");
}

func_EBD2(param_00) {
  var_01 = param_00 getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(!scripts\mp\utility::iscacprimaryweapon(var_03) && !level.var_EBD0) {
      continue;
    }

    if(isaltmodeweapon(var_03) && weaponclass(var_03) == "grenade") {
      continue;
    }

    if(scripts\mp\utility::getweapongroup(var_03) == "weapon_projectile") {
      continue;
    }

    if(var_03 == "venomxgun_mp") {
      continue;
    }

    var_04 = param_00 getweaponammostock(var_03);
    var_05 = weaponclipsize(var_03);
    if(issubstr(var_03, "akimbo") && scripts\mp\utility::getweaponrootname(var_03) != "iw7_fmg") {
      var_05 = var_05 * 2;
    }

    param_00 setweaponammostock(var_03, var_04 + var_05);
  }
}

func_EBD3(param_00) {
  if(isDefined(param_00.powers)) {
    foreach(var_02 in param_00.powers) {
      param_00 notify("scavenged_ammo", var_02.weaponuse);
      scripts\engine\utility::waitframe();
    }
  }
}

dropscavengerfordeath(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 == self) {
    return;
  }

  var_02 = self dropscavengerbag("scavenger_bag_mp");
  if(!isDefined(var_02)) {
    return;
  }

  var_02 thread func_89DF(self, param_01);
  if(isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var_02);
  }
}

weaponcanstoreaccuracystats(param_00) {
  if(scripts\mp\utility::iscacmeleeweapon(param_00)) {
    return 0;
  }

  return scripts\mp\utility::iscacprimaryweapon(param_00) || scripts\mp\utility::iscacsecondaryweapon(param_00);
}

setweaponstat(param_00, param_01, param_02) {
  scripts\mp\gamelogic::setweaponstat(param_00, param_01, param_02);
}

watchweaponusage(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_fired", var_01);
    var_01 = self getcurrentweapon();
    thread scripts\mp\perks\_weaponpassives::updateweaponpassivesonuse(self, var_01);
    scripts\mp\gamelogic::sethasdonecombat(self, 1);
    var_02 = gettime();
    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var_03 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_02;
    if(scripts\mp\utility::istrue(level.jittermodcheck)) {
      jittermodcheck(var_01);
    } else {
      level.jittermodcheck = getdvarint("scr_modDefense", 0);
    }

    if(!issubstr(var_01, "silence") && var_03 > 500 && level.var_768F) {
      thread scripts\mp\killstreaks\_uplink::func_B37E();
    }

    if(isai(self)) {
      continue;
    }

    if(!weaponcanstoreaccuracystats(var_01)) {
      continue;
    }

    var_04 = var_01;
    if(scripts\mp\perks\_weaponpassives::doesshareammo(var_01)) {
      var_04 = scripts\mp\utility::func_E0CF(var_01);
    }

    if(isDefined(self.hitsthismag[var_04])) {
      thread hitsthismag_update(var_04);
    }

    var_05 = scripts\mp\persistence::statgetbuffered("totalShots") + 1;
    var_06 = scripts\mp\persistence::statgetbuffered("hits");
    var_07 = clamp(float(var_06) / float(var_05), 0, 1) * 10000;
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

jittermodcheck(param_00) {
  var_01 = gettime();
  var_02 = self getcurrentweaponclipammo();
  var_03 = self getcurrentweaponclipammo("left");
  var_04 = undefined;
  var_05 = undefined;
  if(!isDefined(self.lastshot)) {
    self.lastshot = [];
    self.lastshot["time"] = var_01;
    self.lastshot["time_left"] = var_01;
    self.lastshot["ammo"] = self getcurrentweaponclipammo();
    self.lastshot["ammo_left"] = self getcurrentweaponclipammo("left");
    self.lastshot["weapon"] = param_00;
    return;
  }

  if(param_00 == self.lastshot["weapon"] && !self ismantling()) {
    var_04 = var_01 - self.lastshot["time"];
    var_05 = var_01 - self.lastshot["time_left"];
    var_06 = getweaponjittertime(param_00);
    if(self.lastshot["ammo"] != var_02) {
      if(var_04 < var_06) {
        self.ismodded = 1;
      }

      if(self.lastshot["ammo"] > var_02) {
        self.lastshot["time"] = var_01;
      }

      self.lastshot["ammo"] = var_02;
    }

    if(self.lastshot["ammo_left"] != var_03) {
      if(var_05 < var_06) {
        self.ismodded = 1;
      }

      if(self.lastshot["ammo_left"] > var_03) {
        self.lastshot["time_left"] = var_01;
      }

      self.lastshot["ammo_left"] = var_03;
    }
  } else {
    self.lastshot["weapon"] = param_00;
  }

  if(scripts\mp\utility::istrue(self.ismodded)) {
    self setweaponammoclip(param_00, 0);
    self setweaponammoclip(param_00, 0, "left");
    self setweaponammostock(param_00, 0);
    scripts\mp\utility::blockperkfunction("specialty_scavenger");
    self disableweaponpickup();
    self.lastshot = undefined;
  }
}

getweaponjittertime(param_00) {
  var_01 = getweaponbasename(param_00);
  var_02 = 1;
  var_03 = scripts\engine\utility::ter_op(issubstr(param_00, "akimbo"), 1, 0);
  switch (var_01) {
    case "iw7_devastator_mp":
      var_02 = 140;
      break;

    case "iw7_mod2187_mp":
      if(var_03) {
        var_02 = 1000;
      } else {
        var_02 = 1200;
      }
      break;

    case "iw7_sonic_mpr":
    case "iw7_sonic_mp":
      var_02 = 700;
      break;

    case "iw7_spas_mpl_slug":
    case "iw7_spas_mpr":
    case "iw7_spas_mpr_focus":
      var_02 = 900;
      break;

    case "iw7_longshot_mpl":
    case "iw7_longshot_mp":
      var_02 = 800;
      break;

    case "iw7_m1_mpr_silencer":
    case "iw7_m1_mpr":
    case "iw7_m1_mp":
      var_02 = 230;
      break;

    case "iw7_ake_mp_single":
      var_02 = 190;
      break;

    case "iw7_emc_mpl_spread":
      var_02 = 130;
      break;

    case "iw7_fmg_mpl_shotgun":
      if(isaltmodeweapon(param_00)) {
        var_02 = 130;
      }
      break;
  }

  return var_02;
}

hitsthismag_init(param_00) {
  if(param_00 == "none") {
    return;
  }

  if((scripts\mp\utility::iscacprimaryweapon(param_00) || scripts\mp\utility::iscacsecondaryweapon(param_00)) && !isDefined(self.hitsthismag[param_00])) {
    self.hitsthismag[param_00] = weaponclipsize(param_00);
  }
}

hitsthismag_update(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("updateMagShots_" + param_00);
  self.hitsthismag[param_00]--;
  wait(0.05);
  self notify("shot_missed", param_00);
  self.consecutivehitsperweapon[param_00] = 0;
  self.hitsthismag[param_00] = weaponclipsize(param_00);
}

func_9046(param_00) {
  self endon("death");
  self endon("disconnect");
  self notify("updateMagShots_" + param_00);
  waittillframeend;
  if(isDefined(self.hitsthismag[param_00]) && self.hitsthismag[param_00] == 0) {
    var_01 = scripts\mp\utility::getweapongroup(param_00);
    scripts\mp\missions::processchallenge(var_01);
    self.hitsthismag[param_00] = weaponclipsize(param_00);
  }
}

func_3E1E(param_00, param_01) {
  self endon("disconnect");
  if(scripts\mp\utility::isstrstart(param_00, "alt_")) {
    var_02 = scripts\mp\utility::getweaponattachmentsbasenames(param_00);
    if(scripts\engine\utility::array_contains(var_02, "shotgun") || scripts\engine\utility::array_contains(var_02, "gl")) {
      self.hits = 1;
    } else {
      param_00 = getsubstr(param_00, 4);
    }
  }

  if(!weaponcanstoreaccuracystats(param_00)) {
    return;
  }

  if(self meleebuttonpressed() && param_00 != "iw7_knife_mp") {
    return;
  }

  switch (weaponclass(param_00)) {
    case "mg":
    case "rifle":
    case "sniper":
    case "smg":
    case "pistol":
      self.hits++;
      break;

    case "spread":
      self.hits = 1;
      break;

    default:
      break;
  }

  if(isriotshield(param_00) || param_00 == "iw7_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(param_00, self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend;
  if(isDefined(self.hitsthismag[param_00])) {
    thread func_9046(param_00);
  }

  if(!isDefined(self.lasthittime[param_00])) {
    self.lasthittime[param_00] = 0;
  }

  if(self.lasthittime[param_00] == gettime()) {
    return;
  }

  self.lasthittime[param_00] = gettime();
  if(!isDefined(self.consecutivehitsperweapon) || !isDefined(self.consecutivehitsperweapon[param_00])) {
    self.consecutivehitsperweapon[param_00] = 1;
  } else {
    self.consecutivehitsperweapon[param_00]++;
  }

  var_03 = scripts\mp\persistence::statgetbuffered("totalShots");
  var_04 = scripts\mp\persistence::statgetbuffered("hits") + 1;
  if(var_04 <= var_03) {
    scripts\mp\persistence::func_10E55("hits", var_04);
    scripts\mp\persistence::func_10E55("misses", int(var_03 - var_04));
    var_05 = clamp(float(var_04) / float(var_03), 0, 1) * 10000;
    scripts\mp\persistence::func_10E55("accuracy", int(var_05));
  }

  thread scripts\mp\missions::func_C5A8(param_00);
  thread scripts\mp\contractchallenges::contractshotslanded(param_00);
  self.lastdamagetime = gettime();
  var_06 = scripts\mp\utility::getweapongroup(param_00);
  if(var_06 == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg)) {
      self.shotslandedlmg = 1;
      return;
    }

    self.shotslandedlmg++;
  }
}

func_24E2(param_00, param_01) {
  return friendlyfirecheck(param_01, param_00);
}

friendlyfirecheck(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  var_04 = level.friendlyfire;
  if(isDefined(param_02)) {
    var_04 = param_02;
  }

  if(var_04 != 0) {
    return 1;
  }

  if(param_01 == param_00 || isDefined(param_01.triggerportableradarping) && param_01.triggerportableradarping == param_00) {
    return 1;
  }

  var_05 = undefined;
  if(isDefined(param_01.triggerportableradarping)) {
    var_05 = param_01.triggerportableradarping.team;
  } else if(isDefined(param_01.team)) {
    var_05 = param_01.team;
  }

  if(!isDefined(var_05)) {
    return 1;
  }

  if(var_05 != param_00.team) {
    return 1;
  }

  return 0;
}

func_13A1F() {
  self notify("watchEquipmentOnSpawn");
  self endon("watchEquipmentOnSpawn");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  if(!isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = [];
  }

  if(!isDefined(self.plantedtacticalequip)) {
    self.plantedtacticalequip = [];
  }

  deletedisparateplacedequipment();
  var_00 = scripts\mp\utility::getintproperty("scr_deleteexplosivesonspawn", 1) && !scripts\mp\utility::_hasperk("specialty_rugged_eqp") || !checkequipforrugged();
  if(var_00) {
    func_51CE();
  }

  var_01 = self.plantedtacticalequip.size;
  var_02 = self.plantedlethalequip.size;
  var_03 = var_01 && var_02;
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp") && var_03) {
    thread scripts\mp\perks\_perkfunctions::feedbackruggedeqp(var_02, var_01);
  }
}

checkequipforrugged() {
  var_00 = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);
  foreach(var_02 in var_00) {
    if(isDefined(var_02.hasruggedeqp)) {
      return 1;
    }
  }

  return 0;
}

watchgrenadeusage() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  watchgrenadethrows();
}

watchgrenadethrows() {
  var_00 = scripts\mp\utility::func_1377B();
  if(!isDefined(var_00)) {
    return;
  }

  if(!isDefined(var_00.weapon_name)) {
    return;
  }

  setweaponstat(var_00.weapon_name, 1, "shots");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  if(isDefined(level.var_2C46[var_00.weapon_name])) {
    var_00 thread createbombsquadmodel(level.var_2C46[var_00.weapon_name].model, level.var_2C46[var_00.weapon_name].physics_setgravitydynentscalar, self);
  }

  if(getweaponbasename(var_00.weapon_name) == "iw7_glprox_mp") {
    var_01 = glprox_trygetweaponname(var_00.weapon_name);
    if(var_01 == "stickglprox") {
      semtexused(var_00);
    }

    return;
  }

  if(getweaponbasename(var_01.weapon_name) == "iw7_venomx_mp") {
    var_01.var_FF03 = self isinphase();
    return;
  }

  if(isaxeweapon(var_01.weapon_name)) {
    var_01.var_FF03 = self isinphase();
    var_01 thread watchgrenadeaxepickup(self);
    return;
  }

  switch (var_01.weapon_name) {
    case "frag_grenade_mp":
      if(var_01.ticks >= 1) {
        var_01.iscooked = 1;
      }

      var_01.originalowner = self;
      var_01 thread scripts\mp\shellshock::grenade_earthquake();
      break;

    case "cluster_grenade_mp":
      var_01.clusterticks = var_01.ticks;
      if(var_01.ticks >= 1) {
        var_01.iscooked = 1;
      }

      var_01.originalowner = self;
      thread clustergrenadeused(var_01);
      var_01 thread scripts\mp\shellshock::grenade_earthquake();
      break;

    case "wristrocket_mp":
      if(var_01.ticks >= 1) {
        var_01.iscooked = 1;
      }

      var_01.originalowner = self;
      thread scripts\mp\equipment\wrist_rocket::wristrocketused(var_01);
      var_01 thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;

    case "iw6_aliendlc22_mp":
      var_01 thread scripts\mp\shellshock::grenade_earthquake();
      var_01.originalowner = self;
      break;

    case "semtex_mp":
      thread semtexused(var_01);
      break;

    case "cryo_mine_mp":
      thread scripts\mp\equipment\cryo_mine::func_4ADA(var_01);
      break;

    case "c4_mp":
      thread scripts\mp\equipment\c4::c4_used(var_01);
      break;

    case "proximity_explosive_mp":
      thread func_DACD(var_01);
      break;

    case "flash_grenade_mp":
      var_01.var_BFD5 = var_01.ticks;
      if(var_01.ticks >= 1) {
        var_01.iscooked = 1;
      }

      var_01 thread func_BFD3();
      break;

    case "throwingknifedisruptor_mp":
      thread func_56E6(var_01);
      break;

    case "smoke_grenadejugg_mp":
    case "smoke_grenade_mp":
      var_01 thread func_1037B();
      break;

    case "gas_grenade_mp":
      var_01 thread watchgasgrenadeexplode();
      break;

    case "concussion_grenade_mp":
      thread scripts\mp\concussiongrenade::func_44EE(var_01);
      break;

    case "alientrophy_mp":
    case "trophy_mp":
      thread scripts\mp\trophy_system::func_12827(var_01);
      break;

    case "claymore_mp":
      thread claymoreused(var_01);
      break;

    case "alienbetty_mp":
    case "bouncingbetty_mp":
      thread mineused(var_01, ::spawnmine);
      break;

    case "motion_sensor_mp":
      thread mineused(var_01, ::func_108E7);
      break;

    case "mobile_radar_mp":
      thread mineused(var_01, ::func_108E5);
      break;

    case "distortionfield_grenade_mp":
      var_01 thread func_139F5();
      break;

    case "throwingknifejugg_mp":
    case "throwingknifehack_mp":
    case "throwingknifesiphon_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifeteleport_mp":
    case "throwingknife_mp":
    case "throwingknifec4_mp":
      level thread throwingknifeused(self, var_01, var_01.weapon_name);
      break;

    case "sensor_grenade_mp":
      break;

    case "sonic_sensor_mp":
      thread mineused(var_01, ::func_10910);
      break;

    case "proto_ricochet_device_mp":
      thread scripts\mp\ricochet::func_E4E9(var_01);
      break;

    case "proxy_bomb_mp":
      thread func_DAD5(self, var_01);
      break;

    case "disc_marker_mp":
      thread func_562B(self, var_01);
      break;

    case "adrenaline_mist_mp":
      break;

    case "case_bomb_mp":
      thread func_3B0E(self, var_01);
      break;

    case "domeshield_mp":
      thread scripts\mp\domeshield::func_5910(var_01);
      break;

    case "blackhole_grenade_mp":
      thread scripts\mp\blackholegrenade::blackholegrenadeused(var_01);
      break;

    case "portal_grenade_mp":
      break;

    case "copycat_grenade_mp":
      break;

    case "speed_strip_mp":
      break;

    case "shard_ball_mp":
      if(scripts\mp\powerloot::func_D779(var_01.power, "passive_grenade_to_mine")) {
        thread mineused(var_01, ::func_1090D, ::scripts\mp\shardball::placementfailed);
      } else {
        thread scripts\mp\shardball::func_FC5B(var_01);
      }
      break;

    case "splash_grenade_mp":
      var_01 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\splashgrenade::splashgrenadeused(var_01);
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
      thread scripts\mp\equipment\pulse_grenade::func_DAF5(var_01);
      break;

    case "ammo_box_mp":
      break;

    case "virus_grenade_mp":
      break;

    case "fear_grenade_mp":
      thread mineused(var_01, ::func_10884);
      break;

    case "deployable_cover_mp":
      break;

    case "power_spider_grenade_mp":
      thread scripts\mp\equipment\spider_grenade::spidergrenade_used(var_01);
      break;

    case "split_grenade_mp":
      thread scripts\mp\equipment\split_grenade::func_10A54(var_01);
      break;

    case "trip_mine_mp":
      thread scripts\mp\equipment\trip_mine::tripmine_used(var_01);
      break;

    case "power_exploding_drone_mp":
      thread scripts\mp\equipment\exploding_drone::func_69D4(var_01);
      break;
  }
}

func_562B(param_00, param_01) {
  param_01 waittill("missile_stuck");
  param_00 notify("markerPlanted", param_01);
}

func_3B0E(param_00, param_01, param_02) {
  level endon("game_ended");
  param_01 endon("death");
  param_01 waittill("missile_stuck");
  if(!isDefined(param_01.origin)) {}
}

func_3B0D(param_00, param_01) {
  level endon("game_ended");
  wait(0.05);
  var_02 = param_00 _meth_8113();
  wait(randomfloatrange(0.5, 0.8));
  if(!isDefined(var_02)) {
    return;
  }

  var_03 = var_02.origin;
  self playSound("frag_grenade_explode");
  earthquake(0.5, 1.5, var_03, 120);
  playFX(level._effect["case_bomb"], var_03 + (0, 0, 12));
  thread scripts\mp\utility::func_13AF(var_03, 256, 400, 50, self, "MOD_EXPLOSIVE", "case_bomb_mp", 0);
  wait(0.1);
  playFX(level._effect["corpse_pop"], var_03 + (0, 0, 12));
  if(isDefined(var_02)) {
    var_02 hide();
  }
}

func_DAD5(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("death");
  param_01 waittill("missile_stuck", var_02);
  if(isDefined(var_02) && isplayer(var_02) || isagent(var_02)) {
    param_01 detonate(param_00);
  }
}

throwingknifeused(param_00, param_01, param_02) {
  param_01 makeunusable();
  if(param_02 == "throwingknifehack_mp") {} else if(param_02 == "throwingknifec4_mp") {
    param_01 thread recordthrowingknifetraveldist();
  }

  var_03 = undefined;
  var_04 = undefined;
  if(param_02 == "throwingknifesmokewall_mp") {
    param_01 func_1181E(param_00);
    return;
  } else {
    param_01 waittill("missile_stuck", var_03, var_04);
  }

  var_05 = isDefined(var_04) && var_04 == "tag_flicker";
  var_06 = isDefined(var_04) && var_04 == "tag_weapon";
  if(isDefined(var_03) && isplayer(var_03) || isagent(var_03) && var_05) {
    var_03 notify("shield_hit", param_01);
  }

  if(isDefined(var_03) && isplayer(var_03) || isagent(var_03) && !var_06 && !var_05) {
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_03, param_01)) {
      param_01 delete();
      return;
    } else if(param_02 == "throwingknifeteleport_mp") {} else if(param_02 == "throwingknifec4_mp") {
      throwingknifec4detonate(param_01, var_03, param_00);
    } else if(param_02 == "throwingknifesiphon_mp") {
      scripts\mp\equipment\siphon_knife::func_1181D(param_01, var_03, param_00);
      return;
    } else if(param_02 == "throwingknifehack_mp") {
      return;
    }
  }

  thread func_11825(param_00, param_01);
  param_01 endon("death");
  param_01 makeunusable();
  var_07 = spawn("trigger_radius", param_01.origin, 0, 64, 64);
  var_07 enablelinkto();
  var_07 linkto(param_01);
  var_07.var_336 = "dropped_knife";
  param_01.knife_trigger = var_07;
  param_01 thread watchgrenadedeath();
  for(;;) {
    scripts\engine\utility::waitframe();
    if(!isDefined(var_07)) {
      return;
    }

    var_07 waittill("trigger", var_08);
    if(!isplayer(var_08) || !scripts\mp\utility::isreallyalive(var_08)) {
      continue;
    }

    if(!var_08 hasweapon(param_02)) {
      continue;
    }

    if(throwingknifeused_trygiveknife(var_08, param_01.power)) {
      param_01 delete();
      break;
    }
  }
}

recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.triggerportableradarping endon("disconnect");
  self.disttravelled = 0;
  var_00 = self.origin;
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_timeout_1(0.15, "death", "missile_stuck");
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

func_11825(param_00, param_01) {
  var_02 = scripts\mp\utility::outlineenableforplayer(param_01, "white", param_00, 1, 0, "equipment");
  param_01 waittill("death");
  scripts\mp\utility::outlinedisable(var_02, param_01);
}

throwingknifeused_trygiveknife(param_00, param_01) {
  if(param_00 scripts\mp\powers::func_D734(param_01) == param_00 scripts\mp\powers::func_D736(param_01)) {
    return 0;
  }

  param_00 scripts\mp\powers::func_D74C(param_01);
  param_00 scripts\mp\hud_message::showmiscmessage("throwingknife");
  return 1;
}

throwingknife_detachknivesfromcorpse(param_00) {
  var_01 = param_00 getlinkedchildren();
  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_04 = var_03.weapon_name;
    if(isDefined(var_04) && func_9FA9(var_04)) {
      var_03 unlink();
      var_05 = throwingknife_getdudknifeweapon(var_04);
      var_03 = var_03.triggerportableradarping scripts\mp\utility::_launchgrenade(var_05, var_03.origin, (0, 0, 0), 100, 1, var_03);
      if(isDefined(var_03.triggerportableradarping)) {
        var_03 setentityowner(var_03.triggerportableradarping);
      }

      thread throwingknife_triggerlinkto(var_03);
      var_03 missiledonttrackkillcam();
    }
  }
}

throwingknife_triggerlinkto(param_00) {
  param_00 endon("death");
  while(!isDefined(param_00.knife_trigger)) {
    scripts\engine\utility::waitframe();
  }

  var_01 = param_00.knife_trigger;
  var_01 endon("death");
  var_01 unlink();
  throwingknife_triggerlinktointernal(var_01, param_00);
  var_01 dontinterpolate();
  var_01.origin = param_00.origin;
  var_01.angles = param_00.angles;
  var_01 linkto(param_00);
}

throwingknife_triggerlinktointernal(param_00, param_01) {
  param_01 endon("missile_stuck");
  for(;;) {
    param_00.origin = param_01.origin;
    scripts\engine\utility::waitframe();
  }
}

throwingknife_getdudknifeweapon(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "throwingknifec4_mp":
      var_01 = "throwingknifec4dud_mp";
      break;

    case "throwingknifeteleport_mp":
      var_01 = "throwingknifeteleportdud_mp";
      break;

    default:
      var_01 = "throwingknifec4dud_mp";
      break;
  }

  return var_01;
}

throwingknifec4init() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx\iw7\_requests\mp\power\vfx_bio_spike_exp.vfx");
}

throwingknifec4detonate(param_00, param_01, param_02) {
  scripts\mp\missions::func_2AEA(param_00, param_02, param_01);
  param_01 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), param_00.origin);
  param_00 radiusdamage(param_00.origin, 180, 140, 70, param_02, "MOD_EXPLOSIVE", param_00.weapon_name);
  param_00 thread scripts\mp\shellshock::grenade_earthquake();
  param_00 notify("explode", param_00.origin);
}

func_1181E(param_00) {
  param_00 thread scripts\mp\equipment\smoke_wall::func_1037D(self);
}

func_F235(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 endon("disconnect");
  var_03 = spawnStruct();
  var_03.var_C78B = [];
  var_04 = 0;
  thread func_F233(param_00, param_01);
  while(isDefined(param_01)) {
    foreach(var_06 in level.characters) {
      if(!isDefined(var_06)) {
        continue;
      }

      if(!param_00 scripts\mp\utility::isenemy(var_06)) {
        continue;
      }

      if(var_06 scripts\mp\utility::_hasperk("specialty_incog")) {
        continue;
      }

      if(isDefined(var_03.var_C78B[var_06 getentitynumber()])) {
        continue;
      }

      if(distancesquared(param_01.origin, var_06.origin) > 90000) {
        continue;
      }

      var_03.var_C78B[var_06 getentitynumber()] = var_06;
      thread func_F234(param_00, var_06, var_03);
    }

    scripts\engine\utility::waitframe();
  }
}

func_10413(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_01 endon("death");
  var_03 = spawnStruct();
  var_03.var_C78B = [];
  var_04 = 0;
  thread func_F233(param_00, param_01);
  while(isDefined(param_01)) {
    foreach(var_06 in level.characters) {
      if(!isDefined(var_06)) {
        continue;
      }

      if(!param_00 scripts\mp\utility::isenemy(var_06)) {
        continue;
      }

      if(var_06 scripts\mp\utility::_hasperk("specialty_quieter")) {
        continue;
      }

      if(isDefined(var_03.var_C78B[var_06 getentitynumber()])) {
        continue;
      }

      if(distancesquared(param_01.origin, var_06.origin) > 90000) {
        continue;
      }

      var_07 = scripts\engine\utility::array_add_safe(level.players, param_01);
      if(!scripts\common\trace::ray_trace_passed(param_01.origin, var_06.origin + (0, 0, 32), var_07)) {
        continue;
      }

      var_03.var_C78B[var_06 getentitynumber()] = var_06;
      thread func_F234(param_00, var_06, var_03);
    }

    wait(2);
  }
}

func_F233(param_00, param_01) {
  param_01 endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  scripts\engine\utility::waitframe();
  scripts\mp\utility::outlineenableforplayer(param_01, "cyan", param_00, 0, 0, "equipment");
  if(param_01.weapon_name == "sonic_sensor_mp") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_sonic_sensor_pulse"), param_01, "tag_origin");
    return;
  }

  playfxontagforclients(scripts\engine\utility::getfx("vfx_sensor_grenade_ping"), param_01, "tag_origin", param_00);
}

func_F234(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  var_03 = param_01 getentitynumber();
  var_04 = undefined;
  param_01 scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  var_04 = scripts\mp\utility::outlineenableforplayer(param_01, "orange", param_00, 0, 0, "equipment");
  wait(0.5);
  if(isDefined(param_01) && isDefined(var_04)) {
    scripts\mp\utility::outlinedisable(var_04, param_01);
  }

  param_02.var_C78B[var_03] = undefined;
}

watchgrenadedeath() {
  self waittill("death");
  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }

  if(isDefined(self.useobj_trigger)) {
    self.useobj_trigger delete();
  }
}

func_1037B() {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_00);
  thread func_10377(var_00);
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread monitorsmokeactive();
  }
}

func_10377(param_00) {
  wait(1);
  thread smokegrenadegiveblindeye(param_00);
  var_01 = scripts\mp\utility::func_180C(param_00, 200);
  wait(8.25);
  scripts\mp\utility::func_E14A(var_01);
}

smokeunderbarrelused(param_00) {
  self endon("disconnect");
  param_00 waittill("explode", var_01);
  self launchgrenade("smoke_grenade_mp", var_01, (0, 0, 0));
  param_00 thread func_10377(var_01);
}

smokegrenadegiveblindeye(param_00) {
  var_01 = spawnStruct();
  var_01.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(var_01, param_00);
  foreach(var_03 in var_01.blindeyerecipients) {
    if(isDefined(var_03) && scripts\mp\utility::isreallyalive(var_03)) {
      var_03 scripts\mp\utility::removeperk("specialty_blindeye");
    }
  }
}

smokegrenademonitorblindeyerecipients(param_00, param_01) {
  level endon("game_ended");
  var_02 = gettime() + 8250;
  var_03 = [];
  while(gettime() < var_02) {
    var_03 = scripts\mp\utility::clearscrambler(param_01, 200);
    foreach(var_07, var_05 in param_00.blindeyerecipients) {
      if(!isDefined(var_05)) {
        param_00.blindeyerecipients[var_07] = undefined;
        continue;
      }

      var_06 = scripts\engine\utility::array_find(var_03, var_05);
      if(!isDefined(var_06) || !scripts\mp\utility::isreallyalive(var_05) || scripts\mp\equipment\phase_shift::isentityphaseshifted(var_05)) {
        var_05 scripts\mp\utility::removeperk("specialty_blindeye");
        param_00.blindeyerecipients[var_07] = undefined;
      }

      if(isDefined(var_06)) {
        var_03[var_06] = undefined;
      }
    }

    foreach(var_09 in var_03) {
      if(!isDefined(var_09)) {
        continue;
      }

      if(isDefined(param_00.blindeyerecipients[var_09 getentitynumber()])) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_09) || scripts\mp\equipment\phase_shift::isentityphaseshifted(var_09) || scripts\mp\utility::func_9F72(var_09)) {
        continue;
      }

      var_09 scripts\mp\utility::giveperk("specialty_blindeye");
      param_00.blindeyerecipients[var_09 getentitynumber()] = var_09;
    }

    scripts\engine\utility::waitframe();
  }
}

monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\mp\utility::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  var_00 = scripts\engine\utility::waittill_any_timeout_1(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility::printgameaction("smoke grenade deactivated", self);
}

watchgasgrenadeexplode() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self waittill("explode", var_01);
  thread ongasgrenadeimpact(var_00, var_01);
}

ongasgrenadeimpact(param_00, param_01) {
  var_02 = spawn("trigger_radius", param_01, 0, 128, 160);
  var_02.triggerportableradarping = param_00;
  var_03 = 128;
  var_04 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), param_01);
  triggerfx(var_04);
  wait(1);
  var_05 = 3;
  var_06 = spawn("script_model", param_01 + (0, 0, 60));
  var_06 linkto(var_02);
  var_02.killcament = var_06;
  while(var_05 > 0) {
    foreach(var_08 in level.characters) {
      var_08 applygaseffect(param_00, param_01, var_02, var_02, 4);
    }

    wait(0.2);
    var_05 = var_05 - 0.2;
  }

  var_04 delete();
  wait(2);
  var_06 delete();
  var_02 delete();
}

applygaseffect(param_00, param_01, param_02, param_03, param_04) {
  if(isalive(self) && self istouching(param_02)) {
    if(param_00 scripts\mp\utility::isenemy(self) || self == param_00) {
      param_03 radiusdamage(self.origin, 1, param_04, param_04, param_00, "MOD_RIFLE_BULLET", "gas_grenade_mp");
    }
  }
}

func_AF2B(param_00) {
  var_01 = [];
  if(level.teambased) {
    if(isDefined(param_00) && param_00 == 1) {
      foreach(var_03 in level.characters) {
        if(isDefined(var_03) && isalive(var_03) && var_03.team != self.team) {
          var_01[var_01.size] = var_03;
        }
      }
    }

    if(isDefined(level.var_1655)) {
      foreach(var_06 in level.var_1655) {
        if(isDefined(var_06.var_18DE) && var_06.team != self.team) {
          var_01[var_01.size] = var_06;
        }
      }
    }

    if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
      foreach(var_09 in level.supertrophy.trophies) {
        if(isDefined(var_09) && isDefined(var_09.team) && var_09.team != self.team) {
          var_01[var_01.size] = var_09;
        }
      }
    }

    if(isDefined(level.microturrets)) {
      foreach(var_0C in level.microturrets) {
        if(isDefined(var_0C) && isDefined(var_0C.team) && var_0C.team != self.team) {
          var_01[var_01.size] = var_0C;
        }
      }
    }
  } else {
    if(isDefined(param_00) && param_00 == 1) {
      foreach(var_03 in level.characters) {
        if(!isDefined(var_03) || !isalive(var_03)) {
          continue;
        }

        var_01[var_01.size] = var_03;
      }
    }

    if(isDefined(level.var_1655)) {
      foreach(var_06 in level.var_1655) {
        if(isDefined(var_06.var_18DE) && isDefined(var_06.triggerportableradarping) && var_06.triggerportableradarping != self) {
          var_01[var_01.size] = var_06;
        }
      }
    }

    if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
      foreach(var_09 in level.supertrophy.trophies) {
        if(isDefined(var_09) && isDefined(var_09.triggerportableradarping) && var_09.triggerportableradarping != self) {
          var_01[var_01.size] = var_09;
        }
      }
    }

    if(isDefined(level.microturrets)) {
      foreach(var_0C in level.microturrets) {
        if(isDefined(var_0C) && isDefined(var_0C.triggerportableradarping) && var_0C.triggerportableradarping != self) {
          var_01[var_01.size] = var_0C;
        }
      }
    }
  }

  return var_01;
}

watchmissileusage() {
  self endon("disconnect");
  for(;;) {
    var_00 = scripts\mp\utility::waittill_missile_fire();
    if(!isDefined(var_00)) {
      continue;
    }

    switch (var_00.weapon_name) {
      case "stinger_mp":
      case "iw7_lockon_mp":
        level notify("stinger_fired", self, var_00, self.var_10FAA);
        break;

      case "javelin_mp":
      case "lasedStrike_missile_mp":
      case "remote_mortar_missile_mp":
        level notify("stinger_fired", self, var_00, self.var_A445);
        break;

      case "iw7_blackholegun_mp":
        thread scripts\mp\supers\super_blackholegun::missilespawned(var_00.weapon_name, var_00);
        break;

      case "iw7_unsalmg_mpl_auto":
      case "iw7_unsalmg_mp":
      case "iw7_unsalmg_mpl":
        var_00.weapon_name = "power_smoke_drone_mp";
        thread scripts\mp\equipment\exploding_drone::func_69D4(var_00, 1);
        break;

      case "iw7_tacburst_mpl":
      case "iw7_tacburst_mp":
        var_00 thread scripts\mp\empgrenade::func_13A12();
        break;

      case "iw7_tacburst_mpl_epic2":
        var_00 thread scripts\mp\perks\_weaponpassives::cryogl_watchforexplode(self);
        break;

      case "iw7_mp28_mpl_fasthip":
        thread smokeunderbarrelused(var_00);
        break;

      default:
        break;
    }

    if(isplayer(self)) {
      var_00.adsfire = scripts\mp\utility::func_9EE8();
    }

    if(isexplosivemissile(var_00.weapon_name)) {
      var_01 = 1;
      if(func_9F5C(var_00.weapon_name)) {
        var_01 = 0.65;
      }

      var_00 thread scripts\mp\shellshock::grenade_earthquake(var_01);
    }

    var_00.var_FF03 = self isinphase();
  }
}

func_9F5C(param_00) {
  param_00 = getweaponbasename(param_00);
  var_01 = 0;
  switch (param_00) {
    case "iw7_venomx_mp":
    case "iw7_glprox_mp":
      var_01 = 1;
      break;

    default:
      break;
  }

  return var_01;
}

isexplosivemissile(param_00) {
  param_00 = getweaponbasename(param_00);
  switch (param_00) {
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
    thread scripts\mp\utility::setaltsceneobj(var_00, "tag_flash", 65);
  }
}

func_42D8(param_00) {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_01);
}

clustergrenadeused(param_00) {
  if(isalive(self)) {
    var_01 = anglesToForward(self getgunangles()) * 940;
    var_02 = (0, 0, 120);
    var_03 = var_01 + var_02;
  } else {
    var_01 = anglesToForward(self getgunangles()) * 50;
    var_02 = (0, 0, 10);
    var_03 = var_02 + var_03;
  }

  param_00 = scripts\mp\utility::_launchgrenade("cluster_grenade_mp", param_00.origin, var_03, 100, 1, param_00);
  param_00 thread func_4107();
  thread func_42DF(param_00);
}

func_42DF(param_00, param_01) {
  param_00 endon("death");
  self endon("disconnect");
  var_02 = 1 - param_00.tickpercent * 3.5;
  wait(var_02);
  thread clustergrenadeexplode(param_00);
}

clustergrenadeexplode(param_00) {
  param_00 notify("death");
  param_00.exploding = 1;
  param_00.origin = param_00.origin;
  var_01 = spawn("script_model", param_00.origin);
  var_01 setotherent(param_00.triggerportableradarping);
  var_01 setModel("prop_mp_cluster_grenade_scr");
  func_42DB(param_00, var_01);
  if(isDefined(param_00)) {
    param_00 forcehidegrenadehudwarning(1);
  }

  wait(2);
  if(isDefined(var_01)) {
    var_01 delete();
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_42DB(param_00, param_01) {
  self endon("disconnect");
  scripts\mp\utility::printgameaction("cluster grenade explode", self);
  var_02 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_03 = param_00.origin;
  var_04 = 0;
  var_05 = var_03 + (0, 0, 3);
  var_06 = var_05 + (0, 0, -5);
  var_07 = physics_raycast(var_05, var_06, var_02, undefined, 0, "physicsquery_closest");
  if(isDefined(var_07) && var_07.size > 0) {
    var_04 = 1;
  }

  var_08 = scripts\engine\utility::ter_op(var_04, (0, 0, 32), (0, 0, 2));
  var_09 = var_03 + var_08;
  var_0A = randomint(90) - 45;
  var_02 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 1, 0);
  for(var_0B = 0; var_0B < 4; var_0B++) {
    var_0C = "explode" + var_0B + 1;
    param_00 setscriptablepartstate(var_0C, "active", 0);
    var_0D = scripts\engine\utility::ter_op(var_0B < 4, 90 * var_0B + var_0A, randomint(360));
    var_0E = scripts\engine\utility::ter_op(var_04, 110, 90);
    var_0F = scripts\engine\utility::ter_op(var_04, 12, 45);
    var_10 = var_0E + randomint(var_0F * 2) - var_0F;
    var_11 = randomint(60) + 30;
    var_12 = cos(var_0D) * sin(var_10);
    var_13 = sin(var_0D) * sin(var_10);
    var_14 = cos(var_10);
    var_15 = (var_12, var_13, var_14) * var_11;
    var_05 = var_09;
    var_06 = var_09 + var_15;
    var_07 = physics_raycast(var_05, var_06, var_02, undefined, 0, "physicsquery_closest");
    if(isDefined(var_07) && var_07.size > 0) {
      var_06 = var_07[0]["position"];
    }

    param_01 dontinterpolate();
    param_01.origin = var_06;
    param_01 setscriptablepartstate(var_0C, "active", 0);
    wait(0.175);
  }
}

func_4107() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self delete();
}

func_10D85(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_04)) {
    return;
  }

  if(param_06) {
    var_0B = spawnfx(param_07, self.origin);
    playsoundatpos(self.origin, param_08);
    triggerfx(var_0B);
    wait(2);
    var_0B delete();
  } else {
    wait(param_00);
  }

  if(!isDefined(param_04)) {
    return;
  }

  radiusdamage(self.origin + (0, 0, 50), param_01, param_02, param_03, param_04, "MOD_EXPLOSIVE", param_0A);
  playFX(param_05, self.origin + (0, 0, 50));
  playsoundatpos(self.origin, param_09);
  self delete();
}

func_BFD3() {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_00);
  thread func_5925(var_00, self.triggerportableradarping, self.var_BFD5);
  func_BFD2(var_00, self.triggerportableradarping, self.var_BFD5);
}

func_BFD2(param_00, param_01, param_02) {
  if(param_02 >= 5 || func_CBED(param_01, param_02)) {
    playsoundatpos(param_00, "emp_grenade_explode_default");
    var_03 = getempdamageents(param_00, 512, 0, undefined);
    foreach(var_05 in var_03) {
      if(isDefined(var_05.triggerportableradarping) && !friendlyfirecheck(param_01, var_05.triggerportableradarping)) {
        continue;
      }

      var_05 notify("emp_damage", self.triggerportableradarping, 8);
    }
  }
}

func_CBED(param_00, param_01) {
  if(param_00 scripts\mp\utility::_hasperk("specialty_pitcher")) {
    if(param_01 >= 4) {
      return 1;
    }
  }

  return 0;
}

func_5925(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = level.weaponconfigs[self.weapon_name];
  wait(randomfloatrange(0.25, 0.5));
  for(var_04 = 1; var_04 < param_02; var_04++) {
    var_05 = func_7FF0(param_00, var_03.vfxradius);
    playsoundatpos(var_05, var_03.onexplodesfx);
    playFX(var_03.onexplodevfx, var_05);
    foreach(var_07 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_07) || var_07.sessionstate != "playing") {
        continue;
      }

      var_08 = var_07 getEye();
      var_09 = distancesquared(param_00, var_08);
      if(var_09 > var_03.radius_max_sq) {
        continue;
      }

      if(!bullettracepassed(param_00, var_08, 0, var_07)) {
        continue;
      }

      if(var_09 <= var_03.radius_min_sq) {
        var_0A = 1;
      } else {
        var_0A = 1 - var_09 - var_03.radius_min_sq / var_03.radius_max_sq - var_03.radius_min_sq;
      }

      var_0B = anglesToForward(var_07 getplayerangles());
      var_0C = param_00 - var_08;
      var_0C = vectornormalize(var_0C);
      var_0D = 0.5 * 1 + vectordot(var_0B, var_0C);
      var_0E = 1;
      var_07 notify("flashbang", param_00, var_0A, var_0D, param_01, var_0E);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

func_7FF0(param_00, param_01) {
  var_02 = (randomfloatrange(-1 * param_01, param_01), randomfloatrange(-1 * param_01, param_01), 0);
  var_03 = param_00 + var_02;
  var_04 = bulletTrace(param_00, var_03, 0, self, 0, 0, 0, 0, 0);
  if(var_04["fraction"] < 1) {
    var_03 = param_00 + var_04["fraction"] * var_02;
  }

  return var_03;
}

func_56E6(param_00) {
  param_00 waittill("missile_stuck", var_01);
  param_00 thread func_56E5(self, 1);
}

func_56E5(param_00, param_01) {
  level endon("game_ended");
  var_02 = level.weaponconfigs[self.weapon_name];
  playFX(var_02.var_C523, self.origin);
  for(var_03 = 0; var_03 < param_01; var_03++) {
    foreach(var_05 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_05) || var_05.sessionstate != "playing") {
        continue;
      }

      if(var_05.team == self.triggerportableradarping.team) {
        continue;
      }

      if(var_05 == self.triggerportableradarping) {
        continue;
      }

      var_06 = var_05 getEye();
      if(!scripts\common\trace::ray_trace_passed(self.origin, var_06, level.players)) {
        continue;
      }

      thread func_56E4(var_05, param_00, var_02, var_06);
    }

    wait(0.75);
    playsoundatpos(self.origin, var_02.onexplodesfx);
    playFX(var_02.onexplodevfx, self.origin);
  }

  self delete();
}

func_56E4(param_00, param_01, param_02, param_03) {
  var_04 = self.origin;
  var_05 = anglesToForward(param_00 getplayerangles());
  var_06 = var_04 - param_03;
  var_07 = vectornormalize(var_06);
  playFX(param_02.var_D828, var_04, rotatevector(var_06, (0, 180, 0)) * (1, 1, -1));
  wait(0.75);
  if(param_00 adsbuttonpressed() && param_00 worldpointinreticle_circle(var_04, 65, 300)) {
    param_00 shellshock("disruptor_mp", 2.5, 0, 1);
    return;
  }

  var_08 = distancesquared(var_04, param_03);
  if(var_08 < param_02.radius_max_sq) {
    if(var_08 <= param_02.radius_min_sq) {
      var_09 = 1;
    } else {
      var_09 = 1 - var_09 - param_03.radius_min_sq / param_03.radius_max_sq - param_03.radius_min_sq;
    }

    var_0A = 0.65 * 1 + vectordot(var_05, var_07);
    var_0B = 1;
    param_00 notify("flashbang", var_04, var_09, var_0A, param_01, var_0B);
  }
}

c4used(param_00) {
  if(!scripts\mp\utility::isreallyalive(self)) {
    param_00 delete();
    return;
  }

  self notify("c4_update", 0);
  param_00 thread ondetonateexplosive();
  thread watchc4detonation();
  thread watchc4altdetonation();
  thread watchc4altdetonate();
  param_00 setotherent(self);
  param_00.activated = 0;
  onlethalequipmentplanted(param_00, "power_c4");
  var_01 = level.weaponconfigs["c4_mp"];
  param_00 thread doblinkinglight("tag_fx", var_01.mine_beacon["friendly"], var_01.mine_beacon["enemy"]);
  param_00 thread scripts\mp\shellshock::c4_earthquake();
  param_00 thread c4activate();
  param_00 thread func_3343();
  param_00 thread func_66B4(1);
  param_00 thread watchc4stuck();
  level thread monitordisownedequipment(self, param_00);
}

watchc4implode() {
  self.triggerportableradarping endon("disconnect");
  var_00 = self.triggerportableradarping;
  var_01 = scripts\engine\utility::spawn_tag_origin();
  var_01 linkto(self);
  thread func_334D(var_01);
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_02);
  thread c4implode(var_02, var_00, var_01);
}

c4implode(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  wait(0.5);
  param_02 radiusdamage(param_00, 256, 140, 70, param_01, "MOD_EXPLOSIVE", "c4_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(param_00);
}

func_334D(param_00) {
  param_00 endon("death");
  self waittill("death");
  wait(1);
  param_00 delete();
}

movingplatformdetonate(param_00) {
  if(!isDefined(param_00.lasttouchedplatform) || !isDefined(param_00.lasttouchedplatform.destroyexplosiveoncollision) || param_00.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
  }
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck", var_00);
  self give_player_tickets(1);
  self.c4stuck = 1;
  thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread outlineequipmentforowner(self, self.triggerportableradarping);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", self.triggerportableradarping, 1);
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

func_DACD(param_00) {
  if(!scripts\mp\utility::isreallyalive(self)) {
    param_00 delete();
    return;
  }

  param_00 waittill("missile_stuck", var_01);
  if(!scripts\mp\utility::isreallyalive(self)) {
    param_00 delete();
    return;
  }

  if(!isDefined(param_00.triggerportableradarping.team)) {
    param_00 delete();
    return;
  }

  var_02 = anglestoup(param_00.angles);
  param_00.origin = param_00.origin - var_02;
  var_03 = level.weaponconfigs[param_00.weapon_name];
  var_04 = spawn("script_model", param_00.origin + var_03.killcamoffset * var_02);
  var_04 setscriptmoverkillcam("explosive");
  var_04 linkto(param_00);
  param_00.killcament = var_04;
  param_00 explosivehandlemovers(var_01);
  param_00 makeexplosiveusable();
  param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", param_00.triggerportableradarping, 1);
  onlethalequipmentplanted(param_00);
  param_00 thread ondetonateexplosive();
  param_00 thread func_3343();
  param_00 thread func_66B4(1);
  param_00 thread func_DACC(var_01);
  param_00 thread func_F692(self.team, 20);
  level thread monitordisownedequipment(self, param_00);
}

func_DACC(param_00) {
  self endon("death");
  self endon("disabled");
  var_01 = level.weaponconfigs[self.weapon_name];
  wait(var_01.armingdelay);
  self playLoopSound("ied_explo_beeps");
  thread doblinkinglight("tag_fx");
  var_02 = self.origin * (1, 1, 0);
  var_03 = var_01.detectionheight / 2;
  var_04 = self.origin[2] - var_03;
  var_02 = var_02 + (0, 0, var_04);
  var_05 = spawn("trigger_radius", var_02, 0, var_01.detectionradius, var_01.detectionheight);
  var_05.triggerportableradarping = self;
  if(isDefined(param_00)) {
    var_05 enablelinkto();
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
      if(isDefined(self.triggerportableradarping)) {
        if(var_06 == self.triggerportableradarping) {
          continue;
        }

        if(isDefined(var_06.triggerportableradarping) && var_06.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.triggerportableradarping, var_06, 0)) {
        continue;
      }
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
  explosivetrigger(var_06, var_01.detectiongraceperiod, "proxExplosive");
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
  if(isDefined(self.damagearea)) {
    self.damagearea delete();
  }
}

func_F692(param_00, param_01) {
  self endon("death");
  wait(0.05);
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon(param_00, (0, 0, param_01));
    return;
  }

  if(isDefined(self.triggerportableradarping)) {
    scripts\mp\entityheadicons::setplayerheadicon(self.triggerportableradarping, (0, 0, param_01));
  }
}

claymoreused(param_00) {
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  param_00 hide();
  param_00 scripts\engine\utility::waittill_any_timeout_1(0.05, "missile_stuck");
  if(!isDefined(self) || !isalive(self)) {
    param_00 delete();
    return;
  }

  var_01 = 60;
  var_02 = (0, 0, 4);
  var_03 = distancesquared(self.origin, param_00.origin);
  var_04 = distancesquared(self getEye(), param_00.origin);
  var_03 = var_03 + 600;
  var_05 = param_00 getlinkedparent();
  if(isDefined(var_05)) {
    param_00 unlink();
  }

  if(var_03 < var_04) {
    if(var_01 * var_01 < distancesquared(param_00.origin, self.origin)) {
      var_06 = bulletTrace(self.origin, self.origin - (0, 0, var_01), 0, self);
      if(var_06["fraction"] == 1) {
        param_00 delete();
        self setweaponammostock(param_00.weapon_name, self getweaponammostock(param_00.weapon_name) + 1);
        return;
      } else {
        param_00.origin = var_06["position"];
        var_05 = var_06["entity"];
      }
    } else {}
  } else if(var_01 * var_01 < distancesquared(param_00.origin, self getEye())) {
    var_06 = bulletTrace(self.origin, self.origin - (0, 0, var_01), 0, self);
    if(var_06["fraction"] == 1) {
      param_00 delete();
      self setweaponammostock(param_00.weapon_name, self getweaponammostock(param_00.weapon_name) + 1);
      return;
    } else {
      param_00.origin = var_06["position"];
      var_05 = var_06["entity"];
    }
  } else {
    var_02 = (0, 0, -5);
    param_00.angles = param_00.angles + (0, 180, 0);
  }

  param_00.angles = param_00.angles * (0, 1, 1);
  param_00.origin = param_00.origin + var_02;
  param_00 explosivehandlemovers(var_05);
  param_00 show();
  param_00 makeexplosiveusable();
  param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", param_00.triggerportableradarping, 1);
  onlethalequipmentplanted(param_00, "power_claymore");
  param_00 thread ondetonateexplosive();
  param_00 thread func_3343();
  param_00 thread func_66B4(1);
  param_00 thread claymoredetonation(var_05);
  param_00 thread func_F692(self.pers["team"], 20);
  level thread monitordisownedequipment(self, param_00);
}

claymoredetonation(param_00) {
  self endon("death");
  var_01 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);
  if(isDefined(param_00)) {
    var_01 enablelinkto();
    var_01 linkto(param_00);
  }

  thread deleteondeath(var_01);
  for(;;) {
    var_01 waittill("trigger", var_02);
    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.triggerportableradarping)) {
        if(var_02 == self.triggerportableradarping) {
          continue;
        }

        if(isDefined(var_02.triggerportableradarping) && var_02.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.triggerportableradarping, var_02, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_02 getentityvelocity()) < 10) {
      continue;
    }

    var_03 = abs(var_02.origin[2] - self.origin[2]);
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
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("claymore_destroyed", undefined, undefined, self.origin);
  }

  self notify("detonateExplosive");
}

shouldaffectclaymore(param_00) {
  if(isDefined(param_00.disabled)) {
    return 0;
  }

  var_01 = self.origin + (0, 0, 32);
  var_02 = var_01 - param_00.origin;
  var_03 = anglesToForward(param_00.angles);
  var_04 = vectordot(var_02, var_03);
  if(var_04 < level.claymoredetectionmindist) {
    return 0;
  }

  var_02 = vectornormalize(var_02);
  var_05 = vectordot(var_02, var_03);
  return var_05 > level.claymoredetectiondot;
}

deleteondeath(param_00) {
  self waittill("death");
  wait(0.05);
  if(isDefined(param_00)) {
    if(isDefined(param_00.trigger)) {
      param_00.trigger delete();
    }

    param_00 delete();
  }
}

c4activate() {
  self endon("death");
  self waittill("missile_stuck", var_00);
  wait(0.05);
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
        wait(0.05);
      }

      if(var_00 >= 0.5) {
        continue;
      }

      var_00 = 0;
      while(!self usebuttonpressed() && var_00 < 0.5) {
        var_00 = var_00 + 0.05;
        wait(0.05);
      }

      if(var_00 >= 0.5) {
        continue;
      }

      if(!self.plantedlethalequip.size) {
        return;
      }

      if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(self) && !scripts\mp\utility::isusingremote()) {
        self notify("alt_detonate");
      }
    }

    wait(0.05);
  }
}

watchc4detonation(param_00) {
  self notify("watchC4Detonation");
  self endon("watchC4Detonation");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittillmatch("c4_mp", "detonate");
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
    if(var_00 != "c4_mp") {
      c4detonateallcharges();
    }
  }
}

c4detonateallcharges() {
  foreach(var_01 in self.plantedlethalequip) {
    if(isDefined(var_01) && var_01.weapon_name == "c4_mp") {
      var_01 thread waitanddetonate(0.1);
    }
  }

  self.plantedlethalequip = [];
  self notify("c4_update", 0);
  self notify("detonated");
}

waitanddetonate(param_00) {
  self endon("death");
  wait(param_00);
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
  if(self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_01++;
  }

  for(;;) {
    self waittill("damage", var_02, var_00, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isplayer(var_00) && !isagent(var_00)) {
      continue;
    }

    if(!friendlyfirecheck(self.triggerportableradarping, var_00)) {
      continue;
    }

    if(func_66AA(var_0A, var_05)) {
      continue;
    }

    var_0B = scripts\engine\utility::ter_op(scripts\mp\utility::isfmjdamage(var_0A, var_05), 2, 1);
    var_01 = var_01 - var_0B;
    if(var_01 <= 0) {
      break;
    }

    if(var_01 <= 0) {
      break;
    } else {
      var_00 scripts\mp\damagefeedback::updatedamagefeedback("bouncing_betty");
    }
  }

  if(level.c4explodethisframe) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait(0.05);
  }

  if(!isDefined(self)) {
    return;
  }

  level.c4explodethisframe = 1;
  thread resetc4explodethisframe();
  if(isDefined(var_05) && issubstr(var_05, "MOD_GRENADE") || issubstr(var_05, "MOD_EXPLOSIVE")) {
    self.waschained = 1;
  }

  if(isDefined(var_09) && var_09 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_09) && var_09 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;
  if(isDefined(var_00)) {
    self.damagedby = var_00;
  }

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback("c4");
    if(var_00 != self.triggerportableradarping && var_00.team != self.triggerportableradarping.team) {
      if(var_0A != "trophy_mp") {
        var_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
      }
    }
  }

  if(level.teambased) {
    if(isDefined(var_00) && isDefined(self.triggerportableradarping)) {
      var_0C = var_00.pers["team"];
      var_0D = self.triggerportableradarping.pers["team"];
      if(isDefined(var_0C) && isDefined(var_0D) && var_0C != var_0D) {
        var_00 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.triggerportableradarping) && isDefined(var_00) && var_00 != self.triggerportableradarping) {
    var_00 notify("destroyed_equipment");
  }

  if(getdvarint("showArchetypes", 0) > 0) {
    if(self.weapon_name == "c4_mp") {
      self.triggerportableradarping notify("c4_update", 0);
    }
  }

  self notify("detonateExplosive", var_00);
}

resetc4explodethisframe() {
  wait(0.05);
  level.c4explodethisframe = 0;
}

func_EB82(param_00, param_01) {
  for(var_02 = 0; var_02 < 60; var_02++) {
    wait(0.05);
  }
}

waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }

  self waittill("enabled");
}

func_3347(param_00) {
  self waittill("activated");
  var_01 = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  var_01.var_53B1 = "trigger" + gettime() + randomint(1000000);
  var_01.triggerportableradarping = self;
  var_01 thread func_53B0(level.otherteam[param_00]);
  self waittill("death");
  var_01 notify("end_detection");
  if(isDefined(var_01.var_2C65)) {
    var_01.var_2C65 destroy();
  }

  var_01 delete();
}

claymoredetectiontrigger(param_00) {
  var_01 = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  var_01.var_53B1 = "trigger" + gettime() + randomint(1000000);
  var_01.triggerportableradarping = self;
  var_01 thread func_53B0(level.otherteam[param_00]);
  self waittill("death");
  var_01 notify("end_detection");
  if(isDefined(var_01.var_2C65)) {
    var_01.var_2C65 destroy();
  }

  var_01 delete();
}

func_53B0(param_00) {
  self endon("end_detection");
  level endon("game_ended");
  while(!level.gameended) {
    self waittill("trigger", var_01);
    if(!var_01.var_53AD) {
      continue;
    }

    if(level.teambased && var_01.team != param_00) {
      continue;
    } else if(!level.teambased && var_01 == self.triggerportableradarping.triggerportableradarping) {
      continue;
    }

    if(isDefined(var_01.var_2C67[self.var_53B1])) {
      continue;
    }

    var_01 thread showheadicon(self);
  }
}

monitordisownedequipment(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("death");
  param_00 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  param_01 deleteexplosive();
}

monitordisownedgrenade(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("death");
  param_01 endon("mine_planted");
  param_00 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  if(isDefined(param_01)) {
    param_01 delete();
  }
}

isplantedequipment(param_00) {
  return isDefined(level.mines[param_00 getentitynumber()]) || scripts\mp\utility::istrue(param_00.planted);
}

func_7F9A(param_00) {
  var_01 = 0;
  var_02 = scripts\mp\powers::getcurrentequipment("primary");
  if(isDefined(var_02)) {
    var_01 = var_01 + scripts\mp\powers::func_D736(var_02);
    if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
      var_01++;
    }
  }

  return var_01;
}

func_7FA3(param_00) {
  var_01 = 0;
  var_02 = scripts\mp\powers::getcurrentequipment("secondary");
  if(isDefined(var_02)) {
    var_01 = var_01 + scripts\mp\powers::func_D736(var_02);
    if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
      var_01++;
    }
  }

  return var_01;
}

onlethalequipmentplanted(param_00, param_01, param_02) {
  param_00.var_D77A = param_01;
  param_00.var_51B6 = param_02;
  param_00.planted = 1;
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);
    if(self.plantedlethalequip.size && self.plantedlethalequip.size >= func_7F9A(self)) {
      self.plantedlethalequip[0] deleteexplosive();
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = param_00;
  var_03 = param_00 getentitynumber();
  level.mines[var_03] = param_00;
  level notify("mine_planted");
}

ontacticalequipmentplanted(param_00, param_01, param_02) {
  param_00.var_D77A = param_01;
  param_00.var_51B6 = param_02;
  param_00.planted = 1;
  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
    if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= func_7FA3(self)) {
      self.plantedtacticalequip[0] deleteexplosive();
    }
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = param_00;
  var_03 = param_00 getentitynumber();
  level.mines[var_03] = param_00;
  level notify("mine_planted");
}

func_5608() {
  if(isDefined(self.plantedlethalequip) && self.plantedlethalequip.size > 0) {
    foreach(var_01 in self.plantedlethalequip) {
      if(isDefined(var_01.trigger) && isDefined(var_01.triggerportableradarping)) {
        var_01.trigger disableplayeruse(var_01.triggerportableradarping);
      }
    }
  }

  if(isDefined(self.plantedtacticalequip) && self.plantedtacticalequip.size > 0) {
    foreach(var_01 in self.plantedtacticalequip) {
      if(isDefined(var_01.trigger) && isDefined(var_01.triggerportableradarping)) {
        var_01.trigger disableplayeruse(var_01.triggerportableradarping);
      }
    }
  }
}

cleanupequipment(param_00, param_01, param_02, param_03) {
  if(getdvarint("showArchetypes", 0) > 0) {
    if(isDefined(self.weapon_name)) {
      if(self.weapon_name == "c4_mp") {
        self.triggerportableradarping notify("c4_update", 0);
      } else if(self.weapon_name == "bouncingbetty_mp") {
        self.triggerportableradarping notify("bouncing_betty_update", 0);
      } else if(self.weapon_name == "trip_mine_mp") {
        self.triggerportableradarping notify("trip_mine_update", 0);
      } else if(self.weapon_name == "cryo_mine_mp") {
        self.triggerportableradarping notify("cryo_mine_update", 0);
      } else if(self.weapon_name == "fear_grenade_mp") {
        self.triggerportableradarping notify("restart_fear_grenade_cooldown", 0);
      } else if(self.weapon_name == "trophy_mp") {
        self.triggerportableradarping notify("trophy_update", 0);
      }
    }
  }

  if(isDefined(param_00)) {
    level.mines[param_00] = undefined;
  }

  if(isDefined(param_01)) {
    param_01 delete();
  }

  if(isDefined(param_02)) {
    param_02 delete();
  }

  if(isDefined(param_03)) {
    param_03 delete();
  }
}

deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }

  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var_00 = self getentitynumber();
  level.mines[var_00] = undefined;
  if(isDefined(self.var_51B6)) {
    self thread[[self.var_51B6]]();
    self notify("deleted_equipment");
    return;
  }

  var_01 = self.killcament;
  var_02 = self.trigger;
  var_03 = self.sensor;
  cleanupequipment(var_00, var_01, var_02, var_03);
  self notify("deleted_equipment");
  self delete();
}

ondetonateexplosive() {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");
  self detonate(self.triggerportableradarping);
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

makeexplosiveusable(param_00) {
  self setotherent(self.triggerportableradarping);
  if(!isDefined(param_00)) {
    param_00 = 10;
  }

  var_01 = spawn("script_origin", self.origin + param_00 * anglestoup(self.angles));
  var_01 linkto(self);
  self.trigger = var_01;
  var_01.triggerportableradarping = self;
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

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  var_00 = self.trigger;
  self.trigger = undefined;
  if(isDefined(var_00)) {
    var_00 delete();
  }
}

watchexplosiveusable() {
  var_00 = self.triggerportableradarping;
  var_01 = self.trigger;
  self endon("death");
  var_01 endon("death");
  var_00 endon("disconnect");
  level endon("game_ended");
  var_01 setcursorhint("HINT_NOICON");
  var_01 scripts\mp\utility::setselfusable(var_00);
  var_01 childthread scripts\mp\utility::notusableforjoiningplayers(var_00);
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
    var_01 waittillmatch(var_00, "trigger");
    if(isDefined(self.weapon_name)) {
      switch (self.weapon_name) {
        case "trophy_mp":
          thread scripts\mp\trophy_system::func_12818();
          break;
      }

      var_00 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_00 playlocalsound("scavenger_pack_pickup");
    var_00 notify("scavenged_ammo", self.weapon_name);
    thread deleteexplosive();
  }
}

makeexplosiveusabletag(param_00, param_01) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_02 = self.triggerportableradarping;
  var_03 = self.weapon_name;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    self grenade_earthquake(1);
  } else {
    self setcursorhint("HINT_NOICON");
  }

  self _meth_84A7(param_00);
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

  scripts\mp\utility::setselfusable(var_02);
  childthread scripts\mp\utility::notusableforjoiningplayers(var_02);
  for(;;) {
    self waittillmatch(var_02, "trigger");
    if(isDefined(var_03)) {
      switch (var_03) {
        case "trophy_mp":
          thread scripts\mp\trophy_system::func_12818();
          break;
      }

      var_02 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_02 playlocalsound("scavenger_pack_pickup");
    var_02 notify("scavenged_ammo", var_03);
    thread deleteexplosive();
  }
}

makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

explosivehandlemovers(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.linkparent = param_00;
  var_02.deathoverridecallback = ::movingplatformdetonate;
  var_02.endonstring = "death";
  if(!isDefined(param_01) || !param_01) {
    var_02.invalidparentoverridecallback = ::scripts\mp\movers::moving_platform_empty_func;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_02);
}

explosivetrigger(param_00, param_01, param_02) {
  if(isplayer(param_00) && param_00 scripts\mp\utility::_hasperk("specialty_delaymine")) {
    param_00 thread scripts\mp\missions::func_127BC();
    param_00 notify("triggeredExpl", param_02);
    param_01 = level.delayminetime;
  }

  wait(param_01);
}

func_FA95() {
  self.var_2C67 = [];
  if(self.var_53AD && !self.var_2C66.size) {
    for(var_00 = 0; var_00 < 4; var_00++) {
      self.var_2C66[var_00] = newclienthudelem(self);
      self.var_2C66[var_00].x = 0;
      self.var_2C66[var_00].y = 0;
      self.var_2C66[var_00].var_3A6 = 0;
      self.var_2C66[var_00].alpha = 0;
      self.var_2C66[var_00].archived = 1;
      self.var_2C66[var_00] setshader("waypoint_bombsquad", 14, 14);
      self.var_2C66[var_00] setwaypoint(0, 0);
      self.var_2C66[var_00].var_53B1 = "";
    }

    return;
  }

  if(!self.var_53AD) {
    for(var_00 = 0; var_00 < self.var_2C66.size; var_00++) {
      self.var_2C66[var_00] destroy();
    }

    self.var_2C66 = [];
  }
}

showheadicon(param_00) {
  var_01 = param_00.var_53B1;
  var_02 = -1;
  for(var_03 = 0; var_03 < 4; var_03++) {
    var_04 = self.var_2C66[var_03].var_53B1;
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

  self.var_2C67[var_01] = 1;
  self.var_2C66[var_02].x = param_00.origin[0];
  self.var_2C66[var_02].y = param_00.origin[1];
  self.var_2C66[var_02].var_3A6 = param_00.origin[2] + 24 + 128;
  self.var_2C66[var_02] fadeovertime(0.25);
  self.var_2C66[var_02].alpha = 1;
  self.var_2C66[var_02].var_53B1 = param_00.var_53B1;
  while(isalive(self) && isDefined(param_00) && self istouching(param_00)) {
    wait(0.05);
  }

  if(!isDefined(self)) {
    return;
  }

  self.var_2C66[var_02].var_53B1 = "";
  self.var_2C66[var_02] fadeovertime(0.25);
  self.var_2C66[var_02].alpha = 0;
  self.var_2C67[var_01] = undefined;
}

getdamageableents(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_05 = param_01 * param_01;
  var_06 = level.players;
  for(var_07 = 0; var_07 < var_06.size; var_07++) {
    if(!isalive(var_06[var_07]) || var_06[var_07].sessionstate != "playing") {
      continue;
    }

    var_08 = scripts\mp\utility::func_7921(var_06[var_07]);
    var_09 = distancesquared(param_00, var_08);
    if(var_09 < var_05 && !param_02 || func_13C7E(param_00, var_08, param_03, var_06[var_07])) {
      var_04[var_04.size] = scripts\mp\utility::func_7920(var_06[var_07], var_08);
    }
  }

  var_0A = getEntArray("grenade", "classname");
  for(var_07 = 0; var_07 < var_0A.size; var_07++) {
    var_0B = scripts\mp\utility::func_791E(var_0A[var_07]);
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_13C7E(param_00, var_0B, param_03, var_0A[var_07])) {
      var_04[var_04.size] = scripts\mp\utility::func_791D(var_0A[var_07], var_0B);
    }
  }

  var_0C = getEntArray("destructible", "targetname");
  for(var_07 = 0; var_07 < var_0C.size; var_07++) {
    var_0B = var_0C[var_07].origin;
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_13C7E(param_00, var_0B, param_03, var_0C[var_07])) {
      var_0D = spawnStruct();
      var_0D.isplayer = 0;
      var_0D.var_9D26 = 0;
      var_0D.issplitscreen = var_0C[var_07];
      var_0D.damagecenter = var_0B;
      var_04[var_04.size] = var_0D;
    }
  }

  var_0E = getEntArray("destructable", "targetname");
  for(var_07 = 0; var_07 < var_0E.size; var_07++) {
    var_0B = var_0E[var_07].origin;
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_13C7E(param_00, var_0B, param_03, var_0E[var_07])) {
      var_0D = spawnStruct();
      var_0D.isplayer = 0;
      var_0D.var_9D26 = 1;
      var_0D.issplitscreen = var_0E[var_07];
      var_0D.damagecenter = var_0B;
      var_04[var_04.size] = var_0D;
    }
  }

  var_0F = getEntArray("misc_turret", "classname");
  foreach(var_11 in var_0F) {
    var_0B = var_11.origin + (0, 0, 32);
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_13C7E(param_00, var_0B, param_03, var_11)) {
      switch (var_11.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_remote_turret":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          var_04[var_04.size] = scripts\mp\utility::func_7922(var_11, var_0B);
          break;
      }
    }
  }

  var_13 = getEntArray("script_model", "classname");
  foreach(var_15 in var_13) {
    if(var_15.model != "projectile_bouncing_betty_grenade" && var_15.model != "ims_scorpion_body") {
      continue;
    }

    var_0B = var_15.origin + (0, 0, 32);
    var_09 = distancesquared(param_00, var_0B);
    if(var_09 < var_05 && !param_02 || func_13C7E(param_00, var_0B, param_03, var_15)) {
      var_04[var_04.size] = scripts\mp\utility::func_791F(var_15, var_0B);
    }
  }

  return var_04;
}

getempdamageents(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_05 = param_01 * param_01;
  level.mines = scripts\engine\utility::array_removeundefined(level.mines);
  foreach(var_07 in level.mines) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  var_09 = getEntArray("misc_turret", "classname");
  foreach(var_07 in var_09) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.uplinks) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.remote_uav) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.balldrones) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.placedims) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.microturrets) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.var_105EA) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.var_69D6) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.spidergrenade.activeagents) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.spidergrenade.proxies) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.var_2ABD) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.var_590F) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.littlebirds) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.var_D3CC) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03)) {
      var_04[var_04.size] = var_07;
    }
  }

  foreach(var_07 in level.players) {
    if(func_619A(var_07, param_00, var_05, param_02, param_03) && scripts\mp\utility::func_9EF0(var_07)) {
      var_04[var_04.size] = var_07;
    }
  }

  return var_04;
}

func_619A(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00.origin;
  var_06 = distancesquared(param_01, var_05);
  return var_06 < param_02 && !param_03 || func_13C7E(param_01, var_05, param_04, param_00);
}

func_13C7E(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = param_01 - param_00;
  if(lengthsquared(var_05) < param_02 * param_02) {
    return 1;
  }

  var_06 = vectornormalize(var_05);
  var_04 = param_00 + (var_06[0] * param_02, var_06[1] * param_02, var_06[2] * param_02);
  var_07 = bulletTrace(var_04, param_01, 0, param_03);
  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread debugprint(param_00, ".dmg");
    if(isDefined(param_03)) {
      thread debugprint(param_01, "." + param_03.classname);
    } else {
      thread debugprint(param_01, ".undefined");
    }

    if(var_07["fraction"] == 1) {
      thread debugline(var_04, param_01, (1, 1, 1));
    } else {
      thread debugline(var_04, var_07["position"], (1, 0.9, 0.8));
      thread debugline(var_07["position"], param_01, (1, 0.4, 0.3));
    }
  }

  return var_07["fraction"] == 1;
}

func_66B4(param_00) {
  self endon("death");
  self waittill("emp_damage", var_01, var_02, var_03, var_04, var_05);
  if(isDefined(var_04) && var_04 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_01))) {
      var_01 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  equipmentempstunvfx();
  if(isDefined(self.triggerportableradarping) && isDefined(var_01) && self.triggerportableradarping != var_01) {
    var_01 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
  }

  if(isDefined(param_00) && param_00) {
    deleteexplosive();
    return;
  }

  self notify("detonateExplosive");
}

damageent(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(self.isplayer) {
    self.var_4D5B = param_05;
    self.issplitscreen thread[[level.callbackplayerdamage]](param_00, param_01, param_02, 0, param_03, param_04, param_05, param_06, "none", 0);
    return;
  }

  if(self.var_9D26 && param_04 == "artillery_mp" || param_04 == "claymore_mp" || param_04 == "stealth_bomb_mp") {
    return;
  }

  self.issplitscreen notify("damage", param_02, param_01, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, param_04);
}

debugline(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < 600; var_03++) {
    wait(0.05);
  }
}

debugcircle(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 16;
  }

  var_04 = 360 / param_03;
  var_05 = [];
  for(var_06 = 0; var_06 < param_03; var_06++) {
    var_07 = var_04 * var_06;
    var_08 = cos(var_07) * param_01;
    var_09 = sin(var_07) * param_01;
    var_0A = param_00[0] + var_08;
    var_0B = param_00[1] + var_09;
    var_0C = param_00[2];
    var_05[var_05.size] = (var_0A, var_0B, var_0C);
  }

  for(var_06 = 0; var_06 < var_05.size; var_06++) {
    var_0D = var_05[var_06];
    if(var_06 + 1 >= var_05.size) {
      var_0E = var_05[0];
    } else {
      var_0E = var_05[var_06 + 1];
    }

    thread debugline(var_0D, var_0E, param_02);
  }
}

debugprint(param_00, param_01) {
  for(var_02 = 0; var_02 < 600; var_02++) {
    wait(0.05);
  }
}

onweapondamage(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  if(!scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  if(isDefined(param_01) && param_01 != "none") {
    param_01 = getweaponbasename(param_01);
  }

  switch (param_01) {
    case "cluster_grenade_mp":
      if(isDefined(param_00) && scripts\mp\utility::istrue(param_00.shellshockondamage)) {
        scripts\mp\shellshock::shellshockondamage(param_02, param_03);
      }
      break;

    case "concussion_grenade_mp":
      if(param_03 > 0) {
        thread scripts\mp\concussiongrenade::onweapondamage(param_00, param_01, param_02, param_03, param_04);
      }
      break;

    case "blackout_grenade_mp":
      if(param_03 > 0) {
        if(param_02 != "MOD_IMPACT") {
          scripts\mp\equipment\blackout_grenade::func_10D6F(param_00.triggerportableradarping, param_00.origin);
        }
      }
      break;

    case "gltacburst_regen":
    case "venomproj_mp":
    case "cryo_mine_mp":
      if(param_03 > 0) {
        if(param_02 != "MOD_IMPACT") {
          if(isDefined(param_00)) {
            if(isDefined(param_00.streakinfo)) {
              if(scripts\mp\killstreaks\_utility::func_A69F(param_00.streakinfo, "passive_increased_frost")) {
                scripts\mp\equipment\cryo_mine::func_4ACF(param_04, 3);
              } else {
                scripts\mp\equipment\cryo_mine::func_4ACF(param_04);
              }
            } else {
              scripts\mp\equipment\cryo_mine::func_4ACF(param_04);
            }
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
      scripts\mp\equipment\ground_pound::groundpound_victimimpacteffects(param_04, self, param_01, param_00);
      break;

    case "gltacburst_big":
    case "gltacburst":
      if(param_03 > 0) {
        thread scripts\mp\empgrenade::onweapondamage(param_00, param_01, param_02, param_03, param_04);
      }
      break;

    default:
      scripts\mp\shellshock::shellshockondamage(param_02, param_03);
      break;
  }
}

isprimaryweapon(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(weaponinventorytype(param_00) != "primary") {
    return 0;
  }

  switch (weaponclass(param_00)) {
    case "mg":
    case "rifle":
    case "spread":
    case "rocketlauncher":
    case "sniper":
    case "smg":
    case "pistol":
      return 1;

    default:
      return 0;
  }
}

isbulletweapon(param_00) {
  if(param_00 == "none" || isriotshield(param_00) || isknifeonly(param_00)) {
    return 0;
  }

  switch (weaponclass(param_00)) {
    case "mg":
    case "rifle":
    case "spread":
    case "sniper":
    case "smg":
    case "pistol":
      return 1;

    default:
      return 0;
  }
}

isknifeonly(param_00) {
  return scripts\mp\utility::getweaponrootname(param_00) == "iw7_knife";
}

isballweapon(param_00) {
  return scripts\mp\utility::getweaponrootname(param_00) == "iw7_uplinkball" || scripts\mp\utility::getweaponrootname(param_00) == "iw7_tdefball";
}

isaxeweapon(param_00) {
  return scripts\mp\utility::getweaponrootname(param_00) == "iw7_axe";
}

isaltmodeweapon(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return weaponinventorytype(param_00) == "altmode";
}

func_9E56(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return weaponinventorytype(param_00) == "item";
}

func_9F5D(param_00) {
  return isDefined(param_00) && scripts\mp\utility::getweaponrootname(param_00) == "iw7_emc";
}

isriotshield(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return weapontype(param_00) == "riotshield";
}

func_9EC0(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return weaponinventorytype(param_00) == "offhand";
}

func_9F54(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(weaponinventorytype(param_00) != "primary") {
    return 0;
  }

  return weaponclass(param_00) == "pistol";
}

func_9E18(param_00) {
  var_01 = weaponclass(param_00);
  if(var_01 != "grenade") {
    return 0;
  }

  var_02 = weaponinventorytype(param_00);
  if(var_02 != "offhand") {
    return 0;
  }

  return 1;
}

func_9FA9(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return issubstr(param_00, "throwingknife");
}

updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_00 = self.currentweaponatspawn;
  if(isDefined(self.saved_lastweaponhack)) {
    var_00 = self.saved_lastweaponhack;
  }

  self.saved_lastweapon = var_00;
  self.var_EB6C = var_00;
  for(;;) {
    self waittill("weapon_change", var_01);
    self.var_EB6C = var_01;
    if(var_01 == "none") {
      continue;
    } else if(scripts\mp\utility::issuperweapon(var_01)) {
      updatemovespeedscale();
      continue;
    } else if(scripts\mp\utility::iskillstreakweapon(var_01)) {
      continue;
    } else {
      var_02 = weaponinventorytype(var_01);
      if(var_02 != "primary" && var_02 != "altmode") {
        continue;
      }
    }

    updatemovespeedscale();
    self.saved_lastweapon = var_00;
    var_00 = var_01;
  }
}

empplayer(param_00) {
  self endon("disconnect");
  self endon("death");
  thread func_41AB();
}

func_41AB() {
  self endon("disconnect");
  self waittill("death");
}

_meth_8237() {
  var_00 = 2;
  self.weaponlist = self getweaponslistprimaries();
  if(self.weaponlist.size) {
    foreach(var_02 in self.weaponlist) {
      if(scripts\mp\utility::issuperweapon(var_02)) {
        var_03 = scripts\mp\supers::func_7FD0(var_02);
      } else if(scripts\mp\utility::func_9E0D(var_02)) {
        var_03 = func_7ECD(var_02);
      } else {
        var_03 = _meth_8236(var_02);
      }

      if(!isDefined(var_03) || var_03 == 0) {
        continue;
      }

      if(var_03 < var_00) {
        var_00 = var_03;
      }
    }
  } else {
    var_00 = 0.94;
  }

  var_00 = clampweaponspeed(var_00);
  return var_00;
}

_meth_8236(param_00) {
  var_01 = scripts\mp\utility::getweaponrootname(param_00);
  return level.weaponmapdata[var_01].getclosestpointonnavmesh3d;
}

func_7ECD(param_00) {
  return 1;
}

clampweaponspeed(param_00) {
  return clamp(param_00, 0, 1);
}

updateviewkickscale(param_00) {
  if(isDefined(param_00)) {
    self.var_1339E = param_00;
  }

  if(isDefined(self.var_C7E8)) {
    param_00 = self.var_C7E8;
  } else if(scripts\mp\utility::_hasperk("specialty_distance_kit")) {
    param_00 = 0.05;
  } else if(isDefined(self.overrideviewkickscale)) {
    if((weaponclass(self getcurrentweapon()) == "sniper" || issubstr(self getcurrentweapon(), "iw7_udm45_mpl") || issubstr(self getcurrentweapon(), "iw7_longshot_mp")) && isDefined(self.overrideviewkickscalesniper)) {
      param_00 = self.overrideviewkickscalesniper;
    } else {
      param_00 = self.overrideviewkickscale;
    }
  } else if(isDefined(self.var_1339E)) {
    param_00 = self.var_1339E;
  } else {
    param_00 = 1;
  }

  param_00 = clamp(param_00, 0, 1);
  self setviewkickscale(param_00);
}

updatemovespeedscale() {
  var_00 = undefined;
  if(isDefined(self.playerstreakspeedscale)) {
    var_00 = 1;
    var_00 = var_00 + self.playerstreakspeedscale;
  } else {
    var_00 = getplayerspeedbyweapon(self);
    if(isDefined(self.overrideweaponspeed_speedscale)) {
      var_00 = self.overrideweaponspeed_speedscale;
    }

    var_01 = self.chill_data;
    if(isDefined(var_01) && isDefined(var_01.speedmod)) {
      var_00 = var_00 + var_01.speedmod;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var_00 = var_00 + self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var_00 = var_00 + self.weaponpassivespeedonkillmod;
    }

    var_00 = var_00 + scripts\mp\perks\_weaponpassives::passivecolddamagegetspeedmod(self);
    if(isDefined(self.weaponpassivefastrechamberspeedmod)) {
      var_00 = var_00 + self.weaponpassivefastrechamberspeedmod;
    }

    if(isDefined(self.speedonkillmod)) {
      var_00 = var_00 + self.speedonkillmod;
    }
  }

  self.weaponspeed = var_00;
  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  var_00 = var_00 + self.movespeedscaler - 1;
  var_00 = var_00 + self.combatspeedscalar - 1;
  var_00 = clamp(var_00, 0, 1.08);
  if(isDefined(self.fastcrouchspeedmod)) {
    var_00 = var_00 + self.fastcrouchspeedmod;
  }

  self setmovespeedscale(var_00);
}

getplayerspeedbyweapon(param_00) {
  var_01 = 1;
  self.weaponlist = self getweaponslistprimaries();
  if(!self.weaponlist.size) {
    var_01 = 0.94;
  } else {
    var_02 = self getcurrentweapon();
    if(scripts\mp\utility::issuperweapon(var_02)) {
      var_01 = scripts\mp\supers::func_7FD0(var_02);
    } else if(scripts\mp\utility::func_9E0D(var_02)) {
      var_01 = func_7ECD(var_02);
    } else if(scripts\mp\utility::iskillstreakweapon(var_02)) {
      var_01 = 0.94;
    } else if(issubstr(var_02, "iw7_mauler_mpl_damage")) {
      var_01 = 0.87;
    } else if(issubstr(var_02, "iw7_udm45_mpl")) {
      var_01 = 0.95;
    } else if(issubstr(var_02, "iw7_rvn") && self _meth_8519(var_02)) {
      var_01 = 1;
    } else if(issubstr(var_02, "iw7_longshot") && self _meth_8519(var_02)) {
      var_01 = 0.98;
    } else {
      var_03 = weaponinventorytype(var_02);
      if(var_03 != "primary" && var_03 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var_02 = self.saved_lastweapon;
        } else {
          var_02 = undefined;
        }
      }

      if(!isDefined(var_02) || !self hasweapon(var_02)) {
        var_01 = _meth_8237();
      } else {
        var_01 = _meth_8236(var_02);
      }
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
    scripts\engine\utility::waittill_any_3("adjustedStance", "sprint_begin", "weapon_change");
    wait(0.5);
    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }

    var_00 = self getstance();
    stancerecoilupdate(var_00);
  }
}

stancerecoilupdate(param_00) {
  var_01 = self getcurrentprimaryweapon();
  var_02 = 0;
  if(isrecoilreducingweapon(var_01)) {
    var_02 = getrecoilreductionvalue();
  }

  if(param_00 == "prone") {
    var_03 = scripts\mp\utility::getweapongroup(var_01);
    if(var_03 == "weapon_lmg") {
      scripts\mp\utility::setrecoilscale(0, 0);
      return;
    }

    if(var_03 == "weapon_sniper") {
      if(issubstr(var_01, "barrelbored")) {
        scripts\mp\utility::setrecoilscale(0, 0 + var_02);
        return;
      }

      scripts\mp\utility::setrecoilscale(0, 0 + var_02);
      return;
    }

    scripts\mp\utility::setrecoilscale();
    return;
  }

  if(param_00 == "crouch") {
    var_03 = scripts\mp\utility::getweapongroup(var_01);
    if(var_03 == "weapon_lmg") {
      scripts\mp\utility::setrecoilscale(0, 0);
      return;
    }

    if(var_03 == "weapon_sniper") {
      if(issubstr(var_01, "barrelbored")) {
        scripts\mp\utility::setrecoilscale(0, 0 + var_02);
        return;
      }

      scripts\mp\utility::setrecoilscale(0, 0 + var_02);
      return;
    }

    scripts\mp\utility::setrecoilscale();
    return;
  }

  if(var_02 > 0) {
    scripts\mp\utility::setrecoilscale(0, var_02);
    return;
  }

  scripts\mp\utility::setrecoilscale();
}

semtexused(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.weapon_name)) {
    return;
  }

  param_00.originalowner = self;
  param_00 waittill("missile_stuck", var_01);
  param_00 thread scripts\mp\shellshock::grenade_earthquake();
  if(isplayer(var_01) || isagent(var_01)) {
    grenadestuckto(param_00, var_01);
  }

  param_00 explosivehandlemovers(undefined);
}

turret_monitoruse() {
  for(;;) {
    self waittill("trigger", var_00);
    thread turret_playerthread(var_00);
  }
}

turret_playerthread(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 notify("weapon_change", "none");
  self waittill("turret_deactivate");
  param_00 notify("weapon_change", param_00 getcurrentweapon());
}

spawnmine(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = (0, randomfloat(360), 0);
  }

  var_05 = level.weaponconfigs[param_02];
  var_06 = spawn("script_model", param_00);
  var_06.angles = param_04;
  var_06 setModel(var_05.model);
  var_06.triggerportableradarping = param_01;
  var_06 setotherent(param_01);
  var_06.weapon_name = param_02;
  var_06.config = var_05;
  var_06.killcamoffset = (0, 0, 4);
  var_06.killcament = spawn("script_model", var_06.origin + var_06.killcamoffset);
  var_06.killcament setscriptmoverkillcam("explosive");
  var_07 = scripts\mp\utility::getequipmenttype(param_02);
  if(!isDefined(var_07)) {
    var_07 = "lethal";
  }

  if(var_07 == "lethal") {
    param_01 onlethalequipmentplanted(var_06, param_03);
  } else if(var_07 == "tactical") {
    param_01 ontacticalequipmentplanted(var_06, param_03);
  } else {}

  if(isDefined(var_05.bombsquadmodel)) {
    var_06 thread createbombsquadmodel(var_05.bombsquadmodel, "tag_origin", param_01);
  }

  if(isDefined(var_05.mine_beacon)) {
    var_06 thread doblinkinglight("tag_fx", var_05.mine_beacon["friendly"], var_05.mine_beacon["enemy"]);
  }

  var_06 thread func_F692(param_01.pers["team"], var_05.headiconoffset);
  var_08 = undefined;
  if(self != level) {
    var_08 = self getlinkedparent();
  }

  var_06 explosivehandlemovers(var_08);
  var_06 thread mineproximitytrigger(var_08);
  var_06 thread scripts\mp\shellshock::grenade_earthquake();
  var_06 thread mineselfdestruct();
  var_06 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", param_01, 1);
  var_06 thread mineexplodeonnotify();
  var_06 thread func_66B4(1);
  var_06 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread outlineequipmentforowner(var_06, param_01);
  level thread monitordisownedequipment(param_01, var_06);
  return var_06;
}

func_108E7(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = (0, randomfloat(360), 0);
  }

  var_05 = level.weaponconfigs[param_02];
  var_06 = spawn("script_model", param_00);
  var_06.angles = param_04;
  var_06 setModel(var_05.model);
  var_06.triggerportableradarping = param_01;
  var_06 setotherent(param_01);
  var_06.weapon_name = param_02;
  var_06.config = var_05;
  param_01 ontacticalequipmentplanted(var_06, param_03);
  var_06 thread createbombsquadmodel(var_05.bombsquadmodel, "tag_origin", param_01);
  var_06 thread func_F692(param_01.pers["team"], var_05.headiconoffset);
  var_07 = undefined;
  if(self != level) {
    var_07 = self getlinkedparent();
  }

  var_06 explosivehandlemovers(var_07, 1);
  var_06 thread mineproximitytrigger(var_07);
  var_06 thread scripts\mp\shellshock::grenade_earthquake();
  var_06 thread func_BBC4();
  var_06 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", param_01);
  var_06 thread func_B77D();
  level thread monitordisownedequipment(param_01, var_06);
  return var_06;
}

func_108E5(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_04)) {
    param_04 = (0, randomfloat(360), 0);
  }

  var_07 = level.weaponconfigs[param_02];
  var_08 = spawn("script_model", param_00);
  var_08.angles = param_04;
  var_08 setModel(var_07.model);
  var_08.triggerportableradarping = param_01;
  var_08 setotherent(param_01);
  var_08.weapon_name = param_02;
  var_08.config = var_07;
  if(isDefined(param_05)) {
    var_08.var_AC75 = param_05;
  } else {
    var_08.var_AC75 = 45;
  }

  param_01 ontacticalequipmentplanted(var_08, param_03);
  var_08 thread createbombsquadmodel(var_07.bombsquadmodel, "tag_origin", param_01);
  var_08 thread func_F692(param_01.pers["team"], var_07.headiconoffset);
  var_09 = undefined;
  if(self != level) {
    var_09 = self getlinkedparent();
  }

  var_08 explosivehandlemovers(var_09, 1);
  var_08 thread mineproximitytrigger(var_09);
  var_08 thread scripts\mp\shellshock::grenade_earthquake();
  var_08 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", param_01);
  var_08 thread func_B8F6();
  level thread monitordisownedequipment(param_01, var_08);
  var_08 thread func_D501();
  var_08 thread func_139F0();
  if(isDefined(param_06) && param_06) {
    var_08 makeexplosiveusable();
    var_08 thread minedamagemonitor();
  }

  return var_08;
}

func_139F5() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self waittill("missile_stuck");
  thread func_E845(var_00, self.origin);
}

func_E845(param_00, param_01) {
  var_02 = spawn("trigger_radius", param_01, 0, 128, 135);
  var_02.triggerportableradarping = param_00;
  var_03 = 128;
  var_04 = spawnfx(scripts\engine\utility::getfx("distortion_field_cloud"), param_01);
  triggerfx(var_04);
  var_05 = 8;
  foreach(var_07 in level.players) {
    var_07.var_9E44 = 0;
    var_07 thread func_20C2(var_02);
  }

  while(var_05 > 0) {
    foreach(var_07 in level.players) {
      if(var_07 istouching(var_02) && !var_07.var_9E44) {
        var_07 thread func_20C2(var_02);
      }
    }

    wait(0.2);
    var_05 = var_05 - 0.2;
  }

  foreach(var_07 in level.players) {
    var_07 notify("distortion_field_ended");
    foreach(var_0E in level.players) {
      var_07 showtoplayer(var_0E);
    }
  }

  var_04 delete();
  self delete();
  wait(2);
  var_02 delete();
}

func_20C2(param_00) {
  self endon("death");
  self endon("disconnect");
  while(isDefined(param_00) && self istouching(param_00) && !scripts\mp\killstreaks\_emp_common::isemped()) {
    self setblurforplayer(4, 1);
    self.var_9E44 = 1;
    thread func_B9CF();
    foreach(var_02 in level.players) {
      self hidefromplayer(var_02);
    }

    scripts\engine\utility::waittill_any_timeout_1(1.4, "emp_damage");
    foreach(var_02 in level.players) {
      self showtoplayer(var_02);
    }

    wait(0.1);
  }

  self setblurforplayer(0, 0.25);
  self.var_9E44 = 0;
  foreach(var_02 in level.players) {
    var_02 showtoplayer(var_02);
  }
}

func_B9CF() {
  self endon("distortion_field_ended");
  var_00 = 0;
  while(!var_00) {
    var_00 = scripts\mp\killstreaks\_emp_common::isemped();
    scripts\engine\utility::waitframe();
  }

  self notify("emp_damage");
}

func_10910(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = (0, randomfloat(360), 0);
  }

  var_05 = level.weaponconfigs[param_02];
  var_06 = spawn("script_model", param_00);
  var_06.angles = param_04;
  var_06 setModel(var_05.model);
  var_06.triggerportableradarping = param_01;
  var_06 setotherent(param_01);
  var_06.weapon_name = param_02;
  var_06.config = var_05;
  param_01 ontacticalequipmentplanted(var_06, param_03);
  var_06 thread createbombsquadmodel(var_05.bombsquadmodel, "tag_origin", param_01);
  var_06 thread func_F692(param_01.pers["team"], var_05.headiconoffset);
  var_06 thread func_10413(param_01, var_06, var_06.weapon_name);
  var_06.var_AC75 = 15;
  var_06 thread func_139F0(0);
  param_01 notify("sonic_sensor_used");
  var_07 = undefined;
  if(self != level) {
    var_07 = self getlinkedparent();
  }

  var_06 explosivehandlemovers(var_07, 1);
  var_06 thread scripts\mp\shellshock::grenade_earthquake();
  var_06 thread func_BBC4();
  var_06 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", param_01);
  var_06 thread func_B77D();
  var_06 thread func_10412();
  level thread monitordisownedequipment(param_01, var_06);
  return var_06;
}

func_10412() {
  scripts\engine\utility::waittill_any_3("death", "mine_destroyed");
  self.triggerportableradarping notify("sonic_sensor_update");
  foreach(var_01 in self.triggerportableradarping.plantedtacticalequip) {
    if(isDefined(var_01) && var_01.weapon_name == "sonic_sensor_mp") {
      var_01 deleteexplosive();
      scripts\engine\utility::array_remove(self.triggerportableradarping.plantedtacticalequip, var_01);
    }
  }
}

func_139F0(param_00) {
  self endon("death");
  while(self.var_AC75 > 0) {
    self.var_AC75--;
    wait(1);
  }

  self playSound(self.config.onexplodesfx);
  var_01 = self gettagorigin("tag_origin");
  playFX(self.config.onexplodevfx, var_01);
  if(isDefined(self.config.var_127BF)) {
    self.config.var_127BF.var_DBD8 = undefined;
    self.config.var_127BF = undefined;
  }

  if(!isDefined(param_00) || param_00) {
    self getplayermodelname();
  }

  deleteexplosive();
}

func_66AA(param_00, param_01) {
  if(isDefined(param_00)) {
    switch (param_00) {
      case "cryo_mine_mp":
        return 1;
    }

    if(param_01 == "MOD_IMPACT") {
      switch (param_00) {
        case "trip_mine_mp":
        case "splash_grenade_mp":
        case "c4_mp":
          return 1;
      }
    } else {
      switch (param_00) {
        case "gltacburst_regen":
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
      if(isDefined(var_01) && !scripts\mp\utility::istrue(var_01.exploding) && !isplantedequipment(var_01)) {
        var_01 delete();
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_04 in level.missiles) {
      if(isDefined(var_04) && !scripts\mp\utility::istrue(var_04.exploding) && !isplantedequipment(var_04)) {
        var_04 delete();
      }
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
  var_01 = self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  var_02 = scripts\engine\utility::ter_op(var_01, 2, 1);
  var_03 = scripts\engine\utility::ter_op(var_01, "hitequip", "");
  for(;;) {
    self waittill("damage", var_04, var_00, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
    var_0C = scripts\mp\utility::func_13CA1(var_0C, var_10);
    if(!isplayer(var_00) && !isagent(var_00)) {
      continue;
    }

    if(isDefined(var_0C) && isendstr(var_0C, "betty_mp")) {
      continue;
    }

    if(!friendlyfirecheck(self.triggerportableradarping, var_00)) {
      continue;
    }

    if(isballweapon(var_0C)) {
      continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_00)) {
      continue;
    }

    if(func_66AA(var_0C, var_07)) {
      continue;
    }

    var_11 = scripts\engine\utility::ter_op(scripts\mp\utility::isfmjdamage(var_0C, var_07) || var_04 >= 80, 2, 1);
    var_02 = var_02 - var_11;
    scripts\mp\powers::equipmenthit(self.triggerportableradarping, var_00, var_0C, var_07);
    if(var_02 <= 0) {
      break;
    } else {
      var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_03);
    }
  }

  self notify("mine_destroyed");
  if(isDefined(var_07) && issubstr(var_07, "MOD_GRENADE") || issubstr(var_07, "MOD_EXPLOSIVE")) {
    self.waschained = 1;
  }

  if(isDefined(var_0B) && var_0B &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_0B) && var_0B &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;
  if(isDefined(var_00)) {
    self.damagedby = var_00;
  }

  if(isDefined(self.killcament)) {
    self.killcament.damagedby = var_00;
  }

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_03);
    if(var_00 != self.triggerportableradarping && var_00.team != self.triggerportableradarping.team) {
      var_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    }
  }

  if(level.teambased) {
    if(isDefined(var_00) && isDefined(var_00.pers["team"]) && isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.pers["team"])) {
      if(var_00.pers["team"] != self.triggerportableradarping.pers["team"]) {
        var_00 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.triggerportableradarping) && isDefined(var_00) && var_00 != self.triggerportableradarping) {
    var_00 notify("destroyed_equipment");
  }

  scripts\mp\missions::minedestroyed(self, var_00, var_07);
  self notify("detonateExplosive", var_00);
}

mineproximitytrigger(param_00, param_01) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_02 = self.config;
  wait(var_02.armtime);
  if(isDefined(var_02.mine_beacon)) {
    thread doblinkinglight("tag_fx", var_02.mine_beacon["friendly"], var_02.mine_beacon["enemy"]);
  }

  var_03 = scripts\engine\utility::ter_op(isDefined(var_02.minedetectionradius), var_02.minedetectionradius, level.minedetectionradius);
  var_04 = scripts\engine\utility::ter_op(isDefined(var_02.minedetectionheight), var_02.minedetectionheight, level.minedetectionheight);
  var_05 = spawn("trigger_radius", self.origin, 0, var_03, var_04);
  var_05.triggerportableradarping = self;
  thread minedeletetrigger(var_05);
  if(isDefined(param_00)) {
    var_05 enablelinkto();
    var_05 linkto(param_00);
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
      if(isDefined(self.triggerportableradarping)) {
        if(var_06 == self.triggerportableradarping) {
          continue;
        }

        if(isDefined(var_06.triggerportableradarping) && var_06.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.triggerportableradarping, var_06, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_06 getentityvelocity()) < 10) {
      continue;
    }

    if(self.weapon_name == "mobile_radar_mp" && !func_B8F7(var_06)) {
      continue;
    }

    if((isDefined(param_01) && param_01) || var_06 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self.config.var_127BF = var_06;
  if(isDefined(self.config.ontriggeredsfx)) {
    self playSound(self.config.ontriggeredsfx);
  }

  explosivetrigger(var_06, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(param_00) {
  scripts\engine\utility::waittill_any_3("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_BBC4() {
  self endon("mine_triggered");
  self endon("death");
  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    equipmentempstunvfx();
    stopblinkinglight();
    if(isDefined(self.damagearea)) {
      self.damagearea delete();
    }

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
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  var_00 = self.origin + (0, 0, 64);
  self moveto(var_00, 0.7, 0, 0.65);
  self.killcament moveto(var_00 + self.killcamoffset, 0.7, 0, 0.65);
  self rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  thread playspinnerfx();
  wait(0.65);
  self notify("detonateExplosive");
}

mineexplodeonnotify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_00);
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(!isDefined(var_00)) {
    var_00 = self.triggerportableradarping;
  }

  var_01 = self.config;
  var_02 = var_01.vfxtag;
  if(!isDefined(var_02)) {
    var_02 = "tag_fx";
  }

  var_03 = self gettagorigin(var_02);
  if(!isDefined(var_03)) {
    var_03 = self gettagorigin("tag_origin");
  }

  self notify("explode", var_03);
  wait(0.05);
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  self hide();
  if(isDefined(var_01.onexplodefunc)) {
    self thread[[var_01.onexplodefunc]]();
  }

  if(isDefined(var_01.onexplodesfx)) {
    self playSound(var_01.onexplodesfx);
  }

  var_04 = scripts\engine\utility::ter_op(isDefined(var_01.onexplodevfx), var_01.onexplodevfx, level.mine_explode);
  playFX(var_04, var_03);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_01.minedamagemin), var_01.minedamagemin, level.minedamagemin);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_01.minedamagemax), var_01.minedamagemax, level.minedamagemax);
  var_07 = scripts\engine\utility::ter_op(isDefined(var_01.minedamageradius), var_01.minedamageradius, level.minedamageradius);
  if(var_06 > 0) {
    self radiusdamage(self.origin, var_07, var_06, var_05, var_00, "MOD_EXPLOSIVE", self.weapon_name);
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
  }

  wait(0.2);
  deleteexplosive();
}

minesensorbounce() {
  self playSound(self.config.onlaunchsfx);
  playFX(self.config.launchvfx, self.origin);
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self hidepart("tag_sensor");
  stopblinkinglight();
  var_00 = spawn("script_model", self.origin);
  var_00.angles = self.angles;
  var_00 setModel(self.config.model);
  var_00 hidepart("tag_base");
  var_00.config = self.config;
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
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(!isDefined(var_00)) {
    var_00 = self.triggerportableradarping;
  }

  self playSound(self.config.onexplodesfx);
  var_01 = undefined;
  if(isDefined(self.sensor)) {
    var_01 = self.sensor gettagorigin("tag_sensor");
  } else {
    var_01 = self gettagorigin("tag_origin");
  }

  playFX(self.config.onexplodevfx, var_01);
  scripts\engine\utility::waitframe();
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(isDefined(self.sensor)) {
    self.sensor delete();
  } else {
    self hidepart("tag_sensor");
  }

  self.triggerportableradarping thread scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  var_02 = [];
  foreach(var_04 in level.characters) {
    if(var_04.team == self.triggerportableradarping.team) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_04)) {
      continue;
    }

    if(var_04 scripts\mp\utility::_hasperk("specialty_heartbreaker")) {
      continue;
    }

    if(distance2d(self.origin, var_04.origin) < 300) {
      var_02[var_02.size] = var_04;
    }
  }

  foreach(var_07 in var_02) {
    thread func_B37F(var_07, self.triggerportableradarping);
    level thread func_F236(var_07, self.triggerportableradarping);
  }

  if(var_02.size > 0) {
    self.triggerportableradarping scripts\mp\missions::processchallenge("ch_motiondetected", var_02.size);
    self.triggerportableradarping thread scripts\mp\gamelogic::threadedsetweaponstatbyname("motion_sensor", 1, "hits");
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
  }

  wait(0.2);
  deleteexplosive();
}

func_B37F(param_00, param_01) {
  if(param_00 == param_01) {
    return;
  }

  param_00 endon("disconnect");
  var_02 = undefined;
  if(level.teambased) {
    var_02 = scripts\mp\utility::outlineenableforteam(param_00, "orange", param_01.team, 0, 0, "equipment");
  } else {
    var_02 = scripts\mp\utility::outlineenableforplayer(param_00, "orange", param_01, 0, 0, "equipment");
  }

  param_00 thread scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  scripts\mp\gamescore::func_11ACE(param_01, param_00, "motion_sensor_mp");
  param_00 scripts\engine\utility::waittill_any_timeout_1(self.config.var_B371, "death");
  scripts\mp\gamescore::untrackdebuffassist(param_01, param_00, "motion_sensor_mp");
  scripts\mp\utility::outlinedisable(var_02, param_00);
}

func_F236(param_00, param_01) {
  if(param_00 == param_01) {
    return;
  }

  if(isai(param_00)) {
    return;
  }

  var_02 = "coup_sunblind";
  param_00 setclientomnvar("ui_hud_shake", 1);
  param_00 visionsetnakedforplayer(var_02, 0.05);
  wait(0.05);
  param_00 visionsetnakedforplayer(var_02, 0);
  param_00 visionsetnakedforplayer("", 0.5);
}

func_B8F5() {
  self playSound(self.config.onlaunchsfx);
  playFX(self.config.launchvfx, self.origin);
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

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
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(!isDefined(var_00)) {
    var_00 = self.triggerportableradarping;
  }

  self playSound(self.config.onexplodesfx);
  var_01 = self gettagorigin("tag_origin");
  playFX(self.config.onexplodevfx, var_01);
  scripts\engine\utility::waitframe();
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(isDefined(self.config.var_127BF)) {
    var_02 = self.config.var_127BF;
    var_02.var_DBD8 = 1;
    var_02 func_10DC5(self);
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
    self.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  }

  wait(0.2);
  deleteexplosive();
}

func_10DC5(param_00) {
  var_01 = self gettagorigin("tag_shield_back");
  var_02 = spawn("script_model", var_01);
  var_02 setModel("weapon_mobile_radar_back");
  var_02.var_AC75 = param_00.var_AC75;
  var_02.triggerportableradarping = param_00.triggerportableradarping;
  var_02.config = param_00.config;
  var_02 linkto(self, "tag_shield_back", (0, 0, 0), (0, 90, 90));
  var_02 thread func_D501(self);
  var_02 thread createbombsquadmodel(param_00.config.bombsquadmodel, "tag_origin", param_00.triggerportableradarping);
  var_02 thread minedamagemonitor();
  var_02 thread func_13B1A(self, param_00);
  var_02 thread func_13B1B(self, param_00);
  var_02 thread func_139F0();
}

func_D501(param_00) {
  self endon("death");
  var_01 = self gettagorigin("tag_fx");
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin");
  var_02 linkto(self, "tag_fx", (0, 0, 0), (90, 0, -90));
  var_02 thread func_13A0F(self);
  for(;;) {
    wait(2);
    playFXOnTag(self.config.var_C4C5, var_02, "tag_origin");
    if(isDefined(param_00)) {
      param_00 scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
      param_00 playsoundonmovingent("ball_drone_3Dping");
    } else {
      self playSound("ball_drone_3Dping");
    }

    foreach(var_04 in level.players) {
      if(var_04.team != self.triggerportableradarping.team) {
        continue;
      }

      triggerportableradarping(self.origin, var_04);
    }
  }
}

func_13A0F(param_00) {
  self endon("death");
  param_00 waittill("death");
  self delete();
}

func_13B1A(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill("detonateExplosive", var_02);
    param_00.var_DBD8 = undefined;
    self.config.var_127BF = undefined;
    self playSound(self.config.onexplodesfx);
    var_03 = self gettagorigin("tag_origin");
    playFX(self.config.onexplodevfx, var_03);
    self delete();
  }
}

func_13B1B(param_00, param_01) {
  self endon("death");
  var_02 = param_01.triggerportableradarping;
  var_03 = param_01.angles;
  var_04 = param_01.var_AC75;
  param_00 waittill("death");
  param_00.var_DBD8 = undefined;
  self.config.var_127BF = undefined;
  func_108E5(param_00.origin, var_02, "mobile_radar_mp", var_03, var_04, 1);
  self delete();
}

func_B8F7(param_00) {
  var_01 = 1;
  if(isDefined(param_00.var_DBD8)) {
    var_01 = 0;
  }

  if(!isplayer(param_00)) {
    var_01 = 0;
  }

  return var_01;
}

playspinnerfx() {
  if(isDefined(self.config.mine_spin)) {
    self endon("death");
    var_00 = gettime() + 1000;
    while(gettime() < var_00) {
      wait(0.05);
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin1");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin3");
      wait(0.05);
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin2");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin4");
    }
  }
}

minedamagedebug(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06[0] = (1, 0, 0);
  var_06[1] = (0, 1, 0);
  if(param_01[2] < param_05) {
    var_07 = 0;
  } else {
    var_07 = 1;
  }

  var_08 = (param_00[0], param_00[1], param_05);
  var_09 = (param_01[0], param_01[1], param_05);
  thread debugcircle(var_08, level.minedamageradius, var_06[var_07], 32);
  var_0A = distancesquared(param_00, param_01);
  if(var_0A > param_02) {
    var_07 = 0;
  } else {
    var_07 = 1;
  }

  thread debugline(var_08, var_09, var_06[var_07]);
}

minedamageheightpassed(param_00, param_01) {
  if(isplayer(param_01) && isalive(param_01) && param_01.sessionstate == "playing") {
    var_02 = param_01 scripts\mp\utility::getstancecenter();
  } else if(var_02.classname == "misc_turret") {
    var_02 = var_02.origin + (0, 0, 32);
  } else {
    var_02 = var_02.origin;
  }

  var_03 = 0;
  var_04 = param_00.origin[2] + var_03 - level.minedamagehalfheight;
  if(var_02[2] < var_04) {
    return 0;
  }

  return 1;
}

mineused(param_00, param_01, param_02) {
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  param_00 thread minethrown(self, param_00.weapon_name, param_00.power, param_00.var_1088C, param_02);
}

minethrown(param_00, param_01, param_02, param_03, param_04) {
  self.triggerportableradarping = param_00;
  self waittill("missile_stuck", var_05);
  if(param_01 != "trip_mine_mp") {
    if(isDefined(var_05) && isDefined(var_05.triggerportableradarping)) {
      if(isDefined(param_04)) {
        self.triggerportableradarping[[param_04]](self);
      }

      self delete();
      return;
    }
  }

  self.triggerportableradarping notify("bouncing_betty_update", 0);
  if(!isDefined(param_00)) {
    return;
  }

  if(param_01 != "sonic_sensor_mp") {
    var_06 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  } else {
    var_06 = scripts\common\trace::ray_trace(self.origin, self.origin + anglestoup(self.angles * 2));
  }

  var_07 = var_06["position"];
  if(var_06["fraction"] == 1 && param_01 != "sonic_sensor_mp") {
    var_07 = getgroundposition(self.origin, 12, 0, 32);
    var_06["normal"] = var_06["normal"] * -1;
  }

  if(param_01 != "sonic_sensor_mp") {
    var_08 = vectornormalize(var_06["normal"]);
    var_09 = vectortoangles(var_08);
    var_09 = var_09 + (90, 0, 0);
  } else {
    var_09 = self.angles;
  }

  var_0A = self[[param_03]](var_07, param_00, param_01, param_02, var_09);
  var_0A makeexplosiveusable();
  var_0A thread minedamagemonitor();
  self delete();
}

func_51CE() {
  if(isDefined(self.plantedlethalequip)) {
    foreach(var_01 in self.plantedlethalequip) {
      if(isDefined(var_01)) {
        var_01 deleteexplosive();
      }
    }
  }

  if(isDefined(self.plantedtacticalequip)) {
    foreach(var_01 in self.plantedtacticalequip) {
      if(isDefined(var_01)) {
        var_01 deleteexplosive();
      }
    }
  }

  self.plantedlethalequip = [];
  self.plantedtacticalequip = [];
}

deletedisparateplacedequipment() {
  var_00 = scripts\mp\powers::getcurrentequipment("primary");
  foreach(var_02 in self.plantedlethalequip) {
    if(isDefined(var_02)) {
      if(!isDefined(var_02.var_D77A) || !isDefined(var_00) || var_02.var_D77A != var_00) {
        var_02 deleteexplosive();
      }
    }
  }

  var_04 = scripts\mp\powers::getcurrentequipment("secondary");
  foreach(var_02 in self.plantedtacticalequip) {
    if(isDefined(var_02)) {
      if(!isDefined(var_02.var_D77A) || !isDefined(var_04) || var_02.var_D77A != var_04) {
        var_02 deleteexplosive();
      }
    }
  }
}

doblinkinglight(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = scripts\engine\utility::getfx("weap_blink_friend");
  }

  if(!isDefined(param_02)) {
    param_02 = scripts\engine\utility::getfx("weap_blink_enemy");
  }

  self.blinkinglightfx["friendly"] = param_01;
  self.blinkinglightfx["enemy"] = param_02;
  self.blinkinglighttag = param_00;
  thread updateblinkinglight(param_01, param_02, param_00);
  self waittill("death");
  stopblinkinglight();
}

updateblinkinglight(param_00, param_01, param_02) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  var_03 = ::checkteam;
  if(!level.teambased) {
    var_03 = ::checkplayer;
  }

  var_04 = randomfloatrange(0.05, 0.25);
  wait(var_04);
  childthread onjointeamblinkinglight(param_00, param_01, param_02, var_03);
  foreach(var_06 in level.players) {
    if(isDefined(var_06)) {
      if(self.triggerportableradarping[[var_03]](var_06)) {
        playfxontagforclients(param_00, self, param_02, var_06);
      } else {
        playfxontagforclients(param_01, self, param_02, var_06);
      }

      wait(0.05);
    }
  }
}

onjointeamblinkinglight(param_00, param_01, param_02, param_03) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");
  for(;;) {
    level waittill("joined_team", var_04);
    if(self.triggerportableradarping[[param_03]](var_04)) {
      playfxontagforclients(param_00, self, param_02, var_04);
      continue;
    }

    playfxontagforclients(param_01, self, param_02, var_04);
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

checkteam(param_00) {
  return self.team == param_00.team;
}

checkplayer(param_00) {
  return self == param_00;
}

equipmentdeathvfx(param_00) {
  playFX(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  if(!isDefined(param_00) || param_00 == 0) {
    self playSound("sentry_explode");
  }
}

equipmentdeletevfx(param_00, param_01) {
  if(isDefined(param_00)) {
    if(isDefined(param_01)) {
      var_02 = anglesToForward(param_01);
      var_03 = anglestoup(param_01);
      playFX(scripts\engine\utility::getfx("equipment_explode"), param_00, var_02, var_03);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), param_00, var_02, var_03);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), param_00);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), param_00);
    }

    playsoundatpos(param_00, "mp_killstreak_disappear");
    return;
  }

  if(isDefined(self)) {
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
    if(var_02 != var_03) {
      level.attachmentmap_uniquetobase[var_02] = var_03;
    }

    var_04 = tablelookup("mp\attachmenttable.csv", 4, var_02, 13);
    if(var_04 != "") {
      level.attachmentmap_uniquetoextra[var_02] = var_04;
      level.attachmentextralist[var_04] = 1;
    }
  }

  var_06 = [];
  var_07 = 1;
  var_08 = tablelookupbyrow("mp\attachmentmap.csv", var_07, 0);
  while(var_08 != "") {
    var_06[var_06.size] = var_08;
    var_07++;
    var_08 = tablelookupbyrow("mp\attachmentmap.csv", var_07, 0);
  }

  var_09 = [];
  var_0A = 1;
  var_0B = tablelookupbyrow("mp\attachmentmap.csv", 0, var_0A);
  while(var_0B != "") {
    var_09[var_0B] = var_0A;
    var_0A++;
    var_0B = tablelookupbyrow("mp\attachmentmap.csv", 0, var_0A);
  }

  level.attachmentmap_basetounique = [];
  foreach(var_08 in var_06) {
    foreach(var_10, var_0E in var_09) {
      var_0F = tablelookup("mp\attachmentmap.csv", 0, var_08, var_0E);
      if(var_0F == "") {
        continue;
      }

      if(!isDefined(level.attachmentmap_basetounique[var_08])) {
        level.attachmentmap_basetounique[var_08] = [];
      }

      level.attachmentmap_basetounique[var_08][var_10] = var_0F;
    }
  }

  level.attachmentmap_attachtoperk = [];
  foreach(var_13 in var_00) {
    var_14 = tablelookup("mp\attachmenttable.csv", 4, var_13, 12);
    if(var_14 == "") {
      continue;
    }

    level.attachmentmap_attachtoperk[var_13] = var_14;
  }

  level.attachmentmap_conflicts = [];
  var_16 = 1;
  var_17 = tablelookupbyrow("mp\attachmentcombos.csv", var_16, 0);
  while(var_17 != "") {
    var_18 = 1;
    var_19 = tablelookupbyrow("mp\attachmentcombos.csv", 0, var_18);
    while(var_19 != "") {
      if(var_17 != var_19) {
        var_1A = tablelookupbyrow("mp\attachmentcombos.csv", var_16, var_18);
        var_1B = scripts\engine\utility::alphabetize([var_17, var_19]);
        var_1C = var_1B[0] + "_" + var_1B[1];
        if(var_1A == "no" && !isDefined(level.attachmentmap_conflicts[var_1C])) {
          level.attachmentmap_conflicts[var_1C] = 1;
        }
      }

      var_18++;
      var_19 = tablelookupbyrow("mp\attachmentcombos.csv", 0, var_18);
    }

    var_16++;
    var_17 = tablelookupbyrow("mp\attachmentcombos.csv", var_16, 0);
  }
}

getattachmentlistuniquenames() {
  var_00 = [];
  var_01 = 0;
  var_02 = tablelookup("mp\attachmentTable.csv", 0, var_01, 4);
  while(var_02 != "") {
    var_00[var_02] = var_02;
    var_01++;
    var_02 = tablelookup("mp\attachmentTable.csv", 0, var_01, 4);
  }

  return var_00;
}

func_3222() {
  level.weaponmapdata = [];
  for(var_00 = 1; tablelookup("mp\statstable.csv", 0, var_00, 0) != ""; var_00++) {
    var_01 = tablelookup("mp\statstable.csv", 0, var_00, 4);
    if(var_01 != "") {
      level.weaponmapdata[var_01] = spawnStruct();
      var_02 = tablelookup("mp\statstable.csv", 0, var_00, 0);
      if(var_02 != "") {
        level.weaponmapdata[var_01].number = var_02;
      }

      var_03 = tablelookup("mp\statstable.csv", 0, var_00, 1);
      if(var_03 != "") {
        level.weaponmapdata[var_01].group = var_03;
      }

      var_04 = tablelookup("mp\statstable.csv", 0, var_00, 5);
      if(var_04 != "") {
        level.weaponmapdata[var_01].var_23B0 = var_04;
      }

      var_05 = tablelookup("mp\statstable.csv", 0, var_00, 44);
      if(var_05 != "") {
        level.weaponmapdata[var_01].perk = var_05;
      }

      var_06 = tablelookup("mp\statstable.csv", 0, var_00, 9);
      if(var_06 != "") {
        level.weaponmapdata[var_01].attachdefaults = strtok(var_06, " ");
      }

      level.weaponmapdata[var_01].selectableattachmentlist = [];
      level.weaponmapdata[var_01].selectableattachmentmap = [];
      for(var_07 = 0; var_07 < 20; var_07++) {
        var_08 = tablelookup("mp\statstable.csv", 0, var_00, 10 + var_07);
        if(isDefined(var_08) && var_08 != "") {
          var_09 = level.weaponmapdata[var_01].selectableattachmentlist.size;
          level.weaponmapdata[var_01].selectableattachmentlist[var_09] = var_08;
          level.weaponmapdata[var_01].selectableattachmentmap[var_08] = 1;
        }
      }

      if(level.tactical) {
        var_0A = tablelookup("mp\statstable.csv", 0, var_00, 50);
      } else {
        var_0A = tablelookup("mp\statstable.csv", 0, var_01, 8);
      }

      if(var_0A != "") {
        var_0A = float(var_0A);
        level.weaponmapdata[var_01].getclosestpointonnavmesh3d = var_0A;
      }
    }
  }
}

func_464F() {
  level endon("game_ended");
  self endon("end_explode");
  self.triggerportableradarping endon("disconnect");
  self waittill("explode", var_00);
  func_464D(var_00);
}

func_464D(param_00) {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  var_01 = self.triggerportableradarping;
  var_02 = var_01 scripts\mp\utility::getotherteam(var_01.team);
  var_03 = undefined;
  var_04 = 0;
  if(level.teambased) {
    var_03 = scripts\mp\utility::getteamarray(var_02);
  } else {
    var_03 = level.characters;
  }

  var_05 = [];
  var_06 = getempdamageents(param_00, 256, 0, undefined);
  if(var_06.size >= 1) {
    foreach(var_08 in var_06) {
      if(isDefined(var_08.triggerportableradarping) && !friendlyfirecheck(self.triggerportableradarping, var_08.triggerportableradarping)) {
        continue;
      }

      var_08 notify("emp_damage", self.triggerportableradarping, 5);
      foreach(var_0A in var_03) {
        if(var_08 == var_0A || var_08 == self.triggerportableradarping) {
          var_08 thread func_464E();
          var_05[var_05.size] = var_08;
          break;
        }
      }
    }

    foreach(var_0E in var_05) {
      if(var_0E == self.triggerportableradarping) {
        var_04 = 1;
        break;
      }
    }

    if(!var_04) {
      var_0E = var_05[var_05.size - 1];
      if(isDefined(var_0E) && var_0E != var_01) {
        var_10 = "primary";
        var_11 = "none";
        var_12 = getarraykeys(var_01.powers);
        foreach(var_14 in var_12) {
          if(var_01.powers[var_14].slot == var_10) {
            var_11 = var_14;
          }
        }

        var_16 = var_0E.var_AE7B;
        if(isDefined(var_16) && var_16 != "none") {
          var_01 notify("corpse_steal");
          var_01 notify("start_copycat");
          var_01 scripts\mp\powers::removepower(var_11);
          var_01 scripts\mp\powers::givepower(var_16, var_10, 1);
          var_01 thread func_139D7(var_16, var_10);
          return;
        }

        return;
      }
    }
  }
}

func_139D7(param_00, param_01) {
  self endon("disconnect");
  self endon("death");
  self endon("corpse_steal");
  self waittill("copycat_reset");
  self notify("start_copycat");
  scripts\mp\powers::removepower(param_00);
  scripts\mp\powers::givepower(self.var_AE7B, param_01, 1);
  self setclientomnvar("ui_juggernaut", 0);
}

func_464E() {
  self endon("disconnect");
  self endon("death");
  var_00 = gettime() + 5000;
  scripts\mp\powers::power_modifycooldownrate(0);
  if(isDefined(self.var_38A1) && self.var_38A1) {
    scripts\mp\powers::func_12C9F();
  }

  thread scripts\mp\powers::func_D729();
  while(gettime() < var_00) {
    wait(0.1);
  }

  scripts\mp\powers::func_D74E();
  if(isDefined(self.var_38A1) && !self.var_38A1) {
    scripts\mp\powers::func_F6B1();
  }

  thread scripts\mp\powers::func_D72F();
}

grenadestuckto(param_00, param_01, param_02) {
  if(!isDefined(self)) {
    param_00.stuckenemyentity = param_01;
    param_01.var_1117F = param_00;
    return;
  }

  if(level.teambased && isDefined(param_01.team) && param_01.team == self.team) {
    param_00.isstuck = "friendly";
    return;
  }

  var_03 = undefined;
  if(glprox_trygetweaponname(param_00.weapon_name) == "stickglprox") {
    var_03 = "stickglprox_stuck";
  } else {
    switch (param_00.weapon_name) {
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
        break;
    }
  }

  param_00.isstuck = "enemy";
  param_00.stuckenemyentity = param_01;
  if(param_00.weapon_name == "split_grenade_mp") {
    param_01.var_1117F = undefined;
  } else {
    param_01.var_1117F = param_00;
    self notify("grenade_stuck_enemy");
  }

  if(!scripts\mp\utility::istrue(param_02)) {
    func_85DE(var_03, param_01);
    return;
  }
}

func_85DE(param_00, param_01) {
  if(isplayer(param_01) && isDefined(param_00)) {
    param_01 scripts\mp\hud_message::showsplash(param_00, undefined, self);
  }

  thread scripts\mp\awards::givemidmatchaward("explosive_stick");
}

func_66A5(param_00, param_01) {
  if(param_00 scripts\mp\powers::func_D734(param_01) > 0) {
    return 0;
  }

  var_02 = undefined;
  switch (param_01) {
    case "power_explodingDrone":
      var_02 = param_00.var_69D6;
      break;

    case "power_c4":
      var_02 = param_00.plantedlethalequip;
      break;

    case "power_transponder":
      var_02 = param_00.plantedtacticalequip;
      break;
  }

  if(!isDefined(var_02) || var_02.size == 0) {
    return 0;
  }

  return 1;
}

func_10884(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnmine(param_00, param_01, param_02, param_03, param_04);
  var_05.var_76CF = spawn("script_model", var_05.killcament.origin);
  var_05.var_76CF setscriptmoverkillcam("explosive");
  thread cleanupflashanim(var_05.var_76CF, var_05);
  return var_05;
}

cleanupflashanim(param_00, param_01) {
  param_01 waittill("death");
  wait(20);
  param_00 delete();
}

func_10832(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnmine(param_00, param_01, param_02, param_03, param_04);
  var_05.var_76CF = spawn("script_model", var_05.killcament.origin);
  var_05.var_76CF setscriptmoverkillcam("explosive");
  thread func_40E6(var_05.var_76CF, var_05);
  param_01 notify("powers_blackholeGrenade_used", 1);
  return var_05;
}

func_40E6(param_00, param_01) {
  param_01 waittill("death");
  wait(20);
  param_00 delete();
}

func_1082C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnmine(param_00, param_01, param_02, param_03, param_04);
  var_05.var_76CF = spawn("script_model", var_05.killcament.origin);
  var_05.var_76CF setscriptmoverkillcam("explosive");
  thread func_40E4(var_05.var_76CF, var_05);
  return var_05;
}

func_40E4(param_00, param_01) {
  param_01 waittill("death");
  wait(20);
  param_00 delete();
}

func_10843(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnmine(param_00, param_01, param_02, param_03, param_04);
  var_05.var_4ACD = spawn("script_model", var_05.killcament.origin);
  var_05.var_4ACD setscriptmoverkillcam("explosive");
  thread func_40F1(var_05.var_4ACD, var_05);
  param_01 notify("powers_cryoGrenade_used", 1);
  return var_05;
}

func_40F1(param_00, param_01) {
  param_01 waittill("death");
  wait(20);
  param_00 delete();
}

func_1090D(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnmine(param_00, param_01, param_02, param_03, param_04);
  var_05.var_76CF = spawn("script_model", var_05.killcament.origin);
  var_05.var_76CF setscriptmoverkillcam("explosive");
  thread func_4117(var_05.var_76CF, var_05);
  self notify("powers_shardBall_used", 1);
  return var_05;
}

func_4117(param_00, param_01) {
  param_01 waittill("death");
  wait(20);
  param_00 delete();
}

outlineequipmentforowner(param_00, param_01) {
  var_02 = scripts\mp\utility::outlineenableforplayer(param_00, "white", param_01, 0, 0, "equipment");
  param_00 waittill("death");
  scripts\mp\utility::outlinedisable(var_02, param_00);
}

outlinesuperequipment(param_00, param_01) {
  if(level.teambased) {
    thread outlinesuperequipmentforteam(param_00, param_01);
    return;
  }

  thread outlinesuperequipmentforplayer(param_00, param_01);
}

outlinesuperequipmentforteam(param_00, param_01) {
  var_02 = scripts\mp\utility::outlineenableforteam(param_00, "cyan", param_01.team, 0, 0, "killstreak");
  param_00 waittill("death");
  scripts\mp\utility::outlinedisable(var_02, param_00);
}

outlinesuperequipmentforplayer(param_00, param_01) {
  var_02 = scripts\mp\utility::outlineenableforplayer(param_00, "cyan", param_01, 0, 0, "killstreak");
  param_00 waittill("death");
  scripts\mp\utility::outlinedisable(var_02, param_00);
}

_meth_85BE() {
  if(!isDefined(self._meth_85BE) || self._meth_85BE == "none") {
    return 0;
  }

  return 1;
}

func_7EE4() {
  if(!isDefined(self._meth_85BE)) {
    return "none";
  }

  return self._meth_85BE;
}

func_13A93() {
  self notify("watchGrenadeHeldAtDeath");
  self endon("watchGrenadeHeldAtDeath");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    self._meth_85BE = scripts\mp\utility::func_7EE5();
    scripts\engine\utility::waitframe();
  }
}

trace_impale(param_00, param_01) {
  var_02 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_03 = scripts\common\trace::ray_trace_detail(param_00, param_01, level.players, var_02, undefined, 1);
  return var_03;
}

impale_endpoint(param_00, param_01) {
  var_02 = param_00 + param_01 * 4096;
  return var_02;
}

impale(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  param_01 endon("death");
  param_01 endon("disconnect");
  if(!isDefined(param_01.body)) {
    return;
  }

  var_09 = param_00 scripts\mp\utility::_hasperk("passive_power_melee");
  if(var_09) {
    param_06 = "torso";
  } else {
    playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), param_04);
  }

  var_0A = impale_endpoint(param_04, param_05);
  var_0B = trace_impale(param_04, var_0A);
  var_0A = var_0B["position"] - param_05 * 12;
  var_0C = length(var_0A - param_04);
  var_0D = var_0C / scripts\engine\utility::ter_op(var_09, 600, 1000);
  var_0D = max(var_0D, 0.05);
  if(var_0B["hittype"] != "hittype_world") {
    var_0D = 0;
  }

  var_0E = var_0D > 0.05;
  if(isDefined(param_01)) {
    param_01.body giverankxp();
  }

  wait(0.05);
  if(var_0E) {
    var_0F = param_05;
    var_10 = anglestoup(param_00.angles);
    var_11 = vectorcross(var_0F, var_10);
    var_12 = scripts\engine\utility::spawn_tag_origin(param_04, axistoangles(var_0F, var_11, var_10));
    var_12 moveto(var_0A, var_0D);
    var_13 = spawnragdollconstraint(param_01.body, param_06, param_07, param_08);
    var_13.origin = var_12.origin;
    var_13.angles = var_12.angles;
    var_13 linkto(var_12);
    if(var_0D > scripts\engine\utility::ter_op(var_09, 0.075, 1)) {
      thread impale_detachaftertime(var_13, scripts\engine\utility::ter_op(var_09, 0.075, 1));
    }

    thread impale_cleanup(param_01, var_12, var_0D + 0.25);
    if(!var_09) {
      var_12 thread impale_effects(var_0A, var_0D);
    }
  }
}

impale_detachaftertime(param_00, param_01) {
  wait(param_01);
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

impale_effects(param_00, param_01) {
  wait(clamp(param_01 - 0.05, 0.05, 20));
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), param_00);
}

impale_cleanup(param_00, param_01, param_02) {
  if(isDefined(param_00)) {
    param_00 scripts\engine\utility::waittill_any_timeout_1(param_02, "death", "disconnect");
  }

  param_01 delete();
}

codecallback_getprojectilespeedscale(param_00, param_01) {
  return [1, 1];
}

func_9F3C(param_00, param_01) {
  return isDefined(level.weaponmapdata[param_00].selectableattachmentmap[param_01]);
}

func_F7FC() {
  if(!isDefined(self.isstunned)) {
    self.isstunned = 1;
    return;
  }

  self.isstunned++;
}

func_F800() {
  self.isstunned--;
}

isstunned() {
  return isDefined(self.isstunned) && self.isstunned > 0;
}

func_F7EE() {
  if(!isDefined(self.isblinded)) {
    self.isblinded = 1;
    return;
  }

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

func_40EA(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(param_00);
  func_F800();
}

func_A008(param_00) {
  var_01 = getweaponbasename(param_00);
  switch (var_01) {
    case "iw7_sonic_mp":
      return 1;
  }

  return 0;
}

func_20E4() {
  self endon("death");
  self endon("disconnect");
  wait(0.1);
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
  level.var_ABBF = getdvarfloat("scr_lethalDelay", 0);
  if(level.var_ABBF == 0) {
    level.var_ABC2 = scripts\mp\utility::gettimepassed();
    level.var_ABC0 = level.var_ABC2;
    level notify("lethal_delay_end");
  }

  level.var_ABC2 = scripts\mp\utility::gettimepassed();
  level.var_ABC0 = level.var_ABC2 + level.var_ABBF * 1000;
  level notify("lethal_delay_start");
  while(scripts\mp\utility::gettimepassed() < level.var_ABC0) {
    scripts\engine\utility::waitframe();
  }

  level notify("lethal_delay_end");
}

func_13AB5(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  if(func_ABC1()) {
    return;
  }

  self notify("watchLethalDelayPlayer_" + param_02);
  self endon("watchLethalDelayPlayer_" + param_02);
  self endon("power_removed_" + param_01);
  param_00 scripts\mp\powers::func_D727(param_01);
  func_13AB4(param_00, param_02);
  param_00 scripts\mp\powers::func_D72D(param_01);
}

func_13AB4(param_00, param_01) {
  level endon("lethal_delay_end");
  if(!scripts\mp\utility::istrue(scripts\mp\utility::gameflag("prematch_done"))) {
    level waittill("lethal_delay_start");
  }

  var_02 = "+frag";
  if(param_01 != "primary") {
    var_02 = "+smoke";
  }

  if(!isbot(param_00)) {
    param_00 notifyonplayercommand("lethal_attempt_" + param_01, var_02);
  }

  for(;;) {
    self waittill("lethal_attempt_" + param_01);
    var_03 = level.var_ABC0 - scripts\mp\utility::gettimepassed() / 1000;
    var_03 = int(max(0, ceil(var_03)));
    param_00 scripts\mp\hud_message::showerrormessage("MP_LETHALS_UNAVAILABLE_FOR_N", var_03);
  }
}

cancellethaldelay() {
  level.var_ABBF = 0;
  level.var_ABC2 = scripts\mp\utility::gettimepassed();
  level.var_ABC0 = level.var_ABC2;
  level notify("lethal_delay_end");
}

func_ABC1(param_00) {
  if(isDefined(level.var_ABBF) && level.var_ABBF == 0) {
    return 1;
  }

  return isDefined(level.var_ABC0) && scripts\mp\utility::gettimepassed() > level.var_ABC0;
}

func_13AA9() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_switch_invalid", var_00);
    var_01 = self getcurrentweapon();
    var_02 = weaponinventorytype(var_01);
    if(var_02 == "item" || var_02 == "exclusive") {
      scripts\mp\utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }
}

func_13C98(param_00) {
  var_01 = scripts\mp\utility::getweaponrootname(param_00);
  var_02 = getweaponattachments(param_00);
  foreach(var_04 in var_02) {
    var_05 = func_248C(var_04);
    if(var_05 == "rail") {
      var_06 = scripts\mp\utility::attachmentmap_tobase(var_04);
      if(func_9F3C(var_01, var_06)) {
        return 1;
      }
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

watchgrenadeaxepickup(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(self.weapon_name) && isDefined(param_01)) {
    self.weapon_name = param_01;
  }

  self.inphase = 0;
  if(isDefined(param_00)) {
    self.inphase = param_00 isinphase();
  }

  self waittill("missile_stuck", var_02, var_03);
  if(isDefined(var_02) && isplayer(var_02) || isagent(var_02)) {
    var_04 = var_03 == "tag_flicker";
    var_05 = var_03 == "tag_top_flicker";
    var_06 = var_02 scripts\mp\utility::_hasperk("specialty_rearguard") && var_03 == "tag_origin";
    var_07 = isDefined(var_03) && var_04 || var_05 || var_06;
    var_08 = isDefined(var_03) && var_03 == "tag_weapon";
    if(var_07) {
      playFX(scripts\engine\utility::getfx("shield_metal_impact"), self.origin);
      if(isDefined(self.triggerportableradarping)) {
        var_09 = self.triggerportableradarping;
        relaunchaxe(self.weapon_name, var_09, 1);
        return;
      }
    } else if(!scripts\mp\utility::istrue(var_08) && isplayer(var_03) && !scripts\mp\utility::isreallyalive(var_03) && level.mapname == "mp_neon" || scripts\mp\utility::istrue(level.var_DC24)) {
      return;
    }
  }

  param_01 thread func_11825(param_01, self);
  var_0A = 45;
  thread watchaxetimeout(var_0A);
  thread watchgrenadedeath();
  thread watchaxeuse(param_01, self.weapon_name);
  thread watchaxeautopickup(param_01, self.weapon_name);
}

axedetachfromcorpse(param_00) {
  level endon("game_ended");
  var_01 = param_00 getlinkedchildren();
  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_04 = var_03.weapon_name;
    var_05 = var_03.triggerportableradarping;
    var_06 = var_03.origin;
    if(isDefined(var_04) && isaxeweapon(var_04)) {
      var_03 relaunchaxe(var_04, var_05, 1);
    }
  }
}

relaunchaxe(param_00, param_01, param_02) {
  self unlink();
  var_03 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_00);
  var_04 = getsubstr(param_00, var_03.size);
  var_05 = param_01 scripts\mp\utility::_launchgrenade("iw7_axe_mp_dummy" + var_04, self.origin, (0, 0, 0), 100, 1, self);
  var_05 setentityowner(param_01);
  var_05 thread watchgrenadeaxepickup(param_01, self.weapon_name);
  if(scripts\mp\utility::istrue(param_02)) {
    self.inphase = 0;
    self.var_FF03 = 0;
  }
}

watchaxetimeout(param_00) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  self delete();
}

watchaxeautopickup(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  var_02 = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  var_02 enablelinkto();
  var_02 linkto(self);
  self.knife_trigger = var_02;
  var_02 endon("death");
  for(;;) {
    var_02 waittill("trigger", param_00);
    if(!isplayer(param_00)) {
      continue;
    }

    if(param_00 playercanautopickupaxe(self)) {
      param_00 playerpickupaxe(param_01, 1);
      self delete();
      break;
    }
  }
}

watchaxeuse(param_00, param_01) {
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
  var_02 waittill("trigger", param_00);
  param_00 playerpickupaxe(param_01, 0);
  self delete();
}

watchallplayerphasestates(param_00) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    foreach(var_02 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_02)) {
        continue;
      }

      if(!axeinsamephaseplayerstate(self, var_02)) {
        param_00 disableplayeruse(var_02);
        continue;
      }

      param_00 enableplayeruse(var_02);
    }

    scripts\engine\utility::waitframe();
  }
}

axeinsamephaseplayerstate(param_00, param_01) {
  var_02 = 1;
  if(scripts\mp\utility::istrue(param_00.inphase) && !param_01 isinphase()) {
    var_02 = 0;
  } else if(!scripts\mp\utility::istrue(param_00.inphase) && param_01 isinphase()) {
    var_02 = 0;
  }

  return var_02;
}

playercanautopickupaxe(param_00) {
  if(isDefined(param_00.triggerportableradarping) && self != param_00.triggerportableradarping) {
    return 0;
  }

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

    if(!issubstr(var_05, "alt_")) {
      var_03++;
    }
  }

  if(var_03 < 2) {
    var_02 = 1;
  }

  if(scripts\mp\utility::istrue(var_02)) {
    if(!axeinsamephaseplayerstate(param_00, self)) {
      var_02 = 0;
    }
  }

  return var_02;
}

playerpickupaxe(param_00, param_01) {
  var_02 = scripts\mp\utility::func_E0CF(param_00);
  var_03 = self getcurrentweapon();
  var_04 = self getweaponslistprimaries();
  if(self hasweapon(param_00)) {
    var_05 = self getweaponammoclip(param_00);
    if(!param_01 && var_05 > 0) {
      self dropitem(param_00);
      scripts\mp\utility::_giveweapon(var_02);
    } else if(!issubstr(var_03, param_00)) {
      scripts\mp\utility::_takeweapon(param_00);
      scripts\mp\utility::_giveweapon(var_02);
    }

    var_06 = self getweaponammoclip(var_03) == 0 && isaxeweapon(var_03);
    var_07 = issubstr(var_03, "iw7_fists_mp");
    if(!param_01 || var_07 || var_06) {
      scripts\mp\utility::_switchtoweapon(var_02);
    }

    self setweaponammoclip(var_02, 1);
    scripts\mp\hud_message::showmiscmessage("axe");
    return;
  }

  var_08 = undefined;
  var_09 = 0;
  foreach(var_0B in var_07) {
    if(issubstr(var_0B, "alt_")) {
      continue;
    }

    if(issubstr(var_0B, "uplinkball")) {
      continue;
    }

    var_0C = self getweaponammoclip(var_0B) == 0 && isaxeweapon(var_0B);
    if(!isDefined(var_08) && weaponispreferreddrop(var_0B) || var_0C) {
      var_08 = var_0B;
    }

    var_09++;
  }

  var_0E = undefined;
  if(isDefined(var_08)) {
    var_0E = var_08;
  } else if(var_09 >= 2) {
    var_0E = var_06;
  }

  var_0F = !var_04 || isDefined(var_0E) && issubstr(var_06, var_0E);
  if(isDefined(var_0E)) {
    var_0C = self getweaponammoclip(var_0E) == 0 && isaxeweapon(var_0E);
    var_10 = var_0E == "iw7_fists_mp";
    var_11 = weaponcandrop(var_0E) && !var_0C;
    if(var_11) {
      var_12 = self dropitem(var_0E);
      if(isDefined(var_12)) {
        if(isDefined(self.tookweaponfrom[var_0E])) {
          var_12.triggerportableradarping = self.tookweaponfrom[var_0E];
          self.tookweaponfrom[var_0E] = undefined;
        } else {
          var_12.triggerportableradarping = self;
        }

        var_12.var_336 = "dropped_weapon";
        var_12 thread watchpickup();
        var_12 thread deletepickupafterawhile();
      }
    } else if(!var_11 && !var_10 && var_09 < 2 && !var_0C && var_09 < 2) {
      self takeweapon(var_0E);
    }
  }

  scripts\mp\utility::_giveweapon(var_05);
  self setweaponammoclip(var_05, 1);
  if(var_0F) {
    scripts\mp\utility::_switchtoweapon(var_05);
  }

  scripts\mp\hud_message::showmiscmessage("axe");
  fixupplayerweapons(self, var_05);
}

callback_finishweaponchange(param_00, param_01, param_02, param_03) {
  updatecamoscripts(param_00, param_01, param_02, param_03);
  updateholidayweaponsounds(param_00, param_01, param_02, param_03);
  updateweaponscriptvfx(param_00, param_01, param_02, param_03);
  if(level.ingraceperiod > 0) {
    thread watchrigchangeforweaponfx(param_00, param_01, param_02, param_03);
  }

  scripts\mp\missions::monitorweaponpickup(param_00);
}

watchrigchangeforweaponfx(param_00, param_01, param_02, param_03) {
  self notify("rigChangedDuringGraceperiod");
  self endon("rigChangedDuringGraceperiod");
  self endon("graceperiod_done");
  while(level.ingraceperiod > 0) {
    self waittill("changed_kit");
    if(isDefined(param_01) && param_01 != "none") {
      updateweaponscriptvfx(param_00, param_01, param_02, param_03);
    }
  }
}

updateholidayweaponsounds(param_00, param_01, param_02, param_03) {
  var_04 = getweaponvariantindex(param_00);
  if(scripts\mp\class::isholidayweapon(param_00, var_04)) {
    self _meth_8460("special_foley", "bells", 2);
    return;
  }

  self _meth_8460("special_foley", "", 0.1);
}

updateweaponscriptvfx(param_00, param_01, param_02, param_03) {
  if((param_01 == "none" || param_01 == "alt_none") && isDefined(self.lastdroppableweaponobj)) {
    if(param_01 == "alt_none") {
      param_03 = 1;
    } else {
      param_03 = 0;
    }

    param_01 = self.lastdroppableweaponobj;
  }

  clearweaponscriptvfx(param_01, param_03);
  runweaponscriptvfx(param_00, param_02);
}

runweaponscriptvfx(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_01) && param_01 == 1) {
    var_02 = "alt_" + scripts\mp\utility::getweaponbasedsmokegrenadecount(param_00);
  } else {
    var_02 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_01);
  }

  switch (var_02) {
    case "alt_iw7_rvn_mp":
      self setscriptablepartstate("rvnFXView", "VFX_base", 0);
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
        self setscriptablepartstate("rvnFXWorld", "activePhase", 0);
      } else {
        self setscriptablepartstate("rvnFXWorld", "active", 0);
      }
      break;

    case "alt_iw7_rvn_mpl_burst6":
    case "alt_iw7_rvn_mpl":
      self setscriptablepartstate("rvnFXView", "VFX_epic", 0);
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
        self setscriptablepartstate("rvnFXWorld", "activePhase", 0);
      } else {
        self setscriptablepartstate("rvnFXWorld", "active", 0);
      }
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
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
        self setscriptablepartstate("gaussFXWorld", "activePhase", 0);
      } else {
        self setscriptablepartstate("gaussFXWorld", "active", 0);
      }

      thread chargefxwatcher();
      break;
  }
}

clearweaponscriptvfx(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_01) && param_01 == 1) {
    var_02 = "alt_" + scripts\mp\utility::getweaponbasedsmokegrenadecount(param_00);
  } else {
    var_02 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_01);
  }

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
    if(!scripts\mp\utility::isreallyalive(self)) {
      break;
    }

    self waittill("weapon_charge_update_tag_count", var_00);
    if(var_00 >= 7) {
      self setscriptablepartstate("gaussFXWorld", "active", 0);
      self waittill("weapon_charge_update_tag_count", var_00);
      self setscriptablepartstate("gaussFXWorld", "neutral", 0);
    }

    wait(0.1);
  }
}

chargedeathwatcher() {
  self endon("clear_chargeFXWatcher");
  self waittill("death");
  self setscriptablepartstate("gaussFXWorld", "neutral", 0);
  self notify("clear_chargeFXWatcher");
}

updatecamoscripts(param_00, param_01, param_02, param_03) {
  var_04 = getweaponcamoname(param_00);
  var_05 = getweaponcamoname(param_01);
  if(!isDefined(var_04)) {
    var_04 = "none";
  }

  if(!isDefined(var_05)) {
    var_05 = "none";
  }

  clearcamoscripts(param_01, var_05);
  runcamoscripts(param_00, var_04);
}

runcamoscripts(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  switch (param_01) {
    case "camo31":
      thread mw2_camo_31();
      break;

    case "camo84":
      thread blood_camo_84();
      break;
  }
}

clearcamoscripts(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  switch (param_01) {
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
  if(!isDefined(self.pers["mw2CamoKillCount"])) {
    self.pers["mw2CamoKillCount"] = 0;
  }

  self setscriptablepartstate("camo_31", self.pers["mw2CamoKillCount"] + "_kills");
  for(;;) {
    self waittill("kill_event_buffered");
    self.pers["mw2CamoKillCount"] = self.pers["mw2CamoKillCount"] + 1;
    if(self.pers["mw2CamoKillCount"] > 7) {
      self.pers["mw2CamoKillCount"] = 0;
    }

    self setscriptablepartstate("camo_31", self.pers["mw2CamoKillCount"] + "_kills");
  }
}

blood_camo_84() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");
  if(isDefined(self.bloodcamokillcount)) {
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  } else {
    self.bloodcamokillcount = 0;
  }

  while(self.bloodcamokillcount < 13) {
    self waittill("kill_event_buffered");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  }
}