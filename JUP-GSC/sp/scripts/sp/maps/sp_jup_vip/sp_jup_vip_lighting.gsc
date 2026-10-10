/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting.gsc
*****************************************************************/

#using scripts\common\ai;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\lights;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\player;
#using scripts\sp\utility;
#using scripts\sp\vision;
#namespace sp_jup_vip_lighting;

function main() {
  scripts\sp\lights::init();
  scripts\common\lighting::light_init();
  level.var_ce78d0e4ea4e7d3b = (0, 0, 0);
  thread function_95238bbeaa618750();
  thread play_lights();
  thread function_f29d0cd9dae6bab4();
  thread function_73d951ad7e0a6224();
  thread function_485480c7b39086ec();
  thread function_bdddea332d5b6e26();
  thread function_f822c68c2aa2215b();
  thread function_28e34d994c7c4008();
  thread function_492b56c109e0dda5();
  thread flow_laundry();
  thread flow_shower();
  thread flow_hallway();
  thread flow_elevator();
  thread function_a840a70ceeb91af5();
  thread function_85f4506969c4eb3e();
  thread function_4450cdf9ea494c76();
  thread flow_lightning();
  thread function_61c92c7d65abe2ee();
  thread function_9a654fa165db374c();
  thread function_d07c024f46b69222();
  thread function_b8dadedcbfbc2f23();
  thread function_3a9f5efbbf29c878();
  thread function_4a6780176013b74();
  thread function_76507ddfcb2fd56a();
  thread sun_castle_btm();
  thread function_3894b687f9e0b4c8();
  thread function_754a81846187bb1e();
  thread function_583ee0a8609a6ee2();
  thread function_153f33f5dedc86a7();
  thread function_2fc4e3b3450f3df7();
  thread function_916337b41b900368();
  thread function_55340deea8653ff6();
  thread escape_jeep_explosion();
  thread function_147aa773e6654f84();
  thread trig_boat_visiblity();
  thread lightning_cliff_trig();
  thread lightning_cliff_trig_int();
  thread function_11dcec639f444f8a();
  thread trig_flare_adjust_down();
  thread function_34f4b53af87b69f5();
  thread function_873d15bd518ed381();
  thread function_ed8262fb3bd4533b();
  thread function_e460bc303ea00462();
  thread function_4e9e9ddbf1dff889();
  thread function_ffef59640da9b712();
  level.var_6df7b39edec9ac5b = getmapsundirection();
  level.var_3f54399adf1186fd = getmapsuncolorandintensity();
  thread nvg_player();
  thread sun_castle_btm();
  thread function_b4e307f11db183af();
  thread function_421b2eddef2ce150();
  thread function_e067f7d1900e80bb();
  thread wind_manage();
  flag_init("player_underwater");
  flag_init("player_above_water");
  flag_init("flag_rappel_lightning");
  flag_init("sun_castle_btm");
  flag_init("sun_castle_top");
  flag_init("garage_sun_move");
  flag_init("garage_sun_reset");
  flag_init("lgt_descend");
  flag_init("wall_lightning_5");
  flag_init("cine_exfil_start");
  flag_init("cine_exfil_end");
  flag_init("cine_elevator_start");
  flag_init("cine_elevator_end");
  flag_init("flag_heli_light_on");
  flag_init("flag_heli_light_off");
  flag_init("wind_on");
  flag_init("escape_jeep_explosion_look");
  flag_init("delete_descend_lights");
  thread courtyard_riot_searchlight();
  thread function_c6f9355bddd9ddf2();
  thread function_c4aca27fe679a4fc();
}

function function_a6fea76a4085e5c1() {
  wait 1;
  setsaveddvar(@ "hash_7c6e3f49a053cc4c", 0.5);
  setsaveddvar(@ "hash_b345e52965c135b5", 0.5);
  setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.4);
}

function function_c4aca27fe679a4fc() {
  wait 1;
  roof = getEnt("metal_roof_reflect_bake", "targetname");
  roof hide();
}

function function_95238bbeaa618750() {
  lights = getEntArray("lgt_pingpong", "targetname");

  foreach(light in lights) {
    light setlightintensity(0);
  }

  lights = getEntArray("lgt_pingpong_2", "script_noteworthy");

  foreach(light in lights) {
    light setlightintensity(0);
  }

  lights = getEntArray("lgt_pingpong_3", "targetname");

  foreach(light in lights) {
    light setlightintensity(0);

    if(isDefined(light.target)) {
      otherlight = getEnt(light.target, "targetname");

      if(isDefined(otherlight)) {
        otherlight setlightintensity(0);
      }
    }
  }

  lights = getEntArray("lgt_pingpong_3_int", "targetname");

  foreach(light in lights) {
    light setlightintensity(0);
  }

  lights = getEntArray("lower_cell_lights", "targetname");

  foreach(light in lights) {
    light setlightcolor((0.9, 1, 0.9));
    light setlightintensity(0);
  }

  thread function_238c2a0aae70e973("red_hall_spot_01", 0, 0);
  thread function_238c2a0aae70e973("red_hall_spot_01_riot", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0.1, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_r", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_l", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0, 0);
}

function function_bf27c7ad1e422467(var_d18b18f6dda61234) {
  level.var_d18b18f6dda61234 = var_d18b18f6dda61234;

  if(isplatformxb3() || isplatformps4()) {
    if(!self.player isnightvisionon()) {
      setsaveddvar(@ "hash_8adcf05d62fe94fd", var_d18b18f6dda61234);
    }

    return;
  }

  setsaveddvar(@ "hash_8adcf05d62fe94fd", var_d18b18f6dda61234);
}

function nvg_player() {
  setdvarifuninitialized(@ "hash_6cb1c50089b6d4d6", 1);
  function_b1b8627b47c5cb79();
  level.player thread function_be7108cc4f05380d();
  level.player thread descend_dim();
  level.player.nvg.on_func = &function_1404277c6de3c625;
  level.player.nvg.off_func = &function_5b6c187e98f818bb;
}

function function_b1b8627b47c5cb79() {
  var_b2483316f871904f = "vfx_nvg_light_player_vip_proto";
  scripts\sp\nvg\nvg_player::main("nvg_base_color_vip");
  level.player set_nvg_light(var_b2483316f871904f);
}

function function_1404277c6de3c625() {
  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_8adcf05d62fe94fd", 0);
  }

  ent_flag_set("stop_tracking_dynolights");
  setsaveddvar(@ "hash_4d6272d1b6aa54d2", 0.02);
}

function function_5b6c187e98f818bb() {
  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_8adcf05d62fe94fd", level.var_d18b18f6dda61234);
  }

  setsaveddvar(@ "hash_4d6272d1b6aa54d2", 0.0005);
}

function descend_dim() {
  self endon("death");

  while(true) {
    waitframe();

    if(self isnightvisionon() && !self adsButtonPressed() && flag("lgt_descend")) {
      setsaveddvar(@ "hash_ac413fc6c99ddeeb", 0.3);
    }

    while(self isnightvisionon() && !self adsButtonPressed() && flag("lgt_descend")) {
      waitframe();
    }
  }

  waitframe();
}

function function_be7108cc4f05380d() {
  self endon("death");
  toggled = undefined;

  while(true) {
    while(!self adsButtonPressed()) {
      waitframe();
    }

    weapon = self getcurrentprimaryweapon();

    if(weapon_has_scope(weapon) && self isnightvisionon()) {
      toggled = 1;

      if(flag("lgt_descend")) {
        setsaveddvar(@ "hash_ac413fc6c99ddeeb", 0.3);
      } else {
        setsaveddvar(@ "hash_ac413fc6c99ddeeb", 1);
      }
    }

    while(self isnightvisionon() && self adsButtonPressed()) {
      waitframe();
    }

    if(self isnightvisionon()) {
      if(istrue(toggled)) {
        if(flag("lgt_descend")) {
          setsaveddvar(@ "hash_ac413fc6c99ddeeb", 0.15);
        } else {
          setsaveddvar(@ "hash_ac413fc6c99ddeeb", 0.5);
        }

        toggled = undefined;
      }
    }

    waitframe();
  }
}

function weapon_has_scope(var_cc0d1a175a64fc0c) {
  if(isnullweapon(var_cc0d1a175a64fc0c)) {
    return false;
  }

  if(weaponclass(var_cc0d1a175a64fc0c) == "pistol") {
    return false;
  }

  if(isDefined(var_cc0d1a175a64fc0c.attachments) && var_cc0d1a175a64fc0c.attachments.size == 0) {
    return false;
  }

  foreach(attachment in var_cc0d1a175a64fc0c.attachments) {
    if(issubstr(attachment, "ironsdefault")) {
      return false;
    }
  }

  return true;
}

function cp_intro() {
  set_vision_naked("sp_jup_vip_intro_dark", 0);
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
}

function cp_scuba() {
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
}

function cp_wall() {
  level function_bf27c7ad1e422467(0.45);
  flag_set("flag_rappel_lightning");
  flag_set("sun_castle_btm");
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  thread function_238c2a0aae70e973("wall_bottom_moonlight", 1, 25);
  thread function_54878a661201ffa();
  flag_set("wall_lightning_5");
  flag_set("wind_on");
  thread function_1bb3d949f3e37969();
}

function function_9f153f00841d1005() {
  setsundirection(anglesToForward((-16, 41.27, 0)));
  setsuncolorandintensity(0.12);
  set_vision_naked("sp_jup_vip_ext", 0);
  flag_set("flag_roof_lightning");
  setsaveddvar(@ "hash_5a83a561cb4970b2", 4096);
  level function_bf27c7ad1e422467(0.4);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 5000);
  setsaveddvar(@ "hash_93b4b56b615317b9", 4000);
  setsaveddvar(@ "hash_ac413fc6c99ddeeb", 1);
  setsaveddvar(@ "hash_227255b054ed2f30", 1);
  setsaveddvar(@ "hash_f462015fd5b9ecc7", 1);
  setsaveddvar(@ "hash_48befd65e5945e5", 1);
  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  function_598d3d265271bd0c();
  function_57a2b4fa9a2f47e2();
  flag_clear("wall_lightning_5");
  flag_set("wind_on");

  if(isplatformxb3() || isplatformps4()) {
    setsuncolorandintensity(0);
  }

  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
}

function function_48daccb47fb01be() {
  setsundirection(anglesToForward((-16, 41.27, 0)));
  flag_set("flag_roof_lightning");
  setsaveddvar(@ "hash_5a83a561cb4970b2", 4096);
  level function_bf27c7ad1e422467(0.4);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 5000);
  set_vision_naked("sp_jup_vip_ext", 0);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  setsuncolorandintensity(0);
  setsaveddvar(@ "hash_227255b054ed2f30", 1);
  setsaveddvar(@ "hash_f462015fd5b9ecc7", 1);
  setsaveddvar(@ "hash_48befd65e5945e5", 1);
  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  function_57a2b4fa9a2f47e2();
  flag_clear("wind_on");
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
}

function cp_descend() {
  set_vision_naked("sp_jup_vip_central_shaft", 0.2);
  flag_clear("flag_roof_lightning");
  flag_clear("wind_on");

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    setsaveddvar(@ "hash_1d03444cd52cc348", 0);
  }

  level function_bf27c7ad1e422467(0.35);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 1000);
  setsaveddvar(@ "hash_5a83a561cb4970b2", 2176);
  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  wait 0.5;
  setsuncolorandintensity(0);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_92223cfdf808190e() {
  set_vision_naked("sp_jup_vip_central_shaft", 0);
  flag_set("lgt_descend");
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  setsaveddvar(@ "hash_e08232af8b8b695c", 6);
  setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.1);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 600);
  flag_clear("wind_on");
  thread function_1c490662fd0cada2();
  thread function_1c490562fd0cab6f();
  thread function_1c490462fd0ca93c();
  thread function_1c490362fd0ca709();
  wait 0.5;
  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_acdd340de8aeefc() {
  set_vision_naked("sp_jup_vip_reach_vip", 0);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  flag_clear("wind_on");
  level.player nightvisiongogglesforceoff();
  thread function_1be9145b47c4b31d();
  setsaveddvar(@ "hash_1ea8544d78048529", 0);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
  setsaveddvar(@ "hash_eca4b727b01fd254", 3);
  setsaveddvar(@ "hash_93b4b56b615317b9", 2000);
  setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.5);
  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_ea6731f91b1378e6() {
  set_vision_naked("sp_jup_vip_central_shaft", 0);
  setsaveddvar(@ "hash_93b4b56b615317b9", 500);
  flag_clear("wind_on");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor", 0, 80);
  thread function_68aeea781acf5933();
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_e8bf4798eff66542() {
  set_vision_naked("sp_jup_vip_central_shaft", 0);
  wait 0.05;
  flag_clear("wind_on");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor", 0, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor_2", 0, 20);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor_rim_ivan", 0.5, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor_rim_makarov", 0.5, 0);
  thread function_f20723b6b8a2349e();
  thread function_68aeea781acf5933();
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_333c73e0dcbdc794() {
  setsundirection(anglesToForward((-16, 41.27, 0)));
  setsuncolorandintensity(0.12);
  setsaveddvar(@ "hash_5a83a561cb4970b2", 4096);
  level function_bf27c7ad1e422467(0.4);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 5000);
  thread function_a6fea76a4085e5c1();
  set_vision_naked("sp_jup_vip_ext_court2", 0);
  function_88538347d5881c88();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_ef38136354fc0472();
  thread function_238c2a0aae70e973("courtyard_castle_spot_light", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0, 0);
  setsuncolorandintensity(0);
  flag_clear("wind_on");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  lgt_elevator_outside_end = getEnt("lgt_elevator_outside_end", "targetname");
  lgt_elevator_outside_end function_b06dacaa135987ad(0);
  thread function_f20723b6b8a2349e();
  thread function_68aeea781acf5933();
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_881065c6aa2388e() {
  set_vision_naked("sp_jup_vip_ext_court2", 0);
  function_88538347d5881c88();
  thread function_a6fea76a4085e5c1();
  thread function_238c2a0aae70e973("courtyard_castle_spot_light", 0, 0);
  setsuncolorandintensity(0);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_f20723b6b8a2349e();
  thread function_68aeea781acf5933();
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_e3b94169b8a44a68() {
  set_vision_naked("sp_jup_vip_ext_heli_int", 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0, 0);
  setsundirection(anglesToForward((-39, 60, 0)));
  setsuncolorandintensity(0.6);
  thread function_a6fea76a4085e5c1();
  flag_set("wind_on");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_68aeea781acf5933();
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function cp_outro() {
  set_vision_naked("sp_jup_vip_ext_cliff", 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0, 0);
  function_88538347d5881c88();
  thread function_238c2a0aae70e973("hallway_window_lights", 0, 0);
  thread function_a6fea76a4085e5c1();
  setsuncolorandintensity(0.12);
  flag_set("wind_on");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_68aeea781acf5933();
  thread function_1bb3d949f3e37969();
  thread function_79294f88498b3155();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_73dfa61909504f41() {
  thread function_69ad917e1822ff0d();
}

function function_69ad917e1822ff0d() {
  wait 0.05;
  level.var_c0539be4ffb94f6f = 0;
  underwater_triggers = getEntArray("UNDERWATER_TRIGGERS", "targetname");

  foreach(underwater_triggers in underwater_triggers) {
    underwater_triggers thread function_4064e58b7f73e5b4();
  }

  while(true) {
    level waittill("underwater_trigger_count_updated");
    waittillframeend();

    if(level.var_c0539be4ffb94f6f > 0) {
      setsaveddvar(@ "hash_5a83a561cb4970b2", 2500);
      continue;
    }

    setsaveddvar(@ "hash_5a83a561cb4970b2", 2176);
  }
}

function function_4064e58b7f73e5b4() {
  while(true) {
    self waittill("trigger");
    level.var_c0539be4ffb94f6f++;
    level notify("underwater_trigger_count_updated");

    while(level.player istouching(self)) {
      wait 0.1;
    }

    level.var_c0539be4ffb94f6f--;
    level notify("underwater_trigger_count_updated");
  }
}

function function_485480c7b39086ec() {
  wait 0.05;
  run_thread_on_targetname("roof_top_flow_lgt_trig", &roof_top_flow_lgt_trig);
}

function roof_top_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    flag_set("flag_roof_lightning");
    set_vision_naked("sp_jup_vip_ext", 0.8);

    if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
      setsaveddvar(@ "hash_1d03444cd52cc348", 0.875);
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_bdddea332d5b6e26() {
  wait 0.05;
  run_thread_on_targetname("roof_top_flow_lgt_trig_int_clamp", &roof_top_flow_lgt_trig_int_clamp);
}

function roof_top_flow_lgt_trig_int_clamp() {
  while(true) {
    self waittill("trigger");

    if(level.player isnightvisionon()) {
      set_vision_naked("sp_jup_vip_ext", 0);
      thread set_nvg_vision("nvg_base_color_vip_int", 3);
    } else {
      thread set_vision_naked("sp_jup_vip_int_clamp", 0);
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }

    thread set_nvg_vision("nvg_base_color_vip", 3);
  }
}

function function_f822c68c2aa2215b() {
  wait 0.05;
  run_thread_on_targetname("gulag_interior_flow_lgt_trig", &gulag_interior_flow_lgt_trig);
}

function gulag_interior_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    flag_clear("wind_on");
    set_vision_naked("sp_jup_vip_piperoom", 0.2);
    flag_clear("flag_roof_lightning");

    if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
      setsaveddvar(@ "hash_1d03444cd52cc348", 0);
    }

    level function_bf27c7ad1e422467(0.35);
    setsaveddvar(@ "hash_8667c0bb90c5bfc3", 1000);
    setsaveddvar(@ "hash_5a83a561cb4970b2", 2176);
    setsuncolorandintensity(0);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_28e34d994c7c4008() {
  wait 0.05;
  run_thread_on_targetname("central_shaft_flow_lgt_trig", &central_shaft_flow_lgt_trig);
}

function central_shaft_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    flag_clear("wind_on");
    set_vision_naked("sp_jup_vip_central_shaft", 0.8);
    thread function_238c2a0aae70e973("red_hall_spot_01_riot", 0.8, 200);
    wait 0.1;
    var_29b310c42d26af91 = getEntArray("groundfloor_spots", "script_noteworthy");

    foreach(light in var_29b310c42d26af91) {
      light setlightcolor((0.9, 1, 0.9));
      light setlightintensity(80);
    }

    lights = getEntArray("lower_cell_lights", "targetname");

    foreach(light in lights) {
      light setlightintensity(1);
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_85f4506969c4eb3e() {
  wait 0.05;
  run_thread_on_targetname("central_shaft_flow_guard_lgt_trig", &function_8880ea90bbf7af1f);
}

function function_8880ea90bbf7af1f() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_central_shaft_guard", 1);
    setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.9);
    setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
    setsaveddvar(@ "hash_36561ce503889667", 0.95);
    setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
    thread function_26280fbed5700639();
    setsaveddvar(@ "hash_6e3f8cef6be16b33", 1);
    thread lerp_dvar(@ "hash_dacffbfd52c2fdc5", 10, 1);
    thread lerp_dvar(@ "hash_eca4b727b01fd254", 10, 1);
    setsaveddvar(@ "hash_93b4b56b615317b9", 2000);
    setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.005);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_a840a70ceeb91af5() {
  wait 0.05;
  run_thread_on_targetname("central_shaft_dark_flow_lgt_trig", &central_shaft_dark_flow_lgt_trig);
}

function central_shaft_dark_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_central_shaft_int", 0.8);
    thread function_238c2a0aae70e973("red_hall_spot_01_riot", 0.8, 50);
    setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.1);
    setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
    setsaveddvar(@ "hash_36561ce503889667", 0.95);
    setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
    wait 0.1;
    var_29b310c42d26af91 = getEntArray("groundfloor_spots", "script_noteworthy");

    foreach(light in var_29b310c42d26af91) {
      light setlightintensity(80);
    }

    lights = getEntArray("lower_cell_lights", "targetname");

    foreach(light in lights) {
      light setlightcolor((0.9, 1, 0.9));
      light setlightintensity(randomfloatrange(0.2, 2));
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_492b56c109e0dda5() {
  wait 0.05;
  run_thread_on_targetname("reach_vip_flow_lgt_trig", &reach_vip_flow_lgt_trig);
}

function reach_vip_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_reach_vip", 0.5);
    setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
    setsaveddvar(@ "hash_36561ce503889667", 0.95);
    setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
    setsaveddvar(@ "hash_93b4b56b615317b9", 2000);
    setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.5);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function flow_laundry() {
  wait 0.05;
  run_thread_on_targetname("laundry_flow_lgt_trig", &laundry_flow_lgt_trig);
}

function laundry_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_laundry", 0.8);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function flow_shower() {
  wait 0.05;
  run_thread_on_targetname("shower_flow_lgt_trig", &shower_flow_lgt_trig);
}

function shower_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");

    if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
      setsaveddvar(@ "hash_1d03444cd52cc348", 0);
    }

    level function_bf27c7ad1e422467(0.85);
    setsaveddvar(@ "hash_8667c0bb90c5bfc3", 1000);
    setsaveddvar(@ "hash_5a83a561cb4970b2", 2176);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_61c92c7d65abe2ee() {
  wait 0.05;
  run_thread_on_targetname("shower_to_elv_flow_lgt_trig", &shower_to_elv_flow_lgt_trig);
}

function shower_to_elv_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    thread function_238c2a0aae70e973("elevator_lgt_int_corridor", 5, 0);
    thread function_238c2a0aae70e973("elevator_lgt_int_corridor_2", 5, 20);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_9a654fa165db374c() {
  wait 0.05;
  run_thread_on_targetname("shower_to_elv_back_flow_lgt_trig", &shower_to_elv_back_flow_lgt_trig);
}

function shower_to_elv_back_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    thread function_238c2a0aae70e973("elevator_lgt_int_corridor", 5, 80);
    thread function_238c2a0aae70e973("elevator_lgt_int_corridor_2", 5, 0);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function flow_hallway() {
  wait 0.05;
  run_thread_on_targetname("hallway_flow_lgt_trig", &hallway_flow_lgt_trig);
}

