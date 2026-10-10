/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_f820c96419fe887.gsc
************************************************/

#using script_294dda4a4b00ffe3;
#using script_5bab271917698dc4;
#using script_f820c96419fe887;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\deathicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment\concussion_grenade;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_armor;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametype_zxp;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\playerlogic;
#using scripts\mp\supers\super_deadsilence;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_7d6064c7725fad70;

function init() {
  if(!getdvarint(@ "hash_58125dd5024d18ca", 0)) {
    return;
  }

  level.var_14cc24a75e8cd64d = &function_14cc24a75e8cd64d;
  level.brgametype.var_ad12a63c860848af = 1;
  level.brgametype.zombierespawning = 1;
  level.brgametype.zombieloadout = createzombieloadout();
  level.brgametype.zombiehealth = getdvarint(@ "hash_457a291554d55361", 350);
  level.brgametype.zombiesdamagezombies = getdvarint(@ "hash_7d04136e229c6d7a", 0);
  level.brgametype.var_8faaf289e5d10151 = getdvarint(@ "hash_8584a72dd6afa977", 80);
  level.brgametype.zombiesignorevehicleexplosions = getdvarint(@ "hash_9e8f30b569e2abe5", 1);
  level.brgametype.var_8eb8826347f1258 = getdvarint(@ "hash_3ad2f81e6e6cf99c", 1);
  level.brgametype.zombiepingrate = getdvarfloat(@ "hash_4dab1aaf5c7733be", -1);
  level.brgametype.zombiepingtime = getdvarfloat(@ "hash_35b72e2558f0a7cd", 0.5);
  level.brgametype.zombienumtoconsume = getdvarint(@ "hash_1322659ceb016a98", 4);
  level.brgametype.zombieregenratescaleingas = getdvarfloat(@ "hash_732dbd6ba0b0f252", 2);
  level.brgametype.zombieregenratescaleoutgas = getdvarfloat(@ "hash_dd936bdb4cf1f2ef", 0.7);
  level.brgametype.zombieregendelayscaleingas = getdvarfloat(@ "hash_c186667e8cb3bc6b", 1);
  level.brgametype.zombieregendelayscaleoutgas = getdvarfloat(@ "hash_b0687a8f2794f3b8", 1.5);
  level.brgametype.zombiepowersenabled = getdvarint(@ "hash_b760176b090452c1", 1);
  level.brgametype.powerscooldown = getdvarint(@ "hash_2546d85e9d039f6b", 1);
  level.brgametype.zombienumhitshuman = getdvarfloat(@ "hash_a08fd1aad589d41b", 3);
  level.brgametype.var_df9ba21d322f48a0 = getdvarint(@ "hash_6931def073d51e8c", 1);
  level.brgametype.zombienumhitsheli = getdvarfloat(@ "hash_8d24cf268d991c83", 2);
  level.brgametype.zombienumhitsatv = getdvarfloat(@ "hash_afb1f56ac422f668", 2);
  level.brgametype.zombienumhitscar = getdvarfloat(@ "hash_9162a16aad712f5b", 3);
  level.brgametype.zombienumhitstruck = getdvarfloat(@ "hash_5552790671b23f3e", 4);
  level.brgametype.zombiespawninair = getdvarint(@ "hash_9c4658bfbe5e2b39", 1);
  level.brgametype.zombievehiclelaststand = getdvarint(@ "hash_46634a326aa6bc5e", 0);
  level.brgametype.zombiespawnabovedeath = getdvarint(@ "hash_b2ccefcd02e5660f", 0);
  level.brgametype.humanspawninair = getdvarint(@ "hash_9ec879d1dafa798b", 1);
  level.brgametype.var_863f6d0e1a1c01e9 = getdvarint(@ "hash_1ee25065b4a3191c", 1);
  level.brgametype.hudserver = getdvarint(@ "hash_b5ac32636b6ff882", 0);
  level.brgametype.var_854edaec88caf865 = getdvarint(@ "hash_21fbbc29b9fecac8", 20);
  level.brgametype.var_854ed7ec88caf1cc = getdvarint(@ "hash_31d8c8e967f4f20f", 30);
  level.brgametype.zombievision = getdvarint(@ "hash_41594fbb80d9883e", 1);
  level.brgametype.var_63d9be743a6ba8cd = getdvarint(@ "hash_fdb01d1a58dcdcb1", 1);
  level.brgametype.var_f08bfc048423d1dc = getdvarint(@ "hash_8c5546e4f573664", 0);
  level.brgametype.var_68dfc0a151952869 = getdvarfloat(@ "hash_340b7eb839056345", 0.65);
  level.brgametype.var_9dd997ced889b541 = getdvarint(@ "hash_a34f4bb4586ca7a6", 1);
  level.brgametype.var_888a368fc494c603 = getdvarint(@ "hash_77b0c9b7f8217be6", 1);
  level.brgametype.var_b8456bbdf46925a3 = getdvarint(@ "hash_4903cbd81395da65", 0);
  level.brgametype.var_fe1ed6b37a8d2bba = getdvarint(@ "hash_ef3cf14423ea0971", 1);
  level.brgametype.var_52d26462081a2d41 = getdvarfloat(@ "hash_6db0c7f59c294cb4", 1);
  level.brgametype.var_5a945be17bf844bd = getdvarfloat(@ "hash_6715c45dd1cda5bf", 10);
  level.brgametype.var_89b7489c115dc08a = getdvarfloat(@ "hash_89b508dfec9fb80a", 15);
  level.brgametype.var_695b3601560f5703 = getdvarfloat(@ "hash_f2bce8bff1023a79", 1.2);
  level.brgametype.var_6225ce8e059e5ce5 = getdvarfloat(@ "hash_3a436a2eb1bd593", 2);
  level.brgametype.var_7f417534e5c75f9 = getdvarfloat(@ "hash_3382204607436afe", 0.75);
  level.brgametype.var_ca0a3ce7573e0780 = getdvarfloat(@ "hash_add73918ea9fcaf8", 0.2);
  level.brgametype.var_2d23e5b9abed638c = getdvarfloat(@ "hash_c63870e71431980a", 1.2);
  level.brgametype.var_5ba111ae6c83effe = getdvarint(@ "hash_345c19750d32d4a7", 0);
  level.brgametype.var_dbb3b2958af5562b = getdvarfloat(@ "hash_3489d22533419d85", 1);
  level.shownonspectatingwinnersplash = 1;
  level._effect["zombie_trans"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_transition_to_human.vfx");
  level._effect["zombie_splat"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_freefall_splat.vfx");
  level._effect["zombie_buffed"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout_buffed.vfx");
  level._effect["zombie_shout"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout.vfx");
  level._effect["zombie_shout_shockwaves"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout_shockwaves.vfx");
  level.brgametype.impulsefx = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_human_push_blast");
  utility::registersharedfunc("airdrop", "specialCase_canUseCrate", &function_aa5af609f16f8351);
  thread initpostmain();
}

function initpostmain() {
  waittillframeend();
  thread setupzombiepowers();

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    thread function_e4cffb22a28408e2();
  }

  if(!threatbiasgroupexists("player_zombie")) {
    createthreatbiasgroup("player_zombie");
  }

  level.swim.var_b6064226993b9c1d = &function_81e6ecfd4df39002;

  if(isDefined(level.var_678d42aa0c5f90ef)) {
    level.brgametype.zombievisionset = getDvar(@ "hash_23bfd5f2a84eb6d8", level.var_678d42aa0c5f90ef);
    return;
  }

  level.brgametype.zombievisionset = getDvar(@ "hash_23bfd5f2a84eb6d8", "mp_zmb_pm");
}

function playerspawn() {
  player = self;

  if(!isDefined(player.hudzombie)) {
    player playerzombiesetuphud();
  }

  wait 0.5;
  player function_10ffa1071b1c2681();
  wait 2;
  player playerzombierespawn(0);
}

function modifyplayerdamage(data) {
  idamage = data.damage;
  var_7bfcad6985f865ac = isPlayer(data.attacker) && data.attacker playeriszombie();
  var_eb938d26f29141aa = isDefined(data.attacker) && data.attacker entisvehicle();
  var_8d6deeb9c425ce1b = isPlayer(data.victim) && data.victim playeriszombie();
  weaponbasename = scripts\mp\utility\weapon::getweaponbasenamescript(data.objweapon);

  if(var_7bfcad6985f865ac && var_8d6deeb9c425ce1b && data.meansofdeath == "MOD_MELEE") {
    idamage = level.brgametype.var_8faaf289e5d10151;
  } else if(var_7bfcad6985f865ac && !var_8d6deeb9c425ce1b && !data.attacker isinexecutionattack() && data.victim isinexecutionvictim()) {
    idamage = 0;
  } else if(var_8d6deeb9c425ce1b && isDefined(data.inflictor) && isDefined(data.inflictor.streakinfo) && (data.inflictor.streakinfo.streakname == "toma_strike" || data.inflictor.streakinfo.streakname == "precision_airstrike" || data.inflictor.streakinfo.streakname == "manual_turret")) {
    var_6b3343960b7f7865 = data.victim.maxhealth;
    var_5dfc4383cde705a4 = data.attacker.maxhealth;
    idamage = data.damage * int(floor(var_6b3343960b7f7865 / var_5dfc4383cde705a4));
  } else if(level.brgametype.zombiesignorevehicleexplosions && var_8d6deeb9c425ce1b && isexplosivedamagemod(data.meansofdeath) && isDefined(data.inflictor) && data.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    idamage = 0;
  } else if(var_8d6deeb9c425ce1b && (data.meansofdeath == "MOD_GRENADE_SPLASH" || data.meansofdeath == "MOD_EXPLOSIVE")) {
    idamage = data.damage * getdvarfloat(@ "hash_bf750007ea105d69", 3);
  } else if(var_7bfcad6985f865ac && !var_8d6deeb9c425ce1b && data.meansofdeath == "MOD_MELEE") {
    maxhealth = data.victim.maxhealth;
    var_676a5fd0436c01a9 = level.brgametype.zombienumhitshuman;

    if(!level.brgametype.var_df9ba21d322f48a0) {
      maxhealth += data.victim.br_maxarmorhealth;
    }

    idamage = int(ceil(maxhealth / var_676a5fd0436c01a9));
  } else if(var_8d6deeb9c425ce1b && var_eb938d26f29141aa && istrue(data.victim.vehicledamageimmunity)) {
    idamage = 0;
  } else if(var_7bfcad6985f865ac && !var_8d6deeb9c425ce1b && data.meansofdeath == "MOD_IMPACT" && weaponbasename == "rock_mp") {
    inflictor = spawnStruct();
    inflictor.origin = data.point;
    data.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, data.attacker);
  } else if(var_8d6deeb9c425ce1b) {
    var_e88b8a44100e399f = 0.7;
    weaponrootname = scripts\cp_mp\weapon::getweaponrootname(data.objweapon);
    weapontype = weaponclass(weaponbasename);
    var_1646fe11681a5388 = scripts\cp_mp\armor::isbulletpenetration(data.idflags);

    if(!var_1646fe11681a5388) {
      switch (weapontype) {
        case #"hash_6191aaef9f922f96":
          if(data.shitloc == "head" || data.shitloc == "helmet") {
            if(scripts\mp\gametypes\br::issnipersemi(weaponrootname)) {
              idamage = int(ceil(level.brgametype.zombiehealth * var_e88b8a44100e399f));
            } else {
              idamage = level.brgametype.zombiehealth;
            }
          }

          break;
        default:
          if(data.shitloc == "head" || data.shitloc == "helmet") {
            playermaxhealth = getdvarfloat(@ "scr_player_maxhealth", 100);
            var_4d995b1dd54eb1ac = playermaxhealth;

            if(level.brgametype.var_f08bfc048423d1dc) {
              var_4d995b1dd54eb1ac += 0;
            }

            idamage = int(ceil(idamage / var_4d995b1dd54eb1ac * level.brgametype.zombiehealth * level.brgametype.var_68dfc0a151952869));
          }

          break;
      }
    }

    var_ca4a38b357937057 = hashcat(@ "hash_199e1d44104c7cb8", weapontype);
    defaultsetting = 0;

    if(weapontype == "spread") {
      defaultsetting = 0.7;
    }

    var_fcc299892a3b968d = getdvarfloat(var_ca4a38b357937057, defaultsetting);

    if(var_fcc299892a3b968d != 0) {
      idamage = int(ceil(idamage * var_fcc299892a3b968d));
    }

    var_6721e451f9be96aa = hashcat(@ "hash_199e1d44104c7cb8", weaponrootname);
    defaultsetting = 0;

    if(weaponrootname == "iw8_sh_charlie725") {
      defaultsetting = 1.43;
    }

    var_745e6e594dcfbdbe = getdvarfloat(var_6721e451f9be96aa, defaultsetting);

    if(var_745e6e594dcfbdbe != 0) {
      idamage = int(ceil(idamage * var_745e6e594dcfbdbe));
    }
  }

  if(var_8d6deeb9c425ce1b && istrue(data.victim.buffed)) {
    idamage = int(float(idamage) * level.brgametype.var_7f417534e5c75f9);
  }

  return idamage;
}

function entisvehicle() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle";
}

function modifyvehicledamage(data) {
  idamage = data.damage;
  vehicle = data.victim;
  attacker = ter_op(isDefined(data.attacker), data.attacker, data.inflictor);
  var_e67a363cb760be2f = 0;

  if(isDefined(attacker)) {
    if(isPlayer(attacker) && attacker playeriszombie()) {
      var_e67a363cb760be2f = data.meansofdeath == "MOD_MELEE";
    } else if(isagent(attacker) && istrue(attacker.zombie)) {
      var_e67a363cb760be2f = data.meansofdeath == "MOD_IMPACT";
    }
  }

  vehicletype = vehicle.vehiclename;

  if(var_e67a363cb760be2f) {
    switch (vehicletype) {
      case #"hash_c93466c10cc10ba":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitsatv;
        break;
      case #"hash_a16995fca8ca9c5":
      case #"hash_21e1eaa9138f512c":
      case #"hash_228830c793bd36cb":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitscar;
        break;
      case #"hash_6e693d48c24e303b":
      case #"hash_9386dbfe3d8d881c":
      case #"hash_f690b9139a2baa7e":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitstruck;
        break;
      case #"hash_9d4e22a00fc630b5":
      case #"hash_fc4bff8ee315386a":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitsheli;
        break;
      default:
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitstruck;
        break;
    }

    idamage = int(ceil(idamage));
  }

  return idamage;
}

function mayconsiderplayerdead(player, var_887d9bc9cbad47f1) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return true;
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {}

  result = player function_afa8b73eb004c380(var_887d9bc9cbad47f1);

  if(result) {
    player.respawningfromtoken = 1;
  } else if(playeriszombie()) {
    thread playerdelaydisablezombie();
  }

  return !result;
}

function spawnhandled(player) {
  if(istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done") && player playeriszombie()) {
    player namespace_27c39fecb94c2a6d::playerreadytospawn();
    return true;
  }

  return false;
}

function markplayeraseliminatedonkilled() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  return !istrue(self.respawningfromtoken);
}

