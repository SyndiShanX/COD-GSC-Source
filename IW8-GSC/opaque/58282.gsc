/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58282.gsc
***********************************************/

_id_11ED7() {
  level._effects["_encstr_9A7116E6BC82F71D5FC86299F08713FBB9886B6BCE284BA0"] = loadfx("_encstr_BD2831933ABBC0189370FFFD42ED20BFB7A2EB58D25708182B0D8DE97D3550F44B79A0A04B8F4850450D8DE15F0AB046EB42FA");
  level._effect["_encstr_96121BDB7183BF1E881BB5BF0D88A3B325CE62A2F9D19F598073B19CD1"] = loadfx("_encstr_954F43B319EB66845899AF9AE5724CEF1911AA1A88C407FE388FB769C3B085E7B30912114B909FF5B0E7966EC1A11E7B46E60AEA31797FEA6B7787749738258785B8E2221A");
  level._effect["_encstr_BDA120EBD40B189DE383B971E7B8F0C8B53223D72B9810094D295B44E5C9EF60E228"] = loadfx("_encstr_ABCA4667CC1E7996EE70AF89C9CB4BB9B1C2B919E5DDCAB038E5EB2DD6C197D82CE6CDB4B94795275E3BCC1EAF3193667DC6B0E62DB93A2B397DAC0F1CEBB1B0E4EC957D6C34ACAD");
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_92440CFD4F8310B8DBFAAB30B227", "_encstr_A2F6108A20351B4869FF5E519D3813E3551B", ::spawn_juggernauts_hangar);
  scripts\mp\utility\sound::besttime("_encstr_B28C183893EDA97D31EA8DD8ACD1AF6C86565BFAC9DE5773C8CD");
  test_bag_pickup();
  level thread _id_11ED8();
}

test_bag_pickup() {
  if(!isDefined(level.getserverroomspawnpoint)) {
    level.getserverroomspawnpoint = spawnStruct();
    level.getserverroomspawnpoint.plunder_economy_shapshot_loop = [];
  }

  level.getserverroomspawnpoint._id_127E0 = getdvarfloat("_encstr_A736226ED893AF6C4395ADFA277BEA37C8B97D1CDE4BCDB7CD9519AF32EA9C5847967BCD", 5);
  level.getserverroomspawnpoint.plunder_awarded_by_missions_total = getdvarfloat("_encstr_833623E0F70A9EB7EA3FE9F8D2B2D3E044DFF9C867A3566F52A5DD7DE1DAD329AD7BC06BDF", 10);
  level.getserverroomspawnpoint.plunder_getleveldataforrepository = getdvarfloat("_encstr_998A2468C26A4791A36DB9B852979B9D576B91409A420F495F9DB7AC5D2F63433A314048129C", 5);
  level.getserverroomspawnpoint._encstr_AFCA251A41D60F6F705BE9F75359B22FFE3EA36269A2576668A3EEEC0FA0BBB325105BBAB00D2B = getdvarfloat("_encstr_A1EF35584FB2567F32F711300A7A6BB80C97B13BAF6BEE39CA9D1F242791A981628F70F81F1BA6EB728780B5B1EAFB68CC2FD8485FADDB", 5);
  level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer = getdvarint("_encstr_A9A11F6E1B4EAF8DD0CAB6BE39DBBA73466EAFB32C37FA1B36DEEA19BEE6969EAC", 180);
  level.getserverroomspawnpoint._encstr_A7521141F6C349067A7F2319A7625DB06F0CAB = getdvarint("_encstr_A3EB214B867B4FF6F908CAE198DFAB5351769FD72FE307BE8940734A0909E70769533C", 96);
}

_id_11ED8() {
  waitframe();

  if(getdvarint("_encstr_86F628CD8D27D71BA5A3CB7DB55AD8635627FADCDED9587D93B7ABB946E6FAD80DB04B73D7B11B7B578C", 0) == 1)
    level.brjugg_watchtimerstart = 1;

  level._id_12074 = ::_id_1447F;
  level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(::gettacroverspawns, level);
  level._id_120AE _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(::getteamcarriedplunder, level);
  level._id_1203F = ::spawn_juggernauts_hangar;
}