function hallway_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_hallway", 0.8);

    if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
      setsaveddvar(@ "hash_1d03444cd52cc348", 0);
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function flow_elevator() {
  wait 0.05;
  run_thread_on_targetname("elevator_flow_lgt_trig", &elevator_flow_lgt_trig);
}

function elevator_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");

    if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
      setsaveddvar(@ "hash_1d03444cd52cc348", 0);
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_d07c024f46b69222() {
  wait 0.05;
  run_thread_on_targetname("FLOW_vip_post_igc_trig", &flow_vip_post_igc_trig);
}

function flow_vip_post_igc_trig() {
  while(true) {
    self waittill("trigger");
    thread function_26280fbed5700639();
    setsaveddvar(@ "hash_8667c0bb90c5bfc3", 500);

    if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
      setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
    }

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_754a81846187bb1e() {
  wait 0.05;
  run_thread_on_targetname("garage_lights_off_trig", &garage_lights_off_trig);
}

function garage_lights_off_trig() {
  while(true) {
    self waittill("trigger");
    thread function_238c2a0aae70e973("garage_light_rim", 5, 0);

    while(level.player istouching(self)) {
      wait 0.05;
    }
  }
}

function function_1be9145b47c4b31d() {
  thread function_61a998996cc98831();
  setsaveddvar(@ "hash_6e3f8cef6be16b33", 1);
  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
  setsaveddvar(@ "hash_eca4b727b01fd254", 2);
  setsaveddvar(@ "hash_e08232af8b8b695c", 6);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
}

function function_26280fbed5700639() {
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  setsaveddvar(@ "hash_cb82c01fec2d534b", 8);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_1ea8544d78048529", 1);
  }

  setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
}

function blur_control() {
  flag_wait("flag_intro_blur_on");
  level.player setblurforplayer(20, 0.5);
  wait 0.5;
  level.player fade_out(0.5, "black");
  flag_wait("flag_intro_blur_off");
  wait 0.25;
  level.player setblurforplayer(0, 0.5);
}

function function_9a73cff3a0f6f2c5(skipintro) {
  if(!isDefined(skipintro)) {
    skipintro = 0;
  }

  if(!skipintro) {
    set_vision_naked("sp_jup_vip_intro_dark", 0);
    wait 0.1;
    thread function_6030abe810f0150f();
    setsaveddvar(@ "hash_1048f749a8b7aa91", 1);
    thread function_b3d1097077cb01bf();
    thread function_1be9145b47c4b31d();
    setsaveddvar(@ "hash_5a83a561cb4970b2", 1);
    setsaveddvar(@ "hash_227255b054ed2f30", 1);
    setsaveddvar(@ "hash_f462015fd5b9ecc7", 1);
    setsaveddvar(@ "hash_48befd65e5945e5", 1);
    setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
    setsaveddvar(@ "hash_eca4b727b01fd254", 16);
    setsaveddvar(@ "hash_6157be5fe5b7cd6e", 16);
    setsaveddvar(@ "hash_93b4b56b615317b9", 4500);
    level.player utility::letterbox_enable(1, 0);
    thread blur_control();
    thread function_238c2a0aae70e973("lgt_intro_castle_rim", 0, 5000);
    flag_wait("lgt_intro_1st_shot");
    level.storm.var_39c17e1e440feaf6 = 40;
    level.storm.var_39e4701e443613e4 = 80;
    level function_bf27c7ad1e422467(0.37);
    thread function_238c2a0aae70e973("intro_rim", 0.1, 0);
    thread function_238c2a0aae70e973("intro_key", 0.1, 0);
    thread function_238c2a0aae70e973("intro_fill", 0.1, 0);
    thread function_238c2a0aae70e973("intro_key_2", 0.1, 0);
    wait 4;
    thread function_4592ed3200c60f5("intro_rim_2", 0, (0.8, 0.8, 1));
    thread function_238c2a0aae70e973("intro_rim_2", 2, 40);
    thread function_238c2a0aae70e973("intro_key_2", 0.1, 0);
    thread function_238c2a0aae70e973("intro_fill_2", 0.1, 0);
    wait 3;
    thread function_238c2a0aae70e973("intro_rim_2", 1.5, 10);
    flag_wait("lgt_intro_rotate_shot");
    thread function_238c2a0aae70e973("intro_rim_2", 2, 0);
    thread function_238c2a0aae70e973("intro_fill_2", 2, 0);
    thread function_238c2a0aae70e973("intro_key_2", 2, 0);
    wait 2.5;
    set_vision_naked("sp_jup_vip_intro_boat", 0.25);
    flag_wait("lgt_intro_2nd_shot");
    setsuncolorandintensity(0);
    setsaveddvar(@ "hash_1ea8544d78048529", 0);
    setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
    thread function_346b41f230343453();
    level.storm.var_39c17e1e440feaf6 = -180;
    level.storm.var_39e4701e443613e4 = 180;
    level function_bf27c7ad1e422467(0.65);
    thread function_238c2a0aae70e973("lgt_intro_castle_rim", 0, 0);
    setsaveddvar(@ "hash_5a83a561cb4970b2", 2176);
    set_vision_naked("sp_jup_vip_underwater_start", 0);
    thread function_238c2a0aae70e973("intro_fill_2", 0.1, 0);
    thread function_238c2a0aae70e973("intro_rim_2", 0.1, 0);
    thread function_238c2a0aae70e973("intro_key_2", 0.1, 0);
    wait 0.5;
    thread function_238c2a0aae70e973("intro_key_3_tp", 2, 40);
    wait 1.5;
    set_vision_naked("sp_jup_vip_underwater", 2);
    flag_wait("cine_intro_dpv_light_ally");
    setsaveddvar(@ "hash_cb471f951a15940f", 0.5);
    setsaveddvar(@ "hash_36561ce503889667", 0.5);
    setsaveddvar(@ "hash_5a016e50936393e9", 0.5);
    thread function_f59833fb6c570028();
    wait 0.5;
    thread function_8d3ebbf2a1a2d301();
    level waittill("cine_intro_end");
  }

  setsaveddvar(@ "hash_1048f749a8b7aa91", 0);
  setsaveddvar(@ "hash_93b4b56b615317b9", 2000);
  thread function_238c2a0aae70e973("water_emerge_begin_key", 4, 200);
  thread function_26280fbed5700639();
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 2);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.6);
  setsaveddvar(@ "hash_36561ce503889667", 0.6);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.6);
  level.scuba_mask = utility::spawn_model("parts_jup_headgear_m48_mod1_divemask_vm");
  level.scuba_mask linktoplayerview(level.player, "tag_origin", (0, 0, 0));
  level.scuba_mask show();
  wait 1;
  level.player thread utility::letterbox_enable(0, 1.5);
  flag_set("vip_fov_scuba_gameplay_start");
  flag_clear("lgt_intro_1st_shot");
}

function function_b3d1097077cb01bf() {
  flag_wait("lgt_intro_1st_shot");
  setblur(10, 0);
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(1, 50, 5, 5);
  wait 0.05;
  setblur(0, 4);
  set_vision_naked("sp_jup_vip_intro", 3);
  wait 1;
  wait 2;
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 500, 5, 5);
  wait 2;
  level.player thread utility::dof_enable_autofocus(1.5, level.ally1, 5, 2, undefined, "j_head");
  wait 6;
  setDvar(@ "hash_93ca035fa3964d3d", 0);
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 500, 15, 50);
  flag_wait("lgt_intro_rotate_shot");
  level.player setphysicaldepthoffield(4, 500, 15, 50);
  flag_wait("lgt_intro_guy_look");
  level.player thread utility::dof_enable_autofocus(0.5, level.ally1, 5, 2, undefined, "j_head");
  flag_wait("lgt_intro_2nd_shot");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(0.2, 100, 50, 50);
  setsaveddvar(@ "hash_227255b054ed2f30", 0);
  setsaveddvar(@ "hash_f462015fd5b9ecc7", -1);
  setsaveddvar(@ "hash_48befd65e5945e5", 0.1);
  wait 3;
  level.player thread utility::dof_enable_autofocus(1.25, level.ally1, 10, 10, undefined, "tag_accessory_right");
  wait 2;
  level.player thread utility::dof_enable_autofocus(1.8, level.ally2, 5, 2, undefined, "tag_accessory_left");
  flag_wait("cine_intro_dpv_light_ally");
  level.player thread utility::dof_enable_autofocus(1.8, level.fakeplayer, 5, 2, undefined, "tag_accessory_right");
  flag_wait("cine_intro_glow_break_2");
  wait 1.25;
  level.player thread utility::dof_enable_autofocus(1.8, level.ally2, 5, 2, undefined, "tag_accessory_left");
  level waittill("cine_intro_end");
  level.player thread utility::dof_enable_autofocus(2, undefined, 5, 2);
}

function function_361103be5fb28520() {
  flag_wait("lgt_emerge_start");
  setsaveddvar(@ "hash_e08232af8b8b695c", 6);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  setsaveddvar(@ "hash_eca4b727b01fd254", 32);
  thread function_1be9145b47c4b31d();
  thread function_f151a60f895e4d9e();
  thread function_91684a8276eb067e();
  thread function_238c2a0aae70e973("water_emerge_begin_key", 3, 0);
  thread function_238c2a0aae70e973("water_emerge_red_key", 4, 20);
  thread function_238c2a0aae70e973("water_emerge_red_key_2", 4, 16);
  thread function_238c2a0aae70e973("water_emerge_moon_fill", 3, 300);
  flag_wait("lgt_emerge_swim_end");
  level thread function_2369ab2349b02a8e();
  setsaveddvar(@ "hash_eca4b727b01fd254", 16);
  flag_wait("lgt_emerge_change");
  flag_set("sun_castle_btm");
  thread function_238c2a0aae70e973("water_emerge_red_key", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_red_key_2", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_rim", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_rim_2", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_fill", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_fill_2", 0.5, 20);
  flag_wait("lgt_emerge_grab_gear");
  thread function_238c2a0aae70e973("water_emerge_moon_end_key_1", 0.5, 40);
  thread function_238c2a0aae70e973("water_emerge_red_key_3", 1, 80);
  thread function_238c2a0aae70e973("water_emerge_fill_3", 0.1, 4);
  wait 6.9;
  thread function_238c2a0aae70e973("water_emerge_fill_2", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_fill_3", 1, 0);
  flag_wait("lgt_emerge_swim_up");
  thread function_54878a661201ffa();
  thread function_238c2a0aae70e973("water_emerge_moon_end_key_2", 1, 120);
  thread function_238c2a0aae70e973("water_emerge_red_key_3", 3, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_rim_2", 5, 0);
  flag_wait("lgt_emerge_surface_look_up");
  thread function_238c2a0aae70e973("water_emerge_moon_end_key_1", 1, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_end_key_2", 2, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_rim", 2, 0);
  flag_wait("lgt_remove_mask");
  thread function_238c2a0aae70e973("wall_bottom_moonlight", 1, 25);
  flag_wait("lgt_emerge_end");
  thread function_bfbba57c24d8bf2f();
  thread function_26280fbed5700639();
  flag_set("wall_lightning_5");
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  flag_set("wind_on");
}

function function_f151a60f895e4d9e() {
  set_vision_naked("sp_jup_vip_underwater_end", 0);
  level.player thread utility::dof_enable_autofocus(3, level.ally1, 30, 30, undefined, "j_head");
  flag_wait("lgt_emerge_swim_end");
  level.player thread utility::dof_enable_autofocus(2, level.ally1, 30, 30, undefined, "j_head");
  wait 2.2;
  level.player thread utility::dof_enable_autofocus(2, level.ally2, 30, 30, undefined, "j_head");
  flag_wait("lgt_emerge_change");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 12, 15, 50);
  flag_wait("lgt_emerge_change_finished");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(2, level.ally2, 30, 30, undefined, "j_head");
  flag_wait("lgt_emerge_surface_look_up");
  level.player thread utility::dof_enable_autofocus(1, level.player, 25, 25, undefined, "j_wrist_ri");
  flag_wait("lgt_emerge_surface");
  set_vision_naked("sp_jup_vip_underwater_end_mask", 0);
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 500, 15, 50);
  setsuncolorandintensity(0.2);
  flag_set("flag_rappel_lightning");
  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  flag_wait("lgt_remove_mask");
  level.player[[level.swim.visionsetfunc]]("sp_jup_vip_rappel", 0);

  if(isDefined(level.scuba_mask)) {
    level.scuba_mask unlinkfromplayerview(level.player);
    level.scuba_mask delete();
  }

  set_vision_naked("", 0);
  level function_bf27c7ad1e422467(0.45);
  setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  wait 0.5;
  level.player disablephysicaldepthoffieldscripting();
  flag_wait("lgt_emerge_end");
  flag_wait("pushthroughkelp_flag");
}

function function_bddf445e41d4f976() {
  thread function_47db9742d70b9a0d();
  flag_set("flag_rappel_lightning");
  level waittill("start_rappel_dof");
  thread function_1be9145b47c4b31d();
  thread function_996c7c0ab957b783();
}

function function_76a901b98ffd8919() {
  flag_wait("lgt_wall_ascend_start");
  function_57a2b4fa9a2f47e2();
  thread function_238c2a0aae70e973("tower_explosion_light", 0, 0);
  set_vision_naked("sp_jup_vip_rappel", 1);
  thread function_238c2a0aae70e973("wall_bottom_key", 0.1, 2);
  thread function_238c2a0aae70e973("wall_bottom_fill", 0.1, 2);
  flag_wait("lgt_wall_raise_rappel");
  flag_clear("flag_rappel_lightning");
  thread function_238c2a0aae70e973("lgt_rappel_climb_rim", 1, 200);
  flag_wait("lgt_wall_ascend_halfway");
  setsaveddvar(@ "hash_5a83a561cb4970b2", 4096);
  thread function_238c2a0aae70e973("wall_bottom_moonlight", 0, 0);
  thread function_238c2a0aae70e973("wall_bottom_key", 0, 0);
  thread function_238c2a0aae70e973("wall_bottom_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_rappel_climb_fill", 0.5, 40);
  thread function_238c2a0aae70e973("wall_top_rim", 8, 5);
  thread function_238c2a0aae70e973("wall_top_hang_fill", 8, 30);
  wait 3.8;
  thread function_238c2a0aae70e973("lgt_rappel_climb_red_rim_1", 3, 20);
  thread function_238c2a0aae70e973("lgt_rappel_climb_red_rim_2", 3, 16);
  flag_wait("lgt_wall_point_gun");
  thread function_238c2a0aae70e973("wall_top_fill", 1, 8);
  flag_clear("wall_lightning_5");
  wait 0.5;
  flag_set("sun_castle_top");
  thread function_238c2a0aae70e973("lgt_rappel_climb_rim", 0.1, 0);
  thread function_238c2a0aae70e973("wall_top_rim", 0.1, 0);
  wait 2;
  thread function_238c2a0aae70e973("lgt_rappel_climb_red_rim_1", 0, 0);
  thread function_238c2a0aae70e973("lgt_rappel_climb_red_rim_2", 0, 0);
  thread function_238c2a0aae70e973("wall_top_ai_key", 5, 0);
  thread function_238c2a0aae70e973("wall_top_ai_rim_1", 5, 0);
  flag_wait("lgt_wall_ascend_end");
  set_vision_naked("sp_jup_vip_ext", 2);
  thread function_26280fbed5700639();
  function_598d3d265271bd0c();
  flag_set("flag_roof_lightning");
  level function_bf27c7ad1e422467(0.4);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 5000);
  setsaveddvar(@ "hash_ac413fc6c99ddeeb", 1);
  thread function_a6fea76a4085e5c1();

  if(isplatformxb3() || isplatformps4()) {
    setsuncolorandintensity(0);
  }

  thread function_79294f88498b3155();
}

function function_598d3d265271bd0c() {
  thread function_238c2a0aae70e973("wall_top_fill", 0, 0);
  thread function_238c2a0aae70e973("wall_top_rim", 0, 0);
  thread function_238c2a0aae70e973("wall_top_hang_fill", 0, 0);
  thread function_238c2a0aae70e973("wall_top_key", 0, 0);
  thread function_238c2a0aae70e973("wall_top_rim_after", 5, 23);
  thread function_238c2a0aae70e973("wall_bottom_rim", 0, 0);
  thread function_238c2a0aae70e973("wall_bottom_fill", 0, 0);
  thread function_238c2a0aae70e973("wall_bottom_key", 0, 0);
  thread function_238c2a0aae70e973("wall_top_ai_key", 0, 0);
  thread function_238c2a0aae70e973("wall_top_ai_rim_1", 0, 0);
}

function function_996c7c0ab957b783() {
  flag_wait("lgt_brace_begin");
  level.player thread utility::dof_enable_autofocus(5, level.player, 50, 50, undefined, "j_wrist_le");
  flag_wait("lgt_grab_rappel");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(3, 80, 15, 50);
  flag_wait("lgt_rappel_aim");
  level.player setphysicaldepthoffield(2, 100, 15, 50);
  flag_wait("lgt_wall_ascend_start");
  level.player setphysicaldepthoffield(3, 100, 15, 50);
  wait 3.9;
  level.player setphysicaldepthoffield(5, 15, 15, 50);
  flag_wait("lgt_wall_raise_rappel");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(15, level.player, 10, 10, undefined, "j_wrist_ri");
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 2);
  flag_wait("lgt_wall_ascend_halfway");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(5, 40, 15, 50);
  wait 1;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(15, level.player, 10, 10, undefined, "j_wrist_ri");
  flag_wait("lgt_wall_ascend_top");
  level.player thread utility::dof_enable_autofocus(2, level.ally1, 10, 10, undefined, "j_head");
  flag_wait("lgt_wall_point_gun");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 300, 15, 50);
  wait 6.1;
  level.player setphysicaldepthoffield(3, 80, 15, 50);
  flag_wait("lgt_wall_land");
  level.player setphysicaldepthoffield(10, 50, 15, 50);
  flag_wait("lgt_wall_ascend_end");
  level.player disablephysicaldepthoffieldscripting();
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 0);
}

function function_76507ddfcb2fd56a() {
  flag_wait("lgt_parapet_takedown_start");
  setsaveddvar(@ "sm_sunsamplesizenear", 0.05);
  level.storm.var_39c17e1e440feaf6 = -9;
  level.storm.var_39e4701e443613e4 = -8;
  level.storm.var_857a0339d2aa52 = -22;
  level.storm.var_61840339aa4598 = -21;
  setsaveddvar(@ "hash_1048f749a8b7aa91", 1);
  flag_wait("lgt_parapet_takedown_end");
  setsaveddvar(@ "hash_1048f749a8b7aa91", 0);
  setsaveddvar(@ "sm_sunsamplesizenear", 0.25);
  level.storm.var_39c17e1e440feaf6 = -180;
  level.storm.var_39e4701e443613e4 = 180;
  level.storm.var_857a0339d2aa52 = -85;
  level.storm.var_61840339aa4598 = -45;
}

function function_916337b41b900368() {
  flag_wait("maintenance_lightning_strike");
  level.storm.var_39c17e1e440feaf6 = 115;
  level.storm.var_39e4701e443613e4 = 116;
  level.storm.var_857a0339d2aa52 = -27;
  level.storm.var_61840339aa4598 = -26;
  wait 8;
  level notify("strikeLightning");
  wait 12;
  level.storm.var_39c17e1e440feaf6 = -180;
  level.storm.var_39e4701e443613e4 = 180;
  level.storm.var_857a0339d2aa52 = -85;
  level.storm.var_61840339aa4598 = -45;
  flag_clear("maintenance_lightning_strike");
}

function function_34f4b53af87b69f5() {
  flag_wait("lgt_halflife_liftgrate_start");
  thread function_1be9145b47c4b31d();
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  thread function_735b91a6452f848f();
  thread function_238c2a0aae70e973("halflife_liftgrate_rim", 15, 32);
  thread function_238c2a0aae70e973("halflife_liftgrate_fill", 15, 40);
  flag_wait("lgt_halflife_liftgrate_jump");
  thread function_238c2a0aae70e973("halflife_liftgrate_rim", 0.5, 0);
  thread function_238c2a0aae70e973("halflife_liftgrate_key", 0.5, 0);
  thread function_238c2a0aae70e973("halflife_liftgrate_fill", 0.5, 0);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 0);
  flag_wait("lgt_halflife_liftgrate_end");
  thread function_26280fbed5700639();
  flag_clear("wind_on");
  set_vision_naked("sp_jup_vip_piperoom", 0.2);
  flag_clear("flag_roof_lightning");

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    setsaveddvar(@ "hash_1d03444cd52cc348", 0);
  }

  level function_bf27c7ad1e422467(0.35);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 1000);
  setsaveddvar(@ "hash_5a83a561cb4970b2", 2176);
  wait 0.5;
  lights = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in lights) {
    light setlightintensity(0);
  }

  var_6906a60962d199f0 = getEntArray("helicopter_main_lights", "script_noteworthy");

  foreach(light in var_6906a60962d199f0) {
    light setlightintensity(0);
  }

  setsuncolorandintensity(0);
  wait 0.05;
  liftgrate_lights = getEntArray("liftgrate_lights", "script_noteworthy");

  foreach(light in liftgrate_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off = getEntArray("ext_lights_to_turn_off", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  ext_lights_to_turn_off_2 = getEntArray("ext_lights_to_turn_off_2", "script_noteworthy");

  foreach(light in ext_lights_to_turn_off_2) {
    light setlightintensity(0);
  }
}

function function_735b91a6452f848f() {
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(5, 20, 15, 50);
  flag_wait("lgt_halflife_liftgrate_look_up");
  level.player setphysicaldepthoffield(5, 55, 15, 50);
  flag_wait("lgt_halflife_liftgrate_jump");
  wait 1;
  level.player setphysicaldepthoffield(5, 20, 15, 50);
  flag_wait("lgt_halflife_liftgrate_end");
  level.player disablephysicaldepthoffieldscripting();
}

function function_873d15bd518ed381() {
  flag_wait("lgt_descend_start");
  thread function_61a998996cc98831();
  set_vision_naked("sp_jup_vip_central_shaft_top", 0);
  level.var_ce78d0e4ea4e7d3b = (-5, 0, 0);
  setsaveddvar(@ "hash_3d8207377722f5d7", 32);
  setsaveddvar(@ "hash_243c16e10a38e1a2", 4);
  thread function_238c2a0aae70e973("pipe_vent_light", 15, 0);
  setsaveddvar(@ "hash_351ca4838eccf185", 1);
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", 2, 2);
  thread function_238c2a0aae70e973("court_yard_2_main", 0, 0);
  var_6906a60962d199f0 = getEntArray("helicopter_main_lights", "script_noteworthy");

  foreach(light in var_6906a60962d199f0) {
    light setlightintensity(0);
  }

  flag_set("lgt_descend");
  thread function_65cc9af18f47c8cb();
  thread set_nvg_vision("nvg_base_color_vip_descend");
  setsaveddvar(@ "hash_ac413fc6c99ddeeb", 0.5);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  setsaveddvar(@ "r_spotlightentityshadows", 1);
  setsaveddvar(@ "hash_9ad4a8901f4c0598", 0.07);
  thread function_9160006a3f10b2cd();
  wait 30;
  setsaveddvar(@ "r_spotlightentityshadows", 0);
}

function function_65cc9af18f47c8cb() {
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 20, 5, 5);
  flag_wait("lgt_descend_look_down");
  level.player setphysicaldepthoffield(1, 800, 10, 10);
  flag_wait("lgt_descend_look_up");
  level.player setphysicaldepthoffield(2, 300, 15, 50);
  flag_wait("lgt_descend_end");
  level.player disablephysicaldepthoffieldscripting();
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
}

