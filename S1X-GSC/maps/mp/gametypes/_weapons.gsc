/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_weapons.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_equipment;
#include maps\mp\gametypes\_scrambler;
#include maps\mp\gametypes\_portable_radar;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\_tracking_drone;
#include maps\mp\_explosive_drone;

init() {
    SetDvarIfUninitialized("scr_allow_weightless_weapons", 0);

    level.scavenger_altmode = true;
    level.scavenger_secondary = true;

    level.maxPerPlayerExplosives = max(getIntProperty("scr_maxPerPlayerExplosives", 2), 1);
    level.riotShieldXPBullets = getIntProperty("scr_riotShieldXPBullets", 15);
    CreateThreatBiasGroup("DogsDontAttack");
    CreateThreatBiasGroup("Dogs");
    SetIgnoreMeGroup("DogsDontAttack", "Dogs");

    switch (getIntProperty("perk_scavengerMode", 0)) {
      case 1:
        level.scavenger_altmode = false;
        break;

      case 2:
        level.scavenger_secondary = false;
        break;

      case 3:
        level.scavenger_altmode = false;
        level.scavenger_secondary = false;
        break;
    }
    gametype = getDvar("g_gametype");
    attachmentList = getAttachmentListBaseNames();
    attachmentList = alphabetize(attachmentList);

    max_weapon_num = 150;

    level.weaponList = [];
    level.weaponAttachments = [];
    for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
      weapon_name = tablelookup("mp/statstable.csv", 0, weaponId, 4);

      if(weapon_name == "") {
        continue;
      }

      if(tableLookup("mp/statsTable.csv", 0, weaponId, 51) != "") {
        continue;
      }

      if(!isSubStr(tableLookup("mp/statsTable.csv", 0, weaponId, 2), "weapon_")) {
        continue;
      }

      if(IsSubStr(weapon_name, "iw5") || IsSubStr(weapon_name, "iw6")) {
        weaponTokens = getWeaponNameTokens(weapon_name);
        weapon_name = weaponTokens[0] + "_" + weaponTokens[1] + "_mp";

        level.weaponList[level.weaponList.size] = weapon_name;
        continue;
      } else {
        level.weaponList[level.weaponList.size] = weapon_name + "_mp";
      }

      if(getDvar("scr_dump_weapon_assets") != "") {
        printLn("");
        printLn("printLn("weapon, mp / " + weapon_name + "_mp ");
        }

        attachmentNames = getWeaponAttachmentArrayFromStats(weapon_name);

        attachments = [];
        foreach(attachmentName in attachmentList) {
          if(!isDefined(attachmentNames[attachmentName])) {
            continue;
          }

          level.weaponList[level.weaponList.size] = weapon_name + "_" + attachmentName + "_mp";
          attachments[attachments.size] = attachmentName;

          if(getDvar("scr_dump_weapon_assets") != "") {
            println("weapon,mp/" + weapon_name + "_" + attachmentName + "_mp");
          }
        }

        attachmentCombos = [];
        for(i = 0; i < (attachments.size - 1); i++) {
          colIndex = tableLookupRowNum("mp/attachmentCombos.csv", 0, attachments[i]);
          for(j = i + 1; j < attachments.size; j++) {
            if(tableLookup("mp/attachmentCombos.csv", 0, attachments[j], colIndex) == "no") {
              continue;
            }

            attachmentCombos[attachmentCombos.size] = attachments[i] + "_" + attachments[j];
          }
        }

        if(getDvar("scr_dump_weapon_assets") != "" && attachmentCombos.size) {
          println("foreach(combo in attachmentCombos) {
          }
          if(getDvar("scr_dump_weapon_assets") != "") {
            println("weapon,mp/" + weapon_name + "_" + combo + "_mp");
          }

          level.weaponList[level.weaponList.size] = weapon_name + "_" + combo + "_mp";
        }
      }

      if(!isDefined(level.isZombieGame) || !level.isZombieGame) {
        foreach(weaponName in level.weaponList) {
          precacheItem(weaponName);

          if(getDvar("scr_dump_weapon_assets") != "") {
            altWeapon = weaponAltWeaponName(weaponName);
            if(altWeapon != "none") {
              println("weapon,mp/" + altWeapon);
            }
          }

        }
      }

      thread maps\mp\_flashgrenades::main();
      thread maps\mp\_entityheadicons::init();
      thread maps\mp\_empgrenade::init();
      thread maps\mp\_tridrone::init();
      thread maps\mp\_explosive_gel::init();
      thread maps\mp\_exoknife::init();
      thread maps\mp\_riotshield::init();

      if(!isDefined(level.weaponDropFunction)) {
        level.weaponDropFunction = ::dropWeaponForDeath;
      }

      claymoreDetectionConeAngle = 70;
      level.claymoreDetectionDot = cos(claymoreDetectionConeAngle);
      level.claymoreDetectionMinDist = 20;
      level.claymoreDetectionGracePeriod = .75;
      level.claymoreDetonateRadius = 192;

      level.mineDetectionGracePeriod = .3;
      level.mineDetectionRadius = 100;
      level.mineDetectionHeight = 20;
      level.mineDamageRadius = 256;
      level.mineDamageMin = 70;
      level.mineDamageMax = 210;
      level.mineDamageHalfHeight = 46;
      level.mineSelfDestructTime = 120;
      level.mine_launch = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
      level.mine_spin = loadfx("vfx/dust/bouncing_betty_swirl");
      level.mine_explode = loadfx("vfx/explosion/bouncing_betty_explosion");
      level.mine_beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
      level.mine_beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
      level.empGrenadeExplode = loadfx("vfx/explosion/emp_grenade_mp");

      level._effect["mine_stunned"] = Loadfx("vfx/sparks/emp_drone_damage");

      level.delayMineTime = 3.0;

      level.sentry_fire = loadfx("fx/muzzleflashes/shotgunflash");

      level.stingerFXid = loadfx("fx/explosions/aerial_explosion_large");

      level.primary_weapon_array = [];
      level.side_arm_array = [];
      level.grenade_array = [];
      level.missile_array = [];
      level.inventory_array = [];
      level.mines = [];
      level.trophies = [];

      if(!InVirtualLobby()) {
        precacheModel("weapon_claymore_bombsquad");
        precacheModel("weapon_c4_bombsquad");
        precacheModel("projectile_m67fraggrenade_bombsquad");
        precacheModel("projectile_semtex_grenade_bombsquad");
        precacheModel("weapon_light_stick_tactical_bombsquad");
        precacheModel("projectile_bouncing_betty_grenade");
        precacheModel("projectile_bouncing_betty_grenade_bombsquad");
        precacheModel("weapon_jammer");
        precacheModel("weapon_jammer_bombsquad");
        precacheModel("weapon_radar");
        precacheModel("weapon_radar_bombsquad");
        PreCacheModel("mp_trophy_system");
        PreCacheModel("mp_trophy_system_bombsquad");
        PreCacheModel("projectile_semtex_grenade");
        PreCacheModel("npc_variable_grenade_lethal");

        PreCacheLaser("mp_attachment_lasersight");
        PreCacheLaser("mp_attachment_directhack");
        PreCacheLaser("mp_attachment_lasersight_short");

        PreCacheShader("exo_hud_cloak_overlay");

        level._effect["equipment_explode"] = LoadFX("vfx/explosion/sparks_burst_lrg_c");

        level._effect["sniperDustLarge"] = LoadFX("vfx/dust/sniper_dust_kickup");
        level._effect["sniperDustLargeSuppress"] = LoadFX("vfx/dust/sniper_dust_kickup_accum_suppress");
      }

      level thread onPlayerConnect();

      level.c4explodethisframe = false;

      array_thread(getEntArray("misc_turret", "classname"), ::turret_monitorUse);
    }

    dumpIt() {
      wait(5.0);

      max_weapon_num = 149;

      for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
        weapon_name = tablelookup("mp/statstable.csv", 0, weaponId, 4);
        if(weapon_name == "") {
          continue;
        }

        if(!isSubStr(tableLookup("mp/statsTable.csv", 0, weaponId, 2), "weapon_")) {
          continue;
        }

        if(getDvar("scr_dump_weapon_challenges") != "") {
          weaponLStringName = tableLookup("mp/statsTable.csv", 0, weaponId, 3);
          weaponRealName = tableLookupIString("mp/statsTable.csv", 0, weaponId, 3);

          prefix = "WEAPON_";
          weaponCapsName = getSubStr(weaponLStringName, prefix.size, weaponLStringName.size);

          weaponGroup = tableLookup("mp/statsTable.csv", 0, weaponId, 2);

          weaponGroupSuffix = getSubStr(weaponGroup, prefix.size, weaponGroup.size);

          iprintln("cardtitle_" + weapon_name + "_sharpshooter,PLAYERCARDS_TITLE_" + weaponCapsName + "_SHARPSHOOTER,cardtitle_" + weaponGroupSuffix + "_sharpshooter,1,1,1");
          iprintln("cardtitle_" + weapon_name + "_marksman,PLAYERCARDS_TITLE_" + weaponCapsName + "_MARKSMAN,cardtitle_" + weaponGroupSuffix + "_marksman,1,1,1");
          iprintln("cardtitle_" + weapon_name + "_veteran,PLAYERCARDS_TITLE_" + weaponCapsName + "_VETERAN,cardtitle_" + weaponGroupSuffix + "_veteran,1,1,1");
          iprintln("cardtitle_" + weapon_name + "_expert,PLAYERCARDS_TITLE_" + weaponCapsName + "_EXPERT,cardtitle_" + weaponGroupSuffix + "_expert,1,1,1");
          iprintln("cardtitle_" + weapon_name + "_master,PLAYERCARDS_TITLE_" + weaponCapsName + "_MASTER,cardtitle_" + weaponGroupSuffix + "_master,1,1,1");

          wait(0.05);
        }
      }

    }

    bombSquadWaiter() {
      self endon("disconnect");

      for(;;) {
        self waittill("grenade_fire", weaponEnt, weaponName);

        shortWeaponName = maps\mp\_utility::strip_suffix(weaponName, "_lefthand");

        if(shortWeaponName == "c4_mp") {
          weaponEnt thread createBombSquadModel("weapon_c4_bombsquad", "tag_origin", self);
        } else if(shortWeaponName == "claymore_mp") {
          weaponEnt thread createBombSquadModel("weapon_claymore_bombsquad", "tag_origin", self);
        } else if(shortWeaponName == "frag_grenade_mp") {
          weaponEnt thread createBombSquadModel("projectile_m67fraggrenade_bombsquad", "tag_weapon", self);
        } else if(shortWeaponName == "frag_grenade_short_mp") {
          weaponEnt thread createBombSquadModel("projectile_m67fraggrenade_bombsquad", "tag_weapon", self);
        } else if(shortWeaponName == "semtex_mp") {
          weaponEnt thread createBombSquadModel("projectile_semtex_grenade_bombsquad", "tag_weapon", self);
        } else if(shortWeaponName == "thermobaric_grenade_mp") {
          weaponEnt thread createBombSquadModel("projectile_m67fraggrenade_bombsquad", "tag_weapon", self);
        }
      }
    }

    createBombSquadModel(modelName, tagName, owner) {
      bombSquadModel = spawn("script_model", (0, 0, 0));
      bombSquadModel hide();
      wait(0.05);

      if(!isDefined(self)) {
        return;
      }

      bombSquadModel thread bombSquadVisibilityUpdater(owner);
      bombSquadModel setModel(modelName);
      bombSquadModel linkTo(self, tagName, (0, 0, 0), (0, 0, 0));
      bombSquadModel SetContents(0);

      self waittill("death");

      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      bombSquadModel delete();
    }

    bombSquadVisibilityUpdater(owner) {
      self endon("death");

      if(!isDefined(owner)) {
        return;
      }

      teamname = owner.team;

      foreach(player in level.players) {
        if(level.teamBased) {
          if(player.team == "spectator") {
            continue;
          }

          if(player.team != teamName && player _hasPerk("specialty_detectexplosive")) {
            self ShowToPlayer(player);
          }
        } else {
          if(isDefined(owner) && player == owner) {
            continue;
          }

          if(!player _hasPerk("specialty_detectexplosive")) {
            continue;
          }

          self ShowToPlayer(player);
        }
      }

      for(;;) {
        level waittill_any("joined_team", "player_spawned", "changed_kit", "update_bombsquad");

        self hide();

        foreach(player in level.players) {
          if(level.teamBased) {
            if(player.team == "spectator") {
              continue;
            }

            if(player.team != teamName && player _hasPerk("specialty_detectexplosive")) {
              self ShowToPlayer(player);
            }
          } else {
            if(isDefined(owner) && player == owner) {
              continue;
            }

            if(!player _hasPerk("specialty_detectexplosive")) {
              continue;
            }

            self ShowToPlayer(player);
          }
        }
      }
    }

    onPlayerConnect() {
      for(;;) {
        level waittill("connected", player);

        player.hits = 0;
        player.isSiliding = false;

        maps\mp\gametypes\_gamelogic::setHasDoneCombat(player, false);

        if(!InVirtualLobby()) {
          player KC_RegWeaponForFXRemoval("remotemissile_projectile_mp");
          player thread sniperDustWatcher();
        }

        player thread onPlayerSpawned();
        player thread bombSquadWaiter();
        player thread watchMissileUsage();

        player thread update_em1_heat_omnvar();
      }
    }

    onPlayerSpawned() {
      self endon("disconnect");

      for(;;) {
        self waittill_any("spawned_player", "faux_spawn");

        self.currentWeaponAtSpawn = self getCurrentWeapon();

        self.empEndTime = 0;
        self.concussionEndTime = 0;
        self.hits = 0;

        maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, false);

        if(!isDefined(self.trackingWeaponName)) {
          self.trackingWeaponName = "";
          self.trackingWeaponName = "none";
          self.trackingWeaponShots = 0;
          self.trackingWeaponKills = 0;
          self.trackingWeaponHits = 0;
          self.trackingWeaponHeadShots = 0;
          self.trackingWeaponHipFireKills = 0;
          self.trackingWeaponDeaths = 0;
          self.trackingWeaponUseTime = 0;
        }

        self thread watchSlide();
        self thread watchWeaponUsage();
        self thread watchGrenadeUsage();
        self thread watchWeaponChange();
        self thread watchStingerUsage();
        self thread watchWeaponReload();
        self thread watchMineUsage();
        self thread maps\mp\_riotshield::watchRiotShieldUse();
        self thread stanceRecoilAdjuster();
        self thread monitorTIUse();
        self thread maps\mp\_target_enhancer::target_enhancer_think();
        self thread maps\mp\_opticsthermal::opticsthermal_think();
        self thread maps\mp\_stock::stock_think();
        self thread maps\mp\_lasersight::lasersight_think();
        self thread maps\mp\_microdronelauncher::monitor_microdrone_launch();
        self thread maps\mp\_exocrossbow::monitor_exocrossbow_launch();
        self thread maps\mp\_stingerm7::stingerm7_think();
        self thread maps\mp\_trackrounds::trackrounds_think();
        self thread maps\mp\_na45::main();
        self thread maps\mp\_lsrmissileguidance::monitor_lsr_missile_launch();
        self thread maps\mp\_exoknife::exo_knife_think();
        self thread maps\mp\_exo_battery::play_insufficient_tactical_energy_sfx();
        self thread maps\mp\_exo_battery::play_insufficient_lethal_energy_sfx();
        self thread watchGrenadeGracePeriod();
        self thread watchTrackingDroneUsage();
        self thread watchExplosiveDroneUsage();
        if(!InVirtualLobby()) {
          self thread watchSentryUsage();
        }
        if(isDefined(level.onPlayerSpawnedWeaponsFunc)) {
          self thread[[level.onPlayerSpawnedWeaponsFunc]]();
        }

        self.lastHitTime = [];

        self.droppedDeathWeapon = undefined;
        self.tookWeaponFrom = [];
        self.pickedUpWeaponFrom = [];

        self thread updateSavedLastWeapon();

        self thread monitorSemtex();

        self.currentWeaponAtSpawn = undefined;
        self.trophyRemainingAmmo = undefined;

        self thread track_damage_info();

        if(!isDefined(self.spawnInfo)) {
          self.spawnInfo = spawnStruct();
        }

        self.spawnInfo.spawnTime = GetTime();
        self.spawnInfo.damageDealtTooFast = false;
        self.spawnInfo.damageReceivedTooFast = false;
        self.spawnInfo.badSpawn = false;
        spawnTime = self.spawnInfo.spawnTime;

        if(!isDefined(self.num_lives)) {
          self.num_lives = 0;
        }
        self.num_lives++;

        if(IsAgent(self)) {
          return;
        }

        if(isDefined(self.explosive_drone_owner)) {
          self.explosive_drone_owner = undefined;
        }

        CONST_spawn_tuning_version = 0.1;
        version = CONST_spawn_tuning_version;

        script_file = "_matchdata.gsc";

        bRandomSpawn = -1;
        number_of_choices = -1;
        last_update_time = -1;

        if(isDefined(self.spawnInfo)) {
          if(isDefined(self.spawnInfo.spawnPoint)) {
            if(isDefined(self.spawnInfo.spawnPoint.isRandom)) {
              bRandomSpawn = self.spawnInfo.spawnPoint.isRandom;
            }

            if(isDefined(self.spawnInfo.spawnPoint.numberOfPossibleSpawnChoices)) {
              number_of_choices = self.spawnInfo.spawnPoint.numberOfPossibleSpawnChoices;
            }

            if(isDefined(self.spawnInfo.spawnPoint.lastUpdateTime)) {
              last_update_time = self.spawnInfo.spawnPoint.lastUpdateTime;
            }
          }
        }

        ReconSpatialEvent(self.spawnPos, "script_mp_playerspawn: player_name %s, life_id %d, life_index %d, was_tactical_insertion %b, team %s, gameTime %d, version %f, script_file %s, randomSpawn %b, number_of_choices %d, last_update_time %d", self.name, self.lifeId, self.num_lives, self.wasTI, self.team, spawnTime, version, script_file, bRandomSpawn, number_of_choices, last_update_time);
      }
    }

    recordToggleScopeStates() {
      self.pers["toggleScopeStates"] = [];

      weapons = self GetWeaponsListPrimaries();
      foreach(weap in weapons) {
        if(weap == self.primaryWeapon || weap == self.secondaryWeapon) {
          attachments = GetWeaponAttachments(weap);
          foreach(attachment in attachments) {
            if(attachment == "variablereddot") {
              self.pers["toggleScopeStates"][weap] = self GetHybridSightEnabled(weap);
              break;
            }
          }
        }
      }
    }

    sniperDustWatcher() {
      self endon("death");
      self endon("disconnect");
      level endon("game_ended");

      lastLargeShotFiredTime = undefined;

      for(;;) {
        self waittill("weapon_fired");

        if(self GetStance() != "prone") {
          continue;
        }

        if(getWeaponClass(self GetCurrentWeapon()) != "weapon_sniper") {
          continue;
        }

        playerForward = anglesToForward(self.angles);

        if(!isDefined(lastLargeShotFiredTime) || (getTime() - lastLargeShotFiredTime) > 2000) {
          playFX(level._effect["sniperDustLarge"], (self.origin + (0, 0, 10)) + playerForward * 50, playerForward);
          lastLargeShotFiredTime = GetTime();
        } else {
          playFX(level._effect["sniperDustLargeSuppress"], (self.origin + (0, 0, 10)) + playerForward * 50, playerForward);
        }
      }
    }

    WatchStingerUsage() {
      self maps\mp\_stinger::StingerUsageLoop();
    }

    watchWeaponChange() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      self thread watchStartWeaponChange();
      self.lastDroppableWeapon = self.currentWeaponAtSpawn;
      self.hitsThisMag = [];

      weapon = self getCurrentWeapon();

      if(isCACPrimaryWeapon(weapon) && !isDefined(self.hitsThisMag[weapon])) {
        self.hitsThisMag[weapon] = weaponClipSize(weapon);
      }

      self.bothBarrels = undefined;

      if(isSubStr(weapon, "ranger")) {
        self thread watchRangerUsage(weapon);
      }

      while(1) {
        self waittill("weapon_change", weaponName);

        if(weaponName == "none") {
          continue;
        }

        if(isBombSiteWeapon(weaponName)) {
          continue;
        }

        if(isKillstreakWeapon(weaponName)) {
          if(self maps\mp\killstreaks\_killstreaks::canShuffleWithKillstreakWeapon()) {
            self.changingWeapon = undefined;
          }

          continue;
        }

        weaponTokens = getWeaponNameTokens(weaponName);

        self.bothBarrels = undefined;

        if(isSubStr(weaponName, "ranger")) {
          self thread watchRangerUsage(weaponName);
        }

        if(weaponTokens[0] == "alt") {
          tmp = GetSubStr(weaponName, 4);
          weaponName = tmp;
          weaponTokens = getWeaponNameTokens(weaponName);
        }

        if(weaponName != "none" && weaponTokens[0] != "iw5" && weaponTokens[0] != "iw6") {
          if(isCACPrimaryWeapon(weaponName) && !isDefined(self.hitsThisMag[weaponName + "_mp"])) {
            self.hitsThisMag[weaponName + "_mp"] = weaponClipSize(weaponName + "_mp");
          }
        } else if(weaponName != "none" && (weaponTokens[0] == "iw5" || weaponTokens[0] == "iw6")) {
          if(isCACPrimaryWeapon(weaponName) && !isDefined(self.hitsThisMag[weaponName])) {
            self.hitsThisMag[weaponName] = weaponClipSize(weaponName);
          }
        }

        if(mayDropWeapon(weaponName)) {
          self.lastDroppableWeapon = weaponName;
        }

        self.changingWeapon = undefined;
      }
    }

    watchStartWeaponChange() {
      self endon("faux_spawn");
      self endon("death");
      self endon("disconnect");
      self.changingWeapon = undefined;

      while(1) {
        self waittill("weapon_switch_started", newWeapon);

        self thread makeSureWeaponChanges(self GetCurrentWeapon());

        self.changingWeapon = newWeapon;

        if(newWeapon == "none" && isDefined(self.isCapturingCrate) && self.isCapturingCrate) {
          while(self.isCapturingCrate) {
            wait(0.05);
          }

          self.changingWeapon = undefined;
        }
      }
    }

    makeSureWeaponChanges(currentWeapon) {
      self endon("weapon_switch_started");
      self endon("weapon_change");
      self endon("disconnect");
      self endon("death");
      level endon("game_ended");

      if(!(self maps\mp\killstreaks\_killstreaks::canShuffleWithKillstreakWeapon())) {
        return;
      }

      wait(1.0);

      self.changingWeapon = undefined;
    }

    watchWeaponReload() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      for(;;) {
        self waittill("reload");

        weaponName = self getCurrentWeapon();

        self.bothBarrels = undefined;

        if(!isSubStr(weaponName, "ranger")) {
          continue;
        }

        self thread watchRangerUsage(weaponName);
      }
    }

    watchRangerUsage(rangerName) {
      rightAmmo = self getWeaponAmmoClip(rangerName, "right");
      leftAmmo = self getWeaponAmmoClip(rangerName, "left");

      self endon("reload");
      self endon("weapon_change");
      self endon("faux_spawn");

      for(;;) {
        self waittill("weapon_fired", weaponName);

        if(weaponName != rangerName) {
          continue;
        }

        self.bothBarrels = undefined;

        if(isSubStr(rangerName, "akimbo")) {
          newLeftAmmo = self getWeaponAmmoClip(rangerName, "left");
          newRightAmmo = self getWeaponAmmoClip(rangerName, "right");

          if(leftAmmo != newLeftAmmo && rightAmmo != newRightAmmo) {
            self.bothBarrels = true;
          }

          if(!newLeftAmmo || !newRightAmmo) {
            return;
          }

          leftAmmo = newLeftAmmo;
          rightAmmo = newRightAmmo;
        } else if(rightAmmo == 2 && !self getWeaponAmmoClip(rangerName, "right")) {
          self.bothBarrels = true;
          return;
        }
      }
    }

    mayDropWeapon(weapon) {
      if(weapon == "none") {
        return false;
      }

      if(isSubStr(weapon, "uav")) {
        return false;
      }

      if(isSubStr(weapon, "killstreak")) {
        return false;
      }

      if(getWeaponClass(weapon) == "weapon_projectile") {
        return false;
      }

      invType = WeaponInventoryType(weapon);

      if(invType != "primary") {
        return false;
      }

      if(IsSubStr(weapon, "combatknife") || IsSubStr(weapon, "underwater")) {
        return false;
      }

      return true;
    }

    dropWeaponForDeath(attacker, sMeansOfDeath) {
      if(!self isUsingRemote()) {
        waittillframeend;
      }

      if(isDefined(level.blockWeaponDrops)) {
        return;
      }

      if(!isDefined(self)) {
        return;
      }

      if(isDefined(self.droppedDeathWeapon)) {
        return;
      }

      if(level.inGracePeriod) {
        return;
      }

      weapon = self.lastDroppableWeapon;
      if(!isDefined(weapon)) {
        if(getDvar("scr_dropdebug") == "1") {
          println("didn't drop weapon: not defined");
        }

        return;
      }

      if(weapon == "none") {
        if(getDvar("scr_dropdebug") == "1") {
          println("didn't drop weapon: weapon == none");
        }

        return;
      }

      if(!(self hasWeapon(weapon))) {
        if(getDvar("scr_dropdebug") == "1") {
          println("didn't drop weapon: don't have it anymore (" + weapon + ")");
        }

        return;
      }

      if(self isJuggernaut()) {
        return;
      }

      if(isDefined(level.gameModeMayDropWeapon) && !(self[[level.gameModeMayDropWeapon]](weapon))) {
        return;
      }

      tokens = getWeaponNameTokens(weapon);

      if(tokens[0] == "alt") {
        for(i = 0; i < tokens.size; i++) {
          if(i > 0 && i < 2) {
            weapon += (tokens[i]);
          } else if(i > 0) {
            weapon += ("_" + tokens[i]);
          } else {
            weapon = "";
          }
        }
      }

      if(weapon != "riotshield_mp") {
        if(!(self AnyAmmoForWeaponModes(weapon))) {
          if(getDvar("scr_dropdebug") == "1") {
            println("didn't drop weapon: no ammo for weapon modes");
          }

          return;
        }

        clipAmmoR = self GetWeaponAmmoClip(weapon, "right");
        clipAmmoL = self GetWeaponAmmoClip(weapon, "left");
        if(!clipAmmoR && !clipAmmoL) {
          if(getDvar("scr_dropdebug") == "1") {
            println("didn't drop weapon: no ammo in clip");
          }

          return;
        }

        stockAmmo = self GetWeaponAmmoStock(weapon);
        stockMax = WeaponMaxAmmo(weapon);
        if(stockAmmo > stockMax) {
          stockAmmo = stockMax;
        }

        item = self dropItem(weapon);
        if(!isDefined(item)) {
          return;
        }

        if(isMeleeMOD(sMeansOfDeath)) {
          item.origin = (item.origin[0], item.origin[1], item.origin[2] - 5);
        }

        item ItemWeaponSetAmmo(clipAmmoR, stockAmmo, clipAmmoL);
      } else {
        item = self dropItem(weapon);
        if(!isDefined(item)) {
          return;
        }
        item ItemWeaponSetAmmo(1, 1, 0);
      }

      if(getDvar("scr_dropdebug") == "1") {
        println("dropped weapon: " + weapon);
      }

      self.droppedDeathWeapon = true;

      if(maps\mp\_riotshield::weaponIsRiotShield(weapon)) {
        self RefreshShieldModels();
      }

      item.owner = self;
      item.ownersattacker = attacker;
      item.targetname = "dropped_weapon";

      item thread watchPickup();

      item thread deletePickupAfterAWhile();
    }

    detachIfAttached(model, baseTag) {
      attachSize = self getAttachSize();

      for(i = 0; i < attachSize; i++) {
        attach = self getAttachModelName(i);

        if(attach != model) {
          continue;
        }

        tag = self getAttachTagName(i);
        self detach(model, tag);

        if(tag != baseTag) {
          attachSize = self getAttachSize();

          for(i = 0; i < attachSize; i++) {
            tag = self getAttachTagName(i);

            if(tag != baseTag) {
              continue;
            }

            model = self getAttachModelName(i);
            self detach(model, tag);

            break;
          }
        }
        return true;
      }
      return false;
    }

    deletePickupAfterAWhile() {
      self endon("death");

      wait 60;

      if(!isDefined(self)) {
        return;
      }

      self delete();
    }

    getItemWeaponName() {
      classname = self.classname;
      assert(getsubstr(classname, 0, 7) == "weapon_");
      weapname = getsubstr(classname, 7);
      return weapname;
    }

    watchPickup() {
      self endon("death");

      weapname = self getItemWeaponName();
      owner = self.owner;

      while(true) {
        self waittill("trigger", player, droppedItem);

        if(isDefined(weapname) && weapname == player.primaryWeapon) {
          return;
        }

        if(isDefined(weapname) && weapname == player.secondaryWeapon) {
          return;
        }

        player.pickedUpWeaponFrom[weapname] = undefined;
        player.tookWeaponFrom[weapname] = undefined;

        if(isDefined(player.pers["weaponPickupsCount"])) {
          player.pers["weaponPickupsCount"]++;
        }

        if(isDefined(owner) && (owner != player)) {
          if(getDvar("scr_dropdebug") == "1") {
            println("picked up weapon: " + weapname + ", " + owner);
          }

          player.pickedUpWeaponFrom[weapname] = owner;

          if(isDefined(self.ownersattacker) && (self.ownersattacker == player)) {
            player.tookWeaponFrom[weapname] = owner;
          }
        }

        if(isDefined(droppedItem)) {
          break;
        }
      }

      droppedItem.owner = player;
      droppedItem.targetname = "dropped_weapon";
      droppedWeaponName = droppedItem getItemWeaponName();

      if(isDefined(player.primaryWeapon) && player.primaryWeapon == droppedWeaponName) {
        player.primaryWeapon = weapname;
      }

      if(isDefined(player.secondaryWeapon) && player.secondaryWeapon == droppedWeaponName) {
        player.secondaryWeapon = weapname;
      }

      if(isDefined(player.pickedUpWeaponFrom[droppedWeaponName])) {
        droppedItem.owner = player.pickedUpWeaponFrom[droppedWeaponName];
        player.pickedUpWeaponFrom[droppedWeaponName] = undefined;
      }

      if(isDefined(player.tookWeaponFrom[droppedWeaponName])) {
        droppedItem.ownersattacker = player;
        player.tookWeaponFrom[droppedWeaponName] = undefined;
      }

      droppedItem thread watchPickup();
    }

    itemRemoveAmmoFromAltModes() {
      origweapname = self getItemWeaponName();

      curweapname = weaponAltWeaponName(origweapname);

      altindex = 1;
      while(curweapname != "none" && curweapname != origweapname) {
        self itemWeaponSetAmmo(0, 0, 0, altindex);
        curweapname = weaponAltWeaponName(curweapname);
        altindex++;
      }
    }

    handleScavengerBagPickup(scrPlayer) {
      self endon("death");
      level endon("game_ended");

      assert(isDefined(scrPlayer));

      self waittill("scavenger", destPlayer);
      assert(isDefined(destPlayer));

      destPlayer notify("scavenger_pickup");

      offhandWeapons = destPlayer getWeaponsListOffhands();
      foreach(offhand in offhandWeapons) {
        if(maps\mp\gametypes\_class::isValidOffhand(offhand, false) && destPlayer _hasPerk("specialty_tacticalresupply")) {
          destPlayer BatteryFullRecharge(offhand);
        } else if(maps\mp\gametypes\_class::isValidEquipment(offhand, false) && destPlayer _hasPerk("specialty_lethalresupply")) {
          currentClipAmmo = destPlayer GetWeaponAmmoClip(offhand);
          destPlayer SetWeaponAmmoClip(offhand, currentClipAmmo + 1);
        }
      }

      if(destPlayer _hasPerk("specialty_scavenger")) {
        primaryWeapons = destPlayer getWeaponsListPrimaries();
        foreach(primary in primaryWeapons) {
          if(isCACPrimaryWeapon(primary) || (level.scavenger_secondary && isCACSecondaryWeapon(primary))) {
            currentStockAmmo = destPlayer GetWeaponAmmoStock(primary);

            addStockAmmo = 0;

            weapon_class = getWeaponClass(primary);
            if(isBeamWeapon(primary) || weapon_class == "weapon_riot" || IsSubStr(primary, "riotshield")) {} else if(weapon_class == "weapon_projectile" || IsSubStr(primary, "exocrossbow") || IsSubStr(primary, "microdronelauncher")) {
              if(destPlayer _hasPerk("specialty_explosiveammoresupply")) {
                addStockAmmo = weaponClipSize(primary);
              }
            } else if(isSubStr(primary, "alt") && isSubStr(primary, "gl")) {
              if(destPlayer _hasPerk("specialty_explosiveammoresupply")) {
                addStockAmmo = weaponClipSize(primary);
              }
            } else if(isBulletWeapon(primary)) {
              if(destPlayer _hasPerk("specialty_bulletresupply")) {
                maxAmmo = WeaponMaxAmmo(primary);

                addStockAmmo = Int(maxAmmo * destPlayer.ammopickup_scalar);
              }
            }

            if(addStockAmmo > 0) {
              destPlayer setWeaponAmmoStock(primary, currentStockAmmo + addStockAmmo);
            }
          }
        }
      }

      destPlayer maps\mp\gametypes\_damagefeedback::updateDamageFeedback("scavenger");
    }

    dropScavengerForDeath(attacker) {
      waittillframeend;

      if(level.inGracePeriod) {
        return;
      }

      if(!isDefined(self)) {
        return;
      }

      if(!isDefined(attacker)) {
        return;
      }

      if(attacker == self) {
        return;
      }

      if(!isDefined(self.agentBody)) {
        dropBag = self DropScavengerBag("scavenger_bag_mp");
      } else {
        dropBag = self.agentBody DropScavengerBag("scavenger_bag_mp");
      }
      dropBag thread handleScavengerBagPickup(self);

      if(isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
        [[level.bot_funcs["bots_add_scavenger_bag"]]](dropBag);
      }
    }

    getWeaponBasedGrenadeCount(weapon) {
      return 2;
    }

    getWeaponBasedSmokeGrenadeCount(weapon) {
      return 1;
    }

    getFragGrenadeCount() {
      grenadetype = "frag_grenade_mp";

      count = self getammocount(grenadetype);
      return count;
    }

    getSmokeGrenadeCount() {
      count = self getammocount("smoke_grenade_mp");
      count += self getammocount("smoke_grenade_mp_lefthand");
      count += self getammocount("smoke_grenade_var_mp");
      count += self getammocount("smoke_grenade_var_mp_lefthand");

      return count;
    }

    setWeaponStat(name, incValue, statName) {
      self maps\mp\gametypes\_gamelogic::setWeaponStat(name, incValue, statName);
    }

    watchWeaponUsage(weaponHand) {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");
      level endon("game_ended");

      if(IsAI(self)) {
        return;
      }

      for(;;) {
        self waittill("weapon_fired", weaponName);

        maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

        self.lastShotFiredTime = getTime();

        if(!isCACPrimaryWeapon(weaponName) && !isCACSecondaryWeapon(weaponName)) {
          continue;
        }

        if(isDefined(self.hitsThisMag[weaponName])) {
          self thread updateMagShots(weaponName);
        }

        totalShots = self maps\mp\gametypes\_persistence::statGetBuffered("totalShots") + 1;
        hits = self maps\mp\gametypes\_persistence::statGetBuffered("hits");

        assert(totalShots > 0);
        accuracy = Clamp(float(hits) / float(totalShots), 0.0, 1.0) * 10000.0;

        self maps\mp\gametypes\_persistence::statSetBuffered("totalShots", totalShots);
        self maps\mp\gametypes\_persistence::statSetBuffered("accuracy", int(accuracy));
        self maps\mp\gametypes\_persistence::statSetBuffered("misses", int(totalShots - hits));

        if(isDefined(self.lastStandParams) && self.lastStandParams.lastStandStartTime == getTime()) {
          self.hits = 0;
          return;
        }

        shotsFired = 1;
        self setWeaponStat(weaponName, shotsFired, "shots");
        self setWeaponStat(weaponName, self.hits, "hits");

        self.hits = 0;
      }
    }

    updateMagShots(weaponName) {
      self endon("death");
      self endon("faux_spawn");
      self endon("disconnect");
      self endon("updateMagShots_" + weaponName);

      self.hitsThisMag[weaponName]--;

      wait(0.05);

      self.hitsThisMag[weaponName] = weaponClipSize(weaponName);
    }

    checkHitsThisMag(weaponName) {
      self endon("death");
      self endon("disconnect");

      self notify("updateMagShots_" + weaponName);
      waittillframeend;

      if(isDefined(self.hitsThisMag[weaponName]) && self.hitsThisMag[weaponName] == 0) {
        weaponClass = getWeaponClass(weaponName);

        maps\mp\gametypes\_missions::genericChallenge(weaponClass);

        self.hitsThisMag[weaponName] = weaponClipSize(weaponName);
      }
    }

    checkHit(weaponName, victim) {
      self endon("disconnect");

      if(isStrStart(weaponName, "alt_")) {
        tokens = getWeaponNameTokens(weaponName);
        foreach(token in tokens) {
          if(token == "shotgun") {
            tmpWeaponName = GetSubStr(weaponName, 0, 4);
            if(!maps\mp\gametypes\_weapons::isPrimaryWeapon(tmpWeaponName) && !maps\mp\gametypes\_weapons::isSideArm(tmpWeaponName)) {
              self.hits = 1;
            }
          } else if(token == "hybrid") {
            tmp = GetSubStr(weaponName, 4);
            weaponName = tmp;
          }
        }
      }

      if(!maps\mp\gametypes\_weapons::isPrimaryWeapon(weaponName) && !maps\mp\gametypes\_weapons::isSideArm(weaponName)) {
        return;
      }

      if(self meleeButtonPressed()) {
        return;
      }

      switch (weaponClass(weaponName)) {
        case "rifle":
        case "pistol":
        case "mg":
        case "smg":
        case "sniper":
          self.hits++;
          break;
        case "spread":
          self.hits = 1;
          break;
        default:
          break;
      }

      if(IsSubStr(weaponName, "riotshield")) {
        self thread maps\mp\gametypes\_gamelogic::threadedSetWeaponStatByName("riotshield", self.hits, "hits");
        self.hits = 0;
      }

      waittillframeend;

      if(isDefined(self.hitsThisMag[weaponName])) {
        self thread checkHitsThisMag(weaponName);
      }

      if(!isDefined(self.lastHitTime[weaponName])) {
        self.lastHitTime[weaponName] = 0;
      }

      if(self.lastHitTime[weaponName] == getTime()) {
        return;
      }

      self.lastHitTime[weaponName] = getTime();

      totalShots = self maps\mp\gametypes\_persistence::statGetBuffered("totalShots");
      hits = self maps\mp\gametypes\_persistence::statGetBuffered("hits") + 1;

      if(hits <= totalShots) {
        self maps\mp\gametypes\_persistence::statSetBuffered("hits", hits);
        self maps\mp\gametypes\_persistence::statSetBuffered("misses", int(totalShots - hits));

        accuracy = Clamp(float(hits) / float(totalShots), 0.0, 1.0) * 10000.0;
        self maps\mp\gametypes\_persistence::statSetBuffered("accuracy", int(accuracy));
      }
    }

    attackerCanDamageItem(attacker, itemOwner) {
      return friendlyFireCheck(itemOwner, attacker);
    }

    friendlyFireCheck(owner, attacker, forcedFriendlyFireRule) {
      if(!isDefined(owner)) {
        return true;
      }

      if(!level.teamBased) {
        return true;
      }

      attackerTeam = attacker.team;

      friendlyFireRule = level.friendlyfire;
      if(isDefined(forcedFriendlyFireRule)) {
        friendlyFireRule = forcedFriendlyFireRule;
      }

      if(friendlyFireRule != 0) {
        return true;
      }

      if(attacker == owner) {
        return true;
      }

      if(!isDefined(attackerTeam)) {
        return true;
      }

      if(attackerTeam != owner.team) {
        return true;
      }

      return false;
    }

    watchGrenadeUsage() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      self.throwingGrenade = undefined;
      self.gotPullbackNotify = false;

      if(getIntProperty("scr_deleteexplosivesonspawn", 1) == 1) {
        if(isDefined(self.dont_delete_grenades_on_next_spawn)) {
          self.dont_delete_grenades_on_next_spawn = undefined;
        } else {
          self delete_all_grenades();
        }
      } else {
        if(!isDefined(self.manuallyDetonatedArray)) {
          self.manuallyDetonatedArray = [];
        }
        if(!isDefined(self.claymorearray)) {
          self.claymorearray = [];
        }
        if(!isDefined(self.bouncingbettyArray)) {
          self.bouncingbettyArray = [];
        }
      }

      thread watchManuallyDetonatedUsage();
      thread watchManualDetonationByEmptyThrow();
      thread watchManualDetonationByDoubleTap();
      thread watchC4Usage();
      thread watchClaymores();
      thread deleteC4AndClaymoresOnDisconnect();

      self thread watchForThrowbacks();

      for(;;) {
        self waittill("grenade_pullback", weaponName);

        self setWeaponStat(weaponName, 1, "shots");

        maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

        self thread watchOffhandCancel();

        if(weaponName == "claymore_mp") {
          continue;
        }

        self.throwingGrenade = weaponName;
        self.gotPullbackNotify = true;

        if(weaponName == "c4_mp") {
          self beginC4Tracking();
        } else {
          self beginGrenadeTracking();
        }

        self.throwingGrenade = undefined;
      }
    }

    beginGrenadeTracking() {
      self endon("faux_spawn");
      self endon("death");
      self endon("disconnect");
      self endon("offhand_end");
      self endon("weapon_change");

      startTime = getTime();

      self waittill("grenade_fire", grenade, weaponName);

      if(isDefined(grenade)) {
        shortWeaponName = maps\mp\_utility::strip_suffix(weaponName, "_lefthand");

        if((getTime() - startTime > 1000) && shortWeaponName == "frag_grenade_mp") {
          grenade.isCooked = true;
        }

        self.changingWeapon = undefined;

        grenade.owner = self;
        grenade.weaponName = weaponName;

        switch (shortWeaponName) {
          case "frag_grenade_mp":
          case "semtex_mp":
          case "frag_grenade_var_mp":
          case "semtex_grenade_var_mp":
            grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
            grenade.originalOwner = self;
            break;
          case "flash_grenade_mp":
            grenade thread nineBangExplodeWaiter();
            break;
          case "concussion_grenade_mp":
            grenade thread empExplodeWaiter();
            break;
          case "stun_grenade_mp":
          case "stun_grenade_var_mp":
            break;
          case "smoke_grenade_mp":
          case "smoke_grenade_var_mp":
            grenade thread watchSmokeExplode();
            break;
          case "paint_grenade_mp":
          case "paint_grenade_var_mp":
          case "paint_grenade_horde_mp":
            grenade thread watchPaintGrenade();
            break;
        }
      }
    }

    watchOffhandCancel() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");
      self endon("grenade_fire");

      self waittill("offhand_end");

      if(isDefined(self.changingWeapon) && self.changingWeapon != self GetCurrentWeapon()) {
        self.changingWeapon = undefined;
      }
    }

    watchPaintGrenade() {
      owner = self.owner;
      owner endon("disconnect");
      owner endon("death");

      self waittill("explode", position);

      if(owner isEMPed() && isDefined(level.empEquipmentDisabled) && level.empEquipmentDisabled) {
        return;
      }

      detection_grenade_think(position, owner);
    }

    detection_grenade_think(position, owner) {
      assert(isDefined(owner));

      PAINT_EXPLOSION_RADIUS = GetDvarFloat("paintExplosionRadius");
      PAINT_EXPLOSION_DURATION = 1.0;

      highlightTime = 1.5;
      if(isDefined(level.isHorde)) {
        highlightTime = 10;
      }

      thread maps\mp\_threatdetection::detection_grenade_hud_effect(owner, position, PAINT_EXPLOSION_DURATION, PAINT_EXPLOSION_RADIUS);
      thread maps\mp\_threatdetection::detection_highlight_hud_effect(owner, highlightTime);

      foreach(person in level.players) {
        if(!isDefined(person) || !IsAlive(person) || person _hasPerk("specialty_coldblooded") || (level.teamBased == true && owner != person && owner.team == person.team)) {
          continue;
        }

        if(Distance(person.origin, position) < PAINT_EXPLOSION_RADIUS) {
          if(person SightConeTrace(position)) {
            if(owner == person) {
              foreach(player in level.players) {
                if(isDefined(player) && ((level.teamBased == false || owner.team != player.team) || owner == player)) {
                  thread maps\mp\_threatdetection::detection_highlight_hud_effect(player, highlightTime);
                  owner maps\mp\_threatdetection::addThreatEvent([player], highlightTime, "PAINT_GRENADE", true, false);
                }
              }
            } else {
              person maps\mp\_threatdetection::addThreatEvent([owner], highlightTime, "PAINT_GRENADE", true, false);
              owner maps\mp\gametypes\_damagefeedback::updateDamageFeedback("paint");
            }
          }
        }
      }

      if(isDefined(level.agentArray)) {
        foreach(agent in level.agentArray) {
          if(!isDefined(agent) || !IsAlive(agent) || (isDefined(agent.team) && level.teamBased == true && owner.team == agent.team)) {
            continue;
          }

          if(Distance(agent.origin, position) < PAINT_EXPLOSION_RADIUS) {
            if(agent SightConeTrace(position)) {
              agent maps\mp\_threatdetection::addThreatEvent([owner], highlightTime, "PAINT_GRENADE", true, false);
              owner maps\mp\gametypes\_damagefeedback::updateDamageFeedback("paint");
            }
          }
        }
      }
    }

    watchSmokeExplode() {
      level endon("smokeTimesUp");

      owner = self.owner;
      owner endon("disconnect");

      self waittill("explode", position);

      smokeRadius = 128;
      smokeTime = 8;
      level thread waitSmokeTime(smokeTime, smokeRadius, position);

      while(true) {
        if(!isDefined(owner)) {
          break;
        }

        foreach(player in level.players) {
          if(!isDefined(player)) {
            continue;
          }

          if(level.teamBased && player.team == owner.team) {
            continue;
          }

          if(DistanceSquared(player.origin, position) < smokeRadius * smokeRadius) {
            player.inPlayerSmokeScreen = owner;
          } else {
            player.inPlayerSmokeScreen = undefined;
          }
        }

        wait(0.05);
      }
    }

    waitSmokeTime(smokeTime, smokeRadius, position) {
      maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(smokeTime);
      level notify("smokeTimesUp");
      waittillframeend;

      foreach(player in level.players) {
        if(isDefined(player)) {
          player.inPlayerSmokeScreen = undefined;
        }
      }

    }

    watchMissileUsage() {
      self endon("disconnect");

      for(;;) {
        self waittill("missile_fire", missile, weaponName);

        missiles = [missile];

        if(isSubStr(weaponName, "_gl")) {
          missile.owner = self;
          missile.primaryWeapon = self getCurrentPrimaryWeapon();
          missile thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
        }

        if(isDefined(missile)) {
          missile.weaponName = weaponName;

          if(isPrimaryOrSecondaryProjectileWeapon(weaponName)) {
            missile.firedAds = self PlayerAds();
          }
        }

        switch (weaponName) {
          case "stinger_mp":

          case "iw5_lsr_mp":
            missile.lockedStingerTarget = self.stingerTarget;
            level notify("stinger_fired", self, missiles);
            self thread setAltSceneObj(missile, "tag_origin", 65);
            break;
          default:
            break;
        }

        switch (weaponName) {
          case "rpg_mp":
          case "ac130_105mm_mp":
          case "ac130_40mm_mp":
          case "remotemissile_projectile_mp":
            missile thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
          default:
            break;
        }
      }
    }

    watchHitByMissile() {
      self endon("disconnect");

      while(1) {
        self waittill("hit_by_missile", attacker, missile, weaponName, impactPos, missileDir, impactNormal, partGroup, partName);

        if(!isDefined(attacker) || !isDefined(missile)) {
          continue;
        }

        if(level.teamBased && self.team == attacker.team) {
          self CancelRocketCorpse(missile, impactPos, missileDir, impactNormal, partGroup, partName);
          continue;
        }

        if(weaponName != "rpg_mp") {
          self CancelRocketCorpse(missile, impactPos, missileDir, impactNormal, partGroup, partName);
          continue;
        }

        if(RandomIntRange(0, 100) < 99) {
          self CancelRocketCorpse(missile, impactPos, missileDir, impactNormal, partGroup, partName);
          continue;
        }

        drag_player_time_seconds = GetDvarFloat("rocket_corpse_max_air_time", 0.5);
        camera_offset_up = GetDvarFloat("rocket_corpse_view_offset_up", 100);
        camera_offset_forward = GetDvarFloat("rocket_corpse_view_offset_forward", 35);

        self.isRocketCorpse = true;
        self SetContents(0);

        durationMs = self SetRocketCorpse(true);
        durationSec = durationMs / 1000.0;

        self.killCamEnt = spawn("script_model", missile.origin);
        self.killCamEnt.angles = missile.angles;
        self.killCamEnt LinkTo(missile);
        self.killCamEnt SetScriptMoverKillCam("rocket_corpse");
        self.killCamEnt SetContents(0);

        self DoDamage(1000, self.origin, attacker, missile);

        self.body = self ClonePlayer(durationMs);
        self.body.origin = missile.origin;
        self.body.angles = missile.angles;
        self.body SetCorpseFalling(false);
        self.body EnableLinkTo();
        self.body LinkTo(missile);
        self.body SetContents(0);

        if(!isDefined(self.switching_teams)) {
          thread maps\mp\gametypes\_deathicons::addDeathicon(self.body, self, self.team, 5.0);
        }

        self PlayerHide();

        missile_up = VectorNormalize(AnglesToUp(missile.angles));
        missile_forward = VectorNormalize(anglesToForward(missile.angles));
        eye_offset = (missile_forward * camera_offset_up) + (missile_up * camera_offset_forward);
        eye_origin = missile.origin + eye_offset;

        eye_pos = spawn("script_model", eye_origin);
        eye_pos setModel("tag_origin");
        eye_pos.angles = VectorToAngles(missile.origin - eye_pos.origin);
        eye_pos LinkTo(missile);
        eye_pos SetContents(0);

        self CameraLinkTo(eye_pos, "tag_origin");

        if(drag_player_time_seconds > durationSec) {
          drag_player_time_seconds = durationSec;
        }

        value = missile waittill_notify_or_timeout_return("death", drag_player_time_seconds);

        if(isDefined(value) && value == "timeout" && isDefined(missile)) {
          missile Detonate();
        }

        self notify("final_rocket_corpse_death");

        self.body Unlink();
        self.body SetCorpseFalling(true);
        self.body StartRagdoll();

        eye_pos LinkTo(self.body);

        self.isRocketCorpse = undefined;

        self waittill("death_delay_finished");

        self CameraUnlink();
        self.killCamEnt Delete();

        eye_pos Delete();
      }
    }

    watchSentryUsage() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      for(;;) {
        self waittill("sentry_placement_finished", sentry);

        self thread setAltSceneObj(sentry, "tag_flash", 65);
      }
    }

    empExplodeWaiter() {
      self thread maps\mp\gametypes\_shellshock::endOnDeath();
      self endon("end_explode");

      self waittill("explode", position);

      ents = getEMPDamageEnts(position, 512, false);

      foreach(ent in ents) {
        if(isDefined(ent.owner) && !friendlyFireCheck(self.owner, ent.owner)) {
          continue;
        }

        ent notify("emp_damage", self.owner, 8.0);
      }
    }

    nineBangExplodeWaiter() {
      self thread maps\mp\gametypes\_shellshock::endOnDeath();
      self endon("end_explode");

      self waittill("explode", position);

      level thread doNineBang(position, self.owner);

      ents = getEMPDamageEnts(position, 512, false);

      foreach(ent in ents) {
        if(isDefined(ent.owner) && !friendlyFireCheck(self.owner, ent.owner)) {
          continue;
        }

        ent notify("emp_damage", self.owner, 8.0);
      }
    }

    flashbangPlayer(player, pos, attacker) {
      radius_max_sq = 640000;
      radius_min_sq = 40000;

      viewHeightStanding = 60;
      viewHeightCrouching = 40;
      viewHeightProne = 11;

      if(!isReallyAlive(player) || player.sessionstate != "playing") {
        return;
      }

      dist = DistanceSquared(pos, player.origin);
      if(dist > radius_max_sq) {
        return;
      }

      if(dist <= radius_min_sq) {
        percent_distance = 1.0;
      } else {
        percent_distance = 1.0 - (dist - radius_min_sq) / (radius_max_sq - radius_min_sq);
      }

      amountSeen = player SightConeTrace(pos);
      if(amountSeen < 0.5) {
        return;
      }

      forward = anglesToForward(player GetPlayerAngles());

      viewOrigin = player.origin;
      switch (player GetStance()) {
        case "stand":
          viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightStanding);
          break;
        case "crouch":
          viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightCrouching);
          break;
        case "prone":
          viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightProne);
          break;
      }
      toBlast = pos - viewOrigin;
      toBlast = VectorNormalize(toBlast);

      percent_angle = 0.5 * (1.0 + VectorDot(forward, toBlast));

      player notify("flashbang", pos, percent_distance, percent_angle, attacker);
    }

    doNineBang(pos, attacker) {
      level endon("game_ended");

      numFlashes = 1;

      for(i = 0; i < numFlashes; i++) {
        if(i > 0) {
          playSoundAtPos(pos, "null");

          foreach(player in level.players) {
            flashbangPlayer(player, pos, attacker);
          }
        }

        ents = getEMPDamageEnts(pos, 512, false);

        foreach(ent in ents) {
          if(isDefined(ent.owner) && !friendlyFireCheck(self.owner, ent.owner)) {
            continue;
          }

          ent notify("emp_damage", self.owner, 8.0);
        }

        wait(RandomFloatRange(0.25, 0.5));
      }
    }

    beginC4Tracking() {
      self endon("faux_spawn");
      self endon("death");
      self endon("disconnect");

      self waittill_any("grenade_fire", "weapon_change", "offhand_end");

      self.changingWeapon = undefined;
    }

    watchForThrowbacks() {
      self endon("faux_spawn");
      self endon("death");
      self endon("disconnect");

      for(;;) {
        self waittill("grenade_fire", grenade, weapname);

        if(self.gotPullbackNotify) {
          self.gotPullbackNotify = false;
          continue;
        }

        if(!isSubStr(weapname, "frag_") && !isSubStr(weapname, "semtex_")) {
          continue;
        }

        grenade.threwBack = true;
        grenade.originalOwner = self;
        grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
      }
    }

    manuallyDetonated_removeUndefined(array) {
      newArray = [];
      foreach(i, item in array) {
        if(!isDefined(item[0])) {
          continue;
        }
        newArray[newArray.size] = item;
      }
      return newArray;
    }

    watchManuallyDetonatedUsage() {
      self endon("spawned_player");
      self endon("faux_spawn");
      self endon("disconnect");

      while(1) {
        self waittill("grenade_fire", weapon, weapname);
        detonatesOnEmptyThrow = IsWeaponManuallyDetonatedByEmptyThrow(weapName);
        detonatesOnDoubleTap = IsWeaponManuallyDetonatedByDoubleTap(weapName);
        if(detonatesOnEmptyThrow || detonatesOnDoubleTap) {
          if(!self.manuallyDetonatedArray.size) {
            self thread watchManuallyDetonatedForDoubleTap();
          }

          if(self.manuallyDetonatedArray.size) {
            self.manuallyDetonatedArray = manuallyDetonated_removeUndefined(self.manuallyDetonatedArray);

            if(self.manuallyDetonatedArray.size >= level.maxPerPlayerExplosives) {
              self.manuallyDetonatedArray[0][0] detonate();
            }
          }

          index = self.manuallyDetonatedArray.size;
          self.manuallyDetonatedArray[index] = [];
          self.manuallyDetonatedArray[index][0] = weapon;
          self.manuallyDetonatedArray[index][1] = detonatesOnEmptyThrow;
          self.manuallyDetonatedArray[index][2] = detonatesOnDoubleTap;

          if(isDefined(weapon)) {
            weapon.owner = self;
            weapon SetOtherEnt(self);
            weapon.team = self.team;
            weapon.weaponName = weapname;
            weapon.stunned = false;
          }
        }
      }
    }

    watchC4Usage() {
      self endon("faux_spawn");
      self endon("spawned_player");
      self endon("disconnect");

      while(1) {
        self waittill("grenade_fire", weapon, weapname);
        if(weapname == "c4" || weapname == "c4_mp") {
          level.mines[level.mines.size] = weapon;
          weapon thread maps\mp\gametypes\_shellshock::c4_earthQuake();
          weapon thread c4Damage();
          weapon thread c4EMPDamage();
          weapon thread c4EMPKillstreakWait();
          weapon thread watchC4Stuck();
          weapon thread setMineTeamHeadIcon(self.pers["team"]);
        }
      }
    }

    watchC4Stuck() {
      self endon("death");

      self waittill("missile_stuck");
      self.trigger = spawn("script_origin", self.origin);
      self.trigger.owner = self;
      self thread equipmentWatchUse(self.owner, true);
      self makeExplosiveTargetableByAI();
    }

    c4EMPDamage() {
      self endon("death");

      for(;;) {
        self waittill("emp_damage", attacker, duration);

        playFXOnTag(getfx("sentry_explode_mp"), self, "tag_origin");

        self.disabled = true;
        self notify("disabled");

        wait(duration);

        self.disabled = undefined;
        self notify("enabled");
      }
    }

    c4EMPKillstreakWait() {
      self endon("death");

      for(;;) {
        level waittill("emp_update");

        if((level.teamBased && level.teamEMPed[self.team]) || (!level.teamBased && isDefined(level.empPlayer) && level.empPlayer != self.owner)) {
          self.disabled = true;
          self notify("disabled");
        } else {
          self.disabled = undefined;
          self notify("enabled");
        }
      }
    }

    setMineTeamHeadIcon(team) {
      self endon("death");
      wait .05;
      if(level.teamBased) {
        self maps\mp\_entityheadicons::setTeamHeadIcon(team, (0, 0, 20));
      } else if(isDefined(self.owner)) {
        self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 20));
      }
    }

    watchClaymores() {
      self endon("faux_spawn");
      self endon("spawned_player");
      self endon("disconnect");

      self.claymorearray = [];
      while(1) {
        self waittill("grenade_fire", claymore, weapname);
        if(weapname == "claymore" || weapname == "claymore_mp") {
          if(!IsAlive(self)) {
            claymore delete();
            return;
          }

          claymore Hide();
          claymore waittill_any_timeout(.05, "missile_stuck");
          TotalDistance = 60;
          claymoreZOffset = (0, 0, 4);

          distanceFromOrigin = DistanceSquared(self.origin, claymore.origin);
          distanceFromEye = DistanceSquared(self getEye(), claymore.origin);

          distanceFromOrigin += 600;

          parent = claymore GetLinkedParent();
          if(isDefined(parent)) {
            claymore unlink();
          }

          if(distanceFromOrigin < distanceFromEye) {
            if(TotalDistance * TotalDistance < DistanceSquared(claymore.origin, self.origin)) {
              secTrace = bulletTrace(self.origin, self.origin - (0, 0, TotalDistance), false, self);

              if(secTrace["fraction"] == 1) {
                claymore delete();
                self SetWeaponAmmoStock("claymore_mp", self GetWeaponAmmoStock("claymore_mp") + 1);
                continue;
              } else {
                claymore.origin = secTrace["position"];
                parent = secTrace["entity"];
              }
            } else {
              println("not sure why this is here");
            }
          } else {
            if(TotalDistance * TotalDistance < DistanceSquared(claymore.origin, self getEye())) {
              secTrace = bulletTrace(self.origin, self.origin - (0, 0, TotalDistance), false, self);

              if(secTrace["fraction"] == 1) {
                claymore delete();
                self SetWeaponAmmoStock("claymore_mp", self GetWeaponAmmoStock("claymore_mp") + 1);
                continue;
              } else {
                claymore.origin = secTrace["position"];
                parent = secTrace["entity"];
              }
            } else {
              claymoreZOffset = (0, 0, -5);
              claymore.angles += (0, 180, 0);
            }
          }

          claymore.angles *= (0, 1, 1);
          claymore.origin = claymore.origin + claymoreZOffset;

          if(isDefined(parent)) {
            claymore linkto(parent);
          }

          claymore Show();

          self.claymorearray = array_removeUndefined(self.claymorearray);

          if(self.claymoreArray.size >= level.maxPerPlayerExplosives) {
            deleteEquipment(self.claymoreArray[0]);
          }

          self.claymorearray[self.claymorearray.size] = claymore;
          claymore.owner = self;
          claymore SetOtherEnt(self);
          claymore.team = self.team;
          claymore.weaponName = weapname;
          claymore.trigger = spawn("script_origin", claymore.origin);
          claymore.trigger.owner = claymore;
          claymore.stunned = false;

          claymore makeExplosiveTargetableByAI();

          level.mines[level.mines.size] = claymore;
          claymore thread c4Damage();
          claymore thread c4EMPDamage();
          claymore thread c4EMPKillstreakWait();
          claymore thread claymoreDetonation();
          claymore thread equipmentWatchUse(self, true);
          claymore thread setMineTeamHeadIcon(self.pers["team"]);

          self.changingWeapon = undefined;

          if(getdvarint("scr_claymoredebug")) {
            claymore thread claymoreDebug();
          }
        }
      }
    }

    equipmentEnableUse(owner) {
      self notify("equipmentWatchUse");

      self endon("spawned_player");
      self endon("disconnect");
      self endon("equipmentWatchUse");
      self endon("change_owner");

      self.trigger setCursorHint("HINT_NOICON");

      if(self.weaponname == "c4_mp") {
        self.trigger setHintString(&"MP_PICKUP_C4");
      } else if(self.weaponname == "claymore_mp") {
        self.trigger setHintString(&"MP_PICKUP_CLAYMORE");
      } else if(self.weaponname == "bouncingbetty_mp") {
        self.trigger setHintString(&"MP_PICKUP_BOUNCING_BETTY");
      }

      self.trigger setSelfUsable(owner);
    }

    equipmentDisableUse(owner) {
      self.trigger setHintString("");

      self.trigger setSelfUnusuable();
    }

    equipmentWatchEnableDisableUse(owner) {
      self endon("spawned_player");
      self endon("disconnect");
      self endon("death");
      owner endon("disconnect");
      owner endon("death");

      enabled = true;

      while(true) {
        if(owner GetWeaponAmmoStock(self.weaponName) < WeaponMaxAmmo(self.weaponName)) {
          if(!enabled) {
            self equipmentEnableUse(owner);
            enabled = true;
          }
        } else {
          if(enabled) {
            self equipmentDisableUse(owner);
            enabled = false;
          }
        }

        wait(0.05);
      }
    }

    equipmentWatchUse(owner, updatePosition) {
      self endon("spawned_player");
      self endon("disconnect");
      self endon("death");
      self endon("change_owner");

      self.trigger setCursorHint("HINT_NOICON");

      self equipmentEnableUse(owner);

      if(isDefined(updatePosition) && updatePosition) {
        self thread updateTriggerPosition();
      }

      for(;;) {
        self thread equipmentWatchEnableDisableUse(owner);

        self.trigger waittill("trigger", owner);

        ammoStock = owner GetWeaponAmmoStock(self.weaponName);

        if(ammoStock < WeaponMaxAmmo(self.weaponName)) {
          owner playLocalSound("scavenger_pack_pickup");

          owner SetWeaponAmmoStock(self.weaponname, ammoStock + 1);

          self.trigger delete();
          self delete();
          self notify("death");
        }
      }
    }

    updateTriggerPosition() {
      self endon("death");

      for(;;) {
        if(isDefined(self) && isDefined(self.trigger)) {
          self.trigger.origin = self.origin;

          if(isDefined(self.bombSquadModel)) {
            self.bombSquadModel.origin = self.origin;
          }
        } else {
          return;
        }

        wait(0.05);
      }
    }

    claymoreDebug() {
      self waittill("missile_stuck");
      self thread showCone(acos(level.claymoreDetectionDot), level.claymoreDetonateRadius, (1, .85, 0));
      self thread showCone(60, 256, (1, 0, 0));
    }

    showCone(angle, range, color) {
      self endon("death");

      start = self.origin;
      forward = anglesToForward(self.angles);
      right = vectorcross(forward, (0, 0, 1));
      up = vectorcross(forward, right);

      fullforward = forward * range * cos(angle);
      sideamnt = range * sin(angle);

      while(1) {
        prevpoint = (0, 0, 0);
        for(i = 0; i <= 20; i++) {
          coneangle = i / 20.0 * 360;
          point = start + fullforward + sideamnt * (right * cos(coneangle) + up * sin(coneangle));
          if(i > 0) {
            line(start, point, color);
            line(prevpoint, point, color);
          }
          prevpoint = point;
        }
        wait .05;
      }
    }

    claymoreDetonation() {
      self endon("death");
      self endon("change_owner");

      damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoreDetonateRadius), 0, level.claymoreDetonateRadius, level.claymoreDetonateRadius * 2);
      self thread deleteOnDeath(damagearea);

      while(1) {
        damagearea waittill("trigger", player);

        if(self.stunned) {
          wait(0.05);
          continue;
        }

        if(getdvarint("scr_claymoredebug") != 1) {
          if(isDefined(self.owner)) {
            if(player == self.owner) {
              continue;
            }
            if(isDefined(player.owner) && player.owner == self.owner) {
              continue;
            }
          }
          if(!friendlyFireCheck(self.owner, player, 0)) {
            continue;
          }
        }
        if(lengthsquared(player getEntityVelocity()) < 10) {
          continue;
        }

        zDistance = abs(player.origin[2] - self.origin[2]);

        if(zDistance > 128) {
          continue;
        }

        if(!player shouldAffectClaymore(self)) {
          continue;
        }

        if(player damageConeTrace(self.origin, self) > 0) {
          break;
        }
      }

      self playSound("claymore_activated");

      if(isPlayer(player) && player _hasPerk("specialty_delaymine")) {
        player notify("triggered_claymore");
        wait level.delayMineTime;
      } else {
        wait level.claymoreDetectionGracePeriod;
      }

      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      if(isDefined(self.owner) && isDefined(level.leaderDialogOnPlayer_func)) {
        self.owner thread[[level.leaderDialogOnPlayer_func]]("claymore_destroyed", undefined, undefined, self.origin);
      }

      self detonate();
    }

    shouldAffectClaymore(claymore) {
      if(isDefined(claymore.disabled)) {
        return false;
      }

      pos = self.origin + (0, 0, 32);

      dirToPos = pos - claymore.origin;
      claymoreForward = anglesToForward(claymore.angles);

      dist = vectorDot(dirToPos, claymoreForward);
      if(dist < level.claymoreDetectionMinDist) {
        return false;
      }

      dirToPos = vectornormalize(dirToPos);

      dot = vectorDot(dirToPos, claymoreForward);
      return (dot > level.claymoreDetectionDot);
    }

    deleteOnDeath(ent) {
      self waittill("death");
      wait .05;

      if(isDefined(ent)) {
        if(isDefined(ent.trigger)) {
          ent.trigger delete();
        }

        ent delete();
      }
    }

    deleteEquipment(ent) {
      if(isDefined(ent)) {
        if(isDefined(ent.trigger)) {
          ent.trigger delete();
        }

        ent delete();
      }
    }

    watchManuallyDetonatedForDoubleTap() {
      self endon("death");
      self endon("disconnect");
      self endon("all_detonated");
      level endon("game_ended");
      self endon("change_owner");

      buttonTime = 0;
      for(;;) {
        if(self useButtonPressed()) {
          buttonTime = 0;
          while(self useButtonPressed()) {
            buttonTime += 0.05;
            wait(0.05);
          }

          println("pressTime1: " + buttonTime);
          if(buttonTime >= 0.5) {
            continue;
          }

          buttonTime = 0;
          while(!self useButtonPressed() && buttonTime < 0.35) {
            buttonTime += 0.05;
            wait(0.05);
          }

          println("delayTime: " + buttonTime);
          if(buttonTime >= 0.35) {
            continue;
          }

          if(!self.manuallyDetonatedArray.size) {
            return;
          }

          self notify("detonate_double_tap");
        }
        wait(0.05);
      }
    }

    watchManualDetonationByEmptyThrow() {
      self endon("death");
      self endon("faux_spawn");
      self endon("disconnect");

      while(1) {
        self waittill("detonate");

        manuallyDetonateAll(1);
      }
    }

    watchManualDetonationByDoubleTap() {
      self endon("death");
      self endon("faux_spawn");
      self endon("disconnect");

      while(1) {
        self waittill("detonate_double_tap");

        weapName = self getCurrentWeapon();
        if(!IsWeaponManuallyDetonatedByDoubleTap(weapName)) {
          manuallyDetonateAll(2);
        }
      }
    }

    manuallyDetonateAll(detonateType) {
      bNotAllDetonated = false;
      newarray = [];
      for(i = 0; i < self.manuallyDetonatedArray.size; i++) {
        if(!self.manuallyDetonatedArray[i][detonateType]) {
          bNotAllDetonated = true;
          continue;
        }

        weapon = self.manuallyDetonatedArray[i][0];

        if(isDefined(weapon)) {
          if(weapon.stunned) {
            bNotAllDetonated = true;
            return;
          }

          if(isDefined(weapon.weaponname) && !self GetDetonateEnabled(weapon.weaponname)) {
            bNotAllDetonated = true;
            continue;
          }

          if(isDefined(weapon.manuallyDetonateFunc)) {
            self thread[[weapon.manuallyDetonateFunc]](weapon);
          } else {
            weapon thread waitAndDetonate(0, detonateType);
          }
        }
      }

      if(bNotAllDetonated) {
        self.manuallyDetonatedArray = manuallyDetonated_removeUndefined(self.manuallyDetonatedArray);
      } else {
        self.manuallyDetonatedArray = newarray;
        self notify("all_detonated");
      }
    }

    waitAndDetonate(delay, detonateType) {
      self endon("death");
      wait delay;

      self waitTillEnabled();

      if(detonateType == 2) {
        self detonateByDoubleTap();
      } else {
        self detonate();
      }

      level.mines = array_removeUndefined(level.mines);
    }

    deleteC4AndClaymoresOnDisconnect() {
      self endon("faux_spawn");
      self endon("death");
      self waittill("disconnect");

      manuallyDetonatedArray = self.manuallyDetonatedArray;
      claymorearray = self.claymorearray;

      wait .05;

      for(i = 0; i < manuallyDetonatedArray.size; i++) {
        if(isDefined(manuallyDetonatedArray[i][0])) {
          manuallyDetonatedArray[i][0] delete();
        }
      }
      for(i = 0; i < claymorearray.size; i++) {
        if(isDefined(claymorearray[i])) {
          claymorearray[i] delete();
        }
      }
    }

    c4Damage() {
      self endon("death");

      self setCanDamage(true);
      self.maxhealth = 100000;
      self.health = self.maxhealth;

      attacker = undefined;

      while(1) {
        self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

        if(!isPlayer(attacker) && !isAgent(attacker)) {
          continue;
        }

        if(!friendlyFireCheck(self.owner, attacker)) {
          continue;
        }

        if(isDefined(weapon)) {
          shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

          switch (shortWeapon) {
            case "concussion_grenade_mp":
            case "flash_grenade_mp":
            case "stun_grenade_mp":
            case "stun_grenade_var_mp":
            case "smoke_grenade_mp":
            case "smoke_grenade_var_mp":
              continue;
          }
        }

        break;
      }

      if(level.c4explodethisframe) {
        wait .1 + randomfloat(.4);
      } else {
        wait .05;
      }

      if(!isDefined(self)) {
        return;
      }

      level.c4explodethisframe = true;

      thread resetC4ExplodeThisFrame();

      if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE"))) {
        self.wasChained = true;
      }

      if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
        self.wasDamagedFromBulletPenetration = true;
      }

      self.wasDamaged = true;

      if(isPlayer(attacker)) {
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("c4");
      }

      if(level.teamBased) {
        if(isDefined(attacker) && isDefined(self.owner)) {
          attacker_pers_team = attacker.pers["team"];
          self_owner_pers_team = self.owner.pers["team"];
          if(isDefined(attacker_pers_team) && isDefined(self_owner_pers_team) && attacker_pers_team != self_owner_pers_team) {
            attacker notify("destroyed_explosive");
          }
        }
      } else {
        if(isDefined(self.owner) && isDefined(attacker) && attacker != self.owner) {
          attacker notify("destroyed_explosive");
        }
      }

      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      self detonate(attacker);
    }

    resetC4ExplodeThisFrame() {
      wait .05;
      level.c4explodethisframe = false;
    }

    saydamaged(orig, amount) {
      for(i = 0; i < 60; i++) {
        print3d(orig, "damaged! " + amount);
        wait .05;
      }
    }

    waitTillEnabled() {
      if(!isDefined(self.disabled)) {
        return;
      }

      self waittill("enabled");
      assert(!isDefined(self.disabled));
    }

    makeExplosiveTargetableByAI(nonLethal) {
      self make_entity_sentient_mp(self.owner.team);
      if(!isDefined(nonLethal) || !nonLethal) {
        self MakeEntityNoMeleeTarget();
      }
      if(IsSentient(self)) {
        self SetThreatBiasGroup("DogsDontAttack");
      }
    }

    setupBombSquad() {
      self.bombSquadIds = [];

      if(self.detectExplosives && !self.bombSquadIcons.size) {
        for(index = 0; index < 4; index++) {
          self.bombSquadIcons[index] = newClientHudElem(self);
          self.bombSquadIcons[index].x = 0;
          self.bombSquadIcons[index].y = 0;
          self.bombSquadIcons[index].z = 0;
          self.bombSquadIcons[index].alpha = 0;
          self.bombSquadIcons[index].archived = true;
          self.bombSquadIcons[index] setShader("waypoint_bombsquad", 14, 14);
          self.bombSquadIcons[index] setWaypoint(false, false);
          self.bombSquadIcons[index].detectId = "";
        }
      } else if(!self.detectExplosives) {
        for(index = 0; index < self.bombSquadIcons.size; index++) {
          self.bombSquadIcons[index] destroy();
        }

        self.bombSquadIcons = [];
      }
    }

    showHeadIcon(trigger) {
      triggerDetectId = trigger.detectId;
      useId = -1;
      for(index = 0; index < 4; index++) {
        detectId = self.bombSquadIcons[index].detectId;

        if(detectId == triggerDetectId) {
          return;
        }

        if(detectId == "") {
          useId = index;
        }
      }

      if(useId < 0) {
        return;
      }

      self.bombSquadIds[triggerDetectId] = true;

      self.bombSquadIcons[useId].x = trigger.origin[0];
      self.bombSquadIcons[useId].y = trigger.origin[1];
      self.bombSquadIcons[useId].z = trigger.origin[2] + 24 + 128;

      self.bombSquadIcons[useId] fadeOverTime(0.25);
      self.bombSquadIcons[useId].alpha = 1;
      self.bombSquadIcons[useId].detectId = trigger.detectId;

      while(isAlive(self) && isDefined(trigger) && self isTouching(trigger)) {
        wait(0.05);
      }

      if(!isDefined(self)) {
        return;
      }

      self.bombSquadIcons[useId].detectId = "";
      self.bombSquadIcons[useId] fadeOverTime(0.25);
      self.bombSquadIcons[useId].alpha = 0;
      self.bombSquadIds[triggerDetectId] = undefined;
    }

    getDamageableEnts(pos, radius, doLOS, startRadius) {
      ents = [];

      if(!isDefined(doLOS)) {
        doLOS = false;
      }

      if(!isDefined(startRadius)) {
        startRadius = 0;
      }

      radiusSq = radius * radius;

      players = level.players;
      for(i = 0; i < players.size; i++) {
        if(!isalive(players[i]) || players[i].sessionstate != "playing") {
          continue;
        }

        playerpos = get_damageable_player_pos(players[i]);
        distSq = distanceSquared(pos, playerpos);
        if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, playerpos, startRadius, players[i]))) {
          ents[ents.size] = get_damageable_player(players[i], playerpos);
        }
      }

      grenades = getEntArray("grenade", "classname");
      for(i = 0; i < grenades.size; i++) {
        entpos = get_damageable_grenade_pos(grenades[i]);
        distSq = distanceSquared(pos, entpos);
        if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, grenades[i]))) {
          ents[ents.size] = get_damageable_grenade(grenades[i], entpos);
        }
      }

      destructibles = getEntArray("destructible", "targetname");
      for(i = 0; i < destructibles.size; i++) {
        entpos = destructibles[i].origin;
        distSq = distanceSquared(pos, entpos);
        if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, destructibles[i]))) {
          newent = spawnStruct();
          newent.isPlayer = false;
          newent.isADestructable = false;
          newent.entity = destructibles[i];
          newent.damageCenter = entpos;
          ents[ents.size] = newent;
        }
      }

      destructables = getEntArray("destructable", "targetname");
      for(i = 0; i < destructables.size; i++) {
        entpos = destructables[i].origin;
        distSq = distanceSquared(pos, entpos);
        if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, destructables[i]))) {
          newent = spawnStruct();
          newent.isPlayer = false;
          newent.isADestructable = true;
          newent.entity = destructables[i];
          newent.damageCenter = entpos;
          ents[ents.size] = newent;
        }
      }

      sentries = getEntArray("misc_turret", "classname");
      foreach(sentry in sentries) {
        entpos = sentry.origin + (0, 0, 32);
        distSq = distanceSquared(pos, entpos);
        if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, sentry))) {
          switch (sentry.model) {
            case "sentry_minigun_weak":
            case "mp_scramble_turret":
            case "mp_remote_turret":
            case "vehicle_ugv_talon_gun_mp":
            case "vehicle_ugv_talon_gun_cloaked_mp":
              ents[ents.size] = get_damageable_sentry(sentry, entpos);
              break;
          }
        }
      }

      mines = getEntArray("script_model", "classname");
      foreach(mine in mines) {
        if(mine.model != "projectile_bouncing_betty_grenade" && mine.model != "ims_scorpion_body") {
          continue;
        }

        entpos = mine.origin + (0, 0, 32);
        distSq = distanceSquared(pos, entpos);
        if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, mine))) {
          ents[ents.size] = get_damageable_mine(mine, entpos);
        }
      }

      return ents;
    }

    getEMPDamageEnts(pos, radius, doLOS, startRadius) {
      ents = [];

      if(!isDefined(doLOS)) {
        doLOS = false;
      }

      if(!isDefined(startRadius)) {
        startRadius = 0;
      }

      grenades = getEntArray("grenade", "classname");
      foreach(grenade in grenades) {
        entpos = grenade.origin;
        dist = distance(pos, entpos);
        if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, grenade))) {
          ents[ents.size] = grenade;
        }
      }

      turrets = getEntArray("misc_turret", "classname");
      foreach(turret in turrets) {
        entpos = turret.origin;
        dist = distance(pos, entpos);
        if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, turret))) {
          ents[ents.size] = turret;
        }
      }

      return ents;
    }

    weaponDamageTracePassed(from, to, startRadius, ent) {
      midpos = undefined;

      diff = to - from;
      if(lengthsquared(diff) < startRadius * startRadius) {
        return true;
      }

      dir = vectornormalize(diff);
      midpos = from + (dir[0] * startRadius, dir[1] * startRadius, dir[2] * startRadius);

      trace = bulletTrace(midpos, to, false, ent);

      if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
        thread debugprint(from, ".dmg");
        if(isDefined(ent)) {
          thread debugprint(to, "." + ent.classname);
        } else {
          thread debugprint(to, ".undefined");
        }
        if(trace["fraction"] == 1) {
          thread debugline(midpos, to, (1, 1, 1));
        } else {
          thread debugline(midpos, trace["position"], (1, .9, .8));
          thread debugline(trace["position"], to, (1, .4, .3));
        }
      }

      return (trace["fraction"] == 1);
    }

    damageEnt(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, damagepos, damagedir) {
      if(self.isPlayer) {
        self.damageOrigin = damagepos;
        self.entity thread[[level.callbackPlayerDamage]](
          eInflictor, eAttacker, iDamage, 0, sMeansOfDeath, sWeapon, damagepos, damagedir, "none", 0
        );
      } else {
        if(self.isADestructable && (sWeapon == "artillery_mp" || sWeapon == "claymore_mp" || sWeapon == "stealth_bomb_mp")) {
          return;
        }

        self.entity notify("damage", iDamage, eAttacker, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, sWeapon);
      }
    }

    debugline(a, b, color) {
      for(i = 0; i < 30 * 20; i++) {
        line(a, b, color);
        wait .05;
      }
    }

    debugcircle(center, radius, color, segments) {
      if(!isDefined(segments)) {
        segments = 16;
      }

      angleFrac = 360 / segments;
      circlepoints = [];

      for(i = 0; i < segments; i++) {
        angle = (angleFrac * i);
        xAdd = cos(angle) * radius;
        yAdd = sin(angle) * radius;
        x = center[0] + xAdd;
        y = center[1] + yAdd;
        z = center[2];
        circlepoints[circlepoints.size] = (x, y, z);
      }

      for(i = 0; i < circlepoints.size; i++) {
        start = circlepoints[i];
        if(i + 1 >= circlepoints.size) {
          end = circlepoints[0];
        } else {
          end = circlepoints[i + 1];
        }

        thread debugline(start, end, color);
      }
    }

    debugprint(pt, txt) {
      for(i = 0; i < 30 * 20; i++) {
        print3d(pt, txt);
        wait .05;
      }
    }

    onWeaponDamage(eInflictor, sWeapon, meansOfDeath, damage, eAttacker) {
      self endon("death");
      self endon("disconnect");

      radius_max = 700;
      radius_min = 25;
      radius_max_sq = radius_max * radius_max;
      radius_min_sq = radius_min * radius_min;

      viewHeightStanding = 60;
      viewHeightCrouching = 40;
      viewHeightProne = 11;

      if(IsSubStr(sWeapon, "_uts19_")) {
        self thread uts19Shock(eInflictor);
      } else {
        shortWeapon = maps\mp\_utility::strip_suffix(sWeapon, "_lefthand");

        switch (shortWeapon) {
          case "stun_grenade_mp":
          case "stun_grenade_var_mp":
          case "stun_grenade_horde_mp":
            inflictorOrigin = eInflictor.origin;

            dist_sq = DistanceSquared(inflictorOrigin, self.origin);
            if(dist_sq > radius_max_sq) {
              return;
            }

            amountSeen = self SightConeTrace(inflictorOrigin);
            if(amountSeen < 0.5) {
              return;
            }

            if(dist_sq <= radius_min_sq) {
              percent_distance = 1.0;
            } else {
              percent_distance = 1.0 - (dist_sq - radius_min_sq) / (radius_max_sq - radius_min_sq);
            }

            forward = anglesToForward(self GetPlayerAngles());

            viewOrigin = self.origin;
            switch (self GetStance()) {
              case "stand":
                viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightStanding);
                break;
              case "crouch":
                viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightCrouching);
                break;
              case "prone":
                viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightProne);
                break;
            }
            toBlast = inflictorOrigin - viewOrigin;
            toBlast = VectorNormalize(toBlast);

            percent_angle = 0.5 * (1.0 + VectorDot(forward, toBlast));

            if(!isDefined(eInflictor)) {
              return;
            } else if(meansOfDeath == "MOD_IMPACT") {
              return;
            }

            giveFeedback = true;
            if(isDefined(eInflictor.owner) && eInflictor.owner == eAttacker) {
              giveFeedback = false;
            }

            time = 3;

            if(isDefined(self.stunScaler)) {
              time = time * self.stunScaler;
            }

            wait(0.05);
            self notify("concussed", eAttacker);
            if(eAttacker != self) {
              eAttacker maps\mp\gametypes\_missions::processChallenge("ch_alittleconcussed");
            }
            flashDuration = percent_distance * percent_angle * time;
            self shellShock("stun_grenade_mp", flashDuration, 0, 1, percent_distance * time);
            self.concussionEndTime = getTime() + (time * 1000);
            if(flashDuration > 0.1) {
              self thread light_set_override_for_player("flashed", 0.1, 0.1, (percent_distance * percent_angle * time) - 0.1);
            }
            if(giveFeedback && eAttacker != self) {
              eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("stun");
            }

            break;
          case "concussion_grenade_mp":

            if(!isDefined(eInflictor)) {
              return;
            } else if(meansOfDeath == "MOD_IMPACT") {
              return;
            }

            giveFeedback = true;
            if(isDefined(eInflictor.owner) && eInflictor.owner == eAttacker) {
              giveFeedback = false;
            }

            radius = 512;
            scale = 1 - (distance(self.origin, eInflictor.origin) / radius);

            if(scale < 0) {
              scale = 0;
            }

            time = 2 + (4 * scale);

            if(isDefined(self.stunScaler)) {
              time = time * self.stunScaler;
            }

            wait(0.05);
            self notify("concussed", eAttacker);
            if(eAttacker != self) {
              eAttacker maps\mp\gametypes\_missions::processChallenge("ch_alittleconcussed");
            }
            self shellShock("concussion_grenade_mp", time);
            self.concussionEndTime = getTime() + (time * 1000);
            if(giveFeedback && eAttacker != self) {
              eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("stun");
            }
            break;

          case "weapon_cobra_mk19_mp":

            break;

          default:

            maps\mp\gametypes\_shellshock::shellshockOnDamage(meansOfDeath, damage);
            break;
        }
      }
    }

    uts19Shock(eInflictor) {
      if(GetDvarInt("scr_game_uts19_shock", 0) == 0) {
        return;
      }

      if(!isDefined(eInflictor)) {
        return;
      }

      minConcussionTime = 0.45;
      maxConcussionTime = 1.2;

      maxConcussionRange = 250;
      minConcussionRange = 700;

      normalizedDistance = (distance(self.origin, eInflictor.origin) - maxConcussionRange) / (minConcussionRange - maxConcussionRange);
      scale = 1 - normalizedDistance;
      scale = clamp(scale, 0, 1);

      time = minConcussionTime + ((maxConcussionTime - minConcussionTime) * scale);

      if(isDefined(self.utsShockQueuedTime)) {
        if(self.utsShockQueuedTime >= time) {
          return;
        }
      }

      self.utsShockQueuedTime = time;

      self shellShock("uts19_mp", time);

      waittillframeend;
      if(isDefined(self)) {
        self.utsShockQueuedTime = undefined;
      }
    }

    isPrimaryWeapon(weapName) {
      if(weapName == "none") {
        return false;
      }

      if(weaponInventoryType(weapName) != "primary") {
        return false;
      }

      switch (weaponClass(weapName)) {
        case "rifle":
        case "smg":
        case "mg":
        case "spread":
        case "pistol":
        case "rocketlauncher":
        case "sniper":
        case "beam":
          return true;

        default:
          return false;
      }
    }

    isBulletWeapon(weapName) {
      if(weapName == "none") {
        return false;
      }

      switch (getWeaponClass(weapName)) {
        case "weapon_assault":
        case "weapon_smg":
        case "weapon_lmg":
        case "weapon_shotgun":
        case "weapon_pistol":
        case "weapon_sniper":
        case "weapon_machine_pistol":
          return true;

        case "weapon_heavy":
          return IsSubStr(weapName, "exoxmg") || IsSubStr(weapName, "lsat") || IsSubStr(weapName, "asaw");

        default:
          return false;
      }
    }

    isBeamWeapon(weaponName) {
      return IsSubStr(weaponName, "em1") || IsSubStr(weaponName, "epm3");
    }

    isAltModeWeapon(weapName) {
      if(weapName == "none") {
        return false;
      }

      return (weaponInventoryType(weapName) == "altmode");
    }

    isInventoryWeapon(weapName) {
      if(weapName == "none") {
        return false;
      }

      return (weaponInventoryType(weapName) == "item");
    }

    isRiotShield(weapName) {
      if(weapName == "none") {
        return false;
      }

      return (WeaponType(weapName) == "riotshield");
    }

    isOffhandWeapon(weapName) {
      if(weapName == "none") {
        return false;
      }

      return (weaponInventoryType(weapName) == "offhand");
    }

    isSideArm(weapName) {
      if(weapName == "none") {
        return false;
      }

      if(weaponInventoryType(weapName) != "primary") {
        return false;
      }

      return (weaponClass(weapName) == "pistol");
    }

    isGrenade(weapName) {
      weapClass = weaponClass(weapName);
      weapType = weaponInventoryType(weapName);

      if(weapClass != "grenade") {
        return false;
      }

      if(weapType != "offhand") {
        return false;
      }

      return true;
    }

    isValidLastWeapon(weapon) {
      if(weapon == "none") {
        return false;
      }

      weaponInvType = weaponInventoryType(weapon);
      return (weaponInvType == "primary") || (weaponInvType == "altmode");
    }

    updateSavedLastWeapon() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      currentWeapon = self.currentWeaponAtSpawn;
      self.saved_lastWeapon = currentWeapon;

      self setWeaponUsageVariables(currentWeapon);

      for(;;) {
        self waittill("weapon_change", newWeapon);

        self updateWeaponUsageStats(newWeapon);

        if(isValidMoveSpeedScaleWeapon(newWeapon)) {
          self updateMoveSpeedScale();
        }

        self.saved_lastWeapon = currentWeapon;
        if(isValidLastWeapon(newWeapon)) {
          currentWeapon = newWeapon;
        }
      }
    }

    updateWeaponUsageStats(newWeapon) {
      timeInUse = int((GetTime() - self.weaponUsageStartTime) / 1000);

      self thread setWeaponStat(self.weaponUsageName, timeInUse, "timeInUse");
      self setWeaponUsageVariables(newWeapon);
    }

    setWeaponUsageVariables(newWeapon) {
      self.weaponUsageName = newWeapon;
      self.weaponUsageStartTime = GetTime();
    }

    EMPPlayer(numSeconds) {
      self endon("disconnect");
      self endon("death");

      self thread clearEMPOnDeath();
    }

    clearEMPOnDeath() {
      self endon("disconnect");

      self waittill("death");
    }

    WEAPON_WEIGHT_VALUE_DEFAULT = 8;
    getWeaponHeaviestValue() {
      heaviestWeaponValue = 1000;

      self.weaponList = self GetWeaponsListPrimaries();
      if(self.weaponList.size) {
        foreach(weapon in self.weaponList) {
          weaponWeight = getWeaponWeight(weapon);

          if(weaponWeight == 0) {
            continue;
          }

          if(weaponWeight < heaviestWeaponValue) {
            heaviestWeaponValue = weaponWeight;
          }
        }

        if(heaviestWeaponValue == 1000) {
          AssertMsg("No weapons of non zero speed");

          foreach(weapon in self.weaponList) {
            AssertMsg("Weapon Name:" + weapon);
          }
        }

        if(heaviestWeaponValue > 10) {
          heaviestWeaponValue = 10;
        }
      } else {
        heaviestWeaponValue = WEAPON_WEIGHT_VALUE_DEFAULT;
      }

      heaviestWeaponValue = clampWeaponWeightValue(heaviestWeaponValue);

      return heaviestWeaponValue;
    }

    getWeaponWeight(weapon) {
      weaponSpeed = undefined;
      baseWeapon = getBaseWeaponName(weapon);

      if(isDefined(level.weaponWeightFunc)) {
        return [}
          [level.weaponWeightFunc]](baseWeapon);

      weaponSpeed = Int(TableLookup("mp/statstable.csv", 4, baseWeapon, 8));

      return weaponSpeed;
    }

    clampWeaponWeightValue(value) {
      return clamp(value, 0.0, 10.0);
    }

    isValidMoveSpeedScaleWeapon(weapon) {
      if(isValidLastWeapon(weapon)) {
        return true;
      }

      weaponClass = WeaponClass(weapon);
      if(weaponClass == "ball") {
        return true;
      }

      return false;
    }

    updateMoveSpeedScale() {
      weaponWeight = undefined;

      self.weaponList = self GetWeaponsListPrimaries();
      if(!self.weaponList.size) {
        weaponWeight = WEAPON_WEIGHT_VALUE_DEFAULT;
      } else {
        weapon = self GetCurrentWeapon();

        if(!isValidMoveSpeedScaleWeapon(weapon)) {
          if(isDefined(self.saved_lastWeapon)) {
            weapon = self.saved_lastWeapon;
          } else {
            weapon = undefined;
          }
        }

        if(!isDefined(weapon) || !self HasWeapon(weapon)) {
          weaponWeight = self getWeaponHeaviestValue();
        } else if(getBaseWeaponName(weapon) == "iw5_underwater") {
          weaponWeight = 5;
        } else {
          weaponWeight = getWeaponWeight(weapon);

          if(GetDvarInt("scr_allow_weightless_weapons", 0) > 0) {
            if(!isDefined(weaponWeight) || weaponWeight == 0) {
              DebugPrint("WARNING: forcing weapon weight because weapon " + getBaseWeaponName(weapon) + " is missing player speed in statstable.csv, this will lock player in position for non-dev builds.");
              weaponWeight = 10;
            }
          }

          weaponWeight = clampWeaponWeightValue(weaponWeight);
        }
      }

      normalizedWeaponSpeed = weaponWeight / 10;

      self.weaponSpeed = normalizedWeaponSpeed;
      assert(isDefined(self.weaponSpeed));
      assert(isDefined(self.moveSpeedScaler));
      self setMoveSpeedScale(normalizedWeaponSpeed * self.moveSpeedScaler);
    }

    stanceRecoilAdjuster() {
      if(!isPlayer(self)) {
        return;
      }

      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      self notifyOnPlayerCommand("adjustedStance", "+stance");
      self notifyOnPlayerCommand("adjustedStance", "+goStand");

      for(;;) {
        self waittill_any("adjustedStance", "sprint_begin", "weapon_change");

        wait(.5);

        self.stance = self GetStance();

        if(self.stance == "prone") {
          weapName = self GetCurrentPrimaryWeapon();
          weapClass = getWeaponClass(weapName);
          if(weapClass == "weapon_lmg") {
            self setRecoilScale(0, 40);
          } else if(weapClass == "weapon_sniper") {
            self setRecoilScale(0, 60);
          } else {
            self setRecoilScale();
          }
        } else if(self.stance == "crouch") {
          weapName = self GetCurrentPrimaryWeapon();
          weapClass = getWeaponClass(weapName);
          if(weapClass == "weapon_lmg") {
            self setRecoilScale(0, 10);
          } else if(weapClass == "weapon_sniper") {
            self setRecoilScale(0, 30);
          } else {
            self setRecoilScale();
          }
        } else {
          self setRecoilScale();
        }
      }
    }

    buildWeaponData(filterPerks) {
      attachmentList = getAttachmentListBaseNames();
      attachmentList = alphabetize(attachmentList);
      max_weapon_num = 4000;
      max_attachment_num = 30;

      baseWeaponData = [];

      for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
        gametype = getDvar("g_gametype");
        baseName = tablelookup("mp/statstable.csv", 0, weaponId, 4);
        if(baseName == "") {
          continue;
        }

        if(IsSubStr(baseName, "dummy")) {
          continue;
        }

        if(IsSubStr(baseName, "reinforcement")) {
          continue;
        }

        if(tableLookup("mp/statsTable.csv", 0, weaponId, 51) != "") {
          continue;
        }

        assetName = baseName + "_mp";

        if(!isSubStr(tableLookup("mp/statsTable.csv", 0, weaponId, 2), "weapon_")) {
          continue;
        }

        if(weaponInventoryType(assetName) != "primary") {
          continue;
        }

        weaponInfo = spawnStruct();
        weaponInfo.baseName = baseName;
        weaponInfo.assetName = assetName;
        weaponInfo.variants = [];

        weaponInfo.variants[0] = assetName;

        attachmentNames = [];
        for(innerLoopCount = 0; innerLoopCount < max_attachment_num; innerLoopCount++) {
          attachmentName = tablelookup("mp/statStable.csv", 0, weaponId, innerLoopCount + 11);
          if(filterPerks) {
            switch (attachmentName) {
              case "xmags":
                continue;
            }
          }

          if(attachmentName == "") {
            continue;
          }

          attachmentNames[attachmentName] = true;
        }

        attachments = [];
        foreach(attachmentName in attachmentList) {
          if(!isDefined(attachmentNames[attachmentName])) {
            continue;
          }

          realAttachmentName = attachmentMap_toUnique(attachmentName, assetName);

          weaponInfo.variants[weaponInfo.variants.size] = baseName + "_mp_" + realAttachmentName;
          attachments[attachments.size] = realAttachmentName;
        }

        for(i = 0; i < (attachments.size - 1); i++) {
          colIndex = tableLookupRowNum("mp/attachmentCombos.csv", 0, attachments[i]);
          for(j = i + 1; j < attachments.size; j++) {
            if(tableLookup("mp/attachmentCombos.csv", 0, attachments[j], colIndex) == "no") {
              continue;
            }

            weaponInfo.variants[weaponInfo.variants.size] = baseName + "_mp_" + attachments[i] + "_" + attachments[j];
          }
        }

        baseWeaponData[baseName] = weaponInfo;
      }

      return (baseWeaponData);
    }

    monitorSemtex() {
      self endon("disconnect");
      self endon("death");
      self endon("faux_spawn");

      for(;;) {
        self waittill("grenade_fire", weapon);

        if(!isDefined(weapon)) {
          continue;
        }
        if(!isDefined(weapon.weaponname)) {
          continue;
        }
        if(!isSubStr(weapon.weaponname, "semtex")) {
          continue;
        }

        weapon thread monitorSemtexStick();
      }
    }

    monitorSemtexStick() {
      self.owner endon("disconnect");
      self.owner endon("death");
      self.owner endon("faux_spawn");

      self waittill("missile_stuck", stuckTo);

      self thread stickyHandleMovers("detonate");

      if(!isPlayer(stuckTo)) {
        return;
      }

      if(self.owner isStuckToFriendly(stuckTo)) {
        self.owner.isStuck = "friendly";
        return;
      }

      self.isStuck = "enemy";
      self.stuckEnemyEntity = stuckTo;

      self.owner maps\mp\_events::semtexStickEvent(stuckTo);
      self.owner notify("process", "ch_bullseye");
    }

    isStuckToFriendly(stuckTo) {
      return (level.teamBased && isDefined(stuckTo.team) && (stuckTo.team == self.team));
    }

    turret_monitorUse() {
      for(;;) {
        self waittill("trigger", player);

        self thread turret_playerThread(player);
      }
    }

    turret_playerThread(player) {
      player endon("death");
      player endon("disconnect");

      player notify("weapon_change", "none");

      self waittill("turret_deactivate");

      player notify("weapon_change", player getCurrentWeapon());
    }

    spawnMine(origin, owner, weaponName, angles, lethal) {
      Assert(isDefined(owner));

      if(!isDefined(angles)) {
        angles = (0, RandomFloat(360), 0);
      }

      model = "projectile_bouncing_betty_grenade";
      mine = spawn("script_model", origin);
      mine.angles = angles;
      mine setModel(model);
      mine.owner = owner;
      mine.stunned = false;
      mine SetOtherEnt(owner);
      mine.weaponName = "bouncingbetty_mp";
      level.mines[level.mines.size] = mine;

      mine.killCamOffset = (0, 0, 4);
      mine.killCamEnt = spawn("script_model", mine.origin + mine.killCamOffset);

      mine.killCamEnt SetScriptMoverKillCam("explosive");

      owner.equipmentMines = array_removeUndefined(owner.equipmentMines);
      if(owner.equipmentMines.size >= level.maxPerPlayerExplosives) {
        owner.equipmentMines[0] delete();
      }

      owner.equipmentMines[owner.equipmentMines.size] = mine;

      mine thread createBombSquadModel("projectile_bouncing_betty_grenade_bombsquad", "tag_origin", owner);
      mine thread mineBeacon();
      mine thread setMineTeamHeadIcon(owner.pers["team"]);
      mine thread mineDamageMonitor();
      mine thread mineProximityTrigger();

      parent = self GetLinkedParent();
      if(isDefined(parent)) {
        mine linkto(parent);
      }

      mine makeExplosiveTargetableByAI(!lethal);

      return mine;
    }

    mineDamageMonitor() {
      self endon("mine_triggered");
      self endon("mine_selfdestruct");
      self endon("death");

      self setCanDamage(true);
      self.maxhealth = 100000;
      self.health = self.maxhealth;

      attacker = undefined;

      while(1) {
        self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

        if(!isPlayer(attacker) && !IsAgent(attacker)) {
          continue;
        }

        if(isDefined(weapon) && weapon == "bouncingbetty_mp") {
          continue;
        }

        if(!friendlyFireCheck(self.owner, attacker)) {
          continue;
        }

        if(isDefined(weapon)) {
          shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

          switch (shortWeapon) {
            case "smoke_grenade_mp":
            case "smoke_grenade_var_mp":
              continue;
          }
        }

        break;
      }

      self notify("mine_destroyed");

      if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE"))) {
        self.wasChained = true;
      }

      if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
        self.wasDamagedFromBulletPenetration = true;
      }

      self.wasDamaged = true;

      if(isPlayer(attacker)) {
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("bouncing_betty");
      }

      if(level.teamBased) {
        if(isDefined(attacker) && isDefined(self.owner)) {
          attacker_pers_team = attacker.pers["team"];
          self_owner_pers_team = self.owner.pers["team"];
          if(isDefined(attacker_pers_team) && isDefined(self_owner_pers_team) && attacker_pers_team != self_owner_pers_team) {
            attacker notify("destroyed_explosive");
          }
        }
      } else {
        if(isDefined(self.owner) && isDefined(attacker) && attacker != self.owner) {
          attacker notify("destroyed_explosive");
        }
      }

      self thread mineExplode(attacker);
    }

    mineProximityTrigger() {
      self endon("mine_destroyed");
      self endon("mine_selfdestruct");
      self endon("death");

      wait(2);

      trigger = spawn("trigger_radius", self.origin, 0, level.mineDetectionRadius, level.mineDetectionHeight);
      trigger.owner = self;
      self thread mineDeleteTrigger(trigger);

      player = undefined;
      while(1) {
        trigger waittill("trigger", player);

        if(self.stunned) {
          continue;
        }

        if(getdvarint("scr_minesKillOwner") != 1) {
          if(isDefined(self.owner)) {
            if(player == self.owner) {
              continue;
            }
            if(isDefined(player.owner) && player.owner == self.owner) {
              continue;
            }
          }

          if(!friendlyFireCheck(self.owner, player, 0)) {
            continue;
          }
        }

        if(lengthsquared(player getEntityVelocity()) < 10) {
          continue;
        }

        if(player damageConeTrace(self.origin, self) > 0) {
          break;
        }
      }

      self notify("mine_triggered");

      self playSound("mine_betty_click");

      if(isPlayer(player) && player _hasPerk("specialty_delaymine")) {
        player notify("triggered_mine");
        wait level.delayMineTime;
      } else {
        wait level.mineDetectionGracePeriod;
      }

      self thread mineBounce();
    }

    mineDeleteTrigger(trigger) {
      self waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

      trigger delete();
    }

    mineSelfDestruct() {
      self endon("mine_triggered");
      self endon("mine_destroyed");
      self endon("death");

      wait(level.mineSelfDestructTime);
      wait RandomFloat(0.4);

      self notify("mine_selfdestruct");
      self thread mineExplode();
    }

    mineBounce() {
      self playSound("mine_betty_spin");
      playFX(level.mine_launch, self.origin);

      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      explodePos = self.origin + (0, 0, 64);
      self MoveTo(explodePos, 0.7, 0, .65);
      self.killCamEnt MoveTo(explodePos + self.killCamOffset, 0.7, 0, .65);

      self RotateVelocity((0, 750, 32), 0.7, 0, .65);
      self thread playSpinnerFX();

      wait(0.65);

      self thread mineExplode();
    }

    mineExplode(attacker) {
      if(!isDefined(self) || !isDefined(self.owner)) {
        return;
      }

      if(!isDefined(attacker)) {
        attacker = self.owner;
      }

      self playSound("null");

      tagOrigin = self GetTagOrigin("tag_fx");
      playFX(level.mine_explode, tagOrigin);

      wait(0.05);
      if(!isDefined(self) || !isDefined(self.owner)) {
        return;
      }

      self Hide();
      self RadiusDamage(self.origin, level.mineDamageRadius, level.mineDamageMax, level.mineDamageMin, attacker, "MOD_EXPLOSIVE");

      if(isDefined(self.owner) && isDefined(level.leaderDialogOnPlayer_func)) {
        self.owner thread[[level.leaderDialogOnPlayer_func]]("mine_destroyed", undefined, undefined, self.origin);
      }

      wait(0.2);
      if(!isDefined(self) || !isDefined(self.owner)) {
        return;
      }

      if(isDefined(self.trigger)) {
        self.trigger delete();
      }

      self.killCamEnt delete();
      self delete();
    }

    mineStunBegin() {
      if(self.stunned) {
        return;
      }

      self.stunned = true;
      playFXOnTag(getfx("mine_stunned"), self, "tag_origin");
    }

    mineStunEnd() {
      self.stunned = false;
      stopFXOnTag(getfx("mine_stunned"), self, "tag_origin");
    }

    mineChangeOwner(newOwner) {
      if(isDefined(self.weaponName)) {
        if(isDefined(self.entityHeadIcon)) {
          self.entityHeadIcon destroy();
        }

        if(self.weaponName == "bouncingbetty_mp") {
          if(isDefined(self.trigger)) {
            self.trigger delete();
          }

          if(isDefined(self.effect["friendly"])) {
            self.effect["friendly"] delete();
          }

          if(isDefined(self.effect["enemy"])) {
            self.effect["enemy"] delete();
          }

          for(i = 0; i < self.owner.equipmentMines.size; i++) {
            if(self.owner.equipmentMines[i] == self) {
              self.owner.equipmentMines[i] = undefined;
            }
          }
          self.owner.equipmentMines = array_removeUndefined(self.owner.equipmentMines);

          self notify("change_owner");

          self.owner = newOwner;
          self.owner.equipmentMines[self.owner.equipmentMines.size] = self;
          self.team = newOwner.team;
          self SetOtherEnt(newOwner);
          self.trigger = spawn("script_origin", self.origin + (0, 0, 25));
          self.trigger.owner = self;

          self equipmentDisableUse(newOwner);
          self thread mineBeacon();
          self thread setMineTeamHeadIcon(newOwner.team);
          newOwner thread mineWatchOwnerDisconnect(self);
          newOwner thread mineWatchOwnerChangeTeams(self);
        } else if(self.weaponName == "claymore_mp") {
          if(isDefined(self.trigger)) {
            self.trigger delete();
          }

          for(i = 0; i < self.owner.claymorearray.size; i++) {
            if(self.owner.claymorearray[i] == self) {
              self.owner.claymorearray[i] = undefined;
            }
          }
          self.owner.claymorearray = array_removeUndefined(self.owner.claymorearray);

          self notify("change_owner");

          self.owner = newOwner;
          self.owner.claymorearray[self.owner.claymorearray.size] = self;
          self.team = newOwner.team;
          self SetOtherEnt(newOwner);
          self.trigger = spawn("script_origin", self.origin);
          self.trigger.owner = self;

          self equipmentDisableUse(newOwner);
          self thread setMineTeamHeadIcon(newOwner.team);
          newOwner thread mineWatchOwnerDisconnect(self);
          newOwner thread mineWatchOwnerChangeTeams(self);
          self thread claymoreDetonation();
        } else if(self.weaponName == "c4_mp") {
          detonatedByEmptyThrow = false;
          detonatedByDoubleTap = false;
          for(i = 0; i < self.owner.manuallyDetonatedArray.size; i++) {
            if(self.owner.manuallyDetonatedArray[i][0] == self) {
              self.owner.manuallyDetonatedArray[i][0] = undefined;
              detonatedByEmptyThrow = self.owner.manuallyDetonatedArray[i][1];
              detonatedByDoubleTap = self.owner.manuallyDetonatedArray[i][2];
            }
          }
          self.owner.manuallyDetonatedArray = manuallyDetonated_removeUndefined(self.owner.manuallyDetonatedArray);

          self notify("change_owner");

          self.owner = newOwner;
          newIndex = self.owner.manuallyDetonatedArray.size;
          self.owner.manuallyDetonatedArray[newIndex] = [];
          self.owner.manuallyDetonatedArray[newIndex][0] = self;
          self.owner.manuallyDetonatedArray[newIndex][1] = detonatedByEmptyThrow;
          self.owner.manuallyDetonatedArray[newIndex][2] = detonatedByDoubleTap;
          self.team = newOwner.team;
          self SetOtherEnt(newOwner);

          self equipmentDisableUse(newOwner);
          self thread setMineTeamHeadIcon(newOwner.team);
        }
      }

    }

    playSpinnerFX() {
      self endon("death");

      timer = gettime() + 1000;

      while(gettime() < timer) {
        wait .05;
        playFXOnTag(level.mine_spin, self, "tag_fx_spin1");
        playFXOnTag(level.mine_spin, self, "tag_fx_spin3");
        wait .05;
        playFXOnTag(level.mine_spin, self, "tag_fx_spin2");
        playFXOnTag(level.mine_spin, self, "tag_fx_spin4");
      }
    }

    mineDamageDebug(damageCenter, recieverCenter, radiusSq, ignoreEnt, damageTop, damageBottom) {
      color[0] = (1, 0, 0);
      color[1] = (0, 1, 0);

      if(recieverCenter[2] < damageBottom) {
        pass = false;
      } else {
        pass = true;
      }

      damageBottomOrigin = (damageCenter[0], damageCenter[1], damageBottom);
      recieverBottomOrigin = (recieverCenter[0], recieverCenter[1], damageBottom);
      thread debugcircle(damageBottomOrigin, level.mineDamageRadius, color[pass], 32);

      distSq = distanceSquared(damageCenter, recieverCenter);
      if(distSq > radiusSq) {
        pass = false;
      } else {
        pass = true;
      }

      thread debugline(damageBottomOrigin, recieverBottomOrigin, color[pass]);
    }

    mineDamageHeightPassed(mine, victim) {
      if(isPlayer(victim) && isAlive(victim) && victim.sessionstate == "playing") {
        victimPos = victim getStanceCenter();
      } else if(victim.classname == "misc_turret") {
        victimPos = victim.origin + (0, 0, 32);
      } else {
        victimPos = victim.origin;
      }

      tempZOffset = 0;
      damageTop = mine.origin[2] + tempZOffset + level.mineDamageHalfHeight;
      damageBottom = mine.origin[2] + tempZOffset - level.mineDamageHalfHeight;

      if(victimPos[2] > damageTop || victimPos[2] < damageBottom) {
        return false;
      }

      return true;
    }

    watchSlide() {
      self endon("disconnect");
      self endon("spawned_player");
      self endon("faux_spawn");

      while(true) {
        self.isSiliding = false;

        self waittill("sprint_slide_begin");

        self.isSiliding = true;

        self waittill("sprint_slide_end");
      }
    }

    watchMineUsage() {
      self endon("disconnect");
      self endon("spawned_player");
      self endon("faux_spawn");

      if(isDefined(self.equipmentMines)) {
        if(getIntProperty("scr_deleteexplosivesonspawn", 1) == 1) {
          if(isDefined(self.dont_delete_mines_on_next_spawn)) {
            self.dont_delete_mines_on_next_spawn = undefined;
          } else {
            self delete_all_mines();
          }
        }
      } else {
        self.equipmentMines = [];
      }

      if(!isDefined(self.killstreakMines)) {
        self.killstreakMines = [];
      }

      for(;;) {
        self waittill("grenade_fire", projectile, weaponName);
        if(weaponName == "bouncingbetty" || weaponName == "bouncingbetty_mp") {
          if(!IsAlive(self)) {
            projectile delete();
            return;
          }

          maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

          projectile thread mineThrown(self, true);
        }
      }
    }

    mineThrown(owner, lethal) {
      self.owner = owner;

      self waittill("missile_stuck");

      if(!isDefined(owner)) {
        return;
      }

      trace = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), false, self);

      pos = trace["position"];
      if(trace["fraction"] == 1) {
        pos = GetGroundPosition(self.origin, 12, 0, 32);
        trace["normal"] *= -1;
      }

      normal = vectornormalize(trace["normal"]);
      plantAngles = vectortoangles(normal);
      plantAngles += (90, 0, 0);

      mine = spawnMine(pos, owner, undefined, plantAngles, lethal);
      mine.trigger = spawn("script_origin", mine.origin + (0, 0, 25));
      mine.trigger.owner = mine;
      mine thread equipmentWatchUse(owner);
      owner thread mineWatchOwnerDisconnect(mine);
      owner thread mineWatchOwnerChangeTeams(mine);

      self delete();
    }

    mineWatchOwnerDisconnect(mine) {
      mine endon("death");
      level endon("game_ended");
      mine endon("change_owner");

      self waittill("disconnect");

      if(isDefined(mine.trigger)) {
        mine.trigger delete();
      }

      mine delete();
    }

    mineWatchOwnerChangeTeams(mine) {
      mine endon("death");
      level endon("game_ended");
      mine endon("change_owner");

      self waittill_either("joined_team", "joined_spectators");

      if(isDefined(mine.trigger)) {
        mine.trigger delete();
      }

      mine delete();
    }

    mineBeacon() {
      self endon("change_owner");

      self.effect["friendly"] = SpawnFx(level.mine_beacon["friendly"], self getTagOrigin("tag_fx"));
      self.effect["enemy"] = SpawnFx(level.mine_beacon["enemy"], self getTagOrigin("tag_fx"));

      self thread mineBeaconTeamUpdater();
      self waittill("death");

      self.effect["friendly"] delete();
      self.effect["enemy"] delete();
    }

    mineBeaconTeamUpdater() {
      self endon("death");
      self endon("change_owner");

      ownerTeam = self.owner.team;

      wait(0.05);

      TriggerFx(self.effect["friendly"]);
      TriggerFx(self.effect["enemy"]);

      for(;;) {
        self.effect["friendly"] Hide();
        self.effect["enemy"] Hide();

        foreach(player in level.players) {
          if(level.teamBased) {
            if(player.team == ownerTeam) {
              self.effect["friendly"] ShowToPlayer(player);
            } else {
              self.effect["enemy"] ShowToPlayer(player);
            }
          } else {
            if(player == self.owner) {
              self.effect["friendly"] ShowToPlayer(player);
            } else {
              self.effect["enemy"] ShowToPlayer(player);
            }
          }
        }

        level waittill_either("joined_team", "player_spawned");
      }
    }

    delete_all_grenades() {
      if(isDefined(self.manuallyDetonatedArray)) {
        for(i = 0; i < self.manuallyDetonatedArray.size; i++) {
          if(isDefined(self.manuallyDetonatedArray[i][0])) {
            if(isDefined(self.manuallyDetonatedArray[i][0].trigger)) {
              self.manuallyDetonatedArray[i][0].trigger delete();
            }

            self.manuallyDetonatedArray[i][0] delete();
          }
        }
      }
      self.manuallyDetonatedArray = [];

      if(isDefined(self.claymorearray)) {
        for(i = 0; i < self.claymorearray.size; i++) {
          if(isDefined(self.claymorearray[i])) {
            if(isDefined(self.claymorearray[i].trigger)) {
              self.claymorearray[i].trigger delete();
            }

            self.claymorearray[i] delete();
          }
        }
      }
      self.claymorearray = [];

      if(isDefined(self.bouncingbettyArray)) {
        for(i = 0; i < self.bouncingbettyArray.size; i++) {
          if(isDefined(self.bouncingbettyArray[i])) {
            if(isDefined(self.bouncingbettyArray[i].trigger)) {
              self.bouncingbettyArray[i].trigger delete();
            }

            self.bouncingbettyArray[i] delete();
          }
        }
      }
      self.bouncingbettyArray = [];
    }

    delete_all_mines() {
      if(isDefined(self.equipmentMines)) {
        self.equipmentMines = array_removeUndefined(self.equipmentMines);
        foreach(equipmentMine in self.equipmentMines) {
          if(isDefined(equipmentMine.trigger)) {
            equipmentMine.trigger delete();
          }

          equipmentMine delete();
        }
      }
    }

    transfer_grenade_ownership(newOwner) {
      newOwner delete_all_grenades();
      newOwner delete_all_mines();

      if(isDefined(self.manuallyDetonatedArray)) {
        newOwner.manuallyDetonatedArray = manuallyDetonated_removeUndefined(self.manuallyDetonatedArray);
      } else {
        newOwner.manuallyDetonatedArray = undefined;
      }

      if(isDefined(self.claymorearray)) {
        newOwner.claymorearray = array_removeUndefined(self.claymorearray);
      } else {
        newOwner.claymorearray = undefined;
      }

      if(isDefined(self.bouncingbettyArray)) {
        newOwner.bouncingbettyArray = array_removeUndefined(self.bouncingbettyArray);
      } else {
        newOwner.bouncingbettyArray = undefined;
      }

      if(isDefined(self.equipmentMines)) {
        newOwner.equipmentMines = array_removeUndefined(self.equipmentMines);
      } else {
        newOwner.equipmentMines = undefined;
      }

      if(isDefined(self.killstreakMines)) {
        newOwner.killstreakMines = array_removeUndefined(self.killstreakMines);
      } else {
        newOwner.killstreakMines = undefined;
      }

      if(isDefined(newOwner.manuallyDetonatedArray)) {
        foreach(manuallyDetonatedWeapon in newOwner.manuallyDetonatedArray) {
          manuallyDetonatedWeapon[0].owner = newOwner;
          manuallyDetonatedWeapon[0] thread equipmentWatchUse(newOwner);
        }
      }

      if(isDefined(newOwner.claymorearray)) {
        foreach(claymore in newOwner.claymorearray) {
          claymore.owner = newOwner;
          claymore thread equipmentWatchUse(newOwner);
        }
      }

      if(isDefined(newOwner.bouncingbettyArray)) {
        foreach(bouncingBetty in newOwner.bouncingbettyArray) {
          bouncingBetty.owner = newOwner;
          bouncingBetty thread equipmentWatchUse(newOwner);
        }
      }

      if(isDefined(newOwner.equipmentMines)) {
        foreach(equipmentMine in newOwner.equipmentMines) {
          equipmentMine.owner = newOwner;
          equipmentMine thread equipmentWatchUse(newOwner);
        }
      }

      if(isDefined(newOwner.killstreakMines)) {
        foreach(ksMine in newOwner.killstreakMines) {
          ksMine.owner = newOwner;
          ksMine thread equipmentWatchUse(newOwner);
        }
      }

      self.manuallyDetonatedArray = [];
      self.claymorearray = [];
      self.bouncingbettyArray = [];
      self.equipmentMines = [];
      self.killstreakMines = [];
      self.dont_delete_grenades_on_next_spawn = true;
      self.dont_delete_mines_on_next_spawn = true;
    }

    update_em1_heat_omnvar() {
      level endon("game_ended");
      self endon("disconnect");

      while(true) {
        current_weapon = self GetCurrentWeapon();

        if(IsSubStr(current_weapon, "em1") || IsSubStr(current_weapon, "epm3") || IsSubStr(current_weapon, "dlcgun1")) {
          weapon_heat = self GetWeaponHeatLevel(current_weapon);
          self SetClientOmnvar("ui_em1_heat", weapon_heat);
        }

        wait(0.05);
      }
    }

    equipmentDeathVfx() {
      playFX(getfx("equipment_sparks"), self.origin);

      self playSound("sentry_explode");
    }

    equipmentDeleteVfx() {
      playFX(getfx("equipment_explode_big"), self.origin);
      playFX(getfx("equipment_smoke"), self.origin);
    }

    equipmentEmpStunVfx() {
      playFXOnTag(getfx("emp_stun"), self, "tag_origin");
    }

    track_damage_info() {
      self.damage_info = [];

      self thread reset_damage_info_when_healed();
    }

    reset_damage_info_when_healed() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      while(true) {
        if(self.health >= 100 && isDefined(self.damage_info) && self.damage_info.size > 0) {
          self.damage_info = [];
        }

        wait(0.05);
      }
    }

    stickyHandleMovers(notifyString, endonString) {
      data = spawnStruct();
      if(isDefined(notifyString)) {
        data.notifyString = notifyString;
      }
      if(isDefined(endonString)) {
        data.endonString = endonString;
      }
      data.deathOverrideCallback = ::stickyMovingPlatformDetonate;

      self thread maps\mp\_movers::handle_moving_platforms(data);
    }

    stickyMovingPlatformDetonate(data) {
      if(!isDefined(self)) {
        return;
      }

      self endon("death");

      if(isDefined(self)) {
        if(isDefined(data.notifyString)) {}
        if(data.notifyString == "detonate") {
          self Detonate();
        } else {
          self notify(data.notifyString);
        }
      } else {
        self Delete();
      }
    }

    getGrenadeGracePeriodTimeLeft() {
      grenadeGracePeriod = 10;
      if(isDefined(level.grenadeGracePeriod)) {
        grenadeGracePeriod = level.grenadeGracePeriod;
      }

      timePassed = 0;
      if(isDefined(level.prematch_done_time)) {
        timePassed = (GetTime() - level.prematch_done_time) / 1000;
      }

      return (grenadeGracePeriod - timePassed);
    }

    inGrenadeGracePeriod() {
      return getGrenadeGracePeriodTimeLeft() > 0;
    }

    isWeaponAllowedInGrenadeGracePeriod(weaponame) {
      if(IsEndStr(weaponame, "_gl")) {
        return false;
      }

      switch (weaponame) {
        case "semtex_mp":
        case "semtex_mp_lefthand":
        case "explosive_drone_mp":
        case "explosive_drone_mp_lefthand":
        case "frag_grenade_mp":
        case "frag_grenade_mp_lefthand":
          return false;
        default:
          break;
      }

      baseWeaponName = GetWeaponBaseName(weaponame);
      if(isDefined(baseWeaponName)) {
        switch (baseWeaponName) {
          case "iw5_mahem_mp":
          case "iw5_maaws_mp":
          case "iw5_exocrossbow_mp":
          case "iw5_microdronelauncher_mp":
          case "iw5_stingerm7_mp":
            return false;
          default:
            break;
        }
      }

      return true;
    }

    watchGrenadeGracePeriod() {
      self endon("death");
      self endon("disconnect");
      self endon("faux_spawn");

      while(1) {
        [note, grenade, weapname] = self waittill_any_return_parms("grenade_fire", "missile_fire");

        if(!isDefined(weapname) || weapname == "") {
          continue;
        }

        if(inGrenadeGracePeriod()) {
          if(!isWeaponAllowedInGrenadeGracePeriod(weapname)) {
            time = int(getGrenadeGracePeriodTimeLeft() + 0.5);
            if(!time) {
              time = 1;
            }

            if(isPlayer(self)) {
              self IPrintLnBold(&"MP_EXPLOSIVES_UNAVAILABLE_FOR_N", time);
            }
          }
        } else {
          break;
        }
      }
    }

    isPrimaryOrSecondaryProjectileWeapon(weapon) {
      assert(isDefined(weapon));

      weaponClass = getWeaponClass(weapon);

      baseWeapon = getBaseWeaponName(weapon);

      if(weaponClass == "weapon_projectile") {
        return true;
      }

      if(isDefined(baseWeapon) && (IsSubStr(baseWeapon, "microdronelauncher") || IsSubStr(baseWeapon, "exocrossbow"))) {
        return true;
      }

      return false;
    }

    saveWeapon(type, saveWeapon, useWeap) {
      numSaves = self.saveWeapons.size;
      if(numSaves == 0) {
        self.firstSaveWeapon = saveWeapon;
      }

      self.saveWeapons[numSaves]["type"] = type;
      self.saveWeapons[numSaves]["use"] = useWeap;
    }

    getSavedWeapon(type) {
      numSaves = self.saveWeapons.size;
      found = -1;
      for(i = 0; i < numSaves; i++) {
        if(self.saveWeapons[i]["type"] == type) {
          found = i;
          break;
        }
      }

      if(found >= 0) {
        return self.saveWeapons[found]["use"];
      } else {
        return "none";
      }
    }

    restoreWeapon(type) {
      updList = [];
      numSaves = self.saveWeapons.size;

      found = -1;
      j = 0;
      for(i = 0; i < numSaves; i++) {
        if((found < 0) && (self.saveWeapons[i]["type"] == type)) {
          found = i;
        } else {
          updList[j] = self.saveWeapons[i];
          j++;
        }
      }

      if(found >= 0) {
        weap = "none";
        if(updList.size == 0) {
          weap = self.firstSaveWeapon;
          self.saveWeapons = updList;
          self.firstSaveWeapon = "none";
        } else {
          self.saveWeapons = updList;
          weap = self getSavedWeapon("underwater");
          if(weap == "none") {
            weap = self.saveWeapons[0]["use"];
          }
        }

        currWeap = self GetCurrentWeapon();
        if(currWeap != weap) {
          self SwitchToWeaponImmediate(weap);
        }
      }
    }