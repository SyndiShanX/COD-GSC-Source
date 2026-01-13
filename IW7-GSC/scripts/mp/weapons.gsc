/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\weapons.gsc
**********************************/

func_248C(var_0) {
  return tablelookup("mp\attachmentTable.csv", 4, var_0, 2);
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

  var_0 = 70;
  level.claymoredetectiondot = cos(var_0);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.5;
  level.claymoredetonateradius = 192;
  var_1 = 25;
  level.var_10F8F = cos(var_1);
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
  var_2 = spawnStruct();
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
  level.weaponconfigs["bouncingbetty_mp"] = var_2;
  level.weaponconfigs["alienbetty_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.model = "weapon_semtex_grenade_iw6";
  var_2.bombsquadmodel = "weapon_semtex_grenade_iw6_bombsquad";
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  var_2.armtime = 2;
  var_2.ontriggeredsfx = "mine_betty_click";
  var_2.onexplodesfx = "frag_grenade_explode";
  var_2.ontriggeredfunc = ::minebounce;
  var_2.headiconoffset = 20;
  level.weaponconfigs["sticky_mine_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.model = "weapon_motion_sensor";
  var_2.bombsquadmodel = "weapon_motion_sensor_bombsquad";
  var_2.mine_beacon["enemy"] = ::scripts\engine\utility::getfx("weap_blink_enemy");
  var_2.mine_beacon["friendly"] = ::scripts\engine\utility::getfx("weap_blink_friend");
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
  var_2.var_B371 = 4;
  level.weaponconfigs["motion_sensor_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.model = "weapon_mobile_radar";
  var_2.bombsquadmodel = "weapon_mobile_radar_bombsquad";
  var_2.mine_beacon["enemy"] = ::scripts\engine\utility::getfx("weap_blink_enemy");
  var_2.mine_beacon["friendly"] = ::scripts\engine\utility::getfx("weap_blink_friend");
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
  var_2.var_C4C5 = loadfx("vfx\core\mp\equipment\vfx_motionsensor_exp");
  var_2.headiconoffset = 25;
  var_2.var_B371 = 4;
  level.weaponconfigs["mobile_radar_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.armingdelay = 1.5;
  var_2.detectionradius = 232;
  var_2.detectionheight = 512;
  var_2.detectiongraceperiod = 1;
  var_2.headiconoffset = 20;
  var_2.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var_2;
  var_2 = spawnStruct();
  var_3 = 800;
  var_4 = 200;
  var_2.radius_max_sq = var_3 * var_3;
  var_2.radius_min_sq = var_4 * var_4;
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_flashbang.vfx");
  var_2.onexplodesfx = "flashbang_explode_default";
  var_2.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var_2;
  var_2 = spawnStruct();
  var_3 = 800;
  var_4 = 200;
  var_2.radius_max_sq = var_3 * var_3;
  var_2.radius_min_sq = var_4 * var_4;
  var_2.onexplodevfx = loadfx("vfx\core\mp\equipment\vfx_flashbang.vfx");
  var_2.var_C523 = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_charge");
  var_2.var_D828 = loadfx("vfx\iw7\_requests\mp\vfx_disruptor_laser");
  var_2.onexplodesfx = "flashbang_explode_default";
  var_2.vfxradius = 72;
  level.weaponconfigs["throwingknifedisruptor_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.model = "weapon_sonic_sensor_wm";
  var_2.bombsquadmodel = "weapon_motion_sensor_bombsquad";
  var_2.mine_beacon["enemy"] = ::scripts\engine\utility::getfx("weap_blink_enemy");
  var_2.mine_beacon["friendly"] = ::scripts\engine\utility::getfx("weap_blink_friend");
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
  var_2.var_B371 = 4;
  level.weaponconfigs["sonic_sensor_mp"] = var_2;
  var_2 = spawnStruct();
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
  var_2.ontriggeredfunc = ::scripts\mp\equipment\fear_grenade::func_6BBC;
  var_2.onexplodefunc = ::scripts\mp\equipment\fear_grenade::func_6BBB;
  var_2.headiconoffset = 20;
  var_2.minedetectionradius = 200;
  var_2.minedetectionheight = 100;
  level.weaponconfigs["fear_grenade_mp"] = var_2;
  var_2 = spawnStruct();
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
  var_2.ontriggeredfunc = ::scripts\mp\blackholegrenade::blackholeminetrigger;
  var_2.onexplodefunc = ::scripts\mp\blackholegrenade::blackholemineexplode;
  var_2.headiconoffset = 20;
  var_2.minedetectionradius = 200;
  var_2.minedetectionheight = 100;
  level.weaponconfigs["blackhole_grenade_mp"] = var_2;
  var_2 = spawnStruct();
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
  var_2.ontriggeredfunc = ::scripts\mp\shardball::func_FC5A;
  var_2.onexplodefunc = ::scripts\mp\shardball::func_FC59;
  var_2.headiconoffset = 20;
  var_2.minedetectionradius = 200;
  var_2.minedetectionheight = 100;
  level.weaponconfigs["shard_ball_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["c4_mp"] = var_2;
  var_2 = spawnStruct();
  var_2.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_2.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["claymore_mp"] = var_2;
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
    var_0 = scripts\mp\utility::waittill_missile_fire();
    if(!isDefined(var_0)) {
      continue;
    }

    if(var_0.weapon_name == "iw6_mk32_mp") {
      var_0 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad", "tag_weapon", self);
    }
  }
}

createbombsquadmodel(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 hide();
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self.bombsquadmodel = var_3;
  var_3 thread bombsquadvisibilityupdater(var_2);
  var_3 setModel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 setcontents(0);
  scripts\engine\utility::waittill_any_3("death", "trap_death");
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  var_3 delete();
}

func_561A(var_0) {
  self hudoutlineenableforclient(var_0, 6, 1, 0);
}

enablevisibilitycullingforclient(var_0) {
  self hudoutlinedisableforclient(var_0);
}

bombsquadvisibilityupdater(var_0) {
  self endon("death");
  self endon("trap_death");
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0.team;
  for(;;) {
    self hide();
    foreach(var_3 in level.players) {
      enablevisibilitycullingforclient(var_3);
      if(!var_3 scripts\mp\utility::_hasperk("specialty_detectexplosive")) {
        continue;
      }

      if(level.teambased) {
        if(var_3.team == "spectator" || var_3.team == var_1) {
          continue;
        }
      } else if(isDefined(var_0) && var_3 == var_0) {
        continue;
      }

      self showtoplayer(var_3);
      func_561A(var_3);
    }

    level scripts\engine\utility::waittill_any_3("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.hits = 0;
    scripts\mp\gamelogic::sethasdonecombat(var_0, 0);
    var_0 thread onplayerspawned();
    var_0 thread bombsquadwaiter_missilefire();
    var_0 thread watchmissileusage();
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
    var_0 = self getcurrentweapon();
    var_1 = self _meth_8519(var_0);
    var_2 = getweaponcamoname(var_0);
    thread runcamoscripts(var_0, var_2);
    thread runweaponscriptvfx(var_0, var_1);
  }
}

recordtogglescopestates() {
  self.pers["altScopeStates"] = [];
  if(isDefined(self.primaryweapon) && self.primaryweapon != "none" && self hasweapon(self.primaryweapon) && func_7DB8(self.primaryweapon) != "" && self _meth_8519(self.primaryweapon)) {
    var_0 = getweaponbasename(self.primaryweapon);
    var_1 = func_7DB8(self.primaryweapon);
    var_2 = var_0 + "+" + var_1;
    self.pers["altScopeStates"][var_2] = 1;
  }

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && self hasweapon(self.secondaryweapon) && func_7DB8(self.secondaryweapon) != "" && self _meth_8519(self.secondaryweapon)) {
    var_0 = getweaponbasename(self.secondaryweapon);
    var_1 = func_7DB8(self.secondaryweapon);
    var_2 = var_0 + "+" + var_1;
    self.pers["altScopeStates"][var_2] = 1;
  }
}

func_DDF6() {
  if(isDefined(self.primaryweapon) && self.primaryweapon != "none" && self hasweapon(self.primaryweapon) && missile_settargetent(self.primaryweapon) != "" && self _meth_8519(self.primaryweapon)) {
    var_0 = getweaponbasename(self.primaryweapon);
    var_1 = missile_settargetent(self.primaryweapon);
    var_2 = var_0 + "+" + var_1;
    var_3 = func_7DB8(self.primaryweapon);
    var_4 = var_0 + "+" + var_3;
    self.pers["altScopeStates"][var_2] = 1;
    self.pers["altScopeStates"][var_4] = 1;
  }

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && self hasweapon(self.secondaryweapon) && missile_settargetent(self.secondaryweapon) != "" && self _meth_8519(self.secondaryweapon)) {
    var_0 = getweaponbasename(self.secondaryweapon);
    var_1 = missile_settargetent(self.secondaryweapon);
    var_2 = var_0 + "+" + var_1;
    var_3 = func_7DB8(self.secondaryweapon);
    var_4 = var_0 + "+" + var_3;
    self.pers["altScopeStates"][var_2] = 1;
    self.pers["altScopeStates"][var_4] = 1;
  }
}

func_DDF4() {
  self.pers["toggleScopeStates"] = [];
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    if(var_2 == self.primaryweapon || var_2 == self.secondaryweapon) {
      var_3 = getweaponattachments(var_2);
      foreach(var_5 in var_3) {
        if(issmallmissile(var_5)) {
          self.pers["toggleScopeStates"][var_2] = self _meth_812E(var_2);
          break;
        }
      }
    }
  }
}

updatetogglescopestate(var_0) {
  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][var_0])) {
    self give_player_cryobomb(var_0, self.pers["toggleScopeStates"][var_0]);
  }
}

updatesavedaltstate(var_0) {
  var_1 = missile_settargetent(var_0);
  var_2 = func_7DB8(var_0);
  var_3 = getweaponbasename(var_0);
  var_4 = var_3 + "+" + var_1;
  var_5 = var_3 + "+" + var_2;
  if(isDefined(self.pers["altScopeStates"]) && scripts\mp\utility::istrue(isDefined(self.pers["altScopeStates"][var_5]) || isDefined(self.pers["altScopeStates"][var_4]))) {
    return "alt_" + var_0;
  }

  return var_0;
}

issmallmissile(var_0) {
  return 0;
}

func_7DB8(var_0) {
  var_1 = getweaponattachments(var_0);
  foreach(var_3 in var_1) {
    if(func_9D3C(var_3)) {
      return var_3;
    }
  }

  return "";
}

missile_settargetent(var_0) {
  var_1 = getweaponattachments(var_0);
  foreach(var_3 in var_1) {
    if(func_9FF3(var_3)) {
      return var_3;
    }
  }

  return "";
}

func_9D3C(var_0) {
  var_1 = 0;
  switch (var_0) {
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
      var_1 = 1;
      break;

    default:
      var_2 = scripts\mp\utility::attachmentmap_tobase(var_0);
      if(var_2 == "hybrid" || var_2 == "acog") {
        var_1 = 1;
      }
      break;
  }

  return var_1;
}

func_9FF3(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "ripperlscope":
    case "ripperrscope":
    case "ripperscope":
    case "m8lscope":
    case "m8rscope":
    case "m8scope":
    case "akimbofmg":
      var_1 = 1;
      break;

    case "arripper":
    case "arm8":
    default:
      var_2 = scripts\mp\utility::attachmentmap_tobase(var_0);
      if(var_2 == "hybrid" || var_2 == "acog") {
        var_1 = 1;
      }
      break;
  }

  return var_1;
}

func_13AC3() {
  scripts\mp\stinger::func_10FAD();
}

func_13AAC() {
  scripts\mp\javelin::func_A448();
}

weaponperkupdate(var_0, var_1) {
  if(isDefined(var_1) && var_1 != "none") {
    var_1 = scripts\mp\utility::getweaponrootname(var_1);
    var_2 = scripts\mp\utility::func_13CB4(var_1);
    if(isDefined(var_2)) {
      scripts\mp\utility::removeperk(var_2);
    }
  }

  if(isDefined(var_0) && var_0 != "none") {
    var_0 = scripts\mp\utility::getweaponrootname(var_0);
    var_3 = scripts\mp\utility::func_13CB4(var_0);
    if(isDefined(var_3)) {
      scripts\mp\utility::giveperk(var_3);
    }
  }

  if(isDefined(var_1) && issubstr(var_1, "iw7_nunchucks") && var_0 != var_1) {
    scripts\mp\utility::unblockperkfunction("specialty_sprintfire");
  }

  if(isDefined(var_1) && issubstr(var_0, "iw7_nunchucks")) {
    scripts\mp\utility::blockperkfunction("specialty_sprintfire");
  }
}

func_12F5D(var_0) {
  var_1 = 1;
  if(isDefined(var_0) && var_0 != "none") {
    var_2 = weaponclass(var_0);
    if(((var_2 == "sniper" || issubstr(var_0, "iw7_longshot") && !isaltmodeweapon(var_0)) && !scripts\mp\utility::_hasperk("passive_scope_radar")) || getweaponbasename(var_0) == "iw7_m1c_mp" && scripts\mp\utility::weaponhasattachment(var_0, "thermal")) {
      var_1 = 0;
    }
  }

  self setclientomnvar("ui_ads_minimap", var_1);
}

func_13C78(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  if(isDefined(var_1) && var_1 != "none") {
    var_3 = getweaponattachments(var_1);
    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = scripts\mp\utility::attachmentperkmap(var_5);
        if(!isDefined(var_6)) {
          continue;
        }

        scripts\mp\utility::removeperk(var_6);
      }
    }
  }

  if(isDefined(var_0) && var_0 != "none") {
    var_2 = getweaponattachments(var_0);
    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = scripts\mp\utility::attachmentperkmap(var_9);
        if(!isDefined(var_6)) {
          continue;
        }

        scripts\mp\utility::giveperk(var_6);
      }
    }
  }
}

func_13B2E(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    var_2 = self getcurrentweapon();
    if(var_2 == var_0) {
      childthread func_13BAC(var_0, var_1);
    }

    self waittill("weapon_change");
  }
}

func_13BAC(var_0, var_1) {
  self endon("weapon_change");
  for(;;) {
    var_2 = scripts\mp\utility::waittill_missile_fire();
    if(!isDefined(var_2.var_9E8F)) {
      thread func_13BAB(var_0, var_2, anglesToForward(var_2.angles), 0, var_1);
    }
  }
}

func_13BAB(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 >= var_4) {
    return;
  }

  var_5 = var_1 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(2, "death");
  if(var_5 != "death") {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  var_6 = var_1.origin + -8 * var_2;
  var_7 = var_6 + var_2 * 15;
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_player", "physicscontents_vehicleclip"]);
  var_9 = physics_raycast(var_6, var_7, var_8, self, 0, "physicsquery_closest");
  if(var_9.size == 0) {
    return;
  }

  var_0A = var_9[0]["entity"];
  var_0B = var_9[0]["normal"];
  var_0C = var_9[0]["position"];
  if(isDefined(var_0A) && isplayer(var_0A)) {
    return;
  } else {
    var_0D = var_2 - 2 * vectordot(var_2, var_0B) * var_0B;
    var_0D = vectornormalize(var_0D);
    var_0E = var_0C + var_0D * 2;
    var_1 = scripts\mp\utility::_magicbullet(var_0, var_0E, var_0E + var_0D, self);
    var_1.triggerportableradarping = self;
    var_1.var_9E8F = 1;
  }

  thread func_13BAB(var_0, var_1, var_0D, var_3 + 1, var_4);
}

func_13BA9() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  var_0 = undefined;
  var_1 = self getcurrentweapon();
  for(;;) {
    var_1 = self getcurrentweapon();
    func_13C78(var_1, var_0);
    weaponperkupdate(var_1, var_0);
    var_0 = var_1;
    self waittill("weapon_change");
  }
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.lastdroppableweaponobj = self.currentweaponatspawn;
  self.hitsthismag = [];
  var_0 = scripts\mp\utility::func_E0CF(self getcurrentweapon());
  hitsthismag_init(var_0);
  for(;;) {
    self waittill("weapon_change", var_0);
    var_0 = scripts\mp\utility::func_E0CF(var_0);
    if(!func_B4E0(var_0)) {
      continue;
    }

    if(scripts\mp\utility::iskillstreakweapon(var_0)) {
      continue;
    }

    hitsthismag_init(var_0);
    if(scripts\mp\utility::iscacprimaryweapon(var_0) || scripts\mp\utility::iscacsecondaryweapon(var_0)) {
      self.lastdroppableweaponobj = var_0;
    }
  }
}

func_12F11(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  if(var_1) {
    wait(0.05);
  }

  if(var_0 == "iw7_fhr_mp") {
    self setscriptablepartstate("chargeVFX", "chargeVFXOn", 0);
    return;
  }

  self setscriptablepartstate("chargeVFX", "chargeVFXOff", 0);
}

func_13B4C() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    var_0 = self getcurrentweapon();
    if(func_103B9(var_0)) {
      childthread func_103B7();
    }

    self waittill("weapon_change");
  }
}

func_103B9(var_0) {
  return var_0 != "none" && weaponclass(var_0) == "sniper" || issubstr(var_0, "iw7_udm45_mpl") || issubstr(var_0, "iw7_longshot_mp") && !isaltmodeweapon(var_0) && !issubstr(var_0, "iw7_m8_mpr");
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
    self waittill("got_a_kill", var_0, var_1, var_2);
    if(isrecoilreducingweapon(var_1)) {
      var_3 = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(var_3, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);
      if(var_3 <= 4) {
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

isrecoilreducingweapon(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = 0;
  if(issubstr(var_0, "l115a3scope") || issubstr(var_0, "l115a3vzscope") || issubstr(var_0, "usrscope") || issubstr(var_0, "usrvzscope")) {
    var_1 = 1;
  }

  return var_1;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 3;
}

glprox_trygetweaponname(var_0) {
  if(var_0 != "none" && getweaponbasename(var_0) == "iw7_glprox_mp") {
    if(isaltmodeweapon(var_0)) {
      var_1 = getweaponattachments(var_0);
      var_0 = var_1[0];
    } else {
      var_0 = getweaponbasename(var_0);
    }
  }

  return var_0;
}

glprox_modifieddamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;
  var_4 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_4);
  if(!isplayer(var_2)) {
    return var_7;
  }

  if(var_4 != "iw7_glprox_mp") {
    return var_7;
  }

  if(!isexplosivedamagemod(var_5)) {
    return var_7;
  }

  var_8 = 2500;
  if(level.hardcoremode) {
    var_8 = 11025;
  } else if(level.tactical) {
    var_8 = 9216;
  }

  var_9 = 105;
  if(level.hardcoremode) {
    var_9 = 35;
  } else if(level.tactical) {
    var_9 = 105;
  }

  var_0A = 55;
  if(level.hardcoremode) {
    var_0A = 25;
  } else if(level.tactical) {
    var_0A = 55;
  }

  var_0B = undefined;
  var_0C = undefined;
  if(isDefined(var_6)) {
    var_0B = distancesquared(var_6, var_2 getEye());
    var_0C = distancesquared(var_6, var_2.origin);
  } else if(isDefined(var_3)) {
    var_0B = distancesquared(var_3.origin, var_2 getEye());
    var_0C = distancesquared(var_3.origin, var_2.origin);
  }

  if(isDefined(var_0B) && var_0B <= var_8) {
    var_7 = var_9;
  } else if(isDefined(var_0C) && var_0C <= var_8) {
    var_7 = var_9;
  } else {
    var_7 = var_0A;
  }

  return var_7;
}

glprox_modifiedblastshieldconst(var_0, var_1) {
  if(level.hardcoremode) {
    if(scripts\mp\utility::getweaponbasedsmokegrenadecount(var_1) == "iw7_glprox_mp") {
      var_0 = 0.65;
    }
  }

  return var_0;
}

ishackweapon(var_0) {
  if(var_0 == "radar_mp" || var_0 == "airstrike_mp" || var_0 == "helicopter_mp") {
    return 1;
  }

  if(var_0 == "briefcase_bomb_mp") {
    return 1;
  }

  return 0;
}

func_9DF7(var_0) {
  var_0 = scripts\mp\utility::getweaponrootname(var_0);
  return var_0 == "iw7_fists";
}

func_9D6D(var_0) {
  return var_0 == "briefcase_bomb_mp" || var_0 == "briefcase_bomb_defuse_mp";
}

func_B4E0(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(func_9DF7(var_0)) {
    return 0;
  }

  if(func_9D6D(var_0)) {
    return 0;
  }

  if(scripts\mp\powers::func_9F0A(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "ac130")) {
    return 0;
  }

  if(issubstr(var_0, "uav")) {
    return 0;
  }

  if(issubstr(var_0, "killstreak")) {
    return 0;
  }

  if(scripts\mp\utility::issuperweapon(var_0)) {
    return 0;
  }

  var_1 = weaponinventorytype(var_0);
  if(var_1 != "primary") {
    return 0;
  }

  return 1;
}

dropweaponfordeath(var_0, var_1) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  if((isDefined(var_0) && var_0 == self) || var_1 == "MOD_SUICIDE") {
    return;
  }

  var_2 = self.lastdroppableweaponobj;
  if(!isDefined(var_2)) {
    return;
  }

  if(var_2 == "none") {
    return;
  }

  if(!self hasweapon(var_2)) {
    return;
  }

  if(scripts\mp\utility::isjuggernaut()) {
    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_2)) {
    return;
  }

  if(isaltmodeweapon(var_2)) {
    var_2 = scripts\mp\utility::func_E0CF(var_2);
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  if(var_2 != "iw6_riotshield_mp") {
    if(!self getobjectivehinttext(var_2)) {
      return;
    }

    var_3 = self getweaponammoclip(var_2, "right");
    var_4 = self getweaponammoclip(var_2, "left");
    if(!var_3 && !var_4) {
      return;
    }

    var_5 = self getweaponammostock(var_2);
    var_6 = weaponmaxammo(var_2);
    if(var_5 > var_6) {
      var_5 = var_6;
    }

    var_7 = self dropitem(var_2);
    if(!isDefined(var_7)) {
      return;
    }

    var_7 gettimepassedpercentage(var_3, var_5, var_4);
  } else {
    var_7 = self dropitem(var_3);
    if(!isDefined(var_7)) {
      return;
    }

    var_7 gettimepassedpercentage(1, 1, 0);
  }

  self.droppeddeathweapon = 1;
  var_7.triggerportableradarping = self;
  var_7.var_336 = "dropped_weapon";
  var_7 thread watchpickup();
  var_7 thread deletepickupafterawhile();
}