function function_afa8b73eb004c380(var_887d9bc9cbad47f1) {
  if(!istrue(var_887d9bc9cbad47f1)) {
    if(playeriszombie()) {
      return false;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.brgametype.zombierespawning) {
    return false;
  }

  return true;
}

function playertryzombiespawn(var_887d9bc9cbad47f1) {
  if(!istrue(var_887d9bc9cbad47f1)) {
    if(playeriszombie()) {
      thread playerdelaydisablezombie();
      return false;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.brgametype.zombierespawning) {
    return false;
  }

  thread playerzombierespawn(0);
  return true;
}

function playerkilledspawn(deathdata, finaldeath) {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(level.gameended) {
    return true;
  }

  if(istrue(self.respawningbr)) {
    return true;
  }

  if(istrue(self.respawningfromtoken) && !playeriszombie()) {
    self.respawningfromtoken = undefined;
    thread playerzombierespawn(0);
  } else if(!scripts\mp\utility\damage::playershoulddofauxdeath(0)) {
    deathdata.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(deathdata, finaldeath);
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("zombieDialog_tryLastHumanAlive")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("zombieDialog_tryLastHumanAlive", self);
  }

  return true;
}

function playerdelaydisablezombie() {
  self endon("disconnect");
  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);

  if(level.brgametype.zombievision) {
    function_234906f719267cd4();

    if(!level.brgametype.var_63d9be743a6ba8cd) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    self.var_54e863ebad3e233 = undefined;
    scripts\mp\utility\player::restorebasevisionset(0);
  }

  waittillframeend();
  playersetiszombie(0, 1);
  function_fd7bdffe7cea51ed(0);
}

function function_234906f719267cd4() {
  foreach(player in level.players) {
    player hudoutlinedisableforclient(self);
  }
}

function playersetiszombie(value, var_5fd0c9cf6d0e1d68) {
  self.iszombie = value;
  playersetiszombieextrainfo(value);

  if(value) {
    self notify("zombie_set");
    level notify("zombie_set", self);

    if(level.brgametype.hudserver) {
      playerzombiesetuphud();
    }

    self.numconsumed = 0;
    self.bcdisabled = 1;
    self.var_f8e21465665e3f81 = 1;
    playersetisbecomingzombie(0);
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(7);
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(9);
    function_936f0ef6e203a7fc("numVaccine", self.numconsumed);

    if(threatbiasgroupexists("player_zombie")) {
      self setthreatbiasgroup("player_zombie");
    }
  } else {
    self notify("zombie_unset");
    level notify("zombie_unset", self);
    self.numconsumed = undefined;
    self.bcdisabled = undefined;
    self.var_f8e21465665e3f81 = undefined;
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(7);

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      scripts\mp\gametypes\br_public::updatebrscoreboardstat("numVaccine", 0);
    }

    self setthreatbiasgroup();
  }

  level notify("players_remaining_changed");
  self setclientomnvar("ui_br_inventory_disabled", value);
  self notify("stop_battlechatter");

  if(istrue(var_5fd0c9cf6d0e1d68)) {
    self lerpfovbypreset("default");

    if(level.brgametype.var_63d9be743a6ba8cd) {
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
    }
  }

  foreach(teammember in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(isDefined(teammember)) {
      teammember notify("refresh_revives");
    }
  }
}

function createzombieloadout() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_me_fists_mp";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

function function_330f2255da6b470(var_92a1c0c07f53993d, dummy1) {
  teamlist = getarraykeys(level.teamdata);

  foreach(team in teamlist) {
    players = level.teamdata[team]["players"];

    foreach(player in players) {
      if(player playeriszombie()) {
        if(level.brgametype.hudserver) {
          player namespace_27c39fecb94c2a6d::playerzombiedestroyhud();
        }

        player namespace_27c39fecb94c2a6d::playerpowerscleanuphud();
        continue;
      }

      player namespace_27c39fecb94c2a6d::playerpowerscleanuphud();
    }
  }
}

function isvalidspectatetarget(player) {
  if(!isDefined(player)) {
    return 0;
  }

  if(!isalive(player) && !istrue(player.respawningfromtoken) && !player playeriszombie()) {
    return 0;
  }

  isvalid = !istrue(player.br_iseliminated) || player playeriszombie();
  return isvalid;
}

function cantakepickuploot(pickup) {
  if(pickup.scriptablename == "brloot_zmb_stim") {
    if(self.numconsumed >= level.brgametype.zombienumtoconsume) {
      return 12;
    }

    return 1;
  }

  return undefined;
}

function function_14cc24a75e8cd64d(pickup) {
  if(pickup.scriptablename == "brloot_zmb_stim") {
    pickup.instance onuse(self);
  }
}

function playerzombiesetuphud() {
  var_5f243323af462b6a = -60;
  var_5522365ea860860b = 120;
  var_748f3ddc7533d2a9 = 180;
  self.hudnumconsumed = playercreatehudelement(var_5f243323af462b6a, var_5522365ea860860b, "right", "middle", "center", "middle", &"MP_ZXP/NUM_CONSUMED", 0);
  self.hudnumtoconsume = playercreatehudelement(var_5f243323af462b6a, var_5522365ea860860b, "left", "middle", "center", "middle", &"MP_ZXP/NUM_TO_CONSUME", level.brgametype.zombienumtoconsume);
  self.hudzombie = playercreatehudelement(0, var_748f3ddc7533d2a9, "center", "middle", "center", "middle", &"MP_ZXP/ZOMBIE");
}

function playercreatehudelement(xoffset, yoffset, alignx, aligny, horzalign, vertalign, label, value) {
  hudelem = createfontstring("default", 1.5);
  hudelem.x = xoffset;
  hudelem.y = yoffset;
  hudelem.alignx = alignx;
  hudelem.aligny = aligny;
  hudelem.horzalign = horzalign;
  hudelem.vertalign = vertalign;
  hudelem.alpha = 0;
  hudelem.glowalpha = 0;
  hudelem.hidewheninmenu = 1;
  hudelem.archived = 0;

  if(isDefined(label)) {
    hudelem.label = label;
  }

  if(isDefined(value)) {
    hudelem setvalue(value);
  }

  return hudelem;
}

function playersetiszombieextrainfo(value) {
  if(istrue(value)) {
    self.game_extrainfo |= 16384;
    return;
  }

  self.game_extrainfo &= ~16384;
}

