/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\damage.gsc
***********************************************/

function callback_playerdamage_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "worldspawn") {
    var_1 = undefined;
  }

  if(isDefined(var_1) && isDefined(var_1.gunner)) {
    var_1 = var_1.gunner;
  }

  if(istrue(var_2.plotarmor)) {
    return;
  }

  if(istrue(var_2.ref_12058) && isDefined(var_6)) {
    if(!trial_vehicle_outline_id(var_6.basename)) {
      return;
    }
  }

  if(var_5 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_2 scripts\cp_mp\utility\player_utility::getvehicle()) && var_2 scripts\cp_mp\utility\player_utility::getvehicle() == var_0) {
    return;
  }

  if(var_5 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle" && isDefined(var_0.vehiclename) && var_0.vehiclename == "loot_chopper") {
    var_17 = 10000;
    var_18 = gettime() - var_0.birthtime;

    if(var_18 < var_17) {
      return;
    }
  }

  if(istrue(var_2.inlaststand) && istrue(level.laststandrequiresmelee) && var_5 != "MOD_MELEE") {
    return;
  }

  var_19 = var_2.health;

  if(var_4 &level.idflags_stun) {
    if(istrue(level.ref_13c56)) {
      var_2 thread scripts\mp\battlechatter_mp::addrecentattacker(var_1);
    }

    return;
  }

  var_20 = filterdamage(var_0, var_1, var_2, var_3, var_5, var_6, var_9);

  if(isDefined(var_20)) {
    return;
  }

  var_21 = scripts\mp\utility\damage::attackerishittingteam(var_2, var_1);

  if(isDefined(var_0) && istrue(var_0.flare_activated)) {
    var_21 = 0;
  }

  var_22 = isDefined(var_6) && scripts\mp\utility\weapon::iskillstreakweapon(var_6.basename);

  if(!istrue(level.allowprematchdamage)) {
    if(istrue(game["inLiveLobby"]) || !scripts\mp\flags::gameflag("prematch_done") || istrue(level.stop_end_breach_fx)) {
      handledamagefeedback(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1, var_22);
      return;
    }
  }

  if(var_21) {
    var_3 = handlefriendlyfiredamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_22);

    if(var_3 == 0) {
      return;
    }
  }

  if(istrue(var_2.spawnprotection) || var_2 method_87d3()) {
    var_23 = isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "trigger_hurt";
    var_24 = var_5 == "MOD_FALLING";

    if(!var_23 && !var_24) {
      handledamagefeedback(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1, var_22);
      return;
    }
  }

  if(isDefined(var_1) && istrue(var_1.cranked)) {
    var_1 thread scripts\mp\cranked::ref_1200c(var_2);
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return;
  }

  var_4 |= level.idflags_no_knockback;

  if((usetimeoverride(var_6) || tutorialzoneexit(var_1, var_6) || var_6 hasattachment("ammo_incendiary", 1)) && scripts\mp\utility\damage::validshotcheck(var_5, var_1)) {
    if(isDefined(var_6.unlockableindex)) {
      thread mine_caves_ambusher_internal(var_2, var_9, var_1);
    }

    if(var_6.basename != "iw8_pi_t9pistolshot_mp") {
      var_3 = ref_13714(var_2, var_1, var_6, var_3, var_4);
    } else if(var_3 == 0) {
      return;
    }
  }

  var_25 = var_6.basename;
  var_26 = scripts\mp\utility\weapon::getequipmenttype(var_25);

  if(isDefined(var_26)) {
    if(var_26 == "lethal") {
      var_3 = lethalequipmentdamagemod(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    } else if(var_26 == "tactical") {}

    LOC_000003ab:
      var_27 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, var_7, var_8, undefined, var_12, undefined, var_4);
    var_28 = scripts\mp\equipment::equiponplayerdamaged(var_27);

    if(isDefined(var_28) && var_28 == 0) {
      return;
    }
  }

  if(var_2 scripts\mp\utility\game::ismatchstartprotected()) {
    var_29 = isDefined(var_6) && isDefined(var_6.basename) && var_6.basename == "minefield_mp";

    if(!var_29) {
      var_30 = istrue(var_6.isalternate);

      if(isDefined(var_26) && !scripts\mp\utility\weapon::isthrowingknife(var_25) || var_30 || var_5 == "MOD_EXPLOSIVE") {
        var_31 = int(max(var_2.health / 5, 1));

        if(var_3 >= var_31) {
          var_3 = var_31;
        }
      }
    }
  }

  var_32 = scripts\mp\utility\weapon::getweapontype(var_25);

  if(isDefined(var_32) && var_32 == "killstreak") {
    var_3 = killstreakdamagefilter(var_1, var_2, var_3, var_6, var_5);

    if(var_3 == 0) {
      return;
    }

    if(isDefined(level.gunshipplayer) && isDefined(var_1) && level.gunshipplayer == var_1) {
      level notify("ai_pain", var_2);
    }
  }

  if(var_5 == "MOD_CRUSH" && isDefined(var_1) && isDefined(var_1.streakname) && var_1.streakname == "emp_drone") {
    var_3 = 0;
  }

  var_3 = modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
  var_3 = handleriotshieldhits(var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4, var_22, var_14);

  if(var_3 == 0) {
    if(istrue(level.ref_13c56)) {
      var_2 thread scripts\mp\battlechatter_mp::addrecentattacker(var_1);
    }

    return;
  }

  var_33 = var_3;

  if(!istrue(var_2.donotmodifydamage)) {
    var_34 = cac_modified_damage(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0, 0, var_4, var_22, var_14);
    var_3 = var_34[0];
    var_35 = var_34[1];
    var_36 = var_34[2];
    var_37 = var_35 != 0 || var_36 != 0;
    var_9 = var_34[3];
  } else {
    var_35 = 0;
    var_36 = 0;
    var_37 = 0;
  }

  if(unsetspecialistbonus(var_4, var_5, var_6, var_8, var_9, var_19)) {
    return;
  }

  if(isDefined(var_5.forcehitlocation)) {
    var_12 = var_5.forcehitlocation;
    var_5.forcehitlocation = undefined;
  }

  if(isPlayer(var_4) && (var_33 == "smoke_grenade_mp" || scripts\mp\utility\weapon::isthrowingknife(var_33))) {
    var_4 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_33, 1, "hits");
  }

  var_38 = var_11;

  if(isDefined(var_7) && var_7 &level.idflags_ricochet && var_6 < self.health) {
    var_38 = var_5.origin - var_4.origin;
  }

  if(unset_force_aitype_sniper(var_3)) {
    var_6 = 0;
  }

  if(isDefined(var_4) && (isPlayer(var_4) || istrue(var_4.brking_getcenterofcircle)) && scripts\mp\utility\game::getgametype() == "br") {
    if(armorvest_washit(var_4) || helmet_washit(var_4)) {
      var_7 |= level.ss_circletick;
    }

    if(armorvest_wasbroke(var_4) || helmet_wasbroke(var_4)) {
      var_7 |= level.sr_next_ammo_restock_time;
    }

    if(isDefined(level.ref_12067)) {
      var_7 |= [[level.ref_12067]](var_5);
    }
  }

  if(usecallback(var_4)) {
    var_6 = ref_12f86(var_4, var_6, var_8);
  }

  if(isDefined(level.ref_12066)) {
    if(![[level.ref_12066]](var_8)) {
      return;
    }
  }

  var_39 = 5;

  if(isPlayer(var_4) && var_4 scripts\mp\utility\perk::_hasperk("specialty_br_ping_on_damage") && var_37 >= var_39) {
    if(isPlayer(var_5) && var_5 scripts\mp\utility\perk::_hasperk("specialty_coldblooded") && var_5 != var_4) {
      var_4 thread scripts\mp\perks\perkfunctions::ref_12374();
    } else {
      var_4 scripts\mp\perks\perkfunctions::maxmuncurrencycap(var_5);
    }
  }

  if(isDefined(var_4) && isPlayer(var_4) && var_4 != var_5) {
    if(var_8 == "MOD_RIFLE_BULLET" || var_8 == "MOD_PISTOL_BULLET") {
      if(var_5 scripts\mp\utility\perk::_hasperk("specialty_br_sprinting_dr") && (var_5 issupersprinting() || var_5 issprintsliding())) {
        var_40 = var_6;
        var_6 = int(var_40 * getdvarfloat("scr_perk_serpentine_drmod", 0.85));

        if(!isagent(var_4) && !isbot(var_4)) {
          var_4 thread scripts\mp\perks\perkfunctions::ref_13716();
        }
      }
    }
  }

  preplayerdamaged(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_38, var_12, var_13, var_14, var_15);
  finishplayerdamagewrapper(var_5, var_3, var_4, var_6, var_7, var_8, var_9, var_10, var_38, var_12, var_13, var_14, var_15, var_37);
  postplayerdamaged(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_38, var_12, var_13, var_14, var_15, var_35, var_36, var_22, var_32);
}

function rungwperif_plumes(var_0, var_1, var_2, var_3, var_4) {
  var_5 = function_0438(var_2);
  var_6 = function_0439(var_0, var_1, var_5);

  if(var_5 == 0 || var_5 > 17 || var_6 > 1.1) {
    return var_3;
  }

  var_7 = var_5 - 1;

  if(var_5 - 6 > 0) {
    var_7--;
  }

  if(var_5 == 6 || var_5 == 7) {
    var_7 = 4;
  }

  if(var_5 == 12 || var_5 == 13) {
    var_7 = 5;
  }

  var_8 = function_0439(var_0, var_1, var_7);

  if(var_8 > 1.1) {
    return floor(var_4 * var_8);
  }

  return var_3;
}

function mine_caves_ambusher_internal(var_0, var_1, var_2) {
  self notify("newDragonsBreathHitLoc");
  self endon("newDragonsBreathHitLoc");

  if(!isDefined(self.mine_caves_ambusher)) {
    self.mine_caves_ambusher = scripts\cp_mp\killstreaks\nuke::ref_13638();
  }

  self.mine_caves_ambusher.ref_11e62 = scripts\engine\utility::array_add(self.mine_caves_ambusher.ref_11e62, var_0);
  waittillframeend();
  var_3 = [];

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.mine_caves_ambusher)) {
    var_3 = self.mine_caves_ambusher.ref_11e62;
    self.mine_caves_ambusher.ref_11e62 = [];
  }

  if(scripts\mp\utility\player::isreallyalive(self)) {
    scripts\cp_mp\killstreaks\nuke::ref_13146(var_3, var_1, var_2);
    return;
  }

  scripts\cp_mp\killstreaks\nuke::ref_13147();
}

function preplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_3;
  var_2.lastweaponused = var_2 getcurrentweapon();
  var_2.wasaimingdownsightsondamage = var_2 scripts\mp\utility\player::isplayerads();

  if(isai(self)) {
    self[[level.bot_funcs["on_damaged"]]](var_1, var_3, var_5, var_6, var_0, var_9);
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo) && isDefined(var_0.streakinfo.hits)) {
    var_0.streakinfo.hits++;
  }

  scripts\mp\perks\perkfunctions::bulletoutlinecheck(var_1, var_2, var_6.basename, var_5);

  if(var_5 == "MOD_FALLING") {
    thread emitfalldamage(var_2);
  }

  logattacker(var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5);

  if(isDefined(var_0) && isDefined(var_0.owner) && var_0.owner.team != var_2.team) {
    var_2.lastdamagewasfromenemy = 1;
  } else {
    var_2.lastdamagewasfromenemy = isDefined(var_1) && var_1 != var_2;
  }

  if(var_2.lastdamagewasfromenemy) {
    var_14 = gettime();
    var_1.damagedplayers[var_2.guid] = var_14;
    var_2.lastdamagedtime = var_14;
  }

  var_2 thread scripts\mp\potg_events::onplayerdamaged(var_1, var_2, var_5);
  var_2 thread scripts\cp\vehicles\vehicle_compass_cp::playerdamaged(var_0, var_1, var_3, var_5, var_6, var_9);

  if(isDefined(var_1) && var_3 != 0) {
    var_1 notify("victim_damaged", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_2 notify("victim_was_damaged", var_1, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(level.preplayerdamaged)) {
    var_2 thread[[level.preplayerdamaged]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  }
}

function postplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = var_3;
  var_18 = scripts\engine\utility::isbulletdamage(var_5);

  if(var_3 > 10 && isDefined(var_0) && !var_2 scripts\mp\utility\player::isusingremote() && isPlayer(var_2)) {
    var_2 thread scripts\mp\shellshock::bloodeffect(var_0.origin);

    if(isPlayer(var_0) && var_5 == "MOD_MELEE") {
      if(isalive(var_2) && !var_2 scripts\mp\utility\killstreak::isjuggernaut() && scripts\mp\utility\game::getgametype() != "br") {
        thread meleestagger(var_2);
        var_2.hitwithmeleetime = gettime();
      }

      var_0 thread scripts\mp\shellshock::bloodmeleeeffect(var_6, var_2);
      var_2 playRumbleOnEntity("defaultweapon_melee");
      var_0 playRumbleOnEntity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
      if(var_3 >= self.health) {
        var_3 = self.health - 1;
      } else {
        var_19 = createheadicon(var_6);
        self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_19, var_7, var_8, var_9, var_10);
      }
    } else {
      var_19 = createheadicon(var_6);
      self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_19, var_7, var_8, var_9, var_10);
    }
  }

  handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, var_13, var_14, var_16);

  if(var_18) {
    var_2 thread scripts\mp\battlechatter_mp::adddamagetaken(var_1, var_6, var_3);
  }

  if(isagent(var_1) && isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 != var_2) {
    var_2 thread scripts\mp\battlechatter_mp::addrecentattacker(var_1);
  }

  if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(var_2.health < 30) {
      var_2 thread scripts\mp\battlechatter_mp::hurtbadlywait();
    }

    if(isDefined(var_1) && var_1 != var_2 && isexplosivedamagemod(var_5)) {
      if(!isDefined(var_6) || var_6.basename != "gas_mp") {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_2, "flavor_surprise", undefined, 0.5);
      }
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(var_2, 1);

  if(isDefined(var_1) && var_1 != var_2) {
    level.usestartspawns = 0;
  }

  if(isPlayer(var_1) && isDefined(var_1.pers["participation"])) {
    var_1.pers["participation"]++;
  } else if(isPlayer(var_1)) {
    var_1.pers["participation"] = 1;
  }

  if(isDefined(level.cinematic_replay_recording) && isPlayer(var_0)) {
    var_22 = spawnStruct();
    var_22.victim = var_2;
    var_22.vpoint = var_7;
    var_22.vdir = var_8;
    var_22.objweapon = var_6;
    var_22.kill = !isalive(var_2);
    var_0.hitrecord[var_0.hitrecord.size] = var_22;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isPlayer(var_2) && isDefined(var_0) && isPlayer(var_0) && var_18) {
    if(var_15 == var_2.maxhealth && var_2.health != self.maxhealth) {
      var_2.engagementstarttime = gettime();
    }
  }

  if(allowdamageflash(var_1, var_2, var_6, var_5, var_3)) {
    showuidamageflash(var_2);
  }

  if(isDefined(var_1) && var_3 > 0) {
    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_delayhealing")) {
      var_1 thread scripts\mp\perks\perk_mark_targets::marktarget_run(var_2, var_5);
    }

    if(var_18 && (var_6 hasattachment("ammomod_slow") || var_6 hasattachment("gunperk_disable") || var_6 hasattachment("ammomod_wound")) && scripts\mp\utility\damage::islowerbodyshot(var_9, var_5, var_1)) {
      var_1 thread scripts\mp\perks\perkfunctions::ammodisabling_run(var_2);
    }

    if(isPlayer(var_2) && var_1 scripts\mp\utility\perk::_hasperk("specialty_shrapnel") && isshrapnelsource(var_6, var_5)) {
      var_2.lastshrapneltime = gettime();
    }

    if(isPlayer(var_2) && isPlayer(var_1)) {
      scripts\mp\gametypes\br_alt_mode_ff::play_animation_old(var_1, var_2);
    }
  }

  if(isDefined(level.onplayerdamaged)) {
    var_2 thread[[level.onplayerdamaged]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_15, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  if(scripts\mp\utility\player::isreallyalive(var_2)) {
    switch (var_5) {
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        var_2 scripts\mp\utility\stats::incpersstat("explosionsSurvived", 1);
        break;
    }

    return;
  }

  if(isDefined(var_4) && var_4 &level.idflags_penetration && !(var_4 &level.ss_respawn)) {
    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_23 = var_1 scripts\mp\playerstats_interface::getplayerstat("combatStats", "wallbangs") + 1;
      var_1 scripts\mp\playerstats_interface::setplayerstatbuffered(var_23, "combatStats", "wallbangs");
    }

    var_1 scripts\mp\utility\stats::incpersstat("penetrationKills", 1);
  }
}

function meleestagger_anglesviewattack(var_0, var_1) {
  var_2 = anglesToForward((0, var_0 getplayerangles()[1], 0));
  var_3 = vectorNormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  return scripts\engine\math::anglebetweenvectorssigned(var_2, var_3, (0, 0, 1));
}

function isshrapnelsource(var_0, var_1) {
  if(!isDefined(var_0) || nullweapon(var_0)) {
    return false;
  }

  if(!isexplosivedamagemod(var_1)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0)) {
    return false;
  }

  if(scripts\mp\utility\weapon::isvehicleweapon(var_0)) {
    return false;
  }

  if(scripts\mp\utility\weapon::isgamemodeweapon(var_0)) {
    return false;
  }

  var_2 = scripts\mp\utility\weapon::getequipmenttype(var_0.basename);

  if(isDefined(var_2)) {
    if(var_2 != "lethal") {
      return false;
    }
  }

  return true;
}

function meleestagger(var_0) {
  self endon("death_or_disconnect");
  var_1 = getdvarfloat("melee_stagger_shock_duration");
  var_2 = getdvarfloat("melee_stagger_aftershock_duration");
  var_3 = self getviewkickscale();

  if(isDefined(level.playerzombievehiclehittoss)) {
    self setviewkickscale(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), level.playerzombievehiclehittoss * 2, level.playerzombievehiclehittoss));
  } else {
    self setviewkickscale(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 3, 1.5));
  }

  var_4 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var_1 * 1.5, var_1);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("melee_mp", "damage", var_4, 0, 0);
  var_5 = 0;

  if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_6 = meleestagger_anglesviewattack(self, var_0);

    if(var_6 < 15) {
      var_5 = 10;
    } else if(var_6 > -15) {
      var_5 = -10;
    }
  }

  var_7 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 1.15, 1);
  self setplayerangles(self getplayerangles() + (-14 * var_7, var_5, 0));
  thread meleedofroutine(var_0);
  self earthquakeforplayer(0.35, 0.2, self.origin, 400);
  self playrumbleonpositionforclient("plr_rumble_4_mp", self.origin);
  self setclientomnvar("ui_hud_shake", 1);
  wait 0.05;
  self setviewkickscale(var_3);
  var_4 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var_2 * 1.5, var_2);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("melee_mp_after", "damage", var_4, 0, 0);
}

function meleedofroutine(var_0) {
  self notify("resetMeleeDOF");
  self endon("resetMeleeDOF");
  self endon("death_or_disconnect");
  var_1 = 1;
  var_2 = 2;
  var_3 = 350;
  var_4 = 1024;
  self setdepthoffield(var_1, var_2, var_3, var_4, 10, 9);
  var_5 = getdvarfloat("melee_stagger_shock_duration");
  wait scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var_5 * 3, var_5);

  while(var_4 > 350) {
    var_1 = clamp(var_1 - 100, 0, 10000);
    var_2 = clamp(var_2 - 100, 0, 10000);
    var_3 = clamp(var_3 - 100, 0, 10000);
    var_4 = clamp(var_4 - 100, 0, 10000);
    self setdepthoffield(var_1, var_2, var_3, var_4, 10, 9);
    wait 0.05;
  }

  scripts\mp\utility\player::setdof_default();
}

function monitormeleeoverlay(var_0) {
  scripts\engine\utility::ref_143b9(2, "death_or_disconnect");
  var_0 destroy();
}

function allowdamageflash(var_0, var_1, var_2, var_3, var_4) {
  if(isagent(var_1)) {
    return false;
  }

  if(var_4 == 0) {
    return false;
  }

  if(ref_139b6(var_0, var_1, var_2, var_3, var_4)) {
    return false;
  }

  return true;
}

function ref_139b6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    switch (var_2.basename) {
      default:
        break;
    }
  }

  return false;
}

function ref_1458b(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_3.basename;

  if(trial_vehicle_outline_id(var_7)) {
    return 1;
  }

  if(isDefined(level.disable_super_in_turret) && isDefined(var_7)) {
    if(istrue(level.disable_super_in_turret.ref_146bf) && var_7 == "iw8_fists_mp_zmb" || istrue(level.disable_super_in_turret.sat_wait_for_antenna) && var_7 == "iw8_fists_mp_gxp") {
      return 1;
    }
  }

  if(var_4 == "MOD_EXECUTION") {
    return 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "weaponIgnoresBRArmor")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "weaponIgnoresBRArmor")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }

  return 0;
}

