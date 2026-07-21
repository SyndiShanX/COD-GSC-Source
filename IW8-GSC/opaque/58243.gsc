/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58243.gsc
***********************************************/

init() {
  thread suppressedlaser();
  thread table_getaddblueprintattachments();
}

suppressedlaser() {
  _handlevehiclerepair::init();

  if(getDvar("_encstr_8B380D5AE910DF5A4ECFB3F7BDF612") == "_encstr_BD1904CF572A") {
    var_0 = [];
    var_0["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A"] = 1;
    var_0["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"] = 1;
    var_0["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926"] = 0.5;
    _handlevehiclerepair::_id_11A45("_encstr_ADBB0FB0C16943EFC5BEE0BA51C25B0B20", var_0);
    var_0 = [];
    var_0["_encstr_95EF1DE6EB6B4FB889C7F73BB7D31FA0FF28707F70744215536D17CD60C7F8"] = 1;
    var_0["_encstr_8DDE08CDF61D434BB9B3"] = 1;
    _handlevehiclerepair::_id_11A45("_encstr_9AB11177A1B7A10F4DBB98200123C339E35F08", var_0);
    var_0 = [];
    var_0["_encstr_96B6164C938DDEDEA3D7B73399D00BDC46D7E6B2B5A3B20F"] = 1;
    var_0["_encstr_91A915AE025A4778E4F7F848EB68718D02E19EA1DD422B"] = 1;
    _handlevehiclerepair::_id_11A45("_encstr_ACDA0F16A57D6CF673B3DB97F576560B27", var_0);
    var_0 = [];
    var_0["_encstr_8DCA2045F2657BC0A399087092FB8690BA7DCB2FB78FC3972B7203785BB7A8F815C7"] = 1;
    var_0["_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3"] = 1;
    var_0["_encstr_AC671D783B12B7EDC91F150ACC43E745DD41509F6150853097CBB3D0D3EFCD"] = 1;
    _handlevehiclerepair::_id_11A45("_encstr_B27111DEA879E38A409DD787E7F613482B53D2", var_0);
    var_0 = [];

    if(getdvarint("_encstr_AAF62372C138F79228454B3773D85B0828EB2D3FFE20822AFF0F2317ADF5F279019165C531", 1) == 1)
      var_0["_encstr_AAAD1EF8FB62F88809C747CBA1F84B237A6F46AA8E4A6BB8D3F1C3EBB983323A"] = 1;
    else {
      var_0["_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5"] = 1;
      var_0["_encstr_AFA92636E3C8C752A5273F2F59415B14C0E96EFCFE80828A76635727B778C179B093628333105342"] = 1;
    }

    _handlevehiclerepair::_id_11A45("_encstr_A798166F84291F38BE13B870CFC3B04942AA5D6E1F22F763", var_0);
  } else {
    var_0 = [];
    var_0["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A"] = 1;
    var_0["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"] = 1;
    var_0["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926"] = 0.5;
    _handlevehiclerepair::_id_11A45("_encstr_ADBB0FB0C16943EFC5BEE0BA51C25B0B20", var_0);
    var_0 = [];
    var_0["_encstr_95EF1DE6EB6B4FB889C7F73BB7D31FA0FF28707F70744215536D17CD60C7F8"] = 1;
    var_0["_encstr_8DDE08CDF61D434BB9B3"] = 1;
    _handlevehiclerepair::_id_11A45("_encstr_9AB11177A1B7A10F4DBB98200123C339E35F08", var_0);
    var_0 = [];
    var_0["_encstr_96B6164C938DDEDEA3D7B73399D00BDC46D7E6B2B5A3B20F"] = 1;
    var_0["_encstr_91A915AE025A4778E4F7F848EB68718D02E19EA1DD422B"] = 1;
    _handlevehiclerepair::_id_11A45("_encstr_ACDA0F16A57D6CF673B3DB97F576560B27", var_0);
    var_0 = [];
    var_0["_encstr_8DCA2045F2657BC0A399087092FB8690BA7DCB2FB78FC3972B7203785BB7A8F815C7"] = 1;
    var_0["_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3"] = 1;
    var_0["_encstr_AC671D783B12B7EDC91F150ACC43E745DD41509F6150853097CBB3D0D3EFCD"] = 1;
    _handlevehiclerepair::_id_11A45("_encstr_B27111DEA879E38A409DD787E7F613482B53D2", var_0);
    var_0 = [];

    if(getdvarint("_encstr_AAF62372C138F79228454B3773D85B0828EB2D3FFE20822AFF0F2317ADF5F279019165C531", 1) == 1)
      var_0["_encstr_AAAD1EF8FB62F88809C747CBA1F84B237A6F46AA8E4A6BB8D3F1C3EBB983323A"] = 1;
    else {
      var_0["_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5"] = 1;
      var_0["_encstr_AFA92636E3C8C752A5273F2F59415B14C0E96EFCFE80828A76635727B778C179B093628333105342"] = 1;
    }

    _handlevehiclerepair::_id_11A45("_encstr_A798166F84291F38BE13B870CFC3B04942AA5D6E1F22F763", var_0);
  }
}

table_getaddblueprintattachments() {
  waitframe();
  level.hurt_trigger_active = getdvarfloat("_encstr_B82323E6D827D785E4B6DE935923BE1BF6CDB3BDF2FA6BC283D73738B0DDDCEB19CA1BB02F", 1);

  if(getdvarint("_encstr_97B8256FB8EBF79A638DE0117A0B229C5198D75720A00E1357236197DCCBFA4CBE781F63983B7D", 0) == 1) {
    self waittill("_encstr_8D18114CC97D9DB234A5C663CADC4AB29BAC3A");
    wait(level.hurt_trigger_active);
    hudplunderstart();
    hvt_key_picked_up();
    var_0 = spawnStruct();
    var_0.streakname = "_encstr_8D860D49508DBBF831085BF0335F07";
    level.idflags_source_left_hand = var_0;
    level.hudextractnum = ::hudextractnum;
    level thread _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::init();
    level thread object_is_valid(var_0);
  }
}

hvt_key_picked_up() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_8D860D49508DBBF831085BF0335F07", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

accessorylogicbyindex() {}

object_is_valid(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  level.hudglobalkillcountmax = spawnStruct();
  level.hudglobalkillcountmax.hudzombie = [];
  level.hudglobalkillcountmax.brvalidatekillcam = 0;
  level.hudglobalkillcountmax.i_see_player_drone_watcher = [];
  stoppingpower_onkill();
  forcefail();

  if(getdvarint("_encstr_931627FBA25B20801AEDA7950D47A9F687CAD3E06B976E40F6EF5DD7312D78505332C9A923E7A8880A", 0) == 1) {
    obj_room_fire_09(var_0, "_encstr_A56206DAA57359E6");
    obj_room_fire_09(var_0, "_encstr_81AB066CB069AF22");
    obj_room_fire_09(var_0, "_encstr_8D0308D858C14BD15836");
    obj_room_fire_09(var_0, "_encstr_A6E909709F0F1AF898A546");
    obj_room_fire_09(var_0, "_encstr_99E00710F71780B782");
    obj_room_fire_09(var_0, "_encstr_B2280A3A935086C353C1623A");
  } else if(getdvarint("_encstr_BD0F2062D128E7A296731F535BB589131898DBED0AE973EB672F13EF97ED1243F1AB", 0) == 1)
    obj_room_fire_09(var_0, "_encstr_81AB066CB069AF22");
  else
    _id_13527(var_0);

  foreach(var_2 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    var_2._id_13415 = 5;
    var_2.personnel_platform = 15;
    var_2._id_136EB = var_2._id_13415;
    var_3 = scripts\common\utility::playersincylinder(var_2.origin, 20000);

    foreach(var_5 in var_3) {
      var_5 thread scripts\mp\hud_message::showsplash("_encstr_92B913C6BD73ECDE2FEB1D4EAE36D6F56EE058EE73");
      var_5.shoulddonodedrop = 1;
    }
  }

  level.hudglobalkillcountmax.locindex = 20;
  level.hudglobalkillcountmax.getoldestdogtags = 0;
  level.hudglobalkillcountmax._id_119E9 = 500;
}

_id_13527(var_0) {
  var_1 = [];

  if(getdvarint("_encstr_BD59267358A5E9BF7B994752A5817F2E37A8AB4A6027DDD790F54347C6081FB35B894202B023533F", 1) == 1)
    var_1[var_1.size] = "_encstr_A56206DAA57359E6";

  if(getdvarint("_encstr_BD2E26FA49B07F0A2ECBB7CB33DD11BBB0703345A2810CA28EFFDF870570FBE458BE6ECE7B98C6DA", 1) == 1)
    var_1[var_1.size] = "_encstr_81AB066CB069AF22";

  if(getdvarint("_encstr_86012837E0B35F12EDB9CD8295F9C92BB810AB3F584EDBDA0143137E09E753FF03687F7720210402556D", 1) == 1)
    var_1[var_1.size] = "_encstr_8D0308D858C14BD15836";

  if(getdvarint("_encstr_82B729C862CAE771AB05D84EE51B7E67755A78A07B29D3C9B7355045FD7B260DDD73E04871FE0F63B74EED", 1) == 1)
    var_1[var_1.size] = "_encstr_A6E909709F0F1AF898A546";

  if(getdvarint("_encstr_8D0F278BB66E810152A71228CFD937EFE730133D1029E18F47CAF76E0193B7B0FC3597965B69AAC318", 1) == 1)
    var_1[var_1.size] = "_encstr_99E00710F71780B782";

  if(getdvarint("_encstr_8F672ACD6CE4AF859CB6DB272B19AF1BF6B9B37B5EEB892B2C36A143B21632D79CDBBA8E95EB0B1BA3A567AC", 1) == 1)
    var_1[var_1.size] = "_encstr_B2280A3A935086C353C1623A";

  var_1 = scripts\engine\utility::array_randomize(var_1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_2 > getdvarint("_encstr_96BB2EABF20B10B02ADD7745FD9779C6D7BA83D0BB67305885AA7B7DDFBD78809F02187B6297F6D11B8F07771866A8D0", 3) - 1) {
      break;
    }

    obj_room_fire_09(var_0, var_1[var_2]);
  }
}

