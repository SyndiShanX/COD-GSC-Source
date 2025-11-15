/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3461.gsc
***************************************/

init() {
  level._effect["airdrop_crate_destroy"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_dp_pickup_dust.vfx");
  level._effect["airdrop_dust_kickup"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_dp_pickup_dust.vfx");
  level._effect["drone_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_dp_exp.vfx");
  level._effect["crate_explode"] = loadfx("vfx\iw7\_requests\mp\killstreak\vfx_drone_pkg_exp_vari.vfx");
  precachempanim("juggernaut_carepackage");
  setairdropcratecollision("airdrop_crate");
  setairdropcratecollision("care_package");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("dronedrop", ::func_1AA2, undefined, undefined, ::tryuseairdrop, undefined, ::func_1A9F);
  var_00 = ["passive_bomb_trap", "passive_decreased_cost", "passive_increased_cost", "passive_reroll", "passive_high_roller", "passive_low_roller"];
  scripts\mp\killstreak_loot::func_DF07("dronedrop", var_00);
  level.numdropcrates = 0;
  level.littlebirds = [];
  level.cratetypes = [];
  level.cratemaxval = [];
  addcratetype("dronedrop", "venom", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_VENOM_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "uav", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "counter_uav", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "drone_hive", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "ball_drone_backup", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "bombardment", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "precision_airstrike", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "sentry_shock", 45, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "jackal", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "thor", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "directional_uav", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "remote_c8", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop", "minijackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "venom", 35, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_VENOM_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "uav", 30, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "counter_uav", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "drone_hive", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "ball_drone_backup", 25, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "bombardment", 20, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "precision_airstrike", 20, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "sentry_shock", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_trap", "bomb_trap", 100, ::killstreakbombcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "venom", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_VENOM_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "uav", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_UAV_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "counter_uav", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_COUNTER_UAV_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "drone_hive", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "ball_drone_backup", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "bombardment", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_BOMBARDMENT_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "precision_airstrike", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "sentry_shock", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_SENTRY_SHOCK_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "jackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_JACKAL_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "thor", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_THOR_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "directional_uav", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_DIRECTIONAL_UAV_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "remote_c8", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_RC8_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_reroll", "minijackal", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", undefined, & "KILLSTREAKS_HINTS_MINI_JACKAL_REROLL", "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "sentry_shock", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "jackal", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "thor", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "directional_uav", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "remote_c8", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_highroll", "minijackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "venom", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_VENOM_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "uav", 85, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "counter_uav", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "drone_hive", 70, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "ball_drone_backup", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "bombardment", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "precision_airstrike", 65, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "sentry_shock", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "jackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "thor", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "directional_uav", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "remote_c8", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("jackaldrop", "minijackal", 1, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");

  if(isDefined(level.customcratefunc))
    [[level.customcratefunc]]("care_package_iw7_un_wm", "care_package_iw7_ca_wm");

  if(isDefined(level.mapcustomcratefunc))
    [[level.mapcustomcratefunc]]();

  generatemaxweightedcratevalue();
  var_01 = spawnStruct();
  var_1.scorepopup = "destroyed_airdrop";
  var_1.vodestroyed = "dronedrop_destroyed";
  var_1.callout = "callout_destroyed_airdrop";
  var_1.samdamagescale = 0.09;
  level.heliconfigs["airdrop"] = var_01;
  scripts\mp\rank::registerscoreinfo("little_bird", "value", 200);
  level setupcaptureflares();
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
}

generatemaxweightedcratevalue() {
  foreach(var_06, var_01 in level.cratetypes) {
    level.cratemaxval[var_06] = 0;

    foreach(var_03 in var_01) {
      var_04 = var_3.type;

      if(!level.cratetypes[var_06][var_04].raw_weight) {
        level.cratetypes[var_06][var_04].weight = level.cratetypes[var_06][var_04].raw_weight;
        continue;
      }

      level.cratemaxval[var_06] = level.cratemaxval[var_06] + level.cratetypes[var_06][var_04].raw_weight;
      level.cratetypes[var_06][var_04].weight = level.cratemaxval[var_06];
    }
  }
}

changecrateweight(var_00, var_01, var_02) {
  if(!isDefined(level.cratetypes[var_00]) || !isDefined(level.cratetypes[var_00][var_01])) {
    return;
  }
  level.cratetypes[var_00][var_01].raw_weight = var_02;
  generatemaxweightedcratevalue();
}

setairdropcratecollision(var_00) {
  var_01 = getEntArray(var_00, "targetname");

  if(!isDefined(var_01) || var_1.size == 0) {
    return;
  }
  level.airdropcratecollision = getent(var_1[0].target, "targetname");

  foreach(var_03 in var_01)
  var_03 deletecrateold();
}

addcratetype(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(var_04))
    var_04 = "care_package_iw7_un_wm";

  if(!isDefined(var_05))
    var_05 = "care_package_iw7_ca_wm";

  if(!isDefined(var_08))
    var_08 = "care_package_iw7_dummy";

  level.cratetypes[var_00][var_01] = spawnStruct();
  level.cratetypes[var_00][var_01].droptype = var_00;
  level.cratetypes[var_00][var_01].type = var_01;
  level.cratetypes[var_00][var_01].raw_weight = var_02;
  level.cratetypes[var_00][var_01].weight = var_02;
  level.cratetypes[var_00][var_01].func = var_03;
  level.cratetypes[var_00][var_01].model_name_friendly = var_04;
  level.cratetypes[var_00][var_01].model_name_enemy = var_05;
  level.cratetypes[var_00][var_01].model_name_dummy = var_08;

  if(isDefined(var_06))
    game["strings"][var_01 + "_hint"] = var_06;

  if(isDefined(var_07))
    game["strings"][var_01 + "_rerollHint"] = var_07;
}

getrandomcratetype(var_00) {
  var_01 = randomint(level.cratemaxval[var_00]);
  var_02 = undefined;

  foreach(var_04 in level.cratetypes[var_00]) {
    var_05 = var_4.type;

    if(!level.cratetypes[var_00][var_05].weight) {
      continue;
    }
    var_02 = var_05;

    if(level.cratetypes[var_00][var_05].weight > var_01) {
      break;
    }
  }

  return var_02;
}

getcratetypefordroptype(var_00) {
  switch (var_00) {
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
      if(isDefined(level.getrandomcratetypeforgamemode))
        return [
          [level.getrandomcratetypeforgamemode]
        ](var_00);

      return getrandomcratetype(var_00);
  }
}

tryuseairdrop(var_00) {
  var_01 = var_0.streakname;
  var_02 = var_01;
  var_03 = undefined;

  if(!isDefined(var_02))
    var_02 = "airdrop";

  var_04 = 1;

  if((level.littlebirds.size >= 4 || level.fauxvehiclecount >= 4) && var_02 != "airdrop_mega" && !issubstr(tolower(var_02), "juggernaut")) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_04 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  } else if(var_02 == "airdrop_lase" && isDefined(level.lasedstrikecrateactive) && level.lasedstrikecrateactive) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  return 1;
}

func_1AA2(var_00) {
  var_0.func_1AA0 = var_0.streakname;
  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_01 = scripts\mp\killstreaks\target_marker::_meth_819B(var_00);

  if(!isDefined(var_1.location)) {
    scripts\mp\utility\game::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(var_0.func_1AA0, self.origin);
  func_1AA1(var_01, var_0.func_1AA0, var_00);
  return 1;
}

func_1AA1(var_00, var_01, var_02) {
  switch (var_01) {
    case "dronedrop":
      level func_581F(self, var_00, randomfloat(360), var_01, var_02);
      break;
  }
}

func_1A9E(var_00, var_01) {
  var_01 thread airdropdetonateonstuck();
  var_1.owner = self;
  var_0.func_1AA0 = var_0.streakname;
  scripts\mp\utility\game::incrementfauxvehiclecount();
  thread func_4FC3();
  var_01 thread airdropmarkeractivate(var_0.func_1AA0);
  scripts\mp\matchdata::logkillstreakevent(var_0.func_1AA0, self.origin);
  var_0.func_1A9E = 1;
  return 1;
}

airdropmarkeractivate(var_00, var_01) {
  level endon("game_ended");
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  self waittill("explode", var_02);
  var_03 = self.owner;

  if(!isDefined(var_03)) {
    return;
  }
  if(var_03 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  if(issubstr(tolower(var_00), "escort_airdrop") && isDefined(level.chopper)) {
    return;
  }
  wait 0.05;

  if(issubstr(tolower(var_00), "juggernaut"))
    level doc130flyby(var_03, var_02, randomfloat(360), var_00);
  else if(issubstr(tolower(var_00), "escort_airdrop"))
    var_03 scripts\mp\killstreaks\escort_airdrop::func_6CE4(var_01, var_02, randomfloat(360), "escort_airdrop");
  else if(var_00 == "dronedrop")
    level func_581F(var_03, var_02, randomfloat(360), var_00);
  else
    level doflyby(var_03, var_02, randomfloat(360), var_00);
}

func_1A9F(var_00) {
  if(isDefined(var_0.func_1AA0) && !issubstr(var_0.func_1AA0, "juggernaut") && !scripts\mp\utility\game::istrue(var_0.func_1A9E))
    scripts\mp\utility\game::decrementfauxvehiclecount();
}

func_4FC3() {
  self endon("airDropMarkerActivate");
  self waittill("death");
  scripts\mp\utility\game::decrementfauxvehiclecount();
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

deleteonownerdeath(var_00) {
  wait 0.25;
  self linkto(var_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_00 waittill("death");
  self delete();
}

crateteammodelupdater() {
  self endon("death");
  self hide();

  foreach(var_01 in level.players) {
    if(var_1.team != "spectator")
      self giveperkequipment(var_01);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_01 in level.players) {
      if(var_1.team != "spectator")
        self giveperkequipment(var_01);
    }
  }
}

cratemodelteamupdater(var_00) {
  self endon("death");
  self hide();

  foreach(var_02 in level.players) {
    if(var_2.team == "spectator") {
      if(var_00 == "allies")
        self giveperkequipment(var_02);

      continue;
    }

    if(var_2.team == var_00)
      self giveperkequipment(var_02);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_02 in level.players) {
      if(var_2.team == "spectator") {
        if(var_00 == "allies")
          self giveperkequipment(var_02);

        continue;
      }

      if(var_2.team == var_00)
        self giveperkequipment(var_02);
    }
  }
}

cratemodelenemyteamsupdater(var_00) {
  self endon("death");
  self hide();

  foreach(var_02 in level.players) {
    if(var_2.team != var_00)
      self giveperkequipment(var_02);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_02 in level.players) {
      if(var_2.team != var_00)
        self giveperkequipment(var_02);
    }
  }
}

cratemodelplayerupdater(var_00, var_01) {
  self endon("death");
  self hide();

  foreach(var_03 in level.players) {
    if(var_01 && isDefined(var_00) && var_03 != var_00) {
      continue;
    }
    if(!var_01 && isDefined(var_00) && var_03 == var_00) {
      continue;
    }
    self giveperkequipment(var_03);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_03 in level.players) {
      if(var_01 && isDefined(var_00) && var_03 != var_00) {
        continue;
      }
      if(!var_01 && isDefined(var_00) && var_03 == var_00) {
        continue;
      }
      self giveperkequipment(var_03);
    }
  }
}

crateuseteamupdater(var_00) {
  self endon("death");

  for(;;) {
    setusablebyteam(var_00);
    level waittill("joined_team");
  }
}

crateuseteamupdater_multiteams(var_00) {
  self endon("death");

  for(;;) {
    setusablebyotherteams(var_00);
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
    level waittill("juggernaut_equipped", var_00);
    self disableplayeruse(var_00);
    thread crateusepostjuggernautupdater(var_00);
  }
}

crateusepostjuggernautupdater(var_00) {
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 waittill("death");
  self enableplayeruse(var_00);
}

createairdropcrate(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawn("script_model", var_03);
  var_6.curprogress = 0;
  var_6.usetime = 0;
  var_6.userate = 0;
  var_6.team = self.team;
  var_6.destination = var_04;
  var_6.id = "care_package";
  var_06 give_player_tickets(1);

  if(isDefined(var_00)) {
    var_6.owner = var_00;
    var_06 setotherent(var_00);
  } else
    var_6.owner = undefined;

  var_6.cratetype = var_02;
  var_6.droptype = var_01;
  var_6.targetname = "care_package";
  var_06 _meth_85C8(1);
  var_07 = "care_package_iw7_dummy";

  if(isDefined(level.custom_dummy_crate_model))
    var_07 = level.custom_dummy_crate_model;

  var_06 setModel(var_07);

  if(var_02 == "airdrop_jackpot") {
    var_6.friendlymodel = spawn("script_model", var_03);
    var_6.friendlymodel setModel(level.cratetypes[var_01][var_02].model_name_friendly);
    var_6.friendlymodel thread deleteonownerdeath(var_06);
  } else {
    var_6.friendlymodel = spawn("script_model", var_03);
    var_6.friendlymodel setModel(level.cratetypes[var_01][var_02].model_name_friendly);

    if(isDefined(level.highlightairdrop) && level.highlightairdrop) {
      if(!isDefined(var_05))
        var_05 = 2;

      var_6.friendlymodel hudoutlineenable(var_05, 0, 0);
      var_6.outlinecolor = var_05;
    }

    var_6.enemymodel = spawn("script_model", var_03);
    var_6.enemymodel setModel(level.cratetypes[var_01][var_02].model_name_enemy);
    var_6.friendlymodel setentityowner(var_06);
    var_6.enemymodel setentityowner(var_06);
    var_6.friendlymodel thread deleteonownerdeath(var_06);

    if(level.teambased)
      var_6.friendlymodel thread cratemodelteamupdater(var_6.team);
    else
      var_6.friendlymodel thread cratemodelplayerupdater(var_00, 1);

    var_6.enemymodel thread deleteonownerdeath(var_06);

    if(level.multiteambased)
      var_6.enemymodel thread cratemodelenemyteamsupdater(var_6.team);
    else if(level.teambased)
      var_6.enemymodel thread cratemodelteamupdater(level.otherteam[var_6.team]);
    else
      var_6.enemymodel thread cratemodelplayerupdater(var_00, 0);
  }

  var_6.inuse = 0;
  var_6.killcament = spawn("script_model", var_6.origin + (0, 0, 300), 0, 1);
  var_6.killcament setscriptmoverkillcam("explosive");
  var_6.killcament linkto(var_06);
  level.numdropcrates++;
  var_06 thread dropcrateexistence(var_04);
  level notify("createAirDropCrate", var_06);
  return var_06;
}

dropcrateexistence(var_00) {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(level.cratekill))
    [[level.cratekill]](var_00);

  level.numdropcrates--;
}

cratesetupforuse(var_00, var_01, var_02, var_03) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(var_00);
  self _meth_84A7("none");
  self makeusable();

  if(isDefined(var_03))
    self setusepriority(var_03);

  if(scripts\mp\utility\game::istrue(var_02)) {
    thread watchcratereroll(self.owner);
    thread watchcratererollcommand(self.owner);
    thread fakererollcratesetupforuse(self.owner, var_03);
  }

  var_04 = "icon_minimap_drone_package_friendly";

  if(isDefined(level.objvisall))
    var_05 = "icon_minimap_drone_package_friendly";

  if(!isDefined(self.minimapid))
    self.minimapid = createobjective(var_04, undefined, 1, 1, 0);

  thread crateuseteamupdater();
  thread crateusejuggernautupdater();

  if(issubstr(self.cratetype, "juggernaut")) {
    foreach(var_07 in level.players) {
      if(var_07 scripts\mp\utility\game::isjuggernaut())
        thread crateusepostjuggernautupdater(var_07);
    }
  }

  var_09 = undefined;

  if(level.teambased)
    var_09 = scripts\mp\entityheadicons::setheadicon(self.team, var_01, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
  else if(isDefined(self.owner))
    var_09 = scripts\mp\entityheadicons::setheadicon(self.owner, var_01, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);

  if(isDefined(var_09))
    var_9.showinkillcam = 0;

  if(isDefined(level.iconvisall))
    [[level.iconvisall]](self, var_01);
  else {
    foreach(var_07 in level.players) {
      if(var_7.team == "spectator")
        var_09 = scripts\mp\entityheadicons::setheadicon(var_07, var_01, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
    }
  }
}

fakererollcratesetupforuse(var_00, var_01) {
  var_02 = & "PLATFORM_GET_KILLSTREAK";

  if(isDefined(game["strings"][self.cratetype + "_hint"]))
    var_02 = game["strings"][self.cratetype + "_hint"];

  var_03 = 128;
  var_04 = 360;
  var_05 = 128;
  var_06 = 360;
  var_07 = -10000;

  if(isDefined(var_01))
    var_07 = var_01;

  var_08 = spawn("script_model", self.origin);
  var_8.curprogress = 0;
  var_8.usetime = 0;
  var_8.userate = 3000;
  var_8.inuse = 0;
  var_8.id = self.id;
  var_08 linkto(self);
  var_08 makeusable();
  var_08 disableplayeruse(var_00);
  var_08 setcursorhint("HINT_NOICON");
  var_08 _meth_84A9("show");
  var_08 sethintstring(var_02);
  var_08 _meth_84A6(var_04);
  var_08 setusefov(var_06);
  var_08 _meth_84A4(var_03);
  var_08 setuserange(var_05);
  var_08 setusepriority(var_07);
  var_08 thread deleteuseent(self);
  self.fakeuseobj = var_08;
}

watchcratereroll(var_00) {
  self endon("death");
  var_00 endon("disconnect");
  self waittill("crate_reroll");
  var_00 playlocalsound("mp_killconfirm_tags_drop");
  var_01 = level.cratetypes[self.droptype][self.cratetype].raw_weight;
  changecrateweight(self.droptype, self.cratetype, 0);
  var_02 = getcratetypefordroptype(self.droptype);
  changecrateweight(self.droptype, self.cratetype, var_01);
  self.cratetype = var_02;
  var_03 = & "PLATFORM_GET_KILLSTREAK";

  if(isDefined(game["strings"][self.cratetype + "_hint"]))
    var_03 = game["strings"][self.cratetype + "_hint"];

  self sethintstring(var_03);

  if(isDefined(self.fakeuseobj))
    self.fakeuseobj sethintstring(var_03);

  var_04 = scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype);
  var_05 = undefined;

  if(level.teambased)
    var_05 = scripts\mp\entityheadicons::setheadicon(self.team, var_04, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
  else if(isDefined(self.owner))
    var_05 = scripts\mp\entityheadicons::setheadicon(self.owner, var_04, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);

  if(isDefined(var_05))
    var_5.showinkillcam = 0;

  if(isDefined(level.iconvisall))
    [[level.iconvisall]](self, var_04);
  else {
    foreach(var_07 in level.players) {
      if(var_7.team == "spectator")
        var_05 = scripts\mp\entityheadicons::setheadicon(var_07, var_04, (0, 0, 24), 14, 14, 0, undefined, undefined, undefined, undefined, 0);
    }
  }
}

watchcratererollcommand(var_00) {
  self endon("death");
  var_00 endon("disconnect");
  var_01 = 0;
  var_02 = 16384;

  for(;;) {
    if(var_00 usebuttonpressed()) {
      var_01 = 0;

      while(var_00 usebuttonpressed()) {
        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      if(var_01 >= 0.5) {
        continue;
      }
      var_01 = 0;

      while(!var_00 usebuttonpressed() && var_01 < 0.5) {
        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      if(var_01 >= 0.5) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_00)) {
        continue;
      }
      if(distance2dsquared(var_0.origin, self.origin) > var_02) {
        continue;
      }
      self notify("crate_reroll");
    }

    wait 0.05;
  }
}

createobjective(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_05 == -1)
    return -1;

  scripts\mp\objidpoolmanager::minimap_objective_add(var_05, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !scripts\mp\utility\game::istrue(var_03))
    scripts\mp\objidpoolmanager::minimap_objective_position(var_05, self.origin);
  else if(scripts\mp\utility\game::istrue(var_03) && scripts\mp\utility\game::istrue(var_04))
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_05, self);
  else
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_05, self);

  scripts\mp\objidpoolmanager::minimap_objective_state(var_05, "active");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_05, var_00);

  if(isDefined(var_01)) {
    if(!level.teambased && isDefined(self.owner)) {
      if(scripts\mp\utility\game::istrue(var_02))
        scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_05, self.owner getentitynumber());
      else
        scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_05, self.owner getentitynumber());
    } else
      scripts\mp\objidpoolmanager::minimap_objective_team(var_05, var_01);
  } else
    scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(var_05);

  if(isDefined(level.objvisall))
    [[level.objvisall]](var_05);

  return var_05;
}

