/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\laststand.gsc
***********************************************/

init() {
  scripts\mp\playeractions::registeractionset("_encstr_A5510A30AA778D28B3C97D51", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_BEF4071AA87BDF5220", "_encstr_8F0508CE59DCA357392B", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", "_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC", "_encstr_A1AF107FB41FA3596A69773FD20858C85627"]);
  scripts\mp\playeractions::registeractionset("_encstr_8C1015C5F140ACE3F50B7B2B0F120AFCE01B7BCAE9384B", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_8F0508CE59DCA357392B", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", "_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC"]);
  scripts\mp\playeractions::registeractionset("_encstr_A26311B91AE301BB9BD3AA1FB8BDBA30A956EB", ["_encstr_B8840F32A81197F3C9E32F3E9B303FCB45", "_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_AF4D07932B1BDE5846", "_encstr_88780599B4E495", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", "_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_8F0508CE59DCA357392B", "_encstr_964E0BB08D63B7BBF553EA5BC1", "_encstr_92100762872552A643", "_encstr_A6C7065BACB1CA95"]);
  level.laststandreviveents = [];

  if(isusingmatchrulesdata()) {} else {
    scripts\mp\utility\game::registerlaststandhealthdvar(50);
    scripts\mp\utility\game::registerlaststandrevivehealthdvar(30);
    scripts\mp\utility\game::registerlaststandtimerdvar(10);
    scripts\mp\utility\game::registerlaststandinvulntimerdvar(1);
    scripts\mp\utility\game::registerlaststandsuicidetimerdvar(5);
    scripts\mp\utility\game::registerlaststandrevivetimerdvar(10);
    scripts\mp\utility\game::registerlaststandweapondvar("_encstr_A393109FCF38E936DA97CCE3177050314CB8");
    scripts\mp\utility\game::registerlaststandrevivedecayscaledvar(0);
    scripts\mp\utility\game::registerlaststandweapondelaydvar(0);
  }

  level.laststandhealth = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8A5511EEC287465822842B3DBCDCE8071BDB80", "_encstr_A7D51BB96C27FA1CD858F2B29CAF1B859BE8D4E80BCD8C902BC2B18E34");
  level.laststandrevivehealth = scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8ED717A07B2197402FCBD94A7DFB8F98942C72E4D7BF8A39F0", "_encstr_AB602116D37B5E59A5D2CBF8FB3129D1C76C8E0D29E3E125CFCB8868A21CE369D3F4AB");

  if(level.laststandhealth > scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A"))
    level.laststandhealth = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A");

  if(level.laststandrevivehealth > scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A"))
    level.laststandrevivehealth = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A");

  level.laststandinvulntime = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_832A151EB3E2782B7A3BEF153DB4089D53EAC0A3784F1D", "_encstr_9A951FDA69905FFBC1330F773D6002D930135A6341282CA028E5276B1D8D1A1D78");
  level.watch_for_next_sniper = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A58D1BE912C3F383313D210BF3958F4C10CCD38B8758DE91F631D3DB57", "_encstr_995025C27188471339CBE76F15481AB1583B728BA973046985CDAF2B139DF2EB6062FAD6C1A8CD");
  level.laststandrevivetimer = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A93C16FA630B9BE84D1D859B4629569DB467ACA24BDA2BE4", "_encstr_8E1D20A37E83B7DA19B023FA302795071B5D0B3C87E8836A23602AC3A0D90C8FB1C6");
  level.laststandsuicidetimer = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_9A7E17B94911D3F5DBB19358045745571784D37F9F87F89D7E", "_encstr_8A5B2178E66A97580DFFBB200AB805A00B401725B9101C3FFD70B2917179A9223B055B");
  level.laststandtimer = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8FA6100F03A20E1893DBE118C7BCB8495AD3", "_encstr_A10C1A38923A17A303D90375A2A76833224B81882AD5A9FF2FCD05F6");
  level.watch_for_payload_approach_cache_1 = scripts\mp\utility\dvars::respawn_index("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E1011883D32C7934BC30B706BA7491BCB6598", "_encstr_8ABB1BEB69853F4FA03070A5DAB922C79BFBFFA339437541A866F26216");
  level.watch_for_player_death = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_AAF8167920A0DBE33671173349DC3A01D0A8AD37B960914B", "_encstr_9303206FB8EBF7AB6907E09FF667229193A857FB30800401432FAA15D0894A5479B8");
  setdvarifuninitialized("_encstr_A95223B9C639D71C8D0B2F594EF56358E68E4D3A58DC91148D8D2F119316EC2A37164CC656", 0);
  setdvarifuninitialized("_encstr_8C3126B96CE4D71CC6B0E5B2E4EB3658B93AA6A32CCD195036B19722E42CEC9ADE9D956A83AC958C", 0.3);
  level thread laststandmonitor();
}

laststandthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  onenter();
  var_0 = scripts\engine\utility::_id_143B8("_encstr_8D811848D20F85416AC46B7DFC59C0C5EF9AA6537B97B6D802BB", "_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A", "_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8A6F1736C237E87DE68E0B7323D7DCCA8DCCBE9356674BD9AC");

  switch (var_0) {
    case "_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A":
      onrevive();
      break;
    case "_encstr_8A6F1736C237E87DE68E0B7323D7DCCA8DCCBE9356674BD9AC":
      onrevive(1);
      break;
    case "_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B":
      onbleedout();
      break;
    case "_encstr_8D811848D20F85416AC46B7DFC59C0C5EF9AA6537B97B6D802BB":
      onrevive(0, 1);
      break;
    case "_encstr_AD75063D571AE108":
      if(!((scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")))
        ondeath();

      break;
    case "_encstr_8D820B49520F0EC02DDE6367EC":
      ondeath();
      break;
  }

  if(isDefined(self))
    self setclientomnvar("_encstr_99FC106B18C9591B88F99FDFE146B389A841", 0);
}

onenter() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self notify("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self setclientomnvar("_encstr_99FC106B18C9591B88F99FDFE146B389A841", 1);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_ACBE12F049519F2F9591A24AC8A1E9FFABA7669C", undefined, 0.25);
  var_0 = level.laststandhealth;

  if(level.gametype == "_encstr_B607038AAB")
    thread waittill_near_goal();

  self.health = var_0;
  thread makelaststandinvuln();
  scripts\mp\utility\perk::giveperk("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6");
  scripts\mp\utility\perk::giveperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
  self.inlaststand = 1;
  self._id_125B9 = undefined;
  self.hasshownlaststandicon = 0;

  if(isDefined(level.playerdatafield) && [[level.playerdatafield]]()) {
    if(isDefined(level.playercleanupinfilondisconnect))
      self[[level.playercleanupinfilondisconnect]](1);
  }

  if(level.gametype == "_encstr_B607038AAB" && !istrue(self.shouldgetnewspawnpoint)) {
    if(isDefined(level.getinfectedairdropposition))
      [[level.getinfectedairdropposition]]();
  }

  self.laststandoldweaponobj = scripts\mp\utility\inventory::getlastweapon();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    scripts\common\utility::allow_weapon_switch_clip(0);

    if(!istrue(self.gulag)) {
      self.watch_for_driver_death = gettime();
      self.get_tv_station_infil_rider_start_targetname = undefined;
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_82D91946DDF83E5657A7C383859F33489CDF082F10E88BAAE24D36("_encstr_959211381051B3070B4EBC2E96C9A3937312EA");

      if(!istrue(level._id_133D8)) {
        var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(self.team, self.squadindex);

        foreach(var_3 in var_1) {
          if(!isDefined(var_3)) {
            continue;
          }
          if(var_3 != self)
            var_3 thread scripts\mp\hud_message::showsplash("_encstr_8D8E11702BEEFBBF1AF5970BD3FF067C523B35", undefined, self);
        }
      }
    }
  }

  var_5 = self getheldoffhand();

  if(!nullweapon(var_5)) {
    var_6 = scripts\mp\equipment::getequipmentreffromweapon(var_5);

    if(isDefined(var_6) && scripts\mp\equipment::hasequipment(var_6)) {
      var_7 = scripts\mp\equipment::findequipmentslot(var_6);

      if(var_7 == "_encstr_BA7F0830B3A7859B60B0" || var_7 == "_encstr_AC8F0AE74163F85AAA380AD8")
        thread scripts\mp\equipment\gas_grenade::gas_takeheldoffhand();
    }
  }

  var_8 = level.watch_for_payload_approach_cache_1;

  if(isDefined(level.laststandweaponcallback) && getdvarint("_encstr_837525DC1BE4FAE0D8C2F2AC4EFAB29B2C89B195A956D8B7E6C8EAD2DC32A0E64682A5CDA3ED63", 0))
    var_8 = self[[level.laststandweaponcallback]]();

  if(!issameweapon(var_8))
    var_8 = getcompleteweaponname(var_8);

  if(!istrue(self.usingascender))
    self stopanimscriptsceneevent();

  if(self isviewmodelanimplaying())
    self stopviewmodelanim();

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func))
    self[[level.killstreak_laststand_func]]();
  else {
    if(isDefined(level.modeonlaststandfunc))
      self[[level.modeonlaststandfunc]]();

    if(isDefined(level.weaponfixup))
      self thread[[level.weaponfixup]]();

    if(isDefined(level.customlaststandactionset))
      self.laststandactionset = level.customlaststandactionset;
    else
      self.laststandactionset = "_encstr_A5510A30AA778D28B3C97D51";

    if(isDefined(self.vehicle))
      self waittill("_encstr_A9130DC330104912F19DE1677B831B");

    scripts\mp\playeractions::allowactionset(self.laststandactionset, 0);
    thread setup_volumes(var_8);

    if(isDefined(level.battle_tracks_stopbattletrackstoalloccupants))
      self[[level.battle_tracks_stopbattletrackstoalloccupants]]();
    else
      addoverheadicon();

    var_9 = level.laststandsuicidetimer;
    scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AD740E39563BE1EE732BF89873876021", "_encstr_B2BE0788BAF573592F", var_9, 0);
    thread revivesetup(self);
    self.fastcrouchspeedmod = getdvarfloat("_encstr_917A229BB1E4AF83D885F2599CF5B1B0DC3A9AE8B0CD19D438ACAC231491C8A5E85AB737", 0);
    scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_82A71120EA74DD99472EF07507F380971DC280");

    if(isDefined(self.watch_for_attack) && self.watch_for_attack scripts\mp\utility\perk::_hasperk("_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1"))
      self.watch_for_attack scripts\mp\perks\perkfunctions::regendelayreduce_onkill();

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
      childthread stucktime(var_9);
      return;
    }

    if(isDefined(self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"])) {
      var_10 = "_encstr_AB3C19EF6B209D2FB8396942408557D27839A76AFDA825D7DBD1B3" + self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"];
      self.watch_for_molotov_ambush_and_spawners = scripts\mp\utility\outline::outlineenableforteam(self, self.team, var_10, "_encstr_A5510A30AA778D28B3C97D51");
    }

    childthread dodamagewhiledown();
  }
}

waittill_near_goal() {
  if(!istrue(self.islaststandbleedoutdmg) && !istrue(self.littlebirdsmg)) {
    self.islaststandbleedoutdmg = 1;
    self stoplocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
    self playlocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
    self setsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread scripts\mp\healthoverlay::playerbreathingpainsound();
  }
}

setup_volumes(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && (self.currentweapon.basename == "_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73" || self.currentweapon.basename == rpggetclosetoapc()))
    waitframe();

  waitframe();
  var_1 = getcompleteweaponname("_encstr_B4FE1DE7AF23C95F98E03D477B905F32573F1BC74FAD921E78AE778D73C8BA");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 0);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  wait 1.7;
  self notify("_encstr_BDA21B114FFBF529ABC3C920EF5FA82E328BA783B3E230E8EFDF303857");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  if(!issameweapon(var_0) && (var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_A393109FCF38E936DA97CCE3177050314CB8"))
    givedefaultlaststandweapon();
  else {
    var_2 = level.watch_for_player_death;

    if(var_2 > 0)
      thread handlelaststandweapongivedelay(var_2, var_0);
    else
      givelaststandweapon(var_0);
  }
}

_id_13A34() {
  var_0 = self;
  var_1 = getcompleteweaponname("_encstr_B4FE1DE7AF23C95F98E03D477B905F32573F1BC74FAD921E78AE778D73C8BA");

  if(var_0 hasweapon(var_1))
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
}

handlelaststandweapongivedelay(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = givedefaultlaststandweapon();

  if(isnullweapon(var_2, var_1)) {
    return;
  }
  wait(var_0);
  self notify("_encstr_A69E127DC0CCCF52D7B74D275B0580FF2373FBEB");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
  givelaststandweapon(var_1);
}

givedefaultlaststandweapon() {
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_A204106372BA8107A31948B5C70F8951652A");

  if(!isDefined(var_0))
    var_0 = "_encstr_A393109FCF38E936DA97CCE3177050314CB8";

  var_1 = getcompleteweaponname(var_0);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  return var_1;
}

givelaststandweapon(var_0) {
  if(!issameweapon(var_0))
    var_0 = scripts\mp\class::buildweapon(var_0);

  var_1 = createheadicon(var_0);

  if(!self hasweapon(var_1))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
}

disableweaponsovertime(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\common\utility::allow_weapon(0);
  scripts\engine\utility::_id_143B9(var_0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\common\utility::allow_weapon(1);
}

switchtofists(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A69E127DC0CCCF52D7B74D275B0580FF2373FBEB");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1) == 0)
    waitframe();
}

dodamagewhiledown() {
  self endon("_encstr_8F4312F2BE8F83B7DDD9D0CFF9DEC7EB5B4B0231");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AA48117347537FEF4F5072DBF877A72789ADE0");
  var_0 = level.laststandhealth;
  var_1 = level.laststandtimer;

  if(var_1 <= 0) {
    onbleedout();
    return;
  }

  var_2 = float(var_0) / float(var_1);

  if(getdvarfloat("_encstr_8F4A214057AA3E310A9E0305325141A1F3A3F9F0C75E9199A286F1958C49A769448F78", 0) > 0)
    var_2 = var_2 * getdvarfloat("_encstr_8F4A214057AA3E310A9E0305325141A1F3A3F9F0C75E9199A286F1958C49A769448F78", 0);

  wait 1.0;
  var_3 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");

  if(!istrue(level.watch_for_objective_failed))
    thread suicidesetup();

  var_4 = 0.0;

  while(self.health > 0) {
    if(self isinexecutionvictim()) {
      wait 1.0;
      continue;
    }

    if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var_5 = int(var_4 + var_2) - int(var_4);
      var_4 = var_4 + var_2;
      self.update_bomb_interaction_ent = 1;
      self dodamage(var_5, self.origin, self, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", var_3, "_encstr_8BBA05185F8B99");
      self.update_bomb_interaction_ent = undefined;
    }

    if(self.health <= 0)
      onbleedout();

    wait 1.0;
  }
}

stucktime(var_0) {
  self.stuckinlaststand = 1;
  wait(var_0);
  self.stuckinlaststand = 0;

  if(scripts\mp\utility\perk::_hasperk("_encstr_A6B5137F3019DB2A03F1D388700FA372C350F387D8") && getdvarint("_encstr_BE7315A211E8277359AB87CFB5E8FA51B89BD2EBC9A0A4") != 1)
    var_1 = level.laststandtimer;
  else
    var_1 = level.laststandtimer;

  if(!isDefined(var_1))
    var_1 = level.laststandtimer;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {}

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    var_1 = max(var_1 - level.laststandsuicidetimer, 1);

  self.timeuntilbleedout = var_1;
  thread bleedoutthink();
  thread suicidesetup();
}

_id_13012(var_0) {
  if(var_0 usinggamepad())
    return var_0 allowspectateallteams();
  else
    return var_0 setmainstreamloaddist();
}

_id_13014() {
  var_0 = self;
  var_1 = var_0.owner;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  var_2 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_A2061581D9773367DBDAA0F8C1B71528CB45058B3DF73B") * 1000;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && var_1 scripts\mp\utility\perk::_hasperk("_encstr_922F1B3FA88FC87B4F02339A592BAE71E71187B925B2E13E67BBE863C2"))
    var_2 = var_2 * 0.75;

  var_0.usetime = var_2;

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  for(;;) {
    if(_id_13012(var_1) && !istrue(var_1.usedprops) && var_1 isonground()) {
      var_0 notify("_encstr_8E1D12A37D4053112590D33A1053594FFBD72A3C");
      var_1 setlaststandenabled(1);
      var_0 thread _id_13013();
    }

    waitframe();
  }
}

_id_13013() {
  var_0 = self.owner;
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  var_1._id_1438A = 0;
  var_1 thread _id_13011();

  while(scripts\mp\utility\player::isreallyalive(var_0) && _id_13012(var_0) && var_1.curprogress < var_1.usetime) {
    while(!var_0 isonground() && _id_13012(var_0) && !istrue(var_0.usedprops))
      waitframe();

    if(!_id_13012(var_0)) {
      break;
    }

    if(var_0 isinexecutionvictim()) {
      break;
    }

    if(!istrue(var_0.usedprops)) {
      var_0 thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_862C1904E411910FC1E80743E8BAD2595F75CD7F58ED4A4668E8E7", 10);

      if(!istrue(var_0._id_138AD)) {
        var_0 attach("_encstr_8D6F1CD8D5B05D4A4B6A284F67C50BA75BCC041841D7A0448908C14B70D7", "_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");
        var_0._id_138AD = 1;
      }

      var_0.usedprops = 1;
      var_0 allowmovement(0);
    }

    if(!isDefined(var_1.userate))
      var_1.userate = 0;

    if(istrue(var_0.beingrevived)) {
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 6);
      break;
    }

    if(!var_0 isonground()) {
      break;
    }

    var_1.curprogress = var_1.curprogress + level.frameduration * var_1.userate;
    var_1.userate = 1;
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1);

    if(var_1.curprogress >= var_1.usetime) {
      var_0 stopgestureviewmodel("_encstr_96921BB395CDFA955CAE5A1CAFDCD1D2ADD737CA3633EBE4B2CEA53BAC");
      wait 0.5;

      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_grenade_missed(var_0);

      var_0 playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", var_0);

      if(isDefined(level._id_12C1F))
        var_0[[level._id_12C1F]]();

      return;
    }

    waitframe();
  }

  if(!istrue(var_0.beingrevived)) {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1401F(var_0, var_0, var_1.curprogress, 1);
    var_1 thread decayreviveprogress();
  }

  var_0 notify("_encstr_A344148634FF4BA91712A1F83A6D4D6653CD8C73AE7F");
}