obj_room_fire_09(var_0, var_1, var_2) {
  if(getdvarint("_encstr_A698141B42BBC060FA0D87B52D27C996A7EA33ED4BB7" + var_1 + "_encstr_B80F0E61B3C23BF05F7771930337AE87", 1) == 0) {
    return;
  }
  var_3 = 0;

  if(getdvarint("_encstr_82DA1AC6CB18A05555AEF1F70EC7F0D018EF906BA008816DA54B326D", 0))
    var_3 = randomint(level.hudglobalkillcountmax.paths[var_1].size);

  var_4 = level.hudglobalkillcountmax.paths[var_1][var_3];
  var_5 = spawn_convoy_truck(var_4, var_2);
  var_5.vehiclename = "_encstr_8D860D49508DBBF831085BF0335F07";
  var_5.name = "_encstr_8D860D49508DBBF831085BF0335F07";
  var_5.ownerdamageenabled = 1;
  var_5._id_13DD4 = 1;
  var_5 setCanDamage(1);
  var_5.godmode = 0;
  var_5.team = "_encstr_A7A408B9CA5D1D4E2C63";
  var_5 setvehicleteam("_encstr_A7A408B9CA5D1D4E2C63");
  var_6 = getdvarint("_encstr_A79B0AF64A38711C9EE7B139", 1);
  var_5.health = 5000;
  var_5.maxhealth = 5000;

  if(var_6 > 2) {
    var_5.health = var_5.health * 2;
    var_5.maxhealth = var_5.maxhealth * 2;
  }

  var_5 hurt_enabled();
  var_5.initplunderpads = "_encstr_A6C30A1D9B978D8F9BB44DE7";
  var_5.locale = var_1;
  var_5.inside_bush = var_3;
  var_5.is_enemy_of_type = 1;
  var_5._id_12B1D = [];
  var_5._id_13A89 = [];
  var_5 vehphys_enablecollisioncallback(1);
  var_5._id_119FB = 3;
  var_5.little_bird_mg_onexitheavydamagestate = 1;
  var_5.clipsize = getdvarint("_encstr_BE8B24A226EB30CB8328AF0A47A11E72628B03D73879E3C3A3A0C804217A556F7BE91878A8A8", 80);
  var_7 = anglesToForward(var_5.angles) * 150 * -1;
  level.hudglobalkillcountmax._id_13E81 = getdvarint("_encstr_956123DCB14EEB8527ADF693B232BE36DE37ECF65ED7D15D39275947D716C61BABC9C2C6CB", 65);
  var_8 = var_5 gettagorigin("_encstr_8FCF0D51A0E8F52A554949A215AF98");
  var_9 = var_5 gettagorigin("_encstr_93CF0DB159C7E9255F21B75DA99FFE");
  var_10 = var_5 gettagorigin("_encstr_97CF0DE1A92F49CB3FA6DAC55D866B");
  var_11 = var_5 gettagorigin("_encstr_844313A90770A82942C517CEBE7959EAA95BF305CB");
  var_12 = var_5 gettagorigin("_encstr_8A401449E79048C9A225F7EE9E59398AC903CBE75BC9");
  var_13 = cos(37.5);
  var_14 = cos(60);
  var_5.waypoint_endzone_vfx = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_8, "_encstr_85B317EED84046DA9B9FCBDBE34E42B778632232312827B277");
  var_5.waypoint_endzone_vfx setModel("_encstr_B4012FECB234EB6ED07D5BD28DBEB19B91F58E4EEAB1B5BE7BC116C11686C0F51693B5ED9C5919F5EE4FAFD1ABE49C953A");
  var_5.waypoint_endzone_vfx.owner = var_0.owner;
  var_5.waypoint_endzone_vfx setturretowner(var_0.owner);
  var_5.waypoint_endzone_vfx.team = var_5.team;
  var_5.waypoint_endzone_vfx maketurretinoperable();
  var_5.waypoint_endzone_vfx.streakinfo = var_0;
  var_5.waypoint_endzone_vfx.turreton = 1;
  var_5.waypoint_endzone_vfx.name = "_encstr_81740C33A849FC79792D023A1D51";
  var_5.waypoint_endzone_vfx.attackingtarget = undefined;
  var_5.waypoint_endzone_vfx linkTo(var_5, "_encstr_8FCF0D51A0E8F52A554949A215AF98", (0, 0, 0), (0, 0, 0));
  var_5.waypoint_endzone_vfx._id_11E1D = var_5;
  var_5.waypoint_endzone_vfx._id_11A52 = [];
  var_5.waypoint_endzone_vfx setturretteam(var_5.team);
  var_5.waypoint_endzone_vfx setturretmodechangewait(0);
  var_5.waypoint_endzone_vfx setmode("_encstr_849007B268BD03DFD8");
  var_5.waypoint_endzone_vfx setotherent(var_0.owner);
  var_5.waypoint_endzone_vfx setdefaultdroppitch(30);
  var_5.waypoint_endzone_vfx._id_11B52 = var_13;
  var_5.waypoint_endzone_vfx._id_13A71 = 0;
  var_5._id_12D3F = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_9, "_encstr_85B317EED84046DA9B9FCBDBE34E42B778632232312827B277");
  var_5._id_12D3F setModel("_encstr_B4012FECB234EB6ED07D5BD28DBEB19B91F58E4EEAB1B5BE7BC116C11686C0F51693B5ED9C5919F5EE4FAFD1ABE49C953A");
  var_5._id_12D3F.owner = var_0.owner;
  var_5._id_12D3F setturretowner(var_0.owner);
  var_5._id_12D3F.team = var_5.team;
  var_5._id_12D3F maketurretinoperable();
  var_5._id_12D3F.streakinfo = var_0;
  var_5._id_12D3F.turreton = 1;
  var_5._id_12D3F.name = "_encstr_86460DC9A5D9D0A3AFA3BA9339B21D";
  var_5._id_12D3F.attackingtarget = undefined;
  var_5._id_12D3F linkTo(var_5, "_encstr_93CF0DB159C7E9255F21B75DA99FFE", (0, 0, 0), (0, 0, 0));
  var_5._id_12D3F._id_11E1D = var_5;
  var_5._id_12D3F._id_11A52 = [];
  var_5._id_12D3F setturretteam(var_5.team);
  var_5._id_12D3F setturretmodechangewait(0);
  var_5._id_12D3F setmode("_encstr_849007B268BD03DFD8");
  var_5._id_12D3F setotherent(var_0.owner);
  var_5._id_12D3F setdefaultdroppitch(30);
  var_5._id_12D3F._id_11B52 = var_13;
  var_5._id_12D3F._id_13A71 = 0;
  var_15 = var_5.origin + var_7;
  var_16 = (var_15[0], var_15[1], var_5.origin[2] + 150);
  var_17 = vectorNormalize(var_16 - var_5.origin) * 150;
  var_18 = var_5.origin + var_17;
  var_5.rearturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_10, "_encstr_85B317EED84046DA9B9FCBDBE34E42B778632232312827B277");
  var_5.rearturret setModel("_encstr_AA9E34145593DEDF33B120189AB1A9B01BC79D8EBD5780BFCD2B48D86283C92E6772A9881217297733B3C1709A6E37E6EB1DAEFE9DFB");
  var_5.rearturret setturretowner(var_0.owner);
  var_5.rearturret.owner = var_0.owner;
  var_5.rearturret.team = var_5.team;
  var_5.rearturret maketurretinoperable();
  var_5.rearturret.streakinfo = var_0;
  var_5.rearturret.turreton = 1;
  var_5.rearturret.name = "_encstr_B4F50CE49516C9BE47D593392BE8";
  var_5.rearturret.attackingtarget = undefined;
  var_5.rearturret linkTo(var_5, "_encstr_97CF0DE1A92F49CB3FA6DAC55D866B", (0, 0, 0), (0, 0, 0));
  var_5.rearturret._id_11E1D = var_5;
  var_5.rearturret._id_11A52 = [];
  var_5.rearturret setturretteam(var_5.team);
  var_5.rearturret setturretmodechangewait(0);
  var_5.rearturret setmode("_encstr_849007B268BD03DFD8");
  var_5.rearturret setotherent(var_0.owner);
  var_5.rearturret setdefaultdroppitch(30);
  var_5.rearturret._id_11B52 = var_14;
  var_5.rearturret._id_13A71 = 0;
  var_5.intel_pieces = 5;
  var_5.waypoint_completed_vfx = var_11;
  var_5._id_12D3E = var_12;
  var_5 vehicle_setspeed(50, 5, 5);
  var_5.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"));
  var_5.killcament.origin = var_5.killcament.origin + (0, 0, 300);
  var_5.killcament linkTo(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-600, 0, 1000), (0, 0, 0));
  var_5.waypoint_endzone_vfx.killcament = var_5.killcament;
  var_5._id_12D3F.killcament = var_5.killcament;
  var_5.rearturret.killcament = var_5.killcament;

  if(getdvarint("_encstr_9BF2277FA8FBE7AA2571154A6D210163E068F38780B602D27F979E03C0AF3A2EEBA86BBFC0A9490BA1", 0))
    level thread _id_144B2(var_5);

  var_5 thread _id_14237();
  var_5 thread _id_14483(var_1);
  var_5 thread is_stealth_sequence_activated();
  var_5 thread vehicle_damage_onenterstateheavy();
  var_5 thread _id_11C18();
  var_5 thread setup_backup_respawn_points_in_verdansk();
  var_5 thread _id_14479();
  return var_5;
}