function trial_vehicle_outline_id(var_0) {
  return isDefined(var_0) && var_0 == "danger_circle_br";
}

function cac_modified_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_0 notify("damage_begin", var_1);
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = var_0 scripts\mp\gametypes\br_public::hasarmor();
  var_17 = var_0 scripts\mp\gametypes\br_public::hashelmet();

  if(isPlayer(var_1) || isDefined(var_1) && istrue(var_1.brking_getcenterofcircle)) {
    armorvest_clearhit(var_1);
    helmet_clearhit(var_1);
    armorvest_clearbroke(var_1);
    helmet_clearbroke(var_1);
  }

  if(scripts\engine\utility::isbulletdamage(var_3)) {
    var_18 = var_4.basename;
    var_19 = scripts\mp\utility\damage::isheadshot(var_7, var_3, var_1);
    var_20 = scripts\mp\utility\damage::istorsoshot(var_7, var_3, var_1);

    if(isDefined(var_4) && scripts\mp\utility\weapon::iscacprimaryorsecondary(var_18)) {
      if(isbehindmeleevictim(var_1, var_0) && isPlayer(var_0)) {
        level thread scripts\mp\battlechatter_mp::saytoself(var_0, "plr_hit_back", undefined, 0.1);
      }
    }

    if(isDefined(var_10) && var_10 &level.idflags_ricochet) {
      if(var_18 != "none" && !scripts\mp\utility\weapon::issuperweapon(var_18)) {
        var_2 *= 0.4;
      }
    }

    if(isPlayer(var_1) && var_1 scripts\mp\utility\perk::_hasperk("specialty_paint_pro") && !var_11) {
      var_0 thread scripts\mp\perks\perkfunctions::setpainted(var_1);
    }

    if(scripts\mp\utility\weapon::update_health_on_spawn(var_18) && scripts\mp\utility\game::getgametype() == "br") {
      var_2 *= scripts\mp\gametypes\br_jugg_common::reservedplacement();
    }

    var_21 = var_20 && var_0 scripts\mp\utility\perk::_hasperk("specialty_armorvest");
    var_22 = var_19 && var_17;
    var_23 = var_19 && istrue(var_0.hasheadgear);
    var_24 = istrue(var_1.waittill_unload_complete) && scripts\mp\utility\weapon::getweaponrootname(var_4) == "iw8_sn_crossbow";
    var_25 = var_1 scripts\mp\utility\perk::_hasperk("specialty_bulletdamage") || var_24;
    var_26 = scripts\mp\utility\damage::isfmjdamage(var_4, var_3, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nova_rounds", "hitByNovaRounds")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nova_rounds", "hitByNovaRounds")]](var_1, var_5, var_0);
    }

    if(var_22 && !istrue(var_0.inlaststand)) {
      var_27 = weaponclass(var_4);
      var_28 = 0;

      if(var_27 == "sniper" || var_27 == "dmr") {
        var_28 = 1;
      }

      var_29 = var_0 scripts\mp\gametypes\br_public::damagehelmet(var_2, var_28, var_6);
      var_2 *= var_29;
    }

    if(issubstr(var_18, "s4_")) {
      var_30 = scripts\mp\utility\damage::validshotcheck(var_3, var_1);
      var_31 = var_0.br_maxarmorhealth;
      var_32 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

      if(scripts\mp\utility\game::unset_relic_grounded() && isDefined(var_31)) {
        var_32 += var_31;
      }

      var_33 = 1;
      var_34 = 0;
      var_35 = function_0440(var_4, var_2, var_7, var_30, var_12, var_32, var_33, var_34);
      var_2 += var_35 - var_2;
    }

    if(var_25 && var_21) {
      armorvest_sethit(var_1);
    } else if(var_25 && var_2 > 0) {
      var_35 = applystoppingpower(var_4, var_7, var_3, var_1, var_2, 100);
      var_13 += var_35 - var_2;
    } else if(var_21 && !istrue(var_0.tookvesthit) && !var_26) {
      var_0.tookvesthit = 1;
      var_35 = adjustbulletstokill(var_2, 100, level.armorvestbulletdelta);
      var_13 += var_35 - var_2;
      helmet_sethit(var_1);
    } else if(var_23 && !var_26) {
      var_36 = scripts\mp\perks\headgear::getdamagemod();
      var_37 = scripts\mp\perks\headgear::getmaxdamage();
      var_38 = int(clamp(var_2 * var_36, 1, var_37));

      if(var_0.health > 1) {
        var_38 = int(min(var_0.health - 1, var_38));
      }

      var_39 = var_2 - var_38;
      var_13 -= var_39;
      var_0 notify("headgear_save");
      helmet_sethit(var_1);
    }

    if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_2 = ref_11c90(var_4, var_2, var_26, 0, var_1);
    }

    if(isDefined(var_1) && isDefined(var_1.ref_14258) && var_1.ref_14258 == "loot_chopper") {
      var_2 = int(var_2 / 3);
    }
  } else if(isexplosivedamagemod(var_3)) {
    if(isPlayer(var_1)) {
      if(var_1 != var_0 && var_1 scripts\mp\utility\perk::_hasperk("specialty_paint") && !var_11) {
        var_0 thread scripts\mp\perks\perkfunctions::setpainted(var_1);
      }
    }

    var_2 = ref_11c9a(var_2, var_8, var_4);
    var_2 = scripts\mp\equipment\claymore::claymore_modifieddamage(var_0, var_4, var_8, var_3, var_2);
    var_2 = scripts\mp\equipment\at_mine::at_mine_modified_damage(var_0, var_8, var_4, var_3, var_2);

    if(isPlayer(var_1) && weaponinheritsperks(var_4) && var_1 scripts\mp\utility\perk::_hasperk("specialty_explosivedamage") && var_0 scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {} else if(isPlayer(var_1) && weaponinheritsperks(var_4) && !var_11 && var_1 scripts\mp\utility\perk::_hasperk("specialty_explosivedamage")) {
      var_13 += var_2 * level.explosivedamagemod;
    } else if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_0, var_4, var_3, var_8, var_7)) {
      var_40 = ref_11c8f(var_2, var_1, var_0);
      var_13 -= var_2 - var_40;
    }

    if(isPlayer(var_1) && var_1 == var_0 && scripts\mp\utility\weapon::iskillstreakweapon(var_4)) {
      var_2 *= 0.5;
    }

    if(isDefined(level.lethaldelay) && !scripts\mp\equipment::lethaldelaypassed()) {
      var_2 *= level.graceperiodgrenademod;
    }

    if(isDefined(var_0) && var_0 scripts\mp\utility\killstreak::isjuggernaut() && isDefined(var_4) && var_4.basename == "semtex_aalpha12_mp") {
      var_2 *= 110;
    }
  } else if(var_3 == "MOD_FIRE") {
    if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      if(isDefined(var_4.basename) && var_4.basename == "thermite_ap_mp" || var_4.basename == "thermite_bolt_mp") {
        var_2 = ref_11c90(var_4, var_2, 0, 1, var_1);
      }
    }

    if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_0, var_4, var_3, var_8, var_7)) {
      var_40 = ref_11c8f(var_2, var_1, var_0);
      var_13 -= var_2 - var_40;
    }
  }

  var_41 = ref_1458b(var_1, var_0, var_2, var_4, var_3, var_8, var_7);
  var_42 = ["MOD_GRENADE_SPLASH", "MOD_FIRE", "MOD_EXPLOSIVE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE_BULLET"];
  var_43 = var_7 == "shield" && !scripts\engine\utility::array_contains(var_42, var_3);

  if(var_16 && !istrue(var_41) && !istrue(var_0.inlaststand) && !var_43) {
    var_44 = var_0 scripts\mp\gametypes\br_public::damagearmor(var_2);
    var_45 = int(var_2 - var_44);
    var_15 = var_45;
    var_13 -= var_45;
    var_0.tookvesthit = 1;

    if(isPlayer(var_1)) {
      armorvest_sethit(var_1);

      if(ref_1331e(self)) {
        var_1 scripts\mp\utility\stats::incpersstat("damage", var_45);
      } else if(isDefined(level.ref_12001)) {
        var_1[[level.ref_12001]](var_45);
      }
    } else if(isDefined(var_1) && istrue(var_1.brking_getcenterofcircle)) {
      armorvest_sethit(var_1);
    }
  }

  var_46 = scripts\mp\equipment\trophy_system::trophy_modifieddamage(var_1, var_0, var_4.basename, var_2, var_13);
  var_2 = var_46[0];
  var_13 = var_46[1];

  if(var_0 scripts\mp\heavyarmor::hasheavyarmor()) {
    var_46 = scripts\mp\heavyarmor::heavyarmormodifydamage(var_0, var_1, var_2, var_13, var_3, var_4.basename, var_5, var_6, var_7, var_8, var_9);
    var_14 = var_46[0] > 0;
    var_2 = var_46[1];
    var_13 = var_46[2];
  }

  if(scripts\mp\lightarmor::haslightarmor(var_0)) {
    var_46 = scripts\mp\lightarmor::lightarmor_modifydamage(var_0, var_1, var_2, var_13, var_3, var_4.basename, var_5, var_6, var_7, var_8, var_9);
    var_15 = var_46[0] > 0;
    var_2 = var_46[1];
    var_13 = var_46[2];
  }

  if(isPlayer(var_1) || isDefined(var_1) && istrue(var_1.brking_getcenterofcircle)) {
    var_47 = var_0 scripts\mp\gametypes\br_public::hasarmor();
    var_48 = var_0 scripts\mp\gametypes\br_public::hashelmet();

    if(var_16 && !var_47) {
      armorvest_setbroke(var_1);
    }

    if(var_17 && !var_48) {
      helmet_setbroke(var_1);
    }
  }

  if(!isPlayer(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("zombie", "hitByGasZombie")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("zombie", "hitByGasZombie")]](var_1, var_5, var_0);
    }
  }

  if(scripts\mp\utility\damage::hashealthshield(var_0)) {
    var_2 = var_0 scripts\mp\utility\damage::gethealthshielddamage(var_2);
  }

  if(istrue(var_0.inlaststand) && getdvarfloat("scr_player_lastStandHealthScalar", 0) > 0) {
    var_49 = 1;

    if(isDefined(level.ref_11c82)) {
      var_50 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_0, var_2, var_4, var_3, var_8);
      var_49 = self[[level.ref_11c82]](var_50);
    }

    if(var_49) {
      var_2 = int(ceil(var_2 / getdvarfloat("scr_player_lastStandHealthScalar", 0)));
    }
  }

  if(var_2 <= 1) {
    var_2 = int(ceil(clamp(var_2, 0, 1)));
  } else {
    var_2 = int(var_2 + var_13);
  }

  return [var_2, var_15, var_14, var_7];
}

function ref_11c8f(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::unset_relic_grounded();
  var_4 = undefined;
  var_5 = undefined;

  if(var_3) {
    var_4 = level.completed_areas;
    var_5 = level.completecollectionquest;
  } else {
    var_4 = level.blastshieldmod;
    var_5 = level.blastshieldclamp;
  }

  var_6 = int(var_0 * var_4);

  if(var_1 != var_2) {
    var_6 = clamp(var_6, 0, var_5);
  }

  return var_6;
}

function ref_11c90(var_0, var_1, var_2, var_3, var_4) {
  var_5 = weaponclass(var_0);
  var_6 = 1;

  if(isDefined(var_4) && var_4 scripts\mp\utility\killstreak::isjuggernaut() && scripts\mp\utility\game::getgametype() == "br") {
    var_6 = scripts\mp\gametypes\br_jugg_common::remove_spawners_that_can_be_seen();
  }

  switch (var_5) {
    case "smg":
    case "pistol":
      var_1 = min(15, var_1);
      break;
    case "mg":
    case "rifle":
      if(scripts\mp\utility\weapon::update_health_on_spawn(var_0.basename) && scripts\mp\utility\game::getgametype() == "br") {
        var_1 = min(50, var_1);
      } else {
        var_1 = min(20, var_1);
      }

      break;
    case "spread":
      var_1 = min(25, var_1);
      break;
    case "sniper":
      break;
    default:
      var_1 = min(15, var_1);
      break;
  }

  var_1 = int(var_1 * var_6);

  if(istrue(var_2)) {
    var_1 *= level.armorpiercingmod;
  }

  if(istrue(var_3)) {
    if(var_0.basename == "thermite_ap_mp") {
      var_1 *= 6;
    } else if(var_0.basename == "thermite_bolt_mp") {
      var_1 *= 3;
    } else if(var_0.basename == "thermite_xmike109_mp") {
      var_1 *= 3;
    }
  }

  return var_1;
}

function ref_11c9a(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!nullweapon(var_2)) {
    return var_0;
  }

  if(!isDefined(var_1.code_classname) || var_1.code_classname != "scriptable") {
    return var_0;
  }

  var_3 = var_1.classname;

  if(isDefined(var_3) && isstartstr(var_3, "scriptable_")) {
    var_3 = getsubstr(var_3, 11, var_3.size);
    var_4 = ["uk_gas_tank_thin_cylinder", "uk_misc_fuel_jug", "uk_fire_extinguisher", "uk_misc_fuel_jug", "decor_barrels_gameplay_flammable", "un_propane_gas_tank", "machinery_oxygen_generator_tank", "sol_barrel", "box_wooden_grenade", "container_gas_tank", "decor_propane_tank", "equipment_propane_burner_stove", "equipment_propane_tank", "misc_propane_rocket", "oil_drum", "rp_propane_tank", "misc_exterior_oxygen_barrel"];

    foreach(var_6 in var_4) {
      if(isstartstr(var_3, var_6)) {
        if(scripts\mp\utility\game::isanymlgmatch()) {
          return 0;
        }

        return int(min(var_0, 60));
      }
    }
  }

  return var_0;
}

function unsetspecialistbonus(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0) && isPlayer(var_0) && (!isalive(var_0) || scripts\mp\utility\player::unset_relic_trex(var_0))) {
    if(istrue(var_5) && weaponclass(var_4) == "spread") {
      return true;
    } else if(var_2 >= var_1.health) {
      if(var_3 == "MOD_MELEE") {
        return true;
      } else if(istrue(var_5)) {
        return true;
      }
    }
  }

  return false;
}

function tutorialzoneexit(var_0, var_1) {
  return isDefined(var_1) && weaponclass(var_1) == "rifle" && isDefined(var_1.underbarrel) && issubstr(var_1.underbarrel, "buckslug");
}

function usetimeoverride(var_0) {
  return isDefined(var_0) && weaponclass(var_0) == "spread";
}

function uavworstid(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_1 == "iw8_sn_crossbow") {
    return true;
  }

  return false;
}

function vehicle_collision_getleveldataforvehicle(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_1 == "iw8_sn_xmike109") {
    return true;
  }

  return false;
}

function turn_on_laser_trap(var_0, var_1) {
  if(var_0 hasattachment("calcustmags_aalpha12") && var_1 == "MOD_RIFLE_BULLET") {
    return true;
  }

  return false;
}

function ref_132f0(var_0) {
  if(var_0 hasattachment("boltexplo_crossbow")) {
    return true;
  }

  return false;
}

function ref_1332d(var_0) {
  if(var_0 hasattachment("calcust", 1)) {
    return false;
  }

  return true;
}

function usefaillaststandmsg(var_0) {
  if(var_0.basename == "semtex_xmike109_splash_mp" || var_0.basename == "thermite_xmike109_radius_mp" || var_0.basename == "semtex_bolt_splash_mp" || var_0.basename == "thermite_bolt_radius_mp" || var_0.basename == "semtex_aalpha12_splash_mp") {
    return 1;
  }

  return 0;
}

function ref_13714(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isDefined(var_0)) {
    if(var_4 &level.sstablet_init) {
      var_5 = "lHandWeap";
    } else {
      var_5 = "rHandWeap";
    }

    if(!isDefined(var_2.ref_122f1)) {
      var_2.ref_122f1 = [];
    }

    var_6 = "" + var_1 getentitynumber();
    var_7 = gettime();

    foreach(var_13, var_9 in var_2.ref_122f1) {
      foreach(var_11 in var_9) {
        if((var_7 - var_11.time) / 1000 > 0.1) {
          var_2.ref_122f1[var_13] = scripts\engine\utility::array_remove_key(var_2.ref_122f1[var_13], var_12);

          if(var_2.ref_122f1[var_13].size == 0) {
            var_2.ref_122f1 = scripts\engine\utility::array_remove_key(var_2.ref_122f1, var_13);
          }
        }
      }
    }

    if(!isDefined(var_2.ref_122f1[var_5])) {
      var_2.ref_122f1[var_5] = [];
    }

    if(!isDefined(var_2.ref_122f1[var_5][var_6])) {
      var_2.ref_122f1[var_5][var_6] = spawnStruct();
      var_2.ref_122f1[var_5][var_6].time = var_7;
      var_2.ref_122f1[var_5][var_6].ref_122f0 = [];
    }

    var_14 = rotationentangles(var_2, var_3);
    var_15 = var_2.ref_122f1[var_5][var_6].ref_122f0;

    if(var_2.ref_122f1[var_5][var_6].ref_122f0.size >= var_14) {
      if(getdvarint("scr_spread_use_highest_damage_pellets", 1)) {
        foreach(var_17 in var_2.ref_122f1[var_5][var_6].ref_122f0) {
          if(var_4 > var_17) {
            var_2.ref_122f1[var_5][var_6].ref_122f0[var_18] = var_4;
            var_2.ref_122f1[var_5][var_6].ref_122f0 = scripts\engine\utility::array_sort_with_func(var_2.ref_122f1[var_5][var_6].ref_122f0, &tromeo_death_watcher);
            return (var_4 - var_17);
          }
        }
      }

      return 0;
    } else {
      var_2.ref_122f1[var_5][var_6].ref_122f0 = scripts\engine\utility::array_add(var_2.ref_122f1[var_5][var_6].ref_122f0, var_4);
      var_2.ref_122f1[var_5][var_6].ref_122f0 = scripts\engine\utility::array_sort_with_func(var_2.ref_122f1[var_5][var_6].ref_122f0, &tromeo_death_watcher);
    }
  }

  return var_4;
}

function tromeo_death_watcher(var_0, var_1) {
  return var_0 < var_1;
}

function rotationentangles(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "iw8_sh_charlie725" || var_2 == "iw8_pi_cpapa") {
    if(var_0 isdualwielding()) {
      return 2;
    }

    if(var_1 hasattachment("barshort_charlie725")) {
      return 3;
    }

    var_3 = var_0 playerads() > 0.5;

    if(var_3) {
      return 4;
    }

    return 3;
  }

  return 4;
}

function armorvest_washit(var_0) {
  return isDefined(var_0.hitarmorvest) && gettime() == var_0.hitarmorvest;
}

function armorvest_sethit(var_0) {
  var_0.hitarmorvest = gettime();
}

function armorvest_clearhit(var_0) {
  var_0.hitarmorvest = undefined;
}

function armorvest_wasbroke(var_0) {
  return isDefined(var_0.brokearmorvest) && gettime() == var_0.brokearmorvest;
}

function armorvest_setbroke(var_0) {
  var_0.brokearmorvest = gettime();
}

function armorvest_clearbroke(var_0) {
  var_0.brokearmorvest = undefined;
}

function heavyarmorvest_washit(var_0) {
  return isDefined(var_0.hitheavyarmorvest) && gettime() == var_0.hitheavyarmorvest;
}

function heavyarmorvest_sethit(var_0) {
  var_0.hitheavyarmorvest = gettime();
}

function heavyarmorvest_clearhit(var_0) {
  var_0.hitheavyarmorvest = undefined;
}

function heavyarmorvest_wasbroke(var_0) {
  return isDefined(var_0.brokeheavyarmorvest) && gettime() == var_0.brokeheavyarmorvest;
}

function heavyarmorvest_setbroke(var_0) {
  var_0.brokeheavyarmorvest = gettime();
}

function heavyarmorvest_clearbroke(var_0) {
  var_0.brokeheavyarmorvest = undefined;
}

function helmet_washit(var_0) {
  return isDefined(var_0.hithelmet) && gettime() == var_0.hithelmet;
}

function helmet_sethit(var_0) {
  var_0.hithelmet = gettime();
}

function helmet_clearhit(var_0) {
  var_0.hithelmet = undefined;
}

function helmet_wasbroke(var_0) {
  return isDefined(var_0.brokehelmet) && gettime() == var_0.brokehelmet;
}

function helmet_setbroke(var_0) {
  var_0.brokehelmet = gettime();
}

function helmet_clearbroke(var_0) {
  var_0.brokehelmet = undefined;
}

function applystoppingpower(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  var_6 = getbulletstokill(var_5, var_4);
  var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_6 == 2) {
    if(ref_138f2(var_0, var_1, var_2, var_3)) {
      return var_5;
    } else {
      return (0.9 * var_5);
    }
  }

  var_8 = -1;

  if(var_6 >= 7) {
    var_8 = -3;
  } else if(var_6 >= 5) {
    var_8 = -2;
  }

  return adjustbulletstokill(var_4, var_5, var_8, var_7);
}