_id_13011() {
  var_0 = self.owner;
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_BA0B1A5221E8EE7146B3ABCF8DE5B92350894E9D5B608F8B9D53B3B3");
  var_0 endon("_encstr_BA0B1A5221E8EE7146B3ABCF8DE5B92350894E9D5B608F8B9D53B3B3");
  var_0 scripts\engine\utility::_id_143B5("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69", "_encstr_A344148634FF4BA91712A1F83A6D4D6653CD8C73AE7F", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(var_0.beingrevived))
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);

  var_0 allowmovement(1);

  if(istrue(var_0._id_138AD)) {
    var_0 detach("_encstr_8D6F1CD8D5B05D4A4B6A284F67C50BA75BCC041841D7A0448908C14B70D7", "_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");
    var_0._id_138AD = 0;
  }

  var_0 stopgestureviewmodel("_encstr_96921BB395CDFA955CAE5A1CAFDCD1D2ADD737CA3633EBE4B2CEA53BAC");
  var_0 setlaststandenabled(0);
  var_0.usedprops = 0;
}

onexitcommon(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.laststandactionset = undefined;
  thread clearlaststandinvuln();
  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(scripts\mp\utility\perk::_hasperk("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6"))
    scripts\mp\utility\perk::removeperk("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6");

  if(scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7"))
    scripts\mp\utility\perk::removeperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");

  if(isDefined(level.playerdatafield) && [[level.playerdatafield]]()) {
    if(isDefined(level.playercleanupinfilondisconnect))
      self[[level.playercleanupinfilondisconnect]](0);

    if(isDefined(level.playercleargulagomnvars))
      self[[level.playercleargulagomnvars]](0);
  }

  var_1 = level.watch_for_payload_approach_cache_1;
  var_1 = getcompleteweaponname(var_1);

  if(self getcurrentprimaryweapon() != var_1) {
    self notify("_encstr_A69E127DC0CCCF52D7B74D275B0580FF2373FBEB");
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
  } else
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  self notify("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self.laststandoldweapon = undefined;

  if(istrue(scripts\mp\utility\player::registerpuzzleinteractions()))
    scripts\mp\utility\player::_id_1312B(0);

  if(level.gametype == "_encstr_B607038AAB") {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1401F(self, self, 0, 1);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319C(0);
    self.disable_hotjoining_after_time = undefined;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(isDefined(level._id_11C79))
    self[[level._id_11C79]](var_0);

  waittillframeend;
  self.inlaststand = 0;
}

onrevive(var_0, var_1) {
  var_2 = self.laststandoldweaponobj;
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::brjugg_droponplayerdeath(1);

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12781(self, 1, 1);

  if(isDefined(self.laststandactionset))
    scripts\mp\playeractions::allowactionset(self.laststandactionset, 1);

  onexitcommon(1);
  self laststandrevive();
  self notify("_encstr_8F4312F2BE8F83B7DDD9D0CFF9DEC7EB5B4B0231");
  var_3 = level.watch_for_payload_approach_cache_1;

  if(var_3 != "_encstr_8BBA05185F8B99")
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 1);

  if(!istrue(var_1)) {
    var_4 = level.laststandrevivehealth;

    if(!getdvarint("_encstr_82CF2768C26A47F3B369B3A55257B883921BF1D89A05798F4F86B3245D1BC161FE529041721EB10313") || self.health < level.laststandrevivehealth)
      self.health = level.laststandrevivehealth;
  } else
    self.health = self.maxhealth;

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060")
    scripts\mp\gamelogic::freezeplayerforroundend();

  scripts\mp\utility\player::_id_1312B(0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !istrue(self.gulag)) {
    scripts\common\utility::allow_weapon_switch_clip(1);

    if(!istrue(level._id_133D8)) {
      var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(self.team, self.squadindex);

      foreach(var_7 in var_5) {
        if(!isDefined(var_7)) {
          continue;
        }
        if(var_7 != self)
          var_7 thread scripts\mp\hud_message::showsplash("_encstr_8EAE148A3817BB37B121FDE945D917C29BF0A24338C9", undefined, self);
      }
    }
  }

  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(istrue(var_0) && istrue(level.allowselfrevive))
    allowselfrevive(0);

  self.watch_for_attack = undefined;
  self.watch_for_level_weapons_free = undefined;
  self.watch_for_player_enter_puddle_trigger = undefined;
  self.watch_for_driver_spawned = undefined;
  self.watch_for_damage = undefined;
  self.watch_for_damage_on_trap = undefined;
  self.watch_for_damage_on_turret = undefined;
}

onbleedout() {
  if(!isDefined(self)) {
    return;
  }
  thread onexitcommon();
  dropcarryobject();

  if(isDefined(self.watch_for_attack))
    self.watch_for_attack thread scripts\mp\rank::scoreeventpopup("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");

  if(level.gametype == "_encstr_B607038AAB") {
    if(!istrue(level.gameended)) {
      self.islaststandbleedoutdmg = 0;
      self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
      self playlocalsound("_encstr_921012A70D0383A0A3294B5F90BB5F4AD3972B5C");
      self enableplayerbreathsystem(1);
    }
  }

  scripts\mp\utility\damage::_suicide();
}

ondeath(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && isDefined(self.watch_for_attack) && istrue(self.watch_for_attack.inlaststand))
    self.watch_for_attack thread _id_1204F(var_0, self.watch_for_level_weapons_free, self.watch_for_player_enter_puddle_trigger);

  if(istrue(self.usedprops))
    self notify("_encstr_A344148634FF4BA91712A1F83A6D4D6653CD8C73AE7F");

  if(level.gametype == "_encstr_B607038AAB") {
    if(!istrue(level.gameended)) {
      self.islaststandbleedoutdmg = 0;
      self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
      self playlocalsound("_encstr_921012A70D0383A0A3294B5F90BB5F4AD3972B5C");
      self enableplayerbreathsystem(1);
    }
  }

  if(isDefined(level.getinfilplayers))
    [[level.getinfilplayers]](self, 1);

  thread onexitcommon();
  dropcarryobject();
}

dropcarryobject() {
  if(isDefined(self.carryobject))
    self.carryobject thread scripts\mp\gameobjects::setdropped();
}

revivesetup(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_BDA21B114FFBF529ABC3C920EF5FA82E328BA783B3E230E8EFDF303857");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_1 setusehideprogressbar(1);
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_1 setHintString(&"_encstr_8E6518CF01A621FF4791374FB01E30DFEDCDAEF32B19EFBD8B5F");
  var_1 setusepriority(-2);
  var_2 = var_0.team;
  var_1 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 6), (0, 0, 0));
  var_1.owner = var_0;
  var_1.inuse = 0;
  var_1.id = "_encstr_9A43124032FAC143E35908750F93C99D24EBB038";
  var_1.trigger = spawnStruct();
  var_1.trigger.owner = var_0;
  var_1.trigger.id = "_encstr_9A43124032FAC143E35908750F93C99D24EBB038";
  var_1.trigger.targetname = "_encstr_81C90FCAF9E0392BF5FFEBFBFBAC626D68";
  var_1 makeusable();
  var_1 thread trackteamchanges(var_2);
  var_1 thread revivetriggerthink(var_2);
  var_1 thread endreviveonownerdeathordisconnect();

  if(getdvarint("_encstr_8663256E6CC9D7C18D0B2F599CEBB12C6EA34DE82CB919A2CD854C63B29ACA36DB3746AE4BCD19", 0) && getdvarint("_encstr_837525DC1BE4FAE0D8C2F2AC4EFAB29B2C89B195A956D8B7E6C8EAD2DC32A0E64682A5CDA3ED63", 0))
    var_0 thread _id_12FB4();

  var_0.laststandreviveent = var_1;
  level.laststandreviveents[var_1 getentitynumber()] = var_1;
  var_1 thread removereviveentfromlevelarrayondeath();
  var_0 thread _id_144D0();

  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldgetnewspawnpoint())
    var_0.laststandreviveent _id_13014();
}

