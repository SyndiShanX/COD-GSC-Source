/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_rewards.gsc
***********************************************/

init_br_rewards() {
  processkillstreaksintotiers();
  level.tierrewardcounts = [];
  level.tierrewardcounts[3] = 0;
  level.tierrewardcounts[2] = 0;
  level.tierrewardcounts[1] = 0;
  level.tierrewardcounts[0] = 0;
}

runmissionrewarddelivery(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(!isDefined(var_0.rewardlocation)) {
    var_4 = findclosestdroplocation(var_0);

    if(!isDefined(var_4))
      var_4 = calculatedroplocationnearlocation(var_0, 64, 2048);
  } else
    var_4 = var_0.rewardlocation;

  if(isDefined(var_2))
    thread runkillstreakreward(var_4, var_1, var_2);
  else if(isDefined(var_3))
    thread runkillstreakreward(var_4, var_1, getkillstreak(var_3));
  else
    thread runkillstreakreward(var_4, var_1, getkillstreak(3));
}

runkillstreakreward(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = undefined;

  if(!istrue(var_0.isinside))
    var_4 = 72;
  else
    var_4 = 40;

  var_5 = scripts\mp\gameobjects::createobjidobject(var_0.origin, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, var_4), undefined, "_encstr_9A19040BCDBC");
  maskobjectivetoplayerssquad(var_5, var_1);
  var_5.origin = var_0.origin;
  var_5.angles = var_0.angles;
  thread docratedropsmoke(undefined, var_0, 16);
  var_5.iconname = "_encstr_B6DC0AD75AE636BDAD5AE63B";
  var_5.lockupdatingicons = 0;
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(var_2);
  var_5.lockupdatingicons = 1;
  wait 3;
  wait 1;

  if(!istrue(var_0.isinside)) {
    var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_1.team, var_2, var_0.origin, (0, randomint(360), 0), undefined);
    var_3.skipminimapicon = 1;
    var_3.nevertimeout = 0;
    var_3.waitforobjectiveactivate = 1;
    var_3.killminimapicon = 0;
    var_3.disallowheadiconid = 1;
    var_3.isarmcrate = 1;
    var_3 waittill("_encstr_AA590EF71A80800D1FEAC370EB0FCADD");
    var_5.useobj = var_3;
    var_5.origin = var_3.origin;
  } else {
    var_5.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
    var_5.useobj.disallowheadiconid = 1;
    var_5.useobj.cratetype = "_encstr_91820DA76AAFF6FDFDD94880A217BD";
    var_6 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var_5.useobj.cratetype);
    var_5.useobj.minimapicon = var_6.minimapicon;
    var_5.useobj.capturestring = var_6.capturestring;
    var_5.useobj.rerollstring = var_6.rerollstring;
    var_5.useobj.supportsreroll = var_6.supportsreroll;
    var_5.useobj.isdummyarmcrate = 1;
    var_5.useobj.isarmcrate = 1;
    var_5.useobj.data = scripts\cp_mp\killstreaks\airdrop::getarmcratedatabystreakname(var_2);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_5.objidnum, var_5.useobj);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_5.objidnum, 40);
  }

  var_7 = 0;
  var_8 = 0.1;

  if(istrue(var_0.isinside))
    var_9 = 15;
  else
    var_9 = 1;

  wait(var_9);

  if(!istrue(var_0.isinside)) {
    var_3 notify("_encstr_8FCA13B789D45636E8D2672BEB0BD8E82D67B047CA");
    scripts\mp\objidpoolmanager::update_objective_onentity(var_5.objidnum, var_3);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_5.objidnum, 72);
  } else {
    var_5.useobj scripts\cp_mp\killstreaks\airdrop::makecrateusable();
    var_6 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var_5.useobj.cratetype);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_5.objidnum, 40);
  }

  var_5.iconname = "_encstr_B40101";
  var_5.lockupdatingicons = 0;
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(var_2);
  var_5.lockupdatingicons = 1;
  objective_setlabel(var_5.objidnum, "_encstr_B40101");

  if(isDefined(var_3))
    var_3 waittill("_encstr_AD75063D571AE108");
  else
    var_5.useobj waittill("_encstr_AD75063D571AE108");

  var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_5 scripts\mp\gameobjects::releaseid();
  var_5.visibleteam = "_encstr_8BBA05185F8B99";
}

