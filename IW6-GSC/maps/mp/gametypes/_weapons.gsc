/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_weapons.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_trophy_system;

kNineBangMaxTicks = 5;
kNineBangRadius = 512;
kNineBangEffectTime = 8.0;
kNineBangCookInterval = 875;

attachmentGroup(attachmentName) {
  if(is_aliens())
    return tableLookup("mp/alien/alien_attachmentTable.csv", 4, attachmentName, 2);
  else
    return tableLookup("mp/attachmentTable.csv", 4, attachmentName, 2);
}

init() {
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
    gametype = GetDvar("g_gametype");
    attachmentList = getAttachmentListBaseNames();
    attachmentList = alphabetize(attachmentList);

    max_weapon_num = 149;

    level.weaponList = [];
    level.weaponAttachments = [];

    statsTablename = "mp/statstable.csv";
    if(is_aliens()) {
      statsTablename = "mp/alien/mode_string_tables/alien_statstable.csv";
    }

    for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
      weapon_name = tablelookup(statsTablename, 0, weaponId, 4);

      if(weapon_name == "") {
        continue;
      }
      if(!isSubStr(tableLookup(statsTablename, 0, weaponId, 2), "weapon_")) {
        continue;
      }
      if(IsSubStr(weapon_name, "iw5") || IsSubStr(weapon_name, "iw6")) {
        weaponTokens = StrTok(weapon_name, "_");
        weapon_name = weaponTokens[0] + "_" + weaponTokens[1] + "_mp";

        level.weaponList[level.weaponList.size] = weapon_name;
        continue;
      } else
        level.weaponList[level.weaponList.size] = weapon_name + "_mp";

      if(getDvar("scr_dump_weapon_assets") != "") {
        printLn("");
        printLn("
          printLn("weapon,mp/" + weapon_name + "_mp");
        }

        attachmentNames = [];
        for(innerLoopCount = 0; innerLoopCount < 10; innerLoopCount++) {
          if(gametype == "aliens") {
            attachmentName = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv", 0, weaponId, innerLoopCount + 11);
          } else {
            attachmentName = getWeaponAttachmentFromStats(weapon_name, innerLoopCount);
          }

          if(attachmentName == "") {
            break;
          }

          attachmentNames[attachmentName] = true;
        }

        attachments = [];
        foreach(attachmentName in attachmentList) {
          if(!isDefined(attachmentNames[attachmentName])) {
            continue;
          }
          level.weaponList[level.weaponList.size] = weapon_name + "_" + attachmentName + "_mp";
          attachments[attachments.size] = attachmentName;

          if(getDvar("scr_dump_weapon_assets") != "")
            println("weapon,mp/" + weapon_name + "_" + attachmentName + "_mp");

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

        if(getDvar("scr_dump_weapon_assets") != "" && attachmentCombos.size)
          println("

            foreach(combo in attachmentCombos) {
              if(getDvar("scr_dump_weapon_assets") != "")
                println("weapon,mp/" + weapon_name + "_" + combo + "_mp");

              level.weaponList[level.weaponList.size] = weapon_name + "_" + combo + "_mp";
            }

          }

        foreach(weaponName in level.weaponList) {
          precacheItem(weaponName);

          if(getDvar("scr_dump_weapon_assets") != "") {
            altWeapon = weaponAltWeaponName(weaponName);
            if(altWeapon != "none")
              println("weapon,mp/" + altWeapon);
          }

        }

        thread maps\mp\_flashgrenades::main();
        thread maps\mp\_entityheadicons::init();
        thread maps\mp\_empgrenade::init();
        initBombSquadData();

        maps\mp\_utility::buildAttachmentMaps();
        maps\mp\_utility::buildWeaponPerkMap();

        level._effect["weap_blink_friend"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_detonator_blink_cyan");
        level._effect["weap_blink_enemy"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_detonator_blink_orange");
        level._effect["emp_stun"] = LoadFX("vfx/gameplay/mp/equipment/vfx_emp_grenade");
        level._effect["equipment_explode_big"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
        level._effect["equipment_smoke"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");
        level._effect["equipment_sparks"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion");

        level.weaponConfigs = [];

        if(!isDefined(level.weaponDropFunction))
          level.weaponDropFunction = ::dropWeaponForDeath;

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
        level.mine_launch = loadfx("fx/impacts/bouncing_betty_launch_dirt");
        level.mine_explode = loadfx("fx/explosions/bouncing_betty_explosion");

        config = spawnStruct();
        config.model = "projectile_bouncing_betty_grenade";
        config.bombSquadModel = "projectile_bouncing_betty_grenade_bombsquad";
        config.mine_beacon["enemy"] = loadfx("fx/misc/light_c4_blink");
        config.mine_beacon["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
        config.mine_spin = loadfx("fx/dust/bouncing_betty_swirl");
        config.armTime = 2;
        config.onTriggeredSfx = "mine_betty_click";
        config.onLaunchSfx = "mine_betty_spin";
        config.onExplodeSfx = "grenade_explode_metal";
        config.launchHeight = 64;
        config.launchTime = 0.65;
        config.onTriggeredFunc = ::mineBounce;
        config.headIconOffset = 20;
        level.weaponConfigs["bouncingbetty_mp"] = config;
        level.weaponConfigs["alienbetty_mp"] = config;

        config = spawnStruct();
        config.model = "weapon_motion_sensor";
        config.bombSquadModel = "weapon_motion_sensor_bombsquad";
        config.mine_beacon["enemy"] = getfx("weap_blink_enemy");
        config.mine_beacon["friendly"] = getfx("weap_blink_friend");
        config.mine_spin = loadfx("fx/dust/bouncing_betty_swirl");
        config.armTime = 2;
        config.onTriggeredSfx = "motion_click";
        config.onTriggeredFunc = ::mineSensorBounce;
        config.onLaunchSfx = "motion_spin";
        config.launchVfx = level.mine_launch;
        config.launchHeight = 64;
        config.launchTime = 0.65;
        config.onExplodeSfx = "motion_explode_default";
        config.onExplodeVfx = LoadFX("vfx/gameplay/mp/equipment/vfx_motionsensor_exp");
        config.headIconOffset = 25;
        config.markedDuration = 4.0;
        level.weaponConfigs["motion_sensor_mp"] = config;

        config = spawnStruct();
        config.armingDelay = 1.5;
        config.detectionRadius = 232;
        config.detectionheight = 512;
        config.detectionGracePeriod = 1;
        config.headIconOffset = 20;
        config.killCamOffset = 12;
        level.weaponConfigs["proximity_explosive_mp"] = config;

        config = spawnStruct();
        nineBangRadiusMax = 800;
        nineBangRadiusMin = 200;
        config.radius_max_sq = nineBangRadiusMax * nineBangRadiusMax;
        config.radius_min_sq = nineBangRadiusMin * nineBangRadiusMin;
        config.onExplodeVfx = LoadFx("vfx/gameplay/mp/equipment/vfx_flashbang");
        config.onExplodeSfx = "flashbang_explode_default";
        config.vfxRadius = 72;
        level.weaponConfigs["flash_grenade_mp"] = config;

        level.delayMineTime = 3.0;

        level.sentry_fire = loadfx("fx/muzzleflashes/shotgunflash");

        level.stingerFXid = loadfx("fx/explosions/aerial_explosion_large");

        level.primary_weapon_array = [];
        level.side_arm_array = [];
        level.grenade_array = [];
        level.missile_array = [];
        level.inventory_array = [];
        level.mines = [];

        level._effect["equipment_explode"] = LoadFX("fx/explosions/sparks_a");

        level._effect["sniperDustLarge"] = LoadFX("fx/dust/sniper_dust_kickup");
        level._effect["sniperDustSmall"] = LoadFX("fx/dust/sniper_dust_kickup_minimal");
        level._effect["sniperDustLargeSuppress"] = LoadFX("fx/dust/sniper_dust_kickup_accum_suppress");
        level._effect["sniperDustSmallSuppress"] = LoadFX("fx/dust/sniper_dust_kickup_accum_supress_minimal");

        level thread onPlayerConnect();

        level.c4explodethisframe = false;

        array_thread(getEntArray("misc_turret", "classname"), ::turret_monitorUse);

        SetDevDvar("scr_debug_throwingknife", 0);
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

      initBombSquadData() {
        level.bomb_squad = [];

        level.bomb_squad["c4_mp"] = spawnStruct();
        level.bomb_squad["c4_mp"].model = "weapon_c4_iw6_bombsquad";
        level.bomb_squad["c4_mp"].tag = "tag_origin";

        level.bomb_squad["claymore_mp"] = spawnStruct();
        level.bomb_squad["claymore_mp"].model = "weapon_claymore_bombsquad";
        level.bomb_squad["claymore_mp"].tag = "tag_origin";

        level.bomb_squad["frag_grenade_mp"] = spawnStruct();
        level.bomb_squad["frag_grenade_mp"].model = "projectile_m67fraggrenade_bombsquad";
        level.bomb_squad["frag_grenade_mp"].tag = "tag_weapon";

        level.bomb_squad["frag_grenade_short_mp"] = spawnStruct();
        level.bomb_squad["frag_grenade_short_mp"].model = "projectile_m67fraggrenade_bombsquad";
        level.bomb_squad["frag_grenade_short_mp"].tag = "tag_weapon";

        level.bomb_squad["semtex_mp"] = spawnStruct();
        level.bomb_squad["semtex_mp"].model = "weapon_semtex_grenade_iw6_bombsquad";
        level.bomb_squad["semtex_mp"].tag = "tag_origin";

        level.bomb_squad["mortar_shell_mp"] = spawnStruct();
        level.bomb_squad["mortar_shell_mp"].model = "weapon_canister_bomb_bombsquad";
        level.bomb_squad["mortar_shell_mp"].tag = "tag_weapon";

        level.bomb_squad["thermobaric_grenade_mp"] = spawnStruct();
        level.bomb_squad["thermobaric_grenade_mp"].model = "weapon_thermobaric_grenade_bombsquad";
        level.bomb_squad["thermobaric_grenade_mp"].tag = "tag_weapon";

        level.bomb_squad["proximity_explosive_mp"] = spawnStruct();
        level.bomb_squad["proximity_explosive_mp"].model = "mp_proximity_explosive_bombsquad";
        level.bomb_squad["proximity_explosive_mp"].tag = "tag_origin";
      }

      bombSquadWaiter_missileFire() {
        self endon("disconnect");

        for(;;) {
          missile = self waittill_missile_fire();

          if(missile.weapon_name == "iw6_mk32_mp")
            missile thread createBombSquadModel("projectile_semtex_grenade_bombsquad", "tag_weapon", self);
        }
      }

      createBombSquadModel(modelName, tagName, owner) {
        bombSquadModel = spawn("script_model", (0, 0, 0));
        bombSquadModel hide();
        wait(0.05);

        if(!isDefined(self)) {
          return;
        }
        self.bombSquadModel = bombSquadModel;

        bombSquadModel thread bombSquadVisibilityUpdater(owner);
        bombSquadModel setModel(modelName);
        bombSquadModel linkTo(self, tagName, (0, 0, 0), (0, 0, 0));
        bombSquadModel SetContents(0);

        self waittill_any("death", "trap_death");

        if(isDefined(self.trigger))
          self.trigger delete();

        bombSquadModel delete();
      }

      DisableVisibilityCullingForClient(client) {
        self HudOutlineEnableForClient(client, 6, true);
      }

      EnableVisibilityCullingForClient(client) {
        self HudOutlineDisableForClient(client);
      }

      bombSquadVisibilityUpdater(owner) {
        self endon("death");
        self endon("trap_death");

        if(!isDefined(owner)) {
          return;
        }

        teamname = owner.team;

        for(;;) {
          self hide();

          foreach(player in level.players) {
            EnableVisibilityCullingForClient(player);

            if(!(player _hasPerk("specialty_detectexplosive"))) {
              continue;
            }
            if(level.teamBased) {
              if(player.team == "spectator" || player.team == teamName)
                continue;
            } else {
              if(isDefined(owner) && player == owner)
                continue;
            }

            self ShowToPlayer(player);

            self DisableVisibilityCullingForClient(player);
          }

          level waittill_any("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
        }
      }

      onPlayerConnect() {
        for(;;) {
          level waittill("connected", player);

          player.hits = 0;

          maps\mp\gametypes\_gamelogic::setHasDoneCombat(player, false);

          player thread onPlayerSpawned();
          player thread bombSquadWaiter_missileFire();
          player thread watchMissileUsage();
          player thread sniperDustWatcher();

        }
      }

      onPlayerSpawned() {
        self endon("disconnect");

        for(;;) {
          self waittill("spawned_player");

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
            self.trackingWeaponDeaths = 0;
          }

          if(!is_aliens()) {
            self thread watchWeaponUsage();
            self thread watchWeaponChange();
            self thread watchWeaponPerkUpdates();
            self thread watchSniperBoltActionKills();
          }

          self thread watchGrenadeUsage();

          self thread watchSentryUsage();

          if(!is_aliens())
            self thread maps\mp\gametypes\_class::trackRiotShield();
          self thread stanceRecoilAdjuster();

          self.lastHitTime = [];

          self.droppedDeathWeapon = undefined;
          self.tookWeaponFrom = [];

          self thread updateSavedLastWeapon();

          self thread monitorMk32SemtexLauncher();

          self.currentWeaponAtSpawn = undefined;
          self.trophyRemainingAmmo = undefined;
        }
      }

      recordToggleScopeStates() {
        self.pers["toggleScopeStates"] = [];

        weapons = self GetWeaponsListPrimaries();
        foreach(weap in weapons) {
          if(weap == self.primaryWeapon || weap == self.secondaryWeapon) {
            attachments = GetWeaponAttachments(weap);
            foreach(attachment in attachments) {
              if(isToggleScope(attachment)) {
                self.pers["toggleScopeStates"][weap] = self GetHybridScopeState(weap);
                break;
              }
            }
          }
        }
      }

      updateToggleScopeState(weapon) {
        if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][weapon])) {
          self SetHybridScopeState(weapon, self.pers["toggleScopeStates"][weapon]);
        }
      }

      isToggleScope(attachUnique) {
        result = undefined;

        if(attachUnique == "thermalsniper") {
          result = false;
        } else if(attachUnique == "dlcweap02scope") {
          result = true;
        } else {
          attachment = attachmentMap_toBase(attachUnique);
          switch (attachment) {
            case "hybrid":
            case "thermal":
            case "tracker":
              result = true;
              break;
            default:
              result = false;
              break;
          }
        }
        return result;
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

          if(!isDefined(lastLargeShotFiredTime) || (GetTime() - lastLargeShotFiredTime) > 2000) {
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

      WatchJavelinUsage() {
        self maps\mp\_javelin::JavelinUsageLoop();
      }

      weaponPerkUdpate(weaponNew, weaponOld, perksIgnore) {
        perkAdd = undefined;
        if(isDefined(weaponNew) && weaponNew != "none") {
          weaponNew = getBaseWeaponName(weaponNew);
          perkAdd = weaponPerkMap(weaponNew);
          if(isDefined(perkAdd) && !self _hasPerk(perkAdd)) {
            self givePerk(perkAdd, false);
          }
        }

        if(isDefined(weaponOld) && weaponOld != "none") {
          weaponOld = getBaseWeaponName(weaponOld);
          perkRemove = weaponPerkMap(weaponOld);
          if(isDefined(perkRemove) &&
            (!isDefined(perkAdd) || perkRemove != perkAdd) &&
            self _hasPerk(perkRemove) &&
            (!isDefined(perksIgnore) || !array_contains(perksIgnore, perkRemove))
          ) {
            self _unsetPerk(perkRemove);
          }
        }
      }

      weaponAttachmentPerkUpdate(weaponNew, weaponOld) {
        newAttachments = undefined;
        oldAttachments = undefined;
        perksAdd = undefined;

        if(isDefined(weaponNew) && weaponNew != "none") {
          newAttachments = GetWeaponAttachments(weaponNew);

          if(isDefined(newAttachments) && newAttachments.size > 0) {
            perksAdd = [];
            foreach(newAttach in newAttachments) {
              perk = attachmentPerkMap(newAttach);
              if(!isDefined(perk)) {
                continue;
              }
              perksAdd[perksAdd.size] = perk;
              if(!self _hasPerk(perk)) {
                self givePerk(perk, false);
              }
            }
          }
        }

        if(isDefined(weaponOld) && weaponOld != "none") {
          oldAttachments = GetWeaponAttachments(weaponOld);

          if(isDefined(oldAttachments) && oldAttachments.size > 0) {
            foreach(oldAttach in oldAttachments) {
              perk = attachmentPerkMap(oldAttach);
              if(!isDefined(perk)) {
                continue;
              }
              if((!isDefined(perksAdd) || !array_contains(perksAdd, perk)) && _hasPerk(perk)) {
                self _unsetPerk(perk);
              }
            }
          }
        }

        return perksAdd;
      }

      watchWeaponPerkUpdates() {
        self endon("death");
        self endon("disconnect");
        self endon("faux_spawn");

        weaponPrev = undefined;
        weaponName = self GetCurrentWeapon();

        attachPerksAdded = self weaponAttachmentPerkUpdate(weaponName, weaponPrev);
        self weaponPerkUdpate(weaponName, weaponPrev, attachPerksAdded);

        while(1) {
          weaponPrev = weaponName;

          self waittill_any("weapon_change", "giveLoadout");
          weaponName = self GetCurrentWeapon();

          attachPerksAdded = self weaponAttachmentPerkUpdate(weaponName, weaponPrev);
          self weaponPerkUdpate(weaponName, weaponPrev, attachPerksAdded);
        }
      }

      lethalStowed_clear() {
        self.loadoutPerkEquipmentStowedAmmo = undefined;
        self.loadoutPerkEquipmentStowed = undefined;
      }

      hasUnderBarrelWeapon() {
        result = false;

        weapons = self GetWeaponsListPrimaries();
        foreach(weap in weapons) {
          if(WeaponAltWeaponName(weap) != "none") {
            result = true;
            break;
          }
        }
        return result;
      }

      lethalStowed_updateLethalsOnWeaponChange() {
        if(self.loadoutPerkEquipment != "specialty_null") {
          if(self hasUnderBarrelWeapon()) {
            self.loadoutPerkEquipmentStowedAmmo = self GetWeaponAmmoClip(self.loadoutPerkEquipment);
            self.loadoutPerkEquipmentStowed = self.loadoutPerkEquipment;

            self TakeWeapon(self.loadoutPerkEquipment);
            self.loadoutPerkEquipment = "specialty_null";

            self givePerkEquipment("specialty_null", false);
          }
        } else {
          if(isDefined(self.loadoutPerkEquipmentStowed) && !self hasUnderBarrelWeapon()) {
            self givePerkEquipment(self.loadoutPerkEquipmentStowed, true);

            self SetWeaponAmmoClip(self.loadoutPerkEquipmentStowed, self.loadoutPerkEquipmentStowedAmmo);
            self.loadoutPerkEquipment = self.loadoutPerkEquipmentStowed;

            self lethalStowed_clear();
          }
        }
      }

      watchWeaponChange() {
        self endon("death");
        self endon("disconnect");
        self endon("faux_spawn");

        self childthread watchStartWeaponChange();
        self.lastDroppableWeapon = self.currentWeaponAtSpawn;
        self.hitsThisMag = [];

        weaponName = self GetCurrentWeapon();

        if(isCACPrimaryWeapon(weaponName) && !isDefined(self.hitsThisMag[weaponName]))
          self.hitsThisMag[weaponName] = weaponClipSize(weaponName);

        while(1) {
          self waittill("weapon_change", weaponName);

          if(weaponName == "none") {
            continue;
          }
          if(weaponName == "briefcase_bomb_mp" || weaponName == "briefcase_bomb_defuse_mp") {
            continue;
          }
          self lethalStowed_updateLethalsOnWeaponChange();

          if(isKillstreakWeapon(weaponName)) {
            if((self isJuggernaut() || maps\mp\killstreaks\_killstreaks::isMiniGun(weaponName) || self GetCurrentWeapon() == "venomxgun_mp") && !maps\mp\killstreaks\_killstreaks::isAirdropMarker(weaponName)) {
              if(isDefined(self.changingWeapon)) {
                waittillframeend;
                self.changingWeapon = undefined;
              }
            }
            continue;
          }

          weaponTokens = StrTok(weaponName, "_");

          if(weaponTokens[0] == "alt") {
            tmp = GetSubStr(weaponName, 4);
            weaponName = tmp;
            weaponTokens = StrTok(weaponName, "_");
          } else if(weaponTokens[0] != "iw5" && weaponTokens[0] != "iw6")
            weaponName = weaponTokens[0];

          if(weaponName != "none" && weaponTokens[0] != "iw5" && weaponTokens[0] != "iw6") {
            if(isCACPrimaryWeapon(weaponName) && !isDefined(self.hitsThisMag[weaponName + "_mp"]))
              self.hitsThisMag[weaponName + "_mp"] = weaponClipSize(weaponName + "_mp");
          } else if(weaponName != "none" && (weaponTokens[0] == "iw5" || weaponTokens[0] == "iw6")) {
            if(isCACPrimaryWeapon(weaponName) && !isDefined(self.hitsThisMag[weaponName]))
              self.hitsThisMag[weaponName] = weaponClipSize(weaponName);
          }

          self.changingWeapon = undefined;

          if(weaponTokens[0] == "iw5" || weaponTokens[0] == "iw6")
            self.lastDroppableWeapon = weaponName;
          else if(weaponName != "none" && mayDropWeapon(weaponName + "_mp"))
            self.lastDroppableWeapon = weaponName + "_mp";

        }
      }

      SCOPE_RECOIL_REDUCTION_MAX_KILLS = 4;
      SCOPE_RECOIL_REDUCTION_PER_KILL = 3;

      watchSniperBoltActionKills() {
        self endon("death");
        self endon("disconnect");

        self thread watchSniperBoltActionKills_onDeath();

        if(!isDefined(self.pers["recoilReduceKills"]))
          self.pers["recoilReduceKills"] = 0;

        self SetClientOmnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

        while(1) {
          self waittill("got_a_kill", victim, weapon, meansOfDeath);

          if(isRecoilReducingWeapon(weapon)) {
            kills = self.pers["recoilReduceKills"] + 1;

            self.pers["recoilReduceKills"] = Int(min(kills, SCOPE_RECOIL_REDUCTION_MAX_KILLS));

            self SetClientOmnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

            if(kills <= SCOPE_RECOIL_REDUCTION_MAX_KILLS) {
              stanceRecoilUpdate(self GetStance());
            }
          }
        }
      }

      watchSniperBoltActionKills_onDeath() {
        self notify("watchSniperBoltActionKills_onDeath");
        self endon("watchSniperBoltActionKills_onDeath");

        self endon("disconnect");

        self waittill("death");

        self.pers["recoilReduceKills"] = 0;
      }

      isRecoilReducingWeapon(weapon) {
        if(!isDefined(weapon) || weapon == "none")
          return false;

        result = false;

        if(IsSubStr(weapon, "l115a3scope") ||
          IsSubStr(weapon, "l115a3vzscope") ||
          IsSubStr(weapon, "usrscope") ||
          IsSubStr(weapon, "usrvzscope")
        ) {
          result = true;
        }
        return result;
      }

      getRecoilReductionValue() {
        if(!isDefined(self.pers["recoilReduceKills"]))
          self.pers["recoilReduceKills"] = 0;

        return self.pers["recoilReduceKills"] * SCOPE_RECOIL_REDUCTION_PER_KILL;
      }

      watchStartWeaponChange() {
        self endon("death");
        self endon("disconnect");
        self.changingWeapon = undefined;

        while(1) {
          self waittill("weapon_switch_started", newWeapon);

          self thread makeSureWeaponChanges(self GetCurrentWeapon());

          self.changingWeapon = newWeapon;

          if(newWeapon == "none" && isDefined(self.isCapturingCrate) && self.isCapturingCrate) {
            while(self.isCapturingCrate)
              wait(0.05);

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

        if(isKillstreakWeapon(currentWeapon)) {
          return;
        }
        wait(1.0);

        self.changingWeapon = undefined;
      }

      isHackWeapon(weapon) {
        if(weapon == "radar_mp" || weapon == "airstrike_mp" || weapon == "helicopter_mp")
          return true;
        if(weapon == "briefcase_bomb_mp")
          return true;
        return false;
      }

      mayDropWeapon(weapon) {
        if(weapon == "none")
          return false;

        if(isSubStr(weapon, "ac130"))
          return false;

        if(isSubStr(weapon, "uav"))
          return false;

        if(isSubStr(weapon, "killstreak"))
          return false;

        invType = WeaponInventoryType(weapon);

        if(invType != "primary")
          return false;

        return true;
      }

      dropWeaponForDeath(attacker, sMeansOfDeath) {
        if(isDefined(level.blockWeaponDrops)) {
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
          if(getdvar("scr_dropdebug") == "1")
            println("didn't drop weapon: not defined");

          return;
        }

        if(weapon == "none") {
          if(getdvar("scr_dropdebug") == "1")
            println("didn't drop weapon: weapon == none");

          return;
        }

        if(!(self hasWeapon(weapon))) {
          if(getdvar("scr_dropdebug") == "1")
            println("didn't drop weapon: don't have it anymore (" + weapon + ")");

          return;
        }

        if(self isJuggernaut()) {
          return;
        }
        if(isDefined(level.gameModeMayDropWeapon) && !(self[[level.gameModeMayDropWeapon]](weapon))) {
          return;
        }
        tokens = strTok(weapon, "_");

        if(tokens[0] == "alt") {
          for(i = 1; i < tokens.size; i++) {
            if(i > 1)
              weapon += "_";

            weapon += tokens[i];
          }
        }

        if(weapon != "iw6_riotshield_mp") {
          if(!(self AnyAmmoForWeaponModes(weapon))) {
            return;
          }

          clipAmmoR = self GetWeaponAmmoClip(weapon, "right");
          clipAmmoL = self GetWeaponAmmoClip(weapon, "left");
          if(!clipAmmoR && !clipAmmoL) {
            return;
          }

          stockAmmo = self GetWeaponAmmoStock(weapon);
          stockMax = WeaponMaxAmmo(weapon);
          if(stockAmmo > stockMax)
            stockAmmo = stockMax;

          item = self dropItem(weapon);
          if(!isDefined(item)) {
            return;
          }
          item ItemWeaponSetAmmo(clipAmmoR, stockAmmo, clipAmmoL);
        } else {
          item = self dropItem(weapon);
          if(!isDefined(item))
            return;
          item ItemWeaponSetAmmo(1, 1, 0);
        }

        self.droppedDeathWeapon = true;

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

        while(1) {
          self waittill("trigger", player, droppedItem);

          if(isDefined(droppedItem)) {
            break;
          }

        }

        if(getdvar("scr_dropdebug") == "1")
          println("picked up weapon: " + weapname + ", " + isDefined(self.ownersattacker));

        assert(isDefined(player.tookWeaponFrom));

        droppedWeaponName = droppedItem getItemWeaponName();

        if(isDefined(player.primaryWeapon) && player.primaryWeapon == droppedWeaponName)
          player.primaryWeapon = weapname;
        if(isDefined(player.secondaryWeapon) && player.secondaryWeapon == droppedWeaponName)
          player.secondaryWeapon = weapname;

        if(isDefined(player.tookWeaponFrom[droppedWeaponName])) {
          droppedItem.owner = player.tookWeaponFrom[droppedWeaponName];
          droppedItem.ownersattacker = player;
          player.tookWeaponFrom[droppedWeaponName] = undefined;
        }
        droppedItem.targetname = "dropped_weapon";
        droppedItem thread watchPickup();

        if(isDefined(self.ownersattacker) && self.ownersattacker == player) {
          player.tookWeaponFrom[weapname] = self.owner;
        } else {
          player.tookWeaponFrom[weapname] = undefined;
        }
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

        self waittill("scavenger", player);
        assert(isDefined(player));

        player notify("scavenger_pickup");

        scavengerGiveAmmo(player);

        player maps\mp\gametypes\_damagefeedback::hudIconType("scavenger");
      }

      scavengerGiveAmmo(player) {
        offhandWeapons = player GetWeaponsListOffhands();
        foreach(offhand in offhandWeapons) {
          if(!isThrowingKnife(offhand)) {
            continue;
          }
          knifeMax = ter_op(player _hasPerk("specialty_extra_deadly"), 2, 1);
          knifeCurr = player GetWeaponAmmoClip(offhand);

          if(knifeCurr + 1 <= knifeMax) {
            player SetWeaponAmmoClip(offhand, knifeCurr + 1);
          }
        }

        primaryWeapons = player GetWeaponsListPrimaries();
        foreach(primary in primaryWeapons) {
          if(!isCACPrimaryWeapon(primary) && !level.scavenger_secondary) {
            continue;
          }
          if(IsSubStr(primary, "alt_") && IsSubStr(primary, "_gl")) {
            continue;
          }
          if(getWeaponClass(primary) == "weapon_projectile") {
            continue;
          }
          if(primary == "venomxgun_mp") {
            continue;
          }
          currentStockAmmo = player GetWeaponAmmoStock(primary);
          addStockAmmo = WeaponClipSize(primary);

          player SetWeaponAmmoStock(primary, currentStockAmmo + addStockAmmo);
        }
      }

      dropScavengerForDeath(attacker) {
        if(level.inGracePeriod) {
          return;
        }
        if(!isDefined(attacker)) {
          return;
        }
        if(attacker == self) {
          return;
        }
        dropBag = self DropScavengerBag("scavenger_bag_mp");
        dropBag thread handleScavengerBagPickup(self);

        if(isDefined(level.bot_funcs["bots_add_scavenger_bag"]))
          [[level.bot_funcs["bots_add_scavenger_bag"]]](dropBag);
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

          weaponName = self GetCurrentWeapon();

          maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

          self.lastShotFiredTime = GetTime();

          if(!isCACPrimaryWeapon(weaponName) && !isCACSecondaryWeapon(weaponName)) {
            continue;
          }
          if(isDefined(self.hitsThisMag[weaponName]))
            self thread updateMagShots(weaponName);

          totalShots = self maps\mp\gametypes\_persistence::statGetBuffered("totalShots") + 1;
          hits = self maps\mp\gametypes\_persistence::statGetBuffered("hits");

          assert(totalShots > 0);
          accuracy = Clamp(float(hits) / float(totalShots), 0.0, 1.0) * 10000.0;

          if(!IsSquadsMode()) {
            self maps\mp\gametypes\_persistence::statSetBuffered("totalShots", totalShots);
            self maps\mp\gametypes\_persistence::statSetBuffered("accuracy", int(accuracy));
            self maps\mp\gametypes\_persistence::statSetBuffered("misses", int(totalShots - hits));
          }

          if(isDefined(self.lastStandParams) && self.lastStandParams.lastStandStartTime == GetTime()) {
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
        if(!is_aliens()) {
          updateMagShots_regularMP(weaponName);
        }
      }

      updateMagShots_regularMP(weaponName) {
        self endon("death");
        self endon("disconnect");
        self endon("updateMagShots_" + weaponName);

        self.hitsThisMag[weaponName]--;

        wait(0.05);

        self.hitsThisMag[weaponName] = weaponClipSize(weaponName);
      }

      checkHitsThisMag(weaponName) {
        if(!is_aliens()) {
          checkHitsThisMag_regularMP(weaponName);
        }
      }

      checkHitsThisMag_regularMP(weaponName) {
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
          attachments = getWeaponAttachmentsBaseNames(weaponName);

          if(array_contains(attachments, "shotgun") || array_contains(attachments, "gl")) {
            self.hits = 1;
          } else {
            weaponName = GetSubStr(weaponName, 4);
          }
        }

        if(!maps\mp\gametypes\_weapons::isPrimaryWeapon(weaponName) && !maps\mp\gametypes\_weapons::isSideArm(weaponName)) {
          return;
        }
        if(self MeleeButtonPressed() && weaponName != "iw6_knifeonly_mp" && weaponName != "iw6_knifeonlyfast_mp") {
          return;
        }
        switch (WeaponClass(weaponName)) {
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

        if(isRiotShield(weaponName) || weaponName == "iw6_knifeonly_mp" || weaponName == "iw6_knifeonlyfast_mp") {
          self thread maps\mp\gametypes\_gamelogic::threadedSetWeaponStatByName(weaponName, self.hits, "hits");
          self.hits = 0;
        }

        waittillframeend;

        if(isDefined(self.hitsThisMag[weaponName]))
          self thread checkHitsThisMag(weaponName);

        if(!isDefined(self.lastHitTime[weaponName]))
          self.lastHitTime[weaponName] = 0;

        if(self.lastHitTime[weaponName] == GetTime()) {
          return;
        }
        self.lastHitTime[weaponName] = GetTime();

        if(!IsSquadsMode()) {
          totalShots = self maps\mp\gametypes\_persistence::statGetBuffered("totalShots");
          hits = self maps\mp\gametypes\_persistence::statGetBuffered("hits") + 1;

          if(hits <= totalShots) {
            self maps\mp\gametypes\_persistence::statSetBuffered("hits", hits);
            self maps\mp\gametypes\_persistence::statSetBuffered("misses", int(totalShots - hits));

            accuracy = Clamp(float(hits) / float(totalShots), 0.0, 1.0) * 10000.0;
            self maps\mp\gametypes\_persistence::statSetBuffered("accuracy", int(accuracy));
          }
        }
      }

      attackerCanDamageItem(attacker, itemOwner) {
        return friendlyFireCheck(itemOwner, attacker);
      }

      friendlyFireCheck(owner, attacker, forcedFriendlyFireRule) {
        if(!isDefined(owner))
          return true;

        if(!level.teamBased)
          return true;

        attackerTeam = attacker.team;

        friendlyFireRule = level.friendlyfire;
        if(isDefined(forcedFriendlyFireRule))
          friendlyFireRule = forcedFriendlyFireRule;

        if(friendlyFireRule != 0)
          return true;

        if(attacker == owner) {
          return (!is_aliens());
        }

        if(!isDefined(attackerTeam))
          return true;

        if(attackerTeam != owner.team)
          return true;

        return false;
      }

      watchGrenadeUsage() {
        self notify("watchGrenadeUsage");
        self endon("watchGrenadeUsage");

        self endon("spawned_player");
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
        } else if(!isDefined(self.plantedLethalEquip)) {
          self.plantedLethalEquip = [];
          self.plantedTacticalEquip = [];
        }

        self thread watchForThrowbacks();

        while(true) {
          self waittill("grenade_pullback", weaponName);

          if(!is_aliens()) {
            self setWeaponStat(weaponName, 1, "shots");
          }

          maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

          self thread watchOffhandCancel();

          self.throwingGrenade = weaponName;
          self.gotPullbackNotify = true;

          if(weaponName == "c4_mp")
            self thread beginC4Tracking();

          self beginGrenadeTracking();

          self.throwingGrenade = undefined;
        }
      }

      beginGrenadeTracking() {
        self endon("offhand_end");
        self endon("weapon_change");

        startTime = GetTime();

        grenade = self waittill_grenade_fire();
        if(!isDefined(grenade))
          return;
        if(!isDefined(grenade.weapon_name)) {
          return;
        }
        self.changingWeapon = undefined;

        if(isDefined(level.bomb_squad[grenade.weapon_name]))
          grenade thread createBombSquadModel(level.bomb_squad[grenade.weapon_name].model, level.bomb_squad[grenade.weapon_name].tag, self);

        switch (grenade.weapon_name) {
          case "frag_grenade_mp":
          case "thermobaric_grenade_mp":
            if(GetTime() - startTime > 1000)
              grenade.isCooked = true;
            grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
            grenade.originalOwner = self;
            break;
          case "mortar_shell_mp":
          case "iw6_aliendlc22_mp":
          case "iw6_aliendlc43_mp":
            grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
            grenade.originalOwner = self;
            break;
          case "semtex_mp":
          case "aliensemtex_mp":
            self thread semtexUsed(grenade);
            break;
          case "c4_mp":
            self thread c4Used(grenade);
            break;
          case "proximity_explosive_mp":
            self thread proximityExplosiveUsed(grenade);
            break;
          case "flash_grenade_mp":
            cookTime = GetTime() - startTime;
            grenade.nineBangTicks = 1;
            if(cookTime > 1000) {
              grenade.isCooked = true;
              grenade.nineBangTicks += min(int(cookTime / kNineBangCookInterval), kNineBangMaxTicks);
            }
            grenade thread nineBangExplodeWaiter();
            break;
          case "smoke_grenade_mp":
          case "smoke_grenadejugg_mp":
            grenade thread watchSmokeExplode();
            break;
          case "trophy_mp":
          case "alientrophy_mp":
            self thread trophyUsed(grenade);
            break;
          case "claymore_mp":
          case "alienclaymore_mp":
            self thread claymoreUsed(grenade);
            break;
          case "bouncingbetty_mp":
          case "alienbetty_mp":
            self thread mineUsed(grenade, ::spawnMine);
            break;
          case "motion_sensor_mp":
            self thread mineUsed(grenade, ::spawnMotionSensor);
            break;
          case "throwingknife_mp":
          case "throwingknifejugg_mp":
            level thread throwingKnifeUsed(self, grenade, grenade.weapon_name);
            break;
        }
      }

      throwingKnifeUsed(owner, grenade, weapon_name) {
        level endon("game_ended");

        grenade waittill("missile_stuck", stuckTo);

        grenade endon("death");

        grenade MakeUnusable();

        knifeTrigger = spawn("trigger_radius", grenade.origin, 0, 64, 64);
        knifeTrigger EnableLinkTo();
        knifeTrigger LinkTo(grenade);
        knifeTrigger.targetname = "dropped_knife";
        grenade.knife_trigger = knifeTrigger;

        grenade thread watchGrenadeDeath();

        grenade thread drawDebugCylinder();

        while(true) {
          waitframe();

          if(!isDefined(knifeTrigger)) {
            return;
          }
          knifeTrigger waittill("trigger", player);

          if(!IsPlayer(player) || !isReallyAlive(player)) {
            continue;
          }
          if(!(player HasWeapon(weapon_name))) {
            continue;
          }
          currentClipAmmo = player GetWeaponAmmoClip(weapon_name);

          player_has_extra_lethal_perk = player _hasPerk("specialty_extra_deadly");

          if(player_has_extra_lethal_perk && currentClipAmmo == 2)
            continue;
          if(!player_has_extra_lethal_perk && currentClipAmmo == 1) {
            continue;
          }
          player SetWeaponAmmoClip(weapon_name, currentClipAmmo + 1);
          player thread maps\mp\gametypes\_damagefeedback::hudIconType("throwingknife");
          grenade delete();
          break;
        }
      }

      drawDebugCylinder() {
        self endon("death");
        while(true) {
          if(GetDvarInt("scr_debug_throwingknife") > 0) {
            Cylinder(self.origin, self.origin + (0, 0, 64), 64);
          }
          wait(0.05);
        }
      }

      watchGrenadeDeath() {
        self waittill("death");
        if(isDefined(self.knife_trigger))
          self.knife_trigger delete();
      }

      watchOffhandCancel() {
        self endon("death");
        self endon("disconnect");
        self endon("faux_spawn");
        self endon("grenade_fire");

        self waittill("offhand_end");

        if(isDefined(self.changingWeapon) && self.changingWeapon != self GetCurrentWeapon())
          self.changingWeapon = undefined;
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
            if(DistanceSquared(player.origin, position) < smokeRadius * smokeRadius)
              player.inPlayerSmokeScreen = owner;
            else
              player.inPlayerSmokeScreen = undefined;
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

      lockOnLaunchers_getTargetArray() {
        targets = [];

        if(level.teamBased) {
          if(isDefined(level.chopper) && (level.chopper.team != self.team || (isDefined(level.chopper.owner) && level.chopper.owner == self)))
            targets[targets.size] = level.chopper;

          if(isDefined(level.littleBirds)) {
            foreach(lb in level.littleBirds) {
              if(isDefined(lb) && (lb.team != self.team || (isDefined(lb.owner) && lb.owner == self)))
                targets[targets.size] = lb;
            }
          }

          if(isDefined(level.ballDrones)) {
            foreach(bd in level.ballDrones) {
              if(isDefined(bd) && (bd.team != self.team || (isDefined(bd.owner) && bd.owner == self)))
                targets[targets.size] = bd;
            }
          }

          if(isDefined(level.harriers)) {
            foreach(harrier in level.harriers) {
              if(isDefined(harrier) && (harrier.team != self.team || (isDefined(harrier.owner) && harrier.owner == self)))
                targets[targets.size] = harrier;
            }
          }
        } else {
          if(isDefined(level.chopper))
            targets[targets.size] = level.chopper;

          if(isDefined(level.littleBirds)) {
            foreach(lb in level.littleBirds) {
              if(!isDefined(lb)) {
                continue;
              }
              targets[targets.size] = lb;
            }
          }

          if(isDefined(level.ballDrones)) {
            foreach(bd in level.ballDrones) {
              if(!isDefined(bd)) {
                continue;
              }
              targets[targets.size] = bd;
            }
          }

          if(isDefined(level.harriers)) {
            foreach(harrier in level.harriers) {
              if(!isDefined(harrier)) {
                continue;
              }
              targets[targets.size] = harrier;
            }
          }
        }

        return targets;
      }

      watchMissileUsage() {
        self endon("disconnect");

        for(;;) {
          missile = self waittill_missile_fire();

          if(isSubStr(missile.weapon_name, "gl_")) {
            missile.primaryWeapon = self getCurrentPrimaryWeapon();
            missile thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
          }

          switch (missile.weapon_name) {
            case "at4_mp":
            case "iw5_smaw_mp":
            case "stinger_mp":
              level notify("stinger_fired", self, missile, self.stingerTarget);

              break;
            case "remote_mortar_missile_mp":
            case "lasedStrike_missile_mp":
            case "javelin_mp":
              level notify("stinger_fired", self, missile, self.javelinTarget);

              break;
            default:
              break;
          }

          switch (missile.weapon_name) {
            case "remote_mortar_missile_mp":
            case "lasedStrike_missile_mp":
            case "ac130_105mm_mp":
            case "ac130_40mm_mp":
            case "remotemissile_projectile_mp":
            case "iw6_maaws_mp":
            case "iw6_panzerfaust3_mp":
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
          self.body.targetname = "player_corpse";
          self.body SetCorpseFalling(false);
          self.body EnableLinkTo();
          self.body LinkTo(missile);
          self.body SetContents(0);

          if(!isDefined(self.switching_teams))
            thread maps\mp\gametypes\_deathicons::addDeathicon(self.body, self, self.team, 5.0);

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

          if(drag_player_time_seconds > durationSec)
            drag_player_time_seconds = durationSec;

          value = missile waittill_notify_or_timeout_return("death", drag_player_time_seconds);

          if(isDefined(value) && value == "timeout" && isDefined(missile))
            missile Detonate();

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

      nineBangExplodeWaiter() {
        self thread maps\mp\gametypes\_shellshock::endOnDeath();
        self endon("end_explode");

        self waittill("explode", position);

        self thread doNineBang(position, self.owner, self.nineBangTicks);

        self nineBangDoEmpDamage(position, self.owner, self.nineBangTicks);
      }

      nineBangDoEmpDamage(position, player, numTicks) {
        if(numTicks >= kNineBangMaxTicks || pitcherCheck(player, numTicks)) {
          PlaySoundAtPos(position, "weap_emp_explode");

          ents = getEMPDamageEnts(position, kNineBangRadius, false);

          foreach(ent in ents) {
            if(isDefined(ent.owner) && !friendlyFireCheck(player, ent.owner)) {
              continue;
            }
            ent notify("emp_damage", self.owner, kNineBangEffectTime);
          }
        }
      }

      pitcherCheck(player, numTicks) {
        if(player _hasPerk("specialty_pitcher")) {
          if(numTicks >= 4)
            return true;
        }

        return false;
      }

      doNineBang(pos, attacker, ticks) {
        level endon("game_ended");

        config = level.weaponConfigs[self.weapon_name];

        wait(RandomFloatRange(0.25, 0.5));

        for(i = 1; i < ticks; i++) {
          newPos = self getNineBangSubExplosionPos(pos, config.vfxRadius);
          playSoundAtPos(newPos, config.onExplodeSfx);
          playFX(config.onExplodeVfx, newPos);

          foreach(player in level.players) {
            if(!isReallyAlive(player) || player.sessionstate != "playing") {
              continue;
            }
            viewOrigin = player getEye();

            dist = DistanceSquared(pos, viewOrigin);
            if(dist > config.radius_max_sq) {
              continue;
            }
            if(!BulletTracePassed(pos, viewOrigin, false, player)) {
              continue;
            }
            if(dist <= config.radius_min_sq)
              percent_distance = 1.0;
            else
              percent_distance = 1.0 - (dist - config.radius_min_sq) / (config.radius_max_sq - config.radius_min_sq);

            forward = anglesToForward(player GetPlayerAngles());

            toBlast = pos - viewOrigin;
            toBlast = VectorNormalize(toBlast);

            percent_angle = 0.5 * (1.0 + VectorDot(forward, toBlast));

            extra_duration = 1;
            player notify("flashbang", pos, percent_distance, percent_angle, attacker, extra_duration);
          }

          wait(RandomFloatRange(0.25, 0.5));
        }
      }

      getNineBangSubExplosionPos(startPos, range) {
        offset = (RandomFloatRange(-1.0 * range, range), RandomFloatRange(-1.0 * range, range), 0);
        newPos = startPos + offset;

        trace = bulletTrace(startPos, newPos, false, self, false, false, false, false, false);
        if(trace["fraction"] < 1) {
          newPos = startPos + trace["fraction"] * offset;
        }

        return newPos;
      }

      beginC4Tracking() {
        self notify("beginC4Tracking");
        self endon("beginC4Tracking");

        self endon("death");
        self endon("disconnect");

        self waittill_any("grenade_fire", "weapon_change", "offhand_end");

        self.changingWeapon = undefined;
      }

      watchForThrowbacks() {
        self endon("death");
        self endon("disconnect");

        while(true) {
          self waittill("grenade_fire", grenade, weapname);

          if(self.gotPullbackNotify) {
            self.gotPullbackNotify = false;
            continue;
          }
          if(!isSubStr(weapname, "frag_") && !isSubStr(weapname, "mortar_shell")) {
            continue;
          }
          grenade.threwBack = true;
          self thread incPlayerStat("throwbacks", 1);

          grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
          grenade.originalOwner = self;
        }
      }

      c4Used(grenade) {
        if(!isReallyAlive(self)) {
          grenade delete();
          return;
        }

        grenade thread onDetonateExplosive();

        self thread watchC4Detonation();
        self thread watchC4AltDetonation();

        if(!self.plantedLethalEquip.size)
          self thread watchC4AltDetonate();

        grenade SetOtherEnt(self);
        grenade.activated = false;

        self onLethalEquipmentPlanted(grenade);

        grenade thread maps\mp\gametypes\_shellshock::c4_earthQuake();
        grenade thread c4Activate();
        grenade thread c4Damage();
        grenade thread c4EMPDamage();
        grenade thread watchC4Stuck();

        level thread monitorDisownedEquipment(self, grenade);
      }

      movingPlatformDetonate(data) {
        if(!isDefined(data.lastTouchedPlatform) ||
          !isDefined(data.lastTouchedPlatform.destroyExplosiveOnCollision) ||
          data.lastTouchedPlatform.destroyExplosiveOnCollision
        ) {
          self notify("detonateExplosive");
        }
      }

      watchC4Stuck() {
        self endon("death");

        self waittill("missile_stuck", stuckTo);

        self makeExplosiveUsable();
        self makeExplosiveTargetableByAI();
        self explosiveHandleMovers(stuckTo);
      }

      c4EMPDamage() {
        self endon("death");

        for(;;) {
          self waittill("emp_damage", attacker, duration);

          self equipmentEmpStunVfx();

          self.disabled = true;
          self notify("disabled");

          wait(duration);

          self.disabled = undefined;
          self notify("enabled");
        }
      }

      proximityExplosiveUsed(grenade) {
        if(!isReallyAlive(self)) {
          grenade delete();
          return;
        }

        grenade waittill("missile_stuck", stuckTo);

        if(!isReallyAlive(self)) {
          grenade delete();
          return;
        }

        if(!isDefined(grenade.owner.team)) {
          grenade delete();
          return;
        }

        upVec = AnglesToUp(grenade.angles);
        grenade.origin = grenade.origin - upVec;

        config = level.weaponConfigs[grenade.weapon_name];
        killCamEnt = spawn("script_model", grenade.origin + config.killCamOffset * upVec);
        killCamEnt SetScriptMoverKillCam("explosive");
        killCamEnt LinkTo(grenade);
        grenade.killCamEnt = killCamEnt;

        grenade explosiveHandleMovers(stuckTo);
        grenade makeExplosiveUsable();
        grenade makeExplosiveTargetableByAI();

        self onLethalEquipmentPlanted(grenade);

        grenade thread onDetonateExplosive();
        grenade thread c4Damage();
        grenade thread proximityExplosiveEMPStun();
        grenade thread proximityExplosiveTrigger(stuckTo);

        if(!is_aliens()) {
          grenade thread setClaymoreTeamHeadIcon(self.team, 20);
        }

        level thread monitorDisownedEquipment(self, grenade);
      }

      proximityExplosiveTrigger(parent) {
        self endon("death");
        self endon("disabled");

        config = level.weaponConfigs[self.weapon_name];

        wait(config.armingDelay);

        self playLoopSound("ied_explo_beeps");
        self thread doBlinkingLight("tag_fx");

        startPositionForTrigger = self.origin * (1, 1, 0);
        halfHeight = config.detectionheight / 2;
        usableHeight = self.origin[2] - halfHeight;
        startPositionForTrigger = startPositionForTrigger + (0, 0, usableHeight);

        damagearea = spawn("trigger_radius", startPositionForTrigger, 0, config.detectionRadius, config.detectionheight);
        damagearea.owner = self;

        if(isDefined(parent)) {
          damagearea EnableLinkTo();
          damagearea LinkTo(self);
        }

        self.damagearea = damagearea;
        self thread deleteOnDeath(damagearea);

        player = undefined;
        while(true) {
          damagearea waittill("trigger", player);

          if(!isDefined(player)) {
            continue;
          }
          if(getdvarint("scr_minesKillOwner") != 1) {
            if(isDefined(self.owner)) {
              if(player == self.owner)
                continue;
              if(isDefined(player.owner) && player.owner == self.owner)
                continue;
            }

            if(!friendlyFireCheck(self.owner, player, 0))
              continue;
          }

          if(lengthsquared(player getEntityVelocity()) < 10) {
            continue;
          }
          if(player damageConeTrace(self.origin, self) > 0) {
            break;
          }
        }

        self StopLoopSound("ied_explo_beeps");
        self playSound("ied_warning");

        self explosiveTrigger(player, config.detectionGracePeriod, "proxExplosive");

        self notify("detonateExplosive");
      }

      proximityExplosiveEMPStun() {
        self endon("death");

        for(;;) {
          self waittill("emp_damage", attacker, duration);

          self equipmentEmpStunVfx();

          self.disabled = true;
          self notify("disabled");

          self proximityExplosiveCleanup();

          wait(duration);

          if(isDefined(self)) {
            self.disabled = undefined;
            self notify("enabled");

            parent = self GetLinkedParent();
            self thread proximityExplosiveTrigger(parent);
          }
        }
      }

      proximityExplosiveCleanup() {
        self stopBlinkingLight();

        if(isDefined(self.damagearea)) {
          self.damagearea Delete();
        }
      }

      setClaymoreTeamHeadIcon(team, offset) {
        self endon("death");
        wait .05;
        if(level.teamBased)
          self maps\mp\_entityheadicons::setTeamHeadIcon(team, (0, 0, offset));
        else if(isDefined(self.owner))
          self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, offset));
      }

      claymoreUsed(grenade) {
        if(!IsAlive(self)) {
          grenade delete();
          return;
        }

        grenade Hide();
        grenade waittill_any_timeout(.05, "missile_stuck");

        if(!isDefined(self) || !IsAlive(self)) {
          grenade delete();
          return;
        }

        TotalDistance = 60;
        claymoreZOffset = (0, 0, 4);

        distanceFromOrigin = DistanceSquared(self.origin, grenade.origin);
        distanceFromEye = DistanceSquared(self getEye(), grenade.origin);

        distanceFromOrigin += 600;

        parent = grenade GetLinkedParent();
        if(isDefined(parent)) {
          grenade unlink();
        }

        if(distanceFromOrigin < distanceFromEye) {
          if(TotalDistance * TotalDistance < DistanceSquared(grenade.origin, self.origin)) {
            secTrace = bulletTrace(self.origin, self.origin - (0, 0, TotalDistance), false, self);

            if(secTrace["fraction"] == 1) {
              grenade delete();

              self SetWeaponAmmoStock(grenade.weapon_name, self GetWeaponAmmoStock(grenade.weapon_name) + 1);

              return;
            } else {
              grenade.origin = secTrace["position"];
              parent = secTrace["entity"];
            }
          } else {
            println("not sure why this is here");
          }
        } else {
          if(TotalDistance * TotalDistance < DistanceSquared(grenade.origin, self getEye())) {
            secTrace = bulletTrace(self.origin, self.origin - (0, 0, TotalDistance), false, self);

            if(secTrace["fraction"] == 1) {
              grenade delete();

              self SetWeaponAmmoStock(grenade.weapon_name, self GetWeaponAmmoStock(grenade.weapon_name) + 1);

              return;
            } else {
              grenade.origin = secTrace["position"];
              parent = secTrace["entity"];
            }
          } else {
            claymoreZOffset = (0, 0, -5);
            grenade.angles += (0, 180, 0);
          }
        }

        grenade.angles *= (0, 1, 1);
        grenade.origin = grenade.origin + claymoreZOffset;

        grenade explosiveHandleMovers(parent);

        grenade Show();
        grenade makeExplosiveUsable();
        grenade makeExplosiveTargetableByAI();

        self onLethalEquipmentPlanted(grenade);

        grenade thread onDetonateExplosive();
        grenade thread c4Damage();
        grenade thread c4EMPDamage();
        grenade thread claymoreDetonation(parent);

        if(!is_aliens()) {
          grenade thread setClaymoreTeamHeadIcon(self.pers["team"], 20);
        }

        self.changingWeapon = undefined;

        if(getdvarint("scr_claymoredebug")) {
          grenade thread claymoreDebug();
        }

        level thread monitorDisownedEquipment(self, grenade);
      }

      equipmentWatchUse(owner, updatePosition) {
        if(!is_aliens()) {
          self notify("equipmentWatchUse");

          self endon("spawned_player");
          self endon("disconnect");
          self endon("equipmentWatchUse");

          self.trigger setCursorHint("HINT_NOICON");

          switch (self.weapon_name) {
            case "c4_mp":
              self.trigger SetHintString(&"MP_PICKUP_C4");
              break;
            case "claymore_mp":
              self.trigger SetHintString(&"MP_PICKUP_CLAYMORE");
              break;
            case "bouncingbetty_mp":
              self.trigger SetHintString(&"MP_PICKUP_BOUNCING_BETTY");
              break;
            case "motion_sensor_mp":
              self.trigger SetHintString(&"MP_PICKUP_MOTION_SENSOR");
              break;
            case "proximity_explosive_mp":
              self.trigger SetHintString(&"MP_PICKUP_PROXIMITY_EXPLOSIVE");
              break;
          }

          self.trigger setSelfUsable(owner);
          self.trigger thread notUsableForJoiningPlayers(owner);

          if(isDefined(updatePosition) && updatePosition) {
            self thread updateTriggerPosition();
          }

          for(;;) {
            self.trigger waittill("trigger", owner);

            owner playLocalSound("scavenger_pack_pickup");

            if(isDefined(owner.loadoutPerkEquipmentStowed) && owner.loadoutPerkEquipmentStowed == self.weapon_name) {
              owner.loadoutPerkEquipmentStowedAmmo++;
            } else {
              owner SetWeaponAmmoStock(self.weapon_name, owner GetWeaponAmmoStock(self.weapon_name) + 1);
            }

            self deleteExplosive();

            self notify("death");
          }
        }
      }

      updateTriggerPosition() {
        self endon("death");

        for(;;) {
          if(isDefined(self) && isDefined(self.trigger)) {
            self.trigger.origin = self.origin + self getExplosiveUsableOffset();

            if(isDefined(self.bombSquadModel))
              self.bombSquadModel.origin = self.origin;
          } else {
            return;
          }

          wait(0.05);
        }
      }

      claymoreDebug() {
        self waittill("missile_stuck", stuckTo);
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

      claymoreDetonation(parent) {
        self endon("death");

        damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoreDetonateRadius), 0, level.claymoreDetonateRadius, level.claymoreDetonateRadius * 2);

        if(isDefined(parent)) {
          damagearea enablelinkto();
          damagearea linkto(parent);
        }

        self thread deleteOnDeath(damagearea);

        while(1) {
          damagearea waittill("trigger", player);

          if(getdvarint("scr_claymoredebug") != 1) {
            if(isDefined(self.owner)) {
              if(player == self.owner)
                continue;
              if(isDefined(player.owner) && player.owner == self.owner)
                continue;
            }
            if(!friendlyFireCheck(self.owner, player, 0))
              continue;
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

        self explosiveTrigger(player, level.claymoreDetectionGracePeriod, "claymore");

        if(isDefined(self.owner) && isDefined(level.leaderDialogOnPlayer_func))
          self.owner thread[[level.leaderDialogOnPlayer_func]]("claymore_destroyed", undefined, undefined, self.origin);

        self notify("detonateExplosive");
      }

      shouldAffectClaymore(claymore) {
        if(isDefined(claymore.disabled))
          return false;

        pos = self.origin + (0, 0, 32);

        dirToPos = pos - claymore.origin;
        claymoreForward = anglesToForward(claymore.angles);

        dist = vectorDot(dirToPos, claymoreForward);
        if(dist < level.claymoreDetectionMinDist)
          return false;

        dirToPos = vectornormalize(dirToPos);

        dot = vectorDot(dirToPos, claymoreForward);
        return (dot > level.claymoreDetectionDot);
      }

      deleteOnDeath(ent) {
        self waittill("death");
        wait .05;

        if(isDefined(ent)) {
          if(isDefined(ent.trigger))
            ent.trigger delete();

          ent delete();
        }
      }

      c4Activate() {
        self endon("death");

        self waittill("missile_stuck", stuckTo);

        wait 0.05;

        self notify("activated");
        self.activated = true;
      }

      watchC4AltDetonate() {
        self endon("death");
        self endon("disconnect");
        self endon("detonated");
        level endon("game_ended");

        buttonTime = 0;
        for(;;) {
          if(self UseButtonPressed()) {
            buttonTime = 0;
            while(self UseButtonPressed()) {
              buttonTime += 0.05;
              wait(0.05);
            }

            println("pressTime1: " + buttonTime);
            if(buttonTime >= 0.5) {
              continue;
            }
            buttonTime = 0;
            while(!self UseButtonPressed() && buttonTime < 0.5) {
              buttonTime += 0.05;
              wait(0.05);
            }

            println("delayTime: " + buttonTime);
            if(buttonTime >= 0.5) {
              continue;
            }
            if(!self.plantedLethalEquip.size) {
              return;
            }
            self notify("alt_detonate");
          }
          wait(0.05);
        }
      }

      watchC4Detonation() {
        self endon("death");
        self endon("disconnect");

        while(1) {
          self waittillmatch("detonate", "c4_mp");
          self c4DetonateAllCharges();
        }
      }

      watchC4AltDetonation() {
        self endon("death");
        self endon("disconnect");

        while(1) {
          self waittill("alt_detonate");
          weap = self getCurrentWeapon();
          if(weap != "c4_mp") {
            self c4DetonateAllCharges();
          }
        }
      }

      c4DetonateAllCharges() {
        foreach(c4 in self.plantedLethalEquip) {
          if(isDefined(c4))
            c4 thread waitAndDetonate(0.1);
        }
        self.plantedLethalEquip = [];

        self notify("detonated");
      }

      waitAndDetonate(delay) {
        self endon("death");
        wait delay;

        self waitTillEnabled();

        self notify("detonateExplosive");
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
            switch (weapon) {
              case "concussion_grenade_mp":
              case "flash_grenade_mp":
              case "smoke_grenade_mp":
                continue;
            }
          }

          break;
        }

        if(level.c4explodethisframe)
          wait .1 + randomfloat(.4);
        else
          wait .05;

        if(!isDefined(self)) {
          return;
        }
        level.c4explodethisframe = true;

        thread resetC4ExplodeThisFrame();

        if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE")))
          self.wasChained = true;

        if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION))
          self.wasDamagedFromBulletPenetration = true;

        self.wasDamaged = true;

        if(isDefined(attacker))
          self.damagedBy = attacker;

        if(isPlayer(attacker)) {
          attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("c4");
        }

        if(level.teamBased) {
          if(isDefined(attacker) && isDefined(self.owner)) {
            attacker_pers_team = attacker.pers["team"];
            self_owner_pers_team = self.owner.pers["team"];
            if(isDefined(attacker_pers_team) && isDefined(self_owner_pers_team) && attacker_pers_team != self_owner_pers_team)
              attacker notify("destroyed_equipment");
          }
        } else {
          if(isDefined(self.owner) && isDefined(attacker) && attacker != self.owner)
            attacker notify("destroyed_equipment");
        }

        self notify("detonateExplosive", attacker);
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

      c4DetectionTrigger(ownerTeam) {
        self waittill("activated");

        trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
        trigger.detectId = "trigger" + GetTime() + randomInt(1000000);

        trigger.owner = self;
        trigger thread detectIconWaiter(level.otherTeam[ownerTeam]);

        self waittill("death");
        trigger notify("end_detection");

        if(isDefined(trigger.bombSquadIcon))
          trigger.bombSquadIcon destroy();

        trigger delete();
      }

      claymoreDetectionTrigger(ownerTeam) {
        trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
        trigger.detectId = "trigger" + GetTime() + randomInt(1000000);

        trigger.owner = self;

        trigger thread detectIconWaiter(level.otherTeam[ownerTeam]);

        self waittill("death");
        trigger notify("end_detection");

        if(isDefined(trigger.bombSquadIcon))
          trigger.bombSquadIcon destroy();

        trigger delete();
      }

      detectIconWaiter(detectTeam) {
        self endon("end_detection");
        level endon("game_ended");

        while(!level.gameEnded) {
          self waittill("trigger", player);

          if(!player.detectExplosives) {
            continue;
          }
          if(level.teamBased && player.team != detectTeam)
            continue;
          else if(!level.teamBased && player == self.owner.owner) {
            continue;
          }
          if(isDefined(player.bombSquadIds[self.detectId])) {
            continue;
          }
          player thread showHeadIcon(self);
        }
      }

      monitorDisownedEquipment(player, equipment) {
        level endon("game_ended");
        equipment endon("death");

        player waittill_any("joined_team", "joined_spectators", "disconnect");

        equipment deleteExplosive();
      }

      onLethalEquipmentPlanted(newLethal) {
        if(self.plantedLethalEquip.size) {
          self.plantedLethalEquip = array_removeUndefined(self.plantedLethalEquip);

          if(self.plantedLethalEquip.size >= level.maxPerPlayerExplosives) {
            self.plantedLethalEquip[0] notify("detonateExplosive");
          }
        }

        self.plantedLethalEquip[self.plantedLethalEquip.size] = newLethal;

        entNum = newLethal GetEntityNumber();
        level.mines[entNum] = newLethal;

        level notify("mine_planted");
      }

      onTacticalEquipmentPlanted(newTactical) {
        if(self.plantedTacticalEquip.size) {
          self.plantedTacticalEquip = array_removeUndefined(self.plantedTacticalEquip);

          if(self.plantedTacticalEquip.size >= level.maxPerPlayerExplosives) {
            self.plantedTacticalEquip[0] notify("detonateExplosive");
          }
        }

        self.plantedTacticalEquip[self.plantedTacticalEquip.size] = newTactical;

        entNum = newTactical GetEntityNumber();
        level.mines[entNum] = newTactical;

        level notify("mine_planted");
      }

      disablePlantedEquipmentUse() {
        if(isDefined(self.plantedLethalEquip) && self.plantedLethalEquip.size > 0) {
          foreach(equip in self.plantedLethalEquip) {
            if(isDefined(equip.trigger) && isDefined(equip.owner)) {
              equip.trigger DisablePlayerUse(equip.owner);
            }
          }
        }

        if(isDefined(self.plantedTacticalEquip) && self.plantedTacticalEquip.size > 0) {
          foreach(equip in self.plantedTacticalEquip) {
            if(isDefined(equip.trigger) && isDefined(equip.owner)) {
              equip.trigger DisablePlayerUse(equip.owner);
            }
          }
        }
      }

      cleanupEquipment(equipNum, equipKillCamEnt, equipTrigger, equipSensor) {
        if(isDefined(equipNum))
          level.mines[equipNum] = undefined;

        if(isDefined(equipKillCamEnt))
          equipKillCamEnt Delete();

        if(isDefined(equipTrigger))
          equipTrigger Delete();

        if(isDefined(equipSensor))
          equipSensor Delete();
      }

      deleteExplosive() {
        if(isDefined(self)) {
          equipNum = self GetEntityNumber();
          equipKillCamEnt = self.killCamEnt;
          equipTrigger = self.trigger;
          equipSensor = self.sensor;

          self cleanupEquipment(equipNum, equipKillCamEnt, equipTrigger, equipSensor);

          self notify("deleted_equipment");

          self delete();
        }
      }

      onDetonateExplosive() {
        self endon("death");
        level endon("game_ended");

        self thread cleanupExplosivesOnDeath();

        self waittill("detonateExplosive");

        self Detonate(self.owner);
      }

      cleanupExplosivesOnDeath() {
        self endon("deleted_equipment");
        level endon("game_ended");

        equipNum = self GetEntityNumber();
        equipKillCamEnt = self.killCamEnt;
        equipTrigger = self.trigger;
        equipSensor = self.sensor;

        self waittill("death");

        self cleanupEquipment(equipNum, equipKillCamEnt, equipTrigger, equipSensor);
      }

      getExplosiveUsableOffset() {
        upVec = AnglesToUp(self.angles);
        return (10 * upVec);
      }

      makeExplosiveUsable() {
        if(isReallyAlive(self.owner)) {
          self SetOtherEnt(self.owner);

          self.trigger = spawn("script_origin", self.origin + self getExplosiveUsableOffset());
          self.trigger.owner = self;

          self thread equipmentWatchUse(self.owner, true);
        }
      }

      makeExplosiveTargetableByAI(nonLethal) {
        self make_entity_sentient_mp(self.owner.team);
        if(!isDefined(nonLethal) || !nonLethal)
          self MakeEntityNoMeleeTarget();
        if(IsSentient(self)) {
          self SetThreatBiasGroup("DogsDontAttack");
        }
      }

      explosiveHandleMovers(parent, useDefaultInvalidParentCallback) {
        data = spawnStruct();
        data.linkParent = parent;
        data.deathOverrideCallback = ::movingPlatformDetonate;
        data.endonString = "death";

        if(!isDefined(useDefaultInvalidParentCallback) || !useDefaultInvalidParentCallback) {
          data.invalidParentOverrideCallback = maps\mp\_movers::moving_platform_empty_func;
        }
        self thread maps\mp\_movers::handle_moving_platforms(data);
      }

      explosiveTrigger(target, gracePeriod, notifyStr) {
        if(IsPlayer(target) && target _hasPerk("specialty_delaymine")) {
          target notify("triggeredExpl", notifyStr);
          gracePeriod = level.delayMineTime;
        }

        wait gracePeriod;
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
          for(index = 0; index < self.bombSquadIcons.size; index++)
            self.bombSquadIcons[index] destroy();

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
          if(detectId == "")
            useId = index;
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

        while(isAlive(self) && isDefined(trigger) && self isTouching(trigger))
          wait(0.05);

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

        if(!isDefined(doLOS))
          doLOS = false;

        if(!isDefined(startRadius))
          startRadius = 0;

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
              case "mp_sam_turret":
              case "mp_scramble_turret":
              case "mp_remote_turret":
              case "vehicle_ugv_talon_gun_mp":
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
          if(distSq < radiusSq && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, mine)))
            ents[ents.size] = get_damageable_mine(mine, entpos);
        }

        return ents;
      }

      getEMPDamageEnts(pos, radius, doLOS, startRadius) {
        ents = [];

        if(!isDefined(doLOS))
          doLOS = false;

        if(!isDefined(startRadius))
          startRadius = 0;

        radiusSq = radius * radius;

        level.mines = array_removeUndefined(level.mines);
        foreach(targetEnt in level.mines) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        turrets = getEntArray("misc_turret", "classname");
        foreach(targetEnt in turrets) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        foreach(targetEnt in level.uplinks) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        foreach(targetEnt in level.remote_uav) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        foreach(targetEnt in level.ballDrones) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        foreach(targetEnt in level.placedIMS) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        foreach(targetEnt in level.players) {
          if(empCanDamage(targetEnt, pos, radiusSq, doLOS, startRadius))
            ents[ents.size] = targetEnt;
        }

        return ents;
      }

      empCanDamage(ent, pos, radiusSq, doLOS, startRadius) {
        entpos = ent.origin;
        distSq = DistanceSquared(pos, entpos);
        return (distSq < radiusSq &&
          (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, ent)));
      }

      weaponDamageTracePassed(from, to, startRadius, ent) {
        midpos = undefined;

        diff = to - from;
        if(lengthsquared(diff) < startRadius * startRadius)
          return true;

        dir = vectornormalize(diff);
        midpos = from + (dir[0] * startRadius, dir[1] * startRadius, dir[2] * startRadius);

        trace = bulletTrace(midpos, to, false, ent);

        if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
          thread debugprint(from, ".dmg");
          if(isDefined(ent))
            thread debugprint(to, "." + ent.classname);
          else
            thread debugprint(to, ".undefined");
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
            eInflictor,
            eAttacker,
            iDamage,
            0,
            sMeansOfDeath,
            sWeapon,
            damagepos,
            damagedir,
            "none",
            0
          );
        } else {
          if(self.isADestructable && (sWeapon == "artillery_mp" || sWeapon == "claymore_mp" || sWeapon == "stealth_bomb_mp" || sWeapon == "alienclaymore_mp")) {
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
        if(!isDefined(segments))
          segments = 16;

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
          if(i + 1 >= circlepoints.size)
            end = circlepoints[0];
          else
            end = circlepoints[i + 1];

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

        switch (sWeapon) {
          case "concussion_grenade_mp":

            if(!isDefined(eInflictor))
              return;
            else if(meansOfDeath == "MOD_IMPACT") {
              return;
            }
            giveFeedback = true;
            if(isDefined(eInflictor.owner) && eInflictor.owner == eAttacker)
              giveFeedback = false;

            radius = 512;
            scale = 1 - (distance(self.origin, eInflictor.origin) / radius);

            if(scale < 0)
              scale = 0;

            time = 2 + (4 * scale);

            time = maps\mp\perks\_perkfunctions::applyStunResistence(time);

            wait(0.05);
            eAttacker notify("stun_hit");
            self notify("concussed", eAttacker);
            if(eAttacker != self)
              eAttacker maps\mp\gametypes\_missions::processChallenge("ch_alittleconcussed");
            self shellShock("concussion_grenade_mp", time);
            self.concussionEndTime = GetTime() + (time * 1000);
            if(giveFeedback)
              eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("stun");
            break;

          case "weapon_cobra_mk19_mp":

            break;

          default:

            maps\mp\gametypes\_shellshock::shellshockOnDamage(meansOfDeath, damage);
            break;
        }

      }

      isPrimaryWeapon(weapName) {
        if(weapName == "none")
          return false;

        if(weaponInventoryType(weapName) != "primary")
          return false;

        switch (weaponClass(weapName)) {
          case "rifle":
          case "smg":
          case "mg":
          case "spread":
          case "pistol":
          case "rocketlauncher":
          case "sniper":
            return true;

          default:
            return false;
        }
      }

      isBulletWeapon(weapName) {
        if(weapName == "none" || isRiotShield(weapName) || isKnifeOnly(weapName))
          return false;

        switch (weaponClass(weapName)) {
          case "rifle":
          case "smg":
          case "mg":
          case "spread":
          case "pistol":
          case "sniper":
            return true;

          default:
            return false;
        }
      }

      isKnifeOnly(weapName) {
        return IsSubStr(weapName, "knifeonly");
      }

      isAltModeWeapon(weapName) {
        if(weapName == "none")
          return false;

        return (weaponInventoryType(weapName) == "altmode");
      }

      isInventoryWeapon(weapName) {
        if(weapName == "none")
          return false;

        return (weaponInventoryType(weapName) == "item");
      }

      isRiotShield(weapName) {
        if(weapName == "none")
          return false;

        return (WeaponType(weapName) == "riotshield");
      }

      isOffhandWeapon(weapName) {
        if(weapName == "none")
          return false;

        return (weaponInventoryType(weapName) == "offhand");
      }

      isSideArm(weapName) {
        if(weapName == "none")
          return false;

        if(weaponInventoryType(weapName) != "primary")
          return false;

        return (weaponClass(weapName) == "pistol");
      }

      isGrenade(weapName) {
        weapClass = weaponClass(weapName);
        weapType = weaponInventoryType(weapName);

        if(weapClass != "grenade")
          return false;

        if(weapType != "offhand")
          return false;

        return true;
      }

      isThrowingKnife(weapName) {
        if(weapName == "none")
          return false;

        return (IsSubStr(weapName, "throwingknife"));
      }

      isRocketLauncher(weapName) {
        return (weapName == "iw6_panzerfaust3_mp" ||
          weapName == "iw6_maaws_mp");
      }

      updateSavedLastWeapon() {
        self endon("death");
        self endon("disconnect");
        self endon("faux_spawn");

        currentWeapon = self.currentWeaponAtSpawn;
        if(isDefined(self.saved_lastWeaponHack))
          currentWeapon = self.saved_lastWeaponHack;

        self.saved_lastWeapon = currentWeapon;

        for(;;) {
          self waittill("weapon_change", newWeapon);

          if(newWeapon == "none") {
            self.saved_lastWeapon = currentWeapon;
            continue;
          }

          weaponInvType = weaponInventoryType(newWeapon);

          if(weaponInvType != "primary" && weaponInvType != "altmode") {
            self.saved_lastWeapon = currentWeapon;
            continue;
          }

          self updateMoveSpeedScale();

          self.saved_lastWeapon = currentWeapon;

          currentWeapon = newWeapon;
        }
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

          /#	/ / Debug
          for odd cases where move speed is erroring based on equiped weapons.
          if(heaviestWeaponValue == 1000) {
            AssertMsg("No weapons of non zero speed");

            foreach(weapon in self.weaponList) {
              AssertMsg("Weapon Name:" + weapon);
            }
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

        if(is_aliens()) {
          weaponSpeed = Float(TableLookup("mp/alien/mode_string_tables/alien_statstable.csv", 4, baseWeapon, 8));
        } else {
          weaponSpeed = Float(TableLookup("mp/statstable.csv", 4, baseWeapon, 8));
        }

        return weaponSpeed;
      }

      clampWeaponWeightValue(value) {
        return clamp(value, 0.0, 11.0);
      }

      updateMoveSpeedScale() {
        weaponWeight = undefined;

        self.weaponList = self GetWeaponsListPrimaries();
        if(!self.weaponList.size) {
          weaponWeight = WEAPON_WEIGHT_VALUE_DEFAULT;
        } else {
          weapon = self GetCurrentWeapon();

          weaponInvType = WeaponInventoryType(weapon);
          if(weaponInvType != "primary" && weaponInvType != "altmode") {
            if(isDefined(self.saved_lastWeapon)) {
              weapon = self.saved_lastWeapon;
            } else {
              weapon = undefined;
            }
          }

          if(!isDefined(weapon) || !self HasWeapon(weapon)) {
            weaponWeight = self getWeaponHeaviestValue();
          } else {
            weaponWeight = getWeaponWeight(weapon);

            if(!isDefined(weaponWeight) || weaponWeight == 0)
              weaponWeight = 10;

            weaponWeight = clampWeaponWeightValue(weaponWeight);
          }
        }

        normalizedWeaponSpeed = weaponWeight / 10;

        self.weaponSpeed = normalizedWeaponSpeed;
        Assert(isDefined(self.weaponSpeed));
        Assert(isDefined(self.moveSpeedScaler));

        if(!isDefined(self.combatSpeedScalar)) {
          self.combatSpeedScalar = 1;
        }

        self SetMoveSpeedScale(normalizedWeaponSpeed * self.moveSpeedScaler * self.combatSpeedScalar);
      }

      CONST_RECOIL_REDUCTION_LMG_PRONE = 40;
      CONST_RECOIL_REDUCTION_LMG_CROUCH = 10;
      CONST_RECOIL_REDUCTION_SNIPER_PRONE = 40;
      CONST_RECOIL_REDUCTION_SNIPER_CROUCH = 20;
      CONST_RECOIL_REDUCTION_SNIPER_PRONE_BORED = 20;
      CONST_RECOIL_REDUCTION_SNIPER_CROUCH_BORED = 10;

      stanceRecoilAdjuster() {
        if(!IsPlayer(self)) {
          return;
        }
        self endon("death");
        self endon("disconnect");
        self endon("faux_spawn");

        self notifyOnPlayerCommand("adjustedStance", "+stance");
        self notifyOnPlayerCommand("adjustedStance", "+goStand");

        if(!level.console && !isAI(self)) {
          self notifyOnPlayerCommand("adjustedStance", "+togglecrouch");
          self notifyOnPlayerCommand("adjustedStance", "toggleprone");
          self notifyOnPlayerCommand("adjustedStance", "+movedown");
          self notifyOnPlayerCommand("adjustedStance", "-movedown");
          self notifyOnPlayerCommand("adjustedStance", "+prone");
          self notifyOnPlayerCommand("adjustedStance", "-prone");
        }

        for(;;) {
          self waittill_any("adjustedStance", "sprint_begin", "weapon_change");

          wait(0.5);

          if(isDefined(self.onHeliSniper) && self.OnHeliSniper) {
            continue;
          }
          stance = self GetStance();

          stanceRecoilUpdate(stance);
        }
      }

      stanceRecoilUpdate(stance) {
        weapName = self GetCurrentPrimaryWeapon();
        sniperReduction = 0;
        if(isRecoilReducingWeapon(weapName)) {
          sniperReduction = self getRecoilReductionValue();
        }

        if(stance == "prone") {
          weapClass = getWeaponClass(weapName);

          if(weapClass == "weapon_lmg") {
            self setRecoilScale(0, CONST_RECOIL_REDUCTION_LMG_PRONE);
          } else if(weapClass == "weapon_sniper") {
            if(IsSubStr(weapName, "barrelbored")) {
              self setRecoilScale(0, CONST_RECOIL_REDUCTION_SNIPER_PRONE_BORED + sniperReduction);
            } else {
              self setRecoilScale(0, CONST_RECOIL_REDUCTION_SNIPER_PRONE + sniperReduction);
            }
          } else {
            self setRecoilScale();
          }
        } else if(stance == "crouch") {
          weapClass = getWeaponClass(weapName);
          if(weapClass == "weapon_lmg") {
            self setRecoilScale(0, CONST_RECOIL_REDUCTION_LMG_CROUCH);
          } else if(weapClass == "weapon_sniper") {
            if(IsSubStr(weapName, "barrelbored")) {
              self setRecoilScale(0, CONST_RECOIL_REDUCTION_SNIPER_CROUCH_BORED + sniperReduction);
            } else {
              self setRecoilScale(0, CONST_RECOIL_REDUCTION_SNIPER_CROUCH + sniperReduction);
            }
          } else {
            self setRecoilScale();
          }
        } else {
          if(sniperReduction > 0) {
            self setRecoilScale(0, sniperReduction);
          } else {
            self setRecoilScale();
          }
        }
      }

      buildWeaponData(filterPerks) {
        attachmentList = getAttachmentListBaseNames();
        attachmentList = alphabetize(attachmentList);
        max_weapon_num = 149;

        baseWeaponData = [];

        statsTableName = "mp/statstable.csv";
        gametype = GetDvar("g_gametype");
        if(gametype == "aliens") {
          statsTableName = "mp/alien/mode_string_tables/alien_statstable.csv";
        }

        for(weaponId = 0; weaponId <= max_weapon_num; weaponId++) {
          baseName = tablelookup(statsTableName, 0, weaponId, 4);
          if(baseName == "") {
            continue;
          }
          assetName = baseName + "_mp";

          if(!isSubStr(tableLookup(statsTableName, 0, weaponId, 2), "weapon_")) {
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
          for(innerLoopCount = 0; innerLoopCount < 6; innerLoopCount++) {
            attachmentName = tablelookup(statsTableName, 0, weaponId, innerLoopCount + 11);

            if(filterPerks) {
              switch (attachmentName) {
                case "fmj":
                case "xmags":
                case "rof":
                  continue;
              }
            }

            if(attachmentName == "") {
              break;
            }

            attachmentNames[attachmentName] = true;
          }

          attachments = [];
          foreach(attachmentName in attachmentList) {
            if(!isDefined(attachmentNames[attachmentName])) {
              continue;
            }
            weaponInfo.variants[weaponInfo.variants.size] = baseName + "_" + attachmentName + "_mp";
            attachments[attachments.size] = attachmentName;
          }

          for(i = 0; i < (attachments.size - 1); i++) {
            colIndex = tableLookupRowNum("mp/attachmentCombos.csv", 0, attachments[i]);
            for(j = i + 1; j < attachments.size; j++) {
              if(tableLookup("mp/attachmentCombos.csv", 0, attachments[j], colIndex) == "no") {
                continue;
              }
              weaponInfo.variants[weaponInfo.variants.size] = baseName + "_" + attachments[i] + "_" + attachments[j] + "_mp";
            }
          }

          baseWeaponData[baseName] = weaponInfo;
        }

        return (baseWeaponData);
      }

      monitorMk32SemtexLauncher() {
        self endon("disconnect");
        self endon("death");
        self endon("faux_spawn");

        for(;;) {
          grenade = self waittill_grenade_fire();

          if(isDefined(grenade.weapon_name) && grenade.weapon_name == "iw6_mk32_mp") {
            self semtexUsed(grenade);
          }
        }
      }

      semtexUsed(grenade) {
        if(!isDefined(grenade))
          return;
        if(!isDefined(grenade.weapon_name)) {
          return;
        }
        if(!IsSubStr(grenade.weapon_name, "semtex") && grenade.weapon_name != "iw6_mk32_mp") {
          return;
        }
        grenade.originalOwner = self;
        grenade waittill("missile_stuck", stuckTo);

        grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();

        if(IsPlayer(stuckTo) || IsAgent(stuckTo)) {
          if(!isDefined(self)) {
            grenade.stuckEnemyEntity = stuckTo;

            stuckTo.stuckByGrenade = grenade;
          } else if(level.teamBased && isDefined(stuckTo.team) && stuckTo.team == self.team) {
            grenade.isStuck = "friendly";
          } else {
            grenade.isStuck = "enemy";
            grenade.stuckEnemyEntity = stuckTo;

            if(IsPlayer(stuckTo))
              stuckTo maps\mp\gametypes\_hud_message::playerCardSplashNotify("semtex_stuck", self);

            self thread maps\mp\gametypes\_hud_message::splashNotify("stuck_semtex", 100);

            stuckTo.stuckByGrenade = grenade;
          }
        }

        grenade explosiveHandleMovers(undefined);
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

      spawnMine(origin, owner, weaponName, angles) {
        Assert(isDefined(owner));

        if(!isDefined(angles))
          angles = (0, RandomFloat(360), 0);

        config = level.weaponConfigs[weaponName];
        Assert(isDefined(config));

        mine = spawn("script_model", origin);
        mine.angles = angles;
        mine setModel(config.model);
        mine.owner = owner;
        mine SetOtherEnt(owner);
        mine.weapon_name = weaponName;
        mine.config = config;

        mine.killCamOffset = (0, 0, 4);
        mine.killCamEnt = spawn("script_model", mine.origin + mine.killCamOffset);

        mine.killCamEnt SetScriptMoverKillCam("explosive");

        owner onLethalEquipmentPlanted(mine);

        mine thread createBombSquadModel(config.bombSquadModel, "tag_origin", owner);
        if(isDefined(config.mine_beacon)) {
          mine thread doBlinkingLight("tag_fx", config.mine_beacon["friendly"], config.mine_beacon["enemy"]);
        }

        if(!is_aliens()) {
          mine thread setClaymoreTeamHeadIcon(owner.pers["team"], config.headIconOffset);
        }

        movingPlatformParent = undefined;
        if(self != level) {
          movingPlatformParent = self GetLinkedParent();
        }
        mine explosiveHandleMovers(movingPlatformParent);

        mine thread mineProximityTrigger(movingPlatformParent);
        mine thread maps\mp\gametypes\_shellshock::grenade_earthQuake();

        mine makeExplosiveTargetableByAI(true);
        if(is_aliens() && IsSentient(mine)) {
          mine SetThreatBiasGroup("deployable_ammo");
          mine.threatbias = -10000;
        }

        mine thread mineExplodeOnNotify();

        level thread monitorDisownedEquipment(owner, mine);

        return mine;
      }

      spawnMotionSensor(origin, owner, weaponName, angles) {
        Assert(isDefined(owner));

        if(!isDefined(angles))
          angles = (0, RandomFloat(360), 0);

        config = level.weaponConfigs[weaponName];
        Assert(isDefined(config));

        mine = spawn("script_model", origin);
        mine.angles = angles;
        mine setModel(config.model);
        mine.owner = owner;
        mine SetOtherEnt(owner);
        mine.weapon_name = weaponName;
        mine.config = config;

        owner onTacticalEquipmentPlanted(mine);

        mine thread createBombSquadModel(config.bombSquadModel, "tag_origin", owner);

        mine thread setClaymoreTeamHeadIcon(owner.pers["team"], config.headIconOffset);

        movingPlatformParent = undefined;
        if(self != level) {
          movingPlatformParent = self GetLinkedParent();
        }
        mine explosiveHandleMovers(movingPlatformParent, true);
        mine thread mineProximityTrigger(movingPlatformParent);
        mine thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
        mine thread motionSensorEMPDamage();

        mine makeExplosiveTargetableByAI(false);

        mine thread mineSensorOnNotify();

        level thread monitorDisownedEquipment(owner, mine);

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

          if(is_aliens() && is_hive_explosion(attacker, type)) {
            break;
          }

          if(!isPlayer(attacker) && !IsAgent(attacker)) {
            continue;
          }
          if(isDefined(weapon) && IsEndStr(weapon, "betty_mp")) {
            continue;
          }
          if(!friendlyFireCheck(self.owner, attacker)) {
            continue;
          }
          if(isDefined(weapon)) {
            switch (weapon) {
              case "concussion_grenade_mp":
              case "flash_grenade_mp":
              case "smoke_grenade_mp":
              case "smoke_grenadejugg_mp":
                continue;
            }
          }

          break;
        }

        self notify("mine_destroyed");

        if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE")))
          self.wasChained = true;

        if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION))
          self.wasDamagedFromBulletPenetration = true;

        self.wasDamaged = true;

        if(isDefined(attacker))
          self.damagedBy = attacker;

        if(isPlayer(attacker)) {
          attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("bouncing_betty");
        }

        if(!is_Aliens()) {
          if(level.teamBased) {
            if(isDefined(attacker) && isDefined(attacker.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
              if(attacker.pers["team"] != self.owner.pers["team"])
                attacker notify("destroyed_equipment");
            }
          } else {
            if(isDefined(self.owner) && isDefined(attacker) && attacker != self.owner)
              attacker notify("destroyed_equipment");
          }
        }

        self notify("detonateExplosive", attacker);
      }

      is_hive_explosion(attacker, type) {
        if(!isDefined(attacker) || !isDefined(attacker.classname))
          return false;

        return (attacker.classname == "scriptable" && type == "MOD_EXPLOSIVE");
      }

      mineProximityTrigger(movingPlatformParent) {
        self endon("mine_destroyed");
        self endon("mine_selfdestruct");
        self endon("death");
        self endon("disabled");

        config = self.config;

        wait(config.armTime);

        if(isDefined(config.mine_beacon)) {
          self thread doBlinkingLight("tag_fx", config.mine_beacon["friendly"], config.mine_beacon["enemy"]);
        }

        trigger = spawn("trigger_radius", self.origin, 0, level.mineDetectionRadius, level.mineDetectionHeight);
        trigger.owner = self;
        self thread mineDeleteTrigger(trigger);

        if(isDefined(movingPlatformParent)) {
          trigger enablelinkto();
          trigger linkto(movingPlatformParent);
        }
        self.damagearea = trigger;

        player = undefined;
        while(1) {
          trigger waittill("trigger", player);

          if(!isDefined(player)) {
            continue;
          }
          if(getdvarint("scr_minesKillOwner") != 1) {
            if(isDefined(self.owner)) {
              if(player == self.owner)
                continue;
              if(isDefined(player.owner) && player.owner == self.owner)
                continue;
            }

            if(!friendlyFireCheck(self.owner, player, 0))
              continue;
          }

          if(lengthsquared(player getEntityVelocity()) < 10) {
            continue;
          }
          if(player damageConeTrace(self.origin, self) > 0) {
            break;
          }
        }

        self notify("mine_triggered");

        self playSound(self.config.onTriggeredSfx);

        self explosiveTrigger(player, level.mineDetectionGracePeriod, "mine");

        self thread[[self.config.onTriggeredFunc]]();
      }

      mineDeleteTrigger(trigger) {
        self waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

        if(isDefined(trigger))
          trigger delete();
      }

      motionSensorEMPDamage() {
        self endon("mine_triggered");
        self endon("death");

        for(;;) {
          self waittill("emp_damage", attacker, duration);

          self equipmentEmpStunVfx();
          self stopBlinkingLight();
          if(isDefined(self.damagearea))
            self.damagearea Delete();

          self.disabled = true;
          self notify("disabled");

          wait(duration);

          if(isDefined(self)) {
            self.disabled = undefined;
            self notify("enabled");

            parent = self GetLinkedParent();
            self thread mineProximityTrigger(parent);
          }
        }
      }

      mineSelfDestruct() {
        self endon("mine_triggered");
        self endon("mine_destroyed");
        self endon("death");

        wait(level.mineSelfDestructTime + RandomFloat(0.4));

        self notify("mine_selfdestruct");
        self notify("detonateExplosive");
      }

      mineBounce() {
        self playSound(self.config.onLaunchSfx);
        playFX(level.mine_launch, self.origin);

        if(isDefined(self.trigger))
          self.trigger delete();

        explodePos = self.origin + (0, 0, 64);
        self MoveTo(explodePos, 0.7, 0, .65);
        self.killCamEnt MoveTo(explodePos + self.killCamOffset, 0.7, 0, .65);

        self RotateVelocity((0, 750, 32), 0.7, 0, .65);
        self thread playSpinnerFX();

        wait(0.65);

        self notify("detonateExplosive");
      }

      mineExplodeOnNotify() {
        self endon("death");
        level endon("game_ended");

        self waittill("detonateExplosive", attacker);

        if(!isDefined(self) || !isDefined(self.owner)) {
          return;
        }
        if(!isDefined(attacker))
          attacker = self.owner;

        self playSound(self.config.onExplodeSfx);

        tagOrigin = self GetTagOrigin("tag_fx");
        playFX(level.mine_explode, tagOrigin);
        self notify("explode", tagOrigin);

        wait(0.05);
        if(!isDefined(self) || !isDefined(self.owner)) {
          return;
        }
        self Hide();

        self RadiusDamage(self.origin, level.mineDamageRadius, level.mineDamageMax, level.mineDamageMin, attacker, "MOD_EXPLOSIVE", self.weapon_name);

        if(isDefined(self.owner) && isDefined(level.leaderDialogOnPlayer_func))
          self.owner thread[[level.leaderDialogOnPlayer_func]]("mine_destroyed", undefined, undefined, self.origin);

        wait(0.2);

        self deleteExplosive();
      }

      mineSensorBounce() {
        self playSound(self.config.onLaunchSfx);

        playFX(self.config.launchVfx, self.origin);

        if(isDefined(self.trigger))
          self.trigger delete();

        self HidePart("tag_sensor");

        self stopBlinkingLight();

        sensor = spawn("script_model", self.origin);
        sensor.angles = self.angles;
        sensor setModel(self.config.model);
        sensor HidePart("tag_base");
        sensor.config = self.config;
        self.sensor = sensor;

        explodePos = self.origin + (0, 0, self.config.launchHeight);

        timeToDetonation = self.config.launchTime;
        flightTime = self.config.launchTime + 0.1;

        sensor MoveTo(explodePos, flightTime, 0, timeToDetonation);

        sensor RotateVelocity((0, 1100, 32), flightTime, 0, timeToDetonation);
        sensor thread playSpinnerFX();

        wait(timeToDetonation);

        self notify("detonateExplosive");
      }

      mineSensorOnNotify() {
        self endon("death");
        level endon("game_ended");

        self waittill("detonateExplosive", attacker);

        if(!isDefined(self) || !isDefined(self.owner)) {
          return;
        }
        if(!isDefined(attacker))
          attacker = self.owner;

        self playSound(self.config.onExplodeSfx);

        tagOrigin = undefined;
        if(isDefined(self.sensor)) {
          tagOrigin = self.sensor GetTagOrigin("tag_sensor");
        } else {
          tagOrigin = self GetTagOrigin("tag_origin");
        }
        playFX(self.config.onExplodeVfx, tagOrigin);

        waitframe();

        if(!isDefined(self) || !isDefined(self.owner)) {
          return;
        }
        if(isDefined(self.sensor)) {
          self.sensor Delete();
        } else {
          self HidePart("tag_sensor");
        }

        self.owner thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("hitmotionsensor");

        markedPlayers = [];

        foreach(character in level.characters) {
          if(character.team == self.owner.team) {
            continue;
          }
          if(!isReallyAlive(character)) {
            continue;
          }
          if(character _hasPerk("specialty_heartbreaker")) {
            continue;
          }
          if(Distance2D(self.origin, character.origin) < 300)
            markedPlayers[markedPlayers.size] = character;
        }

        foreach(player in markedPlayers) {
          self thread markPlayer(player, self.owner);
          level thread sensorScreenEffects(player, self.owner);
        }

        if(markedPlayers.size > 0) {
          self.owner maps\mp\gametypes\_missions::processChallenge("ch_motiondetected", markedPlayers.size);

          self.owner thread maps\mp\gametypes\_gamelogic::threadedSetWeaponStatByName("motion_sensor", 1, "hits");
        }

        if(isDefined(self.owner) && isDefined(level.leaderDialogOnPlayer_func))
          self.owner thread[[level.leaderDialogOnPlayer_func]]("mine_destroyed", undefined, undefined, self.origin);

        wait(0.2);

        self deleteExplosive();
      }

      markPlayer(player, owner) {
        if(player == owner) {
          return;
        }
        player endon("disconnect");

        outlineID = undefined;
        if(level.teamBased) {
          outlineID = outlineEnableForTeam(player, "orange", owner.team, false, "equipment");
        } else {
          outlineID = outlineEnableForPlayer(player, "orange", owner, false, "equipment");
        }

        player thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("hitmotionsensor");

        player.motionSensorMarkedBy = owner;

        player waittill_any_timeout(self.config.markedDuration, "death");

        player.motionSensorMarkedBy = undefined;

        outlineDisable(outlineID, player);
      }

      sensorScreenEffects(player, owner) {
        if(player == owner) {
          return;
        }
        if(isAI(player)) {
          return;
        }
        effectName = "coup_sunblind";

        player SetClientOmnvar("ui_hud_shake", true);
        player VisionSetNakedforPlayer(effectName, 0.05);

        wait(0.05);

        player VisionSetNakedforPlayer(effectName, 0);
        player VisionSetNakedforPlayer("", 0.5);
      }

      motionSensor_processTaggedAssist(victim) {
        if(isDefined(level.assists_disabled)) {
          return;
        }
        self.taggedAssist = true;
        if(isDefined(victim))
          self thread maps\mp\gametypes\_gamescore::processAssist(victim);
        else {
          maps\mp\gametypes\_gamescore::givePlayerScore("assist", self, undefined, true);
          self thread maps\mp\gametypes\_rank::giveRankXP("assist");
        }
      }

      playSpinnerFX() {
        if(isDefined(self.config.mine_spin)) {
          self endon("death");

          timer = gettime() + 1000;

          while(gettime() < timer) {
            wait .05;
            playFXOnTag(self.config.mine_spin, self, "tag_fx_spin1");
            playFXOnTag(self.config.mine_spin, self, "tag_fx_spin3");
            wait .05;
            playFXOnTag(self.config.mine_spin, self, "tag_fx_spin2");
            playFXOnTag(self.config.mine_spin, self, "tag_fx_spin4");
          }
        }
      }

      mineDamageDebug(damageCenter, recieverCenter, radiusSq, ignoreEnt, damageTop, damageBottom) {
        color[0] = (1, 0, 0);
        color[1] = (0, 1, 0);

        if(recieverCenter[2] < damageBottom)
          pass = false;
        else
          pass = true;

        damageBottomOrigin = (damageCenter[0], damageCenter[1], damageBottom);
        recieverBottomOrigin = (recieverCenter[0], recieverCenter[1], damageBottom);
        thread debugcircle(damageBottomOrigin, level.mineDamageRadius, color[pass], 32);

        distSq = distanceSquared(damageCenter, recieverCenter);
        if(distSq > radiusSq)
          pass = false;
        else
          pass = true;

        thread debugline(damageBottomOrigin, recieverBottomOrigin, color[pass]);
      }

      mineDamageHeightPassed(mine, victim) {
        if(isPlayer(victim) && isAlive(victim) && victim.sessionstate == "playing")
          victimPos = victim getStanceCenter();
        else if(victim.classname == "misc_turret")
          victimPos = victim.origin + (0, 0, 32);
        else
          victimPos = victim.origin;

        tempZOffset = 0;
        damageTop = mine.origin[2] + tempZOffset + level.mineDamageHalfHeight;
        damageBottom = mine.origin[2] + tempZOffset - level.mineDamageHalfHeight;

        if(victimPos[2] > damageTop || victimPos[2] < damageBottom)
          return false;

        return true;
      }

      mineUsed(grenade, spawnFunc) {
        if(!IsAlive(self)) {
          grenade delete();
          return;
        }

        maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

        grenade thread mineThrown(self, grenade.weapon_name, spawnFunc);
      }

      mineThrown(owner, weaponName, spawnFunc) {
        self.owner = owner;

        self waittill("missile_stuck", stuckTo);

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

        mine = [
          [spawnFunc]
        ](pos, owner, weaponName, plantAngles);

        mine makeExplosiveUsable();
        mine thread mineDamageMonitor();

        self delete();
      }

      delete_all_grenades() {
        if(isDefined(self.plantedLethalEquip)) {
          foreach(grenade in self.plantedLethalEquip) {
            grenade deleteExplosive();
          }
        }

        if(isDefined(self.plantedTacticalEquip)) {
          foreach(grenade in self.plantedTacticalEquip) {
            grenade deleteExplosive();
          }
        }

        if(isDefined(self)) {
          self.plantedLethalEquip = [];
          self.plantedTacticalEquip = [];
        }
      }

      transfer_grenade_ownership(newOwner) {
        newOwner delete_all_grenades();

        if(isDefined(self.plantedLethalEquip))
          newOwner.plantedLethalEquip = array_removeUndefined(self.plantedLethalEquip);

        if(isDefined(self.plantedTacticalEquip))
          newOwner.plantedTacticalEquip = array_removeUndefined(self.plantedTacticalEquip);

        if(isDefined(newOwner.plantedLethalEquip)) {
          foreach(equip in newOwner.plantedLethalEquip) {
            equip.owner = newOwner;
            equip thread equipmentWatchUse(newOwner);
          }
        }

        if(isDefined(newOwner.plantedTacticalEquip)) {
          foreach(equip in newOwner.plantedTacticalEquip) {
            equip.owner = newOwner;
            equip thread equipmentWatchUse(newOwner);
          }
        }

        self.plantedLethalEquip = [];
        self.plantedTacticalEquip = [];
        self.dont_delete_grenades_on_next_spawn = true;
        self.dont_delete_mines_on_next_spawn = true;
      }

      doBlinkingLight(tagName, friendlyFXSrc, enemyFXSrc) {
        if(!isDefined(friendlyFXSrc)) {
          friendlyFXSrc = getfx("weap_blink_friend");
        }

        if(!isDefined(enemyFXSrc)) {
          enemyFXSrc = getfx("weap_blink_enemy");
        }

        self.blinkingLightFx["friendly"] = friendlyFXSrc;
        self.blinkingLightFx["enemy"] = enemyFXSrc;
        self.blinkingLightTag = tagName;

        self thread updateBlinkingLight(friendlyFXSrc, enemyFXSrc, tagName);

        self waittill("death");

        self stopBlinkingLight();
      }

      updateBlinkingLight(friendlyFXSrc, enemyFXSrc, tagName) {
        self endon("death");
        self endon("carried");
        self endon("emp_damage");

        checkFunc = ::checkTeam;
        if(!level.teamBased) {
          checkFunc = ::checkPlayer;
        }

        delay = RandomFloatRange(0.05, 0.25);
        wait(delay);

        self childthread onJoinTeamBlinkingLight(friendlyFXSrc, enemyFXSrc, tagName, checkFunc);

        foreach(player in level.players) {
          if(isDefined(player)) {
            if(self.owner[[checkFunc]](player)) {
              PlayFXOnTagForClients(friendlyFXSrc, self, tagName, player);
            } else {
              PlayFXOnTagForClients(enemyFXSrc, self, tagName, player);
            }

            wait(0.05);
          }
        }
      }

      onJoinTeamBlinkingLight(friendlyFXSrc, enemyFXSrc, tagName, checkFunc) {
        self endon("death");
        level endon("game_ended");
        self endon("emp_damage");

        while(true) {
          level waittill("joined_team", player);

          if(self.owner[[checkFunc]](player)) {
            PlayFXOnTagForClients(friendlyFXSrc, self, tagName, player);
          } else {
            PlayFXOnTagForClients(enemyFXSrc, self, tagName, player);
          }
        }
      }

      stopBlinkingLight() {
        if(IsAlive(self) && isDefined(self.blinkingLightFx)) {
          stopFXOnTag(self.blinkingLightFx["friendly"], self, self.blinkingLightTag);
          stopFXOnTag(self.blinkingLightFx["enemy"], self, self.blinkingLightTag);

          self.blinkingLightFx = undefined;
          self.blinkingLightTag = undefined;
        }
      }

      checkTeam(other) {
        return (self.team == other.team);
      }

      checkPlayer(other) {
        return (self == other);
      }

      equipmentDeathVfx() {
        playFX(getfx("equipment_sparks"), self.origin);

        self playSound("sentry_explode");
      }

      equipmentDeleteVfx() {
        playFX(getfx("equipment_explode_big"), self.origin);
        playFX(getfx("equipment_smoke"), self.origin);

        self playSound("mp_killstreak_disappear");
      }

      equipmentEmpStunVfx() {
        playFXOnTag(getfx("emp_stun"), self, "tag_origin");
      }