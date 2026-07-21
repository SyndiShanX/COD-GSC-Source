/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\destructible.gsc
***********************************************/

init() {}

script_model_anims() {}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

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

add_destructible_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = spawnStruct();
    add_destructible(var_5, var_4);
    var_5 assigninteractteam(level.teamnamelist);

    if(!isDefined(level.destructibles[var_0]))
      level.destructibles[var_0] = [];

    level.destructibles[var_0][level.destructibles[var_0].size] = var_5;
    var_5 process_action("_encstr_88C5055208731B");
  }
}

add_destructible(var_0, var_1) {
  if(!isDefined(var_0.ents))
    var_0.ents = [];

  var_0 read_properties(var_1);
  var_0 read_actions(var_1);
  var_0.ents[var_0.ents.size] = var_1;
  var_1.parent = var_0;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2)
      add_destructible(var_0, var_4);
    }
  }
}

read_properties(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0.classname) {
    case "_encstr_A38E124303C0477207C357B07F1D8725F85596B3":
      self.use_trigger = var_0;
      break;
    case "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9":
      var_1 = var_0.script_label;

      if(isDefined(var_1)) {
        switch (var_1) {
          case "_encstr_926B103F4F85DA0335B822DDD8D57D5F80B9":
            if(!isDefined(self.useobjects))
              self.useobjects = [];

            self.useobjects["_encstr_AA5606FD1AF05085"] = setup_bomb_object(var_0.origin);
            self.useobjects["_encstr_AA5606FD1AF05085"].scenenodekey = "_encstr_AA5606FD1AF05085";
            break;
          case "_encstr_AB2810F3CED1C32FED10220AA985A28FE82D":
            if(!isDefined(self.scenenodes))
              self.scenenodes = [];

            self.scenenodes["_encstr_AA5606FD1AF05085"] = var_0;
            break;
          case "_encstr_A5250FFB462D02A2F8CD13C381EE79FA9F":
            if(!isDefined(self.useobjects))
              self.useobjects = [];

            self.useobjects["_encstr_B69B0589C236B6"] = setup_bomb_object(var_0.origin);
            self.useobjects["_encstr_B69B0589C236B6"].scenenodekey = "_encstr_B69B0589C236B6";
            break;
          case "_encstr_A1730F2379A5A34751F7545DFF580EEFDA":
            if(!isDefined(self.scenenodes))
              self.scenenodes = [];

            self.scenenodes["_encstr_B69B0589C236B6"] = var_0;
            break;
        }
      }

      break;
    case "_encstr_96010BDCD8392D073A164C1B2B":
      self.scriptable = var_0;
      break;
  }
}

read_actions(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  var_1 = strtok(var_0.script_noteworthy, "_encstr_964C0249");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_encstr_854C021F");

    if(!isDefined(var_4)) {
      return;
    }
    if(var_4.size < 2) {
      return;
    }
    var_3 = var_4[0];

    if(!isDefined(var_0.actions))
      var_0.actions = [];

    if(!isDefined(var_0.actions[var_3]))
      var_0.actions[var_3] = [];

    for(var_5 = 1; var_5 < var_4.size; var_5++)
      var_0.actions[var_3][var_0.actions[var_3].size] = var_4[var_5];
  }
}

waittime_process_action(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_1);
  process_action(var_0);
}

waitmsg_process_action(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_0);
  process_action(var_0);
}

process_action(var_0) {
  if(!isDefined(self.ents)) {
    return;
  }
  foreach(var_2 in self.ents) {
    if(isDefined(var_2.actions) && isDefined(var_2.actions[var_0])) {
      foreach(var_4 in var_2.actions[var_0])
      var_2 actionmap(var_4);
    }
  }

  self.state = var_0;
}

