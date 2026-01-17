/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2667.gsc
**************************************/

weaponsinit() {
  level.maxperplayerexplosives = max(scripts\cp\utility::getintproperty("scr_maxPerPlayerExplosives", 2), 4);
  level.riotshieldxpbullets = scripts\cp\utility::getintproperty("scr_riotShieldXPBullets", 15);
  level.build_weapon_name_func = ::return_weapon_name_with_like_attachments;
  level.weaponconfigs = [];
  level.wavessurvivedthroughweapon = 0;
  level.weaponobtained = 0;
  level.downswithweapon = 0;
  level.weaponkills = 0;
  buildattachmentmaps();
  mpbuildweaponmap();
  initeffects();
  setupminesettings();
  setupconfigs();
  level thread onplayerconnect();
  iteminits();
  scripts\engine\utility::array_thread(getEntArray("misc_turret", "classname"), ::turret_monitoruse);
}

heart_power_init() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_heart", ::powerheartset, ::takeheart, undefined, undefined, "heart_used", undefined);
}

eye_power_init() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_rat_king_eye", ::powereyeset, ::takerateye, ::eye_activated, undefined, undefined, undefined);
}

powerheartset(var_0) {
  self.has_heart = 1;
}

powereyeset(var_0) {
  self.has_eye = 1;
}

blank(var_0) {}

initeffects() {
  level._effect["weap_blink_friend"] = loadfx("vfx\core\mp\killstreaks\vfx_detonator_blink_cyan.vfx");
  level._effect["weap_blink_enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_detonator_blink_cyan.vfx");
  level._effect["emp_stun"] = loadfx("vfx\core\mp\equipment\vfx_emp_grenade");
  level._effect["equipment_explode_big"] = loadfx("vfx\core\mp\killstreaks\vfx_ims_explosion");
  level._effect["equipment_smoke"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx\core\mp\killstreaks\vfx_sentry_gun_explosion.vfx");
  level.kinetic_pulse_fx["spark"] = loadfx("vfx\iw7\_requests\mp\vfx_kinetic_pulse_shock");
  level._effect["gas_grenade_smoke_enemy"] = loadfx("vfx\old\_requests\mp_weapons\vfx_poison_gas_enemy");
  level._effect["equipment_smoke"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["placeEquipmentFailed"] = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  level._effect["penetration_railgun_explosion"] = loadfx("vfx\iw7\core\expl\weap\chargeshot\vfx_expl_chargeshot.vfx");
}

setupminesettings() {
  var_0 = 70;
  level.claymoredetectiondot = cos(var_0);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.75;
  level.claymoredetonateradius = 192;
  level.minedetectiongraceperiod = 0.3;
  level.minedetectionradius = 150;
  level.minedetectionheight = 20;
  level.minedamageradius = 256;
  level.minedamagemin = 600;
  level.minedamagemax = 1200;
  level.minedamagehalfheight = 300;
  level.mineselfdestructtime = 600;
  level.mine_launch = loadfx("vfx\core\impacts\bouncing_betty_launch_dirt");
  level.mine_explode = loadfx("vfx\core\expl\bouncing_betty_explosion.vfx");
  level.delayminetime = 1.5;
  level.c4explodethisframe = 0;
  level.mines = [];
}

setupconfigs() {
  var_0 = spawnStruct();
  var_0.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_0.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["c4_zm"] = var_0;
  var_0 = spawnStruct();
  var_0.model = "prop_mp_speed_strip_temp";
  var_0.bombsquadmodel = "prop_mp_speed_strip_temp";
  var_0.armtime = 0.05;
  var_0.vfxtag = "tag_origin";
  var_0.minedamagemin = 0;
  var_0.minedamagemax = 0;
  var_0.ontriggeredsfx = "motion_click";
  var_0.onlaunchsfx = "motion_spin";
  var_0.onexplodesfx = "motion_explode_default";
  var_0.launchheight = 64;
  var_0.launchtime = 0.65;
  var_0.ontriggeredfunc = scripts\cp\powers\coop_blackholegrenade::blackholeminetrigger;
  var_0.onexplodefunc = scripts\cp\powers\coop_blackholegrenade::blackholemineexplode;
  var_0.headiconoffset = 20;
  var_0.minedetectionradius = 200;
  var_0.minedetectionheight = 100;
  level.weaponconfigs["blackhole_grenade_mp"] = var_0;
  level.weaponconfigs["blackhole_grenade_zm"] = var_0;
  var_0 = spawnStruct();
  var_0.armingdelay = 1.5;
  var_0.detectionradius = 232;
  var_0.detectionheight = 512;
  var_0.detectiongraceperiod = 1;
  var_0.headiconoffset = 20;
  var_0.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var_0;
  var_0 = spawnStruct();
  var_1 = 800;
  var_2 = 200;
  var_0.radius_max_sq = var_1 * var_1;
  var_0.radius_min_sq = var_2 * var_2;
  var_0.onexplodesfx = "flashbang_explode_default";
  var_0.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var_0;
}

iteminits() {
  scripts\cp\powers\coop_portal_generator::portalgeneratorinit();
  scripts\cp\cp_blackholegun::init();
  clustergrenadeinit();
  throwingknifec4init();
}

throwingknifec4init() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx\iw7\_requests\mp\power\vfx_bio_spike_exp.vfx");
}

clustergrenadeinit() {
  level._effect["clusterGrenade_explode"] = loadfx("vfx\iw7\_requests\mp\vfx_cluster_gren_single_runner.vfx");
}

mpbuildweaponmap() {
  var_0 = ["mp\statstable.csv", "cp\zombies\mode_string_tables\zombies_statstable.csv"];
  level.weaponmapdata = [];

  foreach(var_2 in var_0) {
    for(var_3 = 1; tablelookup(var_2, 0, var_3, 0) != ""; var_3++) {
      var_4 = tablelookup(var_2, 0, var_3, 4);

      if(var_4 != "") {
        level.weaponmapdata[var_4] = spawnStruct();
        var_5 = tablelookup(var_2, 0, var_3, 0);

        if(var_5 != "") {
          level.weaponmapdata[var_4].number = var_5;
        }

        var_6 = tablelookup(var_2, 0, var_3, 1);

        if(var_6 != "") {
          level.weaponmapdata[var_4].group = var_6;
        }

        var_7 = tablelookup(var_2, 0, var_3, 5);

        if(var_7 != "") {
          level.weaponmapdata[var_4].perk = var_7;
        }

        var_8 = tablelookup(var_2, 0, var_3, 9);

        if(var_8 != "") {
          if(isDefined(level.weaponmapdata[var_4].attachdefaults)) {
            if(level.weaponmapdata[var_4].attachdefaults == "none") {
              level.weaponmapdata[var_4].attachdefaults = undefined;
            } else {
              level.weaponmapdata[var_4].attachdefaults = strtok(var_8, " ");
            }
          } else {
            level.weaponmapdata[var_4].attachdefaults = strtok(var_8, " ");
          }
        }

        level.weaponmapdata[var_4].selectableattachmentlist = [];
        level.weaponmapdata[var_4].selectableattachmentmap = [];

        for(var_9 = 0; var_9 < 20; var_9++) {
          var_10 = tablelookup(var_2, 0, var_3, 10 + var_9);

          if(isDefined(var_10) && var_10 != "") {
            var_11 = level.weaponmapdata[var_4].selectableattachmentlist.size;
            level.weaponmapdata[var_4].selectableattachmentlist[var_11] = var_10;
            level.weaponmapdata[var_4].selectableattachmentmap[var_10] = 1;
          }
        }

        var_12 = tablelookup(var_2, 0, var_3, 8);

        if(var_12 != "") {
          var_12 = float(var_12);
          level.weaponmapdata[var_4].speed = var_12;
        }
      }
    }
  }
}

buildweaponmaps() {
  var_0 = "mp\statstable.csv";
  var_1 = level.game_mode_statstable;
  level.weaponmap_toperk = [];
  level.weaponmap_toattachdefaults = [];
  level.weaponmap_tospeed = [];
  var_2 = 0;
  var_3 = 1;

  for(var_4 = 1; var_3 || var_4; var_2++) {
    if(tablelookup(var_0, 0, var_2, 0) == "") {
      var_3 = 0;
    }

    var_5 = tablelookup(var_0, 0, var_2, 4);
    var_6 = tablelookup(var_0, 0, var_2, 5);

    if(var_6 != "") {
      if(var_5 != "") {
        level.weaponmap_toperk[var_5] = var_6;
      }
    }

    var_7 = tablelookup(var_0, 0, var_2, 9);

    if(var_7 != "") {
      if(var_5 != "") {
        level.weaponmap_toattachdefaults[var_5] = strtok(var_7, " ");
      }
    }

    var_8 = tablelookup(var_0, 0, var_2, 8);

    if(var_8 != "") {
      if(var_5 != "") {
        var_8 = float(var_8);
        level.weaponmap_tospeed[var_5] = float(var_8);
      }
    }

    if(var_4) {
      if(tablelookup(var_1, 0, var_2, 0) == "") {
        var_4 = 0;
      }

      var_5 = tablelookup(var_1, 0, var_2, 4);
      var_6 = tablelookup(var_1, 0, var_2, 5);

      if(var_6 != "") {
        if(var_5 != "") {
          level.weaponmap_toperk[var_5] = var_6;
        }
      }

      var_7 = tablelookup(var_1, 0, var_2, 9);

      if(var_7 != "") {
        if(var_5 != "") {
          level.weaponmap_toattachdefaults[var_5] = strtok(var_7, " ");
        }
      }

      var_8 = tablelookup(var_1, 0, var_2, 8);

      if(var_8 != "") {
        if(var_5 != "") {
          var_8 = float(var_8);
          level.weaponmap_tospeed[var_5] = float(var_8);
        }
      }
    }
  }
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

playspinnerfx() {
  if(isDefined(self.config.mine_spin)) {
    self endon("death");
    var_0 = gettime() + 1000;

    while(gettime() < var_0) {
      wait 0.05;
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin1");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin3");
      wait 0.05;
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin2");
      playFXOnTag(self.config.mine_spin, self, "tag_fx_spin4");
    }
  }
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
  wait 0.65;
  self notify("detonateExplosive");
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

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.hits = 0;
    var_0 thread onplayerspawned();
    var_0 thread watchmissileusage();
    var_0 thread sniperdustwatcher();
  }
}

giverateye(var_0) {
  self.has_eye = 1;
  thread eye_activated(self);
}

takerateye(var_0) {
  self.has_eye = undefined;
  self notify("remove_eye");
}

eye_activated(var_0) {
  self.wearing_rat_king_eye = 1;
  level notify("rat_king_eye_activated", self);

  if(scripts\engine\utility::flag_exist("rk_fight_started") && !scripts\engine\utility::flag("rk_fight_started")) {
    thread handleratvisionburst(self);
    self setscriptablepartstate("rat_king_eye_light", "active");
    thread reapply_visionset_after_host_migration();
    thread watch_for_eye_remove();
  }
}

reapply_visionset_after_host_migration() {
  self endon("death");
  self endon("disconnect");
  self endon("removing_eye_from_player");
  level waittill("host_migration_begin");
  level waittill("host_migration_end");

  if(scripts\engine\utility::is_true(self.wearing_rat_king_eye)) {
    self setscriptablepartstate("rat_king_eye_light", "active");
  }
}

watch_for_eye_remove() {
  self notify("watch_for_eye_remove");
  self endon("watch_for_eye_remove");
  wait 5;

  if(scripts\engine\utility::is_true(self.wearing_rat_king_eye)) {
    remove_eye_effects();
  }
}

remove_eye_effects() {
  self.wearing_rat_king_eye = 0;
  level notify("rat_king_eye_deactivated");
  self notify("remove_eye");

  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0.1);
  } else {
    self visionsetnakedforplayer("", 0.1);
  }

  self setscriptablepartstate("rat_king_eye_light", "neutral");
}

sniperdustwatcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = undefined;

  for(;;) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }
    if(scripts\cp\utility::coop_getweaponclass(self getcurrentweapon()) != "weapon_sniper") {
      continue;
    }
    var_1 = anglesToForward(self.angles);

    if(!isDefined(var_0) || gettime() - var_0 > 2000) {
      var_0 = gettime();
      continue;
    }
  }
}

unset_scriptable_part_state_after_time(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self setscriptablepartstate("projectile", "inactive");
  var_1 notify("ranged_katana_missile_done");

  if(isDefined(self)) {
    self delete();
  }
}

watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    var_0 = waittill_missile_fire();

    switch (var_0.weapon_name) {
      case "remotemissile_projectile_mp":
        var_0 thread grenade_earthquake();
      case "iw7_harpoon_zm":
        break;
      case "iw7_harpoon3_zm":
        var_0 thread runharpoontraplogic(var_0, self);
        break;
      case "iw7_blackholegun_mp":
        var_0 thread scripts\cp\cp_blackholegun::missilespawned(var_0.weapon_name, var_0);
        break;
      case "iw7_harpoon1_zm":
        var_0.owner thread alt_acid_rain_dud_explode(var_0);
        break;
      case "iw7_harpoon4_zm":
        var_0.owner thread thundergun_harpoon_dud_explode(var_0);
        var_0.owner thread thundergun_harpoon(var_0.weapon_name, var_0);
        break;
      case "iw7_harpoon2_zm":
        var_0.owner thread ben_franklin_harpoon_dud_explode(var_0);
        var_0.owner thread ben_franklin_harpoon(var_0);
        break;
      default:
        break;
    }
  }
}

ben_franklin_harpoon_activate(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_3 = level._effect["hammer_of_dawn_lightning"];
  level notify("ben_franklin_lightning_pos", var_0);
  playFX(var_3, var_0, anglesToForward(self.angles), anglestoup(self.angles));
  playLoopSound(var_0, "harpoon2_impact");
  thread run_stun_logic(var_0, var_1, var_2, var_3);
}

