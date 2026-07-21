/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_trench\mp_m_trench.gsc
***********************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _encstr_BEA335A8BF422DC963C280B91A0E2BC9A807C2C05BD7D8DF0BAAAD303652E730F01F28D9D3921145425488C74AFA47794B5BE0EAF74B69::main();
  _encstr_BE6C346EB193D207A3375EDA83F26B580EB9BCD6E0EB5BBE8E2756733634BCCEB2DCE56BC1BEB57D1DC995B9B1D07D2CE43A8BECDC1B::main();
  _encstr_823E2FC39A63132083EBCF53F0BD6BEF9373D088137F5921DBC2535D0B544AA13B2910763B93856036A01FB528ADC0762F::main();
  _encstr_93BD357B2176F74AF887471D99FAD51F9FDB3602EB58BFC990AD051657E80D57C7F6EAA9F3A6577D10E107EC7BE8E4FBE348C206F9FEF7::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_9717186CB76B1C85DC6ED7D68538EBB50EBEADD71DE42BB91B0D", "_encstr_8AEE22367BC836859B3ACA39EBD87BDA3885379BEBB5C283FAAD0EF5ADAF3A2756DC6C1A");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((1952, 0, -192), 800, 0, 400);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread onplayerconnect();
  thread _id_129F4();
  thread teamrefundplunder();
  level.max_respawn = 1;
  level._id_12328 = 1;
  thread vehicles_spawned();
  thread _id_13241();
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread flagender();
  }
}

