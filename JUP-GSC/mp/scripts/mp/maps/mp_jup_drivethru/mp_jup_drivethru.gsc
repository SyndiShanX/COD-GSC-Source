/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru.gsc
********************************************************************/

#using scripts\common\anim;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_drivethru\gen\mp_jup_drivethru_art;
#using scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru_fx;
#using scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_drivethru;

function main() {
  scripts\mp\maps\mp_jup_drivethru\gen\mp_jup_drivethru_art::main();
  scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru_fx::main();
  scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_drivethru");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  scripts\cp_mp\utility\game_utility::registersmallmap();
  level thread function_31dc060e85f4a689();
  level thread function_1682cf22619a5e55();
  level thread fun_machine();
  level thread function_98d7d107ecc37654();
  level.var_b6a3186c09d2dd34 = getEntArray("dcover_invalid", "targetname");
  precachemodel("jup_appliance_control_panel_graphic_button_green_01");
  precachemodel("jup_appliance_control_panel_graphic_button_01");
  precachemodel("jup_appliance_control_panel_graphic_button_01_off");
  precachemodel("jup_vfx_electronics_com_tv2_drivethru_01_static");
  precachemodel("jup_vfx_electronics_com_tv2_drivethru_01");
  precachemodel("jup_vfx_electronics_com_tv2_drivethru_02_static");
  precachemodel("jup_vfx_electronics_com_tv2_drivethru_02");
  level thread easter_egg();
  level thread function_cdefe9ef996be481();
}

function fun_machine() {
  level.fun_machine = getEnt("fun_machine", "targetname");
  level.speaker_loc = getEnt("speaker_sound_loc", "targetname");
  level.var_b499d9387eee3930 = getEntArray(level.fun_machine.target, "targetname");
  var_71d17ed53a544dbe = getEntArray("carousellights", "script_noteworthy");

  foreach(thing in level.var_b499d9387eee3930) {
    thing linkTo(level.fun_machine);
  }

  foreach(thing in var_71d17ed53a544dbe) {
    thing linkTo(level.fun_machine);
  }

  level.big_duck = getEnt("easter_egg_big_duck", "targetname");
  level.var_ec66cc51e59069d = getEntArray("easter_egg_active_up_lights", "targetname");

  if(isDefined(level.var_ec66cc51e59069d)) {
    foreach(light in level.var_ec66cc51e59069d) {
      light linkTo(level.big_duck, "tag_origin");
    }
  }

  if(isDefined(level.big_duck)) {
    level.big_duck linkTo(level.fun_machine);
    level.big_duck hide();
  }

  current_mode = getbasegametype();

  if(current_mode == "hq") {
    carousel_trigger = getEnt("Carousel", "script_noteworthy");
    hq_sites = getEntArray("hqloc", "targetname");

    foreach(site in hq_sites) {
      if(site istouching(carousel_trigger)) {
        collision_brushes = getEntArray(site.target, "targetname");
        site linkTo(level.fun_machine);

        foreach(col in collision_brushes) {
          col linkTo(level.fun_machine);
        }
      }
    }
  }

  scripts\cp_mp\utility\killstreak_utility::function_2c70bfb1b580e8e0(&function_40b13ec476b59230);
  wait 1;
  var_61a8e726ad4380da = 1;
  level.fun_machine thread function_d9f78a611c4686bb(var_61a8e726ad4380da);
  level.fun_machine thread function_bb96f5c1668f85a8(var_61a8e726ad4380da);
}

function function_40b13ec476b59230(movingplatforment) {
  if(!isDefined(movingplatforment)) {
    return 0;
  }

  if(level.fun_machine == movingplatforment) {
    return 1;
  }

  return utility::array_contains(level.var_b499d9387eee3930, movingplatforment);
}