function ref_138f2(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_5 = weaponclass(var_0);

  if(var_4 == "iw8_sn_crossbow") {
    return true;
  } else if(var_5 == "sniper") {
    switch (var_4) {
      case "iw8_sn_sksierra":
      case "iw8_sn_mike14":
        if(scripts\mp\utility\damage::istorsouppershot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3)) {
          return true;
        }

        break;
      case "iw8_sn_sbeta":
      case "iw8_sn_delta":
      case "iw8_sn_kilo98":
        if(scripts\mp\utility\damage::istorsoshot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3)) {
          return true;
        }

        break;
      default:
        if(scripts\mp\utility\damage::isupperbodyshot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3)) {
          return true;
        }

        break;
    }
  } else if(var_5 == "pistol") {
    switch (var_4) {
      case "iw8_pi_decho":
      case "iw8_pi_cpapa":
        if(scripts\mp\utility\damage::istorsouppershot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3)) {
          return true;
        }

        break;
    }
  } else if(var_5 == "rifle") {
    switch (var_4) {
      case "iw8_ar_asierra12":
      case "iw8_ar_falima":
        if(scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3)) {
          return true;
        }

        break;
    }

    var_6 = getweaponammopoolname(var_0);

    switch (var_6) {
      case "WEAPON/AMMO_SLUGS":
      case "WEAPON/AMMO_7_62_M67":
        if(scripts\mp\utility\damage::istorsouppershot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3)) {
          return true;
        }

        break;
    }
  }

  return false;
}

function adjustbulletstokill(var_0, var_1, var_2, var_3) {
  var_0 = int(var_0);
  var_2 = int(var_2);

  if(var_2 == 0) {
    return var_0;
  }

  if(var_0 <= 0) {
    return var_0;
  }

  var_4 = getbulletstokill(var_1, var_0);
  var_5 = var_4 + var_2;

  if(isDefined(var_3) && var_3 == "iw8_sn_t9accurate") {
    var_0 *= 1.3;
  } else if(var_5 <= 0) {
    var_0 *= 1.4;
  } else if(var_5 == 1) {
    var_0 = int(max(var_1, var_0 * 1.4));
  } else {
    var_6 = scripts\engine\utility::ter_op(var_0 > var_1, var_1, var_0);
    var_7 = 0;

    if(var_4 == 1) {
      var_7 = 0.9;
    } else {
      var_8 = int(ceil(var_1 / (var_4 - 1)));
      var_9 = int(ceil(var_1 / var_4));
      var_7 = (var_6 - var_9) / (var_8 - var_9);
    }

    var_10 = int(ceil(var_1 / (var_5 - 1)));
    var_11 = int(ceil(var_1 / var_5));
    var_0 = int((var_10 - var_11) * var_7 + var_11);
  }

  return var_0;
}

function getbulletstokill(var_0, var_1) {
  return int(ceil(var_0 / var_1));
}

function isbehindmeleevictim(var_0, var_1) {
  var_2 = vectorNormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_3 = anglesToForward((0, var_1.angles[1], 0));
  return vectordot(var_2, var_3) > 0.4;
}

function killstreakdamagefilter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(level.playgotinfectedsoundcount)) {
    var_5 = [[level.playgotinfectedsoundcount]](var_0, var_1, var_2, var_3, var_4);
  }

  if(var_1 scripts\mp\utility\game::isspawnprotected() || istrue(var_5)) {
    var_6 = int(max(var_1.health / 4, 1));

    if(var_2 >= var_6 && scripts\mp\utility\weapon::iskillstreakweapon(var_3.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var_3) && var_4 != "MOD_MELEE") {
      var_2 = var_6;
    }
  }

  return var_2;
}

function friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = 0;

  if(isDefined(var_6)) {
    switch (var_6.basename) {
      case "none":
        if(isDefined(var_0) && scripts\mp\utility\entity::isdronepackage(var_0)) {
          var_13 = 1;
        }

        break;
      case "apache_turret_mp":
      case "trophy_mp":
        var_13 = 1;
        break;
    }
  }

  return var_13;
}

function handlefriendlyfiredamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_6) && scripts\engine\utility::isbulletdamage(var_5) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_6.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_6.basename))) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_2, "check_fire_ally", undefined, 0.25);
  }

  if(isDefined(var_0) && !isPlayer(var_0)) {
    if(!isDefined(var_1)) {
      if(isDefined(var_0.owner)) {
        var_1 = var_0.owner;
      }
    } else if(!isPlayer(var_1)) {
      if(isDefined(var_0.owner)) {
        var_1 = var_0.owner;
      } else if(isDefined(var_1.owner)) {
        var_1 = var_1.owner;
      }
    }
  }

  if(level.hardcoremode) {
    if(isDefined(var_4) && var_4 &level.idflags_ricochet && scripts\engine\utility::isbulletdamage(var_5)) {
      var_3 = int(var_3 * 0.2);
    }
  }

  if(level.friendlyfire != 0) {
    if(level.maxallowedteamkills == -1) {
      var_14 = 0;
    } else {
      var_14 = istrue(var_3.unset_relic_ammo_drain) || istrue(var_3.isdefusing) || istrue(var_3.isplanting);
    }

    var_15 = unset_relic_doubletap(var_2);

    if(var_14 || var_15) {
      var_4 = int(var_4 * 0.5);

      if(var_4 < 1) {
        var_4 = 1;
      }

      var_2.lastdamagewasfromenemy = 0;
      damageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isPlayer(var_2) && level.friendlyfire != 1 || var_7.basename == "bomb_site_mp") {
    return 0;
  } else if(level.friendlyfire == 1) {
    if(var_4 < 1) {
      var_4 = 1;
    }

    var_3.lastdamagewasfromenemy = 0;
    ref_119c0(var_3, var_2, var_4, var_6);
    finishplayerdamagewrapper(var_3, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    handledamagefeedback(var_2, var_1, var_2, var_3, var_4, var_6, var_7, var_10, var_5, 0, 0, var_14);
    return 0;
  } else if(level.friendlyfire == 2) {
    var_4 = int(var_4 * 0.5);

    if(var_4 < 1) {
      var_4 = 1;
    }

    var_2.lastdamagewasfromenemy = 0;

    if(!friendlyfire_ignoresdamageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13)) {
      damageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    }

    return 0;
  } else if(level.friendlyfire == 3) {
    var_4 = int(var_4 * 0.5);

    if(var_4 < 1) {
      var_4 = 1;
    }

    var_3.lastdamagewasfromenemy = 0;
    var_2.lastdamagewasfromenemy = 0;
    ref_119c0(var_3, var_2, var_4, var_6);
    finishplayerdamagewrapper(var_3, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(!friendlyfire_ignoresdamageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13)) {
      damageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    }

    handledamagefeedback(var_2, var_1, var_2, var_3, var_4, var_6, var_7, var_10, var_5, 0, 0, var_14);
    return 0;
  } else if(level.friendlyfire == 4) {
    var_16 = var_2.pers["teamkills"] >= level.maxallowedteamkills;

    if(var_16) {
      if(!friendlyfire_ignoresdamageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13)) {
        var_4 = int(var_4 * 0.5);

        if(var_4 < 1) {
          var_4 = 1;
        }

        var_2.lastdamagewasfromenemy = 0;
        damageattacker(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      }

      return 0;
    }
  }

  return var_4;
}

function unset_relic_doubletap(var_0) {
  if(level.ingraceperiod) {
    return true;
  }

  if(var_0.pers["teamkills"] > 1 && scripts\mp\utility\game::gettimepassed() < level.graceperiod * 1000 + 8000 + var_0.pers["teamkills"] * 1000) {
    return true;
  }

  return false;
}

function damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_1.friendlydamage = 1;
    finishplayerdamagewrapper(var_1, var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_1.friendlydamage = undefined;
    return;
  }
}

function ref_11c5e(var_0) {
  return var_0 == "head" || var_0 == "helmet" || var_0 == "neck";
}

function ref_11c92(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "iw8_pi_mike9" && var_1 hasattachment("akimbo_mike9") && var_1 hasattachment("barburst_mike9")) {
    return (var_0 * 0.75);
  }

  return var_0;
}

function ref_11c93(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "iw8_pi_mike" && var_1 hasattachment("akimbo_mike") && var_1 hasattachment("barauto_mike")) {
    return (var_0 * 0.75);
  }

  return var_0;
}

function ref_11c9f(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1)) {
    if(turn_on_laser_trap(var_0, var_4)) {
      if(var_2.health > 0 && var_3 >= var_2.health) {
        var_3 = var_2.health - 1;
      }
    } else if(isDefined(var_0.ref_136fa)) {
      if(!isDefined(var_1.ref_136f5)) {
        var_1.ref_136f5 = [];
      }

      var_5 = "" + var_2 getentitynumber();
      var_6 = gettime();
      var_1.ref_136f5[var_5] = spawnStruct();
      var_1.ref_136f5[var_5].time = var_6;
      var_1.ref_136f5[var_5].starcount = var_0.ref_136fa.basename;
    } else if(isDefined(var_1.ref_136f5)) {
      var_6 = gettime();

      foreach(var_9, var_8 in var_1.ref_136f5) {
        if(var_6 != var_8.time) {
          var_1.ref_136f5 = scripts\engine\utility::array_remove_key(var_1.ref_136f5, var_9);
        }
      }

      var_9 = "" + var_2 getentitynumber();

      if(scripts\engine\utility::array_contains_key(var_1.ref_136f5, var_9) && var_1.ref_136f5[var_9].starcount == var_0.basename) {
        var_3 = 0;
        var_1.ref_136f5 = scripts\engine\utility::array_remove_key(var_1.ref_136f5, var_9);
      }

      if(var_1.ref_136f5.size == 0) {
        var_1.ref_136f5 = undefined;
      }
    }
  }

  return var_3;
}

function ref_11c61(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::isanymlgmatch() && isDefined(var_0) && isPlayer(var_0) && !nullweapon(var_3) && scripts\mp\utility\weapon::isprimaryweapon(var_3) && scripts\engine\utility::isbulletdamage(var_2) && ref_11c5e(var_4)) {
    switch (var_3.classname) {
      case "smg":
      case "pistol":
      case "mg":
      case "rifle":
        var_1 = int(clamp(var_1, 0, var_3.maxdamage * 1.3));
        break;
    }
  }

  return var_1;
}

function ref_11c9b(var_0, var_1, var_2) {
  var_3 = var_1;

  if(isDefined(var_2) && var_2 == "MOD_FALLING") {
    if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_3 = var_0 scripts\mp\juggernaut::vehicle_deletenextframe();
    }
  }

  return var_3;
}

function ref_11ca3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(var_2 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_5 = var_2 scripts\mp\juggernaut::vehicle_deregister_on_death(var_3, var_4);
    }
  }

  return var_5;
}

function ref_11ca2(var_0, var_1) {
  var_2 = var_1;
  var_3 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_3)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_damage::ref_14160(var_3, var_0, var_1);
  }

  return var_2;
}

function ref_11c97(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(var_4) && var_4 == "MOD_CRUSH") {
    if(isDefined(var_0) && isDefined(var_1) && var_0 == var_1 && var_1 scripts\mp\utility\killstreak::isjuggernaut() && var_2 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_5 = var_2 scripts\mp\juggernaut::vehicle_deletenextframelate(var_3);
    }
  }

  return var_5;
}

function modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_3 = ref_11c92(var_3, var_6);
  var_3 = ref_11c93(var_3, var_6);
  var_3 = ref_11c61(var_1, var_3, var_5, var_6, var_9);
  var_3 = ref_11c9b(var_2, var_3, var_5);
  var_3 = ref_11ca3(var_0, var_1, var_2, var_3, var_5);
  var_3 = ref_11ca2(var_2, var_3);
  var_3 = ref_11c97(var_0, var_1, var_2, var_3, var_5);
  var_3 = ref_11c9f(var_6, var_1, var_2, var_3, var_5);

  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1 && isDefined(var_6) && var_6 getbaseweapon().basename != "iw8_sm_t9flechette_mp") {
    var_3 *= getdvarfloat("scr_explBulletMod");
    var_3 = int(var_3);
  }

  if(var_5 == "MOD_IMPACT" && var_3 != 1) {
    if(istrue(var_6.isalternate) && scripts\mp\weapons::turretobjweapon(var_6.underbarrel)) {
      var_12 = var_0 scriptableclearparententity();
      var_13 = length(var_12);

      if(var_13 < 400) {
        var_3 = 10;
      }
    }
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_3 = int([[level.modifyplayerdamage]](var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4, var_11));
  }

  if(!isDefined(var_2.donotmodifydamage)) {
    var_3 = int(var_3 * var_2 scripts\cp_mp\utility\damage_utility::getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_5, var_6, var_9));
  }

  if(scripts\mp\utility\damage::isheadshot(var_9, var_5, var_1)) {
    var_5 = "MOD_HEAD_SHOT";
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(var_5 == "MOD_HEAD_SHOT") {
      var_3 = 150;
    }
  }

  return var_3;
}

function handleriotshieldhits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_8 != "shield" || istrue(var_2.should_take_damage)) {
    return var_3;
  }

  var_12 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_2, var_1, var_3, var_5, var_4, var_0, var_6, var_7, undefined, undefined, undefined, var_9);
  var_13 = istrue(var_1.ignoreriotshieldxp);

  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;

    if(var_2 == var_1) {
      return 0;
    }
  }

  if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
    if(isPlayer(var_2)) {
      var_2.lastattackedshieldplayer = var_1;
      var_2.lastattackedshieldtime = gettime();
    }

    var_1 notify("shield_blocked");
    jumpiffalse(scripts\mp\utility\weapon::isenvironmentweapon(var_5.basename)) LOC_000000c7;
    var_14 = 25;
    goto LOC_000000fe;
  }

  var_22 = isDefined(var_1) && isDefined(var_1.stuckenemyentity) && var_1.stuckenemyentity == var_2;

  if(var_10 &level.idflags_shield_explosive_impact) {
    var_2.forcehitlocation = "none";

    if(!(var_10 &level.idflags_shield_explosive_impact_huge)) {
      var_2 scripts\mp\utility\stats::incpersstat("riotShieldDamageAbsorbed", var_4);
      var_4 = 0;
    }
  } else if(var_10 &level.idflags_shield_explosive_splash) {
    var_2.forcehitlocation = "none";

    if(var_2 scripts\cp_mp\utility\damage_utility::isstuckdamagekill(var_13)) {
      var_4 = var_2.maxhealth;
    }
  } else if(istrue(var_3.should_take_damage)) {
    return var_4;
  } else {
    return 0;
  }

  if(var_5 == "MOD_MELEE" && scripts\mp\riotshield::isriotshield(var_6.basename)) {
    var_2 stunplayer(0);
  }

  return var_4;
}

function filterdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!var_3) {
    return "!iDamage";
  }

  if(isDefined(level.hostmigrationtimer)) {
    return "level.hostMigrationTimer";
  }

  if(isDefined(level.validateattacker)) {
    var_1 = [[level.validateattacker]](var_1);
  } else {
    var_1 = scripts\mp\utility\damage::_validateattacker(var_1);
  }

  if(!isDefined(var_1) && var_4 != "MOD_FALLING") {
    return "invalid attacker";
  }

  var_2 = scripts\mp\utility\damage::_validatevictim(var_2);

  if(!isDefined(var_2)) {
    return "invalidVictim";
  }

  if(game["state"] == "postgame") {
    return "game[ state ] == postgame";
  }

  if(isDefined(var_2.sessionteam) && var_2.sessionteam == "spectator") {
    return "victim.sessionteam == spectator";
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(var_6 != "head" && var_6 != "helmet") {
      if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
        return "getTweakableValue( game, onlyheadshots )";
      }
    }
  }

  if(scripts\cp_mp\vehicles\vehicle::ref_14201(var_0, var_2, var_4, var_5)) {
    return "playerJustExitedVehicle";
  }

  var_7 = isDefined(var_1) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");

  if(!level.teambased && var_7 && isDefined(var_1.owner) && var_1.owner == var_2) {
    if(var_4 == "MOD_CRUSH") {
      var_2 scripts\mp\utility\damage::_suicide();
    }

    return "ffa suicide";
  }
}

function logattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1.owner) && isPlayer(var_1.owner) && (!isDefined(var_1.scrambled) || !var_1.scrambled)) {
    addattacker(var_0, var_1.owner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1.secondowner) && isDefined(var_1.scrambled) && var_1.scrambled) {
    addattacker(var_0, var_1.secondowner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_2) && isDefined(var_2.owner) && isDefined(var_2.owner.guid) && isPlayer(var_1.owner)) {
    var_10 = var_2.owner.team != var_0.team || level.friendlyfire == 1;

    if(var_10 && !istrue(var_2.owner.ref_1407d) && !isDefined(self.attackerdata[var_2.owner.guid])) {
      addattacker(var_0, var_2.owner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  if(isDefined(var_1)) {
    level.lastlegitimateattacker = var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3)) {
    var_1 thread scripts\mp\weapons::checkhit(var_3, var_0);
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3) && var_1 != var_0) {
    var_1 thread scripts\mp\events::damagedplayer(self, var_4);
    var_0.attackerposition = var_1.origin;
    return;
  }

  var_0.attackerposition = undefined;
}

function logattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_2) && isPlayer(var_2)) {
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.owner) && (!isDefined(var_2.scrambled) || !var_2.scrambled)) {
    var_2 = var_2.owner;
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.secondowner) && isDefined(var_2.scrambled) && var_2.scrambled) {
    var_2 = var_2.secondowner;
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_2)) {
    level.lastlegitimateattacker = var_2;
  }

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_10) && var_2 != var_0) {
    var_0.attackerposition = var_2.origin;
    return;
  }

  var_0.attackerposition = undefined;
}