_id_12FB4() {
  var_0 = self;
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = gettime();
  var_0 waittill("_encstr_A54F1BD02A0B8198B7F76B45F5DDB0C0C7B2AEB832DFC5110AB46B4D1C", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  for(;;) {
    if(var_9) {
      var_0 waittill("_encstr_A54F1BD02A0B8198B7F76B45F5DDB0C0C7B2AEB832DFC5110AB46B4D1C", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
      continue;
    }

    break;
  }

  var_11 = var_2.watch_for_attack;

  if(!isDefined(var_11))
    var_11 = var_2;

  var_12 = isDefined(var_11) && var_11 != var_0;
  var_13 = var_9;
  var_14 = var_10 || isDefined(var_3) && var_3 getentitynumber() == worldentnumber();
  var_15 = gettime() - var_1;
  var_16 = float(var_15 / 1000.0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::diablecachesaroundorigin(var_0, var_11, var_2, var_5, var_6, var_7, var_8, var_12, var_13, var_14, var_16);

  var_0 playanim_aibegindismountturret("_encstr_A9531CB9CA3699D74E2BCE5ACE56FADBDCEBADB41BD87D37AE6C6C599B37", var_0);
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_B1270F86CAC7D30B1E3AA0F811332BC883");
  var_17 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_19 in var_17) {
    if(var_19 != var_0 && isalive(var_19))
      var_19 thread scripts\mp\hud_message::showsplash("_encstr_B4FC18CBA5907B5D38807D469B205FC3551F77036138F31928C9", undefined, var_0);
  }
}

_id_1204F(var_0, var_1, var_2) {
  var_3 = var_0.victim;
  var_4 = var_0.inflictor;
  var_5 = var_0.objweapon;
  var_6 = var_0.meansofdeath;
  var_7 = var_0.weaponfullstring;
  var_8 = var_0.attacker != self;
  var_9 = istrue(var_0.assistedsuicide);
  var_10 = undefined;

  if(isDefined(var_2))
    var_10 = createheadicon(var_2);

  self notify("_encstr_A54F1BD02A0B8198B7F76B45F5DDB0C0C7B2AEB832DFC5110AB46B4D1C", var_3, var_4, var_5, var_6, var_7, var_1, var_10, var_8, var_9);
}

endreviveonownerdeathordisconnect() {
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A6("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69", "_encstr_8768173685B91DAF9BD10B9BC8AFD0CA2C1BFAC2C647A53BB2");
  self delete();
}

removereviveentfromlevelarrayondeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self getentitynumber();
  self waittill("_encstr_AD75063D571AE108");
  level.laststandreviveents[var_0] = undefined;
}

updateusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2.team && var_2 != self.owner && !istrue(var_2 scripts\mp\utility\perk::_hasperk("_encstr_92D11CC31BB088C8B721D15F2963FA2E51DD794FD373635F57DF8A4B2D75")))
      self enableplayeruse(var_2);
    else
      self disableplayeruse(var_2);

    if(istrue(var_2 scripts\mp\utility\perk::_hasperk("_encstr_92D11CC31BB088C8B721D15F2963FA2E51DD794FD373635F57DF8A4B2D75")))
      var_2.hiddenreviveents[self getentitynumber()] = self;
  }
}