createobjective_engineer(var_00, var_01, var_02) {
  var_03 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_03 == -1)
    return -1;

  scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !scripts\mp\utility\game::istrue(var_01))
    scripts\mp\objidpoolmanager::minimap_objective_position(var_03, self.origin);
  else if(scripts\mp\utility\game::istrue(var_01) && scripts\mp\utility\game::istrue(var_02))
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03, self);
  else
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_03, self);

  scripts\mp\objidpoolmanager::minimap_objective_state(var_03, "active");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_03, var_00);
  scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(var_03);
  return var_03;
}

setusablebyteam(var_00) {
  foreach(var_02 in level.players) {
    if(issubstr(self.cratetype, "juggernaut") && var_02 scripts\mp\utility\game::isjuggernaut()) {
      self disableplayeruse(var_02);
      continue;
    }

    if(issubstr(self.cratetype, "lased") && isDefined(var_2.hassoflam) && var_2.hassoflam) {
      self disableplayeruse(var_02);
      continue;
    }

    if(issubstr(self.cratetype, "trap") && scripts\mp\utility\game::istrue(level.teambased) && var_2.team == self.owner.team) {
      self disableplayeruse(var_02);
      continue;
    }

    if(issubstr(self.cratetype, "trap") && !scripts\mp\utility\game::istrue(level.teambased) && var_02 == self.owner) {
      self disableplayeruse(var_02);
      continue;
    }

    if(issubstr(self.droptype, "reroll") && var_02 != self.owner) {
      self disableplayeruse(var_02);
      continue;
    }

    if(!isDefined(var_00) || var_00 == var_2.team) {
      self enableplayeruse(var_02);
      continue;
    }

    self disableplayeruse(var_02);
  }
}

