/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\remoteuav.gsc
***********************************************/

init() {
  level.remoteuav_fx["_encstr_860808CB78E2984063BA"] = loadfx("_encstr_88D827705BB8587F42321508CF0B61F847D33090937B282DAA119E256323BBC6751350D02F0360F7E2");
  level.remoteuav_fx["_encstr_82C910274336BBE1E0D1A1376AD83CB205E3"] = loadfx("_encstr_B48A2B0B5950BF1A3CF107C789C8E22158A0C213B3C0B97238751B8BEF871B61F8C8FF51C980503A60572FDFE5");
  level.remoteuav_dialog["_encstr_9769076901B7A8AF74"][0] = "_encstr_93A6166E59BA032F88C1ABC3B743A28998A1A5F7B1181D22";
  level.remoteuav_dialog["_encstr_9769076901B7A8AF74"][1] = "_encstr_95F913856C98990CF51C633AEB39DBC68DA5379637";
  level.remoteuav_dialog["_encstr_9769076901B7A8AF74"][2] = "_encstr_BDE414B1AA5E0E1259F859912FBA40FFFB1309D87267";
  level.remoteuav_dialog["_encstr_8D3E0D88637B87D85657B010AB6F51"][0] = "_encstr_9B8A12A7CE07770B57C3985097835803AA3525B7";
  level.remoteuav_dialog["_encstr_8D3E0D88637B87D85657B010AB6F51"][1] = "_encstr_A25F1638027A5F3B3F38796D3FBB596557CA08289A023B8B";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][0] = "_encstr_A1FD140B1B8966187D338DB77D6BED9359B27359D697";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][1] = "_encstr_A3A215586CC49918FA996CBDD73B5647E81A853AECBACB";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][2] = "_encstr_B63D13DFB67F0F633FC348303F5F83D3C2DDCC534D";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][3] = "_encstr_92C814856C9899C0AF338DEDAFCE563A07B239DC7B73";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][4] = "_encstr_A51314EE06DB8FF02EF85F6719018D93F5A5B5A5FBBD";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][5] = "_encstr_BAFC1585B189CC0CFA33B17BFA76F6E85827BA9B9B594E";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][6] = "_encstr_881A1616B1989918FA668DBDAF4C58C6D67BE6D11AB737CA";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][7] = "_encstr_856D16C28D89CC60BE33C6F6AF3BDEE63785EC2B8EA1B4AD";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][8] = "_encstr_ADDD199B3B1ACA57372251D8D9E3A598229F3D0DA5B538B3E77BE9";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][9] = "_encstr_838E15076EA7D7ABF73B80E8F7F258A7DA53051B472B33";
  level.remoteuav_dialog["_encstr_95A606733089CB1A"][10] = "_encstr_8DA513B036989903BE66B1DE7DE8392C6CD62D9BD9";
  level.remoteuav_dialog["_encstr_AF1904F3E3AC"][0] = "_encstr_A57E0F2EC61B4FB06EB81F275960D1F21B";
  level.remoteuav_dialog["_encstr_AF1904F3E3AC"][1] = "_encstr_AFA41449D156DB4211F7FA8FD1F157E8DF9FD3F3A0E2";
  level.remoteuav_dialog["_encstr_AF1904F3E3AC"][2] = "_encstr_ABD31528F63A73118E0D1FFD0917C005E7603CEA033B02";
  level.remoteuav_dialog["_encstr_AF1904F3E3AC"][3] = "_encstr_8DC91643E332E26F0F0A09B0A1F78AF8FD6DC7279CCC8819";
  level.remoteuav_dialog["_encstr_A1BD075837DCD29B47"][0] = "_encstr_9588131BBB9A4AD7B7A2D158593F20F0671BB3892C";
  level.remoteuav_dialog["_encstr_A1BD075837DCD29B47"][1] = "_encstr_83CD14583698CC03AF9936BDD78E0DB03A3716D04B8E";
  level.remoteuav_dialog["_encstr_A1BD075837DCD29B47"][2] = "_encstr_9A58146BCBEA3A87E7F2E16889E3D3C81723D9F179E3";
  level.remoteuav_dialog["_encstr_A1BD075837DCD29B47"][3] = "_encstr_B695187BDBFA2AB7D7C2F178794BC35044249FED5456685447FB";
  level.remoteuav_lastdialogtime = 0;
  level.remoteuav_nodeployzones = getEntArray("_encstr_AC950CFB82B91821282B17E5A5F6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.remote_uav = [];
}

useremoteuav(var_0, var_1) {
  return tryuseremoteuav(var_0, "_encstr_A54E0BF3EA0FB710F7F74B5BE6");
}

exceededmaxremoteuavs(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_9707038CB6") {
    if(isDefined(level.remote_uav[var_0]) || isDefined(level.remote_uav[scripts\mp\utility\game::getotherteam(var_0)[0]]))
      return 1;
    else
      return 0;
  } else if(isDefined(level.remote_uav[var_0]))
    return 1;
  else
    return 0;
}

tryuseremoteuav(var_0, var_1) {
  scripts\common\utility::allow_usability(0);

  if(scripts\mp\utility\player::isusingremote() || self isusingturret() || isDefined(level.nukeincoming)) {
    scripts\common\utility::allow_usability(1);
    return 0;
  }

  var_2 = 1;

  if(exceededmaxremoteuavs(self.team) || level.littlebirds.size >= 4) {
    self iprintlnbold(&"_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");
    scripts\common\utility::allow_usability(1);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    scripts\common\utility::allow_usability(1);
    return 0;
  }

  self setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_8DBE0CE68E16E82D360A36831A16", 0);
  self setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_A9E01032D067452FB8B8EFCDC303AF0C9110", 0);
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_3 = givecarryremoteuav(var_0, var_1);

  if(var_3) {
    scripts\common\utility::_id_13E0A(level._id_11B2A, var_1, self.origin);
    thread scripts\mp\hud_util::teamplayercardsplash("_encstr_96F5102DEB0F111F3AFAD8C08397674B7776", self);
  } else
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();

  self.iscarrying = 0;
  return var_3;
}