spawn_juggernauts_hangar(var_0, var_1, var_2, var_3) {
  if(istrue(var_0.should_take_damage) || istrue(var_0.waittill_trigger_player) || istrue(var_3)) {
    if(isDefined(var_1)) {
      if(isDefined(var_2)) {
        var_4 = easepower("_encstr_93981A8335CB9F2F7841A81FC0DFCDCA7B1BCF43E2A7682B897BEB5B", var_1);
        var_4 thread _id_12AAB(1.0);

        if(!istrue(var_2.updateteamplunderscore)) {
          if(isPlayer(var_2)) {
            stopfxontagforclients(level._effects["_encstr_9A7116E6BC82F71D5FC86299F08713FBB9886B6BCE284BA0"], var_2, "_encstr_AADA07DBF19A4A81D7", var_2);
            playfxontagforclients(level._effects["_encstr_9A7116E6BC82F71D5FC86299F08713FBB9886B6BCE284BA0"], var_2, "_encstr_AADA07DBF19A4A81D7", var_2);
          }

          var_2.updateteamplunderscore = 1;

          if(isDefined(self))
            self playlocalsound("_encstr_957D2022C70BA54A9891EF1897823E2A7B789238E95BD964991B88ABB975DBD7C0E7");
        }

        var_2 thread _id_1447F(var_0);
      }
    }
  }
}

_id_12AAB(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  self freescriptable();
}

_id_1447F(var_0, var_1) {
  if(isPlayer(self) || isbot(self))
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8FE41C8368334755E053C4F75FB0DB5FEBC01A7AF61CFFCA9149FDD121A0");
  self endon("_encstr_8FE41C8368334755E053C4F75FB0DB5FEBC01A7AF61CFFCA9149FDD121A0");
  var_2 = level.getserverroomspawnpoint._id_127E0;

  if(isDefined(var_1))
    var_2 = var_1;

  if(var_2 > 0) {
    var_3 = scripts\engine\utility::_id_143B9(level.getserverroomspawnpoint._id_127E0, "_encstr_AD75063D571AE108");

    if(var_3 == "_encstr_995408F398012F656821") {
      if(isPlayer(self)) {
        stopfxontagforclients(level._effects["_encstr_9A7116E6BC82F71D5FC86299F08713FBB9886B6BCE284BA0"], self, "_encstr_AADA07DBF19A4A81D7", self);
        self.updateteamplunderscore = 0;
      }

      return;
    }
  } else
    self waittill("_encstr_AD75063D571AE108");

  if(isPlayer(self)) {
    stopfxontagforclients(level._effects["_encstr_9A7116E6BC82F71D5FC86299F08713FBB9886B6BCE284BA0"], self, "_encstr_AADA07DBF19A4A81D7", self);
    self.updateteamplunderscore = 0;
  }

  var_4 = self.origin;
  var_5 = easepower("_encstr_AAA518472083F5B327A87D33077FEBB74B8093DFD9193D1AA330", var_4);
  var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer, level.getserverroomspawnpoint._encstr_A7521141F6C349067A7F2319A7625DB06F0CAB);
  var_6.attacker = var_0;
  waitframe();
  var_7 = easepower("_encstr_8A571CCB62E350E0EC95335FAA1568803BAB66D18ACFF1F8C96C3B1BB4BC", var_4);
  var_5 setscriptablepartstate("_encstr_8F760C8291980722FFAF3F83D196", "_encstr_84320D88B04F2E0796E321C86BEAD9");
  scripts\mp\utility\trigger::makeenterexittrigger(var_6, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5);
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);
  wait(level.getserverroomspawnpoint.plunder_awarded_by_missions_total);
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);

  foreach(var_9 in var_6.triggerenterents) {
    if(var_9 getstreamedinplayercount())
      var_9 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");
  }

  var_5 freescriptable();
  var_6 notify("_encstr_A39613D7DF82B9800A1DE889097A53BE234BF92952");
  var_7 freescriptable();
  var_6 delete();
}

playericonfilter(var_0, var_1, var_2, var_3) {
  var_4 = easepower("_encstr_AAA518472083F5B327A87D33077FEBB74B8093DFD9193D1AA330", var_1);
  var_4 setscriptablepartstate("_encstr_8DDE106E661EFABB95B0077BCD7DC60DCADA", "_encstr_9BC6199F2358B030679908C892270F7BF1FF110F2B8AFD55AB8902");
  var_5 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.getserverroomspawnpoint._encstr_A7521141F6C349067A7F2319A7625DB06F0CAB);
  var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, var_5, var_5);
  var_6.attacker = var_0;
  scripts\mp\utility\trigger::makeenterexittrigger(var_6, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_8A571CCB62E350E0EC95335FAA1568803BAB66D18ACFF1F8C96C3B1BB4BC");

  if(isDefined(var_2) && var_2 == "_encstr_91D208889782ABF71F0B")
    var_7 = "_encstr_91D208889782ABF71F0B";

  if(var_7 != "_encstr_91D208889782ABF71F0B") {
    var_8 = easepower(var_7, var_1);
    var_8 thread _id_12AAB(8.0);
  }

  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);
  wait(level.getserverroomspawnpoint.plunder_awarded_by_missions_total);
  level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove(level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6);

  foreach(var_10 in var_6.triggerenterents) {
    if(var_10 getstreamedinplayercount())
      var_10 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");
  }

  var_6 notify("_encstr_A39613D7DF82B9800A1DE889097A53BE234BF92952");
  var_6 delete();
  var_4 freescriptable();
}