function function_e460bc303ea00462() {
  flag_wait("lgt_mak_start");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 200);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 2);
  }

  level.player nightvisiongogglesforceoff();
  thread function_1be9145b47c4b31d();
  thread function_84c4c43092e73bac();
  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 32);
  setsaveddvar(@ "hash_eca4b727b01fd254", 3);
  setsaveddvar(@ "hash_93b4b56b615317b9", 300);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 3);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 15);

  if(isplatformxb3() || isplatformps4()) {
    wait 0.1;
    setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  }

  set_vision_naked("sp_jup_vip_reach_vip_cine", 1);
  thread function_238c2a0aae70e973("cin_lgt_opengate_fill", 2, 1);
  thread function_238c2a0aae70e973("cin_lgt_opengate_soldier_fill", 0, 0.8);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_fill", 0, 4);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_key", 0, 8);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_fill_01", 0, 16);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_rim", 0, 16);
  function_1d321dd7f8b825ce("door_flicker", "cellar_door_main_lgt_01");
  thread function_238c2a0aae70e973("cellar_door_main_lgt_01", 0, 0);
  flag_wait("lgt_mak_bomb_preset");
  thread anim_sp::letterbox_enable(1, 1.25);
  flag_wait("lgt_mak_bomb_set");
  thread function_238c2a0aae70e973("cin_lgt_opengate_soldier_fill", 0, 0);
  flag_wait("lgt_mak_explosion");
  wait 1;
  set_vision_naked("sp_jup_vip_reach_vip_cine_blast_01", 0.1);
  thread function_238c2a0aae70e973("cin_lgt_opengate_fill", 0, 0);
  flag_wait("lgt_mak_shot_2");
  setsaveddvar(@ "hash_eca4b727b01fd254", 10);
  set_vision_naked("sp_jup_vip_reach_vip_cine_blast", 0);
  wait 0.3;
  set_vision_naked("sp_jup_vip_reach_vip_cine_blast_01", 0.1);
  wait 0.1;
  set_vision_naked("sp_jup_vip_reach_vip_cine_blast", 2);
  thread function_238c2a0aae70e973("cin_lgt_Makarov_door_blast", 0, 100);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 320);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 50);
  wait 0.5;
  set_vision_naked("sp_jup_vip_reach_vip_cine_vol", 0);
  thread function_238c2a0aae70e973("cin_soldier_fill_shot_2", 0, 4);
  thread function_238c2a0aae70e973("cin_markorov_fill_shot_8", 0, 8);
  thread function_238c2a0aae70e973("makarov_cell_ambient_fill", 0, 2);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_rim", 0, 32);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_rim", 0, 0);
  function_1d321dd7f8b825ce("door_flicker", "cellar_door_main_lgt", 0);
  thread function_238c2a0aae70e973("cin_lgt_Makarov_door_blast", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_opengate_side_fill_01", 0, 0);
  flag_wait("lgt_mak_shot_3");
  set_vision_naked("sp_jup_vip_reach_vip_makarov_closeUp", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 5);
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill", 0, 1);
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_2", 0, 0.4);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_rim", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 0);
  thread function_238c2a0aae70e973("cin_soldier_fill_shot_2", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_fill_shot_8", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 0);
  flag_wait("lgt_mak_cig");
  thread function_238c2a0aae70e973("lgt_mak_closeup_cig", 0.2, 0.15);
  wait 1;
  thread function_238c2a0aae70e973("lgt_mak_closeup_cig", 0.5, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key_01", 0, 320);
  flag_wait("lgt_mak_shot_4");
  set_vision_naked("sp_jup_vip_reach_vip_cine", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 16);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill", 0, 4);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_4_fill", 0, 8);
  thread function_238c2a0aae70e973("cin_markorov_shot_4_numbers", 0, 0.6);
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_2", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 0);
  flag_wait("lgt_mak_shot_5");
  setsaveddvar(@ "hash_eca4b727b01fd254", 10);
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_fill", 0, 4);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_4_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_4_numbers", 0, 0);
  flag_wait("lgt_mak_flare_lights");
  set_vision_naked("sp_jup_vip_reach_vip_cine_flare", 0);
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_ignite", 0.25, 16);
  wait 2;
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_ignite", 0.25, 0);
  flag_wait("lgt_mak_shot_6");
  set_vision_naked("sp_jup_vip_reach_vip_cine_flare", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 10);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key_01", 0, 0);
  flag_wait("lgt_mak_flare_hits_ground");
  set_vision_naked("sp_jup_vip_reach_vip_cine_flare", 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 60);
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_fill", 0, 0);
  thread function_238c2a0aae70e973("makarov_cell_ambient_fill", 0, 0);
  flag_wait("lgt_mak_shot_6_flare");
  function_bb536503bca3484c("flickerflare3", "cin_markorov_flare_face_1");
  flag_wait("lgt_mak_shot_7");
  set_vision_naked("sp_jup_vip_reach_vip_makarov_shot7", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 16);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_shot_7_rim", 0, 3);
  thread function_238c2a0aae70e973("cin_markorov_shot_6_fill", 0, 2);
  thread function_238c2a0aae70e973("cin_markorov_shot_6_face_fill", 0, 0.1);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_eyespec", 0, 0.08);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 0);
  flag_wait("lgt_mak_shot_8");
  set_vision_naked("sp_jup_vip_reach_vip_cine", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 16);
  function_bb536503bca3484c("flickerflare1", "cin_markorov_flare_lgt_3");
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_3", 0, 2);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_bar_rim", 0, 1.6);
  thread function_238c2a0aae70e973("lgt_mak_bed_fill", 0, 24);
  thread function_238c2a0aae70e973("lgt_mak_bed_rim", 0, 8);
  thread function_238c2a0aae70e973("lgt_mak_bed_vol", 0, 20);
  function_1d321dd7f8b825ce("flickerflare3", "cin_markorov_flare_face_1");
  thread function_238c2a0aae70e973("cin_markorov_shot_6_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_shot_7_rim", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_flare_face_1", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_6_face_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_eyespec", 0, 0);
  level waittill("lgt_mak_shot_9");
  function_985b4b064b531836("flare2", "cin_markorov_flare_lgt_2");
  set_vision_naked("sp_jup_vip_reach_vip_cine_soldiers", 0);
  thread function_238c2a0aae70e973("cin_lgt_shot_8_key", 0, 40);
  thread function_238c2a0aae70e973("cin_markorov_fill_shot_8", 0, 8);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 150);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill", 0, 2);
  function_1d321dd7f8b825ce("flickerflare1", "cin_markorov_flare_lgt_3");
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_3", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_bar_rim", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_rim", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_2", 0, 0);
  thread function_238c2a0aae70e973("cine_makarov_cig_lgt_wall_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_vol", 0, 0);
  flag_wait("lgt_mak_shot_10");
  set_vision_naked("sp_jup_vip_reach_vip_cine", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 16);
  function_bb536503bca3484c("flickerflare1", "cin_markorov_flare_lgt_3");
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_3", 0, 1);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_bar_rim", 0, 1.6);
  thread function_238c2a0aae70e973("lgt_mak_bed_fill", 0, 24);
  thread function_238c2a0aae70e973("lgt_mak_bed_rim", 0, 8);
  thread function_238c2a0aae70e973("lgt_mak_bed_vol", 0, 20);
  function_1d321dd7f8b825ce("flare2", "cin_markorov_flare_lgt_2");
  thread function_238c2a0aae70e973("cin_lgt_shot_8_key", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_fill_shot_8", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_2", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key", 0, 0);
  wait 4;
  thread function_238c2a0aae70e973("lgt_mak_bed_vol", 2, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_bar_rim", 1, 0.4);
  flag_wait("lgt_mak_shot_10_situp");
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_3", 2, 0);
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_2", 2, 0.2);
  flag_wait("lgt_mak_shot_11");
  set_vision_naked("sp_jup_vip_reach_vip_cine_walkin", 0);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  thread function_238c2a0aae70e973("lgt_mak_standsup_rim", 0, 20);
  thread function_238c2a0aae70e973("lgt_mak_standsup_mak_face", 0, 5);
  thread function_238c2a0aae70e973("cin_lgt_shot_11_soldier_fill", 0, 20);
  function_bb536503bca3484c("flickerflare", "cin_markorov_flare_walkin");
  thread function_238c2a0aae70e973("lgt_mak_bed_vol_02", 0, 20);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_11_key", 0, 160);
  thread function_238c2a0aae70e973("lgt_mak_standsup_fill", 0, 8);
  thread function_238c2a0aae70e973("lgt_mak_standsup_soldier_red", 0, 8);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 10);
  thread function_238c2a0aae70e973("lgt_mak_standsup_mak_fill", 0, 3);
  function_1d321dd7f8b825ce("flickerflare1", "cin_markorov_flare_lgt_3");
  thread function_238c2a0aae70e973("lgt_mak_closeup_fill_2", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_rim", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_7_bar_rim", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_shot_6_key", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_3", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill", 0, 0);
  thread function_238c2a0aae70e973("cine_makarov_cig_lgt_wall_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_vol", 0, 0);
  flag_wait("lgt_mak_shot_12");
  set_vision_naked("sp_jup_vip_reach_vip_cine_end", 0);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.65);
  setsaveddvar(@ "hash_36561ce503889667", 0.65);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.65);
  thread function_238c2a0aae70e973("cine_makarov_cig_lgt_wall_fill", 0, 0.15);
  thread function_238c2a0aae70e973("cin_lgt_shot_6_key", 0, 200);
  thread function_238c2a0aae70e973("lgt_mak_standsup_rim", 0, 6);
  function_bb536503bca3484c("flickerflare2", "cin_lgt_mak_shot_10_flare");
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 10);
  function_bb536503bca3484c("flickerflare4", "lgt_mak_end_soldier_rim");
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key_01", 0, 300);
  thread function_238c2a0aae70e973("lgt_mak_standsup_mak_face", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_bed_vol_02", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_standsup_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_markorov_shot_6_fill", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_standsup_soldier_red", 0, 0);
  function_1d321dd7f8b825ce("flickerflare", "cin_markorov_flare_walkin", 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_11_key", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_standsup_mak_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_shot_11_soldier_fill", 0, 0);
  function_1d321dd7f8b825ce("door_flicker", "cellar_door_main_lgt", 0);
  flag_wait("lgt_mak_shot_13");
  setsaveddvar(@ "hash_eca4b727b01fd254", 5);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_key_01", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_standsup_rim", 5, 5);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_10_key", 0, 8);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_10_fill", 0, 0.8);
  thread function_238c2a0aae70e973("cin_lgt_shot_6_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 0);
  function_1d321dd7f8b825ce("flickerflare4", "lgt_mak_end_soldier_rim", 0);
  flag_wait("lgt_mak_shot_13_focus");
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_eyespeck", 0.1, 0.02);
  function_1d321dd7f8b825ce("flickerflare2", "cin_lgt_mak_shot_10_flare", 0);
  wait 0.5;
  thread function_238c2a0aae70e973("lgt_mak_standsup_end_rim", 1.5, 1.25);
  thread function_238c2a0aae70e973("lgt_mak_standsup_end_rim_1", 1.5, 5);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_faceblend", 1, 3);
  wait 0.75;
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_eyespeck", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_10_key", 1.75, 0);
  flag_wait("lgt_mak_shot_13_rot");
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  set_vision_naked("sp_jup_vip_reach_vip_makarov_shot7", 1);
  thread function_238c2a0aae70e973("lgt_mak_standsup_end_rim", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_standsup_end_rim_1", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_10_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_10_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_13_key", 0, 200);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_key", 0, 20);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_15_fill", 0, 40);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_faceblend", 1, 0);

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_03", 0, 2);
  }

  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 200);
  function_bb536503bca3484c("flickerflare5", "cin_lgt_mak_shot_13_flare_rot");
  flag_wait("lgt_mak_shot_14");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 50);
  set_vision_naked("sp_jup_vip_reach_vip_makarov_14", 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_15_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_13_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_key", 0, 8);
  thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_03", 0, 40);

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_03", 0, 0);
    thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_rim", 0, 5);
    thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_01", 0, 5);
  }

  wait 2;
  thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_02", 0.5, 16);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_sldr_fill", 1, 0.4);

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_01", 1.5, 0);
  }

  flag_wait("lgt_mak_shot_14_cut");
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_01", 0, 5);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_key", 1, 6);
  thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_02", 0.5, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_15_fill", 2, 30);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_mak_fill", 1, 0.2);
  flag_wait("lgt_mak_shot_14_gun");
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_gun_key", 1, 1.2);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_gun_rim", 1, 0.9);
  flag_wait("lgt_mak_shot_15");
  set_vision_naked("sp_jup_vip_reach_vip_makarov_shot7", 0);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 5);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 200);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_fill_02", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_01", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_sldr_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_gun_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_gun_rim", 0, 0);
  thread function_238c2a0aae70e973("lgt_mak_shot_14_red_rim_03", 0.5, 0);

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_rim", 0, 0);
    thread function_238c2a0aae70e973("cin_lgt_mak_shot_15_red_fill", 0, 20);
  }

  thread function_238c2a0aae70e973("cin_lgt_mak_shot_15_backfill", 0, 8);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_13_key", 0, 150);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_15_rim", 0, 16);
  flag_wait("lgt_mak_shot_16");
  set_vision_naked("sp_jup_vip_reach_vip", 0);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_15_backfill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_13_key", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_15_fill", 0, 10);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_14_mak_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_15_rim", 0, 0);
  function_1d321dd7f8b825ce("flickerflare5", "cin_lgt_mak_shot_13_flare_rot", 0, 0);

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    thread function_238c2a0aae70e973("cin_lgt_mak_shot_15_red_fill", 0, 0);
  }

  thread function_238c2a0aae70e973("cin_lgt_shot_16_door_fill", 0, 1);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_16_face_fill", 0, 2);
  function_985b4b064b531836("door_flicker", "cellar_door_main_lgt_01");
  thread function_238c2a0aae70e973("cellar_door_main_lgt", 0, 4);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_16_key", 0, 160);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_flare_rot_02", 0, 50);
  function_bb536503bca3484c("door_flicker", "cellar_door_main_lgt_01");
  wait 2;
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_16_key", 1, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_13_flare_rot", 0, 0);
  level waittill("lgt_black_bars");
  level thread function_e4cf2932f102d075();
  level.player val::reset_all("scene_shot");
  level.player modifybasefov(65, 2);
  level.player lerpfovscalefactor(1, 2);
  level.player ent_flag_clear("letterbox_enabled");
  hidecinematicletterboxing(0.7, 0);
  flag_wait("lgt_makarov_pcap_complete");
  thread function_238c2a0aae70e973("lgt_mak_standsup_rim", 1, 0);
  thread function_238c2a0aae70e973("cin_lgt_mak_shot_16_face_fill", 1, 0);
  thread function_238c2a0aae70e973("cine_makarov_cig_lgt_wall_fill", 0, 0);
  thread function_238c2a0aae70e973("cin_lgt_breach_door_15_fill", 3, 0);
  thread function_238c2a0aae70e973("cin_markorov_flare_lgt_end", 0, 4);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor", 0, 80);
  thread function_238c2a0aae70e973("cin_lgt_shot_16_door_fill", 0, 8);
  flag_set("delete_descend_lights");
  thread function_68aeea781acf5933();
  lgt_cine_mak_lights = getEntArray("lgt_cine_mak_lights", "script_noteworthy");

  foreach(light in lgt_cine_mak_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }
}

function function_e4cf2932f102d075() {
  animnode = getStruct("scene_vip_0800_reach_makarov_reveal", "targetname");
  level.player setcinematicmotionoverride("disabled");
  level.player showviewmodel();
  ent = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  level.player playerlinkTo(ent, "", 1, 0, 0, 0, 0);
  xcam = "vip_0800_reach_makarov_reveal_sh16_xcam";
  duration = getxcamlength(xcam);
  var_adf0e9db54a43870 = level.player function_89a3566c4c707b11();
  starttime = var_adf0e9db54a43870 * duration;
  ent.origin = level.player getxcamposition(xcam, var_adf0e9db54a43870, 0, animnode.origin, animnode.angles) + (0, 0, -60);
  ent.angles = level.player getxcamangles(xcam, var_adf0e9db54a43870, 0, animnode.origin, animnode.angles);
  endorigin = level.player getxcamposition(xcam, 1, 0, animnode.origin, animnode.angles) + (0, 0, -60);
  endangles = level.player getxcamangles(xcam, 1, 0, animnode.origin, animnode.angles);
  movetime = duration - starttime;
  ent moveTo(endorigin, movetime, 0, movetime);
  ent rotateTo(endangles, movetime, 0, movetime);
  ent waittill("movedone");
}

function function_84c4c43092e73bac() {
  animnode = getStruct("scene_vip_0800_reach_makarov_reveal", "targetname");
  plr_3p = animnode scene::get_entity("plr_3P");
  level.player thread utility::dof_enable_autofocus(15, level.player, 49, 49, undefined, "i_thumb_le_2");
  flag_wait("lgt_mak_bomb_set");
  level.player thread utility::dof_enable_autofocus(22, level.player, 49, 49, undefined, "i_thumb_ri_2");
  flag_wait("lgt_mak_shot_2");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 50, 15, 50);
  wait 3;
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(1, level.ally1, 5, 50);
  flag_wait("lgt_mak_shot_3");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(10, 100, 15, 50);
  flag_wait("lgt_mak_shot_4");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(5, level.ally1, 12, 50);
  flag_wait("lgt_mak_shot_4_numbers");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 111, 5, 50);
  flag_wait("lgt_mak_shot_5");
  level.player setphysicaldepthoffield(6, 41, 5, 50);
  flag_wait("lgt_mak_flare_hits_ground");
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(15, 70, 5, 50);
  flag_wait("lgt_mak_shot_7");
  level.player setphysicaldepthoffield(10, 68, 15, 50);
  flag_wait("lgt_mak_shot_8");
  level.player setphysicaldepthoffield(3, 250, 15, 50);
  level waittill("lgt_mak_shot_9");
  level.player setphysicaldepthoffield(9, 56, 15, 50);
  flag_wait("lgt_mak_shot_10");
  level.player setphysicaldepthoffield(3, 250, 15, 50);
  flag_wait("lgt_mak_shot_11");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(10, level.ally2, 5, 50);
  wait 5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(15, 100, 49, 50);
  flag_wait("lgt_mak_shot_12");
  level.player setphysicaldepthoffield(20, 100, 35, 35);
  wait 3;
  level.player setphysicaldepthoffield(20, 27, 35, 35);
  flag_wait("lgt_mak_shot_13_rot");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_enable_autofocus(20, level.makarov, 40, 40, undefined, "tag_eye");
  flag_wait("lgt_mak_shot_14");
  level.player thread utility::dof_enable_autofocus(22, level.ally1, 49, 49, undefined, "tag_helmetlight");
  flag_wait("lgt_mak_shot_14_gun");
  level.player thread utility::dof_enable_autofocus(15, level.makarov, 40, 40, undefined, "j_wrist_ri");
  flag_wait("lgt_mak_shot_15");
  level.player thread utility::dof_enable_autofocus(15, level.makarov, 40, 40, undefined, "tag_helmetlight");
  flag_wait("lgt_mak_shot_15_close");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(20, 60, 25, 25);
  flag_wait("lgt_mak_shot_16");
  level.player disablephysicaldepthoffieldscripting();
  flag_wait("lgt_makarov_pcap_complete");
  setDvar(@ "hash_93ca035fa3964d3d", 0);
}

