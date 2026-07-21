/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_public.gsc
***********************************************/

iswaitingtoentergulag(var_0) {
  return istrue(var_0.entergulagwait);
}

update_current_solution(var_0) {
  return istrue(var_0.set_relic_steelballs_perks);
}

use_csm(var_0) {
  return istrue(var_0.respawningfromtoken);
}

isplayeringulag() {
  var_0 = self;
  return isDefined(var_0) && (istrue(var_0.jailed) || istrue(var_0.gulagarena));
}

updateinstantclassswapallowedinternal() {
  var_0 = self;
  return isDefined(var_0) && (istrue(var_0.jailed) || istrue(var_0.gulagarena) || istrue(var_0.gulag));
}

_id_1443C() {
  var_0 = self;
  return isDefined(var_0) && istrue(var_0._id_14439);
}

_encstr_A5711EFBE72B193841670BA30E09C8C3620F457B4B42DE5878BA913B72E91888() {
  var_0 = self;
  return isDefined(var_0) && isDefined(var_0._id_12CA1) && var_0._id_12CA1 > 0;
}

unlockscriptabledoors() {
  var_0 = self;
  return (istrue(var_0.delay_enter_combat_after_investigating_grenade) && !isalive(var_0) || var_0 _id_125F3()) && !istrue(var_0.gulag);
}

_id_125F3() {
  return istrue(self.iszombie);
}

_id_125EC() {
  return istrue(self.unset_relic_gun_game) || istrue(self.scn_infil_tango_npc_2_sfx);
}

