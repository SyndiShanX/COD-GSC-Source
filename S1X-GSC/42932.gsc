/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42932.gsc
**************************************/

init() {
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level.maxperplayerexplosives = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
  level.riotshieldxpbullets = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");

  switch (maps\mp\_utility::getintproperty("perk_scavengerMode", 0)) {
    case 1:
      level.scavenger_altmode = 0;
      break;
    case 2:
      level.scavenger_secondary = 0;
      break;
    case 3:
      level.scavenger_altmode = 0;
      level.scavenger_secondary = 0;
      break;
  }

  var_0 = getDvar("g_gametype");
  var_1 = maps\mp\_utility::getattachmentlistbasenames();
  var_1 = common_scripts\utility::alphabetize(var_1);
  var_2 = 150;
  level.weaponlist = [];
  level.weaponattachments = [];

  for(var_3 = 0; var_3 <= var_2; var_3++) {
    var_4 = tablelookup("mp/statstable.csv", 0, var_3, 4);

    if(var_4 == "") {
      continue;
    }
    if(tablelookup("mp/statsTable.csv", 0, var_3, 51) != "") {
      continue;
    }
    if(!issubstr(tablelookup("mp/statsTable.csv", 0, var_3, 2), "weapon_")) {
      continue;
    }
    if(issubstr(var_4, "iw5") || issubstr(var_4, "iw6")) {
      var_5 = maps\mp\_utility::getweaponnametokens(var_4);
      var_4 = var_5[0] + "_" + var_5[1] + "_mp";
      level.weaponlist[level.weaponlist.size] = var_4;
      continue;
    } else {
      level.weaponlist[level.weaponlist.size] = var_4 + "_mp";
    }

    var_6 = maps\mp\_utility::getweaponattachmentarrayfromstats(var_4);
    var_7 = [];

    foreach(var_9 in var_1) {
      if(!isDefined(var_6[var_9])) {
        continue;
      }
      level.weaponlist[level.weaponlist.size] = var_4 + "_" + var_9 + "_mp";
      var_7[var_7.size] = var_9;
    }

    var_11 = [];

    for(var_12 = 0; var_12 < var_7.size - 1; var_12++) {
      var_13 = tablelookuprownum("mp/attachmentCombos.csv", 0, var_7[var_12]);

      for(var_14 = var_12 + 1; var_14 < var_7.size; var_14++) {
        if(tablelookup("mp/attachmentCombos.csv", 0, var_7[var_14], var_13) == "no") {
          continue;
        }
        var_11[var_11.size] = var_7[var_12] + "_" + var_7[var_14];
      }
    }

    foreach(var_16 in var_11) {
      level.weaponlist[level.weaponlist.size] = var_4 + "_" + var_16 + "_mp";
    }
  }

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    foreach(var_19 in level.weaponlist) {
      precacheitem(var_19);
    }
  }

  thread maps\mp\_flashgrenades::main();
  thread maps\mp\_entityheadicons::init();
  thread maps\mp\_empgrenade::init();

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    thread maps\mp\_tridrone::init();
    thread maps\mp\_explosive_gel::init();
    thread maps\mp\_riotshield::init();
  }

  thread maps\mp\_exoknife::init();

  if(!isDefined(level.weapondropfunction)) {
    level.weapondropfunction = ::dropweaponfordeath;
  }

  var_22 = 70;
  level.claymoredetectiondot = cos(var_22);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.75;
  level.claymoredetonateradius = 192;

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    level.minedetectiongraceperiod = 0.3;
    level.minedetectionradius = 100;
    level.minedetectionheight = 20;
    level.minedamageradius = 256;
    level.minedamagemin = 70;
    level.minedamagemax = 210;
    level.minedamagehalfheight = 46;
    level.mineselfdestructtime = 120;
    level.mine_launch = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
    level.mine_spin = loadfx("vfx/dust/bouncing_betty_swirl");
    level.mine_explode = loadfx("vfx/explosion/bouncing_betty_explosion");
    level.mine_beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
    level.mine_beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
    level.empgrenadeexplode = loadfx("vfx/explosion/emp_grenade_mp");
  }

  level._effect["mine_stunned"] = loadfx("vfx/sparks/emp_drone_damage");
  level.delayminetime = 3.0;
  level.sentry_fire = loadfx("fx/muzzleflashes/shotgunflash");
  level.stingerfxid = loadfx("fx/explosions/aerial_explosion_large");
  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.missile_array = [];
  level.inventory_array = [];
  level.mines = [];
  level.trophies = [];

  if(!maps\mp\_utility::invirtuallobby()) {
    if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
      precachemodel("weapon_claymore_bombsquad");
      precachemodel("weapon_c4_bombsquad");
      precachemodel("projectile_m67fraggrenade_bombsquad");
      precachemodel("projectile_semtex_grenade_bombsquad");
      precachemodel("weapon_light_stick_tactical_bombsquad");
      precachemodel("projectile_bouncing_betty_grenade");
      precachemodel("projectile_bouncing_betty_grenade_bombsquad");
      precachemodel("weapon_jammer");
      precachemodel("weapon_jammer_bombsquad");
      precachemodel("weapon_radar");
      precachemodel("weapon_radar_bombsquad");
      precachemodel("mp_trophy_system");
      precachemodel("mp_trophy_system_bombsquad");
      precachemodel("projectile_semtex_grenade");
      precachemodel("npc_variable_grenade_lethal");
      precacheshader("exo_hud_cloak_overlay");
    }

    precachelaser("mp_attachment_lasersight");
    precachelaser("mp_attachment_directhack");
    precachelaser("mp_attachment_lasersight_short");
    level._effect["equipment_explode"] = loadfx("vfx/explosion/sparks_burst_lrg_c");
    level._effect["sniperDustLarge"] = loadfx("vfx/dust/sniper_dust_kickup");
    level._effect["sniperDustLargeSuppress"] = loadfx("vfx/dust/sniper_dust_kickup_accum_suppress");
  }

  level thread onplayerconnect();
  level.c4explodethisframe = 0;
  common_scripts\utility::array_thread(getEntArray("misc_turret", "classname"), ::turret_monitoruse);
}

dumpit() {
  wait 5.0;
}

bombsquadwaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "c4_mp") {
      var_0 thread createbombsquadmodel("weapon_c4_bombsquad", "tag_origin", self);
      continue;
    }

    if(var_2 == "claymore_mp") {
      var_0 thread createbombsquadmodel("weapon_claymore_bombsquad", "tag_origin", self);
      continue;
    }

    if(var_2 == "frag_grenade_mp") {
      var_0 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad", "tag_weapon", self);
      continue;
    }

    if(var_2 == "frag_grenade_short_mp") {
      var_0 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad", "tag_weapon", self);
      continue;
    }

    if(var_2 == "semtex_mp") {
      var_0 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad", "tag_weapon", self);
      continue;
    }

    if(var_2 == "thermobaric_grenade_mp") {
      var_0 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad", "tag_weapon", self);
    }
  }
}

createbombsquadmodel(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 hide();
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  var_3 thread bombsquadvisibilityupdater(var_2);
  var_3 setModel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 setcontents(0);
  self waittill("death");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  var_3 delete();
}

