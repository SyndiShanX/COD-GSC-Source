/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2667.gsc
***************************************/

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

powerheartset(var_00) {
  self.has_heart = 1;
}

powereyeset(var_00) {
  self.has_eye = 1;
}

blank(var_00) {}

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
  var_00 = 70;
  level.claymoredetectiondot = cos(var_00);
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
  var_00 = spawnStruct();
  var_0.mine_beacon["enemy"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  var_0.mine_beacon["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.weaponconfigs["c4_zm"] = var_00;
  var_00 = spawnStruct();
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
  level.weaponconfigs["blackhole_grenade_mp"] = var_00;
  level.weaponconfigs["blackhole_grenade_zm"] = var_00;
  var_00 = spawnStruct();
  var_0.armingdelay = 1.5;
  var_0.detectionradius = 232;
  var_0.detectionheight = 512;
  var_0.detectiongraceperiod = 1;
  var_0.headiconoffset = 20;
  var_0.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var_00;
  var_00 = spawnStruct();
  var_01 = 800;
  var_02 = 200;
  var_0.radius_max_sq = var_01 * var_01;
  var_0.radius_min_sq = var_02 * var_02;
  var_0.onexplodesfx = "flashbang_explode_default";
  var_0.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var_00;
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
  var_00 = ["mp\statstable.csv", "cp\zombies\mode_string_tables\zombies_statstable.csv"];
  level.weaponmapdata = [];

  foreach(var_02 in var_00) {
    for(var_03 = 1; tablelookup(var_02, 0, var_03, 0) != ""; var_3++) {
      var_04 = tablelookup(var_02, 0, var_03, 4);

      if(var_04 != "") {
        level.weaponmapdata[var_04] = spawnStruct();
        var_05 = tablelookup(var_02, 0, var_03, 0);

        if(var_05 != "") {
          level.weaponmapdata[var_04].number = var_05;
        }

        var_06 = tablelookup(var_02, 0, var_03, 1);

        if(var_06 != "") {
          level.weaponmapdata[var_04].group = var_06;
        }

        var_07 = tablelookup(var_02, 0, var_03, 5);

        if(var_07 != "") {
          level.weaponmapdata[var_04].perk = var_07;
        }

        var_08 = tablelookup(var_02, 0, var_03, 9);

        if(var_08 != "") {
          if(isDefined(level.weaponmapdata[var_04].attachdefaults)) {
            if(level.weaponmapdata[var_04].attachdefaults == "none") {
              level.weaponmapdata[var_04].attachdefaults = undefined;
            } else {
              level.weaponmapdata[var_04].attachdefaults = strtok(var_08, " ");
            }
          } else
            level.weaponmapdata[var_04].attachdefaults = strtok(var_08, " ");
        }

        level.weaponmapdata[var_04].selectableattachmentlist = [];
        level.weaponmapdata[var_04].selectableattachmentmap = [];

        for(var_09 = 0; var_09 < 20; var_9++) {
          var_10 = tablelookup(var_02, 0, var_03, 10 + var_09);

          if(isDefined(var_10) && var_10 != "") {
            var_11 = level.weaponmapdata[var_04].selectableattachmentlist.size;
            level.weaponmapdata[var_04].selectableattachmentlist[var_11] = var_10;
            level.weaponmapdata[var_04].selectableattachmentmap[var_10] = 1;
          }
        }

        var_12 = tablelookup(var_02, 0, var_03, 8);

        if(var_12 != "") {
          var_12 = float(var_12);
          level.weaponmapdata[var_04].speed = var_12;
        }
      }
    }
  }
}

buildweaponmaps() {
  var_00 = "mp\statstable.csv";
  var_01 = level.game_mode_statstable;
  level.weaponmap_toperk = [];
  level.weaponmap_toattachdefaults = [];
  level.weaponmap_tospeed = [];
  var_02 = 0;
  var_03 = 1;

  for(var_04 = 1; var_03 || var_04; var_2++) {
    if(tablelookup(var_00, 0, var_02, 0) == "") {
      var_03 = 0;
    }

    var_05 = tablelookup(var_00, 0, var_02, 4);
    var_06 = tablelookup(var_00, 0, var_02, 5);

    if(var_06 != "") {
      if(var_05 != "") {
        level.weaponmap_toperk[var_05] = var_06;
      }
    }

    var_07 = tablelookup(var_00, 0, var_02, 9);

    if(var_07 != "") {
      if(var_05 != "") {
        level.weaponmap_toattachdefaults[var_05] = strtok(var_07, " ");
      }
    }

    var_08 = tablelookup(var_00, 0, var_02, 8);

    if(var_08 != "") {
      if(var_05 != "") {
        var_08 = float(var_08);
        level.weaponmap_tospeed[var_05] = float(var_08);
      }
    }

    if(var_04) {
      if(tablelookup(var_01, 0, var_02, 0) == "") {
        var_04 = 0;
      }

      var_05 = tablelookup(var_01, 0, var_02, 4);
      var_06 = tablelookup(var_01, 0, var_02, 5);

      if(var_06 != "") {
        if(var_05 != "") {
          level.weaponmap_toperk[var_05] = var_06;
        }
      }

      var_07 = tablelookup(var_01, 0, var_02, 9);

      if(var_07 != "") {
        if(var_05 != "") {
          level.weaponmap_toattachdefaults[var_05] = strtok(var_07, " ");
        }
      }

      var_08 = tablelookup(var_01, 0, var_02, 8);

      if(var_08 != "") {
        if(var_05 != "") {
          var_08 = float(var_08);
          level.weaponmap_tospeed[var_05] = float(var_08);
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
  wait 0.65;
  self notify("detonateExplosive");
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

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_0.hits = 0;
    var_00 thread onplayerspawned();
    var_00 thread watchmissileusage();
    var_00 thread sniperdustwatcher();
  }
}

giverateye(var_00) {
  self.has_eye = 1;
  thread eye_activated(self);
}

takerateye(var_00) {
  self.has_eye = undefined;
  self notify("remove_eye");
}

eye_activated(var_00) {
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
  var_00 = undefined;

  for(;;) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }
    if(scripts\cp\utility::coop_getweaponclass(self getcurrentweapon()) != "weapon_sniper") {
      continue;
    }
    var_01 = anglesToForward(self.angles);

    if(!isDefined(var_00) || gettime() - var_00 > 2000) {
      var_00 = gettime();
      continue;
    }
  }
}

unset_scriptable_part_state_after_time(var_00, var_01) {
  self endon("death");
  wait(var_00);
  self setscriptablepartstate("projectile", "inactive");
  var_01 notify("ranged_katana_missile_done");

  if(isDefined(self)) {
    self delete();
  }
}

watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    var_00 = waittill_missile_fire();

    switch (var_0.weapon_name) {
      case "remotemissile_projectile_mp":
        var_00 thread grenade_earthquake();
      case "iw7_harpoon_zm":
        break;
      case "iw7_harpoon3_zm":
        var_00 thread runharpoontraplogic(var_00, self);
        break;
      case "iw7_blackholegun_mp":
        var_00 thread scripts\cp\cp_blackholegun::missilespawned(var_0.weapon_name, var_00);
        break;
      case "iw7_harpoon1_zm":
        var_0.owner thread alt_acid_rain_dud_explode(var_00);
        break;
      case "iw7_harpoon4_zm":
        var_0.owner thread thundergun_harpoon_dud_explode(var_00);
        var_0.owner thread thundergun_harpoon(var_0.weapon_name, var_00);
        break;
      case "iw7_harpoon2_zm":
        var_0.owner thread ben_franklin_harpoon_dud_explode(var_00);
        var_0.owner thread ben_franklin_harpoon(var_00);
        break;
      default:
        break;
    }
  }
}

ben_franklin_harpoon_activate(var_00, var_01, var_02) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_03 = level._effect["hammer_of_dawn_lightning"];
  level notify("ben_franklin_lightning_pos", var_00);
  playFX(var_03, var_00, anglesToForward(self.angles), anglestoup(self.angles));
  playLoopSound(var_00, "harpoon2_impact");
  thread run_stun_logic(var_00, var_01, var_02, var_03);
}

run_stun_logic(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("disconnected");
  level endon("game_ended");
  var_04 = anglesToForward(self.angles);
  var_04 = vectornormalize(var_04);
  var_04 = var_04 * 100;
  var_05 = -1 * var_04;
  var_06 = anglestoleft(self.angles);
  var_06 = vectornormalize(var_06);
  var_06 = var_06 * 100;
  var_07 = -1 * var_06;

  if(isDefined(var_01)) {
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
  }

  var_08 = "reload_zap_screen";
  var_09 = max(1000, 0.5 * var_02);
  self radiusdamage(var_00, 128, var_09, var_09, self, "MOD_GRENADE_SPLASH", "iw7_harpoon2_zm_stun");
  scripts\engine\utility::waitframe();

  if(distance2dsquared(self.origin, var_00) <= 16384) {
    playfxontagforclients(level._effect[var_08], self, "tag_eye", self);
  }

  wait 0.25;
  var_10 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_11 = 65536;
  var_08 = "reload_zap_m";

  foreach(var_13 in var_10) {
    if(var_13.agent_type == "slasher" || var_13.agent_type == "superslasher") {
      continue;
    }
    if(distancesquared(var_13.origin, var_00) < var_11) {
      var_14 = var_13 gettagorigin("j_spineupper");
      var_13 thread zap_over_time(1, self);
      playFX(var_03, var_13.origin);
    }
  }

  if(isDefined(level.played_acid_rain_effect)) {
    level.played_ben_franklin_effect = undefined;
  }
}

play_stun_fx(var_00, var_01, var_02, var_03, var_04) {
  var_05 = "reload_zap_m";
  playLoopSound(var_04, "perk_blue_bolts_sparks");
  playFX(level._effect[var_05], var_04 + var_00);
  scripts\engine\utility::waitframe();
  playFX(level._effect[var_05], var_04 + var_01);
  scripts\engine\utility::waitframe();
  playFX(level._effect[var_05], var_04 + var_02);
  scripts\engine\utility::waitframe();
  playFX(level._effect[var_05], var_04 + var_03);
  scripts\engine\utility::waitframe();
}

zap_over_time(var_00, var_01) {
  self endon("death");
  self.stunned = 1;
  thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);

  while(var_00 > 0) {
    self.stun_hit_time = gettime() + 1500.0;
    wait 0.1;
    self getrandomarmkillstreak(1, self.origin, var_01, var_01, "MOD_GRENADE_SPLASH", "iw7_harpoon2_zm_stun");
    var_00 = var_00 - 1;
    wait 1.5;
  }

  self.stunned = undefined;
}

ben_franklin_harpoon_dud_explode(var_00) {
  self endon("disconnect");
  self endon("death");
  var_00 waittill("death");

  if(isDefined(var_0.origin)) {
    thread ben_franklin_harpoon_activate(var_0.origin, undefined, 500000000);
  }

  self notify("remove_this_function_since_you_missed_zomb");
}

ben_franklin_harpoon(var_00) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("remove_this_function_since_you_missed_zomb");
  self waittill("zombie_hit_by_ben", var_01, var_02, var_03);
  thread ben_franklin_harpoon_activate(var_01, var_02, var_03);
}

thundergun_harpoon_dud_explode(var_00) {
  self endon("disconnect");
  self endon("death");
  var_00 waittill("death");
  var_01 = var_0.origin;

  if(isDefined(var_0.origin)) {
    var_02 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_03 = 160000;

    foreach(var_05 in var_02) {
      if(!isDefined(var_05)) {
        continue;
      }
      if(!isDefined(var_5.agent_type)) {
        continue;
      }
      if(distancesquared(var_5.origin, var_01) < var_03) {
        var_5.do_immediate_ragdoll = 1;
        var_5.disable_armor = 1;
        var_5.customdeath = 1;
        playLoopSound(var_5.origin, "perk_blue_bolts_sparks");
        var_06 = anglesToForward(self.angles);
        var_07 = vectornormalize(var_06) * -100;

        if(isDefined(var_5.agent_type) && (var_5.agent_type != "slasher" && var_5.agent_type != "superslasher")) {
          var_05 giveflagcapturexp(vectornormalize(var_5.origin - (self.origin + var_07)) * 800 + (200, 0, 200));
        }

        wait 0.2;
        var_5.nocorpse = 1;
        var_5.full_gib = 1;

        if(isDefined(var_5.agent_type) && (var_5.agent_type == "slasher" || var_5.agent_type == "superslasher")) {
          var_05 getrandomarmkillstreak(var_5.health, var_5.origin, self, self, "MOD_UNKNOWN", "iw7_harpoon4_zm");
        } else {
          var_05 getrandomarmkillstreak(var_5.health + 1000, var_5.origin, self, self, "MOD_UNKNOWN", "iw7_harpoon4_zm");
        }
      }
    }
  }

  self notify("remove_this_function_since_you_missed_zomb");
}

fling_zombie_thundergun_harpoon(var_00, var_01, var_02, var_03) {
  self endon("death");
  var_03 endon("death");

  if(!isDefined(var_03)) {
    return;
  }
  var_3.angles = vectortoangles(var_1.origin - var_3.origin) + (0, 0, 180);
  var_04 = var_1.origin - var_3.origin;
  var_05 = anglesToForward(var_2.angles);
  var_06 = vectornormalize(var_05) * -100;
  self giveflagcapturexp(vectornormalize(self.origin - (var_2.origin + var_06)) * 800 + (200, 0, 200));
  wait 0.16;

  if(isDefined(var_02)) {
    var_1.do_immediate_ragdoll = 1;
    var_1.disable_armor = 1;
    var_1.customdeath = 1;
    wait 0.1;
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
    self getrandomarmkillstreak(self.health + 1000, var_1.origin, var_02, var_02, "MOD_UNKNOWN", "iw7_harpoon4_zm");
  } else {
    self.nocorpse = 1;
    self.full_gib = 1;
    self getrandomarmkillstreak(self.health + 1000, var_1.origin, var_01, var_01, "MOD_UNKNOWN", "iw7_harpoon4_zm");
  }
}

