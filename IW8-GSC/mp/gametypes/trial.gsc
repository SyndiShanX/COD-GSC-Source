/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\trial.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  trial_mission_data_init();
  _id_13D61();
  scripts\mp\trials\mp_trials_patches::init_trial_patches();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata())
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  else {
    setdynamicdvar("_encstr_925916E7EF1ED14710B857D173F88B9B7B0737134BC82A3D", 0);
    setdynamicdvar("_encstr_B80817528380F1C006B5F5B17015F9AF7B43891F3BA457F31A", 0);
  }

  if(issubstr(getDvar("_encstr_9570084B1793A090CDFF"), "_encstr_811606E55011890F"))
    setDvar("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669", 0);

  if(getDvar("_encstr_A9330B9167D26C016997EB79D7") == "_encstr_A34C02BB")
    setDvar("_encstr_A2C517A5051331BC83985F531159765AC51DE11F60A1EAFE49", 1);
  else
    setDvar("_encstr_AF6D0B69A079EB9A59E9C309B1", 1);

  setDvar("_encstr_AB431BB1C4FF8890BA3B610BB782E3C09B5B9B08ED26A1541217591B57", 0);
  setDvar("_encstr_85F6186F966321C7B788A810A5332B2B8053CC380BD9E150DDC5", 0);
  setDvar("_encstr_ACCD189B1B27AFEC58B6ACF5277BABB9C8373A58393A8E5AB6B2", 0);
  setDvar("_encstr_81B2140BC6CBF9733A48B01CD9237013C3C8236D14B8", 0);
  var_0 = [];
  var_0[var_0.size] = level.gametype;
  var_0[var_0.size] = "_encstr_A9B30F47E4A5B063EB3B0B275AC2B91DF5" + level.trial["_encstr_B6A208B3C2275AC2B9E8"];
  var_0[var_0.size] = "_encstr_B2BE0F088BF47338C7AD7376AB47ED25D1" + level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"];
  var_0[var_0.size] = "_encstr_ADF70BF3401DE28AD008B3C3E1" + level.trial["_encstr_B6A208B3C2275AC2B9E8"];
  var_0[var_0.size] = "_encstr_96B30B7C508220373248272EC7" + level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"];

  if(_tablethide::_id_13D4C())
    var_0[var_0.size] = "_encstr_8DFE083B114186A225C5";

  switch (level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"]) {
    case "_encstr_AC1F058B9EABE0":
    case "_encstr_A7B70BDA8379AF0EA00B9A8333":
      var_0[var_0.size] = "_encstr_B81904B04E6B";
      break;
    default:
      break;
  }

  level.brjuggernautcrateactivatecallback = var_0;
  scripts\mp\gameobjects::main(var_0);
  scripts\mp\utility\game::registerroundswitchdvar(level.gametype, 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(level.gametype, 0);
  scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
  scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
  scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
  scripts\mp\utility\game::registernumlivesdvar(level.gametype, 0);
  scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
  setspecialloadout();
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  scripts\cp_mp\parachute::initparachutedvars();
  level.supportintel = 0;
  level.supportnuke = 0;
  level.loadoutdefaultfiresalediscount = 1;
  level.teambased = 1;
  level.challengesallowed = 0;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerconnect = ::onplayerconnect;
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  level.endgame = ::_id_13D98;

  if(level.scripted_spawner_func.size) {
    level.starttime = 0;

    while(!isDefined(level.struct_class_names))
      waitframe();

    foreach(var_3, var_2 in level.scripted_spawner_func)[[var_2]](1, "_encstr_8A0703D983" + var_3);

    foreach(var_5 in level.cs_object_container) {
      foreach(var_7 in var_5.objects) {
        if(isent(var_7) && isDefined(var_7.struct.script_gameobjectname)) {
          var_8 = 0;

          foreach(var_10 in var_0) {
            if(var_7.struct.script_gameobjectname == var_10)
              var_8 = 1;
          }

          if(!var_8)
            var_7 delete();
        }
      }
    }
  }

  while(!isDefined(level._id_13D51))
    waitframe();

  switch (level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"]) {
    case "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0":
    case "_encstr_8A1804DAAB75":
      thread[[level._id_13D51["_encstr_8A1804DAAB75"]]]();
      break;
    case "_encstr_8E95062EE46DB683":
      thread[[level._id_13D51["_encstr_8E95062EE46DB683"]]]();
      break;
    case "_encstr_850707F7E5833355B8":
      thread[[level._id_13D51["_encstr_850707F7E5833355B8"]]]();
      break;
    case "_encstr_AFDD05A6AB763B":
      thread[[level._id_13D51["_encstr_AFDD05A6AB763B"]]]();
      break;
    case "_encstr_83AD0559672E3A":
      thread[[level._id_13D51["_encstr_83AD0559672E3A"]]]();
      break;
    case "_encstr_8E4708C12DE8D834AC27":
      thread[[level._id_13D51["_encstr_8E4708C12DE8D834AC27"]]]();
      break;
    case "_encstr_A1790BD0BB7517785F6EB4BD6A":
      thread[[level._id_13D51["_encstr_A1790BD0BB7517785F6EB4BD6A"]]]();
      break;
    case "_encstr_AC1F058B9EABE0":
      thread[[level._id_13D51["_encstr_AC1F058B9EABE0"]]]();
      break;
    case "_encstr_A7B70BDA8379AF0EA00B9A8333":
      thread[[level._id_13D51["_encstr_A7B70BDA8379AF0EA00B9A8333"]]]();
      break;
    default:
      break;
  }

  _start_rooftop_obj::init();

  if(level.trial["_encstr_9A5118A925234BDACAC327AF01B52BDADE61688B73A37DC9831D"] != "_encstr_B40101") {
    waitframe();
    scripts\mp\compass::setupminimap(level.trial["_encstr_9A5118A925234BDACAC327AF01B52BDADE61688B73A37DC9831D"]);
  }
}

