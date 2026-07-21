/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\respawn\cp_ac130_respawn.gsc
***********************************************/

start_ac130_respawn_sequence(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3)) {
    if(!isDefined(level.br_ac130)) {
      var_4 = get_path_over_players(var_0, var_2);
      thread spawnc130(var_4);
    }
  }

  if(!isDefined(var_1))
    var_1 = level.players_in_respawn_queue;

  foreach(var_6 in var_1) {
    if(istrue(var_6.binc130)) {
      continue;
    }
    var_6 scripts\cp\respawn\cp_respawn::do_resurrection_logic(var_2);
    var_6 notify("_encstr_956C0F7507A3AF90D73D46BBA5A9186DCB", 1);
    var_6 thread start_black_screen(var_6);
  }
}

spawnc130(var_0, var_1, var_2) {
  var_3 = distance(var_0.startpt, var_0.endpt);
  var_4 = var_3 / 3044;

  if(istrue(var_1)) {
    var_2 endon("_encstr_AD75063D571AE108");

    if(!isDefined(level.respawn_c130[var_2.name])) {
      level.respawn_c130[var_2.name] = gunship_spawn(var_0.startpt, var_0.endpt, var_4, var_1, var_0, var_2);
      level.respawn_c130[var_2.name]._id_12205 = var_0;
    }
  } else
    level.br_ac130 = gunship_spawn(var_0.startpt, var_0.endpt, var_4, undefined, var_0);

  return var_4;
}

gunship_spawn(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6 setModel("_encstr_990B1C90532CF2E013E390766B4B32295251A22EDAB04B7291E62F9F07DA");
  var_6 setCanDamage(0);
  var_6.maxhealth = 100000;
  var_6.health = var_6.maxhealth;
  var_6.dir = vectorNormalize(var_1 - var_0);
  var_6.angles = vectortoangles(var_6.dir);
  var_6.dir = vectorNormalize(var_1 - var_0);
  var_6.angles = vectortoangles(var_6.dir);
  var_6.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  var_6.currentplayeroffset = 0;
  var_6.player_queue = [];
  var_6._id_12205 = var_4;
  var_6 thread gunship_startintroshake();

  if(istrue(var_3)) {
    level.respawn_c130[var_5.name] = var_6;
    level.respawn_c130[var_5.name] hide();
    level.respawn_c130[var_5.name] thread _id_14460(var_5);
    level.respawn_c130[var_5.name] endon("_encstr_AD75063D571AE108");
  } else
    level.br_ac130 = var_6;

  while(var_6.player_queue.size <= 0)
    waitframe();

  foreach(var_8 in var_6.player_queue) {}

  var_6 moveTo(var_1, var_2);
  var_6 thread killaftertime(var_2);
  var_6 playLoopSound("_encstr_9AD91096EE07AFD6B9F5166C896603AF3683");
  return var_6;
}

_id_14460(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.innards))
    self.innards delete();

  self delete();
}

gunship_startintroshake() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = level.scr_anim["_encstr_86FD08B775CD07DC1338"]["_encstr_A66F0ED43B8287503193B10883446BC7"];
  var_1 = getanimlength(var_0);
  var_2 = var_1;
  var_3 = 0.45;
  var_4 = 0.05;

  while(var_2 > 0) {
    earthquake(var_3, var_4, self.origin, 5000);
    var_3 = var_3 - 0.01;

    if(var_3 <= 0.12)
      var_3 = 0.12;

    var_2 = var_2 - var_4;
    wait(var_4);
  }
}

showicon() {
  var_0 = scripts\cp\utility::nonobjective_requestobjectiveid(10);

  if(var_0 == -1)
    return -1;

  scripts\mp\objidpoolmanager::objective_add_objective(var_0, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var_0, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_0, "_encstr_930B07BB1B6B3854FF");
  var_1 = "_encstr_A26F161C306860B15F6053C34D33BBA17A2DBA6048E1B3B7";
  scripts\mp\objidpoolmanager::update_objective_icon(var_0, var_1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
  self.objid = var_0;
}

gunship_spawnvfx() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level._effect["_encstr_A14018B3CCF0AFCDE60B3A8DA17D5836139981F51B8DDEBA23DC"])) {
    return;
  }
  wait 1;
  playFXOnTag(level._effect["_encstr_A14018B3CCF0AFCDE60B3A8DA17D5836139981F51B8DDEBA23DC"], self, "_encstr_8F1E092CC9F71178C01941");
}