thundergun_harpoon(var_00, var_01) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("remove_this_function_since_you_missed_zomb");
  var_02 = 256;
  var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_04 = self.angles;
  var_05 = self getEye();

  while(isDefined(var_01)) {
    var_06 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_03, undefined, 24, var_02);
    self.closestenemies = var_06;
    var_07 = 0;

    foreach(var_09 in self.closestenemies) {
      if(!isDefined(var_9.agent_type)) {
        continue;
      }
      if(isDefined(var_01)) {
        if(distance2dsquared(var_1.origin, var_9.origin) < 16384) {
          if(isDefined(var_9.agent_type) && (var_9.agent_type == "slasher" || var_9.agent_type == "superslasher")) {
            var_09 getrandomarmkillstreak(var_9.health, var_9.origin, self, self, "MOD_UNKNOWN", "iw7_harpoon4_zm");
          } else {
            var_09 thread fling_zombie_thundergun_harpoon(var_9.health + 1000, var_09, self, var_01);
          }

          scripts\engine\utility::waitframe();
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

alt_acid_rain_launch_projectile_during_trail(var_00) {
  var_00 endon("death");

  while(isDefined(var_00)) {
    wait 0.3;

    if(!isDefined(var_0.origin) || !isDefined(var_0.angles)) {
      return;
    }
    var_01 = vectortoangles(anglestoup(var_0.angles));
    thread alt_acid_rain_activate(var_0.origin + (0, 0, 5), var_01);
    scripts\engine\utility::waitframe();
    thread alt_acid_rain_activate(scripts\engine\utility::drop_to_ground(var_0.origin), var_0.angles);
    wait 0.3;
  }
}

alt_acid_rain_dud_explode(var_00) {
  self endon("disconnect");
  self endon("death");
  var_01 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1);
  var_02 = var_0.angles;
  var_03 = var_0.origin;
  var_00 waittill("death");

  if(!isDefined(var_0.origin)) {
    return;
  }
  playFX(level._effect["acid_rain_explosion"], var_0.origin);
  scripts\engine\utility::waitframe();
  playFX(level._effect["acid_rain"], var_0.origin);
  var_04 = gettime();
  var_05 = var_0.origin;
  var_06 = spawn("trigger_radius", var_0.origin, 0, 128, 64);
  var_06 thread deal_damage_to_enemies(self, var_04);
  var_06 thread delete_after_time(self, var_04);
}

delete_after_time(var_00, var_01) {
  var_00 endon("death");
  self endon("death");

  while(gettime() <= var_01 + 3400) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(level.played_acid_rain_effect)) {
    level.played_acid_rain_effect = undefined;
  }

  self delete();
}

deal_damage_to_enemies(var_00, var_01) {
  var_00 endon("death");
  self endon("death");

  while(gettime() <= var_01 + 3400) {
    self waittill("trigger", var_02);

    if(!isDefined(var_02)) {
      continue;
    }
    if(!var_02 scripts\cp\utility::is_zombie_agent()) {
      continue;
    }
    if(isDefined(var_00)) {
      if(var_2.agent_type == "slasher" || var_2.agent_type == "superslasher") {
        var_02 getrandomarmkillstreak(0.1 * var_2.maxhealth, var_2.origin, var_00, var_00, "MOD_RIFLE_BULLET", "iw7_harpoon1_zm");
      } else {
        playFX(level._effect["acid_rain"], var_2.origin);
        var_02 getrandomarmkillstreak(var_2.maxhealth, var_2.origin, var_00, var_00, "MOD_RIFLE_BULLET", "iw7_harpoon1_zm");
      }

      continue;
    }

    var_02 getrandomarmkillstreak(var_2.maxhealth, var_2.origin, undefined, undefined, "MOD_RIFLE_BULLET", "iw7_harpoon1_zm");
  }
}

alt_acid_rain_activate(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_00) || !isDefined(var_01)) {
    return;
  }
  for(var_02 = 0; var_02 < 3; var_2++) {
    var_03 = dropscavengerbag(var_00, var_01);
    var_04 = var_00 + var_03;
    magicbullet("iw7_acid_rain_projectile_zm", var_00, var_04, self);
    scripts\engine\utility::waitframe();
    playFX(level._effect["acid_rain_explosion"], var_04);
  }
}

dropscavengerbag(var_00, var_01) {
  var_02 = anglestoup(var_01);
  var_03 = anglestoright(var_01);
  var_04 = anglesToForward(var_01);
  var_05 = randomint(360);
  var_06 = randomint(360);
  var_07 = cos(var_06) * sin(var_05);
  var_08 = sin(var_06) * sin(var_05);
  var_09 = cos(var_05);
  var_10 = (var_07 * var_03 + var_08 * var_04 + var_09 * var_02) / 0.33;
  return -1 * var_10;
}

acid_rain_radial_activate() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("acid_rain_radial_activate", var_00);
    self radiusdamage(var_00, 300, 1000, 1000, self);
    scripts\engine\utility::waitframe();
  }
}

waittill_missile_fire() {
  self waittill("missile_fire", var_00, var_01);

  if(isDefined(var_00)) {
    if(!isDefined(var_0.weapon_name)) {
      var_02 = getweaponbasename(var_01);

      if(isDefined(var_02)) {
        var_0.weapon_name = var_02;
      } else {
        var_0.weapon_name = var_01;
      }
    }

    if(!isDefined(var_0.owner)) {
      var_0.owner = self;
    }

    if(!isDefined(var_0.team)) {
      var_0.team = self.team;
    }
  }

  return var_00;
}

update_harpoon_upgrade_quest(var_00, var_01) {
  var_00 endon("death");
  var_00 waittill("missile_stuck", var_02);

  if(isDefined(level.animal_quest_volume) && scripts\engine\utility::flag("harpoon_upgrade_quest_active")) {
    if(ispointinvolume(var_0.origin, level.animal_quest_volume)) {
      var_03 = scripts\engine\utility::getstructarray("animal_statues", "script_noteworthy");
      var_04 = sortbydistance(var_03, var_0.origin)[0];
      level.animal_statue_kills[var_4.targetname]++;
    }
  }
}

runharpoontraplogic(var_00, var_01) {
  var_00 endon("death");
  var_00 waittill("missile_stuck", var_02);
  var_03 = var_0.origin;
  var_04 = var_0.angles;
  var_05 = vectornormalize(anglesToForward(var_04));
  var_06 = vectornormalize(anglestoright(var_04));
  var_07 = vectorcross(var_05, var_06);
  var_0.angles = vectortoangles(var_07);
  var_08 = 3 * anglesToForward(var_0.angles);
  var_0.origin = var_0.origin + var_08;
  playLoopSound(var_0.origin, "weap_harpoon3_impact");
  wait 0.5;
  var_00 setscriptablepartstate("arrow_effects", "active");
  level.harpoon_projectiles[level.harpoon_projectiles.size] = var_00;

  if(level.harpoon_projectiles.size >= 6) {
    thread destroy_oldest_trap();
  }

  var_0.linked_to_targets = [];
  var_0.linked_fx = [];
  var_0.death_time = gettime() + 9000;
  var_00 thread connect_to_nearby_harpoon_projectiles(var_00, var_01);
  var_00 thread timeout_trap(var_00, var_01);
}

destroy_oldest_trap() {
  var_00 = level.harpoon_projectiles[0];
  var_00 notify("early_death");
  var_00 clean_up_trap_ent(var_00, var_0.origin);
}

timeout_trap(var_00, var_01) {
  var_00 endon("death");
  var_00 endon("early_death");
  wait 9.95;
  var_02 = var_0.origin;
  wait 0.05;
  var_00 clean_up_trap_ent(var_00, var_02);
}

clean_up_trap_ent(var_00, var_01) {
  if(scripts\engine\utility::array_contains(level.harpoon_projectiles, var_00)) {
    level.harpoon_projectiles = scripts\engine\utility::array_remove(level.harpoon_projectiles, var_00);
  }

  level.harpoon_projectiles = scripts\engine\utility::array_removeundefined(level.harpoon_projectiles);
  var_02 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var_01);
  triggerfx(var_02);
  playLoopSound(var_01, "weap_harpoon3_trap_off");
  thread placeequipmentfailedcleanup(var_02);
  var_00 delete();
}

connect_to_nearby_harpoon_projectiles(var_00, var_01) {
  var_00 endon("death");
  var_02 = scripts\engine\trace::create_world_contents();

  for(;;) {
    var_03 = [];
    var_04 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.harpoon_projectiles, [var_00], 2, 128);
    clean_up_links(var_00, var_04);

    foreach(var_06 in var_04) {
      if(scripts\engine\utility::array_contains(var_0.linked_to_targets, var_06)) {
        continue;
      }
      if(scripts\engine\utility::array_contains(var_6.linked_to_targets, var_00)) {
        continue;
      }
      var_07 = scripts\engine\trace::ray_trace(var_00 gettagorigin("TAG_FX"), var_06 gettagorigin("TAG_FX"), var_00, var_02);

      if(var_7["fraction"] < 0.95) {
        continue;
      } else {
        var_3[var_3.size] = var_06;
        var_0.linked_to_targets[var_0.linked_to_targets.size] = var_06;
      }
    }

    foreach(var_10 in var_03) {
      var_0.linked_fx[var_10.birthtime] = var_10;
      var_11 = distance(var_0.origin, var_10.origin);
      var_12 = spawn("trigger_rotatable_radius", var_00 gettagorigin("TAG_FX"), 0, 3, var_11);
      var_13 = vectortoangles(var_10 gettagorigin("TAG_FX") - var_00 gettagorigin("TAG_FX")) + (-90, 0, 0);
      var_12.angles = (90, var_13[1], var_13[2]);
      var_00 thread play_vfx_between_points_trap_gun(var_00, var_10, var_12);
      var_00 thread damage_enemies_in_trigger(var_10, var_00, var_12, var_01);
      thread clean_up_trigger_on_death(var_10, var_00, var_12);
    }

    wait 1;
  }
}

play_vfx_between_points_trap_gun(var_00, var_01, var_02) {
  var_03 = playfxontagsbetweenclients(level._effect["trap_ww_beam"], var_00, "tag_fx", var_01, "tag_fx");
  thread kill_fx_on_death(var_00, var_01, var_02, var_03);
}

kill_fx_on_death(var_00, var_01, var_02, var_03) {
  level endon("game_ended");
  var_04 = var_0.origin;
  var_05 = var_00 gettagorigin("TAG_FX");
  var_06 = var_01 gettagorigin("TAG_FX");
  var_07 = max((var_1.death_time - gettime()) / 1000, 0);
  var_08 = max((var_0.death_time - gettime()) / 1000 - var_07 - 0.2, 0);
  thread play_sfx_on_harpoon_trap(var_00, var_01, var_02);

  if(var_07 > 0 && isDefined(var_00) && isDefined(var_01)) {
    scripts\cp\utility::waittill_any_ents_or_timeout_return(var_07, var_00, "death", var_01, "death", var_02, "death");
  } else if(isDefined(var_00) && isDefined(var_01)) {
    scripts\engine\utility::waittill_any_ents(var_00, "death", var_01, "death", var_02, "death");
  }

  if(isDefined(var_03)) {
    var_03 delete();
  }

  playfxbetweenpoints(level._effect["trap_ww_beam_death"], var_05, vectortoangles(var_06 - var_05), var_06);
}

play_sfx_on_harpoon_trap(var_00, var_01, var_02) {
  var_03 = var_0.origin;
  var_04 = var_01 gettagorigin("TAG_FX");
  var_05 = [];
  var_5[0] = var_03;
  var_5[1] = var_04;
  var_06 = max((var_1.death_time - gettime()) / 1000, 0);
  var_07 = averagepoint(var_05);
  playLoopSound(var_07, "weap_harpoon3_trap_on");
  var_08 = spawn("script_origin", var_07);
  wait 0.05;
  var_08 playLoopSound("weap_harpoon3_trap_lp");

  if(var_06 > 0 && isDefined(var_00) && isDefined(var_01)) {
    scripts\cp\utility::waittill_any_ents_or_timeout_return(var_06, var_00, "death", var_01, "death", var_02, "death");
  } else if(isDefined(var_00) && isDefined(var_01)) {
    scripts\engine\utility::waittill_any_ents(var_00, "death", var_01, "death", var_02, "death");
  }

  wait 1;
  var_08 stoploopsound("weap_harpoon3_trap_lp");
  wait 0.05;
  var_08 delete();
}

damage_enemies_in_trigger(var_00, var_01, var_02, var_03) {
  self endon("death");
  var_02 endon("death");
  var_00 endon("death");
  var_01 endon("death");

  for(;;) {
    var_02 waittill("trigger", var_04);

    if(!var_04 scripts\cp\utility::is_zombie_agent()) {
      continue;
    }
    if(var_4.agent_type == "slasher" || var_4.agent_type == "superslasher") {
      if(scripts\engine\utility::is_true(var_4.got_hit_once)) {
        continue;
      } else {
        var_04 thread do_damage_on_slasher_once(var_04, var_03);
      }
    }

    thread run_harpoon_laser_death(var_04, var_03);
  }
}

do_damage_on_slasher_once(var_00, var_01) {
  var_00 endon("death");
  level endon("game_ended");
  var_0.got_hit_once = 1;

  if(var_0.agent_type == "superslasher") {
    wait 5.0;
  } else {
    wait 2.0;
  }

  var_0.got_hit_once = undefined;
}

run_harpoon_laser_death(var_00, var_01) {
  var_0.atomize_me = 1;
  var_0.not_killed_by_headshot = 1;

  if(isDefined(var_01)) {
    var_00 getrandomarmkillstreak(var_0.health, var_0.origin, var_01, var_01, "MOD_UNKNOWN", "iw7_harpoon3_zm");
  } else {
    var_00 getrandomarmkillstreak(var_0.health, var_0.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_harpoon3_zm");
  }
}

clean_up_trigger_on_death(var_00, var_01, var_02) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(var_00, "death", var_01, "death");

  if(isDefined(var_02)) {
    var_02 delete();
  }
}

