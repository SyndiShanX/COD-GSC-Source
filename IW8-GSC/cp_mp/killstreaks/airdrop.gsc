/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\airdrop.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_88C5055208731B")]]();

  level._effect["_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"] = loadfx("_encstr_A58B337BB2F1AFF7101B1F07A36FB7C338C1FF4B4268DE83C893DD8BD998EFE33DC02077D1A3072EF40868AF277F3B6B1B0214A48B");
  level._effect["_encstr_8CF81660FAF2B93BC7F0283EEA27237311E2E870434BCD91"] = loadfx("_encstr_8C2A372330EBC0F92B823923776EC058EC890B98F32D7232E028F02251FE8BA39F97BAC768DB1718B9B2BFD8B7C7D97879ECB213C376231A2B");
  level.carepackagedropnodes = getEntArray("_encstr_8264161B5839AC07586CD6C2ECCAF51939DB1CEB0BE495C2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  initkillstreak();
  initheli();
  initcratedata();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_873B147E08B0443BA0F13FD721D572A8A811FC05A0D8"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_873B147E08B0443BA0F13FD721D572A8A811FC05A0D8")]]();
}

initkillstreak() {}

initheli() {
  level.littlebirds = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_A2DD124ECA9DB4CDD1569CD4B1EDC9CA4ADC33B7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A2DD124ECA9DB4CDD1569CD4B1EDC9CA4ADC33B7")]]();
}

initcratedata() {
  var_0 = spawnStruct();
  var_0.configs = [];
  var_0.crates = [];
  var_0.usablecrates = [];
  level.cratedata = var_0;
  level.cratedata._id_13F28 = pow(getdvarfloat("_encstr_B84229F6966BF72932BF902B777643CBC33DE1FCEFE2179004E370B8AF9F18116A65ED06461A1F19C3AFD0", 2), 2);
  level.mpplayerallowcrateuse = scripts\common\utility::allow_crate_use;
  level.cratedata.mountmantlemodel = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D")]]();

  var_2 = "_encstr_8C07031599";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

  switch (var_2) {
    case "_encstr_839E0CBFD1801B5DB0D34C932998":
    case "_encstr_B6570B78A33FB39B3317E886AB":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_B2061DE7CDF3672EAB40B0AA7083EAF389A6619E53B9CF325B203A1030C95E"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_B2061DE7CDF3672EAB40B0AA7083EAF389A6619E53B9CF325B203A1030C95E")]]();
    case "_encstr_B607038AAB":
      initbattleroyalecratedata();
      initbattleroyaleloadoutcratedata();
      teammateoutlineids();
      teamplunderexfil();
      teammatereviveweaponwaitputaway();
      teamplunderexfilshowviponly();
      teamplacement();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_ABD51F307E8925998D03277F8D4FA10D8F982D5A032D6F31F9C2580315FDCFE4EB")) {
        var_3 = spawnStruct();
        var_3.model = relic_landlocked_do_explosion();
        var_3._id_140A1 = 0.5;
        var_3._id_1409F = 3;
        var_3.usefov = 180;
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_ABD51F307E8925998D03277F8D4FA10D8F982D5A032D6F31F9C2580315FDCFE4EB")]](var_3);
      }
    case "_encstr_B81904B04E6B":
      initarmcratedata();
      initkillstreakcratedata();
      initbattleroyalecratedata();
    case "_encstr_9A7205B39CB919":
    case "_encstr_AAE507E8423F63C163":
      initdropzonekillstreakcratedata();
      break;
    default:
      initkillstreakcratedata();
  }

  initcratedropdata();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9223223995D9A5DCE8AC2741360B2F2B27324E58B559AAC1320BE82B1A0B1BC6980B8DB5"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9223223995D9A5DCE8AC2741360B2F2B27324E58B559AAC1320BE82B1A0B1BC6980B8DB5")]](::_id_13C46);

  thread watchallcrateusability();
}

getleveldata(var_0) {
  var_1 = level.cratedata.configs[var_0];

  if(!isDefined(var_1)) {
    var_1 = getemptyleveldata();
    level.cratedata.configs[var_0] = var_1;
  }

  return var_1;
}

getemptyleveldata() {
  var_0 = spawnStruct();
  var_0.friendlymodel = "_encstr_9BBA2105BB0834A3C7331379F92F63EF4013839BC3287F47574389F2E373776538E121";
  var_0.enemymodel = "_encstr_9A531E68A4212F8B4ED3F7572FB12B1A9A7BAA287BF753FFD237518806EF9AA3";
  var_0.dummymodel = "_encstr_99861EB55AC6A5A32C9CE5BED88593AC1C0B36B6583BB2FA81137D23BA6B6B5E";
  var_0.setplayerbeingrevivedextrainfo = 27.5;
  var_0.mountmantlemodel = getdefaultmountmantlemodel();
  var_0.objweapon = isundefinedweapon();
  var_0.timeout = 90;
  var_0.headiconoffset = 0;
  var_0.headicondrawrange = 10000;
  var_0.headiconnaturalrange = 400;
  var_0.minimapicon = "_encstr_ABC919966CDB73F5DAD237A5B55883AF8DC2C9590E85C6B5B0ECAC";
  var_0.usetag = "_encstr_BA300854E318F1FF9699";
  var_0.userange = 128;
  var_0.breakuserangesqr = 30625;
  var_0.usefov = 360;
  var_0.usepriority = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 3;
  var_0.friendlyuseonly = 0;
  var_0.navobstaclebounds = (30, 10, 64);
  var_0.navobstacleupdatedistsqr = 64;
  var_0.dangerzoneheight = 1000;
  var_0.dangerzoneradius = 128;
  var_0.activatecallback = undefined;
  var_0.deactivatecallback = undefined;
  var_0.capturecallback = undefined;
  var_0.rerollcallback = undefined;
  var_0.destroycallback = undefined;
  var_0.destroyoncapture = 1;
  var_0.onecaptureperplayer = 0;
  var_0.destroyvisualscallback = getdefaultdestroyvisualscallback();
  var_0.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  var_0.capturevisualscallback = getdefaultcapturevisualscallback();
  var_0.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  var_0.capturestring = &"_encstr_84621F6383AC13CAB1815810A15731FBE498E4F318152306E901E1F9A94F7CC77F";
  var_0.rerollstring = &"_encstr_BA5B1DB49262984D2A92150AD2A97D1229E42AD479AA05B2AF29A229F48962";
  var_0.headicon = "_encstr_8AAF25786B27FF68C73F60F068E751414112F8A0123A1143B759FAC8E31FFB1BF21A30107A577B";
  var_0.supportsreroll = 0;
  var_0.supportsownercapture = 1;
  var_0.supportsothercapture = 1;
  return var_0;
}

hasleveldata(var_0) {
  return isDefined(level.cratedata.configs[var_0]);
}

createcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = getleveldata(var_2);

  if(var_10.supportsownercapture) {}

  if(var_10.supportsreroll) {}

  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_11.angles = var_4;

  if(!istrue(var_7) && var_2 != "_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D" || var_2 != "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")) {
      if(var_11[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")]]()) {
        var_11 delete();
        return undefined;
      }
    }
  }

  var_11.owner = var_0;
  var_11.team = var_1;
  var_11.objweapon = var_10.objweapon;
  var_11.cratetype = var_2;
  var_11.useobject = undefined;
  var_11.navobstacle = undefined;
  var_11.headiconid = undefined;
  var_11.minimapid = undefined;
  var_11.dangerzoneid = undefined;
  var_11.navobstacleid = undefined;
  var_11.destination = var_5;
  var_11.headiconactive = 0;
  var_11.minimapiconactive = 0;
  var_11.hasnophysics = istrue(var_6);
  var_11.physicsactivated = 0;
  var_11.isdestroyed = 0;
  var_11.data = var_8;
  var_11.skipminimapicon = var_9;
  var_11.headicon = var_10.headicon;
  var_11.minimapicon = var_10.minimapicon;
  var_11.capturestring = var_10.capturestring;
  var_11.rerollstring = var_10.rerollstring;
  var_11.supportsreroll = var_10.supportsreroll;

  if(level.gametype == "_encstr_AAE507E8423F63C163")
    var_11.validate_station = 1;

  var_11 setModel(var_10.dummymodel);
  var_11 setnodeploy(1);
  var_11 setCanDamage(0);
  var_11 makeunusable();
  var_11 enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");

  if(level.teambased)
    var_11 filteroutplayermarks(var_11.team);
  else
    var_11 filteroutplayermarks(var_11.owner);

  var_12 = undefined;

  if(isDefined(var_10.friendlymodel)) {
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_12.angles = var_4;
    var_12.crate = var_11;
    var_12 setModel(var_10.friendlymodel);
    var_12 linkTo(var_11);
    var_11.childoutlineents = [var_12];
  } else
    var_12 = var_11;

  var_11.friendlymodel = var_12;
  var_13 = undefined;

  if(isDefined(var_10.enemymodel)) {
    if(level.teambased) {} else {}

    var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_13.angles = var_4;
    var_13.cratedata = var_11;
    var_13 setModel(var_10.enemymodel);
    var_13 linkTo(var_11);
  }

  var_11.enemymodel = var_13;

  if(isDefined(var_11.enemymodel))
    var_11 thread watchvisibility();

  var_14 = undefined;

  if(!var_11.hasnophysics) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() != "_encstr_B607038AAB") {
        var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3 + (0, 0, 300));
        var_14 setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");

        if(isDefined(self.scenenode)) {
          if(var_7)
            var_14 thread looselinkTo(var_11, (0, 0, 0));
          else
            var_14 linkTo(var_11);
        }
      }
    }
  }

  if(isDefined(var_11.owner))
    var_11.owner.unset_relic_ammo_drain = 1;

  var_11.killcament = var_14;
  var_15 = var_11 createmountmantlemodel();

  if(!var_15)
    var_11.unresolved_collision_func = ::crateunresolvedcollisioncallback;

  var_11 addtolists();

  if(!scripts\engine\utility::is_equal(level.script, "_encstr_BD230AB50EBE26DAFA1D5D8E"))
    var_11 thread watchcratedestroyearly();

  if(var_11.hasnophysics)
    var_11 activatecratefirsttime();
  else if(var_7)
    var_11 infinite_chopper();

  return var_11;
}

activatecratefirsttime() {
  activatecrate(1);
}

activatecrate(var_0) {
  self notify("_encstr_83030E85D8A35AD958E8953439B01D56");
  self.unset_relic_amped = undefined;

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  self notify("_encstr_AA590EF71A80800D1FEAC370EB0FCADD");

  if(istrue(self.waitforobjectiveactivate))
    self waittill("_encstr_8FCA13B789D45636E8D2672BEB0BD8E82D67B047CA");

  if(istrue(var_0) && self.cratetype != "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D" && !istrue(self.skipminimapicon))
    createminimapicon();

  _createheadicon();
  makecrateusable();
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.activatecallback))
    self thread[[var_1.activatecallback]](var_0);
}

deactivatecrate(var_0) {
  if(istrue(var_0))
    destroyminimapicon();

  _destroyheadicon();
  makecrateunusable();
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.deactivatecallback))
    self thread[[var_1.deactivatecallback]](var_0);
}

capturecrate(var_0) {
  var_1 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.unset_relic_ammo_drain))
    self.owner.unset_relic_ammo_drain = 0;

  if(isDefined(var_1.capturecallback))
    self thread[[var_1.capturecallback]](var_0);

  if(var_1.destroyoncapture) {
    var_2 = 0;

    if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel))
        self thread[[var_1.capturevisualscallback]](self.enemymodel);

      var_2 = var_1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var_2);
  }
}

destroycrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  if(!isDefined(var_0)) {
    if(isDefined(self.scenenode)) {
      if(isDefined(self.animdroptime)) {
        if(gettime() >= self.animdroptime) {
          self.destroyonactivate = 1;
          return;
        } else
          var_0 = 1;
      }
    } else if(istrue(self.physicsactivated)) {
      if(!istrue(self._id_12332)) {
        self.destroyonactivate = 1;
        return;
      }
    }
  }

  self.destroyonactivate = undefined;
  var_1 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.unset_relic_ammo_drain))
    self.owner.unset_relic_ammo_drain = 0;

  if(isDefined(var_1.destroycallback))
    self thread[[var_1.destroycallback]](var_0);

  if(!istrue(var_0)) {
    var_2 = undefined;

    if(!istrue(self.physicsactivated) || !istrue(self._id_12332)) {
      if(isDefined(var_1.destroyvisualscallback)) {
        self thread[[var_1.destroyvisualscallback]](self.friendlymodel);

        if(isDefined(self.enemymodel))
          self thread[[var_1.destroyvisualscallback]](self.enemymodel);

        var_2 = var_1.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel))
        self thread[[var_1.capturevisualscallback]](self.enemymodel);

      var_2 = var_1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var_2);
  } else
    thread lastactivateinstruct();
}

deletecrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;
  level notify("_encstr_82941EBD48D8D4AA27572B17C7D8633D389137C960B08412106F17CBB9F07B64" + self.origin);
  var_1 = isDefined(self.friendlymodel) && self.friendlymodel != self;

  if(isDefined(self.scenenode)) {
    if(isDefined(self.scenenode.crates))
      self.scenenode.crates[self getentitynumber()] = undefined;

    if(isDefined(self.scenenode.crate))
      self.scenenode.crate = undefined;

    self.scenenode = undefined;
  }

  removefromlists(self getentitynumber());
  self disableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");
  self setCanDamage(0);
  self setnonstick(1);

  if(var_1)
    self hide();

  makecrateunusable();

  if(isDefined(self.useobject))
    self.useobject delete();

  destroydangerzone();
  _destroynavobstacle();
  destroymountmantlemodel();
  infilweaponraise();
  destroyminimapicon();
  _destroyheadicon();

  if(isDefined(self.killcament))
    self.killcament delete();

  if(level.script == "_encstr_8CD508CA98A70FAFC01D" && getdvarint("_encstr_AD7D0F43F642C9061B3FB93527E2D3F8ED", 0)) {
    var_2 = spawnfx(level._effect["_encstr_837B17813370FF2358FB0982222FB7F9B88B280D9D71C753FF"], self.origin);
    triggerfx(var_2);
    self setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_84CE0AD08484C848CA4F11D1");
  }

  wait(var_0);

  if(var_1)
    self.friendlymodel delete();

  if(isDefined(self.enemymodel))
    self.enemymodel delete();

  self delete();
}

