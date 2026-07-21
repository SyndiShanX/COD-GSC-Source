/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\airstrike.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_88C5055208731B")]]();

  level._effect["_encstr_84AA119F50535363CD9BEC67E8B97B0919A85B"] = loadfx("_encstr_935D2DB39987CB2DDDC1AFAD0ECBADD2B136B9A39C590BD65E3BCCC37DB08903EB1D9C166CACE4F5B99583B8CE99C3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8FAC11C18072B2380AD74C27F737C966AEA0D0"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8FAC11C18072B2380AD74C27F737C966AEA0D0")]]();

  init_airstrike_flyby_anims();
  init_airstrike_vo();
  level.audio_heli_fade_up = [];
  level.brareloadoutdropbagsdelayed = 0;
  level._encstr_8340159E7CC39A6DC0420F2DE3E72ABFBB8CF38B60DC03 = getdvarint("_encstr_954F1EE3B9EEA74670579191E5900BEB9B501AA9E1CD0BFE10099C5FFF7857FF", 1);
  level._encstr_B2FE14D96B286213FEE0628A4B566FDA08FF42298D58 = getdvarint("_encstr_BA291DCDB19CF5C49CAF5896C96EA34EB46D2BFA5DB92BFADCC6DB4E5A733B", 1);
  level._encstr_97FC16C2B44E37E84E2DB52B8C1637D9ACC99CB019A5AEE6 = getdvarint("_encstr_B47B1F3A766D59BB928750087BE3E8EB03F089C865A790B76F4E81EAA109DBF54A", 1000);
  level._encstr_BA1B1A9177050A537DBAEF4AC4111A98F8425F8BC2BB1287F0EB727E = getdvarint("_encstr_99531FC27188473236B7875F155E9BA288D8FF4109780E3A85C5777F1388E3EDF8", 0);
  level._encstr_B22F1928B2BACFA3FB518AF534DFA8BF27ABA8384A9507D8DB458E = getdvarint("_encstr_953A1E2328860F254B5FA7B8726330BB900877AF512AF20709ADBF1F089532E7", 1);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_airstrike_flyby_anims() {
  var_0 = % _encstr_A940106B83FA0BD89958C40CF533C65EB4E6;
  var_1 = "_encstr_A940106B83FA0BD89958C40CF533C65EB4E6";

  if(scripts\cp_mp\utility\game_utility::_id_140AA()) {
    var_0 = % _encstr_AD9B13B50E7D166333854C0CEBCC632F4BE6D7319C;
    var_1 = "_encstr_AD9B13B50E7D166333854C0CEBCC632F4BE6D7319C";
  }

  level.scr_animtree["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"] = #animtree;
  level.scr_anim["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = var_0;
  level.scr_animname["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = var_1;
  level.scr_animtree["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"] = #animtree;
  level.scr_anim["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = % _encstr_A940106B83FA0BD89958C40CF533C65EB4E6;
  level.scr_animname["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = "_encstr_A940106B83FA0BD89958C40CF533C65EB4E6";
  level.scr_animtree["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"] = #animtree;
  level.scr_anim["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = % _encstr_A940106B83FA0BD89958C40CF533C65EB4E6;
  level.scr_animname["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = "_encstr_A940106B83FA0BD89958C40CF533C65EB4E6";
}

init_airstrike_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A22513C6B008EBD3B65B2FEFCFD4AA3F60DE3C4C8B"] = "_encstr_A51018F3626518B33BB7C7FD57228BD82B7B3BA84CCD41FB722B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3621243E9E2E04DBBFA08F1A1C38F10F170DB11"] = "_encstr_96CF19C193B2D84BCDA5F637F5C25A9337D127A5DA56FA5BB49BDC";
}

weapongivenairstrike(var_0) {
  var_1 = getdvarint("_encstr_8B8B13620ECB57018B086A98AA2C084338B1A07320", 2);
  var_2 = branalytics_secondwind(self.origin);

  if(var_2 != "_encstr_88E30897BDF1B71F7823") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_2);

    return 0;
  }

  if(var_0.streakname == "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B") {
    var_3 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656")]](0, 1, var_3);
  } else if(var_0.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656")]]();
  }

  return 1;
}

weaponswitchendedairstrike(var_0, var_1) {
  var_2 = getdvarint("_encstr_8B8B13620ECB57018B086A98AA2C084338B1A07320", 2);

  if(istrue(var_1)) {
    if(var_0.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895") {
      if(var_2 == 1)
        self laseron();
      else if(var_2 == 2)
        thread airstrike_watchforads(var_0);
    }
  }
}

weaponfiredairstrike(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_13A81)) {
    var_3 = airstrike_getownerlookatpos(self);
    var_4 = branalytics_secondwind(var_3);

    if(var_4 != "_encstr_88E30897BDF1B71F7823") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_4);

      return "_encstr_AFAC097640D8DC32A87307";
    }
  }

  if(isDefined(level.gametype)) {
    if(level.gametype == "_encstr_B607038AAB" && isDefined(self.scrambledby)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8C371D6198B78575014891D1E0AD83FE736590E43ABEE3F36560D199D877C9");

      return "_encstr_AFAC097640D8DC32A87307";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");

    return "_encstr_AFAC097640D8DC32A87307";
  }

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_5 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1, var_5);
  return "_encstr_88E30897BDF1B71F7823";
}

