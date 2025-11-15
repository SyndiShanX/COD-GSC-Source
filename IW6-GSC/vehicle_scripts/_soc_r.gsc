/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_soc_r.gsc
**************************************/

main(var_0, var_1, var_2) {
  precachemodel("vehicle_seal_boat_turret");
  precacheturret("minigun_hummer");
  maps\_vehicle::build_template("soc_r", var_0, var_1, var_2);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_zodiac");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_unload_groups(::unload_groups);
}

init_local() {
  build_turrets();
}

build_turrets() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  var_0 = strtok(self.script_parameters, " ");
  var_1 = undefined;
  var_2 = 1;

  foreach(var_5, var_4 in var_0) {
    switch (var_4) {
      case "back":
        var_1 = "TAG_TURRET_BACK";
        break;
      case "front_left":
        var_1 = "TAG_TURRET_FRONT_LEFT";
        break;
      case "front_right":
        var_1 = "TAG_TURRET_FRONT_RIGHT";
        break;
      case "middle_left":
        var_1 = "TAG_TURRET_MIDDLE_LEFT";
        break;
      case "middle_right":
        var_1 = "TAG_TURRET_MIDDLE_RIGHT";
        break;
    }

    boat_mginit("minigun_hummer", var_1, "vehicle_seal_boat_turret");
  }

  self.mgturret = maps\_utility::array_index_by_script_index(self.mgturret);
}

boat_mginit(var_0, var_1, var_2) {
  var_3 = self.classname;
  var_4 = 0;

  if(isDefined(self.script_mg_angle))
    var_4 = self.script_mg_angle;

  if(!isDefined(self.mgturret))
    self.mgturret = [];

  var_5 = spawnturret("misc_turret", (0, 0, 0), var_0);
  var_5 linkto(self, var_1, (0, 0, 0), (0, -1 * var_4, 0));
  var_5 setModel(var_2);
  var_5.angles = self.angles;
  var_5.isvehicleattached = 1;
  var_5.ownervehicle = self;
  var_5.script_team = self.script_team;
  var_5 thread maps\_mgturret::burst_fire_unmanned();
  var_5 makeunusable();
  maps\_vehicle_code::set_turret_team(var_5);

  if(isDefined(self.script_fireondrones))
    var_5.script_fireondrones = self.script_fireondrones;

  self.mgturret = common_scripts\utility::array_add(self.mgturret, var_5);
  var_5.script_index = get_position_from_tag(var_1);

  if(!isDefined(self.script_turretmg))
    self.script_turretmg = 1;

  if(self.script_turretmg == 0)
    thread maps\_vehicle_code::_mgoff();
  else {
    self.script_turretmg = 1;
    thread maps\_vehicle_code::_mgon();
  }
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_GUY_FRONT_LEFT";
  var_0[2].sittag = "TAG_GUY_FRONT_RIGHT";
  var_0[3].sittag = "TAG_GUY_MIDDLE_LEFT";
  var_0[4].sittag = "TAG_GUY_MIDDLE_RIGHT";
  var_0[5].sittag = "TAG_GUY_BACK";
  var_0[0].bhasgunwhileriding = 0;
  var_0[1].mgturret = 1;
  var_0[2].mgturret = 2;
  var_0[3].mgturret = 3;
  var_0[4].mgturret = 4;
  var_0[5].mgturret = 5;
  var_0[0].idle = % london_police_pistol_idle_up;
  var_0[1].idle = % oilrig_civ_escape_2_seal_a;
  var_0[2].idle = % oilrig_civ_escape_3_a;
  var_0[3].idle = % oilrig_civ_escape_4_a;
  var_0[4].idle = % oilrig_civ_escape_5_a;
  var_0[5].idle = % oilrig_civ_escape_6_a;
  var_0[0].getout = % pickup_driver_climb_out;
  var_0[1].getout = % pickup_driver_climb_out;
  var_0[2].getout = % pickup_passenger_climb_out;
  var_0[3].getout = % pickup_passenger_climb_out;
  var_0[4].getout = % pickup_passenger_climb_out;
  var_0[5].getout = % pickup_passenger_climb_out;
  return var_0;
}

get_position_from_tag(var_0) {
  switch (var_0) {
    case "TAG_TURRET_FRONT_LEFT":
      return 1;
    case "TAG_TURRET_FRONT_RIGHT":
      return 2;
    case "TAG_TURRET_MIDDLE_LEFT":
      return 3;
    case "TAG_TURRET_MIDDLE_RIGHT":
      return 4;
    case "TAG_TURRET_BACK":
      return 5;
  }
}

unload_groups() {
  var_0 = [];
  var_0["passengers"] = [];
  var_0["all"] = [];
  var_1 = "passengers";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0["default"] = var_0["all"];
  return var_0;
}