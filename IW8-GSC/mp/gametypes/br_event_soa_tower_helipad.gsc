/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_event_soa_tower_helipad.gsc
*******************************************************/

init() {
  scripts\mp\flags::gameflaginit("_encstr_ACA314B97949B81C7ABB4D7716BB678B8FF1D18228CE", 0);
  setDvar("_encstr_8BBF129653FBDEF165E3B1306AB1B3115BF19C05", 1);
  level._id_14086 = 1;
  scripts\engine\scriptable::scriptable_addusedcallback(::scriptable_used);
  scripts\engine\scriptable::_id_12F58(::_id_12F5D);
  level _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::init();
  level._effect["_encstr_AAC8119D663CBE36A1D79C2B197DC6D2D9341D"] = loadfx("_encstr_B2DB322B63B9A69F8F41DE4665A6D4A8A8608308D1C03F93A7BA57667ACE6F60E771EFC30995A831FB50D194D39AF6A1EF248F40");
  tr_vis_radius_override_lod2();
  level thread object_is_valid();
}

tr_vis_radius_override_lod2() {
  level._id_13460 = spawnStruct();
  level._id_13460.time = getdvarint("_encstr_AC6924F02AF3D7AEC51F129A4F9FB30554CFE0770D11812B919AB989CBDDDB2DCB5F2038FBD3", 120);
  level._id_13460.chosencodephones = getdvarint("_encstr_8D55257B7EAEC142353EE60F678F4D3A3C9F53F90AC35B194E8D577D6397901895FFD763E724D3", 800);
  level._id_13460._id_1345A = getdvarint("_encstr_923A2ED7DF2EE17298EE222DC119AC3A047B6BEF51DD9A21B0311F397908C5625DF7A7AB37FFA3E5C8DE14BF91F01CBA", 5000);
  level._id_13460._id_1345E = getdvarint("_encstr_AF912D17937211D62B29BB20D2C795D84BED9DD7301F50ABCBE2512EFA4BC528237FC731AF82F8E5FBF98BB3C2FF0D", 100);
  level._id_13460._id_13458 = getdvarint("_encstr_AD8F34BBBAC061D2A637DB40BB3FC38F572D600FEAC3F45BC2073940BA2C5D3DE061C6481873BB6FD0496163FFC58995A2674BBB8F4B", 50);
  level._id_13460._id_13459 = getdvarint("_encstr_BE1F305B869E394342477658196FDBBF2CA303E1A89DEBB3B862BBE699032708C3AE100A1A094BDF968F27A86E1512DEDAE1", 35);
  level._id_13460._id_1345C = getdvarint("_encstr_8BEC3523AA300EDA184FAA770B0788EF90F1CD61C4397410A8D6D13ECAD512F095A6AF2C65A94BEFA22F5F5C6D0F3BE9B223C94BBF69FF", 6);
  level._id_13460._id_1345B = getdvarint("_encstr_A58835937A8A777E70E9E7378FAFB048C02DFBCE588D989728DF8BF11D3E21A62B463E631773BF4BE39F5DB75B61E321A0D17953487167", 11);
  level._id_13460._id_13466 = getdvarfloat("_encstr_AC85361FC89B87FA0548322D4FB7534FC3108327F010E9E26BF4BF29A6E15A0408887B7F28CE2B9A4B8FC55F159371C4D098AFA7D8206C72", 3);
}

