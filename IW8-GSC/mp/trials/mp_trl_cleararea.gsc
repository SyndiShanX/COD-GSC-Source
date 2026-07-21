/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_trl_cleararea.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_8E95062EE46DB683"] = ::init;
}

init() {
  build_vehicle_drop_off_list();
  setdvarifuninitialized("_encstr_9978113AF51BB19C7D932C3216E4EBE8E53895", "_encstr_851904B59B34");
  setdvarifuninitialized("_encstr_8DAE1447AF368D4E7DACCDB26BB459DCEBE8BDD12C1B", "_encstr_8D070366C0");

  if(!isDefined(game["_encstr_8CA606F38878410D"]))
    game["_encstr_8CA606F38878410D"] = [];

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"]))
    game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"] = 0;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"]))
    game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] = level.trial["_encstr_A67009D77B23ABF02883D0"];

  level.mapname = level.trial["_encstr_836105A5EFB2E5"];
  level.enemies = [];
  level.enemiesactivenb = 0;
  level.enemiestotal = 0;
  level.enemieskilled = 0;
  level.totaltimeelapsed = 0;
  level.attempttier = 0;
  level._id_11B77 = 59999900;
  level.modeonspawnplayer = ::_id_124D6;
  level scripts\engine\utility::flag_init("_encstr_BA57193AC95A2C63EBDCD116273ABE4FDEB995AF2BDCA359C92B32");
  level scripts\engine\utility::flag_init("_encstr_8C5E103AE4D2B01BEBD8DB5737A323B7DD37");
  level scripts\engine\utility::flag_init("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");
  level scripts\engine\utility::flag_init("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level scripts\engine\utility::flag_init("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
  level scripts\engine\utility::flag_init("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072");
  precachemodel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  precachemodel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
  precachemodel("_encstr_B86D1CF55F30D19C9FEA99A1E2875C708FA67B61FD51F246374253A9BA6B");
  precachemodel("_encstr_A3B614C471D0BC217F11BF7F739D8AFC889EAA8169A0");
  precachemodel("_encstr_96D2193468575B264704F738536390EB83DF6045EF4DF32DB0592A");
  precachemodel("_encstr_B6D21952F813D7B7E989E7C11713179DBB911A1AA0E38AD306CFF8");
  precachemodel("_encstr_B4D21934562C32AFC28DFA8B0BD12CB10BBEC82BDCAC4ED1AFC027");
  precachemodel("_encstr_A5981971E52488E85AE3E783EF33CFE8F97139690A8D6835D1FA35");
  precachemodel("_encstr_8698196E18D089195739A7170B85A2C49066673733604A63A0992E");
  precachemodel("_encstr_A998195607FB42CF2EBA798B82836B38478FED5D73876BD19967B2");
  precachemodel("_encstr_87611B31ED46CBBEB063FAC5851D85D858AF91AC37AC39D1BEC064AF4C");
  level.enemyheadmodels = [];
  level.enemyheadmodels[0] = "_encstr_A3B614C471D0BC217F11BF7F739D8AFC889EAA8169A0";
  level.enemyheadmodels[1] = "_encstr_96D2193468575B264704F738536390EB83DF6045EF4DF32DB0592A";
  level.enemyheadmodels[2] = "_encstr_B6D21952F813D7B7E989E7C11713179DBB911A1AA0E38AD306CFF8";
  level.enemyheadmodels[3] = "_encstr_B4D21934562C32AFC28DFA8B0BD12CB10BBEC82BDCAC4ED1AFC027";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "_encstr_A5981971E52488E85AE3E783EF33CFE8F97139690A8D6835D1FA35";
  level.enemybodymodels[1] = "_encstr_8698196E18D089195739A7170B85A2C49066673733604A63A0992E";
  level.enemybodymodels[2] = "_encstr_A998195607FB42CF2EBA798B82836B38478FED5D73876BD19967B2";
  level.enemybodymodels[3] = "_encstr_87611B31ED46CBBEB063FAC5851D85D858AF91AC37AC39D1BEC064AF4C";
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  thread trial_start_init();
  thread player_init();
  thread enemies_init();
  thread enemy_chatter();
  thread hud_init();
  thread dialog_init();
  level.battlechatterenabled = 0;

  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  thread _id_1385C();
  level.brjugg_dropondeath = getallnodes();
}

