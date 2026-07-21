/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_obj_airfield.gsc
**********************************************************/

main() {
  level.airfield_obj_func = ::register_objectives;
  level thread little_bird_mg_handleflarefire();
}

obj_default_init(var_0, var_1) {
  scripts\cp\utility::skydivestreamhintdvars("_encstr_967B0985969CCC2D561B19");
  level.initlocationcircle = "_encstr_833407DEB619332895";
  level.initlethalmaxoffsetmap = "_encstr_833407DEB619332895";
}

obj_default_end(var_0) {}

obj_default_beat(var_0) {}

obj_default_start(var_0) {
  var_1 = "_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8";

  if(getdvarint("_encstr_B15F13C173303F0F1D38FA31E1E1333960E9795FE5") > 0)
    var_1 = "_encstr_BDB51520BAB2FD18AF2C75E03EAB80A59B613830D20B35";

  scripts\engine\utility::delaythread(3, scripts\cp\utility::teleportallplayersinteamtostructs, "_encstr_9A8507BA4040188D08", var_1, 1);
}

precache_fx() {
  level._effect["_encstr_B2D30F8A7069EB3EF0BB27E57910496701"] = loadfx("_encstr_BE52243B07CA3744F782E87FD1CFA329A316E5C858A5866FB2B3AA97C96F11A15F23CD90169B");
  level._effect["_encstr_A5D30FADD2D8C4853756F5CAE107F51B3B"] = loadfx("_encstr_AD3D243B99C379D2EE70F53638BC3B990FAFC4856EACEBC6854E76BDEB593C07D78CC59D99E1");
  level._effect["_encstr_9AF1131BB09CB3BDFA2B1E07AFC45DB46323D2B976"] = loadfx("_encstr_A1172BECCC3C5E2DBBE0FA8D8397B399E1EB13C2CD2BF5365893B3BDFA563C07D798D5B436192D73B3C59D991E");
  level._effect["_encstr_95A20F2FA8EBCF5A0F05A0DA6011129FB3"] = loadfx("_encstr_9319278376A36EF0BB1FC0678A0AD3E751A0D6770787411FF110DAA27FCDB0D90F80B0B01A6DD06619");
  level._effect["_encstr_8E500EA20FD32F615FE042DA694360B3"] = loadfx("_encstr_AC5521E3B071B5DF9B7337036FA89BAFD9E12AEA7013116FB0B014078D2ACB653D8013");
  level._effect["_encstr_99B91250F35864D3F0A3B2A9EBDFDF9DA073C2A5"] = loadfx("_encstr_88362ED39980C0D07742512BC9CEB9C46843D8D7B52E2EF3DAC7475BA1FF9933C05196540A60F6A1934801CC5A4575D0");
  level._id_14049 = 1;
}

register_objectives() {
  _id_12B06();
  scripts\cp\cp_objectives::registerobjective("_encstr_833407DEB619332895", ::obj_default_init, ::ba_mnu_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_91DE0FCE21588B3BBFE35B595680ABA567", ::obj_default_init, ::ba_shiprecieve_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_81710A9E91485D88655BB2D0", ::obj_default_init, ::ba_router_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_81650F7EC919938A673547637B96F2F910", ::obj_default_init, ::ba_searchareas_start, ::obj_default_end, ::obj_default_beat, ::ba_searcarea_debug_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_8F6F09C485BEA3DEEE95C9", ::obj_default_init, ::ba_tower_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_ACF90EB5F781CED8E5DE8D7E83C9C00A", ::obj_default_init, ::ba_steal_tank_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_8B0A114C85EBC82B6ED1937B97F5A30B37B6CD", ::obj_default_init, ::ba_destroy_tanks_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_BE6708163FAF38504F61", ::obj_default_init, ::obj_default_init, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_AC6708780A21B1EDE765", ::obj_default_init, ::obj_default_init, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_B867082D0B9F030A9341", ::obj_default_init, ::obj_default_init, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_A62A0FCEE7E7AA022891F707838DF94259", ::obj_default_init, ::obj_default_init, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_95B20F9816BEB731A6FA4CAF0EC685B947", ::obj_default_init, ::obj_default_init, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_97360F4C58FAEDC4A6F5D8FA388DB0CDE8", ::obj_default_init, ::obj_default_init, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_87F80A98C2AFACE61B8583B2", ::obj_default_init, ::ba_escape_start, ::obj_default_end, ::obj_default_beat, ::ba_escape_debug_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_88370F5179B989935F27282D977BF94548", ::obj_default_init, ::ba_escape_start_tank, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
}

ba_escape_debug_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B");
  scripts\engine\utility::flag_wait("_encstr_B12F24A0BB6903E803B6636D846316CF8A7238E002B19FE16BD1F7DD5F97D88B724A8068BA17");
  wait 0.5;
  level.use_alt_b = randomint(100) > 49;
  scripts\engine\utility::flag_init("_encstr_B6110C580E3660EF4317B9A73BDA");
  scripts\engine\utility::flag_init("_encstr_B1750B77C8E8A68B6FE5057D5D");
  scripts\engine\utility::flag_init("_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08");
  scripts\engine\utility::flag_init("_encstr_B6270E371A5A1C075AE6D9EB237B3756");
  scripts\engine\utility::flag_init("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  scripts\engine\utility::flag_init("_encstr_AA5E0FFD3B8D03DE6750813AF89F168399");
  scripts\engine\utility::flag_init("_encstr_92EC0D29472272508F0A5308F59D70");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "_encstr_85EF190BAB40E5FF3121D38A28AF77DC9801AF6CD3306FFBF0738F";
  level.pkg_lbl[1] = "_encstr_8AEF19374BCEE67D6BB2E8B08DD79BD0B4C1F5632C89CA63FA0626";
  level.pkg_lbl[2] = "_encstr_97EF19CDB4CE73D7B6B2E88563F5DC345AC1FAD8C226B21BD7C019";
  level.pkg_lbl[3] = "_encstr_ADEF191F297F37398338E4125D9FA870547AC88D9FB2D1254929B7";
  level.pkg_lbl[4] = "_encstr_81EF19CD969D737D5B59D116C6D76ED02D0EBED88531B2B1FA03D0";
  level.pkg_lbl[5] = "_encstr_AAEF19808AC7FDCE9F550D8F242F33B92C8369C0A25E13607F28B5";
  level.pkg_lbl[6] = "_encstr_96EF199B4B9D9BAF5BAC4716D8D79BD0961CEB36B098CAD87D60B1";
  level.pkg_lbl[7] = "_encstr_88EF196E2D9DDCAFD6B247B0B1AFE6D0D2C17D1BB03159C6FA81E6";
  level._id_12386 = [];
  level._id_12386[0] = "_encstr_B8E12C321E7DD80737AFB1C2DCCDF531B0372BBE859BE616AEC6477D83D85836B2EB982B586CED37AF6013E49B85";
  level._id_12386[1] = "_encstr_87FE2C8023716FA37FE78977A3170E35A63B30D12A9287595FCC8D6098B331FF0F818098C22EC7F01FB9B64C35A3";
  level._id_12386[2] = "_encstr_A9102CC80FAFB11C37AFB10BCDCDBE26856E2BBE2CB9B958571BA3F583362C36ACAF98B2B01BF69BAF646623D4C6";
  level._id_12386[3] = "_encstr_86632C8C0F7DD8C16EFA8D58DC6E7D4C2C9B95BE2CCDDCB0AEB18EFA3863C23659AF26CA0B6CDB73F5CC0D861B19";
  level._id_12386[4] = "_encstr_915F2C3093C1DF13EF7719873387BEA5364BA061BA6237C92F7C1D9028C3A16F9F11100852BE5760AFCC855F450F";
  level._id_12386[5] = "_encstr_887C2C913CBE8D83B9FA8D1637CDBE890B37ACFAB0CD9BB057D8477DC11BC2B195D7C4CAC2C6F6E6D753C6199933";
  level._id_12386[6] = "_encstr_8AFB2CCD787F69E9D2E178281BEAFF01DF1BC528F967D313BB3AB0D14345BBF9278FDEBD51DF98456987B28A4F5F";
  level._id_12386[7] = "_encstr_B1A92C23A8D0B2CB7AF94B6B9B1769B5E15FEA7898E8708B7B4009E1780B2198C701F122380E85B01E1BA2B2BA9B";
  setup_search_areas();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_836117B9D7B2E2A1143F03FBA9F8F02F3B2F2D6727BBBFB04C");
  level scripts\engine\utility::delaythread(10, ::spawn_enemy_tanks);
}

ba_searcarea_debug_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B");
  scripts\engine\utility::flag_wait("_encstr_B12F24A0BB6903E803B6636D846316CF8A7238E002B19FE16BD1F7DD5F97D88B724A8068BA17");
  level.use_alt_b = randomint(100) > 49;
  scripts\engine\utility::flag_init("_encstr_B6110C580E3660EF4317B9A73BDA");
  scripts\engine\utility::flag_init("_encstr_B1750B77C8E8A68B6FE5057D5D");
  scripts\engine\utility::flag_init("_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08");
  scripts\engine\utility::flag_init("_encstr_B6270E371A5A1C075AE6D9EB237B3756");
  scripts\engine\utility::flag_init("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  scripts\engine\utility::flag_init("_encstr_AA5E0FFD3B8D03DE6750813AF89F168399");
  scripts\engine\utility::flag_init("_encstr_92EC0D29472272508F0A5308F59D70");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "_encstr_85EF190BAB40E5FF3121D38A28AF77DC9801AF6CD3306FFBF0738F";
  level.pkg_lbl[1] = "_encstr_8AEF19374BCEE67D6BB2E8B08DD79BD0B4C1F5632C89CA63FA0626";
  level.pkg_lbl[2] = "_encstr_97EF19CDB4CE73D7B6B2E88563F5DC345AC1FAD8C226B21BD7C019";
  level.pkg_lbl[3] = "_encstr_ADEF191F297F37398338E4125D9FA870547AC88D9FB2D1254929B7";
  level.pkg_lbl[4] = "_encstr_81EF19CD969D737D5B59D116C6D76ED02D0EBED88531B2B1FA03D0";
  level.pkg_lbl[5] = "_encstr_AAEF19808AC7FDCE9F550D8F242F33B92C8369C0A25E13607F28B5";
  level.pkg_lbl[6] = "_encstr_96EF199B4B9D9BAF5BAC4716D8D79BD0961CEB36B098CAD87D60B1";
  level.pkg_lbl[7] = "_encstr_88EF196E2D9DDCAFD6B247B0B1AFE6D0D2C17D1BB03159C6FA81E6";
  level.obja = scripts\cp\cp_objectives::requestworldid("_encstr_A5F00AEC5D19929B804F7331");
  level.objb = scripts\cp\cp_objectives::requestworldid("_encstr_83F00A05A8E7325C2D48834B");
  level.objc = scripts\cp\cp_objectives::requestworldid("_encstr_8BF00AB208B736BB48E83613");
  level.objplanta = scripts\cp\cp_objectives::requestworldid("_encstr_A5F00AEC5D19929B804F7331");
  level.objplantb = scripts\cp\cp_objectives::requestworldid("_encstr_83F00A05A8E7325C2D48834B");
  level.objplantc = scripts\cp\cp_objectives::requestworldid("_encstr_8BF00AB208B736BB48E83613");
  level scripts\cp\cp_hacking::hacking_init();
  setup_search_areas();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_836117B9D7B2E2A1143F03FBA9F8F02F3B2F2D6727BBBFB04C");
  wait 5;
}

ba_escape_start(var_0) {
  scripts\engine\utility::flag_init("_encstr_93D00ED3760F28BFBF521679BA5367CB");
  thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil();
  thread scripts\cp\cp_objectives::run_objective("_encstr_8F6F09C485BEA3DEEE95C9");
  scripts\engine\utility::flag_wait("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  thread old_health();
  thread scripts\cp\cp_objectives::run_objective("_encstr_ACF90EB5F781CED8E5DE8D7E83C9C00A");
  scripts\engine\utility::flag_wait("_encstr_92EC0D29472272508F0A5308F59D70");
  wait 1;
  thread scripts\cp\cp_objectives::run_objective("_encstr_88370F5179B989935F27282D977BF94548");
  scripts\engine\utility::flag_wait("_encstr_AA5E0FFD3B8D03DE6750813AF89F168399");
  level notify("_encstr_91750BE60B41C076B37326D770", (15809.5, 48806.5, 1172.78), 1);
  level thread monitor_flag_carrier();
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  level waittill("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  level.exfil_heli.onexitfunc = 40;
  scripts\cp\utility::_id_123FE("_encstr_BE9F1C41ABC34F81989FB8D873A43877BB97D0D9047BDF087F4319E00BFC");

  foreach(var_2 in level.players)
  var_2 setsoundsubmix("_encstr_822C12BE606FB8DB03126818DA5FEFF0BF0B3326", 5);

  scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
  level thread vo_mission_end();
  ba_end_sequence(level.heli_trip_vehicle);
}

ba_end_sequence(var_0) {
  var_1 = var_0.origin + anglestoleft(var_0.angles) * 30 + (0, 0, -85) + anglesToForward(var_0.angles) * -20;
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = (0, 200, 0);
  var_2 linkTo(var_0);

  foreach(var_4 in level.players)
  var_4 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_4 in level.players) {
    var_4 allowfire(0);
    var_4 disableoffhandweapons();
    var_4 disableusability();
    var_4 allowmovement(0);
    var_4 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_4 spawn_endgame_camera(var_2);
    var_4 thread scripts\cp_mp\xmike109::screenent_d("_encstr_8171081A85DC7B09740F");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3)
        var_4 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_A1F50CDAABD916B1462CD7B6B791");
      else
        var_4 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_8316107BF034FF21198E1E9AA755078668FB");
    }

    var_4 lerpfovscalefactor(0, 0);
  }

  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_BA09099DA5F9CC40D8DD63", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_88790841A4862D62A29A", 1);
  thread do_killstreaks();
  wait 2;
  thread detonate_explosives();
  wait 8;

  foreach(var_9 in level.spawned_ai) {
    if(isDefined(var_9))
      var_9 dodamage(var_9.health + 100, var_9.origin);
  }

  scripts\engine\utility::flag_set("_encstr_93D00ED3760F28BFBF521679BA5367CB");
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}

