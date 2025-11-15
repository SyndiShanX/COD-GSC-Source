/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_challenges.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\killstreaks\_counteruav;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_satellite;
#using scripts\mp\killstreaks\_uav;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\drown;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#namespace challenges;

function autoexec __init__sytem__() {
  system::register("challenges", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & start_gametype);
  callback::on_spawned( & on_player_spawn);
  level.heroabilityactivateneardeath = & heroabilityactivateneardeath;
  level.callbackendherospecialistemp = & callbackendherospecialistemp;
  level.capturedobjectivefunction = & capturedobjectivefunction;
}

function start_gametype() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }
  waittillframeend();
  if(isDefined(level.scoreeventgameendcallback)) {
    registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
  }
  if(canprocesschallenges()) {
    registerchallengescallback("playerKilled", & challengekills);
    registerchallengescallback("gameEnd", & challengegameendmp);
  }
  callback::on_connect( & on_player_connect);
}

function on_player_connect() {
  initchallengedata();
  self addspecialistusedstatonconnect();
  self thread spawnwatcher();
  self thread monitorreloads();
  self thread monitorgrenadefire();
}

function initchallengedata() {
  self.pers["bulletStreak"] = 0;
  self.pers["lastBulletKillTime"] = 0;
  self.pers["stickExplosiveKill"] = 0;
  self.pers["carepackagesCalled"] = 0;
  self.pers["challenge_destroyed_air"] = 0;
  self.pers["challenge_destroyed_ground"] = 0;
  self.pers["challenge_anteup_earn"] = 0;
  self.pers["specialistStatAbilityUsage"] = 0;
  self.pers["canSetSpecialistStat"] = self isspecialistunlocked();
  self.pers["activeKillstreaks"] = [];
}

function addspecialistusedstatonconnect() {
  if(!isDefined(self.pers["challenge_heroweaponkills"])) {
    heroweaponname = self getloadoutitemref(0, "heroWeapon");
    heroweapon = getweapon(heroweaponname);
    if(heroweapon == level.weaponnone) {
      heroabilityname = self getheroabilityname();
      heroweapon = getweapon(heroabilityname);
    }
    if(heroweapon != level.weaponnone) {
      self addweaponstat(heroweapon, "used", 1);
    }
    self.pers["challenge_heroweaponkills"] = 0;
  }
}

function spawnwatcher() {
  self endon("disconnect");
  self.pers["killNemesis"] = 0;
  self.pers["killsFastMagExt"] = 0;
  self.pers["longshotsPerLife"] = 0;
  self.pers["specialistStatAbilityUsage"] = 0;
  self.challenge_defenderkillcount = 0;
  self.challenge_offenderkillcount = 0;
  self.challenge_offenderprojectilemultikillcount = 0;
  self.challenge_offendercomlinkkillcount = 0;
  self.challenge_offendersentryturretkillcount = 0;
  self.challenge_objectivedefensivekillcount = 0;
  self.challenge_objectiveoffensivekillcount = 0;
  self.challenge_scavengedcount = 0;
  self.challenge_resuppliednamekills = 0;
  self.challenge_objectivedefensive = undefined;
  self.challenge_objectiveoffensive = undefined;
  self.challenge_lastsurvivewithflakfrom = undefined;
  self.explosiveinfo = [];
  for(;;) {
    self waittill("spawned_player");
    self.weaponkillsthisspawn = [];
    self.attachmentkillsthisspawn = [];
    self.challenge_hatchettosscount = 0;
    self.challenge_hatchetkills = 0;
    self.retreivedblades = 0;
    self.challenge_combatrobotattackclientid = [];
    self thread watchdoublejump();
    self thread watchjump();
    self thread watchswimming();
    self thread watchwallrun();
    self thread watchslide();
    self thread watchsprint();
    self thread watchscavengelethal();
    self thread watchwallruntwooppositewallsnoground();
    self thread watchweaponchangecomplete();
  }
}

function watchscavengelethal() {
  self endon("death");
  self endon("disconnect");
  self.challenge_scavengedcount = 0;
  for(;;) {
    self waittill("scavenged_primary_grenade");
    self.challenge_scavengedcount++;
  }
}

function watchdoublejump() {
  self endon("death");
  self endon("disconnect");
  self.challenge_doublejump_begin = 0;
  self.challenge_doublejump_end = 0;
  for(;;) {
    ret = util::waittill_any_return("doublejump_begin", "doublejump_end", "disconnect");
    switch (ret) {
      case "doublejump_begin": {
        self.challenge_doublejump_begin = gettime();
        break;
      }
      case "doublejump_end": {
        self.challenge_doublejump_end = gettime();
        break;
      }
    }
  }
}

function watchjump() {
  self endon("death");
  self endon("disconnect");
  self.challenge_jump_begin = 0;
  self.challenge_jump_end = 0;
  for(;;) {
    ret = util::waittill_any_return("jump_begin", "jump_end", "disconnect");
    switch (ret) {
      case "jump_begin": {
        self.challenge_jump_begin = gettime();
        break;
      }
      case "jump_end": {
        self.challenge_jump_end = gettime();
        break;
      }
    }
  }
}

function watchswimming() {
  self endon("death");
  self endon("disconnect");
  self.challenge_swimming_begin = 0;
  self.challenge_swimming_end = 0;
  for(;;) {
    ret = util::waittill_any_return("swimming_begin", "swimming_end", "disconnect");
    switch (ret) {
      case "swimming_begin": {
        self.challenge_swimming_begin = gettime();
        break;
      }
      case "swimming_end": {
        self.challenge_swimming_end = gettime();
        break;
      }
    }
  }
}

function watchwallrun() {
  self endon("death");
  self endon("disconnect");
  self.challenge_wallrun_begin = 0;
  self.challenge_wallrun_end = 0;
  for(;;) {
    ret = util::waittill_any_return("wallrun_begin", "wallrun_end", "disconnect");
    switch (ret) {
      case "wallrun_begin": {
        self.challenge_wallrun_begin = gettime();
        break;
      }
      case "wallrun_end": {
        self.challenge_wallrun_end = gettime();
        break;
      }
    }
  }
}

function watchslide() {
  self endon("death");
  self endon("disconnect");
  self.challenge_slide_begin = 0;
  self.challenge_slide_end = 0;
  for(;;) {
    ret = util::waittill_any_return("slide_begin", "slide_end", "disconnect");
    switch (ret) {
      case "slide_begin": {
        self.challenge_slide_begin = gettime();
        break;
      }
      case "slide_end": {
        self.challenge_slide_end = gettime();
        break;
      }
    }
  }
}

function watchsprint() {
  self endon("death");
  self endon("disconnect");
  self.challenge_sprint_begin = 0;
  self.challenge_sprint_end = 0;
  for(;;) {
    ret = util::waittill_any_return("sprint_begin", "sprint_end", "disconnect");
    switch (ret) {
      case "sprint_begin": {
        self.challenge_sprint_begin = gettime();
        break;
      }
      case "sprint_end": {
        self.challenge_sprint_end = gettime();
        break;
      }
    }
  }
}