bombsquadvisibilityupdater(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.team;

  foreach(var_3 in level.players) {
    if(level.teambased) {
      if(var_3.team == "spectator") {
        continue;
      }
      if(var_3.team != var_1 && var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
        self showtoplayer(var_3);
      }

      continue;
    }

    if(isDefined(var_0) && var_3 == var_0) {
      continue;
    }
    if(!var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
      continue;
    }
    self showtoplayer(var_3);
  }

  for(;;) {
    level common_scripts\utility::waittill_any("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
    self hide();

    foreach(var_3 in level.players) {
      if(level.teambased) {
        if(var_3.team == "spectator") {
          continue;
        }
        if(var_3.team != var_1 && var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
          self showtoplayer(var_3);
        }

        continue;
      }

      if(isDefined(var_0) && var_3 == var_0) {
        continue;
      }
      if(!var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
        continue;
      }
      self showtoplayer(var_3);
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.hits = 0;
    var_0.issiliding = 0;
    maps\mp\gametypes\_gamelogic::sethasdonecombat(var_0, 0);

    if(!maps\mp\_utility::invirtuallobby()) {
      if(!(isDefined(level.iszombiegame) && level.iszombiegame)) {
        var_0 kc_regweaponforfxremoval("remotemissile_projectile_mp");
      }

      var_0 thread sniperdustwatcher();
    }

    var_0 thread onplayerspawned();
    var_0 thread bombsquadwaiter();
    var_0 thread watchmissileusage();
    var_0 thread update_em1_heat_omnvar();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::waittill_any("spawned_player", "faux_spawn");
    self.currentweaponatspawn = self getcurrentweapon();
    self.empendtime = 0;
    self.concussionendtime = 0;
    self.hits = 0;
    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 0);

    if(!isDefined(self.trackingweaponname)) {
      self.trackingweaponname = "";
      self.trackingweaponname = "none";
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweaponhipfirekills = 0;
      self.trackingweapondeaths = 0;
      self.trackingweaponusetime = 0;
    }

    thread watchslide();
    thread watchweaponusage();
    thread watchgrenadeusage();
    thread watchstingerusage();
    thread watchweaponreload();
    thread watchmineusage();

    if(!(isDefined(level.iszombiegame) && level.iszombiegame) || isagent(self)) {
      thread maps\mp\_riotshield::watchriotshielduse();
    }

    thread stancerecoiladjuster();
    thread maps\mp\perks\_perkfunctions::monitortiuse();
    thread maps\mp\_target_enhancer::target_enhancer_think();
    thread maps\mp\_opticsthermal::opticsthermal_think();
    thread maps\mp\_stock::stock_think();
    thread maps\mp\_lasersight::lasersight_think();
    thread maps\mp\_microdronelauncher::monitor_microdrone_launch();
    thread maps\mp\_exocrossbow::monitor_exocrossbow_launch();
    thread maps\mp\_stingerm7::stingerm7_think();
    thread maps\mp\_trackrounds::trackrounds_think();
    thread maps\mp\_na45::main();
    thread maps\mp\_lsrmissileguidance::monitor_lsr_missile_launch();
    thread maps\mp\_exoknife::exo_knife_think();
    thread maps\mp\_exo_battery::play_insufficient_tactical_energy_sfx();
    thread maps\mp\_exo_battery::play_insufficient_lethal_energy_sfx();
    thread watchgrenadegraceperiod();

    if(!(isDefined(level.iszombiegame) && level.iszombiegame)) {
      thread maps\mp\_tracking_drone::watchtrackingdroneusage();
      thread maps\mp\_explosive_drone::watchexplosivedroneusage();
    }

    if(!maps\mp\_utility::invirtuallobby()) {
      thread watchsentryusage();
    }

    thread watchweaponchange();

    if(isDefined(level.onplayerspawnedweaponsfunc)) {
      self thread[[level.onplayerspawnedweaponsfunc]]();
    }

    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    self.pickedupweaponfrom = [];
    thread updatesavedlastweapon();
    thread monitorsemtex();
    self.currentweaponatspawn = undefined;
    self.trophyremainingammo = undefined;
    thread track_damage_info();

    if(!isDefined(self.spawninfo)) {
      self.spawninfo = spawnStruct();
    }

    self.spawninfo.spawntime = gettime();
    self.spawninfo.damagedealttoofast = 0;
    self.spawninfo.damagereceivedtoofast = 0;
    self.spawninfo.badspawn = 0;
    var_0 = self.spawninfo.spawntime;

    if(!isDefined(self.num_lives)) {
      self.num_lives = 0;
    }

    self.num_lives++;

    if(isagent(self)) {
      return;
    }
    if(isDefined(self.explosive_drone_owner)) {
      self.explosive_drone_owner = undefined;
    }

    var_1 = 0.1;
    var_2 = var_1;
    var_3 = "_matchdata.gsc";
    var_4 = -1;
    var_5 = -1;
    var_6 = -1;

    if(isDefined(self.spawninfo)) {
      if(isDefined(self.spawninfo.spawnpoint)) {
        if(isDefined(self.spawninfo.spawnpoint.israndom)) {
          var_4 = self.spawninfo.spawnpoint.israndom;
        }

        if(isDefined(self.spawninfo.spawnpoint.numberofpossiblespawnchoices)) {
          var_5 = self.spawninfo.spawnpoint.numberofpossiblespawnchoices;
        }

        if(isDefined(self.spawninfo.spawnpoint.lastupdatetime)) {
          var_6 = self.spawninfo.spawnpoint.lastupdatetime;
        }
      }
    }

    reconspatialevent(self.spawnpos, "script_mp_playerspawn: player_name %s, life_id %d, life_index %d, was_tactical_insertion %b, team %s, gameTime %d, version %f, script_file %s, randomSpawn %b, number_of_choices %d, last_update_time %d", self.name, self.lifeid, self.num_lives, self.wasti, self.team, var_0, var_2, var_3, var_4, var_5, var_6);
  }
}

recordtogglescopestates() {
  self.pers["toggleScopeStates"] = [];
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(var_2 == self.primaryweapon || var_2 == self.secondaryweapon) {
      var_3 = getweaponattachments(var_2);

      foreach(var_5 in var_3) {
        if(var_5 == "variablereddot") {
          self.pers["toggleScopeStates"][var_2] = self gethybridsightenabled(var_2);
          break;
        }
      }
    }
  }
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

watchstingerusage() {
  maps\mp\_stinger::stingerusageloop();
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  thread watchstartweaponchange();
  self.lastdroppableweapon = self.currentweaponatspawn;
  self.hitsthismag = [];
  var_0 = self getcurrentweapon();

  if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0])) {
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }

  self.bothbarrels = undefined;

  if(issubstr(var_0, "ranger")) {
    thread watchrangerusage(var_0);
  }

  var_1 = 1;

  for(;;) {
    if(!var_1) {
      self waittill("weapon_change");
    }

    var_1 = 0;
    var_0 = self getcurrentweapon();

    if(var_0 == "none") {
      continue;
    }
    var_2 = getweaponattachments(var_0);
    self.has_opticsthermal = 0;
    self.has_target_enhancer = 0;
    self.has_stock = 0;
    self.has_laser = 0;

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4 == "opticstargetenhancer") {
          self.has_target_enhancer = 1;
          continue;
        }

        if(var_4 == "stock") {
          self.has_stock = 1;
          continue;
        }

        if(var_4 == "lasersight") {
          self.has_laser = 1;
          continue;
        }

        if(issubstr(var_4, "opticsthermal")) {
          self.has_opticsthermal = 1;
        }
      }
    }

    if(maps\mp\_utility::isbombsiteweapon(var_0)) {
      continue;
    }
    if(maps\mp\_utility::iskillstreakweapon(var_0)) {
      if(maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon()) {
        self.changingweapon = undefined;
      }

      continue;
    }

    var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    self.bothbarrels = undefined;

    if(issubstr(var_0, "ranger")) {
      thread watchrangerusage(var_0);
    }

    if(var_6[0] == "alt") {
      var_7 = getsubstr(var_0, 4);
      var_0 = var_7;
      var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    }

    if(var_0 != "none" && var_6[0] != "iw5" && var_6[0] != "iw6") {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0 + "_mp"])) {
        self.hitsthismag[var_0 + "_mp"] = weaponclipsize(var_0 + "_mp");
      }
    } else if(var_0 != "none" && (var_6[0] == "iw5" || var_6[0] == "iw6")) {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0])) {
        self.hitsthismag[var_0] = weaponclipsize(var_0);
      }
    }

    if(maydropweapon(var_0)) {
      self.lastdroppableweapon = var_0;
    }

    self.changingweapon = undefined;
  }
}

watchstartweaponchange() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self.changingweapon = undefined;

  for(;;) {
    self waittill("weapon_switch_started", var_0);
    thread makesureweaponchanges(self getcurrentweapon());
    self.changingweapon = var_0;

    if(var_0 == "none" && isDefined(self.iscapturingcrate) && self.iscapturingcrate) {
      while(self.iscapturingcrate) {
        wait 0.05;
      }

      self.changingweapon = undefined;
    }
  }
}

makesureweaponchanges(var_0) {
  self endon("weapon_switch_started");
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  if(!maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon()) {
    return;
  }
  wait 1.0;
  self.changingweapon = undefined;
}

watchweaponreload() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();
    self.bothbarrels = undefined;

    if(!issubstr(var_0, "ranger")) {
      continue;
    }
    thread watchrangerusage(var_0);
  }
}

watchrangerusage(var_0) {
  var_1 = self getweaponammoclip(var_0, "right");
  var_2 = self getweaponammoclip(var_0, "left");
  self endon("reload");
  self endon("weapon_change");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_fired", var_3);

    if(var_3 != var_0) {
      continue;
    }
    self.bothbarrels = undefined;

    if(issubstr(var_0, "akimbo")) {
      var_4 = self getweaponammoclip(var_0, "left");
      var_5 = self getweaponammoclip(var_0, "right");

      if(var_2 != var_4 && var_1 != var_5) {
        self.bothbarrels = 1;
      }

      if(!var_4 || !var_5) {
        return;
      }
      var_2 = var_4;
      var_1 = var_5;
      continue;
    }

    if(var_1 == 2 && !self getweaponammoclip(var_0, "right")) {
      self.bothbarrels = 1;
      return;
    }
  }
}

maydropweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(issubstr(var_0, "uav")) {
    return 0;
  }

  if(issubstr(var_0, "killstreak")) {
    return 0;
  }

  if(maps\mp\_utility::getweaponclass(var_0) == "weapon_projectile") {
    return 0;
  }

  var_1 = weaponinventorytype(var_0);

  if(var_1 != "primary") {
    return 0;
  }

  if(issubstr(var_0, "combatknife") || issubstr(var_0, "underwater")) {
    return 0;
  }

  return 1;
}

dropweaponfordeath(var_0, var_1) {
  if(!maps\mp\_utility::isusingremote()) {
    waittillframeend;
  }

  if(isDefined(level.blockweapondrops)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.droppeddeathweapon)) {
    return;
  }
  if(level.ingraceperiod) {
    return;
  }
  var_2 = self.lastdroppableweapon;

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2 == "none") {
    return;
  }
  if(!self hasweapon(var_2)) {
    return;
  }
  if(maps\mp\_utility::isjuggernaut()) {
    return;
  }
  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_2)) {
    return;
  }
  var_3 = maps\mp\_utility::getweaponnametokens(var_2);

  if(var_3[0] == "alt") {
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_4 > 0 && var_4 < 2) {
        var_2 = var_2 + var_3[var_4];
        continue;
      }

      if(var_4 > 0) {
        var_2 = var_2 + ("_" + var_3[var_4]);
        continue;
      }

      var_2 = "";
    }
  }

  if(var_2 != "riotshield_mp") {
    if(!self anyammoforweaponmodes(var_2)) {
      return;
    }
    var_5 = self getweaponammoclip(var_2, "right");
    var_6 = self getweaponammoclip(var_2, "left");

    if(!var_5 && !var_6) {
      return;
    }
    var_7 = self getweaponammostock(var_2);
    var_8 = weaponmaxammo(var_2);

    if(var_7 > var_8) {
      var_7 = var_8;
    }

    var_9 = self dropitem(var_2);

    if(!isDefined(var_9)) {
      return;
    }
    if(maps\mp\_utility::ismeleemod(var_1)) {
      var_9.origin = (var_9.origin[0], var_9.origin[1], var_9.origin[2] - 5);
    }

    var_9 itemweaponsetammo(var_5, var_7, var_6);
  } else {
    var_9 = self dropitem(var_2);

    if(!isDefined(var_9)) {
      return;
    }
    var_9 itemweaponsetammo(1, 1, 0);
  }

  self.droppeddeathweapon = 1;

  if(maps\mp\_riotshield::weaponisriotshield(var_2)) {
    self refreshshieldmodels();
  }

  var_9.owner = self;
  var_9.ownersattacker = var_0;
  var_9.targetname = "dropped_weapon";
  var_9 thread watchpickup();
  var_9 thread deletepickupafterawhile();
}

