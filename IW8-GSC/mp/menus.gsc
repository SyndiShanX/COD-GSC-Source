/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\menus.gsc
***********************************************/

init() {
  if(!isDefined(game["_encstr_A9310C0449DDA97F583FADB0FD01"])) {
    game["_encstr_ABD60A48F5C035CFEB0B177D"] = "_encstr_9A91121BA9086D0941332347057DF3D7285155E2";

    if(level.multiteambased)
      game["_encstr_ABD60A48F5C035CFEB0B177D"] = "_encstr_A54C105515F7D8C725C371E89BBB635073AB";

    game["_encstr_B4330B7A8075FBDFF1A1F1FBC6"] = "_encstr_959506B911C79707";
    game["_encstr_81FA126DCB705B77BE980A134398C75538BB1DFB"] = "_encstr_8AD00EE64D42B72317F730A08F4EB9EF";
    game["_encstr_A73010F86875073EB35B0E23C77F375024D3"] = "_encstr_AF080C592D59A086B1F7B195DF4B";
    game["_encstr_83C718D822CBD591BE089B8D2F6728119F3B9306CA7B81E8D70B"] = "_encstr_996B143744E2C83148E7A9F0278B56F837AB3BF0ADD6";
    game["_encstr_979116BB05C5F0F8DFCA69F042BFAE705E8B0F67A9A8E836"] = "_encstr_ABE012E78332101055EEB069922B99D87B13474D";

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        var_1 = "_encstr_A3570CB16DB3A3AFCEDA28B003E9" + level.teamnamelist[var_0];
        var_2 = "_encstr_958112B595DCAEBE8D34C2DC76CA8DD80B37CDBE" + level.teamnamelist[var_0];
        game[var_1] = game["_encstr_81FA126DCB705B77BE980A134398C75538BB1DFB"];
        game[var_2] = "_encstr_996B143744E2C83148E7A9F0278B56F837AB3BF0ADD6";
      }
    }

    game["_encstr_B4DA1155BDCD43477160AF8B3BE9339AABCE5A"] = "_encstr_9AE90C308B49E8EF4ACE39B722C3";
    game["_encstr_837C0E8D2B90BB975E181A4343A093F2"] = "_encstr_A6011080B8C1EF1917A1568F305BE5C819E0";

    if(level.splitscreen) {
      if(level.multiteambased) {
        for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
          var_1 = "_encstr_A3570CB16DB3A3AFCEDA28B003E9" + level.teamnamelist[var_0];
          var_2 = "_encstr_958112B595DCAEBE8D34C2DC76CA8DD80B37CDBE" + level.teamnamelist[var_0];
          game[var_1] = game[var_1] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
          game[var_2] = game[var_2] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
        }
      }

      game["_encstr_ABD60A48F5C035CFEB0B177D"] = game["_encstr_ABD60A48F5C035CFEB0B177D"] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
      game["_encstr_81FA126DCB705B77BE980A134398C75538BB1DFB"] = game["_encstr_81FA126DCB705B77BE980A134398C75538BB1DFB"] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
      game["_encstr_A73010F86875073EB35B0E23C77F375024D3"] = game["_encstr_A73010F86875073EB35B0E23C77F375024D3"] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
      game["_encstr_83C718D822CBD591BE089B8D2F6728119F3B9306CA7B81E8D70B"] = game["_encstr_83C718D822CBD591BE089B8D2F6728119F3B9306CA7B81E8D70B"] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
      game["_encstr_979116BB05C5F0F8DFCA69F042BFAE705E8B0F67A9A8E836"] = game["_encstr_979116BB05C5F0F8DFCA69F042BFAE705E8B0F67A9A8E836"] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
      game["_encstr_837C0E8D2B90BB975E181A4343A093F2"] = game["_encstr_837C0E8D2B90BB975E181A4343A093F2"] + "_encstr_AC3F0D29E3CA01F0339B5ECE659FD8";
      game["_encstr_BDA426135F2A7529BBC4C9202F65102132FFA7EFF322B490C5DD539BD95BC069EA4B5F1F334A8D10"] = "_encstr_BA5F2136D00BDC9DB21BB10BDCB97DDC0EC6B41D9B1BC92BB237AF3256CC0B57C6479B";
      game["_encstr_8CEC2403BD4D786047429178DA3726E8260387EF2373803D4F0A2EC393CBEBE0FA6B0D03CD1D"] = "_encstr_B2BB1FB02AF66D592FA3F17FAB2F061F1AD26890738E8DD107C6106685C7AB9F05";
    }

    precachestring(&"_encstr_85AE13653F4A78D88E89670795DDA0AC2125EEFD35");
    precachestring(&"_encstr_91C51999F13D69144F5CA0B56E3BDDC31D0891E9D84A112CE3A3A5");
  }

  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onleavegamecallback);
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onteamchangecallback);
  level scripts\common\ui::lui_registercallback("_encstr_88D00B37718B3BE3F7ED25D31C", ::onclasseditcallback);
  level scripts\common\ui::lui_registercallback("_encstr_A5EF0DF98DF99B2651677B6157FAED", ::onclasschoicecallback);
  level thread setintrocamnetworkmodel();
}