function challengekills(data) {
  victim = data.victim;
  attacker = data.attacker;
  time = data.time;
  level.numkills++;
  attacker.lastkilledplayer = victim;
  attackerdoublejumping = data.attackerdoublejumping;
  attackerflashbacktime = data.attackerflashbacktime;
  attackerheroability = data.attackerheroability;
  attackerheroabilityactive = data.attackerheroabilityactive;
  attackersliding = data.attackersliding;
  attackerspeedburst = data.attackerspeedburst;
  attackertraversing = data.attackertraversing;
  attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
  attackervisionpulsearray = data.attackervisionpulsearray;
  attackervisionpulseorigin = data.attackervisionpulseorigin;
  attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
  attackerwallrunning = data.attackerwallrunning;
  attackerwasconcussed = data.attackerwasconcussed;
  attackerwasflashed = data.attackerwasflashed;
  attackerwasheatwavestunned = data.attackerwasheatwavestunned;
  attackerwasonground = data.attackeronground;
  attackerwasunderwater = data.attackerwasunderwater;
  attackerlastfastreloadtime = data.attackerlastfastreloadtime;
  lastweaponbeforetoss = data.lastweaponbeforetoss;
  meansofdeath = data.smeansofdeath;
  ownerweaponatlaunch = data.ownerweaponatlaunch;
  victimbedout = data.bledout;
  victimorigin = data.victimorigin;
  victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
  victimcombatefficieny = data.victimcombatefficieny;
  victimelectrifiedby = data.victimelectrifiedby;
  victimflashbacktime = data.victimflashbacktime;
  victimheroability = data.victimheroability;
  victimheroabilityactive = data.victimheroabilityactive;
  victimspeedburst = data.victimspeedburst;
  victimspeedburstlastontime = data.victimspeedburstlastontime;
  victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
  victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
  victimvisionpulsearray = data.victimvisionpulsearray;
  victimvisionpulseorigin = data.victimvisionpulseorigin;
  victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
  victimattackersthisspawn = data.victimattackersthisspawn;
  victimwasdoublejumping = data.victimwasdoublejumping;
  victimwasinslamstate = data.victimwasinslamstate;
  victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
  victimwasonground = data.victimonground;
  victimwasunderwater = data.wasunderwater;
  victimwaswallrunning = data.victimwaswallrunning;
  victimlaststunnedby = data.victimlaststunnedby;
  victimactiveproximitygrenades = data.victim.activeproximitygrenades;
  victimactivebouncingbetties = data.victim.activebouncingbetties;
  attackerlastflashedby = data.attackerlastflashedby;
  attackerlaststunnedby = data.attackerlaststunnedby;
  attackerlaststunnedtime = data.attackerlaststunnedtime;
  attackerwassliding = data.attackerwassliding;
  attackerwassprinting = data.attackerwassprinting;
  wasdefusing = data.wasdefusing;
  wasplanting = data.wasplanting;
  inflictorownerwassprinting = data.inflictorownerwassprinting;
  player = data.attacker;
  playerorigin = data.attackerorigin;
  weapon = data.weapon;
  victim_doublejump_begin = data.victim_doublejump_begin;
  victim_doublejump_end = data.victim_doublejump_end;
  victim_jump_begin = data.victim_jump_begin;
  victim_jump_end = data.victim_jump_end;
  victim_swimming_begin = data.victim_swimming_begin;
  victim_swimming_end = data.victim_swimming_end;
  victim_slide_begin = data.victim_slide_begin;
  victim_slide_end = data.victim_slide_end;
  victim_wallrun_begin = data.victim_wallrun_begin;
  victim_wallrun_end = data.victim_wallrun_end;
  victim_was_drowning = data.victim_was_drowning;
  attacker_doublejump_begin = data.attacker_doublejump_begin;
  attacker_doublejump_end = data.attacker_doublejump_end;
  attacker_jump_begin = data.attacker_jump_begin;
  attacker_jump_end = data.attacker_jump_end;
  attacker_swimming_begin = data.attacker_swimming_begin;
  attacker_swimming_end = data.attacker_swimming_end;
  attacker_slide_begin = data.attacker_slide_begin;
  attacker_slide_end = data.attacker_slide_end;
  attacker_wallrun_begin = data.attacker_wallrun_begin;
  attacker_wallrun_end = data.attacker_wallrun_end;
  attacker_was_drowning = data.attacker_was_drowning;
  attacker_sprint_end = data.attacker_sprint_end;
  attacker_sprint_begin = data.attacker_sprint_begin;
  attacker_wallrantwooppositewallsnoground = data.attacker_wallrantwooppositewallsnoground;
  inflictoriscooked = data.inflictoriscooked;
  inflictorchallenge_hatchettosscount = data.inflictorchallenge_hatchettosscount;
  inflictorownerwassprinting = data.inflictorownerwassprinting;
  inflictorplayerhasengineerperk = data.inflictorplayerhasengineerperk;
  inflictor = data.einflictor;
  if(!isDefined(data.weapon)) {
    return;
  }
  if(!isDefined(player) || !isplayer(player) || weapon == level.weaponnone) {
    return;
  }
  weaponclass = util::getweaponclass(weapon);
  baseweapon = getbaseweapon(weapon);
  baseweaponitemindex = getbaseweaponitemindex(baseweapon);
  weaponpurchased = player isitempurchased(baseweaponitemindex);
  victimsupportindex = victim.team;
  playersupportindex = player.team;
  if(!level.teambased) {
    playersupportindex = player.entnum;
    victimsupportindex = victim.entnum;
  }
  if(meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
    bulletkill = 1;
  } else {
    bulletkill = 0;
  }
  if(level.teambased) {
    if(player.team == victim.team) {
      return;
    }
  } else if(player == victim) {
    return;
  }
  killstreak = killstreaks::get_from_weapon(data.weapon);
  if(!isDefined(killstreak)) {
    player processspecialistchallenge("kills");
    if(weapon.isheroweapon == 1) {
      player processspecialistchallenge("kills_weapon");
      player.heroweaponkillsthisactivation++;
      player.pers["challenge_heroweaponkills"]++;
      if(player.pers["challenge_heroweaponkills"] >= 6) {
        player processspecialistchallenge("kill_one_game_weapon");
        player.pers["challenge_heroweaponkills"] = 0;
      }
    }
  }
  if(bulletkill) {
    if(weaponpurchased) {
      if(weaponclass == "weapon_sniper") {
        if(isDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
          player addplayerstat("kill_enemy_one_bullet_sniper", 1);
          player addweaponstat(weapon, "kill_enemy_one_bullet_sniper", 1);
        }
      } else if(weaponclass == "weapon_cqb") {
        if(isDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
          player addplayerstat("kill_enemy_one_bullet_shotgun", 1);
          player addweaponstat(weapon, "kill_enemy_one_bullet_shotgun", 1);
        }
      }
    }
    if(getdvarint("ui_enablePromoTracking", 0) && meansofdeath == "MOD_HEAD_SHOT") {
      util::function_522d8c7d(1);
    }
    if((time - data.attacker_swimming_end) <= 2000 && (time - data.attacker_doublejump_begin) <= 2000) {
      player addplayerstat("kill_after_doublejump_out_of_water", 1);
    }
    if(attackerwassliding) {
      if(attacker_doublejump_end == attacker_slide_begin) {
        player addplayerstat("kill_while_sliding_from_doublejump", 1);
      }
    }
    if(player isbonuscardactive(2, player.class_num) && player isitempurchased(getitemindexfromref("bonuscard_primary_gunfighter_3"))) {
      if(isDefined(weapon.attachments) && weapon.attachments.size == 6) {
        player addplayerstat("kill_with_gunfighter", 1);
      }
    }
    checkkillstreak5(baseweapon, player);
    if(weapon.isdualwield && weaponpurchased) {
      checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
    }
    if(isDefined(weapon.attachments) && weapon.attachments.size > 0) {
      attachmentname = player getweaponoptic(weapon);
      if(isDefined(attachmentname) && attachmentname != "" && player weaponhasattachmentandunlocked(weapon, attachmentname)) {
        if(weapon.attachments.size > 5 && player allweaponattachmentsunlocked(weapon) && !isDefined(attacker.tookweaponfrom[weapon])) {
          player addplayerstat("kill_optic_5_attachments", 1);
        }
        if(isDefined(player.attachmentkillsthisspawn[attachmentname])) {
          player.attachmentkillsthisspawn[attachmentname]++;
          if(player.attachmentkillsthisspawn[attachmentname] == 5) {
            player addweaponstat(weapon, "killstreak_5_attachment", 1);
          }
        } else {
          player.attachmentkillsthisspawn[attachmentname] = 1;
        }
        if(weapon_utils::ispistol(weapon.rootweapon)) {
          if(player weaponhasattachmentandunlocked(weapon, "suppressed", "extbarrel")) {
            player addplayerstat("kills_pistol_lasersight_suppressor_longbarrel", 1);
          }
        }
      }
      if(player weaponhasattachmentandunlocked(weapon, "suppressed")) {
        if(attacker util::has_hard_wired_perk_purchased_and_equipped() && attacker util::has_ghost_perk_purchased_and_equipped() && attacker util::has_jetquiet_perk_purchased_and_equipped()) {
          player addplayerstat("kills_suppressor_ghost_hardwired_blastsuppressor", 1);
        }
      }
      if(player playerads() == 1) {
        if(isDefined(player.smokegrenadetime) && isDefined(player.smokegrenadeposition)) {
          if((player.smokegrenadetime + 14000) > time) {
            if(player util::is_looking_at(player.smokegrenadeposition) || distancesquared(player.origin, player.smokegrenadeposition) < 40000) {
              if(player weaponhasattachmentandunlocked(weapon, "ir")) {
                player addplayerstat("kill_with_thermal_and_smoke_ads", 1);
                player addweaponstat(weapon, "kill_thermal_through_smoke", 1);
              }
            }
          }
        }
      }
      if(weapon.attachments.size > 1) {
        if(player playerads() == 1) {
          if(player weaponhasattachmentandunlocked(weapon, "grip", "quickdraw")) {
            player addplayerstat("kills_ads_quickdraw_and_grip", 1);
          }
          if(player weaponhasattachmentandunlocked(weapon, "swayreduc", "stalker")) {
            player addplayerstat("kills_ads_stock_and_cpu", 1);
          }
        } else if(player weaponhasattachmentandunlocked(weapon, "rf", "steadyaim")) {
          if(attacker util::has_fast_hands_perk_purchased_and_equipped()) {
            player addplayerstat("kills_hipfire_rapidfire_lasersights_fasthands", 1);
          }
        }
        if(player weaponhasattachmentandunlocked(weapon, "fastreload", "extclip")) {
          player.pers["killsFastMagExt"]++;
          if(player.pers["killsFastMagExt"] > 4) {
            player addplayerstat("kills_one_life_fastmags_and_extclip", 1);
            player.pers["killsFastMagExt"] = 0;
          }
        }
      }
      if(weapon.attachments.size > 2) {
        if(meansofdeath == "MOD_HEAD_SHOT") {
          if(player weaponhasattachmentandunlocked(weapon, "fmj", "damage", "extbarrel")) {
            player addplayerstat("headshot_fmj_highcaliber_longbarrel", 1);
          }
        }
      }
      if(weapon.attachments.size > 4) {
        if(player weaponhasattachmentandunlocked(weapon, "extclip", "grip", "fastreload", "quickdraw", "stalker")) {
          player addplayerstat("kills_extclip_grip_fastmag_quickdraw_stock", 1);
        }
      }
    }
    if(victim_was_drowning && attacker_was_drowning) {
      player addplayerstat("dr_lung", 1);
    }
    if(isDefined(attackerlastfastreloadtime) && (time - attackerlastfastreloadtime) <= 5000 && player weaponhasattachmentandunlocked(weapon, "fastreload")) {
      player addplayerstat("kills_after_reload_fastreload", 1);
    }
    if(victim.idflagstime == time) {
      if(victim.idflags & 8) {
        player addplayerstat("kill_enemy_through_wall", 1);
        if(player weaponhasattachmentandunlocked(weapon, "fmj")) {
          player addplayerstat("kill_enemy_through_wall_with_fmj", 1);
        }
      }
    }
    if(attacker_wallrantwooppositewallsnoground === 1) {
      player addplayerstat("kill_while_wallrunning_2_walls", 1);
    }
  } else {
    if(weapon_utils::ismeleemod(meansofdeath) && !isDefined(killstreak)) {
      player addplayerstat("melee", 1);
      if(weapon_utils::ispunch(weapon)) {
        player addplayerstat("kill_enemy_with_fists", 1);
      }
      checkkillstreak5(baseweapon, player);
    } else {
      if(weaponpurchased) {
        if(weapon == player.grenadetypeprimary) {
          if(player.challenge_scavengedcount > 0) {
            player.challenge_resuppliednamekills++;
            if(player.challenge_resuppliednamekills >= 3) {
              player addplayerstat("kills_3_resupplied_nade_one_life", 1);
              player.challenge_resuppliednamekills = 0;
            }
            player.challenge_scavengedcount--;
          }
        }
        if(isDefined(inflictoriscooked)) {
          if(inflictoriscooked == 1 && weapon.rootweapon.name != "hatchet") {
            player addplayerstat("kill_with_cooked_grenade", 1);
          }
        }
        if(victimlaststunnedby === player) {
          if(weaponclass == "weapon_grenade") {
            player addplayerstat("kill_stun_lethal", 1);
          }
        }
        if(baseweapon == level.weaponspecialcrossbow) {
          if(weapon.isdualwield) {
            checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
          }
        }
        if(baseweapon == level.weaponshotgunenergy) {
          if(isDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
            player addplayerstat("kill_enemy_one_bullet_shotgun", 1);
            player addweaponstat(weapon, "kill_enemy_one_bullet_shotgun", 1);
          }
        }
      }
      if(baseweapon.forcedamagehitlocation || baseweapon == level.weaponspecialcrossbow || baseweapon == level.weaponshotgunenergy || baseweapon == level.weaponspecialdiscgun || baseweapon == level.weaponballisticknife || baseweapon == level.weaponlauncherex41) {
        checkkillstreak5(baseweapon, player);
      }
    }
  }
  if(isDefined(attacker.tookweaponfrom[weapon]) && isDefined(attacker.tookweaponfrom[weapon].previousowner)) {
    if(!isDefined(attacker.tookweaponfrom[weapon].previousowner.team) || attacker.tookweaponfrom[weapon].previousowner.team != player.team) {
      player addplayerstat("kill_with_pickup", 1);
    }
  }
  awarded_kill_enemy_that_blinded_you = 0;
  playerhastacticalmask = loadout::hastacticalmask(player);
  if(attackerwasflashed) {
    if(attackerlastflashedby === victim && !playerhastacticalmask) {
      player addplayerstat("kill_enemy_that_blinded_you", 1);
      awarded_kill_enemy_that_blinded_you = 1;
    }
  }
  if(!awarded_kill_enemy_that_blinded_you && isDefined(attackerlaststunnedtime) && (attackerlaststunnedtime + 5000) > time) {
    if(attackerlaststunnedby === victim && !playerhastacticalmask) {
      player addplayerstat("kill_enemy_that_blinded_you", 1);
      awarded_kill_enemy_that_blinded_you = 1;
    }
  }
  killedstunnedvictim = 0;
  if(isDefined(victim.lastconcussedby) && victim.lastconcussedby == attacker) {
    if(victim.concussionendtime > time) {
      if(player util::is_item_purchased("concussion_grenade")) {
        player addplayerstat("kill_concussed_enemy", 1);
      }
      killedstunnedvictim = 1;
      player addweaponstat(getweapon("concussion_grenade"), "CombatRecordStat", 1);
    }
  }
  if(isDefined(victim.lastshockedby) && victim.lastshockedby == attacker) {
    if(victim.shockendtime > time) {
      if(player util::is_item_purchased("proximity_grenade")) {
        player addplayerstat("kill_shocked_enemy", 1);
      }
      player addweaponstat(getweapon("proximity_grenade"), "CombatRecordStat", 1);
      killedstunnedvictim = 1;
      if(weapon.rootweapon.name == "bouncingbetty") {
        player addplayerstat("kill_trip_mine_shocked", 1);
      }
    }
  }
  if(victim util::isflashbanged()) {
    if(isDefined(victim.lastflashedby) && victim.lastflashedby == player) {
      killedstunnedvictim = 1;
      if(player util::is_item_purchased("flash_grenade")) {
        player addplayerstat("kill_flashed_enemy", 1);
      }
      player addweaponstat(getweapon("flash_grenade"), "CombatRecordStat", 1);
    }
  }
  if(level.teambased) {
    if(!isDefined(player.pers["kill_every_enemy_with_specialist"]) && (level.playercount[victim.pers["team"]] > 3 && player.pers["killed_players_with_specialist"].size >= level.playercount[victim.pers["team"]])) {
      player addplayerstat("kill_every_enemy", 1);
      player.pers["kill_every_enemy_with_specialist"] = 1;
    }
    if(isDefined(victimattackersthisspawn) && isarray(victimattackersthisspawn)) {
      if(victimattackersthisspawn.size > 5) {
        attackercount = 0;
        foreach(attacking_player in victimattackersthisspawn) {
          if(!isDefined(attacking_player)) {
            continue;
          }
          if(attacking_player == attacker) {
            continue;
          }
          if(attacking_player.team != attacker.team) {
            continue;
          }
          attackercount++;
        }
        if(attackercount > 4) {
          player addplayerstat("kill_enemy_5_teammates_assists", 1);
        }
      }
    }
  }
  if(isDefined(killstreak)) {
    if(killstreak == "rcbomb" || killstreak == "inventory_rcbomb") {
      if(!victimwasonground || victimwaswallrunning) {
        player addplayerstat("kill_wallrunner_or_air_with_rcbomb", 1);
      }
    }
    if(killstreak == "autoturret" || killstreak == "inventory_autoturret") {
      if(isDefined(inflictor) && player util::is_item_purchased("killstreak_auto_turret")) {
        if(!isDefined(inflictor.challenge_killcount)) {
          inflictor.challenge_killcount = 0;
        }
        inflictor.challenge_killcount++;
        if(inflictor.challenge_killcount == 5) {
          player addplayerstat("kills_auto_turret_5", 1);
        }
      }
    }
  }
  if(isDefined(victim.challenge_combatrobotattackclientid[player.clientid])) {
    if(!isDefined(inflictor) || !isDefined(inflictor.killstreaktype) || !isstring(inflictor.killstreaktype) || inflictor.killstreaktype != "combat_robot") {
      player addplayerstat("kill_enemy_who_damaged_robot", 1);
    }
  }
  if(player isbonuscardactive(8, player.class_num) && player util::is_item_purchased("bonuscard_danger_close")) {
    if(weaponclass == "weapon_grenade") {
      player addbonuscardstat(8, "kills", 1, player.class_num);
    }
    if(weapon.rootweapon.name == "hatchet" && inflictorchallenge_hatchettosscount <= 2) {
      player.challenge_hatchetkills++;
      if(player.challenge_hatchetkills == 2) {
        player addplayerstat("kills_first_throw_both_hatchets", 1);
      }
    }
  }
  player trackkillstreaksupportkills(victim);
  if(!isDefined(killstreak)) {
    if(attackerwasunderwater) {
      player addplayerstat("kill_while_underwater", 1);
    }
    if(player util::has_purchased_perk_equipped("specialty_jetcharger")) {
      if(attacker_doublejump_begin > attacker_doublejump_end || (attacker_doublejump_end + 3000) > time || (attacker_slide_begin > attacker_slide_end || (attacker_slide_end + 3000) > time)) {
        player addplayerstat("kills_after_jumping_or_sliding", 1);
        if(player util::has_purchased_perk_equipped("specialty_overcharge")) {
          player addplayerstat("kill_overclock_afterburner_specialist_weapon_after_thrust", 1);
        }
      }
    }
    trackedplayer = 0;
    if(player util::has_purchased_perk_equipped("specialty_tracker")) {
      if(!victim hasperk("specialty_trackerjammer")) {
        player addplayerstat("kill_detect_tracker", 1);
        trackedplayer = 1;
      }
    }
    if(player util::has_purchased_perk_equipped("specialty_detectnearbyenemies")) {
      if(!victim hasperk("specialty_sixthsensejammer")) {
        player addplayerstat("kill_enemy_sixth_sense", 1);
        if(player util::has_purchased_perk_equipped("specialty_loudenemies")) {
          if(!victim hasperk("specialty_quieter")) {
            player addplayerstat("kill_sixthsense_awareness", 1);
          }
        }
      }
      if(trackedplayer) {
        player addplayerstat("kill_tracker_sixthsense", 1);
      }
    }
    if(weapon.isheroweapon == 1 || attackerheroabilityactive) {
      if(player util::has_purchased_perk_equipped("specialty_overcharge")) {
        player addplayerstat("kill_with_specialist_overclock", 1);
      }
    }
    if(player util::has_purchased_perk_equipped("specialty_gpsjammer")) {
      if(uav::hasuav(victimsupportindex)) {
        player addplayerstat("kill_uav_enemy_with_ghost", 1);
      }
      if(player util::has_blind_eye_perk_purchased_and_equipped()) {
        activekillstreaks = victim killstreaks::getactivekillstreaks();
        awarded_kill_blindeye_ghost_aircraft = 0;
        foreach(activestreak in activekillstreaks) {
          if(awarded_kill_blindeye_ghost_aircraft) {
            continue;
          }
          switch (activestreak.killstreaktype) {
            case "drone_striked":
            case "helicopter_comlink":
            case "sentinel":
            case "uav": {
              player addplayerstat("kill_blindeye_ghost_aircraft", 1);
              awarded_kill_blindeye_ghost_aircraft = 1;
              break;
            }
          }
        }
      }
    }
    if(player util::has_purchased_perk_equipped("specialty_flakjacket")) {
      if(isDefined(player.challenge_lastsurvivewithflakfrom) && player.challenge_lastsurvivewithflakfrom == victim) {
        player addplayerstat("kill_enemy_survive_flak", 1);
      }
      if(player util::has_tactical_mask_purchased_and_equipped()) {
        recentlysurvivedflak = 0;
        if(isDefined(player.challenge_lastsurvivewithflaktime)) {
          if((player.challenge_lastsurvivewithflaktime + 3000) > time) {
            recentlysurvivedflak = 1;
          }
        }
        recentlystunned = 0;
        if(isDefined(player.laststunnedtime)) {
          if((player.laststunnedtime + 2000) > time) {
            recentlystunned = 1;
          }
        }
        if(recentlysurvivedflak || player util::isflashbanged() || recentlystunned) {
          player addplayerstat("kill_flak_tac_while_stunned", 1);
        }
      }
    }
    if(player util::has_hard_wired_perk_purchased_and_equipped()) {
      if(victim counteruav::hasindexactivecounteruav(victimsupportindex) || victim emp::hasactiveemp()) {
        player addplayerstat("kills_counteruav_emp_hardline", 1);
      }
    }
    if(player util::has_scavenger_perk_purchased_and_equipped()) {
      if(player.scavenged) {
        player addplayerstat("kill_after_resupply", 1);
        if(trackedplayer) {
          player addplayerstat("kill_scavenger_tracker_resupply", 1);
        }
      }
    }
    if(player util::has_fast_hands_perk_purchased_and_equipped()) {
      if(bulletkill) {
        if(attackerwassprinting || (attacker_sprint_end + 3000) > time) {
          player addplayerstat("kills_after_sprint_fasthands", 1);
          if(player util::has_gung_ho_perk_purchased_and_equipped()) {
            player addplayerstat("kill_fasthands_gungho_sprint", 1);
          }
        }
      }
    }
    if(player util::has_hard_wired_perk_purchased_and_equipped()) {
      if(player util::has_cold_blooded_perk_purchased_and_equipped()) {
        player addplayerstat("kill_hardwired_coldblooded", 1);
      }
    }
    killedplayerwithgungho = 0;
    if(player util::has_gung_ho_perk_purchased_and_equipped()) {
      if(bulletkill) {
        killedplayerwithgungho = 1;
        if(attackerwassprinting && player playerads() != 1) {
          player addplayerstat("kill_hip_gung_ho", 1);
        }
      }
      if(weaponclass == "weapon_grenade") {
        if(isDefined(inflictorownerwassprinting) && inflictorownerwassprinting == 1) {
          killedplayerwithgungho = 1;
          player addplayerstat("kill_hip_gung_ho", 1);
        }
      }
    }
    if(player util::has_jetquiet_perk_purchased_and_equipped()) {
      if(attackerdoublejumping || (attacker_doublejump_end + 3000) > time) {
        player addplayerstat("kill_blast_doublejump", 1);
        if(player util::has_ghost_perk_purchased_and_equipped()) {
          if(uav::hasuav(victimsupportindex)) {
            player addplayerstat("kill_doublejump_uav_engineer_hardwired", 1);
          }
        }
      }
    }
    if(player util::has_awareness_perk_purchased_and_equipped()) {
      player addplayerstat("kill_awareness", 1);
    }
    if(killedstunnedvictim) {
      if(player util::has_tactical_mask_purchased_and_equipped()) {
        player addplayerstat("kill_stunned_tacmask", 1);
        if(killedplayerwithgungho == 1) {
          player addplayerstat("kill_sprint_stunned_gungho_tac", 1);
        }
      }
    }
    if(player util::has_ninja_perk_purchased_and_equipped()) {
      player addplayerstat("kill_dead_silence", 1);
      if(distancesquared(playerorigin, victimorigin) < 14400) {
        if(player util::has_awareness_perk_purchased_and_equipped()) {
          player addplayerstat("kill_close_deadsilence_awareness", 1);
        }
        if(player util::has_jetquiet_perk_purchased_and_equipped()) {
          player addplayerstat("kill_close_blast_deadsilence", 1);
        }
      }
    }
    greedcardsactive = 0;
    if(player isbonuscardactive(5, player.class_num) && player util::is_item_purchased("bonuscard_perk_1_greed")) {
      greedcardsactive++;
    }
    if(player isbonuscardactive(6, player.class_num) && player util::is_item_purchased("bonuscard_perk_2_greed")) {
      greedcardsactive++;
    }
    if(player isbonuscardactive(7, player.class_num) && player util::is_item_purchased("bonuscard_perk_3_greed")) {
      greedcardsactive++;
    }
    if(greedcardsactive >= 2) {
      player addplayerstat("kill_2_greed_2_perks_each", 1);
    }
    if(player bonuscardactivecount(player.class_num) >= 2) {
      player addplayerstat("kill_2_wildcards", 1);
    }
    gunfighteroverkillactive = 0;
    if(player isbonuscardactive(4, player.class_num) && player util::is_item_purchased("bonuscard_overkill")) {
      primaryattachmentstotal = 0;
      if(isDefined(player.primaryloadoutweapon)) {
        primaryattachmentstotal = player.primaryloadoutweapon.attachments.size;
      }
      secondaryattachmentstotal = 0;
      if(isDefined(player.secondaryloadoutweapon)) {
        secondaryattachmentstotal = player.secondaryloadoutweapon.attachments.size;
      }
      if((primaryattachmentstotal + secondaryattachmentstotal) >= 5) {
        gunfighteroverkillactive = 1;
      }
    }
    if(isDefined(player.primaryloadoutweapon) && weapon == player.primaryloadoutweapon || (isDefined(player.primaryloadoutaltweapon) && weapon == player.primaryloadoutaltweapon)) {
      if(player isbonuscardactive(0, player.class_num) && player util::is_item_purchased("bonuscard_primary_gunfighter")) {
        player addbonuscardstat(0, "kills", 1, player.class_num);
        player addplayerstat("kill_with_loadout_weapon_with_3_attachments", 1);
      }
      if(isDefined(player.secondaryweaponkill) && player.secondaryweaponkill == 1) {
        player.primaryweaponkill = 0;
        player.secondaryweaponkill = 0;
        if(player isbonuscardactive(4, player.class_num) && player util::is_item_purchased("bonuscard_overkill")) {
          player addbonuscardstat(4, "kills", 1, player.class_num);
          player addplayerstat("kill_with_both_primary_weapons", 1);
          if(gunfighteroverkillactive) {
            player addplayerstat("kill_overkill_gunfighter_5_attachments", 1);
          }
        }
      } else {
        player.primaryweaponkill = 1;
      }
    } else if(isDefined(player.secondaryloadoutweapon) && weapon == player.secondaryloadoutweapon || (isDefined(player.secondaryloadoutaltweapon) && weapon == player.secondaryloadoutaltweapon)) {
      if(player isbonuscardactive(3, player.class_num) && player util::is_item_purchased("bonuscard_secondary_gunfighter")) {
        player addbonuscardstat(3, "kills", 1, player.class_num);
      }
      if(isDefined(player.primaryweaponkill) && player.primaryweaponkill == 1) {
        player.primaryweaponkill = 0;
        player.secondaryweaponkill = 0;
        if(player isbonuscardactive(4, player.class_num) && player util::is_item_purchased("bonuscard_overkill")) {
          player addbonuscardstat(4, "kills", 1, player.class_num);
          player addplayerstat("kill_with_both_primary_weapons", 1);
          if(gunfighteroverkillactive) {
            player addplayerstat("kill_overkill_gunfighter_5_attachments", 1);
          }
        }
      } else {
        player.secondaryweaponkill = 1;
      }
    }
    if(player util::has_hacker_perk_purchased_and_equipped() && player util::has_hard_wired_perk_purchased_and_equipped()) {
      should_award_kill_near_plant_engineer_hardwired = 0;
      if(isDefined(victimactivebouncingbetties)) {
        foreach(bouncingbettyinfo in victimactivebouncingbetties) {
          if(!isDefined(bouncingbettyinfo) || !isDefined(bouncingbettyinfo.origin)) {
            continue;
          }
          if(distancesquared(bouncingbettyinfo.origin, victimorigin) < (400 * 400)) {
            should_award_kill_near_plant_engineer_hardwired = 1;
            break;
          }
        }
      }
      if(isDefined(victimactiveproximitygrenades) && should_award_kill_near_plant_engineer_hardwired == 0) {
        foreach(proximitygrenadeinfo in victimactiveproximitygrenades) {
          if(!isDefined(proximitygrenadeinfo) || !isDefined(proximitygrenadeinfo.origin)) {
            continue;
          }
          if(distancesquared(proximitygrenadeinfo.origin, victimorigin) < (400 * 400)) {
            should_award_kill_near_plant_engineer_hardwired = 1;
            break;
          }
        }
      }
      if(should_award_kill_near_plant_engineer_hardwired) {
        player addplayerstat("kill_near_plant_engineer_hardwired", 1);
      }
    }
  } else if(weapon.name == "supplydrop") {
    if(isDefined(inflictorplayerhasengineerperk)) {
      player addplayerstat("kill_booby_trap_engineer", 1);
    }
  }
  if(weapon.isheroweapon == 1 || attackerheroabilityactive || isDefined(killstreak)) {
    if(player util::has_purchased_perk_equipped("specialty_overcharge") && player util::has_purchased_perk_equipped("specialty_anteup")) {
      player addplayerstat("kill_anteup_overclock_scorestreak_specialist", 1);
    }
  }
}

