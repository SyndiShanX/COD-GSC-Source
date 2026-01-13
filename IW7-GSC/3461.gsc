/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3461.gsc
**************************************/

init() {
  level._effect["airdrop_crate_destroy"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_dp_pickup_dust.vfx");
  level._effect["airdrop_dust_kickup"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_dp_pickup_dust.vfx");
  level._effect["drone_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_dp_exp.vfx");
  level._effect["crate_explode"] = loadfx("vfx\iw7\_requests\mp\killstreak\vfx_drone_pkg_exp_vari.vfx");
  precachempanim("juggernaut_carepackage");
  setairdropcratecollision("airdrop_crate");
  setairdropcratecollision("care_package");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("dronedrop", ::func_1AA2, undefined, undefined, ::tryuseairdrop, undefined, ::func_1A9F);
  var_0 = ["passive_bomb_trap", "passive_decreased_cost", "passive_increased_cost", "passive_reroll", "passive_high_roller", "passive_low_roller"];
  scripts\mp\killstreak_loot::func_DF07("dronedrop", var_0);
  level.numdropcrates = 0;
  level.littlebirds = [];
  level.cratetypes = [];
  level.cratemaxval = [];
  addcratetype("dronedrop", "venom", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_VENOM_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "uav", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "counter_uav", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "drone_hive", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "ball_drone_backup", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "bombardment", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "precision_airstrike", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "sentry_shock", 45, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "jackal", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "thor", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "directional_uav", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "remote_c8", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "minijackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "venom", 35, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_VENOM_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "uav", 30, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "counter_uav", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "drone_hive", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "ball_drone_backup", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "bombardment", 20, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "precision_airstrike", 20, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "sentry_shock", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_trap", "bomb_trap", 100, ::killstreakbombcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "venom", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_VENOM_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "uav", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_UAV_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "counter_uav", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_COUNTER_UAV_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "drone_hive", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "ball_drone_backup", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "bombardment", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_BOMBARDMENT_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "precision_airstrike", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "sentry_shock", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_SENTRY_SHOCK_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "jackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_JACKAL_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "thor", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_THOR_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "directional_uav", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "remote_c8", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_RC8_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "minijackal", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, &"KILLSTREAKS_HINTS_MINI_JACKAL_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "sentry_shock", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "jackal", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "thor", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "directional_uav", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "remote_c8", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "minijackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "venom", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_VENOM_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "uav", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "counter_uav", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "drone_hive", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "ball_drone_backup", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "bombardment", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "precision_airstrike", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "sentry_shock", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "jackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "thor", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "directional_uav", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "remote_c8", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "minijackal", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");

  if(isDefined(level.customcratefunc)) {
    [[level.customcratefunc]]("care_package_iw7_un_wm", "care_package_iw7_ca_wm");
  }

  if(isDefined(level.mapcustomcratefunc)) {
    [[level.mapcustomcratefunc]]();
  }

  generatemaxweightedcratevalue();
  var_1 = spawnStruct();
  var_1.scorepopup = "destroyed_airdrop";
  var_1.vodestroyed = "dronedrop_destroyed";
  var_1.callout = "callout_destroyed_airdrop";
  var_1.samdamagescale = 0.09;
  level.heliconfigs["airdrop"] = var_1;
  scripts\mp\rank::registerscoreinfo("little_bird", "value", 200);
  level setupcaptureflares();
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
}

generatemaxweightedcratevalue() {
  foreach(var_6, var_1 in level.cratetypes) {
    level.cratemaxval[var_6] = 0;

    foreach(var_3 in var_1) {
      var_4 = var_3.type;

      if(!level.cratetypes[var_6][var_4].raw_weight) {
        level.cratetypes[var_6][var_4].weight = level.cratetypes[var_6][var_4].raw_weight;
        continue;
      }

      level.cratemaxval[var_6] = level.cratemaxval[var_6] + level.cratetypes[var_6][var_4].raw_weight;
      level.cratetypes[var_6][var_4].weight = level.cratemaxval[var_6];
    }
  }
}

changecrateweight(var_0, var_1, var_2) {
  if(!isDefined(level.cratetypes[var_0]) || !isDefined(level.cratetypes[var_0][var_1])) {
    return;
  }
  level.cratetypes[var_0][var_1].raw_weight = var_2;
  generatemaxweightedcratevalue();
}

setairdropcratecollision(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level.airdropcratecollision = getent(var_1[0].target, "targetname");

  foreach(var_3 in var_1) {
    var_3 deletecrateold();
  }
}

addcratetype(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_4)) {
    var_4 = "care_package_iw7_un_wm";
  }

  if(!isDefined(var_5)) {
    var_5 = "care_package_iw7_ca_wm";
  }

  if(!isDefined(var_8)) {
    var_8 = "care_package_iw7_dummy";
  }

  level.cratetypes[var_0][var_1] = spawnStruct();
  level.cratetypes[var_0][var_1].droptype = var_0;
  level.cratetypes[var_0][var_1].type = var_1;
  level.cratetypes[var_0][var_1].raw_weight = var_2;
  level.cratetypes[var_0][var_1].weight = var_2;
  level.cratetypes[var_0][var_1].func = var_3;
  level.cratetypes[var_0][var_1].model_name_friendly = var_4;
  level.cratetypes[var_0][var_1].model_name_enemy = var_5;
  level.cratetypes[var_0][var_1].model_name_dummy = var_8;

  if(isDefined(var_6)) {
    game["strings"][var_1 + "_hint"] = var_6;
  }

  if(isDefined(var_7)) {
    game["strings"][var_1 + "_rerollHint"] = var_7;
  }
}

getrandomcratetype(var_0) {
  var_1 = randomint(level.cratemaxval[var_0]);
  var_2 = undefined;

  foreach(var_4 in level.cratetypes[var_0]) {
    var_5 = var_4.type;

    if(!level.cratetypes[var_0][var_5].weight) {
      continue;
    }
    var_2 = var_5;

    if(level.cratetypes[var_0][var_5].weight > var_1) {
      break;
    }
  }

  return var_2;
}

getcratetypefordroptype(var_0) {
  switch (var_0) {
    case "airdrop_sentry_minigun":
      return "sentry";
    case "airdrop_predator_missile":
      return "predator_missile";
    case "airdrop_juggernaut":
      return "airdrop_juggernaut";
    case "airdrop_juggernaut_def":
      return "airdrop_juggernaut_def";
    case "airdrop_juggernaut_gl":
      return "airdrop_juggernaut_gl";
    case "airdrop_juggernaut_recon":
      return "airdrop_juggernaut_recon";
    case "airdrop_juggernaut_maniac":
      return "airdrop_juggernaut_maniac";
    case "airdrop_remote_tank":
      return "remote_tank";
    case "airdrop_lase":
      return "lasedStrike";
    case "dronedrop_trap":
      return "bomb_trap";
    case "airdrop_sotf":
    case "airdrop_grnd_mega":
    case "airdrop_grnd":
    case "airdrop_mega":
    case "airdrop_escort":
    case "airdrop_support":
    case "dronedrop_highroll":
    case "jackaldrop":
    case "dronedrop_reroll":
    case "dronedrop_grnd":
    case "airdrop_assault":
    case "airdrop":
    case "dronedrop":
    default:
      if(isDefined(level.getrandomcratetypeforgamemode)) {
        return [
          }
          [level.getrandomcratetypeforgamemode]
      ](var_0);

      return getrandomcratetype(var_0);
  }
}

tryuseairdrop(var_0) {
  var_1 = var_0.streakname;
  var_2 = var_1;
  var_3 = undefined;

  if(!isDefined(var_2)) {
    var_2 = "airdrop";
  }

  var_4 = 1;

  if((level.littlebirds.size >= 4 || level.fauxvehiclecount >= 4) && var_2 != "airdrop_mega" && !issubstr(tolower(var_2), "juggernaut")) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_4 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  } else if(var_2 == "airdrop_lase" && isDefined(level.lasedstrikecrateactive) && level.lasedstrikecrateactive) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  return 1;
}