run_stun_logic(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("disconnected");
  level endon("game_ended");
  var_4 = anglesToForward(self.angles);
  var_4 = vectornormalize(var_4);
  var_4 = var_4 * 100;
  var_5 = -1 * var_4;
  var_6 = anglestoleft(self.angles);
  var_6 = vectornormalize(var_6);
  var_6 = var_6 * 100;
  var_7 = -1 * var_6;

  if(isDefined(var_1)) {
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
  }

  var_8 = "reload_zap_screen";
  var_9 = max(1000, 0.5 * var_2);
  self radiusdamage(var_0, 128, var_9, var_9, self, "MOD_GRENADE_SPLASH", "iw7_harpoon2_zm_stun");
  scripts\engine\utility::waitframe();

  if(distance2dsquared(self.origin, var_0) <= 16384) {
    playfxontagforclients(level._effect[var_8], self, "tag_eye", self);
  }

  wait 0.25;
  var_10 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_11 = 65536;
  var_8 = "reload_zap_m";

  foreach(var_13 in var_10) {
    if(var_13.agent_type == "slasher" || var_13.agent_type == "superslasher") {
      continue;
    }
    if(distancesquared(var_13.origin, var_0) < var_11) {
      var_14 = var_13 gettagorigin("j_spineupper");
      var_13 thread zap_over_time(1, self);
      playFX(var_3, var_13.origin);
    }
  }

  if(isDefined(level.played_acid_rain_effect)) {
    level.played_ben_franklin_effect = undefined;
  }
}

play_stun_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "reload_zap_m";
  playLoopSound(var_4, "perk_blue_bolts_sparks");
  playFX(level._effect[var_5], var_4 + var_0);
  scripts\engine\utility::waitframe();
  playFX(level._effect[var_5], var_4 + var_1);
  scripts\engine\utility::waitframe();
  playFX(level._effect[var_5], var_4 + var_2);
  scripts\engine\utility::waitframe();
  playFX(level._effect[var_5], var_4 + var_3);
  scripts\engine\utility::waitframe();
}

zap_over_time(var_0, var_1) {
  self endon("death");
  self.stunned = 1;
  thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);

  while(var_0 > 0) {
    self.stun_hit_time = gettime() + 1500.0;
    wait 0.1;
    self getrandomarmkillstreak(1, self.origin, var_1, var_1, "MOD_GRENADE_SPLASH", "iw7_harpoon2_zm_stun");
    var_0 = var_0 - 1;
    wait 1.5;
  }

  self.stunned = undefined;
}

ben_franklin_harpoon_dud_explode(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 waittill("death");

  if(isDefined(var_0.origin)) {
    thread ben_franklin_harpoon_activate(var_0.origin, undefined, 500000000);
  }

  self notify("remove_this_function_since_you_missed_zomb");
}

ben_franklin_harpoon(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("remove_this_function_since_you_missed_zomb");
  self waittill("zombie_hit_by_ben", var_1, var_2, var_3);
  thread ben_franklin_harpoon_activate(var_1, var_2, var_3);
}

thundergun_harpoon_dud_explode(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 waittill("death");
  var_1 = var_0.origin;

  if(isDefined(var_0.origin)) {
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_3 = 160000;

    foreach(var_5 in var_2) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(!isDefined(var_5.agent_type)) {
        continue;
      }
      if(distancesquared(var_5.origin, var_1) < var_3) {
        var_5.do_immediate_ragdoll = 1;
        var_5.disable_armor = 1;
        var_5.customdeath = 1;
        playLoopSound(var_5.origin, "perk_blue_bolts_sparks");
        var_6 = anglesToForward(self.angles);
        var_7 = vectornormalize(var_6) * -100;

        if(isDefined(var_5.agent_type) && (var_5.agent_type != "slasher" && var_5.agent_type != "superslasher")) {
          var_5 giveflagcapturexp(vectornormalize(var_5.origin - (self.origin + var_7)) * 800 + (200, 0, 200));
        }

        wait 0.2;
        var_5.nocorpse = 1;
        var_5.full_gib = 1;

        if(isDefined(var_5.agent_type) && (var_5.agent_type == "slasher" || var_5.agent_type == "superslasher")) {
          var_5 getrandomarmkillstreak(var_5.health, var_5.origin, self, self, "MOD_UNKNOWN", "iw7_harpoon4_zm");
        } else {
          var_5 getrandomarmkillstreak(var_5.health + 1000, var_5.origin, self, self, "MOD_UNKNOWN", "iw7_harpoon4_zm");
        }
      }
    }
  }

  self notify("remove_this_function_since_you_missed_zomb");
}

fling_zombie_thundergun_harpoon(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("death");

  if(!isDefined(var_3)) {
    return;
  }
  var_3.angles = vectortoangles(var_1.origin - var_3.origin) + (0, 0, 180);
  var_4 = var_1.origin - var_3.origin;
  var_5 = anglesToForward(var_2.angles);
  var_6 = vectornormalize(var_5) * -100;
  self giveflagcapturexp(vectornormalize(self.origin - (var_2.origin + var_6)) * 800 + (200, 0, 200));
  wait 0.16;

  if(isDefined(var_2)) {
    var_1.do_immediate_ragdoll = 1;
    var_1.disable_armor = 1;
    var_1.customdeath = 1;
    wait 0.1;
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
    self getrandomarmkillstreak(self.health + 1000, var_1.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_harpoon4_zm");
  } else {
    self.nocorpse = 1;
    self.full_gib = 1;
    self getrandomarmkillstreak(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_harpoon4_zm");
  }
}

thundergun_harpoon(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("remove_this_function_since_you_missed_zomb");
  var_2 = 256;
  var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_4 = self.angles;
  var_5 = self getEye();

  while(isDefined(var_1)) {
    var_6 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_3, undefined, 24, var_2);
    self.closestenemies = var_6;
    var_7 = 0;

    foreach(var_9 in self.closestenemies) {
      if(!isDefined(var_9.agent_type)) {
        continue;
      }
      if(isDefined(var_1)) {
        if(distance2dsquared(var_1.origin, var_9.origin) < 16384) {
          if(isDefined(var_9.agent_type) && (var_9.agent_type == "slasher" || var_9.agent_type == "superslasher")) {
            var_9 getrandomarmkillstreak(var_9.health, var_9.origin, self, self, "MOD_UNKNOWN", "iw7_harpoon4_zm");
          } else {
            var_9 thread fling_zombie_thundergun_harpoon(var_9.health + 1000, var_9, self, var_1);
          }

          scripts\engine\utility::waitframe();
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

alt_acid_rain_launch_projectile_during_trail(var_0) {
  var_0 endon("death");

  while(isDefined(var_0)) {
    wait 0.3;

    if(!isDefined(var_0.origin) || !isDefined(var_0.angles)) {
      return;
    }
    var_1 = vectortoangles(anglestoup(var_0.angles));
    thread alt_acid_rain_activate(var_0.origin + (0, 0, 5), var_1);
    scripts\engine\utility::waitframe();
    thread alt_acid_rain_activate(scripts\engine\utility::drop_to_ground(var_0.origin), var_0.angles);
    wait 0.3;
  }
}

alt_acid_rain_dud_explode(var_0) {
  self endon("disconnect");
  self endon("death");
  var_1 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1);
  var_2 = var_0.angles;
  var_3 = var_0.origin;
  var_0 waittill("death");

  if(!isDefined(var_0.origin)) {
    return;
  }
  playFX(level._effect["acid_rain_explosion"], var_0.origin);
  scripts\engine\utility::waitframe();
  playFX(level._effect["acid_rain"], var_0.origin);
  var_4 = gettime();
  var_5 = var_0.origin;
  var_6 = spawn("trigger_radius", var_0.origin, 0, 128, 64);
  var_6 thread deal_damage_to_enemies(self, var_4);
  var_6 thread delete_after_time(self, var_4);
}

delete_after_time(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  while(gettime() <= var_1 + 3400) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(level.played_acid_rain_effect)) {
    level.played_acid_rain_effect = undefined;
  }

  self delete();
}

deal_damage_to_enemies(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  while(gettime() <= var_1 + 3400) {
    self waittill("trigger", var_2);

    if(!isDefined(var_2)) {
      continue;
    }
    if(!var_2 scripts\cp\utility::is_zombie_agent()) {
      continue;
    }
    if(isDefined(var_0)) {
      if(var_2.agent_type == "slasher" || var_2.agent_type == "superslasher") {
        var_2 getrandomarmkillstreak(0.1 * var_2.maxhealth, var_2.origin, var_0, var_0, "MOD_RIFLE_BULLET", "iw7_harpoon1_zm");
      } else {
        playFX(level._effect["acid_rain"], var_2.origin);
        var_2 getrandomarmkillstreak(var_2.maxhealth, var_2.origin, var_0, var_0, "MOD_RIFLE_BULLET", "iw7_harpoon1_zm");
      }

      continue;
    }

    var_2 getrandomarmkillstreak(var_2.maxhealth, var_2.origin, undefined, undefined, "MOD_RIFLE_BULLET", "iw7_harpoon1_zm");
  }
}

alt_acid_rain_activate(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = dropscavengerbag(var_0, var_1);
    var_4 = var_0 + var_3;
    magicbullet("iw7_acid_rain_projectile_zm", var_0, var_4, self);
    scripts\engine\utility::waitframe();
    playFX(level._effect["acid_rain_explosion"], var_4);
  }
}

dropscavengerbag(var_0, var_1) {
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

acid_rain_radial_activate() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("acid_rain_radial_activate", var_0);
    self radiusdamage(var_0, 300, 1000, 1000, self);
    scripts\engine\utility::waitframe();
  }
}

waittill_missile_fire() {
  self waittill("missile_fire", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      var_2 = getweaponbasename(var_1);

      if(isDefined(var_2)) {
        var_0.weapon_name = var_2;
      } else {
        var_0.weapon_name = var_1;
      }
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

update_harpoon_upgrade_quest(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_2);

  if(isDefined(level.animal_quest_volume) && scripts\engine\utility::flag("harpoon_upgrade_quest_active")) {
    if(ispointinvolume(var_0.origin, level.animal_quest_volume)) {
      var_3 = scripts\engine\utility::getstructarray("animal_statues", "script_noteworthy");
      var_4 = sortbydistance(var_3, var_0.origin)[0];
      level.animal_statue_kills[var_4.targetname]++;
    }
  }
}

runharpoontraplogic(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_2);
  var_3 = var_0.origin;
  var_4 = var_0.angles;
  var_5 = vectornormalize(anglesToForward(var_4));
  var_6 = vectornormalize(anglestoright(var_4));
  var_7 = vectorcross(var_5, var_6);
  var_0.angles = vectortoangles(var_7);
  var_8 = 3 * anglesToForward(var_0.angles);
  var_0.origin = var_0.origin + var_8;
  playLoopSound(var_0.origin, "weap_harpoon3_impact");
  wait 0.5;
  var_0 setscriptablepartstate("arrow_effects", "active");
  level.harpoon_projectiles[level.harpoon_projectiles.size] = var_0;

  if(level.harpoon_projectiles.size >= 6) {
    thread destroy_oldest_trap();
  }

  var_0.linked_to_targets = [];
  var_0.linked_fx = [];
  var_0.death_time = gettime() + 9000;
  var_0 thread connect_to_nearby_harpoon_projectiles(var_0, var_1);
  var_0 thread timeout_trap(var_0, var_1);
}

destroy_oldest_trap() {
  var_0 = level.harpoon_projectiles[0];
  var_0 notify("early_death");
  var_0 clean_up_trap_ent(var_0, var_0.origin);
}

timeout_trap(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("early_death");
  wait 9.95;
  var_2 = var_0.origin;
  wait 0.05;
  var_0 clean_up_trap_ent(var_0, var_2);
}

clean_up_trap_ent(var_0, var_1) {
  if(scripts\engine\utility::array_contains(level.harpoon_projectiles, var_0)) {
    level.harpoon_projectiles = scripts\engine\utility::array_remove(level.harpoon_projectiles, var_0);
  }

  level.harpoon_projectiles = scripts\engine\utility::array_removeundefined(level.harpoon_projectiles);
  var_2 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var_1);
  triggerfx(var_2);
  playLoopSound(var_1, "weap_harpoon3_trap_off");
  thread placeequipmentfailedcleanup(var_2);
  var_0 delete();
}

connect_to_nearby_harpoon_projectiles(var_0, var_1) {
  var_0 endon("death");
  var_2 = scripts\engine\trace::create_world_contents();

  for(;;) {
    var_3 = [];
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.harpoon_projectiles, [var_0], 2, 128);
    clean_up_links(var_0, var_4);

    foreach(var_6 in var_4) {
      if(scripts\engine\utility::array_contains(var_0.linked_to_targets, var_6)) {
        continue;
      }
      if(scripts\engine\utility::array_contains(var_6.linked_to_targets, var_0)) {
        continue;
      }
      var_7 = scripts\engine\trace::ray_trace(var_0 gettagorigin("TAG_FX"), var_6 gettagorigin("TAG_FX"), var_0, var_2);

      if(var_7["fraction"] < 0.95) {
        continue;
      } else {
        var_3[var_3.size] = var_6;
        var_0.linked_to_targets[var_0.linked_to_targets.size] = var_6;
      }
    }

    foreach(var_10 in var_3) {
      var_0.linked_fx[var_10.birthtime] = var_10;
      var_11 = distance(var_0.origin, var_10.origin);
      var_12 = spawn("trigger_rotatable_radius", var_0 gettagorigin("TAG_FX"), 0, 3, var_11);
      var_13 = vectortoangles(var_10 gettagorigin("TAG_FX") - var_0 gettagorigin("TAG_FX")) + (-90, 0, 0);
      var_12.angles = (90, var_13[1], var_13[2]);
      var_0 thread play_vfx_between_points_trap_gun(var_0, var_10, var_12);
      var_0 thread damage_enemies_in_trigger(var_10, var_0, var_12, var_1);
      thread clean_up_trigger_on_death(var_10, var_0, var_12);
    }

    wait 1;
  }
}

