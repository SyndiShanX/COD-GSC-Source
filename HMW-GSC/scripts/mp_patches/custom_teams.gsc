main() {
  replacefunc(maps\mp\gametypes\_teams::playercostume, ::playercostume_stub);
  replacefunc(maps\mp\gametypes\_teams::setteammodels, ::setteammodels_stub);
  replacefunc(maps\mp\gametypes\_teams::setghilliemodels, ::setghilliemodels_stub);
}

setghilliemodels_stub(env) {
  level.environment = env;
  /*
  switch ( env )
  {
  case "desert":
  mptype_ally_ghillie_desert_precache();
  mptype_opforce_ghillie_desert_precache();
  game["allies_model"]["GHILLIE"] = ::mptype_ally_ghillie_desert_main;
  game["axis_model"]["GHILLIE"] = ::mptype_opforce_ghillie_desert_main;
  break;
  case "arctic":
  mptype_ally_ghillie_arctic_precache();
  mptype_opforce_ghillie_arctic_precache();
  game["allies_model"]["GHILLIE"] = ::mptype_ally_ghillie_arctic_main;
  game["axis_model"]["GHILLIE"] = ::mptype_opforce_ghillie_arctic_main;
  break;
  case "urban":
  mptype_ally_ghillie_urban_precache();
  mptype_opforce_ghillie_urban_precache();
  game["allies_model"]["GHILLIE"] = ::mptype_ally_ghillie_urban_main;
  game["axis_model"]["GHILLIE"] = ::mptype_opforce_ghillie_urban_main;
  break;
  case "forest":
  mptype_ally_ghillie_forest_precache();
  mptype_opforce_ghillie_forest_precache();
  game["allies_model"]["GHILLIE"] = ::mptype_ally_ghillie_forest_main;
  game["axis_model"]["GHILLIE"] = ::mptype_opforce_ghillie_forest_main;
  break;
  default:
  break;			
  }
  */
}

////////////////////////////////
// TF141//
////////////////////////////////

tf141_assault_precache() {
  precachemodel("body_h2_tf141_assault");
  precachemodel("head_h2_tf141_assault");
  precachemodel("viewhands_tf141");
}

tf141_smg_precache() {
  precachemodel("body_h2_tf141_smg");
  precachemodel("head_h2_tf141_lmg");
  precachemodel("viewhands_tf141");
}

tf141_lmg_precache() {
  precachemodel("body_h2_tf141_assault");
  precachemodel("head_h2_tf141_smg");
  precachemodel("viewhands_tf141");
}

tf141_assault_main() {
  self setviewmodel("viewhands_tf141");
  self.voice = "american";
  self setclothtype("vestlight");
}

tf141_smg_main() {
  self setviewmodel("viewhands_tf141");
  self.voice = "american";
  self setclothtype("vestlight");
}

tf141_lmg_main() {
  self setviewmodel("viewhands_tf141");
  self.voice = "american";
  self setclothtype("vestlight");
}

////////////////////////////////
// OPFOR//
////////////////////////////////

opfor_assault_precache() {
  precachemodel("body_h2_opforce_assault");
  precachemodel("head_h2_opforce_assault");
  precachemodel("viewhands_h1_arab_desert_mp_camo");
}

opfor_smg_precache() {
  precachemodel("body_h2_opforce_smg");
  precachemodel("head_h2_opforce_smg");
  precachemodel("viewhands_h1_arab_desert_mp_camo");
}

opfor_lmg_precache() {
  precachemodel("body_h2_opforce_lmg");
  precachemodel("head_h2_opforce_lmg");
  precachemodel("viewhands_h1_arab_desert_mp_camo");
}

opfor_assault_main() {
  self setviewmodel("viewhands_h1_arab_desert_mp_camo");
  self.voice = "american";
  self setclothtype("vestlight");
}

opfor_smg_main() {
  self setviewmodel("viewhands_h1_arab_desert_mp_camo");
  self.voice = "american";
  self setclothtype("vestlight");
}

opfor_lmg_main() {
  self setviewmodel("viewhands_h1_arab_desert_mp_camo");
  self.voice = "american";
  self setclothtype("vestlight");
}

////////////////////////////////
//SPETSNAZ//
////////////////////////////////

spetsnaz_assault_precache() {
  precachemodel("body_h2_airborne_assault");
  precachemodel("head_h2_airborne_assault");
  precachemodel("globalViewhands_mw2_airborne");
}

spetsnaz_smg_precache() {
  precachemodel("body_h2_airborne_smg");
  precachemodel("head_h2_airborne_smg");
  precachemodel("globalViewhands_mw2_airborne");
}

spetsnaz_lmg_precache() {
  precachemodel("body_h2_airborne_lmg");
  precachemodel("head_h2_airborne_lmg");
  precachemodel("globalViewhands_mw2_airborne");
}