do_killstreaks() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.airfield_plant_spots;

  for(;;) {
    var_1 = scripts\engine\utility::random(var_0).origin;
    var_2 = level.players[0] scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", level.players[0]);
    level.players[0] scripts\cp_mp\killstreaks\toma_strike::tomastrike_attacktarget(3, undefined, var_1, var_2);
    wait 5;
  }

  wait 5;
}

get_direction_override() {
  var_0 = (5017.1, 46621.4, 1184.12) - self.origin;
  return var_0;
}

ba_escape_start_tank(var_0) {
  scripts\cp\utility::_id_123FE("_encstr_AD061B8AABAB81EB2B763851B6CAF9C7305D2F0347251DCEEF3A3192D0");
  var_1 = var_0.objectiveindex;
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  var_2 = scripts\engine\utility::getStruct("_encstr_8A4C0BDB13A6D7ACCD36C283B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_position(var_1, getgroundposition(scripts\engine\utility::getStruct("_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, 8) + (0, 0, 60));
  objective_setplayintro(var_1, 1);
  scripts\cp\cp_objectives::_id_11F80(var_1);
  objective_setlabel(var_1, &"_encstr_82C020355927F1195D0AC39F75F139AB07300C3D91A708A1A223CB915D29F167E7D8");
  _id_1436D(scripts\engine\utility::getStruct("_encstr_8A4C0BDB13A6D7ACCD36C283B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, 1500);
  scripts\engine\utility::flag_set("_encstr_AA5E0FFD3B8D03DE6750813AF89F168399");
}

_id_1436D(var_0, var_1) {
  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) < var_1)
        var_2 = 1;
    }

    if(var_2) {
      break;
    }

    wait 0.25;
  }
}

brdoesloadoutoptionusedropbags(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = [];
  var_5 = [];

  foreach(var_7 in level.players) {
    if(var_7.team == "_encstr_8E8405EA382B2A") {
      var_4[var_4.size] = var_7;
      continue;
    }

    var_5[var_5.size] = var_7;
  }

  foreach(var_7 in var_5) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_7))
      var_3++;

    if(distance(var_7.origin, var_0) < var_1)
      var_2++;
  }

  return var_2 > 0 && var_5.size == var_2 + var_3;
}

ba_mnu_start(var_0) {
  _encstr_91BC3DB9C69CA53847DC978D1C5EDAC20EB9E58D1CFAC8B7E6CAA36EB579C61C7D46DB73AC3A9BDAAFCDC23395D0BDD56EACD7360BDC461B7B939117EC37B1::_id_13776();
}

ba_shiprecieve_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B");
  scripts\engine\utility::flag_wait("_encstr_B12F24A0BB6903E803B6636D846316CF8A7238E002B19FE16BD1F7DD5F97D88B724A8068BA17");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_8ADB137B8935EBDE3B569CEEB08E8DD0FA86AC36D2");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_97F214C8922C07501BADF66C813B99D1D95B2048FA82");
  scripts\cp\coop_stealth::coop_stealth_init();
  level._id_139B5 = 1;
  level.use_alt_b = randomint(100) > 49;
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "_encstr_85EF190BAB40E5FF3121D38A28AF77DC9801AF6CD3306FFBF0738F";
  level.pkg_lbl[1] = "_encstr_8AEF19374BCEE67D6BB2E8B08DD79BD0B4C1F5632C89CA63FA0626";
  level.pkg_lbl[2] = "_encstr_97EF19CDB4CE73D7B6B2E88563F5DC345AC1FAD8C226B21BD7C019";
  level.pkg_lbl[3] = "_encstr_ADEF191F297F37398338E4125D9FA870547AC88D9FB2D1254929B7";
  level.pkg_lbl[4] = "_encstr_81EF19CD969D737D5B59D116C6D76ED02D0EBED88531B2B1FA03D0";
  level.pkg_lbl[5] = "_encstr_AAEF19808AC7FDCE9F550D8F242F33B92C8369C0A25E13607F28B5";
  level.pkg_lbl[6] = "_encstr_96EF199B4B9D9BAF5BAC4716D8D79BD0961CEB36B098CAD87D60B1";
  level.pkg_lbl[7] = "_encstr_88EF196E2D9DDCAFD6B247B0B1AFE6D0D2C17D1BB03159C6FA81E6";
  level._id_12386 = [];
  level._id_12386[0] = "_encstr_B8E12C321E7DD80737AFB1C2DCCDF531B0372BBE859BE616AEC6477D83D85836B2EB982B586CED37AF6013E49B85";
  level._id_12386[1] = "_encstr_87FE2C8023716FA37FE78977A3170E35A63B30D12A9287595FCC8D6098B331FF0F818098C22EC7F01FB9B64C35A3";
  level._id_12386[2] = "_encstr_A9102CC80FAFB11C37AFB10BCDCDBE26856E2BBE2CB9B958571BA3F583362C36ACAF98B2B01BF69BAF646623D4C6";
  level._id_12386[3] = "_encstr_86632C8C0F7DD8C16EFA8D58DC6E7D4C2C9B95BE2CCDDCB0AEB18EFA3863C23659AF26CA0B6CDB73F5CC0D861B19";
  level._id_12386[4] = "_encstr_915F2C3093C1DF13EF7719873387BEA5364BA061BA6237C92F7C1D9028C3A16F9F11100852BE5760AFCC855F450F";
  level._id_12386[5] = "_encstr_887C2C913CBE8D83B9FA8D1637CDBE890B37ACFAB0CD9BB057D8477DC11BC2B195D7C4CAC2C6F6E6D753C6199933";
  level._id_12386[6] = "_encstr_8AFB2CCD787F69E9D2E178281BEAFF01DF1BC528F967D313BB3AB0D14345BBF9278FDEBD51DF98456987B28A4F5F";
  level._id_12386[7] = "_encstr_B1A92C23A8D0B2CB7AF94B6B9B1769B5E15FEA7898E8708B7B4009E1780B2198C701F122380E85B01E1BA2B2BA9B";
  thread spawn_intro_choppers();
  thread init_alarm_system();
  init_ba_objective();
  scripts\cp\cp_computerscreen::init_computer_anims();
  var_1 = setup_router_objective(var_0);
  var_2 = var_0.objectiveindex;
  level.ba_router = var_1;
  level thread sniper_interaction();
  level thread _id_142F2();

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, squared(250)))
    wait 0.1;

  var_3 = scripts\engine\utility::getclosest(var_1.origin, level.players);
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_3, "_encstr_ABBD0BB789A6EB675A37AE5863");

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_3 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
    wait 0.5;
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var_3, "_encstr_BD1E13BD4CD4F5C82B9D5A6C95F5E695E8E8A5373B");
    break;
  }

  level._id_12DBE = var_1;
  level notify("_encstr_85620E029D73756572AFD070B1378DF1");
  level._id_12DBD = 1;
  level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

ba_router_start(var_0) {
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B81D0B342D63C67D47DBC1EB4C");
  var_1 = var_0.objectiveindex;
  objective_setlabel(var_1, &"_encstr_934A1EA105BE6A92262128D42AFA44520AC4E98EAA155E2C8C2AA4F522281528");
  objective_position(var_1, level._id_12DBE.origin + (0, 0, 10));
  scripts\cp\cp_objectives::_id_11F80(var_1);
  level.ba_router makeunusable();
  level.ba_router setModel("_encstr_AFAA1DF783ABC1A329532B5B3F4E9A15F0E9AAF1D960919B6863235BBBF6A2");
  level.ba_router setscriptablepartstate("_encstr_A7F409337A498D17F7B75B", "_encstr_99AD06D3A5B1538B");
  level.hack_duration = 30;

  if(getdvarint("_encstr_B63C0ED6B64BD74B15FF4810E35941F7") != 0)
    level.hack_duration = getdvarint("_encstr_B63C0ED6B64BD74B15FF4810E35941F7");

  wait 1;
  level scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
  wait 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8F40280F7BC61ACBB8987CB11F12EEBDEBE69F57FFFF8F83471DDDD9C388EE693B913E4B494B21764671", "_encstr_9A8507BA4040188D08");
  var_2 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "_encstr_B6E517E5716867039BC1EB8FF1A8CA9C98B91C61CB30E14B6D");
  level thread friendly_hvi_vehicle_extra_riders_getin_scene("_encstr_BA620AF523181BD66FA88967");
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
  level.ba_router setscriptablepartstate("_encstr_A7F409337A498D17F7B75B", "_encstr_B4BA07CC5ADCB4CDD0");
  wait 1;
  scripts\engine\utility::flag_set("_encstr_B6270E371A5A1C075AE6D9EB237B3756");
  thread _id_142E0();
}

