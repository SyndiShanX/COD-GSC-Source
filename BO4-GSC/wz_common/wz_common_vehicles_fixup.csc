/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_common_vehicles_fixup.csc
**************************************************/

#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\wz_common_fixup;

#namespace wz_common_vehicles_fixup;

autoexec __init__() {
  function_6df391ab();
}

function_6df391ab() {
  var_a12b4736 = &item_world_fixup::function_96ff7b88;
  var_d2223309 = &item_world_fixup::function_261ab7f5;
  var_b5014996 = &item_world_fixup::function_19089c75;
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;

  if(!(isDefined(getgametypesetting(#"wzenableatv")) && getgametypesetting(#"wzenableatv"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"hash_7df5c3630a76391e", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_green", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_police", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"hash_2a97e28588c0e70d", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_tan", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenablecargotruck")) && getgametypesetting(#"wzenablecargotruck"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle_dark", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle_green", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle_tan", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenablelittlebird")) && getgametypesetting(#"wzenablelittlebird"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_police", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_dark", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_tan", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenabletacticalraft")) && getgametypesetting(#"wzenabletacticalraft"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_odg", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenablearav")) && getgametypesetting(#"wzenablearav"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle_blk", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle_grn", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle_tan", #"");

    if(!(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && !(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))) {
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav_clearing", #"open_skyscraper_vehicles_cargo_truck");
    }
  }

  if(!(isDefined(getgametypesetting(#"wzenablepbr")) && getgametypesetting(#"wzenablepbr"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_green", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_tan", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_police", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenableattacklittlebird")) && getgametypesetting(#"wzenableattacklittlebird"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_tan", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_dark", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_green", #"");
  } else if(!(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles")) && !(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle")) && !(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_attack_heli");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli_clearing", #"open_skyscraper_vehicles_attack_heli_clearing");
  }

  if(!(isDefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_blue", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_green", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_orange", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_red", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_white", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_yellow", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_bandit_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_racing_green", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_phantom", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_dark_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_light_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_metal_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_olive", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_tan", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_white", #"");
  } else if(isDefined(getgametypesetting(#"wzenableatv")) && getgametypesetting(#"wzenableatv") && isDefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle") && !(isDefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar")) && !(isDefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_moto");
  }

  if(!(isDefined(getgametypesetting(#"wzenablereplacercar")) && getgametypesetting(#"wzenablereplacercar"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"hash_4bc7cb3d2c929e11", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_met_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_white", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_private_security", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_police_wz_vehicle", #"");
  }

  if(!(isDefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_black", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_green", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_grey", #"");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_tan", #"");
  } else if(!(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles")) && !(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_extra_small");
  }

  if(!(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && !(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b")) && !(isDefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles")) && !(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle")) && !(isDefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks")) && !(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))) {
    if(isDefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar")) {
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_muscle_car_hot_pursuit", #"open_skyscraper_vehicles_muscle_car");

      if(isDefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv")) {
        if(isDefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")) {
          wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_moto_extra_small");
        } else {
          wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_extra_small");
        }

        if(!(isDefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank"))) {
          wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_small");
        }

        wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_suv_base", #"open_skyscraper_vehicles_suv");
      } else if(isDefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")) {
        wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_moto_small");
      } else {
        wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_small");
      }
    } else if(isDefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv")) {
      if(isDefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")) {
        wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_moto_small");
      } else {
        wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_small");
      }

      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_suv_base", #"open_skyscraper_vehicles_suv_medium");
    }
  }

  if(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle") && !(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b")) && !(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && !(isDefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles")) && !(isDefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks")) && !(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_muscle_car_hot_pursuit", #"open_skyscraper_vehicles_muscle_car_big_team");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_big_team");

    if(!(isDefined(getgametypesetting(#"wzenableattacklittlebird")) && getgametypesetting(#"wzenableattacklittlebird"))) {
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_heli_big_team");
    } else {
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_attack_heli_big_team");
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli_clearing", #"open_skyscraper_vehicles_attack_heli_clearing");
    }

    if(isDefined(getgametypesetting(#"wzenablepbr")) && getgametypesetting(#"wzenablepbr")) {
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"open_skyscraper_vehicles_pbr_big_team");
    }

    if(!(isDefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank"))) {
      wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_big_team");
    }
  }

  if(isDefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks") && !(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b")) && !(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && !(isDefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles")) && !(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle")) && !(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_odg", #"zodiac_wz_vehicle_grey");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_muscle_car_hot_pursuit", #"open_skyscraper_vehicles_muscle_car_wetworks");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_extra_small");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_small");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_suv_base", #"open_skyscraper_vehicles_suv");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_zodiac", #"open_skyscraper_vehicles_zodiac_wetworks");
  }

  if(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b") && !(isDefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks")) && !(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && !(isDefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles")) && !(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle")) && !(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_moto_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv_ghost_town", #"open_skyscraper_vehicles_atv_ghost_town_police");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_suv_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_heli_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli_clearing", #"open_skyscraper_vehicles_heli_clearing_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav", #"open_skyscraper_vehicles_arav_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav_clearing", #"open_skyscraper_vehicles_suv_clearing_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"open_skyscraper_vehicles_pbr_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck_clearing", #"open_skyscraper_vehicles_suv_clearing_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_muscle_car_hot_pursuit", #"open_skyscraper_vehicles_muscle_car_heroes");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_tank", #"vehicle_list_empty_wz");
  }

  if(isDefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles") && !(isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b")) && !(isDefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks")) && !(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && !(isDefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles")) && !(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_muscle_car_hot_pursuit", #"open_skyscraper_vehicles_muscle_car_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"open_skyscraper_vehicles_atv_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_suv_base", #"open_skyscraper_vehicles_suv_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav", #"open_skyscraper_vehicles_arav_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_attack_heli_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"open_skyscraper_vehicles_pbr_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_tank", #"open_skyscraper_vehicles_tank_test");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_motorcycle", #"open_skyscraper_vehicles_motorcycle_test");
  }
}