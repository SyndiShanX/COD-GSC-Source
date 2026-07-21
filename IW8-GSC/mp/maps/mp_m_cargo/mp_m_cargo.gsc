/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_cargo\mp_m_cargo.gsc
***********************************************/

main() {
  _encstr_969233B98DC94BC11D6ECB5B38CBB5C20EDCF2DA38AFADBEB12CC9B3ED5EAD1CBEADD78D16933B7BFAE093596CC23634CA8BD9B96C::main();
  _encstr_874532AA5273E02B5397F6EA737F957883AFE649D0B13D7F268725E05078A7195D3E6370B170E8E2B3588FE2F10FEBD962FFEFC7::main();
  _encstr_A1892D9BCA88E8EBC46377CF579208A0B39707DF7271F8D112C92580606F42A381CDE10633564230B921429DA798F1::main();
  _encstr_B4C833670FA33308E44A7808B297A87FDB27A7D3DBD989A90B26DB411DCF902FC1E7CF5737F344601F7DA059C47C7868FA0227FFC7::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_B481170630B0A8C2762FBF0F739F69FD839E3D812938527A40", "_encstr_882C211BDB198DC2DCD1B24ED7D8EDAD1C85CD9BF5B5160EF5AD07AFB6AFC62C39ECDB");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_139C6();
  thread playerspawnexfilchopper();
  thread get_recently_shot_at_by_rpg();
  thread player_fired_gun_monitor();
  thread increase_accuracy_after_delay();
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_BE9508BA80D5CB6BE2E5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-337, -264, 92));
  var_1.angles = (270, 0, -45);
  var_1 clonebrushmodeltoscriptmodel(var_0, 1);
  var_2 = getEnt("_encstr_AA9508ADB7EA9BA3C61A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (58, 7, 5));
  var_3.angles = (0, 80, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2, 1);
  var_4 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-368, 244, 2));
  var_5.angles = (0, 90, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-368, 152, 2));
  var_7.angles = (0, 90, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
}

increase_accuracy_after_delay() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (267.67, 222.004, 11.5));
  var_0.angles = (0, 270, 0);
  var_0 setModel("_encstr_8CD020EEB2C238DB9BEBDDD6FA630BBE9A5DB15A9547EB5B96DCCD4B6395EB660B1D");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (267.67, 222.01, 26.0559));
  var_1.angles = (0, 90, -180);
  var_1 setModel("_encstr_8CD020EEB2C238DB9BEBDDD6FA630BBE9A5DB15A9547EB5B96DCCD4B6395EB660B1D");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (267.67, 222.004, 37.5));
  var_2.angles = (0, 270, 0);
  var_2 setModel("_encstr_8CD020EEB2C238DB9BEBDDD6FA630BBE9A5DB15A9547EB5B96DCCD4B6395EB660B1D");
}

_id_139C6() {
  var_0 = getEnt("_encstr_B6E30A63873F40CFD6E7344F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 linkTo(var_0);

  thread _id_139C8(var_0);
  thread _id_11FA8();
}

_id_11FA8() {
  var_0 = getEnt("_encstr_990106F0C6452810", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 7;
  var_0 rotateTo((0, 0, -1.5), 5, 2.25, 2.25);
  wait 5;

  for(;;) {
    var_0 rotateTo((0, 0, 1.5), var_1, var_1 * 0.45, var_1 * 0.45);
    wait(var_1);
    var_0 rotateTo((0, 0, -1.5), var_1, var_1 * 0.45, var_1 * 0.45);
    wait(var_1);
  }
}

_id_139C8(var_0) {
  var_1 = 4;

  for(;;) {
    var_2 = 7;
    var_1 = var_1 * -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_1);
    var_0 rotateTo(var_0.goalang, var_2, var_2 * 0.45, var_2 * 0.45);
    wait(var_2);
    scripts\engine\utility::exploder("_encstr_A5AD056A019C63");
    var_1 = var_1 * -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_1);
    var_0 rotateTo(var_0.goalang, var_2, var_2 * 0.45, var_2 * 0.45);
    wait(var_2);
    scripts\engine\utility::exploder("_encstr_8253060E2B5FE330");
  }
}

playerspawnexfilchopper() {
  var_0 = getEnt("_encstr_B6E30A63873F40CFD6E7344F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = (0, 0, -386.09);

  for(;;) {
    waitframe();
    var_2 = var_0.angles * (0, 0, 3);
    var_3 = anglestoup(var_2);
    var_4 = var_3 * -386.09;
    waitframe();
    physics_setgravity(var_4);
    waitframe();
    physicsjolt((0, 0, 0), 1024, 1000, (0.1, 0.1, 0.1));
    waitframe();
  }
}

get_recently_shot_at_by_rpg() {
  while(!istrue(game["_encstr_A9310C0449DDA97F583FADB0FD01"]))
    waitframe();

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    var_0 = getEntArray("_encstr_9B1904D48FAA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = getEntArray("_encstr_8EA50608B23F2B80", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  } else {
    var_0 = getEntArray("_encstr_8EA50608B23F2B80", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = getEntArray("_encstr_9B1904D48FAA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  level._id_11F3C = 0;

  foreach(var_3 in var_1)
  var_3 thread trackhiddenobj(var_1.size);

  level._id_11F3E = 0;

  foreach(var_3 in var_0)
  var_3 thread _id_13C4C(var_0.size);

  while(level._id_11F3C < var_1.size && level._id_11F3E == 0)
    wait 1;

  if(level._id_11F3E == 0) {
    for(var_7 = 30; var_7 > 0; var_7--) {
      var_8 = (randomintrange(-400, 400), randomintrange(-400, 400), 800);
      var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
      var_9 setModel("_encstr_B82D1F8773495FBBDCD7A3E077D731BB728E7398BE02D96087022269F70CE9EBEA");
      var_9 physicslaunchserver((0, 0, 0), (0, 0, 0), -500);
      wait 0.1;
    }
  }
}

trackhiddenobj(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_10)) {
      if(var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_5 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
        continue;
    } else if(isDefined(var_14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var_14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var_2.guid])) {
      self.found[var_2.guid] = 1;

      if(!isDefined(var_2.hiddenobjcount))
        var_2.hiddenobjcount = 1;
      else
        var_2.hiddenobjcount++;
    }

    if(self.health <= 0) {
      break;
    }
  }

  level._id_11F3C++;
  self delete();
}

_id_13C4C(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_10)) {
      if(var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_5 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
        continue;
    } else if(isDefined(var_14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var_14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var_2.guid])) {
      self.found[var_2.guid] = 1;

      if(!isDefined(var_2.hiddenobjcount))
        var_2.hiddenobjcount = 1;
      else
        var_2.hiddenobjcount++;
    }

    if(self.health <= 0) {
      break;
    }
  }

  level._id_11F3E++;
  self delete();
}