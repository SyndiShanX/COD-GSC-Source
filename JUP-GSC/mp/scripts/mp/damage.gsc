/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\damage.gsc
***********************************************/

#using script_15eddb0fac236a22;
#using script_32c2f4a699e57e1e;
#using script_3583ff375ab3a91e;
#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using script_5bc60484d17fa95c;
#using script_63634d9fa080435a;
#using script_67015c88c47ec4f8;
#using script_6cb0280f7aa7d3cd;
#using script_74b851b7aa1ef32d;
#using script_cbb0697de4c5728;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\dragonsbreath;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\equipment\throwstar;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bounty;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\cranked;
#using scripts\mp\damage;
#using scripts\mp\deathicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment\at_mine;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\equipment\binoculars;
#using scripts\mp\equipment\bunkerbuster;
#using scripts\mp\equipment\butterfly_mine;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment\molotov;
#using scripts\mp\equipment\nvg;
#using scripts\mp\equipment\throwing_knife_mp;
#using scripts\mp\equipment\trophy_system;
#using scripts\mp\equipment\wristrocket;
#using scripts\mp\events;
#using scripts\mp\final_killcam;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_ai_gulag;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_dom_gulag;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\war;
#using scripts\mp\heavyarmor;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\killcam;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\laststand;
#using scripts\mp\lightarmor;
#using scripts\mp\meatshield;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\headgear;
#using scripts\mp\perks\perk_mark_targets;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perks;
#using scripts\mp\perks\weaponpassives;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats_interface;
#using scripts\mp\plea_for_help;
#using scripts\mp\potg_events;
#using scripts\mp\rank;
#using scripts\mp\riotshield;
#using scripts\mp\shellshock;
#using scripts\mp\spawncamera;
#using scripts\mp\supers;
#using scripts\mp\supers\super_stimpistol;
#using scripts\mp\teamrevive;
#using scripts\mp\teams;
#using scripts\mp\tweakables;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;
#namespace damage;

function callback_playerdamage_internal(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {
  if(isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "worldspawn") {
    eattacker = undefined;
  }

  if(isDefined(eattacker) && isDefined(eattacker.gunner)) {
    eattacker = eattacker.gunner;
  }

  if(getdvarint(@ "hash_c36efcba0f21f379", 0) == 1 && isDefined(objweapon)) {
    baseweaponref = weapon::getweaponrootname(objweapon.basename);
    weaponlootid = scripts\cp_mp\utility\loot::getlootidfromref(baseweaponref);
    var_b2a4bce10dbbb085 = scripts\cp_mp\utility\loot::function_20be2251dd0a8076(weaponlootid);
    var_eaa882d1344e713 = weaponlootid == 39598 && level.gametype == "gold_gun" && istrue(eattacker.raygun);

    if(var_b2a4bce10dbbb085 && !var_eaa882d1344e713) {
      victim = eattacker;
    }
  }

  if((getgametype() == "defuse" || getgametype() == "hc_defuse") && smeansofdeath == "MOD_EXPLOSIVE" && objweapon.basename == "bomb_site_mp") {
    smeansofdeath = "MOD_SUICIDE";
    eattacker = self;
  }

  if(istrue(victim.plotarmor)) {
    function_403e958ecd04f255(victim, "isTrue( victim.plotArmor )");
    return;
  }

  if(isDefined(eattacker) && eattacker vehicle::isvehicle() && is_equal(eattacker.targetname, "veh_jup_space_shipment_transport")) {
    function_403e958ecd04f255(victim, "veh_jup_space_shipment_transport");
    return;
  }

  if(isDefined(victim.takedamage) && victim.takedamage == 0) {
    return;
  }

  if(player::isinlaststand(victim) && istrue(level.var_c53947782c7460f6)) {
    var_5f8fa6dbaf5f0e27 = istrue(level.var_9039ba619a4ab3e1) && smeansofdeath == "MOD_FALLING";
    var_5f8fa6dbaf5f0e27 |= istrue(level.var_b0830df5265878d5) && isPlayer(eattacker);
    var_5f8fa6dbaf5f0e27 |= istrue(level.var_7607dacdbd5ba02) && smeansofdeath == "MOD_TRIGGER_HURT" && (istrue(victim.islaststandbleedoutdmg) || istrue(victim.bleedout));
    var_5f8fa6dbaf5f0e27 |= istrue(level.var_425a393024ec491f) && smeansofdeath == "MOD_EXECUTION";

    if(!var_5f8fa6dbaf5f0e27) {
      if(istrue(level.var_74fe55f9c2b0222) && isDefined(eattacker) && isPlayer(eattacker)) {
        eattacker damagefeedback::updatedamagefeedback("hitnobulletdamage");
        eattacker playlocalsound("hit_marker_dud");
      }

      function_403e958ecd04f255(victim, "isInLastStand( victim ) && IsTrue( level.laststand_always_disable_damage )");
      return;
    }
  }

  if(br_dom_gulag::function_f79445ae166c7150(eattacker, victim) || br_ai_gulag::function_7b08c98431abda40(eattacker, victim)) {
    function_403e958ecd04f255(victim, "isInLastStand( victim ) && IsTrue( level.laststand_always_disable_damage )");
    return;
  }

  if(getdvarint(@ "hash_62a47106347dc9c3", 0) == 1) {
    function_403e958ecd04f255(victim, "<dev string:x1c>");
    return;
  }

  if(isDefined(victim.team)) {
    var_a993c42adf98794d = getdvarint(hashcat(@ "hash_cc6c5774be41ec78", utility::string(victim.team)), 0) != 0;

    if(var_a993c42adf98794d) {
      function_403e958ecd04f255(victim, "<dev string:x30>");
      return;
    }
  }

  if(getdvarint(@ "hash_45dd70c0ac1afda2", 0) != 0) {
    victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, 0);
    function_403e958ecd04f255(victim, "<dev string:x46>");
    return;
  }

  if(getdvarint(@ "scr_dmz_pve_enabled", 0) && isPlayer(eattacker) && isPlayer(victim) && eattacker != victim) {
    function_403e958ecd04f255(victim, "scr_dmz_pve_enabled 1");
    return;
  }

  if(istrue(victim.inlaststand) && istrue(level.laststandrequiresmelee) && smeansofdeath != "MOD_MELEE") {
    function_403e958ecd04f255(victim, "istrue( victim.inLastStand ) && istrue( level.lastStandRequiresMelee ) && sMeansOfDeath != MOD_MELEE");
    return;
  }

  var_fcdf19e3cdd29669 = victim.health;

  if(idflags & 16 && shitloc != "shield") {
    function_403e958ecd04f255(victim, "iDFlags &DFLAGS_STUN");
    return;
  }

  if(getdvarint(@ "hash_4b664c074a868ac5", 0)) {
    thread namespace_dfe80adf32f5c14a::function_5fe942e59dd07717(eattacker, victim, objweapon, smeansofdeath, vpoint, idamage);
  }

  shouldreturn = filterdamage(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, partname);

  if(isDefined(shouldreturn)) {
    function_403e958ecd04f255(victim, "filterDamage true, " + shouldreturn);
    return;
  }

  attackerishittingteammate = attackerishittingteam(victim, eattacker);
  iskillstreakweapon = isDefined(objweapon) && weapon::iskillstreakweapon(objweapon.basename);

  if(!istrue(level.allowprematchdamage)) {
    if(istrue(game["inLiveLobby"]) || !flags::gameflag("prematch_done") || istrue(level.infilcinematicactive)) {
      handledamagefeedback(einflictor, eattacker, victim, 0, smeansofdeath, objweapon, shitloc, idflags, 1, 1, iskillstreakweapon, undefined, vpoint);
      function_403e958ecd04f255(victim, "!istrue( level.allowPrematchDamage ) in prematch still");
      return;
    }
  }

  if(isDefined(level.var_2ceb2474be1c597e) && [[level.var_2ceb2474be1c597e]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1)) {
    return;
  }

  var_f754ceb1e24b2acd = isPlayer(victim) && victim function_fc05ebabfbf10e33() && smeansofdeath != "MOD_MEATSHIELD";

  if(istrue(var_f754ceb1e24b2acd)) {
    var_3418f54f3481ca60 = victim function_3be2afc5f1b4cd2d();

    if(attackerishittingteam(var_3418f54f3481ca60, eattacker)) {
      return;
    }

    if(smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH") {
      idamage = int(idamage * getdvarfloat(@ "hash_1dee446fa0921f47", 1));
    }

    victim meatshield::function_afdf3e6cbe0522d7(idamage, 0);
    eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, undefined, vpoint);
    var_6a7bec5bae7edfed = victim function_3be2afc5f1b4cd2d();

    if(!isDefined(var_6a7bec5bae7edfed)) {
      return;
    }

    idamage = 1;
    var_6a7bec5bae7edfed finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, undefined, 0);
    return;
  }

  var_5120869216e5bbbe = isPlayer(victim) && victim function_a237aba99cf26050() && smeansofdeath == "MOD_FALLING";

  if(istrue(var_5120869216e5bbbe)) {
    var_5e64a8df23fb6063 = victim function_3be2afc5f1b4cd2d();

    if(isDefined(var_5e64a8df23fb6063) && isPlayer(var_5e64a8df23fb6063)) {
      instantkill = victim.health <= idamage;
      meatshielddamage = idamage / var_5e64a8df23fb6063.maxhealth * var_5e64a8df23fb6063.var_423a9f9e23833f65;
      var_5e64a8df23fb6063 meatshield::function_afdf3e6cbe0522d7(meatshielddamage, instantkill);
    }
  }

  var_1a52fb785a04c793 = isDefined(einflictor) && einflictor vehicle::isvehicle() && !iskillstreakweapon && smeansofdeath == "MOD_EXPLOSIVE";

  if(attackerishittingteammate && !var_1a52fb785a04c793) {
    idamage = handlefriendlyfiredamage(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon);

    if(idamage == 0) {
      function_403e958ecd04f255(victim, "handleFriendlyFireDamage damage == 0");
      return;
    }
  }

  if(istrue(super_stimpistol::function_c61ee6d60763e771()) && istrue(super_stimpistol::function_76ca0b3d8b2555ca(objweapon)) && utility::isbulletdamage(smeansofdeath)) {
    idamage = 0;
    function_403e958ecd04f255(victim, "super_stimPistol_getHostileRevivesEnabled() && super_stimPistol_isStimPistol() && isBulletDamage()");
    return;
  }

  if(istrue(victim.spawnprotection) || victim function_f1dcadc8f7c3477c()) {
    var_d0d4ae57019e885d = smeansofdeath == "MOD_TRIGGER_HURT" || isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "trigger_hurt";
    wasfalldamage = smeansofdeath == "MOD_FALLING";
    wassuicidedamage = smeansofdeath == "MOD_SUICIDE";

    if(!var_d0d4ae57019e885d && !wasfalldamage && !wassuicidedamage) {
      handledamagefeedback(einflictor, eattacker, victim, 0, smeansofdeath, objweapon, shitloc, idflags, 1, 1, iskillstreakweapon, undefined, vpoint);
      function_403e958ecd04f255(victim, "( istrue( victim.spawnProtection ) || victim IsLastStandInvulnerable() ) && !wasHurtTrigger && !wasFallDamage");
      return;
    }
  }

  if(isDefined(eattacker) && istrue(eattacker.cranked)) {
    eattacker thread cranked::oncrankedhit(victim);
  }

  if(game_utility::getgametype() == "high") {
    if(smeansofdeath != "MOD_TRIGGER_HURT") {
      idamage = 0;
    }

    if(isDefined(objweapon) && objweapon.basename == "rock_mp") {
      victim knockback_flat(vdir, 250);
      eattacker thread scripts\mp\events::shothit();
    }
  }

  if(isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_origin" && isDefined(eattacker.type) && eattacker.type == "soft_landing") {
    function_403e958ecd04f255(victim, "eAttacker.classname == script_origin && eAttacker.type == soft_landing");
    return;
  }

  headshotmultiplier = 1;

  if(isDefined(var_be4285b26ed99ab1) && var_be4285b26ed99ab1 > 0) {
    headshotmultiplier = idamage / var_be4285b26ed99ab1;
  }

  idflags |= 4;

  if(isspreadweapon(objweapon) && damage_utility::validshotcheck(smeansofdeath, eattacker)) {
    if(dragonsbreath::isdragonsbreathweapon(objweapon) && (weapon::getweapongroup(objweapon) == "weapon_shotgun" || istrue(objweapon.isalternate) || getweaponhasperk(objweapon, "specialty_incendiary_alt"))) {
      victim thread dragonsbreathhitloccollection(shitloc, eattacker, objweapon);
    }

    if(getdvarint(@ "hash_4b664c074a868ac5", 0) && objweapon hasattachment("jup_ammo_127_db_arcade")) {
      victim thread dragonsbreathhitloccollection(shitloc, eattacker, objweapon);
    }

    idamage = spreadshotdamagemod(victim, eattacker, objweapon, idamage, idflags);

    if(idamage == 0) {
      function_403e958ecd04f255(victim, "isSpreadWeapon() && spreadShotDamageMod() iDamage == 0");
      return;
    }
  }

  weaponbasename = objweapon.basename;

  if(!isDefined(weaponbasename)) {
    assertmsg("<dev string:x5f>");
  }

  equiptype = getequipmenttype(objweapon);

  if(isDefined(equiptype)) {
    if(equiptype == "lethal") {
      idamage = lethalequipmentdamagemod(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon);
    } else if(equiptype == "equipment_other") {} else if(equiptype == "tactical") {}

    damagedata = damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, partname, undefined, idflags, undefined, shitloc);
    result = equipment::equiponplayerdamaged(damagedata);

    if(isDefined(result) && result == 0) {
      function_403e958ecd04f255(victim, "isDefined( getEquipmentType ) && equipOnPlayerDamaged() == false");
      return;
    }
  }

  if(victim game_utility::ismatchstartprotected()) {
    var_e0815ed56506a6a3 = isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "minefield_mp";
    wassuicide = smeansofdeath == "MOD_SUICIDE";

    if(!var_e0815ed56506a6a3 && !wassuicide) {
      var_54a24336cc9a143d = istrue(objweapon.isalternate);

      if(isDefined(equiptype) && !weapon::isthrowingknife(weaponbasename) || var_54a24336cc9a143d || smeansofdeath == "MOD_EXPLOSIVE") {
        damagelimit = int(max(victim.health / 5, 1));

        if(idamage >= damagelimit) {
          idamage = damagelimit;
        }
      }
    }
  }

  if(function_d75b73c443421047()) {
    if(objweapon.basename == "jup_jp14_pi_rsierra12_mp" && objweapon hasattachment("jup_ammo_127_db_arcade")) {
      idamage *= 1.6;
    }
  }

  weaptype = weapon::getweapontype(weaponbasename);

  if(isDefined(weaptype) && weaptype == "killstreak") {
    idamage = killstreakdamagefilter(eattacker, victim, idamage, objweapon, smeansofdeath);

    if(idamage == 0) {
      function_403e958ecd04f255(victim, "getWeaponType() == killstreak && iDamage == 0");
      return;
    }

    if(isDefined(level.gunshipplayer) && isDefined(eattacker) && level.gunshipplayer == eattacker) {
      level notify("ai_pain", victim);
    }
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(eattacker) && isDefined(eattacker.streakname) && eattacker.streakname == "emp_drone") {
    idamage = 0;
  }

  if(isDefined(level.var_5cb687ba43fb7102)) {
    foreach(func in level.var_5cb687ba43fb7102) {
      n_damage = self[[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime);

      if(isDefined(n_damage)) {
        idamage = n_damage;
      }
    }
  }

  idamage = handleriotshieldhits(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, iskillstreakweapon);
  [idamage, var_1da1a66b5c6a06a7] = modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, var_be4285b26ed99ab1, partname);
  [idamage, var_1da1a66b5c6a06a7] = function_694d74d8b5ac556f(eattacker, idamage, var_1da1a66b5c6a06a7, smeansofdeath, objweapon, victim);

  if(idamage == 0 && var_1da1a66b5c6a06a7 == 0) {
    function_403e958ecd04f255(victim, "iDamage == 0 && lightArmorDamage == 0");
    return;
  }

  if(dragonsbreath::isdragonsbreathweapon(objweapon) && !isspreadweapon(objweapon)) {
    victim thread function_c206c109a26f598(idamage + var_1da1a66b5c6a06a7, eattacker, objweapon, shitloc);
  } else if(crossbow::isthermitecrossbow(objweapon)) {
    victim thread function_5a05899bb304a6d4(shitloc, scripts\cp_mp\crossbow::function_42b0dfeb350f6ea5());
  }

  if(!istrue(victim.donotmodifydamage)) {
    modifieddamageresults = cac_modified_damage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, einflictor, 0, idflags, iskillstreakweapon, headshotmultiplier);
    idamage = modifieddamageresults[0];
    var_986b2e0350629522 = modifieddamageresults[1];
    armorhit = var_1da1a66b5c6a06a7 != 0 || var_986b2e0350629522 != 0;
    shitloc = modifieddamageresults[2];
  } else {
    var_986b2e0350629522 = 0;
    armorhit = 0;
  }

  if(!istrue(level.var_6ef7df34c802c174) && iskilltradedamage(eattacker, victim, idamage, smeansofdeath, objweapon, var_b0fc59ff15058522)) {
    function_403e958ecd04f255(victim, "isKillTradeDamage()");
    return;
  }

  if(isDefined(victim.forcehitlocation)) {
    shitloc = victim.forcehitlocation;
    victim.forcehitlocation = undefined;
  }

  if(isPlayer(eattacker) && (weaponbasename == "smoke_grenade_mp" || weapon::isthrowingknife(weaponbasename))) {
    eattacker thread gamelogic::threadedsetweaponstatbyname(weaponbasename, 1, "hits");
  }

  vdamagedir = vdir;

  if(isDefined(idflags) && idflags & 256 && idamage < self.health) {
    vdamagedir = victim.origin - eattacker.origin;
  }

  if(isenvironmentalscriptableinflictor(einflictor)) {
    idamage = 0;
  }

  if(isPlayer(eattacker)) {
    if(armor::armorvest_washit(eattacker) || helmet_washit(eattacker)) {
      if(idamage < victim.health) {
        idflags |= 512;
      }
    }

    if(armor::armorvest_wasbroke(eattacker) || helmet_wasbroke(eattacker)) {
      if(idamage < victim.health) {
        idflags |= 1024;
      }
    }
  }

  if(isDefined(level.onplayerdamaged_func)) {
    if(![[level.onplayerdamaged_func]](smeansofdeath)) {
      function_403e958ecd04f255(victim, "[[level.onPlayerDamaged_func]] == false");
      return;
    }
  }

  if(isDefined(einflictor) && isDefined(objweapon) && isDefined(einflictor.equipmentref)) {
    if(einflictor.equipmentref == "equip_throwstar") {
      idamage = throwstar::function_db4bbcfe23f19148(einflictor, victim, idamage, partname);
    }

    if(einflictor.equipmentref == "equip_throwing_knife") {
      scripts\mp\equipment\throwing_knife_mp::function_3ea0bf8465c74efc(victim, partname);
    }

    if(einflictor.equipmentref == "equip_throwing_knife" || einflictor.equipmentref == "equip_shuriken" || einflictor.equipmentref == "equip_throwstar") {
      if(istrue(einflictor.bwasunderwater)) {
        idamage = throwing_knife::function_3d8b0933df7505fd(victim);
      }

      if(scripts\engine\utility::issharedfuncdefined(#"hash_309e179113ce358b", #"hash_2984f255833c7f76") && victim _hasperk("specialty_close_quarter")) {
        idamage = [[scripts\engine\utility::getsharedfunc(#"hash_309e179113ce358b", #"hash_2984f255833c7f76")]](idamage, victim, eattacker, 1);
      }
    }
  }

  if(isDefined(eattacker) && eattacker _hasperk("specialty_super_strength") && smeansofdeath == "MOD_MELEE") {
    idamage = victim.maxhealth;
  }

  if(isjuggermoshgamemode() && isDefined(objweapon) && is_equal(objweapon.basename, "jup_jp23_me_swhiskey_mp")) {
    idamage = victim.maxhealth;
  }

  if(isDefined(objweapon)) {
    if(isDefined(eattacker) && isPlayer(eattacker)) {
      if(eattacker function_f3bb4f4911a1beb2("escort", "isDogZombie") && is_equal(eattacker, victim) && smeansofdeath != "MOD_SUICIDE" && (!isDefined(objweapon.basename) || objweapon.basename != "jackolantern")) {
        idamage = 0;
      }

      if(is_equal(objweapon.basename, "snowball")) {
        idamage = 0;
        victim setscriptablepartstate("shockStickVfx", "vfx_start", 0);
      }

      if(victim function_f3bb4f4911a1beb2("escort", "isDogZombie") && istrue(victim.var_286fe84c87d28222)) {
        idamage *= 0.5;
      }
    }
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.lifetimedamage)) {
    eattacker.lifetimedamage += idamage;
  }

  if(isDefined(victim) && isPlayer(victim) && !function_483cc81bff18273b(victim)) {
    victim.var_489f22c08f63bc0f += idamage;
  }

  if(isDefined(level.var_517ae1797c9e1995)) {
    idamage = [[level.var_517ae1797c9e1995]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon);
  }

  if(idamage >= 150 && isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
    var_f1c9098f9acad294 = getdvarint(@ "hash_6138625068b37f1", 0);
    var_884c40b361d66a39 = getdvarint(@ "hash_65b74a71a96e27ea", 0);

    if(var_f1c9098f9acad294 == 1) {
      idamage = 135;
      newdamage = getdvarint(@ "hash_fd334bd8d3ee773", 0);

      if(newdamage > 0) {
        idamage = newdamage;
      }

      if(var_884c40b361d66a39 && isbehindmeleevictim(eattacker, victim)) {
        idamage = 150;
      }

      if(scripts\engine\utility::issharedfuncdefined(#"hash_309e179113ce358b", #"hash_2984f255833c7f76") && victim _hasperk("specialty_close_quarter")) {
        idamage = [[scripts\engine\utility::getsharedfunc(#"hash_309e179113ce358b", #"hash_2984f255833c7f76")]](idamage, victim, eattacker, 0);
      }
    }
  }

  if(getdvarint(@ "hash_4b664c074a868ac5", 0)) {
    if(isheadshot(shitloc, smeansofdeath, eattacker)) {
      var_724fe920de761a93 = getdvarint(@ "hash_cf46cc4974f2df3", 1.37);
      idamage *= var_724fe920de761a93;
    }

    if(isDefined(eattacker) && eattacker == victim && smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
      if(objweapon hasattachment("jup_jp35_sn_moscar_bar_explode")) {
        idamage *= 0.3;
      }
    }
  }

  preplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdamagedir, shitloc, psoffsettime, modelindex, partname, var_1da1a66b5c6a06a7);
  victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdamagedir, shitloc, psoffsettime, modelindex, partname, armorhit);
  postplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdamagedir, shitloc, psoffsettime, modelindex, partname, var_1da1a66b5c6a06a7, var_986b2e0350629522, var_fcdf19e3cdd29669, iskillstreakweapon);
}

function dragonsbreathhitloccollection(hitloc, eattacker, objweapon) {
  self notify("newDragonsBreathHitLoc");
  self endon("newDragonsBreathHitLoc");
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.dragonsbreathdamage)) {
    self.dragonsbreathdamage = dragonsbreath::function_df4e9a1e313ea352();
  }

  self.dragonsbreathdamage.newhitlocs = utility::array_add(self.dragonsbreathdamage.newhitlocs, hitloc);
  waittillframeend();
  newhitlocs = [];

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.dragonsbreathdamage)) {
    newhitlocs = self.dragonsbreathdamage.newhitlocs;
    self.dragonsbreathdamage.newhitlocs = [];
  }

  if(isreallyalive(self)) {
    dragonsbreath::function_6dc8c5de229e86ff(newhitlocs, eattacker, objweapon);
    return;
  }

  dragonsbreath::function_56a694363da738ac(objweapon);
}

function preplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_1da1a66b5c6a06a7) {
  if(function_483cc81bff18273b(victim)) {
    return;
  }

  originaldamage = idamage;
  victim.lastweaponused = victim getcurrentweapon();
  victim.wasaimingdownsightsondamage = victim player::isplayerads();

  if(function_2f5049bbe3c5e733(objweapon, smeansofdeath)) {
    if(getdvarint(@ "hash_432df71393030be5", 0) == 1) {
      victim thread function_49d8cc008e5f6722(eattacker, victim, idflags);
    }

    if(isPlayer(eattacker)) {
      eattacker setclientomnvar("autofire_hit_notify", gettime());
    }
  }

  if(isai(self)) {
    assert(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["<dev string:xaf>"]));
    self[[level.bot_funcs["on_damaged"]]](eattacker, idamage, smeansofdeath, objweapon, einflictor, shitloc, vpoint, var_1da1a66b5c6a06a7);
  }

  if(isDefined(einflictor) && isDefined(einflictor.streakinfo) && isDefined(einflictor.streakinfo.hits)) {
    einflictor.streakinfo.hits++;
  }

  if(isDefined(objweapon) && objweapon.basename == "bunkerbuster_round_mp") {
    if(isDefined(einflictor) && isDefined(victim)) {
      var_84ca13f5a0250278 = distance(einflictor.origin, victim.origin);
      eattacker dlog_recordplayerevent("dlog_event_mp_bunkerbuster_expl_dist_to_enemy", ["victim", victim, "distance", var_84ca13f5a0250278], 0);
    }
  }

  perkfunctions::bulletoutlinecheck(eattacker, victim, objweapon.basename, smeansofdeath);

  if(smeansofdeath == "MOD_FALLING") {
    victim thread emitfalldamage(idamage);
  }

  logattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7);

  if(isDefined(einflictor) && isDefined(einflictor.owner) && isDefined(einflictor.owner.team) && einflictor.owner.team != victim.team) {
    victim.lastdamagewasfromenemy = 1;
  } else {
    victim.lastdamagewasfromenemy = isDefined(eattacker) && eattacker != victim;
  }

  if(victim.lastdamagewasfromenemy) {
    timestamp = gettime();

    if(isDefined(eattacker)) {
      eattacker.damagedplayers[victim.guid] = timestamp;
      eattacker.var_c826ab9d43c24233 = timestamp;
    }

    victim.lastdamagedtime = timestamp;
  }

  var_b94cd1b61321122a = 0;

  if(isDefined(victim) && isDefined(victim.currentprimaryweapon)) {
    var_b94cd1b61321122a = victim function_c603bed3b1c8d11(victim.currentprimaryweapon, 0);
  }

  victim.var_ddae1352e36165f6 = var_b94cd1b61321122a;
  victim thread potg_events::onplayerdamaged(eattacker, victim, smeansofdeath);
  victim thread challenges::playerdamaged(einflictor, eattacker, idamage, smeansofdeath, objweapon, shitloc);

  if(isDefined(eattacker) && idamage != 0) {
    eattacker notify("victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime);
  }

  if(isDefined(level.preplayerdamaged)) {
    victim thread[[level.preplayerdamaged]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
  }

  assertex(originaldamage == idamage, "<dev string:xbd>");
}

function function_2f5049bbe3c5e733(objweapon, meansofdeath) {
  var_f2c2804490dd2160 = isDefined(objweapon) && (weapontype(objweapon) == "bullet" || weapontype(objweapon) == "projectile");
  return game_utility::function_ba5574c7f287c587() && (var_f2c2804490dd2160 || meansofdeath == "MOD_MELEE");
}

function postplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_1da1a66b5c6a06a7, var_986b2e0350629522, var_fcdf19e3cdd29669, iskillstreakweapon) {
  originaldamage = idamage;
  bisbulletdamage = utility::isbulletdamage(smeansofdeath);

  if(getdvarint(@ "hash_fb388f508f5527e3", 0) == 1 && isDefined(eattacker) && isDefined(eattacker.origin)) {
    victim function_95874c67f460495f(eattacker.origin);
  }

  if(istrue(victim.var_808d06ddfc93a4e4)) {
    victim battlerage::function_903a8abde1f77240();
  }

  if(istrue(victim.disguised) && isDefined(eattacker)) {
    victim namespace_e0526929a9f43046::function_15e7a42c79a6b4f6(idamage, eattacker);
  }

  if(idamage > 10 && isDefined(einflictor) && !victim utility::isusingremote() && isPlayer(victim)) {
    if(isPlayer(einflictor) && smeansofdeath == "MOD_MELEE") {
      if(isalive(victim) && !victim killstreak::isjuggernaut() && !game_utility::isbrstylegametype()) {
        victim thread meleestagger(eattacker);
        victim.hitwithmeleetime = gettime();
      }

      einflictor thread shellshock::bloodmeleeeffect(objweapon);
      victim playRumbleOnEntity("defaultweapon_melee");
      einflictor playRumbleOnEntity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(killstreak::iscontrollingproxyagent()) {
      if(idamage >= self.health) {
        idamage = self.health - 1;
      } else {
        var_366b0ecc2f28aead = getcompleteweaponname(objweapon);
        self[[agent_utility::agentfunc("on_damaged_finished")]](einflictor, eattacker, idamage, idflags, smeansofdeath, var_366b0ecc2f28aead, vpoint, vdir, shitloc, psoffsettime);
      }
    } else {
      var_366b0ecc2f28aead = getcompleteweaponname(objweapon);
      self[[agent_utility::agentfunc("on_damaged_finished")]](einflictor, eattacker, idamage, idflags, smeansofdeath, var_366b0ecc2f28aead, vpoint, vdir, shitloc, psoffsettime);
    }
  } else {
    challenges::function_4ab6f9fba6bb9cc5(self, idamage, var_1da1a66b5c6a06a7);
  }

  if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587() && isPlayer(eattacker)) {
    scripts\cp_mp\challenges::function_f4d8c689aaf296e5(eattacker, objweapon, idamage, var_1da1a66b5c6a06a7);
  }

  handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, var_1da1a66b5c6a06a7, var_986b2e0350629522, iskillstreakweapon, partname, vpoint);
  handledamageeffects(idamage, eattacker, smeansofdeath, vpoint, var_1da1a66b5c6a06a7, objweapon);

  if(bisbulletdamage) {
    victim thread battlechatter_mp::adddamagetaken(eattacker, objweapon, idamage);
  }

  if(isagent(eattacker) && isDefined(eattacker) && eattacker player_utility::_isalive() && eattacker != victim) {
    victim thread battlechatter_mp::addrecentattacker(eattacker);
  }

  if(isDefined(victim) && victim player_utility::_isalive()) {
    if(victim.health < 30) {
      victim thread battlechatter_mp::hurtbadlywait();
    }

    if(isDefined(eattacker) && eattacker != victim && isexplosivedamagemod(smeansofdeath)) {
      var_a5269902cd18ca05 = isDefined(objweapon) && objweapon.basename == "safe_c4_mp";
      isgas = isDefined(objweapon) && objweapon.basename == "gas_mp";

      if(!isDefined(objweapon) || !isgas && !var_a5269902cd18ca05) {
        level thread battlechatter_mp::trysaylocalsound(victim, #"bc_flavor_player_surprise", undefined, 0.5);
      }
    }
  }

  gamelogic::sethasdonecombat(victim, 1);

  if(isDefined(eattacker) && eattacker != victim) {
    level.usestartspawns = 0;
  }

  if(isPlayer(eattacker) && isDefined(eattacker scripts\mp\utility\stats::getpersstat("participation"))) {
    eattacker scripts\mp\utility\stats::incpersstat("participation", 1);
  } else if(isPlayer(eattacker)) {
    eattacker.pers["participation"] = 1;
  }

  weapon_utility::function_c9e5c511b923a42f(idamage, eattacker, victim, smeansofdeath, shitloc, einflictor, vpoint, var_1da1a66b5c6a06a7, var_986b2e0350629522);

  if(isDefined(level.cinematic_replay_recording) && isPlayer(einflictor)) {
    recordstruct = spawnStruct();
    recordstruct.victim = victim;
    recordstruct.vpoint = vpoint;
    recordstruct.vdir = vdir;
    recordstruct.objweapon = objweapon;
    recordstruct.kill = !isalive(victim);
    einflictor.hitrecord[einflictor.hitrecord.size] = recordstruct;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isPlayer(victim) && isDefined(einflictor) && isPlayer(einflictor) && bisbulletdamage) {
    if(var_fcdf19e3cdd29669 == victim.maxhealth && victim.health != self.maxhealth) {
      victim.engagementstarttime = gettime();
    }
  }

  if(allowdamageflash(eattacker, victim, objweapon, smeansofdeath, idamage)) {
    victim showuidamageflash();
  }

  if(isDefined(eattacker) && idamage > 0) {
    if(eattacker perk::_hasperk("specialty_delayhealing")) {
      eattacker thread perk_mark_targets::marktarget_run(victim, objweapon, smeansofdeath);
    }

    if(isshrapnelsource(objweapon, smeansofdeath) && isreallyalive(victim) && eattacker != victim) {
      if(isDefined(eattacker.var_a3376181eed3ffac)) {
        regendelayseconds = eattacker.var_a3376181eed3ffac;
        targetdelayms = (level.healthregendelay + regendelayseconds) * 1000;
        delaymod = (targetdelayms / level.healthregendelay * 1000 - 1) / -1;
        scripts\cp_mp\playerhealth::function_5457f0107a845374("explosive_delay_perk", delaymod, targetdelayms);
      }

      if(istrue(eattacker.var_11554e20eb10a6dd)) {
        eattacker thread perkfunctions::function_dd4a053345e159c2(victim);
      }
    }

    if(bisbulletdamage || objweapon.basename == "throwstar_mp") {
      if(function_1f2e4ff84140d164(objweapon, eattacker) && damage_utility::islowerbodyshot(shitloc, smeansofdeath, eattacker) && !victim _hasperk("specialty_dauntless")) {
        eattacker thread perkfunctions::ammodisabling_run(victim, objweapon.basename == "throwstar_mp");
      }

      if(eattacker shouldmeleeslow(vdir, victim)) {
        eattacker thread function_fbd5b90ec07c28c4(victim);
      }
    }

    if(isPlayer(victim)) {
      if(super_stimpistol::function_76ca0b3d8b2555ca(objweapon) && utility::isbulletdamage(smeansofdeath) || eattacker perk::_hasperk("specialty_shrapnel") && isshrapnelsource(objweapon, smeansofdeath)) {
        victim.lastshrapneltime = gettime();
      }
    }
  }

  if(isDefined(level.onplayerdamaged)) {
    victim thread[[level.onplayerdamaged]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_1da1a66b5c6a06a7);
  }

  namespace_fd8ff6a1c9b4f3c7::function_d1e4826b0a4db6ee(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

  if(game_utility::function_6493ec89ae923684()) {
    level notify("post_player_damaged", einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
  }

  if(player::isreallyalive(victim)) {
    switch (smeansofdeath) {
      case #"hash_3c20f39c73a1422b":
      case #"hash_571e46e17a3cf2e3":
      case #"hash_66cb246f3e55fbe2":
      case #"hash_a911a1880d996edb":
      case #"hash_c22b13f81bed11f0":
        victim stats::incpersstat("explosionsSurvived", 1);

        if(getdvarint(@ "scr_live_ragdoll_on_explosives", 0) == 1) {
          if(isDefined(einflictor)) {
            testarray = function_347074f909e9dea5(einflictor, objweapon);

            if(testarray[0] == 1) {
              victim thread function_bf56dbd2a1035901(testarray.size);
            }
          }
        }

        break;
    }
  } else {
    if(isDefined(victim) && isDefined(einflictor) && scripts\mp\equipment\bunkerbuster::function_eae0802093a7e5f5(einflictor)) {
      if(isDefined(einflictor.vehicleent)) {
        victim function_b3bbb3a877d45df6(einflictor.vehicleent);
      }
    }

    if(isDefined(idflags) && isDefined(8) && idflags & 8 && isDefined(16384) && !(idflags & 16384)) {
      if(eattacker game_utility::onlinestatsenabled()) {
        wallbangs = eattacker playerstats_interface::getplayerstat("combatStats", "wallbangs") + 1;
        eattacker playerstats_interface::setplayerstatbuffered(wallbangs, "combatStats", "wallbangs");
      }

      if(isPlayer(eattacker)) {
        eattacker stats::incpersstat("penetrationKills", 1);
        eattacker stats::incpersstat("wallbangs", 1);
      }
    }
  }

  if(namespace_d36e6800233f4f97::function_cfe304859f30e747("gulagTrackPlayerBulletHitPlayer")) {
    namespace_d36e6800233f4f97::function_3cceb052d780fef1("gulagTrackPlayerBulletHitPlayer", eattacker);
  }

  if(isPlayer(victim) && isPlayer(eattacker)) {
    if(bisbulletdamage && eattacker _hasperk("specialty_combat_scout")) {
      attackerdamage = istrue(idamage > 0 || var_1da1a66b5c6a06a7 > 0 || var_986b2e0350629522 > 0);
      victim thread function_84c8fc967497800(eattacker, attackerdamage, objweapon);
    }
  }

  if(isDefined(einflictor) && isDefined(einflictor.sourcegrenade) && istrue(einflictor.sourcegrenade.bundle.var_5b4fa8f37a5d72d8)) {
    victim thread scripts\mp\equipment\butterfly_mine::function_6fed985972fc7a38(einflictor, eattacker);
  }

  if((getdvarint(@ "hash_4b664c074a868ac5", 0) || function_d75b73c443421047()) && objweapon.basename == "jup_jp14_pi_rsierra12_mp" && objweapon hasattachment("jup_ammo_127_db_arcade")) {
    eattacker namespace_dfe80adf32f5c14a::function_178a29a2b09ae82a(idamage, victim);
  }

  assertex(originaldamage == idamage, "<dev string:x11a>");
  sparams = {
    #var_1da1a66b5c6a06a7: var_1da1a66b5c6a06a7, #partname: partname, #shitloc: shitloc, #vdir: vdir, #vpoint: vpoint, #objweapon: objweapon, #smeansofdeath: smeansofdeath, #idflags: idflags, #idamage: idamage, #einflictor: einflictor, #eattacker: eattacker, #victim: victim
  };
  callback::callback("player_damaged", sparams);
}

function function_1f2e4ff84140d164(objweapon, eattacker) {
  if(objweapon hasattachment("ammomod_slow") || eattacker perk::_hasperk("specialty_wounding")) {
    return true;
  }

  return false;
}

function private function_347074f909e9dea5(einflictor, objweapon) {
  if(isDefined(einflictor.equipmentref)) {
    equipmentinfo = equipment::getequipmenttableinfo(einflictor.equipmentref);

    if(isDefined(equipmentinfo) && equipmentinfo.defaultslot == "primary") {
      return [1];
    }
  }

  if(isDefined(objweapon)) {
    if(weapon::iskillstreakweapon(objweapon)) {
      return [1, 1];
    }

    switch (objweapon.basename) {
      case #"hash_13a265ac820ea0df":
      case #"hash_3e782fd775b72022":
      case #"hash_5c272c0617caebf0":
      case #"hash_5cbb3a1a84d47f1d":
      case #"hash_6b9700922cc910a9":
      case #"hash_a9e31b8ffd42a67b":
      case #"hash_e704ecf8710c6f57":
      case #"hash_f55c20924061bd15":
        return [1];
    }
  }

  return [0];
}

function private function_bf56dbd2a1035901(knockdownintensity, isvehiclehit, velocity) {
  self endon("death_or_disconnect");

  if(!istrue(self.perkthirdperson)) {
    self setcamerathirdperson(1);
  }

  if(istrue(isvehiclehit)) {
    self function_babd8af3054d8abe("torso_upper", velocity);
    wait 3;
  } else {
    self function_360874d9808f0724();
    wait utility::ter_op(knockdownintensity == 2, 5, 3);
  }

  class::setthirdpersonview();
  self function_d87e1768229d0e3e();
}

function meleestagger_anglesviewattack(victim, attacker) {
  vdir = anglesToForward((0, victim getplayerangles()[1], 0));
  vattack = vectorNormalize((attacker.origin[0], attacker.origin[1], 0) - (victim.origin[0], victim.origin[1], 0));
  return math::anglebetweenvectorssigned(vdir, vattack, (0, 0, 1));
}

function isshrapnelsource(objweapon, meansofdeath) {
  if(!isDefined(objweapon) || isnullweapon(objweapon)) {
    return false;
  }

  if(!isexplosivedamagemod(meansofdeath)) {
    return false;
  }

  if(weapon::iskillstreakweapon(objweapon)) {
    return false;
  }

  if(weapon::isvehicleweapon(objweapon)) {
    return false;
  }

  if(weapon::isgamemodeweapon(objweapon)) {
    return false;
  }

  equipmenttype = weapon::getequipmenttype(objweapon);

  if(isDefined(equipmenttype)) {
    if(equipmenttype != "lethal") {
      return false;
    }
  }

  return true;
}

function meleestagger(attacker) {
  self endon("death_or_disconnect");
  var_989ea0994c0bafe0 = getdvarfloat(@ "melee_stagger_shock_duration");
  var_c0d3d09fb36a355e = getdvarfloat(@ "melee_stagger_aftershock_duration");
  var_e501fdb86740b153 = self getviewkickscale();

  if(isDefined(level.gamemodeoverridemeleeviewkickscale)) {
    self setviewkickscale(utility::ter_op(attacker perk::_hasperk("specialty_hardmelee"), level.gamemodeoverridemeleeviewkickscale * 2, level.gamemodeoverridemeleeviewkickscale));
  } else {
    self setviewkickscale(utility::ter_op(attacker perk::_hasperk("specialty_hardmelee"), 3, 1.5));
  }

  duration = utility::ter_op(attacker perk::_hasperk("specialty_hardmelee"), var_989ea0994c0bafe0 * 1.5, var_989ea0994c0bafe0);
  shellshock_utility::_shellshock("melee_mp", "damage", duration, 0, 0);
  yaw = 0;

  if(isDefined(attacker) && attacker player_utility::_isalive()) {
    angle = meleestagger_anglesviewattack(self, attacker);

    if(angle < 15) {
      yaw = 10;
    } else if(angle > -15) {
      yaw = -10;
    }
  }

  pitchscale = utility::ter_op(attacker perk::_hasperk("specialty_hardmelee"), 1.5, 1);
  self setplayerangles(self getplayerangles() + (-8 * pitchscale, yaw, 0));
  thread meleedofroutine(attacker);
  self earthquakeforplayer(0.35, 0.2, self.origin, 400);
  self playrumbleonpositionforclient("plr_rumble_4_mp", self.origin);
  self setclientomnvar("ui_hud_shake", 1);
  wait 0.05;
  self setviewkickscale(var_e501fdb86740b153);
  duration = utility::ter_op(attacker perk::_hasperk("specialty_hardmelee"), var_c0d3d09fb36a355e * 1.5, var_c0d3d09fb36a355e);
  shellshock_utility::_shellshock("melee_mp_after", "damage", duration, 0, 0);
}

function meleedofroutine(attacker) {
  self notify("resetMeleeDOF");
  self endon("resetMeleeDOF");
  self endon("death_or_disconnect");
  nearstart = 1;
  nearend = 2;
  farstart = 350;
  farend = 1024;
  self setdepthoffield(nearstart, nearend, farstart, farend, 10, 9);
  var_989ea0994c0bafe0 = getdvarfloat(@ "melee_stagger_shock_duration");
  wait utility::ter_op(attacker perk::_hasperk("specialty_hardmelee"), var_989ea0994c0bafe0 * 3, var_989ea0994c0bafe0);

  while(farend > 350) {
    nearstart = clamp(nearstart - 100, 0, 10000);
    nearend = clamp(nearend - 100, 0, 10000);
    farstart = clamp(farstart - 100, 0, 10000);
    farend = clamp(farend - 100, 0, 10000);
    self setdepthoffield(nearstart, nearend, farstart, farend, 10, 9);
    wait 0.05;
  }

  player::setdof_default();
}

function monitormeleeoverlay(overlay) {
  utility::waittill_any_timeout_1(2, "death_or_disconnect");
  overlay destroy();
}

function allowdamageflash(attacker, victim, objweapon, meansofdeath, damage) {
  if(isagent(victim)) {
    return false;
  }

  if(function_816434396dce13f(victim)) {
    return false;
  }

  if(damage == 0) {
    return false;
  }

  if(suppressdamageflash(attacker, victim, objweapon, meansofdeath, damage)) {
    return false;
  }

  return true;
}

function suppressdamageflash(attacker, victim, objweapon, meansofdeath, damage) {
  if(isDefined(objweapon)) {}

  return false;
}

function weaponignoresbrarmor(attacker, victim, damage, objweapon, smeansofdeath, inflictor, shitloc) {
  weaponbasename = objweapon.basename;

  if(isDefined(weaponbasename) && weaponbasename == "danger_circle_br") {
    return true;
  }

  if(smeansofdeath == "MOD_EXECUTION") {
    return true;
  }

  if(smeansofdeath == "MOD_MELEE_TAKEDOWN") {
    return true;
  }

  if(smeansofdeath == "MOD_FALLING") {
    return true;
  }

  return false;
}

function function_7b2f2a8a9aa41d44(weaponbasename) {
  return isDefined(weaponbasename) && weaponbasename == "danger_circle_br";
}

function cac_modified_damage(victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query, idflags, iskillstreakweapon, headshotmultiplier) {
  assert(isPlayer(victim) || isagent(victim));
  assert(function_483cc81bff18273b(victim) || isDefined(victim.team));
  victim notify("damage_begin", attacker);

  if(!isDefined(headshotmultiplier)) {
    headshotmultiplier = 1;
  }

  damageadd = 0;
  var_986b2e0350629522 = 0;
  var_7820f81ee1adf7b9 = victim armor::hasarmor();
  var_c258168e026adb0f = victim armor::hashelmet();

  if(isPlayer(attacker)) {
    helmet_clearhit(attacker);
    helmet_clearbroke(attacker);
  }

  if(utility::isbulletdamage(smeansofdeath)) {
    weaponbasename = objweapon.basename;
    headshot = damage_utility::isheadshot(shitloc, smeansofdeath, attacker);
    torsoshot = damage_utility::istorsoshot(shitloc, smeansofdeath, attacker);

    if(isDefined(objweapon) && weapon::iscacprimaryorsecondary(weaponbasename)) {
      if(isbehindmeleevictim(attacker, victim) && isPlayer(victim)) {
        level thread battlechatter_mp::saytoself(victim, "plr_hit_back", undefined, 0.1);
      }
    }

    if(isDefined(idflags) && idflags & 256) {
      if(weaponbasename != "none" && !weapon::issuperweapon(weaponbasename)) {
        damage *= 0.4;
      }
    }

    if(isPlayer(attacker) && attacker perk::_hasperk("specialty_paint_pro") && !istrue(iskillstreakweapon)) {
      victim thread perkfunctions::setpainted(attacker);
    }

    if(weapon::isminigunweapon(weaponbasename) && game_utility::isbrstylegametype()) {
      damage *= br_jugg_common::getminigundamagescale();
    }

    hitarmorvest = torsoshot && victim perk::_hasperk("specialty_armorvest");
    var_946cdaf05db4eca7 = headshot && var_c258168e026adb0f;
    hithelmet = headshot && istrue(victim.hasheadgear);
    var_287ab4d602b23a2a = istrue(attacker.lastcrossbowhadstoppingpower) && weapon::getweaponrootname(objweapon) == "iw9_dm_crossbow";
    var_2b1f3da5885ae9eb = attacker perk::_hasperk("specialty_bulletdamage") || var_287ab4d602b23a2a;
    armorpiercing = isfmjdamage(objweapon, smeansofdeath);

    if(var_946cdaf05db4eca7 && !istrue(victim.inlaststand)) {
      attackerweaponclass = weaponclass(objweapon);
      snipershot = 0;

      if(attackerweaponclass == "sniper" || attackerweaponclass == "dmr") {
        snipershot = 1;
      }

      var_f74a43b699b0afd2 = victim armor::damagehelmet(damage, snipershot, impactdir);
      damage *= var_f74a43b699b0afd2;
    }

    if(var_2b1f3da5885ae9eb && hitarmorvest) {
      armor::armorvest_sethit(attacker);
    } else if(var_2b1f3da5885ae9eb && damage > 0) {
      if(damage <= 0) {
        assertmsg("<dev string:x178>");
      } else {
        damagenew = applystoppingpower(objweapon, shitloc, smeansofdeath, attacker, damage, 100);
        damageadd += damagenew - damage;
      }
    } else if(hitarmorvest && !istrue(victim.tookvesthit) && !armorpiercing) {
      victim.tookvesthit = 1;
      damagenew = adjustbulletstokill(damage, 100, level.armorvestbulletdelta);
      damageadd += damagenew - damage;
      helmet_sethit(attacker);
    } else if(hithelmet && !armorpiercing) {
      damagemod = headgear::getdamagemod();
      maxdamage = headgear::getmaxdamage();
      damagehelmet = int(clamp(damage * damagemod, 1, maxdamage));

      if(victim.health > 1) {
        damagehelmet = int(min(victim.health - 1, damagehelmet));
      }

      var_a97d0ca28da74569 = damage - damagehelmet;
      damageadd -= var_a97d0ca28da74569;
      victim notify("headgear_save");
      helmet_sethit(attacker);
    }

    if(isDefined(attacker) && isDefined(attacker.vehicleparent) && attacker.vehicleparent == "loot_chopper") {
      damage = int(damage / 3);
    }

    if(istrue(victim.undying)) {
      if(damage >= victim.health) {
        victim.health = int(clamp(damage + 1, 1, victim.maxhealth));
      }
    }

    if(attacker perk::_hasperk("specialty_headhunter") && headshot) {
      if(headshotmultiplier <= 1) {
        damage += 10;
      } else {
        disttovictim = distance(attacker.origin, victim.origin);

        if(disttovictim < level.var_a7b25d0a3d5b8f1e) {
          damage += 20 * headshotmultiplier;
        } else if(disttovictim < level.var_a7b25d0a3d5b8f1e) {
          damage += 15 * headshotmultiplier;
        } else {
          damage += 10 * headshotmultiplier;
        }
      }
    }
  } else if(smeansofdeath == "MOD_FALLING") {
    if(perk::_hasperk("specialty_falldamage")) {
      damage = 0;
    }
  }

  var_d089499e6152ef2c = trophy_system::trophy_modifieddamage(attacker, victim, objweapon.basename, damage, damageadd);
  damage = var_d089499e6152ef2c[0];
  damageadd = var_d089499e6152ef2c[1];

  if(victim heavyarmor::hasheavyarmor()) {
    var_d089499e6152ef2c = heavyarmor::heavyarmormodifydamage(victim, attacker, damage, damageadd, smeansofdeath, objweapon.basename, impactpoint, impactdir, shitloc, inflictor, query);
    var_986b2e0350629522 = var_d089499e6152ef2c[0] > 0;
    damage = var_d089499e6152ef2c[1];
    damageadd = var_d089499e6152ef2c[2];
  }

  if(lightarmor::haslightarmor(victim)) {
    var_d089499e6152ef2c = lightarmor::lightarmor_modifydamage(victim, attacker, damage, damageadd, smeansofdeath, objweapon.basename, impactpoint, impactdir, shitloc, inflictor, query);
    var_1da1a66b5c6a06a7 = var_d089499e6152ef2c[0] > 0;
    damage = var_d089499e6152ef2c[1];
    damageadd = var_d089499e6152ef2c[2];
  }

  if(isPlayer(attacker)) {
    var_1bd99d39b987c15e = victim armor::hasarmor();
    var_3cfc0e54103a3f72 = victim armor::hashelmet();

    if(var_7820f81ee1adf7b9 && !var_1bd99d39b987c15e) {
      armor::armorvest_setbroke(attacker);
    }

    if(var_c258168e026adb0f && !var_3cfc0e54103a3f72) {
      helmet_setbroke(attacker);
    }
  }

  if(hashealthshield(victim)) {
    damage = victim gethealthshielddamage(damage);
  }

  fatalfalldamage = smeansofdeath == "MOD_FALLING" && damage >= victim.maxhealth;
  var_ff20188c5460f129 = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

  if(istrue(victim.inlaststand) && !fatalfalldamage) {
    if(var_ff20188c5460f129 && (objweapon.basename == "semtex_mp" || objweapon.basename == "bunkerbuster_not_burrowed_mp")) {} else {
      damage = int(ceil(damage * getmatchrulesdata("commonOption", "lastStandDamageTakenScalar")));
    }
  }

  if(damage <= 1) {
    damage = int(ceil(clamp(damage, 0, 1)));
  } else {
    damage = int(damage + damageadd);
  }

  if(victim killstreak::isjuggernaut()) {
    damage = modify_juggernaut_damage(victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query, idflags, iskillstreakweapon);

    if(damage >= self.health && istrue(self.var_9c1941d3bc009d2e)) {
      self.var_9c1941d3bc009d2e = 0;
      thread scripts\mp\juggernaut::jugg_removejuggernaut();
      damage = 0;
    }
  }

  return [damage, var_986b2e0350629522, shitloc];
}

function modify_blast_shield_damage(damage, attacker, victim, var_463424d8c7b063d4) {
  if(isDefined(var_463424d8c7b063d4)) {
    var_2d0e5379ab68da90 = int(min(victim.flakjackethealth, var_463424d8c7b063d4 * damage));
    victim.flakjackethealth -= var_2d0e5379ab68da90;
    victim notify("blast_shield_damaged", victim.flakjackethealth);

    if(victim.flakjackethealth <= 0) {
      victim perkfunctions::breakflakjacket();
    }

    return (damage - var_2d0e5379ab68da90);
  }

  blastdamagemod = level.blastshieldmod;
  var_1422fd8555ab8bf0 = level.blastshieldclamp;
  var_46381c94b0138dc7 = int(damage * blastdamagemod);

  if(attacker != victim) {
    var_46381c94b0138dc7 = clamp(var_46381c94b0138dc7, 0, var_1422fd8555ab8bf0);
  }

  return var_46381c94b0138dc7;
}

function modify_juggernaut_damage(victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query, idflags, iskillstreakweapon) {
  attackerweaponclass = weaponclass(objweapon);
  damagescale = 1;

  if(isDefined(attacker) && attacker killstreak::isjuggernaut() && game_utility::isbrstylegametype()) {
    damagescale = br_jugg_common::getjuggdamagescale();
  } else if(game_utility::function_21322da268e71c19()) {
    damagescale = 1.25;
  }

  if(utility::isbulletdamage(smeansofdeath)) {
    var_b4a7d8cd8c4fb7da = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    switch (attackerweaponclass) {
      case #"hash_719417cb1de832b6":
      case #"hash_900cb96c552c5e8e":
        damage = min(15, damage);
        break;
      case #"hash_8cdaf2e4ecfe5b51":
      case #"hash_fa24dff6bd60a12d":
        if(weapon::isminigunweapon(objweapon.basename)) {
          damage = min(50, damage);
        } else {
          damage = min(20, damage);
        }

        break;
      case #"hash_690c0d6a821b42e":
        damage = min(25, damage);
        break;
      case #"hash_6191aaef9f922f96":
        break;
      case #"hash_e224d0b635d0dadd":
        if(var_b4a7d8cd8c4fb7da) {
          damage = int(self.maxhealth * 0.05);
        }

        break;
      default:
        damage = min(15, damage);
        break;
    }

    damage = handleapdamage(objweapon, smeansofdeath, damage, attacker);
  } else if(isexplosivedamagemod(smeansofdeath)) {
    damage = function_10268164ab1bcc31(damage, objweapon, attacker);
    weaponref = objweapon.basename;
    var_b4a7d8cd8c4fb7da = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    switch (weaponref) {
      case #"hash_996849dc6e47c18f":
        damage *= 0.25;
        break;
      case #"hash_e4dc94c459367249":
        damage *= 1.5;
        break;
      case #"hash_4b87af60037f526f":
        if(istrue(var_b4a7d8cd8c4fb7da)) {
          damage = int(self.maxhealth * 0.1);
        }

        break;
      case #"hash_ab3485fa6834de47":
        if(istrue(var_b4a7d8cd8c4fb7da)) {
          damage = int(self.maxhealth * 0.011);
        }

        break;
    }
  } else if(utility::isfiredamage(smeansofdeath)) {
    weaponref = objweapon.basename;
    var_b4a7d8cd8c4fb7da = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    switch (weaponref) {
      case #"hash_8fd6158eb96a1f15":
      case #"hash_b2a8e1829f433bd7":
        if(istrue(var_b4a7d8cd8c4fb7da)) {
          damage = int(self.maxhealth * 0.023);
        }

        break;
    }

    damage = function_5e4aa8d548cc604e(damage, objweapon, attacker, smeansofdeath);
  } else if(utility::isimpactdamage(smeansofdeath)) {
    switch (attackerweaponclass) {
      case #"hash_e224d0b635d0dadd":
        damage = min(10, damage);
        break;
      case #"hash_2ab98cab4066a74e":
        damage = min(100, damage);
        break;
    }
  } else if(utility::isvehiclecrushdamage(inflictor, smeansofdeath)) {
    if(!isDefined(victim.var_59651a2893429638)) {
      victim.var_59651a2893429638 = 0;
    }

    damage = min(50, damage);
    victim.var_59651a2893429638++;

    if(victim.var_59651a2893429638 >= 30) {
      [newpos, newdir] = vehicle_occupancy::function_9d86fd9a89cd2702(victim, inflictor, victim.origin, 1);

      if(isDefined(newpos)) {
        victim setOrigin(newpos);
        victim.var_59651a2893429638 = undefined;
      }
    }
  }

  damage = int(damage * damagescale);

  if(isDefined(self.var_a23031c04df01bf)) {
    victim[[self.var_a23031c04df01bf]](damage, shitloc, smeansofdeath, attacker);
  }

  victim thread function_1b7b7da2e72eeffe(attacker, damage, smeansofdeath, objweapon);

  return damage;
}

function modifydestructibledamage(damage, inflictor, objweapon) {
  if(!isDefined(inflictor)) {
    return damage;
  }

  if(!isnullweapon(objweapon)) {
    return damage;
  }

  if(!isDefined(inflictor.code_classname) || inflictor.code_classname != "scriptable") {
    return damage;
  }

  classname = inflictor.classname;

  if(isDefined(classname) && isstartstr(classname, "scriptable_")) {
    classname = getsubstr(classname, 11, classname.size);
    classnames = ["uk_gas_tank_thin_cylinder", "uk_misc_fuel_jug", "uk_fire_extinguisher", "uk_misc_fuel_jug", "decor_barrels_gameplay_flammable", "un_propane_gas_tank", "machinery_oxygen_generator_tank", "sol_barrel", "box_wooden_grenade", "container_gas_tank", "decor_propane_tank", "equipment_propane_burner_stove", "equipment_propane_tank", "misc_propane_rocket", "oil_drum", "rp_propane_tank", "misc_exterior_oxygen_barrel"];

    foreach(_classname in classnames) {
      if(isstartstr(classname, _classname)) {
        if(game_utility::isanymlgmatch()) {
          return 0;
        }

        return int(min(damage, 60));
      }
    }
  }

  return damage;
}

function iskilltradedamage(eattacker, victim, idamage, smeansofdeath, objweapon, var_b0fc59ff15058522) {
  if(isDefined(eattacker) && isPlayer(eattacker) && (!isalive(eattacker) || player::function_d7afe062ef51bd77(eattacker))) {
    if(istrue(var_b0fc59ff15058522) && isspreadweapon(objweapon)) {
      return true;
    } else if(idamage >= victim.health) {
      if(smeansofdeath == "MOD_MELEE") {
        return true;
      } else if(istrue(var_b0fc59ff15058522)) {
        return true;
      }
    }
  }

  return false;
}

function isspreadweapon(objweapon) {
  return isDefined(objweapon) && isDefined(weaponclass(objweapon)) && weaponclass(objweapon) == "spread";
}

function function_2be5b08ed39d6a54(eattacker, victim, objweapon) {
  if(objweapon.basename == "semtex_bolt_splash_mp" && isDefined(victim.var_ea445bb2097eaa16) && isDefined(eattacker) && utility::array_contains(victim.var_ea445bb2097eaa16, eattacker)) {
    return true;
  }

  return false;
}

function issmallsplashdamage(objweapon) {
  if(objweapon.basename == "semtex_xmike109_splash_mp" || objweapon.basename == "thermite_xmike109_radius_mp" || objweapon.basename == "semtex_bolt_splash_mp" || objweapon.basename == "thermite_bolt_radius_mp") {
    return 1;
  }

  return 0;
}

function spreadshotdamagemod(victim, eattacker, objweapon, idamage, idflags) {
  if(isDefined(eattacker) && isDefined(victim)) {
    hand = function_88e9e2299bd29fd1(idflags);
    victimentnum = function_d77e6b2580f74622(victim);
    time = gettime();

    if(!isDefined(eattacker.pelletweaponvictimids)) {
      eattacker.pelletweaponvictimids = [];
    }

    foreach(ihand, var_25762ef6bb7ced23 in eattacker.pelletweaponvictimids) {
      foreach(victimid, victimstruct in var_25762ef6bb7ced23) {
        if((time - victimstruct.time) / 1000 > 0.1) {
          eattacker.pelletweaponvictimids[ihand] = utility::array_remove_key(eattacker.pelletweaponvictimids[ihand], victimid);

          if(eattacker.pelletweaponvictimids[ihand].size == 0) {
            eattacker.pelletweaponvictimids = utility::array_remove_key(eattacker.pelletweaponvictimids, ihand);
          }
        }
      }
    }

    if(!isDefined(eattacker.pelletweaponvictimids[hand])) {
      eattacker.pelletweaponvictimids[hand] = [];
    }

    if(!isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
      eattacker.pelletweaponvictimids[hand][victimentnum] = function_c415d83582aad1e4(eattacker, objweapon, time);
    }

    eattacker.pelletweaponvictimids[hand][victimentnum].var_7981f7d372990a2b = 0;
    eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed = array_sort_with_func(eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed, &is_lower);

    if(eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed.size >= eattacker.pelletweaponvictimids[hand][victimentnum].var_33ac4c9665be6910) {
      if(idamage > eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0]) {
        damagedelta = idamage - eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0];
        eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0] = idamage;
        eattacker.pelletweaponvictimids[hand][victimentnum].var_7981f7d372990a2b = 1;
        idamage = damagedelta;
      } else {
        return 0;
      }
    } else {
      eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed = array_insert(eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed, idamage, 0);
    }

    idamage = function_1113fc99a0327d7d(eattacker, victim, idflags, idamage);
  }

  return idamage;
}

function function_c415d83582aad1e4(eattacker, objweapon, time) {
  struct = spawnStruct();
  struct.time = time;
  struct.pelletdmgpassed = [];
  struct.var_9bb59738d095536e = 0;
  struct.var_33ac4c9665be6910 = getspreadpelletspershot(eattacker, objweapon);

  if(objweapon hasattachment("trigger_heavy_p14")) {
    struct.var_52f16f4c9cdbf165 = 300;
  } else if(function_a062727999a72d2f(objweapon.basename)) {
    struct.var_52f16f4c9cdbf165 = 120;
  } else {
    struct.var_52f16f4c9cdbf165 = 200;
  }

  return struct;
}

function is_lower(a, b) {
  return a < b;
}

function getspreadpelletspershot(eattacker, objweapon) {
  rootname = weapon::getweaponrootname(objweapon.basename);

  if(rootname == "iw9_sh_charlie725" || rootname == "iw9_pi_swhiskey" || rootname == "jup_jp16_sh_recho870") {
    if(eattacker isdualwielding()) {
      return 2;
    }

    if(objweapon hasattachment("bar_sh_short_p14")) {
      return 3;
    }

    ads = eattacker playerads() > 0.5;
    tacstance = 0;

    if(rootname == "jup_jp16_sh_recho870") {
      tacstance = eattacker function_c603bed3b1c8d11(objweapon, 0);
    }

    if(ads || tacstance) {
      return 4;
    } else {
      return 3;
    }

    return;
  }

  if(objweapon hasattachment("jup_ammo_410g_ball")) {
    return 2;
  }

  if(rootname == "jup_jp35_sn_moscar" && objweapon hasattachment("jup_jp35_sn_moscar_bar_blund")) {
    return 20;
  }

  if(rootname == "jup_jp38_sh_spapa12" && objweapon hasattachment("jup_spapa12_selectsemi_bolo")) {
    return 20;
  }

  return 4;
}

function helmet_washit(attacker) {
  return isDefined(attacker.hithelmet) && gettime() == attacker.hithelmet;
}

function helmet_sethit(attacker) {
  attacker.hithelmet = gettime();
}

function helmet_clearhit(attacker) {
  attacker.hithelmet = undefined;
}

function helmet_wasbroke(attacker) {
  return isDefined(attacker.brokehelmet) && gettime() == attacker.brokehelmet;
}

function helmet_setbroke(attacker) {
  attacker.brokehelmet = gettime();
}

function helmet_clearbroke(attacker) {
  attacker.brokehelmet = undefined;
}

function applystoppingpower(objweapon, shitloc, smeansofdeath, attacker, damage, maxhealth) {
  maxhealth = tweakables::gettweakablevalue("player", "maxhealth");
  bulletstokill = getbulletstokill(maxhealth, damage);

  if(bulletstokill == 2) {
    if(stoppingpowercanonehitkill(objweapon, shitloc, smeansofdeath, attacker)) {
      return maxhealth;
    } else {
      return (0.9 * maxhealth);
    }
  }

  var_585a576d50c69137 = -1;

  if(bulletstokill >= 7) {
    var_585a576d50c69137 = -3;
  } else if(bulletstokill >= 5) {
    var_585a576d50c69137 = -2;
  }

  return adjustbulletstokill(damage, maxhealth, var_585a576d50c69137);
}

function stoppingpowercanonehitkill(objweapon, shitloc, smeansofdeath, attacker) {
  weaponrootname = weapon::getweaponrootname(objweapon);
  sweaponclass = weaponclass(objweapon);

  if(weaponrootname == "iw9_dm_crossbow") {
    return true;
  } else if(sweaponclass == "sniper") {
    switch (weaponrootname) {
      case #"hash_6bc7a937030008a":
      case #"hash_fbeff8fdb669137d":
        if(damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker) || damage_utility::isheadshot(shitloc, smeansofdeath, attacker)) {
          return true;
        }

        break;
      case #"hash_1f3b9e13f5e1433c":
      case #"hash_3bab3553abce2fd1":
      case #"hash_ec99e7d11ddb9eea":
        if(damage_utility::istorsoshot(shitloc, smeansofdeath, attacker) || damage_utility::isheadshot(shitloc, smeansofdeath, attacker)) {
          return true;
        }

        break;
      default:
        if(damage_utility::isupperbodyshot(shitloc, smeansofdeath, attacker) || damage_utility::isheadshot(shitloc, smeansofdeath, attacker)) {
          return true;
        }

        break;
    }
  } else if(sweaponclass == "pistol") {
    switch (weaponrootname) {
      case #"hash_bf2d3ffce9ef56d1":
      case #"hash_daf5a16da560ec6d":
        if(damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker) || damage_utility::isheadshot(shitloc, smeansofdeath, attacker)) {
          return true;
        }

        break;
    }
  } else if(sweaponclass == "rifle") {
    switch (weaponrootname) {
      case #"hash_3a523c4bbb66256a":
      case #"hash_5a18d10b44f6c48c":
        if(damage_utility::isheadshot(shitloc, smeansofdeath, attacker)) {
          return true;
        }

        break;
    }

    ammotype = getweaponammopoolname(objweapon);

    if(ammotype == % "hash_a9efef52b466ad3" || ammotype == % "hash_6aa606a18241ad16") {
      if(damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker) || damage_utility::isheadshot(shitloc, smeansofdeath, attacker)) {
        return true;
      }
    }
  }

  return false;
}

function adjustbulletstokill(damage, maxhealth, delta) {
  damage = int(damage);
  delta = int(delta);

  if(delta == 0) {
    return damage;
  }

  if(damage <= 0) {
    assertmsg("<dev string:x1bf>");
    return damage;
  }

  var_59d4cbb2ee26e823 = getbulletstokill(maxhealth, damage);
  var_8242953f0e099baf = var_59d4cbb2ee26e823 + delta;

  if(var_8242953f0e099baf <= 0) {
    damage *= 1.4;
  } else if(var_8242953f0e099baf == 1) {
    damage = int(max(maxhealth, damage * 1.4));
  } else {
    var_febf29b2b2d803fa = utility::ter_op(damage > maxhealth, maxhealth, damage);
    percent = 0;

    if(var_59d4cbb2ee26e823 == 1) {
      percent = 0.9;
    } else {
      var_69489bad55e2b1a7 = int(ceil(maxhealth / (var_59d4cbb2ee26e823 - 1)));
      var_99ca83094b92bb05 = int(ceil(maxhealth / var_59d4cbb2ee26e823));
      percent = (var_febf29b2b2d803fa - var_99ca83094b92bb05) / (var_69489bad55e2b1a7 - var_99ca83094b92bb05);
    }

    var_6606d7544e8b2f6b = int(ceil(maxhealth / (var_8242953f0e099baf - 1)));
    var_e06a97413f959bb1 = int(ceil(maxhealth / var_8242953f0e099baf));
    damage = int((var_6606d7544e8b2f6b - var_e06a97413f959bb1) * percent + var_e06a97413f959bb1);
  }

  return damage;
}

function getbulletstokill(maxhealth, damage) {
  return int(ceil(maxhealth / damage));
}

function isbehindmeleevictim(attacker, victim) {
  var_b3e4c19e4d37bea0 = vectorNormalize((victim.origin[0], victim.origin[1], 0) - (attacker.origin[0], attacker.origin[1], 0));
  fwdvic = anglesToForward((0, victim.angles[1], 0));
  return vectordot(var_b3e4c19e4d37bea0, fwdvic) > 0.4;
}

function killstreakdamagefilter(eattacker, victim, idamage, objweapon, smeansofdeath) {
  var_b4d4d1947da73e65 = 0;

  if(isDefined(level.gamemodespawnprotectedcallback)) {
    var_b4d4d1947da73e65 = [[level.gamemodespawnprotectedcallback]](eattacker, victim, idamage, objweapon, smeansofdeath);
  }

  if(victim game_utility::isspawnprotected() || istrue(var_b4d4d1947da73e65)) {
    damagelimit = int(max(victim.health / 4, 1));

    if(idamage >= damagelimit && weapon::iskillstreakweapon(objweapon.basename) && !weapon::weaponbypassspawnprotection(objweapon) && smeansofdeath != "MOD_MELEE") {
      idamage = damagelimit;
    }
  }

  return idamage;
}

function function_b1493282af6c1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  var_b51ab50e109ad01a = 0;

  if(isDefined(objweapon)) {
    switch (objweapon.basename) {
      case #"hash_db653a4972b3c13b":
        if(isDefined(einflictor) && entity::isdronepackage(einflictor)) {
          var_b51ab50e109ad01a = 1;
        }

        break;
      case #"hash_1eb643f396ea8577":
      case #"hash_1ed1da8a2c218aa7":
      case #"hash_507c24a8f53354fe":
      case #"hash_5e3fa526a48eaaa5":
        var_b51ab50e109ad01a = 1;
        break;
    }
  }

  return var_b51ab50e109ad01a;
}