function loggrenadedata(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((issubstr(var_4, "MOD_EXPLOSIVE") || issubstr(var_4, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
    var_6 = createheadicon(var_5);
    var_2.explosiveinfo = [];
    var_2.explosiveinfo["damageTime"] = gettime();
    var_2.explosiveinfo["damageId"] = var_0 getentitynumber();
    var_2.explosiveinfo["returnToSender"] = 0;
    var_2.explosiveinfo["counterKill"] = 0;
    var_2.explosiveinfo["chainKill"] = 0;
    var_2.explosiveinfo["cookedKill"] = 0;
    var_2.explosiveinfo["throwbackKill"] = 0;
    var_2.explosiveinfo["suicideGrenadeKill"] = 0;
    var_2.explosiveinfo["weapon"] = var_6;
    var_7 = issubstr(var_5.basename, "frag_");

    if(var_1 != var_2) {
      if((issubstr(var_5.basename, "c4_") || issubstr(var_5.basename, "proximity_explosive_") || issubstr(var_5.basename, "claymore_")) && isDefined(var_0.owner)) {
        var_2.explosiveinfo["returnToSender"] = var_0.owner == var_2;
        var_2.explosiveinfo["counterKill"] = isDefined(var_0.wasdamaged);
        var_2.explosiveinfo["chainKill"] = isDefined(var_0.waschained);
        var_2.explosiveinfo["bulletPenetrationKill"] = isDefined(var_0.wasdamagedfrombulletpenetration);
        var_2.explosiveinfo["cookedKill"] = 0;
      }

      if(isDefined(var_1.lastgrenadesuicidetime) && var_1.lastgrenadesuicidetime >= gettime() - 50 && var_7) {
        var_2.explosiveinfo["suicideGrenadeKill"] = 1;
      }
    }

    if(var_7) {
      var_2.explosiveinfo["cookedKill"] = isDefined(var_0.iscooked);
      var_2.explosiveinfo["throwbackKill"] = isDefined(var_0.threwback);
    }

    var_2.explosiveinfo["stickKill"] = isDefined(var_0.isstuck) && var_0.isstuck == "enemy";
    var_2.explosiveinfo["stickFriendlyKill"] = isDefined(var_0.isstuck) && var_0.isstuck == "friendly";

    if(isPlayer(var_1) && var_1 != self && scripts\mp\utility\game::getgametype() != "aliens") {
      updateinflictorstat(var_0, var_1, var_6);
      return;
    }

    return;
  }
}

function handledamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = isDefined(var_1) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");

  if(var_11 && isDefined(var_1.gunner)) {
    var_12 = var_1.gunner;
  } else if(isDefined(var_2) && isDefined(var_2.owner)) {
    var_12 = var_2.owner;
  } else {
    var_12 = var_3;
  }

  var_13 = "standard";

  if(isDefined(var_12) && var_12 != var_4 && var_5 + var_10 + var_11 > 0 && (!isDefined(var_8) || var_8 != "shield")) {
    var_14 = !var_4 scripts\cp_mp\utility\player_utility::_isalive() || isagent(var_4) && var_5 >= var_4.health;

    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath") && isDefined(var_4.inlaststand) && var_4.inlaststand == 1 && !var_4.hasshownlaststandicon) {
      var_4.hasshownlaststandicon = 1;
      var_13 = "hitlaststand";
    } else if(isPlayer(var_4) && var_4 method_87d3()) {
      var_13 = "hitlaststand";
    } else if(istrue(var_4.ref_133ef) && !armorvest_wasbroke(var_3)) {
      var_13 = "hitspawnprotect";
    } else if(istrue(var_4.isjuggernaut)) {
      var_13 = "hitjuggernaut";
    } else if(var_4 scripts\mp\heavyarmor::hasheavyarmor() || var_4 scripts\mp\heavyarmor::hasheavyarmorinvulnerability()) {
      var_13 = "hitarmorheavy";
    } else if(var_9 &level.idflags_stun) {
      var_13 = "stun";
    } else if(scripts\mp\utility\damage::istacticaldamage(var_7, var_6) && var_4 scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && !var_4 scripts\mp\utility\perk::_hasperk("penalty_stun_more")) {
      var_13 = "hittacresist";
    } else if(var_4 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_3, var_4, var_7, var_6, var_2, var_8)) {
      var_13 = "hitblastshield";
    } else if(scripts\mp\utility\damage::hashealthshield(var_4)) {
      var_13 = "hitarmorlight";
    } else if(armorvest_wasbroke(var_3) && var_4 scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
      var_13 = "hitarmorreinforcedbreak";
    } else if(armorvest_washit(var_3) && var_4 scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
      var_13 = "hitarmorreinforced";
    } else if(var_10 > 0 && var_4 scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
      var_13 = "hitarmorreinforced";
    } else if(var_10 == 0 && var_4 scripts\mp\utility\perk::_hasperk("specialty_br_serpentine") && (var_4 issupersprinting() || var_4 issprintsliding())) {
      var_13 = "hitserpentine";
    } else if(armorvest_wasbroke(var_3)) {
      var_13 = "hitarmorlightbreak";
    } else if(helmet_wasbroke(var_3)) {
      var_13 = "hithelmetlightbreak";
    } else if(armorvest_washit(var_3)) {
      var_13 = "hitarmorlight";
    } else if(helmet_washit(var_3)) {
      var_13 = "hithelmetlight";
    } else if(var_10 > 0) {
      var_13 = "hitarmorlight";
    } else if(istrue(var_4.adrenalinepoweractive)) {
      var_13 = "hitadrenaline";
    } else if(var_4 scripts\mp\utility\game::isspawnprotected() && var_12 && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var_7)) {
      var_13 = "hitspawnprotect";
    }

    var_15 = scripts\engine\utility::isbulletdamage(var_6);
    var_16 = scripts\engine\utility::ter_op(var_15 && scripts\mp\utility\weapon::isprimaryweapon(var_7), "standardspread", "standard");
    var_17 = 0;

    if(var_13 == "hitarmorreinforcedbreak") {
      var_17 = 1;

      if(var_16 == "standardspread") {
        var_16 = "standardspreadreinforcedarmor";
      } else {
        var_16 = "standardreinforcedarmor";
      }
    } else if(var_13 == "hitarmorlightbreak") {
      var_17 = 1;

      if(var_16 == "standardspread") {
        var_16 = "standardspreadarmor";
      } else {
        var_16 = "standardarmor";
      }
    }

    var_18 = !usetimeoverride(var_7) && scripts\mp\utility\damage::isheadshot(var_8, var_6, var_3);
    var_19 = 1;
    var_20 = var_6 == "MOD_MELEE";
    var_21 = "" + var_4 getentitynumber();
    var_22 = 0;

    if(!var_17 && usetimeoverride(var_7) && isDefined(var_12.ref_122f1)) {
      foreach(var_24 in var_12.ref_122f1) {
        if(isDefined(var_24[var_21]) && var_24[var_21].ref_122f0.size > 1) {
          var_22 = 1;
        }
      }
    }

    if(!var_20 && var_22) {
      if(var_14) {
        var_20 = 1;
      } else {
        var_19 = 0;
      }
    }

    if(var_19) {
      var_12 thread scripts\mp\damagefeedback::updatedamagefeedback(var_13, var_14, var_18, var_16, var_20);
      return;
    }

    return;
  }
}

function lethalequipmentdamagemod(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, undefined, undefined, undefined, undefined, undefined, var_4);

  if(isDefined(var_0) && isDefined(var_0.damagedby)) {
    var_1 = var_0.damagedby;
  }

  if(var_2 scripts\cp_mp\utility\damage_utility::isstuckdamagekill(var_7)) {
    if(var_2 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_3 = min(300, var_3);
    } else {
      var_3 = var_2.maxhealth + scripts\engine\utility::ter_op(isDefined(self.br_armorhealth), self.br_armorhealth, 0);
    }
  }

  if(isDefined(var_5) && var_5 != "MOD_IMPACT") {
    if(var_2 != var_1 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade" && var_2.lastspawntime + 3500 > gettime() && isDefined(var_2.lastspawnpoint) && distance(var_0.origin, var_2.lastspawnpoint.origin) < 500) {
      var_3 = 0;
    }
  }

  if(isDefined(level.ref_132a4)) {
    var_3 *= [[level.ref_132a4.removelinkdamagemodifieronlaststand]](var_0);
  }

  loggrenadedata(var_0, var_1, var_2, var_3, var_5, var_6);
  var_1 scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var_6), "damage", min(var_2.health, var_3), -1, var_6);
  return var_3;
}

function playerkilled_initdeathdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, undefined, var_7, undefined, undefined, undefined, var_4);
  var_12.hitloc = var_8;
  var_12.psoffsettime = var_9;
  var_12.deathanimduration = var_10;
  var_12.isfauxdeath = var_11;

  if(var_5 == "MOD_EXECUTION") {
    var_12.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(var_1);
  }

  var_12.dokillcam = 0;
  var_12.dofinalkillcam = 1;
  var_12.killcamentity = undefined;
  var_12.killcamentityindex = -1;
  var_12.killcamentitystarttime = 0;
  var_12.inflictoragentinfo = undefined;
  var_12.killcamentstickstovictim = undefined;
  var_12.isfriendlyfire = undefined;
  var_12.primaryweapon = undefined;
  var_12.lifeid = undefined;
  var_12.attackerentnum = undefined;
  var_12.iskillstreakweapon = undefined;
  var_12.weaponfullstring = undefined;
  var_12.isnukekill = 0;
  var_12.deathscenetimesec = getdvarfloat("scr_death_scene_time", 1.75);
  var_12.deathscenetimems = int(var_12.deathscenetimesec * 1000);
  var_12.deathtime = gettime();
  var_12.enemy_monitor_trialending = undefined;
  return var_12;
}

function playerkilled_parameterfixup(var_0) {
  if(isDefined(var_0.objweapon)) {}

  if(scripts\mp\utility\game::gamehasneutralcrateowner(scripts\mp\utility\game::getgametype())) {
    if(var_0.victim != var_0.attacker && var_0.meansofdeath == "MOD_CRUSH") {
      var_0.inflictor = var_0.victim;
      var_0.attacker = var_0.victim;
      var_0.meansofdeath = "MOD_SUICIDE";
      var_0.objweapon.basename = "none";
      var_0.hitloc = "none";
      var_0.victim.attackers = [];
    }
  }

  if(var_0.victim == var_0.attacker && var_0.meansofdeath == "MOD_CRUSH") {
    var_0.meansofdeath = "MOD_SUICIDE";
  }

  if(var_0.objweapon.basename == "none") {
    if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.baseweapon)) {
      var_0.objweapon.basename = var_0.inflictor.baseweapon;
    }
  }

  playerkilled_fixupattacker(var_0.victim, var_0);

  if(scripts\mp\utility\damage::isheadshot(var_0.hitloc, var_0.meansofdeath, var_0.attacker)) {
    var_0.meansofdeath = "MOD_HEAD_SHOT";
  }

  if(var_0.isfauxdeath) {
    var_0.dokillcam = 0;
    var_0.deathanimduration = var_0.victim playerforcedeathanim(var_0.inflictor, var_0.meansofdeath, var_0.objweapon, var_0.hitloc, var_0.direction_vec);
  }
}

function playerkilled_fixupattacker(var_0) {
  if(isDefined(level.validateattacker)) {
    var_0.attacker = [[level.validateattacker]](var_0.attacker);
  } else {
    var_0.attacker = scripts\mp\utility\damage::_validateattacker(var_0.attacker);
  }

  var_1 = 0;

  if(!isDefined(var_0.attacker)) {
    var_1 = 1;
  } else if(isDefined(var_0.attacker.classname) && (var_0.attacker.classname == "trigger_hurt" || var_0.attacker.classname == "worldspawn")) {
    var_1 = 1;
  } else if(var_0.attacker == var_0.victim) {
    var_1 = 1;
  }

  if(var_1) {
    var_2 = undefined;

    if(isDefined(var_0.victim.attackers) && self.attackers.size > 0) {
      foreach(var_4 in var_0.victim.attackers) {
        if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_4))) {
          continue;
        }

        if(!isDefined(var_0.victim.attackerdata[var_4.guid].damage)) {
          continue;
        }

        if(var_4 == var_0.victim || level.teambased && var_4.team == var_0.victim.team) {
          continue;
        }

        if(var_0.victim.attackerdata[var_4.guid].damage > 1 && !isDefined(var_2)) {
          var_2 = var_4;
          continue;
        }

        if(isDefined(var_2) && var_0.victim.attackerdata[var_4.guid].damage > var_0.victim.attackerdata[var_2.guid].damage) {
          var_2 = var_4;
        }
      }
    }

    if(!isDefined(var_2)) {
      if(isDefined(var_0.victim.debuffedbyplayers) && var_0.victim.debuffedbyplayers.size > 0) {
        var_6 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];

        foreach(var_8 in var_6) {
          var_9 = scripts\mp\gamescore::getdebuffattackersbyweapon(var_0.victim, var_8);

          if(isDefined(var_9) && var_9.size > 0) {
            for(var_10 = var_9.size - 1; var_10 >= 0; var_10--) {
              var_11 = var_9[var_10];

              if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_11))) {
                continue;
              }

              if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_11, var_0.victim))) {
                continue;
              }

              var_2 = var_11;

              if(!isDefined(var_0.victim.attackerdata) || !isDefined(var_0.victim.attackerdata[var_2.guid])) {
                addattacker(var_0.victim, var_2, undefined, getcompleteweaponname(var_8), 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
              }

              break;
            }
          }

          if(isDefined(var_2)) {
            break;
          }
        }
      }
    }

    if(isDefined(var_2)) {
      var_0.attacker = var_2;
      var_0.attacker.assistedsuicide = 1;
      var_0.objweapon = var_0.victim.attackerdata[var_2.guid].objweapon;
      var_0.direction_vec = var_0.victim.attackerdata[var_2.guid].vdir;
      var_0.hitloc = var_0.victim.attackerdata[var_2.guid].shitloc;
      var_0.psoffsettime = var_0.victim.attackerdata[var_2.guid].psoffsettime;
      var_0.meansofdeath = var_0.victim.attackerdata[var_2.guid].smeansofdeath;
      var_0.damage = var_0.victim.attackerdata[var_2.guid].damage;
      var_0.primaryweapon = var_0.victim.attackerdata[var_2.guid].sprimaryweapon;

      if(istrue(var_0.victim.ref_13749) && isDefined(var_0.victim.attackerdata[var_2.guid].inflictor)) {
        var_0.inflictor = var_0.victim.attackerdata[var_2.guid].inflictor;
      }

      var_0.assistedsuicide = 1;
    }
  }

  if(isDefined(var_0.attacker)) {
    if(isDefined(var_0.attacker.code_classname) && var_0.attacker.code_classname == "script_vehicle" && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;
    }

    if(isDefined(var_0.attacker.code_classname) && var_0.attacker.code_classname == "misc_turret" && isDefined(var_0.attacker.owner)) {
      if(isDefined(var_0.attacker.vehicle)) {
        var_0.attacker.vehicle notify("killedPlayer", var_0.victim);
      }

      var_0.attacker = var_0.attacker.owner;
    }

    if(isagent(var_0.attacker)) {
      if(isDefined(var_0.attacker.owner)) {
        var_0.attacker = var_0.attacker.owner;
      }
    }

    if(isDefined(var_0.attacker.code_classname) && var_0.attacker.code_classname == "script_model" && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;

      if(!isfriendlyfire(var_0.victim, var_0.attacker) && var_0.attacker != var_0.victim) {
        var_0.attacker notify("crushed_enemy");
      }
    }
  }

  if(isDefined(var_0.inflictor) && !isPlayer(var_0.inflictor)) {
    if(!isDefined(var_0.attacker)) {
      if(isDefined(var_0.inflictor.owner)) {
        var_0.attacker = var_0.inflictor.owner;
      }
    } else if(!isPlayer(var_0.attacker)) {
      if(isDefined(var_0.inflictor.owner)) {
        var_0.attacker = var_0.inflictor.owner;
      }
    }
  }

  if(isDefined(var_0.attacker) && var_0.attacker != var_0.victim) {
    if(isDefined(var_0.inflictor) && var_0.inflictor == var_0.victim) {
      var_0.inflictor = var_0.attacker;
    }
  }

  var_0.attacker.assistedsuicide = 0;
}

function playerkilled_precalc(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_2.perkoutlined = 0;
  var_2.deathspectatepos = undefined;
  var_2.deathtime = var_0.deathtime;
  var_2.attacker = var_1;
  var_2.lastdeathpos = var_2.origin;
  var_2.lastdeathangles = var_2 getplayerangles();

  if(!isPlayer(var_3) && isDefined(var_3.primaryweapon)) {
    var_0.primaryweapon = var_3.primaryweapon;
  } else if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon())) {
    var_0.primaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
  } else if(var_4.isalternate) {
    var_0.primaryweapon = var_4.basename;
  } else {
    var_0.primaryweapon = undefined;
  }

  var_0.lifeid = var_2.matchdatalifeindex;

  if(!isDefined(var_0.lifeid)) {
    var_0.lifeid = level.maxlives - 1;
  }

  if(scripts\mp\utility\entity::isgameparticipant(var_1)) {
    var_0.attackerentnum = var_1 getentitynumber();
  } else {
    var_0.attackerentnum = -1;
  }

  var_0.iskillstreakweapon = scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename);
  var_0.weaponfullstring = createheadicon(var_4);
  var_0.isfriendlyfire = isfriendlyfire(var_2, var_1);
  var_0.isnukekill = var_4.basename == "nuke_mp";
  var_0.enemy_monitor_trialending = scripts\mp\utility\player::unset_relic_trex(var_2);
}

function playerkilled_sharedlogic_early(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_5 = var_0.damage;
  var_6 = var_0.meansofdeath;
  var_7 = var_0.isfauxdeath;
  var_8 = var_0.hitloc;
  var_9 = var_0.direction_vec;

  if(scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_3) && isDefined(var_4) && var_4.basename == "none") {}

  var_2 notify("killed_player");
  scripts\mp\outline::outlinedisableinternalall(var_2);
  showuidamageflash(var_2);
  var_2 setblurforplayer(0, 0);
  scripts\mp\outofbounds::clearoob(var_2, 1);
  var_2 scripts\mp\equipment\molotov::ref_11cb6();
  var_2 scripts\mp\equipment\throwing_knife_mp::ref_13b52();
  var_2 scripts\cp_mp\killstreaks\nuke::ref_138db();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\utility\print::printgameaction("death", var_2);
  }

  launchshield(var_2, var_5, var_6);
  var_2 scripts\mp\riotshield::riotshield_clear();

  if(var_1 != var_2) {
    if(isDefined(var_1.petwatch)) {
      var_1 scripts\cp_mp\pet_watch::addkillcharge();

      if(var_6 == "MOD_EXECUTION") {
        var_1 scripts\cp_mp\pet_watch::addexecutioncharge();
      } else if(ref_125f6(var_2, var_6, var_3)) {
        var_1 scripts\cp_mp\pet_watch::bhasriotshieldattached();
      }
    } else if(isDefined(var_2.ref_12313)) {
      var_2 scripts\cp_mp\utility\callback_group::onplayerkilled(var_1);
    }
  }

  if(var_6 == "MOD_EXECUTION") {
    var_1 scripts\mp\utility\stats::incpersstat("executionKills", 1);

    if(isDefined(var_1.operatorcustomization.title) && var_1.operatorcustomization.title == "s4") {
      var_10 = "flavor_s4_quip";
    } else {
      var_10 = "flavor_execution";
    }

    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_2, var_10, undefined, 1);
  }

  var_11 = var_3 getcurrentweapon();

  if(!var_3 scripts\mp\utility\weapon::iskillstreakweapon(var_11)) {
    scripts\mp\weapons::savetogglescopestates();
    scripts\mp\weapons::savealtstates();
  }

  var_3 scripts\mp\equipment\nvg::savenvgstate();
  scripts\mp\utility\inventory::handleweaponchangecallbacksondeath();

  if(!var_8) {
    if(isDefined(var_3.endgame)) {
      scripts\mp\utility\player::restorebasevisionset(2);
    } else {
      scripts\mp\utility\player::restorebasevisionset(0);
      var_3 thermalvisionoff();
    }
  } else {
    var_3.fauxdead = 1;
    var_3 vehiclepinonminimap(1);
    self notify("death");
    self notify("death_or_disconnect");
  }

  scripts\mp\perks\perks::updateactiveperks(var_4, var_2, var_3, var_6, var_7, var_5, var_9, var_10);
  scripts\mp\supers::updateactivesupers(var_4, var_2, var_3, var_6, var_7, var_5, var_9, var_10);
  scripts\mp\equipment\wristrocket::wristrocketcooksuicideexplodecheck(var_4, var_2, var_3, var_7, var_5);

  if(var_7 != "MOD_HEAD_SHOT" && !var_1.isnukekill) {
    if(isDefined(level.custom_death_sound)) {
      [[level.custom_death_sound]](var_3, var_7, var_4);
    } else if(var_7 != "MOD_MELEE") {
      var_3 scripts\mp\utility\sound::playdeathsound(var_7);
    }
  }

  if(isDefined(level.custom_death_effect)) {
    [[level.custom_death_effect]](var_3, var_7, var_4);
  }

  if(var_7 != "MOD_SUICIDE" && (scripts\mp\utility\entity::isaigameparticipant(var_3) || scripts\mp\utility\entity::isaigameparticipant(var_2)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    var_12 = [[level.bot_funcs["get_attacker_ent"]]](var_2, var_4);

    if(isDefined(var_12)) {
      if(scripts\mp\utility\entity::isaigameparticipant(var_3)) {
        var_3 botmemoryevent("death", var_1.weaponfullstring, var_12.origin, var_3.origin, var_12);
      }

      if(scripts\mp\utility\entity::isaigameparticipant(var_2)) {
        var_13 = 1;

        if(isDefined(var_12.classname) && (var_12.classname == "script_vehicle" && isDefined(var_12.helitype) || var_12.classname == "rocket" || var_12.classname == "misc_turret")) {
          var_13 = 0;
        }

        if(var_13) {
          var_2 botmemoryevent("kill", var_1.weaponfullstring, var_12.origin, var_3.origin, var_3);
        }
      }
    }
  }

  if((scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "br") && scripts\mp\flags::gameflag("prematch_done") && !istrue(var_3.hvtnorevive) && istrue(var_3.inlaststand)) {
    scripts\mp\laststand::ondeath(var_1);
  }

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")) {
    if(var_7 == "MOD_FALLING" && var_3 scripts\mp\teamrevive::isvalidrevivetriggerspawnposition()) {
      var_3 scripts\mp\teamrevive::ref_13285();
    }

    var_14 = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(!var_14) {
      var_15 = var_3 scripts\mp\class::respawnitems_saveplayeritemstostruct();
    } else {
      var_15 = self.juggcontext;
    }

    var_4 scripts\mp\class::respawnitems_assignrespawnitems(var_15);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
      var_4 scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_in_gas");
      var_4 scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_not_downed");

      if(istrue(level.br_prematchstarted) && !scripts\mp\gametypes\br_public::isplayeringulag()) {
        scripts\mp\gametypes\br_analytics::destroyscorelaunchonly(self, "player_death");
      }
    }
  }

  var_16 = scripts\engine\utility::ter_op(scripts\mp\utility\killstreak::isplayerkillstreak(var_4), var_4.playerproxyagent, var_4);

  if(var_3 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
    var_16 thread scripts\mp\weapons::dropscavengerfordeath(var_3, var_2.meansofdeath);
  }

  var_16[[level.weapondropfunction]](var_3, var_8, undefined, var_7);

  if(!var_9) {
    var_4 scripts\mp\utility\player::updatesessionstate("dead");

    if(isPlayer(var_3)) {
      var_4 setclientomnvar("ui_killcam_killedby_id", var_3 getentitynumber());
    } else if(isDefined(var_3.classname) && (var_3.classname == "trigger_hurt" || var_3.classname == "worldspawn")) {
      var_4 setclientomnvar("ui_killcam_killedby_id", var_4 getentitynumber());
    } else if(isagent(var_3)) {
      if(isDefined(var_3.asm) && var_3.asm.archetype == "soldier_lw_br") {
        var_4 setclientomnvar("ui_killcam_killedby_id", -1);
      }
    }
  }

  var_17 = istrue(var_4.fauxdead) && istrue(var_4.switching_teams);

  if(!var_17) {
    if(!isDefined(level.ref_11c76) || [[level.ref_11c76]](var_4)) {
      var_4 scripts\mp\playerlogic::removefromalivecount(0, "playerKilled");
    }
  }

  if(!isDefined(var_4.switching_teams)) {
    if(!istrue(level.ignorescoring) && !var_2.isfriendlyfire) {
      var_4 scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "deaths");

      if(var_4.pers["deaths"] < 999) {
        var_4 scripts\mp\utility\stats::incpersstat("deaths", 1);
        var_4.deaths = var_4 scripts\mp\utility\stats::getpersstat("deaths");
        var_4 scripts\mp\persistence::statsetchild("round", "deaths", var_4.deaths, level.ignorekdrstats);
      }
    }
  }

  var_18 = var_8;

  if(isDefined(var_2.idflags) && var_2.idflags &level.idflags_penetration && !(var_2.idflags &level.ss_respawn)) {
    if(isDefined(var_3.bulletkillsinaframecount) && var_3.bulletkillsinaframecount == 0) {
      var_18 = "MOD_PENETRATION";

      if(isPlayer(var_3)) {
        if(var_6 hasattachment("gunperk_driller")) {
          var_19 = scripts\mp\rank::getscoreinfovalue("penetration_kill") * getdvarfloat("scr_gunperk_driller_xp_bonus", 2);
          var_3 thread scripts\mp\utility\points::sec_sys_struct_1("penetration_kill", var_19);
        } else {
          var_3 thread scripts\mp\utility\points::sec_sys_struct_1("penetration_kill");
        }
      }
    }
  } else if((var_6.basename == "semtex_xmike109_mp" || var_6.basename == "semtex_aalpha12_mp") && var_2.hitloc == "head" || var_2.hitloc == "helmet") {
    var_18 = "MOD_HEAD_SHOT";
  }

  if(isDefined(var_2.inflictor) && (istrue(var_2.inflictor.vehicle_collision_getignoreevent) || istrue(var_2.inflictor.vehicle_collision_geteventdata))) {
    var_18 = "MOD_CRUSH";
  }

  if(level.gametype == "br") {
    var_20 = [];

    if(isDefined(var_4)) {
      var_21 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_4.team, var_4.squadindex);

      if(isDefined(var_21)) {
        var_20 = var_21;
      }
    }

    if(isDefined(var_3) && isPlayer(var_3)) {
      var_22 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_3.team, var_3.squadindex);

      if(isDefined(var_22) && var_4.team != var_3.team) {
        var_20 = scripts\engine\utility::array_combine(var_22, var_20);
      }
    }

    if(var_20.size > 0) {
      var_23 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::ref_14104(var_2), "MOD_EXPLOSIVE", var_18);

      if(getdvarint("scr_br_alt_mode_zxp", 0) || getdvarint("scr_br_alt_mode_gxp", 0)) {
        var_23 = scripts\mp\gametypes\br_gametype_zxp::ref_11ba8(var_2, var_23);
      }

      obituary(var_4, var_3, var_6, var_23, var_20);
    }
  } else {
    var_24 = var_6;

    if(isDefined(var_18) && var_18 == "MOD_EXPLOSIVE" && (!isDefined(var_24) || nullweapon(var_24))) {
      var_24 = getcompleteweaponname("obit_explosive");
    }

    var_23 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::ref_14104(var_2), "MOD_EXPLOSIVE", var_18);
    obituary(var_4, var_3, var_24, var_23);
  }

  updatedeathdetails(var_4, var_4.attackers, var_4.attackerdata, var_3);
  var_4.lastbounty = scripts\mp\bounty::playergetbountypoints();
  var_4 scripts\mp\bounty::playerresetbountypoints();
  var_4 scripts\mp\bounty::playerresetbountystreak();
  var_4 thread scripts\mp\supers::handledeath();
  var_4 scripts\mp\battlechatter_mp::onplayerkilled(var_5, var_3, var_7, var_8, var_6, var_2.direction_vec, var_2.hitloc, var_2.psoffsettime, var_2.deathanimduration, var_2.lifeid);
  var_4 thread[[level.onplayerkilledcommon]](var_5, var_3, var_7, var_8, var_6, var_2.direction_vec, var_2.hitloc, var_2.psoffsettime, var_2.deathanimduration, var_2.lifeid, scripts\mp\utility\weapon::iskillstreakweapon(var_14));

  if(isai(var_4) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
    var_4 thread[[level.bot_funcs["on_killed"]]](var_5, var_3, var_7, var_8, var_2.weaponfullstring, var_2.direction_vec, var_2.hitloc, var_2.psoffsettime, var_2.deathanimduration, var_2.lifeid);
  }

  var_25 = (var_2.deathtime - var_4.spawntime) / 1000;

  if(isDefined(var_4.pers["shortestLife"])) {
    if(var_4.pers["shortestLife"] == 0 || var_25 < var_4.pers["shortestLife"]) {
      var_4.pers["shortestLife"] = var_25;
    }
  }

  if(isDefined(var_4.pers["shortestLife"])) {
    if(var_4.pers["longestLife"] == 0 || var_25 > var_4.pers["longestLife"]) {
      var_4.pers["longestLife"] = var_25;
    }
  }
}