dropcrate(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_2, var_0, var_1.origin, (0, randomint(360), 0), undefined);
  return var_3;
}

docratedropsmoke(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 2000);
  var_4 = scripts\common\utility::groundpos(var_3, (0, 0, 1));
  var_1.vfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_1.vfxent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.vfxent.angles = (0, 0, 0);
  var_1.vfxent playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"), var_1.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(isDefined(var_0))
    var_0 scripts\engine\utility::_id_143B9(var_2, "_encstr_AA590EF71A80800D1FEAC370EB0FCADD");
  else
    wait(var_2);

  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"), var_1.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.vfxent delete();
}

getkillstreak(var_0) {
  if(!isDefined(level.killstreaktierlist))
    processkillstreaksintotiers();

  level.killstreaktierlist[var_0] = scripts\engine\utility::array_randomize(level.killstreaktierlist[var_0]);
  return level.killstreaktierlist[var_0][0];
}

br_getrandomkillstreakreward() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 10;
  var_7 = 35;
  var_8 = 35;
  var_9 = 20;

  if(isDefined(level.tierrewardcounts[0]) && level.tierrewardcounts[0] < 2 || 0)
    var_0 = var_0 + 10;
  else {
    var_2 = 1;
    var_6 = 0;
  }

  if(isDefined(level.tierrewardcounts[1]) && level.tierrewardcounts[1] < -1 || 1) {
    var_0 = var_0 + 35;

    if(!var_2)
      var_7 = var_7 + 10;
  } else {
    var_3 = 1;
    var_7 = 0;
  }

  if(isDefined(level.tierrewardcounts[2]) && level.tierrewardcounts[2] < -1 || 1) {
    var_0 = var_0 + 35;

    if(!var_2)
      var_8 = var_8 + 10;

    if(!var_3)
      var_8 = var_8 + 35;
  } else {
    var_4 = 1;
    var_8 = 0;
  }

  if(isDefined(level.tierrewardcounts[3]) && level.tierrewardcounts[3] < 15 || 0) {
    var_0 = var_0 + 20;

    if(!var_2)
      var_9 = var_9 + 10;

    if(!var_3)
      var_9 = var_9 + 35;

    if(!var_3)
      var_9 = var_9 + 35;
  } else {
    var_5 = 1;
    var_9 = 0;
  }

  var_10 = randomintrange(1, var_0);

  if(var_10 <= var_6) {
    level.tierrewardcounts[0]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[0]);
    return var_11[0];
  } else if(var_10 <= var_7) {
    level.tierrewardcounts[1]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[1]);
    return var_11[0];
  } else if(var_10 <= var_8) {
    level.tierrewardcounts[2]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[2]);
    return var_11[0];
  } else {
    level.tierrewardcounts[3]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[3]);
    return var_11[0];
  }
}

processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", "_encstr_851904B59B34"];
  level.killstreaktierlist[2] = ["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B", "_encstr_8CC008133958C81BACCB"];
  level.killstreaktierlist[1] = ["_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_851904B59B34", "_encstr_B1B30B51D176511E377A1BC313", "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2"];
  level.killstreaktierlist[0] = ["_encstr_851904B59B34"];
}

br_getrewardicon(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["_encstr_BE6C080DBA2392367BE6"];
}

dropweaponcarepackage(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, undefined, "_encstr_A2D40E260F2983A46129135F20D96C5A", var_0, (0, randomfloat(360), 0), 3000, 3000, var_0, scripts\cp_mp\killstreaks\airdrop::getbrcratedatabytype("_encstr_AC20072B9FA9487832"));

  if(!isDefined(var_1))
    return undefined;
  else if(!isDefined(var_1.crate))
    return undefined;

  return var_1.crate;
}