trial_start_init() {
  level endon("_encstr_999A060533C0FDD2");

  while(!isDefined(level.struct_class_names))
    waitframe();

  if(istrue(level._id_13D41)) {
    level.onweapondroppickedup = getEntArray("_encstr_AC05113579E888A09B709B05B711F0BA02DD73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.onweapontaken = getEntArray("_encstr_A5770E750AC145C03FD456B30FC0D245", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.brprewaitandspawnclient = getEntArray("_encstr_A3990BDBEF05B561FA5A488BD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    scripts\engine\utility::array_thread(level.onweapontaken, ::lb_mg_wood_surf_dmg_scalar);
    scripts\engine\utility::array_thread(level.onweapondroppickedup, ::chopperoccupied);
    scripts\engine\utility::array_thread(level.brprewaitandspawnclient, ::brplayerhudoutlineupdatefromnotify);
  }

  var_0 = getEnt("_encstr_969B0AA03FEF33C7B2375465", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_96E70B15FDD2C5F66AB730402B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_9B2F0E4C90C8EBC9DF68CAF1983B7F0B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_97AD0FA37580DDBFAB6540A933C737DA63", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = undefined;

  if(level.mapname == "_encstr_AB5D0960CBB77E40E7D955" || level.mapname == "_encstr_8E940C29F87032C3FF82F50F725A") {
    var_4 = getEnt("_encstr_99300A91E7AA66990BB5F8F0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = getEnt("_encstr_8AA00F0B4720B3CFE829E76B8678378A09", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_6 = getEnt("_encstr_AAE210C99D27D8E073FFAFB9A38936E8CCB5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 linkTo(var_0);
    var_6 linkTo(var_1);
  } else if(isDefined(var_2) || isDefined(var_3)) {
    if(isDefined(var_2))
      var_0.helimakeexfilwait = var_2;

    if(isDefined(var_3))
      var_1.helimakeexfilwait = var_3;
  } else {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_7.angles = var_0.angles;
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_8.angles = var_0.angles;
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_9.angles = var_1.angles;
    var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_10.angles = var_1.angles;
    var_7 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
    var_8 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
    var_9 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
    var_10 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
    var_7 linkTo(var_0, "_encstr_A557166C83AF914BE6D8B77D9D2C47ACFA06267D1BCA993A", (0, -44, 20), (90, 0, 0));
    var_8 linkTo(var_0, "_encstr_A557166C83AF914BE6D8B77D9D2C47ACFA06267D1BCA993A", (0, -44, 84), (90, 0, 0));
    var_9 linkTo(var_1, "_encstr_AF7F17B1387D8CD2CDB1B7FA9DB0E8CAFA184CEB275ACE4347", (0, -44, 20), (-90, 0, 0));
    var_10 linkTo(var_1, "_encstr_AF7F17B1387D8CD2CDB1B7FA9DB0E8CAFA184CEB275ACE4347", (0, -44, 84), (-90, 0, 0));
  }

  var_11 = scripts\mp\trials\mp_trials_patches::trial_chevron_init();

  while(!isDefined(level.player))
    wait 0.05;

  if(isDefined(level._id_13D59)) {
    foreach(var_13 in level._id_13D59)
    level.player setperk(var_13, 1);
  }

  while(!isalive(level.player))
    wait 0.05;

  if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] > 2)
    wait 8;

  wait 2;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(var_11, "_encstr_8BF50833D895F5178868");
  level scripts\engine\utility::flag_wait("_encstr_BA57193AC95A2C63EBDCD116273ABE4FDEB995AF2BDCA359C92B32");
  level.started = 1;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(var_11, "_encstr_A51309AB0D5D5A9F28F84B");
  _tablethide::_id_13D88();
  _tablethide::_id_13D89(0);
  thread radar_think();
  wait 2;
  level scripts\engine\utility::flag_set("_encstr_8C5E103AE4D2B01BEBD8DB5737A323B7DD37");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  level scripts\engine\utility::flag_set("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");
  thread player_monitor_death();

  if(isDefined(var_4))
    var_4 notsolid();

  var_1 playSound("_encstr_866C1E6082EC0F11AF97B00B07CD3FA03E9021113739F0407143C277014F16DB");
  var_0 playSound("_encstr_866C1E6082EC0F11AF97B00B07CD3FA03E9021113739F0407143C277014F16DB");
  var_1 rotateYaw(-150, 0.75);
  var_0 rotateYaw(150, 0.75);

  if(isDefined(var_0.helimakeexfilwait))
    var_0.helimakeexfilwait delete();

  if(isDefined(var_1.helimakeexfilwait))
    var_1.helimakeexfilwait delete();
}

radar_think() {
  var_0 = getDvar("_encstr_9978113AF51BB19C7D932C3216E4EBE8E53895");

  if(var_0 != "_encstr_8BBA05185F8B99") {
    var_1 = level.player scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");
    var_2 = level.player scripts\mp\equipment::getequipmentammo("_encstr_BA7F0830B3A7859B60B0");
    var_3 = level.player scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8");
    var_4 = level.player scripts\mp\equipment::getequipmentammo("_encstr_AC8F0AE74163F85AAA380AD8");

    if(isDefined(var_1)) {
      level.player scripts\mp\equipment::takeequipment("_encstr_BA7F0830B3A7859B60B0");
      var_5 = 1;
    } else
      var_5 = 0;

    if(isDefined(var_3)) {
      level.player scripts\mp\equipment::takeequipment("_encstr_AC8F0AE74163F85AAA380AD8");
      var_6 = 1;
    } else
      var_6 = 0;

    level.player allowmelee(0);
    level.player allowsprint(0);
    level.player allowreload(0);
    level.player cancelreload();

    while(level.player ismeleeing())
      waitframe();

    level.uavsettings[var_0].timeout = 9999;
    level.player scripts\cp_mp\killstreaks\uav::tryuseuav(var_0);
    waitframe();
    level.player allowmelee(1);
    level.player allowsprint(1);
    level.player allowreload(1);

    if(isDefined(var_1) && istrue(var_5))
      level.player scripts\mp\equipment::giveequipment(var_1, "_encstr_BA7F0830B3A7859B60B0");

    if(isDefined(var_3) && istrue(var_6))
      level.player scripts\mp\equipment::giveequipment(var_3, "_encstr_AC8F0AE74163F85AAA380AD8");
  }
}

player_init() {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  self.player scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  wait 0.5;
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.enemyteam = scripts\engine\utility::get_enemy_team(level.player.team);
  level.playerteam = level.player.team;

  if(level.playerteam == "_encstr_8E8405EA382B2A") {
    level.enemyteam = "_encstr_9A8507BA4040188D08";
    level.agent_definition["_encstr_AFDA19161B477B9CBE95E6956B2FAF6BC1EBA3274B161BEB6CD839"]["_encstr_8AEF05472BC2D6"] = level.enemyteam;

    if(isDefined(level.nightmap) && level.nightmap == 1) {
      level.agent_definition["_encstr_856222C69E33F87239DBCE51300390D0E35779430216202736BB32117735E6A3C05F9A25"]["_encstr_8AEF05472BC2D6"] = level.enemyteam;
      level.agent_definition["_encstr_BECC231EF6A1BA22BE70DBFF1852D74241AFA3526B33C2474120930F1008A72925A3EF4C4D"]["_encstr_8AEF05472BC2D6"] = level.enemyteam;
    } else {
      level.agent_definition["_encstr_AD271CAADAF597623F87C28131B7F74283895BC31B5040769692C3B7230E"]["_encstr_8AEF05472BC2D6"] = level.enemyteam;
      level.agent_definition["_encstr_9A7C1D2CC6A3DB27BE9573596BF2AFB683EB1D395AC2B1F5C6C69CF5CD5BCE"]["_encstr_8AEF05472BC2D6"] = level.enemyteam;
    }
  }

  thread set_corpse_detect_ranges();
  thread _id_1248D();
  thread _id_1246D();
}

_id_124D6() {
  level.player.maxhealth = 250;
  level.player.health = 250;
  scripts\engine\utility::delaythread(1, ::_id_1248D);
  scripts\engine\utility::delaythread(1, ::_id_1246D);
}

player_monitor_death() {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  setDvar("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 8);
  setdynamicdvar("_encstr_929A1D37B139AF8EC996581BF5C1C658E5B2C92756E6C185EECD23ACC6C297", 0);
  level.player waittill("_encstr_AD75063D571AE108", var_0);
  setDvar("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 1.75);
  level.player setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", level.player getentitynumber());
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  level scripts\engine\utility::flag_set("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072");
  level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
}

_id_1248D() {
  if(isDefined(level._id_12489))
    level.player scripts\mp\equipment::giveequipment(level._id_12489, "_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(level._id_1248B))
    level.player scripts\mp\equipment::giveequipment(level._id_1248B, "_encstr_AC8F0AE74163F85AAA380AD8");

  if(istrue(level._id_1248A))
    thread _id_12A8E();
}

_id_1246D() {
  var_0 = level.player getweaponslistprimaries();

  if(istrue(level._id_124C9)) {
    foreach(var_2 in var_0) {
      var_3 = level.player getweaponammoclip(var_2) + level.player getweaponammostock(var_2);
      var_4 = level.enemiestotal - weaponclipsize(var_2);
      level.player setweaponammoclip(var_2, weaponclipsize(var_2));
      level.player setweaponammostock(var_2, var_4);
    }

    foreach(var_7 in level.trial_weapons) {
      if(isDefined(var_7.spawned_weapon)) {
        var_8 = weaponclipsize(var_7.spawned_weapon);
        var_4 = level.enemiestotal - var_8;
        var_7.spawned_weapon itemweaponsetammo(var_8, var_4);
      }
    }
  } else {
    foreach(var_2 in var_0) {
      level.player setweaponammoclip(var_2, weaponclipsize(var_2));
      level.player givemaxammo(var_2);
    }

    foreach(var_7 in level.trial_weapons) {
      if(isDefined(var_7.spawned_weapon)) {
        var_8 = weaponclipsize(var_7.spawned_weapon);
        var_4 = weaponmaxammo(var_7.spawned_weapon);
        var_7.spawned_weapon itemweaponsetammo(var_8, var_4);
      }
    }
  }
}

set_corpse_detect_ranges() {
  var_0 = getEntArray("_encstr_BD7D0C1C33C5559F3A7F2F912510", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_0, ::set_combat_action);
}

set_combat_action() {
  switch (self.script_noteworthy) {
    case "_encstr_8A78055C8D488C":
      var_0 = "_encstr_8BBB0B9D41E718D9E922D8582A";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_B2161BA6A0F5A439E882A9A2BE7A7226AC970A52A15A5541D78CA414D1";
      break;
    case "_encstr_9301076F8808DCFA41":
      var_0 = "_encstr_8C450D955CD52D07D7DC2BB6A39587";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_856F1D9A41FA529C8E0A9A54AF7A9CC4ACBC0A4A682DAA0AFA6A8AA9512A0B";
      break;
    case "_encstr_8B07036CD0":
      var_0 = "_encstr_843D095F2B7D52B041D9A3";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_AD5A19A614FA529CE80AA951BED39313CACB1429D0D25514FA0D0D";
      break;
    case "_encstr_9BD1091BC62CBCB5F6E4CA":
      var_0 = "_encstr_82A70F2B3B73E33B472371FF21D7809DDF";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_96981FE9C3DF54E5743EC1FD81B8DDBC71A689B1E7936F11695649F768F097A795";
      break;
    case "_encstr_8DD607A129A89C737D":
      var_0 = "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_86DA1DA60ABE9472748235A27D9E2713CA5EA092A1D2AA82FA14A2A629C98A";
      break;
    case "_encstr_A1C3071D43932DFD6F":
      var_0 = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_82AB1D0D57A111B0ECCB772F8F80F85CC910F284ADE9F589D8C9670B8BDCB0";
      break;
    case "_encstr_8DCB085BEF657B4DCF0B":
      var_0 = "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_83D51E7188A7F47D37F899D1F1DD85AC576F67FB33AF3F0969D49161E823CFA7";
      break;
    case "_encstr_8D7609A4F337C2C9C2BDB7":
      var_0 = "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61";
      var_1 = "_encstr_BA7F0830B3A7859B60B0";
      var_2 = &"_encstr_A97A1FBB01411926D88880D7C057253459F837F9E8324999A79DC8A9425BF361FD";
      break;
    case "_encstr_88A906570DDE7B21":
      var_0 = "_encstr_BD170C5B689B786221E98009A80C";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_A5641C9A41FA529C7414D4547D9E728965E5824A682DAAA0BE8C260AA921";
      break;
    case "_encstr_9B6609EB658A6B7A335003":
      var_0 = "_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_AB491F87315EF1584F679D877077104C26626B1F513425812706558EDFB7A807EF";
      break;
    case "_encstr_BE7206A2D07B1322":
      var_0 = "_encstr_84CB0CB2680B841B3E76A5AF0201";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_A5E31C8132D1B3D45F17612987BF2C415975873B5EC8C35F1F677981CF8D";
      break;
    case "_encstr_9B1905D3B92BF0":
      var_0 = "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_A3B21B0D77DFF02685794F97717CEE680B50C2B4569F4960AEC123DFD1";
      break;
    case "_encstr_9BB4074B8EEF3942D8":
      var_0 = "_encstr_AA870D15FAF37393C74318F8BB184A";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_9A62240D0741EF9D6FD0B1A3DFE7A47DF1FDD1417B41778041D9190FD96418CF4180078B7525";
      break;
    case "_encstr_AD75063D573AD72A":
      var_0 = "_encstr_8B0E0CAC5CAB4B38FA46566CBDF2";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_91B21CB5EF19A9387453FFD7070840D441987A0C25617D115061C7B73F2B";
      break;
    case "_encstr_BA19058303338D":
      var_0 = "_encstr_820F114AE740032B7F8680CAD930B1D239F212";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_A9B21BD4A07DA472E8A06A54D79E39139597054A34D2AA057DA64592D4";
      break;
    case "_encstr_B4570A0E100E4F3D82C16ACB":
      var_0 = "_encstr_BDC515ACB85DD207FA37B14E0B6B4CB159E48C4E7BB92B";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_ACBF20CD57965FE5FF61B008A9D7AD030E8058B146BC97BA2719587131BB96DB6586";
      break;
    default:
      var_0 = "_encstr_8BBB0B9D41E718D9E922D8582A";
      var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
      var_2 = &"_encstr_B2161BA6A0F5A439E882A9A2BE7A7226AC970A52A15A5541D78CA414D1";
      break;
  }

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_3 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (5, 0, 12), (0, 0, 0));
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 setHintString(var_2);
  var_3 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(65);
  var_3 setuserange(72);
  var_3 setusefov(120);
  var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  var_3 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    var_3 makeusable();
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A");
    level.player scripts\mp\equipment::giveequipment(var_0, var_1);
    var_3 makeunusable();
    wait 2.5;
  }

  var_3 makeunusable();
}

enemies_init() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEnt("_encstr_AC711170ABB6157B5F6EB4A06CEB2DF79F02F0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0 scripts\engine\utility::get_target_array();
  level.enemyspawners = [];
  var_2 = getDvar("_encstr_8DAE1447AF368D4E7DACCDB26BB459DCEBE8BDD12C1B");

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_index)) {
      if(int(var_4.script_index) <= int(var_2))
        level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, var_4);

      continue;
    }

    level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, var_4);
  }

  level.enemiestotal = level.enemiestotal + level.enemyspawners.size;

  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  scripts\engine\utility::array_thread(level.enemyspawners, ::enemy_individual_spawn);
  thread enemies_spawnif_noactive();
  thread nextcombatareaid();
  thread new_objective();
}

