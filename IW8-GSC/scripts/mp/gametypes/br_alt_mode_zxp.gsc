/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_zxp.gsc
****************************************************/

function init() {
  if(!getdvarint("scr_br_alt_mode_zxp", 0)) {
    return;
  }

  level.disable_super_in_turret.brmayconsiderplayerdead = 1;
  level.disable_super_in_turret.ref_146E7 = 1;
  level.disable_super_in_turret.ref_146C9 = init_warning_levels();
  level.disable_super_in_turret.ref_146BD = getdvarint("scr_br_zxp_health", 300);
  level.disable_super_in_turret.ref_146F1 = getdvarint("scr_br_zxp_zombiesDamageZombies", 0);
  level.disable_super_in_turret.ref_146F2 = getdvarint("scr_br_zxp_zombiesDamageZombiesDamage", 80);
  level.disable_super_in_turret.ref_146F8 = getdvarint("scr_br_zxp_zombieIgnoreVehicleExplosions", 1);
  level.disable_super_in_turret.brking_movenextcirclecenter = getdvarint("scr_br_zxp_allow_zombie_uav", 1);
  level.disable_super_in_turret.ref_146D5 = getdvarfloat("scr_br_zxp_ping_rate", -1);
  level.disable_super_in_turret.ref_146D6 = getdvarfloat("scr_br_zxp_ping_time", 0.5);
  level.disable_super_in_turret.ref_146D2 = getdvarint("scr_br_zxp_num_consume", 4);
  level.disable_super_in_turret.ref_146E5 = getdvarfloat("scr_br_zxp_regen_rate_scale_in_gas", 1);
  level.disable_super_in_turret.ref_146E6 = getdvarfloat("scr_br_zxp_regen_rate_scale_out_gas", 0.5);
  level.disable_super_in_turret.ref_146E3 = getdvarfloat("scr_br_zxp_regen_delay_scale_in_gas", 1);
  level.disable_super_in_turret.ref_146E4 = getdvarfloat("scr_br_zxp_regen_delay_scale_out_gas", 1.5);
  level.disable_super_in_turret.ref_146E2 = getdvarint("scr_br_zxp_powers", 1);
  level.disable_super_in_turret.ref_12820 = getdvarint("scr_br_zxp_powers_cooldown", 1);
  level.disable_super_in_turret.ref_146CF = getdvarfloat("scr_br_zxp_numHits", 3);
  level.disable_super_in_turret.ref_146D0 = getdvarfloat("scr_br_zxp_numHitsJugg", 20);
  level.disable_super_in_turret.ref_146BF = getdvarint("scr_br_zxp_ignoreArmor", 1);
  level.disable_super_in_turret.ref_146E8 = getdvarint("scr_br_zxp_respawn_shutdown_jugg", 1);
  level.disable_super_in_turret.ref_146CE = getdvarfloat("scr_br_zxp_numHitsHeli", 2);
  level.disable_super_in_turret.ref_146CC = getdvarfloat("scr_br_zxp_numHitsAtv", 2);
  level.disable_super_in_turret.ref_146CD = getdvarfloat("scr_br_zxp_numHitsCar", 3);
  level.disable_super_in_turret.ref_146D1 = getdvarfloat("scr_br_zxp_numHitsTruck", 4);
  level.disable_super_in_turret.ref_146FC = getdvarint("scr_br_zxp_spawn_air", 1);
  level.disable_super_in_turret.ref_1470A = getdvarint("scr_br_zxp_vehicle_laststand", 0);
  level.disable_super_in_turret.ref_146FB = getdvarint("scr_br_zxp_zombie_spawn_above", 0);
  level.disable_super_in_turret.spawndragonsbreathstruct = getdvarint("scr_br_zxp_human_spawn_air", 1);
  level.disable_super_in_turret.fluctuatevalues = getdvarint("scr_br_zxp_buyback_human", 1);
  level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback = getdvarint("scr_br_zxp_jugg_num_players", 3);
  level.disable_super_in_turret.vehicle_occupancy_getreserving = getdvarint("scr_br_zxp_jugg_health_icon", 0);
  level.disable_super_in_turret.spawndistancemax = getdvarint("scr_br_zxp_server_hud", 0);
  level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols = getdvarint("scr_br_zxp_jump_trace_up1_offset", 20);
  level.disable_super_in_turret.vehicle_occupancy_mp_changedseats = getdvarint("scr_br_zxp_jump_trace_up2_offset", 30);
  level.disable_super_in_turret.ref_1470C = getdvarint("scr_br_zxp_zombie_vision", 1);
  level.disable_super_in_turret.ref_1470D = getdvarint("scr_br_zxp_zombie_vision_overlay", 1);
  level.disable_super_in_turret.ref_14061 = getdvarint("scr_br_zxp_use_armor_headshot_scale", 0);
  level.disable_super_in_turret.ref_146BC = getdvarfloat("scr_br_zxp_zombie_headshot_scalar", 0.65);
  level.disable_super_in_turret.zombiecanseeandopenloot = getdvarint("scr_br_zxp_zombie_can_see_and_open_loot", 1);
  level.disable_super_in_turret.zombierespawnonexecute = getdvarint("scr_br_zxp_zombie_respawn_on_execute", 1);
  level.disable_super_in_turret.zombierespawnonlaststandexecute = getdvarint("scr_br_zxp_zombie_respawn_on_laststand_execute", 0);
  level.disable_super_in_turret.zombieenableexecution = getdvarint("scr_br_zombie_enable_execution", 1);
  level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 0;
  level.ref_13364 = 1;
  game["dialog"]["zmb_player_into_zombie"] = "zombie_player_into_zombie";
  game["dialog"]["zmb_teammate_into_zombie"] = "zombie_teammate_into_zombie";
  game["dialog"]["zmb_need_someone_alive"] = "zombie_near_end";
  level._effect["zombie_trans"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_transition_to_human.vfx");
  level._effect["zombie_splat"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_freefall_splat.vfx");
  level.disable_super_in_turret.empvfx = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_emp_blast.vfx");
  level.disable_super_in_turret.start_coop_defuse_infiltrate = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_human_push_blast");
  thread toggleusbstickinhand();
}

function toggleusbstickinhand() {
  waittillframeend();

  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving) {
    level.vehicle_occupancy_forceweaponswitchallowed = undefined;
  }

  thread ref_13283();
  thread ref_1472D();
}

function ref_126A4() {
  var_0 = self;

  if(!isDefined(var_0.spawndomplateflag)) {
    ref_12725(var_0);
  }

  wait 0.5;
  ref_125FC(var_0);
  wait 2;
  ref_12723(var_0, 0);
}

function modifyplayerdamage(var_0) {
  var_1 = var_0.damage;
  var_2 = isPlayer(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::ref_125F3();
  var_3 = isDefined(var_0.attacker) && nukefridgewatcher(var_0.attacker);
  var_4 = isPlayer(var_0.victim) && var_0.victim scripts\mp\gametypes\br_public::ref_125F3();
  var_5 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0.objweapon);

  if(var_2 && var_4 && var_0.meansofdeath == "MOD_MELEE") {
    if(!level.disable_super_in_turret.ref_146F1) {
      var_1 = 0;
    } else {
      var_1 = level.disable_super_in_turret.ref_146F2;
    }
  } else if(var_2 && !var_4 && !var_0.attacker isinexecutionattack() && var_0.victim isinexecutionvictim()) {
    var_1 = 0;
  } else if(isDefined(var_0.attacker) && istrue(var_0.attacker.isjuggernaut) && var_4 && var_0.meansofdeath == "MOD_MELEE") {
    var_1 = var_0.victim.maxhealth / 3;
  } else if(var_4 && var_0.meansofdeath == "MOD_FALLING") {
    var_1 = 0;
  } else if(var_4 && isDefined(var_0.inflictor) && isDefined(var_0.inflictor.streakinfo) && (var_0.inflictor.streakinfo.streakname == "toma_strike" || var_0.inflictor.streakinfo.streakname == "precision_airstrike" || var_0.inflictor.streakinfo.streakname == "manual_turret")) {
    var_6 = var_0.victim.maxhealth;
    var_7 = var_0.attacker.maxhealth;
    var_1 = var_0.damage * int(floor(var_6 / var_7));
  } else if(level.disable_super_in_turret.ref_146F8 && var_4 && isexplosivedamagemod(var_0.meansofdeath) && isDefined(var_0.inflictor) && var_0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_1 = 0;
  } else if(var_4 && (var_0.meansofdeath == "MOD_GRENADE_SPLASH" || var_0.meansofdeath == "MOD_EXPLOSIVE")) {
    var_1 = var_0.damage * getdvarfloat("scr_br_zxp_explosive_dmg_multiplier", 3);
  } else if(var_2 && !var_4 && var_0.meansofdeath == "MOD_MELEE") {
    var_8 = var_0.victim.maxhealth;
    var_9 = level.disable_super_in_turret.ref_146CF;

    if(istrue(var_0.victim.isjuggernaut)) {
      var_9 = level.disable_super_in_turret.ref_146D0;
    }

    if(!level.disable_super_in_turret.ref_146BF) {
      var_8 += var_0.victim.br_maxarmorhealth;
    }

    var_1 = int(ceil(var_8 / var_9));
  } else if(var_4 && var_3 && istrue(var_0.victim.ref_1423B)) {
    var_1 = 0;
  } else if(var_2 && !var_4 && var_0.meansofdeath == "MOD_IMPACT" && var_5 == "rock_mp") {
    var_10 = spawnStruct();
    var_10.origin = var_0.point;
    var_0.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_10, var_0.attacker);
  } else if(var_4) {
    var_11 = 0.7;
    var_12 = scripts\mp\utility\weapon::getweaponrootname(var_0.objweapon);
    var_13 = weaponclass(var_5);
    var_14 = scripts\mp\gametypes\br::tutzonetriggerlogic(var_0.idflags);

    if(!var_14) {
      switch (var_13) {
        case "sniper":
          if(var_0.shitloc == "head" || var_0.shitloc == "helmet") {
            if(scripts\mp\gametypes\br::usefailvehiclemsg(var_12)) {
              var_1 = int(ceil(level.disable_super_in_turret.ref_146BD * var_11));
            } else {
              var_1 = level.disable_super_in_turret.ref_146BD;
            }
          }

          break;
        default:
          if(var_0.shitloc == "head" || var_0.shitloc == "helmet") {
            var_15 = getdvarfloat("scr_player_maxhealth", 100);
            var_16 = var_15;

            if(level.disable_super_in_turret.ref_14061) {
              var_16 += scripts\mp\gametypes\br_armor::getdefaultmaxarmorhealth();
            }

            var_1 = int(ceil(var_1 / var_16 * level.disable_super_in_turret.ref_146BD * level.disable_super_in_turret.ref_146BC));
          }

          break;
      }
    }

    var_17 = "scr_br_zxp_scale_" + var_13;
    var_18 = 0;

    if(var_13 == "spread") {
      var_18 = 0.7;
    }

    var_19 = getdvarfloat(var_17, var_18);

    if(var_19 != 0) {
      var_1 = int(ceil(var_1 * var_19));
    }

    var_20 = "scr_br_zxp_scale_" + var_12;
    var_18 = 0;

    if(var_12 == "iw8_sh_charlie725") {
      var_18 = 1.43;
    }

    var_21 = getdvarfloat(var_20, var_18);

    if(var_21 != 0) {
      var_1 = int(ceil(var_1 * var_21));
    }
  }

  return var_1;
}