setusablebyotherteams(var_00) {
  foreach(var_02 in level.players) {
    if(issubstr(self.cratetype, "juggernaut") && var_02 scripts\mp\utility\game::isjuggernaut()) {
      self disableplayeruse(var_02);
      continue;
    }

    if(!isDefined(var_00) || var_00 != var_2.team) {
      self enableplayeruse(var_02);
      continue;
    }

    self disableplayeruse(var_02);
  }
}

dropthecrate(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = [];
  self.owner endon("disconnect");

  if(!isDefined(var_04)) {
    if(isDefined(var_07)) {
      var_10 = undefined;
      var_11 = undefined;

      for(var_12 = 0; var_12 < 100; var_12++) {
        var_11 = getcratetypefordroptype(var_01);
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

      if(var_10 == 1)
        var_11 = getcratetypefordroptype(var_01);
    } else
      var_11 = getcratetypefordroptype(var_01);
  } else
    var_11 = var_04;

  var_06 = (0, 0, 0);

  if(!isDefined(var_06))
    var_06 = (randomint(5), randomint(5), randomint(5));

  var_09 = createairdropcrate(self.owner, var_01, var_11, var_05, var_00);

  switch (var_01) {
    case "nuke_drop":
    case "airdrop_mega":
    case "airdrop_juggernaut_maniac":
    case "airdrop_juggernaut_recon":
    case "airdrop_juggernaut":
      var_09 linkto(self, "tag_ground", (64, 32, -128), (0, 0, 0));
      break;
    case "airdrop_osprey_gunner":
    case "airdrop_escort":
      var_09 linkto(self, var_08, (0, 0, 0), (0, 0, 0));
      break;
    default:
      var_09 linkto(self, "tag_ground", (32, 0, 5), (0, 0, 0));
      break;
  }

  var_9.angles = (0, 0, 0);
  var_09 show();
  var_14 = self.veh_speed;

  if(issubstr(var_11, "juggernaut"))
    var_06 = (0, 0, 0);

  thread waitfordropcratemsg(var_09, var_06, var_01, var_11);
  var_9.droppingtoground = 1;
  return var_11;
}

killplayerfromcrate_dodamage(var_00) {
  if(!scripts\mp\utility\game::istrue(level.noairdropkills))
    var_00 getrandomarmkillstreak(1000, var_0.origin, self, self, "MOD_CRUSH");

  self endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");

  if(scripts\mp\utility\game::isreallyalive(var_00))
    childthread scripts\mp\movers::unresolved_collision_nearest_node(var_00, undefined, self);
}

killplayerfromcrate_fastvelocitypush() {
  self endon("death");

  for(;;) {
    self waittill("player_pushed", var_00, var_01);

    if(isplayer(var_00) || isagent(var_00)) {
      if(var_1[2] < -20)
        killplayerfromcrate_dodamage(var_00);
    }

    wait 0.05;
  }
}

airdrop_override_death_moving_platform(var_00) {
  if(isDefined(var_0.lasttouchedplatform.destroyairdroponcollision) && var_0.lasttouchedplatform.destroyairdroponcollision) {
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);
    deletecrateold();
  }
}

cleanup_crate_capture() {
  var_00 = self getlinkedchildren(1);

  if(!isDefined(var_00)) {
    return;
  }
  foreach(var_02 in var_00) {
    if(!isplayer(var_02)) {
      continue;
    }
    if(isDefined(var_2.iscapturingcrate) && var_2.iscapturingcrate) {
      var_03 = var_02 getlinkedparent();

      if(isDefined(var_03)) {
        var_02 scripts\mp\gameobjects::updateuiprogress(var_03, 0);
        var_02 unlink();
      }

      if(isalive(var_02))
        var_02 scripts\engine\utility::allow_weapon(1);

      var_2.iscapturingcrate = 0;
    }
  }
}

airdrop_override_invalid_moving_platform(var_00) {
  wait 0.05;
  self notify("restarting_physics");
  cleanup_crate_capture();
  self physicslaunchserver((0, 0, 0), var_0.dropimpulse, var_0.airdrop_max_linear_velocity);
  thread physicswaiter(var_0.droptype, var_0.cratetype, var_0.dropimpulse, var_0.airdrop_max_linear_velocity);
}

waitfordropcratemsg(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 endon("death");

  if(!isDefined(var_05) || !var_05)
    self waittill("drop_crate");

  var_06 = 1200;

  if(isDefined(var_04))
    var_06 = var_04;

  var_00 unlink();
  var_00 physicslaunchserver((0, 0, 0), var_01, var_06);
  var_00 thread physicswaiter(var_02, var_03, var_01, var_06);
  var_00 thread killplayerfromcrate_fastvelocitypush();
  var_0.unresolved_collision_func = ::killplayerfromcrate_dodamage;

  if(isDefined(var_0.killcament)) {
    if(isDefined(var_0.carestrike))
      var_07 = -2100;
    else
      var_07 = 0;

    var_0.killcament unlink();
    var_08 = bulletTrace(var_0.origin, var_0.origin + (0, 0, -10000), 0, var_00);
    var_09 = distance(var_0.origin, var_8["position"]);
    var_10 = var_09 / 800;
    var_0.killcament moveto(var_8["position"] + (0, 0, 300) + (var_07, 0, 0), var_10);
  }
}

