/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\sotf.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0 = [];
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    level.matchrules_randomize = 0;
  }

  setplayerloadout();
  level.teambased = 1;
  level.overridecrateusetime = 500;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.cratekill = ::cratekill;
  level.pickupweaponhandler = ::pickupweaponhandler;
  level.iconvisall = ::iconvisall;
  level.objvisall = ::objvisall;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.vehicleoverride = "_encstr_8D7E1648521385D8EFD27B45FC59F0C5BF1B0311EA67B170";
  level.usedlocations = [];
  level.emptylocations = 1;
  level.firstcratedrop = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_842707D05D371DB223";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_97690AE60FB3A9D774E20820";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_97690AE60FB3A9D774E20820";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_969A15180FF2969F827354F08E6B83BB4D9F60803FB64B", getmatchrulesdata("_encstr_95CB0937B8E065412F4BC1", "_encstr_924D0CAA085B8B07A531EF0D58EB"));
  setdynamicdvar("_encstr_9B0F18E6D8E47DDCBD3A66AF8D93163A56EC5DDC0B5BEDBACD1D", getmatchrulesdata("_encstr_95CB0937B8E065412F4BC1", "_encstr_A90C0FC64EB03A5974BAB90AB5BDEAE6D1"));
  setdynamicdvar("_encstr_862A1482EE85911B80D0E3FF90DBC1EB73FD8CBD45ED", getmatchrulesdata("_encstr_95CB0937B8E065412F4BC1", "_encstr_A1450F0E22AA5119F463D818C3E1D0BB43"));
  setdynamicdvar("_encstr_96F2142EFB5376477DEB8041E3153328636CBBA95993", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_A11805E67B3A33", 1);
  setdynamicdvar("_encstr_AAF81272C138F79328710BF76FC38A0C18E86C3B", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_A11805E67B3A33", 1);
  setdynamicdvar("_encstr_BAC012BA66F88E42F26321D91406C522980989C7", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_A11805E67B3A33", 0);
  setdynamicdvar("_encstr_A9831150C790BF6F02DDE747D8EB98EF7D8DA7", 0);
}

onprecachegametype() {
  level._effect["_encstr_AF4D129B4BD9DC58C67D6C4395B91DFA91E4F60E"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level._effect["_encstr_A21418C3D84443A660B77370EBB02B3F7D139A7B66290F5BF015"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  var_2 = &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75";
  var_3 = &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F";
  var_4 = &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A";

  foreach(var_6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_6, var_2);

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_6, var_2);
    else
      scripts\mp\utility\game::setobjectivescoretext(var_6, var_3);

    scripts\mp\utility\game::setobjectivehinttext(var_6, var_4);
  }

  initspawns();
  level thread sotf();
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

setplayerloadout() {
  definechestweapons();
  var_0 = getrandomweapon(level.pistolarray);
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0["_encstr_84BA05A8CA852B"]);
  var_2 = tablelookup("_encstr_B68813ADC179CDEDD1CC5D2B16E07BCD37718DCD3B", 2, var_1, 0);
  setomnvar("_encstr_B4620F7B6097FA9F93244F784B9B3B0509", int(var_2));
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = var_0["_encstr_84BA05A8CA852B"];
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_83BC1124F069D3E5D3907833B0C31A4F41E8A4"] = "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A9C30F63DE858CDB57E8F499991A2CDCC8"] = "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.sotf_loadouts["_encstr_8E8405EA382B2A"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_86C61787A9F5722930B83378F670671A5C2B1B0F51A61A16C0", "_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953"];
  level.sotf_loadouts["_encstr_9A8507BA4040188D08"] = level.sotf_loadouts["_encstr_8E8405EA382B2A"];
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else
    var_2 = undefined;

  return var_2;
}

onspawnplayer() {
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  self.class = self.pers["_encstr_959506B911C79707"];
  self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.sotf_loadouts[self.pers["_encstr_8AEF05472BC2D6"]];
  level notify("_encstr_92F614981FFB1FCF8FD112436DD8AF4079EF8370FD9F", self);
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  thread waitloadoutdone();
}

waitloadoutdone() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
  var_0 = self getcurrentweapon();
  self setweaponammostock(var_0, 0);
  self.oldprimarygun = var_0;
  thread pickupweaponhandler();
}

onplayerscore(var_0, var_1) {
  if(var_0 == "_encstr_ABD70578F3D02C") {
    var_2 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");
    return var_2;
  }

  return 0;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_1 perkwatcher();
}

sotf() {
  level thread startspawnchest();
}

startspawnchest() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = getdvarint("_encstr_969A15180FF2969F827354F08E6B83BB4D9F60803FB64B", 1);
  var_1 = getdvarint("_encstr_862A1482EE85911B80D0E3FF90DBC1EB73FD8CBD45ED", 30);
  level waittill("_encstr_92F614981FFB1FCF8FD112436DD8AF4079EF8370FD9F", var_2);

  for(;;) {
    if(!isalive(var_2)) {
      var_2 = findnewowner(level.players);

      if(!isDefined(var_2))
        continue;
    } else {
      while(isalive(var_2)) {
        if(level.emptylocations) {
          for(var_3 = 0; var_3 < var_0; var_3++)
            level thread spawnchests(var_2);

          level thread showcratesplash("_encstr_B6F4149BDDFB8B8178E81F9B098660EA9FE708CB88A2");
          wait(var_1);
          continue;
        }

        waitframe();
      }
    }
  }
}

showcratesplash(var_0) {
  foreach(var_2 in level.players)
  var_2 thread scripts\mp\hud_message::showsplash(var_0);
}

findnewowner(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2))
      return var_2;
  }

  level waittill("_encstr_92F614981FFB1FCF8FD112436DD8AF4079EF8370FD9F", var_4);
  return var_4;
}