tryuseairstrike(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryuseairstrikefromstruct(var_1);
}

tryuseairstrikefromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = undefined;
  var_2 = level.airstrikesettings[var_0.streakname].deployweaponobj;

  switch (var_0.streakname) {
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

        if(var_3 == "_encstr_B607038AAB" && isDefined(self.waitandunloadinfils)) {
          var_0._id_13A81 = self.waitandunloadinfils;
          self.waitandunloadinfils = undefined;
        }
      }

      if(isDefined(var_0._id_13A81)) {
        var_4 = weaponfiredairstrike(var_0, undefined, undefined);
        var_1 = var_4 == "_encstr_88E30897BDF1B71F7823";
      } else
        var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_2, "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", ::weapongivenairstrike, ::weaponswitchendedairstrike, ::weaponfiredairstrike);

      break;
    case "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B":
    case "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA":
      var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_2, 1, ::weapongivenairstrike, ::weaponswitchendedairstrike);
      break;
  }

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  var_5 = selectairstrikelocation(var_0);

  if(!istrue(var_5))
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8B330D3ADBD0F47B4B9536570725A8"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8B330D3ADBD0F47B4B9536570725A8")]]();

  return 1;
}

selectairstrikelocation(var_0) {
  var_1 = (0, 0, 0);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_6 = "_encstr_B47106834B35B9CF" + var_0.streakname;

  if(var_0.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895") {
    if(isDefined(var_0._id_13A81))
      var_1 = var_0._id_13A81;
    else
      var_1 = airstrike_getownerlookatpos(self, 1);
  } else if(var_0.streakname == "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B") {
    var_7 = 3;
    var_4 = 1;
    scripts\common\utility::allow_weapon_switch(0);
    self setsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB"))
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB")]](var_0, var_7, 1);

    scripts\common\utility::allow_weapon_switch(1);
  } else if(var_0.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA") {
    var_7 = 3;
    scripts\common\utility::allow_weapon_switch(0);
    self setsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB"))
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB")]](var_0, var_7);

    scripts\common\utility::allow_weapon_switch(1);
  }

  if(isDefined(var_2)) {
    var_8 = branalytics_secondwind(var_2);

    if(var_8 != "_encstr_88E30897BDF1B71F7823") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_8);

      return 0;
    }

    thread finishmapselectairstrikeusage(var_2, var_4, var_1, var_3, var_0);
    self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  } else if(!isDefined(var_2) && (var_0.streakname == "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B" || var_0.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA")) {
    if(isDefined(var_5)) {
      var_5 stoploopsound("_encstr_B40101");
      var_5 delete();
    }

    self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
    return 0;
  } else if(var_0.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895")
    thread finishstandardairstrikeusage(var_1, var_3, var_0);

  if(isDefined(var_5)) {
    var_5 stoploopsound("_encstr_B40101");
    var_5 delete();
  }

  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  self notify("_encstr_A5CA10CFBB58072D5397895553DF2C4132D9");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_6, self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, var_1);

  if(level.gametype == "_encstr_B607038AAB" && level._encstr_BA1B1A9177050A537DBAEF4AC4111A98F8425F8BC2BB1287F0EB727E) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_1, level._encstr_97FC16C2B44E37E84E2DB52B8C1637D9ACC99CB019A5AEE6, var_0.streakname);
  }

  return 1;
}

finishmapselectairstrikeusage(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = level.scr_anim[var_4.streakname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"];
  var_6 = getanimlength(var_5);
  var_7 = scripts\engine\utility::get_notetrack_time(var_5, "_encstr_999A07C61338F9A23A");
  var_8 = branalytics_respawn(self.origin, self);
  thread airstrike_watchkills(var_7 * 2, var_8);
  thread watchairstrikeowner(var_8);
  thread branalytics_teameliminated(var_4, var_8);

  foreach(var_12, var_10 in var_0) {
    var_2 = var_10.location;
    var_11 = self.angles[1];

    if(istrue(var_1))
      var_11 = var_10.angles;

    finishairstrikeusage(var_2, var_11, var_3, var_4, var_5, var_8);

    if(var_0.size > 1 && var_12 < var_0.size - 1)
      wait(randomfloatrange(0.8, 1.0));
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_4);

  branalytics_seteventdelayedstate(self, var_8);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_8887145B961BD86E8EC9AC16B601ACDC8C5923109604" + var_4.streakname, self);

  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_4);
}

finishstandardairstrikeusage(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = level.scr_anim[var_2.streakname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"];
  var_4 = getanimlength(var_3);
  var_5 = scripts\engine\utility::get_notetrack_time(var_3, "_encstr_999A07C61338F9A23A");
  var_6 = branalytics_respawn(var_0, self);
  thread airstrike_watchkills(var_5 * 2, var_6);
  thread watchairstrikeowner(var_6);
  thread branalytics_teameliminated(var_2, var_6);
  finishairstrikeusage(var_0, undefined, var_1, var_2, var_3, var_6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_2);

  branalytics_seteventdelayedstate(self, var_6);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_8887145B961BD86E8EC9AC16B601ACDC8C5923109604" + var_2.streakname, self);

  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_2);
}

finishairstrikeusage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("_encstr_95E405AEDCCA91");
  self notify("_encstr_99B00F0BB8DBCBC3C07C1293A19B3358AD");
  doairstrike(var_0, var_1, self, self.pers["_encstr_8AEF05472BC2D6"], var_2, var_3, var_4, var_5);
}

doairstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level thread callstrike(var_2, var_0, var_1, var_4, var_5, var_6, var_7);
}

watchairstrikeowner(var_0) {
  self endon("_encstr_8E4614852DE4DC3A4E96AD56F5335ADC4BDCD0598CF5" + var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298");
  branalytics_seteventdelayedstate(self, var_0);
}

callstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_9 = 24000;
  var_10 = 6500;
  var_11 = 2500;
  var_7 = 1500;

  if(isDefined(var_8))
    var_11 = var_8.origin[2];

  var_12 = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(var_12) && var_12 == "_encstr_8A34097127C761890FA9D2")
    var_11 = var_11 + 500;

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE" || scripts\cp_mp\utility\game_utility::unlink_on_ai_death())
    var_11 = var_11 + 2500;

  var_7 = getexplodedistance(var_11);
  var_14 = undefined;
  var_15 = undefined;

  if(isDefined(var_2))
    var_14 = (0, var_2, 0);
  else {
    var_14 = callstrike_findoptimaldirection(var_0, var_1, var_11);
    var_15 = 1;
  }

  var_16 = getflightpath(var_1, var_14, var_9, var_8, var_11, var_10, var_7, var_4.streakname, var_15);

  if(var_4.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895") {
    for(var_17 = 0; var_17 < 2; var_17++) {
      var_11 = var_11 + randomintrange(200, 300);
      level thread doplanestrike(var_1, var_16["_encstr_B18C0B5E9C6FA319E20A487853"], var_16["_encstr_ACB7092280809AF7F8F8DB"], var_11, var_3, var_4, var_5, var_0, var_6);
      wait 3;
    }
  } else
    level thread doplanestrike(var_1, var_16["_encstr_B18C0B5E9C6FA319E20A487853"], var_16["_encstr_ACB7092280809AF7F8F8DB"], var_11, var_3, var_4, var_5, var_0, var_6);
}

callstrike_findoptimaldirection(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0 getplayerangles());
  var_4 = scripts\engine\trace::create_default_contents(1);
  var_5 = scripts\engine\trace::ray_trace(var_1 - var_3 * 30, var_1 + var_3 * 1000, undefined, var_4);
  var_1 = var_5["_encstr_BD260953AA97E3F014279D"] + var_5["_encstr_820E07FAE8780B3A4C"] * 20;
  var_6 = var_1;
  var_7 = var_2 * 3;
  var_8 = anglesToForward(var_0.angles);
  var_9 = anglestoright(var_0.angles);
  var_10 = 0;
  var_11 = [var_6 + var_8 * 100, var_6 - var_8 * 100, var_6 + var_9 * 100, var_6 - var_9 * 100, var_6 + (var_8 + var_9) * 100, var_6 + (var_8 - var_9) * 100, var_6 + (var_9 - var_8) * 100, var_6 + (-1 * var_8 - var_9) * 100];

  if(level.gametype == "_encstr_B607038AAB" && level._encstr_8340159E7CC39A6DC0420F2DE3E72ABFBB8CF38B60DC03)
    var_12 = vectorNormalize(var_11[2] - var_6);
  else
    var_12 = vectorNormalize(var_11[0] - var_6);

  var_13 = 0;
  var_14 = 0;

  foreach(var_16 in var_11) {
    var_17 = vectorNormalize(var_16 - var_6);
    var_18 = var_6 + (0, 0, var_7) - var_17 * 25000;
    var_19 = [var_6, var_6 - var_17 * 512, var_6 - var_17 * 256, var_6 + var_17 * 256, var_6 + var_17 * 512];
    var_20 = 0;

    foreach(var_22 in var_19) {
      var_23 = scripts\engine\trace::ray_trace(var_18, var_22, undefined, var_4);
      var_24 = var_23["_encstr_A53009A25003666B9818C6"] == 1;

      if(level.gametype == "_encstr_B607038AAB" && level._encstr_B2FE14D96B286213FEE0628A4B566FDA08FF42298D58) {
        if(var_23["_encstr_A53009A25003666B9818C6"] > var_14) {
          var_12 = var_17;
          var_14 = var_23["_encstr_A53009A25003666B9818C6"];
        }
      }

      if(!istrue(var_24)) {
        wait 0.05;
        break;
      }

      var_20++;
      wait 0.05;
    }

    if(var_20 > var_13) {
      var_12 = var_17;
      var_13 = var_20;

      if(var_20 >= 3) {
        break;
      }
    }
  }

  return var_12;
}

_id_144B7(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_91F714B0A5C9FAB94793A55BACFAD8B7D60E36568EB2");
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0.player_waittilljumpedfromc130))
    var_0.player_waittilljumpedfromc130 delete();

  _id_123AE(var_0);
}

doplanestrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_7)) {
    return;
  }
  var_7 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_9 = level.airstrikesettings[var_5.streakname];
  var_10 = getanimlength(var_6);
  var_11 = scripts\engine\utility::get_notetrack_time(var_6, "_encstr_999A07C61338F9A23A");
  var_12 = var_0 + (0, 0, var_3);
  var_13 = vectorNormalize(var_2 - var_1);
  var_14 = var_9.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_7) && isDefined(var_9.modelbasealt))
    var_14 = var_9.modelbasealt;

  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_12);
  var_15 setModel(var_14);
  var_15.angles = vectortoangles(var_13);
  var_15.flightdir = var_13;
  var_15.flightheight = var_3;
  var_15.owner = var_7;
  var_16 = istrue(level.vehicle_collision_getleveldata) && (isDefined(level._id_14603) && level._id_14603 == 6);
  var_17 = var_16 || istrue(var_5.brmini_ontimelimit);

  if(var_17)
    var_15.team = "_encstr_A31611ABF569C23137B7CE1920FB3140AB228B";
  else
    var_15.team = var_7.team;

  var_15.lifeid = var_5.lifeid;
  var_15.streakinfo = var_5;
  var_15.brbonusxpallowed = var_8;

  if(!istrue(var_5._id_133DE))
    var_15 setotherent(var_7);

  var_15 scriptmoveroutline();
  var_15 scriptmoverthermal();
  var_15 scriptmoverplane();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_15[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_5.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_7, 0, 1, 100);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39")) {
    var_18 = spawnStruct();
    var_18._id_123A1 = var_15;
    var_18._id_13A8A = var_0;
    var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39")]]("_encstr_82F920FAAE7E27D66F202A53A0DF4AF710185452C9C1631C0F90124BC8D182A78875", var_18);
  }

  var_19 = "_encstr_B85617335E725D9615D71828EF314B873A443646F3FB1BD8C5";

  if(var_5.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA")
    var_19 = "_encstr_8A551B2832BFC801AD993533B596401833CB21F07AFF7EA8037A230FA5";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_15.minimapid = var_15[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]](var_19, var_15.team, undefined, 1, 1);

  var_20 = var_11 - 0.75;
  var_21 = var_11;
  var_22 = 8.596;
  var_23 = var_20 + var_22;

  if(var_5.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA")
    var_20 = var_11 + 1;

  if(!istrue(var_5.setuptimelimit))
    level thread airstrike_playplaneattackfx(var_15, var_20, var_5);

  if(istrue(var_5._id_12186) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8CCE12ED3BCA399C5A8C5905630BCB8C1B5E1916"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8CCE12ED3BCA399C5A8C5905630BCB8C1B5E1916")]](var_15, var_1, var_13, var_21, var_22, var_10, var_5);
  else
    level thread airstrike_playflyfx(var_15, var_1, var_13, var_21, var_22, var_10, var_5);

  var_15.bulletpoint = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_15.origin);
  var_15.bulletpoint setModel("_encstr_819117D0629FC873EB1F31054F424DF16C7E7BA90F1C8139A3");

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_15.bulletpoint setModel("_encstr_88451B47E35980334B4BFB23F2F7FDB92B49FDC79DFB298E636111687F");

  var_15.bulletpoint setentityowner(var_7);
  var_15.bulletpoint.weapon_name = "_encstr_A2950D16C9E8D2361B59932FF55BC1";
  var_15.bulletpoint.streakinfo = var_5;
  var_15.bulletpoint.angles = var_15.angles;
  var_15.bulletpoint dontinterpolate();
  var_15.animname = var_5.streakname;
  var_15 scripts\common\anim::setanimtree();
  var_15.scenenode = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_12);
  var_15.scenenode.angles = var_15.angles;
  var_15.scenenode setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(istrue(var_5.setuptimelimit)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_A13C1843C2E4B6B1569BB905A5C9DC47274B5B562ACCCCB21B1D"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_A13C1843C2E4B6B1569BB905A5C9DC47274B5B562ACCCCB21B1D")]](var_15, var_20, var_10, var_0, var_7);
  } else if(var_5.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_5.streakname == "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B")
    level thread callstrike_precisionbulleteffect(var_15, var_20, var_10, var_0, var_7, var_5);
  else if(var_5.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA") {}

  var_25 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";
  var_26 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_931D068662634370";
  thread _id_144B7(var_15, var_7);

  if(var_25 || var_26) {
    var_15.scenenode childthread scripts\common\anim::anim_single_solo(var_15, "_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B23B126388DEBB3E389DF3FC75D07C271FCD4A3A"))
      var_15 childthread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B23B126388DEBB3E389DF3FC75D07C271FCD4A3A")]]();

    wait(var_23);
  } else
    var_15.scenenode scripts\common\anim::anim_single_solo(var_15, "_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5");

  var_15 notify("_encstr_91F714B0A5C9FAB94793A55BACFAD8B7D60E36568EB2");
  _id_123AE(var_15);
}

_id_123AE(var_0) {
  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0.minimapid);
  }

  var_0 notify("_encstr_A25F0710622DF3B3D7");

  if(isDefined(var_0.turrettarget))
    var_0.turrettarget delete();

  if(isDefined(var_0.bulletpoint)) {
    var_0.bulletpoint delete();

    if(isDefined(var_0.bulletpoint.killcament))
      var_0.bulletpoint.killcament delete();
  }

  if(isDefined(var_0.scenenode))
    var_0.scenenode delete();

  if(isDefined(var_0))
    var_0 delete();
}

airstrike_playplaneattackfx(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_2.streakname == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA") {
    return;
  }
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  playsoundatpos(var_0.origin, "_encstr_868417AD9BD7B089067DCC4B3959AF464BDC1DBED8E4B0D8B5");
  var_0 setscriptablepartstate("_encstr_88780599B4E495", "_encstr_AB0703DBB9", 0);
  var_0 waittill("_encstr_A31E0E6C41F2A2692E68D5531B4072F9");
  var_0 setscriptablepartstate("_encstr_88780599B4E495", "_encstr_BA19049F4B2D", 0);
}