object_is_valid() {
  waitframe();
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level._id_13460.active = 0;
  level._id_13460.states = ["_encstr_8882099673858D1D4B6756", "_encstr_930B07BB1B6B3854FF"];
  level._id_13460.current_state = "_encstr_8882099673858D1D4B6756";
  level._id_13460.cp_dntsk_raid_sound_load = 4;
  level._id_13460.cpcpammoarmorcratecapturecallback = [];

  if(!isDefined(level._id_13460.choppers))
    level._id_13460.choppers = [];

  level._id_1345D = [];
  level._id_13460.occupied_rpg_trig = getEnt("_encstr_A7D61A314EF59BDBC2D7E8B7DDB29C7D1B68D7CAB3ACCDE8FAECBD8D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13460._id_12D83 = (20213, -14849, 5000);
  level._id_13460 scripts\mp\utility\trigger::makeenterexittrigger(level._id_13460.occupied_rpg_trig, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5);
  level._id_13460._id_12659 = [];
  level._id_13460._id_12662 = [];
  level._id_13460._id_12663 = [];
  level._id_13460._id_12660 = [];
  level._id_13460._id_13B97 = -1;
  level _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::init();
  level._id_13460 _id_131DB();
}

_id_131DB() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_96B6176E7B2CBEE87BDDB239D7D02BD8961CC2327D13B7AD98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [];
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (20419, -15537, 4404);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (19640, -15161, 4354);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (19717, -14381, 4362);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (20180, -14144, 4354);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (20901, -14742, 4354);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (20817, -15180, 4354);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (19934, -15043, 4338);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (20514, -15072, 4338);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].origin = (20349, -14795, 4336);
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0[var_2].origin);
    var_3.angles = var_0[var_2].angles;
    var_3 setModel("_encstr_B8AD0F4F17BAAF10D76369830182904122");
    var_3 thread cp_raid_complex_behavior();
    var_3.offset3d = (0, 0, 16);
    var_3.curorigin = var_3.origin;
    var_3 scripts\mp\gameobjects::requestid(0, 1);
    var_3.ownerteam = "_encstr_ACFC091AE8AB2FCBE15119";
    var_3.numtouching["_encstr_8E8405EA382B2A"] = 0;
    var_3.numtouching["_encstr_9A8507BA4040188D08"] = 0;

    if(isDefined(var_3.objidnum) && var_3.objidnum != -1) {
      var_4 = var_3.objidnum;
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(var_4, "_encstr_A1511725FA2FE9D068FF033D8F4085C28C848FDD9255D19E17");
      scripts\mp\objidpoolmanager::update_objective_setneutrallabel(var_4, "_encstr_A1511725FA2FE9D068FF033D8F4085C28C848FDD9255D19E17");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(var_4, "_encstr_A1511725FA2FE9D068FF033D8F4085C28C848FDD9255D19E17");
      scripts\mp\objidpoolmanager::update_objective_icon(var_4, "_encstr_8462205D93CE9702A7132BF1982F3D0B260BD3CFB896FF0AAB60132AC815B3EF194D");
      scripts\mp\objidpoolmanager::update_objective_position(var_4, var_3.origin + (0, 0, 10));
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_4, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_4, 0);
      getbnetigrbattlepassxpmultiplier(var_4, 150, 200);
      getscriptcachecontents(var_4, 0.5, 1.0);
    }

    var_3._id_140B8 = scripts\engine\utility::getclosest(var_3.origin, var_1);
    level._id_13460.cpcpammoarmorcratecapturecallback[var_2] = var_3;
  }
}