spawnchests(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_928216BB704B5B697FF0FA93382F5ABB41E43E309830B3EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.firstcratedrop) {
    var_2 = getcenterpoint(var_1);
    level.firstcratedrop = 0;
  } else
    var_2 = getrandompoint(var_1);

  if(isDefined(var_2))
    playfxatpoint(var_2);
}

playfxatpoint(var_0) {
  var_1 = var_0 + (0, 0, 30);
  var_2 = var_0 + (0, 0, -1000);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, undefined, scripts\engine\trace::create_default_contents(1));
  var_4 = var_3["_encstr_BD260953AA97E3F014279D"] + (0, 0, 1);
  var_5 = var_3["_encstr_850E077B0BF30318B9"];

  if(isDefined(var_5)) {
    for(var_6 = var_5 getlinkedparent(); isDefined(var_6); var_6 = var_5 getlinkedparent())
      var_5 = var_6;
  }

  if(isDefined(var_5)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7.angles = (90, randomintrange(-180, 179), 0);
    var_7 linkTo(var_5);
    thread playlinkedsmokeeffect(scripts\engine\utility::getfx("_encstr_A21418C3D84443A660B77370EBB02B3F7D139A7B66290F5BF015"), var_7);
  } else
    playFX(scripts\engine\utility::getfx("_encstr_AF4D129B4BD9DC58C67D6C4395B91DFA91E4F60E"), var_4);
}