airstrike_playflyfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 thread airstrike_delayplayscriptable(0.05);
  var_0.player_waittilljumpedfromc130 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_0.player_waittilljumpedfromc130 setModel("_encstr_9BF610B59BD758A5279BD1392DB6B27DAD07");

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_0.player_waittilljumpedfromc130 setModel("_encstr_813C148F2B8158FB8373B37BBA8FA5F166825F17A862");

  var_0.player_waittilljumpedfromc130 dontinterpolate();
  var_0.player_waittilljumpedfromc130 thread airstrike_playapproachfx(0.05);
  var_0.player_waittilljumpedfromc130 thread airstrike_playflybyfx(3.397);
  var_0.player_waittilljumpedfromc130 thread airstrike_playflyoutfx(var_4);
  var_0.player_waittilljumpedfromc130 thread airstrike_handleflyoutfxdeath(var_5);
  var_0.player_waittilljumpedfromc130 thread branalytics_selfrevive(var_0);
}

airstrike_playapproachfx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("_encstr_8FDE09E270117257C96EB0", "_encstr_AB0703DBB9", 0);
}

airstrike_playflybyfx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("_encstr_B4A9061F0848E2EB", "_encstr_AB0703DBB9", 0);
}

airstrike_playflyoutfx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("_encstr_B85507B49D135FD30C", "_encstr_AB0703DBB9", 0);
}

airstrike_handleflyoutfxdeath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 + 10);
  self delete();
}

branalytics_selfrevive(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AF9C1847FD2F11210B0B75432BB0914948675515A01F67EFC8DB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(var_0)) {
    self.origin = var_0.origin;
    wait 0.05;
  }
}

airstrike_watchkills(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A56A16C7FB7EBB046E3BB0E8A10B68151738D974D8628AFF");
  self endon("_encstr_A56A16C7FB7EBB046E3BB0E8A10B68151738D974D8628AFF");
  self.brattractions = 0;
  var_2 = "_encstr_8E4614852DE4DC3A4E96AD56F5335ADC4BDCD0598CF5" + var_1;
  childthread airstrike_watchkillscount(var_2);
  scripts\engine\utility::_id_143BF(var_0, var_2);
  var_3 = isDefined(self.airstrikekillcount) && self.airstrikekillcount >= 1;
  var_4 = isDefined(self.brattractions) && self.brattractions >= 1;

  if(var_3 || var_4)
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A22513C6B008EBD3B65B2FEFCFD4AA3F60DE3C4C8B", 1);
  else
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A3621243E9E2E04DBBFA08F1A1C38F10F170DB11", 1);

  self.brattractions = undefined;
}

airstrike_watchkillscount(var_0) {
  self endon(var_0);
  self.airstrikekillcount = 0;

  for(;;) {
    self waittill("_encstr_92FB1BA870FADEE4054823C2E74B9D214FEB3260C71EC5E1A19595F873", var_1, var_2);

    if(isDefined(var_2) && var_2 == "_encstr_A2950D16C9E8D2361B59932FF55BC1")
      self.airstrikekillcount++;
  }
}

testsoundplacement(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;)
    wait 0.05;
}

callstrike_precisionbulleteffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_6 = var_0.flightdir;
  var_7 = var_3 + (0, 0, var_0.flightheight + 750);
  var_8 = var_7 - var_6 * 15000;
  var_9 = var_7 - var_6 * 500;
  var_10 = var_7;
  var_11 = istrue(level.vehicle_collision_getleveldata) && (isDefined(level._id_14603) && level._id_14603 == 6);

  if(!var_11) {
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
    var_12 thread airstrike_killcammove(var_1 - 3, var_9, var_10);
    var_0.bulletpoint.killcament = var_12;
  }

  var_13 = [var_3 - var_6 * 512, var_3 - var_6 * 256, var_3, var_3 + var_6 * 256, var_3 + var_6 * 512];

  if(level.gametype == "_encstr_B607038AAB" && level._encstr_B22F1928B2BACFA3FB518AF534DFA8BF27ABA8384A9507D8DB458E) {
    foreach(var_15 in var_13) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
        var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_15, level._encstr_97FC16C2B44E37E84E2DB52B8C1637D9ACC99CB019A5AEE6, var_5.streakname);
    }
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_17 = 5;
  var_18 = (0, 0, 0);
  var_19 = var_18;
  var_0.bulletpoint setscriptablepartstate("_encstr_8FE70EA22BB13BD73027C9C551B01E03", "_encstr_AB0703DBB9", 0);
  var_20 = 0;
  var_21 = 0;

  foreach(var_15 in var_13) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_15, 512, 512, var_4.team, 5, var_4, 1);
  }

  var_28 = var_3[2] + var_0.flightheight * 3;

  for(var_29 = 0; var_29 < var_17; var_29++) {
    if(!isDefined(var_4)) {
      break;
    }

    var_30 = -50;
    var_31 = 150;

    while(var_20 < var_21 + 4) {
      var_32 = callstrike_getrandomshotoffset(var_30, var_31, var_13[var_29], var_0.angles);
      var_33 = var_0 gettagorigin("_encstr_BDA00EE357FA18B193C2D0B1B3318890") * (1, 1, 0) + (0, 0, var_28) + var_6 * 1000;
      var_35 = vectorNormalize(var_32 - var_33);
      var_36 = var_32 + var_35 * 30000;
      var_37 = scripts\engine\trace::ray_trace(var_33, var_36, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
      var_38 = var_37["_encstr_BD260953AA97E3F014279D"];
      var_39 = var_37["_encstr_820E07FAE8780B3A4C"];
      var_40 = var_38 + var_39 * 10;
      var_41 = vectorNormalize(var_38 - var_0 gettagorigin("_encstr_BDA00EE357FA18B193C2D0B1B3318890"));
      var_42 = vectorcross(var_41, (0, 0, 1));
      var_43 = vectorcross(var_42, var_41);
      var_0 thread callstrike_playmultitracerfx(scripts\engine\utility::getfx("_encstr_84AA119F50535363CD9BEC67E8B97B0919A85B"), var_40, var_41, var_43);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_B1781B083BC11A4ACB44A858C1061BDA1BAD6E1A47CDE1D951C188CCF7"))
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_B1781B083BC11A4ACB44A858C1061BDA1BAD6E1A47CDE1D951C188CCF7")]](var_37, var_0, var_4);

      var_0.bulletpoint thread moveanddamagepoint(var_20 + 1, var_40);
      var_19 = var_38;
      var_20++;
      var_0.bulletpoint.streakinfo.shots_fired++;
      var_30 = var_30 + 20;
      var_31 = var_31 + 40;
      var_28 = var_28 - 200;

      if(var_28 < var_0.flightheight)
        var_28 = var_0.flightheight;

      wait 0.05;
    }

    var_21 = var_20;
  }

  var_0 notify("_encstr_A31E0E6C41F2A2692E68D5531B4072F9");
  var_0.bulletpoint setscriptablepartstate("_encstr_8FE70EA22BB13BD73027C9C551B01E03", "_encstr_BA19049F4B2D", 0);
}