function on_player_spawn() {
  if(canprocesschallenges()) {
    self fix_challenge_stats_on_spawn();
  }
}

function get_challenge_stat(stat_name) {
  return self getdstat("playerstatslist", stat_name, "challengevalue");
}

function force_challenge_stat(stat_name, stat_value) {
  self setdstat("playerstatslist", stat_name, "statvalue", stat_value);
  self setdstat("playerstatslist", stat_name, "challengevalue", stat_value);
}

function get_challenge_group_stat(group_name, stat_name) {
  return self getdstat("groupstats", group_name, "stats", stat_name, "challengevalue");
}

function fix_challenge_stats_on_spawn() {
  player = self;
  if(!isDefined(player)) {
    return;
  }
  if(player.fix_challenge_stats_performed === 1) {
    return;
  }
  player fix_tu6_weapon_for_diamond("special_crossbow_for_diamond");
  player fix_tu6_weapon_for_diamond("melee_crowbar_for_diamond");
  player fix_tu6_weapon_for_diamond("melee_sword_for_diamond");
  player fix_tu6_ar_garand();
  player fix_tu6_pistol_shotgun();
  player tu7_fix_100_percenter();
  player.fix_challenge_stats_performed = 1;
}

function fix_tu6_weapon_for_diamond(stat_name) {
  player = self;
  wepaon_for_diamond = player get_challenge_stat(stat_name);
  if(wepaon_for_diamond == 1) {
    secondary_mastery = player get_challenge_stat("secondary_mastery");
    if(secondary_mastery == 3) {
      player force_challenge_stat(stat_name, 2);
    } else {
      player force_challenge_stat(stat_name, 0);
    }
  }
}

