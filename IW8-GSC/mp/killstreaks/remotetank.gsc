/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\remotetank.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_B1B30B51D176511E377A1BC313", ::tryuseremotetankfromstruct);
  level.tanksettings = [];
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"] = spawnStruct();
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].timeout = 60.0;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].maxhealth = 3000;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].hitstokill = 10;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].streakname = "_encstr_B1B30B51D176511E377A1BC313";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].modelbase = "_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].modelbasealt = "_encstr_BE60197393DBEB2F50DA9D27AD609F87204017E5D573216D879BA3";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].modeldestroyed = "_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].mgturretmodelbase = "_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].mgturretmodelbasealt = "_encstr_9A012030D29CF96627F1A908DC03496F036A80A84A35FFDBBFF2AE1DBC9F51DBEA13";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].mgturretinfo = "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].sentrymodeon = "_encstr_849007B268BD03DFD8";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].vehicleinfo = "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].stringcannotplace = &"_encstr_8FBF20B8242923C2B9856D71AFD9997BC3BCC161CD17F34D89A17F7BD30995DF1B14";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].scorepopup = "_encstr_99B31528D8CBCCDB2878F291A13B21683010A506257D8B";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].vodestroyed = "_encstr_99B31528D8CBCCDB2878F291A13B21683010A506257D8B";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].destroyedsplash = "_encstr_A9F01D6C858D8DEDABE8BE91956E8EE4DEE5B232F507C2D8AFCD9537D13997";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].premoddamagefunc = undefined;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].postmoddamagefunc = ::tank_modifydamageresponse;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].deathfunc = ::tank_destroycallback;
  level._effect["_encstr_9B1314A28D9BB23CE1A98BE71818DFDA699FAD1DE523"] = loadfx("_encstr_8B4731AB01F36E8C6091B79D197AD4BF11B873132BC50F44CA258680AF905CF7CD108B2A30B0D33F8059B05FE3906212ECC9B3");
  level._effect["_encstr_911B18420202E56B1149895298AA9FB1D2794B378DD2673A04FB"] = loadfx("_encstr_A7B336D5A3BBA8083F40BEF07A5F2033521357291BB247500FAB816AA9EFF07DBABBCF97D3791DD88B03AEE1CFA14823B1E75131BA535458");
  level._effect["_encstr_B1C31A932BDABD47B2FA1D2C376DF5C6C9B0A359BE2B0FE0B1BD1995"] = loadfx("_encstr_92B62FEC99C35ED2EE07D7AD0EF2D6968DD8DC8E93AC2C5B5ED9660FAFBB0DAC95B1DCBDE6F595F038F596DA83E29D99F0");
  level.remote_tank_armor_bulletdamage = 0.5;
  initmines();
  init_pac_sentry_vo();
  level.incomingallremotetanks = 0;
  level.incomingremotetanks["_encstr_9A8507BA4040188D08"] = 0;
  level.incomingremotetanks["_encstr_8E8405EA382B2A"] = 0;
  level.remotetanks = [];

  foreach(var_1 in level.tanksettings) {
    if(isDefined(var_1.hitstokill))
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_1.streakname, var_1.hitstokill);
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_setclearancecheckminradius("_encstr_B1B30B51D176511E377A1BC313", 32);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1, "_encstr_B1B30B51D176511E377A1BC313");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_B1B30B51D176511E377A1BC313", 18, "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 1, "_encstr_B1B30B51D176511E377A1BC313");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_B1B30B51D176511E377A1BC313", 7, "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 1, "_encstr_B1B30B51D176511E377A1BC313");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_B1B30B51D176511E377A1BC313", 25, "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 1, "_encstr_B1B30B51D176511E377A1BC313");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_B1B30B51D176511E377A1BC313", 8, "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1, "_encstr_B1B30B51D176511E377A1BC313");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_B1B30B51D176511E377A1BC313", 15, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("_encstr_9AAE0876FCB7603101DB", 5, "_encstr_B1B30B51D176511E377A1BC313");
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_B1B30B51D176511E377A1BC313", "_encstr_8D8614ABD34CABA0179F79F05347138E7817BC9E8F60", 11);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_B1B30B51D176511E377A1BC313", "_encstr_B677146431933389B16B58E8B355454E13B5FD709FBB", 12);
}

initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_B1B30B51D176511E377A1BC313", 1);
  var_0.frontextents = 32;
  var_0.backextents = 32;
  var_0.leftextents = 22;
  var_0.rightextents = 22;
  var_0.bottomextents = 10;
  var_0.distancetobottom = 20;
}

init_pac_sentry_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A51D1863D2E67F6BADC6398E20D975C92B3B18A4207828C8B3C8"] = "_encstr_A51D1863D2E67F6BADC6398E20D975C92B3B18A4207828C8B3C8";
}

weapongivenremotetank(var_0) {
  return 1;
}

deployweapontaken(var_0) {
  self notify("_encstr_A5B117CF7820397B738BAB4FE1AD136480C2091311A0E87258");
}

