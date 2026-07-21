/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\motiondetectors.gsc
***********************************************/

init() {
  precachemodel("_encstr_A19D25D33A2FC2F431B87B7BF0A9B11A57C6DD0888E31A04582017C752AB57329DEB25C6852B42");
  precachemodel("_encstr_A99E19AE5BEBB9D1DEE4B0CEB2D7BB0BC68DAF362D7643A3AF6062");
  precachemodel("_encstr_A62E1C0BE2E76B1488F8F7E7A866EFB2698919C55BCF925CD6D2AEFFE078");
  precachemodel("_encstr_BE21175D82088873C713763B0A598FB338B16FEFA88C2701B2");
  precachemodel("_encstr_B8A31AF0C471389A65780FECEBF889B391EB69E7B963E0DB72F662FD");
  precachemodel("_encstr_A27F16532A7EF40A6F93B36A100FC2874198AF8768B36047");
  precachemodel("_encstr_91F319789CEEB3A437B0ABD321179E2701A9F9E75BD38ABA9F7012");
  precachemodel("_encstr_A9782CCBB2413001DA1A13DC58070790E09391C24A207069C7842AC8730BF812ED7130C2BD01A115FAB5CFB7918A");
  precachemodel("_encstr_A7B52F9BA060638CE0319C992538D9BF10BB127348C04349C8058691D72B91EFCDB07A4A30AC3F7BC069BD5F49DAA917E0");
  precachemodel("_encstr_99F221AE6D7D4BE691AE9BD1E4A51663AF63A5D934E8F5064CAF4EBAB9CDAC93BEE06B");
  precachemodel("_encstr_99DC2475D7F95CB33DBB2B636383C755A1B111EF490869127F16337B8868EF0A49319D4FEF20");
  precachemodel("_encstr_8CFC1ED96D90612389283A9236D1572748F1774BA150F5132360B2297BBF9B5D");
  precachemodel("_encstr_A27E2137E019C7FA791075AF10114287E05877D788113E22ABB87F69ED33CA44AE183B");
  precachemodel("_encstr_8AB52732B83F0D1B9F4F103210294BBAC25B599D4AC526C1879FD2A162D1D864485B1BB258BB4F39DF");
  precachemodel("_encstr_81772A4BF869FDDA2FA5453A196B83BF932087BB606122C3D7CECFF4F1331A7FDE30D70FF05BA71F23C8552D");
  precachemodel("_encstr_91B11FFDC8D8889B78175F67611B42FF7131334501C11837500F132F63BE992058");
  precachemodel("_encstr_A29D22C64B761A1DF536B2961B5AB93B7D31AB1B13FA0623BEDC382BB093D70EADEBEDCD");
  precachemodel("_encstr_91CD3370C7AFCADA48330409776B1A1D3C702147A3BB132F6BB75AAF25EEA107EBFBF9C0A0CB93FDC78BE8E1BD457D9A08280131C3");
  precachemodel("_encstr_A7B9361A6160638CE0319CAF3F2854AB93F832A1A9415F452003939BDB585B1F45339A8A16A693FAF06DBF5FCDF8E513654BC163386847B5");
  precachemodel("_encstr_B11C2B4DEBD93D8F9C387BB121E5C7753055FFF775A8834F3EB1037AC9484B61701B7255EFE88A2F6F4BD953D0");
  precachemodel("_encstr_97902EBB058938E3CFCACBD602BFAB705C962767AEAD0838B33223594ABBDD31B3E5B59B6FD26875275BBE23D2A718F0");
  precachemodel("_encstr_A9C33563D29D0D1D96DC767D995A0FE8EAC9959B7DCD568DBA392DE897D7D8B0B50E7DBBB4A30D36B0D9CAFA0326EB370E59B027EB835B");
  precachemodel("_encstr_9A17381BA57686E82D37B3FACCB41EA3AB395637D737B26CAB93A5D1BCEB36856B1CEBBBA53A1AC658B3567D8189BECDC195C239EB1C6BFAED37");
  precachemodel("_encstr_AA39374DE3D13597843003B9F8E8BFED205BC4EF0B10FB6F3608CA7386331BA7701F6C4A8B7085BF5621420A09AF1A8AC987E0A533B0814B09");
  precachemodel("_encstr_99013AB1477F40935A93D1FFFFA2E5180CDF194EEFB0785D23BFEFAD1FEAA090A53283631411F018EA87E79BEB51D76A778A8B19BE6AB1476297FF85");
  precachemodel("_encstr_AD363E9A6160638CE0319CAF237853A31D9902A1C94B5BC7201B8F8AAF60DDF3C5F3FBFBD0AFF3B19073BF65E1A9726278E8D29179FE6F771027A266A581AA47");
  precachemodel("_encstr_A6482C6173595005AAFB87EFD7725E18ED41AB581AAC11C982B791B10F8B10A08529F0F1C7DF38FFBA97DDDF4B62");
  precachemodel("_encstr_B4622B0A80FB3DB3302077574ED963C51B39B3520869B9EB689C707448C30F8DB3A1CAFA013FAA07417E7F8879");
  precachemodel("_encstr_81453725CF3F30308749C1AB4D6860EAEB71B555C38286AF170B7F2529978FE17CA780873B5BA805C03F60AFEACC4506AB67C6A0D763D75FC5");
  precachemodel("_encstr_9B1B3AC59B6E75EB6291431BC0539242FB3140BB538D86D7CFA2C03B76BB0BDD29304DB79BCD911F01A9BC012877877EC3EBF260FF3BF67B08B83778");
  level._effect["_encstr_A6280E3B33F0BE73D9ECAFCCD8B0E456"] = loadfx("_encstr_B1CA2CD49613102B2387F1781BEDE991933D51E0E01FC11788FA9038C6D3A58ADFAEE44C7FDBE84B32828A902A68");
  level._effect["_encstr_96F718D3C53BF16E4819397F50D8BAEAAF79371FA165B90A8A0B"] = loadfx("_encstr_8F8E368D842B6E94DF514FCD9B9D0CFD33CAAABE28797957F9306349A863C28A801E362F60AE99501AED29186C1758240F4765B71513B571");
  thread motiondetectors();
  script_model_anims();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_A7B90C0AE07C73CB400F81843F40"] = #animtree;
  level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_8FF009022583A82537F313"] = % _encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3;
  level.scr_animname["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_8FF009022583A82537F313"] = "_encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3";
  level.scr_eventanim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_8FF009022583A82537F313"] = "_encstr_935D0F2B5CF599AEDC2B31ED0FD7C1D8C9";
  level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = % _encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D;
  level.scr_animname["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D";
  level.scr_eventanim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_97DD1707E7DF021D0358F33F487ED4FB5DF0013DC0B71B5C0B";
  level.scr_animtree["_encstr_B8C5075B87A73349E0"] = #animtree;
  level.scr_anim["_encstr_B8C5075B87A73349E0"]["_encstr_8FF009022583A82537F313"] = % _encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F;
  level.scr_animname["_encstr_B8C5075B87A73349E0"]["_encstr_8FF009022583A82537F313"] = "_encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F";
  level.scr_anim["_encstr_B8C5075B87A73349E0"]["_encstr_AC010C3955ECA9038931DB187790"] = % _encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8;
  level.scr_animname["_encstr_B8C5075B87A73349E0"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8";
  level.interactionanimlength = getanimlength(level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_8FF009022583A82537F313"]);
}

motiondetectors() {
  wait 5;
  var_0 = getEntArray("_encstr_AD320A6B23EB67DBB1EAB695", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::get_target_array();
    var_2 thread motiondetectionproc(var_3);
  }
}

lightonroutine(var_0, var_1) {
  wait(var_0);

  if(self.code_classname == "_encstr_8FA906CC80677438") {
    if(!isDefined(self.savedintensity))
      var_2 = 50;
    else
      var_2 = self.savedintensity;

    self setlightintensity(var_2 * 0.7);
    thread scripts\engine\utility::play_sound_in_space("_encstr_B82111DA1CF51BA5CE34E89BD74BDCA3F5ED73", self.origin);
    wait 0.1;
    thread scripts\engine\utility::play_loop_sound_on_entity("_encstr_A9FC163B9009B8634F4A4BD3410FA8305117B5E724ED5837");
    self setlightintensity(var_2 * 0.1);
    wait 0.05;
    self setlightintensity(var_2 * 0.4);
    wait 0.1;
    self setlightintensity(var_2 * 0.2);
    wait 0.15;
    self setlightintensity(var_2);
  } else if(self.code_classname == "_encstr_96010BDCD8392D073A164C1B2B")
    self setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_B135094273DAF12B2F9808");
}

lightoffroutine(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.code_classname == "_encstr_8FA906CC80677438") {
      var_3 setlightintensity(0);
      var_3 thread scripts\engine\utility::play_sound_in_space("_encstr_8D3D128922C9E118578B80806F613019110DF484", var_3.origin);
      var_3 notify("_encstr_B17D201023802BDECBC5EB5872052991F823E40A3BDBE1C3B04D79C8DB41750F6003");
      continue;
    }

    if(var_3.code_classname == "_encstr_96010BDCD8392D073A164C1B2B")
      var_3 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_82CB0A534F34DAFA7990EFF7");
  }
}

motiondetectionproc(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = spawnStruct();
  var_1.active = undefined;
  var_1.masterswitches = [];
  var_1.lights = [];
  var_1.models = [];
  var_1.nvglights = [];
  var_1.switchstatus = "_encstr_8AB00750CA2393A8F3";
  var_1.lightson = 0;
  var_1.detection = 0;
  var_1.triggerblind = undefined;

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "_encstr_8FA906CC80677438") {
      var_1.lights[var_1.lights.size] = var_3;
      continue;
    }

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "_encstr_81C10DDA0B6ED12BC9A9BB2DE8B10D") {
      var_1.masterswitches[var_1.masterswitches.size] = var_3;
      continue;
    }

    if(var_3.code_classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && !isDefined(var_3.script_parameters)) {
      var_1.models[var_1.models.size] = var_3;
      continue;
    }

    if(var_3.code_classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9") {
      var_1.nvglights[var_1.nvglights.size] = var_3;
      continue;
    }

    if(isDefined(var_3.script_label) && var_3.script_label == "_encstr_9584101DB48CA0FD6F22515ECB1FA1202515")
      var_1.triggerblind = var_3;
  }

  var_5 = getscriptablearray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.lights = scripts\engine\utility::array_combine(var_1.lights, var_5);

  foreach(var_7 in var_1.lights) {
    if(var_7.code_classname == "_encstr_8FA906CC80677438") {
      var_7.savedintensity = var_7 getlightintensity();
      var_7 setlightintensity(0);
      continue;
    }

    if(var_7.code_classname == "_encstr_96010BDCD8392D073A164C1B2B")
      var_7 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_82CB0A534F34DAFA7990EFF7");
  }

  foreach(var_10 in var_1.masterswitches)
  var_10 thread runlightswitch(self, var_1);

  foreach(var_13 in var_1.models)
  var_13.modelname = var_13.model;

  if(scripts\mp\utility\game::getgametype() == "_encstr_ACF906B79752C5E8") {
    if(!isDefined(level.emplights))
      level.emplights = [];

    level.emplights = scripts\engine\utility::array_add(level.emplights, var_1);

    if(isDefined(level.emplightsoff))
      level thread[[level.emplightsoff]]();
  }

  thread onoffmodelswap(var_1.models, "_encstr_BA19049F4B2D");
  thread motiondetectionstatus(var_1);

  for(;;) {
    if(var_1.switchstatus == "_encstr_AB0703DBB9") {
      self notify("_encstr_95741038825FB5A01AD397A31C8610E887CA");

      if(!var_1.lightson) {
        thread blindplayers(var_1);

        foreach(var_7 in var_1.lights)
        var_7 thread lightonroutine(randomfloat(0.2), var_1.nvglights);

        thread onoffmodelswap(var_1.models, "_encstr_AB0703DBB9");
        var_1.lightson = 1;
      }
    } else if(var_1.switchstatus == "_encstr_8AB00750CA2393A8F3") {
      if(var_1.detection && !var_1.lightson) {
        thread blindplayers(var_1);

        foreach(var_7 in var_1.lights) {
          var_7 thread lightonroutine(randomfloat(0.2), var_1.nvglights);
          var_1.lightson = 1;
        }

        thread onoffmodelswap(var_1.models, "_encstr_AB0703DBB9");
        thread motiondetectioncooldown(var_1);
      }
    } else if(var_1.switchstatus == "_encstr_BA19049F4B2D") {
      if(var_1.lightson) {
        level lightoffroutine(var_1.lights, var_1.nvglights);
        thread onoffmodelswap(var_1.models, "_encstr_BA19049F4B2D");
        var_1.lightson = 0;
      }

      if(isDefined(self.script_parameters) && self.script_parameters == "_encstr_8AB00750CA2393A8F3")
        var_1.switchstatus = "_encstr_8AB00750CA2393A8F3";

      self notify("_encstr_9AD50BF4237933936F798A1258");
    }

    wait 0.05;
  }
}

