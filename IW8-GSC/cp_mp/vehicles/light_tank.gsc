/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\light_tank.gsc
***********************************************/

light_tank_init() {
  level.vehicle.lighttank = spawnStruct();
  level.vehicle.lighttank.canautodestruct = 1;
  level.vehicle.lighttank.autodestructdamagepercent = 11;
  level.vehicle.lighttank.cantimeout = 1;
  level.vehicle.lighttank.timeoutduration = 165;
  level.vehicle.lighttank.cantakedamageduringcapture = 1;
  level.vehicle.lighttank.showheadicon = 1;
  level.vehicle.lighttank.showheadicontoenemy = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0._id_13FCA = ::wheelson_tank_death;
  var_0.destroycallback = ::light_tank_explode;
  light_tank_initoccupancy();
  light_tank_initinteract();
  wheelson_delay_allow_attack();
  wheelson_damage_monitor();
  wheelson_build_path();
  light_tank_initentranceanimations();
  light_tank_initfx();
  light_tank_initspawns();
  light_tank_initvo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_88C5055208731B")]]();

  light_tank_initspawning();
  thread light_tank_initlate();
}

light_tank_initlate() {
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BAF609D2739647C4853A2B")]]();
}

light_tank_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0.enterstartcallback = ::light_tank_enterstart;
  var_0.enterendcallback = ::light_tank_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::light_tank_exitend;
  var_0.reentercallback = ::light_tank_reenter;
  var_0.updateteamcallback = ::light_tank_updateteam;
  var_0.updateownercallback = ::light_tank_updateowner;
  var_0.threatbiasgroup = "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858";
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 125;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 115;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 70;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 70;
  var_0.exitextents["_encstr_AC190479FF92"] = 130;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (90, 0, 75);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-90, 30, 60);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-90, -30, 60);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-90, -12, 60);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8D48079DD59BE65627"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_AF390B295782C3585F1B21D8C4", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8D48079DD59BE65627", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (35, 15, 60);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.restrictions = scripts\engine\utility::array_remove(var_4.restrictions, "_encstr_88780599B4E495");
  var_4.hideoccupant = 1;
  var_4.damagemodifier = 0;
  var_4.viewclamps["_encstr_AC190479FF92"] = 30;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 35;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 180;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 180;
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.spawnpriority = 10;
  var_4._id_13E8A = getcompleteweaponname("_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8D48079DD59BE65627";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_AF390B295782C3585F1B21D8C4", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-90, -12, 60);
  var_0.exitdirections[var_3] = "_encstr_B69B0589C236B6";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
}

wheelson_build_path() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0.challengeevaluator = 2.5;
  var_0.keycardlocs_chosen = 0.625;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 1.25;
  var_0.isallowedweapon = 5;
  var_0.isakimbo = 10;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

light_tank_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8D48079DD59BE65627"]);
}

wheelson_delay_allow_attack() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0.id = 1;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8D48079DD59BE65627"] = 1;
  var_0.brtruck_initdialog["_encstr_A7AF07D1EF1B06683C"] = 0;
  var_0.brtruck_initdialog["_encstr_86C808FF9BFE73295899"] = 1;
  var_0.brtruck_initdialog["_encstr_BE7206A2D07B1322"] = 2;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_827E0D809A9733A0E3992D3FBF8D48"] = 0;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83"] = 1;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_8A9B18CDA79A41114F78E7C8AB7719A3EB6702DFB1F277A75BF3"] = 1;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8"] = 0;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0"] = 0;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83"] = 1;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_8A9B18CDA79A41114F78E7C8AB7719A3EB6702DFB1F277A75BF3"] = 1;
}

wheelson_damage_monitor() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_AF390B295782C3585F1B21D8C4", 3000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4");
  var_0.class = "_encstr_81AC0C7BBD0B976247B0BAF26823";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_AF390B295782C3585F1B21D8C4");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_AF390B295782C3585F1B21D8C4", 15);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14176("_encstr_AF390B295782C3585F1B21D8C4", ::light_tank_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_AF390B295782C3585F1B21D8C4", ::light_tank_postmoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_AF390B295782C3585F1B21D8C4", ::light_tank_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C", 7);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20", 7);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_827E0D809A9733A0E3992D3FBF8D48", 5);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

light_tank_initentranceanimations() {
  level.scr_animtree["_encstr_A937066AFF52FA4F"] = #animtree;
  level.scr_anim["_encstr_A937066AFF52FA4F"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"] = % _encstr_A55C1B98F3213DB3BF65BDA07FBB7B9F52A960600AC655487F959F8608;
  level.scr_animname["_encstr_A937066AFF52FA4F"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"] = "_encstr_A55C1B98F3213DB3BF65BDA07FBB7B9F52A960600AC655487F959F8608";
  level.scr_animtree["_encstr_B8650ACAF940B1FAF32B6B27"] = #animtree;
  level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"] = % _encstr_848F19058991F6BBC0D0D27A7EAD636D406F9091E518FE9BF5EB2A;
  level.scr_animname["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"] = "_encstr_848F19058991F6BBC0D0D27A7EAD636D406F9091E518FE9BF5EB2A";
  light_tank_initvehicleentranceanimations();
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

light_tank_initvehicleentranceanimations() {
  level.scr_animtree["_encstr_AF390B295782C3585F1B21D8C4"] = #animtree;
  level.scr_anim["_encstr_AF390B295782C3585F1B21D8C4"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"] = % _encstr_9604165B1CAF4C27B7D6ACDBFA8C4EB707AF9839DEB595BD;
}

light_tank_initfx() {
  level._effect["_encstr_AACC17D8A5CE431DFA1D2C9B6D7D1B0BCDE6F6B97D91AB9B3A"] = loadfx("_encstr_B6E535A3F1F817A294595FAFF1908B95E8DB116C8888EB3B6F1FF38B0970B3C371E316B56011ABB248858FB35F85DB1390EE0B2DBB7068");
  level._effect["_encstr_A5BC13D50B77E88BE1DCC938070F4DC8A3432FA822"] = loadfx("_encstr_AA192D67660F792DEE83F55B1C79D64B8D36DCE89356C2D697D9CCF0FA4758CDB5D7235916E8D0D7560F1CC5D966E1");
  level._effect["_encstr_8AA41770A467403DF9C3DBFD87C18D88287D9809CFF7B0F9A3"] = loadfx("_encstr_915E32A072084730FF10808130F638B375BA10388BE713884666140307A3A1751C112008527B5946478027E8151FAB19952B4868");
  level._effect["_encstr_AF2110A4732963A30710BA42C02F9DFFA06D"] = loadfx("_encstr_8293303B69608F0A2CE1F73799F8D23128B0F20343D0896228450B9BDF7D3A7EA83EAF0A98D05F6AD47F0BA7AF2516BEA862");
}

light_tank_initspawns() {
  var_0 = light_tank_getleveldata();
  var_0.dropspawns = scripts\engine\utility::getStructArray("_encstr_A1290F986A27D18BDB7120AA77A373974A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BDD01133A5D8E8AC9C4493B71C9A380BBB37CD"))
    var_0.dropspawns = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BDD01133A5D8E8AC9C4493B71C9A380BBB37CD")]](var_0.dropspawns);
}

light_tank_initvo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4EE1413732C1AEC6903DEE518910CA2FC87B3CFC3C1"] = "_encstr_8FDB1C308072AC7CE7BD780D7A085BA97B7340BBD517F39F95E848F97FB0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD0D14A59080D0F3AF41272347283A15F8DBDA6B49B0"] = "_encstr_996119BB40E17853A7257EB582FF7B3DE840FF0388DBBCFB1BB603";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B69E116CD3381CDBA09B0AC24098D7D5F88D01"] = "_encstr_BAAE1673CBD094E45EC5F638F0014723013BF52BE3E191FF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAAE1673CBD094E45EC5F638F0014723013BF52BE3E191FF"] = "_encstr_95AE161B96CE343AF5A32C376DF58DA116A3A32BC9BE0664";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95AE161B96CE343AF5A32C376DF58DA116A3A32BC9BE0664"] = "_encstr_A2AE168D4BCE43D1EB4758CD6D7DD843163A1DCA4E7D03CC";
}

