/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\brclientmatchdata.gsc
***********************************************/

getquestrewardgroupindex() {
  if(isDefined(level._id_12B1A)) {
    return;
  }
  level._id_12B1A = [];
  var_0 = [[level.getplunderextractionsites]]();
  var_1 = [[level.getnextpayloadspawnmodule]]();

  if(var_0.size < 1 || var_1.size < 1) {
    return;
  }
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_5, var_4 in var_2) {
    if(!isDefined(level._id_12B1A[var_4.checkpoint]))
      level._id_12B1A[var_4.checkpoint] = [];

    level._id_12B1A[var_4.checkpoint][var_5] = var_4;
  }
}

getpresettruckspawns(var_0, var_1) {
  if(!isDefined(level._id_12B19))
    level._id_12B19 = [];

  level._id_12B19[var_0] = var_1;
}

getprophealth(var_0) {
  setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", var_0);
  setDvar(level.mapname + "_encstr_B4580B18900D4FFAE3A7CAC953", "_encstr_B40101");
  setomnvar("_encstr_A1E7118383366850E1B0F997DB8822F7A0606B", 1);
}

getoperatorspecificaccessoryweapon(var_0, var_1) {
  var_2 = level._id_12B1A[var_0];

  foreach(var_4 in var_2) {
    if(var_4.type != var_1) {
      continue;
    }
    if(var_4.checkpoint != var_0) {
      continue;
    }
    if(isDefined(var_4.inuse)) {
      continue;
    }
    switch (var_1) {
      case "_encstr_831C0DD98B0F8FB5F227DB8BE1FBC8":
        var_4.inuse = 1;
        return var_4;
      case "_encstr_8471166C859CCAE02CD86D16EC95EBB6BA374BE8A5F6CDB9":
      case "_encstr_8F180CCB17EB37825B883A9240BB":
        return var_4;
    }
  }
}

getpreviousplacement(var_0) {
  var_0 scripts\engine\utility::_id_143A5("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_8D820B49520F0EC02DDE6367EC");

  while(scripts\cp\utility::any_player_nearby(self.origin, 64))
    wait 1;

  self.inuse = undefined;
}

getnextprop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level._id_12B19[var_0])) {
    return;
  }
  var_1 = getoperatorspecificaccessoryweapon(var_0, "_encstr_8F180CCB17EB37825B883A9240BB");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("_encstr_9BBA2105BB0834A3C7331379F92F63EF4013839BC3287F47574389F2E373776538E121");
  var_3 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_4 linkTo(var_2);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + (0, 0, 35));
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_BACF179F48C189254390945D1EF7F581ABEF390FC17F21ED63", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BECC055CF3811A", 256, 75, 128, 75);
  var_5.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_5.headicon, "_encstr_B10119D463E897520E670BD7472DABF638AB0E5DDE9875EADF0F03");
  setheadicondrawthroughgeo(var_5.headicon, 0);
  setheadiconsnaptoedges(var_5.headicon, 1024);
  setheadiconmaxdistance(var_5.headicon, 256);
  addclienttoheadiconmask(var_5.headicon, -5);
  var_2.collision = var_4;
  var_2.interaction = var_5;
  var_5 thread getnextcombatareaid(var_2);
  return var_2;
}

getnextcombatareaid(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_1 thread getnextsafecircleradius(self);
  }
}

getnextsafecircleradius(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 disableplayeruse(self);
  level thread scripts\mp\vehicles\vehicle_damage_mp::_id_11952(self, var_0);
  self setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -1);
  self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  scripts\engine\utility::_id_143A5("_encstr_B4C40E582257FDB09BB4077FC103B8B0", "_encstr_A26014B9FAC2217A9FF9B95DA585BB79A34CFFD8CD71");
  wait 1;
  self setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -2);
  var_0 enableplayeruse(self);
}