func_1AA2(var_0) {
  var_0.var_1AA0 = var_0.streakname;
  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_1 = scripts\mp\killstreaks\target_marker::func_819B(var_0);

  if(!isDefined(var_1.location)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(var_0.var_1AA0, self.origin);
  func_1AA1(var_1, var_0.var_1AA0, var_0);
  return 1;
}

func_1AA1(var_0, var_1, var_2) {
  switch (var_1) {
    case "dronedrop":
      level func_581F(self, var_0, randomfloat(360), var_1, var_2);
      break;
  }
}

func_1A9E(var_0, var_1) {
  var_1 thread airdropdetonateonstuck();
  var_1.owner = self;
  var_0.var_1AA0 = var_0.streakname;
  scripts\mp\utility\game::incrementfauxvehiclecount();
  thread func_4FC3();
  var_1 thread airdropmarkeractivate(var_0.var_1AA0);
  scripts\mp\matchdata::logkillstreakevent(var_0.var_1AA0, self.origin);
  var_0.var_1A9E = 1;
  return 1;
}

airdropmarkeractivate(var_0, var_1) {
  level endon("game_ended");
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  self waittill("explode", var_2);
  var_3 = self.owner;

  if(!isDefined(var_3)) {
    return;
  }
  if(var_3 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  if(issubstr(tolower(var_0), "escort_airdrop") && isDefined(level.chopper)) {
    return;
  }
  wait 0.05;

  if(issubstr(tolower(var_0), "juggernaut")) {
    level doc130flyby(var_3, var_2, randomfloat(360), var_0);
  } else if(issubstr(tolower(var_0), "escort_airdrop")) {
    var_3 scripts\mp\killstreaks\escort_airdrop::func_6CE4(var_1, var_2, randomfloat(360), "escort_airdrop");
  } else if(var_0 == "dronedrop") {
    level func_581F(var_3, var_2, randomfloat(360), var_0);
  } else {
    level doflyby(var_3, var_2, randomfloat(360), var_0);
  }
}

func_1A9F(var_0) {
  if(isDefined(var_0.var_1AA0) && !issubstr(var_0.var_1AA0, "juggernaut") && !scripts\mp\utility\game::istrue(var_0.var_1A9E)) {
    scripts\mp\utility::decrementfauxvehiclecount();
  }
}

func_4FC3() {
  self endon("airDropMarkerActivate");
  self waittill("death");
  scripts\mp\utility::decrementfauxvehiclecount();
}

initairdropcrate() {
  self.inuse = 0;
  self hide();

  if(isDefined(self.target)) {
    self.collision = getent(self.target, "targetname");
    self.collision notsolid();
  } else
    self.collision = undefined;
}

deleteonownerdeath(var_0) {
  wait 0.25;
  self linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  self delete();
}

crateteammodelupdater() {
  self endon("death");
  self hide();

  foreach(var_1 in level.players) {
    if(var_1.team != "spectator") {
      self giveperkequipment(var_1);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_1 in level.players) {
      if(var_1.team != "spectator") {
        self giveperkequipment(var_1);
      }
    }
  }
}

cratemodelteamupdater(var_0) {
  self endon("death");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == "spectator") {
      if(var_0 == "allies") {
        self giveperkequipment(var_2);
      }

      continue;
    }

    if(var_2.team == var_0) {
      self giveperkequipment(var_2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team == "spectator") {
        if(var_0 == "allies") {
          self giveperkequipment(var_2);
        }

        continue;
      }

      if(var_2.team == var_0) {
        self giveperkequipment(var_2);
      }
    }
  }
}

cratemodelenemyteamsupdater(var_0) {
  self endon("death");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      self giveperkequipment(var_2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team != var_0) {
        self giveperkequipment(var_2);
      }
    }
  }
}

cratemodelplayerupdater(var_0, var_1) {
  self endon("death");
  self hide();

  foreach(var_3 in level.players) {
    if(var_1 && isDefined(var_0) && var_3 != var_0) {
      continue;
    }
    if(!var_1 && isDefined(var_0) && var_3 == var_0) {
      continue;
    }
    self giveperkequipment(var_3);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(var_1 && isDefined(var_0) && var_3 != var_0) {
        continue;
      }
      if(!var_1 && isDefined(var_0) && var_3 == var_0) {
        continue;
      }
      self giveperkequipment(var_3);
    }
  }
}

crateuseteamupdater(var_0) {
  self endon("death");

  for(;;) {
    setusablebyteam(var_0);
    level waittill("joined_team");
  }
}

crateuseteamupdater_multiteams(var_0) {
  self endon("death");

  for(;;) {
    setusablebyotherteams(var_0);
    level waittill("joined_team");
  }
}

crateusejuggernautupdater() {
  if(!issubstr(self.cratetype, "juggernaut")) {
    return;
  }
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("juggernaut_equipped", var_0);
    self disableplayeruse(var_0);
    thread crateusepostjuggernautupdater(var_0);
  }
}

crateusepostjuggernautupdater(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("death");
  self enableplayeruse(var_0);
}

createairdropcrate(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", var_3);
  var_6.curprogress = 0;
  var_6.usetime = 0;
  var_6.userate = 0;
  var_6.team = self.team;
  var_6.destination = var_4;
  var_6.id = "care_package";
  var_6 give_player_tickets(1);

  if(isDefined(var_0)) {
    var_6.owner = var_0;
    var_6 setotherent(var_0);
  } else
    var_6.owner = undefined;

  var_6.cratetype = var_2;
  var_6.droptype = var_1;
  var_6.targetname = "care_package";
  var_6 func_85C8(1);
  var_7 = "care_package_iw7_dummy";

  if(isDefined(level.custom_dummy_crate_model)) {
    var_7 = level.custom_dummy_crate_model;
  }

  var_6 setModel(var_7);

  if(var_2 == "airdrop_jackpot") {
    var_6.friendlymodel = spawn("script_model", var_3);
    var_6.friendlymodel setModel(level.cratetypes[var_1][var_2].model_name_friendly);
    var_6.friendlymodel thread deleteonownerdeath(var_6);
  } else {
    var_6.friendlymodel = spawn("script_model", var_3);
    var_6.friendlymodel setModel(level.cratetypes[var_1][var_2].model_name_friendly);

    if(isDefined(level.highlightairdrop) && level.highlightairdrop) {
      if(!isDefined(var_5)) {
        var_5 = 2;
      }

      var_6.friendlymodel hudoutlineenable(var_5, 0, 0);
      var_6.outlinecolor = var_5;
    }

    var_6.enemymodel = spawn("script_model", var_3);
    var_6.enemymodel setModel(level.cratetypes[var_1][var_2].model_name_enemy);
    var_6.friendlymodel setentityowner(var_6);
    var_6.enemymodel setentityowner(var_6);
    var_6.friendlymodel thread deleteonownerdeath(var_6);

    if(level.teambased) {
      var_6.friendlymodel thread cratemodelteamupdater(var_6.team);
    } else {
      var_6.friendlymodel thread cratemodelplayerupdater(var_0, 1);
    }

    var_6.enemymodel thread deleteonownerdeath(var_6);

    if(level.multiteambased) {
      var_6.enemymodel thread cratemodelenemyteamsupdater(var_6.team);
    } else if(level.teambased) {
      var_6.enemymodel thread cratemodelteamupdater(level.otherteam[var_6.team]);
    } else {
      var_6.enemymodel thread cratemodelplayerupdater(var_0, 0);
    }
  }

  var_6.inuse = 0;
  var_6.killcament = spawn("script_model", var_6.origin + (0, 0, 300), 0, 1);
  var_6.killcament setscriptmoverkillcam("explosive");
  var_6.killcament linkto(var_6);
  level.numdropcrates++;
  var_6 thread dropcrateexistence(var_4);
  level notify("createAirDropCrate", var_6);
  return var_6;
}

dropcrateexistence(var_0) {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(level.cratekill)) {
    [[level.cratekill]](var_0);
  }

  level.numdropcrates--;
}

cratesetupforuse(var_0, var_1, var_2, var_3) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(var_0);
  self func_84A7("none");
  self makeusable();

  if(isDefined(var_3)) {
    self setusepriority(var_3);
  }

  if(scripts\mp\utility\game::istrue(var_2)) {
    thread watchcratereroll(self.owner);
    thread watchcratererollcommand(self.owner);
    thread fakererollcratesetupforuse(self.owner, var_3);
  }

  var_4 = "icon_minimap_drone_package_friendly";

  if(isDefined(level.objvisall)) {
    var_5 = "icon_minimap_drone_package_friendly";
  }

  if(!isDefined(self.minimapid)) {
    self.minimapid = createobjective(var_4, undefined, 1, 1, 0);
  }

  thread crateuseteamupdater();
  thread crateusejuggernautupdater();

  if(issubstr(self.cratetype, "juggernaut")) {
    foreach(var_7 in level.players) {
      if(var_7 scripts\mp\utility\game::isjuggernaut()) {
        thread crateusepostjuggernautupdater(var_7);
      }
    }
  }

  var_9 = undefined;

  if(level.teambased) {
    var_9 = scripts\mp\entityheadicons::setheadicon(self.team, var_1, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
  } else if(isDefined(self.owner)) {
    var_9 = scripts\mp\entityheadicons::setheadicon(self.owner, var_1, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
  }

  if(isDefined(var_9)) {
    var_9.showinkillcam = 0;
  }

  if(isDefined(level.iconvisall)) {
    [[level.iconvisall]](self, var_1);
  } else {
    foreach(var_7 in level.players) {
      if(var_7.team == "spectator") {
        var_9 = scripts\mp\entityheadicons::setheadicon(var_7, var_1, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
      }
    }
  }
}

fakererollcratesetupforuse(var_0, var_1) {
  var_2 = &"PLATFORM_GET_KILLSTREAK";

  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var_2 = game["strings"][self.cratetype + "_hint"];
  }

  var_3 = 128;
  var_4 = 360;
  var_5 = 128;
  var_6 = 360;
  var_7 = -10000;

  if(isDefined(var_1)) {
    var_7 = var_1;
  }

  var_8 = spawn("script_model", self.origin);
  var_8.curprogress = 0;
  var_8.usetime = 0;
  var_8.userate = 3000;
  var_8.inuse = 0;
  var_8.id = self.id;
  var_8 linkto(self);
  var_8 makeusable();
  var_8 disableplayeruse(var_0);
  var_8 setcursorhint("HINT_NOICON");
  var_8 func_84A9("show");
  var_8 sethintstring(var_2);
  var_8 func_84A6(var_4);
  var_8 setusefov(var_6);
  var_8 func_84A4(var_3);
  var_8 setuserange(var_5);
  var_8 setusepriority(var_7);
  var_8 thread deleteuseent(self);
  self.fakeuseobj = var_8;
}

watchcratereroll(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  self waittill("crate_reroll");
  var_0 playlocalsound("mp_killconfirm_tags_drop");
  var_1 = level.cratetypes[self.droptype][self.cratetype].raw_weight;
  changecrateweight(self.droptype, self.cratetype, 0);
  var_2 = getcratetypefordroptype(self.droptype);
  changecrateweight(self.droptype, self.cratetype, var_1);
  self.cratetype = var_2;
  var_3 = &"PLATFORM_GET_KILLSTREAK";

  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var_3 = game["strings"][self.cratetype + "_hint"];
  }

  self sethintstring(var_3);

  if(isDefined(self.fakeuseobj)) {
    self.fakeuseobj sethintstring(var_3);
  }

  var_4 = scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype);
  var_5 = undefined;

  if(level.teambased) {
    var_5 = scripts\mp\entityheadicons::setheadicon(self.team, var_4, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
  } else if(isDefined(self.owner)) {
    var_5 = scripts\mp\entityheadicons::setheadicon(self.owner, var_4, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
  }

  if(isDefined(var_5)) {
    var_5.showinkillcam = 0;
  }

  if(isDefined(level.iconvisall)) {
    [[level.iconvisall]](self, var_4);
  } else {
    foreach(var_7 in level.players) {
      if(var_7.team == "spectator") {
        var_5 = scripts\mp\entityheadicons::setheadicon(var_7, var_4, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
      }
    }
  }
}

watchcratererollcommand(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 16384;

  for(;;) {
    if(var_0 usebuttonpressed()) {
      var_1 = 0;

      while(var_0 usebuttonpressed()) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!var_0 usebuttonpressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_0)) {
        continue;
      }
      if(distance2dsquared(var_0.origin, self.origin) > var_2) {
        continue;
      }
      self notify("crate_reroll");
    }

    wait 0.05;
  }
}