clean_up_links(var_00, var_01) {
  var_0.linked_to_targets = scripts\engine\utility::array_removeundefined(var_0.linked_to_targets);

  foreach(var_03 in var_0.linked_to_targets) {
    if(isDefined(var_0.linked_fx[var_3.birthtime])) {
      var_0.linked_fx[var_3.birthtime] = undefined;
    }

    if(!scripts\engine\utility::array_contains(var_01, var_03) && scripts\engine\utility::array_contains(var_0.linked_to_targets, var_03)) {
      var_0.linked_to_targets = scripts\engine\utility::array_remove(var_0.linked_to_targets, var_03);
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
    var_00 = waittill_grenade_fire();

    if(isDefined(var_0.weapon_name)) {
      if(glprox_trygetweaponname(var_0.weapon_name) == "stickglprox") {
        semtexused(var_00);
      }
    }
  }
}

glprox_trygetweaponname(var_00) {
  if(var_00 != "none" && getweaponbasename(var_00) == "iw7_glprox_mp") {
    if(scripts\cp\utility::isaltmodeweapon(var_00)) {
      var_01 = getweaponattachments(var_00);
      var_00 = var_1[0];
    } else
      var_00 = getweaponbasename(var_00);
  }

  return var_00;
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
    var_00 = self getstance();
    stancerecoilupdate(var_00);
  }
}

stancerecoilupdate(var_00) {
  var_01 = self getcurrentprimaryweapon();
  var_02 = 0;

  if(isrecoilreducingweapon(var_01)) {
    var_02 = getrecoilreductionvalue();
  }

  if(var_00 == "prone") {
    var_03 = scripts\cp\utility::coop_getweaponclass(var_01);

    if(isDefined(var_03)) {
      if(var_03 == "weapon_lmg") {
        setrecoilscale(0, 40);
        return;
      }

      if(var_03 == "weapon_sniper") {
        if(issubstr(var_01, "barrelbored")) {
          setrecoilscale(0, 20 + var_02);
          return;
        }

        setrecoilscale(0, 40 + var_02);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(var_00 == "crouch") {
    var_03 = scripts\cp\utility::coop_getweaponclass(var_01);

    if(isDefined(var_03)) {
      if(var_03 == "weapon_lmg") {
        setrecoilscale(0, 10);
        return;
      }

      if(var_03 == "weapon_sniper") {
        if(issubstr(var_01, "barrelbored")) {
          setrecoilscale(0, 10 + var_02);
          return;
        }

        setrecoilscale(0, 20 + var_02);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(var_02 > 0)
    setrecoilscale(0, var_02);
  else {
    setrecoilscale();
  }
}

setrecoilscale(var_00, var_01) {
  if(!isDefined(var_00)) {
    var_00 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var_00;
  } else {
    self.recoilscale = self.recoilscale + var_00;
  }

  if(isDefined(var_01)) {
    if(isDefined(self.recoilscale) && var_01 < self.recoilscale) {
      var_01 = self.recoilscale;
    }

    var_02 = 100 - var_01;
  } else
    var_02 = 100 - self.recoilscale;

  if(var_02 < 0) {
    var_02 = 0;
  }

  if(var_02 > 100) {
    var_02 = 100;
  }

  if(var_02 == 100) {
    self getweaponrankforxp();
    return;
  }

  self getweaponrankinfomaxxp(var_02);
}

isrecoilreducingweapon(var_00) {
  if(!isDefined(var_00) || var_00 == "none") {
    return 0;
  }

  var_01 = 0;

  if(issubstr(var_00, "kbsscope") || issubstr(var_00, "m8scope_zm") || issubstr(var_00, "cheytacscope")) {
    var_01 = 1;
  }

  return var_01;
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
    self waittill("slasher_killed_by_own_weapon", var_00, var_01);
    level thread slasher_killed_vo(var_00);
    scripts\cp\zombies\achievement::update_achievement("TABLES_TURNED", 1);
    self notify("achievement_done");
  }
}

slasher_killed_vo(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("disconnect");

  if(var_0.vo_prefix == "p5_") {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_death_p5", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  }

  wait 5;
  var_00 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_slasher", "zmb_comment_vo", "highest", 20, 0, 0, 1);
}

watchforweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_00);

    if(var_00 == "none") {
      continue;
    }
    var_01 = getweaponbasename(var_00);

    if(isvalidweapon(var_00)) {
      self.last_valid_weapon = var_00;
    }

    switch (var_01) {
      case "iw7_axe_zm_pap2":
      case "iw7_axe_zm_pap1":
      case "iw7_axe_zm":
        if(get_weapon_level(var_00) > 1) {} else {}

        break;
      default:
        break;
    }
  }
}

isvalidweapon(var_00) {
  var_01 = level.additional_laststand_weapon_exclusion;

  if(var_00 == "none") {
    return 0;
  } else if(scripts\engine\utility::array_contains(var_01, var_00)) {
    return 0;
  } else if(scripts\engine\utility::array_contains(var_01, getweaponbasename(var_00))) {
    return 0;
  } else if(scripts\cp\utility::is_melee_weapon(var_00, 1)) {
    return 0;
  } else {
    return 1;
  }
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

  for(;;) {
    self waittill("weapon_change", var_01);

    if(var_01 == "none") {
      self.saved_lastweapon = var_00;
      continue;
    }

    var_02 = weaponinventorytype(var_01);

    if(var_02 != "primary" && var_02 != "altmode") {
      self.saved_lastweapon = var_00;
      continue;
    }

    self[[level.move_speed_scale]]();
    self.saved_lastweapon = var_00;
    var_00 = var_01;
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
    self waittill("grenade_pullback", var_00);
    var_01 = self _meth_8556();

    if(var_01 != "none") {
      continue;
    }
    if(isDefined(level.custom_grenade_pullback_func)) {
      thread[[level.custom_grenade_pullback_func]](self, var_00);
    }

    thread watchoffhandcancel();
    self.throwinggrenade = var_00;

    if(var_00 == "c4_zm") {
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
  var_00 = gettime();
  var_01 = waittill_grenade_fire();

  if(!isDefined(var_01)) {
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
      if(gettime() - var_00 > 1000) {
        var_1.iscooked = 1;
      }

      var_01 thread grenade_earthquake();
      var_1.originalowner = self;
      break;
    case "cluster_grenade_zm":
      var_1.clusterticks = var_1.ticks;

      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1.originalowner = self;
      var_01 thread clustergrenadeused();
      var_01 thread grenade_earthquake();
      break;
    case "zfreeze_semtex_mp":
    case "semtex_zm":
    case "semtex_mp":
      thread semtexused(var_01);
      break;
    case "c4_zm":
      thread scripts\cp\powers\coop_c4::c4_used(var_01);
      break;
    case "smoke_grenade_mp":
      var_01 thread watchsmokeexplode();
      break;
    case "claymore_mp":
      thread claymoreused(var_01);
      break;
    case "concussion_grenade_mp":
      var_01 thread watchconcussiongrenadeexplode();
      break;
    case "bouncingbetty_mp":
      thread mineused(var_01, ::spawnmine);
      break;
    case "throwingknifejugg_mp":
    case "throwingknifec4_mp":
    case "throwingknife_mp":
      level thread throwingknifeused(self, var_01, var_1.weapon_name);
      break;
    case "zom_repulsor_mp":
      var_01 delete();
      break;
    case "gas_grenade_mp":
      var_01 thread watchgasgrenadeexplode();
      break;
    case "splash_grenade_zm":
    case "splash_grenade_mp":
      var_01 thread grenade_earthquake();
      thread scripts\cp\cp_splash_grenade::splashgrenadeused(var_01);
      break;
    case "portal_generator_zm":
    case "portal_generator_mp":
      thread scripts\cp\powers\coop_portal_generator::portalgeneratorused(var_01);
      break;
    case "ztransponder_mp":
    case "transponder_mp":
      thread scripts\cp\powers\coop_transponder::transponder_use(var_01);
      break;
    case "micro_turret_zm":
    case "micro_turret_mp":
      thread scripts\cp\powers\coop_microturret::microturret_use(var_01);
      break;
    case "blackhole_grenade_zm":
    case "blackhole_grenade_mp":
      thread scripts\cp\powers\coop_blackholegrenade::blackholegrenadeused(var_01);
      break;
    case "trip_mine_mp":
      thread scripts\cp\powers\coop_trip_mine::tripmine_used(var_01);
      break;
    case "heart_cp":
      thread heart_used();
      break;
    case "rat_king_eye_cp":
      thread eye_activated();
      break;
  }
}

rat_executevisuals(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  scripts\engine\utility::waittill_any_timeout(var_00, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

handleratvisionburst(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");
  var_00 thread rat_executevisuals(2.4);
}

isinvalidzone(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = getEntArray("power_exclusion_volume", "targetname");

  if(isDefined(var_05)) {
    if(isDefined(level.neil) && isDefined(level.neil.upper_body)) {
      if(var_05 == level.neil || var_05 == level.neil.upper_body) {
        return 0;
      }
    }

    if(isDefined(level.boat_vehicle)) {
      if(var_05 == level.boat_vehicle) {
        return 0;
      }
    }

    if(isDefined(var_5.targetname) && var_5.targetname == "beginning_area_balloons") {
      return 0;
    }
  }

  if(isDefined(var_01)) {
    var_06 = scripts\engine\utility::array_combine(var_06, var_01);
  }

  foreach(var_08 in var_06) {
    if(ispointinvolume(var_00, var_08)) {
      return 0;
    }
  }

  if(scripts\engine\utility::is_true(var_04) && !_ispointonnavmesh(var_00)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_03)) {
    if(_navtrace(var_2.origin, var_00)) {
      return 0;
    }
  }

  return 1;
}

placeequipmentfailed(var_00, var_01, var_02, var_03) {
  if(isplayer(self)) {
    self playlocalsound("scavenger_pack_pickup");
  }

  if(scripts\engine\utility::is_true(var_01)) {
    var_04 = undefined;

    if(isplayer(self)) {
      self playlocalsound("ww_magicbox_laughter");

      if(isDefined(var_03)) {
        var_04 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_02, self, anglesToForward(var_03), anglestoup(var_03));
      } else {
        var_04 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_02, self);
      }
    } else
      var_04 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var_02);

    triggerfx(var_04);
    thread placeequipmentfailedcleanup(var_04);
  }
}

placeequipmentfailedcleanup(var_00) {
  wait 2;
  var_00 delete();
}

spawnmine(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03)) {
    var_03 = (0, randomfloat(360), 0);
  }

  var_04 = level.weaponconfigs[var_02];
  var_05 = spawn("script_model", var_00);
  var_5.angles = var_03;
  var_5.owner = var_01;
  var_5.weapon_name = var_02;
  var_5.config = var_04;
  var_05 setModel(var_4.model);
  var_05 setotherent(var_01);
  var_5.killcamoffset = (0, 0, 4);
  var_5.killcament = spawn("script_model", var_5.origin + var_5.killcamoffset);
  var_5.killcament setscriptmoverkillcam("explosive");
  var_01 onlethalequipmentplanted(var_05);

  if(isDefined(var_4.mine_beacon)) {
    var_05 thread doblinkinglight("tag_fx", var_4.mine_beacon["friendly"], var_4.mine_beacon["enemy"]);
  }

  var_06 = undefined;

  if(self != level) {
    var_06 = self getlinkedparent();
  }

  var_05 explosivehandlemovers(var_06);
  var_05 thread mineproximitytrigger(var_06);
  var_05 thread grenade_earthquake();
  var_05 thread mineselfdestruct();
  var_05 thread mineexplodeonnotify();
  level thread monitordisownedequipment(var_01, var_05);
  return var_05;
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
  self waittill("detonateExplosive", var_00);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_00)) {
    var_00 = self.owner;
  }

  var_01 = self.config;
  var_02 = var_1.vfxtag;

  if(!isDefined(var_02)) {
    var_02 = "tag_fx";
  }

  var_03 = self gettagorigin(var_02);

  if(!isDefined(var_03)) {
    var_03 = self gettagorigin("tag_origin");
  }

  self notify("explode", var_03);
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

  var_04 = scripts\engine\utility::ter_op(isDefined(var_1.onexplodevfx), var_1.onexplodevfx, level.mine_explode);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_07 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, var_07, var_06, var_05, var_00, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