onteamchangecallback(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    if(var_0 != "_encstr_B1AC0C6340CF52777A284B638019") {
      return;
    }
    if(scripts\mp\utility\game::matchmakinggame()) {
      return;
    }
    handleteamchange(var_0, var_1);
  }
}

setintrocamnetworkmodel() {
  setintrocameraactive(1);
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setintrocameraactive(0);
}

update_enemies_remaining(var_0) {
  return var_0 >= 100;
}

getclasschoice(var_0) {
  var_0++;
  var_1 = undefined;

  if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag > 0) {
    if(scripts\mp\utility\game::matchmakinggame())
      var_2 = scripts\mp\rank::getrank() >= 4;
    else
      var_2 = 1;

    if(var_0 > 100) {
      var_3 = var_0 - 100;
      var_1 = "_encstr_86130F396BB313C7404F95C59DBAF1E73F" + var_3;
    } else if(!var_2)
      var_1 = "_encstr_A17A10F0BB3219197F6DB5B977B381875F47";
    else
      var_1 = "_encstr_A90B0D7BF38003BF978062EAA87DCF" + var_0;
  } else if(var_0 > 100) {
    var_3 = var_0 - 100;
    var_1 = "_encstr_8B1608EC43B8D647A113" + var_3;
  } else
    var_1 = "_encstr_BD34078D57B9A37BD6" + var_0;

  return var_1;
}

updateloadoutselect(var_0) {
  var_1 = isai(self) || issubstr(self.name, "_encstr_961706FBD19E7FDB");

  if(!var_1)
    return;
}

executeclasschange(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isbot(self) || initmaxspeedforpathlengthtable(self)) {
    self.pers["_encstr_959506B911C79707"] = var_0;
    self.class = var_0;
  } else {
    var_2 = getclasschoice(var_0);

    if(!isDefined(self.pers["_encstr_959506B911C79707"]) || var_2 != self.pers["_encstr_959506B911C79707"] || var_1) {
      self.pers["_encstr_959506B911C79707"] = var_2;
      self.class = var_2;
      scripts\mp\class::preloadandqueueclass(var_2);
    }

    var_3 = 1;
    var_4 = scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic());

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !var_4)
      var_3 = 0;

    if(scripts\mp\class::shouldallowinstantclassswap() && var_3) {
      scripts\cp_mp\utility\inventory_utility::getridofweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
      thread scripts\mp\class::swaploadout();
    } else {
      var_5 = scripts\mp\utility\game::unset_relic_grounded() && self calloutmarkerping_entityzoffset("_encstr_8C0314EA4BBEB7C1CA377D36B7C223DB5D8EBE3185CE");

      if(isalive(self) && !var_5)
        self iprintlnbold(game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_841C0D6C34B09B3BB2AF8D36B09B37"]);

      if(var_0 < 100)
        self setclientomnvar("_encstr_B4E613F3B229C48D99790F254331BFF49E6399DA20", scripts\mp\class::getclassindex(self.pers["_encstr_959506B911C79707"]));
    }
  }
}