_id_13DAB(var_0, var_1) {
  var_0 thread _id_11C1D(var_1);
}

_id_13DAC(var_0, var_1) {
  var_0.start_coop_escape_safehouse = 0;
  var_0 notify("_encstr_959D14CF9B55990750B64A9568A05FC2B8CF4B5733F5");

  if(isPlayer(var_0) && var_0 getstreamedinplayercount())
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");
}

_id_13DA5(var_0, var_1) {
  if(!isDefined(var_0))
    return 1;

  if(isPlayer(var_0) || isbot(var_0) || isagent(var_0))
    return 0;

  return 1;
}

getstreamedinplayercount() {
  foreach(var_1 in level.getserverroomspawnpoint.plunder_economy_shapshot_loop) {
    if(scripts\engine\utility::array_contains(var_1.triggerenterents, self))
      return 0;
  }

  return 1;
}

_id_11C1D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_A7E21D971F6396FBD125FF1745CF0F8BD1D2486050D7F590284FAFD7BACB47");
  self endon("_encstr_A7E21D971F6396FBD125FF1745CF0F8BD1D2486050D7F590284FAFD7BACB47");
  var_1 = 0;

  for(;;) {
    wait 0.5;

    if(!isDefined(var_0)) {
      break;
    }

    if(!scripts\engine\utility::array_contains(var_0.triggerenterents, self)) {
      break;
    }

    if(isDefined(var_0.attacker) && isDefined(var_0.attacker.team)) {
      if(self.team == var_0.attacker.team && self != var_0.attacker) {
        break;
      }
    }

    if(isDefined(self._encstr_ACBB0DF0C850B7ADAD20B28AF89567) && self._encstr_ACBB0DF0C850B7ADAD20B28AF89567) {
      break;
    }

    if(istrue(self.start_death_from_above_sequence)) {
      if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ks_circlecount(self))
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");

      continue;
    }

    if(scripts\cp_mp\gasmask::hasgasmask(self)) {
      if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ks_circlecount(self))
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrepositoryref("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");

      scripts\cp_mp\gasmask::processdamage(level.getserverroomspawnpoint.plunder_getleveldataforrepository);
    } else {
      if(!_encstr_A7DD1D672710BBD4B882FF027E38E943D39DFBAF972DF2AF788BF44F91483A(var_0, self)) {
        continue;
      }
      if(istrue(level.brjugg_watchtimerstart) && self.health - level.getserverroomspawnpoint.plunder_getleveldataforrepository <= 0) {
        self.updateteamplunderscore = 1;
        thread _id_1447F(var_0.attacker);
      }

      var_2 = scripts\engine\utility::ter_op(isagent(self), level.getserverroomspawnpoint._encstr_AFCA251A41D60F6F705BE9F75359B22FFE3EA36269A2576668A3EEEC0FA0BBB325105BBAB00D2B, 1);
      var_3 = level.getserverroomspawnpoint.plunder_getleveldataforrepository * var_2;

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(var_3);
      else {
        var_4 = var_0.attacker;

        if(!isDefined(var_0.attacker) || isDefined(var_0.attacker.unittype) && var_0.attacker.unittype == "_encstr_BACB074025B01AAA28" && !isalive(var_0.attacker))
          var_4 = self;

        self dodamage(var_3, var_0.origin, var_4, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
      }

      if(isagent(self)) {
        var_5 = easepower("_encstr_93981A8335CB9F2F7841A81FC0DFCDCA7B1BCF43E2A7682B897BEB5B", self.origin + (0, 0, 50));
        var_5 thread _id_12AAB(1.0);
      }

      if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ks_circlecount(self))
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");
    }

    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_13E18();
  }

  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8D8010A9425709412ADF437DFC5279C4EF6B");
}

