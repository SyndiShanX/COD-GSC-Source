/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killcam.gsc
***********************************************/

init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_AA820D597390A73BE74BE15B26FEA2");
  level.killcammiscitems = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_B1CA1859804E582B22325158DA3DF711FF115DC5E55768070A8B", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("_encstr_B1CA1859804E582B22325158DA3DF711FF115DC5E55768070A8B", var_0, 1);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    level.killcammiscitems[var_2] = var_1;
    var_0++;
  }
}

setcinematiccamerastyle(var_0, var_1, var_2) {
  self setclientomnvar("_encstr_A9590FD80BB5EBDC1B56B9567DDC586B2B", var_0);
  self setclientomnvar("_encstr_B4490F3B9B3089AFD6C1922A6EB90FFE90", var_1);
  self setclientomnvar("_encstr_BAC212BEE66B8E423227207AD9828343B80F0683", var_2);
}

getkillcamentity(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_0 == var_1 && !isagent(var_0))
    return undefined;

  if(usesattackeraskillcamentity(var_0, var_1, var_2, var_3))
    return undefined;

  if(usesvehiclekillcamentityrelay(var_0, var_1, var_2, var_3))
    return var_1.killcament;

  switch (var_2.basename) {
    case "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E":
    case "_encstr_A3BA1420F546180EC9EB83B92723D5E8FACF2B5E9DA8":
    case "_encstr_8C5A1231DEEA37D82D9BD9F5312BA33AE5AFADC1":
    case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
    case "_encstr_A14A0DD37BFF6FA915219DF36F7D98":
    case "_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07":
    case "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E":
    case "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9":
    case "_encstr_92EA0A290B32FF88A90170EB":
      return scripts\engine\utility::ter_op(isDefined(var_1.killcament), var_1.killcament, var_1);
    case "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9":
    case "_encstr_A29408E6D5D6CAAF5B1C":
    case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
    case "_encstr_95E70D8EDBDA85F5839CED35F5B683":
    case "_encstr_8BBA05185F8B99":
      if(isnoneweaponinflictor(var_1) || isenvironmentalinflictor(var_1))
        return var_1.killcament;

      break;
  }

  if(scripts\common\utility::isdestructibleweapon(var_2.basename) || scripts\mp\utility\weapon::isbombsiteweapon(var_2.basename)) {
    if(isDefined(var_1.killcament) && !var_0 scripts\mp\utility\killstreak::attackerinremotekillstreak())
      return var_1.killcament;
    else
      return undefined;
  }

  return var_1;
}

usesattackeraskillcamentity(var_0, var_1, var_2, var_3) {
  switch (var_2.basename) {
    case "_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583":
    case "_encstr_A90C1AE6ACB63A5987AFE16BA5ADCA13C027FAE60E36B0DC86D76B07":
    case "_encstr_889F1CA3D0ACC9B62D8EB2FA3CB596DAACC403E4D7390B23A5D5B9BED607":
    case "_encstr_84A0166830BBFB0FB38089F0E1D84E2B5B18102BBA09B85B":
    case "_encstr_B69C1874D1289ABFBB9B4AD16180F353A18D19EC4BAB62AF51F3":
    case "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0":
    case "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC":
    case "_encstr_84A00E50B085578F87182E98ED81081B":
    case "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83":
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
    case "_encstr_AC740FAA3BF169D025C6A373200C27E06B":
    case "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0":
    case "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002":
    case "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1":
    case "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579":
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
    case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
    case "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8":
    case "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2":
    case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
      return 1;
  }

  return 0;
}