lastactivateinstruct() {
  var_0 = level.framedurationseconds;

  if(isDefined(self getlinkedscriptableinstance()) && self getscriptablehaspart("_encstr_A1430B84E48B6BF9D91BE83877"))
    self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 1);

  deletecrate(var_0);
}

watchcratedestroyearly() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.timeout)) {}

  watchcratedestroyearlyinternal(var_0.timeout);

  if(istrue(self.nevertimeout)) {
    return;
  }
  thread destroycrate();
}

watchcratedestroyearlyinternal(var_0) {
  if(isDefined(self.owner)) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  else
    level waittill("_encstr_ABA008615A631510C7EA");
}

lb_mg_dmg_factor_tail_rotor() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")]]())
      thread destroycrate();
  }
}

initcratedropdata() {
  var_0 = spawnStruct();
  var_0.helis = [];
  var_1 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_1)) {
    var_0.heliheight = var_1.origin[2] - 750;

    if(issubstr(level.mapname, "_encstr_85D707A9D232B3C051"))
      var_0.heliheight = var_1.origin[2] + 500;
  } else
    var_0.heliheight = 850;

  var_0.heliheightoffset = 128;
  level.cratedropdata = var_0;
  initscriptedhelidropdata();
}

initscriptedhelidropdata() {
  initscriptedhelidropanims();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

initscriptedhelidropanims() {
  level.scr_animtree["_encstr_BAE50DE60E739BA638C72068AF47B9"] = #animtree;
  level.scr_anim["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = % _encstr_96481ACB13F8792333494A31676D873F9FDF9B62A37F2924B81B7860;
  level.scr_animname["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = "_encstr_96481ACB13F8792333494A31676D873F9FDF9B62A37F2924B81B7860";
  level.scr_animtree["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"] = #animtree;
  level.scr_anim["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = % _encstr_9AB41FB607BE8D85E42B0EC21BDA16CE95AF83C2390B1B0DEA4756BE998D2FD2B9;
  level.scr_animname["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = "_encstr_9AB41FB607BE8D85E42B0EC21BDA16CE95AF83C2390B1B0DEA4756BE998D2FD2B9";
  initscriptedhelidropvehicleanims();
  teamplunderexfilvipuav();
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

initscriptedhelidropvehicleanims() {
  level.scr_animtree["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"] = #animtree;
  level.scr_anim["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = % _encstr_A69E1C75CFF7F3D6C3874F2F779A41B725F69BFA9B2023AA1749384A2D70;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

teamplunderexfilvipuav() {
  level.scr_anim["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_960811A04022EFCFA3812AB63F6B9FBBE36C3A"] = % _encstr_A21920D60EEB1B0BE4CA07B01B6DC2ECCAEB6C6D1CEC7D33C65E4BB9D726C09A6006;
  level.scr_animname["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_960811A04022EFCFA3812AB63F6B9FBBE36C3A"] = "_encstr_A21920D60EEB1B0BE4CA07B01B6DC2ECCAEB6C6D1CEC7D33C65E4BB9D726C09A6006";
  level.scr_anim["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_B4D9109636D7072B1BD9BBFB404B0F8AA345"] = % _encstr_8BE61F0B132166D092BFE3D9266318AC7A478F8FAB0A2090D490C830C107E27F87;
  level.scr_animname["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_B4D9109636D7072B1BD9BBFB404B0F8AA345"] = "_encstr_8BE61F0B132166D092BFE3D9266318AC7A478F8FAB0A2090D490C830C107E27F87";
  level.scr_anim["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_B6D910989C3613CC06D74693DBE07D63ED77"] = % _encstr_85C51FF8532FFE40DA25D9F34BC418B46F19B1A0BB3738B0752193F54F3A5AA762;
  level.scr_animname["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_B6D910989C3613CC06D74693DBE07D63ED77"] = "_encstr_85C51FF8532FFE40DA25D9F34BC418B46F19B1A0BB3738B0752193F54F3A5AA762";
  level.scr_anim["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_960811A04022EFCFA3812AB63F6B9FBBE36C3A"] = % _encstr_8EED251BB069A0077BFAABB1A227CF483F07A9FB5A4E18DB0F83017E1AD3FB6095AFB3D1A562CA;
  level.scr_animname["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_960811A04022EFCFA3812AB63F6B9FBBE36C3A"] = "_encstr_8EED251BB069A0077BFAABB1A227CF483F07A9FB5A4E18DB0F83017E1AD3FB6095AFB3D1A562CA";
  level.scr_anim["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_B4D9109636D7072B1BD9BBFB404B0F8AA345"] = % _encstr_AF6024B26BC8E736E0B3F0E957C0FE2F0D26DBFAB3BFAF2CE0891DCF65A0805F20DE272793AF;
  level.scr_animname["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_B4D9109636D7072B1BD9BBFB404B0F8AA345"] = "_encstr_AF6024B26BC8E736E0B3F0E957C0FE2F0D26DBFAB3BFAF2CE0891DCF65A0805F20DE272793AF";
  level.scr_anim["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_B6D910989C3613CC06D74693DBE07D63ED77"] = % _encstr_978124B60EBEB10BE456C10B365B58B3957D1C584E581B43EA1D95EB33C6F22DE6D7990C030C;
  level.scr_animname["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_B6D910989C3613CC06D74693DBE07D63ED77"] = "_encstr_978124B60EBEB10BE456C10B365B58B3957D1C584E581B43EA1D95EB33C6F22DE6D7990C030C";
}

placecrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return createcrate(var_0, var_1, var_2, var_3, var_4, undefined, 1, 0, var_5, var_6);
}

dropcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_5)) {
    var_8 = getcratedropcaststart(var_3, 0);
    var_5 = getcratedropdestination(var_8, getcratedropcastend(var_8, 0));
  }

  return createcrate(var_0, var_1, var_2, var_3, var_4, var_5, undefined, 1, var_6, var_7);
}

dropcratefrommanualheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_3 = getcratedropcaststart(var_3, 1);
  var_9 = var_3[2];

  if(!isDefined(var_7)) {
    var_7 = getcratedropdestination(var_3, getcratedropcastend(var_3, 1));

    if(!isDefined(var_7))
      return undefined;
  }

  var_10 = spawnStruct();
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.hasowner = isDefined(var_0);
  var_4 = var_4 * (0, 1, 0);
  var_11 = var_3 + -1 * anglesToForward(var_4) * var_5;
  var_10.dropposition = var_3;
  var_10.exitposition = var_3 + anglesToForward(var_4) * var_6;
  var_12 = undefined;

  if(isDefined(var_8))
    var_12 = var_8.vehicleisreserved;

  var_13 = createheli(var_0, var_1, var_11, var_4, var_12);
  var_13.dropstruct = var_10;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB")
      var_13 vehicle_setspeed(100, 60);
    else
      var_13 vehicle_setspeed(200, 100);
  }

  var_13 setmaxpitchroll(15, 15);
  var_13 setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_930B07BB1B6B3854FF", 1);
  var_10.heli = var_13;
  var_14 = createcrate(var_0, var_1, var_2, var_11, var_13.angles, var_7, undefined, 0, var_8);
  var_14.dropstruct = var_10;
  var_14 linkTo(var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (16, 0, -156), (0, 0, 0));
  var_10.crate = var_14;
  var_10 thread watchdropcratefrommanualheli();
  return var_10;
}

watchdropcratefrommanualheli() {
  self endon("_encstr_AD75063D571AE108");
  watchdropcratefrommanualheliinternal();

  if(isDefined(self.crate))
    self.crate thread destroycrate();

  if(isDefined(self.heli))
    self.heli thread destroyheli();
}

watchdropcratefrommanualheliinternal() {
  if(self.hasowner) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.heli setvehgoalpos(self.dropposition, 1);
  self.heli scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 2);

  if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
    thread docratedropfrommanualheli();
    return;
  }

  self.heli setyawspeed(40, 20, 20, 0.3);

  if(distancesquared(self.heli.origin, self.dropposition) > 5184) {
    self.heli scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8B7205D9ED5958");

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      thread docratedropfrommanualheli();
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.25);

    if(isDefined(self.crate) && !istrue(self.crate.isdestroyed))
      thread docratedropfrommanualheli();

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }
    self.heli scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.5);

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }
    if(distancesquared(self.heli.origin, self.exitposition) > 5184) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB")
          self.heli vehicle_setspeed(100, 60);
        else
          self.heli vehicle_setspeed(150, 50);
      }

      self.heli setvehgoalpos(self.exitposition, 1);
      self.heli scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8B7205D9ED5958");
    }
  }
}

docratedropfrommanualheli() {
  var_0 = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  var_0 infinite_chopper();
}

createcrateforscripteddrop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = createcrate(var_0, var_1, var_2, var_8.origin, var_8.angles, var_3, var_4, var_5, var_6);

  if(!isDefined(var_11))
    return undefined;

  var_11.scenenode = var_8;
  var_11.streakinfo = var_7;

  if(!isDefined(var_8.crates))
    var_8.crates = [];

  var_8.crates[var_11 getentitynumber()] = var_11;
  var_11.friendlymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);

  if(isDefined(var_11.enemymodel))
    var_11.enemymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);

  var_11.animname = var_9;
  var_11 scripts\common\anim::setanimtree();
  var_12 = level.scr_anim[var_9][var_10];
  var_13 = getanimlength(var_12) * 1000;
  var_11.animdroptime = gettime() + getnotetracktimes(var_12, "_encstr_865911769EE30BB3D93FF0A807F56EB14B8577")[0] * var_13;
  var_11.animstoptrailtime = gettime() + getnotetracktimes(var_12, "_encstr_8D9916AE06039019B1FEF07BEF65D9FBB5B929D23FCF200D")[0] * var_13;
  var_11.animendtime = gettime() + var_13;
  var_8.latestanimendtime = scripts\engine\utility::ter_op(var_11.animendtime > var_8.latestanimendtime, var_11.animendtime, var_8.latestanimendtime);
  return var_11;
}

createchuteforscripteddrop(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.chutes))
    var_0.chutes = [];

  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_4.angles = var_0.origin;
  var_4.scenenode = var_0;
  var_4.crate = var_1;
  var_4.crateanimdroptime = var_1.animdroptime;
  var_0.chutes[var_4 getentitynumber()] = var_4;
  var_4 setModel("_encstr_AB33235D2732AB41AD9C403EC586D0503A9FCDF38B4ADED8F9776936EA71B8F752234B2977");
  var_4 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  var_4.animname = var_2;
  var_4 scripts\common\anim::setanimtree();
  var_5 = level.scr_anim[var_2][var_3];
  var_6 = getanimlength(var_5) * 1000;
  var_4.animendtime = gettime() + getanimlength(level.scr_anim[var_2][var_3]) * 1000;
  var_4.animunhidetime = gettime() + getnotetracktimes(var_5, "_encstr_950A0D6CD0EAD1B2FA5D3743A519AC")[0] * var_6;
  var_4.animendtime = gettime() + var_6;
  var_0.latestanimendtime = scripts\engine\utility::ter_op(var_4.animendtime > var_0.latestanimendtime, var_4.animendtime, var_0.latestanimendtime);
  return var_4;
}

destroychute() {
  if(isDefined(self.scenenode))
    self.scenenode.chutes[self getentitynumber()] = undefined;

  self delete();
}

dropcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]())
      return undefined;
  }

  var_8 = getcratedropcaststart(var_3, 1);
  var_9 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = getcratedropdestination(var_8, getcratedropcastend(var_8, 1));

    if(!isDefined(var_5))
      return undefined;
  }

  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
  var_10.angles = var_9;
  var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.hasowner = isDefined(var_0);
  var_11 = undefined;

  if(isDefined(var_6))
    var_11 = var_6.vehicleisreserved;

  var_12 = createheli(var_0, var_1, var_8, var_9, var_11, var_7);

  if(!isDefined(var_12)) {
    var_10 delete();
    return undefined;
  }

  var_12.scenenode = var_12;
  var_12 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  var_12.animname = "_encstr_88F312368593CABEC1B08DB6583BACD734591B4B";
  var_10.heli = var_12;
  var_10.heliendtime = gettime() + getanimlength(level.scr_anim["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"]) * 1000;
  var_10.latestanimendtime = var_10.heliendtime;
  var_13 = createcrateforscripteddrop(var_0, var_1, var_2, var_5, undefined, 0, var_6, var_7, var_10, "_encstr_BAE50DE60E739BA638C72068AF47B9", "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  if(!isDefined(var_13))
    return undefined;

  var_14 = createchuteforscripteddrop(var_10, var_13, "_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21", "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  if(!isDefined(var_14))
    return undefined;

  var_14 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  var_10 thread watchdropcratefromscriptedheli();
  return var_10;
}

watchdropcratefromscriptedheli() {
  self endon("_encstr_AD75063D571AE108");
  scripts\common\anim::anim_first_frame_solo(self.heli, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  foreach(var_1 in self.crates)
  scripts\common\anim::anim_first_frame_solo(var_1, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  foreach(var_4 in self.chutes)
  scripts\common\anim::anim_first_frame_solo(var_4, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli))
    self.heli thread destroyheli();

  foreach(var_1 in self.crates) {
    if(isDefined(var_1))
      var_1 thread destroycrate();
  }

  foreach(var_4 in self.chutes) {
    if(isDefined(var_4))
      var_4 thread destroychute();
  }

  self delete();
}

watchdropcratefromscriptedheliinternal() {
  var_0 = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team)
              self.ownerjoinedteam = 1;
          }
        } else
          self.ownerdisconnected = 1;
      }
    }

    if(!isDefined(var_0))
      var_0 = 1;
    else if(var_0) {
      if(isDefined(self.heli)) {
        self.heli setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
        self.heli setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_930B07BB1B6B3854FF", 1);
        thread scripts\common\anim::anim_single_solo(self.heli, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
      }

      foreach(var_2 in self.crates) {
        if(isDefined(var_2)) {
          var_2.friendlymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

          if(isDefined(var_2.enemymodel))
            var_2.enemymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

          thread scripts\common\anim::anim_single_solo(var_2, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
        }
      }

      foreach(var_5 in self.chutes) {
        if(isDefined(var_5))
          thread scripts\common\anim::anim_single_solo(var_5, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
      }

      var_0 = 0;
    } else {
      var_7 = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);

      if(isDefined(self.heli)) {
        if(var_7 || gettime() > self.heliendtime)
          self.heli destroyheli();
      }

      foreach(var_2 in self.crates) {
        if(isDefined(var_2)) {
          if(gettime() > var_2.animendtime) {
            if(var_7)
              var_2 thread destroycrate();

            thread docratedropfromscripted(var_2);
            continue;
          }

          if(gettime() > var_2.animdroptime) {
            if(gettime() > var_2.animstoptrailtime) {
              var_2.friendlymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 1);

              if(isDefined(var_2.enemymodel))
                var_2.enemymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 1);
            } else {
              var_2.friendlymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 1);

              if(isDefined(var_2.enemymodel))
                var_2.enemymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 1);
            }

            if(var_7)
              var_2 thread destroycrate();

            continue;
          }

          if(var_7) {
            var_2 thread destroycrate();
            continue;
          }

          if(!isDefined(self.heli) || istrue(self.heli.isdestroyed))
            thread docratedropfromscripted(var_2);
        }
      }

      foreach(var_5 in self.chutes) {
        if(isDefined(var_5)) {
          if(gettime() > var_5.animendtime) {
            var_5 thread destroychute();
            continue;
          }

          if(gettime() <= var_5.crateanimdroptime && (!isDefined(var_5.crate) || !isDefined(self.crates[var_5.crate getentitynumber()]))) {
            var_5 thread destroychute();
            continue;
          }

          if(gettime() > var_5.animunhidetime)
            var_5 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
        }
      }
    }

    waitframe();
  }
}

docratedropfromscripted(var_0) {
  var_0.scenenode = undefined;
  self.crates[var_0 getentitynumber()] = undefined;
  var_0.animname = undefined;
  var_0.animendtime = undefined;
  var_0.animdroptime = undefined;
  var_0.animstoptrailtime = undefined;
  var_0 notify("_encstr_AC7F0EF01AA4DBEE937920AB5B939181");
  var_0 stopanimScripted();
  var_0 infinite_chopper();
}

getcratedropcaststart(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1))
    var_2 = var_0 * (1, 1, 0) + (0, 0, getscriptedhelidropheight());
  else
    var_2 = var_0 + (0, 0, 25);

  return var_2;
}

getcratedropcastend(var_0, var_1) {
  return var_0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var_1), 8000, 8000));
}

getcratedropdestination(var_0, var_1) {
  var_2 = undefined;
  var_3 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_4 = getcratedropignorelist();
  var_5 = physics_raycast(var_0, var_1, var_3, var_4, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_5) && var_5.size > 0)
    var_2 = var_5[0]["_encstr_BD260953AA97E3F014279D"];

  return var_2;
}

getcratedropignorelist() {
  if(isDefined(level.cratedata.helis) && isDefined(level.cratedata.ac130s))
    return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedropdata.ac130s, level.cratedata.crates]);
  else
    return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
}

createheli(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = "_encstr_8E6717B31078F217FA1874BF7EEBAA59C9920B76FC7D014D98";

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_7 = "_encstr_A1901CCE05B8527973E85A618053EA17D07E325124E087BF1320E37918B9";

  if(istrue(var_4))
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(isDefined(var_0))
    var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_2, var_3, "_encstr_82930F3B09E0FF8A23751B4BA7579135C8", var_7);
  else
    var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, "_encstr_82930F3B09E0FF8A23751B4BA7579135C8", var_7);

  if(!isDefined(var_6))
    return undefined;

  if(!isDefined(var_1))
    var_1 = "_encstr_A7A408B9CA5D1D4E2C63";

  if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
    var_6 setvehicleteam(var_1);

  var_6.owner = var_0;
  var_6.team = var_1;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(isDefined(level.heliconfigs)) {
    var_11 = level.heliconfigs["_encstr_BA67082278D537E3C827"];
    var_6.health = var_11.maxhealth;
    var_8 = var_11.callout;
    var_9 = var_11.vodestroyed;
    var_10 = var_11.scorepopup;
  } else
    var_6.health = 999999;

  var_6.helitype = "_encstr_BA67082278D537E3C827";

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]]("_encstr_BA67082278D537E3C827", "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 0);

    if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
      var_6 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]]("_encstr_82930F3B09E0FF8A23751B4BA7579135C8", var_10, var_9, undefined, var_8);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]]("_encstr_82930F3B09E0FF8A23751B4BA7579135C8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]]("_encstr_82930F3B09E0FF8A23751B4BA7579135C8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]]("_encstr_82930F3B09E0FF8A23751B4BA7579135C8", ::destroyhelicallback);

  var_6 setCanDamage(0);
  var_6 thread watchhelidestroyearly();
  return var_6;
}

watchhelidestroyearly() {
  self endon("_encstr_AD75063D571AE108");
  watchhelidestroyearlyinternal();
  thread destroyheli();
}

watchhelidestroyearlyinternal() {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner)) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_ABA008615A631510C7EA");
}

destroyheli() {
  thread deleteheli(0);
}

deleteheli(var_0) {
  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

destroyhelicallback(var_0) {
  destroyheli();
}

getscriptedhelidropheightbase() {
  return level.cratedropdata.heliheight;
}

getscriptedhelidropheight() {
  return getscriptedhelidropheightbase() + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

addhelidroppingcratetolist(var_0) {
  var_1 = var_0 getentitynumber();
  level.cratedropdata.helis[var_1] = var_0;
}

removehelidroppingcratefromlist(var_0) {
  level.cratedropdata.helis[var_0] = undefined;
}

makecrateusable() {
  var_0 = getleveldata(self.cratetype);

  if(istrue(var_0.hasnointeraction)) {
    return;
  }
  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(var_0.supportsownercapture && var_0.supportsothercapture) {
    thread watchcrateuse(1);
    var_1 = self.useobject;

    if(!isDefined(var_1)) {
      var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_0.usetag));
      var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_1 linkTo(self);
      var_1 makeunusable();
      self.useobject = var_1;
    }

    thread watchcrateuse(2, var_1);
  } else if(var_0.supportsownercapture)
    thread watchcrateuse(1);
  else
    thread watchcrateuse(2);
}

watchcrateuse(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A32412C07AC7D579C239B98315AD80A697227849");

  if(isDefined(var_1))
    var_1 endon("_encstr_AD75063D571AE108");

  if(var_0 == 1) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    self.owner.unset_relic_ammo_drain = 1;
  }

  var_2 = getleveldata(self.cratetype);
  var_3 = gettriggerobject(var_1);
  var_3.usetype = var_0;
  var_3 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  var_3 sethinttag(var_2.usetag);
  var_3 sethintdisplayrange(var_2.userange);
  var_3 sethintdisplayfov(var_2.usefov);
  var_3 setuserange(var_2.userange);
  var_3 setusefov(var_2.usefov);
  var_3 setusepriority(var_2.usepriority);
  var_3 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");

  if(var_3.usetype == 1 && self.supportsreroll)
    var_3 setHintString(self.rerollstring);
  else
    var_3 setHintString(self.capturestring);

  var_3.userate = 1;
  var_3.curprogress = 0;

  if(isDefined(var_3._id_140A0))
    var_3.usetime = var_3._id_140A0;
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_3.usetime = scripts\engine\utility::ter_op(var_0 == 1, var_2.ownerusetime, var_2.otherusetime);

  var_3.inuse = 0;
  var_3.playerusing = undefined;

  for(;;) {
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(level.gametype == "_encstr_B607038AAB") {
      if(self.cratetype == "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1D313E8CA2CDA49BAB3ECD4858794AC161B86B219")) {
          var_5 = var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1D313E8CA2CDA49BAB3ECD4858794AC161B86B219")]]();

          if(var_5) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
              var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8B2922B48CAC814EA9BB7383272188796D97BD8E63CD910931EF73B95F19F579D3BC6565");

            continue;
          }
        }
      }

      if(istrue(var_4.isjuggernaut) && !var_4 vehicle_isfriendlytoplayer(self.cratetype)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

        continue;
      }
    }

    if(canstartusingcrate(var_4, var_1)) {
      startusingcrate(var_4, var_1);
      var_4.unset_relic_ammo_drain = 1;
      var_3.playerusing = var_4;
      var_6 = watchcrateuseinternal(var_4, var_1);

      if(isDefined(var_4))
        stopusingcrate(var_4, var_1);

      var_3.playerusing = undefined;

      if(istrue(var_6)) {
        if(isDefined(var_4))
          var_4.unset_relic_ammo_drain = 0;

        if(var_2.onecaptureperplayer && self.cratetype != "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D") {
          if(!isDefined(self.playerscaptured))
            self.playerscaptured = [];

          self.playerscaptured[var_4 getentitynumber()] = var_4;
        }

        if(!isDefined(self.targetname) || self.targetname != "_encstr_858B18931BFFCFBB70F0914FC2BBCA825BF63BFE2C2E2EE76767")
          thread capturecrate(var_4);
      }
    }
  }
}

watchcrateuseinternal(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype != 1) {
    var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
    var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
    var_0 endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  var_2.id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
  var_2.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);
  playusesound(var_0, var_1);

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate(var_0, var_1) && var_0 useButtonPressed()) {
    var_2.curprogress = var_2.curprogress + level.framedurationseconds * var_2.userate;

    if(var_2.curprogress >= var_2.usetime) {
      var_2.curprogress = 0.0;
      return 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B")]](var_2, 1);

    waitframe();
  }

  var_2.curprogress = 0.0;
  return 0;
}

makecrateunusable() {
  self notify("_encstr_A32412C07AC7D579C239B98315AD80A697227849");
  level.cratedata.usablecrates[self getentitynumber()] = undefined;
  self.isusable = 0;

  if(isDefined(self.playerusing))
    stopusingcrate(self.playerusing);

  self.playerusing = undefined;
  self makeunusable();

  if(isDefined(self.useobject)) {
    if(isDefined(self.useobject.playerusing))
      stopusingcrate(self.useobject.playerusing, self.useobject);

    self.useobject makeunusable();
  }
}

startusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_9B3B0DAAC3EA57FDE20F2050271BF1", 0);
  } else {
    var_4 = getdvarint("_encstr_A5CD173B8E2AA1EFF2A3F99D3F8B3808C3E72633B7619090DA", 1);

    if(var_4)
      var_0 thread br_bunker_alt();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_828C09996A99584D51C7DB", 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B")]](var_2, 0);
}

br_bunker_alt() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\utility\weapon_utility::_id_12EB2();
  var_0 = getcompleteweaponname("_encstr_B1FD1078CA47B0A67257F7DDC70BE5991D62");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  thread br_checkforlaststandfinish(var_0);
  self switchtoweapon(var_0);
}

br_checkforlaststandfinish(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A9E70E21182973F56F70B357DFEFB89B");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

    if(isDefined(self.lastdroppableweaponobj)) {
      var_1 = scripts\cp_mp\utility\weapon_utility::_id_12CC7(self.lastdroppableweaponobj);
      self switchtoweapon(var_1);
      thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_1);
    }
  }
}

stopusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_9B3B0DAAC3EA57FDE20F2050271BF1", 1);
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_828C09996A99584D51C7DB", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B")]](var_2, 0);

  stopusesound(var_0, var_1);
  var_0 notify("_encstr_A9E70E21182973F56F70B357DFEFB89B");
}

canstartusingcrate(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_AC0B185773E206F0A1DDA5F9028D094E1AA383DFDF685688ECF7")) {
    if(!var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AC0B185773E206F0A1DDA5F9028D094E1AA383DFDF685688ECF7")]]())
      return 0;
  }

  if(!var_0 scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 isonladder())
    return 0;

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()]))
    return 0;

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0))
      return 0;

    if(var_0.squadindex != self.squadindex || var_0.team != self.team)
      return 0;
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0))
      return 0;

    if(var_0.team != self.team)
      return 0;
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() != "_encstr_9A7205B39CB919" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D")]](self.cratetype))
          return 0;
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB")]](self.cratetype))
        return 0;
    }
  }

  if(!self.isusable)
    return 0;

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    return canstartusingcratetriggerobject(var_0, var_1);

  if(level.gametype == "_encstr_B607038AAB" && var_0 isskydiving())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  return 1;
}