playlinkedsmokeeffect(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  playFXOnTag(var_0, var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 6;
  stopFXOnTag(var_0, var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 0.05;
  var_1 delete();
}

getcenterpoint(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = distance2dsquared(level.mapcenter, var_4.origin);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  level.usedlocations[level.usedlocations.size] = var_1.origin;
  return var_1.origin;
}

getrandompoint(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 0;

    if(isDefined(level.usedlocations) && level.usedlocations.size > 0) {
      foreach(var_5 in level.usedlocations) {
        if(var_0[var_2].origin == var_5) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        continue;
      }
      var_1[var_1.size] = var_0[var_2].origin;
      continue;
    }

    var_1[var_1.size] = var_0[var_2].origin;
  }

  if(var_1.size > 0) {
    var_7 = randomint(var_1.size);
    var_8 = var_1[var_7];
    level.usedlocations[level.usedlocations.size] = var_8;
    return var_8;
  }

  level.emptylocations = 0;
  return undefined;
}

definechestweapons() {
  var_0 = [];
  var_1 = [];

  for(var_2 = 0; tablelookupbyrow("_encstr_B68813ADC179CDEDD1CC5D2B16E07BCD37718DCD3B", var_2, 0) != "_encstr_B40101"; var_2++) {
    var_3 = tablelookupbyrow("_encstr_B68813ADC179CDEDD1CC5D2B16E07BCD37718DCD3B", var_2, 2);
    var_4 = tablelookupbyrow("_encstr_B68813ADC179CDEDD1CC5D2B16E07BCD37718DCD3B", var_2, 1);
    var_5 = isselectableweapon(var_3);

    if(isDefined(var_4) && var_5 && var_4 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36") {
      var_6 = 30;
      var_0[var_0.size]["_encstr_84BA05A8CA852B"] = var_3;
      var_0[var_0.size - 1]["_encstr_8FDE0783D823374B6B"] = var_6;
      continue;
    }

    if(isDefined(var_4) && var_5 && (var_4 == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9" || var_4 == "_encstr_AF710BF4355A9195B0FF0AEAD0" || var_4 == "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D" || var_4 == "_encstr_9B65109F23E0F24FC016431A79258FEE4889" || var_4 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" || var_4 == "_encstr_A1710B57AD31DBCDCDF1422A60" || var_4 == "_encstr_A3710BEEACC2E0B737EB36B676" || var_4 == "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195")) {
      var_6 = 0;

      switch (var_4) {
        case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
          var_6 = 35;
          break;
        case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
          var_6 = 25;
          break;
        case "_encstr_A1710B57AD31DBCDCDF1422A60":
        case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
          var_6 = 15;
          break;
        case "_encstr_A3710BEEACC2E0B737EB36B676":
          var_6 = 10;
          break;
        case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
          var_6 = 30;
          break;
      }

      var_1[var_1.size]["_encstr_84BA05A8CA852B"] = var_3 + "_encstr_851A049F8337";
      var_1[var_1.size - 1]["_encstr_852906B39CBD5D38"] = var_4;
      var_1[var_1.size - 1]["_encstr_8FDE0783D823374B6B"] = var_6;
      continue;
    }

    continue;
  }

  var_1 = sortbyweight(var_1);
  level.pistolarray = var_0;
  level.weaponarray = var_1;
}

sotfcratethink(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A517132A055FFBA18B687763D8068882E3A674E6F6");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(game["_encstr_A1B10847BD1A23B8FA8B"][self.cratetype + "_encstr_9AA906BE0D96E6D1"]))
    var_1 = game["_encstr_A1B10847BD1A23B8FA8B"][self.cratetype + "_encstr_9AA906BE0D96E6D1"];
  else
    var_1 = &"_encstr_BAE712F142A6DFE51C3F61791B6C7FA1D9BF7F6A";

  var_2 = "_encstr_8F7A0C432E022D068037A8705FA4";
  scripts\cp_mp\killstreaks\airdrop::cratesetupforuse(var_1, var_2);
  thread scripts\cp_mp\killstreaks\airdrop::crateallcapturethink();
  childthread cratewatcher(60);
  childthread playerjoinwatcher();
  var_3 = 0;
  var_4 = getdvarint("_encstr_9B0F18E6D8E47DDCBD3A66AF8D93163A56EC5DDC0B5BEDBACD1D", 6);

  for(;;) {
    self waittill("_encstr_B1CF098D5838A3D5C95623", var_5);
    var_5 playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
    var_6 = getrandomweapon(level.weaponarray);
    var_6 = getrandomattachments(var_6);
    var_7 = createheadicon(var_5.lastdroppableweaponobj);
    var_8 = var_5 getammocount(var_7);

    if(var_6 == var_7) {
      var_5 givestartammo(var_6);
      var_5 setweaponammostock(var_6, var_8);
    } else {
      if(isDefined(var_7) && var_7 != "_encstr_8BBA05185F8B99") {
        var_9 = var_5 dropitem(var_7);

        if(isDefined(var_9) && var_8 > 0)
          var_9.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
      }

      var_5 giveweapon(var_6, 0, 0, 0, 1);
      var_5 setweaponammostock(var_6, 0);
      var_5 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_6);

      if(var_5 getweaponammoclip(var_6) == 1)
        var_5 setweaponammostock(var_6, 1);

      var_5.oldprimarygun = var_6;
    }

    var_3++;
    var_4 = var_4 - 1;

    if(var_4 > 0) {
      if(isDefined(self.crateiconid)) {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.crateiconid);
        self.crateiconid = undefined;
      }

      var_10 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "_encstr_82510D0621679340909B51C3B0E1D9" + var_4 + "_encstr_A3D806F5318DEACA", 24);
      self.crateheadicon = "_encstr_82510D0621679340909B51C3B0E1D9" + var_4 + "_encstr_A3D806F5318DEACA";
      self.crateiconid = var_10;
    }

    if(self.cratetype == "_encstr_B8B30C422084CE89BBE5F1039FD8" && var_3 == getdvarint("_encstr_9B0F18E6D8E47DDCBD3A66AF8D93163A56EC5DDC0B5BEDBACD1D", 6))
      scripts\cp_mp\killstreaks\airdrop::deletecrateold();
  }
}