usesvehiclekillcamentityrelay(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    return 0;

  if(!var_1 scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  switch (var_3) {
    case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
    case "_encstr_911B0C7DA090E9A7F799FD50DD48":
    case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
    case "_encstr_84670F0D974DCF124E3F7A931851A1FB9F":
      return 1;
    default:
      return 0;
  }
}

setkillcamerastyle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5.camerastyle = "_encstr_8DC7086BEEA408C0AF8A";

  if(isDefined(var_1) && isDefined(var_1.agent_type)) {
    setcinematiccamerastyle("_encstr_B1450EE02AA519A94FBD786F8F6730E1", var_0 getentitynumber(), var_3 getentitynumber());
    var_5.camerastyle = "_encstr_B1450EE02AA519A94FBD786F8F6730E1";
    return 1;
  } else if(isDefined(var_6) && isDefined(var_6.basename)) {
    if(var_6.basename == "_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C" || var_6.basename == "_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07" || var_6.basename == "_encstr_8EC319437BB679EF28B0A17249903CB287E167DB1D5DE2AB513862")
      return 1;
  } else if(var_4 > 0) {
    setcinematiccamerastyle("_encstr_8DC7086BEEA408C0AF8A", -1, -1);
    return 0;
  } else {
    setcinematiccamerastyle("_encstr_8DC7086BEEA408C0AF8A", -1, -1);
    return 0;
  }

  return 0;
}

trimkillcamtime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2 + var_3;

  if(isDefined(var_5) && var_6 > var_5) {
    if(var_5 < 2) {
      return;
    }
    if(var_5 - var_2 >= 1)
      var_3 = var_5 - var_2;
    else {
      var_3 = 1;
      var_2 = var_5 - 1;
    }

    var_6 = var_2 + var_3;
  }

  var_7 = var_2 + var_4;

  if(isDefined(var_0) && isDefined(var_0.lastspawntime))
    var_8 = var_0.lastspawntime;
  else {
    var_8 = var_1.lastspawntime;

    if(isDefined(var_1.deathtime)) {
      if(gettime() - var_1.deathtime < var_3 * 1000.0) {
        var_3 = 1.0;
        var_3 = var_3 - level.framedurationseconds;
        var_6 = var_2 + var_3;
      }
    }
  }

  var_9 = (gettime() - var_8) / 1000.0;

  if(var_7 > var_9 && var_9 > var_4) {
    var_10 = var_9 - var_4;

    if(var_2 > var_10) {
      var_2 = var_10;
      var_6 = var_2 + var_3;
      var_7 = var_2 + var_4;
    }
  }

  var_11 = spawnStruct();
  var_11.camtime = var_2;
  var_11.postdelay = var_3;
  var_11.killcamlength = var_6;
  var_11.killcamoffset = var_7;
  return var_11;
}

prekillcamnotify(var_0) {
  if(isDefined(var_0) && !isagent(var_0)) {
    var_1 = [];

    if(isDefined(self.class) && isDefined(self.classstruct)) {
      var_2 = scripts\mp\playerlogic::getplayerassets(self.classstruct);
      var_1[var_1.size] = var_2;
    }

    if(isDefined(var_0.class) && isDefined(var_0.classstruct)) {
      var_3 = scripts\mp\playerlogic::getplayerassets(var_0.classstruct);
      var_1[var_1.size] = var_3;
    }

    if(var_1.size > 0)
      scripts\mp\playerlogic::loadplayerassets(var_1, 1);

    self predictstreampos(var_0 getEye(), 1);
    self loadcustomizationplayerview(var_0);
  }
}

makekillcamdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_16 = spawnStruct();
  var_16.einflictor = var_0;
  var_16.inflictoragentinfo = var_1;
  var_16.attackernum = var_2;
  var_16.killcamentityindex = var_3;
  var_16.killcamentitystarttime = var_4;
  var_16.killcamlookatentityindex = var_5;
  var_16.killcamentstickstolookatent = var_6;
  var_16.objweapon = var_7;
  var_16.offsettime = var_8;
  var_16.maxtime = var_9;
  var_16.attacker = var_10;
  var_16.victim = var_11;
  var_16.smeansofdeath = var_12;
  var_16.attackerloadoutperks = var_13;
  var_16.skippable = var_14;
  var_16.doslowmo = var_15;

  if(var_12 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
    var_16.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(var_10);

  return var_16;
}

dokillcamfromstruct(var_0, var_1, var_2, var_3) {
  killcam(var_0.einflictor, var_0.inflictoragentinfo, var_0.attackernum, var_0.killcamentityindex, var_0.killcamentitystarttime, var_0.killcamlookatentityindex, var_0.killcamentstickstolookatent, var_0.objweapon, var_1, var_0.offsettime, var_2, var_0.maxtime, var_0.attacker, var_0.victim, var_0.smeansofdeath, var_0.attackerloadoutperks, var_0.skippable, var_0.doslowmo, var_3);
}