function nukefridgewatcher() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle";
}

function ref_11CA1(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.victim;
  var_3 = isPlayer(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::ref_125F3();
  var_4 = var_2.vehiclename;

  if(var_3 && var_0.meansofdeath == "MOD_MELEE") {
    switch (var_4) {
      case "atv":
        var_1 = var_2.maxhealth / level.disable_super_in_turret.ref_146CC;
        break;
      case "tac_rover":
      case "jeep":
        var_1 = var_2.maxhealth / level.disable_super_in_turret.ref_146CD;
        break;
      case "cargo_truck_mg":
      case "cargo_truck":
        var_1 = var_2.maxhealth / level.disable_super_in_turret.ref_146D1;
        break;
      case "little_bird_mg":
      case "little_bird":
        var_1 = var_2.maxhealth / level.disable_super_in_turret.ref_146CE;
        break;
      default:
        break;
    }

    var_1 = int(ceil(var_1));
  }

  return var_1;
}

function ref_11B80(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return true;
  }

  var_2 = playershouldzombiespawn(var_0, var_1);

  if(var_2) {
    var_0.respawningfromtoken = 1;
  } else if(scripts\mp\gametypes\br_public::ref_125F3()) {
    thread ref_12538();
  }

  return !var_2;
}

function ref_1365D(var_0) {
  if(istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done") && var_0 scripts\mp\gametypes\br_public::ref_125F3()) {
    ref_12645(var_0);
    return true;
  }

  return false;
}

function ref_11B16() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  return !istrue(self.respawningfromtoken);
}

function playershouldzombiespawn(var_0) {
  if(!istrue(var_0)) {
    if(scripts\mp\gametypes\br_public::ref_125F3()) {
      return false;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.disable_super_in_turret.ref_146E7) {
    return false;
  }

  return true;
}

function ref_126D2(var_0) {
  if(!istrue(var_0)) {
    if(scripts\mp\gametypes\br_public::ref_125F3()) {
      thread ref_12538();
      return false;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.disable_super_in_turret.ref_146E7) {
    return false;
  }

  thread ref_12723(0);
  return true;
}

function ref_125F7(var_0, var_1) {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(level.gameended) {
    return true;
  }

  if(istrue(self.ref_12CA8)) {
    return true;
  }

  if(istrue(self.respawningfromtoken) && !scripts\mp\gametypes\br_public::ref_125F3()) {
    self.respawningfromtoken = undefined;
    thread ref_12723(0);
  } else if(!scripts\mp\utility\damage::playershoulddofauxdeath(0)) {
    var_0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, var_1);
  }

  return true;
}

function ref_12538() {
  self endon("disconnect");
  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);

  if(level.disable_super_in_turret.ref_1470C) {
    ref_125DA();

    if(!level.disable_super_in_turret.ref_1470D) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    scripts\mp\utility\player::restorebasevisionset(0);
  }

  waittillframeend();
  ref_12681(0, 1);
  ref_1262B(0);
}

function ref_125DA() {
  foreach(var_1 in level.players) {
    if(!var_1 scripts\mp\gametypes\br_public::ref_125F3()) {
      var_1 hudoutlinedisableforclient(self);
    }
  }
}

function ref_12681(var_0, var_1) {
  self.iszombie = var_0;
  ref_12682(var_0);

  if(isDefined(level.disable_super_in_turret.ref_11B5B)) {
    scripts\mp\gametypes\br_gametype_zxp::ref_126E6(var_0);
  }

  if(var_0) {
    self notify("zombie_set");

    if(level.disable_super_in_turret.spawndistancemax) {
      ref_12725();
    }

    self.ref_11F39 = 0;
    self.bcdisabled = 1;
    self.plunderlimit = 1;
    ref_1267D(0);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(9);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(10);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(11);
    ref_14033("numVaccine", self.ref_11F39);
  } else {
    self notify("zombie_unset");
    self.ref_11F39 = undefined;
    self.bcdisabled = undefined;
    self.plunderlimit = undefined;
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);

    if(isDefined(level.disable_super_in_turret.ref_11B5B) && !istrue(level.disable_super_in_turret.showdogtagstohumans)) {
      scripts\mp\gametypes\br_gametype_zxp::ref_125CE();
    }
  }

  level notify("players_remaining_changed");
  scripts\cp_mp\utility\train_utility::br_ammorestock_playerupdatestructures();
  scripts\mp\gametypes\br_comms_tower::ref_126E0();

  if(isDefined(level.playerupdateboatpromptsfunc)) {
    self[[level.playerupdateboatpromptsfunc]](self.iszombie);
  }

  self notify("stop_battlechatter");

  if(istrue(var_1)) {
    self lerpfovbypreset("default");

    if(level.disable_super_in_turret.ref_1470D) {
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
      return;
    }

    return;
  }
}

function init_warning_levels() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function spawnangle(var_0) {
  var_1 = getarraykeys(level.teamdata);

  foreach(var_3 in var_1) {
    var_4 = level.teamdata[var_3]["players"];

    foreach(var_6 in var_4) {
      if(var_6 scripts\mp\gametypes\br_public::ref_125F3()) {
        if(level.disable_super_in_turret.spawndistancemax) {
          ref_12700(var_6);
        }

        ref_12631(var_6);
        continue;
      }

      ref_12631(var_6);
    }
  }
}

function vandalize_target_think(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isalive(var_0) && !istrue(var_0.respawningfromtoken) && !var_0 scripts\mp\gametypes\br_public::ref_125F3()) {
    return false;
  }

  return !istrue(var_0.delay_enter_combat_after_investigating_grenade) || var_0 scripts\mp\gametypes\br_public::ref_125F3();
}

function get_chopper_minigun_start_node(var_0) {
  if(var_0.scriptablename == "brloot_zmb_stim") {
    if(self.ref_11F39 >= level.disable_super_in_turret.ref_146D2) {
      return 12;
    }

    return 1;
  }

  return undefined;
}

function ref_12725() {
  var_0 = -60;
  var_1 = 120;
  var_2 = 180;
  self.spawnboardroom_juggdrop = ref_12530(var_0, var_1, "right", "middle", "center", "middle", &"MP_ZXP/NUM_CONSUMED", 0);
  self.spawnboardroom_loadoutdrop = ref_12530(var_0, var_1, "left", "middle", "center", "middle", &"MP_ZXP/NUM_TO_CONSUME", level.disable_super_in_turret.ref_146D2);
  self.spawndomplateflag = ref_12530(0, var_2, "center", "middle", "center", "middle", &"MP_ZXP/ZOMBIE");
}

function ref_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 0;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6)) {
    var_8.label = var_6;
  }

  if(isDefined(var_7)) {
    var_8 setvalue(var_7);
  }

  return var_8;
}

function ref_12682(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 4096;
    return;
  }

  self.game_extrainfo &= ~4096;
}

