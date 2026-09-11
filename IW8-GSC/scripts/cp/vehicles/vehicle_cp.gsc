/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_cp.gsc
***********************************************/

function vehicle_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "create", &ref_14133);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createLate", &ref_14134);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrame", &ref_14135);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrameLate", &ref_14136);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "hide", &ref_14137);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_interact", "init", &scripts\cp\vehicles\vehicle_interact_cp::vehicle_interact_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "init", &scripts\cp\vehicles\vehicle_occupancy_cp::vehicle_occupancy_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "init", &scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "init", &_branalytics_geteventtimestamp::ref_1411e);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "init", &_branalytics_headerplayer::ref_1413f);
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "init", &scripts\cp\vehicles\technical_cp::technical_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "init", &scripts\cp\vehicles\light_tank_cp::light_tank_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "init", &scripts\cp\vehicles\little_bird_cp::little_bird_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "init", &_blankfunc::x1opsnpcweaponbarrelmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "init", &scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "init", &scripts\cp\vehicles\atv_cp::atv_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "init", &scripts\cp\vehicles\large_transport_cp::large_transport_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "init", &scripts\cp\vehicles\cop_car_cp::cop_car_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "init", &scripts\cp\vehicles\pickup_truck_cp::pickup_truck_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "init", &scripts\cp\vehicles\cargo_truck_cp::cargo_truck_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_mg", "init", &__ending_origin::get_force_push_direction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "init", &scripts\cp\vehicles\hoopty_cp::hoopty_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "init", &scripts\cp\vehicles\jeep_cp::jeep_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "init", &scripts\cp\vehicles\med_transport_cp::med_transport_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty_truck", "init", &scripts\cp\vehicles\hoopty_truck_cp::hoopty_truck_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("van", "init", &scripts\cp\vehicles\van_cp::van_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "init", &scripts\cp\vehicles\apc_rus_cp::apc_rus_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "init", &_branalytics_addevent::ref_11d51);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "init", &_applysalesdiscount::bot_gametype_human_player_always_considered_attacker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_bt", "init", &scripts\cp_mp\vehicles\customization\battle_tracks::create_juggernaut_spawner);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_tracking", "vehicle_spawned", &ref_14220);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "init", &_applydvarstosettings::get_player_velo_array);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp_aa", "init", &_accessreaderscriptableused::get_most_recent_ping);
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "init", &_branalytics_addeventallowed::ref_120f4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "init", &_attachmentblocks::start_safehouse_restart);
  scripts\cp\vehicles\damage_cp::init();
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_init();
}

function spawn_script_model_at_pos(var0, var1, var2, var3, var4) {
  var5 = self gettagorigin(var1);
  var6 = self gettagangles(var1);
  var7 = getstartorigin(var5, var6, var3);
  var8 = getstartangles(var5, var6, var3);
  var9 = spawn("script_model", var7);
  var9.angles = var8;
  var9 setModel(var4);
  var9 linkTo(self);

  if(isDefined(var2)) {
    var9 scriptmodelplayanim(var2);
  }

  var9.vehicle_position = var0;
  var9.disable_gun_recall = 1;
  self.attachedguys[self.attachedguys.size] = var9;
  self.usedpositions[var0] = 1;
  self.riders[self.riders.size] = var9;

  if(var0 == 0) {
    self.driver = var9;
  }

  return var9;
}

function spawn_vehicle_accessory(var0, var1, var2, var3) {
  var4 = spawn("script_model", self.origin);
  var4 setModel(var0);
  var4 notsolid();
  var4 show();

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  var5 = "tag_origin";

  if(isDefined(var1)) {
    var5 = var1;
  }

  var6 = self gettagorigin(var5);

  if(isDefined(var6)) {
    var4 linkTo(self, var5, var2, var3);
  } else {
    var4 linkTo(self);
  }

  var4.targetname = self.targetname + "_accessory";

  if(!isDefined(self.accessories)) {
    self.accessories = [];
  }

  self.accessories[self.accessories.size] = var4;
  return var4;
}

function ref_14220(var0) {
  if(!isDefined(var0.unique_id)) {
    var0 scripts\engine\flags::assign_unique_id();
  }

  var0 thread scripts\common\vehicle_code::vehicle_ai_avoidance_logic();
}

function ref_14133(var0, var1) {
  var0.bshouldoccupantsbeignored = 0;
  var0.lastkilltime = 0;
  var0.killedplayers = [];
  var0.killedby = [];
  var0.lastkilledby = undefined;
  var0.greatestuniqueplayerkills = 0;
  var0.damagedplayers = [];
  var0.lastkilltime = 0;
  var0.lastkilldogtime = 0;
  var0.recentkillcount = 0;
  var0.recentdefendcount = 0;
  var0.kills = 0;
  var0.deaths = 0;
  var0.pers["cur_kill_streak"] = 0;
  var0.pers["cur_death_streak"] = 0;
  var0.pers["cur_kill_streak_for_nuke"] = 0;
  var0.tookweaponfrom = [];
  var0.guid = var0 getentitynumber();
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registerinstance(var0);
}

function ref_14134(var0, var1) {}

function ref_14135(var0) {
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_clearoob(var0, 1);
}

function ref_14136(var0) {}

function ref_14137(var0) {}