_id_13D98(var_0, var_1) {
  level notify("_encstr_88BC11FDBA8A5109E0A34075FFF167A4699A0D");
  processlobbydata();

  if(isDefined(level._id_13D32))
    [[level._id_13D32]]();

  if(getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A") >= 1) {
    setomnvar("_encstr_A2E219BB686FA880111ACD09326D54BEFB636FA09F709ABBB89B4A", 1);
    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 0);

    if(getDvar("_encstr_A9330B9167D26C016997EB79D7") != "_encstr_A34C02BB") {
      wait 0.1;
      level.player openmenu("_encstr_A6F11007BA9F70606F56F981454E60DB27A2");
      wait 3;
    }
  }

  exitlevel(0);
}

trial_mission_data_init() {
  var_0 = _tablethide::_id_13D42();
  var_1 = getdvarint("_encstr_BA040B31A8A2942D2793962A8A", 0);

  if(var_1 == 0) {
    var_2 = tablelookup(var_0, 2, getDvar("_encstr_9570084B1793A090CDFF"), 0);

    if(var_2 != "_encstr_B40101")
      var_1 = var_2;
    else
      return;
  }

  level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"] = int(var_1);
  level.trial["_encstr_836105A5EFB2E5"] = tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 2);
  level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] = tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 3);
  level.trial["_encstr_B6A208B3C2275AC2B9E8"] = tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 4);
  level.trial["_encstr_8AEF05472BC2D6"] = tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 5);
  level.trial["_encstr_95480A37B1ED9C5915BC1C95"] = tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 6);
  level.trial["_encstr_816C069599555DA7"] = int(tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 8));
  level.trial["_encstr_876C06B1FF0A66F2"] = int(tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 9));
  level.trial["_encstr_966C066BF011B2F7"] = int(tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 10));
  level.trial["_encstr_A67009D77B23ABF02883D0"] = int(tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 11));
  level.trial["_encstr_9A5118A925234BDACAC327AF01B52BDADE61688B73A37DC9831D"] = tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 18);
  level.trial["_encstr_B6390DE0630B5ECA3922161DC2528C"] = int(tablelookup(var_0, 0, level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"], 20));

  if(level.trial["_encstr_836105A5EFB2E5"] != getDvar("_encstr_9570084B1793A090CDFF")) {}

  setomnvar("_encstr_B4761F6BE9A9D84ED77AE8B682EF86A87C77D5479B0EB8960F71403BC9F3B38097", level.trial["_encstr_95480A37B1ED9C5915BC1C95"] == "_encstr_84EF055338A18F");
  setomnvar("_encstr_AD0B140BE069D8FA4FB13896B51A76DBE8D81E987727", level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"]);
  setomnvar("_encstr_ACA4203B381F1B1EFAEF447711AB6706E3FFB0B10B41765AB7FB970D375B11714301", level.trial["_encstr_B6390DE0630B5ECA3922161DC2528C"]);
  setomnvar("_encstr_9A3A1CCBC37EDBC23C5EA220EC1B609B0FA7E9E3D1B74060B31AF1191253", level.trial["_encstr_816C069599555DA7"]);
  setomnvar("_encstr_BA101C1D4748732ABB58D0178C988FD0F94E59CA97CABB130A3F9D3FA023", level.trial["_encstr_876C06B1FF0A66F2"]);
  setomnvar("_encstr_99FB1CAE967D1D935A85D8F51DD2ACE4AF66FA9C568BBA2DE4AC6B56B9E8", level.trial["_encstr_966C066BF011B2F7"]);
}

getspawnpoint() {
  while(istrue(level._id_13D6A))
    waitframe();

  var_0 = "_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37";
  var_1 = scripts\mp\spawnlogic::getspawnpointarray(var_0);
  var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);

  if(isDefined(level._id_13D69)) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(level._id_13D69, 1);
    var_4 = spawnStruct();
    var_4.useonspawn = 1;
    var_4.enterstartwaitmsg = "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level._id_13D69, var_3[0], self, var_4);
    self.spawningintovehicle = 1;
  }

  return var_2;
}

