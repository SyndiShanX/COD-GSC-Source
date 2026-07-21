/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\grnd.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_AF5B09233D7D338D0B9356";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 7500);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::onplayerkilled;
  level.onrespawndelay = _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::getrespawndelay;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B4EA123F6329CAEC5883DFA9F9F80F537AE7938F";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_881C0F26B7B7B93AFA46C9BD384FDBDCCA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_881C0F26B7B7B93AFA46C9BD384FDBDCCA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32"] = "_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96150D4AF18ABF1EC031AC950DD8E7"] = "_encstr_96150D4AF18ABF1EC031AC950DD8E7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA8D10032AC1ED815F5F786887617B3B2A55"] = "_encstr_82211043781F6EC2EF58C272CBBACB112FDE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1341202FF59E78993406BB05124317D280B40A2"] = "_encstr_A9591219D37D6C588347D52795C8D72B73B25B97";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992"] = "_encstr_8EFF1564F5F9DE8F379B4B0381053FD7C8BB1DE651C8E0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C5E0D34E0BEB1DBCD1D59373A2B23"] = "_encstr_BAF50D914FD7D8DB37E8AC3747AC8C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2D90D0DE07DB6BDD956D7DCB7EDB9"] = "_encstr_A5E20D15B8D1FBF06E87F198479F28";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DF313F87BE7D973ABBB25AED462B78605EB6858C7"] = "_encstr_9AC11323A7BE8D0BE047D5932DE63BF59573565B97";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FAD16C8485FB69008A3CB7B2F38CFF06F434BED08E06968"] = "_encstr_82FF16525AB89746A0C1454A93388F1F5C331ACA608D63B8";
  setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
  setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", 0);
  setomnvar("_encstr_86491063E151C0C7078283A80A9B7D10764D", -1);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_87BE12F347105117B658DA51218E7FD2793B956D", getmatchrulesdata("_encstr_843A090F9BA0B48877293F", "_encstr_A138098B2B674BA1D81DF9"));
  setdynamicdvar("_encstr_AA1D1937364EFAECE4E646D75973C2138DB295C29396C2DC3A114B", getmatchrulesdata("_encstr_843A090F9BA0B48877293F", "_encstr_BD9A102BCD58C4C659CAB09CA5B073E82269"));
  setdynamicdvar("_encstr_95F616CD6C39FAD9279B23AF4FB79B5689A533563A4BD659", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_86550DFA1D220B34D12B80A33FFD29"));
  setdynamicdvar("_encstr_8780192E4EB32F61FA3B5889830F988308762735A3CB134FD92FA8", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59"));
  setdynamicdvar("_encstr_85A922C091CA67575BA37B2FC29FEDCF74B9B7E3B79757D47B043EADA04570A53F7197C0", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_87E51966D293CD1D2DDEDCCA82361D4BD9C2A3A5DEB922598DC2E5"));
  setdynamicdvar("_encstr_ADB41D3F57FB70D89A757916987F689520CFB9B3AB92ADE0AF4D65A9055998", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5"));
  setdynamicdvar("_encstr_BEED1DEB5F08493F9E60F2498B7F63FF88DB5C4FF7484BCFC85858E35145DB", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB"));
  setdynamicdvar("_encstr_ACA719FB79457E944BD34C7717B1490BD9F3B3126FC6F53B873A77", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_829C10A99FECC0B502436B0F3F4AFE988E37"));
  setdynamicdvar("_encstr_A39213F79F72E9376BADDC6649F178F34581D33BE5", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_83FE0A484FBDAB0BF9EC1915"));
  setdynamicdvar("_encstr_BACA15082648C94A90B09867A51FF1D143C83099B1AFE5", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_A9210CA017EC518B7175D7E30F6B"));
  setdynamicdvar("_encstr_BEAA129BE06B97D932209BE7C3D1FD368CA0F1C0", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_9A7205B39CB919", 0);
  setdynamicdvar("_encstr_A39911FFD7C2B9A0EB5D60EE701B5FB12F1BFD", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_924510BF628C31B64398CF55C1567C4155FC");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_924510BF628C31B64398CF55C1567C4155FC");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_B65316C5DD1CA0A98589963FDB28C0AA3310881FCEB0C9B7");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_B404149E2125A8685125958A6A5E11D335F509299C2A");
  }

  level thread setupzones();
  setmapsizespawnconsts();
  initspawns();
  level thread dzmainloop();

  if(level.droptime > 0)
    level thread randomdrops();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.droptime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_A138098B2B674BA1D81DF9", 15, 0, 60);
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86550DFA1D220B34D12B80A33FFD29", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87E51966D293CD1D2DDEDCCA82361D4BD9C2A3A5DEB922598DC2E5", 30, 0, 120);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5", 30, 0, 120);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("_encstr_829C10A99FECC0B502436B0F3F4AFE988E37", 0, 0, 1);
  level._id_1221A = scripts\mp\utility\dvars::dvarintvalue("_encstr_83FE0A484FBDAB0BF9EC1915", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9210CA017EC518B7175D7E30F6B", 0, 0, 1);
  level.enablevariantdrops = scripts\mp\utility\dvars::dvarintvalue("_encstr_BD9A102BCD58C4C659CAB09CA5B073E82269", 0, 0, 1);
  level.usehqrules = 0;
  level.usehprules = 1;

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::isanymlgmatch() && getdvarint("_encstr_A9CA25FF7B8AE9BAB743F01EEB5367CBA5D94779DAB528F5372A8BC0B33FA5C8BD26A1C3849E68", 15) != 0)
    level.zoneactivationdelay = binoculars_getfov();
}

binoculars_getfov() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_0) {
    case "_encstr_A3890850E25F90B79A83":
    case "_encstr_A6640D9D1109AF2FC7082B029395FF":
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      return getdvarint("_encstr_A9CA25FF7B8AE9BAB743F01EEB5367CBA5D94779DAB528F5372A8BC0B33FA5C8BD26A1C3849E68", 15);
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      return getdvarint("_encstr_A9CA25FF7B8AE9BAB743F01EEB5367CBA5D94779DAB528F5372A8BC0B33FA5C8BD26A1C3849E68", 15) + 15;
    default:
      return level.zoneactivationdelay;
  }
}

setmapsizespawnconsts() {
  var_0 = getsubstr(level.mapname, 0, 7);

  switch (var_0) {
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 225000000;
      level.max_relevant_spawn_dist = 7000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    case "_encstr_A2200CDA13D6CBC897E1A0EBAA93":
      level.spawn_deadzone_dist = 500;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    default:
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
  }
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  enablespawnpointbyindex("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  level.spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");

  if(!level.spawnpoints.size) {
    return;
  }
  foreach(var_3 in level.objectives) {
    var_3.furthestspawndistsq = 0;
    var_3.spawnpoints = [];
    var_3.fallbackspawnpoints = [];
  }

  foreach(var_6 in level.spawnpoints) {
    calculatespawndisttozones(var_6);
    var_7 = scripts\mp\spawnlogic::getoriginidentifierstring(var_6);

    if(isDefined(level.grndextraprimaryspawnpoints) && isDefined(level.grndextraprimaryspawnpoints[var_7])) {
      foreach(var_9 in level.grndextraprimaryspawnpoints[var_7]) {
        var_3 = level.objectives[var_9];
        var_3.spawnpoints[var_3.spawnpoints.size] = var_6;
      }
    }

    var_11 = 0;
    var_12 = var_6.classname == "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0" || var_6.classname == "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB";
    var_13 = var_6.classname == "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    var_14 = var_6.classname == "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318";

    if(var_12) {
      continue;
    }
    if(var_13 || var_14) {
      if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy != "_encstr_B40101") {
        foreach(var_3 in level.objectives) {
          if(var_13) {
            var_3.spawnpoints[var_3.spawnpoints.size] = var_6;
            continue;
          }

          var_3.fallbackspawnpoints[var_3.fallbackspawnpoints.size] = var_6;
        }
      }
    }

    calculatespawndisttozones(var_6);

    if(!var_11) {
      foreach(var_3 in level.objectives) {
        if(var_6.scriptdata.distsqtokothzones[var_3.trigger getentitynumber()] < level.close_spawn_min_dist_sq || var_6.scriptdata.distsqtokothzones[var_3.trigger getentitynumber()] > level.max_spawn_dist_sq)
          var_6.removespawn = 1;

        if(var_13) {
          if(!isDefined(var_6.removespawn))
            var_3.spawnpoints[var_3.spawnpoints.size] = var_6;
        } else
          var_3.fallbackspawnpoints[var_3.fallbackspawnpoints.size] = var_6;

        var_6.removespawn = undefined;
      }
    }
  }

  foreach(var_21, var_3 in level.objectives) {
    var_3.spawnset = "_encstr_A6680A484BB5913AC7EE3520" + var_21;
    scripts\mp\spawnlogic::registerspawnset(var_3.spawnset, var_3.spawnpoints);
    var_3.fallbackspawnset = "_encstr_970C13494B72BF58FF0D314E37D9A0F9FA6F3FDF67" + var_21;
    scripts\mp\spawnlogic::registerspawnset(var_3.fallbackspawnset, var_3.fallbackspawnpoints);
  }
}

calculatespawndisttozones(var_0, var_1) {
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_3 in level.objectives) {
    var_4 = getpathdist(var_0.origin, var_3.origin, level.max_relevant_spawn_dist);

    if(var_4 < 0)
      var_4 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_3.origin);
    else
      var_4 = var_4 * var_4;

    var_0.scriptdata.distsqtokothzones[var_3.trigger getentitynumber()] = var_4;

    if(var_4 > var_3.furthestspawndistsq)
      var_3.furthestspawndistsq = var_4;
  }
}