spetsnaz_assault_main() {
  self setviewmodel("globalViewhands_mw2_airborne");
  self.voice = "russian";
  self setclothtype("vestlight");
}

spetsnaz_smg_main() {
  self setviewmodel("globalViewhands_mw2_airborne");
  self.voice = "russian";
  self setclothtype("vestlight");
}

spetsnaz_lmg_main() {
  self setviewmodel("globalViewhands_mw2_airborne");
  self.voice = "russian";
  self setclothtype("vestlight");
}

////////////////////////////////
//RANGERS //
////////////////////////////////

rangers_assault_precache() {
  precachemodel("body_h2_us_army_ar");
  precachemodel("head_h2_us_army_assault");
  precachemodel("viewhands_rangers");
}

rangers_smg_precache() {
  precachemodel("body_h2_us_army_smg");
  precachemodel("head_h2_us_army_smg");
  precachemodel("viewhands_rangers");
}

rangers_lmg_precache() {
  precachemodel("body_h2_us_army_lmg");
  precachemodel("head_h2_us_army_lmg");
  precachemodel("viewhands_rangers");
}

rangers_assault_main() {
  self setviewmodel("viewhands_rangers");
  self.voice = "american";
  self setclothtype("vestlight");
}

rangers_smg_main() {
  self setviewmodel("viewhands_rangers");
  self.voice = "american";
  self setclothtype("vestlight");
}

rangers_lmg_main() {
  self setviewmodel("viewhands_rangers");
  self.voice = "american";
  self setclothtype("vestlight");
}

////////////////////////////////
// SEALS//
////////////////////////////////

seals_assault_precache() {
  precachemodel("body_h2_seal_assault");
  precachemodel("head_h2_seal_assault");
  precachemodel("viewhands_udt");
}

seals_smg_precache() {
  precachemodel("body_h2_seal_smg");
  precachemodel("head_h2_seal_smg");
  precachemodel("viewhands_udt");
}

seals_lmg_precache() {
  precachemodel("body_h2_seal_assault");
  precachemodel("head_h2_seal_lmg");
  precachemodel("viewhands_udt");
}

seals_assault_main() {
  self setviewmodel("viewhands_udt");
  self.voice = "american";
  self setclothtype("vestlight");
}

seals_smg_main() {
  self setviewmodel("viewhands_udt");
  self.voice = "american";
  self setclothtype("vestlight");
}

seals_lmg_main() {
  self setviewmodel("viewhands_udt");
  self.voice = "american";
  self setclothtype("vestlight");
}

////////////////////////////////
//MILITIA //
////////////////////////////////

militia_assault_precache() {
  precachemodel("body_h2_militia_assault");
  precachemodel("head_h2_militia_assault");
  precachemodel("globalViewhands_mw2_militia");
}

militia_smg_precache() {
  precachemodel("body_h2_militia_smg");
  precachemodel("head_h2_militia_smg");
  precachemodel("globalViewhands_mw2_militia");
}

militia_lmg_precache() {
  precachemodel("body_h2_militia_lmg");
  precachemodel("head_h2_militia_lmg");
  precachemodel("globalViewhands_mw2_militia");
}

militia_assault_main() {
  self setviewmodel("globalViewhands_mw2_militia");
  self.voice = "american";
  self setclothtype("vestlight");
}

militia_smg_main() {
  self setviewmodel("globalViewhands_mw2_militia");
  self.voice = "american";
  self setclothtype("vestlight");
}

militia_lmg_main() {
  self setviewmodel("viewhands_udt");
  self.voice = "american";
  self setclothtype("vestlight");
}

allies_ghillie_precache() {
  precachemodel("viewhands_h2_ghillie");
}

allies_ghillie_setviewmodel() {
  self setviewmodel("viewhands_h2_ghillie");
}

axis_ghillie_precache() {
  precachemodel("viewhands_h2_ghillie");
}

axis_ghillie_setviewmodel() {
  self setviewmodel("viewhands_h2_ghillie");
}

