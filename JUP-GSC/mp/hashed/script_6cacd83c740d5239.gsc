/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6cacd83c740d5239.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_16ea1b94f0f381b3;
#using script_482376d10f69832c;
#using script_485622d93fa7e4cf;
#using script_4e6e58ab5d96c2b0;
#using script_4fdefae8b7bcdf73;
#using script_62a4f7a62643fe8;
#using script_638d701d263ee1ed;
#using script_9880b9dc28bc25e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\radiation;
#using scripts\cp_mp\uav_tower;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;
#using scripts\ob\ob_seismic_refractor;
#namespace namespace_decffbd4da6d3d16;

function function_2f205c99223eecc7() {}

function main() {
  thread function_8e53068481e83586();
  thread function_6523b8640406fce4();

  level.var_b4afbe308b4c542a = &function_b4afbe308b4c542a;
  level.var_ef7d03b5335531d2 = 0;
  thread function_3cfa9c416247ce77();
  spawn_console();
  thread function_73dfb744cf41525();
  function_ab2955d940ad61f2();
  script_model_anims();
  function_16b9f31835245160();
}

function function_232713911389065c() {}

function spawn_console() {
  wait 15;
  level.var_6697599cde12f9a8 = 0;
  level.var_d510de4414247a2d = 0;
  level.var_806a13ff1252a70a = 0;
  level.var_806a12ff1252a4d7 = 0;
  level.var_806a11ff1252a2a4 = 0;
  level.var_806a10ff1252a071 = 0;
  level.var_efca71ee5d38dbb1 = [];
  level.var_efca71ee5d38dbb1["red"] = [];
  level.var_efca71ee5d38dbb1["yellow"] = [];
  level.var_efca71ee5d38dbb1["green"] = [];
  level.var_efca71ee5d38dbb1["all"] = [];
  level.var_a7ab09ae8140b4f7 = getStructArray("summon_console_red_controller", "target");
  var_723f578c14e7d40e = array_randomize(level.var_a7ab09ae8140b4f7);

  for(i = 0; i < 1; i++) {
    spawn_struct = var_723f578c14e7d40e[i];
    level.var_9a6115f51cb10d62 = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
    level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
    level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower", "unusable");
    up_offset = anglestoup(level.var_9a6115f51cb10d62.angles) * 40;
    forward_offset = anglestoright(level.var_9a6115f51cb10d62.angles) * 40;
    interact_console = register_interact(level.var_9a6115f51cb10d62.origin + up_offset + forward_offset, 110, &function_22523c7bd811ca4a);
    interact_console sethintonobstruction("show");
    interact_console scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c866bbce92024fe);
    interact_console.console_d = level.var_9a6115f51cb10d62;
    level.var_9a6115f51cb10d62.spawn_struct = spawn_struct;
    level.var_efca71ee5d38dbb1["red"] = array_add(level.var_efca71ee5d38dbb1["red"], level.var_9a6115f51cb10d62);
    level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_9a6115f51cb10d62);
    level.var_d510de4414247a2d++;
  }

  level.var_7e14d04a2e11bebe = getStructArray("summon_console_yellow_controller", "target");
  var_19a8d3c0b77792eb = array_randomize(level.var_7e14d04a2e11bebe);
  var_4203e2fc6864dd0f = randomintrange(1, 3);

  if(var_4203e2fc6864dd0f == 2) {
    spawn_struct = var_19a8d3c0b77792eb[0];
    level.var_192e515036e31e45 = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
    level.var_192e515036e31e45 setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
    level.var_192e515036e31e45 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    level.var_192e515036e31e45 setscriptablepartstate("dmz_uav_tower", "unusable");
    up_offset = anglestoup(level.var_192e515036e31e45.angles) * 40;
    forward_offset = anglestoright(level.var_192e515036e31e45.angles) * 40;
    var_e38c6d2c464e06c6 = register_interact(level.var_192e515036e31e45.origin + up_offset + forward_offset, 110, &function_2252367bd811bd18);
    var_e38c6d2c464e06c6 sethintonobstruction("show");
    var_e38c6d2c464e06c6 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c866dbce9202964);
    level.var_192e515036e31e45.spawn_struct = spawn_struct;
    level.var_efca71ee5d38dbb1["yellow"] = array_add(level.var_efca71ee5d38dbb1["yellow"], level.var_192e515036e31e45);
    level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_192e515036e31e45);
    var_e38c6d2c464e06c6.console_b = level.var_192e515036e31e45;
    level.var_d510de4414247a2d++;
    spawn_struct = var_19a8d3c0b77792eb[1];
    level.var_bb623a50aebf49cf = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
    level.var_bb623a50aebf49cf setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
    level.var_bb623a50aebf49cf setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    level.var_bb623a50aebf49cf setscriptablepartstate("dmz_uav_tower", "unusable");
    up_offset = anglestoup(level.var_192e515036e31e45.angles) * 40;
    forward_offset = anglestoright(level.var_192e515036e31e45.angles) * 40;
    var_4e4e942d503cebfc = register_interact(level.var_bb623a50aebf49cf.origin + up_offset + forward_offset, 110, &function_2252377bd811bf4b);
    var_4e4e942d503cebfc sethintonobstruction("show");
    var_4e4e942d503cebfc scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c866ebce9202b97);
    level.var_bb623a50aebf49cf.spawn_struct = spawn_struct;
    level.var_efca71ee5d38dbb1["yellow"] = array_add(level.var_efca71ee5d38dbb1["yellow"], level.var_bb623a50aebf49cf);
    level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_bb623a50aebf49cf);
    var_4e4e942d503cebfc.console_c = level.var_bb623a50aebf49cf;
    level.var_d510de4414247a2d++;
  } else {
    for(i = 0; i < 1; i++) {
      spawn_struct = var_19a8d3c0b77792eb[i];
      level.var_9a6115f51cb10d62 = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
      level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
      level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
      level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower", "unusable");
      up_offset = anglestoup(level.var_9a6115f51cb10d62.angles) * 40;
      forward_offset = anglestoright(level.var_9a6115f51cb10d62.angles) * 40;
      interact_console = register_interact(level.var_9a6115f51cb10d62.origin + up_offset + forward_offset, 110, &function_2252377bd811bf4b);
      interact_console sethintonobstruction("show");
      interact_console scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c866ebce9202b97);
      interact_console.console_c = level.var_9a6115f51cb10d62;
      level.var_9a6115f51cb10d62.spawn_struct = spawn_struct;
      level.var_efca71ee5d38dbb1["yellow"] = array_add(level.var_efca71ee5d38dbb1["yellow"], level.var_9a6115f51cb10d62);
      level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_9a6115f51cb10d62);
      level.var_d510de4414247a2d++;
    }
  }

  level.var_54b012aabe52bf47 = getStructArray("summon_console_green_controller", "target");
  var_fd2a32f00dc7a34e = array_randomize(level.var_54b012aabe52bf47);

  if(level.var_d510de4414247a2d == 2) {
    spawn_struct = var_fd2a32f00dc7a34e[0];
    level.var_192e515036e31e45 = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
    level.var_192e515036e31e45 setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
    level.var_192e515036e31e45 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    level.var_192e515036e31e45 setscriptablepartstate("dmz_uav_tower", "unusable");
    up_offset = anglestoup(level.var_192e515036e31e45.angles) * 40;
    forward_offset = anglestoright(level.var_192e515036e31e45.angles) * 40;
    var_e38c6d2c464e06c6 = register_interact(level.var_192e515036e31e45.origin + up_offset + forward_offset, 110, &function_2252367bd811bd18);
    var_e38c6d2c464e06c6 sethintonobstruction("show");
    var_e38c6d2c464e06c6 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c866dbce9202964);
    var_e38c6d2c464e06c6.console_b = level.var_192e515036e31e45;
    level.var_192e515036e31e45.spawn_struct = spawn_struct;
    level.var_efca71ee5d38dbb1["green"] = array_add(level.var_efca71ee5d38dbb1["green"], level.var_192e515036e31e45);
    level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_192e515036e31e45);
    level.var_d510de4414247a2d++;
    spawn_struct = var_fd2a32f00dc7a34e[1];
    level.var_bb623a50aebf49cf = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
    level.var_bb623a50aebf49cf setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
    level.var_bb623a50aebf49cf setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    level.var_bb623a50aebf49cf setscriptablepartstate("dmz_uav_tower", "unusable");
    up_offset = anglestoup(level.var_192e515036e31e45.angles) * 40;
    forward_offset = anglestoright(level.var_192e515036e31e45.angles) * 40;
    var_4e4e942d503cebfc = register_interact(level.var_bb623a50aebf49cf.origin + up_offset + forward_offset, 110, &function_2252397bd811c3b1);
    var_4e4e942d503cebfc sethintonobstruction("show");
    var_4e4e942d503cebfc scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c8670bce9202ffd);
    var_4e4e942d503cebfc.console_a = level.var_bb623a50aebf49cf;
    level.var_bb623a50aebf49cf.spawn_struct = spawn_struct;
    level.var_efca71ee5d38dbb1["green"] = array_add(level.var_efca71ee5d38dbb1["green"], level.var_bb623a50aebf49cf);
    level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_bb623a50aebf49cf);
    level.var_d510de4414247a2d++;
    return;
  }

  for(i = 0; i < 1; i++) {
    spawn_struct = var_fd2a32f00dc7a34e[i];
    level.var_9a6115f51cb10d62 = spawnscriptable("dmz_uav_tower_summon", spawn_struct.origin, spawn_struct.angles);
    level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
    level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    level.var_9a6115f51cb10d62 setscriptablepartstate("dmz_uav_tower", "unusable");
    up_offset = anglestoup(level.var_9a6115f51cb10d62.angles) * 40;
    forward_offset = anglestoright(level.var_9a6115f51cb10d62.angles) * 40;
    interact_console = register_interact(level.var_9a6115f51cb10d62.origin + up_offset + forward_offset, 110, &function_2252397bd811c3b1);
    interact_console sethintonobstruction("show");
    interact_console scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_2c8670bce9202ffd);
    interact_console.console_a = level.var_9a6115f51cb10d62;
    level.var_9a6115f51cb10d62.spawn_struct = spawn_struct;
    level.var_efca71ee5d38dbb1["green"] = array_add(level.var_efca71ee5d38dbb1["green"], level.var_9a6115f51cb10d62);
    level.var_efca71ee5d38dbb1["all"] = array_add(level.var_efca71ee5d38dbb1["all"], level.var_9a6115f51cb10d62);
    level.var_d510de4414247a2d++;
  }
}