enemy_model_setup(var_0) {
  var_1 = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  var_2 = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(var_2);
  self attach(var_1, "_encstr_B40101", 1);
  self.headmodel = var_1;
}

enemy_individual_spawn() {
  var_0 = self;
  level scripts\engine\utility::flag_wait("_encstr_8C5E103AE4D2B01BEBD8DB5737A323B7DD37");
  var_1 = "_encstr_85DC14D248353FD06943D0F759289C57E906CACA5380";

  if(isDefined(level.nightmap) && level.nightmap == 1)
    var_2 = "_encstr_836A076728795F83AB";
  else
    var_2 = "_encstr_B40101";

  switch (var_0.script_noteworthy) {
    case "_encstr_9A190463ADB3":
    case "_encstr_AD07034A38":
      var_3 = var_1 + "_encstr_AD07034A38" + var_2;
      break;
    case "_encstr_BE1904DCDA9D":
      var_3 = var_1 + "_encstr_BE1904DCDA9D" + var_2;
      break;
    default:
      var_3 = "_encstr_8A0E139B38A9B5EBD67A4B59653B502624E63E6253";
      break;
  }

  var_4 = getEntArray("_encstr_ADF30E90CB69EBDD6A6D5C4840221511", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 thread enemy_spawner_checkdist(var_4);
  var_0 waittill("_encstr_815E0A590B1B1058B8963B10");
  level.enemiesactivenb++;
  level.enemyspawners = scripts\engine\utility::array_remove(level.enemyspawners, var_0);
  var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_3, var_0.origin, var_0.angles);

  while(!isDefined(var_5))
    wait 0.05;

  level.enemies[level.enemies.size] = var_5;
  var_5 thread enemy_monitor_death(level.enemyteam);
  var_5 thread enemy_soldier_think();
  var_5 thread enemy_model_setup();

  if(isDefined(var_0.target))
    var_0 thread enemy_move_and_cover(var_5);
}