function handlefriendlyfiredamage(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon) {
  if(isDefined(einflictor) && !isPlayer(einflictor)) {
    if(!isDefined(eattacker)) {
      if(isDefined(einflictor.owner)) {
        eattacker = einflictor.owner;
      }
    } else if(!isPlayer(eattacker)) {
      if(isDefined(einflictor.owner)) {
        eattacker = einflictor.owner;
      } else if(isDefined(eattacker.owner)) {
        eattacker = eattacker.owner;
      }
    }
  }

  if(isDefined(objweapon)) {
    if(utility::isbulletdamage(smeansofdeath) && (weapon::iscacprimaryweapon(objweapon.basename) || weapon::iscacsecondaryweapon(objweapon.basename)) && !super_stimpistol::function_76ca0b3d8b2555ca(objweapon)) {
      level thread battlechatter_mp::trysaylocalsound(victim, #"bc_combat_inform_check_fire_ally", undefined, 0.25);
    }

    if(super_stimpistol::function_76ca0b3d8b2555ca(objweapon)) {
      return 0;
    }
  }

  if(game_utility::function_21322da268e71c19()) {
    if(isDefined(idflags) && idflags & 256 && utility::isbulletdamage(smeansofdeath)) {
      idamage = int(idamage * 0.2);
    }
  }

  if(level.friendlyfire != 0) {
    if(level.maxallowedteamkills == -1) {
      var_685cac64e1726643 = 0;
    } else {
      var_685cac64e1726643 = istrue(victim.isffprotectedaction) || istrue(victim.isdefusing) || istrue(victim.isplanting);
    }

    var_c7f72fff4c765948 = isfriendlyfireprotectedperiod(eattacker);

    if(var_685cac64e1726643 || var_c7f72fff4c765948) {
      idamage = int(idamage * 0.5);

      if(idamage < 1) {
        idamage = 1;
      }

      if(idamage > victim.health) {
        idamage = victim.health;
      }

      eattacker.lastdamagewasfromenemy = 0;

      if(isDefined(eattacker scripts\mp\utility\stats::getpersstat("teamdamage"))) {
        eattacker stats::incpersstat("teamdamage", idamage);
      }

      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isPlayer(eattacker) && level.friendlyfire != 1) {
    if(function_7cc9753f2f84e883(eattacker, victim)) {
      eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, undefined, vpoint);
    }

    return 0;
  } else if(level.friendlyfire == 1) {
    if(idamage < 1) {
      idamage = 1;
    }

    victim.lastdamagewasfromenemy = 0;

    if(isspreadweapon(objweapon) && damage_utility::validshotcheck(smeansofdeath, eattacker)) {
      if(dragonsbreath::isdragonsbreathweapon(objweapon) && (weapon::getweapongroup(objweapon) == "weapon_shotgun" || istrue(objweapon.isalternate))) {
        victim thread dragonsbreathhitloccollection(shitloc, eattacker, objweapon);
      }
    }

    logfriendlyfire(victim, eattacker, idamage, smeansofdeath);
    victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
    eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, undefined, vpoint);
    return 0;
  } else if(level.friendlyfire == 2) {
    idamage = int(idamage * 0.5);

    if(idamage < 1) {
      idamage = 1;
    }

    eattacker.lastdamagewasfromenemy = 0;

    if(!function_b1493282af6c1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname)) {
      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
    }

    return 0;
  } else if(level.friendlyfire == 3) {
    idamage = int(idamage * 0.5);

    if(idamage < 1) {
      idamage = 1;
    }

    victim.lastdamagewasfromenemy = 0;
    eattacker.lastdamagewasfromenemy = 0;

    if(isspreadweapon(objweapon) && damage_utility::validshotcheck(smeansofdeath, eattacker)) {
      if(dragonsbreath::isdragonsbreathweapon(objweapon) && (weapon::getweapongroup(objweapon) == "weapon_shotgun" || istrue(objweapon.isalternate))) {
        victim thread dragonsbreathhitloccollection(shitloc, eattacker, objweapon);
      }
    }

    logfriendlyfire(victim, eattacker, idamage, smeansofdeath);
    victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    if(!function_b1493282af6c1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname)) {
      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
    }

    eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, undefined, vpoint);
    return 0;
  } else if(level.friendlyfire == 4) {
    var_399ac373783533b5 = !function_b1493282af6c1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    if(var_399ac373783533b5 && isDefined(eattacker scripts\mp\utility\stats::getpersstat("teamdamage")) && self.team == eattacker.team) {
      teamdamage = int(idamage);

      if(idamage > victim.health) {
        teamdamage = victim.health;
      }

      var_ee03b1094657a1ca = !istrue(eattacker.pers["didHitFFPunishLimit"]) && iskillstreakweapon;

      if(!var_ee03b1094657a1ca) {
        eattacker stats::incpersstat("teamdamage", teamdamage);
      }

      var_490bde8509585600 = isDefined(level.var_843399bee19793fe) && level.var_843399bee19793fe > 0;

      if(var_490bde8509585600 && istrue(eattacker.pers["didHitFFPunishLimit"])) {
        eattacker hud_message::showerrormessage("MP/FRIENDLY_FIRE_KICK_WARNING");

        if(eattacker.pers["teamdamage"] - eattacker.pers["totalFFDamageDoneBeforePunish"] >= level.var_843399bee19793fe) {
          if(!istrue(eattacker.pers["didHitFFKickLimit"])) {
            eattacker.pers["didHitFFKickLimit"] = 1;
          } else if(istrue(eattacker.connected)) {
            kick(eattacker getentitynumber(), "EXE/PLAYERKICKED_TEAMKILLS");
            return 0;
          }
        }
      } else if(isDefined(level.var_dc3c7c5627a11e5e) && level.var_dc3c7c5627a11e5e > 0) {
        if(!istrue(eattacker.var_321f6ff131ffbb72) && eattacker.pers["teamdamage"] >= level.var_dc3c7c5627a11e5e) {
          eattacker.var_321f6ff131ffbb72 = 1;
          eattacker hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
        }
      }
    }

    var_554d89e1b2d5128b = isDefined(level.var_6706aad138cbc31d) && level.var_6706aad138cbc31d > 0;
    var_189a3d91f762202b = isDefined(eattacker.pers["teamkills"]) && eattacker.pers["teamkills"] >= level.maxallowedteamkills;

    if(!var_189a3d91f762202b && var_554d89e1b2d5128b) {
      var_189a3d91f762202b = isDefined(eattacker.pers["teamdamage"]) && eattacker.pers["teamdamage"] >= level.var_6706aad138cbc31d;
    }

    if(var_189a3d91f762202b && var_399ac373783533b5) {
      idamage = int(idamage * 0.5);

      if(idamage < 1) {
        idamage = 1;
      }

      eattacker.lastdamagewasfromenemy = 0;
      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

      if(!istrue(eattacker.pers["didHitFFPunishLimit"])) {
        eattacker.pers["didHitFFPunishLimit"] = 1;
        eattacker.pers["totalFFDamageDoneBeforePunish"] = eattacker.pers["teamdamage"];
      }

      return 0;
    }
  }

  return idamage;
}

function isfriendlyfireprotectedperiod(attacker) {
  if(isDefined(level.gametype) && level.gametype == "havoc") {
    return false;
  }

  if(game_utility::isanymlgmatch() && !istrue(level.var_ec2fb549b15ad827)) {
    return false;
  }

  if(level.ingraceperiod) {
    return true;
  }

  if(isDefined(attacker) && isDefined(attacker.pers) && isDefined(attacker.pers["teamkills"]) && attacker.pers["teamkills"] > 1 && game_utility::gettimepassed() < level.graceperiod * 1000 + 8000 + attacker.pers["teamkills"] * 1000) {
    return true;
  }

  return false;
}

function damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(eattacker player_utility::_isalive()) {
    eattacker.friendlydamage = 1;
    eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
    eattacker.friendlydamage = undefined;
  }
}

function mlghitlocrequiresclamp(shitloc) {
  return shitloc == "head" || shitloc == "helmet" || shitloc == "neck";
}

function mlgmodifyheadshotdamage(eattacker, idamage, smeansofdeath, objweapon, shitloc, idflags) {
  if(game_utility::isanymlgmatch() && isDefined(eattacker) && isPlayer(eattacker) && !isnullweapon(objweapon) && weapon::isprimaryweapon(objweapon) && utility::isbulletdamage(smeansofdeath) && mlghitlocrequiresclamp(shitloc)) {
    if(idflags & 262144) {
      weapondamagetype = 2;
    } else {
      weapondamagetype = 0;
    }

    switch (objweapon.classname) {
      case #"hash_719417cb1de832b6":
      case #"hash_8cdaf2e4ecfe5b51":
      case #"hash_900cb96c552c5e8e":
      case #"hash_fa24dff6bd60a12d":
        idamage = int(clamp(idamage, 0, objweapon getmaxdamage(weapondamagetype) * 1.3));
        break;
    }
  }

  return idamage;
}

function modifyfalldamage(victim, idamage, idflags, smeansofdeath) {
  modifieddamage = idamage;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
    if(istrue(victim.falldamageprotection)) {
      modifieddamage = 0;
    } else if(victim scripts\mp\utility\killstreak::isjuggernaut() || getdvarint(@ "hash_f1b2bd0a1fa58a73", 0)) {
      modifieddamage = victim juggernaut::jugg_modifyfalldamage();
    } else if(victim namespace_1f2efdb89e5f3a6e::function_95adb84c5ca51c36() || istrue(self.var_b6aa5954bf6a457a)) {
      modifieddamage = victim namespace_1f2efdb89e5f3a6e::function_3a307fd8eb4f27eb();
    } else if(istrue(victim.iszombie)) {
      modifieddamage = 0;
    } else if(idflags & 32768 && modifieddamage >= victim.health) {
      modifieddamage = victim.health - 1;
    } else if(victim ismutationgamemodezombie()) {
      if(victim function_f3bb4f4911a1beb2("game", "hasMutationModePerk02")) {
        victim function_f3bb4f4911a1beb2("game", "activateMutationModePerk02");
      }

      modifieddamage = 0;
    } else if(modifieddamage < victim.maxhealth) {
      modifieddamage = modifieddamage / victim.maxhealth * modifieddamage / victim.maxhealth * victim.maxhealth;
      thread damage_effects::falldamageeffects(modifieddamage);

      if(istrue(self.var_808d06ddfc93a4e4)) {
        if(isDefined(level.var_6ca69a7226d8f8b5)) {
          modifieddamage *= level.var_6ca69a7226d8f8b5;
        } else {
          modifieddamage = 0;
        }
      } else if(modifieddamage >= victim.health) {
        modifieddamage = victim.health - 1;
      }
    }
  }

  return modifieddamage;
}

function modifyvehicletoplayerdamage(einflictor, eattacker, victim, idamage, smeansofdeath) {
  modifieddamage = idamage;

  if(isDefined(einflictor) && einflictor vehicle::isvehicle()) {
    if(victim killstreak::isjuggernaut()) {
      modifieddamage = victim juggernaut::jugg_modifyvehicletoplayerdamage(idamage, smeansofdeath);
    }

    if(getdvarint(@ "hash_ec8cd89141ead8d9", 0) == 1) {
      velocity = einflictor vehicle_getvelocity();
      modifieddamage = victim.health - 1;

      if(victim.health > 0) {
        victim thread function_bf56dbd2a1035901(undefined, 1, velocity);
      }
    }
  }

  return modifieddamage;
}

function function_53b212d296370f7(victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon) {
  modifieddamage = idamage;
  vehicle = victim player_utility::getvehicle();

  if(isDefined(vehicle)) {
    modifieddamage = vehicle_damage::function_9cac3af67ee6b40a(vehicle, victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon);
  }

  return modifieddamage;
}

function modifycrushdamage(einflictor, eattacker, victim, idamage, smeansofdeath) {
  modifieddamage = idamage;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH") {
    if(isDefined(einflictor) && isDefined(eattacker) && einflictor == eattacker && eattacker killstreak::isjuggernaut() && victim killstreak::isjuggernaut()) {
      modifieddamage = victim juggernaut::jugg_modifyherodroptoplayerdamage(idamage);
    }
  }

  return modifieddamage;
}

function function_754e680a5b56b39e(eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1) {
  modifieddamage = idamage;

  if(isDefined(eattacker) && isDefined(smeansofdeath) && isDefined(objweapon)) {
    if(dragonsbreath::function_cfd2e1e48edaf93(objweapon)) {
      objweapon = eattacker weapon_utility::function_1e3102980c3a4cc1(objweapon);

      if(!isspreadweapon(objweapon)) {
        victimhealth = victim.health;
        modifieddamage = var_be4285b26ed99ab1;

        if(modifieddamage >= victimhealth) {
          modifieddamage = victimhealth - 1;
        }
      }
    }
  }

  return modifieddamage;
}

function function_2aa2c49ee1702368(eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, einflictor) {
  if(!game_utility::function_21322da268e71c19()) {
    return idamage;
  }

  data = damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor);

  if(victim damage_utility::isstuckdamagekill(data)) {
    return idamage;
  }

  if(victim killstreak::isjuggernaut()) {
    return idamage;
  }

  equiptype = weapon::getequipmenttype(objweapon);

  if(isDefined(equiptype)) {
    if(equiptype == "lethal") {
      idamage = function_88c7467b96144afd(objweapon, idamage);
    } else if(equiptype == "equipment_other") {} else if(equiptype == "tactical") {}
  }

  if(utility::isbulletdamage(smeansofdeath)) {
    idamage = function_18b0510fbca05ff7(objweapon, idamage);
  }

  if((isDefined(objweapon.basename) && objweapon.basename == "jup_jp26_la_mike32_mp" || objweapon.basename == "bunkerbuster_round_gl_mp") && smeansofdeath == "MOD_GRENADE_SPLASH") {
    idamage *= 0.2;
  }

  return idamage;
}

function private function_88c7467b96144afd(objweapon, damage) {
  dvarstringbase = @ "hash_303dbc969fd35e79";

  if(isDefined(objweapon.basename)) {
    dvarstring = hashcat(dvarstringbase, objweapon.basename);
    defaultratio = self.maxhealth / 150;
    damage *= getdvarfloat(dvarstring, defaultratio);
  }

  return damage;
}

function private function_18b0510fbca05ff7(objweapon, damage) {
  dvarstringbase = @ "hash_303dbc969fd35e79";

  if(isDefined(objweapon.classname)) {
    dvarstring = hashcat(dvarstringbase, objweapon.classname);
    damageratio = getdvarfloat(dvarstring, 0);
    damage *= utility::ter_op(damageratio == 0, 1, damageratio);
  }

  if(isDefined(objweapon.basename)) {
    dvarstring = hashcat(dvarstringbase, objweapon.basename);
    damageratio = getdvarfloat(dvarstring, 0);
    damage *= utility::ter_op(damageratio == 0, 1, damageratio);
  }

  return damage;
}

function function_49f3d4de0e352093(inflictor, attacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc) {
  modifieddamage = idamage;
  iskillstreakweapon = istrue(weapon::iskillstreakweapon(objweapon));
  isfraggrenade = issubstr(objweapon.basename, "frag_grenade");

  if(isfraggrenade) {
    assert(smeansofdeath == "<dev string:x21e>" || smeansofdeath == "<dev string:x22d>" || smeansofdeath == "<dev string:x243>", "<dev string:x251>" + smeansofdeath);
  }

  if(iskillstreakweapon && victim == attacker && isDefined(inflictor) && isDefined(inflictor.streakname) && (inflictor.streakname == "switchblade_drone" || inflictor.streakname == "drone_swarm") && !getdvarint(@ "hash_926870a17bc1e11f", 0)) {
    return 0;
  }

  if(isexplosivedamagemod(smeansofdeath)) {
    if(isPlayer(attacker)) {
      if(attacker != victim && attacker perk::_hasperk("specialty_paint") && !iskillstreakweapon) {
        victim thread perkfunctions::setpainted(attacker);
      }
    }

    modifieddamage = modifydestructibledamage(modifieddamage, inflictor, objweapon);
    modifieddamage = claymore::claymore_modifieddamage(victim, objweapon, inflictor, smeansofdeath, modifieddamage);
    modifieddamage = at_mine::at_mine_modified_damage(victim, inflictor, objweapon, smeansofdeath, modifieddamage);
    modifieddamage = cluster_spike::function_723aa6329b751bc7(victim, inflictor, objweapon, smeansofdeath, modifieddamage);

    if(ismutationgamemode() && attacker function_f3bb4f4911a1beb2("game", "hasMutationModePerk02") && isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "jup_mutant_leap_emp_impact_mp" && istrue(objweapon.var_f08578daebccf4a2)) {
      modifieddamage *= getdvarfloat(@ "hash_2c41f83a90ac7dcf", 1);
    }

    if(issharedfuncdefined(#"super_landmine", #"modifydamage", 1)) {
      modifieddamage = [[getsharedfunc(#"super_landmine", #"modifydamage")]](victim, inflictor, objweapon, smeansofdeath, modifieddamage);
    }

    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      switch (objweapon.basename) {
        case #"hash_34e7a4cd11aed6bc":
        case #"hash_d072a0adddda0068":
          if(isDefined(victim) && modifieddamage >= victim.health) {
            if(isDefined(attacker)) {
              attacker damagefeedback::updatedamagefeedback("");
            }

            modifieddamage = 0;
          }

          break;
        case #"hash_7f7c5fcf3fba0bea":
          modifieddamage = 0;
          break;
      }
    }

    var_c7fe40d41a2e7963 = arraycontains(victim.loadoutperks, "specialty_eod_vest");

    if(issharedfuncdefined("thermobaric_grenade", "thermobaric_additional_explosive_damage")) {
      modifieddamage += [[getsharedfunc("thermobaric_grenade", "thermobaric_additional_explosive_damage")]](victim, attacker, modifieddamage);
    }

    if(isPlayer(attacker) && weaponinheritsperks(objweapon) && attacker perk::_hasperk("specialty_explosivedamage") && victim perk::_hasperk("specialty_blastshield")) {} else if(isPlayer(attacker) && weaponinheritsperks(objweapon) && !iskillstreakweapon && attacker perk::_hasperk("specialty_explosivedamage")) {
      modifieddamage += modifieddamage * level.explosivedamagemod;
    } else if((var_c7fe40d41a2e7963 || victim perk::_hasperk("specialty_blastshield")) && !damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, shitloc)) {
      if(var_c7fe40d41a2e7963) {
        assert(victim perk::_hasperk("<dev string:x288>"), "<dev string:x2a1>");
      }

      var_46381c94b0138dc7 = modify_blast_shield_damage(modifieddamage, attacker, victim, victim.var_8cbe63a199e19de);
      victim perks::activateperk("specialty_eod");
      modifieddamage = max(var_46381c94b0138dc7, 1);
    }

    if(isDefined(level.lethaldelay) && !equipment::lethaldelaypassed()) {
      modifieddamage *= level.graceperiodgrenademod;
    }
  }

  return modifieddamage;
}

function function_112ee98a4faca19a(inflictor, attacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc) {
  modifieddamage = idamage;

  if(smeansofdeath == "MOD_FIRE") {
    if(victim perk::_hasperk("specialty_blastshield") && !damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, shitloc)) {
      var_46381c94b0138dc7 = modify_blast_shield_damage(modifieddamage, attacker, victim, victim.var_fb1106d94cc95901);
      victim perks::activateperk("specialty_eod");
      modifieddamage -= modifieddamage - var_46381c94b0138dc7;
    }
  }

  return modifieddamage;
}

function function_7e8906e2dab3d41e(inflictor, attacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc) {
  modifieddamage = idamage;

  if(isDefined(objweapon) && isDefined(smeansofdeath) && victim _hasperk("specialty_super_protection")) {
    weaponref = objweapon.basename;
    attackerweaponclass = weaponclass(objweapon);
    var_b4a7d8cd8c4fb7da = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    if(isDefined(weaponref) && isDefined(attackerweaponclass)) {
      if(isbulletdamage(smeansofdeath)) {
        switch (attackerweaponclass) {
          case #"hash_e224d0b635d0dadd":
            if(istrue(var_b4a7d8cd8c4fb7da)) {
              modifieddamage = min(1, idamage);
            }

            break;
        }
      } else if(isimpactdamage(smeansofdeath)) {
        if(isDefined(attackerweaponclass)) {
          switch (attackerweaponclass) {
            case #"hash_2ab98cab4066a74e":
              modifieddamage = min(self.maxhealth, idamage);
              break;
          }
        }
      } else if(isexplosivedamagemod(smeansofdeath)) {
        switch (weaponref) {
          case #"hash_ab3485fa6834de47":
            if(istrue(var_b4a7d8cd8c4fb7da)) {
              modifieddamage = min(5, idamage);
            }

            break;
        }
      } else if(isfiredamage(smeansofdeath)) {
        var_b4a7d8cd8c4fb7da = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

        switch (weaponref) {
          case #"hash_4c7de5619284e175":
          case #"hash_8fd6158eb96a1f15":
          case #"hash_b2a8e1829f433bd7":
            if(istrue(var_b4a7d8cd8c4fb7da)) {
              modifieddamage = min(5, idamage);
            }

            break;
        }
      }
    }

    if(modifieddamage > 0) {
      modifier = isagent(attacker) ? getdvarfloat(@ "hash_aca7f88b7bc0b97d", 0) : getdvarfloat(@ "hash_82cc9b0ec1f12017", 0);
      modifieddamage = int(modifieddamage * modifier);

      if(modifieddamage == 0) {
        attacker damagefeedback::updatedamagefeedback("hitnobulletdamage");
        attacker playlocalsound("hit_marker_dud");
      }
    }
  }

  if(isDefined(objweapon) && isDefined(smeansofdeath) && smeansofdeath != "MOD_FALLING" && modifieddamage < victim.maxhealth && victim _hasperk("specialty_battlerage_reduce_damage")) {
    modifieddamage = int(modifieddamage * getdvarfloat(@ "hash_1bd8b2e40fb683f9", 0.9));
  }

  return modifieddamage;
}

function function_2856696941de9271(objweapon, partname) {
  partname = scripts\cp_mp\utility\damage_utility::function_edefa1e693dd3c7d(partname);
  var_1ec00613d5b61d24 = objweapon.basename == "throwstar_mp_jup" || objweapon.basename == "throwingknife_mp" || objweapon.basename == "bunkerbuster_mp" || objweapon.isalternate && objweapon.underbarrel == "ub_gl01";
  return var_1ec00613d5b61d24 && function_b656251147d7d40b(partname);
}

function modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, var_be4285b26ed99ab1, partname) {
  unmodifieddamage = idamage;
  idamage = mlgmodifyheadshotdamage(eattacker, idamage, smeansofdeath, objweapon, shitloc, idflags);
  idamage = modifyfalldamage(victim, idamage, idflags, smeansofdeath);
  idamage = modifyvehicletoplayerdamage(einflictor, eattacker, victim, idamage, smeansofdeath);
  idamage = function_53b212d296370f7(victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon);
  idamage = modifycrushdamage(einflictor, eattacker, victim, idamage, smeansofdeath);
  idamage = function_754e680a5b56b39e(eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1);
  idamage = function_2aa2c49ee1702368(eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, einflictor);
  idamage = function_49f3d4de0e352093(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc);
  idamage = function_112ee98a4faca19a(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc);
  idamage = function_7e8906e2dab3d41e(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc);

  if(isDefined(level.modifyplayerdamage)) {
    idamage = int([[level.modifyplayerdamage]](einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1));
  }

  [idamage, var_1da1a66b5c6a06a7] = armor::function_90ce8eb3ddaa4943(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_be4285b26ed99ab1, unmodifieddamage, partname);

  if(isPlayer(eattacker) && eattacker != self) {
    if(isbrstylegametype() && !isbot(self)) {
      eattacker thread namespace_4925be476a433a59::function_e08012bdba393c79(objweapon, var_1da1a66b5c6a06a7);
      eattacker thread namespace_4925be476a433a59::function_f9b01f503cdbfd7d(var_1da1a66b5c6a06a7);
    }
  }

  if(var_1da1a66b5c6a06a7 > 0 && isPlayer(eattacker)) {
    if(shouldrecorddamagestats(eattacker)) {
      eattacker stats::incpersstat("damage", var_1da1a66b5c6a06a7);
      eattacker codcasterclientmatchdata::function_d16498b27251da56(1, var_1da1a66b5c6a06a7);

      if(isDefined(eattacker scripts\mp\utility\stats::getpersstat("friendlyDamageDone")) && victim.team == eattacker.team) {
        eattacker stats::incpersstat("friendlyDamageDone", var_1da1a66b5c6a06a7);
      }
    } else if(isDefined(level.onattackerdamagenottracked)) {
      eattacker[[level.onattackerdamagenottracked]](var_1da1a66b5c6a06a7);
    }
  }

  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && idamage != 1) {
    idamage *= getdvarfloat(@ "hash_a881f1ebdab09002");
    idamage = int(idamage);
  }

  if(smeansofdeath == "MOD_IMPACT" && idamage != 1) {
    if(istrue(objweapon.isalternate) && weapons::isattachmentgrenadelauncher(objweapon.underbarrel)) {
      velocity = einflictor getmissilevelocity();
      speed = length(velocity);

      if(speed < 400) {
        idamage = 10;
      }
    }
  }

  if(objweapon.basename == "iw9_dm_crossbow_mp" && isDefined(victim.inlaststand) && istrue(victim.inlaststand)) {
    idamage = victim.health;
    var_deb5669bd1ced8db = getmatchrulesdata("commonOption", "lastStandDamageTakenScalar");

    if(var_deb5669bd1ced8db > 0) {
      idamage = int(ceil(idamage / var_deb5669bd1ced8db));
    }
  }

  if(!isDefined(victim.donotmodifydamage)) {
    idamage = int(idamage * victim damage_utility::getdamagemodifiertotal(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc));
  }

  if(isDefined(eattacker) && isDefined(eattacker.var_888410f22da94ad0) && istrue(eattacker.var_888410f22da94ad0)) {
    idamage *= 0.5;
  }

  if(damage_utility::isheadshot(shitloc, smeansofdeath, eattacker)) {
    smeansofdeath = "MOD_HEAD_SHOT";
  }

  if(tweakables::gettweakablevalue("game", "onlyheadshots") || tweakables::gettweakablevalue("game", "one_tap_headshot")) {
    if(smeansofdeath == "MOD_HEAD_SHOT" || function_2856696941de9271(objweapon, partname)) {
      idamage = 150;
    }
  }

  if(isDefined(eattacker) && eattacker ismutationgamemodezombie() && isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "jup_mutant_leap_impact_mp" && istrue(eattacker.var_f56a71aaddbdd434) && !istrue(objweapon.var_f08578daebccf4a2)) {
    var_67e9622d1fd32306 = getdvarint(@ "hash_37ef7e0a0085a948", 100);
    idamage = int(clamp(idamage, 0, var_67e9622d1fd32306));
  }

  var_1686068dab6149a3 = objweapon.basename == "jup_jp23_me_spear_mp" && !eattacker isalternatemode("jup_jp23_me_spear_mp", 0, 0);

  if((objweapon.basename == "throwingknife_mp" || var_1686068dab6149a3) && isbrstylegametype()) {
    [idamage, var_1da1a66b5c6a06a7] = scripts\mp\equipment\throwing_knife_mp::function_4d6d6bc790611975(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_be4285b26ed99ab1, unmodifieddamage, partname, var_1da1a66b5c6a06a7);
  }

  if(utility::issharedfuncdefined("helmet", "modifyHelmetDamage")) {
    [idamage, var_1da1a66b5c6a06a7] = utility::function_f3bb4f4911a1beb2("helmet", "modifyHelmetDamage", eattacker, victim, idamage, var_1da1a66b5c6a06a7, objweapon, shitloc, partname, smeansofdeath);
  }

  if(isDefined(objweapon.basename) && objweapon.basename == "jup_jp26_la_mike32_mp" && objweapon hasattachment("jup_ammo_44mm_slug")) {
    switch (shitloc) {
      case #"hash_92bbfe494d03d772":
      case #"hash_b107b5547c755d23":
        idamage *= 1.4;
        break;
      case #"hash_da51cc36a471058":
      case #"hash_51d5d0b9add9cc5a":
      case #"hash_5d5aac570f6fd382":
      case #"hash_a7980c387477e7bb":
      case #"hash_b275b50677dcf6cb":
      case #"hash_d42e71cd9f1e822f":
      case #"hash_da2f35145aa58933":
        idamage *= 1.1;
      default:
        break;
    }
  }

  return [idamage, var_1da1a66b5c6a06a7];
}

function handleriotshieldhits(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, iskillstreakweapon) {
  if(shitloc != "shield") {
    return idamage;
  }

  if(isDefined(objweapon) && objweapon.basename == "super_laser_charge_mp") {
    victim.forcehitlocation = "none";
    return idamage;
  }

  data = damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, undefined, idflags);
  ignorexp = istrue(victim.ignoreriotshieldxp);
  isenemy = istrue(player_utility::playersareenemies(victim, eattacker));

  if(getdvarint(@ "hash_79392ae6dcfba9e9", 0)) {
    isfriendly = isfriendlyfire(victim, eattacker);
    var_df49e818dfac7dba = isDefined(victim) && (isDefined(eattacker) && eattacker == victim || isDefined(eattacker.owner) && eattacker.owner == victim);

    if(isenemy || isfriendly && (game_utility::function_21322da268e71c19() || var_df49e818dfac7dba)) {
      if(function_cd066c9463ad28c5(objweapon, smeansofdeath)) {
        victim.var_5c11205f47af8b92 = gettime();
      }
    }
  }

  if(isDefined(victim.owner)) {
    victim = victim.owner;

    if(eattacker == victim) {
      return 0;
    }
  }

  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
    if(isPlayer(eattacker)) {
      eattacker.lastattackedshieldplayer = victim;
      eattacker.lastattackedshieldtime = gettime();
    }

    victim notify("shield_blocked");

    if(weapon::isenvironmentweapon(objweapon.basename)) {
      shielddamage = 25;
    } else {
      modifieddamageresults = cac_modified_damage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, einflictor, 0, idflags);
      shielddamage = modifieddamageresults[0];
      var_986b2e0350629522 = modifieddamageresults[1];
      shitloc = modifieddamageresults[2];
    }

    victim stats::incpersstat("riotShieldDamageAbsorbed", shielddamage);

    if(isPlayer(eattacker) && isDefined(victim.rearguardattackers)) {
      idx = eattacker getentitynumber();

      if(!isDefined(victim.rearguardattackers[idx])) {
        victim.rearguardattackers[idx] = shielddamage;
      } else {
        victim.rearguardattackers[idx] += shielddamage;
      }
    }

    if(ignorexp) {
      return 0;
    }

    if(!weapon::isenvironmentweapon(objweapon.basename) || utility::cointoss()) {
      victim.shieldbullethits++;
    }

    if(victim.shieldbullethits >= level.riotshieldxpbullets && isenemy) {
      xpmultiplier = 1;

      if(self.recentshieldxp > 4) {
        xpmultiplier = 1 / self.recentshieldxp;
      }

      basepoints = rank::getscoreinfovalue(#"shield_damage");
      victim thread points::doscoreevent(#"shield_damage", victim.currentweapon, basepoints * xpmultiplier);
      victim thread giverecentshieldxp();
      victim.shieldbullethits = 0;
    }
  }

  stuckdamage = isDefined(einflictor) && isDefined(einflictor.stuckenemyentity) && einflictor.stuckenemyentity == victim;
  shieldweapon = victim function_3f6d1c80aac1b91();

  if(idflags & 32) {
    victim.forcehitlocation = "none";

    if(!(idflags & 64)) {
      victim stats::incpersstat("riotShieldDamageAbsorbed", idamage);
      idamage = 0;
    }
  } else if(idflags & 128) {
    victim.forcehitlocation = "none";

    if(victim damage_utility::isstuckdamagekill(data)) {
      idamage = victim.maxhealth;
    }
  } else if(isDefined(eattacker) && istrue(eattacker.dontdamageriotshield)) {
    return 0;
  } else if(isDefined(shieldweapon) && shieldweapon.var_8296392555ef410c > 0) {
    victim.forcehitlocation = "none";
    idamage = int(idamage * shieldweapon.var_8296392555ef410c);
  } else {
    return 0;
  }

  if(smeansofdeath == "MOD_MELEE" && weapon_utility::isriotshield(objweapon.basename)) {
    victim stunplayer(0);
  }

  return idamage;
}

function filterdamage(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, partname) {
  if(!idamage) {
    return "!iDamage";
  }

  if(isDefined(level.hostmigrationtimer)) {
    return "level.hostMigrationTimer";
  }

  eattacker = _validateattacker(eattacker);

  if(!isDefined(eattacker) && smeansofdeath != "MOD_FALLING" && !(isDefined(einflictor) && isDefined(einflictor.team) && einflictor.team == "team_hundred_ninety")) {
    return "invalid attacker";
  }

  victim = _validatevictim(victim);

  if(!isDefined(victim)) {
    return "invalidVictim";
  }

  if(isDefined(eattacker) && eattacker == victim && smeansofdeath == "MOD_EXPLOSIVE_BULLET" && !getdvarint(@ "hash_4b664c074a868ac5", 0)) {
    return "Bullet Splash Protection";
  }

  if(game["state"] == "postgame") {
    return "game[ state ] == postgame";
  }

  if(isDefined(victim.sessionteam) && victim.sessionteam == "spectator") {
    return "victim.sessionteam == spectator";
  }

  if(isDefined(eattacker) && (isDefined(victim.damageblockedteam) && victim.damageblockedteam == eattacker.team || isDefined(eattacker.damageblockedteam) && eattacker.damageblockedteam == victim.team)) {
    if(isDefined(eattacker)) {
      if(isDefined(victim.damageblockedteam) && victim.damageblockedteam == eattacker.team || isDefined(eattacker.damageblockedteam) && eattacker.damageblockedteam == victim.team) {
        return "damageBlockedTeam";
      }
    }
  }

  if(isDefined(level.brgametype) && isDefined(level.brgametype.zombiesdamagezombies) && !istrue(level.brgametype.zombiesdamagezombies) && isDefined(eattacker) && eattacker scripts\mp\gametypes\br_public::playeriszombie() && victim scripts\mp\gametypes\br_public::playeriszombie()) {
    return "zombieFriendlyFire";
  }

  if(function_d75b73c443421047() && (isDefined(eattacker) && istrue(eattacker.var_fa9f4c933e6df36d) || isDefined(victim) && istrue(victim.var_fa9f4c933e6df36d))) {
    var_69f6b6b4f7e1e9cf = 1;

    if(istrue(victim.inlaststand) && is_equal(smeansofdeath, "MOD_TRIGGER_HURT")) {
      var_69f6b6b4f7e1e9cf = 0;
    }

    if(var_69f6b6b4f7e1e9cf) {
      return "safeZoneFriendlyFire";
    }
  }

  if(tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(smeansofdeath != "MOD_TRIGGER_HURT" && smeansofdeath != "MOD_FALLING" && shitloc != "head" && shitloc != "helmet" && !function_2856696941de9271(objweapon, partname)) {
      if(level.headhunterenabled) {
        if(eattacker.team != victim.team) {
          eattacker damagefeedback::updatedamagefeedback("hitnobulletdamage");
          eattacker playlocalsound("hit_marker_dud");
        }

        return "level.headhunterEnabled";
      }

      if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
        return "getTweakableValue( game, onlyheadshots )";
      }
    }
  }

  if(level.headhunterenabled) {
    if(smeansofdeath == "MOD_MELEE") {
      return "No melee damage in Headhunter";
    }
  }

  if(isDefined(level.var_6298f362ec23d83) && (level.var_6298f362ec23d83.ref == "dontshoot" || level.var_6298f362ec23d83.ref == "beatupthecar" || level.var_6298f362ec23d83.ref == "revive") && smeansofdeath != "MOD_TRIGGER_HURT" && smeansofdeath != "MOD_FALLING") {
    return "No damage in this minigame in COD Warrior";
  }

  if(smeansofdeath == "MOD_MELEE") {
    if(isDefined(level.var_6298f362ec23d83) && (level.var_6298f362ec23d83.ref == "breacher" || level.var_6298f362ec23d83.ref == "miniguns" || level.var_6298f362ec23d83.ref == "serpentine" || level.var_6298f362ec23d83.ref == "fragged" || level.var_6298f362ec23d83.ref == "turrettime" || level.var_6298f362ec23d83.ref == "dronewars" || level.var_6298f362ec23d83.ref == "shocking" || level.var_6298f362ec23d83.ref == "hunt" || level.var_6298f362ec23d83.ref == "bullettime" || level.var_6298f362ec23d83.ref == "shoot")) {
      return "No melee damage in this minigame in COD Warrior";
    }
  }

  if(function_2be5b08ed39d6a54(eattacker, victim, objweapon)) {
    return "crossbow semtex splash damage on stuckto victim";
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && einflictor vehicle::isvehicle() && victim player_utility::isinvehicle()) {
    return "hitByVehicleWhileInVehicle";
  }

  if(vehicle::vehicle_playershouldignorecollisiondamage(einflictor, victim, smeansofdeath, objweapon)) {
    return "vehicle_playerShouldIgnoreCollisionDamage";
  }

  if(vehicle::vehicle_isrubbingagainstvehicle(einflictor, victim, smeansofdeath)) {
    return "vehicle_isRubbingAgainstVehicle";
  }
}

function logattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7) {
  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
    eattacker = victim;
  }

  if(isDefined(eattacker) && (isPlayer(eattacker) || isagent(eattacker))) {
    addattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7);
  }

  if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.owner) && (!isDefined(eattacker.scrambled) || !eattacker.scrambled)) {
    addattacker(victim, eattacker.owner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7);
  } else if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.secondowner) && isDefined(eattacker.scrambled) && eattacker.scrambled) {
    addattacker(victim, eattacker.secondowner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7);
  }

  if(isDefined(einflictor) && isDefined(einflictor.owner)) {
    lethalteam = isDefined(einflictor.owner.team) && einflictor.owner.team != victim.team || level.friendlyfire == 1;

    if(lethalteam && isDefined(einflictor.owner.guid) && !isDefined(self.attackerdata[einflictor.owner.guid])) {
      addattacker(victim, einflictor.owner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7);
    }
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(objweapon) && eattacker != victim) {
    eattacker thread weapons::checkhit(objweapon, victim, shitloc, idamage);
    eattacker thread events::damagedplayer(self, idamage);
    victim.attackerposition = eattacker.origin;
    return;
  }

  victim.attackerposition = undefined;
}

function logattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon) {
  if(isDefined(eattacker) && isPlayer(eattacker)) {
    addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon);
  }

  if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner) && (!isDefined(eattacker.scrambled) || !eattacker.scrambled)) {
    eattacker = eattacker.owner;
    addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon);
  } else if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.secondowner) && isPlayer(eattacker.secondowner) && isDefined(eattacker.scrambled) && eattacker.scrambled) {
    eattacker = eattacker.secondowner;
    addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon);
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(sweapon) && eattacker != victim) {
    victim.attackerposition = eattacker.origin;
    return;
  }

  victim.attackerposition = undefined;
}

function loggrenadedata(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon) {
  if((issubstr(smeansofdeath, "MOD_EXPLOSIVE") || issubstr(smeansofdeath, "MOD_PROJECTILE")) && isDefined(einflictor) && isDefined(eattacker)) {
    var_366b0ecc2f28aead = getcompleteweaponname(objweapon);
    victim.explosiveinfo = [];
    victim.explosiveinfo["damageTime"] = gettime();
    victim.explosiveinfo["damageId"] = einflictor getentitynumber();
    victim.explosiveinfo["returnToSender"] = 0;
    victim.explosiveinfo["counterKill"] = 0;
    victim.explosiveinfo["chainKill"] = 0;
    victim.explosiveinfo["cookedKill"] = 0;
    victim.explosiveinfo["throwbackKill"] = 0;
    victim.explosiveinfo["suicideGrenadeKill"] = 0;
    victim.explosiveinfo["weapon"] = var_366b0ecc2f28aead;
    isfrag = issubstr(objweapon.basename, "frag_");

    if(eattacker != victim) {
      if((issubstr(objweapon.basename, "c4_") || issubstr(objweapon.basename, "proximity_explosive_") || issubstr(objweapon.basename, "claymore_")) && isDefined(einflictor.owner)) {
        victim.explosiveinfo["returnToSender"] = einflictor.owner == victim;
        victim.explosiveinfo["counterKill"] = isDefined(einflictor.wasdamaged);
        victim.explosiveinfo["chainKill"] = isDefined(einflictor.waschained);
        victim.explosiveinfo["bulletPenetrationKill"] = isDefined(einflictor.wasdamagedfrombulletpenetration);
        victim.explosiveinfo["cookedKill"] = 0;
      }

      if(isDefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag) {
        victim.explosiveinfo["suicideGrenadeKill"] = 1;
      }
    }

    if(isfrag) {
      victim.explosiveinfo["cookedKill"] = isDefined(einflictor.iscooked);
      victim.explosiveinfo["throwbackKill"] = isDefined(einflictor.threwback);
    }

    victim.explosiveinfo["stickKill"] = isDefined(einflictor.isstuck) && einflictor.isstuck == "enemy";
    victim.explosiveinfo["stickFriendlyKill"] = isDefined(einflictor.isstuck) && einflictor.isstuck == "friendly";

    if(isPlayer(eattacker) && eattacker != self && game_utility::getgametype() != "aliens") {
      updateinflictorstat(einflictor, eattacker, var_366b0ecc2f28aead);
    }
  }
}

