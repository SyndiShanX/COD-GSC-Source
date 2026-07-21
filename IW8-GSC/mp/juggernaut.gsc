/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\juggernaut.gsc
***********************************************/

init() {
  level.activejuggernauts = [];
  level._id_11B5F = getdvarint("_encstr_829E15EB5EFA713AA3E775432FCA687085B650E6455180", 0);
}

jugg_makejuggernaut(var_0, var_1) {
  var_2 = vehicle_damage_setweaponhitdamagedata(var_0);

  if(!isDefined(var_2)) {
    scripts\mp\hud_message::showerrormessage("_encstr_8BB91F91EF844C67F9220D074CA1D734257F69B93F61C46510DB18BED758CF9C5D");
    return 0;
  }

  var_3 = var_2 != self getstance();
  self.isjuggernaut = 1;
  scripts\mp\battlechatter_mp::disablebattlechatter(self);
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
  var_4 = spawnStruct();
  var_4.juggconfig = var_0;
  var_4.prevhealth = self.health;
  var_4.prevmaxhealth = self.maxhealth;
  var_4.prevbody = self getcustomizationbody();
  var_4.prevhead = self getcustomizationhead();
  var_4.prevviewmodel = self getcustomizationviewmodel();
  var_4.prevspeedscale = self.playerstreakspeedscale;
  var_4.prevsuit = self.suit;
  var_4.prevclothtype = self.clothtype;
  var_4.maskomnvar = "_encstr_A3B11703EBDF12090389CF0710F8FF0A53740FBFCED50A45CB";
  self.maxhealth = var_0.maxhealth;
  self.health = var_0.startinghealth;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(isDefined(level.headiconbox))
    self[[level.headiconbox]]();

  if(isDefined(var_0.classstruct)) {
    var_5 = scripts\mp\class::respawnitems_saveplayeritemstostruct();
    var_4.respawnitems = var_5;
    var_4.prevclass = self.lastclass;
    var_4.prevclassstruct = self.classstruct;
    scripts\mp\class::loadout_updateclass(var_0.classstruct, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    scripts\mp\class::preloadandqueueclassstruct(var_0.classstruct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", 0, 1);
  }

  self.lastdroppableweaponobj = undefined;

  foreach(var_8, var_7 in var_0.perks)
  scripts\mp\utility\perk::giveperk(var_8);

  if(istrue(self._id_12346)) {
    scripts\mp\playeractions::allowactionset("_encstr_BD2C09BF097845B8ADDF97", 1);
    self._id_12346 = undefined;
  }

  jugg_toggleallows(var_0.allows, 0);
  self skydive_setbasejumpingstatus(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  jugg_setModel();
  self.playerstreakspeedscale = var_0.movespeedscalar;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\player::_setsuit(var_0.suit);
  self setclothtype(var_0.clothtype);
  jugg_enableoverlay(var_4);
  self.juggcontext = var_4;

  if(var_0.infiniteammo)
    thread scripts\mp\utility\weapon::infiniteammothread(var_0.infiniteammoupdaterate);
  else {
    var_9 = self getweaponslistexclusives();

    foreach(var_11 in var_9) {
      self setweaponammoclip(var_11, weaponclipsize(var_11));

      if(vehicle_damage_registervisualpercentcallback()) {
        self givemaxammo(var_11);
        thread vehicle_damage_updatestatemaxhealthvalues(var_11);
      }
    }
  }

  self.streakinfo = var_1;
  self notify("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  thread scripts\mp\gameobjects::onjuggernaut();
  thread vehicle_getturretbyweapon();
  thread jugg_watchmusictoggle();
  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread vehicle_interact_initdev();
  thread vehicle_is_ambient();

  if(vehicle_damage_registerinstance()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  if(isDefined(level.battle_tracks_standingonvehicletimeout))
    self[[level.battle_tracks_standingonvehicletimeout]]();

  if(var_3)
    self setstance(var_2);

  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  vehicle_damage_onexitstatemedium();
  return 1;
}

jugg_removejuggernaut() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = self.juggcontext;
  var_1 = var_0.juggconfig;
  self.musicplaying = undefined;
  jugg_disableoverlay(var_0);
  jugg_toggleallows(var_1.allows, 1);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.maxhealth = var_0.prevmaxhealth;
    self.health = var_0.prevhealth;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

    if(isDefined(var_1.classstruct)) {
      scripts\mp\class::respawnitems_assignrespawnitems(var_0.respawnitems);
      scripts\mp\class::giveloadout(self.team, var_0.prevclass, 0, 1, 1);
    }

    foreach(var_4, var_3 in var_1.perks)
    scripts\mp\utility\perk::removeperk(var_4);
  }

  if(var_1.infiniteammo)
    scripts\mp\utility\weapon::stopinfiniteammothread();

  jugg_restoremodel(var_0);
  self.playerstreakspeedscale = var_0.prevspeedscale;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\player::_setsuit(var_0.prevsuit);
  self setclothtype(var_0.prevclothtype);
  self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(vehicle_damage_registerinstance()) {
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
  }

  self.isjuggernaut = 0;
  self.juggcontext = undefined;
  self.streakinfo = undefined;
  scripts\mp\battlechatter_mp::enablebattlechatter(self);
}

jugg_createconfig(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.maxhealth = 3000;
  var_2.startinghealth = var_2.maxhealth;
  var_2.movespeedscalar = -0.2;
  var_2._id_11B7D = 5;

  if(level.gametype == "_encstr_B607038AAB")
    var_2._id_11B7D = 3;

  var_2.forcetostand = 1;
  var_3 = "_encstr_934212925C82495C700FDF7F3A22E3AB1B11EAC7";

  if(scripts\common\utility::iscp())
    var_3 = "_encstr_AD4212B198122F32AFEFB71AEB90A1F58399CBF3";

  var_2.suit = var_3;
  var_2.infiniteammo = 0;
  var_2.infiniteammoupdaterate = undefined;
  var_2.classstruct = jugg_getdefaultclassstruct();
  var_2.allows = [];
  var_2.allows["_encstr_83290B682399813F110463F9DD"] = 1;
  var_2.allows["_encstr_A9350D834DDE8871B8C7AD38FF21E2"] = 1;
  var_2.allows["_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F"] = 1;
  var_2.allows["_encstr_8E400866D8589B1AB2C8"] = 1;
  var_2.allows["_encstr_8ED90887F39B73AD5BFF"] = 1;
  var_2.allows["_encstr_922406F1A6FD5E05"] = 1;
  var_2.allows["_encstr_BE8F0A272F9B2BE97268AE8B"] = 1;
  var_2.allows["_encstr_BEF4071AA87BDF5220"] = 1;
  var_2.allows["_encstr_85190CAB8B3971B0A4DB2BCAC253"] = 1;
  var_2.allows["_encstr_BD6B06A64C87A9E3"] = 1;
  var_2.allows["_encstr_914C0EDDB20B837BB97D38D2365BAB83"] = 1;
  var_2.allows["_encstr_B24E11E8C140668309413A234F0BE9176B9185"] = 1;
  var_2.allows["_encstr_A91E0E983FF591A981B7D5E64B1BA599"] = 1;
  var_2.allows["_encstr_8A8612E75EAF709F9362F69B8ACB405046B10767"] = 1;
  var_2.perks = [];
  var_2.perks["_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA"] = 1;
  var_2.perks["_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363"] = 1;
  var_2.perks["_encstr_8E2417DC1CCA1BD2B0C647CB7DB5B21B59AC7DE42B9B5AE63A"] = 1;
  var_2.perks["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"] = 1;
  var_2.perks["_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F"] = 1;
  return var_2;
}

jugg_toggleallows(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3) {
      var_4 = tolower(var_4);
      self thread[[level.allow_funcs[var_4]]](var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    }
  }

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    scripts\common\utility::allow_mount_side(var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
  }
}

jugg_getdefaultclassstruct() {
  var_0 = scripts\mp\class::loadout_getclassstruct();
  var_0.loadoutarchetype = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_0.loadoutprimary = "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB";
  var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
  return var_0;
}

vehicle_getturretbyweapon() {
  if(vehicle_damage_registerdefaultvisuals()) {
    var_0 = getdvarint("_encstr_872716E7EF1ED14AB0F9D7D151408D3AF57F071F59CDAA2B", 0);

    if(var_0) {
      var_1 = undefined;

      if(vehicle_damage_updatestate_br(var_0))
        var_1 = "_encstr_840E07CCD8B0DA2B9B";

      if(isDefined(var_1))
        self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", var_1, 0);
    }
  }
}

jugg_watchmusictoggle() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = 0;

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name) && getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0)) {
    return;
  }
  if(!isbot(self) && !isagent(self)) {
    self notifyonplayercommand("_encstr_A54F0D334A2704D0F7F77B73E3DC60", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
    self notifyonplayercommand("_encstr_A54F0D334A2704D0F7F77B73E3DC60", "_encstr_84DB11C20BBACA3B6D9821538F51EB88A108D1");
  }

  var_1 = getcompleteweaponname("_encstr_8D711938CBB05C4FCABB2DFB6FD81B0F4FDF8918CBAFA353B7C8B8");
  var_2 = weaponfiretime(var_1);

  if(!isDefined(self.musicplaying)) {
    var_3 = self getjuggdefaultmusicenabled();
    self.musicplaying = var_3;
  }

  if(!istrue(self.musicplaying))
    self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  else
    self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_813F06832D8A18FE", 0);

  for(;;) {
    self waittill("_encstr_A54F0D334A2704D0F7F77B73E3DC60");

    if(self isonladder() || self ismantling()) {
      continue;
    }
    self giveandfireoffhand(var_1);
    self playsoundonmovingent("_encstr_8D4A19B5C1D7A657763BAFDA5DDCAF8EB7EC9D1BACAFCC7B8D56E5");
    self playlocalsound("_encstr_938A1A9DCB39AAEB047FD7177336710C10B1972581E16AA3E5210F23");
    var_4 = 0.2;

    if(istrue(self.musicplaying))
      var_4 = 0.65;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    } else {
      self.musicplaying = 1;
      self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_813F06832D8A18FE", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

jugg_watchfordeath() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self waittill("_encstr_AD75063D571AE108");
  thread jugg_removejuggernaut();
}

jugg_watchforgameend() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = self.juggcontext;
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self)) {
    self.maxhealth = var_0.prevmaxhealth;
    self.health = var_0.prevhealth;
    jugg_disableoverlay(var_0);
    self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  }
}