light_tank_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(wheelson_thermite_damage_over_time(var_0))
    var_0.modelname = "_encstr_855A19D995A170EB5BA5C6EB36B9C8AF36EDDCC6589C7D562C6E3A";
  else
    var_0.modelname = "_encstr_8DD019DC8D4BEA4FAD6A60F1D285E1DECF3FE6DEE15B4E5797D358";

  var_0.targetname = "_encstr_AF390B295782C3585F1B21D8C4";
  var_0.vehicletype = "_encstr_A2030FD0327CD721BB194DB1F57F4E6BA2";
  var_0.cannotbesuspended = 1;
  var_0.startsuspended = 0;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_2.unset_relic_explodedmg = var_0.spawntype == "_encstr_85CE0B1771B40C71E166070EC2";
  var_3 = light_tank_createdriverturret(var_2, var_0);
  var_3.missilesleft = 2;
  var_3.lastmissilefired = 0;
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_3, getcompleteweaponname("_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8"), 1);
  var_3 = light_tank_creategunnerturret(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_3, getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83"));
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_AF390B295782C3585F1B21D8C4", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_827E0D809A9733A0E3992D3FBF8D48");
  var_2 light_tank_updateheadicon();
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414C(var_2, 1);
  var_4.lb_mg_impulse_dmg_threshold_low = "_encstr_8BBA05185F8B99";

  if(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(var_2))
    var_2 scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_2, 0);

  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  var_2 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowsentient(0);
  var_2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, ::light_tank_flippedendcallback, "_encstr_A16A0CCC632D07E0AC19AF2B3732");
  var_2 thread light_tank_monitordriverturretfire();
  var_2 thread wheelson_fire_thermite();
  var_2 thread wheelson_molotov_damage_over_time();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

light_tank_createdriverturret(var_0, var_1) {
  var_2 = light_tank_getleveldata();
  var_3 = undefined;

  if(var_0.unset_relic_explodedmg)
    var_3 = "_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0";
  else
    var_3 = "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8";

  var_4 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), var_3, 0);
  var_4 linkTo(var_0, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));

  if(wheelson_thermite_damage_over_time(var_1))
    var_4 setModel("_encstr_845520EBFFE2135961A1B45183803429A9C8EEAAD39327F979620941B3539296AD63");
  else
    var_4 setModel("_encstr_8B5B209D5934C1EBDA4BD87D1BDC8CEB8DDEB9B158C9AF77B29B47FA8EAEC94E598E");

  var_4 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_4 setsentryowner(undefined);
  var_4 makeunusable();
  var_4 setdefaultdroppitch(0);
  var_4 setturretmodechangewait(1);
  var_4.angles = var_0.angles;
  var_4.vehicle = var_0;
  return var_4;
}

light_tank_creategunnerturret(var_0, var_1) {
  var_2 = light_tank_getleveldata();
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_4 = undefined;

  if(var_0.unset_relic_explodedmg)
    var_4 = "_encstr_8A9B18CDA79A41114F78E7C8AB7719A3EB6702DFB1F277A75BF3";
  else
    var_4 = "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83";

  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_3 gettagorigin("_encstr_845A13A37342A0857B3F8B8DFFB2DFD8ED41E878DB"), var_4, 0);
  var_5 linkTo(var_3, "_encstr_845A13A37342A0857B3F8B8DFFB2DFD8ED41E878DB", (0, 0, 0), (0, 0, 0));

  if(wheelson_thermite_damage_over_time(var_1))
    var_5 setModel("_encstr_AA97243B561AC1FA6BA5C6F5D8CD23BE1BDB37361639FA560BE68EEB3AD52739591D7DECAB9B");
  else
    var_5 setModel("_encstr_81F024BB632CB0D75D9419E7C155A2B9A3528360C812C793D9505B7F4BF88BC2C73D58D90B40");

  var_5 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  return var_5;
}

light_tank_activate() {
  if(istrue(self.isactivated)) {
    return;
  }
  self.isactivated = 1;
  var_0 = light_tank_getleveldata();
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  var_1 = undefined;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled())
    var_1 = 0;
  else if(isDefined(self.spawndata.showheadicon))
    var_1 = self.spawndata.showheadicon;
  else
    var_1 = var_0.showheadicon;

  if(var_1) {
    light_tank_createheadicon();
    light_tank_updateheadicon();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowsentient(1);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_85AD0950914BBF136ACB7F"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_85AD0950914BBF136ACB7F")]](self);
}

light_tank_explode(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_0)) {
    var_4 = var_0.inflictor;
    var_6 = var_0.meansofdeath;
    var_7 = "_encstr_8CC008133958C81BACCB";
    var_3 = var_0.attacker;
    var_5 = var_0.objweapon;
    var_8 = undefined;
    var_9 = var_0.damage;
    var_10 = "_encstr_ACB80B32E13893EAC81A9F1209" + var_7;
    var_11 = var_7 + "_encstr_8D5A0BF58C59B98E39F65E2B32";
    var_12 = "_encstr_A76B138D2C1B36EDEA477D19959B1D4E7B97B223F5" + var_7;
    var_13 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
      var_14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](var_7, var_3, var_5, var_8, var_9, var_10, var_11, var_12, var_13);
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_827E0D809A9733A0E3992D3FBF8D48";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(isDefined(self.owner) && isDefined(self.streakinfo)) {
    self.streakinfo.onspray = 1;

    if(!istrue(self._id_12AA4))
      self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread light_tank_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_15 = self gettagorigin("_encstr_9AD01136187923E791B06F67D06B9509DD203B");

    if(!isDefined(var_3))
      var_3 = self;

    self radiusdamage(var_15, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_827E0D809A9733A0E3992D3FBF8D48");
    var_16 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_17 = undefined;

    if(wheelson_thermite_damage_over_time(self.spawndata))
      var_17 = "_encstr_8AA41770A467403DF9C3DBFD87C18D88287D9809CFF7B0F9A3";
    else
      var_17 = "_encstr_A5BC13D50B77E88BE1DCC938070F4DC8A3432FA822";

    playFX(scripts\engine\utility::getfx(var_17), var_16, anglesToForward(self.angles));
    playsoundatpos(var_16, "_encstr_845C17E37758C9061BC78189CFF3C050F08A285EDFBD70C533");
    earthquake(0.4, 0.7, var_16, 800);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_16);
    physicsexplosionsphere(var_16, 500, 200, 1);
  }
}

wheelson_thermite_damage_over_time(var_0) {
  return istrue(var_0.usealtmodel);
}