tryuseremotetank() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B1B30B51D176511E377A1BC313", self);
  return tryuseremotetankfromstruct(var_0);
}

tryuseremotetankfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_993A1BAE9B95AF6D5A631BB9E839CA2CD6EB324EB773ACCDB2E63A39F2");
  var_1 = getcompleteweaponname("_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::weapongivenremotetank, undefined, undefined, ::deployweapontaken);

  if(!istrue(var_2))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    scripts\mp\hud_message::showerrormessage(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    return 0;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_3 = 1;

  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level.incomingallremotetanks++;
  var_4 = 2;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    var_4 = 4;

  if(level.remotetanks.size >= var_4 || level.remotetanks.size + level.incomingallremotetanks > var_4) {
    scripts\mp\hud_message::showerrormessage("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    level.incomingallremotetanks--;
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(level.teambased) {
    var_5 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap())
      var_5 = 2;

    level.incomingremotetanks[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.remotetanks) + level.incomingremotetanks[self.team] > var_5) {
      level.incomingallremotetanks--;
      level.incomingremotetanks[self.team]--;
      scripts\mp\hud_message::showerrormessage("_encstr_A99F22694A89264DA8A4A282A5D4976A140BAF234A942A722298B2D7AE90545189D4A727");
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  var_6 = starttankdropoff(var_0);
  level.incomingallremotetanks--;

  if(level.teambased)
    level.incomingremotetanks[self.team]--;

  if(!istrue(var_6)) {
    scripts\mp\hud_message::showerrormessage("_encstr_BE361D694AC4269A8A94A2145A35E5C99EA2EB1527D355E884F56A41281A51");
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return 0;
  }

  return 1;
}

getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

getpathend(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

starttankdropoff(var_0) {
  self disablephysicaldepthoffieldscripting();
  var_1 = tank_findsafespawn(100);

  if(!isDefined(var_1)) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  var_3 = getdvarint("_encstr_9BDE1A765F3316982187215BFD409443E2CF9F50026D2E08874B5743", 1);
  var_4 = undefined;
  var_5 = undefined;

  if(!var_3) {
    var_6 = scripts\engine\utility::drop_to_ground(var_1, 50, -200, (0, 0, 1));
    var_6 = var_6 + (0, 0, 1);
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
    var_5 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
    var_5.angles = (0, 90, 90);
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
    var_4 setModel("_encstr_B231139B17092E334F8B5AE1B097FBE460BD371569");
    var_4 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);
    var_5 playSound("_encstr_A1DB181723F232B3C8616B97F3BEFCE85F639820B0B7F7232197");
  }

  self.restoreangles = self getplayerangles();
  scripts\mp\utility\player::_freezecontrols(1);
  scripts\common\utility::allow_fire(0);
  var_3 = getdvarint("_encstr_9BDE1A765F3316982187215BFD409443E2CF9F50026D2E08874B5743", 0);

  if(!var_3) {
    var_7 = self.angles[1];
    var_8 = var_1 * (1, 1, 0) + (0, 0, 850);
    var_9 = getpathstart(var_8, var_7);
    var_10 = getpathend(var_8, var_7);
    var_8 = var_8 + anglesToForward((0, var_7, 0)) * -50;
    var_11 = createdropoffheli(self, var_9, var_8);
    var_11.droptype = "_encstr_B1B30B51D176511E377A1BC313";
    var_11 setvehgoalpos(var_8, 1);
    var_11 thread tank_finishdropoffsequence(self, var_1, var_10, var_0, var_4, var_5);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_12 = createtank("_encstr_A3AC0C1A9D50B2D162C0E3B0C28A", self, var_0, var_1, undefined, var_3);

    if(!isDefined(var_12)) {
      scripts\mp\utility\killstreak::decrementfauxvehiclecount();
      scripts\mp\utility\player::_freezecontrols(0);
      scripts\common\utility::allow_fire(1);
      return 0;
    }

    scripts\common\utility::allow_fire(1);
    thread startusingtank(var_12, var_3);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1);
  scripts\common\utility::_id_13E0A(level._id_11B2A, "_encstr_B1B30B51D176511E377A1BC313", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_96C110A3683BF797EB6FBB8F7E110BBB7D40", self);
  return 1;
}

createdropoffheli(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = "_encstr_82930F3B09E0FF8A23751B4BA7579135C8";
  var_5 = spawnhelicopter(var_0, var_1, var_3, var_4, "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A");

  if(!isDefined(var_5)) {
    return;
  }
  var_5 playLoopSound("_encstr_91911D1BD14BFFDE0853FBC86349646FE168C3435B95BF9499BBFDCA7FB86A");
  var_5.maxhealth = 500;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.isairdrop = 1;
  var_5 setmaxpitchroll(15, 15);
  var_5 vehicle_setspeed(250, 175);
  var_5.helitype = "_encstr_BA67082278D537E3C827";
  var_5.boxmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin - (0, 0, 100));
  var_5.boxmodel setModel("_encstr_A1E31A0D7F18FA672A9081697070A7B98C7447DB20A0771808975468");
  var_5.boxmodel.angles = var_5.angles;
  var_5.boxmodel linkTo(var_5);
  var_5.intromodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.boxmodel.origin);
  var_5.intromodel setModel("_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1");
  var_5.intromodel.angles = var_5.boxmodel.angles;
  var_5.intromodel.owner = var_5.owner;
  var_5.intromodel linkTo(var_5.boxmodel);
  var_5.turretmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.intromodel gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"));
  var_5.turretmodel setModel("_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133");
  var_5.turretmodel.angles = var_5.intromodel.angles;
  var_5.turretmodel setotherent(var_5.owner);
  var_5.turretmodel linkTo(var_5.intromodel);
  var_5.owner playerlinkweaponviewtodelta(var_5.turretmodel, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
  var_5.owner playerlinkedsetviewznear(0);
  var_5.intromodel scriptmodelplayanim("_encstr_87FE17C8A37147A027DD897EBF630E3962FA98D1AAD5893B37");
  var_5.owner setclientomnvar("_encstr_A72E17BAA5F50EB036EBB92B9BD19C2FBE8DDB731D4E7BC6CD", 1);
  var_5.owner setclientomnvar("_encstr_88171447D87EE88A670872EF8821F3990660CB8F2BB1", 0);
  var_5.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", 3000);
  var_5 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("_encstr_B1B30B51D176511E377A1BC313");
  var_5 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_5.helitype, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 100);
  var_5 thread tank_handlehelidamage();
  return var_5;
}

createtank(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.tanksettings[var_0];
  var_7 = var_1.angles;

  if(isDefined(var_4))
    var_7 = var_4.angles;

  var_8 = spawnStruct();
  var_8.origin = var_3;
  var_8.angles = var_7;
  var_8.modelname = var_6.modelbase;
  var_9 = scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_1);

  if(var_9)
    var_8.modelname = var_6.modelbasealt;

  var_8.targetname = var_0;
  var_8.vehicletype = var_6.vehicleinfo;
  var_8.owner = var_1;
  var_8.cannotbesuspended = 1;
  var_10 = spawnStruct();
  var_11 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_8, var_10);

  if(!isDefined(var_11))
    return undefined;

  var_12 = getdvarint("_encstr_96EF189B1BC9D738586CF537CA9BA3E497D78DB43359E8D2B5CA", var_6.timeout);
  var_11.team = var_1.team;
  var_11.owner = var_1;
  var_11.streakinfo = var_2;
  var_11.tanktype = var_0;
  var_11.config = var_6;
  var_11.maxhealth = var_6.maxhealth;
  var_11.health = var_11.maxhealth;
  var_11.lifetime = var_12;
  var_11.superfaction = var_9;
  var_11.currentdamagestate = 0;
  var_11.objweapon = getcompleteweaponname(var_6.mgturretinfo);
  var_11 setotherent(var_1);
  var_11 setvehicleteam(var_11.team);
  var_11 scripts\mp\sentientpoolmanager::registersentient("_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", var_1);
  var_11 scripts\mp\utility\killstreak::killstreak_make_vehicle(var_2.streakname, var_6.scorepopup, var_6.vodestroyed, undefined, var_6.destroyedsplash);
  var_11 scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback(var_2.streakname, var_6.premoddamagefunc);
  var_11 scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback(var_2.streakname, var_6.postmoddamagefunc);
  var_11 scripts\mp\utility\killstreak::killstreak_set_death_callback(var_2.streakname, var_6.deathfunc);
  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var_11, ::tank_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var_11, ::tank_lockedonremovedcallback);
  var_11.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11 gettagorigin("_encstr_8F1E092CC9F71178C01941"));
  var_11.useobj linkTo(var_11, "_encstr_8F1E092CC9F71178C01941");
  var_14 = var_11 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_15 = var_6.mgturretmodelbase;

  if(var_9)
    var_15 = var_6.mgturretmodelbasealt;

  var_16 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_14, var_6.mgturretinfo, 0);
  var_16 linkTo(var_11, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_16 setModel(var_15);
  var_16.owner = var_1;
  var_16.angles = var_11.angles;
  var_16.tank = var_11;
  var_16 makeusable();
  var_16 setdefaultdroppitch(0);
  var_16 setmode("_encstr_849007B268BD03DFD8");
  var_16 setotherent(var_1);
  var_11 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var_11.mgturret = var_16;

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    var_11.mgturret setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_AB0703DBB9");

  var_11 thread tank_watchfortimeoutdisowned();
  var_11 thread _id_13A50();
  var_11 thread _id_13A51();
  var_11 thread tank_handleairburst();
  var_11 thread tank_handlewheeldustfx();
  var_11 thread tank_updatehudchassisangles();
  var_11 thread tank_updatehudviewstate();
  var_11 thread wheelson_enginesfx();
  var_11.childoutlineents = [var_11, var_16];

  if(istrue(var_5)) {
    var_17 = 1;
    var_18 = "_encstr_8D8614ABD34CABA0179F79F05347138E7817BC9E8F60";

    if(isDefined(var_1.previousremotetankviewstate)) {
      var_17 = var_1.previousremotetankviewstate;

      if(var_18 == 2)
        var_18 = "_encstr_B677146431933389B16B58E8B355454E13B5FD709FBB";
    }

    var_1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_11.streakinfo.streakname, var_18);
    var_1 setclientomnvar("_encstr_A72E17BAA5F50EB036EBB92B9BD19C2FBE8DDB731D4E7BC6CD", var_17);
    var_1 setclientomnvar("_encstr_88171447D87EE88A670872EF8821F3990660CB8F2BB1", 0);
    var_1 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", 3000);
    scripts\mp\outofbounds::registerentforoob(var_11, "_encstr_85CE0B9770B02C73A1760F06D2");
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_11, var_1, var_1.team);
  level.remotetanks[level.remotetanks.size] = var_11;
  var_11 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_2.streakname, "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", var_1, 0, 1, 60);
  level notify("_encstr_823524DA0BA31B86E4951BBDE4195A739DAF37ADC2B1637D9D27DED5378CAFB3CA1A966CB1AC", var_11);
  return var_11;
}