function ref_12723(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("zombie_unset");

  if(level.gameended) {
    return;
  }

  if(!isDefined(level.teamdata[self.team]["lastZombieTime"]) && !isDefined(level.ref_12D05)) {
    scripts\mp\gametypes\br_public::dmztut_luicallback("zmb_need_someone_alive", self.team);
  }

  ref_131CD(self.team);
  ref_1267D(1);
  ref_12727(1);
  waittillframeend();
  ref_12681(1);

  if(istrue(var_1)) {
    scripts\mp\gametypes\br::ref_13F21(self, "outbreak");
  } else {
    self.ref_12CA8 = 1;
  }

  if(isDefined(level.ref_12D05)) {
    ref_12645();
  } else if(var_0) {
    ref_126EE();
  } else {
    ref_12645();
  }

  jumpiffalse(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerGetZombieSpawnLocation")) LOC_000000e9;
  var_2 = scripts\mp\gametypes\br_gametypes::ref_12E05("playerGetZombieSpawnLocation");
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_2 = undefined;
  goto LOC_00000101;
}

function ref_1264B(var_0) {
  if(scripts\mp\gametypes\br_public::ref_125F3()) {
    if(istrue(self.ref_146C0)) {
      return int(level.disable_super_in_turret.ref_146E5 * var_0);
    } else {
      return int(level.disable_super_in_turret.ref_146E6 * var_0);
    }
  }

  return undefined;
}

function ref_1262B(var_0) {
  if(!istrue(level.disable_super_in_turret.zombiecanseeandopenloot)) {
    scripts\mp\gametypes\br_public::ref_125CF(var_0);
  }

  if(var_0) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.spawnboardroom_juggdrop.alpha = 1;
      self.spawnboardroom_loadoutdrop.alpha = 1;
      self.spawndomplateflag.alpha = 1;
    }

    self disableweaponpickup();
    return;
  }

  ref_12700();
  self enableweaponpickup();
}

function ref_131CD(var_0) {
  level.teamdata[var_0]["lastZombieTime"] = gettime();
}

function ref_1267D(var_0) {
  self.tut_popup_listener = var_0;
}

function ref_12727(var_0) {
  var_1 = self.team;
  scripts\mp\utility\teams::ref_140C9("mode", var_1, self);
  ref_126D8();

  if(istrue(var_0)) {
    [[level.updategameevents]]();
    return;
  }
}

function ref_12700() {
  if(isDefined(self.spawnboardroom_juggdrop)) {
    thread kioskfiresaledoneforplayer(self.spawnboardroom_juggdrop, 1.5);
  }

  if(isDefined(self.spawnboardroom_loadoutdrop)) {
    thread kioskfiresaledoneforplayer(self.spawnboardroom_loadoutdrop, 1.5);
  }

  if(isDefined(self.spawndomplateflag)) {
    self.spawndomplateflag destroy();
  }

  self.spawnboardroom_juggdrop = undefined;
  self.spawnboardroom_loadoutdrop = undefined;
  self.spawndomplateflag = undefined;
}

function kioskfiresaledoneforplayer(var_0, var_1) {
  wait var_1;

  if(isDefined(var_0)) {
    var_0 destroy();
    return;
  }
}

function ref_125FA() {
  return isDefined(self.ref_1472F);
}

function ref_1264A(var_0) {
  if(scripts\mp\gametypes\br_public::ref_125F3()) {
    if(istrue(self.ref_146C0)) {
      return (1 / level.disable_super_in_turret.ref_146E3 * var_0);
    } else {
      return (1 / level.disable_super_in_turret.ref_146E4 * var_0);
    }
  }

  return undefined;
}

function onuse(var_0) {
  thread ref_120A7(var_0);
}

function ref_120A7(var_0) {
  if(!isDefined(var_0)) {
    thread scripts\mp\gametypes\br_gametype_zxp::removelootsyringe(self);
    return;
  }

  if(!playercanusetags(var_0)) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  thread scripts\mp\gametypes\br_gametype_zxp::removelootsyringe(self, undefined, var_0);

  if(var_0.ref_11F39 >= level.disable_super_in_turret.ref_146D2) {
    return;
  }

  var_0.ref_11F39++;

  if(level.disable_super_in_turret.spawndistancemax) {
    ref_125D4(var_0);
  }

  ref_14033(var_0, "numVaccine", var_0.ref_11F39);

  if(isDefined(level.disable_super_in_turret.ref_11B5B) && var_0.ref_11F39 >= level.disable_super_in_turret.ref_146D2) {
    var_0 thread scripts\mp\gametypes\br_gametype_zxp::ref_126FA();
    return;
  }
}

function playercanusetags(var_0) {
  return var_0 scripts\mp\gametypes\br_public::ref_125F3();
}

function ref_125D4() {
  var_0 = (0, 1, 0);
  self.spawnboardroom_juggdrop setvalue(self.ref_11F39);
  thread spawn_vindia_assault3(self.spawnboardroom_juggdrop);
  thread spawn_vindia_assault3(self.spawnboardroom_loadoutdrop);
}

function spawn_vindia_assault3(var_0) {
  self endon("death");

  if(istrue(self.ref_1293B)) {
    return;
  }

  var_1 = 0.5;
  var_2 = 4;
  self.ref_1293B = 1;
  var_3 = self.fontscale;
  var_4 = self.color;

  if(isDefined(var_0)) {
    self.color = var_0;
  }

  self changefontscaleovertime(var_1);
  self.fontscale = var_2;
  wait var_1;
  self changefontscaleovertime(var_1);
  self.fontscale = var_3;
  wait var_1;
  self.color = var_4;
  self.ref_1293B = undefined;
}

function ref_125FC() {
  var_0 = spawnStruct();
  var_0.current = self getcurrentprimaryweapon();
  var_0.ref_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename)) {
      var_1 = var_4;
    }
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);
    var_0.brtdm_config[var_8] = weaponclipsize(var_7);
    var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7)) {
      var_0.brtruck_cleanupents[var_8] = self getweaponammoclip(var_7, "left");
    }

    if(getsubstr(var_8, 0, 4) == "alt_") {
      continue;
    }

    var_0.ref_12889[var_0.ref_12889.size] = var_7;
  }

  var_10 = self getweaponslistoffhands();

  foreach(var_12 in var_10) {
    if(var_12.basename == "bandage_br") {
      continue;
    }

    var_13 = self getweaponammoclip(var_12);

    if(var_13 <= 0) {
      continue;
    }

    var_0.offhands[var_0.offhands.size] = var_12;
    var_14 = createheadicon(var_12);
    var_0.brtdm_config[var_14] = var_13;
  }

  foreach(var_17 in self.equipment) {
    var_0.nvidiaansel_overridecollisionradius[var_17] = var_18;
  }

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var_0.super = self.equipment["super"];
  }

  self.ref_1472F = var_0;
}

function ref_126EE() {
  if(scripts\mp\gametypes\br_public::ref_125F3()) {
    self waittill("spawnZombie");
    return;
  }
}

function ref_12645() {
  self notify("spawnZombie");
  self method_87aa("zombie");
  self setclothtype("cloth");
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(self);
}

function run_track_enemy_patrollers(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_3, 1)) {
    var_4 = vectortoangles(var_1 * -1);
    return [var_3, var_4];
  }

  return [undefined, undefined];
}

function ref_1270E() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = getdvarfloat("scr_br_zxp_respawnTeamOffset", 10000);

  if(var_2 >= 0) {
    var_3 = scripts\mp\gametypes\br_gulag::ref_12568(0);

    if(isDefined(var_3)) {
      var_0 = rocket_fuel_stability(var_3.origin, var_2);

      if(istrue(level.usenavmeshforzombierespawn) && isscriptabledefined()) {
        var_0 = getclosestpointonnavmesh(var_0);
      }

      var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0);
      var_1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_0, var_3.origin);
    }
  }

  return [var_0, var_1];
}

function rocket_fuel_stability(var_0, var_1) {
  var_2 = 3.14159;
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_4 = vectorNormalize(var_0 - var_3);
  var_5 = vectortoangles(var_4);
  var_6 = randomfloatrange(getdvarfloat("scr_br_respawn_rand_ang_min", 10), getdvarfloat("scr_br_respawn_rand_ang_max", 60));
  var_7 = var_4;
  var_8 = var_0 + var_7 * var_1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_7 *= -1;
  var_8 = var_0 + var_7 * var_1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_7 = vectorNormalize(var_3 - var_0);
  var_8 = var_0 + var_7 * var_1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_9 = var_1;
  var_10 = distance2d(var_0, var_3);
  var_11 = var_9 / var_10;

  if(var_11 > var_2) {
    var_11 = var_2;
  }

  var_12 = var_11 * 180 / var_2;
  var_8 = rotatepointaroundvector((0, 0, 1), var_0 - var_3, var_12) + var_3;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_8 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0, var_1);

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  return undefined;
}