_id_135EE() {
  self._id_12D3F.groundtargetent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level.players[0].origin);
  self._id_12D3F.groundtargetent dontinterpolate();
  self.waypoint_endzone_vfx.groundtargetent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level.players[0].origin);
  self.waypoint_endzone_vfx.groundtargetent dontinterpolate();
  self.rearturret.groundtargetent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level.players[0].origin);
  self.rearturret.groundtargetent dontinterpolate();
}

_id_11C18() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.mines))
    level.mines = [];

  for(;;) {
    foreach(var_1 in level.mines) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(istrue(var_1._id_11B0D)) {
        continue;
      }
      if(isDefined(var_1.weapon_name) && var_1.weapon_name == "_encstr_ACC40CC1F8A321601715CFBFE0EA") {
        if(distancesquared(self.origin, var_1.origin) < squared(192)) {
          if(vectordot(self.origin - var_1.origin, anglesToForward(var_1.angles)) > 0.86602)
            var_1 thread scripts\mp\equipment\claymore::claymore_trigger(self);
        }
      }
    }

    waitframe();
  }
}

_id_144B2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.locale;
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0.waypoint_endzone_vfx))
    var_0.waypoint_endzone_vfx delete();

  if(isDefined(var_0._id_12D3F))
    var_0._id_12D3F delete();

  if(isDefined(var_0.cannon))
    var_0.cannon delete();

  if(isDefined(var_0.rearturret))
    var_0.rearturret delete();

  if(isDefined(var_0._id_1253B))
    var_0._id_1253B delete();

  if(isDefined(var_0.computerrebootused))
    var_0.computerrebootused delete();

  scripts\engine\utility::array_removeundefined(level.hudglobalkillcountmax.i_see_player_drone_watcher);
  wait 10;
  var_2 = getdvarint("_encstr_9BF2277FA8FBE7AA2571154A6D210163E068F38780B602D27F979E03C0AF3A2EEBA86BBFC0A9490BA1", 0) == 2;
  var_3 = obj_room_fire_09(level.idflags_source_left_hand, var_1, var_2);
  var_3._id_13415 = 5;
  var_3.personnel_platform = 15;
  var_3._id_136EB = var_3._id_13415;
  level.hudglobalkillcountmax.locindex = 20;
  level.hudglobalkillcountmax.getoldestdogtags = 0;
  level.hudglobalkillcountmax._id_119E9 = 500;

  if(istrue(var_2) && isDefined(var_3.path) && isDefined(var_3.path.nodes) && var_3.path.nodes.size > 1)
    var_3 thread br_armor_plate_amount_equipped_set();
}

br_armor_plate_amount_equipped_set() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  self endon("_encstr_AD75063D571AE108");
  _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::stoppingpower_givehcrdata();
  _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::stoppingpower_loadoutchangeremovehcr();
  level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DF8();
  level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DE4(self, self.origin, self.angles, 1);

  if(isDefined(self.path)) {
    self.stop_pressure_sensor = 1;

    while(self.stop_pressure_sensor)
      wait 0.1;

    wait 3;
    thread _id_1422F(self.path);
  }
}

hudextractnum(var_0, var_1) {
  if(level.hudglobalkillcountmax.i_see_player_drone_watcher.size <= 0) {
    return;
  }
  foreach(var_3 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = distance2d(var_3.origin, var_0);

    if(var_4 > var_1 && var_4 - var_1 > 4000) {
      var_3._id_133DA = 1;
      var_5 = play_ac130_approach_scene();
      var_6 = spawnStruct();
      var_6.attacker = var_5;
      var_6._id_11E93 = 1;
      var_3 hudnumtoconsume(var_6);
    }
  }
}

_id_144B1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(validtousecosmetic()) {
      wait 10;

      if(validtousecosmetic()) {
        break;
      }
    }

    wait 5;
  }

  self._id_133DA = 1;
}

validtousecosmetic() {
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_2 = self.origin - var_0;
  var_3 = distance2d(self.origin, var_0);
  return var_3 > var_1 && var_3 - var_1 > 4000;
}

stoppingpower_onkill() {
  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    _encstr_96B43B6E1B4ED2E0A3DC97B61C5E3BC2D659E8BCC12BB9E59893D7832C2F36F62C19BE38858E437DB683AF13C9BE5B561B430BCD2DB1E67D9171ECCD36::toggle_farah_lights(2, "_encstr_A5AE098ADB583E0AF7A5AB", 2);

  if(level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    _codephonescriptableused::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
    _closepurchasemenuwithresponse::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
    _cleanuptabletallows::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
    _calloutmarkerping_shouldremovecalloutifwholesquadinvehicle::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
    _codecomputerscriptableused::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
    _cancelputawayonuseend::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
  }

  syringe_finish_crouch();
}

syringe_finish_crouch() {
  foreach(var_1 in level.hudglobalkillcountmax.paths) {
    foreach(var_3 in var_1) {
      var_3.points = [];

      foreach(var_5 in var_3.nodes)
      var_3.points[var_3.points.size] = var_5.origin;
    }
  }
}

forcefail() {
  forced_kill_off("_encstr_A56206DAA57359E6");
  forced_kill_off("_encstr_81AB066CB069AF22");
  forced_kill_off("_encstr_8D0308D858C14BD15836");
  forced_kill_off("_encstr_A6E909709F0F1AF898A546");
  forced_kill_off("_encstr_99E00710F71780B782");
  forced_kill_off("_encstr_B2280A3A935086C353C1623A");
}

forced_kill_off(var_0) {
  if(!isDefined(level.hudglobalkillcountmax.paths[var_0])) {
    return;
  }
  foreach(var_2 in level.hudglobalkillcountmax.paths[var_0]) {
    for(var_3 = 0; var_3 < var_2.nodes.size; var_3++) {
      if(var_3 < var_2.nodes.size - 1) {
        var_2.times[var_3] = freight_lift_build(var_2.nodes[var_3].origin, var_2.nodes[var_3 + 1].origin);
        continue;
      }

      var_2.times[var_3] = freight_lift_build(var_2.nodes[var_3].origin, var_2.nodes[0].origin);
    }
  }
}

spawn_convoy_truck(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = var_0;
  var_4 = undefined;
  var_5 = 0;

  if(isDefined(var_0.nodes) && isDefined(var_0.nodes[var_5]) && isDefined(var_0.nodes[var_5 + 1])) {
    var_3 = var_0.nodes[var_5];
    var_4 = var_0.nodes[var_5 + 1];

    if(var_3.origin == var_4.origin)
      var_4 = var_0.nodes[var_5 + 2];

    var_2 = vectortoangles(var_4.origin - var_3.origin);
  } else if(isDefined(var_0.target)) {
    var_4 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_4))
      var_2 = vectortoangles(var_4.origin - var_0.origin);
    else if(isDefined(var_0.angles))
      var_2 = vectortoangles(var_4.origin - var_0.origin);
    else
      var_2 = (0, randomint(0, 360), 0);
  }

  var_6 = spawnStruct();
  var_6.origin = var_3.origin;
  var_6.angles = var_2;
  var_6.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_6.spawnmethod = "_encstr_B813195051C942790FB923A7D920974723C3159399431857D9BFB5";
  var_6.team = "_encstr_A7A408B9CA5D1D4E2C63";
  var_6.player_rig_create = ::_id_1423F;
  var_6.vehicletype = "_encstr_AC0E184713A724D85F43188AE83B33DE711867B798F5ED5CD733";
  var_6.modelname = "_encstr_8DCD28DC8D4B0617FB096840D2C9F1F8D30F6556F51FC80715E3F0903A4B01961FCA61406AAFD13F7B6B";
  var_6.showheadicon = 1;
  var_7 = spawnStruct();
  var_8 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8D860D49508DBBF831085BF0335F07", var_6, var_7);
  var_8 unmarkkeyframedmover(1);
  var_8 _meth_87C2(1);
  level.hudglobalkillcountmax.i_see_player_drone_watcher[level.hudglobalkillcountmax.i_see_player_drone_watcher.size] = var_8;
  var_8.intel_pieces = 5;

  if(isDefined(var_4)) {
    var_0.vehicle = var_8;
    var_8.path = var_0;

    if(!isDefined(var_0.trigger))
      var_0.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_8.origin, 0, 250, 200);

    if(!istrue(var_0.trigger.x1loadout)) {
      var_0.trigger enablelinkTo();
      var_0.trigger.x1loadout = 1;
    }

    var_0.trigger linkTo(var_8, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
    var_0.trigger.brkillstreakbeginusefunc = 1;

    if(isDefined(var_4) && !istrue(var_1))
      var_8 thread _id_1422F(var_0);
  }

  var_8._id_1253B = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_8.origin, 0, 1000, 1000);
  var_8._id_1253B enablelinkTo();
  var_8._id_1253B.x1loadout = 1;
  var_8._id_1253B linkTo(var_8, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_8._id_1253B._id_11E1D = var_8;
  scripts\mp\utility\trigger::makeenterexittrigger(var_8._id_1253B, ::nuke_vault_alarm, ::onplayerconnectstream, undefined, undefined, ::hudkothbesttime);
  var_8.computerrebootused = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_8.origin, 0, 150, 150);
  var_8.computerrebootused enablelinkTo();
  var_8.computerrebootused.x1loadout = 1;
  var_8.computerrebootused linkTo(var_8, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_8.computerrebootused._id_11E1D = var_8;
  scripts\mp\utility\trigger::makeenterexittrigger(var_8.computerrebootused, ::confirmed_pilot, ::connect_circlar_path, undefined, undefined, ::connect_init);
  var_8._id_1253B thread _id_144CA();
  return var_8;
}

