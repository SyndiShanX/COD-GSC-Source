/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\vehicle_cp.gsc
***********************************************/

vehicle_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8AEA073693CA16D12B", ::_id_14133);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_888E0BC69CCA85A32B318547B2", ::_id_14134);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8E761050226DB3F317C63DABD4B3FB03958A", ::_id_14135);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8F471472BFB1A1B955F655C833C49B09537A903B940D", ::_id_14136);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_BECC055CF3811A", ::_id_14137);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B6D611B3F8019447480DE7D99013071ABB701B", "_encstr_88C5055208731B", scripts\cp\vehicles\vehicle_interact_cp::vehicle_interact_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_88C5055208731B", scripts\cp\vehicles\vehicle_occupancy_cp::vehicle_occupancy_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_88C5055208731B", scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_88C5055208731B", _branalytics_geteventtimestamp::_id_1411E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C5055208731B", _branalytics_headerplayer::_id_1413F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_88C5055208731B", scripts\cp\vehicles\technical_cp::technical_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_88C5055208731B", scripts\cp\vehicles\light_tank_cp::light_tank_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_88C5055208731B", scripts\cp\vehicles\little_bird_cp::little_bird_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_88C5055208731B", _blankfunc::x1opsnpcweaponbarrelmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_88C5055208731B", scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C190467402B", "_encstr_88C5055208731B", scripts\cp\vehicles\atv_cp::atv_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_88C5055208731B", scripts\cp\vehicles\large_transport_cp::large_transport_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_88C5055208731B", scripts\cp\vehicles\cop_car_cp::cop_car_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_88C5055208731B", scripts\cp\vehicles\pickup_truck_cp::pickup_truck_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_88C5055208731B", scripts\cp\vehicles\cargo_truck_cp::cargo_truck_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_88C5055208731B", __ending_origin::get_force_push_direction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_88C5055208731B", scripts\cp\vehicles\hoopty_cp::hoopty_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_88C5055208731B", scripts\cp\vehicles\jeep_cp::jeep_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_88C5055208731B", scripts\cp\vehicles\med_transport_cp::med_transport_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_88C5055208731B", scripts\cp\vehicles\hoopty_truck_cp::hoopty_truck_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_911904464232", "_encstr_88C5055208731B", scripts\cp\vehicles\van_cp::van_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_88C5055208731B", scripts\cp\vehicles\apc_rus_cp::apc_rus_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_88C5055208731B", _branalytics_addevent::_id_11D51);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_88C5055208731B", _applysalesdiscount::bot_gametype_human_player_always_considered_attacker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_88C5055208731B", scripts\cp_mp\vehicles\customization\battle_tracks::create_juggernaut_spawner);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A19511CE05B81776718869D31843AEC7707827", "_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501", ::_id_14220);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_88C5055208731B", _applydvarstosettings::get_player_velo_array);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_88C5055208731B", _accessreaderscriptableused::get_most_recent_ping);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_88C5055208731B", _branalytics_addeventallowed::_id_120F4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_88C5055208731B", _attachmentblocks::start_safehouse_restart);
  scripts\cp\vehicles\damage_cp::init();
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_init();
}

spawn_script_model_at_pos(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_1);
  var_6 = self gettagangles(var_1);
  var_7 = getstartorigin(var_5, var_6, var_3);
  var_8 = getstartangles(var_5, var_6, var_3);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_9.angles = var_8;
  var_9 setModel(var_4);
  var_9 linkTo(self);

  if(isDefined(var_2))
    var_9 scriptmodelplayanim(var_2);

  var_9.vehicle_position = var_0;
  var_9.disable_gun_recall = 1;
  self.attachedguys[self.attachedguys.size] = var_9;
  self.usedpositions[var_0] = 1;
  self.riders[self.riders.size] = var_9;

  if(var_0 == 0)
    self.driver = var_9;

  return var_9;
}

spawn_vehicle_accessory(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_4 setModel(var_0);
  var_4 notsolid();
  var_4 show();

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_5 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(isDefined(var_1))
    var_5 = var_1;

  var_6 = self gettagorigin(var_5);

  if(isDefined(var_6))
    var_4 linkTo(self, var_5, var_2, var_3);
  else
    var_4 linkTo(self);

  var_4.targetname = self.targetname + "_encstr_92460B9F41C61BA5DF3BE8B363";

  if(!isDefined(self.accessories))
    self.accessories = [];

  self.accessories[self.accessories.size] = var_4;
  return var_4;
}

_id_14220(var_0) {
  if(!isDefined(var_0.unique_id))
    var_0 scripts\engine\flags::assign_unique_id();

  var_0 thread scripts\common\vehicle_code::vehicle_ai_avoidance_logic();
}

_id_14133(var_0, var_1) {
  var_0.bshouldoccupantsbeignored = 0;
  var_0.lastkilltime = 0;
  var_0.killedplayers = [];
  var_0.killedby = [];
  var_0.lastkilledby = undefined;
  var_0.greatestuniqueplayerkills = 0;
  var_0.damagedplayers = [];
  var_0.lastkilltime = 0;
  var_0.lastkilldogtime = 0;
  var_0.recentkillcount = 0;
  var_0.recentdefendcount = 0;
  var_0.kills = 0;
  var_0.deaths = 0;
  var_0.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
  var_0.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;
  var_0.pers["_encstr_8305198D5D93D7AD5AD8B1F5B93A9C5616D6BE33BD937DE6ABB6CA"] = 0;
  var_0.tookweaponfrom = [];
  var_0.guid = var_0 getentitynumber();
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registerinstance(var_0);
}

_id_14134(var_0, var_1) {}

_id_14135(var_0) {
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_clearoob(var_0, 1);
}

_id_14136(var_0) {}

_id_14137(var_0) {}