getallextractspawninstances() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_133EB = spawnStruct();
  self._id_133EC = 1;
  self._id_133EB notify("_encstr_8DA316B947B783F5E6B6BCC8A5ECB2EB8EE42CD8DA96B9B3");
  self._id_133EB endon("_encstr_8DA316B947B783F5E6B6BCC8A5ECB2EB8EE42CD8DA96B9B3");
  self._id_133EB.states = ["_encstr_A7750EA710412F33A7C4DF1238495AC8", "_encstr_92820ABB72EA53E455F84AD2", "_encstr_ACC20AC198BB28400319CF53", "_encstr_9B46072B7EA254ADAF"];
  self._id_133EB.current_state = "_encstr_A7750EA710412F33A7C4DF1238495AC8";
  self._id_133EB.loot_getitemcount = 0;
  self._id_133EB._id_1381C = 0;
  self._id_133EB.initlocs_radio = 0;
  self._id_133EB._id_133F6 = 0;
  var_0 = level._id_13460._id_13466;

  for(;;) {
    if(self isonground() && objectiveids() && !self isparachuting()) {
      self._id_133EB.current_state = "_encstr_A7750EA710412F33A7C4DF1238495AC8";
      self._id_133EB._id_121CB = 0;
      self._id_133EB._id_1381C = 0;
      self._id_133EB.initlocs_radio = 0;
      self._id_133EB._id_133F6 = 0;
    }

    if(!self isonground() && !objectiveids()) {
      if(self._id_133EB.current_state != "_encstr_9B46072B7EA254ADAF") {
        if(self._id_133EB.current_state == "_encstr_A7750EA710412F33A7C4DF1238495AC8")
          self._id_133EB._id_1381C = gettime() / 1000;

        self._id_133EB.current_state = "_encstr_92820ABB72EA53E455F84AD2";
        self._id_133EB.initlocs_radio = gettime() / 1000;
        self._id_133EB._id_133F6 = self._id_133EB.initlocs_radio - self._id_133EB._id_1381C;
      }
    } else if(self isonground() && !objectiveids()) {
      var_1 = 4300;
      var_2 = 1500;
      var_3 = scripts\engine\utility::ter_op(var_1 - self.origin[2] > var_2, "_encstr_ACC20AC198BB28400319CF53", "_encstr_9B46072B7EA254ADAF");
      wait 0.1;

      if(scripts\mp\utility\player::unset_relic_trex(self) || !isalive(self))
        var_3 = "_encstr_9B46072B7EA254ADAF";

      self._id_133EB.current_state = var_3;

      switch (self._id_133EB.current_state) {
        case "_encstr_ACC20AC198BB28400319CF53":
          self._id_133EC = 0;

          if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
            scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_A55C2B5067213FF07F6F39A042AFB8FFD51B10C0DA020F880F9D3FB05EEF23377AF719AAD11F85210BAC509C2A", 1);

          self._id_133EB notify("_encstr_8DA316B947B783F5E6B6BCC8A5ECB2EB8EE42CD8DA96B9B3");
          break;
        case "_encstr_9B46072B7EA254ADAF":
          self._id_133EC = 0;
          self._id_133EB.current_state = "_encstr_9B46072B7EA254ADAF";
          self._id_133EB notify("_encstr_8DA316B947B783F5E6B6BCC8A5ECB2EB8EE42CD8DA96B9B3");
          break;
      }

      self._id_133EC = 0;
      self._id_133EB notify("_encstr_8DA316B947B783F5E6B6BCC8A5ECB2EB8EE42CD8DA96B9B3");
    }

    waitframe();
  }
}

oceanrock() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_13460 endon("_encstr_B65A1D9BE8B738AF6EDE58EB1DDBEE2BE47D0D2BC65AE00B19FAACD959CD47");
  var_0 = gettime() / 1000;
  var_1 = gettime() / 1000;

  for(;;) {
    var_2 = gettime() / 1000;
    var_3 = 120 - (var_2 - var_0);

    foreach(var_5 in level._id_13460._id_12662) {
      if(var_2 - var_1 > 1.0) {
        var_6 = obj_smuggler_killed_early(var_3);
        var_5 playlocalsound(var_6);
        var_1 = gettime() / 1000;
      }
    }

    wait 0.1;
  }
}

obj_smuggler_killed_early(var_0) {
  if(var_0 > 20)
    return "_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40";
  else if(var_0 > 10)
    return "_encstr_A9B919BAA5F5B507D7E8A56BCA4EBEB1F6EACD8E23DBDDE6AF2603";
  else if(var_0 > 5)
    return "_encstr_88981FAE96AF5B83EB474B6B5693BE36B75737A332DEBB37F586C21B66AF6EB21B";
  else if(var_0 > 1.5)
    return "_encstr_962A22AB96EBDA07BEE85AD6AC9CFAD8B7D5B947C8BDEEB9FA17BA8539E89593F5B9B28D";
  else
    return "_encstr_B6AF180B8909B0EFAF8BE810E26330885D0DB5B12CED983887F7";
}

obj_room_fire_08(var_0) {
  if(isDefined(var_0.attacker)) {
    if(isPlayer(var_0.attacker))
      var_0.attacker objective_show_for_mlg_spectator();
  }

  return 1;
}