watchhealend() {
  self endon("_encstr_8BA809681DBE82C6920A0D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8216144C4EEBB0C9B6DB4EAFC1C6588E59FA91BDDCCA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  childthread heal_removeonplayernotifies();
  childthread heal_removeondamage();
}

heal_removeonplayernotifies() {
  self notifyonplayercommand("_encstr_A7121083C07A07DAABD775A1CE4B72C301D8", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommand("_encstr_A7121083C07A07DAABD775A1CE4B72C301D8", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_A7121083C07A07DAABD775A1CE4B72C301D8", "_encstr_977F0F954CE4B20BE8867D9B07935A37D1");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A7121083C07A07DAABD775A1CE4B72C301D8");
  healend();
}

heal_removeondamage() {
  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "_encstr_B607038AAB" && (var_4 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3" || var_4 == "_encstr_BDB50C41D83F8F9F030B60E80F5B")) {
      continue;
    }
    healend();
  }
}

healend() {
  self notifyonplayercommandremove("_encstr_A7121083C07A07DAABD775A1CE4B72C301D8", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommandremove("_encstr_A7121083C07A07DAABD775A1CE4B72C301D8", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommandremove("_encstr_A7121083C07A07DAABD775A1CE4B72C301D8", "_encstr_977F0F954CE4B20BE8867D9B07935A37D1");
  self notify("_encstr_8BA809681DBE82C6920A0D");
}

removeitemfrominventory(var_0) {
  self.br_inventory_slots[var_0] = undefined;
}

ishelmet(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_A7B606DA83796F4A" && issubstr(var_0, "_encstr_A6CC076A05751852B3");
}

isarmor(var_0) {
  return ishelmet(var_0);
}

isarmorplate(var_0) {
  return var_0 == "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
}

ishealitem(var_0) {
  return var_0 == "_encstr_A24A17AD169977A019271839B740631B21113730D0FA17A72B" || var_0 == "_encstr_B83C170E13BAB088A4F75CED772053C82882BBF633D8586311" || var_0 == "_encstr_BA4719B06BCC7047D359B3CD2EAA895817BF08889F96C9092A3D3D";
}

isequipment(var_0) {
  return isarmorplate(var_0) || ishealitem(var_0) || isDefined(level.br_pickups.br_itemtype[var_0]) && (level.br_pickups.br_itemtype[var_0] == "_encstr_B116071BCAD186858D" || level.br_pickups.br_itemtype[var_0] == "_encstr_99C209E34FC743616118AB");
}

isammo(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_B483058670B0B7";
}

_id_12518() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8C140CAFEF2FC261305972B65549")]]() || istrue(self.tracking_max_health))
    return 0;

  var_0 = self getcurrentweapon();

  if(nullweapon(var_0))
    return 0;

  return 1;
}

_id_12616(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = getcompleteweaponname(var_0);
  self giveandfireoffhand(var_2);
  wait(var_1);

  if(self hasweapon(var_2))
    self takeweapon(var_2);
}

hasrespawntoken() {
  var_0 = self;
  return istrue(var_0.hasrespawntoken);
}

_encstr_86D90E342CE676ABC6C29D3ABDD6B29B() {
  var_0 = self;
  return istrue(var_0._encstr_86D90E342CE676ABC6C29D3ABDD6B29B);
}

shouldgetnewspawnpoint() {
  var_0 = self;
  return istrue(var_0.shouldgetnewspawnpoint);
}

should_use_velo_forward() {
  var_0 = self;
  return istrue(var_0.should_use_velo_forward);
}

shouldlink() {
  var_0 = self;
  return istrue(var_0.should_enter_combat_after_checking_decoy_grenade);
}

should_damage_pavelow_boss(var_0) {
  var_1 = self;

  if(!isDefined(var_0) || !isDefined(var_1.armorylights))
    return isDefined(var_1.armorylights);
  else
    return var_0 == var_1.armorylights;
}

isusinginfilselection() {
  if(istrue(level.infilcanusemap)) {
    switch (level.infilselectionmethod) {
      case "_encstr_A3D70A2BF01B365D6EA5DB37":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

handleinfilspawnselectstart() {
  var_0 = level.infilselectionmethod;
  var_1 = getinfilspawnselectstartfunc(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  return level[[var_1]]();
}

handleinfilspawnselectend() {
  var_0 = level.infilselectionmethod;
  var_1 = getinfilspawnselectendfunc(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  return level[[var_1]]();
}

getinfilspawnselectstartfunc(var_0) {
  if(!isDefined(level.br_infillocationselectionhandlers))
    return undefined;

  var_1 = level.br_infillocationselectionhandlers[var_0];

  if(!isDefined(var_1))
    return undefined;

  return var_1.spawnselectstartfunc;
}

getinfilspawnselectendfunc(var_0) {
  if(!isDefined(level.br_infillocationselectionhandlers))
    return undefined;

  var_1 = level.br_infillocationselectionhandlers[var_0];

  if(!isDefined(var_1))
    return undefined;

  return var_1.spawnselectendfunc;
}

cleanac130struct(var_0) {
  if(isDefined(var_0.playerslot1)) {
    if(isDefined(var_0.playerslot1.head))
      var_0.playerslot1.head delete();

    if(isDefined(var_0.playerslot1.helmet))
      var_0.playerslot1.helmet delete();

    var_0.playerslot1 delete();
  }

  if(isDefined(var_0.playerslot2)) {
    if(isDefined(var_0.playerslot2.head))
      var_0.playerslot2.head delete();

    var_0.playerslot2 delete();
  }

  if(isDefined(var_0.playerslot3))
    var_0.playerslot3 delete();

  if(isDefined(var_0.playerslot4))
    var_0.playerslot4 delete();

  if(isDefined(var_0.aidoorchief))
    var_0.aidoorchief delete();

  if(isDefined(var_0.cameraent))
    var_0.cameraent delete();

  if(isDefined(var_0.gas_trigger))
    var_0.gas_trigger delete();

  if(isDefined(var_0.playerpositionents)) {
    foreach(var_2 in var_0.playerpositionents)
    var_2 delete();
  }

  if(isDefined(var_0.helicratedelete))
    var_0.helicratedelete delete();

  if(isDefined(var_0.staticc130) && istrue(var_0.staticc130.cleanme))
    var_0.staticc130 delete();

  if(isDefined(var_0.movingc130) && istrue(var_0.movingc130.cleanme)) {
    if(isDefined(var_0.movingc130.innards) && istrue(var_0.movingc130.innards.cleanme))
      var_0.movingc130.innards delete();

    var_0.movingc130 delete();
  }
}

turn_on_nearby_model_screen() {
  return level.stop_wave == 0;
}

tv_station_intro_already_played() {
  return level.stop_wave == 1;
}

usefailcapacitymsg() {
  return level.stop_wave == 2;
}

remove_old_wheelsons(var_0) {
  var_1 = 1;

  if(isDefined(var_0.infilanimindex))
    var_1 = var_0.infilanimindex;

  if(tv_station_intro_already_played()) {
    if(istrue(var_0.stop_counter_beep_sfx_on_bomb_vests)) {
      var_2 = "_encstr_A37F1AC62CADFADB9C315A8ED79893D7D81AB7E007564EAFE6F663DE";
      return var_2;
    } else {
      var_2 = "_encstr_8A13220BD7C81F85BD40DA03C1F5BA6761CB9F90F711634167E0032A23B7F263992B1D2A" + var_1;
      return var_2;
    }
  } else if(usefailcapacitymsg()) {
    if(istrue(var_0.stop_counter_beep_sfx_on_bomb_vests)) {
      var_2 = "_encstr_810B180A298F49C7DB96083388D2B397A72CE441FFD788C2AB77";
      return var_2;
    } else {
      var_2 = "_encstr_A71420DF58F807AA8556346BD04DB3FFC3E06F6B90166333D3FF7FA9AF69DA91A9B0" + var_1;
      return var_2;
    }
  } else {
    var_2 = "_encstr_9A561A6FC9FD592853B2A00B89FB5EA116235347202968E1473B3933" + var_1;
    return var_2;
  }
}

orbitcam(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(level.infil_vignette_anim_type) && level.infil_vignette_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    self.angles = var_0.angles;
    self playerlinkTo(var_0, "_encstr_B40101");
    self playerhide();
  }

  if(isDefined(level._id_142D1))
    scripts\mp\utility\player::_visionsetnaked(level._id_142D1, 0);
  else
    scripts\mp\utility\player::_visionsetnaked("_encstr_B40101", 0);

  self setplayerangles(var_0.angles);
  var_1 = remove_old_wheelsons(self);
  self cameraset(var_1);
}

_id_1264D() {
  var_0 = self;
  var_0 _meth_87A9();
}

updatebrscoreboardstat(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  switch (var_0) {
    case "_encstr_8AC70C0AB3C8245B35E562CB6895":
      [var_3, var_4, var_5] = [0, 8, 0];
      break;
    case "_encstr_ACF5089FF6827199725B":
      [var_3, var_4, var_5] = [0, 12, 0];
      break;
    case "_encstr_96220C63C85B92E005982F279019":
      [var_3, var_4, var_5] = [0, 16, 0];
      break;
    case "_encstr_AD4E116857C3E0D65F68B9EBB997BEC040CF6B":
      [var_3, var_4, var_5] = [0, 7, 1];
      break;
    case "_encstr_AB2A0F28DA4178ABF283F3F173FAF72005":
      [var_3, var_4, var_5] = [7, 1, 1];
      break;
    case "_encstr_AB7D11491E889F8289381AC25821725F430BDF":
      [var_3, var_4, var_5] = [0, 8, 2];
      break;
    case "_encstr_8AD9126BA5B96ED2B7E6DC68B7ADC1D82B47AC32":
      [var_3, var_4, var_5] = [8, 4, 2];
      break;
    case "_encstr_9538120198883B2B4B77B73836219379374A3295":
      [var_3, var_4, var_5] = [12, 4, 2];
      break;
    case "_encstr_A7B10CF1BFEA8F782D5FF9717D04":
      [var_3, var_4, var_5] = [0, 16, 3];
      break;
    case "_encstr_B4420F5BE2B3E3038D1F3D91BD7A6C3884":
    case "_encstr_B19909981F94202722E785":
    case "_encstr_92A1113B43C342E069FFF8BA6150C7731F928F":
    case "_encstr_A97810F553CDD025BAAB13DF566F519130B1":
    case "_encstr_A1500D40B22258CE7B07674D3F421C":
    case "_encstr_AD4109B11B2B0BDCAEE037":
    case "_encstr_BE100ED98B2A83683A92DDB0BB1E50B5":
      return;
    default:
      return;
  }

  var_2 packstatintoextrainfo(var_1, var_3, var_4, var_5);
}

packstatintoextrainfo(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = [var_4.extrascore0, var_4.extrascore1, var_4.extrascore2, var_4.extrascore3];
  var_6 = int(pow(2, var_2)) - 1;
  var_7 = (var_0 &var_6) << var_1;
  var_8 = ~(var_6 << var_1);
  var_9 = var_5[var_3];
  var_10 = var_9 &var_8;
  var_11 = var_10 + var_7;

  switch (var_3) {
    case 0:
      var_4.extrascore0 = var_11;
      break;
    case 1:
      var_4.extrascore1 = var_11;
      break;
    case 2:
      var_4.extrascore2 = var_11;
      break;
    case 3:
      var_4.extrascore3 = var_11;
      break;
    default:
      break;
  }
}

_encstr_ABB312D50723C247B21393B23CD1938523161D16(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  var_4 = 0;

  switch (var_0) {
    case "_encstr_A9B31537CAB1B21B8EB223B45AD8B1DC4739560BB6528C":
      [var_3, var_4] = [0, 4];
      break;
    case "_encstr_838F10072A626FE3F81390301FC39883BA53":
      [var_3, var_4] = [4, 4];
      break;
    default:
      return;
  }

  var_2 _encstr_AB2A160B5E6B503D02CBE3FB8B7BF078187333A1C4DEF060(var_1, var_3, var_4);
}

_encstr_AB2A160B5E6B503D02CBE3FB8B7BF078187333A1C4DEF060(var_0, var_1, var_2) {
  var_1 = 20 + var_1;

  if(var_1 + var_2 > 31) {
    return;
  }
  var_3 = int(pow(2, var_2)) - 1;
  var_4 = (var_0 &var_3) << var_1;
  var_5 = ~(var_3 << var_1);
  var_6 = self.game_extrainfo;
  var_7 = var_6 &var_5;
  var_8 = var_7 + var_4;
  self.game_extrainfo = var_8;
}

_id_1319E(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 512;
  else
    self.game_extrainfo = self.game_extrainfo &~512;
}

_id_1319C(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 1024;
  else
    self.game_extrainfo = self.game_extrainfo &~1024;
}

_id_131A6(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 2048;
  else
    self.game_extrainfo = self.game_extrainfo &~2048;
}

_id_131A4(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 8192;
  else
    self.game_extrainfo = self.game_extrainfo &~8192;
}

updatelootleadersonfixedinterval(var_0) {
  return isDefined(var_0.game_extrainfo) && var_0.game_extrainfo & 8192;
}

_id_1315C(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 16384;
  else
    self.game_extrainfo = self.game_extrainfo &~16384;
}

_id_1315B(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 32768;
  else
    self.game_extrainfo = self.game_extrainfo &~32768;
}

incrementplayersdownedstat() {
  var_0 = self;

  if(!isDefined(var_0.br_playersdowned))
    var_0.br_playersdowned = 0;

  var_0.br_playersdowned++;
  var_0 updatebrscoreboardstat("_encstr_BE100ED98B2A83683A92DDB0BB1E50B5", var_0.br_playersdowned);
  var_0 scripts\mp\utility\stats::incpersstat("_encstr_A9AB06297DDFD816", 1);
}

_encstr_886A17607773632913E797DB3201D7B05BF8132D27F36E2E07(var_0) {
  if(var_0 == 1) {
    self.game_extrainfo = self.game_extrainfo | 65536;
    self.game_extrainfo = self.game_extrainfo &~131072;
  } else if(var_0 == 2) {
    self.game_extrainfo = self.game_extrainfo &~65536;
    self.game_extrainfo = self.game_extrainfo | 131072;
  } else {
    self.game_extrainfo = self.game_extrainfo &~65536;
    self.game_extrainfo = self.game_extrainfo &~131072;
  }
}

_encstr_AA5F1AE33D032BDE67F8B27AC09352FF9B96706DCB6B1BE67BE01A92(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 262144;
  else
    self.game_extrainfo = self.game_extrainfo &~262144;
}

_encstr_925B180318D9F6AFE8A56B75B45343BE17E03BEB084B2CDB8180(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 524288;
  else
    self.game_extrainfo = self.game_extrainfo &~524288;
}

updatedragonsbreath() {
  var_0 = self;
  return istrue(var_0.tutorial_usingparachute) && var_0.game_extrainfo & 64;
}

dmztutdropcash(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"]) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(var_7 != var_2)
      dmztut_endgamewithreward(var_0, var_7, var_3, var_4, var_5);
  }
}

dmztut_luicallback(var_0, var_1, var_2, var_3, var_4, var_5) {
  brleaderdialog(var_0, var_2, level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"], var_5, var_3, var_4);
}

brleaderdialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  var_7 = level.players;

  if(isDefined(var_2))
    var_7 = var_2;

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_7[var_8];
    thread dmztut_endgamewithreward(var_0, var_9, var_1, var_3, var_4, var_5, var_6);
  }
}

_id_11C7D(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(istrue(var_1) && isplayeringulag())
    return 1;

  if(istrue(self._id_12742))
    return 1;

  if(tutorial_playSound()) {
    if(istrue(self._id_12749))
      return 1;

    if(var_0 == "_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46" || var_0 == "_encstr_A3710FE04ECADAB03A6C34AF56733A5627")
      return 1;

    if((var_0 == "_encstr_A6820FFF97DB9AAD5F1F66D06F42334847" || var_0 == "_encstr_99CB0DCCB44EB93AEB6C96C9B11B2B") && !istrue(level._id_126D5))
      return 1;
  }

  var_2 = level.maxteamsize == 1;

  if(var_2) {
    switch (var_0) {
      case "_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46":
        return 1;
    }
  }

  return 0;
}

disableannouncer(var_0) {
  var_1 = var_0.defaultoperatorteam;

  if(isai(var_0))
    var_1 = var_0.botoperatorteam;

  if(validtousesticker() || tutorial_playSound())
    var_1 = "_encstr_9A8507BA4040188D08";

  if(!isPlayer(var_0))
    var_1 = "_encstr_8E8405EA382B2A";

  return var_1;
}

dmztut_endgamewithreward(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isalive(var_1) && !istrue(var_3)) {
    return;
  }
  if(var_1 issplitscreenplayer() && !var_1 issplitscreenplayerprimary()) {
    return;
  }
  if(var_1 _id_11C7D(var_0, var_2)) {
    return;
  }
  if(validtousesticker() || tutorial_playSound()) {
    if(var_0 == "_encstr_A1D214DAD26EE62DB737EB378D169DEB161B36B21C8E" || var_0 == "_encstr_82011A6750A887DFEDF2B04051E4905D7DC13B87AD5B2CD743F428F0")
      return;
  }

  if(isDefined(var_6))
    var_7 = var_6;
  else if(var_1 scripts\cp_mp\utility\game_utility::_id_140A8())
    var_7 = "_encstr_B89B05311BD04E";
  else {
    var_8 = disableannouncer(var_1);
    var_7 = game["_encstr_8F8206ACFA5A81B5"][var_8];
  }

  var_9 = "_encstr_AB7508A1C157AA4A61C7" + var_7 + "_encstr_BA4C02DF" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];

  if(istrue(level.vehicle_collision_getleveldata)) {
    var_10 = "_encstr_8E750850F3A1BD3337D7" + var_7 + "_encstr_BA4C02DF" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];

    if(soundexists(var_10))
      var_9 = var_10;
  } else if(isDefined(level._encstr_A2080EB7CE2FF3259C8AF86812B43FA9)) {
    var_11 = "_encstr_AB7508A1C157AA4A61C7" + level._encstr_A2080EB7CE2FF3259C8AF86812B43FA9 + "_encstr_BA4C02DF" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];

    if(soundexists(var_11))
      var_9 = var_11;
  }

  if(isDefined(game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"]) && istrue(game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"][var_0]))
    var_9 = game["_encstr_B2DA070A5F8BAB87AF"][var_0];

  if(isDefined(var_9)) {
    var_9 = tolower(var_9);
    var_12 = lookupsoundlength(var_9, 1) / 1000.0;

    if(isDefined(var_4))
      wait(var_4);

    var_1 queuedialogforplayer(var_9, var_0, var_12);
  }
}