comparezoneindexes(var_0, var_1) {
  var_2 = int(var_0.objectivekey);
  var_3 = int(var_1.objectivekey);

  if(!isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(!isDefined(var_2) && isDefined(var_3))
    return 1;

  if(isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(var_2 > var_3)
    return 1;

  return 0;
}

getzonearray(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3.objectivekey = var_3.script_label;

  if(!isDefined(var_1) || var_1.size == 0)
    return undefined;

  var_5 = 1;

  for(var_6 = var_1.size; var_5; var_6--) {
    var_5 = 0;

    for(var_7 = 0; var_7 < var_6 - 1; var_7++) {
      if(comparezoneindexes(var_1[var_7], var_1[var_7 + 1])) {
        var_8 = var_1[var_7];
        var_1[var_7] = var_1[var_7 + 1];
        var_1[var_7 + 1] = var_8;
        var_5 = 1;
      }
    }
  }

  return var_1;
}

setupzones() {
  var_0 = getzonearray("_encstr_9A7205B39CB919");

  if(level.mapname == "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3") {
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1547, -1512, 165)) < 10)
        var_2.origin = var_2.origin - (0, 0, 10);
    }
  } else if(level.mapname == "_encstr_93FB0A6B1C7D2CB92D5EB00D") {
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1117, 2295, 398)) < 10) {
        var_2.origin = var_2.origin - (0, 0, 10);
        continue;
      }

      if(distance(var_2.origin, (-4501, -2, 322)) < 10) {
        var_2.script_label = "_encstr_8B4C0227";
        continue;
      }

      if(distance(var_2.origin, (-4474, 1159, 388)) < 10)
        var_2.origin = var_2.origin - (0, 0, 20);
    }
  }

  var_6 = [];
  var_7 = scripts\engine\utility::getStructArray("_encstr_AF5B09233D7D338D0B9356", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = [];
  var_9 = [];

  if(level.mapname == "_encstr_A2200CDA13D6CBC897E1A0EBAA93") {
    foreach(var_2 in var_0) {
      if(var_2.script_label == "_encstr_A34C02BB" && distance(var_2.origin, (-333, 1999, 119)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2.script_label == "_encstr_A74C0222" && distance(var_2.origin, (189, 1564, 75)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2.script_label == "_encstr_A14C023B" && distance(var_2.origin, (-751, 2416, 81)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2.script_label == "_encstr_AC4C024A" && distance(var_2.origin, (165, 2420, 79)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2.script_label == "_encstr_B84C027E" && distance(var_2.origin, (-823, 1536, 68)) < 5)
        var_8[var_8.size] = var_2;
    }

    var_0 = scripts\engine\utility::array_remove_array(var_0, var_8);

    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (192.944, 1583.51, 16.344)) < 5) {
        var_9[var_9.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (-743.056, 2447.51, 17.844)) < 5) {
        var_9[var_9.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (152.944, 2415.51, 16.344)) < 5) {
        var_9[var_9.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (-334.5, 1990.5, 17.25)) < 5) {
        var_9[var_9.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (-751.056, 1479.51, 16.844)) < 5)
        var_9[var_9.size] = var_13;
    }

    var_7 = scripts\engine\utility::array_remove_array(var_7, var_9);
  } else if(level.mapname == "_encstr_8F2B0BB6E0D71A163932317BE4") {
    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (4491, -942, 183.25)) < 5)
        var_9[var_9.size] = var_13;
    }

    var_7 = scripts\engine\utility::array_remove_array(var_7, var_9);
  } else if(level.mapname == "_encstr_95320DDAE0D7AD5A638D0D7BBAE6B2") {
    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (99, 830.5, 11.25)) < 5) {
        var_13.origin = (-22.5, 86.5, 11);
        continue;
      }

      if(distance(var_13.origin, (-531.5, -485.5, 11.25)) < 5) {
        var_13.origin = (265, 845.5, 10);
        continue;
      }

      if(distance(var_13.origin, (-586, 567.5, 11.25)) < 5) {
        var_13.origin = (-339.5, -509.5, 10);
        continue;
      }

      if(distance(var_13.origin, (-38, -738.5, 11.25)) < 5)
        var_13.origin = (-452, 599.5, 10);
    }
  }

  foreach(var_13 in var_7) {
    var_20 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_13.origin);
    var_20.angles = var_13.angles;
    var_20 setModel("_encstr_956814391B01C498619AA1FEC24BA08B4B8BABBD3BCA");
    var_13.scriptable = var_20;
  }

  var_22 = [];
  level.objectives = [];

  for(var_23 = 0; var_23 < var_7.size; var_23++) {
    var_24 = 0;
    var_13 = var_7[var_23];
    var_2 = undefined;

    for(var_25 = 0; var_25 < var_0.size; var_25++) {
      if(var_13.scriptable istouching(var_0[var_25])) {
        if(isDefined(var_2)) {
          var_6[var_6.size] = "_encstr_BA690A5250F3B2BF21AF6C30" + var_13.origin + "_encstr_84B23208B4374047BDBA8D34A5E6D902B6EDE4B2808E438573047BB9CA108833D8584EB28E4ED2B3D9959C8880D193D2B39D5639";
          var_24 = 1;
          break;
        }

        var_2 = var_0[var_25];
        break;
      }
    }

    if(!isDefined(var_2)) {
      if(!var_24) {
        var_6[var_6.size] = "_encstr_BA690A5250F3B2BF21AF6C30" + var_13.origin + "_encstr_9BC02AA833EB02E5A7D06EF228B71CAB810F716E53D9422F7980530AE0CD546F3905EA5A47BBDBB407982A73";
        continue;
      }
    }

    var_22 = [];
    var_22[0] = var_13.scriptable;
    var_26 = _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setupobjective(var_2, var_22);
    var_26.origin = var_2.origin;
    level.objectives[var_26.objectivekey] = var_26;
  }

  if(var_6.size > 0) {
    for(var_23 = 0; var_23 < var_6.size; var_23++) {}
  } else {}
}

dzmainloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  seticonnames();
  initwaypointicons();
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
  level.zone = getfirstzone();
  var_0 = 1;
  level.kothhillrotation = 0;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_9AA40B86A51B8DF5ADBDB3958C", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);
  var_1 = 0;

  if(level.firstzoneactivationdelay) {
    var_1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 6);
    level._id_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 42, 42);
    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.firstzoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait(level.firstzoneactivationdelay);
    level._id_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 41, 41);
  }

  scripts\mp\utility\sound::playsoundonplayers("_encstr_820A14E06139BD13C8A1F5C71D678730C6E297924D7F");

  for(;;) {
    if(!isDefined(level._id_11AD5))
      level thread setupzonecallouts();

    level.zone.visuals[0] setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_A7C5056BD931D1", 0);
    level.objectivesetorder = 1;
    waittillframeend;
    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled)
      level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::trackgametypevips();

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_1, var_0);
    var_0 = 0;
    var_1 = 0;
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 8);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var_2 = level.zone scripts\mp\gameobjects::getownerteam();

    if(level._id_1221A)
      level scripts\mp\gamelogic::resumetimer();

    level.lastcaptureteam = undefined;
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_4 in level.players)
      level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hideplayerspecificbrushes(var_4);
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    level.zone scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    updateservericons("_encstr_83270B204F9E4157D3C463FCDB", 0);
    level notify("_encstr_9B740BDBEF187A77B0B1CA578B");
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
    spawn_next_zone();

    if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919" && level.kothhillrotation == 1) {}

    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
    wait 1;
  }
}