givecarryremoteuav(var_0, var_1) {
  var_2 = createcarryremoteuav(var_1, self);
  scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A78C126DA58D63DC479CAC16ADF55785CED7B51C");
  scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_913519DA2D6336DC479CCAC2ADBE93AC5B7B8E957DAE16D9AF6BC1");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("_encstr_913519DA2D6336DC479CCAC2ADBE93AC5B7B8E957DAE16D9AF6BC1");
  setcarryingremoteuav(var_2);

  if(isalive(self) && isDefined(var_2)) {
    var_3 = var_2.origin;
    var_4 = self.angles;
    var_2.soundent delete();
    var_2 delete();
    var_5 = startremoteuav(var_0, var_1, var_3, var_4);
  } else {
    var_5 = 0;

    if(isalive(self)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_913519DA2D6336DC479CCAC2ADBE93AC5B7B8E957DAE16D9AF6BC1");
      scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_A78C126DA58D63DC479CAC16ADF55785CED7B51C");
    }
  }

  return var_5;
}

createcarryremoteuav(var_0, var_1) {
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 4 + anglestoup(var_1.angles) * 50;
  var_3 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_2, "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043");
  var_3.origin = var_2;
  var_3.angles = var_1.angles;
  var_3.sentrytype = "_encstr_8E600F37A8A33D66EF21CFE84239028B95";
  var_3.canbeplaced = 1;
  var_3 setturretmodechangewait(1);
  var_3 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_3 makeunusable();
  var_3 maketurretinoperable();
  var_3.owner = var_1;
  var_3 setsentryowner(var_3.owner);
  var_3.scale = 3;
  var_3.inheliproximity = 0;
  var_3 thread carryremoteuav_handleexistence();
  var_3.rangetrigger = getEnt("_encstr_822C113675A7F8F147D180385B91B571D31F35", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3.rangetrigger)) {
    var_4 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    var_3.maxheight = var_4.origin[2];
    var_3.maxdistance = 3600;
  }

  var_3.soundent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_3.origin);
  var_3.soundent.angles = var_3.angles;
  var_3.soundent.origin = var_3.origin;
  var_3.soundent linkTo(var_3);
  var_3.soundent playLoopSound("_encstr_A76D15935936B73732277BB956F5A591C6957D86D276D0");
  return var_3;
}