initdropbagsystem() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.waypointstring["_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9"] = "_encstr_BE15092292E9A0AF12148E";
  level.dropbagstruct = spawnStruct();
  level.dropbagstruct.clusters = scripts\engine\utility::getStructArray("_encstr_8DE1128C27DB831285B33463AED1CA4E9CDE9195", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_0 = scripts\engine\utility::getStructArray("_encstr_933F102AF8B77A6B71E41C278E19FB44CF70", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in level.dropbagstruct.clusters)
  var_2.droplocations = undefined;

  foreach(var_5 in var_0) {
    var_5.inuse = 0;

    foreach(var_2 in level.dropbagstruct.clusters) {
      if(var_5.target == var_2.targetname) {
        if(!isDefined(var_2.droplocations))
          var_2.droplocations = [];

        var_2.droplocations[var_2.droplocations.size] = var_5;
        continue;
      }
    }
  }

  terminal_pusher_approach_entrance_array();
}

terminal_pusher_approach_entrance_array() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_826F118CDE0823461BE83952C8777D2FA04817"] = "_encstr_960D1BA43008803F23F8CB7FC10716B098F6C38F8148BDB2F235B058C8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_961712FAF308035EC01F878105F8A4BBA769F212"] = "_encstr_A5931C82810DFA5FD81163515FBD3B286B190954AE7F74EB7745971348B3";
}

_id_1284D(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_5 = var_4;

  if(var_5 <= 0)
    var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

  var_6 = getarraykeys(level.teamdata);

  foreach(var_8 in var_6) {
    if(level.teamdata[var_8]["_encstr_AB580A05672AE35D5FFF50B8"] > 0) {
      var_9 = 0;
      var_10 = undefined;

      foreach(var_12 in level.teamdata[var_8]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
        if(!isDefined(var_10) && !istrue(var_12.gulag) && !istrue(var_12.unset_relic_gun_game))
          var_10 = var_12;

        if(istrue(var_12.issquadleader) && !istrue(var_12.gulag) && !istrue(var_12.unset_relic_gun_game)) {
          var_9 = 1;
          var_1[var_1.size] = var_12;

          if(istrue(var_0) && isDefined(level.br_spawns[var_12.team].groundorigin))
            var_2[var_2.size] = level.br_spawns[var_12.team].groundorigin;
          else
            var_2[var_2.size] = var_12.origin;

          break;
        }
      }

      if(!var_9) {
        if(isDefined(var_10)) {
          var_12 = var_10;
          var_1[var_1.size] = var_12;

          if(istrue(var_0) && isDefined(level.br_spawns[var_12.team].groundorigin))
            var_2[var_2.size] = level.br_spawns[var_12.team].groundorigin;
          else
            var_2[var_2.size] = var_12.origin;
        } else if(level.teamdata[var_8]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0) {
          var_12 = level.teamdata[var_8]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][0];
          var_1[var_1.size] = var_12;
          var_14 = randomfloat(360.0);
          var_15 = randomfloat(var_5);
          var_16 = var_3 + (cos(var_14) * var_15, sin(var_14) * var_15, 0.0);
          var_2[var_2.size] = var_16;
        }
      }
    }
  }

  var_18 = 5;

  if(isDefined(level.dropbagstruct.clusters) && level.dropbagstruct.clusters.size && isDefined(level.dropbagstruct.clusters[0].droplocations)) {
    var_18 = level.dropbagstruct.clusters[0].droplocations.size;
    var_18 = int(min(var_18, 5));
  }

  var_19 = getdvarfloat("_encstr_A6E11437D8E4AF9127B70789C2CEEBB55A9B91A537E8", 3000);
  var_20 = getdvarfloat("_encstr_87B31428822A07310BA7F7E681771EDB569B08707B43", 7000);
  var_21 = spawnStruct();
  var_21.origin = (0, 0, 0);
  var_22 = [var_21];

  if(isDefined(level.br_level)) {
    if(var_4 > 0)
      var_22 = getunusedlootcachepoints(var_2, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var_19, var_20, 2000, var_18, 128, var_3, var_4);
    else
      var_22 = getunusedlootcachepoints(var_2, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var_19, var_20, 2000, var_18, 128);
  }

  if(isDefined(var_22)) {
    for(var_23 = 0; var_23 < var_22.size; var_23++) {
      var_12 = var_1[var_23];

      if(isDefined(var_22[var_23].node)) {
        var_24 = var_22[var_23].node;
        var_25 = level.dropbagstruct.clusters[var_24];
        var_26 = var_22[var_23].index;
        var_12._id_1284B = var_25.droplocations[var_26].origin;
        continue;
      }

      var_12._id_1284B = var_22[var_23].origin;
    }

    level._id_1284C = 1;
    level thread _id_1363B(var_1);
  }

  level thread _id_11AAA();
}

