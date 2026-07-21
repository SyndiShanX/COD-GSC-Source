/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\chopper_support.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_88C5055208731B")]]();

  if(!isDefined(level.grenade_effect))
    level.grenade_effect = ::choppersupport_movetolocation;

  level._effect["_encstr_84A01AE858BFEB4AC7162E106DF8ABEA1B1BE14ABBFB9827C753671E"] = loadfx("_encstr_B60B38CBEA807D2AA09B1FAD3B57CF87994A42EDCA7F5E1FE0A5F3888EB6042F0B713553600B45B2C09753F3F9A3D8B7016AFF20D08B068B5CD8");
  level.choppersupports = [];
  init_chopper_support_vo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", 12);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1, "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", 36, "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 1, "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", 13, "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 1, "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", 100, "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 1, "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", 24, "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1, "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", 26, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  level.heli_structs_entrances = scripts\cp_mp\utility\game_utility::removematchingents_bykey("_encstr_A58E11AAE3BFE8C7C8B31F27DBD9D3C72846D3");
  level.heli_structs_goals = scripts\cp_mp\utility\game_utility::removematchingents_bykey("_encstr_822A0DBA636F18D305B2D108CA1E89");
  level.heli_structs_paths = scripts\cp_mp\utility\game_utility::removematchingents_bykey("_encstr_95830DADCDBE0DCAB1B4BEE016E8A1");
  level.incomingallchoppersupports = 0;
  level.incomingchoppersupports["_encstr_9A8507BA4040188D08"] = 0;
  level.incomingchoppersupports["_encstr_8E8405EA382B2A"] = 0;
}

init_chopper_support_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88031DD60D7078034D1D8F270BEFCBAF202B419D5858387B88D97F570B1CC2"] = "_encstr_88271C99E89788AF4FBBE05F7B33E33AF0A3B83082DF4A13A0D7F214F7E8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF041B48F33F43A912A298967B1BF1E88A3B21A02FCC7E497A0D8F9457"] = "_encstr_B4CC1BC6A17BE00E56E47DB9AB1C0EEDE41DBEA19585C6D10DEB5B2BC8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BE61D177322EF58857A069BA37890A80BEBF789FF6AB468E7D7C9504E5760"] = "_encstr_A3CC1BB778D0304383768182DD917BE7DBA3CF63F8C9944BF19855BDC4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B641E8D86B783E0CA9C7DB957E0C1B7278ED795E6EC589DAC7D8E589C3BAC8E"] = "_encstr_857817EF2088186BBB4EA95A3579A3DFF368A77F88E1414283";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B40117C634B70E0E95C9D7E6AEE0C1DBC947EB0EC23A39DE63"] = "_encstr_B40117C634B70E0E95C9D7E6AEE0C1DBC947EB0EC23A39DE63";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2081706D007B3219FEB2940B3F219E8DB54800C3CE73B4342"] = "_encstr_A2081706D007B3219FEB2940B3F219E8DB54800C3CE73B4342";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C101606D0A0A8D37D2DBF775B9F9BFF10FBB18E0B38538A"] = "_encstr_8C101606D0A0A8D37D2DBF775B9F9BFF10FBB18E0B38538A";
}

tryusechoppersupport(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusechoppersupportfromstruct(var_1);
}

tryusechoppersupportfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname("_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039"));

  if(!istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level.incomingallchoppersupports++;
  var_2 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    var_2 = 2;

  if(level.choppersupports.size >= var_2 || level.choppersupports.size + level.incomingallchoppersupports > var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

    level.incomingallchoppersupports--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var_3 = 1;
    level.incomingchoppersupports[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppersupports) + level.incomingchoppersupports[self.team] > var_3) {
      level.incomingallchoppersupports--;
      level.incomingchoppersupports[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8D6726962998989A8A491528A54DBC6A8285EBC829948A93221356FAD4AA8205A72945EB848A89E9");

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var_4 = usechoppersupport(self, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]]("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_868815D59B5932FA6CA1ED83385939F59B5D1CE0DBE43A", self);

  return var_4;
}

usechoppersupport(var_0, var_1) {
  var_2 = spawnchopper(var_0, var_1);
  level.incomingallchoppersupports--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level.incomingchoppersupports[var_0.team]--;

  if(!isDefined(var_2))
    return 0;

  var_2 thread startchopper(var_0, var_1);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_1);

  return 1;
}