mineproximitytrigger(var_00) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_01 = self.config;
  wait(var_1.armtime);

  if(isDefined(var_1.mine_beacon)) {
    thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  }

  var_02 = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var_2.owner = self;
  var_2.team = var_2.owner.team;
  thread minedeletetrigger(var_02);

  if(isDefined(var_00)) {
    var_02 getrankxp();
    var_02 linkto(var_00);
  }

  self.damagearea = var_02;

  for(;;) {
    var_02 waittill("trigger", var_03);

    if(isplayer(var_03)) {
      wait 0.05;
      continue;
    }

    if(var_03 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound(self.config.ontriggeredsfx);
  explosivetrigger(var_03, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(var_00) {
  scripts\engine\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

doblinkinglight(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    var_01 = scripts\engine\utility::getfx("weap_blink_friend");
  }

  if(!isDefined(var_02)) {
    var_02 = scripts\engine\utility::getfx("weap_blink_enemy");
  }

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

  if(!level.teambased) {
    var_03 = ::checkplayer;
  }

  var_04 = randomfloatrange(0.05, 0.25);
  wait(var_04);
  childthread onjointeamblinkinglight(var_00, var_01, var_02, var_03);

  foreach(var_06 in level.players) {
    if(isDefined(var_06)) {
      if(self.owner[[var_03]](var_06)) {
        playfxontagforclients(var_00, self, var_02, var_06);
      } else {
        playfxontagforclients(var_01, self, var_02, var_06);
      }

      wait 0.05;
    }
  }
}

checkplayer(var_00) {
  return self == var_00;
}

checkteam(var_00) {
  return self.team == var_0.team;
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

takeheart(var_00) {
  self notify("remove_heart");
  self.has_heart = undefined;
}

heart_used() {
  self endon("disconnect");
  self endon("remove_heart");
  self notify("beginHeartTracking");
  self endon("beginHeartTracking");
  self endon("death");
  var_00 = self _meth_8513("ges_heart_pull", "explode");
  var_01 = self getgestureanimlength("ges_heart_pull");
  self.changingweapon = undefined;
  var_02 = self.origin;
  var_03 = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(var_05 in var_03) {
    if(isDefined(var_5.flung) || isDefined(var_5.agent_type) && (var_5.agent_type == "zombie_brute" || var_5.agent_type == "zombie_ghost" || var_5.agent_type == "zombie_grey" || var_5.agent_type == "slasher" || var_5.agent_type == "superslasher")) {
      continue;
    }
    if(distancesquared(var_5.origin, var_02) <= 65536) {
      if(var_05 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        var_5.scripted_mode = 1;
        var_5.ignoreall = 1;
        var_05 give_mp_super_weapon(var_5.origin);
      }

      var_5.scripted_mode = 1;
      var_5.ignoreall = 1;
      var_05 give_mp_super_weapon(var_5.origin);
      var_5.flung = 1;
      var_5.do_immediate_ragdoll = 1;
      var_5.disable_armor = 1;
      var_5.full_gib = 1;
      var_5.nocorpse = 1;
      var_05 setsolid(0);
      playFX(level._effect["rat_swarm_cheap"], var_05 gettagorigin("j_spine4"), anglesToForward(var_5.angles));
      thread deal_damage(var_05, self);
    }
  }

  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("heart_used", 1);
}

use_heart_notify() {
  self notify("heart_used", 1);
}

deal_damage(var_00, var_01) {
  var_00 endon("death");
  wait 0.7;
  var_0.scripted_mode = undefined;
  var_02 = var_00 gettagorigin("j_spine4");
  playFX(level._effect["gore"], var_02, (1, 0, 0));
  playLoopSound(var_02, "gib_fullbody");
  var_01 earthquakeforplayer(0.5, 1.5, var_02, 120);
  scripts\engine\utility::waitframe();

  if(isDefined(var_00)) {
    var_00 getrandomarmkillstreak(var_0.health + 100000, var_0.origin, var_01, var_01, "MOD_EXPLOSIVE", "heart_cp");
  }
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

  for(var_05 = 8.0; var_05 > 0.0; var_05 = var_05 - 0.2) {
    foreach(var_07 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
      if(isDefined(var_7.agent_type) && (var_7.agent_type == "zombie_brute" || var_7.agent_type == "superslasher" || var_7.agent_type == "slasher" || var_7.agent_type == "zombie_grey")) {
        continue;
      }
      var_08 = getdamagefromzombietype(var_07);

      if(isalive(var_07)) {
        var_07 applygaseffect(var_00, var_01, var_02, var_02, int(var_08));
      }
    }

    wait 0.2;
  }

  var_04 delete();
  wait 2.0;
  var_02 delete();

  foreach(var_07 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isalive(var_07)) {
      var_7.flame_damage_time = undefined;
    }
  }
}

getdamagefromzombietype(var_00) {
  if(isalive(var_00)) {
    if(scripts\engine\utility::is_true(var_0.is_suicide_bomber)) {
      return int(min(1000, var_0.maxhealth * 0.25));
    } else {
      return int(min(1000, var_0.maxhealth * 0.1));
    }
  } else
    return 150;
}

applygaseffect(var_00, var_01, var_02, var_03, var_04) {
  if(isalive(self) && self istouching(var_02)) {
    if(var_00 scripts\cp\utility::isenemy(self)) {
      var_03 radiusdamage(self.origin, 1, var_04, var_04, var_00, "MOD_GRENADE_SPLASH", "gas_grenade_mp");
      self.flame_damage_time = gettime() + 200;
    }
  }
}

throwingknifeused(var_00, var_01, var_02) {
  if(var_02 == "throwingknifec4_mp") {
    var_01 makeunusable();
    var_01 thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(var_00, var_01);
  var_03 = undefined;
  var_04 = undefined;
  var_01 waittill("missile_stuck", var_03, var_04);
  var_05 = isDefined(var_04) && var_04 == "tag_flicker";
  var_06 = isDefined(var_04) && var_04 == "tag_weapon";

  if(isDefined(var_03) && (isplayer(var_03) || isagent(var_03)) && var_05) {
    var_03 notify("shield_hit", var_01);
  }

  if(isDefined(var_03) && (isplayer(var_03) || isagent(var_03)) && !var_06 && !var_05) {
    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(var_03, var_01)) {
      var_01 delete();
      return;
    } else if(var_02 == "throwingknifec4_mp")
      throwingknifec4detonate(var_01, var_03, var_00);
  }

  if(isDefined(var_1.giveknifeback)) {
    throwingknifeused_trygiveknife(var_00, var_1.power);
    var_01 delete();
  }
}

throwingknifedamagedvictim(var_00, var_01) {
  var_01 endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");

  for(;;) {
    var_00 waittill("victim_damaged", var_02, var_03, var_04, var_05, var_06, var_07);

    if(isDefined(var_03) && var_03 == var_01) {
      if(var_07 == "throwingknifeteleport_mp" && !isDefined(var_1.knifeteleownerinvalid)) {
        throwingknifeteleport(var_01, var_02, var_00, 1);
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

throwingknifeused_trygiveknife(var_00, var_01, var_02) {
  var_03 = var_00 getweaponammoclip(var_02);
  var_04 = 2;
  var_05 = undefined;

  if(var_03 >= var_04) {
    var_05 = 0;
  } else {
    var_00 setweaponammoclip(var_02, var_03 + 1);
    var_00 thread hudicontype("throwingknife");
    var_05 = 1;
  }

  return var_05;
}

hudicontype(var_00) {
  var_01 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var_01 = 1;
  }

  if(!isplayer(self)) {
    return;
  }
  switch (var_00) {
    case "scavenger":
    case "throwingknife":
      if(!var_01) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
    case "boxofguns":
      if(!var_01) {
        self playlocalsound("mp_box_guns_ammo");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
    case "oracle":
      if(!var_01) {
        self playlocalsound("oracle_radar_pulse_plr");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var_00);
      }

      break;
  }
}

throwingknifeteleport(var_00, var_01, var_02, var_03) {
  var_02 playlocalsound("blinkknife_teleport");
  var_02 playsoundonmovingent("blinkknife_teleport_npc");
  playLoopSound(var_0.origin, "blinkknife_impact");
  thread throwingknifeteleport_fxstartburst(var_02, var_01);
  var_04 = var_01 _meth_8113();

  if(isDefined(var_04)) {
    var_04 setcontents(0);
  }

  var_05 = [];

  foreach(var_07 in level.characters) {
    if(!isDefined(var_07) || !isalive(var_07) || var_07 == var_01 || var_07 == var_02 || !var_02 scripts\cp\utility::isenemy(var_07)) {
      continue;
    }
    var_5[var_5.size] = var_07;
  }

  var_05 = sortbydistance(var_05, var_1.origin);
  var_09 = var_02 gettagorigin("TAG_EYE");
  var_10 = var_1.origin;
  var_11 = var_1.origin + (0, 0, var_9[2] - var_2.origin[2]);
  var_12 = var_2.angles;

  foreach(var_14 in var_05) {
    var_15 = (var_14.origin[0], var_14.origin[1], var_14 gettagorigin("TAG_EYE")[2]);

    if(distancesquared(var_14.origin, var_1.origin) < 230400 && sighttracepassed(var_11, var_15, 0, undefined)) {
      var_12 = vectortoangles(var_15 - var_11);
      break;
    }
  }

  var_02 setorigin(var_1.origin, !var_03);
  var_02 setplayerangles(var_12);
  throwingknifeteleport_fxendburst(var_02, var_01);
}

throwingknifeteleport_fxstartburst(var_00, var_01) {
  var_02 = var_1.origin - var_0.origin;
  var_03 = var_0.origin + (0, 0, 32);
  var_04 = vectornormalize(var_02);
  var_05 = vectornormalize(vectorcross(var_02, (0, 0, 1)));
  var_06 = vectorcross(var_05, var_04);
  var_07 = _axistoangles(var_04, var_05, var_06);
  var_08 = 0;

  if(var_08) {
    var_09 = spawn("script_model", var_03);
    var_9.angles = var_07;
    var_09 setModel("tag_origin");
    var_09 hidefromplayer(var_00);
    scripts\engine\utility::waitframe();
    _playfxontagforteam(scripts\engine\utility::getfx("vfx_knife_tele_start_friendly"), var_09, "tag_origin", var_0.team);
    wait 3.0;
    var_09 delete();
  } else {
    var_10 = spawn("script_model", var_03);
    var_10.angles = var_07;
    var_10 setModel("tag_origin");
    var_10 hidefromplayer(var_00);
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

throwingknifeteleport_fxendburst(var_00, var_01) {}

throwingknifec4detonate(var_00, var_01, var_02) {
  var_01 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var_0.origin);
  var_00 radiusdamage(var_0.origin, 180, 1200, 600, var_02, "MOD_EXPLOSIVE", var_0.weapon_name);
  var_00 thread grenade_earthquake();
  var_00 notify("explode", var_0.origin);
  var_00 delete();
}

throwingknifeused_recordownerinvalid(var_00, var_01) {
  var_01 endon("missile_stuck");
  var_01 endon("death");
  var_00 scripts\engine\utility::waittill_any("death", "disconnect");
  var_1.knifeteleownerinvalid = 1;
}

watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_00);
  stunenemiesinrange(var_00, self.owner);
}

stunenemiesinrange(var_00, var_01) {
  var_02 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_03 = scripts\engine\utility::get_array_of_closest(var_00, var_02, undefined, 24, 256);

  foreach(var_05 in var_03) {
    if(!var_05 scripts\cp\utility::agentisfnfimmune()) {
      var_05 thread fx_stun_damage(var_05, var_01);
    }
  }
}

fx_stun_damage(var_00, var_01) {
  var_00 endon("death");

  if(isDefined(var_0.stun_hit_time)) {
    if(gettime() > var_0.stun_hit_time) {
      if(var_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        var_0.scripted_mode = 1;
        var_0.ignoreall = 1;
        var_00 give_mp_super_weapon(var_0.origin);
      }

      var_0.allowpain = 1;
      var_0.stun_hit_time = gettime() + 1000;
      var_0.stunned = 1;
    } else
      return;
  } else {
    if(var_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
      var_0.scripted_mode = 1;
      var_0.ignoreall = 1;
      var_00 give_mp_super_weapon(var_0.origin);
    }

    var_0.allowpain = 1;
    var_0.stun_hit_time = gettime() + 1000;
    var_0.stunned = 1;
  }

  var_00 getrandomarmkillstreak(1, var_0.origin, var_01, var_01, "MOD_GRENADE_SPLASH", "concussion_grenade_mp");
  wait 1;

  if(var_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
    var_0.scripted_mode = 0;
    var_0.ignoreall = 0;
  }

  var_0.allowpain = 0;
  var_0.stunned = undefined;
}

mineused(var_00, var_01) {
  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  var_00 thread minethrown(self, var_0.weapon_name, var_01);
}

minethrown(var_00, var_01, var_02, var_03) {
  self.owner = var_00;
  self waittill("missile_stuck", var_04);

  if(!isDefined(var_00)) {
    return;
  }
  if(var_01 != "trip_mine_mp") {
    if(isDefined(var_04) && isDefined(var_4.owner)) {
      if(isDefined(var_03)) {
        self.owner[[var_03]](self);
      }

      self delete();
      return;
    }
  }

  var_05 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_06 = var_5["position"];

  if(var_5["fraction"] == 1) {
    var_06 = getgroundposition(self.origin, 12, 0, 32);
    var_5["normal"] = var_5["normal"] * -1;
  }

  var_07 = vectornormalize(var_5["normal"]);
  var_08 = vectortoangles(var_07);
  var_08 = var_08 + (90, 0, 0);
  var_09 = [[var_02]](var_06, var_00, var_01, var_08);
  var_09 thread minedamagemonitor();
  self delete();
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_00 = undefined;

  for(;;) {
    self waittill("damage", var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(is_hive_explosion(var_00, var_04)) {
      break;
    }
    if(!isplayer(var_00) && !isagent(var_00)) {
      continue;
    }
    if(isDefined(var_09) && isendstr(var_09, "betty_mp")) {
      continue;
    }
    if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_00)) {
      continue;
    }
    if(isDefined(var_09)) {
      switch (var_09) {
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

  if(isDefined(var_04) && (issubstr(var_04, "MOD_GRENADE") || issubstr(var_04, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_08) && var_08 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var_00)) {
    self.damagedby = var_00;
  }

  if(isplayer(var_00)) {
    var_00 scripts\cp\cp_damage::updatedamagefeedback("bouncing_betty");
  }

  self notify("detonateExplosive", var_00);
}

is_hive_explosion(var_00, var_01) {
  if(!isDefined(var_00) || !isDefined(var_0.classname)) {
    return 0;
  }

  return var_0.classname == "scriptable" && var_01 == "MOD_EXPLOSIVE";
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

  if(isDefined(var_05)) {
    var_00 unlink();
  }

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
  onlethalequipmentplanted(var_00);
  var_00 thread ondetonateexplosive();
  var_00 thread c4empdamage();
  var_00 thread claymoredetonation(var_05);
  self.changingweapon = undefined;
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
        if(isDefined(var_2.owner) && var_2.owner == self.owner) {
          continue;
        }
      }

      if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_02, 0)) {
        continue;
      }
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
  self notify("detonateExplosive");
}

explosivetrigger(var_00, var_01, var_02) {
  if(isplayer(var_00) && var_00 scripts\cp\utility::_hasperk("specialty_delaymine")) {
    var_00 notify("triggeredExpl", var_02);
    var_01 = level.delayminetime;
  }

  wait(var_01);
}

shouldaffectclaymore(var_00) {
  if(isDefined(var_0.disabled)) {
    return 0;
  }

  var_01 = self.origin + (0, 0, 32);
  var_02 = var_01 - var_0.origin;
  var_03 = anglesToForward(var_0.angles);
  var_04 = vectordot(var_02, var_03);

  if(var_04 < level.claymoredetectionmindist) {
    return 0;
  }

  var_02 = vectornormalize(var_02);
  var_05 = vectordot(var_02, var_03);
  return var_05 > level.claymoredetectiondot;
}

deleteondeath(var_00) {
  self waittill("death");
  wait 0.05;

  if(isDefined(var_00)) {
    if(isDefined(var_0.trigger)) {
      var_0.trigger delete();
    }

    var_00 delete();
  }
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

equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

makeexplosiveunusable() {
  self notify("equipmentWatchUse");
  self.trigger delete();
}

makeexplosivetargetablebyai(var_00) {
  scripts\cp\utility::make_entity_sentient_cp(self.owner.team);

  if(!isDefined(var_00) || !var_00) {
    self makeentitynomeleetarget();
  }
}

watchsmokeexplode() {
  level endon("smokeTimesUp");
  var_00 = self.owner;
  var_00 endon("disconnect");
  self waittill("explode", var_01);
  var_02 = 22500;
  var_03 = 12;
  var_04 = spawn("script_model", var_01);
  var_4.origin = var_01 + (0, 0, 56);
  var_04 makeentitysentient("allies", 1);
  var_4.health = 100000;
  var_4.maxhealth = 100000;
  var_4.threatbias = 10000;
  var_04 setthreatbiasgroup("players");
  level thread waitsmoketime(12, 22500, var_01, var_04);

  for(;;) {
    if(!isDefined(var_00)) {
      break;
    }
    var_05 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(var_07 in var_05) {
      if(var_7.species == "alien") {
        continue;
      }
      if(isDefined(var_7.smoked)) {
        continue;
      }
      var_08 = distance2dsquared(var_01, var_7.origin);

      if(var_08 < 90000) {
        var_07 thread target_smoke(var_04, 22500);
      }
    }

    foreach(var_11 in level.players) {
      if(!isDefined(var_11)) {
        continue;
      }
      var_12 = distance2dsquared(var_01, var_11.origin);

      if(var_12 < 22500) {
        var_11.inplayersmokescreen = var_00;
        var_11 setthreatbiasgroup("phased_players");
        continue;
      }

      var_11.inplayersmokescreen = undefined;
      var_11 setthreatbiasgroup("players");
    }

    wait 0.05;
  }
}

target_smoke(var_00, var_01) {
  scripts\cp\cp_agent_utils::agent_go_to_pos(var_0.origin, sqrt(var_01), "critical");

  if(!scripts\cp\cp_agent_utils::is_agent_scripted(self)) {
    self getenemyinfo(var_00);
    self getpathend(var_00);
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

waitsmoketime(var_00, var_01, var_02, var_03) {
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  level notify("smokeTimesUp");
  waittillframeend;

  foreach(var_05 in level.players) {
    if(isDefined(var_05)) {
      var_5.inplayersmokescreen = undefined;
      var_05 setthreatbiasgroup("players");
    }
  }

  var_03 delete();
}

c4used(var_00) {
  if(!scripts\cp\utility::isreallyalive(self)) {
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
  var_01 = level.weaponconfigs["c4_zm"];
  var_00 thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  var_00 thread c4_earthquake();
  var_00 thread c4activate();
  var_00 thread watchc4stuck();
  level thread monitordisownedequipment(self, var_00);
}

watchc4implode() {
  self.owner endon("disconnect");
  var_00 = self.owner;
  var_01 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_01 linkto(self);
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_02);
  thread c4implode(var_02, var_00, var_01);
}

c4implode(var_00, var_01, var_02) {
  var_01 endon("disconnect");
  wait 0.5;
  var_02 radiusdamage(var_00, 256, 1200, 600, var_01, "MOD_EXPLOSIVE", "c4_zm");
  thread c4_earthquake();
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

c4activate() {
  self endon("death");
  self waittill("missile_stuck", var_00);
  wait 0.05;
  self notify("activated");
  self.activated = 1;
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck", var_00);
  self give_player_tickets(1);
  self.c4stuck = 1;
  explosivehandlemovers(var_00);
}

onlethalequipmentplanted(var_00, var_01, var_02) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(scripts\engine\utility::is_true(var_02)) {
        self.plantedlethalequip[0] notify("detonateExplosive");
      } else {
        self.plantedlethalequip[0] deleteexplosive();
      }
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var_00;
  var_03 = var_00 getentitynumber();
  level.mines[var_03] = var_00;
  level notify("mine_planted");
}

watchc4altdetonate(var_00) {
  self notify("watchC4AltDetonate");
  self endon("watchC4AltDetonate");
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_01 = 0;

  for(;;) {
    if(self usebuttonpressed()) {
      var_01 = 0;

      while(self usebuttonpressed()) {
        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      if(var_01 >= 0.5) {
        continue;
      }
      var_01 = 0;

      while(!self usebuttonpressed() && var_01 < 0.5) {
        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      if(var_01 >= 0.5) {
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
    var_00 = self getcurrentweapon();

    if(var_00 != "c4_zm") {
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
  foreach(var_01 in self.plantedlethalequip) {
    if(isDefined(var_01) && var_1.weapon_name == "c4_zm") {
      var_01 thread waitanddetonate(0.1);
      scripts\engine\utility::array_remove(self.plantedlethalequip, var_01);
    }
  }

  self notify("c4_update", 0);
  waittillframeend;
  self notify("detonated");
}

waitanddetonate(var_00) {
  self endon("death");
  wait(var_00);
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
  var_00 = self.originalowner;
  var_00 endon("disconnect");
  thread ownerdisconnectcleanup(var_00);
  var_01 = [];

  for(var_02 = 0; var_02 < 4; var_2++) {
    var_1[var_02] = 0.2;
  }

  var_03 = 0;

  foreach(var_05 in var_01) {
    var_03 = var_03 + var_05;
  }

  var_07 = spawn("script_model", self.origin);
  var_07 linkto(self);
  var_07 setModel("tag_origin");
  var_07 setscriptmoverkillcam("explosive");
  var_07 thread deathdelaycleanup(self, var_03 + 5);
  var_07 thread ownerdisconnectcleanup(self.owner);
  var_7.threwback = self.threwback;
  var_08 = var_00 scripts\cp\utility::_launchgrenade("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  var_08 linkto(self);
  var_08 thread deathdelaycleanup(self, var_03);
  var_08 thread ownerdisconnectcleanup(self.owner);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_09);
  thread clustergrenadeexplode(var_09, var_01, var_00, var_07);
}

clustergrenadeexplode(var_00, var_01, var_02, var_03) {
  var_02 endon("disconnect");
  var_04 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_05 = 0;
  var_06 = var_00 + (0, 0, 3);
  var_07 = var_06 + (0, 0, -5);
  var_08 = physics_raycast(var_06, var_07, var_04, undefined, 0, "physicsquery_closest");

  if(isDefined(var_08) && var_8.size > 0) {
    var_05 = 1;
  }

  var_09 = scripts\engine\utility::ter_op(var_05, (0, 0, 32), (0, 0, 2));
  var_10 = var_00 + var_09;
  var_11 = randomint(90) - 45;
  var_04 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(var_12 = 0; var_12 < 4; var_12++) {
    var_3.shellshockondamage = scripts\engine\utility::ter_op(var_12 == 0, 1, undefined);
    var_03 radiusdamage(var_00, 256, 800, 400, var_02, "MOD_EXPLOSIVE", "cluster_grenade_zm");
    var_13 = scripts\engine\utility::ter_op(var_12 < 4, 90 * var_12 + var_11, randomint(360));
    var_14 = scripts\engine\utility::ter_op(var_05, 110, 90);
    var_15 = scripts\engine\utility::ter_op(var_05, 12, 45);
    var_16 = var_14 + randomint(var_15 * 2) - var_15;
    var_17 = randomint(60) + 30;
    var_18 = cos(var_13) * sin(var_16);
    var_19 = sin(var_13) * sin(var_16);
    var_20 = cos(var_16);
    var_21 = (var_18, var_19, var_20) * var_17;
    var_06 = var_10;
    var_07 = var_10 + var_21;
    var_08 = physics_raycast(var_06, var_07, var_04, undefined, 0, "physicsquery_closest");

    if(isDefined(var_08) && var_8.size > 0) {
      var_07 = var_8[0]["position"];
    }

    playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var_07);

    switch (var_12) {
      case 0:
        playLoopSound(var_07, "frag_grenade_explode");
        break;
      case 3:
        playLoopSound(var_07, "cluster_explode_end");
        break;
      default:
        playLoopSound(var_07, "cluster_explode_mid");
    }

    wait(var_1[var_12]);
  }
}

deathdelaycleanup(var_00, var_01) {
  self endon("death");
  var_00 waittill("death");
  wait(var_01);
  self delete();
}

ownerdisconnectcleanup(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self delete();
}

semtexused(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  if(!issubstr(var_0.weapon_name, "semtex") && var_0.weapon_name != "iw6_mk32_mp") {
    return;
  }
  var_0.originalowner = self;
  var_00 waittill("missile_stuck", var_01);
  var_00 thread grenade_earthquake();
  var_00 explosivehandlemovers(undefined);
}

remove_attachment(var_00, var_01, var_02) {
  if(!isDefined(var_00) && !isDefined(var_01)) {
    return;
  }
  var_03 = [];
  var_04 = undefined;
  var_05 = undefined;

  if(isDefined(var_02)) {
    var_3[var_3.size] = var_02;
  } else {
    var_03 = var_01 getweaponslistall();
  }

  foreach(var_07 in var_03) {
    if(var_01 has_attachment(var_07, var_00)) {
      var_08 = scripts\cp\utility::getrawbaseweaponname(var_07);
      var_09 = getweaponbasename(var_07);
      var_01 giveuponsuppressiontime(var_07);
      var_10 = getweaponattachments(var_07);

      foreach(var_12 in var_10) {
        if(issubstr(var_12, var_00)) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func)) {
        var_05 = var_01[[level.build_weapon_name_func]](var_09, undefined, var_10);
      }

      if(isDefined(var_05)) {
        var_03 = self getweaponslistprimaries();

        foreach(var_02 in var_03) {
          if(issubstr(var_02, var_05)) {
            if(scripts\cp\utility::isaltmodeweapon(var_02)) {
              var_09 = getweaponbasename(var_02);

              if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_09)) {
                var_05 = "alt_" + var_05;
                break;
              }
            }
          }
        }

        var_01 scripts\cp\utility::_giveweapon(var_05, -1, -1, 1);
        var_01 switchtoweapon(var_05);
      }
    }
  }
}

has_attachment(var_00, var_01) {
  var_02 = strtok(var_00, "+");

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    if(var_2[var_03] == var_01) {
      return 1;
    }

    if(issubstr(var_2[var_03], var_01)) {
      return 1;
    }
  }

  return 0;
}

getattachmentlist() {
  var_00 = [];
  var_01 = ["mp\attachmentTable.csv", "cp\zombies\zombie_attachmenttable.csv"];

  foreach(var_03 in var_01) {
    var_04 = 0;

    for(var_05 = tablelookup(var_03, 0, var_04, 5); var_05 != ""; var_05 = tablelookup(var_03, 0, var_04, 5)) {
      if(!scripts\engine\utility::array_contains(var_00, var_05)) {
        var_0[var_0.size] = var_05;
      }

      var_4++;
    }
  }

  return var_00;
}

getarkattachmentlist() {
  var_00 = [];
  var_01 = 0;

  for(var_02 = tablelookup("cp\zombies\zombie_attachmenttable.csv", 0, var_01, 5); var_02 != ""; var_02 = tablelookup("cp\zombies\zombie_attachmenttable.csv", 0, var_01, 5)) {
    if(!scripts\engine\utility::array_contains(var_00, var_02)) {
      var_0[var_0.size] = var_02;
    }

    var_1++;
  }

  return var_00;
}

has_weapon_variation(var_00) {
  var_01 = self getweaponslistall();

  foreach(var_03 in var_01) {
    var_04 = scripts\cp\utility::getrawbaseweaponname(var_00);
    var_05 = scripts\cp\utility::getrawbaseweaponname(var_03);

    if(var_04 == var_05) {
      return 1;
    }
  }

  return 0;
}

create_attachment_variant_list(var_00, var_01, var_02) {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];

  foreach(var_04 in var_00) {
    var_05 = tablelookup(var_01, 4, var_04, 5);

    if(var_02 == "zombie") {
      if(!isDefined(var_05) || var_05 == "") {
        var_05 = tablelookup("cp\zombies\zombie_attachmenttable.csv", 4, var_04, 5);
      }
    }

    if(var_04 == var_05) {
      continue;
    }
    level.attachmentmap_uniquetobase[var_04] = var_05;
    var_06 = tablelookup("mp\attachmenttable.csv", 4, var_04, 13);

    if(var_06 != "") {
      level.attachmentmap_uniquetoextra[var_04] = var_06;
      level.attachmentextralist[var_06] = 1;
    }
  }
}

buildattachmentmaps() {
  var_00 = ["mp\attachmentTable.csv", "cp\zombies\zombie_attachmenttable.csv"];
  var_01 = ["mp\attachmentmap.csv", "cp\zombies\zombie_attachmentmap.csv"];
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.attachmentextralist = [];
  level.attachmentmap_attachtoperk = [];
  level.attachmentmap_conflicts = [];
  level.attachmentmap_basetounique = [];

  foreach(var_03 in var_00) {
    var_04 = getattachmentlistuniquenames(var_03);

    foreach(var_06 in var_04) {
      var_07 = tablelookup(var_03, 4, var_06, 5);

      if(var_06 != var_07) {
        level.attachmentmap_uniquetobase[var_06] = var_07;
      }

      var_08 = tablelookup(var_03, 4, var_06, 13);

      if(var_08 != "") {
        level.attachmentmap_uniquetoextra[var_06] = var_08;
        level.attachmentextralist[var_08] = 1;
      }
    }

    foreach(var_11 in var_01) {
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

      foreach(var_25 in var_04) {
        var_26 = tablelookup(var_03, 4, var_25, 12);

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

create_zombie_base_to_unique_map(var_00, var_01, var_02, var_03) {
  if(var_00 == "zombie") {
    foreach(var_05 in var_01) {
      foreach(var_09, var_07 in var_02) {
        var_08 = tablelookup(var_03, 0, var_05, var_07);

        if(var_08 == "") {
          continue;
        }
        if(!isDefined(level.attachmentmap_basetounique[var_05])) {
          level.attachmentmap_basetounique[var_05] = [];
        }

        if(var_08 == "none") {
          level.attachmentmap_basetounique[var_05][var_09] = undefined;
          continue;
        }

        level.attachmentmap_basetounique[var_05][var_09] = var_08;
      }
    }
  }
}

getattachmentlistuniquenames(var_00) {
  var_01 = getdvar("g_gametype");
  var_02 = [];
  var_03 = 0;

  for(var_04 = tablelookup(var_00, 0, var_03, 4); var_04 != ""; var_04 = tablelookup(var_00, 0, var_03, 4)) {
    var_2[var_2.size] = var_04;
    var_3++;
  }

  return var_02;
}

grenade_earthquake(var_00) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_01 = undefined;

  if(!isDefined(var_00) || var_00) {
    self waittill("explode", var_01);
  } else {
    var_01 = self.origin;
  }

  playrumbleonentity("grenade_rumble", var_01);
  earthquake(0.5, 0.75, var_01, 800);

  foreach(var_03 in level.players) {
    if(var_03 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distancesquared(var_01, var_3.origin) > 360000) {
      continue;
    }
    if(var_03 damageconetrace(var_01)) {
      var_03 thread dirteffect(var_01);
    }

    var_03 setclientomnvar("ui_hud_shake", 1);
  }
}

c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_00);
  playrumbleonentity("grenade_rumble", var_00);
  earthquake(0.4, 0.75, var_00, 512);

  foreach(var_02 in level.players) {
    if(var_02 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distance(var_00, var_2.origin) > 512) {
      continue;
    }
    if(var_02 damageconetrace(var_00)) {
      var_02 thread dirteffect(var_00);
    }

    var_02 setclientomnvar("ui_hud_shake", 1);
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

dirteffect(var_00) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp\utility::isreallyalive(self)) {
    return;
  }
  var_01 = vectornormalize(anglesToForward(self.angles));
  var_02 = vectornormalize(anglestoright(self.angles));
  var_03 = vectornormalize(var_00 - self.origin);
  var_04 = vectordot(var_03, var_01);
  var_05 = vectordot(var_03, var_02);
  var_06 = ["death", "damage"];

  if(var_04 > 0 && var_04 > 0.5 && self getcurrentweapon() != "iw6_riotshield_mp") {
    scripts\engine\utility::waittill_any_in_array_or_timeout(var_06, 2.0);
  } else if(abs(var_04) < 0.866) {
    if(var_05 > 0) {
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_06, 2.0);
    } else {
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_06, 2.0);
    }
  }
}

shellshockondamage(var_00, var_01) {
  if(isflashbanged()) {
    return;
  }
  if(var_00 == "MOD_EXPLOSIVE" || var_00 == "MOD_GRENADE" || var_00 == "MOD_GRENADE_SPLASH" || var_00 == "MOD_PROJECTILE" || var_00 == "MOD_PROJECTILE_SPLASH") {
    if(var_01 > 10) {
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
    self waittill("grenade_fire", var_00, var_01, var_02);

    if(isDefined(self.throwinggrenade) && var_01 != self.throwinggrenade) {
      continue;
    }
    if(isDefined(var_00)) {
      if(!isDefined(var_0.weapon_name)) {
        var_0.weapon_name = var_01;
      }

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.team)) {
        var_0.team = self.team;
      }

      if(!isDefined(var_0.ticks) && isDefined(self.throwinggrenade)) {
        var_0.ticks = scripts\cp\utility::roundup(4 * var_02);
      }
    }

    if(!scripts\cp\utility::isreallyalive(self) && !isDefined(self.throwndyinggrenade)) {
      self notify("grenade_fire_dead", var_00, var_01);
      self.throwndyinggrenade = 1;
    }

    return var_00;
  }
}

can_use_attachment(var_00, var_01) {
  if(isDefined(var_01)) {
    var_02 = var_01;
  } else {
    var_02 = self getcurrentweapon();
  }

  var_03 = getweaponbasename(var_02);
  var_04 = scripts\cp\utility::coop_getweaponclass(var_03);
  var_05 = get_possible_attachments_by_weaponclass(var_04, var_03, var_00);

  if(!var_05) {
    return 0;
  }

  return 1;
}

add_attachment_to_weapon(var_00, var_01, var_02, var_03) {
  if(isDefined(var_01)) {
    var_04 = var_01;
  } else {
    var_04 = scripts\cp\utility::getvalidtakeweapon();
  }

  var_05 = getweaponbasename(var_04);
  var_06 = 0;
  var_07 = getweaponattachments(var_04);
  var_08 = scripts\cp\utility::getcurrentcamoname(var_04);
  var_09 = return_weapon_name_with_like_attachments(var_04, var_00, var_07, undefined, var_08);

  if(!isDefined(var_09) || isDefined(var_09) && var_09 == "none") {
    return 0;
  }

  var_10 = scripts\cp\utility::isaltmodeweapon(var_01);

  if(scripts\cp\utility::weaponhasattachment(var_09, "xmags")) {
    var_06 = 1;
  }

  if(isDefined(var_00)) {
    if(!issubstr(var_00, "pap")) {
      var_11 = self getweaponammoclip(var_04);
      var_12 = self getweaponammostock(var_04);

      if(issubstr(var_09, "akimbo")) {
        var_13 = self getweaponammoclip(var_04, "left");
      } else {
        var_13 = undefined;
      }

      self giveuponsuppressiontime(var_04);
      scripts\cp\utility::_giveweapon(var_09, undefined, undefined, 1);

      if(scripts\cp\utility::weaponhasattachment(var_09, "xmags") && !var_06) {
        var_11 = weaponclipsize(var_09);
      }

      self setweaponammoclip(var_09, var_11);
      self setweaponammostock(var_09, var_12);

      if(isDefined(var_13)) {
        self setweaponammoclip(var_09, var_13, "left");
      }
    } else {
      if(issubstr(var_09, "katana") || issubstr(var_09, "nunchucks")) {}

      self giveuponsuppressiontime(var_04);
      scripts\cp\utility::_giveweapon(var_09, undefined, undefined, 0);
      self givemaxammo(var_09);
    }
  }

  self playlocalsound("weap_raise_large_plr");
  var_14 = self getweaponslistprimaries();

  foreach(var_01 in var_14) {
    if(issubstr(var_01, var_09)) {
      if(scripts\cp\utility::isaltmodeweapon(var_01)) {
        var_16 = getweaponbasename(var_01);

        if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_16) || var_10) {
          var_09 = "alt_" + var_09;
          break;
        }
      }
    }
  }

  if(scripts\engine\utility::is_true(var_03)) {
    return 1;
  }

  if(scripts\engine\utility::is_true(var_02)) {
    self switchtoweaponimmediate(var_09);
  } else {
    self switchtoweapon(var_09);
  }

  return 1;
}

isforgefreezeweapon(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  var_01 = getweaponbasename(var_00);

  if(isDefined(var_01)) {
    if(var_01 == "iw7_forgefreeze_zm" || var_01 == "iw7_forgefreeze_zm_pap1" || var_01 == "iw7_forgefreeze_zm_pap2" || var_01 == "zfreeze_semtex_mp") {
      if(scripts\cp\utility::isaltmodeweapon(var_00)) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

isaltforgefreezeweapon(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  var_01 = getweaponbasename(var_00);

  if(isDefined(var_01)) {
    if(var_01 == "iw7_forgefreeze_zm" || var_01 == "iw7_forgefreeze_zm_pap1" || var_01 == "iw7_forgefreeze_zm_pap2" || var_01 == "zfreeze_semtex_mp") {
      if(scripts\cp\utility::isaltmodeweapon(var_00)) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

issteeldragon(var_00) {
  var_01 = getweaponbasename(var_00);

  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01 == "iw7_steeldragon_zm";
}

is_perk_attachment(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(var_00 == "doubletap") {
    return 1;
  }

  return 0;
}

is_arcane_attachment(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(issubstr(var_00, "ark")) {
    return 1;
  }

  if(issubstr(var_00, "arcane")) {
    return 1;
  }

  return 0;
}

is_mod_attachment(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(issubstr(var_00, "mod")) {
    return 1;
  }

  return 0;
}

is_default_attachment(var_00, var_01) {
  var_02 = scripts\cp\utility::weaponattachdefaultmap(var_01);

  if(!isDefined(var_02) || var_2.size < 1) {
    return 0;
  }

  foreach(var_04 in var_02) {
    if(var_00 == var_04) {
      return 1;
    }
  }

  return 0;
}

is_pap_attachment(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(issubstr(var_00, "pap")) {
    return 1;
  }

  return 0;
}

get_possible_attachments_by_weaponclass(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(!isDefined(var_01)) {
    return 0;
  }

  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = [];
  var_04 = scripts\cp\utility::getbaseweaponname(var_01);

  if(isDefined(level.attachmentmap_basetounique[var_04])) {
    if(isDefined(level.attachmentmap_basetounique[var_04][var_02])) {
      if(level.attachmentmap_basetounique[var_04][var_02] != "none") {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_00])) {
    if(isDefined(level.attachmentmap_basetounique[var_00][var_02])) {
      if(level.attachmentmap_basetounique[var_00][var_02] != "none") {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_04])) {
    var_05 = getarraykeys(level.attachmentmap_basetounique[var_04]);

    foreach(var_07 in var_05) {
      if(level.attachmentmap_basetounique[var_04][var_07] == var_02) {
        if(level.attachmentmap_basetounique[var_04][var_07] != "none") {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_00])) {
    var_05 = getarraykeys(level.attachmentmap_basetounique[var_00]);

    foreach(var_07 in var_05) {
      if(level.attachmentmap_basetounique[var_00][var_07] == var_02) {
        if(level.attachmentmap_basetounique[var_00][var_07] != "none") {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  return 0;
}

return_weapon_name_with_like_attachments(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_00)) {
    var_05 = var_00;
  } else {
    var_05 = self getcurrentweapon();
  }

  var_06 = getweaponbasename(var_05);
  var_07 = scripts\cp\utility::get_weapon_variant_id(self, var_05);
  var_08 = 0;
  var_09 = 0;
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
  var_27 = scripts\cp\utility::coop_getweaponclass(var_06);

  if(scripts\cp\utility::weaponhasattachment(var_05, "xmags")) {
    var_09 = 1;
  }

  var_28 = get_possible_attachments_by_weaponclass(var_27, var_06, var_01);

  if(!var_28 && isDefined(var_01)) {
    if(!scripts\engine\utility::is_true(var_03)) {
      scripts\cp\utility::setlowermessage("cant_attach", &"COOP_PILLAGE_CANT_USE", 3);
    }

    return undefined;
  }

  if(!isDefined(var_02)) {
    var_02 = getweaponattachments(var_05);
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat")) {
    if(get_possible_attachments_by_weaponclass(var_27, var_06, "doubletap")) {
      var_2[var_2.size] = "doubletap";
    }
  }

  if(isDefined(var_01)) {
    if(weaponclass(var_00) == "spread") {
      if(issubstr(var_01, "arkyellow")) {
        foreach(var_30 in var_02) {
          if(issubstr(var_30, "smart")) {
            var_02 = scripts\engine\utility::array_remove(var_02, var_30);
          }
        }
      }
    }
  }

  var_02 = scripts\engine\utility::array_remove_duplicates(var_02);
  var_02 = scripts\engine\utility::array_removeundefined(var_02);

  if(var_2.size > 0 && var_2.size <= var_26) {
    foreach(var_33 in var_02) {
      if(is_pap_attachment(var_33)) {
        if(var_17.size < var_18) {
          var_17[var_17.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_arcane_attachment(var_33)) {
        if(var_23.size < var_24) {
          var_23[var_23.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_mod_attachment(var_33)) {
        if(var_19.size < var_20) {
          var_19[var_19.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_default_attachment(var_33, scripts\cp\utility::getweaponrootname(var_06))) {
        if(var_21.size < var_22) {
          var_21[var_21.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_perk_attachment(var_33)) {
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

  if(isDefined(var_01)) {
    var_35 = scripts\cp\utility::attachmentmap_tobase(var_01);

    if(isDefined(var_35) && var_35 != "none") {
      for(var_36 = 0; var_36 < var_25.size; var_36++) {
        var_37 = scripts\cp\utility::attachmentmap_tobase(var_25[var_36]);

        if(var_37 == var_35) {
          var_25[var_36] = var_01;
          var_08 = 1;
          break;
        }
      }
    }

    var_38 = scripts\cp\utility::getattachmenttype(var_01);

    if(isDefined(var_38) && var_38 != "none") {
      if(!var_08) {
        if(is_pap_attachment(var_01)) {
          if(var_17.size < var_18) {
            var_17[var_17.size] = var_01;
            var_25[var_25.size] = var_01;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_17[var_17.size] = var_01;
                var_25[var_36] = var_01;
                var_08 = 1;
                break;
              }
            }
          }
        } else if(is_arcane_attachment(var_01)) {
          if(var_23.size < var_24) {
            var_23[var_23.size] = var_01;
            var_25[var_25.size] = var_01;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_23[var_15.size] = var_01;
                var_25[var_36] = var_01;
                var_08 = 1;
                break;
              }
            }
          }
        } else if(is_perk_attachment(var_01)) {
          if(var_15.size < var_16) {
            var_15[var_15.size] = var_01;
            var_25[var_25.size] = var_01;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_15[var_15.size] = var_01;
                var_25[var_36] = var_01;
                var_08 = 1;
                break;
              }
            }
          }
        } else if(var_13.size < var_14) {
          var_13[var_13.size] = var_01;
          var_25[var_25.size] = var_01;
        } else {
          for(var_36 = 0; var_36 < var_25.size; var_36++) {
            var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

            if(var_39 == var_38) {
              var_13[var_13.size] = var_01;
              var_25[var_36] = var_01;
              var_08 = 1;
              break;
            }
          }

          if(!var_08) {
            return undefined;
          }
        }
      } else if(is_perk_attachment(var_01)) {
        var_17[var_17.size] = var_01;
        var_25[var_25.size] = var_01;
      } else if(is_pap_attachment(var_01)) {
        var_15[var_15.size] = var_01;
        var_25[var_25.size] = var_01;
      } else if(is_arcane_attachment(var_01)) {
        var_23[var_23.size] = var_01;
        var_25[var_25.size] = var_01;
      } else {
        var_13[var_13.size] = var_01;
        var_25[var_25.size] = var_01;
      }
    } else if(isDefined(var_01)) {
      if(is_perk_attachment(var_01)) {
        var_15[var_15.size] = var_01;
        var_25[var_25.size] = var_01;
      } else if(is_pap_attachment(var_01)) {
        var_17[var_17.size] = var_01;
        var_25[var_25.size] = var_01;
      } else if(is_arcane_attachment(var_01)) {
        var_23[var_23.size] = var_01;
        var_25[var_25.size] = var_01;
      } else {
        var_13[var_13.size] = var_01;
        var_25[var_25.size] = var_01;
      }
    }
  }

  var_40 = scripts\cp\utility::getweaponrootname(var_06);
  var_41 = isDefined(self.weapon_build_models[scripts\cp\utility::getrawbaseweaponname(var_05)]);

  if(!isDefined(var_04) && var_41) {
    var_10 = scripts\cp\utility::getweaponcamo(var_40);
  } else {
    var_10 = var_04;
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

  var_51 = scripts\cp\utility::mpbuildweaponname(var_40, var_25, var_10, var_11, var_07, self getentitynumber(), self.clientid, var_45, var_12);

  if(isDefined(var_51)) {
    return var_51;
  } else {
    return var_05;
  }
}

getattachmenttypeslist(var_00, var_01) {
  var_02 = scripts\cp\utility::getweaponattachmentarrayfromstats(var_00);
  var_03 = [];

  foreach(var_05 in var_02) {
    var_06 = scripts\cp\utility::getattachmenttype(var_05);

    if(isDefined(var_01) && scripts\cp\utility::listhasattachment(var_01, var_05)) {
      continue;
    }
    if(!isDefined(var_3[var_06])) {
      var_3[var_06] = [];
    }

    var_07 = var_3[var_06];
    var_7[var_7.size] = var_05;
    var_3[var_06] = var_07;
  }

  return var_03;
}

getattachmentlistbasenames() {
  var_00 = [];
  var_01 = ["mp\attachmentTable.csv", "cp\zombies\zombie_attachmenttable.csv"];

  foreach(var_03 in var_01) {
    var_04 = 0;

    for(var_05 = tablelookup(var_03, 0, var_04, 5); var_05 != ""; var_05 = tablelookup(var_03, 0, var_04, 5)) {
      var_06 = tablelookup(var_03, 0, var_04, 2);

      if(var_06 != "none" && !scripts\engine\utility::array_contains(var_00, var_05)) {
        var_0[var_0.size] = var_05;
      }

      var_4++;
    }
  }

  return var_00;
}

getweaponattachmentarray(var_00) {
  var_01 = [];
  var_02 = scripts\cp\utility::getbaseweaponname(var_00);
  var_03 = scripts\cp\utility::coop_getweaponclass(var_00);

  if(isDefined(level.attachmentmap_basetounique[var_02])) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.attachmentmap_basetounique[var_02]);
  }

  if(isDefined(level.attachmentmap_basetounique[var_03])) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.attachmentmap_basetounique[var_03]);
  }

  return var_01;
}

isvalidzombieweapon(var_00) {
  if(!isDefined(level.weaponrefs)) {
    level.weaponrefs = [];

    foreach(var_02 in level.weaponlist) {
      level.weaponrefs[var_02] = 1;
    }
  }

  if(isDefined(level.weaponrefs[var_00])) {
    return 1;
  }

  return 0;
}

setweaponlaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var_00 = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(var_00);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change", var_00);

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      disableweaponlaser();
    }
  }
}

setweaponlaser_waitforlaserweapon(var_00) {
  for(;;) {
    var_00 = getweaponbasename(var_00);

    if(isDefined(var_00) && (var_00 == "iw6_kac_mp" || var_00 == "iw6_arx160_mp")) {
      break;
    }
    self waittill("weapon_change", var_00);
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

setweaponlaser_monitorweaponswitchstart(var_00) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(var_00);
  }
}

setweaponlaser_onweaponswitchstart(var_00) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait(var_00);
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

ondetonateexplosive(var_00) {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");

  if(isDefined(var_00)) {
    self.owner notify(var_00, 1);
  } else {
    self.owner notify("powers_c4_used", 1);
  }

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

cleanupequipment(var_00, var_01, var_02, var_03) {
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

  if(isDefined(var_00)) {
    level.mines[var_00] = undefined;
  }

  if(isDefined(var_01)) {
    var_01 delete();
  }

  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(var_03)) {
    var_03 delete();
  }
}

monitordamage(var_00, var_01, var_02, var_03, var_04, var_05) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = var_00;
  self.damagetaken = 0;

  if(!isDefined(var_04)) {
    var_04 = 0;
  }

  for(var_06 = 1; var_06; var_06 = monitordamageoneshot(var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_01, var_02, var_03, var_04)) {
    self waittill("damage", var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(var_05) {
      self playrumbleonentity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_17 = "";

      if(isDefined(var_08) && isplayer(var_08)) {
        var_17 = var_08 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_17])) {
        self.attackers[var_17] = self.attackers[var_17] + var_07;
      } else {
        self.attackers[var_17] = var_07;
      }
    }
  }
}

monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(var_01) && !scripts\cp\utility::isgameparticipant(var_01) && !isDefined(var_1.allowmonitoreddamage)) {
    return 1;
  }

  return 1;
}

explosivehandlemovers(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.linkparent = var_00;
  var_2.deathoverridecallback = ::movingplatformdetonate;
  var_2.endonstring = "death";

  if(!isDefined(var_01) || !var_01) {
    var_2.invalidparentoverridecallback = scripts\cp\cp_movers::moving_platform_empty_func;
  }

  thread scripts\cp\cp_movers::handle_moving_platforms(var_02);
}

movingplatformdetonate(var_00) {
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

equipmentwatchuse(var_00, var_01) {
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

  self.trigger scripts\cp\utility::setselfusable(var_00);
  self.trigger thread scripts\cp\utility::notusableforjoiningplayers(var_00);

  if(isDefined(var_01) && var_01) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", var_00);
    var_00 playlocalsound("scavenger_pack_pickup");
    var_00 notify("scavenged_ammo", self.weapon_name);
    var_00 setweaponammostock(self.weapon_name, var_00 getweaponammostock(self.weapon_name) + 1);
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
    } else
      return;

    wait 0.05;
  }
}

deleteexplosive(var_00) {
  if(isDefined(self)) {
    var_01 = self getentitynumber();
    var_02 = self.killcament;
    var_03 = self.trigger;
    var_04 = self.sensor;
    cleanupequipment(var_01, var_02, var_03, var_04);
    self notify("deleted_equipment");
    self delete();
  }
}

ontacticalequipmentplanted(var_00) {
  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

    if(self.plantedtacticalequip.size >= level.maxperplayerexplosives) {
      self.plantedtacticalequip[0] notify("detonateExplosive");
    }
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = var_00;
  var_01 = var_00 getentitynumber();
  level.mines[var_01] = var_00;
  level notify("mine_planted");
}

equipmentdeathvfx(var_00) {
  var_01 = spawnfx(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  triggerfx(var_01);

  if(!isDefined(var_00) || var_00 == 0) {
    self playSound("sentry_explode");
  }

  var_01 thread scripts\cp\utility::delayentdelete(1);
}

equipmentdeletevfx() {
  var_00 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), self.origin);
  triggerfx(var_00);
  self playSound("mp_killstreak_disappear");
  var_00 thread scripts\cp\utility::delayentdelete(1);
}

monitordisownedequipment(var_00, var_01) {
  level endon("game_ended");
  var_01 endon("death");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  var_01 deleteexplosive();
}

isprimaryweapon(var_00) {
  if(var_00 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_00) != "primary") {
    return 0;
  }

  switch (weaponclass(var_00)) {
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
  var_00 = anglestoup(self.angles);
  return 10 * var_00;
}

isknifeonly(var_00) {
  return issubstr(var_00, "knife");
}

is_incompatible_weapon(var_00) {
  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(scripts\engine\utility::array_contains(level.ammoincompatibleweaponslist, var_00)) {
      return 1;
    }
  }

  return 0;
}

isbulletweapon(var_00) {
  if(var_00 == "none" || scripts\cp\utility::isriotshield(var_00) || isknifeonly(var_00)) {
    return 0;
  }

  switch (weaponclass(var_00)) {
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

is_explosive_kill(var_00) {
  switch (var_00) {
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

is_arc_death(var_00, var_01, var_02, var_03, var_04, var_05) {
  return var_02 && var_03 && var_04 && !var_05 && isDefined(var_1.stun_struct) && isDefined(var_1.stun_struct.attack_bolt) && var_00 == var_1.stun_struct.attack_bolt;
}

is_holding_pistol(var_00) {
  var_01 = var_00 getcurrentprimaryweapon();

  if(scripts\cp\utility::coop_getweaponclass(var_01) == "weapon_pistol") {
    return 1;
  } else {
    return 0;
  }
}

get_weapon_level(var_00) {
  if(!isplayer(self)) {
    return int(1);
  }

  if(isDefined(self.pap[var_00])) {
    return self.pap[var_00].lvl;
  }

  var_01 = scripts\cp\utility::getrawbaseweaponname(var_00);

  if(isDefined(self.pap[var_01])) {
    return self.pap[var_01].lvl;
  }

  return int(1);
}

can_upgrade(var_00, var_01) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(level.max_pap_func)) {
    return [[level.max_pap_func]](var_00, var_01);
  }

  if(isDefined(var_00)) {
    var_02 = scripts\cp\utility::getrawbaseweaponname(var_00);
  } else {
    return 0;
  }

  if(!isDefined(var_02)) {
    return 0;
  }

  if(!isDefined(level.pap[var_02])) {
    var_03 = getsubstr(var_02, 0, var_2.size - 1);

    if(!isDefined(level.pap[var_03])) {
      return 0;
    }
  }

  if(isDefined(self.ephemeralweapon) && getweaponbasename(self.ephemeralweapon) == getweaponbasename(var_00)) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_00)])) {
    return 1;
  }

  if(var_02 == "dischord" || var_02 == "facemelter" || var_02 == "headcutter" || var_02 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      if(scripts\engine\utility::is_true(var_01)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(self.pap[var_02]) && self.pap[var_02].lvl == 2)
      return 0;
  }

  if(scripts\engine\utility::is_true(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return 1;
  }

  if(scripts\engine\utility::is_true(self.has_zis_soul_key) && !scripts\engine\utility::is_true(level.no_auto_pap_upgrade) || scripts\engine\utility::is_true(level.placed_alien_fuses)) {
    if(isDefined(self.pap[var_02]) && self.pap[var_02].lvl >= 3) {
      return 0;
    } else {
      return 1;
    }
  }

  if(scripts\engine\utility::is_true(var_01) && isDefined(self.pap[var_02]) && self.pap[var_02].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var_02]) && self.pap[var_02].lvl >= level.pap_max) {
    return 0;
  } else {
    return 1;
  }
}

get_pap_camo(var_00, var_01, var_02) {
  var_03 = undefined;

  if(isDefined(var_01)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_01)) {
      var_03 = undefined;
    } else if(isDefined(level.pap_1_camo) && isDefined(var_00) && var_00 == 2) {
      var_03 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(var_00) && var_00 == 3) {
      var_03 = level.pap_2_camo;
    }

    switch (var_01) {
      case "dischord":
        var_02 = "iw7_dischord_zm_pap1";
        var_03 = "camo20";
        break;
      case "facemelter":
        var_02 = "iw7_facemelter_zm_pap1";
        var_03 = "camo22";
        break;
      case "headcutter":
        var_02 = "iw7_headcutter_zm_pap1";
        var_03 = "camo21";
        break;
      case "forgefreeze":
        if(var_00 == 2) {
          var_02 = "iw7_forgefreeze_zm_pap1";
        } else if(var_00 == 3) {
          var_02 = "iw7_forgefreeze_zm_pap2";
        }

        var_04 = 1;
        break;
      case "axe":
        if(var_00 == 2) {
          var_02 = "iw7_axe_zm_pap1";
        } else if(var_00 == 3) {
          var_02 = "iw7_axe_zm_pap2";
        }

        var_04 = 1;
        break;
      case "shredder":
        var_02 = "iw7_shredder_zm_pap1";
        var_03 = "camo23";
        break;
    }
  }

  return var_03;
}