play_vfx_between_points_trap_gun(var_0, var_1, var_2) {
  var_3 = playfxontagsbetweenclients(level._effect["trap_ww_beam"], var_0, "tag_fx", var_1, "tag_fx");
  thread kill_fx_on_death(var_0, var_1, var_2, var_3);
}

kill_fx_on_death(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = var_0.origin;
  var_5 = var_0 gettagorigin("TAG_FX");
  var_6 = var_1 gettagorigin("TAG_FX");
  var_7 = max((var_1.death_time - gettime()) / 1000, 0);
  var_8 = max((var_0.death_time - gettime()) / 1000 - var_7 - 0.2, 0);
  thread play_sfx_on_harpoon_trap(var_0, var_1, var_2);

  if(var_7 > 0 && isDefined(var_0) && isDefined(var_1)) {
    scripts\cp\utility::waittill_any_ents_or_timeout_return(var_7, var_0, "death", var_1, "death", var_2, "death");
  } else if(isDefined(var_0) && isDefined(var_1)) {
    scripts\engine\utility::waittill_any_ents(var_0, "death", var_1, "death", var_2, "death");
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }

  playfxbetweenpoints(level._effect["trap_ww_beam_death"], var_5, vectortoangles(var_6 - var_5), var_6);
}

play_sfx_on_harpoon_trap(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_1 gettagorigin("TAG_FX");
  var_5 = [];
  var_5[0] = var_3;
  var_5[1] = var_4;
  var_6 = max((var_1.death_time - gettime()) / 1000, 0);
  var_7 = averagepoint(var_5);
  playLoopSound(var_7, "weap_harpoon3_trap_on");
  var_8 = spawn("script_origin", var_7);
  wait 0.05;
  var_8 playLoopSound("weap_harpoon3_trap_lp");

  if(var_6 > 0 && isDefined(var_0) && isDefined(var_1)) {
    scripts\cp\utility::waittill_any_ents_or_timeout_return(var_6, var_0, "death", var_1, "death", var_2, "death");
  } else if(isDefined(var_0) && isDefined(var_1)) {
    scripts\engine\utility::waittill_any_ents(var_0, "death", var_1, "death", var_2, "death");
  }

  wait 1;
  var_8 stoploopsound("weap_harpoon3_trap_lp");
  wait 0.05;
  var_8 delete();
}

damage_enemies_in_trigger(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_2 endon("death");
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    var_2 waittill("trigger", var_4);

    if(!var_4 scripts\cp\utility::is_zombie_agent()) {
      continue;
    }
    if(var_4.agent_type == "slasher" || var_4.agent_type == "superslasher") {
      if(scripts\engine\utility::is_true(var_4.got_hit_once)) {
        continue;
      } else {
        var_4 thread do_damage_on_slasher_once(var_4, var_3);
      }
    }

    thread run_harpoon_laser_death(var_4, var_3);
  }
}

do_damage_on_slasher_once(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  var_0.got_hit_once = 1;

  if(var_0.agent_type == "superslasher") {
    wait 5.0;
  } else {
    wait 2.0;
  }

  var_0.got_hit_once = undefined;
}

run_harpoon_laser_death(var_0, var_1) {
  var_0.atomize_me = 1;
  var_0.not_killed_by_headshot = 1;

  if(isDefined(var_1)) {
    var_0 getrandomarmkillstreak(var_0.health, var_0.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_harpoon3_zm");
  } else {
    var_0 getrandomarmkillstreak(var_0.health, var_0.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_harpoon3_zm");
  }
}

clean_up_trigger_on_death(var_0, var_1, var_2) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(var_0, "death", var_1, "death");

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

clean_up_links(var_0, var_1) {
  var_0.linked_to_targets = scripts\engine\utility::array_removeundefined(var_0.linked_to_targets);

  foreach(var_3 in var_0.linked_to_targets) {
    if(isDefined(var_0.linked_fx[var_3.birthtime])) {
      var_0.linked_fx[var_3.birthtime] = undefined;
    }

    if(!scripts\engine\utility::array_contains(var_1, var_3) && scripts\engine\utility::array_contains(var_0.linked_to_targets, var_3)) {
      var_0.linked_to_targets = scripts\engine\utility::array_remove(var_0.linked_to_targets, var_3);
    }
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.currentweaponatspawn = self getcurrentweapon();
    self.empendtime = 0;
    self.concussionendtime = 0;
    self.hits = 0;

    if(!isDefined(self.trackingweapon)) {
      self.trackingweapon = "";
      self.trackingweapon = "none";
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweapondeaths = 0;
    }

    thread watchgrenadeusage();
    thread stancerecoiladjuster();
    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    thread updatesavedlastweapon();
    thread watchforweaponchange();
    thread watch_slasher_killed();
    thread monitorlauncherspawnedgrenades();
    self.currentweaponatspawn = undefined;
    self.trophyremainingammo = undefined;
  }
}

monitorlauncherspawnedgrenades() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    var_0 = waittill_grenade_fire();

    if(isDefined(var_0.weapon_name)) {
      if(glprox_trygetweaponname(var_0.weapon_name) == "stickglprox") {
        semtexused(var_0);
      }
    }
  }
}

glprox_trygetweaponname(var_0) {
  if(var_0 != "none" && getweaponbasename(var_0) == "iw7_glprox_mp") {
    if(scripts\cp\utility::isaltmodeweapon(var_0)) {
      var_1 = getweaponattachments(var_0);
      var_0 = var_1[0];
    } else {
      var_0 = getweaponbasename(var_0);
    }
  }

  return var_0;
}

stancerecoiladjuster() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(!isplayer(self)) {
    return;
  }
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
    var_3 = scripts\cp\utility::coop_getweaponclass(var_1);

    if(isDefined(var_3)) {
      if(var_3 == "weapon_lmg") {
        setrecoilscale(0, 40);
        return;
      }

      if(var_3 == "weapon_sniper") {
        if(issubstr(var_1, "barrelbored")) {
          setrecoilscale(0, 20 + var_2);
          return;
        }

        setrecoilscale(0, 40 + var_2);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(var_0 == "crouch") {
    var_3 = scripts\cp\utility::coop_getweaponclass(var_1);

    if(isDefined(var_3)) {
      if(var_3 == "weapon_lmg") {
        setrecoilscale(0, 10);
        return;
      }

      if(var_3 == "weapon_sniper") {
        if(issubstr(var_1, "barrelbored")) {
          setrecoilscale(0, 10 + var_2);
          return;
        }

        setrecoilscale(0, 20 + var_2);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(var_2 > 0) {
    setrecoilscale(0, var_2);
  } else {
    setrecoilscale();
  }
}

setrecoilscale(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var_0;
  } else {
    self.recoilscale = self.recoilscale + var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self.recoilscale) && var_1 < self.recoilscale) {
      var_1 = self.recoilscale;
    }

    var_2 = 100 - var_1;
  } else {
    var_2 = 100 - self.recoilscale;
  }

  if(var_2 < 0) {
    var_2 = 0;
  }

  if(var_2 > 100) {
    var_2 = 100;
  }

  if(var_2 == 100) {
    self getweaponrankforxp();
    return;
  }

  self getweaponrankinfomaxxp(var_2);
}

isrecoilreducingweapon(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = 0;

  if(issubstr(var_0, "kbsscope") || issubstr(var_0, "m8scope_zm") || issubstr(var_0, "cheytacscope")) {
    var_1 = 1;
  }

  return var_1;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 40;
}

watch_slasher_killed() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("achievement_done");

  for(;;) {
    self waittill("slasher_killed_by_own_weapon", var_0, var_1);
    level thread slasher_killed_vo(var_0);
    scripts\cp\zombies\achievement::update_achievement("TABLES_TURNED", 1);
    self notify("achievement_done");
  }
}

slasher_killed_vo(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(var_0.vo_prefix == "p5_") {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_death_p5", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  }

  wait 5;
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_slasher", "zmb_comment_vo", "highest", 20, 0, 0, 1);
}

watchforweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0 == "none") {
      continue;
    }
    var_1 = getweaponbasename(var_0);

    if(isvalidweapon(var_0)) {
      self.last_valid_weapon = var_0;
    }

    switch (var_1) {
      case "iw7_axe_zm_pap2":
      case "iw7_axe_zm_pap1":
      case "iw7_axe_zm":
        if(get_weapon_level(var_0) > 1) {}

        break;
      default:
        break;
    }
  }
}

isvalidweapon(var_0) {
  var_1 = level.additional_laststand_weapon_exclusion;

  if(var_0 == "none") {
    return 0;
  } else if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 0;
  } else if(scripts\engine\utility::array_contains(var_1, getweaponbasename(var_0))) {
    return 0;
  } else if(scripts\cp\utility::is_melee_weapon(var_0, 1)) {
    return 0;
  } else {
    return 1;
  }
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

  for(;;) {
    self waittill("weapon_change", var_1);

    if(var_1 == "none") {
      self.saved_lastweapon = var_0;
      continue;
    }

    var_2 = weaponinventorytype(var_1);

    if(var_2 != "primary" && var_2 != "altmode") {
      self.saved_lastweapon = var_0;
      continue;
    }

    self[[level.move_speed_scale]]();
    self.saved_lastweapon = var_0;
    var_0 = var_1;
  }
}

watchgrenadeusage() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  self.throwinggrenade = undefined;
  self.gotpullbacknotify = 0;

  if(!isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = [];
    self.plantedtacticalequip = [];
  }

  for(;;) {
    self waittill("grenade_pullback", var_0);
    var_1 = self func_8556();

    if(var_1 != "none") {
      continue;
    }
    if(isDefined(level.custom_grenade_pullback_func)) {
      thread[[level.custom_grenade_pullback_func]](self, var_0);
    }

    thread watchoffhandcancel();
    self.throwinggrenade = var_0;

    if(var_0 == "c4_zm") {
      thread beginc4tracking();
    }

    begingrenadetracking();
    self.throwinggrenade = undefined;
  }
}

watchoffhandcancel() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");

  if(isDefined(self.changingweapon) && self.changingweapon != self getcurrentweapon()) {
    self.changingweapon = undefined;
  }
}

beginc4tracking() {
  self notify("beginC4Tracking");
  self endon("beginC4Tracking");
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

begingrenadetracking() {
  self endon("offhand_end");
  var_0 = gettime();
  var_1 = waittill_grenade_fire();

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_1.weapon_name)) {
    return;
  }
  self.changingweapon = undefined;

  switch (var_1.weapon_name) {
    case "thermobaric_grenade_mp":
    case "frag_grenade_mp":
    case "frag_grenade_zm":
      if(gettime() - var_0 > 1000) {
        var_1.iscooked = 1;
      }

      var_1 thread grenade_earthquake();
      var_1.originalowner = self;
      break;
    case "cluster_grenade_zm":
      var_1.clusterticks = var_1.ticks;

      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1.originalowner = self;
      var_1 thread clustergrenadeused();
      var_1 thread grenade_earthquake();
      break;
    case "zfreeze_semtex_mp":
    case "semtex_zm":
    case "semtex_mp":
      thread semtexused(var_1);
      break;
    case "c4_zm":
      thread scripts\cp\powers\coop_c4::c4_used(var_1);
      break;
    case "smoke_grenade_mp":
      var_1 thread watchsmokeexplode();
      break;
    case "claymore_mp":
      thread claymoreused(var_1);
      break;
    case "concussion_grenade_mp":
      var_1 thread watchconcussiongrenadeexplode();
      break;
    case "bouncingbetty_mp":
      thread mineused(var_1, ::spawnmine);
      break;
    case "throwingknifejugg_mp":
    case "throwingknifec4_mp":
    case "throwingknife_mp":
      level thread throwingknifeused(self, var_1, var_1.weapon_name);
      break;
    case "zom_repulsor_mp":
      var_1 delete();
      break;
    case "gas_grenade_mp":
      var_1 thread watchgasgrenadeexplode();
      break;
    case "splash_grenade_zm":
    case "splash_grenade_mp":
      var_1 thread grenade_earthquake();
      thread scripts\cp\cp_splash_grenade::splashgrenadeused(var_1);
      break;
    case "portal_generator_zm":
    case "portal_generator_mp":
      thread scripts\cp\powers\coop_portal_generator::portalgeneratorused(var_1);
      break;
    case "ztransponder_mp":
    case "transponder_mp":
      thread scripts\cp\powers\coop_transponder::transponder_use(var_1);
      break;
    case "micro_turret_zm":
    case "micro_turret_mp":
      thread scripts\cp\powers\coop_microturret::microturret_use(var_1);
      break;
    case "blackhole_grenade_zm":
    case "blackhole_grenade_mp":
      thread scripts\cp\powers\coop_blackholegrenade::blackholegrenadeused(var_1);
      break;
    case "trip_mine_mp":
      thread scripts\cp\powers\coop_trip_mine::tripmine_used(var_1);
      break;
    case "heart_cp":
      thread heart_used();
      break;
    case "rat_king_eye_cp":
      thread eye_activated();
      break;
  }
}