function function_3894b687f9e0b4c8() {
  flag_wait("flag_begin_explosions");

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  setsuncolorandintensity(0);
  set_vision_naked("sp_jup_vip_ext_explosion", 0);
  level function_bf27c7ad1e422467(0.4);
  thread function_238c2a0aae70e973("explosion_light", 0, 800);
  lights2 = getEntArray("explosion_off_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }

  thread function_238c2a0aae70e973("court_yard_light_increase_1", 10, 500);
}

function function_f29d0cd9dae6bab4() {
  function_dbec921ed499ee34("firelight_motion_medium", (1, 0.2246, 0), (1, 0.25, 0), 30, 0.05, 0.2, 20);
  function_dbec921ed499ee34("electric_medium", (0, 0.2246, 1), (0, 0.4, 1), 1, 0.05, 0.2, 2);
  function_dbec921ed499ee34("pulse_medium", (0, 1, 0), (0, 0, 1), 1, 0.5, 2, 2);
  function_dbec921ed499ee34("pulse_red", (1, 0, 0), (0, 0, 0), 3, 1.5, 3, 2);
  function_dbec921ed499ee34("pulse_red_dim", (1, 0, 0), (0, 0, 0), 3, 1.5, 3, 2);
  function_bf134e4c6c36436("flicker1", 5, 40, 0.05, 0.15, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker2", 0.05, 0.5, 0.05, 0.25, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker3", 0.05, 0.25, 0.05, 0.3, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker4", 850, 0.5, 0.05, 0.4, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker5", 0.1, 5, 0.01, 0.05, 3, 15, 0.1, 3);
  function_bf134e4c6c36436("flicker6", 0.1, 3.25, 0.05, 0.1, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker7", 0.05, 0.2, 0.05, 0.1, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker8", 0.2, 15, 0.05, 0.1, 3, 7, 0.1, 3);
  function_bf134e4c6c36436("flicker9", 0.2, 7, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flicker10", 0.2, 18, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flicker11", 0.2, 18, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flicker12", 0.005, 0.65, 0.01, 0.05, 3, 15, 0.1, 3);
  function_bf134e4c6c36436("beeping_01", 0.005, 200, 0.01, 0.1, 1, 3, 0.1, 2);
  function_bf134e4c6c36436("flickerflare", 25, 40, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare1", 15, 20, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare2", 2, 4, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare3", 25, 50, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare4", 5, 10, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("flickerflare5", 20, 25, 0.01, 0.02, 40, 50, 0.5, 0.85);
  function_bf134e4c6c36436("door_flicker", 5, 10, 0.01, 0.02, 2, 4, 0.01, 0.02);
  function_dbec921ed499ee34("flare", (1, 0, 0), (0, 0, 0), 3, 0.3, 0.4, 1.5);
  function_dbec921ed499ee34("flare1", (1, 0, 0), (0, 0, 0), 10, 0.3, 0.4, 0.5);
  function_dbec921ed499ee34("flare2", (1, 0, 0), (0, 0, 0), 8, 0.3, 0.4, 0.5);
  function_dbec921ed499ee34("flare3", (1, 0, 0), (0, 0, 0), 20, 0.2, 0.4, 0.5);
  function_dbec921ed499ee34("flare4", (1, 0, 0), (0, 0, 0), 3, 0.3, 0.4, 0.5);
  function_dbec921ed499ee34("flare5", (1, 0, 0), (0, 0, 0), 10, 0.3, 0.4, 0.5);
  function_dbec921ed499ee34("flare6", (1, 0, 0), (0, 0, 0), 1, 0.3, 0.4, 0.5);
  function_dbec921ed499ee34("flare_exil", (1, 0.39, 0.39), (1, 0.39, 0.39), 1000, 0.3, 0.4, 0.5);
}

function play_lights() {
  wait 0.5;
  function_bb536503bca3484c("flicker1", "electric01");
  function_bb536503bca3484c("flicker2", "pulse01");
  function_bb536503bca3484c("flicker3", "fire01");
  function_bb536503bca3484c("flicker4", "electric02");
  function_bb536503bca3484c("flicker5", "pulse02");
  function_bb536503bca3484c("flicker6", "fire02");
  function_bb536503bca3484c("flicker7", "streetlight_coolgreen_small");
  function_bb536503bca3484c("flicker8", "streetlight_coolgreen");
  function_bb536503bca3484c("flicker9", "siren_red");
  function_bb536503bca3484c("flicker10", "police_siren_blue");
  function_bb536503bca3484c("flicker11", "backyardfire_01");
  function_bb536503bca3484c("beeping_01", "red_beeping_01");
  function_bb536503bca3484c("door_flicker", "cellar_door_main_lgt");
  function_bb536503bca3484c("door_flicker", "cellar_door_main_lgt_01");
}

function scuba_lightning() {
  spot = getEnt("Thunder_flash_01", "targetname");
  thread function_238c2a0aae70e973("Thunder_flash_01", 0, 0);
}

function flag_rappel_lightning(targetname) {
  wait 0.15;
  assert(isstring(targetname));
  rappel_strikes = getEntArray(targetname, "targetname");
  flag_wait("flag_rappel_lightning");

  while(flag("flag_rappel_lightning")) {
    foreach(ent in rappel_strikes) {
      wait randomfloatrange(5, 15);
      ent function_94e6538604ee3986("forceshadowon");
      ent setlightintensity(2500);
      earthquake(0.05, 0.5, level.player.origin, 300);
      wait 0.1;
      ent setlightintensity(0);
    }
  }
}

function function_a9d3bae3f8b167a6(targetname) {
  wait 0.15;
  assert(isstring(targetname));
  rappel_strikes = getEntArray(targetname, "targetname");
  flag_wait("flag_rappel_lightning");

  while(flag("flag_rappel_lightning")) {
    foreach(ent in rappel_strikes) {
      ent setlightintensity(800);
      wait randomfloatrange(1, 10);
      ent function_94e6538604ee3986("forceshadowon");
      ent setlightintensity(25000);
      earthquake(0.05, 0.5, level.player.origin, 300);
      wait 0.1;
      ent setlightintensity(800);
      wait randomfloatrange(0.1, 0.3);
      ent setlightintensity(25000);
      earthquake(0.05, 0.5, level.player.origin, 300);
      wait 0.1;
      ent function_94e6538604ee3986("normal");
    }
  }

  foreach(ent in rappel_strikes) {
    ent setlightintensity(200);
  }
}

function function_73d951ad7e0a6224() {
  wait 0.15;
  flag_wait("flag_roof_lightning");
  wait 3;
  level notify("strikeLightning");
  wait randomfloatrange(5, 10);
}

function function_3a9f5efbbf29c878() {
  wait 0.05;
  run_thread_on_targetname("garage_sunmove_lgt_trig", &garage_sunmove_lgt_trig);
}

function garage_sunmove_lgt_trig() {
  while(true) {
    self waittill("trigger");
    flag_set("garage_sun_move");

    while(flag("garage_sun_move")) {
      flag_set("garage_sun_reset");
      setsundirection(anglesToForward((-18, 175.27, 0)));
      setsuncolorandintensity(5);
      earthquake(0.05, 0.5, level.player.origin, 300);
      wait 0.1;
      setsuncolorandintensity(0.12);
      wait 5;
      flag_clear("garage_sun_move");
      setsaveddvar(@ "hash_8667c0bb90c5bfc3", 1500);
    }
  }
}

function function_4a6780176013b74() {
  wait 0.05;
  run_thread_on_targetname("garage_sunreset_lgt_trig", &garage_sunreset_lgt_trig);
}

function garage_sunreset_lgt_trig() {
  while(true) {
    self waittill("trigger");
    flag_clear("garage_sun_move");

    while(flag("garage_sun_reset")) {
      wait randomfloatrange(1, 2);
      setsundirection(anglesToForward((-32, 49.27, 0)));
      setsuncolorandintensity(5);
      earthquake(0.05, 0.5, level.player.origin, 300);
      wait 0.1;
      setsuncolorandintensity(0.12);
      flag_clear("garage_sun_reset");
      wait 5;
    }
  }
}

function lights_out_5() {
  setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.1);
  lights2 = getEntArray("top_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }

  wait 0.5;
  set_vision_naked("sp_jup_vip_central_shaft_dark", 0);
  wait 1;
  setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.9);
}

function function_ea42fd53bd60dc63() {
  set_vision_naked("sp_jup_vip_central_shaft_lights_off", 0.8);
}

function lights_out_4() {
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", 0, 0.1);
  setsaveddvar(@ "hash_351ca4838eccf185", 0);
  lights2 = getEntArray("4th_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }
}

function lights_out_3() {
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", 0.5, 0.1);
  lights2 = getEntArray("3rd_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }
}

function lights_out_2() {
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", 1, 0.1);
  lights2 = getEntArray("2nd_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }
}

function lights_out_1() {
  thread lerp_dvar(@ "hash_def5bdc115ba2abb", 1.5, 0.1);
  lights2 = getEntArray("bttm_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }

  thread function_238c2a0aae70e973("descend_bottom_fills", 0.025, 0);
  var_29b310c42d26af91 = getEntArray("groundfloor_spots", "script_noteworthy");

  foreach(light in var_29b310c42d26af91) {
    light setlightcolor((0.9, 1, 0.9));
    light setlightintensity(0);
  }

  lights = getEntArray("lower_cell_lights", "targetname");

  foreach(light in lights) {
    light setlightintensity(0);
  }
}

function function_1c490662fd0cada2() {
  lights2 = getEntArray("top_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(5);
  }

  var_29b310c42d26af91 = getEntArray("4th_floor_lights", "script_noteworthy");

  foreach(light in var_29b310c42d26af91) {
    light setlightintensity(5);
  }
}

function function_1c490562fd0cab6f() {
  lights2 = getEntArray("2nd_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(5);
  }
}

function function_1c490462fd0ca93c() {
  lights2 = getEntArray("3rd_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(5);
  }
}

function function_1c490362fd0ca709() {
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 600);
  thread function_5a93ff2ef12211db();
  setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.1);
  setsaveddvar(@ "hash_3d8207377722f5d7", 16);
  setsaveddvar(@ "hash_243c16e10a38e1a2", 8);
  lights = getEntArray("lower_cell_lights", "targetname");

  foreach(light in lights) {
    light setlightcolor((0.9, 1, 0.9));
    light setlightintensity(1);
  }

  lights = getEntArray("red_pill_bulb_lgt", "targetname");

  foreach(light in lights) {
    light setlightintensity(0.5);
  }

  var_29b310c42d26af91 = getEntArray("groundfloor_spots", "script_noteworthy");

  foreach(light in var_29b310c42d26af91) {
    light setlightcolor((0.9, 1, 0.9));
    light setlightintensity(70);
  }

  thread function_238c2a0aae70e973("red_hall_spot_01", 0.025, 10);
  thread function_238c2a0aae70e973("red_hall_spot_01_riot", 0.025, 200);
  wait 0.05;
  set_vision_naked("sp_jup_vip_central_shaft", 0.8);
  setsaveddvar(@ "hash_9ad4a8901f4c0598", 0.04);
}

function function_4769444d9a7f7fe3() {
  thread function_238c2a0aae70e973("red_cell_lights_2F", 0.025, 0.065);
  thread function_238c2a0aae70e973("red_cell_lightbulb_2F", 0.025, 0.001);
  thread function_238c2a0aae70e973("red_cell_lights_3F", 0.025, 0.065);
  thread function_238c2a0aae70e973("red_cell_lightbulb_3F", 0.025, 0.001);
  thread function_238c2a0aae70e973("red_cell_lights", 0.025, 0.065);
  thread function_238c2a0aae70e973("red_cell_lightbulb", 0.025, 0.001);
}

function function_8c23ebaac68c22c7() {
  thread function_238c2a0aae70e973("red_cell_lights_2F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lightbulb_2F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lights_3F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lightbulb_3F", 0.025, 0);
}

function function_e70a70564550a33e() {
  thread function_238c2a0aae70e973("red_cell_lights_2F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lightbulb_2F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lights_3F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lightbulb_3F", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lights", 0.025, 0);
  thread function_238c2a0aae70e973("red_cell_lightbulb", 0.025, 0);
}

function function_e6315ae113fcbc87() {
  level.storm = spawnStruct();
  level.storm.var_a6a6742af38e5e03 = function_ea2c8d4f46f1c8c0()[3];
  level.storm.var_7d0e812e8cf767d9 = anglesToForward(function_8410baeceb657ca3());
  level.storm.var_719d13bd0372d164 = 10000;
  level.storm.var_7977f13ebf43144a = 15000;
  level.storm.var_3acf398bd716533e = 0.5;
  level.storm.var_d9f5286110bcca20 = 2;
  level.storm.var_d9d13e6110947fca = 6;
  level.storm.var_79d238eb8500f0fe = 0.05;
  level.storm.var_79af4aeb84dad0dc = 0.5;
  level.storm.var_b175095c56db53f2 = 0.07;
  level.storm.var_b152135c56b52238 = 0.15;
  level.storm.var_912842520406540d = 0.07;
  level.storm.var_91052c5203dfdbf3 = 0.2;
  level.storm.var_a519ed3d3f91ed51 = 0.5;
  level.storm.var_a53cff3d3fb85c9f = 1.5;
  level.storm.var_f516bed4300f6e70 = (0.92, 0.94, 1);
  level.storm.var_f516c1d4300f7509 = (0.96, 0.98, 1);
  level.storm.var_1bbaabce0384f51d = 1;
  level.storm.var_1b96b5ce035c9063 = 10;
  level.storm.var_102c67162b8f8b20 = 2;
  level.storm.var_10087d162b6740ca = 20;
  level.storm.var_fecdc4332e39b67 = 10;
  level.storm.var_857a0339d2aa52 = -85;
  level.storm.var_61840339aa4598 = -45;
  level.storm.var_39c17e1e440feaf6 = -180;
  level.storm.var_39e4701e443613e4 = 180;
}

function function_b4e307f11db183af() {
  function_e6315ae113fcbc87();
  function_fb3603eec8fd6c94(0);
  function_26fc73f5366f147b(0);
  function_a535ef5c75ea8a5f();
  var_54a20e4ff6156818 = 1;
  wait var_54a20e4ff6156818;

  while(true) {
    while(!function_75379624055693d0()) {
      waitframe();
    }

    function_30919f9d32e03e65();
    var_c17b35846edc1c62 = randomfloatrange(level.storm.var_719d13bd0372d164, level.storm.var_7977f13ebf43144a);
    var_c0bd71e7987170bf = gettime() + var_c17b35846edc1c62;
    var_5e5b72e0d3fda1ea = 0;
    var_1afca4a7180bacc2 = 500;
    var_1b71adb5dd5f240c = 0;

    while(true) {
      currenttime = gettime();

      if(currenttime >= var_c0bd71e7987170bf) {
        break;
      }

      if(level.player playerads() == 1 && !var_5e5b72e0d3fda1ea) {
        if(!var_1b71adb5dd5f240c) {
          var_1b71adb5dd5f240c = gettime();
        }

        if(gettime() >= var_1b71adb5dd5f240c + var_1afca4a7180bacc2) {
          var_c0bd71e7987170bf = currenttime + (var_c0bd71e7987170bf - currenttime) * level.storm.var_3acf398bd716533e;
          var_5e5b72e0d3fda1ea = 1;
        }
      } else {
        var_1b71adb5dd5f240c = 0;
      }

      waitframe();
    }
  }
}

function function_75379624055693d0() {
  return level.storm.var_e7326b0ad1d80966;
}

function function_fb3603eec8fd6c94(boolean) {
  level.storm.var_e7326b0ad1d80966 = boolean;
}

function function_26fc73f5366f147b(boolean) {
  level.storm.var_af21a0fb8d001897 = boolean;
}

function function_1361b2552037860e() {}

function function_a535ef5c75ea8a5f() {}

function function_3cb7812f03ad260() {
  output = 0;

  if(randomfloat(100) < level.storm.var_fecdc4332e39b67) {
    output = randomfloatrange(level.storm.var_102c67162b8f8b20, level.storm.var_10087d162b6740ca);
  } else {
    output = randomfloatrange(level.storm.var_1bbaabce0384f51d, level.storm.var_1b96b5ce035c9063);
  }

  return output;
}

function function_7301b0091a829823() {
  pitch = randomfloatrange(level.storm.var_857a0339d2aa52, level.storm.var_61840339aa4598);
  heading = randomfloatrange(level.storm.var_39c17e1e440feaf6, level.storm.var_39e4701e443613e4);
  return (pitch, heading, 0);
}

function function_36552610035fd32e(var_28f8f8b442df4f9e, var_39d209c4a94dfabb, duration) {
  var_753d68ba27e6eddc = var_28f8f8b442df4f9e;
  var_70f0b7676ad5912d = var_753d68ba27e6eddc;
  range = var_39d209c4a94dfabb - var_753d68ba27e6eddc;
  count = int(duration / 0.05);

  if(count > 0) {
    delta = range / count;

    while(count) {
      var_70f0b7676ad5912d = max(var_70f0b7676ad5912d + delta, 0);
      setsuncolorandintensity(var_70f0b7676ad5912d);
      wait 0.05;
      count--;
    }
  }

  setsuncolorandintensity(var_39d209c4a94dfabb);
}

function function_2efb9a617d726a56(light, var_39d209c4a94dfabb, duration) {
  var_753d68ba27e6eddc = light getlightintensity();
  var_70f0b7676ad5912d = var_753d68ba27e6eddc;
  range = var_39d209c4a94dfabb - var_753d68ba27e6eddc;
  count = int(duration / 0.05);

  if(count > 0) {
    delta = range / count;

    while(count) {
      var_70f0b7676ad5912d = max(var_70f0b7676ad5912d + delta, 0);
      light setlightintensity(var_70f0b7676ad5912d);
      wait 0.05;
      count--;
    }
  }

  light setlightintensity(var_39d209c4a94dfabb);
}

function function_d9a2957b1f46532d(var_694ddd5e1ce6d4d) {
  exploder("storm_lightning_" + randomint(var_694ddd5e1ce6d4d));
}

function function_d323aab6b1ed931d() {
  return getEntArray("level_stormLightningLight", "targetname");
}

function function_d36dd41938d97870() {
  random_f = randomfloat(1);
  return vectorlerp(level.storm.var_f516bed4300f6e70, level.storm.var_f516c1d4300f7509, random_f);
}

function function_3c9bbfe6f8ba5021(min_val, max_val) {
  level.storm.var_857a0339d2aa52 = min_val;
  level.storm.var_61840339aa4598 = max_val;
}

function function_732db4c97ee906cc(min_val, max_val) {
  level.storm.var_b175095c56db53f2 = min_val;
  level.storm.var_b152135c56b52238 = max_val;
}

function function_f6b868bf207376e1(min_val, max_val) {
  level.storm.var_912842520406540d = min_val;
  level.storm.var_91052c5203dfdbf3 = max_val;
}

function function_95811a0c0820b3e4(val_min, val_max, var_6ccb5ae5a741f7c2, var_6ca844e5a71b7fa8) {
  level.storm.var_1bbaabce0384f51d = val_min;
  level.storm.var_1b96b5ce035c9063 = val_max;

  if(isDefined(var_6ccb5ae5a741f7c2) && isDefined(var_6ca844e5a71b7fa8)) {
    level.storm.var_102c67162b8f8b20 = var_6ccb5ae5a741f7c2;
    level.storm.var_10087d162b6740ca = var_6ca844e5a71b7fa8;
  }
}

function function_4b391d14abff3ffa(min_val, max_val) {
  level.storm.var_719d13bd0372d164 = min_val;
  level.storm.var_7977f13ebf43144a = max_val;
}

function sun_castle_btm() {
  flag_wait("sun_castle_btm");
  setsundirection(anglesToForward((-71, -20, 0)));
  setsuncolorandintensity(0.3);
  flag_wait("sun_castle_top");
  setsundirection(anglesToForward((-16, 41.27, 0)));
  setsuncolorandintensity(0.12);
  wait 0.05;
}

function function_30919f9d32e03e65(var_c2a989438eb8d070, var_9c3d7716a239b594) {
  var_3f54399adf1186fd = function_ea2c8d4f46f1c8c0()[3];
  var_5ad39406be255956 = anglesToForward(function_8410baeceb657ca3());
  function_26fc73f5366f147b(1);
  var_e7ba2183e71ddc27 = level.visionnakeddefault;

  if(!isDefined(var_c2a989438eb8d070)) {
    var_c2a989438eb8d070 = randomintrange(level.storm.var_d9f5286110bcca20, level.storm.var_d9d13e6110947fca);
  }

  for(index = 0; index < var_c2a989438eb8d070; index++) {
    var_4a206f225167fa98 = randomfloatrange(level.storm.var_b175095c56db53f2, level.storm.var_b152135c56b52238);

    if(index == 0) {
      exploder("fx_lightning");
    }

    var_120f4cf87856a0ac = function_7301b0091a829823();
    setsundirection(anglesToForward(var_120f4cf87856a0ac));
    var_f0ee6aaae740c473 = function_d36dd41938d97870();
    setsuncolorandintensity(var_f0ee6aaae740c473[0], var_f0ee6aaae740c473[1], var_f0ee6aaae740c473[2]);
    var_39d209c4a94dfabb = function_3cb7812f03ad260();
    function_36552610035fd32e(var_3f54399adf1186fd, var_39d209c4a94dfabb, var_4a206f225167fa98);
    choices = ["sp_jup_vip_intro_bright", "sp_jup_vip_intro_bright2", "sp_jup_vip_intro_bright3"];
    var_10a442ef2940b545 = random(choices);

    if(flag("wall_lightning_5")) {
      set_vision_naked("sp_jup_vip_intro_bright5", 0.05);
    } else if(randomfloat(level.storm.var_39e4701e443613e4) < 80 && randomfloat(level.storm.var_39c17e1e440feaf6) > -60) {
      if(flag("lgt_intro_1st_shot")) {
        set_vision_naked("sp_jup_vip_intro_bright4", 0.05);
      } else {
        set_vision_naked("sp_jup_vip_intro_bright2", 0.05);
      }
    } else {
      set_vision_naked(var_10a442ef2940b545, 0.05);
    }

    var_e59fab0769b8cf05 = randomfloatrange(level.storm.var_912842520406540d, level.storm.var_91052c5203dfdbf3);
    function_36552610035fd32e(var_39d209c4a94dfabb, var_3f54399adf1186fd, var_e59fab0769b8cf05);
    set_vision_naked(var_e7ba2183e71ddc27, 0.05);
    setsundirection(var_5ad39406be255956);
    var_f91455db29c90fa8 = index == var_c2a989438eb8d070 - 1;

    if(var_f91455db29c90fa8) {
      break;
    }

    var_e5397163769189b3 = randomfloatrange(level.storm.var_79d238eb8500f0fe, level.storm.var_79af4aeb84dad0dc);
    wait var_e5397163769189b3;
  }

  wait randomfloatrange(level.storm.var_a519ed3d3f91ed51, level.storm.var_a53cff3d3fb85c9f);

  if(isDefined(var_9c3d7716a239b594) && isarray(var_9c3d7716a239b594)) {
    var_a5f1cae34be24ee3 = randomint(var_9c3d7716a239b594.size);
    var_5cf8f3e35358fabf = var_9c3d7716a239b594[var_a5f1cae34be24ee3];
    thread play_sound_in_space(var_5cf8f3e35358fabf, (0, 0, 0));
    var_d16e38e18badf9cf = lookupsoundlength(var_5cf8f3e35358fabf) * 0.001;
    wait var_d16e38e18badf9cf;
  }

  level notify("level_stormLightningThunderComplete");
  setsaveddvar(@ "hash_4d57c3ba2b8e27d6", 0.95);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  function_26fc73f5366f147b(0);
}

function function_421b2eddef2ce150() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    return;
  }

  while(true) {
    level waittill("strikeLightning");
    function_30919f9d32e03e65();
  }
}

function flow_lightning() {
  wait 0.05;
  run_thread_on_targetname("lightning_trig", &lightning_trig);
}

function lightning_trig() {
  while(true) {
    self waittill("trigger");
    level.storm.var_39c17e1e440feaf6 = 10;
    level.storm.var_39e4701e443613e4 = 11;
    level notify("strikeLightning");
    wait randomfloatrange(2, 6);

    while(level.player istouching(self)) {
      wait 0.05;
    }

    level.storm.var_39c17e1e440feaf6 = -180;
    level.storm.var_39e4701e443613e4 = 180;
  }
}

function function_b8dadedcbfbc2f23() {
  wait 0.05;
  run_thread_on_targetname("lightning_flash_05_trig", &function_7da2c64efc0b5dee);
}

function function_7da2c64efc0b5dee() {
  self waittill("trigger");
  level notify("strikeLightning");

  if(isDefined(self.script_parameters)) {
    sunangles = strtok(self.script_parameters, " ");
    level.storm.var_39c17e1e440feaf6 = float(sunangles[0]);
    level.storm.var_39e4701e443613e4 = float(sunangles[1]);
  }

  wait randomfloatrange(5, 15);

  while(level.player istouching(self)) {
    wait 0.05;
  }

  level.storm.var_39c17e1e440feaf6 = -180;
  level.storm.var_39e4701e443613e4 = 180;
}

function function_4450cdf9ea494c76() {
  wait 0.05;
  run_thread_on_targetname("lightning_escape_trig", &lightning_escape_trig);
}

function lightning_escape_trig() {
  self waittill("trigger");
  level.storm.var_39c17e1e440feaf6 = 60;
  level.storm.var_39e4701e443613e4 = 61;
  level.storm.var_d9f5286110bcca20 = 2;
  level.storm.var_d9d13e6110947fca = 3;
  wait 1;

  while(level.player istouching(self)) {
    wait 0.05;
  }

  level.storm.var_39c17e1e440feaf6 = -180;
  level.storm.var_39e4701e443613e4 = 180;
  level.storm.var_d9f5286110bcca20 = 2;
  level.storm.var_d9d13e6110947fca = 6;
  setsundirection(anglesToForward((-39, 60, 0)));
  setsuncolorandintensity(0.6);
}

function function_8d3ebbf2a1a2d301() {
  fakeplayer = level.fakeplayer;
  fakeplayer.water_tag = spawn_tag_origin();
  fakeplayer.water_tag show();
  water_tag = fakeplayer.water_tag;
  water_tag linkTo(fakeplayer, "tag_flash", (-30, 20, -12), (0, 0, 0), 0);
  playFXOnTag(level._effect["vfx_light_underwater_vol"], water_tag, "tag_origin");
  level waittill("cine_intro_end");
  killfxontag(level._effect["vfx_light_underwater_vol"], water_tag, "tag_origin");
  water_tag delete();
  player = level.player;
  player.water_tag = spawn_tag_origin();
  player.water_tag show();
  water_tag = player.water_tag;
  water_tag linktoplayerview(player, "j_dpv", (10, 4, -10), (0, 0, 0), 0);
  playFXOnTag(level._effect["vfx_light_underwater"], water_tag, "tag_origin");
}

function function_91684a8276eb067e() {
  wait 2;
  player = level.player;

  if(isDefined(player.water_tag)) {
    killfxontag(level._effect["vfx_light_underwater"], player.water_tag, "tag_origin");
    player.water_tag linkTo(player, "TAG_ACCESSORY_LEFT", (0, 0, 0), (0, 0, 0), 0);
    playFXOnTag(level._effect["vfx_vip_dpv_light_ally_bright"], player.water_tag, "tag_origin");
  }
}

function function_bfbba57c24d8bf2f() {
  player = level.player;

  if(isDefined(player.water_tag)) {
    killfxontag(level._effect["vfx_vip_dpv_light_ally_bright"], player.water_tag, "tag_origin");
    player.water_tag delete();
  }
}

function function_9a005628dc3cf8e2() {
  animnode = getStruct("vip_0160_scuba_emerge", "targetname");
  var_2931ea04151e190f = undefined;

  while(!isDefined(var_2931ea04151e190f)) {
    var_2931ea04151e190f = animnode scene::get_entity("Prop 7");
    waitframe();
  }

  var_2931ea04151e190f.water_tag = spawn_tag_origin();
  var_2931ea04151e190f.water_tag show();
  var_2931ea04151e190f.water_tag linkTo(var_2931ea04151e190f, "tag_dpv_light", (0, 0, 0), (0, 0, 0), 0);
  playFXOnTag(level._effect["vfx_light_underwater"], var_2931ea04151e190f.water_tag, "tag_origin");
  flag_wait("lgt_emerge_swim_end");
  wait 2;
  killfxontag(getfx("vfx_light_underwater"), var_2931ea04151e190f.water_tag, "tag_origin");
}

function function_346b41f230343453() {
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 3);
  animnode = getStruct("scene_vip_0000_intro", "targetname");
  var_e86b25000c0fb10e = getStruct("scene_vip_0001_intro", "targetname");
  ally1 = level.ally1;
  ally2 = level.ally2;
  ally1.var_90434866328b3744 = spawn_tag_origin();
  ally1.var_90434866328b3744 show();
  ally2.var_90434866328b3744 = spawn_tag_origin();
  ally2.var_90434866328b3744 show();
  ally1.var_90434866328b3744 linkTo(ally1, "tag_accessory_right", (0, 0, 0), (0, 0, 0), 0);
  ally2.var_90434866328b3744 linkTo(ally2, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 0);
  var_148062269544a623 = var_e86b25000c0fb10e scene::get_entity("ally1");
  var_dc6e89e2d0743120 = var_e86b25000c0fb10e scene::get_entity("ally2");
  var_120270b0cfc78cda = var_e86b25000c0fb10e scene::get_entity("FakePlayer");
  player = var_120270b0cfc78cda;
  level.fakeplayer = var_120270b0cfc78cda;
  player.var_90434866328b3744 = spawn_tag_origin();
  player.var_90434866328b3744 show();
  player.var_90434866328b3744 linkTo(player, "tag_accessory_right", (0, 0, 0), (0, 0, 0), 0);
  var_e86b25000c0fb10e scene::function_8207074e79f22926(var_120270b0cfc78cda, "player_glowsticks_on", "FakePlayer");
  var_e86b25000c0fb10e scene::function_8207074e79f22926(var_148062269544a623, "ally1_glowstick_on", "ally1");
  var_e86b25000c0fb10e scene::function_8207074e79f22926(var_dc6e89e2d0743120, "ally2_glowstick_on", "ally2");
  var_e86b25000c0fb10e scene::function_8207074e79f22926(level.player, "fov_start_90_1", "level.player_rig");
  var_efbfff0726c683b0 = var_e86b25000c0fb10e scene::get_entity("Prop 10");
  ally1_glowstick_on = var_e86b25000c0fb10e scene::get_entity("Prop 7");
  var_a75b3906f1c3367b = var_e86b25000c0fb10e scene::get_entity("Prop 16");
  var_e3bb812f6073a78d = var_e86b25000c0fb10e scene::get_entity("Prop 12");
  ally2_glowstick_on = var_e86b25000c0fb10e scene::get_entity("Prop 9");
  var_2c78472f95d7c18e = var_e86b25000c0fb10e scene::get_entity("Prop 18");
  var_8fa31955e3b7a652 = var_e86b25000c0fb10e scene::get_entity("Prop 11");
  var_948a093a5ae43398 = var_e86b25000c0fb10e scene::get_entity("Prop 8");
  var_f64043562f527791 = var_e86b25000c0fb10e scene::get_entity("Prop 17");
  var_148062269544a623 waittill("ally1_glowstick_on");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_r_bright"), ally1.var_90434866328b3744, "tag_origin");
  var_dc6e89e2d0743120 waittill("ally2_glowstick_on");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_r_dim"), ally2.var_90434866328b3744, "tag_origin");
  var_120270b0cfc78cda waittill("player_glowsticks_on");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_player_cine"), player.var_90434866328b3744, "tag_origin");
  wait 1;
  var_f64043562f527791 hide();
  var_948a093a5ae43398 show();
  level waittill("cine_intro_shake_on");
  ally2_glowstick_on show();
  killfxontag(getfx("vfx_vip_glowstick_glow_red_r_dim"), ally2.var_90434866328b3744, "tag_origin");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_r_bright"), ally2.var_90434866328b3744, "tag_origin");
  level waittill("cine_intro_shake_off");
  var_2c78472f95d7c18e show();
  killfxontag(getfx("vfx_vip_glowstick_glow_red_r_bright"), ally2.var_90434866328b3744, "tag_origin");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_r_dim"), ally2.var_90434866328b3744, "tag_origin");
  level waittill("cine_intro_shake_on");
  ally2_glowstick_on show();
  killfxontag(getfx("vfx_vip_glowstick_glow_red_r_dim"), ally2.var_90434866328b3744, "tag_origin");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_r_bright"), ally2.var_90434866328b3744, "tag_origin");
  flag_wait("flag_ally2_glowstick_attach");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red"), ally2.var_90434866328b3744, "tag_origin");
  wait 0.75;
  killfxontag(getfx("vfx_vip_glowstick_glow_red_r_bright"), ally2.var_90434866328b3744, "tag_origin");
  killfxontag(getfx("vfx_vip_glowstick_glow_red_r_bright"), ally1.var_90434866328b3744, "tag_origin");
  playFXOnTag(getfx("vfx_vip_glowstick_glow_red_r"), ally1.var_90434866328b3744, "tag_origin");
  level waittill("cine_intro_end");
  killfxontag(getfx("vfx_vip_glowstick_glow_red_player_cine"), player.var_90434866328b3744, "tag_origin");
  wait 3;
  level.scuba_mask show();
  flag_wait("lgt_emerge_start");
}

function function_4ed1808a09513c95() {
  player = level.player;

  if(isDefined(player.var_90434866328b3744)) {
    killfxontag(getfx("vfx_vip_glowstick_glow_red_r"), player.var_90434866328b3744, "tag_origin");
    player.var_90434866328b3744 delete();
  }
}

function function_47db9742d70b9a0d() {
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  ally1 = level.ally1;
  ally2 = level.ally2;

  if(isDefined(ally1.var_90434866328b3744)) {
    killfxontag(getfx("vfx_vip_glowstick_glow_red"), ally1.var_90434866328b3744, "tag_origin");
    ally1.var_90434866328b3744 delete();
  }

  if(isDefined(ally2.var_90434866328b3744)) {
    killfxontag(getfx("vfx_vip_glowstick_glow_red_r"), ally2.var_90434866328b3744, "tag_origin");
    ally2.var_90434866328b3744 delete();
  }
}

function function_f59833fb6c570028() {
  ally1 = level.ally1;
  ally2 = level.ally2;
  ally1.var_e65de8b99eb642da = spawn_tag_origin();
  ally1.var_e65de8b99eb642da show();
  ally2.var_e65de8b99eb642da = spawn_tag_origin();
  ally2.var_e65de8b99eb642da show();
  ally1.var_e65de8b99eb642da linkTo(ally1, "j_gun", (15, -2, -8), (0, 0, 0));
  ally2.var_e65de8b99eb642da linkTo(ally2, "j_gun", (15, -2, -8), (0, 0, 0));
  playFXOnTag(level._effect["vfx_vip_dpv_light_ally"], ally1.var_e65de8b99eb642da, "tag_origin");
  playFXOnTag(level._effect["vfx_vip_dpv_light_ally"], ally2.var_e65de8b99eb642da, "tag_origin");
}

function function_df00af6e14e227ad() {
  ally1 = level.ally1;
  ally2 = level.ally2;

  if(isDefined(ally1.var_e65de8b99eb642da)) {
    killfxontag(level._effect["vfx_vip_dpv_light_ally"], ally1.var_e65de8b99eb642da, "tag_origin");
    ally1.var_e65de8b99eb642da linkTo(ally1, "j_gun", (15, -2, -8), (0, 0, 0));
    playFXOnTag(level._effect["vfx_vip_dpv_light_ally_bright"], ally1.var_e65de8b99eb642da, "tag_origin");
  }

  if(isDefined(ally2.var_e65de8b99eb642da)) {
    killfxontag(level._effect["vfx_vip_dpv_light_ally"], ally2.var_e65de8b99eb642da, "tag_origin");
    ally2.var_e65de8b99eb642da linkTo(ally2, "j_gun", (15, -2, -8), (0, 0, 0));
    playFXOnTag(level._effect["vfx_vip_dpv_light_ally_bright"], ally2.var_e65de8b99eb642da, "tag_origin");
  }
}

function function_2369ab2349b02a8e() {
  ally1 = level.ally1;
  ally2 = level.ally2;

  if(isDefined(ally1.var_e65de8b99eb642da)) {
    killfxontag(level._effect["vfx_vip_dpv_light_ally_bright"], ally1.var_e65de8b99eb642da, "tag_origin");
    waitframe();
    ally1.var_e65de8b99eb642da delete();
  }

  wait 0.5;

  if(isDefined(ally2.var_e65de8b99eb642da)) {
    killfxontag(level._effect["vfx_vip_dpv_light_ally_bright"], ally2.var_e65de8b99eb642da, "tag_origin");
    waitframe();
    ally2.var_e65de8b99eb642da delete();
  }
}

function function_351de5e184a832() {
  wait 0.1;
  lights = getEntArray("descend_blinking_fixture", "script_noteworthy");

  foreach(light in lights) {
    light setscriptablepartstate("light_part", "off");
  }
}

function function_5a93ff2ef12211db() {
  if(isplatformxb3() || isplatformps4()) {}

  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  lights = getEntArray("lgt_pingpong_3", "targetname");
  lights2 = getEntArray("lgt_pingpong_3_int", "targetname");
  fx = "vfx_vip_flare_alarm_light_01";

  while(true) {
    if(!flag("delete_descend_lights")) {
      thread function_238c2a0aae70e973("lgt_pingpong_3", 0.05, 100);
      thread function_238c2a0aae70e973("lgt_pingpong_3_int", 0.05, 20);

      foreach(ent in lights) {
        playFX(getfx(fx), ent.origin, anglesToForward(ent.angles));

        if(isDefined(ent.target)) {
          target_ent = getEnt(ent.target, "targetname");

          if(isDefined(target_ent) && target_ent.classname == "light") {
            playFX(getfx(fx), target_ent.origin, anglesToForward(target_ent.angles));
          }
        }
      }

      foreach(ent in lights2) {
        playFX(getfx(fx), ent.origin, anglesToForward(ent.angles));

        if(isDefined(ent.target)) {
          target_ent = getEnt(ent.target, "targetname");

          if(isDefined(target_ent) && target_ent.classname == "light") {
            playFX(getfx(fx), target_ent.origin, anglesToForward(target_ent.angles));
          }
        }
      }

      wait 0.1;
      thread function_238c2a0aae70e973("lgt_pingpong_3", 0.2, 0);
      thread function_238c2a0aae70e973("lgt_pingpong_3_int", 0.2, 0);
      wait 1.25;
    }

    waitframe();
  }
}

function function_c78e7f2b4d739175() {
  wait 0.1;
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  door = getEnt("reachvip_dungeondoor_right", "targetname");
  lights = getEntArray("lgt_pingpong_3", "targetname");
  ents = sortbydistance(lights, door.origin);
  var_1eea4cad3d06febb = 1;

  while(true) {
    thread function_d8dc18179bcafb5e(0, ents[0], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(0.5, ents[1], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(1, ents[2], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(1.5, ents[3], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(2, ents[4], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(2.5, ents[5], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(3, ents[6], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(3.5, ents[7], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(4, ents[8], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(4.5, ents[9], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(5, ents[10], 0.5, "vfx_vip_flare_alarm_light_01");
    thread function_d8dc18179bcafb5e(5.5, ents[11], 0.5, "vfx_vip_flare_alarm_light_01");
    wait 3;
  }
}

function function_d8dc18179bcafb5e(on_delay, ent, on_duration, fx) {
  thread function_57e5b8e4ac029421(on_delay, ent, on_duration);
  playFX(getfx(fx), ent.origin, anglesToForward(ent.angles));

  if(isDefined(ent.target)) {
    target_ent = getEnt(ent.target, "targetname");

    if(isDefined(target_ent) && target_ent.classname == "light") {
      playFX(getfx(fx), target_ent.origin, anglesToForward(target_ent.angles));
    }
  }
}

function function_57e5b8e4ac029421(on_delay, ent, on_duration) {
  wait on_delay;
  var_c82eabb722c361a7 = 0.05;
  flickerpercentage = randomfloatrange(0, 1);
  thread lerp_spot_intensity_manage(ent, var_c82eabb722c361a7, 1600, flickerpercentage);
  wait 0.1;
  var_cec49f1254ec4d98 = 0.05;
  flickerpercentage = randomfloatrange(0, 1);
  thread lerp_spot_intensity_manage(ent, var_cec49f1254ec4d98, 0, flickerpercentage);
}

function function_54878a661201ffa() {
  wait 0.15;
  all_lights = [];
  ents1 = getEntArray("red_wall_spots", "targetname");
  ents2 = getEntArray("red_wall_omnis", "targetname");
  var_f90821454418f061 = getEntArray("lgt_rappel_climb_key", "targetname");
  var_f90820454418ee2e = getEntArray("lgt_rappel_climb_fill", "targetname");
  var_3ad387c442544c3e = array_combine(ents1, ents2, var_f90821454418f061, var_f90820454418ee2e);

  foreach(light in var_3ad387c442544c3e) {
    light thread blink_light(0.1, 1.5, 1, 0.5, 0.75, 20);
  }

  flag_wait("lgt_wall_ascend_start");

  foreach(light in var_3ad387c442544c3e) {
    light notify("kill_flicker");
  }

  flag_wait("lgt_wall_red_flash_1");

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(100);
  }

  wait 0.5;

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(0);
  }

  flag_wait("lgt_wall_red_flash_2");

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(100);
  }

  wait 0.5;

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(0);
  }

  flag_wait("lgt_wall_red_flash_3");

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(400);
  }

  wait 0.5;

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(0);
  }

  flag_wait("lgt_wall_red_flash_4");

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(400);
  }

  wait 0.5;

  foreach(light in var_3ad387c442544c3e) {
    light setlightintensity(0);
  }

  flag_wait("lgt_wall_land");

  foreach(light in var_3ad387c442544c3e) {
    light notify("kill_flicker");
  }
}

function function_6030abe810f0150f() {
  spots = getEntArray("red_wall_spots", "targetname");

  foreach(light in spots) {
    light setlightintensity(0);
  }

  thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
  wait 2;
  thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
  wait 3;
  thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
  wait 2;
  thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
  wait 3;
  thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
  wait 2;
  thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
  wait 3;
  thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
  wait 2;
  thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
  wait 3;
  thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
  wait 2;
  thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
  wait 3;
  thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
  wait 2;
  thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
  wait 0.05;
  flag_wait("lgt_intro_2nd_shot");

  foreach(light in spots) {
    light notify("kill_flicker");
  }
}

function function_f2cb32d3b862bcc4() {
  spots = getEntArray("red_wall_spots", "targetname");

  foreach(light in spots) {
    light setlightintensity(0);
  }

  for(;;) {
    thread function_238c2a0aae70e973("red_wall_omnis", 0, 1.75);
    wait 2;
    thread function_238c2a0aae70e973("red_wall_omnis", 2, 0);
    wait 3;
  }
}

function function_583ee0a8609a6ee2() {
  flag_wait("flag_start_third_scenario");
  thread function_238c2a0aae70e973("descend_bottom_fills", 3, 16);
}

function function_153f33f5dedc86a7() {
  for(;;) {
    level waittill("lgt_control_room_flashes");
    thread function_238c2a0aae70e973("lgt_control_room_flashes", 0, 20);
    wait 0.05;
    thread function_238c2a0aae70e973("lgt_control_room_flashes", 0, 0);
  }
}

function function_2fc4e3b3450f3df7() {
  flag_wait("flag_panopticon_in_darkness");
  setsaveddvar(@ "hash_67d7542dab3970f2", 3);
  setsaveddvar(@ "hash_1fc47d6f68e1faf", 1);
  setsaveddvar(@ "hash_5b1b5bd738a5436f", 1);
  setsaveddvar(@ "hash_be419c605c5c5a2c", 1);
  flag_wait("flag_control_room_clear");
  setsaveddvar(@ "hash_67d7542dab3970f2", 1);
  setsaveddvar(@ "hash_1fc47d6f68e1faf", 0);
  setsaveddvar(@ "hash_5b1b5bd738a5436f", 0);
  setsaveddvar(@ "hash_be419c605c5c5a2c", 0);
}

function function_4068626e9ddd7a11() {
  ally1 = level.ally1;
  ally1.laser_tag = spawn_tag_origin();
  ally1.laser_tag show();
  ally1.laser_tag linkTo(level.ally1, "j_gun", (15, -2, -8), (0, 0, 0), 0);
  playFXOnTag(level._effect["vfx_light_laser_fill"], ally1.laser_tag, "tag_origin");
  ally2 = level.ally2;
  ally2.laser_tag = spawn_tag_origin();
  ally2.laser_tag show();
  ally2.laser_tag linkTo(level.ally2, "j_gun", (15, -2, -8), (0, 0, 0), 0);
  playFXOnTag(level._effect["vfx_light_laser_fill"], ally2.laser_tag, "tag_origin");
}

function function_82e700452debfc2d() {
  ally1 = level.ally1;

  if(isDefined(ally1.laser_tag)) {
    killfxontag(level._effect["vfx_light_laser_fill"], ally1.laser_tag, "tag_origin");
    ally1.laser_tag delete();
  }

  ally2 = level.ally2;

  if(isDefined(ally2.laser_tag)) {
    killfxontag(level._effect["vfx_light_laser_fill"], ally2.laser_tag, "tag_origin");
    ally2.laser_tag delete();
  }
}

function function_ffef59640da9b712() {
  flag_wait("lgt_mak_cig");
  animnode = getStruct("scene_vip_0800_reach_makarov_reveal", "targetname");
  cig = animnode scene::get_entity("cigarette");
  wait 0.05;
  cig.var_cfddb148e61187a6 = spawn_tag_origin();
  cig.var_cfddb148e61187a6 show();
  cig.var_cfddb148e61187a6 linkTo(cig, "tag_origin", (1, 0, 0), (0, 0, 0), 0);
  wait 0.05;
  playFXOnTag(level._effect["vfx_light_mak_cig"], cig.var_cfddb148e61187a6, "tag_origin");
}

function function_13ab1d129a269b90() {
  flag_wait("lgt_mak_flare_lights");
  animnode = getStruct("scene_vip_0800_reach_makarov_reveal", "targetname");
  var_77c3fca845cbaa55 = animnode scene::get_entity("flare");
  wait 0.05;
  var_3f25b085280f86be = spawn_tag_origin();
  var_3f25b085280f86be show();
  wait 0.05;
  var_3f25b085280f86be linkTo(var_77c3fca845cbaa55, "j_gun", (15, -2, -8), (0, 0, 0), 0);
  wait 0.05;
  playFXOnTag(level._effect["vfx_light_mak_flare"], var_3f25b085280f86be, "tag_origin");
}

function function_e067f7d1900e80bb() {
  wait 1;
  var_14c32a94c804ed52 = getEntArray("fans_upper_y", "targetname");
  var_14c32b94c804ef85 = getEntArray("fans_upper_x", "targetname");

  for(;;) {
    foreach(fan in var_14c32a94c804ed52) {
      fan rotateby((0, 360, 0), 7);
    }

    foreach(fan in var_14c32b94c804ef85) {
      fan rotateby((0, 0, 360), 7);
    }

    wait 3;

    if(flag("cine_elevator_start")) {
      break;
    }
  }

  foreach(fan in var_14c32a94c804ed52) {
    fan delete();
  }

  foreach(fan in var_14c32b94c804ef85) {
    fan delete();
  }
}

function function_55340deea8653ff6() {
  flag_wait("flag_begin_explosions");
  wait 1;
  set_vision_naked("sp_jup_vip_ext_explosion_height", 0.2);
  wait 1;
  set_vision_naked("sp_jup_vip_ext_explosion", 3);
}

function function_705c8e520049883f() {
  lights = getEntArray("top_floor_lights", "script_noteworthy");

  foreach(light in lights) {
    light setlightintensity(0);
  }

  lights2 = getEntArray("2nd_floor_lights", "script_noteworthy");

  foreach(light in lights2) {
    light setlightintensity(0);
  }

  var_29b310c42d26af91 = getEntArray("3rd_floor_lights", "script_noteworthy");

  foreach(light in var_29b310c42d26af91) {
    light setlightintensity(0);
  }

  var_29b311c42d26b1c4 = getEntArray("bttm_floor_lights", "script_noteworthy");

  foreach(light in var_29b311c42d26b1c4) {
    light setlightintensity(0);
  }

  var_29b312c42d26b3f7 = getEntArray("4th_floor_lights", "script_noteworthy");

  foreach(light in var_29b312c42d26b3f7) {
    light setlightintensity(0);
  }

  var_29b313c42d26b62a = getEntArray("groundfloor_spots", "script_noteworthy");

  foreach(light in var_29b313c42d26b62a) {
    light setlightcolor((0.9, 1, 0.9));
    light setlightintensity(80);
  }

  thread function_238c2a0aae70e973("descend_bottom_fills", 0, 0);
}

function function_ed8262fb3bd4533b() {
  flag_wait("lgt_emerge_v2_start");
  flag_set("sun_castle_btm");
  thread function_1be9145b47c4b31d();
  thread function_da811acf019f37b3();
  thread function_47db9742d70b9a0d();
  thread function_54878a661201ffa();
  thread function_df00af6e14e227ad();
  setsaveddvar(@ "hash_e08232af8b8b695c", 6);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  setsaveddvar(@ "hash_eca4b727b01fd254", 32);
  flag_wait("lgt_emerge_v2_swim_end");
  setsaveddvar(@ "hash_eca4b727b01fd254", 16);
  level thread function_2369ab2349b02a8e();
  thread function_238c2a0aae70e973("water_emerge_moon_end_key_1", 0, 200);
  thread function_238c2a0aae70e973("water_emerge_red_key", 0, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_fill", 0, 0);
  thread function_238c2a0aae70e973("water_emerge_moon_rim", 0, 0);
  flag_wait("lgt_emerge_surface_look_up");
  thread function_238c2a0aae70e973("water_emerge_moon_end_key_1", 0.5, 0);
  flag_wait("lgt_remove_mask");
  thread function_238c2a0aae70e973("wall_bottom_moonlight", 1, 25);
  flag_wait("lgt_emerge_end");
  thread function_bfbba57c24d8bf2f();
  thread function_26280fbed5700639();
  flag_set("wall_lightning_5");
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
  thread function_1bb3d949f3e37969();
}

function function_da811acf019f37b3() {
  set_vision_naked("sp_jup_vip_underwater_end", 0);
  flag_wait("lgt_emerge_v2_swim_end");
  level.player thread utility::dof_enable_autofocus(2, level.ally1, 30, 30, undefined, "j_head");
  level.player thread utility::dof_enable_autofocus(2, level.ally2, 30, 30, undefined, "j_head");
  flag_wait("lgt_emerge_surface_look_up");
  flag_set("sun_castle_btm");
  level.player thread utility::dof_enable_autofocus(1, level.player, 25, 25, undefined, "j_wrist_ri");
  flag_wait("lgt_emerge_surface");
  set_vision_naked("sp_jup_vip_underwater_end_mask", 0);
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 500, 15, 50);
  setsuncolorandintensity(0.2);
  flag_set("flag_rappel_lightning");
  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  flag_wait("lgt_remove_mask");
  level.player[[level.swim.visionsetfunc]]("sp_jup_vip_rappel", 0);

  if(isDefined(level.scuba_mask)) {
    level.scuba_mask unlinkfromplayerview(level.player);
    level.scuba_mask delete();
  }

  set_vision_naked("", 0);
  level function_bf27c7ad1e422467(0.45);
  setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  wait 0.5;
  level.player disablephysicaldepthoffieldscripting();
  flag_wait("lgt_emerge_end");
  flag_wait("pushthroughkelp_flag");
}

function function_4e9e9ddbf1dff889() {
  flag_wait("lgt_mak_shot_11");
  wait 4;
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 100);
  flag_wait("lgt_mak_shot_12");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 100);
  wait 5;
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 300);
}

function elevator_anim() {
  animnode = utility::getStruct("scene_vip_elevator_pcap", "targetname");
  makarov = animnode scene::get_entity("Makarov");
  ivan = animnode scene::get_entity("Ivan");
  rook = animnode scene::get_entity("Rook");
  actors = [level.ally1, level.ally2, level.player, level.makarov];
  level.makarov setModel("body_c_jup_sp_villain_makarov_vip");
  waitframe();
  utility::flag_set("cine_elevator_start");
  level.player nightvisiongogglesforceoff();
  level.player player::focusdisable();
  utility::function_1ae8f046dee579e0(1);
  thread function_b43da6f1b78f953b();
  animnode thread scene::play(actors, "approach_enter");
  animnode thread scene::play(actors, "approach_idle");
  animnode thread scene::play(level.ally1, "approach_nag1");
  animnode thread scene::play(level.ally1, "approach_nag2");
  animnode thread scene::play(level.ally1, "approach_nag3");
  animnode thread scene::play(level.ally1, "approach_nag4");
  utility::flag_wait("flag_player_within_elevator");
  utility::flag_set("cine_elevator_start");
  animnode scene::play(actors, "pcap_intro");
  animnode scene::play(actors, "pcap_idle");
  animnode scene::play(actors, "pcap_answer1");
  animnode scene::play(actors, "pcap_answer2");
  animnode scene::play(actors, "pcap_answer3");
  animnode scene::play(actors, "pcap_exit");
  utility::flag_wait("cine_elevator_end");
  level.player player::focusenable();
  utility::function_1ae8f046dee579e0(0);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_55f8fe20a6ed10b5", 0);
  }
}

function hide_every_frame() {
  self endon("death");
  level.player_rig endon("death");
  level.player_rig endon("kill_hide_every_frame");

  while(true) {
    level.player_rig hide();
    waitframe();
  }
}

function function_b43da6f1b78f953b() {
  utility::flag_wait("cine_elevator_start");
  animnode = utility::getStruct("scene_vip_elevator_pcap", "targetname");
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_orginal", 2, 0);
  thread function_1be9145b47c4b31d();
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 10);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_eca4b727b01fd254", 18);
    setsaveddvar(@ "hash_5bd7532930b8949a", 2);
  }

  thread function_5c4556bd2167e009();
  thread function_ff51e0a6804b6fee();
  reflection_probe = getEnt("reflection_elevator", "script_noteworthy");
  thread vision::set_vision_naked("sp_jup_vip_elevator_cine_0air", 3);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor", 0.5, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor_2", 0.5, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor_rim_ivan", 0.5, 0);
  thread function_238c2a0aae70e973("elevator_lgt_int_corridor_rim_makarov", 0.5, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_start_outside", 3, 10);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_back", 0, 20);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L", 0.1, 20);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L_sm", 0.1, 20);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R", 0.1, 5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R_sm", 0.1, 5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_rim", 0, 40);
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 0, 1);
  thread function_4592ed3200c60f5("lgts_cine_elevator_top", 0, (1, 0.85, 0.6));
  thread function_4592ed3200c60f5("lgt_cine_elevator_moving", 0, (0.8, 0.8, 1));
  thread function_4592ed3200c60f5("lgts_cine_elevator_fill", 0, (0.9, 1, 0.8));
  thread function_e35e87e1ea308b6a();
  fill = getEnt("lgts_cine_elevator_fill", "targetname");
  fill setlightradius(140);
  wait 0.05;
  setsaveddvar(@ "hash_63eb1893f96ac98d", 10);
  setsaveddvar(@ "hash_e08232af8b8b695c", 10);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
    lgts_cine_elevator_top_back = getEnt("lgts_cine_elevator_top_back", "targetname");
    lgts_cine_elevator_top_back function_94e6538604ee3986("forceshadowoff");
  }

  player = animnode scene::get_entity("Player");
  rook = animnode scene::get_entity("Rook");
  wait 2;
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  utility::flag_wait("cine_elevator_gate_closing");
  thread function_238c2a0aae70e973("lgts_cine_elevator_key", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 0, 0);
  setsaveddvar(@ "hash_dacffbfd52c2fdc5", 8);
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
  wait 1;
  thread function_238c2a0aae70e973("lgts_cine_elevator_key", 0.5, 2);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 0.5, 0.3);
  utility::flag_wait("cine_elevator_look_right");
  utility::flag_wait("cine_elevator_mak_close");
  thread function_4592ed3200c60f5("lgts_cine_elevator_key", 1.5, (1, 1, 1));
  fill setlightradius(220);
  level.player hide();
  player hide();
  player dontcastshadows();
  rook dontcastshadows();
  level.player_rig thread hide_every_frame();
  thread function_238c2a0aae70e973("lgts_cine_elevator_key", 0.5, 0.75);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 1, 0.15);
  thread function_238c2a0aae70e973("lgts_cine_elevator_start_outside", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L", 1, 0);
  thread function_238c2a0aae70e973("lgt_cine_L_kicker", 1, 0.5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_rim", 1, 100);
  utility::flag_wait("cine_elevator_mak_far");
  thread function_4592ed3200c60f5("lgts_cine_elevator_key", 1.5, (0.92, 1, 0.85));
  player show();
  player castshadows();
  rook castshadows();
  level.player show();
  level.player_rig notify("kill_hide_every_frame");
  thread function_238c2a0aae70e973("lgt_cine_L_kicker", 1, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_rim", 2, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 2.5, 0);
  utility::flag_wait("cine_elevator_actual_teleport");
  thread vision::set_vision_naked("sp_jup_vip_elevator_cine", 2);
  thread function_238c2a0aae70e973("lgt_elevator_outside_end", 0, 80);
  wait 0.2;
  thread function_238c2a0aae70e973("lgts_cine_elevator_top", 2, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_key", 2, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_rim", 2, 0);
  utility::flag_wait("cine_elevator_open_gate");
  thread function_238c2a0aae70e973("lgts_cine_elevator_key", 0.5, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 0.5, 0);
  thread vision::set_vision_naked("sp_jup_vip_ext_court2", 4);
  setsuncolorandintensity(0);
  thread function_238c2a0aae70e973("lgt_elevator_outside_end", 1, 10);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0, 0);
  utility::flag_wait("cine_elevator_pre_end");
  thread function_238c2a0aae70e973("lgt_elevator_outside_end", 2, 1);
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving", 0, 0);
  lgt_elevator_outside_end = getEnt("lgt_elevator_outside_end", "targetname");
  lgt_elevator_outside_end function_b06dacaa135987ad(0);
  setsaveddvar(@ "hash_93b4b56b615317b9", 4000);
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 2000);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_93b4b56b615317b9", 1000);
  }

  thread function_88538347d5881c88();
  setsaveddvar(@ "hash_1ea8544d78048529", 1);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_ef38136354fc0472();
  wait 4;
  thread function_26280fbed5700639();

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_5bd7532930b8949a", 4.9);
  }

  thread function_f20723b6b8a2349e();
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L_sm", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R_sm", 0, 0);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_back", 0, 0);

  if(function_8f7452209f2fa982() || function_33d2520f3f4c794() || isplatformpc()) {
    setsaveddvar(@ "hash_1d03444cd52cc348", 0.875);
    setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.005);
    setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  }
}