blindplayers(var_0) {
  if(isDefined(var_0.triggerblind)) {
    wait 0.4;

    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !scripts\mp\utility\player::isreallyalive(var_2)) {
        continue;
      }
      if(var_2 istouching(var_0.triggerblind)) {
        var_2 activatenightvisionblind();
        continue;
      }

      foreach(var_4 in var_0.lights) {
        if(distancesquared(var_4.origin, var_2.origin) > 230400) {
          continue;
        }
        if(!scripts\engine\utility::within_fov(var_2 getEye(), var_2 getplayerangles(), var_4.origin, 0.707106)) {
          continue;
        }
        var_5 = scripts\engine\trace::ray_trace(var_2 getEye(), var_4.origin, undefined, scripts\engine\trace::create_default_contents(1));

        if(distancesquared(var_5["_encstr_BD260953AA97E3F014279D"], var_4.origin) <= 324) {
          var_2 activatenightvisionblind();
          break;
        }
      }
    }
  }
}

nameplatemanagement(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(var_0.lightson == 0) {
      foreach(var_2 in level.players) {
        if(var_2 istouching(self))
          var_2 thread manageplayerindarkvolume(self, var_0);
      }
    }

    wait 0.1;
  }
}

manageplayerindarkvolume(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self.indarkvolume)) {
    return;
  }
  scripts\mp\utility\perk::giveperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
  self.indarkvolume = 1;

  while(self istouching(var_0) && var_1.lightson == 0)
    wait 0.1;

  scripts\mp\utility\perk::removeperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
  self.indarkvolume = undefined;
}