tank_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A51D1863D2E67F6BADC6398E20D975C92B3B18A4207828C8B3C8");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

tank_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

tank_finishdropoffsequence(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_8B7205D9ED5958");
  self setyawspeed(40, 20, 20, 0.3);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self notify("_encstr_8FA80BC4586F72611BBBCE631F");
  self.boxmodel unlink();
  self.boxmodel moveTo(var_1, 1.5, 1);
  self.intromodel scriptmodelplayanim("_encstr_885D19DA38AFDDD0CA5936E6DEB9BE239CED1CEB9CB2C6AC2CE659");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self.intromodel scriptmodelplayanim("_encstr_91FA16B6C17DBB34562BB19BED73D73227ED38F58DB073C8");
  earthquake(0.3, 0.1, self.intromodel.origin, 400);
  playrumbleonposition("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", self.intromodel.origin);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.7);
  var_6 = self.turretmodel gettagorigin("_encstr_8E010B996FB7B6B3C1D1183343");
  var_7 = self.turretmodel.angles;
  var_8 = var_6 - anglesToForward(var_7) * 100;
  var_9 = var_7;
  playFX(scripts\engine\utility::getfx("_encstr_B1C31A932BDABD47B2FA1D2C376DF5C6C9B0A359BE2B0FE0B1BD1995"), self.intromodel.origin);
  earthquake(0.3, 0.1, self.intromodel.origin, 400);
  playrumbleonposition("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB", self.intromodel.origin);
  self.boxmodel delete();
  self.intromodel delete();
  self.turretmodel delete();
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_10 = createtank("_encstr_A3AC0C1A9D50B2D162C0E3B0C28A", var_0, var_3, var_1, self);

  if(!isDefined(var_10)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    var_0 scripts\mp\utility\player::_freezecontrols(0);
    var_0 scripts\common\utility::allow_fire(1);
    return 0;
  }

  var_10 tank_playercameratransition(var_6, var_7, var_8, var_9);
  var_0 scripts\common\utility::allow_fire(1);
  var_0 thread startusingtank(var_10);
  self setvehgoalpos(var_2, 1);
  self.leaving = 1;
  self waittill("_encstr_8B7205D9ED5958");
  self delete();
  var_4 delete();
  var_5 delete();
}