func_1175A(var_0, var_1, var_2, var_3) {
  self.triggerportableradarping endon("disconnect");
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  var_4 = self.origin;
  for(;;) {
    wait(0.25);
    if(!isDefined(self)) {
      return;
    }

    var_5 = self.origin;
    if(var_4 == var_5) {
      break;
    }

    var_4 = var_5;
  }

  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(var_1 <= 0 && var_2 <= 0) {
    return;
  }

  var_6 = self.origin;
  var_7 = self.angles;
  var_8 = 2;
  var_9 = weaponfiretime(var_0) * var_8;
  while(isDefined(self) && var_1 > 0 || var_2 > 0) {
    var_0A = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(0, 1));
    var_0B = var_0A * 180;
    var_0C = var_0A * 1000;
    self.origin = var_6 + (0, 0, 10);
    self.angles = var_0B;
    thread scripts\mp\utility::drawline(self.origin, self.origin + var_0C, 2, (0, 1, 0));
    thread func_1174C(self.origin, var_0C, self.triggerportableradarping, var_0);
    wait(var_9);
    if(!isDefined(self)) {
      break;
    }

    var_1 = var_1 - var_8;
    var_2 = var_2 - var_8;
    if(var_1 <= 0) {
      var_1 = 0;
    }

    if(var_2 <= 0) {
      var_2 = 0;
    }

    self gettimepassedpercentage(var_1, var_3, var_2);
  }

  if(!isDefined(self)) {
    return;
  }

  self.origin = var_6;
  self.angles = var_7;
}

func_1174C(var_0, var_1, var_2, var_3) {
  var_2 endon("disconnect");
  var_4 = var_0 + var_1;
  var_5 = scripts\mp\utility::_magicbullet(var_3, var_0, var_4, var_2);
}

func_1015B() {
  wait(0.1);
  if(!isDefined(self)) {
    return;
  }

  var_0 = getitemweaponname();
  var_1 = getweaponbasename(var_0);
  var_2 = _meth_822A(var_1);
  switch (var_2) {
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

_meth_822A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = strtok(var_0, "_");
  foreach(var_3 in var_1) {
    switch (var_3) {
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

detachifattached(var_0, var_1) {
  var_2 = self getscoreremaining();
  var_3 = 0;
  while(var_3 < var_2) {
    var_4 = self getscoreperminute(var_3);
    if(var_4 != var_0) {
      continue;
    }

    var_5 = self getattachtagname(var_3);
    self detach(var_0, var_5);
    if(var_5 != var_1) {
      var_2 = self getscoreremaining();
      for(var_3 = 0; var_3 < var_2; var_3++) {
        var_5 = self getattachtagname(var_3);
        if(var_5 != var_1) {
          continue;
        }

        var_0 = self getscoreperminute(var_3);
        self detach(var_0, var_5);
        break;
      }
    }

    return 1;
    var_4++;
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
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

watchpickup() {
  self endon("death");
  var_0 = getitemweaponname();
  for(;;) {
    self waittill("trigger", var_1, var_2);
    var_3 = fixupplayerweapons(var_1, var_0);
    if(isDefined(var_2) || var_3) {
      break;
    }
  }

  if(isDefined(var_2)) {
    var_4 = var_2 getitemweaponname();
    if(isDefined(var_1.tookweaponfrom[var_4])) {
      var_2.triggerportableradarping = var_1.tookweaponfrom[var_4];
      var_1.tookweaponfrom[var_4] = undefined;
    }

    var_2.var_336 = "dropped_weapon";
    var_2 thread watchpickup();
  }

  var_1.tookweaponfrom[var_0] = self.triggerportableradarping;
}

fixupplayerweapons(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  foreach(var_6 in var_2) {
    if(var_0.primaryweapon == var_6) {
      var_3 = 0;
      continue;
    }

    if(var_0.secondaryweapon == var_6) {
      var_4 = 0;
    }
  }

  if(var_3) {
    var_0.primaryweapon = var_1;
  } else if(var_4) {
    var_0.secondaryweapon = var_1;
  }

  return var_3 || var_4;
}

itemremoveammofromaltmodes() {
  var_0 = getitemweaponname();
  var_1 = weaponaltweaponname(var_0);
  for(var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++) {
    self gettimepassedpercentage(0, 0, 0, var_2);
    var_1 = weaponaltweaponname(var_1);
  }
}

func_89DF(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self waittill("scavenger", var_2);
  var_2 notify("scavenger_pickup");
  func_EBD2(var_2);
  scripts\mp\powers::func_EBD4(var_2);
  var_2 scripts\mp\damagefeedback::hudicontype("scavenger");
}

func_EBD2(var_0) {
  var_1 = var_0 getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(!scripts\mp\utility::iscacprimaryweapon(var_3) && !level.var_EBD0) {
      continue;
    }

    if(isaltmodeweapon(var_3) && weaponclass(var_3) == "grenade") {
      continue;
    }

    if(scripts\mp\utility::getweapongroup(var_3) == "weapon_projectile") {
      continue;
    }

    if(var_3 == "venomxgun_mp") {
      continue;
    }

    var_4 = var_0 getweaponammostock(var_3);
    var_5 = weaponclipsize(var_3);
    if(issubstr(var_3, "akimbo") && scripts\mp\utility::getweaponrootname(var_3) != "iw7_fmg") {
      var_5 = var_5 * 2;
    }

    var_0 setweaponammostock(var_3, var_4 + var_5);
  }
}

func_EBD3(var_0) {
  if(isDefined(var_0.powers)) {
    foreach(var_2 in var_0.powers) {
      var_0 notify("scavenged_ammo", var_2.weaponuse);
      scripts\engine\utility::waitframe();
    }
  }
}

dropscavengerfordeath(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == self) {
    return;
  }

  var_2 = self dropscavengerbag("scavenger_bag_mp");
  if(!isDefined(var_2)) {
    return;
  }

  var_2 thread func_89DF(self, var_1);
  if(isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var_2);
  }
}

weaponcanstoreaccuracystats(var_0) {
  if(scripts\mp\utility::iscacmeleeweapon(var_0)) {
    return 0;
  }

  return scripts\mp\utility::iscacprimaryweapon(var_0) || scripts\mp\utility::iscacsecondaryweapon(var_0);
}

setweaponstat(var_0, var_1, var_2) {
  scripts\mp\gamelogic::setweaponstat(var_0, var_1, var_2);
}

watchweaponusage(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_fired", var_1);
    var_1 = self getcurrentweapon();
    thread scripts\mp\perks\_weaponpassives::updateweaponpassivesonuse(self, var_1);
    scripts\mp\gamelogic::sethasdonecombat(self, 1);
    var_2 = gettime();
    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var_3 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_2;
    if(scripts\mp\utility::istrue(level.jittermodcheck)) {
      jittermodcheck(var_1);
    } else {
      level.jittermodcheck = getdvarint("scr_modDefense", 0);
    }

    if(!issubstr(var_1, "silence") && var_3 > 500 && level.var_768F) {
      thread scripts\mp\killstreaks\_uplink::func_B37E();
    }

    if(isai(self)) {
      continue;
    }

    if(!weaponcanstoreaccuracystats(var_1)) {
      continue;
    }

    var_4 = var_1;
    if(scripts\mp\perks\_weaponpassives::doesshareammo(var_1)) {
      var_4 = scripts\mp\utility::func_E0CF(var_1);
    }

    if(isDefined(self.hitsthismag[var_4])) {
      thread hitsthismag_update(var_4);
    }

    var_5 = scripts\mp\persistence::statgetbuffered("totalShots") + 1;
    var_6 = scripts\mp\persistence::statgetbuffered("hits");
    var_7 = clamp(float(var_6) / float(var_5), 0, 1) * 10000;
    scripts\mp\persistence::func_10E55("totalShots", var_5);
    scripts\mp\persistence::func_10E55("accuracy", int(var_7));
    scripts\mp\persistence::func_10E55("misses", int(var_5 - var_6));
    if(isDefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime()) {
      self.hits = 0;
      return;
    }

    var_8 = 1;
    setweaponstat(var_1, var_8, "shots");
    setweaponstat(var_1, self.hits, "hits");
    self.hits = 0;
  }
}

jittermodcheck(var_0) {
  var_1 = gettime();
  var_2 = self getcurrentweaponclipammo();
  var_3 = self getcurrentweaponclipammo("left");
  var_4 = undefined;
  var_5 = undefined;
  if(!isDefined(self.lastshot)) {
    self.lastshot = [];
    self.lastshot["time"] = var_1;
    self.lastshot["time_left"] = var_1;
    self.lastshot["ammo"] = self getcurrentweaponclipammo();
    self.lastshot["ammo_left"] = self getcurrentweaponclipammo("left");
    self.lastshot["weapon"] = var_0;
    return;
  }

  if(var_0 == self.lastshot["weapon"] && !self ismantling()) {
    var_4 = var_1 - self.lastshot["time"];
    var_5 = var_1 - self.lastshot["time_left"];
    var_6 = getweaponjittertime(var_0);
    if(self.lastshot["ammo"] != var_2) {
      if(var_4 < var_6) {
        self.ismodded = 1;
      }

      if(self.lastshot["ammo"] > var_2) {
        self.lastshot["time"] = var_1;
      }

      self.lastshot["ammo"] = var_2;
    }

    if(self.lastshot["ammo_left"] != var_3) {
      if(var_5 < var_6) {
        self.ismodded = 1;
      }

      if(self.lastshot["ammo_left"] > var_3) {
        self.lastshot["time_left"] = var_1;
      }

      self.lastshot["ammo_left"] = var_3;
    }
  } else {
    self.lastshot["weapon"] = var_0;
  }

  if(scripts\mp\utility::istrue(self.ismodded)) {
    self setweaponammoclip(var_0, 0);
    self setweaponammoclip(var_0, 0, "left");
    self setweaponammostock(var_0, 0);
    scripts\mp\utility::blockperkfunction("specialty_scavenger");
    self disableweaponpickup();
    self.lastshot = undefined;
  }
}

getweaponjittertime(var_0) {
  var_1 = getweaponbasename(var_0);
  var_2 = 1;
  var_3 = scripts\engine\utility::ter_op(issubstr(var_0, "akimbo"), 1, 0);
  switch (var_1) {
    case "iw7_devastator_mp":
      var_2 = 140;
      break;

    case "iw7_mod2187_mp":
      if(var_3) {
        var_2 = 1000;
      } else {
        var_2 = 1200;
      }
      break;

    case "iw7_sonic_mpr":
    case "iw7_sonic_mp":
      var_2 = 700;
      break;

    case "iw7_spas_mpl_slug":
    case "iw7_spas_mpr":
    case "iw7_spas_mpr_focus":
      var_2 = 900;
      break;

    case "iw7_longshot_mpl":
    case "iw7_longshot_mp":
      var_2 = 800;
      break;

    case "iw7_m1_mpr_silencer":
    case "iw7_m1_mpr":
    case "iw7_m1_mp":
      var_2 = 230;
      break;

    case "iw7_ake_mp_single":
      var_2 = 190;
      break;

    case "iw7_emc_mpl_spread":
      var_2 = 130;
      break;

    case "iw7_fmg_mpl_shotgun":
      if(isaltmodeweapon(var_0)) {
        var_2 = 130;
      }
      break;
  }

  return var_2;
}

hitsthismag_init(var_0) {
  if(var_0 == "none") {
    return;
  }

  if((scripts\mp\utility::iscacprimaryweapon(var_0) || scripts\mp\utility::iscacsecondaryweapon(var_0)) && !isDefined(self.hitsthismag[var_0])) {
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }
}

hitsthismag_update(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("updateMagShots_" + var_0);
  self.hitsthismag[var_0]--;
  wait(0.05);
  self notify("shot_missed", var_0);
  self.consecutivehitsperweapon[var_0] = 0;
  self.hitsthismag[var_0] = weaponclipsize(var_0);
}

func_9046(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("updateMagShots_" + var_0);
  waittillframeend;
  if(isDefined(self.hitsthismag[var_0]) && self.hitsthismag[var_0] == 0) {
    var_1 = scripts\mp\utility::getweapongroup(var_0);
    scripts\mp\missions::processchallenge(var_1);
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }
}

func_3E1E(var_0, var_1) {
  self endon("disconnect");
  if(scripts\mp\utility::isstrstart(var_0, "alt_")) {
    var_2 = scripts\mp\utility::getweaponattachmentsbasenames(var_0);
    if(scripts\engine\utility::array_contains(var_2, "shotgun") || scripts\engine\utility::array_contains(var_2, "gl")) {
      self.hits = 1;
    } else {
      var_0 = getsubstr(var_0, 4);
    }
  }

  if(!weaponcanstoreaccuracystats(var_0)) {
    return;
  }

  if(self meleebuttonpressed() && var_0 != "iw7_knife_mp") {
    return;
  }

  switch (weaponclass(var_0)) {
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

  if(isriotshield(var_0) || var_0 == "iw7_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_0, self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend;
  if(isDefined(self.hitsthismag[var_0])) {
    thread func_9046(var_0);
  }

  if(!isDefined(self.lasthittime[var_0])) {
    self.lasthittime[var_0] = 0;
  }

  if(self.lasthittime[var_0] == gettime()) {
    return;
  }

  self.lasthittime[var_0] = gettime();
  if(!isDefined(self.consecutivehitsperweapon) || !isDefined(self.consecutivehitsperweapon[var_0])) {
    self.consecutivehitsperweapon[var_0] = 1;
  } else {
    self.consecutivehitsperweapon[var_0]++;
  }

  var_3 = scripts\mp\persistence::statgetbuffered("totalShots");
  var_4 = scripts\mp\persistence::statgetbuffered("hits") + 1;
  if(var_4 <= var_3) {
    scripts\mp\persistence::func_10E55("hits", var_4);
    scripts\mp\persistence::func_10E55("misses", int(var_3 - var_4));
    var_5 = clamp(float(var_4) / float(var_3), 0, 1) * 10000;
    scripts\mp\persistence::func_10E55("accuracy", int(var_5));
  }

  thread scripts\mp\missions::func_C5A8(var_0);
  thread scripts\mp\contractchallenges::contractshotslanded(var_0);
  self.lastdamagetime = gettime();
  var_6 = scripts\mp\utility::getweapongroup(var_0);
  if(var_6 == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg)) {
      self.shotslandedlmg = 1;
      return;
    }

    self.shotslandedlmg++;
  }
}

func_24E2(var_0, var_1) {
  return friendlyfirecheck(var_1, var_0);
}

friendlyfirecheck(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  var_4 = level.friendlyfire;
  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return 1;
  }

  if(var_1 == var_0 || isDefined(var_1.triggerportableradarping) && var_1.triggerportableradarping == var_0) {
    return 1;
  }

  var_5 = undefined;
  if(isDefined(var_1.triggerportableradarping)) {
    var_5 = var_1.triggerportableradarping.team;
  } else if(isDefined(var_1.team)) {
    var_5 = var_1.team;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  if(var_5 != var_0.team) {
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
  var_0 = scripts\mp\utility::getintproperty("scr_deleteexplosivesonspawn", 1) && !scripts\mp\utility::_hasperk("specialty_rugged_eqp") || !checkequipforrugged();
  if(var_0) {
    func_51CE();
  }

  var_1 = self.plantedtacticalequip.size;
  var_2 = self.plantedlethalequip.size;
  var_3 = var_1 && var_2;
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp") && var_3) {
    thread scripts\mp\perks\_perkfunctions::feedbackruggedeqp(var_2, var_1);
  }
}

checkequipforrugged() {
  var_0 = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);
  foreach(var_2 in var_0) {
    if(isDefined(var_2.hasruggedeqp)) {
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
  var_0 = scripts\mp\utility::func_1377B();
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.weapon_name)) {
    return;
  }

  setweaponstat(var_0.weapon_name, 1, "shots");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  if(isDefined(level.var_2C46[var_0.weapon_name])) {
    var_0 thread createbombsquadmodel(level.var_2C46[var_0.weapon_name].model, level.var_2C46[var_0.weapon_name].physics_setgravitydynentscalar, self);
  }

  if(getweaponbasename(var_0.weapon_name) == "iw7_glprox_mp") {
    var_1 = glprox_trygetweaponname(var_0.weapon_name);
    if(var_1 == "stickglprox") {
      semtexused(var_0);
    }

    return;
  }

  if(getweaponbasename(var_1.weapon_name) == "iw7_venomx_mp") {
    var_1.var_FF03 = self isinphase();
    return;
  }

  if(isaxeweapon(var_1.weapon_name)) {
    var_1.var_FF03 = self isinphase();
    var_1 thread watchgrenadeaxepickup(self);
    return;
  }

  switch (var_1.weapon_name) {
    case "frag_grenade_mp":
      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1.originalowner = self;
      var_1 thread scripts\mp\shellshock::grenade_earthquake();
      break;

    case "cluster_grenade_mp":
      var_1.clusterticks = var_1.ticks;
      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1.originalowner = self;
      thread clustergrenadeused(var_1);
      var_1 thread scripts\mp\shellshock::grenade_earthquake();
      break;

    case "wristrocket_mp":
      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1.originalowner = self;
      thread scripts\mp\equipment\wrist_rocket::wristrocketused(var_1);
      var_1 thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;

    case "iw6_aliendlc22_mp":
      var_1 thread scripts\mp\shellshock::grenade_earthquake();
      var_1.originalowner = self;
      break;

    case "semtex_mp":
      thread semtexused(var_1);
      break;

    case "cryo_mine_mp":
      thread scripts\mp\equipment\cryo_mine::func_4ADA(var_1);
      break;

    case "c4_mp":
      thread scripts\mp\equipment\c4::c4_used(var_1);
      break;

    case "proximity_explosive_mp":
      thread func_DACD(var_1);
      break;

    case "flash_grenade_mp":
      var_1.var_BFD5 = var_1.ticks;
      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1 thread func_BFD3();
      break;

    case "throwingknifedisruptor_mp":
      thread func_56E6(var_1);
      break;

    case "smoke_grenadejugg_mp":
    case "smoke_grenade_mp":
      var_1 thread func_1037B();
      break;

    case "gas_grenade_mp":
      var_1 thread watchgasgrenadeexplode();
      break;

    case "concussion_grenade_mp":
      thread scripts\mp\concussiongrenade::func_44EE(var_1);
      break;

    case "alientrophy_mp":
    case "trophy_mp":
      thread scripts\mp\trophy_system::func_12827(var_1);
      break;

    case "claymore_mp":
      thread claymoreused(var_1);
      break;

    case "alienbetty_mp":
    case "bouncingbetty_mp":
      thread mineused(var_1, ::spawnmine);
      break;

    case "motion_sensor_mp":
      thread mineused(var_1, ::func_108E7);
      break;

    case "mobile_radar_mp":
      thread mineused(var_1, ::func_108E5);
      break;

    case "distortionfield_grenade_mp":
      var_1 thread func_139F5();
      break;

    case "throwingknifejugg_mp":
    case "throwingknifehack_mp":
    case "throwingknifesiphon_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifeteleport_mp":
    case "throwingknife_mp":
    case "throwingknifec4_mp":
      level thread throwingknifeused(self, var_1, var_1.weapon_name);
      break;

    case "sensor_grenade_mp":
      break;

    case "sonic_sensor_mp":
      thread mineused(var_1, ::func_10910);
      break;

    case "proto_ricochet_device_mp":
      thread scripts\mp\ricochet::func_E4E9(var_1);
      break;

    case "proxy_bomb_mp":
      thread func_DAD5(self, var_1);
      break;

    case "disc_marker_mp":
      thread func_562B(self, var_1);
      break;

    case "adrenaline_mist_mp":
      break;

    case "case_bomb_mp":
      thread func_3B0E(self, var_1);
      break;

    case "domeshield_mp":
      thread scripts\mp\domeshield::func_5910(var_1);
      break;

    case "blackhole_grenade_mp":
      thread scripts\mp\blackholegrenade::blackholegrenadeused(var_1);
      break;

    case "portal_grenade_mp":
      break;

    case "copycat_grenade_mp":
      break;

    case "speed_strip_mp":
      break;

    case "shard_ball_mp":
      if(scripts\mp\powerloot::func_D779(var_1.power, "passive_grenade_to_mine")) {
        thread mineused(var_1, ::func_1090D, ::scripts\mp\shardball::placementfailed);
      } else {
        thread scripts\mp\shardball::func_FC5B(var_1);
      }
      break;

    case "splash_grenade_mp":
      var_1 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\splashgrenade::splashgrenadeused(var_1);
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
      thread scripts\mp\equipment\pulse_grenade::func_DAF5(var_1);
      break;

    case "ammo_box_mp":
      break;

    case "virus_grenade_mp":
      break;

    case "fear_grenade_mp":
      thread mineused(var_1, ::func_10884);
      break;

    case "deployable_cover_mp":
      break;

    case "power_spider_grenade_mp":
      thread scripts\mp\equipment\spider_grenade::spidergrenade_used(var_1);
      break;

    case "split_grenade_mp":
      thread scripts\mp\equipment\split_grenade::func_10A54(var_1);
      break;

    case "trip_mine_mp":
      thread scripts\mp\equipment\trip_mine::tripmine_used(var_1);
      break;

    case "power_exploding_drone_mp":
      thread scripts\mp\equipment\exploding_drone::func_69D4(var_1);
      break;
  }
}

func_562B(var_0, var_1) {
  var_1 waittill("missile_stuck");
  var_0 notify("markerPlanted", var_1);
}

func_3B0E(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 waittill("missile_stuck");
  if(!isDefined(var_1.origin)) {}
}

func_3B0D(var_0, var_1) {
  level endon("game_ended");
  wait(0.05);
  var_2 = var_0 _meth_8113();
  wait(randomfloatrange(0.5, 0.8));
  if(!isDefined(var_2)) {
    return;
  }

  var_3 = var_2.origin;
  self playSound("frag_grenade_explode");
  earthquake(0.5, 1.5, var_3, 120);
  playFX(level._effect["case_bomb"], var_3 + (0, 0, 12));
  thread scripts\mp\utility::func_13AF(var_3, 256, 400, 50, self, "MOD_EXPLOSIVE", "case_bomb_mp", 0);
  wait(0.1);
  playFX(level._effect["corpse_pop"], var_3 + (0, 0, 12));
  if(isDefined(var_2)) {
    var_2 hide();
  }
}

func_DAD5(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 waittill("missile_stuck", var_2);
  if(isDefined(var_2) && isplayer(var_2) || isagent(var_2)) {
    var_1 detonate(var_0);
  }
}

throwingknifeused(var_0, var_1, var_2) {
  var_1 makeunusable();
  if(var_2 == "throwingknifehack_mp") {} else if(var_2 == "throwingknifec4_mp") {
    var_1 thread recordthrowingknifetraveldist();
  }

  var_3 = undefined;
  var_4 = undefined;
  if(var_2 == "throwingknifesmokewall_mp") {
    var_1 func_1181E(var_0);
    return;
  } else {
    var_1 waittill("missile_stuck", var_3, var_4);
  }

  var_5 = isDefined(var_4) && var_4 == "tag_flicker";
  var_6 = isDefined(var_4) && var_4 == "tag_weapon";
  if(isDefined(var_3) && isplayer(var_3) || isagent(var_3) && var_5) {
    var_3 notify("shield_hit", var_1);
  }

  if(isDefined(var_3) && isplayer(var_3) || isagent(var_3) && !var_6 && !var_5) {
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_3, var_1)) {
      var_1 delete();
      return;
    } else if(var_2 == "throwingknifeteleport_mp") {} else if(var_2 == "throwingknifec4_mp") {
      throwingknifec4detonate(var_1, var_3, var_0);
    } else if(var_2 == "throwingknifesiphon_mp") {
      scripts\mp\equipment\siphon_knife::func_1181D(var_1, var_3, var_0);
      return;
    } else if(var_2 == "throwingknifehack_mp") {
      return;
    }
  }

  thread func_11825(var_0, var_1);
  var_1 endon("death");
  var_1 makeunusable();
  var_7 = spawn("trigger_radius", var_1.origin, 0, 64, 64);
  var_7 enablelinkto();
  var_7 linkto(var_1);
  var_7.var_336 = "dropped_knife";
  var_1.knife_trigger = var_7;
  var_1 thread watchgrenadedeath();
  for(;;) {
    scripts\engine\utility::waitframe();
    if(!isDefined(var_7)) {
      return;
    }

    var_7 waittill("trigger", var_8);
    if(!isplayer(var_8) || !scripts\mp\utility::isreallyalive(var_8)) {
      continue;
    }

    if(!var_8 hasweapon(var_2)) {
      continue;
    }

    if(throwingknifeused_trygiveknife(var_8, var_1.power)) {
      var_1 delete();
      break;
    }
  }
}

recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.triggerportableradarping endon("disconnect");
  self.disttravelled = 0;
  var_0 = self.origin;
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_timeout_1(0.15, "death", "missile_stuck");
    if(!isDefined(self)) {
      break;
    }

    var_2 = distance(var_0, self.origin);
    self.disttravelled = self.disttravelled + var_2;
    var_0 = self.origin;
    if(var_1 != "timeout") {
      break;
    }
  }
}

func_11825(var_0, var_1) {
  var_2 = scripts\mp\utility::outlineenableforplayer(var_1, "white", var_0, 1, 0, "equipment");
  var_1 waittill("death");
  scripts\mp\utility::outlinedisable(var_2, var_1);
}

throwingknifeused_trygiveknife(var_0, var_1) {
  if(var_0 scripts\mp\powers::func_D734(var_1) == var_0 scripts\mp\powers::func_D736(var_1)) {
    return 0;
  }

  var_0 scripts\mp\powers::func_D74C(var_1);
  var_0 scripts\mp\hud_message::showmiscmessage("throwingknife");
  return 1;
}

throwingknife_detachknivesfromcorpse(var_0) {
  var_1 = var_0 getlinkedchildren();
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3.weapon_name;
    if(isDefined(var_4) && func_9FA9(var_4)) {
      var_3 unlink();
      var_5 = throwingknife_getdudknifeweapon(var_4);
      var_3 = var_3.triggerportableradarping scripts\mp\utility::_launchgrenade(var_5, var_3.origin, (0, 0, 0), 100, 1, var_3);
      if(isDefined(var_3.triggerportableradarping)) {
        var_3 setentityowner(var_3.triggerportableradarping);
      }

      thread throwingknife_triggerlinkto(var_3);
      var_3 missiledonttrackkillcam();
    }
  }
}

throwingknife_triggerlinkto(var_0) {
  var_0 endon("death");
  while(!isDefined(var_0.knife_trigger)) {
    scripts\engine\utility::waitframe();
  }

  var_1 = var_0.knife_trigger;
  var_1 endon("death");
  var_1 unlink();
  throwingknife_triggerlinktointernal(var_1, var_0);
  var_1 dontinterpolate();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 linkto(var_0);
}

throwingknife_triggerlinktointernal(var_0, var_1) {
  var_1 endon("missile_stuck");
  for(;;) {
    var_0.origin = var_1.origin;
    scripts\engine\utility::waitframe();
  }
}

throwingknife_getdudknifeweapon(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "throwingknifec4_mp":
      var_1 = "throwingknifec4dud_mp";
      break;

    case "throwingknifeteleport_mp":
      var_1 = "throwingknifeteleportdud_mp";
      break;

    default:
      var_1 = "throwingknifec4dud_mp";
      break;
  }

  return var_1;
}

throwingknifec4init() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx\iw7\_requests\mp\power\vfx_bio_spike_exp.vfx");
}

throwingknifec4detonate(var_0, var_1, var_2) {
  scripts\mp\missions::func_2AEA(var_0, var_2, var_1);
  var_1 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var_0.origin);
  var_0 radiusdamage(var_0.origin, 180, 140, 70, var_2, "MOD_EXPLOSIVE", var_0.weapon_name);
  var_0 thread scripts\mp\shellshock::grenade_earthquake();
  var_0 notify("explode", var_0.origin);
}

func_1181E(var_0) {
  var_0 thread scripts\mp\equipment\smoke_wall::func_1037D(self);
}

func_F235(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_3 = spawnStruct();
  var_3.var_C78B = [];
  var_4 = 0;
  thread func_F233(var_0, var_1);
  while(isDefined(var_1)) {
    foreach(var_6 in level.characters) {
      if(!isDefined(var_6)) {
        continue;
      }

      if(!var_0 scripts\mp\utility::isenemy(var_6)) {
        continue;
      }

      if(var_6 scripts\mp\utility::_hasperk("specialty_incog")) {
        continue;
      }

      if(isDefined(var_3.var_C78B[var_6 getentitynumber()])) {
        continue;
      }

      if(distancesquared(var_1.origin, var_6.origin) > 90000) {
        continue;
      }

      var_3.var_C78B[var_6 getentitynumber()] = var_6;
      thread func_F234(var_0, var_6, var_3);
    }

    scripts\engine\utility::waitframe();
  }
}

func_10413(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 endon("death");
  var_3 = spawnStruct();
  var_3.var_C78B = [];
  var_4 = 0;
  thread func_F233(var_0, var_1);
  while(isDefined(var_1)) {
    foreach(var_6 in level.characters) {
      if(!isDefined(var_6)) {
        continue;
      }

      if(!var_0 scripts\mp\utility::isenemy(var_6)) {
        continue;
      }

      if(var_6 scripts\mp\utility::_hasperk("specialty_quieter")) {
        continue;
      }

      if(isDefined(var_3.var_C78B[var_6 getentitynumber()])) {
        continue;
      }

      if(distancesquared(var_1.origin, var_6.origin) > 90000) {
        continue;
      }

      var_7 = scripts\engine\utility::array_add_safe(level.players, var_1);
      if(!scripts\common\trace::ray_trace_passed(var_1.origin, var_6.origin + (0, 0, 32), var_7)) {
        continue;
      }

      var_3.var_C78B[var_6 getentitynumber()] = var_6;
      thread func_F234(var_0, var_6, var_3);
    }

    wait(2);
  }
}

func_F233(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  scripts\engine\utility::waitframe();
  scripts\mp\utility::outlineenableforplayer(var_1, "cyan", var_0, 0, 0, "equipment");
  if(var_1.weapon_name == "sonic_sensor_mp") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_sonic_sensor_pulse"), var_1, "tag_origin");
    return;
  }

  playfxontagforclients(scripts\engine\utility::getfx("vfx_sensor_grenade_ping"), var_1, "tag_origin", var_0);
}

func_F234(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_3 = var_1 getentitynumber();
  var_4 = undefined;
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  var_4 = scripts\mp\utility::outlineenableforplayer(var_1, "orange", var_0, 0, 0, "equipment");
  wait(0.5);
  if(isDefined(var_1) && isDefined(var_4)) {
    scripts\mp\utility::outlinedisable(var_4, var_1);
  }

  var_2.var_C78B[var_3] = undefined;
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
  self waittill("explode", var_0);
  thread func_10377(var_0);
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread monitorsmokeactive();
  }
}

func_10377(var_0) {
  wait(1);
  thread smokegrenadegiveblindeye(var_0);
  var_1 = scripts\mp\utility::func_180C(var_0, 200);
  wait(8.25);
  scripts\mp\utility::func_E14A(var_1);
}

smokeunderbarrelused(var_0) {
  self endon("disconnect");
  var_0 waittill("explode", var_1);
  self launchgrenade("smoke_grenade_mp", var_1, (0, 0, 0));
  var_0 thread func_10377(var_1);
}

smokegrenadegiveblindeye(var_0) {
  var_1 = spawnStruct();
  var_1.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(var_1, var_0);
  foreach(var_3 in var_1.blindeyerecipients) {
    if(isDefined(var_3) && scripts\mp\utility::isreallyalive(var_3)) {
      var_3 scripts\mp\utility::removeperk("specialty_blindeye");
    }
  }
}

smokegrenademonitorblindeyerecipients(var_0, var_1) {
  level endon("game_ended");
  var_2 = gettime() + 8250;
  var_3 = [];
  while(gettime() < var_2) {
    var_3 = scripts\mp\utility::clearscrambler(var_1, 200);
    foreach(var_7, var_5 in var_0.blindeyerecipients) {
      if(!isDefined(var_5)) {
        var_0.blindeyerecipients[var_7] = undefined;
        continue;
      }

      var_6 = scripts\engine\utility::array_find(var_3, var_5);
      if(!isDefined(var_6) || !scripts\mp\utility::isreallyalive(var_5) || scripts\mp\equipment\phase_shift::isentityphaseshifted(var_5)) {
        var_5 scripts\mp\utility::removeperk("specialty_blindeye");
        var_0.blindeyerecipients[var_7] = undefined;
      }

      if(isDefined(var_6)) {
        var_3[var_6] = undefined;
      }
    }

    foreach(var_9 in var_3) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(isDefined(var_0.blindeyerecipients[var_9 getentitynumber()])) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_9) || scripts\mp\equipment\phase_shift::isentityphaseshifted(var_9) || scripts\mp\utility::func_9F72(var_9)) {
        continue;
      }

      var_9 scripts\mp\utility::giveperk("specialty_blindeye");
      var_0.blindeyerecipients[var_9 getentitynumber()] = var_9;
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
  var_0 = scripts\engine\utility::waittill_any_timeout_1(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility::printgameaction("smoke grenade deactivated", self);
}

watchgasgrenadeexplode() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  thread ongasgrenadeimpact(var_0, var_1);
}

ongasgrenadeimpact(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_1, 0, 128, 160);
  var_2.triggerportableradarping = var_0;
  var_3 = 128;
  var_4 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), var_1);
  triggerfx(var_4);
  wait(1);
  var_5 = 3;
  var_6 = spawn("script_model", var_1 + (0, 0, 60));
  var_6 linkto(var_2);
  var_2.killcament = var_6;
  while(var_5 > 0) {
    foreach(var_8 in level.characters) {
      var_8 applygaseffect(var_0, var_1, var_2, var_2, 4);
    }

    wait(0.2);
    var_5 = var_5 - 0.2;
  }

  var_4 delete();
  wait(2);
  var_6 delete();
  var_2 delete();
}

applygaseffect(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(self) && self istouching(var_2)) {
    if(var_0 scripts\mp\utility::isenemy(self) || self == var_0) {
      var_3 radiusdamage(self.origin, 1, var_4, var_4, var_0, "MOD_RIFLE_BULLET", "gas_grenade_mp");
    }
  }
}

func_AF2B(var_0) {
  var_1 = [];
  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_3 in level.characters) {
        if(isDefined(var_3) && isalive(var_3) && var_3.team != self.team) {
          var_1[var_1.size] = var_3;
        }
      }
    }

    if(isDefined(level.var_1655)) {
      foreach(var_6 in level.var_1655) {
        if(isDefined(var_6.var_18DE) && var_6.team != self.team) {
          var_1[var_1.size] = var_6;
        }
      }
    }

    if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
      foreach(var_9 in level.supertrophy.trophies) {
        if(isDefined(var_9) && isDefined(var_9.team) && var_9.team != self.team) {
          var_1[var_1.size] = var_9;
        }
      }
    }

    if(isDefined(level.microturrets)) {
      foreach(var_0C in level.microturrets) {
        if(isDefined(var_0C) && isDefined(var_0C.team) && var_0C.team != self.team) {
          var_1[var_1.size] = var_0C;
        }
      }
    }
  } else {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_3 in level.characters) {
        if(!isDefined(var_3) || !isalive(var_3)) {
          continue;
        }

        var_1[var_1.size] = var_3;
      }
    }

    if(isDefined(level.var_1655)) {
      foreach(var_6 in level.var_1655) {
        if(isDefined(var_6.var_18DE) && isDefined(var_6.triggerportableradarping) && var_6.triggerportableradarping != self) {
          var_1[var_1.size] = var_6;
        }
      }
    }

    if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
      foreach(var_9 in level.supertrophy.trophies) {
        if(isDefined(var_9) && isDefined(var_9.triggerportableradarping) && var_9.triggerportableradarping != self) {
          var_1[var_1.size] = var_9;
        }
      }
    }

    if(isDefined(level.microturrets)) {
      foreach(var_0C in level.microturrets) {
        if(isDefined(var_0C) && isDefined(var_0C.triggerportableradarping) && var_0C.triggerportableradarping != self) {
          var_1[var_1.size] = var_0C;
        }
      }
    }
  }

  return var_1;
}

watchmissileusage() {
  self endon("disconnect");
  for(;;) {
    var_0 = scripts\mp\utility::waittill_missile_fire();
    if(!isDefined(var_0)) {
      continue;
    }

    switch (var_0.weapon_name) {
      case "stinger_mp":
      case "iw7_lockon_mp":
        level notify("stinger_fired", self, var_0, self.var_10FAA);
        break;

      case "javelin_mp":
      case "lasedStrike_missile_mp":
      case "remote_mortar_missile_mp":
        level notify("stinger_fired", self, var_0, self.var_A445);
        break;

      case "iw7_blackholegun_mp":
        thread scripts\mp\supers\super_blackholegun::missilespawned(var_0.weapon_name, var_0);
        break;

      case "iw7_unsalmg_mpl_auto":
      case "iw7_unsalmg_mp":
      case "iw7_unsalmg_mpl":
        var_0.weapon_name = "power_smoke_drone_mp";
        thread scripts\mp\equipment\exploding_drone::func_69D4(var_0, 1);
        break;

      case "iw7_tacburst_mpl":
      case "iw7_tacburst_mp":
        var_0 thread scripts\mp\empgrenade::func_13A12();
        break;

      case "iw7_tacburst_mpl_epic2":
        var_0 thread scripts\mp\perks\_weaponpassives::cryogl_watchforexplode(self);
        break;

      case "iw7_mp28_mpl_fasthip":
        thread smokeunderbarrelused(var_0);
        break;

      default:
        break;
    }

    if(isplayer(self)) {
      var_0.adsfire = scripts\mp\utility::func_9EE8();
    }

    if(isexplosivemissile(var_0.weapon_name)) {
      var_1 = 1;
      if(func_9F5C(var_0.weapon_name)) {
        var_1 = 0.65;
      }

      var_0 thread scripts\mp\shellshock::grenade_earthquake(var_1);
    }

    var_0.var_FF03 = self isinphase();
  }
}

func_9F5C(var_0) {
  var_0 = getweaponbasename(var_0);
  var_1 = 0;
  switch (var_0) {
    case "iw7_venomx_mp":
    case "iw7_glprox_mp":
      var_1 = 1;
      break;

    default:
      break;
  }

  return var_1;
}

isexplosivemissile(var_0) {
  var_0 = getweaponbasename(var_0);
  switch (var_0) {
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
    self waittill("sentry_placement_finished", var_0);
    thread scripts\mp\utility::setaltsceneobj(var_0, "tag_flash", 65);
  }
}

func_42D8(var_0) {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_1);
}