canstartusingcratetriggerobject(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(isDefined(var_2.playerusing) && var_2.playerusing != var_0)
    return 0;

  if(var_2.usetype == 1 && (!isDefined(self.owner) || var_0 != self.owner))
    return 0;

  if(var_2.usetype == 2 && (isDefined(self.owner) && var_0 == self.owner))
    return 0;

  if(level.teambased && isDefined(self.team) && self.team != "_encstr_A7A408B9CA5D1D4E2C63") {
    var_3 = getleveldata(self.cratetype);

    if(var_3.friendlyuseonly && var_0.team != self.team)
      return 0;
  }

  return 1;
}

cankeepusingcrate(var_0, var_1) {
  if(!scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 meleeButtonPressed())
    return 0;

  if(var_0 isinexecutionvictim())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  var_2 = getleveldata(self.cratetype);

  if(isDefined(var_2.breakuserangesqr) && distancesquared(var_0.origin, gettriggerobject(var_1).origin) >= var_2.breakuserangesqr)
    return 0;

  if(!self.isusable)
    return 0;

  return 1;
}

_id_11A9C(var_0, var_1) {
  var_0 enableplayeruse(var_1);

  if(isDefined(var_0.useobject))
    var_0.useobject enableplayeruse(var_1);

  if(!var_0 canstartusingcrate(var_1, var_0.useobject, 0)) {
    var_0 disableplayeruse(var_1);

    if(isDefined(var_0.useobject))
      var_0.useobject disableplayeruse(var_1);
  } else {
    if(!var_0 canstartusingcratetriggerobject(var_1, undefined))
      var_0 disableplayeruse(var_1);

    if(isDefined(var_0.useobject)) {
      if(!var_0 canstartusingcratetriggerobject(var_1, var_0.useobject))
        var_0.useobject disableplayeruse(var_1);
    }
  }
}

_id_14485() {
  for(;;) {
    foreach(var_1 in level.cratedata.usablecrates) {
      if(!isDefined(var_1)) {
        thread scripts\engine\utility::error("_encstr_A30B278F67F0D59A505B0FE66A7A2D122ECFD79E4EB5E96DF11B71C91133C8988FBD2B41D18C1AC7D0");
        continue;
      }

      var_1 makeusable();
      var_1 istacmapactive();

      if(isDefined(var_1.useobject)) {
        var_1.useobject makeusable();
        var_1.useobject istacmapactive();
      }

      var_2 = level.players;

      if(level.teambased && isDefined(var_1.team) && var_1.team != "_encstr_A7A408B9CA5D1D4E2C63") {
        var_3 = getleveldata(var_1.cratetype);

        if(var_3.friendlyuseonly)
          var_2 = level.teamdata[var_1.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];
      }

      foreach(var_5 in var_2) {
        var_6 = distancesquared(var_1.origin, var_5.origin) < 57600.0;

        if(var_6)
          _id_11A9C(var_1, var_5);
      }
    }

    wait 0.1;
  }
}

watchallcrateusability() {
  if(getdvarint("_encstr_855F1FCD8DC9BE2C5AC9464EB7C1BE33166E1DBE5DDC85268DACAF6C4E8547CA6E", 0)) {
    thread _id_14485();
    return;
  }

  for(;;) {
    foreach(var_1 in level.cratedata.usablecrates) {
      if(!isDefined(var_1)) {
        thread scripts\engine\utility::error("_encstr_A30B278F67F0D59A505B0FE66A7A2D122ECFD79E4EB5E96DF11B71C91133C8988FBD2B41D18C1AC7D0");
        continue;
      }

      var_1 makeusable();

      if(isDefined(var_1.useobject))
        var_1.useobject makeusable();

      foreach(var_3 in level.players)
      _id_11A9C(var_1, var_3);
    }

    wait 0.1;
  }
}

playusesound(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype == 1)
    var_0 playLoopSound("_encstr_85221A12407F663FFB1DF7D027E12F2EA770B9CA90C55F3B3676D1E8");
  else
    var_0 playLoopSound("_encstr_82AC1E0553A13B4276833FFBF396AA713859314D28C0FF7ACCBDDFFBA74EF2B8");
}

stopusesound(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype == 1)
    var_0 stoploopsound("_encstr_85221A12407F663FFB1DF7D027E12F2EA770B9CA90C55F3B3676D1E8");
  else
    var_0 stoploopsound("_encstr_82AC1E0553A13B4276833FFBF396AA713859314D28C0FF7ACCBDDFFBA74EF2B8");

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
    var_0 playsoundonmovingent("_encstr_8312197DD8A0F7A7DB8F1E4BBBD6339178BFF142F9514E0347FFBA");
}

gettriggerobject(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0), var_0, self);
}

infinite_chopper(var_0, var_1) {
  var_2 = getleveldata(self.cratetype);

  if(isDefined(var_2.ingame))
    self thread[[var_2.ingame]]();

  if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  self unlink();
  self physicslaunchserver(var_0, var_1);
  var_3 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_3, (0, 0, -1));
  self.physicsactivated = 1;
  createdangerzone();
  thread _id_11CFE();
  thread _id_11D0B();
  thread _id_11D17();
}

infilweaponraise() {
  if(!istrue(self.physicsactivated)) {
    return;
  }
  self.physicsactivated = undefined;
  self._id_12332 = undefined;
  self physicsstopserver();
  headicon_z_offset();
  _id_11D0C();
  _id_11D18();
  generatecodestoshow();
}

_id_11CFE() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_937320E83FEE509182F2C7640F6B83D94D43209857BBE8590BD658656B23C1C1A427");
  self endon("_encstr_937320E83FEE509182F2C7640F6B83D94D43209857BBE8590BD658656B23C1C1A427");
  var_0 = 0.1;
  thread _id_11CFD(var_0, 8);
  var_1 = 0;
  var_2 = 0;
  self.unset_relic_amped = 1;
  var_3 = undefined;
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0"))
    var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0");

  for(;;) {
    var_5 = registeronplayerjointeamnospectatorcallback();
    var_6 = registeronplayerdisconnect();

    if(isDefined(var_5) && isDefined(var_6)) {
      if(var_5 <= 5.0 && var_6 <= 1.0) {
        var_1++;
        var_2 = 0;

        if(var_1 == 6) {
          self._id_12332 = 1;
          var_3 = self.origin;
          thread activatecrate(self.unset_relic_amped);

          if(isDefined(var_4) && [[var_4]]()) {
            _id_11D0C();

            if(isDefined(self.killcament))
              self.killcament delete();
          }

          var_0 = 0.1;
          thread _id_11CFD(var_0, 3, 3);
          lb_mg_dmg_factor_tail_rotor();
        }
      } else {
        if(isDefined(var_3)) {
          if(distancesquared(self.origin, var_3) <= 2500) {
            wait(var_0);
            continue;
          }
        }

        var_2++;
        var_1 = 0;

        if(var_2 == 1) {
          self._id_12332 = undefined;
          thread deactivatecrate();
          var_0 = 0.1;
          thread _id_11CFD(var_0, 8);
        }
      }

      wait(var_0);
      continue;
    }

    waitframe();
  }
}

_id_11CFD(var_0, var_1, var_2) {
  headicon_z_offset();
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE8F19A6A19A2FED5148B6CF8201191261EB32DB88BAA4E3121878");
  self.x1ops2 = [];
  self.buildrespawnlist = [];
  self._id_1428A = 0;
  self._id_14285 = 0;
  self._id_14287 = var_1;

  if(isDefined(var_2)) {
    var_2 = int(clamp(var_2, 0, var_1));

    if(var_2 > 0) {
      for(var_3 = 0; var_3 < var_2; var_3++) {
        self.x1ops2[self._id_1428A + var_3] = 0;
        self.buildrespawnlist[self._id_1428A + var_3] = 0;
      }
    }
  }

  for(;;) {
    var_4 = self physics_getbodyid(0);
    var_5 = physics_getbodylinvel(var_4);
    var_6 = physics_getbodyangvel(var_4);
    self.x1ops2[self._id_14285] = length(var_5);
    self.buildrespawnlist[self._id_14285] = length(var_6);
    self._id_14285++;
    var_7 = self._id_14285 - self._id_1428A;

    if(var_7 > var_1) {
      var_8 = scripts\engine\utility::mod(var_7, var_1);

      for(var_3 = 0; var_3 < var_8; var_3++) {
        self.x1ops2[self._id_1428A + var_3] = undefined;
        self.buildrespawnlist[self._id_1428A + var_3] = undefined;
      }

      self._id_1428A = self._id_1428A + var_8;
    }

    self.checkrequiredteamstreamcount = undefined;
    self.checkreload = undefined;
    wait(var_0);
  }
}

registeronplayerjointeamnospectatorcallback() {
  if(isDefined(self.checkrequiredteamstreamcount))
    return self.checkrequiredteamstreamcount;

  if(!isDefined(self.x1ops2))
    return undefined;

  if(self._id_14285 - self._id_1428A < self._id_14287)
    return undefined;

  forcestuckdamageclear();
  return self.checkrequiredteamstreamcount;
}

registeronplayerdisconnect() {
  if(isDefined(self.checkreload))
    return self.checkreload;

  if(!isDefined(self.buildrespawnlist))
    return undefined;

  if(self._id_14285 - self._id_1428A < self._id_14287)
    return undefined;

  forcestuckdamageclear();
  return self.checkreload;
}

forcestuckdamageclear() {
  var_0 = 0;
  var_1 = 0;

  for(var_2 = self._id_1428A; var_2 < self._id_14285; var_2++) {
    var_0 = var_0 + self.x1ops2[var_2];
    var_1 = var_1 + self.buildrespawnlist[var_2];
  }

  self.checkrequiredteamstreamcount = var_0 / self._id_14287;
  self.checkreload = var_1 / self._id_14287;
}

headicon_z_offset() {
  self notify("_encstr_BE8F19A6A19A2FED5148B6CF8201191261EB32DB88BAA4E3121878");
  self.x1ops2 = undefined;
  self.buildrespawnlist = undefined;
  self._id_14287 = undefined;
  self._id_1428A = undefined;
  self._id_14285 = undefined;
  self.checkrequiredteamstreamcount = undefined;
  self.checkreload = undefined;
}

_id_11D0B(var_0) {
  _id_11D0C();
  self endon("_encstr_927011315D6253F317BB21089B3129D178853D");
  self._id_11D0E = 1;
  self playLoopSound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
  self physics_registerforcollisioncallback();
  _id_11D0D(var_0);

  if(isDefined(self))
    thread _id_11D0C();
}

_id_11D0D(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    wait(var_0);

  var_1 = 0;

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9)) {
      if(isDefined(var_9.classname) && var_9.classname == "_encstr_85BB1A5B708D3CA3D3E732248DDE8FC361F9C2629807740F48C06871")
        thread br_badcircleareas(var_9);

      getkioskyawoffsetoverride(var_9);
    }

    if(isDefined(var_9) && start_chants_on_movement(var_9)) {
      if(var_9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks())
        var_9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
    }

    if(gettime() - var_1 >= 200) {
      var_1 = gettime();
      var_10 = physics_getsurfacetypefromflags(var_5);
      var_11 = getsubstr(var_10["_encstr_84BA05A8CA852B"], 9);

      if(var_11 == "_encstr_A1140EEA6EB2E4EB3A9593C90BB4734C")
        var_11 = "_encstr_AA9D0F9543A77B872312D8C04A3CAD964E";

      if(var_11 == "_encstr_9B140E63868B6317C37893AB6058EEDF")
        var_11 = "_encstr_8A9D0F4F7F25B3CF2829E2EA412836B9A5";

      _id_1273B(var_6, var_7, var_8, var_11);
    }
  }
}

getkioskyawoffsetoverride(var_0) {
  if(isDefined(var_0.script_noteworthy) && isstartstr(var_0.script_noteworthy, "_encstr_836007B99B42E3283F") && !isDefined(self getlinkedparent())) {
    if(isDefined(self._id_13CC8)) {
      if(self._id_13CC8 == var_0)
        return;
      else
        generatecodestoshow();
    }

    self._id_13CC8 = var_0;
    self._id_13CC7 = 4;
    thread getknivesoutsetting(var_0);
  }
}

getknivesoutsetting(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B283151B85DC3695367D8D2D9BB5AF47DBD71D9CC24BCD");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = getleveldata(self.cratetype);
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  var_3 = [self];

  foreach(var_5 in self getlinkedchildren(1))
  var_3[var_3.size] = var_5;

  self._id_13CCE = 0;
  self._id_13CD0 = 0;

  while(self._id_13CCE < 5) {
    var_7 = self.origin + anglestoup(self.angles) * var_1.setplayerbeingrevivedextrainfo;
    var_8 = var_7 + (0, 0, -200);
    var_9 = scripts\engine\trace::ray_trace(var_7, var_8, var_3, var_2);

    if(var_9.size > 0 && isDefined(var_9["_encstr_850E077B0BF30318B9"]) && var_9["_encstr_850E077B0BF30318B9"] == self._id_13CC8) {
      var_10 = combineangles(invertangles(var_0.angles), var_0.origin - var_9["_encstr_BD260953AA97E3F014279D"]);

      if(!isDefined(self._id_13CCF)) {} else if(distancesquared(var_10, self._id_13CCF) > 25) {
        self._id_13CCE++;
        self._id_13CD0 = 0;
      } else if(vectordot(var_10, self._id_13CCF) < 0.997) {
        self._id_13CCE++;
        self._id_13CD0 = 0;
      } else {
        self._id_13CD0++;

        if(self._id_13CD0 >= 4) {
          self linkTo(var_0);
          activatecrate(self.unset_relic_amped);
          thread infilweaponraise();
          break;
        }
      }

      self._id_13CCF = var_10;
    } else
      break;

    wait 0.05;
  }

  thread generatecodestoshow();
}