endgamevo(var_0, var_1) {
  game["_encstr_B2DA070A5F8BAB87AF"][var_0] = var_1;

  if(!isDefined(game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"]))
    game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"] = [];

  game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"][var_0] = 1;
}

uniquelootitemid() {
  return isDefined(level.script) && level.script == "_encstr_BD230AB50EBE26DAFA1D5D8E";
}

validtousesticker() {
  var_0 = getDvar("_encstr_8EF5100C8AE17CF33D30A25CE07C4FB57F90", "_encstr_93BA0B9A43E0DBCAA1891D041D");
  return isDefined(level.script) && (level.script == var_0 || level.script == "_encstr_993E0DDA88B71D8F16C682B7E57B1B");
}

tutorial_playSound() {
  return isDefined(level.script) && level.script == "_encstr_84E70D78D34F41EDF1A24D5F7AFB23";
}

uniquelootcallbacks() {
  return isDefined(level.script) && level.script == "_encstr_BAC50C3DA2912902F125EDCA575E";
}

turret_headicon() {
  return validtousesticker() || uniquelootitemid() || tutorial_playSound() || uniquelootcallbacks();
}

_id_12570() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = var_2.basename;

    if(weaponclass(var_2) == "_encstr_8D940738966ED1DB8D" && var_3 != "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C" && var_3 != "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1" && var_3 != "_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1" && var_3 != "_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB" && var_3 != "_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9" && var_3 != "_encstr_A10A211A6393EF8BD845C7C76BB01777D0D86242CE0583041051FFD51B885FB790F07B")
      return var_2;
  }
}

