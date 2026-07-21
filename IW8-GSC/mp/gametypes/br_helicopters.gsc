/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_helicopters.gsc
***********************************************/

setuphalodropplayer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_972A0CB116378D2BD8BE43B21B2D");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.playerlinkent = var_1;
  self.playerstartpos = var_0.origin;

  if(istrue(var_0.isbombcarrier))
    level.bombdroploc = self.playerstartpos;

  var_1 playLoopSound("_encstr_91911D1BD14BFFDE0853FBC86349646FE168C3435B95BF9499BBFDCA7FB86A");
  var_1 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", self.playeroffsets[self.playerslots.size], (0, 90, 0));
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 setCanDamage(0);
  var_0 cancelmantle();
  var_0 playerlinktodelta(var_1, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 40, 40, -5, 70, 0);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 notifyonplayercommand("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_B44609DFE707CF394E1651");
  var_0 thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::listenjump(self, 1);
  var_0 thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::listenkick(self, 1);
}

spawnplayertohelicam(var_0) {
  var_0.angles = self.angles;
  var_0 thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::listenjump(self, 1);
  var_0 thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::listenkick(self, 1);
  var_0.br_infil_type = "_encstr_B6CC0586B28D96";
  var_0 thread orbitcam(self);
}

orbitcam(var_0) {
  var_1 = 450;
  var_2 = (-5, 0, 0);
  var_3 = anglesToForward(var_2) * var_1 * -1;
  var_0.br_vieworigin = var_3 + (150, 150, 0);
  self.angles = var_0.angles;
  self playerlinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerhide();

  if(isDefined(level._id_142D1))
    scripts\mp\utility\player::_visionsetnaked(level._id_142D1, 0);
  else
    scripts\mp\utility\player::_visionsetnaked("_encstr_B40101", 0);

  if(isDefined(self.br_orbitcam))
    self.br_orbitcam delete();

  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_4 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_4 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 50), (0, 0, 0));
  self.br_orbitcam = var_4;
  self cameraset("_encstr_B8CB169FD3B95A7A08162EB38B78BF1218775303AB5DA172");
}

forceejectall() {
  foreach(var_1 in level.players) {
    var_1 notify("_encstr_AB180A802B88358FC253D20B");
    var_1 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
  }
}

jumplistener(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8F7D08C66A0125438523");
  scripts\common\utility::allow_melee(0);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  self notifyonplayercommand("_encstr_AB180A802B88358FC253D20B", "_encstr_B44609DFE707CF394E1651");
  self waittill("_encstr_AB180A802B88358FC253D20B");
  var_2 = self getplayerangles();
  var_3 = var_0 getfirstopenjumporigin();
  var_4 = anglestoleft(var_0.angles);
  var_5 = var_3.origin + var_4 * 200;
  var_6 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07"]);
  var_7 = (0, 0, 0);
  var_8 = physics_raycast(var_5, var_5 + (0, 0, -20000), var_6, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_9 = var_8[0]["_encstr_BD260953AA97E3F014279D"];
    var_7 = getclosestpointonnavmesh(var_9);
  } else
    iprintln("_encstr_8A421F496E9967B9EF6E3C31BCD7B37FEA7E1F53DC6719F53F4EB5E339354EF788");

  self unlink();
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_10.angles = self.angles;
  var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerlinkTo(var_10);
  var_10 moveTo(var_7 + (0, 0, 24), var_1, 0, 1.0);
  self playerlinkTo(var_10);
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 300));
  var_11 setModel("_encstr_B483150653B887D37F2D4737611DDBF5797B7D0E6A1852");
  var_11 notsolid();
  childthread parachuteupdater(var_11);
  wait(var_1 - 0.333);
  self unlink();
  var_0.playerslots = scripts\engine\utility::array_remove(var_0.playerslots, self);
  self setCanDamage(1);
  scripts\common\utility::allow_usability(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\mp\utility\player::enableplayerforspawnlogic(1);
  scripts\common\utility::allow_melee(1);

  if(isDefined(var_0))
    var_0 jumpdone();
}

parachuteupdater(var_0) {
  for(;;) {
    if(self isonground() || !isalive(self)) {
      self.br_fallaccel = (0, 0, 0);
      var_0 delete();
      break;
    } else {
      var_0.angles = self.angles;
      var_0.origin = self.origin + (0, 0, 360);
    }

    waitframe();
  }
}