objectiveachievementkillcount() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_13460 endon("_encstr_B65A1D9BE8B738AF6EDE58EB1DDBEE2BE47D0D2BC65AE00B19FAACD959CD47");

  for(;;) {
    var_0 = scripts\engine\utility::array_combine_unique(level._id_13460._id_12659, level._id_13460._id_12662);

    foreach(var_2 in var_0) {
      var_3 = var_2 objective_set_hot();

      if(!var_3 && var_2 objectiveids())
        var_2 objective_timers_reset_both();
      else if(isalive(var_2))
        var_2 objectiveicon();
      else
        var_2 objectivedescription();

      var_4 = gettime() / 1000;

      foreach(var_2 in level._id_13460._id_12663) {
        var_6 = gettime() / 1000 - var_2._id_13462 / 1000;
        var_7 = var_2.soldier_agent_lwfn6;

        if(isDefined(var_7)) {
          if(var_7.hidden)
            var_7 scripts\mp\hud_util::showelem();

          var_7 setvalue(ceil(10 - var_6));
        }

        if(var_2 objectiveids()) {
          var_2 objective_timers_reset_both();

          if(isDefined(var_7))
            var_7 scripts\mp\hud_util::hideelem();

          continue;
        }

        if(var_6 >= 10) {
          var_2 objectivedescription();
          objective_locations_logic(var_2, "_encstr_BA98272D76293390F921407FFF50ADA152A3B39E1327CC07314BD08FEBF903ED7845FB931FBE9BB0E2");
        }
      }
    }

    wait 0.1;
  }
}

objective_timers_reset_both() {
  if(!isDefined(self)) {
    return;
  }
  if(!objective_set_hot()) {
    level._id_13460._id_12662 = scripts\engine\utility::array_add(level._id_13460._id_12662, self);
    _id_13EF3();

    if(level._id_13460.current_state == "_encstr_930B07BB1B6B3854FF")
      objective_locations_logic(self, "_encstr_819E266D3A89C30832013540B48596A91D4387A00DAF72B07B031387B0712503DB80C733DB7B01E7");
  } else if(objective_origin()) {
    self._id_13462 = undefined;
    level._id_13460._id_12663 = scripts\engine\utility::array_remove(level._id_13460._id_12663, self);
  }
}

objectivedescription() {
  if(!isDefined(self)) {
    return;
  }
  if(objective_set_hot()) {
    _id_13EF4();
    level._id_13460._id_12662 = scripts\engine\utility::array_remove(level._id_13460._id_12662, self);
    level._id_13460._id_12663 = scripts\engine\utility::array_remove(level._id_13460._id_12663, self);
  }
}

objectiveicon() {
  if(!isDefined(self)) {
    return;
  }
  if(objective_set_hot() && !objective_origin()) {
    self._id_13462 = gettime();
    level._id_13460._id_12663 = scripts\engine\utility::array_add(level._id_13460._id_12663, self);
  }
}

objectiveids() {
  if(!isDefined(self))
    return 0;

  if(scripts\engine\utility::array_contains(level._id_13460._id_12659, self))
    return 1;

  return 0;
}

objective_set_hot() {
  if(!isDefined(self))
    return 0;

  return scripts\engine\utility::array_contains(level._id_13460._id_12662, self);
}

objective_origin() {
  if(!isDefined(self))
    return 0;

  return scripts\engine\utility::array_contains(level._id_13460._id_12663, self);
}

objective_show_for_mlg_spectator() {
  if(!isDefined(self))
    return 0;

  if(!scripts\engine\utility::array_contains(level._id_13460._id_12660, self) && objective_set_hot())
    level._id_13460._id_12660 = scripts\engine\utility::array_add(level._id_13460._id_12660, self);
}

objective_minimapupdate(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.intvar = var_1;
  }

  foreach(var_4 in level._id_13460._id_12662)
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_4, var_0, var_2);
}

objective_locations_logic(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3);
}

_id_13DAB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isPlayer(var_0) && level._id_13460.chosencodephones > 0)
    var_0 thread chosen_airlock_door();

  if(isPlayer(var_0) && !scripts\engine\utility::array_contains(level._id_13460._id_12659, var_0))
    level._id_13460._id_12659 = scripts\engine\utility::array_add(level._id_13460._id_12659, var_0);

  if(isPlayer(var_0) && (!isDefined(var_0._id_133EC) || !var_0._id_133EC))
    var_0 thread getallextractspawninstances();
}

_id_13DAC(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isPlayer(var_0) && scripts\engine\utility::array_contains(level._id_13460._id_12659, var_0))
    level._id_13460._id_12659 = scripts\engine\utility::array_remove(level._id_13460._id_12659, var_0);
}

_id_13DA5(var_0, var_1) {
  if(!isDefined(var_0))
    return 1;

  if(!isPlayer(var_0))
    return 1;

  return 0;
}