function function_42baa3bb97d2d1d7(player, var_254ce4e343d1f7de, var_a3732517126407b2, idamage, vpoint) {
  idamage = int(clamp(idamage, 0, 1000000));
  player setclientomnvar("ui_dmg_num_amount", idamage);
  player setclientomnvar("ui_dmg_num_x", int(vpoint[0]));
  player setclientomnvar("ui_dmg_num_y", int(vpoint[1]));
  player setclientomnvar("ui_dmg_num_z", int(vpoint[2]));
  player setclientomnvar("ui_dmg_num_element", 0);
  player setclientomnvar("ui_dmg_num_state", var_a3732517126407b2);
  player setclientomnvar("ui_dmg_num_notify", gettime());
  player setclientomnvar("ui_dmg_num_target", var_254ce4e343d1f7de);
}

function function_7a6bbb24289296e7(player, var_254ce4e343d1f7de, var_a3732517126407b2, idamage, vpoint) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!isDefined(player.var_a0f98ffc22b158e3)) {
    player.var_a0f98ffc22b158e3 = 0;
  }

  player.var_a0f98ffc22b158e3++;
  wait 0.05 * player.var_a0f98ffc22b158e3;

  if(isPlayer(player)) {
    function_42baa3bb97d2d1d7(player, var_254ce4e343d1f7de, var_a3732517126407b2, idamage, vpoint);
  }

  player.var_a0f98ffc22b158e3--;
}

function function_c54b2cc2e762c201(eattacker, etargethit, idamage, vpoint, waskilled, var_4ec43f1177740f8d) {
  if(var_4ec43f1177740f8d) {
    var_a3732517126407b2 = 3;
  } else {
    var_a3732517126407b2 = ter_op(waskilled, 2, 1);
  }

  if(!isDefined(vpoint)) {
    usedoffset = default_to(etargethit.var_2be88729da6fdbc5, (0, 0, 12));

    if(isent(etargethit) && isalive(etargethit)) {
      usedtag = default_to(etargethit.var_52dcdba485e7ceeb, "j_head");
      vpoint = etargethit gettagorigin(usedtag) + usedoffset;
    } else {
      vpoint = etargethit.origin + usedoffset;
    }
  }

  var_254ce4e343d1f7de = etargethit getentitynumber();
  thread function_7a6bbb24289296e7(eattacker, var_254ce4e343d1f7de, var_a3732517126407b2, idamage, vpoint);
}

function handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, var_1da1a66b5c6a06a7, var_986b2e0350629522, iskillstreakweapon, partname, vpoint) {
  if(function_483cc81bff18273b(eattacker) || function_483cc81bff18273b(victim)) {
    return;
  }

  if(isDefined(victim.handledamagefeedback)) {
    [[victim.handledamagefeedback]](einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, var_1da1a66b5c6a06a7, var_986b2e0350629522, iskillstreakweapon);
    return;
  }

  var_168973eaf883aea1 = isDefined(eattacker) && isDefined(eattacker.classname) && !isDefined(eattacker.gunner) && (eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model");

  if(var_168973eaf883aea1 && isDefined(eattacker.gunner)) {
    damager = eattacker.gunner;
  } else if(isDefined(eattacker) && isDefined(eattacker.owner)) {
    damager = eattacker.owner;
  } else {
    damager = eattacker;
  }

  typehit = "standard";

  if(isDefined(damager) && damager != victim && idamage + var_1da1a66b5c6a06a7 + var_986b2e0350629522 > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    waskilled = !victim player_utility::_isalive() || isagent(victim) && idamage >= victim.health;
    var_b44e627d6a911f55 = game_utility::function_fa7bfcc1d68b7b73();
    var_dc726e8cc0b003a3 = isDefined(victim.platecarrierlevel) && victim.platecarrierlevel > 2;
    var_a2ffd9894fd368c5 = isDefined(victim.var_4045f099f3da4bd) && victim.var_4045f099f3da4bd == "brloot_plate_carrier_tempered";
    damagecaused = idamage + var_1da1a66b5c6a06a7 + var_986b2e0350629522;
    var_135003274a4cc703 = 0;
    var_9c2547405b5b2cbf = 0;

    if(utility::issharedfuncdefined("helmet", "helmet_wasBroke")) {
      var_9c2547405b5b2cbf = utility::function_f3bb4f4911a1beb2("helmet", "helmet_wasBroke", damager);
    }

    if(istrue(var_dc726e8cc0b003a3) && isDefined(victim.armorhealth)) {
      var_135003274a4cc703 = victim.armorhealth + damagecaused >= 150;
    }

    if(isPlayer(eattacker) && function_3201a1bc3ff0e482(eattacker, victim, smeansofdeath, idflags)) {
      typehit = "hitsuppression";
    } else if(victim perk::_hasperk("specialty_pistoldeath") && isDefined(victim.inlaststand) && victim.inlaststand == 1 && !victim.hasshownlaststandicon) {
      victim.hasshownlaststandicon = 1;
      typehit = "hitlaststand";
    } else if(!isagent(victim) && victim function_f1dcadc8f7c3477c()) {
      typehit = "hitlaststand";
    } else if(istrue(victim.isjuggernaut) && !isjuggermoshgamemode()) {
      if(istrue(victim.isjuggernautrecon)) {
        typehit = "hitjuggernautrecon";
      } else {
        typehit = "hitjuggernaut";
      }
    } else if(isPlayer(victim) && istrue(victim function_fc05ebabfbf10e33())) {
      typehit = "hitarmorheavy";
    } else if(victim heavyarmor::hasheavyarmor() || victim heavyarmor::hasheavyarmorinvulnerability()) {
      typehit = "hitarmorheavy";
    } else if(idflags & 16) {
      typehit = "stun";
    } else if(hashealthshield(victim)) {
      typehit = "hitarmorlight";
    } else if(var_9c2547405b5b2cbf) {
      typehit = "hithelmetlightbreak";
    } else if(armor::armorvest_wasbroke(damager)) {
      typehit = "hitarmorlightbreak";

      if(var_dc726e8cc0b003a3 && !var_b44e627d6a911f55) {
        typehit = "hitarmormaxplatebreak";
      }

      if(var_a2ffd9894fd368c5 && !var_b44e627d6a911f55) {
        typehit = "hitarmortemperedbreak";
      }
    } else if(victim perk::_hasperk("specialty_durability")) {
      typehit = "hitdurability";
    } else if(function_7cc9753f2f84e883(eattacker, victim) || victim game_utility::isspawnprotected() && iskillstreakweapon && !weapon::weaponbypassspawnprotection(objweapon)) {
      typehit = "hitspawnprotect";
    } else if(helmet_wasbroke(damager)) {
      typehit = "hithelmetlightbreak";
    } else if(armor::armorvest_washit(damager)) {
      typehit = "hitarmorlight";

      if((getdvarint(@ "hash_2f7767a2a092ce1a", 0) || !getdvarint(@ "hash_f786619a1f55409f", 0)) && var_dc726e8cc0b003a3 && !var_b44e627d6a911f55) {
        typehit = "hitarmorlightmaxlevel";
      }

      if(var_a2ffd9894fd368c5 && !var_b44e627d6a911f55) {
        typehit = "hitarmorlighttempered";
      }
    } else if(helmet_washit(damager)) {
      typehit = "hithelmetlight";
    } else if(var_1da1a66b5c6a06a7 > 0) {
      typehit = "hitarmorlight";
    } else if((smeansofdeath == "MOD_MELEE" || isthrowingknife(objweapon) || isthrowingstar(objweapon)) && victim perk::_hasperk("specialty_close_quarter")) {
      typehit = "hitcqc";
    } else if(victim _hasperk("specialty_regen_delay_reduced")) {
      typehit = "hitquickfix";
    } else if(istrue(victim.var_808d06ddfc93a4e4)) {
      typehit = "hitbattlerage";
    } else if(istrue(victim.iszombie) && istrue(victim.buffed)) {
      typehit = "hitzombieshout";
    } else if(function_bd90db337f1ae0d4(victim, damager)) {
      function_675990374e11b0f7(victim, damager);
      typehit = "hitresolute";
    } else if(istacticaldamage(objweapon, smeansofdeath) && victim perk::_hasperk("specialty_stun_resistance")) {
      typehit = "hittacresist";
    } else if(victim perk::_hasperk("specialty_blastshield") && !damage_should_ignore_blast_shield(eattacker, victim, objweapon, smeansofdeath, einflictor, shitloc)) {
      typehit = "hitblastshield";
    } else if(istrue(victim.adrenalinepoweractive)) {
      typehit = "hitadrenaline";
    } else if(isDefined(objweapon) && objweapon.basename == "sound_veil_mp") {
      typehit = "hitsoundveil";
    } else if(getdvarint(@ "hash_1db87c3b655b5645", 0) == 1) {
      typehit = "hithealth";
    }

    eattacker game_utility::clearspawnprotection();
    bulletdamage = utility::isbulletdamage(smeansofdeath);
    hitmarkertype = utility::ter_op(bulletdamage && weapon::isprimaryweapon(objweapon), "standardspread", "standard");

    if(istrue(level.var_3ff7c73209fcf59d)) {
      if(bulletdamage && istrue(victim.skydive_spawnprotection) || isexplosivedamagemod(smeansofdeath) && istrue(victim.var_ce34e72182b33556)) {
        typehit = "hitskydiveprotection";
      }
    }

    armorbreak = 0;

    if(typehit == "hitarmorlightbreak" || typehit == "hitarmormaxplatebreak" || typehit == "hitarmortemperedbreak") {
      armorbreak = 1;

      if(var_a2ffd9894fd368c5) {
        hitmarkertype = "temperedarmorbreak";

        if(istrue(var_b44e627d6a911f55) && !istrue(var_135003274a4cc703)) {
          hitmarkertype = utility::ter_op(hitmarkertype == "standardspread", "standardspreadarmorbreak", "standardarmorbreak");
        }
      } else if(var_dc726e8cc0b003a3) {
        hitmarkertype = "threeplatearmorbreak";

        if(istrue(var_b44e627d6a911f55) && !istrue(var_135003274a4cc703)) {
          hitmarkertype = utility::ter_op(hitmarkertype == "standardspread", "standardspreadarmorbreak", "standardarmorbreak");
        }
      } else if(hitmarkertype == "standardspread") {
        hitmarkertype = "standardspreadarmorbreak";
      } else {
        hitmarkertype = "standardarmorbreak";
      }
    } else if(typehit == "hitarmorlight" || typehit == "hitarmorlightmaxlevel" || typehit == "hitarmorlighttempered") {
      if(var_a2ffd9894fd368c5) {
        hitmarkertype = "temperedarmor";

        if(istrue(var_b44e627d6a911f55) && !istrue(var_135003274a4cc703)) {
          hitmarkertype = utility::ter_op(hitmarkertype == "standardspread", "standardspreadarmor", "standardarmor");
        }
      } else if(var_dc726e8cc0b003a3) {
        hitmarkertype = "threeplatearmor";

        if(istrue(var_b44e627d6a911f55) && !istrue(var_135003274a4cc703)) {
          hitmarkertype = utility::ter_op(hitmarkertype == "standardspread", "standardspreadarmor", "standardarmor");
        }
      } else if(hitmarkertype == "standardspread") {
        hitmarkertype = "standardspreadarmor";
      } else {
        hitmarkertype = "standardarmor";
      }
    } else if(typehit == "hitblastshield" && victim perk::_hasperk("specialty_flak_jacket")) {
      hitmarkertype = "hitflakjacket";
    }

    headshot = !isspreadweapon(objweapon) && damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);

    if(weapon::isthrowingstar(objweapon) && damage_utility::function_b656251147d7d40b(partname)) {
      headshot = 1;
    }

    if(objweapon.basename == "jup_jp26_la_mike32_mp" && objweapon hasattachment("jup_ammo_44mm_slug") && (shitloc == "head" || shitloc == "helmet")) {
      headshot = 1;
    }

    if((level.headhunterenabled || eattacker perk::_hasperk("specialty_headhunter")) && headshot) {
      typehit = "hitheadhunter";
    }

    allowdamagefeedback = 1;
    suppressaudio = smeansofdeath == "MOD_MELEE";
    victimentnum = "" + victim getentitynumber();

    if(waskilled && isDefined(victim.body)) {
      var_249fca7089cd498f = victim.body getentitynumber();
    } else {
      var_249fca7089cd498f = victim getentitynumber();
    }

    var_65cb04ee667315bc = 0;

    if(!armorbreak && isspreadweapon(objweapon) && isDefined(damager.pelletweaponvictimids)) {
      foreach(var_4663bfaed1a30ec9 in damager.pelletweaponvictimids) {
        if(isDefined(var_4663bfaed1a30ec9[victimentnum]) && var_4663bfaed1a30ec9[victimentnum].pelletdmgpassed.size > 1) {
          var_65cb04ee667315bc = 1;
        }
      }
    }

    if(!weapon::iskillstreakweapon(objweapon) && isPlayer(damager)) {
      if(bulletdamage || (isspreadweapon(objweapon) ? !var_65cb04ee667315bc : islauncherweapon(objweapon))) {
        damager scripts\mp\utility\stats::initpersstat("shotsBulletHit");
        var_5f7f853e0aeb4d24 = 0;

        if(true) {} else if(islauncherweapon(objweapon) || isspreadweapon(objweapon)) {
          weaponbasename = objweapon.basename;

          if(!isDefined(weaponbasename)) {
            var_5f7f853e0aeb4d24 = 1;
          } else {
            if(!isDefined(damager.lasthittime[objweapon.basename])) {
              damager.lasthittime[objweapon.basename] = 0;
            }

            if(damager.lasthittime[objweapon.basename] == gettime()) {
              var_5f7f853e0aeb4d24 = 1;
            } else {
              damager.lasthittime[objweapon.basename] = gettime();
            }
          }
        }

        if(!var_5f7f853e0aeb4d24) {
          damager scripts\mp\utility\stats::incpersstat("shotsBulletHit", 1);
          damager thread namespace_6b49ddb858f34366::function_298b6dd0b26f13bd();

          if(!isbot(victim) || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
            damager thread namespace_6b49ddb858f34366::function_2efd6926efd58b49(1);
          }
        }
      }
    }

    if(!suppressaudio && var_65cb04ee667315bc) {
      if(waskilled || armorbreak) {
        suppressaudio = 1;
      } else {
        allowdamagefeedback = 0;
      }
    }

    if(allowdamagefeedback) {
      var_203066c6662e1f2d = undefined;

      if(getdvarint(@ "hash_2909726ff0e12a7d", 0) == 1 && isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_e76a5e57e1ff6b9b)) {
        var_203066c6662e1f2d = spawnStruct();

        if(isPlayer(victim) || isagent(victim)) {
          var_203066c6662e1f2d.isenemydown = player::isinlaststand(victim);
          var_203066c6662e1f2d.isfriendly = isfriendlyfire(victim, damager);

          if(bulletdamage && weapon::isprimaryweapon(objweapon)) {
            hitmarkertype = 1;
          } else {
            hitmarkertype = 2;
          }
        }
      }

      armorplatecount = armor::function_77b7145c92102847(victim armor::function_ac266fc218266d08() + var_1da1a66b5c6a06a7);
      damager damagefeedback::updatedamagefeedback(typehit, waskilled, headshot, hitmarkertype, suppressaudio, undefined, var_249fca7089cd498f, armorplatecount, var_203066c6662e1f2d);

      if(getdvarint(@ "hash_8a8ff6ed00ccc7a", 0) && (isPlayer(victim) || isagent(victim))) {
        point = undefined;

        if(!getdvarint(@ "hash_817f3f9eb1901919", 1)) {
          point = vpoint;
        } else if(waskilled && bulletdamage && isDefined(vpoint)) {
          point = vpoint + (0, 0, 20);
        }

        function_c54b2cc2e762c201(eattacker, victim, damagecaused, point, waskilled, 0);
      }
    }
  }
}

function handledamageeffects(idamage, eattacker, smeansofdeath, vpoint, var_1da1a66b5c6a06a7, objweapon) {
  damage_effects::damageeffects(idamage, eattacker, smeansofdeath, vpoint, var_1da1a66b5c6a06a7, objweapon);
}

function lethalequipmentdamagemod(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon) {
  data = damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, undefined, undefined, undefined, undefined, undefined, idflags);

  if(isDefined(einflictor) && isDefined(einflictor.damagedby)) {
    eattacker = einflictor.damagedby;
  }

  if(victim damage_utility::isstuckdamagekill(data)) {
    if(victim killstreak::isjuggernaut()) {
      idamage = min(300, idamage);
    } else if(isDefined(einflictor.bundle) && istrue(einflictor.bundle.var_f09a1a099e0824ef)) {
      if(!victim _hasperk("specialty_blastshield")) {
        if(isDefined(victim.maxarmorhealth)) {
          idamage = victim.maxhealth + victim.maxarmorhealth;
        } else {
          idamage = victim.maxhealth;
        }
      }
    } else if(isDefined(victim.maxarmorhealth)) {
      idamage = victim.maxhealth + victim.maxarmorhealth;
    } else {
      idamage = victim.maxhealth;
    }
  }

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_IMPACT") {
    if(isDefined(eattacker) && victim != eattacker && isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "grenade" && victim.lastspawntime + 3500 > gettime() && isDefined(victim.lastspawnpoint) && distance(einflictor.origin, victim.lastspawnpoint.origin) < 500) {
      idamage = 0;
    }
  }

  if(isDefined(eattacker) && isPlayer(eattacker)) {
    loggrenadedata(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon);
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.weaponname = weapon::getweaponrootname(objweapon);
    var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(objweapon);
    var_7e2c53b0bcf117d9.statname = "damage";
    var_7e2c53b0bcf117d9.incvalue = min(victim.health, idamage);
    var_7e2c53b0bcf117d9.variantid = -1;
    var_7e2c53b0bcf117d9.weaponobj = objweapon;
    eattacker namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  return idamage;
}

function playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  deathdata = damage_utility::packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, undefined, direction_vec, undefined, undefined, undefined, undefined, damageflags);
  deathdata.hitloc = hitloc;
  deathdata.psoffsettime = psoffsettime;
  deathdata.deathanimduration = deathanimduration;
  deathdata.isfauxdeath = isfauxdeath;

  if(meansofdeath == "MOD_EXECUTION") {
    deathdata.executionref = execution::execution_getrefbyplayer(attacker);
  }

  deathdata.dokillcam = 0;
  deathdata.dofinalkillcam = 1;
  deathdata.killcamentity = undefined;
  deathdata.killcamentityindex = -1;
  deathdata.killcamentitystarttime = 0;
  deathdata.inflictoragentinfo = undefined;
  deathdata.killcamentstickstovictim = undefined;
  deathdata.isfriendlyfire = undefined;
  deathdata.primaryweapon = undefined;
  deathdata.lifeid = undefined;
  deathdata.attackerentnum = undefined;
  deathdata.iskillstreakweapon = undefined;
  deathdata.var_bfcdebee0e8a3189 = undefined;
  deathdata.weaponfullstring = undefined;
  deathdata.isnukekill = 0;
  deathdata.deathscenetimesec = getdvarfloat(@ "hash_ac849f1ec300d19c", 1.75);
  deathdata.deathscenetimems = int(deathdata.deathscenetimesec * 1000);
  deathdata.deathtime = gettime();
  deathdata.brvictiminlaststand = undefined;
  deathdata.var_f83c15acb64c91b7 = isDefined(victim) && istrue(victim.var_f83c15acb64c91b7);
  deathdata.var_21d6bd6b0d89a70c = isDefined(victim) && istrue(victim.var_21d6bd6b0d89a70c);
  return deathdata;
}

function playerkilled_parameterfixup(deathdata) {
  assert(deathdata.victim.sessionteam != "<dev string:x2dc>");

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.var_26fb072855fd4772)) {
    deathdata.meansofdeath = "MOD_CRUSH";
    deathdata.attacker = deathdata.inflictor;
    deathdata.attacker.team = game_utility::getotherteam(deathdata.victim.team)[0];
  }

  if(deathdata.victim == deathdata.attacker && deathdata.meansofdeath == "MOD_CRUSH") {
    deathdata.meansofdeath = "MOD_SUICIDE";
  }

  if(deathdata.objweapon.basename == "none") {
    if(isDefined(deathdata.inflictor) && isDefined(deathdata.inflictor.baseweapon)) {
      deathdata.objweapon.basename = deathdata.inflictor.baseweapon;
    }
  }

  deathdata.victim playerkilled_fixupattacker(deathdata);

  if(damage_utility::isheadshot(deathdata.hitloc, deathdata.meansofdeath, deathdata.attacker)) {
    deathdata.meansofdeath = "MOD_HEAD_SHOT";
  }

  if(deathdata.objweapon.basename == "jup_jp26_la_mike32_mp" && deathdata.objweapon hasattachment("jup_ammo_44mm_slug") && (deathdata.hitloc == "head" || deathdata.hitloc == "helmet")) {
    deathdata.meansofdeath = "MOD_HEAD_SHOT";
  }

  if(deathdata.isfauxdeath) {
    deathdata.dokillcam = 0;
    deathdata.deathanimduration = deathdata.victim playerforcedeathanim(deathdata.inflictor, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.direction_vec);
  }

  if(deathdata.meansofdeath == "MOD_IMPACT" && deathdata.objweapon.basename == "mutation_sludge_sling") {
    deathdata.meansofdeath = "MOD_MUTATION_SLUDGE_SLING";
  }

  function_af3ebb9d1ecd18e7(deathdata);

  function_18c42af5777dcd9f(deathdata);
}

function playerkilled_fixupattacker(deathdata) {
  deathdata.attacker = _validateattacker(deathdata.attacker);

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.var_26fb072855fd4772)) {
    if(isDefined(level.var_b6e3760a75368efc)) {
      deathdata.attacker = [[level.var_b6e3760a75368efc]](deathdata.inflictor, deathdata.victim);
    }
  }

  assistedsuicide = 0;

  if(!isDefined(deathdata.attacker)) {
    assistedsuicide = 1;
  } else if(isDefined(deathdata.attacker.classname) && (deathdata.attacker.classname == "trigger_hurt" || deathdata.attacker.classname == "worldspawn")) {
    assistedsuicide = 1;
  } else if(deathdata.attacker == deathdata.victim) {
    assistedsuicide = 1;

    if(deathdata.meansofdeath == "MOD_SUICIDE") {
      logattacker(deathdata.victim, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.damage, undefined, undefined, deathdata.hitloc, deathdata.psoffsettime, deathdata.meansofdeath, 0);
    }
  }

  if(assistedsuicide) {
    bestplayer = undefined;

    if(isDefined(deathdata.victim.attackers) && self.attackers.size > 0) {
      foreach(player in deathdata.victim.attackers) {
        if(!isDefined(player)) {
          continue;
        }

        if(!isDefined(deathdata.victim)) {
          continue;
        }

        if(!isDefined(_validateattacker(player))) {
          continue;
        }

        if(!isDefined(player.guid)) {
          continue;
        }

        if(!isDefined(deathdata.victim.attackerdata)) {
          continue;
        }

        if(!isDefined(deathdata.victim.attackerdata[player.guid])) {
          continue;
        }

        if(!isDefined(deathdata.victim.attackerdata[player.guid].damage)) {
          continue;
        }

        if(player == deathdata.victim || level.teambased && player.team == deathdata.victim.team) {
          continue;
        }

        if(deathdata.victim.attackerdata[player.guid].damage > 1 && !isDefined(bestplayer)) {
          bestplayer = player;
          continue;
        }

        if(isDefined(bestplayer) && deathdata.victim.attackerdata[player.guid].damage > deathdata.victim.attackerdata[bestplayer.guid].damage) {
          bestplayer = player;
        }
      }
    }

    if(!isDefined(bestplayer)) {
      if(isDefined(deathdata.victim.debuffedbyplayers) && deathdata.victim.debuffedbyplayers.size > 0) {
        var_f6f171fa9c145f8 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];

        foreach(var_65928e4c6195a5b in var_f6f171fa9c145f8) {
          var_a676df5d3d80a259 = gamescore::getdebuffattackersbyweapon(deathdata.victim, var_65928e4c6195a5b);

          if(var_a676df5d3d80a259.size > 0) {
            for(i = var_a676df5d3d80a259.size - 1; i >= 0; i--) {
              var_e0573162d646b530 = var_a676df5d3d80a259[i];

              if(!isDefined(_validateattacker(var_e0573162d646b530))) {
                continue;
              }

              if(!istrue(player_utility::playersareenemies(var_e0573162d646b530, deathdata.victim))) {
                continue;
              }

              bestplayer = var_e0573162d646b530;

              if(!isDefined(deathdata.victim.attackerdata) || !isDefined(deathdata.victim.attackerdata[bestplayer.guid])) {
                addattacker(deathdata.victim, bestplayer, undefined, makeweapon(var_65928e4c6195a5b), 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
              }

              break;
            }
          }

          if(isDefined(bestplayer)) {
            break;
          }
        }
      }
    }

    if(isDefined(bestplayer)) {
      deathdata.attacker = bestplayer;
      deathdata.attacker.assistedsuicide = 1;
      deathdata.objweapon = deathdata.victim.attackerdata[bestplayer.guid].objweapon;
      deathdata.direction_vec = deathdata.victim.attackerdata[bestplayer.guid].vdir;
      deathdata.hitloc = deathdata.victim.attackerdata[bestplayer.guid].shitloc;
      deathdata.psoffsettime = deathdata.victim.attackerdata[bestplayer.guid].psoffsettime;
      deathdata.meansofdeath = deathdata.victim.attackerdata[bestplayer.guid].smeansofdeath;
      deathdata.damage = deathdata.victim.attackerdata[bestplayer.guid].damage;

      if(istrue(deathdata.victim.squadwiped) && isDefined(deathdata.victim.attackerdata[bestplayer.guid].inflictor)) {
        deathdata.inflictor = deathdata.victim.attackerdata[bestplayer.guid].inflictor;
      }

      deathdata.assistedsuicide = 1;
    } else if(!isDefined(deathdata.attacker.team) || deathdata.attacker.team == "neutral") {
      deathdata.attacker = deathdata.victim;
    }
  }

  if(isDefined(deathdata.attacker) && isDefined(deathdata.attacker.code_classname)) {
    if(deathdata.attacker.code_classname == "script_vehicle" && isDefined(deathdata.attacker.owner)) {
      deathdata.attacker = deathdata.attacker.owner;
    }

    if(deathdata.attacker.code_classname == "misc_turret" && isDefined(deathdata.attacker.owner)) {
      if(isDefined(deathdata.attacker.vehicle)) {
        deathdata.attacker.vehicle notify("killedPlayer", deathdata.victim);
      }

      deathdata.attacker = deathdata.attacker.owner;
    }

    if(isagent(deathdata.attacker)) {
      if(isDefined(deathdata.attacker.owner)) {
        deathdata.attacker = deathdata.attacker.owner;
      }
    }

    if(deathdata.attacker.code_classname == "script_model" && isDefined(deathdata.attacker.owner)) {
      deathdata.attacker = deathdata.attacker.owner;

      if(!isfriendlyfire(deathdata.victim, deathdata.attacker) && deathdata.attacker != deathdata.victim) {
        deathdata.attacker notify("crushed_enemy");
      }
    }
  }

  if(isDefined(deathdata.inflictor) && !isPlayer(deathdata.inflictor)) {
    if(!isDefined(deathdata.attacker)) {
      if(isDefined(deathdata.inflictor.owner)) {
        deathdata.attacker = deathdata.inflictor.owner;
      }
    } else if(!isPlayer(deathdata.attacker)) {
      if(isDefined(deathdata.inflictor.owner)) {
        deathdata.attacker = deathdata.inflictor.owner;
      }
    }
  }

  if(isDefined(deathdata.attacker) && deathdata.attacker != deathdata.victim) {
    if(isDefined(deathdata.inflictor) && deathdata.inflictor == deathdata.victim) {
      deathdata.inflictor = deathdata.attacker;
    }
  }

  if(isDefined(deathdata.inflictor) && isDefined(deathdata.inflictor.var_9328ded553f15d2b) && !istrue(player_utility::playersareenemies(deathdata.victim, deathdata.inflictor.var_9328ded553f15d2b))) {
    deathdata.attacker = self;
  }

  deathdata.attacker.assistedsuicide = 0;
}

