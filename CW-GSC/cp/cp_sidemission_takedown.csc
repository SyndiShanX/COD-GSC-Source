/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_sidemission_takedown.csc
***********************************************/

#using script_38867f943fb86135;
#using script_46407e4cf62c1a9e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace cp_sidemission_takedown;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  init_clientfields();
  load::main();
  util::waitforclient(0);
}

function init_clientfields() {
  clientfield::register("toplayer", "lerp_fov", 1, 3, "int", &lerp_fov, 0, 0);
  clientfield::register("vehicle", "hit1_helispotlight", 1, 1, "int", &hit1_helispotlight, 0, 0);
  clientfield::register("vehicle", "hit1_track_vehicle", 1, 1, "int", &hit1_track_vehicle, 0, 0);
  clientfield::register("scriptmover", "hit1_track_ent", 1, 1, "int", &hit1_track_ent, 0, 0);
  clientfield::register("scriptmover", "hit1_tracking", 1, 1, "int", &hit1_tracking, 0, 0);
  clientfield::register("scriptmover", "hit1_light", 1, 1, "int", &hit1_light, 0, 0);
  clientfield::register("toplayer", "toggle_gameplayer_character_vis", 1, 1, "int", &function_9ff0fc62, 0, 0);
  clientfield::register("scriptmover", "heli_rpg_trail", 1, 1, "int", &heli_rpg_trail, 0, 0);
  clientfield::register("vehicle", "exfil_heli_exp", 1, 1, "int", &exfil_heli_exp, 0, 0);
  clientfield::register("toplayer", "force_stream_weapons", 1, 1, "int", &force_stream_weapons, 1, 1);
  clientfield::register("world", "stream_heli_woods", 1, 1, "int", &stream_heli_woods, 0, 0);
  clientfield::register("world", "stream_heli", 1, 1, "int", &stream_heli, 0, 0);
}

function heli_rpg_trail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_68f17c3 = util::playFXOnTag(fieldname, "maps/cp_takedown/fx9_td_rocket_trail_lrg", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_68f17c3)) {
    stopfx(fieldname, self.var_68f17c3);
  }
}

function exfil_heli_exp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_653683ec = [];
    playFX(fieldname, "explosions/fx9_vexp_mil_ru_heli_gunship_hind_death", self.origin);
    wait 0.1;
    self.var_653683ec[self.var_653683ec.size] = util::playFXOnTag(fieldname, "maps/cp_armada/fx9_heli_exp_02_crash_cine", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_653683ec) && self.var_653683ec.size) {
    foreach(fx in self.var_653683ec) {
      stopfx(fieldname, fx);
    }
  }
}

function function_9ff0fc62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump > 0) {
    util::function_8eb5d4b0(2000, 2);
    return;
  }

  util::function_21aef83c();
}

function hit1_track_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(level.var_9a3944f4)) {
    level.var_9a3944f4.var_ba240678 = self;
    level.var_cc43fb24 = undefined;

    if(isDefined(level.var_bda6b1e1)) {
      level.var_9a3944f4.var_ba240678.tracking = level.var_bda6b1e1;
      level.var_bda6b1e1 = undefined;
    }

    return;
  }

  level.var_cc43fb24 = self;
}

function hit1_tracking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(level.var_9a3944f4.var_ba240678)) {
    level.var_9a3944f4.var_ba240678.tracking = self;
    level.var_bda6b1e1 = undefined;
    return;
  }

  level.var_bda6b1e1 = self;
}

function hit1_track_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(level.var_9a3944f4.var_ba240678)) {
    level.var_9a3944f4.var_ba240678.tracking = self;
    level.var_bda6b1e1 = undefined;
    return;
  }

  level.var_bda6b1e1 = self;
}

function hit1_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(level.var_9a3944f4)) {
    level.var_9a3944f4.light = self;
    return;
  }

  level.var_c3ea2341 = self;
}