validate_current_weapon(var_00, var_01, var_02) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_02)])) {
    var_02 = level.weapon_upgrade_path[getweaponbasename(var_02)];
  } else if(isDefined(var_01)) {
    switch (var_01) {
      case "two":
        if(var_00 == 2) {
          var_02 = "iw7_two_headed_axe_mp";
        } else if(var_00 == 3) {
          var_02 = "iw7_two_headed_axe_mp";
        }

        break;
      case "golf":
        if(var_00 == 2) {
          var_02 = "iw7_golf_club_mp";
        } else if(var_00 == 3) {
          var_02 = "iw7_golf_club_mp";
        }

        break;
      case "machete":
        if(var_00 == 2) {
          var_02 = "iw7_machete_mp";
        } else if(var_00 == 3) {
          var_02 = "iw7_machete_mp";
        }

        break;
      case "spiked":
        if(var_00 == 2) {
          var_02 = "iw7_spiked_bat_mp";
        } else if(var_00 == 3) {
          var_02 = "iw7_spiked_bat_mp";
        }

        break;
      case "axe":
        if(var_00 == 2) {
          var_02 = "iw7_axe_zm_pap1";
        } else if(var_00 == 3) {
          var_02 = "iw7_axe_zm_pap2";
        }

        break;
      case "katana":
        if(var_00 == 2) {
          var_02 = "iw7_katana_zm_pap1";
        } else if(var_00 == 3) {
          var_02 = "iw7_katana_zm_pap2";
        }

        break;
      case "nunchucks":
        if(var_00 == 2) {
          var_02 = "iw7_nunchucks_zm_pap1";
        } else if(var_00 == 3) {
          var_02 = "iw7_nunchucks_zm_pap2";
        }

        break;
      default:
        return var_02;
    }
  }

  return var_02;
}