function function_5c4556bd2167e009() {
  wait 5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player thread dof_enable_autofocus(1.5, level.makarov, 10, 10, undefined, "tag_helmetlight");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", 100);
  animnode = utility::getStruct("scene_vip_elevator_pcap", "targetname");
  makarov = animnode scene::get_entity("Makarov");
  ivan = animnode scene::get_entity("Ivan");
  rook = animnode scene::get_entity("Rook");
  utility::flag_wait("cine_elevator_mak_close");
  setsaveddvar(@ "hash_eca4b727b01fd254", 5);
  wait 1.5;
  level.player thread dof_enable_autofocus(3, level.makarov, 10, 10, undefined, "tag_helmetlight");
  wait 1.5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(4, 22);
  utility::flag_wait("cine_elevator_mak_far");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread dof_enable_autofocus(2.5, level.makarov, 10, 10, undefined, "tag_helmetlight");
  setsaveddvar(@ "hash_eca4b727b01fd254", 20);
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 5, 0);
  utility::flag_wait("cine_elevator_pre_end");
  level.player disablephysicaldepthoffieldscripting();
  level.player thread utility::dof_disable_autofocus();
}

function mak_response() {}

function function_e35e87e1ea308b6a() {
  thread mak_response();
  light = getEnt("lgt_cine_elevator_moving3", "targetname");
  high_pos = getStruct("lgt_cine_elevator_moving_pos_high3", "targetname");
  low_pos = getStruct("lgt_cine_elevator_moving_pos_low3", "targetname");
  light2 = getEnt("lgt_cine_elevator_moving2", "targetname");
  high_pos2 = getStruct("lgt_cine_elevator_moving_pos_high2", "targetname");
  low_pos2 = getStruct("lgt_cine_elevator_moving_pos_low2", "targetname");
  light2 setlightradius(110);
  var_2156513b75d9f7d8 = getEnt("lgt_cine_elevator_moving", "targetname");
  flag_wait("cine_elevator_moving");
  thread vision::set_vision_naked("sp_jup_vip_elevator_cine_dark_0air", 1.5);
  thread function_e16726dfe88727e8();
  thread function_238c2a0aae70e973("lgts_cine_elevator_fill", 2, 6);
  wait 4;
  thread function_4592ed3200c60f5("lgt_cine_elevator_moving3", 0, (1, 0, 0));
  thread function_4592ed3200c60f5("lgt_cine_elevator_moving2", 0, (1, 0, 0));
  thread function_4592ed3200c60f5("lgt_cine_elevator_moving", 0, (1, 0, 0));
  wait 1;
  thread function_bb9b60091de365cc(light, 0, high_pos.origin);
  thread function_bb9b60091de365cc(light2, 0, high_pos2.origin);
  thread function_69fdb565035993c5(light, high_pos, low_pos);
  thread function_7289e4265e006835(light2, high_pos2, low_pos2);

  while(flag("cine_elevator_moving")) {
    waitframe();
  }

  level.player notify("elevator stop");
  light setlightintensity(0);
  light2 setlightintensity(0);
  var_2156513b75d9f7d8 setlightintensity(0);
  flag_wait("cine_elevator_moving");
  thread function_e16726dfe88727e8();
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving", 0, 0);
  light = getEnt("lgt_cine_elevator_moving", "targetname");
  high_pos = getStruct("lgt_cine_elevator_moving_pos_high", "targetname");
  low_pos = getStruct("lgt_cine_elevator_moving_pos_low", "targetname");
  thread function_bb9b60091de365cc(light, 0, high_pos.origin);
  thread function_28b8448c309e426(light, high_pos, low_pos);

  while(flag("cine_elevator_moving") && !flag("cine_elevator_actual_teleport")) {
    waitframe();
  }

  level.player notify("elevator stop");
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving3", 0, 0);
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving2", 0, 0);
  wait 0.05;
  thread function_bb9b60091de365cc(light, 0, high_pos.origin);
}