_id_11AAA() {
  level notify("_encstr_B4450F536603EB1F4F3C7DD0B1C8E72893");
  level endon("_encstr_B4450F536603EB1F4F3C7DD0B1C8E72893");
  var_0 = -1;
  var_1 = getdvarfloat("_encstr_9BF4277FA8FBE79A2568168CE62F3265E660A393603104715F999F86C0FB2B17EBC06B577808478AB9", 2400.0);

  for(;;) {
    if(!isDefined(level.br_pickups.crates) || !level.br_pickups.crates.size) {
      var_0 = -1;
      wait 1.0;
      continue;
    }

    var_0 = (var_0 + 1) % level.br_pickups.crates.size;
    var_2 = level.br_pickups.crates[var_0];

    if(!isDefined(var_2)) {
      level.br_pickups.crates = scripts\engine\utility::array_removeundefined(level.br_pickups.crates);
      waitframe();
      continue;
    }

    if(isDefined(var_2.team)) {
      var_3 = 0;

      if(isDefined(var_2.numuses))
        var_3 = var_2.numuses;

      if(var_3 >= level.teamdata[var_2.team]["_encstr_AB580A05672AE35D5FFF50B8"]) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

    if(var_4 > 0.0) {
      var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
      var_6 = distance2dsquared(var_2.origin, var_5);
      var_7 = max(0, var_4 + var_1);

      if(var_6 > var_7 * var_7) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

handlerelicshieldsonlyonkill(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.br_pickups.crates) {
    if(!isDefined(var_4) || !isDefined(var_4.team) || var_4.team != var_0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_6 = var_2.size - var_1;

  if(var_6 <= 0) {
    return;
  }
  for(var_7 = var_6 - 1; var_7 >= 0; var_7--) {
    var_8 = var_2[var_7];
    var_8 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

_id_1363A(var_0, var_1, var_2) {
  handlerelicshieldsonlyonkill(self.team, 1);
  var_3 = 4096;
  var_4 = scripts\engine\utility::getStruct("_encstr_8D5A1B37ED58AF8EB7775993AFAC8DCA9D85A3ED93F53363F6F6E4FA33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = (11240, 13287, 9200);
  var_6 = scripts\cp_mp\utility\game_utility::unsetchainkillstreaks() && distance2d(var_0, var_5) < getdvarint("_encstr_96BE17ABF20B10A82AEF7B47F4D6F045175BE1119A673EF8C7", 7000) && getdvarint("_encstr_A7BE1783A8557923EB30F1E3B151CB7FE7C86A3A40B76E6721", 1) == 1;

  if(istrue(self.umbra) || isDefined(var_4) && distance2d(var_0, var_4.origin) < 5000 || var_6)
    var_3 = 10000;

  var_7 = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate(self.team, var_0 + (0, 0, var_3), var_0 + (0, 0, 512));
  var_7 endon("_encstr_AD75063D571AE108");
  _id_13C47(var_7);
  enabledropbagobjective(var_7);
  getzeroarray(var_7);

  foreach(var_9 in level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
    if(isDefined(var_9) && !var_9 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      var_10 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_A99214D562D90BB3CBBABBEDE3A77BB06EC7435B16BF");
      var_9 thread scripts\mp\hud_message::showsplash(var_10);
    }
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker())
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_826F118CDE0823461BE83952C8777D2FA04817", self.team, 1);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destprogress(self, var_0, var_1, var_7);
    thread setup_minecart(var_7);
    thread _encstr_9267184B0737D7C0B779A2574DD34959C395ABF9F11B28DAC9F5(var_7);
  }
}

setup_minecart(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 1.0;
  var_1 = var_0 physics_getbodyid(0);

  while(isDefined(var_0)) {
    var_2 = physics_getbodylinvel(var_1);

    if(abs(var_2[2]) < 0.01) {
      var_3 = [var_0];
      var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
      var_5 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 100), var_0.origin + (0, 0, -100), var_3, var_4);

      if(var_5["_encstr_A53009A25003666B9818C6"] == 1)
        var_0 scripts\cp_mp\killstreaks\airdrop::infinite_chopper(var_0.origin, (0, 0, -10));
      else
        break;
    }

    wait 0.5;
  }
}

_encstr_9267184B0737D7C0B779A2574DD34959C395ABF9F11B28DAC9F5(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 1.0;

  if(getdvarint("_encstr_852F17FB43FB576A22E1C7A7DA431297238828B35747894819", 1) == 0) {
    return;
  }
  var_1 = var_0 physics_getbodyid(0);
  var_2 = 0;
  var_3 = 0;

  while(isDefined(var_0)) {
    var_4 = physics_getbodylinvel(var_1);
    var_5 = length(var_4);
    var_6 = getdvarint("_encstr_B66A206E6CC9AF4C27F50B96C9C8937B07D7DA9637E62DC6B2BEB3AC1BBE378EDEC1", 500);

    if(var_5 - var_2 > var_6 || var_3 && var_5 > var_6) {
      var_7 = vectorNormalize(var_4);
      var_8 = var_7 * getdvarint("_encstr_939A22C23F6B9F2D3B06C873C0D44EDA2BD9FD5B332248A12AA7D51F2CFF33F27FA01747", 0);
      physics_setbodyangvel(var_1, var_8[0], var_8[1], var_8[2]);
      var_9 = physics_getbodyangvel(var_1);
      var_10 = vectorNormalize(var_9);
      var_11 = var_10 * getdvarint("_encstr_B668266E6CC9AF4C27F50B96C9C8937B07D7DA9637E62DC6B2BE0BCDD9BE67ACD87D6C0D0BB9D995", 0);
      physics_setbodylinangvel(var_1, var_11[0], var_11[1], var_11[2]);
      var_3 = 1;
    } else
      var_3 = 0;

    var_2 = var_5;
    waitframe();
  }
}

_id_1363B(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_12931)) {
    var_1 = level._id_12931;
    level._id_12931 = undefined;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3._id_1284B;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
      var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();

      if(distance2dsquared(var_5, var_4) > var_6 * var_6) {
        var_7 = vectorNormalize(var_4 - var_5);
        var_8 = var_5 + var_7 * var_6 * 0.95;

        if(isscriptabledefined())
          var_4 = getclosestpointonnavmesh(var_8);
        else
          var_4 = var_8;
      } else if(istrue(level._id_14089) && isscriptabledefined())
        var_4 = getclosestpointonnavmesh(var_4);

      if(istrue(level._id_1406F))
        var_4 = return_enemy_type_mask(var_4);

      if(scripts\mp\outofbounds::ispointinoutofbounds(var_4)) {
        var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
        var_8 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::_id_1342E(var_5, var_4);

        if(isscriptabledefined())
          var_4 = getclosestpointonnavmesh(var_8);
        else
          var_4 = var_8;
      }
    }

    var_9 = relic_punchbullets_fire_fists(1, 0, 0, 0, 0);
    var_3 _id_1363A(var_4, var_9, var_1);
    waitframe();
  }
}

return_enemy_type_mask(var_0) {
  if(isDefined(level.minigun_warning_time)) {
    if(!updatesecretstashhud(var_0, level.minigun_warning_time)) {
      var_1 = relic_bang_and_boom_think(var_0, level.minigun_warning_time);

      if(isDefined(var_1))
        var_0 = var_1;
    }
  }

  return var_0;
}

updatesecretstashhud(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3))
      return 1;
  }

  return 0;
}

