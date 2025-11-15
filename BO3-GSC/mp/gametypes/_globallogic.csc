/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_hive_gun;
#using scripts\shared\weapons\_weaponobjects;
#namespace globallogic;

function autoexec __init__sytem__() {
  system::register("globallogic", & __init__, undefined, "visionset_mgr");
}

function __init__() {
  visionset_mgr::register_visionset_info("mpintro", 1, 31, undefined, "mpintro");
  clientfield::register("world", "game_ended", 1, 1, "int", & game_ended, 1, 1);
  clientfield::register("world", "post_game", 1, 1, "int", & post_game, 1, 1);
  registerclientfield("playercorpse", "firefly_effect", 1, 2, "int", & firefly_effect_cb, 0);
  registerclientfield("playercorpse", "annihilate_effect", 1, 1, "int", & annihilate_effect_cb, 0);
  registerclientfield("playercorpse", "pineapplegun_effect", 1, 1, "int", & pineapplegun_effect_cb, 0);
  registerclientfield("actor", "annihilate_effect", 1, 1, "int", & annihilate_effect_cb, 0);
  registerclientfield("actor", "pineapplegun_effect", 1, 1, "int", & pineapplegun_effect_cb, 0);
  level._effect["annihilate_explosion"] = "weapon/fx_hero_annhilatr_death_blood";
  level._effect["pineapplegun_explosion"] = "weapon/fx_hero_pineapple_death_blood";
  level.gameended = 0;
  level.postgame = 0;
}

function game_ended(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !level.gameended) {
    level notify("game_ended");
    level.gameended = 1;
  }
}

function post_game(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !level.postgame) {
    level notify("post_game");
    level.postgame = 1;
  }
}

function firefly_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bnewent && newval) {
    self thread hive_gun::gib_corpse(localclientnum, newval);
  }
}

function annihilate_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !oldval) {
    where = self gettagorigin("J_SpineLower");
    if(!isDefined(where)) {
      where = self.origin;
    }
    where = where + (vectorscale((0, 0, -1), 40));
    character_index = self getcharacterbodytype();
    fields = getcharacterfields(character_index, currentsessionmode());
    if(fields.fullbodyexplosion != "") {
      if(util::is_mature() && !util::is_gib_restricted_build()) {
        playFX(localclientnum, fields.fullbodyexplosion, where);
      }
      playFX(localclientnum, "explosions/fx_exp_grenade_default", where);
    }
  }
}

function pineapplegun_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !oldval) {
    where = self gettagorigin("J_SpineLower");
    if(!isDefined(where)) {
      where = self.origin;
    }
    if(isDefined(level._effect["pineapplegun_explosion"])) {
      playFX(localclientnum, level._effect["pineapplegun_explosion"], where);
    }
  }
}

function watch_plant_sound(localclientnum) {
  self endon("entityshutdown");
  while(true) {
    self waittill("start_plant_sound");
    self thread play_plant_sound(localclientnum);
  }
}

function play_plant_sound(localclientnum) {
  self notify("play_plant_sound");
  self endon("play_plant_sound");
  self endon("entityshutdown");
  self endon("stop_plant_sound");
  player = getlocalplayer(localclientnum);
  plantweapon = getweapon("briefcase_bomb");
  defuseweapon = getweapon("briefcase_bomb_defuse");
  wait(0.25);
  while(true) {
    if(!isDefined(player)) {
      return;
    }
    if(player.weapon != plantweapon && player.weapon != defuseweapon) {
      return;
    }
    if(player != self || isthirdperson(localclientnum)) {
      self playSound(localclientnum, "fly_bomb_buttons_npc");
    }
    wait(0.15);
  }
}

function function_9350c173() {
  util::waitforallclients();
  wait(5);
  var_57f81ff6 = getdvarint("sys_threadWatchdogTimeoutLive", 30000);
  setdvar("sys_threadWatchdogTimeout", var_57f81ff6);
}

function autoexec function_d00a98f6() {
  if(getdvarint("sys_threadWatchdogTimeoutLive", 0) > 0) {
    level thread function_9350c173();
  }
}