setcarryingremoteuav(var_0) {
  var_0 thread carryremoteuav_setcarried(self);
  self notifyonplayercommand("_encstr_A33215D89A06A7C91713C746FA77D763ED3270C8A156B5", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_A33215D89A06A7C91713C746FA77D763ED3270C8A156B5", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  self notifyonplayercommand("_encstr_A7FB161BB0DC8DAC8DEBD8169C9CE525B2D67BE859AA0AAC", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("_encstr_A7FB161BB0DC8DAC8DEBD8169C9CE525B2D67BE859AA0AAC", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
    self notifyonplayercommand("_encstr_A7FB161BB0DC8DAC8DEBD8169C9CE525B2D67BE859AA0AAC", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
    self notifyonplayercommand("_encstr_A7FB161BB0DC8DAC8DEBD8169C9CE525B2D67BE859AA0AAC", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
  }

  for(;;) {
    var_1 = _id_11969("_encstr_A33215D89A06A7C91713C746FA77D763ED3270C8A156B5", "_encstr_A7FB161BB0DC8DAC8DEBD8169C9CE525B2D67BE859AA0AAC", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC", "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    self forceusehintoff();

    if(var_1 != "_encstr_A33215D89A06A7C91713C746FA77D763ED3270C8A156B5") {
      carryremoteuav_delete(var_0);
      break;
    }

    if(!var_0.canbeplaced) {
      if(self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D")
        self forceusehinton(&"_encstr_A5852410D8B43B3241AA8B6B9A06E9A151390FAF7590BF3719C017103606649C87A7F5C73BD5");

      continue;
    }

    if(exceededmaxremoteuavs(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
      self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
      carryremoteuav_delete(var_0);
      break;
    }

    self.iscarrying = 0;
    var_0.carriedby = undefined;
    var_0 playSound("_encstr_931A11C275C203937A69DC3F0D89CB65633853");
    var_0 notify("_encstr_B8B00782A191CB07D9");
    break;
  }
}

_id_11969(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_6 = spawnStruct();

  if(isDefined(var_0))
    thread scripts\engine\utility::waittill_string(var_0, var_6);

  if(isDefined(var_1))
    thread scripts\engine\utility::waittill_string(var_1, var_6);

  if(isDefined(var_2))
    thread scripts\engine\utility::waittill_string(var_2, var_6);

  if(isDefined(var_3))
    thread scripts\engine\utility::waittill_string(var_3, var_6);

  if(isDefined(var_4))
    thread scripts\engine\utility::waittill_string(var_4, var_6);

  if(isDefined(var_5))
    thread scripts\engine\utility::waittill_string(var_5, var_6);

  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

carryremoteuav_setcarried(var_0) {
  self setCanDamage(0);
  self setsentrycarrier(var_0);
  self notsolid();
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread updatecarryremoteuavplacement(self);
  self notify("_encstr_A93B084AF782F0DA4A04");
}

carryremoteuav_delete(var_0) {
  self.iscarrying = 0;

  if(isDefined(var_0)) {
    if(isDefined(var_0.soundent))
      var_0.soundent delete();

    var_0 delete();
  }
}

isinremotenodeploy() {
  if(isDefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size) {
    foreach(var_1 in level.remoteuav_nodeployzones) {
      if(self istouching(var_1))
        return 1;
    }
  }

  return 0;
}

updatecarryremoteuavplacement(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B8B00782A191CB07D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.canbeplaced = 1;
  var_1 = -1;
  scripts\common\utility::allow_usability(1);

  for(;;) {
    var_2 = 18;

    switch (self getstance()) {
      case "_encstr_A5AD069B231F0BAF":
        var_2 = 40;
        break;
      case "_encstr_B13D076BED70539F23":
        var_2 = 25;
        break;
      case "_encstr_922406F1A6FD5E05":
        var_2 = 10;
        break;
    }

    var_3 = self canplayerplacetank(22, 22, 50, var_2, 0, 0);
    var_0.origin = var_3["_encstr_97FE07DE392D76D2CD"] + anglestoup(self.angles) * 27;
    var_0.angles = var_3["_encstr_A7610758E6CED8569B"];
    var_0.canbeplaced = self isonground() && var_3["_encstr_9B7C07725D17A39473"] && var_0 remoteuav_in_range() && !var_0 isinremotenodeploy();

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        if(self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D")
          self forceusehinton(&"_encstr_AD771DAA5CC8916F54B3D9E1CF8B2665E0F530AD2791FB157E6F7981CFF33D");

        if(self attackButtonPressed())
          self notify("_encstr_A33215D89A06A7C91713C746FA77D763ED3270C8A156B5");
      } else if(self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D")
        self forceusehinton(&"_encstr_A5852410D8B43B3241AA8B6B9A06E9A151390FAF7590BF3719C017103606649C87A7F5C73BD5");
    }

    var_1 = var_0.canbeplaced;
    waitframe();
  }
}

carryremoteuav_handleexistence() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_A33215D89A06A7C91713C746FA77D763ED3270C8A156B5");
  self.owner endon("_encstr_A7FB161BB0DC8DAC8DEBD8169C9CE525B2D67BE859AA0AAC");
  self.owner scripts\engine\utility::_id_143A6("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(isDefined(self)) {
    if(isDefined(self.soundent))
      self.soundent delete();

    self delete();
  }
}

removeremoteweapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.7;
}

startremoteuav(var_0, var_1, var_2, var_3) {
  lockplayerforremoteuavlaunch();
  scripts\mp\utility\player::setusingremote(var_1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_8E540EE05AD3EF1BCF0DD0551DFF2079");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("_encstr_8E540EE05AD3EF1BCF0DD0551DFF2079");
  self visionsetnakedforplayer("_encstr_8A8C09A5D372D6302FEE93", 0.0);
  var_4 = scripts\mp\killstreaks\killstreaks::initridekillstreak("_encstr_A54E0BF3EA0FB710F7F74B5BE6");

  if(var_4 != "_encstr_88E30897BDF1B71F7823") {
    if(var_4 != "_encstr_8D820B49520F0EC02DDE6367EC") {
      self notify("_encstr_829611CBDFD83D3BD8678BE836CB90D88FB360");
      scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_8E540EE05AD3EF1BCF0DD0551DFF2079");
      scripts\mp\utility\player::clearusingremote();
    }

    return 0;
  }

  if(exceededmaxremoteuavs(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    self notify("_encstr_829611CBDFD83D3BD8678BE836CB90D88FB360");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_8E540EE05AD3EF1BCF0DD0551DFF2079");
    scripts\mp\utility\player::clearusingremote();
    return 0;
  }

  self notify("_encstr_829611CBDFD83D3BD8678BE836CB90D88FB360");
  var_5 = createremoteuav(var_0, self, var_1, var_2, var_3);

  if(isDefined(var_5)) {
    thread remoteuav_ride(var_0, var_5, var_1);
    return 1;
  } else {
    self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_8E540EE05AD3EF1BCF0DD0551DFF2079");
    scripts\mp\utility\player::clearusingremote();
    return 0;
  }
}

lockplayerforremoteuavlaunch() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0 hide();
  self playerlinkTo(var_0);
  thread clearplayerlockfromremoteuavlaunch(var_0);
}

clearplayerlockfromremoteuavlaunch(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::_id_143AD("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_829611CBDFD83D3BD8678BE836CB90D88FB360");

  if(var_1 != "_encstr_8D820B49520F0EC02DDE6367EC")
    self unlink();

  var_0 delete();
}

createremoteuav(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 isconsoleplayer())
    var_5 = spawnhelicopter(var_1, var_3, var_4, "_encstr_A5E60EA5D792F0E83581F349F327E8B7", "_encstr_82AD13C3F118316279833FF3FB91EA64281EBB8E0B");
  else
    var_5 = spawnhelicopter(var_1, var_3, var_4, "_encstr_97AD11FBF781E7E9AD69884A731F235BD1434E", "_encstr_82AD13C3F118316279833FF3FB91EA64281EBB8E0B");

  if(!isDefined(var_5))
    return undefined;

  var_5 makevehiclesolidcapsule(18, -9, 18);
  var_5.lifeid = var_0;
  var_5.team = var_1.team;
  var_5.pers["_encstr_8AEF05472BC2D6"] = var_1.team;
  var_5.owner = var_1;
  var_5 setotherent(var_1);
  var_5 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_1);
  var_5.maxhealth = 250;
  var_5.scrambler = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_5.scrambler linkTo(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, -160), (0, 0, 0));
  var_5.scrambler makescrambler(var_1);
  var_5.smoking = 0;
  var_5.inheliproximity = 0;
  var_5.helitype = "_encstr_A54E0BF3EA0FB710F7F74B5BE6";
  var_5.markedplayers = [];
  var_5 thread remoteuav_light_fx();
  var_5 thread remoteuav_explode_on_disconnect();
  var_5 thread remoteuav_explode_on_changeteams();
  var_5 thread remoteuav_explode_on_death();
  var_5 thread remoteuav_clear_marked_on_gameended();
  var_5 thread remoteuav_leave_on_timeout();
  var_5 thread remoteuav_watch_distance();
  var_5 thread remoteuav_watchheliproximity();
  var_5 thread remoteuav_handledamage();
  var_5.numflares = 2;
  var_5.hasincoming = 0;
  var_5.incomingmissiles = [];
  var_5 thread remoteuav_clearincomingwarning();
  var_5 thread remoteuav_handleincomingstinger();
  var_5 thread remoteuav_handleincomingsam();
  level.remote_uav[var_5.team] = var_5;
  return var_5;
}

remoteuav_ride(var_0, var_1, var_2) {
  var_1.playerlinked = 1;
  self.restoreangles = self.angles;

  if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    scripts\mp\utility\player::setthirdpersondof(0);

  self cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self remotecontrolvehicle(var_1);
  thread remoteuav_playerexit(var_1);
  thread remoteuav_track(var_1);
  thread remoteuav_fire(var_1);
  self.remote_uav_ridelifeid = var_0;
  self.remoteuav = var_1;
  thread remoteuav_delaylaunchdialog(var_1);
  self visionsetnakedforplayer("_encstr_8A8C09A5D372D6302FEE93", 0.0);
  scripts\mp\utility\player::restorebasevisionset(1);
}

remoteuav_delaylaunchdialog(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_920E0BE7880931BA61B86733C0");
  var_0 endon("_encstr_BAC812B865F8C9FA0868C85BA391F5D973F4289F");
  wait 3;
  remoteuav_dialog("_encstr_9769076901B7A8AF74");
}

remoteuav_endride(var_0) {
  if(isDefined(var_0)) {
    var_0.playerlinked = 0;
    var_0 notify("_encstr_920E0BE7880931BA61B86733C0");
    scripts\mp\utility\player::clearusingremote();

    if(getdvarint("_encstr_82570B397A4D3192935192A562"))
      scripts\mp\utility\player::setthirdpersondof(1);

    self cameraunlink(var_0);
    self remotecontrolvehicleoff(var_0);
    self thermalvisionoff();
    self setplayerangles(self.restoreangles);
    var_1 = scripts\mp\utility\inventory::getlastweapon();

    if(!self hasweapon(var_1))
      var_1 = scripts\mp\utility\inventory::getfirstprimaryweapon();

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_8E540EE05AD3EF1BCF0DD0551DFF2079");
    thread remoteuav_freezebuffer();
  }

  self.remoteuav = undefined;
}

remoteuav_freezebuffer() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::_freezecontrols(1);
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0);
}