nuke_vault_alarm(var_0, var_1) {
  if(isPlayer(var_0)) {
    if(!isDefined(var_0.aq_playerremoved))
      var_0.aq_playerremoved = [];

    if(!scripts\engine\utility::array_contains(var_0.aq_playerremoved, var_1._id_11E1D)) {
      var_0.aq_playerremoved[var_0.aq_playerremoved.size] = var_1._id_11E1D;
      var_0 thread scripts\mp\hud_message::showsplash("_encstr_92B913C6BD73ECDE2FEB1D4EAE36D6F56EE058EE73");
    }

    var_1._id_11E1D _id_12AFF(var_0.team);
  } else if(isvalidmissile(var_0))
    var_0.exploding = 1;
}

onplayerconnectstream(var_0, var_1) {}

hudkothbesttime(var_0, var_1) {
  if(!isDefined(var_0))
    return 1;

  return 0;
}

confirmed_pilot(var_0, var_1) {
  var_0 dodamage(10000, self.origin);
}

connect_circlar_path(var_0, var_1) {}

connect_init(var_0, var_1) {
  if(var_0 == self)
    return 1;

  if(isDefined(var_0.vehiclename) || isDefined(var_0.equipmentref) && var_0.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
    return 0;

  return 1;
}

_id_14479() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = scripts\engine\trace::create_default_contents(1);
    var_1 = scripts\mp\utility\entity::getentitiesinradius(self.origin, 175, undefined, self, var_0);

    if(isDefined(var_1) && var_1.size > 0) {
      foreach(var_3 in var_1) {
        var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_3, 0);

        if(isDefined(var_3.vehiclename)) {
          if(isDefined(var_4) && var_4.size > 0)
            var_3 dodamage(10000, self.origin, self, self);
          else {
            var_5 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var_3.vehiclename);
            var_6 = var_5.destroycallback;
            var_3 thread[[var_6]](undefined, 1);
          }
        }

        if(isDefined(var_3.animname) && var_3.animname == "_encstr_BA8E0766EA368EDE9B")
          var_3 thread _debug_rooftopobjstart::playerswithoutdismemberment(undefined);
      }
    }

    wait 1;
  }
}

setup_backup_respawn_points_in_verdansk() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = self getentitynumber();
  var_1 = 150;
  var_2 = physics_createcontents(["_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_3 = (var_1, var_1, 200);
  var_4 = [self, self._id_12D3F, self.waypoint_endzone_vfx, self.rearturret];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_5 - var_3;
    var_7 = var_5 + var_3;
    var_8 = physics_aabbbroadphasequery(var_6, var_7, var_2, var_4);

    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      var_10 = var_8[var_9];

      if(istrue(var_10._id_11B0D)) {
        continue;
      }
      if(isDefined(var_10.idflags_br_armor_hit) && isDefined(var_10.idflags_br_armor_hit.size)) {
        if(var_10.idflags_br_armor_hit.size > 0) {
          if(isDefined(var_10.idflags_br_armor_hit[var_0]))
            continue;
        }
      }

      if(isDefined(var_10.equipmentref)) {
        if(var_10.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {
          if(!var_10.collision istouching(self)) {
            continue;
          }
          var_10 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
          var_10._id_11B0D = 1;
          continue;
        }
      }

      if(isDefined(var_10.get_teaminquiry_alias))
        var_10 thread scripts\mp\equipment\binoculars::get_smoke_grenade_start_pos();

      if(!var_10 istouching(self)) {
        continue;
      }
      if(isDefined(var_10.cratetype) && var_10.cratetype == "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D") {
        hudkothtimer(var_10, self, var_5);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var_10)) {
        if(istrue(var_10.usedropspawn)) {
          continue;
        }
        var_10 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 1);
        var_10._id_11B0D = 1;
        continue;
      }

      if(hudextractmax(var_10)) {
        if(isDefined(var_10.health) && var_10.health > 0) {
          var_10 dodamage(var_10.health + 100, self.origin);
          var_10._id_11B0D = 1;
        }
      }
    }

    waitframe();
  }
}

hudextractmax(var_0) {
  if(!isDefined(var_0.weapon_name))
    return 0;

  var_1 = 0;

  switch (var_0.weapon_name) {
    case "_encstr_81BE0DD71ADF8095A15AF84861C549":
    case "_encstr_92BC0F408BC20108238458CE67F3F6F32A":
      var_1 = 1;
      break;
  }

  if(var_1)
    return 1;

  return 0;
}

vehicle_collision_loadtablecell(var_0, var_1, var_2) {
  if(!isDefined(var_0.idflags_br_armor_hit))
    var_0.idflags_br_armor_hit = [];

  var_3 = self getentitynumber();
  var_0.idflags_br_armor_hit[var_3] = var_1;
  wait(var_2);

  if(isDefined(var_0) && isDefined(var_0.idflags_br_armor_hit))
    var_0.idflags_br_armor_hit[var_3] = undefined;

  if(isDefined(var_0) && isDefined(var_0.idflags_br_armor_hit) && var_0.idflags_br_armor_hit.size == 0)
    var_0.idflags_br_armor_hit = undefined;
}

hudkothtimer(var_0, var_1, var_2) {
  if(!istrue(var_0.spawn_juggernauts_fob)) {
    var_3 = var_1.velocity * 150;
    var_0 playSound("_encstr_BEEB1CF5796146279E0141BBE97E77BEC8CB4F48E3784C17CB38ABD2B1CD");
    var_0 physicslaunchserver(var_2, var_3);
    var_0.spawn_juggernauts_fob = 1;
    level thread vehicle_collision_loadtablecell(var_0, var_1, 1);
  } else {
    var_0 scripts\cp_mp\killstreaks\airdrop::destroycrate();
    var_0._id_11B0D = 1;
  }
}

_id_144CA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0) && isPlayer(var_0)) {
      self._id_11E1D _id_13F03(var_0);
      break;
    }
  }
}

_id_1423F(var_0, var_1) {}

_id_1422F(var_0, var_1) {
  self notify("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  self endon("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 0;
  self.carriable_explode = 1;
  self.tutonplayerkilled = undefined;

  if(!isDefined(var_1))
    var_1 = 0;

  var_0.initial_enemy_spawner = 0;
  var_0._id_136FB = var_1;
  thread _id_1423A();
  var_3 = 1;
  self startpathnodes(var_0.points, var_0.times, 0, 0.5, 0.5, 0, 0, var_2, 0, 0, 1, 1);
}

_id_14483(var_0) {
  self notify("_encstr_A974171F6F0AF929A8866BE02173B0A7234FAF93B342B3B0C2");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A974171F6F0AF929A8866BE02173B0A7234FAF93B342B3B0C2");

  for(;;) {
    self waittill("_encstr_B454120EB087C7B1E3C7C948782B7B9F71CF9894");

    if(self.inside_bush >= level.hudglobalkillcountmax.paths[var_0].size - 1)
      self.inside_bush = 0;
    else
      self.inside_bush = self.inside_bush + 1;

    self startpathnodes(level.hudglobalkillcountmax.paths[var_0][self.inside_bush].points, level.hudglobalkillcountmax.paths[var_0][self.inside_bush].times, 0, 0.5, 0.5, 0, 0, 0, 0, 0, 1, 1);
  }
}

freight_lift_build(var_0, var_1) {
  var_2 = 0.0000157828;
  var_3 = 3600;
  var_4 = 1;
  var_5 = distance(var_0, var_1);
  var_6 = var_5 * var_2;
  var_7 = max(var_6 / 10 * var_3, var_4);
  return var_7;
}

_id_1423A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B8CC16B38B41C76E6DBA6BC102378C19492A7C1A8BF2682B");
  self endon("_encstr_B8CC16B38B41C76E6DBA6BC102378C19492A7C1A8BF2682B");
  self endon("_encstr_AD75063D571AE108");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_7)) {
      continue;
    }
    if(var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::nuke_vault_suicidebombers()) {
      var_7 _id_1423E(self);
      continue;
    }

    if(isDefined(var_7.equipmentref) && var_7.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
      var_7 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 1);
  }
}

_id_14237() {
  self notify("_encstr_97FE16D6B48DC6BE0E2C3A43EB563719EBDD583AD8A1ACE4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_97FE16D6B48DC6BE0E2C3A43EB563719EBDD583AD8A1ACE4");

  for(;;) {
    self waittill("_encstr_8EE01139CA2C6C0D958CAF2B7346D737ED8CAC");
    self notify("_encstr_B454120EB087C7B1E3C7C948782B7B9F71CF9894");
  }
}

_id_1423E(var_0) {
  self._id_12282 = 1;
  self dodamage(self.health, var_0.origin, var_0, var_0);

  if(isDefined(self))
    self._id_12282 = undefined;
}

_id_11F86(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_onentity(var_0, self);
    wait 0.1;
  }
}

accessoryfem() {}