relic_bang_and_boom_think(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = (var_0[0], var_0[1], 0);

  foreach(var_6 in var_1) {
    var_7 = (var_6.origin[0], var_6.origin[1], 0);
    var_8 = var_4 - var_7;
    var_9 = var_6.radius / length(var_8);
    var_8 = var_8 * var_9;
    var_10 = var_7 + var_8;
    var_11 = length(var_4 - var_10);

    if(!isDefined(var_3) || var_11 < var_3) {
      var_2 = var_10;
      var_3 = var_11;
    }
  }

  if(isDefined(var_2))
    var_2 = (var_2[0], var_2[1], var_0[2]);

  return var_2;
}

spawndropbagonlanding() {
  var_0 = undefined;
  var_0 = findunuseddropbaglocation(self);

  if(!isDefined(var_0)) {
    var_1 = getdvarfloat("_encstr_A6E11437D8E4AF9127B70789C2CEEBB55A9B91A537E8", 3000);
    var_2 = getdvarfloat("_encstr_87B31428822A07310BA7F7E681771EDB569B08707B43", 7000);
    var_0 = calculatedroplocationnearlocation(self, var_1, var_2);
  }

  if(isDefined(var_0)) {
    var_3 = relic_punchbullets_fire_fists(0, 0, 0, 1, 0);
    _id_1363A(var_0.origin, var_3);
    level thread _id_11AAA();
  }
}