light_tank_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(istrue(self.infreefall)) {
    self physics_unregisterforcollisioncallback();
    self.infreefall = undefined;
  }

  thread light_tank_endcapture(self);
  light_tank_destroyheadicon();

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }

  if(isDefined(self.streakinfo) && isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();

  if(isDefined(self.dropspawn)) {
    self.dropspawn.isdisabled = undefined;
    self.dropspawn = undefined;
  }

  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

light_tank_land(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("_encstr_AF2110A4732963A30710BA42C02F9DFFA06D"), var_0, anglesToForward(var_1));
  playsoundatpos(var_0, "_encstr_85D819126B9BF716935BC4C47B701143E6EDFBF95116C74F084BE1");
  earthquake(0.3, 0.7, var_0, 800);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0);
  physicsexplosionsphere(var_0, 800, 400, 0.5);
}

light_tank_initializespawndata(var_0) {
  if(!isDefined(var_0))
    var_0 = spawnStruct();

  if(!isDefined(var_0.spawnmethod))
    var_0.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";

  if(!isDefined(var_0.cancapture))
    var_0.cancapture = 0;

  if(!isDefined(var_0.cancaptureimmediately))
    var_0.cancaptureimmediately = 0;

  if(!isDefined(var_0.activateimmediately))
    var_0.activateimmediately = 1;

  if(!isDefined(var_0.faceawayfromowner))
    var_0.faceawayfromowner = 0;

  return var_0;
}

light_tank_copyspawndata(var_0, var_1) {
  var_1.spawnmethod = var_0.spawnmethod;
  var_1.cancapture = var_0.cancapture;
  var_1.cancaptureimmediately = var_0.cancaptureimmediately;
  var_1.activateimmediately = var_0.activateimmediately;
  var_1.faceawayfromowner = var_0.faceawayfromowner;
  var_1.cantimeout = var_0.cantimeout;
  var_1.showheadicon = var_0.showheadicon;
}

light_tank_spawn(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_0 = light_tank_initializespawndata(var_0);
  var_8 = issubstr(var_0.spawnmethod, "_encstr_81B608D9B5CD2379D108");
  var_9 = issubstr(var_0.spawnmethod, "_encstr_B84309FF146B810B2FFBC9");

  if(var_8) {
    var_3 = var_0.origin;
    var_4 = var_0.angles;

    if(isDefined(var_0.owner) && istrue(var_0.faceawayfromowner)) {
      var_10 = var_3 - var_0.owner.origin;

      if(length2dsquared(var_10) > 0)
        var_4 = vectortoangles(var_3 - var_0.owner.origin);
      else
        var_4 = var_0.owner getplayerangles(1);
    }
  } else {
    if(isDefined(var_0.owner) && var_0.spawnmethod == "_encstr_AD3D14B05A9323E4EDE0F56639BDB67D0E36C2E5AC4E")
      var_3 = light_tank_getdesiredspawnpositionfromplayer(var_0.owner);
    else
      var_3 = var_0.origin;

    var_7 = light_tank_getdropspawn(var_3, var_0);

    if(isDefined(var_7)) {
      if(!isDefined(var_7.angles))
        var_7.angles = (0, 0, 0);

      var_3 = var_7.origin;
      var_5 = var_7.origin;
      var_6 = anglestoup(var_7.angles);

      if(isDefined(var_0.owner) && istrue(var_0.faceawayfromowner)) {
        var_10 = var_3 - var_0.owner.origin;

        if(length2dsquared(var_10) > 0)
          var_4 = vectortoangles(var_3 - var_0.owner.origin);
        else
          var_4 = var_0.owner getplayerangles(1);
      }

      var_4 = light_tank_getdropspawnangles(var_4, var_7);

      if(var_9)
        var_3 = var_3 + (0, 0, 150);
      else
        var_3 = var_3 + (0, 0, 60);
    } else {
      if(isDefined(var_1))
        var_1.fail = "_encstr_8D2A106E18203EE3690FBBEF1F3D1077DA4D";

      return undefined;
    }
  }

  if(!isDefined(var_4))
    var_4 = (0, randomint(360), 0);
  else
    var_4 = var_4 * (0, 1, 0);

  var_11 = undefined;

  if(var_9) {
    var_11 = light_tank_airdrop(var_3, var_4, var_5, var_6, var_0, var_1);

    if(isDefined(var_11) && isDefined(var_7)) {
      var_11.dropspawn = var_7;
      var_7.isdisabled = 1;
    }
  } else
    var_11 = light_tank_place(var_3, var_4, var_0, var_1);

  if(isDefined(var_11) && isDefined(var_0.owner) && isDefined(var_2)) {
    var_11.streakinfo = var_2;
    var_12 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](var_0.owner, var_2.streakname);
      var_12 = 2.0;
    }

    var_0.owner thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B1250C0DCB2F56055ADAF0B8B2B0", 1, var_12);
  }

  return var_11;
}

light_tank_place(var_0, var_1, var_2, var_3) {
  var_4 = var_2.origin;
  var_5 = var_2.angles;
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_6 = light_tank_create(var_2, var_3);
  var_2.origin = var_4;
  var_2.angles = var_5;

  if(!isDefined(var_6))
    return undefined;

  if(var_2.cancapture) {
    if(var_2.cancaptureimmediately)
      thread light_tank_startcapture(var_6, var_2.owner, var_2.team);
  } else if(var_2.activateimmediately)
    var_6 thread light_tank_activate();

  return var_6;
}

light_tank_getdesiredspawnpositionfromplayer(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = max(-5, min(angleclamp180(var_2[0]), 45));
  var_2 = (angleclamp(var_3), var_2[1], var_2[2]);
  var_4 = anglesToForward(var_2);
  var_5 = anglesToForward(var_2 * (0, 1, 0));
  var_6 = var_1;
  var_7 = var_1 + var_4 * 1800;
  var_8 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07"]);
  var_9 = physics_raycast(var_6, var_7, var_8, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_9) && var_9.size > 0)
    var_7 = var_9[0]["_encstr_BD260953AA97E3F014279D"];

  var_10 = vectordot(var_7 - var_6, var_5);

  if(var_10 < 400)
    var_10 = 400;

  var_7 = var_6 + var_5 * var_10;
  return var_7;
}