function function_69fdb565035993c5(light, high_pos, low_pos) {
  wait randomfloatrange(0.5, 2);
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving3", 0, randomfloatrange(100, 200));
  thread function_4592ed3200c60f5("lgt_cine_elevator_moving3", 0, (1, 0.6, 0.2));
  wait 0.05;
  thread function_bb9b60091de365cc(light, 10, low_pos.origin);
  wait 2;
  thread vision::set_vision_naked("sp_jup_vip_elevator_cine", 1);
  wait 4.5;
  thread vision::set_vision_naked("sp_jup_vip_elevator_cine_dark", 1);
  wait 1;
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving3", 0, 0);
  wait 1;
  thread function_bb9b60091de365cc(light, 0, high_pos.origin);
}

function function_7289e4265e006835(light, high_pos, low_pos) {
  wait randomfloatrange(0.5, 2);
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving2", 0, randomfloatrange(700, 2000));
  thread function_4592ed3200c60f5("lgt_cine_elevator_moving2", 0, (1, 0.6, 0.2));
  wait 0.05;
  thread function_bb9b60091de365cc(light, 10, low_pos.origin);
  wait 4;
  wait 2.5;
  wait 1;
  thread function_238c2a0aae70e973("lgt_cine_elevator_moving2", 0, 0);
  wait 1;
  thread function_bb9b60091de365cc(light, 0, high_pos.origin);
}

function function_28b8548c309e659(light, high_pos, low_pos) {
  level.player endon("elevator stop");

  for(i = 0;; i++) {
    wait randomfloatrange(0.5, 2);
    thread function_238c2a0aae70e973("lgt_cine_elevator_moving2", 0, randomfloatrange(1000, 2500));

    if(i == 0) {
      thread function_4592ed3200c60f5("lgt_cine_elevator_moving2", 0, (1, 0.8, 0.3));
    }

    if(i == 1) {
      thread function_4592ed3200c60f5("lgt_cine_elevator_moving2", 0, (0, 0.8, 1));
    }

    wait 0.05;
    thread function_bb9b60091de365cc(light, 10, low_pos.origin);
    wait 4;
    thread vision::set_vision_naked("sp_jup_vip_elevator_cine", 1);
    wait 2.5;
    thread vision::set_vision_naked("sp_jup_vip_elevator_cine_dark", 1);
    wait 1;
    thread function_238c2a0aae70e973("lgt_cine_elevator_moving2", 0, 0);
    wait 1;
    thread function_bb9b60091de365cc(light, 0, high_pos.origin);
  }
}

function function_28b8448c309e426(light, high_pos, low_pos) {
  level.player endon("elevator stop");

  for(i = 0; !flag("lgt_mak_response"); i++) {
    wait randomfloatrange(0.5, 2);
    thread function_238c2a0aae70e973("lgt_cine_elevator_moving", 0, randomfloatrange(100, 250));

    if(i == 0) {
      thread function_4592ed3200c60f5("lgt_cine_elevator_moving", 0, (0.35, 0.8, 1));
    }

    if(i == 1) {
      thread function_4592ed3200c60f5("lgt_cine_elevator_moving", 0, (1, 0.8, 0.7));
    }

    if(i == 2) {
      thread function_4592ed3200c60f5("lgt_cine_elevator_moving", 0, (0.5, 1, 0.8));
    }

    wait 0.05;
    thread function_bb9b60091de365cc(light, 10, low_pos.origin);
    wait 4;
    thread vision::set_vision_naked("sp_jup_vip_elevator_cine", 1);
    wait 2.5;
    thread vision::set_vision_naked("sp_jup_vip_elevator_cine_dark", 1);
    wait 1;
    thread function_238c2a0aae70e973("lgt_cine_elevator_moving", 0, 0);
    wait 1;
    thread function_bb9b60091de365cc(light, 0, high_pos.origin);
  }

  thread function_238c2a0aae70e973("lgt_cine_elevator_moving", 1, 0);
}

function function_e16726dfe88727e8() {
  lights = getEntArray("lgts_cine_elevator_top", "targetname");

  if(isDefined(lights)) {
    foreach(light in lights) {
      light thread lighting::flicker_light(0.05, 0.3, 0.1, 0.3, 0, 0.005);
    }
  }

  wait randomfloatrange(0.5, 2);

  if(isDefined(lights)) {
    foreach(light in lights) {
      light notify("kill_flicker");
    }
  }

  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L", 0.1, 10);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L_sm", 0.1, 10);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R", 0.1, 5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R_sm", 0.1, 5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_back", 0.1, 20);
  wait 0.05;
  flag_waitopen("cine_elevator_moving");
  wait 0.3;
  lights = getEntArray("lgts_cine_elevator_top", "targetname");

  if(isDefined(lights)) {
    foreach(light in lights) {
      light thread lighting::flicker_light(0.05, 0.3, 0.1, 0.3, 0, 0.005);
    }
  }

  wait randomfloatrange(0.5, 2);

  if(isDefined(lights)) {
    foreach(light in lights) {
      light notify("kill_flicker");
    }
  }

  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L", 0.1, 10);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_L_sm", 0.1, 10);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R", 0.1, 5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_R_sm", 0.1, 5);
  thread function_238c2a0aae70e973("lgts_cine_elevator_top_back", 0.1, 20);
}