spawnchopper(var_0, var_1) {
  var_2 = (0, 0, 1750);
  var_4 = var_0.origin - anglesToForward(var_0.angles) * 15000 + var_2;
  var_5 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_2;
  var_6 = var_0.angles;
  var_7 = getdvarint("_encstr_82BC1D8B3E9A115E7247E1E9873B88A835525380E2E459815A7B33F98F92ED", 45);
  var_9 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_10 = randomint(level.heli_structs_entrances.size);
    var_11 = level.heli_structs_entrances[var_10];
    var_9 = choppersupport_findtargetStruct(var_11.script_linkto, level.heli_structs_goals);

    if(isDefined(var_9)) {
      var_12 = var_11.origin * (1, 1, 0) + var_2;
      var_13 = var_9.origin * (1, 1, 0) + var_2;
      var_14 = vectorNormalize(var_13 - var_12);
      var_4 = var_13 - var_14 * 15000;
      var_5 = var_13;
      var_6 = vectortoangles(var_14);
    } else {}
  } else {}

  var_21 = "_encstr_BE50133BC7C819C9ED087107F389E30EA7D1F9F0C8";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_21 = "_encstr_A3EC184E8538D2F9F368DAE10BD36A97D37FACD62F66EF3EB798";

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_22 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_4, var_6, "_encstr_880B175437EAD70908E7D0C8D74AC6C7431ACF504A830F30F8", var_21);

  if(!isDefined(var_22))
    return undefined;

  var_22.speed = 100;
  var_22.accel = 50;
  var_22.lifetime = var_7;
  var_22.team = var_0.team;
  var_22.owner = var_0;
  var_22.angles = var_6;
  var_22.streakinfo = var_1;
  var_22.streakname = var_1.streakname;
  var_22.flaresreservecount = 1;
  var_22.currentdamagestate = 0;
  var_22.pathstart = var_4;
  var_22.pathgoal = var_5;
  var_22.currentaction = "_encstr_96080730D8534E0A28";
  var_22.currenttarget = undefined;
  var_22.currentpatrolstruct = var_9;
  var_22.heightoffset = var_2;
  var_22.infil_complete = var_2[2] - 750;
  var_22._id_13766 = 50;
  var_22._id_13767 = 25;
  var_22._id_13768 = undefined;
  var_22._id_11C43 = 7;
  var_22._id_11C44 = 12;
  var_22 setvehicleteam(var_22.team);
  var_22.health = 3500;
  var_22.maxhealth = 3500;
  var_22 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_1.streakname, "_encstr_B6221A912898A54D273037B5B1CEA83FC8F24D826FB0B5F0C3D553B4", undefined, "_encstr_A58418E3DA959F3D4823BF2F0B1890B050A64F4B45071B8F3855", "_encstr_824522B6BF39A4808DF3A121853B39226D48E08566BFD860715721FB479BB568F317EAC3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]](var_1.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]](var_1.streakname, ::choppersupport_modifydamage);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]](var_1.streakname, ::choppersupport_handledeathdamage);

  level.choppersupports[level.choppersupports.size] = var_22;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 100);

  var_22 setmaxpitchroll(15, 15);
  var_22 vehicle_setspeed(var_22.speed, var_22.accel);
  var_22 sethoverparams(50, 5, 2.5);
  var_22 setturningability(0.5);
  var_22 setyawspeed(100, 25, 25, 0.1);
  var_22 setotherent(var_0);
  var_22 setCanDamage(1);
  var_22 setneargoalnotifydist(768);
  var_22 setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_AB0703DBB9", 0);
  var_22 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_23 = "_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_23 = "_encstr_83D225ECBD7BDA5FBD7A90011254FDCEB728F865153353C1699340903B6FB98657C5685569E7C3";

  var_22.frontturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_22 gettagorigin("_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_22.frontturret setModel(var_23);
  var_22.frontturret.owner = var_0;
  var_22.frontturret.team = var_0.team;
  var_22.frontturret.angles = var_22.angles;
  var_22.frontturret.streakinfo = var_1;
  var_22.frontturret.turreton = 1;
  var_22.frontturret.name = "_encstr_9BAF0D33C9DEE68EAF47BAC9C956A3";
  var_22.frontturret.attackingtarget = undefined;
  var_22.frontturret linkTo(var_22);
  var_22.frontturret setturretteam(var_0.team);
  var_22.frontturret setturretmodechangewait(0);
  var_22.frontturret setmode("_encstr_849007B268BD03DFD8");
  var_22.frontturret setotherent(var_0);
  var_22.frontturret setdefaultdroppitch(45);
  var_22.frontturret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_22.frontturret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_22.frontturret.groundtargetent dontinterpolate();
  var_22.rearturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_22 gettagorigin("_encstr_8AA1104B5B2461E420CBE22FE3992A1A8FD5"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_22.rearturret setModel(var_23);
  var_22.rearturret.owner = var_0;
  var_22.rearturret.team = var_0.team;
  var_22.rearturret.angles = var_22.angles;
  var_22.rearturret.streakinfo = var_1;
  var_22.rearturret.turreton = 1;
  var_22.rearturret.name = "_encstr_B4F50CE49516C9BE47D593392BE8";
  var_22.rearturret.attackingtarget = undefined;
  var_22.rearturret linkTo(var_22);
  var_22.rearturret setturretteam(var_0.team);
  var_22.rearturret setturretmodechangewait(0);
  var_22.rearturret setmode("_encstr_849007B268BD03DFD8");
  var_22.rearturret setotherent(var_0);
  var_22.rearturret setdefaultdroppitch(45);
  var_22.rearturret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_22.rearturret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_22.rearturret.groundtargetent dontinterpolate();
  var_22.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_22 gettagorigin("_encstr_ACF80B99F702D840F25D235887"));
  var_22.killcament linkTo(var_22, "_encstr_ACF80B99F702D840F25D235887", (-600, 0, 1000), (0, 0, 0));
  var_22.frontturret.killcament = var_22.killcament;
  var_22.rearturret.killcament = var_22.killcament;
  level notify("_encstr_AA67171FA023D3325D0D1E15EE297A96E9E9AF93385B182A75", var_22);
  return var_22;
}

startchopper(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self setvehgoalpos(self.pathgoal, 1);
  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](var_0, var_1.streakname);
    var_2 = 2.0;
  }

  var_0 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_1.streakname, 1, var_2);
  thread choppersupport_monitorowner();
  thread choppersupport_neargoalsettings();
  self playsoundonmovingent("_encstr_95DA1C68DA57103BE2DBC1E3FBC9FEF8107290C383EFC8EFEBCBC7F3C7E2");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](::choppersupport_handlemissiledetection);
}