tank_playercameratransition(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner unlink();
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_4.owner = self.owner;
  var_4.angles = var_1;
  self.owner playerlinkweaponviewtodelta(var_4, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  self.owner visionsetkillstreakforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  var_2 = var_2 + (0, 0, 20);
  var_3 = vectortoangles(var_0 - var_2);
  var_4 moveTo(var_2, 0.5);
  var_4 rotateTo(var_3, 0.5);
  self.owner thread tank_startfadetransition();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  self.owner visionsetkillstreakforplayer("_encstr_B40101", 0.2);
  self.owner unlink();
  var_4 delete();
}

tank_startfadetransition() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.5);
  wait 0.5;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

tank_turrethandleuse(var_0) {
  self endon("_encstr_AD75063D571AE108");
  tank_disableturretuseforenemies(var_0);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    var_1 setplayerangles(var_0.angles);
    var_1 playerlinkTo(self, "_encstr_A21B0F472CECFA83D8C297B2934ED28CCA");
    var_1 thread tank_watchstopuseturret(var_0, self);
  }
}

tank_disableturretuseforenemies(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.team) && var_2.team == self.team) {
      continue;
    }
    var_2 disableplayeruse();
  }

  thread tank_disableturretforfutureenemies(var_0);
}

tank_disableturretforfutureenemies(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_1);

    if(isDefined(var_1.team) && var_1.team == self.team) {
      var_0 enableplayeruse(var_1);
      continue;
    }

    var_0 disableplayeruse(var_1);
  }
}