actionmap(var_0) {
  switch (var_0) {
    case "_encstr_BD1805CB69C063":
      self show();
      break;
    case "_encstr_BECC055CF3811A":
      self hide();
      break;
    case "_encstr_AB610616DF039871":
      self solid();
      break;
    case "_encstr_AC1C094DFF93103033EAF9":
      self notsolid();
      break;
    case "_encstr_B41C1023A59BC67BB99B2B8D4707581D1ADC":
      self disconnectPaths();
      break;
    case "_encstr_B4A50D583AB837D53F1397E2241B48":
      self connectpaths();
      break;
    case "_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73":
      var_1 = self.origin;
      var_2 = self.angles;
      var_3 = spawnfx(level._effect["_encstr_950D0F9D6D2A63501B5755786BA387E46B"], var_1, anglesToForward(var_2) * -1.0, (0, 0, 1));
      triggerfx(var_3);
      physicsexplosionsphere(var_1, 200, 100, 3);
      playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
      earthquake(0.5, 1.0, var_1, 1500);
      self.parent.plantedbomb setscriptablepartstate("_encstr_999B050670F0FA", "_encstr_AFCB082AC1D6A3EA7B73");
      break;
  }
}

setup_bomb_object(var_0) {
  var_1 = scripts\mp\gameobjects::createhintobject(var_0, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_88FF1268537C29B806D035FF8E0BEF7B42E9AB60", &"_encstr_ADFC0AEC70DEC642B1991BDB", undefined, undefined, undefined, 800, 120, 72, 120);

  if(!isDefined(level.breachusetriggers))
    level.breachusetriggers = [];

  level.breachusetriggers[level.breachusetriggers.size] = var_1;
  self.defused = 0;
  thread usetriggerthink(var_1);
  return var_1;
}

bomb_planted_think(var_0, var_1) {
  var_2 = var_1.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex))
      level.breachindex = 0;
    else
      level.breachindex++;

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(var_2);

  if(!self.defused) {
    process_action("_encstr_83320ADDB7DB01AB8F3FF8E8");
    var_3 = self.useobjects[var_0].origin;

    if(isDefined(self.scriptable)) {
      if(var_0 == "_encstr_AA5606FD1AF05085")
        self.scriptable setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_BE870DE4FF283DA6CFAA6573A0066D");
      else
        self.scriptable setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_8E240C1959E6A3E4B797240B8DAD");
    } else {
      var_4 = self.useobjects[var_0].angles;
      var_5 = spawnfx(level._effect["_encstr_950D0F9D6D2A63501B5755786BA387E46B"], var_3, anglesToForward(var_4) * -1.0, (0, 0, 1));
      triggerfx(var_5);
      self.plantedbomb setscriptablepartstate("_encstr_999B050670F0FA", "_encstr_AFCB082AC1D6A3EA7B73");
    }

    physicsexplosionsphere(var_3, 200, 100, 3);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_3);
    earthquake(0.5, 1.0, var_3, 1500);

    foreach(var_7 in self.useobjects) {
      var_7 delete();
      level.breachusetriggers = scripts\engine\utility::array_remove(level.breachusetriggers, var_7);
    }

    wait 0.1;

    if(isDefined(var_1))
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");
    else
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");

    if(isDefined(level.hostages))
      thread playhostagehelp(self.plantedbomb.origin);
  }

  self.plantedbomb delete();
  self.plantedbomb = undefined;
  self.plantedkey = undefined;
  setomnvar("_encstr_8FB61105DB86CFFDAF50821AB9D17497B93EA7" + self.breachindex, 0);
  setomnvar("_encstr_AAB815BA96D72D37CEC25BACAF472DB559C9FACAE68E7D" + self.breachindex, undefined);

  if(self.defused) {
    foreach(var_7 in self.useobjects)
    var_7 setHintString(&"_encstr_ADFC0AEC70DEC642B1991BDB");

    assigninteractteam(level.teamnamelist);
    process_action("_encstr_88C5055208731B");
  }
}

playhostagehelp(var_0) {
  wait 1;

  if(distance2d(level.hostages[0].origin, var_0) < 500)
    level.hostages[0] playSound("_encstr_A13A128B8BA79AE98091FB7E4339AB432B578B2F");
}