rat_executevisuals(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  scripts\engine\utility::waittill_any_timeout(var_0, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

handleratvisionburst(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 thread rat_executevisuals(2.4);
}

isinvalidzone(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray("power_exclusion_volume", "targetname");

  if(isDefined(var_5)) {
    if(isDefined(level.neil) && isDefined(level.neil.upper_body)) {
      if(var_5 == level.neil || var_5 == level.neil.upper_body) {
        return 0;
      }
    }

    if(isDefined(level.boat_vehicle)) {
      if(var_5 == level.boat_vehicle) {
        return 0;
      }
    }

    if(isDefined(var_5.targetname) && var_5.targetname == "beginning_area_balloons") {
      return 0;
    }
  }

  if(isDefined(var_1)) {
    var_6 = scripts\engine\utility::array_combine(var_6, var_1);
  }

  foreach(var_8 in var_6) {
    if(ispointinvolume(var_0, var_8)) {
      return 0;
    }
  }

  if(scripts\engine\utility::is_true(var_4) && !_ispointonnavmesh(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_3)) {
    if(_navtrace(var_2.origin, var_0)) {
      return 0;
    }
  }

  return 1;
}

placeequipmentfailed(var_0, var_1, var_2, var_3) {
  if(isplayer(self)) {
    self playlocalsound("scavenger_pack_pickup");
  }

  if(scripts\engine\utility::is_true(var_1)) {
    var_4 = undefined;

    if(isplayer(self)) {
      self playlocalsound("ww_magicbox_laughter");

      if(isDefined(var_3)) {
        var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
      } else {
        var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self);
      }
    } else {
      var_4 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2);
    }

    triggerfx(var_4);
    thread placeequipmentfailedcleanup(var_4);
  }
}

placeequipmentfailedcleanup(var_0) {
  wait 2;
  var_0 delete();
}

spawnmine(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (0, randomfloat(360), 0);
  }

  var_4 = level.weaponconfigs[var_2];
  var_5 = spawn("script_model", var_0);
  var_5.angles = var_3;
  var_5.owner = var_1;
  var_5.weapon_name = var_2;
  var_5.config = var_4;
  var_5 setModel(var_4.model);
  var_5 setotherent(var_1);
  var_5.killcamoffset = (0, 0, 4);
  var_5.killcament = spawn("script_model", var_5.origin + var_5.killcamoffset);
  var_5.killcament setscriptmoverkillcam("explosive");
  var_1 onlethalequipmentplanted(var_5);

  if(isDefined(var_4.mine_beacon)) {
    var_5 thread doblinkinglight("tag_fx", var_4.mine_beacon["friendly"], var_4.mine_beacon["enemy"]);
  }

  var_6 = undefined;

  if(self != level) {
    var_6 = self getlinkedparent();
  }

  var_5 explosivehandlemovers(var_6);
  var_5 thread mineproximitytrigger(var_6);
  var_5 thread grenade_earthquake();
  var_5 thread mineselfdestruct();
  var_5 thread mineexplodeonnotify();
  level thread monitordisownedequipment(var_1, var_5);
  return var_5;
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.mineselfdestructtime + randomfloat(0.4));
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

mineexplodeonnotify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self.owner;
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
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
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
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

mineproximitytrigger(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_1 = self.config;
  wait(var_1.armtime);

  if(isDefined(var_1.mine_beacon)) {
    thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  }

  var_2 = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var_2.owner = self;
  var_2.team = var_2.owner.team;
  thread minedeletetrigger(var_2);

  if(isDefined(var_0)) {
    var_2 getrankxp();
    var_2 linkto(var_0);
  }

  self.damagearea = var_2;

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isplayer(var_3)) {
      wait 0.05;
      continue;
    }

    if(var_3 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound(self.config.ontriggeredsfx);
  explosivetrigger(var_3, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(var_0) {
  scripts\engine\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_0)) {
    var_0 delete();
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
      if(self.owner[[var_3]](var_6)) {
        playfxontagforclients(var_0, self, var_2, var_6);
      } else {
        playfxontagforclients(var_1, self, var_2, var_6);
      }

      wait 0.05;
    }
  }
}

checkplayer(var_0) {
  return self == var_0;
}

checkteam(var_0) {
  return self.team == var_0.team;
}

onjointeamblinkinglight(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  for(;;) {
    level waittill("joined_team", var_4);

    if(self.owner[[var_3]](var_4)) {
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

takeheart(var_0) {
  self notify("remove_heart");
  self.has_heart = undefined;
}

heart_used() {
  self endon("disconnect");
  self endon("remove_heart");
  self notify("beginHeartTracking");
  self endon("beginHeartTracking");
  self endon("death");
  var_0 = self func_8513("ges_heart_pull", "explode");
  var_1 = self getgestureanimlength("ges_heart_pull");
  self.changingweapon = undefined;
  var_2 = self.origin;
  var_3 = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(var_5 in var_3) {
    if(isDefined(var_5.flung) || isDefined(var_5.agent_type) && (var_5.agent_type == "zombie_brute" || var_5.agent_type == "zombie_ghost" || var_5.agent_type == "zombie_grey" || var_5.agent_type == "slasher" || var_5.agent_type == "superslasher")) {
      continue;
    }
    if(distancesquared(var_5.origin, var_2) <= 65536) {
      if(var_5 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        var_5.scripted_mode = 1;
        var_5.ignoreall = 1;
        var_5 give_mp_super_weapon(var_5.origin);
      }

      var_5.scripted_mode = 1;
      var_5.ignoreall = 1;
      var_5 give_mp_super_weapon(var_5.origin);
      var_5.flung = 1;
      var_5.do_immediate_ragdoll = 1;
      var_5.disable_armor = 1;
      var_5.full_gib = 1;
      var_5.nocorpse = 1;
      var_5 setsolid(0);
      playFX(level._effect["rat_swarm_cheap"], var_5 gettagorigin("j_spine4"), anglesToForward(var_5.angles));
      thread deal_damage(var_5, self);
    }
  }

  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("heart_used", 1);
}

use_heart_notify() {
  self notify("heart_used", 1);
}

deal_damage(var_0, var_1) {
  var_0 endon("death");
  wait 0.7;
  var_0.scripted_mode = undefined;
  var_2 = var_0 gettagorigin("j_spine4");
  playFX(level._effect["gore"], var_2, (1, 0, 0));
  playLoopSound(var_2, "gib_fullbody");
  var_1 earthquakeforplayer(0.5, 1.5, var_2, 120);
  scripts\engine\utility::waitframe();

  if(isDefined(var_0)) {
    var_0 getrandomarmkillstreak(var_0.health + 100000, var_0.origin, var_1, var_1, "MOD_EXPLOSIVE", "heart_cp");
  }
}

watchgasgrenadeexplode() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  thread ongasgrenadeimpact(var_0, var_1);
}

ongasgrenadeimpact(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_1, 0, 128, 160);
  var_2.owner = var_0;
  var_3 = 128;
  var_4 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), var_1);
  triggerfx(var_4);
  wait 1.0;

  for(var_5 = 8.0; var_5 > 0.0; var_5 = var_5 - 0.2) {
    foreach(var_7 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
      if(isDefined(var_7.agent_type) && (var_7.agent_type == "zombie_brute" || var_7.agent_type == "superslasher" || var_7.agent_type == "slasher" || var_7.agent_type == "zombie_grey")) {
        continue;
      }
      var_8 = getdamagefromzombietype(var_7);

      if(isalive(var_7)) {
        var_7 applygaseffect(var_0, var_1, var_2, var_2, int(var_8));
      }
    }

    wait 0.2;
  }

  var_4 delete();
  wait 2.0;
  var_2 delete();

  foreach(var_7 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isalive(var_7)) {
      var_7.flame_damage_time = undefined;
    }
  }
}

getdamagefromzombietype(var_0) {
  if(isalive(var_0)) {
    if(scripts\engine\utility::is_true(var_0.is_suicide_bomber)) {
      return int(min(1000, var_0.maxhealth * 0.25));
    } else {
      return int(min(1000, var_0.maxhealth * 0.1));
    }
  } else {
    return 150;
  }
}

applygaseffect(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(self) && self istouching(var_2)) {
    if(var_0 scripts\cp\utility::isenemy(self)) {
      var_3 radiusdamage(self.origin, 1, var_4, var_4, var_0, "MOD_GRENADE_SPLASH", "gas_grenade_mp");
      self.flame_damage_time = gettime() + 200;
    }
  }
}

throwingknifeused(var_0, var_1, var_2) {
  if(var_2 == "throwingknifec4_mp") {
    var_1 makeunusable();
    var_1 thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(var_0, var_1);
  var_3 = undefined;
  var_4 = undefined;
  var_1 waittill("missile_stuck", var_3, var_4);
  var_5 = isDefined(var_4) && var_4 == "tag_flicker";
  var_6 = isDefined(var_4) && var_4 == "tag_weapon";

  if(isDefined(var_3) && (isplayer(var_3) || isagent(var_3)) && var_5) {
    var_3 notify("shield_hit", var_1);
  }

  if(isDefined(var_3) && (isplayer(var_3) || isagent(var_3)) && !var_6 && !var_5) {
    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(var_3, var_1)) {
      var_1 delete();
      return;
    } else if(var_2 == "throwingknifec4_mp") {
      throwingknifec4detonate(var_1, var_3, var_0);
    }
  }

  if(isDefined(var_1.giveknifeback)) {
    throwingknifeused_trygiveknife(var_0, var_1.power);
    var_1 delete();
  }
}

throwingknifedamagedvictim(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_3) && var_3 == var_1) {
      if(var_7 == "throwingknifeteleport_mp" && !isDefined(var_1.knifeteleownerinvalid)) {
        throwingknifeteleport(var_1, var_2, var_0, 1);
        var_1.giveknifeback = 1;
      }

      break;
    }
  }
}

watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }
}

throwingknifeused_trygiveknife(var_0, var_1, var_2) {
  var_3 = var_0 getweaponammoclip(var_2);
  var_4 = 2;
  var_5 = undefined;

  if(var_3 >= var_4) {
    var_5 = 0;
  } else {
    var_0 setweaponammoclip(var_2, var_3 + 1);
    var_0 thread hudicontype("throwingknife");
    var_5 = 1;
  }

  return var_5;
}

hudicontype(var_0) {
  var_1 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var_1 = 1;
  }

  if(!isplayer(self)) {
    return;
  }
  switch (var_0) {
    case "scavenger":
    case "throwingknife":
      if(!var_1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "boxofguns":
      if(!var_1) {
        self playlocalsound("mp_box_guns_ammo");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
    case "oracle":
      if(!var_1) {
        self playlocalsound("oracle_radar_pulse_plr");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_0);
      }

      break;
  }
}

throwingknifeteleport(var_0, var_1, var_2, var_3) {
  var_2 playlocalsound("blinkknife_teleport");
  var_2 playsoundonmovingent("blinkknife_teleport_npc");
  playLoopSound(var_0.origin, "blinkknife_impact");
  thread throwingknifeteleport_fxstartburst(var_2, var_1);
  var_4 = var_1 func_8113();

  if(isDefined(var_4)) {
    var_4 setcontents(0);
  }

  var_5 = [];

  foreach(var_7 in level.characters) {
    if(!isDefined(var_7) || !isalive(var_7) || var_7 == var_1 || var_7 == var_2 || !var_2 scripts\cp\utility::isenemy(var_7)) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  var_5 = sortbydistance(var_5, var_1.origin);
  var_9 = var_2 gettagorigin("TAG_EYE");
  var_10 = var_1.origin;
  var_11 = var_1.origin + (0, 0, var_9[2] - var_2.origin[2]);
  var_12 = var_2.angles;

  foreach(var_14 in var_5) {
    var_15 = (var_14.origin[0], var_14.origin[1], var_14 gettagorigin("TAG_EYE")[2]);

    if(distancesquared(var_14.origin, var_1.origin) < 230400 && sighttracepassed(var_11, var_15, 0, undefined)) {
      var_12 = vectortoangles(var_15 - var_11);
      break;
    }
  }

  var_2 setorigin(var_1.origin, !var_3);
  var_2 setplayerangles(var_12);
  throwingknifeteleport_fxendburst(var_2, var_1);
}

throwingknifeteleport_fxstartburst(var_0, var_1) {
  var_2 = var_1.origin - var_0.origin;
  var_3 = var_0.origin + (0, 0, 32);
  var_4 = vectornormalize(var_2);
  var_5 = vectornormalize(vectorcross(var_2, (0, 0, 1)));
  var_6 = vectorcross(var_5, var_4);
  var_7 = _axistoangles(var_4, var_5, var_6);
  var_8 = 0;

  if(var_8) {
    var_9 = spawn("script_model", var_3);
    var_9.angles = var_7;
    var_9 setModel("tag_origin");
    var_9 hidefromplayer(var_0);
    scripts\engine\utility::waitframe();
    _playfxontagforteam(scripts\engine\utility::getfx("vfx_knife_tele_start_friendly"), var_9, "tag_origin", var_0.team);
    wait 3.0;
    var_9 delete();
  } else {
    var_10 = spawn("script_model", var_3);
    var_10.angles = var_7;
    var_10 setModel("tag_origin");
    var_10 hidefromplayer(var_0);
    scripts\engine\utility::waitframe();

    foreach(var_12 in level.players) {
      var_10 hidefromplayer(var_12);
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_tele_start_friendly"), var_10, "tag_origin");
    wait 3.0;
    var_10 delete();
  }
}

recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.disttravelled = 0;
  var_0 = self.origin;

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_timeout(0.15, "death", "missile_stuck");

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

throwingknifeteleport_fxendburst(var_0, var_1) {}

throwingknifec4detonate(var_0, var_1, var_2) {
  var_1 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var_0.origin);
  var_0 radiusdamage(var_0.origin, 180, 1200, 600, var_2, "MOD_EXPLOSIVE", var_0.weapon_name);
  var_0 thread grenade_earthquake();
  var_0 notify("explode", var_0.origin);
  var_0 delete();
}

throwingknifeused_recordownerinvalid(var_0, var_1) {
  var_1 endon("missile_stuck");
  var_1 endon("death");
  var_0 scripts\engine\utility::waittill_any("death", "disconnect");
  var_1.knifeteleownerinvalid = 1;
}

watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  stunenemiesinrange(var_0, self.owner);
}