preventleave(var_0) {
  var_1 = var_0;
  var_2 = [];

  for(var_2[var_2.size] = var_0; isDefined(var_1.target); var_1 = var_3) {
    var_3 = getvehiclenode(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2[var_2.size] = var_3;
  }

  return var_2;
}

accessreaderscriptableused() {}

is_stealth_sequence_activated() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_87EF0F37D02BCD8B0F0EA51D7411128730");
  _id_13077(1, 5, 5);
  wait 3;
  _id_13077(10, 5, 5);
  thread is_stealth_sequence_activated();
}

_id_13077(var_0, var_1, var_2) {
  foreach(var_4 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    if(isDefined(var_4)) {
      level.hudglobalkillcountmax.i_see_player_drone_watcher[0].intel_pieces = var_0;
      var_4 vehicle_setspeed(var_0, var_1, var_2);
    }
  }
}

_id_13F03(var_0) {
  if(isDefined(var_0))
    _id_12AFF(var_0.team);

  if(!isDefined(self.waypoint_endzone_vfx.groundtargetent))
    _id_135EE();

  if(isDefined(self.initplunderpads) && self.initplunderpads != "_encstr_AAD208CADCD92CB3B219") {
    thread disengage_watcher();
    self.initplunderpads = "_encstr_AAD208CADCD92CB3B219";
    self notify("_encstr_AAD208CADCD92CB3B219");
    self.intel_pieces = 15;
    self.waypoint_endzone_vfx thread _id_13C3F();
    self._id_12D3F thread _id_13C3F();
    self.rearturret thread _id_13C3F();
    var_0.intel_collect_vo_func = 0;
    var_0.armsrace_c4_planter_backlot = 0;
    thread _id_13A6A();
    thread _id_12C4E();
    self.waypoint_endzone_vfx thread playapache_dialogue(var_0);
    self._id_12D3F thread playapache_dialogue(var_0);
    self.rearturret thread playapache_dialogue(var_0);
  }
}

disengage_watcher() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level.hudglobalkillcountmax.locindex = level.hudglobalkillcountmax.locindex - 1;

    if(level.hudglobalkillcountmax.locindex <= 0) {
      var_0 = scripts\common\utility::playersincylinder(self.origin, 1000);

      if(isDefined(var_0) && isDefined(var_0[0]))
        level.hudglobalkillcountmax.locindex = 20;
      else
        break;
    }

    wait 1;
  }

  if(isDefined(self)) {
    self.initplunderpads = "_encstr_A6C30A1D9B978D8F9BB44DE7";

    if(isDefined(self.waypoint_endzone_vfx)) {
      self.waypoint_endzone_vfx cleartargetentity();
      self.waypoint_endzone_vfx notify("_encstr_932D0C087BD23CA6CBBB553A4DE8");
      self.waypoint_endzone_vfx.groundtargetent delete();
    }

    if(isDefined(self._id_12D3F)) {
      self._id_12D3F cleartargetentity();
      self._id_12D3F notify("_encstr_932D0C087BD23CA6CBBB553A4DE8");
      self._id_12D3F.groundtargetent delete();
    }

    if(isDefined(self.rearturret)) {
      self.rearturret cleartargetentity();
      self.rearturret notify("_encstr_932D0C087BD23CA6CBBB553A4DE8");
      self.rearturret.groundtargetent delete();
    }

    if(isDefined(self.cannon)) {
      self.cannon cleartargetentity();
      self.cannon notify("_encstr_932D0C087BD23CA6CBBB553A4DE8");
    }

    self._id_1253B thread _id_144CA();
  }

  self notify("_encstr_82760B57B0706CF1D3BB8D479E");
  self._id_12B1D = [];
  self notify("_encstr_AAD208CADCD92CB3B219");
  _id_13077(5, 5, 5);
}

_id_13A6A() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    foreach(var_1 in self._id_12B1D) {
      if(isDefined(var_1) && isDefined(var_1.origin)) {
        var_1.intel_collect_vo_func = _id_12EFC(var_1) + _id_12F0C(var_1);

        if(var_1.intel_collect_vo_func < 0)
          var_1.intel_collect_vo_func = 0;
      }
    }

    wait 0.1;
  }
}

_id_12EFC(var_0) {
  return (1 - distance2d(self.origin, var_0.origin) / 5000) * 1;
}

_id_12F0C(var_0) {
  var_1 = var_0.armsrace_c4_planter_backlot;

  if(!isDefined(var_0.armsrace_c4_planter_backlot))
    return 0;

  if(var_0.armsrace_c4_planter_backlot > 1000)
    var_1 = 1000;

  return var_1 / 1000 * 2;
}

_id_12C4E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    wait 5;

    foreach(var_1 in self._id_12B1D) {
      if(isDefined(var_1) && isDefined(var_1.armsrace_c4_planter_backlot)) {
        var_1.armsrace_c4_planter_backlot = var_1.armsrace_c4_planter_backlot - 250;

        if(var_1.armsrace_c4_planter_backlot < 0)
          var_1.armsrace_c4_planter_backlot = 0;
      }
    }
  }
}

playapache_dialogue(var_0) {
  self._id_11E1D endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  waitframe();
  var_1 = 0;
  var_2 = 1;
  var_3 = var_0;
  self.attackingtarget = var_0;
  self.canseetarget = _id_140D7(self, self.groundtargetent, self.attackingtarget);

  for(;;) {
    if(isDefined(var_3) && self.canseetarget && !scripts\mp\utility\player::unset_relic_trex(var_3) && scripts\mp\utility\player::isreallyalive(var_3) && var_1 < self._id_11E1D.clipsize && scripts\engine\utility::distance_2d_squared(self.origin, var_3.origin) < 25000000) {
      if(!isDefined(self.groundtargetent)) {
        return;
      }
      self.groundtargetent.origin = var_3.origin;
      var_4 = vectordot(anglestoright(self._id_11E1D.angles), vectorNormalize(self.groundtargetent.origin - self.origin));
      var_5 = vectordot(-1 * anglesToForward(self._id_11E1D.angles), vectorNormalize(self.groundtargetent.origin - self.origin));

      if(self.name == "_encstr_86460DC9A5D9D0A3AFA3BA9339B21D") {
        if(var_4 >= self._id_11B52)
          fire_turret(var_3);
      } else if(self.name == "_encstr_81740C33A849FC79792D023A1D51") {
        if(var_4 <= -1 * self._id_11B52)
          fire_turret(var_3);
      } else if(self.name == "_encstr_B4F50CE49516C9BE47D593392BE8" && var_5 > self._id_11B52)
        fire_turret(var_3);

      var_1++;
    } else if(var_1 < self._id_11E1D.clipsize)
      var_3 = selfrevivemonitorrevivebuttonPressed();
    else {
      wait 4;
      var_3 = selfrevivemonitorrevivebuttonPressed();
      var_1 = 0;
    }

    wait 0.1;
  }
}

fire_turret(var_0) {
  self settargetentity(self.groundtargetent);
  _id_13129(self, var_0.origin, level.hudglobalkillcountmax._id_13E81);
  self shootturret("_encstr_A14F0AE336178944BA076F41");
}

_id_14448(var_0) {
  self._id_11E1D endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    if(!_id_140D7(self, self.groundtargetent, var_0)) {
      wait 0.5;
      self.canseetarget = 0;
      self notify("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
    } else
      self.canseetarget = 1;

    wait 0.5;
  }
}

_id_14475() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.maxhealth * 0.6;

  for(;;) {
    if(self.health < var_0) {
      get_all_players_enemy_info_new();
      var_0 = var_0 / 2;
    }

    wait 0.1;
  }
}

get_all_players_enemy_info_new() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 7;
  var_1 = semtex_killstuckplayer();

  for(;;) {
    if(isDefined(var_1)) {
      level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.origin + (0, 0, 75), "_encstr_999A07C61338F9A23A", 2);

      foreach(var_3 in self._id_12B1D)
      _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(var_1, "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");

      wait 1;
      thread pavelow_boss_explodes(var_1);
      wait 60;
      break;
    }
  }
}

accuracy_bonus_factor() {}

selfrevivemonitorrevivebuttonPressed() {
  var_0 = 0;
  var_1 = undefined;

  if(self._id_11A52.size > 0) {
    foreach(var_3 in self._id_11A52) {
      if(isDefined(var_3)) {
        if(isDefined(var_3.intel_collect_vo_func) && var_3.intel_collect_vo_func > var_0)
          var_1 = var_3;
      }
    }

    thread _id_14448(var_1);
  }

  return var_1;
}

semtex_killstuckplayer() {
  if(!isDefined(self) || self._id_12B1D.size == 0) {
    return;
  }
  if(self._id_12B1D.size == 1)
    return self._id_12B1D[0];

  return self._id_12B1D[randomintrange(0, self._id_12B1D.size - 1)];
}

selfrevivebuttonPressed() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self._id_12B1D[0];

  for(var_1 = 1; var_1 < self._id_12B1D.size; var_1++) {
    if(!isDefined(self._id_12B1D[var_1])) {
      self._id_12B1D = scripts\engine\utility::can_path_to_target(self._id_12B1D, var_1);
      continue;
    }

    if(scripts\engine\utility::distance_2d_squared(self, self._id_12B1D[var_1]) < scripts\engine\utility::distance_2d_squared(self.origin, var_0.origin))
      var_0 = self._id_12B1D[var_1];
  }

  return var_0;
}

_id_12AFF(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3) && !scripts\engine\utility::array_contains(self._id_12B1D, var_3))
        self._id_12B1D[self._id_12B1D.size] = var_3;
    }
  }
}