function playerzombierespawn(var_fd96c3c1ec7b2988, var_babf157dec7ecb90) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("zombie_unset");

  if(level.gameended) {
    return;
  }

  if(!isDefined(level.teamdata[self.team]["lastZombieTime"]) && !isDefined(level.var_42d67d7e9f82f50b)) {
    scripts\mp\gametypes\br_public::brleaderdialogteam("zmb_need_someone_alive", self.team);
  }

  setteamlastzombietime(self.team);
  playersetisbecomingzombie(1);
  playerzombiestatechange(1);
  waittillframeend();

  if(isDefined(level.brgametype.var_5fc0811cb9626ef0) && level.brgametype.var_5fc0811cb9626ef0 && !function_6ece6988ecaf0ea7()) {
    function_10ffa1071b1c2681();
  }

  playersetiszombie(1);

  if(istrue(var_babf157dec7ecb90)) {
    scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(self, "outbreak");
  } else {
    self.respawningbr = 1;
  }

  if(isDefined(level.var_42d67d7e9f82f50b)) {
    playerreadytospawn();
  } else if(var_fd96c3c1ec7b2988) {
    playerwaittospawn();
  } else {
    playerreadytospawn();
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("playerGetZombieSpawnLocation")) {
    [spawnorigin, spawnangles] = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerGetZombieSpawnLocation");
  } else {
    [spawnorigin, spawnangles] = playergetzombiespawnlocation();
  }

  [spawnorigin, streamorigin] = playerzombieprestream(spawnorigin, spawnangles);
  namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
  wait 1;
  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.brgametype.zombieloadout;
  self.class = "gamemode";
  self.forcespawnangles = spawnangles;
  self.forcespawnorigin = streamorigin;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer(1);
  scripts\mp\gametypes\br_spectate::playerclearspectatekillchainsystem();
  self notify("endSuperJumpFov");
  fistsweapon = makeweapon("iw9_me_fists_mp");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(fistsweapon);
  var_e3438b8cb9c2c515 = makeweapon("iw9_me_fists_mp_zmb");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_e3438b8cb9c2c515, undefined, undefined, 1);
  self detachall();
  self setModel("fullbody_zombie_a_br");
  self setviewmodel("vm_arms_zombie_a");
  _setsuit("iw9_zombie_mp");

  if(level.brgametype.var_fe1ed6b37a8d2bba) {
    scripts\cp_mp\execution::_giveexecution("execution_345");
  } else {
    scripts\cp_mp\execution::_clearexecution();
  }

  var_f053fd568237d1f2 = self function_efed183e552b0625();

  if(isDefined(var_f053fd568237d1f2)) {
    self function_ecdccfda4326de02();
  }

  playerstreamwaittillcomplete(spawnorigin, spawnangles, streamorigin);
  self skydive_interrupt();
  self.ffsm_state = 5;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  self skydive_beginfreefall();
  childthread playerweaponswitch(var_e3438b8cb9c2c515);
  function_fd7bdffe7cea51ed(1);
  thread playerzombiehitground(var_e3438b8cb9c2c515, 0);
  thread scripts\mp\gametypes\br::br_displayperkinfo();
  thread playerzombiesupersprint();

  if(level.brgametype.var_8eb8826347f1258) {
    thread playerzombiesetradar();
  }

  thread playerzombiegasthink();
  self disableexecutionvictim();
  scripts\mp\utility\perk::giveperk("specialty_tracker");
  scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
  scripts\mp\utility\perk::giveperk("specialty_sprintads");
  scripts\common\values::set("zombie", "vehicle_use", !self.iszombie);
  self lerpfovbypreset("zombiedefault");

  if(level.brgametype.var_63d9be743a6ba8cd) {
    self setclientomnvar("ui_deadsilence_overlay", 0);
  }

  thread playerzombiedelayturnonfx();
  self setscriptablepartstate("compassicon", "zombie");

  if(getdvarint(@ "hash_4171e2bc0238543", 0)) {
    self forcenetfieldhighlod(1);
  }

  if(isDefined(level.var_42d67d7e9f82f50b)) {
    scripts\mp\hud_message::showsplash("br_reveal_stop_exfil");
  } else {
    scripts\mp\hud_message::showsplash("br_gametype_zxp_change_zombie", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zxp");
  }

  if(!scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
  }

  self.maxhealth = level.brgametype.zombiehealth;
  self.health = self.maxhealth;
  scripts\cp_mp\armor::givestartingarmor(0, 0, 0);
  scripts\mp\gametypes\br_armor::givearmorvalue(0);
  self.respawningbr = undefined;
  self.var_5166e5e6229b88ee = undefined;
  wait 3;

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("zombieDialog_respawnAsZombie")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("zombieDialog_respawnAsZombie", self);
  }

  if(namespace_c711384b1335919::function_4ad287e0971672a6()) {
    var_c492f22d5c11b367 = namespace_c711384b1335919::function_c6b950c21813b5cd();
    dlog_recordevent("dlog_event_zxp_player_zombie_respawn", ["infestation_index", var_c492f22d5c11b367]);
  }
}

function playerregenhealthadd(healthadd) {
  if(playeriszombie()) {
    if(istrue(self.zombieingas)) {
      return int(level.brgametype.zombieregenratescaleingas * healthadd);
    } else {
      return int(level.brgametype.zombieregenratescaleoutgas * healthadd);
    }
  }

  return undefined;
}

function function_fd7bdffe7cea51ed(iszombie) {
  if(!istrue(level.brgametype.var_9dd997ced889b541)) {
    function_179a8d5a185dfb56(iszombie);
  }

  if(iszombie) {
    if(level.brgametype.hudserver) {
      self.hudnumconsumed.alpha = 1;
      self.hudnumtoconsume.alpha = 1;
      self.hudzombie.alpha = 1;
    }

    self disableweaponpickup();
  } else {
    playerzombiedestroyhud();
    self enableweaponpickup();
  }

  scripts\common\swim_common::function_9368fff2b3156346(iszombie);
}

function setteamlastzombietime(team) {
  level.teamdata[team]["lastZombieTime"] = gettime();
}

function playersetisbecomingzombie(value) {
  self.isbecomingzombie = value;
}

function playerzombiestatechange(var_e2c92ccede3b063e) {
  team = self.team;
  scripts\mp\utility\teams::validatealivecount("mode", team, self);
  playerupdatealivecounthuman();

  if(istrue(var_e2c92ccede3b063e)) {
    [[level.updategameevents]]();
  }
}

function playerzombiedestroyhud() {
  if(isDefined(self.hudnumconsumed)) {
    thread delaydestroyhudelem(self.hudnumconsumed, 1.5);
  }

  if(isDefined(self.hudnumtoconsume)) {
    thread delaydestroyhudelem(self.hudnumtoconsume, 1.5);
  }

  if(isDefined(self.hudzombie)) {
    self.hudzombie destroy();
  }

  self.hudnumconsumed = undefined;
  self.hudnumtoconsume = undefined;
  self.hudzombie = undefined;
}

function delaydestroyhudelem(hudelem, delaytime) {
  wait delaytime;

  if(isDefined(hudelem)) {
    hudelem destroy();
  }
}

function function_6ece6988ecaf0ea7() {
  return isDefined(self.var_45f93a3ba26bd0b7);
}

function playerregendelayspeed(delayspeed) {
  if(playeriszombie()) {
    if(istrue(self.zombieingas)) {
      return (1 / level.brgametype.zombieregendelayscaleingas * delayspeed);
    } else {
      return (1 / level.brgametype.zombieregendelayscaleoutgas * delayspeed);
    }
  }

  return undefined;
}

function onuse(player) {
  thread function_dc5e885eda9f918e(player);
}

function function_dc5e885eda9f918e(player) {
  if(!isDefined(player)) {
    thread scripts\mp\gametypes\br_gametype_zxp::function_3bbc840fb244d188(self);
    return;
  }

  if(!function_7ffb58b4ceffae1b(player)) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  thread scripts\mp\gametypes\br_gametype_zxp::function_3bbc840fb244d188(self, undefined, player);

  if(player.numconsumed >= level.brgametype.zombienumtoconsume) {
    return;
  }

  player.numconsumed++;

  if(level.brgametype.hudserver) {
    player playerhudupdatenumconsumed();
  }

  player namespace_27c39fecb94c2a6d::function_936f0ef6e203a7fc("numVaccine", player.numconsumed);

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("zombieDialog_lootSyringe")) {
    thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("zombieDialog_lootSyringe", player);
  }

  if(player.numconsumed >= level.brgametype.zombienumtoconsume) {
    player.var_5166e5e6229b88ee = 1;
    player thread scripts\mp\gametypes\br_gametype_zxp::playerzombiebacktohuman();
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("numVaccine", level.brgametype.zombienumtoconsume);
    dlog_recordevent("dlog_event_zxp_syringe_use", []);
    return;
  }

  player scripts\mp\gametypes\br_public::updatebrscoreboardstat("numVaccine", int(player.numconsumed));
}

function function_7ffb58b4ceffae1b(player) {
  return player playeriszombie();
}

function function_aa5af609f16f8351() {
  return !playeriszombie();
}

function playerhudupdatenumconsumed() {
  var_6bdb7efe3af494ba = (0, 1, 0);
  self.hudnumconsumed setvalue(self.numconsumed);
  self.hudnumconsumed thread huddopulse(var_6bdb7efe3af494ba);
  self.hudnumtoconsume thread huddopulse(var_6bdb7efe3af494ba);
}

function huddopulse(var_a1c90d2e290c03fd) {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }

  var_cc2c2f3eac3c7bd2 = 0.5;
  var_5f2809f4e8852c13 = 4;
  self.pulsing = 1;
  originalscale = self.fontscale;
  var_672265c8e01995a1 = self.color;

  if(isDefined(var_a1c90d2e290c03fd)) {
    self.color = var_a1c90d2e290c03fd;
  }

  self changefontscaleovertime(var_cc2c2f3eac3c7bd2);
  self.fontscale = var_5f2809f4e8852c13;
  wait var_cc2c2f3eac3c7bd2;
  self changefontscaleovertime(var_cc2c2f3eac3c7bd2);
  self.fontscale = originalscale;
  wait var_cc2c2f3eac3c7bd2;
  self.color = var_672265c8e01995a1;
  self.pulsing = undefined;
}

function function_10ffa1071b1c2681() {
  var_45f93a3ba26bd0b7 = spawnStruct();
  var_45f93a3ba26bd0b7.current = self getcurrentprimaryweapon();
  var_45f93a3ba26bd0b7.primaries = [];
  var_45f93a3ba26bd0b7.ammoclip = [];
  var_45f93a3ba26bd0b7.ammoclipleft = [];
  var_45f93a3ba26bd0b7.ammostock = [];
  var_45f93a3ba26bd0b7.offhands = [];
  var_45f93a3ba26bd0b7.equipslots = [];
  savedprimaries = [];
  allprimaries = self getweaponslistprimaries();

  foreach(primary in allprimaries) {
    if(!scripts\mp\utility\weapon::ismeleeoverrideweapon(primary) && !issubstr(primary.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::isgunlessweapon(primary.basename)) {
      savedprimaries[savedprimaries.size] = primary;
    }
  }

  foreach(weaponobj in savedprimaries) {
    weaponname = getcompleteweaponname(weaponobj);
    var_45f93a3ba26bd0b7.ammoclip[weaponname] = weaponclipsize(weaponobj);
    var_45f93a3ba26bd0b7.ammostock[weaponname] = self getweaponammostock(weaponobj);

    if(scripts\mp\utility\weapon::isakimbo(weaponobj)) {
      var_45f93a3ba26bd0b7.ammoclipleft[weaponname] = self getweaponammoclip(weaponobj, "left");
    }

    if(getsubstr(weaponname, 0, 4) == "alt_") {
      continue;
    }

    var_45f93a3ba26bd0b7.primaries[var_45f93a3ba26bd0b7.primaries.size] = weaponobj;
  }

  var_a8b87696ab744141 = self getweaponslistoffhands();

  foreach(offhandobj in var_a8b87696ab744141) {
    if(offhandobj.basename == "bandage_br") {
      continue;
    }

    offhandammo = self getweaponammoclip(offhandobj);

    if(offhandammo <= 0) {
      continue;
    }

    var_45f93a3ba26bd0b7.offhands[var_45f93a3ba26bd0b7.offhands.size] = offhandobj;
    offhandname = getcompleteweaponname(offhandobj);
    var_45f93a3ba26bd0b7.ammoclip[offhandname] = offhandammo;
  }

  foreach(slot, equipref in self.equipment) {
    var_45f93a3ba26bd0b7.equipslots[equipref] = slot;
  }

  var_45f93a3ba26bd0b7.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var_45f93a3ba26bd0b7.super = self.equipment["super"];
  }

  self.var_45f93a3ba26bd0b7 = var_45f93a3ba26bd0b7;
}

function playerwaittospawn() {
  if(playeriszombie()) {
    self waittill("spawnZombie");
  }
}

function playerreadytospawn() {
  self notify("spawnZombie");

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    self function_555e2d32e2756625("zombie");
  }

  self setclothtype("cloth");
  scripts\mp\deathicons::hidedeathicon(self);
}

function getvalidatedspawnorgangles(origin, dir, dist) {
  startorigin = origin + dir * dist;

  if(scripts\mp\gametypes\br_c130::iswithinplanepathsaferadius(startorigin)) {
    spawnangles = vectortoangles(dir * -1);
    return [startorigin, spawnangles];
  }

  return [undefined, undefined];
}