trackteamchanges(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");

  for(;;) {
    updateusablebyteam(var_0);
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

revivetriggerthink(var_0) {
  self.owner endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self.owner endon("_encstr_8768173685B91DAF9BD10B9BC8AFD0CA2C1BFAC2C647A53BB2");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(istrue(var_1.iszombie)) {
      continue;
    }
    if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      continue;
    }
    while(!var_1 isonground() && var_1 useButtonPressed())
      waitframe();

    if(istrue(var_1.tracking_max_health)) {
      var_1 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

      while(istrue(var_1.tracking_max_health) && var_1 useButtonPressed())
        waitframe();
    }

    if(!var_1 useButtonPressed()) {
      continue;
    }
    self.owner scripts\mp\utility\player::_id_1312B(1);
    var_2 = 0;
    self.owner notify("_encstr_BA94161A16DC238DB2EB9C563B4B3BB2BE6B959BE62CCE2B");
    self makeunusable();
    self.owner allowmovement(0);
    var_1 isholdingbreath(1);
    var_1._id_12D1E = 1;
    self.reviver = var_1;
    thread useholdthink(var_1);
    var_1 thread _id_139D5(self.owner);

    if(level.gametype == "_encstr_B607038AAB")
      self.owner _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319C(1);

    var_3 = scripts\engine\utility::_id_143B5("_encstr_883618B33B68CEF047138817CD6A1B84A012F78FBBEA3BFFBB9F", "_encstr_BD641553CB6F58B035842967A29F081B7BC26EB972F709", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

    if(var_3 == "_encstr_883618B33B68CEF047138817CD6A1B84A012F78FBBEA3BFFBB9F")
      var_2 = 1;

    var_1 notify("_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F");
    self.owner scripts\mp\utility\player::_id_1312B(0);
    var_2 = self.owner playanim_aibegindismountturret(var_3, var_1);

    if(var_2) {
      return;
    }
    thread decayreviveprogress();
    self makeusable();
    updateusablebyteam(var_0);
    waittillframeend;
    self.reviver = undefined;
  }
}

rpggetclosetoapc() {
  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    return "_encstr_8AA11C4B532742FD800B27A123482EDA04FB5FDFE95B0A97D89351B658A2";
  else
    return "_encstr_B192181D9585D65B85D1CAD79C56D9A59DB2F5CD1DA5B5AFD6C1";
}

_id_139D5(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(var_1._id_1438B)) {
    return;
  }
  var_2 = getcompleteweaponname(rpggetclosetoapc());
  var_3 = var_1 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B40101", var_1);
  var_3._id_12D1D = var_2;

  for(var_4 = 0; !var_4 || istrue(var_1.consecutive_kills); var_1._id_1438B = 1) {
    var_4 = var_1 scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var_2, var_3, ::_id_13AB4, undefined, ::_id_1209F, undefined, ::_id_120A0, 0);
    waitframe();
  }

  var_1.consecutive_kills = 1;
  var_1._id_1438B = 0;
  var_1 thread _id_144B4();
  var_1 thread _id_144D5(var_0);
  var_1 thread _id_144D6(var_0);
}