_id_1313F(var_0, var_1) {
  switch (var_1) {
    case 1:
      var_2 = getEnt("_encstr_A2BA0527EAB698", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 2:
      var_2 = getEnt("_encstr_B1BA059DF7EA9F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 3:
      var_2 = getEnt("_encstr_BABA059CD55B99", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 4:
      var_2 = getEnt("_encstr_B2BA05D9FBF5D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 5:
      var_2 = getEnt("_encstr_A6BA05D0BBF1D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 6:
      var_2 = getEnt("_encstr_B6BA0584133DE2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 7:
      var_2 = getEnt("_encstr_B4BA05C95DDA9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 8:
      var_2 = getEnt("_encstr_ADBA05C9DDF818", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 9:
      var_2 = getEnt("_encstr_85BA0588C0B328", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    default:
      break;
  }
}

_id_13D1D() {
  wait 5;
  var_0 = getEnt("_encstr_8AF01212AECDD695390AB0A386098D7B1BDA2B27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 hide();
  var_0 connectpaths();
  _id_12121(level.door);
  level.monitor_player_pinging = getEntArray("_encstr_B8970DB263CACEC2E8DB3922F67B4E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in level.monitor_player_pinging)
  thread _id_1323D(var_2);

  var_4 = scripts\engine\utility::getStruct("_encstr_8CCB0AB823375A07CBBC76B4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12324 = easepower("_encstr_91DC1AAD8583A1B49B8EEB8343EDB9CAFA5BC1D7ADAFD12795E61BD0", var_4.origin);
  waitframe();
  scripts\engine\scriptable::_id_12F5B("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", ::_id_11AE3);

  for(;;) {
    level._id_12329 = 1;
    thread _id_1232B(var_4);
    level waittill("_encstr_B1920E14A1BDE65905B9E6DD59279591");
    level._id_1232C stoploopsound("_encstr_BE0212D383E0A6F28B07730B7FA0DADFE048CD9F");
    level._id_1232C delete();
    playsoundatpos(level._id_12324.origin, "_encstr_AF75141C3E59359A83A973EB47F859D798C4EB0BD502");
    wait 0.5;
    playsoundatpos(level._id_12324.origin, "_encstr_99432C98E81FF136180E5A0B58B831E2A32D70F11B0123BB6A18DA3369F3CCF7C0CF59538A0B9F28A308BDE1A2A7");
    wait 4.9;
    playsoundatpos(level._id_12324.origin, "_encstr_9AD014B3967B52DBB0390B73A0289509D9A7BDEFFDB9");
    wait 0.5;
    vehicle_isneutraltoteam();
    wait 5;
    level._id_12324 setscriptablepartstate("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", "_encstr_AB0703DBB9");
  }
}

flagender() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEnt("_encstr_A2A511662DE330ABFA5808D0629353EBE781E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.tracking_obit = 0;

  if(isDefined(var_0)) {
    for(;;) {
      if(self istouching(var_0)) {
        if(!istrue(self.tracking_obit)) {
          self.tracking_obit = 1;
          self.radarstrength = level._id_13EDE;
          self.isradarblocked = 1;
          self.hasradar = 0;
          self.radarshowenemydirection = 0;
          self.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
        }
      } else if(istrue(self.tracking_obit)) {
        self.tracking_obit = undefined;
        level notify("_encstr_8B540B6DB903360BFAAAF85852");
      }

      waitframe();
    }
  }
}

_id_11AE3(var_0, var_1, var_2, var_3, var_4) {
  level thread allowassassinationdamage(var_0, var_1, var_2, var_3, var_4);
}

allowassassinationdamage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    var_0 setscriptablepartstate("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", "_encstr_BA19049F4B2D");
    level notify("_encstr_B1920E14A1BDE65905B9E6DD59279591");
    level._id_12329 = 0;
  }
}

vehicles_spawned() {
  wait 2;
  level.vehicleoccupants = getEntArray("_encstr_8A3407E22DAF47934F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.vehicleoccupants)
  thread vehiclespawn_armoredtruck(var_1);

  level.helihint_gotopad[0] = randomintrange(1, 10);
  level.helihint_deposit[0] = scripts\engine\utility::getStruct("_encstr_8C8D06F727C5A2C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_1313F(level.helihint_deposit[0], level.helihint_gotopad[0]);

  for(level.helihint_gotopad[1] = level.helihint_gotopad[0]; level.helihint_gotopad[1] == level.helihint_gotopad[0]; level.helihint_gotopad[1] = randomintrange(1, 10)) {}

  level.helihint_deposit[1] = scripts\engine\utility::getStruct("_encstr_A98D06491F4ACA12", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_1313F(level.helihint_deposit[1], level.helihint_gotopad[1]);

  for(level.helihint_gotopad[2] = level.helihint_gotopad[0]; level.helihint_gotopad[2] == level.helihint_gotopad[0] || level.helihint_gotopad[2] == level.helihint_gotopad[1]; level.helihint_gotopad[2] = randomintrange(1, 10)) {}

  level.helihint_deposit[2] = scripts\engine\utility::getStruct("_encstr_BA8D0634DE32AC66", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_1313F(level.helihint_deposit[2], level.helihint_gotopad[2]);

  for(level.helihint_gotopad[3] = level.helihint_gotopad[0]; level.helihint_gotopad[3] == level.helihint_gotopad[0] || level.helihint_gotopad[3] == level.helihint_gotopad[1] || level.helihint_gotopad[3] == level.helihint_gotopad[2]; level.helihint_gotopad[3] = randomintrange(1, 10)) {}

  level.helihint_deposit[3] = scripts\engine\utility::getStruct("_encstr_868D06399F44B171", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_1313F(level.helihint_deposit[3], level.helihint_gotopad[3]);

  for(level.helihint_gotopad[4] = level.helihint_gotopad[0]; level.helihint_gotopad[4] == level.helihint_gotopad[0] || level.helihint_gotopad[4] == level.helihint_gotopad[1] || level.helihint_gotopad[4] == level.helihint_gotopad[2] || level.helihint_gotopad[4] == level.helihint_gotopad[3]; level.helihint_gotopad[4] = randomintrange(1, 10)) {}

  level.helihint_deposit[4] = scripts\engine\utility::getStruct("_encstr_A58D062822C9E586", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_1313F(level.helihint_deposit[4], level.helihint_gotopad[4]);
  level.insertingarmorplate = 0;
  var_3 = getEnt("_encstr_8B01089DC0C1A08979FA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread player_near_obit(var_3);
  var_4 = getEnt("_encstr_8AF01212AECDD695390AB0A386098D7B1BDA2B27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 disconnectPaths();

  while(level.max_respawn) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    killfxontag(scripts\engine\utility::getfx("_encstr_8DAE10453956CD6CA1A8CD3A2B39D0DB8CCA"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level.max_respawn = 0;
    var_4 hide();
    waitframe();
    var_4 connectpaths();
    playsoundatpos(var_3.origin, "_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51");
    killfxontag(scripts\engine\utility::getfx("_encstr_8DAE10453956CD6CA1A8CD3A2B39D0DB8CCA"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 2;
    thread _id_12121(level.door);
  }

  wait 1;
  level.helihint_gotopad[0] = 5;
  level.helihint_gotopad[1] = 3;
  level.helihint_gotopad[2] = 1;
  level.helihint_gotopad[3] = 2;
  level.helihint_gotopad[4] = 5;
  level.insertingarmorplate = 0;
  level.monitor_player_pinging = getEntArray("_encstr_B8970DB263CACEC2E8DB3922F67B4E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in level.monitor_player_pinging)
  thread _id_1323D(var_6);

  while(level._id_12328) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    level._id_12328 = 0;
    level._id_12329 = 1;
    playsoundatpos(var_3.origin, "_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51");
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BE9E12DD6AA22D8180EFA04003A5D941A8554DDD"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level._id_12327 = scripts\engine\utility::getStruct("_encstr_8CCB0AB823375A07CBBC76B4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level._id_12324 = easepower("_encstr_91DC1AAD8583A1B49B8EEB8343EDB9CAFA5BC1D7ADAFD12795E61BD0", level._id_12327.origin);
    waitframe();
    scripts\engine\scriptable::_id_12F5B("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", ::_id_11AE3);
    thread _id_1232B(level._id_12327);
    level waittill("_encstr_B1920E14A1BDE65905B9E6DD59279591");
    level._id_1232C stoploopsound("_encstr_BE0212D383E0A6F28B07730B7FA0DADFE048CD9F");
    level._id_1232C delete();
    playsoundatpos(level._id_12327.origin, "_encstr_AF75141C3E59359A83A973EB47F859D798C4EB0BD502");
    wait 0.5;
    playsoundatpos(level._id_12327.origin, "_encstr_99432C98E81FF136180E5A0B58B831E2A32D70F11B0123BB6A18DA3369F3CCF7C0CF59538A0B9F28A308BDE1A2A7");
    wait 4.9;
    playsoundatpos(level._id_12327.origin, "_encstr_9AD014B3967B52DBB0390B73A0289509D9A7BDEFFDB9");
    wait 0.5;
    vehicle_isneutraltoteam();
  }
}

_id_1232B(var_0) {
  level._id_1232C = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  wait 0.05;
  level._id_1232C playLoopSound("_encstr_BE0212D383E0A6F28B07730B7FA0DADFE048CD9F");
}

vehicle_isneutraltoteam() {
  level.monitor_player_pinging[0] playLoopSound("_encstr_AB9A104886EF08BB68CFD1C8A05D081FD1B1");
  scripts\engine\utility::exploder("_encstr_8CEA0C31BDCFF07373D213592A73");
  wait 3;
  level.monitor_player_pinging[1] playSound("_encstr_A133124DA6FA40CACBC1BBE090A631A3A5A76BAB");

  foreach(var_1 in level.monitor_player_pinging)
  thread _id_12124(var_1);

  level.monitor_player_pinging[1] playLoopSound("_encstr_83AC0F55EE3DCA734307BC05AAC8F949DB");
  wait 2;
  level.monitor_player_pinging[1] playSound("_encstr_BA811110B397459FB039D180AF887987DBDFD8");
  level.monitor_player_pinging[1] stoploopsound("_encstr_83AC0F55EE3DCA734307BC05AAC8F949DB");
  var_3 = scripts\engine\utility::getStructArray("_encstr_873708BE89285268ADCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_3[0].origin);
  var_4 playSound("_encstr_8FD816E8E012AA570BB610CDBA0847B073654DFA4075FB1E");
  wait 1;
  scripts\engine\utility::exploder("_encstr_95AD085B5AB9D2ECABE6");
  var_4 playLoopSound("_encstr_85D718BF62B23731494A29558147FF7B68066368E75F9070809A");
  level.clear_my_munition_slot = 0;
  thread spawner_recently_used();
  wait 10;
  level.monitor_player_pinging[0] stoploopsound("_encstr_AB9A104886EF08BB68CFD1C8A05D081FD1B1");
  level.clear_my_munition_slot = 1;
  scripts\engine\utility::stop_exploder("_encstr_95AD085B5AB9D2ECABE6");
  var_4 playSound("_encstr_878D18372357E3BFF899D59D5149DB9B3B5DE3DFBF08D9768081");
  var_4 stoploopsound("_encstr_85D718BF62B23731494A29558147FF7B68066368E75F9070809A");
  wait 1;
  scripts\engine\utility::stop_exploder("_encstr_8CEA0C31BDCFF07373D213592A73");
  scripts\engine\utility::exploder("_encstr_AC450B1D7F62E932478320086B");
  playsoundatpos((2604.05, -0.801273, -153), "_encstr_872611A3C310924588FE5718F3099CFB7F1D7F");
  var_4 stopsounds();
  var_4 delete();
  wait 0.5;

  foreach(var_1 in level.monitor_player_pinging)
  thread heli_killed(var_1);

  level.monitor_player_pinging[0] playSound("_encstr_A133124DA6FA40CACBC1BBE090A631A3A5A76BAB");
  level.monitor_player_pinging[1] playSound("_encstr_BA811110B397459FB039D180AF887987DBDFD8");
}

spawner_recently_used() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_873708BE89285268ADCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_852812315DB9DAB24E09AB4ED1A2E45A3BCE5693", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!level.clear_my_munition_slot) {
    magicbullet("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB", var_0[0].origin, (0, randomintrange(-1000, 1000), randomintrange(-300, 100)));
    wait 0.1;
    magicbullet("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB", var_0[1].origin, (0, randomintrange(-1000, 1000), randomintrange(-300, 100)));
    wait 0.1;

    if(randomint(2)) {
      foreach(var_3 in level.players) {
        if(var_3 istouching(var_1))
          var_3 dodamage(4, var_0[0].origin, var_3, var_3, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9", undefined, "_encstr_952B0C65857BBFB80F9FC0B8A75A");
      }
    }
  }
}

player_near_obit(var_0) {
  wait 10;

  while(level.max_respawn) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_8DAE10453956CD6CA1A8CD3A2B39D0DB8CCA"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.5;
    killfxontag(scripts\engine\utility::getfx("_encstr_8DAE10453956CD6CA1A8CD3A2B39D0DB8CCA"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    waitframe();
    killfxontag(scripts\engine\utility::getfx("_encstr_8DAE10453956CD6CA1A8CD3A2B39D0DB8CCA"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.5;
  }
}

vehiclespawn_armoredtruck(var_0) {
  var_0 setCanDamage(1);

  while(level.max_respawn || level._id_12328) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(level.audio_player_delete_mud_loop == int(var_0.script_noteworthy)) {
      level.insertingarmorplate++;
      level notify("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    if(level.helihint_gotopad[0] == int(var_0.script_noteworthy)) {
      level.insertingarmorplate = 1;
      level notify("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    level.insertingarmorplate = 0;
    level notify("_encstr_9BB30F1ABDC85669B29728C995379B9519");
  }
}

_id_1323D(var_0) {
  var_0.originalpos = var_0.origin;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0._id_1212B = var_1.origin;
}

_id_12124(var_0) {
  var_0 moveTo(var_0._id_1212B, 2, 1.5, 0);
}

heli_killed(var_0) {
  var_0 moveTo(var_0.originalpos, 0.5, 0.25, 0);
}

teamrefundplunder() {
  thread teamrevivefiresalediscount();
  thread teamsassigned();
}

#using_animtree("_encstr_87610FB0CD966BC23A2B237DC19CBDE0DC");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

teamrevivefiresalediscount() {
  level.scr_animtree["_encstr_B6B20C25954580651B3949504263"] = #animtree;
  level.scr_anim["_encstr_B6B20C25954580651B3949504263"]["_encstr_8A900A9CA7C8F0994A2875C8"] = % _encstr_B10B1CCDAF27FBC5EB88370358A087C21BC8D4471689A20733691703F038;
  level.scr_animname["_encstr_B6B20C25954580651B3949504263"]["_encstr_8A900A9CA7C8F0994A2875C8"] = "_encstr_B10B1CCDAF27FBC5EB88370358A087C21BC8D4471689A20733691703F038";
  level.scr_anim["_encstr_B6B20C25954580651B3949504263"]["_encstr_82FD1152F8A0D3C958C95556FFC80B8B52F0DA"] = % _encstr_9B742387D1804B4DB0914E956BA0AFC26D15173F7DB5820FD8DEC51A41A0E79BC595AB93CB;
  level.scr_animname["_encstr_B6B20C25954580651B3949504263"]["_encstr_82FD1152F8A0D3C958C95556FFC80B8B52F0DA"] = "_encstr_9B742387D1804B4DB0914E956BA0AFC26D15173F7DB5820FD8DEC51A41A0E79BC595AB93CB";
}

teamsassigned() {
  level.door = getEnt("_encstr_B6B20C25954580651B3949504263", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = getEntArray(level.door.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "_encstr_877D10DB511F685D317120503271DE1442CB") {
      level.door.heli_anim = var_2;
      continue;
    }

    if(var_2.script_noteworthy == "_encstr_994C0FEA2BE53B5F91A07F7A50995B8431")
      level.door.heli_approach_instruct = var_2;
  }

  level.door.animname = "_encstr_B6B20C25954580651B3949504263";
  level.door scripts\common\anim::setanimtree();
}

_id_12121(var_0) {
  var_1 = "_encstr_8A900A9CA7C8F0994A2875C8";
  var_0 thread scripts\common\anim::anim_single_solo(var_0, var_1);
  var_0 playSound("_encstr_85A6179636AF326DD078BFFBC1C93FAA8DD85D8A156539D0D3");
  var_2 = getanimlength(level.scr_anim["_encstr_B6B20C25954580651B3949504263"][var_1]);
  wait 8;
  var_0.heli_anim rotateTo(var_0.heli_anim.angles - (0, 90, 0), 5, 0.2, 0.8);
  var_0.heli_approach_instruct rotateTo(var_0.heli_approach_instruct.angles + (0, 90, 0), 5, 0.2, 0.8);
  var_0 playSound("_encstr_B2A617E24696F32BAD30327BA981E58F6BB867885518BFA2FD");
  wait(var_2 - 8);
  var_0.heli_anim connectpaths();
  var_0.heli_approach_instruct connectpaths();
}

_id_129F4() {
  wait 3;
  level.onupdatefunc = scripts\engine\utility::getStructArray("_encstr_8CAD0BFFA8631C82D9C8DC15AD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = 0;

  foreach(var_2 in level.onupdatefunc) {
    level.open_doors[var_0] = scripts\engine\utility::spawn_tag_origin();
    level.open_doors[var_0].origin = var_2.origin;
    level.open_doors[var_0] show();
    var_0++;
  }

  for(;;) {
    wait(randomintrange(5, 17));

    if(var_0 > 0) {
      var_4 = randomintrange(0, var_0);
      level.open_doors[var_4] playSound("_encstr_8E8A19EBDD85D25368CE45CD43A099CB701B237379203B1A58F0FA");
      playFXOnTag(scripts\engine\utility::getfx("_encstr_8DAF12453956CD6CA1A80F3863B7DC5AEDDC1961"), level.open_doors[var_4], "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }
  }
}

_id_13241() {
  var_0 = getEntArray("_encstr_851804A69B38", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  thread pelletdmgpassed(var_2, randomfloatrange(0.75, 1.25));
}

pelletdmgpassed(var_0, var_1) {
  for(;;) {
    var_0 rotateroll(360, var_1, 0, 0);
    wait(var_1);
  }
}