stunenemiesinrange(var_0, var_1) {
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, var_2, undefined, 24, 256);

  foreach(var_5 in var_3) {
    if(!var_5 scripts\cp\utility::agentisfnfimmune()) {
      var_5 thread fx_stun_damage(var_5, var_1);
    }
  }
}

fx_stun_damage(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(var_0.stun_hit_time)) {
    if(gettime() > var_0.stun_hit_time) {
      if(var_0 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        var_0.scripted_mode = 1;
        var_0.ignoreall = 1;
        var_0 give_mp_super_weapon(var_0.origin);
      }

      var_0.allowpain = 1;
      var_0.stun_hit_time = gettime() + 1000;
      var_0.stunned = 1;
    } else {
      return;
    }
  } else {
    if(var_0 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
      var_0.scripted_mode = 1;
      var_0.ignoreall = 1;
      var_0 give_mp_super_weapon(var_0.origin);
    }

    var_0.allowpain = 1;
    var_0.stun_hit_time = gettime() + 1000;
    var_0.stunned = 1;
  }

  var_0 getrandomarmkillstreak(1, var_0.origin, var_1, var_1, "MOD_GRENADE_SPLASH", "concussion_grenade_mp");
  wait 1;

  if(var_0 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
    var_0.scripted_mode = 0;
    var_0.ignoreall = 0;
  }

  var_0.allowpain = 0;
  var_0.stunned = undefined;
}

mineused(var_0, var_1) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 thread minethrown(self, var_0.weapon_name, var_1);
}

minethrown(var_0, var_1, var_2, var_3) {
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

  var_5 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_6 = var_5["position"];

  if(var_5["fraction"] == 1) {
    var_6 = getgroundposition(self.origin, 12, 0, 32);
    var_5["normal"] = var_5["normal"] * -1;
  }

  var_7 = vectornormalize(var_5["normal"]);
  var_8 = vectortoangles(var_7);
  var_8 = var_8 + (90, 0, 0);
  var_9 = [[var_2]](var_6, var_0, var_1, var_8);
  var_9 thread minedamagemonitor();
  self delete();
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(is_hive_explosion(var_0, var_4)) {
      break;
    }
    if(!isplayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(isDefined(var_9) && isendstr(var_9, "betty_mp")) {
      continue;
    }
    if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9) {
        case "concussion_grenade_mp":
        case "smoke_grenadejugg_mp":
        case "smoke_grenade_mp":
        case "flash_grenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var_0)) {
    self.damagedby = var_0;
  }

  if(isplayer(var_0)) {
    var_0 scripts\cp\cp_damage::updatedamagefeedback("bouncing_betty");
  }

  self notify("detonateExplosive", var_0);
}

is_hive_explosion(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.classname)) {
    return 0;
  }

  return var_0.classname == "scriptable" && var_1 == "MOD_EXPLOSIVE";
}

claymoreused(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 hide();
  var_0 scripts\engine\utility::waittill_any_timeout(0.05, "missile_stuck");

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
  onlethalequipmentplanted(var_0);
  var_0 thread ondetonateexplosive();
  var_0 thread c4empdamage();
  var_0 thread claymoredetonation(var_5);
  self.changingweapon = undefined;
  level thread monitordisownedequipment(self, var_0);
}

claymoredetonation(var_0) {
  self endon("death");
  var_1 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);

  if(isDefined(var_0)) {
    var_1 getrankxp();
    var_1 linkto(var_0);
  }

  thread deleteondeath(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.owner)) {
        if(var_2 == self.owner) {
          continue;
        }
        if(isDefined(var_2.owner) && var_2.owner == self.owner) {
          continue;
        }
      }

      if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_2, 0)) {
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
  self notify("detonateExplosive");
}

explosivetrigger(var_0, var_1, var_2) {
  if(isplayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_delaymine")) {
    var_0 notify("triggeredExpl", var_2);
    var_1 = level.delayminetime;
  }

  wait(var_1);
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
  wait 0.05;

  if(isDefined(var_0)) {
    if(isDefined(var_0.trigger)) {
      var_0.trigger delete();
    }

    var_0 delete();
  }
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

equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

makeexplosiveunusable() {
  self notify("equipmentWatchUse");
  self.trigger delete();
}

makeexplosivetargetablebyai(var_0) {
  scripts\cp\utility::make_entity_sentient_cp(self.owner.team);

  if(!isDefined(var_0) || !var_0) {
    self makeentitynomeleetarget();
  }
}

watchsmokeexplode() {
  level endon("smokeTimesUp");
  var_0 = self.owner;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  var_2 = 22500;
  var_3 = 12;
  var_4 = spawn("script_model", var_1);
  var_4.origin = var_1 + (0, 0, 56);
  var_4 makeentitysentient("allies", 1);
  var_4.health = 100000;
  var_4.maxhealth = 100000;
  var_4.threatbias = 10000;
  var_4 setthreatbiasgroup("players");
  level thread waitsmoketime(12, 22500, var_1, var_4);

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }
    var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(var_7 in var_5) {
      if(var_7.species == "alien") {
        continue;
      }
      if(isDefined(var_7.smoked)) {
        continue;
      }
      var_8 = distance2dsquared(var_1, var_7.origin);

      if(var_8 < 90000) {
        var_7 thread target_smoke(var_4, 22500);
      }
    }

    foreach(var_11 in level.players) {
      if(!isDefined(var_11)) {
        continue;
      }
      var_12 = distance2dsquared(var_1, var_11.origin);

      if(var_12 < 22500) {
        var_11.inplayersmokescreen = var_0;
        var_11 setthreatbiasgroup("phased_players");
        continue;
      }

      var_11.inplayersmokescreen = undefined;
      var_11 setthreatbiasgroup("players");
    }

    wait 0.05;
  }
}

target_smoke(var_0, var_1) {
  scripts\cp\cp_agent_utils::agent_go_to_pos(var_0.origin, sqrt(var_1), "critical");

  if(!scripts\cp\cp_agent_utils::is_agent_scripted(self)) {
    self getenemyinfo(var_0);
    self getpathend(var_0);
    scripts\cp\cp_agent_utils::agent_go_to_pos(var_0.origin, 8, "hunt");
  }

  self.smoked = 1;
  level waittill("smokeTimesUp");

  if(!scripts\cp\cp_agent_utils::is_agent_scripted(self)) {
    self botclearscriptenemy();
  }

  scripts\cp\cp_agent_utils::agent_go_to_pos(self.origin, 8, "hunt");
  self.smoked = undefined;
}

waitsmoketime(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  level notify("smokeTimesUp");
  waittillframeend;

  foreach(var_5 in level.players) {
    if(isDefined(var_5)) {
      var_5.inplayersmokescreen = undefined;
      var_5 setthreatbiasgroup("players");
    }
  }

  var_3 delete();
}

c4used(var_0) {
  if(!scripts\cp\utility::isreallyalive(self)) {
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
  var_1 = level.weaponconfigs["c4_zm"];
  var_0 thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  var_0 thread c4_earthquake();
  var_0 thread c4activate();
  var_0 thread watchc4stuck();
  level thread monitordisownedequipment(self, var_0);
}

watchc4implode() {
  self.owner endon("disconnect");
  var_0 = self.owner;
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_1 linkto(self);
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_2);
  thread c4implode(var_2, var_0, var_1);
}

c4implode(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait 0.5;
  var_2 radiusdamage(var_0, 256, 1200, 600, var_1, "MOD_EXPLOSIVE", "c4_zm");
  thread c4_earthquake();
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

c4activate() {
  self endon("death");
  self waittill("missile_stuck", var_0);
  wait 0.05;
  self notify("activated");
  self.activated = 1;
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck", var_0);
  self give_player_tickets(1);
  self.c4stuck = 1;
  explosivehandlemovers(var_0);
}

onlethalequipmentplanted(var_0, var_1, var_2) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(scripts\engine\utility::is_true(var_2)) {
        self.plantedlethalequip[0] notify("detonateExplosive");
      } else {
        self.plantedlethalequip[0] deleteexplosive();
      }
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var_0;
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("mine_planted");
}

watchc4altdetonate(var_0) {
  self notify("watchC4AltDetonate");
  self endon("watchC4AltDetonate");
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    if(self usebuttonpressed()) {
      var_1 = 0;

      while(self usebuttonpressed()) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!self usebuttonpressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      if(!self.plantedlethalequip.size) {
        return;
      }
      if(!scripts\cp\powers\coop_phaseshift::isentityphaseshifted(self)) {
        self notify("alt_detonate");
      }
    }

    wait 0.05;
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

    if(var_0 != "c4_zm") {
      c4detonateallcharges();
    }
  }
}

watchc4detonation() {
  self notify("watchC4Detonation");
  self endon("watchC4Detonation");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittillmatch("detonate", "c4_zm");
    c4detonateallcharges();
  }
}

c4detonateallcharges() {
  foreach(var_1 in self.plantedlethalequip) {
    if(isDefined(var_1) && var_1.weapon_name == "c4_zm") {
      var_1 thread waitanddetonate(0.1);
      scripts\engine\utility::array_remove(self.plantedlethalequip, var_1);
    }
  }

  self notify("c4_update", 0);
  waittillframeend;
  self notify("detonated");
}

waitanddetonate(var_0) {
  self endon("death");
  wait(var_0);
  waittillenabled();
  self notify("detonateExplosive");
}

waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }
  self waittill("enabled");
}

clustergrenadeused() {
  var_0 = self.originalowner;
  var_0 endon("disconnect");
  thread ownerdisconnectcleanup(var_0);
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
  var_7 setscriptmoverkillcam("explosive");
  var_7 thread deathdelaycleanup(self, var_3 + 5);
  var_7 thread ownerdisconnectcleanup(self.owner);
  var_7.threwback = self.threwback;
  var_8 = var_0 scripts\cp\utility::_launchgrenade("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  var_8 linkto(self);
  var_8 thread deathdelaycleanup(self, var_3);
  var_8 thread ownerdisconnectcleanup(self.owner);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_9);
  thread clustergrenadeexplode(var_9, var_1, var_0, var_7);
}

clustergrenadeexplode(var_0, var_1, var_2, var_3) {
  var_2 endon("disconnect");
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_5 = 0;
  var_6 = var_0 + (0, 0, 3);
  var_7 = var_6 + (0, 0, -5);
  var_8 = physics_raycast(var_6, var_7, var_4, undefined, 0, "physicsquery_closest");

  if(isDefined(var_8) && var_8.size > 0) {
    var_5 = 1;
  }

  var_9 = scripts\engine\utility::ter_op(var_5, (0, 0, 32), (0, 0, 2));
  var_10 = var_0 + var_9;
  var_11 = randomint(90) - 45;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(var_12 = 0; var_12 < 4; var_12++) {
    var_3.shellshockondamage = scripts\engine\utility::ter_op(var_12 == 0, 1, undefined);
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
    var_8 = physics_raycast(var_6, var_7, var_4, undefined, 0, "physicsquery_closest");

    if(isDefined(var_8) && var_8.size > 0) {
      var_7 = var_8[0]["position"];
    }

    playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var_7);

    switch (var_12) {
      case 0:
        playLoopSound(var_7, "frag_grenade_explode");
        break;
      case 3:
        playLoopSound(var_7, "cluster_explode_end");
        break;
      default:
        playLoopSound(var_7, "cluster_explode_mid");
    }

    wait(var_1[var_12]);
  }
}

deathdelaycleanup(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait(var_1);
  self delete();
}

ownerdisconnectcleanup(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

semtexused(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  if(!issubstr(var_0.weapon_name, "semtex") && var_0.weapon_name != "iw6_mk32_mp") {
    return;
  }
  var_0.originalowner = self;
  var_0 waittill("missile_stuck", var_1);
  var_0 thread grenade_earthquake();
  var_0 explosivehandlemovers(undefined);
}

remove_attachment(var_0, var_1, var_2) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return;
  }
  var_3 = [];
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_2)) {
    var_3[var_3.size] = var_2;
  } else {
    var_3 = var_1 getweaponslistall();
  }

  foreach(var_7 in var_3) {
    if(var_1 has_attachment(var_7, var_0)) {
      var_8 = scripts\cp\utility::getrawbaseweaponname(var_7);
      var_9 = getweaponbasename(var_7);
      var_1 giveuponsuppressiontime(var_7);
      var_10 = getweaponattachments(var_7);

      foreach(var_12 in var_10) {
        if(issubstr(var_12, var_0)) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func)) {
        var_5 = var_1[[level.build_weapon_name_func]](var_9, undefined, var_10);
      }

      if(isDefined(var_5)) {
        var_3 = self getweaponslistprimaries();

        foreach(var_2 in var_3) {
          if(issubstr(var_2, var_5)) {
            if(scripts\cp\utility::isaltmodeweapon(var_2)) {
              var_9 = getweaponbasename(var_2);

              if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_9)) {
                var_5 = "alt_" + var_5;
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

has_attachment(var_0, var_1) {
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

getattachmentlist() {
  var_0 = [];
  var_1 = ["mp\attachmentTable.csv", "cp\zombies\zombie_attachmenttable.csv"];

  foreach(var_3 in var_1) {
    var_4 = 0;

    for(var_5 = tablelookup(var_3, 0, var_4, 5); var_5 != ""; var_5 = tablelookup(var_3, 0, var_4, 5)) {
      if(!scripts\engine\utility::array_contains(var_0, var_5)) {
        var_0[var_0.size] = var_5;
      }

      var_4++;
    }
  }

  return var_0;
}

getarkattachmentlist() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = tablelookup("cp\zombies\zombie_attachmenttable.csv", 0, var_1, 5); var_2 != ""; var_2 = tablelookup("cp\zombies\zombie_attachmenttable.csv", 0, var_1, 5)) {
    if(!scripts\engine\utility::array_contains(var_0, var_2)) {
      var_0[var_0.size] = var_2;
    }

    var_1++;
  }

  return var_0;
}

has_weapon_variation(var_0) {
  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_0);
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_3);

    if(var_4 == var_5) {
      return 1;
    }
  }

  return 0;
}

