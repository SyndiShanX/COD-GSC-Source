/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58312.gsc
***********************************************/

teamplunderexfiltimer() {
  if(isDefined(level.deposit_from_compromised_convoy_delayed)) {
    return;
  }
  level.disable_oob_immunity_on_riders = 1;
  level.deposit_from_compromised_convoy_delayed = spawnStruct();
  level.deposit_from_compromised_convoy_delayed._id_12010 = undefined;
  level.deposit_from_compromised_convoy_delayed._id_12011 = undefined;
  level.deposit_from_compromised_convoy_delayed._id_1201E = undefined;
  level.deposit_from_compromised_convoy_delayed._id_1363D = [];
  level.deposit_from_compromised_convoy_delayed.bisdeaf = ["_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B", "_encstr_87FF21A892BB77E3CFDD8875BD3F0E2923F908B8C997AB3B3FC18060899B53EB8E62E0", "_encstr_BACB074025B01AAA28"];
  level.deposit_from_compromised_convoy_delayed ambush_lmg_guy();
  allammoboxes();
  allassassin_getsortedteams();
  all_players_within_distance2d_and_below_height();
  scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
}

ambush_lmg_guy() {
  foreach(var_1 in level.deposit_from_compromised_convoy_delayed.bisdeaf) {
    _id_12B0B(var_1, ::binoculars_watchracelaststand);
    _id_12B0C(var_1, ::binoculars_watchracetake);
    _id_12B0D(var_1, ::binocularsinited);
  }
}

all_players_within_distance2d_and_below_height() {
  anim.grenadetimers["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(0, 20000);
}

allammoboxes() {
  var_0 = [["_encstr_B24D129758A8476BEF0CE91F73B9A21F13C02713", "_encstr_BA9E2FD9331E5E2D770E798DBD4E9579B5F6D87BE8DED9CB67CC1EBEADDB8D7B47B7ECAFB2C30EC67B372D7B37C5CE333C"], ["_encstr_93D018C3770D6835B76316596B23E1B062D97F4DDFB618F3835A", "_encstr_812D350357A8AA63AB02B7374723BD6245EDC8B87B173808D3531147A7DA7118F4457336A758C0517A7F0BDF93A1CEE8B11DB9A00BAE38"], ["_encstr_A6D9117BD1235FBE80D5561FAF3845174168E3", "_encstr_83C436CE33C3792DEEC197EE562C83BCBECC5A39B2E5B5BDD8BDA3BDCE79B3993CEB6BD1EDB3EBF6371D2C9DAFE6B563AF8DF6DDE2EC330F"], ["_encstr_A9261235E93AAF299F2B703FC305248950792F30", "_encstr_8A14371E546ADE04B792BE3310F33AA6E6CC99927D581F4D591013CA9057734BBA38152C80DB8F1575204A42F107ED3BB61B69B7ABA8E39F21"], ["_encstr_8E7C16CE991EBEC4BAC9377D6E6B8DEB43562C32FA8DEDDD", "_encstr_AF7837484D50F852633885E7A5707806F72020831D0DC29F18A7B3AF33D28CC468513FD870ED87E09D1B32DF8028591F6A68B25743B6054E5B"], ["_encstr_83E7116D1B032898E50A504EF5DDE0601A5717", "_encstr_AA83364E5B1227BC978A673725FE735768303B7E31963DC5A84A1B22B34D036C9028F5A8F70477B0D82B0798BED570474105A05060A02232"], ["_encstr_8666129DCCF0F598AE27CDFAADB28C7D43A5D9A1", "_encstr_8FD637EBD85BF7A0636A9F83206120504F32F8A237CF4578B10D6BC7CB4ADBDCF351483D48CE1F280E8327072952425009B808C07802AE7413"], ["_encstr_8848113B99F0BE89AEC99BBE63279DBEB1B777", "_encstr_B2DA362B63B9A69F8F41D0034B425FDA3978C8F8D5557DB0255801257BC065E48371F3D30595B0B0CD98518776CA7E609F248F4045237608"], ["_encstr_B183124863801E35BB7AE878D5E37746C837B830", "_encstr_86D8373BCCF0F24B7770BCBB95C238CBFACCD2E4B2CBDA7B63F6A3B7CEE5ECCC877DB53ADB3BEBDECD8E2CD9D78D93B37DD05A76D017B3661E"]];

  if(!isDefined(level.g_effect))
    level.g_effect = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(level.g_effect[var_0[var_1][0]]))
      level.g_effect[var_0[var_1][0]] = loadfx(var_0[var_1][1]);
  }
}

allassassin_getsortedteams() {
  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
}