spawnheli(var_0, var_1) {
  var_2 = "_encstr_B88607820996877650";
  var_3 = fakestreakinfo();
  var_4 = "_encstr_97B21A67CAA1D74C8D4BB585FAD957DC73B2C9F51C4EF647DEEBB638";
  var_5 = "_encstr_AF72271EB5F8995997CA037049C0BBD78A85E10DDFC907674AE603E8C8FB43CA0D280A6152427ACDB5";
  var_6 = 1500;
  var_7 = spawnVehicle(var_5, "_encstr_B4980F4CE4F56EE02CEECDF50D59362DFA" + var_0, var_4, var_1, (0, -90, 0));
  var_7.streakinfo = var_3;
  var_7 vehicle_setspeed(30, 15, 5);
  var_7 notsolid(0);
  var_7 setCanDamage(0);
  var_7 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9");
  var_7 playLoopSound("_encstr_AB08131B899C85CEB7F59537CE4B7395D7344B760D");
  var_7.health = var_6;
  var_7.targetpos = level.mapcenter;
  var_7.targetent = undefined;
  var_7.team = "_encstr_9A8507BA4040188D08";
  var_7.dying = 0;
  var_7.leaving = 0;
  var_7.queuetokens = 0;
  var_7.playerslots = [];
  var_7.playeroffsets = [(32, 30, -135), (-32, 30, -135), (0, 30, -135), (16, 30, -135), (-16, 30, -135)];
  var_7.jumpslots = [];

  for(var_8 = 0; var_8 < 10; var_8++)
    var_7.jumpslots[var_8] = 0;

  return var_7;
}

getfirstopenjumporigin() {
  if(!isDefined(self.jumpslots))
    return self.trail[0];

  for(var_0 = 0; var_0 < 10; var_0++) {
    if(self.jumpslots[var_0] == 0) {
      self.jumpslots[var_0] = 1;
      return self.trail[var_0];
    }
  }

  return self.trail[9];
}

helipathmemory() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.trail = [];

  for(var_0 = 0; var_0 < 10; var_0++) {
    var_1 = spawnStruct();
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    self.trail[var_0] = var_1;
  }

  for(;;) {
    for(var_0 = 9; var_0 > 0; var_0--) {
      self.trail[var_0].origin = self.trail[var_0 - 1].origin;
      self.trail[var_0].angles = self.trail[var_0 - 1].angles;
      self.jumpslots[var_0] = self.jumpslots[var_0 - 1];
    }

    self.trail[0].origin = self.origin;
    self.trail[0].angles = self.angles;
    self.jumpslots[0] = 0;
    wait 1.0;
  }
}

fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "_encstr_AD56169FC186E14B0B222E10A9B28BA3D38FD76FE2A17735";
  var_0.streakname = "_encstr_B88607820996877650";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  var_0.hits = 0;
  return var_0;
}

ishelicopterfull(var_0) {
  return var_0.playerslots.size == 10;
}

sorthelosize(var_0, var_1) {
  return var_0.playerslots.size < var_1.playerslots.size;
}

getnexthelicopterwithroom(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.br_helicopters) {
      if(isDefined(var_2.spawnteam) && var_2.spawnteam == var_0 && !ishelicopterfull(var_2))
        return var_2;
    }

    foreach(var_2 in level.br_helicopters) {
      if(!isDefined(var_2.spawnteam)) {
        var_2.spawnteam = var_0;
        return var_2;
      }
    }
  } else {
    var_6 = scripts\engine\utility::array_sort_with_func(level.br_helicopters, ::sorthelosize);

    foreach(var_8 in var_6) {
      if(!ishelicopterfull(var_8))
        return var_8;
    }
  }

  return undefined;
}

kickanyremainingplayers() {
  foreach(var_1 in self.playerslots) {
    if(isDefined(var_1) && isDefined(var_1.br_infil_type) && var_1.br_infil_type == "_encstr_B6CC0586B28D96") {
      var_1 cameradefault();
      var_1 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }
}

exitandcleanup() {
  self endon("_encstr_AD75063D571AE108");
  level notify("_encstr_8AA60DD065664831F9A3C7E787620D");
  kickanyremainingplayers();
  self notify("_encstr_91470BFDC7EA03A260112BB371");
  self.leaving = 1;
  var_0 = getEnt("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.origin[2];
  var_2 = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  var_3 = self.origin - var_2;
  var_3 = (var_3[0], var_3[1], 0);
  var_4 = vectorNormalize(var_3);
  var_5 = self.origin + var_4 * 10000 + (0, 0, 1) * var_1;
  var_6 = 150;
  var_7 = 50;
  var_8 = 350;
  self vehicle_setspeed(var_6, var_7, var_7);
  self setvehgoalpos(var_5, 0);
  self setneargoalnotifydist(var_8);
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  self delete();
}

jumpdone() {
  foreach(var_1 in level.br_helicopters) {
    if(isDefined(var_1) && var_1.playerslots.size == 0)
      var_1 thread exitandcleanup();
  }
}