alwaysgamemodeclass() {
  return "_encstr_AAAC09D09972B9C83F2B7F";
}

onplayerconnect(var_0) {
  var_0 thread scripts\mp\menus::addtoteam(level.trial["_encstr_8AEF05472BC2D6"]);
  level.teamdata["_encstr_9A8507BA4040188D08"]["_encstr_8D2B0B731835B061416B9B8751"] = "_encstr_B10703CB22";
  level.teamdata["_encstr_8E8405EA382B2A"]["_encstr_8D2B0B731835B061416B9B8751"] = "_encstr_9107031585";
  var_0 setclientomnvar("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 1);
  var_0 setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", 1);
  var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  var_0.class = var_0.pers["_encstr_959506B911C79707"];
  var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];

  if(isDefined(level.trial_map_loadout))
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.trial_map_loadout;
  else
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.trial_loadout["_encstr_8E8405EA382B2A"];

  if(istrue(level.trial_infinite_reserve_ammo))
    var_0 thread infinite_reserve_ammo();

  thread trial_weapon_spawn();
  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");

  if(level.players.size > 1)
    exitlevel(0);

  level.player _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1254D();
  wait 1;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_0, 0, 0.5);

  if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] < level.trial["_encstr_A67009D77B23ABF02883D0"])
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AAC30CB5E0384E6BD74B5D8BBBF8");
  else if(getDvar("_encstr_9570084B1793A090CDFF") == getDvar("_encstr_86EB0C1F79AD69F598831D26D840", "_encstr_B40101"))
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_994612186A739139E9C84609D8D831F3722FB8D3");
  else
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_9B150C2306935224A618E3B3F898");

  setDvar("_encstr_86EB0C1F79AD69F598831D26D840", getDvar("_encstr_9570084B1793A090CDFF"));
  thread _id_13D5F();
}

setspecialloadout() {
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_A7ED0AD79F73990E28334B92";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_83BC1124F069D3E5D3907833B0C31A4F41E8A4"] = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_A9C30F63DE858CDB57E8F499991A2CDCC8"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];
  level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_0 = getEnt("_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = getEnt("_encstr_8B791885530F01093F9FD449F01BF71807FF048F08E92D2D713A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_0)) {
    var_2 = strtok(var_0.script_parameters, "_encstr_BE4C0295");
    var_3 = var_2[0];
    var_4 = scripts\engine\utility::array_remove(var_2, var_3);
    level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_3;

    foreach(var_8, var_6 in var_4) {
      if(!var_8) {
        level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = var_6;
        continue;
      }

      var_7 = "_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878" + (var_8 + 1);
      level.trial_loadout["_encstr_8E8405EA382B2A"][var_7] = var_6;
    }
  }

  if(isDefined(var_1)) {
    var_2 = strtok(var_1.script_parameters, "_encstr_BE4C0295");
    var_3 = var_2[0];
    var_4 = scripts\engine\utility::array_remove(var_2, var_3);
    level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = var_3;

    foreach(var_8, var_6 in var_4) {
      if(!var_8) {
        level.trial_loadout["_encstr_8E8405EA382B2A"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = var_6;
        continue;
      }

      var_7 = "_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB" + (var_8 + 1);
      level.trial_loadout["_encstr_8E8405EA382B2A"][var_7] = var_6;
    }
  }

  level.trial_loadout["_encstr_9A8507BA4040188D08"] = level.trial_loadout["_encstr_8E8405EA382B2A"];
}

