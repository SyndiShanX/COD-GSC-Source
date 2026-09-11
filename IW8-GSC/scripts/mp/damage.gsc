/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\damage.gsc
***********************************************/

function callback_playerdamage_internal(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15) {
  if(isDefined(var1) && isDefined(var1.classname) && var1.classname == "worldspawn") {
    var1 = undefined;
  }

  if(isDefined(var1) && isDefined(var1.gunner)) {
    var1 = var1.gunner;
  }

  if(istrue(var2.plotarmor)) {
    return;
  }

  if(istrue(var2.ref_12058) && isDefined(var6)) {
    if(!trial_vehicle_outline_id(var6.basename)) {
      return;
    }
  }

  if(var5 == "MOD_CRUSH" && isDefined(var0) && isDefined(var2 scripts\cp_mp\utility\player_utility::getvehicle()) && var2 scripts\cp_mp\utility\player_utility::getvehicle() == var0) {
    return;
  }

  if(var5 == "MOD_CRUSH" && isDefined(var0) && isDefined(var0.classname) && var0.classname == "script_vehicle" && isDefined(var0.vehiclename) && var0.vehiclename == "loot_chopper") {
    var17 = 10000;
    var18 = gettime() - var0.birthtime;

    if(var18 < var17) {
      return;
    }
  }

  if(istrue(var2.inlaststand) && istrue(level.laststandrequiresmelee) && var5 != "MOD_MELEE") {
    return;
  }

  var19 = var2.health;

  if(var4 &level.idflags_stun) {
    if(istrue(level.ref_13c56)) {
      var2 thread scripts\mp\battlechatter_mp::addrecentattacker(var1);
    }

    return;
  }

  var20 = filterdamage(var0, var1, var2, var3, var5, var6, var9);

  if(isDefined(var20)) {
    return;
  }

  var21 = scripts\mp\utility\damage::attackerishittingteam(var2, var1);

  if(isDefined(var0) && istrue(var0.flare_activated)) {
    var21 = 0;
  }

  var22 = isDefined(var6) && scripts\mp\utility\weapon::iskillstreakweapon(var6.basename);

  if(!istrue(level.allowprematchdamage)) {
    if(istrue(game["inLiveLobby"]) || !scripts\mp\flags::gameflag("prematch_done") || istrue(level.stop_end_breach_fx)) {
      handledamagefeedback(var0, var1, var2, 0, var5, var6, var9, var4, 1, 1, var22);
      return;
    }
  }

  if(var21) {
    var3 = handlefriendlyfiredamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var22);

    if(var3 == 0) {
      return;
    }
  }

  if(istrue(var2.spawnprotection) || var2 method_87d3()) {
    var23 = isDefined(var1) && isDefined(var1.classname) && var1.classname == "trigger_hurt";
    var24 = var5 == "MOD_FALLING";

    if(!var23 && !var24) {
      handledamagefeedback(var0, var1, var2, 0, var5, var6, var9, var4, 1, 1, var22);
      return;
    }
  }

  if(isDefined(var1) && istrue(var1.cranked)) {
    var1 thread scripts\mp\cranked::ref_1200c(var2);
  }

  if(isDefined(var1) && isDefined(var1.classname) && var1.classname == "script_origin" && isDefined(var1.type) && var1.type == "soft_landing") {
    return;
  }

  var4 |= level.idflags_no_knockback;

  if((usetimeoverride(var6) || tutorialzoneexit(var1, var6) || var6 hasattachment("ammo_incendiary", 1)) && scripts\mp\utility\damage::validshotcheck(var5, var1)) {
    if(isDefined(var6.unlockableindex)) {
      thread mine_caves_ambusher_internal(var2, var9, var1);
    }

    if(var6.basename != "iw8_pi_t9pistolshot_mp") {
      var3 = ref_13714(var2, var1, var6, var3, var4);
    } else if(var3 == 0) {
      return;
    }
  }

  var25 = var6.basename;
  var26 = scripts\mp\utility\weapon::getequipmenttype(var25);

  if(isDefined(var26)) {
    if(var26 == "lethal") {
      var3 = lethalequipmentdamagemod(var0, var1, var2, var3, var4, var5, var6);
    } else if(var26 == "tactical") {}

    LOC_000003ab:
      var27 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, var2, var3, var6, var5, var0, var7, var8, undefined, var12, undefined, var4);
    var28 = scripts\mp\equipment::equiponplayerdamaged(var27);

    if(isDefined(var28) && var28 == 0) {
      return;
    }
  }

  if(var2 scripts\mp\utility\game::ismatchstartprotected()) {
    var29 = isDefined(var6) && isDefined(var6.basename) && var6.basename == "minefield_mp";

    if(!var29) {
      var30 = istrue(var6.isalternate);

      if(isDefined(var26) && !scripts\mp\utility\weapon::isthrowingknife(var25) || var30 || var5 == "MOD_EXPLOSIVE") {
        var31 = int(max(var2.health / 5, 1));

        if(var3 >= var31) {
          var3 = var31;
        }
      }
    }
  }

  var32 = scripts\mp\utility\weapon::getweapontype(var25);

  if(isDefined(var32) && var32 == "killstreak") {
    var3 = killstreakdamagefilter(var1, var2, var3, var6, var5);

    if(var3 == 0) {
      return;
    }

    if(isDefined(level.gunshipplayer) && isDefined(var1) && level.gunshipplayer == var1) {
      level notify("ai_pain", var2);
    }
  }

  if(var5 == "MOD_CRUSH" && isDefined(var1) && isDefined(var1.streakname) && var1.streakname == "emp_drone") {
    var3 = 0;
  }

  var3 = modifydamagegeneral(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var14);
  var3 = handleriotshieldhits(var0, var2, var1, var3, var5, var6, var7, var8, var9, var4, var22, var14);

  if(var3 == 0) {
    if(istrue(level.ref_13c56)) {
      var2 thread scripts\mp\battlechatter_mp::addrecentattacker(var1);
    }

    return;
  }

  var33 = var3;

  if(!istrue(var2.donotmodifydamage)) {
    var34 = cac_modified_damage(var2, var1, var3, var5, var6, var7, var8, var9, var0, 0, var4, var22, var14);
    var3 = var34[0];
    var35 = var34[1];
    var36 = var34[2];
    var37 = var35 != 0 || var36 != 0;
    var9 = var34[3];
  } else {
    var35 = 0;
    var36 = 0;
    var37 = 0;
  }

  if(unsetspecialistbonus(var4, var5, var6, var8, var9, var19)) {
    return;
  }

  if(isDefined(var5.forcehitlocation)) {
    var12 = var5.forcehitlocation;
    var5.forcehitlocation = undefined;
  }

  if(isPlayer(var4) && (var33 == "smoke_grenade_mp" || scripts\mp\utility\weapon::isthrowingknife(var33))) {
    var4 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var33, 1, "hits");
  }

  var38 = var11;

  if(isDefined(var7) && var7 &level.idflags_ricochet && var6 < self.health) {
    var38 = var5.origin - var4.origin;
  }

  if(unset_force_aitype_sniper(var3)) {
    var6 = 0;
  }

  if(isDefined(var4) && (isPlayer(var4) || istrue(var4.brking_getcenterofcircle)) && scripts\mp\utility\game::getgametype() == "br") {
    if(armorvest_washit(var4) || helmet_washit(var4)) {
      var7 |= level.ss_circletick;
    }

    if(armorvest_wasbroke(var4) || helmet_wasbroke(var4)) {
      var7 |= level.sr_next_ammo_restock_time;
    }

    if(isDefined(level.ref_12067)) {
      var7 |= [[level.ref_12067]](var5);
    }
  }

  if(usecallback(var4)) {
    var6 = ref_12f86(var4, var6, var8);
  }

  if(isDefined(level.ref_12066)) {
    if(![[level.ref_12066]](var8)) {
      return;
    }
  }

  var39 = 5;

  if(isPlayer(var4) && var4 scripts\mp\utility\perk::_hasperk("specialty_br_ping_on_damage") && var37 >= var39) {
    if(isPlayer(var5) && var5 scripts\mp\utility\perk::_hasperk("specialty_coldblooded") && var5 != var4) {
      var4 thread scripts\mp\perks\perkfunctions::ref_12374();
    } else {
      var4 scripts\mp\perks\perkfunctions::maxmuncurrencycap(var5);
    }
  }

  if(isDefined(var4) && isPlayer(var4) && var4 != var5) {
    if(var8 == "MOD_RIFLE_BULLET" || var8 == "MOD_PISTOL_BULLET") {
      if(var5 scripts\mp\utility\perk::_hasperk("specialty_br_sprinting_dr") && (var5 issupersprinting() || var5 issprintsliding())) {
        var40 = var6;
        var6 = int(var40 * getdvarfloat("scr_perk_serpentine_drmod", 0.85));

        if(!isagent(var4) && !isbot(var4)) {
          var4 thread scripts\mp\perks\perkfunctions::ref_13716();
        }
      }
    }
  }

  preplayerdamaged(var3, var4, var5, var6, var7, var8, var9, var10, var38, var12, var13, var14, var15);
  finishplayerdamagewrapper(var5, var3, var4, var6, var7, var8, var9, var10, var38, var12, var13, var14, var15, var37);
  postplayerdamaged(var3, var4, var5, var6, var7, var8, var9, var10, var38, var12, var13, var14, var15, var35, var36, var22, var32);
}

function rungwperif_plumes(var0, var1, var2, var3, var4) {
  var5 = function_0438(var2);
  var6 = function_0439(var0, var1, var5);

  if(var5 == 0 || var5 > 17 || var6 > 1.1) {
    return var3;
  }

  var7 = var5 - 1;

  if(var5 - 6 > 0) {
    var7--;
  }

  if(var5 == 6 || var5 == 7) {
    var7 = 4;
  }

  if(var5 == 12 || var5 == 13) {
    var7 = 5;
  }

  var8 = function_0439(var0, var1, var7);

  if(var8 > 1.1) {
    return floor(var4 * var8);
  }

  return var3;
}

function mine_caves_ambusher_internal(var0, var1, var2) {
  self notify("newDragonsBreathHitLoc");
  self endon("newDragonsBreathHitLoc");

  if(!isDefined(self.mine_caves_ambusher)) {
    self.mine_caves_ambusher = scripts\cp_mp\killstreaks\nuke::ref_13638();
  }

  self.mine_caves_ambusher.ref_11e62 = scripts\engine\utility::array_add(self.mine_caves_ambusher.ref_11e62, var0);
  waittillframeend();
  var3 = [];

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.mine_caves_ambusher)) {
    var3 = self.mine_caves_ambusher.ref_11e62;
    self.mine_caves_ambusher.ref_11e62 = [];
  }

  if(scripts\mp\utility\player::isreallyalive(self)) {
    scripts\cp_mp\killstreaks\nuke::ref_13146(var3, var1, var2);
    return;
  }

  scripts\cp_mp\killstreaks\nuke::ref_13147();
}

function preplayerdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = var3;
  var2.lastweaponused = var2 getcurrentweapon();
  var2.wasaimingdownsightsondamage = var2 scripts\mp\utility\player::isplayerads();

  if(isai(self)) {
    self[[level.bot_funcs["on_damaged"]]](var1, var3, var5, var6, var0, var9);
  }

  if(isDefined(var0) && isDefined(var0.streakinfo) && isDefined(var0.streakinfo.hits)) {
    var0.streakinfo.hits++;
  }

  scripts\mp\perks\perkfunctions::bulletoutlinecheck(var1, var2, var6.basename, var5);

  if(var5 == "MOD_FALLING") {
    thread emitfalldamage(var2);
  }

  logattacker(var2, var1, var0, var6, var3, var7, var8, var9, var10, var5);

  if(isDefined(var0) && isDefined(var0.owner) && var0.owner.team != var2.team) {
    var2.lastdamagewasfromenemy = 1;
  } else {
    var2.lastdamagewasfromenemy = isDefined(var1) && var1 != var2;
  }

  if(var2.lastdamagewasfromenemy) {
    var14 = gettime();
    var1.damagedplayers[var2.guid] = var14;
    var2.lastdamagedtime = var14;
  }

  var2 thread scripts\mp\potg_events::onplayerdamaged(var1, var2, var5);
  var2 thread scripts\cp\vehicles\vehicle_compass_cp::playerdamaged(var0, var1, var3, var5, var6, var9);

  if(isDefined(var1) && var3 != 0) {
    var1 notify("victim_damaged", var2, var0, var3, var4, var5, var6, var7, var8, var9, var10);
    var2 notify("victim_was_damaged", var1, var0, var3, var4, var5, var6, var7, var8, var9, var10);
  }

  if(isDefined(level.preplayerdamaged)) {
    var2 thread[[level.preplayerdamaged]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
  }
}

function postplayerdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16) {
  var17 = var3;
  var18 = scripts\engine\utility::isbulletdamage(var5);

  if(var3 > 10 && isDefined(var0) && !var2 scripts\mp\utility\player::isusingremote() && isPlayer(var2)) {
    var2 thread scripts\mp\shellshock::bloodeffect(var0.origin);

    if(isPlayer(var0) && var5 == "MOD_MELEE") {
      if(isalive(var2) && !var2 scripts\mp\utility\killstreak::isjuggernaut() && scripts\mp\utility\game::getgametype() != "br") {
        thread meleestagger(var2);
        var2.hitwithmeleetime = gettime();
      }

      var0 thread scripts\mp\shellshock::bloodmeleeeffect(var6, var2);
      var2 playRumbleOnEntity("defaultweapon_melee");
      var0 playRumbleOnEntity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
      if(var3 >= self.health) {
        var3 = self.health - 1;
      } else {
        var19 = createheadicon(var6);
        self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var0, var1, var3, var4, var5, var19, var7, var8, var9, var10);
      }
    } else {
      var19 = createheadicon(var6);
      self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var0, var1, var3, var4, var5, var19, var7, var8, var9, var10);
    }
  }

  handledamagefeedback(var0, var1, var2, var3, var5, var6, var9, var4, var13, var14, var16);

  if(var18) {
    var2 thread scripts\mp\battlechatter_mp::adddamagetaken(var1, var6, var3);
  }

  if(isagent(var1) && isDefined(var1) && var1 scripts\cp_mp\utility\player_utility::_isalive() && var1 != var2) {
    var2 thread scripts\mp\battlechatter_mp::addrecentattacker(var1);
  }

  if(isDefined(var2) && var2 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(var2.health < 30) {
      var2 thread scripts\mp\battlechatter_mp::hurtbadlywait();
    }

    if(isDefined(var1) && var1 != var2 && isexplosivedamagemod(var5)) {
      if(!isDefined(var6) || var6.basename != "gas_mp") {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var2, "flavor_surprise", undefined, 0.5);
      }
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(var2, 1);

  if(isDefined(var1) && var1 != var2) {
    level.usestartspawns = 0;
  }

  if(isPlayer(var1) && isDefined(var1.pers["participation"])) {
    var1.pers["participation"]++;
  } else if(isPlayer(var1)) {
    var1.pers["participation"] = 1;
  }

  if(isDefined(level.cinematic_replay_recording) && isPlayer(var0)) {
    var22 = spawnStruct();
    var22.victim = var2;
    var22.vpoint = var7;
    var22.vdir = var8;
    var22.objweapon = var6;
    var22.kill = !isalive(var2);
    var0.hitrecord[var0.hitrecord.size] = var22;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isPlayer(var2) && isDefined(var0) && isPlayer(var0) && var18) {
    if(var15 == var2.maxhealth && var2.health != self.maxhealth) {
      var2.engagementstarttime = gettime();
    }
  }

  if(allowdamageflash(var1, var2, var6, var5, var3)) {
    showuidamageflash(var2);
  }

  if(isDefined(var1) && var3 > 0) {
    if(var1 scripts\mp\utility\perk::_hasperk("specialty_delayhealing")) {
      var1 thread scripts\mp\perks\perk_mark_targets::marktarget_run(var2, var5);
    }

    if(var18 && (var6 hasattachment("ammomod_slow") || var6 hasattachment("gunperk_disable") || var6 hasattachment("ammomod_wound")) && scripts\mp\utility\damage::islowerbodyshot(var9, var5, var1)) {
      var1 thread scripts\mp\perks\perkfunctions::ammodisabling_run(var2);
    }

    if(isPlayer(var2) && var1 scripts\mp\utility\perk::_hasperk("specialty_shrapnel") && isshrapnelsource(var6, var5)) {
      var2.lastshrapneltime = gettime();
    }

    if(isPlayer(var2) && isPlayer(var1)) {
      scripts\mp\gametypes\br_alt_mode_ff::play_animation_old(var1, var2);
    }
  }

  if(isDefined(level.onplayerdamaged)) {
    var2 thread[[level.onplayerdamaged]](var0, var1, var2, var3, var4, var5, var6, var15, var7, var8, var9, var10, var11, var12);
  }

  if(scripts\mp\utility\player::isreallyalive(var2)) {
    switch (var5) {
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        var2 scripts\mp\utility\stats::incpersstat("explosionsSurvived", 1);
        break;
    }

    return;
  }

  if(isDefined(var4) && var4 &level.idflags_penetration && !(var4 &level.ss_respawn)) {
    if(var1 scripts\mp\utility\game::onlinestatsenabled()) {
      var23 = var1 scripts\mp\playerstats_interface::getplayerstat("combatStats", "wallbangs") + 1;
      var1 scripts\mp\playerstats_interface::setplayerstatbuffered(var23, "combatStats", "wallbangs");
    }

    var1 scripts\mp\utility\stats::incpersstat("penetrationKills", 1);
  }
}

function meleestagger_anglesviewattack(var0, var1) {
  var2 = anglesToForward((0, var0 getplayerangles()[1], 0));
  var3 = vectorNormalize((var1.origin[0], var1.origin[1], 0) - (var0.origin[0], var0.origin[1], 0));
  return scripts\engine\math::anglebetweenvectorssigned(var2, var3, (0, 0, 1));
}

function isshrapnelsource(var0, var1) {
  if(!isDefined(var0) || nullweapon(var0)) {
    return false;
  }

  if(!isexplosivedamagemod(var1)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var0)) {
    return false;
  }

  if(scripts\mp\utility\weapon::isvehicleweapon(var0)) {
    return false;
  }

  if(scripts\mp\utility\weapon::isgamemodeweapon(var0)) {
    return false;
  }

  var2 = scripts\mp\utility\weapon::getequipmenttype(var0.basename);

  if(isDefined(var2)) {
    if(var2 != "lethal") {
      return false;
    }
  }

  return true;
}

function meleestagger(var0) {
  self endon("death_or_disconnect");
  var1 = getdvarfloat("melee_stagger_shock_duration");
  var2 = getdvarfloat("melee_stagger_aftershock_duration");
  var3 = self getviewkickscale();

  if(isDefined(level.playerzombievehiclehittoss)) {
    self setviewkickscale(scripts\engine\utility::ter_op(var0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), level.playerzombievehiclehittoss * 2, level.playerzombievehiclehittoss));
  } else {
    self setviewkickscale(scripts\engine\utility::ter_op(var0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 3, 1.5));
  }

  var4 = scripts\engine\utility::ter_op(var0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var1 * 1.5, var1);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("melee_mp", "damage", var4, 0, 0);
  var5 = 0;

  if(isDefined(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var6 = meleestagger_anglesviewattack(self, var0);

    if(var6 < 15) {
      var5 = 10;
    } else if(var6 > -15) {
      var5 = -10;
    }
  }

  var7 = scripts\engine\utility::ter_op(var0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 1.15, 1);
  self setplayerangles(self getplayerangles() + (-14 * var7, var5, 0));
  thread meleedofroutine(var0);
  self earthquakeforplayer(0.35, 0.2, self.origin, 400);
  self playrumbleonpositionforclient("plr_rumble_4_mp", self.origin);
  self setclientomnvar("ui_hud_shake", 1);
  wait 0.05;
  self setviewkickscale(var3);
  var4 = scripts\engine\utility::ter_op(var0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var2 * 1.5, var2);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("melee_mp_after", "damage", var4, 0, 0);
}

function meleedofroutine(var0) {
  self notify("resetMeleeDOF");
  self endon("resetMeleeDOF");
  self endon("death_or_disconnect");
  var1 = 1;
  var2 = 2;
  var3 = 350;
  var4 = 1024;
  self setdepthoffield(var1, var2, var3, var4, 10, 9);
  var5 = getdvarfloat("melee_stagger_shock_duration");
  wait scripts\engine\utility::ter_op(var0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var5 * 3, var5);

  while(var4 > 350) {
    var1 = clamp(var1 - 100, 0, 10000);
    var2 = clamp(var2 - 100, 0, 10000);
    var3 = clamp(var3 - 100, 0, 10000);
    var4 = clamp(var4 - 100, 0, 10000);
    self setdepthoffield(var1, var2, var3, var4, 10, 9);
    wait 0.05;
  }

  scripts\mp\utility\player::setdof_default();
}

function monitormeleeoverlay(var0) {
  scripts\engine\utility::ref_143b9(2, "death_or_disconnect");
  var0 destroy();
}

function allowdamageflash(var0, var1, var2, var3, var4) {
  if(isagent(var1)) {
    return false;
  }

  if(var4 == 0) {
    return false;
  }

  if(ref_139b6(var0, var1, var2, var3, var4)) {
    return false;
  }

  return true;
}

function ref_139b6(var0, var1, var2, var3, var4) {
  if(isDefined(var2)) {
    switch (var2.basename) {
      default:
        break;
    }
  }

  return false;
}