function function_bb96f5c1668f85a8(state) {
  interact_pos = getStruct("fun_machine_button_interact", "targetname");
  button = getEnt("fun_machine_button", "targetname");
  button_socket = getStruct(button.target, "targetname");
  var_c48b2f68d8501bb2 = button.angles;
  var_4ee952c8b91aa5e7 = button_socket.angles;
  off_model = "jup_appliance_control_panel_graphic_button_01_off";
  var_898f403576ec49aa = "jup_appliance_control_panel_graphic_button_green_01";
  var_3aa9f27ae71e6c6a = "jup_appliance_control_panel_graphic_button_01";
  carousel_on_button = getEnt("carousel_on_button", "targetname");
  carousel_off_button = getEnt("carousel_off_button", "targetname");
  carousel_on_button setModel(var_898f403576ec49aa);
  carousel_off_button setModel(off_model);

  while(true) {
    off_hint = scripts\mp\gameobjects::createhintobject(interact_pos.origin, "HINT_BUTTON", undefined, &"MP_JUP_DRIVETHRU/CAROUSEL_OFF_HINT");
    off_hint waittill("trigger");
    off_hint delete();
    button thread button_mover(var_4ee952c8b91aa5e7);
    thread function_77c5bd936b9b3a50();
    carousel_on_button setModel(off_model);
    carousel_off_button setModel(var_3aa9f27ae71e6c6a);
    var_61a8e726ad4380da = 0;
    wait 5;
    on_hint = scripts\mp\gameobjects::createhintobject(interact_pos.origin, "HINT_BUTTON", undefined, &"MP_JUP_DRIVETHRU/CAROUSEL_ON_HINT");
    on_hint waittill("trigger");
    on_hint delete();
    button thread button_mover(var_c48b2f68d8501bb2);
    var_61a8e726ad4380da = 1;
    thread function_d9f78a611c4686bb(var_61a8e726ad4380da);
    carousel_on_button setModel(var_898f403576ec49aa);
    carousel_off_button setModel(off_model);
    wait 5;
  }
}

function function_d9f78a611c4686bb(state) {
  self endon("deactive");
  rotate_angle = 18;
  rotate_time = 1.75;
  level.var_86430c69d883dd69 = spawn_script_origin((86, 575, 799), (0, 0, 0));
  self playSound("carousel_motor_start");
  level.speaker_loc playSound("amb_mp_drivethru_carousel_music_speaker_start");
  playsoundatpos((86, 575, 799), "amb_emt_drivethru_rotating_sign_start");
  self rotateYaw(rotate_angle, rotate_time, 1.5, 0.25);
  wait 1.75;
  self playLoopSound("carousel_motor_loop");
  level.speaker_loc playLoopSound("amb_mp_drivethru_carousel_music_lp");

  if(isDefined(level.var_86430c69d883dd69)) {
    level.var_86430c69d883dd69 playLoopSound("amb_emt_drivethru_rotating_sign_lp");
  }

  while(true) {
    self rotateYaw(rotate_angle, rotate_time);
    self waittill("rotatedone");
  }
}

function function_77c5bd936b9b3a50() {
  wait 1.75;
  self stoploopsound("carousel_motor_loop");
  level.speaker_loc stoploopsound("amb_mp_drivethru_carousel_music_lp");

  if(isDefined(level.var_86430c69d883dd69)) {
    level.var_86430c69d883dd69 stoploopsound("amb_emt_drivethru_rotating_sign_lp");
    level.var_86430c69d883dd69 delete();
  }

  self playSound("carousel_motor_stop");
  level.speaker_loc playSound("amb_mp_drivethru_carousel_music_speaker_stop");
  playsoundatpos((86, 575, 799), "amb_emt_drivethru_rotating_sign_stop");
  self notify("deactive");
  self rotateYaw(-0.75, 1, 0, 0.75);
}

function button_mover(angle) {
  self playSound("carousel_toggle_switch");
  self rotateTo(angle, 0.25);
}

function function_1682cf22619a5e55() {
  level waittill("infil_setup_complete");
  var_6120df12544987e8 = getEnt("static_infil_van", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_6120df12544987e8)) {
    var_6120df12544987e8 hide();
  }
}