generatecodestoshow() {
  self notify("_encstr_B283151B85DC3695367D8D2D9BB5AF47DBD71D9CC24BCD");
  self._id_13CC8 = undefined;
  self._id_13CCF = undefined;
  self._id_13CCE = undefined;
  self._id_13CD0 = undefined;
}

br_badcircleareas(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = gettime();

  while(gettime() - var_1 < 3000) {
    var_0 dodamage(100, var_0.origin, self, self, "_encstr_8D4E0A501FCB898912CB3FA3");
    wait 0.5;
  }
}

_id_11D0C() {
  if(!istrue(self._id_11D0E)) {
    return;
  }
  self notify("_encstr_927011315D6253F317BB21089B3129D178853D");
  self._id_11D0E = undefined;
  self stoploopsound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
  self physics_unregisterforcollisioncallback();
}

start_chants_on_movement(var_0) {
  if(!istrue(self._id_12332)) {
    if(isDefined(var_0.classname)) {
      if(var_0.classname == "_encstr_BD4E0B7B104D6AD4DF384717A0")
        return 0;
      else if(var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
        if(var_0 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
          var_1 = getleveldata(self.cratetype);
          var_2 = self.origin + anglestoup(self.angles) * var_1.setplayerbeingrevivedextrainfo;
          return var_0.origin[2] <= var_2[2];
        }
      }
    }
  }

  return 0;
}

_id_11D17() {
  _id_11D18();
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_958317B5BDDC2DE8BD39A0D816F295E44AD6C1C2C6D1A87391");
  var_0 = self;

  if(isDefined(self.mountmantlemodel))
    var_0 = self.mountmantlemodel;

  var_1 = undefined;

  if(isDefined(self.owner))
    var_1 = self.owner;

  while(isDefined(var_0)) {
    var_0 waittill("_encstr_93410E6B08AB38F713F8203D8638BF07", var_2, var_3);

    if(isDefined(var_2) && (isPlayer(var_2) || isagent(var_2)) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = var_3[2] <= -8;
      var_5 = 0;
      var_6 = undefined;

      if(var_2 tagexists("_encstr_8FE10B52092BB64F28E6B7BFFD")) {
        var_6 = var_2 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");
        var_7 = getleveldata(self.cratetype);
        var_8 = self.origin + anglestoup(self.angles) * var_7.setplayerbeingrevivedextrainfo;
        var_5 = var_6[2] <= var_8[2];
      }

      if(var_4 && var_5) {
        var_9 = var_1;

        if(!isDefined(var_9))
          var_9 = var_2;
      }
    }
  }
}

_id_11D18() {
  self notify("_encstr_958317B5BDDC2DE8BD39A0D816F295E44AD6C1C2C6D1A87391");
}

_id_1273B(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"), var_0, var_1);

  if(var_2 < 150)
    self playsurfacesound("_encstr_8EC81BB5C1FAB185C995EB072C366D0BCEB27DB1DE77EBA5B583851BD1", var_3);
  else if(var_2 < 300)
    self playsurfacesound("_encstr_BD5C1BF7C0AE2B5AB5E5897ADFBF32F17180C77FF0615F82F3070EB6BD", var_3);
  else
    self playsurfacesound("_encstr_BEEB1CF5796146279E0141BBE97E77BEC8CB4F48E3784C17CB38ABD2B1CD", var_3);

  self stoploopsound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
}

createdangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0")]]()) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")) {
    return;
  }
  destroydangerzone();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.owner) && isDefined(self.team))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](self.destination, var_0.dangerzoneradius, var_0.dangerzoneheight, self.team, 30.0, self.owner, 1);
  else if(isDefined(self.team))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](self.destination, var_0.dangerzoneradius, var_0.dangerzoneheight, self.team, 30.0);
  else
    var_1 = spawnuniversaldangerzone(self.destination, var_0.dangerzoneradius, var_0.dangerzoneheight, 30.0);

  self.dangerzoneid = var_1;
  return var_1;
}

spawnuniversaldangerzone(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_0, var_1, var_2, undefined, var_3, level.players[randomint(level.players.size)], 1);
    self.dangerzoneid = var_4;
    return var_4;
  }
}

destroydangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_AAED17502BCAC109F75E158F26CFF18DE072E088A0DD0B2397") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_8285169C2BB6DB6759A9E00BBB7388B0E6CE5927D2BDE6B2")) {
    var_0 = self.dangerzoneid;

    if(isDefined(var_0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_AAED17502BCAC109F75E158F26CFF18DE072E088A0DD0B2397")]](var_0))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_8285169C2BB6DB6759A9E00BBB7388B0E6CE5927D2BDE6B2")]](var_0);

    self.dangerzoneid = undefined;
  }
}

_createnavobstacle() {
  self notify("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");
  self endon("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  var_0 = getleveldata(self.cratetype);
  var_1 = createnavobstaclebybounds(self.origin, var_0.navobstaclebounds, self.angles);
  self.navobstacleid = var_1;
  childthread _watchnavobstacle(var_1, self.origin, var_0.navobstacleupdatedistsqr);
  return var_1;
}

_watchnavobstacle(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");

  while(distancesquared(var_1, self.origin) < var_2)
    wait 0.5;

  thread _createnavobstacle();
}

_destroynavobstacle() {
  self notify("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  self.navobstacleid = undefined;
}

createmountmantlemodel() {
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel))
      self.mountmantlemodel delete();

    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    var_1 dontinterpolate();
    var_1.angles = self.angles;
    var_1.owner = self.owner;
    var_1.unresolved_collision_func = ::crateunresolvedcollisioncallback;
    var_1.killcament = self.killcament;
    var_1.mountmantlemodel = 1;
    var_1 clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    var_1 linkTo(self);
    self.mountmantlemodel = var_1;
    var_1.crate = self;
    return 1;
  }

  return 0;
}

destroymountmantlemodel() {
  if(isDefined(self.mountmantlemodel))
    self.mountmantlemodel delete();

  self.mountmantlemodel = undefined;
}

crateunresolvedcollisioncallback(var_0, var_1) {
  if(level.cratedata._id_13F28 > 0) {
    if(lengthsquared(var_1) <= level.cratedata._id_13F28)
      return;
  }

  var_2 = self.objweapon;

  if(isDefined(self.init_airdrop_anims))
    var_2 = self.crate.objweapon;

  var_0 dodamage(1000, var_0.origin, self.owner, self, "_encstr_8D4E0A501FCB898912CB3FA3", var_2);
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isPlayer(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_81BC1FDD06A3C197ADBA30A0D24E773873B9665B6FABECF316435008EB553F718F"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_81BC1FDD06A3C197ADBA30A0D24E773873B9665B6FABECF316435008EB553F718F")]](var_0, undefined, self);
  }
}

_createheadicon() {
  if(istrue(self.disallowheadiconid)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.headicon)) {
    if(level.teambased && isDefined(self.team)) {
      if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
        var_1 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.team, self.headicon, var_0.headiconoffset, 1, var_0.headicondrawrange, var_0.headiconnaturalrange, undefined, 1);

      if(isDefined(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A9670B5AB9D489A3352C8E6C1A")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A9670B5AB9D489A3352C8E6C1A")]]())
            removeclientfromheadiconmask(var_1, "_encstr_AF8C0A1B6A1D6045925B4F7D");
        }
      }
    } else if(isDefined(self.owner)) {
      if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
        var_1 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.owner, self.headicon, var_0.headiconoffset, 1, var_0.headicondrawrange, var_0.headiconnaturalrange, undefined, 1);

      if(isDefined(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A9670B5AB9D489A3352C8E6C1A")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A9670B5AB9D489A3352C8E6C1A")]]())
            removeclientfromheadiconmask(var_1, "_encstr_AF8C0A1B6A1D6045925B4F7D");
        }
      }
    } else if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
      scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.teamnamelist, self.headicon, var_0.headiconoffset, 1, var_0.headicondrawrange, var_0.headiconnaturalrange);
  }

  self.headiconid = var_1;
  self.headiconactive = 1;
  return var_1;
}

_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.headiconactive = 0;
}

createminimapicon() {
  destroyminimapicon();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.minimapicon) && !istrue(self.visibilitymanuallycontrolled)) {
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
      var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841");

    if(isDefined(var_2)) {
      if(level.teambased && isDefined(self.team))
        var_1 = self[[var_2]](self.minimapicon, self.team, 1, 1, 0);
      else if(isDefined(self.owner))
        var_1 = self[[var_2]](self.minimapicon, undefined, 1, 1, 0);
      else
        var_1 = self[[var_2]](self.minimapicon, undefined, 0, 1, 0);
    }
  }

  self.minimapid = var_1;
  self.minimapiconactive = 1;
  return var_1;
}

destroyminimapicon() {
  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.minimapid);
  }

  self.minimapid = undefined;
  self.minimapiconactive = 0;
}

watchvisibility() {
  self endon("_encstr_AD75063D571AE108");

  foreach(var_1 in level.players)
  updatevisibilityforplayer(var_1);

  waitframe();
  childthread watchvisibilityinternal();
}

watchvisibilityinternal() {
  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298", var_0);
    updatevisibilityforplayer(var_0);
  }
}

updatevisibilityforplayer(var_0) {
  self.friendlymodel hidefromplayer(var_0);
  self.enemymodel hidefromplayer(var_0);

  if(var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    self.friendlymodel showtoplayer(var_0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var_0.team == self.team)
      self.friendlymodel showtoplayer(var_0);
    else
      self.enemymodel showtoplayer(var_0);

    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var_0 == self.owner)
      self.friendlymodel showtoplayer(var_0);
    else
      self.enemymodel showtoplayer(var_0);

    return;
  }
}

looselinkTo(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A5820C6DC0A74BE50CC02B370140");
  self endon("_encstr_8DA90F0D38E28E8DFB6180A27978A5556A");

  while(istrue(self.physicsactivated)) {
    self.origin = var_0.origin + var_1;
    waitframe();
  }

  self linkTo(var_0);
}

addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

removefromlists(var_0) {
  if(!isDefined(level.cratedata)) {
    return;
  }
  level.cratedata.crates[var_0] = undefined;
}

getrandomkeyfromweightsarray(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;

  foreach(var_11, var_6 in var_0) {
    if(var_6 > 0) {
      var_7 = 0;

      if(isDefined(var_1)) {
        if(var_1.size > 0) {
          foreach(var_10, var_9 in var_1) {
            if(var_9 == var_11) {
              var_1[var_10] = undefined;
              var_7 = 1;
              break;
            }
          }
        } else
          var_1 = undefined;
      }

      if(!var_7) {
        var_4 = var_4 + var_6;
        var_2[var_2.size] = var_11;
        var_3[var_3.size] = var_4;
      }
    }
  }

  var_12 = randomint(var_4);
  var_11 = undefined;

  for(var_13 = 0; var_13 < var_2.size; var_13++) {
    var_4 = var_3[var_13];

    if(var_12 < var_4) {
      var_11 = var_2[var_13];
      break;
    }
  }

  return var_11;
}