clustergrenadeused(var_0) {
  if(isalive(self)) {
    var_1 = anglesToForward(self getgunangles()) * 940;
    var_2 = (0, 0, 120);
    var_3 = var_1 + var_2;
  } else {
    var_1 = anglesToForward(self getgunangles()) * 50;
    var_2 = (0, 0, 10);
    var_3 = var_2 + var_3;
  }

  var_0 = scripts\mp\utility::_launchgrenade("cluster_grenade_mp", var_0.origin, var_3, 100, 1, var_0);
  var_0 thread func_4107();
  thread func_42DF(var_0);
}

func_42DF(var_0, var_1) {
  var_0 endon("death");
  self endon("disconnect");
  var_2 = 1 - var_0.tickpercent * 3.5;
  wait(var_2);
  thread clustergrenadeexplode(var_0);
}

clustergrenadeexplode(var_0) {
  var_0 notify("death");
  var_0.exploding = 1;
  var_0.origin = var_0.origin;
  var_1 = spawn("script_model", var_0.origin);
  var_1 setotherent(var_0.triggerportableradarping);
  var_1 setModel("prop_mp_cluster_grenade_scr");
  func_42DB(var_0, var_1);
  if(isDefined(var_0)) {
    var_0 forcehidegrenadehudwarning(1);
  }

  wait(2);
  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_42DB(var_0, var_1) {
  self endon("disconnect");
  scripts\mp\utility::printgameaction("cluster grenade explode", self);
  var_2 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_3 = var_0.origin;
  var_4 = 0;
  var_5 = var_3 + (0, 0, 3);
  var_6 = var_5 + (0, 0, -5);
  var_7 = physics_raycast(var_5, var_6, var_2, undefined, 0, "physicsquery_closest");
  if(isDefined(var_7) && var_7.size > 0) {
    var_4 = 1;
  }

  var_8 = scripts\engine\utility::ter_op(var_4, (0, 0, 32), (0, 0, 2));
  var_9 = var_3 + var_8;
  var_0A = randomint(90) - 45;
  var_2 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 1, 0);
  for(var_0B = 0; var_0B < 4; var_0B++) {
    var_0C = "explode" + var_0B + 1;
    var_0 setscriptablepartstate(var_0C, "active", 0);
    var_0D = scripts\engine\utility::ter_op(var_0B < 4, 90 * var_0B + var_0A, randomint(360));
    var_0E = scripts\engine\utility::ter_op(var_4, 110, 90);
    var_0F = scripts\engine\utility::ter_op(var_4, 12, 45);
    var_10 = var_0E + randomint(var_0F * 2) - var_0F;
    var_11 = randomint(60) + 30;
    var_12 = cos(var_0D) * sin(var_10);
    var_13 = sin(var_0D) * sin(var_10);
    var_14 = cos(var_10);
    var_15 = (var_12, var_13, var_14) * var_11;
    var_5 = var_9;
    var_6 = var_9 + var_15;
    var_7 = physics_raycast(var_5, var_6, var_2, undefined, 0, "physicsquery_closest");
    if(isDefined(var_7) && var_7.size > 0) {
      var_6 = var_7[0]["position"];
    }

    var_1 dontinterpolate();
    var_1.origin = var_6;
    var_1 setscriptablepartstate(var_0C, "active", 0);
    wait(0.175);
  }
}

func_4107() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self delete();
}

func_10D85(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(!isDefined(var_4)) {
    return;
  }

  if(var_6) {
    var_0B = spawnfx(var_7, self.origin);
    playsoundatpos(self.origin, var_8);
    triggerfx(var_0B);
    wait(2);
    var_0B delete();
  } else {
    wait(var_0);
  }

  if(!isDefined(var_4)) {
    return;
  }

  radiusdamage(self.origin + (0, 0, 50), var_1, var_2, var_3, var_4, "MOD_EXPLOSIVE", var_0A);
  playFX(var_5, self.origin + (0, 0, 50));
  playsoundatpos(self.origin, var_9);
  self delete();
}

func_BFD3() {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_0);
  thread func_5925(var_0, self.triggerportableradarping, self.var_BFD5);
  func_BFD2(var_0, self.triggerportableradarping, self.var_BFD5);
}

func_BFD2(var_0, var_1, var_2) {
  if(var_2 >= 5 || func_CBED(var_1, var_2)) {
    playsoundatpos(var_0, "emp_grenade_explode_default");
    var_3 = getempdamageents(var_0, 512, 0, undefined);
    foreach(var_5 in var_3) {
      if(isDefined(var_5.triggerportableradarping) && !friendlyfirecheck(var_1, var_5.triggerportableradarping)) {
        continue;
      }

      var_5 notify("emp_damage", self.triggerportableradarping, 8);
    }
  }
}

func_CBED(var_0, var_1) {
  if(var_0 scripts\mp\utility::_hasperk("specialty_pitcher")) {
    if(var_1 >= 4) {
      return 1;
    }
  }

  return 0;
}

func_5925(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = level.weaponconfigs[self.weapon_name];
  wait(randomfloatrange(0.25, 0.5));
  for(var_4 = 1; var_4 < var_2; var_4++) {
    var_5 = func_7FF0(var_0, var_3.vfxradius);
    playsoundatpos(var_5, var_3.onexplodesfx);
    playFX(var_3.onexplodevfx, var_5);
    foreach(var_7 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_7) || var_7.sessionstate != "playing") {
        continue;
      }

      var_8 = var_7 getEye();
      var_9 = distancesquared(var_0, var_8);
      if(var_9 > var_3.radius_max_sq) {
        continue;
      }

      if(!bullettracepassed(var_0, var_8, 0, var_7)) {
        continue;
      }

      if(var_9 <= var_3.radius_min_sq) {
        var_0A = 1;
      } else {
        var_0A = 1 - var_9 - var_3.radius_min_sq / var_3.radius_max_sq - var_3.radius_min_sq;
      }

      var_0B = anglesToForward(var_7 getplayerangles());
      var_0C = var_0 - var_8;
      var_0C = vectornormalize(var_0C);
      var_0D = 0.5 * 1 + vectordot(var_0B, var_0C);
      var_0E = 1;
      var_7 notify("flashbang", var_0, var_0A, var_0D, var_1, var_0E);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

func_7FF0(var_0, var_1) {
  var_2 = (randomfloatrange(-1 * var_1, var_1), randomfloatrange(-1 * var_1, var_1), 0);
  var_3 = var_0 + var_2;
  var_4 = bulletTrace(var_0, var_3, 0, self, 0, 0, 0, 0, 0);
  if(var_4["fraction"] < 1) {
    var_3 = var_0 + var_4["fraction"] * var_2;
  }

  return var_3;
}

func_56E6(var_0) {
  var_0 waittill("missile_stuck", var_1);
  var_0 thread func_56E5(self, 1);
}

func_56E5(var_0, var_1) {
  level endon("game_ended");
  var_2 = level.weaponconfigs[self.weapon_name];
  playFX(var_2.var_C523, self.origin);
  for(var_3 = 0; var_3 < var_1; var_3++) {
    foreach(var_5 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_5) || var_5.sessionstate != "playing") {
        continue;
      }

      if(var_5.team == self.triggerportableradarping.team) {
        continue;
      }

      if(var_5 == self.triggerportableradarping) {
        continue;
      }

      var_6 = var_5 getEye();
      if(!scripts\common\trace::ray_trace_passed(self.origin, var_6, level.players)) {
        continue;
      }

      thread func_56E4(var_5, var_0, var_2, var_6);
    }

    wait(0.75);
    playsoundatpos(self.origin, var_2.onexplodesfx);
    playFX(var_2.onexplodevfx, self.origin);
  }

  self delete();
}

func_56E4(var_0, var_1, var_2, var_3) {
  var_4 = self.origin;
  var_5 = anglesToForward(var_0 getplayerangles());
  var_6 = var_4 - var_3;
  var_7 = vectornormalize(var_6);
  playFX(var_2.var_D828, var_4, rotatevector(var_6, (0, 180, 0)) * (1, 1, -1));
  wait(0.75);
  if(var_0 adsbuttonpressed() && var_0 worldpointinreticle_circle(var_4, 65, 300)) {
    var_0 shellshock("disruptor_mp", 2.5, 0, 1);
    return;
  }

  var_8 = distancesquared(var_4, var_3);
  if(var_8 < var_2.radius_max_sq) {
    if(var_8 <= var_2.radius_min_sq) {
      var_9 = 1;
    } else {
      var_9 = 1 - var_9 - var_3.radius_min_sq / var_3.radius_max_sq - var_3.radius_min_sq;
    }

    var_0A = 0.65 * 1 + vectordot(var_5, var_7);
    var_0B = 1;
    var_0 notify("flashbang", var_4, var_9, var_0A, var_1, var_0B);
  }
}

c4used(var_0) {
  if(!scripts\mp\utility::isreallyalive(self)) {
    var_0 delete();
    return;
  }

  self notify("c4_update", 0);
  var_0 thread ondetonateexplosive();
  thread watchc4detonation();
  thread watchc4altdetonation();
  thread watchc4altdetonate();
  var_0 setotherent(self);
  var_0.activated = 0;
  onlethalequipmentplanted(var_0, "power_c4");
  var_1 = level.weaponconfigs["c4_mp"];
  var_0 thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  var_0 thread scripts\mp\shellshock::c4_earthquake();
  var_0 thread c4activate();
  var_0 thread func_3343();
  var_0 thread func_66B4(1);
  var_0 thread watchc4stuck();
  level thread monitordisownedequipment(self, var_0);
}

watchc4implode() {
  self.triggerportableradarping endon("disconnect");
  var_0 = self.triggerportableradarping;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 linkto(self);
  thread func_334D(var_1);
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_2);
  thread c4implode(var_2, var_0, var_1);
}

c4implode(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait(0.5);
  var_2 radiusdamage(var_0, 256, 140, 70, var_1, "MOD_EXPLOSIVE", "c4_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(var_0);
}

func_334D(var_0) {
  var_0 endon("death");
  self waittill("death");
  wait(1);
  var_0 delete();
}

movingplatformdetonate(var_0) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
  }
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck", var_0);
  self give_player_tickets(1);
  self.c4stuck = 1;
  thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread outlineequipmentforowner(self, self.triggerportableradarping);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", self.triggerportableradarping, 1);
  explosivehandlemovers(var_0);
  makeexplosiveusable();
}

c4empdamage() {
  self endon("death");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("disabled");
    wait(var_1);
    self.disabled = undefined;
    self notify("enabled");
  }
}

func_DACD(var_0) {
  if(!scripts\mp\utility::isreallyalive(self)) {
    var_0 delete();
    return;
  }

  var_0 waittill("missile_stuck", var_1);
  if(!scripts\mp\utility::isreallyalive(self)) {
    var_0 delete();
    return;
  }

  if(!isDefined(var_0.triggerportableradarping.team)) {
    var_0 delete();
    return;
  }

  var_2 = anglestoup(var_0.angles);
  var_0.origin = var_0.origin - var_2;
  var_3 = level.weaponconfigs[var_0.weapon_name];
  var_4 = spawn("script_model", var_0.origin + var_3.killcamoffset * var_2);
  var_4 setscriptmoverkillcam("explosive");
  var_4 linkto(var_0);
  var_0.killcament = var_4;
  var_0 explosivehandlemovers(var_1);
  var_0 makeexplosiveusable();
  var_0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.triggerportableradarping, 1);
  onlethalequipmentplanted(var_0);
  var_0 thread ondetonateexplosive();
  var_0 thread func_3343();
  var_0 thread func_66B4(1);
  var_0 thread func_DACC(var_1);
  var_0 thread func_F692(self.team, 20);
  level thread monitordisownedequipment(self, var_0);
}

func_DACC(var_0) {
  self endon("death");
  self endon("disabled");
  var_1 = level.weaponconfigs[self.weapon_name];
  wait(var_1.armingdelay);
  self playLoopSound("ied_explo_beeps");
  thread doblinkinglight("tag_fx");
  var_2 = self.origin * (1, 1, 0);
  var_3 = var_1.detectionheight / 2;
  var_4 = self.origin[2] - var_3;
  var_2 = var_2 + (0, 0, var_4);
  var_5 = spawn("trigger_radius", var_2, 0, var_1.detectionradius, var_1.detectionheight);
  var_5.triggerportableradarping = self;
  if(isDefined(var_0)) {
    var_5 enablelinkto();
    var_5 linkto(self);
  }

  self.damagearea = var_5;
  thread deleteondeath(var_5);
  var_6 = undefined;
  for(;;) {
    var_5 waittill("trigger", var_6);
    if(!isDefined(var_6)) {
      continue;
    }

    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.triggerportableradarping)) {
        if(var_6 == self.triggerportableradarping) {
          continue;
        }

        if(isDefined(var_6.triggerportableradarping) && var_6.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.triggerportableradarping, var_6, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_6 getentityvelocity()) < 10) {
      continue;
    }

    if(var_6 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self stoploopsound("ied_explo_beeps");
  self playSound("ied_warning");
  explosivetrigger(var_6, var_1.detectiongraceperiod, "proxExplosive");
  self notify("detonateExplosive");
}

func_DACB() {
  self endon("death");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("disabled");
    func_DACA();
    wait(var_1);
    if(isDefined(self)) {
      self.disabled = undefined;
      self notify("enabled");
      var_2 = self getlinkedparent();
      thread func_DACC(var_2);
    }
  }
}

func_DACA() {
  stopblinkinglight();
  if(isDefined(self.damagearea)) {
    self.damagearea delete();
  }
}

func_F692(var_0, var_1) {
  self endon("death");
  wait(0.05);
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon(var_0, (0, 0, var_1));
    return;
  }

  if(isDefined(self.triggerportableradarping)) {
    scripts\mp\entityheadicons::setplayerheadicon(self.triggerportableradarping, (0, 0, var_1));
  }
}

claymoreused(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 hide();
  var_0 scripts\engine\utility::waittill_any_timeout_1(0.05, "missile_stuck");
  if(!isDefined(self) || !isalive(self)) {
    var_0 delete();
    return;
  }

  var_1 = 60;
  var_2 = (0, 0, 4);
  var_3 = distancesquared(self.origin, var_0.origin);
  var_4 = distancesquared(self getEye(), var_0.origin);
  var_3 = var_3 + 600;
  var_5 = var_0 getlinkedparent();
  if(isDefined(var_5)) {
    var_0 unlink();
  }

  if(var_3 < var_4) {
    if(var_1 * var_1 < distancesquared(var_0.origin, self.origin)) {
      var_6 = bulletTrace(self.origin, self.origin - (0, 0, var_1), 0, self);
      if(var_6["fraction"] == 1) {
        var_0 delete();
        self setweaponammostock(var_0.weapon_name, self getweaponammostock(var_0.weapon_name) + 1);
        return;
      } else {
        var_0.origin = var_6["position"];
        var_5 = var_6["entity"];
      }
    }
  } else if(var_1 * var_1 < distancesquared(var_0.origin, self getEye())) {
    var_6 = bulletTrace(self.origin, self.origin - (0, 0, var_1), 0, self);
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
  var_0 explosivehandlemovers(var_5);
  var_0 show();
  var_0 makeexplosiveusable();
  var_0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.triggerportableradarping, 1);
  onlethalequipmentplanted(var_0, "power_claymore");
  var_0 thread ondetonateexplosive();
  var_0 thread func_3343();
  var_0 thread func_66B4(1);
  var_0 thread claymoredetonation(var_5);
  var_0 thread func_F692(self.pers["team"], 20);
  level thread monitordisownedequipment(self, var_0);
}

claymoredetonation(var_0) {
  self endon("death");
  var_1 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);
  if(isDefined(var_0)) {
    var_1 enablelinkto();
    var_1 linkto(var_0);
  }

  thread deleteondeath(var_1);
  for(;;) {
    var_1 waittill("trigger", var_2);
    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.triggerportableradarping)) {
        if(var_2 == self.triggerportableradarping) {
          continue;
        }

        if(isDefined(var_2.triggerportableradarping) && var_2.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.triggerportableradarping, var_2, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_2 getentityvelocity()) < 10) {
      continue;
    }

    var_3 = abs(var_2.origin[2] - self.origin[2]);
    if(var_3 > 128) {
      continue;
    }

    if(!var_2 shouldaffectclaymore(self)) {
      continue;
    }

    if(var_2 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self playSound("claymore_activated");
  explosivetrigger(var_2, level.claymoredetectiongraceperiod, "claymore");
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("claymore_destroyed", undefined, undefined, self.origin);
  }

  self notify("detonateExplosive");
}

shouldaffectclaymore(var_0) {
  if(isDefined(var_0.disabled)) {
    return 0;
  }

  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);
  if(var_4 < level.claymoredetectionmindist) {
    return 0;
  }

  var_2 = vectornormalize(var_2);
  var_5 = vectordot(var_2, var_3);
  return var_5 > level.claymoredetectiondot;
}

deleteondeath(var_0) {
  self waittill("death");
  wait(0.05);
  if(isDefined(var_0)) {
    if(isDefined(var_0.trigger)) {
      var_0.trigger delete();
    }

    var_0 delete();
  }
}

c4activate() {
  self endon("death");
  self waittill("missile_stuck", var_0);
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
  var_0 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;
      while(self usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
        continue;
      }

      var_0 = 0;
      while(!self usebuttonpressed() && var_0 < 0.5) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
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

watchc4detonation(var_0) {
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
    var_0 = self getcurrentweapon();
    if(var_0 != "c4_mp") {
      c4detonateallcharges();
    }
  }
}

c4detonateallcharges() {
  foreach(var_1 in self.plantedlethalequip) {
    if(isDefined(var_1) && var_1.weapon_name == "c4_mp") {
      var_1 thread waitanddetonate(0.1);
    }
  }

  self.plantedlethalequip = [];
  self notify("c4_update", 0);
  self notify("detonated");
}

waitanddetonate(var_0) {
  self endon("death");
  wait(var_0);
  waittillenabled();
  self notify("detonateExplosive");
}

func_3343() {
  self endon("death");
  self endon("detonated");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  var_1 = 1;
  if(self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_1++;
  }

  for(;;) {
    self waittill("damage", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!isplayer(var_0) && !isagent(var_0)) {
      continue;
    }

    if(!friendlyfirecheck(self.triggerportableradarping, var_0)) {
      continue;
    }

    if(func_66AA(var_0A, var_5)) {
      continue;
    }

    var_0B = scripts\engine\utility::ter_op(scripts\mp\utility::isfmjdamage(var_0A, var_5), 2, 1);
    var_1 = var_1 - var_0B;
    if(var_1 <= 0) {
      break;
    }

    if(var_1 <= 0) {
      break;
    } else {
      var_0 scripts\mp\damagefeedback::updatedamagefeedback("bouncing_betty");
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
  if(isDefined(var_5) && issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE")) {
    self.waschained = 1;
  }

  if(isDefined(var_9) && var_9 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_9) && var_9 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;
  if(isDefined(var_0)) {
    self.damagedby = var_0;
  }

  if(isplayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback("c4");
    if(var_0 != self.triggerportableradarping && var_0.team != self.triggerportableradarping.team) {
      if(var_0A != "trophy_mp") {
        var_0 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
      }
    }
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self.triggerportableradarping)) {
      var_0C = var_0.pers["team"];
      var_0D = self.triggerportableradarping.pers["team"];
      if(isDefined(var_0C) && isDefined(var_0D) && var_0C != var_0D) {
        var_0 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.triggerportableradarping) && isDefined(var_0) && var_0 != self.triggerportableradarping) {
    var_0 notify("destroyed_equipment");
  }

  if(getdvarint("showArchetypes", 0) > 0) {
    if(self.weapon_name == "c4_mp") {
      self.triggerportableradarping notify("c4_update", 0);
    }
  }

  self notify("detonateExplosive", var_0);
}

resetc4explodethisframe() {
  wait(0.05);
  level.c4explodethisframe = 0;
}

func_EB82(var_0, var_1) {
  for(var_2 = 0; var_2 < 60; var_2++) {
    wait(0.05);
  }
}

waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }

  self waittill("enabled");
}

func_3347(var_0) {
  self waittill("activated");
  var_1 = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  var_1.var_53B1 = "trigger" + gettime() + randomint(1000000);
  var_1.triggerportableradarping = self;
  var_1 thread func_53B0(level.otherteam[var_0]);
  self waittill("death");
  var_1 notify("end_detection");
  if(isDefined(var_1.var_2C65)) {
    var_1.var_2C65 destroy();
  }

  var_1 delete();
}

claymoredetectiontrigger(var_0) {
  var_1 = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  var_1.var_53B1 = "trigger" + gettime() + randomint(1000000);
  var_1.triggerportableradarping = self;
  var_1 thread func_53B0(level.otherteam[var_0]);
  self waittill("death");
  var_1 notify("end_detection");
  if(isDefined(var_1.var_2C65)) {
    var_1.var_2C65 destroy();
  }

  var_1 delete();
}