init_ba_objective() {
  level.flare_lifetime = 10;
  scripts\engine\utility::flag_init("_encstr_B6110C580E3660EF4317B9A73BDA");
  scripts\engine\utility::flag_init("_encstr_B1750B77C8E8A68B6FE5057D5D");
  scripts\engine\utility::flag_init("_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08");
  scripts\engine\utility::flag_init("_encstr_B6270E371A5A1C075AE6D9EB237B3756");
  scripts\engine\utility::flag_init("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  scripts\engine\utility::flag_init("_encstr_AA5E0FFD3B8D03DE6750813AF89F168399");
  scripts\engine\utility::flag_init("_encstr_92EC0D29472272508F0A5308F59D70");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level thread wait_for_combat_start();
  level.obja = scripts\cp\cp_objectives::requestworldid("_encstr_A5F00AEC5D19929B804F7331");
  level.objb = scripts\cp\cp_objectives::requestworldid("_encstr_83F00A05A8E7325C2D48834B");
  level.objc = scripts\cp\cp_objectives::requestworldid("_encstr_8BF00AB208B736BB48E83613");
  level.objplanta = scripts\cp\cp_objectives::requestworldid("_encstr_A5F00AEC5D19929B804F7331");
  level.objplantb = scripts\cp\cp_objectives::requestworldid("_encstr_83F00A05A8E7325C2D48834B");
  level.objplantc = scripts\cp\cp_objectives::requestworldid("_encstr_8BF00AB208B736BB48E83613");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  setup_search_areas();
}

setup_router_objective(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8A4D18584B27992D95C6C8FAB9B0CC5643B7BAE6ACBEDBE0CA37");
  wait 1;
  level thread _id_142DF();
  var_1 = getEnt("_encstr_B19811406FA54303E3698F99FEAA5B281DD3F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_A57217730B9F43C71F5957BB435832730BB18F3570E363BFA0", &"_encstr_AD5121E11AEFDDDC2909F91F097F2DF1A5C5A87FAF533A69F8B79F311709C51D399732", 25, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BECC055CF3811A", 256, 45, 72, 45);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 = var_0.objectiveindex;
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_2, var_1.origin + (0, 0, 20));
  objective_setplayintro(var_2, 1);
  scripts\cp\cp_objectives::_id_11F80(var_2);
  objective_setlabel(var_2, &"_encstr_92C522D00A7DC450938889E99288E59E12527D0A34D0A89A6AFA6A514A2B514AD7988413");
  objective_setdescription(var_2, &"_encstr_97C61EDDA2E7D91F20DB4947ABA86079528CC6159E23592EA9CF6F6BB3718DD9");
  wait 2;
  return var_1;
}

wait_for_combat_start() {
  scripts\engine\utility::flag_init("_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB");
  wait 3;
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_832514E0778341574283647C119B7B88F6137BF8D72D", 1, 1, 1, 0, 0, "_encstr_A3D10F9390D127B1ADFD0CC554AF5BEB39", ::end_spawn_group, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_832514E0778341574283647C119B7B88F6137BF8D72D", ::vehicle_damage_onenterstatemedium);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A26614A3B23D7F4613D98874B1130E3B655A70606A92", 8, 8, 8, 0.1, 0, "_encstr_A26614A3B23D7F4613D98874B1130E3B655A70606A92");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B3612A7C6BB5BF9F85F20500F0F138F132A888F", 4, 4, 4, 0.5, 0, "_encstr_9B3612A7C6BB5BF9F85F20500F0F138F132A888F", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_863612A9CF6BFF483003EBC1A1E71820F3737FB5", 4, 4, 4, 0.5, 0, "_encstr_863612A9CF6BFF483003EBC1A1E71820F3737FB5", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B36129AA910E14A439BBBF7E7FC63578013D932", 4, 4, 4, 0.5, 0, "_encstr_8B36129AA910E14A439BBBF7E7FC63578013D932", undefined, undefined, 5);
  level thread targets_killed();
  scripts\engine\utility::flag_wait("_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB");
  level notify("_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB");
  level._id_139B5 = 0;
  wait 2;
  level thread mortar_launch_think();
  level thread paratrooper_logic(["_encstr_9B3612A7C6BB5BF9F85F20500F0F138F132A888F", "_encstr_863612A9CF6BFF483003EBC1A1E71820F3737FB5", "_encstr_8B36129AA910E14A439BBBF7E7FC63578013D932"]);
  call_in_reinforcements();
  wait 3;
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "_encstr_8F6F13C2A5E433D2ACB1917D91CACCB0AE1BD1AF13");
  wait 60;
  level thread spawn_enemy_chopper();
}

reinforcement_loop() {
  level endon("_encstr_BDC1146E3ADBE0F59356B4CD337B4E8D59DAACCDA3CD");

  for(;;) {
    while(level.spawned_ai.size >= 8)
      wait 1;

    call_in_reinforcements();
    wait(randomintrange(30, 45));
  }
}

paratrooper_logic(var_0) {
  level endon("_encstr_B46E1243AB3091CF130AC2B903AB5068D37A2AF3");
  wait 90;

  for(;;) {
    while(level.spawned_ai.size >= 8)
      wait 1;

    var_1 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(var_0), undefined, (-13512, 66432, 5904));

    if(isDefined(var_1) && var_1.size > 0)
      thread _id_142EC();

    wait 30;
  }
}

ba_searchareas_start(var_0) {
  foreach(var_2 in level.all_search_areas) {
    if(var_2.script_noteworthy == "_encstr_87370AFD69707F3AB8D3BBD3" && !level.use_alt_b) {
      continue;
    }
    if(var_2.script_noteworthy == "_encstr_AFF6062299E2A746" && level.use_alt_b) {
      continue;
    }
    var_2.useobj makeusable();
  }

  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A6BA1E56F1E8116013C097D2057E0D59C764FC178BD188ADC35B7C0AE7F5A0CA");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8D1F31521AB89702B8975F4E99B1CEE7D6D1798AC30657BB98F9773385E0590B7789B2B288D4F776A8235024BB389F3AB06B7F");
  wait 1;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_84BA1EC1D9097BCCDBB257564D6F95BB6680295921D7C7E4C79B4A2F6F6BBE19");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B42B315BE0C12691F35720FB72D162E7DF3DE14ACB8B3F252BE8616660E29FAC30799753E8C1491F2F88E0C5E10D01DAC7C6F1");
  objective_state(level.obja, "_encstr_AF5A081BBAC993AC73A3");
  objective_state(level.objb, "_encstr_AF5A081BBAC993AC73A3");
  objective_state(level.objc, "_encstr_AF5A081BBAC993AC73A3");
  objective_setshowoncompass(level.obja, 1);
  objective_setshowoncompass(level.objb, 1);
  objective_setshowoncompass(level.objc, 1);
  objective_setplayintro(level.obja, 1);
  objective_setplayintro(level.objb, 1);
  objective_setplayintro(level.objc, 1);
  objective_setlabel(level.obja, &"_encstr_88301A2ECFA1A7980CD80F11858FEFDB4184EDDF31D5BDF14FC54F3E");
  objective_setlabel(level.objb, &"_encstr_97301A0387EF4DE1FC2885D7A5380853DB11AFEFFFF5FE61EFA55ED5");
  objective_setlabel(level.objc, &"_encstr_81301ADE1769A5A3C1C6A9A3D06E790876B4E5375537C2417F7F90D0");
  objective_icon(level.obja, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_icon(level.objb, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_icon(level.objc, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");

  if(!level.use_alt_b)
    objective_position(level.objb, scripts\engine\utility::getStruct("_encstr_AFF6062299E2A746", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin);
  else
    objective_position(level.objb, scripts\engine\utility::getStruct("_encstr_87370AFD69707F3AB8D3BBD3", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin);

  objective_position(level.obja, scripts\engine\utility::getStruct("_encstr_9AF606F03AB3B818", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin);
  objective_position(level.objc, scripts\engine\utility::getStruct("_encstr_8DF606E213C5D987", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin);

  if(!level.use_alt_b)
    scripts\cp\utility::objective_update("_encstr_AC6708780A21B1EDE765");
  else
    scripts\cp\utility::objective_update("_encstr_AC6708780A21B1EDE765");

  scripts\cp\utility::objective_update("_encstr_BE6708163FAF38504F61");
  scripts\cp\utility::objective_update("_encstr_B867082D0B9F030A9341");

  if(!level.use_alt_b)
    objective_setdescription(level.objb, &"_encstr_AD7819453A6FA91D1967DFDBE6904E29D742CD9D558789582057C3");
  else
    objective_setdescription(level.objb, &"_encstr_AD7819453A6FA91D1967DFDBE6904E29D742CD9D558789582057C3");

  objective_setdescription(level.obja, &"_encstr_81781960D1EF9A1B0F9B7375B0F41B944771E8D8C91785BF05F802");
  objective_setdescription(level.objc, &"_encstr_AA78195611AF67D38B042C854708C02B79770B78BB5FD12558319B");
  objective_setdescription(var_0.objectiveindex, &"_encstr_A6FC2A871781C154B89A6556E5FFADD48FA978B0F7090F13C1D85B07A688E763FFE0579564D67193344F95B2");
  scripts\cp\cp_objectives::_id_11F80(level.obja);
  scripts\cp\cp_objectives::_id_11F80(level.objb);
  scripts\cp\cp_objectives::_id_11F80(level.objc);
  wait 3;
  scripts\engine\utility::flag_wait_all("_encstr_B1750B77C8E8A68B6FE5057D5D", "_encstr_B6110C580E3660EF4317B9A73BDA", "_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08");
  level scripts\engine\utility::delaythread(45, ::spawn_enemy_tanks);
  level _id_142D7();
}

setup_search_areas() {
  level.all_search_areas = scripts\engine\utility::getStructArray("_encstr_B4C214784263FEC01AA50757CDC69336DB9971036AAF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.all_search_areas) {
    if(var_1.script_noteworthy == "_encstr_87370AFD69707F3AB8D3BBD3" && !level.use_alt_b) {
      continue;
    }
    if(var_1.script_noteworthy == "_encstr_AFF6062299E2A746" && level.use_alt_b) {
      continue;
    }
    setup_search_area(var_1);
  }
}

setup_search_area(var_0, var_1) {
  var_0.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", scripts\engine\utility::getclosest(var_0.origin, scripts\engine\utility::getStructArray("_encstr_ABBF15B4B947AC2758368E5A7BE6FAB17BD60ED5479593", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")).origin);
  wait 1;
  var_0.useobj scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", &"_encstr_81F4146F09E1DBFB929C8AFD472FD03E8E51C5E9E921", 25, "_encstr_97C20EB5FD43A179CC6AD05152651579", "_encstr_BECC055CF3811A", 256, 120, 72, 50);
  var_0.useobj makeunusable();
  var_2 = [0, 1, 2, 3, 4, 5, 6, 7];

  switch (var_0.script_noteworthy) {
    case "_encstr_9AF606F03AB3B818":
      var_0.useobj.objindex = level.obja;
      var_0.useobj.objplant = level.objplanta;
      var_0.plantobjstr = &"_encstr_970C1A07C3712E29C2C4F40D65F7D1EA29AB618B2369903127AE7EE5";
      var_0.hint_obj_id = &"_encstr_973B236814FA6AA82594D22A97E92149BE418914E4A2D726D31ABE09AF68D3A905132A158A";
      var_0.flagname = "_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08";
      var_0.tutorial = &"_encstr_8D4F19B063A78A3112F33C25AF01E1216098E799C0364D3FC93103";
      var_0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var_0.omnvar = "_encstr_8F431202FA83E68B57D6534F775E830337BA1209";
      var_0.get_dropkit_price = "_encstr_9A620A059BD843C307922141";
      var_0.popup_omnvar = 1;
      break;
    case "_encstr_87370AFD69707F3AB8D3BBD3":
      var_0.useobj.objindex = level.objb;
      var_0.useobj.objplant = level.objplantb;
      var_0.plantobjstr = &"_encstr_8A0C1AD7C9EE3AB17738F8DFC8E835EC1707F5B0A33451743C05CEC1";
      var_0.hint_obj_id = &"_encstr_8C5F23A1A0BEA9154A52D254977A12257D2889059351EB263DA17D28D7A1A7A60A265415A8";
      var_0.flagname = "_encstr_B6110C580E3660EF4317B9A73BDA";
      var_0.tutorial = &"_encstr_852919A1147DD42A4A295AA8BC0A92943292546222F582FAA85551";
      var_0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var_0.omnvar = "_encstr_8E5712504B13EFF8DF0ED35C1D4F03FD7122E010";
      var_0.popup_omnvar = 2;
      var_0.get_dropkit_price = "_encstr_AF620AB24851E336E8B3DFBD";
      break;
    case "_encstr_AFF6062299E2A746":
      var_0.useobj.objindex = level.objb;
      var_0.useobj.objplant = level.objplantb;
      var_0.plantobjstr = &"_encstr_8A0C1AD7C9EE3AB17738F8DFC8E835EC1707F5B0A33451743C05CEC1";
      var_0.hint_obj_id = &"_encstr_8C5F23A1A0BEA9154A52D254977A12257D2889059351EB263DA17D28D7A1A7A60A265415A8";
      var_0.flagname = "_encstr_B6110C580E3660EF4317B9A73BDA";
      var_0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var_0.omnvar = "_encstr_8E5712504B13EFF8DF0ED35C1D4F03FD7122E010";
      var_0.popup_omnvar = 2;
      var_0.tutorial = &"_encstr_852919A1147DD42A4A295AA8BC0A92943292546222F582FAA85551";
      var_0.get_dropkit_price = "_encstr_A2620A399A122D9A87DBB9CA";
      break;
    case "_encstr_8DF606E213C5D987":
      var_0.useobj.objindex = level.objc;
      var_0.useobj.objplant = level.objplantc;
      var_0.plantobjstr = &"_encstr_AD0C1A17C05911ADCBE81CC596676E11E178818BB6F3299997A0960D";
      var_0.hint_obj_id = &"_encstr_92F4230D41BE6A51924A2DA2797A9025AF826228E445F589F40DF568AF1AE9A91498548A2A";
      var_0.flagname = "_encstr_B1750B77C8E8A68B6FE5057D5D";
      var_0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var_0.omnvar = "_encstr_A67D122A13A55F7D20ED512683C843A6D8A8D223";
      var_0.popup_omnvar = 3;
      var_0.get_dropkit_price = "_encstr_95620A5BB48D4C8537ACF591";
      var_0.tutorial = &"_encstr_9B6219AB49113AA3DED4B058F0BF0FA271C3253C096976C7E54FB9";
      break;
  }

  var_0._id_11E20 = scripts\engine\utility::getStruct(var_0.script_noteworthy + "_encstr_97660AF00EE789D736535088", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::array_remove(var_2, var_0.pkg_id);
  var_0.useobj thread scripts\cp\cp_computerscreen::computer_think(var_0.popup_omnvar, var_0.omnvar, var_0.pkg_id);
  var_3 = "_encstr_81190401EA65" + var_0.popup_omnvar + "_encstr_A1950FE70E1937326FE069B3A0672BDBD3";
  var_0.useobj thread scripts\cp\cp_computerscreen::computer_event_listener(var_3);
  var_0.useobj thread scripts\cp\cp_computerscreen::computer_watch_for_search(var_3);
  var_0.useobj thread wait_for_manifest_searched(var_0);
  var_0.useobj thread usability_think(var_0);
  var_0 thread _id_131E7(var_0, var_1, var_2);
  level.pkg_ids = scripts\engine\utility::array_remove(level.pkg_ids, var_0.pkg_id);
}

wait_for_manifest_searched(var_0) {
  for(;;) {
    self waittill("_encstr_91F90FB1BDB583BA472BC9FAACB3593747", var_1, var_2);

    if(int(var_1) != 2) {
      var_2 playlocalsound("_encstr_840E116CE0AFC67B6B1CEAE859C9BECCB0D21B");
      continue;
    }

    if(!isDefined(level._id_11AB7)) {
      scripts\cp\utility::_id_123FE("_encstr_A2AA19AD57B9BE6C1CEB1B85738C36B72791BE6B16DC5A33AC6EE8");
      level._id_11AB7 = 1;
    }

    var_0 notify("_encstr_AFCE08B9C685DCE6958C", var_2);
    return;
  }
}

usability_think(var_0) {
  for(;;) {
    self waittill("_encstr_A16413872F65B88DE37A6BF6239F4F603EB01B65CF", var_1, var_2);

    if(getdvarint("_encstr_AAF71972C138F7B2A65317F76DC5EA0948C86FFAFE08939B735D0F", 1))
      level thread called75percentprogress(var_0);

    if(int(var_1) != 2) {
      continue;
    }
    return;
  }
}

_id_131E7(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.airfield_plant_spots))
    level.airfield_plant_spots = [];

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = scripts\engine\utility::getStruct(var_3[var_5].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_6.angles))
      var_6.angles = (0, 0, 0);

    if(var_5 <= 2) {
      var_3[var_5].pkg_id_lbl = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
      var_3[var_5].pkg_id_lbl.angles = var_6.angles;
      var_3[var_5].pkg_id_lbl setModel(level.pkg_lbl[var_0.pkg_id]);
      var_3[var_5].plant_spot = 1;
      var_4++;
      level.airfield_plant_spots[level.airfield_plant_spots.size] = var_3[var_5];
      waitframe();
      continue;
    }

    var_7 = scripts\engine\utility::random(var_2);
    var_6 = scripts\engine\utility::getStruct(var_3[var_5].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3[var_5].pkg_id_lbl = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
    var_3[var_5].pkg_id_lbl.angles = var_6.angles;
    var_3[var_5].pkg_id_lbl setModel(level.pkg_lbl[var_7]);
    waitframe();
  }

  var_0 waittill("_encstr_AFCE08B9C685DCE6958C", var_8);
  var_0.useobj playSound("_encstr_A91D1407B069A0B707AB0B13C243D0E83B3B8FF35BCA");
  scripts\cp\utility::objective_update("_encstr_B61904310BAF" + var_0.script_noteworthy + "_encstr_AB0E07D738D80BE6D1", undefined, undefined, undefined, undefined, 3 - var_4);
  wait 1;
  objective_setlabel(var_0.useobj.objindex, var_0.tutorial);
  objective_setplayintro(var_0.useobj.objindex, 1);
  var_0.charges_planted = 0;
  var_0.num_charges_to_plant = var_4;

  foreach(var_11, var_10 in var_3) {
    if(!isDefined(var_10.plant_spot)) {
      continue;
    }
    var_10.planted_explosive = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);

    if(!isDefined(var_10.angles))
      var_10.angles = (0, 0, 0);

    var_10.planted_explosive.angles = var_10.angles;
    var_10.planted_explosive makeusable();
    var_10.planted_explosive scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", &"_encstr_A17F179B490113F775B96740B79FACA62325FF53D58FF91720", 25, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BD1805CB69C063", 70, 45, 70, 45);
    var_10.planted_explosive.objindex = var_11;
    var_10.area = var_0;
    var_10 thread waittill_planted();
  }

  level _id_142E7(level._id_12386[var_0.pkg_id]);
  level thread _id_142E9(var_0);
  level thread friendly_hvi_vehicle_extra_riders_getin_scene(var_0.get_dropkit_price);
}

