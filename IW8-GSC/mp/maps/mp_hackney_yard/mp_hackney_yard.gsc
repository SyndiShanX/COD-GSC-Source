/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_hackney_yard\mp_hackney_yard.gsc
*******************************************************/

main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "_encstr_BAFB08CA7376C616B932";
  _encstr_A2413DCEAE53A3631CAF22388B6F98EB1BD26859C2396989F3D71060D747D223E3BF10D15AD1D1F1DB3F1868FFAFEA5B4B27A0E7322A8F39830B584A9FBBE1::main();
  _encstr_93B73C573F930338B41A2878C2C7984F0BD777E38BA95B88FB740871A84FE0F74313FF0F77E2B0207041B0C9D653103D2B97EB8BB3EA70183A637001FA03::main();
  _encstr_9A4237B812BAFB23E34BA8F120E6C8B362BBE2C0BB1931D9874B37FD11FFB27B4AB26A5853A149916F6318E5F9D7FAC3B21A71886B959FEB37::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("_encstr_8AE519B93BCEEB988537957DDAC1AF8658B16DB9CA5E7DCB85C991");
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_9A0C1C5058353189E26B879B116F9F8877B90C4782FFC01D6357EA1FC271", "_encstr_A15F268657AB51839A0B78C891B6A72853C116068F57D9E9C9E2C899FACE77A0536D9BE8110FE319");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 3);
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1500);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 6);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 10);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_A5230B3794A4302F69C7377A1A", 0);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_8A65065739262C37";
  thread scripts\mp\motiondetectors::init();
  thread player_exfil_struct();
  level battle_tracks_vehicleoccupancyenter();
  level thread _id_121F5();
  level thread neartrackthink();
  level thread fartrackthink();
  level thread maintvdestructibles();
  var_0 = getEnt("_encstr_AD250E2A0AFC8FE53FCB32E028DF9752", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 connectpaths();
  }

  level thread _id_136AD();
  thread hide_multiple_brush();
  wait 10;
  getEnt("_encstr_A5B7107BDFDD15D1E26D089D287BA968DA22", "_encstr_B2CE0BA1D0FB19FDC54613D9BF") thread palfa_lights_thread();
  var_1 = getnodesinradius((808, -350, 185), 200, 0, 200);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.animscript) && var_3.animscript == "_encstr_8F9D0E52582BF2976968AFBE689B7E2B")
      destroynavlink(var_3);
  }

  var_1 = getnodesinradius((766, 1259, 188), 200, 0, 200);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.animscript) && var_3.animscript == "_encstr_A13D0B53EADA387D5783AFE0C0")
      destroynavlink(var_3);
  }
}

spawntraincar(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_85601D031F34535F36C3D616102D0D96F30D4F3FC29546DF75AF2D9EFD1B81");
  return var_1;
}

neartrackthink() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B"))
    level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  var_0 = [];
  var_1 = (-5930, -605, 510);
  var_2 = spawntraincar(var_1);
  var_0[var_0.size] = var_2;
  var_3 = var_2;
  var_0[0].angles = (0, 166, 0);
  var_4 = (0, 526, 0);
  var_5 = var_1 + anglesToForward(var_4) * -27000;
  wait 2.0;
  var_0[0] setscriptablepartstate("_encstr_91EA0C8D4B7643A36E194E7BDC47", "_encstr_AB0703DBB9");
  var_0[var_0.size - 1] setscriptablepartstate("_encstr_AA9F0B1959AF38D1E26160587B", "_encstr_AB0703DBB9");
  thread nearexploderthink(var_0);

  for(;;) {
    var_0[0].origin = var_1;
    wait 1.0;
    var_0[0] show();
    var_0[0] moveTo(var_5, 30.0, 0.1, 0.1);
    var_0[0] setscriptablepartstate("_encstr_95C308568519FBF2E5E0", "_encstr_AB0703DBB9");
    wait(15.0 + randomfloatrange(20.0, 40.0));
    var_0[0] hide();
    waitframe();
  }
}

