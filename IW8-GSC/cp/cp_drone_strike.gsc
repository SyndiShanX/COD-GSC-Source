/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_drone_strike.gsc
***********************************************/

init_drone_strike() {
  createdronestrikeheightpoint();
  level.drone_strike_activate_function = ::dronestrikeactivatefunc;
  setdvarifuninitialized("_encstr_A5900FC3C112591FE893B293B7203E8B2A", 0);
  setdvarifuninitialized("_encstr_BE9716C7AF038830426B102B170728583B4347173F2A6B98", 0);
  setdvarifuninitialized("_encstr_8CBC175E3EC35FB1AA0780582FEF2953CB26DE6B997AFB7B74", 1000);
  setdvarifuninitialized("_encstr_AF3019C31EE3D77E453002BBA8C777F7DBF75B40B808678407F0DB", 0);
  setdvarifuninitialized("_encstr_BA67170328D5F9A76BA57163B51657BD39C08AEB61412CAFC3", 50);
  setdvarifuninitialized("_encstr_A2161DC399CE872690E3796BEBD16CF777715A3B66AE0F1D40195744EBC873", 150);
  setdvarifuninitialized("_encstr_A7EA17BFB756990BF0F30C92E9C159F22FCB773B67FD23D0A0", 1);
}

dronestrikeactivatefunc(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", var_0);
  thread tryusedronestrike(var_1);
}

createdronestrikeheightpoint() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-16, 0, 2576));
  var_0.angles = (0, 0, 0);
  var_0.targetname = "_encstr_95D61467465F62ED66084B6BE0D8A5390955ACDF23C1";
  level.vdronestrikeheight = var_0;
}

weapongivendronestrike(var_0) {}

tryusedronestrike(var_0) {
  var_1 = playremotesequence(var_0);
  thread runcruisepredator(var_0.streakname, var_0, undefined);

  foreach(var_3 in level.players) {
    if(var_3 != self)
      var_3 thread scripts\cp\cp_hud_message::showsplash("_encstr_88421557E059203E173A9EE143E77868E15BF1ED913CF8", undefined, self);
  }
}