_id_126ED() {
  if(istrue(self._id_12875))
    self waittill("_encstr_87A218DB78315972CD07AA67FEB97B0D59E89F1FD8CBB4BAE9A5");
}

getinfilspawnoffset() {
  if(istrue(level.infilcanusemap))
    return getdvarfloat("_encstr_AD5B20B9D893D7DA2C83EBDCCA1B59D8A35ADBCDD71A595A3BA11DD7DE66339B2B8E", 2000);

  return getdvarfloat("_encstr_A3661BAB669BAF562D39FA93D041424B51D40E1F0CE1D75F19B1524A41", 12000);
}

_id_126B8(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = getinfilspawnoffset();

  var_2 = getdvarint("_encstr_BD7D1C16114E371E5BF1775362F86905216943C565A84F22D19BDFD3934C", 4500);

  if(var_2 >= 0) {
    var_3 = var_1 - var_2;
    var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var_0 = scripts\engine\utility::drop_to_ground(var_0, 0, -1 * var_3, undefined, var_4);
  }

  return var_0;
}

_id_126B9(var_0, var_1, var_2, var_3, var_4) {
  thread _id_126BA(var_0, var_1, var_2, var_3, var_4);
}

_id_126BA(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_B1D01CC11BB0CB95C9059356E6474E2BB05B89DE1B85A35AB773EAC2D2E8");
  self endon("_encstr_B1D01CC11BB0CB95C9059356E6474E2BB05B89DE1B85A35AB773EAC2D2E8");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_5 = !self calloutmarkerping_getEnt();

  if(!isDefined(var_1))
    var_1 = relic_nuketimer_gettimeformission();

  var_6 = gettime() + var_1;
  self._id_12875 = 1;

  if(!self ispredictedstreamposready())
    self clearpredictedstreampos();

  var_7 = gettime();

  if(var_5) {
    while(!istrue(self.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"]) && gettime() < var_6)
      waitframe();
  }

  self predictstreampos(var_0, 1);

  if(istrue(var_2))
    self loadcustomizationplayerview(self);

  if(var_5) {
    waitframe();

    while((!self ispredictedstreamposready() || istrue(var_2) && !self hasloadedcustomizationplayerview(self)) && gettime() < var_6)
      waitframe();

    if(istrue(var_3)) {
      var_9 = gettime() + getdvarint("_encstr_A5EA1EFB4EEA61AE83D757510B9A6788AFE420D0331F785B3B5B6B7F0B62B92B", 5000);

      while(gettime() < var_9)
        waitframe();
    }

    if(isDefined(var_4)) {
      var_10 = getdvarint("_encstr_8E4417ADACCA1CAF2CC6A56756FA5DE02358E859EB47B4B5CA", 2000);
      var_6 = gettime() + var_4;
      var_11 = 0;

      while(gettime() < var_6) {
        if(gettime() > var_11) {
          self predictstreampos(var_0, 1);
          var_11 = gettime() + var_10;
        }

        waitframe();
      }
    }
  }

  self._id_12875 = undefined;
  self notify("_encstr_87A218DB78315972CD07AA67FEB97B0D59E89F1FD8CBB4BAE9A5");
}

relic_nuketimer_gettimeformission() {
  return getdvarint("_encstr_AADF1B2B9E3AB17E73278781BB2A37F8FFB490CDC3AFA0A3FAD7879B5B", 9000);
}

_id_1252B() {
  self notify("_encstr_B1D01CC11BB0CB95C9059356E6474E2BB05B89DE1B85A35AB773EAC2D2E8");
  self clearpredictedstreampos();
}

_id_1264C() {
  self cancelmantle();

  if(self isskydiving())
    self skydive_interrupt();

  if(istrue(self.inlaststand))
    scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", self);

  if(isDefined(self.burninginfo))
    scripts\mp\equipment\molotov::molotov_clear_burning();

  if(istrue(self.usingascender))
    scripts\cp_mp\auto_ascender::canseesafecircleui();

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    var_0 = spawnStruct();
    var_0.allowairexit = 1;
    var_0.onprematchfadedone2 = "_encstr_B6690C29C959A78955E4A21449B2";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(self.vehicle, undefined, self, var_0, 1);
  }

  if(isDefined(self.remoteuav))
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();

  if(isDefined(self.currentturret))
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);

  if(isDefined(self.usingremote)) {
    var_1 = vehicle_getarray();

    foreach(var_3 in var_1) {
      if(isDefined(var_3.owner) && var_3.owner == self) {
        if(isDefined(var_3.helperdronetype))
          var_3 scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(1);
      }
    }
  }

  scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
}