remoteuav_playerexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_920E0BE7880931BA61B86733C0");
  wait 2;
  var_1 = level.framedurationseconds;

  for(;;) {
    var_2 = 0;

    while(self useButtonPressed()) {
      var_2 = var_2 + var_1;

      if(var_2 > 0.75) {
        var_0 thread remoteuav_leave();
        return;
      }

      wait(var_1);
    }

    waitframe();
  }
}

remoteuav_track(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_920E0BE7880931BA61B86733C0");
  var_0.lasttrackingdialogtime = 0;
  self.lockedtarget = undefined;
  self weaponlockfree();
  wait 1;

  for(;;) {
    var_1 = var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1");
    var_2 = anglesToForward(self getplayerangles());
    var_3 = var_1 + var_2 * 1024;
    var_4 = scripts\engine\trace::_bullet_trace(var_1, var_3, 1, var_0);

    if(isDefined(var_4["_encstr_BD260953AA97E3F014279D"]))
      var_5 = var_4["_encstr_BD260953AA97E3F014279D"];
    else {
      var_5 = var_3;
      var_4["_encstr_AD8A07AD6A70AADF26"] = var_3;
    }

    var_0.trace = var_4;
    var_6 = remoteuav_trackentities(var_0, level.players, var_5);
    var_7 = remoteuav_trackentities(var_0, level.turrets, var_5);
    var_8 = undefined;

    if(level.teambased) {
      var_9 = undefined;
      var_10 = [];
      var_11 = scripts\mp\utility\teams::getenemyteams(self.team);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
        var_9 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

      if(istrue(var_9) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
        foreach(var_13 in level.teamnamelist) {
          foreach(var_20, var_15 in level.squaddata[var_13]) {
            var_16 = var_13 + var_20;

            foreach(var_18 in level.uavmodels[var_16])
            var_10[var_10.size] = var_18;
          }
        }
      } else {
        foreach(var_23 in level.teamnamelist) {
          foreach(var_18 in level.uavmodels[var_23])
          var_10[var_10.size] = var_18;
        }
      }

      var_8 = remoteuav_trackentities(var_0, var_10, var_5);
    } else
      var_8 = remoteuav_trackentities(var_0, level.uavmodels, var_5);

    var_27 = undefined;

    if(isDefined(var_6))
      var_27 = var_6;
    else if(isDefined(var_7))
      var_27 = var_7;
    else if(isDefined(var_8))
      var_27 = var_8;

    if(isDefined(var_27)) {
      if(!isDefined(self.lockedtarget) || isDefined(self.lockedtarget) && self.lockedtarget != var_27) {
        self weaponlockfinalize(var_27);
        self.lockedtarget = var_27;

        if(isDefined(var_6)) {
          var_0 notify("_encstr_BAC812B865F8C9FA0868C85BA391F5D973F4289F");
          remoteuav_dialog("_encstr_95A606733089CB1A");
        }
      }
    } else {
      self weaponlockfree();
      self.lockedtarget = undefined;
    }

    wait 0.05;
  }
}