killaftertime(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(isDefined(self.players)) {
    foreach(var_2 in self.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_2.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
      var_2 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
      var_2 notify("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82");
      var_2.kickedfromc130 = 1;
    }
  }

  wait 0.1;

  if(isDefined(self.innards))
    self.innards delete();

  self delete();
}

expandspawnpointbounds(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    var_1 = expandmins(var_1, var_4);
    var_2 = expandmaxs(var_2, var_4);
  }
}

expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0])
    var_0 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] > var_1[1])
    var_0 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] > var_1[2])
    var_0 = (var_0[0], var_0[1], var_1[2]);

  return var_0;
}

expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0])
    var_0 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] < var_1[1])
    var_0 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] < var_1[2])
    var_0 = (var_0[0], var_0[1], var_1[2]);

  return var_0;
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

get_path_over_players(var_0, var_1, var_2) {
  if(trial_ui_decrease_tries_remaining())
    return quest_assdistmax(var_0, var_1, var_2);

  return forcegivekillstreak(var_0, var_1);
}

forcegivekillstreak(var_0, var_1) {
  var_2 = 30000;
  var_3 = 1000;
  var_4 = 300;
  var_5 = [];

  foreach(var_7 in level.players) {
    if(!var_7 isonground() || istrue(var_7.inlaststand)) {
      continue;
    }
    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  if(var_5.size > 0)
    var_9 = getaverageorigin(var_5);
  else
    var_9 = scripts\engine\utility::drop_to_ground(var_0);

  if(isDefined(var_1) && isPlayer(var_1))
    var_0 = var_1.origin;

  var_9 = (var_0[0], var_0[1], 4333);
  var_10 = [40000, 20000, 15000, 7000, 4500, 2500, 1000, 0];
  var_11 = (0, randomfloatrange(0, 360), 0);
  var_11 = (0, getdvarfloat("_encstr_BE0C15DFB71B90503A99397BAA40F937D303331D4F2245", var_11[1]), 0);
  var_12 = anglesToForward(var_11);
  var_13 = 2;
  var_14 = var_10[4];
  var_15 = var_9 - var_12 * var_14 + (0, 0, abs(4333 - var_4));
  var_16 = var_9 + var_12 * var_14 * var_13;
  var_15 = var_15 - var_12 * 3044 * 2;
  var_16 = var_16 + var_12 * 3044;
  var_15 = var_0 + (-5000, 0, 4333);
  var_16 = var_0 + (5000, 0, 4333);
  var_17 = spawnStruct();
  var_17.startpt = var_15;
  var_17.endpt = var_16;
  var_17.angle = var_11;
  var_17.modevalidatekillstreakslot = var_9;
  return var_17;
}

quest_assdistmax(var_0, var_1, var_2) {
  if(!isDefined(level.initlethalmaxoffsetmap)) {
    return;
  }
  if(!isstring(level.initlethalmaxoffsetmap)) {
    return;
  }
  if(isDefined(level.initlocationcircle))
    level.initlethalmaxoffsetmap = level.initlocationcircle;

  var_3 = scripts\engine\utility::getStructArray(level.initlethalmaxoffsetmap, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3[0];

  if(var_3.size > 1) {
    if(isDefined(var_3[1].name))
      var_4 = var_3[1];
    else
      var_4 = var_3[0];
  }

  var_5 = "_encstr_B40101";

  if(!isDefined(var_4)) {
    if(isDefined(level._id_12880) && level._id_12880.size > 0) {
      for(var_6 = level._id_12880.size - 1; var_6 >= 0; var_6--) {
        if(isDefined(level._id_12880[var_6])) {
          var_7 = scripts\engine\utility::getStructArray(level._id_12880[var_6], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

          if(isDefined(var_7) && var_7.size > 0)
            var_5 = level._id_12880[var_6];

          break;
        }
      }

      if(var_5 == "_encstr_B40101")
        return forcegivekillstreak(var_0, var_1);

      var_3 = scripts\engine\utility::getStructArray(var_5, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_4 = var_3[0];

      if(var_3.size > 1) {
        if(isDefined(var_3[1].name))
          var_4 = var_3[1];
        else
          var_4 = var_3[0];
      }

      level.initlethalmaxoffsetmap = var_5;
    } else
      return forcegivekillstreak(var_0, var_1);
  }

  if(!scripts\engine\utility::array_contains(level._id_12880, level.initlethalmaxoffsetmap))
    level._id_12880 = scripts\engine\utility::array_add(level._id_12880, level.initlethalmaxoffsetmap);

  var_8 = var_4.origin;

  if(istrue(var_2) && level.respawn_c130.size > 1) {
    if(level.respawn_c130.size % 2 == 0)
      var_9 = (var_8[0], var_8[1], 4633);
    else
      var_9 = (var_8[0], var_8[1], 4033);
  } else
    var_9 = (var_8[0], var_8[1], 4333);

  var_10 = (0, randomfloatrange(0, 360), 0);
  var_10 = (0, getdvarfloat("_encstr_AD23136E8D4EFAE4B2CD0EC2BBE6F5169B9D8D56B9", var_10[1]), 0);
  var_11 = anglesToForward(var_10);
  var_12 = 7000;
  var_13 = var_9 - var_11 * var_12;
  var_14 = var_9 + var_11 * var_12;
  var_13 = var_13 - var_11 * getc130speed() * 7;
  var_14 = var_14 + var_11 * getc130speed() * 5;
  var_15 = spawnStruct();
  var_15.startpt = var_13;
  var_15.endpt = var_14;
  var_15.modevalidatekillstreakslot = var_9;
  var_15.angle = vectortoangles(var_11);
  var_15._id_11F8C = var_8;
  return var_15;
}

getc130speed() {
  return 3044;
}

trial_ui_decrease_tries_remaining() {
  if(isDefined(level.initlocationcircle))
    return 1;

  if(scripts\engine\utility::getStructArray("_encstr_829C0ECBDFFB083FE3231F490F2AF070", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").size > 0)
    return 1;

  if(level.script == "_encstr_AC7F0DE0FB29E7698F7CA5254DFFB3" || level.script == "_encstr_BE1D0DD8E07D46BB37F5E8BB73AFC8" || level.script == "_encstr_86A90F8D07AF0B4EB6E67DC82B2C36AC39" || level.script == "_encstr_93580C1B837DB9DAAECED936B239" || level.script == "_encstr_AC850C5F503EB4CA3DD5F52DC6C1")
    return 1;

  return 0;
}

_id_131D9() {
  switch (level.script) {
    case "_encstr_AC7F0DE0FB29E7698F7CA5254DFFB3":
      level._id_12880 = ["_encstr_83F00E0229E3C25CC660BFF720F9125B", "_encstr_A54E0C905A2303D079D8795BFEDF"];
      break;
    case "_encstr_BE1D0DD8E07D46BB37F5E8BB73AFC8":
      level._id_12880 = ["_encstr_A19E0CD5B92F93A976E813639048"];
      break;
    case "_encstr_8A37107778166123D3B60F4797E96A3ABEF2":
      level._id_12880 = ["_encstr_83F00E0229E3C25CC660BFF720F9125B"];
      break;
    case "_encstr_86A90F8D07AF0B4EB6E67DC82B2C36AC39":
      level._id_12880 = ["_encstr_93D90AD6F627B036CA6ED7C4"];
      break;
    case "_encstr_93580C1B837DB9DAAECED936B239":
      level._id_12880 = ["_encstr_8DD40BAF059011477FB95AB283"];
      break;
    case "_encstr_AC850C5F503EB4CA3DD5F52DC6C1":
      level._id_12880 = ["_encstr_A7280AF6C4D4AF8ED68E97D8"];
      break;
    case "_encstr_96250E8F105945B875F131AFB3CBAEB7":
      level._id_12880 = ["_encstr_833407DEB619332895"];
      break;
  }
}

getaverageorigin(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size)
    return undefined;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

start_black_screen(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 playerhide();
  scripts\cp\cp_outofbounds::enableoobimmunity(var_0);
  var_0 setCanDamage(0);
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  var_0 setclientomnvar("_encstr_8458126ADB72B388EE97AADFFF8F316808CB60EA", 1);
  var_0 disableweapons();
  var_2 = newclienthudelem(var_0);
  var_2.x = 0;
  var_2.y = 0;
  var_2.alignx = "_encstr_A5AD056A019C63";
  var_2.aligny = "_encstr_AC190479FF92";
  var_2.sort = 1;
  var_2.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.alpha = 1;
  var_2.foreground = 1;
  var_2 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_0 scripts\cp\utility::giveperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
  var_0 scripts\cp\utility::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
  var_0 scripts\cp\utility::giveperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  var_0 scripts\cp\utility::giveperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
  var_0 scripts\cp\utility::freezecontrolswrapper(1);

  if(istrue(var_1)) {
    var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    var_0.no_outline = 1;
    var_0.no_team_outlines = 1;
    var_0 scripts\cp\utility::giveperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
    var_0 scripts\cp\utility::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
    var_0 scripts\cp\utility::giveperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
    var_0 scripts\cp\utility::giveperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
    var_0 playerhide();

    while(!isDefined(level.respawn_c130[var_0.name]))
      wait 1;

    var_0 cameraset("_encstr_9341135A60B3B1DF1366393C9079E3C9D318E7D752");
    var_0 setadditionalstreampos(level.respawn_c130[var_0.name].origin, 1);
    var_0 setOrigin(level.respawn_c130[var_0.name].origin);
    var_0 setplayerangles(level.respawn_c130[var_0.name].angles);
    var_0 playerlinkTo(level.respawn_c130[var_0.name], "_encstr_B40101");
    var_0 thread scripts\cp\cp_globallogic::open_loadout_menu();
    var_0 notify("_encstr_93E5126FC75143212990F29AA823A3CF0825E60D");
    var_0 waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
    var_0 thread scripts\cp\respawn\cp_respawn::_id_12768(0.0, 1.5, 1, "_encstr_998806DD1A96D12B");

    if(level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998") {
      var_0 setclientomnvar("_encstr_8BCB112DF3390A3B3A66FB3F820F10911F73FD", "_encstr_877508C1D8C22F2DDC3B");

      if(!istrue(self._id_11B20))
        var_0 scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
    }

    var_0.no_outline = 1;
    var_0.no_team_outlines = 1;
    var_0 scripts\cp\utility::giveperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
    var_0 scripts\cp\utility::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
    var_0 scripts\cp\utility::giveperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
    var_0 scripts\cp\utility::giveperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
    level.respawn_c130[var_0.name] show();
    wait 1;
    playfxontagforclients(level._effect["_encstr_9BBD0C0B0BF2620FC6F072DB1926"], level.respawn_c130[var_0.name], "_encstr_8F1E092CC9F71178C01941", var_0);
    playfxontagforclients(level._effect["_encstr_92970C36989918EBB196D91A47CD"], level.respawn_c130[var_0.name], "_encstr_8F1E092CC9F71178C01941", var_0);
    var_0 playerhide();
  } else {
    var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    playfxontagforclients(level._effect["_encstr_9BBD0C0B0BF2620FC6F072DB1926"], level.br_ac130, "_encstr_8F1E092CC9F71178C01941", var_0);
    playfxontagforclients(level._effect["_encstr_92970C36989918EBB196D91A47CD"], level.br_ac130, "_encstr_8F1E092CC9F71178C01941", var_0);
  }

  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  var_0 thread enable_damage_on_landing();
  level thread spawn_player_into_c130(var_0, var_1);

  if(!scripts\engine\utility::flag("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  var_2 fadeovertime(4);
  var_2.alpha = 0;
  wait 4;
  var_0 enableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_2 destroy();
}

spam_errors_as_prints(var_0, var_1) {
  self notify("_encstr_93F8169B1C85AD7DAC9C39ED39E6BE2C6EAF074EB4CD47CD" + var_0.name);
  self endon("_encstr_93F8169B1C85AD7DAC9C39ED39E6BE2C6EAF074EB4CD47CD" + var_0.name);

  for(;;) {
    iprintln(var_0.name + "_encstr_A26B1FA241EBE9847F980477B90BC82D270E28501B46BD985BC98473C8B619851A" + var_1);
    wait 5;
  }
}

enable_damage_on_landing() {
  scripts\engine\utility::_id_143A6("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20", "_encstr_9674114388CBE9BA412D83FFAF61D2BE51C06B", "_encstr_99C30D224AF34261C338679320F824");
  self setCanDamage(1);
  self.respawn_in_progress = undefined;
  self setclientomnvar("_encstr_8458126ADB72B388EE97AADFFF8F316808CB60EA", 0);
}

spawn_player_into_c130(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(var_1))
    level.respawn_c130[var_0.name].player_queue = scripts\engine\utility::array_add(level.respawn_c130[var_0.name].player_queue, var_0);
  else
    level.br_ac130.player_queue = scripts\engine\utility::array_add(level.br_ac130.player_queue, var_0);

  var_0._id_12982 = 1;
  var_0 unlink();
  var_0 scripts\cp_mp\parachute::freefallstartdefault();

  if(istrue(var_1)) {
    var_0 thread listenjump(level.respawn_c130[var_0.name], 0);

    if(!isbot(var_0))
      var_0 thread orbitcam(level.respawn_c130[var_0.name]);
  } else {
    var_0 thread listenjump(level.br_ac130, 0);

    if(!isbot(var_0))
      var_0 thread orbitcam(level.br_ac130);
  }

  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\utility::_unsetperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
  var_0 scripts\cp\utility::_unsetperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
  var_0 scripts\cp\utility::_unsetperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  var_0 scripts\cp\utility::_unsetperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
  var_0.br_infil_type = "_encstr_969105B1C4CC81";

  if(trial_ui_decrease_tries_remaining()) {
    if(istrue(var_1))
      var_0 thread playerplaydepositanim(level.respawn_c130[var_0.name]);
    else
      var_0 thread playerplaydepositanim(level.br_ac130);
  } else
    var_0 thread forcejumpaftertimeout(1);
}

orbitcam(var_0) {
  self visionsetnakedforplayer("_encstr_B40101", 0);
  self setplayerangles(var_0._id_12205.angle);
  self playerlinkTo(var_0, "_encstr_B40101");
  self cameraset("_encstr_9341135A60B3B1DF1366393C9079E3C9D318E7D752");
}

playerplaydepositanim(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(distance2dsquared(var_0.origin, var_0._id_12205.modevalidatekillstreakslot) <= 1048576) {
      break;
    } else
      waitframe();
  }

  self.jumptype = "_encstr_85790EDF70280D5A99C3E3DFAA7372C0";
  self notify("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82");
}

forcejumpaftertimeout(var_0) {
  wait(var_0);
  self.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
  self notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
  self notify("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82");
}

listenjump(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  self endon("_encstr_972A0CB116378D2BD8BE43B21B2D");
  self endon("_encstr_8F7D08C66A0125438523");
  self waittill("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82");
  self setclientomnvar("_encstr_8458126ADB72B388EE97AADFFF8F316808CB60EA", 0);

  if(scripts\engine\utility::array_contains(var_0.player_queue, self))
    var_0.player_queue = scripts\engine\utility::array_remove(var_0.player_queue, self);

  self._id_12982 = undefined;
  self cameradefault();
  self.br_infil_type = undefined;
  thread parachute(var_0, var_1, 0, 0);
  self notify("_encstr_8F7D08C66A0125438523");
}

parachute(var_0, var_1, var_2, var_3) {
  self unlink();

  if(isDefined(self.br_orbitcam))
    self.br_orbitcam delete();

  if(isDefined(var_0.playeroffsets) && isDefined(var_0.currentplayeroffset)) {
    var_4 = var_0.playeroffsets[var_0.currentplayeroffset];
    self setOrigin(var_0.origin + var_4, 1, 1);
    var_0.currentplayeroffset++;

    if(var_0.currentplayeroffset == var_0.playeroffsets.size)
      var_0.currentplayeroffset = 0;
  } else {
    var_5 = anglesToForward(var_0.angles) * var_0.br_vieworigin;
    self setOrigin(var_0.origin + var_5, 1, 1);
  }

  waitframe();
  self playershow(1);

  if(istrue(var_2))
    self setplayerangles((0, var_0.angles[1] + 180, 0));
  else
    self setplayerangles(var_0._id_12205.angle);

  var_6 = (0, 0, 0);

  if(istrue(var_3))
    var_6 = anglesToForward(var_0.angles) * 1522.0;

  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  thread scripts\cp_mp\parachute::startfreefall(1, 0, undefined, var_6);
}

setup_comms_obj_crate(var_0) {
  var_0.forcespawnangles = level.br_ac130.angles;
  var_0 thread scripts\cp\respawn\cp_respawn::_id_12768(0.0, 1, 1, "_encstr_998806DD1A96D12B");
  var_0 spawn(level.br_ac130.origin, level.br_ac130._id_12205.angle);
  var_0 playerhide();
  var_0 cameraset("_encstr_9341135A60B3B1DF1366393C9079E3C9D318E7D752");
  var_0.bspawningviaac130 = 1;
  var_1 = undefined;
  var_0 scripts\cp\respawn\cp_respawn::camera_setup_for_lerping(var_0, level.br_ac130);
}