function playergetzombiespawnlocation() {
  var_72541f27d0911a16 = 50;
  var_ddb70f36e908d6d9 = 10000;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.brgametype.zombiespawnabovedeath)) {
    return [self.origin, self getplayerangles()];
  }

  radius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  origin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  dist = radius + var_72541f27d0911a16;
  var_ac2e1efdf095af8c = (self.origin[0], self.origin[1], 0);
  dir = vectorNormalize(var_ac2e1efdf095af8c - origin);
  var_ddb9b3e2fbe1d70a = dir;
  [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);

  if(!isDefined(startorigin)) {
    dir *= -1;
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (1, 0, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (-1, 0, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (0, 1, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (0, -1, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    radius = scripts\mp\gametypes\br_c130::getplanepathsaferadiusfromcenter();
    origin = level.br_level.br_mapcenter;
    origin += scripts\mp\gametypes\br_c130::function_1f389456d7c530a();
    dir = vectorNormalize(var_ac2e1efdf095af8c - origin);
    startorigin = origin + dir * radius;
    spawnangles = vectortoangles(dir * -1);
  }

  spawnorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(startorigin, var_ddb70f36e908d6d9);
  return [spawnorigin, spawnangles];
}

function playerzombieprestream(spawnorigin, spawnangles) {
  streamorigin = spawnorigin;

  if(level.brgametype.zombiespawninair) {
    height = getdvarint(@ "hash_2b1cfe3dd1fa5a38", 10000);
    dropspawnoffset = (0, 0, height);
    spawnorigin = scripts\mp\gametypes\br::getoffsetspawnorigin(spawnorigin, dropspawnoffset);
    spawnpoint = spawnStruct();
    spawnpoint.origin = spawnorigin;
    spawnpoint.angles = spawnangles;
    spawnpoint.height = height;
    streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
  } else {
    self setpredictedstreamloaddist(0);
    scripts\mp\gametypes\br_public::playerstreamhintlocation(streamorigin);
  }

  return [spawnorigin, streamorigin];
}

function playerstreamwaittillcomplete(spawnorigin, spawnangles, streamorigin) {
  namespace_8bfdb6eb5a3df67a::function_ab31cf673d70f72d(spawnorigin, spawnangles);
  linker = spawn("script_model", streamorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  self playerhide();
  thread namespace_8bfdb6eb5a3df67a::playercleanupentondisconnect(linker);
  waitframe();
  scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  scripts\mp\gametypes\br_public::playerclearstreamhintorigin();
  linker.origin = spawnorigin;
  waitframe();
  self unlink();
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  falltime = 0;

  if(isDefined(level.parachutedeploydelay)) {
    falltime = level.parachutedeploydelay;
  }

  thread scripts\cp_mp\parachute::startfreefall(falltime, 0, undefined, undefined, 1);
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_show_spectateHud", -1);
  namespace_8bfdb6eb5a3df67a::resetplayermovespeedscale();
  wait 0.5;
  namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
  waitframe();
  linker delete();
  self notify("can_show_splashes");
}

function playerzombiedelayturnonfx() {
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(level.brgametype.zombievision) {
    self hudoutlinedisable();

    if(!level.brgametype.var_63d9be743a6ba8cd) {
      self setscriptablepartstate("headVFX", "zombieVision");
    }

    self.var_54e863ebad3e233 = level.brgametype.zombievisionset;
    self visionsetnakedforplayer(level.brgametype.zombievisionset, 0);
    thread function_81e6ecfd4df39002();
    function_6febc57cce002a98();
  }

  waitframe();

  if(getdvarint(@ "hash_d2e09e5cb7c82d3f", 1)) {
    self setscriptablepartstate("zombie", "on_loop");
    return;
  }

  self setscriptablepartstate("zombie", "on");
}

function function_81e6ecfd4df39002() {
  self endon("disconnect");
  self endon("swim_breathing_disabled_begin");
  self endon("swim_begin");

  if(playeriszombie()) {
    self setclienttriggeraudiozonepartial("player_is_zombie", "ambient");
    waittill_any_2("zombie_unset", "death");
    self clearclienttriggeraudiozone(1);
  }
}

function function_6febc57cce002a98() {
  friendlyplayers = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  enemyplayers = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(player in friendlyplayers) {
    scripts\mp\utility\outline::outlineenableforplayer(player, self, "outline_depth_zombievision_friendly", "top");

    if(player playeriszombie()) {
      scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_zombievision_friendly", "top");
    }
  }

  foreach(player in enemyplayers) {
    if(!player playeriszombie()) {
      scripts\mp\utility\outline::outlineenableforplayer(player, self, "outline_depth_zombievision_enemy", "top");
    }
  }
}

function function_c53d906a08ed3e87() {
  friendlyplayers = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  enemyplayers = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(player in friendlyplayers) {
    if(isDefined(player) && player playeriszombie()) {
      scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_zombievision_friendly", "top");
    }
  }

  foreach(player in enemyplayers) {
    if(isDefined(player) && player playeriszombie()) {
      scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_zombievision_enemy", "top");
    }
  }
}

function playerzombiegasthink() {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("disconnect");
  self.zombieingas = undefined;

  while(true) {
    if(playerzombieisingas()) {
      if(!isDefined(self.zombieingas) || !self.zombieingas) {
        self.zombieingas = 1;
        playerzombieentergas();
      }
    } else if(!isDefined(self.zombieingas) || self.zombieingas) {
      self.zombieingas = 0;
      playerzombieexitgas();
    }

    waitframe();
  }
}

function playerzombieentergas() {
  self notify("zombie_enter_gas");
  self unsetperk("specialty_radarblip", 1);
}

function playerzombieexitgas() {
  self notify("zombie_exit_gas");

  if(level.brgametype.zombiepingrate >= 0) {
    if(level.brgametype.zombiepingrate == 0) {
      self setperk("specialty_radarblip", 1);
      return;
    }

    thread playerzombiepingoutofgas();
  }
}

function playerzombiepingoutofgas() {
  if(level.brgametype.zombiepingrate <= 0) {
    return;
  }

  self endon("zombie_unset");
  self endon("zombie_enter_gas");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self setperk("specialty_radarblip", 1);
    wait level.brgametype.zombiepingtime;
    self unsetperk("specialty_radarblip", 1);
    wait level.brgametype.zombiepingrate;
  }
}

function playerzombieisingas() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  dangercircleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  dangercircleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return distance2dsquared(dangercircleorigin, self.origin) > dangercircleradius * dangercircleradius;
}

function playerzombiesetradar() {
  self endon("disconnect");
  self.skipuavupdate = 1;
  self.radarmode = "normal_radar";
  self.hasradar = 1;
  self waittill("zombie_unset");
  self.skipuavupdate = undefined;
  self.hasradar = 0;
}

function playerzombiesupersprint() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  while(true) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    waitframe();
  }
}

function playerzombiehitground(var_e3438b8cb9c2c515, var_a2f406096e542298) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(istrue(self.var_584c38d71aa17739)) {
    self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);
  }

  wait 1;

  while(!self isonground() && !self isswimming()) {
    waitframe();
  }

  self setclientomnvar("ui_br_altimeter_state", 0);
  self skydive_interrupt();
  playFX(level._effect["zombie_splat"], self.origin);
  self playsoundtoplayer("zxp_spawn_splat_plr", self, self);
  self playSound("zxp_spawn_splat_npc", self, self);
  self freezecontrols(1);
  groundnormal = get_ground_normal(self, 0);

  if(!isDefined(groundnormal)) {
    groundnormal = (0, 0, 1);
  }

  ovf = anglesToForward(self.angles);
  newangles = vectortoangles(groundnormal);
  pitch = angleclamp180(newangles[0] + 90);
  newangles = (0, newangles[1], 0);
  var_65667e04420c7105 = anglesToForward(newangles);
  dot = vectordot(var_65667e04420c7105, ovf);
  newpitch = dot * pitch;
  var_20adb86449c4cc7 = getdvarint(@ "hash_f89852faf4700eb7", 20);
  var_a4ad9b2f0f9e5a70 = getdvarint(@ "hash_6b79ddef31557a12", -70);

  if(newpitch > 0) {
    newpitch = min(var_20adb86449c4cc7, newpitch);
  } else {
    newpitch = max(var_a4ad9b2f0f9e5a70, newpitch);
  }

  self setplayerangles((newpitch, self.angles[1], 0));

  if(self getcurrentprimaryweapon().classname != "none") {
    self forceplaygestureviewmodel("ges_zombie_splat");
  }

  wait 1;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  wait 0.5;
  self freezecontrols(0);
  self freezelookcontrols(1);
  self allowsprint(0);
  thread playerzombiepowers();

  if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_e3438b8cb9c2c515)) {
    assertmsg("<dev string:x1c>" + function_16b62b803ccf6981(var_e3438b8cb9c2c515));
    childthread playerweaponswitch(var_e3438b8cb9c2c515);
  }

  if(istrue(self.var_584c38d71aa17739)) {
    self.var_584c38d71aa17739 = undefined;
    self setscriptablepartstate("skydiveVfx", "default", 0);
  }

  if(istrue(var_a2f406096e542298)) {
    wait 0.5;
  } else {
    wait 1;
  }

  self freezelookcontrols(0);

  if(istrue(var_a2f406096e542298)) {
    wait 0.5;
  } else {
    wait 1;
  }

  self allowsprint(1);
}

function private function_16b62b803ccf6981(weapon) {
  player = self;
  errormessage = "Weapon Switch failed! ";

  if(player hasweapon(weapon)) {
    errormessage += "Player has weapon " + getweaponbasename(weapon) + " . ";
  } else {
    errormessage += "Player has NOT weapon " + getweaponbasename(weapon) + " . ";
  }

  currentweapon = player getcurrentweapon();
  currentweaponname = "none";

  if(isDefined(currentweapon)) {
    currentweaponname = getweaponbasename(currentweapon);
  }

  errormessage += "CurrentWeapon: " + currentweaponname + " . ";
  var_f2445c74eef451f9 = "none";
  var_d93faf2b91e9b072 = player scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

  if(isDefined(var_d93faf2b91e9b072)) {
    var_f2445c74eef451f9 = getweaponbasename(var_d93faf2b91e9b072);
  }

  errormessage += "CurrentHighPriorityWeapon: " + var_f2445c74eef451f9 + " . ";
  return errormessage;
}

function private playerweaponswitch(weapon) {
  player = self;
  player notify("zxpPlayerWeaponSwitch");
  player endon("zxpPlayerWeaponSwitch");
  switchimmediate = 1;
  result = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon, switchimmediate);
  assertex(result || player scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon), player function_16b62b803ccf6981(weapon));
}

function ondeadevent(team) {
  if(!isDefined(level.brgametype.var_8cfe7f196e21e100)) {
    level.brgametype.var_8cfe7f196e21e100 = [];
  }

  level.brgametype.var_8cfe7f196e21e100[level.brgametype.var_8cfe7f196e21e100.size] = team;
  return true;
}

function oneliminatedteamsrespawn() {
  level.brgametype.var_8cfe7f196e21e100 = undefined;
}

function onplayerdamaged(data) {
  var_f67c3d8d3e5e4c14 = isDefined(data.attacker) && isDefined(data.attacker.var_92ad976bcd196d41);
  var_e51a346ebc3d594b = data.victim getentitynumber();
  var_e255f974b378c965 = var_f67c3d8d3e5e4c14 && isDefined(data.attacker.var_92ad976bcd196d41.targetdata) && isDefined(data.attacker.var_92ad976bcd196d41.targetdata[var_e51a346ebc3d594b]) && data.attacker.var_92ad976bcd196d41.targetdata[var_e51a346ebc3d594b] == data.victim;
  var_7bfcad6985f865ac = isPlayer(data.attacker) && data.attacker playeriszombie();

  if(data.victim playeriszombie() && var_e255f974b378c965) {
    data.attacker thread removepingondamageheadicon(data.victim, data.victim.headicon);
  }

  if(var_7bfcad6985f865ac) {
    self playSound("zmb_npc_impact_hit");
  }
}

function removepingondamageheadicon(targetent, var_fafaa28d217bf19c) {
  level endon("game_ended");
  targetent endon("disconnect");
  entnum = targetent getentitynumber();
  targetent endon("removeHeadIcon_" + entnum);
  notifystring = "removePingOnDamageHeadIcon_" + entnum;
  self notify(notifystring);
  self endon(notifystring);
  targetent waittill("zombie_unset");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_fafaa28d217bf19c);
}