setteammodels_stub(team, charSet) {
  if(maps\mp\_utility::invirtuallobby() || level.virtuallobbyactive) {
    charSet = "rangers";
  }

  tf141_assault_precache();
  tf141_smg_precache();
  tf141_lmg_precache();

  opfor_assault_precache();
  opfor_smg_precache();
  opfor_lmg_precache();

  spetsnaz_assault_precache();
  spetsnaz_smg_precache();
  spetsnaz_lmg_precache();

  rangers_assault_precache();
  rangers_smg_precache();
  rangers_lmg_precache();

  seals_assault_precache();
  seals_smg_precache();
  seals_lmg_precache();

  militia_assault_precache();
  militia_smg_precache();
  militia_lmg_precache();

  allies_ghillie_precache();
  axis_ghillie_precache();

  switch (charSet) {
    case "tf141":
      game[team + "_model"]["LMG"] = ::tf141_lmg_main;
      game[team + "_model"]["ASSAULT"] = ::tf141_assault_main;
      game[team + "_model"]["SMG"] = ::tf141_smg_main;
      break;
    case "russian":
      game[team + "_model"]["LMG"] = ::spetsnaz_lmg_main;
      game[team + "_model"]["ASSAULT"] = ::spetsnaz_assault_main;
      game[team + "_model"]["SMG"] = ::spetsnaz_smg_main;
      break;
    case "rangers":
      game[team + "_model"]["LMG"] = ::rangers_lmg_main;
      game[team + "_model"]["ASSAULT"] = ::rangers_assault_main;
      game[team + "_model"]["SMG"] = ::rangers_smg_main;
      break;
    case "seals":
      game[team + "_model"]["LMG"] = ::seals_lmg_main;
      game[team + "_model"]["ASSAULT"] = ::seals_assault_main;
      game[team + "_model"]["SMG"] = ::seals_smg_main;
      break;
    case "militia":
      game[team + "_model"]["LMG"] = ::militia_lmg_main;
      game[team + "_model"]["ASSAULT"] = ::militia_assault_main;
      game[team + "_model"]["SMG"] = ::militia_smg_main;
      break;
    case "opfor":
    default:
      game[team + "_model"]["LMG"] = ::opfor_lmg_main;
      game[team + "_model"]["ASSAULT"] = ::opfor_assault_main;
      game[team + "_model"]["SMG"] = ::opfor_smg_main;
      break;
  }
}

playercostume_stub(weapon, team, environment) {
  if(isagent(self) && !getdvarint("virtualLobbyActive", 0)) {
    self thread apply_iw4_costumes();
    return 1;
  }

  if(isdefined(weapon))
    weapon = maps\mp\_utility::getbaseweaponname(weapon);

  if(isdefined(weapon))
    weapon = weapon + "_mp";

  self setcostumemodels(self.costume, weapon, team, environment);

  // if( maps\mp\_utility::invirtuallobby() || level.virtuallobbyactive)
  // {
  // return 1;
  // }

  self thread apply_iw4_costumes();

  return 1;
}

apply_iw4_costumes() {
  self endon("disconnect");
  level endon("game_ended");

  self waittill("player_model_set");

  // returning here is fine if its not valid, because the function seems to call again with a valid primaryweapon on the same player
  if(!isdefined(self.primaryweapon)) {
    return;
  }

  weapon = self.primaryweapon;

  if(isdefined(weapon))
    weapon = maps\mp\_utility::getbaseweaponname(weapon);

  weaponClass = tablelookup("mp/statstable.csv", 4, weapon, 2);

  if(maps\mp\_utility::invirtuallobby() || level.virtuallobbyactive) {
    switch (weaponClass) {
      case "weapon_smg":
        rangers_smg_main();
        break;
      case "weapon_assault":
        rangers_assault_main();
        break;
      case "weapon_sniper":
        if(self.team == "allies")
          allies_ghillie_setviewmodel();
        else
          axis_ghillie_setviewmodel();
        break;
      case "weapon_lmg":
      case "weapon_heavy":
      case "default":
      default:
        rangers_lmg_main();
        break;
    }
    return;
  }

  switch (weaponClass) {
    case "weapon_smg":
      [
        [game[self.team + "_model"]["SMG"]]
      ]();
      break;
    case "weapon_assault":
      [
        [game[self.team + "_model"]["ASSAULT"]]
      ]();
      break;
    case "weapon_sniper":
      if(self.team == "allies")
        allies_ghillie_setviewmodel();
      else
        axis_ghillie_setviewmodel();
      break;
    case "weapon_lmg":
    case "weapon_heavy":
      [
        [game[self.team + "_model"]["LMG"]]
      ]();
      break;
    default:
      // print ("[WARNING] weaponClass '" + weaponClass + "' does not match any valid types.");
      //self iprintln ("^3[WARNING] weaponClass '" + weaponClass + "' does not match any valid types.");
      self randomBotCostume();
      break;
  }
}

randomBotCostume() {
  weapon_classes = [];
  weapon_classes[0] = "weapon_smg";
  weapon_classes[1] = "weapon_assault";
  weapon_classes[2] = "weapon_sniper";
  weapon_classes[3] = "weapon_heavy";

  chosen_weapon_class = weapon_classes[randomInt(weapon_classes.size)];

  switch (chosen_weapon_class) {
    case "weapon_smg":
      [
        [game[self.team + "_model"]["SMG"]]
      ]();
      break;
    case "weapon_assault":
      [
        [game[self.team + "_model"]["ASSAULT"]]
      ]();
      break;
    case "weapon_sniper":
      if(self.team == "allies")
        allies_ghillie_setviewmodel();
      else
        axis_ghillie_setviewmodel();
      break;
    case "weapon_lmg":
    case "weapon_heavy":
      [
        [game[self.team + "_model"]["LMG"]]
      ]();
      break;
    default:
      break;
  }
}