waitandanimate() {
  self endon("death");
  wait 0.035;
  playFX(level._effect["airdrop_dust_kickup"], self.origin + (0, 0, 5), (0, 0, 1));
  self.friendlymodel scriptmodelplayanim("juggernaut_carepackage");
  self.enemymodel scriptmodelplayanim("juggernaut_carepackage");
}

physicswaiter(var_00, var_01, var_02, var_03, var_04) {
  if(scripts\mp\utility\game::istrue(var_04))
    self endon("death");

  self endon("restarting_physics");
  func_136A7();
  self.droppingtoground = 0;
  self thread[[level.cratetypes[var_00][var_01].func]](var_00);
  level thread droptimeout(self, self.owner, var_01);
  var_05 = spawnStruct();
  var_5.endonstring = "restarting_physics";
  var_5.deathoverridecallback = ::airdrop_override_death_moving_platform;
  var_5.invalidparentoverridecallback = ::airdrop_override_invalid_moving_platform;
  var_5.droptype = var_00;
  var_5.cratetype = var_01;
  var_5.dropimpulse = var_02;
  var_5.airdrop_max_linear_velocity = var_03;
  thread scripts\mp\movers::handle_moving_platforms(var_05);

  if(self.friendlymodel scripts\mp\utility\game::touchingbadtrigger()) {
    deletecrateold();
    return;
  }

  if(isDefined(self.owner) && abs(self.origin[2] - self.owner.origin[2]) > 3000)
    deletecrateold();
}

func_136A7() {
  wait 0.5;

  for(;;) {
    var_00 = self physics_getbodyid(0);
    var_01 = physics_getbodylinvel(var_00);

    if(lengthsquared(var_01) > 0.5) {
      wait 0.1;
      continue;
    }

    break;
  }
}

droptimeout(var_00, var_01, var_02) {
  if(isDefined(level.nod_gesture) && level.nod_gesture) {
    return;
  }
  level endon("game_ended");
  var_00 endon("death");

  if(var_0.droptype == "nuke_drop") {
    return;
  }
  var_03 = 90.0;

  if(var_02 == "supply")
    var_03 = 20.0;
  else if(var_02 == "bomb_trap")
    var_03 = 60.0;

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_03);

  while(var_0.curprogress != 0)
    wait 1;

  var_00 deletecrateold();
}

getpathstart(var_00, var_01) {
  var_02 = 100;
  var_03 = 15000;
  var_04 = (0, var_01, 0);
  var_05 = var_00 + anglesToForward(var_04) * (-1 * var_03);
  var_05 = var_05 + ((randomfloat(2) - 1) * var_02, (randomfloat(2) - 1) * var_02, 0);
  return var_05;
}

getpathend(var_00, var_01) {
  var_02 = 150;
  var_03 = 15000;
  var_04 = (0, var_01, 0);
  var_05 = var_00 + anglesToForward(var_04 + (0, 90, 0)) * var_03;
  var_05 = var_05 + ((randomfloat(2) - 1) * var_02, (randomfloat(2) - 1) * var_02, 0);
  return var_05;
}

getflyheightoffset(var_00) {
  var_01 = 850;
  var_02 = getent("airstrikeheight", "targetname");

  if(!isDefined(var_02)) {
    if(isDefined(level.airstrikeheightscale)) {
      if(level.airstrikeheightscale > 2) {
        var_01 = 1500;
        return var_01 * level.airstrikeheightscale;
      }

      return var_01 * level.airstrikeheightscale + 256 + var_0[2];
    } else
      return var_01 + var_0[2];
  } else
    return var_2.origin[2];
}

func_581F(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00)) {
    return;
  }
  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed()) {
    return;
  }
  if(var_03 == "dronedrop_grnd")
    var_05 = var_1.droporigin;
  else
    var_05 = var_1.location;

  var_06 = getflyheightoffset(var_05);
  var_07 = var_05 * (1, 1, 0) + (0, 0, var_06);
  var_08 = getpathstart(var_07, var_02);
  var_09 = getpathend(var_07, var_02);
  var_07 = var_07 + anglesToForward((0, var_02, 0)) * -50;
  var_10 = func_5CC7(var_00, var_08, var_07, var_03, var_01, var_04);
  var_11 = undefined;
  var_12 = 999999;
  var_13 = scripts\engine\trace::ray_trace(var_05, var_05 + (0, 0, 10000), level.characters, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  var_14 = undefined;
  var_15 = 0;

  if(var_13["hittype"] == "hittype_none") {
    var_14 = var_05 * (1, 1, 0) + (0, 0, var_06);
    var_15 = 1;
  } else {
    if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
      foreach(var_17 in level.carepackagedropnodes) {
        var_18 = distance(var_17.origin, var_05);

        if(var_18 < var_12) {
          var_11 = var_17;
          var_12 = var_18;
        }
      }
    } else {}

    var_14 = var_11.origin * (1, 1, 0) + (0, 0, var_06);
  }

  var_20 = "";
  var_21 = "used_dronedrop";

  if(isDefined(var_04)) {
    var_20 = scripts\mp\killstreak_loot::getrarityforlootitem(var_4.variantid);
    var_21 = "used_" + var_4.streakname;
  }

  if(var_20 != "" && var_20 != "rare")
    var_21 = var_21 + "_" + var_20;

  if(level.gametype != "grnd")
    level thread scripts\mp\utility\game::teamplayercardsplash(var_21, var_00);

  var_10 setvehgoalpos(var_14, 1);
  var_10 setscriptablepartstate("lights", "idle");
  var_10 setscriptablepartstate("thrusters", "fly", 0);
  var_10 thread func_13A04(var_14, var_05, var_15);
}

func_5CC7(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = vectortoangles(var_02 - var_01);
  var_07 = "veh_mil_air_un_delivery_drone";
  var_08 = "";

  if(isDefined(var_05))
    var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(var_5.variantid);

  if(var_08 != "")
    var_07 = var_07 + "_" + var_08;

  if(isDefined(var_05)) {
    if(scripts\mp\killstreaks\utility::func_A69F(var_05, "passive_bomb_trap"))
      var_03 = "dronedrop_trap";

    if(scripts\mp\killstreaks\utility::func_A69F(var_05, "passive_reroll"))
      var_03 = "dronedrop_reroll";

    if(scripts\mp\killstreaks\utility::func_A69F(var_05, "passive_high_roller"))
      var_03 = "dronedrop_highroll";
  }

  var_09 = spawnhelicopter(var_00, var_01, var_06, "delivery_drone_mp", var_07);

  if(!isDefined(var_09)) {
    return;
  }
  var_9.maxhealth = 100;
  var_9.owner = var_00;
  var_9.team = var_0.team;
  var_9.isairdrop = 1;
  var_09 setmaxpitchroll(35, 35);
  var_09 vehicle_setspeed(1600, 200, 200);
  var_09 setyawspeed(250, 100);
  var_09 setneargoalnotifydist(1000);
  var_09 sethoverparams(5, 5, 2);
  var_09 setCanDamage(1);
  var_09 setturningability(1.0);
  var_09 _meth_84E1(1);
  var_09 _meth_84E0(1);
  var_9.streakinfo = var_05;
  var_9.helitype = "dronedrop";
  var_09 scripts\mp\killstreaks\utility::func_1843(var_9.helitype, "Killstreak_Air", var_00, 1);
  var_10 = getcratetypefordroptype(var_03);
  var_11 = var_09 createairdropcrate(var_00, var_03, var_10, var_9.origin);
  var_11 linkto(var_09, "tag_origin", (0, 0, 5), (0, 0, 0));
  var_11.streakinfo = var_05;
  var_9.func_5D26 = var_11;
  var_09 thread watchtimeout(60);
  var_09 thread func_13A01(var_11, var_03, var_10, var_04);
  var_09 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("dronedrop", undefined, 1);
  var_09 thread watchempdamage();

  if(var_03 == "dronedrop_trap")
    var_09 thread watchownerdisconnect(var_11, var_04);

  var_09 setscriptablepartstate("dust", "active", 0);
  var_09 thread dronewatchgameover();
  return var_09;
}

func_13A01(var_00, var_01, var_02, var_03) {
  self waittill("death");

  if(!isDefined(var_00)) {
    return;
  }
  var_04 = (0, 0, 0);
  var_05 = 1200;
  var_06 = undefined;

  if(var_01 == "dronedrop_trap")
    var_06 = 1;

  var_00 unlink();
  var_00 physicslaunchserver((0, 0, 0), var_04, var_05);
  var_00 thread physicswaiter(var_01, var_02, var_04, var_05, var_06);
  var_00 thread killplayerfromcrate_fastvelocitypush();
  var_0.unresolved_collision_func = ::killplayerfromcrate_dodamage;

  if(isDefined(var_0.killcament))
    var_0.killcament unlink();

  if(isDefined(var_3.func_1349C))
    var_3.func_1349C delete();

  var_00 thread handlenavobstacle();
  func_5CAC();
  scripts\mp\utility\game::printgameaction("killstreak ended - dronedrop", self.owner);
}