enemy_spawner_checkdist(var_0) {
  self endon("_encstr_815E0A590B1B1058B8963B10");
  var_1 = getmaxagents() - 1;
  level scripts\engine\utility::flag_wait("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");

  if(isDefined(self.radius))
    var_2 = self.radius;
  else
    var_2 = 1400;

  var_3 = [];
  var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);

  foreach(var_6 in var_0) {
    if(var_6 istouching(var_4))
      var_3 = scripts\engine\utility::array_add(var_3, var_6);
  }

  var_4 delete();

  for(;;) {
    var_8 = 0;

    if(var_3.size > 0) {
      foreach(var_6 in var_3)
      var_8 = level.player istouching(var_6);
    } else
      var_8 = 1;

    var_11 = distance2d(level.player.origin, self.origin);
    var_12 = var_11 < 250;
    var_13 = var_11 < var_2;
    var_14 = level.enemiesactivenb < var_1;
    var_15 = level.player gettagorigin("_encstr_A130084D2FDAD8AA8F62");
    var_16 = (self.origin[0], self.origin[1], self.origin[2] + 40);
    var_17 = spawnsighttrace(self, var_15, var_16);

    if(!var_17 && var_8 && var_13 && !var_12 && var_14) {
      self notify("_encstr_815E0A590B1B1058B8963B10");
      continue;
    }

    wait 0.05;
  }
}

enemies_spawnif_noactive() {
  level scripts\engine\utility::flag_wait("_encstr_8C5E103AE4D2B01BEBD8DB5737A323B7DD37");
  level endon("_encstr_8F730B82D32028A1759BF7AFD5");
  var_0 = getEntArray("_encstr_ADF30E90CB69EBDD6A6D5C4840221511", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, ::check_script_noteworthy);

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = [];
    var_5 = undefined;

    while(level.enemies.size > 0)
      wait 0.25;

    foreach(var_7 in var_0) {
      if(var_7 istouching(level.player))
        var_1 = scripts\engine\utility::array_add(var_1, var_7);
    }

    var_2 = return_enemyspawners_in_zones(var_1);

    if(var_2.size == 0) {
      var_9 = [];
      var_10 = [];

      foreach(var_7 in var_1) {
        var_9[var_9.size] = int(var_7.script_noteworthy) + 1;
        var_9[var_9.size] = int(var_7.script_noteworthy) + -1;
      }

      foreach(var_14 in var_9) {
        foreach(var_7 in var_0) {
          if(int(var_7.script_noteworthy) == var_14)
            var_10 = scripts\engine\utility::array_add(var_10, var_7);
        }
      }

      var_2 = return_enemyspawners_in_zones(var_10);
    }

    if(var_2.size == 0)
      var_2[0] = scripts\engine\utility::getclosest(level.player.origin, level.enemyspawners);

    var_3 = var_2;
    var_4 = scripts\engine\utility::get_array_of_closest(level.player.origin, var_3);

    if(var_4.size > 0) {
      for(var_18 = 0; var_18 < var_4.size; var_18++) {
        var_5 = scripts\engine\utility::random_weight_sorted(var_4);
        var_19 = level.player gettagorigin("_encstr_A130084D2FDAD8AA8F62");
        var_20 = (var_5.origin[0], var_5.origin[1], var_5.origin[2] + 40);
        var_21 = spawnsighttrace(var_5, var_19, var_20);

        if(!var_21) {
          var_5 notify("_encstr_815E0A590B1B1058B8963B10");
          break;
        }
      }
    } else {
      var_22 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B");
      var_23 = scripts\engine\utility::getclosest(level.player.origin, var_22);
      var_24 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_8A0E139B38A9B5EBD67A4B59653B502624E63E6253", var_23.origin, var_23.angles);

      while(!isDefined(var_24))
        wait 0.05;

      level.enemies[level.enemies.size] = var_24;
      var_24 thread enemy_monitor_death(level.enemyteam);
      var_24 thread enemy_soldier_think();
      var_24 thread node_cansee_child();
    }

    wait 0.05;
  }
}

nextcombatareaid() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level scripts\engine\utility::flag_wait("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    var_0 = scripts\mp\mp_agent::getfreeagentcount();

    if(var_0 == level.agentarray.size) {
      wait 0.5;

      if(level.enemieskilled + level.enemyspawners.size + level.enemies.size < level.enemiestotal) {
        var_1 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_8A0E139B38A9B5EBD67A4B59653B502624E63E6253", (0, 0, 80), (0, 0, 0));

        while(!isDefined(var_1))
          wait 0.05;

        level.enemies[level.enemies.size] = var_1;
        var_1 thread enemy_monitor_death(level.enemyteam);
        var_1 thread enemy_soldier_think();
        var_1 thread node_cansee_child();
      }
    }

    wait 0.5;
  }
}

new_objective() {
  for(;;) {
    foreach(var_1 in level.enemies) {
      if(!isalive(var_1))
        level.enemies = scripts\engine\utility::array_remove(level.enemies, var_1);
    }

    wait 0.25;
  }
}

node_cansee_child() {
  while(isalive(self)) {
    self setgoalentity(level.player);
    self agentsetfavoriteenemy(level.player);
    wait 2.5;
  }
}

return_enemyspawners_in_zones(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in level.enemyspawners) {
      var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_5.origin);

      if(var_6 istouching(var_3))
        var_1 = scripts\engine\utility::array_add(var_1, var_5);

      var_6 delete();
    }
  }

  return var_1;
}

