/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_sumpf.csc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_bgb;
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
#using scripts\zm\_zm_trap_electric;
#using scripts\zm\_zm_weap_bouncingbetty;
#using scripts\zm\_zm_weap_cymbal_monkey;
#using scripts\zm\_zm_weap_tesla;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_sumpf_amb;
#using scripts\zm\zm_sumpf_ffotd;
#using scripts\zm\zm_sumpf_fx;
#namespace zm_sumpf;

function autoexec function_d9af860b() {
  level.bgb_in_use = 1;
  level.aat_in_use = 1;
}

function main() {
  level thread zm_sumpf_ffotd::main_start();
  level.default_game_mode = "zclassic";
  level.default_start_location = "default";
  level.use_water_risers = 1;
  zm_sumpf_fx::main();
  start_zombie_stuff();
  level thread zm_sumpf_amb::main();
  clientfield::register("world", "SUMPF_VISIONSET_DOGS", 21000, 1, "int", & function_166277c8, 0, 0);
  clientfield::register("actor", "zombie_flogger_trap", 21000, 1, "int", & function_f79e9b4f, 0, 0);
  clientfield::register("allplayers", "player_legs_hide", 21000, 1, "int", & player_legs_hide, 0, 0);
  load::main();
  util::waitforclient(0);
  _zm_weap_tesla::init();
  callback::on_localclient_connect( & function_794950d2);
  setdvar("player_shallowWaterWadeScale", 0.5);
  setdvar("player_waistWaterWadeScale", 0.5);
  level thread function_4e327cec();
  println("");
  level thread zm_sumpf_ffotd::main_end();
}

function function_794950d2(localclientnum) {
  setsaveddvar("phys_buoyancy", 1);
}

function player_legs_hide(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self hideviewlegs();
  } else {
    self showviewlegs();
  }
}

function function_166277c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    setworldfogactivebank(localclientnum, 2);
  } else {
    setworldfogactivebank(localclientnum, 1);
  }
}

function function_f79e9b4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    playfxontag(localclientnum, level._effect["trap_log"], self, "tag_origin");
  }
}

function start_zombie_stuff() {
  include_weapons();
  _zm_weap_cymbal_monkey::init();
}

function include_weapons() {
  zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_sumpf_weapons.csv", 1);
}

function function_4e327cec() {
  steptrigs = getentarray(0, "audio_step_trigger", "targetname");
  foreach(trig in steptrigs) {
    if(isdefined(trig.script_label) && trig.script_label == "fly_water_wade") {
      trig thread function_938d448f();
    }
  }
}

function function_938d448f() {
  while (true) {
    self waittill("trigger", who);
    if(who isplayer()) {
      if(!(isdefined(who.var_b115a3e6) && who.var_b115a3e6)) {
        who.var_b115a3e6 = 1;
        who thread function_387efde5(self);
      }
    }
    wait(0.1);
  }
}

function function_387efde5(trigger) {
  self endon("death");
  self endon("disconnect");
  while (self istouching(trigger)) {
    if(self getspeed() > 5) {
      playsound(0, "fly_water_wade_plr", (0, 0, 0));
    }
    wait(randomfloatrange(0.5, 1));
  }
  self.var_b115a3e6 = 0;
}