/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\potg_events.gsc
***********************************************/

init() {
  if(!level.potgenabled) {
    return;
  }
  level.potgglobals.eventdata = spawnStruct();
  var_0 = level.potgglobals.eventdata;
  var_0.lastkillearner = undefined;
  var_0.lastkilltime = undefined;

  if(level.teambased) {
    var_0.lastteamkillearners = [];
    var_0.lastteamkilltimes = [];
  }
}

onpotgrecordingstopped() {
  clearshotgroup();
}

getentityeventdata() {
  var_0 = scripts\mp\potg::getentitypotgdata(self);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.trackingdata))
    var_0.trackingdata = createentityeventdata();

  return var_0.trackingdata;
}

createentityeventdata() {
  var_0 = spawnStruct();
  var_0.shotgroupactive = 0;
  var_0.shotgroupcount = 0;
  var_0.shotgroupaccuracy = 0;
  var_0.shotgrouplastcount = 0;
  var_0.shotgrouplastaccuracy = 0;
  return var_0;
}

onroundended(var_0) {
  var_1 = level.potgglobals.eventdata;
  handlefinalkill(var_0);
}

handlefinalkill(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = level.potgglobals.eventdata;
  var_2 = undefined;
  var_3 = undefined;

  if(level.teambased) {
    if(isDefined(var_1.lastteamkillearners[var_0])) {
      var_2 = var_1.lastteamkillearners[var_0];
      var_3 = var_1.lastteamkilltimes[var_0];
    } else {
      var_2 = var_1.lastkillearner;
      var_3 = var_1.lastkilltime;
    }
  } else {
    var_2 = var_1.lastkillearner;
    var_3 = var_1.lastkilltime;
  }

  if(isDefined(var_2) && isDefined(var_3))
    var_2 scripts\mp\potg::processevent("_encstr_87050B09527B0FD861DB7B79F4", var_3);
}