function playerkilled_precalc(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  victim.perkoutlined = 0;
  victim.deathspectatepos = undefined;
  victim.deathtime = deathdata.deathtime;
  victim.attacker = attacker;
  victim.lastdeathpos = victim.origin;
  victim.lastdeathangles = victim getplayerangles();

  if(!isbot(victim)) {
    victim thread namespace_4925be476a433a59::function_221ea9f08eaf2346();
  }

  if(isDefined(inflictor) && !isPlayer(inflictor) && isDefined(inflictor.primaryweapon)) {
    deathdata.primaryweapon = inflictor.primaryweapon;
  } else if(isDefined(attacker) && isPlayer(attacker) && !isnullweapon(attacker getcurrentprimaryweapon())) {
    deathdata.primaryweapon = getcompleteweaponname(attacker getcurrentprimaryweapon());
  } else if(objweapon.isalternate) {
    deathdata.primaryweapon = objweapon.basename;
  } else {
    deathdata.primaryweapon = undefined;
  }

  deathdata.lifeid = victim.matchdatalifeindex;

  if(!isDefined(deathdata.lifeid)) {
    deathdata.lifeid = level.maxlives - 1;
  }

  if(game_utility::isgameparticipant(attacker)) {
    deathdata.attackerentnum = attacker getentitynumber();
  } else {
    deathdata.attackerentnum = -1;
  }

  deathdata.iskillstreakweapon = attacker weapon::iskillstreakweapon(objweapon.basename);
  deathdata.weaponfullstring = getcompleteweaponname(objweapon);
  deathdata.var_bfcdebee0e8a3189 = isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "bomb_site_mp";
  deathdata.isfriendlyfire = isfriendlyfire(victim, attacker);
  deathdata.isnukekill = objweapon.basename == "nuke_mp";
  deathdata.brvictiminlaststand = player::isinlaststand(victim);

  function_f9249bb06eb48092(deathdata);

  function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_sharedlogic_early(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  damage = deathdata.damage;
  meansofdeath = deathdata.meansofdeath;
  isfauxdeath = deathdata.isfauxdeath;
  hitloc = deathdata.hitloc;
  direction_vec = deathdata.direction_vec;
  victim notify("killed_player");
  outline::outlinedisableinternalall(victim);
  victim showuidamageflash();
  victim setblurforplayer(0, 0);
  victim scripts\mp\equipment\molotov::molotov_clear_fx();
  victim scripts\mp\weapons::clearburning();

  if(!game_utility::runleanthreadmode()) {
    print::printgameaction("death", victim);
  }

  victim launchshield(damage, meansofdeath);
  victim riotshield::riotshield_clear();

  if(isDefined(attacker.petwatch) && attacker != victim) {
    attacker pet_watch::addkillcharge();

    if(meansofdeath == "MOD_EXECUTION") {
      attacker pet_watch::addexecutioncharge();
    } else if(victim playerkilled_washitbyvehicle(meansofdeath, inflictor)) {
      attacker pet_watch::addvehicularmanslaughtercharge();
    }
  }

  if(meansofdeath == "MOD_EXECUTION") {
    attacker stats::incpersstat("executionKills", 1);
    level thread battlechatter_mp::trysaylocalsound(attacker, #"bc_combat_action_execution", undefined, 1);
  }

  if(victim scripts\mp\damage::playerkilled_washitbyvehicle(meansofdeath, inflictor)) {
    inflictor notify("vehicle_killed_player");
  }

  victimheldweapon = victim getcurrentweapon();

  if(!victim weapon::iskillstreakweapon(victimheldweapon) && !istrue(victim.inlaststand)) {
    weapons::savetogglescopestates();
    weapons::savealtstates();
  }

  victim nvg::savenvgstate();
  inventory::handleweaponchangecallbacksondeath();

  if(!isfauxdeath) {
    if(vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(victim)) {
      if(isDefined(victim.vehicle)) {
        victim.vehicle notify("player_killed_no_faux_death");
      }
    }
  } else {
    victim.fauxdead = 1;
    victim sethidenameplate(1);
    self notify("death");
    self notify("death_or_disconnect");
  }

  perks::updateactiveperks(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc, direction_vec);
  supers::updateactivesupers(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc, direction_vec);
  wristrocket::wristrocketcooksuicideexplodecheck(inflictor, attacker, victim, meansofdeath, objweapon);

  if(meansofdeath != "MOD_HEAD_SHOT" && !deathdata.isnukekill) {
    if(isDefined(level.custom_death_sound)) {
      [[level.custom_death_sound]](victim, meansofdeath, inflictor);
    } else if(meansofdeath != "MOD_MELEE") {
      victim sound::playdeathsound(meansofdeath);
    }
  }

  if(isDefined(level.custom_death_effect)) {
    [[level.custom_death_effect]](victim, meansofdeath, inflictor);
  }

  if(meansofdeath != "MOD_SUICIDE" && (game_utility::isaigameparticipant(victim) || game_utility::isaigameparticipant(attacker)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    killing_entity = [[level.bot_funcs["get_attacker_ent"]]](attacker, inflictor);

    if(isDefined(killing_entity)) {
      if(game_utility::isaigameparticipant(victim) && !isagent(victim)) {
        assert(!isDefined(killing_entity.classname) || killing_entity.classname != "<dev string:x2e9>" && killing_entity.classname != "<dev string:x2f7>");
        victim botmemoryevent("death", deathdata.weaponfullstring, killing_entity.origin, victim.origin, killing_entity);
      }

      if(game_utility::isaigameparticipant(attacker) && !isagent(attacker)) {
        var_6b82b9183bb9b5df = 1;

        if(isDefined(killing_entity.classname) && (killing_entity.classname == "script_vehicle" && isDefined(killing_entity.helitype) || killing_entity.classname == "rocket" || killing_entity.classname == "misc_turret")) {
          var_6b82b9183bb9b5df = 0;
        }

        if(var_6b82b9183bb9b5df) {
          attacker botmemoryevent("kill", deathdata.weaponfullstring, killing_entity.origin, victim.origin, victim);
        }
      }
    }
  }

  if((game_utility::isteamreviveenabled() || game_utility::isbrstylegametype() || victim perk::_hasperk("specialty_survivor")) && flags::gameflag("prematch_done") && !istrue(victim.hvtnorevive) && istrue(victim.inlaststand)) {
    laststand::ondeath(deathdata);
  }

  laststand::function_d393166ea9eab059(deathdata);

  if(game_utility::isteamreviveenabled() && flags::gameflag("prematch_done") && !istrue(victim.switching_teams)) {
    if(meansofdeath == "MOD_FALLING" && victim teamrevive::isvalidrevivetriggerspawnposition()) {
      victim teamrevive::setvalidreviveposition();
    }

    var_85a40249b07be68e = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(isDefined(level.var_a12ec32a24e1a367)) {
      [[level.var_a12ec32a24e1a367]](victim);
    }

    if(!var_85a40249b07be68e) {
      respawnitems = victim class::respawnitems_saveplayeritemstostruct();
    } else {
      respawnitems = self.juggcontext;
    }

    victim class::respawnitems_assignrespawnitems(respawnitems);
  }

  if(utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      victim challenges::stopchallengetimer("alive_in_gas");
      victim challenges::stopchallengetimer("alive_not_downed");

      if(istrue(level.br_prematchstarted) && !br_public::isplayeringulag()) {
        br_analytics::branalytics_inventory_snapshot(self, "player_death");
      }
    }
  }

  var_87f4e7d1a685aec1 = victim killstreak::iscontrollingproxyagent() ? victim.playerproxyagent : victim;

  if(attacker perk::_hasperk("specialty_scavenger")) {
    var_87f4e7d1a685aec1 thread weapons::dropscavengerfordeath(attacker, deathdata.meansofdeath);
  }

  if(getdvarint(@ "hash_5afa341109e3a9f4", 0)) {
    var_87f4e7d1a685aec1 thread weapons::function_7e895e1c85354e17(attacker, deathdata.meansofdeath);
  }

  var_87f4e7d1a685aec1[[level.weapondropfunction]](attacker, meansofdeath, undefined, damage);

  if(!isfauxdeath) {
    if(isPlayer(attacker)) {
      victim setclientomnvar("ui_killcam_killedby_id", attacker getentitynumber());
      victim setclientomnvar("ui_killcam_killedby_health_ratio", int(clamp(deathdata.attacker.health / deathdata.attacker.maxhealth * 127, 0, 127)));
    } else if(attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn") {
      victim setclientomnvar("ui_killcam_killedby_id", victim getentitynumber());
    } else {
      victim setclientomnvar("ui_killcam_killedby_id", -1);
    }

    newstate = "dead";

    if(istrue(self.liveragdoll)) {
      newstate = "playing_but_spectating";
    } else if(istrue(level.var_b7ad06255200033c)) {
      newstate = "spectator";
    }

    victim player::updatesessionstate(newstate);
  }

  var_63c3344d9c1f9816 = istrue(victim.fauxdead) && istrue(victim.switching_teams);

  if(!var_63c3344d9c1f9816) {
    if(!isDefined(level.modemayconsiderplayerdead) || [[level.modemayconsiderplayerdead]](victim)) {
      victim playerlogic::removefromalivecount(undefined, "playerKilled");
    }
  }

  if(!isDefined(victim.switching_teams)) {
    if(!istrue(level.ignorescoring) && !deathdata.isfriendlyfire) {
      if(!scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
        victim playerstats_interface::addtoplayerstat(1, "combatStats", "deaths");
      }

      if(victim scripts\mp\utility\stats::getpersstat("deaths") < 999) {
        victim stats::incpersstat("deaths", 1);
        victim.deaths = victim stats::getpersstat("deaths");
        victim persistence::statsetchild("round", "deaths", victim.deaths, level.ignorekdrstats);
      }
    }
  }

  obitmeansofdeath = meansofdeath;

  if(isDefined(deathdata.idflags) && deathdata.idflags & 8 && !(deathdata.idflags & 16384)) {
    if(isDefined(attacker.bulletkillsinaframecount) && attacker.bulletkillsinaframecount == 0) {
      obitmeansofdeath = "MOD_PENETRATION";

      if(isPlayer(attacker)) {
        attacker thread points::givexpwithtext(#"penetration_kill");
      }
    }
  } else if(objweapon.basename == "semtex_xmike109_mp" && deathdata.hitloc == "head" || deathdata.hitloc == "helmet") {
    obitmeansofdeath = "MOD_HEAD_SHOT";
  }

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.iswztrain)) {
    obitmeansofdeath = "MOD_CRUSH";
  }

  if(game_utility::isbrstylegametype()) {
    obitplayers = [];

    if(isDefined(level.var_c5877dbe60fddbf6)) {
      obitplayers = level.var_c5877dbe60fddbf6;
    }

    if(obitmeansofdeath == "MOD_TRIGGER_HURT" && isDefined(level.var_c8936f922b7d32a1) && level.var_c8936f922b7d32a1.size > 0 && isDefined(deathdata.inflictor) && function_f3bb4f4911a1beb2("limbo", "isDeathBall", deathdata.inflictor)) {
      obitmeansofdeath = "MOD_EXPLOSIVE";
      objweapon = makeweapon("deathball_limbo");
    }

    if(isDefined(victim)) {
      victimteam = teams::getfriendlyplayers(victim.team, 0);

      if(isDefined(victimteam)) {
        obitplayers = utility::array_combine(obitplayers, victimteam);
      }
    }

    if(isDefined(attacker) && isPlayer(attacker)) {
      attackerteam = teams::getfriendlyplayers(attacker.team, 0);

      if(isDefined(attackerteam) && victim.team != attacker.team) {
        obitplayers = utility::array_combine(obitplayers, attackerteam);
      }
    }

    if(obitplayers.size > 0) {
      var_d7f5ef4a14230875 = utility::ter_op(vehicle::function_4687f4da72911323(deathdata), "MOD_EXPLOSIVE", obitmeansofdeath);
      obituary(victim, attacker, objweapon, var_d7f5ef4a14230875, obitplayers);
    }
  } else {
    var_aae3f6afd894e63a = objweapon;

    if(isDefined(obitmeansofdeath) && obitmeansofdeath == "MOD_EXPLOSIVE" && (!isDefined(var_aae3f6afd894e63a) || isnullweapon(var_aae3f6afd894e63a))) {
      var_aae3f6afd894e63a = makeweapon("obit_explosive");
    }

    var_d7f5ef4a14230875 = utility::ter_op(vehicle::function_4687f4da72911323(deathdata), "MOD_EXPLOSIVE", obitmeansofdeath);

    if(var_d7f5ef4a14230875 == "MOD_EXPLOSIVE" && isDefined(attacker) && attacker function_c14e8044664565ad(var_aae3f6afd894e63a)) {
      parentweapon = attacker function_1e3102980c3a4cc1(var_aae3f6afd894e63a);

      if(isDefined(parentweapon) && parentweapon.basename == "jup_jp31_dm_compound_mp") {
        var_aae3f6afd894e63a = parentweapon;
      }
    }

    obituary(victim, attacker, var_aae3f6afd894e63a, var_d7f5ef4a14230875);
  }

  victim updatedeathdetails(victim.attackers, victim.attackerdata, attacker);
  victim.lastbounty = bounty::playergetbountypoints();
  victim bounty::playerresetbountypoints();
  victim bounty::playerresetbountystreak();
  victim thread supers::handledeath(attacker);
  victim battlechatter_mp::onplayerkilled(inflictor, attacker, damage, meansofdeath, objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid);
  victim thread[[level.onplayerkilledcommon]](inflictor, attacker, damage, meansofdeath, objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid, weapon::iskillstreakweapon(victimheldweapon));

  if(isai(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
    victim thread[[level.bot_funcs["on_killed"]]](inflictor, attacker, damage, meansofdeath, deathdata.weaponfullstring, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid);
  }

  victimlifetime = (deathdata.deathtime - victim.spawntime) / 1000;

  if(isDefined(victim scripts\mp\utility\stats::getpersstat("shortestLife"))) {
    if(victim scripts\mp\utility\stats::getpersstat("shortestLife") == 0 || victimlifetime < victim scripts\mp\utility\stats::getpersstat("shortestLife")) {
      victim.pers["shortestLife"] = victimlifetime;
    }
  }

  if(isDefined(victim scripts\mp\utility\stats::getpersstat("shortestLife"))) {
    if(victim scripts\mp\utility\stats::getpersstat("longestLife") == 0 || victimlifetime > scripts\mp\utility\stats::getpersstat("longestLife")) {
      victim.pers["longestLife"] = victimlifetime;
    }
  }

  function_f9249bb06eb48092(deathdata);

  function_af3ebb9d1ecd18e7(deathdata);

  if(game_utility::function_ba5574c7f287c587()) {
    isplayerreloading = self isreloading();

    if(isplayerreloading) {
      var_5814d27874b48e54 = spawnStruct();
      var_5814d27874b48e54.player = self;
      var_5814d27874b48e54.reloadcanceltime = getsystemtimeinmicroseconds();
      var_5814d27874b48e54.cancelreason = "DEATH";
      namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_on_reload_cancel", var_5814d27874b48e54);
    }

    if(isDefined(attacker) && isDefined(attacker.team)) {
      level notify("kill_player_" + attacker.team, attacker, victim);
    }
  }
}

function playerkilled_logkill(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  weaponfullstring = deathdata.weaponfullstring;
  meansofdeath = deathdata.meansofdeath;
  lifeid = deathdata.lifeid;
  victim utility::trycall(level.clientmatchdata_logplayerdeath, attacker);
  namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_player_death", deathdata);
  victim analyticslog::logevent_path();
  victim analyticslog::logevent_playerdeath(attacker, meansofdeath, weaponfullstring);
  attacker analyticslog::logevent_playerkill(victim, meansofdeath, weaponfullstring);

  if(isDefined(attacker) && isPlayer(attacker)) {}

  if(isPlayer(attacker) && attacker != self && (!level.teambased || level.teambased && self.team != attacker.team)) {
    var_d4b54dc4008c298c = victim.lastdroppableweaponobj;

    if(isDefined(var_d4b54dc4008c298c) && isDefined(inflictor)) {
      var_d4b54dc4008c298c = mapweapon(var_d4b54dc4008c298c, inflictor);
      var_b2b6cafcdb2218d2 = getcompleteweaponname(var_d4b54dc4008c298c);

      if(var_b2b6cafcdb2218d2.size > 0 && meansofdeath.size > 0) {
        thread scripts\mp\gamelogic::trackleaderboarddeathstats(attacker, victim, var_b2b6cafcdb2218d2, meansofdeath);
      }
    }

    if(weaponfullstring.size > 0 && meansofdeath.size > 0) {
      thread scripts\mp\gamelogic::trackattackerleaderboarddeathstats(attacker, victim, weaponfullstring, meansofdeath);
    }
  } else if(isagent(attacker) && attacker != self && (!level.teambased || level.teambased && self.team != attacker.team)) {
    var_d4b54dc4008c298c = victim.lastdroppableweaponobj;
    var_d4b54dc4008c298c = weapon::mapweapon(var_d4b54dc4008c298c, inflictor);
    var_b2b6cafcdb2218d2 = getcompleteweaponname(var_d4b54dc4008c298c);
    victim thread gamelogic::threadedsetweaponstatbyname(var_b2b6cafcdb2218d2, 1, "deaths", attacker);
  }

  if(isDefined(level.matchrecording_logeventmsg) && isDefined(inflictor) && isPlayer(inflictor) && utility::isbulletdamage(meansofdeath)) {
    toinflictor = inflictor.origin - victim.origin;
    var_a25e56f3ab389dbc = vectorNormalize((toinflictor[0], toinflictor[1], 0));
    playerdir = anglesToForward(victim.angles);
    var_71082de84d50d735 = vectorNormalize((playerdir[0], playerdir[1], 0));
    var_eec27afb6560632a = clamp(var_71082de84d50d735[0] * var_a25e56f3ab389dbc[0] + var_71082de84d50d735[1] * var_a25e56f3ab389dbc[1], -1, 1);
    angle = acos(var_eec27afb6560632a);

    if(!isDefined(victim.sidekillcount)) {
      victim.sidekillcount = 0;
    }

    if(angle > 75) {
      victim.sidekillcount++;
    }

    engagementtime = 0;

    if(isDefined(victim.engagementstarttime)) {
      engagementtime = gettime() - victim.engagementstarttime;
    }

    if(!isDefined(victim.engagementtime)) {
      victim.engagementtime = 0;
      victim.engagementcount = 0;
    }

    victim.engagementtime += engagementtime;
    victim.engagementcount++;
    victim.engagementstarttime = undefined;
  }

  updatecombatrecordkillstats(attacker, victim, meansofdeath, objweapon);
}

function playerkilled_finddeathtype(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  meansofdeath = deathdata.meansofdeath;

  if(victim isswitchingteams()) {
    return "deathType_switchingTeams";
  }

  if(!isPlayer(attacker) || isPlayer(attacker) && meansofdeath == "MOD_FALLING") {
    return "deathType_worldDeath";
  }

  if(attacker == victim || !player_utility::playersareenemies(attacker, victim) && entity::isdronepackage(inflictor)) {
    return "deathType_suicide";
  }

  if(deathdata.isfriendlyfire && !deathdata.isnukekill) {
    return "deathType_friendlyFire";
  }

  if(istrue(victim.inlaststand)) {
    return "deathType_inLastStand";
  }

  return "deathType_normal";
}

function playerkilled_handledeathtype(deathdata) {
  victim = deathdata.victim;
  deathdata.deathtype = playerkilled_finddeathtype(deathdata);
  isfauxdeath = istrue(deathdata.isfauxdeath);

  if(!isfauxdeath || getdvarint(@ "hash_896b182fbfa8d9de", 0)) {
    victim notify("player_fatal_death");
  }

  switch (deathdata.deathtype) {
    case #"hash_fea1e712b5740278":
      handleteamchangedeath();
      break;
    case #"hash_1184b43822fe56f0":
      handleworlddeath(deathdata, deathdata.attacker, deathdata.lifeid, deathdata.meansofdeath, deathdata.hitloc);
      break;
    case #"hash_c03eabf71149f406":
      handlesuicidedeath(deathdata.meansofdeath, deathdata.hitloc);
      break;
    case #"hash_e97320d8279bef45":
      handlefriendlyfiredeath(deathdata);
      break;
    case #"hash_ce250de499ae9603":
      handleinlaststanddeath(deathdata);
      break;
    case #"hash_a9f265ec10b615d":
      handlenormaldeath(deathdata.lifeid, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.meansofdeath, victim, deathdata.iskillstreakweapon, deathdata);
      break;
    default:
      assertmsg("<dev string:x307>" + deathdata.deathtype + "<dev string:x320>");
      break;
  }

  function_8be77b53bcbd6d2d(deathdata.attacker, 0);

  function_f9249bb06eb48092(deathdata);

  function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_sharedlogic_late(deathdata) {
  playerkilled_handlecorpse(deathdata);
  outofbounds::clearoob(self, 1);
  setdeathtimerlength(deathdata);
  attacker = deathdata.attacker;

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if(!isPlayer(attacker)) {
    deathdata.dokillcam = 0;
    deathdata.dofinalkillcam = 0;
  }

  thread function_c3599460c850b0f7();

  if(level.killcam || level.finalkillcamenabled) {
    playerkilled_killcamsetup(deathdata);
  }

  if(game_utility::isbrstylegametype()) {
    br_analytics::branalytics_down(deathdata.attacker, deathdata.victim, deathdata.objweapon, deathdata.deathtype, deathdata.meansofdeath);
  }

  thread challenges::ondeath(deathdata.inflictor, deathdata.attacker, deathdata.damage, deathdata.damageflags, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.attacker.modifiers);

  if(!game_utility::runleanthreadmode() || getdvarint(@ "hash_ee4a7c4b0cf8c75b", 1)) {
    playerkilled_logkill(deathdata);
  }

  if(isDefined(level.var_cc2c79de99db62c) && level.var_cc2c79de99db62c) {
    codcasterclientmatchdata::function_94c8f3722d550646();
    level.var_cc2c79de99db62c = 0;
  }

  if(isDefined(deathdata.objweapon) && deathdata.objweapon.basename == "jup_jp35_sn_moscar_mp" && deathdata.objweapon hasattachment("jup_jp35_sn_moscar_bar_blund")) {
    if(!isDefined(deathdata.direction_vec)) {
      damagedirection = anglesToForward(attacker.angles);
    } else {
      damagedirection = deathdata.direction_vec;
    }

    var_451ae3c06028a7ae = distance(deathdata.attacker.origin, deathdata.victim.origin);
    scale = lerp(1, 0.33, var_451ae3c06028a7ae / 300);
    var_fa6c1ef67f69ac61 = 8000 * scale;

    if(var_fa6c1ef67f69ac61 < 0) {
      var_fa6c1ef67f69ac61 = 0;
    }

    deathdata.victim.body startragdollfromimpact("torso_lower", damagedirection * var_fa6c1ef67f69ac61);
  }

  namespace_e2785bb1da360f91::function_eceb462b367e4b04(deathdata);
  callback::callback("player_death", deathdata);

  if(function_6b9f8406e6153597()) {
    if(isDefined(attacker) && isPlayer(attacker)) {
      attacker function_410078bd7a6f4a1(1);
    }

    if(isDefined(deathdata.victim) && isPlayer(deathdata.victim)) {
      deathdata.victim function_410078bd7a6f4a1(2);
    }
  }

  function_f9249bb06eb48092(deathdata);

  function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_handlecorpse(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  meansofdeath = deathdata.meansofdeath;
  objweapon = deathdata.objweapon;
  isfauxdeath = deathdata.isfauxdeath;
  hitloc = deathdata.hitloc;
  var_f5b166094dc876c1 = 0;

  if(isDefined(victim)) {
    if(function_f3bb4f4911a1beb2("limbo", "isOnSpaceShipment", victim)) {
      victim.nocorpse = 1;
    }
  }

  if(isDefined(victim.carryobject) && !isfauxdeath) {
    victim notify("drop_called");
    victim.carryobject thread gameobjects::setdropped();
  }

  if(game_utility::isteamreviveenabled() && !outofbounds::isoob(self) && flags::gameflag("prematch_done") && level.teambased) {
    if(istrue(level.var_2a91b79384531432)) {
      level callback::callback("on_revive_trigger_requested", deathdata);
    } else {
      level thread teamrevive::spawnrevivetrigger(victim, attacker, "new_trigger_spawned", meansofdeath);
    }
  }

  vehicle::vehicle_playerkilledbycollision(deathdata);

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse)) {
    if(istrue(self.liveragdoll)) {
      victim.body = victim;
    } else {
      victim.body = victim cloneplayer(deathdata.deathanimduration, attacker);
      victim.body.targetname = "player_corpse";
    }

    debug::function_57f3a2089db4a571(victim.body);
  }

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse) && isDefined(victim.body)) {
    if(!isDefined(victim.switching_teams)) {
      if(isDefined(attacker) && isPlayer(attacker)) {
        thread deathicons::adddeathicon(attacker, victim.body, victim, victim.team, 5);
      }

      var_e707f0032fa7b4bb = [];
      var_b8f254d4fd3f46a2 = [];

      foreach(index, player in level.players) {
        if(isDefined(victim)) {
          if(istrue(player_utility::playersareenemies(player, victim)) && player perk::_hasperk("specialty_kill_report")) {
            var_e707f0032fa7b4bb[index] = player;
            continue;
          }

          if(player iscodcaster()) {
            var_b8f254d4fd3f46a2[index] = player;
          }
        }
      }

      if(var_e707f0032fa7b4bb.size > 0 || var_b8f254d4fd3f46a2.size > 0) {
        thread deathicons::addenemydeathicon(victim.body, victim, var_e707f0032fa7b4bb, var_b8f254d4fd3f46a2, getdvarfloat(@ "hash_77d5a9878cbf3172"), 1);
      }
    }

    if(!istrue(self.liveragdoll)) {
      if(deathdata.isnukekill) {}

      if(deathdata.isfauxdeath) {
        victim scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
        victim scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("damage::PlayerKilled_handleCorpse()");
        victim setsolid(0);
      }

      victim thread _startragdoll(deathdata.victim.body, deathdata.meansofdeath, deathdata.inflictor);
    }

    victim thread callcorpsetablefuncs();

    if(!istrue(deathdata.assistedsuicide)) {
      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        if(getsubgametype() == "dmz" && istrue(self.liveragdoll)) {
          var_f5b166094dc876c1 = 1;
        } else if(isDefined(level.pleaforhelp)) {
          var_f5b166094dc876c1 = !istrue(scripts\mp\plea_for_help::function_bfdfd3c9ba0cc7cb(victim));
        } else {
          var_f5b166094dc876c1 = 1;
        }
      } else {
        var_f5b166094dc876c1 = 1;
      }
    }

    if(istrue(var_f5b166094dc876c1)) {
      victim namespace_46e942396566f2da::function_1dd3a521ea9ecf27(attacker, objweapon, meansofdeath, hitloc, inflictor, deathdata.executionref, deathdata.damageflags);
    }
  } else if(!istrue(self.liveragdoll)) {
    if(isDefined(victim.nocorpse) && !istrue(victim.skipcorpse)) {
      victim.body = victim cloneplayer(deathdata.deathanimduration);
      victim.body hide(1);
    }
  }

  if(!istrue(game["isLaunchChunk"])) {
    victim.streaktype = class::loadout_getplayerstreaktype(victim.streaktype);
    var_3e4944bceee5519 = killstreak_utility::function_9f1dc821e9a8506();

    if(killstreaks::streaktyperesetsondeath(victim.streaktype)) {
      if(!level.casualscorestreaks && !victim perk::_hasperk("specialty_support_killstreaks") && !var_3e4944bceee5519) {
        victim killstreaks::resetstreakpoints();
        victim killstreaks::resetstreakavailability();
        return;
      }

      if(level.casualscorestreaks && !var_3e4944bceee5519) {
        shouldreset = killstreaks::checkcasualstreaksreset();

        if(shouldreset) {
          victim killstreaks::resetstreakpoints();
          victim killstreaks::resetstreakavailability();
        }

        return;
      }

      if(var_3e4944bceee5519) {
        if(getdvarint(@ "hash_9e63e7a9c6f6ee4c", 1) == 1) {
          victim killstreaks::function_21e35dd4600c80a7();
        }

        victim killstreaks::function_e90a1856110e006a(attacker);
        victim killstreaks::resetstreakavailability();
      }
    }
  }
}

function _startragdoll(corpse, meansofdeath, inflictor) {
  if(!isDefined(corpse)) {
    return;
  }

  corpse endon("death");
  deathanim = corpse getcorpseanim();
  animduration = 0;

  if(animisleaf(deathanim)) {
    animduration = getanimlength(deathanim);
  }

  startdelay = undefined;
  vehicle = player_utility::getvehicle();
  hitbyvehicle = playerkilled_washitbyvehicle(meansofdeath, inflictor);
  var_6126d8436c986baf = undefined;
  deletecorpse = animhasnotetrack(deathanim, "delete_corpse");
  deletecorpsedelayed = animhasnotetrack(deathanim, "delete_corpse_delayed");
  noragdoll = animhasnotetrack(deathanim, "no_ragdoll");
  hasstartdelay = animhasnotetrack(deathanim, "start_ragdoll");

  if(isDefined(vehicle) || isDefined(self.var_e9a71c27fef1b65a) && isDefined(self.externalvehicle)) {
    if(isDefined(vehicle)) {
      var_6126d8436c986baf = vehicle_occupancy::vehicle_occupancy_getoccupantseat(vehicle, self);
    } else {
      vehicle = self.externalvehicle;
      var_6126d8436c986baf = self.var_e9a71c27fef1b65a;
    }

    if(noragdoll || hasstartdelay) {
      vehicle_occupancy::vehicle_occupancy_linkseatcorpse(corpse, vehicle, var_6126d8436c986baf);
      corpse setcorpsefalling(0);
      corpse.linktooriginandangles = vehicle_occupancy::vehicle_occupancy_linktooriginandangles(vehicle, var_6126d8436c986baf);
    }

    if(deletecorpse || deletecorpsedelayed || noragdoll || hasstartdelay) {
      deleteonseatenter = !noragdoll && !hasstartdelay || isDefined(self.externalvehicle);
      duration = utility::ter_op(deletecorpsedelayed, animduration, animduration + 3);
      thread playerkilled_deletecorpseoutofvehicle(corpse, vehicle, var_6126d8436c986baf, duration, deleteonseatenter);
    }
  }

  if(meansofdeath != "mod_execution" && meansofdeath != "MOD_MELEE_TAKEDOWN" && !noragdoll) {
    startdelay = 0;

    if(hasstartdelay && animduration > 0) {
      startfraction = getnotetracktimes(deathanim, "start_ragdoll")[0];
      startdelay = startfraction * animduration;
    }

    if(hitbyvehicle) {
      startdelay = 0;
    }
  }

  if(isDefined(startdelay)) {
    wait startdelay;

    if(!isDefined(corpse)) {
      return;
    }

    if(isDefined(vehicle)) {
      corpse thread _unlinkcorpsefromvehicle(vehicle, var_6126d8436c986baf, deletecorpse, deletecorpsedelayed, startdelay, animduration);
      corpse notify("cancel_delete_corpse");
      vehicle_occupancy::vehicle_occupancy_clearseatcorpse(corpse, vehicle, var_6126d8436c986baf);
      return;
    }

    if(!corpse isragdoll()) {
      if(hitbyvehicle) {
        corpse startragdollfromvehiclehit(inflictor);
      } else {
        corpse startragdoll();
      }
    }

    if(isDefined(level.var_83ed94a4c034a642)) {
      self thread[[level.var_83ed94a4c034a642]](corpse, animduration);
      return;
    }

    [var_b2afba0be4e4e55, var_cff2e3774745e3dd] = function_cd0171313cca081();

    if(isDefined(var_b2afba0be4e4e55) && isDefined(var_cff2e3774745e3dd)) {
      corpse thread function_c837dcc441a2d51b(var_b2afba0be4e4e55, var_cff2e3774745e3dd);
      return;
    }

    corpse thread _donewithcorpse(deletecorpse, deletecorpsedelayed, startdelay, animduration);
  }
}

function _donewithcorpse(deletecorpse, deletecorpsedelayed, startdelay, animduration) {
  corpse = self;

  if(deletecorpse || deletecorpsedelayed) {
    deletedelay = animduration;

    if(deletecorpsedelayed) {
      animduration += 3;
    }

    if(isDefined(startdelay)) {
      deletedelay -= startdelay;
    }

    wait deletedelay;

    if(!isDefined(corpse)) {
      return;
    }

    corpse delete();
    return;
  }

  if(!game_utility::isteamreviveenabled() && !isagent(self)) {
    corpse setplayercorpsedone();
  }
}

function function_c837dcc441a2d51b(var_b2afba0be4e4e55, var_cff2e3774745e3dd) {
  corpse = self;
  level endon("game_ended");

  if(isDefined(var_b2afba0be4e4e55) && isDefined(var_cff2e3774745e3dd) && var_cff2e3774745e3dd > 0) {
    corpse utility::waittill_notify_or_timeout(var_b2afba0be4e4e55, var_cff2e3774745e3dd);
  }

  if(isDefined(corpse)) {
    corpse delete();
  }
}

function function_cd0171313cca081() {
  player = self;

  if(isDefined(level.var_d40354696b3b8b2)) {
    return player[[level.var_d40354696b3b8b2]]();
  } else if(istrue(player.gulag)) {
    arena = namespace_de6eb888abbe38e1::function_2f4344abdc200e43(player);

    if(!isDefined(arena) || !isDefined(arena.time)) {
      return [undefined, undefined];
    } else {
      return ["corpse_manually_deleted", arena.time];
    }
  }

  return [undefined, undefined];
}

function _unlinkcorpsefromvehicle(vehicle, var_6126d8436c986baf, deletecorpse, deletecorpsedelayed, startdelay, animduration) {
  corpse = self;
  var_78235dcdec40f390 = getdvarint(@ "hash_7c902421e1883986", 1);
  var_14615b298620c411 = !var_78235dcdec40f390;
  immediateragdoll = getdvarint(@ "hash_c041b4135b55d8b7", 1);

  if(var_78235dcdec40f390) {
    if(!corpse isragdoll()) {
      corpse startragdoll(immediateragdoll);
    }
  }

  waittime = getdvarfloat(@ "hash_7d1401b6075479ac", 0.1);

  if(waittime > 0) {
    wait waittime;
  }

  if(isDefined(corpse)) {
    if(isDefined(corpse.linktooriginandangles) && isDefined(vehicle)) {
      originoffset = (0, 0, 0);
      linktooriginandangles = vehicle_occupancy::vehicle_occupancy_linktooriginandangles(vehicle, var_6126d8436c986baf);
      originoffset = linktooriginandangles.origin - corpse.linktooriginandangles.origin;
      corpseorigin = corpse.origin + originoffset;
      var_a918f1be2147ec75 = linktooriginandangles.angles;
      corpse trajectoryupdateoriginandangles(corpseorigin, var_a918f1be2147ec75);
    }

    corpse unlink();

    if(var_14615b298620c411) {
      corpse startragdoll(immediateragdoll);
    }

    corpse thread _donewithcorpse(deletecorpse, deletecorpsedelayed, startdelay, animduration);
  }
}

function playerkilled_deletecorpseoutofvehicle(corpse, vehicle, seatid, duration, deleteonseatenter) {
  corpse endon("death");
  corpse endon("cancel_delete_corpse");
  vehicle_occupancy::vehicle_occupancy_assignseatcorpse(corpse, vehicle, seatid, deleteonseatenter);
  vehicle utility::waittill_any_timeout_1(duration, "death");

  if(isDefined(corpse)) {
    corpse delete();
  }
}

function playerkilled_washitbyvehicle(meansofdeath, inflictor) {
  if(meansofdeath != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(inflictor)) {
    return false;
  }

  if(!inflictor vehicle::isvehicle()) {
    return false;
  }

  return true;
}

function playerkilled_killcamsetup(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  meansofdeath = deathdata.meansofdeath;
  objweapon = deathdata.objweapon;
  executionref = deathdata.executionref;

  if(isDefined(attacker) && istrue(attacker.assistedsuicide) || level.teambased && isDefined(attacker) && utility::is_equal(attacker.team, victim.team) || istrue(level.var_c2111af4e4ece485)) {
    deathdata.dokillcam = 0;
    deathdata.dofinalkillcam = 0;
  }

  if(!isDefined(deathdata.killcamentity)) {
    deathdata.killcamentity = victim killcam::getkillcamentity(attacker, inflictor, objweapon, meansofdeath);
  }

  if(isDefined(deathdata.killcamentity)) {
    deathdata.killcamentityindex = deathdata.killcamentity getentitynumber();
    deathdata.killcamentitystarttime = deathdata.killcamentity.birthtime;

    if(!isDefined(deathdata.killcamentitystarttime)) {
      deathdata.killcamentitystarttime = 0;
    }
  }

  if(getdvarint(@ "scr_forcekillcam") != 0) {
    deathdata.dokillcam = 1;
  }

  if(isDefined(inflictor) && istrue(deathdata.inflictor.var_26fb072855fd4772)) {
    deathdata.dokillcam = 1;
  }

  if(deathdata.dokillcam) {
    victim killcam::prekillcamnotify(attacker);

    if(isDefined(inflictor) && isagent(inflictor)) {
      deathdata.inflictoragentinfo = spawnStruct();
      deathdata.inflictoragentinfo.agent_type = inflictor.agent_type;
      deathdata.inflictoragentinfo.lastspawntime = inflictor.lastspawntime;
    }
  }

  deathdata.killcamentstickstovictim = meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_HEAD_SHOT" && isDefined(inflictor) || meansofdeath == "MOD_GRENADE" || isDefined(victim) && isDefined(victim.stuckbygrenade) && isDefined(inflictor) && victim.stuckbygrenade == inflictor || objweapon.basename == "throwingknifec4_mp";

  if(!deathdata.iskillstreakweapon || function_1a9394eb58e66a9b(objweapon)) {
    killcam::setkillcamnormalweaponomnvars(objweapon, meansofdeath, inflictor, executionref, attacker);
  }

  attackerisvalid = isDefined(attacker) && isDefined(attacker.classname) && attacker.classname != "trigger_hurt" && attacker.classname != "worldspawn" && attacker != victim;

  if(level.recordfinalkillcam && deathdata.dofinalkillcam) {
    if(!istrue(level.disable_killcam) && meansofdeath != "MOD_SUICIDE" && attackerisvalid) {
      final_killcam::recordfinalkillcam(5, victim, attacker, deathdata.attackerentnum, inflictor, deathdata.killcamentityindex, deathdata.killcamentitystarttime, deathdata.killcamentstickstovictim, objweapon, deathdata.psoffsettime, meansofdeath);
    }
  }

  function_f9249bb06eb48092(deathdata);

  function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_deathscene(deathdata) {
  victim = deathdata.victim;
  victim endon("spawned");

  if(victim spawncamera::function_581a8fc6f76d525d()) {
    victim spawncamera::function_cdff2f0b5dcf3aa1();
  }

  if(!deathdata.isfauxdeath) {
    if(!isDefined(victim.respawntimerstarttime)) {
      victim.respawntimerstarttime = gettime() + deathdata.deathscenetimems;
    }

    wait deathdata.deathscenetimesec;

    if(deathdata.dokillcam) {
      skipkillcam = final_killcam::skipkillcamduringdeathtimer(0.5);
      deathdata.dokillcam = isDefined(skipkillcam) && !skipkillcam;
    }

    if(isDefined(victim)) {
      victim notify("death_delay_finished");

      if(getdvarint(@ "hash_8d86e6b3c30bfbf1", 1) == 1 && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        victim thread scripts\mp\playerlogic::function_5c5f27d13e5eb129();
      }
    }
  } else if(!isDefined(victim.respawntimerstarttime)) {
    victim.respawntimerstarttime = gettime();
  }

  function_f9249bb06eb48092(deathdata);
}

function playerkilled_killcam(var_7ce346cc7a54d100) {
  deathdata = var_7ce346cc7a54d100;

  if(!isDefined(deathdata.victim) || istrue(deathdata.victim.skipkillcam)) {
    return;
  }

  deathtime = deathdata.victim.deathtime;

  if(getdvarint(@ "hash_98f5c716d594181b", 1) && isDefined(deathdata.victim.laststanddowneddata)) {
    deathdata = deathdata.victim.laststanddowneddata;
    deathdata.victim.laststanddowneddata = undefined;
    deathdata.dokillcam = var_7ce346cc7a54d100.dokillcam && isPlayer(deathdata.attacker);
    deathtime = deathdata.deathtime;
  }

  if(isDefined(level.modevalidatekillcam)) {
    [[level.modevalidatekillcam]](deathdata);
  }

  if(!isDefined(deathtime)) {
    return;
  }

  if(isDefined(level.var_85cda66c74550adc)) {
    result = deathdata.victim[[level.var_85cda66c74550adc]]();

    if(result) {
      return;
    }
  }

  deathdata.victim endon("spawned");
  victim = deathdata.victim;
  attacker = deathdata.attacker;
  postdeathdelay = (gettime() - deathtime) / 1000;

  if(!istrue(victim.cancelkillcam) && deathdata.dokillcam && level.killcam && game["state"] == "playing" && !victim isusingremote() && !level.showingfinalkillcam && !istrue(level.var_904aa57b8b22090c)) {
    timeuntilspawn = playerlogic::timeuntilspawn(1);
    attackerperks = [];
    defaultperks = function_87c3b562f2b366ee(attacker);
    perklist = attacker.loadoutperks;

    if(!isDefined(perklist) && isDefined(attacker.pers) && array_contains_key(attacker.pers, "loadoutPerks")) {
      perklist = attacker.pers["loadoutPerks"];
    }

    if(isDefined(perklist)) {
      foreach(perk in perklist) {
        if(perk != "" && perk != "none" && perk != "specialty_null" && !array_contains(attackerperks, perk) && (!isDefined(defaultperks) || defaultperks.size == 0 || !array_contains(defaultperks, perk))) {
          attackerperks[attackerperks.size] = perk;
        }
      }
    }

    if(!istrue(level.disablecopycatloadout)) {
      victim thread startcopycatoption(attacker);
    }

    skippable = 1;
    victim killcam::killcam(deathdata.inflictor, deathdata.inflictoragentinfo, deathdata.attackerentnum, deathdata.killcamentityindex, deathdata.killcamentitystarttime, undefined, deathdata.killcamentstickstovictim, deathdata.objweapon, postdeathdelay, deathdata.psoffsettime, timeuntilspawn, gamelogic::timeuntilroundend(), attacker, victim, deathdata.meansofdeath, attackerperks, skippable);

    if(isDefined(victim) && !istrue(level.disablecopycatloadout)) {
      victim thread stopcopycatoption();
    }

    if(isDefined(level.onpostkillcamcallback)) {
      [[level.onpostkillcamcallback]]();
    }
  }

  if(isDefined(victim)) {
    victim.var_7c813e50ff75be27 = 0;
  }

  function_f9249bb06eb48092(var_7ce346cc7a54d100);
}

function playerkilled_spawn(deathdata) {
  victim = deathdata.victim;

  if(!isDefined(victim)) {
    return;
  }

  if(isDefined(level.modeplayerkilledspawn) && [[level.modeplayerkilledspawn]](deathdata, 1)) {
    return;
  }

  if(istrue(victim.liveragdoll)) {
    return;
  }

  victim endon("spawned");
  victim endon("disconnect");
  attacker = deathdata.attacker;
  victim resetplayervariables();
  victim resetplayeromnvarsonspawn();

  if(isDefined(attacker)) {
    victim.lastattacker = attacker;
  } else {
    victim.lastattacker = undefined;
  }

  victim.wantsafespawn = 0;

  if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    victim adjustvoxelhead(1);
  }

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      victim player::updatesessionstate("dead");
      victim player::clearkillcamstate();
    }

    return;
  }

  if(class::isvalidclass(victim.class)) {
    victim thread playerlogic::spawnclient();
  }
}

function playerkilled_internal(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  victim endon("spawned");

  if(game["state"] == "postgame") {
    return;
  }

  deathdata = victim playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath);
  playerkilled_parameterfixup(deathdata);
  playerkilled_precalc(deathdata);
  playerkilled_sharedlogic_early(deathdata);
  playerkilled_handledeathtype(deathdata);
  playerkilled_sharedlogic_late(deathdata);
  playerkilled_deathscene(deathdata);
  playerkilled_killcam(deathdata);
  playerkilled_spawn(deathdata);
}

function isswitchingteams() {
  if(isDefined(self.switching_teams)) {
    return true;
  }

  return false;
}

function isteamswitchbalanced() {
  playercounts = teams::countplayers();
  playercounts[self.leaving_team]--;
  playercounts[self.joining_team]++;
  return playercounts[self.joining_team] - playercounts[self.leaving_team] < 2;
}

function isfriendlyfire(victim, attacker) {
  if(!level.teambased) {
    return false;
  }

  if(!isDefined(attacker)) {
    return false;
  }

  if(!isPlayer(attacker) && !isDefined(attacker.team)) {
    return false;
  }

  if(victim.team != attacker.team) {
    return false;
  }

  if(victim == attacker) {
    return false;
  }

  return true;
}

function killedself(attacker) {
  if(!isPlayer(attacker)) {
    return false;
  }

  if(attacker != self) {
    return false;
  }

  return true;
}

function handleteamchangedeath() {
  if(!level.teambased) {
    return;
  }

  assert(self.leaving_team != self.joining_team);

  if(self.joining_team == "spectator" || !isteamswitchbalanced()) {
    playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
    stats::incpersstat("suicides", 1);
  }

  if(isDefined(level.onteamchangedeath)) {
    [[level.onteamchangedeath]](self);
  }
}