createobjective(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_5 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_5, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !scripts\mp\utility\game::istrue(var_3)) {
    scripts\mp\objidpoolmanager::minimap_objective_position(var_5, self.origin);
  } else if(scripts\mp\utility\game::istrue(var_3) && scripts\mp\utility\game::istrue(var_4)) {
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_5, self);
  } else {
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_5, self);
  }

  scripts\mp\objidpoolmanager::minimap_objective_state(var_5, "active");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_5, var_0);

  if(isDefined(var_1)) {
    if(!level.teambased && isDefined(self.owner)) {
      if(scripts\mp\utility\game::istrue(var_2)) {
        scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_5, self.owner getentitynumber());
      } else {
        scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_5, self.owner getentitynumber());
      }
    } else
      scripts\mp\objidpoolmanager::minimap_objective_team(var_5, var_1);
  } else
    scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(var_5);

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var_5);
  }

  return var_5;
}

createobjective_engineer(var_0, var_1, var_2) {
  var_3 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_3 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_3, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !scripts\mp\utility\game::istrue(var_1)) {
    scripts\mp\objidpoolmanager::minimap_objective_position(var_3, self.origin);
  } else if(scripts\mp\utility\game::istrue(var_1) && scripts\mp\utility\game::istrue(var_2)) {
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_3, self);
  } else {
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_3, self);
  }

  scripts\mp\objidpoolmanager::minimap_objective_state(var_3, "active");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_3, var_0);
  scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(var_3);
  return var_3;
}

setusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(issubstr(self.cratetype, "juggernaut") && var_2 scripts\mp\utility\game::isjuggernaut()) {
      self disableplayeruse(var_2);
      continue;
    }

    if(issubstr(self.cratetype, "lased") && isDefined(var_2.hassoflam) && var_2.hassoflam) {
      self disableplayeruse(var_2);
      continue;
    }

    if(issubstr(self.cratetype, "trap") && scripts\mp\utility\game::istrue(level.teambased) && var_2.team == self.owner.team) {
      self disableplayeruse(var_2);
      continue;
    }

    if(issubstr(self.cratetype, "trap") && !scripts\mp\utility\game::istrue(level.teambased) && var_2 == self.owner) {
      self disableplayeruse(var_2);
      continue;
    }

    if(issubstr(self.droptype, "reroll") && var_2 != self.owner) {
      self disableplayeruse(var_2);
      continue;
    }

    if(!isDefined(var_0) || var_0 == var_2.team) {
      self enableplayeruse(var_2);
      continue;
    }

    self disableplayeruse(var_2);
  }
}

setusablebyotherteams(var_0) {
  foreach(var_2 in level.players) {
    if(issubstr(self.cratetype, "juggernaut") && var_2 scripts\mp\utility\game::isjuggernaut()) {
      self disableplayeruse(var_2);
      continue;
    }

    if(!isDefined(var_0) || var_0 != var_2.team) {
      self enableplayeruse(var_2);
      continue;
    }

    self disableplayeruse(var_2);
  }
}

dropthecrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = [];
  self.owner endon("disconnect");

  if(!isDefined(var_4)) {
    if(isDefined(var_7)) {
      var_10 = undefined;
      var_11 = undefined;

      for(var_12 = 0; var_12 < 100; var_12++) {
        var_11 = getcratetypefordroptype(var_1);
        var_10 = 0;

        for(var_13 = 0; var_13 < var_7.size; var_13++) {
          if(var_11 == var_7[var_13]) {
            var_10 = 1;
            break;
          }
        }

        if(var_10 == 0) {
          break;
        }
      }

      if(var_10 == 1) {
        var_11 = getcratetypefordroptype(var_1);
      }
    } else
      var_11 = getcratetypefordroptype(var_1);
  } else
    var_11 = var_4;

  var_6 = (0, 0, 0);

  if(!isDefined(var_6)) {
    var_6 = (randomint(5), randomint(5), randomint(5));
  }

  var_9 = createairdropcrate(self.owner, var_1, var_11, var_5, var_0);

  switch (var_1) {
    case "nuke_drop":
    case "airdrop_mega":
    case "airdrop_juggernaut_maniac":
    case "airdrop_juggernaut_recon":
    case "airdrop_juggernaut":
      var_9 linkto(self, "tag_ground", (64, 32, -128), (0, 0, 0));
      break;
    case "airdrop_osprey_gunner":
    case "airdrop_escort":
      var_9 linkto(self, var_8, (0, 0, 0), (0, 0, 0));
      break;
    default:
      var_9 linkto(self, "tag_ground", (32, 0, 5), (0, 0, 0));
      break;
  }

  var_9.angles = (0, 0, 0);
  var_9 show();
  var_14 = self.veh_speed;

  if(issubstr(var_11, "juggernaut")) {
    var_6 = (0, 0, 0);
  }

  thread waitfordropcratemsg(var_9, var_6, var_1, var_11);
  var_9.droppingtoground = 1;
  return var_11;
}

killplayerfromcrate_dodamage(var_0) {
  if(!scripts\mp\utility\game::istrue(level.noairdropkills)) {
    var_0 getrandomarmkillstreak(1000, var_0.origin, self, self, "MOD_CRUSH");
  }

  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(scripts\mp\utility\game::isreallyalive(var_0)) {
    childthread scripts\mp\movers::unresolved_collision_nearest_node(var_0, undefined, self);
  }
}

killplayerfromcrate_fastvelocitypush() {
  self endon("death");

  for(;;) {
    self waittill("player_pushed", var_0, var_1);

    if(isplayer(var_0) || isagent(var_0)) {
      if(var_1[2] < -20) {
        killplayerfromcrate_dodamage(var_0);
      }
    }

    wait 0.05;
  }
}

airdrop_override_death_moving_platform(var_0) {
  if(isDefined(var_0.lasttouchedplatform.destroyairdroponcollision) && var_0.lasttouchedplatform.destroyairdroponcollision) {
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);
    deletecrateold();
  }
}

cleanup_crate_capture() {
  var_0 = self getlinkedchildren(1);

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isplayer(var_2)) {
      continue;
    }
    if(isDefined(var_2.iscapturingcrate) && var_2.iscapturingcrate) {
      var_3 = var_2 getlinkedparent();

      if(isDefined(var_3)) {
        var_2 scripts\mp\gameobjects::updateuiprogress(var_3, 0);
        var_2 unlink();
      }

      if(isalive(var_2)) {
        var_2 scripts\engine\utility::allow_weapon(1);
      }

      var_2.iscapturingcrate = 0;
    }
  }
}

airdrop_override_invalid_moving_platform(var_0) {
  wait 0.05;
  self notify("restarting_physics");
  cleanup_crate_capture();
  self physicslaunchserver((0, 0, 0), var_0.dropimpulse, var_0.airdrop_max_linear_velocity);
  thread physicswaiter(var_0.droptype, var_0.cratetype, var_0.dropimpulse, var_0.airdrop_max_linear_velocity);
}