function playerkilled_logkill(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_5 = var_0.weaponfullstring;
  var_6 = var_0.meansofdeath;
  var_7 = var_0.lifeid;
  var_2 scripts\common\utility::ref_13e0a(level.heavydamageawardlaunchonly, var_1);

  if(!istrue(level.ignorescoring)) {
    var_2 scripts\common\utility::ref_13e0a(level.ref_11b2d, var_7, var_1, var_0.damage, var_6, var_5, var_0.primaryweapon, var_0.hitloc, var_4);
  }

  var_2 scripts\mp\analyticslog::logevent_path();
  var_2 scripts\mp\analyticslog::logevent_playerdeath(var_1, var_6, var_5);

  if(isPlayer(var_1)) {
    var_1 scripts\mp\analyticslog::logevent_playerkill(var_2, var_6, var_5);
  }

  if(isPlayer(var_1) && var_1 != self && (!level.teambased || level.teambased && self.team != var_1.team)) {
    var_8 = var_2.lastdroppableweaponobj;
    var_8 = scripts\mp\utility\weapon::mapweapon(var_8, var_3);
    var_9 = createheadicon(var_8);
    thread scripts\mp\gamelogic::trackleaderboarddeathstats(var_1, var_2, var_9, var_6);
    thread scripts\mp\gamelogic::trackattackerleaderboarddeathstats(var_1, var_2, var_5, var_6);
  }

  if(isDefined(level.matchrecording_logeventmsg) && isDefined(var_3) && isPlayer(var_3) && scripts\engine\utility::isbulletdamage(var_6)) {
    var_10 = var_3.origin - var_2.origin;
    var_11 = vectorNormalize((var_10[0], var_10[1], 0));
    var_12 = anglesToForward(var_2.angles);
    var_13 = vectorNormalize((var_12[0], var_12[1], 0));
    var_14 = clamp(var_13[0] * var_11[0] + var_13[1] * var_11[1], -1, 1);
    var_15 = acos(var_14);

    if(!isDefined(var_2.ref_1338f)) {
      var_2.ref_1338f = 0;
    }

    if(var_15 > 75) {
      var_2.ref_1338f++;
    }

    var_16 = 0;

    if(isDefined(var_2.engagementstarttime)) {
      var_16 = gettime() - var_2.engagementstarttime;
    }

    if(!isDefined(var_2.nuke_hostmigration_waitlongdurationwithpause)) {
      var_2.nuke_hostmigration_waitlongdurationwithpause = 0;
      var_2.nuke_explposstruct = 0;
    }

    var_2.nuke_hostmigration_waitlongdurationwithpause += var_16;
    var_2.nuke_explposstruct++;
    var_2.engagementstarttime = undefined;
  }

  updatecombatrecordkillstats(var_1, var_2, var_6, var_4);
}

function playerkilled_finddeathtype(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.meansofdeath;

  if(isswitchingteams(var_2)) {
    return "deathType_switchingTeams";
  }

  if(!isPlayer(var_1) || isPlayer(var_1) && var_4 == "MOD_FALLING") {
    return "deathType_worldDeath";
  }

  if(var_1 == var_2 || !scripts\cp_mp\utility\player_utility::playersareenemies(var_1, var_2) && scripts\mp\utility\entity::isdronepackage(var_3)) {
    return "deathType_suicide";
  }

  if(var_0.isfriendlyfire && var_0.objweapon.basename != "bomb_site_mp" && !var_0.isnukekill) {
    return "deathType_friendlyFire";
  }

  if(istrue(var_2.inlaststand)) {
    return "deathType_inLastStand";
  }

  return "deathType_normal";
}

function playerkilled_handledeathtype(var_0) {
  var_1 = var_0.victim;
  var_0.deathtype = playerkilled_finddeathtype(var_0);

  switch (var_0.deathtype) {
    case "deathType_switchingTeams":
      handleteamchangedeath();
      break;
    case "deathType_worldDeath":
      handleworlddeath(var_0, var_0.attacker, var_0.lifeid, var_0.meansofdeath, var_0.hitloc);
      break;
    case "deathType_suicide":
      handlesuicidedeath(var_0.meansofdeath, var_0.hitloc);
      break;
    case "deathType_friendlyFire":
      handlefriendlyfiredeath(var_0.attacker, var_0.victim);
      break;
    case "deathType_inLastStand":
      handleinlaststanddeath(var_0);
      break;
    case "deathType_normal":
      handlenormaldeath(var_0.lifeid, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0.meansofdeath, var_1, var_0.iskillstreakweapon, var_0);
      break;
    default:
      break;
  }
}

function playerkilled_sharedlogic_late(var_0) {
  playerkilled_handlecorpse(var_0);
  setdeathtimerlength(var_0);
  var_1 = var_0.attacker;

  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(!isPlayer(var_1)) {
    var_0.dokillcam = 0;
    var_0.dofinalkillcam = 0;
  }

  playerkilled_killcamsetup(var_0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::branalytics_down(var_0.attacker, var_0.victim, var_0.objweapon, var_0.deathtype, var_0.meansofdeath);
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::ondeath(var_0.inflictor, var_0.attacker, var_0.damage, var_0.damageflags, var_0.meansofdeath, var_0.objweapon, var_0.hitloc, var_0.attacker.modifiers);

  if(!scripts\mp\utility\game::runleanthreadmode() || getdvarint("scr_runlean_playerthread_allow_logkill", 1)) {
    playerkilled_logkill(var_0);
  }
}

function playerkilled_handlecorpse(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.meansofdeath;
  var_5 = var_0.objweapon;
  var_2 setscriptablepartstate("watchVFXPlayer", "off");
  scripts\cp_mp\vehicles\vehicle::vehicle_playerkilledbycollision(var_0);

  if(!isDefined(self.nocorpse) && !istrue(var_2.ref_133c8)) {
    var_2.body = var_2 cloneplayer(var_0.deathanimduration, var_1);
  }

  if(!isDefined(self.nocorpse) && !istrue(var_2.ref_133c8) && isDefined(var_2.body)) {
    var_2.body.targetname = "player_corpse";

    if(var_0.isnukekill) {}

    enqueueweapononkillcorpsetablefuncs(var_1, var_2, var_3, var_5, var_4);
    thread callcorpsetablefuncs();

    if(var_0.isfauxdeath) {
      var_2 playerhide();
      var_2 setsolid(0);
    }

    if(!isDefined(var_2.switching_teams)) {
      if(isDefined(var_1) && isPlayer(var_1)) {
        thread scripts\mp\deathicons::adddeathicon(var_1, var_2.body, var_2, var_2.team, 5);
      }

      var_6 = [];

      foreach(var_8 in level.players) {
        if(isDefined(var_2) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_8, var_2)) && var_8 scripts\mp\utility\perk::_hasperk("specialty_kill_report")) {
          var_6 = var_8;
        }
      }

      if(var_6.size > 0) {
        thread scripts\mp\deathicons::addenemydeathicon(var_2.body, var_2, var_6, getdvarfloat("perk_kill_report_icon_time"), 1);
      }
    }

    thread _startragdoll(var_2, var_0.victim.body, var_0.meansofdeath);
  } else if(isDefined(var_2.nocorpse) && !istrue(var_2.ref_133c8)) {
    var_2.body = var_2 cloneplayer(var_0.deathanimduration);
    var_2.body hide(1);
  }

  if(!istrue(game["isLaunchChunk"])) {
    var_2.streaktype = scripts\mp\class::loadout_getplayerstreaktype(var_2.streaktype);

    if(scripts\mp\killstreaks\killstreaks::streaktyperesetsondeath(var_2.streaktype)) {
      if(!level.casualscorestreaks && !var_2 scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
        var_2 scripts\mp\killstreaks\killstreaks::resetstreakpoints();
        var_2 scripts\mp\killstreaks\killstreaks::resetstreakavailability();
        return;
      }

      if(level.casualscorestreaks) {
        var_10 = scripts\mp\killstreaks\killstreaks::checkcasualstreaksreset();

        if(var_10) {
          var_2 scripts\mp\killstreaks\killstreaks::resetstreakpoints();
          var_2 scripts\mp\killstreaks\killstreaks::resetstreakavailability();
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function _startragdoll(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 endon("death");

  if(getdvarint("NOONKKQQT", 0) && isDefined(var_1) && (var_1 == "MOD_GRENADE" || var_1 == "MOD_EXPLOSIVE" || var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_PROJECTILE_SPLASH")) {
    var_0 method_87c0(1);
  }

  var_3 = var_0 getcorpseanim();
  var_4 = 0;

  if(animisleaf(var_3)) {
    var_4 = getanimlength(var_3);
  }

  var_5 = undefined;
  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();
  var_7 = ref_125f6(var_1, var_2);
  var_8 = undefined;
  var_9 = animhasnotetrack(var_3, "delete_corpse");
  var_10 = animhasnotetrack(var_3, "delete_corpse_delayed");
  var_11 = animhasnotetrack(var_3, "no_ragdoll");
  var_12 = animhasnotetrack(var_3, "start_ragdoll");

  if(isDefined(var_6)) {
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_6, self);

    if(var_11 || var_12) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(var_0, var_6, var_8);
      var_0 setcorpsefalling(0);
      var_0.x1ops = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e7(var_6, var_8);
    }

    if(var_9 || var_10 || var_11 || var_12) {
      var_13 = scripts\engine\utility::ter_op(var_11 || var_12, 0, 1);
      var_14 = scripts\engine\utility::ter_op(var_10, var_4, var_4 + 3);
      thread playerkilled_deletecorpseoutofvehicle(var_0, var_6, var_8, var_14, var_13);
    }
  }

  if(var_1 != "mod_execution" && !var_11) {
    var_5 = 0;

    if(var_12 && var_4 > 0) {
      var_15 = getnotetracktimes(var_3, "start_ragdoll")[0];
      var_5 = var_15 * var_4;
    }

    if(var_7) {
      var_5 = 0;
    }
  }

  if(isDefined(var_5)) {
    wait var_5;

    if(!isDefined(var_0)) {
      return;
    }

    if(isDefined(var_6)) {
      thread any_rider_still_alive_at_seat(var_0, var_6, var_8, var_9, var_10, var_5);
      var_0 notify("cancel_delete_corpse");
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141cc(var_0, var_6, var_8);
      return;
    }

    if(!var_0 isragdoll()) {
      if(var_7) {
        var_0 vehswitchseatbuttonPressed(var_2);
      } else {
        var_0 startragdoll();
      }
    }

    thread adson(var_0, var_9, var_10, var_5);
    return;
  }
}

function adson(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(var_0 || var_1) {
    var_5 = var_3;

    if(var_1) {
      var_3 += 3;
    }

    if(isDefined(var_2)) {
      var_5 -= var_2;
    }

    wait var_5;

    if(!isDefined(var_4)) {
      return;
    }

    var_4 delete();
    return;
  }

  if(!scripts\mp\utility\game::isteamreviveenabled() && !isagent(self)) {
    var_4 setplayercorpsedone();
    return;
  }
}

function any_rider_still_alive_at_seat(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = getdvarint("scr_ragdollBeforeUnlink", 1);
  var_8 = !var_7;
  var_9 = getdvarint("scr_ragdollImmediate", 1);

  if(var_7) {
    if(!var_6 isragdoll()) {
      var_6 startragdoll(var_9);
    }
  }

  var_10 = getdvarfloat("scr_ragdollUnlinkWait", 0.1);

  if(var_10 > 0) {
    wait var_10;
  }

  if(isDefined(var_6)) {
    if(isDefined(var_6.x1ops) && isDefined(var_0)) {
      var_11 = (0, 0, 0);
      var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e7(var_0, var_1);
      var_11 = var_12.origin - var_6.x1ops.origin;
      var_13 = var_6.origin + var_11;
      var_14 = var_12.angles;
      var_6 getcovertacpoint(var_13, var_14);
    }

    var_6 unlink();

    if(var_8) {
      var_6 startragdoll(var_9);
    }

    thread adson(var_6, var_2, var_3, var_4);
    return;
  }
}

function anim_offset(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 endon("death");
  var_3 = var_0 getcorpseanim();
  var_4 = undefined;
  var_5 = getanimlength(var_3);
  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();
  var_7 = var_1 == "MOD_CRUSH" && isDefined(var_2) && isDefined(var_2.vehiclename);

  if(!var_7) {
    var_8 = animhasnotetrack(var_3, "delete_corpse");
    var_9 = animhasnotetrack(var_3, "delete_corpse_delayed");
    var_10 = animhasnotetrack(var_3, "no_ragdoll");
  } else {
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
  }

  if(isDefined(var_9)) {
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_9, self);

    if(var_10) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(var_3, var_9, var_11);
    }

    if(var_8 || var_9) {
      var_12 = scripts\engine\utility::ter_op(var_9, var_8, var_8 + 3);
      thread playerkilled_deletecorpseoutofvehicle(var_3, var_9, var_11, var_12);
    }
  }

  if(var_4 != "mod_execution" && !var_10) {
    var_7 = 0;

    if(animhasnotetrack(var_6, "start_ragdoll")) {
      var_13 = getnotetracktimes(var_6, "start_ragdoll")[0];
      var_7 = var_13 * var_8;
    }
  }

  if(var_10) {
    var_7 = 0;
  }

  if(isDefined(var_7)) {
    if(var_7 > 0) {
      wait var_7;
    }

    if(!var_3 isragdoll()) {
      if(!var_10) {
        var_3 startragdoll();
      } else {
        var_3 vehswitchseatbuttonPressed(var_5);
      }
    }
  }

  if(var_8 || var_9) {
    if(!var_10) {
      var_14 = var_8;

      if(var_9) {
        var_8 += 3;
      }

      if(isDefined(var_7)) {
        var_14 -= var_7;
      }

      wait var_14;
    }

    var_3 delete();
    return;
  }

  if(!scripts\mp\utility\game::isteamreviveenabled()) {
    var_3 setplayercorpsedone();
    return;
  }
}

function playerkilled_deletecorpseoutofvehicle(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("cancel_delete_corpse");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_assignseatcorpse(var_0, var_1, var_2, var_4);
  var_1 scripts\engine\utility::ref_143b9(var_3, "death");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function ref_125f6(var_0, var_1) {
  if(var_0 != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(!var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return false;
  }

  return true;
}

function playerkilled_killcamsetup(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.meansofdeath;
  var_5 = var_0.objweapon;
  var_6 = var_0.executionref;

  if(var_0.attacker.assistedsuicide || level.teambased && isDefined(var_1.team) && var_1.team == var_2.team) {
    var_0.dokillcam = 0;
    var_0.dofinalkillcam = 0;
  }

  if(!isDefined(var_0.killcamentity)) {
    var_0.killcamentity = var_2 scripts\mp\killcam::getkillcamentity(var_1, var_3, var_5, var_4);
  }

  if(isDefined(var_0.killcamentity)) {
    var_0.killcamentityindex = var_0.killcamentity getentitynumber();
    var_0.killcamentitystarttime = var_0.killcamentity.birthtime;

    if(!isDefined(var_0.killcamentitystarttime)) {
      var_0.killcamentitystarttime = 0;
    }
  }

  if(var_0.dokillcam) {
    var_2 scripts\mp\killcam::prekillcamnotify(var_1);

    if(isDefined(var_3) && isagent(var_3)) {
      var_0.inflictoragentinfo = spawnStruct();
      var_0.inflictoragentinfo.agent_type = var_3.agent_type;
      var_0.inflictoragentinfo.lastspawntime = var_3.lastspawntime;
    }
  }

  var_0.killcamentstickstovictim = var_4 == "MOD_IMPACT" || var_4 == "MOD_HEAD_SHOT" && isDefined(var_3) || var_4 == "MOD_GRENADE" || isDefined(var_2) && isDefined(var_2.stuckbygrenade) && isDefined(var_3) && var_2.stuckbygrenade == var_3 || var_5.basename == "throwingknifec4_mp";

  if(!var_0.iskillstreakweapon) {
    scripts\mp\killcam::setkillcamnormalweaponomnvars(var_5, var_4, var_3, var_6);
  }

  if(level.recordfinalkillcam && var_0.dofinalkillcam) {
    if((!isDefined(level.disable_killcam) || !level.disable_killcam) && var_4 != "MOD_SUICIDE" && !(!isDefined(var_1) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2)) {
      scripts\mp\final_killcam::recordfinalkillcam(5, var_2, var_1, var_0.attackerentnum, var_3, var_0.killcamentityindex, var_0.killcamentitystarttime, var_0.killcamentstickstovictim, var_5, var_0.psoffsettime, var_4);
    }
  }
}

function playerkilled_deathscene(var_0) {
  var_1 = var_0.victim;
  var_1 endon("spawned");

  if(!var_0.isfauxdeath) {
    if(!isDefined(var_1.respawntimerstarttime)) {
      var_1.respawntimerstarttime = gettime() + var_0.deathscenetimems;
    }

    wait var_0.deathscenetimesec;

    if(var_0.dokillcam) {
      var_0.dokillcam = !scripts\mp\final_killcam::skipkillcamduringdeathtimer(0.5);
    }

    var_1 notify("death_delay_finished");
    return;
  }

  if(!isDefined(var_1.respawntimerstarttime)) {
    var_1.respawntimerstarttime = gettime();
    return;
  }
}

function playerkilled_killcam(var_0) {
  var_1 = var_0;
  var_2 = var_1.victim.deathtime;

  if(getdvarint("scr_killcam_on_down", 1) && isDefined(var_1.victim.watch_for_driver_spawned)) {
    var_1 = var_1.victim.watch_for_driver_spawned;
    var_1.victim.watch_for_driver_spawned = undefined;
    var_1.dokillcam = var_0.dokillcam;
    var_2 = var_1.deathtime;
  }

  var_1.victim endon("spawned");
  var_3 = var_1.victim;
  var_4 = var_1.attacker;
  var_5 = (gettime() - var_2) / 1000;

  if(isDefined(level.ref_11c8b)) {
    [[level.ref_11c8b]](var_1);
  }

  if(!(isDefined(var_3.cancelkillcam) && var_3.cancelkillcam) && var_1.dokillcam && level.killcam && game["state"] == "playing" && !var_3 scripts\mp\utility\player::isusingremote() && !level.showingfinalkillcam) {
    var_6 = scripts\mp\playerlogic::timeuntilspawn(1);

    if(!isDefined(var_4) || !isDefined(var_4.pers)) {
      var_7 = [];
    } else {
      var_7 = var_5.pers["loadoutPerks"];
    }

    if(!istrue(level.disablecopycatloadout)) {
      thread startcopycatoption(var_4);
    }

    var_8 = 1;
    var_4 scripts\mp\killcam::killcam(var_2.inflictor, var_2.inflictoragentinfo, var_2.attackerentnum, var_2.killcamentityindex, var_2.killcamentitystarttime, undefined, var_2.killcamentstickstovictim, var_2.objweapon, var_6, var_2.psoffsettime, var_7, scripts\mp\gamelogic::timeuntilroundend(), var_5, var_4, var_2.meansofdeath, var_7, var_8);

    if(!istrue(level.disablecopycatloadout)) {
      thread stopcopycatoption();
    }

    if(isDefined(level.ref_12075)) {
      [[level.ref_12075]]();
      return;
    }

    return;
  }
}

function playerkilled_spawn(var_0) {
  if(isDefined(level.ref_11c7a) && [[level.ref_11c7a]](var_0, 1)) {
    return;
  }

  var_1 = var_0.victim;
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_2 = var_0.attacker;
  resetplayervariables(var_1);
  resetplayeromnvarsonspawn(var_1);

  if(isDefined(var_2)) {
    var_1.lastattacker = var_2;
  } else {
    var_1.lastattacker = undefined;
  }

  var_1.wantsafespawn = 0;

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      var_1 scripts\mp\utility\player::updatesessionstate("dead");
      var_1 scripts\mp\utility\player::clearkillcamstate();
    }

    return;
  }

  if(scripts\mp\class::isvalidclass(var_1.class)) {
    var_1 thread scripts\mp\playerlogic::spawnclient();
    return;
  }
}

function playerkilled_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_2 endon("spawned");

  if(game["state"] == "postgame") {
    return;
  }

  var_12 = playerkilled_initdeathdata(var_2, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  playerkilled_parameterfixup(var_12);
  playerkilled_precalc(var_12);
  playerkilled_sharedlogic_early(var_12);
  playerkilled_handledeathtype(var_12);
  playerkilled_sharedlogic_late(var_12);
  playerkilled_deathscene(var_12);
  playerkilled_killcam(var_12);
  playerkilled_spawn(var_12);
}

function isswitchingteams() {
  if(isDefined(self.switching_teams)) {
    return true;
  }

  return false;
}

function isteamswitchbalanced() {
  var_0 = scripts\mp\teams::countplayers();
  GscBinSkip0(0x2e, self.leaving_team);
}

function isfriendlyfire(var_0, var_1) {
  if(!level.teambased) {
    return false;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return false;
  }

  if(var_0.team != var_1.team) {
    return false;
  }

  if(var_0 == var_1) {
    return false;
  }

  return true;
}

function killedself(var_0) {
  if(!isPlayer(var_0)) {
    return false;
  }

  if(var_0 != self) {
    return false;
  }

  return true;
}

function handleteamchangedeath() {
  if(!level.teambased) {
    return;
  }

  if(self.joining_team == "spectator" || !isteamswitchbalanced()) {
    scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
    scripts\mp\utility\stats::incpersstat("suicides", 1);
  }

  if(isDefined(level.onteamchangedeath)) {
    [[level.onteamchangedeath]](self);
    return;
  }
}

function handleworlddeath(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.victim;
  var_5.deathspectatepos = var_5.origin;

  if(!isDefined(var_1)) {
    return;
  }

  scripts\mp\events::playerworlddeath(var_1, var_3);

  if(!isDefined(var_1.team) || var_1.team == "neutral") {
    handlesuicidedeath(var_3, var_4);
    return;
  }

  if(level.teambased && var_1.team != self.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(var_1) || isagent(var_1)) && var_1.team != "spectator") {
      if(!level.gameended) {
        [[level.onnormaldeath]](self, var_1, var_2, var_3);
      }
    }
  }

  if(isagent(var_1)) {
    var_0.dokillcam = 1;
    return;
  }
}