_id_1209F(var_0, var_1) {
  var_2 = self;
  var_2 disableweaponswitch();
}

_id_120A0(var_0, var_1) {
  var_2 = self;
  var_2 enableweaponswitch();
  var_2 notify("_encstr_8268157215DEE8AEF029D3D3EF6701B6E0BED2FB226D0C");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == rpggetclosetoapc())
    waitframe();

  waitframe();
  var_2.consecutive_kills = 0;
}

_id_13AB4(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(var_1._id_12D1E)) {
    return;
  }
  var_1 scripts\engine\utility::_id_143B5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
}

_id_144B4() {
  var_0 = self;
  var_0 endon("_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_AD75063D571AE108");
  var_0 enableweaponswitch();
}

_id_144D5(var_0) {
  var_1 = self;
  var_1 endon("_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isalive(var_0))
    var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  var_1 notify("_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F");
}

_id_144D6(var_0) {
  var_1 = self;
  var_1 endon("_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  var_1 notify("_encstr_88251639E995402E7B1E7E535963C239F0E72C31B3FF6A5F");
}

_id_144D0() {
  var_0 = self;

  if(!isPlayer(var_0)) {
    return;
  }
  if(!scripts\mp\utility\game::unset_relic_grounded()) {
    return;
  }
  var_1 = getdvarint("_encstr_BEC229782BF261E2EB215A5148C1E7F19608673E6015B94ABC9309904A0745C10FC115BFD327B3AB51B228", 0) == 1;

  if(!var_1) {
    return;
  }
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("_encstr_A2DB146EE885378D95341A5837EC95A093CAB9B95919", "_encstr_BA3B0CCFFF63FB656EA798872795");
    var_0 notifyonplayercommand("_encstr_A2DB146EE885378D95341A5837EC95A093CAB9B95919", "_encstr_ACF70A27C7824C50E45D6358");
    var_0 notifyonplayercommand("_encstr_A2DB146EE885378D95341A5837EC95A093CAB9B95919", "_encstr_A75407A4F05EE24E57");
    var_0 notifyonplayercommand("_encstr_A2DB146EE885378D95341A5837EC95A093CAB9B95919", "_encstr_A6E308B2DCE8B0B936B2");
    var_0 notifyonplayercommand("_encstr_A2DB146EE885378D95341A5837EC95A093CAB9B95919", "_encstr_B1680E47C3E2A4204C7F417BE53D486B");
    var_0 notifyonplayercommand("_encstr_B2A115331BDF6048170B91FB5EFF3026973249F9F327AD", "_encstr_969C0CD237A3C2736C568CEDBBE6");
    var_0 notifyonplayercommand("_encstr_B2A115331BDF6048170B91FB5EFF3026973249F9F327AD", "_encstr_92700A11DD726DD11CCFD010");
    var_0 notifyonplayercommand("_encstr_B2A115331BDF6048170B91FB5EFF3026973249F9F327AD", "_encstr_AA1207A507C9B7732B");
    var_0 notifyonplayercommand("_encstr_B2A115331BDF6048170B91FB5EFF3026973249F9F327AD", "_encstr_AA8B08A1EA73F3E04BB7");
    var_0 notifyonplayercommand("_encstr_B2A115331BDF6048170B91FB5EFF3026973249F9F327AD", "_encstr_9AFE0EA5E8B7D9B38DCA1B27DEEAD8A1");
  }

  for(;;) {
    var_0 waittill("_encstr_A2DB146EE885378D95341A5837EC95A093CAB9B95919");
    var_2 = gettime();
    var_0 waittill("_encstr_B2A115331BDF6048170B91FB5EFF3026973249F9F327AD");
    var_3 = gettime() - var_2;
    var_4 = 350;

    if(var_3 < var_4)
      _id_13BC9(var_0);
  }
}

_id_13BC9(var_0) {
  var_0.changesleft = !istrue(var_0.changesleft);
  var_1 = istrue(var_0.changesleft);
  var_2 = scripts\engine\utility::ter_op(var_1, "_encstr_A51E24373786C0AE3184357F5EB805751F7FD9EC098DE56E44A19BE7410BD957D7B9C1B41CF1", "_encstr_93FB256A147D4849EB5227E8A09A8AE5EAA4C489AF4A54599465A2AF9293153DAF86A4D3AA3409");
  var_0 scripts\mp\hud_message::showerrormessage(var_2);
}

playanim_aibegindismountturret(var_0, var_1) {
  var_2 = self;
  var_3 = 0;

  if(!isDefined(var_2) || !isalive(var_2))
    return 0;

  if(var_0 == "_encstr_883618B33B68CEF047138817CD6A1B84A012F78FBBEA3BFFBB9F" || var_0 == "_encstr_A9531CB9CA3699D74E2BCE5ACE56FADBDCEBADB41BD87D37AE6C6C599B37" || var_0 == "_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F")
    var_3 = 1;

  var_2.beingrevived = 0;
  var_2.usedprops = 0;

  if(var_0 == "_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F")
    var_2 setlaststandreviving();

  if(level.gametype == "_encstr_B607038AAB") {
    self.watch_for_driver_death = undefined;
    var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319C(0);
    var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_131A6(0);
  }

  var_2 allowmovement(1);

  if(var_3) {
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    var_2 notify("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
    self.fastcrouchspeedmod = 0;
    scripts\mp\weapons::updatemovespeedscale();

    if(level.gametype == "_encstr_B607038AAB") {
      if(!istrue(level.gameended)) {
        var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319E(0);
        scripts\mp\events::revivedplayer(var_1, var_2);
        scripts\cp\vehicles\vehicle_compass_cp::_id_12050(var_1, var_2);
        var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_1383B("_encstr_82A71120EA74DD99472EF07507F380971DC280");

        if(var_1 != var_2)
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_8294083A0938C3CB2577", 1);

        var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_82D91946DDF83E5657A7C383859F33489CDF082F10E88BAAE24D36("_encstr_AFE212DE73622CE6E8D4E80BE62349569D2D9D59", var_1);
        var_2.islaststandbleedoutdmg = 0;
        var_2 stoplocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");

        if(!istrue(var_2.deletequestcircle)) {
          var_2 playlocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
          var_2 clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
          var_2 playlocalsound(scripts\engine\utility::ter_op(scripts\mp\utility\player::isfemale(), "_encstr_9A181532ACB6D7C427B2583AD0A59B3BFAC4AC3AE8AC4E", "_encstr_8B2011A1E2E211DBF8B88D4071489B2C9B5F38"));
          var_2 enableplayerbreathsystem(1);
        }
      }

      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() && !istrue(var_2.deletequestcircle))
        playsoundatpos(var_2.origin, "_encstr_B23812422BC8AB75788BE5FA2F08FF6B0B038AAA");

      if(isDefined(self.watch_for_molotov_ambush_and_spawners)) {
        scripts\mp\utility\outline::outlinedisable(self.watch_for_molotov_ambush_and_spawners, self);
        self.watch_for_molotov_ambush_and_spawners = undefined;
      }
    }

    var_4 = "_encstr_B13D076BED70539F23";

    if(scripts\mp\utility\game::unset_relic_grounded()) {
      if(istrue(self.changesleft))
        var_4 = "_encstr_922406F1A6FD5E05";

      self.changesleft = undefined;
    }

    var_5 = var_2 setstance(var_4);

    if(!var_5) {
      var_6 = var_4 == "_encstr_B13D076BED70539F23";
      var_5 = var_2 setstance(scripts\engine\utility::ter_op(var_6, "_encstr_922406F1A6FD5E05", "_encstr_B13D076BED70539F23"));
    }
  }

  var_2 _id_13A34();
  var_2 thread has_filled_amped_bar();
  return var_3;
}

has_filled_amped_bar() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(level.gametype != "_encstr_B607038AAB") {
    return;
  }
  scripts\common\utility::allow_offhand_secondary_weapons(0, "_encstr_A37A14730306FBCB10813D877E28E853D0B7C3BFEFA2");

  while(self isthrowingbackgrenade()) {
    self._id_13B4F = 1;
    self giveandfireoffhand("_encstr_86B108781A36271E4F70");
    wait 1;
  }

  scripts\common\utility::allow_offhand_secondary_weapons(1, "_encstr_A37A14730306FBCB10813D877E28E853D0B7C3BFEFA2");
}