calckillcamtimes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(getDvar("_encstr_B26111F8FEFB873028808D6FF7FA51B4F32535") == "_encstr_B40101") {
    if(level.showingfinalkillcam) {
      if(var_10 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
        var_11 = 4.0;
      else if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
        if(isDefined(var_2.recentkillcount) && var_2.recentkillcount > 1)
          var_11 = 4.0 + level.maxkillcamdelay - var_9;
        else
          var_11 = 1.5 + level.maxkillcamdelay - var_9;
      } else
        var_11 = 4.0 + level.maxkillcamdelay - var_9;
    } else if(var_7.basename == "_encstr_A2950D16C9E8D2361B59932FF55BC1")
      var_11 = 2.25;
    else if(var_7.basename == "_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07")
      var_11 = 3.0;
    else if(var_7.basename == "_encstr_A3BA1420F546180EC9EB83B92723D5E8FACF2B5E9DA8" || var_7.basename == "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E")
      var_11 = 1.5;
    else if(var_7.basename == "_encstr_95E70D8EDBDA85F5839CED35F5B683")
      var_11 = 2.5;
    else if(var_7.basename == "_encstr_8DCB0F47F22330CEE7996B13A2E390583A")
      var_11 = 3.0;
    else if(var_7.basename == "_encstr_8D270BA9C2D9B2D8D2E67DB5E0")
      var_11 = 8;
    else if(issubstr(var_7.basename, "_encstr_B6C60FE4ACDAB7D1CAD64B37E62DB195D7"))
      var_11 = 5;
    else if(isDefined(var_0.sentrytype) && var_0.sentrytype == "_encstr_A1EE0CA817AC336BF3F39EA6CFCB")
      var_11 = 2.0;
    else if(!var_8 || var_8 > 5.0)
      var_11 = 5.0;
    else if(var_7.basename == "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B" || var_7.basename == "_encstr_8B7B168C532F076F4F9BC5A8681AC73E139108D3A0B7AD11" || var_7.basename == "_encstr_92A70ABB8267F5E0D89F6351" || var_7.basename == "_encstr_BDCC0EB995DAE8AC1E0793B79AFAB683" || var_7.basename == "_encstr_AA4311CAF026F37EB88F4B2883304517D82893" || var_7.basename == "_encstr_8592135EB163BBE43908DF372011A6C2295D295527")
      var_11 = 4.25;
    else
      var_11 = 2.5;
  } else
    var_11 = getdvarfloat("_encstr_B26111F8FEFB873028808D6FF7FA51B4F32535");

  if(isDefined(var_5)) {
    if(var_11 > var_5)
      var_11 = var_5;

    if(var_11 < level.framedurationseconds)
      var_11 = level.framedurationseconds;
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    var_12 = 1;

    if(var_10 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      var_12 = 3.0;
  } else if(getDvar("_encstr_86D4152B9E3AB1FAC2EBB9AFF7AA2810CF723343849D28") == "_encstr_B40101")
    var_12 = 2;
  else {
    var_12 = getdvarfloat("_encstr_86D4152B9E3AB1FAC2EBB9AFF7AA2810CF723343849D28");

    if(var_12 < level.framedurationseconds)
      var_12 = level.framedurationseconds;
  }

  if(var_3 < 0 || !isDefined(var_2))
    return undefined;

  if(isagent(var_2) || isagent(var_0))
    var_3 = var_4 getentitynumber();

  var_13 = trimkillcamtime(var_1, var_2, var_11, var_12, var_6, var_5);

  if(!isDefined(var_13))
    return undefined;

  return var_13;
}

setkilledbyuiomnvar(var_0) {
  self setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", var_0 getentitynumber());
}

setkillcamuitimer(var_0) {
  self setclientomnvar("_encstr_AC4D1C4FD076CB3271996EE6716F8A8679F9A78750C8315B4B26755DED1F", int(var_0 * 1000) + gettime());
}