_encstr_A7321A10206B3779A25B8D31E94F6753A2F25BEDD07F5D100E4C8723(var_0) {
  var_1 = undefined;
  var_1 = scripts\mp\class::preloadandqueueclass(var_0);
  return var_1;
}

forcedisablelaststand() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}

hasarmor() {
  return isDefined(self.br_armorhealth) && self.br_armorhealth > 0;
}

hashelmet() {
  return isDefined(self.br_helmetlevel);
}

damagearmor(var_0, var_1) {
  if(!hasarmor())
    return var_0;

  var_2 = int(min(self.br_armorhealth, var_0));
  var_3 = var_0 - var_2;
  var_4 = self.br_armorhealth / self.br_maxarmorhealth;
  self.br_armorhealth = self.br_armorhealth - var_2;
  scripts\cp\vehicles\vehicle_compass_cp::_id_12000(var_2);
  self.br_armorhealth = max(0, self.br_armorhealth);
  var_5 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    if(!istrue(var_1)) {
      if(self.br_armorhealth == 0 && var_2 > 0) {
        self playsoundtoplayer("_encstr_B17B1AC857E3D90A898228DD1389AF5F9E276E5A57DAE1D533C588CA", self);

        if(scripts\mp\utility\perk::_hasperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32"))
          self setscriptablepartstate("_encstr_82590C8593B5BD93D78993B20B6D", "_encstr_B879177D7AA950BA7AA66BFD99F87A25E757FAF9A1661F716A", 0);
        else
          self setscriptablepartstate("_encstr_82590C8593B5BD93D78993B20B6D", "_encstr_82590C8593B5BD93D78993B20B6D", 0);
      }
    }

    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", var_5);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    var_6 = spawnStruct();
    var_6.is_spawner_position_valid = var_2;
    var_6.isaccesscard = var_3;
    var_6.stack_patch_waittill_stack = var_1;
    _encstr_82D91946DDF83E5657A7C383859F33489CDF082F10E88BAAE24D36("_encstr_96D415F530CF7BE14B0DADB97525E093C9272847BF4D31", var_6);
  }

  return var_3;
}

ishelmetpopenabled() {
  if(getdvarint("_encstr_A39F12DB6ECA418EE3B70113533A45A04F02C033", 1))
    return 1;

  return 0;
}

breakhelmet() {
  self.br_helmetlevel = undefined;
}

damagehelmet(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !ishelmetpopenabled())
    var_1 = 0;

  var_3 = 1;

  switch (self.br_helmetlevel) {
    case 1:
      var_3 = 0.85;
      break;
    case 2:
      var_3 = 0.7;
      break;
    case 3:
      var_3 = 0.7;
      break;
    default:
  }

  if(var_1) {
    breakhelmet();

    if(isDefined(level._id_1203E))
      [[level._id_1203E]](self, var_2);
  }

  return var_3;
}

_id_1285E(var_0) {
  setglobalsoundcontext("_encstr_93FD0BEA50EDBEC7F624716C4D", "_encstr_AB0703DBB9", 3);

  if(!isDefined(level._id_133B4))
    level._id_133B4 = 1;

  level thread stop_priming_gesture();

  if(level.matchcountdowntime > 13) {
    var_1 = level.matchcountdowntime - 13;
    wait(var_1);
    var_2 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

    if(istrue(level.vehicle_collision_getleveldata))
      setmusicstate("_encstr_ABC514CA6795731D0C62AF36EDC4895EF57B573A39ED");
    else {
      var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_BD290F117B276128D62AB3875F7BB836BF"].size;

      foreach(var_5 in var_2) {
        if(isDefined(var_5)) {
          var_6 = randomint(var_3);
          var_5 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_BD290F117B276128D62AB3875F7BB836BF"][var_6]);
          var_5 setsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 8);
        }
      }
    }

    wait(level.matchcountdowntime);

    if(!istrue(level._encstr_87EA162B304EC14A7D03A5117933D39991F1DB9B30620532)) {
      foreach(var_5 in var_2) {
        if(isDefined(var_5))
          var_5 setplayermusicstate("_encstr_B40101");
      }
    }

    var_10 = istrue(level.br_infils_disabled);

    if(var_10) {
      foreach(var_5 in var_2) {
        if(isDefined(var_5))
          var_5 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
      }

      return;
    }
  } else {}
}

stop_priming_gesture() {
  if(istrue(level._encstr_8B1416EA6D71D42BA4B062591805078CF84F6371F9501FCB)) {
    return;
  }
  if(getdvarint("_encstr_8538150F67CB40E08A29692BDA10D183A28385AFFFA3BE", 0) == 1) {
    return;
  }
  level._encstr_8B1416EA6D71D42BA4B062591805078CF84F6371F9501FCB = 1;

  if(tv_station_intro_already_played()) {
    var_0 = level.matchcountdowntime + 1 + 3.5 - 1.0;

    if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death())
      var_0 = level.matchcountdowntime - 0.05;

    wait(var_0);
  } else if(usefailcapacitymsg()) {
    scripts\mp\utility\sound::besttime("_encstr_82510F061DBFE7E00CEF54A79B406BF8F8");
    var_0 = level.matchcountdowntime + 1 + 3.5;
    wait(var_0);
  } else {
    var_0 = level.matchcountdowntime + 1 + 3.5;
    wait(var_0);
  }

  waittillframeend;
  level._encstr_87EA162B304EC14A7D03A5117933D39991F1DB9B30620532 = 1;

  foreach(var_2 in level.players) {
    var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_82A30F380BF9E3F8A32971E031DBE39D5D"].size;
    var_4 = randomint(var_3);
    var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_82A30F380BF9E3F8A32971E031DBE39D5D"][var_4];
    var_2 setplayermusicstate(var_5);
  }

  wait 24.0;
  level._encstr_87EA162B304EC14A7D03A5117933D39991F1DB9B30620532 = undefined;
  level._encstr_8B1416EA6D71D42BA4B062591805078CF84F6371F9501FCB = undefined;
}

_id_12854(var_0) {
  if(validtousesticker()) {
    return;
  }
  if(level.matchcountdowntime > 3) {
    var_1 = level.matchcountdowntime - 3;
    wait(var_1);
    dmztut_luicallback("_encstr_878B0D2B0D55328178B9D41111C0CC", var_0);
  }
}