bomb_fuse_think(var_0) {
  self endon("_encstr_9A7B088CCA335D37CA91");

  foreach(var_2 in self.useobjects)
  var_2 setHintString(&"_encstr_A13211D1B75E56D97F2027D996BDB7F035BEB7");

  self.timerobject = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.plantedbomb.origin);
  self.timerobject makeusable();
  assigninteractteam(scripts\mp\utility\teams::getenemyteams(var_0));
  var_4 = gettime();
  var_5 = int(var_4 + 5000);
  setomnvar("_encstr_8FB61105DB86CFFDAF50821AB9D17497B93EA7" + self.breachindex, var_5);
  setomnvar("_encstr_AAB815BA96D72D37CEC25BACAF472DB559C9FACAE68E7D" + self.breachindex, self.timerobject);
  var_6 = var_5 - var_4;

  while(!self.defused && var_6 > 0) {
    var_4 = gettime();
    var_6 = var_5 - var_4;

    if(var_6 < 1500) {
      if(var_6 <= 250)
        self.plantedbomb playSound("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E");
      else if(var_6 < 500)
        self.plantedbomb playSound("_encstr_9203179D930AEF7868B99B511AFED090C2BF152B6703B8AA74");
      else if(var_6 < 1500)
        self.plantedbomb playSound("_encstr_AA0317C813BDF9174A11040732424B40E70F7078D740F669C7");
      else
        self.plantedbomb playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");

      wait 0.25;
    } else if(var_6 < 3500) {
      self.plantedbomb playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");
      wait 0.5;
    } else {
      self.plantedbomb playSound("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF");
      wait 1.0;
    }

    if(var_6 < 0) {
      break;
    }
  }
}

usetriggerthink(var_0) {
  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\engine\utility::array_contains(self.interactteams, var_1.team)) {
      continue;
    }
    if(var_1 scripts\mp\utility\weapon::grenadeinpullback())
      return 0;

    if(var_1 meleeButtonPressed())
      return 0;

    if(var_1 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(!isDefined(self.plantedbomb)) {
      plantbreachc4(var_0, var_1);
      continue;
    }

    defusec4(var_1);
  }
}

#using_animtree("_encstr_B40101");