function fix_tu6_ar_garand() {
  player = self;
  group_weapon_assault = player get_challenge_group_stat("weapon_assault", "challenges");
  weapons_mastery_assault = player get_challenge_stat("weapons_mastery_assault");
  if(group_weapon_assault >= 49 && weapons_mastery_assault < 1) {
    player force_challenge_stat("weapons_mastery_assault", 1);
    player addplayerstat("ar_garand_for_diamond", 1);
  }
}

function fix_tu6_pistol_shotgun() {
  player = self;
  group_weapon_pistol = player get_challenge_group_stat("weapon_pistol", "challenges");
  secondary_mastery_pistol = player get_challenge_stat("secondary_mastery_pistol");
  if(group_weapon_pistol >= 21 && secondary_mastery_pistol < 1) {
    player force_challenge_stat("secondary_mastery_pistol", 1);
    player addplayerstat("pistol_shotgun_for_diamond", 1);
  }
}

function completed_specific_challenge(target_value, challenge_name) {
  challenge_count = self get_challenge_stat(challenge_name);
  return challenge_count >= target_value;
}

function tally_completed_challenge(target_value, challenge_name) {
  return true;
}

function tu7_fix_100_percenter() {
  self tu7_fix_mastery_perk_2();
}

function tu7_fix_mastery_perk_2() {
  player = self;
  mastery_perk_2 = player get_challenge_stat("mastery_perk_2");
  if(mastery_perk_2 >= 12) {
    return;
  }
  if(player completed_specific_challenge(200, "earn_scorestreak_anteup") == 0) {
    return;
  }
  perk_2_tally = 1;
  perk_2_tally = perk_2_tally + player tally_completed_challenge(100, "destroy_ai_scorestreak_coldblooded");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(100, "kills_counteruav_emp_hardline");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(200, "kill_after_resupply");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(100, "kills_after_sprint_fasthands");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(200, "kill_detect_tracker");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(10, "earn_5_scorestreaks_anteup");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(25, "kill_scavenger_tracker_resupply");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(25, "kill_hardwired_coldblooded");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(25, "kill_anteup_overclock_scorestreak_specialist");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(50, "kill_fasthands_gungho_sprint");
  perk_2_tally = perk_2_tally + player tally_completed_challenge(50, "kill_tracker_sixthsense");
  if(mastery_perk_2 < perk_2_tally) {
    player addplayerstat("mastery_perk_2", 1);
  }
}