fartrackthink() {
  var_0 = [];
  var_1 = (9240, -4705, 510);
  var_2 = spawntraincar(var_1);
  var_0[var_0.size] = var_2;
  var_3 = var_2;
  var_0[0].angles = (0, 346, 0);
  var_4 = (0, 346, 0);
  var_5 = var_1 + anglesToForward(var_4) * -35000;
  wait 2.0;
  var_0[0] setscriptablepartstate("_encstr_91EA0C8D4B7643A36E194E7BDC47", "_encstr_AB0703DBB9");
  var_0[var_0.size - 1] setscriptablepartstate("_encstr_AA9F0B1959AF38D1E26160587B", "_encstr_AB0703DBB9");
  thread farexploderthink(var_0);

  for(;;) {
    var_0[0].origin = var_1;
    wait 1.0;
    var_0[0] show();
    var_0[0] moveTo(var_5, 30.0, 0.1, 0.1);
    var_0[0] setscriptablepartstate("_encstr_8A17070ED72BAFC7A9", "_encstr_AB0703DBB9");
    wait(20.0 + randomfloatrange(25.0, 35.0));
    var_0[0] hide();
    waitframe();
  }
}

nearexploderthink(var_0) {
  var_1 = [];
  var_1[0] = (1081.93, -2260.39, 411.6);
  var_1[1] = (64.6655, -2080.35, 425.455);
  var_2 = [];
  var_2[0] = 100;
  var_2[1] = 102;
  var_3 = [];
  var_3[0] = undefined;
  var_3[1] = undefined;

  for(;;) {
    wait 0.1;

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      foreach(var_6 in var_0) {
        var_7 = distancesquared(var_6.origin, var_1[var_4]);

        if(var_7 < 90000) {
          if(!isDefined(var_3[var_4]) || var_3[var_4] != var_6) {
            var_3[var_4] = var_6;

            if(randomint(100) > 25)
              scripts\engine\utility::exploder(var_2[var_4]);
          }
        }
      }
    }
  }
}

farexploderthink(var_0) {
  var_1 = [];
  var_1[0] = (-711.066, -2248.86, 440);
  var_2 = [];
  var_2[0] = 101;
  var_3 = [];
  var_3[0] = undefined;

  for(;;) {
    waitframe();

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      foreach(var_6 in var_0) {
        var_7 = distancesquared(var_6.origin, var_1[var_4]);

        if(var_7 < 90000) {
          if(!isDefined(var_3[var_4]) || var_3[var_4] != var_6) {
            var_3[var_4] = var_6;

            if(randomint(100) > 25)
              scripts\engine\utility::exploder(var_2[var_4]);
          }
        }
      }
    }
  }
}

raindrop_fx_manager() {
  wait 3;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  level thread raindrop_fx_thread();
  var_1 = getEntArray("_encstr_B14F0F232B5302BFF0DA16DD1328C16AB8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1)
  thread raindrop_fx_trigger_think(var_3);
}

raindrop_fx_thread(var_0) {
  self endon("_encstr_A971119BEB977850238FC3C5B30B80C00FC762");
  var_1 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  for(;;) {
    foreach(var_0 in level.players) {
      if(var_0.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        continue;
      }
      if(istrue(var_0.in_rain)) {
        var_3 = angleclamp180(var_0 getplayerangles()[0]);

        if(var_3 < -35 && !istrue(var_0.looking_up)) {
          playFXOnTag(level._effect["_encstr_8322161305FB31B3A0FB357110E8E7CAD5812FD3D5A80B8B"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
          var_0.looking_up = 1;
        } else if(var_3 >= -35 && istrue(var_0.looking_up)) {
          if(isDefined("_encstr_8322161305FB31B3A0FB357110E8E7CAD5812FD3D5A80B8B"))
            stopFXOnTag(level._effect["_encstr_8322161305FB31B3A0FB357110E8E7CAD5812FD3D5A80B8B"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

          var_0.looking_up = 0;
        }
      }
    }

    wait 0.05;
  }
}

raindrop_fx_trigger_think(var_0) {
  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 istouching(var_0)) {
        var_2.in_rain = 0;
        continue;
      }

      var_2.in_rain = 1;
    }

    wait 0.05;
  }
}

maintvdestructibles() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_0 = getEntArray("_encstr_A1AB10A52BCB8380A5B983CF8E7B22F735FB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0)
  var_2 thread runtvdestructible();
}

runtvdestructible() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B4C21279324360709EB47F61FC0BB137CF7AB1E1");
  var_0 = scripts\engine\utility::get_target_array();
  var_1 = spawnStruct();
  var_1.lights = [];
  var_1.tvs = getscriptablearray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.activetvs = var_1.tvs.size;

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "_encstr_8FA906CC80677438") {
      var_4 = var_1.lights.size;
      var_1.lights[var_4] = var_3;
      var_1.lights[var_4].startintensity = var_3 getlightintensity();
      var_1.lights[var_4].currentintensity = var_3 getlightintensity();
      var_1.lights[var_4] thread runflickerroutine();
      continue;
    }
  }

  foreach(var_7 in var_1.tvs) {
    var_7 thread watchtvdamage(var_1);
    var_7 thread watchdestructibletvs(var_1);
  }

  var_9 = var_1.activetvs;

  for(;;) {
    level waittill("_encstr_883114BD6963432B2BCA95B26143A7E1F9E62783B045");
    waittillframeend;

    if(istrue(var_1.dead)) {
      return;
    }
    foreach(var_11 in var_1.lights) {
      var_12 = var_11.startintensity * (var_1.tvs.size / var_9);
      var_11 setlightintensity(var_12);
      var_11.currentintensity = var_12;

      if(var_12 <= 0) {
        var_11 notify("_encstr_8ACC14644DC297202D8BA948FF5438D5AA3966F565AB");
        break;
      }
    }

    waitframe();
  }
}

