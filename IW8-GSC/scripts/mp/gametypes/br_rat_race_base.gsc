/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rat_race_base.gsc
*****************************************************/

function ref_140F9() {
  ref_140FA();
}

function ref_140FA() {
  var_0 = scripts\mp\gametypes\br_plunder::ref_1278C("br_plunder_extraction_vault", 1);
  var_0.type = 1;
  var_0.usetime = 0.75;
  var_0.stealtime = 1.5;
  var_0.ref_14077 = 7;
  var_0.ref_14075 = 100000;
  var_0.ref_13ACC = 0;
  var_0.ref_12F7D = "brloot_plunder_extraction_vault";
  var_0.ref_12F7E = "usable";
  var_0.ref_12F77 = "unusable";
  var_0.stealfailmsg7 = "BR_RAT_RACE/BR_NOTHING_TO_STEAL";
  var_0.overrideviewkickscaledmr = 10800;
  var_0.origin_delta = 0;
  var_0.get_closest_enemy_near_turret = 0;
  var_0.outline_enemy_ai_for_duration = "rat_race";
  var_0.brking_ispointinmovingcircle = getdvarint("scr_br_plunder_extraction_vault_allow_stealing", 1) != 0;
  var_0.stealamount = getdvarint("scr_br_plunder_extraction_vault_steal_amount", 2500);
  var_0.maxnumplunderobjectstodropforsteal = 50;
}

function ref_140F5(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("br_plunder_extraction_vault");
  var_3.team = var_2;
  var_3.angles = var_1;
  scripts\mp\gametypes\br_plunder::ref_12796(var_3, "br_plunder_extraction_vault");
  var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_3.team);
  thread scripts\mp\gametypes\br_plunder::ref_127A4(var_3, var_4);
  scripts\mp\gametypes\br_plunder::ref_127AA(var_3, var_4);

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && isPlayer(var_6)) {
      var_3 setotherent(var_6);
      break;
    }
  }

  return var_3;
}

function ref_140FB() {
  var_0 = scripts\mp\gametypes\br_plunder::ref_1278C("br_plunder_extraction_vault");

  if(var_0.brking_ispointinmovingcircle) {
    var_1 = "hitequip";
    var_2 = undefined;
    var_3 = undefined;
    var_4 = 1;
    thread scripts\mp\damage::monitordamage(500, var_1, &ref_140F8, &ref_140F7, var_2, var_3, var_4);
    return;
  }
}

function ref_140F7(var_0) {
  if(self.plunder.size <= 0) {
    return 0;
  }

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, self))) {
    return 0;
  }

  var_1 = scripts\mp\damage::handleshotgundamage(var_0.objweapon, var_0.meansofdeath, var_0.damage);

  if(var_0.meansofdeath == "MOD_MELEE") {
    var_1 = int(ceil(self.maxhealth / 6));
  } else if(isexplosivedamagemod(var_0.meansofdeath)) {
    if(var_0.damage >= 50) {
      var_1 = int(ceil(self.maxhealth / 2));
    }
  }

  return var_1;
}

function ref_140F8(var_0) {
  thread scripts\mp\gametypes\br::ref_13AC7("br_gametype_rat_race_your_team_stole_from_enemy_base", undefined, var_0.attacker.team);
  thread scripts\mp\gametypes\br::ref_13AC7("br_gametype_rat_race_enemy_stole_from_your_base", undefined, self.team);
  var_1 = 1;
  var_2 = scripts\mp\gametypes\br_gametype_rat_race::replace_access_card_on_deathordisconnect();
  scripts\mp\gametypes\br_plunder::num_rocket_per_attack(var_1, var_2);
  scripts\mp\damage::monitordamageend();
  wait 1;
  ref_140FB();
}