remoteuav_trackentities(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(level.teambased && (!isDefined(var_5.team) || var_5.team == self.team)) {
      continue;
    }
    if(isPlayer(var_5)) {
      if(!scripts\mp\utility\player::isreallyalive(var_5)) {
        continue;
      }
      if(var_5 == self) {
        continue;
      }
      var_6 = var_5.guid;
    } else
      var_6 = var_5.birthtime;

    if(isDefined(var_5.sentrytype) || isDefined(var_5.turrettype)) {
      var_7 = 32;
      var_8 = "_encstr_84071B120FFD07B0D0370617BBD6D9288B09E4C17AEF53723833826AED";
    } else if(isDefined(var_5.uavtype)) {
      var_7 = -52;
      var_8 = "_encstr_84071B120FFD07B0D0370617BBD6D9288B09E4C17AEF53723833826AED";
    } else {
      var_7 = 26;
      var_8 = "_encstr_86E5187B88A8F72A5B8569DB7F3D929573F1CF93506112C243AD";
    }

    if(isDefined(var_5.uavremotemarkedby)) {
      if(!isDefined(var_0.markedplayers[var_6])) {
        var_0.markedplayers[var_6] = [];
        var_0.markedplayers[var_6]["_encstr_8BB007E03658CBCAE4"] = var_5;
        var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"] = var_5 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "_encstr_9A90169BA9405F7A4D3997331BF6B2DD0876D526235B2D72", var_7);
        var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"].shader = "_encstr_9A90169BA9405F7A4D3997331BF6B2DD0876D526235B2D72";

        if(!isDefined(var_5.sentrytype) || !isDefined(var_5.turrettype))
          var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"] settargetEnt(var_5);
      } else if(isDefined(var_0.markedplayers[var_6]) && isDefined(var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"]) && isDefined(var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"].shader) && var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"].shader != "_encstr_9A90169BA9405F7A4D3997331BF6B2DD0876D526235B2D72") {
        var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"].shader = "_encstr_9A90169BA9405F7A4D3997331BF6B2DD0876D526235B2D72";
        var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"] setshader("_encstr_9A90169BA9405F7A4D3997331BF6B2DD0876D526235B2D72", 10, 10);
        var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"] setwaypoint(0, 0, 0, 0);
      }

      continue;
    }

    if(isPlayer(var_5)) {
      var_9 = isDefined(var_5.spawntime) && (gettime() - var_5.spawntime) / 1000 <= 5;
      var_10 = var_5 scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
      var_11 = 0;
      var_12 = 0;
    } else {
      var_9 = 0;
      var_10 = 0;
      var_11 = isDefined(var_5.carriedby);
      var_12 = isDefined(var_5.isleaving) && var_5.isleaving == 1;
    }

    if(!isDefined(var_0.markedplayers[var_6]) && !var_9 && !var_10 && !var_11 && !var_12) {
      var_0.markedplayers[var_6] = [];
      var_0.markedplayers[var_6]["_encstr_8BB007E03658CBCAE4"] = var_5;
      var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"] = var_5 scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, var_8, var_7);
      var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"].shader = var_8;

      if(!isDefined(var_5.sentrytype) || !isDefined(var_5.turrettype))
        var_0.markedplayers[var_6]["_encstr_A3C505966CBDE6"] settargetEnt(var_5);
    }

    if((!isDefined(var_3) || var_3 != var_5) && (isDefined(var_0.trace["_encstr_850E077B0BF30318B9"]) && var_0.trace["_encstr_850E077B0BF30318B9"] == var_5 && !var_11 && !var_12) || distance(var_5.origin, var_2) < 200 * var_0.trace["_encstr_A53009A25003666B9818C6"] && !var_9 && !var_11 && !var_12 || !var_12 && remoteuav_cantargetuav(var_0, var_5)) {
      var_13 = scripts\engine\trace::_bullet_trace(var_0.origin, var_5.origin + (0, 0, 32), 1, var_0);

      if(isDefined(var_13["_encstr_850E077B0BF30318B9"]) && var_13["_encstr_850E077B0BF30318B9"] == var_5 || var_13["_encstr_A53009A25003666B9818C6"] == 1) {
        self playlocalsound("_encstr_A2FE12CB415E4F6DD8E5677ED3D93587F6389292");
        var_3 = var_5;
      }
    }
  }

  return var_3;
}