getsearchparams() {
  self notify("_encstr_9A7A16EEC2A3D886D2B93BD71BD0B2B6FAAD5AB9DCD2B156");
  self endon("_encstr_9A7A16EEC2A3D886D2B93BD71BD0B2B6FAAD5AB9DCD2B156");
  self endon("_encstr_9393189E7067B3A908118B11082B70FF8FAEF315938765AC5319");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0, var_1);

    if(!istrue(self._id_11ED4)) {
      return;
    }
    var_0 thread getserachparams(self);
  }
}

getscrapassistplayers() {
  self notify("_encstr_A9471907A3134E2410D00461F1A84DD536B07B907ABBFFF3688C51");
  self endon("_encstr_A9471907A3134E2410D00461F1A84DD536B07B907ABBFFF3688C51");
  self endon("_encstr_9393189E7067B3A908118B11082B70FF8FAEF315938765AC5319");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1);
    var_2 = weaponinventorytype(var_1.basename);

    if(var_2 != "_encstr_BA7F0830B3A7859B60B0") {
      continue;
    }
    if(!istrue(self._id_11ED4)) {
      return;
    }
    var_0 thread getserachparams(self);
  }
}

getserachparams(var_0) {
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  thread playericonfilter(var_0, var_1);
  var_0 thread _id_13580(var_1);
}

_id_12BE2() {
  wait 0.1;

  if(isDefined(self)) {
    self._id_11ED4 = 0;
    self notify("_encstr_9393189E7067B3A908118B11082B70FF8FAEF315938765AC5319");
  }
}

_id_13580(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  waitframe();
  var_1._id_14293 = playFXOnTag(scripts\engine\utility::getfx("_encstr_BDA120EBD40B189DE383B971E7B8F0C8B53223D72B9810094D295B44E5C9EF60E228"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 = 2;
  wait(level.getserverroomspawnpoint.plunder_awarded_by_missions_total - var_2);
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_BDA120EBD40B189DE383B971E7B8F0C8B53223D72B9810094D295B44E5C9EF60E228"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 delete();
}

_id_11ED6() {
  var_0 = self.lastweaponobj;
  var_1 = isundefinedweapon();

  if(!scripts\mp\weapons::isnormallastweapon(var_0) || scripts\mp\utility\weapon::ismeleeonly(var_0) || scripts\mp\utility\weapon::isgamemodeweapon(var_0) || scripts\mp\utility\weapon::isaxeweapon(var_0) || !getsubgametype(var_0) || getstancetop(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8C9E182193BFABA1BAA9A93599813A6FB979CC017624F3E9A00D");

    return 0;
  }

  self.should_take_damage = 1;
  self._id_11ED4 = 1;
  thread getsearchparams();
  thread getscrapassistplayers();
  var_2 = getsixthsensedirection();

  if(!istrue(var_2))
    return 0;

  if(self isalternatemode(var_0)) {
    var_1 = var_0;
    var_0 = var_0 getnoaltweapon();
  } else
    var_1 = var_0 getaltweapon();

  var_3 = [];
  var_4 = 0;
  var_5 = 0;

  if(!nullweapon(var_1))
    var_3[var_3.size] = var_1;

  var_3[var_3.size] = var_0;

  foreach(var_7 in var_3) {
    var_8 = scripts\mp\utility\weapon::turnexfiltoside(var_7);

    if(isnullweapon(var_7, var_0, 0)) {
      var_9 = scripts\mp\weapons::getammooverride(var_7);
      var_10 = var_9 * 1;

      if(var_8)
        var_10 = var_10 * 2;

      thread getsquadspawnlocations(self, var_7, var_10);

      if(1) {
        if(var_8) {
          var_9 = self getweaponammoclip(var_7, "_encstr_A5AD056A019C63") + self getweaponammoclip(var_7, "_encstr_8253060E2B5FE330");
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_12 = int(min(getspecialdaystickers(var_7, var_11), var_11 + var_10));
          self setweaponammostock(var_7, var_12);
          self setweaponammoclip(var_7, 0, "_encstr_A5AD056A019C63");
          self setweaponammoclip(var_7, 0, "_encstr_8253060E2B5FE330");
        } else {
          var_9 = self getweaponammoclip(var_7);
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_13 = getspecialdaystickers(var_7, var_11);
          var_14 = var_11 + var_10;
          var_5 = int(var_14 - var_13);
          var_15 = int(min(var_13, var_14));

          if(var_7.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
            self setweaponammoclip(var_7, var_9 + var_10);
          else {
            self setweaponammoclip(var_7, 0);

            if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
              var_16 = var_15 - var_4;
              _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_camera_normal(var_7, var_16);
            } else
              self setweaponammostock(var_7, var_15);
          }
        }
      }
    }
  }

  thread getteamplunder(var_0, var_4, var_5);
  return 1;
}

getspecialdaystickers(var_0, var_1) {
  var_2 = var_0.maxammo;

  if(var_1 > var_2)
    var_2 = var_1;

  return var_2;
}

getsubgametype(var_0) {
  if(!self isalternatemode(var_0))
    return 1;

  var_1 = var_0.underbarrel;
  return scripts\mp\weapons::turretoverridefunc(var_1);
}

getstancetop(var_0) {
  switch (var_0.basename) {
    case "_encstr_85EA0D0B1181251728A113CA4E197B":
    case "_encstr_B8F811FFCAE9A908777459915A3940D2813771":
    case "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB":
    case "_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3":
    case "_encstr_A30914AF1FA248DA40A925CB767AA382FFC7EB889ABF":
    case "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C":
      return 1;
  }

  return 0;
}

getteamplunder(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    if(self getcurrentprimaryweapon() != var_0) {
      break;
    }

    var_3 = self getweaponammoclip(var_0);

    if(var_3 > 0) {
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, "_encstr_B6411358B50BAB8E12E7F838D34BC6F9E25EC555CF");
      self setclientomnvar("_encstr_8BFE0E3348C8E77458A3D2E77BE8BF7F", 1);

      if(var_2 > 0)
        self setweaponammostock(var_0, var_1 + var_2);

      break;
    }

    waitframe();
  }

  if(!scripts\mp\supers::issuperinuse())
    waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]]();
}