function function_98d7d107ecc37654() {
  sign_lights = getEntArray("sign_lights", "targetname");
  sign_face_lights = getEntArray("sign_face_lights", "targetname");

  foreach(light in sign_lights) {
    light thread scripts\common\lighting::function_70a9f70afd49dead(0.25, 0.25);
  }

  foreach(face_light in sign_face_lights) {
    face_light thread scripts\common\lighting::function_70a9f70afd49dead(0.25, 0.8);
  }

  while(true) {
    intensity = randomfloatrange(0.15, 0.2);
    var_4d3801966a2e47d1 = randomfloatrange(0.3, 0.35);
    time = randomfloatrange(4, 4.1);
    wait time;

    foreach(light in sign_lights) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0.1, intensity);
    }

    foreach(face_light in sign_face_lights) {
      face_light thread scripts\common\lighting::function_70a9f70afd49dead(0.1, var_4d3801966a2e47d1);
    }

    time = randomfloatrange(4, 4.1);
    wait time;

    foreach(light in sign_lights) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0.05, 0.25);
      playsoundatpos((-534, -287, 421), "amb_emt_funnys_sign_flicker");
    }

    foreach(face_light in sign_face_lights) {
      face_light thread scripts\common\lighting::function_70a9f70afd49dead(0.05, 0.8);
    }

    wait 0.25;

    foreach(light in sign_lights) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0.05, intensity);
    }

    foreach(face_light in sign_face_lights) {
      face_light thread scripts\common\lighting::function_70a9f70afd49dead(0.05, var_4d3801966a2e47d1);
    }

    wait 0.25;

    foreach(light in sign_lights) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0.025, 0.25);
    }

    foreach(face_light in sign_face_lights) {
      face_light thread scripts\common\lighting::function_70a9f70afd49dead(0.025, 0.8);
    }
  }
}

function function_cdefe9ef996be481() {
  var_23c4a8f2bad953e6 = "jup_vfx_electronics_com_tv2_drivethru_01";
  var_618a146d9b4a2777 = "jup_vfx_electronics_com_tv2_drivethru_01_static";
  var_5cd3f7504c46ffb = "jup_vfx_electronics_com_tv2_drivethru_02";
  var_44edae92f155630 = "jup_vfx_electronics_com_tv2_drivethru_02_static";
  pickup_room_tv = getEnt("pickup_room_tv", "targetname");
  break_room_tv = getEnt("break_room_tv", "targetname");
  waitframe();

  if(isDefined(pickup_room_tv)) {
    pickup_room_tv thread function_60f3ea12bac7b984(var_23c4a8f2bad953e6, var_618a146d9b4a2777);
  }

  if(isDefined(break_room_tv)) {
    break_room_tv thread function_60f3ea12bac7b984(var_5cd3f7504c46ffb, var_44edae92f155630);
  }
}

function function_60f3ea12bac7b984(clear, static) {
  self playLoopSound("amb_emt_cctv_monitor_static_lp");
  time = randomfloatrange(0.5, 3);
  wait time;

  while(true) {
    self setModel(clear);
    self playSound("amb_emt_cctv_monitor_static_burst");
    self stoploopsound("amb_emt_cctv_monitor_static_lp");
    time = randomfloatrange(0.5, 3);
    wait time;
    self setModel(static);
    self playLoopSound("amb_emt_cctv_monitor_static_lp");
    time = randomfloatrange(0.5, 3);
    wait time;
  }
}