light_tank_airdrop(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4.origin;
  var_7 = var_4.angles;
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_8 = light_tank_create(var_4, var_5);
  var_4.origin = var_6;
  var_4.angles = var_7;

  if(!isDefined(var_8))
    return undefined;

  var_8.animname = "_encstr_AF390B295782C3585F1B21D8C4";
  var_8 vehphys_forcekeyframedmotion();
  var_8 hide();
  var_9 = scripts\cp_mp\vehicles\vehicle::_id_14193(var_8);

  foreach(var_11 in var_9)
  var_11 hide();

  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_13.angles = var_1;
  var_13 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_14 = undefined;

  if(isDefined(var_2)) {
    if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_14 = light_tank_createobjective(var_2, var_3, var_4);
      var_8.objent = var_14;
    }
  }

  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_15.angles = var_1;
  var_15.animname = "_encstr_B8650ACAF940B1FAF32B6B27";
  var_15 setModel("_encstr_A2811E4BB898A0697B13B561891592BFA168B7AF2BD00F63BBB6FE66E31B4B4D");
  var_15 scripts\common\anim::setanimtree();
  var_15 hide();
  var_16 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_16.angles = var_1;
  var_16.animname = "_encstr_A937066AFF52FA4F";
  var_16 setModel("_encstr_954624A0420C69F69741199821EF1BDF364AC8908BA503493E233F9033BF666F9EC3906812FA");
  var_16 scripts\common\anim::setanimtree();
  var_16 hide();
  var_13.vehicle = var_8;
  var_13.parachute = var_15;
  var_13.carrier = var_16;
  var_13.objent = var_14;
  var_17 = gettime() + level.frameduration;
  var_13.endtime = gettime();
  var_13.vehicleendtime = var_17 + getanimlength(level.scr_anim["_encstr_AF390B295782C3585F1B21D8C4"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"]) * 1000;

  if(var_13.vehicleendtime > var_13.endtime)
    var_13.endtime = var_13.vehicleendtime;

  var_13.parachuteendtime = var_17 + getanimlength(level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"]) * 1000;

  if(var_13.parachuteendtime > var_13.endtime)
    var_13.endtime = var_13.parachuteendtime;

  var_13.carrierendtime = var_17 + getanimlength(level.scr_anim["_encstr_A937066AFF52FA4F"]["_encstr_8864108A4B875C93D60D5146AAFE9B622F60"]) * 1000;

  if(var_13.carrierendtime > var_13.endtime)
    var_13.endtime = var_13.carrierendtime;

  var_13 thread light_tank_airdropinternal();
  return var_8;
}

light_tank_airdropinternal() {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, "_encstr_8864108A4B875C93D60D5146AAFE9B622F60");
  scripts\common\anim::anim_first_frame_solo(self.parachute, "_encstr_8864108A4B875C93D60D5146AAFE9B622F60");
  scripts\common\anim::anim_first_frame_solo(self.carrier, "_encstr_8864108A4B875C93D60D5146AAFE9B622F60");
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    var_0 = scripts\cp_mp\vehicles\vehicle::_id_14193(self.vehicle);

    foreach(var_2 in var_0)
    var_2 show();

    thread scripts\common\anim::anim_single_solo(self.vehicle, "_encstr_8864108A4B875C93D60D5146AAFE9B622F60");
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, "_encstr_8864108A4B875C93D60D5146AAFE9B622F60");
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("_encstr_BD6616AB57C2CEEDB22218201A08DFE1B3E7AF08DB0EBB91");
    self.carrier setscriptablepartstate("_encstr_BE2908C47B90B4630EFB", "_encstr_AB0703DBB9", 0);
    self.carrier setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, "_encstr_8864108A4B875C93D60D5146AAFE9B622F60");
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime)
      thread light_tank_detachvehiclefromairdropsequence(self.vehicle);

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime)
      self.parachute delete();

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime)
      self.carrier delete();

    waitframe();
  }

  thread light_tank_detachvehiclefromairdropsequence(self.vehicle);

  if(isDefined(self.parachute))
    self.parachute delete();

  if(isDefined(self.carrier))
    self.carrier delete();

  self delete();
}

light_tank_detachvehiclefromairdropsequence(var_0) {
  self.vehicle = undefined;

  if(isDefined(var_0)) {
    var_0 vehphys_setdefaultmotion();
    var_0 thread light_tank_startfreefall();
  }

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }
}

light_tank_startfreefall() {
  self endon("_encstr_AD75063D571AE108");
  self.infreefall = 1;
  self physics_registerforcollisioncallback();
  waitframe();
  var_0 = gettime() + 5000;
  var_1 = undefined;
  var_2 = undefined;

  while(gettime() < var_0) {
    if(!isDefined(var_1))
      var_1 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    else {
      var_3 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var_4 = (var_3 - var_1) / level.framedurationseconds;

      if(isDefined(var_2)) {
        if(var_2 - var_4 >= 300) {
          light_tank_land(self.origin, self.angles);
          break;
        }
      }

      var_1 = var_3;
      var_2 = var_4;
    }

    waitframe();
  }

  self.infreefall = undefined;
  self physics_unregisterforcollisioncallback();

  while(lengthsquared(self vehicle_getvelocity()) > 400)
    waitframe();

  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(self.dropspawn)) {
    self.dropspawn.isdisabled = undefined;
    self.dropspawn = undefined;
  }

  if(var_5.cancapture) {
    if(var_5.cancaptureimmediately)
      thread light_tank_startcapture(self, self.owner, self.team);
  } else if(var_5.activateimmediately)
    thread light_tank_activate();
}

light_tank_createobjective(var_0, var_1, var_2) {
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057")]](99);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_9B1217E486FF522103C88BAB2018E57943172A1C650D097D2B");
  var_5 = (1, 0, 0);
  var_6 = vectorcross(var_5, var_1);
  var_5 = vectorcross(var_1, var_6);
  var_7 = axistoangles(var_5, var_6, var_1);
  var_4.angles = var_7;

  if(var_3 != -1) {
    var_4.objid = var_3;
    objective_onentity(var_3, var_4);
    objective_icon(var_3, "_encstr_8CD2138A1BC78D6FE3B7798858C863D37F10B272D8");
    objective_setzoffset(var_3, 55);
    objective_setplayintro(var_3, 0);
    objective_setplayoutro(var_3, 0);
    objective_setbackground(var_3, 1);
    objective_showtoplayersinmask(var_3);
    objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");

    if(level.teambased) {
      var_8 = var_2.team;

      if(!isDefined(var_8) || var_8 == "_encstr_A7A408B9CA5D1D4E2C63") {
        if(isDefined(var_2.owner))
          var_8 = var_2.owner.team;
      }

      if(!isDefined(var_8) || var_8 == "_encstr_A7A408B9CA5D1D4E2C63") {
        objective_addalltomask(var_3);
        var_4 setscriptablepartstate("_encstr_84910EB2688584CF1BE0382C8741B70F", "_encstr_AADD0BCFE2487B8552B0E05861", 0);
      } else {
        objective_addteamtomask(var_3, var_8);
        light_tank_setteamotherent(var_4, var_8);
        var_4 setscriptablepartstate("_encstr_84910EB2688584CF1BE0382C8741B70F", "_encstr_AFCE07B7DC51CA16B5", 0);
      }
    } else if(!isDefined(var_2.owner)) {
      objective_addalltomask(var_3);
      var_4 setscriptablepartstate("_encstr_84910EB2688584CF1BE0382C8741B70F", "_encstr_AADD0BCFE2487B8552B0E05861", 0);
    } else {
      objective_setownerclient(var_3, var_2.owner);
      objective_addclienttomask(var_3, var_2.owner);
      var_4 setotherent(var_2.owner);
      var_4 setscriptablepartstate("_encstr_84910EB2688584CF1BE0382C8741B70F", "_encstr_AB0703DBB9", 0);
    }
  }

  return var_4;
}

light_tank_destroyobjective(var_0) {
  if(isDefined(var_0.objid))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0.objid);

  var_0 delete();
}

light_tank_setteamotherent(var_0, var_1) {
  var_0 notify("_encstr_A6AA1B05BF4FFB55E163DA53CAC7A238BB1917B7FD108380E255452E98");
  var_0 endon("_encstr_A6AA1B05BF4FFB55E163DA53CAC7A238BB1917B7FD108380E255452E98");
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(var_4.team == var_1) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_0 setotherent(var_2);
    childthread light_tank_monitorotherentjoined(var_0, var_2);
    childthread light_tank_monitorotherentdisconnect(var_0, var_2);
  }
}

light_tank_monitorotherentjoined(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = var_1.team;
  var_1 scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  thread light_tank_setteamotherent(var_0, var_2);
}