setnextroundclass(var_0) {
  var_1 = var_0;

  if(!isbot(self)) {
    if(isalive(self))
      self iprintlnbold(game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_B4CA0D6517E33338F541F128F6CB58"]);

    var_1 = getclasschoice(var_0);
  }

  self.pers["_encstr_954311604208F1F6EB479537243739B9364B10"] = var_1;
}

onleavegamecallback(var_0, var_1) {
  if(var_0 != "_encstr_A3AF090768A9910F4118EF") {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(isdedicatedserver()) {
    return;
  }
  level thread scripts\mp\gamelogic::forceend(var_1);
}

onclasseditcallback(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waittillframeend;
  handleclassedit(var_0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_A7321A10206B3779A25B8D31E94F6753A2F25BEDD07F5D100E4C8723(getclasschoice(var_0));
}

onclasschoicecallback(var_0, var_1) {
  if(scripts\mp\utility\game::usefloorrocks()) {
    if(var_0 < 100)
      var_0 = var_0 + 100;
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && var_0 == -1 && getdvarint("_encstr_932C1B0B7E330F01ABEF6DFF5F51D3AF732B21733704C86304FB50B77A", 0) == 0) {
    return;
  }
  self notify("_encstr_B4C617593F92B5F0E58B76C9B5D95876292733D18F1A05780C", var_0);

  if(level.systemlink && getdvarint("_encstr_BA8A0BC49EA68A9654A2292A53") && self ismlgspectator())
    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
  else {
    updateloadoutselect(var_0);

    if(istrue(self.waitingtoselectclass)) {
      if(isDefined(self.revive_chosenclass))
        setnextroundclass(var_0);

      self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
      return;
    }

    if(!scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout()) {
      return;
    }
    if(isDefined(self.revive_chosenclass) && isDefined(self.instantclassswapallowed) && !scripts\mp\class::shouldallowinstantclassswap()) {
      setnextroundclass(var_0);
      return;
    }

    if("_encstr_B40101" + var_0 != "_encstr_A7AA09C616D81B26586CB5") {
      executeclasschange(var_0, istrue(var_1));
      return;
    }

    menuclass("_encstr_A7AA09C616D81B26586CB5");
  }
}

handleteamchange(var_0, var_1) {
  var_2 = 0;

  if(var_1 >= 3)
    var_2 = 1;

  if(var_2) {
    self setclientomnvar("_encstr_9B1816D5836E7E9B6291432AA3572381FBE080BB6F0595E3", 1);
    self.spectating_actively = 1;
  } else {
    self setclientomnvar("_encstr_9B1816D5836E7E9B6291432AA3572381FBE080BB6F0595E3", -1);
    self.spectating_actively = 0;
  }

  var_3 = self ismlgspectator();
  var_4 = !var_3 && isDefined(self.team) && (self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.team == "_encstr_933E090A10B17DDFB3E522");
  var_5 = var_3 && var_1 == 3 || var_4 && (var_1 == 4 || var_1 == 5);

  if(var_1 == 4 || var_1 == 5) {
    var_1 = 3;
    self setmlgspectator(1);
  } else
    self setmlgspectator(0);

  if(var_1 == 0)
    var_1 = "_encstr_8E8405EA382B2A";
  else if(var_1 == 1)
    var_1 = "_encstr_9A8507BA4040188D08";
  else if(var_1 == 2)
    var_1 = "_encstr_A31207CBF788523281";
  else
    var_1 = "_encstr_AF8C0A1B6A1D6045925B4F7D";

  if(!var_5 && isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && var_1 == self.pers["_encstr_8AEF05472BC2D6"]) {
    return;
  }
  if(isDefined(self.operatorcustomization))
    self.operatorcustomization.rebuild = 1;

  thread logteamselection(var_1);

  if(var_1 != "_encstr_AF8C0A1B6A1D6045925B4F7D")
    self.pers["_encstr_BE0819E2C9C3936D4309BB9FB099134B93D66BDEAD779B8449F0A7"] = undefined;
  else
    self.pers["_encstr_BE0819E2C9C3936D4309BB9FB099134B93D66BDEAD779B8449F0A7"] = 1;

  if(var_1 == "_encstr_8E8405EA382B2A")
    thread setteam("_encstr_8E8405EA382B2A");
  else if(var_1 == "_encstr_9A8507BA4040188D08")
    thread setteam("_encstr_9A8507BA4040188D08");
  else if(var_1 == "_encstr_A31207CBF788523281")
    thread autoassign();
  else if(var_1 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    thread setspectator(var_5);
}

handleclassedit(var_0) {
  var_1 = getclasschoice(var_0);
  var_2 = scripts\mp\class::loadout_editcachedclassstruct(var_1);
  var_3 = scripts\mp\class::zombieregenratescaleoutgas();
  var_4 = var_2 || var_3;

  if(isDefined(self.pers["_encstr_959506B911C79707"]) && var_1 == self.pers["_encstr_959506B911C79707"] && var_4)
    onclasschoicecallback(var_0, 1);
}

autoassign() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163")
    thread setteam("_encstr_9A8507BA4040188D08");
  else if(getdvarint("_encstr_BD6714A643EBCEC3F262B9D0BACFB3E0EFDBAF17CF73", 0) != 0)
    thread setteam("_encstr_9A8507BA4040188D08");
  else if(brking_updateteamscore())
    thread setteam("_encstr_9A8507BA4040188D08");
  else {
    if(isbot(self) && isDefined(self.bot_team) && self.bot_team != "_encstr_8F4B0BD00FAC3813FB1A0B0435") {
      thread setteam(self.bot_team);
      return;
    }

    if(self ismlgspectator()) {
      thread setspectator();
      return;
    }

    if(istrue(level.teammaxfill)) {
      foreach(var_1 in level.teamnamelist) {
        if(scripts\mp\teams::_id_132E6() && var_1 == "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8") {
          continue;
        }
        var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_AB580A05672AE35D5FFF50B8");

        if(level.maxteamsize == 0 || var_2 < level.maxteamsize) {
          thread setteam(var_1);
          break;
        }
      }

      return;
    }

    var_4 = 0;
    var_5 = [];

    foreach(var_1 in level.teamnamelist) {
      if(scripts\mp\teams::_id_132E6() && var_1 == "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8") {
        continue;
      }
      var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_AB580A05672AE35D5FFF50B8");

      if(isDefined(self.team) && self.team == var_1)
        var_2--;

      if(!var_5.size || var_2 < var_4) {
        var_4 = var_2;
        var_5 = [];
        var_5[var_5.size] = var_1;
        continue;
      }

      if(var_2 == var_4)
        var_5[var_5.size] = var_1;
    }

    if(var_5.size == 1) {
      if(!isDefined(self.team) || self.team != var_5[0]) {
        thread setteam(var_5[0]);
        return;
      }

      return;
    }

    if(level.teambased) {
      var_8 = scripts\mp\gamescore::gethighestscoringteam();

      if(scripts\engine\utility::array_contains(var_5, var_8))
        var_5 = scripts\engine\utility::array_remove(var_5, var_8);
    }

    if(isDefined(self.team) && scripts\engine\utility::array_contains(var_5, self.team))
      var_5 = scripts\engine\utility::array_remove(var_5, self.team);

    if(var_5.size > 0) {
      var_9 = randomint(var_5.size);

      if(istrue(level.checkforlaststandfinish))
        var_9 = 0;

      thread setteam(var_5[var_9]);
    }
  }
}

setteam(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isai(self) && level.teambased && !scripts\mp\teams::getjointeampermissions(var_0) && !scripts\mp\utility\game::lobbyteamselectenabled()) {
    return;
  }
  if(level.ingraceperiod && !self.hasdonecombat) {
    self.hasspawned = 0;
    self.pers["_encstr_8CAA06DB20A31543"] = scripts\mp\utility\game::getgametypenumlives();
  }

  if(self.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
    self.switching_teams = 1;
    self.joining_team = var_0;
    self.leaving_team = self.pers["_encstr_8AEF05472BC2D6"];

    if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916")
      self.switching_teams_arena = 1;
  }

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) && isbot(self) == 0)
    var_0 = "_encstr_9A8507BA4040188D08";

  addtoteam(var_0);

  if(shouldmodesetsquads())
    thread setsquad(var_0);

  if(scripts\mp\utility\player::isragdollzerog())
    self lockdeathcamera(1);

  if(self.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
    self suicide();
    scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
    self.suicideswitched = 1;
  }

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("_encstr_AF121CB812BA97E18F4A8EF50FD749B7A9BB088049162378BB530DFF0B2F", 0) == 1 && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9936086E0BB9324CDBC3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
      var_1 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::laststand_dogtags("_encstr_B4DD0BD2BDF9517D31488A963A" + self.name + "_encstr_862F2E56E5B3910763D0DF3FF8FBFF7A73F08BEE69493F1C4150C33BD8539B32D39692BEBB6F429BB171BF2BA0E12D3E" + var_1);
    }

    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  }

  if(isDefined(level._id_12065))
    self thread[[level._id_12065]]();

  waitforclassselect();
  endrespawnnotify();

  if((self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" || _id_125F1()) && !istrue(self.suicideswitched)) {
    if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
      return;
    }
    if(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B" && !scripts\mp\utility\player::isinkillcam()) {
      if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
        return;
      }
      thread scripts\mp\playerlogic::spawnclient();
    }

    thread scripts\mp\spectating::setspectatepermissions();
  }

  self.suicideswitched = undefined;
  self notify("_encstr_B6490A92A03C30911B037F70");
}