watchplayermelee() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("melee_fired", var_00);

    if(self.meleekill == 0) {
      if(var_00 == "iw7_fists_zm_crane" || var_00 == "iw7_fists_zm_dragon" || var_00 == "iw7_fists_zm_snake" || var_00 == "iw7_fists_zm_tiger") {
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
      } else
        thread scripts\cp\cp_vo::try_to_play_vo("melee_miss", "zmb_comment_vo", "high", 1, 0, 0, 1, 20);

      continue;
    }

    if(issubstr(var_00, "katana") && self.vo_prefix == "p5_") {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special_katana", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if((issubstr(var_00, "golf") || issubstr(var_00, "machete") || issubstr(var_00, "spiked_bat") || issubstr(var_00, "two_headed_axe")) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if(issubstr(var_00, "iw7_knife") && scripts\cp\utility::is_melee_weapon(var_00) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_fatal", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self.meleekill = 0;
      continue;
    }

    if((var_00 == "iw7_axe_zm" || var_00 == "iw7_axe_zm_pap1" || var_00 == "iw7_axe_zm_pap2") && scripts\cp\utility::is_melee_weapon(var_00) && self.meleekill == 1) {
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
    var_00 = self getcurrentweapon();

    if(!isDefined(var_00) || var_00 == "none") {
      continue;
    }
    self waittill("fired", var_00);
    var_00 = self getcurrentweapon();
    var_01 = self getammocount(var_00);

    if(scripts\cp\utility::is_melee_weapon(var_00) || issubstr(var_00, "fists") || issubstr(var_00, "heart")) {
      continue;
    }
    if(var_01 <= 5 && var_01 > 0 && self getweaponammostock(var_00) == 0 || self getweaponammostock(var_00) > 0 && var_01 / self getweaponammostock(var_00) < 0.1) {
      scripts\cp\cp_vo::try_to_play_vo("nag_low_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);
      continue;
    }

    if(var_01 == 0 && (var_00 != "iw7_cpbasketball_mp" && var_00 != "none")) {
      scripts\cp\cp_vo::try_to_play_vo("nag_out_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);
    }
  }
}

watchweaponusage(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_01);
    var_01 = self getcurrentweapon();

    if(!isDefined(var_01) || var_01 == "none") {
      continue;
    }
    if(!scripts\cp\utility::isinventoryprimaryweapon(var_01)) {
      continue;
    }
    if(isDefined(level.updateonusepassivesfunc)) {
      thread[[level.updateonusepassivesfunc]](self, var_01);
    }

    var_02 = gettime();

    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var_03 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_02;

    if(isai(self)) {
      continue;
    }
    var_04 = getweaponbasename(var_01);

    if(!isDefined(self.shotsfiredwithweapon[var_04])) {
      self.shotsfiredwithweapon[var_04] = 1;
    } else {
      self.shotsfiredwithweapon[var_04]++;
    }

    if(!isDefined(self.accuracy_shots_fired)) {
      self.accuracy_shots_fired = 1;
    } else {
      self.accuracy_shots_fired++;
    }

    scripts\cp\cp_persistence::increment_player_career_shots_fired(self);

    if(isDefined(var_04)) {
      if(isDefined(self.hitsthismag[var_04])) {
        thread hitsthismag_update(var_04, var_01);
      }
    }
  }
}