light_tank_monitorotherentdisconnect(var_0, var_1) {
  var_2 = var_1.team;
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread light_tank_setteamotherent(var_0, var_2);
}

light_tank_startcapture(var_0, var_1, var_2) {
  var_3 = light_tank_getleveldata();

  if(var_3.cantakedamageduringcapture)
    var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);

  var_4 = undefined;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled())
    var_4 = 0;
  else if(isDefined(var_0.spawndata.showheadicon))
    var_4 = var_0.spawndata.showheadicon;
  else
    var_4 = var_3.showheadicon;

  if(var_4) {
    var_0 light_tank_createheadicon(1);
    var_0 light_tank_updateheadicon(var_1, var_2);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_AF850D78A3F7FD1197C95B03F0F2B9"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_AF850D78A3F7FD1197C95B03F0F2B9")]](var_0, var_1, var_2);
}

light_tank_endcapture(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_92E80B695DACD17FD30B0B0D67"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_92E80B695DACD17FD30B0B0D67")]](var_0);
}

light_tank_capture(var_0, var_1) {
  thread light_tank_endcapture(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, var_1.team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setowner(var_0, var_1);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_0, "_encstr_9AE307B956E345D0AB", var_1);
  var_0 thread light_tank_activate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_95EB0866891B23FB85B3"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_95EB0866891B23FB85B3")]](var_1, var_0);
}

wheelson_tank_death(var_0) {
  if(scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return;
  }
  light_tank_updatetimeout();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("_encstr_9AE307B956E345D0AB");
}

light_tank_monitordriverturretfire() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.shotsleft = 8;
  light_tank_updatedriverturretammoui();
  light_tank_updatemissileammoui();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_143AD("_encstr_BDBA0C4757C927CA477DCC5A4EAC", "_encstr_88BE0EEC1B3B5D9D6886F837997067AC");

    if(var_1 == "_encstr_88BE0EEC1B3B5D9D6886F837997067AC") {
      var_0.shotsleft = 0;
      light_tank_updatedriverturretammoui();
      light_tank_driverturretreload();
      continue;
    }

    light_tank_turretdustkickup();
    light_tank_adjustdriverturretammo(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

    if(var_0.shotsleft <= 0)
      light_tank_driverturretreload();
  }
}

wheelson_fire_thermite() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_BDBA0C4757C927CA477DCC5A4EAC", var_1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");
    var_1 thread whistlestarttimer_internal(var_2);

    if(isDefined(self.streakinfo)) {
      var_1.streakinfo = self.streakinfo;
      self.streakinfo.shots_fired++;
    }
  }
}

whistlestarttimer_internal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_860808CB78E2984063BA", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_1, 175, 175, var_0.team, 1, var_0, 1);
}

light_tank_monitordriverturretreload(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");

  if(isDefined(var_0)) {
    var_0 endon("_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115");
    var_0 endon("_encstr_939D1243D0687BBE49BDDFE381D6D34F7508A01B");
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

    while(var_0 isbnetkr15player())
      waitframe();

    var_2 = getdvarint("_encstr_923D0BEB217B114153E83CC451", 250) / 1000;

    for(;;) {
      var_3 = 0.0;
      var_4 = var_0 ismlgfreecamenabled();

      while(var_0 isbnetkr15player()) {
        if(!var_0 usinggamepad() && var_1.shotsleft < 8) {
          var_1 notify("_encstr_88BE0EEC1B3B5D9D6886F837997067AC");
          break;
        } else {
          if(var_1.shotsleft < 8 && var_4 > 0 && var_3 >= var_2)
            var_1 notify("_encstr_88BE0EEC1B3B5D9D6886F837997067AC");

          var_3 = var_3 + level.framedurationseconds;
          waitframe();
        }
      }

      if(var_0 usinggamepad() && var_1.shotsleft < 8 && (var_4 == 0 && var_3 > 0.0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2))
        var_1 notify("_encstr_88BE0EEC1B3B5D9D6886F837997067AC");

      waitframe();
    }
  }
}

light_tank_adjustdriverturretammo(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_1.shotsleft = var_1.shotsleft + var_0;
  var_1.shotsleft = int(clamp(var_1.shotsleft, 0, 8));
  light_tank_updatedriverturretammoui();
}

light_tank_updatedriverturretammoui() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_A7AF07D1EF1B06683C", var_1.shotsleft, var_0);
  }
}

light_tank_driverturretreload() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_0 turretfiredisable();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

  if(isDefined(var_1))
    thread scripts\mp\utility\sound::playplayerandnpcsounds(var_1, "_encstr_8F8B188F054F9B19CAC533C45A0F19C773CAAABF217CFE3BECA8", "_encstr_B48C184B3998E079B665FFE3B1EDC317A88105D5D1C88722975F");

  wait 2.7;
  light_tank_adjustdriverturretammo(8);
  wait 0.15;
  var_0 turretfireenable();
}

whistlestarttimer() {
  self notify("_encstr_A6D41BBBB01D8D0DFAB52D9BCD5AC656EBA53783AEE8F5D81AC27376CA");
  self endon("_encstr_A6D41BBBB01D8D0DFAB52D9BCD5AC656EBA53783AEE8F5D81AC27376CA");

  for(;;) {
    var_0 = weight_spawners_closest_to_forward();
    self notifyonplayercommand("_encstr_AC541342C84F64AB9E55090EE2A6F76CCF809A3AC0", var_0);
    var_1 = scripts\engine\utility::_id_143B4("_encstr_AA63132DE6C1ABA37D1DF2C159D7C6430BCD3BB223", "_encstr_82AC170570C02BC279833F9BF3105A7C48383F0169C0C4DA45");
    self notifyonplayercommandremove("_encstr_AC541342C84F64AB9E55090EE2A6F76CCF809A3AC0", var_0);

    if(!isDefined(var_1) || var_1 == "_encstr_82AC170570C02BC279833F9BF3105A7C48383F0169C0C4DA45") {
      break;
    }
  }
}

wheelson_remote_tank_think() {
  self notify("_encstr_82AC170570C02BC279833F9BF3105A7C48383F0169C0C4DA45");
}

weight_spawners_closest_to_forward() {
  return "_encstr_9B0D065699E485D9";
}

light_tank_monitordrivermissilefire(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_96191739547AD98B5F2BF8984F874125223B25BEA132A1105C");

  for(;;) {
    var_0 waittill("_encstr_AC541342C84F64AB9E55090EE2A6F76CCF809A3AC0");
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");

    if(gettime() - var_1.lastmissilefired >= 1330.0) {
      if(var_1.missilesleft > 0) {
        var_1.lastmissilefired = gettime();
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D2(var_0);
        light_tank_firemissile(var_0, var_0.stingertarget);
        light_tank_adjustmissileammo(-1);
        continue;
      }
    }
  }
}

light_tank_firemissile(var_0, var_1) {
  wait 0.33;
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_3 = var_2 gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_4 = var_2 gettagangles("_encstr_A14F0AE336178944BA076F41");
  var_5 = var_3 + anglesToForward(var_4);
  var_0 childthread light_tank_playmissilefireplayerfx();
  var_2 setscriptablepartstate("_encstr_973E0D7CB0EB37A41F687A22F05DD0", "_encstr_930B07BB1B6B3854FF", 0);
  var_6 = undefined;

  if(istrue(self.unset_relic_explodedmg))
    var_6 = "_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20";
  else
    var_6 = "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C";

  if(isDefined(self.streakinfo))
    self.streakinfo.shots_fired++;

  var_7 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var_6), var_3, var_5, var_0);
  var_7.vehicle = self;
  var_7.streakinfo = self.streakinfo;

  if(isDefined(var_1)) {
    var_7 missile_settargetEnt(var_1);
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var_1, var_7);
  }
}