_id_125F1() {
  return isDefined(level._id_125F1) && self[[level._id_125F1]]();
}

shouldmodesetsquads() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A10C0780F23F6F400B":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_931D068662634370":
    case "_encstr_A9B606B0C956B916":
    case "_encstr_B81904B04E6B":
      return 1;
    case "_encstr_B607038AAB":
      return _id_13733();
    default:
      return 0;
  }
}

setsquad(var_0) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(level.squaddata))
    level initsquaddata();

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_1 = self getsquadindex();
    joinsquad(var_0, var_1);
    return;
  }

  var_2 = issubstr(self.name, "_encstr_961706FBD19E7FDB") || issubstr(self.name, "_encstr_8C43057D1AB1EB");

  if(!isai(self) && !var_2) {
    var_3 = self getlobbysquadindex();

    if(var_3 != -1) {
      self.squadassignedfromlobby = 1;
      joinsquad(var_0, var_3);
      return;
    }
  }

  if(istrue(scripts\mp\utility\game::matchmakinggame())) {
    var_4 = self getfireteammembers();

    if(isDefined(var_4) && var_4.size > 0) {
      var_1 = undefined;

      foreach(var_6 in var_4) {
        if(isDefined(var_6) && isDefined(var_6.squadindex)) {
          var_1 = var_6.squadindex;
          break;
        }
      }

      if(isDefined(var_1)) {
        joinsquad(var_0, var_1);
        return;
      } else {
        requestnewsquad(var_0, 1);
        return;
      }
    }
  }

  if(var_0 != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    foreach(var_9 in level.squaddata[var_0]) {
      var_9.isfull = var_9.players.size == level.maxsquadsize;

      if(var_9.inuse && !var_9.isfireteam && !var_9.isfull) {
        joinsquad(var_0, var_9.index);
        return;
      }
    }

    requestnewsquad(var_0, 0);
  }
}

initsquaddata() {
  if(!isDefined(level.maxsquadsize))
    level.maxsquadsize = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8D2B0B5FF8373DC16C1FA7CB6B", 4);

  level.maxsquadwait = getdvarint("_encstr_A31913E61B9C7D9BE2AEC219D75B2C1EEBEE0B5AA3", 15);
  level.squaddata = [];

  foreach(var_1 in level.teamnamelist)
  level.squaddata[var_1] = [];

  level thread monitorsquads();

  if(getdvarint("_encstr_873B11FA49B07F5AA5D5DF9F4756F3ADC03172", 0) == 1)
    level thread debugprintsquads();
}