motiondetectionstatus(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0.detection = 0;

    foreach(var_2 in level.players) {
      if(var_2 istouching(self)) {
        if(var_2 getstance() == "_encstr_A5AD069B231F0BAF" && length2d(var_2 getvelocity()) > 40) {
          var_0.detection = 1;
          var_0.cooldown = 4;
        }

        if(var_0.lightson)
          var_2.inmotionlight = 1;
      }
    }

    wait 0.05;
  }
}

motiondetectioncooldown(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9AD50BF4237933936F798A1258");
  self endon("_encstr_95741038825FB5A01AD397A31C8610E887CA");

  if(isDefined(self.script_parameters) && self.script_parameters == "_encstr_8AB00750CA2393A8F3") {
    while(var_0.cooldown > 0) {
      wait 0.1;
      var_0.cooldown = var_0.cooldown - 0.1;
    }
  }

  var_0.switchstatus = "_encstr_BA19049F4B2D";
}

runlightswitch(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = createlightswitchtrigger(var_0, var_1);

  if(isDefined(var_2))
    var_2 thread watchlightswitchuse(var_1);
}

createlightswitchtrigger(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin, 40, 0, 60);
  var_2 setModel("_encstr_A19D25D33A2FC2F431B87B7BF0A9B11A57C6DD0888E31A04582017C752AB57329DEB25C6852B42");
  var_2.angles = self.angles;

  if(self.script_parameters == "_encstr_8AB00750CA2393A8F3") {
    return;
  }
  var_3 = scripts\engine\utility::get_target_array();

  foreach(var_5 in var_3) {
    if(var_5.code_classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9") {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "_encstr_87D10ACD8DCA7356C9ED19B2")
        var_2.scenenode = var_5;
      else {
        var_2.hintlightmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
        var_2.hintlightmodel.angles = var_5.angles;
        var_2.hintlightmodel setModel(var_5.script_noteworthy);
        var_2.hintlightmodel.modelname = var_5.script_noteworthy;
      }

      continue;
    }

    if(var_5.code_classname == "_encstr_8FA906CC80677438") {
      var_2.hintlight = var_5;
      continue;
    }
  }

  var_2 setuserange(80);
  var_2 sethintdisplayrange(200);
  var_2 setusefov(120);
  var_2 sethintdisplayfov(120);
  var_2 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_2 setHintString(&"_encstr_8B7F103505976252D14251EBA97529150D12");
    var_2 sethinticon("_encstr_9A2E1472F83F45A779F9ADA38DE3074E4B18997A30C9");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_2 setusepriority(0);
    var_2 makeusable();
  }

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_8AB00750CA2393A8F3")
    var_1.switchstatus = "_encstr_8AB00750CA2393A8F3";
  else
    var_1.switchstatus = "_encstr_BA19049F4B2D";

  foreach(var_8 in level.players)
  var_2 enableplayeruse(var_8);

  if(isDefined(var_2.hintlightmodel) && isDefined(var_2.hintlight)) {
    var_2.hintlightcolor = var_2.hintlight getlightintensity();
    var_2 thread manageswitchhintlight(var_1);
  }

  return var_2;
}