getfirstzone() {
  if(level.mapname == "_encstr_992B0BABB3814370F29F80B983") {
    var_0 = level.objectives["_encstr_B84C027E"];
    level.prevzoneindex = 5;
  } else {
    var_0 = level.objectives["_encstr_A34C02BB"];
    level.prevzoneindex = 1;
  }

  return var_0;
}

getnextzone() {
  if(level.zonerandomlocationorder) {
    var_0 = [];

    foreach(var_2 in level.teamnamelist)
    var_0[var_2] = (0, 0, 0);

    var_4 = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(var_6 in var_4) {
      if(var_6.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        continue;
      }
      var_0[var_6.team] = var_0[var_6.team] + var_6.origin;
    }

    var_8 = [];

    foreach(var_2 in level.teamnamelist) {
      var_10 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");
      var_11 = max(var_10.size, 1);
      var_8[var_2] = var_0[var_2] / var_11;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1)
      level.prevzonelist = [];

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    var_13 = 0.7;
    var_14 = 0.3;
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_18 in level.objectives) {
      var_19 = 0;

      foreach(var_21 in level.prevzonelist) {
        if(var_18.objectivekey == scripts\engine\utility::string(var_21)) {
          var_19 = 1;
          break;
        }
      }

      if(var_19) {
        continue;
      }
      var_23 = var_18;
      var_24 = 0;

      foreach(var_2 in level.teamnamelist)
      var_24 = var_24 + distance2dsquared(var_23.curorigin, var_8[var_2]);

      var_27 = distance2dsquared(var_23.curorigin, level.zone.curorigin);
      var_28 = var_24 * var_13 + var_27 * var_14;

      if(!isDefined(var_16) || var_28 > var_16) {
        var_16 = var_28;
        var_15 = var_18.objectivekey;
      }
    }

    var_23 = level.objectives[var_15];
    level.prevzoneindex = var_15;
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size)
      level.prevzoneindex = 1;

    var_23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
  }

  return var_23;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone.visuals[0] setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_BA19049F4B2D", 0);
  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0)
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_9AA40B86A51B8DF5ADBDB3958C", level.zone.trigger.origin);
}