waitfordropcratemsg(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(!isDefined(var_5) || !var_5) {
    self waittill("drop_crate");
  }

  var_6 = 1200;

  if(isDefined(var_4)) {
    var_6 = var_4;
  }

  var_0 unlink();
  var_0 physicslaunchserver((0, 0, 0), var_1, var_6);
  var_0 thread physicswaiter(var_2, var_3, var_1, var_6);
  var_0 thread killplayerfromcrate_fastvelocitypush();
  var_0.unresolved_collision_func = ::killplayerfromcrate_dodamage;

  if(isDefined(var_0.killcament)) {
    if(isDefined(var_0.carestrike)) {
      var_7 = -2100;
    } else {
      var_7 = 0;
    }

    var_0.killcament unlink();
    var_8 = bulletTrace(var_0.origin, var_0.origin + (0, 0, -10000), 0, var_0);
    var_9 = distance(var_0.origin, var_8["position"]);
    var_10 = var_9 / 800;
    var_0.killcament moveto(var_8["position"] + (0, 0, 300) + (var_7, 0, 0), var_10);
  }
}

waitandanimate() {
  self endon("death");
  wait 0.035;
  playFX(level._effect["airdrop_dust_kickup"], self.origin + (0, 0, 5), (0, 0, 1));
  self.friendlymodel scriptmodelplayanim("juggernaut_carepackage");
  self.enemymodel scriptmodelplayanim("juggernaut_carepackage");
}

physicswaiter(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::istrue(var_4)) {
    self endon("death");
  }

  self endon("restarting_physics");
  func_136A7();
  self.droppingtoground = 0;
  self thread[[level.cratetypes[var_0][var_1].func]](var_0);
  level thread droptimeout(self, self.owner, var_1);
  var_5 = spawnStruct();
  var_5.endonstring = "restarting_physics";
  var_5.deathoverridecallback = ::airdrop_override_death_moving_platform;
  var_5.invalidparentoverridecallback = ::airdrop_override_invalid_moving_platform;
  var_5.droptype = var_0;
  var_5.cratetype = var_1;
  var_5.dropimpulse = var_2;
  var_5.airdrop_max_linear_velocity = var_3;
  thread scripts\mp\movers::handle_moving_platforms(var_5);

  if(self.friendlymodel scripts\mp\utility\game::touchingbadtrigger()) {
    deletecrateold();
    return;
  }

  if(isDefined(self.owner) && abs(self.origin[2] - self.owner.origin[2]) > 3000) {
    deletecrateold();
  }
}

func_136A7() {
  wait 0.5;

  for(;;) {
    var_0 = self physics_getbodyid(0);
    var_1 = physics_getbodylinvel(var_0);

    if(lengthsquared(var_1) > 0.5) {
      wait 0.1;
      continue;
    }

    break;
  }
}

droptimeout(var_0, var_1, var_2) {
  if(isDefined(level.nod_gesture) && level.nod_gesture) {
    return;
  }
  level endon("game_ended");
  var_0 endon("death");

  if(var_0.droptype == "nuke_drop") {
    return;
  }
  var_3 = 90.0;

  if(var_2 == "supply") {
    var_3 = 20.0;
  } else if(var_2 == "bomb_trap") {
    var_3 = 60.0;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);

  while(var_0.curprogress != 0) {
    wait 1;
  }

  var_0 deletecrateold();
}

getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

getpathend(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

getflyheightoffset(var_0) {
  var_1 = 850;
  var_2 = getent("airstrikeheight", "targetname");

  if(!isDefined(var_2)) {
    if(isDefined(level.airstrikeheightscale)) {
      if(level.airstrikeheightscale > 2) {
        var_1 = 1500;
        return var_1 * level.airstrikeheightscale;
      }

      return var_1 * level.airstrikeheightscale + 256 + var_0[2];
    } else
      return var_1 + var_0[2];
  } else
    return var_2.origin[2];
}

func_581F(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed()) {
    return;
  }
  if(var_3 == "dronedrop_grnd") {
    var_5 = var_1.droporigin;
  } else {
    var_5 = var_1.location;
  }

  var_6 = getflyheightoffset(var_5);
  var_7 = var_5 * (1, 1, 0) + (0, 0, var_6);
  var_8 = getpathstart(var_7, var_2);
  var_9 = getpathend(var_7, var_2);
  var_7 = var_7 + anglesToForward((0, var_2, 0)) * -50;
  var_10 = func_5CC7(var_0, var_8, var_7, var_3, var_1, var_4);
  var_11 = undefined;
  var_12 = 999999;
  var_13 = scripts\engine\trace::ray_trace(var_5, var_5 + (0, 0, 10000), level.characters, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  var_14 = undefined;
  var_15 = 0;

  if(var_13["hittype"] == "hittype_none") {
    var_14 = var_5 * (1, 1, 0) + (0, 0, var_6);
    var_15 = 1;
  } else {
    if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
      foreach(var_17 in level.carepackagedropnodes) {
        var_18 = distance(var_17.origin, var_5);

        if(var_18 < var_12) {
          var_11 = var_17;
          var_12 = var_18;
        }
      }
    }

    var_14 = var_11.origin * (1, 1, 0) + (0, 0, var_6);
  }

  var_20 = "";
  var_21 = "used_dronedrop";

  if(isDefined(var_4)) {
    var_20 = scripts\mp\killstreak_loot::getrarityforlootitem(var_4.variantid);
    var_21 = "used_" + var_4.streakname;
  }

  if(var_20 != "" && var_20 != "rare") {
    var_21 = var_21 + "_" + var_20;
  }

  if(level.gametype != "grnd") {
    level thread scripts\mp\utility\game::teamplayercardsplash(var_21, var_0);
  }

  var_10 setvehgoalpos(var_14, 1);
  var_10 setscriptablepartstate("lights", "idle");
  var_10 setscriptablepartstate("thrusters", "fly", 0);
  var_10 thread func_13A04(var_14, var_5, var_15);
}

func_5CC7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = "veh_mil_air_un_delivery_drone";
  var_8 = "";

  if(isDefined(var_5)) {
    var_8 = scripts\mp\killstreak_loot::getrarityforlootitem(var_5.variantid);
  }

  if(var_8 != "") {
    var_7 = var_7 + "_" + var_8;
  }

  if(isDefined(var_5)) {
    if(scripts\mp\killstreaks\utility::func_A69F(var_5, "passive_bomb_trap")) {
      var_3 = "dronedrop_trap";
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_5, "passive_reroll")) {
      var_3 = "dronedrop_reroll";
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_5, "passive_high_roller")) {
      var_3 = "dronedrop_highroll";
    }
  }

  var_9 = spawnhelicopter(var_0, var_1, var_6, "delivery_drone_mp", var_7);

  if(!isDefined(var_9)) {
    return;
  }
  var_9.maxhealth = 100;
  var_9.owner = var_0;
  var_9.team = var_0.team;
  var_9.isairdrop = 1;
  var_9 setmaxpitchroll(35, 35);
  var_9 vehicle_setspeed(1600, 200, 200);
  var_9 setyawspeed(250, 100);
  var_9 setneargoalnotifydist(1000);
  var_9 sethoverparams(5, 5, 2);
  var_9 setCanDamage(1);
  var_9 setturningability(1.0);
  var_9 func_84E1(1);
  var_9 func_84E0(1);
  var_9.streakinfo = var_5;
  var_9.helitype = "dronedrop";
  var_9 scripts\mp\killstreaks\utility::func_1843(var_9.helitype, "Killstreak_Air", var_0, 1);
  var_10 = getcratetypefordroptype(var_3);
  var_11 = var_9 createairdropcrate(var_0, var_3, var_10, var_9.origin);
  var_11 linkto(var_9, "tag_origin", (0, 0, 5), (0, 0, 0));
  var_11.streakinfo = var_5;
  var_9.var_5D26 = var_11;
  var_9 thread watchtimeout(60);
  var_9 thread func_13A01(var_11, var_3, var_10, var_4);
  var_9 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("dronedrop", undefined, 1);
  var_9 thread watchempdamage();

  if(var_3 == "dronedrop_trap") {
    var_9 thread watchownerdisconnect(var_11, var_4);
  }

  var_9 setscriptablepartstate("dust", "active", 0);
  var_9 thread dronewatchgameover();
  return var_9;
}

func_13A01(var_0, var_1, var_2, var_3) {
  self waittill("death");

  if(!isDefined(var_0)) {
    return;
  }
  var_4 = (0, 0, 0);
  var_5 = 1200;
  var_6 = undefined;

  if(var_1 == "dronedrop_trap") {
    var_6 = 1;
  }

  var_0 unlink();
  var_0 physicslaunchserver((0, 0, 0), var_4, var_5);
  var_0 thread physicswaiter(var_1, var_2, var_4, var_5, var_6);
  var_0 thread killplayerfromcrate_fastvelocitypush();
  var_0.unresolved_collision_func = ::killplayerfromcrate_dodamage;

  if(isDefined(var_0.killcament)) {
    var_0.killcament unlink();
  }

  if(isDefined(var_3.var_1349C)) {
    var_3.var_1349C delete();
  }

  var_0 thread handlenavobstacle();
  func_5CAC();
  scripts\mp\utility\game::printgameaction("killstreak ended - dronedrop", self.owner);
}