infinite_reserve_ammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    self givemaxammo(self.currentprimaryweapon);
  }
}

trial_weapon_spawn() {
  level.trial_weapons = getEntArray("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.trial_akimbo_props = getEntArray("_encstr_8EEE1929B2E4B081CFDB09B1933748893E339BE34ACDF9D71332A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!isDefined(level.weaponmapdata))
    waitframe();

  waitframe();

  foreach(var_1 in level.trial_weapons)
  var_1 thread weapon_think();
}

weapon_think() {
  level.player endon("_encstr_AD75063D571AE108");
  var_0 = strtok(self.script_parameters, "_encstr_BE4C0295");
  var_1 = var_0[0];
  var_2 = scripts\engine\utility::array_remove(var_0, var_1);
  var_3 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_4 = scripts\mp\utility\weapon::weaponassetnamemap(var_1);
  var_5 = getcompleteweaponname(var_4);
  var_6 = [];
  var_7 = 0;

  foreach(var_9 in var_2) {
    var_10 = scripts\mp\utility\weapon::attachmentmap_tounique(var_9, var_4);

    if(var_5 canuseattachment(var_10)) {
      if(var_9 == "_encstr_AD9C07E0478148252A")
        var_7 = 1;

      var_6[var_6.size] = var_9;
      continue;
    }
  }

  var_2 = var_6;
  var_12 = scripts\mp\class::buildweapon(var_1, var_2, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1, undefined, undefined, undefined, var_3);
  var_13 = createheadicon(var_12);

  if(var_7)
    thread weapon_akimbo_prop_think(var_13);

  while(!isDefined(level.player.primaryinventory[0]))
    waitframe();

  for(;;) {
    var_14 = 0;
    var_15 = 0;

    if(isDefined(level.player.primaryinventory[0]))
      var_14 = var_13 == createheadicon(level.player.primaryinventory[0]);

    if(isDefined(level.player.primaryinventory[1]))
      var_15 = var_13 == createheadicon(level.player.primaryinventory[1]);

    if(!isDefined(self.spawned_weapon) && !var_14 && !var_15) {
      self.spawned_weapon = spawn("_encstr_B2010820C5337B67C8CF" + var_13, self.origin, 17);
      self.spawned_weapon.angles = self.angles;
      var_16 = weaponclipsize(var_12);
      var_17 = weaponmaxammo(var_12);

      if(isDefined(self.script_noteworthy)) {
        if(self.script_noteworthy == "_encstr_8D360838D3CB51A8EEEF")
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "_encstr_8294137D0BA3CC0AA05BF7539DDB7234B1103347A0", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
        else if(self.script_noteworthy == "_encstr_851904AFBF37") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "_encstr_A7DA197F2B857AD1C0013FC418E8DF92D091DFFBC123F19310E935", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
          var_17 = 0;
        }
      }

      if(var_7)
        var_16 = 0;

      if(istrue(level._id_124C9))
        var_17 = level.enemiestotal - var_16;

      self.spawned_weapon itemweaponsetammo(var_16, var_17);
    }

    level.player waittill("_encstr_B8E20FBB59851CF6E6AF91E4DBC107B232", var_18, var_19);

    if(createheadicon(var_19) == var_13)
      var_18 delete();
  }
}

weapon_akimbo_prop_think(var_0) {
  foreach(var_2 in level.trial_akimbo_props) {
    if(var_2.script_parameters == self.script_parameters)
      self.akimbo_prop = var_2;
  }

  while(isDefined(self.akimbo_prop)) {
    while(!isDefined(self.spawned_weapon))
      waitframe();

    self.akimbo_prop.spawned_prop = spawn("_encstr_B2010820C5337B67C8CF" + var_0, self.akimbo_prop.origin, 17);
    self.akimbo_prop.spawned_prop.angles = self.akimbo_prop.angles;
    self.akimbo_prop.spawned_prop sethintinoperable(1);

    while(isDefined(self.spawned_weapon))
      waitframe();

    if(isDefined(self.akimbo_prop.spawned_prop))
      self.akimbo_prop.spawned_prop delete();
  }
}