plantbreachc4(var_0, var_1) {
  thread watchplayerdeath(var_1);
  var_1.linktoent = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 playerlinktodelta(var_1.linktoent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0, 0);
  var_1.linktoent moveTo(self.scenenodes[var_0.scenenodekey].origin, 0.25, 0.1, 0.1);
  var_1.linktoent rotateTo(self.scenenodes[var_0.scenenodekey].angles, 0.25, 0.1, 0.1);
  var_1 setstance("_encstr_A5AD069B231F0BAF");

  if(!var_1 givegunless()) {
    var_1 unlink();
    var_1.linktoent delete();
    var_1.linktoent = undefined;
    return 0;
  }

  if(istrue(self.cancelplant))
    return 0;

  var_1 unlink();
  var_1.linktoent delete();
  var_1.linktoent = undefined;
  var_1 setOrigin(self.scenenodes[var_0.scenenodekey].origin);
  var_1 setplayerangles(self.scenenodes[var_0.scenenodekey].angles);

  foreach(var_3 in self.useobjects)
  var_3 hide();

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, "_encstr_AA45092A9BB0E33D20ED4C");
  var_5 = scripts\engine\utility::ter_op(var_1.team == "_encstr_9A8507BA4040188D08", "_encstr_8BE4053B1FD34F", "_encstr_918305A77EDB3B");

  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0")
    var_5 = scripts\engine\utility::ter_op(var_1.team == "_encstr_9A8507BA4040188D08", "_encstr_B2E40580875803", "_encstr_AA8305594B131B");

  var_1 queuedialogforplayer("_encstr_84690847F92EFD1A5F1F" + var_5 + "_encstr_AD500E0196C2F5D67758099340873818", "_encstr_8A2C11976F8A67C6A36FC7DAFB58EA8833AE28", 2);
  thread create_player_rig(var_1, "_encstr_A51B086302E74E1BADDA");
  var_1 thread scripts\mp\anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_A24E069389FFAA3C");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.scenenodes[var_0.scenenodekey].origin);
  var_6 setModel("_encstr_A3B30E856CADE209A050075FE07EC3EF");
  var_6.animname = "_encstr_8B07036CD0";
  var_6 useanimtree(#animtree);
  self.plantedbomb = var_6;
  self.plantedkey = var_0.scenenodekey;
  self.scenenodes[var_0.scenenodekey] thread scripts\common\anim::anim_single_solo(var_6, "_encstr_A24E069389FFAA3C");
  var_7 = getanimlength(level.scr_anim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"]);
  var_8 = 0.5;
  wait(var_7 - var_8);

  if(istrue(self.cancelplant))
    return 0;

  thread bomb_planted_think(var_0.scenenodekey, var_1);
  givebreachscore(var_1);
  wait(var_8 - 0.1);
  var_1 thread takegunless();
  remove_player_rig(var_1);
  process_action("_encstr_A29106F6B9EAE6B2");
  self notify("_encstr_874010B5023760D6C3A939A092FB19080B6D");
  return 1;
}

watchplayerdeath(var_0) {
  self endon("_encstr_874010B5023760D6C3A939A092FB19080B6D");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      foreach(var_2 in self.useobjects)
      var_2 show();

      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
        self.plantedkey = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

allowplayertobreach(var_0) {
  if(isDefined(level.breachusetriggers)) {
    foreach(var_2 in level.breachusetriggers)
    var_2 enableplayeruse(var_0);
  }
}

disallowplayertobreach(var_0) {
  if(isDefined(level.breachusetriggers)) {
    foreach(var_2 in level.breachusetriggers)
    var_2 disableplayeruse(var_0);
  }
}

defusec4(var_0) {
  self.defused = 1;
  self notify("_encstr_9A7B088CCA335D37CA91");
  givedefusescore(var_0);
}

onplayerjoinedteam(var_0) {
  foreach(var_2 in level.destructibles) {
    foreach(var_4 in var_2)
    var_4 applyinteractteam(var_0);
  }
}

assigninteractteam(var_0) {
  self.interactteams = var_0;

  foreach(var_2 in level.players)
  applyinteractteam(var_2);
}

applyinteractteam(var_0) {
  if(self.state == "_encstr_83320ADDB7DB01AB8F3FF8E8") {
    return;
  }
  if(!isDefined(self.useobjects)) {
    return;
  }
  if(scripts\engine\utility::array_contains(self.interactteams, var_0.team)) {
    if(isDefined(self.plantedbomb)) {
      self.timerobject hidefromplayer(var_0);

      foreach(var_3, var_2 in self.useobjects) {
        if(var_3 == self.plantedkey) {
          var_2 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
          var_2 enableplayeruse(var_0);
          var_2 showtoplayer(var_0);
          continue;
        }

        var_2 disableplayeruse(var_0);
        var_2 hidefromplayer(var_0);
      }

      return;
    }

    foreach(var_3, var_2 in self.useobjects) {
      var_2 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
      var_2 enableplayeruse(var_0);
      var_2 showtoplayer(var_0);
    }

    return;
  } else {
    if(isDefined(self.plantedbomb))
      self.timerobject showtoplayer(var_0);

    foreach(var_2 in self.useobjects) {
      var_2 disableplayeruse(var_0);
      var_2 hidefromplayer(var_0);
    }
  }
}

givebreachscore(var_0) {
  var_1 = "_encstr_BAD70791FB4F67C8D4";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
}

givedefusescore(var_0) {
  var_1 = "_encstr_A6530EFD4A6F389E8BD191B96AD74EC0";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
}

givegunless() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.gunnlessweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::allow_melee(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

takegunless() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  self.takinggunless = 1;
  scripts\common\utility::allow_weapon_switch(1);

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_melee(1);
}

rockable_cars_init() {
  waitframe();
  scripts\common\rockable_vehicles::rockable_cars_init();
  scripts\engine\utility::array_thread(level.rockablecars.cars, ::rockable_cars_watch_players);
}

rockable_cars_watch_players() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    foreach(var_1 in level.rockablecars.cars) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = [];

      foreach(var_4 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var_4)) {
          continue;
        }
        var_5 = var_4 getentitynumber();

        if(isDefined(var_1.players[var_5])) {
          continue;
        }
        if(var_4 ismantling()) {
          continue;
        }
        var_6 = var_4 getmovingplatformparent();

        if(!isDefined(var_6) || var_6 != var_1) {
          continue;
        }
        var_7 = var_4.origin - var_1.toppoint;

        if(vectordot(var_7, var_1.up) < 0) {
          continue;
        }
        var_8 = vectordot(var_7, var_1.forward);
        var_9 = abs(var_8);
        var_10 = var_9 / var_1.halflength;

        if(var_10 > 1) {
          continue;
        }
        var_11 = vectordot(var_7, var_1.right);
        var_12 = abs(var_11);
        var_13 = var_12 / var_1.halfwidth;

        if(var_13 > 1) {
          continue;
        }
        var_5 = var_4 getentitynumber();
        var_2[var_5] = var_4;
        var_1 rockable_car_rock(var_4, var_10, var_13, var_8, var_11);
      }

      foreach(var_5, var_4 in var_1.players) {
        var_16 = gettime() - var_1.touchtimes[var_5];

        if(!isDefined(var_4) || !scripts\mp\utility\player::isreallyalive(var_4)) {
          var_1 rockable_car_remove_player(var_5, undefined, 0);
          continue;
        }

        if(var_4 ismantling()) {
          var_1 rockable_car_remove_player(var_5, var_16, 1);
          continue;
        }

        var_6 = var_4 getmovingplatformparent();

        if(!isDefined(var_6) || var_6 != var_1) {
          var_1 rockable_car_remove_player(var_5, var_16, 1);
          continue;
        }

        var_7 = var_4.origin - var_1.toppoint;

        if(vectordot(var_7, var_1.up) < 0) {
          var_1 rockable_car_remove_player(var_5, var_16, 1);
          continue;
        }

        var_8 = vectordot(var_7, var_1.forward);
        var_9 = abs(var_8);
        var_10 = var_9 / var_1.halflength;

        if(var_10 > 1) {
          var_1 rockable_car_remove_player(var_5, var_16, 1);
          continue;
        }

        var_11 = vectordot(var_7, var_1.right);
        var_12 = abs(var_11);
        var_13 = var_12 / var_1.halfwidth;

        if(var_13 > 1) {
          var_1 rockable_car_remove_player(var_5, var_16, 1);
          continue;
        }

        var_1.touchtimes[var_5] = gettime();
      }

      foreach(var_5, var_4 in var_2)
      var_1 rockable_car_add_player(var_4);
    }

    waitframe();
  }
}