cratewatcher(var_0) {
  wait(var_0);

  while(isDefined(self.inuse) && self.inuse)
    waitframe();

  scripts\cp_mp\killstreaks\airdrop::deletecrateold();
}

playerjoinwatcher() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(isDefined(self.crateiconid))
      scripts\cp_mp\entityheadicons::_id_1315D(self.crateiconid, var_0);
  }
}

cratekill(var_0) {
  for(var_1 = 0; var_1 < level.usedlocations.size; var_1++) {
    if(var_0 != level.usedlocations[var_1]) {
      continue;
    }
    level.usedlocations = scripts\engine\utility::array_remove(level.usedlocations, var_0);
  }

  level.emptylocations = 1;
}

isselectableweapon(var_0) {
  var_1 = tablelookup("_encstr_B68813ADC179CDEDD1CC5D2B16E07BCD37718DCD3B", 2, var_0, 3);
  var_2 = tablelookup("_encstr_B68813ADC179CDEDD1CC5D2B16E07BCD37718DCD3B", 2, var_0, 4);

  if(var_1 == "_encstr_AAEF05B9394BAB" && (var_2 == "_encstr_B40101" || getdvarint(var_2, 0) == 1))
    return 1;

  return 0;
}

getrandomweapon(var_0) {
  var_1 = setbucketval(var_0);
  var_2 = randomint(level.weaponmaxval["_encstr_951904F0ED08"]);
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!var_1[var_4]["_encstr_8FDE0783D823374B6B"]) {
      continue;
    }
    if(var_1[var_4]["_encstr_8FDE0783D823374B6B"] > var_2) {
      var_3 = var_1[var_4];
      break;
    }
  }

  return var_3;
}

getrandomattachments(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0["_encstr_84BA05A8CA852B"]);
  var_5 = scripts\mp\utility\weapon::register_wave_spawner(var_4);

  if(var_5.size > 0) {
    var_6 = randomint(5);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_1 = getvalidattachments(var_0, var_2, var_5);

      if(var_1.size == 0) {
        break;
      }

      var_8 = randomint(var_1.size);
      var_2[var_2.size] = var_1[var_8];
      var_9 = scripts\mp\utility\weapon::attachmentmap_tounique(var_1[var_8], var_4);
      var_3[var_3.size] = var_9;
    }

    var_10 = scripts\mp\utility\weapon::getweapongroup(var_0["_encstr_84BA05A8CA852B"]);

    if(var_10 == "_encstr_A1710B57AD31DBCDCDF1422A60" || var_10 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" || var_4 == "_encstr_887C0BA5BB6E7D93B4830E5627") {
      var_11 = 0;

      foreach(var_13 in var_2) {
        if(scripts\mp\utility\weapon::getattachmenttype(var_13) == "_encstr_851F05E3C813A5") {
          var_11 = 1;
          break;
        }
      }

      if(!var_11 && var_0["_encstr_84BA05A8CA852B"] != "_encstr_8F540ABBEBBBC97DFB5F6A21") {
        var_15 = strtok(var_4, "_encstr_BA4C02DF")[1];
        var_3[var_3.size] = var_15 + "_encstr_B8FB06FF97EA2708";
      }
    }

    if(var_3.size > 0) {
      var_3 = scripts\engine\utility::alphabetize(var_3);

      foreach(var_17 in var_3)
      var_0["_encstr_84BA05A8CA852B"] = var_0["_encstr_84BA05A8CA852B"] + "_encstr_BA4C02DF" + var_17;
    }
  }

  return var_0["_encstr_84BA05A8CA852B"];
}

getvalidattachments(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = scripts\mp\weapons::safechecknum(var_0["_encstr_84BA05A8CA852B"]);

  foreach(var_6 in var_2) {
    if(var_6 == "_encstr_8A07035972" || var_6 == "_encstr_A65B084B38A76BEFC350") {
      continue;
    }
    var_7 = attachmentcheck(var_4, var_6, var_1);

    if(!var_7) {
      continue;
    }
    var_3[var_3.size] = var_6;
  }

  return var_3;
}