getsquadspawnlocations(var_0, var_1, var_2) {
  var_3 = init_relic_steelballs(var_0, var_1, var_2);
  getsquadspawnStruct(var_0, var_3);
}

init_relic_steelballs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.player = var_0;
  var_3.objweapon = var_1;
  var_3.rounds = var_2;
  var_3.gavehcr = 0;
  var_3.kills = 0;
  return var_3;
}

getsquadspawnStruct(var_0, var_1) {
  if(!isDefined(var_0.showassassinationtargethud))
    var_0.showassassinationtargethud = [];

  var_2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_1.objweapon);
  var_3 = var_0.showassassinationtargethud[var_2];

  if(isDefined(var_3))
    var_3 thread getteamcontenders();

  var_0.showassassinationtargethud[var_2] = var_1;
  var_1 thread getspawncamerablendtime();
  var_1 thread getspecialdaycamos();
  var_1 thread getspecialdaycosmetics();
  var_1 thread getspreadpelletspershot();
  var_0 thread getsetplundercountdatanosplash();
  var_1 thread getteamplunderhud();
  var_1 thread getteamscoreplacements();
  var_0 thread getscrapassistplayers();
}

gettacroverspawns(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_3 = var_1 getspectatorsofplayer(var_2);

  if(isDefined(var_3)) {
    var_4 = init_relic_steelballs(var_3.player, var_3.objweapon, var_3.rounds);
    var_0.showassassinationtargethud = var_4;
    var_3 thread getteamcontenders();
  }
}

getteamcarriedplunder(var_0, var_1, var_2) {
  var_3 = var_0.showassassinationtargethud;

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_3.player) || !var_3.player hasweapon(var_3.objweapon)) {
    return;
  }
  var_3.player = var_1;
  getsquadspawnStruct(var_1, var_3);
}

getspectatorsofplayer(var_0) {
  if(!isDefined(var_0))
    return undefined;

  if(!isDefined(self.showassassinationtargethud))
    return undefined;

  var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);
  return self.showassassinationtargethud[var_1];
}

getsixthsensedirection() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self cancelreload();
  wait 0.05;
  return 1;
}