callstrike_getrandomshotoffset(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * (0, 1, 0);
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = randomintrange(var_0, var_1);
  var_7 = randomint(80) - 40;
  var_8 = var_4 * cos(var_7) * var_6;
  return var_2 + var_8 + var_5 * sin(var_7) * var_6;
}

callstrike_playmultitracerfx(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_4 = 0;
  var_5 = 3;

  while(var_4 < var_5) {
    var_6 = randomintrange(25, 50);
    var_7 = randomintrange(25, 50);
    playFX(var_0, var_1 + (var_6, var_7, 0), var_2, var_3);
    var_4++;
    wait 0.05;
  }
}

moveanddamagepoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = var_1;
  self setscriptablepartstate("_encstr_860808CB78E2984063BA" + var_0, "_encstr_930B07BB1B6B3854FF", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA" + var_0, "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

callstrike_fuelbombeffect(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = var_0.flightdir;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_3, 650, 650, var_4.team, var_2, var_4, 1);

  var_7 = var_3 + (0, 0, 2500);
  var_8 = var_3 - (0, 0, 10000);
  var_9 = scripts\engine\trace::ray_trace(var_7, var_8, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  var_10 = var_9["_encstr_BD260953AA97E3F014279D"];
  var_11 = var_9["_encstr_820E07FAE8780B3A4C"];
  var_12 = var_10 + var_11 * 10;
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_12 + (0, 0, 400));
  var_13 setModel("_encstr_99F1116D6E7D3357958D9BD1E4A5B62BAF6BC1");
  var_13 setscriptablepartstate("_encstr_A39B08FDCF453790FB9F", "_encstr_AB0703DBB9", 0);
  var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_12);
  var_14 setModel("_encstr_99F1116D6E7D3357958D9BD1E4A5B62BAF6BC1");
  var_14 setscriptablepartstate("_encstr_91C407B8826D2B7397", "_encstr_AB0703DBB9", 0);
  var_14 setentityowner(var_4);
  level thread delaydeletefxents(var_13, var_14);
}

delaydeletefxents(var_0, var_1) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();
}

getflightpath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  if(istrue(var_8))
    var_9 = var_1;
  else
    var_9 = anglesToForward(var_1);

  var_10 = var_0 + var_9 * (-1 * var_2);

  if(isDefined(var_3))
    var_10 = var_10 * (1, 1, 0);

  var_10 = var_10 + (0, 0, var_4);
  var_11 = var_0 + var_9 * var_2;

  if(isDefined(var_3))
    var_11 = var_11 * (1, 1, 0);

  var_11 = var_11 + (0, 0, var_4);
  var_12 = length(var_10 - var_11);
  var_13 = var_12 / var_5;
  var_12 = abs(var_12 / 2 + var_6);
  var_14 = var_12 / var_5;
  var_15["_encstr_B18C0B5E9C6FA319E20A487853"] = var_10;
  var_15["_encstr_ACB7092280809AF7F8F8DB"] = var_11;
  var_15["_encstr_A16509852F65281D97FA89"] = var_14;
  var_15["_encstr_B602088CA52B1198DD3F"] = var_13;
  var_15["_encstr_8EC91091A593B28DD1A5EDE628E6EC63CAB9"] = var_9;
  return var_15;
}

getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