decayreviveprogress() {
  self.owner endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self.owner endon("_encstr_8768173685B91DAF9BD10B9BC8AFD0CA2C1BFAC2C647A53BB2");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91E316456345493BA793991E12018D9B2B0D4FA7806062E3");
  self endon("_encstr_8E1D12A37D4053112590D33A1053594FFBD72A3C");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.watch_for_next_sniper;

  if(var_0 <= 0) {
    return;
  }
  for(;;) {
    self.curprogress = self.curprogress - level.frameduration * var_0;

    if(self.curprogress <= 0) {
      self.curprogress = 0;
      return;
    }

    waitframe();
  }
}

useholdthink(var_0, var_1) {
  self.owner endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = self.owner;
  var_3 = getdvarint("_encstr_A95223B9C639D71C8D0B2F594EF56358E68E4D3A58DC91148D8D2F119316EC2A37164CC656");
  var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_4 hide();

  if(!var_3)
    var_0 scripts\mp\playeractions::allowactionset("_encstr_A26311B91AE301BB9BD3AA1FB8BDBA30A956EB", 0);

  self notify("_encstr_91E316456345493BA793991E12018D9B2B0D4FA7806062E3");
  var_0 thread _id_13298();

  if(var_3)
    dragallyprototype(var_0, var_2);

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  self.inuse = 1;
  self.userate = 0;
  var_5 = 0;

  if(isDefined(var_1))
    self.usetime = var_1;
  else if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_84C710D3602B067FF9F9BCB918AD378F5B60"))
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("_encstr_A2061581D9773367DBDAA0F8C1B71528CB45058B3DF73B") * 1000 * getdvarfloat("_encstr_A97E1B48CB906F372255672BCBE9D983FC84A7370AE3828C4F17A8D2C7");
  else
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("_encstr_A2061581D9773367DBDAA0F8C1B71528CB45058B3DF73B") * 1000;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && var_0 scripts\mp\utility\perk::_hasperk("_encstr_922F1B3FA88FC87B4F02339A592BAE71E71187B925B2E13E67BBE863C2"))
    self.usetime = self.usetime * 0.75;

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "_encstr_B4EE096B6BA40AEED8405F");
  thread useholdthinkcleanup(var_0, var_4);
  thread useholdthinkloop(var_0);
}