func_53B0(var_0) {
  self endon("end_detection");
  level endon("game_ended");
  while(!level.gameended) {
    self waittill("trigger", var_1);
    if(!var_1.var_53AD) {
      continue;
    }

    if(level.teambased && var_1.team != var_0) {
      continue;
    } else if(!level.teambased && var_1 == self.triggerportableradarping.triggerportableradarping) {
      continue;
    }

    if(isDefined(var_1.var_2C67[self.var_53B1])) {
      continue;
    }

    var_1 thread showheadicon(self);
  }
}

monitordisownedequipment(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  var_1 deleteexplosive();
}

monitordisownedgrenade(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("mine_planted");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

isplantedequipment(var_0) {
  return isDefined(level.mines[var_0 getentitynumber()]) || scripts\mp\utility::istrue(var_0.planted);
}

func_7F9A(var_0) {
  var_1 = 0;
  var_2 = scripts\mp\powers::getcurrentequipment("primary");
  if(isDefined(var_2)) {
    var_1 = var_1 + scripts\mp\powers::func_D736(var_2);
    if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
      var_1++;
    }
  }

  return var_1;
}

func_7FA3(var_0) {
  var_1 = 0;
  var_2 = scripts\mp\powers::getcurrentequipment("secondary");
  if(isDefined(var_2)) {
    var_1 = var_1 + scripts\mp\powers::func_D736(var_2);
    if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
      var_1++;
    }
  }

  return var_1;
}

onlethalequipmentplanted(var_0, var_1, var_2) {
  var_0.var_D77A = var_1;
  var_0.var_51B6 = var_2;
  var_0.planted = 1;
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);
    if(self.plantedlethalequip.size && self.plantedlethalequip.size >= func_7F9A(self)) {
      self.plantedlethalequip[0] deleteexplosive();
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var_0;
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("mine_planted");
}

ontacticalequipmentplanted(var_0, var_1, var_2) {
  var_0.var_D77A = var_1;
  var_0.var_51B6 = var_2;
  var_0.planted = 1;
  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
    if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= func_7FA3(self)) {
      self.plantedtacticalequip[0] deleteexplosive();
    }
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = var_0;
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("mine_planted");
}

func_5608() {
  if(isDefined(self.plantedlethalequip) && self.plantedlethalequip.size > 0) {
    foreach(var_1 in self.plantedlethalequip) {
      if(isDefined(var_1.trigger) && isDefined(var_1.triggerportableradarping)) {
        var_1.trigger disableplayeruse(var_1.triggerportableradarping);
      }
    }
  }

  if(isDefined(self.plantedtacticalequip) && self.plantedtacticalequip.size > 0) {
    foreach(var_1 in self.plantedtacticalequip) {
      if(isDefined(var_1.trigger) && isDefined(var_1.triggerportableradarping)) {
        var_1.trigger disableplayeruse(var_1.triggerportableradarping);
      }
    }
  }
}

cleanupequipment(var_0, var_1, var_2, var_3) {
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

  if(isDefined(var_0)) {
    level.mines[var_0] = undefined;
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

deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }

  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var_0 = self getentitynumber();
  level.mines[var_0] = undefined;
  if(isDefined(self.var_51B6)) {
    self thread[[self.var_51B6]]();
    self notify("deleted_equipment");
    return;
  }

  var_1 = self.killcament;
  var_2 = self.trigger;
  var_3 = self.sensor;
  cleanupequipment(var_0, var_1, var_2, var_3);
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
  var_0 = self getentitynumber();
  var_1 = self.killcament;
  var_2 = self.trigger;
  var_3 = self.sensor;
  self waittill("death");
  cleanupequipment(var_0, var_1, var_2, var_3);
}

makeexplosiveusable(var_0) {
  self setotherent(self.triggerportableradarping);
  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = spawn("script_origin", self.origin + var_0 * anglestoup(self.angles));
  var_1 linkto(self);
  self.trigger = var_1;
  var_1.triggerportableradarping = self;
  thread makeexplosiveusableinternal();
  return var_1;
}

makeexplosiveusableinternal() {
  self endon("makeExplosiveUnusable");
  var_0 = self.trigger;
  watchexplosiveusable();
  if(isDefined(self)) {
    var_0 = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  var_0 = self.trigger;
  self.trigger = undefined;
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

watchexplosiveusable() {
  var_0 = self.triggerportableradarping;
  var_1 = self.trigger;
  self endon("death");
  var_1 endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 setcursorhint("HINT_NOICON");
  var_1 scripts\mp\utility::setselfusable(var_0);
  var_1 childthread scripts\mp\utility::notusableforjoiningplayers(var_0);
  switch (self.weapon_name) {
    case "c4_mp":
      var_1 sethintstring(&"MP_PICKUP_C4");
      break;

    case "cryo_mine_mp":
      var_1 sethintstring(&"MP_PICKUP_CRYO_MINE");
      break;

    case "trip_mine_mp":
      var_1 sethintstring(&"MP_PICKUP_TRIP_MINE");
      break;

    case "trophy_mp":
      var_1 sethintstring(&"MP_PICKUP_TROPHY");
      break;
  }

  for(;;) {
    var_1 waittillmatch(var_0, "trigger");
    if(isDefined(self.weapon_name)) {
      switch (self.weapon_name) {
        case "trophy_mp":
          thread scripts\mp\trophy_system::func_12818();
          break;
      }

      var_0 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_0 playlocalsound("scavenger_pack_pickup");
    var_0 notify("scavenged_ammo", self.weapon_name);
    thread deleteexplosive();
  }
}

makeexplosiveusabletag(var_0, var_1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_2 = self.triggerportableradarping;
  var_3 = self.weapon_name;
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    self grenade_earthquake(1);
  } else {
    self setcursorhint("HINT_NOICON");
  }

  self _meth_84A7(var_0);
  switch (var_3) {
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

  scripts\mp\utility::setselfusable(var_2);
  childthread scripts\mp\utility::notusableforjoiningplayers(var_2);
  for(;;) {
    self waittillmatch(var_2, "trigger");
    if(isDefined(var_3)) {
      switch (var_3) {
        case "trophy_mp":
          thread scripts\mp\trophy_system::func_12818();
          break;
      }

      var_2 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_2 playlocalsound("scavenger_pack_pickup");
    var_2 notify("scavenged_ammo", var_3);
    thread deleteexplosive();
  }
}

makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

explosivehandlemovers(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.linkparent = var_0;
  var_2.deathoverridecallback = ::movingplatformdetonate;
  var_2.endonstring = "death";
  if(!isDefined(var_1) || !var_1) {
    var_2.invalidparentoverridecallback = ::scripts\mp\movers::moving_platform_empty_func;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_2);
}

explosivetrigger(var_0, var_1, var_2) {
  if(isplayer(var_0) && var_0 scripts\mp\utility::_hasperk("specialty_delaymine")) {
    var_0 thread scripts\mp\missions::func_127BC();
    var_0 notify("triggeredExpl", var_2);
    var_1 = level.delayminetime;
  }

  wait(var_1);
}

func_FA95() {
  self.var_2C67 = [];
  if(self.var_53AD && !self.var_2C66.size) {
    for(var_0 = 0; var_0 < 4; var_0++) {
      self.var_2C66[var_0] = newclienthudelem(self);
      self.var_2C66[var_0].x = 0;
      self.var_2C66[var_0].y = 0;
      self.var_2C66[var_0].var_3A6 = 0;
      self.var_2C66[var_0].alpha = 0;
      self.var_2C66[var_0].archived = 1;
      self.var_2C66[var_0] setshader("waypoint_bombsquad", 14, 14);
      self.var_2C66[var_0] setwaypoint(0, 0);
      self.var_2C66[var_0].var_53B1 = "";
    }

    return;
  }

  if(!self.var_53AD) {
    for(var_0 = 0; var_0 < self.var_2C66.size; var_0++) {
      self.var_2C66[var_0] destroy();
    }

    self.var_2C66 = [];
  }
}

showheadicon(var_0) {
  var_1 = var_0.var_53B1;
  var_2 = -1;
  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = self.var_2C66[var_3].var_53B1;
    if(var_4 == var_1) {
      return;
    }

    if(var_4 == "") {
      var_2 = var_3;
    }
  }

  if(var_2 < 0) {
    return;
  }

  self.var_2C67[var_1] = 1;
  self.var_2C66[var_2].x = var_0.origin[0];
  self.var_2C66[var_2].y = var_0.origin[1];
  self.var_2C66[var_2].var_3A6 = var_0.origin[2] + 24 + 128;
  self.var_2C66[var_2] fadeovertime(0.25);
  self.var_2C66[var_2].alpha = 1;
  self.var_2C66[var_2].var_53B1 = var_0.var_53B1;
  while(isalive(self) && isDefined(var_0) && self istouching(var_0)) {
    wait(0.05);
  }

  if(!isDefined(self)) {
    return;
  }

  self.var_2C66[var_2].var_53B1 = "";
  self.var_2C66[var_2] fadeovertime(0.25);
  self.var_2C66[var_2].alpha = 0;
  self.var_2C67[var_1] = undefined;
}

getdamageableents(var_0, var_1, var_2, var_3) {
  var_4 = [];
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = var_1 * var_1;
  var_6 = level.players;
  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7].sessionstate != "playing") {
      continue;
    }

    var_8 = scripts\mp\utility::func_7921(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);
    if(var_9 < var_5 && !var_2 || func_13C7E(var_0, var_8, var_3, var_6[var_7])) {
      var_4[var_4.size] = ::scripts\mp\utility::func_7920(var_6[var_7], var_8);
    }
  }

  var_0A = getEntArray("grenade", "classname");
  for(var_7 = 0; var_7 < var_0A.size; var_7++) {
    var_0B = scripts\mp\utility::func_791E(var_0A[var_7]);
    var_9 = distancesquared(var_0, var_0B);
    if(var_9 < var_5 && !var_2 || func_13C7E(var_0, var_0B, var_3, var_0A[var_7])) {
      var_4[var_4.size] = ::scripts\mp\utility::func_791D(var_0A[var_7], var_0B);
    }
  }

  var_0C = getEntArray("destructible", "targetname");
  for(var_7 = 0; var_7 < var_0C.size; var_7++) {
    var_0B = var_0C[var_7].origin;
    var_9 = distancesquared(var_0, var_0B);
    if(var_9 < var_5 && !var_2 || func_13C7E(var_0, var_0B, var_3, var_0C[var_7])) {
      var_0D = spawnStruct();
      var_0D.isplayer = 0;
      var_0D.var_9D26 = 0;
      var_0D.issplitscreen = var_0C[var_7];
      var_0D.damagecenter = var_0B;
      var_4[var_4.size] = var_0D;
    }
  }

  var_0E = getEntArray("destructable", "targetname");
  for(var_7 = 0; var_7 < var_0E.size; var_7++) {
    var_0B = var_0E[var_7].origin;
    var_9 = distancesquared(var_0, var_0B);
    if(var_9 < var_5 && !var_2 || func_13C7E(var_0, var_0B, var_3, var_0E[var_7])) {
      var_0D = spawnStruct();
      var_0D.isplayer = 0;
      var_0D.var_9D26 = 1;
      var_0D.issplitscreen = var_0E[var_7];
      var_0D.damagecenter = var_0B;
      var_4[var_4.size] = var_0D;
    }
  }

  var_0F = getEntArray("misc_turret", "classname");
  foreach(var_11 in var_0F) {
    var_0B = var_11.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_0B);
    if(var_9 < var_5 && !var_2 || func_13C7E(var_0, var_0B, var_3, var_11)) {
      switch (var_11.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_remote_turret":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          var_4[var_4.size] = ::scripts\mp\utility::func_7922(var_11, var_0B);
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
    var_9 = distancesquared(var_0, var_0B);
    if(var_9 < var_5 && !var_2 || func_13C7E(var_0, var_0B, var_3, var_15)) {
      var_4[var_4.size] = ::scripts\mp\utility::func_791F(var_15, var_0B);
    }
  }

  return var_4;
}

getempdamageents(var_0, var_1, var_2, var_3) {
  var_4 = [];
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = var_1 * var_1;
  level.mines = scripts\engine\utility::array_removeundefined(level.mines);
  foreach(var_7 in level.mines) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  var_9 = getEntArray("misc_turret", "classname");
  foreach(var_7 in var_9) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.uplinks) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.remote_uav) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.balldrones) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.placedims) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.microturrets) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.var_105EA) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.var_69D6) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.spidergrenade.activeagents) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.spidergrenade.proxies) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.var_2ABD) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.var_590F) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.littlebirds) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.var_D3CC) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3)) {
      var_4[var_4.size] = var_7;
    }
  }

  foreach(var_7 in level.players) {
    if(func_619A(var_7, var_0, var_5, var_2, var_3) && scripts\mp\utility::func_9EF0(var_7)) {
      var_4[var_4.size] = var_7;
    }
  }

  return var_4;
}

func_619A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.origin;
  var_6 = distancesquared(var_1, var_5);
  return var_6 < var_2 && !var_3 || func_13C7E(var_1, var_5, var_4, var_0);
}

func_13C7E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;
  if(lengthsquared(var_5) < var_2 * var_2) {
    return 1;
  }

  var_6 = vectornormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = bulletTrace(var_4, var_1, 0, var_3);
  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread debugprint(var_0, ".dmg");
    if(isDefined(var_3)) {
      thread debugprint(var_1, "." + var_3.classname);
    } else {
      thread debugprint(var_1, ".undefined");
    }

    if(var_7["fraction"] == 1) {
      thread debugline(var_4, var_1, (1, 1, 1));
    } else {
      thread debugline(var_4, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

func_66B4(var_0) {
  self endon("death");
  self waittill("emp_damage", var_1, var_2, var_3, var_4, var_5);
  if(isDefined(var_4) && var_4 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_1))) {
      var_1 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  equipmentempstunvfx();
  if(isDefined(self.triggerportableradarping) && isDefined(var_1) && self.triggerportableradarping != var_1) {
    var_1 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
  }

  if(isDefined(var_0) && var_0) {
    deleteexplosive();
    return;
  }

  self notify("detonateExplosive");
}

damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.var_4D5B = var_5;
    self.issplitscreen thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
    return;
  }

  if(self.var_9D26 && var_4 == "artillery_mp" || var_4 == "claymore_mp" || var_4 == "stealth_bomb_mp") {
    return;
  }

  self.issplitscreen notify("damage", var_2, var_1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_4);
}

debugline(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 600; var_3++) {
    wait(0.05);
  }
}

debugcircle(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 16;
  }

  var_4 = 360 / var_3;
  var_5 = [];
  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_1;
    var_9 = sin(var_7) * var_1;
    var_0A = var_0[0] + var_8;
    var_0B = var_0[1] + var_9;
    var_0C = var_0[2];
    var_5[var_5.size] = (var_0A, var_0B, var_0C);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_0D = var_5[var_6];
    if(var_6 + 1 >= var_5.size) {
      var_0E = var_5[0];
    } else {
      var_0E = var_5[var_6 + 1];
    }

    thread debugline(var_0D, var_0E, var_2);
  }
}