createsquad(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level.squaddata[var_0].size;

  var_2 = spawnStruct();
  var_2.index = var_1;
  var_2.formedtime = undefined;
  var_2.isfireteam = 0;
  var_2.isstale = 0;
  var_2.isfull = 0;
  var_2.inuse = 0;
  var_2.players = [];
  var_2.spawnpoint = undefined;
  level.squaddata[var_0][var_1] = var_2;
  return var_1;
}

checksquads() {
  foreach(var_1 in level.teamnamelist) {
    if(!isDefined(level.squaddata[var_1])) {
      continue;
    }
    foreach(var_3 in level.squaddata[var_1]) {
      if(!var_3.inuse) {
        continue;
      }
      if(!var_3.isstale && gettime() > var_3.formedtime + level.maxsquadwait * 1000)
        var_3.isstale = 1;

      var_3.isfull = var_3.players.size == level.maxsquadsize;
      var_4 = 0;

      foreach(var_6 in var_3.players) {
        if(isDefined(var_6))
          var_4 = 1;
      }

      if(!var_4)
        freesquadindex(var_1, var_3.index);
    }
  }
}

monitorsquads() {
  for(;;) {
    checksquads();
    waitframe();
  }
}

requestnewsquad(var_0, var_1) {
  var_2 = getavailablesquadindex(var_0);
  var_3 = level.squaddata[var_0][var_2];
  var_3.index = var_2;
  var_3.formedtime = gettime();
  var_3.isfireteam = var_1;
  var_3.isstale = 0;
  var_3.isfull = 0;
  var_3.inuse = 1;
  var_3.players = [];
  var_3.squadstartlocationkey = undefined;
  var_3.infil = undefined;
  joinsquad(var_0, var_2);
}

joinsquad(var_0, var_1) {
  if(!isDefined(level.squaddata[var_0][var_1]))
    createsquad(var_0, var_1);

  var_2 = isDefined(self.pers["_encstr_AFE90B9B1757C2469273232BE1"]) && self.pers["_encstr_AFE90B9B1757C2469273232BE1"] == var_1;

  if(isDefined(self.squadindex)) {
    var_3 = 0;

    foreach(var_9, var_5 in level.squaddata) {
      foreach(var_8, var_7 in var_5) {
        if(scripts\engine\utility::array_contains(var_7.players, self)) {
          level.squaddata[var_9][var_8].players = scripts\engine\utility::array_remove(var_7.players, self);
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }
  }

  self.squadindex = var_1;
  self.pers["_encstr_AFE90B9B1757C2469273232BE1"] = var_1;

  if(!var_2 || !isDefined(self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"])) {
    self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] = level.squaddata[var_0][var_1].players.size;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
      self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]++;
  }

  if(!istrue(scripts\mp\utility\game::matchmakinggame()))
    self setsquadindex(var_1);

  level.squaddata[var_0][var_1].players[level.squaddata[var_0][var_1].players.size] = self;
  scripts\mp\utility\join_squad_aggregator::onplayerjoinsquad(self);
  self notify("_encstr_84760DD4F696DCCA32D7B9C5AB5891");

  if(istrue(level.usesquadleader))
    choosesquadleader(var_0, var_1);

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    updatesquadomnvars(var_0, var_1);
}

leavesquad(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    level.squaddata[var_0][var_1].players = scripts\engine\utility::array_remove(level.squaddata[var_0][var_1].players, self);
    return;
  }

  if(isDefined(var_0) && isDefined(var_1))
    thread scripts\mp\spawnselection::_id_12ACB(var_0, var_1);

  var_2 = 0;
  var_3 = getsquadleader(var_0, var_1);

  if(istrue(level.usesquadleader) && isDefined(var_3) && var_3 == self) {
    level.squaddata[var_0][var_1].squadleaderindex = undefined;
    var_2 = 1;
  }

  level.squaddata[var_0][var_1].players = scripts\engine\utility::array_remove(level.squaddata[var_0][var_1].players, self);

  for(var_4 = 0; var_4 < level.squaddata[var_0][var_1].players.size; var_4++)
    level.squaddata[var_0][var_1].players[var_4].pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] = var_4;

  if(istrue(var_2)) {
    var_5 = scripts\engine\utility::array_randomize(level.squaddata[var_0][var_1].players);

    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 choosesquadleader(var_0, var_1);
        break;
      }
    }
  }

  updatesquadomnvars(var_0, var_1);
}