detachifattached(var_0, var_1) {
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

deletepickupafterawhile() {
  self endon("death");
  wait 60;

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
  var_1 = self.owner;

  for(;;) {
    self waittill("trigger", var_2, var_3);

    if(isDefined(var_0) && var_0 == var_2.primaryweapon) {
      return;
    }
    if(isDefined(var_0) && var_0 == var_2.secondaryweapon) {
      return;
    }
    var_2.pickedupweaponfrom[var_0] = undefined;
    var_2.tookweaponfrom[var_0] = undefined;

    if(isDefined(var_2.pers["weaponPickupsCount"])) {
      var_2.pers["weaponPickupsCount"]++;
    }

    if(isDefined(var_1) && var_1 != var_2) {
      var_2.pickedupweaponfrom[var_0] = var_1;

      if(isDefined(self.ownersattacker) && self.ownersattacker == var_2) {
        var_2.tookweaponfrom[var_0] = var_1;
      }
    }

    if(isDefined(var_3)) {
      break;
    }
  }

  var_3.owner = var_2;
  var_3.targetname = "dropped_weapon";
  var_4 = var_3 getitemweaponname();

  if(isDefined(var_2.primaryweapon) && var_2.primaryweapon == var_4) {
    var_2.primaryweapon = var_0;
  }

  if(isDefined(var_2.secondaryweapon) && var_2.secondaryweapon == var_4) {
    var_2.secondaryweapon = var_0;
  }

  if(isDefined(var_2.pickedupweaponfrom[var_4])) {
    var_3.owner = var_2.pickedupweaponfrom[var_4];
    var_2.pickedupweaponfrom[var_4] = undefined;
  }

  if(isDefined(var_2.tookweaponfrom[var_4])) {
    var_3.ownersattacker = var_2;
    var_2.tookweaponfrom[var_4] = undefined;
  }

  var_3 thread watchpickup();
}

itemremoveammofromaltmodes() {
  var_0 = getitemweaponname();
  var_1 = weaponaltweaponname(var_0);

  for(var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++) {
    self itemweaponsetammo(0, 0, 0, var_2);
    var_1 = weaponaltweaponname(var_1);
  }
}

handlescavengerbagpickup(var_0) {
  self endon("death");
  level endon("game_ended");
  self waittill("scavenger", var_1);
  var_1 notify("scavenger_pickup");
  var_2 = var_1 getweaponslistoffhands();

  foreach(var_4 in var_2) {
    if(maps\mp\gametypes\_class::isvalidoffhand(var_4, 0) && var_1 maps\mp\_utility::_hasperk("specialty_tacticalresupply")) {
      var_1 batteryfullrecharge(var_4);
      continue;
    }

    if(maps\mp\gametypes\_class::isvalidequipment(var_4, 0) && var_1 maps\mp\_utility::_hasperk("specialty_lethalresupply")) {
      var_5 = var_1 getweaponammoclip(var_4);
      var_1 setweaponammoclip(var_4, var_5 + 1);
    }
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_scavenger")) {
    var_7 = var_1 getweaponslistprimaries();

    foreach(var_9 in var_7) {
      if(maps\mp\_utility::iscacprimaryweapon(var_9) || level.scavenger_secondary && maps\mp\_utility::iscacsecondaryweapon(var_9)) {
        var_10 = var_1 getweaponammostock(var_9);
        var_11 = 0;
        var_12 = maps\mp\_utility::getweaponclass(var_9);

        if(isbeamweapon(var_9) || var_12 == "weapon_riot" || issubstr(var_9, "riotshield")) {} else if(var_12 == "weapon_projectile" || issubstr(var_9, "exocrossbow") || issubstr(var_9, "microdronelauncher")) {
          if(var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply")) {
            var_11 = weaponclipsize(var_9);
          }
        } else if(issubstr(var_9, "alt") && issubstr(var_9, "gl")) {
          if(var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply")) {
            var_11 = weaponclipsize(var_9);
          }
        } else if(isbulletweapon(var_9)) {
          if(var_1 maps\mp\_utility::_hasperk("specialty_bulletresupply")) {
            var_13 = weaponmaxammo(var_9);
            var_11 = int(var_13 * var_1.ammopickup_scalar);
          }
        }

        if(var_11 > 0) {
          var_1 setweaponammostock(var_9, var_10 + var_11);
        }
      }
    }
  }

  var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("scavenger");
}

dropscavengerfordeath(var_0) {
  waittillframeend;

  if(level.ingraceperiod) {
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
  if(level.iszombiegame) {
    return;
  }
  if(!isDefined(self.agentbody)) {
    var_1 = self dropscavengerbag("scavenger_bag_mp");
  } else {
    var_1 = self.agentbody dropscavengerbag("scavenger_bag_mp");
  }

  var_1 thread handlescavengerbagpickup(self);

  if(isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var_1);
  }
}

getweaponbasedgrenadecount(var_0) {
  return 2;
}

getweaponbasedsmokegrenadecount(var_0) {
  return 1;
}

getfraggrenadecount() {
  var_0 = "frag_grenade_mp";
  var_1 = self getammocount(var_0);
  return var_1;
}

getsmokegrenadecount() {
  var_0 = self getammocount("smoke_grenade_mp");
  var_0 = var_0 + self getammocount("smoke_grenade_mp_lefthand");
  var_0 = var_0 + self getammocount("smoke_grenade_var_mp");
  var_0 = var_0 + self getammocount("smoke_grenade_var_mp_lefthand");
  return var_0;
}

setweaponstat(var_0, var_1, var_2) {
  maps\mp\gametypes\_gamelogic::setweaponstat(var_0, var_1, var_2);
}

watchweaponusage(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  if(isai(self)) {
    return;
  }
  for(;;) {
    self waittill("weapon_fired", var_1);
    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
    self.lastshotfiredtime = gettime();

    if(!maps\mp\_utility::iscacprimaryweapon(var_1) && !maps\mp\_utility::iscacsecondaryweapon(var_1)) {
      continue;
    }
    if(isDefined(self.hitsthismag[var_1])) {
      thread updatemagshots(var_1);
    }

    var_2 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
    var_3 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
    var_4 = clamp(float(var_3) / float(var_2), 0.0, 1.0) * 10000.0;
    maps\mp\gametypes\_persistence::statsetbuffered("totalShots", var_2);
    maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_4));
    maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_2 - var_3));

    if(isDefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime()) {
      self.hits = 0;
      return;
    }

    var_5 = 1;
    setweaponstat(var_1, var_5, "shots");
    setweaponstat(var_1, self.hits, "hits");
    self.hits = 0;
  }
}

updatemagshots(var_0) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("updateMagShots_" + var_0);
  self.hitsthismag[var_0]--;
  wait 0.05;
  self.hitsthismag[var_0] = weaponclipsize(var_0);
}

checkhitsthismag(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("updateMagShots_" + var_0);
  waittillframeend;

  if(isDefined(self.hitsthismag[var_0]) && self.hitsthismag[var_0] == 0) {
    var_1 = maps\mp\_utility::getweaponclass(var_0);
    maps\mp\gametypes\_missions::genericchallenge(var_1);
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }
}

checkhit(var_0, var_1) {
  self endon("disconnect");

  if(maps\mp\_utility::isstrstart(var_0, "alt_")) {
    var_2 = maps\mp\_utility::getweaponnametokens(var_0);

    foreach(var_4 in var_2) {
      if(var_4 == "shotgun") {
        var_5 = getsubstr(var_0, 0, 4);

        if(!isprimaryweapon(var_5) && !issidearm(var_5)) {
          self.hits = 1;
        }

        continue;
      }

      if(var_4 == "hybrid") {
        var_6 = getsubstr(var_0, 4);
        var_0 = var_6;
      }
    }
  }

  if(!isprimaryweapon(var_0) && !issidearm(var_0)) {
    return;
  }
  if(self meleebuttonpressed()) {
    return;
  }
  switch (weaponclass(var_0)) {
    case "beam":
    case "smg":
    case "mg":
    case "pistol":
    case "rifle":
    case "sniper":
      self.hits++;
      break;
    case "spread":
      self.hits = 1;
      break;
    case "rocketlauncher":
    case "ball":
    case "shield":
    case "item":
    case "underwater":
    case "grenade":
      break;
    default:
      break;
  }

  if(issubstr(var_0, "riotshield")) {
    thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname("riotshield", self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend;

  if(isDefined(self.hitsthismag[var_0])) {
    thread checkhitsthismag(var_0);
  }

  if(!isDefined(self.lasthittime[var_0])) {
    self.lasthittime[var_0] = 0;
  }

  if(self.lasthittime[var_0] == gettime()) {
    return;
  }
  self.lasthittime[var_0] = gettime();
  var_8 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
  var_9 = maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;

  if(var_9 <= var_8) {
    maps\mp\gametypes\_persistence::statsetbuffered("hits", var_9);
    maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_8 - var_9));
    var_10 = clamp(float(var_9) / float(var_8), 0.0, 1.0) * 10000.0;
    maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_10));
  }
}

attackercandamageitem(var_0, var_1) {
  return friendlyfirecheck(var_1, var_0);
}

friendlyfirecheck(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  var_3 = var_1.team;
  var_4 = level.friendlyfire;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return 1;
  }

  if(var_1 == var_0) {
    return 1;
  }

  if(!isDefined(var_3)) {
    return 1;
  }

  if(var_3 != var_0.team) {
    return 1;
  }

  return 0;
}

watchgrenadeusage() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.throwinggrenade = undefined;
  self.gotpullbacknotify = 0;

  if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1) {
    if(isDefined(self.dont_delete_grenades_on_next_spawn)) {
      self.dont_delete_grenades_on_next_spawn = undefined;
    } else {
      delete_all_grenades();
    }
  } else {
    if(!isDefined(self.manuallydetonatedarray)) {
      self.manuallydetonatedarray = [];
    }

    if(!isDefined(self.claymorearray)) {
      self.claymorearray = [];
    }

    if(!isDefined(self.bouncingbettyarray)) {
      self.bouncingbettyarray = [];
    }
  }

  thread watchmanuallydetonatedusage();
  thread watchmanualdetonationbyemptythrow();
  thread watchmanualdetonationbydoubletap();
  thread watchc4usage();
  thread watchclaymores();
  thread deletec4andclaymoresondisconnect();
  thread watchforthrowbacks();

  for(;;) {
    self waittill("grenade_pullback", var_0);
    setweaponstat(var_0, 1, "shots");
    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
    thread watchoffhandcancel();

    if(var_0 == "claymore_mp") {
      continue;
    }
    self.throwinggrenade = var_0;
    self.gotpullbacknotify = 1;

    if(var_0 == "c4_mp") {
      beginc4tracking();
    } else {
      begingrenadetracking();
    }

    self.throwinggrenade = undefined;
  }
}

begingrenadetracking() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self endon("offhand_end");
  self endon("weapon_change");
  var_0 = gettime();
  self waittill("grenade_fire", var_1, var_2);

  if(isDefined(var_1)) {
    var_3 = maps\mp\_utility::strip_suffix(var_2, "_lefthand");

    if(gettime() - var_0 > 1000 && var_3 == "frag_grenade_mp") {
      var_1.iscooked = 1;
    }

    self.changingweapon = undefined;
    var_1.owner = self;
    var_1.weaponname = var_2;

    switch (var_3) {
      case "semtex_grenade_var_mp":
      case "frag_grenade_var_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_1 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
        var_1.originalowner = self;
        break;
      case "flash_grenade_mp":
        var_1 thread ninebangexplodewaiter();
        break;
      case "concussion_grenade_mp":
        var_1 thread empexplodewaiter();
        break;
      case "stun_grenade_var_mp":
      case "stun_grenade_mp":
        break;
      case "smoke_grenade_var_mp":
      case "smoke_grenade_mp":
        var_1 thread watchsmokeexplode();
        break;
      case "paint_grenade_horde_mp":
      case "paint_grenade_var_mp":
      case "paint_grenade_mp":
        var_1 thread watchpaintgrenade();
        break;
    }
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

watchpaintgrenade() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_0 endon("death");
  self waittill("explode", var_1);

  if(var_0 maps\mp\_utility::isemped() && isDefined(level.empequipmentdisabled) && level.empequipmentdisabled) {
    return;
  }
  detection_grenade_think(var_1, var_0);
}

detection_grenade_think(var_0, var_1) {
  var_2 = getdvarfloat("paintExplosionRadius");
  var_3 = 1.0;
  var_4 = 1.5;

  if(isDefined(level.ishorde)) {
    var_4 = 10;
  }

  thread maps\mp\_threatdetection::detection_grenade_hud_effect(var_1, var_0, var_3, var_2);
  thread maps\mp\_threatdetection::detection_highlight_hud_effect(var_1, var_4);

  foreach(var_6 in level.players) {
    if(!isDefined(var_6) || !isalive(var_6) || var_6 maps\mp\_utility::_hasperk("specialty_coldblooded") || level.teambased == 1 && var_1 != var_6 && var_1.team == var_6.team) {
      continue;
    }
    if(distance(var_6.origin, var_0) < var_2) {
      if(var_6 sightconetrace(var_0)) {
        if(var_1 == var_6) {
          foreach(var_8 in level.players) {
            if(isDefined(var_8) && (level.teambased == 0 || var_1.team != var_8.team || var_1 == var_8)) {
              thread maps\mp\_threatdetection::detection_highlight_hud_effect(var_8, var_4);
              var_1 maps\mp\_threatdetection::addthreatevent([var_8], var_4, "PAINT_GRENADE", 1, 0);
            }
          }

          continue;
        }

        var_6 maps\mp\_threatdetection::addthreatevent([var_1], var_4, "PAINT_GRENADE", 1, 0);
        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("paint");
      }
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(var_12 in level.agentarray) {
      if(!isDefined(var_12) || !isalive(var_12) || isDefined(var_12.team) && level.teambased == 1 && var_1.team == var_12.team) {
        continue;
      }
      if(distance(var_12.origin, var_0) < var_2) {
        if(var_12 sightconetrace(var_0)) {
          var_12 maps\mp\_threatdetection::addthreatevent([var_1], var_4, "PAINT_GRENADE", 1, 0);
          var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("paint");
        }
      }
    }
  }
}

watchsmokeexplode() {
  level endon("smokeTimesUp");
  var_0 = self.owner;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  var_2 = 128;
  var_3 = 8;
  level thread waitsmoketime(var_3, var_2, var_1);

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    foreach(var_5 in level.players) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(level.teambased && var_5.team == var_0.team) {
        continue;
      }
      if(distancesquared(var_5.origin, var_1) < var_2 * var_2) {
        var_5.inplayersmokescreen = var_0;
        continue;
      }

      var_5.inplayersmokescreen = undefined;
    }

    wait 0.05;
  }
}