onplayerdamaged(var_0, var_1, var_2) {
  if(!level.potgenabled) {
    return;
  }
  if(scripts\common\utility::getdamagetype(var_2) == "_encstr_8AC9070B9918264FB3" && !var_1 scripts\mp\utility\game::isspawnprotected())
    var_1 scripts\mp\potg::processevent("_encstr_A36D11D02DE8BE31BCEBB23C0763B73796B359");
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level.potgenabled) {
    return;
  }
  var_6 = level.potgglobals.eventdata;
  var_7 = gettime();

  if(!isPlayer(var_0)) {
    return;
  }
  var_8 = var_0 getentityeventdata();
  var_9 = var_2 getentityeventdata();
  var_10 = var_0 calckillmultiplier(var_0);
  var_11 = var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F";
  var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1);
  var_13 = physics_raycast(var_0 getEye(), var_2 getEye(), var_12, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);
  var_14 = isDefined(var_13) && var_13.size > 0;
  var_15 = scripts\engine\utility::within_fov(var_0 getEye(), var_0 getplayerangles(), var_2.origin, cos(80));
  var_16 = var_4.basename == "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920";
  var_17 = (var_16 || var_11) && (!var_15 || var_14);

  if(!var_17)
    var_0 scripts\mp\potg::processevent("_encstr_ABD70578F3D02C", var_7, var_7, var_5, undefined, var_10);

  if(isDefined(self.prevlastkilltime) && isDefined(var_0.lastspawntime)) {
    if(var_0.lastspawntime < self.prevlastkilltime) {
      var_18 = var_7 - self.prevlastkilltime;

      if(var_18 < 1800) {
        var_19 = 1.0 - var_18 / 1800;
        var_0 scripts\mp\potg::processevent("_encstr_B88D1018E2C35991FA01B19B17A64810CF3B", self.prevlastkilltime, var_7, var_5, undefined, var_19);
      }
    }
  }

  var_0 handlekillmodifiers(var_0, var_3, var_4, var_2, var_10, var_5);

  if(var_3 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" && !var_16)
    var_0 scripts\mp\potg::processevent("_encstr_8EA71408326F26D08DF53767087568EEEBC94030CA4B", var_7, var_7, var_5, undefined, var_10);

  if(scripts\common\utility::getdamagetype(var_3) == "_encstr_8AC9070B9918264FB3") {
    if(scripts\mp\utility\game::gettimepassed() <= 12000 && randomintrange(0, 2) == 0)
      var_0 scripts\mp\potg::processevent("_encstr_8A0714FB4267988871D37153FA6389D4931AF0015A9F");
  }

  if(istrue(var_0.modifiers["_encstr_A6790E3AB329937F888F5C21935887FF"]) && var_2 scripts\mp\equipment\molotov::molotov_is_burning())
    var_0 scripts\mp\potg::processevent("_encstr_8A510F73E4A360731AAF073D97924B987D", var_7, var_7, var_5, undefined, var_10);

  if(var_0 scripts\mp\equipment\molotov::molotov_is_burning())
    var_0 scripts\mp\potg::processevent("_encstr_8D2B136B28B9B1067F73A7936B4F101BC94CCF3255", var_7, var_7, var_5, undefined, var_10);

  if(istrue(var_0.modifiers["_encstr_A64409C2D29C4CED93B9B2"])) {
    var_8.lastinairkilltime = var_7;
    var_8.inairsincelastkill = 1;
    var_0 thread watchforpostkilllanding();
  }

  if(isDefined(var_0.lastdooropentime) && var_7 - var_0.lastdooropentime < 3500)
    var_0 scripts\mp\potg::processevent("_encstr_845A16C0325540987AFF97B52742DD48E70A095E1CB188C9", var_0.lastdooropentime, var_7, var_5, undefined, var_10);

  if(isDefined(var_0.attackerdata) && var_0.attackerdata.size > 3)
    var_0 scripts\mp\potg::processevent("_encstr_A6B10CB730A3C52D6B85FD2B3D91", var_7, var_7, var_5, undefined, var_10);

  if(isDefined(var_9.lastteabagtime) && var_7 - var_9.lastteabagtime < 1000 && randomintrange(0, 2) == 0)
    var_0 scripts\mp\potg::processevent("_encstr_8B200F802472B0BE1839936892609F3D5B", var_9.lastteabagtime, var_7, var_5, undefined, var_10);

  var_0 handleequipmentkills(var_0, var_1, var_2, var_3, var_4, var_10);
  var_0 handlemeleekills(var_0, var_1, var_2, var_3, var_4, var_10, var_5);

  if(var_8.shotgroupactive) {
    if(var_8.shotgroupaccuracy >= 0.9)
      var_0 scripts\mp\potg::processevent("_encstr_AFF20E4A8E2AE3E22AB938A749C808C5", var_7, var_7, var_5, undefined, var_10);
    else if(var_8.shotgroupaccuracy <= 0.075)
      var_0 scripts\mp\potg::processevent("_encstr_A52012875101B3BEC0C15B79933A9EE00FD383E9", var_7, var_7, var_5, undefined, var_10);
    else if(var_8.shotgroupaccuracy <= 0.15)
      var_0 scripts\mp\potg::processevent("_encstr_A6AB0D46974E8F56023F5B975A3F67", var_7, var_7, var_5, undefined, var_10);
  }

  if(level.teambased) {
    var_6.lastteamkillearners[var_0.team] = var_0;
    var_6.lastteamkilltimes[var_0.team] = var_7;
  }

  var_6.lastkillearner = var_0;
  var_6.lastkilltime = var_7;
}

calckillmultiplier(var_0) {
  var_1 = 1.0;

  if(!istrue(var_0.modifiers["_encstr_9BFB183B4BD81DA5D6FAA537EB373A85CD4616C946FAEC4B2BEE"]))
    var_1 = var_1 * 0.15;

  return var_1;
}

handlemeleekills(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
    if(isDefined(var_0.lastspawntime)) {
      var_7 = isDefined(var_0.lastshotfiredtime) && var_0.lastshotfiredtime >= var_0.lastspawntime;

      if(!var_7)
        var_0 scripts\mp\potg::processevent("_encstr_BA7C147895B9AF482FEBA8D1BB7143CBB2316273AD62", undefined, undefined, var_6, undefined, var_5);
    }
  }
}