watchtvdamage(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B4C21279324360709EB47F61FC0BB137CF7AB1E1");
  self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

  if(var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_5 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421") {
    var_0.dead = 1;

    foreach(var_16 in var_0.tvs) {
      var_16 setscriptablepartstate("_encstr_9707038E3B", "_encstr_84670547C3E9F4");

      if(var_16 != self)
        var_16 notify("_encstr_B4C21279324360709EB47F61FC0BB137CF7AB1E1");
    }

    foreach(var_19 in var_0.lights) {
      var_19 notify("_encstr_8ACC14644DC297202D8BA948FF5438D5AA3966F565AB");
      var_19 setlightintensity(0);
    }

    self notify("_encstr_B4C21279324360709EB47F61FC0BB137CF7AB1E1");
  }
}

watchdestructibletvs(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_1);

  if(var_1 == "_encstr_819B086434E69B5FC3D8") {
    var_0.tvs = scripts\engine\utility::array_remove(var_0.tvs, self);
    level notify("_encstr_883114BD6963432B2BCA95B26143A7E1F9E62783B045");
  }
}

runflickerroutine() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8ACC14644DC297202D8BA948FF5438D5AA3966F565AB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait(randomfloatrange(0.01, 0.2));
    self setlightintensity(randomfloatrange(self.currentintensity * 0.5, self.currentintensity * 1.5));
  }
}