chosen_airlock_door() {
  self endon("_encstr_8D3E0D88637B87D85657B010AB6F51");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(!self isonground())
    waitframe();

  self skydive_setbasejumpingstatus(0);

  for(;;) {
    if(level._id_13460._id_12D83[2] - self.origin[2] > level._id_13460.chosencodephones) {
      break;
    }

    wait 0.1;
  }

  self skydive_setbasejumpingstatus(1);
  var_0 = [];
  var_0[0] = self;
  var_1 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  var_2 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 30), self.origin + (0, 0, -80), var_0, var_1);

  if(!isDefined(var_2))
    self skydive_beginfreefall();

  self notify("_encstr_8D3E0D88637B87D85657B010AB6F51");
}

scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0.type == "_encstr_B8AD0F4F17BAAF10D76369830182904122") {
    if(!level._id_13460.active) {
      level thread start_event();
      level._id_13460.active = 1;
    }

    var_0 thread location_tracker(var_3);
  }
}

_id_12F5D(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0.type == "_encstr_B8AD0F4F17BAAF10D76369830182904122") {
    if(!level._id_13460.active) {
      level thread start_event();
      level._id_13460.active = 1;
    }
  }
}

start_event() {
  level._id_13460 thread objectiveachievementkillcount();
  waitframe();
  level._id_13460.current_state = "_encstr_930B07BB1B6B3854FF";
  level._id_13460.cp_dntsk_raid_sound_load = 4;
  level._id_13460._id_13B97 = gettime();
  _id_13EE8();
  objective_minimapupdate("_encstr_819E266D3A89C30832013540B48596A91D4387A00DAF72B07B031387B0712503DB80C733DB7B01E7");
  level._id_13460 thread _id_13291("_encstr_96B613AD83EBE6D80B5BAF3459D84BC6F61CE8B2C9");
  level thread _id_137AA();
  level._id_13460 _id_13467();
  _id_13EEA("_encstr_930B07BB1B6B3854FF");
}

soldier_agent_lwfn3() {
  thread _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::_id_1344E();
}

_id_13467() {
  if(level._id_13460.choppers.size == 0)
    level._id_13460.choppers = [];

  var_0 = scripts\engine\utility::getStruct("_encstr_BDA60C294F8BF6A8B409AAED6D65", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = _id_1345F();
  var_2 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A18(var_0, undefined, 1, var_1);
  var_2 thread _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::connectedplayercount();
  var_2.intro_driver_logic = ::_id_13450;
  var_2.intro_enemy_respawner = ::_id_13450;
  var_2.lootfunc = ::soldier_agent_lwfn3;
  var_2.interaction_is_floor_is_lava_client = ::_id_1344D;
  var_2.intermissionspawntime = ::_id_1344F;
  var_2.updateteamscoreplacements = 1;
  var_2.usefuncoverride = 1;
  var_2.health = level._id_13460._id_1345A;
  var_2.speed = level._id_13460._id_1345E;
  var_2.accel = level._id_13460._id_13458;
  var_2._id_13768 = level._id_13460._id_13459;
  var_2 thread _id_13450(var_1[0]);
  level._id_13460.choppers = scripts\engine\utility::array_add(level._id_13460.choppers, var_2);
  waitframe();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_A7B30DE187CA05B92B54B8537A15E8", ::obj_room_fire_08);
  scripts\mp\flags::gameflagset("_encstr_ACA314B97949B81C7ABB4D7716BB678B8FF1D18228CE");
  waitframe();
  scripts\mp\flags::gameflagclear("_encstr_ACA314B97949B81C7ABB4D7716BB678B8FF1D18228CE");

  if(!isDefined(level.shutdownattractionicontrigger))
    level thread _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::init();
}

_id_1345F() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0 = (19077, -17718, 5550);
    var_1 = (17866, -15627, 5550);
    var_2 = (19309, -13691, 5550);
    var_3 = (21973, -13971, 5550);
    var_4 = (22573, -15691, 5550);
  } else {
    var_0 = (1132.5, 2841.5, 5550.5);
    var_1 = (2337, 746.5, 5551);
    var_2 = (902, -1193.5, 5548.5);
    var_3 = (-1763.5, -912, 5549);
    var_4 = (-2366, 811.5, 5549.5);
  }

  var_5 = [var_0, var_1, var_2, var_3, var_4];
  return var_5;
}

