/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_petrograd\mp_petrograd.gsc
*************************************************/

main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  _encstr_8CD1376EB1E4B41C1D6ECBD683796BC21CDCBC5BC1F50E59479CBD3B93858CF26B1CFA0E9547937B9DE41691FA8327CAC6161B345971D99BB1::main();
  _encstr_8220361FB0AB6993E34EF652D85E8D1911C3FDC33F31B180CB33F817A3789537371BB51D83CBD6F3CDEB3B38F9B3A1C9B9115B0305BF482F::main();
  _encstr_B6653197BF0B73876CAFE8DF278ECA01B83F263B32918BF8931A60E95B37EBD0B018AFF07503462A37CD4037418A7AC87C7B36::main();
  _encstr_A10737BBE1B6378A384787DD59BA955FDF9BF6C22B988B07D06DCFDF35E01F9E8953899B11E5CBFD7095F9A4577064F7A34B62C2B990273238::main();
  scripts\cp_mp\utility\game_utility::_id_12B2C();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_B606199A7A28AAAA803E1FAD7FE91F97A17982654B23DD2F4E8BFB", "_encstr_81592396FF19671B127BAF0347F380D84BE6E30BD0B1E1FA09C94BB9A0F7F3A3F729FBC087");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_8A65065739262C37";
  level battle_tracks_vehicleoccupancyenter();
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  thread set_lighting_dvars();
  thread hide_multiple_brush();
  thread scripts\mp\destructible::rockable_cars_init();
  level thread managegate();
  level thread player_exfil_struct();
  level thread _id_121F5();
  scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  wait 7.5;
  scripts\engine\utility::array_thread(getscriptablearray("_encstr_A6AB2FC2970AFF575337EA5B2AC7E3387AC199BFF9832F8452795F30308DA5B93EBF085E6B21474D0B58179815783A30D7", "_encstr_AC110A7F14873B5B3D073009"), ::_id_141BD);
  scripts\engine\utility::array_thread(getscriptablearray("_encstr_A33F29DEBE43B3532CD75820AF6FEBD38AF0406E94DB1718EEFBA9A08F61600F410ACDEEE1132F40C10F70", "_encstr_AC110A7F14873B5B3D073009"), ::_id_141BD);
}