function getbaseweapon(weapon) {
  base_weapon_param = [[level.get_base_weapon_param]](weapon);
  base_weapon_param_name = str_strip_lh_or_dw(base_weapon_param.name);
  base_weapon_param_name = str_strip_lh_from_crossbow(base_weapon_param_name);
  return getweapon(getreffromitemindex(getbaseweaponitemindex(getweapon(base_weapon_param_name))));
}

function str_strip_lh_from_crossbow(str) {
  if(strendswith(str, "crossbowlh")) {
    return getsubstr(str, 0, str.size - 2);
  }
  return str;
}

function str_strip_lh_or_dw(str) {
  if(strendswith(str, "_lh") || strendswith(str, "_dw")) {
    return getsubstr(str, 0, str.size - 3);
  }
  return str;
}

function checkkillstreak5(baseweapon, player) {
  if(isDefined(player.weaponkillsthisspawn[baseweapon])) {
    player.weaponkillsthisspawn[baseweapon]++;
    if((player.weaponkillsthisspawn[baseweapon] % 5) == 0) {
      player addweaponstat(baseweapon, "killstreak_5", 1);
    }
  } else {
    player.weaponkillsthisspawn[baseweapon] = 1;
  }
}

function checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end) {
  if(attackerwassprinting || (attacker_sprint_end + 1000) > time) {
    if(attacker util::has_gung_ho_perk_purchased_and_equipped()) {
      player addplayerstat("kills_sprinting_dual_wield_and_gung_ho", 1);
    }
  }
}