function ref_1458b(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var3.basename;

  if(trial_vehicle_outline_id(var7)) {
    return 1;
  }

  if(isDefined(level.disable_super_in_turret) && isDefined(var7)) {
    if(istrue(level.disable_super_in_turret.ref_146bf) && var7 == "iw8_fists_mp_zmb" || istrue(level.disable_super_in_turret.sat_wait_for_antenna) && var7 == "iw8_fists_mp_gxp") {
      return 1;
    }
  }

  if(var4 == "MOD_EXECUTION") {
    return 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "weaponIgnoresBRArmor")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "weaponIgnoresBRArmor")]](var0, var1, var2, var3, var4, var5, var6);
  }

  return 0;
}

function trial_vehicle_outline_id(var0) {
  return isDefined(var0) && var0 == "danger_circle_br";
}

function cac_modified_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var0 notify("damage_begin", var1);
  var13 = 0;
  var14 = 0;
  var15 = 0;
  var16 = var0 scripts\mp\gametypes\br_public::hasarmor();
  var17 = var0 scripts\mp\gametypes\br_public::hashelmet();

  if(isPlayer(var1) || isDefined(var1) && istrue(var1.brking_getcenterofcircle)) {
    armorvest_clearhit(var1);
    helmet_clearhit(var1);
    armorvest_clearbroke(var1);
    helmet_clearbroke(var1);
  }

  if(scripts\engine\utility::isbulletdamage(var3)) {
    var18 = var4.basename;
    var19 = scripts\mp\utility\damage::isheadshot(var7, var3, var1);
    var20 = scripts\mp\utility\damage::istorsoshot(var7, var3, var1);

    if(isDefined(var4) && scripts\mp\utility\weapon::iscacprimaryorsecondary(var18)) {
      if(isbehindmeleevictim(var1, var0) && isPlayer(var0)) {
        level thread scripts\mp\battlechatter_mp::saytoself(var0, "plr_hit_back", undefined, 0.1);
      }
    }

    if(isDefined(var10) && var10 &level.idflags_ricochet) {
      if(var18 != "none" && !scripts\mp\utility\weapon::issuperweapon(var18)) {
        var2 *= 0.4;
      }
    }

    if(isPlayer(var1) && var1 scripts\mp\utility\perk::_hasperk("specialty_paint_pro") && !var11) {
      var0 thread scripts\mp\perks\perkfunctions::setpainted(var1);
    }

    if(scripts\mp\utility\weapon::update_health_on_spawn(var18) && scripts\mp\utility\game::getgametype() == "br") {
      var2 *= scripts\mp\gametypes\br_jugg_common::reservedplacement();
    }

    var21 = var20 && var0 scripts\mp\utility\perk::_hasperk("specialty_armorvest");
    var22 = var19 && var17;
    var23 = var19 && istrue(var0.hasheadgear);
    var24 = istrue(var1.waittill_unload_complete) && scripts\mp\utility\weapon::getweaponrootname(var4) == "iw8_sn_crossbow";
    var25 = var1 scripts\mp\utility\perk::_hasperk("specialty_bulletdamage") || var24;
    var26 = scripts\mp\utility\damage::isfmjdamage(var4, var3, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nova_rounds", "hitByNovaRounds")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nova_rounds", "hitByNovaRounds")]](var1, var5, var0);
    }

    if(var22 && !istrue(var0.inlaststand)) {
      var27 = weaponclass(var4);
      var28 = 0;

      if(var27 == "sniper" || var27 == "dmr") {
        var28 = 1;
      }

      var29 = var0 scripts\mp\gametypes\br_public::damagehelmet(var2, var28, var6);
      var2 *= var29;
    }

    if(issubstr(var18, "s4_")) {
      var30 = scripts\mp\utility\damage::validshotcheck(var3, var1);
      var31 = var0.br_maxarmorhealth;
      var32 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

      if(scripts\mp\utility\game::unset_relic_grounded() && isDefined(var31)) {
        var32 += var31;
      }

      var33 = 1;
      var34 = 0;
      var35 = function_0440(var4, var2, var7, var30, var12, var32, var33, var34);
      var2 += var35 - var2;
    }

    if(var25 && var21) {
      armorvest_sethit(var1);
    } else if(var25 && var2 > 0) {
      var35 = applystoppingpower(var4, var7, var3, var1, var2, 100);
      var13 += var35 - var2;
    } else if(var21 && !istrue(var0.tookvesthit) && !var26) {
      var0.tookvesthit = 1;
      var35 = adjustbulletstokill(var2, 100, level.armorvestbulletdelta);
      var13 += var35 - var2;
      helmet_sethit(var1);
    } else if(var23 && !var26) {
      var36 = scripts\mp\perks\headgear::getdamagemod();
      var37 = scripts\mp\perks\headgear::getmaxdamage();
      var38 = int(clamp(var2 * var36, 1, var37));

      if(var0.health > 1) {
        var38 = int(min(var0.health - 1, var38));
      }

      var39 = var2 - var38;
      var13 -= var39;
      var0 notify("headgear_save");
      helmet_sethit(var1);
    }

    if(var0 scripts\mp\utility\killstreak::isjuggernaut()) {
      var2 = ref_11c90(var4, var2, var26, 0, var1);
    }

    if(isDefined(var1) && isDefined(var1.ref_14258) && var1.ref_14258 == "loot_chopper") {
      var2 = int(var2 / 3);
    }
  } else if(isexplosivedamagemod(var3)) {
    if(isPlayer(var1)) {
      if(var1 != var0 && var1 scripts\mp\utility\perk::_hasperk("specialty_paint") && !var11) {
        var0 thread scripts\mp\perks\perkfunctions::setpainted(var1);
      }
    }

    var2 = ref_11c9a(var2, var8, var4);
    var2 = scripts\mp\equipment\claymore::claymore_modifieddamage(var0, var4, var8, var3, var2);
    var2 = scripts\mp\equipment\at_mine::at_mine_modified_damage(var0, var8, var4, var3, var2);

    if(isPlayer(var1) && weaponinheritsperks(var4) && var1 scripts\mp\utility\perk::_hasperk("specialty_explosivedamage") && var0 scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {} else if(isPlayer(var1) && weaponinheritsperks(var4) && !var11 && var1 scripts\mp\utility\perk::_hasperk("specialty_explosivedamage")) {
      var13 += var2 * level.explosivedamagemod;
    } else if(var0 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var1, var0, var4, var3, var8, var7)) {
      var40 = ref_11c8f(var2, var1, var0);
      var13 -= var2 - var40;
    }

    if(isPlayer(var1) && var1 == var0 && scripts\mp\utility\weapon::iskillstreakweapon(var4)) {
      var2 *= 0.5;
    }

    if(isDefined(level.lethaldelay) && !scripts\mp\equipment::lethaldelaypassed()) {
      var2 *= level.graceperiodgrenademod;
    }

    if(isDefined(var0) && var0 scripts\mp\utility\killstreak::isjuggernaut() && isDefined(var4) && var4.basename == "semtex_aalpha12_mp") {
      var2 *= 110;
    }
  } else if(var3 == "MOD_FIRE") {
    if(var0 scripts\mp\utility\killstreak::isjuggernaut()) {
      if(isDefined(var4.basename) && var4.basename == "thermite_ap_mp" || var4.basename == "thermite_bolt_mp") {
        var2 = ref_11c90(var4, var2, 0, 1, var1);
      }
    }

    if(var0 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var1, var0, var4, var3, var8, var7)) {
      var40 = ref_11c8f(var2, var1, var0);
      var13 -= var2 - var40;
    }
  }

  var41 = ref_1458b(var1, var0, var2, var4, var3, var8, var7);
  var42 = ["MOD_GRENADE_SPLASH", "MOD_FIRE", "MOD_EXPLOSIVE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE_BULLET"];
  var43 = var7 == "shield" && !scripts\engine\utility::array_contains(var42, var3);

  if(var16 && !istrue(var41) && !istrue(var0.inlaststand) && !var43) {
    var44 = var0 scripts\mp\gametypes\br_public::damagearmor(var2);
    var45 = int(var2 - var44);
    var15 = var45;
    var13 -= var45;
    var0.tookvesthit = 1;

    if(isPlayer(var1)) {
      armorvest_sethit(var1);

      if(ref_1331e(self)) {
        var1 scripts\mp\utility\stats::incpersstat("damage", var45);
      } else if(isDefined(level.ref_12001)) {
        var1[[level.ref_12001]](var45);
      }
    } else if(isDefined(var1) && istrue(var1.brking_getcenterofcircle)) {
      armorvest_sethit(var1);
    }
  }

  var46 = scripts\mp\equipment\trophy_system::trophy_modifieddamage(var1, var0, var4.basename, var2, var13);
  var2 = var46[0];
  var13 = var46[1];

  if(var0 scripts\mp\heavyarmor::hasheavyarmor()) {
    var46 = scripts\mp\heavyarmor::heavyarmormodifydamage(var0, var1, var2, var13, var3, var4.basename, var5, var6, var7, var8, var9);
    var14 = var46[0] > 0;
    var2 = var46[1];
    var13 = var46[2];
  }

  if(scripts\mp\lightarmor::haslightarmor(var0)) {
    var46 = scripts\mp\lightarmor::lightarmor_modifydamage(var0, var1, var2, var13, var3, var4.basename, var5, var6, var7, var8, var9);
    var15 = var46[0] > 0;
    var2 = var46[1];
    var13 = var46[2];
  }

  if(isPlayer(var1) || isDefined(var1) && istrue(var1.brking_getcenterofcircle)) {
    var47 = var0 scripts\mp\gametypes\br_public::hasarmor();
    var48 = var0 scripts\mp\gametypes\br_public::hashelmet();

    if(var16 && !var47) {
      armorvest_setbroke(var1);
    }

    if(var17 && !var48) {
      helmet_setbroke(var1);
    }
  }

  if(!isPlayer(var1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("zombie", "hitByGasZombie")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("zombie", "hitByGasZombie")]](var1, var5, var0);
    }
  }

  if(scripts\mp\utility\damage::hashealthshield(var0)) {
    var2 = var0 scripts\mp\utility\damage::gethealthshielddamage(var2);
  }

  if(istrue(var0.inlaststand) && getdvarfloat("scr_player_lastStandHealthScalar", 0) > 0) {
    var49 = 1;

    if(isDefined(level.ref_11c82)) {
      var50 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, var0, var2, var4, var3, var8);
      var49 = self[[level.ref_11c82]](var50);
    }

    if(var49) {
      var2 = int(ceil(var2 / getdvarfloat("scr_player_lastStandHealthScalar", 0)));
    }
  }

  if(var2 <= 1) {
    var2 = int(ceil(clamp(var2, 0, 1)));
  } else {
    var2 = int(var2 + var13);
  }

  return [var2, var15, var14, var7];
}

function ref_11c8f(var0, var1, var2) {
  var3 = scripts\mp\utility\game::unset_relic_grounded();
  var4 = undefined;
  var5 = undefined;

  if(var3) {
    var4 = level.completed_areas;
    var5 = level.completecollectionquest;
  } else {
    var4 = level.blastshieldmod;
    var5 = level.blastshieldclamp;
  }

  var6 = int(var0 * var4);

  if(var1 != var2) {
    var6 = clamp(var6, 0, var5);
  }

  return var6;
}

function ref_11c90(var0, var1, var2, var3, var4) {
  var5 = weaponclass(var0);
  var6 = 1;

  if(isDefined(var4) && var4 scripts\mp\utility\killstreak::isjuggernaut() && scripts\mp\utility\game::getgametype() == "br") {
    var6 = scripts\mp\gametypes\br_jugg_common::remove_spawners_that_can_be_seen();
  }

  switch (var5) {
    case "smg":
    case "pistol":
      var1 = min(15, var1);
      break;
    case "mg":
    case "rifle":
      if(scripts\mp\utility\weapon::update_health_on_spawn(var0.basename) && scripts\mp\utility\game::getgametype() == "br") {
        var1 = min(50, var1);
      } else {
        var1 = min(20, var1);
      }

      break;
    case "spread":
      var1 = min(25, var1);
      break;
    case "sniper":
      break;
    default:
      var1 = min(15, var1);
      break;
  }

  var1 = int(var1 * var6);

  if(istrue(var2)) {
    var1 *= level.armorpiercingmod;
  }

  if(istrue(var3)) {
    if(var0.basename == "thermite_ap_mp") {
      var1 *= 6;
    } else if(var0.basename == "thermite_bolt_mp") {
      var1 *= 3;
    } else if(var0.basename == "thermite_xmike109_mp") {
      var1 *= 3;
    }
  }

  return var1;
}

function ref_11c9a(var0, var1, var2) {
  if(!isDefined(var1)) {
    return var0;
  }

  if(!nullweapon(var2)) {
    return var0;
  }

  if(!isDefined(var1.code_classname) || var1.code_classname != "scriptable") {
    return var0;
  }

  var3 = var1.classname;

  if(isDefined(var3) && isstartstr(var3, "scriptable_")) {
    var3 = getsubstr(var3, 11, var3.size);
    var4 = ["uk_gas_tank_thin_cylinder", "uk_misc_fuel_jug", "uk_fire_extinguisher", "uk_misc_fuel_jug", "decor_barrels_gameplay_flammable", "un_propane_gas_tank", "machinery_oxygen_generator_tank", "sol_barrel", "box_wooden_grenade", "container_gas_tank", "decor_propane_tank", "equipment_propane_burner_stove", "equipment_propane_tank", "misc_propane_rocket", "oil_drum", "rp_propane_tank", "misc_exterior_oxygen_barrel"];

    foreach(var6 in var4) {
      if(isstartstr(var3, var6)) {
        if(scripts\mp\utility\game::isanymlgmatch()) {
          return 0;
        }

        return int(min(var0, 60));
      }
    }
  }

  return var0;
}

function unsetspecialistbonus(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var0) && isPlayer(var0) && (!isalive(var0) || scripts\mp\utility\player::unset_relic_trex(var0))) {
    if(istrue(var5) && weaponclass(var4) == "spread") {
      return true;
    } else if(var2 >= var1.health) {
      if(var3 == "MOD_MELEE") {
        return true;
      } else if(istrue(var5)) {
        return true;
      }
    }
  }

  return false;
}

function tutorialzoneexit(var0, var1) {
  return isDefined(var1) && weaponclass(var1) == "rifle" && isDefined(var1.underbarrel) && issubstr(var1.underbarrel, "buckslug");
}

function usetimeoverride(var0) {
  return isDefined(var0) && weaponclass(var0) == "spread";
}

function uavworstid(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0.basename);

  if(var1 == "iw8_sn_crossbow") {
    return true;
  }

  return false;
}

function vehicle_collision_getleveldataforvehicle(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0.basename);

  if(var1 == "iw8_sn_xmike109") {
    return true;
  }

  return false;
}

function turn_on_laser_trap(var0, var1) {
  if(var0 hasattachment("calcustmags_aalpha12") && var1 == "MOD_RIFLE_BULLET") {
    return true;
  }

  return false;
}

function ref_132f0(var0) {
  if(var0 hasattachment("boltexplo_crossbow")) {
    return true;
  }

  return false;
}

function ref_1332d(var0) {
  if(var0 hasattachment("calcust", 1)) {
    return false;
  }

  return true;
}

function usefaillaststandmsg(var0) {
  if(var0.basename == "semtex_xmike109_splash_mp" || var0.basename == "thermite_xmike109_radius_mp" || var0.basename == "semtex_bolt_splash_mp" || var0.basename == "thermite_bolt_radius_mp" || var0.basename == "semtex_aalpha12_splash_mp") {
    return 1;
  }

  return 0;
}

function ref_13714(var0, var1, var2, var3, var4) {
  if(isDefined(var1) && isDefined(var0)) {
    if(var4 &level.sstablet_init) {
      var5 = "lHandWeap";
    } else {
      var5 = "rHandWeap";
    }

    if(!isDefined(var2.ref_122f1)) {
      var2.ref_122f1 = [];
    }

    var6 = "" + var1 getentitynumber();
    var7 = gettime();

    foreach(var13, var9 in var2.ref_122f1) {
      foreach(var11 in var9) {
        if((var7 - var11.time) / 1000 > 0.1) {
          var2.ref_122f1[var13] = scripts\engine\utility::array_remove_key(var2.ref_122f1[var13], var12);

          if(var2.ref_122f1[var13].size == 0) {
            var2.ref_122f1 = scripts\engine\utility::array_remove_key(var2.ref_122f1, var13);
          }
        }
      }
    }

    if(!isDefined(var2.ref_122f1[var5])) {
      var2.ref_122f1[var5] = [];
    }

    if(!isDefined(var2.ref_122f1[var5][var6])) {
      var2.ref_122f1[var5][var6] = spawnStruct();
      var2.ref_122f1[var5][var6].time = var7;
      var2.ref_122f1[var5][var6].ref_122f0 = [];
    }

    var14 = rotationentangles(var2, var3);
    var15 = var2.ref_122f1[var5][var6].ref_122f0;

    if(var2.ref_122f1[var5][var6].ref_122f0.size >= var14) {
      if(getdvarint("scr_spread_use_highest_damage_pellets", 1)) {
        foreach(var17 in var2.ref_122f1[var5][var6].ref_122f0) {
          if(var4 > var17) {
            var2.ref_122f1[var5][var6].ref_122f0[var18] = var4;
            var2.ref_122f1[var5][var6].ref_122f0 = scripts\engine\utility::array_sort_with_func(var2.ref_122f1[var5][var6].ref_122f0, &tromeo_death_watcher);
            return (var4 - var17);
          }
        }
      }

      return 0;
    } else {
      var2.ref_122f1[var5][var6].ref_122f0 = scripts\engine\utility::array_add(var2.ref_122f1[var5][var6].ref_122f0, var4);
      var2.ref_122f1[var5][var6].ref_122f0 = scripts\engine\utility::array_sort_with_func(var2.ref_122f1[var5][var6].ref_122f0, &tromeo_death_watcher);
    }
  }

  return var4;
}

function tromeo_death_watcher(var0, var1) {
  return var0 < var1;
}

function rotationentangles(var0, var1) {
  var2 = scripts\mp\utility\weapon::getweaponrootname(var1.basename);

  if(var2 == "iw8_sh_charlie725" || var2 == "iw8_pi_cpapa") {
    if(var0 isdualwielding()) {
      return 2;
    }

    if(var1 hasattachment("barshort_charlie725")) {
      return 3;
    }

    var3 = var0 playerads() > 0.5;

    if(var3) {
      return 4;
    }

    return 3;
  }

  return 4;
}

function armorvest_washit(var0) {
  return isDefined(var0.hitarmorvest) && gettime() == var0.hitarmorvest;
}

function armorvest_sethit(var0) {
  var0.hitarmorvest = gettime();
}

function armorvest_clearhit(var0) {
  var0.hitarmorvest = undefined;
}

function armorvest_wasbroke(var0) {
  return isDefined(var0.brokearmorvest) && gettime() == var0.brokearmorvest;
}

function armorvest_setbroke(var0) {
  var0.brokearmorvest = gettime();
}

function armorvest_clearbroke(var0) {
  var0.brokearmorvest = undefined;
}

function heavyarmorvest_washit(var0) {
  return isDefined(var0.‡î è + ÀúsŒàžö‚ 3× û) && gettime() == var0.‡î è + ÀúsŒàžö‚ 3× û;
}

function heavyarmorvest_sethit(var0) {
  var0.‡î è + ÀúsŒàžö‚ 3× û = gettime();
}

function heavyarmorvest_clearhit(var0) {
  var0.‡î è + ÀúsŒàžö‚ 3× û = undefined;
}