enemy_move_and_cover(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 agentsetfavoriteenemy(level.player);
  var_1 = self;
  var_2 = getnodearray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_2.size == 0) {
    var_3 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_3.size > 0) {
      var_4 = var_3[randomint(var_3.size)];
      var_0 setgoalpos(var_4.origin);

      if(isDefined(self.script_speed) && self.script_speed == -1) {
        return;
      }
      if(isDefined(self.speed) && self.speed == -1) {
        return;
      }
      var_5 = scripts\engine\utility::getclosest(var_4.origin, level.brjugg_dropondeath, 500);
      var_2[0] = var_5;
    } else
      var_2[0] = scripts\engine\utility::getclosest(var_0.origin, level.brjugg_dropondeath, 1000);
  }

  var_6 = var_2[randomint(var_2.size)];
  var_7 = 1;
  var_8 = 1;

  while(isalive(var_0)) {
    if(isDefined(var_6)) {
      var_0 setgoalnode(var_6);
      var_0 scripts\engine\utility::_id_143A7("_encstr_8B7205D9ED5958", "_encstr_886808E876776F2914DB", "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA", "_encstr_91010E0AEFFA2995BBA97FC82AF23328");
      var_8 = var_6 trialendgame();
    }

    if(isDefined(var_6))
      var_9 = var_0 enemy_already_near_node(var_6);
    else
      var_9 = 0;

    var_10 = var_0 non_detectable_killstreaks(var_6);

    if(var_7 && var_10 && !var_9) {
      wait 5;
      var_11 = var_0 iscovervalidagainstenemy(var_6);

      for(var_10 = var_0 non_detectable_killstreaks(var_6); var_11 && var_10; var_11 = var_0 iscovervalidagainstenemy(var_6))
        wait 1;
    }

    var_12 = var_0 findbestcoverlist(1);
    var_13 = [];
    var_13[0] = var_6;
    var_14 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_12, var_13, 1400, 0);

    foreach(var_5 in var_14) {
      var_9 = var_0 enemy_already_near_node(var_5);

      if(var_9 == 0)
        scripts\engine\utility::array_remove(var_14, var_5);
    }

    if(var_14.size > 0) {
      var_6 = scripts\engine\utility::random(var_14);
      var_7 = var_6 trialendgame();
      continue;
    }

    var_2 = getnodesinradius(var_0.origin, 512, 100, 100);
    var_6 = var_2[randomint(var_2.size)];
    var_7 = var_6 trialendgame();
    var_17 = var_0 getnearestnode();
    var_18 = var_0 findpath(var_17.origin, var_6.origin, 0, 1);

    if(var_18.size == 0 && var_8) {
      var_6 = var_17;
      var_7 = var_6 trialendgame();
    } else if(var_18.size > 14) {
      var_2 = getnodearray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_6 = var_2[randomint(var_2.size)];
      var_7 = var_6 trialendgame();
    }
  }
}

non_detectable_killstreaks(var_0) {
  var_1 = self.goalradius;
  var_2 = distance(var_0.origin, self.origin);
  return var_2 < var_1;
}

trialendgame() {
  return scripts\engine\utility::string_starts_with(self.type, "_encstr_B68E06D8F6B3CA27");
}

enemy_already_near_node(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\utility::array_remove(level.enemies, self);
  var_3 = sortbydistance(var_2, var_0.origin);

  if(isDefined(var_3[0]) && distance(var_3[0].origin, var_0.origin) < 50)
    var_1 = 1;

  return var_1;
}

enemy_soldier_think() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  self enabletraversals(0);
  self allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  self.goalradius = 64;
  self.grenadeammo = 0;
  self.baseaccuracy = 0.3;
  self agentsetfavoriteenemy(level.player);
  thread scripts\engine\utility::set_movement_speed(200);
  self.a.disablelongdeath = 1;
  thread enemy_accuracy_think();
  var_0 = 0;

  while(isalive(self)) {
    wait 0.05;
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    scripts\engine\utility::array_contains(level.players, var_2);
    var_11 = level.player getcurrentweapon();

    if(var_11.basename == "_encstr_BED80D7C9C59D95BF870DBDFA9F018") {
      self kill();
      var_12 = 1;
    } else
      var_12 = 0;

    level.player thread _tablethide::_id_13D4B(self, var_12, 0, 1);

    if(gettime() - var_0 > 800) {
      self playSound("_encstr_AD9915D14EA51663FACD991EEBCA73AC6B97D73858D2DC");
      var_0 = gettime();
    }
  }
}

enemy_accuracy_think() {
  self endon("_encstr_AD75063D571AE108");

  while(isalive(self)) {
    var_0 = distance(self.origin, level.player.origin);

    if(var_0 < 250)
      self.baseaccuracy = 0.8;
    else if(var_0 < 500)
      self.baseaccuracy = 0.5;
    else
      self.baseaccuracy = 0.3;

    wait 0.25;
  }
}