function handlesuicidedeath(var_0, var_1) {
  scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
  scripts\mp\utility\stats::incpersstat("suicides", 1);
  var_2 = scripts\mp\tweakables::gettweakablevalue("game", "suicidepointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_2);

  if(scripts\mp\weapons::grenadeheldatdeath() && var_0 == "MOD_SUICIDE" && var_1 == "none") {
    self.lastgrenadesuicidetime = gettime();
  }

  if(isDefined(level.onsuicidedeath)) {
    [[level.onsuicidedeath]](self);
  }

  self.suicidespawndelay = 1;

  if(isDefined(self.friendlydamage)) {
    self.playersetarenaomnvarwithloadout = 1;
    return;
  }
}

function handlefriendlyfiredeath(var_0, var_1) {
  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")) {
    level thread scripts\mp\teamrevive::spawnrevivetrigger(var_1, var_1, "new_trigger_spawned", "MOD_SUICIDE");
  }

  var_0 thread scripts\mp\rank::scoreeventpopup("teamkill");
  var_0.pers["teamkills"] = var_0.pers["teamkills"] + 1;

  if(scripts\mp\tweakables::gettweakablevalue("team", "teamkillpointloss")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("kill");
    scripts\mp\gamescore::_setplayerscore(var_0, scripts\mp\gamescore::_getplayerscore(var_0) - var_2);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }

  var_3 = var_0 scripts\mp\playerlogic::teamkilldelay();

  if(var_3 > 0) {
    var_0.pers["teamKillPunish"] = 1;
    var_0 notify("team_kill_punish");

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      var_0 thread scripts\mp\utility\damage::ref_13966();
    } else {
      var_0 thread scripts\mp\utility\damage::ref_13965();
    }
  }

  if(level.friendlyfire == 4 && !istrue(var_0.hitfflimit) && var_0.pers["teamkills"] >= level.maxallowedteamkills) {
    var_0.hitfflimit = 1;
    var_0 scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_PUNISH_SWITCH");
    return;
  }
}

function handleinlaststanddeath(var_0) {
  var_1 = scripts\mp\utility\game::getgametype() == "br";

  if(!istrue(var_0.victim.disable_killcam)) {
    var_0.dokillcam = 1;
  }

  if(!var_0.iskillstreakweapon) {
    var_0.attacker thread scripts\mp\utility\points::giveunifiedpoints("last_stand_kill", var_0.objweapon, undefined, undefined, var_0.victim);
  }

  if(isDefined(self.watch_for_attack)) {
    ref_125e3(self.watch_for_attack);
  }

  if(isDefined(self.watch_for_attack) && var_0.attacker != self.watch_for_attack) {
    thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkilled(self.watch_for_attack, self.watch_for_attack, 0, var_0.damageflags, self.watch_for_level_weapons_free, self.watch_for_player_enter_puddle_trigger, var_0.hitloc, self.watch_for_damage, self.watch_for_damage_on_trap, self.watch_for_damage_on_turret);
    self.watch_for_attack thread scripts\mp\rank::scoreeventpopup("kill_confirmed");
  }

  if(var_1) {
    handlenormaldeath(var_0.lifeid, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0.meansofdeath, self, var_0.iskillstreakweapon, var_0, 1);
  }

  self.watch_for_attack = undefined;
  self.watch_for_level_weapons_free = undefined;
  self.watch_for_player_enter_puddle_trigger = undefined;
  self.watch_for_damage = undefined;
  self.watch_for_damage_on_trap = undefined;
  self.watch_for_damage_on_turret = undefined;
}

function handlenormaldeath_sounds(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = var_1;

  if(!isDefined(var_0.lastkillalertsoundtime)) {
    var_0.lastkillalertsoundtime = gettime();
    var_4 = 1;
  } else if(gettime() > var_0.lastkillalertsoundtime + 700) {
    var_0.lastkillalertsoundtime = gettime();
    var_4 = 1;
  }

  if(!scripts\engine\utility::isbulletdamage(var_2) || var_0 != var_3) {
    if(var_4 && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_5 playsoundtoplayer("mp_kill_alert_quiet", var_0);
    }
  } else if(var_2 == "MOD_HEAD_SHOT") {
    var_5 playsoundtoplayer("bullet_impact_headshot_plr", var_1);
    var_5 playsoundtoplayer("bullet_impact_headshot", var_0);

    if(var_4) {
      var_5 playsoundtoplayer("mp_headshot_alert", var_0);
    }

    var_5 playsoundtoteam("bullet_impact_headshot_npc", var_1.team, var_1);
    var_5 playsoundtoteam("bullet_impact_headshot_npc", var_0.team, var_0);
  } else {
    var_5 playsoundtoteam("mp_hit_alert_final_npc", var_1.team);
    var_5 playsoundtoteam("mp_hit_alert_final_npc", var_0.team, var_0);

    if(var_4) {
      var_5 playsoundtoplayer("mp_kill_alert", var_0);
    }
  }

  if(isPlayer(var_1)) {
    if(var_2 != "MOD_EXECUTION") {
      var_1 playlocalsound("deaths_door_death");
    }

    var_1 clearsoundsubmix("deaths_door_mp", 2);
    return;
  }
}

function handlenormaldeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(var_4 == "MOD_GRENADE" && var_2 == var_1) {
    addattacker(var_5, var_1, var_2, var_3, var_7.damage, (0, 0, 0), var_7.direction_vec, var_7.hitloc, var_7.psoffsettime, var_4);
  }

  var_7.dokillcam = 1;

  if(isai(var_5) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
    var_7.dokillcam = var_5[[level.bot_funcs["should_do_killcam"]]]();
  }

  if(istrue(level.disable_killcam) || istrue(var_5.disable_killcam)) {
    var_7.dokillcam = 0;
  }

  var_1 thread scripts\mp\events::killedplayer(var_0, self, var_3, var_4, var_2, var_7);
  scripts\mp\gametypes\br_alt_mode_ff::play_airport_success_vo(var_1);
  scripts\mp\gametypes\br_gametype_respect::ref_12cba(var_1);

  if(!istrue(level.disablestattracking)) {
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_1.modifiers)) {
      var_9 = var_1.modifiers["mask"];
      var_10 = var_1.modifiers["mask2"];
      var_11 = var_1.modifiers["mask3"];
    }

    var_5 thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkilled(var_2, var_1, var_7.damage, var_7.damageflags, var_4, var_3, var_7.hitloc, var_9, var_10, var_11);
    var_5.watch_for_driver_death = undefined;
    var_5.pers["cur_death_streak"]++;

    if(var_4 == "MOD_HEAD_SHOT") {
      var_1 scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "headshots");
      var_1 scripts\mp\utility\stats::incpersstat("headshots", 1);
      var_1.headshots = var_1 scripts\mp\utility\stats::getpersstat("headshots");

      switch (weaponclass(var_3.basename)) {
        case "rifle":
          var_1 scripts\mp\utility\stats::incpersstat("arHeadshots", 1);
          break;
        case "smg":
          var_1 scripts\mp\utility\stats::incpersstat("smgHeadshots", 1);
          break;
        case "spread":
          var_1 scripts\mp\utility\stats::incpersstat("shotgunHeadshots", 1);
          break;
        case "mg":
          var_1 scripts\mp\utility\stats::incpersstat("lmgHeadshots", 1);
          break;
        case "sniper":
          var_1 scripts\mp\utility\stats::incpersstat("sniperHeadshots", 1);
          break;
        case "rocketlauncher":
          var_1 scripts\mp\utility\stats::incpersstat("launcherHeadshots", 1);
          break;
        case "pistol":
          var_1 scripts\mp\utility\stats::incpersstat("pistolHeadshots", 1);
          break;
      }
    }

    if(isDefined(var_2) && istrue(var_2.isequipment)) {
      switch (var_2.equipmentref) {
        case "equip_frag":
          var_1 scripts\mp\utility\stats::incpersstat("fragKills", 1);
          break;
        case "equip_semtex":
          var_1 scripts\mp\utility\stats::incpersstat("semtexKills", 1);
          break;
        case "equip_molotov":
          var_1 scripts\mp\utility\stats::incpersstat("molotovKills", 1);
          break;
        case "equip_claymore":
          var_1 scripts\mp\utility\stats::incpersstat("claymoreKills", 1);
          break;
        case "equip_throwing_knife_drill":
        case "equip_throwing_knife_electric":
        case "equip_throwing_knife_fire":
        case "equip_throwing_knife":
          var_1 scripts\mp\utility\stats::incpersstat("throwingKnifeKills", 1);
          var_1 scripts\cp_mp\pet_watch::begin_vo();
          break;
        case "equip_c4":
          var_1 scripts\mp\utility\stats::incpersstat("c4Kills", 1);
          break;
        case "equip_thermite":
          var_1 scripts\mp\utility\stats::incpersstat("thermiteKills", 1);
          break;
        case "equip_at_mine":
          var_1 scripts\mp\utility\stats::incpersstat("proximityMineKills", 1);
          break;
      }
    }
  }

  thread handlenormaldeath_sounds(var_1, var_5, var_4, var_2);
  var_12 = var_1;

  if(isDefined(var_1.commanding_bot)) {
    var_12 = var_1.commanding_bot;
  }

  if(!istrue(var_8) && !isfriendlyfire(var_5, var_1)) {
    if(!istrue(level.ignorescoring)) {
      ref_125e3(var_12);

      if(isbehindmeleevictim(var_12, var_5)) {
        var_12 scripts\mp\utility\stats::incpersstat("killsFromBehind", 1);
        var_5 scripts\mp\utility\stats::incpersstat("deathsFromBehind", 1);
      }
    } else if(isDefined(level.prematchaddkillfunc)) {
      var_12[[level.prematchaddkillfunc]]();
    }
  }

  if(!istrue(level.disablestattracking)) {
    self resetplayerconsecutivekills();

    if(isPlayer(var_1)) {
      var_1 increaseplayerconsecutivekills();
    }
  }

  if(!istrue(var_12.pers["ignoreWeaponMatchBonus"]) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_3) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_3))) {
    if(!isDefined(var_12.pers["weaponMatchBonusKills"])) {
      var_12.pers["weaponMatchBonusKills"] = 1;
    } else {
      var_12.pers["weaponMatchBonusKills"]++;
    }

    if(var_12.pers["weaponMatchBonusKills"] > scripts\mp\weaponrank::reload_use_think()) {
      var_12.pers["ignoreWeaponMatchBonus"] = 1;
      var_12.pers["weaponMatchBonusKills"] = undefined;
      var_12.pers["killsPerWeapon"] = undefined;
    } else {
      if(!isDefined(var_12.pers["killsPerWeapon"])) {
        var_12.pers["killsPerWeapon"] = [];
      }

      var_13 = scripts\mp\utility\weapon::getweaponrootname(var_3);
      var_14 = 0;

      foreach(var_16 in var_12.pers["killsPerWeapon"]) {
        if(var_17 == var_13) {
          var_16.killcount++;
          var_14 = 1;
          break;
        }
      }

      if(!var_14) {
        var_16 = spawnStruct();
        var_16.killcount = 1;
        var_16.basename = var_3.basename;
        var_16.ref_1213c = var_12.pers["killsPerWeapon"].size;
        var_12.pers["killsPerWeapon"][var_13] = var_16;
      }
    }
  }

  var_18 = var_1.pers["cur_kill_streak"];

  if(!istrue(level.ignorescoring) && (isalive(var_1) || isDefined(var_1.streaktype) && var_1.streaktype == "support")) {
    if(var_4 == "MOD_MELEE" && !var_1 scripts\mp\utility\killstreak::isjuggernaut() || var_1 scripts\mp\utility\killstreak::killshouldaddtokillstreak(var_3)) {
      registerkill(var_1, var_3, var_4, 1, var_6);
    }

    if(var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility\stats::getpersstat("longestStreak")) {
      var_1.pers["longestStreak"] = var_1.pers["cur_kill_streak"];
    }
  }

  var_1.pers["cur_death_streak"] = 0;

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    if(!istrue(level.ignorescoring) && var_1.pers["cur_kill_streak"] > var_1 scripts\mp\persistence::statgetchild("round", "killStreak")) {
      var_1 scripts\mp\persistence::statsetchild("round", "killStreak", var_1.pers["cur_kill_streak"]);
    }

    if(!istrue(level.ignorescoring) && var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      if(var_1.pers["cur_kill_streak"] > var_1.bestlifetimekillstreak) {
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_1.pers["cur_kill_streak"], "bestStats", "killStreak");
        var_1.bestlifetimekillstreak = var_1.pers["cur_kill_streak"];
      }
    }
  }

  if(!var_6 && !scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_2) || scripts\mp\utility\points::unset_relic_doomslayer(var_3)) {
    var_1 thread scripts\mp\events::killeventtextpopup("kill", 0);
    var_19 = undefined;

    if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done")) {
      var_19 = 100;
    }

    var_1 thread scripts\mp\utility\points::giveunifiedpoints("kill", var_3, var_19, undefined, var_5);
    var_1 scripts\mp\bounty::bountyincreasestreak();
    var_1 scripts\mp\bounty::bountycollect(var_5.lastbounty, var_5.origin);

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_hardline") && isDefined(var_1.hardlineactive) && var_1.hardlineactive["assists"] == 2) {
      var_1 thread scripts\mp\utility\points::givestreakpointswithtext("assist_hardline", var_3, 1);
    }
  }

  var_20 = scripts\mp\tweakables::gettweakablevalue("game", "deathpointloss");

  if(var_1.currentweapon hasattachment("gunperk_frenzy")) {
    var_1 notify("begin_regeneration");
  }

  if(isDefined(level.gunshipplayer) && level.gunshipplayer == var_1) {
    level notify("ai_killed", self);
  }

  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_20);
  level notify("player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_1);
  var_1 notify("killed_enemy");

  if(istrue(var_1.inlaststand)) {
    var_1 thread scripts\mp\laststand::ref_1204f(var_7);
  }

  if(isDefined(level.onnormaldeath) && isDefined(var_1.pers) && var_1.pers["team"] != "spectator" && !istrue(level.ignorescoring)) {
    [[level.onnormaldeath]](self, var_1, var_0, var_4, var_3, var_6);
  }

  if(!var_1 scripts\mp\utility\player::isusingremote()) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, "killfirm_infantry", undefined, 0.75);
  }

  var_21 = undefined;

  switch (var_5.loadoutarchetype) {
    case "archetype_assault":
      var_21 = "plr_killfirm_warfighter";
      break;
  }

  if(isDefined(var_21)) {
    level thread scripts\mp\battlechatter_mp::saytoself(var_1, var_21, "plr_killfirm_generic", 0.75);
  }

  if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != var_1) {
    if(gettime() - self.lastattackedshieldtime < 2500) {
      self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
    } else if(isalive(self.lastattackedshieldplayer) && gettime() - self.lastattackedshieldtime < 5000) {
      var_22 = vectorNormalize(anglesToForward(self.angles));
      var_23 = vectorNormalize(self.lastattackedshieldplayer.origin - self.origin);

      if(vectordot(var_23, var_22) > 0.925) {
        self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
      }
    }
  }

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\gamescore::awardbuffdebuffassists(var_1, self);
  }

  if(isDefined(self.attackers)) {
    foreach(var_25 in self.attackers) {
      if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_25))) {
        continue;
      }

      if(var_25 == var_1) {
        continue;
      }

      if(self == var_25) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      if(isDefined(self.watch_for_attack) && self.watch_for_attack == var_25) {
        continue;
      }

      var_26 = undefined;

      if(isDefined(self.attackerdata)) {
        var_27 = self.attackerdata[var_25.guid];

        if(isDefined(var_27)) {
          var_26 = var_27.objweapon;
        }
      }

      var_28 = 0;

      if(self.attackerdata[var_25.guid].damage >= 35) {
        var_28 = 1;
      }

      if(self.attackerdata[var_25.guid].damage >= 70) {
        var_28 = 2;
      }

      var_25 thread scripts\mp\gamescore::processassist(self, var_26, var_28);

      if(var_25 scripts\mp\utility\perk::_hasperk("specialty_boom")) {
        var_5 thread scripts\mp\perks\perkfunctions::setboominternal(var_25);
      }
    }
  }

  if(isDefined(self.markedbyboomperk)) {
    foreach(var_25 in level.players) {
      if(var_25.team == self.team) {
        continue;
      }

      if(scripts\engine\utility::array_contains(self.attackers, var_25)) {
        continue;
      }

      if(scripts\engine\utility::array_contains_key(self.markedbyboomperk, var_25 scripts\mp\utility\player::getuniqueid())) {
        var_25 thread scripts\mp\gamescore::processassist(self, var_3);
      }
    }
  }

  if(level.teambased) {
    var_32 = undefined;
    var_33 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
      var_33 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    }

    if(istrue(var_33) && getdvarint("scr_uav_for_squad_only", 1) && isDefined(var_1.squadindex) && isDefined(var_1.team)) {
      var_32 = var_1.team + var_1.squadindex;
    } else if(isDefined(var_1.team)) {
      var_32 = var_1.team;
    }

    if(isDefined(var_32) && isDefined(level.uavmodels) && isDefined(level.uavmodels[var_32]) && level.uavmodels[var_32].size > 0) {
      var_34 = [];

      foreach(var_36 in level.uavmodels[var_32]) {
        if(isDefined(var_36) && isDefined(var_36.owner) && var_36.owner != var_1 && !scripts\engine\utility::array_contains(var_34, var_36.uavtype)) {
          var_37 = var_36.uavtype + "_assist";
          var_38 = undefined;

          if(!isDefined(var_36.carpunchcount)) {
            var_36.carpunchcount = 0;
          }

          var_39 = scripts\engine\utility::ter_op(var_36.uavtype == "directional_uav", 15, 10);

          if(var_36.carpunchcount < var_39) {
            var_36.owner thread scripts\mp\utility\points::giveunifiedpoints(var_37, undefined, var_38, undefined, undefined, undefined, var_36.streakinfo);
          } else {
            var_36.owner thread scripts\mp\utility\points::sec_sys_struct_1(var_37, var_38);
          }

          var_36.carpunchcount++;

          switch (var_36.uavtype) {
            case "uav":
              var_36.owner scripts\mp\utility\stats::incpersstat("killstreakUAVAssists", 1);
              break;
            case "directional_uav":
              var_36.owner scripts\mp\utility\stats::incpersstat("killstreakAUAVAssists", 1);
              break;
          }

          var_34 = var_36.uavtype;
          scripts\cp\vehicles\vehicle_compass_cp::processuavassist(var_36.owner, var_36.uavtype);
          var_36.owner scripts\mp\utility\script::bufferednotify("update_uav_assist_buffered");
          combatrecordkillstreakstat(var_36.owner, var_36.uavtype);
        }
      }
    }

    if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
      foreach(var_42 in level.supportdrones) {
        if(level.teambased && var_42.team == var_1.team && var_42.owner != var_1) {
          if(isDefined(var_42.enemiesmarked) && isDefined(var_42.enemiesmarked[self getentitynumber()])) {
            var_42.owner thread scripts\mp\utility\points::giveunifiedpoints(var_42.streakinfo.streakname + "_assist");
            var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_1207c();
          }
        }

        if(var_42.helperdronetype == "scrambler_drone_guard") {
          if(var_1 != var_42.owner) {
            var_37 = var_42.streakinfo.streakname + "_assist";

            if(!isDefined(var_42.carpunchcount)) {
              var_42.carpunchcount = 0;
            }

            if(var_42.carpunchcount < 10) {
              var_42.owner thread scripts\mp\utility\points::giveunifiedpoints(var_37, undefined, undefined, undefined, undefined, undefined, var_42.streakinfo);
            } else {
              var_42.owner thread scripts\mp\utility\points::sec_sys_struct_1(var_37);
            }

            var_42.carpunchcount++;
            var_42.owner scripts\mp\utility\stats::incpersstat("killstreakCUAVAssists", 1);
            continue;
          }

          if(isDefined(var_42.owner) && var_1 == var_42.owner) {
            if(!istrue(var_1.ref_12c3d)) {
              var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_kill_scrambled_enemies_s1", 1);
              continue;
            }

            var_1.ref_12c3d = undefined;
          }
        }
      }
    }

    _debug_rooftop_activesat::close_teleport_room_door(var_1, self);

    if(isDefined(var_1.team) && isDefined(level.activewpzones) && level.activewpzones.size > 0) {
      var_44 = level.activewpzones[0];
      var_45 = var_44.owner;
      var_46 = var_44.team;

      if(var_1.team == var_46 && var_1 != var_45) {
        if(istrue(var_5.wpdisorient) || istrue(var_5.wpburning)) {
          var_37 = "white_phosphorus_assist";

          if(!isDefined(var_44.carpunchcount)) {
            var_44.carpunchcount = 0;
          }

          if(var_44.carpunchcount < 15) {
            var_45 thread scripts\mp\utility\points::giveunifiedpoints(var_37, undefined, undefined, undefined, undefined, undefined, var_44.streakinfo);
          } else {
            var_45 thread scripts\mp\utility\points::sec_sys_struct_1(var_37);
          }

          var_44.carpunchcount++;
          var_45 scripts\mp\utility\stats::incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        }
      }
    }
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_killed_player", self getentitynumber());
    var_1 setclientomnvar("ui_killed_player_notify", gettime());
  }
}