function heavyarmorvest_wasbroke(var0) {
  return isDefined(var0.¬Ù &É½ mVC + Xg— 'köœÎ+ÜŽ ) && gettime() == var0.¬Ù&É½mVC+Xg—'
    köœÎ + ÜŽ;
  }

  function heavyarmorvest_setbroke(var0) {
    var0.¬Ù &É½ mVC + Xg— 'köœÎ+ÜŽ = gettime();
  }

  function heavyarmorvest_clearbroke(var0) {
    var0.¬Ù &É½ mVC + Xg— 'köœÎ+ÜŽ = undefined;
  }

  function helmet_washit(var0) {
    return isDefined(var0.hithelmet) && gettime() == var0.hithelmet;
  }

  function helmet_sethit(var0) {
    var0.hithelmet = gettime();
  }

  function helmet_clearhit(var0) {
    var0.hithelmet = undefined;
  }

  function helmet_wasbroke(var0) {
    return isDefined(var0.brokehelmet) && gettime() == var0.brokehelmet;
  }

  function helmet_setbroke(var0) {
    var0.brokehelmet = gettime();
  }

  function helmet_clearbroke(var0) {
    var0.brokehelmet = undefined;
  }

  function applystoppingpower(var0, var1, var2, var3, var4, var5) {
    var5 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
    var6 = getbulletstokill(var5, var4);
    var7 = scripts\mp\utility\weapon::getweaponrootname(var0);

    if(var6 == 2) {
      if(ref_138f2(var0, var1, var2, var3)) {
        return var5;
      } else {
        return (0.9 * var5);
      }
    }

    var8 = -1;

    if(var6 >= 7) {
      var8 = -3;
    } else if(var6 >= 5) {
      var8 = -2;
    }

    return adjustbulletstokill(var4, var5, var8, var7);
  }

  function ref_138f2(var0, var1, var2, var3) {
    var4 = scripts\mp\utility\weapon::getweaponrootname(var0);
    var5 = weaponclass(var0);

    if(var4 == "iw8_sn_crossbow") {
      return true;
    } else if(var5 == "sniper") {
      switch (var4) {
        case "iw8_sn_sksierra":
        case "iw8_sn_mike14":
          if(scripts\mp\utility\damage::istorsouppershot(var1, var2, var3) || scripts\mp\utility\damage::isheadshot(var1, var2, var3)) {
            return true;
          }

          break;
        case "iw8_sn_sbeta":
        case "iw8_sn_delta":
        case "iw8_sn_kilo98":
          if(scripts\mp\utility\damage::istorsoshot(var1, var2, var3) || scripts\mp\utility\damage::isheadshot(var1, var2, var3)) {
            return true;
          }

          break;
        default:
          if(scripts\mp\utility\damage::isupperbodyshot(var1, var2, var3) || scripts\mp\utility\damage::isheadshot(var1, var2, var3)) {
            return true;
          }

          break;
      }
    } else if(var5 == "pistol") {
      switch (var4) {
        case "iw8_pi_decho":
        case "iw8_pi_cpapa":
          if(scripts\mp\utility\damage::istorsouppershot(var1, var2, var3) || scripts\mp\utility\damage::isheadshot(var1, var2, var3)) {
            return true;
          }

          break;
      }
    } else if(var5 == "rifle") {
      switch (var4) {
        case "iw8_ar_asierra12":
        case "iw8_ar_falima":
          if(scripts\mp\utility\damage::isheadshot(var1, var2, var3)) {
            return true;
          }

          break;
      }

      var6 = getweaponammopoolname(var0);

      switch (var6) {
        case "WEAPON/AMMO_SLUGS":
        case "WEAPON/AMMO_7_62_M67":
          if(scripts\mp\utility\damage::istorsouppershot(var1, var2, var3) || scripts\mp\utility\damage::isheadshot(var1, var2, var3)) {
            return true;
          }

          break;
      }
    }

    return false;
  }

  function adjustbulletstokill(var0, var1, var2, var3) {
    var0 = int(var0);
    var2 = int(var2);

    if(var2 == 0) {
      return var0;
    }

    if(var0 <= 0) {
      return var0;
    }

    var4 = getbulletstokill(var1, var0);
    var5 = var4 + var2;

    if(isDefined(var3) && var3 == "iw8_sn_t9accurate") {
      var0 *= 1.3;
    } else if(var5 <= 0) {
      var0 *= 1.4;
    } else if(var5 == 1) {
      var0 = int(max(var1, var0 * 1.4));
    } else {
      var6 = scripts\engine\utility::ter_op(var0 > var1, var1, var0);
      var7 = 0;

      if(var4 == 1) {
        var7 = 0.9;
      } else {
        var8 = int(ceil(var1 / (var4 - 1)));
        var9 = int(ceil(var1 / var4));
        var7 = (var6 - var9) / (var8 - var9);
      }

      var10 = int(ceil(var1 / (var5 - 1)));
      var11 = int(ceil(var1 / var5));
      var0 = int((var10 - var11) * var7 + var11);
    }

    return var0;
  }

  function getbulletstokill(var0, var1) {
    return int(ceil(var0 / var1));
  }

  function isbehindmeleevictim(var0, var1) {
    var2 = vectorNormalize((var1.origin[0], var1.origin[1], 0) - (var0.origin[0], var0.origin[1], 0));
    var3 = anglesToForward((0, var1.angles[1], 0));
    return vectordot(var2, var3) > 0.4;
  }

  function killstreakdamagefilter(var0, var1, var2, var3, var4) {
    var5 = 0;

    if(isDefined(level.playgotinfectedsoundcount)) {
      var5 = [[level.playgotinfectedsoundcount]](var0, var1, var2, var3, var4);
    }

    if(var1 scripts\mp\utility\game::isspawnprotected() || istrue(var5)) {
      var6 = int(max(var1.health / 4, 1));

      if(var2 >= var6 && scripts\mp\utility\weapon::iskillstreakweapon(var3.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var3) && var4 != "MOD_MELEE") {
        var2 = var6;
      }
    }

    return var2;
  }

  function friendlyfire_ignoresdamageattacker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
    var13 = 0;

    if(isDefined(var6)) {
      switch (var6.basename) {
        case "none":
          if(isDefined(var0) && scripts\mp\utility\entity::isdronepackage(var0)) {
            var13 = 1;
          }

          break;
        case "apache_turret_mp":
        case "trophy_mp":
          var13 = 1;
          break;
      }
    }

    return var13;
  }

  function handlefriendlyfiredamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
    if(isDefined(var6) && scripts\engine\utility::isbulletdamage(var5) && (scripts\mp\utility\weapon::iscacprimaryweapon(var6.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var6.basename))) {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var2, "check_fire_ally", undefined, 0.25);
    }

    if(isDefined(var0) && !isPlayer(var0)) {
      if(!isDefined(var1)) {
        if(isDefined(var0.owner)) {
          var1 = var0.owner;
        }
      } else if(!isPlayer(var1)) {
        if(isDefined(var0.owner)) {
          var1 = var0.owner;
        } else if(isDefined(var1.owner)) {
          var1 = var1.owner;
        }
      }
    }

    if(level.hardcoremode) {
      if(isDefined(var4) && var4 &level.idflags_ricochet && scripts\engine\utility::isbulletdamage(var5)) {
        var3 = int(var3 * 0.2);
      }
    }

    if(level.friendlyfire != 0) {
      if(level.maxallowedteamkills == -1) {
        var14 = 0;
      } else {
        var14 = istrue(var3.unset_relic_ammo_drain) || istrue(var3.isdefusing) || istrue(var3.isplanting);
      }

      var15 = unset_relic_doubletap(var2);

      if(var14 || var15) {
        var4 = int(var4 * 0.5);

        if(var4 < 1) {
          var4 = 1;
        }

        var2.lastdamagewasfromenemy = 0;
        damageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
        return 0;
      }
    }

    if(level.friendlyfire == 0 || !isPlayer(var2) && level.friendlyfire != 1 || var7.basename == "bomb_site_mp") {
      return 0;
    } else if(level.friendlyfire == 1) {
      if(var4 < 1) {
        var4 = 1;
      }

      var3.lastdamagewasfromenemy = 0;
      ref_119c0(var3, var2, var4, var6);
      finishplayerdamagewrapper(var3, var1, var2, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
      handledamagefeedback(var2, var1, var2, var3, var4, var6, var7, var10, var5, 0, 0, var14);
      return 0;
    } else if(level.friendlyfire == 2) {
      var4 = int(var4 * 0.5);

      if(var4 < 1) {
        var4 = 1;
      }

      var2.lastdamagewasfromenemy = 0;

      if(!friendlyfire_ignoresdamageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13)) {
        damageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
      }

      return 0;
    } else if(level.friendlyfire == 3) {
      var4 = int(var4 * 0.5);

      if(var4 < 1) {
        var4 = 1;
      }

      var3.lastdamagewasfromenemy = 0;
      var2.lastdamagewasfromenemy = 0;
      ref_119c0(var3, var2, var4, var6);
      finishplayerdamagewrapper(var3, var1, var2, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

      if(!friendlyfire_ignoresdamageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13)) {
        damageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
      }

      handledamagefeedback(var2, var1, var2, var3, var4, var6, var7, var10, var5, 0, 0, var14);
      return 0;
    } else if(level.friendlyfire == 4) {
      var16 = var2.pers["teamkills"] >= level.maxallowedteamkills;

      if(var16) {
        if(!friendlyfire_ignoresdamageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13)) {
          var4 = int(var4 * 0.5);

          if(var4 < 1) {
            var4 = 1;
          }

          var2.lastdamagewasfromenemy = 0;
          damageattacker(var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
        }

        return 0;
      }
    }

    return var4;
  }

  function unset_relic_doubletap(var0) {
    if(level.ingraceperiod) {
      return true;
    }

    if(var0.pers["teamkills"] > 1 && scripts\mp\utility\game::gettimepassed() < level.graceperiod * 1000 + 8000 + var0.pers["teamkills"] * 1000) {
      return true;
    }

    return false;
  }

  function damageattacker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
    if(var1 scripts\cp_mp\utility\player_utility::_isalive()) {
      var1.friendlydamage = 1;
      finishplayerdamagewrapper(var1, var0, var1, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
      var1.friendlydamage = undefined;
      return;
    }
  }

  function ref_11c5e(var0) {
    return var0 == "head" || var0 == "helmet" || var0 == "neck";
  }

  function ref_11c92(var0, var1) {
    var2 = scripts\mp\utility\weapon::getweaponrootname(var1.basename);

    if(var2 == "iw8_pi_mike9" && var1 hasattachment("akimbo_mike9") && var1 hasattachment("barburst_mike9")) {
      return (var0 * 0.75);
    }

    return var0;
  }

  function ref_11c93(var0, var1) {
    var2 = scripts\mp\utility\weapon::getweaponrootname(var1.basename);

    if(var2 == "iw8_pi_mike" && var1 hasattachment("akimbo_mike") && var1 hasattachment("barauto_mike")) {
      return (var0 * 0.75);
    }

    return var0;
  }

  function ref_11c9f(var0, var1, var2, var3, var4) {
    if(isDefined(var1)) {
      if(turn_on_laser_trap(var0, var4)) {
        if(var2.health > 0 && var3 >= var2.health) {
          var3 = var2.health - 1;
        }
      } else if(isDefined(var0.ref_136fa)) {
        if(!isDefined(var1.ref_136f5)) {
          var1.ref_136f5 = [];
        }

        var5 = "" + var2 getentitynumber();
        var6 = gettime();
        var1.ref_136f5[var5] = spawnStruct();
        var1.ref_136f5[var5].time = var6;
        var1.ref_136f5[var5].starcount = var0.ref_136fa.basename;
      } else if(isDefined(var1.ref_136f5)) {
        var6 = gettime();

        foreach(var9, var8 in var1.ref_136f5) {
          if(var6 != var8.time) {
            var1.ref_136f5 = scripts\engine\utility::array_remove_key(var1.ref_136f5, var9);
          }
        }

        var9 = "" + var2 getentitynumber();

        if(scripts\engine\utility::array_contains_key(var1.ref_136f5, var9) && var1.ref_136f5[var9].starcount == var0.basename) {
          var3 = 0;
          var1.ref_136f5 = scripts\engine\utility::array_remove_key(var1.ref_136f5, var9);
        }

        if(var1.ref_136f5.size == 0) {
          var1.ref_136f5 = undefined;
        }
      }
    }

    return var3;
  }

  function ref_11c61(var0, var1, var2, var3, var4) {
    if(scripts\mp\utility\game::isanymlgmatch() && isDefined(var0) && isPlayer(var0) && !nullweapon(var3) && scripts\mp\utility\weapon::isprimaryweapon(var3) && scripts\engine\utility::isbulletdamage(var2) && ref_11c5e(var4)) {
      switch (var3.classname) {
        case "smg":
        case "pistol":
        case "mg":
        case "rifle":
          var1 = int(clamp(var1, 0, var3.maxdamage * 1.3));
          break;
      }
    }

    return var1;
  }

  function ref_11c9b(var0, var1, var2) {
    var3 = var1;

    if(isDefined(var2) && var2 == "MOD_FALLING") {
      if(var0 scripts\mp\utility\killstreak::isjuggernaut()) {
        var3 = var0 scripts\mp\juggernaut::vehicle_deletenextframe();
      }
    }

    return var3;
  }

  function ref_11ca3(var0, var1, var2, var3, var4) {
    var5 = var3;

    if(isDefined(var0) && var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(var2 scripts\mp\utility\killstreak::isjuggernaut()) {
        var5 = var2 scripts\mp\juggernaut::vehicle_deregister_on_death(var3, var4);
      }
    }

    return var5;
  }

  function ref_11ca2(var0, var1) {
    var2 = var1;
    var3 = var0 scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var3)) {
      var2 = scripts\cp_mp\vehicles\vehicle_damage::ref_14160(var3, var0, var1);
    }

    return var2;
  }

  function ref_11c97(var0, var1, var2, var3, var4) {
    var5 = var3;

    if(isDefined(var4) && var4 == "MOD_CRUSH") {
      if(isDefined(var0) && isDefined(var1) && var0 == var1 && var1 scripts\mp\utility\killstreak::isjuggernaut() && var2 scripts\mp\utility\killstreak::isjuggernaut()) {
        var5 = var2 scripts\mp\juggernaut::vehicle_deletenextframelate(var3);
      }
    }

    return var5;
  }

  function modifydamagegeneral(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
    var3 = ref_11c92(var3, var6);
    var3 = ref_11c93(var3, var6);
    var3 = ref_11c61(var1, var3, var5, var6, var9);
    var3 = ref_11c9b(var2, var3, var5);
    var3 = ref_11ca3(var0, var1, var2, var3, var5);
    var3 = ref_11ca2(var2, var3);
    var3 = ref_11c97(var0, var1, var2, var3, var5);
    var3 = ref_11c9f(var6, var1, var2, var3, var5);

    if(var5 == "MOD_EXPLOSIVE_BULLET" && var3 != 1 && isDefined(var6) && var6 getbaseweapon().basename != "iw8_sm_t9flechette_mp") {
      var3 *= getdvarfloat("scr_explBulletMod");
      var3 = int(var3);
    }

    if(var5 == "MOD_IMPACT" && var3 != 1) {
      if(istrue(var6.isalternate) && scripts\mp\weapons::turretobjweapon(var6.underbarrel)) {
        var12 = var0 scriptableclearparententity();
        var13 = length(var12);

        if(var13 < 400) {
          var3 = 10;
        }
      }
    }

    if(isDefined(level.modifyplayerdamage)) {
      var3 = int([[level.modifyplayerdamage]](var0, var2, var1, var3, var5, var6, var7, var8, var9, var4, var11));
    }

    if(!isDefined(var2.donotmodifydamage)) {
      var3 = int(var3 * var2 scripts\cp_mp\utility\damage_utility::getdamagemodifiertotal(var0, var1, var2, var3, var5, var6, var9));
    }

    if(scripts\mp\utility\damage::isheadshot(var9, var5, var1)) {
      var5 = "MOD_HEAD_SHOT";
    }

    if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
      if(var5 == "MOD_HEAD_SHOT") {
        var3 = 150;
      }
    }

    return var3;
  }

  function handleriotshieldhits(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
    if(var8 != "shield" || istrue(var2.should_take_damage)) {
      return var3;
    }

    var12 = scripts\cp_mp\utility\damage_utility::packdamagedata(var2, var1, var3, var5, var4, var0, var6, var7, undefined, undefined, undefined, var9);
    var13 = istrue(var1.ignoreriotshieldxp);

    if(isDefined(var1.owner)) {
      var1 = var1.owner;

      if(var2 == var1) {
        return 0;
      }
    }

    if(var4 == "MOD_PISTOL_BULLET" || var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_EXPLOSIVE_BULLET") {
      if(isPlayer(var2)) {
        var2.lastattackedshieldplayer = var1;
        var2.lastattackedshieldtime = gettime();
      }

      var1 notify("shield_blocked");
      jumpiffalse(scripts\mp\utility\weapon::isenvironmentweapon(var5.basename)) LOC_000000c7;
      var14 = 25;
      goto LOC_000000fe;
    }

    var22 = isDefined(var1) && isDefined(var1.stuckenemyentity) && var1.stuckenemyentity == var2;

    if(var10 &level.idflags_shield_explosive_impact) {
      var2.forcehitlocation = "none";

      if(!(var10 &level.idflags_shield_explosive_impact_huge)) {
        var2 scripts\mp\utility\stats::incpersstat("riotShieldDamageAbsorbed", var4);
        var4 = 0;
      }
    } else if(var10 &level.idflags_shield_explosive_splash) {
      var2.forcehitlocation = "none";

      if(var2 scripts\cp_mp\utility\damage_utility::isstuckdamagekill(var13)) {
        var4 = var2.maxhealth;
      }
    } else if(istrue(var3.should_take_damage)) {
      return var4;
    } else {
      return 0;
    }

    if(var5 == "MOD_MELEE" && scripts\mp\riotshield::isriotshield(var6.basename)) {
      var2 stunplayer(0);
    }

    return var4;
  }

  function filterdamage(var0, var1, var2, var3, var4, var5, var6) {
    if(!var3) {
      return "!iDamage";
    }

    if(isDefined(level.hostmigrationtimer)) {
      return "level.hostMigrationTimer";
    }

    if(isDefined(level.validateattacker)) {
      var1 = [[level.validateattacker]](var1);
    } else {
      var1 = scripts\mp\utility\damage::_validateattacker(var1);
    }

    if(!isDefined(var1) && var4 != "MOD_FALLING") {
      return "invalid attacker";
    }

    var2 = scripts\mp\utility\damage::_validatevictim(var2);

    if(!isDefined(var2)) {
      return "invalidVictim";
    }

    if(game["state"] == "postgame") {
      return "game[ state ] == postgame";
    }

    if(isDefined(var2.sessionteam) && var2.sessionteam == "spectator") {
      return "victim.sessionteam == spectator";
    }

    if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
      if(var6 != "head" && var6 != "helmet") {
        if(var4 == "MOD_PISTOL_BULLET" || var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_EXPLOSIVE_BULLET") {
          return "getTweakableValue( game, onlyheadshots )";
        }
      }
    }

    if(scripts\cp_mp\vehicles\vehicle::ref_14201(var0, var2, var4, var5)) {
      return "playerJustExitedVehicle";
    }

    var7 = isDefined(var1) && isDefined(var1.classname) && !isDefined(var1.gunner) && (var1.classname == "script_vehicle" || var1.classname == "misc_turret" || var1.classname == "script_model");

    if(!level.teambased && var7 && isDefined(var1.owner) && var1.owner == var2) {
      if(var4 == "MOD_CRUSH") {
        var2 scripts\mp\utility\damage::_suicide();
      }

      return "ffa suicide";
    }
  }

  function logattacker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
    if(isDefined(var1) && isPlayer(var1)) {
      addattacker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    }

    if(isDefined(var1) && !isPlayer(var1) && isDefined(var1.owner) && isPlayer(var1.owner) && (!isDefined(var1.scrambled) || !var1.scrambled)) {
      addattacker(var0, var1.owner, var2, var3, var4, var5, var6, var7, var8, var9);
    } else if(isDefined(var1) && !isPlayer(var1) && isDefined(var1.secondowner) && isDefined(var1.scrambled) && var1.scrambled) {
      addattacker(var0, var1.secondowner, var2, var3, var4, var5, var6, var7, var8, var9);
    }

    if(isDefined(var2) && isDefined(var2.owner) && isDefined(var2.owner.guid) && isPlayer(var1.owner)) {
      var10 = var2.owner.team != var0.team || level.friendlyfire == 1;

      if(var10 && !istrue(var2.owner.ref_1407d) && !isDefined(self.attackerdata[var2.owner.guid])) {
        addattacker(var0, var2.owner, var2, var3, var4, var5, var6, var7, var8, var9);
      }
    }

    if(isDefined(var1)) {
      level.lastlegitimateattacker = var1;
    }

    if(isDefined(var1) && isPlayer(var1) && isDefined(var3)) {
      var1 thread scripts\mp\weapons::checkhit(var3, var0);
    }

    if(isDefined(var1) && isPlayer(var1) && isDefined(var3) && var1 != var0) {
      var1 thread scripts\mp\events::damagedplayer(self, var4);
      var0.attackerposition = var1.origin;
      return;
    }

    var0.attackerposition = undefined;
  }

  function logattackerkillstreak(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
    if(isDefined(var2) && isPlayer(var2)) {
      addattackerkillstreak(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    }

    if(isDefined(var2) && !isPlayer(var2) && isDefined(var2.owner) && (!isDefined(var2.scrambled) || !var2.scrambled)) {
      var2 = var2.owner;
      addattackerkillstreak(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    } else if(isDefined(var2) && !isPlayer(var2) && isDefined(var2.secondowner) && isDefined(var2.scrambled) && var2.scrambled) {
      var2 = var2.secondowner;
      addattackerkillstreak(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    }

    if(isDefined(var2)) {
      level.lastlegitimateattacker = var2;
    }

    if(isDefined(var2) && isPlayer(var2) && isDefined(var10) && var2 != var0) {
      var0.attackerposition = var2.origin;
      return;
    }

    var0.attackerposition = undefined;
  }

  function loggrenadedata(var0, var1, var2, var3, var4, var5) {
    if((issubstr(var4, "MOD_EXPLOSIVE") || issubstr(var4, "MOD_PROJECTILE")) && isDefined(var0) && isDefined(var1)) {
      var6 = createheadicon(var5);
      var2.explosiveinfo = [];
      var2.explosiveinfo["damageTime"] = gettime();
      var2.explosiveinfo["damageId"] = var0 getentitynumber();
      var2.explosiveinfo["returnToSender"] = 0;
      var2.explosiveinfo["counterKill"] = 0;
      var2.explosiveinfo["chainKill"] = 0;
      var2.explosiveinfo["cookedKill"] = 0;
      var2.explosiveinfo["throwbackKill"] = 0;
      var2.explosiveinfo["suicideGrenadeKill"] = 0;
      var2.explosiveinfo["weapon"] = var6;
      var7 = issubstr(var5.basename, "frag_");

      if(var1 != var2) {
        if((issubstr(var5.basename, "c4_") || issubstr(var5.basename, "proximity_explosive_") || issubstr(var5.basename, "claymore_")) && isDefined(var0.owner)) {
          var2.explosiveinfo["returnToSender"] = var0.owner == var2;
          var2.explosiveinfo["counterKill"] = isDefined(var0.wasdamaged);
          var2.explosiveinfo["chainKill"] = isDefined(var0.waschained);
          var2.explosiveinfo["bulletPenetrationKill"] = isDefined(var0.wasdamagedfrombulletpenetration);
          var2.explosiveinfo["cookedKill"] = 0;
        }

        if(isDefined(var1.lastgrenadesuicidetime) && var1.lastgrenadesuicidetime >= gettime() - 50 && var7) {
          var2.explosiveinfo["suicideGrenadeKill"] = 1;
        }
      }

      if(var7) {
        var2.explosiveinfo["cookedKill"] = isDefined(var0.iscooked);
        var2.explosiveinfo["throwbackKill"] = isDefined(var0.threwback);
      }

      var2.explosiveinfo["stickKill"] = isDefined(var0.isstuck) && var0.isstuck == "enemy";
      var2.explosiveinfo["stickFriendlyKill"] = isDefined(var0.isstuck) && var0.isstuck == "friendly";

      if(isPlayer(var1) && var1 != self && scripts\mp\utility\game::getgametype() != "aliens") {
        updateinflictorstat(var0, var1, var6);
        return;
      }

      return;
    }
  }

  function handledamagefeedback(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
    var11 = isDefined(var1) && isDefined(var1.classname) && !isDefined(var1.gunner) && (var1.classname == "script_vehicle" || var1.classname == "misc_turret" || var1.classname == "script_model");

    if(var11 && isDefined(var1.gunner)) {
      var12 = var1.gunner;
    } else if(isDefined(var2) && isDefined(var2.owner)) {
      var12 = var2.owner;
    } else {
      var12 = var3;
    }

    var13 = "standard";

    if(isDefined(var12) && var12 != var4 && var5 + var10 + var11 > 0 && (!isDefined(var8) || var8 != "shield")) {
      var14 = !var4 scripts\cp_mp\utility\player_utility::_isalive() || isagent(var4) && var5 >= var4.health;

      if(var4 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath") && isDefined(var4.inlaststand) && var4.inlaststand == 1 && !var4.hasshownlaststandicon) {
        var4.hasshownlaststandicon = 1;
        var13 = "hitlaststand";
      } else if(isPlayer(var4) && var4 method_87d3()) {
        var13 = "hitlaststand";
      } else if(istrue(var4.ref_133ef) && !armorvest_wasbroke(var3)) {
        var13 = "hitspawnprotect";
      } else if(istrue(var4.isjuggernaut)) {
        var13 = "hitjuggernaut";
      } else if(var4 scripts\mp\heavyarmor::hasheavyarmor() || var4 scripts\mp\heavyarmor::hasheavyarmorinvulnerability()) {
        var13 = "hitarmorheavy";
      } else if(var9 &level.idflags_stun) {
        var13 = "stun";
      } else if(scripts\mp\utility\damage::istacticaldamage(var7, var6) && var4 scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && !var4 scripts\mp\utility\perk::_hasperk("penalty_stun_more")) {
        var13 = "hittacresist";
      } else if(var4 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var3, var4, var7, var6, var2, var8)) {
        var13 = "hitblastshield";
      } else if(scripts\mp\utility\damage::hashealthshield(var4)) {
        var13 = "hitarmorlight";
      } else if(armorvest_wasbroke(var3) && var4 scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
        var13 = "hitarmorreinforcedbreak";
      } else if(armorvest_washit(var3) && var4 scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
        var13 = "hitarmorreinforced";
      } else if(var10 > 0 && var4 scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
        var13 = "hitarmorreinforced";
      } else if(var10 == 0 && var4 scripts\mp\utility\perk::_hasperk("specialty_br_serpentine") && (var4 issupersprinting() || var4 issprintsliding())) {
        var13 = "hitserpentine";
      } else if(armorvest_wasbroke(var3)) {
        var13 = "hitarmorlightbreak";
      } else if(helmet_wasbroke(var3)) {
        var13 = "hithelmetlightbreak";
      } else if(armorvest_washit(var3)) {
        var13 = "hitarmorlight";
      } else if(helmet_washit(var3)) {
        var13 = "hithelmetlight";
      } else if(var10 > 0) {
        var13 = "hitarmorlight";
      } else if(istrue(var4.adrenalinepoweractive)) {
        var13 = "hitadrenaline";
      } else if(var4 scripts\mp\utility\game::isspawnprotected() && var12 && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var7)) {
        var13 = "hitspawnprotect";
      }

      var15 = scripts\engine\utility::isbulletdamage(var6);
      var16 = scripts\engine\utility::ter_op(var15 && scripts\mp\utility\weapon::isprimaryweapon(var7), "standardspread", "standard");
      var17 = 0;

      if(var13 == "hitarmorreinforcedbreak") {
        var17 = 1;

        if(var16 == "standardspread") {
          var16 = "standardspreadreinforcedarmor";
        } else {
          var16 = "standardreinforcedarmor";
        }
      } else if(var13 == "hitarmorlightbreak") {
        var17 = 1;

        if(var16 == "standardspread") {
          var16 = "standardspreadarmor";
        } else {
          var16 = "standardarmor";
        }
      }

      var18 = !usetimeoverride(var7) && scripts\mp\utility\damage::isheadshot(var8, var6, var3);
      var19 = 1;
      var20 = var6 == "MOD_MELEE";
      var21 = "" + var4 getentitynumber();
      var22 = 0;

      if(!var17 && usetimeoverride(var7) && isDefined(var12.ref_122f1)) {
        foreach(var24 in var12.ref_122f1) {
          if(isDefined(var24[var21]) && var24[var21].ref_122f0.size > 1) {
            var22 = 1;
          }
        }
      }

      if(!var20 && var22) {
        if(var14) {
          var20 = 1;
        } else {
          var19 = 0;
        }
      }

      if(var19) {
        var12 thread scripts\mp\damagefeedback::updatedamagefeedback(var13, var14, var18, var16, var20);
        return;
      }

      return;
    }
  }

  function lethalequipmentdamagemod(var0, var1, var2, var3, var4, var5, var6) {
    var7 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, var2, var3, var6, var5, var0, undefined, undefined, undefined, undefined, undefined, var4);

    if(isDefined(var0) && isDefined(var0.damagedby)) {
      var1 = var0.damagedby;
    }

    if(var2 scripts\cp_mp\utility\damage_utility::isstuckdamagekill(var7)) {
      if(var2 scripts\mp\utility\killstreak::isjuggernaut()) {
        var3 = min(300, var3);
      } else {
        var3 = var2.maxhealth + scripts\engine\utility::ter_op(isDefined(self.br_armorhealth), self.br_armorhealth, 0);
      }
    }

    if(isDefined(var5) && var5 != "MOD_IMPACT") {
      if(var2 != var1 && isDefined(var0) && isDefined(var0.classname) && var0.classname == "grenade" && var2.lastspawntime + 3500 > gettime() && isDefined(var2.lastspawnpoint) && distance(var0.origin, var2.lastspawnpoint.origin) < 500) {
        var3 = 0;
      }
    }

    if(isDefined(level.ref_132a4)) {
      var3 *= [[level.ref_132a4.removelinkdamagemodifieronlaststand]](var0);
    }

    loggrenadedata(var0, var1, var2, var3, var5, var6);
    var1 scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var6), "damage", min(var2.health, var3), -1, var6);
    return var3;
  }

  function playerkilled_initdeathdata(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
    var12 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, var2, var3, var6, var5, var0, undefined, var7, undefined, undefined, undefined, var4);
    var12.hitloc = var8;
    var12.psoffsettime = var9;
    var12.deathanimduration = var10;
    var12.isfauxdeath = var11;

    if(var5 == "MOD_EXECUTION") {
      var12.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(var1);
    }

    var12.dokillcam = 0;
    var12.dofinalkillcam = 1;
    var12.killcamentity = undefined;
    var12.killcamentityindex = -1;
    var12.killcamentitystarttime = 0;
    var12.inflictoragentinfo = undefined;
    var12.killcamentstickstovictim = undefined;
    var12.isfriendlyfire = undefined;
    var12.primaryweapon = undefined;
    var12.lifeid = undefined;
    var12.attackerentnum = undefined;
    var12.iskillstreakweapon = undefined;
    var12.weaponfullstring = undefined;
    var12.isnukekill = 0;
    var12.deathscenetimesec = getdvarfloat("scr_death_scene_time", 1.75);
    var12.deathscenetimems = int(var12.deathscenetimesec * 1000);
    var12.deathtime = gettime();
    var12.enemy_monitor_trialending = undefined;
    return var12;
  }

  function playerkilled_parameterfixup(var0) {
    if(isDefined(var0.objweapon)) {}

    if(scripts\mp\utility\game::gamehasneutralcrateowner(scripts\mp\utility\game::getgametype())) {
      if(var0.victim != var0.attacker && var0.meansofdeath == "MOD_CRUSH") {
        var0.inflictor = var0.victim;
        var0.attacker = var0.victim;
        var0.meansofdeath = "MOD_SUICIDE";
        var0.objweapon.basename = "none";
        var0.hitloc = "none";
        var0.victim.attackers = [];
      }
    }

    if(var0.victim == var0.attacker && var0.meansofdeath == "MOD_CRUSH") {
      var0.meansofdeath = "MOD_SUICIDE";
    }

    if(var0.objweapon.basename == "none") {
      if(isDefined(var0.inflictor) && isDefined(var0.inflictor.baseweapon)) {
        var0.objweapon.basename = var0.inflictor.baseweapon;
      }
    }

    playerkilled_fixupattacker(var0.victim, var0);

    if(scripts\mp\utility\damage::isheadshot(var0.hitloc, var0.meansofdeath, var0.attacker)) {
      var0.meansofdeath = "MOD_HEAD_SHOT";
    }

    if(var0.isfauxdeath) {
      var0.dokillcam = 0;
      var0.deathanimduration = var0.victim playerforcedeathanim(var0.inflictor, var0.meansofdeath, var0.objweapon, var0.hitloc, var0.direction_vec);
    }
  }

  function playerkilled_fixupattacker(var0) {
    if(isDefined(level.validateattacker)) {
      var0.attacker = [[level.validateattacker]](var0.attacker);
    } else {
      var0.attacker = scripts\mp\utility\damage::_validateattacker(var0.attacker);
    }

    var1 = 0;

    if(!isDefined(var0.attacker)) {
      var1 = 1;
    } else if(isDefined(var0.attacker.classname) && (var0.attacker.classname == "trigger_hurt" || var0.attacker.classname == "worldspawn")) {
      var1 = 1;
    } else if(var0.attacker == var0.victim) {
      var1 = 1;
    }

    if(var1) {
      var2 = undefined;

      if(isDefined(var0.victim.attackers) && self.attackers.size > 0) {
        foreach(var4 in var0.victim.attackers) {
          if(!isDefined(scripts\mp\utility\damage::_validateattacker(var4))) {
            continue;
          }

          if(!isDefined(var0.victim.attackerdata[var4.guid].damage)) {
            continue;
          }

          if(var4 == var0.victim || level.teambased && var4.team == var0.victim.team) {
            continue;
          }

          if(var0.victim.attackerdata[var4.guid].damage > 1 && !isDefined(var2)) {
            var2 = var4;
            continue;
          }

          if(isDefined(var2) && var0.victim.attackerdata[var4.guid].damage > var0.victim.attackerdata[var2.guid].damage) {
            var2 = var4;
          }
        }
      }

      if(!isDefined(var2)) {
        if(isDefined(var0.victim.debuffedbyplayers) && var0.victim.debuffedbyplayers.size > 0) {
          var6 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];

          foreach(var8 in var6) {
            var9 = scripts\mp\gamescore::getdebuffattackersbyweapon(var0.victim, var8);

            if(isDefined(var9) && var9.size > 0) {
              for(var10 = var9.size - 1; var10 >= 0; var10--) {
                var11 = var9[var10];

                if(!isDefined(scripts\mp\utility\damage::_validateattacker(var11))) {
                  continue;
                }

                if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var11, var0.victim))) {
                  continue;
                }

                var2 = var11;

                if(!isDefined(var0.victim.attackerdata) || !isDefined(var0.victim.attackerdata[var2.guid])) {
                  addattacker(var0.victim, var2, undefined, getcompleteweaponname(var8), 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
                }

                break;
              }
            }

            if(isDefined(var2)) {
              break;
            }
          }
        }
      }

      if(isDefined(var2)) {
        var0.attacker = var2;
        var0.attacker.assistedsuicide = 1;
        var0.objweapon = var0.victim.attackerdata[var2.guid].objweapon;
        var0.direction_vec = var0.victim.attackerdata[var2.guid].vdir;
        var0.hitloc = var0.victim.attackerdata[var2.guid].shitloc;
        var0.psoffsettime = var0.victim.attackerdata[var2.guid].psoffsettime;
        var0.meansofdeath = var0.victim.attackerdata[var2.guid].smeansofdeath;
        var0.damage = var0.victim.attackerdata[var2.guid].damage;
        var0.primaryweapon = var0.victim.attackerdata[var2.guid].sprimaryweapon;

        if(istrue(var0.victim.ref_13749) && isDefined(var0.victim.attackerdata[var2.guid].inflictor)) {
          var0.inflictor = var0.victim.attackerdata[var2.guid].inflictor;
        }

        var0.assistedsuicide = 1;
      }
    }

    if(isDefined(var0.attacker)) {
      if(isDefined(var0.attacker.code_classname) && var0.attacker.code_classname == "script_vehicle" && isDefined(var0.attacker.owner)) {
        var0.attacker = var0.attacker.owner;
      }

      if(isDefined(var0.attacker.code_classname) && var0.attacker.code_classname == "misc_turret" && isDefined(var0.attacker.owner)) {
        if(isDefined(var0.attacker.vehicle)) {
          var0.attacker.vehicle notify("killedPlayer", var0.victim);
        }

        var0.attacker = var0.attacker.owner;
      }

      if(isagent(var0.attacker)) {
        if(isDefined(var0.attacker.owner)) {
          var0.attacker = var0.attacker.owner;
        }
      }

      if(isDefined(var0.attacker.code_classname) && var0.attacker.code_classname == "script_model" && isDefined(var0.attacker.owner)) {
        var0.attacker = var0.attacker.owner;

        if(!isfriendlyfire(var0.victim, var0.attacker) && var0.attacker != var0.victim) {
          var0.attacker notify("crushed_enemy");
        }
      }
    }

    if(isDefined(var0.inflictor) && !isPlayer(var0.inflictor)) {
      if(!isDefined(var0.attacker)) {
        if(isDefined(var0.inflictor.owner)) {
          var0.attacker = var0.inflictor.owner;
        }
      } else if(!isPlayer(var0.attacker)) {
        if(isDefined(var0.inflictor.owner)) {
          var0.attacker = var0.inflictor.owner;
        }
      }
    }

    if(isDefined(var0.attacker) && var0.attacker != var0.victim) {
      if(isDefined(var0.inflictor) && var0.inflictor == var0.victim) {
        var0.inflictor = var0.attacker;
      }
    }

    var0.attacker.assistedsuicide = 0;
  }

  function playerkilled_precalc(var0) {
    var1 = var0.attacker;
    var2 = var0.victim;
    var3 = var0.inflictor;
    var4 = var0.objweapon;
    var2.perkoutlined = 0;
    var2.deathspectatepos = undefined;
    var2.deathtime = var0.deathtime;
    var2.attacker = var1;
    var2.lastdeathpos = var2.origin;
    var2.lastdeathangles = var2 getplayerangles();

    if(!isPlayer(var3) && isDefined(var3.primaryweapon)) {
      var0.primaryweapon = var3.primaryweapon;
    } else if(isDefined(var1) && isPlayer(var1) && !nullweapon(var1 getcurrentprimaryweapon())) {
      var0.primaryweapon = createheadicon(var1 getcurrentprimaryweapon());
    } else if(var4.isalternate) {
      var0.primaryweapon = var4.basename;
    } else {
      var0.primaryweapon = undefined;
    }

    var0.lifeid = var2.matchdatalifeindex;

    if(!isDefined(var0.lifeid)) {
      var0.lifeid = level.maxlives - 1;
    }

    if(scripts\mp\utility\entity::isgameparticipant(var1)) {
      var0.attackerentnum = var1 getentitynumber();
    } else {
      var0.attackerentnum = -1;
    }

    var0.iskillstreakweapon = scripts\mp\utility\weapon::iskillstreakweapon(var4.basename);
    var0.weaponfullstring = createheadicon(var4);
    var0.isfriendlyfire = isfriendlyfire(var2, var1);
    var0.isnukekill = var4.basename == "nuke_mp";
    var0.enemy_monitor_trialending = scripts\mp\utility\player::unset_relic_trex(var2);
  }

  function playerkilled_sharedlogic_early(var0) {
    var1 = var0.attacker;
    var2 = var0.victim;
    var3 = var0.inflictor;
    var4 = var0.objweapon;
    var5 = var0.damage;
    var6 = var0.meansofdeath;
    var7 = var0.isfauxdeath;
    var8 = var0.hitloc;
    var9 = var0.direction_vec;

    if(scripts\mp\utility\weapon::unsetreduceregendelayonkills(var3) && isDefined(var4) && var4.basename == "none") {}

    var2 notify("killed_player");
    scripts\mp\outline::outlinedisableinternalall(var2);
    showuidamageflash(var2);
    var2 setblurforplayer(0, 0);
    scripts\mp\outofbounds::clearoob(var2, 1);
    var2 scripts\mp\equipment\molotov::ref_11cb6();
    var2 scripts\mp\equipment\throwing_knife_mp::ref_13b52();
    var2 scripts\cp_mp\killstreaks\nuke::ref_138db();

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      scripts\mp\utility\print::printgameaction("death", var2);
    }

    launchshield(var2, var5, var6);
    var2 scripts\mp\riotshield::riotshield_clear();

    if(var1 != var2) {
      if(isDefined(var1.petwatch)) {
        var1 scripts\cp_mp\pet_watch::addkillcharge();

        if(var6 == "MOD_EXECUTION") {
          var1 scripts\cp_mp\pet_watch::addexecutioncharge();
        } else if(ref_125f6(var2, var6, var3)) {
          var1 scripts\cp_mp\pet_watch::bhasriotshieldattached();
        }
      } else if(isDefined(var2.ref_12313)) {
        var2 scripts\cp_mp\utility\callback_group::onplayerkilled(var1);
      }
    }

    if(var6 == "MOD_EXECUTION") {
      var1 scripts\mp\utility\stats::incpersstat("executionKills", 1);

      if(isDefined(var1.operatorcustomization.title) && var1.operatorcustomization.title == "s4") {
        var10 = "flavor_s4_quip";
      } else {
        var10 = "flavor_execution";
      }

      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var2, var10, undefined, 1);
    }

    var11 = var3 getcurrentweapon();

    if(!var3 scripts\mp\utility\weapon::iskillstreakweapon(var11)) {
      scripts\mp\weapons::savetogglescopestates();
      scripts\mp\weapons::savealtstates();
    }

    var3 scripts\mp\equipment\nvg::savenvgstate();
    scripts\mp\utility\inventory::handleweaponchangecallbacksondeath();

    if(!var8) {
      if(isDefined(var3.endgame)) {
        scripts\mp\utility\player::restorebasevisionset(2);
      } else {
        scripts\mp\utility\player::restorebasevisionset(0);
        var3 thermalvisionoff();
      }
    } else {
      var3.fauxdead = 1;
      var3 vehiclepinonminimap(1);
      self notify("death");
      self notify("death_or_disconnect");
    }

    scripts\mp\perks\perks::updateactiveperks(var4, var2, var3, var6, var7, var5, var9, var10);
    scripts\mp\supers::updateactivesupers(var4, var2, var3, var6, var7, var5, var9, var10);
    scripts\mp\equipment\wristrocket::wristrocketcooksuicideexplodecheck(var4, var2, var3, var7, var5);

    if(var7 != "MOD_HEAD_SHOT" && !var1.isnukekill) {
      if(isDefined(level.custom_death_sound)) {
        [[level.custom_death_sound]](var3, var7, var4);
      } else if(var7 != "MOD_MELEE") {
        var3 scripts\mp\utility\sound::playdeathsound(var7);
      }
    }

    if(isDefined(level.custom_death_effect)) {
      [[level.custom_death_effect]](var3, var7, var4);
    }

    if(var7 != "MOD_SUICIDE" && (scripts\mp\utility\entity::isaigameparticipant(var3) || scripts\mp\utility\entity::isaigameparticipant(var2)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
      var12 = [[level.bot_funcs["get_attacker_ent"]]](var2, var4);

      if(isDefined(var12)) {
        if(scripts\mp\utility\entity::isaigameparticipant(var3)) {
          var3 botmemoryevent("death", var1.weaponfullstring, var12.origin, var3.origin, var12);
        }

        if(scripts\mp\utility\entity::isaigameparticipant(var2)) {
          var13 = 1;

          if(isDefined(var12.classname) && (var12.classname == "script_vehicle" && isDefined(var12.helitype) || var12.classname == "rocket" || var12.classname == "misc_turret")) {
            var13 = 0;
          }

          if(var13) {
            var2 botmemoryevent("kill", var1.weaponfullstring, var12.origin, var3.origin, var3);
          }
        }
      }
    }

    if((scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "br") && scripts\mp\flags::gameflag("prematch_done") && !istrue(var3.hvtnorevive) && istrue(var3.inlaststand)) {
      scripts\mp\laststand::ondeath(var1);
    }

    if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")) {
      if(var7 == "MOD_FALLING" && var3 scripts\mp\teamrevive::isvalidrevivetriggerspawnposition()) {
        var3 scripts\mp\teamrevive::ref_13285();
      }

      var14 = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

      if(!var14) {
        var15 = var3 scripts\mp\class::respawnitems_saveplayeritemstostruct();
      } else {
        var15 = self.juggcontext;
      }

      var4 scripts\mp\class::respawnitems_assignrespawnitems(var15);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
        var4 scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_in_gas");
        var4 scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_not_downed");

        if(istrue(level.br_prematchstarted) && !scripts\mp\gametypes\br_public::isplayeringulag()) {
          scripts\mp\gametypes\br_analytics::destroyscorelaunchonly(self, "player_death");
        }
      }
    }

    var16 = scripts\engine\utility::ter_op(scripts\mp\utility\killstreak::isplayerkillstreak(var4), var4.playerproxyagent, var4);

    if(var3 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var16 thread scripts\mp\weapons::dropscavengerfordeath(var3, var2.meansofdeath);
    }

    var16[[level.weapondropfunction]](var3, var8, undefined, var7);

    if(!var9) {
      var4 scripts\mp\utility\player::updatesessionstate("dead");

      if(isPlayer(var3)) {
        var4 setclientomnvar("ui_killcam_killedby_id", var3 getentitynumber());
      } else if(isDefined(var3.classname) && (var3.classname == "trigger_hurt" || var3.classname == "worldspawn")) {
        var4 setclientomnvar("ui_killcam_killedby_id", var4 getentitynumber());
      } else if(isagent(var3)) {
        if(isDefined(var3.asm) && var3.asm.archetype == "soldier_lw_br") {
          var4 setclientomnvar("ui_killcam_killedby_id", -1);
        }
      }
    }

    var17 = istrue(var4.fauxdead) && istrue(var4.switching_teams);

    if(!var17) {
      if(!isDefined(level.ref_11c76) || [[level.ref_11c76]](var4)) {
        var4 scripts\mp\playerlogic::removefromalivecount(0, "playerKilled");
      }
    }

    if(!isDefined(var4.switching_teams)) {
      if(!istrue(level.ignorescoring) && !var2.isfriendlyfire) {
        var4 scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "deaths");

        if(var4.pers["deaths"] < 999) {
          var4 scripts\mp\utility\stats::incpersstat("deaths", 1);
          var4.deaths = var4 scripts\mp\utility\stats::getpersstat("deaths");
          var4 scripts\mp\persistence::statsetchild("round", "deaths", var4.deaths, level.ignorekdrstats);
        }
      }
    }

    var18 = var8;

    if(isDefined(var2.idflags) && var2.idflags &level.idflags_penetration && !(var2.idflags &level.ss_respawn)) {
      if(isDefined(var3.bulletkillsinaframecount) && var3.bulletkillsinaframecount == 0) {
        var18 = "MOD_PENETRATION";

        if(isPlayer(var3)) {
          if(var6 hasattachment("gunperk_driller")) {
            var19 = scripts\mp\rank::getscoreinfovalue("penetration_kill") * getdvarfloat("scr_gunperk_driller_xp_bonus", 2);
            var3 thread scripts\mp\utility\points::sec_sys_struct_1("penetration_kill", var19);
          } else {
            var3 thread scripts\mp\utility\points::sec_sys_struct_1("penetration_kill");
          }
        }
      }
    } else if((var6.basename == "semtex_xmike109_mp" || var6.basename == "semtex_aalpha12_mp") && var2.hitloc == "head" || var2.hitloc == "helmet") {
      var18 = "MOD_HEAD_SHOT";
    }

    if(isDefined(var2.inflictor) && (istrue(var2.inflictor.vehicle_collision_getignoreevent) || istrue(var2.inflictor.vehicle_collision_geteventdata))) {
      var18 = "MOD_CRUSH";
    }

    if(level.gametype == "br") {
      var20 = [];

      if(isDefined(var4)) {
        var21 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var4.team, var4.squadindex);

        if(isDefined(var21)) {
          var20 = var21;
        }
      }

      if(isDefined(var3) && isPlayer(var3)) {
        var22 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var3.team, var3.squadindex);

        if(isDefined(var22) && var4.team != var3.team) {
          var20 = scripts\engine\utility::array_combine(var22, var20);
        }
      }

      if(var20.size > 0) {
        var23 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::ref_14104(var2), "MOD_EXPLOSIVE", var18);

        if(getdvarint("scr_br_alt_mode_zxp", 0) || getdvarint("scr_br_alt_mode_gxp", 0)) {
          var23 = scripts\mp\gametypes\br_gametype_zxp::ref_11ba8(var2, var23);
        }

        obituary(var4, var3, var6, var23, var20);
      }
    } else {
      var24 = var6;

      if(isDefined(var18) && var18 == "MOD_EXPLOSIVE" && (!isDefined(var24) || nullweapon(var24))) {
        var24 = getcompleteweaponname("obit_explosive");
      }

      var23 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::ref_14104(var2), "MOD_EXPLOSIVE", var18);
      obituary(var4, var3, var24, var23);
    }

    updatedeathdetails(var4, var4.attackers, var4.attackerdata, var3);
    var4.lastbounty = scripts\mp\bounty::playergetbountypoints();
    var4 scripts\mp\bounty::playerresetbountypoints();
    var4 scripts\mp\bounty::playerresetbountystreak();
    var4 thread scripts\mp\supers::handledeath();
    var4 scripts\mp\battlechatter_mp::onplayerkilled(var5, var3, var7, var8, var6, var2.direction_vec, var2.hitloc, var2.psoffsettime, var2.deathanimduration, var2.lifeid);
    var4 thread[[level.onplayerkilledcommon]](var5, var3, var7, var8, var6, var2.direction_vec, var2.hitloc, var2.psoffsettime, var2.deathanimduration, var2.lifeid, scripts\mp\utility\weapon::iskillstreakweapon(var14));

    if(isai(var4) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
      var4 thread[[level.bot_funcs["on_killed"]]](var5, var3, var7, var8, var2.weaponfullstring, var2.direction_vec, var2.hitloc, var2.psoffsettime, var2.deathanimduration, var2.lifeid);
    }

    var25 = (var2.deathtime - var4.spawntime) / 1000;

    if(isDefined(var4.pers["shortestLife"])) {
      if(var4.pers["shortestLife"] == 0 || var25 < var4.pers["shortestLife"]) {
        var4.pers["shortestLife"] = var25;
      }
    }

    if(isDefined(var4.pers["shortestLife"])) {
      if(var4.pers["longestLife"] == 0 || var25 > var4.pers["longestLife"]) {
        var4.pers["longestLife"] = var25;
      }
    }
  }

  function playerkilled_logkill(var0) {
    var1 = var0.attacker;
    var2 = var0.victim;
    var3 = var0.inflictor;
    var4 = var0.objweapon;
    var5 = var0.weaponfullstring;
    var6 = var0.meansofdeath;
    var7 = var0.lifeid;
    var2 scripts\common\utility::ref_13e0a(level.heavydamageawardlaunchonly, var1);

    if(!istrue(level.ignorescoring)) {
      var2 scripts\common\utility::ref_13e0a(level.ref_11b2d, var7, var1, var0.damage, var6, var5, var0.primaryweapon, var0.hitloc, var4);
    }

    var2 scripts\mp\analyticslog::logevent_path();
    var2 scripts\mp\analyticslog::logevent_playerdeath(var1, var6, var5);

    if(isPlayer(var1)) {
      var1 scripts\mp\analyticslog::logevent_playerkill(var2, var6, var5);
    }

    if(isPlayer(var1) && var1 != self && (!level.teambased || level.teambased && self.team != var1.team)) {
      var8 = var2.lastdroppableweaponobj;
      var8 = scripts\mp\utility\weapon::mapweapon(var8, var3);
      var9 = createheadicon(var8);
      thread scripts\mp\gamelogic::trackleaderboarddeathstats(var1, var2, var9, var6);
      thread scripts\mp\gamelogic::trackattackerleaderboarddeathstats(var1, var2, var5, var6);
    }

    if(isDefined(level.matchrecording_logeventmsg) && isDefined(var3) && isPlayer(var3) && scripts\engine\utility::isbulletdamage(var6)) {
      var10 = var3.origin - var2.origin;
      var11 = vectorNormalize((var10[0], var10[1], 0));
      var12 = anglesToForward(var2.angles);
      var13 = vectorNormalize((var12[0], var12[1], 0));
      var14 = clamp(var13[0] * var11[0] + var13[1] * var11[1], -1, 1);
      var15 = acos(var14);

      if(!isDefined(var2.ref_1338f)) {
        var2.ref_1338f = 0;
      }

      if(var15 > 75) {
        var2.ref_1338f++;
      }

      var16 = 0;

      if(isDefined(var2.engagementstarttime)) {
        var16 = gettime() - var2.engagementstarttime;
      }

      if(!isDefined(var2.nuke_hostmigration_waitlongdurationwithpause)) {
        var2.nuke_hostmigration_waitlongdurationwithpause = 0;
        var2.nuke_explposstruct = 0;
      }

      var2.nuke_hostmigration_waitlongdurationwithpause += var16;
      var2.nuke_explposstruct++;
      var2.engagementstarttime = undefined;
    }

    updatecombatrecordkillstats(var1, var2, var6, var4);
  }

  function playerkilled_finddeathtype(var0) {
    var1 = var0.attacker;
    var2 = var0.victim;
    var3 = var0.inflictor;
    var4 = var0.meansofdeath;

    if(isswitchingteams(var2)) {
      return "deathType_switchingTeams";
    }

    if(!isPlayer(var1) || isPlayer(var1) && var4 == "MOD_FALLING") {
      return "deathType_worldDeath";
    }

    if(var1 == var2 || !scripts\cp_mp\utility\player_utility::playersareenemies(var1, var2) && scripts\mp\utility\entity::isdronepackage(var3)) {
      return "deathType_suicide";
    }

    if(var0.isfriendlyfire && var0.objweapon.basename != "bomb_site_mp" && !var0.isnukekill) {
      return "deathType_friendlyFire";
    }

    if(istrue(var2.inlaststand)) {
      return "deathType_inLastStand";
    }

    return "deathType_normal";
  }

  function playerkilled_handledeathtype(var0) {
    var1 = var0.victim;
    var0.deathtype = playerkilled_finddeathtype(var0);

    switch (var0.deathtype) {
      case "deathType_switchingTeams":
        handleteamchangedeath();
        break;
      case "deathType_worldDeath":
        handleworlddeath(var0, var0.attacker, var0.lifeid, var0.meansofdeath, var0.hitloc);
        break;
      case "deathType_suicide":
        handlesuicidedeath(var0.meansofdeath, var0.hitloc);
        break;
      case "deathType_friendlyFire":
        handlefriendlyfiredeath(var0.attacker, var0.victim);
        break;
      case "deathType_inLastStand":
        handleinlaststanddeath(var0);
        break;
      case "deathType_normal":
        handlenormaldeath(var0.lifeid, var0.attacker, var0.inflictor, var0.objweapon, var0.meansofdeath, var1, var0.iskillstreakweapon, var0);
        break;
      default:
        break;
    }
  }

  function playerkilled_sharedlogic_late(var0) {
    playerkilled_handlecorpse(var0);
    setdeathtimerlength(var0);
    var1 = var0.attacker;

    if(isDefined(var1.owner)) {
      var1 = var1.owner;
    }

    if(!isPlayer(var1)) {
      var0.dokillcam = 0;
      var0.dofinalkillcam = 0;
    }

    playerkilled_killcamsetup(var0);

    if(scripts\mp\utility\game::getgametype() == "br") {
      scripts\mp\gametypes\br_analytics::branalytics_down(var0.attacker, var0.victim, var0.objweapon, var0.deathtype, var0.meansofdeath);
    }

    thread scripts\cp\vehicles\vehicle_compass_cp::ondeath(var0.inflictor, var0.attacker, var0.damage, var0.damageflags, var0.meansofdeath, var0.objweapon, var0.hitloc, var0.attacker.modifiers);

    if(!scripts\mp\utility\game::runleanthreadmode() || getdvarint("scr_runlean_playerthread_allow_logkill", 1)) {
      playerkilled_logkill(var0);
    }
  }

  function playerkilled_handlecorpse(var0) {
    var1 = var0.attacker;
    var2 = var0.victim;
    var3 = var0.inflictor;
    var4 = var0.meansofdeath;
    var5 = var0.objweapon;
    var2 setscriptablepartstate("watchVFXPlayer", "off");
    scripts\cp_mp\vehicles\vehicle::vehicle_playerkilledbycollision(var0);

    if(!isDefined(self.nocorpse) && !istrue(var2.ref_133c8)) {
      var2.body = var2 cloneplayer(var0.deathanimduration, var1);
    }

    if(!isDefined(self.nocorpse) && !istrue(var2.ref_133c8) && isDefined(var2.body)) {
      var2.body.targetname = "player_corpse";

      if(var0.isnukekill) {}

      enqueueweapononkillcorpsetablefuncs(var1, var2, var3, var5, var4);
      thread callcorpsetablefuncs();

      if(var0.isfauxdeath) {
        var2 playerhide();
        var2 setsolid(0);
      }

      if(!isDefined(var2.switching_teams)) {
        if(isDefined(var1) && isPlayer(var1)) {
          thread scripts\mp\deathicons::adddeathicon(var1, var2.body, var2, var2.team, 5);
        }

        var6 = [];

        foreach(var8 in level.players) {
          if(isDefined(var2) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var8, var2)) && var8 scripts\mp\utility\perk::_hasperk("specialty_kill_report")) {
            var6 = var8;
          }
        }

        if(var6.size > 0) {
          thread scripts\mp\deathicons::addenemydeathicon(var2.body, var2, var6, getdvarfloat("perk_kill_report_icon_time"), 1);
        }
      }

      thread _startragdoll(var2, var0.victim.body, var0.meansofdeath);
    } else if(isDefined(var2.nocorpse) && !istrue(var2.ref_133c8)) {
      var2.body = var2 cloneplayer(var0.deathanimduration);
      var2.body hide(1);
    }

    if(!istrue(game["isLaunchChunk"])) {
      var2.streaktype = scripts\mp\class::loadout_getplayerstreaktype(var2.streaktype);

      if(scripts\mp\killstreaks\killstreaks::streaktyperesetsondeath(var2.streaktype)) {
        if(!level.casualscorestreaks && !var2 scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
          var2 scripts\mp\killstreaks\killstreaks::resetstreakpoints();
          var2 scripts\mp\killstreaks\killstreaks::resetstreakavailability();
          return;
        }

        if(level.casualscorestreaks) {
          var10 = scripts\mp\killstreaks\killstreaks::checkcasualstreaksreset();

          if(var10) {
            var2 scripts\mp\killstreaks\killstreaks::resetstreakpoints();
            var2 scripts\mp\killstreaks\killstreaks::resetstreakavailability();
            return;
          }

          return;
        }

        return;
      }

      return;
    }
  }

  function _startragdoll(var0, var1, var2) {
    if(!isDefined(var0)) {
      return;
    }

    var0 endon("death");

    if(getdvarint("NOONKKQQT", 0) && isDefined(var1) && (var1 == "MOD_GRENADE" || var1 == "MOD_EXPLOSIVE" || var1 == "MOD_GRENADE_SPLASH" || var1 == "MOD_PROJECTILE_SPLASH")) {
      var0 method_87c0(1);
    }

    var3 = var0 getcorpseanim();
    var4 = 0;

    if(animisleaf(var3)) {
      var4 = getanimlength(var3);
    }

    var5 = undefined;
    var6 = scripts\cp_mp\utility\player_utility::getvehicle();
    var7 = ref_125f6(var1, var2);
    var8 = undefined;
    var9 = animhasnotetrack(var3, "delete_corpse");
    var10 = animhasnotetrack(var3, "delete_corpse_delayed");
    var11 = animhasnotetrack(var3, "no_ragdoll");
    var12 = animhasnotetrack(var3, "start_ragdoll");

    if(isDefined(var6)) {
      var8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var6, self);

      if(var11 || var12) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(var0, var6, var8);
        var0 setcorpsefalling(0);
        var0.x1ops = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e7(var6, var8);
      }

      if(var9 || var10 || var11 || var12) {
        var13 = scripts\engine\utility::ter_op(var11 || var12, 0, 1);
        var14 = scripts\engine\utility::ter_op(var10, var4, var4 + 3);
        thread playerkilled_deletecorpseoutofvehicle(var0, var6, var8, var14, var13);
      }
    }

    if(var1 != "mod_execution" && !var11) {
      var5 = 0;

      if(var12 && var4 > 0) {
        var15 = getnotetracktimes(var3, "start_ragdoll")[0];
        var5 = var15 * var4;
      }

      if(var7) {
        var5 = 0;
      }
    }

    if(isDefined(var5)) {
      wait var5;

      if(!isDefined(var0)) {
        return;
      }

      if(isDefined(var6)) {
        thread any_rider_still_alive_at_seat(var0, var6, var8, var9, var10, var5);
        var0 notify("cancel_delete_corpse");
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141cc(var0, var6, var8);
        return;
      }

      if(!var0 isragdoll()) {
        if(var7) {
          var0 vehswitchseatbuttonPressed(var2);
        } else {
          var0 startragdoll();
        }
      }

      thread adson(var0, var9, var10, var5);
      return;
    }
  }

  function adson(var0, var1, var2, var3) {
    var4 = self;

    if(var0 || var1) {
      var5 = var3;

      if(var1) {
        var3 += 3;
      }

      if(isDefined(var2)) {
        var5 -= var2;
      }

      wait var5;

      if(!isDefined(var4)) {
        return;
      }

      var4 delete();
      return;
    }

    if(!scripts\mp\utility\game::isteamreviveenabled() && !isagent(self)) {
      var4 setplayercorpsedone();
      return;
    }
  }

  function any_rider_still_alive_at_seat(var0, var1, var2, var3, var4, var5) {
    var6 = self;
    var7 = getdvarint("scr_ragdollBeforeUnlink", 1);
    var8 = !var7;
    var9 = getdvarint("scr_ragdollImmediate", 1);

    if(var7) {
      if(!var6 isragdoll()) {
        var6 startragdoll(var9);
      }
    }

    var10 = getdvarfloat("scr_ragdollUnlinkWait", 0.1);

    if(var10 > 0) {
      wait var10;
    }

    if(isDefined(var6)) {
      if(isDefined(var6.x1ops) && isDefined(var0)) {
        var11 = (0, 0, 0);
        var12 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141e7(var0, var1);
        var11 = var12.origin - var6.x1ops.origin;
        var13 = var6.origin + var11;
        var14 = var12.angles;
        var6 getcovertacpoint(var13, var14);
      }

      var6 unlink();

      if(var8) {
        var6 startragdoll(var9);
      }

      thread adson(var6, var2, var3, var4);
      return;
    }
  }

  function anim_offset(var0, var1, var2) {
    if(!isDefined(var0)) {
      return;
    }

    var0 endon("death");
    var3 = var0 getcorpseanim();
    var4 = undefined;
    var5 = getanimlength(var3);
    var6 = scripts\cp_mp\utility\player_utility::getvehicle();
    var7 = var1 == "MOD_CRUSH" && isDefined(var2) && isDefined(var2.vehiclename);

    if(!var7) {
      var8 = animhasnotetrack(var3, "delete_corpse");
      var9 = animhasnotetrack(var3, "delete_corpse_delayed");
      var10 = animhasnotetrack(var3, "no_ragdoll");
    } else {
      var8 = 0;
      var9 = 0;
      var10 = 0;
    }

    if(isDefined(var9)) {
      var11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var9, self);

      if(var10) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(var3, var9, var11);
      }

      if(var8 || var9) {
        var12 = scripts\engine\utility::ter_op(var9, var8, var8 + 3);
        thread playerkilled_deletecorpseoutofvehicle(var3, var9, var11, var12);
      }
    }

    if(var4 != "mod_execution" && !var10) {
      var7 = 0;

      if(animhasnotetrack(var6, "start_ragdoll")) {
        var13 = getnotetracktimes(var6, "start_ragdoll")[0];
        var7 = var13 * var8;
      }
    }

    if(var10) {
      var7 = 0;
    }

    if(isDefined(var7)) {
      if(var7 > 0) {
        wait var7;
      }

      if(!var3 isragdoll()) {
        if(!var10) {
          var3 startragdoll();
        } else {
          var3 vehswitchseatbuttonPressed(var5);
        }
      }
    }

    if(var8 || var9) {
      if(!var10) {
        var14 = var8;

        if(var9) {
          var8 += 3;
        }

        if(isDefined(var7)) {
          var14 -= var7;
        }

        wait var14;
      }

      var3 delete();
      return;
    }

    if(!scripts\mp\utility\game::isteamreviveenabled()) {
      var3 setplayercorpsedone();
      return;
    }
  }

  function playerkilled_deletecorpseoutofvehicle(var0, var1, var2, var3, var4) {
    var0 endon("death");
    var0 endon("cancel_delete_corpse");
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_assignseatcorpse(var0, var1, var2, var4);
    var1 scripts\engine\utility::ref_143b9(var3, "death");

    if(isDefined(var0)) {
      var0 delete();
      return;
    }
  }

  function ref_125f6(var0, var1) {
    if(var0 != "MOD_CRUSH") {
      return false;
    }

    if(!isDefined(var1)) {
      return false;
    }

    if(!var1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      return false;
    }

    return true;
  }

  function playerkilled_killcamsetup(var0) {
    var1 = var0.attacker;
    var2 = var0.victim;
    var3 = var0.inflictor;
    var4 = var0.meansofdeath;
    var5 = var0.objweapon;
    var6 = var0.executionref;

    if(var0.attacker.assistedsuicide || level.teambased && isDefined(var1.team) && var1.team == var2.team) {
      var0.dokillcam = 0;
      var0.dofinalkillcam = 0;
    }

    if(!isDefined(var0.killcamentity)) {
      var0.killcamentity = var2 scripts\mp\killcam::getkillcamentity(var1, var3, var5, var4);
    }

    if(isDefined(var0.killcamentity)) {
      var0.killcamentityindex = var0.killcamentity getentitynumber();
      var0.killcamentitystarttime = var0.killcamentity.birthtime;

      if(!isDefined(var0.killcamentitystarttime)) {
        var0.killcamentitystarttime = 0;
      }
    }

    if(var0.dokillcam) {
      var2 scripts\mp\killcam::prekillcamnotify(var1);

      if(isDefined(var3) && isagent(var3)) {
        var0.inflictoragentinfo = spawnStruct();
        var0.inflictoragentinfo.agent_type = var3.agent_type;
        var0.inflictoragentinfo.lastspawntime = var3.lastspawntime;
      }
    }

    var0.killcamentstickstovictim = var4 == "MOD_IMPACT" || var4 == "MOD_HEAD_SHOT" && isDefined(var3) || var4 == "MOD_GRENADE" || isDefined(var2) && isDefined(var2.stuckbygrenade) && isDefined(var3) && var2.stuckbygrenade == var3 || var5.basename == "throwingknifec4_mp";

    if(!var0.iskillstreakweapon) {
      scripts\mp\killcam::setkillcamnormalweaponomnvars(var5, var4, var3, var6);
    }

    if(level.recordfinalkillcam && var0.dofinalkillcam) {
      if((!isDefined(level.disable_killcam) || !level.disable_killcam) && var4 != "MOD_SUICIDE" && !(!isDefined(var1) || var1.classname == "trigger_hurt" || var1.classname == "worldspawn" || var1 == var2)) {
        scripts\mp\final_killcam::recordfinalkillcam(5, var2, var1, var0.attackerentnum, var3, var0.killcamentityindex, var0.killcamentitystarttime, var0.killcamentstickstovictim, var5, var0.psoffsettime, var4);
      }
    }
  }

  function playerkilled_deathscene(var0) {
    var1 = var0.victim;
    var1 endon("spawned");

    if(!var0.isfauxdeath) {
      if(!isDefined(var1.respawntimerstarttime)) {
        var1.respawntimerstarttime = gettime() + var0.deathscenetimems;
      }

      wait var0.deathscenetimesec;

      if(var0.dokillcam) {
        var0.dokillcam = !scripts\mp\final_killcam::skipkillcamduringdeathtimer(0.5);
      }

      var1 notify("death_delay_finished");
      return;
    }

    if(!isDefined(var1.respawntimerstarttime)) {
      var1.respawntimerstarttime = gettime();
      return;
    }
  }

  function playerkilled_killcam(var0) {
    var1 = var0;
    var2 = var1.victim.deathtime;

    if(getdvarint("scr_killcam_on_down", 1) && isDefined(var1.victim.watch_for_driver_spawned)) {
      var1 = var1.victim.watch_for_driver_spawned;
      var1.victim.watch_for_driver_spawned = undefined;
      var1.dokillcam = var0.dokillcam;
      var2 = var1.deathtime;
    }

    var1.victim endon("spawned");
    var3 = var1.victim;
    var4 = var1.attacker;
    var5 = (gettime() - var2) / 1000;

    if(isDefined(level.ref_11c8b)) {
      [[level.ref_11c8b]](var1);
    }

    if(!(isDefined(var3.cancelkillcam) && var3.cancelkillcam) && var1.dokillcam && level.killcam && game["state"] == "playing" && !var3 scripts\mp\utility\player::isusingremote() && !level.showingfinalkillcam) {
      var6 = scripts\mp\playerlogic::timeuntilspawn(1);

      if(!isDefined(var4) || !isDefined(var4.pers)) {
        var7 = [];
      } else {
        var7 = var5.pers["loadoutPerks"];
      }

      if(!istrue(level.disablecopycatloadout)) {
        thread startcopycatoption(var4);
      }

      var8 = 1;
      var4 scripts\mp\killcam::killcam(var2.inflictor, var2.inflictoragentinfo, var2.attackerentnum, var2.killcamentityindex, var2.killcamentitystarttime, undefined, var2.killcamentstickstovictim, var2.objweapon, var6, var2.psoffsettime, var7, scripts\mp\gamelogic::timeuntilroundend(), var5, var4, var2.meansofdeath, var7, var8);

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

  function playerkilled_spawn(var0) {
    if(isDefined(level.ref_11c7a) && [[level.ref_11c7a]](var0, 1)) {
      return;
    }

    var1 = var0.victim;
    var1 endon("spawned");
    var1 endon("disconnect");
    var2 = var0.attacker;
    resetplayervariables(var1);
    resetplayeromnvarsonspawn(var1);

    if(isDefined(var2)) {
      var1.lastattacker = var2;
    } else {
      var1.lastattacker = undefined;
    }

    var1.wantsafespawn = 0;

    if(game["state"] != "playing") {
      if(!level.showingfinalkillcam) {
        var1 scripts\mp\utility\player::updatesessionstate("dead");
        var1 scripts\mp\utility\player::clearkillcamstate();
      }

      return;
    }

    if(scripts\mp\class::isvalidclass(var1.class)) {
      var1 thread scripts\mp\playerlogic::spawnclient();
      return;
    }
  }

  function playerkilled_internal(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
    var2 endon("spawned");

    if(game["state"] == "postgame") {
      return;
    }

    var12 = playerkilled_initdeathdata(var2, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    playerkilled_parameterfixup(var12);
    playerkilled_precalc(var12);
    playerkilled_sharedlogic_early(var12);
    playerkilled_handledeathtype(var12);
    playerkilled_sharedlogic_late(var12);
    playerkilled_deathscene(var12);
    playerkilled_killcam(var12);
    playerkilled_spawn(var12);
  }

  function isswitchingteams() {
    if(isDefined(self.switching_teams)) {
      return true;
    }

    return false;
  }

  function isteamswitchbalanced() {
    var0 = scripts\mp\teams::countplayers();
    GscBinSkip0(0x2e, self.leaving_team);
  }

  function isfriendlyfire(var0, var1) {
    if(!level.teambased) {
      return false;
    }

    if(!isDefined(var1)) {
      return false;
    }

    if(!isPlayer(var1) && !isDefined(var1.team)) {
      return false;
    }

    if(var0.team != var1.team) {
      return false;
    }

    if(var0 == var1) {
      return false;
    }

    return true;
  }

  function killedself(var0) {
    if(!isPlayer(var0)) {
      return false;
    }

    if(var0 != self) {
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

  function handleworlddeath(var0, var1, var2, var3, var4) {
    var5 = var0.victim;
    var5.deathspectatepos = var5.origin;

    if(!isDefined(var1)) {
      return;
    }

    scripts\mp\events::playerworlddeath(var1, var3);

    if(!isDefined(var1.team) || var1.team == "neutral") {
      handlesuicidedeath(var3, var4);
      return;
    }

    if(level.teambased && var1.team != self.team || !level.teambased) {
      if(isDefined(level.onnormaldeath) && (isPlayer(var1) || isagent(var1)) && var1.team != "spectator") {
        if(!level.gameended) {
          [[level.onnormaldeath]](self, var1, var2, var3);
        }
      }
    }

    if(isagent(var1)) {
      var0.dokillcam = 1;
      return;
    }
  }

  function handlesuicidedeath(var0, var1) {
    scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
    scripts\mp\utility\stats::incpersstat("suicides", 1);
    var2 = scripts\mp\tweakables::gettweakablevalue("game", "suicidepointloss");
    scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var2);

    if(scripts\mp\weapons::grenadeheldatdeath() && var0 == "MOD_SUICIDE" && var1 == "none") {
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

  function handlefriendlyfiredeath(var0, var1) {
    if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")) {
      level thread scripts\mp\teamrevive::spawnrevivetrigger(var1, var1, "new_trigger_spawned", "MOD_SUICIDE");
    }

    var0 thread scripts\mp\rank::scoreeventpopup("teamkill");
    var0.pers["teamkills"] = var0.pers["teamkills"] + 1;

    if(scripts\mp\tweakables::gettweakablevalue("team", "teamkillpointloss")) {
      var2 = scripts\mp\rank::getscoreinfovalue("kill");
      scripts\mp\gamescore::_setplayerscore(var0, scripts\mp\gamescore::_getplayerscore(var0) - var2);
    }

    if(level.maxallowedteamkills < 0) {
      return;
    }

    var3 = var0 scripts\mp\playerlogic::teamkilldelay();

    if(var3 > 0) {
      var0.pers["teamKillPunish"] = 1;
      var0 notify("team_kill_punish");

      if(var0 scripts\mp\utility\player::isusingremote()) {
        var0 thread scripts\mp\utility\damage::ref_13966();
      } else {
        var0 thread scripts\mp\utility\damage::ref_13965();
      }
    }

    if(level.friendlyfire == 4 && !istrue(var0.hitfflimit) && var0.pers["teamkills"] >= level.maxallowedteamkills) {
      var0.hitfflimit = 1;
      var0 scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_PUNISH_SWITCH");
      return;
    }
  }

  function handleinlaststanddeath(var0) {
    var1 = scripts\mp\utility\game::getgametype() == "br";

    if(!istrue(var0.victim.disable_killcam)) {
      var0.dokillcam = 1;
    }

    if(!var0.iskillstreakweapon) {
      var0.attacker thread scripts\mp\utility\points::giveunifiedpoints("last_stand_kill", var0.objweapon, undefined, undefined, var0.victim);
    }

    if(isDefined(self.watch_for_attack)) {
      ref_125e3(self.watch_for_attack);
    }

    if(isDefined(self.watch_for_attack) && var0.attacker != self.watch_for_attack) {
      thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkilled(self.watch_for_attack, self.watch_for_attack, 0, var0.damageflags, self.watch_for_level_weapons_free, self.watch_for_player_enter_puddle_trigger, var0.hitloc, self.watch_for_damage, self.watch_for_damage_on_trap, self.watch_for_damage_on_turret);
      self.watch_for_attack thread scripts\mp\rank::scoreeventpopup("kill_confirmed");
    }

    if(var1) {
      handlenormaldeath(var0.lifeid, var0.attacker, var0.inflictor, var0.objweapon, var0.meansofdeath, self, var0.iskillstreakweapon, var0, 1);
    }

    self.watch_for_attack = undefined;
    self.watch_for_level_weapons_free = undefined;
    self.watch_for_player_enter_puddle_trigger = undefined;
    self.watch_for_damage = undefined;
    self.watch_for_damage_on_trap = undefined;
    self.watch_for_damage_on_turret = undefined;
  }

  function handlenormaldeath_sounds(var0, var1, var2, var3) {
    var4 = 0;
    var5 = var1;

    if(!isDefined(var0.lastkillalertsoundtime)) {
      var0.lastkillalertsoundtime = gettime();
      var4 = 1;
    } else if(gettime() > var0.lastkillalertsoundtime + 700) {
      var0.lastkillalertsoundtime = gettime();
      var4 = 1;
    }

    if(!scripts\engine\utility::isbulletdamage(var2) || var0 != var3) {
      if(var4 && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var5 playsoundtoplayer("mp_kill_alert_quiet", var0);
      }
    } else if(var2 == "MOD_HEAD_SHOT") {
      var5 playsoundtoplayer("bullet_impact_headshot_plr", var1);
      var5 playsoundtoplayer("bullet_impact_headshot", var0);

      if(var4) {
        var5 playsoundtoplayer("mp_headshot_alert", var0);
      }

      var5 playsoundtoteam("bullet_impact_headshot_npc", var1.team, var1);
      var5 playsoundtoteam("bullet_impact_headshot_npc", var0.team, var0);
    } else {
      var5 playsoundtoteam("mp_hit_alert_final_npc", var1.team);
      var5 playsoundtoteam("mp_hit_alert_final_npc", var0.team, var0);

      if(var4) {
        var5 playsoundtoplayer("mp_kill_alert", var0);
      }
    }

    if(isPlayer(var1)) {
      if(var2 != "MOD_EXECUTION") {
        var1 playlocalsound("deaths_door_death");
      }

      var1 clearsoundsubmix("deaths_door_mp", 2);
      return;
    }
  }

  function handlenormaldeath(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
    if(var4 == "MOD_GRENADE" && var2 == var1) {
      addattacker(var5, var1, var2, var3, var7.damage, (0, 0, 0), var7.direction_vec, var7.hitloc, var7.psoffsettime, var4);
    }

    var7.dokillcam = 1;

    if(isai(var5) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
      var7.dokillcam = var5[[level.bot_funcs["should_do_killcam"]]]();
    }

    if(istrue(level.disable_killcam) || istrue(var5.disable_killcam)) {
      var7.dokillcam = 0;
    }

    var1 thread scripts\mp\events::killedplayer(var0, self, var3, var4, var2, var7);
    scripts\mp\gametypes\br_alt_mode_ff::play_airport_success_vo(var1);
    scripts\mp\gametypes\br_gametype_respect::ref_12cba(var1);

    if(!istrue(level.disablestattracking)) {
      var9 = 0;
      var10 = 0;
      var11 = 0;

      if(isDefined(var1.modifiers)) {
        var9 = var1.modifiers["mask"];
        var10 = var1.modifiers["mask2"];
        var11 = var1.modifiers["mask3"];
      }

      var5 thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkilled(var2, var1, var7.damage, var7.damageflags, var4, var3, var7.hitloc, var9, var10, var11);
      var5.watch_for_driver_death = undefined;
      var5.pers["cur_death_streak"]++;

      if(var4 == "MOD_HEAD_SHOT") {
        var1 scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "headshots");
        var1 scripts\mp\utility\stats::incpersstat("headshots", 1);
        var1.headshots = var1 scripts\mp\utility\stats::getpersstat("headshots");

        switch (weaponclass(var3.basename)) {
          case "rifle":
            var1 scripts\mp\utility\stats::incpersstat("arHeadshots", 1);
            break;
          case "smg":
            var1 scripts\mp\utility\stats::incpersstat("smgHeadshots", 1);
            break;
          case "spread":
            var1 scripts\mp\utility\stats::incpersstat("shotgunHeadshots", 1);
            break;
          case "mg":
            var1 scripts\mp\utility\stats::incpersstat("lmgHeadshots", 1);
            break;
          case "sniper":
            var1 scripts\mp\utility\stats::incpersstat("sniperHeadshots", 1);
            break;
          case "rocketlauncher":
            var1 scripts\mp\utility\stats::incpersstat("launcherHeadshots", 1);
            break;
          case "pistol":
            var1 scripts\mp\utility\stats::incpersstat("pistolHeadshots", 1);
            break;
        }
      }

      if(isDefined(var2) && istrue(var2.isequipment)) {
        switch (var2.equipmentref) {
          case "equip_frag":
            var1 scripts\mp\utility\stats::incpersstat("fragKills", 1);
            break;
          case "equip_semtex":
            var1 scripts\mp\utility\stats::incpersstat("semtexKills", 1);
            break;
          case "equip_molotov":
            var1 scripts\mp\utility\stats::incpersstat("molotovKills", 1);
            break;
          case "equip_claymore":
            var1 scripts\mp\utility\stats::incpersstat("claymoreKills", 1);
            break;
          case "equip_throwing_knife_drill":
          case "equip_throwing_knife_electric":
          case "equip_throwing_knife_fire":
          case "equip_throwing_knife":
            var1 scripts\mp\utility\stats::incpersstat("throwingKnifeKills", 1);
            var1 scripts\cp_mp\pet_watch::begin_vo();
            break;
          case "equip_c4":
            var1 scripts\mp\utility\stats::incpersstat("c4Kills", 1);
            break;
          case "equip_thermite":
            var1 scripts\mp\utility\stats::incpersstat("thermiteKills", 1);
            break;
          case "equip_at_mine":
            var1 scripts\mp\utility\stats::incpersstat("proximityMineKills", 1);
            break;
        }
      }
    }

    thread handlenormaldeath_sounds(var1, var5, var4, var2);
    var12 = var1;

    if(isDefined(var1.commanding_bot)) {
      var12 = var1.commanding_bot;
    }

    if(!istrue(var8) && !isfriendlyfire(var5, var1)) {
      if(!istrue(level.ignorescoring)) {
        ref_125e3(var12);

        if(isbehindmeleevictim(var12, var5)) {
          var12 scripts\mp\utility\stats::incpersstat("killsFromBehind", 1);
          var5 scripts\mp\utility\stats::incpersstat("deathsFromBehind", 1);
        }
      } else if(isDefined(level.prematchaddkillfunc)) {
        var12[[level.prematchaddkillfunc]]();
      }
    }

    if(!istrue(level.disablestattracking)) {
      self resetplayerconsecutivekills();

      if(isPlayer(var1)) {
        var1 increaseplayerconsecutivekills();
      }
    }

    if(!istrue(var12.pers["ignoreWeaponMatchBonus"]) && (scripts\mp\utility\weapon::iscacprimaryweapon(var3) || scripts\mp\utility\weapon::iscacsecondaryweapon(var3))) {
      if(!isDefined(var12.pers["weaponMatchBonusKills"])) {
        var12.pers["weaponMatchBonusKills"] = 1;
      } else {
        var12.pers["weaponMatchBonusKills"]++;
      }

      if(var12.pers["weaponMatchBonusKills"] > scripts\mp\weaponrank::reload_use_think()) {
        var12.pers["ignoreWeaponMatchBonus"] = 1;
        var12.pers["weaponMatchBonusKills"] = undefined;
        var12.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(var12.pers["killsPerWeapon"])) {
          var12.pers["killsPerWeapon"] = [];
        }

        var13 = scripts\mp\utility\weapon::getweaponrootname(var3);
        var14 = 0;

        foreach(var16 in var12.pers["killsPerWeapon"]) {
          if(var17 == var13) {
            var16.killcount++;
            var14 = 1;
            break;
          }
        }

        if(!var14) {
          var16 = spawnStruct();
          var16.killcount = 1;
          var16.basename = var3.basename;
          var16.ref_1213c = var12.pers["killsPerWeapon"].size;
          var12.pers["killsPerWeapon"][var13] = var16;
        }
      }
    }

    var18 = var1.pers["cur_kill_streak"];

    if(!istrue(level.ignorescoring) && (isalive(var1) || isDefined(var1.streaktype) && var1.streaktype == "support")) {
      if(var4 == "MOD_MELEE" && !var1 scripts\mp\utility\killstreak::isjuggernaut() || var1 scripts\mp\utility\killstreak::killshouldaddtokillstreak(var3)) {
        registerkill(var1, var3, var4, 1, var6);
      }

      if(var1.pers["cur_kill_streak"] > var1 scripts\mp\utility\stats::getpersstat("longestStreak")) {
        var1.pers["longestStreak"] = var1.pers["cur_kill_streak"];
      }
    }

    var1.pers["cur_death_streak"] = 0;

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      if(!istrue(level.ignorescoring) && var1.pers["cur_kill_streak"] > var1 scripts\mp\persistence::statgetchild("round", "killStreak")) {
        var1 scripts\mp\persistence::statsetchild("round", "killStreak", var1.pers["cur_kill_streak"]);
      }

      if(!istrue(level.ignorescoring) && var1 scripts\mp\utility\game::onlinestatsenabled()) {
        if(var1.pers["cur_kill_streak"] > var1.bestlifetimekillstreak) {
          var1 scripts\mp\playerstats_interface::setplayerstat(var1.pers["cur_kill_streak"], "bestStats", "killStreak");
          var1.bestlifetimekillstreak = var1.pers["cur_kill_streak"];
        }
      }
    }

    if(!var6 && !scripts\mp\utility\weapon::unsetreduceregendelayonkills(var2) || scripts\mp\utility\points::unset_relic_doomslayer(var3)) {
      var1 thread scripts\mp\events::killeventtextpopup("kill", 0);
      var19 = undefined;

      if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done")) {
        var19 = 100;
      }

      var1 thread scripts\mp\utility\points::giveunifiedpoints("kill", var3, var19, undefined, var5);
      var1 scripts\mp\bounty::bountyincreasestreak();
      var1 scripts\mp\bounty::bountycollect(var5.lastbounty, var5.origin);

      if(var1 scripts\mp\utility\perk::_hasperk("specialty_hardline") && isDefined(var1.hardlineactive) && var1.hardlineactive["assists"] == 2) {
        var1 thread scripts\mp\utility\points::givestreakpointswithtext("assist_hardline", var3, 1);
      }
    }

    var20 = scripts\mp\tweakables::gettweakablevalue("game", "deathpointloss");

    if(var1.currentweapon hasattachment("gunperk_frenzy")) {
      var1 notify("begin_regeneration");
    }

    if(isDefined(level.gunshipplayer) && level.gunshipplayer == var1) {
      level notify("ai_killed", self);
    }

    scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var20);
    level notify("player_got_killstreak_" + var1.pers["cur_kill_streak"], var1);
    var1 notify("killed_enemy");

    if(istrue(var1.inlaststand)) {
      var1 thread scripts\mp\laststand::ref_1204f(var7);
    }

    if(isDefined(level.onnormaldeath) && isDefined(var1.pers) && var1.pers["team"] != "spectator" && !istrue(level.ignorescoring)) {
      [[level.onnormaldeath]](self, var1, var0, var4, var3, var6);
    }

    if(!var1 scripts\mp\utility\player::isusingremote()) {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var1, "killfirm_infantry", undefined, 0.75);
    }

    var21 = undefined;

    switch (var5.loadoutarchetype) {
      case "archetype_assault":
        var21 = "plr_killfirm_warfighter";
        break;
    }

    if(isDefined(var21)) {
      level thread scripts\mp\battlechatter_mp::saytoself(var1, var21, "plr_killfirm_generic", 0.75);
    }

    if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != var1) {
      if(gettime() - self.lastattackedshieldtime < 2500) {
        self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
      } else if(isalive(self.lastattackedshieldplayer) && gettime() - self.lastattackedshieldtime < 5000) {
        var22 = vectorNormalize(anglesToForward(self.angles));
        var23 = vectorNormalize(self.lastattackedshieldplayer.origin - self.origin);

        if(vectordot(var23, var22) > 0.925) {
          self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
        }
      }
    }

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      scripts\mp\gamescore::awardbuffdebuffassists(var1, self);
    }

    if(isDefined(self.attackers)) {
      foreach(var25 in self.attackers) {
        if(!isDefined(scripts\mp\utility\damage::_validateattacker(var25))) {
          continue;
        }

        if(var25 == var1) {
          continue;
        }

        if(self == var25) {
          continue;
        }

        if(isDefined(level.assists_disabled)) {
          continue;
        }

        if(isDefined(self.watch_for_attack) && self.watch_for_attack == var25) {
          continue;
        }

        var26 = undefined;

        if(isDefined(self.attackerdata)) {
          var27 = self.attackerdata[var25.guid];

          if(isDefined(var27)) {
            var26 = var27.objweapon;
          }
        }

        var28 = 0;

        if(self.attackerdata[var25.guid].damage >= 35) {
          var28 = 1;
        }

        if(self.attackerdata[var25.guid].damage >= 70) {
          var28 = 2;
        }

        var25 thread scripts\mp\gamescore::processassist(self, var26, var28);

        if(var25 scripts\mp\utility\perk::_hasperk("specialty_boom")) {
          var5 thread scripts\mp\perks\perkfunctions::setboominternal(var25);
        }
      }
    }

    if(isDefined(self.markedbyboomperk)) {
      foreach(var25 in level.players) {
        if(var25.team == self.team) {
          continue;
        }

        if(scripts\engine\utility::array_contains(self.attackers, var25)) {
          continue;
        }

        if(scripts\engine\utility::array_contains_key(self.markedbyboomperk, var25 scripts\mp\utility\player::getuniqueid())) {
          var25 thread scripts\mp\gamescore::processassist(self, var3);
        }
      }
    }

    if(level.teambased) {
      var32 = undefined;
      var33 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
        var33 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
      }

      if(istrue(var33) && getdvarint("scr_uav_for_squad_only", 1) && isDefined(var1.squadindex) && isDefined(var1.team)) {
        var32 = var1.team + var1.squadindex;
      } else if(isDefined(var1.team)) {
        var32 = var1.team;
      }

      if(isDefined(var32) && isDefined(level.uavmodels) && isDefined(level.uavmodels[var32]) && level.uavmodels[var32].size > 0) {
        var34 = [];

        foreach(var36 in level.uavmodels[var32]) {
          if(isDefined(var36) && isDefined(var36.owner) && var36.owner != var1 && !scripts\engine\utility::array_contains(var34, var36.uavtype)) {
            var37 = var36.uavtype + "_assist";
            var38 = undefined;

            if(!isDefined(var36.carpunchcount)) {
              var36.carpunchcount = 0;
            }

            var39 = scripts\engine\utility::ter_op(var36.uavtype == "directional_uav", 15, 10);

            if(var36.carpunchcount < var39) {
              var36.owner thread scripts\mp\utility\points::giveunifiedpoints(var37, undefined, var38, undefined, undefined, undefined, var36.streakinfo);
            } else {
              var36.owner thread scripts\mp\utility\points::sec_sys_struct_1(var37, var38);
            }

            var36.carpunchcount++;

            switch (var36.uavtype) {
              case "uav":
                var36.owner scripts\mp\utility\stats::incpersstat("killstreakUAVAssists", 1);
                break;
              case "directional_uav":
                var36.owner scripts\mp\utility\stats::incpersstat("killstreakAUAVAssists", 1);
                break;
            }

            var34 = var36.uavtype;
            scripts\cp\vehicles\vehicle_compass_cp::processuavassist(var36.owner, var36.uavtype);
            var36.owner scripts\mp\utility\script::bufferednotify("update_uav_assist_buffered");
            combatrecordkillstreakstat(var36.owner, var36.uavtype);
          }
        }
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(var42 in level.supportdrones) {
          if(level.teambased && var42.team == var1.team && var42.owner != var1) {
            if(isDefined(var42.enemiesmarked) && isDefined(var42.enemiesmarked[self getentitynumber()])) {
              var42.owner thread scripts\mp\utility\points::giveunifiedpoints(var42.streakinfo.streakname + "_assist");
              var1 scripts\cp\vehicles\vehicle_compass_cp::ref_1207c();
            }
          }

          if(var42.helperdronetype == "scrambler_drone_guard") {
            if(var1 != var42.owner) {
              var37 = var42.streakinfo.streakname + "_assist";

              if(!isDefined(var42.carpunchcount)) {
                var42.carpunchcount = 0;
              }

              if(var42.carpunchcount < 10) {
                var42.owner thread scripts\mp\utility\points::giveunifiedpoints(var37, undefined, undefined, undefined, undefined, undefined, var42.streakinfo);
              } else {
                var42.owner thread scripts\mp\utility\points::sec_sys_struct_1(var37);
              }

              var42.carpunchcount++;
              var42.owner scripts\mp\utility\stats::incpersstat("killstreakCUAVAssists", 1);
              continue;
            }

            if(isDefined(var42.owner) && var1 == var42.owner) {
              if(!istrue(var1.ref_12c3d)) {
                var1 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_kill_scrambled_enemies_s1", 1);
                continue;
              }

              var1.ref_12c3d = undefined;
            }
          }
        }
      }

      _debug_rooftop_activesat::close_teleport_room_door(var1, self);

      if(isDefined(var1.team) && isDefined(level.activewpzones) && level.activewpzones.size > 0) {
        var44 = level.activewpzones[0];
        var45 = var44.owner;
        var46 = var44.team;

        if(var1.team == var46 && var1 != var45) {
          if(istrue(var5.wpdisorient) || istrue(var5.wpburning)) {
            var37 = "white_phosphorus_assist";

            if(!isDefined(var44.carpunchcount)) {
              var44.carpunchcount = 0;
            }

            if(var44.carpunchcount < 15) {
              var45 thread scripts\mp\utility\points::giveunifiedpoints(var37, undefined, undefined, undefined, undefined, undefined, var44.streakinfo);
            } else {
              var45 thread scripts\mp\utility\points::sec_sys_struct_1(var37);
            }

            var44.carpunchcount++;
            var45 scripts\mp\utility\stats::incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
          }
        }
      }
    }

    if(isPlayer(var1)) {
      var1 setclientomnvar("ui_killed_player", self getentitynumber());
      var1 setclientomnvar("ui_killed_player_notify", gettime());
    }
  }

  function ref_125e3() {
    var0 = self;
    var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "kills");

    if(var0.pers["kills"] < 14999) {
      var0 scripts\mp\utility\stats::incpersstat("kills", 1);
      var0.kills = var0 scripts\mp\utility\stats::getpersstat("kills");
      var0 scripts\mp\persistence::statsetchild("round", "kills", var0.kills, level.ignorekdrstats);
      return;
    }
  }

  function callback_playerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
    playerkilled_internal(var0, var1, self, var2, var3, var4, var5, var6, var7, var8, var9, 0);
  }

  function launchshield(var0, var1) {
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

  function hitlocdebug(var0, var1, var2, var3, var4) {
    var5 = [];
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

  function updateinflictorstat(var0, var1, var2) {
    if(!isDefined(var0) || !isDefined(var0.alreadyhit) || !var0.alreadyhit || !scripts\mp\utility\weapon::issinglehitweapon(var2)) {
      scripts\mp\gamelogic::setinflictorstat(var0, var1, var2);
    }

    if(isDefined(var0)) {
      var0.alreadyhit = 1;
      return;
    }
  }

  function addattacker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
    if(!isDefined(var0.attackerdata)) {
      var0.attackerdata = [];
    }

    if(!isDefined(var0.attackerdata[var1.guid])) {
      var0.attackers[var1.guid] = var1;
      var0.attackerdata[var1.guid] = spawnStruct();
      var0.attackerdata[var1.guid].damage = 0;
      var0.attackerdata[var1.guid].attackerent = var1;
      var0.attackerdata[var1.guid].firsttimedamaged = gettime();
      var0.attackerdata[var1.guid].hitcount = 1;
    } else {
      var0.attackerdata[var1.guid].hitcount++;
    }

    if(scripts\mp\utility\weapon::iscacprimaryweapon(var3) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var3)) {
      var0.attackerdata[var1.guid].diddamagewithprimary = 1;
    }

    if(isDefined(var9) && var9 != "MOD_MELEE") {
      var0.attackerdata[var1.guid].didnonmeleedamage = 1;
    }

    var10 = scripts\mp\utility\weapon::getequipmenttype(var3.basename);

    if(isDefined(var10)) {
      if(var10 == "lethal") {
        var0.attackerdata[var1.guid].diddamagewithlethalequipment = 1;
      }

      if(var10 == "tactical") {
        var0.attackerdata[var1.guid].diddamagewithtacticalequipment = 1;
      }
    }

    var0.attackerdata[var1.guid].damage += var4;
    var0.attackerdata[var1.guid].weapon = createheadicon(var3);
    var0.attackerdata[var1.guid].objweapon = var3;
    var0.attackerdata[var1.guid].vpoint = var5;
    var0.attackerdata[var1.guid].vdir = var6;
    var0.attackerdata[var1.guid].shitloc = var7;
    var0.attackerdata[var1.guid].psoffsettime = var8;
    var0.attackerdata[var1.guid].smeansofdeath = var9;
    var0.attackerdata[var1.guid].attackerent = var1;
    var0.attackerdata[var1.guid].lasttimedamaged = gettime();
    var0.attackerdata[var1.guid].inflictor = var2;
    var0.attackerdata[var1.guid].ref_11c8d = var1 scripts\mp\events::registerhints(0, var0, var3, var9, var2);
    var0.attackerdata[var1.guid].ref_11c8e = var1 scripts\mp\events::registerleveldataforvehicle(0, var0, var3, var9, var2);

    if(isDefined(var2) && !isPlayer(var2) && isDefined(var2.primaryweapon)) {
      var0.attackerdata[var1.guid].sprimaryweapon = var2.primaryweapon;
      return;
    }

    if(isDefined(var1) && isPlayer(var1) && !nullweapon(var1 getcurrentprimaryweapon())) {
      var0.attackerdata[var1.guid].sprimaryweapon = createheadicon(var1 getcurrentprimaryweapon());
      return;
    }

    var0.attackerdata[var1.guid].sprimaryweapon = undefined;
  }

  function addattackerkillstreak(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
    if(!isDefined(var0.attackerdata)) {
      var0.attackerdata = [];
    }

    if(!isDefined(var0.attackerdata[var2.guid])) {
      var0.attackers[var2.guid] = var2;
      var0.attackerdata[var2.guid] = spawnStruct();
      var0.attackerdata[var2.guid].damage = 0;
      var0.attackerdata[var2.guid].attackerent = var2;
      var0.attackerdata[var2.guid].firsttimedamaged = gettime();
      var0.attackerdata[var2.guid].hitcount = 1;
    }

    var0.attackerdata[var2.guid].damage += var1;
    var0.attackerdata[var2.guid].weapon = var10;
    var0.attackerdata[var2.guid].vpoint = var4;
    var0.attackerdata[var2.guid].vdir = var3;
    var0.attackerdata[var2.guid].partname = var8;
    var0.attackerdata[var2.guid].smeansofdeath = var5;
    var0.attackerdata[var2.guid].attackerent = var2;
    var0.attackerdata[var2.guid].lasttimedamaged = gettime();
    var0.attackerdata[var2.guid].ref_11c8d = 0;
    var0.attackerdata[var2.guid].ref_11c8e = 0;

    if(isDefined(var2) && isPlayer(var2) && !nullweapon(var2 getcurrentprimaryweapon())) {
      var0.attackerdata[var2.guid].sprimaryweapon = createheadicon(var2 getcurrentprimaryweapon());
      return;
    }

    var0.attackerdata[var2.guid].sprimaryweapon = undefined;
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

  function callback_playerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
    var14 = gettime();
    callback_playerdamage_internal(var0, var1, self, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  }

  function ref_12aa2(var0, var1, var2, var3) {
    if(ref_1331e(self)) {
      var0 scripts\mp\utility\stats::incpersstat("damage", var1);

      if(!isDefined(var0.isbecomingzombie)) {
        var0.isbecomingzombie = var1;
      } else {
        var0.isbecomingzombie += var1;
      }

      if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
        if(isPlayer(var0)) {
          var0 scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var3), "damage", min(self.health, var2), -1, var3);
          scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var0, "damageDone", var0 scripts\mp\utility\stats::getpersstat("damage"));
        }
      }

      var4 = scripts\mp\utility\weapon::mapweapon(var3);
      var5 = createheadicon(var4);
      var0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var5, var1, "damage_dealt");
      return;
    }

    if(isDefined(level.ref_12001)) {
      var0[[level.ref_12001]](var1);
      return;
    }
  }

  function finishplayerdamagewrapper(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
    var13 = int(min(var2, self.health));

    if(isDefined(var1) && isPlayer(var1)) {
      ref_12aa2(var1, var13, var2, var5);
    } else if(isDefined(var0) && var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var14 = var0;

      if(isDefined(var14.owner) && isPlayer(var14.owner)) {
        ref_12aa2(var14.owner, var13, var2, var5);
      }
    } else if(isDefined(var0) && var0 _calloutmarkerping_isvehicleoccupiedbyenemy::unrescuable_fail()) {
      var15 = var0;

      if(isDefined(var15.owner) && isPlayer(var15.owner)) {
        ref_12aa2(var15.owner, var13, var2, var5);
      }
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(var5)) {
      if(scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var5) == "precision_airstrike" && istrue(level.vehicle_collision_getleveldata)) {
        return;
      }
    }

    if(ref_1331e(self)) {
      var16 = self.lastdroppableweaponobj;
      var16 = scripts\mp\utility\weapon::mapweapon(var16);
      var17 = createheadicon(var16);
      scripts\mp\utility\stats::incpersstat("damageTaken", var13);
      thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var17, 1, "hit_markers_taken");
      thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var17, var13, "damage_taken");

      if(var13 > 1000) {
        scripts\mp\gametypes\br_analytics::determine_starting_breadcrumb(self, var13, var4);
      }
    }

    if(isDefined(var0) && isDefined(var0.streakinfo) && isDefined(var0.streakinfo.damage)) {
      var0.streakinfo.damage += var2;
    }

    if(scripts\mp\utility\damage::playershoulddofauxdeath() && var2 >= self.health && !(var3 &level.idflags_stun) && allowfauxdeath()) {
      if(!isDefined(var7)) {
        var7 = (0, 0, 0);
      }

      if(!isDefined(var1)) {
        var1 = self;
      }

      if(!isDefined(var0)) {
        var0 = var1;
      }

      playerkilled_internal(var0, var1, self, var2, var3, var4, var5, var7, var8, var9, 0, 1);
    } else {
      if(!callback_killingblow(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9)) {
        return;
      }

      if(!isalive(self)) {
        return;
      }

      if(isPlayer(self)) {
        if(!isDefined(var11)) {
          var11 = "";
        }

        if(!isDefined(var12)) {
          var12 = 0;
        }

        if(shoulduseexplosiveindicator(var4)) {
          var3 |= level.idflags_ricochet;
        }

        if(scripts\mp\utility\game::getgametype() == "br") {
          var12 = 0;
        }

        var18 = !(var4 != "MOD_TRIGGER_HURT" && isDefined(self.update_bomb_interaction_ent));
        self finishplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11, var12, var18);
        br_itemrarity(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
      }
    }

    if(var4 == "MOD_EXPLOSIVE_BULLET") {
      scripts\cp_mp\utility\shellshock_utility::_shellshock("damage_mp", "damage", getdvarfloat("scr_csmode"), 0, 0);
    }

    damageshellshockandrumble(var0, var5, var4, var2, var3, var1);
  }

  function shoulduseexplosiveindicator(var0) {
    return var0 == "MOD_GRENADE" || var0 == "MOD_GRENADE_SPLASH" || var0 == "MOD_EXPLOSIVE" || var0 == "MOD_FIRE";
  }

  function callback_playerimpaled(var0, var1, var2, var3, var4, var5, var6, var7) {
    thread scripts\mp\weapons::impale(var0, self, var1, var2, var3, var4, var5, var6, var7);
  }

  function allowfauxdeath() {
    if(!isDefined(level.allowfauxdeath)) {
      level.allowfauxdeath = 1;
    }

    return level.allowfauxdeath;
  }

  function callback_playerlaststand(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
    var9 = isforcedlaststand(self, var0, var1, var2, var3, var4, var5, var6);

    if(!istrue(var9)) {
      if(scripts\mp\utility\game::getgametype() != "br" && !istrue(self.killstreaklaststand) && var3 == "MOD_MELEE" && var4.basename != "iw8_fists_mp" && var4.basename != "iw8_fists_mp_ls") {
        return false;
      }

      if(var3 == "MOD_EXECUTION") {
        return false;
      }

      if(scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\damage::isheadshot(var6, var3, var1)) {
        return false;
      }

      if(scripts\mp\utility\game::getgametype() != "br" && isexplosivedamagemod(var3)) {
        return false;
      }

      if(istrue(self.gulagarena)) {
        return false;
      }

      if(isDefined(var1) && isDefined(var1.classname) && (var1.classname == "trigger_hurt" || var1.classname == "worldspawn")) {
        return false;
      }

      if(var1 == self && scripts\mp\utility\game::getgametype() != "br") {
        return false;
      }

      if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\killstreak::isjuggernaut()) {
        return false;
      }

      if(isDefined(level.ref_11c6f) && !self[[level.ref_11c6f]](var0, var1, var2, var3, var4, var5, var6, var7, var8)) {
        return false;
      }
    }

    if(isDefined(level.ref_121d1)) {
      self[[level.ref_121d1]]();
    }

    if(self isskydiving()) {
      self skydive_interrupt();
    }

    var10 = self.matchdatalifeindex;

    if(!isDefined(var10)) {
      var10 = level.maxlives - 1;
    }

    if(isDefined(var1) && isDefined(var1.classname) && var1.classname != "worldspawn") {
      if(!isPlayer(var1)) {
        if(isDefined(var1.owner) && isPlayer(var1.owner)) {
          var1 = var1.owner;
        } else if(isDefined(var0) && isDefined(var0.owner) && isPlayer(var0.owner)) {
          var1 = var0.owner;
        }
      }

      var11 = playerkilled_initdeathdata(var0, var1, self, var2, 0, var3, var4, var5, var6, var7, var8, 0);
      playerkilled_parameterfixup(var11);
      playerkilled_precalc(var11);
      var11.laststandkill = 1;
      self.ref_125b9 = 1;

      if(isPlayer(var1) && var1 != self) {
        self.watch_for_attack = var1;
        self.watch_for_level_weapons_free = var11.meansofdeath;
        self.watch_for_player_enter_puddle_trigger = var4;
        var1 thread scripts\mp\events::cargo_truck_mg_initoccupancy(var10, self, var4, var3, var0, var11);
        self.watch_for_damage = var1.modifiers["mask"];
        self.watch_for_damage_on_trap = var1.modifiers["mask2"];
        self.watch_for_damage_on_turret = var1.modifiers["mask3"];
      }

      self.lastbounty = scripts\mp\bounty::playergetbountypoints();
      scripts\mp\bounty::playerresetbountypoints();
      scripts\mp\bounty::playerresetbountystreak();
      var11.isfriendlyfire = isfriendlyfire(self, var1);

      if(getdvarint("scr_killcam_on_down", 1)) {
        self.watch_for_driver_spawned = var11;
      }

      if(!var11.isfriendlyfire && var1 != self) {
        if(scripts\mp\utility\game::getgametype() == "br") {
          if(isPlayer(var1) && var1 != self) {
            var1 scripts\mp\gametypes\br_public::incrementplayersdownedstat();
            var1 thread scripts\mp\rank::scoreeventpopup("downed");
            var12 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var4);
            var13 = isDefined(var12) && var12 == "precision_airstrike";

            if(var13) {
              if(isDefined(var1.brattractions)) {
                var1.brattractions++;
              }
            }

            if(var1 ispcplayer() && scripts\mp\flags::gameflag("prematch_done")) {
              var1 setclientomnvar("nVidiaHighlights_events", 24);
            }

            if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "kingslayer" && getDvar("scr_br_gametype", "") != "gold_war" && level.teamdata[self.team]["alivePlayers"].size > 0) {
              obituary(self, var1, var4, "MOD_DOWN", level.teamdata[var1.team]["alivePlayers"]);
            }
          }

          if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "kingslayer" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "gold_war") {
            if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
              var14 = min(max(1, level.br_circle.circleindex), 6);
              var15 = "br_downEnemy_circle_" + scripts\engine\utility::string(var14);

              if(scripts\mp\rank::isregisteredevent(var15) && isPlayer(var1)) {
                var1 thread scripts\mp\utility\points::giveunifiedpoints(var15, var4);
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
      scripts\mp\gametypes\br_analytics::branalytics_down(var1, self, var4, "downed", var3);

      if(var3 == "MOD_CRUSH" && isDefined(var0.classname) && var0.classname == "script_vehicle") {
        self playSound("vehicle_body_hit");
      }
    }

    if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
      if(isDefined(var1) && isPlayer(var1) && !isbot(var1)) {
        var1 notify("enemy_in_laststand");
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

  function isforcedlaststand(var0, var1, var2, var3, var4, var5, var6, var7) {
    var8 = 0;

    if(scripts\mp\utility\game::getgametype() == "br") {
      if(scripts\mp\gametypes\br_public::validtousesticker()) {
        return 1;
      }

      if(isDefined(var2) && isPlayer(var2) && var2 != var0 && !istrue(var2.gulag)) {
        var2 thread scripts\mp\hud_message::showsplash("br_enemy_downed", undefined, var0);
      }

      if(var4 == "MOD_FALLING" && !istrue(self.gulagarena)) {
        var8 = 1;
      }
    }

    if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
      var8 = 1;
    }

    return var8;
  }

  function gethitlocheight(var0) {
    switch (var0) {
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

  function damageshellshockandrumble(var0, var1, var2, var3, var4, var5) {
    thread scripts\mp\weapons::onweapondamage(var0, var1, var2, var3, var5);

    if(!isai(self) && scripts\common\utility::getdamagetype(var2) != "bullet") {
      self playRumbleOnEntity("damage_heavy");

      if(isDefined(var0) && istrue(var0.vehicle_collision_getignoreevent)) {
        self playSound("train_veh_impact_body");

        if(isDefined(level.ref_145f1.ref_13c8d)) {
          var6 = level.ref_145f1.ref_13c8d[0].wz_tease;
          var6 playsoundonmovingent("veh_horn_cargotrain");
        }
      }

      if(scripts\mp\utility\game::getgametype() != "br" && var2 == "MOD_TRIGGER_HURT") {
        self playsoundtoplayer("trigger_hurt_impact_plr", self);
        return;
      }

      return;
    }
  }

  function callback_killingblow(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
    return true;
  }

  function emitfalldamage(var0) {
    physicsexplosionsphere(self.origin, 64, 64, 1);
  }

  function gamemodemodifyplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
    if(isDefined(var2) && isPlayer(var2) && isalive(var2)) {
      if(level.matchrules_damagemultiplier) {
        var3 *= level.matchrules_damagemultiplier;
      }

      if(level.matchrules_vampirism) {
        var2.health = int(min(float(var2.maxhealth), min(var2.health + var3, float(var2.health + 20))));
        var2 notify("vampirism");
      }

      if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var11 = weaponclass(var5);

        switch (var8) {
          case "neck":
          case "helmet":
          case "head":
            if(var11 != "spread" && var5.basename != "white_phosphorus_proj_mp") {
              var3 *= 2.7;
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
          if(!isbot(var1)) {
            if(var4 == "MOD_PISTOL_BULLET" || var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_HEAD_SHOT") {
              var12 = 80;

              if(!isPlayer(var2) || !isPlayer(var1)) {
                return 0;
              }

              var13 = var1 getplayerangles();
              var14 = var2 getplayerangles();
              var15 = angleclamp180(var13[1] - var14[1]);

              if(abs(var15) < var12) {
                var3 *= 0.3;
              }
            }
          }
        }
      }

      if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() == "infect" && isDefined(var5)) {
        if(var5.basename == "iw8_fists_mp_zmb") {
          var3 = 135;
        }
      }
    }

    return var3;
  }

  function registerkill(var0, var1, var2, var3) {
    self.killcountthislife++;
    self.pers["cur_kill_streak"]++;
    self setclientomnvar("ui_life_kill_count", self.killcountthislife);
  }

  function monitordamage(var0, var1, var2, var3, var4, var5, var6) {
    self endon("death");
    level endon("game_ended");
    self endon("monitorDamageEnd");

    if(!isDefined(var5)) {
      var5 = 0;
    }

    self setCanDamage(1);
    self.health = 2147483647;
    self.maxhealth = var0;

    if(!isDefined(self.damagetaken) || istrue(var6)) {
      self.damagetaken = 0;
    }

    if(!isDefined(var4)) {
      var4 = 0;
    }

    for(var7 = 1; var7; var7 = monitordamageoneshot(var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var21, var1, var2, var3, var4)) {
      self waittill("damage", var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18, var19, var20, var21);
      var17 = scripts\mp\utility\weapon::mapweapon(var17, var21);

      if(var5) {
        self playRumbleOnEntity("damage_light");
      }

      if(var4) {
        var22 = "none";

        if(isDefined(var17)) {
          var22 = createheadicon(var17);
        }

        logattackerkillstreak(self, var8, var9, var10, var11, var12, var13, var14, var15, var16, var22);
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

  function monitordamageoneshot(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
    if(!isDefined(self)) {
      return false;
    }

    if(isDefined(var1) && isDefined(var1.owner)) {
      var1 = var1.owner;
    }

    if(isDefined(var1) && !scripts\mp\utility\entity::isgameparticipant(var1) && !istrue(var1.ref_1217b)) {
      return true;
    }

    if(isDefined(var1) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var1)) {
      if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else {
        return true;
      }
    }

    var15 = var0;

    if(!istrue(self.ref_133d4) && scripts\mp\utility\damage::non_player_should_ignore_damage(var1, var9, var10, var4)) {
      return true;
    }

    if(isDefined(var9)) {
      var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, self, var0, var9, var4, var10, var3, var2, var5, var7, var6, var8);

      if(!isDefined(var13)) {
        var13 = &modifydamage;
      }

      var15 = self[[var13]](var16);
    }

    if(var15 <= 0) {
      return true;
    }

    self.wasdamaged = 1;
    self.damagetaken += int(var15);
    self.health = 2147483647;

    if(isDefined(var8) && var8 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var8) && var8 &level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    if(istrue(var14)) {
      scripts\mp\killstreaks\killstreaks::killstreakhit(var1, var9, self, var4, var15);
    }

    if(isDefined(var1)) {
      if(isPlayer(var1)) {
        var1 scripts\mp\damagefeedback::updatedamagefeedback(var11);
      }
    }

    if(self.damagetaken >= self.maxhealth) {
      var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, self, var0, var9, var4, var10, var3, var2, var5, var7, var6, var8);
      self thread[[var12]](var16);
      return false;
    }

    return true;
  }

  function modifydamage(var0) {
    var1 = var0.attacker;
    var2 = var0.objweapon;
    var3 = var0.meansofdeath;
    var4 = var0.damage;
    var5 = var0.idflag;

    if(isDefined(var5) && var5 && level.idflags_ricochet) {
      var6 = 0.6 * var4;
    } else {
      var6 = var5;
    }

    var6 = handleempdamage(var3, var4, var6);
    var6 = handlemissiledamage(var3, var4, var6);
    var6 = handlegrenadedamage(var3, var4, var6);
    var6 = handleapdamage(var3, var4, var6);
    return var6;
  }

  function handlemissiledamage(var0, var1, var2) {
    var3 = var2;

    switch (var0.basename) {
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
        var3 = self.maxhealth + 1;
        break;
      case "heli_pilot_turret_mp":
        self.largeprojectiledamage = 0;
        var3 *= 2;
        break;
    }

    return var3;
  }

  function handlegrenadedamage(var0, var1, var2) {
    if(isexplosivedamagemod(var1)) {
      switch (var0.basename) {
        case "c4_mp_p":
          var2 *= 3;
          break;
        case "bouncing_betty_mp":
        case "semtex_mp":
        case "frag_grenade_mp":
          var2 *= 4;
          break;
        default:
          if(var0.isalternate) {
            var2 *= 3;
          }

          break;
      }
    }

    return var2;
  }

  function handlemeleedamage(var0, var1, var2) {
    if(var1 == "MOD_MELEE") {
      return (self.maxhealth + 1);
    }

    return var2;
  }

  function handleempdamage(var0, var1, var2) {
    return var2;
  }

  function handleapdamage(var0, var1, var2, var3) {
    var4 = 1;
    var5 = level.armorpiercingmod - 1;

    if(scripts\mp\utility\damage::isfmjdamage(var0, var1, 1)) {
      var4 += var5;
    }

    var6 = level.armorpiercingmodks - 1;

    if(isDefined(var3) && var3 scripts\mp\utility\perk::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\mp\utility\weapon::isprimaryweapon(var0) && scripts\engine\utility::isbulletdamage(var1)) {
      var4 += var6;
    }

    return var2 * var4;
  }

  function handleshotgundamage(var0, var1, var2) {
    if(!isDefined(var0)) {
      return var2;
    }

    if(var0.basename == "none") {
      return var2;
    }

    if(weaponclass(var0) != "spread") {
      return var2;
    }

    return int(min(150, var2));
  }

  function onkillstreakdamaged(var0, var1, var2, var3) {
    var4 = undefined;

    if(isDefined(var1) && isDefined(self.owner)) {
      if(isDefined(var1.owner) && isPlayer(var1.owner)) {
        var1 = var1.owner;
      }

      if(isPlayer(var1) && self.owner scripts\mp\utility\player::isenemy(var1)) {
        var4 = var1;
      }
    }

    if(isDefined(var4)) {
      thread scripts\cp\vehicles\vehicle_compass_cp::killstreakdamaged(var0, self.owner, var4, var2, var3);
      return;
    }
  }

  function onkillstreakkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
    var9 = 0;
    var10 = undefined;

    if(isDefined(var1) && isDefined(self.owner)) {
      if(isDefined(var1.owner) && isPlayer(var1.owner)) {
        var1 = var1.owner;
      }

      if(issentient(self.owner) && issentient(var1)) {
        if(!istestclient(self.owner, var1)) {
          var10 = var1;
        }
      } else if(self.owner scripts\mp\utility\player::isenemy(var1)) {
        var10 = var1;
      }
    }

    if(isDefined(var10)) {
      if(isDefined(var7)) {
        var10 scripts\mp\battlechatter_mp::killstreakdestroyed(var0);
      }

      thread scripts\mp\events::killedkillstreak(var0, var10, var2);
      thread scripts\cp\vehicles\vehicle_compass_cp::killstreakkilled(var0, self.owner, self, var10, var4, var3, var2, var5);
      scripts\cp_mp\gestures::processcalloutdeath(self, var10);
      var9 = 1;
    }

    thread scripts\mp\events::ref_128b3(var10);

    if(isDefined(self.owner) && isDefined(var6)) {
      self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer(var6, undefined, undefined, self.origin);
    }

    if(!istrue(var8)) {
      self notify("death");
    }

    return var9;
  }

  function updatedeathdetails(var0, var1, var2) {
    var3 = 0;

    if(isDefined(var2) && isPlayer(var2) && isDefined(var2.health)) {
      if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
        self setclientomnvar("ui_death_details_enemy_health", 0);
      } else {
        self setclientomnvar("ui_death_details_enemy_health", int(clamp(var2.health, 0, var2.maxhealth)) / var2.maxhealth);
      }
    } else {
      self setclientomnvar("ui_death_details_enemy_health", -1);
    }

    if(isDefined(var0) && isDefined(var1)) {
      foreach(var5 in var0) {
        if(!isPlayer(var5)) {
          continue;
        }

        var6 = var5 getentitynumber();
        self setclientomnvar("ui_death_details_attacker_" + var3, var6);
        self setclientomnvar("ui_death_details_hits_" + var3, int(min(var1[var7].hitcount, 10)));
        var3++;

        if(var3 >= 4) {
          break;
        }
      }
    }

    for(var8 = var3; var8 < 4; var8++) {
      self setclientomnvar("ui_death_details_attacker_" + var8, -1);
    }
  }

  function setdeathtimerlength(var0) {
    var1 = var0.victim;
    var2 = 0;

    if(var1 scripts\mp\playerlogic::mayspawn() && !level.loadoutdefaultfiresalediscount) {
      var3 = scripts\mp\playerlogic::timeuntilspawn(1);
      var4 = 2.25;
      var5 = 1;
      var3 = max(var3 + var5, var4);
      var2 = var3 + var0.deathscenetimesec;
    }

    var1.death_timer_length = int(var2 * 10);
  }

  function getindexfromhitloc(var0) {
    switch (var0) {
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

  function updatecombatrecordkillstats(var0, var1, var2, var3) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
      return;
    }

    if(isDefined(var0) && isPlayer(var0) && var0 != var1) {
      combatrecordarchetypekill(var0, var0.loadoutarchetype);

      if(isDefined(var3)) {
        var4 = scripts\mp\utility\weapon::getequipmenttype(var3.basename);

        if(isDefined(var4) && var4 == "lethal") {
          var5 = scripts\mp\equipment::getequipmentreffromweapon(var3);

          if(var5 == "equip_throwing_knife_fire" || var5 == "equip_throwing_knife_electric" || var5 == "equip_throwing_knife_drill") {
            var5 = "equip_throwing_knife";
          }

          combatrecordlethalkill(var0, var5);
        } else {
          var6 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var3);

          if(isDefined(var6)) {
            if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var6)) {
              combatrecordkillstreakstat(var0, var6);
            }
          }

          if(scripts\mp\utility\game::getgametype() != "br") {
            if(istrue(var0.personalradaractive)) {
              combatrecordtacticalstat(var0, "power_periphVis");
            }

            if(istrue(var0.adrenalinepoweractive)) {
              combatrecordtacticalstat(var0, "power_adrenaline");
            }
          }
        }
      }
    }

    if(isDefined(var1) && isPlayer(var1)) {
      combatrecordarchetypedeath(var1, var1.loadoutarchetype);
      return;
    }
  }

  function combatrecordarchetypekill(var0) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
      return;
    }

    var1 = self getplayerdata("mp", "playerStats", "archetypeStats", var0, "kills");
    self setplayerdata("mp", "playerStats", "archetypeStats", var0, "kills", var1 + 1);
  }

  function combatrecordarchetypedeath(var0) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
      return;
    }

    var1 = self getplayerdata("mp", "playerStats", "archetypeStats", var0, "deaths");
    self setplayerdata("mp", "playerStats", "archetypeStats", var0, "deaths", var1 + 1);
  }

  function hide_name_fx_from_players(var0) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
      return;
    }

    var1 = scripts\mp\equipment::isequipmentlethal(var0);

    if(var0 == "equip_throwing_knife_fire" || var0 == "equip_throwing_knife_electric" || var0 == "equip_throwing_knife_drill") {
      var0 = "equip_throwing_knife";
    }

    if(var1) {
      var2 = self getplayerdata("mp", "playerStats", "lethalStats", var0, "uses");
      self setplayerdata("mp", "playerStats", "lethalStats", var0, "uses", var2 + 1);
      return;
    }

    var2 = self getplayerdata("mp", "playerStats", "tacticalStats", var1, "uses");
    self setplayerdata("mp", "playerStats", "tacticalStats", var1, "uses", var2 + 1);
  }

  function combatrecordlethalkill(var0) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
      return;
    }

    var1 = self getplayerdata("mp", "playerStats", "lethalStats", var0, "kills");
    self setplayerdata("mp", "playerStats", "lethalStats", var0, "kills", var1 + 1);
  }

  function combatrecordtacticalstat(var0, var1) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats() || !isPlayer(self)) {
      return;
    }

    if(!isDefined(var1)) {
      var1 = 1;
    }

    var2 = self getplayerdata("mp", "playerStats", "tacticalStats", var0, "extraStat1");
    self setplayerdata("mp", "playerStats", "tacticalStats", var0, "extraStat1", var2 + var1);
  }

  function combatrecordkillstreakstat(var0) {
    if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
      return;
    }

    var1 = scripts\mp\utility\stats::getstreakrecordtype(var0);

    if(!isDefined(var1)) {
      return;
    }

    var2 = self getplayerdata("mp", "playerStats", var1, var0, "extraStat1");
    self setplayerdata("mp", "playerStats", var1, var0, "extraStat1", var2 + 1);
  }

  function enqueuecorpsetablefunc(var0, var1) {
    if(!isDefined(self.corpsetablefuncs)) {
      self.corpsetablefuncs = [];
      self.corpsetablefunccounts = [];
    }

    if(!isDefined(self.corpsetablefuncs[var0])) {
      self.corpsetablefuncs[var0] = var1;
      self.corpsetablefunccounts[var0] = 0;
    }

    self.corpsetablefunccounts[var0]++;
  }

  function dequeuecorpsetablefunc(var0) {
    if(!isDefined(self.corpsetablefuncs)) {
      return;
    }

    if(!isDefined(self.corpsetablefuncs[var0])) {
      return;
    }

    self.corpsetablefunccounts[var0]--;

    if(self.corpsetablefunccounts[var0] <= 0) {
      self.corpsetablefuncs[var0] = undefined;
      self.corpsetablefunccounts[var0] = undefined;
      return;
    }
  }

  function callcorpsetablefuncs() {
    if(!isDefined(self.corpsetablefuncs)) {
      return;
    }

    var0 = self.body;

    foreach(var2 in self.corpsetablefuncs) {
      self thread[[var2]](var0);
    }

    thread clearcorpsetablefuncs();
  }

  function clearcorpsetablefuncs() {
    self notify("clearCorpsetableFuncs");
    self.corpsetablefuncs = undefined;
    self.corpsetablefunccounts = undefined;
  }

  function enqueueweapononkillcorpsetablefuncs(var0, var1, var2, var3, var4) {
    if(scripts\mp\weapons::update_icon_for_bomb_case_detonator_holder(var3)) {
      enqueuecorpsetablefunc("8bitDeath", &scripts\mp\weapons::ref_11df5);
      return;
    }

    if(scripts\mp\weapons::update_jugg_targets(var3)) {
      enqueuecorpsetablefunc("teslaDeath", &scripts\mp\weapons::ref_11df6);
      return;
    }
  }

  function startcopycatoption(var0) {
    level endon("game_ended");
    self endon("disconnect");
    self endon("stop_copy_cat_option");

    if(!isDefined(var0) || !isPlayer(var0) || isbot(self)) {
      return;
    }

    while(self playcinematicforplayerlooping()) {
      waitframe();
    }

    while(!self playcinematicforplayerlooping()) {
      waitframe();
    }

    scripts\mp\class::copyclassfornextlife(var0);
  }

  function stopcopycatoption() {
    self notify("stop_copy_cat_option");
  }

  function unset_force_aitype_sniper(var0) {
    var1 = 0;

    if(isDefined(var0) && isDefined(var0.code_classname) && var0.code_classname == "scriptable") {
      switch (var0.classname) {
        case "scriptable_rp_propane_tank_long_01":
          var1 = 1;
          break;
      }
    }

    return var1;
  }

  function ref_1331e(var0) {
    if(istrue(level.little_bird_mp_initmines)) {
      return false;
    }

    if(isDefined(level.little_bird_onenterheavydamagestate) && ![[level.little_bird_onenterheavydamagestate]](var0)) {
      return false;
    }

    return true;
  }

  function ref_119c0(var0, var1, var2, var3) {
    if(!isDefined(var0) || !isDefined(var1) || !isDefined(var3)) {
      return;
    }

    var4 = var2 >= var0.health;
    var1 scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var1.currentweapon), "friendly_fire_damage", int(min(var2, var0.health)), -1, var1.currentweapon);
    var0 dlog_recordplayerevent("dlog_event_friendly_fire", ["attacker", var1, "damage", var2, "is_fatal_damage", var4, "damage_method", var3]);
  }

  function usecallback(var0) {
    if(!isscriptedagent(var0)) {
      return false;
    }

    return true;
  }

  function ref_12f86(var0, var1, var2) {
    if(!isDefined(var0.unittype) || var2 == "MOD_MELEE ") {
      return var1;
    }

    switch (var0.unittype) {
      case "juggernaut":
        return int(var1 * 0.3);
      case "soldier":
        return int(var1 * 0.4);
    }

    return var1;
  }

  function br_itemrarity(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
    var13 = self;

    if(!isDefined(var1)) {
      return;
    }

    var14 = isDefined(var5) && var5.basename == "tur_gun_bt_mp_bomb";

    if(!istrue(var14) && !var1 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() && !var1 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
      return;
    }

    if(!isDefined(var1.branalytics_publiceventstarted)) {
      var1.br_onvehicledeath = ["run_over_driverless", 0, "run_over", 0, "airplane_explode", 0, "bomb", 0, "bomber_turret", 0, "dauntless", 0, "dauntless_ads", 0, "self_elimination", 0, "other", 0];
    }

    var15 = [];
    var16 = "";

    if(!isent(var13) || !isPlayer(var13)) {
      return;
    }

    if(var1 == var13) {
      var16 = "self_elimination";
    } else if((var1 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var1 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) && var4 == "MOD_CRUSH") {
      var17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var1);

      if(!isDefined(var17)) {
        var16 = "run_over_driverless";
      } else {
        var16 = "run_over";
      }
    } else if(istrue(var14)) {
      var16 = "bomb";
    } else if(isDefined(var5) && var5.basename == "tur_gun_bt_mp") {
      var16 = "bomber_turret";
    } else if(isDefined(var5) && var5.basename == "tur_gun_fd_mp_seeking") {
      var16 = "dauntless_ads";
    } else if(var4 == "MOD_EXPLOSIVE") {
      var16 = "airplane_explode";
    } else {
      var16 = "other";
    }

    switch (var16) {
      case "run_over_driverless":
        var1.br_onvehicledeath[1] += 1;
        break;
      case "run_over":
        var1.br_onvehicledeath[3] += 1;
        break;
      case "airplane_explode":
        var1.br_onvehicledeath[5] += 1;
        break;
      case "bomb":
        var1.br_onvehicledeath[7] += 1;
        break;
      case "bomber_turret":
        var1.br_onvehicledeath[9] += 1;
        break;
      case "dauntless":
        var1.br_onvehicledeath[11] += 1;
        break;
      case "dauntless_ads":
        var1.br_onvehicledeath[13] += 1;
        break;
      case "self_elimination":
        var1.br_onvehicledeath[15] += 1;
        break;
      case "other":
        var1.br_onvehicledeath[17] += 1;
        break;
      default:
        break;
    }

    var1.br_onvehicledeath[var1.br_onvehicledeath.size] = "last_victim_ent_num";
    var1.br_onvehicledeath[var1.br_onvehicledeath.size] = var13 getentitynumber();

    if(isPlayer(var1)) {
      var1 dlog_recordplayerevent("dlog_event_plane_kill_type", var1.br_onvehicledeath);
      return;
    }

    if(isDefined(var1.owner) && isPlayer(var1.owner)) {
      var1.owner dlog_recordplayerevent("dlog_event_plane_kill_type", var1.br_onvehicledeath);
      return;
    }
  }