choppersupport_monitorowner() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread choppersupport_leave();
    return;
  }

  self.owner scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_8D820B49520F0EC02DDE6367EC");
  thread choppersupport_leave();
}

choppersupport_neargoalsettings() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread choppersupport_watchlifetime();
  thread choppersupport_watchdestoyed();
  thread choppersupport_watchgameendleave();
  thread grab_players_inside();
  thread choppersupport_patrolfield(1);
  thread choppersupport_engageturrettarget(self.frontturret);
  thread choppersupport_engageturrettarget(self.rearturret);
}

choppersupport_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6")]](var_2);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB"))
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB")]](undefined, var_3);

      if(isDefined(var_2.streakinfo))
        var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A2081706D007B3219FEB2940B3F219E8DB54800C3CE73B4342");

      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB"))
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0")]](var_0);

      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    }

    waitframe();
  }
}

choppersupport_engageturrettarget(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!istrue(var_0.turreton) || istrue(var_0._id_13E86)) {
      waitframe();
      continue;
    }

    var_1 = choppersupport_gettargets(var_0, 6000, 1, 1);

    if(isDefined(var_1) && var_1.size > 0) {
      var_2 = choppersupport_acquireturrettarget(var_0, var_1);

      if(isDefined(var_2) && var_2 == "_encstr_85680FEB7807CA1361F59FDE1BEB3F154F")
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

      if(!choppersupport_checkifactivetargets()) {
        if(istrue(self.chopper_boss_explosion) && isDefined(self.intro_enemy_respawner))
          self thread[[self.intro_enemy_respawner]]();
        else if(isDefined(self._id_1220C))
          self thread[[self._id_1220C]]();
        else
          thread choppersupport_patrolfield();
      }
    }

    wait 0.05;
  }
}

choppersupport_acquireturrettarget(var_0, var_1) {
  self notify("_encstr_B6911073D66FB81C0F42717ECB074E500724");
  var_2 = undefined;
  [var_4, var_5, var_6] = choppersupport_getbesttarget(var_0, var_1);

  if(isDefined(var_4)) {
    var_7 = undefined;

    if(istrue(var_6))
      var_7 = var_4 scripts\cp_mp\utility\player_utility::getvehicle();

    choppersupport_setcurrenttarget(var_0, var_4);

    if(istrue(var_5) && self.currenttarget == var_4 && !istrue(self.chopper_boss_explosion))
      self thread[[level.grenade_effect]](var_4, 1);

    choppersupport_fireonturrettarget(var_0, var_4, var_7, 1, var_5);
    var_2 = "_encstr_85680FEB7807CA1361F59FDE1BEB3F154F";
  } else
    var_2 = "_encstr_A1DF1327FD1ECBBF1A7093698811E6F2867441B330";

  return var_2;
}

choppersupport_setcurrenttarget(var_0, var_1) {
  var_0 settargetentity(var_0.groundtargetent);
  var_0.attackingtarget = var_1;

  if(!isDefined(self.currenttarget)) {
    self.currenttarget = var_1;
    self setlookatent(self.currenttarget);
  }
}