function function_2252397bd811c3b1(player) {
  if(level.var_806a13ff1252a70a == 1) {
    iprintlnbold("<dev string:x1c>");

    return;
  } else {
    level.var_806a13ff1252a70a = 1;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
    self.console_a scripts\cp_mp\uav_tower::function_678ea4319b42dfed(player);
    wait 1.5;
    self.console_a setscriptablepartstate("dmz_uav_tower_antenna", "active_end");
    self.console_a setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
    wait 1;

    iprintlnbold("<dev string:x28>");

    itembundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_a");
    common_item::function_c465d27f3f6066b4(itembundle, self.console_a.origin + (0, 5, -16), self.console_a.angles + (0, -100, 0), undefined, undefined, undefined, function_59a2e61d79065dca());
  }

  thread function_bf7e8c05c1eb9c09(player);

  if(!player ent_flag("used_console_a")) {
    console_audio(player);
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(player in squad) {
      player ent_flag_set("used_console_a");
    }
  }
}

function function_2252367bd811bd18(player) {
  if(level.var_806a12ff1252a4d7 == 1) {
    iprintlnbold("<dev string:x1c>");

    return;
  } else {
    level.var_806a12ff1252a4d7 = 1;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
    self.console_b scripts\cp_mp\uav_tower::function_678ea4319b42dfed(player);
    wait 1.5;
    self.console_b setscriptablepartstate("dmz_uav_tower_antenna", "active_end");
    self.console_b setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
    wait 1;

    iprintlnbold("<dev string:x28>");

    itembundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_b");
    common_item::function_c465d27f3f6066b4(itembundle, self.console_b.origin + (0, 5, -16), self.console_b.angles + (0, -100, 0), undefined, undefined, undefined, function_59a2e61d79065dca());
  }

  thread function_5eb2076c0952dd6a(player);

  if(!player ent_flag("used_console_b")) {
    console_audio(player);
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(player in squad) {
      player ent_flag_set("used_console_b");
    }
  }
}

function function_2252377bd811bf4b(player) {
  if(level.var_806a11ff1252a2a4 == 1) {
    iprintlnbold("<dev string:x1c>");

    return;
  } else {
    level.var_806a11ff1252a2a4 = 1;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
    self.console_c scripts\cp_mp\uav_tower::function_678ea4319b42dfed(player);
    wait 1.5;
    self.console_c setscriptablepartstate("dmz_uav_tower_antenna", "active_end");
    self.console_c setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
    wait 1;

    iprintlnbold("<dev string:x28>");

    itembundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_c");
    common_item::function_c465d27f3f6066b4(itembundle, self.console_c.origin + (0, 5, -16), self.console_c.angles + (0, -100, 0), undefined, undefined, undefined, function_59a2e61d79065dca());
  }

  thread function_8eba9838d1d843f(player);

  if(!player ent_flag("used_console_c")) {
    console_audio(player);
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(player in squad) {
      player ent_flag_set("used_console_c");
    }
  }
}