function setupzombiepowers() {
  if(!level.brgametype.zombiepowersenabled) {
    return;
  }

  level.brgametype.zombie = spawnStruct();
  level.brgametype.zombie.powers = [];
  var_f9a7592661710983 = level.brgametype.var_52d26462081a2d41 + level.brgametype.var_5a945be17bf844bd + level.brgametype.var_89b7489c115dc08a;
  addpowerbutton(level.brgametype.zombie, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &playerzombiejump, 0, undefined, &playerzombiejumpcleanup, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress");
  addpowerbutton(level.brgametype.zombie, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &playerzombiejumpstop, 0);
  addpowerbutton(level.brgametype.zombie, "gas", "+smoke", &function_3287e064cd7027f, 0, &function_2418beaf3229ed30, &function_95863013475ad0e9, &function_2418beaf3229ed30, &"MP_ZXP/GAS_GRENADE", undefined, 15, "gasGrenadeStatus", "gasGrenadeProgress");
  addpowerbutton(level.brgametype.zombie, "shout", "+frag", &function_7f013d8a91788fdf, 0, undefined, undefined, undefined, &"MP_ZXP/SHOUT", undefined, var_f9a7592661710983, "shoutStatus", "shoutProgress");

  if(getdvarint(@ "hash_da9aa24852c36fd1", 1)) {
    addpowerbutton(level.brgametype.zombie, "gas_or_shout", ["+equip_toggle_throw"], &playerzombiegasorshout, 0, undefined, &function_cd06c81e9adcbee9);
  }
}

function addpowerbutton(powerstruct, powerref, keybindings, var_fb3a9f61fc511db4, var_91513a57aa89be6d, var_1a5269312d3a0b00, cleanupfunc, var_7939d347ade41da0, label, labelpc, cooldownsec, statusupdate, progressupdate) {
  var_2afd19924dad2b4f = hashcat(@ "hash_b75ff36b09040395", powerref);

  if(getdvarint(var_2afd19924dad2b4f, 1) == 0) {
    return;
  }

  if(isstring(keybindings)) {
    keybindings = [keybindings];
  }

  powerstruct.powers[powerref] = spawnStruct();
  powerstruct.powers[powerref].bindings = keybindings;
  powerstruct.powers[powerref].func = var_fb3a9f61fc511db4;
  powerstruct.powers[powerref].var_1a5269312d3a0b00 = var_1a5269312d3a0b00;
  powerstruct.powers[powerref].cleanupfunc = cleanupfunc;
  powerstruct.powers[powerref].var_7939d347ade41da0 = var_7939d347ade41da0;
  powerstruct.powers[powerref].label = label;
  powerstruct.powers[powerref].labelpc = labelpc;
  powerstruct.powers[powerref].cooldownsec = cooldownsec;
  powerstruct.powers[powerref].statusupdate = statusupdate;
  powerstruct.powers[powerref].progressupdate = progressupdate;
  powerstruct.powers[powerref].var_91513a57aa89be6d = var_91513a57aa89be6d;
}

function playerzombiegasorshout(powerstruct, powerref) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("playerZombieGasOrShout");
  self endon("playerZombieGasOrShout");
  endtime = gettime() + getdvarint(@ "hash_64480c2e87bc9a43", 500);

  while(endtime > gettime()) {
    if(self secondaryoffhandbuttonPressed()) {
      self notify("gas");
      break;
    } else if(self fragButtonPressed()) {
      self notify("shout");
      break;
    }

    waitframe();
  }
}

function function_7f013d8a91788fdf(powerstruct, powerref) {
  zombie = self;

  if(!isDefined(zombie)) {
    return;
  }

  zombie.var_3f4318a44cfc517f = undefined;

  if(!zombie function_72e633a2cadc2f8f()) {
    zombie function_e63114420500fb();
    zombie function_ae8ecf6e5f68f1ea(zombie.var_3f4318a44cfc517f);
    zombie thread function_f2ddb7c78178c1be(powerstruct, powerref);
    return;
  }

  if(zombie scripts\mp\utility\weapon::grenadeinpullback()) {
    zombie function_187fb04ebd01baea();
  }

  zombie thread function_120695737abd78f4(powerstruct, powerref);
  zombie thread function_502603b3a9bddbc4(powerstruct, powerref);
  zombie thread function_2726f662b9cd30a8();
}

function function_72e633a2cadc2f8f() {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie playeriszombie()) {
    return false;
  }

  if(zombie isswimunderwater()) {
    zombie.var_3f4318a44cfc517f = "MP_BR_INGAME/ZMB_SHOUT_ERROR_UNDERWATER";
    return false;
  }

  if(zombie isonladder()) {
    zombie.var_3f4318a44cfc517f = "MP_BR_INGAME/ZMB_SHOUT_ERROR_LADDER";
    return false;
  }

  return true;
}

function function_ae8ecf6e5f68f1ea(errormessage) {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie playeriszombie()) {
    return;
  }

  if(!isDefined(errormessage)) {
    return;
  }

  zombie scripts\mp\hud_message::showerrormessage(errormessage);
}

function function_2726f662b9cd30a8() {
  zombie = self;
  zombie endon("zombie_shout_finished");
  waittill_any_ents(zombie, "death", zombie, "disconnect", level, "game_ended", zombie, "zombie_unset");

  if(!isDefined(zombie)) {
    return;
  }

  if(istrue(zombie.var_a2906c0a3da2c192)) {
    stopFXOnTag(level._effect["zombie_shout"], zombie, "j_head");
    stopFXOnTag(level._effect["zombie_shout_shockwaves"], zombie, "tag_origin");

    if(zombie isgestureplaying("ges_zombie_shout")) {
      zombie stopgestureviewmodel("ges_zombie_shout");
    }
  }

  if(istrue(zombie.buffed)) {
    zombie setscriptablepartstate("zombieBuffVfx", "off", 0);
    zombie setscriptablepartstate("zombieRageVfx", "off", 0);
    zombie.movespeedscaler = 1;
    zombie setmovespeedscale(zombie.movespeedscaler);
  }

  zombie.var_a2906c0a3da2c192 = 0;
  zombie.buffed = 0;
}

function function_502603b3a9bddbc4(powerstruct, powerref) {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie)) {
    return;
  }

  zombie endon("death");
  zombie endon("disconnect");
  zombie endon("zombie_unset");
  level endon("game_ended");
  zombie.var_a2906c0a3da2c192 = 1;

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 4);
  }

  zombie forceplaygestureviewmodel("ges_zombie_shout");
  playFXOnTag(level._effect["zombie_shout"], zombie, "j_head");
  playFXOnTag(level._effect["zombie_shout_shockwaves"], zombie, "tag_origin");
  self setscriptablepartstate("zombieRageVfx", "fx_start", 0);
  wait level.brgametype.var_52d26462081a2d41;
  zombie stopgestureviewmodel("ges_zombie_shout");
  zombie.var_a2906c0a3da2c192 = 0;
  zombie notify("zombie_shouting_finished");
  zombie.buffed = 1;
  zombie thread function_74b142ac51e57492();
  self setscriptablepartstate("zombieBuffVfx", "on", 0);
  wait level.brgametype.var_5a945be17bf844bd;
  self setscriptablepartstate("zombieBuffVfx", "off", 0);
  self setscriptablepartstate("zombieRageVfx", "fx_end", 0);

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 1);
  }

  zombie.movespeedscaler = 1;
  zombie setmovespeedscale(zombie.movespeedscaler);
  zombie function_9354c4c50c43abc0(zombie.movespeedscaler);
  zombie.buffed = 0;
  zombie notify("zombie_shout_finished");
}

function function_74b142ac51e57492() {
  zombie = self;
  zombie endon("death");
  zombie endon("disconnect");
  zombie endon("zombie_unset");
  zombie endon("zombie_shout_finished");
  level endon("game_ended");

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie playeriszombie()) {
    return;
  }

  zombie function_9354c4c50c43abc0(level.brgametype.var_2d23e5b9abed638c);

  while(true) {
    zombie.movespeedscaler = zombie function_9af8aa334971aeb0();

    if(isDefined(zombie.movespeedscaler) && zombie.movespeedscaler > 0) {
      zombie setmovespeedscale(zombie.movespeedscaler);
    }

    waitframe();
  }
}

function function_9af8aa334971aeb0() {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie playeriszombie()) {
    return undefined;
  }

  if(zombie isswimming()) {
    return undefined;
  }

  if(zombie issprintsliding()) {
    return level.brgametype.var_6225ce8e059e5ce5;
  }

  return level.brgametype.var_695b3601560f5703;
}

function function_c6519d37adedcb4f(time) {
  if(isDefined(time)) {
    wait time;
  }

  self enableplayerbreathsystem(1);
}

function function_120695737abd78f4(powerstruct, powerref) {
  if(level.brgametype.hudserver) {
    self.powershud[powerref].barelem updatebar(1, 0);
  } else {
    self.powershud[powerref].frac = 1;
  }

  thread playerpowerstartcooldown(powerstruct, powerref);
}

function function_cd06c81e9adcbee9(powerstruct, powerref) {
  self notify("playerZombieGasOrShout");
}

function playerzombiepowers() {
  if(!level.brgametype.zombiepowersenabled) {
    return;
  }

  thread playerstartpowers(level.brgametype.zombie);
}

function playerstartpowers(powerstruct) {
  thread playerpowerssetupkeybindings(powerstruct);
  thread playerpowershud(powerstruct);
  thread playerpowersmonitorinput(powerstruct);

  if(level.brgametype.hudserver) {
    thread playerpowersupdateongamepadchange(powerstruct);
  }

  thread function_539dc27334184e77(powerstruct);
  thread playerpowerscleanup(powerstruct);

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(powerstruct.powers[powerref].statusupdate)) {
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 2);
    }
  }
}

function function_2418beaf3229ed30(powerstruct, powerref) {
  scripts\mp\equipment::giveequipment("equip_gas_grenade", "secondary");
  scripts\mp\equipment::setequipmentslotammo("secondary", 1);
}

function function_3287e064cd7027f(powerstruct, powerref) {
  level endon("game_ended");
  self endon("offhand_end");
  self endon("zombie_unset");
  self endon("death_or_disconnect");
  self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

  if(!scripts\mp\utility\weapon::grenadethrown(grenade)) {
    return;
  }

  self playSound("zxp_grenade_vo_npc", self, self);
  thread function_120695737abd78f4(powerstruct, powerref);
  wait 0.25;
  function_95863013475ad0e9(powerstruct, powerref);
  self notify("gas_grenade_finished");
}

function function_95863013475ad0e9(powerstruct, powerref) {
  scripts\mp\equipment::takeequipment("secondary");
}

function playerpowerscleanup(powerstruct) {
  level endon("game_ended");
  self endon("disconnect");
  waittill_any_3("death", "zombie_unset", "zombie_set");
  thread playerpowerresetpowers(powerstruct);
  thread playerpowerscleanupkeybindings(powerstruct);
  thread playerpowerscleanuppowers(powerstruct);
  thread playerpowerscleanuphud(powerstruct);
}

function playerpowerssetupkeybindings(powerstruct) {
  if(isbot(self)) {
    return;
  }

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    foreach(binding in var_8723cff430a72c82.bindings) {
      self notifyonplayercommand(powerref, binding);
    }
  }
}

function playerpowerscleanuphud(powerstruct) {
  if(!isDefined(self.powershud)) {
    return;
  }

  if(level.brgametype.hudserver) {
    foreach(hudelem in self.powershud) {
      if(isDefined(hudelem)) {
        if(isDefined(hudelem.barelem)) {
          hudelem.barelem destroyelem();
        }

        hudelem destroy();
      }
    }
  }

  self.powershud = undefined;
}

function playerpowershud(powerstruct) {
  var_6e2c1bd41e3923d6 = 200;
  var_6d8e1e3cbd28de50 = 18;
  assert(!isDefined(self.powershud));
  currenthudy = var_6e2c1bd41e3923d6;
  self.powershud = [];

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(var_8723cff430a72c82.label)) {
      if(level.brgametype.hudserver) {
        self.powershud[powerref] = playerpowersaddhudelem(var_8723cff430a72c82.label, var_8723cff430a72c82.labelpc, currenthudy, var_8723cff430a72c82.var_91513a57aa89be6d);
      } else {
        self.powershud[powerref] = spawnStruct();
        self.powershud[powerref].frac = 0;
      }

      self.powershud[powerref].incooldown = 0;
      currenthudy += var_6d8e1e3cbd28de50;
    }
  }
}