light_tank_adjustmissileammo(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_1.missilesleft = var_1.missilesleft + var_0;
  var_1.missilesleft = int(clamp(var_1.missilesleft, 0, 2));
  light_tank_updatemissileammoui();
}

light_tank_updatemissileammoui() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_86C808FF9BFE73295899", var_1.missilesleft, var_0);
  }
}

light_tank_playmissilefireplayerfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setblurforplayer(0.333, 0.1);
  wait 0.15;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_heavydamagefeedbackforplayer();
  wait 0.35;
  light_tank_endmissilefireplayerfx();
}

light_tank_endmissilefireplayerfx(var_0) {
  if(!istrue(var_0))
    self setblurforplayer(0.0, 0.1);
  else
    self setblurforplayer(0.0, 0.0);
}

wheelson_molotov_damage_over_time() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");

  for(;;) {
    var_0 waittill("_encstr_BDBA0C4757C927CA477DCC5A4EAC");

    if(isDefined(self.streakinfo))
      self.streakinfo.shots_fired++;
  }
}

light_tank_updateautodestructui(var_0) {
  var_1 = light_tank_getleveldata();

  if(var_1.canautodestruct) {
    if(istrue(self.autodestructactivated))
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_B8310C70ED636AC7A8A7CC6A8F88", var_0, "_encstr_AF390B295782C3585F1B21D8C4");
    else
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_B8310C70ED636AC7A8A7CC6A8F88", var_0, "_encstr_AF390B295782C3585F1B21D8C4");
  } else
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_B8310C70ED636AC7A8A7CC6A8F88", var_0, "_encstr_AF390B295782C3585F1B21D8C4");
}

light_tank_updatetimeoutui(var_0, var_1) {
  var_2 = light_tank_getleveldata();

  if(light_tank_cantimeout()) {
    if(!isDefined(var_1)) {
      var_1 = (var_2.timeoutduration - self.timeelapsed) / var_2.timeoutduration;
      var_1 = clamp(var_1, 0, 1);
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_settimepercent(var_1, var_0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showtime(var_0);
  } else {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_cleartimepercent(var_0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidetime(var_0);
  }
}

light_tank_updatetimeout() {
  if(light_tank_cantimeout()) {
    if(!isDefined(self.timeelapsed))
      self.timeelapsed = 0;

    if(istrue(self.isactivated)) {
      self.timeelapsed = self.timeelapsed + level.framedurationseconds;
      var_0 = light_tank_getleveldata();
      var_1 = (var_0.timeoutduration - self.timeelapsed) / var_0.timeoutduration;
      var_1 = int(ceil(clamp(var_1, 0, 1) * 100));

      if(self.timeelapsed >= var_0.timeoutduration) {
        thread light_tank_timeout();
        return;
      }

      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(var_4 in var_2)
      light_tank_updatetimeoutui(var_4, var_1);

      return;
    } else {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(var_4 in var_2)
      light_tank_updatetimeoutui(var_4, 1);
    }
  } else
    self.timeelapsed = undefined;
}

light_tank_timeout() {
  if(light_tank_canautodestruct()) {
    thread light_tank_autodestruct();
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(var_2 in var_0)
    light_tank_updatetimeoutui(var_2, undefined);
  } else
    thread light_tank_explode(undefined, 0, 1);
}

light_tank_enterstart(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_8D48079DD59BE65627")
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83", var_4, 1);
}

light_tank_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread light_tank_enterendinternal(var_0, var_1, var_2, var_3, var_4);
  else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "_encstr_8D48079DD59BE65627") {
      wheelson_remote_tank_follow_path(var_3);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83", var_4, 1);
    }
  }
}

light_tank_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
    var_5.owner = var_3;
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 remotecontrolturret(var_5);
    var_3 thread whistlestarttimer();
    var_0 thread light_tank_monitordrivermissilefire(var_3);
    var_3 scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  } else if(var_1 == "_encstr_8D48079DD59BE65627") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
    var_5.owner = var_3;
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_5);
    week(var_3);
  }

  if(!isDefined(var_2))
    var_0 light_tank_updateheadiconforplayer(var_3);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
  light_tank_updateplayeromnvarsonenter(var_0, var_2, var_1, var_3);

  if(var_1 == "_encstr_9AE307B956E345D0AB")
    var_0 thread light_tank_monitordriverturretreload(var_3);
}

light_tank_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread light_tank_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

light_tank_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 notify("_encstr_96191739547AD98B5F2BF8984F874125223B25BEA132A1105C");
    wheelson_remote_tank_think();
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
    var_5.owner = undefined;
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      var_5 setturretdismountorg(var_3.origin);
      var_3 remotecontrolturretoff(var_5);
      var_3 controlsunlink();

      if(!istrue(var_4.playerdeath))
        var_3 light_tank_endmissilefireplayerfx(1);

      var_3 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    }

    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
  } else if(var_1 == "_encstr_8D48079DD59BE65627") {
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);

      if(!istrue(var_4.playerdeath))
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83", var_4, 1);
    }

    var_5.owner = undefined;
    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
    wheelson_remote_tank_follow_path(var_3);
  }

  if(!istrue(var_4.playerdisconnect)) {
    if(!isDefined(var_2))
      var_0 light_tank_updateheadiconforplayer(var_3);

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

light_tank_reenter(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB")
    var_0 thread light_tank_monitordrivermissilefire(var_3);

  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627")
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83", var_4, 1);
}

week(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_A1AD15A109FF93602879025F0B0743504139CB7F9B438B", 0.4, 0, ::wheels_fx);
}

wheelson_remote_tank_follow_path(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = undefined;
  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_A1AD15A109FF93602879025F0B0743504139CB7F9B438B", 0);
}

wheels_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" && var_4 != "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    return 1;

  if(!isDefined(var_5))
    return 1;

  switch (var_5.basename) {
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0":
    case "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
    case "_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      return 0;
    default:
      return 1;
  }
}

whistlestarttime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self._id_12AA4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

light_tank_premoddamagecallback(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, var_0))
    return 0;

  var_1 = self.origin - var_0.point;
  var_2 = anglestoup(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.point + var_2 * var_3;
  var_5 = vectorNormalize(var_4 - self.origin);
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);

  if(vectordot(var_5, var_6) < -0.83)
    var_0.use_aitype = canweapondealcriticaldamage(var_0);

  return 1;
}

canweapondealcriticaldamage(var_0) {
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.weapon_name) && var_0.inflictor.weapon_name == "_encstr_8A07035972")
    return isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_911B0C7DA090E9A7F799FD50DD48";

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
      case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
        return isDefined(var_0.meansofdeath) && (var_0.meansofdeath == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_0.meansofdeath == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
      case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
      case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
        return isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F";
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
        return isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_911B0C7DA090E9A7F799FD50DD48";
    }
  }

  return 0;
}

light_tank_postmoddamagecallback(var_0) {
  if(istrue(var_0.use_aitype))
    var_0.damage = int(var_0.damage * 1.6);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8CFC16C55190EE6B0DAFFAF3F1DFF72290CB5B4CC1507307"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8CFC16C55190EE6B0DAFFAF3F1DFF72290CB5B4CC1507307")]](var_0.attacker, var_0.damage);

  return 1;
}