function ref_12582() {
  var_0 = 50;
  var_1 = 10000;
  var_2 = ref_1270E();
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_2 = undefined;

  if(isDefined(var_3)) {
    var_3 = checkspawnwithinmapradius(var_3);
    return [var_3, var_4];
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret.ref_146FB)) {
    return [self.origin, self getplayerangles()];
  }

  var_5 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_6 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_7 = var_5 + var_0;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_6);
  var_10 = run_track_enemy_patrollers(var_6, var_9, var_7);
  var_11 = var_10[0];
  var_4 = var_10[1];
  var_10 = undefined;

  if(!isDefined(var_11)) {
    var_9 *= -1;
    var_12 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_12[0];
    var_4 = var_12[1];
    var_12 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (1, 0, 0);
    var_13 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_13[0];
    var_4 = var_13[1];
    var_13 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (-1, 0, 0);
    var_14 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_14[0];
    var_4 = var_14[1];
    var_14 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (0, 1, 0);
    var_15 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_15[0];
    var_4 = var_15[1];
    var_15 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (0, -1, 0);
    var_16 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_16[0];
    var_4 = var_16[1];
    var_16 = undefined;
  }

  if(!isDefined(var_11)) {
    var_11 = self.origin;
    var_4 = self.angles;
  }

  var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_11, var_1);
  var_3 = checkspawnwithinmapradius(var_3);
  return [var_3, var_4];
}

function ref_12722(var_0, var_1) {
  var_2 = var_0;

  if(level.disable_super_in_turret.ref_146FC) {
    var_3 = getdvarint("scr_br_zxp_respawnZombieHeight", 10000);
    var_4 = (0, 0, var_3);
    var_0 = scripts\mp\gametypes\br::getoffsetspawnorigin(var_0, var_4);
    var_5 = spawnStruct();
    var_5.origin = var_0;
    var_5.angles = var_1;
    var_5.height = var_3;
    var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_5);
  } else {
    self calloutmarkerping_getinventoryslot(0);
    scripts\mp\gametypes\br_public::ref_126B9(var_2);
  }

  return [var_0, var_2];
}

function ref_126BD(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_gulag::ref_126C3(var_2, var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tag_origin");
  var_3.angles = var_1;
  var_3 hide();
  var_3 showtoplayer(self);
  self playerlinktoabsolute(var_3, "tag_origin");
  self playerhide();
  thread scripts\mp\gametypes\br_gulag::ref_12524(var_3);
  waitframe();
  scripts\mp\gametypes\br_public::ref_126ED();
  scripts\mp\gametypes\br_public::ref_1252B();
  var_3.origin = var_0;
  waitframe();
  self unlink();
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  var_4 = 0;

  if(isDefined(level.ref_121CC)) {
    var_4 = level.ref_121CC;
  }

  thread scripts\cp_mp\parachute::startfreefall(var_4, 0, undefined, undefined, 1);
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_show_spectateHud", -1);
  scripts\mp\gametypes\br_gulag::ref_12C7A();
  wait 0.5;
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  waitframe();
  var_3 delete();
  self notify("can_show_splashes");
}

function ref_126FF() {
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(level.disable_super_in_turret.ref_1470C) {
    self hudoutlinedisable();

    if(!level.disable_super_in_turret.ref_1470D) {
      self setscriptablepartstate("headVFX", "zombieVision");
    }

    if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
      self visionsetnakedforplayer("mp_escape4_wz_zmb", 0);
      thread playerzombieambienceoverride();
    } else {
      self visionsetnakedforplayer("mp_don3_wz_zmb", 0);
    }

    ref_12713();
  }

  waitframe();

  if(getdvarint("scr_br_zxp_loop_zombie_fx", 1)) {
    self setscriptablepartstate("zombie", "on_loop");
    return;
  }

  self setscriptablepartstate("zombie", "on");
}

function playerzombieambienceoverride() {
  self endon("disconnect");
  self setclienttriggeraudiozonepartial("player_is_zombie", "ambient");
  scripts\engine\utility::ref_143A5("zombie_unset", "death");
  self clearclienttriggeraudiozone(1);
}

function ref_12713() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  var_1 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(var_3 in var_0) {
    scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "outline_depth_zombievision_friendly", "top");
  }

  foreach(var_3 in var_1) {
    if(!var_3 scripts\mp\gametypes\br_public::ref_125F3()) {
      scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "outline_depth_zombievision_enemy", "top");
    }
  }
}

function playerhumanhudoutlineenable() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  var_1 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 scripts\mp\gametypes\br_public::ref_125F3()) {
      scripts\mp\utility\outline::outlineenableforplayer(self, var_3, "outline_depth_zombievision_friendly", "top");
    }
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && var_3 scripts\mp\gametypes\br_public::ref_125F3()) {
      scripts\mp\utility\outline::outlineenableforplayer(self, var_3, "outline_depth_zombievision_enemy", "top");
    }
  }
}

function ref_1270D() {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("disconnect");
  self.ref_146C0 = undefined;

  for(;;) {
    if(ref_12714()) {
      if(!isDefined(self.ref_146C0) || !self.ref_146C0) {
        self.ref_146C0 = 1;
        ref_12705();
      }
    } else if(!isDefined(self.ref_146C0) || self.ref_146C0) {
      self.ref_146C0 = 0;
      ref_12706();
    }

    waitframe();
  }
}

function ref_12705() {
  self notify("zombie_enter_gas");
  self unsetperk("specialty_radarblip", 1);
}

function ref_12706() {
  self notify("zombie_exit_gas");

  if(level.disable_super_in_turret.ref_146D5 >= 0) {
    if(level.disable_super_in_turret.ref_146D5 == 0) {
      self setperk("specialty_radarblip", 1);
      return;
    }

    thread ref_1271F();
    return;
  }
}

function ref_1271F() {
  if(level.disable_super_in_turret.ref_146D5 <= 0) {
    return;
  }

  self endon("zombie_unset");
  self endon("zombie_enter_gas");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setperk("specialty_radarblip", 1);
    wait level.disable_super_in_turret.ref_146D6;
    self unsetperk("specialty_radarblip", 1);
    wait level.disable_super_in_turret.ref_146D5;
  }
}

function ref_12714() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var_0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return distance2dsquared(var_0, self.origin) > var_1 * var_1;
}

function ref_12724() {
  self endon("disconnect");
  self.ref_133E9 = 1;
  self.radarmode = "normal_radar";
  self.hasradar = 1;
  self waittill("zombie_unset");
  self.ref_133E9 = undefined;
  self.hasradar = 0;
}

function ref_1272A() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  for(;;) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    waitframe();
  }
}

function ref_12710(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(istrue(self.respawnedfromoutbreak)) {
    self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);
  }

  wait 1;

  while(!self isonground()) {
    ref_125B8(var_0);
    waitframe();
  }

  self setclientomnvar("ui_br_altimeter_state", 0);
  self skydive_interrupt();
  playFX(level._effect["zombie_splat"], self.origin);
  self playsoundtoplayer("zxp_spawn_splat_plr", self, self);
  self playSound("zxp_spawn_splat_npc", self, self);
  self freezecontrols(1);
  var_2 = gettime() + 2000;

  while(self getcurrentprimaryweapon().classname == "none" && gettime() < var_2) {
    ref_125B8(var_0);
    waitframe();
  }

  var_3 = propwaitminigameinit(self, 0);

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 1);
  }

  var_4 = anglesToForward(self.angles);
  var_5 = vectortoangles(var_3);
  var_6 = angleclamp180(var_5[0] + 90);
  var_5 = (0, var_5[1], 0);
  var_7 = anglesToForward(var_5);
  var_8 = vectordot(var_7, var_4);
  var_9 = var_8 * var_6;
  var_10 = getdvarint("scr_br_zxp_zombie_splat_down_clamp", 20);
  var_11 = getdvarint("scr_br_zxp_zombie_splat_up_clamp", -70);

  if(var_9 > 0) {
    var_9 = min(var_10, var_9);
  } else {
    var_9 = max(var_11, var_9);
  }

  self setplayerangles((var_9, self.angles[1], 0));

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
  thread ref_12720();
  ref_125B8(var_0);

  if(istrue(self.respawnedfromoutbreak)) {
    self.respawnedfromoutbreak = undefined;
    self setscriptablepartstate("skydiveVfx", "default", 0);
  }

  if(istrue(var_1)) {
    wait 0.5;
  } else {
    wait 1;
  }

  self freezelookcontrols(0);

  if(istrue(var_1)) {
    wait 0.5;
  } else {
    wait 1;
  }

  self allowsprint(1);
}

function ref_125B8(var_0) {
  if(!self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  }

  if(self getcurrentprimaryweapon().classname == "none") {
    thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
    return;
  }
}

function ref_11ECD(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_0, var_2.team)) {
      var_2 scripts\mp\hud_message::showsplash("br_gametype_zxp_jugg_team");
      continue;
    }

    var_2 scripts\mp\hud_message::showsplash("br_gametype_zxp_jugg_other");
  }
}

function clear_tier_lights_all(var_0) {
  ref_11ECD(var_0);

  foreach(var_2 in var_0) {
    var_3 = level.teamdata[var_2]["alivePlayers"];

    foreach(var_5 in var_3) {
      if(isalive(var_5) && !var_5 scripts\mp\gametypes\br_public::ref_125F3()) {
        if(level.disable_super_in_turret.spawndomplateflagtestmap) {
          ref_125FC(var_5);
        }

        ref_1250E(var_5);
      }
    }
  }
}

function ref_1250E() {
  if(istrue(self.inlaststand)) {
    scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", self);
  }

  scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);

  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving) {
    objective_icon(self.juggcontext.juggobjid, "icon_waypoint_jugg");
    objective_state(self.juggcontext.juggobjid, "current");
    objective_setzoffset(self.juggcontext.juggobjid, 70);
    objective_setprogress(self.juggcontext.juggobjid, 0.99);
    objective_setshowprogress(self.juggcontext.juggobjid, 1);
    objective_setprogressteam(self.juggcontext.juggobjid, self.team);
    objective_setbackground(self.juggcontext.juggobjid, 1);
    function_0421(self.juggcontext.juggobjid, 1);
    return;
  }
}