hqactivatenextzone(var_0, var_1) {
  if(var_1) {
    foreach(var_3 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_AA8314574B50C73FDF38F323237E81CF7780B5FDD3BF", var_3);
  } else {
    foreach(var_3 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_AA8D10032AC1ED815F5F786887617B3B2A55", var_3);
  }

  scripts\mp\utility\sound::playsoundonplayers("_encstr_820A14E06139BD13C8A1F5C71D678730C6E297924D7F");
  level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(istrue(var_0)) {} else if(level.zoneactivationdelay) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 6);
    level._id_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 42, 42);
    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.zoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait(level.zoneactivationdelay);
    level._id_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 41, 41);
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(level.zoneduration) {
    updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);
    thread movezoneaftertime(level.zoneduration);
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
  } else
    level.zonedestroyedbytimer = 0;
}

locktimeruntilcap() {
  level endon("_encstr_86C30E225D088A98370A61DBF31607CC");

  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    waitframe();
  }
}

hpcaptureloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    level.zone scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    level.zone scripts\mp\gameobjects::setusetext(&"_encstr_838E1511A2461705EBF709D9B3C79EC9A89A9B054CF865");
    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hardpoint_setneutral();
    level.zone scripts\mp\gameobjects::cancontestclaim(1);

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime)
      level thread randomdrops();

    var_0 = level scripts\engine\utility::_id_143AD("_encstr_86C30E225D088A98370A61DBF31607CC", "_encstr_A29C0FA77BE659D74656B9479CDBE52B91");

    if(var_0 == "_encstr_A29C0FA77BE659D74656B9479CDBE52B91") {
      continue;
    }
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("_encstr_AAFE1E62300FB76348A7E2FFB0D10FBE9BC87B7B88C3EF9FC3B7D3E15578E347", var_1);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_87881E305B89A92BD7704AC8E607766FEEC37048D35FD1C6FB3DDC37D41F1B3B", scripts\mp\utility\game::getotherteam(var_1)[0]);
    thread updaterespawntimer();
    level waittill("_encstr_A29C0FA77BE659D74656B9479CDBE52B91", var_2);
    level.spawndelay = undefined;

    if(isDefined(var_2)) {
      level.zone scripts\mp\gameobjects::setownerteam(var_2);
      continue;
    }

    level.zone scripts\mp\gameobjects::setownerteam("_encstr_8BBA05185F8B99");
  }
}

