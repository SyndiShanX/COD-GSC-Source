/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7508a8d2b5b9aa8b.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_f8486b6e01af8b5f;

function main() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player setsoundsubmix("cp_jup_resort_global");
  thread function_efbb5b6e5e8cdbeb();
  location_list = [];
  location_list[0] = (285, 5107, 1306);
  thread scripts\cp\cp_audio::function_ec9b3af8f8e2d59f(4, "flag_dungeon_outro_start", "jup_alarm_red_alert_resort_dry", "cp_jup_resort_alarm_attenuate", location_list);
  thread scripts\cp\cp_audio::function_f1dd559fdd8216d1(2, 4, 8, 1500, "resort", "flag_dungeon_outro_start");
}

function function_efbb5b6e5e8cdbeb() {
  while(true) {
    playsoundatpos((3204, -3180, 1300), "amb_elm_distant_thunder");
    wait randomintrange(15, 40);
  }
}

function function_5c76898cddcf6a50() {}

function function_43a408ee2ba42d1a() {}

function function_83c5d872891aa8fc() {}

function function_568d4e33eecc8859() {
  level.player setsoundsubmix("cp_jup_resort_bink");
}

function function_522d661934355f5b() {
  level.player clearsoundsubmix("cp_jup_resort_bink");
}