function ref_125e3() {
  var_0 = self;
  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "kills");

  if(var_0.pers["kills"] < 14999) {
    var_0 scripts\mp\utility\stats::incpersstat("kills", 1);
    var_0.kills = var_0 scripts\mp\utility\stats::getpersstat("kills");
    var_0 scripts\mp\persistence::statsetchild("round", "kills", var_0.kills, level.ignorekdrstats);
    return;
  }
}

function callback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0);
}

function launchshield(var_0, var_1) {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel)) {
      scripts\mp\riotshield::riotshield_detach(1);
    }

    if(isDefined(self.riotshieldmodelstowed)) {
      scripts\mp\riotshield::riotshield_detach(0);
      return;
    }

    return;
  }
}

function resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.watch_for_driver_death = undefined;
  self.pers["cur_kill_streak"] = 0;
  self.killcountthislife = 0;
  self.intel_guys = 0;
  self.ref_11bc2 = 0;
  self.ref_1341b = 0;
  self.showplunderextracticonsinworld = 0;
  self.getanimsforplanefacing = undefined;

  if(!isDefined(self.chopper_watch_death)) {
    self.ref_1202b = 0;
  }

  self.vip_questthink_iconposition = undefined;
  self.vip_respawnplayer = undefined;
  self.vip_removequestinstance = undefined;
  self.vipbot_movesup = undefined;
  self.vip_playerremoved = undefined;
  self.ref_1288a = undefined;
  self.ref_1288b = undefined;
  self.ref_1458d = undefined;
  self.numpropsperarea = undefined;
  self.weapon_xp_iw8_sh_dpapa12 = undefined;
  self.ref_13bdc = undefined;
  self.ref_1237b = undefined;
  self.cargo_truck_mg_addgunnerdamagemod = undefined;
  self.ref_14072 = undefined;
  self.watch_for_attack = undefined;
  self.watch_for_damage = undefined;
  self.watch_for_damage_on_trap = undefined;
  self.watch_for_damage_on_turret = undefined;
  self.ref_12a0c = undefined;
  self.get_tv_station_infil_rider_start_targetname = undefined;
  self.ref_13b5b = undefined;
  scripts\mp\gameobjects::detachusemodels();
}

function resetplayeromnvarsonspawn() {
  scripts\mp\playerlogic::resetuiomnvarscommon();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function hitlocdebug(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  GscBinSkip0(0x2e, 0, 2);
}

function giverecentshieldxp() {
  self endon("death_or_disconnect");
  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");
  self.recentshieldxp++;
  wait 20;
  self.recentshieldxp = 0;
}

function updateinflictorstat(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_0.alreadyhit) || !var_0.alreadyhit || !scripts\mp\utility\weapon::issinglehitweapon(var_2)) {
    scripts\mp\gamelogic::setinflictorstat(var_0, var_1, var_2);
  }

  if(isDefined(var_0)) {
    var_0.alreadyhit = 1;
    return;
  }
}

function addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hitcount = 1;
  } else {
    var_0.attackerdata[var_1.guid].hitcount++;
  }

  if(scripts\mp\utility\weapon::iscacprimaryweapon(var_3) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_3)) {
    var_0.attackerdata[var_1.guid].diddamagewithprimary = 1;
  }

  if(isDefined(var_9) && var_9 != "MOD_MELEE") {
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;
  }

  var_10 = scripts\mp\utility\weapon::getequipmenttype(var_3.basename);

  if(isDefined(var_10)) {
    if(var_10 == "lethal") {
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;
    }

    if(var_10 == "tactical") {
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
    }
  }

  var_0.attackerdata[var_1.guid].damage += var_4;
  var_0.attackerdata[var_1.guid].weapon = createheadicon(var_3);
  var_0.attackerdata[var_1.guid].objweapon = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid].psoffsettime = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();
  var_0.attackerdata[var_1.guid].inflictor = var_2;
  var_0.attackerdata[var_1.guid].ref_11c8d = var_1 scripts\mp\events::registerhints(0, var_0, var_3, var_9, var_2);
  var_0.attackerdata[var_1.guid].ref_11c8e = var_1 scripts\mp\events::registerleveldataforvehicle(0, var_0, var_3, var_9, var_2);

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon)) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
    return;
  }

  if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon())) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
    return;
  }

  var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

function addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_0.attackerdata[var_2.guid])) {
    var_0.attackers[var_2.guid] = var_2;
    var_0.attackerdata[var_2.guid] = spawnStruct();
    var_0.attackerdata[var_2.guid].damage = 0;
    var_0.attackerdata[var_2.guid].attackerent = var_2;
    var_0.attackerdata[var_2.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_2.guid].hitcount = 1;
  }

  var_0.attackerdata[var_2.guid].damage += var_1;
  var_0.attackerdata[var_2.guid].weapon = var_10;
  var_0.attackerdata[var_2.guid].vpoint = var_4;
  var_0.attackerdata[var_2.guid].vdir = var_3;
  var_0.attackerdata[var_2.guid].partname = var_8;
  var_0.attackerdata[var_2.guid].smeansofdeath = var_5;
  var_0.attackerdata[var_2.guid].attackerent = var_2;
  var_0.attackerdata[var_2.guid].lasttimedamaged = gettime();
  var_0.attackerdata[var_2.guid].ref_11c8d = 0;
  var_0.attackerdata[var_2.guid].ref_11c8e = 0;

  if(isDefined(var_2) && isPlayer(var_2) && !nullweapon(var_2 getcurrentprimaryweapon())) {
    var_0.attackerdata[var_2.guid].sprimaryweapon = createheadicon(var_2 getcurrentprimaryweapon());
    return;
  }

  var_0.attackerdata[var_2.guid].sprimaryweapon = undefined;
}

function resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
}

function removeoldattackersovertime() {
  self endon("damage");
  self endon("death_or_disconnect");
  level endon("game_ended");
  jumpiftrue(isDefined(self.attackers)) LOC_00000020;
  return;
}

function callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = gettime();
  callback_playerdamage_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

function ref_12aa2(var_0, var_1, var_2, var_3) {
  if(ref_1331e(self)) {
    var_0 scripts\mp\utility\stats::incpersstat("damage", var_1);

    if(!isDefined(var_0.isbecomingzombie)) {
      var_0.isbecomingzombie = var_1;
    } else {
      var_0.isbecomingzombie += var_1;
    }

    if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
      if(isPlayer(var_0)) {
        var_0 scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var_3), "damage", min(self.health, var_2), -1, var_3);
        scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_0, "damageDone", var_0 scripts\mp\utility\stats::getpersstat("damage"));
      }
    }

    var_4 = scripts\mp\utility\weapon::mapweapon(var_3);
    var_5 = createheadicon(var_4);
    var_0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_5, var_1, "damage_dealt");
    return;
  }

  if(isDefined(level.ref_12001)) {
    var_0[[level.ref_12001]](var_1);
    return;
  }
}

function finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = int(min(var_2, self.health));

  if(isDefined(var_1) && isPlayer(var_1)) {
    ref_12aa2(var_1, var_13, var_2, var_5);
  } else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_14 = var_0;

    if(isDefined(var_14.owner) && isPlayer(var_14.owner)) {
      ref_12aa2(var_14.owner, var_13, var_2, var_5);
    }
  } else if(isDefined(var_0) && var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unrescuable_fail()) {
    var_15 = var_0;

    if(isDefined(var_15.owner) && isPlayer(var_15.owner)) {
      ref_12aa2(var_15.owner, var_13, var_2, var_5);
    }
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_5)) {
    if(scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_5) == "precision_airstrike" && istrue(level.vehicle_collision_getleveldata)) {
      return;
    }
  }

  if(ref_1331e(self)) {
    var_16 = self.lastdroppableweaponobj;
    var_16 = scripts\mp\utility\weapon::mapweapon(var_16);
    var_17 = createheadicon(var_16);
    scripts\mp\utility\stats::incpersstat("damageTaken", var_13);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_17, 1, "hit_markers_taken");
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_17, var_13, "damage_taken");

    if(var_13 > 1000) {
      scripts\mp\gametypes\br_analytics::determine_starting_breadcrumb(self, var_13, var_4);
    }
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo) && isDefined(var_0.streakinfo.damage)) {
    var_0.streakinfo.damage += var_2;
  }

  if(scripts\mp\utility\damage::playershoulddofauxdeath() && var_2 >= self.health && !(var_3 &level.idflags_stun) && allowfauxdeath()) {
    if(!isDefined(var_7)) {
      var_7 = (0, 0, 0);
    }

    if(!isDefined(var_1)) {
      var_1 = self;
    }

    if(!isDefined(var_0)) {
      var_0 = var_1;
    }

    playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_7, var_8, var_9, 0, 1);
  } else {
    if(!callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      return;
    }

    if(!isalive(self)) {
      return;
    }

    if(isPlayer(self)) {
      if(!isDefined(var_11)) {
        var_11 = "";
      }

      if(!isDefined(var_12)) {
        var_12 = 0;
      }

      if(shoulduseexplosiveindicator(var_4)) {
        var_3 |= level.idflags_ricochet;
      }

      if(scripts\mp\utility\game::getgametype() == "br") {
        var_12 = 0;
      }

      var_18 = !(var_4 != "MOD_TRIGGER_HURT" && isDefined(self.update_bomb_interaction_ent));
      self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11, var_12, var_18);
      br_itemrarity(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }
  }

  if(var_4 == "MOD_EXPLOSIVE_BULLET") {
    scripts\cp_mp\utility\shellshock_utility::_shellshock("damage_mp", "damage", getdvarfloat("scr_csmode"), 0, 0);
  }

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

function shoulduseexplosiveindicator(var_0) {
  return var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_FIRE";
}

function callback_playerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread scripts\mp\weapons::impale(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

function allowfauxdeath() {
  if(!isDefined(level.allowfauxdeath)) {
    level.allowfauxdeath = 1;
  }

  return level.allowfauxdeath;
}

function callback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = isforcedlaststand(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  if(!istrue(var_9)) {
    if(scripts\mp\utility\game::getgametype() != "br" && !istrue(self.killstreaklaststand) && var_3 == "MOD_MELEE" && var_4.basename != "iw8_fists_mp" && var_4.basename != "iw8_fists_mp_ls") {
      return false;
    }

    if(var_3 == "MOD_EXECUTION") {
      return false;
    }

    if(scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\damage::isheadshot(var_6, var_3, var_1)) {
      return false;
    }

    if(scripts\mp\utility\game::getgametype() != "br" && isexplosivedamagemod(var_3)) {
      return false;
    }

    if(istrue(self.gulagarena)) {
      return false;
    }

    if(isDefined(var_1) && isDefined(var_1.classname) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn")) {
      return false;
    }

    if(var_1 == self && scripts\mp\utility\game::getgametype() != "br") {
      return false;
    }

    if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\killstreak::isjuggernaut()) {
      return false;
    }

    if(isDefined(level.ref_11c6f) && !self[[level.ref_11c6f]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8)) {
      return false;
    }
  }

  if(isDefined(level.ref_121d1)) {
    self[[level.ref_121d1]]();
  }

  if(self isskydiving()) {
    self skydive_interrupt();
  }

  var_10 = self.matchdatalifeindex;

  if(!isDefined(var_10)) {
    var_10 = level.maxlives - 1;
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname != "worldspawn") {
    if(!isPlayer(var_1)) {
      if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
        var_1 = var_1.owner;
      } else if(isDefined(var_0) && isDefined(var_0.owner) && isPlayer(var_0.owner)) {
        var_1 = var_0.owner;
      }
    }

    var_11 = playerkilled_initdeathdata(var_0, var_1, self, var_2, 0, var_3, var_4, var_5, var_6, var_7, var_8, 0);
    playerkilled_parameterfixup(var_11);
    playerkilled_precalc(var_11);
    var_11.laststandkill = 1;
    self.ref_125b9 = 1;

    if(isPlayer(var_1) && var_1 != self) {
      self.watch_for_attack = var_1;
      self.watch_for_level_weapons_free = var_11.meansofdeath;
      self.watch_for_player_enter_puddle_trigger = var_4;
      var_1 thread scripts\mp\events::cargo_truck_mg_initoccupancy(var_10, self, var_4, var_3, var_0, var_11);
      self.watch_for_damage = var_1.modifiers["mask"];
      self.watch_for_damage_on_trap = var_1.modifiers["mask2"];
      self.watch_for_damage_on_turret = var_1.modifiers["mask3"];
    }

    self.lastbounty = scripts\mp\bounty::playergetbountypoints();
    scripts\mp\bounty::playerresetbountypoints();
    scripts\mp\bounty::playerresetbountystreak();
    var_11.isfriendlyfire = isfriendlyfire(self, var_1);

    if(getdvarint("scr_killcam_on_down", 1)) {
      self.watch_for_driver_spawned = var_11;
    }

    if(!var_11.isfriendlyfire && var_1 != self) {
      if(scripts\mp\utility\game::getgametype() == "br") {
        if(isPlayer(var_1) && var_1 != self) {
          var_1 scripts\mp\gametypes\br_public::incrementplayersdownedstat();
          var_1 thread scripts\mp\rank::scoreeventpopup("downed");
          var_12 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_4);
          var_13 = isDefined(var_12) && var_12 == "precision_airstrike";

          if(var_13) {
            if(isDefined(var_1.brattractions)) {
              var_1.brattractions++;
            }
          }

          if(var_1 ispcplayer() && scripts\mp\flags::gameflag("prematch_done")) {
            var_1 setclientomnvar("nVidiaHighlights_events", 24);
          }

          if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "kingslayer" && getDvar("scr_br_gametype", "") != "gold_war" && level.teamdata[self.team]["alivePlayers"].size > 0) {
            obituary(self, var_1, var_4, "MOD_DOWN", level.teamdata[var_1.team]["alivePlayers"]);
          }
        }

        if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "kingslayer" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "gold_war") {
          if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
            var_14 = min(max(1, level.br_circle.circleindex), 6);
            var_15 = "br_downEnemy_circle_" + scripts\engine\utility::string(var_14);

            if(scripts\mp\rank::isregisteredevent(var_15) && isPlayer(var_1)) {
              var_1 thread scripts\mp\utility\points::giveunifiedpoints(var_15, var_4);
            }
          }
        }
      }
    }
  }

  scripts\common\utility::allow_vehicle_use(0);
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::brjugg_droponplayerdeath(0);

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    scripts\mp\gametypes\br_plunder::ref_12781(self, 0, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::branalytics_down(var_1, self, var_4, "downed", var_3);

    if(var_3 == "MOD_CRUSH" && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
      self playSound("vehicle_body_hit");
    }
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    if(isDefined(var_1) && isPlayer(var_1) && !isbot(var_1)) {
      var_1 notify("enemy_in_laststand");
    }
  }

  if(isDefined(level.getinfilplayers)) {
    if([[level.getinfilplayers]](self)) {
      return false;
    }
  }

  thread scripts\mp\laststand::laststandthink();
  return true;
}

function isforcedlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(scripts\mp\gametypes\br_public::validtousesticker()) {
      return 1;
    }

    if(isDefined(var_2) && isPlayer(var_2) && var_2 != var_0 && !istrue(var_2.gulag)) {
      var_2 thread scripts\mp\hud_message::showsplash("br_enemy_downed", undefined, var_0);
    }

    if(var_4 == "MOD_FALLING" && !istrue(self.gulagarena)) {
      var_8 = 1;
    }
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
    var_8 = 1;
  }

  return var_8;
}

function gethitlocheight(var_0) {
  switch (var_0) {
    case "neck":
    case "helmet":
    case "head":
      return 60;
    case "left_hand":
    case "right_hand":
    case "left_arm_lower":
    case "right_arm_lower":
    case "left_arm_upper":
    case "right_arm_upper":
    case "torso_upper":
    case "gun":
      return 48;
    case "torso_lower":
      return 40;
    case "right_leg_upper":
    case "left_leg_upper":
      return 32;
    case "right_leg_lower":
    case "left_leg_lower":
      return 10;
    case "right_foot":
    case "left_foot":
      return 5;
  }

  return 48;
}

function damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread scripts\mp\weapons::onweapondamage(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self) && scripts\common\utility::getdamagetype(var_2) != "bullet") {
    self playRumbleOnEntity("damage_heavy");

    if(isDefined(var_0) && istrue(var_0.vehicle_collision_getignoreevent)) {
      self playSound("train_veh_impact_body");

      if(isDefined(level.ref_145f1.ref_13c8d)) {
        var_6 = level.ref_145f1.ref_13c8d[0].wz_tease;
        var_6 playsoundonmovingent("veh_horn_cargotrain");
      }
    }

    if(scripts\mp\utility\game::getgametype() != "br" && var_2 == "MOD_TRIGGER_HURT") {
      self playsoundtoplayer("trigger_hurt_impact_plr", self);
      return;
    }

    return;
  }
}

function callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return true;
}

function emitfalldamage(var_0) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
}

function gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_2) && isPlayer(var_2) && isalive(var_2)) {
    if(level.matchrules_damagemultiplier) {
      var_3 *= level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      var_2.health = int(min(float(var_2.maxhealth), min(var_2.health + var_3, float(var_2.health + 20))));
      var_2 notify("vampirism");
    }

    if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_11 = weaponclass(var_5);

      switch (var_8) {
        case "neck":
        case "helmet":
        case "head":
          if(var_11 != "spread" && var_5.basename != "white_phosphorus_proj_mp") {
            var_3 *= 2.7;
          }

          break;
        case "torso_upper":
          break;
        case "left_hand":
        case "right_hand":
        case "left_arm_lower":
        case "right_arm_lower":
        case "left_arm_upper":
        case "right_arm_upper":
        case "gun":
          break;
        case "torso_lower":
          break;
        case "right_leg_upper":
        case "left_leg_upper":
          break;
        case "right_foot":
        case "left_foot":
        case "right_leg_lower":
        case "left_leg_lower":
          break;
      }
    }

    if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
        if(!isbot(var_1)) {
          if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_HEAD_SHOT") {
            var_12 = 80;

            if(!isPlayer(var_2) || !isPlayer(var_1)) {
              return 0;
            }

            var_13 = var_1 getplayerangles();
            var_14 = var_2 getplayerangles();
            var_15 = angleclamp180(var_13[1] - var_14[1]);

            if(abs(var_15) < var_12) {
              var_3 *= 0.3;
            }
          }
        }
      }
    }

    if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() == "infect" && isDefined(var_5)) {
      if(var_5.basename == "iw8_fists_mp_zmb") {
        var_3 = 135;
      }
    }
  }

  return var_3;
}

function registerkill(var_0, var_1, var_2, var_3) {
  self.killcountthislife++;
  self.pers["cur_kill_streak"]++;
  self setclientomnvar("ui_life_kill_count", self.killcountthislife);
}

function monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 2147483647;
  self.maxhealth = var_0;

  if(!isDefined(self.damagetaken) || istrue(var_6)) {
    self.damagetaken = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_7 = 1; var_7; var_7 = monitordamageoneshot(var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_21, var_1, var_2, var_3, var_4)) {
    self waittill("damage", var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21);
    var_17 = scripts\mp\utility\weapon::mapweapon(var_17, var_21);

    if(var_5) {
      self playRumbleOnEntity("damage_light");
    }

    if(var_4) {
      var_22 = "none";

      if(isDefined(var_17)) {
        var_22 = createheadicon(var_17);
      }

      logattackerkillstreak(self, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_22);
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

function monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(isDefined(var_1) && !scripts\mp\utility\entity::isgameparticipant(var_1) && !istrue(var_1.ref_1217b)) {
    return true;
  }

  if(isDefined(var_1) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_1)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else {
      return true;
    }
  }

  var_15 = var_0;

  if(!istrue(self.ref_133d4) && scripts\mp\utility\damage::non_player_should_ignore_damage(var_1, var_9, var_10, var_4)) {
    return true;
  }

  if(isDefined(var_9)) {
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);

    if(!isDefined(var_13)) {
      var_13 = &modifydamage;
    }

    var_15 = self[[var_13]](var_16);
  }

  if(var_15 <= 0) {
    return true;
  }

  self.wasdamaged = 1;
  self.damagetaken += int(var_15);
  self.health = 2147483647;

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  if(istrue(var_14)) {
    scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_9, self, var_4, var_15);
  }

  if(isDefined(var_1)) {
    if(isPlayer(var_1)) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_11);
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);
    self thread[[var_12]](var_16);
    return false;
  }

  return true;
}

function modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflag;

  if(isDefined(var_5) && var_5 && level.idflags_ricochet) {
    var_6 = 0.6 * var_4;
  } else {
    var_6 = var_5;
  }

  var_6 = handleempdamage(var_3, var_4, var_6);
  var_6 = handlemissiledamage(var_3, var_4, var_6);
  var_6 = handlegrenadedamage(var_3, var_4, var_6);
  var_6 = handleapdamage(var_3, var_4, var_6);
  return var_6;
}

function handlemissiledamage(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0.basename) {
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_gromeo_mp":
    case "bomb_site_mp":
    case "iw8_la_t9launcher_mp":
    case "iw8_la_t9freefire_mp":
    case "iw8_la_t9standard_mp":
      self.largeprojectiledamage = 1;
      var_3 = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      var_3 *= 2;
      break;
  }

  return var_3;
}

function handlegrenadedamage(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_1)) {
    switch (var_0.basename) {
      case "c4_mp_p":
        var_2 *= 3;
        break;
      case "bouncing_betty_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_2 *= 4;
        break;
      default:
        if(var_0.isalternate) {
          var_2 *= 3;
        }

        break;
    }
  }

  return var_2;
}

function handlemeleedamage(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return (self.maxhealth + 1);
  }

  return var_2;
}

function handleempdamage(var_0, var_1, var_2) {
  return var_2;
}

function handleapdamage(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = level.armorpiercingmod - 1;

  if(scripts\mp\utility\damage::isfmjdamage(var_0, var_1, 1)) {
    var_4 += var_5;
  }

  var_6 = level.armorpiercingmodks - 1;

  if(isDefined(var_3) && var_3 scripts\mp\utility\perk::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\mp\utility\weapon::isprimaryweapon(var_0) && scripts\engine\utility::isbulletdamage(var_1)) {
    var_4 += var_6;
  }

  return var_2 * var_4;
}

function handleshotgundamage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return var_2;
  }

  if(var_0.basename == "none") {
    return var_2;
  }

  if(weaponclass(var_0) != "spread") {
    return var_2;
  }

  return int(min(150, var_2));
}

function onkillstreakdamaged(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    }

    if(isPlayer(var_1) && self.owner scripts\mp\utility\player::isenemy(var_1)) {
      var_4 = var_1;
    }
  }

  if(isDefined(var_4)) {
    thread scripts\cp\vehicles\vehicle_compass_cp::killstreakdamaged(var_0, self.owner, var_4, var_2, var_3);
    return;
  }
}

function onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    }

    if(issentient(self.owner) && issentient(var_1)) {
      if(!istestclient(self.owner, var_1)) {
        var_10 = var_1;
      }
    } else if(self.owner scripts\mp\utility\player::isenemy(var_1)) {
      var_10 = var_1;
    }
  }

  if(isDefined(var_10)) {
    if(isDefined(var_7)) {
      var_10 scripts\mp\battlechatter_mp::killstreakdestroyed(var_0);
    }

    thread scripts\mp\events::killedkillstreak(var_0, var_10, var_2);
    thread scripts\cp\vehicles\vehicle_compass_cp::killstreakkilled(var_0, self.owner, self, var_10, var_4, var_3, var_2, var_5);
    scripts\cp_mp\gestures::processcalloutdeath(self, var_10);
    var_9 = 1;
  }

  thread scripts\mp\events::ref_128b3(var_10);

  if(isDefined(self.owner) && isDefined(var_6)) {
    self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer(var_6, undefined, undefined, self.origin);
  }

  if(!istrue(var_8)) {
    self notify("death");
  }

  return var_9;
}

function updatedeathdetails(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_2.health)) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      self setclientomnvar("ui_death_details_enemy_health", 0);
    } else {
      self setclientomnvar("ui_death_details_enemy_health", int(clamp(var_2.health, 0, var_2.maxhealth)) / var_2.maxhealth);
    }
  } else {
    self setclientomnvar("ui_death_details_enemy_health", -1);
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_5 in var_0) {
      if(!isPlayer(var_5)) {
        continue;
      }

      var_6 = var_5 getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + var_3, var_6);
      self setclientomnvar("ui_death_details_hits_" + var_3, int(min(var_1[var_7].hitcount, 10)));
      var_3++;

      if(var_3 >= 4) {
        break;
      }
    }
  }

  for(var_8 = var_3; var_8 < 4; var_8++) {
    self setclientomnvar("ui_death_details_attacker_" + var_8, -1);
  }
}

function setdeathtimerlength(var_0) {
  var_1 = var_0.victim;
  var_2 = 0;

  if(var_1 scripts\mp\playerlogic::mayspawn() && !level.loadoutdefaultfiresalediscount) {
    var_3 = scripts\mp\playerlogic::timeuntilspawn(1);
    var_4 = 2.25;
    var_5 = 1;
    var_3 = max(var_3 + var_5, var_4);
    var_2 = var_3 + var_0.deathscenetimesec;
  }

  var_1.death_timer_length = int(var_2 * 10);
}

function getindexfromhitloc(var_0) {
  switch (var_0) {
    case "torso_upper":
      return 0;
    case "torso_lower":
      return 1;
    case "helmet":
      return 2;
    case "head":
      return 3;
    case "neck":
      return 4;
    case "left_arm_upper":
      return 5;
    case "left_arm_lower":
      return 6;
    case "left_hand":
      return 7;
    case "right_arm_upper":
      return 8;
    case "right_arm_lower":
      return 9;
    case "right_hand":
      return 10;
    case "left_leg_upper":
      return 11;
    case "left_leg_lower":
      return 12;
    case "left_foot":
      return 13;
    case "right_leg_upper":
      return 14;
    case "right_leg_lower":
      return 15;
    case "right_foot":
      return 16;
    case "gun":
      return 17;
    case "none":
      return 18;
  }

  return 0;
}

function showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

function updatecombatrecordkillstats(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  if(isDefined(var_0) && isPlayer(var_0) && var_0 != var_1) {
    combatrecordarchetypekill(var_0, var_0.loadoutarchetype);

    if(isDefined(var_3)) {
      var_4 = scripts\mp\utility\weapon::getequipmenttype(var_3.basename);

      if(isDefined(var_4) && var_4 == "lethal") {
        var_5 = scripts\mp\equipment::getequipmentreffromweapon(var_3);

        if(var_5 == "equip_throwing_knife_fire" || var_5 == "equip_throwing_knife_electric" || var_5 == "equip_throwing_knife_drill") {
          var_5 = "equip_throwing_knife";
        }

        combatrecordlethalkill(var_0, var_5);
      } else {
        var_6 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_3);

        if(isDefined(var_6)) {
          if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_6)) {
            combatrecordkillstreakstat(var_0, var_6);
          }
        }

        if(scripts\mp\utility\game::getgametype() != "br") {
          if(istrue(var_0.personalradaractive)) {
            combatrecordtacticalstat(var_0, "power_periphVis");
          }

          if(istrue(var_0.adrenalinepoweractive)) {
            combatrecordtacticalstat(var_0, "power_adrenaline");
          }
        }
      }
    }
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    combatrecordarchetypedeath(var_1, var_1.loadoutarchetype);
    return;
  }
}

function combatrecordarchetypekill(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "playerStats", "archetypeStats", var_0, "kills");
  self setplayerdata("mp", "playerStats", "archetypeStats", var_0, "kills", var_1 + 1);
}

function combatrecordarchetypedeath(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "playerStats", "archetypeStats", var_0, "deaths");
  self setplayerdata("mp", "playerStats", "archetypeStats", var_0, "deaths", var_1 + 1);
}

function hide_name_fx_from_players(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\equipment::isequipmentlethal(var_0);

  if(var_0 == "equip_throwing_knife_fire" || var_0 == "equip_throwing_knife_electric" || var_0 == "equip_throwing_knife_drill") {
    var_0 = "equip_throwing_knife";
  }

  if(var_1) {
    var_2 = self getplayerdata("mp", "playerStats", "lethalStats", var_0, "uses");
    self setplayerdata("mp", "playerStats", "lethalStats", var_0, "uses", var_2 + 1);
    return;
  }

  var_2 = self getplayerdata("mp", "playerStats", "tacticalStats", var_1, "uses");
  self setplayerdata("mp", "playerStats", "tacticalStats", var_1, "uses", var_2 + 1);
}

function combatrecordlethalkill(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "playerStats", "lethalStats", var_0, "kills");
  self setplayerdata("mp", "playerStats", "lethalStats", var_0, "kills", var_1 + 1);
}

function combatrecordtacticalstat(var_0, var_1) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats() || !isPlayer(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = self getplayerdata("mp", "playerStats", "tacticalStats", var_0, "extraStat1");
  self setplayerdata("mp", "playerStats", "tacticalStats", var_0, "extraStat1", var_2 + var_1);
}

function combatrecordkillstreakstat(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self getplayerdata("mp", "playerStats", var_1, var_0, "extraStat1");
  self setplayerdata("mp", "playerStats", var_1, var_0, "extraStat1", var_2 + 1);
}

function enqueuecorpsetablefunc(var_0, var_1) {
  if(!isDefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isDefined(self.corpsetablefuncs[var_0])) {
    self.corpsetablefuncs[var_0] = var_1;
    self.corpsetablefunccounts[var_0] = 0;
  }

  self.corpsetablefunccounts[var_0]++;
}

function dequeuecorpsetablefunc(var_0) {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  if(!isDefined(self.corpsetablefuncs[var_0])) {
    return;
  }

  self.corpsetablefunccounts[var_0]--;

  if(self.corpsetablefunccounts[var_0] <= 0) {
    self.corpsetablefuncs[var_0] = undefined;
    self.corpsetablefunccounts[var_0] = undefined;
    return;
  }
}

function callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  var_0 = self.body;

  foreach(var_2 in self.corpsetablefuncs) {
    self thread[[var_2]](var_0);
  }

  thread clearcorpsetablefuncs();
}

function clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

function enqueueweapononkillcorpsetablefuncs(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\weapons::update_icon_for_bomb_case_detonator_holder(var_3)) {
    enqueuecorpsetablefunc("8bitDeath", &scripts\mp\weapons::ref_11df5);
    return;
  }

  if(scripts\mp\weapons::update_jugg_targets(var_3)) {
    enqueuecorpsetablefunc("teslaDeath", &scripts\mp\weapons::ref_11df6);
    return;
  }
}

function startcopycatoption(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_copy_cat_option");

  if(!isDefined(var_0) || !isPlayer(var_0) || isbot(self)) {
    return;
  }

  while(self playcinematicforplayerlooping()) {
    waitframe();
  }

  while(!self playcinematicforplayerlooping()) {
    waitframe();
  }

  scripts\mp\class::copyclassfornextlife(var_0);
}

function stopcopycatoption() {
  self notify("stop_copy_cat_option");
}

function unset_force_aitype_sniper(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && isDefined(var_0.code_classname) && var_0.code_classname == "scriptable") {
    switch (var_0.classname) {
      case "scriptable_rp_propane_tank_long_01":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

function ref_1331e(var_0) {
  if(istrue(level.little_bird_mp_initmines)) {
    return false;
  }

  if(isDefined(level.little_bird_onenterheavydamagestate) && ![[level.little_bird_onenterheavydamagestate]](var_0)) {
    return false;
  }

  return true;
}

function ref_119c0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_3)) {
    return;
  }

  var_4 = var_2 >= var_0.health;
  var_1 scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var_1.currentweapon), "friendly_fire_damage", int(min(var_2, var_0.health)), -1, var_1.currentweapon);
  var_0 dlog_recordplayerevent("dlog_event_friendly_fire", ["attacker", var_1, "damage", var_2, "is_fatal_damage", var_4, "damage_method", var_3]);
}

function usecallback(var_0) {
  if(!isscriptedagent(var_0)) {
    return false;
  }

  return true;
}

function ref_12f86(var_0, var_1, var_2) {
  if(!isDefined(var_0.unittype) || var_2 == "MOD_MELEE ") {
    return var_1;
  }

  switch (var_0.unittype) {
    case "juggernaut":
      return int(var_1 * 0.3);
    case "soldier":
      return int(var_1 * 0.4);
  }

  return var_1;
}

function br_itemrarity(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_1)) {
    return;
  }

  var_14 = isDefined(var_5) && var_5.basename == "tur_gun_bt_mp_bomb";

  if(!istrue(var_14) && !var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() && !var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }

  if(!isDefined(var_1.branalytics_publiceventstarted)) {
    var_1.br_onvehicledeath = ["run_over_driverless", 0, "run_over", 0, "airplane_explode", 0, "bomb", 0, "bomber_turret", 0, "dauntless", 0, "dauntless_ads", 0, "self_elimination", 0, "other", 0];
  }

  var_15 = [];
  var_16 = "";

  if(!isent(var_13) || !isPlayer(var_13)) {
    return;
  }

  if(var_1 == var_13) {
    var_16 = "self_elimination";
  } else if((var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) && var_4 == "MOD_CRUSH") {
    var_17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_1);

    if(!isDefined(var_17)) {
      var_16 = "run_over_driverless";
    } else {
      var_16 = "run_over";
    }
  } else if(istrue(var_14)) {
    var_16 = "bomb";
  } else if(isDefined(var_5) && var_5.basename == "tur_gun_bt_mp") {
    var_16 = "bomber_turret";
  } else if(isDefined(var_5) && var_5.basename == "tur_gun_fd_mp_seeking") {
    var_16 = "dauntless_ads";
  } else if(var_4 == "MOD_EXPLOSIVE") {
    var_16 = "airplane_explode";
  } else {
    var_16 = "other";
  }

  switch (var_16) {
    case "run_over_driverless":
      var_1.br_onvehicledeath[1] += 1;
      break;
    case "run_over":
      var_1.br_onvehicledeath[3] += 1;
      break;
    case "airplane_explode":
      var_1.br_onvehicledeath[5] += 1;
      break;
    case "bomb":
      var_1.br_onvehicledeath[7] += 1;
      break;
    case "bomber_turret":
      var_1.br_onvehicledeath[9] += 1;
      break;
    case "dauntless":
      var_1.br_onvehicledeath[11] += 1;
      break;
    case "dauntless_ads":
      var_1.br_onvehicledeath[13] += 1;
      break;
    case "self_elimination":
      var_1.br_onvehicledeath[15] += 1;
      break;
    case "other":
      var_1.br_onvehicledeath[17] += 1;
      break;
    default:
      break;
  }

  var_1.br_onvehicledeath[var_1.br_onvehicledeath.size] = "last_victim_ent_num";
  var_1.br_onvehicledeath[var_1.br_onvehicledeath.size] = var_13 getentitynumber();

  if(isPlayer(var_1)) {
    var_1 dlog_recordplayerevent("dlog_event_plane_kill_type", var_1.br_onvehicledeath);
    return;
  }

  if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
    var_1.owner dlog_recordplayerevent("dlog_event_plane_kill_type", var_1.br_onvehicledeath);
    return;
  }
}