awardcapturepoints() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  level endon("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    var_2 = 0.0;

    while(var_2 < var_0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level.framedurationseconds;

      if(level.zone.stalemate)
        var_2 = 0.0;
    }

    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
      continue;
    }
    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring)
        var_1 = level.zone.touchlist[var_3].size;

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);

      foreach(var_5 in level.zone.touchlist[var_3]) {
        var_5.player scripts\mp\utility\stats::incpersstat("_encstr_ACF5089FF6827199725B", 1);

        if(isDefined(var_5.player.timebyrotation[level.kothhillrotation]))
          var_5.player.timebyrotation[level.kothhillrotation]++;
        else
          var_5.player.timebyrotation[level.kothhillrotation] = 1;

        var_5.player scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ACF5089FF6827199725B", var_5.player.pers["_encstr_ACF5089FF6827199725B"]);
        var_5.player scripts\mp\utility\stats::setextrascore0(var_5.player.pers["_encstr_ACF5089FF6827199725B"]);
        var_5.player scripts\mp\gamescore::giveplayerscore("_encstr_991E0CD6DBD11AD75AB9EBBDC4A9", 10);
      }
    }
  }
}

movezoneaftertime(var_0) {
  level notify("_encstr_8D8A0FF83329E3FBD875FB20D7CF407D83");
  level endon("_encstr_8D8A0FF83329E3FBD875FB20D7CF407D83");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_A6940FED853B0E2535D3E028F988FFE0AF");
  level.zonemovetime = var_0;
  level.zonedestroyedbytimer = 0;
  _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
}

give_capture_credit(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.lastcaptime = gettime();
  var_6 = var_4;

  if(isDefined(var_6.owner))
    var_6 = var_6.owner;

  if(isPlayer(var_6)) {
    if(!isscoreboosting(var_6)) {
      var_6 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_6.origin);
      var_6 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8FC30BAC3D311657EF53B3CB59");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100)
        var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_97D91205E8A9323760F0074720B8C31A07768EFA");

      if(var_6.lastkilltime + 500 > gettime()) {} else
        var_6 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_6);
    }
  }

  var_7 = getarraykeys(var_0);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_0[var_7[var_8]].player;
    var_9 updatecapsperminute(var_3);

    if(!isscoreboosting(var_9)) {
      var_9 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
      var_9 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_9.pers["_encstr_81CF0936850ED1D54EACCD"]);
    } else {}

    if(var_6 != var_9) {
      var_9 thread scripts\mp\rank::scoreeventpopup("_encstr_96E10F4E1293111B5BCF794043AB0C0FFB");
      var_9 thread scripts\mp\awards::givemidmatchaward("_encstr_A57E172DC0B12ADF09F027E73801DB93356D39A6B6C7A23BD3");
      var_9 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_9);
    }

    wait 0.05;
  }
}

randomdrops() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.grnd_previouscratetypes = [];

  for(;;) {
    var_0 = getbestplayer();
    var_1 = 1;

    if(isDefined(var_0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      var_2 = getdropzonecratetype();
      var_3 = getnodesintrigger(level.zone.trigger);

      if(level.mapname == "_encstr_95320DDAE0D7AD5A638D0D7BBAE6B2")
        var_4 = relic_shieldsonly_set_player_stats_after_spawn();
      else
        var_4 = relic_shieldsonly_set_player_stats_after_spawn() + (randomintrange(-50, 50), randomintrange(-50, 50), 0);

      if(var_2 == "_encstr_84A20520D7F798") {
        var_5 = spawnStruct();
        var_5.cratetype = undefined;
        var_5.numcrates = undefined;
        var_5.usephysics = undefined;
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_0, var_0.team, var_4, randomfloat(360), var_4, var_5);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(var_0, var_0.team, var_2, var_4, randomfloat(360), var_4, 1);
      }

      var_6 = level.droptime;
    } else
      var_6 = 0.5;

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_6);
  }
}