function handleworlddeath(deathdata, attacker, lifeid, smeansofdeath, shitloc) {
  victim = deathdata.victim;
  victim.deathspectatepos = victim.origin;

  if(!isDefined(attacker)) {
    return;
  }

  events::playerworlddeath(attacker, smeansofdeath);

  if(!isDefined(attacker.team) || attacker.team == "neutral" || attacker == victim) {
    handlesuicidedeath(smeansofdeath, shitloc);
    return;
  }

  assert(isagent(attacker) || teams::isgameplayteam(attacker.team) || teams::function_44a6f98cc3c0f5f4(attacker.team));

  if(level.teambased && attacker.team != self.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(attacker) || isagent(attacker)) && attacker.team != "spectator" || isDefined(attacker.damagetrigger)) {
      if(!level.gameended) {
        [[level.onnormaldeath]](self, attacker, lifeid, smeansofdeath);
      }
    }
  }

  if(isagent(attacker) || teams::function_44a6f98cc3c0f5f4(attacker.team)) {
    deathdata.dokillcam = 1;
    thread handlenormaldeath_sounds(attacker, victim, smeansofdeath);
  }
}

function handlesuicidedeath(smeansofdeath, shitloc) {
  playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
  stats::incpersstat("suicides", 1);
  codcasterclientmatchdata::function_5a82c337b996baa5(6, 0);
  scoresub = tweakables::gettweakablevalue("game", "suicidepointloss");
  gamescore::_setplayerscore(self, gamescore::_getplayerscore(self) - scoresub);

  if(weapons::grenadeheldatdeath() && smeansofdeath == "MOD_SUICIDE" && shitloc == "none") {
    self.lastgrenadesuicidetime = gettime();
  }

  if(isDefined(level.onsuicidedeath)) {
    [[level.onsuicidedeath]](self);
  }

  if(isDefined(level.onplayerkilledcallback)) {
    self[[level.onplayerkilledcallback]](undefined, 0);
  }

  self.suicidespawndelay = 1;

  if(isDefined(self.friendlydamage)) {
    self.friendlyfiredeath = 1;
  }

  thread function_4e8bd2bd787c0dda(smeansofdeath);
}

function handlefriendlyfiredeath(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  meansofdeath = deathdata.meansofdeath;
  var_f03e984a6fb59137 = 0;

  if(meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH") {
    var_da0825016d12704e = function_1823ff50bb28148d(game_utility::getbasegametype());

    if(var_da0825016d12704e == #"control" || var_da0825016d12704e == #"koth") {
      if(isDefined(victim.isonobjective) && istrue(victim.isonobjective)) {
        var_f03e984a6fb59137 = 1;
      }
    }
  } else if(istrue(deathdata.iskillstreakweapon)) {
    var_f03e984a6fb59137 = 1;
  }

  if(istrue(deathdata.var_bfcdebee0e8a3189)) {
    return;
  }

  if(var_f03e984a6fb59137 && attacker.pers["teamkills"] < level.maxallowedteamkills) {
    return;
  }

  attacker thread rank::scoreeventpopup(#"teamkill");
  attacker.pers["teamkills"] = attacker.pers["teamkills"] + 1;
  victim codcasterclientmatchdata::function_5a82c337b996baa5(6, 0);

  if(tweakables::gettweakablevalue("team", "teamkillpointloss")) {
    scoresub = rank::getscoreinfovalue(#"kill");
    gamescore::_setplayerscore(attacker, gamescore::_getplayerscore(attacker) - scoresub);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }

  teamkilldelay = attacker playerlogic::teamkilldelay();

  if(teamkilldelay > 0) {
    attacker.pers["teamKillPunish"] = 1;
    attacker notify("team_kill_punish");

    if(attacker utility::isusingremote()) {
      attacker thread suicide_on_end_remote();
    } else {
      attacker thread suicide_on_alive();
    }
  }

  if(level.friendlyfire == 4) {
    if(!istrue(attacker.pers["hitFFLimit"]) && attacker.pers["teamkills"] >= level.maxallowedteamkills) {
      attacker.pers["hitFFLimit"] = 1;
      attacker hud_message::showerrormessage("MP/FRIENDLY_FIRE_PUNISH_SWITCH");
      return;
    }

    if(istrue(level.var_7d731c7dcbefbf3d)) {
      attacker hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
    }
  }
}

function handleinlaststanddeath(deathdata) {
  if(istrue(level.gamemodebundle.var_198508771f0592a9)) {
    attacker = self.laststandattacker;
    inflictor = self.laststanddowneddata.inflictor;
    objweapon = self.laststanddowneddata.objweapon;
    meansofdeath = self.laststanddowneddata.meansofdeath;

    if(!isDefined(inflictor)) {
      inflictor = self.laststanddowneddata.inflictorcopy;
    }

    if(isDefined(self.attackers)) {
      foreach(var_7694fc472af9f89d in self.attackers) {
        if(var_7694fc472af9f89d == attacker) {
          continue;
        }

        if(!isDefined(var_7694fc472af9f89d.modifiers)) {
          var_7694fc472af9f89d.modifiers = [];
        }
      }
    }

    if(isbot(deathdata.victim) && getdvarint(@ "hash_e125675f281d4f47", 0) == 1) {
      deathdata.dokillcam = 0;
    }

    handlenormaldeath(deathdata.lifeid, attacker, inflictor, objweapon, meansofdeath, self, deathdata.iskillstreakweapon, deathdata, 0);
  } else {
    if(!istrue(deathdata.victim.disable_killcam)) {
      deathdata.dokillcam = 1;
    }

    if(isbot(deathdata.victim) && getdvarint(@ "hash_e125675f281d4f47", 0) == 1) {
      deathdata.dokillcam = 0;
    }

    if(!deathdata.iskillstreakweapon) {
      deathdata.attacker thread points::function_e3e3e81453fd788b(#"hash_4b2faaeab2b30db", deathdata.objweapon, deathdata.victim);
    }

    if(isDefined(self.laststandattacker)) {
      self.laststandattacker playerincrementscoreboardkills();
    }

    var_24244b97c44b0386 = undefined;

    if(isDefined(self.laststandattacker) && deathdata.attacker != self.laststandattacker) {
      var_24244b97c44b0386 = 1;
      thread challenges::onplayerkilled(self.laststandattacker, self.laststandattacker, 0, deathdata.damageflags, self.laststandmeansofdeath, self.laststandweaponobj, deathdata.hitloc, self.laststandattackermodifiers);

      if(isDefined(level.onplayerkilledcallback)) {
        self[[level.onplayerkilledcallback]](self.laststandattacker, 0);
      }

      self.laststandattacker thread rank::scoreeventpopup(#"kill_confirmed");
    }

    var_b9c265f657115663 = 0;

    if(istrue(var_24244b97c44b0386)) {
      var_b9c265f657115663 = 1;
    }

    handlenormaldeath(deathdata.lifeid, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.meansofdeath, self, deathdata.iskillstreakweapon, deathdata, 1, var_b9c265f657115663);
  }

  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststandattackermodifiers = undefined;
}

function function_11ea8154fd8726c5(var_306f84215cfc4820) {
  if(!isDefined(var_306f84215cfc4820)) {
    return "";
  }

  var_f1758d2a7814ab9b = function_5deea0be9aafcdd4(var_306f84215cfc4820);

  if(isDefined(var_f1758d2a7814ab9b) && var_f1758d2a7814ab9b != "") {
    return var_f1758d2a7814ab9b;
  }

  return "";
}

function handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor, var_10e1ef8c47f876d8, var_306f84215cfc4820) {
  var_e08e0d086a79892b = 0;
  ent = victim;

  if(!isDefined(attacker.lastkillalertsoundtime)) {
    attacker.lastkillalertsoundtime = gettime();
    var_e08e0d086a79892b = 1;
  } else if(gettime() > attacker.lastkillalertsoundtime + 700) {
    attacker.lastkillalertsoundtime = gettime();
    var_e08e0d086a79892b = 1;
  }

  var_31920aa482f41ae8 = !game_utility::function_b2c4b42f9236924() || getdvarint(@ "hash_c2989c398361dbb3", 0) != 0;
  var_e7d4a41e01c7228c = game_utility::function_b2c4b42f9236924() && getdvarint(@ "hash_58f2c5b698828174", 0) != 0;

  if(function_80ade967129c9845()) {} else if(isagent(attacker) || teams::function_44a6f98cc3c0f5f4(attacker.team)) {
    if(!utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {} else if(smeansofdeath == "MOD_HEAD_SHOT") {
      ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
      ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    } else {
      ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
    }
  } else if(!utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {
    if(var_e08e0d086a79892b) {
      if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
        soundtoplay = "mp_kill_alert" + function_11ea8154fd8726c5(var_306f84215cfc4820);
        attacker playlocalsound(soundtoplay);
      } else {
        attacker playlocalsound("mp_kill_alert_quiet");
      }
    }
  } else if(smeansofdeath == "MOD_HEAD_SHOT" && var_31920aa482f41ae8) {
    ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
    ent playsoundtoplayer("bullet_impact_headshot", attacker);

    if(var_e08e0d086a79892b) {
      soundtoplay = "mp_headshot_alert" + function_11ea8154fd8726c5(var_306f84215cfc4820);
      attacker playlocalsound(soundtoplay);
    }

    ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
  } else {
    ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);

    if(var_e08e0d086a79892b) {
      killalert = utility::ter_op(var_e7d4a41e01c7228c, "mp_kill_alert_quiet", "mp_kill_alert");

      if(!var_e7d4a41e01c7228c) {
        killalert += function_11ea8154fd8726c5(var_306f84215cfc4820);
      }

      attacker playlocalsound(killalert);
    }
  }

  if(isPlayer(victim)) {
    if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE") {
      victim playlocalsound("deaths_door_death_quiet");
    } else if(smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN") {
      victim playlocalsound("deaths_door_death");
    }

    victim setentitysoundcontext("deaths_door", "", 0.1);
    victim scripts\common\damage_effects::function_a2b4e6088394bade(2);
    victim notify("deaths_door_exit");
    victim.deathsdoor = 0;

    if(getdvarint(@ "hash_4392ab54b296ef96", 0) != 0) {
      if(function_950c8234f03299d4()) {
        if(isDefined(var_10e1ef8c47f876d8) && var_10e1ef8c47f876d8 != "") {
          victim playlocalsound(var_10e1ef8c47f876d8);
        }

        return;
      }

      function_5013853947770621(#"hash_e4a6063613016089");
    }
  }
}

function function_4e8bd2bd787c0dda(smeansofdeath) {
  if(isPlayer(self)) {
    if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE") {
      self playlocalsound("deaths_door_death_quiet");
    } else if(smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN") {
      self playlocalsound("deaths_door_death");
    }

    self setentitysoundcontext("deaths_door", "", 0.1);
    thread scripts\common\damage_effects::function_a2b4e6088394bade(2);
    self notify("deaths_door_exit");
    self.deathsdoor = 0;
  }
}

function function_80ade967129c9845() {
  return istrue(level.var_57ece26e490ad8c4);
}

function handlenormaldeath(lifeid, attacker, einflictor, objweapon, smeansofdeath, victim, iskillstreakweapon, deathdata, var_c7944407e05a6f77, var_b9c265f657115663) {
  if(smeansofdeath == "MOD_GRENADE" && einflictor == attacker) {
    addattacker(victim, attacker, einflictor, objweapon, deathdata.damage, (0, 0, 0), deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, smeansofdeath);
  }

  deathdata.dokillcam = 1;

  if(isai(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
    deathdata.dokillcam = victim[[level.bot_funcs["should_do_killcam"]]]();
  }

  if(istrue(level.disable_killcam) || istrue(victim.disable_killcam)) {
    deathdata.dokillcam = 0;
  }

  attacker thread events::killedplayer(lifeid, self, objweapon, smeansofdeath, einflictor, deathdata);

  if(!isbrstylegametype() || !isbot(victim)) {
    if(isbulletdamage(smeansofdeath) || ismeleedamage(smeansofdeath) || islauncherweapon(objweapon)) {
      attacker thread namespace_4925be476a433a59::function_4552872977024e34(victim);
    }

    if(isbrstylegametype()) {
      attacker thread namespace_4925be476a433a59::function_b96bbb38cfb63125();
    }
  }

  if(!istrue(level.disablestattracking)) {
    self.var_f215f63a4834bb72 = isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker;

    if(getdvarint(@ "hash_dda9d67c21b0f4b4", 0)) {
      victim thread scripts\cp_mp\challenges::onplayerkilled(einflictor, attacker, deathdata.damage, deathdata.damageflags, smeansofdeath, objweapon, deathdata.hitloc, attacker.modifiers);

      if(isDefined(level.onplayerkilledcallback)) {
        self[[level.onplayerkilledcallback]](attacker, istrue(var_b9c265f657115663));
      }
    } else if(!istrue(var_b9c265f657115663)) {
      victim thread scripts\cp_mp\challenges::onplayerkilled(einflictor, attacker, deathdata.damage, deathdata.damageflags, smeansofdeath, objweapon, deathdata.hitloc, attacker.modifiers);

      if(isDefined(level.onplayerkilledcallback)) {
        self[[level.onplayerkilledcallback]](attacker, 0);
      }
    }

    scripts\mp\codcasterclientmatchdata::function_6f792f70ffe4cd4d(attacker, victim);
    victim.pers["cur_death_streak"]++;

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker playerstats_interface::addtoplayerstat(1, "combatStats", "headshots");
      attacker stats::incpersstat("headshots", 1);
      attacker.headshots = attacker stats::getpersstat("headshots");
      attacker thread namespace_4925be476a433a59::function_f1b4726896f5c0c9();
      attacker thread namespace_4925be476a433a59::function_a4bd960925ab1205();

      switch (weaponclass(objweapon.basename)) {
        case #"hash_8cdaf2e4ecfe5b51":
          attacker stats::incpersstat("arHeadshots", 1);
          break;
        case #"hash_900cb96c552c5e8e":
          attacker stats::incpersstat("smgHeadshots", 1);
          break;
        case #"hash_690c0d6a821b42e":
          attacker stats::incpersstat("shotgunHeadshots", 1);
          break;
        case #"hash_fa24dff6bd60a12d":
          attacker stats::incpersstat("lmgHeadshots", 1);
          break;
        case #"hash_6191aaef9f922f96":
          attacker stats::incpersstat("sniperHeadshots", 1);
          break;
        case #"hash_61e969dacaaf9881":
          attacker stats::incpersstat("launcherHeadshots", 1);
          break;
        case #"hash_719417cb1de832b6":
          attacker stats::incpersstat("pistolHeadshots", 1);
          break;
      }
    }

    if(isDefined(einflictor) && istrue(einflictor.isequipment)) {
      switch (einflictor.equipmentref) {
        case #"hash_8c7819f0a3fbd1e0":
          attacker stats::incpersstat("fragKills", 1);
          break;
        case #"hash_f0907f858c134cb4":
          attacker stats::incpersstat("semtexKills", 1);
          break;
        case #"hash_142a787e36d7d7ce":
          attacker stats::incpersstat("molotovKills", 1);
          break;
        case #"hash_2354208d9af64220":
          attacker stats::incpersstat("claymoreKills", 1);
          break;
        case #"hash_184d8c620fb78060":
        case #"hash_9ba0a6ff6081954e":
        case #"hash_acc752b9cde2ff4f":
          attacker stats::incpersstat("throwingKnifeKills", 1);
          attacker pet_watch::addthrowingknifecharge();
          break;
        case #"hash_4320d77f90725183":
          attacker stats::incpersstat("c4Kills", 1);
          break;
        case #"hash_de4641ddbc44a7ba":
          attacker stats::incpersstat("thermiteKills", 1);
          break;
        case #"hash_3995658e01f4fac1":
          attacker stats::incpersstat("proximityMineKills", 1);
          break;
      }
    }
  }

  if(isDefined(einflictor) && istrue(einflictor.var_26fb072855fd4772)) {
    return;
  }

  var_10e1ef8c47f876d8 = function_57803ce293ce78c4(objweapon.basename);
  thread handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor, var_10e1ef8c47f876d8, objweapon);
  var_d2db6cb7f6d5d36d = attacker;

  if(isDefined(attacker.commanding_bot)) {
    var_d2db6cb7f6d5d36d = attacker.commanding_bot;
  }

  if(!istrue(var_c7944407e05a6f77) && !isfriendlyfire(victim, attacker)) {
    attacker function_213650502f1ed86f(victim);
    attacker function_53931e410002911f(objweapon);
  }

  if(!istrue(level.disablestattracking)) {
    codcasterclientmatchdata::function_5a82c337b996baa5(6, 0);

    if(isPlayer(attacker) && !scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename)) {
      attacker codcasterclientmatchdata::function_1882f80b14421089(6, 1);
      consecutivekills = attacker.var_1a34ed8eb5c6e9c[6];

      if(!(consecutivekills % 5)) {
        if(!game_utility::isbrstylegametype()) {
          namespace_31d46e80f376f2f7::function_7d42d3f8dd68280c(13, attacker.team, attacker getentitynumber(), consecutivekills);
        }
      }
    }
  }

  if(!istrue(var_d2db6cb7f6d5d36d.pers["ignoreWeaponMatchBonus"]) && (weapon::iscacprimaryweapon(objweapon) || weapon::iscacsecondaryweapon(objweapon))) {
    if(!isDefined(var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"])) {
      var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"] = 1;
    } else {
      var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"]++;
    }

    if(var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"] > weaponrank::getgametypekillspermatchmaximum()) {
      var_d2db6cb7f6d5d36d.pers["ignoreWeaponMatchBonus"] = 1;
      var_d2db6cb7f6d5d36d.pers["weaponMatchBonusKills"] = undefined;
      var_d2db6cb7f6d5d36d.pers["killsPerWeapon"] = undefined;
    } else {
      if(!isDefined(var_d2db6cb7f6d5d36d.pers["killsPerWeapon"])) {
        var_d2db6cb7f6d5d36d.pers["killsPerWeapon"] = [];
      }

      rootname = weapon::getweaponrootname(objweapon);
      weaponfound = 0;

      foreach(weaponkey, data in var_d2db6cb7f6d5d36d.pers["killsPerWeapon"]) {
        if(isDefined(rootname) && weaponkey == rootname) {
          data.killcount++;
          weaponfound = 1;
          break;
        }
      }

      if(isDefined(rootname) && !weaponfound) {
        data = spawnStruct();
        data.killcount = 1;
        data.basename = objweapon.basename;
        data.orderindex = var_d2db6cb7f6d5d36d.pers["killsPerWeapon"].size;
        var_d2db6cb7f6d5d36d.pers["killsPerWeapon"][rootname] = data;
      }
    }
  }

  lastkillstreak = attacker.pers["cur_kill_streak"];

  if(!istrue(level.ignorescoring) && (isalive(attacker) || isDefined(attacker.streaktype) && attacker.streaktype == "support")) {
    if(smeansofdeath == "MOD_MELEE" && !attacker killstreak::isjuggernaut() || attacker killstreak::killshouldaddtokillstreak(objweapon)) {
      attacker registerkill(objweapon, smeansofdeath, 1, iskillstreakweapon);
    }

    if(attacker.pers["cur_kill_streak"] > attacker stats::getpersstat("longestStreak")) {
      attacker.pers["longestStreak"] = attacker.pers["cur_kill_streak"];
    }
  }

  attacker.pers["cur_death_streak"] = 0;

  if(!game_utility::runleanthreadmode()) {
    if(!istrue(level.ignorescoring) && attacker.pers["cur_kill_streak"] > attacker persistence::statgetchild("round", "killStreak")) {
      attacker persistence::statsetchild("round", "killStreak", attacker.pers["cur_kill_streak"]);
    }

    if(!istrue(level.ignorescoring) && attacker game_utility::onlinestatsenabled()) {
      if(attacker.pers["cur_kill_streak"] > attacker.bestlifetimekillstreak) {
        attacker playerstats_interface::setplayerstat(attacker.pers["cur_kill_streak"], "bestStats", "killStreak");
        attacker.bestlifetimekillstreak = attacker.pers["cur_kill_streak"];
      }
    }
  }

  if(istrue(level.gamemodebundle.var_198508771f0592a9)) {
    attacker function_1306e8a08ab7bbab(victim, objweapon, einflictor, iskillstreakweapon);
  } else if(!istrue(iskillstreakweapon) && !weapon::iskillstreakvehicleinflictor(einflictor) || points::isforcekillstreakprogressweapon(objweapon)) {
    attacker thread events::killeventtextpopup(#"kill", 0);
    pointoverride = undefined;

    if(game_utility::isbrstylegametype() && !flags::gameflag("prematch_done")) {
      pointoverride = 100;
    }

    xpoverride = undefined;

    if(istrue(level.var_f60a3be40c34023d)) {
      xpoverride = getdvarint(@ "hash_defd7006efde9127", 100);
    }

    attacker thread points::doscoreevent(#"kill", objweapon, pointoverride, xpoverride, victim);
    attacker bounty::bountyincreasestreak();
    attacker bounty::bountycollect(victim.lastbounty, victim.origin);
  }

  scoresub = tweakables::gettweakablevalue("game", "deathpointloss");

  if(isDefined(level.gunshipplayer) && level.gunshipplayer == attacker) {
    level notify("ai_killed", self);
  }

  gamescore::_setplayerscore(self, gamescore::_getplayerscore(self) - scoresub);
  level notify("player_got_killstreak_" + attacker.pers["cur_kill_streak"], attacker);
  attacker notify("killed_enemy");

  if(isDefined(level.onnormaldeath) && isDefined(attacker.pers) && attacker.pers["team"] != "spectator" && !istrue(level.ignorescoring)) {
    [[level.onnormaldeath]](self, attacker, lifeid, smeansofdeath, objweapon, iskillstreakweapon);
  }

  if(!attacker utility::isusingremote()) {
    weaponlist = victim getweaponslistprimaries();
    wassniper = 0;

    foreach(weapon in weaponlist) {
      if(weaponclass(weapon.basename) == "sniper") {
        wassniper = 1;
        break;
      }
    }

    if(wassniper) {
      level thread battlechatter_mp::trysaylocalsound(attacker, #"bc_combat_killfirm_sniper", undefined, 0.75);
    } else {
      level thread battlechatter_mp::trysaylocalsound(attacker, #"bc_combat_killfirm_infantry", undefined, 0.75);
    }
  }

  vocallout = undefined;

  switch (victim.loadoutarchetype) {
    case #"hash_98ff6f21872f18e0":
      vocallout = "plr_killfirm_warfighter";
      break;
  }

  if(isDefined(vocallout)) {
    level thread battlechatter_mp::saytoself(attacker, vocallout, "plr_killfirm_generic", 0.75);
  }

  if(istrue(self.var_f215f63a4834bb72) && !istrue(level.disablestattracking)) {
    var_6d6b794a7b5386a0 = getdvarint(@ "hash_89c66b6f125f4f6", 2500);

    if(deathdata.deathtime - self.lastattackedshieldtime < var_6d6b794a7b5386a0) {
      self.lastattackedshieldplayer thread gamescore::processshieldassist(self);
    } else if(isalive(self.lastattackedshieldplayer) && deathdata.deathtime - self.lastattackedshieldtime < 5000) {
      forwardvec = vectorNormalize(anglesToForward(self.angles));
      shieldvec = vectorNormalize(self.lastattackedshieldplayer.origin - self.origin);

      if(vectordot(shieldvec, forwardvec) > 0.925) {
        self.lastattackedshieldplayer thread gamescore::processshieldassist(self);
      } else {
        self.lastattackedshieldplayer scripts\mp\gamescore::function_5a687b65c904b197(attacker, self, attacker.team);
      }
    } else {
      self.lastattackedshieldplayer scripts\mp\gamescore::function_5a687b65c904b197(attacker, self, attacker.team);
    }
  }

  if(!game_utility::runleanthreadmode()) {
    gamescore::awardbuffdebuffassists(attacker, self);
  }

  var_986a03ff4ba86052 = 1;

  if(!istrue(level.disablestattracking) && isDefined(self.attackers)) {
    var_ae089731ca00d639 = 0;

    if(istrue(level.gamemodebundle.var_198508771f0592a9)) {
      var_ae089731ca00d639 = level.gamemodebundle.var_ae089731ca00d639 * 1000;
    }

    foreach(player in self.attackers) {
      if(isDefined(level.assists_disabled)) {
        continue;
      }

      if(!isDefined(player) || !isDefined(player.guid)) {
        continue;
      }

      if(!isDefined(_validateattacker(player))) {
        continue;
      }

      if(getdvarint(@ "hash_dda9d67c21b0f4b4", 0)) {
        if(player == attacker) {
          continue;
        }
      } else if(!istrue(var_b9c265f657115663) && player == attacker || istrue(var_b9c265f657115663) && player == self.laststandattacker) {
        continue;
      }

      if(self == player) {
        continue;
      }

      if(istrue(level.var_c9c83bd1de3cbfa6) && isagent(player)) {
        continue;
      }

      attackerdata = self.attackerdata[player.guid];
      assert(isDefined(attackerdata));
      assistweapon = attackerdata.objweapon;

      if(istrue(level.gamemodebundle.var_198508771f0592a9)) {
        if(istrue(self.inlaststand)) {
          if(attackerdata.lasttimedamaged < self.laststandstarttime) {
            timesincelastdamaged = self.laststandstarttime - attackerdata.lasttimedamaged;

            if(timesincelastdamaged > var_ae089731ca00d639) {
              continue;
            }
          }
        } else {
          timesincelastdamaged = deathdata.deathtime - attackerdata.lasttimedamaged;

          if(timesincelastdamaged > var_ae089731ca00d639) {
            continue;
          }
        }
      }

      if(getdvarint(@ "hash_dda9d67c21b0f4b4", 0)) {
        if(!(istrue(var_b9c265f657115663) && isDefined(self.laststandattacker) && player == self.laststandattacker)) {
          bonusmagnitude = 0;

          if(isDefined(attackerdata.damage)) {
            if(attackerdata.damage >= 70) {
              bonusmagnitude = 2;
            } else if(attackerdata.damage >= 35) {
              bonusmagnitude = 1;
            }
          }

          player thread gamescore::processassist(self, assistweapon, bonusmagnitude);
        }
      } else {
        bonusmagnitude = 0;

        if(isDefined(attackerdata.damage)) {
          if(attackerdata.damage >= 70) {
            bonusmagnitude = 2;
          } else if(attackerdata.damage >= 35) {
            bonusmagnitude = 1;
          }
        }

        player thread gamescore::processassist(self, assistweapon, bonusmagnitude);
      }

      var_986a03ff4ba86052 = 0;

      if(isDefined(player.super)) {
        if(player.super.staticdata.ref == "super_battlerage") {
          player battlerage::function_3f783a5aca22152d();
        }
      }

      if(!isDefined(player.equipment)) {
        player.equipment = [];
      }

      if(isDefined(player.equipment["secondary"]) && player.equipment["secondary"] == "equip_battlerage") {
        if(istrue(player.var_808d06ddfc93a4e4)) {
          player battlerage::function_9e87f6624dd929f1();
        }
      }

      if(player perk::_hasperk("specialty_boom")) {
        victim thread perkfunctions::setboominternal(player);
      }
    }
  }

  if(isDefined(attacker.pers["soloKills"]) && var_986a03ff4ba86052 && attacker.team != victim.team) {
    attacker stats::incpersstat("soloKills", 1);
  }

  if(isDefined(self.markedbyboomperk) && !istrue(level.disablestattracking)) {
    foreach(player in level.players) {
      if(player.team == self.team) {
        continue;
      }

      if(utility::array_contains(self.attackers, player)) {
        continue;
      }

      if(utility::array_contains_key(self.markedbyboomperk, player player::getuniqueid())) {
        player thread gamescore::processassist(self, objweapon);
      }
    }
  }

  if(level.teambased) {
    if(isDefined(attacker.team) && isDefined(level.uavmodels) && isDefined(level.uavmodels[attacker.team]) && level.uavmodels[attacker.team].size > 0) {
      uavtypes = [];

      foreach(uav in level.uavmodels[attacker.team]) {
        if(isDefined(uav) && isDefined(uav.owner) && uav.owner != attacker && !utility::array_contains(uavtypes, uav.uavtype)) {
          eventname = hashcat(function_1823ff50bb28148d(uav.uavtype), "_assist");
          pointsoverride = undefined;

          if(!isDefined(uav.assistsgiven)) {
            uav.assistsgiven = 0;
          }

          var_ccfe1eb50c191e67 = utility::ter_op(uav.uavtype == "directional_uav", 15, 10);

          if(uav.assistsgiven < var_ccfe1eb50c191e67 || level.var_d11891ea093da336) {
            eventinfo = spawnStruct();
            eventinfo.var_17f6b15ddeddd1f8 = 1;
            uav.owner thread points::doscoreevent(eventname, undefined, pointsoverride, undefined, undefined, undefined, undefined, undefined, uav.streakinfo, undefined, eventinfo);
          } else {
            uav.owner thread points::givexpwithtext(eventname, pointsoverride);
          }

          uav.assistsgiven++;

          switch (uav.uavtype) {
            case #"hash_634b246c3da5c56f":
              uav.owner stats::incpersstat("killstreakUAVAssists", 1);
              break;
            case #"hash_10e585c25e7e9f60":
              uav.owner stats::incpersstat("killstreakCUAVAssists", 1);
              break;
            case #"hash_e171e5b86ef0a4cc":
              uav.owner stats::incpersstat("killstreakAUAVAssists", 1);
              break;
          }

          uavtypes[uavtypes.size] = uav.uavtype;
          challenges::processuavassist(uav.owner, uav.uavtype);
          uav.owner script::bufferednotify("update_uav_assist_buffered");
          uav.owner combatrecordkillstreakstat(uav.uavtype);
        }
      }
    }

    if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
      foreach(drone in level.supportdrones) {
        if(level.teambased && drone.team == attacker.team && drone.owner != attacker) {
          if(isDefined(drone.enemiesmarked) && isDefined(self) && isDefined(drone.enemiesmarked[self getentitynumber()])) {
            drone.owner thread points::doscoreevent(hashcat(function_1823ff50bb28148d(drone.streakinfo.streakname), "_assist"));
          }
        }

        if(drone.helperdronetype == "scrambler_drone_guard") {
          if(level.teambased && drone.team == attacker.team && drone.owner != attacker) {
            eventname = hashcat(function_1823ff50bb28148d(drone.streakinfo.streakname), "_assist");

            if(!isDefined(drone.assistsgiven)) {
              drone.assistsgiven = 0;
            }

            if(drone.assistsgiven < 10 || level.var_d11891ea093da336) {
              eventinfo = spawnStruct();
              eventinfo.var_17f6b15ddeddd1f8 = 1;
              drone.owner thread points::doscoreevent(eventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, drone.streakinfo, undefined, eventinfo);
            } else {
              drone.owner thread points::givexpwithtext(eventname);
            }

            drone.assistsgiven++;
            drone.owner stats::incpersstat("killstreakCUAVAssists", 1);
          }
        }
      }
    }

    binoculars::binoculars_giveassistpoints(attacker, self);

    if(isDefined(attacker.team) && isDefined(level.activewpzones) && level.activewpzones.size > 0) {
      wpzone = level.activewpzones[0];
      var_bfb78b87a67e2eb9 = wpzone.owner;
      var_a9be838ef5e091ef = wpzone.team;

      if(attacker.team == var_a9be838ef5e091ef && attacker != var_bfb78b87a67e2eb9) {
        if(istrue(victim.wpdisorient) || istrue(victim.wpburning)) {
          eventname = #"hash_213b00973af47f5e";

          if(!isDefined(wpzone.assistsgiven)) {
            wpzone.assistsgiven = 0;
          }

          if(wpzone.assistsgiven < 15) {
            var_bfb78b87a67e2eb9 thread points::doscoreevent(eventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, wpzone.streakinfo);
          } else {
            var_bfb78b87a67e2eb9 thread points::givexpwithtext(eventname);
          }

          wpzone.assistsgiven++;
          var_bfb78b87a67e2eb9 stats::incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        }
      }
    }
  }

  if(isPlayer(attacker)) {
    function_b908a35b0981168e();

    if(!function_e42efe66fa95ca55()) {
      attacker setclientomnvar("ui_killed_player", self getentitynumber());
      attacker setclientomnvar("ui_killed_player_notify", deathdata.deathtime);
    }
  }

  if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    attacker adjustvoxelhead();
  }
}

function private function_72a7592cd2fc0b9a(headsize) {
  bitwidth = 8;
  bitoffset = 8;
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (int(clamp(headsize, 1, 3)) &mask) << bitoffset;
  var_f8f977081d3da8b4 = ~(mask << bitoffset);
  prevvalue = self.game_extrainfo;
  cleanedbase = prevvalue &var_f8f977081d3da8b4;
  var_82a90e56e416fa55 = cleanedbase + var_a463992091f1d483;
  self.game_extrainfo = var_82a90e56e416fa55;
}

function adjustvoxelhead(var_a9351fa416d5d33f) {
  headsize = 0;
  head = self.operatorcustomization.head;

  if(istrue(var_a9351fa416d5d33f)) {
    head = getsubstr(head, 0, head.size - 1) + "a";
    headsize = 1;
    self playsoundtoplayer("mp_jup_voxel_small_head", self);
  } else {
    lastcharacter = head[head.size - 1];

    if(lastcharacter == "a") {
      head = getsubstr(head, 0, head.size - 1) + "b";
      headsize = 2;
      self playsoundtoplayer("mp_jup_voxel_medium_head", self);
      head_c = getsubstr(head, 0, head.size - 1) + "c";
      self loadcustomization(self.operatorcustomization.body, head_c);
    } else if(lastcharacter == "b") {
      head = getsubstr(head, 0, head.size - 1) + "c";
      headsize = 3;
      self playsoundtoplayer("mp_jup_voxel_big_head", self);
    } else {
      return;
    }
  }

  self.operatorcustomization.head = head;

  if(!istrue(self.isjuggernaut)) {
    self setcustomization(self.operatorcustomization.body, head);
    scripts\mp\teams::setcharactermodels(self.operatorcustomization.body, head, self.operatorcustomization.vm);
  }

  if(headsize != 0) {
    self setclientomnvar("ui_voxel_head_size", headsize);
  }

  function_72a7592cd2fc0b9a(headsize);
}

function function_213650502f1ed86f(victim) {
  var_d2db6cb7f6d5d36d = self;

  if(!istrue(level.ignorescoring)) {
    var_d2db6cb7f6d5d36d playerincrementscoreboardkills();

    if(isbehindmeleevictim(var_d2db6cb7f6d5d36d, victim)) {
      var_d2db6cb7f6d5d36d incpersstat("killsFromBehind", 1);
      victim incpersstat("deathsFromBehind", 1);
    }

    return;
  }

  if(isDefined(level.prematchaddkillfunc)) {
    var_d2db6cb7f6d5d36d[[level.prematchaddkillfunc]]();
  }
}

function playerincrementscoreboardkills() {
  var_d2db6cb7f6d5d36d = self;

  if(!scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
    var_d2db6cb7f6d5d36d playerstats_interface::addtoplayerstat(1, "combatStats", "kills");
  }

  if(var_d2db6cb7f6d5d36d stats::getpersstat("kills") < 14999) {
    var_d2db6cb7f6d5d36d stats::incpersstat("kills", 1);
    var_d2db6cb7f6d5d36d.kills = var_d2db6cb7f6d5d36d stats::getpersstat("kills");
    var_d2db6cb7f6d5d36d persistence::statsetchild("round", "kills", var_d2db6cb7f6d5d36d.kills, level.ignorekdrstats);
  }
}

function function_53931e410002911f(killweapon) {
  if(!isDefined(self.var_445c8714ee8588d5)) {
    self.var_445c8714ee8588d5 = [];
    self.var_445c8714ee8588d5["ar"] = 0;
    self.var_445c8714ee8588d5["br"] = 0;
    self.var_445c8714ee8588d5["dmr"] = 0;
    self.var_445c8714ee8588d5["sniper"] = 0;
    self.var_445c8714ee8588d5["launcher"] = 0;
    self.var_445c8714ee8588d5["lmg"] = 0;
    self.var_445c8714ee8588d5["melee"] = 0;
    self.var_445c8714ee8588d5["pistol"] = 0;
    self.var_445c8714ee8588d5["shotgun"] = 0;
    self.var_445c8714ee8588d5["smg"] = 0;
    self.var_445c8714ee8588d5["other"] = 0;
  }

  weapongroup = getweapongroup(killweapon);

  switch (weapongroup) {
    case #"hash_8af0086b038622b5":
      self.var_445c8714ee8588d5["ar"] = self.var_445c8714ee8588d5["ar"] + 1;
      break;
    case #"hash_dd616da0b395a0b0":
      self.var_445c8714ee8588d5["br"] = self.var_445c8714ee8588d5["br"] + 1;
      break;
    case #"hash_47368bc0d2ef1565":
      self.var_445c8714ee8588d5["dmr"] = self.var_445c8714ee8588d5["dmr"] + 1;
      break;
    case #"hash_c095d67337b1f5a1":
      self.var_445c8714ee8588d5["sniper"] = self.var_445c8714ee8588d5["sniper"] + 1;
      break;
    case #"hash_9d18adab1b65a661":
      self.var_445c8714ee8588d5["launcher"] = self.var_445c8714ee8588d5["launcher"] + 1;
      break;
    case #"hash_bef5ec0b3e197ae":
      self.var_445c8714ee8588d5["lmg"] = self.var_445c8714ee8588d5["lmg"] + 1;
      break;
    case #"hash_86b11ac21f992552":
    case #"hash_a1f27f97be15d620":
      self.var_445c8714ee8588d5["melee"] = self.var_445c8714ee8588d5["melee"] + 1;
      break;
    case #"hash_34340d457a63e7f1":
      self.var_445c8714ee8588d5["pistol"] = self.var_445c8714ee8588d5["pistol"] + 1;
      break;
    case #"hash_16cf6289ab06bd30":
      self.var_445c8714ee8588d5["shotgun"] = self.var_445c8714ee8588d5["shotgun"] + 1;
      break;
    case #"hash_ab10f9c080fe4faf":
      self.var_445c8714ee8588d5["smg"] = self.var_445c8714ee8588d5["smg"] + 1;
      break;
    default:
      self.var_445c8714ee8588d5["other"] = self.var_445c8714ee8588d5["other"] + 1;
      break;
  }
}

function function_1306e8a08ab7bbab(victim, objweapon, einflictor, iskillstreakweapon) {
  if(istrue(einflictor.isequipment)) {
    assertex(isDefined(einflictor.equipmentref), "<dev string:x325>");
    equipmentbundle = level.equipment.table[einflictor.equipmentref].bundle;
    scoreevent = equipmentbundle.eliminationscoreevent;

    if(isDefined(scoreevent)) {
      thread points::doscoreevent(scoreevent, objweapon, undefined, undefined, victim);
      return;
    }
  } else if(istrue(einflictor.issuper)) {
    assertex(isDefined(einflictor.equipmentref), "<dev string:x354>");
    superbundle = level.superglobals.staticsuperdata["super_" + einflictor.equipmentref].bundle;
    scoreevent = superbundle.eliminationscoreevent;

    if(isDefined(scoreevent)) {
      thread points::doscoreevent(scoreevent, objweapon, undefined, undefined, victim);
      return;
    }
  } else if(istrue(iskillstreakweapon)) {
    assertex(isDefined(einflictor.streakinfo), "<dev string:x37f>");
    streakbundle = level.streakglobals.streakbundles[einflictor.streakinfo.streakname];
    scoreevent = streakbundle.eliminationscoreevent;

    if(isDefined(scoreevent)) {
      thread points::doscoreevent(scoreevent, objweapon, undefined, undefined, victim);
      return;
    }
  }

  thread points::doscoreevent(#"elimination_kill", objweapon, undefined, undefined, victim);
}

function callback_playerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration) {
  playerkilled_internal(inflictor, attacker, self, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, 0);
}

function launchshield(damage, meansofdeath) {
  if(riotshield::riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel)) {
      riotshield::riotshield_detach(1);
    }

    if(isDefined(self.riotshieldmodelstowed)) {
      riotshield::riotshield_detach(0);
    }
  }
}

function resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.pers["cur_kill_streak"] = 0;
  thread namespace_6b49ddb858f34366::function_d8eb5fb3b35ed1a1();
  self.killcountthislife = 0;
  self.laststandattacker = undefined;
  self.laststandattackermodifiers = undefined;
  gameobjects::detachusemodels();
}