function playerpowersaddhudelem(label, labelpc, currenthudy, var_91513a57aa89be6d) {
  hudelem = createfontstring("default", 1.5);
  hudelem.x = 15;
  hudelem.y = currenthudy;
  hudelem.alignx = "left";
  hudelem.aligny = "top";
  hudelem.horzalign = "left_adjustable";
  hudelem.vertalign = "top_adjustable";
  hudelem.alpha = var_91513a57aa89be6d;
  hudelem.glowalpha = 0;
  hudelem.hidewheninmenu = 1;
  hudelem.archived = 0;

  if(isDefined(labelpc) && !is_player_gamepad_enabled()) {
    hudelem.label = labelpc;
  } else if(isDefined(label)) {
    hudelem.label = label;
  }

  barelem = createbar((1, 1, 1), 160, 14);
  barelem.x = 13;
  barelem.y = currenthudy;
  barelem.alignx = "left";
  barelem.aligny = "top";
  barelem.horzalign = "left_adjustable";
  barelem.vertalign = "top_adjustable";
  barelem.alpha = var_91513a57aa89be6d;
  barelem shiftbar();
  barelem.archived = 0;
  barelem.hidewheninmenu = 1;
  barelem.bar.archived = 0;
  barelem.bar.hidewheninmenu = 1;
  barelem.bar.alpha = var_91513a57aa89be6d;
  hudelem.barelem = barelem;
  return hudelem;
}

function shiftbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  updatebar(self.bar.frac);
}

function playerpowerscleanupkeybindings(powerstruct) {
  if(isbot(self)) {
    return;
  }

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    foreach(binding in var_8723cff430a72c82.bindings) {
      self notifyonplayercommandremove(powerref, binding);
    }
  }
}

function playerpowerscleanuppowers(powerstruct) {
  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(var_8723cff430a72c82.cleanupfunc)) {
      self thread[[var_8723cff430a72c82.cleanupfunc]](powerstruct, powerref);
    }
  }
}

function playerpowerresetpowers(powerstruct) {
  if(!isDefined(powerstruct) || !isDefined(self.powershud)) {
    return;
  }

  self notify("disableCooldown");

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(!isDefined(self.powershud[powerref])) {
      continue;
    }

    self.powershud[powerref].incooldown = 0;

    if(level.brgametype.hudserver) {
      self.powershud[powerref].barelem updatebar(0, 0);
    } else {
      self.powershud[powerref].frac = 0;
    }

    thread playerpowerstartcooldown(powerstruct, powerref);
  }

  self.var_f07121951ba8e9a5 = undefined;
  self.var_741cb4edf0f0590c = undefined;
}

function remainingplayersaliveonteam(team) {
  if(!isDefined(level.teamdata[team]["aliveCountHuman"])) {
    return level.teamdata[team]["aliveCount"];
  }

  return level.teamdata[team]["aliveCountHuman"];
}

function kioskreviveplayer(sponsor, tokenused) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulag_auto_win");
  player notify("zombie_set");
  player notify("zombie_unset");

  if(istrue(player.respawningfromtoken)) {
    return;
  }

  var_84e2123aaca9a965 = sponsor;
  var_df2fbb13c226be75 = "token_sponsored";

  if(!isalive(player) && istrue(player.br_iseliminated)) {
    if(!level.brgametype.var_863f6d0e1a1c01e9) {
      player playersetisbecomingzombie(1);
    }

    [var_84e2123aaca9a965, var_df2fbb13c226be75] = namespace_8bfdb6eb5a3df67a::playerhandlesponsor(sponsor, tokenused, 0, 1, 0, "zombiesRevive");
  } else if(istrue(var_84e2123aaca9a965.hasrespawntoken)) {
    var_84e2123aaca9a965 scripts\mp\gametypes\br_pickups::removerespawntoken();
  }

  player.respawningfromtoken = 1;
  var_1476e0f78320a501 = player namespace_8bfdb6eb5a3df67a::playerwaitforprestreaming();

  if(var_1476e0f78320a501) {
    player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }

  player scripts\mp\hud_message::clearsplashqueue();

  if(level.brgametype.var_863f6d0e1a1c01e9) {
    player scripts\mp\gametypes\br_gametype_zxp::playerzombiebacktohuman(1);
  } else {
    player playerzombierespawn(0);
  }

  player freezecontrols(0);
  player freezelookcontrols(0);
  player allowsprint(1);
  var_9d45f503ae900a7d = "br_gulag_kiosk_redeploy";
  var_1f0a356715870574 = sponsor;
  player thread scripts\mp\hud_message::showsplash(var_9d45f503ae900a7d, undefined, sponsor);
  player.respawningfromtoken = undefined;
}

function function_539dc27334184e77(powerstruct) {
  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(isDefined(var_8723cff430a72c82.var_1a5269312d3a0b00)) {
      self thread[[var_8723cff430a72c82.var_1a5269312d3a0b00]](powerstruct, powerref);
    }
  }
}

function playerpowersmonitorinput(powerstruct) {
  if(!scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587() && isbot(self)) {
    return;
  }

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    thread function_a17e5100d67f2109(powerstruct, powerref);
  }
}

function function_a17e5100d67f2109(powerstruct, powerref) {
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  level endon("game_ended");

  while(true) {
    self waittill(powerref);
    waittillframeend();

    if(isDefined(self.powershud[powerref]) && self.powershud[powerref].incooldown) {
      function_e63114420500fb();
      continue;
    }

    self thread[[powerstruct.powers[powerref].func]](powerstruct, powerref);
  }
}

function function_e63114420500fb() {
  if(!isDefined(self.var_f07121951ba8e9a5) || gettime() > self.var_f07121951ba8e9a5) {
    self playlocalsound("br_pickup_deny");
    self.var_f07121951ba8e9a5 = gettime() + 1000;
  }
}

function playerpowersupdateongamepadchange(powerstruct) {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var_fd0efa5c23be8228 = is_player_gamepad_enabled();

  while(true) {
    var_890736e866204b96 = is_player_gamepad_enabled();

    if(var_890736e866204b96 != var_fd0efa5c23be8228) {
      var_fd0efa5c23be8228 = var_890736e866204b96;

      if(var_890736e866204b96) {
        foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
          if(isDefined(var_8723cff430a72c82.labelpc)) {
            self.powershud[powerref].label = var_8723cff430a72c82.label;
          }
        }
      } else {
        foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
          if(isDefined(var_8723cff430a72c82.labelpc)) {
            self.powershud[powerref].label = var_8723cff430a72c82.labelpc;
          }
        }
      }
    }

    waitframe();
  }
}

function playerpowerstartcooldown(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(self.powershud[powerref]) || istrue(self.powershud[powerref].incooldown)) {
    return;
  }

  var_67bf71bf64a4c87f = self.powershud[powerref];

  if(level.brgametype.powerscooldown && var_67bf71bf64a4c87f.frac > 0) {
    self.powershud[powerref].incooldown = 1;
    cooldownsec = powerstruct.powers[powerref].cooldownsec;
    var_b1f7ce0445d66ac9 = hashcat(@ "hash_a726fd9fdb5568e5", powerref);

    if(getdvarint(var_b1f7ce0445d66ac9, 0) != 0) {
      cooldownsec = getdvarint(var_b1f7ce0445d66ac9, 0);
    }

    thread function_90f6fbbb6332dadd(powerstruct, powerref, cooldownsec, int(var_67bf71bf64a4c87f.frac * 100));
    fraction = var_67bf71bf64a4c87f.frac;
    cooldownsec *= fraction;

    if(level.brgametype.hudserver) {
      var_67bf71bf64a4c87f.barelem.bar.color = (1, 0.6, 0);
      var_67bf71bf64a4c87f.barelem.bar scaleovertime(cooldownsec, 0, var_67bf71bf64a4c87f.barelem.height);
    }

    wait cooldownsec;
    var_6538d60a6fdba877 = "zxp_restock_" + powerref;
    self playlocalsound(var_6538d60a6fdba877);
    self.powershud[powerref].incooldown = 0;
  } else {
    if(level.brgametype.hudserver) {
      var_67bf71bf64a4c87f.barelem updatebar(0, 0);
    } else {
      var_67bf71bf64a4c87f.frac = 0;
    }

    thread function_90f6fbbb6332dadd(powerstruct, powerref, 0, 0);
  }

  if(level.brgametype.hudserver) {
    var_67bf71bf64a4c87f.barelem.bar.color = (1, 1, 1);
  }

  if(isDefined(powerstruct.powers[powerref].var_7939d347ade41da0)) {
    self[[powerstruct.powers[powerref].var_7939d347ade41da0]](powerstruct, powerref);
  }
}

function function_90f6fbbb6332dadd(powerstruct, powerref, cooldownsec, var_25ccce114196d19c) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(powerstruct.powers[powerref].statusupdate) || !isDefined(powerstruct.powers[powerref].progressupdate)) {
    return;
  }

  function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 1);
  durationms = cooldownsec * 1000 * var_25ccce114196d19c / 100;
  starttime = gettime();
  endtime = starttime + durationms;

  while(gettime() < endtime) {
    var_a0dfc893004c6eb3 = gettime();
    fraction = (endtime - gettime()) / durationms;
    progress = fraction * var_25ccce114196d19c;
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, int(progress));
    waitframe();
  }

  function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 0);
  function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 2);
}

function function_936f0ef6e203a7fc(dataref, value) {
  if(!istrue(level.brgametype.zombiepowersenabled)) {
    return;
  }

  bitoffset = 0;
  bitwidth = 0;

  switch (dataref) {
    case #"hash_6fdca435002399b7":
      bitoffset = 0;
      bitwidth = 2;
      break;
    case #"hash_903c3a93257a45fe":
      bitoffset = 2;
      bitwidth = 7;
      break;
    case #"hash_33f6e05f0765624c":
      bitoffset = 9;
      bitwidth = 3;
      break;
    case #"hash_11b1be2500f780fd":
      bitoffset = 12;
      bitwidth = 7;
      break;
    case #"hash_b2d5d8995a0d93ca":
      bitoffset = 19;
      bitwidth = 2;
      break;
    case #"hash_9af3d492597d7bbb":
      bitoffset = 21;
      bitwidth = 7;
      break;
    case #"hash_d4536c3cd58937a6":
      bitoffset = 28;
      bitwidth = 2;
      break;
    default:
      assertmsg("<dev string:x66>" + dataref + "<dev string:x86>");
      break;
  }

  if(!isDefined(level.var_ce83fb46b0b7d8f3)) {
    level.var_ce83fb46b0b7d8f3 = [];
  }

  if(!isDefined(level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"])) {
    level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"] = 0;
  }

  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (int(value) &mask) << bitoffset;
  var_f8f977081d3da8b4 = ~(mask << bitoffset);
  prevvalue = self getclientomnvar("ui_br_zombie_powers");
  cleanedbase = prevvalue &var_f8f977081d3da8b4;
  var_82a90e56e416fa55 = cleanedbase + var_a463992091f1d483;
  level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"] = var_82a90e56e416fa55;
  self setclientomnvar("ui_br_zombie_powers", level.var_ce83fb46b0b7d8f3["ui_br_zombie_powers"]);
}

function function_f2ddb7c78178c1be(powerstruct, powerref) {
  if(!isDefined(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 3);
  }

  wait level.brgametype.var_ca0a3ce7573e0780;

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 2);
  }
}