hitsthismag_update(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("updateMagShots_" + var_00);
  self.hitsthismag[var_00]--;
  wait 0.1;
  self notify("shot_missed", var_01);
  self.consecutivehitsperweapon[var_00] = 0;
  self.hitsthismag[var_00] = weaponclipsize(var_01);
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.hitsthismag = [];
  var_00 = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(var_00);

  for(;;) {
    self waittill("weapon_change", var_00);
    var_00 = getweaponbasename(var_00);
    weapontracking_init(var_00);
    hitsthismag_init(var_00);
  }
}

harpoon_impale_additional_func(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!issubstr(var_00, "harpoon")) {
    return;
  } else {
    var_02 startragdoll();
    var_08 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_corpseclipshot"]);
    var_09 = var_03 + var_04 * 4096;
    var_10 = scripts\engine\trace::ray_trace_detail(var_03, var_09, undefined, var_08, undefined, 1);
    var_09 = var_10["position"] - var_04 * 12;
    var_11 = length(var_09 - var_03);
    var_12 = var_11 / 1250;
    var_12 = clamp(var_12, 0.05, 1);
    wait 0.05;
    var_13 = var_04;
    var_14 = anglestoup(var_1.angles);
    var_15 = vectorcross(var_13, var_14);
    var_16 = scripts\engine\utility::spawn_tag_origin(var_03, _axistoangles(var_13, var_15, var_14));
    var_16 moveto(var_09, var_12);
    var_17 = spawnragdollconstraint(var_02, var_05, var_06, var_07);
    var_17.origin = var_16.origin;
    var_17.angles = var_16.angles;
    var_17 linkto(var_16);
    thread play_explosion_post_impale(var_09, var_01);
    thread impale_cleanup(var_02, var_16, var_12 + 0.05, var_17);
  }
}