handlenavobstacle() {
  self endon("death");
  self endon("nav_obstacle_destroyed");
  wait 1;
  self.func_BE6F = _createnavobstaclebybounds(self.origin, (30, 10, 64), self.angles);
  var_00 = self.origin;

  while(isDefined(self) && isDefined(self.func_BE6F)) {
    if(distance2dsquared(var_00, self.origin) > 64) {
      _destroynavobstacle(self.func_BE6F);
      self.func_BE6F = _createnavobstaclebybounds(self.origin, (30, 10, 64), self.angles);
      var_00 = self.origin;
    }

    wait 1;
  }
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);

    if(isDefined(var_03) && var_03 == "concussion_grenade_mp") {
      if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_00)))
        var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }

    scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_00, var_00, self.team, var_02, var_04, var_03);
  }
}

watchownerdisconnect(var_00, var_01) {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(var_1.func_1349C))
    var_1.func_1349C delete();

  var_00 deletecrateold();
  func_5CAC();
}

func_5CAC() {
  playFX(scripts\engine\utility::getfx("drone_explode"), self.origin);
  self playSound("sentry_explode");
  scripts\mp\utility\game::decrementfauxvehiclecount();
  self delete();
}

func_13A04(var_00, var_01, var_02) {
  self endon("death");
  self waittill("goal");
  thread watchmantledisable();
  var_03 = (0, 0, -30);
  var_04 = (0, 0, 12);
  self setscriptablepartstate("thrusters", "descend", 0);
  thread watchfailsafe(var_00);
  var_05 = undefined;

  if(!scripts\mp\utility\game::istrue(var_02)) {
    if(_areanynavvolumesloaded()) {
      var_06 = var_01 + (0, 0, 12);
      var_05 = _findpath3d(self.origin, var_06);
    } else {
      var_07 = scripts\engine\trace::create_solid_ai_contents();
      var_08 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 500), self, var_07);
      var_09 = getclosestpointonnavmesh(var_8["position"], self);
      var_05 = self.owner findpath(var_09, var_01);
      self.owner iprintlnbold("3D Nav Volume is not present, using 2D path instead");
    }
  } else
    var_05 = [var_01 + (0, 0, 12)];

  var_10 = 0;
  var_11 = self.origin;

  foreach(var_16, var_13 in var_05) {
    if(var_16 == var_5.size - 1)
      var_10 = 1;

    if(var_10)
      var_14 = var_04;
    else
      var_14 = var_03;

    var_15 = 50;
    self setneargoalnotifydist(var_15);
    var_11 = var_13;

    if(!var_10)
      thread func_BA1C(var_13 + var_14, var_5[var_16 + 1] + var_14);
    else
      thread func_BA1D(var_13 + var_14);

    self setscriptablepartstate("thrusters", "navigate", 0);
    self setvehgoalpos(var_13 + var_14, var_10);

    if(!var_10 || scripts\mp\utility\game::istrue(var_02)) {
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
    foreach(var_01 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_01)) {
        continue;
      }
      if(distancesquared(self.origin, var_1.origin) <= 10000 && !isDefined(var_1.cratemantle)) {
        var_1.cratemantle = 0;
        var_01 scripts\engine\utility::allow_mantle(0);
        var_01 thread watchdistancefromcrate(self);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

watchdistancefromcrate(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(isDefined(var_00)) {
    if(distancesquared(var_0.origin, self.origin) > 10000) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  self.cratemantle = undefined;
  scripts\engine\utility::allow_mantle(1);
}

watchfailsafe(var_00) {
  self endon("death");
  self endon("near_goal");
  var_01 = 3;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);

  if(distancesquared(self.origin, var_00) < 2500)
    self notify("death");
}

func_7E84(var_00) {
  var_01 = abs(var_0[0]);
  var_02 = abs(var_0[1]);
  var_03 = abs(var_0[2]);
  return int(max(var_03, max(var_01, var_02)));
}

func_BA00(var_00, var_01) {
  self notify("stop_MonitorPath");
  self endon("death");
  self endon("stop_MonitorPath");
  self endon("goal");
  self endon("near_goal");
  var_2[0] = self;
  var_2[1] = self.func_5D26;

  for(;;) {
    var_03 = scripts\engine\trace::sphere_trace(self.origin, var_01, 16, var_02);

    if(var_3["fraction"] == 1.0)
      self notify("near_goal");

    wait 0.25;
  }
}

setupchallengelocales(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnStruct();
  var_6.func_B75B = var_01;
  var_6.func_B491 = var_02;
  var_6.func_B7CB = var_03;
  var_6.func_B4C9 = var_04;
  var_6.func_1545 = var_05;
  level.func_109C4[var_00] = var_06;
}

setupcaptureflares() {
  setupchallengelocales("far", 500, 750, 45, 70, 100);
  setupchallengelocales("medium", 250, 500, 35, 45, 100);
  setupchallengelocales("near", 50, 250, 15, 30, 100);
  setupchallengelocales("medium_sharpturn", 250, 500, 10, 30, 100);
  setupchallengelocales("near_sharpturn", 50, 250, 10, 20, 100);
  setupchallengelocales("final", 50, 1000, 10, 45, 100);
}

func_12F22(var_00, var_01) {
  var_02 = 9999;
  var_03 = level.func_109C4[var_00];

  if(var_01 < var_3.func_B75B)
    var_01 = var_3.func_B75B;

  if(var_01 > var_3.func_B491)
    var_01 = var_3.func_B491;

  var_04 = (var_01 - var_3.func_B75B) / (var_3.func_B491 - var_3.func_B75B);
  var_05 = var_3.func_B7CB + var_04 * (var_3.func_B4C9 - var_3.func_B7CB);
  var_06 = var_3.func_1545;

  if(var_06 > var_05)
    var_06 = var_05;

  self vehicle_setspeed(var_05, var_06, var_02);
}

func_BA1D(var_00) {
  self notify("stop_MonitorSpeed");
  self endon("death");
  self endon("stop_MonitorSpeed");
  self endon("goal");
  var_01 = "none";

  for(;;) {
    var_02 = distance(self.origin, var_00);
    func_12F22("final", var_02);
    scripts\engine\utility::waitframe();
  }
}

func_BA1C(var_00, var_01) {
  self notify("stop_MonitorSpeed");
  self endon("death");
  self endon("stop_MonitorSpeed");
  var_02 = "none";
  var_03 = vectornormalize(var_01 - var_00);
  var_04 = distance(var_00, var_01);

  for(;;) {
    var_05 = distance(self.origin, var_00);
    var_06 = vectornormalize(var_00 - self.origin);
    var_07 = vectordot(var_03, var_06);
    var_08 = 0;

    if(var_07 < 0.707 || var_04 < 300)
      var_08 = 1;

    if(var_08) {
      if(var_05 < level.func_109C4["medium_sharpturn"].func_B75B)
        func_12F22("near_sharpturn", var_05);
      else
        func_12F22("medium_sharpturn", var_05);
    } else if(var_05 < level.func_109C4["near"].func_B491)
      func_12F22("near", var_05);
    else if(var_05 < level.func_109C4["medium"].func_B491)
      func_12F22("medium", var_05);
    else
      func_12F22("far", var_05);

    scripts\engine\utility::waitframe();
  }
}

doflyby(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_00)) {
    return;
  }
  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed()) {
    return;
  }
  var_06 = getflyheightoffset(var_01);

  if(isDefined(var_04))
    var_06 = var_06 + var_04;

  foreach(var_08 in level.littlebirds) {
    if(isDefined(var_8.droptype))
      var_06 = var_06 + 128;
  }

  var_10 = var_01 * (1, 1, 0) + (0, 0, var_06);
  var_11 = getpathstart(var_10, var_02);
  var_12 = getpathend(var_10, var_02);
  var_10 = var_10 + anglesToForward((0, var_02, 0)) * -50;
  var_13 = helisetup(var_00, var_11, var_10);

  if(isDefined(level.highlightairdrop) && level.highlightairdrop)
    var_13 hudoutlineenable(3, 0, 0);

  var_13 endon("death");
  var_13 thread func_4FC2();
  var_13.droptype = var_03;
  var_13 setvehgoalpos(var_10, 1);
  var_13 thread dropthecrate(var_01, var_03, var_06, 0, var_05, var_11);
  wait 2;
  var_13 vehicle_setspeed(75, 40);
  var_13 setyawspeed(180, 180, 180, 0.3);
  var_13 waittill("goal");
  wait 0.1;
  var_13 notify("drop_crate");
  var_13 setvehgoalpos(var_12, 1);
  var_13 vehicle_setspeed(300, 75);
  var_13.func_AB32 = 1;
  var_13 waittill("goal");
  var_13 notify("leaving");
  var_13 notify("delete");
  var_13 delete();
}

func_4FC2() {
  self waittill("death");
  waittillframeend;
  scripts\mp\utility\game::decrementfauxvehiclecount();
}

domegaflyby(var_00, var_01, var_02, var_03) {
  level thread doflyby(var_00, var_01, var_02, var_03, 0);
  wait(randomintrange(1, 2));
  level thread doflyby(var_00, var_01 + (128, 128, 0), var_02, var_03, 128);
  wait(randomintrange(1, 2));
  level thread doflyby(var_00, var_01 + (172, 256, 0), var_02, var_03, 256);
  wait(randomintrange(1, 2));
  level thread doflyby(var_00, var_01 + (64, 0, 0), var_02, var_03, 0);
}