setupkillcamui(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isPlayer(var_0)) {
    setkilledbyuiomnvar(var_0);
    self setclientomnvar("_encstr_930D15F31B0F02D130A04757B00E866ACF2D7C6DE88B2A", var_1 getentitynumber());
    self loadcustomizationplayerview(var_0);
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename))
    setkillcamkillstreaktypeomnvars(var_2);
  else if(istrue(level.allowperks))
    scripts\mp\perks\perks::setomnvarsforperklist("_encstr_BEB11957C86EE31A49A146FE190772B950886F9B08021F53A3464C", var_5);

  var_6 = getdvarint("_encstr_BD781816114E3717BA7E6371622989074D6381C601A033E25018");

  if(var_4 && !level.gameended || isDefined(self) && !level.gameended || var_6 == 0 && !level.gameended)
    self setclientomnvar("_encstr_96E7109D7CD1F73074A310084FAF6B134BA3", "_encstr_8A18059BF07BBA");
  else if(!level.gameended)
    self setclientomnvar("_encstr_96E7109D7CD1F73074A310084FAF6B134BA3", "_encstr_A20A088EDD77B3031B2A");
  else
    self setclientomnvar("_encstr_96E7109D7CD1F73074A310084FAF6B134BA3", "_encstr_8BBA05185F8B99");

  setkillcamuitimer(var_3.killcamlength);
}

beginarchiveplayback(var_0, var_1, var_2, var_3) {
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self.spectatekillcam = 1;
  self.forcespectatorclient = var_0;
  self.killcamentity = -1;
  self.archivetime = var_1;
  self.killcamlength = var_2;
  self.psoffsettime = var_3;
  self allowspectateteam("_encstr_818709A35AE71A38D792CF", 1);
  self allowspectateteam("_encstr_8BBA05185F8B99", 1);

  foreach(var_5 in level.teamnamelist)
  self allowspectateteam(var_5, 1);
}

checkkillcamtruncation(var_0) {
  if(self.archivetime + 0.015 < var_0) {
    var_1 = var_0 - self.archivetime;

    if(game["_encstr_AF851340BBA7C53FD36B0F07A1B438A990EE8E188E"] < 32)
      game["_encstr_AF851340BBA7C53FD36B0F07A1B438A990EE8E188E"]++;
  }
}

queueforkillcam() {
  level.numplayerswaitingtoenterkillcam++;
  var_0 = 1;

  if(istrue(level.showingfinalkillcam) && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    var_0 = 5;

  var_1 = level.framedurationseconds * int(floor((level.numplayerswaitingtoenterkillcam - 1) / var_0));
  level.maxkillcamdelay = var_1;

  if(var_1 > 0)
    wait(var_1);

  waitframe();
  level.numplayerswaitingtoenterkillcam--;
  return var_1;
}

killcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BA350853C128FB939DB9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::_id_12898("_encstr_871119AD961B36B1B0D6A38E6D2D8DB1C6C26B052540A651504A2A");
  resetplayeromnvarsonkillcam();

  if(var_2 < 0 || !isDefined(var_12)) {
    self notify("_encstr_958F11AD5AD836D8855BBE6C0B378D95B12B19");

    if(istrue(var_18))
      self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);

    return;
  }

  var_19 = queueforkillcam();
  var_20 = calckillcamtimes(var_0, var_1, var_12, var_2, var_13, var_11, var_8, var_7, var_10, var_19, var_14);

  if(!isDefined(var_20)) {
    self notify("_encstr_958F11AD5AD836D8855BBE6C0B378D95B12B19");

    if(istrue(var_18))
      self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);

    return;
  }

  setupkillcamui(var_12, var_13, var_7, var_20, var_10, var_15);

  if(isPlayer(var_12))
    self loadcustomizationplayerview(var_12);

  beginarchiveplayback(var_2, var_20.killcamoffset, var_20.killcamlength, var_9);
  var_21 = setkillcamerastyle(var_0, var_1, var_2, var_13, var_3, var_20, var_7);

  if(!var_21)
    thread setkillcamentity(var_3, var_20.killcamoffset, var_4, var_5, var_6);

  thread endedkillcamcleanup(var_18);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  checkkillcamtruncation(var_20.killcamoffset);
  var_20.camtime = self.archivetime - level.framedurationseconds - var_8;
  var_20.killcamlength = var_20.camtime + var_20.postdelay;
  self.killcamlength = var_20.killcamlength;

  if(var_20.camtime <= 0) {
    killcamcleanup(1, undefined, var_18);
    return;
  }

  self.killcam = 1;
  thread spawnedkillcamcleanup(var_18);

  if(istrue(var_17))
    thread dokillcamslowmo(var_20.camtime);

  if(!isDefined(var_16) || var_16) {
    thread waitskipkillcambutton(var_10);
    thread waitskipkillcamkbm();
  }

  if(istrue(var_18))
    thread scripts\mp\final_killcam::play_patrol_sequence_based_on_first_vehicle();

  thread endkillcamifnothingtoshow();

  if(!isbot(self))
    thread _id_12C7F();

  self.killcamwatchtime = gettime();
  waittillkillcamover();
  self.killcamwatchtime = (gettime() - self.killcamwatchtime) / 1000;
  scripts\mp\utility\stats::incpersstat("_encstr_A755157338D14277567B067A400DEF7C9A7C7A26F9DA13", self.killcamwatchtime);
  killcamcleanup(1, undefined, var_18);
  scripts\mp\utility\player::_id_12898("_encstr_92331CE79B7182233098A0A87058643A5E236762E38FB8370947254F8FC1");
}