getdefaultcapturevisualscallback() {
  return::defaultcapturevisualscallback;
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

getdefaultcapturevisualsdeletiondelay() {
  return getanimlength(%_encstr_9BB1276BC1BED62D36963A85C997FA8D584E56830B1B5BC2D92BFA37A34EB0E037FA992C8DB15AE6EC);
}

#using_animtree("_encstr_B40101");

defaultcapturevisualscallback(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isdummyarmcrate)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getanimlength(%_encstr_9BB1276BC1BED62D36963A85C997FA8D584E56830B1B5BC2D92BFA37A34EB0E037FA992C8DB15AE6EC);

  if(isDefined(var_1))
    var_1 = max(0, var_1 - 0.05);

  var_0 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_95EB0866891B23FB85B3", 0);
  var_0 setscriptablepartstate("_encstr_95EB0866891B23FB85B3", "_encstr_99AD06D3A5B1538B", 0);
  var_0 notsolid();

  if(isDefined(var_1))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  playFX(scripts\engine\utility::getfx("_encstr_8CF81660FAF2B93BC7F0283EEA27237311E2E870434BCD91"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
}

getdefaultdestroyvisualsdeletiondelay() {
  return 0;
}

getdefaultdestroyvisualscallback() {
  return::defaultdestroyvisualscallback;
}

defaultdestroyvisualscallback(var_0) {}

getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

getnumdroppedcrates() {
  if(!isDefined(level.cratedata))
    return 0;

  return level.cratedata.crates.size;
}

_id_13C46() {
  if(!isDefined(self.numactivejuggdrops)) {
    if(self ismantling()) {
      var_0 = self getmovingplatformparent();

      if(isDefined(var_0) && isDefined(var_0.crate)) {
        self.num_shot_taken_to_next_damage_state = var_0;
        self.num_times_stealth_broken_tv_station_interior = var_0.crate;
      }

      self.numactivejuggdrops = gettime() + 1000;
    }
  } else if(gettime() >= self.numactivejuggdrops) {
    self.num_shot_taken_to_next_damage_state = undefined;
    self.num_times_stealth_broken_tv_station_interior = undefined;
    self.numactivejuggdrops = undefined;
  } else {
    foreach(var_2 in level.cratedata.crates) {
      if(isDefined(var_2) && istrue(var_2.physicsactivated) && !istrue(var_2._id_12332)) {
        if(isDefined(self.num_shot_taken_to_next_damage_state)) {
          if(isDefined(var_2.mountmantlemodel)) {
            if(self.num_shot_taken_to_next_damage_state != var_2.mountmantlemodel) {
              if(self istouching(var_2.mountmantlemodel)) {
                self.num_shot_taken_to_next_damage_state = undefined;
                self.num_times_stealth_broken_tv_station_interior = undefined;
                self.numactivejuggdrops = undefined;

                if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877"))
                  self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877")]]();
                else
                  self suicide();

                return;
              }
            }
          }

          if(self.num_times_stealth_broken_tv_station_interior != var_2) {
            if(self istouching(var_2)) {
              self.num_shot_taken_to_next_damage_state = undefined;
              self.num_times_stealth_broken_tv_station_interior = undefined;
              self.numactivejuggdrops = undefined;

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877"))
                self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877")]]();
              else
                self suicide();

              return;
            }
          }
        } else if(self istouching(var_2) || isDefined(var_2.mountmantlemodel) && self istouching(var_2.mountmantlemodel)) {
          self.num_shot_taken_to_next_damage_state = undefined;
          self.num_times_stealth_broken_tv_station_interior = undefined;
          self.numactivejuggdrops = undefined;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877"))
            self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877")]]();
          else
            self suicide();

          return;
        }
      }
    }
  }
}

overridecapturestring(var_0) {
  if(isDefined(self.capturestring) && self.capturestring == var_0) {
    return;
  }
  self.capturestring = var_0;
  var_1 = [self];

  if(isDefined(self.useobject))
    var_1[var_1.size] = self.useobject;

  foreach(var_3 in var_1) {
    if(!self.supportsreroll || var_3.usetype == 2)
      var_3 setHintString(self.capturestring);
  }
}

overridererollstring(var_0) {
  if(isDefined(self.rerollstring) && self.rerollstring == var_0) {
    return;
  }
  self.rerollstring = var_0;
  var_1 = [self];

  if(isDefined(self.useobject))
    var_1[var_1.size] = self.useobject;

  foreach(var_3 in var_1) {
    if(self.supportsreroll && var_3.usetype == 1)
      var_3 setHintString(self.rerollstring);
  }
}

overrideheadicon(var_0) {
  if(!isDefined(self.headicon) && !isDefined(var_0)) {
    return;
  }
  if(isDefined(self.headicon) && isDefined(var_0) && self.headicon == var_0) {
    return;
  }
  if(!isDefined(var_0)) {
    self.headicon = undefined;
    _destroyheadicon();
  } else {
    self.headicon = var_0;

    if(self.headiconactive) {
      if(isDefined(self.headiconid))
        setheadiconfriendlyimage(self.headiconid, var_0);
      else
        _createheadicon();
    }
  }
}

overrideminimapicon(var_0) {
  if(!isDefined(self.minimapicon) && !isDefined(var_0)) {
    return;
  }
  if(isDefined(self.minimapicon) && isDefined(var_0) && self.minimapicon == var_0) {
    return;
  }
  if(!isDefined(var_0)) {
    self.minimapicon = undefined;
    destroyminimapicon();
  } else {
    self.minimapicon = var_0;

    if(self.minimapiconactive) {
      if(isDefined(self.minimapid))
        scripts\mp\objidpoolmanager::update_objective_icon(self.minimapid, var_0);
      else
        createminimapicon();
    }
  }
}

overridesupportsreroll(var_0) {
  if(self.supportsreroll == var_0) {
    return;
  }
  self.supportsreroll = var_0;

  if(self.supportsreroll) {
    var_1 = [self];

    if(isDefined(self.useobject))
      var_1[var_1.size] = self.useobject;

    foreach(var_3 in var_1) {
      if(var_3.usetype == 1)
        var_3 setHintString(self.rerollstring);
    }
  }
}

initkillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  var_0 = ::killstreakcrateactivatecallback;
  var_1 = ::killstreakcratecapturecallback;
  var_2 = getleveldata("_encstr_85CE0B9770B02C73A1760F06D2");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2 = getleveldata("_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2.supportsownercapture = 0;
  var_2.enemymodel = undefined;
  addkillstreakcratedata("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", undefined, undefined, 120);
  addkillstreakcratedata("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", undefined, undefined, 120);
  addkillstreakcratedata("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", undefined, undefined, 120);
  addkillstreakcratedata("_encstr_851904B59B34", undefined, undefined, 120);
  addkillstreakcratedata("_encstr_A2E60C6BC099B7E1A0A93A398F48", undefined, undefined, 170);
  addkillstreakcratedata("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", undefined, undefined, 170);
  addkillstreakcratedata("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", undefined, undefined, 170);
  addkillstreakcratedata("_encstr_AA060B6EB2731DE4BCFAEC57E6", undefined, undefined, 50);
  addkillstreakcratedata("_encstr_B1B30B51D176511E377A1BC313", undefined, undefined, 50);
  addkillstreakcratedata("_encstr_8CC008133958C81BACCB", undefined, undefined, 50);
  addkillstreakcratedata("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", undefined, undefined, 10);
  addkillstreakcratedata("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950", undefined, undefined, 10);
  addkillstreakcratedata("_encstr_86FD08B775CD07DC1338", undefined, undefined, 10);
  addkillstreakcratedata("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", undefined, undefined, 10);
  addkillstreakcratedata("_encstr_8C980A867B3B569CFAA659E8", undefined, undefined, 10);
  addkillstreakcratedata("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", undefined, undefined, 10);
  addkillstreakcratedata("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", undefined, undefined, 5);
  var_3 = 50;
  thread initkillstreakcratedatalate(var_3);
}

initdropzonekillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  var_0 = ::killstreakcrateactivatecallback;
  var_1 = ::killstreakcratecapturecallback;
  var_2 = getleveldata("_encstr_85CE0B9770B02C73A1760F06D2");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2 = getleveldata("_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2.supportsownercapture = 0;
  var_2.enemymodel = undefined;
  var_3 = 0;
  addkillstreakcratedata("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", undefined, undefined, 100);
  addkillstreakcratedata("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", undefined, undefined, 100);
  addkillstreakcratedata("_encstr_851904B59B34", undefined, undefined, 100);
  addkillstreakcratedata("_encstr_A2E60C6BC099B7E1A0A93A398F48", undefined, undefined, 65);
  addkillstreakcratedata("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", undefined, undefined, 65);
  addkillstreakcratedata("_encstr_AA060B6EB2731DE4BCFAEC57E6", undefined, undefined, 65);
  addkillstreakcratedata("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", undefined, undefined, 65);
  addkillstreakcratedata("_encstr_B1B30B51D176511E377A1BC313", undefined, undefined, 35);
  addkillstreakcratedata("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", undefined, undefined, 35);
  addkillstreakcratedata("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", undefined, undefined, 35);
  addkillstreakcratedata("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", undefined, undefined, 35);
  addkillstreakcratedata("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950", undefined, undefined, 15);
  addkillstreakcratedata("_encstr_86FD08B775CD07DC1338", undefined, undefined, 15);
  addkillstreakcratedata("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", undefined, undefined, 15);
  addkillstreakcratedata("_encstr_8C980A867B3B569CFAA659E8", undefined, undefined, 15);

  if(level.gametype != "_encstr_AAE507E8423F63C163") {
    addkillstreakcratedata("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", undefined, undefined, 100);
    addkillstreakcratedata("_encstr_8CC008133958C81BACCB", undefined, undefined, 35);
    var_3 = 25;
    thread initkillstreakcratedatalate(var_3);
  }
}

initkillstreakcratedatalate(var_0) {
  waittillframeend;
  var_1 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\light_tank::light_tank_supported(), var_0, 0);
  addkillstreakcratedata("_encstr_8CC008133958C81BACCB", undefined, undefined, var_1);
}

addkillstreakcratedata(var_0, var_1, var_2, var_3) {
  level.cratedata.kscapturestrings[var_0] = var_1;
  level.cratedata.ksrerollstrings[var_0] = var_2;
  level.cratedata.ksweights[var_0] = var_3;
}

getkillstreakcratedatabystreakname(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.supportsreroll = var_1;
  return var_2;
}

overridekillstreakcrateweight(var_0, var_1) {
  level.cratedata.ksweights[var_0] = var_1;
}

killstreakcrateactivatecallback(var_0) {
  var_1 = self.data;
  var_2 = level.cratedata.kscapturestrings[var_1.streakname];

  if(isDefined(var_2))
    overridecapturestring(var_2);

  var_3 = level.cratedata.ksrerollstrings[var_1.streakname];

  if(isDefined(var_3))
    overridererollstring(var_3);

  var_4 = var_1.supportsreroll;

  if(isDefined(var_4))
    overridesupportsreroll(var_4);
}

killstreakcratecapturecallback(var_0) {
  var_1 = self.data.streakname;
  var_2 = 0;

  switch (var_1) {
    case "_encstr_8CC008133958C81BACCB":
      if(!scripts\cp_mp\vehicles\light_tank::light_tank_supported())
        var_1 = "_encstr_B1B30B51D176511E377A1BC313";

      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      if(!istrue(var_0.isjuggernaut)) {
        var_2 = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_ACD719491F2B93408B78DA52D823BE0B619AC5C73CD1A3CD838053"))
          var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_ACD719491F2B93408B78DA52D823BE0B619AC5C73CD1A3CD838053")]](var_2);
        else
          var_0 scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(var_2);
      }

      break;
  }

  if(!istrue(var_2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_A1C61066D3304A728AFB93ABF73DDB95E8B8"))
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1C61066D3304A728AFB93ABF73DDB95E8B8")]](var_1, self.owner, self);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BD53157A9377DBFB98D8730770938DE2D7A602358FB7E2"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BD53157A9377DBFB98D8730770938DE2D7A602358FB7E2")]](var_1, undefined, 1);
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    return;
  }
  if(isDefined(self.team)) {
    if(var_0.team != self.team) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516"))
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516")]]("_encstr_A3E00911A924B0061FFAEB");

      if(isDefined(self.owner)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_83C20B6E437BBB6A0E63B0E686"))
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_83C20B6E437BBB6A0E63B0E686")]]("_encstr_81231110F73A618FF26705807E8AF5898A5758", undefined, var_0);
      }
    } else {}
  } else {}
}

getrandomkillstreak(var_0) {
  var_1 = getrandomkeyfromweightsarray(level.cratedata.ksweights, var_0);
  return var_1;
}

placekillstreakcrate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || var_2 == "_encstr_A31207CBF788523281")
    var_2 = getrandomkillstreak();

  var_5 = scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_6 = getkillstreakcratedatabystreakname(var_2, 0);
  var_7 = placecrate(var_0, var_1, var_5, var_3, var_4, var_6);

  if(!isDefined(var_7))
    return undefined;

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A54D0DD503E7F9C7261218B0BB7D51", var_0);
  }

  return var_7;
}

dropkillstreakcrate(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2) || var_2 == "_encstr_A31207CBF788523281")
    var_2 = getrandomkillstreak();

  var_6 = scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_7 = getkillstreakcratedatabystreakname(var_2, 0);
  var_8 = dropcrate(var_0, var_1, var_6, var_3, var_4, var_5, var_7);

  if(!isDefined(var_8))
    return undefined;

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A54D0DD503E7F9C7261218B0BB7D51", var_0);
  }

  return var_8;
}

dropkillstreakcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2) || var_2 == "_encstr_A31207CBF788523281")
    var_2 = getrandomkillstreak();

  var_8 = scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_9 = getkillstreakcratedatabystreakname(var_2, 0);
  var_9.vehicleisreserved = var_6;
  var_10 = dropcratefromscriptedheli(var_0, var_1, var_8, var_3, var_4, var_5, var_9, var_7);

  if(!isDefined(var_10))
    return undefined;
  else if(!isDefined(var_10.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var_10.crates)))
    return undefined;

  if(isDefined(var_0)) {
    var_0 thread br_c130spawndone(var_7);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A54D0DD503E7F9C7261218B0BB7D51", var_0);
  }

  return var_10;
}

br_c130spawndone(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level.gametype == "_encstr_9A7205B39CB919" || level.gametype == "_encstr_AAE507E8423F63C163") {
    return;
  }
  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_2 = 1.5;
  }

  var_3 = var_0.streakname;

  if(isDefined(var_1))
    var_3 = var_1;

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_3, 1, var_2);
}

dropkillstreakcratefrommanualheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2) || var_2 == "_encstr_A31207CBF788523281")
    var_2 = getrandomkillstreak();

  var_7 = scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_8 = getkillstreakcratedatabystreakname(var_2, 0);
  var_8.vehicleisreserved = var_6;
  var_9 = dropcratefrommanualheli(var_0, var_1, var_7, var_3, var_4, 30000, 30000, var_5, var_8);

  if(!isDefined(var_9))
    return undefined;
  else if(!isDefined(var_9.crate))
    return undefined;

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A54D0DD503E7F9C7261218B0BB7D51", var_0);
  }

  return var_9.crate;
}

tryairdroptriggered(var_0) {
  var_1 = var_0.streakname;
  var_2 = var_1;
  var_3 = undefined;

  if(!isDefined(var_2))
    var_2 = "_encstr_BA67082278D537E3C827";

  var_4 = 4;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    var_4 = 10;

  var_5 = 1;

  if((level.littlebirds.size >= var_4 || level.fauxvehiclecount >= var_4) && var_2 != "_encstr_8E710DF71C63897357F3D1488F7729") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A69E195353E4DC5A5B5BD5AFD786883D371657C828B9AF79578FDF");

    return 0;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]() || level.fauxvehiclecount + var_5 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");

      return 0;
    }
  }

  var_6 = getdvarint("_encstr_A9DD13DAB6EDF971388833E34833176389DBA65423", 0);

  if(var_2 == "_encstr_BA67082278D537E3C827" && var_6)
    var_0.deployweaponobj = getcompleteweaponname("_encstr_841719F45B108D27234EBA22F3F51B056847656897A053C7C6E033");

  return 1;
}