waittill_planted() {
  for(;;) {
    self.planted_explosive waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    var_0 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
    self.planted_explosive setModel("_encstr_A38115E02C4EA3DCD739588C5ADBFADC5B5836D8F5360E");
    self.planted_explosive thread blink_beacon();
    self.planted_explosive makeunusable();
    self.area.charges_planted++;
    scripts\cp\cp_objectives::screenent_c("_encstr_82950C7A08A8CC5A385B5317A555");
    var_1 = self.area.num_charges_to_plant - self.area.charges_planted;
    scripts\cp\utility::objective_update("_encstr_B61904310BAF" + self.area.script_noteworthy + "_encstr_AB0E07D738D80BE6D1", undefined, undefined, undefined, undefined, 3 - var_1);

    if(self.area.charges_planted >= self.area.num_charges_to_plant) {
      break;
    }

    thread _id_142D8(self.area, var_1);
  }

  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
  objective_state(self.area.useobj.objindex, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_B61904310BAF" + self.area.script_noteworthy + "_encstr_AB0E07D738D80BE6D1");
  scripts\engine\utility::flag_set(self.area.flagname);
  level notify("_encstr_816C0D1F82557B90733BB248A24F31");
  self.area notify("_encstr_816C0D1F82557B90733BB248A24F31");
  scripts\cp\utility::_id_123FE("_encstr_B40101");

  if(!isDefined(level.calloutmarkerping_enemytodangerdecaycreate)) {
    level.calloutmarkerping_enemytodangerdecaycreate = 3;
    scripts\engine\utility::delaythread(4, ::_id_142DA, "_encstr_8D5F31460FD7B10EB9F51B0B378CEBC458CD2BEB0B379B0B57C6E8FA2659C26CED9BCDFAC6B7B6078D2BA3ACFA896E1DD78C60");
  }

  level.calloutmarkerping_enemytodangerdecaycreate--;
  thread _id_142D5(self.area, level.calloutmarkerping_enemytodangerdecaycreate);
}

blink_beacon() {
  wait 1;
  self setModel("_encstr_ADA21783C239A337F54EC2325AB7D7CD5B85D8D87DC607BE8C");
  self playSound("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF");

  for(;;) {
    wait 3;
    self setModel("_encstr_A38115E02C4EA3DCD739588C5ADBFADC5B5836D8F5360E");
    wait 1;
    self setModel("_encstr_ADA21783C239A337F54EC2325AB7D7CD5B85D8D87DC607BE8C");
    self playSound("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF");
  }
}

ba_tower_start(var_0) {
  var_1 = getEnt("_encstr_8A421320F7784F8AC67F59E8753BF75ABF6553DFF8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_1.origin + (0, 0, 10));
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setlabel(var_0.objectiveindex, &"_encstr_92271E97B7F17D2924F3B756453F33216EB10CD969F5FFAC33C4F993CF64C1D1");
  level thread hangar_door_button();
  scripts\engine\utility::flag_wait("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
}

ba_steal_tank_start(var_0) {
  var_1 = getEnt("_encstr_A9A1140D0BCDB385E4BE31CAB0D8B773F56CB039ECF6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_1.origin + (0, 0, 10));
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setdescription(var_0.objectiveindex, &"_encstr_A19A1F5327E63F5499E9E0D9C967DFE79D81D7CFDDCDEEEA8139E8203119C64334");
  var_1 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", &"_encstr_A17F179B490113F775B96740B79FACA62325FF53D58FF91720", 25, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BD1805CB69C063", 70, 45, 70, 45);
  var_1 makeunusable();
  var_1 waittill_emp_beacon_planted();
  objective_state(var_0.objectiveindex, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_ACF90EB5F781CED8E5DE8D7E83C9C00A");
  scripts\engine\utility::flag_set("_encstr_92EC0D29472272508F0A5308F59D70");
  level notify("_encstr_8E0216A16FF5B1F7CEEFC03321FF3AD03720C0F3FDA5EF65");
}

waittill_emp_beacon_planted() {
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
  scripts\cp\cp_objectives::screenent_c("_encstr_82950C7A08A8CC5A385B5317A555");
  var_0 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
  self setModel("_encstr_A38115E02C4EA3DCD739588C5ADBFADC5B5836D8F5360E");
  thread blink_beacon();
  self makeunusable();
}

ba_destroy_tanks_start(var_0) {
  while(!isDefined(level.enemy_tanks) || level.enemy_tanks.size < 4)
    wait 1;

  for(var_1 = 0; var_1 < level.enemy_tanks.size; var_1++)
    objective_setlocation(var_0.objectiveindex, var_1, level.enemy_tanks[var_1]);

  while(level.enemy_tanks.size > 0)
    wait 1;
}

init_alarm_system() {
  level.alarm_box_structs = scripts\engine\utility::getStructArray("_encstr_B6380AC2630B9CDAAF31F61E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.flare_launchers = getEntArray("_encstr_9627098BD859C7D0B63323", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.flare_launchers)
  var_1 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");

  foreach(var_4 in level.alarm_box_structs)
  _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::initialize_alarm_box(var_4);
}

call_in_reinforcements() {
  if(!scripts\engine\utility::flag_exist("_encstr_96EF141B0BB11BAF9CAC96E6CCDB93C6565BAC373ADC"))
    scripts\engine\utility::flag_init("_encstr_96EF141B0BB11BAF9CAC96E6CCDB93C6565BAC373ADC");

  if(scripts\engine\utility::flag("_encstr_96EF141B0BB11BAF9CAC96E6CCDB93C6565BAC373ADC")) {
    return;
  }
  scripts\engine\utility::flag_set("_encstr_96EF141B0BB11BAF9CAC96E6CCDB93C6565BAC373ADC");

  foreach(var_1 in level.alarm_box_structs)
  thread _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_alarm(var_1, var_1.alarm_box);

  level scripts\engine\utility::waittill_notify_or_timeout("_encstr_91B909B0D858935BD77BE6", 45);

  foreach(var_1 in level.alarm_box_structs)
  var_1 notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");

  foreach(var_6 in level.flare_launchers) {
    var_6 notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");
    var_6.attracting = 0;
  }

  foreach(var_9 in level.agentarray) {
    if(isDefined(var_9.going_to_object)) {
      var_9.going_to_object = undefined;
      var_9.goalradius = 2048;
      var_9 _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::clear_custom_anim();
    }
  }

  level.calling_reinforcements = 0;
  scripts\engine\utility::flag_clear("_encstr_96EF141B0BB11BAF9CAC96E6CCDB93C6565BAC373ADC");
  level notify("_encstr_A1FA0D28796B2169A0D790A8AA6580");
}

waittill_both_or_timeout(var_0, var_1, var_2) {
  self endon("_encstr_A66E095D3CB2ABD13787E8");
  thread dotimer(var_0);
  scripts\engine\utility::_id_1439F(var_1, var_2);
  self notify("_encstr_ABCD099BF61D96662DB223");
}

dotimer(var_0) {
  self endon("_encstr_ABCD099BF61D96662DB223");
  wait(var_0);
  self notify("_encstr_A66E095D3CB2ABD13787E8");
}

rpg_interaction() {
  var_0 = getEnt("_encstr_996B0A73428241B1F0E3A5D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_2 linkTo(var_0);
  var_3 = scripts\engine\utility::getStructArray("_encstr_9BC110FABF69FF24A5D03A4350975B9FC028", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3)
  var_5 thread _id_12DCB();
}

_id_12DCB() {
  var_0 = _id_135B3(self.origin, self.angles, "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8");
  var_0 thread scripts\cp\cp_weapon::watchweaponpickup();
}

sniper_interaction() {
  var_0 = getEntArray("_encstr_87140CBDE927212F4A7AE828E222", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread sniper_pickup();
}

sniper_pickup() {
  scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_8C28186857F02F73F9E333C5D711CCA7126FD1119F203F3A69FD", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BD1805CB69C063", 70, 45, 70, 45);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_0 scripts\cp\cp_weapons::minigun_track_target_think();
    self hide();
    self makeunusable();
    var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_8D06112DDDE0EB6EE6BEB5B463BD271CFAD61C", ["_encstr_B8FB06FF97EA2708"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    var_0 giveweapon(var_1);
    var_0 switchtoweaponimmediate(var_1);
  }
}

hangar_door_button() {
  wait 1;
  level thread rpg_interaction();
  var_0 = getEnt("_encstr_8A421320F7784F8AC67F59E8753BF75ABF6553DFF8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_84BF16C1D909476FA3B9525D272F17A3A5B1116990571BE7", 25, "_encstr_97C20EB5FD43A179CC6AD05152651579", "_encstr_BD1805CB69C063", 150, 45, 70, 45);
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_0 makeunusable();
  var_0 setModel("_encstr_82CD22D832AF3F73CB61BEA74C57598B559A91587A45552E53853D2557EB86473A92C870");
  thread _id_142E1();
  scripts\engine\utility::flag_set("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  var_0 playSound("_encstr_87C31EE636B9FAC683D7B10BDC32B1BD9C46EB43C29BECC2E4FA895D1DE8BDCD");
  _id_12B50(level.airfield_mortar_1);
  _id_12B50(level.airfield_mortar_2);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A26614A3B23D7F4613D98874B1130E3B655A70606A92");
  var_1 = scripts\engine\utility::getStructArray("_encstr_B2AF150110D006F9FE179828AD1BC05150FF9C8EF34ADE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  thread spawn_light_tank(var_3);

  wait 0.5;
  level._id_124F6 = 1;
  var_5 = getEnt("_encstr_9A6B1586E92B55D8815A6D8FF81F30B2B73B87190F7AED", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_93CF08C7684F60BBB372");
  var_6 = getEntArray("_encstr_8FC71DB0A5E46696CAD846FA0D0B9BCE2C27AF27DEC6B12B39EB8CDBB739CD", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_8 in var_6)
  var_8 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_93CF08C7684F60BBB372");
}

spawn_light_tank(var_0) {
  if(istrue(level._id_124F6)) {
    return;
  }
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.owner = undefined;
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "_encstr_AA0B120E360BD8CAAF0B8EF507BDCD2D47B4DB37";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var_1);
  var_2.maxhealth = int(var_2.health * 2.5);
  var_2.health = var_2.maxhealth;

  if(!isDefined(level.airfield_player_tanks))
    level.airfield_player_tanks = [];

  level.airfield_player_tanks[level.airfield_player_tanks.size] = var_2;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin + (0, 0, 40));
  var_3 makeusable();
  var_3 sethinticon("_encstr_97EA11A5B1DE73D732B7DEC9FAC6DBB1DA9523");
  var_3 setHintString(&"_encstr_BDB6153129F997BF7309E2ED772FE7F3D6505911D0457F");
  var_3 sethintdisplayrange(256);
  var_3 setuserange(148);
  var_3 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_3 sethintdisplayfov(120);
  var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  var_3 sethintrequiresholding(1);
  var_3 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);
  var_2.team = "_encstr_9A8507BA4040188D08";
  var_2._id_13AAD = "_encstr_9A8507BA4040188D08";
  var_2 setvehicleteam("_encstr_9A8507BA4040188D08");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_2, "_encstr_9A8507BA4040188D08");
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_2);
  var_2 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_2 makeentitysentient("_encstr_9A8507BA4040188D08");
  var_3 delete();
  level notify("_encstr_88300CB5E9B23FF9EBBB18E2814B", var_2);
  var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_2, 1);

  if(var_5.size > 0 && scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_2) == 1)
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, var_5[0], var_4);
}