runcruisepredator(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = "_encstr_918F15D5DCCA32AFD8C9ABD2B92BAF072795C82CA3BD93";
  self notifyonplayercommand("_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_BE64111F8B564EF7581A93DF2A28DFAC01E10C", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  var_4 = getEnt("_encstr_95D61467465F62ED66084B6BE0D8A5390955ACDF23C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = (0, 0, 10000);

  if(isDefined(var_4))
    var_5 = var_4.origin[2] + 6000;
  else
    var_5 = self.origin[2] + 6000;

  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;

  foreach(var_10 in level.characters) {
    if(var_10 == self) {
      continue;
    }
    if(isPlayer(var_10)) {
      continue;
    }
    var_7 = var_7 + (var_10.origin - level.mapcenter);
    var_6[var_6.size] = var_10;
  }

  if(isDefined(var_7) && var_6.size > 0) {
    var_8 = vectorNormalize(var_7 / var_6.size);
    var_8 = var_8 * (1, 1, 0);
  } else {
    var_12 = randomint(360);
    var_8 = anglesToForward((0, var_12, 0));
  }

  if(isDefined(self.drone_strike_dir_override)) {
    var_8 = anglesToForward(self.drone_strike_dir_override.angles);
    var_8 = vectorNormalize(var_8);
    var_8 = var_8 * (1, 1, 0);
  }

  var_13 = self.origin + (0, 0, var_5);
  var_14 = var_13 + var_8 * -3000;
  var_14 = var_13 + var_8 * -3000;
  var_15 = var_13;
  var_16 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_14);
  var_16 setModel("_encstr_87E11677D6917D9DDAD7AD5AE6CDD263B2F51B275D5A6E2B");
  var_16.owner = self;
  var_16.origin = var_14;
  var_16.angles = vectortoangles(var_15 - var_14);
  var_16.type = "_encstr_A1530723371D084D2A";
  var_16.team = self.team;
  var_16.entitynumber = var_16 getentitynumber();
  var_16.streakinfo = var_1;
  var_16.duration = 30;
  self.restoreangles = self getplayerangles();
  level.rockets[var_16.entitynumber] = var_16;
  level.remotemissileinprogress = 1;
  thread cruisepredator_followmissilepod(var_16, var_15, var_2, var_0);
  thread cruisepredator_watchownerdisown(var_16);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

cruisepredator_followmissilepod(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_8B2D0BF0DAD59FDB9301D3590B");
  var_5 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_A1400C9BD0CA36B1F513399585AD");
  var_6 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_97F01828E26E6770539779639327D8D957E988786B03970B0FC2");
  var_7 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_8C4C09CA106B5731C02D9C");
  var_8 = var_4;
  var_9 = var_5 - var_4;
  var_10 = var_6 - var_5;
  var_11 = var_7 - var_6;
  var_12 = undefined;
  var_13 = undefined;

  if(!istrue(var_2)) {
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    self setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 1);
    var_12 = mark_enemies(self);
    self playerlinkweaponviewtodelta(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
  }

  scripts\cp\utility::setdof_cruisethird();
  var_14 = "_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7";
  var_15 = getdvarint("_encstr_BE9716C7AF038830426B102B170728583B4347173F2A6B98", 0);

  if(var_15 == 1)
    var_14 = "_encstr_B8D42308C1F8665BFBA367CD9FB9509BEFA89203667D8D4E3A3E96FD64B53F46A3E07910BF";

  var_0 scriptmodelplayanimdeltamotion(var_14);
  var_0 setscriptablepartstate("_encstr_ACE90E9DC2D03A698D78D8DB1B8B72ED", "_encstr_AB0703DBB9", 0);
  var_0 setscriptablepartstate("_encstr_9A5007A9E5275F8ACA", "_encstr_AB0703DBB9", 0);

  if(!istrue(var_2))
    self playlocalsound("_encstr_A19E1DD434E161FBD3080F7F902EBD4A0F4E5C0D95874B0C3B71070370A367");

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_8);
  var_0 setscriptablepartstate("_encstr_99760C3BB425F90F7192E8070B20", "_encstr_AB0703DBB9");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_9);
  var_0 setscriptablepartstate("_encstr_99760C3BB425F90F7192E8070B20", "_encstr_BA19049F4B2D");
  var_0 setscriptablepartstate("_encstr_ACE90E9DC2D03A698D78D8DB1B8B72ED", "_encstr_BA19049F4B2D", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_10);
  var_0 setscriptablepartstate("_encstr_B4AE0D3757C4EBD1D0E4EADC8ECA27", "_encstr_AB0703DBB9", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_11 - 0.32);

  if(!istrue(var_2)) {}

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var_16 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_8DCB0F47F22330CEE7996B13A2E390583A"), var_0 gettagorigin("_encstr_91630C0C561F51EA516F0F610550"), var_0 gettagorigin("_encstr_91630C0C561F51EA516F0F610550") + anglesToForward(var_0 gettagangles("_encstr_91630C0C561F51EA516F0F610550")) * 10, self);
  var_16.angles = var_0 gettagangles("_encstr_91630C0C561F51EA516F0F610550");
  var_16 setmissileminimapvisible(1);
  var_16 setotherent(self);
  var_16.team = self.team;
  var_16.owner = self;
  var_16.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_16 gettagorigin("_encstr_8E010B996FB7B6B3C1D1183343"));
  var_16.killcament setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_16.killcament linkTo(var_16, "_encstr_8E010B996FB7B6B3C1D1183343");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_16 gettagorigin("_encstr_B2BF0708BA770F795B"));
  var_17 setModel("_encstr_8DBB16D66EF5C64E574BB92BD707C9B246581DDE39D7D60E");
  var_17.angles = var_16 gettagangles("_encstr_B2BF0708BA770F795B");
  var_17 linkTo(var_16, "_encstr_B2BF0708BA770F795B");
  var_17 setscriptablepartstate("_encstr_93640BB9B39752774DD59789A4", "_encstr_AB0703DBB9", 0);
  var_17 setotherent(self);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var_0 hide();

  if(!istrue(var_2)) {}

  scripts\cp\utility::setdof_cruisefirst();
  var_0 setscriptablepartstate("_encstr_9A5007A9E5275F8ACA", "_encstr_BA19049F4B2D", 0);
  var_0 setscriptablepartstate("_encstr_B4AE0D3757C4EBD1D0E4EADC8ECA27", "_encstr_BA19049F4B2D", 0);

  if(!istrue(var_2)) {
    self cameraunlink();
    self cameralinkTo(var_16, "_encstr_8E010B996FB7B6B3C1D1183343", 1);
    self controlslinkTo(var_16);
    self playlocalsound("_encstr_BA321749CFE2F1A7169BAA73E1F8D734E06FF1C47331C2433E");
    self setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 2);
    self setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", 1);
    self setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(10000));
    self setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", -1);
    self visionsetkillstreakforplayer("_encstr_A38610F3626FA0B0F99FFDCB8F038DB1357A");

    if(istrue(level.thermal)) {
      self thermalvisionon();
      self visionsetthermalforplayer("_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320");
    }

    self setplayerangles(var_16.angles);
    var_16 hidefromplayer(self);
  }

  var_18 = randomintrange(1, 3);
  var_16 enablemissileboosting();
  var_16 thread cruisepredator_watchexplosion(self, var_16.killcament, var_2, var_17, var_12, var_13);
  var_16 thread cruisepredator_watchtimer(self);

  if(isDefined(var_0))
    var_0 delete();
}