function playerzombiejump(powerstruct, powerref) {
  if(!isDefined(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  var_4ca6e232b3a08ae5 = -1;
  self.var_ee75699e65f68166 = undefined;

  if(function_77bab0532bc12f0e()) {
    function_e63114420500fb();
    function_ae8ecf6e5f68f1ea(self.var_ee75699e65f68166);
    thread function_f2ddb7c78178c1be(powerstruct, powerref);
    return;
  }

  var_e8b1539c9f6ccbc1 = getdvarfloat(@ "hash_2fc6c2dc7f9c722a", 1);
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_6b00aa3867c7f0d9 = getdvarint(@ "hash_69111e35067f9d8f", var_4ca6e232b3a08ae5);
  var_57bd73d0ecaee169 = var_e8b1539c9f6ccbc1 * level.framedurationseconds;
  self.var_17c60a92aea65107 = 0;
  self allowmelee(0);
  self disableoffhandweapons();
  scripts\common\values::set("zombie_jump", "sprint", 0);
  thread function_647ba9e9a0d700c7();
  thread superjumpfov();
  var_715d7709363e068c = undefined;
  progress = 0;

  if(!isDefined(self.var_741cb4edf0f0590c) || gettime() > self.var_741cb4edf0f0590c) {
    self playlocalsound("zxp_charge_jump_start");
    self.var_741cb4edf0f0590c = gettime() + 500;
  }

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 0);
  }

  while(!function_77bab0532bc12f0e()) {
    if(level.brgametype.hudserver) {
      self.powershud[powerref].barelem updatebar(self.var_17c60a92aea65107, 0);
    } else {
      self.powershud[powerref].frac = self.var_17c60a92aea65107;
    }

    prevfrac = self.var_17c60a92aea65107;
    self.var_17c60a92aea65107 += var_57bd73d0ecaee169;

    if(self.var_17c60a92aea65107 >= 1) {
      self.var_17c60a92aea65107 = 1;

      if(var_6b00aa3867c7f0d9 >= 0) {
        if(!isDefined(var_715d7709363e068c)) {
          var_715d7709363e068c = gettime() + var_6b00aa3867c7f0d9 * 1000;

          if(level.brgametype.hudserver) {
            thread playerzombiejumpmaxholdwarning(powerref, var_6b00aa3867c7f0d9);
          }
        }

        if(gettime() >= var_715d7709363e068c) {
          break;
        }
      }
    }

    if(level.brgametype.hudserver && prevfrac < var_eec1ca5327266614 && self.var_17c60a92aea65107 >= var_eec1ca5327266614) {
      self.powershud[powerref].barelem.bar.color = (0, 1, 0);
    }

    if(prevfrac < 1 && self.var_17c60a92aea65107 >= 1) {
      self playlocalsound("zxp_charge_jump_full");
    }

    if(isDefined(powerstruct.powers[powerref].progressupdate)) {
      progress = max(int(self.var_17c60a92aea65107 * 100), 0);
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, progress);
    }

    waitframe();
  }

  thread function_a1b195bc24dae315(powerstruct, powerref);
}

function function_77bab0532bc12f0e() {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie playeriszombie()) {
    return true;
  }

  if(zombie meleeButtonPressed() || zombie attackButtonPressed()) {
    zombie.var_e11136acf00d18f = 1;
    return true;
  }

  if(zombie getstance() == "prone") {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_PRONE";
    return true;
  }

  if(zombie isswimunderwater()) {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_UNDERWATER";
    return true;
  }

  if(zombie ishanging()) {
    zombie.var_ee75699e65f68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_HANGING";
    return true;
  }

  return false;
}

function function_d4e7d5bfedb0b977() {
  if(level.brgametype.var_854edaec88caf865 != 0) {
    end = self.origin + (0, 0, level.brgametype.var_854edaec88caf865);
    result = playerphysicstrace(self.origin, end);

    if(result != end) {
      return false;
    }
  }

  if(level.brgametype.var_854ed7ec88caf1cc != 0) {
    start = self getEye();
    end = start + (0, 0, level.brgametype.var_854ed7ec88caf1cc);
    radius = 10;
    height = 20;
    contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    result = scripts\engine\trace::capsule_trace(start, end, radius, height, (0, 0, 0), self, contents);

    if(result["fraction"] != 1) {
      return false;
    }
  }

  return true;
}

function function_a1b195bc24dae315(powerstruct, powerref) {
  self stopgestureviewmodel("ges_zombie_superjumpcharge");
  self notify("playerZombieJumpChargeEnd");
  self notify("playerZombieJumpStop");
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_e5482b00771c4909 = getdvarint(@ "hash_2a5201ccbcd3b1a1", 1);
  var_b13a0e71ef0de57c = 1;

  if(self.var_17c60a92aea65107 >= var_eec1ca5327266614 && !function_77bab0532bc12f0e() && function_d4e7d5bfedb0b977() && !self ismantling()) {
    self playsoundtoplayer("zxp_superjump_vo", self, self);
    self playsoundonmovingent("zxp_superjump_sfx_npc");
    self playsoundonmovingent("jup_mp_mode_mutation_zombie_superjump_leap");
    self playsoundonmovingent("jup_mp_mode_mutation_zombie_superjump_whoosh");
    maxjumpvelocity = getdvarfloat(@ "hash_fd6822a1c2607510", 1300);
    player_angles = self getplayerangles();
    thread function_a3335da8620d547c();
    playerapplyjumpvelocity(player_angles, maxjumpvelocity, self.var_17c60a92aea65107);
    thread function_dd8a4b0712217000();
    thread function_46bb895f743ddb94();
    self.var_f07121951ba8e9a5 = undefined;
    self.var_741cb4edf0f0590c = undefined;
  } else {
    if(var_e5482b00771c4909) {
      if(level.brgametype.hudserver) {
        self.powershud[powerref].barelem.bar.frac = 0;
      } else {
        self.powershud[powerref].frac = 0;
      }

      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 0);
      scripts\common\values::reset_all("zombie_jump");
      self enableoffhandweapons();
      self allowmelee(1);
      self notify("endSuperJumpFov");
    }

    function_e63114420500fb();
    function_ae8ecf6e5f68f1ea(self.var_ee75699e65f68166);
    thread function_f2ddb7c78178c1be(powerstruct, powerref);

    if(istrue(self.var_e11136acf00d18f)) {
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 100);
      var_b13a0e71ef0de57c = 0;
    }
  }

  playerzombiejumpcleanup(powerstruct, powerref, var_b13a0e71ef0de57c);
}

function function_647ba9e9a0d700c7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");

  if(self isgestureplaying("ges_zombie_superjumpcharge")) {
    return;
  }

  if(scripts\mp\utility\weapon::grenadeinpullback()) {
    self function_187fb04ebd01baea();
  }

  while(self ismantling() || self ismeleeing()) {
    waitframe();
  }

  self forceplaygestureviewmodel("ges_zombie_superjumpcharge");

  while(self isgestureplaying("ges_zombie_superjumpcharge")) {
    if(self isonladder()) {
      self stopgestureviewmodel("ges_zombie_superjumpcharge");
      break;
    }

    waitframe();
  }
}

function function_a3335da8620d547c() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self allowjump(0);
  self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);
  wait 0.2;
  self enableoffhandweapons();
  self notify("endSuperJumpFov");
  self forceplaygestureviewmodel("ges_zombie_superjump");
  thread function_a0810cb7bb46ccdb();

  while(!function_bd2a29feef8f2889()) {
    waitframe();
  }

  self notify("zombie_jump_complete");
  self stopgestureviewmodel("ges_zombie_superjump");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playsoundtoplayer("zxp_splat_plr", self, self);
  self playSound("zmb_npc_breath_land_hi", self, self);
  self playSound("zxp_splat_npc", self, self);
  wait 0.2;
  scripts\common\values::reset_all("zombie_jump");
  self allowmelee(1);
  self allowjump(1);
}

function function_a0810cb7bb46ccdb() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_jump_complete");

  while(true) {
    waittill_any_2("gas_grenade_finished", "zombie_shouting_finished");
    self forceplaygestureviewmodel("ges_zombie_superjump");
  }
}

function function_bd2a29feef8f2889() {
  return self isonground() || self isonladder() || self ismantling() || self isswimming();
}

function playerapplyjumpvelocity(angledir, maxjumpvelocity, fraction, startoffset) {
  var_355760d151d56e05 = 1;
  var_b2d80e99c4ea7f00 = (0, 0, 20);

  if(!isDefined(startoffset)) {
    startoffset = var_b2d80e99c4ea7f00;
  }

  player_angles = angledir;
  ground_normal = (0, 0, 1);
  fwd = (1, 0, 0);

  if(getdvarint(@ "hash_ce6d7d66848cdbcc", var_355760d151d56e05)) {
    if(istrue(level.brgametype.var_5ba111ae6c83effe)) {
      ground_normal = get_ground_normal();

      if(!isDefined(ground_normal)) {
        ground_normal = (0, 0, 1);
      }
    }

    yawangles = (0, player_angles[1], 0);
    right = anglestoright(yawangles);
    fwd = vectorcross(ground_normal, right);
    fwd_angles = vectortoangles(fwd);
    ground_pitch = angleclamp180(fwd_angles[0]);
    min_pitch = -85;
    max_pitch = ground_pitch;
    player_pitch = player_angles[0];

    if(player_pitch > ground_pitch) {
      player_pitch = ground_pitch;
    }

    var_e6bc250926c6d64d = getdvarfloat(@ "hash_9ec479015407c245", -45);
    var_e6980f09269e2b33 = getdvarfloat(@ "hash_9ee78301542e1ffb", 0);
    frac = (player_pitch - min_pitch) / (max_pitch - min_pitch);
    var_aee49e405bf58492 = var_e6980f09269e2b33 + frac * (var_e6bc250926c6d64d - var_e6980f09269e2b33);
    player_angles = (player_pitch + var_aee49e405bf58492, player_angles[1], player_angles[2]);
  }

  pitch_add = getdvarfloat(@ "hash_cf56037c34ea141f", 0);

  if(pitch_add != 0) {
    player_angles = (player_angles[0] + pitch_add, player_angles[1], player_angles[2]);
  }

  dir = anglesToForward(player_angles);
  velocity = dir * fraction * maxjumpvelocity;
  startorg = self.origin + startoffset;
  self setOrigin(startorg, 0);
  self setvelocity(velocity);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  fwddir = anglesToForward(self.angles);
  var_cc05c7fa92d3f6ba = self.origin + (0, 0, 30) + fwddir * 15;
  radiusdamage(var_cc05c7fa92d3f6ba, 100, 1, 1);
}

function function_dd8a4b0712217000() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  var_4992594dd7ee57b6 = getdvarfloat(@ "hash_1df491267fcc6307", 400);

  if(var_4992594dd7ee57b6 <= 0) {
    return;
  }

  maxspeed = getdvarfloat(@ "hash_a60f6bc28d9bc0c6", 1400);
  wait 0.2;

  while(!function_bd2a29feef8f2889()) {
    movementinput = self getnormalizedmovement();

    if(length(movementinput) > 0) {
      worlddir = rotatevector((movementinput[0], -1 * movementinput[1], 0), self.angles);
      velocity = self getvelocity();
      speed = length(velocity);
      var_3b61b63c7e59f697 = worlddir * var_4992594dd7ee57b6 * level.framedurationseconds;
      newvel = velocity + var_3b61b63c7e59f697;
      newspeed = length(newvel);

      if(newspeed <= maxspeed) {
        self setvelocity(newvel);
      } else if(speed < maxspeed) {
        newvel = vectorNormalize(newvel) * maxspeed;
        self setvelocity(newvel);
      }
    }

    waitframe();
  }
}

function function_46bb895f743ddb94() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_jump_complete");
  var_70e2efb856b2eebf = getdvarfloat(@ "hash_407c08e67d1cb43b", 0.3);

  if(var_70e2efb856b2eebf < 0) {
    return;
  }

  if(var_70e2efb856b2eebf > 0) {
    wait var_70e2efb856b2eebf;
  }

  self function_aaa37279040dd667();
}