_id_12C7F() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143BA(0.15, "_encstr_958F11AD5AD836D8855BBE6C0B378D95B12B19", "_encstr_BA350853C128FB939DB9");
  self clearpredictedstreampos();

  if(istrue(level.showingfinalkillcam))
    scripts\mp\gamelogic::_id_1284E();
}

setuppotgui(var_0, var_1) {
  setkilledbyuiomnvar(var_0);
  setkillcamuitimer(var_1);
}

potg_killcam(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  prekillcamnotify(var_0);
  resetplayeromnvarsonkillcam();
  var_4 = var_0 getentitynumber();
  queueforkillcam();

  if(isPlayer(var_0))
    self loadcustomizationplayerview(var_0);

  var_5 = gettime();
  var_6 = (var_5 - var_2) / 1000.0;
  var_7 = (var_5 - var_3) / 1000.0;
  var_8 = (var_3 - var_2) / 1000.0;
  setuppotgui(var_0, var_8);
  self.archiveusepotg = 1;
  beginarchiveplayback(var_4, var_6, var_8, var_1);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  checkkillcamtruncation(var_6);
  self.killcamlength = self.archivetime - var_7;
  self.killcam = 1;
  self notify("_encstr_8D860E6955CFC7F01712F863A25F2FC8");
  waittillkillcamover();
  potgkillcamcleanup();
}

potgkillcamcleanup() {
  self.killcam = undefined;
  scripts\mp\spectating::setspectatepermissions();
  scripts\mp\utility\player::updatesessionstate("_encstr_84670547C3E9F4");
  scripts\mp\utility\player::clearkillcamstate();
  self notify("_encstr_84BC0E804AC539896F9D584D6683B1E1");
}

dokillcamslowmo(var_0) {
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");

  if(isDefined(level.doingkillcamslowmo)) {
    return;
  }
  level.doingkillcamslowmo = 1;
  var_1 = 0;
  var_2 = var_0;

  if(var_2 > 1.0) {
    var_2 = 1.0;
    var_1 = var_1 + 1.0;
    wait(var_0 - var_1);
  }

  if(!isDefined(level.vip_freeze_link)) {
    createheadiconatorigin("_encstr_8A130803D3E8D3869B38");
    level.vip_freeze_link = 1;
  }

  setslowmotion(1.0, 0.25, var_2);
  wait(var_2 + 0.5);
  setslowmotion(0.25, 1, 1);
  level.doingkillcamslowmo = undefined;
}