watchlightswitchuse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(var_0.switchstatus) && var_0.switchstatus == "_encstr_AB0703DBB9")
      playsoundatpos(self.origin, "_encstr_8C9219298269553BE31F907B9337D09B236F1EB8DD922D26D66390");
    else
      playsoundatpos(self.origin, "_encstr_979518BB108968ED9F1A09D0B35729389B9D0D67A72D59B8BB52");

    thread swapswitchstatus(getanimlength(level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_8FF009022583A82537F313"]) - 0.15, var_0);
    var_2 = lightswitchinteraction(var_1, var_0);

    if(!var_2)
      self notify("_encstr_87BB15E95D20DF433FF9DB324080CF96A82F9D64C12B27");
  }
}

swapswitchstatus(var_0, var_1) {
  self endon("_encstr_87BB15E95D20DF433FF9DB324080CF96A82F9D64C12B27");
  wait(var_0);

  if(var_1.switchstatus == "_encstr_8AB00750CA2393A8F3" || var_1.switchstatus == "_encstr_BA19049F4B2D") {
    var_1.switchstatus = "_encstr_AB0703DBB9";
    self notify("_encstr_95741038825FB5A01AD397A31C8610E887CA");
  } else
    var_1.switchstatus = "_encstr_BA19049F4B2D";
}