impale_cleanup(var_00, var_01, var_02, var_03) {
  var_00 scripts\engine\utility::waittill_any_timeout(var_02, "death", "disconnect");
  var_03 delete();
  var_01 delete();
}

play_explosion_post_impale(var_00, var_01) {
  wait 2;
  var_01 radiusdamage(var_00, 500, 1000, 500, var_01, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], var_00);
}

scripted_ability_harpoonv1() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_00);

    if(issubstr(var_00, "harpoon1")) {
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

  for(var_00 = 1; var_00 <= 5; var_0++) {
    self.trigger_alt_mode[var_00] = undefined;
  }

  for(;;) {
    scripts\engine\utility::waittill_any("ads_in");
    scripts\engine\utility::waittill_any("ads_out");
    var_01 = self getplayerangles();
    var_02 = self getEye();
    var_03 = anglesToForward(var_01);
    var_04 = var_02 + var_03 * 2048;
    var_05 = scripts\engine\trace::create_contents(1, 1, 0, 0, 0, 0, 0);
    var_06 = physics_raycast(var_02, var_04, var_05, self, 0, "physicsquery_closest");
    var_07 = var_6[0]["position"];

    if(isDefined(var_07)) {
      if(isDefined(self.zombie_charges)) {
        if(self.zombie_charges <= 5) {
          thread create_trigger_based_on_charges(self.zombie_charges, self, var_07);
        }

        self.zombie_charges++;
      } else {
        self.zombie_charges = 1;
        thread create_trigger_based_on_charges(self.zombie_charges, self, var_07);
      }

      thread charge_watcher(var_07);
    }

    wait 0.8;
  }
}

charge_watcher(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_01 = gettime();

  while(gettime() <= var_01 + 7000) {
    scripts\engine\utility::waitframe();

    if(self getcurrentweaponclipammo() <= 1) {
      continue;
    }
    if(isDefined(self.zombie_charges)) {
      if(self.zombie_charges > 5) {
        foreach(var_03 in self.trigger_alt_mode) {
          if(isDefined(var_03)) {
            var_03 delete();
          }
        }

        self radiusdamage(var_00, 100, 1000, 100, self, "MOD_EXPLOSIVE");
        playFX(level._effect["penetration_railgun_explosion"], var_00);
        self.zombie_charges = 0;
      }
    }
  }

  foreach(var_03 in self.trigger_alt_mode) {
    if(isDefined(var_03)) {
      self radiusdamage(var_3.origin, 100, 1000, 100, self, "MOD_EXPLOSIVE");
      playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      var_03 delete();
    }
  }
}

create_trigger_based_on_charges(var_00, var_01, var_02) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_03 = 0;

  switch (var_00) {
    case 0:
      self.zombie_charges = 1;
    case 1:
      foreach(var_05 in self.trigger_alt_mode) {
        if(isDefined(var_05)) {
          if(var_5.origin == var_02 || distance2dsquared(var_5.origin, var_02) <= 100) {
            var_05 delete();
          }
        }
      }

      var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 50, 25);
      break;
    case 2:
      foreach(var_05 in self.trigger_alt_mode) {
        if(isDefined(var_05)) {
          if(var_5.origin == var_02 || distance2dsquared(var_5.origin, var_02) <= 100) {
            var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 55, 25);
            var_03 = 1;
          }

          if(isDefined(var_1.trigger_alt_mode[var_00]) && var_05 != var_1.trigger_alt_mode[var_00]) {
            var_05 delete();
          }
        }
      }

      if(!var_03) {
        var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 50, 25);
      }

      break;
    case 3:
      foreach(var_05 in self.trigger_alt_mode) {
        if(isDefined(var_05)) {
          if(var_5.origin == var_02 || distance2dsquared(var_5.origin, var_02) <= 100) {
            var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 60, 25);
            var_03 = 1;
          }

          if(isDefined(var_1.trigger_alt_mode[var_00]) && var_05 != var_1.trigger_alt_mode[var_00]) {
            var_05 delete();
          }
        }
      }

      if(!var_03) {
        var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 50, 25);
      }

      break;
    case 4:
      foreach(var_05 in self.trigger_alt_mode) {
        if(isDefined(var_05)) {
          if(var_5.origin == var_02 || distance2dsquared(var_5.origin, var_02) <= 100) {
            var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 65, 25);
            var_03 = 1;
          }

          if(isDefined(var_1.trigger_alt_mode[var_00]) && var_05 != var_1.trigger_alt_mode[var_00]) {
            var_05 delete();
          }
        }
      }

      if(!var_03) {
        var_1.trigger_alt_mode[var_00] = spawn("trigger_radius", var_02, 0, 50, 25);
      }

      break;
    case 5:
      foreach(var_05 in self.trigger_alt_mode) {
        if(isDefined(var_05)) {
          var_01 radiusdamage(var_5.origin, 100, 1000, 100, var_01, "MOD_EXPLOSIVE");
          playFX(level._effect["penetration_railgun_explosion"], var_5.origin);
          var_05 delete();
        }
      }

      break;
    default:
      break;
  }

  if(isDefined(var_1.trigger_alt_mode[var_00])) {
    var_1.trigger_alt_mode[var_00] setModel("prop_mp_super_blackholegun_projectile");
    var_1.trigger_alt_mode[var_00] thread do_damage_when_trigger(var_1.trigger_alt_mode[var_00], var_01);
  }
}

do_damage_when_trigger(var_00, var_01) {
  self endon("death");
  level endon("game_ended");
  var_02 = 0;

  for(;;) {
    var_00 waittill("trigger", var_03);

    if(isDefined(var_3.agent_type) && var_3.agent_type == "generic_zombie" && !isDefined(var_3.flung)) {
      var_01 radiusdamage(var_3.origin, 100, 1000, 100, var_01, "MOD_EXPLOSIVE");
      playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      var_2++;

      if(var_02 >= 5) {
        foreach(var_05 in self.trigger_alt_mode) {
          if(isDefined(var_05)) {
            var_05 delete();
          }
        }

        self.zombie_charges = 0;
        var_01 radiusdamage(var_3.origin, 100, 1000, 100, var_01, "MOD_EXPLOSIVE");
        playFX(level._effect["penetration_railgun_explosion"], var_3.origin);
      }
    }
  }
}

weapontracking_init(var_00) {
  if(!isDefined(var_00) || var_00 == "none") {
    return;
  }
  if(!isDefined(self.shotsfiredwithweapon[var_00])) {
    self.shotsfiredwithweapon[var_00] = 0;
  }

  if(!isDefined(self.shotsontargetwithweapon[var_00])) {
    self.shotsontargetwithweapon[var_00] = 0;
  }

  if(!isDefined(self.headshots[var_00])) {
    self.headshots[var_00] = 0;
  }

  if(!isDefined(self.wavesheldwithweapon[var_00])) {
    self.wavesheldwithweapon[var_00] = 1;
  }

  if(!isDefined(self.downsperweaponlog[var_00])) {
    self.downsperweaponlog[var_00] = 0;
  }

  if(!isDefined(self.killsperweaponlog[var_00])) {
    self.killsperweaponlog[var_00] = 0;
  }
}

hitsthismag_init(var_00) {
  if(!isDefined(var_00) || var_00 == "none") {
    return;
  }
  if(scripts\cp\utility::isinventoryprimaryweapon(var_00) && !isDefined(self.hitsthismag[var_00])) {
    self.hitsthismag[var_00] = weaponclipsize(var_00);
  }
}