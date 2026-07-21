/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58250.gsc
***********************************************/

activate_minigun() {}

init() {
  if(getdvarint("_encstr_8895213736E4FAD8A195B5B4D82C63BE33B0C6A3DEE4CBEB1DC90B38AF2C6C1D4BEC56", 0) == 1) {
    level._effects["_encstr_A9D716AB4BEAA7501C7F3D9FE1BA66518F727347F3F5CBC9"] = loadfx("_encstr_910B311D96F092533F5F3E81E3061D28CBE199B33DDD9088D392D22ECA17C6F8E552F35FB402706F4F7AAB50C3D30DE93FD96F");
    level thread table_getaddblueprintattachments();
  }
}

table_getaddblueprintattachments() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  scripts\engine\scriptable::_id_12F5B("_encstr_99520FC6103075D2BFCD7F731BDD9BBFB0", ::plunder_repositorysendcountdownmessage);
  var_0 = easepower("_encstr_ABFA1F6E8D93B4E0A31689B12BBE36D0CAB58D5826D71D39C283BE4CABD1A3ED37", (3459.75, 37679, 1193.75), (75, 223.998, 179.999));
  var_0 setscriptablepartstate("_encstr_99520FC6103075D2BFCD7F731BDD9BBFB0", "_encstr_AB0703DBB9");
  level.getteamspawnbots = spawnStruct();
  level.getteamspawnbots.plunderatcapacity = getdvarint("_encstr_BD40246CD0B25BB1C24CEB953B2B37D1BE9D58B93AC916077DE89396763B2BC9BEEEA532E80D", 750);
  level.getteamspawnbots.plunder_updaterepositorywidgetforplayer = getdvarint("_encstr_A93C251B432B6BD885987D5967B2E61DAF762C9BA3E40BE07DD193D2B3B3954EAF36ACE6ECA31A", 750);
  level.getteamspawnbots.plunder_updateanchoredwidgetforplayers = getdvarint("_encstr_9BF0253FF019D57A03F6198FE4231274E620AFF7E813118327955A8444DF7A3A8EC03767D8085C", 240);
  level.getteamspawnbots.plunder_tenpercent_music = getdvarint("_encstr_8A6A28D81A2BD6C6C231D756CEB2DCD17DD92CCDD14E0B38D71D27969DB35639D732ABE493853AB4F637", 30);
  level.getteamspawnbots.plunder_thirtypercent_music = getdvarint("_encstr_992A26B7D322C118E11E663903CDC08539472B1FDB3B9FC00777A930EEB7C0A823D7853F73525650", 8);
  level.getteamspawnbots.plunder_repositoryusecallback = getdvarint("_encstr_B14B208D86B2B5362C987DB2B3CA9BD1FA9D0BB91D4E2CC1EB475A365BAFC9C23A59", 1);
  level.getteamspawnbots.plunder_items_dropped = getdvarint("_encstr_AB9A22F08BEF68B409F2EFE918736834B79F4910ABBA8B326F3640926380D92A902B32D3", 100.0);
  level.getteamspawnbots.plunder_items_picked_up = getdvarint("_encstr_AB1520B10D565BB1B0C4BEB2D956373AAFEC16DCE8390B1CAF99968DB1FA93C24759", 1);
  level.getteamspawnbots.plunder_repositoryusescriptablecallback = getdvarint("_encstr_A2341F7713E201D8A15E2679438D80C5F987EBDF9B7BDF83C7762830ED7450FC82", 10);
  level.getteamspawnbots.plunder_deregisterrepositoryinstance = [];
  level.getteamspawnbots.plundercountroll = plunderusable();
  level.getteamspawnbots._id_11A70 = plunderusedisabledwhenempty();
}

plunderusable() {
  var_0 = [];
  var_0[var_0.size] = (2987, 37243, 600);
  return var_0;
}

plunderusedisabledwhenempty() {
  var_0 = [];
  var_0[var_0.size] = (2808, 36760, 672);
  var_0[var_0.size] = (3320, 37248, 672);
  var_0[var_0.size] = (2792, 36760, 672);
  var_0[var_0.size] = (2496, 37048, 672);
  var_0[var_0.size] = (2832, 37352, 672);
  var_0[var_0.size] = (3176, 37656, 672);
  var_0[var_0.size] = (3056, 37304, 672);
  var_0[var_0.size] = (2776, 36720, 672);
  var_0[var_0.size] = (2432, 37024, 688);
  var_0[var_0.size] = (3056, 37304, 912.25);
  var_0[var_0.size] = (3088, 37632, 912.25);
  var_0[var_0.size] = (3376, 37616, 912.25);
  var_0[var_0.size] = (3384, 37288, 912.25);
  var_0[var_0.size] = (3040, 36960, 912.25);
  var_0[var_0.size] = (2696, 37104, 912.25);
  var_0[var_0.size] = (2864, 37448, 912.25);
  var_0[var_0.size] = (3136, 37224, 912.25);
  var_0[var_0.size] = (2776, 36720, 912.25);
  var_0[var_0.size] = (2448, 37048, 912.25);
  var_0[var_0.size] = (3216, 37848, 912.25);
  var_0[var_0.size] = (3560, 37512, 912.25);
  return var_0;
}

activate_laser_from_struct() {}

plunder_repositorysendcountdownmessage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "_encstr_BA19049F4B2D") {
    level thread _id_13CF3(var_0.origin);
    var_0 setscriptablepartstate(var_1, "_encstr_BA19049F4B2D");
    plunder_repositoryinstanceisregistered(var_0, var_1);
  }
}