debugprint(var_0, var_1) {
  for(var_2 = 0; var_2 < 600; var_2++) {
    wait(0.05);
  }
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  if(!scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  if(isDefined(var_1) && var_1 != "none") {
    var_1 = getweaponbasename(var_1);
  }

  switch (var_1) {
    case "cluster_grenade_mp":
      if(isDefined(var_0) && scripts\mp\utility::istrue(var_0.shellshockondamage)) {
        scripts\mp\shellshock::shellshockondamage(var_2, var_3);
      }
      break;

    case "concussion_grenade_mp":
      if(var_3 > 0) {
        thread scripts\mp\concussiongrenade::onweapondamage(var_0, var_1, var_2, var_3, var_4);
      }
      break;

    case "blackout_grenade_mp":
      if(var_3 > 0) {
        if(var_2 != "MOD_IMPACT") {
          scripts\mp\equipment\blackout_grenade::func_10D6F(var_0.triggerportableradarping, var_0.origin);
        }
      }
      break;

    case "gltacburst_regen":
    case "venomproj_mp":
    case "cryo_mine_mp":
      if(var_3 > 0) {
        if(var_2 != "MOD_IMPACT") {
          if(isDefined(var_0)) {
            if(isDefined(var_0.streakinfo)) {
              if(scripts\mp\killstreaks\_utility::func_A69F(var_0.streakinfo, "passive_increased_frost")) {
                scripts\mp\equipment\cryo_mine::func_4ACF(var_4, 3);
              } else {
                scripts\mp\equipment\cryo_mine::func_4ACF(var_4);
              }
            } else {
              scripts\mp\equipment\cryo_mine::func_4ACF(var_4);
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
      scripts\mp\equipment\ground_pound::groundpound_victimimpacteffects(var_4, self, var_1, var_0);
      break;

    case "gltacburst_big":
    case "gltacburst":
      if(var_3 > 0) {
        thread scripts\mp\empgrenade::onweapondamage(var_0, var_1, var_2, var_3, var_4);
      }
      break;

    default:
      scripts\mp\shellshock::shellshockondamage(var_2, var_3);
      break;
  }
}

isprimaryweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  switch (weaponclass(var_0)) {
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

isbulletweapon(var_0) {
  if(var_0 == "none" || isriotshield(var_0) || isknifeonly(var_0)) {
    return 0;
  }

  switch (weaponclass(var_0)) {
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

isknifeonly(var_0) {
  return scripts\mp\utility::getweaponrootname(var_0) == "iw7_knife";
}

isballweapon(var_0) {
  return scripts\mp\utility::getweaponrootname(var_0) == "iw7_uplinkball" || scripts\mp\utility::getweaponrootname(var_0) == "iw7_tdefball";
}

isaxeweapon(var_0) {
  return scripts\mp\utility::getweaponrootname(var_0) == "iw7_axe";
}

isaltmodeweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "altmode";
}

func_9E56(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "item";
}

func_9F5D(var_0) {
  return isDefined(var_0) && scripts\mp\utility::getweaponrootname(var_0) == "iw7_emc";
}

isriotshield(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weapontype(var_0) == "riotshield";
}

func_9EC0(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "offhand";
}

func_9F54(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  return weaponclass(var_0) == "pistol";
}

func_9E18(var_0) {
  var_1 = weaponclass(var_0);
  if(var_1 != "grenade") {
    return 0;
  }

  var_2 = weaponinventorytype(var_0);
  if(var_2 != "offhand") {
    return 0;
  }

  return 1;
}

func_9FA9(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return issubstr(var_0, "throwingknife");
}

updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.currentweaponatspawn;
  if(isDefined(self.saved_lastweaponhack)) {
    var_0 = self.saved_lastweaponhack;
  }

  self.saved_lastweapon = var_0;
  self.var_EB6C = var_0;
  for(;;) {
    self waittill("weapon_change", var_1);
    self.var_EB6C = var_1;
    if(var_1 == "none") {
      continue;
    } else if(scripts\mp\utility::issuperweapon(var_1)) {
      updatemovespeedscale();
      continue;
    } else if(scripts\mp\utility::iskillstreakweapon(var_1)) {
      continue;
    } else {
      var_2 = weaponinventorytype(var_1);
      if(var_2 != "primary" && var_2 != "altmode") {
        continue;
      }
    }

    updatemovespeedscale();
    self.saved_lastweapon = var_0;
    var_0 = var_1;
  }
}

empplayer(var_0) {
  self endon("disconnect");
  self endon("death");
  thread func_41AB();
}

func_41AB() {
  self endon("disconnect");
  self waittill("death");
}

_meth_8237() {
  var_0 = 2;
  self.weaponlist = self getweaponslistprimaries();
  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      if(scripts\mp\utility::issuperweapon(var_2)) {
        var_3 = scripts\mp\supers::func_7FD0(var_2);
      } else if(scripts\mp\utility::func_9E0D(var_2)) {
        var_3 = func_7ECD(var_2);
      } else {
        var_3 = _meth_8236(var_2);
      }

      if(!isDefined(var_3) || var_3 == 0) {
        continue;
      }

      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else {
    var_0 = 0.94;
  }

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

_meth_8236(var_0) {
  var_1 = scripts\mp\utility::getweaponrootname(var_0);
  return level.weaponmapdata[var_1].getclosestpointonnavmesh3d;
}

func_7ECD(var_0) {
  return 1;
}

clampweaponspeed(var_0) {
  return clamp(var_0, 0, 1);
}

updateviewkickscale(var_0) {
  if(isDefined(var_0)) {
    self.var_1339E = var_0;
  }

  if(isDefined(self.var_C7E8)) {
    var_0 = self.var_C7E8;
  } else if(scripts\mp\utility::_hasperk("specialty_distance_kit")) {
    var_0 = 0.05;
  } else if(isDefined(self.overrideviewkickscale)) {
    if((weaponclass(self getcurrentweapon()) == "sniper" || issubstr(self getcurrentweapon(), "iw7_udm45_mpl") || issubstr(self getcurrentweapon(), "iw7_longshot_mp")) && isDefined(self.overrideviewkickscalesniper)) {
      var_0 = self.overrideviewkickscalesniper;
    } else {
      var_0 = self.overrideviewkickscale;
    }
  } else if(isDefined(self.var_1339E)) {
    var_0 = self.var_1339E;
  } else {
    var_0 = 1;
  }

  var_0 = clamp(var_0, 0, 1);
  self setviewkickscale(var_0);
}

updatemovespeedscale() {
  var_0 = undefined;
  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1;
    var_0 = var_0 + self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);
    if(isDefined(self.overrideweaponspeed_speedscale)) {
      var_0 = self.overrideweaponspeed_speedscale;
    }

    var_1 = self.chill_data;
    if(isDefined(var_1) && isDefined(var_1.speedmod)) {
      var_0 = var_0 + var_1.speedmod;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var_0 = var_0 + self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var_0 = var_0 + self.weaponpassivespeedonkillmod;
    }

    var_0 = var_0 + scripts\mp\perks\_weaponpassives::passivecolddamagegetspeedmod(self);
    if(isDefined(self.weaponpassivefastrechamberspeedmod)) {
      var_0 = var_0 + self.weaponpassivefastrechamberspeedmod;
    }

    if(isDefined(self.speedonkillmod)) {
      var_0 = var_0 + self.speedonkillmod;
    }
  }

  self.weaponspeed = var_0;
  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  var_0 = var_0 + self.movespeedscaler - 1;
  var_0 = var_0 + self.combatspeedscalar - 1;
  var_0 = clamp(var_0, 0, 1.08);
  if(isDefined(self.fastcrouchspeedmod)) {
    var_0 = var_0 + self.fastcrouchspeedmod;
  }

  self setmovespeedscale(var_0);
}

getplayerspeedbyweapon(var_0) {
  var_1 = 1;
  self.weaponlist = self getweaponslistprimaries();
  if(!self.weaponlist.size) {
    var_1 = 0.94;
  } else {
    var_2 = self getcurrentweapon();
    if(scripts\mp\utility::issuperweapon(var_2)) {
      var_1 = scripts\mp\supers::func_7FD0(var_2);
    } else if(scripts\mp\utility::func_9E0D(var_2)) {
      var_1 = func_7ECD(var_2);
    } else if(scripts\mp\utility::iskillstreakweapon(var_2)) {
      var_1 = 0.94;
    } else if(issubstr(var_2, "iw7_mauler_mpl_damage")) {
      var_1 = 0.87;
    } else if(issubstr(var_2, "iw7_udm45_mpl")) {
      var_1 = 0.95;
    } else if(issubstr(var_2, "iw7_rvn") && self _meth_8519(var_2)) {
      var_1 = 1;
    } else if(issubstr(var_2, "iw7_longshot") && self _meth_8519(var_2)) {
      var_1 = 0.98;
    } else {
      var_3 = weaponinventorytype(var_2);
      if(var_3 != "primary" && var_3 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var_2 = self.saved_lastweapon;
        } else {
          var_2 = undefined;
        }
      }

      if(!isDefined(var_2) || !self hasweapon(var_2)) {
        var_1 = _meth_8237();
      } else {
        var_1 = _meth_8236(var_2);
      }
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
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

    var_0 = self getstance();
    stancerecoilupdate(var_0);
  }
}

stancerecoilupdate(var_0) {
  var_1 = self getcurrentprimaryweapon();
  var_2 = 0;
  if(isrecoilreducingweapon(var_1)) {
    var_2 = getrecoilreductionvalue();
  }

  if(var_0 == "prone") {
    var_3 = scripts\mp\utility::getweapongroup(var_1);
    if(var_3 == "weapon_lmg") {
      scripts\mp\utility::setrecoilscale(0, 0);
      return;
    }

    if(var_3 == "weapon_sniper") {
      if(issubstr(var_1, "barrelbored")) {
        scripts\mp\utility::setrecoilscale(0, 0 + var_2);
        return;
      }

      scripts\mp\utility::setrecoilscale(0, 0 + var_2);
      return;
    }

    scripts\mp\utility::setrecoilscale();
    return;
  }

  if(var_0 == "crouch") {
    var_3 = scripts\mp\utility::getweapongroup(var_1);
    if(var_3 == "weapon_lmg") {
      scripts\mp\utility::setrecoilscale(0, 0);
      return;
    }

    if(var_3 == "weapon_sniper") {
      if(issubstr(var_1, "barrelbored")) {
        scripts\mp\utility::setrecoilscale(0, 0 + var_2);
        return;
      }

      scripts\mp\utility::setrecoilscale(0, 0 + var_2);
      return;
    }

    scripts\mp\utility::setrecoilscale();
    return;
  }

  if(var_2 > 0) {
    scripts\mp\utility::setrecoilscale(0, var_2);
    return;
  }

  scripts\mp\utility::setrecoilscale();
}

semtexused(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.weapon_name)) {
    return;
  }

  var_0.originalowner = self;
  var_0 waittill("missile_stuck", var_1);
  var_0 thread scripts\mp\shellshock::grenade_earthquake();
  if(isplayer(var_1) || isagent(var_1)) {
    grenadestuckto(var_0, var_1);
  }

  var_0 explosivehandlemovers(undefined);
}

turret_monitoruse() {
  for(;;) {
    self waittill("trigger", var_0);
    thread turret_playerthread(var_0);
  }
}

turret_playerthread(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notify("weapon_change", "none");
  self waittill("turret_deactivate");
  var_0 notify("weapon_change", var_0 getcurrentweapon());
}

spawnmine(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = (0, randomfloat(360), 0);
  }

  var_5 = level.weaponconfigs[var_2];
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_4;
  var_6 setModel(var_5.model);
  var_6.triggerportableradarping = var_1;
  var_6 setotherent(var_1);
  var_6.weapon_name = var_2;
  var_6.config = var_5;
  var_6.killcamoffset = (0, 0, 4);
  var_6.killcament = spawn("script_model", var_6.origin + var_6.killcamoffset);
  var_6.killcament setscriptmoverkillcam("explosive");
  var_7 = scripts\mp\utility::getequipmenttype(var_2);
  if(!isDefined(var_7)) {
    var_7 = "lethal";
  }

  if(var_7 == "lethal") {
    var_1 onlethalequipmentplanted(var_6, var_3);
  } else if(var_7 == "tactical") {
    var_1 ontacticalequipmentplanted(var_6, var_3);
  }

  if(isDefined(var_5.bombsquadmodel)) {
    var_6 thread createbombsquadmodel(var_5.bombsquadmodel, "tag_origin", var_1);
  }

  if(isDefined(var_5.mine_beacon)) {
    var_6 thread doblinkinglight("tag_fx", var_5.mine_beacon["friendly"], var_5.mine_beacon["enemy"]);
  }

  var_6 thread func_F692(var_1.pers["team"], var_5.headiconoffset);
  var_8 = undefined;
  if(self != level) {
    var_8 = self getlinkedparent();
  }

  var_6 explosivehandlemovers(var_8);
  var_6 thread mineproximitytrigger(var_8);
  var_6 thread scripts\mp\shellshock::grenade_earthquake();
  var_6 thread mineselfdestruct();
  var_6 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_1, 1);
  var_6 thread mineexplodeonnotify();
  var_6 thread func_66B4(1);
  var_6 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread outlineequipmentforowner(var_6, var_1);
  level thread monitordisownedequipment(var_1, var_6);
  return var_6;
}

func_108E7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = (0, randomfloat(360), 0);
  }

  var_5 = level.weaponconfigs[var_2];
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_4;
  var_6 setModel(var_5.model);
  var_6.triggerportableradarping = var_1;
  var_6 setotherent(var_1);
  var_6.weapon_name = var_2;
  var_6.config = var_5;
  var_1 ontacticalequipmentplanted(var_6, var_3);
  var_6 thread createbombsquadmodel(var_5.bombsquadmodel, "tag_origin", var_1);
  var_6 thread func_F692(var_1.pers["team"], var_5.headiconoffset);
  var_7 = undefined;
  if(self != level) {
    var_7 = self getlinkedparent();
  }

  var_6 explosivehandlemovers(var_7, 1);
  var_6 thread mineproximitytrigger(var_7);
  var_6 thread scripts\mp\shellshock::grenade_earthquake();
  var_6 thread func_BBC4();
  var_6 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_1);
  var_6 thread func_B77D();
  level thread monitordisownedequipment(var_1, var_6);
  return var_6;
}

func_108E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = (0, randomfloat(360), 0);
  }

  var_7 = level.weaponconfigs[var_2];
  var_8 = spawn("script_model", var_0);
  var_8.angles = var_4;
  var_8 setModel(var_7.model);
  var_8.triggerportableradarping = var_1;
  var_8 setotherent(var_1);
  var_8.weapon_name = var_2;
  var_8.config = var_7;
  if(isDefined(var_5)) {
    var_8.var_AC75 = var_5;
  } else {
    var_8.var_AC75 = 45;
  }

  var_1 ontacticalequipmentplanted(var_8, var_3);
  var_8 thread createbombsquadmodel(var_7.bombsquadmodel, "tag_origin", var_1);
  var_8 thread func_F692(var_1.pers["team"], var_7.headiconoffset);
  var_9 = undefined;
  if(self != level) {
    var_9 = self getlinkedparent();
  }

  var_8 explosivehandlemovers(var_9, 1);
  var_8 thread mineproximitytrigger(var_9);
  var_8 thread scripts\mp\shellshock::grenade_earthquake();
  var_8 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var_1);
  var_8 thread func_B8F6();
  level thread monitordisownedequipment(var_1, var_8);
  var_8 thread func_D501();
  var_8 thread func_139F0();
  if(isDefined(var_6) && var_6) {
    var_8 makeexplosiveusable();
    var_8 thread minedamagemonitor();
  }

  return var_8;
}

func_139F5() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self waittill("missile_stuck");
  thread func_E845(var_0, self.origin);
}

func_E845(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_1, 0, 128, 135);
  var_2.triggerportableradarping = var_0;
  var_3 = 128;
  var_4 = spawnfx(scripts\engine\utility::getfx("distortion_field_cloud"), var_1);
  triggerfx(var_4);
  var_5 = 8;
  foreach(var_7 in level.players) {
    var_7.var_9E44 = 0;
    var_7 thread func_20C2(var_2);
  }

  while(var_5 > 0) {
    foreach(var_7 in level.players) {
      if(var_7 istouching(var_2) && !var_7.var_9E44) {
        var_7 thread func_20C2(var_2);
      }
    }

    wait(0.2);
    var_5 = var_5 - 0.2;
  }

  foreach(var_7 in level.players) {
    var_7 notify("distortion_field_ended");
    foreach(var_0E in level.players) {
      var_7 showtoplayer(var_0E);
    }
  }

  var_4 delete();
  self delete();
  wait(2);
  var_2 delete();
}

func_20C2(var_0) {
  self endon("death");
  self endon("disconnect");
  while(isDefined(var_0) && self istouching(var_0) && !scripts\mp\killstreaks\_emp_common::isemped()) {
    self setblurforplayer(4, 1);
    self.var_9E44 = 1;
    thread func_B9CF();
    foreach(var_2 in level.players) {
      self hidefromplayer(var_2);
    }

    scripts\engine\utility::waittill_any_timeout_1(1.4, "emp_damage");
    foreach(var_2 in level.players) {
      self showtoplayer(var_2);
    }

    wait(0.1);
  }

  self setblurforplayer(0, 0.25);
  self.var_9E44 = 0;
  foreach(var_2 in level.players) {
    var_2 showtoplayer(var_2);
  }
}

func_B9CF() {
  self endon("distortion_field_ended");
  var_0 = 0;
  while(!var_0) {
    var_0 = scripts\mp\killstreaks\_emp_common::isemped();
    scripts\engine\utility::waitframe();
  }

  self notify("emp_damage");
}

func_10910(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = (0, randomfloat(360), 0);
  }

  var_5 = level.weaponconfigs[var_2];
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_4;
  var_6 setModel(var_5.model);
  var_6.triggerportableradarping = var_1;
  var_6 setotherent(var_1);
  var_6.weapon_name = var_2;
  var_6.config = var_5;
  var_1 ontacticalequipmentplanted(var_6, var_3);
  var_6 thread createbombsquadmodel(var_5.bombsquadmodel, "tag_origin", var_1);
  var_6 thread func_F692(var_1.pers["team"], var_5.headiconoffset);
  var_6 thread func_10413(var_1, var_6, var_6.weapon_name);
  var_6.var_AC75 = 15;
  var_6 thread func_139F0(0);
  var_1 notify("sonic_sensor_used");
  var_7 = undefined;
  if(self != level) {
    var_7 = self getlinkedparent();
  }

  var_6 explosivehandlemovers(var_7, 1);
  var_6 thread scripts\mp\shellshock::grenade_earthquake();
  var_6 thread func_BBC4();
  var_6 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var_1);
  var_6 thread func_B77D();
  var_6 thread func_10412();
  level thread monitordisownedequipment(var_1, var_6);
  return var_6;
}

func_10412() {
  scripts\engine\utility::waittill_any_3("death", "mine_destroyed");
  self.triggerportableradarping notify("sonic_sensor_update");
  foreach(var_1 in self.triggerportableradarping.plantedtacticalequip) {
    if(isDefined(var_1) && var_1.weapon_name == "sonic_sensor_mp") {
      var_1 deleteexplosive();
      scripts\engine\utility::array_remove(self.triggerportableradarping.plantedtacticalequip, var_1);
    }
  }
}

func_139F0(var_0) {
  self endon("death");
  while(self.var_AC75 > 0) {
    self.var_AC75--;
    wait(1);
  }

  self playSound(self.config.onexplodesfx);
  var_1 = self gettagorigin("tag_origin");
  playFX(self.config.onexplodevfx, var_1);
  if(isDefined(self.config.var_127BF)) {
    self.config.var_127BF.var_DBD8 = undefined;
    self.config.var_127BF = undefined;
  }

  if(!isDefined(var_0) || var_0) {
    self getplayermodelname();
  }

  deleteexplosive();
}

func_66AA(var_0, var_1) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "cryo_mine_mp":
        return 1;
    }

    if(var_1 == "MOD_IMPACT") {
      switch (var_0) {
        case "trip_mine_mp":
        case "splash_grenade_mp":
        case "c4_mp":
          return 1;
      }
    } else {
      switch (var_0) {
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
    foreach(var_1 in level.grenades) {
      if(isDefined(var_1) && !scripts\mp\utility::istrue(var_1.exploding) && !isplantedequipment(var_1)) {
        var_1 delete();
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_4 in level.missiles) {
      if(isDefined(var_4) && !scripts\mp\utility::istrue(var_4.exploding) && !isplantedequipment(var_4)) {
        var_4 delete();
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
  var_0 = undefined;
  var_1 = self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  var_2 = scripts\engine\utility::ter_op(var_1, 2, 1);
  var_3 = scripts\engine\utility::ter_op(var_1, "hitequip", "");
  for(;;) {
    self waittill("damage", var_4, var_0, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
    var_0C = scripts\mp\utility::func_13CA1(var_0C, var_10);
    if(!isplayer(var_0) && !isagent(var_0)) {
      continue;
    }

    if(isDefined(var_0C) && isendstr(var_0C, "betty_mp")) {
      continue;
    }

    if(!friendlyfirecheck(self.triggerportableradarping, var_0)) {
      continue;
    }

    if(isballweapon(var_0C)) {
      continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
      continue;
    }

    if(func_66AA(var_0C, var_7)) {
      continue;
    }

    var_11 = scripts\engine\utility::ter_op(scripts\mp\utility::isfmjdamage(var_0C, var_7) || var_4 >= 80, 2, 1);
    var_2 = var_2 - var_11;
    scripts\mp\powers::equipmenthit(self.triggerportableradarping, var_0, var_0C, var_7);
    if(var_2 <= 0) {
      break;
    } else {
      var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_3);
    }
  }

  self notify("mine_destroyed");
  if(isDefined(var_7) && issubstr(var_7, "MOD_GRENADE") || issubstr(var_7, "MOD_EXPLOSIVE")) {
    self.waschained = 1;
  }

  if(isDefined(var_0B) && var_0B &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_0B) && var_0B &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;
  if(isDefined(var_0)) {
    self.damagedby = var_0;
  }

  if(isDefined(self.killcament)) {
    self.killcament.damagedby = var_0;
  }

  if(isplayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_3);
    if(var_0 != self.triggerportableradarping && var_0.team != self.triggerportableradarping.team) {
      var_0 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    }
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(var_0.pers["team"]) && isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.pers["team"])) {
      if(var_0.pers["team"] != self.triggerportableradarping.pers["team"]) {
        var_0 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.triggerportableradarping) && isDefined(var_0) && var_0 != self.triggerportableradarping) {
    var_0 notify("destroyed_equipment");
  }

  scripts\mp\missions::minedestroyed(self, var_0, var_7);
  self notify("detonateExplosive", var_0);
}

mineproximitytrigger(var_0, var_1) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_2 = self.config;
  wait(var_2.armtime);
  if(isDefined(var_2.mine_beacon)) {
    thread doblinkinglight("tag_fx", var_2.mine_beacon["friendly"], var_2.mine_beacon["enemy"]);
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_2.minedetectionradius), var_2.minedetectionradius, level.minedetectionradius);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2.minedetectionheight), var_2.minedetectionheight, level.minedetectionheight);
  var_5 = spawn("trigger_radius", self.origin, 0, var_3, var_4);
  var_5.triggerportableradarping = self;
  thread minedeletetrigger(var_5);
  if(isDefined(var_0)) {
    var_5 enablelinkto();
    var_5 linkto(var_0);
  }

  self.damagearea = var_5;
  var_6 = undefined;
  for(;;) {
    var_5 waittill("trigger", var_6);
    if(!isDefined(var_6)) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_6)) {
      continue;
    }

    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.triggerportableradarping)) {
        if(var_6 == self.triggerportableradarping) {
          continue;
        }

        if(isDefined(var_6.triggerportableradarping) && var_6.triggerportableradarping == self.triggerportableradarping) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.triggerportableradarping, var_6, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_6 getentityvelocity()) < 10) {
      continue;
    }

    if(self.weapon_name == "mobile_radar_mp" && !func_B8F7(var_6)) {
      continue;
    }

    if((isDefined(var_1) && var_1) || var_6 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self.config.var_127BF = var_6;
  if(isDefined(self.config.ontriggeredsfx)) {
    self playSound(self.config.ontriggeredsfx);
  }

  explosivetrigger(var_6, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(var_0) {
  scripts\engine\utility::waittill_any_3("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_BBC4() {
  self endon("mine_triggered");
  self endon("death");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    equipmentempstunvfx();
    stopblinkinglight();
    if(isDefined(self.damagearea)) {
      self.damagearea delete();
    }

    self.disabled = 1;
    self notify("disabled");
    wait(var_1);
    if(isDefined(self)) {
      self.disabled = undefined;
      self notify("enabled");
      var_2 = self getlinkedparent();
      thread mineproximitytrigger(var_2);
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

  var_0 = self.origin + (0, 0, 64);
  self moveto(var_0, 0.7, 0, 0.65);
  self.killcament moveto(var_0 + self.killcamoffset, 0.7, 0, 0.65);
  self rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  thread playspinnerfx();
  wait(0.65);
  self notify("detonateExplosive");
}

mineexplodeonnotify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = self.triggerportableradarping;
  }

  var_1 = self.config;
  var_2 = var_1.vfxtag;
  if(!isDefined(var_2)) {
    var_2 = "tag_fx";
  }

  var_3 = self gettagorigin(var_2);
  if(!isDefined(var_3)) {
    var_3 = self gettagorigin("tag_origin");
  }

  self notify("explode", var_3);
  wait(0.05);
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  self hide();
  if(isDefined(var_1.onexplodefunc)) {
    self thread[[var_1.onexplodefunc]]();
  }

  if(isDefined(var_1.onexplodesfx)) {
    self playSound(var_1.onexplodesfx);
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1.onexplodevfx), var_1.onexplodevfx, level.mine_explode);
  playFX(var_4, var_3);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);
  if(var_6 > 0) {
    self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "MOD_EXPLOSIVE", self.weapon_name);
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
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel(self.config.model);
  var_0 hidepart("tag_base");
  var_0.config = self.config;
  self.sensor = var_0;
  var_1 = self.origin + (0, 0, self.config.launchheight);
  var_2 = self.config.launchtime;
  var_3 = self.config.launchtime + 0.1;
  var_0 moveto(var_1, var_3, 0, var_2);
  var_0 rotatevelocity((0, 1100, 32), var_3, 0, var_2);
  var_0 thread playspinnerfx();
  wait(var_2);
  self notify("detonateExplosive");
}