function onplayerdamaged(var_0) {
  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving && istrue(var_0.victim.isjuggernaut)) {
    var_1 = var_0.victim.health / var_0.victim.maxhealth;
    objective_setprogress(var_0.victim.juggcontext.juggobjid, var_1);

    if(isDefined(var_0.attacker)) {
      thread ref_12612(var_0.attacker, var_0.victim.juggcontext.juggobjid);
    }
  }

  var_2 = isDefined(var_0.attacker) && isDefined(var_0.attacker.ref_12369);
  var_3 = var_0.victim getentitynumber();
  var_4 = var_2 && isDefined(var_0.attacker.ref_12369.ref_13A72) && isDefined(var_0.attacker.ref_12369.ref_13A72[var_3]) && var_0.attacker.ref_12369.ref_13A72[var_3] == var_0.victim;

  if(var_0.victim scripts\mp\gametypes\br_public::ref_125F3() && var_4) {
    thread removepingondamageheadicon(var_0.attacker, var_0.victim);
    return;
  }
}

function removepingondamageheadicon(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();
  var_0 endon("removeHeadIcon_" + var_2);
  var_3 = "removePingOnDamageHeadIcon_" + var_2;
  self notify(var_3);
  self endon(var_3);
  var_0 waittill("zombie_unset");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1);
}

function ref_12612(var_0, var_1) {
  self endon("disconnect");
  self notify("playerPinObjective");
  self endon("playerPinObjective");
  objective_pinforclient(var_0, self);
  var_1 scripts\engine\utility::waittill_notify_or_timeout("death", 1);
  objective_unpinforclient(var_0, self);
}

function ref_13283() {
  if(!level.disable_super_in_turret.ref_146E2) {
    return;
  }

  level.disable_super_in_turret.ref_14693 = spawnStruct();
  level.disable_super_in_turret.ref_14693.powers = [];
  battlepassxpmultipliers(level.disable_super_in_turret.ref_14693, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &ref_12716, 0, undefined, &ref_12718, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress");
  battlepassxpmultipliers(level.disable_super_in_turret.ref_14693, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &ref_1271B, 0);
  battlepassxpmultipliers(level.disable_super_in_turret.ref_14693, "gas", "+smoke", &ref_12707, 0, &ref_1270A, &ref_12708, &ref_12709, &"MP_ZXP/GAS_GRENADE", undefined, 15, "gasGrenadeStatus", "gasGrenadeProgress");
  battlepassxpmultipliers(level.disable_super_in_turret.ref_14693, "emp", "+frag", &ref_12703, 0, undefined, undefined, undefined, &"MP_ZXP/EMP", undefined, 15, "empStatus", "empProgress");

  if(getdvarint("scr_br_zxp_bumper_ping_support", 1)) {
    battlepassxpmultipliers(level.disable_super_in_turret.ref_14693, "gas_or_emp", ["+equip_toggle_throw"], &ref_1270B, 0, undefined, &ref_1270C);
    return;
  }
}

function battlepassxpmultipliers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = "scr_br_zxp_power_" + var_1;

  if(getdvarint(var_13, 1) == 0) {
    return;
  }

  if(isstring(var_2)) {
    var_2 = [var_2];
  }

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
  var_0.powers[var_1].ref_1387B = var_5;
  var_0.powers[var_1].has_ammo_drain_passive = var_6;
  var_0.powers[var_1].ref_127FC = var_7;
  var_0.powers[var_1].label = var_8;
  var_0.powers[var_1].waitforstreamsynccomplete = var_9;
  var_0.powers[var_1].idmask = var_10;
  var_0.powers[var_1].ref_1388F = var_11;
  var_0.powers[var_1].ref_128BE = var_12;
  var_0.powers[var_1].ref_13060 = var_4;
}

function ref_1270B(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("playerZombieGasOrEMP");
  self endon("playerZombieGasOrEMP");
  var_2 = gettime() + getdvarint("scr_br_zxp_gas_or_emp_timeout_ms", 500);

  while(var_2 > gettime()) {
    if(self secondaryoffhandbuttonPressed()) {
      self notify("gas");
      break;
    } else if(self fragButtonPressed()) {
      self notify("emp");
      break;
    }

    waitframe();
  }
}

function ref_12703(var_0, var_1) {
  var_2 = 60;
  var_3 = 1;
  var_4 = 64;
  var_5 = var_4 * var_4;
  var_6 = 768;
  var_7 = var_6 * var_6;
  var_8 = "zxp_emp_fire_plr";
  var_9 = self;
  var_9 enableplayerbreathsystem(0);
  var_9 playsoundonmovingent(var_8);
  var_9 playsoundtoplayer("zmb_effort_empblast", self, self);
  var_9 playSound("zmb_npc_effort_empblast", var_9, var_9);
  thread ref_14697(var_9);
  var_10 = anglesToForward(var_9.angles);
  playFX(level.disable_super_in_turret.empvfx, var_9.origin, var_10);
  var_11 = getcompleteweaponname("emp_drone_non_player_mp");
  var_12 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var_13 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_15 in var_13) {
    var_16 = var_15.owner;
    jumpiffalse(isDefined(var_16)) LOC_000000d6;
    var_17 = distancesquared(var_9.origin, var_15.origin);

    if(var_17 > var_7) {
      continue;
    }

    var_18 = scripts\engine\utility::ter_op(var_17 > var_5, var_11, var_12);
    var_15 dodamage(1, var_9.origin, var_9, var_9, "MOD_EXPLOSIVE", var_18);
    var_15 playsoundonmovingent("zxp_emp_impact_ent");
    var_19 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_9, var_15, 1, var_18, "MOD_EXPLOSIVE", var_9, var_9.origin);
    thread ref_126F9(var_19);
    LOC_00000149:
  }

  var_21 = getcompleteweaponname("emp_drone_player_mp");
  var_22 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_22 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var_9.origin, var_6);
  }

  foreach(var_24 in var_22) {
    if(var_24 scripts\mp\gametypes\br_public::ref_125F3()) {
      continue;
    }

    if(!var_24 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var_24 != var_9 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_9, var_24)) {
      continue;
    }

    var_24 dodamage(1, var_9.origin, var_9, var_9, "MOD_EXPLOSIVE", var_21);
    var_19 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_9, var_24, 1, var_21, "MOD_EXPLOSIVE", var_9, var_9.origin);
    thread ref_126F9(var_19);
    LOC_00000221:
  }

  thread ref_1262C(var_0, var_1);
}

function ref_14697(var_0) {
  if(isDefined(var_0)) {
    wait var_0;
  }

  self enableplayerbreathsystem(1);
}

function ref_1262C(var_0, var_1) {
  if(level.disable_super_in_turret.spawndistancemax) {
    self.ref_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(1, 0);
  } else {
    self.ref_12821[var_1].frac = 1;
  }

  thread ref_12639(var_0, var_1);
}

function ref_1270C(var_0, var_1) {
  self notify("playerZombieGasOrEMP");
}

function ref_12720() {
  if(!level.disable_super_in_turret.ref_146E2) {
    return;
  }

  thread ref_126B4(level.disable_super_in_turret.ref_14693);
}

function ref_126B4(var_0) {
  thread ref_12637(var_0);
  thread ref_12634(var_0);
  thread ref_12635(var_0);

  if(level.disable_super_in_turret.spawndistancemax) {
    thread ref_1263A(var_0);
  }

  thread ref_12638(var_0);
  thread ref_12630(var_0);

  foreach(var_2 in var_0.powers) {
    if(isDefined(var_0.powers[var_3].ref_1388F)) {
      ref_14033(var_0.powers[var_3].ref_1388F, 2);
    }
  }
}

function ref_126F9(var_0) {
  var_1 = 5;
  var_2 = 2;
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_3 = var_1;

  if(isPlayer(var_0.victim)) {
    var_0.victim.unmark_on_death = 1;
    var_0.victim playSound("zxp_emp_impact_plr");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_0.victim != self && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var_3 = var_2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }
  }

  moraleslaptopthink(var_0, var_3);

  if(isDefined(var_0.victim)) {
    var_0.victim.unmark_on_death = undefined;
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function ref_1270A(var_0, var_1) {
  scripts\mp\equipment::giveequipment("equip_gas_grenade", "secondary");
  scripts\mp\equipment::setequipmentslotammo("secondary", 1);
}

function ref_12707(var_0, var_1) {
  level endon("game_ended");
  self endon("offhand_end");
  self endon("zombie_unset");
  self endon("death_or_disconnect");
  self waittill("grenade_fire", var_2, var_3, var_4, var_5);

  if(!scripts\mp\utility\weapon::grenadethrown(var_2)) {
    return;
  }

  self playSound("zxp_grenade_vo_npc", self, self);
  thread ref_1262C(var_0, var_1);
}

function ref_12709(var_0, var_1) {
  scripts\mp\equipment::setequipmentslotammo("secondary", 1);
}

function ref_12708(var_0, var_1) {
  scripts\mp\equipment::takeequipment("secondary");
}

function moraleslaptopthink(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);

  if(var_2 != "emp_cleared") {
    var_0.empremoved = 1;
    return;
  }
}

