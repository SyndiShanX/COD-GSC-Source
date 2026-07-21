/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\classes\cp_class_progression.gsc
***********************************************/

class_progression_init() {
  while(!isDefined(level.players))
    wait 0.1;
}

get_player_class(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_1 = var_0 scripts\cp\utility::getplayerdataloadoutgroup();
  var_2 = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_835A0FF94ACBEA830262CB0B129627E341");
}

give_player_class(var_0) {
  self notify("_encstr_B4FB0D299CBE80F8A2A7273177CBBE");
  scripts\cp\perks\cp_perks::init_each_perk();
  var_1 = scripts\cp\utility::getplayerdataloadoutgroup();
  var_2 = scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var_3 = "_encstr_8BBA05185F8B99";

  if(!scripts\cp\utility::tryingtoleave()) {
    self setviewkickscale(0.5);

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = var_4;

      if(isDefined(var_0))
        var_6 = scripts\cp\cp_loadout::table_getperk(level.classtablename, var_0, var_4);
      else
        var_6 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_2, "_encstr_86CB0DFB97F7022F90BB3A7F53487B", var_5);

      if(isDefined(var_6))
        scripts\cp\utility::giveperk(var_6);
    }
  }

  scripts\cp\coop_super::script_end();
  init_player_sessiondata();
}

give_assault_class() {
  self.class = "_encstr_AB3508737F830710ACDB";
  scripts\cp\utility::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
}

_id_12BC2() {
  scripts\cp\utility::takeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
}

give_crusader_class() {
  self.class = "_encstr_88CC09377EA33BA181ED2E";
}

_id_12BC8() {}

wait_and_give_perk(var_0, var_1) {
  wait(var_1);
  scripts\cp\utility::giveperk(var_0);
}

give_tank_class() {
  self.class = "_encstr_8DEF05BDE933E0";
  screenent();
}

screenent() {
  var_0 = self getcurrentweapon();

  if(scripts\cp\cp_weapon::is_launcher(var_0) && !scripts\cp\cp_weapon::is_killstreak_weapon(var_0))
    var_0 = scripts\cp\cp_weapon::add_launcher_xmags(var_0);
}

_id_12BF8() {
  var_0 = self getcurrentweapon();

  if(scripts\cp\cp_weapon::is_launcher(var_0) && !scripts\cp\cp_weapon::is_killstreak_weapon(var_0)) {
    var_1 = self getweaponammoclip(var_0);
    var_2 = self getweaponammostock(var_0);
    var_0 = scripts\cp\cp_weapon::_id_12BDA(var_0);
    self setweaponammoclip(var_0, var_1);
    self setweaponammostock(var_0, var_2);
  }
}

give_medic_class() {
  self.class = "_encstr_A6C7065BAC91D28D";
}

_id_12BDE() {}

give_hunter_class() {
  self.class = "_encstr_A12707B8AB65E9A9C3";
  scripts\cp\perks\cp_perks::reduce_recoil();
}

_id_12BD5() {
  scripts\cp\perks\cp_perks::_id_12BEE();
}

give_engineer_class() {
  self.class = "_encstr_8CFF09D56D88EC030D69EB";
}

_id_12BCA() {}

give_default_class() {
  var_0 = scripts\engine\utility::random(["_encstr_A6C7065BAC91D28D", "_encstr_8DEF05BDE933E0", "_encstr_88CC09377EA33BA181ED2E", "_encstr_AB3508737F830710ACDB", "_encstr_A12707B8AB65E9A9C3", "_encstr_8CFF09D56D88EC030D69EB"]);

  switch (var_0) {
    case "_encstr_A6C7065BAC91D28D":
      give_medic_class();
      break;
    case "_encstr_8DEF05BDE933E0":
      give_tank_class();
      break;
    case "_encstr_88CC09377EA33BA181ED2E":
      give_crusader_class();
      break;
    case "_encstr_AB3508737F830710ACDB":
      give_assault_class();
      break;
    case "_encstr_A12707B8AB65E9A9C3":
      give_hunter_class();
    case "_encstr_8CFF09D56D88EC030D69EB":
      give_engineer_class();
      break;
  }
}

init_player_sessiondata() {
  var_0 = self;
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 1, 0);
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 2, 0);
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 3, 0);
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 4, 0);
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3A60DDC6DA56336FAC1EDA59BA337", 0);
}

randomize_player_sessiondata() {
  foreach(var_1 in level.players) {
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 1, randomint(5));
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 2, randomint(5));
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 3, randomint(5));
    var_1 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", 4, randomint(5));
  }
}

give_skill_points(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3A60DDC6DA56336FAC1EDA59BA337");
  self setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3A60DDC6DA56336FAC1EDA59BA337", var_1 + var_0);
}

take_skill_points(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3A60DDC6DA56336FAC1EDA59BA337");
  self setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3A60DDC6DA56336FAC1EDA59BA337", var_1 - var_0);
}

giveskillpointsthruluinotify(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_85E00C37B52D8D63D71B95EC951B", var_0);
  var_2 = self.skill_names[var_0 - 1];
  add_skill_point_to_skill(var_2, 1);
}

set_class_playerdata(var_0) {
  switch (var_0) {
    case "_encstr_AB3508737F830710ACDB":
      var_1 = 1;
      break;
    case "_encstr_8DEF05BDE933E0":
      var_1 = 2;
      break;
    case "_encstr_A6C7065BAC91D28D":
      var_1 = 3;
      break;
    case "_encstr_A12707B8AB65E9A9C3":
      var_1 = 4;
      break;
    default:
      var_1 = 0;
      break;
  }
}

reload_on_kill() {}

add_skill_point_to_skill(var_0, var_1) {}

debug_give_class(var_0) {
  give_player_class(var_0);
}

return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(var_0.weaponkitinitialized))
    var_0 waittill("_encstr_81BE245F04EF42BBEA8938A082827778BFB2655B6C83CEEF142381D84A9C09D09F54E34AFD2B");

  if(isDefined(var_0.weapon_build_models[var_1]))
    return asmdevgetallstates(var_0.weapon_build_models[var_1]);
  else
    return var_2;
}