func_B77D() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = self.triggerportableradarping;
  }

  self playSound(self.config.onexplodesfx);
  var_1 = undefined;
  if(isDefined(self.sensor)) {
    var_1 = self.sensor gettagorigin("tag_sensor");
  } else {
    var_1 = self gettagorigin("tag_origin");
  }

  playFX(self.config.onexplodevfx, var_1);
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
  var_2 = [];
  foreach(var_4 in level.characters) {
    if(var_4.team == self.triggerportableradarping.team) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_4)) {
      continue;
    }

    if(var_4 scripts\mp\utility::_hasperk("specialty_heartbreaker")) {
      continue;
    }

    if(distance2d(self.origin, var_4.origin) < 300) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_7 in var_2) {
    thread func_B37F(var_7, self.triggerportableradarping);
    level thread func_F236(var_7, self.triggerportableradarping);
  }

  if(var_2.size > 0) {
    self.triggerportableradarping scripts\mp\missions::processchallenge("ch_motiondetected", var_2.size);
    self.triggerportableradarping thread scripts\mp\gamelogic::threadedsetweaponstatbyname("motion_sensor", 1, "hits");
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
  }

  wait(0.2);
  deleteexplosive();
}

func_B37F(var_0, var_1) {
  if(var_0 == var_1) {
    return;
  }

  var_0 endon("disconnect");
  var_2 = undefined;
  if(level.teambased) {
    var_2 = scripts\mp\utility::outlineenableforteam(var_0, "orange", var_1.team, 0, 0, "equipment");
  } else {
    var_2 = scripts\mp\utility::outlineenableforplayer(var_0, "orange", var_1, 0, 0, "equipment");
  }

  var_0 thread scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  scripts\mp\gamescore::func_11ACE(var_1, var_0, "motion_sensor_mp");
  var_0 scripts\engine\utility::waittill_any_timeout_1(self.config.var_B371, "death");
  scripts\mp\gamescore::untrackdebuffassist(var_1, var_0, "motion_sensor_mp");
  scripts\mp\utility::outlinedisable(var_2, var_0);
}

func_F236(var_0, var_1) {
  if(var_0 == var_1) {
    return;
  }

  if(isai(var_0)) {
    return;
  }

  var_2 = "coup_sunblind";
  var_0 setclientomnvar("ui_hud_shake", 1);
  var_0 visionsetnakedforplayer(var_2, 0.05);
  wait(0.05);
  var_0 visionsetnakedforplayer(var_2, 0);
  var_0 visionsetnakedforplayer("", 0.5);
}

func_B8F5() {
  self playSound(self.config.onlaunchsfx);
  playFX(self.config.launchvfx, self.origin);
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  stopblinkinglight();
  var_0 = self.origin + (0, 0, self.config.launchheight);
  var_1 = self.config.launchtime;
  var_2 = self.config.launchtime + 0.1;
  self moveto(var_0, var_2, 0, var_1);
  self rotatevelocity((0, 1100, 32), var_2, 0, var_1);
  thread playspinnerfx();
  wait(var_1);
  self notify("detonateExplosive");
}

func_B8F6() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = self.triggerportableradarping;
  }

  self playSound(self.config.onexplodesfx);
  var_1 = self gettagorigin("tag_origin");
  playFX(self.config.onexplodevfx, var_1);
  scripts\engine\utility::waitframe();
  if(!isDefined(self) || !isDefined(self.triggerportableradarping)) {
    return;
  }

  if(isDefined(self.config.var_127BF)) {
    var_2 = self.config.var_127BF;
    var_2.var_DBD8 = 1;
    var_2 func_10DC5(self);
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
    self.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
  }

  wait(0.2);
  deleteexplosive();
}

func_10DC5(var_0) {
  var_1 = self gettagorigin("tag_shield_back");
  var_2 = spawn("script_model", var_1);
  var_2 setModel("weapon_mobile_radar_back");
  var_2.var_AC75 = var_0.var_AC75;
  var_2.triggerportableradarping = var_0.triggerportableradarping;
  var_2.config = var_0.config;
  var_2 linkto(self, "tag_shield_back", (0, 0, 0), (0, 90, 90));
  var_2 thread func_D501(self);
  var_2 thread createbombsquadmodel(var_0.config.bombsquadmodel, "tag_origin", var_0.triggerportableradarping);
  var_2 thread minedamagemonitor();
  var_2 thread func_13B1A(self, var_0);
  var_2 thread func_13B1B(self, var_0);
  var_2 thread func_139F0();
}

func_D501(var_0) {
  self endon("death");
  var_1 = self gettagorigin("tag_fx");
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2 linkto(self, "tag_fx", (0, 0, 0), (90, 0, -90));
  var_2 thread func_13A0F(self);
  for(;;) {
    wait(2);
    playFXOnTag(self.config.var_C4C5, var_2, "tag_origin");
    if(isDefined(var_0)) {
      var_0 scripts\mp\damagefeedback::updatedamagefeedback("hitmotionsensor");
      var_0 playsoundonmovingent("ball_drone_3Dping");
    } else {
      self playSound("ball_drone_3Dping");
    }

    foreach(var_4 in level.players) {
      if(var_4.team != self.triggerportableradarping.team) {
        continue;
      }

      triggerportableradarping(self.origin, var_4);
    }
  }
}

func_13A0F(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

func_13B1A(var_0, var_1) {
  self endon("death");
  for(;;) {
    self waittill("detonateExplosive", var_2);
    var_0.var_DBD8 = undefined;
    self.config.var_127BF = undefined;
    self playSound(self.config.onexplodesfx);
    var_3 = self gettagorigin("tag_origin");
    playFX(self.config.onexplodevfx, var_3);
    self delete();
  }
}

func_13B1B(var_0, var_1) {
  self endon("death");
  var_2 = var_1.triggerportableradarping;
  var_3 = var_1.angles;
  var_4 = var_1.var_AC75;
  var_0 waittill("death");
  var_0.var_DBD8 = undefined;
  self.config.var_127BF = undefined;
  func_108E5(var_0.origin, var_2, "mobile_radar_mp", var_3, var_4, 1);
  self delete();
}

func_B8F7(var_0) {
  var_1 = 1;
  if(isDefined(var_0.var_DBD8)) {
    var_1 = 0;
  }

  if(!isplayer(var_0)) {
    var_1 = 0;
  }

  return var_1;
}

playspinnerfx() {
  if(isDefined(self.config.mine_spin)) {
    self endon("death");
    var_0 = gettime() + 1000;
    while(gettime() < var_0) {
      wait(0.05);
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin1");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin3");
      wait(0.05);
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin2");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin4");
    }
  }
}

minedamagedebug(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6[0] = (1, 0, 0);
  var_6[1] = (0, 1, 0);
  if(var_1[2] < var_5) {
    var_7 = 0;
  } else {
    var_7 = 1;
  }

  var_8 = (var_0[0], var_0[1], var_5);
  var_9 = (var_1[0], var_1[1], var_5);
  thread debugcircle(var_8, level.minedamageradius, var_6[var_7], 32);
  var_0A = distancesquared(var_0, var_1);
  if(var_0A > var_2) {
    var_7 = 0;
  } else {
    var_7 = 1;
  }

  thread debugline(var_8, var_9, var_6[var_7]);
}

minedamageheightpassed(var_0, var_1) {
  if(isplayer(var_1) && isalive(var_1) && var_1.sessionstate == "playing") {
    var_2 = var_1 scripts\mp\utility::getstancecenter();
  } else if(var_2.classname == "misc_turret") {
    var_2 = var_2.origin + (0, 0, 32);
  } else {
    var_2 = var_2.origin;
  }

  var_3 = 0;
  var_4 = var_0.origin[2] + var_3 - level.minedamagehalfheight;
  if(var_2[2] < var_4) {
    return 0;
  }

  return 1;
}

mineused(var_0, var_1, var_2) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var_0 thread minethrown(self, var_0.weapon_name, var_0.power, var_0.var_1088C, var_2);
}

minethrown(var_0, var_1, var_2, var_3, var_4) {
  self.triggerportableradarping = var_0;
  self waittill("missile_stuck", var_5);
  if(var_1 != "trip_mine_mp") {
    if(isDefined(var_5) && isDefined(var_5.triggerportableradarping)) {
      if(isDefined(var_4)) {
        self.triggerportableradarping[[var_4]](self);
      }

      self delete();
      return;
    }
  }

  self.triggerportableradarping notify("bouncing_betty_update", 0);
  if(!isDefined(var_0)) {
    return;
  }

  if(var_1 != "sonic_sensor_mp") {
    var_6 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  } else {
    var_6 = scripts\common\trace::ray_trace(self.origin, self.origin + anglestoup(self.angles * 2));
  }

  var_7 = var_6["position"];
  if(var_6["fraction"] == 1 && var_1 != "sonic_sensor_mp") {
    var_7 = getgroundposition(self.origin, 12, 0, 32);
    var_6["normal"] = var_6["normal"] * -1;
  }

  if(var_1 != "sonic_sensor_mp") {
    var_8 = vectornormalize(var_6["normal"]);
    var_9 = vectortoangles(var_8);
    var_9 = var_9 + (90, 0, 0);
  } else {
    var_9 = self.angles;
  }

  var_0A = self[[var_3]](var_7, var_0, var_1, var_2, var_9);
  var_0A makeexplosiveusable();
  var_0A thread minedamagemonitor();
  self delete();
}

func_51CE() {
  if(isDefined(self.plantedlethalequip)) {
    foreach(var_1 in self.plantedlethalequip) {
      if(isDefined(var_1)) {
        var_1 deleteexplosive();
      }
    }
  }

  if(isDefined(self.plantedtacticalequip)) {
    foreach(var_1 in self.plantedtacticalequip) {
      if(isDefined(var_1)) {
        var_1 deleteexplosive();
      }
    }
  }

  self.plantedlethalequip = [];
  self.plantedtacticalequip = [];
}

deletedisparateplacedequipment() {
  var_0 = scripts\mp\powers::getcurrentequipment("primary");
  foreach(var_2 in self.plantedlethalequip) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.var_D77A) || !isDefined(var_0) || var_2.var_D77A != var_0) {
        var_2 deleteexplosive();
      }
    }
  }

  var_4 = scripts\mp\powers::getcurrentequipment("secondary");
  foreach(var_2 in self.plantedtacticalequip) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.var_D77A) || !isDefined(var_4) || var_2.var_D77A != var_4) {
        var_2 deleteexplosive();
      }
    }
  }
}

doblinkinglight(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getfx("weap_blink_friend");
  }

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::getfx("weap_blink_enemy");
  }

  self.blinkinglightfx["friendly"] = var_1;
  self.blinkinglightfx["enemy"] = var_2;
  self.blinkinglighttag = var_0;
  thread updateblinkinglight(var_1, var_2, var_0);
  self waittill("death");
  stopblinkinglight();
}

updateblinkinglight(var_0, var_1, var_2) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  var_3 = ::checkteam;
  if(!level.teambased) {
    var_3 = ::checkplayer;
  }

  var_4 = randomfloatrange(0.05, 0.25);
  wait(var_4);
  childthread onjointeamblinkinglight(var_0, var_1, var_2, var_3);
  foreach(var_6 in level.players) {
    if(isDefined(var_6)) {
      if(self.triggerportableradarping[[var_3]](var_6)) {
        playfxontagforclients(var_0, self, var_2, var_6);
      } else {
        playfxontagforclients(var_1, self, var_2, var_6);
      }

      wait(0.05);
    }
  }
}

onjointeamblinkinglight(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");
  for(;;) {
    level waittill("joined_team", var_4);
    if(self.triggerportableradarping[[var_3]](var_4)) {
      playfxontagforclients(var_0, self, var_2, var_4);
      continue;
    }

    playfxontagforclients(var_1, self, var_2, var_4);
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

checkteam(var_0) {
  return self.team == var_0.team;
}

checkplayer(var_0) {
  return self == var_0;
}

equipmentdeathvfx(var_0) {
  playFX(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  if(!isDefined(var_0) || var_0 == 0) {
    self playSound("sentry_explode");
  }
}

equipmentdeletevfx(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_2 = anglesToForward(var_1);
      var_3 = anglestoup(var_1);
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_0, var_2, var_3);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_0, var_2, var_3);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_0);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_0);
    }

    playsoundatpos(var_0, "mp_killstreak_disappear");
    return;
  }

  if(isDefined(self)) {
    var_4 = self.origin;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("equipment_explode"), var_4, var_2, var_3);
    playFX(scripts\engine\utility::getfx("equipment_smoke"), var_4, var_2, var_3);
    self playSound("mp_killstreak_disappear");
  }
}

equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

buildattachmentmaps() {
  var_0 = getattachmentlistuniquenames();
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.attachmentextralist = [];
  foreach(var_2 in var_0) {
    var_3 = tablelookup("mp\attachmenttable.csv", 4, var_2, 5);
    if(var_2 != var_3) {
      level.attachmentmap_uniquetobase[var_2] = var_3;
    }

    var_4 = tablelookup("mp\attachmenttable.csv", 4, var_2, 13);
    if(var_4 != "") {
      level.attachmentmap_uniquetoextra[var_2] = var_4;
      level.attachmentextralist[var_4] = 1;
    }
  }

  var_6 = [];
  var_7 = 1;
  var_8 = tablelookupbyrow("mp\attachmentmap.csv", var_7, 0);
  while(var_8 != "") {
    var_6[var_6.size] = var_8;
    var_7++;
    var_8 = tablelookupbyrow("mp\attachmentmap.csv", var_7, 0);
  }

  var_9 = [];
  var_0A = 1;
  var_0B = tablelookupbyrow("mp\attachmentmap.csv", 0, var_0A);
  while(var_0B != "") {
    var_9[var_0B] = var_0A;
    var_0A++;
    var_0B = tablelookupbyrow("mp\attachmentmap.csv", 0, var_0A);
  }

  level.attachmentmap_basetounique = [];
  foreach(var_8 in var_6) {
    foreach(var_10, var_0E in var_9) {
      var_0F = tablelookup("mp\attachmentmap.csv", 0, var_8, var_0E);
      if(var_0F == "") {
        continue;
      }

      if(!isDefined(level.attachmentmap_basetounique[var_8])) {
        level.attachmentmap_basetounique[var_8] = [];
      }

      level.attachmentmap_basetounique[var_8][var_10] = var_0F;
    }
  }

  level.attachmentmap_attachtoperk = [];
  foreach(var_13 in var_0) {
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
  var_0 = [];
  var_1 = 0;
  var_2 = tablelookup("mp\attachmentTable.csv", 0, var_1, 4);
  while(var_2 != "") {
    var_0[var_2] = var_2;
    var_1++;
    var_2 = tablelookup("mp\attachmentTable.csv", 0, var_1, 4);
  }

  return var_0;
}

func_3222() {
  level.weaponmapdata = [];
  for(var_0 = 1; tablelookup("mp\statstable.csv", 0, var_0, 0) != ""; var_0++) {
    var_1 = tablelookup("mp\statstable.csv", 0, var_0, 4);
    if(var_1 != "") {
      level.weaponmapdata[var_1] = spawnStruct();
      var_2 = tablelookup("mp\statstable.csv", 0, var_0, 0);
      if(var_2 != "") {
        level.weaponmapdata[var_1].number = var_2;
      }

      var_3 = tablelookup("mp\statstable.csv", 0, var_0, 1);
      if(var_3 != "") {
        level.weaponmapdata[var_1].group = var_3;
      }

      var_4 = tablelookup("mp\statstable.csv", 0, var_0, 5);
      if(var_4 != "") {
        level.weaponmapdata[var_1].var_23B0 = var_4;
      }

      var_5 = tablelookup("mp\statstable.csv", 0, var_0, 44);
      if(var_5 != "") {
        level.weaponmapdata[var_1].perk = var_5;
      }

      var_6 = tablelookup("mp\statstable.csv", 0, var_0, 9);
      if(var_6 != "") {
        level.weaponmapdata[var_1].attachdefaults = strtok(var_6, " ");
      }

      level.weaponmapdata[var_1].selectableattachmentlist = [];
      level.weaponmapdata[var_1].selectableattachmentmap = [];
      for(var_7 = 0; var_7 < 20; var_7++) {
        var_8 = tablelookup("mp\statstable.csv", 0, var_0, 10 + var_7);
        if(isDefined(var_8) && var_8 != "") {
          var_9 = level.weaponmapdata[var_1].selectableattachmentlist.size;
          level.weaponmapdata[var_1].selectableattachmentlist[var_9] = var_8;
          level.weaponmapdata[var_1].selectableattachmentmap[var_8] = 1;
        }
      }

      if(level.tactical) {
        var_0A = tablelookup("mp\statstable.csv", 0, var_0, 50);
      } else {
        var_0A = tablelookup("mp\statstable.csv", 0, var_1, 8);
      }

      if(var_0A != "") {
        var_0A = float(var_0A);
        level.weaponmapdata[var_1].getclosestpointonnavmesh3d = var_0A;
      }
    }
  }
}

func_464F() {
  level endon("game_ended");
  self endon("end_explode");
  self.triggerportableradarping endon("disconnect");
  self waittill("explode", var_0);
  func_464D(var_0);
}

func_464D(var_0) {
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  var_1 = self.triggerportableradarping;
  var_2 = var_1 scripts\mp\utility::getotherteam(var_1.team);
  var_3 = undefined;
  var_4 = 0;
  if(level.teambased) {
    var_3 = scripts\mp\utility::getteamarray(var_2);
  } else {
    var_3 = level.characters;
  }

  var_5 = [];
  var_6 = getempdamageents(var_0, 256, 0, undefined);
  if(var_6.size >= 1) {
    foreach(var_8 in var_6) {
      if(isDefined(var_8.triggerportableradarping) && !friendlyfirecheck(self.triggerportableradarping, var_8.triggerportableradarping)) {
        continue;
      }

      var_8 notify("emp_damage", self.triggerportableradarping, 5);
      foreach(var_0A in var_3) {
        if(var_8 == var_0A || var_8 == self.triggerportableradarping) {
          var_8 thread func_464E();
          var_5[var_5.size] = var_8;
          break;
        }
      }
    }

    foreach(var_0E in var_5) {
      if(var_0E == self.triggerportableradarping) {
        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      var_0E = var_5[var_5.size - 1];
      if(isDefined(var_0E) && var_0E != var_1) {
        var_10 = "primary";
        var_11 = "none";
        var_12 = getarraykeys(var_1.powers);
        foreach(var_14 in var_12) {
          if(var_1.powers[var_14].slot == var_10) {
            var_11 = var_14;
          }
        }

        var_16 = var_0E.var_AE7B;
        if(isDefined(var_16) && var_16 != "none") {
          var_1 notify("corpse_steal");
          var_1 notify("start_copycat");
          var_1 scripts\mp\powers::removepower(var_11);
          var_1 scripts\mp\powers::givepower(var_16, var_10, 1);
          var_1 thread func_139D7(var_16, var_10);
          return;
        }

        return;
      }
    }
  }
}

func_139D7(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  self endon("corpse_steal");
  self waittill("copycat_reset");
  self notify("start_copycat");
  scripts\mp\powers::removepower(var_0);
  scripts\mp\powers::givepower(self.var_AE7B, var_1, 1);
  self setclientomnvar("ui_juggernaut", 0);
}

func_464E() {
  self endon("disconnect");
  self endon("death");
  var_0 = gettime() + 5000;
  scripts\mp\powers::power_modifycooldownrate(0);
  if(isDefined(self.var_38A1) && self.var_38A1) {
    scripts\mp\powers::func_12C9F();
  }

  thread scripts\mp\powers::func_D729();
  while(gettime() < var_0) {
    wait(0.1);
  }

  scripts\mp\powers::func_D74E();
  if(isDefined(self.var_38A1) && !self.var_38A1) {
    scripts\mp\powers::func_F6B1();
  }

  thread scripts\mp\powers::func_D72F();
}

grenadestuckto(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0.stuckenemyentity = var_1;
    var_1.var_1117F = var_0;
    return;
  }

  if(level.teambased && isDefined(var_1.team) && var_1.team == self.team) {
    var_0.isstuck = "friendly";
    return;
  }

  var_3 = undefined;
  if(glprox_trygetweaponname(var_0.weapon_name) == "stickglprox") {
    var_3 = "stickglprox_stuck";
  } else {
    switch (var_0.weapon_name) {
      case "semtex_mp":
        var_3 = "semtex_stuck";
        break;

      case "splash_grenade_mp":
        var_3 = "splash_grenade_stuck";
        break;

      case "power_spider_grenade_mp":
        var_3 = "spider_grenade_stuck";
        break;

      case "wristrocket_proj_mp":
        var_3 = "wrist_rocket_stuck";
        break;
    }
  }

  var_0.isstuck = "enemy";
  var_0.stuckenemyentity = var_1;
  if(var_0.weapon_name == "split_grenade_mp") {
    var_1.var_1117F = undefined;
  } else {
    var_1.var_1117F = var_0;
    self notify("grenade_stuck_enemy");
  }

  if(!scripts\mp\utility::istrue(var_2)) {
    func_85DE(var_3, var_1);
    return;
  }
}

func_85DE(var_0, var_1) {
  if(isplayer(var_1) && isDefined(var_0)) {
    var_1 scripts\mp\hud_message::showsplash(var_0, undefined, self);
  }

  thread scripts\mp\awards::givemidmatchaward("explosive_stick");
}

func_66A5(var_0, var_1) {
  if(var_0 scripts\mp\powers::func_D734(var_1) > 0) {
    return 0;
  }

  var_2 = undefined;
  switch (var_1) {
    case "power_explodingDrone":
      var_2 = var_0.var_69D6;
      break;

    case "power_c4":
      var_2 = var_0.plantedlethalequip;
      break;

    case "power_transponder":
      var_2 = var_0.plantedtacticalequip;
      break;
  }

  if(!isDefined(var_2) || var_2.size == 0) {
    return 0;
  }

  return 1;
}

func_10884(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnmine(var_0, var_1, var_2, var_3, var_4);
  var_5.var_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.var_76CF setscriptmoverkillcam("explosive");
  thread cleanupflashanim(var_5.var_76CF, var_5);
  return var_5;
}

cleanupflashanim(var_0, var_1) {
  var_1 waittill("death");
  wait(20);
  var_0 delete();
}

func_10832(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnmine(var_0, var_1, var_2, var_3, var_4);
  var_5.var_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.var_76CF setscriptmoverkillcam("explosive");
  thread func_40E6(var_5.var_76CF, var_5);
  var_1 notify("powers_blackholeGrenade_used", 1);
  return var_5;
}

func_40E6(var_0, var_1) {
  var_1 waittill("death");
  wait(20);
  var_0 delete();
}

func_1082C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnmine(var_0, var_1, var_2, var_3, var_4);
  var_5.var_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.var_76CF setscriptmoverkillcam("explosive");
  thread func_40E4(var_5.var_76CF, var_5);
  return var_5;
}