function resetplayeromnvarsonspawn() {
  playerlogic::resetuiomnvarscommon();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
}

function hitlocdebug(attacker, victim, damage, hitloc, dflags) {
  colors = [];
  colors[0] = 2;
  colors[1] = 3;
  colors[2] = 5;
  colors[3] = 7;

  if(!getdvarint(@ "hash_8662c4d785d46fd6")) {
    return;
  }

  if(!isDefined(attacker.hitlocinited)) {
    for(i = 0; i < 6; i++) {
      attacker setclientdvar(hashcat(@ "hash_3dd1dde9508849d5", utility::string(i)), "");
    }

    attacker.hitlocinited = 1;
  }

  if(level.splitscreen || !isPlayer(attacker)) {
    return;
  }

  elemcount = 6;

  if(!isDefined(attacker.damageinfo)) {
    attacker.damageinfo = [];

    for(i = 0; i < elemcount; i++) {
      attacker.damageinfo[i] = spawnStruct();
      attacker.damageinfo[i].damage = 0;
      attacker.damageinfo[i].hitloc = "";
      attacker.damageinfo[i].bp = 0;
      attacker.damageinfo[i].colorindex = 0;
    }

    attacker.damageinfocolorindex = 0;
    attacker.damageinfovictim = undefined;
  }

  for(i = elemcount - 1; i > 0; i--) {
    attacker.damageinfo[i].damage = attacker.damageinfo[i - 1].damage;
    attacker.damageinfo[i].hitloc = attacker.damageinfo[i - 1].hitloc;
    attacker.damageinfo[i].bp = attacker.damageinfo[i - 1].bp;
    attacker.damageinfo[i].colorindex = attacker.damageinfo[i - 1].colorindex;
  }

  attacker.damageinfo[0].damage = damage;
  attacker.damageinfo[0].hitloc = hitloc;
  attacker.damageinfo[0].bp = dflags & 8;

  if(isDefined(attacker.damageinfovictim) && attacker.damageinfovictim != victim) {
    attacker.damageinfocolorindex++;

    if(attacker.damageinfocolorindex == colors.size) {
      attacker.damageinfocolorindex = 0;
    }
  }

  attacker.damageinfovictim = victim;
  attacker.damageinfo[0].colorindex = attacker.damageinfocolorindex;

  for(i = 0; i < elemcount; i++) {
    color = "^" + colors[attacker.damageinfo[i].colorindex];

    if(attacker.damageinfo[i].hitloc != "") {
      val = color + attacker.damageinfo[i].hitloc;

      if(attacker.damageinfo[i].bp) {
        val += " (BP)";
      }

      attacker setclientdvar(hashcat(@ "hash_3dd1dde9508849d5", utility::string(i)), val);
    }

    attacker setclientdvar(hashcat(@ "hash_9df3a18be699b19d", utility::string(i)), color + attacker.damageinfo[i].damage);
  }
}

function giverecentshieldxp() {
  self endon("death_or_disconnect");
  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");
  self.recentshieldxp++;
  wait 20;
  self.recentshieldxp = 0;
}

function updateinflictorstat(einflictor, eattacker, sweapon, otherent) {
  if(!isDefined(einflictor) || !isDefined(einflictor.alreadyhit) || !einflictor.alreadyhit || !weapon::issinglehitweapon(sweapon)) {
    gamelogic::setinflictorstat(einflictor, eattacker, sweapon);
  }

  if(isDefined(einflictor)) {
    einflictor.alreadyhit = 1;
  }
}

function addattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, var_1da1a66b5c6a06a7) {
  if(!isDefined(eattacker.guid) && (isagent(eattacker) || isPlayer(eattacker))) {
    eattacker.guid = eattacker scripts\mp\utility\player::getuniqueid();
  }

  if(!isDefined(eattacker.guid)) {
    return;
  }

  if(!isDefined(victim.attackerdata)) {
    victim.attackerdata = [];
  }

  currenttime = gettime();

  if(!isDefined(victim.attackerdata[eattacker.guid])) {
    victim.attackers[eattacker.guid] = eattacker;
    victim.attackerdata[eattacker.guid] = spawnStruct();
    victim.attackerdata[eattacker.guid].damage = 0;
    victim.attackerdata[eattacker.guid].var_d69d6cc16d8b71fb = 0;
    victim.attackerdata[eattacker.guid].attackerent = eattacker;
    victim.attackerdata[eattacker.guid].firsttimedamaged = currenttime;
    victim.attackerdata[eattacker.guid].hitcount = 0;
  }

  attackerdata = victim.attackerdata[eattacker.guid];

  if(isDefined(level.var_b5224f533f8fffb0) && isDefined(level.var_b5224f533f8fffb0[objweapon.basename]) && isDefined(level.var_b5224f533f8fffb0[objweapon.basename][eattacker.guid])) {
    objweapon = level.var_b5224f533f8fffb0[objweapon.basename][eattacker.guid];
  }

  if(iscacprimaryweapon(objweapon) && !iscacsecondaryweapon(objweapon)) {
    attackerdata.diddamagewithprimary = 1;
  }

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_MELEE") {
    attackerdata.didnonmeleedamage = 1;
  }

  equipmenttype = weapon::getequipmenttype(objweapon);

  if(isDefined(equipmenttype)) {
    if(equipmenttype == "lethal") {
      attackerdata.diddamagewithlethalequipment = 1;
    }

    if(equipmenttype == "tactical") {
      attackerdata.diddamagewithtacticalequipment = 1;
    }
  }

  idamage = default_to(idamage, 0);
  var_1da1a66b5c6a06a7 = default_to(var_1da1a66b5c6a06a7, 0);
  armorhealth = default_to(victim.armorhealth, 0);

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_SUICIDE") {
    totalhealth = victim.maxhealth + max(0, armorhealth) + var_1da1a66b5c6a06a7;
  } else {
    totalhealth = victim.health + max(0, armorhealth) + var_1da1a66b5c6a06a7;
  }

  totaldamage = idamage + var_1da1a66b5c6a06a7;
  var_d69d6cc16d8b71fb = ter_op(totaldamage > totalhealth, totalhealth, totaldamage);
  attackerdata scripts\common\damage_effects::updatefirsttimedamaged();
  attackerdata.hitcount++;
  attackerdata.damage += totaldamage;
  attackerdata.var_d69d6cc16d8b71fb += var_d69d6cc16d8b71fb;
  attackerdata.objweapon = objweapon;
  attackerdata.vpoint = vpoint;
  attackerdata.vdir = vdir;
  attackerdata.shitloc = shitloc;
  attackerdata.psoffsettime = psoffsettime;
  attackerdata.smeansofdeath = smeansofdeath;
  attackerdata.attackerent = eattacker;
  attackerdata.lasttimedamaged = currenttime;
  attackerdata.var_2c151652ca2c1756 = !isinlaststand(victim) || istrue(attackerdata.var_2c151652ca2c1756);
  attackerdata.inflictor = einflictor;
  attackerdata.var_4ce88b2dfe0bfa52 = istrue(victim.var_4ce88b2dfe0bfa52);

  if(!isDefined(attackerdata.damagesources)) {
    attackerdata.damagesources = [];
  }

  var_22de319bdc95fea2 = "none";
  equipref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

  if(isDefined(equipref)) {
    var_22de319bdc95fea2 = equipref;
  } else if(scripts\cp_mp\weapon::iskillstreakweapon(objweapon)) {
    var_22de319bdc95fea2 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(objweapon);
  } else if(isDefined(smeansofdeath) && (smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN")) {
    var_22de319bdc95fea2 = smeansofdeath;
  } else if(istrue(victim.islaststandbleedoutdmg) || istrue(victim.bleedout) || istrue(victim.var_4ce88b2dfe0bfa52)) {
    var_22de319bdc95fea2 = "BLEED_TICK";
  } else if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE" && isDefined(einflictor) && einflictor.code_classname == "scriptable") {
    var_22de319bdc95fea2 = "ENV_EXPLOSIVE";
  } else if(scripts\mp\utility\weapon::isbombsiteweapon(objweapon)) {
    var_22de319bdc95fea2 = "BOMB_SITE";
  } else if(istrue(victim.oobdeath)) {
    var_22de319bdc95fea2 = "OOB";
  } else if(isDefined(objweapon.basename)) {
    var_22de319bdc95fea2 = objweapon.basename;
  }

  if(!isDefined(attackerdata.damagesources[var_22de319bdc95fea2])) {
    attackerdata.damagesources[var_22de319bdc95fea2] = 1;
  }

  attackerdata.var_8519cf56b38d717d = var_22de319bdc95fea2;
}

function addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon) {
  if(!isDefined(victim.attackerdata)) {
    victim.attackerdata = [];
  }

  if(!isDefined(victim.attackerdata[eattacker.guid])) {
    victim.attackers[eattacker.guid] = eattacker;
    victim.attackerdata[eattacker.guid] = spawnStruct();
    victim.attackerdata[eattacker.guid].damage = 0;
    victim.attackerdata[eattacker.guid].attackerent = eattacker;
    victim.attackerdata[eattacker.guid].firsttimedamaged = gettime();
    victim.attackerdata[eattacker.guid].hitcount = 1;
  }

  victim.attackerdata[eattacker.guid] scripts\common\damage_effects::updatefirsttimedamaged();
  victim.attackerdata[eattacker.guid].damage += idamage;
  victim.attackerdata[eattacker.guid].vpoint = vpoint;
  victim.attackerdata[eattacker.guid].vdir = vdir;
  victim.attackerdata[eattacker.guid].partname = partname;
  victim.attackerdata[eattacker.guid].smeansofdeath = smeansofdeath;
  victim.attackerdata[eattacker.guid].attackerent = eattacker;
  victim.attackerdata[eattacker.guid].lasttimedamaged = gettime();
  victim.attackerdata[eattacker.guid].var_2c151652ca2c1756 = !isinlaststand(victim) || istrue(victim.attackerdata[eattacker.guid].var_2c151652ca2c1756);
}

function resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {
  dmgtime = gettime();
  callback_playerdamage_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1);
  assertex(dmgtime == gettime(), "<dev string:x3ae>");
}

function function_f9237ec4a57b0ff9(eattacker, var_ba9dc00e6d5896dc, idamage, fdistance, objweapon, shitloc) {
  if(shouldrecorddamagestats(eattacker)) {
    eattacker stats::incpersstat("damage", var_ba9dc00e6d5896dc);

    if(isDefined(eattacker scripts\mp\utility\stats::getpersstat("friendlyDamageDone")) && self.team == eattacker.team) {
      eattacker stats::incpersstat("friendlyDamageDone", var_ba9dc00e6d5896dc);
    }

    if(!isDefined(eattacker.damagethisround)) {
      eattacker.damagethisround = var_ba9dc00e6d5896dc;
    } else {
      eattacker.damagethisround += var_ba9dc00e6d5896dc;
    }

    if(eattacker != self && self.team != eattacker.team) {
      eattacker codcasterclientmatchdata::function_d16498b27251da56(1, var_ba9dc00e6d5896dc);
      fullweaponname = getcompleteweaponname(objweapon);
      incvalue = min(self.health, idamage);
      eattacker thread gamelogic::threadedsetweaponstatbyname(fullweaponname, incvalue, "damage", self);
    }

    if(shitloc == "head" && isDefined(eattacker scripts\mp\utility\stats::getpersstat("shotsHitHead"))) {
      eattacker stats::incpersstat("shotsHitHead", 1);
    }

    eattacker utility::trycall(level.matchdata_logweaponstat, weapon::getweaponrootname(objweapon), "damage", min(self.health, idamage), -1);
    weaponobj = weapon::mapweapon(objweapon);
    sweapon = getcompleteweaponname(weaponobj);
    eattacker thread gamelogic::threadedsetweaponstatbyname(sweapon, var_ba9dc00e6d5896dc, "damage_dealt");
    return;
  }

  if(isDefined(level.onattackerdamagenottracked)) {
    eattacker[[level.onattackerdamagenottracked]](var_ba9dc00e6d5896dc);
  }
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, armorhit, flinch) {
  idamage = int(idamage);
  var_ba9dc00e6d5896dc = int(min(idamage, self.health));

  if(isDefined(eattacker) && isPlayer(eattacker) && !function_483cc81bff18273b(eattacker)) {
    if(eattacker != self) {
      if(!isbrstylegametype() || !isbot(self)) {
        eattacker thread namespace_4925be476a433a59::function_e08012bdba393c79(objweapon, var_ba9dc00e6d5896dc);
        eattacker thread namespace_4925be476a433a59::function_f9b01f503cdbfd7d(var_ba9dc00e6d5896dc);
      }
    }

    function_f9237ec4a57b0ff9(eattacker, var_ba9dc00e6d5896dc, idamage, fdistance, objweapon, shitloc);
  } else if(isDefined(einflictor) && einflictor vehicle::isvehicle()) {
    vehicle = einflictor;

    if(isDefined(vehicle.owner) && isPlayer(vehicle.owner)) {
      function_f9237ec4a57b0ff9(vehicle.owner, var_ba9dc00e6d5896dc, idamage, fdistance, objweapon, shitloc);
    }
  }

  if(isPlayer(self)) {
    thread namespace_4925be476a433a59::function_99b3339dca12abde(var_ba9dc00e6d5896dc);
  }

  if(isPlayer(self) && shouldrecorddamagestats(self) && !function_483cc81bff18273b(self)) {
    weaponobj = self.lastdroppableweaponobj;
    weaponobj = weapon::mapweapon(weaponobj);
    sweapon = getcompleteweaponname(weaponobj);
    stats::incpersstat("damageTaken", var_ba9dc00e6d5896dc);
    thread gamelogic::threadedsetweaponstatbyname(sweapon, 1, "hit_markers_taken");
    thread gamelogic::threadedsetweaponstatbyname(sweapon, var_ba9dc00e6d5896dc, "damage_taken");
  }

  if(isDefined(einflictor) && isDefined(einflictor.streakinfo) && isDefined(einflictor.streakinfo.damage)) {
    einflictor.streakinfo.damage += idamage;
  }

  if(playershoulddofauxdeath() && idamage >= self.health && !(idflags & 16) && allowfauxdeath()) {
    if(!isDefined(vdir)) {
      vdir = (0, 0, 0);
    }

    if(!isDefined(eattacker)) {
      eattacker = self;
    }

    if(!isDefined(einflictor)) {
      einflictor = eattacker;
    }

    playerkilled_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 0, 1);
  } else {
    if(isDefined(self.var_5c11205f47af8b92)) {
      isfataldamage = idamage >= self.health;
      isvalidshielddamage = gettime() - self.var_5c11205f47af8b92 <= 1000 && riotshield::riotshield_hasweapon() && function_cd066c9463ad28c5(objweapon, smeansofdeath);
      var_ed364fc58a359515 = !utility::isusingremote();

      if(isfataldamage && isvalidshielddamage && var_ed364fc58a359515) {
        iprintln("<dev string:x3e8>" + self.name);

        self suicide();
        function_403e958ecd04f255(self, "forcing suicide on riot shield player");
        return;
      }
    }

    if(!callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime)) {
      function_403e958ecd04f255(self, "Callback_KillingBlow == false");
      return;
    }

    if(!isalive(self)) {
      function_403e958ecd04f255(self, "!IsAlive");
      return;
    }

    if(isPlayer(self)) {
      if(!isDefined(partname)) {
        partname = "";
      }

      if(!isDefined(armorhit)) {
        armorhit = 0;
      }

      if(shoulduseexplosiveindicator(smeansofdeath)) {
        idflags |= 256;
      }

      if(!isDefined(flinch)) {
        var_e9a18bdaf2a766e9 = smeansofdeath == "MOD_TRIGGER_HURT" && isDefined(self.islaststandbleedoutdmg);
        iscircledamage = smeansofdeath == "MOD_TRIGGER_HURT" && isDefined(objweapon) && objweapon.basename == "danger_circle_br";
        flinch = !var_e9a18bdaf2a766e9 && !iscircledamage;
      }

      if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
        if(!isDefined(eattacker.var_198b774c93c48891)) {
          eattacker.var_198b774c93c48891 = gettime();
        }
      }

      if(!isDefined(self.var_9691e7d8cde294f2)) {
        self.var_9691e7d8cde294f2 = gettime();
      }

      if(game_utility::isteamreviveenabled() && !ismutationgamemodezombie() && istrue(level.liveragdollrevive) && idamage >= self.health && !laststand::function_27d0ea02ed3cc35f(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 500) && (!istrue(level.var_46c429e667d32f63) || istrue(teams::getteamdata(self.team, "noRespawns")))) {
        if(istrue(self.inlaststand)) {
          self laststandrevive();
        }

        self notify("enter_live_ragdoll");
        idamage = self.health - 1;
        println("<dev string:x42f>" + gettime() + "<dev string:x435>" + self.name + "<dev string:x43b>" + self.health + "<dev string:x474>" + idamage + "<dev string:x489>");
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, 0, modelindex, partname, armorhit, flinch, fdistance);
        println("<dev string:x42f>" + gettime() + "<dev string:x435>" + self.name + "<dev string:x494>" + self.health + "<dev string:x4ce>");

        if(isDefined(einflictor) && isDefined(eattacker)) {
          self lookatkiller(einflictor, eattacker);
        }

        player::_freezecontrols(1, undefined, "liveRagdoll");
        self sethidenameplate(1);
        self.healthregendisabled = 1;
        self.liveragdoll = 1;
        self function_6b4c8718bc36d1ef(1);
        self function_e4ccd01fb7ec7a6f(1);
        self function_360874d9808f0724();
        class::setthirdpersonview();

        if(!isDefined(einflictor) && !isDefined(eattacker)) {
          einflictor = self;
          eattacker = self;
        }

        thread playerkilled_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 500, 0);

        if(getdvarint(@ "hash_8dab2b41a06260c6", 0) == 1) {
          self notify("death");
          self notify("death_or_disconnect");

          if(game_utility::function_ba5574c7f287c587()) {
            isplayerreloading = self isreloading();

            if(isplayerreloading) {
              var_5814d27874b48e54 = spawnStruct();
              var_5814d27874b48e54.player = self;
              var_5814d27874b48e54.reloadcanceltime = getsystemtimeinmicroseconds();
              var_5814d27874b48e54.cancelreason = "DEATH";
              namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_on_reload_cancel", var_5814d27874b48e54);
            }
          }
        }
      } else {
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, 0, modelindex, partname, armorhit, flinch, fdistance);
      }
    }
  }

  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
    shellshock_utility::_shellshock("damage_mp", "damage", getdvarfloat(@ "scr_csmode"), 0, 0);
  }

  damageshellshockandrumble(einflictor, objweapon, smeansofdeath, idamage, idflags, eattacker);
}

function shoulduseexplosiveindicator(smeansofdeath) {
  return smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_FIRE";
}

function callback_playerimpaled(eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b, isagent) {
  thread weapons::impale(eattacker, self, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b, isagent);
}

function function_b6ceceee10bc38d8(eattacker, objweapon, vdir, magnitude, shitloc, isagent) {
  if(!isDefined(objweapon)) {
    return;
  }

  if(!isDefined(magnitude)) {
    return;
  }

  if(isDefined(objweapon.weaponblueprint) && isDefined(objweapon.weaponblueprint.lootid) && objweapon.weaponblueprint.lootid == 64155) {
    magnitude *= 3;
    vdir = (vdir[0], vdir[1], vdir[2] + 0.5);
  }

  if(isDefined(objweapon.weaponblueprint) && isDefined(objweapon.weaponblueprint.lootid) && objweapon.weaponblueprint.lootid == 55571) {
    magnitude *= 9;
    vdir = (vdir[0], vdir[1], vdir[2] + 0.5);
  }

  if(objweapon.basename == "jup_jp23_me_shotel_mp") {
    if(objweapon hasattachment("zm_me_shotel")) {
      magnitude *= 1.1;
      vdir = (vdir[0], vdir[1], vdir[2] + 0.5);
    } else if(objweapon hasattachment("zm_me_shotel_pap")) {
      magnitude *= 2;
      vdir = (vdir[0], vdir[1], vdir[2] + 0.8);
    }
  }

  if(objweapon.basename == "jup_jp23_me_shotel_arcade_mp") {
    magnitude *= 3.5;
    vdir = (vdir[0], vdir[1], vdir[2] + 0.5);
    thread namespace_dfe80adf32f5c14a::function_a87a61b0dd6925c0(self, eattacker, vdir, magnitude);
  }

  weapons::launch(eattacker, self, objweapon, vdir, magnitude, shitloc, isagent);
}

function allowfauxdeath() {
  if(!isDefined(level.allowfauxdeath)) {
    level.allowfauxdeath = 1;
  }

  return level.allowfauxdeath;
}

function callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  forcelaststand = isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);
  var_4a823a0c8e9adbb7 = laststand::function_27d0ea02ed3cc35f(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration);

  if(!forcelaststand && !var_4a823a0c8e9adbb7) {
    return false;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && !istrue(attacker.gulag) && !istrue(level.var_fdb13ccd60afe05c)) {
    attacker thread hud_message::showsplash("br_enemy_downed", undefined, self);
  }

  if(isDefined(level.parachuteprelaststandfunc)) {
    self[[level.parachuteprelaststandfunc]]();
  }

  if(self isskydiving()) {
    self skydive_interrupt();
  }

  lifeid = self.matchdatalifeindex;

  if(!isDefined(lifeid)) {
    lifeid = level.maxlives - 1;
  }

  if(game_utility::isbrstylegametype()) {
    if(!isDefined(self.timesdowned)) {
      self.timesdowned = 0;
    }

    self.timesdowned++;
  }

  var_5b5deaccb6cc0f8a = 0;

  if(isDefined(attacker) && !(isDefined(attacker.classname) && attacker.classname == "worldspawn")) {
    if(isDefined(attacker.var_e7b48b5121285edd)) {
      attacker[[attacker.var_e7b48b5121285edd]](self);
    }

    if(!isPlayer(attacker)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
        attacker = attacker.owner;
      } else if(isDefined(einflictor) && isDefined(einflictor.owner) && isPlayer(einflictor.owner)) {
        attacker = einflictor.owner;
      }
    }

    deathdata = playerkilled_initdeathdata(einflictor, attacker, self, idamage, 0, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, 0);
    playerkilled_parameterfixup(deathdata);
    playerkilled_precalc(deathdata);
    deathdata.laststandkill = 1;
    self.playergoingintols = 1;

    if(isPlayer(attacker) && attacker != self) {
      self.laststandattacker = attacker;
      self.laststandmeansofdeath = deathdata.meansofdeath;
      self.laststandweaponobj = objweapon;
      self.var_d9d1b1f409f99154 = self.origin;
      attacker thread events::function_b7f154368abbe463(self, objweapon, smeansofdeath, einflictor, deathdata);
      self.laststandattackermodifiers = attacker.modifiers;
    }

    self.lastbounty = bounty::playergetbountypoints();
    bounty::playerresetbountypoints();
    bounty::playerresetbountystreak();
    deathdata.isfriendlyfire = isfriendlyfire(self, attacker);

    if(getdvarint(@ "hash_98f5c716d594181b", 1)) {
      self.laststanddowneddata = deathdata;
    }

    if(istrue(level.gamemodebundle.var_198508771f0592a9)) {
      self.laststanddowneddata = deathdata;
      inflictorisequipment = istrue(einflictor.isequipment);
      var_a8f54da1cfb1dea0 = istrue(einflictor.issuper);

      if(inflictorisequipment || var_a8f54da1cfb1dea0) {
        inflictorcopy = spawnStruct();
        inflictorcopy.isequipment = inflictorisequipment;
        inflictorcopy.issuper = var_a8f54da1cfb1dea0;
        inflictorcopy.equipmentref = einflictor.equipmentref;
        self.laststanddowneddata.inflictorcopy = inflictorcopy;
      }
    }

    if(!deathdata.isfriendlyfire && attacker != self) {
      var_5b5deaccb6cc0f8a = 1;

      if(game_utility::isbrstylegametype()) {
        if(isPlayer(attacker) && attacker != self) {
          if(!isbot(self)) {
            attacker thread namespace_6b49ddb858f34366::function_ac584dc244d416b1();
          }

          attacker br_public::incrementplayersdownedstat();
          attacker thread rank::scoreeventpopup(#"downed");
          killstreakweaponname = killstreak::getkillstreaknamefromweapon(objweapon);

          if(isDefined(killstreakweaponname)) {
            if(isDefined(attacker.var_3efdaabc0f66846d)) {
              attacker.var_3efdaabc0f66846d++;
            }
          }

          if(attacker ispcplayer() && flags::gameflag("prematch_done")) {
            attacker setclientomnvar("nVidiaHighlights_events", 24);
          }
        }

        if(attacker != self) {
          brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

          if(brgametype != "risk" && brgametype != "kingslayer" && brgametype != "rumble_mgl" && level.teamdata[self.team]["alivePlayers"].size > 0 && isPlayer(attacker)) {
            obitplayers = [];

            if(isDefined(level.var_c5877dbe60fddbf6)) {
              obitplayers = level.var_c5877dbe60fddbf6;
            }

            obitplayers = array_combine(obitplayers, level.teamdata[attacker.team]["alivePlayers"]);
            obituary(self, attacker, objweapon, "MOD_DOWN", obitplayers);
          }

          overlord::playevent("squad_down_enemy", level.teamdata[self.team]["alivePlayers"]);
        } else {
          overlord::playevent("squad_down_self", level.teamdata[self.team]["alivePlayers"]);
        }

        if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() != "rumble_mgl") {
          circle = min(max(1, level.br_circle.circleindex), 6);
          event = hashcat(#"br_downEnemy_circle_", utility::string(circle));

          if(rank::function_377a94f711d96927(event)) {
            attacker thread points::doscoreevent(event, objweapon);
          }
        }
      }
    }
  }

  brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(brgametype == "plunder" || brgametype == "risk") {
    br_plunder::plunder_allowallrepositoryuseforplayer(self, 0, 1);
  }

  if(game_utility::isbrstylegametype()) {
    br_analytics::branalytics_down(attacker, self, objweapon, "downed", smeansofdeath);

    if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor.classname) && einflictor.classname == "script_vehicle") {
      playsoundatpos(self.origin + (0, 0, 18), "vehicle_body_hit");
    }
  }

  if(br_public::isbrpracticemode()) {
    if(isDefined(attacker) && isPlayer(attacker) && !isbot(attacker)) {
      attacker notify("enemy_in_laststand");
    }
  }

  if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "champion") {
    if(isDefined(attacker) && isDefined(attacker.team)) {
      level notify("down_enemy_laststand_" + attacker.team, attacker, self);
    }
  }

  if(isDefined(level.checkforlaststandwipe)) {
    if([[level.checkforlaststandwipe]](self)) {
      self.playergoingintols = 0;
      return false;
    }
  }

  if(isDefined(level.var_2d3ee92902ba30fa)) {
    self thread[[level.var_2d3ee92902ba30fa]]();
  } else {
    thread laststand::laststandthink();
  }

  if(isPlayer(self)) {
    scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "player_knocked_down");

    if(isPlayer(attacker)) {
      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(attacker, "knocked_down_enemy");
    }
  }

  if(scripts\mp\damage::playerkilled_washitbyvehicle(smeansofdeath, einflictor)) {
    einflictor notify("vehicle_downed_player");
  }

  if(var_5b5deaccb6cc0f8a && isDefined(attacker.guid)) {
    function_b908a35b0981168e(1);
    function_8be77b53bcbd6d2d(attacker, 1);
  }

  return true;
}

function function_b908a35b0981168e(isdowned) {
  if(getdvarint(@ "hash_3352584db9b5ae7b", 1) == 0) {
    return;
  }

  if(istrue(self.var_7744df488b629b5)) {
    return;
  }

  attackercount = 0;

  foreach(data in self.attackerdata) {
    if(data.attackerent == self) {
      continue;
    }

    attackercount++;
  }

  attackercount = int(clamp(attackercount, 0, 15));
  self setclientomnvar("ui_num_attackers", attackercount);
  self.var_7744df488b629b5 = 1;

  if(attackercount > 1) {
    thread scripts\mp\rank::scoreeventpopup(#"hash_59943f6a740f581b");
    return;
  }

  if(istrue(isdowned)) {
    if(getdvarint(@ "hash_a188996b14552063", 0) == 1) {
      thread scripts\mp\rank::scoreeventpopup(#"downed_victim");
    }
  }
}

function isforcedlaststand(victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc) {
  forcelaststand = 0;

  var_61468d0f2f1e6cb7 = getdvarint(@ "hash_9564fda23c9d6dbd", 0);

  if(var_61468d0f2f1e6cb7) {
    return 1;
  }

  if(istrue(level.var_78184ec36f669844) && isbot(victim)) {
    return 1;
  }

  if(game_utility::isbrstylegametype()) {
    if(br_public::istutorial()) {
      return 1;
    }

    if(!flags::gameflagexists("prematch_done") || flags::gameflag("prematch_done")) {
      if(smeansofdeath == "MOD_FALLING" && !istrue(self.gulagarena) && !istrue(self.inlaststand)) {
        forcelaststand = 1;
      }
    }
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
    forcelaststand = 1;
  }

  if(istrue(level.var_c8dbb5a3e916546f)) {
    forcelaststand = 1;
  }

  if(scripts\mp\gametypes\war::function_2898a9c3d425a919() && smeansofdeath != "MOD_EXECUTION") {
    forcelaststand = 1;
  }

  return forcelaststand;
}

function gethitlocheight(shitloc) {
  switch (shitloc) {
    case #"hash_8a1772f5f912c880":
    case #"hash_92bbfe494d03d772":
    case #"hash_b107b5547c755d23":
      return 60;
    case #"hash_da51cc36a471058":
    case #"hash_51d5d0b9add9cc5a":
    case #"hash_5d5aac570f6fd382":
    case #"hash_a7980c387477e7bb":
    case #"hash_b275b50677dcf6cb":
    case #"hash_d42e71cd9f1e822f":
    case #"hash_da2f35145aa58933":
    case #"hash_fb5b5e6c07253005":
      return 48;
    case #"hash_fbb61fc356f3c75e":
      return 40;
    case #"hash_1cbc508a2fe01b79":
    case #"hash_810a7426c8bac3ac":
      return 32;
    case #"hash_7b36142458a6c2d5":
    case #"hash_a638fec9040cfcf4":
      return 10;
    case #"hash_168c74e879f0ba11":
    case #"hash_9536712388e65bce":
      return 5;
  }

  return 48;
}

function damageshellshockandrumble(einflictor, objweapon, smeansofdeath, idamage, idflags, eattacker) {
  thread scripts\mp\weapons::onweapondamage(einflictor, objweapon, smeansofdeath, idamage, eattacker);

  if(!isai(self) && utility::getdamagetype(smeansofdeath) != "bullet") {
    self playRumbleOnEntity("damage_heavy");

    if(isDefined(einflictor) && isDefined(einflictor.var_9c675043198097a3)) {
      self[[einflictor.var_9c675043198097a3]](einflictor);
      return;
    }

    if(!game_utility::isbrstylegametype() && smeansofdeath == "MOD_TRIGGER_HURT") {
      self playsoundtoplayer("trigger_hurt_impact_plr", self);
    }
  }
}

function callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  return true;
}

function function_49d8cc008e5f6722(eattacker, victim, idflags) {
  eattacker endon("disconnect");
  victim endon("disconnect");

  if(getdvarint(@ "hash_fa43f14297cc7d79", 0) == 1) {
    if(idflags & 512) {
      outlinetype = "outline_nodepth_cyan";
    } else if(istrue(victim.inlaststand)) {
      outlinetype = "outline_nodepth_red";
    } else {
      outlinetype = "outline_nodepth_orange";
    }
  } else {
    outlinetype = "outline_nodepth_trans_white";
  }

  if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
    if(!isPlayer(eattacker) && isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }
  }

  victim scripts\mp\outline::hudoutline_enable_internal(eattacker, "damage", outlinetype);
  wait 0.2;
  victim outline::function_32dfa50c47325abe(eattacker, "damage", 1);
}

function emitfalldamage(idamage) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
}

function gamemodemodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  if(isDefined(eattacker) && isPlayer(eattacker) && isalive(eattacker)) {
    if(level.matchrules_damagemultiplier) {
      idamage *= level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      eattacker.health = int(min(float(eattacker.maxhealth), min(eattacker.health + idamage, float(eattacker.health + 20))));
      eattacker notify("vampirism");
    }

    if(game_utility::function_21322da268e71c19() && utility::isbulletdamage(smeansofdeath) && !isspreadweapon(objweapon)) {
      switch (shitloc) {
        case #"hash_8a1772f5f912c880":
        case #"hash_92bbfe494d03d772":
        case #"hash_b107b5547c755d23":
          if(!victim killstreak::isjuggernaut()) {
            idamage = victim.maxhealth;

            if(isDefined(victim.maxarmorhealth)) {
              idamage += victim.maxarmorhealth;
            }
          }

          break;
        default:
          break;
      }
    }

    if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
        if(!isbot(victim)) {
          if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT") {
            var_e87fbcd39de22d1b = 80;

            if(!isPlayer(eattacker) || !isPlayer(victim)) {
              return 0;
            }

            victimangles = victim getplayerangles();
            attackerangles = eattacker getplayerangles();
            anglediff = angleclamp180(victimangles[1] - attackerangles[1]);

            if(abs(anglediff) < var_e87fbcd39de22d1b) {
              idamage *= 0.3;
            }
          }
        }
      }
    }
  }

  return idamage;
}

function registerkill(objweapon, smeansofdeath, var_82a240a652326f8, iskillstreakweapon) {
  self.killcountthislife++;
  scripts\mp\utility\stats::incpersstat("cur_kill_streak", 1);
  thread namespace_6b49ddb858f34366::function_d8eb5fb3b35ed1a1();

  if(function_e42efe66fa95ca55()) {
    return;
  }

  killcountthislife = int(min(self.killcountthislife, 255));
  self setclientomnvar("ui_life_kill_count", killcountthislife);
}

function function_e42efe66fa95ca55() {
  return istrue(level.var_e42efe66fa95ca55);
}