hide_multiple_brush() {
  var_0 = getEntArray("_encstr_A31212CAF72842318EB3C139F81B31C12693A768", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 delete();
}

set_lighting_dvars() {
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_846619C2B76BE35FC67FE9F90BD89B0797F07225731F6381C9E8DF", 1);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.425);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 4);
  setDvar("_encstr_A5AD0AB9C789FB64295D839C", 2);
}

_id_141BD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(randomfloat(2));

  if(self getscriptablehaspart("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93")) {
    if(self getscriptableparthasstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_992A0A97D753C508DF5D4159"))
      self setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_992A0A97D753C508DF5D4159");
  }

  self.wire_think = scripts\engine\utility::spawn_tag_origin();
  self.wire_think.origin = self gettagorigin("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.wire_think.angles = self gettagangles("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.wire_think show();
  self.wire_think linkTo(self, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  waitframe();

  if(self.classname == "_encstr_A6AB2FC2970AFF575337EA5B2AC7E3387AC199BFF9832F8452795F30308DA5B93EBF085E6B21474D0B58179815783A30D7")
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BD221FD9CCF0F5E02B1D9CED9D27C291BEC2B531ABB116CD8DCA7DB15AD943D137"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  else if(self.classname == "_encstr_A33F29DEBE43B3532CD75820AF6FEBD38AF0406E94DB1718EEFBA9A08F61600F410ACDEEE1132F40C10F70")
    playFXOnTag(scripts\engine\utility::getfx("_encstr_ADEE22152660984093B0E2F29F2B38F1D9BAD2A019BF9622459103A282A875A7BFA3C3C3"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  else
    return;

  for(;;) {
    self waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_0);

    if(var_0 == "_encstr_99220EEC59A15AD81B95EB91CA853AD0" || var_0 == "_encstr_AF790FF05D41D931214052FCA0E06102C6" || var_0 == "_encstr_8C0B1819A53025FF3582935A48161F1DA05F936FCBA02DDF65D9") {
      if(self.classname == "_encstr_A6AB2FC2970AFF575337EA5B2AC7E3387AC199BFF9832F8452795F30308DA5B93EBF085E6B21474D0B58179815783A30D7")
        killfxontag(scripts\engine\utility::getfx("_encstr_BD221FD9CCF0F5E02B1D9CED9D27C291BEC2B531ABB116CD8DCA7DB15AD943D137"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      else if(self.classname == "_encstr_A33F29DEBE43B3532CD75820AF6FEBD38AF0406E94DB1718EEFBA9A08F61600F410ACDEEE1132F40C10F70")
        killfxontag(scripts\engine\utility::getfx("_encstr_ADEE22152660984093B0E2F29F2B38F1D9BAD2A019BF9622459103A282A875A7BFA3C3C3"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

      self.wire_think delete();
      break;
    }
  }
}

managegate() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_0 = getEntArray("_encstr_B6070E3A6A70EC7AE1B6636A33DBF7EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 hide();

  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  wait 4.0;

  foreach(var_2 in var_0)
  var_2 show();
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1620, -1772, 258));
  var_1.angles = (351, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEntArray("_encstr_8E4A0FABC16B29497522C86039483F206F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(var_4.script_label == "_encstr_8B4C0227")
      var_4.origin = var_4.origin + (0, -2, 0);
  }
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_8E65062BD0CFB4EC":
    case "_encstr_8E9E088D9C58E65B2B19":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_85EF050CB150E7":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_959105B99040BD":
    case "_encstr_B41904BB8593":
    case "_encstr_9B0703CD93":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1280, -2400, 156), (0, 160, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1120, 400, 156), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-464, -1744, 160), (0, 20, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-336, 248, 160), (0, 20, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (200, -680, 160), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-592, 992, 156), (0, 350, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (640, 992, 156), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1920, 1280, 149), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1632, -288, 156), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1488, 176, 164), (0, 160, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (167, 213, 156), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (48, 1072, 148), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1584, 1488, 156), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (976, 1472, 160), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (624, -640, 160), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1584, -896, 156), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-688, -1264, 160), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-96, -1296, 160), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1376, -2144, 156), (0, 60, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1280, -2400, 156), (0, 160, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-1120, 400, 156), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-464, -1744, 160), (0, 20, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-336, 248, 160), (0, 20, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (200, -680, 160), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-592, 992, 156), (0, 350, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (640, 992, 156), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1920, 1280, 149), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1632, -288, 156), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1488, 176, 164), (0, 160, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (167, 213, 156), (0, 70, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (48, 1072, 148), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1584, 1488, 156), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (976, 1472, 160), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (624, -640, 160), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1584, -896, 156), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-688, -1264, 160), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-96, -1296, 160), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1376, -2144, 156), (0, 60, 0));
      break;
    case "_encstr_B807035284":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (610, 2640, 176), (0, 278, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (597, 2713, 176), (0, 278, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (533, 2700, 176), (0, 278, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (466, 2733, 176), (0, 248, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (403, 2753, 176), (0, 248, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550", (378, 2698, 176), (0, 248, 0));
      level.modifiedspawnpoints["_encstr_9AF40A891BCC10B491814E13"]["_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_92D00A82D32A92401E994976"]["_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_81150A7216CB21C67A7A8AD3"]["_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B2E30A8983B140A52672E062"]["_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A9850A52A70A896816E1C47C"]["_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_99050A7B131622B13FD64923"]["_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39", (163, -2912, 172), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39", (263, -2912, 172), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39", (363, -2912, 172), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39", (163, -2812, 172), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39", (263, -2812, 172), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39", (363, -2812, 172), (0, 90, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

_id_121F5() {
  level.outofboundstriggerpatches = [];
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-1369, -543, 150), 0, 16, 48);
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_0;
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_0 in level.outofboundstriggerpatches) {
    if(isDefined(var_0))
      var_0 delete();
  }
}