jugg_watchfordisconnect() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = self.juggcontext;
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self)) {
    self.maxhealth = var_0.prevmaxhealth;
    self.health = var_0.prevhealth;
  }
}

vehicle_interact_initdev() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");

    if(isDefined(self.streakinfo) && isDefined(self.streakinfo.shots_fired))
      self.streakinfo.shots_fired++;
  }
}

vehicle_damage_registerdefaultvisuals() {
  var_0 = 0;
  var_1 = getdvarint("_encstr_81DF1613A7F0B1C3D5990A7121AC37351877B98B3F20C2FF", 0);

  if(scripts\mp\utility\game::matchmakinggame() || var_1)
    var_0 = 1;

  return var_0;
}

jugg_getjuggmodels() {
  var_0 = [];
  var_0["_encstr_AD9B0589ED9197"] = "_encstr_8897204CF6325EFAED07337B271BCAF53557B33BB2E473B05747BE5B07AF8DB72398";
  var_0["_encstr_81CC0586952C91"] = "_encstr_8B9B181A565819D7DBE066ED936C56AF355D9D9D2B277385BA1D";

  if(vehicle_damage_registerdefaultvisuals()) {
    var_1 = getdvarint("_encstr_872716E7EF1ED14AB0F9D7D151408D3AF57F071F59CDAA2B", 0);

    if(var_1) {
      if(vehicle_damage_updatestate_br(var_1)) {
        var_2 = ["_encstr_91D12BD0C7D34AB9183F2FB073794ADDBB11612547CB132D4B34DC9B1FEA8B3B977D38E038CCD7FDC54F42E13B", "_encstr_91D12BD0C7D34AB9183F2FB073794ADDBB11612547CB132D4B34DC9B1FEA8B3B977D38E038CCD7FDC54F4AE13B"];
        var_0["_encstr_81CC0586952C91"] = var_2[randomint(var_2.size)];
      }
    }
  }

  var_0["_encstr_9601059D5AB2EE"] = "_encstr_AF601D0348D5B77478A5E4FB2FE0BA2B0883EABA163AF7EF70AB0AFE6B68C3";
  return var_0;
}