cruisepredator_watchexplosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_1;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = cruisepredator_waittillexplode("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", "_encstr_860808CB78E2984063BA");

  if(isDefined(var_4))
    unmark_enemies(var_0);

  if(isDefined(var_5)) {}

  if(isDefined(var_9)) {
    if(isDefined(self)) {
      var_7 = self.origin;
      var_8 = self.angles;

      if(var_9.msg == "_encstr_8DE90E4D31C35370B84D709B4B6DEE42") {
        var_10 = 400;
        var_11 = var_7 + (0, 0, int(var_10 / 8));
        var_12 = [];
        var_13 = var_9.param1;

        if(isDefined(var_13))
          var_13 dodamage(10000, var_7, var_0, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8DCB0F47F22330CEE7996B13A2E390583A");

        foreach(var_15 in level.characters) {
          if(!isDefined(var_15) || !var_15 scripts\cp_mp\utility\player_utility::_isalive()) {
            continue;
          }
          if(isPlayer(var_15)) {
            continue;
          }
          if(distancesquared(var_11, var_15.origin) > 320000) {
            continue;
          }
          var_12[var_12.size] = var_15;
        }

        if(isDefined(level.remote_tanks)) {
          foreach(var_18 in level.remote_tanks) {
            if(isDefined(var_18)) {
              if(distancesquared(var_11, var_18.origin) > 320000) {
                continue;
              }
              var_12[var_12.size] = var_18;
            }
          }
        }

        if(var_12.size > 0) {
          var_20 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1);

          foreach(var_22 in var_12) {
            var_23 = var_22.origin + (0, 0, 10);

            if(var_22.classname != "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
              var_23 = var_22 getEye();

            var_24 = scripts\engine\trace::ray_trace_passed(var_11, var_23, self, var_20);

            if(istrue(var_24))
              var_22 dodamage(10000, var_7, var_0, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8DCB0F47F22330CEE7996B13A2E390583A");
          }
        }

        playrumbleonposition("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_7);
        earthquake(0.09, 1, var_7, 800);
        self detonate();
      }
    }
  }

  var_3 thread cruisepredator_handlevfxstates(self, var_0, var_9);

  if(isDefined(var_0)) {
    var_0 thread cruisepredator_watchkills(var_9);

    if(!istrue(var_2)) {
      var_0 stoplocalsound("_encstr_BA321749CFE2F1A7169BAA73E1F8D734E06FF1C47331C2433E");
      var_0 stoplocalsound("_encstr_886B1CB0F360F82B12AF93DBB23FEBA077F3C21125E87024730F1AB3268F");
      var_0 stoplocalsound("_encstr_ADAF1BC168F0419F92A34BC3B24F0DC1CBF7E2087DCEAAE263576862B1");
      var_0 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 0);
      var_0 visionsetkillstreakforplayer("_encstr_B40101");
      var_0 thermalvisionoff();
      var_26 = getdvarint("_encstr_A7EA17BFB756990BF0F30C92E9C159F22FCB773B67FD23D0A0", 1);

      if(!isDefined(var_7)) {
        var_0 cruisepredator_returnplayer();
        return;
      }

      var_27 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
      var_27 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
      var_28 = getdvarint("_encstr_8CBC175E3EC35FB1AA0780582FEF2953CB26DE6B997AFB7B74", 1000);
      var_29 = getdvarint("_encstr_AF3019C31EE3D77E453002BBA8C777F7DBF75B40B808678407F0DB", 0);

      if(!isDefined(var_8)) {
        var_0 cruisepredator_returnplayer();
        return;
      }

      var_30 = anglesToForward(var_8);
      var_31 = var_7 - var_30 * var_28;
      var_32 = (0, 0, var_29);
      var_33 = var_31 + var_32;
      var_27.angles = vectortoangles(var_7 + (0, 0, 150) - var_33);
      var_6 unlink();
      var_6 linkTo(var_27, "_encstr_8E010B996FB7B6B3C1D1183343", (0, 0, 0), (0, 0, 0));
      var_0 cameraunlink();

      if(var_26 == 1 || var_26 == 2) {
        var_27.origin = var_33;
        var_0 playerlinkweaponviewtodelta(var_27, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
        var_0 playerlinkedsetviewznear(0);
        var_0 setplayerangles(var_27.angles);
        var_34 = "_encstr_A13817972B0FDAEFB8915BFE15F72F4B48E3CEAED5F8E3F18E";

        if(var_26 == 2)
          var_34 = "_encstr_9A7416B19CD55ACDB2FAC12756C8C21DB793D799632C6E86";

        var_0 thread cruisepredator_startfadecamtransition(0.4, 0.1, 0.05, var_34);
        var_0 earthquakeforplayer(0.3, 2, var_0.origin, 100);
        var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
        wait 0.1;
      } else {
        var_27 thread cruisepredator_cameramove(var_33, var_7);
        var_0 thread cruisepredator_startexplodecamtransition();
        var_0 playerlinkweaponviewtodelta(var_27, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
        var_0 playerlinkedsetviewznear(0);
        var_0 setplayerangles(var_27.angles);
        var_0 playlocalsound("_encstr_8432170BB7222E0F52839078BA21DB20D75B83713D17D161BA");
        var_0 earthquakeforplayer(0.25, 1.5, var_33, 5000);
        wait 1.3;
        var_0 thread cruisepredator_startfadecamtransition();
        wait 0.5;
      }

      var_27 delete();
      var_0 cruisepredator_returnplayer();
    }
  }

  if(isDefined(var_6))
    var_6 delete();

  var_0 scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("_encstr_8DDA0D2327EDB995D7DC1D4EB4DACA"));
}

mark_enemies(var_0) {
  var_0.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(var_1 = 0; var_1 < level.spawned_enemies.size; var_1++) {
      level.spawned_enemies[var_1] hudoutlineenableforclient(var_0, "_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
      var_0.enemy_list[var_0.enemy_list.size] = level.spawned_enemies[var_1];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(var_3 in level.remote_tanks) {
      if(isDefined(var_3)) {
        var_3 hudoutlineenableforclient(var_0, "_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
        var_0.enemy_list[var_0.enemy_list.size] = var_3;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(var_0, "_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
    var_0.enemy_list[var_0.enemy_list.size] = level.heli;
  }

  return var_0.enemy_list;
}

unmark_enemies(var_0) {
  if(isDefined(var_0.enemy_list)) {
    foreach(var_2 in var_0.enemy_list) {
      if(isDefined(var_2))
        var_2 hudoutlinedisableforclient(var_0);
    }
  }
}

cruisepredator_cameramove(var_0, var_1) {
  self moveTo(var_0, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(var_0 + vectorNormalize(var_1 - var_0) * 24, 2);
}

cruisepredator_returnplayer() {
  self cameraunlink();
  self controlsunlink();
  self setplayerangles(self.restoreangles);
  self.restoreangles = undefined;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);
  scripts\cp\utility::setdof_default();
  thread stopremotesequence();
}

cruisepredator_watchtimer(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(10.1);
  self detonate();
}

cruisepredator_watchexplosiondistance(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = [self, var_1];
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    var_4 = anglesToForward(self.angles);
    var_5 = self gettagorigin("_encstr_91630C0C561F51EA516F0F610550");
    var_0.lastknownmissilepos = var_5;
    var_0.lastknownmissileangles = self.angles;
    var_6 = getdvarint("_encstr_BA67170328D5F9A76BA57163B51657BD39C08AEB61412CAFC3", 50);

    if(isDefined(self.missilebooston))
      var_6 = getdvarint("_encstr_A2161DC399CE872690E3796BEBD16CF777715A3B66AE0F1D40195744EBC873", 150);

    var_7 = var_5 + var_4 * var_6;
    var_8 = scripts\engine\trace::sphere_trace(var_5, var_7, 5, var_2, var_3);

    if(isDefined(var_8["_encstr_AA1C0886968EA32FE056"]) && var_8["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
      if(isDefined(var_8["_encstr_BD260953AA97E3F014279D"])) {
        var_0.lastknowntrace = var_8;
        self notify("_encstr_875516B6D2DC6E968DAC7D8DC6F69BACBE56E1E036F6C8B2", var_8["_encstr_BD260953AA97E3F014279D"]);
        break;
      }
    }

    wait 0.05;
  }
}

cruisepredator_watchmissileboost(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notifyonplayercommand("_encstr_955E11E2188EF76420830F3ABF10AA5320704A", "_encstr_A9E60828803C73F11780");

  for(;;) {
    var_0 waittill("_encstr_955E11E2188EF76420830F3ABF10AA5320704A");
    self.missilebooston = 1;
    break;
  }
}

cruisepredator_watchownerdisown(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AE("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(var_0))
      var_0 delete();
  }
}

cruisepredator_startexplodecamtransition() {
  wait 0.1;
}

cruisepredator_startfadecamtransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 0.5;

  if(!isDefined(var_1))
    var_1 = 0.5;

  if(!isDefined(var_2))
    var_2 = 0.05;

  if(isDefined(var_3))
    wait(var_1);
  else
    wait(var_1);
}

cruisepredator_shakerider(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;

  while(var_1 < var_0) {
    self playrumbleonpositionforclient("_encstr_B14F0D7B2B51F287F03ED59C51F0DC", self.origin);
    var_1 = var_1 + 0.05;
    wait 0.05;
  }
}

cruisepredator_waittillexplode(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = spawnStruct();

  if(isDefined(var_0))
    thread waittill_explodestring(var_0, var_2);

  if(isDefined(var_1))
    thread waittill_explodestring(var_1, var_2);

  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  var_2 notify("_encstr_B81804322D2B");
  var_10 = spawnStruct();
  var_10.msg = var_3;
  var_10.param1 = var_4;
  var_10.param2 = var_5;
  var_10.param3 = var_6;
  var_10.param4 = var_7;
  var_10.param5 = var_8;
  var_10.param6 = var_9;
  return var_10;
}

waittill_explodestring(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

cruisepredator_handlevfxstates(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self unlink();

  if(!isDefined(var_2) || var_2.msg == "_encstr_860808CB78E2984063BA") {
    self setscriptablepartstate("_encstr_88460E53F9127135637BF88053FFF830", "_encstr_AB0703DBB9", 0);
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
    self delete();
  }

  var_3 = (0, 0, 1);
  var_4 = var_2.param6;
  self.angles = vectortoangles(var_4);
  var_5 = vectordot(var_4, var_3);

  if(var_5 >= 0.7)
    self setscriptablepartstate("_encstr_861B113BC9B7D537C8BEACF038D87BCD4BF637", "_encstr_AB0703DBB9", 0);
  else
    self setscriptablepartstate("_encstr_88460E53F9127135637BF88053FFF830", "_encstr_AB0703DBB9", 0);

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  self delete();
}

cruisepredator_watchkills(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(1);
}

playremotesequence(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\cp\utility::isusingremote())
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  self notify("_encstr_AD66151CC6B0CBBE93566BED1D56BE37952ED5ACCDD8CA");
  self playlocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
  var_2 = undefined;

  if(self isonladder() || self ismantling() || !self isonground())
    return 0;

  var_2 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";
  scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
  var_3 = int(tablelookup("_encstr_AB7A17451FC08F44C1703B43683BBE77430FD2CC3DB8E78AAD", 1, var_0.streakname, 0));
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", var_3);
  var_4 = scripts\cp\cp_weapons::switchtoweaponreliable(var_2);

  if(istrue(var_4))
    thread scripts\cp\cp_weapons::watchformanualweaponend(var_2);

  scripts\cp\utility::setusingremote(var_0.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  var_5 = scripts\engine\utility::_id_143B9(1.8, "_encstr_AD75063D571AE108");
  self notify("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

  if(isDefined(var_2))
    self takeweapon(var_2);

  self stoplocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
  return 1;
}

watchvisordeath() {
  self endon("_encstr_B45E151389187A1756D9AA720325DF72902BAD8D251047");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

stopremotesequence(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B45E151389187A1756D9AA720325DF72902BAD8D251047");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(istrue(level.nukedetonated) && !istrue(level.nukecancel)) {}

    var_1 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";

    if(istrue(var_0)) {
      wait 0.1;
      self notify("_encstr_85D31DAEA242BB50514D3967832BF11BAE0557E8D3D709E887FA8EA398AD48" + var_1);
    } else
      self notify("_encstr_95E2216DD2631BE61DE4B20BB6F5995ADC9637A12B32AFDD4BE834AFEEB2C21CBD37AF" + var_1);
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::_id_143B9(1.3, "_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
}