tank_watchstopuseturret(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  while(isDefined(var_0) && self isusingturret())
    waitframe();

  var_2 = tank_findsafedetach(var_1);
  self unlink();
  self dontinterpolate();
  self.origin = var_2;
  self.angles = var_0.angles;
  self notify("_encstr_93B3128817C6091FCB4A3BB0A78181F3228B1880");
}

tank_findsafedetach(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_2 * 100;
  var_5 = var_0.origin - var_2 * 100;
  var_6 = var_0.origin + var_3 * 100;
  var_7 = var_0.origin - var_3 * 100;
  var_8 = [var_5, var_6, var_7, var_4];

  foreach(var_11, var_10 in var_8) {
    if(capsuletracepassed(var_10, 40, 80, var_0, 0, 1)) {
      var_1 = var_10;
      break;
    }
  }

  return var_1;
}

startusingtank(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  var_2 = spawnStruct();
  var_2.playdeathfx = 1;
  var_2.deathoverridecallback = ::tank_override_moving_platform_death;
  var_0 thread scripts\mp\movers::handle_moving_platforms(var_2);
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0.driver = self;

  if(istrue(var_1))
    self unlink();

  self controlslinkTo(var_0);
  self remotecontrolturret(var_0.mgturret);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(var_0.lifetime * 1000));
  self setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", var_0.health / var_0.maxhealth);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  scripts\common\utility::allow_shellshock(0);
  scripts\mp\outofbounds::registerentforoob(var_0, "_encstr_85CE0B9770B02C73A1760F06D2");
  var_0 thread tank_earthquake();
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit("_encstr_AD75063D571AE108");
  scripts\mp\utility\player::enableplayerforspawnlogic(0, "_encstr_99300BBDCF8AE8C00D7B59B05C");
  scripts\mp\spawnlogic::addspawnviewer(var_0);
  var_0 scripts\cp_mp\emp_debuff::set_start_emp_callback(::tank_empstarted);
  var_0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::tank_empcleared);
  scripts\mp\utility\player::_freezecontrols(0);
}

tank_handlehelidamage() {
  self endon("_encstr_AD75063D571AE108");
  scripts\mp\damage::monitordamage(self.maxhealth, "_encstr_B40101", ::tank_handlehelideathdamage, ::tank_modifyhelidamage, 1);
}

tank_modifyhelidamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 1, 1, 1);
  return var_6;
}

tank_handlehelideathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(self.intromodel))
    self.intromodel delete();

  self notify("_encstr_AD75063D571AE108");
}

tank_modifydamageresponse(var_0) {
  thread tank_modifydamagestate(var_0);
  var_1 = var_0.damage;
  var_2 = var_0.meansofdeath;

  if(isDefined(self.owner) && self.owner scripts\mp\utility\player::isusingremote()) {
    if(isexplosivedamagemod(var_2)) {
      if(ceil(var_1 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.mgturret.origin, 150);
        self.owner playrumbleonpositionforclient("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB", self.owner getEye());
      }
    } else {
      self.owner earthquakeforplayer(0.15, 0.15, self.mgturret.origin, 150);
      self.owner playrumbleonpositionforclient("_encstr_B14F0D7B2B51F287F03ED59C51F0DC", self.owner getEye());
    }
  }

  return 1;
}

tank_modifydamagestate(var_0) {
  var_1 = var_0.damage;
  self.currenthealth = self.health - var_1;

  if(self.currenthealth <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
  } else if(self.currenthealth <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
  } else if(self.currenthealth <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
    self.mgturret setscriptablepartstate("_encstr_ABA50E1D5793E4CA3AFAC816D6583BCA", "_encstr_AB0703DBB9");
  }

  self.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.currenthealth / self.maxhealth);
  return 1;
}

tank_override_moving_platform_death(var_0) {
  thread tank_destroy();
}

tank_watchfortimeoutdisowned() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  tank_watchfortimeoutdisownedendearly();
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_BAF413D12D5B59DBBAE8EB07166CEB6EACE63A392F", 1);
  thread tank_destroy();
}

tank_watchfortimeoutdisownedendearly() {
  self endon("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self.owner endon("_encstr_835E111B0F57AAF772B2857B91972DCBC070DA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

_id_13A50() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread tank_destroy();
}

_id_13A51() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\cp_mp\vehicles\vehicle::_id_14103(self);
    waitframe();
  }
}