function function_1c122eda03d1132f() {
  thread function_238c2a0aae70e973("lgt_cine_elevator_button", 0.1, 22);
  wait 0.1;
  thread function_238c2a0aae70e973("lgt_cine_elevator_button", 0.5, 0);
  flag_waitopen("cine_elevator_moving");
  thread function_238c2a0aae70e973("lgt_cine_elevator_button", 0.1, 22);
  wait 0.1;
  thread function_238c2a0aae70e973("lgt_cine_elevator_button", 0.5, 0);
  flag_wait("cine_elevator_moving");
  thread function_238c2a0aae70e973("lgt_cine_elevator_button_up", 0.1, 22);
  wait 0.1;
  thread function_238c2a0aae70e973("lgt_cine_elevator_button_up", 0.5, 0);
}

function function_cf989893662dbcd2(animnode) {
  waitframe();
  player_1 = animnode scene::get_entity("Player 1");
  ally1 = animnode scene::get_entity("ally1");
  nolan = animnode scene::get_entity("Nolan");
  actor_3 = animnode scene::get_entity("Makarov");
  actor_4 = animnode scene::get_entity("Actor 4");
  actor_5 = animnode scene::get_entity("Actor 5");
  boat01 = animnode scene::get_entity("Boat01");
  boat02 = animnode scene::get_entity("Boat02");
  actors = [level.ally1, level.makarov, nolan];
  function_a19904f15da81f7d([actor_4, actor_5], animnode);
  thread function_b0c69eb4c5c04de3(actors, boat01, boat02);
  thread function_8ba87b2fd136d3d4(level.ally1, nolan);
  level.makarov setModel("body_c_jup_sp_villain_makarov_vip");
  level.player nightvisiongogglesforceoff();
  utility::flag_wait("lgt_cine_pullout_1");
  utility::flag_wait("lgt_cine_pullout_2");
  utility::flag_wait("lgt_cine_pullout_3");
  wait 0.05;
  utility::flag_wait("lgt_cine_boat_go");
  utility::flag_wait("lgt_lgt_cine_boat_gulag");
  utility::flag_wait("cine_exfil_end");
  level.player player::focusenable();
  utility::function_1ae8f046dee579e0(0);
}

function function_b0c69eb4c5c04de3(actors, boat01, boat02) {
  thread function_1be9145b47c4b31d();
  thread function_b5f0378af9b938b1(actors);
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 1);
  setsaveddvar(@ "hash_960ef00238357bbc", 0);
  setsaveddvar(@ "hash_7c6e3f49a053cc4c", 0.3);
  setsaveddvar(@ "hash_b345e52965c135b5", 0.3);
  setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.2);
  var_4c13edcdb5f48b4f = isplatformxb3() || isplatformps4();

  if(var_4c13edcdb5f48b4f) {
    setsaveddvar(@ "hash_1d03444cd52cc348", 0.875);
    setsaveddvar(@ "hash_5bd7532930b8949a", 2);
  }

  thread function_238c2a0aae70e973("exfil_cin_lights", 0, 0);
  thread function_238c2a0aae70e973("lgt_cliff_searchlight_3", 0, 0);
  thread function_238c2a0aae70e973("lgt_cliff_searchlight_3_move", 0, 0);
  setsaveddvar(@ "hash_227255b054ed2f30", 1);
  setsaveddvar(@ "hash_f462015fd5b9ecc7", 170);
  setsaveddvar(@ "hash_48befd65e5945e5", 1);
  setsuncolorandintensity(0.12);
  setsundirection(anglesToForward((-69, -132, 0)));
  thread vision::set_vision_naked("sp_jup_vip_exfil_cine_underwater", 0);
  setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
  setsaveddvar(@ "hash_36561ce503889667", 0.95);
  setsaveddvar(@ "hash_5a016e50936393e9", 0.95);

  if(!var_4c13edcdb5f48b4f) {
    setsaveddvar(@ "hash_e2bf54eff7003fea", 1);
  }

  lgt_exfil_gunfire_water_02 = getEnt("lgt_exfil_gunfire_water_02", "targetname");
  lgt_exfil_gunfire_water_01 = getEnt("lgt_exfil_gunfire_water_01", "targetname");
  lgt_exfil_gunfire_water_03 = getEnt("lgt_exfil_gunfire_water_03", "targetname");
  lgt_exfil_gunfire_water_04 = getEnt("lgt_exfil_gunfire_water_04", "targetname");
  lgt_exfil_gunfire_water_03 thread blink_light(0.05, 0.05, 1, 4, 1, 1600);
  lgt_exfil_gunfire_water_04 thread blink_light(0.05, 0.05, 1, 4, 1, 3200);
  level.player setblurforplayer(5, 0);
  wait 1;
  level.player setblurforplayer(0, 1.5);
  utility::flag_wait("lgt_cine_exfil_surface");
  thread function_f2cb32d3b862bcc4();
  setsuncolorandintensity(0.12);
  setsundirection(anglesToForward((-39, -102.27, 0)));
  thread function_238c2a0aae70e973("end_cin_castle_rim", 0, 1600);
  thread function_238c2a0aae70e973("exfil_cin_castle_light", 0, 6366);
  lgt_exfil_gunfire_water_01 notify("kill_flicker");
  lgt_exfil_gunfire_water_02 notify("kill_flicker");
  lgt_exfil_gunfire_water_03 notify("kill_flicker");
  lgt_exfil_gunfire_water_04 notify("kill_flicker");
  thread function_238c2a0aae70e973("lgt_exfil_gunfire_water_03", 0, 0);
  thread function_238c2a0aae70e973("lgt_exfil_gunfire_water_04", 0, 0);
  thread function_5ab45c10238872b(boat01, boat02);
  thread function_238c2a0aae70e973("lgt_exfil_surface_key", 0, 0.25);
  thread function_238c2a0aae70e973("lgt_exfil_surface_rim", 0, 20);
  thread function_238c2a0aae70e973("lgt_exfil_surface_fill", 0, 0);
  thread function_238c2a0aae70e973("boat_control_light", 0, 0.3);
  boat_control_light = getEnt("boat_control_light", "targetname");
  boat_control_light linkTo(boat01, "tag_fx_forward");
  thread vision::set_vision_naked("sp_jup_vip_exfil_cine", 0);
  utility::flag_wait("lgt_cine_pullout_2");
  anim_sp::letterbox_enable(1, 1);
  utility::flag_wait("lgt_cine_pullout_3");
  thread function_238c2a0aae70e973("lgt_exfil_surface_rim", 0, 50);
  thread function_238c2a0aae70e973("lgt_exfil_surface_key", 2, 0);
  thread function_238c2a0aae70e973("lgt_exfil_surface_fill", 2, 0);
  thread function_238c2a0aae70e973("lgt_exfil_surface_key_end", 2, 80);
  thread function_238c2a0aae70e973("lgt_exfil_surface_rim", 6, 0);
  utility::flag_wait("lgt_cine_boat_go");
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 3);
  thread vision::set_vision_naked("sp_jup_vip_exfil_cine_drive", 5);
  function_36552610035fd32e(0.12, 0.4, 5);
  utility::flag_wait("attach_lights");
  exfil_red_boat_light = getEnt("exfil_red_boat_light", "targetname");
  var_5f2a99785dd35945 = function_848155be2b7da2cb(boat01.angles, exfil_red_boat_light.angles);
  exfil_red_boat_light linkTo(boat01, "tag_origin", (1.39103, -22.9364, 69.5), var_5f2a99785dd35945);
  exfil_rim_drive_mac = getEnt("exfil_rim_drive_mac", "targetname");
  var_5f2a99785dd35945 = function_848155be2b7da2cb(boat01.angles, exfil_rim_drive_mac.angles);
  exfil_rim_drive_mac linkTo(boat01, "tag_origin", (-80.4894, -38.5438, 94.5), var_5f2a99785dd35945);
  exfil_fill1_drive_mac = getEnt("exfil_fill1_drive_mac", "targetname");
  var_5f2a99785dd35945 = function_848155be2b7da2cb(boat01.angles, exfil_fill1_drive_mac.angles);
  exfil_fill1_drive_mac linkTo(boat01, "tag_origin", (-38.9849, -41.1286, 77.5), var_5f2a99785dd35945);
  exfil_fill2_drive_mac = getEnt("exfil_fill2_drive_mac", "targetname");
  var_5f2a99785dd35945 = function_848155be2b7da2cb(boat01.angles, exfil_fill2_drive_mac.angles);
  exfil_fill2_drive_mac linkTo(boat01, "tag_origin", (-31.1204, -36.9009, 59.5), var_5f2a99785dd35945);
  exfil_rim_drive_guy2 = getEnt("exfil_rim_drive_guy2", "targetname");
  var_5f2a99785dd35945 = function_848155be2b7da2cb(boat01.angles, exfil_rim_drive_guy2.angles);
  exfil_rim_drive_guy2 linkTo(boat01, "tag_origin", (-30.6321, -62.5282, 118.5), var_5f2a99785dd35945);
  exfil_fill_drive_guy2 = getEnt("exfil_fill_drive_guy2", "targetname");
  var_5f2a99785dd35945 = function_848155be2b7da2cb(boat01.angles, exfil_fill_drive_guy2.angles);
  exfil_fill_drive_guy2 linkTo(boat01, "tag_origin", (-53.3587, -24.7989, 77.5), var_5f2a99785dd35945);
  thread function_238c2a0aae70e973("exfil_red_boat_light", 1, 1);
  thread function_238c2a0aae70e973("exfil_rim_drive_mac", 1, 1.5);
  thread function_238c2a0aae70e973("exfil_fill1_drive_mac", 1, 0.04);
  thread function_238c2a0aae70e973("exfil_fill2_drive_mac", 1, 0.04);
  thread function_238c2a0aae70e973("exfil_rim_drive_guy2", 1, 4);
  thread function_238c2a0aae70e973("exfil_fill_drive_guy2", 1, 0.03);
  thread function_238c2a0aae70e973("exfil_cin_castle_light", 2, 0);
  utility::flag_wait("lgt_cine_boat_gulag");
  setsaveddvar(@ "hash_ea4c44a08cd23d5d", 2.5);
  utility::flag_wait("lgt_cine_exfil_end");
  thread function_26280fbed5700639();
}

function function_b5f0378af9b938b1(actors) {
  utility::flag_wait("lgt_cine_exfil_surface");
  level.player thread utility::dof_enable_autofocus(1.5, level.makarov, 5, 2, undefined, "tag_helmetlight");
  wait 2.5;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(15, 50, 15, 50);
  utility::flag_wait("lgt_cine_pullout_2");
  level.player thread utility::dof_enable_autofocus(2, level.makarov, 5, 2, undefined, "tag_helmetlight");
  utility::flag_wait("lgt_cine_pullout_3");
  level.player thread utility::dof_enable_autofocus(2, level.ally1, 5, 2, undefined, "tag_helmetlight");
  wait 2;
  level.player thread utility::dof_enable_autofocus(2, level.makarov, 5, 2, undefined, "tag_helmetlight");
  utility::flag_wait("lgt_cine_boat_go");
  wait 6;
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(5, 40, 15, 50);
}

function function_5ab45c10238872b(boat01, boat02) {
  lgt_exfil_gunfire_01 = getEnt("lgt_exfil_gunfire_01", "targetname");
  lgt_exfil_gunfire_01_2 = getEnt("lgt_exfil_gunfire_01_2", "targetname");
  lgt_exfil_gunfire_01_3 = getEnt("lgt_exfil_gunfire_01_3", "targetname");
  lgt_exfil_gunfire_01_4 = getEnt("lgt_exfil_gunfire_01_4", "targetname");
  lgt_exfil_gunfire_01 linkTo(boat01, "tag_fx_forward");
  lgt_exfil_gunfire_01_2 linkTo(boat01, "tag_fx_forward");
  lgt_exfil_gunfire_01_3 linkTo(boat01, "tag_fx_forward");
  lgt_exfil_gunfire_01_4 linkTo(boat01, "tag_fx_forward");
  lgt_exfil_gunfire_01 thread blink_light(0.1, 0.2, 0.25, 1, 5, 125);
  lgt_exfil_gunfire_01_2 thread blink_light(0.1, 0.2, 0.15, 1, 3, 125);
  lgt_exfil_gunfire_01_3 thread blink_light(0.1, 0.1, 1, 0.1, 0.05, 37);
  lgt_exfil_gunfire_01_4 thread blink_light(0.1, 0.1, 1, 0.1, 0.05, 37);
  utility::flag_wait("lgt_cine_pullout_1");
  lgt_exfil_gunfire_01_4 notify("kill_flicker");
  thread function_238c2a0aae70e973("lgt_exfil_gunfire_01_4", 0, 0);
  utility::flag_wait("lgt_cine_boat_go");
  wait 2.5;
  lgt_exfil_gunfire_01 notify("kill_flicker");
  lgt_exfil_gunfire_01_2 notify("kill_flicker");
  lgt_exfil_gunfire_01_3 notify("kill_flicker");
  thread function_238c2a0aae70e973("lgt_exfil_gunfire_01", 0, 0);
  thread function_238c2a0aae70e973("lgt_exfil_gunfire_01_2", 0, 0);
  thread function_238c2a0aae70e973("lgt_exfil_gunfire_01_3", 0, 0);
}

function function_8ba87b2fd136d3d4(ally1, nolan) {
  wait 3;
  level.ally1 setModel("body_c_jup_sp_villain_ivan_urban");
  ally1 detach(ally1.headmodel);
  ally1.headmodel = "c_jup_head_hero_ivan_urban_unmasked";
  ally1 attach(ally1.headmodel);
  ally1.name = "";
  ally1.callsign = "";
  nolan setModel("body_c_jup_sp_villain_nolan_urban");
  nolan detach(nolan.headmodel);
  nolan.headmodel = "c_jup_head_hero_nolan_urban_unmasked";
  nolan attach(nolan.headmodel);
  nolan.name = "";
  nolan.callsign = "";
  utility::flag_wait("lgt_cine_pullout_2");
}

function function_bb9b60091de365cc(ent, time, target) {
  ent notify("stop lerp");
  ent endon("stop lerp");
  ent endon("death");
  startorigin = ent.origin;
  t = 0;

  while(t < time && flag("cine_elevator_moving")) {
    ent.origin = vectorlerp(startorigin, target, t / time);
    t += 0.05;
    wait 0.05;
  }

  ent.origin = target;
}

function function_a42590e4d2476219(ent, time, target) {
  ent notify("stop lerp");
  ent endon("stop lerp");
  ent endon("death");
  startorigin = ent.origin;
  t = 0;

  while(t < time) {
    ent.origin = vectorlerp(startorigin, target, t / time);
    t += 0.05;
    wait 0.05;
  }

  ent.origin = target;
}

function function_336d610219c2b94c() {
  set_vision_naked("sp_jup_vip_ext_heli", 10);
  fx_org = spawn_tag_origin();
  fx_org show();
  fx_org linkTo(level.var_8906fd70bcda7978, "camera_cover1_jnt", (0, 0, 0), (0, 0, 0), 0);
  playFXOnTag(getfx("vfx_vip_lgt_heli_search"), fx_org, "tag_origin");
  thread function_2315eb07b8add818(fx_org);
  flag_wait("flag_escape_hallway_prisoner_door_breach");
  set_vision_naked("sp_jup_vip_ext_heli_int", 2);
  flag_wait("flag_escape_cliff_heli_enter");
  flag_wait("flag_escape_cliff_slide_start");
  flag_wait("flag_escape_cliff_heli_death");
}

function function_2315eb07b8add818(fx_org) {
  for(;;) {
    if(flag("flag_escape_cliff_heli_death") || flag("flag_heli_light_off")) {
      setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
      setsaveddvar(@ "hash_36561ce503889667", 0.95);
      setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
      killfxontag(getfx("vfx_vip_lgt_heli_search"), fx_org, "tag_origin");
      wait 1;
      setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
      setsaveddvar(@ "hash_36561ce503889667", 0.95);
      setsaveddvar(@ "hash_5a016e50936393e9", 0.95);

      while(flag("flag_escape_cliff_heli_death") || flag("flag_heli_light_off")) {
        wait 0.05;
      }
    }

    wait 0.05;

    if(flag("flag_heli_light_on")) {
      playFXOnTag(getfx("vfx_vip_lgt_heli_search"), fx_org, "tag_origin");

      while(flag("flag_heli_light_on")) {
        wait 0.05;

        if(flag("flag_escape_cliff_heli_death")) {
          break;
        }
      }
    }
  }
}

function escape_jeep_explosion() {
  flag_wait("escape_bridge_apc_shot_truck");
  level.player endon("kill_courtyard_riot_searchlight");
  thread escape_jeep_explosion_look();
  thread function_238c2a0aae70e973("lgt_heli_missle", 0.1, 10000);
  wait 0.15;
  thread function_238c2a0aae70e973("lgt_heli_missle", 0.25, 0);
  wait 0.25;
}

function escape_jeep_explosion_look() {
  trigger = getEnt("escape_jeep_explosion_look", "targetname");
  trigger.script_dot = 0.3;

  if(flag("escape_jeep_explosion_look")) {
    setsaveddvar(@ "hash_351ca4838eccf185", 1);
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 3, 0.25);
    wait 0.35;
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 1, 1);
    wait 1;
    setsaveddvar(@ "hash_351ca4838eccf185", 0);
  }
}

function function_22cfef863bc45a6b(apc) {
  flag_wait("escape_bridge_apc_shot_truck");
}

function heli_explosion() {
  setsaveddvar(@ "hash_5a83a561cb4970b2", 1000);
  wait 2;
  thread function_238c2a0aae70e973("lgt_heli_explosion_boat", 0.2, 10000);
  wait 0.5;
  thread function_238c2a0aae70e973("lgt_heli_explosion_omni", 1, 0);
  wait 3.5;
  thread function_238c2a0aae70e973("lgt_heli_explosion_link", 4, 0);
  thread function_238c2a0aae70e973("lgt_heli_explosion_boat", 4, 0);
}

function function_66ed7d72bfc4b049() {
  flag_wait("flag_riot_elevator_hallway_door_open");
  setsaveddvar(@ "hash_93b4b56b615317b9", 500);
  lgt_cine_l_kicker = getEnt("lgt_cine_L_kicker", "targetname");
  lgt_cine_elevator_button = getEnt("lgt_cine_elevator_button", "targetname");
  lgts_cine_elevator_rim = getEnt("lgts_cine_elevator_rim", "targetname");
  lgts_cine_elevator_top = getEntArray("lgts_cine_elevator_top", "targetname");
  lgts_cine_elevator_key = getEnt("lgts_cine_elevator_key", "targetname");
  lgts_cine_elevator_fill = getEnt("lgts_cine_elevator_fill", "targetname");
  array = [lgt_cine_l_kicker, lgts_cine_elevator_rim, lgts_cine_elevator_key, lgts_cine_elevator_fill, lgt_cine_elevator_button];

  foreach(ent in lgts_cine_elevator_top) {
    array = array_add(array, ent);
  }

  foreach(ent in array) {
    ent function_94e6538604ee3986("forceshadowoff");
  }

  utility::flag_wait("cine_elevator_start");

  foreach(ent in array) {
    ent function_94e6538604ee3986("normal");
  }
}

function function_ff51e0a6804b6fee() {
  animnode = utility::getStruct("scene_vip_elevator_pcap", "targetname");
  wait 0.05;
  elevator = animnode scene::get_entity("Elevator");
  lgt_cine_l_kicker = getEnt("lgt_cine_L_kicker", "targetname");
  lgt_cine_elevator_button = getEnt("lgt_cine_elevator_button", "targetname");
  lgts_cine_elevator_rim = getEnt("lgts_cine_elevator_rim", "targetname");
  lgts_cine_elevator_top = getEntArray("lgts_cine_elevator_top", "targetname");
  lgts_cine_elevator_top_fixtures = getEntArray("lgts_cine_elevator_top_fixtures", "targetname");
  lgts_cine_elevator_key = getEnt("lgts_cine_elevator_key", "targetname");
  lgts_cine_elevator_fill = getEnt("lgts_cine_elevator_fill", "targetname");
  reflection_elevator = getEnt("reflection_elevator", "script_noteworthy");
  lgts_cine_elevator_top_back = getEnt("lgts_cine_elevator_top_back", "targetname");
  array = [lgt_cine_l_kicker, lgts_cine_elevator_rim, lgts_cine_elevator_key, lgts_cine_elevator_fill, reflection_elevator, lgt_cine_elevator_button, lgts_cine_elevator_top_back];

  foreach(ent in lgts_cine_elevator_top) {
    array = array_add(array, ent);
  }

  foreach(ent in lgts_cine_elevator_top_fixtures) {
    array = array_add(array, ent);
  }

  level waittill("cine_elevator_actual_moving");

  foreach(ent in array) {
    ent linkTo(elevator, "J_prop_1");
  }

  level waittill("cine_elevator_actual_stop");
  level waittill("cine_elevator_actual_preteleport");
  utility::flag_wait("cine_elevator_end");

  foreach(ent in array) {
    ent unlink();
  }
}

function trig_boat_visiblity() {
  wait 0.05;
  run_thread_on_targetname("TRIG_boat_visiblity", &boat_visiblity);
}