function hit1_helispotlight(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self endon(#"stop_spotlight");
  getplayers(fieldname)[0] endon(#"death", #"disconnect");

  if(isDefined(level.var_cc43fb24)) {
    level.var_9a3944f4.var_ba240678 = level.var_cc43fb24;
    level.var_cc43fb24 = undefined;

    if(isDefined(level.var_bda6b1e1)) {
      level.var_9a3944f4.var_ba240678.tracking = level.var_bda6b1e1;
      level.var_bda6b1e1 = undefined;
    }
  }

  var_61bc4e7 = 0;
  var_7dfc67b2 = "tag_searchlight_bracket";
  var_5d9bcd31 = "tag_searchlight_attach";
  tag_body = "tag_searchlight";
  tag_fx = "tag_searchlight_fx";

  if(bwastimejump) {
    self endon(#"stop_spotlight");
    level.var_9a3944f4 = self;

    while(true) {
      if(isDefined(self.var_ba240678.tracking)) {
        if(is_true(var_61bc4e7)) {
          sphere(self.var_ba240678.origin, 8, (1, 0, 0), 1, 0, 10, 1);
          sphere(self.var_ba240678.tracking.origin, 4, (0, 0, 1), 1, 0, 10, 1);
        }

        org = self gettagorigin(tag_body);
        ang = self gettagangles(var_7dfc67b2);
        var_ba943ae1 = self gettagangles(var_5d9bcd31);
        var_bca870f9 = angleclamp180(ang - var_ba943ae1);
        var_54c9ea3b = (0, var_bca870f9[1], 0);
        var_26ea01fb = vectortoangles(self.var_ba240678.origin - org);
        var_bca870f9 = angleclamp180(var_26ea01fb - var_ba943ae1);
        var_54c9ea3b = (0, var_bca870f9[1], 0);
        self function_2e566abb(var_7dfc67b2, (0, 0, 0), var_54c9ea3b);
        var_bca870f9 = angleclamp180(var_26ea01fb - ang);
        var_76d79dc0 = (var_bca870f9[0], 0, 0);
        self function_2e566abb(tag_body, (0, 0, 0), var_76d79dc0);

        fwd = anglesToForward(self gettagangles(tag_fx));
        fwd = vectornormalize(fwd);
        fwd *= 2512;
      }

      waitframe(1);
    }

    return;
  }

  self notify(#"stop_spotlight");
}

function lerp_fov(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      self function_9e574055(1);
      self easing::function_136edb11(undefined, 4, 1, #"linear");
      self function_d7be9a9f(25, 1);
      break;
    case 2:
      self function_9e574055(1);
      self easing::function_136edb11(undefined, 5.5, 1, #"linear", 1, 1);
      self function_d7be9a9f(25, 1);
      break;
    case 3:
      self function_9298adaf(2);
      self easing::function_136edb11(undefined, 5.6, 2, #"linear");
      self function_d7be9a9f(400, 2);
      wait 2;
      self function_9e574055(0);
      self function_3c54e2b8(1);
      self function_9ea7b4eb(1);
      break;
    case 4:
      self function_9e574055(1);
      self easing::function_136edb11(undefined, 3.5, 1, #"linear");
      self function_d7be9a9f(40, 0.5);
      break;
    case 5:
      self easing::function_136edb11(undefined, 3.5, 1, #"linear");
      self function_d7be9a9f(300, 1.5);
      break;
    case 6:
      self easing::function_136edb11(undefined, 0.8, 1, #"linear");
      self function_d7be9a9f(135, 1);
      break;
    case 7:
      self function_9e574055(0);
      self function_3c54e2b8(1);
      self function_9ea7b4eb(1);
      break;
    case 8:
      self function_9e574055(1);
      self easing::function_136edb11(undefined, 3.6, 1, #"linear");
      self function_d7be9a9f(20, 1);
      break;
  }
}

function force_stream_weapons(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  weapons = [];

  switch (bwasdemojump) {
    case 1:
      weapons[weapons.size] = getweapon(#"lmg_slowfire_t9", "reflex2");
      break;
    default:
      weapons[weapons.size] = getweapon(#"lmg_slowfire_t9", "reflex2");
      break;
  }

  self thread util::force_stream_weapons(fieldname, weapons);
}

function stream_heli_woods(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_usa_hero_woods_head1_bandana_flag");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_usa_hero_woods_head1_bandana_flag");
}

function stream_heli(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("veh_t9_mil_us_helicopter_large_cp_takedown");
    return;
  }

  stopforcestreamingxmodel("veh_t9_mil_us_helicopter_large_cp_takedown");
}