create_attachment_variant_list(var_0, var_1, var_2) {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];

  foreach(var_4 in var_0) {
    var_5 = tablelookup(var_1, 4, var_4, 5);

    if(var_2 == "zombie") {
      if(!isDefined(var_5) || var_5 == "") {
        var_5 = tablelookup("cp\zombies\zombie_attachmenttable.csv", 4, var_4, 5);
      }
    }

    if(var_4 == var_5) {
      continue;
    }
    level.attachmentmap_uniquetobase[var_4] = var_5;
    var_6 = tablelookup("mp\attachmenttable.csv", 4, var_4, 13);

    if(var_6 != "") {
      level.attachmentmap_uniquetoextra[var_4] = var_6;
      level.attachmentextralist[var_6] = 1;
    }
  }
}

buildattachmentmaps() {
  var_0 = ["mp\attachmentTable.csv", "cp\zombies\zombie_attachmenttable.csv"];
  var_1 = ["mp\attachmentmap.csv", "cp\zombies\zombie_attachmentmap.csv"];
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.attachmentextralist = [];
  level.attachmentmap_attachtoperk = [];
  level.attachmentmap_conflicts = [];
  level.attachmentmap_basetounique = [];

  foreach(var_3 in var_0) {
    var_4 = getattachmentlistuniquenames(var_3);

    foreach(var_6 in var_4) {
      var_7 = tablelookup(var_3, 4, var_6, 5);

      if(var_6 != var_7) {
        level.attachmentmap_uniquetobase[var_6] = var_7;
      }

      var_8 = tablelookup(var_3, 4, var_6, 13);

      if(var_8 != "") {
        level.attachmentmap_uniquetoextra[var_6] = var_8;
        level.attachmentextralist[var_8] = 1;
      }
    }

    foreach(var_11 in var_1) {
      var_12 = [];
      var_13 = 1;

      for(var_14 = tablelookupbyrow(var_11, var_13, 0); var_14 != ""; var_14 = tablelookupbyrow(var_11, var_13, 0)) {
        var_12[var_12.size] = var_14;
        var_13++;
      }

      var_15 = [];
      var_16 = 1;

      for(var_17 = tablelookupbyrow(var_11, 0, var_16); var_17 != ""; var_17 = tablelookupbyrow(var_11, 0, var_16)) {
        var_15[var_17] = var_16;
        var_16++;
      }

      foreach(var_14 in var_12) {
        foreach(var_22, var_20 in var_15) {
          var_21 = tablelookup(var_11, 0, var_14, var_20);

          if(var_21 == "") {
            continue;
          }
          if(!isDefined(level.attachmentmap_basetounique[var_14])) {
            level.attachmentmap_basetounique[var_14] = [];
          }

          level.attachmentmap_basetounique[var_14][var_22] = var_21;
        }
      }

      foreach(var_25 in var_4) {
        var_26 = tablelookup(var_3, 4, var_25, 12);

        if(var_26 == "") {
          continue;
        }
        level.attachmentmap_attachtoperk[var_25] = var_26;
      }

      var_28 = 1;

      for(var_29 = tablelookupbyrow("mp\attachmentcombos.csv", var_28, 0); var_29 != ""; var_29 = tablelookupbyrow("mp\attachmentcombos.csv", var_28, 0)) {
        var_30 = 1;

        for(var_31 = tablelookupbyrow("mp\attachmentcombos.csv", 0, var_30); var_31 != ""; var_31 = tablelookupbyrow("mp\attachmentcombos.csv", 0, var_30)) {
          if(var_29 != var_31) {
            var_32 = tablelookupbyrow("mp\attachmentcombos.csv", var_28, var_30);
            var_33 = scripts\engine\utility::alphabetize([var_29, var_31]);
            var_34 = var_33[0] + "_" + var_33[1];

            if(var_32 == "no" && !isDefined(level.attachmentmap_conflicts[var_34])) {
              level.attachmentmap_conflicts[var_34] = 1;
            }
          }

          var_30++;
        }

        var_28++;
      }
    }
  }
}

create_zombie_base_to_unique_map(var_0, var_1, var_2, var_3) {
  if(var_0 == "zombie") {
    foreach(var_5 in var_1) {
      foreach(var_9, var_7 in var_2) {
        var_8 = tablelookup(var_3, 0, var_5, var_7);

        if(var_8 == "") {
          continue;
        }
        if(!isDefined(level.attachmentmap_basetounique[var_5])) {
          level.attachmentmap_basetounique[var_5] = [];
        }

        if(var_8 == "none") {
          level.attachmentmap_basetounique[var_5][var_9] = undefined;
          continue;
        }

        level.attachmentmap_basetounique[var_5][var_9] = var_8;
      }
    }
  }
}

getattachmentlistuniquenames(var_0) {
  var_1 = getdvar("g_gametype");
  var_2 = [];
  var_3 = 0;

  for(var_4 = tablelookup(var_0, 0, var_3, 4); var_4 != ""; var_4 = tablelookup(var_0, 0, var_3, 4)) {
    var_2[var_2.size] = var_4;
    var_3++;
  }

  return var_2;
}

grenade_earthquake(var_0) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonentity("grenade_rumble", var_1);
  earthquake(0.5, 0.75, var_1, 800);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distancesquared(var_1, var_3.origin) > 360000) {
      continue;
    }
    if(var_3 damageconetrace(var_1)) {
      var_3 thread dirteffect(var_1);
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonentity("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }
    if(var_2 damageconetrace(var_0)) {
      var_2 thread dirteffect(var_0);
    }

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

dirteffect(var_0) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp\utility::isreallyalive(self)) {
    return;
  }
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];

  if(var_4 > 0 && var_4 > 0.5 && self getcurrentweapon() != "iw6_riotshield_mp") {
    scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
  } else if(abs(var_4) < 0.866) {
    if(var_5 > 0) {
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
    } else {
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
    }
  }
}

shellshockondamage(var_0, var_1) {
  if(isflashbanged()) {
    return;
  }
  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction) {
        self shellshock("frag_grenade_mp", self.shellshockreduction);
      } else {
        self shellshock("frag_grenade_mp", 0.5);
      }
    }
  }
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

waittill_grenade_fire() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2);

    if(isDefined(self.throwinggrenade) && var_1 != self.throwinggrenade) {
      continue;
    }
    if(isDefined(var_0)) {
      if(!isDefined(var_0.weapon_name)) {
        var_0.weapon_name = var_1;
      }

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.team)) {
        var_0.team = self.team;
      }

      if(!isDefined(var_0.ticks) && isDefined(self.throwinggrenade)) {
        var_0.ticks = scripts\cp\utility::roundup(4 * var_2);
      }
    }

    if(!scripts\cp\utility::isreallyalive(self) && !isDefined(self.throwndyinggrenade)) {
      self notify("grenade_fire_dead", var_0, var_1);
      self.throwndyinggrenade = 1;
    }

    return var_0;
  }
}

can_use_attachment(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self getcurrentweapon();
  }

  var_3 = getweaponbasename(var_2);
  var_4 = scripts\cp\utility::coop_getweaponclass(var_3);
  var_5 = get_possible_attachments_by_weaponclass(var_4, var_3, var_0);

  if(!var_5) {
    return 0;
  }

  return 1;
}

add_attachment_to_weapon(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = var_1;
  } else {
    var_4 = scripts\cp\utility::getvalidtakeweapon();
  }

  var_5 = getweaponbasename(var_4);
  var_6 = 0;
  var_7 = getweaponattachments(var_4);
  var_8 = scripts\cp\utility::getcurrentcamoname(var_4);
  var_9 = return_weapon_name_with_like_attachments(var_4, var_0, var_7, undefined, var_8);

  if(!isDefined(var_9) || isDefined(var_9) && var_9 == "none") {
    return 0;
  }

  var_10 = scripts\cp\utility::isaltmodeweapon(var_1);

  if(scripts\cp\utility::weaponhasattachment(var_9, "xmags")) {
    var_6 = 1;
  }

  if(isDefined(var_0)) {
    if(!issubstr(var_0, "pap")) {
      var_11 = self getweaponammoclip(var_4);
      var_12 = self getweaponammostock(var_4);

      if(issubstr(var_9, "akimbo")) {
        var_13 = self getweaponammoclip(var_4, "left");
      } else {
        var_13 = undefined;
      }

      self giveuponsuppressiontime(var_4);
      scripts\cp\utility::_giveweapon(var_9, undefined, undefined, 1);

      if(scripts\cp\utility::weaponhasattachment(var_9, "xmags") && !var_6) {
        var_11 = weaponclipsize(var_9);
      }

      self setweaponammoclip(var_9, var_11);
      self setweaponammostock(var_9, var_12);

      if(isDefined(var_13)) {
        self setweaponammoclip(var_9, var_13, "left");
      }
    } else {
      if(issubstr(var_9, "katana") || issubstr(var_9, "nunchucks")) {}

      self giveuponsuppressiontime(var_4);
      scripts\cp\utility::_giveweapon(var_9, undefined, undefined, 0);
      self givemaxammo(var_9);
    }
  }

  self playlocalsound("weap_raise_large_plr");
  var_14 = self getweaponslistprimaries();

  foreach(var_1 in var_14) {
    if(issubstr(var_1, var_9)) {
      if(scripts\cp\utility::isaltmodeweapon(var_1)) {
        var_16 = getweaponbasename(var_1);

        if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_16) || var_10) {
          var_9 = "alt_" + var_9;
          break;
        }
      }
    }
  }

  if(scripts\engine\utility::is_true(var_3)) {
    return 1;
  }

  if(scripts\engine\utility::is_true(var_2)) {
    self switchtoweaponimmediate(var_9);
  } else {
    self switchtoweapon(var_9);
  }

  return 1;
}

isforgefreezeweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getweaponbasename(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "iw7_forgefreeze_zm" || var_1 == "iw7_forgefreeze_zm_pap1" || var_1 == "iw7_forgefreeze_zm_pap2" || var_1 == "zfreeze_semtex_mp") {
      if(scripts\cp\utility::isaltmodeweapon(var_0)) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

isaltforgefreezeweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getweaponbasename(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "iw7_forgefreeze_zm" || var_1 == "iw7_forgefreeze_zm_pap1" || var_1 == "iw7_forgefreeze_zm_pap2" || var_1 == "zfreeze_semtex_mp") {
      if(scripts\cp\utility::isaltmodeweapon(var_0)) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

issteeldragon(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1 == "iw7_steeldragon_zm";
}

is_perk_attachment(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "doubletap") {
    return 1;
  }

  return 0;
}

is_arcane_attachment(var_0) {
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

is_mod_attachment(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "mod")) {
    return 1;
  }

  return 0;
}

is_default_attachment(var_0, var_1) {
  var_2 = scripts\cp\utility::weaponattachdefaultmap(var_1);

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

is_pap_attachment(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "pap")) {
    return 1;
  }

  return 0;
}