getnextrpgspawnmodule(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = 0;

  if(istrue(level.little_bird_mg_cp_spawncallback)) {
    switch (var_0) {
      case "_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43":
      case "_encstr_8215098EAD8EBCB1AF1C26":
      case "_encstr_A9CA0DDB6A4D88A0C312915919234F":
      case "_encstr_87B80821127338B81BE6":
      case "_encstr_A27A069DF177CBE3":
      case "_encstr_957A062DA3C7A23F":
      case "_encstr_B47A06BDB537ABF6":
      case "_encstr_8A12071CD08B1F423B":
        var_4 = 1;
        break;
    }

    if(var_4)
      return;
  }

  var_5 = getoperatorspecificaccessoryweapon(var_0, "_encstr_8471166C859CCAE02CD86D16EC95EBB6BA374BE8A5F6CDB9");

  if(!isDefined(var_5) || !isDefined(var_5.origin)) {
    return;
  }
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
  var_6.angles = var_5.angles;
  var_7 = (0, 0, 35);
  var_8 = "_encstr_BD1805CB69C063";
  var_9 = undefined;
  var_10 = undefined;

  if(!istrue(var_3)) {
    var_6 setModel("_encstr_8CBA1B51BC223353B91BCB3937D1EB538B26DEEA164AE3FE302E29100F");
    var_11 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
    var_12.angles = var_5.angles;
    var_12 clonebrushmodeltoscriptmodel(var_11);
    var_12 linkTo(var_6);
    var_6.collision = var_12;

    if(isDefined(var_0) && var_0 == "_encstr_A27C0A1AFD2D3ABE39C85F0B") {
      level.checkpoint = "_encstr_A27C0A1AFD2D3ABE39C85F0B";
      var_7 = var_7 + (-10, 25, 0);
      var_9 = (10, -25, 35);
    }
  } else {
    var_6 setModel("_encstr_9B8528AD5A1BD247589C2FFAA117F56C4E583A2BFA0698BE0EC9DB0FCBD71B0EEBCD1C0BDD738598632B");
    var_6 setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_AB0703DBB9");
    var_6._id_14057 = 1;
    var_7 = var_7 + rotatevector((18.5, 16.6, 2), var_6.angles);
    var_8 = "_encstr_BECC055CF3811A";
    var_9 = (0, 0, 35) + rotatevector((18.5, -14.6, 2), var_6.angles);
  }

  level thread getnearestbombsiteteam(var_9, var_5, var_6, var_1, var_2, var_3, var_8);
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin + var_7);
  var_13 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_13 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_BEED19DB39614AF38E84B4E8206DCBB451BF5D75AD09434FD85C99", 1, "_encstr_82370F09B522B08D175A6876A32BC8E07B", var_8, 256, 75, 128, 75);
  var_6.interaction = var_13;
  var_13.get_distance_to_closest_teammate = var_6;
  var_13._id_11E0E = var_1;
  var_13._id_11E0D = var_2;
  var_13._id_14057 = var_3;
  var_13 thread getnextcircleindex(var_6);
  return var_6;
}

getnearestbombsiteteam(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + var_0);
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

    if(!isDefined(var_6))
      var_6 = "_encstr_BECC055CF3811A";

    var_7 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_8258140D827D4DA294255AA279A8444AA2FA92F4268A", 1, "_encstr_82370F09B522B08D175A6876A32BC8E07B", var_6, 256, 75, 128, 75);
    var_2._id_12D7E = var_7;
    var_7.get_distance_to_closest_teammate = var_2;
    var_7._id_11E0E = var_3;
    var_7._id_11E0D = var_4;
    var_7._id_14057 = var_5;
    var_7 thread getnemesis(var_2);
  }
}

getnextcircleindex(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  thread getnumbersspawnpoint();
  thread getnumbersspawnpoint_late();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(var_1.little_bird_mg_enterendinternal)) {
      continue;
    }
    var_1 thread getnextspectatecandidatefromchain(self);
  }
}

getnemesis(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  thread getoffsetspawnoriginmultitrace();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(var_2.little_bird_mg_enterendinternal)) {
      continue;
    }
    var_2 thread getobjectiveflag(self);
  }
}

getoffsetspawnoriginmultitrace() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_AB7F1692281067F74963B5A60378BC4FC863E91BB3F8AB2F");
  self makeunusable();
}

getnumbersspawnpoint_late() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AB7F1692281067F74963B5A60378BC4FC863E91BB3F8AB2F");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);
    level thread getnumdrops(var_0, self);
  }
}