handlenavobstacle() {
  self endon("death");
  self endon("nav_obstacle_destroyed");
  wait 1;
  self.var_BE6F = _createnavobstaclebybounds(self.origin, (30, 10, 64), self.angles);
  var_0 = self.origin;

  while(isDefined(self) && isDefined(self.var_BE6F)) {
    if(distance2dsquared(var_0, self.origin) > 64) {
      _destroynavobstacle(self.var_BE6F);
      self.var_BE6F = _createnavobstaclebybounds(self.origin, (30, 10, 64), self.angles);
      var_0 = self.origin;
    }

    wait 1;
  }
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_3) && var_3 == "concussion_grenade_mp") {
      if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
        var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
      }
    }

    scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_0, var_0, self.team, var_2, var_4, var_3);
  }
}

watchownerdisconnect(var_0, var_1) {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(var_1.var_1349C)) {
    var_1.var_1349C delete();
  }

  var_0 deletecrateold();
  func_5CAC();
}

func_5CAC() {
  playFX(scripts\engine\utility::getfx("drone_explode"), self.origin);
  self playSound("sentry_explode");
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

func_13A04(var_0, var_1, var_2) {
  self endon("death");
  self waittill("goal");
  thread watchmantledisable();
  var_3 = (0, 0, -30);
  var_4 = (0, 0, 12);
  self setscriptablepartstate("thrusters", "descend", 0);
  thread watchfailsafe(var_0);
  var_5 = undefined;

  if(!scripts\mp\utility\game::istrue(var_2)) {
    if(_areanynavvolumesloaded()) {
      var_6 = var_1 + (0, 0, 12);
      var_5 = _findpath3d(self.origin, var_6);
    } else {
      var_7 = scripts\engine\trace::create_solid_ai_contents();
      var_8 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 500), self, var_7);
      var_9 = getclosestpointonnavmesh(var_8["position"], self);
      var_5 = self.owner findpath(var_9, var_1);
      self.owner iprintlnbold("3D Nav Volume is not present, using 2D path instead");
    }
  } else
    var_5 = [var_1 + (0, 0, 12)];

  var_10 = 0;
  var_11 = self.origin;

  foreach(var_16, var_13 in var_5) {
    if(var_16 == var_5.size - 1) {
      var_10 = 1;
    }

    if(var_10) {
      var_14 = var_4;
    } else {
      var_14 = var_3;
    }

    var_15 = 50;
    self setneargoalnotifydist(var_15);
    var_11 = var_13;

    if(!var_10) {
      thread func_BA1C(var_13 + var_14, var_5[var_16 + 1] + var_14);
    } else {
      thread func_BA1D(var_13 + var_14);
    }

    self setscriptablepartstate("thrusters", "navigate", 0);
    self setvehgoalpos(var_13 + var_14, var_10);

    if(!var_10 || scripts\mp\utility\game::istrue(var_2)) {
      self waittill("near_goal");
      continue;
    }

    self waittill("goal");
  }

  self notify("death");
}