updatesquadomnvars(var_0, var_1) {
  var_2 = getsquadleader(var_0, var_1);

  foreach(var_4 in level.squaddata[var_0][var_1].players) {
    var_5 = var_1;
    var_5 = var_5 + (level.squaddata[var_0][var_1].players.size << 5);

    if(isDefined(var_2) && var_2 == var_4)
      var_5 = var_5 + 256;

    var_4 setclientomnvar("_encstr_93280ED351E1A897FF3291FE4A87CDE0", var_5);

    if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" || scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370") {
      var_6 = var_4.game_extrainfo & 65528;
      var_4.game_extrainfo = var_6 | var_4.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] + 1;

      if(isDefined(var_2) && var_2 == var_4)
        var_4.game_extrainfo = var_4.game_extrainfo | 64;
      else
        var_4.game_extrainfo = var_4.game_extrainfo &~64;

      var_7 = var_4 getentitynumber();

      if(isDefined(var_2) && var_2 == var_4)
        var_7 = var_7 + 2048;

      if(isalive(var_4))
        var_7 = var_7 + 4096;

      var_4 setclientomnvar("_encstr_87FD150832716BE307E7067FA55F692BA7DA082B1B9901", var_7);
      var_8 = scripts\engine\utility::array_remove(level.squaddata[var_0][var_1].players, var_4);

      for(var_9 = 0; var_9 < 3; var_9++) {
        var_10 = var_8[var_9];

        if(isDefined(var_10)) {
          var_7 = var_10 getentitynumber();

          if(isDefined(var_2) && var_2 == var_10)
            var_7 = var_7 + 2048;

          if(isalive(var_10))
            var_7 = var_7 + 4096;
        } else
          var_7 = -1;

        var_4 setclientomnvar("_encstr_8FCF14D5B4EB1639B57DCDB85DB0C8B595D626CA9CBE" + (var_9 + 1), var_7);
      }
    }
  }
}

getavailablesquadindex(var_0) {
  foreach(var_2 in level.squaddata[var_0]) {
    if(!var_2.inuse)
      return var_2.index;
  }

  return createsquad(var_0);
}

freesquadindex(var_0, var_1) {
  level.squaddata[var_0][var_1].formedtime = undefined;
  level.squaddata[var_0][var_1].isfireteam = 0;
  level.squaddata[var_0][var_1].isstale = 0;
  level.squaddata[var_0][var_1].isfull = 0;
  level.squaddata[var_0][var_1].inuse = 0;
  level.squaddata[var_0][var_1].players = [];
  level.squaddata[var_0][var_1].squadstartlocationkey = undefined;
  level.squaddata[var_0][var_1].infil = undefined;
}

choosesquadleader(var_0, var_1) {
  if(isDefined(getsquadleader(var_0, var_1))) {
    return;
  }
  if(istrue(scripts\mp\utility\game::matchmakinggame())) {
    var_2 = self getfireteammembers();

    if(isDefined(var_2) && var_2.size > 0) {
      if(self isfireteamleader()) {
        foreach(var_5, var_4 in level.squaddata[self.team][self.squadindex].players) {
          if(var_4 == self)
            level.squaddata[var_0][var_1].squadleaderindex = var_5;
        }
      } else
        return;
    }
  }

  foreach(var_5, var_4 in level.squaddata[self.team][self.squadindex].players) {
    if(var_4 == self)
      level.squaddata[var_0][var_1].squadleaderindex = var_5;
  }
}

getsquadleader(var_0, var_1) {
  var_2 = level.squaddata[var_0][var_1].squadleaderindex;

  if(!isDefined(var_2))
    return undefined;

  return level.squaddata[var_0][var_1].players[var_2];
}

_id_13733() {
  return getdvarint("_encstr_9BB10B623996B44A264528394D", 0) != 0;
}

brking_updateteamscore() {
  return getdvarint("_encstr_81550ADDC077A379DAC82247", 0) != 0;
}

setspectator(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "_encstr_AF8C0A1B6A1D6045925B4F7D";
    self.leaving_team = self.pers["_encstr_8AEF05472BC2D6"];

    if(self.sessionstate == "_encstr_877508C1D8C22F2DDC3B")
      self suicide();
  }

  self notify("_encstr_B6A41013CA3658DA95A6E059B11D0B8EF639");
  addtoteam("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self.pers["_encstr_959506B911C79707"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

setfollower(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_933E090A10B17DDFB3E522") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "_encstr_933E090A10B17DDFB3E522";
    self.leaving_team = self.pers["_encstr_8AEF05472BC2D6"];
    self suicide();
  }

  self notify("_encstr_B6A41013CA3658DA95A6E059B11D0B8EF639");
  addtoteam("_encstr_933E090A10B17DDFB3E522");
  self.pers["_encstr_959506B911C79707"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

waitforclassselect() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.waitingtoselectclass = 1;

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && istrue(level.usespawnselection) && !istrue(self.hasspawned)) {
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1.0);
    self setclientomnvar("_encstr_9AC413AB96BEA14BC8567D7B4CA62B36D14B675937", 1);
    self setclientomnvar("_encstr_A63C1393641F0870B99FB9A3B792D090F9FD198B8E", 1);
  }

  for(;;) {
    var_0 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::allowclasschoice() && (!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || istrue(level._id_133E0) || istrue(level.dmztut_endgametransition));
    var_1 = scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4") && !isDefined(level.bypassclasschoicefunc);

    if(var_0 || var_1) {
      var_2 = "_encstr_A5EF0DF98DF99B2651677B6157FAED";

      if(!isai(self)) {
        var_3 = scripts\mp\rank::getrank() >= 4;

        if(var_3 && !scripts\mp\utility\game::tv_station_intro_camera())
          var_4 = self getplayerdata(level.loadoutsgroup, "_encstr_AC3B17D8AEE6D1F6D696D3581DD27B9B230BB3BDC9A58ECA37", "_encstr_9951158731A87733BBE197CB2F579ABF683BF40D095818");
        else
          var_4 = 100;
      } else
        var_4 = "_encstr_A7AA09C616D81B26586CB5";
    } else if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
      if(!self ismlgspectator() && getdvarint("_encstr_8D9B112D074310378FF7141FC16538FB931B25", 0) == 0 && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B")
        scripts\mp\utility\lower_message::setlowermessageomnvar(15);

      self waittill("_encstr_B4C617593F92B5F0E58B76C9B5D95876292733D18F1A05780C", var_4);
    } else {
      bypassclasschoice();
      break;
    }

    if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if("_encstr_B40101" + var_4 != "_encstr_A7AA09C616D81B26586CB5") {
      if(isbot(self)) {
        self.pers["_encstr_959506B911C79707"] = var_4;
        self.class = var_4;
      } else {
        var_4 = var_4;
        self.pers["_encstr_959506B911C79707"] = getclasschoice(var_4);
        self.class = getclasschoice(var_4);
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      self.waitingtoselectclass = 0;
    } else {
      self.waitingtoselectclass = 0;
      menuclass("_encstr_A7AA09C616D81B26586CB5");
    }

    break;
  }
}