tank_destroy(var_0, var_1) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  self notify("_encstr_AD75063D571AE108");
  self.mgturret notify("_encstr_AD75063D571AE108");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(!isDefined(var_0))
    var_0 = self.owner;

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);

  if(isDefined(self.driver))
    thread tank_driverexit(self.driver);

  self.useobj delete();
  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  self.mgturret setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  removefromugvlist(self getentitynumber());
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\outofbounds::clearoob(self, 1);
  self.streakinfo.onspray = istrue(var_1);
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  waitframe();
  self playSound("_encstr_BDA11887DF79028B02DCD893ABE0B00820224FFB209A10D80E4B");
  var_2 = level._effect["_encstr_9B1314A28D9BB23CE1A98BE71818DFDA699FAD1DE523"];

  if(self.superfaction)
    var_2 = level._effect["_encstr_911B18420202E56B1149895298AA9FB1D2794B378DD2673A04FB"];

  playFX(var_2, self.origin);
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self.mgturret setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_BA19049F4B2D");
  self.mgturret delete();
  level.remotetanks = scripts\engine\utility::array_remove(level.remotetanks, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

tank_destroycallback(var_0) {
  thread tank_destroy(var_0.attacker, 1);
  return 0;
}

tank_driverexit(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  tank_lockedonremovedcallback();
  self.driver = undefined;
  var_0 controlsunlink();

  if(isDefined(self.mgturret))
    var_0 remotecontrolturretoff(self.mgturret);

  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_BA19049F4B2D");
  var_0 setclientomnvar("_encstr_A72E17BAA5F50EB036EBB92B9BD19C2FBE8DDB731D4E7BC6CD", 0);

  if(var_0 scripts\mp\utility\player::isusingremote())
    self.streakinfo notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  var_0 painvisionon();
  var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  var_0 scripts\mp\utility\player::enableplayerforspawnlogic(1, "_encstr_99300BBDCF8AE8C00D7B59B05C");
  scripts\mp\spawnlogic::removespawnviewer(self);

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\common\utility::allow_shellshock(1);
    level thread scripts\cp_mp\utility\killstreak_utility::_id_12CC6(var_0);
  }
}

tank_riderexit(var_0, var_1) {
  var_0 unlink();
}

tank_handleairburst() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.mgturret waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0);
    var_0.owner = self.owner;
    var_0.streakinfo = self.streakinfo;
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_1 setModel("_encstr_B8B311442EAFD80639DFE3529D08BA4A110A4B");
    var_1.angles = var_0.angles;
    var_1.team = self.team;
    var_1.owner = self.owner;
    var_1.streakinfo = self.streakinfo;
    var_1 setentityowner(self.owner);
    var_1 dontinterpolate();
    self.streakinfo.shots_fired++;
    tank_findclosestairbursttarget(var_0, var_1);
  }
}

tank_findclosestairbursttarget(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_0.origin;
  var_4 = var_3 + var_2 * 22500;
  var_5 = [var_0, var_1, self.owner];
  var_6 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0, 0);
  var_7 = scripts\engine\trace::sphere_trace_get_all_results(var_3, var_4, 60, var_5, var_6);
  var_8 = 0;

  if(isDefined(var_7[0])) {
    for(var_9 = 0; var_9 < var_7.size - 1; var_9++) {
      var_10 = var_7[var_9]["_encstr_850E077B0BF30318B9"];
      var_11 = var_7[var_9]["_encstr_BD260953AA97E3F014279D"];
      var_12 = var_7[var_9]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];

      if(isDefined(var_10)) {
        if(level.teambased) {
          if(var_10.team == var_1.team)
            continue;
        }

        if(!scripts\engine\trace::ray_trace_passed(var_12, var_11, var_1))
          continue;
      }

      var_8 = 1;
      var_13 = distance(var_3, var_12) / 7500;
      var_0 thread tank_watchforairburstdetonate(var_11, var_12, var_13, var_1, self);
      break;
    }
  }

  if(!istrue(var_8)) {
    if(isDefined(var_1))
      var_1 delete();
  }
}

tank_watchforairburstdetonate(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self))
    self delete();

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_3.origin = var_1;
  var_3 setscriptablepartstate("_encstr_881C0916B43931BA9337D1", "_encstr_955B0822180E2F20C091");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_1, 100, 100, var_3.team, 1, var_3.owner, 1);

  var_3 thread tank_delayairburstscriptabledeath();
}

tank_delayairburstscriptabledeath() {
  self endon("_encstr_AD75063D571AE108");
  self.dying = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self delete();
}

tank_handlewheeldustfx() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;

  for(;;) {
    var_1 = self vehicle_getspeed();
    var_2 = var_1 * 1.60934;

    if(var_1 > 1 && !istrue(var_0)) {
      var_0 = 1;
      self setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_AB0703DBB9");
    } else if(var_1 <= 1 && istrue(var_0)) {
      var_0 = 0;
      self setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_BA19049F4B2D");
    }

    self.owner setclientomnvar("_encstr_88171447D87EE88A670872EF8821F3990660CB8F2BB1", int(var_2));
    waitframe();
  }
}

wheelson_enginesfx() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread wheelson_engine_audio_game_end();

  for(;;) {
    var_0 = self.owner;

    if(isDefined(var_0)) {
      var_1 = var_0 getnormalizedmovement();
      var_2 = abs(var_1[0]);

      if(var_2 >= 0.15)
        wheelson_start_engine_audio();
      else
        wheelson_stop_engine_audio();
    } else
      wheelson_stop_engine_audio();

    waitframe();
  }
}

