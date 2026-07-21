/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_malyshev\mp_malyshev.gsc
***********************************************/

main() {
  _encstr_A9D835DAB6ED9A609B809E9FB0D8254281D6B5D5A70F12B960C8D79360ABAF4A5978AD4E01AB4BC869586FFBF021DBF2D70B37157CE702::main();
  _encstr_875634B9C69C2D078E6EBCB507F26B2CE037BCDA38F5DAB0C6BCE6A1B2ECCB9DACB9CBB638AFD60BC6E56E86B2D9BE85393A179D6E8D::main();
  _encstr_8CEF2F3FBB4A98F71BF35818AB1E218062033F8B30F970B7434BABA0C2A3C8283A57330BC4D8F80B8F932669FBEA946016::main();
  _encstr_B1B03557D332E09F73AB702083C6D9684A3B67F368D1986F7B23F3883A8BA070E2BF1B63EC5EA02367AB4EF0C2B7CB70FC1687458F6A98::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(istrue(level._id_11AD3))
    scripts\mp\compass::setupminimap("_encstr_858E1E97DDFF91A78860967D869BA982796013396D392EE327A358EAE793AE43", "_encstr_81D8288DED3236853747CA4EBE6C7BDA072CE66EBEDA58C1F5ADE0FAB5C2C65E9BD0B2D9FA260667C481");
  else
    scripts\mp\compass::setupminimap("_encstr_876818B1BDB61CB09BCDFA5BC238BEDA0ED76BC2D897CD34B2CE", "_encstr_A64B2241F55428870B9383B52752D810F8CECBDB11B5E0C7E19FA1E7C79A910893E4B1F3");

  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level thread onplayerconnect();
  level thread player_exfil_struct();
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";

  if(getdvarint("_encstr_A76C1C9BD827AFB6B007FAD53756C4C067C4C0F5DE26D459C6D1963B56E6", 0) == 0) {
    scripts\cp_mp\utility\game_utility::_id_12B25();
    level thread little_bird_mg_mp_waitandspawn();
  }

  if(scripts\mp\spawnlogic::generatinglosdata()) {
    var_0 = getEntArray("_encstr_85140DF79C3737B95D38FFBFB7CDAB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_2 in var_0) {
      var_2 hide();

      if(var_2.spawnflags & 1) {
        var_2 connectpaths();
        var_2 delete();
      }
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread _id_13892();
    var_0 thread _id_13893();
  }
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (712.5, 3364, 21));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (712.5, 3340, 21));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3129, 3548.95, 80));
  var_4 setModel("_encstr_B6F62FE28865023FFB20EBEF4E23B78F8B987A5AF119BE6B1191E327E9E9FB562929D25278B9F9836805FD2F71313B1F53");
  var_4.angles = (86.6, 293, -69.3);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3126.25, 3548.3, 77.75));
  var_5 setModel("_encstr_B6F62FE28865023FFB20EBEF4E23B78F8B987A5AF119BE6B1191E327E9E9FB562929D25278B9F9836805FD2F71313B1F53");
  var_5.angles = (85.94, 330.58, 148);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3035.2, 3553.25, 80.5));
  var_6 setModel("_encstr_B6F62FE28865023FFB20EBEF4E23B78F8B987A5AF119BE6B1191E327E9E9FB562929D25278B9F9836805FD2F71313B1F53");
  var_6.angles = (86.7, 175.2, 88.8);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3026.8, 3713.5, 80.5));
  var_7 setModel("_encstr_B6F62FE28865023FFB20EBEF4E23B78F8B987A5AF119BE6B1191E327E9E9FB562929D25278B9F9836805FD2F71313B1F53");
  var_7.angles = (85.9, 141.85, -128.76);
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3430.5, 2158.7, 66.25));
  var_8 setModel("_encstr_B6F62FE28865023FFB20EBEF4E23B78F8B987A5AF119BE6B1191E327E9E9FB562929D25278B9F9836805FD2F71313B1F53");
  var_8.angles = (86.47, 250.5, 70);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3575, 2158.3, 66.25));
  var_9 setModel("_encstr_B6F62FE28865023FFB20EBEF4E23B78F8B987A5AF119BE6B1191E327E9E9FB562929D25278B9F9836805FD2F71313B1F53");
  var_9.angles = (87.8, 306, -56.25);
}

_id_13892() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.update_tracks_operational_status = 1;
  var_0 = "_encstr_A130084D2FDAD8AA8F62";

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.update_tracks_operational_status)
      playFXOnTag(level._effect["_encstr_A525103948240FE9900A42924BEBBEEBE7DD"], self, var_0);

    wait(2.5 + randomfloat(3));
  }
}

_id_13893() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEnt("_encstr_BE380E2D7337B423AC1539963B76AC4E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    if(var_0 istouching(self))
      self.update_tracks_operational_status = 0;
    else
      self.update_tracks_operational_status = 1;

    wait 1;
  }
}

little_bird_mg_mp_waitandspawn() {
  if(!isDefined(level.chopper_gunner_assignedtargetmarkers_onnewai))
    level.chopper_gunner_assignedtargetmarkers_onnewai = [];

  var_0 = [];
  var_1 = spawnStruct();
  var_1.origin = (-3100, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-3100, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-2600, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-2100, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-2100, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1600, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1100, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-600, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-100, 4950, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1800, 100, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1300, 100, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-800, 100, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-300, 300, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (300, 300, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;
  var_1 = spawnStruct();
  var_1.origin = (300, -200, 30);
  var_1.radius = 500;
  var_0[var_0.size] = var_1;

  foreach(var_1 in var_0) {
    var_3 = getnodesinradius(var_1.origin, var_1.radius, 0, 1000);

    foreach(var_5 in var_3) {
      if(!scripts\engine\utility::array_contains(level.chopper_gunner_assignedtargetmarkers_onnewai, var_5))
        level.chopper_gunner_assignedtargetmarkers_onnewai[level.chopper_gunner_assignedtargetmarkers_onnewai.size] = var_5;
    }
  }
}