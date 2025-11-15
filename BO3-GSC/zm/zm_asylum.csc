/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_asylum.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_random;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;
#using scripts\zm\_zm_radio;
#using scripts\zm\_zm_trap_electric;
#using scripts\zm\_zm_weap_bouncingbetty;
#using scripts\zm\_zm_weap_cymbal_monkey;
#using scripts\zm\_zm_weap_tesla;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_asylum_ffotd;
#using scripts\zm\zm_asylum_fx;
#namespace zm_asylum;

function autoexec function_d9af860b() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
}

function main() {
  zm_asylum_ffotd::main_start();
  level.default_game_mode = "zclassic";
  level.default_start_location = "default";
  start_zombie_stuff();
  zm_asylum_fx::main();
  visionset_mgr::register_visionset_info("zm_showerhead", 21000, 31, undefined, "zm_bloodwash_red");
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_showerhead_postfx", 21000, 32, "pstfx_blood_wash", 3);
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_waterfall_postfx", 21000, 32, "pstfx_shower_wash", 3);
  level._uses_sticky_grenades = 1;
  init_clientfields();
  load::main();
  _zm_weap_cymbal_monkey::init();
  _zm_weap_tesla::init();
  util::waitforclient(0);
  level thread function_d87a7dcc();
  level thread function_c9207335();
  level thread function_d19cb2f8();
  println("");
  zm_asylum_ffotd::main_end();
}

function init_clientfields() {
  clientfield::register("world", "asylum_trap_fx_north", 21000, 1, "int", & zm_asylum_fx::function_93f91575, 0, 0);
  clientfield::register("world", "asylum_trap_fx_south", 21000, 1, "int", & zm_asylum_fx::function_4c17ba1b, 0, 0);
  clientfield::register("world", "asylum_generator_state", 21000, 1, "int", & function_d56a2c4b, 0, 0);
}

function start_zombie_stuff() {
  include_weapons();
  _zm_weap_cymbal_monkey::init();
}

function include_weapons() {
  zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_asylum_weapons.csv", 1);
}

function function_d87a7dcc() {
  var_bd7ba30 = 0;
  while(true) {
    if(!level clientfield::get("zombie_power_on")) {
      level.power_on = 0;
      if(var_bd7ba30) {
        level notify("power_controlled_light");
      }
      level util::waittill_any("power_on", "pwr", "ZPO");
    }
    level notify("power_controlled_light");
    level util::waittill_any("pwo", "ZPOff");
    var_bd7ba30 = 1;
  }
}

function function_d56a2c4b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    level.var_c4ea7bb2 = 1;
    level thread play_random_generator_sparks();
  } else if(isDefined(level.var_c4ea7bb2) && level.var_c4ea7bb2) {
    level.var_c4ea7bb2 = 0;
  }
}

function play_random_generator_sparks() {
  while(level.var_c4ea7bb2) {
    wait(randomfloatrange(0.45, 0.85));
    playSound(0, "amb_elec_arc_generator", (-672, -264, 296));
  }
}

function function_c9207335() {
  wait(3);
  level thread function_d667714e();
  var_13a52dfe = getEntArray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_13a52dfe, & function_60a32834);
}

function function_60a32834() {
  while(true) {
    self waittill("trigger", trigplayer);
    if(trigplayer islocalplayer()) {
      level notify("hash_51d7bc7c", self.script_sound);
      while(isDefined(trigplayer) && trigplayer istouching(self)) {
        wait(0.016);
      }
    } else {
      wait(0.016);
    }
  }
}

function function_d667714e() {
  level.var_b6342abd = "mus_asylum_underscore_default";
  level.var_6d9d81aa = "mus_asylum_underscore_default";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(level.var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_asylum_underscore_" + location;
    if(level.var_6d9d81aa != level.var_b6342abd) {
      level thread function_b234849(level.var_6d9d81aa);
      level.var_b6342abd = level.var_6d9d81aa;
    }
  }
}

function function_b234849(var_6d9d81aa) {
  level endon("hash_51d7bc7c");
  level.var_eb526c90 stopallloopsounds(2);
  wait(1);
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_6d9d81aa, 2);
}

function function_d19cb2f8() {
  loopers = struct::get_array("exterior_goal", "targetname");
  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;
    if(getdvarint("") > 0) {
      println(("" + loopers.size) + "");
    }
    for(i = 0; i < loopers.size; i++) {
      loopers[i] thread soundloopthink();
      delay = delay + 1;
      if((delay % 20) == 0) {
        wait(0.016);
      }
    }
  } else {
    println("");
    if(getdvarint("") > 0) {}
  }
}

function soundloopthink() {
  if(!isDefined(self.origin)) {
    return;
  }
  if(!isDefined(self.script_sound)) {
    self.script_sound = "zmb_spawn_walla";
  }
  notifyname = "";
  assert(isDefined(notifyname));
  if(isDefined(self.script_string)) {
    notifyname = self.script_string;
  }
  assert(isDefined(notifyname));
  started = 1;
  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }
  if(started) {
    soundloopemitter(self.script_sound, self.origin);
  }
  if(notifyname != "") {
    for(;;) {
      level waittill(notifyname);
      if(started) {
        soundstoploopemitter(self.script_sound, self.origin);
      } else {
        soundloopemitter(self.script_sound, self.origin);
      }
      started = !started;
    }
  }
}