func_40E4(var_0, var_1) {
  var_1 waittill("death");
  wait(20);
  var_0 delete();
}

func_10843(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnmine(var_0, var_1, var_2, var_3, var_4);
  var_5.var_4ACD = spawn("script_model", var_5.killcament.origin);
  var_5.var_4ACD setscriptmoverkillcam("explosive");
  thread func_40F1(var_5.var_4ACD, var_5);
  var_1 notify("powers_cryoGrenade_used", 1);
  return var_5;
}

func_40F1(var_0, var_1) {
  var_1 waittill("death");
  wait(20);
  var_0 delete();
}

func_1090D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnmine(var_0, var_1, var_2, var_3, var_4);
  var_5.var_76CF = spawn("script_model", var_5.killcament.origin);
  var_5.var_76CF setscriptmoverkillcam("explosive");
  thread func_4117(var_5.var_76CF, var_5);
  self notify("powers_shardBall_used", 1);
  return var_5;
}

func_4117(var_0, var_1) {
  var_1 waittill("death");
  wait(20);
  var_0 delete();
}

outlineequipmentforowner(var_0, var_1) {
  var_2 = scripts\mp\utility::outlineenableforplayer(var_0, "white", var_1, 0, 0, "equipment");
  var_0 waittill("death");
  scripts\mp\utility::outlinedisable(var_2, var_0);
}

outlinesuperequipment(var_0, var_1) {
  if(level.teambased) {
    thread outlinesuperequipmentforteam(var_0, var_1);
    return;
  }

  thread outlinesuperequipmentforplayer(var_0, var_1);
}

outlinesuperequipmentforteam(var_0, var_1) {
  var_2 = scripts\mp\utility::outlineenableforteam(var_0, "cyan", var_1.team, 0, 0, "killstreak");
  var_0 waittill("death");
  scripts\mp\utility::outlinedisable(var_2, var_0);
}

outlinesuperequipmentforplayer(var_0, var_1) {
  var_2 = scripts\mp\utility::outlineenableforplayer(var_0, "cyan", var_1, 0, 0, "killstreak");
  var_0 waittill("death");
  scripts\mp\utility::outlinedisable(var_2, var_0);
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

trace_impale(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_3 = scripts\common\trace::ray_trace_detail(var_0, var_1, level.players, var_2, undefined, 1);
  return var_3;
}

impale_endpoint(var_0, var_1) {
  var_2 = var_0 + var_1 * 4096;
  return var_2;
}

impale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 endon("death");
  var_1 endon("disconnect");
  if(!isDefined(var_1.body)) {
    return;
  }

  var_9 = var_0 scripts\mp\utility::_hasperk("passive_power_melee");
  if(var_9) {
    var_6 = "torso";
  } else {
    playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), var_4);
  }

  var_0A = impale_endpoint(var_4, var_5);
  var_0B = trace_impale(var_4, var_0A);
  var_0A = var_0B["position"] - var_5 * 12;
  var_0C = length(var_0A - var_4);
  var_0D = var_0C / scripts\engine\utility::ter_op(var_9, 600, 1000);
  var_0D = max(var_0D, 0.05);
  if(var_0B["hittype"] != "hittype_world") {
    var_0D = 0;
  }

  var_0E = var_0D > 0.05;
  if(isDefined(var_1)) {
    var_1.body giverankxp();
  }

  wait(0.05);
  if(var_0E) {
    var_0F = var_5;
    var_10 = anglestoup(var_0.angles);
    var_11 = vectorcross(var_0F, var_10);
    var_12 = scripts\engine\utility::spawn_tag_origin(var_4, axistoangles(var_0F, var_11, var_10));
    var_12 moveto(var_0A, var_0D);
    var_13 = spawnragdollconstraint(var_1.body, var_6, var_7, var_8);
    var_13.origin = var_12.origin;
    var_13.angles = var_12.angles;
    var_13 linkto(var_12);
    if(var_0D > scripts\engine\utility::ter_op(var_9, 0.075, 1)) {
      thread impale_detachaftertime(var_13, scripts\engine\utility::ter_op(var_9, 0.075, 1));
    }

    thread impale_cleanup(var_1, var_12, var_0D + 0.25);
    if(!var_9) {
      var_12 thread impale_effects(var_0A, var_0D);
    }
  }
}

impale_detachaftertime(var_0, var_1) {
  wait(var_1);
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

impale_effects(var_0, var_1) {
  wait(clamp(var_1 - 0.05, 0.05, 20));
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), var_0);
}

impale_cleanup(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::waittill_any_timeout_1(var_2, "death", "disconnect");
  }

  var_1 delete();
}

codecallback_getprojectilespeedscale(var_0, var_1) {
  return [1, 1];
}

func_9F3C(var_0, var_1) {
  return isDefined(level.weaponmapdata[var_0].selectableattachmentmap[var_1]);
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

func_40EA(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(var_0);
  func_F800();
}

func_A008(var_0) {
  var_1 = getweaponbasename(var_0);
  switch (var_1) {
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

func_13AB5(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  if(func_ABC1()) {
    return;
  }

  self notify("watchLethalDelayPlayer_" + var_2);
  self endon("watchLethalDelayPlayer_" + var_2);
  self endon("power_removed_" + var_1);
  var_0 scripts\mp\powers::func_D727(var_1);
  func_13AB4(var_0, var_2);
  var_0 scripts\mp\powers::func_D72D(var_1);
}

func_13AB4(var_0, var_1) {
  level endon("lethal_delay_end");
  if(!scripts\mp\utility::istrue(scripts\mp\utility::gameflag("prematch_done"))) {
    level waittill("lethal_delay_start");
  }

  var_2 = "+frag";
  if(var_1 != "primary") {
    var_2 = "+smoke";
  }

  if(!isbot(var_0)) {
    var_0 notifyonplayercommand("lethal_attempt_" + var_1, var_2);
  }

  for(;;) {
    self waittill("lethal_attempt_" + var_1);
    var_3 = level.var_ABC0 - scripts\mp\utility::gettimepassed() / 1000;
    var_3 = int(max(0, ceil(var_3)));
    var_0 scripts\mp\hud_message::showerrormessage("MP_LETHALS_UNAVAILABLE_FOR_N", var_3);
  }
}

cancellethaldelay() {
  level.var_ABBF = 0;
  level.var_ABC2 = scripts\mp\utility::gettimepassed();
  level.var_ABC0 = level.var_ABC2;
  level notify("lethal_delay_end");
}

func_ABC1(var_0) {
  if(isDefined(level.var_ABBF) && level.var_ABBF == 0) {
    return 1;
  }

  return isDefined(level.var_ABC0) && scripts\mp\utility::gettimepassed() > level.var_ABC0;
}

func_13AA9() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_switch_invalid", var_0);
    var_1 = self getcurrentweapon();
    var_2 = weaponinventorytype(var_1);
    if(var_2 == "item" || var_2 == "exclusive") {
      scripts\mp\utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }
}

func_13C98(var_0) {
  var_1 = scripts\mp\utility::getweaponrootname(var_0);
  var_2 = getweaponattachments(var_0);
  foreach(var_4 in var_2) {
    var_5 = func_248C(var_4);
    if(var_5 == "rail") {
      var_6 = scripts\mp\utility::attachmentmap_tobase(var_4);
      if(func_9F3C(var_1, var_6)) {
        return 1;
      }
    }
  }

  return 0;
}

watchdropweapons() {
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_dropped", var_0, var_1);
    if(isDefined(var_0) && isDefined(var_1)) {}
  }
}

watchgrenadeaxepickup(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(self.weapon_name) && isDefined(var_1)) {
    self.weapon_name = var_1;
  }

  self.inphase = 0;
  if(isDefined(var_0)) {
    self.inphase = var_0 isinphase();
  }

  self waittill("missile_stuck", var_2, var_3);
  if(isDefined(var_2) && isplayer(var_2) || isagent(var_2)) {
    var_4 = var_3 == "tag_flicker";
    var_5 = var_3 == "tag_top_flicker";
    var_6 = var_2 scripts\mp\utility::_hasperk("specialty_rearguard") && var_3 == "tag_origin";
    var_7 = isDefined(var_3) && var_4 || var_5 || var_6;
    var_8 = isDefined(var_3) && var_3 == "tag_weapon";
    if(var_7) {
      playFX(scripts\engine\utility::getfx("shield_metal_impact"), self.origin);
      if(isDefined(self.triggerportableradarping)) {
        var_9 = self.triggerportableradarping;
        relaunchaxe(self.weapon_name, var_9, 1);
        return;
      }
    } else if(!scripts\mp\utility::istrue(var_8) && isplayer(var_3) && !scripts\mp\utility::isreallyalive(var_3) && level.mapname == "mp_neon" || scripts\mp\utility::istrue(level.var_DC24)) {
      return;
    }
  }

  var_1 thread func_11825(var_1, self);
  var_0A = 45;
  thread watchaxetimeout(var_0A);
  thread watchgrenadedeath();
  thread watchaxeuse(var_1, self.weapon_name);
  thread watchaxeautopickup(var_1, self.weapon_name);
}

axedetachfromcorpse(var_0) {
  level endon("game_ended");
  var_1 = var_0 getlinkedchildren();
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3.weapon_name;
    var_5 = var_3.triggerportableradarping;
    var_6 = var_3.origin;
    if(isDefined(var_4) && isaxeweapon(var_4)) {
      var_3 relaunchaxe(var_4, var_5, 1);
    }
  }
}

relaunchaxe(var_0, var_1, var_2) {
  self unlink();
  var_3 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
  var_4 = getsubstr(var_0, var_3.size);
  var_5 = var_1 scripts\mp\utility::_launchgrenade("iw7_axe_mp_dummy" + var_4, self.origin, (0, 0, 0), 100, 1, self);
  var_5 setentityowner(var_1);
  var_5 thread watchgrenadeaxepickup(var_1, self.weapon_name);
  if(scripts\mp\utility::istrue(var_2)) {
    self.inphase = 0;
    self.var_FF03 = 0;
  }
}

watchaxetimeout(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self delete();
}

watchaxeautopickup(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  var_2 enablelinkto();
  var_2 linkto(self);
  self.knife_trigger = var_2;
  var_2 endon("death");
  for(;;) {
    var_2 waittill("trigger", var_0);
    if(!isplayer(var_0)) {
      continue;
    }

    if(var_0 playercanautopickupaxe(self)) {
      var_0 playerpickupaxe(var_1, 1);
      self delete();
      break;
    }
  }
}

watchaxeuse(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = spawn("script_model", self.origin);
  var_2 linkto(self);
  self.useobj_trigger = var_2;
  var_2 makeusable();
  var_2 setcursorhint("HINT_NOICON");
  var_2 _meth_84A9("show");
  var_2 sethintstring(&"WEAPON_PICKUP_AXE");
  var_2 _meth_84A6(360);
  var_2 setusefov(360);
  var_2 _meth_84A4(64);
  var_2 setuserange(64);
  var_2 setusepriority(0);
  thread watchallplayerphasestates(var_2);
  var_2 waittill("trigger", var_0);
  var_0 playerpickupaxe(var_1, 0);
  self delete();
}

watchallplayerphasestates(var_0) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    foreach(var_2 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_2)) {
        continue;
      }

      if(!axeinsamephaseplayerstate(self, var_2)) {
        var_0 disableplayeruse(var_2);
        continue;
      }

      var_0 enableplayeruse(var_2);
    }

    scripts\engine\utility::waitframe();
  }
}

axeinsamephaseplayerstate(var_0, var_1) {
  var_2 = 1;
  if(scripts\mp\utility::istrue(var_0.inphase) && !var_1 isinphase()) {
    var_2 = 0;
  } else if(!scripts\mp\utility::istrue(var_0.inphase) && var_1 isinphase()) {
    var_2 = 0;
  }

  return var_2;
}

playercanautopickupaxe(var_0) {
  if(isDefined(var_0.triggerportableradarping) && self != var_0.triggerportableradarping) {
    return 0;
  }

  var_1 = self getweaponslistprimaries();
  var_2 = 0;
  var_3 = 0;
  foreach(var_5 in var_1) {
    if(isaxeweapon(var_5) && self getweaponammoclip(var_5) == 0) {
      var_2 = 1;
      break;
    }

    if(issubstr(var_5, "iw7_fists_mp")) {
      var_2 = 1;
      break;
    }

    if(!issubstr(var_5, "alt_")) {
      var_3++;
    }
  }

  if(var_3 < 2) {
    var_2 = 1;
  }

  if(scripts\mp\utility::istrue(var_2)) {
    if(!axeinsamephaseplayerstate(var_0, self)) {
      var_2 = 0;
    }
  }

  return var_2;
}

playerpickupaxe(var_0, var_1) {
  var_2 = scripts\mp\utility::func_E0CF(var_0);
  var_3 = self getcurrentweapon();
  var_4 = self getweaponslistprimaries();
  if(self hasweapon(var_0)) {
    var_5 = self getweaponammoclip(var_0);
    if(!var_1 && var_5 > 0) {
      self dropitem(var_0);
      scripts\mp\utility::_giveweapon(var_2);
    } else if(!issubstr(var_3, var_0)) {
      scripts\mp\utility::_takeweapon(var_0);
      scripts\mp\utility::_giveweapon(var_2);
    }

    var_6 = self getweaponammoclip(var_3) == 0 && isaxeweapon(var_3);
    var_7 = issubstr(var_3, "iw7_fists_mp");
    if(!var_1 || var_7 || var_6) {
      scripts\mp\utility::_switchtoweapon(var_2);
    }

    self setweaponammoclip(var_2, 1);
    scripts\mp\hud_message::showmiscmessage("axe");
    return;
  }

  var_8 = undefined;
  var_9 = 0;
  foreach(var_0B in var_7) {
    if(issubstr(var_0B, "alt_")) {
      continue;
    }

    if(issubstr(var_0B, "uplinkball")) {
      continue;
    }

    var_0C = self getweaponammoclip(var_0B) == 0 && isaxeweapon(var_0B);
    if(!isDefined(var_8) && weaponispreferreddrop(var_0B) || var_0C) {
      var_8 = var_0B;
    }

    var_9++;
  }

  var_0E = undefined;
  if(isDefined(var_8)) {
    var_0E = var_8;
  } else if(var_9 >= 2) {
    var_0E = var_6;
  }

  var_0F = !var_4 || isDefined(var_0E) && issubstr(var_6, var_0E);
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
    } else if(!var_11 && !var_10 && var_9 < 2 && !var_0C && var_9 < 2) {
      self takeweapon(var_0E);
    }
  }

  scripts\mp\utility::_giveweapon(var_5);
  self setweaponammoclip(var_5, 1);
  if(var_0F) {
    scripts\mp\utility::_switchtoweapon(var_5);
  }

  scripts\mp\hud_message::showmiscmessage("axe");
  fixupplayerweapons(self, var_5);
}

callback_finishweaponchange(var_0, var_1, var_2, var_3) {
  updatecamoscripts(var_0, var_1, var_2, var_3);
  updateholidayweaponsounds(var_0, var_1, var_2, var_3);
  updateweaponscriptvfx(var_0, var_1, var_2, var_3);
  if(level.ingraceperiod > 0) {
    thread watchrigchangeforweaponfx(var_0, var_1, var_2, var_3);
  }

  scripts\mp\missions::monitorweaponpickup(var_0);
}

watchrigchangeforweaponfx(var_0, var_1, var_2, var_3) {
  self notify("rigChangedDuringGraceperiod");
  self endon("rigChangedDuringGraceperiod");
  self endon("graceperiod_done");
  while(level.ingraceperiod > 0) {
    self waittill("changed_kit");
    if(isDefined(var_1) && var_1 != "none") {
      updateweaponscriptvfx(var_0, var_1, var_2, var_3);
    }
  }
}

updateholidayweaponsounds(var_0, var_1, var_2, var_3) {
  var_4 = getweaponvariantindex(var_0);
  if(scripts\mp\class::isholidayweapon(var_0, var_4)) {
    self _meth_8460("special_foley", "bells", 2);
    return;
  }

  self _meth_8460("special_foley", "", 0.1);
}

updateweaponscriptvfx(var_0, var_1, var_2, var_3) {
  if((var_1 == "none" || var_1 == "alt_none") && isDefined(self.lastdroppableweaponobj)) {
    if(var_1 == "alt_none") {
      var_3 = 1;
    } else {
      var_3 = 0;
    }

    var_1 = self.lastdroppableweaponobj;
  }

  clearweaponscriptvfx(var_1, var_3);
  runweaponscriptvfx(var_0, var_2);
}

runweaponscriptvfx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_2 = "alt_" + scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
  } else {
    var_2 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_1);
  }

  switch (var_2) {
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

clearweaponscriptvfx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_2 = "alt_" + scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
  } else {
    var_2 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_1);
  }

  switch (var_2) {
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

    self waittill("weapon_charge_update_tag_count", var_0);
    if(var_0 >= 7) {
      self setscriptablepartstate("gaussFXWorld", "active", 0);
      self waittill("weapon_charge_update_tag_count", var_0);
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

updatecamoscripts(var_0, var_1, var_2, var_3) {
  var_4 = getweaponcamoname(var_0);
  var_5 = getweaponcamoname(var_1);
  if(!isDefined(var_4)) {
    var_4 = "none";
  }

  if(!isDefined(var_5)) {
    var_5 = "none";
  }

  clearcamoscripts(var_1, var_5);
  runcamoscripts(var_0, var_4);
}

runcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
    case "camo31":
      thread mw2_camo_31();
      break;

    case "camo84":
      thread blood_camo_84();
      break;
  }
}

clearcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
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