enemy_monitor_death(var_0) {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  switch (self.primaryweapon.classname) {
    case "_encstr_965306392D3336B2":
      var_1 = "_encstr_A5060F368537594E27C273ECACD74CB093";
      break;
    case "_encstr_BE0703A54C":
      var_1 = "_encstr_A5060F368537594E27C273ECACD74CB093";
      break;
    case "_encstr_BE1904DCDA9D":
      var_1 = "_encstr_A30D0BF0D3D00F8868421252CF";
      break;
    default:
      var_1 = "_encstr_B40101";
  }

  if(isDefined(level.nightmap) && level.nightmap == 1)
    var_2 = "_encstr_BE4C0295" + var_1;
  else
    var_2 = "_encstr_B40101";

  var_3 = createheadicon(self.weapon) + var_2;
  var_4 = self gettagorigin("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
  var_5 = self gettagorigin("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4);
  var_6.angles = var_5;
  var_6 linkTo(self, "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");

  if(isalive(self)) {
    self waittill("_encstr_AD75063D571AE108", var_11, var_7, var_8, var_9, var_10);

    if(isalive(level.player))
      var_11 = scripts\engine\utility::array_contains(level.players, var_7);
    else
      var_11 = 0;
  } else
    var_11 = 0;

  var_12 = var_0 == level.enemyteam;

  if(var_12 && var_11) {
    self playSound("_encstr_99B9164CDD7066F3E82332DB8EDDC3DFF853EFA41BE8EBAB");
    level.player thread _tablethide::_id_13D4B(self, 1, 0, 1);
  }

  level notify("_encstr_85980DA238454FA0F9DF7974F92B2F");
  level.enemieskilled++;
  level.enemiesactivenb--;
  level.enemies = scripts\engine\utility::array_removedead(level.enemies);

  if(istrue(level._id_13D3F)) {
    var_6 delete();
    return;
  }

  var_13 = spawn("_encstr_B2010820C5337B67C8CF" + var_3, var_6.origin);
  var_13.angles = var_6.angles;
  var_14 = int(weaponclipsize(var_13) / 1);
  var_15 = int(weaponclipsize(var_13) / 3);

  if(var_15 == 0)
    var_15 = 1;

  var_13 itemweaponsetammo(randomintrange(var_15, var_14), 0);
  var_6 delete();
}

enemy_chatter() {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  level.player endon("_encstr_AD75063D571AE108");
  var_0 = 2;
  var_1 = 5;
  var_2 = 1;
  var_3 = 4;
  var_4 = 1;
  var_5 = 3;
  level scripts\engine\utility::flag_wait("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");

  while(level.enemiesactivenb == 0)
    wait 0.05;

  for(;;) {
    var_6 = level.enemieskilled / level.enemiestotal;

    if(var_6 < 0.29) {
      var_7 = "_encstr_AC9005CF6275C0";
      var_8 = var_0;
      var_9 = var_1;
    } else if(var_6 < 0.79) {
      var_7 = "_encstr_9B9D061F7727B3F5";
      var_8 = var_2;
      var_9 = var_3;
    } else {
      var_7 = "_encstr_84A70683D6FED826";
      var_8 = var_4;
      var_9 = var_5;
    }

    wait(randomfloatrange(var_8, var_9));
    var_10 = scripts\engine\utility::get_array_of_closest(level.player.origin, level.enemies, undefined, 10, 1000);

    if(var_10.size > 0)
      var_11 = scripts\engine\utility::random_weight_sorted(var_10);
    else
      var_11 = scripts\engine\utility::getclosest(level.player.origin, level.enemies, 2500);

    if(isDefined(var_11) && isalive(var_11)) {
      var_12 = level.player gettagorigin("_encstr_A130084D2FDAD8AA8F62");
      var_13 = spawnsighttrace(var_11, var_12, var_11.origin);

      if(var_13)
        var_14 = "_encstr_9BEE1673BD7BF1E571B63B83783D02CF6DE07170764520FF";
      else
        var_14 = "_encstr_BE81185B18A0F15227263FB0180B2ABD48387F9F60193C1BBBBE";

      var_11 playsoundonmovingent(var_14);
      var_15 = lookupsoundlength(var_14) / 1000;

      if(isDefined(var_15) && var_15 > 0)
        wait(var_15);
      else
        wait 4;
    }

    if(scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19"))
      return;
  }
}

init_trap_room_debug() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0) {
    if(var_2.model == "_encstr_AB570E0B644AE9DB51CFD928A3691191" && isDefined(var_2.script_noteworthy)) {
      switch (var_2.script_noteworthy) {
        case "_encstr_8E2508511EE07BE6B246":
          var_3 = "_encstr_8E2508511EE07BE6B246";
          break;
        case "_encstr_B2030A81CF1D2F7AD9BB1620":
          var_3 = "_encstr_A7760B6710A315533959DF17AD";
          break;
        case "_encstr_95CE0B68F6D9594E9496B3863A":
          var_3 = "_encstr_86A30C90489C3F32B21DA9AF0178";
          break;
        case "_encstr_8DA30CA1F63B2B278627B7EA8DD0":
          var_3 = "_encstr_87AB0D4BD7B857DB077503DA9B8EEB";
          break;
        case "_encstr_B47C0B367565FAFBDA2B50E823":
          var_3 = "_encstr_AFFF0C6E8FE899DDE6174B068510";
          break;
        case "_encstr_8CA00B516F0D9D98BA8BA84DFB":
          var_3 = "_encstr_AF7A0CE15F5EDDE38968D2FF2050";
          break;
        default:
          var_3 = undefined;
          break;
      }

      if(isDefined(var_3)) {
        var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_2 thread _id_134E7(var_3);
      }
    }
  }
}

_id_134E7(var_0) {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  var_1 = spawncovernode(self.origin, self.angles, var_0, 16, self.targetname);

  while(!isDefined(var_1))
    waitframe();

  if(isDefined(self.radius))
    var_1.radius = self.radius;
  else
    var_1.radius = 24;
}

hud_init() {
  _tablethide::trial_ui_set_reward_tier(game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  level.player setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
}

hud_objectives() {
  _tablethide::trial_ui_set_objective_icon_index(0);
  _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_8E070F8556AF90931F7BA95BF275A12903", level.enemieskilled, 0);

  while(!isDefined(level.player))
    wait 0.05;

  _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\engine\utility::flag_wait("_encstr_8C5E103AE4D2B01BEBD8DB5737A323B7DD37");

  while(level.enemieskilled < level.enemiestotal) {
    _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
    _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_8E070F8556AF90931F7BA95BF275A12903", level.enemieskilled, 0);
    wait 0.05;
  }

  _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_8E070F8556AF90931F7BA95BF275A12903", level.enemieskilled, 0);
  level notify("_encstr_8F730B82D32028A1759BF7AFD5");
  level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
}

hud_timer() {
  level endon("_encstr_B4C8175B07032828F9CD314EB5D1A87B9B971DC39F1A0B780C");
  _tablethide::trial_ui_set_main_time(0);
  _tablethide::trial_ui_set_subtime(0);
  level scripts\engine\utility::flag_wait("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  var_0 = gettime();

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    var_1 = gettime() - var_0;
    level.totaltimeelapsed = int(var_1);
    _tablethide::trial_ui_set_main_time(level.totaltimeelapsed);
    _tablethide::trial_ui_set_subtime(level.totaltimeelapsed);
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    var_1 = gettime() - var_0;
    level.totaltimeelapsed = int(var_1);
    _tablethide::trial_ui_set_main_time(level.totaltimeelapsed);
    _tablethide::trial_ui_set_subtime(level.totaltimeelapsed);

    if(game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] <= 0 || var_1 < game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"]) {
      game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] = var_1;
      hud_besttime_update();
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B40108EEB2B00EEDB9C4"] = level.player.primaryweapons[0].basename;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B2010820C5337B67C815"] = level.player.primaryweapons[1].basename;
    }
  } else {
    _tablethide::trial_ui_set_main_time(0);
    _tablethide::trial_ui_set_subtime(0);
  }

  level scripts\engine\utility::flag_set("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
}

hud_reward_tiers_tracking() {
  self endon("_encstr_8F730B82D32028A1759BF7AFD5");
  self waittill("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");
  var_0 = [];
  var_0[0] = undefined;
  var_0[1] = level.trial["_encstr_816C069599555DA7"];
  var_0[2] = level.trial["_encstr_876C06B1FF0A66F2"];
  var_0[3] = level.trial["_encstr_966C066BF011B2F7"];

  for(var_1 = 3; var_1 >= 0; var_1--) {
    level.attempttier = var_1;
    _tablethide::trial_ui_set_reward_tier_preview(var_1);

    if(isDefined(var_0[var_1])) {
      while(level.totaltimeelapsed < var_0[var_1] - 5000)
        wait 0.05;

      for(var_2 = 5; var_2 > 0; var_2--) {
        level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
        wait 1;
      }

      level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");
    }
  }

  while(level.totaltimeelapsed < level._id_11B77)
    wait 0.05;

  level notify("_encstr_B4C8175B07032828F9CD314EB5D1A87B9B971DC39F1A0B780C");
  level scripts\engine\utility::flag_set("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
  _tablethide::trial_ui_set_main_time(level._id_11B77);
  _tablethide::trial_ui_set_subtime(level._id_11B77);
}

hud_fade_to_black() {
  var_0 = 0;

  while(var_0 < 1) {
    level.player setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_0);
    var_0 = var_0 + 0.05;
    wait 0.05;
  }
}