watchmantledisable() {
  self endon("death");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_1)) {
        continue;
      }
      if(distancesquared(self.origin, var_1.origin) <= 10000 && !isDefined(var_1.cratemantle)) {
        var_1.cratemantle = 0;
        var_1 scripts\engine\utility::allow_mantle(0);
        var_1 thread watchdistancefromcrate(self);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

watchdistancefromcrate(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(isDefined(var_0)) {
    if(distancesquared(var_0.origin, self.origin) > 10000) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  self.cratemantle = undefined;
  scripts\engine\utility::allow_mantle(1);
}

watchfailsafe(var_0) {
  self endon("death");
  self endon("near_goal");
  var_1 = 3;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

  if(distancesquared(self.origin, var_0) < 2500) {
    self notify("death");
  }
}

func_7E84(var_0) {
  var_1 = abs(var_0[0]);
  var_2 = abs(var_0[1]);
  var_3 = abs(var_0[2]);
  return int(max(var_3, max(var_1, var_2)));
}

func_BA00(var_0, var_1) {
  self notify("stop_MonitorPath");
  self endon("death");
  self endon("stop_MonitorPath");
  self endon("goal");
  self endon("near_goal");
  var_2[0] = self;
  var_2[1] = self.var_5D26;

  for(;;) {
    var_3 = scripts\engine\trace::sphere_trace(self.origin, var_1, 16, var_2);

    if(var_3["fraction"] == 1.0) {
      self notify("near_goal");
    }

    wait 0.25;
  }
}

setupchallengelocales(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.var_B75B = var_1;
  var_6.var_B491 = var_2;
  var_6.var_B7CB = var_3;
  var_6.var_B4C9 = var_4;
  var_6.var_1545 = var_5;
  level.var_109C4[var_0] = var_6;
}

setupcaptureflares() {
  setupchallengelocales("far", 500, 750, 45, 70, 100);
  setupchallengelocales("medium", 250, 500, 35, 45, 100);
  setupchallengelocales("near", 50, 250, 15, 30, 100);
  setupchallengelocales("medium_sharpturn", 250, 500, 10, 30, 100);
  setupchallengelocales("near_sharpturn", 50, 250, 10, 20, 100);
  setupchallengelocales("final", 50, 1000, 10, 45, 100);
}

func_12F22(var_0, var_1) {
  var_2 = 9999;
  var_3 = level.var_109C4[var_0];

  if(var_1 < var_3.var_B75B) {
    var_1 = var_3.var_B75B;
  }

  if(var_1 > var_3.var_B491) {
    var_1 = var_3.var_B491;
  }

  var_4 = (var_1 - var_3.var_B75B) / (var_3.var_B491 - var_3.var_B75B);
  var_5 = var_3.var_B7CB + var_4 * (var_3.var_B4C9 - var_3.var_B7CB);
  var_6 = var_3.var_1545;

  if(var_6 > var_5) {
    var_6 = var_5;
  }

  self vehicle_setspeed(var_5, var_6, var_2);
}

func_BA1D(var_0) {
  self notify("stop_MonitorSpeed");
  self endon("death");
  self endon("stop_MonitorSpeed");
  self endon("goal");
  var_1 = "none";

  for(;;) {
    var_2 = distance(self.origin, var_0);
    func_12F22("final", var_2);
    scripts\engine\utility::waitframe();
  }
}

func_BA1C(var_0, var_1) {
  self notify("stop_MonitorSpeed");
  self endon("death");
  self endon("stop_MonitorSpeed");
  var_2 = "none";
  var_3 = vectornormalize(var_1 - var_0);
  var_4 = distance(var_0, var_1);

  for(;;) {
    var_5 = distance(self.origin, var_0);
    var_6 = vectornormalize(var_0 - self.origin);
    var_7 = vectordot(var_3, var_6);
    var_8 = 0;

    if(var_7 < 0.707 || var_4 < 300) {
      var_8 = 1;
    }

    if(var_8) {
      if(var_5 < level.var_109C4["medium_sharpturn"].var_B75B) {
        func_12F22("near_sharpturn", var_5);
      } else {
        func_12F22("medium_sharpturn", var_5);
      }
    } else if(var_5 < level.var_109C4["near"].var_B491)
      func_12F22("near", var_5);
    else if(var_5 < level.var_109C4["medium"].var_B491) {
      func_12F22("medium", var_5);
    } else {
      func_12F22("far", var_5);
    }

    scripts\engine\utility::waitframe();
  }
}

doflyby(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed()) {
    return;
  }
  var_6 = getflyheightoffset(var_1);

  if(isDefined(var_4)) {
    var_6 = var_6 + var_4;
  }

  foreach(var_8 in level.littlebirds) {
    if(isDefined(var_8.droptype)) {
      var_6 = var_6 + 128;
    }
  }

  var_10 = var_1 * (1, 1, 0) + (0, 0, var_6);
  var_11 = getpathstart(var_10, var_2);
  var_12 = getpathend(var_10, var_2);
  var_10 = var_10 + anglesToForward((0, var_2, 0)) * -50;
  var_13 = helisetup(var_0, var_11, var_10);

  if(isDefined(level.highlightairdrop) && level.highlightairdrop) {
    var_13 hudoutlineenable(3, 0, 0);
  }

  var_13 endon("death");
  var_13 thread func_4FC2();
  var_13.droptype = var_3;
  var_13 setvehgoalpos(var_10, 1);
  var_13 thread dropthecrate(var_1, var_3, var_6, 0, var_5, var_11);
  wait 2;
  var_13 vehicle_setspeed(75, 40);
  var_13 setyawspeed(180, 180, 180, 0.3);
  var_13 waittill("goal");
  wait 0.1;
  var_13 notify("drop_crate");
  var_13 setvehgoalpos(var_12, 1);
  var_13 vehicle_setspeed(300, 75);
  var_13.var_AB32 = 1;
  var_13 waittill("goal");
  var_13 notify("leaving");
  var_13 notify("delete");
  var_13 delete();
}

func_4FC2() {
  self waittill("death");
  waittillframeend;
  scripts\mp\utility::decrementfauxvehiclecount();
}

domegaflyby(var_0, var_1, var_2, var_3) {
  level thread doflyby(var_0, var_1, var_2, var_3, 0);
  wait(randomintrange(1, 2));
  level thread doflyby(var_0, var_1 + (128, 128, 0), var_2, var_3, 128);
  wait(randomintrange(1, 2));
  level thread doflyby(var_0, var_1 + (172, 256, 0), var_2, var_3, 256);
  wait(randomintrange(1, 2));
  level thread doflyby(var_0, var_1 + (64, 0, 0), var_2, var_3, 0);
}

doc130flyby(var_0, var_1, var_2, var_3) {
  var_4 = 18000;
  var_5 = 3000;
  var_6 = vectortoyaw(var_1 - var_0.origin);
  var_7 = (0, var_6, 0);
  var_8 = getflyheightoffset(var_1);
  var_9 = var_1 + anglesToForward(var_7) * (-1 * var_4);
  var_9 = var_9 * (1, 1, 0) + (0, 0, var_8);
  var_10 = var_1 + anglesToForward(var_7) * var_4;
  var_10 = var_10 * (1, 1, 0) + (0, 0, var_8);
  var_11 = length(var_9 - var_10);
  var_12 = var_11 / var_5;
  var_13 = c130setup(var_0, var_9, var_10);
  var_13.veh_speed = var_5;
  var_13.droptype = var_3;
  var_13 playLoopSound("veh_ac130_dist_loop");
  var_13.angles = var_7;
  var_14 = anglesToForward(var_7);
  var_13 moveto(var_10, var_12, 0, 0);
  var_15 = distance2d(var_13.origin, var_1);
  var_16 = 0;

  for(;;) {
    var_17 = distance2d(var_13.origin, var_1);

    if(var_17 < var_15) {
      var_15 = var_17;
    } else if(var_17 > var_15) {
      break;
    }
    if(var_17 < 320) {
      break;
    } else if(var_17 < 768) {
      scripts\mp\shellshock::_earthquake(0.15, 1.5, var_1, 1500);

      if(!var_16) {
        var_13 playSound("veh_ac130_sonic_boom");
        var_16 = 1;
      }
    }

    wait 0.05;
  }

  wait 0.05;
  var_18 = (0, 0, 0);
  var_19[0] = var_13 thread dropthecrate(var_1, var_3, var_8, 0, undefined, var_9, var_18);
  wait 0.05;
  var_13 notify("drop_crate");
  var_20 = var_1 + anglesToForward(var_7) * (var_4 * 1.5);
  var_13 moveto(var_20, var_12 / 2, 0, 0);
  wait 6;
  var_13 delete();
}

domegac130flyby(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 24000;
  var_6 = 2000;
  var_7 = vectortoyaw(var_1 - var_0.origin);
  var_8 = (0, var_7, 0);
  var_9 = anglesToForward(var_8);

  if(isDefined(var_4)) {
    var_1 = var_1 + var_9 * var_4;
  }

  var_10 = getflyheightoffset(var_1);
  var_11 = var_1 + anglesToForward(var_8) * (-1 * var_5);
  var_11 = var_11 * (1, 1, 0) + (0, 0, var_10);
  var_12 = var_1 + anglesToForward(var_8) * var_5;
  var_12 = var_12 * (1, 1, 0) + (0, 0, var_10);
  var_13 = length(var_11 - var_12);
  var_14 = var_13 / var_6;
  var_15 = c130setup(var_0, var_11, var_12);
  var_15.veh_speed = var_6;
  var_15.droptype = var_3;
  var_15 playLoopSound("veh_ac130_dist_loop");
  var_15.angles = var_8;
  var_9 = anglesToForward(var_8);
  var_15 moveto(var_12, var_14, 0, 0);
  var_16 = distance2d(var_15.origin, var_1);
  var_17 = 0;

  for(;;) {
    var_18 = distance2d(var_15.origin, var_1);

    if(var_18 < var_16) {
      var_16 = var_18;
    } else if(var_18 > var_16) {
      break;
    }
    if(var_18 < 256) {
      break;
    } else if(var_18 < 768) {
      scripts\mp\shellshock::_earthquake(0.15, 1.5, var_1, 1500);

      if(!var_17) {
        var_15 playSound("veh_ac130_sonic_boom");
        var_17 = 1;
      }
    }

    wait 0.05;
  }

  wait 0.05;
  var_19[0] = var_15 thread dropthecrate(var_1, var_3, var_10, 0, undefined, var_11);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 0.05;
  var_19[1] = var_15 thread dropthecrate(var_1, var_3, var_10, 0, undefined, var_11, undefined, var_19);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 0.05;
  var_19[2] = var_15 thread dropthecrate(var_1, var_3, var_10, 0, undefined, var_11, undefined, var_19);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 0.05;
  var_19[3] = var_15 thread dropthecrate(var_1, var_3, var_10, 0, undefined, var_11, undefined, var_19);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 4;
  var_15 delete();
}

dropnuke(var_0, var_1, var_2) {
  var_3 = 24000;
  var_4 = 2000;
  var_5 = randomint(360);
  var_6 = (0, var_5, 0);
  var_7 = getflyheightoffset(var_0);
  var_8 = var_0 + anglesToForward(var_6) * (-1 * var_3);
  var_8 = var_8 * (1, 1, 0) + (0, 0, var_7);
  var_9 = var_0 + anglesToForward(var_6) * var_3;
  var_9 = var_9 * (1, 1, 0) + (0, 0, var_7);
  var_10 = length(var_8 - var_9);
  var_11 = var_10 / var_4;
  var_12 = c130setup(var_1, var_8, var_9);
  var_12.veh_speed = var_4;
  var_12.droptype = var_2;
  var_12 playLoopSound("veh_ac130_dist_loop");
  var_12.angles = var_6;
  var_13 = anglesToForward(var_6);
  var_12 moveto(var_9, var_11, 0, 0);
  var_14 = 0;
  var_15 = distance2d(var_12.origin, var_0);

  for(;;) {
    var_16 = distance2d(var_12.origin, var_0);

    if(var_16 < var_15) {
      var_15 = var_16;
    } else if(var_16 > var_15) {
      break;
    }
    if(var_16 < 256) {
      break;
    } else if(var_16 < 768) {
      scripts\mp\shellshock::_earthquake(0.15, 1.5, var_0, 1500);

      if(!var_14) {
        var_12 playSound("veh_ac130_sonic_boom");
        var_14 = 1;
      }
    }

    wait 0.05;
  }

  var_12 thread dropthecrate(var_0, var_2, var_7, 0, "nuke", var_8);
  wait 0.05;
  var_12 notify("drop_crate");
  wait 4;
  var_12 delete();
}

stoploopafter(var_0) {
  self endon("death");
  wait(var_0);
  self stoploopsound();
}

playlooponent(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();
  var_1 endon("death");
  thread scripts\engine\utility::delete_on_death(var_1);
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1 linkto(self);
  var_1 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_1 stoploopsound(var_0);
  var_1 delete();
}

c130setup(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = spawnplane(var_0, "script_model", var_1, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
  var_4 setModel("vehicle_ac130_low_mp");

  if(!isDefined(var_4)) {
    return;
  }
  var_4.owner = var_0;
  var_4.team = var_0.team;
  level.c130 = var_4;
  return var_4;
}

helisetup(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = "littlebird_mp";

  if(isDefined(level.vehicleoverride)) {
    var_4 = level.vehicleoverride;
  }

  var_5 = spawnhelicopter(var_0, var_1, var_3, var_4, "vehicle_aas_72x_killstreak");

  if(!isDefined(var_5)) {
    return;
  }
  var_5.maxhealth = 500;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.isairdrop = 1;
  var_5 thread watchtimeout();
  var_5 thread heli_existence();
  var_5 thread helidestroyed();
  var_5 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("airdrop");
  var_5 setmaxpitchroll(45, 85);
  var_5 vehicle_setspeed(250, 175);
  var_5.helitype = "airdrop";
  var_5 scripts\mp\killstreaks\utility::func_1843(var_5.helitype, "Killstreak_Air", var_0, 1);
  var_5 hidepart("tag_wings");
  return var_5;
}

watchtimeout(var_0) {
  level endon("game_ended");
  self endon("leaving");
  self endon("helicopter_gone");
  self endon("death");
  var_1 = 25.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  self notify("death");
}

heli_existence() {
  scripts\engine\utility::waittill_any("crashing", "leaving");
  self notify("helicopter_gone");
}

helidestroyed() {
  self endon("leaving");
  self endon("helicopter_gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self vehicle_setspeed(25, 5);
  thread lbspin(randomintrange(180, 220));
  wait(randomfloatrange(0.5, 1.5));
  self notify("drop_crate");
  lbexplode();
}

lbexplode() {
  var_0 = self.origin + (0, 0, 1) - self.origin;
  playFX(level.chopper_fx["explode"]["death"]["cobra"], self.origin, var_0);
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

lbspin(var_0) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  playFXOnTag(level.chopper_fx["fire"]["trail"]["medium"], self, "tail_rotor_jnt");
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

nukecapturethink() {
  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(!var_0 isonground()) {
      continue;
    }
    if(!useholdthink(var_0)) {
      continue;
    }
    self notify("captured", var_0);
  }
}

crateothercapturethink(var_0, var_1) {
  self endon("restarting_physics");
  var_2 = self;
  var_3 = undefined;

  if(scripts\mp\utility\game::istrue(var_1)) {
    var_2 = self.fakeuseobj;
    var_3 = self.fakeuseobj;
  }

  while(isDefined(self)) {
    var_2 waittill("trigger", var_4);

    if(isDefined(self.owner) && var_4 == self.owner) {
      continue;
    }
    if(!validateopenconditions(var_4)) {
      continue;
    }
    if(isDefined(level.overridecrateusetime)) {
      var_5 = level.overridecrateusetime;
    } else {
      var_5 = undefined;
    }

    var_4.iscapturingcrate = 1;

    if(!scripts\mp\utility\game::istrue(var_1)) {
      var_3 = createuseent();
    }

    var_6 = var_3 useholdthink(var_4, var_5, var_0);

    if(!scripts\mp\utility\game::istrue(var_1)) {
      if(isDefined(var_3)) {
        var_3 delete();
      }
    }

    if(!isDefined(var_4)) {
      return;
    }
    if(!var_6) {
      var_4.iscapturingcrate = 0;
      continue;
    }

    var_4.iscapturingcrate = 0;
    self notify("captured", var_4);
  }
}

crateownercapturethink(var_0) {
  self endon("restarting_physics");

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(isDefined(self.owner) && var_1 != self.owner) {
      continue;
    }
    if(!validateopenconditions(var_1)) {
      continue;
    }
    var_1.iscapturingcrate = 1;

    if(!useholdthink(var_1, 500, var_0)) {
      var_1.iscapturingcrate = 0;
      continue;
    }

    var_1.iscapturingcrate = 0;
    self notify("captured", var_1);
  }
}

crateallcapturethink(var_0) {
  self endon("restarting_physics");
  self.crateuseents = [];

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(!validateopenconditions(var_1)) {
      continue;
    }
    if(isDefined(level.overridecrateusetime)) {
      var_2 = level.overridecrateusetime;
    } else {
      var_2 = undefined;
    }

    childthread cratealluselogic(var_1, var_2, var_0);
  }
}

cratealluselogic(var_0, var_1, var_2) {
  var_0.iscapturingcrate = 1;
  self.crateuseents[var_0.name] = createuseent();
  var_3 = self.crateuseents[var_0.name];
  var_4 = self.crateuseents[var_0.name] useholdthink(var_0, var_1, var_2, self);

  if(isDefined(self.crateuseents) && isDefined(var_3)) {
    self.crateuseents = scripts\mp\utility\game::func_22B1(self.crateuseents, var_3);
    var_3 delete();
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0.iscapturingcrate = 0;

  if(var_4) {
    self notify("captured", var_0);
  }
}

updatecraftingomnvars() {
  self.inuse = 0;

  foreach(var_1 in self.crateuseents) {
    if(var_1.inuse) {
      self.inuse = 1;
      break;
    }
  }
}

validateopenconditions(var_0) {
  if((self.cratetype == "airdrop_juggernaut_recon" || self.cratetype == "airdrop_juggernaut" || self.cratetype == "airdrop_juggernaut_maniac") && var_0 scripts\mp\utility\game::isjuggernaut()) {
    return 0;
  }

  if(isDefined(var_0.onhelisniper) && var_0.onhelisniper) {
    return 0;
  }

  var_1 = var_0 getcurrentweapon();

  if(scripts\mp\utility\game::iskillstreakweapon(var_1) && !scripts\mp\utility\game::isjuggernautweapon(var_1)) {
    return 0;
  }

  if(isbot(var_0)) {
    if(level.gametype != "grnd" && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(self.cratetype)) {
      return 0;
    }

    if(scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots(self.cratetype)) {
      return 0;
    }
  }

  return 1;
}

killstreakcratethink(var_0) {
  self endon("restarting_physics");
  self endon("death");

  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var_1 = game["strings"][self.cratetype + "_hint"];
  } else {
    var_1 = &"PLATFORM_GET_KILLSTREAK";
  }

  var_2 = -10000;
  var_3 = undefined;

  if(!scripts\mp\utility\game::istrue(level.gameended)) {
    if(var_0 == "dronedrop_reroll") {
      var_3 = 1;

      if(isDefined(game["strings"][self.cratetype + "_rerollHint"])) {
        var_1 = game["strings"][self.cratetype + "_rerollHint"];
      }
    }

    cratesetupforuse(var_1, scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype), var_3, var_2);
  }

  thread crateothercapturethink(undefined, var_3);
  thread crateownercapturethink();
  thread cratewatchgameover();

  for(;;) {
    self waittill("captured", var_4);

    if(isplayer(var_4)) {
      var_4 setclientomnvar("ui_securing", 0);
      var_4.ui_securing = undefined;
    }

    if(isDefined(self.owner)) {
      if(var_4 == self.owner) {
        var_4 thread scripts\mp\missions::func_D991("ch_scorestreak_uses_dronepackage");
      } else if(!level.teambased || var_4.team != self.team) {
        switch (var_0) {
          case "airdrop_osprey_gunner":
          case "airdrop_escort":
          case "airdrop_support":
          case "airdrop_assault":
            var_4 thread scripts\mp\missions::processchallenge("hijacker_airdrop");
            var_4 thread hijacknotify(self, "airdrop");
            break;
          case "airdrop_sentry_minigun":
            var_4 thread scripts\mp\missions::processchallenge("hijacker_airdrop");
            var_4 thread hijacknotify(self, "sentry");
            break;
          case "airdrop_remote_tank":
            var_4 thread scripts\mp\missions::processchallenge("hijacker_airdrop");
            var_4 thread hijacknotify(self, "remote_tank");
            break;
          case "airdrop_mega":
            var_4 thread scripts\mp\missions::processchallenge("hijacker_airdrop_mega");
            var_4 thread hijacknotify(self, "emergency_airdrop");
            break;
          case "dronedrop_highroll":
          case "jackaldrop":
          case "dronedrop_reroll":
          case "dronedrop":
            var_4 thread hijacknotify(self, "dronedrop");
            var_4 thread scripts\mp\missions::func_D991("ch_hijack");
            break;
        }
      } else if(level.gametype != "grnd") {
        self.owner thread scripts\mp\awards::givemidmatchaward("ss_use_dronedrop");
        self.owner thread scripts\mp\missions::func_D991("ch_package_share");
      }
    }

    var_4 playlocalsound("ammo_crate_use");
    var_5 = undefined;

    if(scripts\mp\utility\game::istrue(level.enablevariantdrops)) {
      var_5 = scripts\mp\killstreak_loot::getrandomvariantfrombaseref(self.cratetype);
    }

    if(isDefined(var_5)) {
      var_6 = scripts\mp\killstreak_loot::getpassiveperk(var_5);
      var_4 thread scripts\mp\killstreaks\killstreaks::awardkillstreak(self.cratetype, self.owner, var_6, var_5);
      var_7 = scripts\mp\killstreak_loot::getrarityforlootitem(var_5);
      var_8 = self.cratetype + "_" + var_7;
      var_4 scripts\mp\hud_message::showkillstreaksplash(var_8, undefined, 1);
    } else {
      var_4 thread scripts\mp\killstreaks\killstreaks::givekillstreak(self.cratetype, 0, 0, self.owner);
      var_4 scripts\mp\hud_message::showkillstreaksplash(self.cratetype, undefined, 1);
    }

    if(scripts\mp\killstreaks\killstreaks::getstreakcost(self.cratetype) > 1000) {
      var_4 thread scripts\mp\missions::func_D991("ch_dronepackage_jackpot");
    }

    deletecrateold();
  }
}