get_possible_attachments_by_weaponclass(var_0, var_1, var_2) {
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
  var_4 = scripts\cp\utility::getbaseweaponname(var_1);

  if(isDefined(level.attachmentmap_basetounique[var_4])) {
    if(isDefined(level.attachmentmap_basetounique[var_4][var_2])) {
      if(level.attachmentmap_basetounique[var_4][var_2] != "none") {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_0])) {
    if(isDefined(level.attachmentmap_basetounique[var_0][var_2])) {
      if(level.attachmentmap_basetounique[var_0][var_2] != "none") {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_4])) {
    var_5 = getarraykeys(level.attachmentmap_basetounique[var_4]);

    foreach(var_7 in var_5) {
      if(level.attachmentmap_basetounique[var_4][var_7] == var_2) {
        if(level.attachmentmap_basetounique[var_4][var_7] != "none") {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_0])) {
    var_5 = getarraykeys(level.attachmentmap_basetounique[var_0]);

    foreach(var_7 in var_5) {
      if(level.attachmentmap_basetounique[var_0][var_7] == var_2) {
        if(level.attachmentmap_basetounique[var_0][var_7] != "none") {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  return 0;
}

return_weapon_name_with_like_attachments(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    var_5 = var_0;
  } else {
    var_5 = self getcurrentweapon();
  }

  var_6 = getweaponbasename(var_5);
  var_7 = scripts\cp\utility::get_weapon_variant_id(self, var_5);
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
  var_20 = 4;
  var_21 = [];
  var_22 = 1;
  var_23 = [];
  var_24 = 1;
  var_25 = [];
  var_26 = 15;
  var_27 = scripts\cp\utility::coop_getweaponclass(var_6);

  if(scripts\cp\utility::weaponhasattachment(var_5, "xmags")) {
    var_9 = 1;
  }

  var_28 = get_possible_attachments_by_weaponclass(var_27, var_6, var_1);

  if(!var_28 && isDefined(var_1)) {
    if(!scripts\engine\utility::is_true(var_3)) {
      scripts\cp\utility::setlowermessage("cant_attach", &"COOP_PILLAGE_CANT_USE", 3);
    }

    return undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = getweaponattachments(var_5);
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat")) {
    if(get_possible_attachments_by_weaponclass(var_27, var_6, "doubletap")) {
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

  var_2 = scripts\engine\utility::array_remove_duplicates(var_2);
  var_2 = scripts\engine\utility::array_removeundefined(var_2);

  if(var_2.size > 0 && var_2.size <= var_26) {
    foreach(var_33 in var_2) {
      if(is_pap_attachment(var_33)) {
        if(var_17.size < var_18) {
          var_17[var_17.size] = var_33;
          var_25[var_25.size] = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_arcane_attachment(var_33)) {
        if(var_23.size < var_24) {
          var_23[var_23.size] = var_33;
          var_25[var_25.size] = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_mod_attachment(var_33)) {
        if(var_19.size < var_20) {
          var_19[var_19.size] = var_33;
          var_25[var_25.size] = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_default_attachment(var_33, scripts\cp\utility::getweaponrootname(var_6))) {
        if(var_21.size < var_22) {
          var_21[var_21.size] = var_33;
          var_25[var_25.size] = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_perk_attachment(var_33)) {
        if(var_15.size < var_16) {
          var_15[var_15.size] = var_33;
          var_25[var_25.size] = var_33;
        } else {
          continue;
        }

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
    var_35 = scripts\cp\utility::attachmentmap_tobase(var_1);

    if(isDefined(var_35) && var_35 != "none") {
      for(var_36 = 0; var_36 < var_25.size; var_36++) {
        var_37 = scripts\cp\utility::attachmentmap_tobase(var_25[var_36]);

        if(var_37 == var_35) {
          var_25[var_36] = var_1;
          var_8 = 1;
          break;
        }
      }
    }

    var_38 = scripts\cp\utility::getattachmenttype(var_1);

    if(isDefined(var_38) && var_38 != "none") {
      if(!var_8) {
        if(is_pap_attachment(var_1)) {
          if(var_17.size < var_18) {
            var_17[var_17.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_17[var_17.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(is_arcane_attachment(var_1)) {
          if(var_23.size < var_24) {
            var_23[var_23.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_23[var_15.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(is_perk_attachment(var_1)) {
          if(var_15.size < var_16) {
            var_15[var_15.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

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
            var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

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
      } else if(is_perk_attachment(var_1)) {
        var_17[var_17.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_pap_attachment(var_1)) {
        var_15[var_15.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_arcane_attachment(var_1)) {
        var_23[var_23.size] = var_1;
        var_25[var_25.size] = var_1;
      } else {
        var_13[var_13.size] = var_1;
        var_25[var_25.size] = var_1;
      }
    } else if(isDefined(var_1)) {
      if(is_perk_attachment(var_1)) {
        var_15[var_15.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_pap_attachment(var_1)) {
        var_17[var_17.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_arcane_attachment(var_1)) {
        var_23[var_23.size] = var_1;
        var_25[var_25.size] = var_1;
      } else {
        var_13[var_13.size] = var_1;
        var_25[var_25.size] = var_1;
      }
    }
  }

  var_40 = scripts\cp\utility::getweaponrootname(var_6);
  var_41 = isDefined(self.weapon_build_models[scripts\cp\utility::getrawbaseweaponname(var_5)]);

  if(!isDefined(var_4) && var_41) {
    var_10 = scripts\cp\utility::getweaponcamo(var_40);
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
      var_12 = scripts\cp\utility::getweaponcosmeticattachment(var_40);
    }

    var_11 = scripts\cp\utility::getweaponreticle(var_40);
    var_45 = scripts\cp\utility::getweaponpaintjobid(var_40);
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

  var_51 = scripts\cp\utility::mpbuildweaponname(var_40, var_25, var_10, var_11, var_7, self getentitynumber(), self.clientid, var_45, var_12);

  if(isDefined(var_51)) {
    return var_51;
  } else {
    return var_5;
  }
}

getattachmenttypeslist(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponattachmentarrayfromstats(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = scripts\cp\utility::getattachmenttype(var_5);

    if(isDefined(var_1) && scripts\cp\utility::listhasattachment(var_1, var_5)) {
      continue;
    }
    if(!isDefined(var_3[var_6])) {
      var_3[var_6] = [];
    }

    var_7 = var_3[var_6];
    var_7[var_7.size] = var_5;
    var_3[var_6] = var_7;
  }

  return var_3;
}

getattachmentlistbasenames() {
  var_0 = [];
  var_1 = ["mp\attachmentTable.csv", "cp\zombies\zombie_attachmenttable.csv"];

  foreach(var_3 in var_1) {
    var_4 = 0;

    for(var_5 = tablelookup(var_3, 0, var_4, 5); var_5 != ""; var_5 = tablelookup(var_3, 0, var_4, 5)) {
      var_6 = tablelookup(var_3, 0, var_4, 2);

      if(var_6 != "none" && !scripts\engine\utility::array_contains(var_0, var_5)) {
        var_0[var_0.size] = var_5;
      }

      var_4++;
    }
  }

  return var_0;
}

getweaponattachmentarray(var_0) {
  var_1 = [];
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_3 = scripts\cp\utility::coop_getweaponclass(var_0);

  if(isDefined(level.attachmentmap_basetounique[var_2])) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.attachmentmap_basetounique[var_2]);
  }

  if(isDefined(level.attachmentmap_basetounique[var_3])) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.attachmentmap_basetounique[var_3]);
  }

  return var_1;
}

isvalidzombieweapon(var_0) {
  if(!isDefined(level.weaponrefs)) {
    level.weaponrefs = [];

    foreach(var_2 in level.weaponlist) {
      level.weaponrefs[var_2] = 1;
    }
  }

  if(isDefined(level.weaponrefs[var_0])) {
    return 1;
  }

  return 0;
}

setweaponlaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var_0 = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(var_0);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change", var_0);

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      disableweaponlaser();
    }
  }
}

setweaponlaser_waitforlaserweapon(var_0) {
  for(;;) {
    var_0 = getweaponbasename(var_0);

    if(isDefined(var_0) && (var_0 == "iw6_kac_mp" || var_0 == "iw6_arx160_mp")) {
      break;
    }
    self waittill("weapon_change", var_0);
  }
}

setweaponlaser_monitorads() {
  self endon("weapon_change");

  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        enableweaponlaser();
      }
    }

    scripts\engine\utility::waitframe();
  }
}

setweaponlaser_monitorweaponswitchstart(var_0) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(var_0);
  }
}

setweaponlaser_onweaponswitchstart(var_0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait(var_0);
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
  }
}

enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls)) {
    self.weaponlasercalls = 0;
  }

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

ondetonateexplosive(var_0) {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");

  if(isDefined(var_0)) {
    self.owner notify(var_0, 1);
  } else {
    self.owner notify("powers_c4_used", 1);
  }

  self detonate(self.owner);
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

cleanupequipment(var_0, var_1, var_2, var_3) {
  if(isDefined(self.weapon_name)) {
    if(self.weapon_name == "c4_zm") {
      self.owner notify("c4_update", 0);
    } else if(self.weapon_name == "bouncingbetty_mp") {
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

monitordamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = var_0;
  self.damagetaken = 0;

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_6 = 1; var_6; var_6 = monitordamageoneshot(var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_1, var_2, var_3, var_4)) {
    self waittill("damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(var_5) {
      self playrumbleonentity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_17 = "";

      if(isDefined(var_8) && isplayer(var_8)) {
        var_17 = var_8 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_17])) {
        self.attackers[var_17] = self.attackers[var_17] + var_7;
      } else {
        self.attackers[var_17] = var_7;
      }
    }
  }
}

monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(var_1) && !scripts\cp\utility::isgameparticipant(var_1) && !isDefined(var_1.allowmonitoreddamage)) {
    return 1;
  }

  return 1;
}

explosivehandlemovers(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.linkparent = var_0;
  var_2.deathoverridecallback = ::movingplatformdetonate;
  var_2.endonstring = "death";

  if(!isDefined(var_1) || !var_1) {
    var_2.invalidparentoverridecallback = scripts\cp\cp_movers::moving_platform_empty_func;
  }

  thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
}

movingplatformdetonate(var_0) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
  }
}

makeexplosiveusable() {
  if(scripts\cp\utility::isreallyalive(self.owner)) {
    self setotherent(self.owner);
    self.trigger = spawn("script_origin", self.origin + getexplosiveusableoffset());
    self.trigger.owner = self;
    thread equipmentwatchuse(self.owner, 1);
  }
}

equipmentwatchuse(var_0, var_1) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self.trigger setcursorhint("HINT_NOICON");

  switch (self.weapon_name) {
    case "c4_zm":
      self.trigger sethintstring(&"MP_PICKUP_C4");
      break;
    case "claymore_mp":
      self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
      break;
    case "bouncingbetty_mp":
      self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
      break;
    case "proximity_explosive_mp":
      self.trigger sethintstring(&"MP_PICKUP_PROXIMITY_EXPLOSIVE");
      break;
    case "mobile_radar_mp":
      self.trigger sethintstring(&"MP_PICKUP_MOBILE_RADAR");
      break;
    case "ztransponder_mp":
    case "transponder_mp":
      self.trigger sethintstring(&"MP_PICKUP_TRANSPONDER");
      break;
    case "sonic_sensor_mp":
      self.trigger sethintstring(&"MP_PICKUP_SONIC_SENSOR");
      break;
    case "sticky_mine_mp":
      self.trigger sethintstring(&"MP_PICKUP_STICKY_MINE");
      break;
    case "blackhole_grenade_zm":
    case "blackhole_grenade_mp":
      self.trigger sethintstring(&"MP_PICKUP_BLACKHOLE_GRENADE");
      break;
    case "shard_ball_mp":
      self.trigger sethintstring(&"MP_PICKUP_SHARD_BALL");
      break;
    case "cryo_grenade_mp":
      self.trigger sethintstring(&"MP_PICKUP_CRYO_MINE");
      break;
    case "trip_mine_mp":
      self.trigger sethintstring(&"MP_PICKUP_TRIP_MINE");
      break;
    case "arc_grenade_mine_mp":
      self.trigger sethintstring(&"MP_PICKUP_ARC_MINE");
      break;
  }

  self.trigger scripts\cp\utility::setselfusable(var_0);
  self.trigger thread scripts\cp\utility::notusableforjoiningplayers(var_0);

  if(isDefined(var_1) && var_1) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", var_0);
    var_0 playlocalsound("scavenger_pack_pickup");
    var_0 notify("scavenged_ammo", self.weapon_name);
    var_0 setweaponammostock(self.weapon_name, var_0 getweaponammostock(self.weapon_name) + 1);
    deleteexplosive();
    self notify("death");
  }
}

updatetriggerposition() {
  self endon("death");

  for(;;) {
    if(isDefined(self) && isDefined(self.trigger)) {
      self.trigger.origin = self.origin + getexplosiveusableoffset();

      if(isDefined(self.bombsquadmodel)) {
        self.bombsquadmodel.origin = self.origin;
      }
    } else {
      return;
    }

    wait 0.05;
  }
}

deleteexplosive(var_0) {
  if(isDefined(self)) {
    var_1 = self getentitynumber();
    var_2 = self.killcament;
    var_3 = self.trigger;
    var_4 = self.sensor;
    cleanupequipment(var_1, var_2, var_3, var_4);
    self notify("deleted_equipment");
    self delete();
  }
}

ontacticalequipmentplanted(var_0) {
  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

    if(self.plantedtacticalequip.size >= level.maxperplayerexplosives) {
      self.plantedtacticalequip[0] notify("detonateExplosive");
    }
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = var_0;
  var_1 = var_0 getentitynumber();
  level.mines[var_1] = var_0;
  level notify("mine_planted");
}

equipmentdeathvfx(var_0) {
  var_1 = spawnfx(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  triggerfx(var_1);

  if(!isDefined(var_0) || var_0 == 0) {
    self playSound("sentry_explode");
  }

  var_1 thread scripts\cp\utility::delayentdelete(1);
}

equipmentdeletevfx() {
  var_0 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), self.origin);
  triggerfx(var_0);
  self playSound("mp_killstreak_disappear");
  var_0 thread scripts\cp\utility::delayentdelete(1);
}

monitordisownedequipment(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_0 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  var_1 deleteexplosive();
}

isprimaryweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "smg":
    case "sniper":
    case "rocketlauncher":
    case "mg":
    case "rifle":
    case "spread":
    case "pistol":
      return 1;
    default:
      return 0;
  }
}

getexplosiveusableoffset() {
  var_0 = anglestoup(self.angles);
  return 10 * var_0;
}

isknifeonly(var_0) {
  return issubstr(var_0, "knife");
}

is_incompatible_weapon(var_0) {
  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(scripts\engine\utility::array_contains(level.ammoincompatibleweaponslist, var_0)) {
      return 1;
    }
  }

  return 0;
}

isbulletweapon(var_0) {
  if(var_0 == "none" || scripts\cp\utility::isriotshield(var_0) || isknifeonly(var_0)) {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "smg":
    case "sniper":
    case "mg":
    case "rifle":
    case "spread":
    case "pistol":
      return 1;
    default:
      return 0;
  }
}

is_explosive_kill(var_0) {
  switch (var_0) {
    case "zombie_armageddon_mp":
    case "zfreeze_semtex_mp":
    case "splash_grenade_zm":
    case "splash_grenade_mp":
    case "throwingknifec4_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "semtex_mp":
    case "c4_zm":
    case "frag_grenade_zm":
      return 1;
    default:
      return 0;
  }
}

is_arc_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  return var_2 && var_3 && var_4 && !var_5 && isDefined(var_1.stun_struct) && isDefined(var_1.stun_struct.attack_bolt) && var_0 == var_1.stun_struct.attack_bolt;
}

is_holding_pistol(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();

  if(scripts\cp\utility::coop_getweaponclass(var_1) == "weapon_pistol") {
    return 1;
  } else {
    return 0;
  }
}

get_weapon_level(var_0) {
  if(!isplayer(self)) {
    return int(1);
  }

  if(isDefined(self.pap[var_0])) {
    return self.pap[var_0].lvl;
  }

  var_1 = scripts\cp\utility::getrawbaseweaponname(var_0);

  if(isDefined(self.pap[var_1])) {
    return self.pap[var_1].lvl;
  }

  return int(1);
}

can_upgrade(var_0, var_1) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(level.max_pap_func)) {
    return [[level.max_pap_func]](var_0, var_1);
  }

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_0);
  } else {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!isDefined(level.pap[var_2])) {
    var_3 = getsubstr(var_2, 0, var_2.size - 1);

    if(!isDefined(level.pap[var_3])) {
      return 0;
    }
  }

  if(isDefined(self.ephemeralweapon) && getweaponbasename(self.ephemeralweapon) == getweaponbasename(var_0)) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)])) {
    return 1;
  }

  if(var_2 == "dischord" || var_2 == "facemelter" || var_2 == "headcutter" || var_2 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      if(scripts\engine\utility::is_true(var_1)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl == 2) {
      return 0;
    }
  }

  if(scripts\engine\utility::is_true(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return 1;
  }

  if(scripts\engine\utility::is_true(self.has_zis_soul_key) && !scripts\engine\utility::is_true(level.no_auto_pap_upgrade) || scripts\engine\utility::is_true(level.placed_alien_fuses)) {
    if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= 3) {
      return 0;
    } else {
      return 1;
    }
  }

  if(scripts\engine\utility::is_true(var_1) && isDefined(self.pap[var_2]) && self.pap[var_2].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= level.pap_max) {
    return 0;
  } else {
    return 1;
  }
}