wheelson_start_engine_audio() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AA5515DF9CA00889AF5A02F1DB0D6AD7EFAB165CA30E60");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.engine_audio_active)) {
    return;
  }
  self.engine_audio_active = 1;
  self playsoundonmovingent("_encstr_B47D1A7BF75959EF146F70A87FFF385F05D8C9D360A508A32BC7CA6B");
  wait 0.5;
  self playLoopSound("_encstr_843F171303F331B7F819F7BDF3E8E689DDBDCFE7EDADF99460");
}

wheelson_stop_engine_audio(var_0) {
  if(istrue(var_0)) {
    self notify("_encstr_AA5515DF9CA00889AF5A02F1DB0D6AD7EFAB165CA30E60");
    self.engine_audio_active = undefined;
    self stoploopsound("_encstr_843F171303F331B7F819F7BDF3E8E689DDBDCFE7EDADF99460");
  } else if(istrue(self.engine_audio_active)) {
    self notify("_encstr_AA5515DF9CA00889AF5A02F1DB0D6AD7EFAB165CA30E60");
    self endon("_encstr_AA5515DF9CA00889AF5A02F1DB0D6AD7EFAB165CA30E60");
    self.engine_audio_active = undefined;
    self playsoundonmovingent("_encstr_8A2119B32B86EBBB34B22B1BB9F69BF5ACB9CE5AB92BEB9B3ADB07");
    wait 0.5;

    if(isDefined(self))
      self stoploopsound("_encstr_843F171303F331B7F819F7BDF3E8E689DDBDCFE7EDADF99460");
  }
}

wheelson_engine_audio_game_end() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread wheelson_stop_engine_audio();
}

tank_empstarted(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }
  self.owner controlsunlink();
  thread scripts\cp_mp\emp_debuff::_id_1241A(self.owner, 5);
}

tank_empcleared(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(!istrue(var_0))
    self.owner controlslinkTo(self);
}

tank_watchfiring(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_920E0BE7880931BA61B86733C0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 50;
  var_2 = var_1;
  var_3 = weaponfiretime(level.tanksettings[var_0.tanktype].mgturretinfo);

  for(;;) {
    if(var_0.mgturret isfiringvehicleturret()) {
      var_2--;

      if(var_2 <= 0) {
        var_0.mgturret turretfiredisable();
        wait 2.5;
        var_0 playSound("_encstr_B2F70DD373524A2326C5FDAAF893A1");
        self playlocalsound("_encstr_BA741130B3F17848818320508702BCAFBB9D2A");
        var_2 = var_1;
        var_0.mgturret turretfireenable();
      }
    }

    wait(var_3);
  }
}

tank_earthquake() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_920E0BE7880931BA61B86733C0");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self.owner earthquakeforplayer(0.05, 0.05, self gettagorigin("_encstr_8F1E092CC9F71178C01941"), 500);
    wait 0.05;
  }
}

addtougvlist(var_0) {
  level.ugvs[var_0] = self;
}

removefromugvlist(var_0) {
  level.ugvs[var_0] = undefined;
}

tank_watchridermount() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, &"_encstr_A6A52369A46262A6A292A81496A97D21259CA26A970550A1AF35A8938A2556F5A99E559315", 90, 90, 150, 150, 3, 1);
  tank_enableriderprompt();

  for(;;) {
    self.useobj waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(self.rider) && self.rider == var_0) {
      var_0 unlink();
      self.rider = undefined;
      tank_enableriderprompt();
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(!var_0 scripts\common\utility::is_usability_allowed()) {
      continue;
    }
    self.rider = var_0;
    var_0 playerlinkTo(self, "_encstr_A21B0F472CECFA83D8C297B2934ED28CCA", 0.8);
    thread tank_watchriderturn(var_0, 20);
    thread tank_watchriderabandon(var_0);
    thread tank_watchriderautodismount(var_0);
    tank_disableriderprompt(var_0);
  }
}

tank_watchriderturn(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = var_0 getplayerangles();
    var_5 = var_4[1];
    var_6 = self.angles[1];

    switch (var_2) {
      case 0:
        var_7 = 90 - var_1 * 0.5;
        var_8 = angleclamp180(var_5 - var_6);

        if(abs(var_8) >= var_7) {
          var_3 = 2;
          var_2 = 1;
        }

        break;
      case 1:
        var_9 = vectordot(anglesToForward(var_4), anglestoright(self.angles));
        var_10 = -1.0 * var_1;

        if(var_9 > 0) {
          var_11 = angleclamp180(var_5 - var_6 + 90);

          if(var_11 < var_10) {
            var_3 = 2;
            var_2 = 2;
          } else if(var_11 > var_1) {
            var_3 = 0;
            var_2 = 0;
          }
        } else {
          var_11 = angleclamp180(var_5 - var_6 - 90);

          if(var_11 > var_1) {
            var_3 = 2;
            var_2 = 2;
          } else if(var_11 < var_10) {
            var_3 = 0;
            var_2 = 0;
          }
        }

        break;
      case 2:
        var_7 = 90 - var_1 * 0.5;
        var_11 = angleclamp180(var_5 - var_6 + 180);

        if(abs(var_11) >= var_7) {
          var_3 = 0;
          var_2 = 1;
        }

        break;
    }

    waitframe();
  }
}