function easter_egg() {
  flag_init("flag_easter_egg_trig_1");
  flag_init("flag_easter_egg_trig_2");
  flag_init("flag_easter_egg_trig_3");
  flag_init("flag_easter_egg_trig_4");
  waitframe();

  foreach(ent in level.var_b499d9387eee3930) {
    if(isDefined(ent.script_noteworthy)) {
      istrigger = ent.script_noteworthy == "easter_egg_trig_1" || ent.script_noteworthy == "easter_egg_trig_2" || ent.script_noteworthy == "easter_egg_trig_3" || ent.script_noteworthy == "easter_egg_trig_4";

      if(istrigger) {
        ent notsolid();
        ent thread trig_watcher();
      }
    }
  }

  fries = getEntArray("easter_egg_fries", "script_noteworthy");
  easter_egg_duck_loc = getStruct("easter_egg_duck_loc", "targetname");
  var_146cc960bad141d2 = getStructArray("eg_confetti_loc", "targetname");
  roof_confetti_loc = getStruct("eg_roof_confetti_loc", "targetname");
  flag_wait_all("flag_easter_egg_trig_1", "flag_easter_egg_trig_2", "flag_easter_egg_trig_3", "flag_easter_egg_trig_4");

  foreach(var_ed8a4f03e8cb0394 in fries) {
    var_ed8a4f03e8cb0394 hide();
  }

  if(isDefined(level.big_duck)) {
    level.big_duck show();
    playsoundatpos(level.big_duck.origin, "mp_jup_bait_big_duck_appear");

    if(isDefined(var_146cc960bad141d2)) {
      foreach(loc in var_146cc960bad141d2) {
        playFX(getfx("carousel_confetti"), loc.origin);
      }
    }

    if(isDefined(roof_confetti_loc)) {
      playFX(getfx("roof_confetti"), roof_confetti_loc.origin);
    }

    thread function_ab40957f314a872b();
  }

  level notify("easter_egg_triggered");
}

function trig_watcher() {
  level endon("easter_egg_triggered");

  while(true) {
    var_c22b3b81eaead8f = self getistouchingentities(level.players);

    if(!isDefined(var_c22b3b81eaead8f)) {
      iprintlnbold("flag_cleared");
      flag_clear("flag_" + self.script_noteworthy);
      return;
    }

    if(isarray(var_c22b3b81eaead8f)) {
      foreach(ent in var_c22b3b81eaead8f) {
        if(isPlayer(ent)) {
          flag_set("flag_" + self.script_noteworthy);
          function_e9e8d0b6a3b254af(self, ent);
        }
      }
    } else if(isPlayer(ent)) {
      flag_set("flag_" + self.script_noteworthy);
      function_e9e8d0b6a3b254af(self, ent);
    }

    flag_clear("flag_" + self.script_noteworthy);
    waitframe();
  }
}

function function_e9e8d0b6a3b254af(trig, player) {
  level endon("easter_egg_triggered");
  player endon("death");
  player endon("disconnect");

  while(player istouching(trig)) {
    waitframe();
  }
}

function function_ab40957f314a872b() {
  easter_egg_base_lights = getEntArray("easter_egg_base_lights", "targetname");
  easter_egg_up_lights = getEntArray("easter_egg_up_lights", "targetname");
  waitframe();

  if(isDefined(easter_egg_base_lights)) {
    foreach(light in easter_egg_base_lights) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0, 0);
    }
  }

  if(isDefined(easter_egg_up_lights)) {
    foreach(light in easter_egg_up_lights) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0, 0);
    }
  }

  if(isDefined(level.var_ec66cc51e59069d)) {
    foreach(light in level.var_ec66cc51e59069d) {
      light thread scripts\common\lighting::function_70a9f70afd49dead(0.25, 4.62);
    }
  }
}

function function_31dc060e85f4a689() {
  level.var_69ce64f9d9c5dfb9 = 1;
  spawns = [];

  switch (getbasegametype()) {
    case #"hash_1a5d186c17c00d3c":
      break;
    case #"hash_a1313b745c17c07e":
      break;
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      break;
    case #"hash_2fcf99fb5dbdcffb":
    case #"hash_3a17de6e294210d2":
    case #"hash_515260130b210bff":
    case #"hash_7485fa6c474ec865":
    case #"hash_973d1db8b6644466":
    case #"hash_b0eb18371d980895":
    case #"hash_b9458959b10637f8":
    case #"hash_c3668076a0827ce0":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ddd385f0a27d71bb":
    case #"hash_ea061d29bbd1f237":
    case #"hash_ec24570718a340f5":
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      break;
    case #"hash_c51506c10984515":
    case #"hash_21eed743fb721f4a":
    case #"hash_31104ebc01bd9ba9":
    case #"hash_3696c16c262a0862":
    case #"hash_77eb1179a728005e":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      break;
    case #"hash_f4a9126c03d3385b":
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}