function function_22523c7bd811ca4a(player) {
  if(level.var_806a10ff1252a071 == 1) {
    iprintlnbold("<dev string:x1c>");

    return;
  } else {
    level.var_806a10ff1252a071 = 1;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
    self.console_d scripts\cp_mp\uav_tower::function_678ea4319b42dfed(player);
    wait 1.5;
    self.console_d setscriptablepartstate("dmz_uav_tower_antenna", "active_end");
    self.console_d setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
    wait 1;

    iprintlnbold("<dev string:x28>");

    itembundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_d");
    common_item::function_c465d27f3f6066b4(itembundle, self.console_d.origin + (0, 5, -16), self.console_d.angles + (0, -100, 0), undefined, undefined, undefined, function_59a2e61d79065dca());
    player ent_flag_set("consoleused");
  }

  thread function_66dee4959045fe18(player);

  if(!player ent_flag("used_console_d")) {
    console_audio(player);
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(player in squad) {
      player ent_flag_set("used_console_d");
    }
  }
}

function function_2c8670bce9202ffd(interact, player) {
  if(level.var_806a13ff1252a70a == 1) {
    return {
      #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_COOLDOWN", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_ACTIVATE", #type: "HINT_BUTTON"};
}

function function_2c866dbce9202964(interact, player) {
  if(level.var_806a12ff1252a4d7 == 1) {
    return {
      #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_COOLDOWN", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_ACTIVATE", #type: "HINT_BUTTON"};
}

function function_2c866ebce9202b97(interact, player) {
  if(level.var_806a11ff1252a2a4 == 1) {
    return {
      #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_COOLDOWN", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_ACTIVATE", #type: "HINT_BUTTON"};
}

function function_2c866bbce92024fe(interact, player) {
  if(level.var_806a10ff1252a071 == 1) {
    return {
      #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_COOLDOWN", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_OBJECTIVES/SUMMON_CONSOLE_ACTIVATE", #type: "HINT_BUTTON"};
}

function function_bf7e8c05c1eb9c09(player) {
  wait 75;
  level.var_806a13ff1252a70a = 0;
  self.console_a setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
  self.console_a setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
}

function function_5eb2076c0952dd6a(player) {
  wait 75;
  level.var_806a12ff1252a4d7 = 0;
  self.console_b setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
  self.console_b setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
}

function function_8eba9838d1d843f(player) {
  wait 75;
  level.var_806a11ff1252a2a4 = 0;
  self.console_c setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
  self.console_c setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
}

function function_66dee4959045fe18(player) {
  wait 75;
  level.var_806a10ff1252a071 = 0;
  self.console_d setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
  self.console_d setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
}

function function_ab2955d940ad61f2() {
  wait 10;
  level.var_9e0fc4d14807024b = getStruct("map_location_1_a", "targetname");
  level.var_a9b819d14f871b7a = getStruct("map_location_2_a", "targetname");
  level.var_bae032d15d137d75 = getStruct("map_location_3_a", "targetname");
  level.var_557b0fd112cf7e3c = getStruct("map_location_4_a", "targetname");
  level.var_2293749bbb99f40c = getStructArray("map_location_1", "script_noteworthy");
  level.var_2293779bbb99faa5 = getStructArray("map_location_2", "script_noteworthy");
  level.var_2293769bbb99f872 = getStructArray("map_location_3", "script_noteworthy");
  level.var_2293719bbb99ed73 = getStructArray("map_location_4", "script_noteworthy");
  level.var_30c15da1298fa375 = getStructArray("map_controller", "target");
  function_d46e216e83569779(level.var_30c15da1298fa375);
}

function function_d46e216e83569779(var_bf4e6fa2365b2d5d) {
  var_ee641b753ff9cd = var_bf4e6fa2365b2d5d;
  level.var_3bce2c412b396473 = [];
  var_add17afc802acd84 = getStructArray("red_map_pin_1", "script_noteworthy");
  var_add17dfc802ad41d = getStructArray("red_map_pin_2", "script_noteworthy");
  var_add17cfc802ad1ea = getStructArray("red_map_pin_3", "script_noteworthy");
  var_c552e69136deea11 = getStructArray("yellow_map_pin_1", "script_noteworthy");
  var_c552e39136dee378 = getStructArray("yellow_map_pin_2", "script_noteworthy");
  var_c552e49136dee5ab = getStructArray("yellow_map_pin_3", "script_noteworthy");
  var_c552e99136def0aa = getStructArray("yellow_map_pin_4", "script_noteworthy");
  var_5c0a199b19108434 = getStructArray("green_map_pin_1", "script_noteworthy");
  var_5c0a1c9b19108acd = getStructArray("green_map_pin_2", "script_noteworthy");
  var_5c0a1b9b1910889a = getStructArray("green_map_pin_3", "script_noteworthy");
  var_5c0a169b19107d9b = getStructArray("green_map_pin_4", "script_noteworthy");
  var_5c0a159b19107b68 = getStructArray("green_map_pin_5", "script_noteworthy");

  foreach(console in level.var_efca71ee5d38dbb1["red"]) {
    var_1a94055b19df70a0 = array_random(var_ee641b753ff9cd);
    var_4356e749c679aa8d = getStructArray(var_1a94055b19df70a0.script_noteworthy, "script_noteworthy");
    var_ee641b753ff9cd = array_remove(var_ee641b753ff9cd, var_1a94055b19df70a0);

    foreach(map_piece in var_4356e749c679aa8d) {
      if(is_equal(console.spawn_struct.targetname, "red_console_1")) {
        var_560e5c042e0d590c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_560e5c042e0d590c setscriptablepartstate("body", "red_map_1");
      }

      if(is_equal(console.spawn_struct.targetname, "red_console_2")) {
        var_560e5c042e0d590c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_560e5c042e0d590c setscriptablepartstate("body", "red_map_2");
      } else if(is_equal(console.spawn_struct.targetname, "red_console_3")) {
        var_560e5c042e0d590c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_560e5c042e0d590c setscriptablepartstate("body", "red_map_3");
      }

      if(isDefined(var_560e5c042e0d590c)) {
        var_560e5c042e0d590c.spawn_struct = map_piece;
        level.var_3bce2c412b396473 = array_add(level.var_3bce2c412b396473, var_560e5c042e0d590c);
      }
    }
  }

  foreach(console in level.var_efca71ee5d38dbb1["yellow"]) {
    var_1a94055b19df70a0 = array_random(var_ee641b753ff9cd);
    var_4356e749c679aa8d = getStructArray(var_1a94055b19df70a0.script_noteworthy, "script_noteworthy");
    var_ee641b753ff9cd = array_remove(var_ee641b753ff9cd, var_1a94055b19df70a0);

    foreach(map_piece in var_4356e749c679aa8d) {
      if(is_equal(console.spawn_struct.targetname, "yellow_console_1")) {
        var_b9bf6f9289bd152d = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_b9bf6f9289bd152d setscriptablepartstate("body", "yellow_map_1");
      } else if(is_equal(console.spawn_struct.targetname, "yellow_console_2")) {
        var_b9bf6f9289bd152d = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_b9bf6f9289bd152d setscriptablepartstate("body", "yellow_map_2");
      } else if(is_equal(console.spawn_struct.targetname, "yellow_console_3")) {
        var_b9bf6f9289bd152d = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_b9bf6f9289bd152d setscriptablepartstate("body", "yellow_map_3");
      } else if(is_equal(console.spawn_struct.targetname, "yellow_console_4")) {
        var_b9bf6f9289bd152d = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_b9bf6f9289bd152d setscriptablepartstate("body", "yellow_map_4");
      }

      if(isDefined(var_b9bf6f9289bd152d)) {
        var_b9bf6f9289bd152d.spawn_struct = map_piece;
        level.var_3bce2c412b396473 = array_add(level.var_3bce2c412b396473, var_b9bf6f9289bd152d);
      }
    }
  }

  foreach(console in level.var_efca71ee5d38dbb1["green"]) {
    var_1a94055b19df70a0 = array_random(var_ee641b753ff9cd);
    var_4356e749c679aa8d = getStructArray(var_1a94055b19df70a0.script_noteworthy, "script_noteworthy");
    var_ee641b753ff9cd = array_remove(var_ee641b753ff9cd, var_1a94055b19df70a0);

    foreach(map_piece in var_4356e749c679aa8d) {
      if(is_equal(console.spawn_struct.targetname, "green_console_1")) {
        var_bf2860d71b6b5c4c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_bf2860d71b6b5c4c setscriptablepartstate("body", "green_map_1");
      } else if(is_equal(console.spawn_struct.targetname, "green_console_2")) {
        var_bf2860d71b6b5c4c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_bf2860d71b6b5c4c setscriptablepartstate("body", "green_map_2");
      } else if(is_equal(console.spawn_struct.targetname, "green_console_3")) {
        var_bf2860d71b6b5c4c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_bf2860d71b6b5c4c setscriptablepartstate("body", "green_map_3");
      } else if(is_equal(console.spawn_struct.targetname, "green_console_4")) {
        var_bf2860d71b6b5c4c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_bf2860d71b6b5c4c setscriptablepartstate("body", "green_map_4");
      } else if(is_equal(console.spawn_struct.targetname, "green_console_5")) {
        var_bf2860d71b6b5c4c = spawnscriptable("ob_summon_console_map_pieces", map_piece.origin, map_piece.angles);
        var_bf2860d71b6b5c4c setscriptablepartstate("body", "green_map_5");
      }

      if(isDefined(var_bf2860d71b6b5c4c)) {
        var_bf2860d71b6b5c4c.spawn_struct = map_piece;
        level.var_3bce2c412b396473 = array_add(level.var_3bce2c412b396473, var_bf2860d71b6b5c4c);
      }
    }
  }
}

function function_8e53068481e83586(params) {
  wait 5;
  devgui::function_6e7290c8ee4f558b("<dev string:x2f>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x59>", "<dev string:x6d>", &function_7e0ba30f57da7621, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x86>", "<dev string:x9d>", &function_597435b194be1d38, 1);
  devgui::function_fe953f000498048f();
}

function function_7e0ba30f57da7621(params) {
  if(is_equal(level.var_3bce2c412b396473.size, 0)) {
    level.var_30c15da1298fa375 = getStructArray("<dev string:xb8>", "<dev string:xca>");
    function_d46e216e83569779(level.var_30c15da1298fa375);
  }
}

function function_597435b194be1d38(params) {
  if(isDefined(level.var_3bce2c412b396473) && level.var_3bce2c412b396473.size > 0) {
    foreach(scriptable in level.var_3bce2c412b396473) {
      scriptable freescriptable();
      scriptable notify("<dev string:xd4>");
    }

    level.var_3bce2c412b396473 = [];
  }
}

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["uav_tower"] = #animtree;
  level.scr_anim["uav_tower"]["use_uav_tower_enter"] = % dmz_uav_tower_enter;
  level.scr_eventanim["uav_tower"]["use_uav_tower_enter"] = % "use_uav_tower_enter";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_enter"] = "dmz_uav_tower_enter";
  level.scr_anim["uav_tower"]["use_uav_tower_idle"] = % dmz_uav_tower_idle;
  level.scr_eventanim["uav_tower"]["use_uav_tower_idle"] = % "use_uav_tower_idle";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_idle"] = "dmz_uav_tower_idle";
  level.scr_anim["uav_tower"]["use_uav_tower_exit"] = % dmz_uav_tower_exit;
  level.scr_eventanim["uav_tower"]["use_uav_tower_exit"] = % "use_uav_tower_exit";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_exit"] = "dmz_uav_tower_exit";
  level.towerusetime = getdvarfloat(@ "scr_uav_tower_use_time", 1);
  level.var_6acf91bbf5273e8f = getdvarint(@ "hash_bd581b3a13b81db8", 5000);
  level.var_39f69f7dfc40a323 = getdvarint(@ "hash_e466d59282ecb790", 3000);
  level.var_ab2c4542c95656cb = getdvarint(@ "hash_d6193a209d3948a4", 3);
  level.var_20ebe48820fd70a2 = getdvarint(@ "scr_uav_tower_uptime", 40);
  level.var_c5bbb7914cb760cf = getdvarint(@ "hash_25af310c5bc4bc7c", 3);
  level.var_eb56ea0bfdaa4011 = getdvarint(@ "hash_4704cc015db60ad2", 3);
  level.var_174fe9ecce8fb96b = randomintrange(level.var_c5bbb7914cb760cf, level.var_eb56ea0bfdaa4011 + 1);
  level.var_8703df33a53750c6 = getdvarint(@ "hash_f741c76d2b72d5c5", 1);
  level.var_81018c8d037da6c8 = getdvarint(@ "hash_d78433447211bc33", 1);
  level.towercooldown = getmatchrulesdata("commonOption", "uavTowerCooldown");
  level.var_815479da1dafbdb0 = getdvarint(@ "hash_45f42bcb4e5d758d", 1);
  level.var_66bf5bfca21a8d52 = getdvarint(@ "hash_c7c9d45312dd7ec", 1);
  level.var_d507e35282b50614 = getdvarint(@ "scr_uav_tower_cost", 200);
  level.var_db9587440497015c = getdvarint(@ "scr_uav_tower_sound", 1);
  level.var_9f740c9281d0c7f4 = getdvarint(@ "hash_5569456c0eff0d5b", 1);
  level.var_21da00da533a4de5 = getdvarint(@ "hash_2d4b53ed39fc8215", 1);
  level.var_6bacc8cb646fa5cd = getdvarint(@ "hash_21c230525b7cf2be", 1);
  level.var_4414dbbf9d80d75d = [];
  level.var_38c78bab762bfff6 = [];
  level.activetowers = [];
  level.uavtowers = [];
}

function function_73dfb744cf41525() {
  level.map_room = getentitylessscriptablearray("summon_maproom_POI", "target");

  foreach(scriptable in level.map_room) {
    scriptable setscriptablepartstate("body", "visible");
  }
}

function function_2b83c497da6348e2() {}

function function_3cfa9c416247ce77() {
  wait 15;
  utility::flag_wait("aether_storm_initialized");
  storm_center = level.aether_storm.starting_origin;
  level.var_3ab903842a23db62 = [];
  var_c535998c042bb958 = utility::getStructArray("refractor_set", "script_noteworthy");
  var_6023bfcad6738d22 = undefined;
  var_8724f4ea8ed146da = undefined;

  foreach(struct in var_c535998c042bb958) {
    var_cc0ba6c7a3be6a74 = distance2dsquared(struct.origin, level.aether_storm.starting_origin);

    if(!isDefined(var_6023bfcad6738d22)) {
      var_6023bfcad6738d22 = var_cc0ba6c7a3be6a74;
      var_8724f4ea8ed146da = struct;
    }

    if(var_cc0ba6c7a3be6a74 < var_6023bfcad6738d22) {
      var_6023bfcad6738d22 = var_cc0ba6c7a3be6a74;
      var_8724f4ea8ed146da = struct;
    }
  }

  level.var_d9fe0f9ad95b793b = var_8724f4ea8ed146da;
  level.var_671dd24102fe610a = [];
  linked_structs = getStructArray(level.var_d9fe0f9ad95b793b.targetname, "target");
  var_89e3d0ed94b39a38 = [];
  var_6daa4a86fe79883b = [];

  foreach(struct in linked_structs) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }

    if(struct.script_noteworthy == "refractor") {
      var_89e3d0ed94b39a38 = array_add(var_89e3d0ed94b39a38, struct);
      continue;
    }

    if(struct.script_noteworthy == "ammo_crate") {
      var_6daa4a86fe79883b = array_add(var_6daa4a86fe79883b, struct);
    }
  }

  foreach(struct in var_6daa4a86fe79883b) {
    ammo_crate = spawnscriptable("military_ammo_restock_noent", struct.origin, struct.angles);
  }

  scriptable_array = ["ob_seismic_refractor_summon_a", "ob_seismic_refractor_summon_b", "ob_seismic_refractor_summon_c", "ob_seismic_refractor_summon_d"];
  key_array = ["obloot_key_summon_a", "obloot_key_summon_b", "obloot_key_summon_c", "obloot_key_summon_d"];
  var_671b4c56d9271130 = [ &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_A_NO_KEYCARD", &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_B_NO_KEYCARD", &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_C_NO_KEYCARD", &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_D_NO_KEYCARD"];
  var_136714198bebc58f = [ &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_A_NOT_ACTIVE", &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_B_NOT_ACTIVE", &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_C_NOT_ACTIVE", &"JUP_OB_OBJECTIVES/SUMMON_REFRACTOR_D_NOT_ACTIVE"];

  foreach(idx, struct in var_89e3d0ed94b39a38) {
    refractor = ob_seismic_refractor::spawn_refractor(struct, scriptable_array[idx]);
    refractor ob_seismic_refractor::function_cf139bdff2bdcaad(&function_61f59a9cc42c932);
    refractor.key_name = key_array[idx];
    refractor.var_8c2f2d93ef1b5a63 = var_671b4c56d9271130[idx];
    refractor.var_3953a8a349006b46 = var_136714198bebc58f[idx];
    level.var_671dd24102fe610a = array_add(level.var_671dd24102fe610a, refractor);
  }

  level thread function_6f93a363ddce9d45();
  thread function_303658e9b41d2015(level.var_d9fe0f9ad95b793b, 2000);
}

function function_6f93a363ddce9d45() {
  foreach(refractor in level.var_671dd24102fe610a) {
    up_offset = anglestoup(refractor.angles) * 30;
    forward_offset = anglestoleft(refractor.angles) * 20;
    interact = register_interact(refractor.origin + up_offset + forward_offset, 70, &function_16aecf732fc7c90e);
    interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_8a0d4a3244c98aac);
    refractor.activated = 0;
    interact.refractor = refractor;
    refractor.interact = interact;
    thread function_b2edd98d65c371a2(refractor);
    thread delete_interact(interact);
  }
}

function delete_interact(interact) {
  while(true) {
    if(interact.refractor.activated == 1) {
      interact delete();
      return;
    }

    waitframe();
  }
}

function function_16aecf732fc7c90e(player) {
  if(namespace_6776e8e74ed64842::expansion_started() == 1 && self.refractor.isinside == 1) {
    itemid = loot::getlootidfromref(self.refractor.key_name);
    backpackindex = player scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(itemid);

    if(backpackindex == -1) {
      iprintlnbold("<dev string:xdd>" + self.refractor.key_name + "<dev string:xec>");

      return;
    }
  }

  iprintlnbold("<dev string:xfa>");
}

function function_61f59a9cc42c932(player) {
  itemid = loot::getlootidfromref(self.key_name);
  backpackindex = player scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(itemid);

  if(backpackindex == -1) {
    iprintlnbold("<dev string:xdd>" + self.key_name + "<dev string:xec>");

    return;
  } else {
    player scripts\cp_mp\loot\common_inventory::function_181a584e4a68d5d6(itemid);
    level.var_ef7d03b5335531d2++;

    iprintlnbold("<dev string:x108>");

    self setscriptablepartstate("effects", "Initial", 0);
    self.activated = 1;

    if(istrue(self.activated)) {
      level.var_3ab903842a23db62 = function_6d6af8144a5131f1(level.var_3ab903842a23db62, self);
    }

    spawn_encounter(player);
    return;
  }

  iprintlnbold("<dev string:xfa>");
}

function function_8a0d4a3244c98aac(interact, player) {
  interact.refractor.isinside = level.aether_storm.radiation radiation::function_1b4f63fa623de69a(interact.refractor.origin);

  if(namespace_6776e8e74ed64842::expansion_started() == 1 && interact.refractor.isinside == 1) {
    itemid = loot::getlootidfromref(interact.refractor.key_name);
    backpackindex = player scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(itemid);

    if(backpackindex == -1) {
      return {
        #string: interact.refractor.var_8c2f2d93ef1b5a63, #type: "HINT_NOBUTTON"};
    } else {
      if(interact.refractor ent_flag("aether_storm_engulfed")) {
        interact.refractor.var_b7792a6a967c1b9d = player;
        interact.refractor.var_b7792a6a967c1b9d ent_flag_set(interact.refractor.key_name);
        thread function_cc65145199d2c7d9(interact);
        return {
          #string: &"", #type: "HINT_NOBUTTON"};
      }

      return {
        #string: &"", #type: "HINT_NOBUTTON"};
    }
  }

  return {
    #string: interact.refractor.var_3953a8a349006b46, #type: "HINT_NOBUTTON"};
}

function function_cc65145199d2c7d9(interact) {
  interact.refractor setscriptablepartstate("model", "usable", 0);

  foreach(player in level.players) {
    interact.refractor disablescriptableplayeruse(player);

    if(player ent_flag(interact.refractor.key_name)) {
      interact.refractor enablescriptableplayeruse(player);
      interact disableplayeruse(player);
    }
  }

  while(interact.refractor.activated == 0) {
    foreach(player in level.players) {
      if(isDefined(interact)) {
        itemid = loot::getlootidfromref(interact.refractor.key_name);
        backpackindex = player scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(itemid);

        if(backpackindex == -1) {
          if(isalive(player) && player ent_flag(interact.refractor.key_name)) {
            interact enableplayeruse(player);
            interact.refractor disablescriptableplayeruse(player);
            player ent_flag_clear(interact.refractor.key_name);
            continue;
          }

          if(!isalive(player) && player ent_flag(interact.refractor.key_name)) {
            interact enableplayeruse(player);
            interact.refractor disablescriptableplayeruse(player);
            player ent_flag_clear(interact.refractor.key_name);
          }
        }
      }
    }

    waitframe();
  }
}

function function_b2edd98d65c371a2(refractor) {
  while(true) {
    refractor.isinside = level.aether_storm.radiation radiation::function_1b4f63fa623de69a(refractor.origin);

    if(namespace_6776e8e74ed64842::expansion_started() == 1 && refractor.isinside == 1) {
      refractor setscriptablepartstate("model", "unusable_screen_on", 0);
      refractor ent_flag_set("aether_storm_engulfed");
      return;
    }

    waitframe();
  }
}

function function_7c6cf66e28b4e511() {
  foreach(refractor in level.var_671dd24102fe610a) {
    refractor setscriptablepartstate("effects", "off", 0);
    refractor setscriptablepartstate("model", "stop", 0);
  }
}

function function_4ee7f07a73a880b8() {}

function spawn_zombies() {
  level endon("end_zombie_spawn");
  zombie_spawn_loc = level.var_d9fe0f9ad95b793b.origin;

  while(true) {
    iprintlnbold("<dev string:x124>");

    scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:ob_jup_summon_zombies", zombie_spawn_loc, 550, 1, 1, 0);
    wait 5;
  }
}

function private spawn_deathworm(squad) {
  if(isalive(level.death_worm)) {
    return;
  }

  zombie_spawn_loc = level.var_d9fe0f9ad95b793b.origin;
  earthquake(0.5, 2, level.var_d9fe0f9ad95b793b.origin, 2000);
  level.death_worm = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_deathworm_boss", zombie_spawn_loc, undefined, "team_two_hundred");
  level.death_worm namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
  level.death_worm.summon_squad = squad;
  level.death_worm callback::add("spawned_from_deathworm", &function_77b1ba349c93c2b4);
  level.death_worm callback::add("on_zombie_ai_killed", &function_7d81180cfc146b9a);
  musicplayers = getplayersinradius(level.var_d9fe0f9ad95b793b.origin, 5000);

  foreach(player in musicplayers) {
    player ob_music::function_2431d3e1b4e70519();
    player.var_488872571019cd6c = 1;
    player setplayermusicstate("mx_jup_ob_worldboss_2");
  }

  wait 0.7;
  var_71c8d12883582237 = getaiarrayinradius(zombie_spawn_loc, 500);

  foreach(zombie in var_71c8d12883582237) {
    if(isalive(zombie) && zombie != level.death_worm && zombie.team == level.death_worm.team) {
      v_dir = vectorNormalize(level.death_worm.origin - zombie.origin);
      n_boost = 13000;
      zombie kill();
      corpse = zombie getcorpseentity();
      corpse startragdollfromimpact("torso_upper", v_dir * n_boost + (0, 0, 80000));
    }
  }

  waitframe();
  var_ec7cfbf62a751362 = getaiarrayinradius(zombie_spawn_loc, 1000);

  foreach(zombie in var_ec7cfbf62a751362) {
    if(isalive(zombie) && zombie != level.death_worm && zombie.team == level.death_worm.team) {
      zombie kill(zombie_spawn_loc, level.death_worm, level.death_worm, "MOD_PROJECTILE_SPLASH");
    }

    waitframe();
  }

  wait 1;

  if(level.aether_storm.announcement_handler == 0) {
    thread scripts\cp_mp\overlord::playevent("activity_summon_jan_worm_spawn", squad);
    return;
  }

  thread scripts\cp_mp\overlord::playevent("activity_summon_bare_worm_spawn", squad);
}

function private function_77b1ba349c93c2b4(params) {
  if(isDefined(params.ai)) {
    params.ai namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
  }
}

function private function_7d81180cfc146b9a(params) {
  a_players = level.death_worm.var_21a8839dd03e31cd;

  if(isDefined(level.death_worm.var_ef8c3662cc722e80)) {
    foreach(damage_struct in level.death_worm.var_ef8c3662cc722e80) {}
  }

  level thread function_8fcaa5c0d74f44c7(a_players);
}

function private function_8fcaa5c0d74f44c7(a_players) {
  level endon("game_ended");
  wait 8;

  foreach(player in level.players) {
    if(istrue(player.var_488872571019cd6c)) {
      player.var_488872571019cd6c = 0;
      player ob_music::function_78c9f1435281a248();
      player setplayermusicstate("mx_jup_ob_worldboss_2_success");
    }
  }

  var_6ae956fe060702cb = getaiarrayinradius(level.var_d9fe0f9ad95b793b.origin, 5000);

  foreach(zombie in var_6ae956fe060702cb) {
    if(isalive(zombie) && zombie != level.death_worm) {
      zombie kill();
    }

    waitframe();
  }

  wait 4;
  spawn_reward(a_players);

  if(level.aether_storm.announcement_handler == 0) {
    thread scripts\cp_mp\overlord::playconversation("activity_summon_death_to_worm_ravjan_conv", a_players);
  } else {
    thread scripts\cp_mp\overlord::playconversation("activity_summon_death_to_worm_ravbare_conv", a_players);
  }

  foreach(player in a_players) {
    if(isalive(player)) {
      player thread hud_message::showsplash("jup_ob_activity_summon_complete", undefined, undefined, undefined, 1, "splash_list_jup_ob");
    }
  }

  wait 3;
  function_6d1c4d6325f44bd8();
}

function private spawn_encounter(player) {
  squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(level.var_ef7d03b5335531d2 == 1) {
    if(level.aether_storm.announcement_handler == 0) {
      thread scripts\cp_mp\overlord::playevent("activity_summon_jan_first_refractor_active", squad);
    } else {
      thread scripts\cp_mp\overlord::playevent("activity_summon_bare_first_refractor_active", squad);
    }
  }

  if(is_equal(level.var_3ab903842a23db62.size, level.var_671dd24102fe610a.size)) {
    if(flag("activated_all_refractors")) {
      return;
    }

    level flag_set("activated_all_refractors");

    if(level.aether_storm.announcement_handler == 0) {
      thread scripts\cp_mp\overlord::playevent("activity_summon_jan_fourth_refractor_active", squad);
    } else {
      thread scripts\cp_mp\overlord::playevent("activity_summon_bare_fourth_refractor_active", squad);
    }

    wait 2;
    level.var_671dd24102fe610a[0] setscriptablepartstate("alarm_sfx", "alarm1");

    foreach(refractor in level.var_671dd24102fe610a) {
      refractor setscriptablepartstate("flipbook", "warning", 0);
    }

    function_606642b946a01237("summon_ambient_blocker", level.var_d9fe0f9ad95b793b.origin, 4500, 0);
    thread spawn_zombies();

    for(i = 1; i < 50; i++) {
      iprintlnbold(i);

      if(i == 5) {
        thread scripts\cp_mp\overlord::playevent("activity_summon_rav_zombie_wave_start", squad);
      }

      if(i == 22) {
        level.var_671dd24102fe610a[0] setscriptablepartstate("alarm_sfx", "alarm2");
      }

      if(i == 23) {
        if(level.aether_storm.announcement_handler == 0) {
          thread scripts\cp_mp\overlord::playevent("activity_summon_jan_one_third_wave", squad);
        } else {
          thread scripts\cp_mp\overlord::playevent("activity_summon_bare_one_third_wave", squad);
        }
      }

      if(i == 40) {
        level.var_671dd24102fe610a[0] setscriptablepartstate("alarm_sfx", "alarm3");
      }

      if(i == 49) {
        if(level.aether_storm.announcement_handler == 0) {
          thread scripts\cp_mp\overlord::playevent("activity_summon_jan_two_third_wave", squad);
        } else {
          thread scripts\cp_mp\overlord::playevent("activity_summon_bare_two_third_wave", squad);
        }
      }

      wait 1;
    }

    level notify("end_zombie_spawn");
    attractor = namespace_5381a59d140f4df8::add_attractor(level.var_d9fe0f9ad95b793b, 1, 2000, 0, undefined);

    for(i = 1; i < 9; i++) {
      if(i == 1) {
        players = getplayersinradius(level.var_d9fe0f9ad95b793b.origin, 3000);

        foreach(player in players) {
          player playrumblelooponentity("grenade_rumble");
          player earthquakeforplayer(0.2, 3, player.origin, 500);
        }
      }

      if(i == 2) {
        level.var_671dd24102fe610a[0] setscriptablepartstate("alarm_sfx", "alarm3");
      }

      if(i == 4) {
        playsoundatpos(level.var_d9fe0f9ad95b793b.origin + (0, 0, 100), "evt_ob_summon_warning_roar");
        players = getplayersinradius(level.var_d9fe0f9ad95b793b.origin, 3000);

        foreach(player in players) {
          player earthquakeforplayer(0.25, 6, player.origin, 500);
        }
      }

      if(i == 5) {
        scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:ob_jup_summon_zombies", level.var_d9fe0f9ad95b793b.origin, 300, 1, 1, 0);
      }

      if(i == 7) {
        playsoundatpos(level.var_d9fe0f9ad95b793b.origin + (0, 0, 100), "evt_ob_summon_warning_roar");
        players = getplayersinradius(level.var_d9fe0f9ad95b793b.origin, 3000);

        foreach(player in players) {
          player playrumblelooponentity("grenade_rumble");
          player earthquakeforplayer(0.3, 4, player.origin, 500);
        }
      }

      if(i == 8) {
        wait 1;
        players = getplayersinradius(level.var_d9fe0f9ad95b793b.origin, 3000);

        foreach(player in players) {
          player stoprumble("grenade_rumble");
        }
      }

      iprintlnbold(i);

      wait 1;
    }

    function_7c6cf66e28b4e511();
    wait 1;
    spawn_deathworm(squad);
    namespace_5381a59d140f4df8::remove_attractor(attractor);
  }
}

function function_c06dcbc38dbb511b() {}

function function_510aa363d2583f0(params) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_items_activity_summon", 3);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function spawn_reward(a_players) {
  scripts\engine\utility::addstruct({
    #angles: level.var_d9fe0f9ad95b793b.angles, #origin: level.var_d9fe0f9ad95b793b.origin, #targetname: "rift_spawn"});
  level.rift_spawn = getStruct("rift_spawn", "targetname");

  if(!isarray(a_players)) {
    return;
  }

  if(a_players.size == 0) {
    return;
  }

  iprintlnbold("<dev string:x136>");

  reward_groups = [];

  foreach(player in a_players) {
    reward_groups[reward_groups.size] = [player];
  }

  namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, level.rift_spawn, &function_510aa363d2583f0);
}

function function_6d1c4d6325f44bd8() {
  scripts\engine\utility::addstruct({
    #angles: level.var_d9fe0f9ad95b793b.angles + (0, 90, 0), #origin: level.var_d9fe0f9ad95b793b.origin + (300, 0, -15), #targetname: "exit_gate"});
  var_734d269f7ba8502f = getStruct("exit_gate", "targetname");
  namespace_b000de497fab9bf4::function_c9eea6ea790d37bd();
  namespace_b000de497fab9bf4::function_a13799ae222a8b48("exit_gate");
  level.var_db80981879714f15 = &namespace_b000de497fab9bf4::function_348e0a3041479e64;
}

function function_631d8a81dbb35fbb() {}

function function_303658e9b41d2015(s_spot, n_radius) {
  if(!isDefined(n_radius)) {
    n_dist = squared(int(s_spot.radius * 0.9));
  } else {
    n_dist = squared(n_radius);
  }

  while(true) {
    players = getplayersinradius(level.var_d9fe0f9ad95b793b.origin, 2000);

    foreach(player in players) {
      squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

      if(distance2dsquared(s_spot.origin, player.origin) < n_dist) {
        if(namespace_6776e8e74ed64842::expansion_started() == 1) {
          if((player ent_flag("heard_console_data_nomap") || player ent_flag("heard_saw_map_tile_vo")) && !player ent_flag("heard_refractor_vo_storm_started") && player ent_flag("heard_rav_storm_start_alldata")) {
            if(level.aether_storm.announcement_handler == 0) {
              thread scripts\cp_mp\overlord::playevent("activity_summon_jan_refractor_on_sight_storm_active", squad);

              foreach(player in squad) {
                player ent_flag_set("heard_refractor_vo_storm_started");
              }
            } else {
              thread scripts\cp_mp\overlord::playevent("activity_summon_bare_refractor_on_sight_storm_active", squad);

              foreach(player in squad) {
                player ent_flag_set("heard_refractor_vo_storm_started");
              }
            }
          }

          continue;
        }

        if(namespace_6776e8e74ed64842::expansion_started() == 0) {
          if((player ent_flag("heard_console_data_nomap") || player ent_flag("heard_saw_map_tile_vo")) && !player ent_flag("heard_refractor_vo_storm_notstarted")) {
            thread scripts\cp_mp\overlord::playevent("activity_summon_bare_refractor_on_sight_storm_notactive", squad);

            foreach(player in squad) {
              player ent_flag_set("heard_refractor_vo_storm_notstarted");
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

function function_858202bc2560195b(player) {
  utility::flag_wait("aether_storm_expansion_started");
  wait 15;
  squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(player ent_flag("heard_console_finaldata") && !player ent_flag("heard_rav_storm_start_alldata")) {
    thread scripts\cp_mp\overlord::playevent("activity_summon_rav_all_four_refractor_collected_storm", squad);

    foreach(player in squad) {
      player ent_flag_set("heard_rav_storm_start_alldata");
    }
  }
}

function function_16b9f31835245160() {
  while(true) {
    foreach(map_piece in level.var_2293749bbb99f40c) {
      players = getplayersinradius(map_piece.origin, 2000);

      foreach(player in players) {
        if(isalive(player) && player ent_flag("heard_console_data_nomap") && !player ent_flag("heard_console_datafirst_mapsecond") && !player ent_flag("heard_console_finaldata")) {
          dist = distancesquared(player.origin, map_piece.origin);

          if(dist < squared(300) && scripts\engine\utility::within_fov(player.origin, player.angles, map_piece.origin, cos(70))) {
            eyepos = player getEye();

            if(sighttracepassed(eyepos, map_piece.origin, 1, player)) {
              if(utility::within_fov(player getEye(), player getplayerangles(), map_piece.origin, cos(35))) {
                squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
                thread scripts\cp_mp\overlord::playevent("activity_summon_mapdataalreadyfound_map", squad);

                foreach(player in squad) {
                  player ent_flag_set("heard_console_datafirst_mapsecond");
                }
              }
            }
          }

          continue;
        }

        if(isalive(player) && !player ent_flag("heard_console_data_nomap") && !player ent_flag("heard_saw_map_tile_vo") && !player ent_flag("heard_console_finaldata")) {
          dist = distancesquared(player.origin, map_piece.origin);

          if(dist < squared(300) && scripts\engine\utility::within_fov(player.origin, player.angles, map_piece.origin, cos(70))) {
            eyepos = player getEye();

            if(sighttracepassed(eyepos, map_piece.origin, 1, player)) {
              if(utility::within_fov(player getEye(), player getplayerangles(), map_piece.origin, cos(35))) {
                squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
                thread scripts\cp_mp\overlord::playconversation("activity_summon_nomap_conv", squad);

                foreach(player in squad) {
                  player ent_flag_set("heard_saw_map_tile_vo");
                }
              }
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

function console_audio(player) {
  squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(player ent_flag("heard_saw_map_tile_vo") && !player ent_flag("heard_console_firstdata_mapfound") && !player ent_flag("heard_console_data_nomap")) {
    thread scripts\cp_mp\overlord::playevent("activity_summon_firstdata_map", squad);

    foreach(player in squad) {
      player ent_flag_set("heard_console_firstdata_mapfound");
    }

    return;
  }

  if(!player ent_flag("heard_saw_map_tile_vo") && !player ent_flag("heard_console_data_nomap")) {
    thread scripts\cp_mp\overlord::playconversation("activity_summon_nomap_firstdata_conv", squad);

    foreach(player in squad) {
      player ent_flag_set("heard_console_data_nomap");
    }

    return;
  }

  if((player ent_flag("heard_console_data_nomap") || player ent_flag("heard_console_firstdata_mapfound")) && !player ent_flag("heard_console_seconddata")) {
    thread scripts\cp_mp\overlord::playevent("activity_summon_seconddata_map", squad);

    foreach(player in squad) {
      player ent_flag_set("heard_console_seconddata");
    }

    return;
  }

  if(player ent_flag("heard_console_seconddata") && !player ent_flag("heard_console_thirddata")) {
    thread scripts\cp_mp\overlord::playevent("activity_summon_thirddata_map", squad);

    foreach(player in squad) {
      player ent_flag_set("heard_console_thirddata");
    }

    return;
  }

  if(player ent_flag("heard_console_thirddata") && !player ent_flag("heard_console_finaldata")) {
    thread scripts\cp_mp\overlord::playconversation("activity_summon_map_forthdata_conv", squad);

    foreach(player in squad) {
      player ent_flag_set("heard_console_finaldata");
    }

    thread function_858202bc2560195b(player);
  }
}

function function_517338924707dea() {}

function function_6523b8640406fce4() {
  while(true) {
    if(getdvarint(@ "hash_ce3d0acd80bbd256", 0) == 1) {
      iprintlnbold("<dev string:x144>");
      function_b4afbe308b4c542a();
      setDvar(@ "hash_ce3d0acd80bbd256", 0);
    }

    waitframe();
  }
}

function function_b4afbe308b4c542a() {
  foreach(player in level.players) {
    var_afe22f1ecaf5fb72 = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_a");
    common_item::function_c465d27f3f6066b4(var_afe22f1ecaf5fb72, player.origin, player.angles, undefined, undefined, undefined, function_59a2e61d79065dca());
    var_afe22e1ecaf5f93f = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_b");
    common_item::function_c465d27f3f6066b4(var_afe22e1ecaf5f93f, player.origin, player.angles, undefined, undefined, undefined, function_59a2e61d79065dca());
    var_afe22d1ecaf5f70c = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_c");
    common_item::function_c465d27f3f6066b4(var_afe22d1ecaf5f70c, player.origin, player.angles, undefined, undefined, undefined, function_59a2e61d79065dca());
    var_afe22c1ecaf5f4d9 = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_summon_d");
    common_item::function_c465d27f3f6066b4(var_afe22c1ecaf5f4d9, player.origin, player.angles, undefined, undefined, undefined, function_59a2e61d79065dca());
    waitframe();
  }
}