dragallyprototype(var_0, var_1) {
  var_2 = self;
  var_1 playerlinkTo(var_0);
  var_1 playerlinkedoffsetenable();
  var_1 allowmovement(0);
  var_0 setmovespeedscale(getdvarfloat("_encstr_8C3126B96CE4D71CC6B0E5B2E4EB3658B93AA6A32CCD195036B19722E42CEC9ADE9D956A83AC958C"));
}

cleanupdragallyprototype(var_0, var_1) {
  var_1 unlink();
  var_1 allowmovement(1);
  var_0 setmovespeedscale(1);
}

useholdthinkcleanup(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = getdvarint("_encstr_A95223B9C639D71C8D0B2F594EF56358E68E4D3A58DC91148D8D2F119316EC2A37164CC656");
  var_3 = self.owner;
  var_4 = var_3 scripts\engine\utility::_id_143B6("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_86AD17D537B2FA0DB7D891BEA30DB4CDB57DDCAEB16CCA37CD", "_encstr_869814AB9BD8AF6A50394BAF218B22C6C066E7367028", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self.inuse = 0;
  var_1 delete();
  var_0 setlaststandselfreviving();
  var_0 isholdingbreath(0);
  var_0._id_12D1E = 0;

  if(isDefined(var_0))
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);

  if(isDefined(var_3))
    var_3 scripts\mp\gameobjects::updateuiprogress(self, 0);

  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    if(var_2)
      cleanupdragallyprototype(var_0, var_3);
    else
      var_0 scripts\mp\playeractions::allowactionset("_encstr_A26311B91AE301BB9BD3AA1FB8BDBA30A956EB", 1);
  }

  var_0 notify("_encstr_919F10CDCC0F7DC9CAD996EC95F519EDCD95");

  if(var_4 == "_encstr_86AD17D537B2FA0DB7D891BEA30DB4CDB57DDCAEB16CCA37CD") {
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B442086D6763FB3D4F0A");

    if(istrue(level.allowselfrevive))
      var_0 allowselfrevive(1);

    var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_8E4208C9ACEC5A3BAC46");
    var_3 thread scripts\mp\hud_message::showsplash("_encstr_8E4208C9ACEC5A3BAC46", undefined, var_0);
    var_3.inlaststand = 0;
    self notify("_encstr_883618B33B68CEF047138817CD6A1B84A012F78FBBEA3BFFBB9F");
    return;
  } else if(var_4 == "_encstr_869814AB9BD8AF6A50394BAF218B22C6C066E7367028")
    var_3 notify("_encstr_BA94161A16DC238DB2EB9C563B4B3BB2BE6B959BE62CCE2B");

  self notify("_encstr_BD641553CB6F58B035842967A29F081B7BC26EB972F709");
}

_id_13298() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0 linkTo(self);
  var_0 playLoopSound("_encstr_AD7D1261B26FA0855BE7A59B9391D5E0ED4128BB");
  self waittill("_encstr_919F10CDCC0F7DC9CAD996EC95F519EDCD95");
  playsoundatpos(self.origin, "_encstr_8E3C1326E4D793593BD2ECB2E47DAECD567D957319");
  var_0 delete();
}

useholdthinkloop(var_0) {
  var_1 = self.owner;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");

  while(scripts\mp\utility\player::isreallyalive(var_0) && var_0 useButtonPressed() && !var_0 isinexecutionvictim() && self.curprogress < self.usetime && (!isDefined(var_0.inlaststand) || !var_0.inlaststand) && distancesquared(var_0.origin, self.origin) <= 65536) {
    if(istrue(var_0.tacopsmedicrole))
      return scripts\mp\utility\player::isreallyalive(var_0);

    self.curprogress = self.curprogress + level.frameduration * self.userate;
    self.userate = 1;
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var_1 notify("_encstr_86AD17D537B2FA0DB7D891BEA30DB4CDB57DDCAEB16CCA37CD");
      return;
    }

    waitframe();
  }

  var_1 notify("_encstr_869814AB9BD8AF6A50394BAF218B22C6C066E7367028");
  return;
}

suicidesetup() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread showsuicidehintstring();

  if(!isbot(self))
    thread _id_13969();

  var_0 = 0;

  for(;;) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0 && !scripts\mp\utility\player::registerpuzzleinteractions()) {
      var_0 = var_0 + level.framedurationseconds;

      if(var_0 >= 0.5) {
        break;
      }
    } else
      var_0 = 0;
  }

  _id_1396A();
}

_id_13969() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notifyonplayercommand("_encstr_B8C2145B8B875B4988A7DFE28A8B9A3319505A406B30", "_encstr_ACF70A27C7824C50E45D6358");
  self notifyonplayercommand("_encstr_8436120A5BD8BEFA757F7B7B6326A3ED58860352", "_encstr_92700A11DD726DD11CCFD010");
  self notifyonplayercommand("_encstr_B8C2145B8B875B4988A7DFE28A8B9A3319505A406B30", "_encstr_BA3B0CCFFF63FB656EA798872795");
  self notifyonplayercommand("_encstr_8436120A5BD8BEFA757F7B7B6326A3ED58860352", "_encstr_969C0CD237A3C2736C568CEDBBE6");
  var_0 = gettime();
  var_1 = 0;
  var_2 = 0;
  var_3 = 500.0;
  var_4 = 0;

  while(!var_4 && !var_1) {
    var_1 = 0;

    if(!var_2)
      var_0 = gettime();

    var_5 = scripts\engine\utility::_id_143BD(0.5, "_encstr_B8C2145B8B875B4988A7DFE28A8B9A3319505A406B30", "_encstr_8436120A5BD8BEFA757F7B7B6326A3ED58860352", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69", "_encstr_8A6F1736C237E87DE68E0B7323D7DCCA8DCCBE9356674BD9AC", "_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B");

    switch (var_5) {
      case "_encstr_B8C2145B8B875B4988A7DFE28A8B9A3319505A406B30":
        var_0 = gettime();
        var_2 = 1;
        break;
      case "_encstr_8436120A5BD8BEFA757F7B7B6326A3ED58860352":
      case "_encstr_995408F398012F656821":
        if(var_2 && gettime() - var_0 >= var_3)
          var_1 = 1;

        var_2 = 0;
        break;
      default:
        var_4 = 1;
        break;
    }

    waitframe();
  }

  if(var_1)
    _id_1396A();

  self notifyonplayercommandremove("_encstr_B8C2145B8B875B4988A7DFE28A8B9A3319505A406B30", "_encstr_ACF70A27C7824C50E45D6358");
  self notifyonplayercommandremove("_encstr_8436120A5BD8BEFA757F7B7B6326A3ED58860352", "_encstr_92700A11DD726DD11CCFD010");
  self notifyonplayercommandremove("_encstr_B8C2145B8B875B4988A7DFE28A8B9A3319505A406B30", "_encstr_BA3B0CCFFF63FB656EA798872795");
  self notifyonplayercommandremove("_encstr_8436120A5BD8BEFA757F7B7B6326A3ED58860352", "_encstr_969C0CD237A3C2736C568CEDBBE6");
}