rockable_car_add_player(var_0) {
  var_1 = var_0 getentitynumber();
  self.players[var_1] = var_0;
  self.touchtimes[var_1] = gettime();
}

rockable_car_remove_player(var_0, var_1, var_2) {
  if(var_2) {
    if(isDefined(var_1) && var_1 >= 200) {
      self.players[var_0] = undefined;
      self.touchtimes[var_0] = undefined;
      self.rocktimes[var_0] = undefined;
      self.rockstrings[var_0] = undefined;
    }
  } else {
    self.players[var_0] = undefined;
    self.touchtimes[var_0] = undefined;
    self.rocktimes[var_0] = undefined;
    self.rockstrings[var_0] = undefined;
  }
}

rockable_car_rock(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 > 0.3 && var_2 > 0) {
    var_5 = scripts\engine\utility::ter_op(var_3 >= 0, "_encstr_AA5606FD1AF05085", "_encstr_B69B0589C236B6");
    var_6 = scripts\engine\utility::ter_op(var_4 >= 0, "_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63");
    self setscriptablepartstate("_encstr_8CED155BB68CB8608B02919AFA6B3E28261EA9F52FF640", var_5 + "_encstr_BA4C02DF" + var_6, 0);
    var_7 = var_0 getentitynumber();
    self.rocktimes[var_7] = gettime();
    self.rockstrings[var_7] = var_5 + var_6;
  }
}