function ref_12630(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143A6("death", "zombie_unset", "zombie_set");
  thread ref_1262D(var_0);
  thread ref_12632(var_0);
  thread ref_12633(var_0);
  thread ref_12631(var_0);
}

function ref_12637(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommand(var_6, var_4);
    }
  }
}

function ref_12631(var_0) {
  if(!isDefined(self.ref_12821)) {
    return;
  }

  if(level.disable_super_in_turret.spawndistancemax) {
    foreach(var_2 in self.ref_12821) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.choppergunner_refillmissiles)) {
          var_2.choppergunner_refillmissiles scripts\mp\hud_util::destroyelem();
        }

        var_2 destroy();
      }
    }
  }

  self.ref_12821 = undefined;
}

function ref_12634(var_0) {
  var_1 = 200;
  var_2 = 18;
  var_3 = var_1;
  self.ref_12821 = [];

  foreach(var_6, var_5 in var_0.powers) {
    if(isDefined(var_5.label)) {
      if(level.disable_super_in_turret.spawndistancemax) {
        self.ref_12821[var_6] = ref_1262F(var_5.label, var_5.waitforstreamsynccomplete, var_3, var_5.ref_13060);
      } else {
        self.ref_12821[var_6] = spawnStruct();
        self.ref_12821[var_6].frac = 0;
      }

      self.ref_12821[var_6].incooldown = 0;
      var_3 += var_2;
    }
  }
}

function ref_1262F(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_4.x = 15;
  var_4.y = var_2;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "left_adjustable";
  var_4.vertalign = "top_adjustable";
  var_4.alpha = var_3;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 1;
  var_4.archived = 0;

  if(isDefined(var_1) && !scripts\engine\utility::is_player_gamepad_enabled()) {
    var_4.label = var_1;
  } else if(isDefined(var_0)) {
    var_4.label = var_0;
  }

  var_5 = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  var_5.x = 13;
  var_5.y = var_2;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.horzalign = "left_adjustable";
  var_5.vertalign = "top_adjustable";
  var_5.alpha = var_3;
  ref_132A8(var_5);
  var_5.archived = 0;
  var_5.hidewheninmenu = 1;
  var_5.bar.archived = 0;
  var_5.bar.hidewheninmenu = 1;
  var_5.bar.alpha = var_3;
  var_4.choppergunner_refillmissiles = var_5;
  return var_4;
}

function ref_132A8(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

function ref_12632(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommandremove(var_6, var_4);
    }
  }
}

function ref_12633(var_0) {
  foreach(var_2 in var_0.powers) {
    if(isDefined(var_2.has_ammo_drain_passive)) {
      self thread[[var_2.has_ammo_drain_passive]](var_0, var_3);
    }
  }
}

function ref_1262D(var_0) {
  if(!isDefined(var_0) || !isDefined(self.ref_12821)) {
    return;
  }

  self notify("disableCooldown");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self.ref_12821[var_3])) {
      continue;
    }

    self.ref_12821[var_3].incooldown = 0;

    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var_3].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    } else {
      self.ref_12821[var_3].frac = 0;
    }

    thread ref_12639(var_0, var_3);
  }

  self.laststandattackermodifiers = undefined;
  self.vehicle_occupancy_mp_hidecashbag = undefined;
}

function ref_12BBA(var_0) {
  if(!isDefined(level.teamdata[var_0]["aliveCountHuman"])) {
    return level.teamdata[var_0]["aliveCount"];
  }

  return level.teamdata[var_0]["aliveCountHuman"];
}

function wait_for_chopper_boss_finish_turning(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 notify("gulag_auto_win");
  var_2 notify("zombie_set");
  var_2 notify("zombie_unset");

  if(istrue(var_2.respawningfromtoken)) {
    return;
  }

  var_3 = var_0;
  var_4 = "token_sponsored";

  if(!isalive(var_2) && istrue(var_2.delay_enter_combat_after_investigating_grenade)) {
    if(!level.disable_super_in_turret.fluctuatevalues) {
      ref_1267D(var_2, 1);
    }

    var_5 = scripts\mp\gametypes\br_gulag::ref_125C7(var_0, var_1, 0, 1, "zombiesRevive");
    var_3 = var_5[0];
    var_4 = var_5[1];
    var_5 = undefined;
  } else if(istrue(var_3.hasrespawntoken)) {
    var_3 scripts\mp\gametypes\br_pickups::removerespawntoken();
  }

  var_2.respawningfromtoken = 1;
  var_6 = var_2 scripts\mp\gametypes\br_gulag::ref_126E8();

  if(var_6) {
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var_2 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();

  if(level.disable_super_in_turret.fluctuatevalues) {
    var_2 scripts\mp\gametypes\br_gametype_zxp::ref_126FA(1);
  } else {
    ref_12723(var_2, 0);
  }

  var_2 freezecontrols(0);
  var_2 freezelookcontrols(0);
  var_2 allowsprint(1);
  var_7 = "br_gulag_kiosk_redeploy";
  var_8 = var_0;
  var_2 thread scripts\mp\hud_message::showsplash(var_7, undefined, var_0);
  var_2.respawningfromtoken = undefined;
}

function ref_12638(var_0) {
  foreach(var_2 in var_0.powers) {
    if(isDefined(var_2.ref_1387B)) {
      self thread[[var_2.ref_1387B]](var_0, var_3);
    }
  }
}

function ref_12635(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    thread ref_12636(var_0, var_3);
  }
}

function ref_12636(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  level endon("game_ended");

  for(;;) {
    self waittill(var_1);
    waittillframeend();

    if(isDefined(self.ref_12821[var_1]) && self.ref_12821[var_1].incooldown) {
      ref_12614();
      continue;
    }

    self thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

function ref_12614() {
  if(!isDefined(self.laststandattackermodifiers) || gettime() > self.laststandattackermodifiers) {
    self playlocalsound("br_pickup_deny");
    self.laststandattackermodifiers = gettime() + 1000;
    return;
  }
}

function ref_1263A(var_0) {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var_1 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var_2 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_2 != var_1) {
      var_1 = var_2;
      jumpiffalse(var_2) LOC_00000091;

      foreach(var_5, var_4 in var_0.powers) {
        if(isDefined(var_4.waitforstreamsynccomplete)) {
          self.ref_12821[var_5].label = var_4.label;
        }
      }

      goto LOC_000000db;
    }

    waitframe();
  }
}

function ref_12639(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(self.ref_12821[var_1]) || istrue(self.ref_12821[var_1].incooldown)) {
    return;
  }

  var_2 = self.ref_12821[var_1];

  if(level.disable_super_in_turret.ref_12820 && var_2.frac > 0) {
    self.ref_12821[var_1].incooldown = 1;
    var_3 = var_0.powers[var_1].idmask;
    var_4 = "scr_br_zxp_power_cooldown_" + var_1;

    if(getdvarint(var_4, 0) != 0) {
      var_3 = getdvarint(var_4, 0);
    }

    thread ref_126DE(var_0, var_1, var_3, int(var_2.frac * 100));
    var_5 = var_2.frac;
    var_3 *= var_5;

    if(level.disable_super_in_turret.spawndistancemax) {
      var_2.choppergunner_refillmissiles.bar.color = (1, 0.6, 0);
      var_2.choppergunner_refillmissiles.bar scaleovertime(var_3, 0, var_2.choppergunner_refillmissiles.height);
    }

    wait var_3;
    var_6 = "ui_zxp_restock_" + var_1;
    self playlocalsound(var_6);
    self.ref_12821[var_1].incooldown = 0;
  } else {
    if(level.disable_super_in_turret.spawndistancemax) {
      var_2.choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    } else {
      var_2.frac = 0;
    }

    thread ref_126DE(var_0, var_1, 0, 0);
  }

  if(level.disable_super_in_turret.spawndistancemax) {
    var_2.choppergunner_refillmissiles.bar.color = (1, 1, 1);
  }

  if(isDefined(var_0.powers[var_1].ref_127FC)) {
    self[[var_0.powers[var_1].ref_127FC]](var_0, var_1);
    return;
  }
}

function ref_126DE(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(var_0.powers[var_1].ref_1388F) || !isDefined(var_0.powers[var_1].ref_128BE)) {
    return;
  }

  ref_14033(var_0.powers[var_1].ref_1388F, 1);
  var_4 = var_2 * 1000 * var_3 / 100;
  var_5 = gettime();
  var_6 = var_5 + var_4;

  while(gettime() < var_6) {
    var_7 = gettime();
    var_8 = (var_6 - gettime()) / var_4;
    var_9 = var_8 * var_3;
    ref_14033(var_0.powers[var_1].ref_128BE, int(var_9));
    waitframe();
  }

  ref_14033(var_0.powers[var_1].ref_128BE, 0);
  ref_14033(var_0.powers[var_1].ref_1388F, 2);
}