airdropmarkerswitchended(var_0, var_1) {
  if(istrue(var_1))
    thread airdrop_watchplayerweapon(var_0);
}

airdrop_watchplayerweapon(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
  var_1 = scripts\engine\utility::_id_143AD("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

airdropvisualmarkerfired(var_0) {
  var_0.airdroptype = var_0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]]();

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E"))
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E")]](var_0);

  if(!isDefined(var_1.location)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.airdroptype, self.origin);

  airdropvisualmarkeractivate(var_1, var_0.airdroptype, var_0);
  return 1;
}

airdropvisualmarkeractivate(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::drop_to_ground(var_0.location, 50, -200, (0, 0, 1));
  var_3 = var_3 + (0, 0, 1);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_4 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  var_4.angles = (0, 90, 90);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_5 setModel("_encstr_B231139B17092E334F8B5AE1B097FBE460BD371569");
  var_5 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);

  if(isDefined(var_0.visual))
    var_0.visual delete();
}

tryuseairdropmarker() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_BA67082278D537E3C827", self);
  return tryuseairdropmarkerfromstruct(var_0);
}

tryuseairdropmarkerfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.deployweaponobj = getcompleteweaponname("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683");
  var_1 = undefined;

  switch (var_0.streakname) {
    case "_encstr_BA67082278D537E3C827":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
  }

  if(var_1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

      return 0;
    }
  }

  if(!tryairdroptriggered(var_0)) {
    if(var_1)
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      if(var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

      return 0;
    }
  }

  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_0.deployweaponobj, "_encstr_9B620D8F0DC07577C551F16A3826BF", undefined, ::airdropmarkerswitchended, ::airdropmarkerfired, undefined, ::airdropmarkertaken);

  if(!istrue(var_2)) {
    if(var_1)
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  return 1;
}

airdropmarkerfired(var_0, var_1, var_2) {
  var_0.airdroptype = var_0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]]();

  var_2.owner = self;
  var_2 thread airdropmarkeractivate(var_0.airdroptype, undefined, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.airdroptype, self.origin);

  var_0.airdropmarkerfired = 1;
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  return "_encstr_88E30897BDF1B71F7823";
}

airdropmarkeractivate(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = self.owner.angles;
  self waittill("_encstr_860808CB78E2984063BA", var_4);
  var_5 = self.owner;

  if(!isDefined(var_5)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }

  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

  var_7 = undefined;

  if(var_0 == "_encstr_BA67082278D537E3C827")
    var_7 = dropkillstreakcratefromscriptedheli(var_5, var_5.team, undefined, var_4, var_3 + (0, 180, 0), var_4, 1, var_2);
  else if(var_0 == "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8E211A852D4E4627DBC1A65D631D961CB1AC2239DE83A1C916472BE6"))
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8E211A852D4E4627DBC1A65D631D961CB1AC2239DE83A1C916472BE6")]](var_5, var_5.team, var_4, var_3 + (0, 180, 0), var_4, var_2);
  }

  if(!isDefined(var_7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88D02667E3D104E7E1DAB5C7236955AFFB8BEF767025C71BBD758B984F87CAA13C3C71A96EA075BC");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59"))
      var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59")]](var_2.mpstreaksysteminfo, "_encstr_8261067B1D34AC27");

    return;
  }

  var_5 scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_2);
}

airdropmarkertaken(var_0) {
  if(istrue(var_0.airdropmarkerfired)) {
    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](var_0);
  }

  if(isDefined(var_0.airdroptype) && !istrue(var_0.airdropmarkerfired)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();
  }
}

initbattleroyalecratedata() {
  var_0 = getleveldata("_encstr_A2D40E260F2983A46129135F20D96C5A");
  var_0.capturestring = &"_encstr_AB3D0CCD21FA16C320FDB9B02715";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.activatecallback = ::brcrateactivatecallback;
  var_0.capturecallback = ::brcratecapturecallback;
}

getbrcratedatabytype(var_0) {
  var_1 = spawnStruct();
  var_1.type = var_0;
  return var_1;
}

brcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

brcratecapturecallback(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_91651315562FDFA84C43777B8FE8E85986237123A5"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91651315562FDFA84C43777B8FE8E85986237123A5")]](var_0);
}

dropbrcratefromscriptedheli(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_AC20072B9FA9487832", "_encstr_B19A0BD803A4E10F42E50598BB");
  var_2 = dropcratefromscriptedheli(undefined, undefined, "_encstr_A2D40E260F2983A46129135F20D96C5A", var_0, (0, randomfloat(360), 0), var_0, getbrcratedatabytype(var_1));

  if(!isDefined(var_2))
    return undefined;
  else if(!isDefined(var_2.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var_2.crates)))
    return undefined;

  return var_2.crate;
}

dropbrcratefrommanualheli(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_AC20072B9FA9487832", "_encstr_B19A0BD803A4E10F42E50598BB");
  var_2 = dropcratefrommanualheli(undefined, undefined, "_encstr_A2D40E260F2983A46129135F20D96C5A", var_0, (0, randomfloat(360), 0), 30000, 30000, var_0, getbrcratedatabytype(var_1));

  if(!isDefined(var_2))
    return undefined;
  else if(!isDefined(var_2.crate))
    return undefined;

  return var_2.crate;
}

teamplacement() {
  var_0 = getleveldata("_encstr_A53519E2C829A30B19AFDACF2BA1332FD75BDACAB0CFD1639370C0");
  var_0.dummymodel = relic_landlocked_do_explosion("_encstr_BAF90BD64BF637B67D3293DB07");
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.destroyoncapture = 0;
}

missionbasetimer(var_0, var_1, var_2) {
  return dropcrate(undefined, var_0, "_encstr_A53519E2C829A30B19AFDACF2BA1332FD75BDACAB0CFD1639370C0", var_1, (0, randomfloat(360), 0), var_2);
}

initbattleroyaleloadoutcratedata() {
  var_0 = getleveldata("_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D");
  var_0.capturestring = &"_encstr_8AC61435D902EECB28E5B1882F0DC7D5A963B44FBB81";
  var_0.dummymodel = relic_landlocked_do_explosion();
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::brloadoutcrateactivatecallback;
  var_0.capturecallback = ::brloadoutcratecapturecallback;
  var_0.destroycallback = ::dropradius;
  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 1;
}

brloadoutcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8A6A1E989C62F616C8B75D476839C2D195912DC9CD8E0AB11D5A6716D1B4F637"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8A6A1E989C62F616C8B75D476839C2D195912DC9CD8E0AB11D5A6716D1B4F637")]](self);
  }
}

brloadoutcratecapturecallback(var_0) {
  giveweaponsfromdropbag(var_0);
}

dropspecialistbonus(var_0) {
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  if(!isDefined(self.playerscaptured))
    self.playerscaptured = [];

  self.playerscaptured[var_0 getentitynumber()] = var_0;
  self.playersused[self.playersused.size] = var_0;
  self.numuses++;

  if(isDefined(self.playeroutlines)) {
    foreach(var_2 in self.playeroutlines) {
      if(isDefined(self.outlines) && isDefined(self.outlines[var_2]) && isDefined(self.outlines[var_2].playersvisibleto)) {
        if(self.outlines[var_2].playersvisibleto.size == 1 && self.outlines[var_2].playersvisibleto[0] == var_0) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_2, self);

          self.playeroutlines = scripts\engine\utility::array_remove(self.playeroutlines, var_2);
          break;
        }
      }
    }
  }

  if(self.numuses >= level.teamdata[var_0.team]["_encstr_AB580A05672AE35D5FFF50B8"]) {
    if(isDefined(self.playeroutlines)) {
      foreach(var_5 in self.playeroutlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_5, self);
      }
    }

    if(isDefined(self.choosenlocation) && isDefined(self.choosenlocation.inuse))
      self.choosenlocation.inuse = 0;

    thread destroycrate();
  }
}

dropradius(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_AF431A59AE6793EBE7E64467A3FD48ADA39B5D59CB56B1261D3312CB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AF431A59AE6793EBE7E64467A3FD48ADA39B5D59CB56B1261D3312CB")]](var_0);
}

giveweaponsfromdropbag(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BA6516FAAE7E0FD465A838531081C6CFD1094F71CDED0FDB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BA6516FAAE7E0FD465A838531081C6CFD1094F71CDED0FDB")]](var_0);
}

dropbrloadoutcrate(var_0, var_1, var_2) {
  return dropcrate(undefined, var_0, "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D", var_1, (0, randomfloat(360), 0), var_2);
}

teammateoutlineids() {
  var_0 = getleveldata("_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D");

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    var_0.capturestring = &"_encstr_B1FA1AFF6950808D695EBD757431D74846E303578FBE18A8416722CF";
  else
    var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";

  var_0.dummymodel = relic_landlocked_do_explosion();
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = 600;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::dialog_wait_think;
  var_0.capturecallback = ::dialog_wait_think_civ;
  var_0.destroycallback = ::dialogqueue;
  var_0.ingame = ::dialogueindex;
  var_0.destroyoncapture = 1;
}

dialog_wait_think(var_0) {}

dialog_wait_think_civ(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A7AA0FC427BED813CC06A0A54E329CDE07", "_encstr_BA2017FE03BA1008A3F59BCB27D711B7B8D532C603503D638D"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A7AA0FC427BED813CC06A0A54E329CDE07", "_encstr_BA2017FE03BA1008A3F59BCB27D711B7B8D532C603503D638D")]](var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A7AA0FC427BED813CC06A0A54E329CDE07", "_encstr_AF8411C0C79BB113F90E17825073B9DB686FCF"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A7AA0FC427BED813CC06A0A54E329CDE07", "_encstr_AF8411C0C79BB113F90E17825073B9DB686FCF")]](var_0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  if(isDefined(level.focus_fire_attacker_timeout))
    level.focus_fire_attacker_timeout = scripts\engine\utility::array_remove(level.focus_fire_attacker_timeout, self);
}

dialogqueue(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  if(isDefined(level.focus_fire_attacker_timeout))
    level.focus_fire_attacker_timeout = scripts\engine\utility::array_remove(level.focus_fire_attacker_timeout, self);
}

dialogueindex() {
  self setscriptablepartstate("_encstr_9BF30C3F2099CCEA7F7793CF6B37", "_encstr_A1A107973D7982FB90", 0);
}

minshotstostage3acc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 250;
  var_8 = level.fnhidefoundintel;
  var_9 = 1000;
  var_10 = 10500;
  var_11 = 7500;
  var_12 = 3000;
  var_13 = var_1 + (0, 0, var_9);
  var_14 = "_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D";

  if(isDefined(var_3))
    var_14 = var_3;

  if(!isDefined(var_5))
    var_5 = 0;

  var_15 = createcrate(undefined, undefined, var_14, var_0, (0, 0, 0), var_1, undefined, 0);

  if(isDefined(var_15)) {
    var_15.skipminimapicon = 1;

    if(!var_5 && var_13[2] < var_0[2]) {
      var_16 = undefined;
      var_17 = distance(var_0, var_13);

      if(var_17 >= var_10)
        var_16 = "_encstr_960811A04022EFCFA3812AB63F6B9FBBE36C3A";
      else if(var_17 >= var_11)
        var_16 = "_encstr_B4D9109636D7072B1BD9BBFB404B0F8AA345";
      else if(var_17 >= var_12)
        var_16 = "_encstr_B6D910989C3613CC06D74693DBE07D63ED77";

      if(isDefined(var_16)) {
        var_18 = 1000;
        var_19 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_13 + (0, 0, var_18));
        var_19.angles = var_2;
        var_19 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_15.animname = "_encstr_BAE50DE60E739BA638C72068AF47B9";
        var_15.dropanim = level.scr_anim[var_15.animname][var_16];
        var_15.animlength = getanimlength(var_15.dropanim);
        var_15 scripts\common\anim::setanimtree();
        var_20 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_15.origin);
        var_20.angles = var_15.angles;
        var_20.animname = "_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21";
        var_20.dropanim = level.scr_anim[var_20.animname][var_16];
        var_20.animlength = getanimlength(var_20.dropanim);
        var_20 setModel("_encstr_B2CB2693115CC8117AA75CAF820EB9B851B20E5FE0DEFA98F3C09BFF4A1643C6AEB9150371E71B6A");
        var_20 scripts\common\anim::setanimtree();
        var_19 thread scripts\common\anim::anim_single_solo(var_15, var_16);
        var_19 thread scripts\common\anim::anim_single_solo(var_20, var_16);
        var_15 thread _id_14492();
        var_20 thread _id_14493(var_19);
      } else
        var_15 infinite_chopper();
    } else
      var_15 infinite_chopper();

    var_21 = "_encstr_A1D710C6C26ED08C39B70EF58DF65BADF673";
    var_22 = getdvarint("_encstr_A2F61B3B61366F0F70D57751EBD05793D07B710268044F85D8B74F5A85", 1);

    if(var_22)
      var_21 = "_encstr_8685168D0BDC34234EBD0EFAB1DBB6D67B9BD7EEDBE43619";

    if(isDefined(var_4))
      var_21 = var_4;

    var_15 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", var_21, 0);
    var_15 setscriptablepartstate("_encstr_9BF30C3F2099CCEA7F7793CF6B37", "_encstr_B6200C1308902F6F20507333FDCC", 0);
    var_15._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
    var_15._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");

    if(!istrue(var_6))
      var_15._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_AB0703DBB9", 0);

    var_23 = getleveldata(var_14);

    if(isDefined(var_23._id_127FD))
      var_15 thread[[var_23._id_127FD]]();
  }

  return var_15;
}

_id_14492() {
  self endon("_encstr_AD75063D571AE108");
  wait(self.animlength);

  if(isDefined(self)) {
    self stopanimScripted();
    infinite_chopper();
  }
}