choppersupport_clearcurrenttarget(var_0) {
  if(isDefined(self.currenttarget) && self.currenttarget == var_0.attackingtarget)
    self.currenttarget = undefined;

  if(istrue(var_0._id_13A71))
    var_0._id_13A71 = undefined;

  var_0.attackingtarget = undefined;
  var_0 cleartargetentity();
  var_0.groundtargetent unlink();
  var_1 = choppersupport_getactivetargets();

  if(self.currentaction != "_encstr_96080730D8534E0A28") {
    if(var_1.size == 0)
      self clearlookatent();
  }

  var_0 notify("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
}

choppersupport_fireonturrettarget(var_0, var_1, var_2, var_3, var_4) {
  if(self.currentaction != "_encstr_AD1C0A291B7C0BBEA2BFFDE7")
    self.currentaction = "_encstr_AD1C0A291B7C0BBEA2BFFDE7";

  if(istrue(var_3) && isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8B641E8D86B783E0CA9C7DB957E0C1B7278ED795E6EC589DAC7D8E589C3BAC8E");
    self.lastfiretime = gettime();
  }

  choppersupport_watchforlosttarget(var_0);
  thread greenlight(var_0);
  thread choppersupport_watchtargetlos(var_0, var_2);
  thread choppersupport_watchtargettimeout(var_0);
  thread grab_entities_inside(var_0);
  var_5 = weaponfiretime("_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_6 = 0;
  var_7 = 100;

  if(isDefined(self._id_13766))
    var_7 = self._id_13766;

  var_8 = 20;

  if(isDefined(self._id_11C43))
    var_8 = self._id_11C43;

  var_9 = 40;

  if(isDefined(self._id_11C44))
    var_9 = self._id_11C44;

  if(istrue(var_4)) {
    var_10 = 3750;

    while(istrue(goalyaw(var_0, var_1))) {
      if(distance2dsquared(self.origin, var_1.origin) < var_10 * var_10) {
        break;
      }

      waitframe();
    }
  }

  thread grenade_chances(var_0);

  while(istrue(goalyaw(var_0, var_1))) {
    if(istrue(var_0._id_13A71)) {
      if(isDefined(self.currenttarget) && var_1 == self.currenttarget && !istrue(self.chopper_boss_explosion))
        self[[level.grenade_effect]](self.currenttarget, 1);
      else
        var_0 notify("_encstr_8F031EC61ADB8307B293D4578307B79C3AEBA385C9B3CA3A09C97B6D2B62A7A6");
    } else if(var_0 choppersupport_turretlookingattarget()) {
      var_11 = undefined;

      if(isDefined(var_2))
        var_11 = var_1.origin;
      else
        var_11 = var_1 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");

      choppersupport_setattackpoint(var_0, var_1, var_11, var_7);

      if(var_6 == var_8) {
        var_7 = 50;

        if(isDefined(self._id_13767))
          var_7 = self._id_13767;
      } else if(var_6 == var_9) {
        var_7 = undefined;

        if(isDefined(self._id_13768))
          var_7 = self._id_13768;
      }

      var_0 shootturret("_encstr_A14F0AE336178944BA076F41");
      var_6++;

      if(isDefined(var_0.streakinfo))
        var_0.streakinfo.shots_fired++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  }
}

goalyaw(var_0, var_1) {
  return isDefined(self) && isDefined(var_0) && isDefined(var_1) && !isDefined(self.iscrashing) && !isDefined(self.isleaving) && isDefined(var_0.attackingtarget);
}

choppersupport_setattackpoint(var_0, var_1, var_2, var_3) {
  var_4 = var_2;

  if(isDefined(var_3)) {
    var_5 = [self, var_0];
    var_6 = randomint(var_3);
    var_7 = randomint(360);
    var_8 = var_2[0] + var_6 * cos(var_7);
    var_9 = var_2[1] + var_6 * sin(var_7);
    var_10 = var_2[2];
    var_4 = (var_8, var_9, var_10);
    var_0.groundtargetent.origin = var_4;
  } else if(!var_0.groundtargetent islinked())
    var_0.groundtargetent linkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 30), (0, 0, 0));
}

choppersupport_turretlookingattarget() {
  var_0 = 0.992;
  var_1 = anglesToForward(self gettagangles("_encstr_A14F0AE336178944BA076F41"));
  var_2 = vectorNormalize(self.groundtargetent.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(isDefined(self gettargetentity(1)) && var_3 >= var_0)
    return 1;

  return 0;
}

choppersupport_watchforlosttarget(var_0) {
  thread choppersupport_watchforlosttargetaction(var_0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread choppersupport_watchforlosttargetaction(var_0, "_encstr_92861DBA8038538AB045FBC559401513DD1ED2022A97D787E057F2D90DD05F");
  thread choppersupport_watchforlosttargetaction(var_0, "_encstr_B89D1FD886DB1C1C2B4ED4AB3883BDC98EBE1D85E4D9AC4713AC333A4A16E69D59");
  thread choppersupport_watchforlosttargetaction(var_0, "_encstr_8F031EC61ADB8307B293D4578307B79C3AEBA385C9B3CA3A09C97B6D2B62A7A6");
  thread choppersupport_watchforlosttargetaction(var_0, "_encstr_9BCF1D1B86ED38C156E4A6BA831CDB4EA3AF1DC2939DAC8E2AB4DACAF6573A");
  thread choppersupport_watchforlosttargetaction(var_0, "_encstr_97931FA70885D86FC76B2F9333EBA8801BA7011BBA6F88B54B7223BB29D357B8B7");
}

choppersupport_watchforlosttargetaction(var_0, var_1) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
  var_2 = var_0;

  if(var_1 == "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5")
    var_2 = var_0.attackingtarget;

  var_2 waittill(var_1);
  choppersupport_clearcurrenttarget(var_0);
}

greenlight(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");

  if(!scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    return;
  }
  var_1 = self.pathgoal;

  for(;;) {
    if(isDefined(var_0.attackingtarget)) {
      if(distance2dsquared(var_1, self.origin) > 100000000) {
        if(!istrue(self.spawn_lbravo))
          self.spawn_lbravo = 1;

        var_0 notify("_encstr_92861DBA8038538AB045FBC559401513DD1ED2022A97D787E057F2D90DD05F");
        break;
      }
    }

    waitframe();
  }
}

grenade_chances(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");

  for(;;) {
    if(isDefined(var_0.attackingtarget)) {
      var_1 = var_0.attackingtarget;

      if(distance2dsquared(var_0.origin, var_1.origin) > 20250000) {
        wait 2;
        var_0 notify("_encstr_B89D1FD886DB1C1C2B4ED4AB3883BDC98EBE1D85E4D9AC4713AC333A4A16E69D59");
        break;
      }
    }

    waitframe();
  }
}

choppersupport_watchtargetlos(var_0, var_1) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
  var_2 = undefined;
  var_3 = 500;
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_5 = [var_0];

  if(isDefined(var_1)) {
    var_5[var_5.size] = var_1;
    var_6 = var_1 getlinkedchildren();

    if(isDefined(var_6) && var_6.size > 0)
      var_5 = scripts\engine\utility::array_combine(var_5, var_6);
  }

  for(;;) {
    if(!istrue(var_0._id_13A71) && isDefined(var_0.attackingtarget)) {
      var_7 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("_encstr_91E80B3A2CCE7D262C4E9359D8"), var_0.attackingtarget gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_5, var_4);

      if(!istrue(var_7)) {
        if(!isDefined(var_2))
          var_2 = gettime();

        if(gettime() - var_2 > var_3)
          var_0._id_13A71 = 1;
      } else
        var_2 = undefined;
    }

    wait 0.25;
  }
}

choppersupport_watchtargettimeout(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  var_0 notify("_encstr_9BCF1D1B86ED38C156E4A6BA831CDB4EA3AF1DC2939DAC8E2AB4DACAF6573A");
}