hud_attempt_over() {
  level scripts\engine\utility::flag_wait("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  setDvar("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 1.75);
  level.player freezecontrols(1);

  if(!scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    var_0 = game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"];

    if(level.attempttier > var_0) {
      game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"] = level.attempttier;
      _tablethide::trial_ui_set_reward_tier(level.attempttier);
    }

    if(level.attempttier >= 2) {
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_2]);
    } else if(level.attempttier >= 1) {
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"][var_2]);
    } else {
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"][var_2]);
    }

    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 0);
  } else if(scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.player clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
    level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");
    var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
    var_2 = randomint(var_1);
    level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_2]);
    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 1);
    thread hud_fade_to_black();
    wait 1;
  }

  scripts\engine\utility::array_call(level.enemies, ::despawnagent);
  setomnvar("_encstr_BE51134A8548B7C3DFD8F55DDD85E30EA7D1CB58E8", 1);
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 0);
  level scripts\engine\utility::flag_wait("_encstr_9A0C1AE8D6341384E94B6F83B1EB9FE9F8D0C14552C3281BE66D6998");
  _tablethide::_id_13D89(1);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_8E070F8556AF90931F7BA95BF275A12903", level.enemieskilled, 0);
  _tablethide::trial_ui_open_results_screen();
  level._id_13D60 = 1;
  _tablethide::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  var_3 = game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"];

  if(var_3 > 0) {
    level notify("_encstr_8F3F0DCF1F807A39380175B16B930B");
    level notify("_encstr_92DF0B127AF74B41D63488E317");
    game["_encstr_A1AD062E09D98338"] = "_encstr_877508C1D8C22F2DDC3B";
    _tablethide::_id_13D5E();
  } else {}
}

hud_besttime_update() {
  var_0 = game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"];
  var_1 = game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"];
  _tablethide::trial_ui_set_best_time(var_0);
  _tablethide::trial_ui_set_reward_tier(var_1);
}

_id_1385C() {
  var_0 = getEnt("_encstr_AC711170ABB6157B5F6EB4A06CEB2DF79F02F0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  level scripts\engine\utility::flag_set("_encstr_BA57193AC95A2C63EBDCD116273ABE4FDEB995AF2BDCA359C92B32");
}

check_script_noteworthy(var_0, var_1) {
  var_2 = int(var_0.script_noteworthy);
  var_3 = int(var_1.script_noteworthy);
  return var_2 < var_3;
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_8D4A0FADA1D736C6560B39BE5A9B3A4EB7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_85AE15EC38C953EA95E3D36FDBC8B39AA02662B470180C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_95BE14B60DFAC6C6AC8527EB6E4716E403F533B02DB1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962A15A3272DC2C6BECA9B46EB1D4B59397DC0F5C2B1E8"] = "_encstr_BEFB1577035116C8D5EEF32E12ACE8D6FF77D1E3BF0B6B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_835D0FF84CAF4A91923202B7539527BBCB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_A55D0FA872213F70976936B853FB19A5C2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_865D0FBA48B7DEB3514782B7665B4F22D7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_811A0F6DEC704F210FC75B4EB3DA535D13";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE180CD8D8951693AF37E8B0933A"] = "_encstr_8A5D0FB82447ABB84FFFADF14A2D46387B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84060DA26B7DFF10D672C72F9351D9"] = "_encstr_B4CA1057237136E8F5CED34E72DDC8F6EA4B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5C110E1E14F62DB61375A3708C130732479"] = "_encstr_9AA612B6A1D76CC6AC85937DECF6DE19AD96D8B1";
  thread dialog_killstreak_acknowledgement();
  thread dialog_push_forward();
  scripts\engine\utility::flag_wait("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_BE180CD8D8951693AF37E8B0933A");
}

dialog_push_forward() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  var_0 = 0;
  var_1 = 0;
  scripts\engine\utility::flag_wait("_encstr_A5C10F03EE4C6218611FEB2BB80B707D2F");

  while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
    wait 1;
    var_2 = level.enemieskilled != var_1;

    if(var_2 == 0 && level.enemies.size > 0) {
      var_3 = sortbydistance(level.enemies, level.player.origin);

      if(distance2d(var_3[0].origin, level.player.origin) > 900)
        var_0++;
    } else {
      var_0 = 0;
      var_1 = level.enemieskilled;
    }

    if(var_0 > 4) {
      var_0 = 0;
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_84060DA26B7DFF10D672C72F9351D9");
      wait 5;
    }
  }
}

dialog_killstreak_acknowledgement() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 8000;
  level waittill("_encstr_85980DA238454FA0F9DF7974F92B2F");
  var_0++;
  var_1 = gettime();

  for(;;) {
    level waittill("_encstr_85980DA238454FA0F9DF7974F92B2F");
    var_4 = gettime();
    var_5 = var_4 - var_1;

    if(var_5 < 2600) {
      if(var_0 < 3)
        var_0++;
    } else if(var_5 < 4000) {} else if(var_0 > 0)
      var_0--;

    if(var_0 > 2 && var_4 > var_2) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A5C110E1E14F62DB61375A3708C130732479");
      var_2 = var_4 + var_3;
      var_0 = var_0 - 2;
    }

    var_1 = var_4;
  }
}

_id_12A8E() {
  for(;;) {
    while(isalive(level.player)) {
      _id_12A91(level.player);
      wait 0.2;
    }

    waitframe();
  }
}

_id_12A90(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1]))
    var_2.progress[var_1] = 0;

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(var_4 < var_5)
    var_2.progress[var_1] = var_2.progress[var_1] + 0.025;
  else
    var_2.progress[var_1] = 0;

  if(var_2.progress[var_1] >= 1) {
    var_0 scripts\mp\equipment::incrementequipmentslotammo(var_1, 1);
    var_2.progress[var_1] = 0;
    var_2.recharged[var_1] = 1;
  }
}

_id_12A91(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  _id_12A90(var_0, "_encstr_BA7F0830B3A7859B60B0");
  _id_12A90(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  _id_12A92(var_0);
}

_id_12A92(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["_encstr_BA7F0830B3A7859B60B0"]))
      var_1 = var_4.progress["_encstr_BA7F0830B3A7859B60B0"];

    if(isDefined(var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"]))
      var_2 = var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"];

    foreach(var_7, var_6 in var_4.recharged) {
      if(var_7 == "_encstr_BA7F0830B3A7859B60B0") {
        var_3 = var_3 + 1;
        var_0 playlocalsound("_encstr_B229132D8BA1C2F7DEE3824AE8202BFF1011B18C17");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }

      if(var_7 == "_encstr_AC8F0AE74163F85AAA380AD8") {
        var_3 = var_3 + 2;
        var_0 playlocalsound("_encstr_871E14BB5357CB959B58BF8748F65C22877504B6CF49");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }
    }
  }

  var_0 setclientomnvar("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", var_1);
  var_0 setclientomnvar("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", var_2);
  var_0 setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", var_3);
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D31;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B40108EEB2B00EEDB9C4"] = "_encstr_811804E565FC";
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B2010820C5337B67C815"] = "_encstr_811804E565FC";
  }
}

_id_13D31() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_AF8F13DB2C27D846120F49272BFA0E608FC3C05057");
  var_3 = "_encstr_B40101" + game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B40108EEB2B00EEDB9C4"];
  var_4 = "_encstr_B40101" + game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B2010820C5337B67C815"];
  level.player dlog_recordplayerevent("_encstr_922A2011B40DE8605FA31178EBDFAD182411B9EF23F5703F438A4B0161F769687E7A", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_84EF055338A18F", var_2, "_encstr_B40108EEB2B00EEDB9C4", var_3, "_encstr_B2010820C5337B67C815", var_4]);
}