beginclasschoice(var_0) {
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("_encstr_AF121CB812BA97E18F4A8EF50FD749B7A9BB088049162378BB530DFF0B2F", 0) == 1 && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9936086E0BB9324CDBC3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
      var_2 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::laststand_dogtags("_encstr_AF8614F0E7EFCB2597681FC2C0BE18AFB8EE8F32A348" + self.name + "_encstr_862F2E56E5B3910763D0DF3FF8FBFF7A73F08BEE69493F1C4150C33BD8539B32D39692BEBB6F429BB171BF2BA0E12D3E" + var_2);
    }

    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);

    if(!self ismlgspectator())
      waitforclassselect();

    endrespawnnotify();

    if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
        return;
      }
      if(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B" && !scripts\mp\utility\player::isinkillcam()) {
        if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }
        thread scripts\mp\playerlogic::spawnclient();
      }

      thread scripts\mp\spectating::setspectatepermissions();
    }

    self.connecttime = gettime();
    self notify("_encstr_B6490A92A03C30911B037F70");
  } else
    thread bypassclasschoice();
}

bypassclasschoice() {
  self.selectedclass = 1;
  self.waitingtoselectclass = 0;

  if(updatetimedrunhud() && level.enforceantiboosting && !isbot(self)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    self notifyonplayercommand("_encstr_BD6C0D4B03FD9F8AF9BF3B70BB3815", "_encstr_97410B23BD6B976233901AF2F8");
    self notifyonplayercommand("_encstr_BD6C0D4B03FD9F8AF9BF3B70BB3815", "_encstr_B4C60AD707B2BDC0E6CE1309");
    thread waitthensetspawnomnvar();
    self waittill("_encstr_BD6C0D4B03FD9F8AF9BF3B70BB3815");
  }

  if(isDefined(level.bypassclasschoicefunc)) {
    var_0 = self[[level.bypassclasschoicefunc]]();
    self.class = var_0;
  } else
    self.class = "_encstr_AB8007922817677232";
}

updatetimedrunhud() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163")
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_9707038CB6" && istrue(level.aonrules))
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_8A1804DAAB75")
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916")
    return 1;

  return 0;
}

waitthensetspawnomnvar() {
  self endon("_encstr_BD6C0D4B03FD9F8AF9BF3B70BB3815");
  wait 1;

  if(isDefined(self))
    scripts\mp\utility\lower_message::setlowermessageomnvar(1);
}

beginteamchoice() {
  self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 1);
}