function challengegameendmp(data) {
  player = data.player;
  winner = data.winner;
  if(!isDefined(player)) {
    return;
  }
  if(endedearly(winner)) {
    return;
  }
  if(level.teambased) {
    winnerscore = game["teamScores"][winner];
    loserscore = getlosersteamscores(winner);
  }
  mostkillsleastdeaths = 1;
  for(index = 0; index < level.placement["all"].size; index++) {
    if(level.placement["all"][index].deaths < player.deaths) {
      mostkillsleastdeaths = 0;
    }
    if(level.placement["all"][index].kills > player.kills) {
      mostkillsleastdeaths = 0;
    }
  }
  if(mostkillsleastdeaths && player.kills > 0 && level.placement["all"].size > 3) {
    if(level.teambased) {
      playeriswinner = player.team === winner;
    } else {
      playeriswinner = level.placement["all"][0] === winner || level.placement["all"][1] === winner || level.placement["all"][2] === winner;
    }
    if(playeriswinner) {
      player addplayerstat("most_kills_least_deaths", 1);
    }
  }
}

function killedbaseoffender(objective, weapon) {
  self endon("disconnect");
  self addplayerstatwithgametype("defends", 1);
  self.challenge_offenderkillcount++;
  if(!isDefined(self.challenge_objectiveoffensive) || self.challenge_objectiveoffensive != objective) {
    self.challenge_objectiveoffensivekillcount = 0;
  }
  self.challenge_objectiveoffensivekillcount++;
  self.challenge_objectiveoffensive = objective;
  killstreak = killstreaks::get_from_weapon(weapon);
  if(isDefined(killstreak)) {
    switch (killstreak) {
      case "drone_strike":
      case "inventory_drone_strike":
      case "inventory_planemortar":
      case "inventory_remote_missile":
      case "planemortar":
      case "remote_missile": {
        self.challenge_offenderprojectilemultikillcount++;
        break;
      }
      case "helicopter_comlink":
      case "inventory_helicopter_comlink": {
        self.challenge_offendercomlinkkillcount++;
        break;
      }
      case "combat_robot":
      case "inventory_combat_robot": {
        self addplayerstat("kill_attacker_with_robot_or_tank", 1);
        break;
      }
      case "autoturret":
      case "inventory_autoturret": {
        self.challenge_offendersentryturretkillcount++;
        self addplayerstat("kill_attacker_with_robot_or_tank", 1);
        break;
      }
    }
  }
  if(self.challenge_offendercomlinkkillcount == 2) {
    self addplayerstat("kill_2_attackers_with_comlink", 1);
  }
  if(self.challenge_objectiveoffensivekillcount > 4) {
    self addplayerstatwithgametype("multikill_5_attackers", 1);
    self.challenge_objectiveoffensivekillcount = 0;
  }
  if(self.challenge_offendersentryturretkillcount > 2) {
    self addplayerstat("multikill_3_attackers_ai_tank", 1);
    self.challenge_offendersentryturretkillcount = 0;
  }
  self util::player_contract_event("offender_kill");
  self waittilltimeoutordeath(4);
  if(self.challenge_offenderkillcount > 1) {
    self addplayerstat("double_kill_attackers", 1);
  }
  self.challenge_offenderkillcount = 0;
  if(self.challenge_offenderprojectilemultikillcount >= 2) {
    self addplayerstat("multikill_2_objective_scorestreak_projectile", 1);
  }
  self.challenge_offenderprojectilemultikillcount = 0;
}