doc130flyby(var_00, var_01, var_02, var_03) {
  var_04 = 18000;
  var_05 = 3000;
  var_06 = vectortoyaw(var_01 - var_0.origin);
  var_07 = (0, var_06, 0);
  var_08 = getflyheightoffset(var_01);
  var_09 = var_01 + anglesToForward(var_07) * (-1 * var_04);
  var_09 = var_09 * (1, 1, 0) + (0, 0, var_08);
  var_10 = var_01 + anglesToForward(var_07) * var_04;
  var_10 = var_10 * (1, 1, 0) + (0, 0, var_08);
  var_11 = length(var_09 - var_10);
  var_12 = var_11 / var_05;
  var_13 = c130setup(var_00, var_09, var_10);
  var_13.veh_speed = var_05;
  var_13.droptype = var_03;
  var_13 playLoopSound("veh_ac130_dist_loop");
  var_13.angles = var_07;
  var_14 = anglesToForward(var_07);
  var_13 moveto(var_10, var_12, 0, 0);
  var_15 = distance2d(var_13.origin, var_01);
  var_16 = 0;

  for(;;) {
    var_17 = distance2d(var_13.origin, var_01);

    if(var_17 < var_15)
      var_15 = var_17;
    else if(var_17 > var_15) {
      break;
    }
    if(var_17 < 320) {
      break;
    } else if(var_17 < 768) {
      scripts\mp\shellshock::_earthquake(0.15, 1.5, var_01, 1500);

      if(!var_16) {
        var_13 playSound("veh_ac130_sonic_boom");
        var_16 = 1;
      }
    }

    wait 0.05;
  }

  wait 0.05;
  var_18 = (0, 0, 0);
  var_19[0] = var_13 thread dropthecrate(var_01, var_03, var_08, 0, undefined, var_09, var_18);
  wait 0.05;
  var_13 notify("drop_crate");
  var_20 = var_01 + anglesToForward(var_07) * (var_04 * 1.5);
  var_13 moveto(var_20, var_12 / 2, 0, 0);
  wait 6;
  var_13 delete();
}

domegac130flyby(var_00, var_01, var_02, var_03, var_04) {
  var_05 = 24000;
  var_06 = 2000;
  var_07 = vectortoyaw(var_01 - var_0.origin);
  var_08 = (0, var_07, 0);
  var_09 = anglesToForward(var_08);

  if(isDefined(var_04))
    var_01 = var_01 + var_09 * var_04;

  var_10 = getflyheightoffset(var_01);
  var_11 = var_01 + anglesToForward(var_08) * (-1 * var_05);
  var_11 = var_11 * (1, 1, 0) + (0, 0, var_10);
  var_12 = var_01 + anglesToForward(var_08) * var_05;
  var_12 = var_12 * (1, 1, 0) + (0, 0, var_10);
  var_13 = length(var_11 - var_12);
  var_14 = var_13 / var_06;
  var_15 = c130setup(var_00, var_11, var_12);
  var_15.veh_speed = var_06;
  var_15.droptype = var_03;
  var_15 playLoopSound("veh_ac130_dist_loop");
  var_15.angles = var_08;
  var_09 = anglesToForward(var_08);
  var_15 moveto(var_12, var_14, 0, 0);
  var_16 = distance2d(var_15.origin, var_01);
  var_17 = 0;

  for(;;) {
    var_18 = distance2d(var_15.origin, var_01);

    if(var_18 < var_16)
      var_16 = var_18;
    else if(var_18 > var_16) {
      break;
    }
    if(var_18 < 256) {
      break;
    } else if(var_18 < 768) {
      scripts\mp\shellshock::_earthquake(0.15, 1.5, var_01, 1500);

      if(!var_17) {
        var_15 playSound("veh_ac130_sonic_boom");
        var_17 = 1;
      }
    }

    wait 0.05;
  }

  wait 0.05;
  var_19[0] = var_15 thread dropthecrate(var_01, var_03, var_10, 0, undefined, var_11);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 0.05;
  var_19[1] = var_15 thread dropthecrate(var_01, var_03, var_10, 0, undefined, var_11, undefined, var_19);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 0.05;
  var_19[2] = var_15 thread dropthecrate(var_01, var_03, var_10, 0, undefined, var_11, undefined, var_19);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 0.05;
  var_19[3] = var_15 thread dropthecrate(var_01, var_03, var_10, 0, undefined, var_11, undefined, var_19);
  wait 0.05;
  var_15 notify("drop_crate");
  wait 4;
  var_15 delete();
}

dropnuke(var_00, var_01, var_02) {
  var_03 = 24000;
  var_04 = 2000;
  var_05 = randomint(360);
  var_06 = (0, var_05, 0);
  var_07 = getflyheightoffset(var_00);
  var_08 = var_00 + anglesToForward(var_06) * (-1 * var_03);
  var_08 = var_08 * (1, 1, 0) + (0, 0, var_07);
  var_09 = var_00 + anglesToForward(var_06) * var_03;
  var_09 = var_09 * (1, 1, 0) + (0, 0, var_07);
  var_10 = length(var_08 - var_09);
  var_11 = var_10 / var_04;
  var_12 = c130setup(var_01, var_08, var_09);
  var_12.veh_speed = var_04;
  var_12.droptype = var_02;
  var_12 playLoopSound("veh_ac130_dist_loop");
  var_12.angles = var_06;
  var_13 = anglesToForward(var_06);
  var_12 moveto(var_09, var_11, 0, 0);
  var_14 = 0;
  var_15 = distance2d(var_12.origin, var_00);

  for(;;) {
    var_16 = distance2d(var_12.origin, var_00);

    if(var_16 < var_15)
      var_15 = var_16;
    else if(var_16 > var_15) {
      break;
    }
    if(var_16 < 256) {
      break;
    } else if(var_16 < 768) {
      scripts\mp\shellshock::_earthquake(0.15, 1.5, var_00, 1500);

      if(!var_14) {
        var_12 playSound("veh_ac130_sonic_boom");
        var_14 = 1;
      }
    }

    wait 0.05;
  }

  var_12 thread dropthecrate(var_00, var_02, var_07, 0, "nuke", var_08);
  wait 0.05;
  var_12 notify("drop_crate");
  wait 4;
  var_12 delete();
}

stoploopafter(var_00) {
  self endon("death");
  wait(var_00);
  self stoploopsound();
}

playlooponent(var_00) {
  var_01 = spawn("script_origin", (0, 0, 0));
  var_01 hide();
  var_01 endon("death");
  thread scripts\engine\utility::delete_on_death(var_01);
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_01 linkto(self);
  var_01 playLoopSound(var_00);
  self waittill("stop sound" + var_00);
  var_01 stoploopsound(var_00);
  var_01 delete();
}

c130setup(var_00, var_01, var_02) {
  var_03 = vectortoangles(var_02 - var_01);
  var_04 = spawnplane(var_00, "script_model", var_01, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
  var_04 setModel("vehicle_ac130_low_mp");

  if(!isDefined(var_04)) {
    return;
  }
  var_4.owner = var_00;
  var_4.team = var_0.team;
  level.c130 = var_04;
  return var_04;
}

helisetup(var_00, var_01, var_02) {
  var_03 = vectortoangles(var_02 - var_01);
  var_04 = "littlebird_mp";

  if(isDefined(level.vehicleoverride))
    var_04 = level.vehicleoverride;

  var_05 = spawnhelicopter(var_00, var_01, var_03, var_04, "vehicle_aas_72x_killstreak");

  if(!isDefined(var_05)) {
    return;
  }
  var_5.maxhealth = 500;
  var_5.owner = var_00;
  var_5.team = var_0.team;
  var_5.isairdrop = 1;
  var_05 thread watchtimeout();
  var_05 thread heli_existence();
  var_05 thread helidestroyed();
  var_05 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("airdrop");
  var_05 setmaxpitchroll(45, 85);
  var_05 vehicle_setspeed(250, 175);
  var_5.helitype = "airdrop";
  var_05 scripts\mp\killstreaks\utility::func_1843(var_5.helitype, "Killstreak_Air", var_00, 1);
  var_05 hidepart("tag_wings");
  return var_05;
}

watchtimeout(var_00) {
  level endon("game_ended");
  self endon("leaving");
  self endon("helicopter_gone");
  self endon("death");
  var_01 = 25.0;

  if(isDefined(var_00))
    var_01 = var_00;

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
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
  var_00 = self.origin + (0, 0, 1) - self.origin;
  playFX(level.chopper_fx["explode"]["death"]["cobra"], self.origin, var_00);
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  scripts\mp\utility\game::decrementfauxvehiclecount();
  self delete();
}

lbspin(var_00) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  playFXOnTag(level.chopper_fx["fire"]["trail"]["medium"], self, "tail_rotor_jnt");
  self setyawspeed(var_00, var_00, var_00);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_00 * 0.9);
    wait 1;
  }
}

nukecapturethink() {
  while(isDefined(self)) {
    self waittill("trigger", var_00);

    if(!var_00 isonground()) {
      continue;
    }
    if(!useholdthink(var_00)) {
      continue;
    }
    self notify("captured", var_00);
  }
}