light_tank_deathcallback(var_0) {
  thread light_tank_explode(var_0);
  return 1;
}

light_tank_autodestruct(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A16A0CCC632D07E0AC19AF2B3732");

  if(!istrue(self.autodestructactivated)) {
    self.autodestructactivated = 1;

    if(!scripts\common\utility::iscp()) {
      var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414B(self);
      self.health = int(min(self.health, var_1));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
      scripts\cp_mp\vehicles\vehicle_damage::_id_1417F();
    } else {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(var_4 in var_2)
      light_tank_updateautodestructui(var_4);

      wait 5.5;
      thread light_tank_explode(undefined, undefined, 1);
    }
  }
}

light_tank_turretdustkickup() {
  var_0 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_1 = self getlinkedchildren();

  if(!isDefined(var_1))
    var_1 = [];

  var_1[var_1.size] = self;
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_3 = var_2 gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_4 = var_3 + (-0, -0, -200);
  var_5 = physics_raycast(var_3, var_4, var_0, var_1, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(!isDefined(var_5) || !var_5.size) {
    return;
  }
  var_6 = anglesToForward(var_2 gettagangles("_encstr_A14F0AE336178944BA076F41") * (0, 1, 0));
  var_7 = var_5[0]["_encstr_820E07FAE8780B3A4C"];
  var_8 = vectorcross(var_6, var_7);
  var_7 = vectorcross(var_8, var_6);
  var_9 = axistoangles(var_6, var_8, var_7);
  playFX(scripts\engine\utility::getfx("_encstr_AACC17D8A5CE431DFA1D2C9B6D7D1B0BCDE6F6B97D91AB9B3A"), var_5[0]["_encstr_BD260953AA97E3F014279D"], anglesToForward(var_9), anglestoup(var_9));
}

light_tank_createheadicon(var_0) {
  var_1 = self.headicon;

  if(!isDefined(var_1)) {
    var_2 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
    var_1 = var_2 scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(var_1))
      return 0;

    self.headicon = var_1;
    addclienttoheadiconmask(var_1, 55);
  }

  self.headiconforcapture = istrue(var_0);
  var_3 = scripts\engine\utility::ter_op(istrue(var_0), 0, 0);
  var_4 = scripts\engine\utility::ter_op(istrue(var_0), 2250, 2250);
  var_5 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  var_6 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  setheadiconmaxdistance(var_1, var_3);
  setheadiconsnaptoedges(var_1, var_4);
  setheadiconzoffset(var_1, var_5);
  setheadicondrawthroughgeo(var_1, var_6);
}

light_tank_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

light_tank_updateheadicon(var_0, var_1) {
  if(!isDefined(self.headicon)) {
    return;
  }
  if(isDefined(var_0)) {
    if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
      self.headiconowneroverride = undefined;
    else
      self.headiconowneroverride = var_0;
  }

  if(isDefined(var_1)) {
    if(var_1 == "_encstr_8BBA05185F8B99")
      self.headiconteamoverride = undefined;
    else
      self.headiconteamoverride = var_1;
  }

  light_tank_updateheadiconowner();
  light_tank_updateheadiconteam();
  light_tank_updateheadiconimage();

  foreach(var_3 in level.players)
  light_tank_updateheadiconforplayer(var_3);
}

light_tank_updateheadiconforplayer(var_0) {
  if(!isDefined(self.headicon)) {
    return;
  }
  var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1) && var_1 == self)
    scripts\cp_mp\entityheadicons::_id_1315E(self.headicon, var_0);
  else {
    var_2 = undefined;

    if(isDefined(self.headiconowneroverride))
      var_2 = self.headiconowneroverride;
    else
      var_2 = self.owner;

    var_3 = undefined;

    if(isDefined(self.headiconteamoverride))
      var_3 = self.headiconteamoverride;
    else
      var_3 = self.team;

    var_4 = light_tank_getleveldata();

    if(level.teambased) {
      if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
        if(!isDefined(var_2)) {
          if(1)
            scripts\cp_mp\entityheadicons::_id_1315D(self.headicon, var_0);
          else
            scripts\cp_mp\entityheadicons::_id_1315E(self.headicon, var_0);

          return;
        } else
          var_3 = var_2.team;
      }

      if(isenemyteam(var_3, var_0.team)) {
        if(istrue(var_4.showheadicontoenemy))
          scripts\cp_mp\entityheadicons::_id_1315D(self.headicon, var_0);
        else
          scripts\cp_mp\entityheadicons::_id_1315E(self.headicon, var_0);
      } else
        scripts\cp_mp\entityheadicons::_id_1315D(self.headicon, var_0);
    } else {
      if(!isDefined(var_2)) {
        if(1)
          scripts\cp_mp\entityheadicons::_id_1315D(self.headicon, var_0);
        else
          scripts\cp_mp\entityheadicons::_id_1315E(self.headicon, var_0);

        return;
      }

      if(var_0 != var_2) {
        if(var_4.showheadicontoenemy) {
          scripts\cp_mp\entityheadicons::_id_1315D(self.headicon, var_0);
          return;
        }

        scripts\cp_mp\entityheadicons::_id_1315E(self.headicon, var_0);
        return;
        return;
      }

      scripts\cp_mp\entityheadicons::_id_1315D(self.headicon, var_0);
    }
  }
}

light_tank_updateheadiconforplayeronjointeam(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_AF390B295782C3585F1B21D8C4");

  foreach(var_3 in var_1)
  var_3 light_tank_updateheadiconforplayer(var_0);
}

light_tank_updateheadiconowner() {
  if(level.teambased)
    return 0;

  var_0 = undefined;

  if(isDefined(self.headiconowneroverride))
    var_0 = self.headiconowneroverride;
  else
    var_0 = self.owner;

  if(isDefined(var_0))
    createtargetmarkergroup(self.headicon, var_0);
  else
    createtargetmarkergroup(self.headicon, undefined);

  return 1;
}

light_tank_updateheadiconteam() {
  if(!level.teambased) {
    return;
  }
  var_0 = light_tank_getheadiconteam();

  if(isDefined(var_0) && var_0 != "_encstr_A7A408B9CA5D1D4E2C63")
    setheadiconowner(self.headicon, var_0);
  else
    setheadiconowner(self.headicon, undefined);
}

light_tank_updateheadiconimage() {
  var_0 = light_tank_getleveldata();
  var_1 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);

  if(var_1) {
    setheadiconenemyimage(self.headicon, level.factionfriendlyheadicon);

    if(1)
      setheadiconnaturaldistance(self.headicon, level.factionenemyheadicon);

    if(var_0.showheadicontoenemy)
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);
  } else {
    var_2 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);
    var_3 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 0, var_0.showheadicontoenemy);
    var_4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "_encstr_91AD25ABC3DA27B8F337F081DF01D089732B1EA55E425F81CA27A810CF39CEC5CB941DB8778ADB", "_encstr_91AD25ABC3DA27B8F337F081DF01D089732B1EA55E425F81CA27A810CF39CEC5CB941DB8778ADB");
    var_5 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "_encstr_A26D1C5C80ED464B67A053AF4B237A920B216B75D8E7A8BEC3BF69249BCB", "_encstr_A26D1C5C80ED464B67A053AF4B237A920B216B75D8E7A8BEC3BF69249BCB");
    var_6 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "_encstr_8EAE222AAB617107F120FED7CA58DB45B7E0137218D739538B1FFCECD5624F4F25F06A0B", "_encstr_8EAE222AAB617107F120FED7CA58DB45B7E0137218D739538B1FFCECD5624F4F25F06A0B");
    setheadiconenemyimage(self.headicon, var_4);

    if(var_2)
      setheadiconnaturaldistance(self.headicon, var_5);

    if(var_3)
      setheadiconneutralimage(self.headicon, var_6);
  }
}