function killedbasedefender(objective) {
  self endon("disconnect");
  self addplayerstatwithgametype("offends", 1);
  if(!isDefined(self.challenge_objectivedefensive) || self.challenge_objectivedefensive != objective) {
    self.challenge_objectivedefensivekillcount = 0;
  }
  self.challenge_objectivedefensivekillcount++;
  self.challenge_objectivedefensive = objective;
  self.challenge_defenderkillcount++;
  self util::player_contract_event("defender_kill");
  self waittilltimeoutordeath(4);
  if(self.challenge_defenderkillcount > 1) {
    self addplayerstat("double_kill_defenders", 1);
  }
  self.challenge_defenderkillcount = 0;
}

function waittilltimeoutordeath(timeout) {
  self endon("death");
  wait(timeout);
}

function killstreak_30_noscorestreaks() {
  if(level.gametype == "dm") {
    self addplayerstat("killstreak_30_no_scorestreaks", 1);
  }
}

function heroabilityactivateneardeath() {
  if(isDefined(self.heroability) && self.pers["canSetSpecialistStat"]) {
    switch (self.heroability.name) {
      case "gadget_armor":
      case "gadget_camo":
      case "gadget_clone":
      case "gadget_flashback":
      case "gadget_heat_wave":
      case "gadget_speed_burst":
      case "gadget_vision_pulse": {
        self thread checkforherosurvival();
        break;
      }
    }
  }
}