spawnnewagent(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = "_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B";

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_4))
    var_4 = "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";

  var_5 = scripts\mp\mp_agent::spawnnewagent(var_3, var_4, var_0, var_1);

  if(!isDefined(var_5)) {
    return;
  }
  var_5.guid = var_5 getguid();
  var_5 ammobox_getbufferedattachmentsourceweapon();
  var_5 thread alwaysdoskyspawnontacinsert();
  var_5 thread activeparachutersfactionvo();
  var_5 scriptablecount("_encstr_95650DDC1AEB2CC9F5CEF69BB1B0E4");
  var_5 thread activestate();

  if(var_2)
    var_5 scriptable_token_scriptable_touched_callback(250);

  level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_add(level.deposit_from_compromised_convoy_delayed._id_1363D, var_5);
  return var_5;
}

_encstr_A6F91493F823E363F83FB31A38F046E2B50B845F9B93(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = "_encstr_82211847D8F76D034FC17371D25A8D1A23D5E1D1B5F893ABAB53";

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_5))
    var_5 = "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";

  var_6 = access_card::_id_146FA(var_3, var_0, var_1, undefined, var_4);

  if(!isDefined(var_6)) {
    return;
  }
  var_6.guid = var_6 getguid();
  var_6 thread activeparachutersfactionvo();
  var_6._encstr_846A1D03EF69CF5B5F69EFF17AD0B75B96B8FE375807E140C9EBCE63C7721E = 1;

  if(var_2)
    var_6 scriptable_token_scriptable_touched_callback(250);

  level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_add(level.deposit_from_compromised_convoy_delayed._id_1363D, var_6);
  return var_6;
}

_encstr_82F017C37BFB3B65E0678B7040137ED62AE87385A8FF8A3D93(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = "_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B";

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_4))
    var_4 = "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";

  var_5 = spawnnewagent(var_0, var_1, var_2, var_3, var_4);
  var_5 hide();
  var_5[[level._encstr_A3271AA18AE35EF88534999B25AAA8AFDB1299E883131D9B9A11B79D]](var_0);
  return var_5;
}

ammobox_getbufferedattachmentsourceweapon() {
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
  self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;
  self.pers["_encstr_8305198D5D93D7AD5AD8B1F5B93A9C5616D6BE33BD937DE6ABB6CA"] = 0;
  self.tookweaponfrom = [];
  self.killedplayers = [];
  self._id_1407D = 0;
  self.name = "_encstr_AFF607C2396563C319" + self.entity_number;
  self.scripted_long_deaths = 0;
  self.agentdamagefeedback = 1;
  self.maxhealth = 100;
  self.health = 100;
  self.health_remaining = 100;
  self.showseasonalcontent = 100;
  self.showsplashtoall = 100;
  self.meleedamageoverride = 25;
  self.baseaccuracy = 0.35;
  self.circleclosestarttime = spawnStruct();
  self.circleclosestarttime.maxhealth = self.maxhealth;
  self.circleclosestarttime.meleedamageoverride = self.meleedamageoverride;
  self.circleclosestarttime.baseaccuracy = self.baseaccuracy;
}

activestate() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }
    scripts\mp\weapons::grenadeinitialize(var_0, var_1, var_2, var_3);
    self notify("_encstr_97E30EEC9359DC0B19ACBE47D027BDDD");

    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(var_0.weapon_name)) {
      return;
    }
    var_0.spawnpos = var_0.origin;

    switch (var_0.weapon_name) {
      case "_encstr_BA730BF8AFF178988293F158B9":
        thread scripts\mp\equipment\molotov::molotov_used(var_0);
        break;
      case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
        thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
        wait 0.1;
        var_0 notify("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
        break;
    }
  }
}

scriptable_token_scriptable_touched_callback(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::teamfriendlyto();
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
    ammobox_canweaponuserandomattachments(var_0);
  }
}

scriptablecount(var_0, var_1) {
  self.weapon = scripts\mp\class::buildweapon(var_0, ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;

  if(!scripts\common\utility::isweaponinitialized(self.primaryweapon))
    scripts\common\utility::initweapon(self.primaryweapon);

  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::attachweapon(self.primaryweapon, "_encstr_8253060E2B5FE330");
}

scriptable_used_by_part_funcs(var_0, var_1) {
  if(!isDefined(self.grenadeweapon) || self.grenadeweapon.basename != var_0)
    self.grenadeweapon = getcompleteweaponname(var_0);

  self.grenadeammo = var_1;
}

alwaysdoskyspawnontacinsert() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(randomfloatrange(1.25, 2.75));
  scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest(self);
  scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent("_encstr_ACA20538F84D39", "_encstr_82EE0B8DE82C13A2187BCEFE14", anim.player);
}

ammobox_canweaponuserandomattachments(var_0) {
  if(!isDefined(var_0) || var_0 < 0) {
    return;
  }
  self.br_maxarmorhealth = var_0;
  self.br_armorhealth = var_0;
  var_1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", var_1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  }
}