waitsmoketime(var_0, var_1, var_2) {
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  level notify("smokeTimesUp");
  waittillframeend;

  foreach(var_4 in level.players) {
    if(isDefined(var_4)) {
      var_4.inplayersmokescreen = undefined;
    }
  }
}

watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    var_2 = [var_0];

    if(issubstr(var_1, "_gl")) {
      var_0.owner = self;
      var_0.primaryweapon = self getcurrentprimaryweapon();
      var_0 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
    }

    if(isDefined(var_0)) {
      var_0.weaponname = var_1;

      if(isprimaryorsecondaryprojectileweapon(var_1)) {
        var_0.firedads = self playerads();
      }
    }

    switch (var_1) {
      case "iw5_lsr_mp":
      case "stinger_mp":
        var_0.lockedstingertarget = self.stingertarget;
        level notify("stinger_fired", self, var_2);
        thread maps\mp\_utility::setaltsceneobj(var_0, "tag_origin", 65);
        break;
      default:
        break;
    }

    switch (var_1) {
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
      case "rpg_mp":
      case "remotemissile_projectile_mp":
        var_0 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
      default:
        break;
    }
  }
}

watchhitbymissile() {
  self endon("disconnect");

  for(;;) {
    self waittill("hit_by_missile", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!isDefined(var_0) || !isDefined(var_1)) {
      continue;
    }
    if(level.teambased && self.team == var_0.team) {
      self cancelrocketcorpse(var_1, var_3, var_4, var_5, var_6, var_7);
      continue;
    }

    if(var_2 != "rpg_mp") {
      self cancelrocketcorpse(var_1, var_3, var_4, var_5, var_6, var_7);
      continue;
    }

    if(randomintrange(0, 100) < 99) {
      self cancelrocketcorpse(var_1, var_3, var_4, var_5, var_6, var_7);
      continue;
    }

    var_8 = getdvarfloat("rocket_corpse_max_air_time", 0.5);
    var_9 = getdvarfloat("rocket_corpse_view_offset_up", 100);
    var_10 = getdvarfloat("rocket_corpse_view_offset_forward", 35);
    self.isrocketcorpse = 1;
    self setcontents(0);
    var_11 = self setrocketcorpse(1);
    var_12 = var_11 / 1000.0;
    self.killcament = spawn("script_model", var_1.origin);
    self.killcament.angles = var_1.angles;
    self.killcament linkto(var_1);
    self.killcament setscriptmoverkillcam("rocket_corpse");
    self.killcament setcontents(0);
    self dodamage(1000, self.origin, var_0, var_1);
    self.body = self cloneplayer(var_11);
    self.body.origin = var_1.origin;
    self.body.angles = var_1.angles;
    self.body setcorpsefalling(0);
    self.body enablelinkto();
    self.body linkto(var_1);
    self.body setcontents(0);

    if(!isDefined(self.switching_teams)) {
      thread maps\mp\gametypes\_deathicons::adddeathicon(self.body, self, self.team, 5.0);
    }

    self playerhide();
    var_13 = vectornormalize(anglestoup(var_1.angles));
    var_14 = vectornormalize(anglesToForward(var_1.angles));
    var_15 = var_14 * var_9 + var_13 * var_10;
    var_16 = var_1.origin + var_15;
    var_17 = spawn("script_model", var_16);
    var_17 setModel("tag_origin");
    var_17.angles = vectortoangles(var_1.origin - var_17.origin);
    var_17 linkto(var_1);
    var_17 setcontents(0);
    self cameralinkto(var_17, "tag_origin");

    if(var_8 > var_12) {
      var_8 = var_12;
    }

    var_18 = var_1 common_scripts\utility::waittill_notify_or_timeout_return("death", var_8);

    if(isDefined(var_18) && var_18 == "timeout" && isDefined(var_1)) {
      var_1 detonate();
    }

    self notify("final_rocket_corpse_death");
    self.body unlink();
    self.body setcorpsefalling(1);
    self.body startragdoll();
    var_17 linkto(self.body);
    self.isrocketcorpse = undefined;
    self waittill("death_delay_finished");
    self cameraunlink();
    self.killcament delete();
    var_17 delete();
  }
}

watchsentryusage() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sentry_placement_finished", var_0);
    thread maps\mp\_utility::setaltsceneobj(var_0, "tag_flash", 65);
  }
}

empexplodewaiter() {
  thread maps\mp\gametypes\_shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  var_1 = getempdamageents(var_0, 512, 0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.owner) && !friendlyfirecheck(self.owner, var_3.owner)) {
      continue;
    }
    var_3 notify("emp_damage", self.owner, 8.0);
  }
}

ninebangexplodewaiter() {
  thread maps\mp\gametypes\_shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  level thread doninebang(var_0, self.owner);
  var_1 = getempdamageents(var_0, 512, 0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.owner) && !friendlyfirecheck(self.owner, var_3.owner)) {
      continue;
    }
    var_3 notify("emp_damage", self.owner, 8.0);
  }
}

flashbangplayer(var_0, var_1, var_2) {
  var_3 = 640000;
  var_4 = 40000;
  var_5 = 60;
  var_6 = 40;
  var_7 = 11;

  if(!maps\mp\_utility::isreallyalive(var_0) || var_0.sessionstate != "playing") {
    return;
  }
  var_8 = distancesquared(var_1, var_0.origin);

  if(var_8 > var_3) {
    return;
  }
  if(var_8 <= var_4) {
    var_9 = 1.0;
  } else {
    var_9 = 1.0 - (var_8 - var_4) / (var_3 - var_4);
  }

  var_10 = var_0 sightconetrace(var_1);

  if(var_10 < 0.5) {
    return;
  }
  var_11 = anglesToForward(var_0 getangles());
  var_12 = var_0.origin;

  switch (var_0 getstance()) {
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
  var_13 = vectornormalize(var_13);
  var_14 = 0.5 * (1.0 + vectordot(var_11, var_13));
  var_0 notify("flashbang", var_1, var_9, var_14, var_2);
}

doninebang(var_0, var_1) {
  level endon("game_ended");
  var_2 = 1;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(var_3 > 0) {
      playsoundatpos(var_0, "null");

      foreach(var_5 in level.players) {
        flashbangplayer(var_5, var_0, var_1);
      }
    }

    var_7 = getempdamageents(var_0, 512, 0);

    foreach(var_9 in var_7) {
      if(isDefined(var_9.owner) && !friendlyfirecheck(self.owner, var_9.owner)) {
        continue;
      }
      var_9 notify("emp_damage", self.owner, 8.0);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

beginc4tracking() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::waittill_any("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

watchforthrowbacks() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(self.gotpullbacknotify) {
      self.gotpullbacknotify = 0;
      continue;
    }

    if(!issubstr(var_1, "frag_") && !issubstr(var_1, "semtex_")) {
      continue;
    }
    var_0.threwback = 1;
    var_0.originalowner = self;
    var_0 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
  }
}

manuallydetonated_removeundefined(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3[0])) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

watchmanuallydetonatedusage() {
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = isweaponmanuallydetonatedbyemptythrow(var_1);
    var_3 = isweaponmanuallydetonatedbydoubletap(var_1);

    if(var_2 || var_3) {
      if(!self.manuallydetonatedarray.size) {
        thread watchmanuallydetonatedfordoubletap();
      }

      if(self.manuallydetonatedarray.size) {
        self.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);

        if(self.manuallydetonatedarray.size >= level.maxperplayerexplosives) {
          self.manuallydetonatedarray[0][0] detonate();
        }
      }

      var_4 = self.manuallydetonatedarray.size;
      self.manuallydetonatedarray[var_4] = [];
      self.manuallydetonatedarray[var_4][0] = var_0;
      self.manuallydetonatedarray[var_4][1] = var_2;
      self.manuallydetonatedarray[var_4][2] = var_3;

      if(isDefined(var_0)) {
        var_0.owner = self;
        var_0 setotherent(self);
        var_0.team = self.team;
        var_0.weaponname = var_1;
        var_0.stunned = 0;
      }
    }
  }
}

watchc4usage() {
  self endon("faux_spawn");
  self endon("spawned_player");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "c4" || var_1 == "c4_mp") {
      level.mines[level.mines.size] = var_0;
      var_0 thread maps\mp\gametypes\_shellshock::c4_earthquake();
      var_0 thread c4damage();
      var_0 thread c4empdamage();
      var_0 thread c4empkillstreakwait();
      var_0 thread watchc4stuck();
      var_0 thread setmineteamheadicon(self.pers["team"]);
    }
  }
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck");
  self.trigger = spawn("script_origin", self.origin);
  self.trigger.owner = self;
  thread equipmentwatchuse(self.owner, 1);
  makeexplosivetargetablebyai();
}

c4empdamage() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    self.disabled = 1;
    self notify("disabled");
    wait(var_1);
    self.disabled = undefined;
    self notify("enabled");
  }
}

c4empkillstreakwait() {
  self endon("death");

  for(;;) {
    level waittill("emp_update");

    if(level.teambased && level.teamemped[self.team] || !level.teambased && isDefined(level.empplayer) && level.empplayer != self.owner) {
      self.disabled = 1;
      self notify("disabled");
      continue;
    }

    self.disabled = undefined;
    self notify("enabled");
  }
}

setmineteamheadicon(var_0) {
  self endon("death");
  wait 0.05;

  if(level.teambased) {
    maps\mp\_entityheadicons::setteamheadicon(var_0, (0, 0, 20));
  } else if(isDefined(self.owner)) {
    maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0, 0, 20));
  }
}