hidetimedrunhudfromplayer(var_0) {
  level notify("_encstr_812A1DA3D3BF5078EB5F2B4F2BF2B4305AE148F97D11082FF2B7092BA77A7E");
  var_0 _id_13546();
  objective_minimapupdate("_encstr_9A693046F28E7FE8016965EF1B0FB331A72BBD581479D9619394D3782C48969FC89AB5A85379072A3B03E847277ADDF18BC2");

  foreach(var_2 in level._id_13460._id_12660) {
    var_2 _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::_id_12D23("_encstr_95AF15D843BEB23B56738EAF0E16C9D1961B4B8385DC8E");

    if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_91F5357C9BEE8FE447C82A12C813DDC7C128FDF059F19B6F9F90629AE817D5D73B8E7197E05E0BB5ADD9CBE751EB81BF337DCE0490E333", 1);
  }

  handlematchscoreboardinfo();
}

patchoutofboundstrigger() {
  objective_minimapupdate("_encstr_8E97298A0D11324F471643FAFBADE3E168BD051E6969BC2FF9C8FB02A1E8B324F073AAA7D3F842279E61B2");

  foreach(var_1 in level._id_13460.cpcpammoarmorcratecapturecallback) {
    if(isDefined(var_1))
      var_1 thread lbravo_spawner_jammer4b();
  }

  handlematchscoreboardinfo();
}

handlematchscoreboardinfo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_13460.current_state = "_encstr_8882099673858D1D4B6756";

  foreach(var_1 in level._id_13460.choppers) {
    if(isDefined(var_1)) {}
  }

  level._id_13460 notify("_encstr_B65A1D9BE8B738AF6EDE58EB1DDBEE2BE47D0D2BC65AE00B19FAACD959CD47");
  level._id_13460.active = 0;
  _id_13EE9();
}

_id_137AA() {
  level endon("_encstr_812A1DA3D3BF5078EB5F2B4F2BF2B4305AE148F97D11082FF2B7092BA77A7E");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 120;
  patchoutofboundstrigger();
}

cp_raid_complex_behavior() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BAB71531912AF8DE5BB236993A778651C4F459BB3FD7F8");
  var_0 = self.origin + anglestoup(self.angles) * 2.5;

  for(;;) {
    playFX(scripts\engine\utility::getfx("_encstr_AAC8119D663CBE36A1D79C2B197DC6D2D9341D"), var_0);
    playsoundatpos(self.origin, "_encstr_85751076162A77ABAF3F49B072C7C14B227A");
    wait 1.0;
  }
}

location_tracker(var_0) {
  var_1 = self.entity;
  var_1 notify("_encstr_BAB71531912AF8DE5BB236993A778651C4F459BB3FD7F8");
  level._id_13460.cp_dntsk_raid_sound_load--;
  _id_13EEB();

  if(level._id_13460.cp_dntsk_raid_sound_load < 1)
    hidetimedrunhudfromplayer(var_1);

  playsoundatpos(var_1.origin, "_encstr_88AB1212CE1DB91788DB67B7747FDA0B350F442F");
  var_0 thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_A52119A7D36A1134E0C317B215FB9E6969E79FEB09C9C95B6D93F1", 1.17);
  var_0 objective_show_for_mlg_spectator();
  var_0 _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::_id_12D23("_encstr_A79D0A6A9793E1AB1847020B");
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_3 = vectorNormalize(var_1.origin - (var_1._id_140B8.origin[0], var_1._id_140B8.origin[1], var_1.origin[2])) * 5;
  var_4 = var_1.origin - var_3;
  var_5 = vectortoangles(var_1.origin - var_4) + (0, 45, 0);
  _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41("_encstr_AF491213931BDEDB477DED339934587391BE3686", var_2, var_4, var_5, 1, 0, 0);
  level._id_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove(level._id_13460.cpcpammoarmorcratecapturecallback, var_1);
  var_1 scripts\mp\gameobjects::releaseid();
  var_1 notify("_encstr_8BE208E31FA8E1631D65");
  var_1 delete();
  waitframe();
}