menuspectator() {
  if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "_encstr_AF8C0A1B6A1D6045925B4F7D";
    self.leaving_team = self.pers["_encstr_8AEF05472BC2D6"];
    self suicide();
  }

  addtoteam("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self.pers["_encstr_959506B911C79707"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

menuclass(var_0) {
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];
  var_2 = scripts\mp\class::getclasschoice(var_0);
  var_3 = scripts\mp\class::getweaponchoice(var_0);

  if(var_2 == "_encstr_83E00BE4CA6ED1272DC68E5632") {
    beginclasschoice();
    return;
  }

  if(isDefined(self.pers["_encstr_959506B911C79707"]) && self.pers["_encstr_959506B911C79707"] == var_2 && (isDefined(self.pers["_encstr_BA7F0830B3A7859B60B0"]) && self.pers["_encstr_BA7F0830B3A7859B60B0"] == var_3)) {
    return;
  }
  if(self.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
    if(isDefined(self.pers["_encstr_92690A5B078ED325F539E25E"]) && isDefined(self.pers["_encstr_959506B911C79707"])) {
      self.pers["_encstr_92690A5B078ED325F539E25E"] = self.pers["_encstr_959506B911C79707"];
      self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
    }

    self.pers["_encstr_959506B911C79707"] = var_2;
    self.class = var_2;
    self.pers["_encstr_BA7F0830B3A7859B60B0"] = var_3;

    if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
      return;
    }
    if(level.ingraceperiod && !self.hasdonecombat) {
      scripts\mp\class::setclass(self.pers["_encstr_959506B911C79707"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      scripts\mp\class::giveloadout(self.pers["_encstr_8AEF05472BC2D6"], self.pers["_encstr_959506B911C79707"]);
    } else
      self iprintlnbold(game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_841C0D6C34B09B3BB2AF8D36B09B37"]);
  } else {
    if(isDefined(self.pers["_encstr_92690A5B078ED325F539E25E"]) && isDefined(self.pers["_encstr_959506B911C79707"])) {
      self.pers["_encstr_92690A5B078ED325F539E25E"] = self.pers["_encstr_959506B911C79707"];
      self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
    }

    self.pers["_encstr_959506B911C79707"] = var_2;
    self.class = var_2;
    self.pers["_encstr_BA7F0830B3A7859B60B0"] = var_3;

    if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
      return;
    }
    if(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B" && !scripts\mp\utility\player::isinkillcam())
      thread scripts\mp\playerlogic::spawnclient();
  }

  thread scripts\mp\spectating::setspectatepermissions();
}

addtoteam(var_0, var_1, var_2) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();

    if(isDefined(var_2) && var_2)
      scripts\mp\playerlogic::decrementalivecount(self.team, 0, "_encstr_87B00AB8F2AF115093AD7F61");

    if(shouldmodesetsquads() && isDefined(self.squadindex) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D")
      leavesquad(self.team, self.squadindex);
  }

  if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && self.pers["_encstr_8AEF05472BC2D6"] != "_encstr_B40101" && self.pers["_encstr_8AEF05472BC2D6"] != "_encstr_AF8C0A1B6A1D6045925B4F7D")
    self.pers["_encstr_82AE0ABC1348CBA7E549FA22"] = self.pers["_encstr_8AEF05472BC2D6"];

  self.changedteams = isDefined(self.pers["_encstr_82AE0ABC1348CBA7E549FA22"]) && self.pers["_encstr_82AE0ABC1348CBA7E549FA22"] != var_0;
  self.pers["_encstr_8AEF05472BC2D6"] = var_0;
  self.team = var_0;
  var_3 = isbot(self) || initmaxspeedforpathlengthtable(self);

  if(var_3)
    setsessionteam(var_0);
  else if(!scripts\mp\utility\game::denysystemicteamchoice()) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      if(!scripts\mp\utility\game::allowteamassignment()) {
        if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163")
          setsessionteam(var_0);
        else
          setemptysessionteam(var_0);
      }
    } else if(!_func_426())
      setsessionteam(var_0);
  }

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_ACE709DA22939BA8075060")
    scripts\mp\playerlogic::addtoteamcount(istrue(var_2));

  scripts\mp\utility\game::updateobjectivetext();

  if(isDefined(var_1) && var_1)
    waittillframeend;

  if(var_0 == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_0 == "_encstr_933E090A10B17DDFB3E522") {
    self notify("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    scripts\mp\teams::onjoinedspectators(self);
    scripts\mp\spectating::onjoinedspectators(self);
    scripts\mp\bounty::onplayerjoinedspectators(self);
    scripts\cp_mp\pet_watch::_id_12044();
  } else
    self notify("_encstr_81170C244F9CBDE72C01BB99A298");

  scripts\mp\utility\join_team_aggregator::onplayerjointeam(self);
  scripts\mp\infilexfil\infilexfil::onjoinedteam(self);
  level notify("_encstr_B1750C47E049978B0F78C3BF5F23", self);
}

setsessionteam(var_0) {
  if(level.teambased)
    self.sessionteam = var_0;
  else
    setemptysessionteam(var_0);
}

setemptysessionteam(var_0) {
  if(var_0 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    self.sessionteam = "_encstr_AF8C0A1B6A1D6045925B4F7D";
  else if(var_0 == "_encstr_933E090A10B17DDFB3E522")
    self.sessionteam = "_encstr_933E090A10B17DDFB3E522";
  else
    self.sessionteam = "_encstr_8BBA05185F8B99";
}

endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("_encstr_8CBF0C557DA25F93BD1F48C867DE");
}

logteamselection(var_0) {
  if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) == 0) {
    return;
  }
  if(var_0 != "_encstr_A31207CBF788523281")
    iprintlnbold("_encstr_B40101" + self.name + "_encstr_BD5F1CC260682C4E8DE0436ED6B342F5F1083A4F70636FC6EB868A34347D");
}

debugprintsquads() {
  var_0 = 25;

  for(;;) {
    if(isDefined(level.squaddata)) {
      var_1 = 800;
      var_2 = 25;
      var_3 = 1;

      foreach(var_13, var_5 in level.squaddata) {
        var_3 = 1;
        var_3++;

        foreach(var_7 in var_5) {
          var_8 = (1, 1, 1);

          if(isDefined(var_7.activemission))
            var_8 = (1, 1, 0);

          var_3++;

          foreach(var_10 in var_7.players) {
            var_8 = (1, 1, 1);

            if(istrue(var_10.squadassignedfromlobby))
              var_8 = (0, 1, 0);

            var_3++;
          }
        }

        var_1 = var_1 + 200;
      }
    }

    waitframe();
  }
}