setkillcamnormalweaponomnvars(var_0, var_1, var_2, var_3) {
  if(var_1 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
    setkillcamexecutiontypeomnvars(var_3);
  else if(!isDefined(var_0) || var_0.basename == "_encstr_8BBA05185F8B99")
    clearkillcamattachmentomnvars();
  else {
    if(isDefined(var_2.see_killstreak_dist)) {
      var_4 = undefined;
      var_0 = var_2.see_killstreak_dist;
      var_2 = undefined;
    } else
      var_4 = scripts\mp\utility\weapon::getequipmenttype(var_0.basename);

    if(isDefined(scripts\mp\supers::getsuperrefforsuperweapon(var_0)))
      setkillcamsupertypeomnvars(var_0);
    else {
      if(isDefined(var_4) && (var_4 == "_encstr_B116071BCAD186858D" || var_4 == "_encstr_99C209E34FC743616118AB")) {
        setkillcamequipmenttypeomnvars(var_0);
        return;
      }

      if(isDefined(level.killcammiscitems[var_0.basename])) {
        setkillcammisctypeomnvars(level.killcammiscitems[var_0.basename]);
        return;
      }

      setkillcamweapontypeomnvars(var_0, var_2);
    }
  }
}

waittillkillcamover() {
  self endon("_encstr_B6730EE73AE71389B1DA381842565B08");
  scripts\mp\utility\player::_id_12898("_encstr_932C25087BD23C219A8BC5285F40C7FB748AB874BF01C87C0EFF98EF9B1D7A2351C0E701B046EB");
  wait(self.killcamlength - level.frameduration / 1000.0);
  scripts\mp\utility\player::_id_12898("_encstr_860628D769E59846773AA29AA34F0B10BBF151A1230C20199712403CDB37BE2A0410976F9DBAE9C51348");
}

setkillcamentity(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");
  var_5 = gettime() - var_1 * 1000;

  if(var_2 > var_5) {
    waitframe();
    var_1 = self.archivetime;
    var_5 = gettime() - var_1 * 1000;

    if(var_2 > var_5)
      wait((var_2 - var_5) / 1000);
  }

  self.killcamentity = var_0;

  if(isDefined(var_3))
    self.killcamentitylookat = var_3;

  if(isDefined(var_4))
    self setkillcamentstickstolookatent(var_4);
}

waitskipkillcambutton(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");

  if(!isai(self)) {
    self notifyonplayercommand("_encstr_821E0B7FB01F72C2FFCF12F3C6", "_encstr_97410B23BD6B976233901AF2F8");
    self notifyonplayercommand("_encstr_821E0B7FB01F72C2FFCF12F3C6", "_encstr_B4C60AD707B2BDC0E6CE1309");
    self waittill("_encstr_821E0B7FB01F72C2FFCF12F3C6");
    scripts\mp\utility\stats::incpersstat("_encstr_9365101BA7930358C5F98289A408DB3A4858", 1);
    scripts\mp\utility\player::_id_12898("_encstr_8887315B961BD86C2CB547A3770B2DE86ADA4B38A52DC6366C16B5905DD18EDBB9149401A54BD81BD8165B809AD24A82281511");
    self notify("_encstr_B6730EE73AE71389B1DA381842565B08");
  }
}

waitskipkillcamkbm() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");
  self endon("_encstr_B6730EE73AE71389B1DA381842565B08");

  while(self usinggamepad() || !self jumpbuttonPressed())
    waitframe();

  scripts\mp\utility\stats::incpersstat("_encstr_9365101BA7930358C5F98289A408DB3A4858", 1);
  scripts\mp\utility\player::_id_12898("_encstr_8AB32E60AA259929CF3D4A421FF750614212F84060BC2180AF59F9C2C2AFB083E6B86028AA5673787A73E2CBC8834591");
  self notify("_encstr_B6730EE73AE71389B1DA381842565B08");
}

endkillcamifnothingtoshow() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");

  for(;;) {
    if(self.archivetime <= 0) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\player::_id_12898("_encstr_BE1C35DAD2B1C61BB0D6741D2B3791695AB18D1BC26B949927B7A334B4DC3B2ADB350DBDDD059201964BD8B11B2C5B10359694050AA888");
  self notify("_encstr_B6730EE73AE71389B1DA381842565B08");
}

spawnedkillcamcleanup(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");
  self waittill("_encstr_BA350853C128FB939DB9");
  killcamcleanup(0, undefined, var_0);
}

endedkillcamcleanup(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84BC0E804AC539896F9D584D6683B1E1");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  killcamcleanup(1, 1, var_0);
}