lbravo_spawner_jammer4b() {
  self endon("_encstr_AD75063D571AE108");
  wait(randomfloatrange(0.0, 1.25));
  self setscriptablepartstate("_encstr_B8AD0F4F17BAAF10D76369830182904122", "_encstr_860808CB78E2984063BA", 0);
  playsoundatpos(self.origin, "_encstr_A3D70E1B68FAB21E0EB1D73AC98573B9");
  self notify("_encstr_BAB71531912AF8DE5BB236993A778651C4F459BB3FD7F8");
  level._id_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove(level._id_13460.cpcpammoarmorcratecapturecallback, self);
  scripts\mp\gameobjects::releaseid();
  self notify("_encstr_8BE208E31FA8E1631D65");
  wait 10;
  self delete();
}

_id_13546() {
  var_0 = [];
  var_0[0] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
  var_0[1] = "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2";
  var_0[2] = "_encstr_96AF286AC692E00FF38E3B2337C0A2F0578BDA3A1C61AF88D235C60598A34293E861379E0F661F18F012";

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
    var_0[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
    var_0[4] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
  } else {
    var_0[3] = "_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B";
    var_0[4] = "_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5";
  }

  playFX(scripts\engine\utility::getfx("_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"), self.origin);
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_1.ml_p3_to_safehouse_transition = 0;
  var_2 = vectorNormalize(self.origin - (self._id_140B8.origin[0], self._id_140B8.origin[1], self.origin[2])) * 5;
  var_3 = self.origin - var_2;
  var_4 = vectortoangles(self.origin - var_3) + (0, 90, 0);

  foreach(var_6 in var_0) {
    if(_encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::get_bonus_targets(var_6))
      _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_6, var_1, var_3, var_4, 1, 0, 0);
  }
}

_id_11A17() {
  if(istrue(self.updateteamscoreplacements)) {
    if(self._id_12200 + 1 >= self._id_1220E.size)
      self.updateteamscoreplacements = 0;
    else
      self._id_12200 = self._id_12200 + 1;
  } else if(self._id_12200 - 1 < 0)
    self.updateteamscoreplacements = 1;
  else
    self._id_12200 = self._id_12200 - 1;
}

_id_13450(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_0)) {
      self setvehgoalpos(self._id_1220E[0], 1);
      self.pathgoal = self._id_1220E[0];
    } else {
      self setvehgoalpos(var_0, 1);
      self.pathgoal = var_0;
    }

    if(isDefined(self.currenttarget) && self.currentaction == "_encstr_AD1C0A291B7C0BBEA2BFFDE7")
      self setlookatent(self.currenttarget);
    else
      self clearlookatent();

    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
    var_1 = randomintrange(level._id_13460._id_1345C, level._id_13460._id_1345B);
    var_2 = randomint(10);
    wait(var_1);

    if(var_2 > 5)
      self.updateteamscoreplacements = !self.updateteamscoreplacements;

    _id_11A17();
    var_0 = self._id_1220E[self._id_12200];
  }
}

_id_1344D() {
  var_0 = undefined;

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D")
    var_0 = (20213, -14849, 5141);
  else
    var_0 = (-479, 909, 5141);

  return var_0;
}

_id_1344F() {
  playsoundatpos(self.origin, "_encstr_9193131BD14BFF9D9875F9D67749E72BEF680242B9");
  earthquake(1, 3, self.origin, 1000);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
  physicsexplosionsphere(self.origin, 1000, 100, 2);
}

_id_11A16(var_0) {
  if(self.currentaction != "_encstr_96080730D8534E0A28")
    self.currentaction = "_encstr_96080730D8534E0A28";
  else if(self.currentaction == "_encstr_96080730D8534E0A28" && !istrue(var_0)) {
    return;
  }
  self clearlookatent();
  self setneargoalnotifydist(500);
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    foreach(var_4 in self._id_1220E) {}

    if(self.currentaction == "_encstr_AD1C0A291B7C0BBEA2BFFDE7") {
      if(!istrue(var_1))
        var_1 = 1;

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1))
      var_1 = 0;

    scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(self._id_1220E[0], 1);
    _id_11A17();
    wait 0.5;
  }
}

_id_13EF3() {
  self.soldier_agent_lwfn4 = _id_13EE0(&"_encstr_BE8B1AEEBE393697B0B985034FE47FB6D017516F6158290570999124", -1, 1.0, (1, 1, 1), 0, 50);
  self.soldier_agent_lwfn5 = _id_13EE1();
  self.soldier_agent_lwfn6 = _id_13EE0(&"_encstr_8A8B2AC723A0C7F1382717609CDDC10BB9CF5157EF893751078A5C47F793215DF07FFBF5DF80FEB16214A47D", -1, 1.2, (1, 1, 1), -300, 85);
  _id_13EF5();
  _id_13EF6(level._id_13460.current_state);
}