_id_13C3F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_11E1D endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 = 0;

  for(var_1 = 0; var_1 < self._id_11E1D._id_12B1D.size + 1; var_1++) {
    scripts\engine\utility::array_removeundefined(self._id_11E1D._id_12B1D);
    scripts\engine\utility::array_removeundefined(self._id_11A52);

    if(var_1 >= self._id_11E1D._id_12B1D.size)
      var_1 = 0;

    if(self._id_11E1D._id_12B1D.size == 0) {
      break;
    }

    if(scripts\mp\utility\player::unset_relic_trex(self._id_11E1D._id_12B1D[var_1]))
      self._id_11E1D _id_12BEA(self._id_11E1D._id_12B1D[var_1]);
    else if(_id_140D7(self, self.groundtargetent, self._id_11E1D._id_12B1D[var_1])) {
      if(!scripts\engine\utility::array_contains(self._id_11A52, self._id_11E1D._id_12B1D[var_1]))
        self._id_11A52[self._id_11A52.size] = self._id_11E1D._id_12B1D[var_1];
    } else if(scripts\engine\utility::array_contains(self._id_11A52, self._id_11E1D._id_12B1D[var_1])) {
      self._id_11A52 = scripts\engine\utility::array_remove(self._id_11A52, self._id_11E1D._id_12B1D[var_1]);

      if(self._id_11A52.size <= 0)
        self cleartargetentity();
    }

    if(var_1 % 3 == 0)
      wait 0.1;
  }
}

_id_12BEA(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::array_contains(self._id_12D3F._id_11A52, var_0);
  var_2 = scripts\engine\utility::array_contains(self.waypoint_endzone_vfx._id_11A52, var_0);
  var_3 = scripts\engine\utility::array_contains(self.rearturret._id_11A52, var_0);

  if(var_1)
    self._id_12D3F._id_11A52 = scripts\engine\utility::array_remove(self._id_12D3F._id_11A52, var_0);
  else if(var_2)
    self.waypoint_endzone_vfx._id_11A52 = scripts\engine\utility::array_remove(self.waypoint_endzone_vfx._id_11A52, var_0);
  else if(var_3)
    self.rearturret._id_11A52 = scripts\engine\utility::array_remove(self.rearturret._id_11A52, var_0);
}

_id_13129(var_0, var_1, var_2) {
  var_3 = var_1;

  if(isDefined(var_2)) {
    var_4 = randomint(var_2);
    var_5 = randomint(360);
    var_6 = randomintrange(32, 48);
    var_7 = var_1[0] + var_4 * cos(var_5);
    var_8 = var_1[1] + var_4 * sin(var_5);
    var_9 = var_1[2] + var_6;
    var_3 = (var_7, var_8, var_9);
    var_0.groundtargetent.origin = var_3;
  }
}

accessoryfemband() {}

hurt_enabled() {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(self.vehiclename, 20);
  hudsbredeploy("_encstr_9B69114A571F8EBD17484FBA87220987C71A97", 4.0, 20);
  hudsbredeploy("_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA", 4.0, 20);
  hudsbredeploy("_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59", 4.0, 20);
  hudsbredeploy("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", 4.0, 20);
  hudsbredeploy("_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0", 4.0, 20);
  hudsbredeploy("_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920", 5.0, 20);
  hudsbredeploy("_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B", 4.0, 20);
  hudsbredeploy("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0", 2.85714, 20);
  hudsbredeploy("_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB", 2.85714, 20);
  hudsbredeploy("_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1", 2.85714, 20);
  hudsbredeploy("_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", 2.85714, 20);
  hudsbredeploy("_encstr_8A6E10B968F5D885BE0E0B63831A58BEAD0E", 4.0, 20);
  hudsbredeploy("_encstr_8C2F1137A27861F12E284A3D76576398DF8B6B", 4.0, 20);
  hudsbredeploy("_encstr_9331124BFBD033DE7171F9CC49F0E61ACE0E2203", 4.0, 20);
  hudsbredeploy("_encstr_9AAE0876FCB7603101DB", 4.0, 20);
  hudsbredeploy("_encstr_92A70ABB8267F5E0D89F6351", 2.85714, 20);
  hudsbredeploy("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 2.85714, 20);
  hudsbredeploy("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0", 2.85714, 20);
  hudsbredeploy("_encstr_BA730BF8AFF178988293F158B9", 1.81818, 20);
  hudsbredeploy("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", 1.81818, 20);
  hudsbredeploy("_encstr_81430B218B3F7018458997D78A", 2.85714, 20);
  hudsbredeploy("_encstr_99410C4B48C39AB7D0CD95B769DB", 1, 36);
  hudsbredeploy("_encstr_B29B0FE0E32573E3A23395B04E6BBF5898", 1, 36);
  hudsbredeploy("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1, 30);
  hudsbredeploy("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 1, 52);
  hudsbredeploy("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", 2.85714, 20);
  hudsbredeploy("_encstr_ACC40CC1F8A321601715CFBFE0EA", 2.85714, 20);
  hudsbredeploy("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 2.0, 20);
  hudsbredeploy("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 1.42857, 20);
  hudsbredeploy("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1.0, 20);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(self.vehiclename, 1);
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, ::hunters_killed_by_targets);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, ::humanspawninair);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, ::hudnumtoconsume);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

hudsbredeploy(var_0, var_1, var_2) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(var_0, var_1, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var_2, var_0);
}

hunters_killed_by_targets(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!isDefined(var_2) || !isPlayer(var_2))
    return 0;

  level.hudglobalkillcountmax.locindex = 20;

  if(isDefined(self.initplunderpads) && self.initplunderpads != "_encstr_AAD208CADCD92CB3B219" && !level.hudglobalkillcountmax.getoldestdogtags)
    _id_13F03(var_2);

  return 1;
}

humanspawninair(var_0) {
  if(!isDefined(self.attackers))
    self.attackers = [];

  var_1 = hudkothbesttimelabel(var_0.attacker);

  if(!isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.player = var_0.attacker;
    var_2.objweapon = var_0.objweapon;
    var_2._id_13BEE = var_0.damage;
    self.attackers[self.attackers.size] = var_2;
  } else {
    var_1._id_13BEE = var_1._id_13BEE + var_0.damage;
    var_1.objweapon = var_0.objweapon;
  }

  if(!isDefined(var_0.attacker.armsrace_c4_planter_backlot))
    var_0.attacker.armsrace_c4_planter_backlot = 0;

  var_0.attacker.armsrace_c4_planter_backlot = var_0.attacker.armsrace_c4_planter_backlot + var_0.damage;

  if(var_0.attacker.armsrace_c4_planter_backlot > 1000)
    var_0.attacker.armsrace_c4_planter_backlot = 1000;

  level.hudglobalkillcountmax._id_119E9 = level.hudglobalkillcountmax._id_119E9 - var_0.damage;

  if(is_enemy_dangerous(var_0.objweapon.basename))
    self notify("_encstr_87EF0F37D02BCD8B0F0EA51D7411128730");

  if(level.hudglobalkillcountmax._id_119E9 <= 0)
    self notify("_encstr_82C20BD0AAE76DA9923899FB44");

  if(self.health < self.maxhealth * 0.8 && self.is_enemy_of_type == 1) {
    self.is_enemy_of_type = 2;
    thread watchcrategastimeout(6);
  }

  return 1;
}

hasseenendgamesplash() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;)
    wait 1;
}

hudplunderstart() {
  var_0 = getDvar("_encstr_8B380D5AE910DF5A4ECFB3F7BDF612");
  level._id_12815 = spawnStruct();
  level._id_12815.ammo = ["_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD", "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"];
  level._id_12815.armor = ["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"];
  level._id_12815.weapon_xp_iw8_sh_mike26 = ["_encstr_AF491213931BDEDB477DED339934587391BE3686", "_encstr_B4C917454B4230F0E441706937D0C8F89A9723D7ABDA05281E"];

  if(isDefined(var_0) && var_0 != "_encstr_BD1904CF572A") {
    level._id_12815.weapon_xp_iw8_sh_mike26[level._id_12815.weapon_xp_iw8_sh_mike26.size] = "_encstr_A7F5186B7A448F67735F2F9F072B617E6859A399D1552A585465";
    level._id_12815.weapon_xp_iw8_sh_mike26[level._id_12815.weapon_xp_iw8_sh_mike26.size] = "_encstr_855518036DB172EFD89EB5FF911029DA1D9F9FB333631AD73021";
    level._id_12815.weapon_xp_iw8_sh_mike26[level._id_12815.weapon_xp_iw8_sh_mike26.size] = "_encstr_96B6164C938DDEDEA3D7B73399D00BDC46D7E6B2B5A3B20F";
  }

  level._id_12815._id_11CD2 = ["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922"];
}

hudglobalkillcount(var_0) {
  if(_encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::get_bonus_targets(var_0)) {
    var_1 = level.br_pickups.delay_hide_player_clip[var_0];
    var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    var_3 = anglesToForward(self.angles) * 155 * -1;
    var_4 = self.origin + var_3;
    var_5 = (var_4[0], var_4[1], self.origin[2] + 100);
    var_6 = vectorNormalize(var_5 - (self.origin + (0, 0, 100))) * 155;
    var_7 = self.origin + var_6;

    if(issubstr(var_0, "_encstr_B483058670B0B7")) {
      var_8 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_0, var_2, var_7, self.angles, 0, 0);
      var_8.count = level.br_pickups.maxcounts[var_0];
    } else {
      var_9 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_0, var_2, var_7, self.angles, 0, 0);

      if(isDefined(var_9))
        var_9.count = 1;
    }
  }
}