function checkforherosurvival() {
  self endon("death");
  self endon("disconnect");
  self util::waittill_any_timeout(8, "challenge_survived_from_death", "disconnect");
  self addplayerstat("death_dodger", 1);
}

function callbackendherospecialistemp() {
  empowner = self emp::enemyempowner();
  if(isDefined(empowner) && isplayer(empowner)) {
    empowner addplayerstat("end_enemy_specialist_ability_with_emp", 1);
    return;
  }
  if(isDefined(self.empstarttime) && self.empstarttime > (gettime() - 100)) {
    if(isDefined(self.empedby) && isplayer(self.empedby)) {
      self.empedby addplayerstat("end_enemy_specialist_ability_with_emp", 1);
      return;
    }
  }
}

function calledincomlinkchopper() {
  self.challenge_offendercomlinkkillcount = 0;
}

function combat_robot_damage(eattacker, combatrobotowner) {
  if(!isDefined(eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid])) {
    eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid] = spawnStruct();
  }
}

function trackkillstreaksupportkills(victim) {
  if(level.activeplayeremps[self.entnum] > 0) {
    self addweaponstat(getweapon("emp"), "kills_while_active", 1);
  }
  if(level.activeplayeruavs[self.entnum] > 0 && (!isDefined(level.forceradar) || level.forceradar == 0)) {
    self addweaponstat(getweapon("uav"), "kills_while_active", 1);
  }
  if(level.activeplayersatellites[self.entnum] > 0) {
    self addweaponstat(getweapon("satellite"), "kills_while_active", 1);
  }
  if(level.activeplayercounteruavs[self.entnum] > 0) {
    self addweaponstat(getweapon("counteruav"), "kills_while_active", 1);
  }
  if(isDefined(victim.lastmicrowavedby) && victim.lastmicrowavedby == self) {
    self addweaponstat(getweapon("microwave_turret"), "kills_while_active", 1);
  }
}

function monitorreloads() {
  self endon("disconnect");
  self endon("killmonitorreloads");
  while(true) {
    self waittill("reload");
    currentweapon = self getcurrentweapon();
    if(currentweapon == level.weaponnone) {
      continue;
    }
    time = gettime();
    self.lastreloadtime = time;
    if(weaponhasattachment(currentweapon, "fastreload")) {
      self.lastfastreloadtime = time;
    }
  }
}

function monitorgrenadefire() {
  self notify("grenadetrackingstart");
  self endon("grenadetrackingstart");
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon);
    if(!isDefined(grenade)) {
      continue;
    }
    if(weapon.rootweapon.name == "hatchet") {
      self.challenge_hatchettosscount++;
      grenade.challenge_hatchettosscount = self.challenge_hatchettosscount;
    }
    if(self issprinting()) {
      grenade.ownerwassprinting = 1;
    }
  }
}

function watchweaponchangecomplete() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  while(true) {
    self.heroweaponkillsthisactivation = 0;
    self waittill("weapon_change_complete");
  }
}

function longdistancekillmp(weapon) {
  self addweaponstat(weapon, "longshot_kill", 1);
  if(self weaponhasattachmentandunlocked(weapon, "extbarrel", "suppressed")) {
    if(self getweaponoptic(weapon) != "") {
      self addplayerstat("long_shot_longbarrel_suppressor_optic", 1);
    }
  }
}

function capturedobjectivefunction() {
  if(self isbonuscardactive(9, self.class_num) && self util::is_item_purchased("bonuscard_two_tacticals")) {
    self addplayerstat("capture_objective_tactician", 1);
  }
}

function watchwallruntwooppositewallsnoground() {
  player = self;
  player endon("death");
  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");
  self.wallrantwooppositewallsnoground = 0;
  while(true) {
    if(!player iswallrunning()) {
      self.wallrantwooppositewallsnoground = 0;
      player waittill("wallrun_begin");
    }
    ret = player util::waittill_any_return("jump_begin", "wallrun_end", "disconnect", "joined_team", "joined_spectators");
    if(ret == "wallrun_end") {
      continue;
    }
    wall_normal = player getwallrunwallnormal();
    player waittill("jump_end");
    if(!player iswallrunning()) {
      continue;
    }
    last_wall_normal = wall_normal;
    wall_normal = player getwallrunwallnormal();
    opposite_walls = vectordot(wall_normal, last_wall_normal) < -0.5;
    if(!opposite_walls) {
      continue;
    }
    player.wallrantwooppositewallsnoground = 1;
    while(player iswallrunning()) {
      ret = player util::waittill_any_return("jump_end", "wallrun_end", "disconnect", "joined_team", "joined_spectators");
      if(ret == "wallrun_end") {
        break;
      }
    }
    wait(0.05);
    while(!player isonground()) {
      wait(0.05);
    }
  }
}

function processspecialistchallenge(statname) {
  if(self.pers["canSetSpecialistStat"]) {
    self addspecialiststat(statname, 1);
  }
}

function flakjacketprotectedmp(weapon, attacker) {
  if(weapon.name == "claymore") {
    self.flakjacketclaymore[attacker.clientid] = 1;
  }
  self addplayerstat("survive_with_flak", 1);
  self.challenge_lastsurvivewithflakfrom = attacker;
  self.challenge_lastsurvivewithflaktime = gettime();
}