function function_8fde79c22dc9f857(startorg, velocity, groundorg, ground_normal, fwd) {
  level notify("hitVelocity");
  level endon("hitVelocity");
  end = startorg + velocity;
  var_a73107a327311aef = groundorg + ground_normal * 20;
  var_4be927b6d84b8823 = groundorg + fwd * 20;

  while(true) {
    line(startorg, end, (0, 1, 0));
    line(groundorg, var_a73107a327311aef, (1, 0, 1));
    line(groundorg, var_4be927b6d84b8823, (0, 1, 1));

    waitframe();
  }
}

function playerzombiejumpstop(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waittillframeend();

  if(isDefined(self.var_17c60a92aea65107)) {
    function_a1b195bc24dae315(powerstruct, "jump");
    return;
  }

  self notify("playerZombieJumpStop");
}

function filterdamage(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc) {
  if(!isDefined(eattacker)) {
    return undefined;
  }

  if(!istrue(level.brgametype.zombiesdamagezombies) && istrue(eattacker.iszombie) && istrue(victim.iszombie)) {
    return "zombieFriendlyFire";
  }
}

function get_ground_normal(traceignore, debug) {
  if(!isDefined(traceignore)) {
    ignore = self;
  } else {
    ignore = traceignore;
  }

  if(!isDefined(debug)) {
    debug = 0;
  }

  ignorelist = [ignore];
  tracepoints = [self.origin];
  i = -1;

  while(i <= 1) {
    j = -1;

    while(j <= 1) {
      corner = ignore getpointinbounds(i, j, 0);
      corner = (corner[0], corner[1], self.origin[2]);
      tracepoints[tracepoints.size] = corner;
      j += 2;
    }

    i += 2;
  }

  avgnormal = (0, 0, 0);
  tracehitcount = 0;

  foreach(point in tracepoints) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    tracehit = trace["fraction"] > 0 && trace["fraction"] < 1;

    if(tracehit) {
      avgnormal += trace["normal"];
      tracehitcount++;
    }

    if(debug) {
      if(tracehit) {
        line(point, point + trace["<dev string:xbc>"] * 30, (0, 1, 0));
        continue;
      }

      sphere(point, 3, (1, 0, 0));
    }
  }

  if(tracehitcount > 0) {
    avgnormal /= tracehitcount;

    if(debug) {
      line(self.origin, self.origin + avgnormal * 20, (1, 1, 1));
    }

    return avgnormal;
  }

  if(debug) {
    sphere(self.origin, 5, (1, 0, 0));
  }

  return undefined;
}

function playerzombiejumpcleanup(powerstruct, powerref, docooldown) {
  if(istrue(docooldown)) {
    thread playerpowerstartcooldown(powerstruct, powerref);
  }

  self.var_e11136acf00d18f = undefined;
  self.var_17c60a92aea65107 = undefined;
}

function playerzombiejumpmaxholdwarning(powerref, time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("playerZombieJumpChargeEnd");

  if(time <= 0) {
    return;
  }

  waittimes = scripts\mp\gametypes\br_circle::array_init_distribute(time, int(time * 5), 1);
  color = 1;

  for(i = 0; i < waittimes.size; i++) {
    if(color) {
      self.powershud[powerref].barelem.bar.color = (1, 0, 0);
    } else {
      self.powershud[powerref].barelem.bar.color = (0, 1, 0);
    }

    wait waittimes[i];
    color = !color;
  }
}

function playerhumanconcusspushplayer(victim, maxradius) {
  var_f508c8516e132d = 1800;
  inflictor = spawnStruct();
  inflictor.origin = self.origin;
  victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, self);
  victim thread playerpowerrestartallcooldowns(level.brgametype.zombie);
  dir = victim.origin - self.origin;
  angledir = vectortoangles(dir);
  dist = distance(victim.origin, self.origin);
  fraction = 1 - dist / maxradius;
  victim playerapplyjumpvelocity(angledir, var_f508c8516e132d, fraction);
}

function ignorevehicleexplosivedamage(data) {
  if(isexplosivedamagemod(data.meansofdeath) && data.objweapon.basename == "emp_drone_non_player_direct_mp" || data.objweapon.basename == "emp_drone_non_player_mp" || data.objweapon.basename == "emp_drone_player_mp") {
    return 1;
  }

  return 0;
}

function playerpowerrestartallcooldowns(powerstruct) {
  if(!isDefined(powerstruct)) {
    return;
  }

  self notify("disableCooldown");

  foreach(powerref, var_8723cff430a72c82 in powerstruct.powers) {
    if(!isDefined(self.powershud[powerref])) {
      continue;
    }

    self.powershud[powerref].incooldown = 0;
    thread function_120695737abd78f4(powerstruct, powerref);
  }
}

function superjumpfov() {
  player = self;
  player endon("death_or_disconnect");
  player notify("applyFOVPresentation");
  player endon("applyFOVPresentation");
  player lerpfovbypreset("zombiearcade");
  player waittill("endSuperJumpFov");
  player lerpfovbypreset("zombiedefault");
}

function addtoteamlives(player, team) {
  player playerupdatealivecounthuman();
}

function removefromteamlives(player, team) {
  player playerupdatealivecounthuman();
}

function playerisbecomingzombie() {
  return istrue(self.isbecomingzombie);
}

function laststandallowed(damagedata) {
  if(playeriszombie()) {
    var_eb938d26f29141aa = isDefined(damagedata.attacker) && damagedata.attacker namespace_27c39fecb94c2a6d::entisvehicle();

    if(!var_eb938d26f29141aa || !level.brgametype.zombievehiclelaststand) {
      return false;
    }

    thread namespace_27c39fecb94c2a6d::playerpowerrestartallcooldowns(level.brgametype.zombie);
    thread playerzombielaststandrevive();
    thread playerzombievehiclehittoss(damagedata);
    thread playerzombiedovehicledamageimmunity();
  }

  return true;
}

function playerzombievehiclehittoss(damagedata) {
  var_33a88760203205c8 = 500;
  var_7188c5ad86f4bcdb = 90;
  var_d511b11429292c8a = 60;
  const_offset = 30;
  hitdir = damagedata.direction_vec;
  var_7973ec383855b23b = vectortoyaw(hitdir);
  var_ee8d7fd04ae3145c = var_7188c5ad86f4bcdb;
  var_517b722235216a01 = var_d511b11429292c8a;

  if(cointoss()) {
    var_517b722235216a01 *= -1;
  }

  var_517b722235216a01 += var_7973ec383855b23b;
  var_50600b9245d45105 = (var_ee8d7fd04ae3145c, var_517b722235216a01, 0);
  var_19468a9f48671d17 = vectorNormalize((hitdir[0], hitdir[1], 0));
  startoffset = var_19468a9f48671d17 * const_offset + (0, 0, const_offset);
  namespace_27c39fecb94c2a6d::playerapplyjumpvelocity(var_50600b9245d45105, var_33a88760203205c8, 1, startoffset);
}

function playerzombiedovehicledamageimmunity() {
  self endon("disconnect");
  self.vehicledamageimmunity = 1;
  duration = getdvarfloat(@ "hash_e466123b801bd8d4", 1.5);
  wait duration;
  self.vehicledamageimmunity = undefined;
}

function playerzombielaststandrevive() {
  level endon("game_ended");
  self endon("last_stand_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_transition_done");
  waittillframeend();
  self setlaststandselfreviving(1);
  self.isselfreviving = 1;
  self.laststandreviveent makeunusable();
  triggerent = self.laststandreviveent;
  triggerent.usetime = getdvarfloat(@ "hash_ca5a718f09f3343f", 3) * 1000;

  if(!isDefined(triggerent.curprogress)) {
    triggerent.curprogress = 0;
  }

  while(isreallyalive(self) && triggerent.curprogress < triggerent.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(triggerent.userate)) {
      triggerent.userate = 0;
    }

    triggerent.curprogress += level.frameduration * triggerent.userate;
    triggerent.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(triggerent, 1);

    if(triggerent.curprogress >= triggerent.usetime) {
      break;
    }

    waitframe();
  }

  triggerent.usetime = undefined;
  triggerent.curprogress = undefined;
  triggerent.userate = undefined;
  scripts\mp\laststand::finishreviveplayer("self_revive_success", self);
  self playsoundtoplayer("zmb_breath_land_dropin", self, self);
  self playSound("zmb_npc_breath_land_dropin");
  self setlaststandselfreviving(0);

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("zombieDialog_playerRevived")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("zombieDialog_playerRevived", self);
  }
}

function function_758e2f92abfdfdd3(var_869d699197f920a2, var_7fd613fa13deec82) {
  if(isDefined(self) && isPlayer(self)) {
    if(istrue(var_7fd613fa13deec82)) {
      scriptables = getentitylessscriptablearray(undefined, undefined, undefined, undefined, var_869d699197f920a2);
    } else {
      scriptables = getentitylessscriptablearray("scriptable_" + var_869d699197f920a2, "classname");
    }

    if(playeriszombie()) {
      foreach(scriptable in scriptables) {
        scriptable disablescriptableplayeruse(self);
      }

      return;
    }

    foreach(scriptable in scriptables) {
      scriptable enablescriptableplayeruse(self);
    }
  }
}

function private function_e3c3b1fd15e0116a() {
  var_6e1ab2b17cc36743 = [];

  foreach(team in level.teamnamelist) {
    if(remainingplayersaliveonteam(team) > 0) {
      var_6e1ab2b17cc36743[var_6e1ab2b17cc36743.size] = team;
    }
  }

  return var_6e1ab2b17cc36743;
}

function postupdategameevents() {
  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }

  var_6e1ab2b17cc36743 = function_e3c3b1fd15e0116a();

  if(var_6e1ab2b17cc36743.size > 1) {
    return;
  }

  winnerteam = var_6e1ab2b17cc36743[0];

  if(isDefined(level.brgametype.var_8cfe7f196e21e100)) {
    remainingteams = 0;

    foreach(entry in level.teamnamelist) {
      var_849d01afb2fc0f0a = scripts\mp\gametypes\br::function_99e3948bfd8a99b8(entry);

      if(var_849d01afb2fc0f0a > 0) {
        remainingteams++;
      }
    }

    teamplacement = remainingteams + 1;
    var_8cfe7f196e21e100 = array_reverse(level.brgametype.var_8cfe7f196e21e100);

    foreach(entry in var_8cfe7f196e21e100) {
      teamplacement++;
    }
  }

  winnerplayers = scripts\mp\utility\teams::getteamdata(winnerteam, "players");

  foreach(player in winnerplayers) {
    player scripts\mp\gametypes\br_gametype_zxp::function_85ac199ed33991d6();
  }

  function_93d2f288e29b5dc7(winnerteam);
  thread scripts\mp\gamelogic::endgame(winnerteam, game["end_reason"]["enemies_eliminated"]);
}

function private function_93d2f288e29b5dc7(winnerteam) {
  if(!isDefined(winnerteam)) {
    return;
  }

  squadmates = scripts\mp\utility\teams::getteamdata(winnerteam, "players");

  if(!isDefined(squadmates)) {
    return;
  }

  foreach(squadmate in squadmates) {
    if(isDefined(squadmate) && squadmate playeriszombie()) {
      scripts\cp_mp\challenges::function_8359cadd253f9604(squadmate, "zxp_zombie_win", 1);
    }
  }
}

function sortbylastzombietime(left, right) {
  lefttime = level.teamdata[left]["lastZombieTime"];
  var_1b1911b9658c8a60 = level.teamdata[right]["lastZombieTime"];
  return lefttime >= var_1b1911b9658c8a60;
}

function function_e4cffb22a28408e2() {
  wait 5;
  scripts\cp_mp\utility\audio_utility::function_f1aed36ab4598ea("br_zxp");
}

function playerupdatealivecounthuman() {
  team = self.team;
  level.teamdata[team]["aliveCountHuman"] = 0;

  foreach(player in level.teamdata[team]["alivePlayers"]) {
    if(!player playeriszombie() && !player playerisbecomingzombie()) {
      level.teamdata[team]["aliveCountHuman"]++;
    }
  }
}