grab_entities_inside(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");

  for(;;) {
    if(isDefined(var_0.attackingtarget) && istrue(var_0.attackingtarget.inlaststand)) {
      var_0 notify("_encstr_97931FA70885D86FC76B2F9333EBA8801BA7011BBA6F88B54B7223BB29D357B8B7");
      break;
    }

    waitframe();
  }
}

choppersupport_isactivetarget(var_0) {
  var_1 = 0;

  if(!isDefined(var_0))
    return 0;

  if(isDefined(self.frontturret.attackingtarget)) {
    if(self.frontturret.attackingtarget == var_0)
      var_1 = 1;
  }

  if(isDefined(self.rearturret.attackingtarget)) {
    if(self.rearturret.attackingtarget == var_0)
      var_1 = 1;
  }

  return var_1;
}

choppersupport_checkifactivetargets() {
  return isDefined(self.frontturret.attackingtarget) || isDefined(self.rearturret.attackingtarget);
}

choppersupport_getactivetargets() {
  var_0 = [];

  if(isDefined(self.frontturret.attackingtarget))
    var_0[var_0.size] = self.frontturret.attackingtarget;

  if(isDefined(self.rearturret.attackingtarget))
    var_0[var_0.size] = self.rearturret.attackingtarget;

  return var_0;
}

choppersupport_patrolfield(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_B6911073D66FB81C0F42717ECB074E500724");

  if(isDefined(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self._id_1220C))
    self[[self._id_1220C]](var_0);
  else {
    if(self.currentaction != "_encstr_96080730D8534E0A28")
      self.currentaction = "_encstr_96080730D8534E0A28";
    else if(self.currentaction == "_encstr_96080730D8534E0A28" && !istrue(var_0)) {
      return;
    }
    self clearlookatent();
    var_1 = 500;

    if(goodjobplayer())
      var_1 = 50;

    self setneargoalnotifydist(var_1);
    var_2 = 0;

    for(;;) {
      if(self.currentaction == "_encstr_AD1C0A291B7C0BBEA2BFFDE7") {
        if(!istrue(var_2))
          var_2 = 1;

        waitframe();
        continue;
      }

      if(!istrue(var_0) && istrue(var_2)) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B40117C634B70E0E95C9D7E6AEE0C1DBC947EB0EC23A39DE63");
        var_2 = 0;
      }

      var_3 = choppersupport_findclosestpatrolstruct();

      if(isDefined(var_3) && !istrue(self.chopper_boss_explosion))
        self[[level.grenade_effect]](var_3, 1);
      else {
        var_5 = [];
        var_6 = (0, 0, 0);
        var_7 = self.pathgoal;

        foreach(var_9 in level.players) {
          if(var_9 == self.owner) {
            continue;
          }
          if(level.teambased && var_9.team == self.owner.team) {
            continue;
          }
          if(!var_9 scripts\cp_mp\utility\player_utility::_isalive()) {
            continue;
          }
          var_6 = var_6 + var_9.origin;
          var_5[var_5.size] = var_9;
        }

        if(isDefined(var_6) && var_5.size > 0 && !istrue(self.chopper_boss_explosion)) {
          var_11 = var_6 / var_5.size;
          self[[level.grenade_effect]](var_11);
        }
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    }
  }
}

choppersupport_findclosestpatrolstruct() {
  var_0 = scripts\engine\utility::array_combine(level.heli_structs_goals, level.heli_structs_paths);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(self.currentpatrolstruct) && var_5 == self.currentpatrolstruct) {
      continue;
    }
    var_6 = distance2dsquared(var_5.origin, self.origin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    var_1 = choppersupport_findtargetStruct(var_2.script_linkto, var_0);
    self.currentpatrolstruct = var_2;
  }

  return var_1;
}