loadoutcustomfiresalediscount(var_0) {
  if(!getdvarint("_encstr_8176204F98CBD78B7525C5FE957F428F51A0378F08A025A1A343CF767D096A77F8C8", 1)) {
    return;
  }
  if(istrue(level._id_12856)) {
    return;
  }
  level._id_12856 = 1;
  var_1 = getdvarint("_encstr_BA2D26DC1B9CFA0E39ACADB0A3B11A7D232D6E85C43659BEACF0ACB1BA475ADE37F598D56633959C", 2);
  var_2 = level.players;
  var_3 = ["_encstr_880811DD703AAFCB14FF28383F59A3C902DE42", "_encstr_B24E11E8C140668309413A234F0BE9176B9185"];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 scripts\common\utility::allow_array(var_3, 0);
  }

  wait(var_0 + var_1);

  foreach(var_5 in var_2) {
    if(!isDefined(var_5) || var_5 scripts\common\utility::can_execute()) {
      continue;
    }
    var_5 scripts\common\utility::allow_array(var_3, 1);
  }

  level._id_12856 = undefined;
}

calculateeventstarttime() {
  if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 0) {
    return;
  }
  var_0 = 5;
  var_1 = level.matchcountdowntime - var_0;

  if(var_1 > 0)
    wait(var_1);

  foreach(var_3 in level.players)
  var_3.plotarmor = 1;

  level thread loadoutcustomfiresalediscount(var_0);
}

delay_then_run_wave_override() {
  var_0 = self;
  var_0 damagearmor(150, 1);
}

defend_wave_1() {
  if(!_encstr_87F318502B87EB09FB450E8D2DEB71AD6DD2B018939E39E3976A("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE")) {
    level endon("_encstr_9B1D0BC7932875276230426AA1");
    var_0 = getdvarint("_encstr_93B513573F9318A8B211CD38448170504A8FF1FBAF", 30);
    wait(var_0);
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    level.nojip = 1;
  }
}

_id_12A1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\trace::ray_trace(var_0 + (var_1, var_2, var_3), var_0 + (var_1, var_2, var_4), var_6, var_5);
  return var_7;
}

reset_button_init(var_0, var_1) {
  if(!isDefined(level.cratedata) || !isDefined(level.cratedata.crates)) {
    return;
  }
  var_2 = var_1 * var_1;
  var_3 = [];

  foreach(var_5 in level.cratedata.crates) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = distance2dsquared(var_5.origin, var_0);

    if(var_6 < var_2)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

semtex_used() {
  var_0 = 4000;

  if(isDefined(level.br_level) && isDefined(level.br_level.spawn_exfil_enemies))
    var_0 = level.br_level.spawn_exfil_enemies;

  return var_0;
}

send_all_ai_to_players() {
  var_0 = -1200;

  if(isDefined(level.br_level) && isDefined(level.br_level._id_11A5B))
    var_0 = level.br_level._id_11A5B;

  return var_0;
}

modifyplayer_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = modifyscenenode(var_0, var_1, var_2, var_3, var_4);
  return var_5["_encstr_BD260953AA97E3F014279D"];
}

modifytriggerlocation(var_0, var_1, var_2, var_3, var_4) {
  var_5 = modifyscenenode(var_0, var_1, var_2, var_3, var_4);
  return var_5;
}

modifyscenenode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = send_all_ai_to_players();
  var_6 = semtex_used();
  var_7 = 2500;
  var_8 = -19000 + var_5;
  var_9 = 15;

  if(!isDefined(var_1))
    var_1 = getdvarint("_encstr_828B109B2E8A01CE2377F9FDA71A85B92542", var_7);

  if(!isDefined(var_2))
    var_2 = getdvarint("_encstr_8FC712B98DE4F526E4BE47932C1B59BE8CF6BBE6", var_8);

  var_10 = getdvarint("_encstr_888C11E6D8E47D13937DD127B08DCAD7B1B7DD", var_5);
  var_11 = getdvarint("_encstr_BD621293CA3358E072B7093DB11E90AF03026978", var_6);
  var_12 = undefined;

  if(isDefined(var_3))
    var_12 = var_3;
  else
    var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);

  if(!isDefined(var_4))
    var_4 = [];

  var_13 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  if(isDefined(var_13.instancesbyref["_encstr_9A8F0CB1A5E8471BB2EB894B39C8"]))
    var_4 = scripts\engine\utility::array_combine(var_4, var_13.instancesbyref["_encstr_9A8F0CB1A5E8471BB2EB894B39C8"]);

  if(isDefined(var_13.instancesbyref["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"]))
    var_4 = scripts\engine\utility::array_combine(var_4, var_13.instancesbyref["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"]);

  var_14 = reset_button_init(var_0, 100);

  if(isDefined(var_14) && var_14.size > 0)
    var_4 = scripts\engine\utility::array_combine(var_4, var_14);

  if(getdvarint("_encstr_BDF91D5B966B5F86FDE94B23F037BFA7E00CDECFB6D117CE8348D20A981572", 1) > 0) {
    var_15 = _encstr_AD091B2A80DB08ED6FD34852AB3A73C0D8D81B065725DDC86DF8932790(var_0, 100);

    if(var_15.size > 0)
      var_4 = scripts\engine\utility::array_combine(var_4, var_15);
  }

  var_16 = _id_12A1C(var_0, 0, 0, var_1, var_2, var_12, var_4);

  if(_id_13C32(var_16, var_10))
    return var_16;

  var_16 = _id_12A1C(var_0, var_9, 0, var_1, var_2, var_12, var_4);

  if(_id_13C32(var_16, var_10))
    return var_16;

  var_16 = _id_12A1C(var_0, 0, var_9, var_1, var_2, var_12, var_4);

  if(_id_13C32(var_16, var_10))
    return var_16;

  var_16 = _id_12A1C(var_0, -1 * var_9, 0, var_1, var_2, var_12, var_4);

  if(_id_13C32(var_16, var_10))
    return var_16;

  var_16 = _id_12A1C(var_0, 0, -1 * var_9, var_1, var_2, var_12, var_4);

  if(_id_13C32(var_16, var_10))
    return var_16;

  var_16 = [];
  var_16["_encstr_BD260953AA97E3F014279D"] = (var_0[0], var_0[1], var_11);
  var_16["_encstr_A53009A25003666B9818C6"] = 0;
  return var_16;
}

_id_13C32(var_0, var_1) {
  return var_0["_encstr_A53009A25003666B9818C6"] != 1 && var_0["_encstr_BD260953AA97E3F014279D"][2] > var_1;
}