killstreakbombcratethink(var_0) {
  self endon("restarting_physics");
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  var_1 = [ &"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", &"KILLSTREAKS_HINTS_JACKAL_PICKUP", &"KILLSTREAKS_HINTS_THOR_PICKUP", &"KILLSTREAKS_HINTS_RC8_PICKUP", &"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP"];
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = undefined;

  if(level.gametype == "grnd") {
    var_3 = -10000;
  }

  if(!scripts\mp\utility\game::istrue(level.gameended)) {
    cratesetupforuse(var_2, "hud_icon_trap_package", 0, var_3);
  }

  thread crateothercapturethink();
  thread cratewatchgameover();
  thread cratewatchownerdisconnect();

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament moveto(self.origin + (0, 0, 30), 0.05);
  }

  self waittill("captured", var_4);

  if(isplayer(var_4)) {
    var_4 setclientomnvar("ui_securing", 0);
    var_4.ui_securing = undefined;
  }

  var_4 playlocalsound("ammo_crate_use");
  var_5 = self.owner scripts\mp\utility\game::_launchgrenade("dummy_spike_mp", self.origin, self.origin, 2);

  if(!isDefined(var_5.weapon_name)) {
    var_5.weapon_name = "dummy_spike_mp";
  }

  var_5 linkto(self);
  var_6 = 0.1;
  var_7 = 0;

  while(var_7 < 0.8) {
    playLoopSound(self.origin + (0, 0, 10), "mp_dronepackage_trap_warning");
    var_7 = var_7 + var_6;
    wait(var_6);
  }

  playFX(scripts\engine\utility::getfx("crate_explode"), self.origin);
  playLoopSound(self.origin, "mp_equip_destroyed");
  scripts\mp\shellshock::func_22FF(1.0, 0.7, 800);

  if(isDefined(self.owner)) {
    self radiusdamage(self.origin, 256, 200, 100, self.owner, "MOD_EXPLOSIVE", "jackal_fast_cannon_mp");
  }

  deletecrateold();
}