watchclaymores() {
  self endon("faux_spawn");
  self endon("spawned_player");
  self endon("disconnect");
  self.claymorearray = [];

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "claymore" || var_1 == "claymore_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      var_0 hide();
      var_0 common_scripts\utility::waittill_any_timeout(0.05, "missile_stuck");
      var_2 = 60;
      var_3 = (0, 0, 4);
      var_4 = distancesquared(self.origin, var_0.origin);
      var_5 = distancesquared(self getEye(), var_0.origin);
      var_4 = var_4 + 600;
      var_6 = var_0 getlinkedparent();

      if(isDefined(var_6)) {
        var_0 unlink();
      }

      if(var_4 < var_5) {
        if(var_2 * var_2 < distancesquared(var_0.origin, self.origin)) {
          var_7 = bulletTrace(self.origin, self.origin - (0, 0, var_2), 0, self);

          if(var_7["fraction"] == 1) {
            var_0 delete();
            self setweaponammostock("claymore_mp", self getweaponammostock("claymore_mp") + 1);
            continue;
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
          continue;
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

      if(isDefined(var_6)) {
        var_0 linkto(var_6);
      }

      var_0 show();
      self.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);

      if(self.claymorearray.size >= level.maxperplayerexplosives) {
        deleteequipment(self.claymorearray[0]);
      }

      self.claymorearray[self.claymorearray.size] = var_0;
      var_0.owner = self;
      var_0 setotherent(self);
      var_0.team = self.team;
      var_0.weaponname = var_1;
      var_0.trigger = spawn("script_origin", var_0.origin);
      var_0.trigger.owner = var_0;
      var_0.stunned = 0;
      var_0 makeexplosivetargetablebyai();
      level.mines[level.mines.size] = var_0;
      var_0 thread c4damage();
      var_0 thread c4empdamage();
      var_0 thread c4empkillstreakwait();
      var_0 thread claymoredetonation();
      var_0 thread equipmentwatchuse(self, 1);
      var_0 thread setmineteamheadicon(self.pers["team"]);
      self.changingweapon = undefined;
    }
  }
}

equipmentenableuse(var_0) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self endon("change_owner");
  self.trigger setcursorhint("HINT_NOICON");

  if(self.weaponname == "c4_mp") {
    self.trigger sethintstring(&"MP_PICKUP_C4");
  } else if(self.weaponname == "claymore_mp") {
    self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
  } else if(self.weaponname == "bouncingbetty_mp") {
    self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
  }

  self.trigger maps\mp\_utility::setselfusable(var_0);
}

equipmentdisableuse(var_0) {
  self.trigger sethintstring("");
  self.trigger maps\mp\_utility::setselfunusuable();
}

equipmentwatchenabledisableuse(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = 1;

  for(;;) {
    if(var_0 getweaponammostock(self.weaponname) < weaponmaxammo(self.weaponname)) {
      if(!var_1) {
        equipmentenableuse(var_0);
        var_1 = 1;
      }
    } else if(var_1) {
      equipmentdisableuse(var_0);
      var_1 = 0;
    }

    wait 0.05;
  }
}

equipmentwatchuse(var_0, var_1) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self.trigger setcursorhint("HINT_NOICON");
  equipmentenableuse(var_0);

  if(isDefined(var_1) && var_1) {
    thread updatetriggerposition();
  }

  for(;;) {
    thread equipmentwatchenabledisableuse(var_0);
    self.trigger waittill("trigger", var_0);
    var_2 = var_0 getweaponammostock(self.weaponname);

    if(var_2 < weaponmaxammo(self.weaponname)) {
      var_0 playlocalsound("scavenger_pack_pickup");
      var_0 setweaponammostock(self.weaponname, var_2 + 1);
      self.trigger delete();
      self delete();
      self notify("death");
    }
  }
}

updatetriggerposition() {
  self endon("death");

  for(;;) {
    if(isDefined(self) && isDefined(self.trigger)) {
      self.trigger.origin = self.origin;

      if(isDefined(self.bombsquadmodel)) {
        self.bombsquadmodel.origin = self.origin;
      }
    } else {
      return;
    }

    wait 0.05;
  }
}

claymoredetonation() {
  self endon("death");
  self endon("change_owner");
  var_0 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);
  thread deleteondeath(var_0);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(self.stunned) {
      wait 0.05;
      continue;
    }

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.owner)) {
        if(var_1 == self.owner) {
          continue;
        }
        if(isDefined(var_1.owner) && var_1.owner == self.owner) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.owner, var_1, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_1 getentityvelocity()) < 10) {
      continue;
    }
    var_2 = abs(var_1.origin[2] - self.origin[2]);

    if(var_2 > 128) {
      continue;
    }
    if(!var_1 shouldaffectclaymore(self)) {
      continue;
    }
    if(var_1 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self playSound("claymore_activated");

  if(isPlayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_delaymine")) {
    var_1 notify("triggered_claymore");
    wait(level.delayminetime);
  } else {
    wait(level.claymoredetectiongraceperiod);
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.owner) && isDefined(level.leaderdialogonplayer_func)) {
    self.owner thread[[level.leaderdialogonplayer_func]]("claymore_destroyed", undefined, undefined, self.origin);
  }

  self detonate();
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

deleteequipment(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(var_0.trigger)) {
      var_0.trigger delete();
    }

    var_0 delete();
  }
}

watchmanuallydetonatedfordoubletap() {
  self endon("death");
  self endon("disconnect");
  self endon("all_detonated");
  level endon("game_ended");
  self endon("change_owner");
  var_0 = 0;

  for(;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;

      while(self usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while(!self usebuttonpressed() && var_0 < 0.35) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.35) {
        continue;
      }
      if(!self.manuallydetonatedarray.size) {
        return;
      }
      self notify("detonate_double_tap");
    }

    wait 0.05;
  }
}

watchmanualdetonationbyemptythrow() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  for(;;) {
    self waittill("detonate");
    manuallydetonateall(1);
  }
}

watchmanualdetonationbydoubletap() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  for(;;) {
    self waittill("detonate_double_tap");
    var_0 = self getcurrentweapon();

    if(!isweaponmanuallydetonatedbydoubletap(var_0)) {
      manuallydetonateall(2);
    }
  }
}

manuallydetonateall(var_0) {
  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < self.manuallydetonatedarray.size; var_3++) {
    if(!self.manuallydetonatedarray[var_3][var_0]) {
      var_1 = 1;
      continue;
    }

    var_4 = self.manuallydetonatedarray[var_3][0];

    if(isDefined(var_4)) {
      if(var_4.stunned) {
        var_1 = 1;
        return;
      }

      if(isDefined(var_4.weaponname) && !self getdetonateenabled(var_4.weaponname)) {
        var_1 = 1;
        continue;
      }

      if(isDefined(var_4.manuallydetonatefunc)) {
        self thread[[var_4.manuallydetonatefunc]](var_4);
        continue;
      }

      var_4 thread waitanddetonate(0, var_0);
    }
  }

  if(var_1) {
    self.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
  } else {
    self.manuallydetonatedarray = var_2;
    self notify("all_detonated");
  }
}

waitanddetonate(var_0, var_1) {
  self endon("death");
  wait(var_0);
  waittillenabled();

  if(var_1 == 2) {
    self detonatebydoubletap();
  } else {
    self detonate();
  }

  level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

deletec4andclaymoresondisconnect() {
  self endon("faux_spawn");
  self endon("death");
  self waittill("disconnect");
  var_0 = self.manuallydetonatedarray;
  var_1 = self.claymorearray;
  wait 0.05;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2][0])) {
      var_0[var_2][0] delete();
    }
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2])) {
      var_1[var_2] delete();
    }
  }
}

c4damage() {
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      var_10 = maps\mp\_utility::strip_suffix(var_9, "_lefthand");

      switch (var_10) {
        case "smoke_grenade_var_mp":
        case "stun_grenade_var_mp":
        case "smoke_grenade_mp":
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
          continue;
      }
    }

    break;
  }

  if(level.c4explodethisframe) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  level.c4explodethisframe = 1;
  thread resetc4explodethisframe();

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isPlayer(var_0)) {
    var_0 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("c4");
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self.owner)) {
      var_11 = var_0.pers["team"];
      var_12 = self.owner.pers["team"];

      if(isDefined(var_11) && isDefined(var_12) && var_11 != var_12) {
        var_0 notify("destroyed_explosive");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var_0) && var_0 != self.owner) {
    var_0 notify("destroyed_explosive");
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self detonate(var_0);
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

saydamaged(var_0, var_1) {
  for(var_2 = 0; var_2 < 60; var_2++) {
    wait 0.05;
  }
}

waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }
  self waittill("enabled");
}

makeexplosivetargetablebyai(var_0) {
  common_scripts\utility::make_entity_sentient_mp(self.owner.team);

  if(!isDefined(var_0) || !var_0) {
    self makeentitynomeleetarget();
  }

  if(issentient(self)) {
    self setthreatbiasgroup("DogsDontAttack");
  }
}

setupbombsquad() {
  self.bombsquadids = [];

  if(self.detectexplosives && !self.bombsquadicons.size) {
    for(var_0 = 0; var_0 < 4; var_0++) {
      self.bombsquadicons[var_0] = newclienthudelem(self);
      self.bombsquadicons[var_0].x = 0;
      self.bombsquadicons[var_0].y = 0;
      self.bombsquadicons[var_0].z = 0;
      self.bombsquadicons[var_0].alpha = 0;
      self.bombsquadicons[var_0].archived = 1;
      self.bombsquadicons[var_0] setshader("waypoint_bombsquad", 14, 14);
      self.bombsquadicons[var_0] setwaypoint(0, 0);
      self.bombsquadicons[var_0].detectid = "";
    }
  } else if(!self.detectexplosives) {
    for(var_0 = 0; var_0 < self.bombsquadicons.size; var_0++) {
      self.bombsquadicons[var_0] destroy();
    }

    self.bombsquadicons = [];
  }
}

showheadicon(var_0) {
  var_1 = var_0.detectid;
  var_2 = -1;

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = self.bombsquadicons[var_3].detectid;

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
  self.bombsquadids[var_1] = 1;
  self.bombsquadicons[var_2].x = var_0.origin[0];
  self.bombsquadicons[var_2].y = var_0.origin[1];
  self.bombsquadicons[var_2].z = var_0.origin[2] + 24 + 128;
  self.bombsquadicons[var_2] fadeovertime(0.25);
  self.bombsquadicons[var_2].alpha = 1;
  self.bombsquadicons[var_2].detectid = var_0.detectid;

  while(isalive(self) && isDefined(var_0) && self istouching(var_0)) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  self.bombsquadicons[var_2].detectid = "";
  self.bombsquadicons[var_2] fadeovertime(0.25);
  self.bombsquadicons[var_2].alpha = 0;
  self.bombsquadids[var_1] = undefined;
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
    var_8 = maps\mp\_utility::get_damageable_player_pos(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_6[var_7]))) {
      var_4[var_4.size] = maps\mp\_utility::get_damageable_player(var_6[var_7], var_8);
    }
  }

  var_10 = getEntArray("grenade", "classname");

  for(var_7 = 0; var_7 < var_10.size; var_7++) {
    var_11 = maps\mp\_utility::get_damageable_grenade_pos(var_10[var_7]);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_10[var_7]))) {
      var_4[var_4.size] = maps\mp\_utility::get_damageable_grenade(var_10[var_7], var_11);
    }
  }

  var_12 = getEntArray("destructible", "targetname");

  for(var_7 = 0; var_7 < var_12.size; var_7++) {
    var_11 = var_12[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_12[var_7]))) {
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

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_14[var_7]))) {
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

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_17))) {
      switch (var_17.model) {
        case "vehicle_ugv_talon_gun_cloaked_mp":
        case "vehicle_ugv_talon_gun_mp":
        case "mp_remote_turret":
        case "mp_scramble_turret":
        case "sentry_minigun_weak":
          var_4[var_4.size] = maps\mp\_utility::get_damageable_sentry(var_17, var_11);
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
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_21))) {
      var_4[var_4.size] = maps\mp\_utility::get_damageable_mine(var_21, var_11);
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

  var_5 = getEntArray("grenade", "classname");

  foreach(var_7 in var_5) {
    var_8 = var_7.origin;
    var_9 = distance(var_0, var_8);

    if(var_9 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_7))) {
      var_4[var_4.size] = var_7;
    }
  }

  var_11 = getEntArray("misc_turret", "classname");

  foreach(var_13 in var_11) {
    var_8 = var_13.origin;
    var_9 = distance(var_0, var_8);

    if(var_9 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_13))) {
      var_4[var_4.size] = var_13;
    }
  }

  return var_4;
}