jugg_setModel() {
  var_0 = jugg_getjuggmodels();

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  var_1 = var_0["_encstr_AD9B0589ED9197"];
  var_2 = var_0["_encstr_81CC0586952C91"];
  var_3 = var_0["_encstr_9601059D5AB2EE"];
  self setModel(var_1);
  self setviewmodel(var_3);
  self attach(var_2, "_encstr_B40101", 1);
  self.headmodel = var_2;
}

jugg_restoremodel(var_0) {
  self.operatorcustomization = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(var_0.prevbody, var_0.prevhead);
    scripts\mp\teams::setcharactermodels(var_0.prevbody, var_0.prevhead, var_0.prevviewmodel);
  }
}

vehicle_damage_setweaponhitdamagedata(var_0) {
  var_1 = undefined;
  var_2 = self getstance();

  if(var_2 != "_encstr_A5AD069B231F0BAF") {
    var_3 = !istrue(var_0.forcetostand) && !isDefined(var_0.allows["_encstr_B13D076BED70539F23"]) || istrue(var_0.allowcrouch);
    var_4 = !istrue(var_0.forcetostand) && !isDefined(var_0.allows["_encstr_922406F1A6FD5E05"]) || istrue(var_0.allowprone);
    var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 0);

    if(!var_3 && !var_4)
      var_1 = "_encstr_A5AD069B231F0BAF";
    else if(var_2 == "_encstr_B13D076BED70539F23") {
      if(!var_3) {
        var_6 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::round_smoke_logic("_encstr_A5AD069B231F0BAF"), self, var_5);

        if(var_6)
          var_1 = "_encstr_A5AD069B231F0BAF";
      } else
        var_1 = "_encstr_B13D076BED70539F23";
    } else if(var_2 == "_encstr_922406F1A6FD5E05") {
      if(!var_4) {
        if(var_3) {
          var_7 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::round_smoke_logic("_encstr_B13D076BED70539F23"), self, var_5);

          if(var_7)
            var_1 = "_encstr_B13D076BED70539F23";
        } else {
          var_6 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::round_smoke_logic("_encstr_A5AD069B231F0BAF"), self, var_5);

          if(var_6)
            var_1 = "_encstr_A5AD069B231F0BAF";
        }
      } else
        var_1 = "_encstr_922406F1A6FD5E05";
    }
  } else
    var_1 = "_encstr_A5AD069B231F0BAF";

  return var_1;
}