hide_multiple_brush() {
  var_0 = getEntArray("_encstr_A31212CAF72842318EB3C139F81B31C12693A768", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 delete();
}

palfa_lights_thread() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 2;

  while(var_0) {
    self waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_1);

    if(var_1 == "_encstr_99341681FF2A6BC037F73B901DE46191E25B395F6352A708") {
      getEnt("_encstr_970D115927F2B328CF0FD34835CC39F98A7311", "_encstr_B2CE0BA1D0FB19FDC54613D9BF") setlightintensity(0);
      var_0--;
    } else if(var_1 == "_encstr_8C2E174B486463E42E4950277803463BE99F6898212C323745") {
      getEnt("_encstr_937F12F1A157C03901BA709012E3B75B87570B75", "_encstr_B2CE0BA1D0FB19FDC54613D9BF") setlightintensity(0);
      var_0--;
    }

    wait 0.05;
  }
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (504, 1225, 140));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-575, -2143, 92));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
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
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (128, -768, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (720, -1112, 24), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-80, -1272, 30), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (288, -1104, 25), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (408, -1208, 24), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (456, 1016, 24), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (872, 608, 32), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1304, 752, 32), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (168, -600, 24), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (552, -1016, 24), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (544, -1760, 16), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (8, 1168, 16), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (344, 1120, 24), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1560, -1864, 24), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-424, 1376, 24), (0, 330, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (455, 1553, 28), (0, 200, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1144, -576, 24), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (872, -416, 32), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (992, -1112, 32), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (856, -1248, 24), (0, 20, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-504, 1640, 106), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-616, 436, 36), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-584, -648, 40), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1584, -64, 28), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1592, -216, 24), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (232, 1312, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-32, -488, 24), (0, 120, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1088, -96, 32), (0, 100, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (464, -1880, 32), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (472, -2248, 176), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1493, -1914, 184), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1320, -264, 176), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (576, 1952, 184), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-600, 1520, 160), (0, 290, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-616, 416, 156), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-48, 184, 28), (0, 200, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (128, -768, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (720, -1112, 24), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-80, -1272, 30), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (288, -1104, 25), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (408, -1208, 24), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (456, 1016, 24), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (872, 608, 32), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1304, 752, 32), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (168, -600, 24), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (552, -1016, 24), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (544, -1760, 16), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (8, 1168, 16), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (344, 1120, 24), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1560, -1864, 24), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-424, 1376, 24), (0, 330, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (455, 1553, 28), (0, 200, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (1144, -576, 24), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (872, -416, 32), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (992, -1112, 32), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (856, -1248, 24), (0, 20, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-504, 1640, 106), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-616, 436, 36), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-584, -648, 40), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1584, -64, 28), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1592, -216, 24), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (232, 1312, 24), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-32, -488, 24), (0, 120, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1088, -96, 32), (0, 100, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (464, -1880, 32), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (472, -2248, 176), (0, 45, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1493, -1914, 184), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (1320, -264, 176), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (576, 1952, 184), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-600, 1520, 160), (0, 290, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-616, 416, 156), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (-48, 184, 28), (0, 200, 0));
      break;
    case "_encstr_B60703EACA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (-645, 1343, 156), (0, 330, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (-639, 1651, 148), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (598, 1855, 52), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (999, 1784, 36), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (1507, -1889, 176), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (553, -2234, 176), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (462, -2221, 176), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (295, -2164, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (372, -1754, 24), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B", (515, -1887, 24), (0, 0, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

_id_136AD() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (1416, -80, 97), 0, 64, 100);
  var_0 thread _id_144FF("_encstr_88190426B73C");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (1595, -150, 97), 0, 64, 100);
  var_1 thread _id_144FF("_encstr_B25709195D5B1C6ED1B24E");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (1585, -920, 50), 0, 32, 100);
  var_2 thread _id_144FF("_encstr_B42D091B62302EA1E32B28");
}

_id_144FF(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!isDefined(self._id_126CE))
      self._id_126CE = [];

    if(scripts\engine\utility::array_contains(self._id_126CE, var_1.guid)) {
      continue;
    }
    self._id_126CE = scripts\engine\utility::array_add(self._id_126CE, var_1.guid);

    switch (var_0) {
      case "_encstr_88190426B73C":
        var_1 thread _id_14491(self);
        break;
      case "_encstr_B25709195D5B1C6ED1B24E":
        var_1 thread _id_1449C(self);
        break;
      case "_encstr_B42D091B62302EA1E32B28":
        var_1 thread _id_144FE(self);
        break;
    }
  }
}

_id_14491(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (1579.86, -232.75, 18.1071);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1564.49, -784.368, 18.125);
  var_4.radius = 128;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1567.63, -2088.98, 24.0016);
  var_4.radius = 256;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 100, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}

_id_1449C(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (1430.82, 605.449, 23.759);
  var_4.radius = 256;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1574.82, -49.8372, 23.8122);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1500, 1300, 15);
  var_4.radius = 256;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 70, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}

_id_144FE(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (1020, -1750, 15);
  var_4.radius = 850;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-617, -1765, 15);
  var_4.radius = 128;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1500, -1865, 160);
  var_4.radius = 128;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 70, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}

_id_121F5() {
  if(level.gametype == "_encstr_AAE507E8423F63C163") {
    if(!isDefined(level.outofboundstriggers))
      level.outofboundstriggers = [];

    var_0 = [(689, 935, 371)];

    foreach(var_2 in var_0) {
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 300, 128);
      level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
    }
  }
}