clearkillcamomnvars() {
  clearkillcamkilledbyitemomnvars();
  self setclientomnvar("_encstr_AC4D1C4FD076CB3271996EE6716F8A8679F9A78750C8315B4B26755DED1F", 0);
  self setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", -1);
  self setclientomnvar("_encstr_930D15F31B0F02D130A04757B00E866ACF2D7C6DE88B2A", -1);
  self setclientomnvar("_encstr_876424BA2DF55BD236631B85B5D7ADD21B36958C262FAFB1DEBDE8AFCE164E2D58378EBED28C", -1);
  self setclientomnvar("_encstr_8D4722B7B047643A798DD803E0EF6230F2C2D2FA7E6971B3E5A72AD03B985B9B32BBE9B3", -1);
  clearkillcamattachmentomnvars();

  for(var_0 = 0; var_0 < 6; var_0++)
    self setclientomnvar("_encstr_BEB11957C86EE31A49A146FE190772B950886F9B08021F53A3464C" + var_0, -1);
}

killcamcleanup(var_0, var_1, var_2) {
  clearkillcamomnvars();
  self.killcam = undefined;
  setcinematiccamerastyle("_encstr_8DC7086BEEA408C0AF8A", -1, -1);
  scripts\mp\spectating::setspectatepermissions(var_1);
  scripts\mp\utility\player::clearkillcamstate();

  if(istrue(var_0) && !istrue(var_1))
    scripts\mp\utility\player::updatesessionstate("_encstr_84670547C3E9F4");

  self notify("_encstr_84BC0E804AC539896F9D584D6683B1E1");

  if(istrue(var_2))
    self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
}

clearlootweaponomnvars() {
  self setclientomnvar("_encstr_876424BA2DF55BD236631B85B5D7ADD21B36958C262FAFB1DEBDE8AFCE164E2D58378EBED28C", -1);
  self setclientomnvar("_encstr_8D4722B7B047643A798DD803E0EF6230F2C2D2FA7E6971B3E5A72AD03B985B9B32BBE9B3", -1);
}

clearkillcamkilledbyitemomnvars() {
  self setclientomnvar("_encstr_B1CF1ED55AAF5BA5B1C61B16DAF56D4B361BACC813E5FA5A3A2BADBEE8F20795", -1);
  self setclientomnvar("_encstr_BA751C38A368F870B2FB103883E1B377389D3D71969FD1FC4B332247C837", -1);
}

setkillcamkilledbyitemomnvars(var_0, var_1) {
  self setclientomnvar("_encstr_B1CF1ED55AAF5BA5B1C61B16DAF56D4B361BACC813E5FA5A3A2BADBEE8F20795", var_0);
  self setclientomnvar("_encstr_BA751C38A368F870B2FB103883E1B377389D3D71969FD1FC4B332247C837", var_1);
}

setkillcamweapontypeomnvars(var_0, var_1) {
  if(isDefined(var_0._id_121D9))
    var_0 = var_0._id_121D9;

  var_0 = scripts\mp\utility\weapon::mapweapon(var_0, var_1);
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
  var_3 = tablelookuprownum("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_2);
  self setclientomnvar("_encstr_AD81115796EBDD2B0B0EF69BBE38D28DB5BA83", 0);

  if(!isDefined(var_3) || var_3 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  var_4 = scripts\mp\loot::getlootinfoforweapon(var_0.basename, var_0.variantid);

  if(isDefined(var_4)) {
    self setclientomnvar("_encstr_876424BA2DF55BD236631B85B5D7ADD21B36958C262FAFB1DEBDE8AFCE164E2D58378EBED28C", var_4.variantid);
    self setclientomnvar("_encstr_8D4722B7B047643A798DD803E0EF6230F2C2D2FA7E6971B3E5A72AD03B985B9B32BBE9B3", var_4.quality - 1);
  } else {
    self setclientomnvar("_encstr_876424BA2DF55BD236631B85B5D7ADD21B36958C262FAFB1DEBDE8AFCE164E2D58378EBED28C", -1);
    self setclientomnvar("_encstr_8D4722B7B047643A798DD803E0EF6230F2C2D2FA7E6971B3E5A72AD03B985B9B32BBE9B3", -1);
  }

  self setclientomnvar("_encstr_8B8F29E38C6E630981F86E30B5A1085BA181A7F1185351DFCF432BCF68FF1B4ED3839CEA199068CB795313", gettime());
  setkillcamkilledbyitemomnvars(0, var_3);

  if(var_2 != "_encstr_87610AB4EE83FAD6374B3395") {
    var_5 = getweaponattachments(var_0);

    if(!isDefined(var_5))
      var_5 = [];

    var_6 = 0;

    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];
      var_9 = scripts\mp\utility\weapon::attachmentmap_tobase(var_8);

      if(scripts\mp\utility\weapon::carriedpunchcard(var_2, var_9)) {
        if(var_6 >= 8) {
          break;
        }

        var_10 = tablelookuprownum("_encstr_833C29DF78B31EE118E26724E7F74BB8D8BFB6FBC3D90F88778F20E0D74073F7E650FD6F4345E78603DBBB", 0, var_8);

        if(isDefined(var_10) && var_10 >= 0) {
          self setclientomnvar("_encstr_BE991FCB87D192605C2D5169150738DBBA3B5361335B70F87C0319217CEDB08093" + (var_6 + 1), var_10);
          var_6++;
        }
      }
    }

    for(var_7 = var_6; var_7 < 8; var_7++)
      self setclientomnvar("_encstr_BE991FCB87D192605C2D5169150738DBBA3B5361335B70F87C0319217CEDB08093" + (var_7 + 1), -1);
  }
}