weapondamagetracepassed(var_0, var_1, var_2, var_3) {
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

damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.damageorigin = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
  } else {
    if(self.isadestructable && (var_4 == "artillery_mp" || var_4 == "claymore_mp" || var_4 == "stealth_bomb_mp")) {
      return;
    }
    self.entity notify("damage", var_2, var_1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_4);
  }
}

debugline(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 600; var_3++) {
    wait 0.05;
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
    var_10 = var_0[0] + var_8;
    var_11 = var_0[1] + var_9;
    var_12 = var_0[2];
    var_5[var_5.size] = (var_10, var_11, var_12);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_13 = var_5[var_6];

    if(var_6 + 1 >= var_5.size) {
      var_14 = var_5[0];
    } else {
      var_14 = var_5[var_6 + 1];
    }

    thread debugline(var_13, var_14, var_2);
  }
}

debugprint(var_0, var_1) {
  for(var_2 = 0; var_2 < 600; var_2++) {
    wait 0.05;
  }
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_5 = 700;
  var_6 = 25;
  var_7 = var_5 * var_5;
  var_8 = var_6 * var_6;
  var_9 = 60;
  var_10 = 40;
  var_11 = 11;

  if(issubstr(var_1, "_uts19_")) {
    thread uts19shock(var_0);
  } else {
    var_12 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    switch (var_12) {
      case "stun_grenade_var_mp":
      case "stun_grenade_mp":
      case "stun_grenade_horde_mp":
        var_13 = var_0.origin;
        var_14 = distancesquared(var_13, self.origin);

        if(var_14 > var_7) {
          return;
        }
        var_15 = self sightconetrace(var_13);

        if(var_15 < 0.5) {
          return;
        }
        if(var_14 <= var_8) {
          var_16 = 1.0;
        } else {
          var_16 = 1.0 - (var_14 - var_8) / (var_7 - var_8);
        }

        var_17 = anglesToForward(self getangles());
        var_18 = self.origin;

        switch (self getstance()) {
          case "stand":
            var_18 = (var_18[0], var_18[1], var_18[2] + var_9);
            break;
          case "crouch":
            var_18 = (var_18[0], var_18[1], var_18[2] + var_10);
            break;
          case "prone":
            var_18 = (var_18[0], var_18[1], var_18[2] + var_11);
            break;
        }

        var_19 = var_13 - var_18;
        var_19 = vectornormalize(var_19);
        var_20 = 0.5 * (1.0 + vectordot(var_17, var_19));

        if(!isDefined(var_0)) {
          return;
        } else if(var_2 == "MOD_IMPACT") {
          return;
        }
        var_21 = 1;

        if(isDefined(var_0.owner) && var_0.owner == var_4) {
          var_21 = 0;
        }

        var_22 = 3;

        if(isDefined(self.stunscaler)) {
          var_22 = var_22 * self.stunscaler;
        }

        wait 0.05;
        self notify("concussed", var_4);

        if(var_4 != self) {
          var_4 maps\mp\gametypes\_missions::processchallenge("ch_alittleconcussed");
        }

        var_23 = var_16 * var_20 * var_22;
        self shellshock("stun_grenade_mp", var_23, 0, 1, var_16 * var_22);
        self.concussionendtime = gettime() + var_22 * 1000;

        if(var_23 > 0.1) {
          thread maps\mp\_utility::light_set_override_for_player("flashed", 0.1, 0.1, var_16 * var_20 * var_22 - 0.1);
        }

        if(var_21 && var_4 != self) {
          var_4 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("stun");
        }

        break;
      case "concussion_grenade_mp":
        if(!isDefined(var_0)) {
          return;
        } else if(var_2 == "MOD_IMPACT") {
          return;
        }
        var_21 = 1;

        if(isDefined(var_0.owner) && var_0.owner == var_4) {
          var_21 = 0;
        }

        var_24 = 512;
        var_25 = 1 - distance(self.origin, var_0.origin) / var_24;

        if(var_25 < 0) {
          var_25 = 0;
        }

        var_22 = 2 + 4 * var_25;

        if(isDefined(self.stunscaler)) {
          var_22 = var_22 * self.stunscaler;
        }

        wait 0.05;
        self notify("concussed", var_4);

        if(var_4 != self) {
          var_4 maps\mp\gametypes\_missions::processchallenge("ch_alittleconcussed");
        }

        self shellshock("concussion_grenade_mp", var_22);
        self.concussionendtime = gettime() + var_22 * 1000;

        if(var_21 && var_4 != self) {
          var_4 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("stun");
        }

        break;
      case "weapon_cobra_mk19_mp":
        break;
      default:
        maps\mp\gametypes\_shellshock::shellshockondamage(var_2, var_3);
        break;
    }
  }
}

uts19shock(var_0) {
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

  if(isDefined(self.utsshockqueuedtime)) {
    if(self.utsshockqueuedtime >= var_7) {
      return;
    }
  }

  self.utsshockqueuedtime = var_7;
  self shellshock("uts19_mp", var_7);
  waittillframeend;

  if(isDefined(self)) {
    self.utsshockqueuedtime = undefined;
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
    case "rocketlauncher":
    case "beam":
    case "smg":
    case "mg":
    case "pistol":
    case "rifle":
    case "sniper":
    case "spread":
      return 1;
    default:
      return 0;
  }
}

isbulletweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  switch (maps\mp\_utility::getweaponclass(var_0)) {
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
      return 1;
    case "weapon_heavy":
      return issubstr(var_0, "exoxmg") || issubstr(var_0, "lsat") || issubstr(var_0, "asaw") || issubstr(var_0, "dlcgun2_mp") || issubstr(var_0, "dlcgun2loot");
    case "weapon_special":
      return issubstr(var_0, "dlcgun3_mp") || issubstr(var_0, "dlcgun3loot") || issubstr(var_0, "dlcgun5loot5");
    default:
      return 0;
  }
}

isbeamweapon(var_0) {
  return issubstr(var_0, "em1") || issubstr(var_0, "epm3") || issubstr(var_0, "dlcgun1_") || issubstr(var_0, "dlcgun1loot") || issubstr(var_0, "dlcgun9loot6");
}

isaltmodeweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "altmode";
}

isinventoryweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "item";
}

isriotshield(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weapontype(var_0) == "riotshield";
}

isoffhandweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "offhand";
}

issidearm(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  return weaponclass(var_0) == "pistol";
}

isgrenade(var_0) {
  var_1 = weaponclass(var_0);
  var_2 = weaponinventorytype(var_0);

  if(var_1 != "grenade") {
    return 0;
  }

  if(var_2 != "offhand") {
    return 0;
  }

  return 1;
}

isvalidlastweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  var_1 = weaponinventorytype(var_0);
  return var_1 == "primary" || var_1 == "altmode";
}

updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.currentweaponatspawn;
  self.saved_lastweapon = var_0;
  setweaponusagevariables(var_0);

  for(;;) {
    self waittill("weapon_change", var_1);
    updateweaponusagestats(var_1);

    if(isvalidmovespeedscaleweapon(var_1)) {
      updatemovespeedscale();
    }

    self.saved_lastweapon = var_0;

    if(isvalidlastweapon(var_1)) {
      var_0 = var_1;
    }
  }
}

updateweaponusagestats(var_0) {
  var_1 = int((gettime() - self.weaponusagestarttime) / 1000);
  thread setweaponstat(self.weaponusagename, var_1, "timeInUse");
  setweaponusagevariables(var_0);
}

setweaponusagevariables(var_0) {
  self.weaponusagename = var_0;
  self.weaponusagestarttime = gettime();
}

empplayer(var_0) {
  self endon("disconnect");
  self endon("death");
  thread clearempondeath();
}

clearempondeath() {
  self endon("disconnect");
  self waittill("death");
}

getweaponheaviestvalue() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponweight(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }

    if(var_0 > 10) {
      var_0 = 10;
    }
  } else {
    var_0 = 8;
  }

  var_0 = clampweaponweightvalue(var_0);
  return var_0;
}

getweaponweight(var_0) {
  var_1 = undefined;
  var_2 = maps\mp\_utility::getbaseweaponname(var_0);

  if(isDefined(level.weaponweightfunc)) {
    return [[level.weaponweightfunc]](var_2);
  }

  var_1 = int(tablelookup("mp/statstable.csv", 4, var_2, 8));
  return var_1;
}

clampweaponweightvalue(var_0) {
  return clamp(var_0, 0.0, 10.0);
}

isvalidmovespeedscaleweapon(var_0) {
  if(isvalidlastweapon(var_0)) {
    return 1;
  }

  var_1 = weaponclass(var_0);

  if(var_1 == "ball") {
    return 1;
  }

  return 0;
}

updatemovespeedscale() {
  var_0 = undefined;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size) {
    var_0 = 8;
  } else {
    var_1 = self getcurrentweapon();

    if(!isvalidmovespeedscaleweapon(var_1)) {
      if(isDefined(self.saved_lastweapon)) {
        var_1 = self.saved_lastweapon;
      } else {
        var_1 = undefined;
      }
    }

    if(!isDefined(var_1) || !self hasweapon(var_1)) {
      var_0 = getweaponheaviestvalue();
    } else if(maps\mp\_utility::getbaseweaponname(var_1) == "iw5_underwater") {
      var_0 = 5;
    } else {
      var_0 = getweaponweight(var_1);
      var_0 = clampweaponweightvalue(var_0);
    }
  }

  var_2 = var_0 / 10;
  self.weaponspeed = var_2;
  self setmovespeedscale(var_2 * self.movespeedscaler);
}

stancerecoiladjuster() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  for(;;) {
    common_scripts\utility::waittill_any("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
    self.stance = self getstance();

    if(self.stance == "prone") {
      var_0 = self getcurrentprimaryweapon();
      var_1 = maps\mp\_utility::getweaponclass(var_0);

      if(var_1 == "weapon_lmg") {
        maps\mp\_utility::setrecoilscale(0, 40);
      } else if(var_1 == "weapon_sniper") {
        maps\mp\_utility::setrecoilscale(0, 60);
      } else {
        maps\mp\_utility::setrecoilscale();
      }

      continue;
    }

    if(self.stance == "crouch") {
      var_0 = self getcurrentprimaryweapon();
      var_1 = maps\mp\_utility::getweaponclass(var_0);

      if(var_1 == "weapon_lmg") {
        maps\mp\_utility::setrecoilscale(0, 10);
      } else if(var_1 == "weapon_sniper") {
        maps\mp\_utility::setrecoilscale(0, 30);
      } else {
        maps\mp\_utility::setrecoilscale();
      }

      continue;
    }

    maps\mp\_utility::setrecoilscale();
  }
}