spawn_enemy_chopper() {
  level endon("_encstr_B80814529468880107F0F6D26877C78B5F67865CEA67");

  for(;;) {
    var_0 = scripts\engine\utility::getStruct("_encstr_970A192CB493CC4BAC1B46BEC4DE9BDCBE1A591BB47DB90785EE73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_0.classname_mp = "_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8";
    var_0.script_modelname = "_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71";
    var_0.vehicletype = "_encstr_A60D0E2307118F4150A11F847AC08F30";
    var_1 = scripts\common\vehicle::vehicle_spawn(var_0);
    var_1.death_fx_on_self = 1;
    var_1.circle_radius = 2500;
    var_1 scripts\cp\helicopter\cp_helicopter::heli_mg_create("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED", "_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753", "_encstr_99FE0B2B19086F6B9DC5D387E1");
    var_1 thread setup_pilot(1);
    var_1.isheli = 1;
    var_1.health = 50000;
    var_1.maxhealth = 50000;
    var_1.team = "_encstr_8E8405EA382B2A";
    var_1 setvehicleteam(var_1.team);
    var_1 setmaxpitchroll(15, 15);
    var_1.health_remaining = 2250;
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var_1, undefined, "_encstr_8F3515BBD74A5B6EF3EF78F8EF30A683A2BA24B3AF2219");
    var_1 sethoverparams(25, 15, 10);
    var_1.headicon = deleteheadicon(var_1);
    setheadiconfriendlyimage(var_1.headicon, "_encstr_A6371ED0BAC8D74B6C7BE6BE43AC58C8AFCA17575A0E5B2B73E8BE56E656B697");
    setheadiconsnaptoedges(var_1.headicon, 12000);
    setheadiconmaxdistance(var_1.headicon, 1500);
    addclienttoheadiconmask(var_1.headicon, 10);
    setheadicondrawthroughgeo(var_1.headicon, 1);

    if(!isDefined(level.special_lockon_target_list))
      level.special_lockon_target_list = [];

    level.special_lockon_target_list[level.special_lockon_target_list.size] = var_1;
    thread _id_142DC();
    level.cashtypes = var_1;
    var_1 waittill("_encstr_AD75063D571AE108");
    wait(randomintrange(220, 260));
  }
}

setup_pilot(var_0) {
  var_1 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(!self tagexists(var_1))
    var_1 = "_encstr_AB680B55361AD76B09EB28E886";

  self.pilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_1));
  self.pilot setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  self.pilot linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("_encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A");

  if(isDefined(var_0))
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
}

end_spawn_group(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _end_spawn_group(var_0);
}

_end_spawn_group(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait_all("_encstr_B1750B77C8E8A68B6FE5057D5D", "_encstr_B6110C580E3660EF4317B9A73BDA", "_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

end_heli_spawn_group(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _end_spawn_group(var_0);
}

_end_heli_spawn_group(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B6520A8E7852C3499BE8AC34");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

mortar_launch_think() {
  level.get_mortar_impact_pos = ::get_mortar_impact_spot;
  level.airfield_mortar_1 = getEnt("_encstr_9201129BFF7B6C280D75F996DDFF089DA20B6F83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.airfield_mortar_2 = getEnt("_encstr_BE011296E058AE520D6123D77B20ABF4782B81CA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.airfield_mortar_1 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  level.airfield_mortar_2 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  wait 30;
  level.airfield_mortar_1 thread mortar_think("_encstr_A30F16F8C328CE102B551952DF9823D268771A2B272FB703");
  level.airfield_mortar_2 thread mortar_think("_encstr_A70F16BDC31811569B67B6699D6B13A7684FBE1388176196");
}

mortar_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin, 0, int(var_1.radius), int(var_1.height));
  var_2.targetname = var_0;
  self.targets = undefined;

  for(;;) {
    var_3 = get_players_in_area(var_2);

    if(var_3.size) {
      self.targets = var_3;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_mortar(self, 1);
      self.targets = undefined;
      wait(randomintrange(5, 8));
      continue;
    }

    wait 1;
  }
}

get_players_in_area(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!var_3 scripts\cp\utility::is_valid_player() || !var_3 isonground()) {
      continue;
    }
    if(var_3 istouching(var_0))
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets))
    return undefined;

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["_encstr_BD260953AA97E3F014279D"];
}

spawn_intro_choppers() {
  var_0 = getEnt("_encstr_97420C7CC96309A96489AFFFF51C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  var_2 = scripts\engine\utility::getStructArray("_encstr_A7F31147665CB567B983071DC4F72360401825", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    var_4.classname_mp = "_encstr_8F871B9BD8E4B4388EEBCE590D96D81B95BE2DBBE0D75B2DCD8CA51683";
    var_4.script_modelname = "_encstr_8A67159D594383F5DAB41BF52CB4E47DB55ACD91A52CC1";
    var_4.vehicletype = "_encstr_BAFD0BB5B473195A0BC1AF1B83";
    var_5 = scripts\common\vehicle::vehicle_spawn(var_4);
    var_5 thread setup_pilot();
    var_5.isheli = 1;
    var_5.health = 50000;
    var_5.maxhealth = 50000;
    var_5.team = "_encstr_8E8405EA382B2A";
    var_5 setvehicleteam(var_5.team);
    var_5 setmaxpitchroll(15, 15);
    var_5 sethoverparams(25, 15, 10);
    var_5 thread intro_chopper();
    wait 2;
  }
}