crateothercapturethink(var_00, var_01) {
  self endon("restarting_physics");
  var_02 = self;
  var_03 = undefined;

  if(scripts\mp\utility\game::istrue(var_01)) {
    var_02 = self.fakeuseobj;
    var_03 = self.fakeuseobj;
  }

  while(isDefined(self)) {
    var_02 waittill("trigger", var_04);

    if(isDefined(self.owner) && var_04 == self.owner) {
      continue;
    }
    if(!validateopenconditions(var_04)) {
      continue;
    }
    if(isDefined(level.overridecrateusetime))
      var_05 = level.overridecrateusetime;
    else
      var_05 = undefined;

    var_4.iscapturingcrate = 1;

    if(!scripts\mp\utility\game::istrue(var_01))
      var_03 = createuseent();

    var_06 = var_03 useholdthink(var_04, var_05, var_00);

    if(!scripts\mp\utility\game::istrue(var_01)) {
      if(isDefined(var_03))
        var_03 delete();
    }

    if(!isDefined(var_04)) {
      return;
    }
    if(!var_06) {
      var_4.iscapturingcrate = 0;
      continue;
    }

    var_4.iscapturingcrate = 0;
    self notify("captured", var_04);
  }
}

crateownercapturethink(var_00) {
  self endon("restarting_physics");

  while(isDefined(self)) {
    self waittill("trigger", var_01);

    if(isDefined(self.owner) && var_01 != self.owner) {
      continue;
    }
    if(!validateopenconditions(var_01)) {
      continue;
    }
    var_1.iscapturingcrate = 1;

    if(!useholdthink(var_01, 500, var_00)) {
      var_1.iscapturingcrate = 0;
      continue;
    }

    var_1.iscapturingcrate = 0;
    self notify("captured", var_01);
  }
}

crateallcapturethink(var_00) {
  self endon("restarting_physics");
  self.crateuseents = [];

  while(isDefined(self)) {
    self waittill("trigger", var_01);

    if(!validateopenconditions(var_01)) {
      continue;
    }
    if(isDefined(level.overridecrateusetime))
      var_02 = level.overridecrateusetime;
    else
      var_02 = undefined;

    childthread cratealluselogic(var_01, var_02, var_00);
  }
}

cratealluselogic(var_00, var_01, var_02) {
  var_0.iscapturingcrate = 1;
  self.crateuseents[var_0.name] = createuseent();
  var_03 = self.crateuseents[var_0.name];
  var_04 = self.crateuseents[var_0.name] useholdthink(var_00, var_01, var_02, self);

  if(isDefined(self.crateuseents) && isDefined(var_03)) {
    self.crateuseents = scripts\mp\utility\game::func_22B1(self.crateuseents, var_03);
    var_03 delete();
  }

  if(!isDefined(var_00)) {
    return;
  }
  var_0.iscapturingcrate = 0;

  if(var_04)
    self notify("captured", var_00);
}

updatecraftingomnvars() {
  self.inuse = 0;

  foreach(var_01 in self.crateuseents) {
    if(var_1.inuse) {
      self.inuse = 1;
      break;
    }
  }
}

validateopenconditions(var_00) {
  if((self.cratetype == "airdrop_juggernaut_recon" || self.cratetype == "airdrop_juggernaut" || self.cratetype == "airdrop_juggernaut_maniac") && var_00 scripts\mp\utility\game::isjuggernaut())
    return 0;

  if(isDefined(var_0.onhelisniper) && var_0.onhelisniper)
    return 0;

  var_01 = var_00 getcurrentweapon();

  if(scripts\mp\utility\game::iskillstreakweapon(var_01) && !scripts\mp\utility\game::isjuggernautweapon(var_01))
    return 0;

  if(isbot(var_00)) {
    if(level.gametype != "grnd" && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(self.cratetype))
      return 0;

    if(scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots(self.cratetype))
      return 0;
  }

  return 1;
}

killstreakcratethink(var_00) {
  self endon("restarting_physics");
  self endon("death");

  if(isDefined(game["strings"][self.cratetype + "_hint"]))
    var_01 = game["strings"][self.cratetype + "_hint"];
  else
    var_01 = & "PLATFORM_GET_KILLSTREAK";

  var_02 = -10000;
  var_03 = undefined;

  if(!scripts\mp\utility\game::istrue(level.gameended)) {
    if(var_00 == "dronedrop_reroll") {
      var_03 = 1;

      if(isDefined(game["strings"][self.cratetype + "_rerollHint"]))
        var_01 = game["strings"][self.cratetype + "_rerollHint"];
    }

    cratesetupforuse(var_01, scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype), var_03, var_02);
  }

  thread crateothercapturethink(undefined, var_03);
  thread crateownercapturethink();
  thread cratewatchgameover();

  for(;;) {
    self waittill("captured", var_04);

    if(isplayer(var_04)) {
      var_04 setclientomnvar("ui_securing", 0);
      var_4.ui_securing = undefined;
    }

    if(isDefined(self.owner)) {
      if(var_04 == self.owner)
        var_04 thread scripts\mp\missions::func_D991("ch_scorestreak_uses_dronepackage");
      else if(!level.teambased || var_4.team != self.team) {
        switch (var_00) {
          case "airdrop_osprey_gunner":
          case "airdrop_escort":
          case "airdrop_support":
          case "airdrop_assault":
            var_04 thread scripts\mp\missions::processchallenge("hijacker_airdrop");
            var_04 thread hijacknotify(self, "airdrop");
            break;
          case "airdrop_sentry_minigun":
            var_04 thread scripts\mp\missions::processchallenge("hijacker_airdrop");
            var_04 thread hijacknotify(self, "sentry");
            break;
          case "airdrop_remote_tank":
            var_04 thread scripts\mp\missions::processchallenge("hijacker_airdrop");
            var_04 thread hijacknotify(self, "remote_tank");
            break;
          case "airdrop_mega":
            var_04 thread scripts\mp\missions::processchallenge("hijacker_airdrop_mega");
            var_04 thread hijacknotify(self, "emergency_airdrop");
            break;
          case "dronedrop_highroll":
          case "jackaldrop":
          case "dronedrop_reroll":
          case "dronedrop":
            var_04 thread hijacknotify(self, "dronedrop");
            var_04 thread scripts\mp\missions::func_D991("ch_hijack");
            break;
        }
      } else if(level.gametype != "grnd") {
        self.owner thread scripts\mp\awards::givemidmatchaward("ss_use_dronedrop");
        self.owner thread scripts\mp\missions::func_D991("ch_package_share");
      }
    }

    var_04 playlocalsound("ammo_crate_use");
    var_05 = undefined;

    if(scripts\mp\utility\game::istrue(level.enablevariantdrops))
      var_05 = scripts\mp\killstreak_loot::getrandomvariantfrombaseref(self.cratetype);

    if(isDefined(var_05)) {
      var_06 = scripts\mp\killstreak_loot::getpassiveperk(var_05);
      var_04 thread scripts\mp\killstreaks\killstreaks::awardkillstreak(self.cratetype, self.owner, var_06, var_05);
      var_07 = scripts\mp\killstreak_loot::getrarityforlootitem(var_05);
      var_08 = self.cratetype + "_" + var_07;
      var_04 scripts\mp\hud_message::showkillstreaksplash(var_08, undefined, 1);
    } else {
      var_04 thread scripts\mp\killstreaks\killstreaks::givekillstreak(self.cratetype, 0, 0, self.owner);
      var_04 scripts\mp\hud_message::showkillstreaksplash(self.cratetype, undefined, 1);
    }

    if(scripts\mp\killstreaks\killstreaks::getstreakcost(self.cratetype) > 1000)
      var_04 thread scripts\mp\missions::func_D991("ch_dronepackage_jackpot");

    deletecrateold();
  }
}

killstreakbombcratethink(var_00) {
  self endon("restarting_physics");
  self endon("death");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  var_01 = [ & "KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP", & "KILLSTREAKS_HINTS_JACKAL_PICKUP", & "KILLSTREAKS_HINTS_THOR_PICKUP", & "KILLSTREAKS_HINTS_RC8_PICKUP", & "KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP"];
  var_02 = scripts\engine\utility::random(var_01);
  var_03 = undefined;

  if(level.gametype == "grnd")
    var_03 = -10000;

  if(!scripts\mp\utility\game::istrue(level.gameended))
    cratesetupforuse(var_02, "hud_icon_trap_package", 0, var_03);

  thread crateothercapturethink();
  thread cratewatchgameover();
  thread cratewatchownerdisconnect();

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament moveto(self.origin + (0, 0, 30), 0.05);
  }

  self waittill("captured", var_04);

  if(isplayer(var_04)) {
    var_04 setclientomnvar("ui_securing", 0);
    var_4.ui_securing = undefined;
  }

  var_04 playlocalsound("ammo_crate_use");
  var_05 = self.owner scripts\mp\utility\game::_launchgrenade("dummy_spike_mp", self.origin, self.origin, 2);

  if(!isDefined(var_5.weapon_name))
    var_5.weapon_name = "dummy_spike_mp";

  var_05 linkto(self);
  var_06 = 0.1;
  var_07 = 0;

  while(var_07 < 0.8) {
    playLoopSound(self.origin + (0, 0, 10), "mp_dronepackage_trap_warning");
    var_07 = var_07 + var_06;
    wait(var_06);
  }

  playFX(scripts\engine\utility::getfx("crate_explode"), self.origin);
  playLoopSound(self.origin, "mp_equip_destroyed");
  scripts\mp\shellshock::func_22FF(1.0, 0.7, 800);

  if(isDefined(self.owner))
    self radiusdamage(self.origin, 256, 200, 100, self.owner, "MOD_EXPLOSIVE", "jackal_fast_cannon_mp");

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

  if(isDefined(self))
    deletecrateold();
}