hunterswonending() {
  var_0 = randomint(4);

  switch (var_0) {
    case 0:
      var_1 = level._id_12815.ammo[randomint(level._id_12815.ammo.size - 1)];
      hudglobalkillcount(var_1);
      break;
    case 1:
      var_1 = level._id_12815.armor[0];
      hudglobalkillcount(var_1);
      break;
    case 2:
      var_1 = level._id_12815.weapon_xp_iw8_sh_mike26[randomint(level._id_12815.weapon_xp_iw8_sh_mike26.size - 1)];
      hudglobalkillcount(var_1);
      break;
    case 3:
      var_1 = level._id_12815._id_11CD2[0];
      hudglobalkillcount(var_1);
      break;
    default:
      break;
  }
}

vehicle_damage_onenterstateheavy() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_82C20BD0AAE76DA9923899FB44");
  hunterswonending();
  wait 0.1;
  hunterswonending();
  wait 0.1;
  hunterswonending();
  wait 0.1;
  hunterswonending();
  level.hudglobalkillcountmax._id_119E9 = 500;
  thread vehicle_damage_onenterstateheavy();
}

is_enemy_dangerous(var_0) {
  if(var_0 == "_encstr_9AAE0876FCB7603101DB" || var_0 == "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860" || var_0 == "_encstr_81430B218B3F7018458997D78A" || var_0 == "_encstr_ACC40CC1F8A321601715CFBFE0EA")
    return 1;

  return 0;
}

hudnumtoconsume(var_0) {
  if(isDefined(self.waypoint_endzone_vfx))
    self.waypoint_endzone_vfx delete();

  if(isDefined(self._id_12D3F))
    self._id_12D3F delete();

  if(isDefined(self.cannon))
    self.cannon delete();

  if(isDefined(self.rearturret))
    self.rearturret delete();

  self._id_1253B delete();
  self.computerrebootused delete();
  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0.attacker;
  var_4 = istrue(self._id_133DA);
  level.hudglobalkillcountmax.i_see_player_drone_watcher = scripts\engine\utility::array_remove(level.hudglobalkillcountmax.i_see_player_drone_watcher, self);
  self notify("_encstr_AD75063D571AE108", var_0.attacker, var_0.meansofdeath, var_0._id_14596, var_0.damagelocation);

  if(!var_4) {
    foreach(var_6 in self.attackers) {
      if(isDefined(var_6.player)) {
        if(isDefined(var_3) && var_3 == var_6.player)
          var_1 = "_encstr_A1C20E964793E3EF68C9184B9245A3F9";
        else
          var_1 = "_encstr_B81A0EB1ED7367BD97D7856EDCB4B9D1";

        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
        var_6.player thread scripts\mp\rank::giverankxp(var_1, var_2, var_6.objweapon);
        var_6.player thread scripts\mp\events::killeventtextpopup(var_1, 0);
        thread scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled(self, var_0.inflictor, var_6.player, 0, var_6.objweapon);
      }
    }

    foreach(var_9 in self._id_12B1D) {
      if(isDefined(var_9))
        var_9 thread scripts\mp\hud_message::showsplash("_encstr_AF071459ED568888D337B9BDB75AC279F6C460901288");
    }

    if(getdvarint("_encstr_ABF527BF683B276A6531550A2D6141A320A83347C0F655C3B959DC460339196B09D8C3FF808B870BD7", 0) == 1) {
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922", getdvarint("_encstr_B28629ABDFC219DBD35DE805BBC9CFE748087B20E2D8F2071EB90F4D552B30835D274527CE6F3B7A4DF8F3", 0), self.origin);
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996", getdvarint("_encstr_A29729CB508E675A3A80F2AB3ADA1707D23D9B5DC779E159EF0BB9A8B0874FCA5B2A95202A5F3F180D70CB", 0), self.origin);
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC", getdvarint("_encstr_832229070FFE31A12818753A31B0D74AD8BD8BFFC3B03A9978C061C348703FE2A12763C7FFD8625FA028A3", 0), self.origin);
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A", getdvarint("_encstr_88A6259A8793F7566B09B09E6B09299FC89B3307B0F92ADF768BB9934FB24518AAA91F8273EDEB", 0), self.origin);
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3", getdvarint("_encstr_8A91258BAB6B997A9B35704B225B0938B0C6B37558C9C2073B03D18EE9C6139FBA7E76C8639DBC", 0), self.origin);
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926", getdvarint("_encstr_81D2256E6C93AF1627B57B9C2B32EB8DB7B9B37B5ED71BB0371AEB561CA56CEB26FAC67BEACDA3", 0), self.origin);
      _encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7("_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2", getdvarint("_encstr_81D2256E6C93AF1627B57B9C2B32EB8DB7B9B37B5ED71BB0371AEB561CA56CEB26FAC67BEACDA3", 0), self.origin);
    } else
      level thread _handlevehiclerepair::_id_13673("_encstr_ADBB0FB0C16943EFC5BEE0BA51C25B0B20", self.origin, 10, 1);

    level thread _handlevehiclerepair::_id_13673("_encstr_9AB11177A1B7A10F4DBB98200123C339E35F08", self.origin, 1, 0);
    level thread _handlevehiclerepair::_id_13673("_encstr_ACDA0F16A57D6CF673B3DB97F576560B27", self.origin, 2, 0);
    level thread _handlevehiclerepair::_id_13673("_encstr_B27111DEA879E38A409DD787E7F613482B53D2", self.origin, 3, 0);
    level thread _handlevehiclerepair::_id_13673("_encstr_A798166F84291F38BE13B870CFC3B04942AA5D6E1F22F763", self.origin, 1, 0);
  }

  var_11 = getdvarint("_encstr_B4B1173736E4EB8DDEDCECDB2FBE47AC166B7DE07B2DB947CD", 0);

  if(isDefined(var_3) && var_11 > 0 && !isDefined(var_0._id_11E93))
    level scripts\mp\gamescore::giveteamscoreforobjective(var_3.team, var_11, 0);

  level.hudglobalkillcountmax.brvalidatekillcam++;
  var_12 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFX(scripts\engine\utility::getfx("_encstr_B4D715B1F6CD3BB7F2EBA393AB8D6D7D2BF0E063DB8CAC"), var_12, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_12, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
  earthquake(0.4, 800, var_12, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_12);
  physicsexplosionsphere(var_12, 500, 200, 1);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
  scripts\engine\utility::array_removeundefined(level.hudglobalkillcountmax.i_see_player_drone_watcher);
  return 0;
}

_encstr_8A8D20A7DF825C1009A1138BD6EFD0AF8B0B132F5F6AAB28178659E3BC9F784B13A7(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.item = var_0;
  var_3.ml_p3_to_safehouse_transition = var_1;
  var_3.heightoffset = 0;
  var_3.origin = var_2;

  for(var_4 = 0; var_4 < var_1; var_4++)
    thread _handlevehiclerepair::_id_13672(var_3);
}

hudkothbesttimelabel(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  foreach(var_3 in self.attackers) {
    if(isDefined(var_3.player) && var_0 == var_3.player) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

minigamelosersettings() {
  var_0 = self.origin;

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC", self.origin, (0, randomfloat(360), 0), var_0);
    var_1._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    var_1._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_1._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_AB0703DBB9", 0);

    if(isDefined(var_1))
      var_1 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_8C2414DAF1EFBB38919F1DE169E805D78F6BF222D8B6");

    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2._id_140A0 = 10;
  }
}

_id_140D7(var_0, var_1, var_2) {
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_2) || scripts\mp\utility\player::unset_relic_trex(var_2))
    return 0;

  var_3 = 1;
  var_4 = 1;
  var_5 = 0;
  var_6 = 1;
  var_7 = 0;
  var_8 = 1;
  var_9 = 0;
  var_10 = 1;
  var_11 = 0;
  var_12 = scripts\engine\trace::create_contents(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = var_12 + init_cp_execution("_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4");
  var_12 = var_12 + init_cp_execution("_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39");
  var_13 = [var_0];

  if(isDefined(var_1)) {
    var_13[var_13.size] = var_1;
    var_14 = var_1 getlinkedchildren();

    if(isDefined(var_14) && var_14.size > 0)
      var_13 = scripts\engine\utility::array_combine(var_13, var_14);
  }

  var_15 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("_encstr_91E80B3A2CCE7D262C4E9359D8"), var_2.origin, var_13, var_12);
  return var_15;
}

init_cp_execution(var_0) {
  var_1 = [var_0];
  return physics_createcontents(var_1);
}

accessorybig() {}

watchcheck() {}

buttonmashcount(var_0) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A1F02398937D279567AC5836AF897BD631169C46DA59B9D1BE6316BADCD8A1F5AC37CA6B5E");
}

crates_delete_early() {
  var_0 = getmaxobjectivecount(self.origin[0], self.origin[1], 2000);
  level waittill("_encstr_8A501330E6B5B0764AAF1D3F5FD24F987C7D99884B");
  var_0 delete();
}