plunder_repositoryinstanceisregistered(var_0, var_1) {
  foreach(var_3 in level.getteamspawnbots.plundercountroll) {
    var_4 = getEnt("_encstr_85B3166D19785ED911E3936FEFC5029AD021E779D3F017B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = plunder_repositoryplayerplundereventcallback(var_4);
    var_5 thread plunder_extraction_site_active();
    var_5 thread _id_12A3D(var_0, var_1);
  }
}

_id_12A3D(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BEE809A3785B486AA5FE17");
  wait(level.getteamspawnbots.plunder_repositoryusescriptablecallback);
  var_0 setscriptablepartstate(var_1, "_encstr_AB0703DBB9");
}

_id_13CF3(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  playsoundatpos(var_0, "_encstr_85951A5A366D79F2DB6107138090A421235EB2C2078FF2344140270B");
  wait 1;
  playsoundatpos(var_0, "_encstr_85951A5A366D79F2DB6107138090A421235EB2C2078FF2344140270B");
  wait 1;
  playsoundatpos(var_0, "_encstr_85951A5A366D79F2DB6107138090A421235EB2C2078FF2344140270B");
  wait 1;
}

plunder_repositoryplayerplundereventcallback(var_0) {
  var_1 = var_0;

  if(!isDefined(var_1))
    var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", level.getteamspawnbots.plundercountroll[0], 0, level.getteamspawnbots.plunderatcapacity, level.getteamspawnbots.plunder_updateanchoredwidgetforplayers);

  var_1.location = "_encstr_BA5609B6855ACDFA8D5889";
  scripts\mp\utility\trigger::makeenterexittrigger(var_1, ::plunder_repositoryatcapacity, ::plunder_repositoryclearcountdown, undefined, undefined, ::plunder_ninetypercent_music);
  var_1 thread plunder_playerrepositoryuseshouldsucceed(var_1.location);
  level.getteamspawnbots.plundervar[var_1.location] = var_1;
  var_1.intel_loc = 100;
  var_1.active = 0;
  return var_1;
}

plunder_infils_ready() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BEE809A3785B486AA5FE17");
  var_0 = 100;

  for(;;) {
    if(var_0 < self.intel_loc)
      var_0 = var_0 + 50;

    wait 0.1;
  }
}

plunder_playerrepositoryuseshouldsucceed(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  switch (var_0) {
    case "_encstr_BA5609B6855ACDFA8D5889":
      thread setup_comms_obj();
      break;
    case "_encstr_8B1608EC43B8D647A113":
      break;
  }
}

setup_comms_obj() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = [];

  foreach(var_2 in level.getteamspawnbots._id_11A70) {
    var_3 = easepower("_encstr_B4B418885A20FF29EB35E1F004F731378B83B840213E21E0F75C", var_2, (0, 0, 0));
    var_0[var_0.size] = var_3;
    var_3 setscriptablepartstate("_encstr_93A01817B86579B149B9A521A31287F34F138D787389D7C506C8", "_encstr_BE8B08E323FB2BCD6268");
    var_3 setscriptablepartstate("_encstr_87A01816C0E0A531897B3BD749AE9AF089094D9D9B234FCBD421", "_encstr_AB0703DBB9");
    waitframe();
  }

  self.active = 1;
  self waittill("_encstr_BEE809A3785B486AA5FE17");

  foreach(var_6 in self.triggerenterents)
  var_6 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_960411D81AB2ADF533166C1D7B4E2FAF76B0DC");

  foreach(var_9 in var_0) {
    var_9 setscriptablepartstate("_encstr_93A01817B86579B149B9A521A31287F34F138D787389D7C506C8", "_encstr_95DF070DD22319CA9B");
    var_9 thread _id_11A6F();
  }
}

_id_11A6F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5.7;
  self freescriptable();
}

plunder_repositoryatcapacity(var_0, var_1) {
  var_0 thread plunder_repositoryendcountdown(var_1);
}

plunder_repositoryclearcountdown(var_0, var_1) {
  var_0 notify("_encstr_959D14CF9B55990750B64A9568A05FC2B8CF4B5733F5");
  var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_960411D81AB2ADF533166C1D7B4E2FAF76B0DC");
}

plunder_ninetypercent_music(var_0, var_1) {
  if(!isDefined(var_0) || !isPlayer(var_0))
    return 1;

  return 0;
}

plunder_extraction_site_active() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait(level.getteamspawnbots.plunder_items_picked_up);

    if(self.intel_loc >= level.getteamspawnbots.plunderatcapacity) {
      break;
    }

    self.intel_loc = self.intel_loc + level.getteamspawnbots.plunder_items_dropped;
  }

  wait(level.getteamspawnbots.plunder_tenpercent_music);
  self notify("_encstr_BEE809A3785B486AA5FE17");
  self.active = 0;
}

plunder_repositoryendcountdown(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_959D14CF9B55990750B64A9568A05FC2B8CF4B5733F5");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    wait(level.getteamspawnbots.plunder_repositoryusecallback);

    if(istrue(self.start_death_from_above_sequence)) {
      continue;
    }
    if(istrue(var_0.active)) {
      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrepositoryref("_encstr_960411D81AB2ADF533166C1D7B4E2FAF76B0DC");
        scripts\cp_mp\gasmask::processdamage(level.getteamspawnbots.plunder_thirtypercent_music);
        continue;
      }

      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_960411D81AB2ADF533166C1D7B4E2FAF76B0DC");

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(level.getserverroomspawnpoint.plunder_getleveldataforrepository);
      else
        self dodamage(level.getteamspawnbots.plunder_thirtypercent_music, var_0.origin, var_0, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");

      _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_13E18();
    }
  }
}