remoteuav_cantargetuav(var_0, var_1) {
  if(isDefined(var_1.uavtype)) {
    var_2 = anglesToForward(self getplayerangles());
    var_3 = vectorNormalize(var_1.origin - var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"));
    var_4 = vectordot(var_2, var_3);

    if(var_4 > 0.985)
      return 1;
  }

  return 0;
}

remoteuav_fire(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_920E0BE7880931BA61B86733C0");
  wait 1;
  self notifyonplayercommand("_encstr_BD9E0EFB555AB7B192E549D71F68B068", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_BD9E0EFB555AB7B192E549D71F68B068", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");

  for(;;) {
    self waittill("_encstr_BD9E0EFB555AB7B192E549D71F68B068");

    if(isDefined(self.lockedtarget)) {
      self playlocalsound("_encstr_8ABE0FFBA9A75F40E0A8C0AECDB9A3C78F");
      scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");
      thread remoteuav_markplayer(self.lockedtarget);
      thread remoteuav_rumble(var_0, 3);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

remoteuav_rumble(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_920E0BE7880931BA61B86733C0");
  var_0 notify("_encstr_A19D0BD7B85961EA33C8230390");
  var_0 endon("_encstr_A19D0BD7B85961EA33C8230390");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
    wait 0.05;
  }
}

remoteuav_markplayer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.uavremotemarkedby = self;

  if(isPlayer(var_0) && !var_0 scripts\mp\utility\player::isusingremote()) {} else if(isDefined(var_0.uavtype))
    var_0.birth_time = var_0.birthtime;
  else if(isDefined(var_0.owner) && isalive(var_0.owner))
    var_0.owner thread scripts\mp\rank::scoreeventpopup("_encstr_8C991C47AB392759A3F55BC2E46D5919BE13CBBEE4CA6BF6E8CAEB5D58CE");

  remoteuav_dialog("_encstr_AF1904F3E3AC");

  if(scripts\mp\utility\game::getgametype() != "_encstr_9707038CB6") {
    if(isPlayer(var_0))
      thread scripts\mp\utility\points::giveunifiedpoints("_encstr_ABD70578F3D02C");
  }

  if(isPlayer(var_0))
    var_0 setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
  else {
    if(isDefined(var_0.uavtype))
      var_1 = "_encstr_B66B166CEDB5382C37378396B9CEFA2BE659DA97F5EA2C67";
    else
      var_1 = "_encstr_923A1997C7A11371906BE2AC20D887FB0D6D735B73C00A2618B058";

    if(level.teambased) {
      var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var_2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
        scripts\mp\objidpoolmanager::update_objective_state(var_2, "_encstr_930B07BB1B6B3854FF");
        scripts\mp\objidpoolmanager::objective_teammask_single(var_2, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
      }

      var_0.remoteuavmarkedobjid01 = var_2;
    } else {
      var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var_2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
        scripts\mp\objidpoolmanager::update_objective_state(var_2, "_encstr_930B07BB1B6B3854FF");
        scripts\mp\objidpoolmanager::objective_teammask_single(var_2, scripts\mp\utility\game::getotherteam(self.team)[0]);
        scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
      }

      var_0.remoteuavmarkedobjid02 = var_2;
      var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var_2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
        scripts\mp\objidpoolmanager::update_objective_state(var_2, "_encstr_930B07BB1B6B3854FF");
        scripts\mp\objidpoolmanager::objective_teammask_single(var_2, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
      }

      var_0.remoteuavmarkedobjid03 = var_2;
    }
  }

  var_0 thread remoteuav_unmarkremovedplayer(self.remoteuav);
}

remoteuav_processtaggedassist(var_0) {
  remoteuav_dialog("_encstr_A1BD075837DCD29B47");

  if(scripts\mp\utility\game::getgametype() != "_encstr_9707038CB6") {
    self.taggedassist = 1;

    if(isDefined(var_0))
      thread scripts\mp\gamescore::processassist(var_0);
    else
      thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A1BD075837DCD29B47");
  }
}

remoteuav_unmarkremovedplayer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::_id_143AE("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_A93B084AF782F0DA4A04", "_encstr_BA2D081B2B58B32D37EC");

  if(var_1 == "_encstr_BA2D081B2B58B32D37EC" || !isDefined(self.uavtype))
    self.uavremotemarkedby = undefined;

  if(isDefined(var_0)) {
    if(isPlayer(self))
      var_2 = self.guid;
    else if(isDefined(self.birthtime))
      var_2 = self.birthtime;
    else
      var_2 = self.birth_time;

    if(var_1 == "_encstr_A93B084AF782F0DA4A04" || var_1 == "_encstr_BA2D081B2B58B32D37EC") {
      if(isDefined(var_0.markedplayers[var_2]["_encstr_A3C505966CBDE6"])) {
        var_0.markedplayers[var_2]["_encstr_A3C505966CBDE6"] destroy();
        var_0.markedplayers[var_2]["_encstr_A3C505966CBDE6"] = undefined;
      }
    }

    if(isDefined(var_2) && isDefined(var_0.markedplayers[var_2])) {
      var_0.markedplayers[var_2] = undefined;
      var_0.markedplayers = scripts\engine\utility::array_removeundefined(var_0.markedplayers);
    }
  }

  if(isPlayer(self))
    self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
  else {
    if(isDefined(self.remoteuavmarkedobjid01))
      scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid01);

    if(isDefined(self.remoteuavmarkedobjid02))
      scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid02);

    if(isDefined(self.remoteuavmarkedobjid03))
      scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid03);
  }
}

remoteuav_clearmarkedforowner() {
  foreach(var_1 in self.markedplayers) {
    if(isDefined(var_1["_encstr_A3C505966CBDE6"])) {
      var_1["_encstr_A3C505966CBDE6"] destroy();
      var_1["_encstr_A3C505966CBDE6"] = undefined;
    }
  }

  self.markedplayers = undefined;
}

remoteuav_operationrumble(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_920E0BE7880931BA61B86733C0");

  for(;;) {
    self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
    wait 0.5;
  }
}

remoteuav_watch_distance() {
  self endon("_encstr_AD75063D571AE108");
  self.rangetrigger = getEnt("_encstr_822C113675A7F8F147D180385B91B571D31F35", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(self.rangetrigger)) {
    var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    self.maxheight = var_0.origin[2];
    self.maxdistance = 12800;
  }

  self.centerref = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.mapcenter);
  var_1 = self.origin;
  self.rangecountdownactive = 0;

  for(;;) {
    if(!remoteuav_in_range()) {
      var_2 = 0;

      while(!remoteuav_in_range()) {
        self.owner remoteuav_dialog("_encstr_8D3E0D88637B87D85657B010AB6F51");

        if(!self.rangecountdownactive) {
          self.rangecountdownactive = 1;
          thread remoteuav_rangecountdown();
        }

        if(isDefined(self.heliinproximity)) {
          var_3 = distance(self.origin, self.heliinproximity.origin);
          var_2 = 1 - (var_3 - 150) / 150;
        } else {
          var_3 = distance(self.origin, var_1);
          var_2 = min(1, var_3 / 200);
        }

        self.owner setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_8DBE0CE68E16E82D360A36831A16", var_2);
        wait 0.05;
      }

      self notify("_encstr_8DDD094BE6EBC9859BD959");
      self.rangecountdownactive = 0;
      thread remoteuav_staticfade(var_2);
    }

    var_1 = self.origin;
    waitframe();
  }
}