_id_13EF4() {
  if(!isDefined(self._id_13461)) {
    return;
  }
  foreach(var_1 in self._id_13461) {
    var_1 scripts\mp\hud_util::destroyelem();
    self._id_13461 = scripts\engine\utility::array_remove(self._id_13461, var_1);
    var_1 = undefined;
  }

  self._id_13461 = undefined;
}

_id_13EF5() {
  if(!isDefined(self._id_13461)) {
    return;
  }
  foreach(var_1 in self._id_13461)
  var_1 scripts\mp\hud_util::hideelem();
}

_id_13EEA(var_0) {
  foreach(var_2 in level._id_13460._id_12662)
  var_2 _id_13EF6(var_0);
}

_id_13EE8() {
  foreach(var_1 in level._id_13460._id_12662)
  var_1 _id_13EF3();
}

_id_13EE9() {
  foreach(var_1 in level._id_13460._id_12662)
  var_1 _id_13EF4();
}

_id_13EF6(var_0) {
  _id_13EF5();

  switch (var_0) {
    case "_encstr_8882099673858D1D4B6756":
      break;
    case "_encstr_930B07BB1B6B3854FF":
      self.soldier_agent_lwfn4 setvalue(4 - level._id_13460.cp_dntsk_raid_sound_load);
      self.soldier_agent_lwfn4 scripts\mp\hud_util::showelem();
      var_1 = undefined;

      if(level._id_13460._id_13B97 <= 0)
        var_1 = 120;
      else {
        var_2 = level._id_13460._id_13B97 / 1000;
        var_3 = gettime() / 1000;
        var_4 = var_3 - var_2;
        var_1 = 120 - var_4;
      }

      self.soldier_agent_lwfn5 settimer(var_1);
      self.soldier_agent_lwfn5 scripts\mp\hud_util::showelem();
      break;
  }
}

_id_13EEB() {
  foreach(var_1 in level._id_13460._id_12662)
  var_1.soldier_agent_lwfn4 setvalue(4 - level._id_13460.cp_dntsk_raid_sound_load);
}

_id_13EDF(var_0) {
  if(!isDefined(self._id_13461))
    self._id_13461 = [];

  self._id_13461 = scripts\engine\utility::array_add(self._id_13461, var_0);
}

_id_13EE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6))
    var_6 = "_encstr_AF9F08DB601069806D49";

  var_7 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", var_2);
  var_8 = 40;
  var_9 = (1.0 - getdvarfloat("_encstr_B1B90BF18220754798F7C9D19B", 0)) * var_8;
  var_10 = (1.0 - getdvarfloat("_encstr_8C180BDB616CA32853516D1229", 0)) * var_8 / 2;
  var_7 scripts\mp\hud_util::setpoint(var_6, var_6, 143 + var_9, var_5 + var_10);
  var_7.color = var_3;
  var_7.label = var_0;
  var_7 setvalue(var_1);
  _id_13EDF(var_7);
  return var_7;
}

_id_13EE1() {
  var_0 = newclienthudelem(self);
  var_0.elemtype = "_encstr_9A6C06E43B201F1A";
  var_0.font = "_encstr_8B1608EC43B8D647A113";
  var_0.fontscale = 1.25;
  var_0.basefontscale = 1.25;
  var_0.width = 0;
  var_0.height = 10;
  var_1 = 40;
  var_2 = (1.0 - getdvarfloat("_encstr_B1B90BF18220754798F7C9D19B", 0)) * var_1;
  var_3 = (1.0 - getdvarfloat("_encstr_8C180BDB616CA32853516D1229", 0)) * var_1 / 2;
  var_0.x = 65 + var_2;
  var_0.y = 60 + var_3;
  var_0.xoffset = 25;
  var_0.yoffset = 0;
  var_0.children = [];
  var_0.hidden = 0;
  _id_13EDF(var_0);
  return var_0;
}

_id_13291(var_0) {
  foreach(var_2 in level._id_13460._id_12662)
  var_2 playlocalsound(var_0, undefined, undefined, 1);
}