chopperoccupied() {
  var_0 = getentarrayinradius("_encstr_BA8A0B26C2394ECA1BFAB1B71B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", self.origin, 250);
  self disconnectPaths();
  self setCanDamage(1);
  self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5);

  if(var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")
    wait 0.15;

  self radiusdamage(self.origin, 250, 250, 100, level.player, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");

  if(isDefined(self.script_noteworthy) && !istrue(level.started)) {
    if(self.script_noteworthy == "_encstr_93AD0E892DCEEB56F03836ED9B96ED37") {
      level notify("_encstr_999A060533C0FDD2");
      level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_encstr_9B77144FFB187A45E8F68D5368D0AF72E00D077F45B5");
      var_6 = 6;
      var_7 = 0.1;
      var_8 = (1645.5, -21164, -2543.5);
      var_9 = vectorNormalize((var_8[0], var_8[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
      var_10 = var_8 + var_9 * 15000;
      var_10 = var_10 + (0, 0, 30000) + var_9 * 5000;
      var_11 = spawnStruct();
      var_11.streakname = "_encstr_A1B90BB32380C2D0A1587087E7";
      var_11.nukegoalpoint = var_8;
      level.nuke_clockobject = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_10 + (0, 0, 100));
      playsoundatpos(var_10, "_encstr_85D415A14327A0B86B433B67E12BFF6BAE045765E5D60B");
      level thread nuke_launchmissile(undefined, undefined, (1645.5, -21164, -2543.5), var_8, var_7);
      wait(var_7);
      level thread _calloutmarkerping_handleluinotify_acknowledged::setnuketimescalefactor();
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_explosion(undefined, var_11);
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_earthquake(undefined, var_11);
      visionsetnaked("_encstr_AC711298BB343B1E676CB03E7993C6F55D42F830", 0.05);
      setDvar("_encstr_87642439EBD60BE8B2934B85B190B1DEDBB6212A356C39A5E0D19AB06E47AC4E51372CC4D8AC", 0);
      wait 0.5;
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_fadeflashvision(1, 2);
      wait 3.5;
      playFX(scripts\engine\utility::getfx("_encstr_AD331373AB6D56D7C9DE36B14BE6D9AF23B2C28ED0"), level.player.origin - (0, 0, 64), anglesToForward(self.angles) * -1, undefined, level.player);
      wait 1;
      _calloutmarkerping_handleluinotify_acknowledged::_id_11EF4();
      wait 2;
      map_restart(1);
    }
  } else
    playFX(scripts\engine\utility::getfx(_id_129F5()), self.origin);

  foreach(var_13 in var_0) {
    if(isDefined(var_13))
      var_13 delete();
  }

  playsoundatpos(self.origin, "_encstr_925016C83747D70EC9BD0E16E656FA95F038D8F5851D6BF6");
  level.player earthquakeforplayer(0.15, 0.25, self.origin, 1000);
  playFX(scripts\engine\utility::getfx("_encstr_87C513C416C993CA63D79963C2B6957DDCD62C63D8"), self.origin);
  playFX(scripts\engine\utility::getfx("_encstr_88740C2A8BD8D2C761B602FA3BCD"), self.origin);
  self hide();
  wait 5;
  self delete();
}

nuke_launchmissile(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_6 = var_4;
  var_7 = "_encstr_A29408E6D5D6CAAF5B1C";

  if(isDefined(var_5))
    var_7 = var_5;

  var_8 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));
  var_9 = (var_3 - 0.5 * var_8 * squared(var_4) - var_2) / var_4;
  level.nuke_missile = magicgrenademanual(var_7, var_2, var_9, var_4);
  level.nuke_missile setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_AB0703DBB9", 0);
}

_id_129F5() {
  var_0 = randomint(2);

  switch (var_0) {
    case 0:
      return "_encstr_961C123E562BEDA96C87D82823B42027227DA01F";
    case 1:
      return "_encstr_821C121E760BCD894C6738C8C394ED07421D80BE";
    case 2:
      return "_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9";
  }
}

lb_mg_wood_surf_dmg_scalar() {
  self disconnectPaths();
  var_0 = getnodesinradius(self.origin, 256, 0);

  foreach(var_2 in var_0)
  var_2 disconnectnode();

  self setCanDamage(1);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_4, var_5, var_6, var_7, var_8);

    if(var_8 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_8 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_8 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_8 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") {
      break;
    }

    waitframe();
  }

  self radiusdamage(self.origin, 250, 250, 10, level.player);
  playFX(scripts\engine\utility::getfx("_encstr_83E317ECCA0DA5368DCAEB26B7DA26BEB2870E637B6EA5F6DC"), self.origin);
  playsoundatpos(self.origin, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
  level.player earthquakeforplayer(0.45, 0.25, self.origin, 1000);
  playFX(scripts\engine\utility::getfx("_encstr_9A561345CDBCE82E2BC26629FBB351209229EFFD22"), self.origin);
  playFX(scripts\engine\utility::getfx("_encstr_B1190D56EB607CA71999C922606EF7"), self.origin);
  self setModel("_encstr_9B831FB3CA0D83BE1B2DECEBB1CD23AFA1A5E68CA558EB6EE885A3D2B1FA46373A");
  waitframe();
  self hidepart("_encstr_810C14D9911741836420D2274C2F67DDE9C9E0403159", "_encstr_9B831FB3CA0D83BE1B2DECEBB1CD23AFA1A5E68CA558EB6EE885A3D2B1FA46373A");
  self hidepart("_encstr_B85315B9D55C7F17718F4A7FA5A1ED737D8E51107D83EB", "_encstr_9B831FB3CA0D83BE1B2DECEBB1CD23AFA1A5E68CA558EB6EE885A3D2B1FA46373A");
}

brplayerhudoutlineupdatefromnotify() {
  self setscriptablepartstate("_encstr_83FC16A06FA4E829AA2A1308C64253902FAB78D8E34F612F", "_encstr_85EA0C2DDF512E8BA12561686D8C");
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 35, 44), (0, 0, 0));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_0 setHintString(&"_encstr_877B1B286827614037D53101797048344120E265A74C69193FA9371FC8");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(120);
  var_0 setuserange(72);
  var_0 setusefov(120);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0.headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.headicon, "_encstr_AD6E13B11CF51B27C2E895AF4BC6DB37F585D6B5BD");
  setheadiconmaxdistance(var_0.headicon, 800);
  addclienttoheadiconmask(var_0.headicon, 5);
  var_0 makeusable();
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1 = level.player getweaponslistall();

  foreach(var_3 in var_1)
  level.player setweaponammostock(var_3, weaponclipsize(var_3) * 2 + level.player getweaponammostock(var_3));

  level.player scripts\mp\damagefeedback::hudicontype("_encstr_97DB08C666DF7205C008");
  level.player playlocalsound("_encstr_AFC214672FA349CB18A3BA45DB28DF52D0A937EFCFA5");
  var_0 makeunusable();
  setheadiconteam(var_0.headicon);
}