function ref_14033(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  switch (var_0) {
    case "jumpStatus":
      var_2 = 0;
      var_3 = 2;
      break;
    case "jumpProgress":
      var_2 = 2;
      var_3 = 7;
      break;
    case "empStatus":
      var_2 = 9;
      var_3 = 2;
      break;
    case "empProgress":
      var_2 = 11;
      var_3 = 7;
      break;
    case "gasGrenadeStatus":
      var_2 = 18;
      var_3 = 2;
      break;
    case "gasGrenadeProgress":
      var_2 = 20;
      var_3 = 7;
      break;
    case "numVaccine":
      var_2 = 27;
      var_3 = 2;
      break;
    default:
      break;
  }

  if(!isDefined(level.ref_146E0)) {
    level.ref_146E0 = [];
  }

  if(!isDefined(level.ref_146E0["ui_br_zombie_powers"])) {
    level.ref_146E0["ui_br_zombie_powers"] = 0;
  }

  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (int(var_1) &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset("ui_br_zombie_powers");
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;
  level.ref_146E0["ui_br_zombie_powers"] = var_9;
  self setclientomnvar("ui_br_zombie_powers", level.ref_146E0["ui_br_zombie_powers"]);
}

function ref_12716(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  var_2 = -1;

  if(ref_12717()) {
    ref_12614();
    return;
  }

  var_3 = getdvarfloat("scr_br_zxp_powers_jump_charge_rate", 1);
  var_4 = getdvarfloat("scr_br_zxp_powers_jump_min_frac", 0.25);
  var_5 = getdvarint("scr_br_zxp_powers_jump_max_hold_time", var_2);
  var_6 = var_3 * level.framedurationseconds;
  self.vehicle_occupancy_monitormovementcontrols = 0;
  self allowmelee(0);
  self disableoffhandweapons();

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback()) {
    waitframe();
  }

  thread ref_1270F();
  thread ref_13982();
  var_7 = undefined;
  var_8 = 0;

  if(!isDefined(self.vehicle_occupancy_mp_hidecashbag) || gettime() > self.vehicle_occupancy_mp_hidecashbag) {
    self playlocalsound("ui_zxp_charge_jump_start");
    self.vehicle_occupancy_mp_hidecashbag = gettime() + 500;
  }

  jumpiffalse(isDefined(var_0.powers[var_1].ref_1388F)) LOC_00000102;
  ref_14033(var_0.powers[var_1].ref_1388F, 0);

  while(!ref_12717()) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(self.vehicle_occupancy_monitormovementcontrols, 0);
    } else {
      self.ref_12821[var_1].frac = self.vehicle_occupancy_monitormovementcontrols;
    }

    var_9 = self.vehicle_occupancy_monitormovementcontrols;
    self.vehicle_occupancy_monitormovementcontrols += var_6;

    if(self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self.vehicle_occupancy_monitormovementcontrols = 1;

      if(var_5 >= 0) {
        if(!isDefined(var_7)) {
          var_7 = gettime() + var_5 * 1000;

          if(level.disable_super_in_turret.spawndistancemax) {
            thread ref_1271A(var_1, var_5);
          }
        }

        if(gettime() >= var_7) {
          break;
        }
      }
    }

    if(level.disable_super_in_turret.spawndistancemax && var_9 < var_4 && self.vehicle_occupancy_monitormovementcontrols >= var_4) {
      self.ref_12821[var_1].choppergunner_refillmissiles.bar.color = (0, 1, 0);
    }

    if(var_9 < 1 && self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self playlocalsound("ui_zxp_charge_jump_full");
    }

    if(isDefined(var_0.powers[var_1].ref_128BE)) {
      var_8 = max(int(self.vehicle_occupancy_monitormovementcontrols * 100), 0);
      ref_14033(var_0.powers[var_1].ref_128BE, var_8);
    }

    waitframe();
  }

  thread ref_12719(var_0, var_1);
}

function ref_12717() {
  return self getstance() == "prone" || istrue(self.usingascender);
}

function ref_1271C() {
  if(level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols != 0) {
    var_0 = self.origin + (0, 0, level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols);
    var_1 = playerphysicstrace(self.origin, var_0);

    if(var_1 != var_0) {
      return false;
    }
  }

  if(level.disable_super_in_turret.vehicle_occupancy_mp_changedseats != 0) {
    var_2 = self getEye();
    var_0 = var_2 + (0, 0, level.disable_super_in_turret.vehicle_occupancy_mp_changedseats);
    var_3 = 10;
    var_4 = 20;
    var_5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    var_1 = scripts\engine\trace::capsule_trace(var_2, var_0, var_3, var_4, (0, 0, 0), self, var_5);

    if(var_1["fraction"] != 1) {
      return false;
    }
  }

  return true;
}

function ref_12719(var_0, var_1) {
  self stopgestureviewmodel("ges_zombie_superjumpcharge");
  self notify("playerZombieJumpChargeEnd");
  self notify("playerZombieJumpStop");
  var_2 = getdvarfloat("scr_br_zxp_powers_jump_min_frac", 0.25);
  var_3 = getdvarint("scr_br_zxp_powers_jump_min_frac_refund", 1);

  if(self.vehicle_occupancy_monitormovementcontrols >= var_2 && !ref_12717() && ref_1271C() && !self ismantling()) {
    self playsoundtoplayer("zxp_superjump_vo", self, self);
    self playSound("zxp_superjump_sfx_npc", self, self);
    var_4 = getdvarfloat("scr_br_zxp_powers_jump_velocity", 1300);
    var_5 = self getplayerangles();
    thread ref_12711();
    ref_1250A(var_5, var_4, self.vehicle_occupancy_monitormovementcontrols);
    thread ref_126D7();
    thread ref_12528();
    self.laststandattackermodifiers = undefined;
    self.vehicle_occupancy_mp_hidecashbag = undefined;
  } else if(var_3) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var_1].choppergunner_refillmissiles.bar.frac = 0;
    } else {
      self.ref_12821[var_1].frac = 0;
    }

    ref_14033(var_0.powers[var_1].ref_128BE, 0);
    self enableoffhandweapons();
    self allowmelee(1);
    self notify("endSuperJumpFov");
    ref_12614();
  } else {
    ref_12614();
  }

  ref_12718(var_0, var_1, 1);
}

function ref_1270F() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");

  if(self isgestureplaying("ges_zombie_superjumpcharge")) {
    return;
  }

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback()) {
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

function ref_12711() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);
  wait 0.2;
  self notify("endSuperJumpFov");
  self forceplaygestureviewmodel("ges_zombie_superjump");

  while(!ref_12715()) {
    waitframe();
  }

  self notify("zombie_jump_complete");
  self stopgestureviewmodel("ges_zombie_superjump");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playsoundtoplayer("zxp_splat_plr", self, self);
  self playSound("zmb_npc_breath_land_hi", self, self);
  self playSound("zxp_splat_npc", self, self);
  wait 0.2;
  self enableoffhandweapons();
  self allowmelee(1);
}

function ref_12715() {
  return self isonground() || self isonladder() || self ismantling();
}

function ref_1250A(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = (0, 0, 20);

  if(!isDefined(var_3)) {
    var_3 = var_5;
  }

  var_6 = var_0;
  var_7 = (0, 0, 1);
  var_8 = (1, 0, 0);

  if(getdvarint("scr_br_zxp_powers_jump_pitch_correction", var_4)) {
    var_7 = propwaitminigameinit();

    if(!isDefined(var_7)) {
      var_7 = (0, 0, 1);
    }

    var_9 = (0, var_6[1], 0);
    var_10 = anglestoright(var_9);
    var_8 = vectorcross(var_7, var_10);
    var_11 = vectortoangles(var_8);
    var_12 = angleclamp180(var_11[0]);
    var_13 = -85;
    var_14 = var_12;
    var_15 = var_6[0];

    if(var_15 > var_12) {
      var_15 = var_12;
    }

    var_16 = getdvarfloat("scr_br_zxp_powers_jump_pitch_correction_at_max", -45);
    var_17 = getdvarfloat("scr_br_zxp_powers_jump_pitch_correction_at_min", 0);
    var_18 = (var_15 - var_13) / (var_14 - var_13);
    var_19 = var_17 + var_18 * (var_16 - var_17);
    var_6 = (var_15 + var_19, var_6[1], var_6[2]);
  }

  var_20 = getdvarfloat("scr_br_zxp_powers_jump_pitch_add", 0);

  if(var_20 != 0) {
    var_6 = (var_6[0] + var_20, var_6[1], var_6[2]);
  }

  var_21 = anglesToForward(var_6);
  var_22 = var_21 * var_2 * var_1;
  var_23 = self.origin + var_3;
  self setOrigin(var_23);
  self setvelocity(var_22);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  var_24 = anglesToForward(self.angles);
  var_25 = self.origin + (0, 0, 30) + var_24 * 15;
  radiusdamage(var_25, 100, 1, 1);
}

function ref_126D7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  var_0 = getdvarfloat("scr_br_zxp_air_control", 400);

  if(var_0 <= 0) {
    return;
  }

  var_1 = getdvarfloat("scr_br_zxp_air_control_max_speed", 1400);
  wait 0.2;

  while(!ref_12715()) {
    var_2 = self getnormalizedmovement();

    if(length(var_2) > 0) {
      var_3 = rotatevector((var_2[0], -1 * var_2[1], 0), self.angles);
      var_4 = self getvelocity();
      var_5 = length(var_4);
      var_6 = var_3 * var_0 * level.framedurationseconds;
      var_7 = var_4 + var_6;
      var_8 = length(var_7);

      if(var_8 <= var_1) {
        self setvelocity(var_7);
      } else if(var_5 < var_1) {
        var_7 = vectorNormalize(var_7) * var_1;
        self setvelocity(var_7);
      }
    }

    waitframe();
  }
}