_id_14493(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(self.animlength);

  if(isDefined(self))
    self delete();

  if(isDefined(var_0))
    var_0 delete();
}

teamplunderexfil() {
  var_0 = getleveldata("_encstr_992A1BB5F7334D18E551C378C0C9D00D39573927CB1B9DD007756870AB");
  var_0.capturestring = &"_encstr_9ACA1DF30788DC9F86290FCC6DEDB44D968656D2F6993FA7FF9E0ACCAB0977";
  var_0.dummymodel = relic_landlocked_do_explosion();
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = 600;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::dummy_model;
  var_0.capturecallback = ::dvarlocations;
  var_0.destroycallback = ::dwell_aggro;
  var_0.destroyoncapture = 1;
}

dummy_model(var_0) {}

dvarlocations(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D480F89C9D7C6F6F6A3B1D0DB1C38AC39", "_encstr_AFFD17A58F20BBBFF4905B4247A041307248BB123C3DD38208"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D480F89C9D7C6F6F6A3B1D0DB1C38AC39", "_encstr_AFFD17A58F20BBBFF4905B4247A041307248BB123C3DD38208")]](var_0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }
}

dwell_aggro(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }
}

missionbonustimer(var_0, var_1) {
  var_2 = dropcrate(undefined, undefined, "_encstr_992A1BB5F7334D18E551C378C0C9D00D39573927CB1B9DD007756870AB", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2.skipminimapicon = 1;
    var_3 = "_encstr_A1D710C6C26ED08C39B70EF58DF65BADF673";
    var_4 = getdvarint("_encstr_A2F61B3B61366F0F70D57751EBD05793D07B710268044F85D8B74F5A85", 1);

    if(var_4)
      var_3 = "_encstr_8685168D0BDC34234EBD0EFAB1DBB6D67B9BD7EEDBE43619";

    var_2 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", var_3, 0);
    var_2._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
    var_2._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_2._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_AB0703DBB9", 0);
  }

  return var_2;
}

missionid(var_0, var_1) {
  var_2 = dropcrate(undefined, undefined, "_encstr_992A1BB5F7334D18E551C378C0C9D00D39573927CB1B9DD007756870AB", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2.skipminimapicon = 1;
    var_2 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_A79511C1CAFAC686EDE0072B39FAB1E4853A95", 0);
    var_2._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
    var_2._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_2._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_A3BD0E23776F2803CA83A99B9391D808", 0);
  }

  return var_2;
}

initplundercratedata() {
  var_0 = getleveldata("_encstr_9BC90AC77780B09066D9C8CD");
  var_0.capturestring = &"_encstr_8D8F1609A3E03F3238792F01354B4547F132632884708E79";
  var_0.usetag = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  var_0.userange = 200;
  var_0.usefov = 160;
  var_0.usepriority = 0;
  var_0.friendlymodel = "_encstr_A11122C832BD7B2337CA0368B313C919A7F978201B97AB9E47D4077E838751E10F81123A";
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -10000;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_AA1C1936160EA3AEE456C4DBDBA3860B6C3459860BC6D8C4B08D6D"))
    var_0.capturecallback = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AA1C1936160EA3AEE456C4DBDBA3860B6C3459860BC6D8C4B08D6D")]]();

  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 1;
  var_0.capturevisualscallback = undefined;
  var_0.destroyvisualscallback = undefined;
  var_0.timeout = undefined;
}

getplcratedata(var_0) {
  var_1 = spawnStruct();
  var_1.contents = var_0;
  return var_1;
}

placeplcrate(var_0, var_1, var_2) {
  var_3 = placecrate(undefined, undefined, "_encstr_9BC90AC77780B09066D9C8CD", var_1, var_2, getplcratedata(var_0));
  return var_3;
}

initarmcratedata() {
  level.cratedata.armweights = [];
  level.cratedata.armcapturestrings = [];
  var_0 = getleveldata("_encstr_91820DA76AAFF6FDFDD94880A217BD");
  var_0.activatecallback = ::armcrateactivatecallback;
  var_0.capturecallback = ::armcratecapturecallback;
  var_0.supportsownercapture = 0;
  var_0.enemymodel = undefined;
  var_0.headicondrawrange = 5000;
  var_0.timeout = 180;
  addarmcratedata("_encstr_851904B59B34", undefined, 5, 10);
  addarmcratedata("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", undefined, 5, 5);
  addarmcratedata("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", undefined, 4, 40);
  addarmcratedata("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", undefined, 4, 20);
  addarmcratedata("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", undefined, 3, 60);
  addarmcratedata("_encstr_A2E60C6BC099B7E1A0A93A398F48", undefined, 2, 40);
  addarmcratedata("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", undefined, 2, 30);
  addarmcratedata("_encstr_B1B30B51D176511E377A1BC313", undefined, 2, 30);
  addarmcratedata("_encstr_86FD08B775CD07DC1338", undefined, 2, 30);
  thread initarmcratedatalate();
}

initarmcratedatalate() {
  waittillframeend;
  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\light_tank::light_tank_supported(), 50, 0);
  addarmcratedata("_encstr_8CC008133958C81BACCB", undefined, 4, var_0);
}

addarmcratedata(var_0, var_1, var_2, var_3) {
  level.cratedata.armdefconlevels[var_0] = var_2;
  level.cratedata.armweights[var_0] = var_3;
  level.cratedata.armcapturestrings[var_0] = var_1;
}

getarmcratedatabystreakname(var_0) {
  var_1 = spawnStruct();
  var_1.streakname = var_0;
  return var_1;
}

armcrateactivatecallback(var_0) {
  var_1 = self.data;
  var_2 = level.cratedata.armcapturestrings[var_1.streakname];

  if(isDefined(var_2))
    overridecapturestring(var_2);
}

armcratecapturecallback(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8A490FD94B675969A5C6D89B3A39CA165B"))
    var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8A490FD94B675969A5C6D89B3A39CA165B")]](self.data.streakname, 0, 0, self.owner);
}

getrandomarmkillstreak(var_0) {
  var_1 = getarmkillsteakstoexcludebyteamdefconlevel(var_0);
  var_2 = getrandomkeyfromweightsarray(level.cratedata.armweights, var_1);
  return var_2;
}

getarmkillsteakstoexcludebyteamdefconlevel(var_0) {
  var_1 = level.defconlevel;
  var_2 = undefined;

  if(var_1 > 1) {
    var_2 = [];

    foreach(var_5, var_4 in level.cratedata.armdefconlevels) {
      if(var_1 > var_4)
        var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

droparmcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1) || var_1 == "_encstr_A31207CBF788523281")
    var_1 = getrandomarmkillstreak(var_0);

  var_5 = getarmcratedatabystreakname(var_1);
  var_6 = dropcratefromscriptedheli(undefined, var_0, "_encstr_91820DA76AAFF6FDFDD94880A217BD", var_2, var_3, var_4, var_5);

  if(!isDefined(var_6))
    return undefined;
  else if(!isDefined(var_6.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var_6.crates)))
    return undefined;

  foreach(var_8 in var_6.crates)
  return var_8;
}

teammatereviveweaponwaitputaway() {
  var_0 = getleveldata("_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385");
  var_0.capturestring = &"_encstr_ACDE245381A1B18FF9C225F10463EFF07440A50E88E409312DAFC90A3045F779C194D5803928";
  var_0.dummymodel = relic_landlocked_do_explosion("_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385");
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.capturecallback = ::display_dont_have_weapon_message;
  var_0.destroycallback = ::display_fx_names_after_plane_spawns;
  var_0.activatecallback = ::display_cypher_updated;
  var_0.ingame = ::display_headicon_to_players;
  var_0._id_127FD = ::display_hint_for_all;
  var_0.destroyoncapture = 1;
}

display_cypher_updated(var_0) {
  scripts\cp_mp\killstreaks\juggernaut::oncrateactivated(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_BDE210BD9B1A93C28E955036E84B9DC2A395"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_BDE210BD9B1A93C28E955036E84B9DC2A395")]](var_0);
}

display_dont_have_weapon_message(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_B29F0BB0BA576E58532DEBDF55"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_B29F0BB0BA576E58532DEBDF55")]](var_0);

  scripts\cp_mp\killstreaks\juggernaut::oncratecaptured(var_0);
}

display_fx_names_after_plane_spawns(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_85DA0F72482643D63053E4CD57185A6F63"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_85DA0F72482643D63053E4CD57185A6F63")]](var_0);
}

display_headicon_to_players(var_0, var_1) {
  self setscriptablepartstate("_encstr_9BF30C3F2099CCEA7F7793CF6B37", "_encstr_A1A107973D7982FB90", 0);
}

display_hint_for_all() {
  self setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_ACFC091AE8AB2FCBE15119", 0);
}

modeallowmeleevehicledamage(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", self);
  return dropcrate(undefined, var_0, "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385", var_1, (0, randomfloat(360), 0), var_2, var_3, 1);
}

_id_13669(var_0, var_1) {
  var_2 = 4096;

  if(istrue(self.umbra))
    var_2 = 10000;

  var_3 = modeallowmeleevehicledamage(self.team, var_0 + (0, 0, var_2), var_0 + (0, 0, 512));
  var_3 endon("_encstr_AD75063D571AE108");
  move_payload_to_back_of_super(var_3);
  give_deployable_crate(var_3);
  var_4 = [];

  foreach(var_6 in level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {}
}

move_payload_to_back_of_super(var_0) {
  var_0 setotherent(self);
  var_0 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_82F50B526FF73A07C3E52B6C68");
}

give_deployable_crate(var_0) {
  var_0 setotherent(self);
  var_0 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_ACFC091AE8AB2FCBE15119");
}

vehicle_isfriendlytoplayer(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385":
      var_1 = 0;
      break;
    case "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
        var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

        if(!istrue(var_2))
          var_1 = 0;
      }

      break;
  }

  return var_1;
}

teamplunderexfilshowviponly() {
  var_0 = getleveldata("_encstr_9B0E1EC458E8D11B95AF27B7E50BC6B2F58E58C6A35A6CB08DD7192BD94B6CCA");
  var_0.capturestring = &"_encstr_96251FCD0159CA997BD56B8C0792A0B1BD499FE69354D9CF91D11F140FD14C407F";
  var_0.dummymodel = "_encstr_A9DE2272E879C44BB9B6F1DFC641AB0FA9301AAA0B37BFAFBB3FCF1A66AEBB571D9882C2";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.capturecallback = ::endoperatorsfxondisconnect;
  var_0.activatecallback = ::endofmatchdatasent;
  var_0.destroycallback = ::endprematchskydiving;
  var_0.ingame = ::endptui;
  var_0.destroyoncapture = 1;
}

endoperatorsfxondisconnect(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_B29F0BB0BA576E58532DEBDF55"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_B29F0BB0BA576E58532DEBDF55")]](var_0);
}

modifydestructibledamage(var_0) {
  var_1 = 4096;
  var_2 = var_0 + (0, 0, var_1);
  var_3 = var_0 + (0, 0, 512);
  level._id_12CE8.plundereventtime = spawnfx(level._effect["_encstr_A7BA1683D86F743F4EA5F9F3BD50FF3E81B17A7AA8DB2E77"], level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher - (0, 0, 60));
  triggerfx(level._id_12CE8.plundereventtime);
  var_4 = dropcrate(undefined, undefined, "_encstr_9B0E1EC458E8D11B95AF27B7E50BC6B2F58E58C6A35A6CB08DD7192BD94B6CCA", var_2, (0, randomfloat(360), 0), var_3);
  var_4.skipminimapicon = 1;
  endround_timescalefactor(var_4);
}

endofmatchdatasent(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_BDE210BD9B1A93C28E955036E84B9DC2A395"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_BDE210BD9B1A93C28E955036E84B9DC2A395")]](var_0);
}

endprematchskydiving(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_85DA0F72482643D63053E4CD57185A6F63"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_85DA0F72482643D63053E4CD57185A6F63")]](var_0);
}

endptui(var_0, var_1) {
  self setscriptablepartstate("_encstr_9BF30C3F2099CCEA7F7793CF6B37", "_encstr_A1A107973D7982FB90", 0);
}

endround_timescalefactor(var_0) {
  var_0 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_99DD1674C3181BAFBE39DAD1A1859B1440A327FF4738A543");
  var_0 setscriptablepartstate("_encstr_A27B0C1A71177AB53E782B6FB870", "_encstr_AB0703DBB9");
  var_0 setscriptablepartstate("_encstr_92C611A9AEB33B7D3293BD0EAFC456B036B737", "_encstr_AB0703DBB9");
}

relic_landlocked_do_explosion(var_0) {
  var_1 = level.script == "_encstr_8CD508CA98A70FAFC01D" && getdvarint("_encstr_AD7D0F43F642C9061B3FB93527E2D3F8ED", 0);
  var_2 = "_encstr_B40101";

  if(var_1)
    var_2 = "_encstr_ADCA1EE262AF98433AA7E1D3D3B3802029CAC97BDEFBF00FA27FBF79F6B95610";
  else if(isDefined(var_0) && var_0 == "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385" && istrue(level._id_12184))
    var_2 = "_encstr_8449205BD23696A32C3997AFC60B9CACC12C1B5BC2D956FA0C62FA13E4BE35EAD93B";
  else if(isDefined(var_0) && var_0 == "_encstr_BAF90BD64BF637B67D3293DB07")
    var_2 = "_encstr_921821C9DDA16923234FA3DB7BC3184058AF56CACFC05520AFE86F21A980137EA3C795";
  else
    var_2 = "_encstr_AAD31BDAD21B2D3AB09CF2D7D8C29C953858B1B6859D95BE0C8CEB26C9";

  return var_2;
}