setkillcamsupertypeomnvars(var_0) {
  var_1 = scripts\mp\supers::getsuperrefforsuperweapon(var_0);
  var_2 = scripts\mp\supers::getsuperid(var_1);
  setkillcamkilledbyitemomnvars(2, var_2);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

setkillcamkillstreaktypeomnvars(var_0) {
  var_1 = scripts\mp\utility\killstreak::getkillstreakindex(level.killstreakweaponmap[var_0.basename]);

  if(isDefined(self.scorestreakvariantattackerinfo)) {
    var_1 = self.scorestreakvariantattackerinfo.id;
    var_2 = self.scorestreakvariantattackerinfo.rarity;
    self setclientomnvar("_encstr_B1CF1ED55AAF5BA5B1C61B16DAF56D4B361BACC813E5FA5A3A2BADBEE8F20795", 1);
    self setclientomnvar("_encstr_876424BA2DF55BD236631B85B5D7ADD21B36958C262FAFB1DEBDE8AFCE164E2D58378EBED28C", var_1);
    self setclientomnvar("_encstr_8D4722B7B047643A798DD803E0EF6230F2C2D2FA7E6971B3E5A72AD03B985B9B32BBE9B3", var_2 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, var_1);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

setkillcamequipmenttypeomnvars(var_0) {
  var_1 = scripts\mp\equipment::getequipmentreffromweapon(var_0);
  var_2 = scripts\mp\equipment::getequipmenttableinfo(var_1);
  setkillcamkilledbyitemomnvars(3, var_2.id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

setkillcamexecutiontypeomnvars(var_0) {
  if(!isDefined(var_0))
    var_1 = 0;
  else
    var_1 = scripts\cp_mp\execution::execution_getidbyref(var_0);

  setkillcamkilledbyitemomnvars(4, var_1);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

setkillcammisctypeomnvars(var_0) {
  setkillcamkilledbyitemomnvars(5, var_0);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

clearkillcamattachmentomnvars() {
  for(var_0 = 0; var_0 < 8; var_0++)
    self setclientomnvar("_encstr_BE991FCB87D192605C2D5169150738DBBA3B5361335B70F87C0319217CEDB08093" + (var_0 + 1), -1);
}

isnoneweaponinflictor(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && isDefined(var_0.targetname)) {
    switch (var_0.targetname) {
      case "_encstr_A3AC0C1A9D50B2D162C0E3B0C28A":
      case "_encstr_BAE50DE60E739BA638C72068AF47B9":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

isenvironmentalinflictor(var_0) {
  var_1 = 0;

  if(isDefined(var_0.killcament) && isDefined(var_0.classname)) {
    switch (var_0.classname) {
      case "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C":
      case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
      case "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

resetplayeromnvarsonkillcam() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearall(self);
}