function ref_12528() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_jump_complete");
  var_0 = getdvarfloat("scr_br_zxp_clear_moving_platfrom_time", 0.3);

  if(var_0 < 0) {
    return;
  }

  if(var_0 > 0) {
    wait var_0;
  }

  self method_87b1();
}

function isvalidpointinbounds(var_0, var_1, var_2, var_3, var_4) {
  level notify("hitVelocity");
  level endon("hitVelocity");
  var_5 = var_0 + var_1;
  var_6 = var_2 + var_3 * 20;
  var_7 = var_2 + var_4 * 20;

  for(;;) {
    waitframe();
  }
}

function ref_1271B(var_0, var_1) {
  if(isDefined(self.vehicle_occupancy_monitormovementcontrols)) {
    ref_12719(var_0, "jump");
    return;
  }

  self notify("playerZombieJumpStop");
}

function propwaitminigameinit(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = self;
  } else {
    var_2 = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = [var_2];
  var_4 = [self.origin];
  var_5 = -1;

  while(var_5 <= 1) {
    var_6 = -1;

    while(var_6 <= 1) {
      var_7 = var_2 getpointinbounds(var_5, var_6, 0);
      var_7 = (var_7[0], var_7[1], self.origin[2]);
      var_4 = var_7;
      var_6 += 2;
    }

    var_5 += 2;
  }

  var_8 = (0, 0, 0);
  var_9 = 0;

  foreach(var_11 in var_4) {
    var_12 = scripts\engine\trace::_bullet_trace(var_11 + (0, 0, 4), var_11 + (0, 0, -16), 0, var_3);
    var_13 = var_12["fraction"] > 0 && var_12["fraction"] < 1;

    if(var_13) {
      var_8 += var_12["normal"];
      var_9++;
    }
  }

  if(var_9 > 0) {
    var_8 /= var_9;
    return var_8;
  }

  return undefined;
}

function ref_12718(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    thread ref_12639(var_0, var_1);
  }

  self.vehicle_occupancy_monitormovementcontrols = undefined;
}

function ref_1271A(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("playerZombieJumpChargeEnd");

  if(var_1 <= 0) {
    return;
  }

  var_2 = scripts\mp\gametypes\br_circle::can_killstreak_be_detected(var_1, int(var_1 * 5), 1);
  var_3 = 1;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_3) {
      self.ref_12821[var_0].choppergunner_refillmissiles.bar.color = (1, 0, 0);
    } else {
      self.ref_12821[var_0].choppergunner_refillmissiles.bar.color = (0, 1, 0);
    }

    wait var_2[var_4];
    var_3 = !var_3;
  }
}

function ref_125D7(var_0, var_1) {
  var_2 = 1800;
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_0 thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_3, self);
  thread ref_1262E(var_0);
  var_4 = var_0.origin - self.origin;
  var_5 = vectortoangles(var_4);
  var_6 = distance(var_0.origin, self.origin);
  var_7 = 1 - var_6 / var_1;
  ref_1250A(var_0, var_5, var_2, var_7);
}

function checkspawnwithinmapradius(var_0) {
  if(istrue(level.usenavmeshforzombierespawn) && isscriptabledefined()) {
    if(isDefined(level.ref_12CA9) && level.ref_12CA9 >= 0) {
      var_1 = getclosestpointonnavmesh(var_0);
      var_2 = var_1 - var_0;

      if(length2d(var_2) > level.ref_12CA9) {
        var_2 = vectorNormalize(var_2);
        var_2 = (var_2[0] * level.ref_12CA9, var_2[1] * level.ref_12CA9, 0);
        var_0 = var_1 + var_2;
      }
    }
  }

  return var_0;
}

function standard_health(var_0) {
  if(isexplosivedamagemod(var_0.meansofdeath) && var_0.objweapon.basename == "emp_drone_non_player_direct_mp" || var_0.objweapon.basename == "emp_drone_non_player_mp" || var_0.objweapon.basename == "emp_drone_player_mp") {
    return 1;
  }

  return 0;
}

function ref_1262E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  self notify("disableCooldown");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self.ref_12821[var_3])) {
      continue;
    }

    self.ref_12821[var_3].incooldown = 0;
    thread ref_1262C(var_0, var_3);
  }
}

function ref_13982() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 notify("applyFOVPresentation");
  var_0 endon("applyFOVPresentation");
  var_0 lerpfovbypreset("zombiearcade");
  var_0 waittill("endSuperJumpFov");
  var_0 lerpfovbypreset("zombiedefault");
}

function addtoteamlives(var_0, var_1) {
  ref_126D8(var_0);
}

function removefromteamlives(var_0, var_1) {
  ref_126D8(var_0);
}

function ref_125E9() {
  return istrue(self.tut_popup_listener);
}

function watch_flight_collision(var_0) {
  if(scripts\mp\gametypes\br_public::ref_125F3()) {
    var_1 = isDefined(var_0.attacker) && nukefridgewatcher(var_0.attacker);

    if(!var_1 || !level.disable_super_in_turret.ref_1470A) {
      return false;
    }

    thread ref_1262E(level.disable_super_in_turret.ref_14693);
    thread ref_1271D();
    thread ref_12731(var_0);
    thread ref_12701();
  }

  return true;
}

function ref_12731(var_0) {
  var_1 = 500;
  var_2 = 90;
  var_3 = 60;
  var_4 = 30;
  var_5 = var_0.direction_vec;
  var_6 = vectortoyaw(var_5);
  var_7 = var_2;
  var_8 = var_3;

  if(scripts\engine\utility::cointoss()) {
    var_8 *= -1;
  }

  var_8 += var_6;
  var_9 = (var_7, var_8, 0);
  var_10 = vectorNormalize((var_5[0], var_5[1], 0));
  var_11 = var_10 * var_4 + (0, 0, var_4);
  ref_1250A(var_9, var_1, 1, var_11);
}

function ref_12701() {
  self endon("disconnect");
  self.ref_1423B = 1;
  var_0 = getdvarfloat("scr_br_zxp_vehicle_immunity", 1.5);
  wait var_0;
  self.ref_1423B = undefined;
}

function ref_1271D() {
  level endon("game_ended");
  self endon("last_stand_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_transition_done");
  waittillframeend();
  self setlaststandenabled(1);
  self.usedprops = 1;
  self.laststandreviveent makeunusable();
  var_0 = self.laststandreviveent;
  var_0.usetime = getdvarfloat("scr_br_zxp_vehicle_getup", 3) * 1000;

  if(!isDefined(var_0.curprogress)) {
    var_0.curprogress = 0;
  }

  while(scripts\mp\utility\player::isreallyalive(self) && var_0.curprogress < var_0.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(var_0.userate)) {
      var_0.userate = 0;
    }

    var_0.curprogress += level.frameduration * var_0.userate;
    var_0.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(var_0, 1);

    if(var_0.curprogress >= var_0.usetime) {
      break;
    }

    waitframe();
  }

  var_0.usetime = undefined;
  var_0.curprogress = undefined;
  var_0.userate = undefined;
  scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", self);
  self playsoundtoplayer("zmb_breath_land_dropin", self, self);
  self playSound("zmb_npc_breath_land_dropin");
  self setlaststandenabled(0);
}

function ref_12810() {
  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }

  var_0 = 0;
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.teamnamelist) {
    var_5 = level.teamdata[var_4]["teamCount"];

    if(var_5 > 0) {
      if(level.teamdata[var_4]["aliveCountHuman"] > 0) {
        if((level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto || level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback == 0) && var_2.size > 0) {
          return;
        }

        var_2 = var_4;
        var_0 += level.teamdata[var_4]["aliveCountHuman"];
        continue;
      }

      if(level.teamdata[var_4]["aliveCount"] > 0) {
        var_1 = var_4;
      }
    }
  }

  if(!level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto && var_0 <= level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback) {
    level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 1;
    thread clear_tier_lights_all(var_2);

    if(level.disable_super_in_turret.ref_146E8) {
      level.disable_super_in_turret.ref_146E7 = 0;
    }
  }

  if(var_2.size > 1) {
    return;
  }

  var_7 = scripts\mp\utility\script::quicksort(var_1, &ref_134D6);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_4 = var_7[var_8];
    var_9 = var_8 + 2;
    thread scripts\mp\gametypes\br::ref_1209B(var_4, var_9, 0, 1);
  }

  thread scripts\mp\gamelogic::endgame(var_2[0], game["end_reason"]["enemies_eliminated"]);
}

function ref_134D6(var_0, var_1) {
  var_2 = level.teamdata[var_0]["lastZombieTime"];
  var_3 = level.teamdata[var_1]["lastZombieTime"];
  return var_2 >= var_3;
}

function ref_1472D() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_zxp");
}

function ref_126D8() {
  var_0 = self.team;
  level.teamdata[var_0]["aliveCountHuman"] = 0;

  foreach(var_2 in level.teamdata[var_0]["alivePlayers"]) {
    if(!var_2 scripts\mp\gametypes\br_public::ref_125F3() && !ref_125E9(var_2)) {
      level.teamdata[var_0]["aliveCountHuman"]++;
    }
  }
}