airstrike_getownerlookatpos(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8F3D0D4E3F80D93A908562A277D7A9"))
    return var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8F3D0D4E3F80D93A908562A277D7A9")]]();

  var_2 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07"];
  var_3 = physics_createcontents(var_2);
  var_4 = var_0 getvieworigin();
  var_5 = var_4 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_6 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_125F8();
  var_7 = scripts\engine\trace::ray_trace(var_4, var_5, var_6, var_3);
  var_8 = var_7["_encstr_BD260953AA97E3F014279D"];

  if(var_7["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_8 = undefined;

  return var_8;
}

airstrike_watchforads(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A1591119CA1C1BDBCBFAD82CCD1BCA1B63568C");
  self endon("_encstr_84390DCF7950BC3A7B7F23174D2DD2");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_2 setModel("_encstr_9B1217E486FF522103C88BAB2018E57943172A1C650D097D2B");

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_2 setModel("_encstr_92AE1B6C2E998608CE03231DA85F087180783A7BC12A59651D69F72013");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057"))
    var_2.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057")]](99);

  var_2 setotherent(self);
  var_2 dontinterpolate();
  var_2 hide();
  var_3 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);

  if(var_3)
    var_4 = "_encstr_84B91CD21BDEDCAFDD58E5E0DEB4CDA3AF85A527E63AC94B6D95D7BBEE19";
  else
    var_4 = "_encstr_95DD1828DE6778A0639FD3C98FAA70F03F3650C342C450635A97";

  if(isDefined(var_1))
    var_4 = var_1;

  var_2 airstrike_setmarkerobjective(var_2.objidnum, var_4, self, 50);
  var_2 thread branalytics_validation(self);
  var_2 thread airstrike_watchdeployended(self);
  var_2 thread branalytics_spawntablet(self);
  var_2.updatemarker = 0;
  scripts\common\utility::allow_fire(0);

  for(;;) {
    var_5 = self playerads();
    var_6 = var_5 == 1;
    var_7 = var_5 < 1;
    var_8 = scripts\cp_mp\emp_debuff::is_empd();
    var_9 = istrue(var_2.updatemarker);

    if(!var_9 && !var_8 && var_6) {
      scripts\common\utility::allow_fire(1);
      var_2 show();
      var_2 setscriptablepartstate("_encstr_A5030D6B16E45B95C9FA6E367BC159", "_encstr_AB0703DBB9", 0);
      var_2 thread airstrike_updatemarkerpos(self);
      var_2.updatemarker = 1;
    } else if(var_9 && (var_7 || var_8)) {
      scripts\common\utility::allow_fire(0);
      var_2 hide();
      var_2 setscriptablepartstate("_encstr_A5030D6B16E45B95C9FA6E367BC159", "_encstr_BA19049F4B2D", 0);
      self notify("_encstr_AB70137F053849AF081345BF0908C1300E53AF85D8");
      var_2.updatemarker = 0;
    }

    waitframe();
  }
}

airstrike_setmarkerobjective(var_0, var_1, var_2, var_3) {
  objective_icon(var_0, var_1);
  objective_showtoplayersinmask(var_0);
  objective_addclienttomask(var_0, var_2);
  objective_onentity(var_0, self);
  objective_setzoffset(var_0, var_3);
  objective_setplayintro(var_0, 0);
  objective_setplayoutro(var_0, 0);
  objective_setbackground(var_0, 1);

  if(level.teambased)
    objective_setownerteam(var_0, var_2.team);
  else
    objective_setownerclient(var_0, var_2);

  objective_state(var_0, "_encstr_8267056410C669");
}

airstrike_updatemarkerpos(var_0) {
  var_0 notify("_encstr_AB70137F053849AF081345BF0908C1300E53AF85D8");
  var_0 endon("_encstr_AB70137F053849AF081345BF0908C1300E53AF85D8");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A1591119CA1C1BDBCBFAD82CCD1BCA1B63568C");
  var_0 endon("_encstr_84390DCF7950BC3A7B7F23174D2DD2");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = 0;
  var_0 setclientomnvar("_encstr_813918A34B71933F7794B9601DC7208028FBB789E7D9D87707C2", 0);

  for(;;) {
    var_2 = airstrike_getownerlookatpos(var_0);
    var_3 = -1;
    var_4 = -1;
    var_5 = -1;
    var_6 = isDefined(var_2);

    if(var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8C0C1084B359B742F821E7033510CBFEA01B"))
        var_6 = var_6 &level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8C0C1084B359B742F821E7033510CBFEA01B")]](var_2);
    }

    if(var_6) {
      self.origin = var_2;
      var_3 = int(self.origin[0]);
      var_4 = int(self.origin[1]);
      var_5 = int(self.origin[2]);
    }

    var_0 setclientomnvar("_encstr_92FF150BD0372967C2D3F3413708EA43BCD799334FF82B", var_3);
    var_0 setclientomnvar("_encstr_BEFF1523A111C80E7E87AB4EAA2F30E87753EFA15FC2C0", var_4);
    var_0 setclientomnvar("_encstr_BDFF158564C9FB5901E6A2E19F671015A21A688F7DA375", var_5);

    if(isDefined(var_2)) {
      if(!istrue(var_1) && distance2dsquared(var_0.origin, var_2) <= 1638400) {
        var_0 setclientomnvar("_encstr_813918A34B71933F7794B9601DC7208028FBB789E7D9D87707C2", 1);
        var_1 = 1;
      } else if(istrue(var_1) && distance2dsquared(var_0.origin, var_2) > 1638400) {
        var_0 setclientomnvar("_encstr_813918A34B71933F7794B9601DC7208028FBB789E7D9D87707C2", 0);
        var_1 = 0;
      }
    }

    waitframe();
  }
}

branalytics_validation(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  airstrike_removemarker();
}

airstrike_watchdeployended(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 scripts\engine\utility::_id_143AD("_encstr_925B0C0238EDF6BFA8B07E793E51", "_encstr_A5CA10CFBB58072D5397895553DF2C4132D9");

  if(isDefined(var_1) && var_1 == "_encstr_A5CA10CFBB58072D5397895553DF2C4132D9") {
    var_0 notify("_encstr_84390DCF7950BC3A7B7F23174D2DD2");
    self setscriptablepartstate("_encstr_A5030D6B16E45B95C9FA6E367BC159", "_encstr_BA19049F4B2D", 0);
    var_2 = anglesToForward(var_0 getplayerangles());
    var_3 = self.origin - var_2 * 500;
    var_4 = self.origin + var_2 * 20;
    var_5 = scripts\engine\trace::ray_trace(var_3, var_4, self);
    var_6 = var_5["_encstr_820E07FAE8780B3A4C"];
    self.angles = generateaxisanglesfromupvector(var_6, self.angles);
    self setscriptablepartstate("_encstr_84910EB2688584CF1BE0382C8741B70F", "_encstr_AB0703DBB9", 0);
    objective_state(self.objidnum, "_encstr_AF5A081BBAC993AC73A3");
    thread airstrike_removemarker(7);
  } else {
    var_0 notify("_encstr_A1591119CA1C1BDBCBFAD82CCD1BCA1B63568C");

    if(!var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8C140CAFEF2FC261305972B65549")]]())
      var_0 scripts\common\utility::allow_fire(1);

    airstrike_removemarker();
  }
}

branalytics_spawntablet(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 getcurrentweapon();

  for(;;) {
    if(var_0 getcurrentweapon() != var_1) {
      break;
    }

    waitframe();
  }

  var_0 notify("_encstr_925B0C0238EDF6BFA8B07E793E51");
}

airstrike_removemarker(var_0) {
  if(isDefined(var_0)) {
    self endon("_encstr_AD75063D571AE108");
    level endon("_encstr_9B1D0BC7932875276230426AA1");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(isDefined(self.objidnum)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.objidnum);
  }

  self delete();
}

airstrike_delayplayscriptable(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  self setscriptablepartstate("_encstr_B6C907C4EDC8BC99F0", "_encstr_AB0703DBB9", 0);
}

airstrike_killcammove(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self moveTo(var_1, 4);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.95);
  self moveTo(var_2, 5);
}

branalytics_teameliminated(var_0, var_1) {
  self endon("_encstr_8E4614852DE4DC3A4E96AD56F5335ADC4BDCD0598CF5" + var_1);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

branalytics_respawn(var_0, var_1) {
  level.brareloadoutdropbagsdelayed++;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.owner = var_1;
  var_2.id = var_1.name + "_encstr_BA4C02DF" + level.brareloadoutdropbagsdelayed;
  level.audio_heli_fade_up[var_2.id] = var_2;
  return var_2.id;
}

branalytics_seteventdelayedstate(var_0, var_1) {
  level.audio_heli_fade_up = scripts\engine\utility::array_remove_index(level.audio_heli_fade_up, var_1, 1);

  if(isDefined(var_0))
    var_0 notify("_encstr_8E4614852DE4DC3A4E96AD56F5335ADC4BDCD0598CF5" + var_1);
}

branalytics_secondwind(var_0) {
  var_1 = "_encstr_88E30897BDF1B71F7823";
  var_2 = 625000000;

  if(isDefined(var_0)) {
    if(level.audio_heli_fade_up.size > 0) {
      var_3 = 1;
      var_4 = level.gametype == "_encstr_B607038AAB";

      if(var_4)
        var_3 = 3;

      if(level.audio_heli_fade_up.size >= var_3)
        var_1 = "_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544";
      else {
        foreach(var_6 in level.audio_heli_fade_up) {
          if(distance2dsquared(var_6.origin, var_0) <= var_2)
            var_1 = "_encstr_BD6727BA6913AC8F3B111149F8823F455FDA380EE8CFB57BD159493191AE3D5C8FB4AD0D0F77DF338E";
        }
      }
    }
  } else
    var_1 = "_encstr_88A31A942F6BE4DA0996F50737672E37C17BFE24BC3FE91B680FA831";

  return var_1;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

game_end_watcher(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = spawnStruct();
  var_5.streakname = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  var_5.owner = var_4;
  var_5.score = 0;
  var_5.shots_fired = 0;
  var_5.hits = 0;
  var_5.damage = 0;
  var_5.kills = 0;
  var_5.setuptimelimit = istrue(var_1);
  var_5.brmini_ontimelimit = istrue(var_2);
  var_6 = var_3;
  var_7 = undefined;
  var_8 = % _encstr_A940106B83FA0BD89958C40CF533C65EB4E6;

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_8 = % _encstr_AD9B13B50E7D166333854C0CEBCC632F4BE6D7319C;

  var_9 = undefined;
  level thread callstrike(var_4, var_0, var_6, var_7, var_5, var_8, var_9);
}