_encstr_9B371226C7DB5B79F5332010F710509B522D1D23(var_0) {
  self.maxhealth = var_0;
  self.health = var_0;
}

_id_13122(var_0) {
  self.baseaccuracy = var_0;
}

_id_13123(var_0) {
  self.meleedamageoverride = var_0;
}

relic_mythic_next_pain_time() {
  return self.enemy;
}

activeparachutersfactionvo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_remove(level.deposit_from_compromised_convoy_delayed._id_1363D, self);
}

_id_12B0B(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.agent_funcs)) {
    return;
  }
  level.deposit_from_compromised_convoy_delayed._id_12010 = var_1;
  level.agent_funcs[var_0]["_encstr_8BB20BDE37D723C2DA859DACC8"] = var_1;
}

_id_12B0C(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.agent_funcs)) {
    return;
  }
  level.deposit_from_compromised_convoy_delayed._id_12011 = var_1;
  level.agent_funcs[var_0]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = var_1;
}

_id_12B0D(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level.deposit_from_compromised_convoy_delayed._id_1201E = var_1;
  level.agent_funcs[var_0]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = var_1;
}

binoculars_watchracelaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_2;

  if(!istrue(self._id_14693))
    scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

binoculars_watchracetake(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(level._id_1203F)) {
    if(scripts\engine\utility::isbulletdamage(var_4)) {
      if(isPlayer(var_1) || isbot(var_1) || isagent(var_1))
        self[[level._id_1203F]](var_1, var_6, self);
    }
  }

  if(!istrue(self._id_14693))
    scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  else
    _encstr_8D3C2590A0CAE37959BF28208766732F02CF7701FEE24BA131FB60885B85496F9A75791E56DA1F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

binocularsinited(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_encstr_8D3C2590A0CAE37959BF28208766732F02CF7701FEE24BA131FB60885B85496F9A75791E56DA1F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(self._encstr_9196231D87BDF06B4F21A1E97A03969056EBCFBF3EE908A7B7FA39115113DB206C6B2913DC)) {
    if(istrue(self._encstr_82B61D186381B9D0E711DB40E7F7FB41F6CBB821EBA7F5E98722D1CFF63F61))
      var_2 = int(var_2 * 0.5);

    self[[self._encstr_9196231D87BDF06B4F21A1E97A03969056EBCFBF3EE908A7B7FA39115113DB206C6B2913DC]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, undefined, var_11, var_12);
    _encstr_A6221AFF5068E5AA4325823A187F92A3B3E033BF60632442B3CF4FF7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(self._encstr_A539298FEBC6CB9DD0063EC47950B4411045F7EBABE1525730EE778C70E8FBEAFDF96F7F13994A0A48712C))
      [[self._encstr_A539298FEBC6CB9DD0063EC47950B4411045F7EBABE1525730EE778C70E8FBEAFDF96F7F13994A0A48712C]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    scripts\mp\subway\fast_travel_subway_station::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self, var_13, var_14);
  }
}

_encstr_A6221AFF5068E5AA4325823A187F92A3B3E033BF60632442B3CF4FF7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor()) {
    var_15 = var_2;

    if(istrue(self.hashelmet) && (var_8 == "_encstr_81CC0586952C91" || var_8 == "_encstr_A6CC076A05751852B3"))
      var_2 = int(var_2 * 0.07);

    if(isDefined(var_1) && isPlayer(var_1))
      var_1 playsoundtoplayer("_encstr_A1BB141A961DBE6B169CB6599CFA9946BEB093ADBD27", var_1);

    scripts\mp\damage::armorvest_sethit(var_1);
    var_16 = self.br_armorhealth - var_2;
    self.health = self.health + var_15;
    self.br_armorhealth = self.br_armorhealth - var_2;

    if(scripts\engine\utility::sign(var_16) == -1) {
      var_2 = int(abs(var_16));
      self.health = self.health - var_2;
    }

    if(self.br_armorhealth <= 0) {
      self.br_armorhealth = 0;
      scripts\mp\damage::armorvest_setbroke(var_1);

      if(isDefined(self._encstr_952410E6DB537883206282F7DBAFBB7F9F44))
        access_card::_encstr_ABF9178C95A3B0C6438695B16BCA47CCE4BDAD9EF65B98B4CA(self._encstr_952410E6DB537883206282F7DBAFBB7F9F44.model, self._encstr_952410E6DB537883206282F7DBAFBB7F9F44.tag);

      if(isDefined(var_1) && isPlayer(var_1))
        var_1 playsoundtoplayer("_encstr_B17B1AC857E3D90A898228DD1389AF5F9E276E5A57DAE1D533C588CA", var_1);
    }
  }
}