intro_chopper() {
  self endon("_encstr_AD75063D571AE108");
  self vehicle_setspeed(20, 15, 15);
  self setvehgoalpos(self.origin + (0, 0, 1200), 1);
  scripts\engine\utility::_id_143BB(10, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");
  var_0 = scripts\engine\utility::getStruct("_encstr_81F515C7752BFA17D1161BD7F969B2F29FE24118E8142F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self vehicle_setspeed(90, 30, 30);
  self setvehgoalpos(var_0.origin, 1);
  scripts\engine\utility::_id_143BB(45, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");
  self.pilot delete();
  self delete();
}

tank_battle_test() {
  wait 10;
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_836117B9D7B2E2A1143F03FBA9F8F02F3B2F2D6727BBBFB04C");
  thread hangar_door_button();
  wait 30;
  level thread spawn_enemy_tanks();
}

spawn_enemy_tanks() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_993A142C4BC9332D596319AFCA37CAADF2EB3A2C375B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.altgunnerturret = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";
  level.enemy_tanks = [];
  thread _id_142DB();

  foreach(var_2 in var_0) {
    level thread spawn_enemy_tank(var_2);
    wait(randomintrange(3, 7));
  }
}

spawn_enemy_tank(var_0) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.owner = undefined;
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  var_1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var_3;
  var_3 thread tank_waittill_death();
  var_3 thread _id_14350();
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 = scripts\engine\utility::getStructArray("_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = sortbydistance(var_4, var_3.origin)[0];
  var_6 = build_tank_path(var_5);
  var_7 = build_tank_duration(var_5);
  var_3 startpathnodes(var_6, var_7);
  setheadiconsnaptoedges(var_3.headicon, 8088);
  var_8 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_3, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_9 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_3, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");

  if(!isDefined(level.vo_paratroopers))
    level.vo_paratroopers = [];

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_3);

  for(;;) {
    var_10 = var_3 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_10)) {
      wait 1;
      continue;
    }

    if(istrue(var_10.binvehicle) && isDefined(var_10.vehicle)) {
      if(var_8 turretcantarget(var_10.vehicle.origin + (0, 0, 50)))
        var_8 settargetentity(var_10.vehicle, (0, 0, 50));

      if(var_9 turretcantarget(var_10.vehicle.origin + (0, 0, 50)))
        var_9 settargetentity(var_10.vehicle, (0, 0, 50));
    } else {
      var_8 settargetentity(var_10);
      var_9 settargetentity(var_10);
    }

    var_3 thread tank_shoot_at_target(var_9, 1);
    var_3 thread tank_shoot_at_target(var_8);
    wait(randomfloatrange(3, 5));
  }
}

tank_shoot_at_target(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = 1;
  var_3 = getcompleteweaponname("_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");

  if(istrue(var_1)) {
    var_2 = randomintrange(15, 25);
    var_3 = getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  }

  var_4 = weaponfiretime(var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_0 shootturret();
    wait(var_4);
  }
}

build_tank_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2.origin)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

build_tank_duration(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = 10; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = 10)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);
}

base_explosion_test() {
  scripts\engine\utility::flag_set("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B");
  scripts\engine\utility::flag_wait("_encstr_B12F24A0BB6903E803B6636D846316CF8A7238E002B19FE16BD1F7DD5F97D88B724A8068BA17");
  wait 0.5;
  level.use_alt_b = randomint(100) > 49;
  scripts\engine\utility::flag_init("_encstr_B6110C580E3660EF4317B9A73BDA");
  scripts\engine\utility::flag_init("_encstr_B1750B77C8E8A68B6FE5057D5D");
  scripts\engine\utility::flag_init("_encstr_BE770FA351E81DF2D883AFCFEF75CA5E08");
  scripts\engine\utility::flag_init("_encstr_B6270E371A5A1C075AE6D9EB237B3756");
  scripts\engine\utility::flag_init("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  scripts\engine\utility::flag_init("_encstr_AA5E0FFD3B8D03DE6750813AF89F168399");
  scripts\engine\utility::flag_init("_encstr_92EC0D29472272508F0A5308F59D70");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "_encstr_85EF190BAB40E5FF3121D38A28AF77DC9801AF6CD3306FFBF0738F";
  level.pkg_lbl[1] = "_encstr_8AEF19374BCEE67D6BB2E8B08DD79BD0B4C1F5632C89CA63FA0626";
  level.pkg_lbl[2] = "_encstr_97EF19CDB4CE73D7B6B2E88563F5DC345AC1FAD8C226B21BD7C019";
  level.pkg_lbl[3] = "_encstr_ADEF191F297F37398338E4125D9FA870547AC88D9FB2D1254929B7";
  level.pkg_lbl[4] = "_encstr_81EF19CD969D737D5B59D116C6D76ED02D0EBED88531B2B1FA03D0";
  level.pkg_lbl[5] = "_encstr_AAEF19808AC7FDCE9F550D8F242F33B92C8369C0A25E13607F28B5";
  level.pkg_lbl[6] = "_encstr_96EF199B4B9D9BAF5BAC4716D8D79BD0961CEB36B098CAD87D60B1";
  level.pkg_lbl[7] = "_encstr_88EF196E2D9DDCAFD6B247B0B1AFE6D0D2C17D1BB03159C6FA81E6";
  level._id_12386 = [];
  level._id_12386[0] = "_encstr_B8E12C321E7DD80737AFB1C2DCCDF531B0372BBE859BE616AEC6477D83D85836B2EB982B586CED37AF6013E49B85";
  level._id_12386[1] = "_encstr_87FE2C8023716FA37FE78977A3170E35A63B30D12A9287595FCC8D6098B331FF0F818098C22EC7F01FB9B64C35A3";
  level._id_12386[2] = "_encstr_A9102CC80FAFB11C37AFB10BCDCDBE26856E2BBE2CB9B958571BA3F583362C36ACAF98B2B01BF69BAF646623D4C6";
  level._id_12386[3] = "_encstr_86632C8C0F7DD8C16EFA8D58DC6E7D4C2C9B95BE2CCDDCB0AEB18EFA3863C23659AF26CA0B6CDB73F5CC0D861B19";
  level._id_12386[4] = "_encstr_915F2C3093C1DF13EF7719873387BEA5364BA061BA6237C92F7C1D9028C3A16F9F11100852BE5760AFCC855F450F";
  level._id_12386[5] = "_encstr_887C2C913CBE8D83B9FA8D1637CDBE890B37ACFAB0CD9BB057D8477DC11BC2B195D7C4CAC2C6F6E6D753C6199933";
  level._id_12386[6] = "_encstr_8AFB2CCD787F69E9D2E178281BEAFF01DF1BC528F967D313BB3AB0D14345BBF9278FDEBD51DF98456987B28A4F5F";
  level._id_12386[7] = "_encstr_B1A92C23A8D0B2CB7AF94B6B9B1769B5E15FEA7898E8708B7B4009E1780B2198C701F122380E85B01E1BA2B2BA9B";
  setup_search_areas();

  while(!level.players[0] meleeButtonPressed())
    wait 0.05;

  while(level.players[0] meleeButtonPressed())
    wait 0.05;

  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_836117B9D7B2E2A1143F03FBA9F8F02F3B2F2D6727BBBFB04C");
  wait 3;
  thread do_killstreaks();
  wait 2;
  thread detonate_explosives();
  level waittill("_encstr_ABA008615A631510C7EA");
}

detonate_explosives() {
  var_0 = level.airfield_plant_spots;
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      var_2 thread detonate_explosive();
      wait(randomfloatrange(0.75, 1.5));
    }

    wait(randomfloatrange(1, 2.5));
  }
}

detonate_explosive() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = [level._effect["_encstr_B2D30F8A7069EB3EF0BB27E57910496701"], level._effect["_encstr_A5D30FADD2D8C4853756F5CAE107F51B3B"], level._effect["_encstr_A5D30FADD2D8C4853756F5CAE107F51B3B"]];
  playFX(scripts\engine\utility::random(var_0), self.origin);
  earthquake(randomfloatrange(0.2, 0.3), 1, self.origin, 10000);
  playsoundatpos(self.origin, "_encstr_A6AB1AC2970D27DE13CFDA4F5B2324383A7999BBF1D3C7B7E241702C");
  thread kill_nearby_ai_enemies(self.origin, 1000);
}

kill_nearby_ai_enemies(var_0, var_1) {
  foreach(var_3 in level.agentarray) {
    if(!istrue(var_3.isactive)) {
      continue;
    }
    if(distance2dsquared(var_0, var_3.origin) > var_1 * var_1) {
      continue;
    }
    var_3 dodamage(var_3.health + 1000, var_0, undefined, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A6EC1AF35710E12197F94BF3E22B6F6A11D54927EEEA28FD836280DA");
  }
}

targets_killed(var_0) {
  var_1 = getEntArray("_encstr_B26A10A36EF0EF9927329FCFA9010F50E1D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEntArray("_encstr_A2C116A38613B2AF6140A72F68D977EAD31EE11F6B815BF1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_93AE140863C1496FCA0A203E62628790358BC970C767", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_1)
  var_5 targetoverride(var_0);

  foreach(var_5 in var_2)
  var_5 targetoverride(var_0);

  var_3 thread vehicle_damage_onexitstatelight();
  var_9 = scripts\engine\utility::getStructArray("_encstr_B81C0D35AE3BF59D5758C98C5AB037", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").size;
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B81C0D35AE3BF59D5758C98C5AB037", 1, var_9, var_9, 0.1, undefined, "_encstr_B81C0D35AE3BF59D5758C98C5AB037");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B81C0D35AE3BF59D5758C98C5AB037", ::vehicle_damage_onenterstatemedium);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("_encstr_B81C0D35AE3BF59D5758C98C5AB037", ::bot_choose_defend_role);
  var_10 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B81C0D35AE3BF59D5758C98C5AB037");
}

targetoverride(var_0) {
  var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").size;
  scripts\cp\cp_modular_spawning::registerambientgroup(self.target, 1, var_1, var_1, 0.1, undefined, self.target, undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, ::ai_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func(self.target, ::bot_choose_defend_role);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(self.target, undefined, undefined, self.script_maxdist, undefined);
  thread trigger_spawn(var_0);
}

trigger_spawn(var_0) {
  level endon("_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB");
  self endon("_encstr_8F110E9BE8DB83EBB90785DDB95A9B76");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  var_2 = self.target;
  var_3 = scripts\cp\cp_modular_spawning::run_spawn_module(var_2);
  self delete();
}

bot_choose_defend_role(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!scripts\engine\utility::flag("_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB")) {
    scripts\engine\utility::flag_set("_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB");
    var_1 = getEntArray("_encstr_B26A10A36EF0EF9927329FCFA9010F50E1D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = getEntArray("_encstr_A2C116A38613B2AF6140A72F68D977EAD31EE11F6B815BF1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_4 in var_1)
    var_4 delete();

    foreach(var_4 in var_2)
    var_4 delete();

    thread _id_142ED();
  }

  self.sightmaxdistance = 10000;
}

ai_spawn_func(var_0) {
  if(!isDefined(self.spawnpoint)) {
    return;
  }
  if(istrue(self.spawnpoint.script_noteworthy == "_encstr_850707F7E5833355B8")) {
    self.sightmaxdistance = 4096;
    self.pacifist_override = 1;
    self._id_133B9 = 1;
    thread scripts\cp\coop_stealth::run_common_functions(self, 0, 0, 75, 1440000);
  } else {
    self.sightmaxdistance = 2048;
    self.pacifist_override = 1;
    thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 75, 147456);
  }
}

vehicle_damage_onexitstatelight() {
  thread vehicle_damage_onexitstateheavy();
}

vehicle_damage_onexitstateheavy() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A12D2C40833F31B96399718FEA1B9F596937C0214FCBCB532B7D7598C2520D03D55B8958F360A317B2A663804ADF", "_encstr_9A8507BA4040188D08");
  thread _id_142EA();
  self delete();
}

vehicle_damage_onenterstatemedium(var_0) {
  if(!isDefined(self.spawnpoint)) {
    return;
  }
  if(!istrue(level.global_stealth_broken))
    thread _id_142E5();

  self.sightmaxdistance = 2048;
  self.pacifist_override = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 75, 262144);
  thread vehicle_damage_onenterstatelight();
}

vehicle_damage_onenterstatelight(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  wait 120;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_832514E0778341574283647C119B7B88F6137BF8D72D");
}

_id_142DF() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AD09271A686960F827763851ABBB60CAA8D6159857E21A09EBB873F120D5F082C56AE340D78BEED343", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A30E27B0E1B18E982B6F1492DB0BE9E2F0C75AF92667EFA3554039D1F843487133E33D50930BA9FA37", "_encstr_9A8507BA4040188D08");
  wait(randomintrange(7, 12));
  thread _id_142EE();
}