manageswitchhintlight(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(var_0.switchstatus == "_encstr_AB0703DBB9") {
      self.hintlight setlightintensity(0);
      self.hintlightmodel setModel(self.hintlightmodel.modelname);
    } else {
      self.hintlight setlightintensity(self.hintlightcolor);
      self.hintlightmodel setModel(self.hintlightmodel.modelname + "_encstr_951A0491F710");
    }

    waitframe();
  }
}

getlightswitchstatus(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.switchstatus) && var_2.switchstatus == "_encstr_AB0703DBB9")
      return "_encstr_AB0703DBB9";
  }

  return "_encstr_8AB00750CA2393A8F3";
}

onoffmodelswap(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_1 == "_encstr_AB0703DBB9") {
      var_3 setModel(var_3.modelname + "_encstr_951A0491F710");
      continue;
    }

    var_3 setModel(var_3.modelname);

    if(isDefined(var_3.flare))
      var_3.flare delete();
  }
}

#using_animtree("_encstr_B40101");

lightswitchinteraction(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1.switchstatus == "_encstr_AB0703DBB9", "_encstr_8FF009022583A82537F313", "_encstr_AC010C3955ECA9038931DB187790");
  var_3 = scripts\engine\utility::ter_op(var_1.switchstatus == "_encstr_AB0703DBB9", "_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_9AD50BF4237933936F798A1258");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, var_3);
  self.animname = "_encstr_B8C5075B87A73349E0";
  self useanimtree(#animtree);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, var_2);
  var_4 = getanimlength(level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"][var_2]);
  wait(var_4);
  setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 0);
  self notify("_encstr_8190159025B4E8FEDA5F313357125010777D3BC80F1C50");
  return 1;
}

watchplayerdeath(var_0) {
  self endon("_encstr_8190159025B4E8FEDA5F313357125010777D3BC80F1C50");
  self.cancelinteraction = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      self.cancelinteraction = 1;
      break;
    }

    waitframe();
  }
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0.player_rig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_0.player_rig setModel(var_2);
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 0);
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1))
    var_0 setOrigin(var_1);
  else
    var_0 setOrigin(var_0.origin + (0, 0, 100));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
}