_id_132F5(var_0) {
  if(var_0 == "_encstr_84A20520D7F798")
    return 0;

  if(level.mapname == "_encstr_9B2D0A451FCEFB46DF18EA43") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_AC4C024A")
      return 0;
  } else if(issubstr(level.mapname, "_encstr_93FB0A6B1C7D2CB92D5EB00D")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_A34C02BB")
      return 0;
  } else if(level.mapname == "_encstr_A3890850E25F90B79A83") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_8F4C026A")
      return 0;
  } else if(level.mapname == "_encstr_BA4D0DED61799A1FB5DB6AD2E30753") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_A34C02BB")
      return 0;
  } else if(issubstr(level.mapname, "_encstr_86B70B68DA97887FE2773D2317")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_AC4C024A")
      return 0;
  } else if(issubstr(level.mapname, "_encstr_A2200CDA13D6CBC897E1A0EBAA93")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_A34C02BB")
      return 0;
  } else if(issubstr(level.mapname, "_encstr_BD960C6B0ED7CAD61CED395AD5B6"))
    return 0;
  else if(level.mapname == "_encstr_8E2D0CDA88B79E8791429C87E593") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_B84C027E")
      return 0;
  }

  return 1;
}

relic_shieldsonly_set_player_stats_after_spawn() {
  if(level.mapname == "_encstr_9B2D0A451FCEFB46DF18EA43" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_AC4C024A")
    return (1760, 701, 122);
  else if(level.mapname == "_encstr_BD960C6B0ED7CAD61CED395AD5B6" && isDefined(level.zone.trigger.script_label)) {
    switch (level.zone.trigger.script_label) {
      case "_encstr_A34C02BB":
        return (-732, -136, 608);
      case "_encstr_A74C0222":
        return (672, -1336, 608);
      case "_encstr_A14C023B":
        return (44, 968, 608);
      case "_encstr_AC4C024A":
        return (-680, -1552, 608);
      case "_encstr_B84C027E":
        return (832, 4, 608);
    }
  } else if(level.mapname == "_encstr_8E2D0CDA88B79E8791429C87E593" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_B84C027E")
    return (-346, -2368, 66);
  else if(level.mapname == "_encstr_8B1D09FFC8A63802BDEF7B" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_A74C0222")
    return (-2057, 1042, 150);
  else if(level.mapname == "_encstr_A5110B50E25F68A83BD3D3EBBB" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "_encstr_A14C023B")
    return (-100, 1780, 82);
  else if(level.mapname == "_encstr_95320DDAE0D7AD5A638D0D7BBAE6B2" && isDefined(level.zone.trigger.script_label)) {
    switch (level.zone.trigger.script_label) {
      case "_encstr_A34C02BB":
        var_0 = [(-589, -479, 68), (289, 830, 68), (-589, -479, 68), (301, 525, 68)];
        var_1 = scripts\engine\utility::random(var_0);
        return var_1;
      case "_encstr_A74C0222":
        return (289, 830, 68);
      case "_encstr_A14C023B":
        return (-589, -479, 68);
      case "_encstr_AC4C024A":
        return (-301, 525, 68);
    }
  }

  return level.zone.origin;
}

getbestplayer() {
  var_0 = undefined;
  var_1 = 0;
  var_2 = level.zone scripts\mp\gameobjects::getownerteam();

  if(var_2 == "_encstr_A7A408B9CA5D1D4E2C63")
    return var_0;

  foreach(var_4 in level.zone.touchlist[var_2]) {
    if(var_1 == 0 || var_1 > var_4.starttime) {
      var_1 = var_4.starttime;
      var_0 = var_4.player;
    }
  }

  return var_0;
}

getdropzonecratetype() {
  var_0 = undefined;

  if(level.mapname != "_encstr_95320DDAE0D7AD5A638D0D7BBAE6B2" && !isDefined(level.grnd_previouscratetypes["_encstr_84A20520D7F798"]) && randomintrange(0, 100) < 5)
    var_0 = "_encstr_84A20520D7F798";
  else {
    if(level.grnd_previouscratetypes.size) {
      for(var_1 = 200; var_1; var_1--) {
        var_0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

        if(isDefined(level.grnd_previouscratetypes[var_0])) {
          var_0 = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(var_0))
      var_0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
  }

  level.grnd_previouscratetypes[var_0] = 1;

  if(level.grnd_previouscratetypes.size == 15)
    level.grnd_previouscratetypes = [];

  return var_0;
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = getobjzonedeadzonedist();
  var_2 = [];
  var_2["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"] = level.zone.visuals[0] getentitynumber();
  var_2["_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"] = level.zone.visuals[0].furthestspawndistsq;
  var_2["_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"] = var_1 * var_1;
  var_2["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"] = level.enemy_spawn_influence_dist_sq;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7", undefined, var_2);
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207", undefined, var_2);
    }
  } else {
    if(!isDefined(level._id_139D1)) {
      level._id_139D1 = 1;
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8307038FD6", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    }

    var_4 = removespawnsinactivedz(level.zone.spawnpoints);
    var_5 = removespawnsinactivedz(level.zone.fallbackspawnpoints);
    var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.zone.spawnset, level.zone.fallbackspawnset, "_encstr_8F1904CA1729", var_2);
  }

  return var_3;
}

getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

removespawnsinactivedz(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.zone.trigger))
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

onplayerconnect(var_0) {
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_ACF5089FF6827199725B"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_ACF5089FF6827199725B"]);

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["_encstr_B1F7085B03F492AE98DB"]))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B1F7085B03F492AE98DB"]);
}

onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  thread updatematchstatushintonspawn();
  level._id_12305 = 30;
}

updateservericons(var_0, var_1) {
  var_2 = -1;

  if(var_1)
    var_2 = -2;
  else if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
    var_3 = thread getownerteamplayer(var_0);

    if(isDefined(var_3))
      var_2 = var_3 getentitynumber();
  } else {
    switch (var_0) {
      case "_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E":
        var_2 = -3;
        break;
      case "_encstr_83270B204F9E4157D3C463FCDB":
      default:
        break;
    }
  }

  setomnvar("_encstr_95E80DAE5ABEA11693190EB79637A3", var_2);
}

getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

updaterespawntimer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level endon("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
  var_0 = gettime();

  if(level.zoneduration > 0)
    var_1 = var_0 + level.zoneduration * 1000;
  else
    var_1 = var_0 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();

  var_2 = var_0;

  while(var_2 < var_1) {
    var_2 = gettime();
    level.spawndelay = (var_1 - var_2) / 1000 + 0.1;
    waitframe();
  }
}

seticonnames() {
  level.icontarget = "_encstr_918E0A919EBE3AB09C9D2BE8";
  level.iconneutral = "_encstr_826B0B649AF708BD70E3F387FB";
  level.iconcapture = "_encstr_9738098C9EFAACDC56D65E";
  level.icondefend = "_encstr_AFD70C34BAA7CE6B621D530992CB";
  level.iconcontested = "_encstr_BAF50D914FD7D8DB37E8AC3747AC8C";
  level.icontaking = "_encstr_B1CA0ADD8A8F7B3B24927828";
  level.iconlosing = "_encstr_88BC0AFCFAE96198504018B7";
  level.icondefending = "_encstr_96940D32E97D239599AC9B19B49B9D";
}

initwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_9738098C9EFAACDC56D65E", 0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AFD70C34BAA7CE6B621D530992CB", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_96940D32E97D239599AC9B19B49B9D", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_826B0B649AF708BD70E3F387FB", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BAF50D914FD7D8DB37E8AC3747AC8C", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_88BC0AFCFAE96198504018B7", 0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_918E0A919EBE3AB09C9D2BE8", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B1CA0ADD8A8F7B3B24927828", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_A612112B9B2D804037F2F2DB3A67800849F475", 1);
}

updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  self.numcaps++;
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["_encstr_BE7D0633C08849E2"]))
    var_1 = self.timeplayed["_encstr_BE7D0633C08849E2"] / 60;

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(var_0) {
  if(var_0.capsperminute > 3)
    return 1;

  return 0;
}

writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("_encstr_BE7D1176A0484172A6BDAFDFDDC5D983A88BEF", level.kothhillrotation, getteamscore("_encstr_9A8507BA4040188D08"));
    setmatchdata("_encstr_A56F0FEBCBBA96A1576388C18203104ED2", level.kothhillrotation, getteamscore("_encstr_8E8405EA382B2A"));
  }
}

setupzonecallouts() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.zone.visuals[0];

  foreach(var_5 in level.calloutglobals.areatriggers) {
    var_1 = ispointinvolume(var_3.baseorigin, var_5);
    var_2 = isDefined(var_3.script_noteworthy) && isDefined(var_5.script_noteworthy) && var_3.script_noteworthy == var_5.script_noteworthy;

    if(var_1 || var_2) {
      var_0 = level.calloutglobals.areaidmap[var_5.script_noteworthy];

      foreach(var_7 in level.players) {
        if(isDefined(var_0))
          var_7 setclientomnvar("_encstr_997811BA96FAA11C7D1B2C36C6DEAEE87DB491", var_0);
      }

      break;
    }
  }
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level._id_14726))
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 42);
  else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 41);
}