_encstr_AD091B2A80DB08ED6FD34852AB3A73C0D8D81B065725DDC86DF8932790(var_0, var_1) {
  var_2 = [];

  if(isDefined(level._id_13400)) {
    var_3 = var_1 * var_1;

    foreach(var_5 in level._id_13400.areas_remaining) {
      if(isDefined(var_5.chopperexfil_sfx_before_sh070)) {
        var_6 = distance2dsquared(var_0, var_5.chopperexfil_sfx_before_sh070.origin);

        if(var_6 < var_3)
          var_2[var_2.size] = var_5.chopperexfil_sfx_before_sh070;
      }
    }
  }

  return var_2;
}

timeoutonabandonedcallback() {
  if(!getdvarint("_encstr_82661D7316DA2EBA482930A7D773CBA761B932E0E37C09EA651F16A859575D", 1)) {
    return;
  }
  if(self.triggertype == "_encstr_83650AB19BA26B100D3CE35A" && !self.usetime) {
    self.touchlist = [];
    self.touchlist["_encstr_A7A408B9CA5D1D4E2C63"] = [];
    self.touchlist["_encstr_8BBA05185F8B99"] = [];
    self.assisttouchlist = undefined;
  }
}

_id_1266C(var_0, var_1) {
  var_2 = self calloutmarkerping_entityzoffset("_encstr_92BC12C8FB0923AB679843C46D83F6E52D5268F8");

  if(istrue(var_1))
    var_2 = var_2 | var_0;
  else
    var_2 = var_2 &~var_0;

  self setclientomnvar("_encstr_92BC12C8FB0923AB679843C46D83F6E52D5268F8", var_2);
}

_id_125CF(var_0) {
  _id_1266C(1, var_0);
}

round_enemy_stuck_logic(var_0, var_1) {
  if(scripts\mp\menus::_id_13733()) {
    if(!isDefined(var_1) && scripts\mp\menus::brking_updateteamscore())
      return [];
    else
      return level.squaddata[var_0][var_1].players;
  } else
    return level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];
}

rotationrefsbyseatandweapon(var_0, var_1) {
  if(scripts\mp\menus::_id_13733()) {
    var_2 = [];

    foreach(var_4 in level.squaddata[var_0][var_1].players) {
      if(isalive(var_4))
        var_2[var_2.size] = var_4;
    }

    return var_2;
  } else
    return level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];
}

rotationids(var_0, var_1) {
  if(scripts\mp\menus::_id_13733()) {
    var_2 = 0;

    foreach(var_4 in level.squaddata[var_0][var_1].players) {
      if(isalive(var_4))
        var_2++;
    }

    return var_2;
  } else
    return level.teamdata[var_0]["_encstr_8A2A0B936CCCC3078547970A8B"];
}

round_enemies_fallback_logic(var_0) {
  if(scripts\mp\menus::_id_13733())
    return getarraykeys(level.squaddata[var_0]);
  else
    return [0];
}

replace_sat_piece_on_deathordisconnect() {
  if(scripts\mp\menus::_id_13733())
    return level.maxsquadsize;
  else
    return level.maxteamsize;
}

_id_131C3(var_0, var_1, var_2, var_3) {
  if(scripts\mp\menus::_id_13733()) {
    if(!isDefined(level.squaddata[var_0][var_1].difficultytabledata))
      level.squaddata[var_0][var_1].difficultytabledata = [];

    level.squaddata[var_0][var_1].difficultytabledata[var_2] = var_3;
  } else
    level.teamdata[var_0][var_2] = var_3;
}

round_at_max(var_0, var_1, var_2) {
  if(scripts\mp\menus::_id_13733()) {
    if(!isDefined(level.squaddata[var_0][var_1].difficultytabledata) || !isDefined(level.squaddata[var_0][var_1].difficultytabledata[var_2])) {
      return;
    }
    return level.squaddata[var_0][var_1].difficultytabledata[var_2];
  } else
    return level.teamdata[var_0][var_2];
}

_id_1276A(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\menus::_id_13733()) {
    var_5 = round_enemy_stuck_logic(var_2.team, var_2.squadindex);

    foreach(var_7 in var_5) {
      if(!isDefined(var_3) || var_7 != var_3)
        self playsoundtoplayer(var_0, var_7, var_4);
    }
  } else
    self playsoundtoteam(var_0, var_1, var_3, var_4);
}

updatesquadmemberlaststandreviveprogress(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_1[0], var_1[1], 0);
  var_5 = (var_2[0], var_2[1], 0);
  var_6 = vectorNormalize(var_3 - var_4);
  var_7 = vectorNormalize(var_5 - var_4);
  var_8 = vectordot(var_6, var_7);
  return var_8 > 0;
}

woods_two_death_func(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0] - var_2[0];
  var_5 = var_0[1] - var_2[1];
  var_6 = var_1[0] - var_2[0];
  var_7 = var_1[1] - var_2[1];
  var_8 = float(var_3);
  var_9 = var_6 - var_4;
  var_10 = var_7 - var_5;
  var_11 = var_9 * var_9 + var_10 * var_10;
  var_12 = var_4 * var_7 - var_6 * var_5;
  var_13 = var_8 * var_8 * var_11 - var_12 * var_12;

  if(var_13 < 0)
    return;
  else if(var_13 == 0) {
    var_14 = var_12 * var_10 / var_11 + var_2[0];
    var_15 = -1 * var_12 * var_9 / var_11 + var_2[1];
    return (var_14, var_15, 0);
  } else {
    var_16 = sqrt(var_13);
    var_17 = var_12 * var_10;
    var_18 = scripts\engine\utility::sign(var_10) * var_9 * var_16;
    var_19 = (var_17 + var_18) / var_11 + var_2[0];
    var_20 = (var_17 - var_18) / var_11 + var_2[0];
    var_21 = -1 * var_12 * var_9;
    var_22 = abs(var_10) * var_16;
    var_23 = (var_21 + var_22) / var_11 + var_2[1];
    var_24 = (var_21 - var_22) / var_11 + var_2[1];
    return [(var_19, var_23, 0), (var_20, var_24, 0)];
  }
}

registersuperextraweapon(var_0, var_1, var_2) {
  var_3 = woods_two_death_func(var_0, var_1, var_2.origin, var_2.radius);

  if(!isDefined(var_3))
    return;
  else if(!isarray(var_3)) {
    if(updatesquadmemberlaststandreviveprogress(var_3, var_0, var_1))
      return var_3;
  } else {
    var_4 = updatesquadmemberlaststandreviveprogress(var_3[0], var_0, var_1);
    var_5 = updatesquadmemberlaststandreviveprogress(var_3[1], var_0, var_1);

    if(!var_4 && !var_5)
      return;
    else if(var_4 && !var_5)
      return var_3[0];
    else if(var_5 && !var_4)
      return var_3[1];
    else {
      var_6 = distance2dsquared(var_0, var_3[0]);
      var_7 = distance2dsquared(var_0, var_3[1]);

      if(var_6 < var_7)
        return var_3[0];
      else
        return var_3[1];
    }
  }
}