create_animpack(var_0, var_1) {
  var_2 = magicgrenademanual("_encstr_95E70D8EDBDA85F5839CED35F5B683", var_1.sourcepos, var_1.initvelocity, 5);
  var_3 = var_2 scripts\mp\objidpoolmanager::createobjective("_encstr_A18A1BD2367B9BD7B52DB92DB60B38AFD8E4AED2DCACDA4B373796632B", "_encstr_8E8405EA382B2A", undefined, 1, 1);
  var_2 setentityowner(self);
  var_2 setotherent(self);
  var_2.owner = self;
  var_2 setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 0);
  var_2.explodeent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.explodeent setModel("_encstr_97901DB71389F8E0E75AAE5373E3AB485FA7330BBB6AE8B9EF91E03BE9E3FE");
  var_2.explodeent linkTo(var_2);
  var_2.explodeent dontinterpolate();
  var_2.explodeent setentityowner(self);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.sourcepos);
  var_4 linkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (10, 0, 10), (0, 0, 0));
  var_2.killcament = var_4;
  var_2.streakinfo = var_0;
  var_5 = randomint(360);
  var_2.angles = (90, var_5, 0);
  var_2 thread create_badplace_extraction(var_1.preexplpos, var_1.parachutecleanup);
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var_1.initvelocity), gettime(), var_1.initvelocity);
  var_2 waittill("_encstr_AD75063D571AE108");
  objective_delete(var_3);
}

cratephysicsoncallback(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = var_0 + (0, 0, 5000);
  var_4 = vectorNormalize(var_0 - (var_3[0], var_3[1], 0));
  var_5 = scripts\cp_mp\killstreaks\toma_strike::_id_13BD6(var_0, var_1, var_4);
  var_6 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));
  var_7 = (var_5.point - 0.5 * var_6 * squared(1) - var_3) / 1;
  var_8 = 1 * randomfloatrange(0.95, 1.0);
  var_9 = var_3 + var_7 * var_8 + 0.5 * var_6 * squared(var_8);
  var_2.sourcepos = var_3;
  var_2.num_of_frame_frozen = var_5.num_of_frame_frozen;
  var_2.num_of_subway_cars = var_5.num_of_subway_cars;
  var_2.goalpos = var_5.point;
  var_2.preexplpos = var_9;
  var_2.initvelocity = var_7;
  var_2.parachutecleanup = var_8;
  return var_2;
}

create_badplace_extraction(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  self.killcament thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_move_killcam(0.75, var_0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self setmissileminimapvisible(0);
  thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_missile_explode(var_0);
}

accessoryface() {}

entityhit() {
  var_0 = spawnStruct();
  var_0.streakname = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  var_0.owner = self;
  var_0.score = 0;
  var_0.shots_fired = 0;
  var_0.hits = 0;
  var_0.damage = 0;
  var_0.kills = 0;
  var_0._id_121A9 = "_encstr_97901DB71389F8E0E75AAE5373E3AB485FA7330BBB6AE8B9EF91E03BE9E3FE";
  var_0._id_121A8 = "_encstr_AF521D6D9BF58EDEDA85FA374727B4B6AC7D1B1B5D9B47ACC97DB683FA1E23";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE"))
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE")]](var_0, "_encstr_A2E60C6BC099B7E1A0A93A398F48");

  return var_0;
}

_id_11D2C(var_0, var_1, var_2) {
  var_3 = play_ac130_approach_scene();
  _id_132B3(var_3, var_0, var_1, var_2);
}

pavelow_boss_explodes(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = spawnStruct();
  var_1.streakname = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  var_1.owner = self;
  var_1.score = 0;
  var_1.shots_fired = 0;
  var_1.hits = 0;
  var_1.damage = 0;
  var_1._id_133DE = 1;
  var_1.kills = 0;
  var_1._id_133CE = 1;
  var_1.setuptimelimit = 0;
  var_1.brmini_ontimelimit = 1;
  var_1.lifeid = 0;
  self.pers["_encstr_8AEF05472BC2D6"] = "_encstr_A7A408B9CA5D1D4E2C63";
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE")]](var_1, "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_1))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_1))
      return 0;
  }

  var_3 = level.scr_anim[var_1.streakname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"];
  var_4 = getanimlength(var_3);
  var_5 = scripts\engine\utility::get_notetrack_time(var_3, "_encstr_999A07C61338F9A23A");
  var_6 = scripts\cp_mp\killstreaks\airstrike::branalytics_respawn(var_0.origin + anglesToForward(var_0.angles) * 1000, self);
  var_7 = self.angles[1];
  scripts\cp_mp\killstreaks\airstrike::finishairstrikeusage(var_0.origin, var_7, var_2, var_1, var_3, var_6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_1);

  scripts\cp_mp\killstreaks\airstrike::branalytics_seteventdelayedstate(self, var_6);
}

play_ac130_approach_scene() {
  var_0 = undefined;

  if(isDefined(level.idflags_br_armor_break))
    var_0 = level.idflags_br_armor_break;
  else {
    var_1 = scripts\engine\utility::array_reverse(level.agentarray);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(isDefined(var_3.team) && var_3.team != "_encstr_8E8405EA382B2A") {
        continue;
      }
      if(!isDefined(var_3.team) && isDefined(var_3.agentteam)) {
        continue;
      }
      var_0 = var_3;
      var_0._id_1407D = 1;

      if(!isDefined(var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"]))
        var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"] = 0;

      break;
    }

    level.idflags_br_armor_break = var_0;
  }

  return var_0;
}

_id_132B3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = var_0 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", var_0);

  var_3._id_11EAE = 0;
  var_3._id_11F47 = 1;
  var_3.vehicle_process_node_when_at_goal = 1;
  var_3._id_121A9 = "_encstr_97901DB71389F8E0E75AAE5373E3AB485FA7330BBB6AE8B9EF91E03BE9E3FE";
  var_3._id_121A8 = "_encstr_AF521D6D9BF58EDEDA85FA374727B4B6AC7D1B1B5D9B47ACC97DB683FA1E23";
  var_0.origin = var_1;
  var_0.angles = vectortoangles(var_2 - var_1);
  var_3._id_13A81 = var_2;
  var_0 thread scripts\cp_mp\killstreaks\toma_strike::starttomastrike(5, undefined, undefined, var_3);
}

_id_13AFB(var_0, var_1) {
  var_2 = scripts\mp\mp_agent::spawnnewagent("_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B", "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8", var_0, var_1);
  var_2 setgoalvolume(level.hudglobalkillcountmax.getoriginidentifierstringnoz);
  var_2 bomber();
}

_id_13068(var_0) {
  switch (var_0) {
    case "_encstr_AB3508737F830710ACDB":
      bomb_hostage_play_anim("_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6");
      self.goalradius = randomintrange(100, 200);
      break;
    case "_encstr_BE1904DCDA9D":
      bomb_hostage_play_anim("_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D");
      self.goalradius = randomintrange(50, 100);
      break;
    case "_encstr_9A190463ADB3":
      break;
    case "_encstr_A65B084B38A76BEFC350":
      break;
    default:
      break;
  }
}

_id_13521(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = var_1 + 300 * anglesToForward((0, (var_3 + 1) * 72, 0));
    var_5 = _id_13AFB(var_4, (0, 0, 0));
    var_2[var_2.size] = var_5;
  }

  return var_2;
}

bomb_hostage_play_anim(var_0, var_1) {
  self.weapon = scripts\mp\class::buildweapon(var_0, ["_encstr_91D30B98AF82FABB1A37C877AA", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
}

bomber() {
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
  self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;
  self.pers["_encstr_8305198D5D93D7AD5AD8B1F5B93A9C5616D6BE33BD937DE6ABB6CA"] = 0;
  self.tookweaponfrom = [];
  self.killedplayers = [];
  self._id_1407D = 0;
}

bonuskillscharge() {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  self endon("_encstr_AD75063D571AE108");
  var_0 = gettime() / 1000;

  for(;;) {
    var_1 = self getgoalvolume();
    var_2 = distance2d(self.origin, var_1.origin);
    var_3 = var_2 < 600;
    self._id_145D4 = var_3;

    if(var_3) {
      var_4 = gettime() / 1000;
      var_5 = var_4 - var_0;
      self._id_13B6B = var_5;
      var_6 = level.ai_event.binoculars_targetisvalid;
      self._id_13B6C = var_6 - var_5;

      if(var_4 - var_0 >= var_6) {
        var_7 = [];

        foreach(var_9 in level.ai_event.select_hostage_room_three_spawners) {
          if(var_9.players.size > 0 && var_9 != var_1)
            var_7[var_7.size] = var_9;
        }

        if(var_7.size > 0) {
          var_11 = scripts\engine\utility::random(var_7);
          self setgoalvolumeauto(var_11);
        }

        var_0 = gettime() / 1000;
      }
    } else
      var_0 = gettime() / 1000;

    wait 1.0;
  }
}

_id_134E9() {}

_id_134EA() {}

activate_scavenger_bag() {}

watchcrategastimeout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B60F1D394C3D40EA63D7A3A5537925D0D3656310F36580880B83AB654BE2FD");
  self endon("_encstr_82760B57B0706CF1D3BB8D479E");
  var_1 = randomintrange(6, 10);
  wait(var_1);
  var_2 = 1;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    self.waypoint_completed_vfx = self gettagorigin("_encstr_844313A90770A82942C517CEBE7959EAA95BF305CB");
    self._id_12D3E = self gettagorigin("_encstr_8A401449E79048C9A225F7EE9E59398AC903CBE75BC9");
    var_4 = randomintrange(4, 6);

    if(var_2)
      var_5 = magicgrenademanual("_encstr_92A70ABB8267F5E0D89F6351", self.waypoint_completed_vfx, (0, 0, -2), var_4, self);
    else
      var_5 = magicgrenademanual("_encstr_92A70ABB8267F5E0D89F6351", self._id_12D3E, (0, 0, -2), var_4, self);

    var_2 = !var_2;
    wait 0.5;
  }

  thread watchcrategastimeout(var_0);
}