light_tank_getheadiconteam() {
  var_0 = undefined;

  if(isDefined(self.headiconowneroverride))
    var_0 = self.headiconowneroverride;
  else
    var_0 = self.owner;

  var_1 = undefined;

  if(isDefined(self.headiconteamoverride))
    var_1 = self.headiconteamoverride;
  else
    var_1 = self.team;

  var_2 = var_1;

  if(!isDefined(var_2) || var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(isDefined(var_0))
      var_2 = var_0.team;
  }

  return var_2;
}

light_tank_tryuse() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8CC008133958C81BACCB", self);
  return light_tank_tryusefromstruct(var_0);
}

light_tank_tryusefromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = getcompleteweaponname("_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, var_1);

  if(!istrue(var_2))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_atinstancelimit("_encstr_AF390B295782C3585F1B21D8C4", self, self.team))
    return 0;

  var_3 = spawnStruct();
  light_tank_initializespawndata(var_3);
  var_3.spawnmethod = "_encstr_AD3D14B05A9323E4EDE0F56639BDB67D0E36C2E5AC4E";
  var_3.faceawayfromowner = 1;
  var_3.cancapture = 1;
  var_3.cancaptureimmediately = 1;
  var_3.team = self.team;
  var_3.owner = self;
  var_3.spawntype = "_encstr_85CE0B1771B40C71E166070EC2";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self) == 1)
    var_3.usealtmodel = 1;

  var_4 = spawnStruct();
  var_5 = light_tank_spawn(var_3, var_4, var_0);

  if(!isDefined(var_5)) {
    if(isDefined(var_4.fail)) {
      switch (var_4.fail) {
        case "_encstr_BD910503BF403F":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");

          break;
        case "_encstr_A91F15203FF451A18175D3E90C0BFF99509720D07BBD49":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");

          break;
        case "_encstr_8D2A106E18203EE3690FBBEF1F3D1077DA4D":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_BE361D694AC4269A8A94A2145A35E5C99EA2EB1527D355E884F56A41281A51");

          break;
        case "_encstr_BD6311300A874E70B69F3D3F8F9CC8AF17828B":
          break;
      }
    }

    return 0;
  }

  if(isDefined(var_0)) {
    var_5.streakinfo = var_0;
    var_6 = scripts\cp_mp\vehicles\vehicle::_id_14193(var_5);

    foreach(var_8 in var_6)
    var_8.streakinfo = var_0;

    var_5 thread whistlestarttime(var_0);
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]]("_encstr_8CC008133958C81BACCB", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_8B3F0D53CFC5F9BF82EE29EB62DA21", self);

  return 1;
}

light_tank_hasdropspawns() {
  var_0 = light_tank_getleveldata();

  if(isDefined(var_0))
    return var_0.dropspawns.size > 0;

  return undefined;
}

light_tank_getdropspawn(var_0, var_1) {
  var_2 = light_tank_getleveldata();

  if(var_2.dropspawns.size > 0) {
    var_3 = sortbydistance(var_2.dropspawns, var_0);
    var_4 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_870C179D561D2239B707351C2CEECD25CEDC7B4EAC98D2CD1D"))
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_870C179D561D2239B707351C2CEECD25CEDC7B4EAC98D2CD1D")]](var_4);

    foreach(var_6 in var_3) {
      if(istrue(var_6.isdisabled)) {
        continue;
      }
      var_7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(var_6.origin, "_encstr_AF390B295782C3585F1B21D8C4", undefined, var_4);

      if(var_7)
        return var_6;
    }
  }

  return undefined;
}

light_tank_getdropspawnangles(var_0, var_1) {
  var_0 = var_0 * (0, 1, 0);

  if(!isDefined(var_1.spawnflags) || var_1.spawnflags & 0) {
    var_2 = var_1.angles * (0, 1, 0);
    var_3 = vectordot(anglesToForward(var_0), anglesToForward(var_2));

    if(var_3 < 0)
      var_0 = (0, angleclamp180(var_2[1] + 180), 0);
  }

  return var_0;
}

light_tank_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0.maxinstancecount = 4;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::light_tank_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 130;
  var_0.clearancecheckheight = 1000;
  var_0.clearancecheckminradius = 130;
}

light_tank_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_843D107B1B7442B41899357C7608F86AD4BD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

light_tank_getleveldata() {
  return level.vehicle.lighttank;
}

light_tank_updateteam(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_14193(var_0);

  foreach(var_5 in var_3)
  var_5.team = var_1;

  if(isDefined(var_0.headicon)) {
    if(var_2) {
      var_0 light_tank_updateheadiconteam();
      var_0 light_tank_updateheadiconimage();

      foreach(var_8 in level.players)
      var_0 light_tank_updateheadiconforplayer(var_8);
    }
  }
}

light_tank_updateowner(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.headicon)) {
    if(var_2)
      var_0 light_tank_updateheadiconowner();

    if(var_3) {
      var_0 light_tank_updateheadiconteam();
      var_0 light_tank_updateheadiconimage();
    }

    if(var_2 || var_3) {
      foreach(var_5 in level.players)
      var_0 light_tank_updateheadiconforplayer(var_5);
    }
  }
}

light_tank_shouldautodestructfromdamage(var_0) {
  if(!light_tank_canautodestruct())
    return 0;

  var_1 = light_tank_getleveldata();

  if(var_1.autodestructdamagepercent > 0) {
    var_2 = max(self.health - var_0.damage, 0);
    return floor(var_2 / self.maxhealth * 100) <= var_1.autodestructdamagepercent;
  } else
    return 0;
}

light_tank_canautodestruct() {
  if(istrue(self.autodestructactivated))
    return 0;

  var_0 = light_tank_getleveldata();

  if(!var_0.canautodestruct)
    return 0;

  return 1;
}

light_tank_cantimeout() {
  if(!light_tank_cantimeoutinternal())
    return 0;

  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(var_0.cantimeout) && var_0.cantimeout == 0)
    return 0;

  var_1 = light_tank_getleveldata();

  if(!var_1.cantimeout)
    return 0;

  if(var_1.timeoutduration <= 0)
    return 0;

  return 1;
}

light_tank_cantimeoutinternal() {
  if(istrue(self.autodestructactivated))
    return 0;

  return 1;
}

light_tank_supported(var_0) {
  return light_tank_hasdropspawns();
}

light_tank_updateplayeromnvarsonenter(var_0, var_1, var_2, var_3) {
  if(var_2 == "_encstr_9AE307B956E345D0AB") {
    var_0 light_tank_updatedriverturretammoui();
    var_0 light_tank_updatemissileammoui();
  }

  var_0 light_tank_updatetimeoutui(var_3);
  var_0 light_tank_updateautodestructui(var_3);
}

light_tank_flippedendcallback(var_0, var_1) {
  if(var_1)
    var_0 light_tank_timeout();
}