trial_end_score_dialogue() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getomnvar("_encstr_AAAE14C3FA175DF0043989F72D6E60286F339908F357");
  var_4 = getomnvar("_encstr_BE2813DD7B51B37B03910239786F4F6DF9F9495D8B");

  if(var_3 != -1) {
    var_0 = var_3 >= getomnvar("_encstr_9A3A1CCBC37EDBC23C5EA220EC1B609B0FA7E9E3D1B74060B31AF1191253");
    var_1 = var_3 >= getomnvar("_encstr_BA101C1D4748732ABB58D0178C988FD0F94E59CA97CABB130A3F9D3FA023");
    var_2 = var_3 >= getomnvar("_encstr_99FB1CAE967D1D935A85D8F51DD2ACE4AF66FA9C568BBA2DE4AC6B56B9E8");
  } else if(var_4 != -1) {
    var_0 = var_4 <= getomnvar("_encstr_9A3A1CCBC37EDBC23C5EA220EC1B609B0FA7E9E3D1B74060B31AF1191253");
    var_1 = var_4 <= getomnvar("_encstr_BA101C1D4748732ABB58D0178C988FD0F94E59CA97CABB130A3F9D3FA023");
    var_2 = var_4 <= getomnvar("_encstr_99FB1CAE967D1D935A85D8F51DD2ACE4AF66FA9C568BBA2DE4AC6B56B9E8");
  }

  if(istrue(level.trial_fail_alt)) {
    level.trial_fail_alt = 0;
    var_5 = "_encstr_962A15A3272DC2C6BECA9B46EB1D4B59397DC0F5C2B1E8";
  } else if(var_2)
    var_5 = "_encstr_922511F9A67C510C376F0BCD5F148740A29783";
  else if(var_1)
    var_5 = "_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12";
  else if(var_0)
    var_5 = "_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4";
  else
    var_5 = "_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F";

  level.player scripts\mp\utility\dialog::leaderdialogonplayer(var_5);
  _tablethide::trial_ui_waittill_retry();

  if(!istrue(level._id_13D60))
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AAC30CB5E0384E6BD74B5D8BBBF8");
}

_id_13D61() {
  if(!isDefined(game["_encstr_8CA606F38878410D"]))
    game["_encstr_8CA606F38878410D"] = [];

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_9B230BB64D9BDD493B975FDB03"]))
    game["_encstr_8CA606F38878410D"]["_encstr_9B230BB64D9BDD493B975FDB03"] = -1;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"]))
    game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] = -1;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"]))
    game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] = level.trial["_encstr_A67009D77B23ABF02883D0"];

  setomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B", int(game["_encstr_8CA606F38878410D"]["_encstr_9B230BB64D9BDD493B975FDB03"]));
  setomnvar("_encstr_AF8F13DB2C27D846120F49272BFA0E608FC3C05057", int(game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"]));
  setomnvar("_encstr_836119BBF7A16DC8093EE09E63FAD82D9BC72D135FEABB5051D589", int(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"]));
}

_id_13D5F() {
  for(;;) {
    level.player waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0);

    if(var_0 == "_encstr_8A790E558D088F605193C037736ED6C3") {
      if(!isDefined(level.unset_stay_at_spawn_flag_on_entering_combat) || !level.unset_stay_at_spawn_flag_on_entering_combat)
        _tablethide::_id_13D5E();
    }
  }
}

processlobbydata() {
  _id_128AF(level.player);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
    setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", 1);
  else
    setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", 0);

  sendclientmatchdata();
}

_id_128AF(var_0) {
  if(istrue(var_0._id_128AF)) {
    return;
  }
  var_0._id_128AF = 1;

  if(isDefined(var_0) && !isDefined(var_0.clientmatchdataid)) {
    var_0.clientmatchdataid = level.initship;
    level.initship++;
  }

  var_1 = var_0.name;
  setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_91C008E832AE2577876F", var_0 getclantag());
  setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_823C09A2FB0F95E1C4FF41", var_0 getxuidhigh());
  setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_B12B0878EBE4094C77A7", var_0 getxuidlow());
  setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_87FA065AE621EDE8", isbot(var_0));
  setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_9BDC0FAE73A517EA561A8D96CAB9A3A446", var_0.clientid);
  setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_9BB5094F0EC73D22DE5BBA", var_1);

  if(var_0 isps4player())
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_A31904E09B0D");
  else if(var_0 isxb3player())
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8D19040F89CC");
  else if(var_0 ispcplayer())
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_B49B054CDC568E");
  else
    setclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8BBA05185F8B99");

  var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_882A111B1B5A95DC1D35B08ED81A29CD1995E1", var_0.clientmatchdataid);
}