jugg_enableoverlay(var_0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8111084A907F4CEF60B0");
  self setclientomnvar(var_0.maskomnvar, 1);
  self.juggoverlaystatelabel = "_encstr_8111084A907F4CEF60B0";
  self.juggoverlaystate = 1;
  thread jugg_watchoverlaydamagestates(var_0);
  thread jugg_watchforoverlayexecutiontoggle(var_0);
}

jugg_watchoverlaydamagestates(var_0) {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.health;
  var_2 = var_1 - var_1 * 0.1;
  var_3 = var_1 - var_1 * 0.35;
  var_4 = var_1 - var_1 * 0.6;
  var_5 = var_1 - var_1 * 0.85;
  var_6 = 1;
  var_7 = var_6;
  var_8 = "_encstr_8111084A907F4CEF60B0";

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_B2BE0788BAF573592F", "_encstr_91D212A8FF87DA0F68274FB5BBE9AF3D25942788");

    if(self.health <= var_5) {
      var_8 = "_encstr_825E15B802DFBAF11F6123338F872976733A13A04AEF61";
      var_6 = 5;
    } else if(self.health <= var_4) {
      var_8 = "_encstr_83D41161B917B05FFFFA98F07257A72897277B";
      var_6 = 4;
    } else if(self.health <= var_3) {
      var_8 = "_encstr_B2DC109A7FAFB747A9F398864F02C8C8E868";
      var_6 = 3;
    } else if(self.health <= var_2) {
      var_8 = "_encstr_BDDC100ACE8F0A87ECB8F51AAFF2278AE8BF";
      var_6 = 2;
    } else {
      var_8 = "_encstr_8111084A907F4CEF60B0";
      var_6 = 1;
    }

    if(var_7 != var_6) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", var_8);
      self setclientomnvar(var_0.maskomnvar, var_6);
      var_7 = var_6;
      self.juggoverlaystatelabel = var_8;
      self.juggoverlaystate = var_6;
    }
  }
}

jugg_watchforoverlayexecutiontoggle(var_0) {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;

  for(;;) {
    if(!self isinexecutionattack()) {
      if(istrue(var_1)) {
        scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", self.juggoverlaystatelabel);
        self setclientomnvar(var_0.maskomnvar, self.juggoverlaystate);
        var_1 = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_1)) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA19049F4B2D");
      self setclientomnvar(var_0.maskomnvar, -1);
      var_1 = 1;
    }

    waitframe();
  }
}

jugg_disableoverlay(var_0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA19049F4B2D");
  self setclientomnvar(var_0.maskomnvar, 0);
  self.juggoverlaystatelabel = undefined;
  self.juggoverlaystate = undefined;
}

jugg_getmovespeedscalar() {
  return -0.2;
}