getnumbersspawnpoint() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  var_0 = 38;

  if(istrue(self._id_14057))
    var_0 = 22;

  self.objicon = scripts\cp\cp_objectives::requestworldid("_encstr_849E1398B0BD8F4BF798081078F80B3B3998102B6A", 25);
  objective_setplayintro(self.objicon, 0);
  objective_setbackground(self.objicon, 1);
  objective_state(self.objicon, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(self.objicon, "_encstr_8C9323ABC3DA27B8F337F081BF1D13BDD2AB9721D1423340D46F28E0CF2148B7DB951FB975");
  var_1 = self.origin;

  if(isDefined(level.checkpoint) && level.checkpoint == "_encstr_A27C0A1AFD2D3ABE39C85F0B") {
    var_0 = 75;
    var_1 = self.get_distance_to_closest_teammate.origin;
  }

  objective_position(self.objicon, var_1 + (0, 0, var_0));
  objective_setshowdistance(self.objicon, 0);
  objective_sethot(self.objicon, 0);
  objective_setpinned(self.objicon, 0);
  objective_hidefromplayersinmask(self.objicon);
  objective_removeallfrommask(self.objicon);
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 2.5;
  var_2 = 1;
  var_3 = 60;
  var_4 = 0.1;

  if(isDefined(self._id_11E0D))
    var_3 = self._id_11E0D;

  var_5 = var_4 / var_3;

  if(isDefined(self._id_11E0E))
    level waittill(self._id_11E0E);

  objective_showprogressforteam(self.objicon, "_encstr_9A8507BA4040188D08");

  while(var_2 > 0) {
    objective_setprogress(self.objicon, var_2);
    wait(var_4);
    var_2 = var_2 - var_5;

    if(var_2 < 0)
      var_2 = 0;
  }

  level notify("_encstr_AB7F1692281067F74963B5A60378BC4FC863E91BB3F8AB2F");
  self makeunusable();

  foreach(var_7 in level.players) {
    if(var_7 calloutmarkerping_entityzoffset("_encstr_83A50C1B07BEB70E2B73FAD885C6") == 3)
      var_7 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -2);
  }

  if(istrue(self._id_14057))
    self.get_distance_to_closest_teammate setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_BA19049F4B2D");
  else {
    self.get_distance_to_closest_teammate setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_95EB0866891B23FB85B3", 0);
    self.get_distance_to_closest_teammate setscriptablepartstate("_encstr_95EB0866891B23FB85B3", "_encstr_99AD06D3A5B1538B", 0);
    self.get_distance_to_closest_teammate.collision delete();
  }

  scripts\cp\cp_objectives::freeworldid("_encstr_849E1398B0BD8F4BF798081078F80B3B3998102B6A");
}

getnumdrops(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_AB7F1692281067F74963B5A60378BC4FC863E91BB3F8AB2F");

  if(istrue(var_0._id_13C50)) {
    return;
  }
  var_0._id_13C50 = 1;
  wait 3;

  for(;;) {
    var_2 = distance2dsquared(var_0.origin, var_1.origin);

    if(isDefined(var_2) && var_2 > 262144) {
      if(!istrue(var_0.spawn_enemy_drone_turret)) {
        objective_addclienttomask(var_1.objicon, var_0);
        var_0.spawn_enemy_drone_turret = 1;
      }
    } else if(isDefined(var_2) && var_2 <= 262144) {
      if(isDefined(var_0.spawn_enemy_drone_turret)) {
        objective_removeclientfrommask(var_1.objicon, var_0);
        var_0.spawn_enemy_drone_turret = undefined;
      }
    }

    wait 0.5;
  }
}

getnextspectatecandidatefromchain(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AB7F1692281067F74963B5A60378BC4FC863E91BB3F8AB2F");
  var_0 disableplayeruse(self);
  self setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", 3);
  wait 1;
  var_0 enableplayeruse(self);
}

getobjectiveflag(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AB7F1692281067F74963B5A60378BC4FC863E91BB3F8AB2F");
  var_0 disableplayeruse(self);
  self._id_12D7D = 1;
  self setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", 5);
  wait 1;
  var_0 enableplayeruse(self);
}

getnearbyaliveplayer(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "_encstr_831C0DD98B0F8FB5F227DB8BE1FBC8";
  var_3.checkpoint = var_0;
  return var_3;
}

getmaxoutofboundsbrtime(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "_encstr_8F180CCB17EB37825B883A9240BB";
  var_3.checkpoint = var_0;
  return var_3;
}

getminigundamagescale(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "_encstr_8471166C859CCAE02CD86D16EC95EBB6BA374BE8A5F6CDB9";
  var_3.checkpoint = var_0;
  return var_3;
}