safehouse_struct(var_0, var_1, var_2) {
  var_3 = var_1[0] - var_0[0];
  var_4 = var_1[1] - var_0[1];
  var_5 = var_1[2] - var_0[2];

  if(var_3 != 0)
    var_6 = (var_2[0] - var_0[0]) / var_3;
  else
    var_6 = (var_2[1] - var_0[1]) / var_4;

  var_7 = var_0[2] + var_5 * var_6;
  return var_7;
}

updaterectangularzone(var_0, var_1) {
  var_2 = var_1.origin[2];
  var_3 = var_2 + var_1.height;
  return var_0[2] >= var_2 && var_0[2] <= var_3;
}

registertabletinit(var_0, var_1, var_2) {
  var_3 = woods_two_death_func(var_0, var_1, var_2.origin, var_2.radius);

  if(!isDefined(var_3))
    return;
  else if(!isarray(var_3)) {
    if(updatesquadmemberlaststandreviveprogress(var_3, var_0, var_1)) {
      var_4 = safehouse_struct(var_0, var_1, var_3);
      var_3 = (var_3[0], var_3[1], var_4);

      if(updaterectangularzone(var_3, var_2))
        return var_3;
    }
  } else {
    var_5 = updatesquadmemberlaststandreviveprogress(var_3[0], var_0, var_1);
    var_6 = updatesquadmemberlaststandreviveprogress(var_3[1], var_0, var_1);

    if(!var_5 && !var_6)
      return;
    else if(var_5 && !var_6) {
      var_4 = safehouse_struct(var_0, var_1, var_3[0]);
      var_3[0] = (var_3[0][0], var_3[0][1], var_4);

      if(updaterectangularzone(var_3[0], var_2))
        return var_3[0];
    } else if(var_6 && !var_5) {
      var_4 = safehouse_struct(var_0, var_1, var_3[1]);
      var_3[1] = (var_3[1][0], var_3[1][1], var_4);

      if(updaterectangularzone(var_3[1], var_2))
        return var_3[1];
    } else {
      var_4 = safehouse_struct(var_0, var_1, var_3[0]);
      var_3[0] = (var_3[0][0], var_3[0][1], var_4);
      var_7 = updaterectangularzone(var_3[0], var_2);
      var_4 = safehouse_struct(var_0, var_1, var_3[1]);
      var_3[1] = (var_3[1][0], var_3[1][1], var_4);
      var_8 = updaterectangularzone(var_3[1], var_2);

      if(!var_7 && !var_8)
        return;
      else if(var_7 && !var_8)
        return var_3[0];
      else if(var_8 && !var_7)
        return var_3[1];
      else {
        var_9 = distance2dsquared(var_0, var_3[0]);
        var_10 = distance2dsquared(var_0, var_3[1]);

        if(var_9 < var_10)
          return var_3[0];
        else
          return var_3[1];
      }
    }
  }
}

_id_12A18(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = registersuperextraweapon(var_0, var_1, var_5);

    if(isDefined(var_6))
      var_3[var_3.size] = var_6;
  }

  var_8 = undefined;
  var_9 = 0;

  foreach(var_6 in var_3) {
    var_11 = distance2dsquared(var_0, var_6);

    if(!isDefined(var_8) || var_11 < var_9) {
      var_8 = var_6;
      var_9 = var_11;
    }
  }

  return var_8;
}

_id_12A19(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = registertabletinit(var_0, var_1, var_5);

    if(isDefined(var_6))
      var_3[var_3.size] = var_6;
  }

  var_8 = undefined;
  var_9 = 0;

  foreach(var_6 in var_3) {
    var_11 = distancesquared(var_0, var_6);

    if(!isDefined(var_8) || var_11 < var_9) {
      var_8 = var_6;
      var_9 = var_11;
    }
  }

  return var_8;
}

nuke_vault_suicidebombers() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6() {
  return getdvarint("_encstr_B65823F8EF12B69D73997F096BCAE9B97A8740405FE7494FBA7FE006462357E1C35F58F0FF", 0) != 0;
}

_encstr_82D91946DDF83E5657A7C383859F33489CDF082F10E88BAAE24D36(var_0, var_1, var_2) {
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret._id_12E05))
    return [[level.disable_super_in_turret._id_12E05]](var_0, var_1, var_2);
}

_encstr_83F31F44A6E5034F0158AF93805B050A93B04EBF05054A9EA938EF836873E8E235(var_0) {
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.tutorial_showtext))
    return [[level.disable_super_in_turret.tutorial_showtext]](var_0);

  return 0;
}

_encstr_87F318502B87EB09FB450E8D2DEB71AD6DD2B018939E39E3976A(var_0) {
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.unset_relic_aggressive_melee_params))
    return [[level.disable_super_in_turret.unset_relic_aggressive_melee_params]](var_0);

  return 0;
}

gunship_spawnvfx() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level.gametype == "_encstr_B607038AAB") {
    wait 0.1;

    if(!isDefined(level.debugforcesre2))
      level.debugforcesre2 = "_encstr_AD1D06499A573833";

    self setscriptablepartstate(level.debugforcesre2, "_encstr_9A5007A9E5275F8ACA");
  } else {
    var_0 = level._effect["_encstr_A14018B3CCF0AFCDE60B3A8DA17D5836139981F51B8DDEBA23DC"];

    if(!isDefined(var_0)) {
      return;
    }
    wait 0.1;
    playFXOnTag(var_0, self, "_encstr_8F1E092CC9F71178C01941");
  }
}

makepathstruct(var_0) {
  var_1 = var_0.r;
  var_2 = var_0.randomangle;
  var_3 = var_0.endangleoffset;
  var_4 = var_0.centerpt;
  var_5 = (var_2 + var_3) % 360;
  var_6 = (var_1 * cos(var_2), var_1 * sin(var_2), scripts\cp_mp\parachute::getc130height()) + var_4;
  var_7 = (var_1 * cos(var_5), var_1 * sin(var_5), scripts\cp_mp\parachute::getc130height()) + var_4;
  var_8 = vectorNormalize(var_7 - var_6);
  var_7 = var_7 + var_8 * var_1;
  var_6 = var_6 - var_8 * var_1 * 2;
  var_9 = spawnStruct();
  var_9.startpt = var_6;
  var_9.endpt = var_7;
  var_9.angle = vectortoangles(var_8);
  return var_9;
}

calctrailpoint() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}