remoteuav_in_range() {
  if(isDefined(self.rangetrigger)) {
    if(!self istouching(self.rangetrigger) && !self.inheliproximity)
      return 1;
  } else if(distance2d(self.origin, level.mapcenter) < self.maxdistance && self.origin[2] < self.maxheight && !self.inheliproximity)
    return 1;

  return 0;
}

remoteuav_staticfade(var_0) {
  self endon("_encstr_AD75063D571AE108");

  while(remoteuav_in_range()) {
    var_0 = var_0 - 0.05;

    if(var_0 < 0) {
      self.owner setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_8DBE0CE68E16E82D360A36831A16", 0);
      break;
    }

    self.owner setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_8DBE0CE68E16E82D360A36831A16", var_0);
    wait 0.05;
  }
}

remoteuav_rangecountdown() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DDD094BE6EBC9859BD959");

  if(isDefined(self.heliinproximity))
    var_0 = 3;
  else
    var_0 = 6;

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("_encstr_AD75063D571AE108");
}

remoteuav_explode_on_disconnect() {
  self endon("_encstr_AD75063D571AE108");
  self.owner waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AD75063D571AE108");
}

remoteuav_explode_on_changeteams() {
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_AD75063D571AE108");
}

remoteuav_clear_marked_on_gameended() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  remoteuav_clearmarkedforowner();
}

remoteuav_leave_on_timeout() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 60.0;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread remoteuav_leave();
}

remoteuav_leave() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.owner remoteuav_endride(self);
  self notify("_encstr_AD75063D571AE108");
}

remoteuav_explode_on_death() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  self playSound("_encstr_B6011586E78A6778D463D8E807D7F1BB534B7E807842C9");
  playFX(level.remoteuav_fx["_encstr_860808CB78E2984063BA"], self.origin);
  remoteuav_cleanup();
}

remoteuav_cleanup() {
  if(self.playerlinked == 1 && isDefined(self.owner))
    self.owner remoteuav_endride(self);

  if(isDefined(self.scrambler))
    self.scrambler delete();

  if(isDefined(self.centerref))
    self.centerref delete();

  remoteuav_clearmarkedforowner();
  stopFXOnTag(level.remoteuav_fx["_encstr_BE7206A2D07B1322"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.remote_uav[self.team] = undefined;
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

remoteuav_light_fx() {
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_915E0613420DC132"], self, "_encstr_92790F8B9BE4A13C4BA9242BC650773B4D");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_B1EF0591524C08"], self, "_encstr_8D8410AB57CF1FE02114D8C091712F487C06");
}

remoteuav_dialog(var_0) {
  if(var_0 == "_encstr_AF1904F3E3AC")
    var_1 = 1000;
  else
    var_1 = 5000;

  if(gettime() - level.remoteuav_lastdialogtime < var_1) {
    return;
  }
  level.remoteuav_lastdialogtime = gettime();
  var_2 = randomint(level.remoteuav_dialog[var_0].size);
  var_3 = level.remoteuav_dialog[var_0][var_2];
  var_4 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "_encstr_A607032BE0" + var_3;
  self playlocalsound(var_4);
}

remoteuav_handleincomingstinger() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_920E0BE7880931BA61B86733C0");

  for(;;) {
    level waittill("_encstr_A1B90EC33B80328870DB219DE446B39B", var_0, var_1, var_2);

    if(!isDefined(var_1) || !isDefined(var_2) || var_2 != self) {
      continue;
    }
    self.owner playlocalsound("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5");
    self.owner setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_A9E01032D067452FB8B8EFCDC303AF0C9110", 1);
    self.hasincoming = 1;
    self.incomingmissiles[self.incomingmissiles.size] = var_1;
    var_1.owner = var_0;
    var_1 thread watchstingerproximity(var_2);
  }
}

remoteuav_handleincomingsam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_920E0BE7880931BA61B86733C0");

  for(;;) {
    level waittill("_encstr_B4340A9BA073713BB0AEF5EC", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(isDefined(var_5)) {
        self.incomingmissiles[self.incomingmissiles.size] = var_5;
        var_5.owner = var_0;
        var_3++;
      }
    }

    if(var_3) {
      self.owner playlocalsound("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5");
      self.owner setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_A9E01032D067452FB8B8EFCDC303AF0C9110", 1);
      self.hasincoming = 1;
      level thread watchsamproximity(var_2, var_1);
    }
  }
}