_id_142E0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A6CE31AA18B96803C3A914080FB7C09ADA86E51977FBB0CE632B53E74A95C531F03A8790E4F024F1263895EA82B5E8900FCE18");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_857531FDD0390FCBB3C7E8A017F9664562BAE5E86E13F7D19D631859471E1B879AA66E0AC49A97DE7357A818C32D933B311A7F");
}

_id_142E7(var_0) {
  scripts\cp\cp_vo::try_to_play_vo_on_team(var_0 + "_encstr_931A04C92127", "_encstr_9A8507BA4040188D08");
}

_id_142D8(var_0, var_1) {
  var_2 = "_encstr_931A04C92127";

  if(var_1 == 1)
    var_2 = "_encstr_951A0491AAE2";

  var_3 = scripts\cp\utility::give_all_players_nearby(var_0._id_11E20.origin, squared(int(var_0._id_11E20.radius)));

  if(var_3.size) {
    foreach(var_5 in var_3)
    var_5 scripts\cp\cp_vo::try_to_play_vo("_encstr_AAEF28389BC9E72BE76F018F3B9FB6AD2EB3B859A21A3FC1D77415E802EFB977150AF1A88A364D3B4F64" + var_2, "_encstr_99140ED629C9C62FA399EFB01B5F748F", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1, 100);
  }
}

_id_142D5(var_0, var_1) {
  var_2 = "_encstr_8877312CB9B19693EEB6A27A1BC6F70EA857A58F2368DA9F95C81B81C115470680C54B07BFE0E5233181132A4E57373BA9E380";

  if(var_1 == 1)
    var_2 = "_encstr_B62E31F1C331B93096176B91AF83A9F390D637E1871BB2575FA0AC81E030395FEF735B67E3A0F57BF8926B277622BB0B375BB8";

  var_3 = scripts\cp\utility::give_all_players_nearby(var_0._id_11E20.origin, squared(int(var_0._id_11E20.radius)));

  if(var_3.size) {
    foreach(var_5 in var_3)
    var_5 scripts\cp\cp_vo::try_to_play_vo(var_2, "_encstr_99140ED629C9C62FA399EFB01B5F748F", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1, 100);
  }
}

_id_142D7() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_85D431ACB351BE4867772959031FA733691B4770FBDE86F7856ACB1F1EBB578257650E26DEAD1F11C07DFBA5410B72CC6926B1", "_encstr_9A8507BA4040188D08");
  level _id_142DA("_encstr_97B32D46F07DD80E6EFAB1857319F5C40BB995F5586E3716EA8D3AAF862C9B3BB027B9AFE4B29196C95936A3D74CC0");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B89D2D1987D7D81C9BEBDA0BB60B7D892CE6597DC2DC6E165D8D3AAF0D16E69D58C9E6EB392B32A539596C1DFA1981", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_879D2DD7C231ABC306071F2F7B2779E2780B0F9119B863EA5D096BDF59DFB25F10B30269D3503CA236234F4BCFDE1F", "_encstr_9A8507BA4040188D08");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_97E61347B0CDA621176D7DB7CED33A476B1883E3A8"));
}

_id_142E1() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_ABBA2A32E1F56C07DCF56D586B16FA310B37AC7D16CD9B85AE638EAF8DED37479CEDD8EB3ADEDDACC9FA4C03", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_82262A6D40A99F5B23372030FF5BF6D5122A55789E8347A10DD3E8C9976F28218B5559E033FA0769D207C2AA", "_encstr_9A8507BA4040188D08");
  thread _id_142E8();
  level waittill("_encstr_8E0216A16FF5B1F7CEEFC03321FF3AD03720C0F3FDA5EF65");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_84DB353283893A0BEEF1E05397A0EEC921B8C367BA0F8337BD01AC699A1668599F3A397015B367F2A85270099797FD53618233057F42BA", "_encstr_9A8507BA4040188D08");
}

_id_142ED() {
  wait 5;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A101252387D7360EB9BEB5B0ADB07D31589BACAF0BB96EB0D5C68EF519AC3AACD81D2B46BE62C0", "_encstr_9A8507BA4040188D08");
  wait 5;
  level _id_142DA("_encstr_850B25ABC9980240B0CE054EC020A7CA6F3757CF63364B09F8B03BD979F0B4F23681DFBBB7FEC7");
  wait 3;
  level _id_142DA("_encstr_850B25ABC9980240B0CE054EC020A7CA6F3757CF63364B09F8B03BD979F0B4F23681DFBBB7FEC7");
}

_id_142E5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = cos(75);

  for(;;) {
    foreach(var_2 in level.players) {
      if(istrue(level.global_stealth_broken)) {
        return;
      }
      if(scripts\engine\utility::within_fov(var_2 getEye(), var_2.angles, self.origin, var_0) && var_2 scripts\engine\utility::can_trace_to_ai(var_2 getEye(), self)) {
        thread _id_142E6();
        return;
      }
    }

    wait 1;
  }
}

_id_142E6() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BE62373BA9404693A0B95CDFED1851BA90231D70D10F4069D76AA38FA85BDCB4D29D881F757B81DBF3DF5BBD6A3D6E7EB92B2328CDCB991B47", "_encstr_9A8507BA4040188D08");
}

_id_142DA(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_86F70BB5A5C6980BCD2BFAC1B0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  playsoundatpos(var_3.origin, var_0);

  var_5 = lookupsoundlength(var_0) / 1000;
  wait(var_5 + 1);
}

_id_142EE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!istrue(level.global_stealth_broken)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_863A3081ABB9FED02B8949436DE9A0388237271B9FE2BE80511BD0FB59DB606DEAABD18907CA83F860769891FF8F72884742", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8FC82F32E1BE3607E6BEC60BCD23D7C42C37B2F5C237CD0BBA8D8ED7B93A95851BA334EB560FB1A18573D995BEC4FA640C", "_encstr_9A8507BA4040188D08");
    wait 3;
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AFBE2F19E1AFD883E67DD8169B19EBC458E695BE0BDC6EB0EAB18ED79BA3560BD84743F5953C36A15837B395D791BE26C0", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A721309C090126C3BEE6020BA89BAF9140A303E52FA86A076F5BCA63D6EEA3D7A0119C609760701F83F1E25AF9D062019251", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A3BE2FA1306F280F0B3F9193E322C068E94A095E9EAB704F439BA9E7BFCB15C88CE310D607F8B8F3FAABF7ABF797709208", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_82213043681F6393FF581293C43A8F2735D1EAD3A8C0B7309F4379D306E89DA3310981CCE79F3291C0BAB83CB907F2AEE23B", "_encstr_9A8507BA4040188D08");
    return;
  }
}

monitor_flag_carrier() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_919623219031F8E7172140E95A230888D6F3BBDF31E2B0A7D72A5B56F2175678EA6B47BB88", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A25824D773389F3B3B296773C3D272564EE8D3FDD923BF727125A069F11F32909B7F76572A03", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AA96233287D71B839B7DC616DC8CFAC40BDC56F516B99B16ABD88EEBB29D27B2DCDC7D6681", "_encstr_9A8507BA4040188D08");
}

vo_mission_end() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BDFD250D20C9FF3B43574010DF7B1635F20A7518FEA367412DF388E95F8EA9775A34789CD9FFA9", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B4C6254963713608E341108935DC39FECA2733B79F1B86581D651B469C8EE0A0E2F7AD5FCFF7EF", "_encstr_9A8507BA4040188D08");
  wait 3;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9ACE2DB7930F82C8D3397B57408BAFDACBAE7FE1F7BF5BE13BC813A798205B73B3C805696EDFF238E0B86B77F11350", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B2352D9401092E3B46EEBA02B0974FA640BF0D274B9B72476D6043E998FBA75AE81F8E5FE7383D4B9979BB72A66E62", "_encstr_9A8507BA4040188D08");
}

_id_142DB() {
  var_0 = ["_encstr_BE1E254C0B08D80B02477A991551778F27B17BED0B8C2789309287E65B822684626878FA198B43", "_encstr_AF1E25ACFB2E4FA25F491AB2F05351F741693C2F959377EB23B80269188916EFD843B6DF383392", "_encstr_8134251703698B3F3881C091B3EB4FAA7E942D6775F3413123CB8A11836A108F823872BFA91F8A", "_encstr_823425C8C3FA1B07E67D6385E6DCD71B8536C6EDEAD1FAD185E6D67DB90EB0BBDC5AE6EC7D460C"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
}

_id_142EC() {
  if(!isDefined(level._id_121D5))
    level._id_121D5 = gettime() - 1000;

  if(level._id_121D5 > gettime()) {
    return;
  }
  var_0 = ["_encstr_8B322CAA7A48763B469933877F27710729F0250FD5CB86117FFB6A85E327E8E31B10A1026777E71E3483B4F7DA88", "_encstr_93322C3A72D00F9A102FF3C173B86947676832F2BB1D4752689DF1DC25A02DD39D0399BBA37F2F8D70BDEFEFBD82", "_encstr_A1E42CA10B3668508051F187CB8BE9FBE061EA35B78B403B6B2E77047B9F5AEA9003F9E3511E5C084BCDCF9FC71A", "_encstr_86E42C33604ECBAB5718A59E763F1193D168AB9790C33F734BA6EED3DEDFEA48F9E0EF7F50D96FDAB3B07701E649"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
  level._id_121D5 = gettime() + 30000;
}

_id_142DC() {
  var_0 = ["_encstr_B8892C622A88A732A8872B298B50B1FFCF8D5A5A13F59FEC20F95133B783832FEE1E0273DBC71764A8D55707E32A", "_encstr_9A892CEAE0D9489808171C0A102EC00BE16B7375E7331E52826AC8564703C3C70AA7790569823F482380C7FF9B1B", "_encstr_95112C91798967C87757D13E0BDF47E363A0CD78631011419798036A28CB40ED88690AC5AC0E3BBAD7FAF0971352", "_encstr_9A112C68D3B91798E2EE4B8353EE9F49FF200D40E38349106D64E81E85F36439EB4FD0EBE3C806AA7FC3CFB7A7DB"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
}

_id_142EA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85620E029D73756572AFD070B1378DF1");

  for(;;) {
    wait(randomintrange(25, 45));

    if(istrue(level._id_12DBD)) {
      return;
    }
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A5D824461ED7361C9BAFB10BCDDCEB4CB09BB27DC237CD16EA638EFAB9DCE4D7CD1676FA260C", "_encstr_9A8507BA4040188D08");
  }
}

_id_142E9(var_0) {
  var_0 endon("_encstr_816C0D1F82557B90733BB248A24F31");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait(randomintrange(30, 45));
    var_1 = scripts\cp\utility::give_all_players_nearby(var_0._id_11E20.origin, squared(int(var_0._id_11E20.radius)));

    if(var_1.size) {
      foreach(var_3 in var_1)
      var_3 scripts\cp\cp_vo::try_to_play_vo(level._id_12386[var_0.pkg_id] + "_encstr_951A0491AAE2", "_encstr_99140ED629C9C62FA399EFB01B5F748F", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1, 100);
    }
  }
}

_id_142E8() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8E0216A16FF5B1F7CEEFC03321FF3AD03720C0F3FDA5EF65");
  var_0 = getEnt("_encstr_A9A1140D0BCDB385E4BE31CAB0D8B773F56CB039ECF6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, squared(1024)))
    wait 0.1;

  var_1 = scripts\engine\utility::getclosest(var_0.origin, level.players);
  wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_B64213EFE6BAE91070C340C21FB7A6F855B75B532F"));
  wait 0.2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A79F2C6AD3BFA18BDB47F2A14A9FD16D482A823FA9F2FEB13B55FB40F09715271A750FBFB5730D72A168EAFFCE32", "_encstr_9A8507BA4040188D08");
  var_0 makeusable();

  for(;;) {
    wait(randomintrange(17, 28));
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A59F2C463C7D361CE6FA36589BDCD74C0B9B56EB58B9B916AE638EFAA12C379DC29CBE96DCE8B2934BDEC9EB9160", "_encstr_9A8507BA4040188D08");
  }
}

_id_142F2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_91B517B6C29B4B99599B477DB1EDAD07AEE85993EBD5DC9519", var_0);
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_87500D7F058A49D1C023FF02B990F4");
  }
}