function monitordamage(maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");

  if(!isDefined(rumble)) {
    rumble = 0;
  }

  self setCanDamage(1);
  self.health = 2147483647;
  self.maxhealth = maxhealth;

  if(!isDefined(self.damagetaken) || istrue(resetdamagetaken)) {
    self.damagetaken = 0;
  }

  if(!isDefined(biskillstreak)) {
    biskillstreak = 0;
  }

  for(running = 1; running; running = monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak)) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = weapon::mapweapon(objweapon, inflictor);

    if(rumble) {
      self playRumbleOnEntity("damage_light");
    }

    if(biskillstreak) {
      weaponname = "none";

      if(isDefined(objweapon)) {
        weaponname = getcompleteweaponname(objweapon);
      }

      logattackerkillstreak(self, damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weaponname);
    }
  }
}

function monitordamageend() {
  self notify("monitorDamageEnd");
  self.damagetaken = undefined;
  self.attackers = undefined;
  self.wasdamaged = undefined;
  self.wasdamagedfrombulletpenetration = undefined;
  self.wasdamagedfrombulletricochet = undefined;
  self setCanDamage(0);
}

function monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak) {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(attacker) && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if(isDefined(attacker) && !game_utility::isgameparticipant(attacker)) {
    return true;
  }

  if(isDefined(attacker) && !scripts\mp\weapons::friendlyfirecheck(self.owner, attacker)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else {
      return true;
    }
  }

  modifieddamage = damage;

  if(!istrue(self.skipignoredamage) && non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath)) {
    return true;
  }

  if(isDefined(objweapon)) {
    damagedata = damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);

    if(!isDefined(var_d7b6456018542238)) {
      var_d7b6456018542238 = &modifydamage;
    }

    modifieddamage = self[[var_d7b6456018542238]](damagedata);
  }

  if(modifieddamage <= 0) {
    return true;
  }

  self.wasdamaged = 1;
  self.damagetaken += int(modifieddamage);
  self.health = 2147483647;

  if(isDefined(idflags) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(idflags) && idflags & 256) {
    self.wasdamagedfrombulletricochet = 1;
  }

  if(istrue(biskillstreak)) {
    killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, modifieddamage);
  }

  if(isDefined(attacker)) {
    if(isPlayer(attacker)) {
      attacker damagefeedback::updatedamagefeedback(damagefeedback);

      if(isreallyalive(attacker)) {
        attacker scripts\mp\utility\game::clearspawnprotection();
      }
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    damagedata = damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);

    if(!istrue(biskillstreak)) {
      thread equipmentdestroyed(inflictor, attacker, damage, idflags, undefined, objweapon, undefined, attacker.modifiers);
    }

    self thread[[ondeathfunc]](damagedata);
    return false;
  }

  return true;
}

function modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflag = data.idflag;

  if(isDefined(idflag) && idflag && true) {
    modifieddamage = 0.6 * damage;
  } else {
    modifieddamage = damage;
  }

  modifieddamage = handleempdamage(objweapon, type, modifieddamage);
  modifieddamage = handlemissiledamage(objweapon, type, modifieddamage);
  modifieddamage = handlegrenadedamage(objweapon, type, modifieddamage);
  modifieddamage = handleapdamage(objweapon, type, modifieddamage, attacker);
  return modifieddamage;
}

function handlemissiledamage(objweapon, meansofdeath, damage) {
  actualdamage = damage;

  switch (objweapon.basename) {
    case #"hash_13a265ac820ea0df":
    case #"hash_1ed1da8a2c218aa7":
    case #"hash_1ee2bbd1bc80ea9a":
    case #"hash_3e782fd775b72022":
    case #"hash_4f9064f9a7a4b7d1":
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_6b9700922cc910a9":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_e704ecf8710c6f57":
    case #"hash_f55c20924061bd15":
    case #"hash_fe08358bc8f9a34a":
      self.largeprojectiledamage = 1;
      actualdamage = self.maxhealth + 1;
      break;
    case #"hash_8d402b4aee106399":
      self.largeprojectiledamage = 0;
      actualdamage *= 2;
      break;
  }

  return actualdamage;
}

function handlegrenadedamage(objweapon, damagetype, modifieddamage) {
  if(isexplosivedamagemod(damagetype)) {
    weaponrootname = getweaponrootstring(objweapon);

    switch (weaponrootname) {
      case #"hash_fa1e80f6bd5b8e72":
        modifieddamage *= 3;
        break;
      case #"hash_5d11ac1131cddab1":
      case #"hash_7c03088193266bc4":
      case #"hash_eeb591a8f50a5869":
        modifieddamage *= 4;
        break;
      default:
        if(objweapon.isalternate) {
          modifieddamage *= 3;
        }

        break;
    }
  }

  return modifieddamage;
}

function handleempdamage(objweapon, meansofdeath, damage) {
  return damage;
}

function handleapdamage(objweapon, meansofdeath, damage, attacker, victim) {
  modifier = 1;
  armorpiercingmod = level.armorpiercingmod - 1;

  if(isfmjdamage(objweapon, meansofdeath)) {
    if(!isDefined(victim) || !isPlayer(victim)) {
      modifier += armorpiercingmod;
    }
  }

  var_f08f2b140236ebf2 = armorpiercingmod + 0.5;

  if(function_73d1d5d600a0cbc3(meansofdeath, attacker)) {
    modifier += var_f08f2b140236ebf2;
    attacker namespace_40cd4a4db2010f22::doonactionscoreevent(1, "suppressionRoundHit");
  }

  return int(damage * modifier);
}

function handleapammodamage(objweapon, smeansofdeath, damage, var_be4285b26ed99ab1) {
  if(!isfmjdamage(objweapon, smeansofdeath)) {
    return damage;
  }

  var_527bb875e0d92d99 = 0;

  if(damage / var_be4285b26ed99ab1 < var_527bb875e0d92d99) {
    damage = int(var_be4285b26ed99ab1 * var_527bb875e0d92d99);
  }

  return damage;
}

function function_5e4aa8d548cc604e(damage, objweapon, attacker, meansofdeath) {
  modifier = 1;

  if(function_4766094b15b00a8(objweapon, meansofdeath, attacker)) {
    modifier = level.var_3395494b137909bb;
  }

  return int(damage * modifier);
}

function function_10268164ab1bcc31(damage, objweapon, attacker) {
  modifier = 1;

  if(function_e287831520aa308b(objweapon, attacker)) {
    modifier = level.var_3395494b137909bb;
  }

  return int(damage * modifier);
}

function handleakimbodamage(objweapon, meansofdeath, damage, attacker, victim) {
  if(!scripts\mp\utility\weapon::isakimbo(objweapon)) {
    return damage;
  }

  modifier = 1;
  return int(damage * modifier);
}

function handleshotgundamage(objweapon, meansofdeath, damage) {
  if(!isDefined(objweapon)) {
    return damage;
  }

  if(objweapon.basename == "none") {
    return damage;
  }

  if(weaponclass(objweapon) != "spread") {
    return damage;
  }

  return int(min(150, damage));
}

function onkillstreakdamaged(killstreakname, attacker, weapon, damage) {
  validattacker = undefined;

  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(isPlayer(attacker) && self.owner player_utility::isenemy(attacker)) {
      validattacker = attacker;
    }
  }

  if(isDefined(validattacker)) {
    thread challenges::killstreakdamaged(killstreakname, self.owner, validattacker, weapon, damage);
  }
}

function onkillstreakkilled(killstreakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify) {
  notifyflag = 0;
  validattacker = undefined;

  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(issentient(self.owner) && issentient(attacker)) {
      if(!isalliedsentient(self.owner, attacker)) {
        validattacker = attacker;
      }
    } else if(self.owner player_utility::isenemy(attacker)) {
      validattacker = attacker;
    }
  }

  if(isDefined(validattacker)) {
    if(isDefined(level.var_ce95c7540070f7d0)) {
      [[level.var_ce95c7540070f7d0]](killstreakname, self.team, validattacker);
    }

    if(isDefined(cardsplash)) {
      validattacker battlechatter_mp::killstreakdestroyed(killstreakname);
    }

    thread events::killedkillstreak(killstreakname, validattacker, objweapon);
    thread challenges::killstreakkilled(killstreakname, self.owner, self, validattacker, damage, damagetype, objweapon, scorepopupname);
    gestures::processcalloutdeath(self, validattacker);
    notifyflag = 1;
  }

  thread events::processscrapassist(validattacker);

  if(isDefined(self.owner) && isDefined(leaderdialog)) {
    self.owner killstreak_utility::playkillstreakteamleaderdialog(killstreakname, leaderdialog);
  }

  if(!istrue(skipdeathnotify)) {
    self notify("death");
  }

  return notifyflag;
}

function updatedeathdetails(attackerlist, attackerdata, killer) {
  attackercount = 0;

  if(isDefined(killer) && isPlayer(killer) && isDefined(killer.health)) {
    if(!killer player_utility::_isalive()) {
      self setclientomnvar("ui_death_details_enemy_health", 0);
    } else {
      self setclientomnvar("ui_death_details_enemy_health", int(clamp(killer.health, 0, killer.maxhealth)) / killer.maxhealth);
    }
  } else {
    self setclientomnvar("ui_death_details_enemy_health", -1);
  }

  if(isDefined(attackerlist) && isDefined(attackerdata)) {
    foreach(guid, attacker in attackerlist) {
      if(!isPlayer(attacker)) {
        continue;
      }

      attackernumber = attacker getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + attackercount, attackernumber);
      self setclientomnvar("ui_death_details_hits_" + attackercount, int(min(attackerdata[guid].hitcount, 10)));
      attackercount++;

      if(attackercount >= 4) {
        break;
      }
    }
  }

  for(clearindex = attackercount; clearindex < 4; clearindex++) {
    self setclientomnvar("ui_death_details_attacker_" + clearindex, -1);
  }
}

function setdeathtimerlength(deathdata) {
  victim = deathdata.victim;
  actualtimeuntilspawn = 0;

  if(victim playerlogic::mayspawn() && !level.disablespawncamera) {
    timeuntilspawn = playerlogic::timeuntilspawn(1);
    minimumtime = 2.25;
    var_b5c34c3bc6c7e65 = 1;
    timeuntilspawn = max(timeuntilspawn + var_b5c34c3bc6c7e65, minimumtime);
    actualtimeuntilspawn = timeuntilspawn + deathdata.deathscenetimesec;
  }

  victim.death_timer_length = int(actualtimeuntilspawn * 10);
}

function getindexfromhitloc(shitloc) {
  switch (shitloc) {
    case #"hash_b275b50677dcf6cb":
      return 0;
    case #"hash_fbb61fc356f3c75e":
      return 1;
    case #"hash_8a1772f5f912c880":
      return 2;
    case #"hash_b107b5547c755d23":
      return 3;
    case #"hash_92bbfe494d03d772":
      return 4;
    case #"hash_51d5d0b9add9cc5a":
      return 5;
    case #"hash_a7980c387477e7bb":
      return 6;
    case #"hash_da51cc36a471058":
      return 7;
    case #"hash_d42e71cd9f1e822f":
      return 8;
    case #"hash_5d5aac570f6fd382":
      return 9;
    case #"hash_da2f35145aa58933":
      return 10;
    case #"hash_810a7426c8bac3ac":
      return 11;
    case #"hash_7b36142458a6c2d5":
      return 12;
    case #"hash_168c74e879f0ba11":
      return 13;
    case #"hash_1cbc508a2fe01b79":
      return 14;
    case #"hash_a638fec9040cfcf4":
      return 15;
    case #"hash_9536712388e65bce":
      return 16;
    case #"hash_fb5b5e6c07253005":
      return 17;
    case #"hash_db653a4972b3c13b":
      return 18;
  }

  return 0;
}

function showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

function updatecombatrecordkillstats(attacker, victim, meansofdeath, objweapon) {
  if(!canrecordcombatrecordstats()) {
    return;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker != victim) {
    if(isDefined(objweapon)) {
      equipmenttype = weapon::getequipmenttype(objweapon);

      if(isDefined(equipmenttype) && equipmenttype == "lethal") {
        equipment = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

        if(!isDefined(equipment)) {
          assertmsg("<dev string:x4d9>" + objweapon.basename);
          equipment = "";
        }

        if(equipment == "equip_throwing_knife_fire" || equipment == "equip_throwing_knife_electric" || equipment == "equip_shuriken") {
          equipment = "equip_throwing_knife";
        }

        if(equipment == "equip_pball") {
          equipment = "equip_snowball";
        }

        attacker combatrecordlethalkill(equipment);
        return;
      }

      killstreak = killstreak::getkillstreaknamefromweapon(objweapon);

      if(isDefined(killstreak)) {
        if(isenumvaluevalid(level.var_5d69837cf4db0407, "LethalScorestreakStatItems", killstreak)) {
          attacker combatrecordkillstreakstat(killstreak);
        }
      }

      if(istrue(attacker.personalradaractive)) {
        attacker combatrecordtacticalstat("power_periphVis");
      }

      if(istrue(attacker.adrenalinepoweractive)) {
        attacker combatrecordtacticalstat("equip_adrenaline");
      }
    }
  }
}

function combatrecordequipmentused(weapon) {
  if(!stats::canrecordcombatrecordstats()) {
    return;
  }

  islethal = equipment::isequipmentlethal(weapon);

  if(weapon == "equip_throwing_knife_fire" || weapon == "equip_throwing_knife_electric" || weapon == "equip_shuriken") {
    weapon = "equip_throwing_knife";
  }

  if(weapon == "equip_pball") {
    weapon = "equip_snowball";
  }

  if(weapon == "equip_mutant_ability_5" || weapon == "equip_mutant_ability_6") {
    return;
  }

  if(islethal) {
    oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "lethalStats", weapon, "uses");
    self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "lethalStats", weapon, "uses", oldvalue + 1);
    return;
  }

  oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "tacticalStats", weapon, "uses");
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "tacticalStats", weapon, "uses", oldvalue + 1);
}

function combatrecordlethalkill(weapon) {
  if(!canrecordcombatrecordstats()) {
    return;
  }

  oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "lethalStats", weapon, "kills");
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "lethalStats", weapon, "kills", oldvalue + 1);
}

function combatrecordtacticalstat(weapon, incrementvalue) {
  if(!stats::canrecordcombatrecordstats() || isagent(self)) {
    return;
  }

  if(!isDefined(incrementvalue)) {
    incrementvalue = 1;
  }

  oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "tacticalStats", weapon, "extraStat1");
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "tacticalStats", weapon, "extraStat1", oldvalue + incrementvalue);
}

function combatrecordkillstreakstat(streakname) {
  if(!stats::canrecordcombatrecordstats()) {
    return;
  }

  recordtype = stats::getstreakrecordtype(streakname);

  if(!isDefined(recordtype)) {
    return;
  }

  oldvalue = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", recordtype, streakname, "extraStat1");
  self setplayerdata(level.var_5d69837cf4db0407, "playerStats", recordtype, streakname, "extraStat1", oldvalue + 1);
}

function enqueuecorpsetablefunc(funcid, func) {
  if(!isDefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isDefined(self.corpsetablefuncs[funcid])) {
    self.corpsetablefuncs[funcid] = func;
    self.corpsetablefunccounts[funcid] = 0;
  }

  self.corpsetablefunccounts[funcid]++;
}

function dequeuecorpsetablefunc(funcid) {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  if(!isDefined(self.corpsetablefuncs[funcid])) {
    return;
  }

  self.corpsetablefunccounts[funcid]--;

  if(self.corpsetablefunccounts[funcid] <= 0) {
    self.corpsetablefuncs[funcid] = undefined;
    self.corpsetablefunccounts[funcid] = undefined;
  }
}

function callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  corpsetable = self.body;

  foreach(func in self.corpsetablefuncs) {
    self thread[[func]](corpsetable);
  }

  thread clearcorpsetablefuncs();
}

function clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

function startcopycatoption(attacker) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_copy_cat_option");

  if(!isDefined(attacker) || !isPlayer(attacker) || isbot(self)) {
    return;
  }

  while(self copyloadoutbuttonPressed()) {
    waitframe();
  }

  while(!self copyloadoutbuttonPressed()) {
    waitframe();
  }

  class::copyclassfornextlife(attacker);
}

function stopcopycatoption() {
  self notify("stop_copy_cat_option");
}

function isenvironmentalscriptableinflictor(einflictor) {
  var_619c67271783522f = 0;

  if(isDefined(einflictor) && isDefined(einflictor.code_classname) && einflictor.code_classname == "scriptable") {
    switch (einflictor.classname) {
      case #"hash_807fe3702cfc611f":
        var_619c67271783522f = 1;
        break;
    }
  }

  return var_619c67271783522f;
}

function shouldrecorddamagestats(player) {
  assertex(isPlayer(player), "<dev string:x538>");

  if(function_483cc81bff18273b(player)) {
    return false;
  }

  if(istrue(level.disabledamagestattracking)) {
    return false;
  }

  if(isDefined(level.disabledamagestattrackingfunc) && ![[level.disabledamagestattrackingfunc]](player)) {
    return false;
  }

  return true;
}

function logfriendlyfire(player, attacker, damage, method) {
  if(!isDefined(player) || !isDefined(attacker) || !isDefined(method)) {
    return;
  }

  willkill = damage >= player.health;
  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.weaponname = weapon::getweaponrootname(attacker.currentweapon);
  var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(attacker.currentweapon);
  var_7e2c53b0bcf117d9.statname = "friendly_fire_damage";
  var_7e2c53b0bcf117d9.incvalue = int(min(damage, player.health));
  var_7e2c53b0bcf117d9.variantid = -1;
  var_7e2c53b0bcf117d9.weaponobj = attacker.currentweapon;
  attacker namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  player dlog_recordplayerevent("dlog_event_friendly_fire", ["attacker", attacker, "damage", damage, "is_fatal_damage", willkill, "damage_method", method]);
}

function function_694d74d8b5ac556f(eattacker, idamage, var_1da1a66b5c6a06a7, smeansofdeath, objweapon, victim) {
  if(!isscriptedagent(eattacker) || eattacker.unittype == "zombie") {
    return [idamage, var_1da1a66b5c6a06a7];
  }

  if(smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN" || smeansofdeath == "MOD_DOWN") {
    return [idamage, var_1da1a66b5c6a06a7];
  }

  maxdamage = undefined;

  if(isDefined(level.var_ed524ae7534d93e6)) {
    maxdamage = level.var_ed524ae7534d93e6;
  } else if(isDefined(level.agentmaxdamage) && level.agentmaxdamage != -1) {
    class = weaponclass(objweapon);

    switch (class) {
      case #"hash_8cdaf2e4ecfe5b51":
      case #"hash_fa24dff6bd60a12d":
        maxdamage = level.var_6ba4985b66d62a71;
        break;
      case #"hash_6191aaef9f922f96":
        maxdamage = level.var_7eb56682f591ea8d;
        break;
      case #"hash_690c0d6a821b42e":
        maxdamage = level.var_9cf526926a72864c;
        break;
      default:
        if(isexplosivedamagemod(smeansofdeath)) {
          maxdamage = level.var_47aedb539717aea5;
        } else if(smeansofdeath == "MOD_MELEE") {
          maxdamage = level.var_e2fbc9e65108b1e;
        } else {
          maxdamage = level.agentmaxdamage;
        }

        break;
    }
  }

  if(isDefined(maxdamage)) {
    invehicle = player_utility::isinvehicle();

    if(invehicle && isDefined(level.var_4899061e2e21dd13) && level.var_4899061e2e21dd13 != -1) {
      maxdamage = int(maxdamage * level.var_4899061e2e21dd13);
    }

    if(var_1da1a66b5c6a06a7 >= maxdamage) {
      var_1da1a66b5c6a06a7 = maxdamage;
      idamage = 0;
    } else {
      maxdamage -= var_1da1a66b5c6a06a7;

      if(idamage > maxdamage) {
        idamage = maxdamage;
      }
    }
  }

  return [idamage, var_1da1a66b5c6a06a7];
}

function issuicide(einflictor, attacker, smeansofdeath, objweapon) {
  if(isDefined(attacker) && attacker == self) {
    return true;
  }

  if(isDefined(smeansofdeath) && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE")) {
    return true;
  }

  if(entity::isdronepackage(einflictor)) {
    return true;
  }

  return false;
}

function isteamkill(einflictor, attacker) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(!isPlayer(attacker) && !isDefined(attacker.team)) {
    return false;
  }

  if(self.team != attacker.team) {
    return false;
  }

  if(self == attacker) {
    return false;
  }

  return true;
}

function function_cd066c9463ad28c5(objweapon, smeansofdeath) {
  if(!isDefined(objweapon)) {
    return 0;
  }

  if(!isDefined(objweapon.basename)) {
    return 0;
  }

  var_f91bacb796f4fde4 = 0;

  switch (objweapon.basename) {
    case #"hash_4e86f50e99575707":
    case #"hash_507c24a8f53354fe":
    case #"hash_9d164ab536ac5b47":
    case #"hash_b2f452f9e4afa176":
    case #"hash_f89fb49cf58b70a5":
      var_f91bacb796f4fde4 = 1;
      break;
    default:
      if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
        var_f91bacb796f4fde4 = 1;
      }

      break;
  }

  return var_f91bacb796f4fde4;
}

function function_a062727999a72d2f(weaponname) {
  var_f8c0529126c5fb04 = ["iw9_sh_vecho_mp", "iw9_pi_swhiskey_mp", "iw9_sh_tsierra12_mp"];

  foreach(i in var_f8c0529126c5fb04) {
    if(i == weaponname) {
      return true;
    }
  }

  return false;
}

function function_403e958ecd04f255(victim, reason) {
  if(getdvarint(@ "hash_a658b504ac40c111", 1) == 1) {
    logprint("[DamageEarlyOut] Victim Client " + victim getentitynumber() + " '" + victim.name + "' - Reason: " + reason);
  }
}

function function_8be77b53bcbd6d2d(attacker, type) {
  if(getdvarint(@ "hash_8484954d9812dec1", 1) == 0) {}

  if(istrue(level.var_9b9f1cd3c521e447)) {
    return;
  }

  if(!isDefined(self.attackerdata)) {
    return;
  }

  if(isDefined(attacker) && isDefined(attacker.guid) && isDefined(self.attackerdata[attacker.guid])) {
    if(type == 0) {
      self.attackerdata[attacker.guid].killedby = 1;
    } else if(type == 1) {
      self.attackerdata[attacker.guid].downedby = 1;
    }
  }

  displaydata = [];

  if(isDefined(attacker) && isDefined(attacker.guid) && isDefined(self.attackerdata[attacker.guid])) {
    displaydata[0] = self.attackerdata[attacker.guid];
  }

  currenttime = gettime();
  ignoremaxtime = getdvarfloat(@ "hash_568c61c9cb10a05a", 20) * 1000;
  var_27759d6e184c86e1 = getdvarint(@ "hash_10925a6ddd9190c1", 0) == 0;

  while(true) {
    var_21aa6f16d3025af6 = undefined;
    var_753e95a387880b4f = undefined;

    foreach(attackerdata in self.attackerdata) {
      if(array_contains(displaydata, attackerdata)) {
        continue;
      }

      if(var_27759d6e184c86e1 && istrue(attackerdata.var_4ce88b2dfe0bfa52)) {
        continue;
      }

      elapsedtime = attackerdata.lasttimedamaged - currenttime;

      if(abs(elapsedtime) > ignoremaxtime) {
        continue;
      }

      if(!isDefined(var_753e95a387880b4f) || var_753e95a387880b4f > elapsedtime) {
        var_21aa6f16d3025af6 = attackerdata;
        var_753e95a387880b4f = elapsedtime;
      }
    }

    if(isDefined(var_21aa6f16d3025af6)) {
      displaydata[displaydata.size] = var_21aa6f16d3025af6;
      continue;
    }

    break;
  }

  var_c41dadd6f0b10385 = 0;

  for(index = 0; index < 6; index++) {
    if(index < displaydata.size) {
      data = displaydata[index];
      lootid = scripts\cp_mp\weapon::getweaponlootid(data.objweapon);

      if(lootid == 0) {
        equipref = scripts\mp\equipment::getequipmentreffromweapon(data.objweapon);

        if(isDefined(equipref)) {
          lootid = scripts\cp_mp\utility\loot::getlootidfromref(equipref);
        } else if(scripts\cp_mp\weapon::iskillstreakweapon(data.objweapon)) {
          killstreakname = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(data.objweapon);
          lootid = scripts\cp_mp\utility\loot::getlootidfromref(killstreakname);
        } else if(isDefined(data.objweapon.basename)) {
          lootid = scripts\cp_mp\utility\loot::getlootidfromref(data.objweapon.basename);
        }
      }

      attackerent = default_to(data.attackerent, undefined);
      lootid = int(clamp(default_to(lootid, 0), 0, 2147483647));
      multiweapon = default_to(data.damagesources.size > 1, 0);
      damage = int(clamp(default_to(data.var_d69d6cc16d8b71fb, 0), 0, 1023));
      hitcount = int(clamp(default_to(data.hitcount, 0), 0, 255));
      downedby = default_to(istrue(data.downedby), 0);
      killedby = default_to(istrue(data.killedby), 0);
      friendly = default_to(scripts\cp_mp\utility\player_utility::isfriendly(self.team, data.attackerent), 0);
      damagetypeoverride = 0;

      if(isDefined(data.var_8519cf56b38d717d)) {
        switch (data.var_8519cf56b38d717d) {
          case #"hash_b15027ffbdc0ecb":
            damagetypeoverride = 1;
            break;
          case #"hash_f91d639d29feb858":
            damagetypeoverride = 2;
            break;
          case #"hash_e4fbf0b31ced1661":
            damagetypeoverride = 3;
            break;
          case #"hash_91d0b5d30ea06560":
            damagetypeoverride = 4;
            break;
          case #"hash_daa7ba4e87e42b9":
            damagetypeoverride = 5;
            break;
          case #"hash_abb1587cdc6def23":
            damagetypeoverride = 6;
            break;
          case #"hash_1b5395c651f95456":
          case #"hash_a5123f4d02745600":
            damagetypeoverride = 7;
            break;
          case #"hash_61e42661ac27b9f2":
            damagetypeoverride = 8;
            break;
          case #"hash_24cf9a6ca3404493":
            damagetypeoverride = 9;
            break;
          default:
            damagetypeoverride = 10;

            if(isDefined(data.smeansofdeath) && data.smeansofdeath == "MOD_SUICIDE") {
              damagetypeoverride = 9;
            }

            break;
        }
      }

      self setclientomnvar("ui_combat_report_attacker_" + index, attackerent);
      self setclientomnvar("ui_combat_report_weapon_lootid_" + index, lootid);
      self setclientomnvar("ui_combat_report_multi_weapon_" + index, multiweapon);
      self setclientomnvar("ui_combat_report_damage_" + index, damage);
      self setclientomnvar("ui_combat_report_hits_" + index, hitcount);
      self setclientomnvar("ui_combat_report_downedby_" + index, downedby);
      self setclientomnvar("ui_combat_report_killedby_" + index, killedby);
      self setclientomnvar("ui_combat_report_friendly_" + index, friendly);
      self setclientomnvar("ui_combat_report_damage_type_override_" + index, damagetypeoverride);
      continue;
    }

    self setclientomnvar("ui_combat_report_attacker_" + index, undefined);
    self setclientomnvar("ui_combat_report_weapon_lootid_" + index, 0);
    self setclientomnvar("ui_combat_report_multi_weapon_" + index, 0);
    self setclientomnvar("ui_combat_report_damage_" + index, 0);
    self setclientomnvar("ui_combat_report_hits_" + index, 0);
    self setclientomnvar("ui_combat_report_downedby_" + index, 0);
    self setclientomnvar("ui_combat_report_killedby_" + index, 0);
    self setclientomnvar("ui_combat_report_friendly_" + index, 0);
    self setclientomnvar("ui_combat_report_damage_type_override_" + index, 0);
  }

  numattackers = default_to(displaydata.size, 0);
  numattackers = int(clamp(numattackers, 0, 6));
  self setclientomnvar("ui_combat_report_num_attackers", numattackers);
}

function function_84c8fc967497800(attacker, attackerdamage, attackerweapon) {
  victim = self;

  if(!istrue(attackerdamage)) {
    return;
  }

  if(!isreallyalive(victim) || victim isplayeringulag()) {
    return;
  }

  attackerteam = scripts\mp\utility\teams::getteamdata(attacker.team, "alivePlayers");

  if(!isDefined(attackerteam)) {
    return;
  }

  if(victim _hasperk("specialty_covert_ops")) {
    attacker thread function_b3e014b644ff0edb(2);
    return;
  }

  foreach(player in attackerteam) {
    if(!isDefined(player.var_6745f7e4484f1a55)) {
      continue;
    }

    if(player.var_6745f7e4484f1a55 == victim) {
      return;
    }
  }

  attacker notify("combatscout_targetSwitch");
  marktype = function_f7060d6be77fc6a2(attacker.origin, victim.origin);
  victim function_87dfbd72f4fdd76f(attacker, int(5), marktype);
  currenttime = gettime();

  if(!isDefined(attacker.var_d0a7a6015ed83b19) || currenttime > attacker.var_d0a7a6015ed83b19 + 1500) {
    attacker playlocalsound("recon_drone_marked_owner");
    attacker.var_d0a7a6015ed83b19 = gettime();
  }
}

function function_87dfbd72f4fdd76f(attacker, pingtime, marktype) {
  victim = self;
  level endon("game_ended");
  victim endon("disconnect");
  var_5283d6ed761e8022 = pingtime * 1000;

  if(!isDefined(marktype)) {
    marktype = getdvarint(@ "hash_1330d41fefd75985", 1);
  }

  switch (marktype) {
    case 3:
      pingtime = int(pingtime * 1.6);
      var_5283d6ed761e8022 = int(var_5283d6ed761e8022 * 1.6);
      break;
    case 2:
      pingtime = int(pingtime * 1);
      var_5283d6ed761e8022 = int(var_5283d6ed761e8022 * 1);
      break;
    case 1:
    default:
      pingtime = int(pingtime * 0.75);
      var_5283d6ed761e8022 = int(var_5283d6ed761e8022 * 0.75);
      break;
  }

  icon = victim thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(attacker.team, "hud_icon_new_marked", 8, 1, 5000, 500, undefined, 1, 1);
  currenttime = gettime();

  if(!isDefined(victim.var_70ec5815eb1aa3f2) || currenttime > victim.var_70ec5815eb1aa3f2 + 1500) {
    victim scripts\cp_mp\killstreaks\recon_drone::function_fa08d1d78cf5cb01();
    victim playlocalsound("recon_drone_spotted_plr");
    victim.var_70ec5815eb1aa3f2 = gettime();
  }

  victim thread function_c712df451114149d(attacker, icon, pingtime);
  triggerportableradarpingteam(victim.origin, attacker.team, 40, var_5283d6ed761e8022);

  iprintln("<dev string:x57a>" + marktype + "<dev string:x598>" + pingtime);
}

function function_c712df451114149d(attacker, icon, waittime) {
  victim = self;
  level endon("game_ended");
  victim endon("disconnect");
  attacker.var_6745f7e4484f1a55 = victim;
  waittill_any_ents_or_timeout_return(waittime, victim, "death", attacker, "combatscout_targetSwitch");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  attacker.var_6745f7e4484f1a55 = undefined;
  attacker.var_d0a7a6015ed83b19 = undefined;
}

function function_f7060d6be77fc6a2(attackerloc, victimloc) {
  dist = distance2d(attackerloc, victimloc);

  iprintln("<dev string:x5a5>" + dist);

  if(dist >= 0 && dist <= 2000) {
    return 1;
  }

  if(dist > 2000 && dist <= 4000) {
    return 2;
  }

  if(dist > 4000) {
    return 3;
  }
}

function function_b3e014b644ff0edb(time) {
  attacker = self;
  level endon("game_ended");
  attacker endon("disconnect");

  if(isDefined(attacker.var_b9fc1ffc6b388cf5)) {
    return;
  }

  if(!isDefined(time)) {
    time = 1;
  }

  attacker.var_b9fc1ffc6b388cf5 = 1;
  attacker iprintlnbold(&"KILLSTREAKS_HINTS/RECON_NO_MARK");
  self playlocalsound("uin_jup_br_perk_combat_scout_marking_resist", self);
  wait time;
  attacker.var_b9fc1ffc6b388cf5 = undefined;
}

function function_fbd5b90ec07c28c4(victim) {
  victim endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(victim.var_529eb36595b1d4bf)) {
    return;
  } else {
    victim.var_529eb36595b1d4bf = -0.1;
  }

  victim shellshock("chargemode_mp", 0.7);
  victim weapons::updatemovespeedscale();
  victim val::set("bulletDamageMeleeSlow", "sprint", 0);
  utility::waittill_any_timeout_1(0.7, "death");
  victim val::reset_all("bulletDamageMeleeSlow");
  victim.var_529eb36595b1d4bf = undefined;
  victim weapons::updatemovespeedscale();
}

function shouldmeleeslow(vdir, victim) {
  if(getdvarint(@ "scr_bullet_damage_melee_slow", 0) && weapon::ismeleeonly(victim.currentweapon)) {
    if(vectordot(vdir, anglesToForward(victim.angles)) < 0 && distance2dsquared(self.origin, victim.origin) < 562500) {
      return true;
    }
  }

  return false;
}

function function_3e0f845008bbd48d(func_damage_override) {
  assert(isDefined(func_damage_override), "<dev string:x5c7>");

  if(!isDefined(level.var_5cb687ba43fb7102)) {
    level.var_5cb687ba43fb7102 = [];
  }

  level.var_5cb687ba43fb7102 = utility::function_6d6af8144a5131f1(level.var_5cb687ba43fb7102, func_damage_override);
}

function function_ba85b91abfec02d8(func) {
  if(!isarray(level.var_5cb687ba43fb7102)) {
    return;
  }

  level.var_5cb687ba43fb7102 = utility::array_remove(level.var_5cb687ba43fb7102, func);
}

function function_18c42af5777dcd9f(deathdata) {
  deathdata.var_28cd1e201ecd8281 = [];
  deathdata.var_28cd1e201ecd8281["<dev string:x622>"] = deathdata.attacker;
  deathdata.var_28cd1e201ecd8281["<dev string:x62e>"] = deathdata.victim;
  deathdata.var_28cd1e201ecd8281["<dev string:x638>"] = deathdata.damage;
  deathdata.var_28cd1e201ecd8281["<dev string:x642>"] = deathdata.objweapon;
  deathdata.var_28cd1e201ecd8281["<dev string:x64f>"] = deathdata.meansofdeath;
  deathdata.var_28cd1e201ecd8281["<dev string:x65f>"] = deathdata.inflictor;
  deathdata.var_28cd1e201ecd8281["<dev string:x66c>"] = deathdata.direction_vec;
  deathdata.var_28cd1e201ecd8281["<dev string:x67d>"] = deathdata.damageflags;
  deathdata.var_28cd1e201ecd8281["<dev string:x68c>"] = deathdata.hitloc;
  deathdata.var_28cd1e201ecd8281["<dev string:x696>"] = deathdata.psoffsettime;
  deathdata.var_28cd1e201ecd8281["<dev string:x6a6>"] = deathdata.deathanimduration;
  deathdata.var_28cd1e201ecd8281["<dev string:x6bb>"] = deathdata.isfauxdeath;
}

function function_f9249bb06eb48092(deathdata) {
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x622>"] == deathdata.attacker, "<dev string:x6ca>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x62e>"] == deathdata.victim, "<dev string:x71c>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x638>"] == deathdata.damage, "<dev string:x76c>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x642>"] == deathdata.objweapon, "<dev string:x7bc>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x64f>"] == deathdata.meansofdeath, "<dev string:x80f>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x65f>"] == deathdata.inflictor, "<dev string:x865>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x66c>"] == deathdata.direction_vec, "<dev string:x8b8>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x67d>"] == deathdata.damageflags, "<dev string:x90f>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x68c>"] == deathdata.hitloc, "<dev string:x964>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x696>"] == deathdata.psoffsettime, "<dev string:x9b4>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x6a6>"] == deathdata.deathanimduration, "<dev string:xa0a>");
  assertex(deathdata.var_28cd1e201ecd8281["<dev string:x6bb>"] == deathdata.isfauxdeath, "<dev string:xa65>");
}

function function_af3ebb9d1ecd18e7(deathdata) {
  assertex(deathdata.deathtime == gettime(), "<dev string:xaba>");
}

function function_1b7b7da2e72eeffe(attacker, recentdamage, smeansofdeath, objweapon) {
  self endon("<dev string:xaf8>");

  if(!isDefined(self.var_e6c94d7b9dc402ee)) {
    self.var_e6c94d7b9dc402ee = recentdamage;
  } else {
    self.var_e6c94d7b9dc402ee += recentdamage;
  }

  self notify("<dev string:xb06>");
  self endon("<dev string:xb06>");

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  utility::waittill_any_timeout_1(2, "<dev string:xb1d>");
  var_81abac435f94f75c = self.var_e6c94d7b9dc402ee;
  self.var_e6c94d7b9dc402ee = undefined;

  if(!isDefined(objweapon) || isDefined(objweapon) && !isDefined(objweapon.basename)) {
    return;
  }

  if(!isDefined(attacker)) {
    return;
  }

  iprintlnbold("<dev string:xb26>" + var_81abac435f94f75c + "<dev string:xb38>" + smeansofdeath + "<dev string:xb4a>" + objweapon.basename);
}

# /