buildweapondata(var_0) {}

monitorsemtex() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(!isDefined(var_0.weaponname)) {
      continue;
    }
    if(!issubstr(var_0.weaponname, "semtex")) {
      continue;
    }
    var_0 thread monitorsemtexstick();
  }
}

monitorsemtexstick() {
  self.owner endon("disconnect");
  self.owner endon("death");
  self.owner endon("faux_spawn");
  self waittill("missile_stuck", var_0);
  thread stickyhandlemovers("detonate");

  if(!isPlayer(var_0)) {
    return;
  }
  if(self.owner isstucktofriendly(var_0)) {
    self.owner.isstuck = "friendly";
    return;
  }

  self.isstuck = "enemy";
  self.stuckenemyentity = var_0;
  self.owner maps\mp\_events::semtexstickevent(var_0);
  self.owner notify("process", "ch_bullseye");
}

isstucktofriendly(var_0) {
  return level.teambased && isDefined(var_0.team) && var_0.team == self.team;
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
  if(!isDefined(var_3)) {
    var_3 = (0, randomfloat(360), 0);
  }

  var_5 = "projectile_bouncing_betty_grenade";
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_3;
  var_6 setModel(var_5);
  var_6.owner = var_1;
  var_6.stunned = 0;
  var_6 setotherent(var_1);
  var_6.weaponname = "bouncingbetty_mp";
  level.mines[level.mines.size] = var_6;
  var_6.killcamoffset = (0, 0, 4);
  var_6.killcament = spawn("script_model", var_6.origin + var_6.killcamoffset);
  var_6.killcament setscriptmoverkillcam("explosive");
  var_1.equipmentmines = common_scripts\utility::array_removeundefined(var_1.equipmentmines);

  if(var_1.equipmentmines.size >= level.maxperplayerexplosives) {
    var_1.equipmentmines[0] delete();
  }

  var_1.equipmentmines[var_1.equipmentmines.size] = var_6;
  var_6 thread createbombsquadmodel("projectile_bouncing_betty_grenade_bombsquad", "tag_origin", var_1);
  var_6 thread minebeacon();
  var_6 thread setmineteamheadicon(var_1.pers["team"]);
  var_6 thread minedamagemonitor();
  var_6 thread mineproximitytrigger();
  var_7 = self getlinkedparent();

  if(isDefined(var_7)) {
    var_6 linkto(var_7);
  }

  var_6 makeexplosivetargetablebyai(!var_4);
  return var_6;
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

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(isDefined(var_9) && var_9 == "bouncingbetty_mp") {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      var_10 = maps\mp\_utility::strip_suffix(var_9, "_lefthand");

      switch (var_10) {
        case "smoke_grenade_var_mp":
        case "smoke_grenade_mp":
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

  if(isPlayer(var_0)) {
    var_0 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("bouncing_betty");
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self.owner)) {
      var_11 = var_0.pers["team"];
      var_12 = self.owner.pers["team"];

      if(isDefined(var_11) && isDefined(var_12) && var_11 != var_12) {
        var_0 notify("destroyed_explosive");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var_0) && var_0 != self.owner) {
    var_0 notify("destroyed_explosive");
  }

  thread mineexplode(var_0);
}

mineproximitytrigger() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait 2;
  var_0 = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var_0.owner = self;
  thread minedeletetrigger(var_0);
  var_1 = undefined;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(self.stunned) {
      continue;
    }
    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.owner)) {
        if(var_1 == self.owner) {
          continue;
        }
        if(isDefined(var_1.owner) && var_1.owner == self.owner) {
          continue;
        }
      }

      if(!friendlyfirecheck(self.owner, var_1, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_1 getentityvelocity()) < 10) {
      continue;
    }
    if(var_1 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound("mine_betty_click");

  if(isPlayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_delaymine")) {
    var_1 notify("triggered_mine");
    wait(level.delayminetime);
  } else {
    wait(level.minedetectiongraceperiod);
  }

  thread minebounce();
}

minedeletetrigger(var_0) {
  common_scripts\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  var_0 delete();
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.mineselfdestructtime);
  wait(randomfloat(0.4));
  self notify("mine_selfdestruct");
  thread mineexplode();
}

minebounce() {
  self playSound("mine_betty_spin");
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
  thread mineexplode();
}

mineexplode(var_0) {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self playSound("null");
  var_1 = self gettagorigin("tag_fx");
  playFX(level.mine_explode, var_1);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();
  self radiusdamage(self.origin, level.minedamageradius, level.minedamagemax, level.minedamagemin, var_0, "MOD_EXPLOSIVE");

  if(isDefined(self.owner) && isDefined(level.leaderdialogonplayer_func)) {
    self.owner thread[[level.leaderdialogonplayer_func]]("mine_destroyed", undefined, undefined, self.origin);
  }

  wait 0.2;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self.killcament delete();
  self delete();
}

minestunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;
  playFXOnTag(common_scripts\utility::getfx("mine_stunned"), self, "tag_origin");
}

minestunend() {
  self.stunned = 0;
  stopFXOnTag(common_scripts\utility::getfx("mine_stunned"), self, "tag_origin");
}

minechangeowner(var_0) {
  if(isDefined(self.weaponname)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    if(self.weaponname == "bouncingbetty_mp") {
      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      if(isDefined(self.effect["friendly"])) {
        self.effect["friendly"] delete();
      }

      if(isDefined(self.effect["enemy"])) {
        self.effect["enemy"] delete();
      }

      for(var_1 = 0; var_1 < self.owner.equipmentmines.size; var_1++) {
        if(self.owner.equipmentmines[var_1] == self) {
          self.owner.equipmentmines[var_1] = undefined;
        }
      }

      self.owner.equipmentmines = common_scripts\utility::array_removeundefined(self.owner.equipmentmines);
      self notify("change_owner");
      self.owner = var_0;
      self.owner.equipmentmines[self.owner.equipmentmines.size] = self;
      self.team = var_0.team;
      self setotherent(var_0);
      self.trigger = spawn("script_origin", self.origin + (0, 0, 25));
      self.trigger.owner = self;
      equipmentdisableuse(var_0);
      thread minebeacon();
      thread setmineteamheadicon(var_0.team);
      var_0 thread minewatchownerdisconnect(self);
      var_0 thread minewatchownerchangeteams(self);
    } else if(self.weaponname == "claymore_mp") {
      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      for(var_1 = 0; var_1 < self.owner.claymorearray.size; var_1++) {
        if(self.owner.claymorearray[var_1] == self) {
          self.owner.claymorearray[var_1] = undefined;
        }
      }

      self.owner.claymorearray = common_scripts\utility::array_removeundefined(self.owner.claymorearray);
      self notify("change_owner");
      self.owner = var_0;
      self.owner.claymorearray[self.owner.claymorearray.size] = self;
      self.team = var_0.team;
      self setotherent(var_0);
      self.trigger = spawn("script_origin", self.origin);
      self.trigger.owner = self;
      equipmentdisableuse(var_0);
      thread setmineteamheadicon(var_0.team);
      var_0 thread minewatchownerdisconnect(self);
      var_0 thread minewatchownerchangeteams(self);
      thread claymoredetonation();
    } else if(self.weaponname == "c4_mp") {
      var_2 = 0;
      var_3 = 0;

      for(var_1 = 0; var_1 < self.owner.manuallydetonatedarray.size; var_1++) {
        if(self.owner.manuallydetonatedarray[var_1][0] == self) {
          self.owner.manuallydetonatedarray[var_1][0] = undefined;
          var_2 = self.owner.manuallydetonatedarray[var_1][1];
          var_3 = self.owner.manuallydetonatedarray[var_1][2];
        }
      }

      self.owner.manuallydetonatedarray = manuallydetonated_removeundefined(self.owner.manuallydetonatedarray);
      self notify("change_owner");
      self.owner = var_0;
      var_4 = self.owner.manuallydetonatedarray.size;
      self.owner.manuallydetonatedarray[var_4] = [];
      self.owner.manuallydetonatedarray[var_4][0] = self;
      self.owner.manuallydetonatedarray[var_4][1] = var_2;
      self.owner.manuallydetonatedarray[var_4][2] = var_3;
      self.team = var_0.team;
      self setotherent(var_0);
      equipmentdisableuse(var_0);
      thread setmineteamheadicon(var_0.team);
    }
  }
}

playspinnerfx() {
  self endon("death");
  var_0 = gettime() + 1000;

  while(gettime() < var_0) {
    wait 0.05;
    playFXOnTag(level.mine_spin, self, "tag_fx_spin1");
    playFXOnTag(level.mine_spin, self, "tag_fx_spin3");
    wait 0.05;
    playFXOnTag(level.mine_spin, self, "tag_fx_spin2");
    playFXOnTag(level.mine_spin, self, "tag_fx_spin4");
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
  var_10 = distancesquared(var_0, var_1);

  if(var_10 > var_2) {
    var_7 = 0;
  } else {
    var_7 = 1;
  }

  thread debugline(var_8, var_9, var_6[var_7]);
}

minedamageheightpassed(var_0, var_1) {
  if(isPlayer(var_1) && isalive(var_1) && var_1.sessionstate == "playing") {
    var_2 = var_1 maps\mp\_utility::getstancecenter();
  } else if(var_1.classname == "misc_turret") {
    var_2 = var_1.origin + (0, 0, 32);
  } else {
    var_2 = var_1.origin;
  }

  var_3 = 0;
  var_4 = var_0.origin[2] + var_3 + level.minedamagehalfheight;
  var_5 = var_0.origin[2] + var_3 - level.minedamagehalfheight;

  if(var_2[2] > var_4 || var_2[2] < var_5) {
    return 0;
  }

  return 1;
}

watchslide() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  for(;;) {
    self.issiliding = 0;
    self waittill("sprint_slide_begin");
    self.issiliding = 1;
    self.lastslidetime = gettime();
    self waittill("sprint_slide_end");
  }
}

watchmineusage() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  if(isDefined(self.equipmentmines)) {
    if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1) {
      if(isDefined(self.dont_delete_mines_on_next_spawn)) {
        self.dont_delete_mines_on_next_spawn = undefined;
      } else {
        delete_all_mines();
      }
    }
  } else {
    self.equipmentmines = [];
  }

  if(!isDefined(self.killstreakmines)) {
    self.killstreakmines = [];
  }

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "bouncingbetty" || var_1 == "bouncingbetty_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
      var_0 thread minethrown(self, 1);
    }
  }
}

minethrown(var_0, var_1) {
  self.owner = var_0;
  self waittill("missile_stuck");

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_3 = var_2["position"];

  if(var_2["fraction"] == 1) {
    var_3 = getgroundposition(self.origin, 12, 0, 32);
    var_2["normal"] = var_2["normal"] * -1;
  }

  var_4 = vectornormalize(var_2["normal"]);
  var_5 = vectortoangles(var_4);
  var_5 = var_5 + (90, 0, 0);
  var_6 = spawnmine(var_3, var_0, undefined, var_5, var_1);
  var_6.trigger = spawn("script_origin", var_6.origin + (0, 0, 25));
  var_6.trigger.owner = var_6;
  var_6 thread equipmentwatchuse(var_0);
  var_0 thread minewatchownerdisconnect(var_6);
  var_0 thread minewatchownerchangeteams(var_6);
  self delete();
}