findunuseddropbaglocation(var_0) {
  var_1 = [];
  var_2 = getdvarfloat("_encstr_A6E11437D8E4AF9127B70789C2CEEBB55A9B91A537E8", 3000);
  var_3 = getdvarfloat("_encstr_87B31428822A07310BA7F7E681771EDB569B08707B43", 7000);
  var_4 = var_2 * var_2;
  var_5 = var_3 * var_3;

  foreach(var_7 in level.dropbagstruct.clusters) {
    var_8 = distance2dsquared(var_0.origin, var_7.origin);

    if(var_8 >= var_4 && var_8 <= var_5)
      var_1[var_1.size] = var_7;
  }

  if(var_1.size == 0)
    return undefined;

  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_10 = 0;

  foreach(var_7 in var_1) {
    var_12 = scripts\engine\utility::array_randomize(var_7.droplocations);

    foreach(var_14 in var_12) {
      if(!var_14.inuse) {
        var_14.inuse = 1;
        return var_14;
      }
    }
  }

  return undefined;
}

_id_13C47(var_0) {
  level thread _id_13C48(var_0, self);
}

_id_13C48(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = var_1;
  var_3 = var_1.team;

  for(;;) {
    var_0 setotherent(var_2);
    var_2 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
    var_4 = undefined;
    var_5 = level.teamdata[var_3]["_encstr_9775086022BE1B413B8B"];

    foreach(var_1 in var_5) {
      if(isDefined(var_2) && var_2 == var_1) {
        continue;
      }
      var_4 = var_1;
      break;
    }

    if(!isDefined(var_4)) {
      break;
    }

    var_2 = var_4;
  }
}

enabledropbagobjective(var_0) {
  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_930B07BB1B6B3854FF");
}

getzeroarray(var_0) {
  var_0 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_8C8C077729400283C0");
}