cratewatchownerdisconnect() {
  self endon("death");
  self.owner waittill("disconnect");
  deletecrateold();
}

cratewatchgameover() {
  self endon("death");
  level scripts\engine\utility::waittill_any("bro_shot_start", "game_ended");

  if(isDefined(self)) {
    deletecrateold();
  }
}

dronewatchgameover() {
  self endon("death");
  level scripts\engine\utility::waittill_any("bro_shot_start", "game_ended");

  if(isDefined(self)) {
    self notify("death");
  }
}

nukecratethink(var_0) {
  self endon("restarting_physics");
  self endon("death");
  cratesetupforuse(&"PLATFORM_CALL_NUKE", scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype));
  thread nukecapturethink();

  for(;;) {
    self waittill("captured", var_1);
    var_1 thread scripts\mp\killstreaks\killstreaks::func_729F(self.cratetype);
    level notify("nukeCaptured", var_1);

    if(isDefined(level.gtnw) && level.gtnw) {
      var_1.capturednuke = 1;
    }

    var_1 playlocalsound("ammo_crate_use");
    deletecrateold();
  }
}

juggernautcratethink(var_0) {
  self endon("restarting_physics");
  self endon("death");
  cratesetupforuse(game["strings"][self.cratetype + "_hint"], scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype));
  thread crateothercapturethink();
  thread crateownercapturethink();

  for(;;) {
    self waittill("captured", var_1);

    if(isDefined(self.owner) && var_1 != self.owner) {
      if(!level.teambased || var_1.team != self.team) {
        if(self.cratetype == "airdrop_juggernaut_maniac") {
          var_1 thread hijacknotify(self, "maniac");
        } else if(scripts\mp\utility\game::isstrstart(self.cratetype, "juggernaut_")) {
          var_1 thread hijacknotify(self, self.cratetype);
        } else {
          var_1 thread hijacknotify(self, "juggernaut");
        }
      } else if(self.cratetype == "airdrop_juggernaut_maniac")
        self.owner scripts\mp\hud_message::showsplash("giveaway_juggernaut_maniac", undefined, var_1);
      else if(scripts\mp\utility\game::isstrstart(self.cratetype, "juggernaut_")) {
        self.owner scripts\mp\hud_message::showsplash("giveaway_" + self.cratetype, undefined, var_1);
      } else {
        self.owner scripts\mp\hud_message::showsplash("giveaway_juggernaut", undefined, var_1);
      }
    }

    var_1 playlocalsound("ammo_crate_use");
    var_2 = "juggernaut";

    switch (self.cratetype) {
      case "airdrop_juggernaut":
        var_2 = "juggernaut";
        break;
      case "airdrop_juggernaut_recon":
        var_2 = "juggernaut_recon";
        break;
      case "airdrop_juggernaut_maniac":
        var_2 = "juggernaut_maniac";
        break;
      default:
        if(scripts\mp\utility\game::isstrstart(self.cratetype, "juggernaut_")) {
          var_2 = self.cratetype;
        }

        break;
    }

    var_1 thread scripts\mp\killstreaks\juggernaut::givejuggernaut(var_2);
    deletecrateold();
  }
}

sentrycratethink(var_0) {
  self endon("death");
  cratesetupforuse(game["strings"]["sentry_hint"], scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype));
  thread crateothercapturethink();
  thread crateownercapturethink();

  for(;;) {
    self waittill("captured", var_1);

    if(isDefined(self.owner) && var_1 != self.owner) {
      if(!level.teambased || var_1.team != self.team) {
        if(issubstr(var_0, "airdrop_sentry")) {
          var_1 thread hijacknotify(self, "sentry");
        } else {
          var_1 thread hijacknotify(self, "emergency_airdrop");
        }
      } else {
        self.owner thread scripts\mp\utility\game::giveunifiedpoints("killstreak_giveaway", undefined, int(scripts\mp\killstreaks\killstreaks::getstreakcost("sentry") / 10) * 50);
        self.owner scripts\mp\hud_message::showsplash("giveaway_sentry", undefined, var_1);
      }
    }

    var_1 playlocalsound("ammo_crate_use");
    var_1 thread sentryusetracker();
    deletecrateold();
  }
}

deletecrateold() {
  self notify("crate_deleting");

  if(isDefined(self.usedby)) {
    foreach(var_1 in self.usedby) {
      var_1 setclientomnvar("ui_securing", 0);
      var_1.ui_securing = undefined;
    }
  }

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.minimapid);
  }

  if(isDefined(self.bomb) && isDefined(self.bomb.killcament)) {
    self.bomb.killcament delete();
  }

  if(isDefined(self.bomb)) {
    self.bomb delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.droptype)) {
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(self.var_BE6F)) {
    self notify("nav_obstacle_destroyed");
    _destroynavobstacle(self.var_BE6F);
    self.var_BE6F = undefined;
  }

  self delete();
}

sentryusetracker() {
  if(!scripts\mp\killstreaks\autosentry::givesentry("sentry_minigun", 0, 0)) {
    scripts\mp\killstreaks\killstreaks::givekillstreak("sentry");
  }
}

hijacknotify(var_0, var_1) {
  self notify("hijacker", var_1, var_0.owner);
}

refillammo(var_0) {
  var_1 = self getweaponslistall();

  if(var_0) {}

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "grenade") || getsubstr(var_3, 0, 2) == "gl") {
      if(!var_0 || self getammocount(var_3) >= 1) {
        continue;
      }
    }

    self givemaxammo(var_3);
  }
}

useholdthink(var_0, var_1, var_2, var_3) {
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\engine\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(var_3)) {
    var_3 updatecraftingomnvars();
  }

  if(isDefined(var_1)) {
    self.usetime = var_1;
  } else {
    self.usetime = 3000;
  }

  var_4 = useholdthinkloop(var_0);

  if(isalive(var_0)) {
    var_0 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(var_0)) {
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;

  if(isDefined(var_3)) {
    var_3 updatecraftingomnvars();
  }

  return var_4;
}

useholdthinkloop(var_0) {
  while(var_0 scripts\mp\killstreaks\deployablebox::isplayerusingbox(self)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return 0;
    }

    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility\game::isreallyalive(var_0);
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  return 0;
}

createuseent() {
  var_0 = spawn("script_origin", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0.id = self.id;
  var_0 linkto(self);
  var_0 thread deleteuseent(self);
  return var_0;
}

deleteuseent(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self.usedby)) {
    foreach(var_2 in self.usedby) {
      var_2 setclientomnvar("ui_securing", 0);
      var_2.ui_securing = undefined;
    }
  }

  self delete();
}

airdropdetonateonstuck() {
  self endon("death");
  self waittill("missile_stuck");
  self detonate();
}

throw_linked_care_packages(var_0, var_1, var_2, var_3) {
  if(isDefined(level.carepackages)) {
    foreach(var_5 in level.carepackages) {
      if(isDefined(var_5.inuse) && var_5.inuse) {
        continue;
      }
      var_6 = var_5 getlinkedparent();

      if(isDefined(var_6) && var_6 == var_0) {
        thread spawn_new_care_package(var_5, var_1, var_2);

        if(isDefined(var_3)) {
          scripts\engine\utility::delaythread(1.0, ::remove_care_packages_in_volume, var_3);
        }
      }
    }
  }
}

spawn_new_care_package(var_0, var_1, var_2) {
  var_3 = var_0.owner;
  var_4 = var_0.droptype;
  var_5 = var_0.cratetype;
  var_6 = var_0.origin;
  var_0 deletecrateold();
  var_7 = var_3 createairdropcrate(var_3, var_4, var_5, var_6 + var_1, var_6 + var_1);
  var_7.droppingtoground = 1;
  var_7 thread[[level.cratetypes[var_7.droptype][var_7.cratetype].func]](var_7.droptype);
  scripts\engine\utility::waitframe();
  var_7 physicslaunchserver(var_7.origin, var_2);

  if(isbot(var_7.owner)) {
    wait 0.1;
    var_7.owner notify("new_crate_to_take");
  }
}

remove_care_packages_in_volume(var_0) {
  if(isDefined(level.carepackages)) {
    foreach(var_2 in level.carepackages) {
      if(isDefined(var_2) && isDefined(var_2.friendlymodel) && var_2.friendlymodel istouching(var_0)) {
        var_2 deletecrateold();
      }
    }
  }
}

get_dummy_crate_model() {
  return "care_package_iw7_dummy";
}

get_enemy_crate_model() {
  return "care_package_iw7_ca_wm";
}

get_friendly_crate_model() {
  return "care_package_iw7_un_wm";
}

dropzoneaddcratetypes() {
  addcratetype("dronedrop_grnd", "jackal", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "thor", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "directional_uav", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "remote_c8", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "minijackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", &"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  generatemaxweightedcratevalue();
}