handleequipmentkills(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1) && istrue(var_1.isequipment) || scripts\mp\utility\weapon::validatefuelstability(var_4, var_1)) {
    var_6 = scripts\mp\utility\weapon::isthrowingknife(var_4) || scripts\mp\utility\weapon::validatefuelstability(var_4, var_1);

    if(isDefined(var_1.spawnpos)) {
      var_7 = distancesquared(var_1.spawnpos, var_1.origin);

      if(var_6) {
        if(var_7 >= 640000)
          var_0 scripts\mp\potg::processevent("_encstr_9257149BF710527FB81892DD13B886AA60170B075DCD");
        else
          var_0 scripts\mp\potg::processevent("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D");
      } else if(var_7 >= 1440000)
        var_0 scripts\mp\potg::processevent("_encstr_B69E136CDF70DF77BC5B4AC20105D799F8B90AE777");
    }

    if(scripts\mp\utility\game::gettimepassed() <= 12000) {
      if(var_6 && level.mapname != "_encstr_A2200CDA13D6CBC897E1A0EBAA93")
        var_0 scripts\mp\potg::processevent("_encstr_9BD81B4E7BD5E6C8F59B8E16E4D1FA3A864EDEDDD2CDECBED6DCA5332B");
    }
  }
}

handlekillmodifiers(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();
  var_7 = scripts\mp\utility\weapon::getweapongroup(var_2);

  foreach(var_10, var_9 in var_0.modifiers) {
    switch (var_10) {
      case "_encstr_A13C0913C2C6B5CD470B31":
        if(var_1 == "_encstr_8DED0A21C79B660BC7588981")
          var_0 scripts\mp\potg::processevent("_encstr_A13C0913C2C6B5CD470B31", var_6, var_6, var_5, undefined, var_4);

        break;
      case "_encstr_A90B0B68C75085F316A022DA28":
        if(var_7 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33")
          var_0 scripts\mp\potg::processevent("_encstr_97C212BFE72F40790E5AA8D802692F1847804D36", var_6, var_6, var_5, undefined, var_4);
        else
          var_0 scripts\mp\potg::processevent("_encstr_A90B0B68C75085F316A022DA28", var_6, var_6, var_5, undefined, var_4);

        break;
      case "_encstr_A64409C2D29C4CED93B9B2":
        if(isDefined(var_0.modifiers["_encstr_AD1904291F7B"])) {
          if(var_7 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33")
            var_0 scripts\mp\potg::processevent("_encstr_BECE191EF3AD6A3F1B28F71778F1FB614798E4D26D15F1732D20EB", var_6, var_6, var_5, undefined, var_4);
          else
            var_0 scripts\mp\potg::processevent("_encstr_BDC912DF344BAD8812E378B1C75C439FA25CC1D1", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      case "_encstr_9A93109B2818746A414F6F473DFE32CAD831":
        if(var_7 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33")
          var_0 scripts\mp\potg::processevent("_encstr_8D0C17DBB3E6D8094D6FF2F09319F7CDE6B5B73AA8A4EF8D6D", var_6, var_6, var_5, undefined, var_4);
        else
          var_0 scripts\mp\potg::processevent("_encstr_9A93109B2818746A414F6F473DFE32CAD831", var_6, var_6, var_5, undefined, var_4);

        break;
      case "_encstr_B82009D8DBE6D9CDD0B7E8":
        if(!isDefined(var_0.modifiers["_encstr_86500EF327F03197887228922B19E053"]))
          var_0 scripts\mp\potg::processevent("_encstr_B82009D8DBE6D9CDD0B7E8", var_6, var_6, var_5, undefined, var_4);

        break;
      case "_encstr_B4C8115907B3BD71F2CB1028F7CC397A4A5B21":
        if(var_7 != "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" && var_7 != "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195")
          var_0 scripts\mp\potg::processevent("_encstr_B4C8115907B3BD71F2CB1028F7CC397A4A5B21", var_6, var_6, var_5, undefined, var_4);

        break;
      case "_encstr_AB4011F653989B2F397EABA3E3037BD390359F":
        if(var_7 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33")
          var_0 scripts\mp\potg::processevent("_encstr_BAD318134A57ED9895972759C2FCE8B5279289BE738BAB88AF92", var_6, var_6, var_5, undefined, var_4);

        break;
      default:
        if(scripts\mp\potg::eventtable_isevent(var_10))
          var_0 scripts\mp\potg::processevent(var_10, var_6, var_6, var_5, undefined, var_4);

        break;
    }
  }
}

collateral(var_0, var_1) {
  if(!level.potgenabled) {
    return;
  }
  if(var_1 == 2)
    var_0 scripts\mp\potg::processevent("_encstr_B49B0B6CDEC68DC28EAC4E168D");
  else if(var_1 == 3)
    var_0 scripts\mp\potg::processevent("_encstr_88DA12600BA9B361E27916288D4A43FB0D934058");
  else
    var_0 scripts\mp\potg::processevent("_encstr_BEF5119DA8F89B4941BF0805805873A1D36F92");
}

shotguncollateral(var_0, var_1) {
  if(!level.potgenabled) {
    return;
  }
  if(var_1 == 2)
    var_0 scripts\mp\potg::processevent("_encstr_8B8113CD86B7A3D95D737D6CB7C68D58D15993588D");
  else
    var_0 scripts\mp\potg::processevent("_encstr_8262199B1AB78E765DCDBEDAAED8475AAFD8DB8D63C2D1CA4E2CD8");
}

quadfeed(var_0, var_1, var_2) {
  if(!level.potgenabled) {
    return;
  }
  var_0 scripts\mp\potg::processevent("_encstr_A74E0A83F3D19018DA570319", var_1, var_2);
}

processeventforwitnesses(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\common\utility::playersnear(var_0, 1000);

  foreach(var_7 in var_5) {
    if(!scripts\mp\utility\player::isreallyalive(var_7)) {
      continue;
    }
    var_8 = var_0 - var_7 getEye();
    var_9 = anglesToForward(var_7 getplayerangles());

    if(vectordot(var_8, var_9) < 0) {
      continue;
    }
    var_7 scripts\mp\potg::processevent(var_2, var_3, var_4);
  }
}

watchforpostkilllanding() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = getentityeventdata();

  for(;;) {
    if(self isonground()) {
      var_0.inairsincelastkill = 0;
      break;
    }

    waitframe();
  }
}

predatormissileimpact(var_0) {
  if(!level.potgenabled) {
    return;
  }
  processeventforwitnesses(var_0, 1000000, "_encstr_85A818E0D04BA3D74BD7977183AFC1EB74EAC327872771C16F05");
}

largevehicleexplosion(var_0) {
  if(!level.potgenabled) {
    return;
  }
  processeventforwitnesses(var_0, 640000, "_encstr_916818EEB4479B59B96EBE9D56435A6C1B56EBCA87831BBD9195");
}

vehiclekilled(var_0) {
  if(!level.potgenabled) {
    return;
  }
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return;
  }
  var_0.attacker scripts\mp\potg::processevent("_encstr_A97712255F4A7BC8B4870E61AF73A82ED2D78B99");
}

missilewhizby(var_0) {
  if(!level.potgenabled) {
    return;
  }
  var_0 scripts\mp\potg::processevent("_encstr_92A4173B4203F8E01AB3076BC1420833CB3AB6A3BA8F2A10B0");
}

bombdefused(var_0, var_1, var_2) {
  if(!level.potgenabled) {
    return;
  }
  if(var_2)
    var_0 scripts\mp\potg::processevent("_encstr_AF6F0D7833AAA51639898F5A40F28D");
  else if(var_1)
    var_0 scripts\mp\potg::processevent("_encstr_A3BB12A0764390982AF39BBDCF915D50EECBCB19");
  else
    var_0 scripts\mp\potg::processevent("_encstr_830C078CCA33ABB959");
}

revivedplayer(var_0, var_1) {
  if(!level.potgenabled) {
    return;
  }
  var_0 scripts\mp\potg::processevent("_encstr_85CE0DF310F32923837D810651A9EB");
}

playerworlddeath(var_0, var_1) {
  if(!level.potgenabled) {
    return;
  }
  var_2 = getentityeventdata();

  if(istrue(var_2.inairsincelastkill))
    var_0 scripts\mp\potg::processevent("_encstr_990913105B2D50E021E0F6116340B3E4B150B26DC4", var_2.lastinairkilltime, gettime());
}

doorused(var_0, var_1) {
  if(!level.potgenabled) {
    return;
  }
  if(!var_1 && isDefined(var_0.lastkilltime) && gettime() - var_0.lastkilltime < 2000)
    var_0 scripts\mp\potg::processevent("_encstr_850D177703420E90A4114138059A094F6ACBE3DD37EADBE0F4");
}

playerstancechanged(var_0) {
  if(!level.potgenabled || !(isDefined(self.petwatch) && self.petwatch._id_12314 == "_encstr_A7730AAB40E32F3393461E55")) {
    return;
  }
  var_1 = getentityeventdata();
  var_2 = gettime();

  if(var_0 == "_encstr_B13D076BED70539F23") {
    scripts\mp\potg::processevent("_encstr_86B10E78BA363B382B5FB63677F741E9");

    if(isDefined(self.lastkillvictimpos)) {
      if(distancesquared(self.lastkillvictimpos, self.origin) < 40000) {
        var_3 = var_2 - self.laststancetimes["_encstr_B13D076BED70539F23"];

        if(var_3 < 750) {
          var_4 = isDefined(self.lastspawntime) && (isDefined(var_1.lastteabagtime) && self.lastspawntime < var_1.lastteabagtime);

          if(!var_4)
            scripts\mp\potg::processevent("_encstr_8471078E9558C4C2EC");

          if(!isDefined(var_1.lastteabagtime) || var_2 - var_1.lastteabagtime > 5000) {
            if(!isDefined(self.pers["_encstr_8A14081CD5496B0697C8"]))
              self.pers["_encstr_8A14081CD5496B0697C8"] = 0;

            self.pers["_encstr_8A14081CD5496B0697C8"]++;
            scripts\cp_mp\pet_watch::bearwatch();
          }

          var_1.lastteabagtime = var_2;
        }
      }
    }
  } else if(var_0 == "_encstr_922406F1A6FD5E05")
    scripts\mp\potg::processevent("_encstr_AC2C0D39CA8DB237E8F5C139EDB9B2");
}

shothit() {
  if(!level.potgenabled) {
    return;
  }
  var_0 = getentityeventdata();
  updateshotgroup(1);
}

shotmissed() {
  if(!level.potgenabled) {
    return;
  }
  var_0 = getentityeventdata();
  updateshotgroup(0);
}

updateshotgroup(var_0) {
  if(!level.potgenabled) {
    return;
  }
  var_1 = getentityeventdata();
  var_2 = scripts\engine\utility::ter_op(var_0, 1.0, 0.0);
  var_1.shotgroupaccuracy = (var_1.shotgroupaccuracy * var_1.shotgroupcount + var_2) / (var_1.shotgroupcount + 1);
  var_1.shotgroupcount++;
  thread shotgroupendwatcher();
}

shotgroupendwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_83F40FC629EB325A47708793711B0F3B99");
  self notify("_encstr_912D1688B37F838723254DD7B73A192FD97B80C8EF1A5013");
  self endon("_encstr_912D1688B37F838723254DD7B73A192FD97B80C8EF1A5013");

  if(!level.potgenabled) {
    return;
  }
  var_0 = getentityeventdata();
  var_0.shotgroupactive = 1;
  wait 2.0;
  clearshotgroup();
}

clearshotgroup() {
  if(!level.potgenabled) {
    return;
  }
  var_0 = getentityeventdata();
  var_0.shotgroupactive = 0;
  var_0.shotgrouplastcount = var_0.shotgroupcount;
  var_0.shotgrouplastaccuracy = var_0.shotgroupaccuracy;
  var_0.shotgroupcount = 0;
  var_0.shotgroupaccuracy = 0;
  self notify("_encstr_83F40FC629EB325A47708793711B0F3B99");
}

grenadethrownevent(var_0) {
  if(!level.potgenabled) {
    return;
  }
  if(var_0)
    scripts\mp\potg::processevent("_encstr_92960E27B2B1B2CDD1F51B5947A1161B");
  else
    scripts\mp\potg::processevent("_encstr_841A104EB2B159733AAFD1B0B1A396C658D8");
}

crouch() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("_encstr_86B10E78BA363B382B5FB63677F741E9");
}

jump() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("_encstr_9BE70C7B709F0FEBC3E82A4D992B");
}

prone() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("_encstr_AC2C0D39CA8DB237E8F5C139EDB9B2");
}

slide() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("_encstr_AC870D1BF8B9BD3A094832ED4BC142");
}

mantle() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("_encstr_8BBD0E1655BF99E523B12058BA7BA9D1");
}