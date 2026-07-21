/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\juggernaut_cp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_937E0B73A66F43570D3AD0A082", ::jugg_initconfig);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AC2B0A36CAD9B2368816D1B0", ::jugg_leveldata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D", ::jugg_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_9B511E42FB086CF705E96BA0904FC3264053DAEB29D033BBB601829A393F271C", ::jugg_registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AB591A0DA2CAD95D42AF80300B7A102BD10EFE03BAD34BE110D74858", ::jugg_dropcratefromscriptedheli);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8A4B0F5B0BB65949D576CE2B3937C257A3", ::jugg_makejuggernautcallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A6DE0C7758E8B1A105B436ADEAE0", ::jugg_watchpickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A1E713A78553194FA8808FC3DD4927CBF0E7EAB6AB", ::jugg_getmovespeedscalar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AB8015F3AB952FB39823AFBE1B41FA674D81291A1179F7", ::jugg_updatemovespeedscale);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549", ::jugg_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8331155EB60A41AB8947E8E00BF2036FE2DF4E500E13D9", ::jugg_cantriggerjuggernaut);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8C6F14129071CB5F8B67363F09A82359808D18EB5035", ::jugg_playoperatoruseline);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A3E5115F78581833C82D3178FE841059AFE858", ::vehicle_damage_setweaponclassmoddamageforvehicle);
}

vehicle_damage_setweaponclassmoddamageforvehicle() {
  return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

jugg_registeronplayerspawncallback(var_0) {}

jugg_dropcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

jugg_makejuggernautcallback(var_0, var_1) {
  return scripts\cp\cp_juggernaut::jugg_makejuggernaut(var_0, var_1);
}

jugg_initconfig(var_0) {
  return scripts\cp\cp_juggernaut::jugg_createconfig(var_0);
}

jugg_leveldata(var_0) {
  return scripts\cp_mp\killstreaks\airdrop::getleveldata(var_0);
}

jugg_watchpickup(var_0) {
  thread scripts\cp\cp_weapon::watchweaponpickup(var_0);
}

jugg_registeractionset() {
  scripts\mp\playeractions::registeractionset("_encstr_BD2C09BF097845B8ADDF97", ["_encstr_BD6B06A64C87A9E3", "_encstr_922406F1A6FD5E05", "_encstr_AF4D07932B1BDE5846"]);
}

juggernautweaponpickedup(var_0, var_1) {
  if(istrue(self.isjuggernaut)) {
    return;
  }
  if(isDefined(var_1) && isDefined(var_1.basename) && var_1.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB") {
    var_2 = weaponclipsize(var_1);
    self setweaponammoclip(var_1, var_2);
    return;
  }

  self.minigunprevweaponobject = var_1;
  self.playerstreakspeedscale = scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
  scripts\cp\cp_loadout::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("_encstr_BD2C09BF097845B8ADDF97", 0);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(0, "_encstr_BD2C09BF097845B8ADDF97");
    scripts\common\utility::allow_mount_side(0, "_encstr_BD2C09BF097845B8ADDF97");
  }

  self notifyonplayercommand("_encstr_9A361BFBC758CB067DD15334F19550F30FD23B40D0A0806030DAF41B12", "_encstr_81E10A4B8F483EAB573B2AE3");
  scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse(var_0, var_1);
}

jugg_getmovespeedscalar() {
  return scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
}

jugg_updatemovespeedscale() {
  scripts\cp\survival\survival_loadout::updatemovespeedscale();
}

jugg_allowactionset(var_0, var_1) {
  scripts\mp\playeractions::allowactionset(var_0, var_1);
}

jugg_decrementfauxvehiclecount() {}

jugg_incrementfauxvehiclecount() {}

jugg_cantriggerjuggernaut(var_0) {
  return 1;
}

jugg_playoperatoruseline(var_0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_97AD20E7728587D7A1A5406B53AB334A92A60C554CB2FDA380FB932B2982A89E0F69");
}