choppersupport_canseeenemy(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

choppersupport_movetolocation(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_2 = undefined;
  var_3 = var_0;

  if(!isvector(var_0))
    var_3 = var_0.origin;

  var_4 = [self, self.frontturret, self.rearturret];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_3 * (1, 1, 0) + (0, 0, self.origin[2]);
    var_7 = scripts\engine\trace::sphere_trace(var_5, var_6, 256, var_4);
    var_8 = 0;
    var_9 = var_3[0];
    var_10 = var_3[1];

    if(isDefined(var_7)) {
      if(var_7["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_9 = var_7["_encstr_BD260953AA97E3F014279D"][0];
        var_10 = var_7["_encstr_BD260953AA97E3F014279D"][1];
        var_8 = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      var_11 = var_9 + randomintrange(-500, 500);
      var_12 = var_10 + randomintrange(-500, 500);
      var_13 = getcorrectheight(var_11, var_12, 350);
      var_2 = (var_11, var_12, var_13);
    } else {
      var_13 = getcorrectheight(var_9, var_10, 20);
      var_2 = (var_9, var_10, var_13);
    }

    var_14 = 0;

    if(istrue(var_1) && !istrue(var_8))
      var_14 = var_1;

    self setvehgoalpos(var_2, var_14);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");

    if(!istrue(var_8)) {
      break;
    }
  }
}

debugtimedelta(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_2 = undefined;
  var_3 = var_0;

  if(!isvector(var_0))
    var_3 = var_0.origin;

  if(getdvarint("_encstr_AC5C244F4746891B30807A42F9D81F039DF9CB470DED31C59B29B90D105057DBF7731FD78D9C") > 0)
    var_3 = going_to(var_3);

  var_4 = [self, self.frontturret, self.rearturret];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_3;

    if(istrue(self.chopper_boss_explosion) && isDefined(self.intro_driver_logic)) {
      break;
    } else {
      var_7 = 20;
      var_8 = scripts\engine\utility::ter_op(istrue(self.evasivemaneuvers), 350, var_7);
      var_9 = getcorrectheight(var_3[0], var_3[1], var_8);
      var_6 = (var_6[0], var_6[1], var_9);
      var_10 = 512;
      var_11 = scripts\engine\trace::sphere_trace(var_5, var_6, var_10, var_4);
      var_12 = 0;
      var_13 = var_6[0];
      var_14 = var_6[1];
      var_15 = var_6[2];

      if(isDefined(var_11)) {
        if(var_11["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
          var_13 = var_11["_encstr_BD260953AA97E3F014279D"][0];
          var_14 = var_11["_encstr_BD260953AA97E3F014279D"][1];
          var_15 = getcorrectheight(var_13, var_14, var_8);
          var_12 = 1;
        }
      }

      if(istrue(self.evasivemaneuvers)) {
        var_13 = var_13 + randomintrange(-500, 500);
        var_14 = var_14 + randomintrange(-500, 500);
        var_15 = getcorrectheight(var_13, var_14, var_8);
      }

      var_16 = 0;

      if(istrue(var_1) && !istrue(var_12))
        var_16 = var_1;

      var_2 = (var_13, var_14, var_15);
      self setvehgoalpos(var_2, var_16);
      scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");

      if(!istrue(var_12)) {
        break;
      }
    }
  }
}

going_to(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");

  if(!isDefined(level._id_119E7) || level._id_119E7.size == 0)
    return var_0;

  var_1 = 0;
  var_2 = var_0[2];
  var_3 = getdvarfloat("_encstr_B64A2053E01AB1927B1F637FB53DB1EFBFAB7232DA33A8F90F7E499BC33117E02E40", 1500);

  for(var_4 = 0; !var_4 && var_1 < 360; var_0 = (var_0[0], var_0[1], var_2)) {
    for(var_5 = 0; var_5 < level._id_119E7.size; var_5++) {
      if(self == level._id_119E7[var_5]) {
        continue;
      }
      var_4 = distance2d(var_0, level._id_119E7[var_5].pathgoal) >= var_3;

      if(!var_4) {
        break;
      }
    }

    if(var_4)
      return var_0;

    var_1 = var_1 + 10;
    var_0 = rotatepointaroundvector(self._id_1220D, var_0, var_1);
  }

  return var_0;
}

choppersupport_leave() {
  self endon("_encstr_AD75063D571AE108");
  self playsoundonmovingent("_encstr_AA2419725B5F51B9C080306D4BDE3ED3A26318ADD9A13A9DCF1B32");
  self setmaxpitchroll(0, 0);
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.isleaving = 1;
  self clearlookatent();
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 = var_0 + (0, 0, 1000);
  self setvehgoalpos(var_0, 1);
  self setneargoalnotifydist(100);
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  var_1 = getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(var_1, 1);
  self waittill("_encstr_8B7205D9ED5958");
  self stoploopsound();
  self notify("_encstr_97CF1492E07F825B39B6DBF54F63DFCAA1C15AEA7833");
  thread choppersupport_cleanup();
}

choppersupport_cleanup(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_AC901AEFE275C8E3C8A60FA6AB5FE876E3150191B902C2365A6A4ADA", self.owner);

  if(isDefined(self.frontturret)) {
    self.frontturret setentityowner(undefined);
    self.frontturret.groundtargetent delete();
    self.frontturret delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret setentityowner(undefined);
    self.rearturret.groundtargetent delete();
    self.rearturret delete();
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.has_ammo_drain_passive))
    self[[self.has_ammo_drain_passive]]();

  if(isDefined(self.streakinfo))
    self.streakinfo.onspray = istrue(var_0);

  if(!istrue(self._id_12AA4)) {
    if(isDefined(self.streakinfo))
      self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  }

  if(isDefined(level.choppersupports))
    level.choppersupports = scripts\engine\utility::array_remove(level.choppersupports, self);

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

choppersupport_watchlifetime() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.lifetime);
  thread choppersupport_leave();
}