getteamplunderhud() {
  self endon("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.post_blockade_combat_logic = 0;

  while(self.player hasweapon(self.objweapon)) {
    if(getstartparachutespawnpoint(self.player getcurrentweapon())) {
      if(!self.post_blockade_combat_logic) {
        self.player scripts\mp\utility\perk::giveperk("_encstr_8D131520BBE707E84FBCED63B77FF0C34D0348E8B27F9F");
        self.player.should_take_damage = 1;
        self.player._id_11ED4 = 1;
        self.post_blockade_combat_logic = 1;
        self.player setclientomnvar("_encstr_8BFE0E3348C8E77458A3D2E77BE8BF7F", 1);
        self.player thread getsearchparams();
        self.player thread getscrapassistplayers();
      }
    } else if(self.post_blockade_combat_logic) {
      self.player scripts\mp\utility\perk::removeperk("_encstr_8D131520BBE707E84FBCED63B77FF0C34D0348E8B27F9F");
      self.player.should_take_damage = 0;
      self.player thread _id_12BE2();
      self.post_blockade_combat_logic = 0;
      self.player setclientomnvar("_encstr_8BFE0E3348C8E77458A3D2E77BE8BF7F", 0);
    }

    self.player waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }

  thread getteamcontenders();
}

getteamscoreplacements() {
  self endon("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0);

    if(getstartparachutespawnpoint(var_0)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  if(isDefined(self)) {
    self.player thread getteamfactionsfrommap(self.objweapon);
    thread getteamcontenders();
  }
}

getteamfactionsfrommap(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self)) {
    return;
  }
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_1 != "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD" && var_1 != "_encstr_A34C12B0EB7A380815D7690B13FA20F68F12C8FB") {
    return;
  }
  self.waittill_trigger_player = 1;
  scripts\engine\utility::_id_143C0(2, "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self.waittill_trigger_player = undefined;
}

getteamcontenders() {
  self notify("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");

  if(isDefined(self.player)) {
    if(istrue(self.post_blockade_combat_logic)) {
      if(isDefined(self.player.perks["_encstr_8D131520BBE707E84FBCED63B77FF0C34D0348E8B27F9F"]))
        self.player scripts\mp\utility\perk::removeperk("_encstr_8D131520BBE707E84FBCED63B77FF0C34D0348E8B27F9F");

      self.player.should_take_damage = 0;
      self.player thread _id_12BE2();
      self.player setclientomnvar("_encstr_8BFE0E3348C8E77458A3D2E77BE8BF7F", 0);
    }

    if(isDefined(self))
      getsolospawnStruct();
  }
}

getsuperrefforsuperextraweapon() {
  self notify("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");

  if(isDefined(self.player))
    getsolospawnStruct();
}

getsolospawnStruct() {
  if(isDefined(self.player.showassassinationtargethud)) {
    var_0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
    var_1 = self.player.showassassinationtargethud[var_0];

    if(isDefined(var_1) && var_1 == self)
      self.player.showassassinationtargethud[var_0] = undefined;

    self.player scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_84970F967582523A388D0230E79940D71E", self.kills);
    self.player setclientomnvar("_encstr_8BFE0E3348C8E77458A3D2E77BE8BF7F", 0);
    self.player.should_take_damage = 0;
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["_encstr_84970F967582523A388D0230E79940D71E"].id, self.kills, 0);
  }
}

getstartparachutespawnpoint(var_0) {
  var_1 = self.player getammotype(self.objweapon);
  var_2 = self.player getammotype(var_0);
  var_3 = var_1 == var_2;
  return isnullweapon(var_0, self.objweapon, 1) && var_3;
}

getspawncamerablendtime() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");
  self.player waittill("_encstr_AD75063D571AE108");
  thread getteamcontenders();
}

getspecialdaycamos() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread getteamcontenders();
}

getspecialdaycosmetics() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");
  self.player waittill("_encstr_ADB9121B6B1A70608D729893D1737895228B9BA9");
  thread getsuperrefforsuperextraweapon();
}

getspreadpelletspershot() {
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.player scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  self.player scripts\engine\utility::_id_143A6("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_85E2193634ACAD4BD858B1A4BD5DE623377DC9596BB7EC2B09D094");
  self.player scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
}

getsetplundercountdatanosplash() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\common\utility::allow_sprint(0);
  wait 0.4;
  scripts\common\utility::allow_sprint(1);
}

_encstr_A7DD1D672710BBD4B882FF027E38E943D39DFBAF972DF2AF788BF44F91483A(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_3 = vectorcross(vectorNormalize(var_0.origin - var_1.origin), anglestoup(var_1.angles));
  var_4 = var_1 getEye();
  var_5 = var_0.origin + (0, 0, level.getserverroomspawnpoint._encstr_A7521141F6C349067A7F2319A7625DB06F0CAB / 2);
  var_6 = [];
  var_6[0] = var_4 + var_3 * 20;
  var_6[1] = var_4 - var_3 * 20;

  foreach(var_8 in var_6) {
    var_9 = physics_raycast(var_5, var_8, var_2, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(!(isDefined(var_9) && var_9.size > 0))
      return 1;

    waitframe();
  }

  return 0;
}