_id_1396A() {
  if(istrue(self.allowselfrevive))
    self notify("_encstr_8A6F1736C237E87DE68E0B7323D7DCCA8DCCBE9356674BD9AC");
  else
    self notify("_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B");
}

showsuicidehintstring() {
  if(istrue(self.allowselfrevive))
    self forceusehinton(&"_encstr_919111A877E8A3D7190FDDF31721EF9B7DAF10");
  else if(level.gametype != "_encstr_B607038AAB")
    thread handlerevivemessage();

  scripts\engine\utility::waittill_any_ents(self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69", level, "_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self)) {
    return;
  }
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self forceusehintoff();
}

handlerevivemessage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");

  for(;;) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    var_0 = 0;
    var_1 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var_1) && var_1 == "_encstr_AACB15DC5738CA27FA1B589B1DCD47C29B32D7A19516B1" && scripts\mp\supers::issuperready())
      var_0 = 1;

    if(istrue(scripts\mp\utility\player::registerpuzzleinteractions()))
      scripts\mp\utility\lower_message::setlowermessageomnvar(22);
    else if(istrue(self.laststandhealisactive))
      scripts\mp\utility\lower_message::setlowermessageomnvar(23);
    else if(isDefined(self.timeuntilbleedout)) {
      if(var_0)
        scripts\mp\utility\lower_message::setlowermessageomnvar(19, int(gettime() + self.timeuntilbleedout * 1000));
      else if(scripts\mp\utility\game::getgametype() != "_encstr_9707038CB6") {
        if(self.pers["_encstr_8CAA06DB20A31543"] == 0 && scripts\mp\utility\game::isteamreviveenabled())
          scripts\mp\utility\lower_message::setlowermessageomnvar(5, int(gettime() + self.timeuntilbleedout * 1000));
        else
          scripts\mp\utility\lower_message::setlowermessageomnvar(20, int(gettime() + self.timeuntilbleedout * 1000));
      } else
        scripts\mp\utility\lower_message::setlowermessageomnvar(21, int(gettime() + self.timeuntilbleedout * 1000));
    } else if(var_0)
      scripts\mp\utility\lower_message::setlowermessageomnvar(19);
    else if(self.pers["_encstr_8CAA06DB20A31543"] == 0 && scripts\mp\utility\game::isteamreviveenabled())
      scripts\mp\utility\lower_message::setlowermessageomnvar(5);
    else
      scripts\mp\utility\lower_message::setlowermessageomnvar(20);

    for(;;) {
      var_2 = scripts\engine\utility::_id_143B4("_encstr_A3F20C0B33A3EDC8812283835C70", "_encstr_BA94161A16DC238DB2EB9C563B4B3BB2BE6B959BE62CCE2B");

      if(var_2 == "_encstr_A3F20C0B33A3EDC8812283835C70" && scripts\mp\supers::getcurrentsuperref() != "_encstr_AACB15DC5738CA27FA1B589B1DCD47C29B32D7A19516B1")
        continue;
      else
        break;
    }
  }
}

bleedoutthink() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self endon("_encstr_8768173685B91DAF9BD10B9BC8AFD0CA2C1BFAC2C647A53BB2");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.timeuntilbleedout;

  if(var_0 != 0) {
    for(;;) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }
      if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions()))
        var_0 = var_0 - level.framedurationseconds;

      if(var_0 <= level.framedurationseconds) {
        self notify("_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B");
        break;
      }

      self.timeuntilbleedout = var_0;
    }
  }
}

addoverheadicon() {
  var_0 = self.origin;
  var_1 = newteamhudelem(self.team);
  var_1.x = var_0[0];
  var_1.y = var_0[1];
  var_1.z = var_0[2] + 32;
  var_1.alpha = 1.0;
  var_1.archived = 0;
  var_1.showinkillcam = 0;

  if(level.splitscreen)
    var_1 setshader("_encstr_950518D0EA46BE93AC0B36A59BDAAFD0CA2C8CFA9CAC67B49D2B", 10, 10);
  else
    var_1 setshader("_encstr_950518D0EA46BE93AC0B36A59BDAAFD0CA2C8CFA9CAC67B49D2B", 5, 5);

  var_1 setwaypoint(0);
  var_1 settargetEnt(self);
  thread cleanupoverheadicon(var_1);
}

cleanupoverheadicon(var_0) {
  self waittill("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  var_0 destroy();
}

showwaverespawnmessage() {
  var_0 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122") > 0;

  if(!var_0) {
    return;
  }
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");

  for(;;) {
    self.respawntimerstarttime = gettime();
    var_0 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122") > 0;

    if(var_0) {
      var_1 = scripts\mp\playerlogic::timeuntilwavespawn(0.0);
      scripts\mp\utility\lower_message::setlowermessageomnvar(10, int(gettime() + var_1 * 1000));
      wait(var_1);
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    }

    wait 2.0;
  }
}

allowselfrevive(var_0) {
  self.allowselfrevive = var_0;
  self setclientomnvar("_encstr_8C910F25C4697F39FC1379E8E71E70BD12", var_0);
}

laststandmonitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.watch_for_icbm_spawners)) {
    return;
  }
  for(;;) {
    waitframe();

    if(scripts\mp\utility\game::getgametypenumlives() == 0 && !istrue(level.disablespawning)) {
      continue;
    }
    level thread laststandkillteamifdown();
  }
}

laststandkillteamifdown() {
  foreach(var_1 in level.teamnamelist) {
    var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_1, 1);
    var_3 = [];

    foreach(var_5 in var_2) {
      if(istrue(var_5.inlaststand))
        var_3[var_3.size] = var_5;
    }

    if(var_3.size > 0 && var_2.size <= var_3.size) {
      level.laststandrequiresmelee = 0;

      foreach(var_5 in var_3) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_5 notify("_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B");
      }
    }
  }
}

getclassiclaststandpistol() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = weaponclass(var_2);

    if(weaponclass(var_2) == "_encstr_8D940738966ED1DB8D")
      return var_2;
  }

  var_2 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname("_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B"), [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  return var_2;
}

makelaststandinvuln() {
  var_0 = level.laststandinvulntime;
  clearlaststandinvuln();
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B19918C863B5E12D31A50716BB69770B19D378B19F46DBEB2A4D");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_A79E12EAB7934379DB1122408FC76075F0AB125D", 0, 0, ::laststandinvulnignorefunc);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", var_0);
  thread clearlaststandinvuln();
}

clearlaststandinvuln() {
  self notify("_encstr_B19918C863B5E12D31A50716BB69770B19D378B19F46DBEB2A4D");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_A79E12EAB7934379DB1122408FC76075F0AB125D", 0);
}

laststandinvulnignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
    return 1;

  return 0;
}

getdefaultlaststandtimervalue() {
  return 10;
}

getdefaultlaststandrevivetimervalue() {
  return 10;
}

getshellshockinterruptdelayms(var_0) {
  return var_0 * 1000;
}