dronewatchgameover() {
  self endon("death");
  level scripts\engine\utility::waittill_any("bro_shot_start", "game_ended");

  if(isDefined(self))
    self notify("death");
}

nukecratethink(var_00) {
  self endon("restarting_physics");
  self endon("death");
  cratesetupforuse( & "PLATFORM_CALL_NUKE", scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype));
  thread nukecapturethink();

  for(;;) {
    self waittill("captured", var_01);
    var_01 thread scripts\mp\killstreaks\killstreaks::func_729F(self.cratetype);
    level notify("nukeCaptured", var_01);

    if(isDefined(level.gtnw) && level.gtnw)
      var_1.capturednuke = 1;

    var_01 playlocalsound("ammo_crate_use");
    deletecrateold();
  }
}

juggernautcratethink(var_00) {
  self endon("restarting_physics");
  self endon("death");
  cratesetupforuse(game["strings"][self.cratetype + "_hint"], scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype));
  thread crateothercapturethink();
  thread crateownercapturethink();

  for(;;) {
    self waittill("captured", var_01);

    if(isDefined(self.owner) && var_01 != self.owner) {
      if(!level.teambased || var_1.team != self.team) {
        if(self.cratetype == "airdrop_juggernaut_maniac")
          var_01 thread hijacknotify(self, "maniac");
        else if(scripts\mp\utility\game::isstrstart(self.cratetype, "juggernaut_"))
          var_01 thread hijacknotify(self, self.cratetype);
        else
          var_01 thread hijacknotify(self, "juggernaut");
      } else if(self.cratetype == "airdrop_juggernaut_maniac")
        self.owner scripts\mp\hud_message::showsplash("giveaway_juggernaut_maniac", undefined, var_01);
      else if(scripts\mp\utility\game::isstrstart(self.cratetype, "juggernaut_"))
        self.owner scripts\mp\hud_message::showsplash("giveaway_" + self.cratetype, undefined, var_01);
      else
        self.owner scripts\mp\hud_message::showsplash("giveaway_juggernaut", undefined, var_01);
    }

    var_01 playlocalsound("ammo_crate_use");
    var_02 = "juggernaut";

    switch (self.cratetype) {
      case "airdrop_juggernaut":
        var_02 = "juggernaut";
        break;
      case "airdrop_juggernaut_recon":
        var_02 = "juggernaut_recon";
        break;
      case "airdrop_juggernaut_maniac":
        var_02 = "juggernaut_maniac";
        break;
      default:
        if(scripts\mp\utility\game::isstrstart(self.cratetype, "juggernaut_"))
          var_02 = self.cratetype;

        break;
    }

    var_01 thread scripts\mp\killstreaks\juggernaut::givejuggernaut(var_02);
    deletecrateold();
  }
}

sentrycratethink(var_00) {
  self endon("death");
  cratesetupforuse(game["strings"]["sentry_hint"], scripts\mp\utility\game::getkillstreakoverheadicon(self.cratetype));
  thread crateothercapturethink();
  thread crateownercapturethink();

  for(;;) {
    self waittill("captured", var_01);

    if(isDefined(self.owner) && var_01 != self.owner) {
      if(!level.teambased || var_1.team != self.team) {
        if(issubstr(var_00, "airdrop_sentry"))
          var_01 thread hijacknotify(self, "sentry");
        else
          var_01 thread hijacknotify(self, "emergency_airdrop");
      } else {
        self.owner thread scripts\mp\utility\game::giveunifiedpoints("killstreak_giveaway", undefined, int(scripts\mp\killstreaks\killstreaks::getstreakcost("sentry") / 10) * 50);
        self.owner scripts\mp\hud_message::showsplash("giveaway_sentry", undefined, var_01);
      }
    }

    var_01 playlocalsound("ammo_crate_use");
    var_01 thread sentryusetracker();
    deletecrateold();
  }
}

deletecrateold() {
  self notify("crate_deleting");

  if(isDefined(self.usedby)) {
    foreach(var_01 in self.usedby) {
      var_01 setclientomnvar("ui_securing", 0);
      var_1.ui_securing = undefined;
    }
  }

  if(isDefined(self.minimapid))
    scripts\mp\objidpoolmanager::returnminimapid(self.minimapid);

  if(isDefined(self.bomb) && isDefined(self.bomb.killcament))
    self.bomb.killcament delete();

  if(isDefined(self.bomb))
    self.bomb delete();

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.droptype))
    playFX(scripts\engine\utility::getfx("airdrop_crate_destroy"), self.origin);

  if(isDefined(self.func_BE6F)) {
    self notify("nav_obstacle_destroyed");
    _destroynavobstacle(self.func_BE6F);
    self.func_BE6F = undefined;
  }

  self delete();
}

sentryusetracker() {
  if(!scripts\mp\killstreaks\autosentry::givesentry("sentry_minigun", 0, 0))
    scripts\mp\killstreaks\killstreaks::givekillstreak("sentry");
}

hijacknotify(var_00, var_01) {
  self notify("hijacker", var_01, var_0.owner);
}

refillammo(var_00) {
  var_01 = self getweaponslistall();

  if(var_00) {}

  foreach(var_03 in var_01) {
    if(issubstr(var_03, "grenade") || getsubstr(var_03, 0, 2) == "gl") {
      if(!var_00 || self getammocount(var_03) >= 1)
        continue;
    }

    self givemaxammo(var_03);
  }
}

useholdthink(var_00, var_01, var_02, var_03) {
  scripts\mp\movers::script_mover_link_to_use_object(var_00);
  var_00 scripts\engine\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(var_03))
    var_03 updatecraftingomnvars();

  if(isDefined(var_01))
    self.usetime = var_01;
  else
    self.usetime = 3000;

  var_04 = useholdthinkloop(var_00);

  if(isalive(var_00))
    var_00 scripts\engine\utility::allow_weapon(1);

  if(isDefined(var_00))
    scripts\mp\movers::script_mover_unlink_from_use_object(var_00);

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;

  if(isDefined(var_03))
    var_03 updatecraftingomnvars();

  return var_04;
}

useholdthinkloop(var_00) {
  while(var_00 scripts\mp\killstreaks\deployablebox::isplayerusingbox(self)) {
    if(!var_00 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_00 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return 0;
    }

    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler))
      self.userate = 1 * self.objectivescaler;
    else
      self.userate = 1;

    var_00 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var_00 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility\game::isreallyalive(var_00);
    }

    wait 0.05;
  }

  if(isDefined(self))
    var_00 scripts\mp\gameobjects::updateuiprogress(self, 0);

  return 0;
}

createuseent() {
  var_00 = spawn("script_origin", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0.id = self.id;
  var_00 linkto(self);
  var_00 thread deleteuseent(self);
  return var_00;
}

deleteuseent(var_00) {
  self endon("death");
  var_00 waittill("death");

  if(isDefined(self.usedby)) {
    foreach(var_02 in self.usedby) {
      var_02 setclientomnvar("ui_securing", 0);
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

throw_linked_care_packages(var_00, var_01, var_02, var_03) {
  if(isDefined(level.carepackages)) {
    foreach(var_05 in level.carepackages) {
      if(isDefined(var_5.inuse) && var_5.inuse) {
        continue;
      }
      var_06 = var_05 getlinkedparent();

      if(isDefined(var_06) && var_06 == var_00) {
        thread spawn_new_care_package(var_05, var_01, var_02);

        if(isDefined(var_03))
          scripts\engine\utility::delaythread(1.0, ::remove_care_packages_in_volume, var_03);
      }
    }
  }
}

spawn_new_care_package(var_00, var_01, var_02) {
  var_03 = var_0.owner;
  var_04 = var_0.droptype;
  var_05 = var_0.cratetype;
  var_06 = var_0.origin;
  var_00 deletecrateold();
  var_07 = var_03 createairdropcrate(var_03, var_04, var_05, var_06 + var_01, var_06 + var_01);
  var_7.droppingtoground = 1;
  var_07 thread[[level.cratetypes[var_7.droptype][var_7.cratetype].func]](var_7.droptype);
  scripts\engine\utility::waitframe();
  var_07 physicslaunchserver(var_7.origin, var_02);

  if(isbot(var_7.owner)) {
    wait 0.1;
    var_7.owner notify("new_crate_to_take");
  }
}

remove_care_packages_in_volume(var_00) {
  if(isDefined(level.carepackages)) {
    foreach(var_02 in level.carepackages) {
      if(isDefined(var_02) && isDefined(var_2.friendlymodel) && var_2.friendlymodel istouching(var_00))
        var_02 deletecrateold();
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
  addcratetype("dronedrop_grnd", "jackal", 15, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "thor", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_THOR_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "directional_uav", 10, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "remote_c8", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_RC8_PICKUP", undefined, "care_package_iw7_dummy");
  addcratetype("dronedrop_grnd", "minijackal", 5, ::killstreakcratethink, "care_package_iw7_un_wm", "care_package_iw7_ca_wm", & "KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP", undefined, "care_package_iw7_dummy");
  generatemaxweightedcratevalue();
}