tank_watchriderabandon(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.rider = undefined;
  tank_enableriderprompt();
}

tank_watchriderautodismount(var_0) {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.rider) && var_0 == self.rider)
    var_0 unlink();
}

tank_enableriderprompt() {
  if(level.teambased) {
    foreach(var_1 in level.players) {
      if(var_1.team != self.team) {
        continue;
      }
      self enableplayeruse(var_1);
    }
  }
}

tank_disableriderprompt(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.players) {
      if(var_2.team != self.team) {
        continue;
      }
      if(var_2 == var_0) {
        continue;
      }
      self disableplayeruse(var_2);
    }
  }
}

tank_findsafespawn(var_0) {
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = [var_2 + var_0 * var_4, var_2 - var_0 * var_4, var_2 + var_0 * var_5, var_2 - var_0 * var_5, var_2 + 0.707 * var_0 * (var_4 + var_5), var_2 + 0.707 * var_0 * (var_4 - var_5), var_2 + 0.707 * var_0 * (var_5 - var_4), var_2 + 0.707 * var_0 * (-1 * var_4 - var_5)];

  foreach(var_8 in var_6) {
    var_1 = tank_checkspawnpoint(var_2, var_8);

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

tank_checkspawnpoint(var_0, var_1) {
  var_2 = undefined;
  var_3 = (0, 0, 45);
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var_5 = var_0 + var_3;
  var_6 = var_1 + var_3;
  var_7 = 40;
  var_8 = scripts\engine\trace::ray_trace_passed(var_5, var_6, self, var_4);

  if(!istrue(var_8))
    return var_2;

  var_9 = scripts\engine\trace::ray_trace(var_6, var_6 - (0, 0, 500), level.players, var_4);

  if(isDefined(var_9["_encstr_BD260953AA97E3F014279D"]) && var_9["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
    var_10 = var_9["_encstr_BD260953AA97E3F014279D"] + var_3;
    var_11 = scripts\engine\trace::sphere_trace_passed(var_10, var_10, var_7, level.players, var_4);
    var_12 = undefined;

    if(level.teambased)
      var_12 = self.team;

    if(istrue(var_11) && !scripts\mp\outofbounds::ispointinoutofbounds(var_9["_encstr_BD260953AA97E3F014279D"], var_12))
      var_2 = var_9["_encstr_BD260953AA97E3F014279D"];
    else {}
  }

  return var_2;
}

tank_updatehudchassisangles() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = self.mgturret gettagangles("_encstr_A14F0AE336178944BA076F41");
    var_1 = invertangles(self.angles);
    var_2 = combineangles(var_1, var_0);
    var_3 = var_2[1] * -1.0;
    self.owner setclientomnvar("_encstr_8E2116D52DEB0716D87DB959731D275E7D8CB2B3E42BB2CD", var_3);
    waitframe();
  }
}

tank_updatehudviewstate() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread tank_watchownerdeath();
  self.owner notifyonplayercommand("_encstr_9BDC0C8E7B9D76D856FACE96CADD", "_encstr_82600E591DB7EC761BACECCA0DC6165B");
  var_0 = 1;
  var_1 = "_encstr_8D8614ABD34CABA0179F79F05347138E7817BC9E8F60";

  if(isDefined(self.owner.previousremotetankviewstate)) {
    var_0 = self.owner.previousremotetankviewstate;

    if(var_1 == 2)
      var_1 = "_encstr_B677146431933389B16B58E8B355454E13B5FD709FBB";
  }

  for(;;) {
    self.owner waittill("_encstr_9BDC0C8E7B9D76D856FACE96CADD");
    var_0++;

    if(var_0 == 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A37A196F13897ACB10E3FFC6F871F62253E7C7BFF3A523912168B2", "_encstr_AC190479FF92", self.lifetime, 0);
      var_1 = "_encstr_B677146431933389B16B58E8B355454E13B5FD709FBB";
    } else if(var_0 > 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_0 = 1;
      var_1 = "_encstr_8D8614ABD34CABA0179F79F05347138E7817BC9E8F60";
    }

    self.owner.previousremotetankviewstate = var_0;
    self.owner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, var_1);
    self.owner setclientomnvar("_encstr_A72E17BAA5F50EB036EBB92B9BD19C2FBE8DDB731D4E7BC6CD", var_0);
  }
}

tank_watchownerdeath() {
  var_0 = self.owner;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_9BC215FC37482FA99D585B32F8EFDB9F81A443745F535F");
  var_0 endon("_encstr_9BC215FC37482FA99D585B32F8EFDB9F81A443745F535F");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0.previousremotetankviewstate))
    var_0.previousremotetankviewstate = undefined;
}