minewatchownerdisconnect(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("change_owner");
  self waittill("disconnect");

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  var_0 delete();
}

minewatchownerchangeteams(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("change_owner");
  common_scripts\utility::waittill_either("joined_team", "joined_spectators");

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  var_0 delete();
}

minebeacon() {
  self endon("change_owner");
  self.effect["friendly"] = spawnfx(level.mine_beacon["friendly"], self gettagorigin("tag_fx"));
  self.effect["enemy"] = spawnfx(level.mine_beacon["enemy"], self gettagorigin("tag_fx"));
  thread minebeaconteamupdater();
  self waittill("death");
  self.effect["friendly"] delete();
  self.effect["enemy"] delete();
}

minebeaconteamupdater() {
  self endon("death");
  self endon("change_owner");
  var_0 = self.owner.team;
  wait 0.05;
  triggerfx(self.effect["friendly"]);
  triggerfx(self.effect["enemy"]);

  for(;;) {
    self.effect["friendly"] hide();
    self.effect["enemy"] hide();

    foreach(var_2 in level.players) {
      if(level.teambased) {
        if(var_2.team == var_0) {
          self.effect["friendly"] showtoplayer(var_2);
        } else {
          self.effect["enemy"] showtoplayer(var_2);
        }

        continue;
      }

      if(var_2 == self.owner) {
        self.effect["friendly"] showtoplayer(var_2);
        continue;
      }

      self.effect["enemy"] showtoplayer(var_2);
    }

    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

delete_all_grenades() {
  if(isDefined(self.manuallydetonatedarray)) {
    for(var_0 = 0; var_0 < self.manuallydetonatedarray.size; var_0++) {
      if(isDefined(self.manuallydetonatedarray[var_0][0])) {
        if(isDefined(self.manuallydetonatedarray[var_0][0].trigger)) {
          self.manuallydetonatedarray[var_0][0].trigger delete();
        }

        self.manuallydetonatedarray[var_0][0] delete();
      }
    }
  }

  self.manuallydetonatedarray = [];

  if(isDefined(self.claymorearray)) {
    for(var_0 = 0; var_0 < self.claymorearray.size; var_0++) {
      if(isDefined(self.claymorearray[var_0])) {
        if(isDefined(self.claymorearray[var_0].trigger)) {
          self.claymorearray[var_0].trigger delete();
        }

        self.claymorearray[var_0] delete();
      }
    }
  }

  self.claymorearray = [];

  if(isDefined(self.bouncingbettyarray)) {
    for(var_0 = 0; var_0 < self.bouncingbettyarray.size; var_0++) {
      if(isDefined(self.bouncingbettyarray[var_0])) {
        if(isDefined(self.bouncingbettyarray[var_0].trigger)) {
          self.bouncingbettyarray[var_0].trigger delete();
        }

        self.bouncingbettyarray[var_0] delete();
      }
    }
  }

  self.bouncingbettyarray = [];
}

delete_all_mines() {
  if(isDefined(self.equipmentmines)) {
    self.equipmentmines = common_scripts\utility::array_removeundefined(self.equipmentmines);

    foreach(var_1 in self.equipmentmines) {
      if(isDefined(var_1.trigger)) {
        var_1.trigger delete();
      }

      var_1 delete();
    }
  }
}

transfer_grenade_ownership(var_0) {
  var_0 delete_all_grenades();
  var_0 delete_all_mines();

  if(isDefined(self.manuallydetonatedarray)) {
    var_0.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
  } else {
    var_0.manuallydetonatedarray = undefined;
  }

  if(isDefined(self.claymorearray)) {
    var_0.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
  } else {
    var_0.claymorearray = undefined;
  }

  if(isDefined(self.bouncingbettyarray)) {
    var_0.bouncingbettyarray = common_scripts\utility::array_removeundefined(self.bouncingbettyarray);
  } else {
    var_0.bouncingbettyarray = undefined;
  }

  if(isDefined(self.equipmentmines)) {
    var_0.equipmentmines = common_scripts\utility::array_removeundefined(self.equipmentmines);
  } else {
    var_0.equipmentmines = undefined;
  }

  if(isDefined(self.killstreakmines)) {
    var_0.killstreakmines = common_scripts\utility::array_removeundefined(self.killstreakmines);
  } else {
    var_0.killstreakmines = undefined;
  }

  if(isDefined(var_0.manuallydetonatedarray)) {
    foreach(var_2 in var_0.manuallydetonatedarray) {
      var_2[0].owner = var_0;
      var_2[0] thread equipmentwatchuse(var_0);
    }
  }

  if(isDefined(var_0.claymorearray)) {
    foreach(var_5 in var_0.claymorearray) {
      var_5.owner = var_0;
      var_5 thread equipmentwatchuse(var_0);
    }
  }

  if(isDefined(var_0.bouncingbettyarray)) {
    foreach(var_8 in var_0.bouncingbettyarray) {
      var_8.owner = var_0;
      var_8 thread equipmentwatchuse(var_0);
    }
  }

  if(isDefined(var_0.equipmentmines)) {
    foreach(var_11 in var_0.equipmentmines) {
      var_11.owner = var_0;
      var_11 thread equipmentwatchuse(var_0);
    }
  }

  if(isDefined(var_0.killstreakmines)) {
    foreach(var_14 in var_0.killstreakmines) {
      var_14.owner = var_0;
      var_14 thread equipmentwatchuse(var_0);
    }
  }

  self.manuallydetonatedarray = [];
  self.claymorearray = [];
  self.bouncingbettyarray = [];
  self.equipmentmines = [];
  self.killstreakmines = [];
  self.dont_delete_grenades_on_next_spawn = 1;
  self.dont_delete_mines_on_next_spawn = 1;
}

update_em1_heat_omnvar() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(issubstr(var_0, "em1") || issubstr(var_0, "epm3") || issubstr(var_0, "dlcgun1_") || issubstr(var_0, "dlcgun1loot") || issubstr(var_0, "dlcgun9loot6") || issubstr(var_0, "dlcgun10loot6") || issubstr(var_0, "dlcgun10loot4")) {
      var_1 = self getweaponheatlevel(var_0);
      self setclientomnvar("ui_em1_heat", var_1);
    }

    wait 0.05;
  }
}

equipmentdeathvfx() {
  playFX(common_scripts\utility::getfx("equipment_sparks"), self.origin);
  self playSound("sentry_explode");
}

equipmentdeletevfx() {
  playFX(common_scripts\utility::getfx("equipment_explode_big"), self.origin);
  playFX(common_scripts\utility::getfx("equipment_smoke"), self.origin);
}

equipmentempstunvfx() {
  playFXOnTag(common_scripts\utility::getfx("emp_stun"), self, "tag_origin");
}

track_damage_info() {
  self.damage_info = [];
  thread reset_damage_info_when_healed();
}

reset_damage_info_when_healed() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    if(self.health >= 100 && isDefined(self.damage_info) && self.damage_info.size > 0) {
      self.damage_info = [];
    }

    wait 0.05;
  }
}

stickyhandlemovers(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_2.notifystring = var_0;
  }

  if(isDefined(var_1)) {
    var_2.endonstring = var_1;
  }

  var_2.deathoverridecallback = ::stickymovingplatformdetonate;
  thread maps\mp\_movers::handle_moving_platforms(var_2);
}

stickymovingplatformdetonate(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  if(isDefined(self)) {
    if(isDefined(var_0.notifystring)) {
      if(var_0.notifystring == "detonate") {
        self detonate();
      } else {
        self notify(var_0.notifystring);
      }
    } else {
      self delete();
    }
  }
}

getgrenadegraceperiodtimeleft() {
  var_0 = 10;

  if(isDefined(level.grenadegraceperiod)) {
    var_0 = level.grenadegraceperiod;
  }

  var_1 = 0;

  if(isDefined(level.prematch_done_time)) {
    var_1 = (gettime() - level.prematch_done_time) / 1000;
  }

  return var_0 - var_1;
}

ingrenadegraceperiod() {
  return getgrenadegraceperiodtimeleft() > 0;
}

isweaponallowedingrenadegraceperiod(var_0) {
  if(isendstr(var_0, "_gl")) {
    return 0;
  }

  switch (var_0) {
    case "frag_grenade_mp_lefthand":
    case "explosive_drone_mp_lefthand":
    case "semtex_mp_lefthand":
    case "explosive_drone_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 0;
    default:
      break;
  }

  var_1 = getweaponbasename(var_0);

  if(isDefined(var_1)) {
    switch (var_1) {
      case "iw5_stingerm7_mp":
      case "iw5_microdronelauncher_mp":
      case "iw5_exocrossbow_mp":
      case "iw5_maaws_mp":
      case "iw5_mahem_mp":
        return 0;
      default:
        break;
    }
  }

  return 1;
}

watchgrenadegraceperiod() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    [var_1, var_2, var_3] = common_scripts\utility::waittill_any_return_parms("grenade_fire", "missile_fire");

    if(!isDefined(var_3) || var_3 == "") {
      continue;
    }
    if(ingrenadegraceperiod()) {
      if(!isweaponallowedingrenadegraceperiod(var_3)) {
        var_4 = int(getgrenadegraceperiodtimeleft() + 0.5);

        if(!var_4) {
          var_4 = 1;
        }

        if(isPlayer(self)) {
          self iprintlnbold(&"MP_EXPLOSIVES_UNAVAILABLE_FOR_N", var_4);
        }
      }

      continue;
    }

    break;
  }
}

isprimaryorsecondaryprojectileweapon(var_0) {
  var_1 = maps\mp\_utility::getweaponclass(var_0);
  var_2 = maps\mp\_utility::getbaseweaponname(var_0);

  if(var_1 == "weapon_projectile") {
    return 1;
  }

  if(isDefined(var_2) && (issubstr(var_2, "microdronelauncher") || issubstr(var_2, "exocrossbow"))) {
    return 1;
  }

  return 0;
}

saveweapon(var_0, var_1, var_2) {
  var_3 = self.saveweapons.size;

  if(var_3 == 0) {
    self.firstsaveweapon = var_1;
  }

  self.saveweapons[var_3]["type"] = var_0;
  self.saveweapons[var_3]["use"] = var_2;
}

getsavedweapon(var_0) {
  var_1 = self.saveweapons.size;
  var_2 = -1;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(self.saveweapons[var_3]["type"] == var_0) {
      var_2 = var_3;
      break;
    }
  }

  if(var_2 >= 0) {
    return self.saveweapons[var_2]["use"];
  } else {
    return "none";
  }
}

restoreweapon(var_0) {
  var_1 = [];
  var_2 = self.saveweapons.size;
  var_3 = -1;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    if(var_3 < 0 && self.saveweapons[var_5]["type"] == var_0) {
      var_3 = var_5;
      continue;
    }

    var_1[var_4] = self.saveweapons[var_5];
    var_4++;
  }

  if(var_3 >= 0) {
    var_6 = "none";

    if(var_1.size == 0) {
      var_6 = self.firstsaveweapon;
      self.saveweapons = var_1;
      self.firstsaveweapon = "none";
    } else {
      self.saveweapons = var_1;
      var_6 = getsavedweapon("underwater");

      if(var_6 == "none") {
        var_6 = self.saveweapons[0]["use"];
      }
    }

    var_7 = self getcurrentweapon();

    if(var_7 != var_6) {
      self switchtoweaponimmediate(var_6);
    }
  }
}