get_pap_camo(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_1)) {
      var_3 = undefined;
    } else if(isDefined(level.pap_1_camo) && isDefined(var_0) && var_0 == 2) {
      var_3 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(var_0) && var_0 == 3) {
      var_3 = level.pap_2_camo;
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

        var_4 = 1;
        break;
      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        var_4 = 1;
        break;
      case "shredder":
        var_2 = "iw7_shredder_zm_pap1";
        var_3 = "camo23";
        break;
    }
  }

  return var_3;
}

validate_current_weapon(var_0, var_1, var_2) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_2)])) {
    var_2 = level.weapon_upgrade_path[getweaponbasename(var_2)];
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

watchplayermelee() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("melee_fired", var_0);

    if(self.meleekill == 0) {
      if(var_0 == "iw7_fists_zm_crane" || var_0 == "iw7_fists_zm_dragon" || var_0 == "iw7_fists_zm_snake" || var_0 == "iw7_fists_zm_tiger") {
        if(self.kung_fu_vo == 0) {
          self.kung_fu_vo = 1;
          thread scripts\cp\cp_vo::try_to_play_vo("melee_punch", "zmb_comment_vo", "high", 1, 0, 0, 1);
          thread kung_fu_vo_wait();
        } else {
          self.kung_fu_vo = 1;
          self notify("kung_fu_vo_reset");
          thread scripts\cp\cp_vo::try_to_play_vo("melee_punch", "zmb_comment_vo", "high", 1, 0, 0, 1, 60);
          thread kung_fu_vo_wait();
        }
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("melee_miss", "zmb_comment_vo", "high", 1, 0, 0, 1, 20);
      }

      continue;
    }

    if(issubstr(var_0, "katana") && self.vo_prefix == "p5_") {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special_katana", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if((issubstr(var_0, "golf") || issubstr(var_0, "machete") || issubstr(var_0, "spiked_bat") || issubstr(var_0, "two_headed_axe")) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if(issubstr(var_0, "iw7_knife") && scripts\cp\utility::is_melee_weapon(var_0) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_fatal", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self.meleekill = 0;
      continue;
    }

    if((var_0 == "iw7_axe_zm" || var_0 == "iw7_axe_zm_pap1" || var_0 == "iw7_axe_zm_pap2") && scripts\cp\utility::is_melee_weapon(var_0) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_splice", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self.meleekill = 0;
    }
  }
}

kung_fu_vo_wait() {
  self endon("kung_fu_vo_reset");
  wait 4;
  self.kung_fu_vo = 0;
}

watchweaponfired() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    wait 1;
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || var_0 == "none") {
      continue;
    }
    self waittill("fired", var_0);
    var_0 = self getcurrentweapon();
    var_1 = self getammocount(var_0);

    if(scripts\cp\utility::is_melee_weapon(var_0) || issubstr(var_0, "fists") || issubstr(var_0, "heart")) {
      continue;
    }
    if(var_1 <= 5 && var_1 > 0 && self getweaponammostock(var_0) == 0 || self getweaponammostock(var_0) > 0 && var_1 / self getweaponammostock(var_0) < 0.1) {
      scripts\cp\cp_vo::try_to_play_vo("nag_low_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);
      continue;
    }

    if(var_1 == 0 && (var_0 != "iw7_cpbasketball_mp" && var_0 != "none")) {
      scripts\cp\cp_vo::try_to_play_vo("nag_out_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);
    }
  }
}

watchweaponusage(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_1);
    var_1 = self getcurrentweapon();

    if(!isDefined(var_1) || var_1 == "none") {
      continue;
    }
    if(!scripts\cp\utility::isinventoryprimaryweapon(var_1)) {
      continue;
    }
    if(isDefined(level.updateonusepassivesfunc)) {
      thread[[level.updateonusepassivesfunc]](self, var_1);
    }

    var_2 = gettime();

    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var_3 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_2;

    if(isai(self)) {
      continue;
    }
    var_4 = getweaponbasename(var_1);

    if(!isDefined(self.shotsfiredwithweapon[var_4])) {
      self.shotsfiredwithweapon[var_4] = 1;
    } else {
      self.shotsfiredwithweapon[var_4]++;
    }

    if(!isDefined(self.accuracy_shots_fired)) {
      self.accuracy_shots_fired = 1;
    } else {
      self.accuracy_shots_fired++;
    }

    scripts\cp\cp_persistence::increment_player_career_shots_fired(self);

    if(isDefined(var_4)) {
      if(isDefined(self.hitsthismag[var_4])) {
        thread hitsthismag_update(var_4, var_1);
      }
    }
  }
}

hitsthismag_update(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("updateMagShots_" + var_0);
  self.hitsthismag[var_0]--;
  wait 0.1;
  self notify("shot_missed", var_1);
  self.consecutivehitsperweapon[var_0] = 0;
  self.hitsthismag[var_0] = weaponclipsize(var_1);
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.hitsthismag = [];
  var_0 = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(var_0);

  for(;;) {
    self waittill("weapon_change", var_0);
    var_0 = getweaponbasename(var_0);
    weapontracking_init(var_0);
    hitsthismag_init(var_0);
  }
}

harpoon_impale_additional_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!issubstr(var_0, "harpoon")) {
    return;
  } else {
    var_2 startragdoll();
    var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_corpseclipshot"]);
    var_9 = var_3 + var_4 * 4096;
    var_10 = scripts\engine\trace::ray_trace_detail(var_3, var_9, undefined, var_8, undefined, 1);
    var_9 = var_10["position"] - var_4 * 12;
    var_11 = length(var_9 - var_3);
    var_12 = var_11 / 1250;
    var_12 = clamp(var_12, 0.05, 1);
    wait 0.05;
    var_13 = var_4;
    var_14 = anglestoup(var_1.angles);
    var_15 = vectorcross(var_13, var_14);
    var_16 = scripts\engine\utility::spawn_tag_origin(var_3, _axistoangles(var_13, var_15, var_14));
    var_16 moveto(var_9, var_12);
    var_17 = spawnragdollconstraint(var_2, var_5, var_6, var_7);
    var_17.origin = var_16.origin;
    var_17.angles = var_16.angles;
    var_17 linkto(var_16);
    thread play_explosion_post_impale(var_9, var_1);
    thread impale_cleanup(var_2, var_16, var_12 + 0.05, var_17);
  }
}

impale_cleanup(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::waittill_any_timeout(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

play_explosion_post_impale(var_0, var_1) {
  wait 2;
  var_1 radiusdamage(var_0, 500, 1000, 500, var_1, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], var_0);
}

scripted_ability_harpoonv1() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(issubstr(var_0, "harpoon1")) {
      thread harpoonv1_passive();
      continue;
    }

    continue;
  }
}

harpoonv1_passive() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");
  self.trigger_alt_mode = [];

  for(var_0 = 1; var_0 <= 5; var_0++) {
    self.trigger_alt_mode[var_0] = undefined;
  }

  for(;;) {
    scripts\engine\utility::waittill_any("ads_in");
    scripts\engine\utility::waittill_any("ads_out");
    var_1 = self getplayerangles();
    var_2 = self getEye();
    var_3 = anglesToForward(var_1);
    var_4 = var_2 + var_3 * 2048;
    var_5 = scripts\engine\trace::create_contents(1, 1, 0, 0, 0, 0, 0);
    var_6 = physics_raycast(var_2, var_4, var_5, self, 0, "physicsquery_closest");
    var_7 = var_6[0]["position"];

    if(isDefined(var_7)) {
      if(isDefined(self.zombie_charges)) {
        if(self.zombie_charges <= 5) {
          thread create_trigger_based_on_charges(self.zombie_charges, self, var_7);
        }

        self.zombie_charges++;
      } else {
        self.zombie_charges = 1;
        thread create_trigger_based_on_charges(self.zombie_charges, self, var_7);
      }

      thread charge_watcher(var_7);
    }

    wait 0.8;
  }
}

charge_watcher(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_1 = gettime();

  while(gettime() <= var_1 + 7000) {
    scripts\engine\utility::waitframe();

    if(self getcurrentweaponclipammo() <= 1) {
      continue;
    }
    if(isDefined(self.zombie_charges)) {
      if(self.zombie_charges > 5) {
        foreach(var_3 in self.trigger_alt_mode) {
          if(isDefined(var_3)) {
            var_3 delete();
          }
        }

        self radiusdamage(var_0, 100, 1000, 100, self, "MOD_EXPLOSIVE");
        playFX(level._effect["penetration_railgun_explosion"], var_0);
        self.zombie_charges = 0;
      }
    }
  }

  foreach(var_3 in self.trigger_alt_mode) {
    if(isDefined(var_3)) {
      self radiusdamage(var_3.origin, 100, 1000, 100, self, "MOD_EXPLOSIVE");
      playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      var_3 delete();
    }
  }
}

create_trigger_based_on_charges(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_3 = 0;

  switch (var_0) {
    case 0:
      self.zombie_charges = 1;
    case 1:
      foreach(var_5 in self.trigger_alt_mode) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_5 delete();
          }
        }
      }

      var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      break;
    case 2:
      foreach(var_5 in self.trigger_alt_mode) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 55, 25);
            var_3 = 1;
          }

          if(isDefined(var_1.trigger_alt_mode[var_0]) && var_5 != var_1.trigger_alt_mode[var_0]) {
            var_5 delete();
          }
        }
      }

      if(!var_3) {
        var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      }

      break;
    case 3:
      foreach(var_5 in self.trigger_alt_mode) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 60, 25);
            var_3 = 1;
          }

          if(isDefined(var_1.trigger_alt_mode[var_0]) && var_5 != var_1.trigger_alt_mode[var_0]) {
            var_5 delete();
          }
        }
      }

      if(!var_3) {
        var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      }

      break;
    case 4:
      foreach(var_5 in self.trigger_alt_mode) {
        if(isDefined(var_5)) {
          if(var_5.origin == var_2 || distance2dsquared(var_5.origin, var_2) <= 100) {
            var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 65, 25);
            var_3 = 1;
          }

          if(isDefined(var_1.trigger_alt_mode[var_0]) && var_5 != var_1.trigger_alt_mode[var_0]) {
            var_5 delete();
          }
        }
      }

      if(!var_3) {
        var_1.trigger_alt_mode[var_0] = spawn("trigger_radius", var_2, 0, 50, 25);
      }

      break;
    case 5:
      foreach(var_5 in self.trigger_alt_mode) {
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

  if(isDefined(var_1.trigger_alt_mode[var_0])) {
    var_1.trigger_alt_mode[var_0] setModel("prop_mp_super_blackholegun_projectile");
    var_1.trigger_alt_mode[var_0] thread do_damage_when_trigger(var_1.trigger_alt_mode[var_0], var_1);
  }
}

do_damage_when_trigger(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = 0;

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(isDefined(var_3.agent_type) && var_3.agent_type == "generic_zombie" && !isDefined(var_3.flung)) {
      var_1 radiusdamage(var_3.origin, 100, 1000, 100, var_1, "MOD_EXPLOSIVE");
      playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      var_2++;

      if(var_2 >= 5) {
        foreach(var_5 in self.trigger_alt_mode) {
          if(isDefined(var_5)) {
            var_5 delete();
          }
        }

        self.zombie_charges = 0;
        var_1 radiusdamage(var_3.origin, 100, 1000, 100, var_1, "MOD_EXPLOSIVE");
        playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      }
    }
  }
}

weapontracking_init(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }
  if(!isDefined(self.shotsfiredwithweapon[var_0])) {
    self.shotsfiredwithweapon[var_0] = 0;
  }

  if(!isDefined(self.shotsontargetwithweapon[var_0])) {
    self.shotsontargetwithweapon[var_0] = 0;
  }

  if(!isDefined(self.headshots[var_0])) {
    self.headshots[var_0] = 0;
  }

  if(!isDefined(self.wavesheldwithweapon[var_0])) {
    self.wavesheldwithweapon[var_0] = 1;
  }

  if(!isDefined(self.downsperweaponlog[var_0])) {
    self.downsperweaponlog[var_0] = 0;
  }

  if(!isDefined(self.killsperweaponlog[var_0])) {
    self.killsperweaponlog[var_0] = 0;
  }
}

hitsthismag_init(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }
  if(scripts\cp\utility::isinventoryprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0])) {
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }
}