function boat_visiblity() {
  while(true) {
    self waittill("trigger");
    var_19ca117e923c8ce0 = getStructArray("escape_boat_bullet_start", "targetname");
    setsaveddvar(@ "hash_5a83a561cb4970b2", 1000);

    foreach(gun in var_19ca117e923c8ce0) {}

    setsaveddvar(@ "hash_93b4b56b615317b9", 8000);
    flag_set("wind_on");
    thread function_c4d3fdabc1d2f662();
    thread function_99c076d43d9443fc();
    setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
    setsaveddvar(@ "hash_36561ce503889667", 0.95);
    setsaveddvar(@ "hash_5a016e50936393e9", 0.95);

    if(isplatformxb3() || isplatformps4()) {
      setsaveddvar(@ "hash_55f8fe20a6ed10b5", 1);
    }

    flag_clear("flag_heli_light_off");
    wait 0.05;
    flag_set("flag_heli_light_on");

    while(level.player istouching(self)) {
      wait 0.05;
    }

    function_1d321dd7f8b825ce("flare_exil", "lgt_exfil_visibility", 0);
    setsaveddvar(@ "hash_cb471f951a15940f", 0.95);
    setsaveddvar(@ "hash_36561ce503889667", 0.95);
    setsaveddvar(@ "hash_5a016e50936393e9", 0.95);
    wait 2;
    setsaveddvar(@ "hash_93b4b56b615317b9", 2000);
  }
}

function function_57a2b4fa9a2f47e2() {
  thread function_238c2a0aae70e973("main_court_arch_lights", 0, 0);
  thread function_238c2a0aae70e973("court_yard_2_main", 0, 200);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light", 0, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0, 0);
  var_6906a60962d199f0 = getEntArray("helicopter_main_lights", "script_noteworthy");

  foreach(light in var_6906a60962d199f0) {
    light setlightintensity(0);
  }
}

function function_88538347d5881c88() {
  wait 0.05;
  setsaveddvar(@ "hash_93b4b56b615317b9", 4000);

  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_93b4b56b615317b9", 1000);
  }

  var_29b310c42d26af91 = getEntArray("explosion_off_lights", "script_noteworthy");

  foreach(light in var_29b310c42d26af91) {
    light setlightintensity(0);
  }

  thread function_238c2a0aae70e973("moon_rims", 0, 0);
  thread function_238c2a0aae70e973("court_yard_2_main", 1, 1600);
  thread function_238c2a0aae70e973("main_court_arch_lights", 0, 300);
  var_6906a60962d199f0 = getEntArray("helicopter_main_lights", "script_noteworthy");

  foreach(light in var_6906a60962d199f0) {
    light setlightintensity(238);
  }
}

function function_147aa773e6654f84() {
  flag_wait("flag_courtyard_jet_strike_hit");

  if(isplatformxb3() || isplatformps4()) {
    thread function_238c2a0aae70e973("tower_explosion_light", 0, 199);
  }

  thread tower_explosion_look();
  thread function_4592ed3200c60f5("courtyard_castle_spot_light_r", 0.25, (1, 0.7, 0.45));
  thread function_238c2a0aae70e973("main_court_arch_lights", 15, 0);
}

function function_60af931d01bdcc63() {
  self endon("kill_castle_courtyard_spotlight");
  setsaveddvar(@ "hash_e08232af8b8b695c", 3);
  exploder("mg_nest_light");
  flag_wait("flag_courtyard_arrive_mg_passed");
  stop_exploder("mg_nest_light");
  wait 0.1;
  exploder("mg_nest_light_move");
  flag_wait("flag_courtyard_opening_view_reached");
  stop_exploder("mg_nest_light_move");
  wait 0.1;
  exploder("mg_nest_light");
  flag_wait("flag_courtyard_jet_strike_hit");
  stop_exploder("mg_nest_light");
}

function function_ef38136354fc0472() {
  if(isplatformxb3() || isplatformps4()) {
    thread function_60af931d01bdcc63();
    return;
  }

  self endon("kill_castle_courtyard_spotlight");
  setsaveddvar(@ "hash_e08232af8b8b695c", 3);
  wait 0.1;
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_r", 0, 0);
  first_light = getEnt("courtyard_castle_spot_light_l", "targetname");
  first_light rotateby((20, 20, 0), 0.05);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_l", 0, 10000);
  flag_wait("flag_courtyard_arrive_mg_pre_intro");
  first_light rotateby((-20, -20, 0), 1);
  exploder("mg_nest_light");
  light2 = getEnt("courtyard_castle_spot_light_2", "targetname");
  light2 rotateby((0, 22, 0), 0.5);
  flag_wait("flag_couryard_elevator_exit_spotlight_move");
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_l", 0.5, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0.5, 10000);
  light2 rotateby((0, -22, 0), 1.5, 0.25, 0.25);
  wait 1.5;
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0.5, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_r", 0.5, 10000);
  flag_wait("flag_courtyard_arrive_mg_passed");
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_r", 0.25, 0);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0.25, 10000);
  wait 0.25;
  light2 rotateby((0, 60, 0), 2, 0.25, 0.25);
  stop_exploder("mg_nest_light");
  wait 0.1;
  exploder("mg_nest_light_move");
  flag_wait("flag_courtyard_opening_view_reached");
  stop_exploder("mg_nest_light_move");
  wait 0.1;
  exploder("mg_nest_light");
  light2 rotateby((0, -60, 0), 1.25, 0.25, 0.25);
  wait 1.25;
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_r", 0.5, 10000);
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_2", 0.5, 0);
  flag_wait("flag_courtyard_jet_strike_hit");
  thread function_238c2a0aae70e973("courtyard_castle_spot_light_r", 0.5, 0);
  stop_exploder("mg_nest_light");
}

function function_d45d714d5f9f83e2() {}

function function_13455f3d1172f088() {}

function trig_heli_searchlight_hallway() {
  wait 0.05;
  run_thread_on_targetname("TRIG_heli_searchlight_hallway", &heli_searchlight_hallway);
}

function heli_searchlight_hallway() {
  while(true) {
    self waittill("trigger");
    light = getEnt("lgt_heli_searchlight_hallway", "targetname");
    left_pos = getStruct("heli_searchlight_hallway_left", "targetname");
    right_pos = getStruct("heli_searchlight_hallway_right", "targetname");
    thread function_c4d3fdabc1d2f662();
    flag_set("flag_heli_light_off");
    wait 0.1;
    thread function_238c2a0aae70e973("lgt_heli_searchlight_hallway", 0, 6000);
    set_vision_naked("sp_jup_vip_ext_heli_int", 1);
    thread function_2f94857fc380e4dd(light, right_pos, left_pos);

    while(level.player istouching(self)) {
      waitframe();
    }

    level.player notify("stop lerp");
    thread function_238c2a0aae70e973("lgt_heli_searchlight_hallway", 0, 0);
  }
}

function function_2f94857fc380e4dd(light, right_pos, left_pos) {
  level.player endon("stop lerp");

  while(true) {
    thread function_a42590e4d2476219(light, 8, right_pos.origin);
    wait 9.1;
    thread function_a42590e4d2476219(light, 8, left_pos.origin);
    wait 9.1;
  }
}

function function_3df5b0f22c612e83(animnode) {
  flag_wait("flag_escape_tunnel_enter");
  wait 0.1;
  jeep = animnode scene::get_entity("Prop 2");
  playFXOnTag(getfx("vfx_vip_lensflare_headlight_white"), jeep, "tag_light_front_right");
  playFXOnTag(getfx("vfx_vip_lensflare_headlight_white"), jeep, "tag_light_front_left");
  flag_wait("lgt_escape_jeep_explosion");
  stopFXOnTag(getfx("vfx_vip_lensflare_headlight_white"), jeep, "tag_light_front_right");
  stopFXOnTag(getfx("vfx_vip_lensflare_headlight_white"), jeep, "tag_light_front_left");
}

function function_11dcec639f444f8a() {
  wait 0.05;
}

function function_f60b53b288e2bf21() {
  while(true) {
    self waittill("trigger");
    flag_set("wind_on");
    wait 0.1;
  }
}

function trig_flare_adjust_down() {
  wait 0.05;
  run_thread_on_targetname("TRIG_flare_adjust_down", &flare_adjust_down);
}

function flare_adjust_down() {
  while(true) {
    self waittill("trigger");
    wait 0.05;
    wait 0.1;
    flag_wait("cine_exfil_start");
    function_1d321dd7f8b825ce("flare_exil", "lgt_exfil_visibility", 0);
    function_1d321dd7f8b825ce("flare_exil", "lgt_heli_explosion_boat", 0);
  }
}

function lightning_cliff_trig() {
  wait 0.05;
  run_thread_on_targetname("lightning_cliff_trig", &function_d0b9cc155ce83597);
}

function function_d0b9cc155ce83597() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_ext_cliff", 1);
    thread function_238c2a0aae70e973("hallway_window_lights", 2.5, 0);
    function_36552610035fd32e(0.6, 0.12, 3);

    while(level.player istouching(self)) {
      wait 0.05;
    }

    wait 0.1;
  }
}

function lightning_cliff_trig_int() {
  wait 0.05;
  run_thread_on_targetname("lightning_cliff_trig_int", &function_fbb3c46273189b6e);
}

function function_fbb3c46273189b6e() {
  while(true) {
    self waittill("trigger");
    set_vision_naked("sp_jup_vip_ext_heli_int", 1);
    thread function_238c2a0aae70e973("hallway_window_lights", 5, 16);

    while(level.player istouching(self)) {
      wait 0.05;
    }

    wait 0.1;
  }
}

function courtyard_riot_searchlight() {
  flag_wait("flag_courtyard_jet_strike_hit");
  wait 2;

  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  self endon("kill_courtyard_riot_searchlight");
  flag_wait("flag_courtyard_jet_strike_hit");
  wait 3;
  light = getEnt("lgt_courtyard_riot_searchlight", "targetname");
  light setlightfovrange(14, 7);
  thread function_238c2a0aae70e973("lgt_courtyard_riot_searchlight", 0.5, 35000);
  fixture = getEnt("courtyard_spot_fixture_set_1", "targetname");
  var_87e18f7f96861f52 = utility::spawn_tag_origin(light.origin, light.angles);
  var_87e18f7f96861f52 linkTo(light, "", (0, 0, 0), (90, 0, 0));
  playFXOnTag(getfx("vfx_vip_light_searchlight_wall_03"), var_87e18f7f96861f52, "tag_origin");

  for(;;) {
    light rotateby((10, 45, 0), 5, 0.5, 0.5);
    fixture rotateby((0, 30, 0), 5, 0.5, 0.5);
    wait 5.1;
    light rotateby((-10, -45, 0), 5, 0.5, 0.5);
    fixture rotateby((0, -30, 0), 5, 0.5, 0.5);
    wait 5.1;
    light rotateby((20, 20, 0), 4, 0.5, 0.5);
    fixture rotateby((0, 30, 0), 4, 0.5, 0.5);
    wait 4.1;
    light rotateby((-20, -20, 0), 3, 0.5, 0.5);
    fixture rotateby((0, -30, 0), 3, 0.5, 0.5);
    wait 3.1;
  }
}

function courtyard_riot_searchlight_2() {
  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  wait 3;
  light = getEnt("lgt_courtyard_riot_searchlight_2", "targetname");
  light setlightfovrange(14, 7);
  thread function_238c2a0aae70e973("lgt_courtyard_riot_searchlight_2", 0.5, 35000);

  for(;;) {
    light rotateby((10, 60, 0), 5);
    wait 5;
    light rotateby((0, -60, 0), 5);
    wait 5;
    light rotateby((20, 20, 0), 4);
    wait 4;
    light rotateby((0, -30, 0), 3);
    wait 3;
  }
}

function courtyard_riot_searchlight_3() {
  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  self endon("kill_courtyard_riot_searchlight");
  light = getEnt("lgt_courtyard_riot_searchlight_3", "targetname");
  light setlightfovrange(14, 7);
  thread function_238c2a0aae70e973("lgt_courtyard_riot_searchlight_3", 0.5, 35000);
  setsaveddvar(@ "hash_5a83a561cb4970b2", 5000);
}

function function_dbeae3a14de2795() {
  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  level endon("stop_cliff_light");
  light = getEnt("lgt_cliff_searchlight_boat", "targetname");
  light setlightfovrange(14, 7);
  level.var_da899bc761c2a722 = light.angles;
  thread function_238c2a0aae70e973("lgt_cliff_searchlight_boat", 0.5, 3250000);

  for(;;) {
    light rotateby((5, 10, 0), 5, 0.5, 0.5);
    wait 5.1;
    light rotateby((-5, -10, 0), 5, 0.5, 0.5);
    wait 5.1;
    light rotateby((10, 5, 0), 4, 0.5, 0.5);
    wait 4.1;
    light rotateby((-10, -5, 0), 3, 0.5, 0.5);
    wait 3.1;
  }
}

function function_c4d3fdabc1d2f662() {
  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  light = getEnt("lgt_cliff_searchlight", "targetname");
  light setlightfovrange(14, 7);
  thread function_238c2a0aae70e973("lgt_cliff_searchlight", 0.5, 35000);
  fixture = getEnt("courtyard_spot_fixture_set_2", "targetname");
  var_87e18f7f96861f52 = utility::spawn_tag_origin(light.origin, light.angles);
  var_87e18f7f96861f52 linkTo(light, "", (0, 0, 0), (90, 0, 0));
  playFXOnTag(getfx("vfx_vip_light_searchlight_wall_03"), var_87e18f7f96861f52, "tag_origin");

  for(;;) {
    light rotateby((20, 20, 0), 5, 0.5, 0.5);
    fixture rotateby((0, 20, 0), 5, 0.5, 0.5);
    wait 5.1;
    light rotateby((-20, -20, 0), 5, 0.5, 0.5);
    fixture rotateby((0, -20, 0), 5, 0.5, 0.5);
    wait 5.1;
    light rotateby((20, 20, 0), 4, 0.5, 0.5);
    fixture rotateby((0, 20, 0), 5, 0.5, 0.5);
    wait 4.1;
    light rotateby((-20, -20, 0), 3, 0.5, 0.5);
    fixture rotateby((0, -20, 0), 5, 0.5, 0.5);
    wait 3.1;
  }
}

function lgt_cliff_searchlight_slide() {
  flag_wait("flag_escape_cliff_heli_hide");

  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  light = getEnt("lgt_cliff_searchlight_slide", "targetname");
  light setlightfovrange(14, 7);
  thread function_238c2a0aae70e973("lgt_cliff_searchlight_slide", 0.5, 35000);
  flag_wait("lgt_slide_start");
  light rotateby((0, -10, 0), 2, 0.5, 0.5);
}

function function_99c076d43d9443fc() {
  thread function_238c2a0aae70e973("lgt_cliff_searchlight_3", 0.5, 7000);
  thread function_238c2a0aae70e973("lgt_cliff_searchlight_3_move", 0.5, 15000);

  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  setsaveddvar(@ "hash_63eb1893f96ac98d", 8);
  setsaveddvar(@ "hash_e08232af8b8b695c", 6);
  light = getEnt("lgt_cliff_searchlight_3_move", "targetname");
}

function scriptable_callback() {
  wait 0.1;

  if(!flag_exist("scriptables_ready")) {
    flag_init("scriptables_ready");
  }

  flag_set("scriptables_ready");
}

function wind_manage() {
  flag_wait("scriptables_ready");

  for(;;) {
    flag_wait("wind_on");

    if(isDefined(level.ally1)) {
      level.ally1 setscriptablepartstate("wind", "100", 0);
    }

    if(isDefined(level.ally2)) {
      level.ally2 setscriptablepartstate("wind", "100", 0);
    }

    if(isDefined(level.makarov)) {
      level.makarov setscriptablepartstate("wind", "50", 0);
    }

    while(flag("wind_on")) {
      waitframe();
    }

    if(isDefined(level.ally1)) {
      level.ally1 setscriptablepartstate("wind", "0", 0);
    }

    if(isDefined(level.ally2)) {
      level.ally2 setscriptablepartstate("wind", "0", 0);
    }

    if(isDefined(level.makarov)) {
      level.makarov setscriptablepartstate("wind", "0", 0);
    }
  }
}

function function_71491682f17da12d() {
  wait 1;
  level scripts\common\ai::function_4dcca048a83a2f3c(10);
}

function function_378f7c813ed7ee71() {
  if(level.start_point == "heli_crash") {
    scripts\common\ai::function_4dcca048a83a2f3c(10);
  }

  for(i = 9; i > 0; i--) {
    scripts\common\ai::function_4dcca048a83a2f3c(i);
    wait 1.25;
  }

  scripts\common\ai::function_4dcca048a83a2f3c(0);
}

function function_c6f9355bddd9ddf2() {
  flag_wait("lgt_slide_start");
  set_vision_naked("sp_jup_vip_ext_cliff_slide", 0.25);
  level notify("stop_cliff_light");
  thread function_238c2a0aae70e973("lgt_cliff_searchlight", 0, 0);
  animnode = utility::getStruct("scene_vip_exfil_leapoffaith", "targetname");
  waitframe();
  boat = animnode scene::get_entity("Prop 2");
  flag_wait("lgt_hit_water_slide");
  level.player setblurforplayer(5, 0);
  thread vision::set_vision_naked("sp_jup_vip_exfil_cine_underwater", 0);
  level notify("stop_cliff_light");
}

function target_boat(boat, light) {
  level endon("stop_cliff_light");
  setsaveddvar(@ "hash_5a83a561cb4970b2", 2000);
  light rotateTo(level.var_da899bc761c2a722, 0.25);
  wait 0.5;
  light rotateby((7, 25, 0), 5, 0.5, 0.5);
}

function tower_explosion_look() {
  trigger = getEnt("tower_explosion_look", "targetname");
  trigger.script_dot = 0.3;

  if(flag("tower_explosion_look")) {
    setsaveddvar(@ "hash_351ca4838eccf185", 1);
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 3, 0.25);
    thread vision::set_vision_naked("sp_jup_vip_ext_court2_orange", 0.3);
    wait 0.35;
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 1, 1);
    thread vision::set_vision_naked("sp_jup_vip_ext_court2", 1);
    wait 1;
    setsaveddvar(@ "hash_351ca4838eccf185", 0);
  }
}

function truck_explosion_look() {
  trigger = getEnt("truck_explosion_look", "targetname");
  trigger.script_dot = 0.3;

  if(flag("truck_explosion_look")) {
    setsaveddvar(@ "hash_351ca4838eccf185", 1);
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 3, 0.25);
    thread vision::set_vision_naked("sp_jup_vip_ext_court2_orange", 0.3);
    wait 0.35;
    thread lerp_dvar(@ "hash_def5bdc115ba2abb", 1, 1);
    thread vision::set_vision_naked("sp_jup_vip_ext_court2", 1);
    wait 1;
    setsaveddvar(@ "hash_351ca4838eccf185", 0);
  }
}

function function_f20723b6b8a2349e() {
  wait 0.05;
  thread function_238c2a0aae70e973("courtyard2_light_01", 0, 16);
  thread function_238c2a0aae70e973("courtyard2_light_02", 0, 40);
  thread function_238c2a0aae70e973("courtyard2_light_03", 0, 20);
  thread function_238c2a0aae70e973("courtyard2_light_04", 0, 12);
  thread function_238c2a0aae70e973("courtyard2_light_05", 0, 80);
}

function function_a19904f15da81f7d(actors, anim_node) {
  actor_1 = anim_node scene::get_entity("Actor 1");
  actor_2 = anim_node scene::get_entity("Actor 2");
  actor_3 = anim_node scene::get_entity("Actor 3");
  actors_array = [actor_1, actor_2, actor_3];
  actors = array_combine(actors, actors_array);

  foreach(var_ae50a2bd65179a44 in actors) {
    scripts\common\visibility_mode::function_8ba05ef17e2b7d10(var_ae50a2bd65179a44, "allies");
  }
}

function function_1bb3d949f3e37969() {
  wait 0.05;
  scuba_lights = getEntArray("scuba_lights_to_delete", "script_noteworthy");

  foreach(light in scuba_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }
}

function function_79294f88498b3155() {
  wait 0.05;
  var_66a8d21e4c78a9d1 = getEntArray("wall_climb_lights_to_delete", "script_noteworthy");

  foreach(light in var_66a8d21e4c78a9d1) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  wall_top_ai_rim_1 = getEntArray("wall_top_ai_rim_1", "script_noteworthy");

  foreach(light in wall_top_ai_rim_1) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  wall_top_ai_key = getEntArray("wall_top_ai_key", "script_noteworthy");

  foreach(light in wall_top_ai_key) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  lgt_rappel_climb_red_rim_1 = getEntArray("lgt_rappel_climb_red_rim_1", "script_noteworthy");

  foreach(light in lgt_rappel_climb_red_rim_1) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  lgt_rappel_climb_red_rim_2 = getEntArray("lgt_rappel_climb_red_rim_2", "script_noteworthy");

  foreach(light in lgt_rappel_climb_red_rim_2) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }
}

function function_68aeea781acf5933() {
  wait 0.05;
  groundfloor_spots = getEntArray("groundfloor_spots", "script_noteworthy");

  foreach(light in groundfloor_spots) {
    light setlightintensity(0);
    wait 0.1;
  }

  top_floor_lights = getEntArray("top_floor_lights", "script_noteworthy");

  foreach(light in top_floor_lights) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  red_hall_spots = getEntArray("red_hall_spots", "script_noteworthy");

  foreach(light in red_hall_spots) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }

  var_9a976b0fc856f4d0 = getEntArray("2nd_floor_lights", "script_noteworthy");

  foreach(light in var_9a976b0fc856f4d0) {
    light setlightintensity(0);
    wait 0.1;
  }

  var_f20d14ecdb49f359 = getEntArray("3rd_floor_lights", "script_noteworthy");

  foreach(light in var_f20d14ecdb49f359) {
    light setlightintensity(0);
    wait 0.1;
  }

  bttm_floor_lights = getEntArray("bttm_floor_lights", "script_noteworthy");

  foreach(light in bttm_floor_lights) {
    light setlightintensity(0);
    wait 0.1;
  }

  var_f301d1558fcbb574 = getEntArray("4th_floor_lights", "script_noteworthy");

  foreach(light in var_f301d1558fcbb574) {
    light setlightintensity(0);
    wait 0.1;
  }

  descend_lights_to_delete = getEntArray("descend_lights_to_delete", "script_noteworthy");

  foreach(light in descend_lights_to_delete) {
    light setlightintensity(0);
    wait 0.1;
    light delete();
  }
}