choppersupport_watchgameendleave() {
  if(isDefined(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self._id_12AA4 = 1;

  if(isDefined(self.streakinfo))
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);

  thread choppersupport_leave();
}

grab_players_inside() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");

  if(!scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    return;
  }
  for(;;) {
    if(istrue(self.spawn_lbravo)) {
      self.frontturret.turreton = 0;
      self.rearturret.turreton = 0;
      var_0 = 8000;

      for(;;) {
        if(distance2dsquared(self.origin, self.pathgoal) <= var_0 * var_0) {
          self.spawn_lbravo = undefined;
          self.frontturret.turreton = 1;
          self.rearturret.turreton = 1;
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

choppersupport_gettargets(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_4 = [];
  var_5 = level.players;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_6 = 4500;

    if(isDefined(var_1))
      var_6 = var_1;

    var_5 = scripts\common\utility::playersinsphere(self.origin, var_6);
  }

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_8 = var_5[var_7];
    [var_10, var_11, var_12] = choppersupport_istarget(var_0, var_8, var_2, var_3);

    if(istrue(var_10)) {
      var_13 = spawnStruct();
      var_13.player = var_8;
      var_13._id_12FA2 = var_11;
      var_13._id_13A93 = var_12;
      var_4[var_4.size] = var_13;
    } else
      continue;

    wait 0.05;
  }

  return var_4;
}

choppersupport_istarget(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(isDefined(self.va_standard_spawnpoint_valid) && ![[self.va_standard_spawnpoint_valid]](var_1))
    return [0, 0, 0];

  if(!goliath_init(var_1))
    return [0, 0, 0];

  if(isDefined(self.owner) && var_1 == self.owner)
    return [0, 0, 0];

  if(!isDefined(var_1.pers["_encstr_8AEF05472BC2D6"]))
    return [0, 0, 0];

  if(level.teambased && var_1.pers["_encstr_8AEF05472BC2D6"] == self.team)
    return [0, 0, 0];

  if(var_1.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return [0, 0, 0];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7"))
      return [0, 0, 0];
  }

  if(istrue(var_1.inlaststand))
    return [0, 0, 0];

  if(scripts\cp_mp\parachute::isparachutegametype() && (var_1 isparachuting() || var_1 isskydiving()))
    return [0, 0, 0];

  var_5 = 0;

  if(istrue(var_2)) {
    if(distance2dsquared(self.origin, var_1.origin) > 20250000) {
      if(distance2dsquared(self.origin, var_1.origin) > 36000000)
        return [0, 0, 0];

      var_5 = 1;
    }
  }

  var_6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_7 = [var_0];
  var_8 = 0;

  if(istrue(var_3)) {
    var_8 = var_1 scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(var_8)) {
      var_9 = var_1 scripts\cp_mp\utility\player_utility::getvehicle();
      var_7[var_7.size] = var_9;
      var_10 = var_9 getlinkedchildren();

      if(isDefined(var_10) && var_10.size > 0)
        var_7 = scripts\engine\utility::array_combine(var_7, var_10);
    }
  }

  var_11 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("_encstr_91E80B3A2CCE7D262C4E9359D8"), var_1 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_7, var_6);

  if(!istrue(var_11))
    return [0, 0, 0];

  return [1, var_5, var_8];
}

goliath_init(var_0) {
  return isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0.sessionstate == "_encstr_877508C1D8C22F2DDC3B";
}

choppersupport_getbesttarget(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in var_1) {
    if(!goliath_init(var_7.player)) {
      continue;
    }
    if(choppersupport_isactivetarget(var_7.player) && !istrue(var_7._id_13A93)) {
      continue;
    }
    var_8 = 0;
    var_9 = 0;
    var_10 = abs(vectortoangles(var_7.player.origin - self.origin)[1]);
    var_11 = abs(self gettagangles("_encstr_A14F0AE336178944BA076F41")[1]);
    var_10 = abs(var_10 - var_11);
    var_12 = var_7.player getweaponslistitems();

    foreach(var_14 in var_12) {
      var_15 = weaponclass(var_14);

      if(var_15 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        var_10 = var_10 - 40;
    }

    if(istrue(var_7._id_12FA2)) {
      var_8 = 1;
      var_10 = var_10 + 40;
    }

    if(istrue(var_7._id_13A93)) {
      var_9 = 1;
      var_10 = var_10 + 20;
    }

    if(!isDefined(var_2) || var_2 > var_10) {
      var_2 = var_10;
      var_3 = var_7.player;
      var_5 = var_9;
      var_4 = var_8;
    }
  }

  return [var_3, var_4, var_5];
}

getcorrectheight(var_0, var_1, var_2) {
  var_3 = self.heightoffset[2];
  var_4 = tracegroundpoint(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 = var_5 + randomint(var_2);
  return var_5;
}

choppersupport_watchdestoyed() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_97CF1492E07F825B39B6DBF54F63DFCAA1C15AEA7833");
  var_0 = self.owner;
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")]](self.killedbyweapon))
      choppersupport_crash(100);
  }

  choppersupport_explode();
}

choppersupport_explode() {
  self notify("_encstr_860808CB78E2984063BA");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_AB0703DBB9", 0);

  if(isDefined(self.intermissionspawntime))
    [[self.intermissionspawntime]]();

  if(isDefined(self.lootfunc))
    self[[self.lootfunc]]();

  wait 0.35;
  choppersupport_cleanup(1);
}