kioskreviveplayer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_4 = var_3 - var_1;

    if(var_4 > 0)
      wait(var_4);

    var_1 = var_3;
    _id_1284D(0);

    if(level.delay_put_vehicles_on_compass)
      _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_id_13169("_encstr_93920C9E781BB33078D689330FA7", 0);
  }
}

brking_initexternalfeatures() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BDC6085DF29A892901C7")) {
    return;
  }
  foreach(var_1 in level.br_pickups.crates) {
    if(!isDefined(var_1) || !isDefined(var_1.team) || var_1.team != self.team) {
      continue;
    }
    var_2 = isDefined(var_1.playerscaptured) && isDefined(var_1.playerscaptured[self getentitynumber()]);

    if(var_2) {
      var_1.playerscaptured[self getentitynumber()] = undefined;

      for(var_3 = 0; var_3 < var_1.playersused.size; var_3++) {
        if(isDefined(var_1.playersused[var_3]) && var_1.playersused[var_3] == self)
          var_1.playersused[var_3] = undefined;
      }

      var_1.playersused = scripts\engine\utility::array_removeundefined(var_1.playersused);
      var_1.numuses--;
    }
  }
}

_id_12072() {
  brking_initexternalfeatures();
}

relic_punchbullets_fire_fists(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0))
    return 0;

  if(istrue(var_1))
    return 1;

  if(istrue(var_2))
    return 2;

  if(istrue(var_3))
    return 3;

  if(istrue(var_4))
    return 4;

  return -1;
}

testmissionrewards() {
  runmissionrewarddelivery(level.players[0], level.players[0], undefined, 3);
}

findclosestdroplocation(var_0) {
  var_1 = var_0 scripts\engine\utility::array_sort_with_func(level.dropbagstruct.clusters, ::sortlocationsbydistance);

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::array_randomize(var_3.droplocations);

    foreach(var_6 in var_4) {
      if(!var_6.inuse) {
        var_6.inuse = 1;
        return var_6;
      }
    }
  }

  return undefined;
}

sortlocationsbydistance(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

calculatedroplocationnearlocation(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_4 = randomfloatrange(var_3[0] + var_1 * var_7, var_3[0] + var_2 * var_7);

    if(var_4 >= level.br_level.br_mapbounds[0][0])
      var_4 = level.br_level.br_mapbounds[0][0] - 250;
  } else {
    var_4 = randomfloatrange(var_3[0] + var_2 * var_7, var_3[0] + var_1 * var_7);

    if(var_4 <= level.br_level.br_mapbounds[1][0])
      var_4 = level.br_level.br_mapbounds[1][0] + 250;
  }

  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_5 = randomfloatrange(var_3[1] + var_1 * var_7, var_3[1] + var_2 * var_7);

    if(var_5 >= level.br_level.br_mapbounds[0][1])
      var_5 = level.br_level.br_mapbounds[0][1] - 250;
  } else {
    var_5 = randomfloatrange(var_3[1] + var_2 * var_7, var_3[1] + var_1 * var_7);

    if(var_5 <= level.br_level.br_mapbounds[1][1])
      var_5 = level.br_level.br_mapbounds[1][1] + 250;
  }

  if(isscriptabledefined()) {
    var_8 = getclosestpointonnavmesh((var_4, var_5, var_3[2]));

    if(isDefined(var_8)) {
      var_9 = spawnStruct();
      var_9.origin = var_8;
      return var_9;
    }
  }

  var_9 = spawnStruct();
  var_9.origin = (var_4, var_5, var_3[2]);
  return var_9;
}

debugsphereonlocation(var_0) {}

maskobjectivetoplayerssquad(var_0, var_1) {
  var_0.visibilitymanuallycontrolled = 1;
  objective_removeallfrommask(var_0.objidnum);

  foreach(var_3 in level.squaddata[var_1.team][var_1.squadindex].players)
  objective_addclienttomask(var_0.objidnum, var_3);
}