attachmentcheck(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_1 == var_2[var_3] || !scripts\mp\utility\weapon::attachmentscompatible(var_0, var_1, var_2[var_3]))
      return 0;
  }

  return 1;
}

checkscopes(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 == "_encstr_A3CA081B50EDAB3D60A9" || var_2 == "_encstr_8BEB08833B38890A08A7" || var_2 == "_encstr_A28305178878FF" || var_2 == "_encstr_81B00A4882BFB5B22138F804")
      return 1;
  }

  return 0;
}

pickupweaponhandler() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    waitframe();
    var_0 = self getweaponslistprimaries();

    if(var_0.size > 1) {
      var_1 = self.oldprimarygun;

      foreach(var_3 in var_0) {
        if(var_3 == var_1) {
          var_4 = self getammocount(var_3);
          var_5 = self dropitem(var_3);

          if(isDefined(var_5) && var_4 > 0)
            var_5.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";

          break;
        }
      }

      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      self.oldprimarygun = var_0[0];
    }
  }
}

loginckillchain() {
  self.pers["_encstr_8B560B62B16B5067FCFAB88833"]++;
  scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B560B62B16B5067FCFAB88833", self.pers["_encstr_8B560B62B16B5067FCFAB88833"]);
}

perkwatcher() {
  if(level.allowperks) {
    switch (self.streakpoints) {
      case 2:
        scripts\mp\utility\perk::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
        thread scripts\mp\hud_message::showsplash("_encstr_B84C2267491592C9901893D89640096B75A7F3EBC3C8ABAAE8C14DE3C9D849E14E076B03", self.streakpoints);
        thread loginckillchain();
        break;
      case 3:
        scripts\mp\utility\perk::giveperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
        thread scripts\mp\hud_message::showsplash("_encstr_8FAC1BD34865B6D019C38B57F739C1ECEC83F0ED30F8612B06B3B7AC46", self.streakpoints);
        thread loginckillchain();
        break;
      case 4:
        scripts\mp\utility\perk::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
        thread scripts\mp\hud_message::showsplash("_encstr_978617C3AB3F16E8C6F4797BDFAAC8EFE3F2996BE1CF58785F", self.streakpoints);
        thread loginckillchain();
        break;
      case 5:
        scripts\mp\utility\perk::giveperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD");
        thread scripts\mp\hud_message::showsplash("_encstr_96AA1B3738B21BA5B0C6D1CB7D4EB2CE2BE6CC85B9D1CAC9EB37F63A33", self.streakpoints);
        thread loginckillchain();
        break;
      case 6:
        scripts\mp\utility\perk::giveperk("_encstr_8E621237838FB6EB8F12ABEA513422A381ED81E5");
        thread scripts\mp\hud_message::showsplash("_encstr_A971179BEA9DE04B12BBF9EB5F6A8548340742D159D3C8FDBA", self.streakpoints);
        thread loginckillchain();
        break;
    }
  }
}

iconvisall(var_0, var_1) {
  var_2 = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, var_1, 24, 1);
  self.crateheadicon = var_1;
  self.crateiconid = var_2;
}

objvisall(var_0) {
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
}

setbucketval(var_0) {
  level.weaponmaxval["_encstr_951904F0ED08"] = 0;
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!var_1[var_2]["_encstr_8FDE0783D823374B6B"]) {
      continue;
    }
    level.weaponmaxval["_encstr_951904F0ED08"] = level.weaponmaxval["_encstr_951904F0ED08"] + var_1[var_2]["_encstr_8FDE0783D823374B6B"];
    var_1[var_2]["_encstr_8FDE0783D823374B6B"] = level.weaponmaxval["_encstr_951904F0ED08"];
  }

  return var_1;
}

sortbyweight(var_0) {
  var_1 = [];
  var_2 = [];

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3]["_encstr_8FDE0783D823374B6B"];
    var_1 = var_0[var_3];

    for(var_5 = var_3 - 1; var_5 >= 0 && is_weight_a_less_than_b(var_0[var_5]["_encstr_8FDE0783D823374B6B"], var_4); var_5--) {
      var_2 = var_0[var_5];
      var_0[var_5] = var_1;
      var_0[var_5 + 1] = var_2;
    }
  }

  return var_0;
}

is_weight_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
}