choppersupport_crash(var_0) {
  var_1 = 0;
  self endon("_encstr_860808CB78E2984063BA");
  self setscriptablepartstate("_encstr_8F9E06C26033324B", "_encstr_AB0703DBB9", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("_encstr_86BD0980BBC647A80FDE04");
  self.iscrashing = 1;
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_2 = undefined;

  if(istrue(self.chopper_boss_explosion) && isDefined(self.interaction_is_floor_is_lava_client)) {
    self setneargoalnotifydist(300);
    var_1 = 1;
    var_2 = [[self.interaction_is_floor_is_lava_client]]();
  } else
    var_2 = choppersupport_findcrashposition(3500, 500, 1000);

  if(!isDefined(var_2)) {
    return;
  }
  if(istrue(level._id_14088) && isscriptabledefined()) {
    var_3 = getclosestpointonnavmesh(var_2);
    var_2 = goto_goal_and_snipe(var_3 + (0, 0, 1500), var_3);
  }

  if(isDefined(self.streakinfo))
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8C101606D0A0A8D37D2DBF775B9F9BFF10FBB18E0B38538A", 1);

  self setvehgoalpos(var_2, var_1);
  thread choppersupport_spinout(var_0);
  self vehicle_turnengineoff();
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");

  if(isDefined(self.streakinfo))
    scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

choppersupport_findcrashposition(var_0, var_1, var_2) {
  var_3 = self.origin;
  var_4 = self.infil_complete;
  var_5 = undefined;
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = var_3 + var_6 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 - var_6 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + var_7 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 - var_7 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_6 + var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_6 - var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_7 - var_6) - (0, 0, var_4);
  var_9 = scripts\engine\trace::ray_trace(var_3, var_8, self);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (-1 * var_6 - var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  return var_5;
}

goto_goal_and_snipe(var_0, var_1) {
  var_2 = var_1;
  var_3 = 335;
  var_4 = [self, self.frontturret, self.rearturret];
  var_5 = scripts\engine\trace::sphere_trace(var_0, var_1, var_3, var_4);

  if(isDefined(var_5) && var_5["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_2 = var_5["_encstr_BD260953AA97E3F014279D"];

  return var_2;
}

choppersupport_spinout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.4);
    wait 0.5;
  }
}

tracenewpoint(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A279095A77158A9D386877");
  var_3 = scripts\engine\trace::sphere_trace(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["_encstr_8BCA0C2BFD504F333E6D7513637B"] != "_encstr_9B0C0EE65DE4991DE53856AFB97BE6B2")
    return 0;

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

tracegroundpoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_7 in self.dropcrates)
    var_5[var_5.size] = var_7;
  }

  var_9 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 800, var_5, undefined, 1);

  if(var_9["_encstr_BD260953AA97E3F014279D"][2] < var_4)
    var_10 = var_4;
  else
    var_10 = var_9["_encstr_BD260953AA97E3F014279D"][2];

  return var_10;
}

beginevasivemaneuvers() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
  self endon("_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
  self.evasivemaneuvers = 1;
  var_0 = scripts\engine\utility::_id_143B9(3.0, "_encstr_AD75063D571AE108");

  if(var_0 == "_encstr_995408F398012F656821")
    self.evasivemaneuvers = 0;
}

getcorrectheightescort(var_0, var_1, var_2, var_3) {
  var_4 = 200;

  if(isDefined(var_3))
    var_4 = var_3;

  var_5 = tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_4;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}

choppersupport_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  self.currenthealth = self.health - var_4;

  if(self.currenthealth <= 1500 && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");

    if(isDefined(self.streakinfo))
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_88031DD60D7078034D1D8F270BEFCBAF202B419D5858387B88D97F570B1CC2");
  } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");

    if(isDefined(self.streakinfo))
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AF041B48F33F43A912A298967B1BF1E88A3B21A02FCC7E497A0D8F9457");
  } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");

    if(isDefined(self.streakinfo))
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8BE61D177322EF58857A069BA37890A80BEBF789FF6AB468E7D7C9504E5760");
  }

  return 1;
}

choppersupport_handledeathdamage(var_0) {
  self.killedbyweapon = var_0.objweapon;

  if(istrue(self.usefuncoverride) && isDefined(level._id_13457)) {
    if(isDefined(var_0.objweapon))
      [[level._id_13457._id_1346A]](var_0.objweapon.basename);
    else
      [[level._id_13457._id_1346A]]("_encstr_8BBA05185F8B99");
  }

  return 1;
}

choppersipport_randommovement() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.lastaction = "_encstr_96DD0F932CCDC8DE6B53BD3B59D62BE61D";
  var_0 = self.defendloc;
  var_1 = getrandompoint(self.origin);
  self setvehgoalpos(var_1, 1);
  thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, var_1, 5, (1, 0, 1));
  self waittill("_encstr_8B7205D9ED5958");
}

getrandompoint(var_0) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = getcorrectheight(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  } else {
    var_5 = self.angles[1];
    var_6 = int(var_5 - 60);
    var_7 = int(var_5 + 60);
    var_8 = randomintrange(var_6, var_7);
    var_9 = (0, var_8, 0);
    var_10 = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
    var_11 = var_10[0];
    var_12 = var_10[1];
    var_13 = getcorrectheight(var_11, var_12, 20);
    var_14 = tracenewpoint(var_11, var_12, var_13);

    if(var_14 != 0)
      return var_14;

    var_11 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
    var_12 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
    var_15 = (var_11, var_12, var_13);
    return var_15;
  }
}

getnewpoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    if(!level.teambased || var_4.team != self.team)
      var_2[var_2.size] = var_4.origin;
  }

  if(var_2.size > 0) {
    var_6 = averagepoint(var_2);
    var_7 = var_6[0];
    var_8 = var_6[1];
  } else {
    var_9 = level.mapcenter;
    var_10 = level.mapsize / 4;
    var_7 = randomfloatrange(var_9[0] - var_10, var_9[0] + var_10);
    var_8 = randomfloatrange(var_9[1] - var_10, var_9[1] + var_10);
  }

  var_11 = getcorrectheight(var_7, var_8, 20);
  var_12 = tracenewpoint(var_7, var_8, var_11);

  if(var_12 != 0)
    return var_12;

  var_7 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
  var_8 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
  var_11 = getcorrectheight(var_7, var_8, 20);
  var_13 = (var_7, var_8, var_11);
  return var_13;
}

getpathstart(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_2);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

choppersupport_findtargetStruct(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4.script_linkname == var_0) {
      var_2 = var_4;
      break;
    }
  }

  return var_2;
}

goodjobplayer() {
  var_0 = 0;

  switch (level.mapname) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
    case "_encstr_A2200CDA13D6CBC897E1A0EBAA93":
      var_0 = 1;
      break;
  }

  return var_0;
}