watchstingerproximity(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self missile_settargetEnt(var_0);
  var_1 = vectorNormalize(var_0.origin - self.origin);

  while(isDefined(var_0)) {
    var_2 = var_0 getpointinbounds(0, 0, 0);
    var_3 = distance(self.origin, var_2);

    if(var_0.numflares > 0 && var_3 < 4000) {
      var_4 = var_0 deployflares();
      self missile_settargetEnt(var_4);
      return;
    } else {
      var_5 = vectorNormalize(var_0.origin - self.origin);

      if(vectordot(var_5, var_1) < 0) {
        self playSound("_encstr_86B01AC06BF24F9B2B6930BC7DEBC6FBDA8218E0718F63D3039A48AB");
        playFX(level.remoteuav_fx["_encstr_82C910274336BBE1E0D1A1376AD83CB205E3"], self.origin);

        if(isDefined(self.owner))
          radiusdamage(self.origin, 400, 1000, 1000, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AAD60BE6E85ACDB3B29CBE5B1C");
        else
          radiusdamage(self.origin, 400, 1000, 1000, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AAD60BE6E85ACDB3B29CBE5B1C");

        self hide();
        wait 0.05;
        self delete();
      } else
        var_1 = var_5;
    }

    wait 0.05;
  }
}

watchsamproximity(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 missile_settargetEnt(var_0);
      var_3.lastvectotarget = vectorNormalize(var_0.origin - var_3.origin);
    }
  }

  while(var_1.size && isDefined(var_0)) {
    var_5 = var_0 getpointinbounds(0, 0, 0);

    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        if(isDefined(self.markfordetete)) {
          self delete();
          continue;
        }

        if(var_0.numflares > 0) {
          var_7 = distance(var_3.origin, var_5);

          if(var_7 < 4000) {
            var_8 = var_0 deployflares();

            foreach(var_10 in var_1) {
              if(isDefined(var_10))
                var_10 missile_settargetEnt(var_8);
            }

            return;
          }

          continue;
        }

        var_12 = vectorNormalize(var_0.origin - var_3.origin);

        if(vectordot(var_12, var_3.lastvectotarget) < 0) {
          var_3 playSound("_encstr_86B01AC06BF24F9B2B6930BC7DEBC6FBDA8218E0718F63D3039A48AB");
          playFX(level.remoteuav_fx["_encstr_82C910274336BBE1E0D1A1376AD83CB205E3"], var_3.origin);

          if(isDefined(var_3.owner))
            radiusdamage(var_3.origin, 400, 1000, 1000, var_3.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AAD60BE6E85ACDB3B29CBE5B1C");
          else
            radiusdamage(var_3.origin, 400, 1000, 1000, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AAD60BE6E85ACDB3B29CBE5B1C");

          var_3 hide();
          var_3.markfordetete = 1;
        } else
          var_3.lastvectotarget = var_12;
      }
    }

    var_1 = scripts\engine\utility::array_removeundefined(var_1);
    wait 0.05;
  }
}

deployflares() {
  self.numflares--;
  self.owner thread remoteuav_rumble(self, 6);
  self playSound("_encstr_A3621C2FC52EF9D83FE88CD7201F1839334C8B7FA001F10BD3D0869C392F");
  thread playflarefx();
  var_0 = self.origin + (0, 0, -100);
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_1.angles = self.angles;
  var_1 movegravity((0, 0, -1), 5.0);
  var_1 thread deleteaftertime(5.0);
  return var_1;
}

playflarefx() {
  for(var_0 = 0; var_0 < 5; var_0++) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(level._effect["_encstr_91940F1BD14B275EE85BC7C671B8225F6E"], self, "_encstr_8D4F0AC127C789A195E31F25");
    wait 0.15;
  }
}

deleteaftertime(var_0) {
  wait(var_0);
  self delete();
}

remoteuav_clearincomingwarning() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_920E0BE7880931BA61B86733C0");

  for(;;) {
    var_0 = 0;

    for(var_1 = 0; var_1 < self.incomingmissiles.size; var_1++) {
      if(isDefined(self.incomingmissiles[var_1]) && missile_isincoming(self.incomingmissiles[var_1], self))
        var_0++;
    }

    if(self.hasincoming && !var_0) {
      self.hasincoming = 0;
      self.owner setplayerdata("_encstr_AAC110B65879CD63CC4B580D5972AC66C5C5", "_encstr_A9E01032D067452FB8B8EFCDC303AF0C9110", 0);
    }

    self.incomingmissiles = scripts\engine\utility::array_removeundefined(self.incomingmissiles);
    wait 0.05;
  }
}

missile_isincoming(var_0, var_1) {
  var_2 = vectorNormalize(var_1.origin - var_0.origin);
  var_3 = anglesToForward(var_0.angles);
  return vectordot(var_2, var_3) > 0;
}

remoteuav_watchheliproximity() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_920E0BE7880931BA61B86733C0");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.helis) {
      if(distance(var_2.origin, self.origin) < 300) {
        var_0 = 1;
        self.heliinproximity = var_2;
      }
    }

    foreach(var_5 in level.littlebirds) {
      if(var_5 != self && (!isDefined(var_5.helitype) || var_5.helitype != "_encstr_A54E0BF3EA0FB710F7F74B5BE6") && distance(var_5.origin, self.origin) < 300) {
        var_0 = 1;
        self.heliinproximity = var_5;
      }
    }

    if(!self.inheliproximity && var_0)
      self.inheliproximity = 1;
    else if(self.inheliproximity && !var_0) {
      self.inheliproximity = 0;
      self.heliinproximity = undefined;
    }

    waitframe();
  }
}

remoteuav_handledamage() {
  self endon("_encstr_920E0BE7880931BA61B86733C0");
  scripts\mp\damage::monitordamage(self.maxhealth, "_encstr_A54E0BF3EA0FB710F7F74B5BE6", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\damage::handleempdamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);
  playfxontagforclients(level.remoteuav_fx["_encstr_BD1904D06B18"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", self.owner);
  self playSound("_encstr_AF911315953690D073FB38CD92C79DA8CDE9B7A33C");

  if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.smoking = 1;
    playFXOnTag(level.remoteuav_fx["_encstr_BE7206A2D07B1322"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }

  return var_6;
}

handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  scripts\mp\damage::onkillstreakkilled("_encstr_A54E0BF3EA0FB710F7F74B5BE6", var_1, var_2, var_3, var_4, "_encstr_83071587319BECB3387B17EBCF5E0A3D38BB7FC1ABF896", undefined, "_encstr_99531DC6317874E2B5E17F6B3B5E9BA2B89AFF8F6EE0059A80C99F8F330FC3");
}