vehicle_damage_setweaponclassmoddamageforvehicle() {
  return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

vehicle_damage_registervisualpercentcallback() {
  return istrue(self.juggcontext.juggconfig._id_14092);
}

vehicle_damage_setdeathcallback() {
  return istrue(self.juggcontext.juggconfig._id_140A7);
}

vehicle_damage_updatestatemaxhealthvalues(var_0) {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self getweaponammostock(var_0);
  thread vehicle_isenemytoplayer(var_0, var_1);
  thread vehicle_has_flare(var_0, var_1);

  for(;;) {
    self waittill("_encstr_8D4510D7B083E4DA4B0D3925E1C3EDF002B2");
    self setweaponammostock(var_0, var_1);
  }
}

vehicle_isenemytoplayer(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(self isbnetkr15player()) {
      var_2 = self getweaponammostock(var_0);

      if(var_2 < var_1)
        self notify("_encstr_8D4510D7B083E4DA4B0D3925E1C3EDF002B2");
    }

    waitframe();
  }
}

vehicle_has_flare(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_2 = self getweaponammoclip(var_0);

    if(var_2 == 0) {
      var_3 = self getweaponammostock(var_0);

      if(var_3 < var_1)
        self notify("_encstr_8D4510D7B083E4DA4B0D3925E1C3EDF002B2");
    }

    waitframe();
  }
}

vehicle_damage_onexitstatemedium() {
  if(!isDefined(level.activejuggernauts))
    level.activejuggernauts = [];

  level.activejuggernauts[level.activejuggernauts.size] = self;
  thread vehicle_invalid_seats();
}

vehicle_invalid_seats() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(["_encstr_88B00FB037873113F3557705AB596B58EC", "_encstr_8D820B49520F0EC02DDE6367EC"]);
  vehicle_getteamfriendlyto();
}

vehicle_getteamfriendlyto() {
  if(!isDefined(self))
    level.activejuggernauts = scripts\engine\utility::array_removeundefined(level.activejuggernauts);
  else
    level.activejuggernauts = scripts\engine\utility::array_remove(level.activejuggernauts, self);
}

vehicle_is_ambient() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.juggcontext.juggconfig;
  var_0.spawn_all_unique_drones = 0;

  for(;;) {
    self waittill("_encstr_849712177D026227AE4D01C0E54B2817070E5748");

    if(!istrue(var_0.spawn_all_unique_drones)) {
      var_0.spawn_all_unique_drones = 1;
      self radiusdamage(self.origin, 500, 2000, 500, self, "_encstr_8D4E0A501FCB898912CB3FA3");
      thread vehicle_getturrets(var_0);
    }
  }
}

vehicle_getturrets(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setscriptablepartstate("_encstr_8C7A0C9C356D7AD4B82837F380B2", "_encstr_AB0703DBB9", 0);
  wait 1;
  self setscriptablepartstate("_encstr_8C7A0C9C356D7AD4B82837F380B2", "_encstr_BA19049F4B2D", 0);
  var_0.spawn_all_unique_drones = 0;
}

vehicle_deletenextframe() {
  if(self isskydiving())
    self skydive_interrupt();

  self notify("_encstr_849712177D026227AE4D01C0E54B2817070E5748");
  return 0;
}

vehicle_deregister_on_death(var_0, var_1) {
  var_2 = self.maxhealth;
  var_3 = self.juggcontext.juggconfig;
  var_4 = 0.5;
  var_5 = 10;

  if(isDefined(var_1) && isexplosivedamagemod(var_1)) {
    var_4 = 7;
    var_5 = var_3._id_11B7D;
  }

  var_6 = var_0 * var_4;
  var_7 = var_2 / var_5;
  var_8 = scripts\mp\utility\script::roundup(min(var_7, var_6));
  return int(var_8);
}

vehicle_deletenextframelate(var_0) {
  return int(var_0 / 2);
}

vehicle_damage_registerinstance() {
  var_0 = 0;
  var_1 = 0;

  if(var_1 || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping())
    var_0 = 1;

  return var_0;
}

vehicle_damage_updatestate_br(var_0) {
  return istrue(level.setplayerselfrevivingextrainfo) && var_0 == 1;
}

changecirclestateatlowtime() {
  if(istrue(level._id_11B5F) && level.activejuggernauts.size > 0) {
    var_0 = 0;
    var_1 = level.activejuggernauts.size;

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = level.activejuggernauts[var_2];

      if(isDefined(var_3) && self.team == var_3.team)
        var_0++;
    }

    if(var_0 >= level._id_11B5F)
      return 1;
  }

  return 0;
}