old_health() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEnt("_encstr_AFDC1537A316931DBE9587994B8DAF9BC12CBBE64BE6D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  thread onenterfunc();
  level waittill("_encstr_91750BE60B41C076B37326D770");
  wait 5;
  level notify("_encstr_B80814529468880107F0F6D26877C78B5F67865CEA67");
  level thread oncratedestroy();
}

onenterfunc() {
  level endon("_encstr_B80814529468880107F0F6D26877C78B5F67865CEA67");
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level notify("_encstr_B46E1243AB3091CF130AC2B903AB5068D37A2AF3");
  level notify("_encstr_BDC1146E3ADBE0F59356B4CD337B4E8D59DAACCDA3CD");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A9291839097B1F09EBCB33D7EF0D3040587CCFD1235F3322A84A", 4, 4, 4, 0.5, 0, "_encstr_A9291839097B1F09EBCB33D7EF0D3040587CCFD1235F3322A84A", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BA2918C1B09C16C61ABA1D567DACC3CCB48DFA3B9CB7AB83D764", 4, 4, 4, 0.5, 0, "_encstr_BA2918C1B09C16C61ABA1D567DACC3CCB48DFA3B9CB7AB83D764", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B129188FD9739107DC9B70F011B709C9B74C808C22DFDB694987", 4, 4, 4, 0.5, 0, "_encstr_B129188FD9739107DC9B70F011B709C9B74C808C22DFDB694987", undefined, undefined, 5);
  _id_135E3();
  wait 2;
  scripts\engine\utility::delaythread(5, ::_id_13535);
  wait 5;
  _id_135D1();
  scripts\engine\utility::delaythread(10, ::_id_135E4);
  var_0 = 24;
  var_1 = 12;
  var_2 = 2;
  var_3 = 1;

  for(;;) {
    var_4 = level.spawned_ai;

    if(var_4.size < var_1) {
      if(var_3) {
        wait 1;
        var_3 = 0;
      } else
        wait(var_2);

      while(var_4.size < var_0) {
        var_4 = level.spawned_ai;
        var_5 = var_0 - var_4.size;

        if(var_5 >= 4) {
          thread _id_1354C();
          level waittill("_encstr_968E1B950F995AD8EB1CB09C164727DBED38CAE4CDF5371C16BB739532");
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

_id_1354C() {
  var_0 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(["_encstr_A9291839097B1F09EBCB33D7EF0D3040587CCFD1235F3322A84A", "_encstr_BA2918C1B09C16C61ABA1D567DACC3CCB48DFA3B9CB7AB83D764", "_encstr_B129188FD9739107DC9B70F011B709C9B74C808C22DFDB694987"]), undefined, (-13512, 66432, 5904));
  thread _id_142EC();
  level notify("_encstr_968E1B950F995AD8EB1CB09C164727DBED38CAE4CDF5371C16BB739532");
}

_id_135E3() {
  var_0 = scripts\engine\utility::getStruct("_encstr_92C71C8DED37B3BDBCFACD8EB0E447AF16B439994B2BD819AFACF0CC2D1B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_999E140339D2AF91B8F6C50772F46FBD0D7BA882F7EB";
  var_2 = "_encstr_84690A86D708E6DDDB1F477B";
  level thread spawn_convoy(var_2, var_1, var_0);
}

_id_135E4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(level.spawned_ai.size > 16)
    wait 0.1;

  var_0 = scripts\engine\utility::getStruct("_encstr_ACD91E36BDB9CEF6CBFADC47162747FA165A4E335AACB1C8AFACE1992DB1FAD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_999E140339D2AF91B8F6C50772F46FBD0D7BA882F7EB";
  var_2 = "_encstr_95690A374F12CC8079D10B93";
  level thread spawn_convoy(var_2, var_1, var_0);
}

_id_13535() {
  var_0 = scripts\engine\utility::getStruct("_encstr_BDD91EEA4DB5DB47F149EB4B2E8371B9EFA1F0B59361D41F6EA7EBB3617C3FD3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_A1E31329FD0593ABAAB2B1B808B0652586365A9770";
  var_2 = "_encstr_8A690AD8DB7367F6F2AF0C23";
  level thread spawn_convoy(var_2, var_1, var_0);
}

_id_135D1() {
  var_0 = scripts\engine\utility::getStruct("_encstr_87D91E4A6F528BD7531153611A43158F271AA827E1C3A3D83E18DB6253CABF6F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_82AA138270283F92FD1393AFF713EA3D18D97A0F28";
  var_2 = "_encstr_85690AEAA0054B6FE268F08B";
  level thread spawn_convoy(var_2, var_1, var_0);
}

spawn_convoy(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  level thread allow_driver_exit(var_4);
  var_4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("_encstr_8E76095022AA99515FE620" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

allow_driver_exit(var_0) {
  wait 1;
  var_0 notify("_encstr_AA0117D053B4796F8B1D1085F7A347E3E9A399708B59D3C3D3");
  var_0 scripts\cp\cp_convoy_manager::_id_1307D(0);
}

oncratedestroy() {
  foreach(var_1 in level.spawned_ai)
  var_1 thread _id_12DFC();

  if(isDefined(level.cashtypes)) {
    level.cashtypes notify("_encstr_82EB0B8CEDA735C29963C6FF01");
    wait 0.05;
    level.cashtypes notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
    var_3 = scripts\engine\utility::getStruct("_encstr_970A192CB493CC4BAC1B46BEC4DE9BDCBE1A591BB47DB90785EE73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.cashtypes cleargoalyaw();
    level.cashtypes vehicle_setspeed(50, 30);
    level.cashtypes setvehgoalpos(var_3.origin, 1);
    level.cashtypes waittill("_encstr_8B7205D9ED5958");
    level.cashtypes delete();
  }
}

_id_12DFC() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("_encstr_B41B0E9395A3E42B851DFACD07F61DDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  self.ignoreall = 1;
  self.playing_skit = 1;
  self.goalradius = 64;
  self setgoalpos(var_0.origin);
  self waittill("_encstr_8B7205D9ED5958");
  self dodamage(self.health + 100, self.origin);
}

_id_14350() {
  self endon("_encstr_AD75063D571AE108");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

_id_12B06() {
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B29A1050C73273FB02F49EB00C5AD9D8B71E", 3, 9, 9, 0.1, undefined, "_encstr_B29A1050C73273FB02F49EB00C5AD9D8B71E", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_849A101E7F02232926CCC379633A30CFC92E", 3, 6, 6, 0.1, undefined, "_encstr_849A101E7F02232926CCC379633A30CFC92E", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_84B60CE47BC2C8AFA159B1D2BE98", 3, 9, 9, 0.1, undefined, "_encstr_84B60CE47BC2C8AFA159B1D2BE98", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_ADB60C3D67CAED1980B778D0D122", 3, 9, 9, 0.1, undefined, "_encstr_ADB60C3D67CAED1980B778D0D122", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A7A10D1AB792217A5E1DC2A18FC7A2", 3, 6, 6, 0.1, undefined, "_encstr_A7A10D1AB792217A5E1DC2A18FC7A2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8BC30E03A3F0BFD7C01B0B9220AFDFE2", 3, 9, 9, 0.1, undefined, "_encstr_8BC30E03A3F0BFD7C01B0B9220AFDFE2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91FA0D33A5956332F54395632DFA4C", 3, 9, 9, 0.1, undefined, "_encstr_91FA0D33A5956332F54395632DFA4C", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A6D50EA3B09CB52C1B7D0D2BB15AF513", 3, 6, 6, 0.1, undefined, "_encstr_A6D50EA3B09CB52C1B7D0D2BB15AF513", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B81D0B342D63C67D47DBC1EB4C", 3, 6, 6, 0.1, undefined, "_encstr_B81D0B342D63C67D47DBC1EB4C", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B6430FDB6DBE48707E27CDC27F47A4E0EB", 3, 9, 9, 0.1, undefined, "_encstr_B6430FDB6DBE48707E27CDC27F47A4E0EB", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_84430FC5D7E2B22062C1936B735B18E07F", 3, 9, 9, 0.1, undefined, "_encstr_84430FC5D7E2B22062C1936B735B18E07F", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B2171031C22739856CD66EAFE47B0B32AF98", 3, 9, 9, 0.1, undefined, "_encstr_B2171031C22739856CD66EAFE47B0B32AF98", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB760DA0EF07DA4A5F73A8177CB94A", 3, 9, 9, 0.1, undefined, "_encstr_AB760DA0EF07DA4A5F73A8177CB94A", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A1760DD2F8AC8F82D9CD5F5989B19A", 3, 9, 9, 0.1, undefined, "_encstr_A1760DD2F8AC8F82D9CD5F5989B19A", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_93760DE03FF7D19D81F2D0EF4FB925", 3, 9, 9, 0.1, undefined, "_encstr_93760DE03FF7D19D81F2D0EF4FB925", undefined, undefined, 15);
}

called75percentprogress(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0._id_1425F)) {
    return;
  }
  var_0._id_1425F = 1;

  switch (var_0.script_noteworthy) {
    case "_encstr_9AF606F03AB3B818":
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B6430FDB6DBE48707E27CDC27F47A4E0EB");
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A6D50EA3B09CB52C1B7D0D2BB15AF513");
      wait 5;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91FA0D33A5956332F54395632DFA4C");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_84430FC5D7E2B22062C1936B735B18E07F");
      break;
    case "_encstr_AFF6062299E2A746":
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7A10D1AB792217A5E1DC2A18FC7A2");
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8BC30E03A3F0BFD7C01B0B9220AFDFE2");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_93760DE03FF7D19D81F2D0EF4FB925");
      break;
    case "_encstr_87370AFD69707F3AB8D3BBD3":
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7A10D1AB792217A5E1DC2A18FC7A2");
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8BC30E03A3F0BFD7C01B0B9220AFDFE2");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B81D0B342D63C67D47DBC1EB4C");
      break;
    case "_encstr_8DF606E213C5D987":
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B2171031C22739856CD66EAFE47B0B32AF98");
      wait 5;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B29A1050C73273FB02F49EB00C5AD9D8B71E");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_849A101E7F02232926CCC379633A30CFC92E");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB760DA0EF07DA4A5F73A8177CB94A");
      break;
  }
}

_id_12B50(var_0) {
  if(isDefined(var_0.operator) && isalive(var_0.operator)) {
    var_0.operator.goalradius = 2048;
    var_0.operator = undefined;
  }
}

_id_135B3(var_0, var_1, var_2) {
  var_3 = undefined;
  var_3 = scripts\cp\utility::getweaponrootname(var_2);
  var_4 = [];
  var_5 = scripts\cp\cp_weapon::buildweapon(var_3, var_4, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_6 = createheadicon(var_5);
  var_2 = spawn("_encstr_B2010820C5337B67C8CF" + var_6, var_0, 17);
  var_2 sethintdisplayrange(96);
  var_2 setuserange(96);
  var_2 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_2 setusefov(210);
  var_2.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
  var_2.objweapon = var_5;
  var_2.angles = var_1;
  var_2 itemweaponsetammo(weaponclipsize(var_2), weaponmaxammo(var_2));
  return var_2;
}

friendly_hvi_vehicle_extra_riders_getin_scene(var_0) {
  wait(randomintrange(10, 20));
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40(var_0);
}

little_bird_mg_handleflarefire() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 10;
  var_0 = scripts\cp\cp_spawning_util::balloon_deposit((4491.52, 49455, 1035.5), 825);

  while(!scripts\engine\utility::flag_exist("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC"))
    wait 1;

  scripts\engine\utility::flag_wait("_encstr_923E13A111F550D7ABA9D9A0B2F380580A6D2523BC");
  scripts\cp\cp_spawning_util::_id_12BF2(var_0);
}